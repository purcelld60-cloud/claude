/* Cinco formas de Jorge. Os dois motores consultam o mesmo piso e o mesmo corpo. */
(() => {
  'use strict';
  const clamp = (v,l,r) => Math.max(l,Math.min(r,v));
  const formas = ['jorge','jorge_gordo','jorge_farpas','jorge_aura','jorge_promessa'];
  const escolhas = [[0,2,4],[1,3,5],[0,3,5],[1,2,4]];
  const volta = 2.45;
  const meio = i => i.x+i.w/2;
  const sob = (i,x) => x>=i.x-4 && x<=i.x+i.w+4;
  function maisPerto(ilhas,x) {
    return ilhas.reduce((melhor,i) => i.estado!=='ausente' && (!melhor || Math.abs(meio(i)-x)<Math.abs(meio(melhor)-x)) ? i : melhor,null);
  }
  function mudar(f,fase,p) {
    const desceu = !!f.ceu;
    f.ceu = null; f.y=f.piso;
    if (fase!==4) {
      if (desceu && p) { p.y=f.piso; p.vy=0; p.ground=true; }
      return;
    }
    const passo=(f.r-f.l)/6;
    const ilhas=Array.from({length:6},(_,id)=>({id,x:f.l+id*passo+11,w:passo-22,
      y:f.piso,anterior:f.piso,estado:'inteira',resto:0}));
    f.ceu={tempo:0,rodada:0,ilhas};
    if(p) { const i=maisPerto(ilhas,p.x); p.x=clamp(p.x,i.x+9,i.x+i.w-9); p.y=i.y; p.vy=0; p.ground=true; }
  }
  function avancar(f,dt,p) {
    const ceu=f.ceu;
    ceu.tempo+=dt;
    const v=clamp(ceu.tempo/1.25,0,1), subida=v*v*(3-2*v);
    for(const i of ceu.ilhas) {
      const levando=p.ground && p.vy>=0 && i.estado!=='ausente' && sob(i,p.x) && Math.abs(p.y-i.y)<2;
      i.anterior=i.y;
      i.y=f.piso-subida*(74+25*Math.sin(ceu.tempo*1.12+i.id*.94));
      if(levando) p.y+=i.y-i.anterior;
      if(i.estado==='ausente') {
        i.resto=Math.max(0,i.resto-dt);
        if(i.resto===0) i.estado='inteira';
      }
    }
    // O clarão que rompe o piso acompanha o vitral até mesmo durante o aviso.
    for(const o of f.objetos) if(o.ilha!==undefined) o.y0=o.y1=ceu.ilhas[o.ilha].y-5;
  }
  function pousar(f,p,antes,ferir) {
    if(p.vy>=0) {
      for(const i of f.ceu.ilhas) {
        if(i.estado==='ausente' || !sob(i,p.x) || antes>Math.max(i.y,i.anterior)+2 || p.y<i.y) continue;
        p.y=i.y; p.vy=0; p.ground=true; return;
      }
    }
    if(p.y<=f.piso+40) return;
    const i=maisPerto(f.ceu.ilhas,p.x);
    ferir(9,p.x); p.x=meio(i); p.y=i.y; p.vy=0; p.vx=0; p.ground=true; p.inv=Math.max(p.inv||0,.95);
  }
  function marcar(f) {
    const ceu=f.ceu;
    const ids=escolhas[ceu.rodada++ % escolhas.length];
    const alvos=ids.map(id=>ceu.ilhas[id]);
    for(const i of alvos) i.estado='aviso';
    return alvos;
  }
  function romper(f,p) {
    for(const i of f.ceu.ilhas) if(i.estado==='aviso') {
      if(p?.ground && sob(i,p.x) && Math.abs(i.y-p.y)<3)p.ground=false;
      i.estado='ausente'; i.resto=volta;
    }
  }
  function flutuar(f,dt) {
    if(f.golpe==='rasante' && (f.estado==='firing'||f.estado==='windup')) return;
    const subida=clamp(f.ceu.tempo/1.18,0,1);
    const altura=146+19*Math.sin(f.ceu.tempo*1.7);
    f.y+=(f.piso-subida*altura-f.y)*Math.min(1,dt*5.2);
  }
  function corpo(f) {
    return f.fase===2 ? {rx:36,altura:103} : {rx:22,altura:f.fase===4?76:71};
  }
  function toca(f,x,y,rx,ry) {
    const c=corpo(f);
    return Math.abs(x-f.x)<c.rx+rx && y+ry>f.y-c.altura && y-ry<f.y;
  }
  const rect=(c,x,y,w,h,cor)=>{c.fillStyle=cor;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));};
  function pol(c,p,cor) {
    c.fillStyle=cor; c.beginPath(); c.moveTo(Math.round(p[0][0]),Math.round(p[0][1]));
    for(let i=1;i<p.length;i++) c.lineTo(Math.round(p[i][0]),Math.round(p[i][1]));
    c.closePath();c.fill();
  }
  function risco(c,p,cor,w=2) {
    c.strokeStyle=cor;c.lineWidth=w;c.lineJoin='bevel';c.beginPath();c.moveTo(Math.round(p[0][0]),Math.round(p[0][1]));
    for(let i=1;i<p.length;i++)c.lineTo(Math.round(p[i][0]),Math.round(p[i][1]));
    c.stroke();
  }
  // O fundo distante é pintado uma vez. Só as nuvens, as ilhas e a aura se movem por quadro.
  let paisagem;
  function horizonte() {
    if(paisagem)return paisagem;
    const img=document.createElement('canvas'); img.width=480;img.height=270;
    const c=img.getContext('2d'), grad=c.createLinearGradient(0,0,0,270);
    for(const [v,cor] of [[0,'#171c46'],[.30,'#393e79'],[.55,'#856794'],[.74,'#efac9c'],[.88,'#ffd39e'],[1,'#9295ad']]) grad.addColorStop(v,cor);
    c.fillStyle=grad;c.fillRect(0,0,480,270);
    for(let k=0;k<66;k++) {const x=(k*131+27)%480,y=(k*k*7+13*k+3)%81;rect(c,x,y,k%7?1:2,1,k%4?'#aca3bf':'#fce4c7');}
    for(const [y,w] of [[0,10],[2,18],[5,24],[9,28],[15,28],[20,24],[24,16],[27,8]]) rect(c,361-w/2,28+y,w,4,'#ffe7c1');
    rect(c,353,38,6,2,'#e9c7ad');rect(c,362,47,7,2,'#e9c7ad');
    for(let k=0;k<3;k++){
      const pontos=[];
      for(let x=0;x<=488;x+=8)pontos.push([x,37+k*7+14*Math.sin(x/87+k*.22)-.059*x]);
      pol(c,[...pontos,...pontos.slice().reverse().map(([x,y])=>[x,y+2+k])],['#414b80','#505888','#635c8b'][k]);
    }
    // A silhueta da Catedral de Conquista fica abaixo dos telhados e dá escala à subida.
    for(let layer=0;layer<2;layer++){
      const y=175+layer*23, pts=[[0,270]];
      for(let x=0;x<=486;x+=6)pts.push([x,y+Math.sin(x/46+layer)*11+Math.sin(x/19)*5]);
      pol(c,[...pts,[486,270]],layer?'#91829a':'#aa8c9e');
    }
    // Telhados em contraluz, janelas ainda acesas e a estrada que some no vale.
    pol(c,[[0,208],[80,194],[142,202],[214,186],[274,209],[315,193],[390,207],[480,189],[480,270],[0,270]],'#938497');
    for(let k=0;k<48;k++){const x=k*11, h=7+(k*13)%14;rect(c,x,211-h,9,h,'#81788c');pol(c,[[x-2,211-h],[x+4,207-h],[x+11,211-h]],'#79758e');}
    const sil='#696c87', vitral='#e4b196';
    for(const x of [137,168]){
      rect(c,x-5,163,11,37,sil);rect(c,x-7,160,15,3,sil);pol(c,[[x-6,160],[x,139],[x+6,160]],sil);
      rect(c,x,135,1,8,sil);rect(c,x-2,138,5,1,sil);rect(c,x-2,169,4,8,vitral);rect(c,x-1,167,2,2,vitral);
    }
    pol(c,[[137,195],[152,172],[168,195]],sil);rect(c,140,194,24,15,sil);rect(c,150,187,4,6,vitral);
    rect(c,0,211,480,4,'#877b90');
    for(let k=0;k<64;k++){
      const x=(k*71+11)%480, y=198+(k*23)%12;
      rect(c,x,y,2,1,k%3?'#b4a1a3':'#efd39e');
    }
    pol(c,[[0,217],[52,213],[89,221],[147,209],[208,222],[268,214],[334,221],[395,209],[479,218],[480,270],[0,270]],'#81798e');
    risco(c,[[0,233],[76,229],[129,235],[179,230],[242,235],[310,228],[369,230],[431,223],[480,226]],'#a695a1',2);
    for(let k=0;k<19;k++){
      const x=k*30-24, y=249+Math.round(Math.sin(k*2.4)*6);
      nuvem(c,x,y,1.2,k%3?'#aba1b4':'#a59aae','#c7b6bf');
    }
    paisagem=img;return img;
  }
  function nuvem(c,x,y,s,cor,luz) {
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);
    pol(c,[[0,8],[6,8],[6,5],[16,5],[16,0],[23,0],[23,-3],[35,-3],[35,1],[44,1],[44,5],[55,5],[55,8],[65,8],[65,12],[0,12]],cor);
    rect(c,17,0,7,2,luz);rect(c,24,-3,10,2,luz);rect(c,36,1,8,2,luz);c.restore();
  }
  function fundo(c,f) {
    const t=f.ceu.tempo;
    c.save();c.globalAlpha*=clamp(t/.85,0,1);c.imageSmoothingEnabled=false;
    c.drawImage(horizonte(),0,0,960,540);
    for(let k=0;k<15;k++){
      const faixa=Math.floor(k/5),x=((k*217-t*(4+faixa*5))%1160+1160)%1160-147;
      nuvem(c,x,202+faixa*112+Math.sin(k*3)*29,.94+faixa*.64, ['#b297ac','#d7a8ac','#847e9f'][faixa],['#d9b2b7','#f6c4af','#aca0b6'][faixa]);
    }
    for(let k=0;k<6;k++){
      const x=((k*217-t*10)%1240+1240)%1240-174, y=509+14*Math.sin(k*1.8);
      nuvem(c,x,y,2.4,'#ac9fb6','#d0b8bd');
    }
    c.restore();
  }
  function plataformas(c,f) {
    const t=f.ceu.tempo;
    for(const i of f.ceu.ilhas){
      const x=Math.round(i.x),w=Math.round(i.w),y=Math.round(i.y),m=x+w/2;
      if(i.estado==='ausente'){
        const queda=volta-i.resto;
        if(queda<.48)for(let n=0;n<5;n++){const dx=(n-2)*w/5,dy=queda*queda*390;pol(c,[[m+dx-7,y+dy+3],[m+dx+8,y+dy+6],[m+dx+1,y+dy+18+n]],n%2?'#a786b4':'#dcaf97');}
        if(i.resto<.64) {c.save();c.globalAlpha=.26+(1-i.resto/.64)*.46;for(let n=0;n<w;n+=12)rect(c,x+n,y,Math.min(7,w-n),3,'#bff9ff');c.restore();}
        continue;
      }
      const alerta=i.estado==='aviso';
      pol(c,[[x,y+4],[x+w,y+4],[x+w-9,y+16],[m+15,y+24],[m+7,y+33],[m-10,y+33],[m-17,y+23],[x+10,y+17]],'#323453');
      pol(c,[[x+8,y+8],[x+w-9,y+8],[x+w-19,y+15],[m,y+28],[x+17,y+15]],'#65557e');
      pol(c,[[m-14,y+13],[m,y+9],[m+14,y+13],[m,y+29]],alerta?'#ec7975':'#75cacd');
      pol(c,[[m-9,y+14],[m,y+12],[m,y+24]],alerta?'#ffc79b':'#baf9ed');
      for(const side of [-1,1]) {
        const g=m+side*w*.30;pol(c,[[g-7,y+12],[g,y+10],[g+7,y+12],[g,y+18]],'#b28eaf');
        rect(c,g-1,y+18,3,7,'#9e815d');rect(c,g-2,y+25,5,3,'#ebbd78');
      }
      rect(c,x,y,w,7,'#4c435c');rect(c,x,y,w,3,alerta?'#ffc783':'#ffdfae');
      rect(c,x+4,y+3,w-8,2,alerta?'#d06c65':'#b699aa');
      for(let n=1;n<4;n++)rect(c,x+n*w/4,y+3,2,4,'#6b596e');
      if(alerta) {
        risco(c,[[m-13,y+1],[m-6,y+6],[m-10,y+10],[m+1,y+16],[m-1,y+21],[m+7,y+26]],'#ffe8ae',3);
        for(const side of [-1,1]){const bx=m+side*w*.33,by=y-14+Math.sin(t*9)*2;risco(c,[[bx-6,by-4],[bx,by+1],[bx+6,by-4]],'#ffb68e',3);}
      }
    }
  }
  function aura(c,f) {
    const t=f.idade;
    for(let i=0;i<7;i++){
      const x=(i-3)*12, altura=51+42*(1-Math.abs(i-3)/4)+11*Math.sin(t*4+i*1.8), y=-15-Math.abs(i-3)*4;
      pol(c,[[x-10,y],[x-14,y-23],[x-8,y-18],[x-6,y-altura*.67],[x-2,y-altura*.62],[x+4,y-altura],[x+7,y-altura*.6],[x+10,y-29],[x+13,y-32],[x+10,y-4]],i%2?'#5178bd':'#5a62ae');
      pol(c,[[x-6,y],[x-8,y-20],[x-2,y-17],[x+3,y-altura*.76],[x+5,y-26],[x+9,y-29],[x+7,y-2]],i%2?'#9ce7e9':'#acbcff');
    }
    for(let i=0;i<6;i++){const q=(t*.75+i/6)%1, lado=i%2?1:-1;rect(c,lado*(28+q*19),-13-q*105,2,5+i%3,'#d7ffff');}
  }
  function personagem(c,f,o) {
    const tipo=formas[f.fase-1], dir=o.facing||1;
    c.save();c.translate(Math.round(f.x),Math.round(f.y));
    if(f.fase===4) aura(c,f);
    if(f.fase===2) {
      const preparo=f.estado==='windup'&&f.golpe==='saltoBarriga' ? clamp(f.tempo/f.dur,0,1) : 0;
      const voo=clamp((f.piso-f.y)/130,0,1);
      const pouso=f.golpe==='saltoBarriga'&&f.estado==='firing' ? Math.max(0,1-(f.piso-f.y)/18)*.07 : 0;
      c.scale(1.56+preparo*.13+pouso-voo*.09,1.48-preparo*.20-pouso+voo*.08);
    }
    if(f.fase===5){
      // Duas fitas de uma fotografia voltam a se tocar quando ele atende.
      for(const lado of [-1,1]) {const x=-dir*(17+lado*5);risco(c,[[x,-43],[x-dir*12,-39],[x-dir*21,-41+Math.sin(f.idade*3+lado)*3]],lado<0?'#bce1e3':'#ffd690',3);}
    }
    window.Art.drawCharacter(c,tipo,0,0,{...o,scale:f.fase===2?1:1.08,duelo:f.fase,grounded:!f.ceu&&f.y>=f.piso-2,frame:f.idade});
    c.restore();
  }
  window.JorgeDuelo=Object.freeze({formas,corpo,toca,mudar,avancar,pousar,marcar,romper,flutuar,fundo,plataformas,personagem});
})();
