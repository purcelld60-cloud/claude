/* Original night festival and Ollyan's three-stage flying-ear encounter.
 * No campaign state or storage is touched: the campaign owns entry and rewards. */
(() => {
 'use strict';
 const W=960,H=540,FLOOR=440,LENGTH=4800,NPC_X=3260,TAU=Math.PI*2;
 const clamp=(n,a,b)=>Math.max(a,Math.min(b,n)),mix=(a,b,t)=>a+(b-a)*t,smooth=t=>{t=clamp(t,0,1);return t*t*(3-2*t);};
 const finite=(n,f)=>Number.isFinite(Number(n))?Number(n):f;
 const palette={ink:'#171d32',night:'#111b39',pink:'#eb84b3',cyan:'#7ed6e4',gold:'#f1cf87',mint:'#a3e4ba'};
 const INTRO=Object.freeze([
  Object.freeze({id:'dance',start:0,duration:3,label:'O baile virou perseguição',speaker:'Ollyan',text:'Ô, chapéu… eu tô é tonto! Tu tá rindo da minha orelha, véi?'}),
  Object.freeze({id:'ears',start:3,duration:3,label:'Orelhas no teto',speaker:'Da Roça',text:'Oxe! O cara ligou o ventilador na cabeça e furou o teto do baile!'}),
  Object.freeze({id:'chase',start:6,duration:3,label:'O carro a gás decola pelo buraco',speaker:'Da Roça',text:'Bora, carro do meu pai! Sobe pelo buraco que a lua tá chamando!'})
 ]);
 const phases=Object.freeze([
  Object.freeze({name:'ORELHAS AO VENTO',attacks:['earFan','pulseRing','swoop'],windup:1.1,recover:.95,speed:1}),
  Object.freeze({name:'NUVENS SOB OS PÉS',attacks:['cloudGate','earFan','platformStorm','gustRing'],windup:.98,recover:.79,speed:1.13}),
  Object.freeze({name:'O REI DA CORRENTE DE AR',attacks:['moonBeam','crosswind','cometRain','earFan','swoop'],windup:.88,recover:.66,speed:1.24})
 ]);
 const SKY_PLATFORMS=Object.freeze([{id:'carro',x:55,y:416,w:245},{id:'meio',x:348,y:350,w:190},{id:'frente',x:600,y:396,w:205},{id:'alta',x:746,y:286,w:150}].map(p=>Object.freeze(p)));
 const attackNames={platformStorm:'NUVENS CARREGADAS! MUDE DE PLATAFORMA',earFan:'RAJADA DE ORELHA',pulseRing:'ONDA DE GRAVE',swoop:'MERGULHO! SAIA DA LINHA',cloudGate:'PROCURE O VÃO NAS NUVENS',cometRain:'CHUVA DE COMETAS',gustRing:'ESPIRAL DE VENTO',moonBeam:'LUAR CORTANTE! SAIA DA MIRA',crosswind:'VENTO CRUZADO! BUSQUE AS ABERTURAS'};
 let serial=0;
 function rect(c,x,y,w,h,color){c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
 function poly(c,points,color){c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(p[0],p[1]):c.moveTo(p[0],p[1]));c.closePath();c.fill();}
 function oval(c,x,y,rx,ry,color){c.fillStyle=color;c.beginPath();c.ellipse(Math.round(x),Math.round(y),rx,ry,0,0,TAU);c.fill();}
 function line(c,points,color,width=2){c.strokeStyle=color;c.lineWidth=width;c.beginPath();points.forEach((p,i)=>i?c.lineTo(p[0],p[1]):c.moveTo(p[0],p[1]));c.stroke();}
 function text(c,value,x,y,size=14,color='#f4e8bd',align='center'){c.save();c.font='bold '+size+'px monospace';c.textAlign=align;c.textBaseline='middle';c.fillStyle='#101a30';c.fillText(value,x+1,y+2);c.fillStyle=color;c.fillText(value,x,y);c.restore();}
 function glow(c,x,y,r,color,alpha=.2){c.save();c.globalAlpha*=alpha;const g=c.createRadialGradient(x,y,0,x,y,r);g.addColorStop(0,color);g.addColorStop(1,'#00000000');c.fillStyle=g;c.fillRect(x-r,y-r,r*2,r*2);c.restore();}
 function noise(n){return(Math.sin(n*12.9898+78.233)*43758.5453)%1;}
 function cloud(c,x,y,scale=1,color='#c1cfe2',alpha=1){c.save();c.translate(Math.round(x),Math.round(y));c.scale(scale,scale);c.globalAlpha*=alpha;for(const[k,yy,r]of[[-29,5,20],[-8,-5,25],[18,0,23],[39,10,17]]){oval(c,k,yy,r,r*.54,color);}rect(c,-38,9,88,10,color);c.restore();}
 function dancer(c,x,y,t,seed=0,scale=1){
  if(window.BailePixel?.dancer?.(c,x,y,t,seed,scale))return; // gente redesenhada em pixel art (baile-pixel.js)
  if(!window.Graphics?.isLite?.())return dancerHD(c,x,y,t,seed,scale);
  const sw=Math.sin(t*(2.3+seed%3*.17)+seed)*5,bounce=Math.max(0,Math.sin(t*4+seed))*3,skin=['#8d583f','#e4b596','#b47c55','#6f4838','#eec9ae'][seed%5],shirt=['#7a5f9c','#e49a78','#679fac','#c0b56b','#b46c88','#dde0c8'][seed%6],pants=['#29374c','#3c3a55','#26394a'][seed%3];
  c.save();c.translate(Math.round(x),Math.round(y));c.scale(scale,scale);oval(c,0,0,13,3,'#13192d50');
  line(c,[[-5,-17],[-8-sw*.3,-7],[-9-sw*.4,-2]],pants,6);line(c,[[5,-17],[8+sw*.3,-8],[9+sw*.5,-2]],pants,6);rect(c,-15-sw*.4,-4,11,4,'#cad1cd');rect(c,5+sw*.5,-4,11,4,'#c2cad0');
  c.translate(sw*.25,-bounce);rect(c,-10,-39,20,24,palette.ink);rect(c,-8,-37,16,21,shirt);line(c,[[-8,-34],[-15,-24+sw],[-20,-30+sw]],skin,5);line(c,[[8,-34],[15,-40-sw],[19,-48-sw]],skin,5);
  rect(c,-9,-53,18,17,palette.ink);rect(c,-7,-51,14,14,skin);rect(c,-8,-54,16,6,seed%4===0?'#54404a':'#232534');if(seed%3===0){rect(c,-10,-50,4,20,'#252333');rect(c,7,-49,4,20,'#252333');}rect(c,-4,-45,2,3,'#302c37');rect(c,3,-45,2,3,'#302c37');rect(c,-2,-39,5,2,'#8b514c');if(seed%7===0){rect(c,-9,-47,8,4,'#293b55');rect(c,1,-47,8,4,'#293b55');}c.restore();
 }

 const isLite=()=>!!window.Graphics?.isLite?.();
 const BPM=2.15; // beats per second of the baile
 // Redesigned dancer: taller proportions, varied hair/clothes, real dance moves and props.
 function dancerHD(c,x,y,t,seed=0,scale=1){
  const skin=['#8d583f','#e4b596','#b47c55','#6f4838','#eec9ae','#5c3a2c'][seed%6],skinSh=['#6d4231','#c4937a','#8f603f','#55362a','#cfa98e','#43291f'][seed%6];
  const top=['#e2445c','#2d9cdb','#f2c94c','#27ae60','#9b51e0','#f2f2f2','#1d1d1d','#ff7a45'][(seed*3)%8],bottom=['#29374c','#3c3a55','#1f2a36','#5a3a2a','#d6d0c4'][(seed*5)%5],hairC=['#1b1414','#3a2418','#6b3e22','#c9a050','#1b1414','#7a2a4a'][(seed*7)%6];
  const move=seed%5,beat=t*BPM*Math.PI*2+seed,b=Math.max(0,Math.sin(beat)),sw=Math.sin(beat*.5)*6;
  c.save();c.translate(Math.round(x),Math.round(y));c.scale(scale,scale);
  oval(c,0,0,14,3,'#0c101d70');
  const hop=move===2?b*6:b*2.5,lean=move===3?Math.sin(beat*.5)*.12:0;
  // legs: footwork for "passinho", bounce for others
  const fA=move===1?Math.sin(beat)*9:sw*.4,fB=move===1?-Math.sin(beat)*9:-sw*.4;
  line(c,[[-5,-24],[-7+fA*.4,-12],[-8+fA,-2]],bottom,7);line(c,[[5,-24],[7+fB*.4,-12],[8+fB,-2]],bottom,7);
  rect(c,-13+fA,-4,11,4,'#e9ecef');rect(c,4+fB,-4,11,4,seed%3?'#e9ecef':'#ff5a5a');
  c.translate(sw*.2,-hop);c.rotate(lean);
  // torso
  rect(c,-11,-48,22,26,'#151a28');rect(c,-9,-46,18,23,top);rect(c,3,-46,6,23,'#00000022');if(seed%4===0){rect(c,-9,-40,18,3,'#ffffff55');}if(seed%6===1)text(c,String(seed%90+10),0,-34,8,'#ffffff');
  // arms by move type
  let la,ra;
  if(move===0){la=[[-9,-44],[-18,-56+sw],[-14,-70+sw]];ra=[[9,-44],[18,-58-sw],[13,-72-sw]];}       // hands up
  else if(move===1){la=[[-9,-44],[-18,-34],[-12,-26]];ra=[[9,-44],[19,-36],[14,-28]];}               // passinho
  else if(move===2){la=[[-9,-44],[-20,-52-b*6],[-26,-60-b*8]];ra=[[9,-44],[20,-52-b*6],[26,-60-b*8]];} // jumping
  else if(move===3){la=[[-9,-44],[-16,-38+sw],[-22,-46+sw]];ra=[[9,-44],[16,-50],[8,-62]];}           // wave + phone
  else {la=[[-9,-44],[-17,-36],[-18,-28]];ra=[[9,-44],[18,-54],[20,-68+Math.sin(beat)*4]];}           // fist pump
  line(c,la,skin,5);line(c,ra,skin,5);
  if(move===3){const hx=ra[2][0],hy=ra[2][1];rect(c,hx-3,hy-8,7,11,'#111');rect(c,hx-2,hy-7,5,8,'#9fd8ff');glow(c,hx,hy-3,16,'#9fd8ff',.25);}
  if(seed%7===2){const hx=la[2][0],hy=la[2][1],col=['#7dff9a','#ff7ad9','#7adfff'][seed%3];line(c,[[hx,hy],[hx-4,hy-14]],col,3);glow(c,hx-2,hy-7,14,col,.35);}
  // head + hair styles
  rect(c,-8,-64,16,17,'#151a28');rect(c,-7,-63,14,15,skin);rect(c,3,-63,4,15,skinSh);
  const style=(seed*11)%5;
  if(style===0){oval(c,0,-64,11,9,hairC);} // afro / volume
  else if(style===1){rect(c,-8,-66,16,5,hairC);rect(c,-9,-62,3,14,hairC);rect(c,6,-62,3,14,hairC);} // long
  else if(style===2){rect(c,-9,-66,18,5,['#e2445c','#1d1d1d','#2d9cdb'][seed%3]);rect(c,0,-63,12,2,['#e2445c','#1d1d1d','#2d9cdb'][seed%3]);} // cap
  else if(style===3){rect(c,-8,-66,16,5,hairC);for(const bx of[-10,-8,7,9])rect(c,bx,-63,2,17,hairC);} // braids
  else rect(c,-7,-65,14,3,hairC); // buzz
  rect(c,-4,-57,2,2,'#1b1414');rect(c,2,-57,2,2,'#1b1414');rect(c,-2,-52,5,2,b>.5?'#8b3a3a':'#6a3a32');
  c.restore();
 }
 // Show: lasers, LED wall with equalizer, pulsing speakers, stage fog, confetti bursts, strobe.
 function showFx(c,x,t){
  if(window.BailePixel?.fx?.(c,x,t))return;
  const beat=t*BPM,b=Math.pow(Math.max(0,Math.sin(beat*Math.PI*2)),3),bar=Math.floor(beat/4);
  c.save();c.translate(Math.round(x),0);
  // lasers sweeping the night sky
  c.save();c.globalCompositeOperation='lighter';
  for(let i=0;i<8;i++){const a=-Math.PI/2+Math.sin(t*(.6+i*.07)+i*1.3)*.9,col=['#ff4fd8','#4fd8ff','#7dff6a','#ffe14f'][(i+bar)%4];
   c.globalAlpha=.16+.14*b;c.strokeStyle=col;c.lineWidth=2;c.beginPath();c.moveTo((i-3.5)*60,200);c.lineTo((i-3.5)*60+Math.cos(a)*900,200+Math.sin(a)*900);c.stroke();
   c.globalAlpha=.06;c.lineWidth=7;c.stroke();}
  c.restore();
  // LED wall equalizer behind the DJ
  rect(c,-140,150,280,44,'#0b0f1c');for(let i=0;i<28;i++){const h=6+Math.abs(Math.sin(t*6+i*.7))*24*(.5+b*.6);for(let k=0;k<h;k+=4)rect(c,-136+i*10,190-k,8,3,k>24?'#ff4f6a':k>14?'#ffe14f':'#4fd8ff');}
  // pulsing speaker cones
  for(const xx of[-230,220])for(const yy of[304,364]){oval(c,xx,yy,17+b*2,18+b*2,'#4a5b6c');oval(c,xx,yy,7+b*2,8+b*2,'#1c2a3e');}
  // stage fog
  for(let i=0;i<9;i++){const fx=-260+i*65+Math.sin(t*.4+i)*20,fy=400+Math.sin(t*.6+i*2)*6;c.save();c.globalAlpha=.16;oval(c,fx,fy,60,18,'#cdb8ee');c.restore();}
  // confetti burst every 4 bars
  const cb=(beat%16)/16;if(cb<.35){const k=cb/.35;for(let i=0;i<40;i++){const side=i%2?1:-1,a=-Math.PI/2+side*(.2+((i*37)%50)/100),v=260*(1-k*.3);c.save();c.globalAlpha=1-k;c.fillStyle=['#ff4fd8','#4fd8ff','#7dff6a','#ffe14f','#ffffff'][i%5];c.fillRect(side*240+Math.cos(a)*v*k,200+Math.sin(a)*v*k+k*k*220,4,3);c.restore();}}
  c.restore();
  // strobe on the downbeat of every other bar
  if(beat%8<.06){c.save();c.globalAlpha=.12;c.fillStyle='#ffffff';c.fillRect(0,0,W,H);c.restore();}
 }
 // Ollyan, redrawn thin and drunk for the party (the flying fight keeps the classic, slimmed).
 function drawOllyan(c,x,y,t=0,o={}){
  if(window.BailePixel?.ollyan?.(c,x,y,t,o))return; // Ollyan redesenhado (baile-pixel.js)
  if(o.flying||isLite()){if(o.flying&&!isLite()){c.save();c.translate(Math.round(x),Math.round(y));c.scale(.84,1.04);drawOllyanClassic(c,0,0,t,o);c.restore();return;}return drawOllyanClassic(c,x,y,t,o);}
  const scale=finite(o.scale,1),face=o.facing===-1?-1:1,skin='#ebc4ab',flush='#e07a74',ink='#121722',hood='#262b38',hoodSh='#181c27';
  // stagger: the body lags behind the hips, feet shuffle to catch the balance
  const sway=Math.sin(t*1.7)*.16+Math.sin(t*3.1)*.05,lag=Math.sin(t*1.7-.6)*.12,stepL=Math.sin(t*1.7)*6,stepR=-Math.sin(t*1.7+.8)*5;
  c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale(face*scale,scale);
  oval(c,0,0,16,4,'#0c101d80');
  // long skinny legs and baggy shorts
  line(c,[[-4,-44],[-6+stepL*.5,-22],[-7+stepL,-2]],skin,4);line(c,[[4,-44],[6+stepR*.5,-22],[7+stepR,-2]],skin,4);
  rect(c,-12+stepL,-5,12,5,'#f2f2f2');rect(c,3+stepR,-5,12,5,'#f2f2f2');rect(c,-12+stepL,-1,12,2,'#c9ced6');rect(c,3+stepR,-1,12,2,'#c9ced6');
  pixelPoly(c,[[-10,-58],[10,-58],[11,-40],[-11,-40]],'#3a4766',2);rect(c,-1,-58,2,18,'#2a3550');
  c.rotate(sway);
  // narrow hoodie torso, hood strings swinging
  pixelPoly(c,[[-9,-96],[9,-96],[11,-58],[-11,-58]],ink,2);pixelPoly(c,[[-7,-94],[7,-94],[9,-60],[-9,-60]],hood,2);pixelPoly(c,[[2,-94],[7,-94],[9,-60],[3,-60]],hoodSh,2);
  rect(c,-3+Math.round(lag*10),-92,1,14,'#d9dde3');rect(c,3+Math.round(lag*10),-92,1,13,'#d9dde3');rect(c,-6,-72,12,6,'#1c2130');
  // arms: one flailing for balance, one gripping the cup that sloshes
  const flail=Math.sin(t*2.6)*10;
  line(c,[[-8,-90],[-18,-78+flail*.3],[-26,-66+flail]],hood,4);rect(c,-29,-68+flail,5,5,skin);
  const cupX=20,cupY=-74+Math.sin(t*1.7)*3;line(c,[[8,-90],[16,-80],[cupX-2,cupY+6]],hood,4);rect(c,cupX-4,cupY+3,5,5,skin);
  if(o.cup!==false){rect(c,cupX-2,cupY-10,9,13,'#e8392e');rect(c,cupX-2,cupY-10,9,2,'#f4f4f4');const slosh=Math.sin(t*3.4);if(slosh>.7){for(let i=0;i<3;i++)rect(c,cupX+6+i*2,cupY-8+i*4+Math.round((slosh-.7)*20),2,2,'#d8b25a');}}
  // head tilted the other way, big ears, flushed face, half-lidded eyes, crooked grin
  c.save();c.translate(0,-100);c.rotate(-lag*1.4);
  for(const side of[-1,1]){pixelPoly(c,[[side*9,-12],[side*24,-20],[side*30,-12],[side*24,-2],[side*10,-4]],ink,2);pixelPoly(c,[[side*11,-11],[side*22,-17],[side*26,-11],[side*21,-5],[side*12,-6]],skin,2);rect(c,side>0?14:-20,-12,6,3,flush);}
  pixelPoly(c,[[-10,-22],[10,-22],[12,-6],[6,4],[-6,4],[-12,-6]],ink,2);pixelPoly(c,[[-8,-20],[8,-20],[10,-6],[5,2],[-5,2],[-10,-6]],skin,2);
  pixelPoly(c,[[-10,-22],[0,-27],[10,-22],[11,-15],[5,-17],[0,-15],[-6,-17],[-11,-15]],'#141a25',2);
  rect(c,-9,-6,6,3,flush);rect(c,4,-6,6,3,flush);rect(c,-2,-10,4,4,'#f2a39a');
  const lid=Math.sin(t*.9)>.85?1:0;rect(c,-7,-12,5,lid?1:3,'#f2e4d7');rect(c,3,-12,5,lid?1:3,'#f2e4d7');if(!lid){rect(c,-6,-11,2,2,'#2a2230');rect(c,4,-11,2,2,'#2a2230');}rect(c,-8,-13,6,2,'#3a2a2e');rect(c,2,-13,6,2,'#3a2a2e');
  rect(c,-4,-2,8,2,'#6f4047');rect(c,2,-3,3,2,'#6f4047');
  c.restore();
  if(o.hit){c.globalAlpha=.25;rect(c,-18,-130,36,130,'#fff3d9');c.globalAlpha=1;}
  c.restore();
  // hiccup bubble
  const hic=(t*.45)%1;if(hic<.3&&o.cup!==false){c.save();c.globalAlpha=1-hic/.3;text(c,'hic!',x+face*22,y-150-hic*30,11,'#ffd0e0');c.restore();}
 }
 function stage(c,x,t){
  if(window.BailePixel?.palco?.(c,x,t))return;
  c.save();c.translate(Math.round(x),0);rect(c,-290,200,580,240,'#1b2441');rect(c,-284,205,568,225,'#302c52');rect(c,-289,416,578,24,'#382e4d');rect(c,-296,413,590,5,'#eab78e');
  for(const xx of[-283,279]){rect(c,xx,147,7,267,'#7691a5');for(let y=150;y<405;y+=25)line(c,[[xx,y],[xx+7,y+13],[xx,y+25]],'#b5c7d2',1);}
  rect(c,-286,146,574,8,'#7189a1');for(let xx=-274;xx<275;xx+=28)line(c,[[xx,146],[xx+14,154],[xx+28,146]],'#bfd0d6',1);
  const glowLevel=.36+Math.sin(t*.9)*.08;glow(c,0,268,245,'#aa65dc',glowLevel);for(let i=0;i<5;i++){const xx=-228+i*112,yy=168,angle=Math.sin(t*.55+i)*.24+i*.11-.22;c.save();c.translate(xx,yy);c.rotate(angle);c.globalAlpha=.065;poly(c,[[0,0],[-105,245],[105,245]],['#e3a8ee','#91dbe3','#eecb8c'][i%3]);c.globalAlpha=1;rect(c,-10,-5,20,12,'#374a6c');rect(c,-7,5,14,5,['#f4a8df','#94dfeb','#f8dc9b'][i%3]);c.restore();}
  for(const xx of[-230,220]){rect(c,xx-31,272,62,137,'#141a2a');rect(c,xx-26,279,52,122,'#354052');for(const yy of[304,364]){oval(c,xx,yy,22,23,'#131e2d');oval(c,xx,yy,17,18,'#4a5b6c');oval(c,xx,yy,7,8,'#152136');}rect(c,xx-27,405,55,5,'#6c7891');}
  rect(c,-151,196,302,43,'#172239');rect(c,-145,201,290,32,'#342b58');text(c,'BAILE DA ROÇA',0,217,19,'#efa7d6');rect(c,-113,248,226,7,'#edc296');
  dancer(c,-66,358,t,16,1.05);dancer(c,65,356,t+.3,22,1.05);rect(c,-108,337,218,48,'#1a263a');rect(c,-100,345,202,22,'#464b70');for(let i=0;i<10;i++)rect(c,-93+i*20,349,12,3,['#bfcde1','#95dfc8','#e7bdd8'][i%3]);
  const hands=Math.sin(t*3.5)*4;rect(c,-19,277,37,22,'#252735');rect(c,-15,281,29,20,'#c9977a');rect(c,-21,274,41,8,'#1b2135');rect(c,-26,282,5,18,'#718dab');rect(c,20,282,5,18,'#718dab');rect(c,-20,300,40,37,'#a886b5');line(c,[[-15,310],[-30,323+hands],[-41,341]],'#d7a98b',8);line(c,[[15,311],[30,323-hands],[43,341]],'#d7a98b',8);
  for(const xx of[-151,152]){rect(c,xx-22,341,45,48,'#79516b');oval(c,xx,341,24,8,'#d9c9ae');rect(c,xx-2,388,4,21,'#626b7f');line(c,[[xx-13,345],[xx-18+hands,332]],'#efdcb8',3);}
  for(let i=0;i<9;i++){const h=9+Math.sin(t*2+i*.8)*7;rect(c,-83+i*21,378-h,10,h,'#83cdbb');}c.restore();
 }
 function pixelPoly(c,points,color,unit=2){
  const minX=Math.floor(Math.min(...points.map(p=>p[0]))/unit)*unit,maxX=Math.ceil(Math.max(...points.map(p=>p[0]))/unit)*unit,minY=Math.floor(Math.min(...points.map(p=>p[1]))/unit)*unit,maxY=Math.ceil(Math.max(...points.map(p=>p[1]))/unit)*unit;c.fillStyle=color;
  for(let y=minY;y<maxY;y+=unit)for(let x=minX;x<maxX;x+=unit){const px=x+unit*.5,py=y+unit*.5;let inside=false;for(let i=0,j=points.length-1;i<points.length;j=i++){const a=points[i],b=points[j];if((a[1]>py)!==(b[1]>py)&&px<(b[0]-a[0])*(py-a[1])/(b[1]-a[1])+a[0])inside=!inside;}if(inside)c.fillRect(x,y,unit,unit);}
 }
 function drawOllyanClassic(c,x,y,t=0,o={}){
  const flying=!!o.flying,flap=Math.round(Math.sin(t*(o.fast?15:10))*4),sway=flying?Math.sin(t*2)*.018:Math.sin(t*2.3)*.027,scale=finite(o.scale,1),skin='#e7c2a9',shadow='#c18e7d';
  c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale(o.facing===-1?-scale:scale,scale);c.rotate(finite(o.angle,0)+sway);
  if(o.aura){glow(c,0,-44,97,o.aura,.19);for(let i=0;i<6;i++){const a=t*.8+i*TAU/6;rect(c,Math.cos(a)*79,-44+Math.sin(a)*66,3,6,o.aura);}}
  for(const side of[-1,1]){
   c.save();c.scale(side,1);
   if(flying){
    pixelPoly(c,[[12,-80],[28,-87-flap],[48,-91-flap],[72,-91-flap*2],[98,-86-flap*2],[128,-76-flap],[116,-64+flap],[92,-56+flap],[63,-55+flap],[39,-60],[16,-62]],palette.ink,3);
    pixelPoly(c,[[17,-77],[31,-82-flap],[50,-86-flap],[72,-86-flap*2],[97,-81-flap*2],[119,-75-flap],[110,-68+flap],[89,-62+flap],[64,-61+flap],[41,-65],[18,-66]],skin,3);
    pixelPoly(c,[[26,-74],[51,-79-flap],[77,-78-flap],[100,-74-flap],[82,-68+flap],[54,-67],[31,-68]],shadow,3);
    rect(c,48,-82-flap,15,3,'#f4d9bf');rect(c,71,-81-flap*2,18,3,'#f2d7be');rect(c,24,-73,10,3,'#bd8d7e');
   }else{
    pixelPoly(c,[[11,-82],[25,-88],[41,-83],[45,-74],[38,-64],[20,-61],[11,-66]],palette.ink,2);
    pixelPoly(c,[[15,-78],[25,-83],[37,-80],[39,-73],[34,-68],[21,-66],[15,-69]],skin,2);rect(c,24,-78,9,3,shadow);rect(c,23,-74,3,6,shadow);
   }c.restore();
  }
  const leg=flying?Math.round(Math.sin(t*7)*2):Math.round(Math.sin(t*3)*2);pixelPoly(c,[[-10,-26],[-2,-26],[-4,-12],[-7+leg,-2],[-14+leg,-2]],'#192538',2);pixelPoly(c,[[3,-26],[11,-26],[14,-12],[17-leg,-2],[9-leg,-2]],'#233046',2);rect(c,-18+leg,-4,13,6,'#bdc8d0');rect(c,7-leg,-3,14,5,'#cbd2d5');
  // Narrow hoodie, long arms and an angular face preserve his lean silhouette.
  pixelPoly(c,[[-10,-60],[-17,-55],[-15,-31],[-11,-24],[10,-24],[15,-31],[17,-54],[10,-60]],'#111823',2);pixelPoly(c,[[-8,-57],[-13,-52],[-10,-30],[10,-30],[13,-51],[8,-57]],'#252a36',2);rect(c,-7,-46,14,2,'#464957');rect(c,-7,-36,14,6,'#1c2330');rect(c,-3,-55,2,11,'#b7bcc4');rect(c,5,-55,2,11,'#b7bcc4');
  const handY=flying?-32:-27;pixelPoly(c,[[-15,-54],[-20,-51],[-23,-37],[-24,handY],[-18,handY+2],[-17,-36],[-12,-49]],'#111925',2);pixelPoly(c,[[14,-54],[19,-51],[22,-37],[25,handY-2],[19,handY+1],[16,-36],[12,-49]],'#172031',2);rect(c,-26,handY-3,7,8,skin);rect(c,19,handY-5,7,8,skin);if(!flying&&o.cup!==false){rect(c,21,handY-11,9,13,'#dedfcf');rect(c,22,handY-10,7,5,'#a68b63');rect(c,21,handY-12,9,2,'#fff0cf');}
  const head=[[0,-96],[11,-91],[17,-80],[13,-68],[5,-59],[0,-56],[-6,-60],[-14,-69],[-17,-80],[-11,-91]];pixelPoly(c,head,palette.ink,2);pixelPoly(c,[[0,-92],[9,-88],[13,-79],[10,-69],[4,-62],[0,-60],[-5,-64],[-11,-71],[-13,-80],[-9,-88]],skin,2);pixelPoly(c,[[7,-85],[12,-78],[9,-70],[4,-64],[0,-61],[0,-67],[5,-72]],'#d3a38b',2);
  pixelPoly(c,[[-11,-91],[0,-96],[10,-91],[15,-83],[8,-82],[5,-87],[0,-85],[-6,-86],[-12,-82]],'#141a25',2);rect(c,-13,-82,3,6,'#171d27');rect(c,10,-82,3,6,'#171d27');
  // Stepped inward eyebrows and bright narrow eyes make the anger readable at game scale.
  rect(c,-11,-80,4,2,'#30262b');rect(c,-7,-78,4,2,'#30262b');rect(c,3,-78,4,2,'#30262b');rect(c,7,-80,4,2,'#30262b');rect(c,-10,-75,7,4,'#f2e4d7');rect(c,3,-75,7,4,'#f2e4d7');rect(c,-5,-75,2,4,'#222938');rect(c,3,-75,2,4,'#222938');rect(c,-1,-73,3,7,shadow);rect(c,-4,-65,9,2,'#6f4047');rect(c,-2,-63,7,2,'#f4dfcd');rect(c,-10,-69,4,2,'#d79b91');rect(c,8,-69,3,2,'#d79b91');if(o.hit){c.globalAlpha=.25;rect(c,-18,-95,36,72,'#fff3d9');}c.restore();
 }
 function world(c,camera=0,t=0,opts={}){
  c.save();c.imageSmoothingEnabled=false;
  if(window.BaileGalpao?.draw?.(c,camera,t,opts)){ollyanNoBaile(c,camera,t,opts);c.restore();return;} // baile em local fechado (baile-galpao.js)
  const sky=c.createLinearGradient(0,0,0,440);sky.addColorStop(0,'#0b1330');sky.addColorStop(.55,'#28325a');sky.addColorStop(1,'#71536e');c.fillStyle=sky;c.fillRect(0,0,W,H);
  for(let i=0;i<70;i++){const xx=((i*113.7-camera*.035)%1050+1050)%1050,yy=18+(i*47)%221;rect(c,xx,yy,i%7===0?2:1,i%7===0?2:1,'#cbd0e7');}glow(c,810-camera*.018,85,90,'#d5cdec',.14);oval(c,810-camera*.018,85,29,29,'#e5dbdc');oval(c,819-camera*.018,77,27,26,'#182144');
  for(let layer=0;layer<2;layer++){const speed=layer?.21:.11;for(let i=-2;i<18;i++){const xx=i*137-(camera*speed%137),hh=70+(i*i*37+layer*31)%114,yy=330-hh+layer*32;rect(c,xx,yy,127,330-yy,layer?'#24334b':'#1c2845');rect(c,xx+7,yy-5,113,7,layer?'#3b4b61':'#293450');for(let row=0;row<4;row++)for(let col=0;col<6;col++)if((i+row+col+layer)%3!==0)rect(c,xx+12+col*17,yy+15+row*22,7,9,layer?'#948576':'#5a6476');if(i%3===0){rect(c,xx+75,yy-26,3,23,'#576980');line(c,[[xx+57,yy-26],[xx+95,yy-26]],'#65788e',2);}}}
  for(let i=0;i<5;i++){const x=i*1100-camera*.55;line(c,[[x,165],[x+330,190],[x+680,172],[x+1000,186]],'#283442',3);for(let j=0;j<18;j++){const xx=x+j*57,yy=174+Math.sin(j*.42)*10+Math.sin(t*.8+j)*1.5;rect(c,xx,yy,5,8,['#f5d78b','#b3dce8','#eeabd7','#a9ddc1'][j%4]);if(j%3===0)glow(c,xx,yy,15,'#d9bbdb',.075);}}
  rect(c,0,330,W,110,'#59445c');for(let i=0;i<14;i++){const xx=i*95-(camera*.75%95);rect(c,xx,332,66,7,'#75566d');rect(c,xx+12,351,48,3,'#493c56');}rect(c,0,423,W,17,'#292e48');rect(c,0,440,W,100,'#30364e');rect(c,0,440,W,6,'#a18a8b');for(let i=-1;i<20;i++){const xx=i*64-(camera%64);rect(c,xx,451,1,89,'#262b43');rect(c,xx+7,477,40,2,'#4d4e66');rect(c,xx+24,514,31,2,'#43465e');}
  stage(c,2240-camera,t);if(!isLite())showFx(c,2240-camera,t);window.BailePixel?.cenario?.(c,camera,t);
  // Two dense, independently animated rows form a full audience in front of the stage.
  // Only visible people are rendered: the 232-person crowd stays light on phones.
  for(let row=0;row<2;row++)for(let i=0;i<116;i++){
   const wx=60+i*41+row*23,xx=wx-camera;if(xx<-45||xx>W+45||row===0&&wx>1900&&wx<2560)continue;
   const yy=row===0?401+i%3*5:438+i%2*3,scale=row===0?.73:.91;dancer(c,xx,yy,t+row*.33,i+row*7,scale);
  }
  if(!isLite())for(let i=0;i<70;i++){const wx=40+i*67+((i*29)%30),xx=wx-camera;if(xx<-50||xx>W+50||Math.abs(wx-3260)<90)continue;c.save();c.globalAlpha=.92;dancer(c,xx,486+(i%3)*9,t+.6,i*5+3,1.08);c.restore();}
  for(const wx of[230,1000,2850,4070,4620]){const xx=wx-camera;if(xx<-100||xx>W+100)continue;rect(c,xx,203,8,237,'#293b54');rect(c,xx-20,197,49,15,'#526278');rect(c,xx-14,212,38,6,'#efc994');glow(c,xx+5,236,76,'#e3b083',.09);}
  for(let i=0;i<21;i++){const xx=(i*227-camera*.35+t*(4+i%3))%W,yy=210+(i*41)%190;rect(c,xx,yy,2,2,i%2?'#c4b6d7':'#a7dcd8');}
  const signs=[{x:430,txt:'BAILE FUNK'},{x:1350,txt:'PISTA DA RESENHA'},{x:2970,txt:'VAI COM CALMA, VÉI'},{x:4300,txt:'ITABUNA NO RITMO'}];for(const s of signs){const xx=s.x-camera;if(xx<-220||xx>W+220)continue;rect(c,xx-124,258,248,34,'#25304b');rect(c,xx-120,262,240,26,'#3c3556');text(c,s.txt,xx,276,12,'#e9b6d3');}
  ollyanNoBaile(c,camera,t,opts);c.restore();
 }
 function ollyanNoBaile(c,camera,t,opts){
  if(!opts.hideOllyan&&!opts.defeated&&NPC_X-camera>-100&&NPC_X-camera<W+100){drawOllyan(c,NPC_X-camera,FLOOR,t,{cup:true});text(c,'OLLYAN',NPC_X-camera,FLOOR-(isLite()?106:158),11,'#f4dca7');if(Math.sin(t*.7)>.25)text(c,'Ô, chapéu… qual foi?',NPC_X-camera,FLOOR-(isLite()?124:176),10,'#d8c4e6');}
  if(opts.defeated&&NPC_X-camera>-100&&NPC_X-camera<W+100){drawOllyan(c,NPC_X-camera,FLOOR,t,{cup:false});text(c,'OLLYAN · AGORA É SÓ DANÇA',NPC_X-camera,FLOOR-(isLite()?108:158),10,'#bfe5c7');}
 }
 function sky(c,t,phase=1){
  const g=c.createLinearGradient(0,0,0,H);g.addColorStop(0,phase===3?'#16162e':'#111e3c');g.addColorStop(.53,phase===3?'#5d355c':'#304d74');g.addColorStop(1,'#ae7890');c.fillStyle=g;c.fillRect(0,0,W,H);
  for(let i=0;i<58;i++){const x=((i*137-t*(9+i%3*5))%1040+1040)%1040,y=18+(i*61)%245;rect(c,x,y,i%8===0?2:1,i%8===0?2:1,'#d9d2e6');}glow(c,791,122,110,phase===3?'#a3c3e8':'#c3badb',.14);oval(c,791,122,43,43,'#e9dfd4');oval(c,780,115,8,5,'#bfb9c8');oval(c,804,135,10,7,'#c8bfcb');
  for(let i=0;i<7;i++){const x=((i*217-t*(21+i%3*5))%1400+1400)%1400-180,y=110+(i*83)%340;cloud(c,x,y,.9+i%3*.34,i%2?'#7587a8':'#a8a8c5',.19);}
  poly(c,[[0,490],[65,472],[117,485],[178,454],[218,472],[276,450],[338,478],[402,455],[466,483],[531,468],[605,479],[681,457],[745,482],[821,462],[892,479],[960,462],[960,540],[0,540]],'#26334d');
  for(let i=0;i<22;i++){const x=i*47-10-t*7%47,h=12+(i*37)%31;rect(c,x,535-h,37,h,'#18263d');if(i%2)rect(c,x+8,539-h,5,5,'#bda17e');}
  for(let i=0;i<6;i++){const xx=((i*220-t*65)%1350+1350)%1350-160;cloud(c,xx,518+i%2*12,1.8,'#8b88ab',.24);}
 }
 function pilot(c,x,y,t,options={}){
  c.save();c.translate(x,y);c.rotate(finite(options.angle,0));if(options.inv>0&&Math.floor(t*18)%2===0)c.globalAlpha=.56;
  if(options.dash){for(let i=0;i<5;i++){c.save();c.globalAlpha*=.13-i*.02;rect(c,-85-i*19,-17,57,17,'#d9f2c8');c.restore();}}
  if(window.Art?.drawVehicle)window.Art.drawVehicle(c,0,10,t);else{rect(c,-47,-19,95,31,'#7f975d');rect(c,-21,-39,44,24,'#b7c79e');rect(c,-38,12,20,8,'#314039');rect(c,21,12,20,8,'#314039');}
  if(window.Art?.drawCharacter)window.Art.drawCharacter(c,'daroca',3,-7,{frame:t,scale:.65,facing:1,muscular:!!options.trained,grounded:false,flight:true});else{rect(c,-8,-56,17,32,'#d49952');rect(c,-16,-60,34,5,'#e5ca8b');}c.restore();
 }
 function caption(c,speaker,content){
  rect(c,88,467,784,56,'#111c32e8');rect(c,91,467,3,56,'#c7a3d8');text(c,speaker.toUpperCase(),109,482,10,'#e8c892','left');
  c.save();c.font='12px monospace';c.fillStyle='#eee5df';c.textBaseline='middle';c.textAlign='left';const words=content.split(' ');let value='',y=501;for(const word of words){if(c.measureText(value+' '+word).width>735){c.fillText(value,109,y);y+=15;value=word;}else value+=(value?' ':'')+word;}c.fillText(value,109,y);c.restore();
 }
 function drawIntro(c,seconds=0,options={}){
  const t=clamp(finite(seconds,0),0,9),index=Math.min(2,Math.floor(t/3)),local=t-index*3;
  c.save();c.imageSmoothingEnabled=false;
  const G=window.BaileGalpao,tetoY=G?G.TETO:70;
  if(index<2){
   // Ollyan sobe girando as orelhas, rasga o teto de zinco e a luz da lua entra no galpão
   const sobe=index===1?smooth(local/1.5):0,fura=index===1?smooth((local-1.3)/.45):0,saiu=index===1?smooth((local-1.55)/.9):0;
   const tremor=index===1&&local>1.25&&local<1.9?Math.sin(t*90)*3:0;c.save();c.translate(Math.round(tremor),Math.round(tremor*.5));
   world(c,NPC_X-535,t,{hideOllyan:true,rombo:G?fura:undefined});rect(c,0,0,W,H,'#11152d22');
   const approach=index===0?535-smooth(local/2.65)*75:460+sobe*75,oy=index===0?440:440-sobe*(440-tetoY-30)-saiu*200;
   drawOllyan(c,approach+Math.sin(t*3)*6,oy,t,{scale:1+sobe*.08,facing:-1,flying:index===1&&local>.25,cup:index===0,fast:true,angle:index===0?Math.sin(t*3)*.08:0});
   if(window.Art?.drawCharacter)window.Art.drawCharacter(c,'daroca',315,440,{frame:t,facing:1,muscular:!!options.trained});else{rect(c,303,383,24,57,'#dda05d');rect(c,293,376,44,6,'#dbc589');}
   if(index===1){for(let i=0;i<12;i++){const q=(t*1.1+i*.13)%1,xx=535+Math.cos(i*2.4)*q*130,yy=oy-5-q*120;rect(c,xx,yy,4,3,'#dbd2e4');}
    // pedaços de telha caindo depois do estouro
    if(fura>0)for(let i=0;i<14;i++){const q=clamp(local-1.3-i*.03,0,2),xx=535+(i-7)*14+Math.sin(i)*20,yy=tetoY+q*q*260+q*40;if(yy<440)rect(c,xx,yy,6+(i%3)*3,3,i%2?'#4a4e60':'#6a6e80');}}
   c.restore();
  }else if(local<1){
   // o carro a gás sobe pelo buraco atrás do Ollyan
   const u=smooth(local);world(c,NPC_X-535,t,{hideOllyan:true,rombo:G?1:undefined});rect(c,0,0,W,H,'#11152d22');pilot(c,520,430-u*470,t,{trained:options.trained,dash:true});
  }else{sky(c,t,1);const chase=smooth((local-1)/2);drawOllyan(c,750+Math.sin(t*4)*5,190-Math.sin(t*2)*15,t,{scale:1.25,flying:true,fast:true});pilot(c,150+chase*200,330-chase*72,t,{trained:options.trained,dash:true});for(let i=0;i<9;i++){const xx=(i*143-t*260)%1100;rect(c,xx,130+(i*43)%270,40,2,'#ddd9e444');}}
  rect(c,0,0,W,25,'#0b1122');rect(c,0,532,W,8,'#0b1122');text(c,index===2?'CARRO A GÁS · PERSEGUIÇÃO NO CÉU':'BAILE FUNK · O CÉU VIROU PISTA',480,13,10,'#d9cfdf');caption(c,INTRO[index].speaker,INTRO[index].text);c.restore();
 }
 function renderIntro(canvasOrContext,seconds=0,options={}){
  if(!canvasOrContext)return null;const canvas=typeof canvasOrContext.getContext==='function'?canvasOrContext:null,c=canvas?canvas.getContext('2d'):canvasOrContext;if(!c)return null;
  if(canvas){const scale=Math.min(canvas.width/W,canvas.height/H);c.save();c.setTransform(1,0,0,1,0,0);rect(c,0,0,canvas.width,canvas.height,'#0a1020');c.translate((canvas.width-W*scale)/2,(canvas.height-H*scale)/2);c.scale(scale,scale);drawIntro(c,seconds,options);c.restore();}else drawIntro(c,seconds,options);
  return{id:'ollyan_flight',time:clamp(finite(seconds,0),0,9),duration:9,index:Math.min(2,Math.floor(clamp(finite(seconds,0),0,8.999)/3))};
 }
 function previewTimeline(){return{id:'ollyan_flight',duration:9,manualDefault:false,shots:INTRO.map(x=>({...x}))};}
 function event(s,type,detail={}){s.events.push({type,...detail});if(s.events.length>40)s.events.splice(0,s.events.length-40);}
 function create(options={}){
  const maxHP=clamp(finite(options.maxHP,100),1,10000),maxGas=clamp(finite(options.maxGas,100),10,10000),bossHP=clamp(finite(options.bossHP,2600),100,100000);
  return{kind:'ollyan',token:'ollyan-flight-'+(++serial),stage:'intro',stageTime:0,time:0,phase:1,done:false,success:false,cancelled:false,events:[],options:{...options},player:{x:196,y:320,vx:0,vy:0,grounded:false,facing:1,jumpHeld:false,jumpBuffer:0,coyote:0,attackTime:0,lastAttack:'paper',hp:clamp(finite(options.hp,maxHP),1,maxHP),maxHP,gas:clamp(finite(options.gas,maxGas),0,maxGas),maxGas,inv:1,dash:0,dashX:1,dashY:0,paperCooldown:0,fartCooldown:0,dashCooldown:0,tilt:0},mode:'car',phaseHPs:[bossHP,Math.round(bossHP*1.25),Math.round(bossHP*1.5)],platforms:SKY_PLATFORMS.map(p=>({...p})),parkedCar:{x:142,y:399},transitionStart:null,playerInputX:0,playerInputY:0,boss:{x:744,y:246,hp:bossHP,max:bossHP,baseMax:bossHP,hit:0,inv:0,state:'recover',stateTime:.9,attack:'',attackId:0,sequence:0,targetX:196,targetY:320},shots:[],hazards:[],particles:[],shake:0,transitionFrom:1,transitionTo:1,bonuses:{damageMultiplier:clamp(finite(options.damageMultiplier,1),.1,100),moveSpeed:clamp(finite(options.moveSpeed,280),120,900),dashCooldown:clamp(finite(options.dashCooldown,1.1),.35,4),gasRegen:clamp(finite(options.gasRegen,13),1,150),maxHP,maxGas},seed:finite(options.seed,1)};
 }
 function setPlayer(s,values={}){if(!s||s.done)return false;if(values.maxHP!==undefined||values.maxGas!==undefined)setBonuses(s,values);if(values.hp!==undefined)s.player.hp=clamp(finite(values.hp,s.player.hp),0,s.player.maxHP);if(values.gas!==undefined)s.player.gas=clamp(finite(values.gas,s.player.gas),0,s.player.maxGas);return true;}
 function setBonuses(s,values={}){
  if(!s)return;const b=s.bonuses;for(const key of['damageMultiplier','moveSpeed','dashCooldown','gasRegen'])if(values[key]!==undefined)b[key]=Math.max(.1,finite(values[key],b[key]));
  if(values.maxHP!==undefined){s.player.maxHP=b.maxHP=clamp(finite(values.maxHP,b.maxHP),1,10000);s.player.hp=Math.min(s.player.hp,s.player.maxHP);}
  if(values.maxGas!==undefined){s.player.maxGas=b.maxGas=clamp(finite(values.maxGas,b.maxGas),10,10000);s.player.gas=Math.min(s.player.gas,s.player.maxGas);}
 }
 function startFight(s){s.stage='fight';s.stageTime=0;s.player.inv=Math.max(s.player.inv,1.25);s.boss.state='recover';s.boss.stateTime=.65;event(s,'intro-end');}
 function burst(s,x,y,color,count=15,speed=100){for(let i=0;i<count;i++){const a=(i+.3)*2.399,r=speed*(.35+(i%7)/10);s.particles.push({x,y,vx:Math.cos(a)*r,vy:Math.sin(a)*r,life:.4+(i%5)*.08,maxLife:.8,size:2+i%3,color});}if(s.particles.length>160)s.particles.splice(0,s.particles.length-160);}
 function damagePlayer(s,damage,x){if(s.stage!=='fight'||s.player.inv>0||s.player.hp<=0)return false;const value=Math.max(1,Math.round(damage*clamp(finite(s.options.enemyDamageMultiplier,1.5),.2,6)));s.player.hp=Math.max(0,s.player.hp-value);s.player.inv=1.05;s.player.x=clamp(s.player.x+(s.player.x<x?-15:15),65,895);s.shake=5;burst(s,s.player.x,s.player.y,'#f2d19c',13,100);event(s,'hurt',{damage:value,hp:s.player.hp,sourceX:x});if(s.player.hp<=0){s.stage='defeat';s.stageTime=0;s.shots=[];s.hazards=[];}return true;}
 function damageBoss(s,damage,x,y){
  if(s.stage!=='fight'||s.boss.inv>0||s.boss.hp<=0)return false;
  s.boss.hp=Math.max(0,s.boss.hp-Math.max(1,damage));s.boss.hit=.11;burst(s,x,y,s.phase===3?'#e9baee':'#eddaa3',4,35);
  if(s.boss.hp<=0){
   if(s.phase<3)phaseChange(s,s.phase+1);
   else{s.stage='victory';s.stageTime=0;s.shots=[];s.hazards=[];s.player.inv=10;s.shake=10;burst(s,s.boss.x,s.boss.y,'#e8ce8f',45,150);}
  }
  return true;
 }
 function shot(s,x,y,vx,vy,type,damage,r=9,extra={}){s.shots.push({x,y,vx,vy,type,damage,r,life:7,age:0,owner:'enemy',...extra});if(s.shots.length>180)s.shots.splice(0,s.shots.length-180);}
 function fan(s,count,speed,spread=.16){const b=s.boss,p=s.player,base=Math.atan2((s.mode==='platform'?p.y-32:p.y)-b.y,p.x-b.x),gap=s.phase===3?2:0;for(let i=0;i<count;i++){if(gap&&i===Math.floor(count/2))continue;const a=base+(i-(count-1)/2)*spread;shot(s,b.x-35,b.y,Math.cos(a)*speed,Math.sin(a)*speed,'ear',s.phase===3?16:12,8,{spin:i%2?1:-1});}}
 function ring(s,count,speed,rotate=0){const b=s.boss,p=s.player,aim=Math.atan2((s.mode==='platform'?p.y-32:p.y)-b.y,p.x-b.x);for(let i=0;i<count;i++){const a=i/count*TAU+rotate,delta=Math.atan2(Math.sin(a-aim),Math.cos(a-aim));if(Math.abs(delta)<.20)continue;shot(s,b.x,b.y,Math.cos(a)*speed,Math.sin(a)*speed,'pulse',12,8,{spin:i%2?1:-1});}}
 function beginAttack(s){const p=phases[s.phase-1],b=s.boss;b.attack=p.attacks[b.sequence%p.attacks.length];b.sequence++;b.attackId++;b.targetX=s.player.x;b.targetY=s.mode==='platform'?s.player.y-32:s.player.y;b.state='windup';b.stateTime=(p.windup+(b.attack==='moonBeam'?.28:0))*clamp(finite(s.options.windupMultiplier,1),.4,2);event(s,'telegraph',{attack:b.attack,label:attackNames[b.attack],duration:b.stateTime});}
 function executeAttack(s){
  const b=s.boss,p=phases[s.phase-1],speed=(200+s.phase*25)*p.speed;
  if(b.attack==='earFan')fan(s,3+s.phase*2,speed,.18);
  else if(b.attack==='pulseRing')ring(s,13,158,s.time*.18);
  else if(b.attack==='gustRing'){ring(s,18,180,s.time*.21);s.hazards.push({type:'ringBurst',x:b.x,y:b.y,delay:.7,life:.2,done:false});}
  else if(b.attack==='swoop'){b.state='swoop';b.stateTime=1.3;b.swoopStartX=b.x;b.swoopStartY=b.y;b.swoopEndX=clamp(b.targetX-60,100,800);b.swoopEndY=clamp(b.targetY,130,430);return;}
  else if(b.attack==='cloudGate'||b.attack==='crosswind'){
   const gap=s.mode==='platform'?[315,345,270][b.sequence%3]:clamp(130+(b.sequence*97)%285,144,405);s.hazards.push({type:'gate',x:1035,gapY:gap,gapSize:s.mode==='platform'?168:b.attack==='crosswind'?114:136,delay:.45,life:7,vx:-(158+s.phase*13),damage:18});
   if(b.attack==='crosswind')s.hazards.push({type:'gate',x:1035,gapY:clamp(535-gap,143,407),gapSize:122,delay:2.35,life:7,vx:-195,damage:19});
  }else if(b.attack==='platformStorm'){
   const safe=b.sequence%3;for(let i=0;i<3;i++){if(i===safe)continue;const platform=s.platforms[i];s.hazards.push({type:'cloudStorm',x:platform.x+platform.w/2,y:platform.y-12,delay:1.05+i*.18,life:.18,damage:16,done:false});}
  }else if(b.attack==='cometRain'){
   for(let i=0;i<5+s.phase;i++){const x=310+i*91,y=-50-i*31;shot(s,x,y,-74-s.phase*8,186+s.phase*17,'comet',15,10,{delay:i*.1,life:6,spin:i%2?1:-1});}
   if(s.phase===3)fan(s,3,218,.19);
  }else if(b.attack==='moonBeam')s.hazards.push({type:'beam',x:b.x,y:b.y,tx:b.targetX,ty:b.targetY,delay:.3,life:.42,damage:23,done:false});
  b.state='firing';b.stateTime=.38;s.shake=Math.max(s.shake,b.attack==='moonBeam'?5:2);burst(s,b.x-32,b.y-20,'#d3bedf',12,55);event(s,'attack',{attack:b.attack});
 }
 function attack(s,type='paper'){
  if(!s||s.stage!=='fight'||s.done||s.player.hp<=0)return false;const p=s.player,damage=clamp(s.bonuses.damageMultiplier,.1,100),b=s.boss,platform=s.mode==='platform',py=platform?p.y-35:p.y-10;
  if(type==='dash'){
   if(p.dashCooldown>0||p.gas<6)return false;p.gas-=6;p.dash=.19;p.inv=Math.max(p.inv,.28);p.dashCooldown=clamp(s.bonuses.dashCooldown,.35,4);if(platform){p.dashX=p.facing||1;p.dashY=0;}else if(!p.dashX&&!p.dashY)p.dashX=1;burst(s,p.x-32,platform?p.y-20:p.y,'#c1edc7',17,150);event(s,'dash');return true;
  }
  const facing=platform?(b.x>=p.x?1:-1):1;if(platform)p.facing=facing;const origin=p.x+(platform?23*facing:48),angle=platform?Math.atan2(b.y-12-py,b.x-origin):clamp(Math.atan2(b.y-p.y,Math.max(70,b.x-p.x)),-.65,.65);
  if(type==='fart'||type==='gas'){
   if(p.fartCooldown>0||p.gas<22)return false;p.gas-=22;p.fartCooldown=1.05;p.attackTime=.3;p.lastAttack='fart';s.shots=s.shots.filter(a=>a.owner==='player'||Math.hypot(a.x-p.x,a.y-py)>105);shot(s,origin,py,Math.cos(angle)*440,Math.sin(angle)*440,'gas',Math.round(61*damage),29,{owner:'player',life:1.8,pierce:false});burst(s,origin,py,'#c4e993',15,100);event(s,'fart');return true;
  }
  if(type==='jump'){if(!platform)return false;p.jumpBuffer=.12;return true;}
  if(p.paperCooldown>0)return false;p.paperCooldown=.21;p.attackTime=.22;p.lastAttack='paper';shot(s,origin,py,Math.cos(angle)*690,Math.sin(angle)*690,'paper',Math.round(14*damage),6,{owner:'player',life:1.6});event(s,'paper');return true;
 }
 function circleEllipse(x,y,ex,ey,rx,ry,pad=0){return Math.pow((x-ex)/(rx+pad),2)+Math.pow((y-ey)/(ry+pad),2)<=1;}
 function pointSegment(px,py,x1,y1,x2,y2){const dx=x2-x1,dy=y2-y1,den=dx*dx+dy*dy;if(!den)return Math.hypot(px-x1,py-y1);const k=clamp(((px-x1)*dx+(py-y1)*dy)/den,0,1);return Math.hypot(px-(x1+k*dx),py-(y1+k*dy));}
 function phaseChange(s,next){
  const p=s.player;s.transitionStart={x:p.x,y:p.y,mode:s.mode};s.transitionFrom=s.phase;s.transitionTo=next;s.phase=next;s.mode=next===2?'platform':'car';
  s.boss.max=s.phaseHPs[next-1];s.boss.hp=s.boss.max;s.stage='transition';s.stageTime=0;s.shots=[];s.hazards=[];p.inv=2.65;s.boss.inv=2.65;s.boss.sequence=0;s.boss.state='recover';s.boss.stateTime=.7;s.shake=7;p.vx=0;p.vy=0;p.dash=0;p.jumpBuffer=0;p.jumpHeld=false;
  if(s.mode==='platform'){p.x=230;p.y=416;p.grounded=true;p.coyote=.12;p.facing=1;}else{p.x=196;p.y=320;p.grounded=false;p.coyote=0;}
  burst(s,s.boss.x,s.boss.y,'#e8c5ed',35,135);event(s,'phase',{phase:next,name:phases[next-1].name,mode:s.mode,hp:s.boss.hp,max:s.boss.max});
 }
 function updatePlatformPlayer(s,dt,input){
  const p=s.player,ix=clamp(finite(input.x,0),-1,1),speed=clamp(s.bonuses.moveSpeed,140,700),wasY=p.y;p.jumpBuffer=Math.max(0,p.jumpBuffer-dt);p.coyote=p.grounded?.11:Math.max(0,p.coyote-dt);
  if(input.jump&&!p.jumpHeld)p.jumpBuffer=.13;p.jumpHeld=!!input.jump;if(Math.abs(ix)>.05)p.facing=ix<0?-1:1;
  if(p.jumpBuffer>0&&p.coyote>0){p.vy=-540;p.grounded=false;p.coyote=0;p.jumpBuffer=0;event(s,'jump');burst(s,p.x,p.y,'#c9e5e4',8,55);}
  p.vx=(p.dash>0?p.dashX*2.55:ix)*speed;p.x=clamp(p.x+p.vx*dt,28,932);p.vy=Math.min(780,p.vy+1200*dt);p.y+=p.vy*dt;p.grounded=false;
  if(p.vy>=0){for(const platform of s.platforms)if(p.x>platform.x-7&&p.x<platform.x+platform.w+7&&wasY<=platform.y+1&&p.y>=platform.y){p.y=platform.y;p.vy=0;p.grounded=true;p.coyote=.11;break;}}
  if(p.y>590){p.x=230;p.y=416;p.vy=0;p.vx=0;p.grounded=true;p.coyote=.11;const before=p.hp;damagePlayer(s,Math.min(27,Math.max(8,p.maxHP*.06)),p.x+1);p.inv=Math.max(p.inv,1.4);burst(s,p.x,p.y-12,'#c3dfe6',20,90);event(s,'fall',{hp:p.hp,damage:before-p.hp});}
  s.playerInputX=ix;s.playerInputY=0;p.tilt=0;
 }
 function playerCenter(s){return{x:s.player.x,y:s.mode==='platform'?s.player.y-31:s.player.y};}

 function update(s,delta,input={},bonuses={}){
  if(!s||s.done)return;setBonuses(s,bonuses);const dt=clamp(finite(delta,0),0,.05);if(!dt)return;s.time+=dt;s.stageTime+=dt;s.shake=Math.max(0,s.shake-dt*18);
  for(const part of s.particles){part.life-=dt;part.x+=part.vx*dt;part.y+=part.vy*dt;part.vy+=70*dt;}s.particles=s.particles.filter(p=>p.life>0);
  const p=s.player,b=s.boss;for(const key of['inv','dash','paperCooldown','fartCooldown','dashCooldown','attackTime'])p[key]=Math.max(0,p[key]-dt);b.hit=Math.max(0,b.hit-dt);b.inv=Math.max(0,b.inv-dt);
  if(s.stage==='intro'){if(s.stageTime>=9)startFight(s);return;}
  if(s.stage==='victory'){b.y+=dt*45;b.x+=Math.sin(s.time*5)*dt*13;if(s.stageTime>=2.6){s.done=true;s.success=true;event(s,'won',{hp:p.hp,gas:p.gas});}return;}
  if(s.stage==='defeat'){p.y+=dt*35;if(s.stageTime>=1.4){s.done=true;event(s,'defeated',{hp:0});}return;}
  if(s.stage==='transition'){b.x+=(740-b.x)*Math.min(1,dt*3);b.y+=(242-b.y)*Math.min(1,dt*3);if(s.stageTime>=2.05){s.stage='fight';s.stageTime=0;b.inv=0;b.state='recover';b.stateTime=.55;p.inv=Math.max(p.inv,.6);}return;}
  if(s.mode==='platform')updatePlatformPlayer(s,dt,input);
  else{let ix=clamp(finite(input.x,0),-1,1),iy=clamp(finite(input.y,0),-1,1);const len=Math.hypot(ix,iy);if(len>1){ix/=len;iy/=len;}if(len>.1){p.dashX=ix;p.dashY=iy;}const speed=clamp(s.bonuses.moveSpeed,140,700)*(p.dash>0?2.55:1);p.vx=(p.dash>0?p.dashX:ix)*speed;p.vy=(p.dash>0?p.dashY:iy)*speed;p.x=clamp(p.x+p.vx*dt,65,895);p.y=clamp(p.y+p.vy*dt,104,454);p.grounded=false;p.tilt+=(iy*.075-p.tilt)*Math.min(1,dt*8);s.playerInputX=ix;s.playerInputY=iy;}
  p.gas=Math.min(p.maxGas,p.gas+clamp(s.bonuses.gasRegen,1,150)*dt);
  if(s.stage!=='fight')return;if(input.fire||input.paper)attack(s,'paper');if(input.fart||input.gasAttack)attack(s,'fart');if(input.dash)attack(s,'dash');
  const ph=phases[s.phase-1];b.stateTime-=dt;
  if(b.state==='swoop'){
   const q=clamp(1-b.stateTime/1.3,0,1),arc=Math.sin(q*Math.PI);b.x=mix(b.swoopStartX,b.swoopEndX,arc);b.y=mix(b.swoopStartY,b.swoopEndY,arc)-Math.sin(q*TAU)*20;if(b.stateTime<=0){b.state='recover';b.stateTime=(ph.recover+1.05)*clamp(finite(s.options.recoveryMultiplier,1),.4,2);}
  }else{const targetX=716+Math.sin(s.time*.65)*28,targetY=s.mode==='platform'?205+Math.sin(s.time*.93)*48:246+Math.sin(s.time*(.78+s.phase*.07))*94;b.x+=(targetX-b.x)*Math.min(1,dt*2);b.y+=(targetY-b.y)*Math.min(1,dt*2);if(b.stateTime<=0){if(b.state==='windup')executeAttack(s);else if(b.state==='firing'){b.state='recover';b.stateTime=ph.recover*clamp(finite(s.options.recoveryMultiplier,1),.4,2);}else beginAttack(s);}}
  const center=playerCenter(s);if(b.state==='swoop'&&circleEllipse(center.x,center.y,b.x,b.y,48,62,s.mode==='platform'?16:22))damagePlayer(s,17,b.x);
  for(const a of s.shots){
   a.age+=dt;if(a.delay>0){a.delay-=dt;continue;}a.life-=dt;a.x+=a.vx*dt;a.y+=a.vy*dt;if(a.type==='comet'){a.vx-=dt*7;a.y+=Math.sin(a.age*4)*dt*12;}
   if(a.owner==='player'){if(circleEllipse(a.x,a.y,b.x,b.y-18,33+s.phase*3,59+s.phase*3,a.r)&&damageBoss(s,a.damage,a.x,a.y))a.life=0;}
   else if(circleEllipse(a.x,a.y,center.x,center.y,s.mode==='platform'?13:29,s.mode==='platform'?27:15,a.r)){if(damagePlayer(s,a.damage,a.x))a.life=0;}
  }
  s.shots=s.shots.filter(a=>a.life>0&&a.x>-100&&a.x<1110&&a.y>-180&&a.y<690);
  for(const h of s.hazards){
   if(h.delay>0){h.delay-=dt;continue;}h.life-=dt;
   if(h.type==='cloudStorm'&&!h.done){h.done=true;shot(s,h.x,90,0,340,'comet',h.damage,11,{life:2.1,spin:1});}
   else if(h.type==='ringBurst'&&!h.done){h.done=true;ring(s,15,190,s.time*.3);}
   else if(h.type==='gate'){h.x+=h.vx*dt;if(Math.abs(center.x-h.x)<38&&Math.abs(center.y-h.gapY)>h.gapSize*.5-(s.mode==='platform'?23:11))damagePlayer(s,h.damage,h.x);}
   else if(h.type==='beam'&&!h.done){const dx=h.tx-h.x,dy=h.ty-h.y,L=Math.hypot(dx,dy)||1,ex=h.x+dx/L*1200,ey=h.y+dy/L*1200;if(pointSegment(center.x,center.y,h.x,h.y,ex,ey)<(s.mode==='platform'?25:30)){if(damagePlayer(s,h.damage,h.x))h.done=true;}}
  }
  s.hazards=s.hazards.filter(h=>h.life>0&&(h.type!=='gate'||h.x>-70));
 }
 function advance(s){if(!s||s.done)return false;if(s.stage==='intro'){s.stageTime=Math.min(9,(Math.floor(s.stageTime/3)+1)*3);if(s.stageTime>=9)startFight(s);return true;}if(s.stage==='victory'){s.stageTime=2.6;update(s,.001);return true;}if(s.stage==='defeat'){s.stageTime=1.4;update(s,.001);return true;}return false;}
 function cancel(s){if(!s||s.done)return false;s.done=true;s.cancelled=true;s.stage='retreat';s.shots=[];s.hazards=[];event(s,'retreat',{hp:s.player.hp,gas:s.player.gas});return true;}
 function drainEvents(s){if(!s)return[];const out=s.events.slice();s.events.length=0;return out;}
 function getStatus(s){if(!s)return null;return{type:'ollyan',name:'Ollyan · Orelhas ao Vento',hp:s.boss.hp,max:s.boss.max,maxHP:s.boss.max,phase:s.phase,mode:s.mode,phaseHPs:s.phaseHPs.slice(),playerGrounded:!!s.player.grounded,playerX:s.player.x,playerY:s.player.y,playerVY:s.player.vy,phaseName:phases[s.phase-1].name,phases:3,stage:s.stage,time:s.time,stageTime:s.stageTime,active:s.stage==='fight'||s.stage==='transition',done:s.done,success:s.success,playerHP:s.player.hp,playerMaxHP:s.player.maxHP,gas:s.player.gas,maxGas:s.player.maxGas,dashCooldown:s.player.dashCooldown,fartCooldown:s.player.fartCooldown,telegraph:s.boss.state==='windup'?attackNames[s.boss.attack]:'',attack:s.boss.attack,shotCount:s.shots.length,hazardCount:s.hazards.length,recommendedLevel:10};}
 function getAudioState(s){if(!s)return null;return{cutscene:s.stage==='intro'?'ollyan_flight':null,cutsceneElapsed:s.stage==='intro'?s.stageTime:0,cutsceneToken:s.token,cutsceneIndex:s.stage==='intro'?Math.min(2,Math.floor(s.stageTime/3)):0,cutsceneTimed:s.stage==='intro',boss:['fight','transition'].includes(s.stage)?'ollyan':null};}
 function drawProjectile(c,a,t){
  if(window.BailePixel?.projetil?.(c,a,t))return; // ataques do Ollyan redesenhados (baile-pixel.js)
  c.save();c.translate(Math.round(a.x),Math.round(a.y));if(a.delay>0)c.globalAlpha=.28;
  if(a.type==='paper'){c.rotate(t*8);rect(c,-6,-5,12,10,'#fff1d0');rect(c,-3,-3,5,2,'#cabfae');}
  else if(a.type==='gas'){oval(c,0,0,27,20,'#94bc6999');oval(c,-6,-4,18,15,'#c5e399bb');rect(c,-4,-8,8,4,'#e0efb7');}
  else if(a.type==='ear'){c.rotate(t*4*a.spin);poly(c,[[-10,-4],[-4,-12],[8,-12],[12,-3],[6,10],[-5,8]],'#472e4c');poly(c,[[-6,-4],[-2,-8],[6,-8],[8,-2],[3,6],[-3,5]],'#e5baac');line(c,[[-2,-4],[3,-3],[0,3]],'#a8798f',2);}
  else if(a.type==='comet'){c.rotate(-.5);poly(c,[[3,11],[-9,-18],[2,-12],[9,-25],[13,0]],'#b0cff188');oval(c,0,0,10,12,'#535b9c');oval(c,-2,-1,6,7,'#d2b5e7');rect(c,-3,-3,3,3,'#f3e3ef');}
  else{oval(c,0,0,9,9,'#9a7ca9');oval(c,0,0,5,5,'#e4c8e4');rect(c,-2,-3,3,3,'#f6e2e5');}c.restore();
 }
 function hazardDraw(c,h,t){
  if(window.BailePixel?.perigo?.(c,h,t))return;
  c.save();if(h.type==='gate'){
   const x=h.delay>0?930:h.x,alpha=h.delay>0?.45:1;c.globalAlpha*=alpha;
   for(let yy=90;yy<494;yy+=29){if(Math.abs(yy-h.gapY)<h.gapSize*.5)continue;cloud(c,x,yy,.55,'#a7bed8',.9);line(c,[[x+13,yy-2],[x-8,yy+2],[x-25,yy-1]],'#e2d7e9',2);}
   if(h.delay>0){line(c,[[889,h.gapY-h.gapSize*.5],[909,h.gapY-h.gapSize*.5],[909,h.gapY+h.gapSize*.5],[889,h.gapY+h.gapSize*.5]],'#bcebc6',3);text(c,'VÃO',871,h.gapY,11,'#c7efcc');}
  }else if(h.type==='cloudStorm'){c.globalAlpha=h.delay>0?.7:.3;line(c,[[h.x,88],[h.x,h.y]],'#edbc9e',2);oval(c,h.x,h.y,35,8,'#dca9d266');text(c,'!',h.x,h.y-17,19,'#f1d19e');}
  else if(h.type==='beam'){
   const dx=h.tx-h.x,dy=h.ty-h.y,len=Math.hypot(dx,dy)||1,ex=h.x+dx/len*1200,ey=h.y+dy/len*1200;
   if(h.delay>0){c.setLineDash([12,9]);line(c,[[h.x,h.y],[ex,ey]],'#f5c8ad',3);c.setLineDash([]);}
   else{line(c,[[h.x,h.y],[ex,ey]],'#79559199',44);line(c,[[h.x,h.y],[ex,ey]],'#d3b5e2',21);line(c,[[h.x,h.y],[ex,ey]],'#fcf0e7',7);}
  }else if(h.type==='ringBurst'&&h.delay>0){c.globalAlpha*=.4;oval(c,h.x,h.y,36+Math.sin(t*7)*4,36+Math.sin(t*7)*4,'#bf94d155');}c.restore();
 }
 function skyPlatforms(c,s,alpha=1){
  c.save();c.globalAlpha*=alpha;for(const p of s.platforms){const y=p.y;rect(c,p.x+6,y,p.w-12,13,'#536e99');rect(c,p.x+3,y-5,p.w-6,8,'#c4e1e7');rect(c,p.x+11,y-9,p.w-22,6,'#eff1e2');for(let x=p.x+8;x<p.x+p.w-8;x+=29){rect(c,x,y+10,21,7,'#6482ad');rect(c,x+4,y+16,12,4,'#445f8c');}for(let x=p.x+15;x<p.x+p.w-8;x+=38)rect(c,x,y-13,25,6,'#dbe9e7');}c.restore();
 }
 function parkedVehicle(c,s,alpha=1){c.save();c.globalAlpha*=alpha;if(window.Art?.drawVehicle)window.Art.drawVehicle(c,s.parkedCar.x,s.parkedCar.y,s.time*.35);else{rect(c,s.parkedCar.x-50,s.parkedCar.y-21,100,28,'#758e5d');rect(c,s.parkedCar.x-20,s.parkedCar.y-42,40,24,'#b3c29b');}c.restore();}
 function onFoot(c,s,x=s.player.x,y=s.player.y,alpha=1){
  const p=s.player;c.save();c.globalAlpha*=alpha;if(p.inv>0&&Math.floor(s.time*18)%2===0)c.globalAlpha*=.55;
  if(p.dash>0){for(let i=0;i<4;i++){c.save();c.globalAlpha*=.16-i*.03;rect(c,x-p.facing*(18+i*14)-9,y-47,18,43,'#ccedca');c.restore();}}
  if(window.Art?.drawCharacter)window.Art.drawCharacter(c,'daroca',x,y,{frame:s.time,facing:p.facing,muscular:!!s.options.trained,moving:Math.abs(p.vx)>10,speed:Math.abs(p.vx),grounded:p.grounded,vy:p.vy,attack:p.attackTime>0,attackType:p.lastAttack,attackProgress:1-p.attackTime/.3,animation:p.grounded?Math.abs(p.vx)>10?'run':'idle':p.vy<0?'jump':'fall'});else{rect(c,x-10,y-49,20,35,'#d7924f');rect(c,x-15,y-57,30,7,'#dec28b');rect(c,x-8,y-14,6,14,'#31465a');rect(c,x+3,y-14,6,14,'#31465a');}c.restore();
 }
 function transitionPilot(c,s){
  const q=clamp(s.stageTime/2.05,0,1),from=s.transitionStart||{x:196,y:320,mode:'car'},park=s.parkedCar;
  if(s.mode==='platform'){
   skyPlatforms(c,s,smooth(q/.6));if(q<.48){const k=smooth(q/.48);pilot(c,mix(from.x,park.x,k),mix(from.y,park.y-10,k),s.time,{trained:s.options.trained});}
   else{parkedVehicle(c,s);const k=smooth((q-.48)/.52);onFoot(c,s,mix(park.x+8,s.player.x,k),mix(park.y-17,s.player.y,k)-Math.sin(k*Math.PI)*34);}
  }else{
   skyPlatforms(c,s,1-smooth((q-.52)/.48));if(q<.5){const k=smooth(q/.5);parkedVehicle(c,s,1-k);const carX=mix(park.x,from.x,k),carY=mix(park.y-10,from.y-25,k);pilot(c,carX,carY,s.time,{trained:s.options.trained});onFoot(c,s,from.x,from.y-k*20,1-k);}
   else{const k=smooth((q-.5)/.5);pilot(c,mix(from.x,s.player.x,k),mix(from.y-25,s.player.y,k),s.time,{trained:s.options.trained,dash:true});}
  }
 }
 function draw(c,s,options={}){
  if(!s)return;if(s.stage==='intro'){drawIntro(c,s.stageTime,s.options);return;}
  c.save();c.imageSmoothingEnabled=false;sky(c,s.time,s.phase);
  if(s.shake>0){const a=s.shake/7;c.translate(Math.sin(s.time*55)*a*2,Math.cos(s.time*43)*a*1.6);}
  if(s.stage!=='transition'&&s.mode==='platform'){skyPlatforms(c,s);parkedVehicle(c,s);}
  for(const h of s.hazards)hazardDraw(c,h,s.time);
  const b=s.boss,p=s.player,scale=1.37+(s.phase-1)*.09,aura=s.phase===3?'#bda7e2':s.phase===2?'#9acbdf':null;
  window.BailePixel?.antesChefe?.(c,s);
  if(s.stage==='victory'){drawOllyan(c,b.x,b.y+63,s.time,{scale:1.23,flying:true,angle:Math.sin(s.stageTime*5)*.25,cup:false});for(let i=0;i<14;i++){const q=(s.stageTime*.5+i*.11)%1;rect(c,b.x+Math.sin(i*2.2)*q*150,b.y-100+q*180,4,4,['#e4cb8d','#bddecb','#c4b4df'][i%3]);}}
  else drawOllyan(c,b.x,b.y+63,s.time,{scale,flying:true,fast:b.state==='windup'||s.phase===3,hit:b.hit>0,aura,angle:b.state==='swoop'?Math.sin(s.time*8)*.13:0});
  for(const a of s.shots)drawProjectile(c,a,s.time);if(s.stage==='transition')transitionPilot(c,s);else if(s.mode==='platform')onFoot(c,s);else pilot(c,p.x,p.y,s.time,{angle:p.tilt,inv:p.inv,dash:p.dash>0,trained:s.options.trained});
  for(const part of s.particles){c.save();c.globalAlpha=clamp(part.life/part.maxLife,0,1);rect(c,part.x,part.y,part.size,part.size,part.color);c.restore();}
  c.restore();
  if(options.hud!==false){rect(c,222,31,516,23,'#152139db');text(c,'OLLYAN',236,42,10,'#eedcb5','left');rect(c,326,37,394,8,'#3b3c58');rect(c,326,37,394*b.hp/b.max,8,s.phase===3?'#bd91db':s.phase===2?'#9acdd5':'#e0bb8e');text(c,s.phase+'/3',744,42,10,'#e5d5e5');}
  if(s.stage==='transition'){
   const alpha=smooth(Math.min(s.stageTime/.25,(2.05-s.stageTime)/.25));c.save();c.globalAlpha=alpha;rect(c,177,215,606,91,'#17223ee8');rect(c,181,219,598,2,'#cdb3dc');text(c,'FASE '+s.phase+' / 3',480,239,12,'#edce9a');text(c,phases[s.phase-1].name,480,270,21,'#e2d3ee');text(c,s.mode==='platform'?'SAIA DO CARRO · ANDE E PULE PELAS NUVENS':'VOLTE AO CARRO A GÁS · O CÉU É SEU',480,296,10,'#cce8de');c.restore();
  }else if(s.stage==='fight'&&b.state==='windup'){
   const title=attackNames[b.attack];rect(c,480-title.length*3.9,66,title.length*7.8,22,'#142440c9');text(c,title,480,77,11,b.attack==='moonBeam'?'#f6cbab':'#d5e6d5');
   if(!window.BailePixel?.telegrafa?.(c,s)){if(b.attack==='swoop'){c.save();c.globalAlpha=.35;line(c,[[b.x,b.y],[b.targetX,b.targetY]],'#eacfa2',22);c.restore();oval(c,b.targetX,b.targetY,19,19,'#f1d19844');line(c,[[b.targetX-14,b.targetY],[b.targetX+14,b.targetY]],'#edc995',2);}
   if(b.attack==='moonBeam'){const dx=b.targetX-b.x,dy=b.targetY-b.y,len=Math.hypot(dx,dy)||1;c.save();c.setLineDash([11,8]);line(c,[[b.x,b.y],[b.x+dx/len*1200,b.y+dy/len*1200]],'#e5bfa2',2);c.restore();}}
  }
  if(s.stage==='fight'&&(s.time<15||s.mode==='platform')){text(c,s.mode==='platform'?'A / D OU JOYSTICK: ANDAR · ESPAÇO / PULAR: SALTAR · PAPEL / PEIDO / DASH':'VOE EM TODAS AS DIREÇÕES · PAPEL / PEIDO / DASH',480,508,10,'#d2d0df');}
  if(s.stage==='victory'){text(c,'O CÉU FICOU PEQUENO PRA ESSA ORELHA!',480,144,20,'#f5d99b');text(c,'Ollyan: tá bom, véi… agora eu vou de carona.',480,173,12,'#e8d9df');}
  if(s.stage==='defeat'){rect(c,0,0,W,H,'#101b3566');text(c,'O MOTOR PERDEU O FÔLEGO…',480,239,22,'#e8ccd9');text(c,'Invista nos atributos e tente outra rota entre as rajadas.',480,273,12,'#d2d9e4');}
 }
 window.BaileWorld=Object.freeze({version:1,draw:world,drawOllyan,getLength:()=>LENGTH,getCrowdCount:()=>232,getNPC:()=>({id:'ollyan',name:'Ollyan · Orelhas ao Vento',scene:11,x:NPC_X,y:FLOOR}),drawForeground:()=>{}});
 window.OllyanEncounter=Object.freeze({version:1,create,update,draw,attack,advance,cancel,retreat:cancel,setPlayer,setBonuses,getStatus,getAudioState,drainEvents,isDone:s=>!!s?.done,previewTimeline,getIntroTimeline:previewTimeline,drawIntro,renderIntro,phases});
})();
