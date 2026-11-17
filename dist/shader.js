/* Qualidade ALTA: pós-processamento em WebGL sobre o quadro já desenhado.
   Mantém o pixel art nítido: a imagem é lida pixel a pixel (sem filtro) e os efeitos que
   deslocam a imagem (calor, reflexo) andam sempre em passos inteiros de pixel.
   Efeitos:
   - relevo de luz: normais estimadas a partir do brilho de cada pixel (um "normal map"
     calculado na hora), iluminadas pela direção do sol ou da lua da hora do dia;
   - brilho (bloom) nas luzes, raios de sol volumétricos e faixas de luz animadas;
   - névoa na linha do horizonte, reflexo e ondulação na água, distorção de calor;
   - profundidade de campo leve só no céu distante; correção de cor e vinheta.
   Só aparência: entrada, HUD, física e saves não mudam. Sem WebGL, o quadro fica como está. */
(() => {
  'use strict';
  let gl = null, glCanvas = null, prog = null, tex = null, loc = {}, broken = false;
  const VERT = 'attribute vec2 p;varying vec2 uv;void main(){uv=vec2(p.x*.5+.5,.5-p.y*.5);gl_Position=vec4(p,0.,1.);}';
  const FRAG = `
precision mediump float;
varying vec2 uv;
uniform sampler2D img;
uniform vec2 res;
uniform vec2 sun;
uniform float rays;
uniform float warm;
uniform float t;
uniform vec2 ldir;
uniform float relief;
uniform vec3 fogCol;
uniform float fogY;
uniform float fogAmt;
uniform vec3 water;
uniform float heat;
uniform float night;
uniform float wet;
uniform float dof;
float lum(vec3 c){return dot(c,vec3(.299,.587,.114));}
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
vec3 at(vec2 p){return texture2D(img,(floor(p)+.5)/res).rgb;}
vec3 tap(vec2 o){return texture2D(img,uv+o/res).rgb;}
void main(){
  vec2 pix=floor(uv*res);
  // calor: as linhas ondulam em passos inteiros de pixel
  if(heat>0.&&uv.y>.12&&uv.y<.82){float w=sin(pix.y*.35+t*7.)*sin(pix.y*.09-t*2.3);pix.x+=floor(w*heat+.5);}
  vec3 base=at(pix);
  // reflexo na água: espelha o que está acima da linha d'água, com ondas
  if(water.x>0.){float y0=water.y*res.y,y1=water.z*res.y;if(pix.y>y0&&pix.y<y1){float d=pix.y-y0;float wv=floor(sin(pix.y*.6+t*2.6)*1.5+sin(pix.x*.05+t)*.8+.5);vec3 r=at(vec2(pix.x+wv,y0-d*1.15-2.));float k=.34*(1.-d/(y1-y0));base=mix(base,r*vec3(.78,.9,1.02),k);}}
  // relevo de luz: normal estimada pelo brilho dos pixels vizinhos (2 px = 1 pixel de arte)
  if(relief>0.){float l0=lum(at(pix+vec2(-2.,0.))),l1=lum(at(pix+vec2(2.,0.))),l2=lum(at(pix+vec2(0.,-2.))),l3=lum(at(pix+vec2(0.,2.)));
    vec3 n=normalize(vec3((l0-l1)*2.2,(l2-l3)*2.2,1.));vec3 L=normalize(vec3(ldir.x,ldir.y,.9));float sh=dot(n,L)-L.z;
    base*=1.+relief*clamp(sh,-.6,.6);}
  // brilho: vizinhos claros espalham luz
  vec3 glow=vec3(0.);
  for(int i=0;i<12;i++){float a=float(i)*.5236;vec2 d=vec2(cos(a),sin(a));vec3 n1=tap(d*4.),n2=tap(d*11.);glow+=max(n1-.88,0.)*1.6+max(n2-.86,0.)*1.2;}
  glow/=12.;
  // raios volumétricos em direção ao sol (ou à lua)
  vec3 shaft=vec3(0.);
  if(rays>0.){vec2 dir=(sun-uv)/22.;vec2 s=uv;float decay=1.;for(int i=0;i<22;i++){s+=dir;vec3 c=texture2D(img,s).rgb;float b=max(lum(c)-.9,0.)*step(s.y,.55);shaft+=c*b*decay;decay*=.93;}shaft=min(shaft*rays*.5,vec3(.32));}
  vec3 col=base+glow*(.38+night*.4)+shaft;
  if(rays>0.){vec2 q=(uv-sun)*vec2(res.x/res.y,1.);float ang=atan(q.y,q.x),dist=length(q);
    float bands=.55+.45*sin(ang*26.+t*.35)*sin(ang*11.-t*.22+1.3);float cone=smoothstep(1.25,.05,dist)*smoothstep(-.2,.6,q.y+.15);
    col+=mix(vec3(1.,.9,.68),vec3(.7,.8,1.),night)*bands*cone*.1*rays;
    vec2 cell=floor(uv*res/6.);float h=hash(cell+floor(t*.5));col+=vec3(1.,.95,.8)*step(.996,h)*(.5+.5*sin(t*3.+h*40.))*cone*.6*rays;
    float d=distance(uv*vec2(res.x/res.y,1.),sun*vec2(res.x/res.y,1.));col+=mix(vec3(1.,.82,.55),vec3(.6,.7,1.),night)*exp(-d*5.)*.16*rays;}
  // névoa na faixa do horizonte
  if(fogAmt>0.){float f=smoothstep(fogY-.16,fogY,uv.y)*smoothstep(fogY+.12,fogY,uv.y);col=mix(col,fogCol,f*fogAmt);}
  // profundidade de campo leve: só o céu bem distante (topo) amacia um pouco
  if(dof>0.&&uv.y<.2){vec3 b=(at(pix+vec2(-2.,0.))+at(pix+vec2(2.,0.))+at(pix+vec2(0.,-2.))+at(pix+vec2(0.,2.)))*.25;col=mix(col,b+glow*.45,dof*smoothstep(.2,.02,uv.y));}
  // chuva: tudo mais frio e com mais contraste
  if(wet>0.){col=mix(col,col*vec3(.86,.93,1.04),wet);col=(col-.5)*(1.+wet*.08)+.5;}
  // correção de cor: luzes quentes, sombras frias (mais azuladas à noite)
  float l=lum(col);
  col=mix(col,col*vec3(1.08,1.,.9),warm*smoothstep(.35,1.,l));
  col=mix(col,col*vec3(.86,.95,1.1),smoothstep(.45,0.,l)*(.6+night*.3));
  col=mix(vec3(lum(col)),col,1.1);
  col=(col-.5)*1.07+.5;
  col=col/(1.+max(col-1.,0.)*.6);
  vec2 v=uv-.5;col*=1.-dot(v,v)*(.55+night*.25);
  gl_FragColor=vec4(clamp(col,0.,1.),1.);
}`;
  const NAMES = ['img', 'res', 'sun', 'rays', 'warm', 't', 'ldir', 'relief', 'fogCol', 'fogY', 'fogAmt', 'water', 'heat', 'night', 'wet', 'dof'];
  function init(w, h) {
    try {
      glCanvas = document.createElement('canvas'); glCanvas.width = w; glCanvas.height = h;
      gl = glCanvas.getContext('webgl', { premultipliedAlpha: false, preserveDrawingBuffer: true, antialias: false });
      if (!gl) throw Error('no webgl');
      const sh = (type, src) => { const s = gl.createShader(type); gl.shaderSource(s, src); gl.compileShader(s); if (!gl.getShaderParameter(s, gl.COMPILE_STATUS)) throw Error(gl.getShaderInfoLog(s)); return s; };
      prog = gl.createProgram(); gl.attachShader(prog, sh(gl.VERTEX_SHADER, VERT)); gl.attachShader(prog, sh(gl.FRAGMENT_SHADER, FRAG)); gl.linkProgram(prog);
      if (!gl.getProgramParameter(prog, gl.LINK_STATUS)) throw Error('link');
      gl.useProgram(prog);
      const buf = gl.createBuffer(); gl.bindBuffer(gl.ARRAY_BUFFER, buf); gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]), gl.STATIC_DRAW);
      const p = gl.getAttribLocation(prog, 'p'); gl.enableVertexAttribArray(p); gl.vertexAttribPointer(p, 2, gl.FLOAT, false, 0, 0);
      tex = gl.createTexture(); gl.bindTexture(gl.TEXTURE_2D, tex);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST); gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE); gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
      for (const n of NAMES) loc[n] = gl.getUniformLocation(prog, n);
      return true;
    } catch (e) { broken = true; gl = null; return false; }
  }

  // Sol e lua na tela, iguais aos que os mapas novos desenham (coordenadas 0..1).
  function sky(camera) {
    const s = window.DayTime?.state?.(); if (!s) return null;
    const camL = Math.floor((Number(camera) || 0) / 2);
    if (s.sunT !== null) return { s, x: (40 + s.sunT * 400 - camL * .012) / 480, y: (168 - Math.sin(s.sunT * Math.PI) * 128) / 270, moon: false, lean: (.5 - s.sunT) * 2, up: Math.sin(s.sunT * Math.PI) };
    if (s.moonT !== null) return { s, x: (50 + s.moonT * 380 - camL * .012) / 480, y: (150 - Math.sin(s.moonT * Math.PI) * 108) / 270, moon: true, lean: (.5 - s.moonT) * 2, up: Math.sin(s.moonT * Math.PI) };
    return { s, x: .5, y: -1, moon: true, lean: 0, up: 0 };
  }
  // Cenários com água (reflexo) e calor (meio-dia em lugares abertos e quentes).
  const WATER = { 4: [260 / 540, 350 / 540] };
  const HOT = { 3: 1, 5: 1, 7: .7 };

  // s: {scene, camera, time, outdoor, sun?, arena?}
  function apply(canvas, s = {}) {
    if (broken || !canvas || !window.Graphics?.isShader?.()) return false;
    const w = canvas.width, h = canvas.height;
    if (!gl || glCanvas.width !== w || glCanvas.height !== h) { if (!init(w, h)) return false; }
    try {
      gl.viewport(0, 0, w, h);
      gl.bindTexture(gl.TEXTURE_2D, tex);
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, canvas);
      const scene = Number(s.scene), outdoor = !!s.outdoor, t = Number(s.time) || 0, k = s.sun ? null : sky(s.camera);
      const night = k ? k.s.night : 0, wx = window.Weather?.state?.() || {};
      const sunX = s.sun ? s.sun[0] : k ? k.x : .76, sunY = s.sun ? s.sun[1] : k ? k.y : .18;
      let rays = outdoor ? (k && k.y < 0 ? 0 : k && k.moon ? .45 : scene === 3 ? 1.15 : 1) : 0; rays *= 1 - (wx.rain || 0) * .85 - (wx.snow || 0) * .5;
      gl.uniform1i(loc.img, 0); gl.uniform2f(loc.res, w, h); gl.uniform2f(loc.sun, sunX, sunY);
      gl.uniform1f(loc.rays, Math.max(0, rays));
      gl.uniform1f(loc.warm, (scene === 6 ? .3 : .7) * (1 - night * .6));
      gl.uniform1f(loc.t, t);
      // relevo: luz vem do lado do sol; à noite e em interiores fica mais fraca
      const lean = k ? k.lean : -.4;
      gl.uniform2f(loc.ldir, -lean * .9, -.55 - (k ? k.up : .5) * .35);
      gl.uniform1f(loc.relief, s.arena === 'menu' ? 0 : (outdoor ? .32 : .22) * (k && k.moon ? .55 : 1));
      const fog = k ? k.s.bot : [.8, .85, .9];
      gl.uniform3f(loc.fogCol, fog[0], fog[1], fog[2]); gl.uniform1f(loc.fogY, .56); gl.uniform1f(loc.fogAmt, outdoor ? .1 + (wx.rain || 0) * .2 + (wx.snow || 0) * .25 : 0);
      const wa = outdoor && WATER[scene]; gl.uniform3f(loc.water, wa ? 1 : 0, wa ? wa[0] : 0, wa ? wa[1] : 0);
      const midday = k && !k.moon ? Math.max(0, k.up - .55) * 2.2 : 0; gl.uniform1f(loc.heat, outdoor && HOT[scene] ? HOT[scene] * midday * (1 - (wx.rain || 0)) : 0);
      gl.uniform1f(loc.night, night); gl.uniform1f(loc.wet, wx.rain || 0); gl.uniform1f(loc.dof, outdoor ? .35 : 0);
      gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
      const c = canvas.getContext('2d'); c.save(); c.setTransform(1, 0, 0, 1, 0, 0); c.globalAlpha = 1; c.globalCompositeOperation = 'copy'; c.drawImage(glCanvas, 0, 0); c.restore();
      return true;
    } catch (e) { broken = true; return false; }
  }
  window.Shader = Object.freeze({ apply, supported: () => { if (broken) return false; if (gl) return true; try { const t = document.createElement('canvas'); return !!t.getContext('webgl'); } catch (e) { return false; } } });
})();
