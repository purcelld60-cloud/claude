/* Optional "SHADER" graphics mode: a WebGL post-process over the finished game frame.
   Warm filmic grading, bloom, volumetric sun shafts, sky glow and a soft vignette.
   It only repaints pixels of the already-drawn frame: input, HUD, physics and saves are
   untouched. If WebGL is missing or fails, the frame is simply left as it was. */
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
float lum(vec3 c){return dot(c,vec3(.299,.587,.114));}
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
vec3 tap(vec2 o){return texture2D(img,uv+o/res).rgb;}
void main(){
  vec2 px=(floor(uv*res)+.5)/res;
  vec3 base=texture2D(img,px).rgb;
  // Bloom: bright neighbours bleed light softly around them.
  vec3 glow=vec3(0.);
  for(int i=0;i<12;i++){
    float a=float(i)*.5236;
    vec2 d=vec2(cos(a),sin(a));
    vec3 n1=tap(d*4.),n2=tap(d*11.);
    glow+=max(n1-.82,0.)*1.5+max(n2-.8,0.)*1.1;
  }
  glow/=12.;
  // Volumetric shafts: march toward the sun and gather bright sky.
  vec3 shaft=vec3(0.);
  if(rays>0.){
    vec2 dir=(sun-uv)/22.;
    vec2 s=uv;float decay=1.;
    for(int i=0;i<22;i++){
      s+=dir;
      vec3 c=texture2D(img,s).rgb;
      float b=max(lum(c)-.86,0.)*step(s.y,.5);
      shaft+=c*b*decay;
      decay*=.93;
    }
    shaft=min(shaft*rays*.5,vec3(.35));
  }
  vec3 col=base+glow*.45+shaft;
  if(rays>0.){
    // Animated god rays: angular bands fanning out of the sun, drifting slowly.
    vec2 q=(uv-sun)*vec2(res.x/res.y,1.);float ang=atan(q.y,q.x),dist=length(q);
    float bands=.55+.45*sin(ang*26.+t*.35)*sin(ang*11.-t*.22+1.3);
    float cone=smoothstep(1.25,.05,dist)*smoothstep(-.2,.6,q.y+.15);
    col+=vec3(1.,.9,.68)*bands*cone*.11*rays;
    // Dust motes glittering inside the light.
    vec2 cell=floor(uv*res/6.);float h=hash(cell+floor(t*.5));
    float mote=step(.996,h)*(.5+.5*sin(t*3.+h*40.))*cone;
    col+=vec3(1.,.95,.8)*mote*.6*rays;
  }
  // Sky glow around the sun.
  if(rays>0.){float d=distance(uv*vec2(res.x/res.y,1.),sun*vec2(res.x/res.y,1.));col+=vec3(1.,.82,.55)*exp(-d*5.)*.18*rays;}
  // Filmic grading: warm highlights, cool deep shadows, a little more colour and contrast.
  float l=lum(col);
  col=mix(col,col*vec3(1.08,1.0,.9),warm*smoothstep(.35,1.,l));
  col=mix(col,col*vec3(.86,.95,1.1),smoothstep(.45,.0,l)*.6);
  col=mix(vec3(lum(col)),col,1.1);
  col=(col-.5)*1.07+.5;
  col=col/(1.+max(col-1.,0.)*.6);
  // Soft vignette.
  vec2 v=uv-.5;col*=1.-dot(v,v)*.55;
  gl_FragColor=vec4(clamp(col,0.,1.),1.);
}`;

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
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR); gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE); gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
      for (const n of ['img', 'res', 'sun', 'rays', 'warm', 't']) loc[n] = gl.getUniformLocation(prog, n);
      return true;
    } catch (e) { broken = true; gl = null; return false; }
  }

  // s: {scene, camera, time, outdoor}
  function apply(canvas, s = {}) {
    if (broken || !canvas || !window.Graphics?.isShader?.()) return false;
    const w = canvas.width, h = canvas.height;
    if (!gl || glCanvas.width !== w || glCanvas.height !== h) { if (!init(w, h)) return false; }
    try {
      gl.viewport(0, 0, w, h);
      gl.bindTexture(gl.TEXTURE_2D, tex);
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, canvas);
      const scene = Number(s.scene), outdoor = !!s.outdoor;
      const sunX = s.sun ? s.sun[0] : ((scene === 3 ? 762 : 734) - (Number(s.camera) || 0) * .025) / 960, sunY = s.sun ? s.sun[1] : 99 / 540;
      gl.uniform1i(loc.img, 0); gl.uniform2f(loc.res, w, h); gl.uniform2f(loc.sun, sunX, sunY);
      gl.uniform1f(loc.rays, outdoor ? (scene === 3 ? 1.15 : scene === 5 ? .9 : 1) : 0);
      gl.uniform1f(loc.warm, scene === 5 ? .55 : scene === 6 ? .3 : .7);
      gl.uniform1f(loc.t, Number(s.time) || 0);
      gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
      const c = canvas.getContext('2d'); c.save(); c.setTransform(1, 0, 0, 1, 0, 0); c.globalAlpha = 1; c.globalCompositeOperation = 'copy'; c.drawImage(glCanvas, 0, 0); c.restore();
      return true;
    } catch (e) { broken = true; return false; }
  }
  window.Shader = Object.freeze({ apply, supported: () => { if (broken) return false; if (gl) return true; try { const t = document.createElement('canvas'); return !!t.getContext('webgl'); } catch (e) { return false; } } });
})();
