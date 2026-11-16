/* Original pixel scenery and sprite animation for Da Roça Adventure. */
(() => {
  'use strict';
  const P = {ink:'#342d2b', earth:'#8f573d', dark:'#243c33', moss:'#3d6540', leaf:'#658746', lime:'#a5b952', cream:'#f4d49a', sun:'#ffdf94', clay:'#bd6244', teal:'#365e62'};
  const hash = (i) => {const x=Math.sin(i*127.1+311.7)*43758.5453;return x-Math.floor(x);};
  const heroFrameCatalog=Object.freeze({idle:4,walk:12,jump:3,fall:3,land:3,dash:4,paper:6,fart:6,flight:4});
  const worldWidth=(scene)=>Number(window.WorldData?.widths?.[scene])||[4800,6200,5000,5200,6000,7200,6600,4800,3600,4200,3600,4800][scene]||4800;
  const r = (c,x,y,w,h,color) => {c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.ceil(w),Math.ceil(h));};
  function poly(c, points, color) {c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(p[0],p[1]):c.moveTo(p[0],p[1]));c.closePath();c.fill();}
  function oval(c,x,y,rx,ry,color,p=3) {for(let yy=-ry;yy<ry;yy+=p){const ww=Math.sqrt(Math.max(0,1-(yy/ry)*(yy/ry)))*rx;r(c,x-ww,y+yy,ww*2,p,color);}}
  function cloud(c,x,y,s=1,color='#fffef4') {r(c,x+3*s,y+15*s,66*s,15*s,'#b9d3e366');r(c,x,y+12*s,66*s,15*s,color);r(c,x+12*s,y+4*s,38*s,24*s,color);r(c,x+21*s,y-3*s,22*s,29*s,color);r(c,x-8*s,y+17*s,85*s,7*s,color);r(c,x+4*s,y+28*s,56*s,3*s,'#d8e7e9');r(c,x-6*s,y+20*s,81*s,4*s,'#e3edf1');r(c,x+22*s,y-2*s,14*s,3*s,'#ffffff');r(c,x+14*s,y+5*s,10*s,2*s,'#ffffff');}
  function steppedHill(c,x,y,w,h,color) {poly(c,[[x,y+h],[x,y+75],[x+w*.09,y+75],[x+w*.09,y+55],[x+w*.21,y+55],[x+w*.21,y+31],[x+w*.35,y+31],[x+w*.35,y+12],[x+w*.48,y+12],[x+w*.48,y],[x+w*.6,y],[x+w*.6,y+16],[x+w*.73,y+16],[x+w*.73,y+39],[x+w*.85,y+39],[x+w*.85,y+66],[x+w,y+66],[x+w,y+h]],color);}
  /* Scenery remaster: cached, ordered-dither (Bayer 4x4) light and depth layers.
     Only paints scenery; collisions, platforms and characters are untouched. */
  let animT=0,animCam=0;
  const windAt=(screenX)=>{const x=screenX+animCam,g=.55+.45*Math.sin(animT*.31);return(Math.sin(animT*1.15+x*.0042)*.62+Math.sin(animT*2.4+x*.013)*.38)*g;};
  const screenX=(c,x)=>{try{const m=c.getTransform();return m.e/(m.a||1)+x;}catch(e){return x;}};
  const BAYER=[0,8,2,10,12,4,14,6,3,11,1,9,15,7,13,5];
  const remasterCache=new Map();
  const hex=(h)=>{const n=parseInt(h.slice(1),16);return[(n>>16)&255,(n>>8)&255,n&255];};
  function cachedLayer(key,w,h,paint){let layer=remasterCache.get(key);if(layer)return layer;layer=document.createElement('canvas');layer.width=w;layer.height=h;const x=layer.getContext('2d');x.imageSmoothingEnabled=false;paint(x,w,h);remasterCache.set(key,layer);return layer;}
  // Paints a vertical palette ramp at 1/px resolution so each dither cell is a crisp px*px block.
  function ditherRamp(key,w,h,stops,px=2){
    return cachedLayer(key,w,h,(x)=>{const lw=Math.ceil(w/px),lh=Math.ceil(h/px),small=document.createElement('canvas');small.width=lw;small.height=lh;const sc=small.getContext('2d'),img=sc.createImageData(lw,lh),cols=stops.map(hex),n=cols.length-1;
      for(let yy=0;yy<lh;yy++){const f=yy/(lh-1)*n,i=Math.min(n-1,Math.floor(f)),frac=f-i;for(let xx=0;xx<lw;xx++){const pick=frac*16>BAYER[(yy&3)*4+(xx&3)]+.5?cols[i+1]:cols[i],o=(yy*lw+xx)*4;img.data[o]=pick[0];img.data[o+1]=pick[1];img.data[o+2]=pick[2];img.data[o+3]=255;}}
      sc.putImageData(img,0,0);x.drawImage(small,0,0,lw*px,lh*px);});
  }
  // Alpha ramp of a single colour (shadows, haze, light) using the same ordered dither.
  function ditherShade(key,w,h,color,alphaAt,px=2){
    return cachedLayer(key,w,h,(x)=>{const lw=Math.ceil(w/px),lh=Math.ceil(h/px),small=document.createElement('canvas');small.width=lw;small.height=lh;const sc=small.getContext('2d'),img=sc.createImageData(lw,lh),col=hex(color);
      for(let yy=0;yy<lh;yy++)for(let xx=0;xx<lw;xx++){const a=Math.max(0,Math.min(1,alphaAt(xx/(lw-1),yy/(lh-1)))),steps=a*4,base=Math.floor(steps),on=(steps-base)*16>BAYER[(yy&3)*4+(xx&3)]+.5?base+1:base,o=(yy*lw+xx)*4;img.data[o]=col[0];img.data[o+1]=col[1];img.data[o+2]=col[2];img.data[o+3]=Math.round(on/4*255);}
      sc.putImageData(img,0,0);x.drawImage(small,0,0,lw*px,lh*px);});
  }
  const SKIES={
    day:['#2f7cc8','#4a95d9','#68abe3','#8cc1ea','#b0d5ee','#d4e8ec','#ecefdc'],
    afternoon:['#3a6fb4','#5b8cc8','#83a9d6','#aec4d9','#d4d6cc','#efdcb6'],
    golden:['#35609f','#5a82bd','#8ea4c8','#c7b9bd','#ecc49b','#f7d79a'],
    plaza:['#2e86c9','#4f9fdb','#77b8e6','#a2d0ee','#cfe6ee','#eef2e2']
  };
  const skyFor=(scene)=>scene===3?'afternoon':scene===5?'golden':scene===4?'plaza':'day';
  function farRange(scene){
    const mood=skyFor(scene),far=mood==='golden'?'#8a84a8':mood==='afternoon'?'#7d98bb':'#78a3c6',near=mood==='golden'?'#6f6b92':mood==='afternoon'?'#64819f':'#5f8fb3',snow=mood==='golden'?'#f0c9b0':'#e6f0f4';
    return cachedLayer('range-'+mood,1920,190,(x)=>{
      for(const [col,amp,base,seed] of [[far,70,40,3],[near,48,92,9]]){x.fillStyle=col;let h=base;for(let xx=0;xx<1920;xx+=6){const n=Math.sin((xx+seed*91)/151)*.55+Math.sin((xx+seed*37)/67)*.3+Math.sin((xx+seed*13)/29)*.15;h=Math.round((base+amp*(.5-n*.5))/3)*3;x.fillRect(xx,h,6,190-h);if(col===far&&h<base+8){x.fillStyle=snow;x.fillRect(xx,h,6,3);x.fillStyle=col;}}}
      // Atmospheric haze fades the foot of the range into the horizon.
      x.drawImage(ditherShade('haze-'+mood,1920,190,mood==='golden'?'#f2d3a8':'#e4eef0',(u,v)=>v<.35?0:Math.pow((v-.35)/.65,1.4)*.7,2),0,0);
    });
  }
  function sunGlow(c,x,y,warm){
    const glow=cachedLayer('sun-'+(warm?'w':'d'),340,340,(g)=>{const gr=g.createRadialGradient(170,170,10,170,170,170);gr.addColorStop(0,warm?'rgba(255,214,150,.55)':'rgba(255,248,214,.5)');gr.addColorStop(.35,warm?'rgba(255,200,140,.18)':'rgba(255,250,224,.16)');gr.addColorStop(1,'rgba(255,250,224,0)');g.fillStyle=gr;g.fillRect(0,0,340,340);for(let i=0;i<3;i++){g.globalAlpha=.16-i*.04;oval(g,170,170,46+i*12,46+i*12,warm?'#ffe0b0':'#fff7da',3);}});
    c.drawImage(glow,Math.round(x-170),Math.round(y-170));
  }

  const OUTDOOR=new Set([0,1,3,4,5,7,9]);
  function lightPass(c,scene,camera,t){
    const outdoor=OUTDOOR.has(scene),ink=scene===6,mood=skyFor(scene);
    c.drawImage(cachedLayer('overlay-'+(ink?'ink':outdoor?'out':'in'),960,540,(x)=>{
      const g=x.createLinearGradient(0,412,0,442);g.addColorStop(0,'rgba(20,16,12,0)');g.addColorStop(1,'rgba(20,16,12,.28)');x.fillStyle=g;x.fillRect(0,412,960,30);
      const d=x.createLinearGradient(0,452,0,540);d.addColorStop(0,'rgba(20,14,10,0)');d.addColorStop(1,ink?'rgba(20,10,40,.45)':'rgba(20,14,10,.42)');x.fillStyle=d;x.fillRect(0,452,960,88);
      if(!outdoor){x.fillStyle=ink?'rgba(40,20,70,.12)':'rgba(40,34,28,.1)';x.fillRect(0,0,960,540);}
      const v=x.createRadialGradient(480,300,180,480,300,620);v.addColorStop(0,'rgba(12,16,14,0)');v.addColorStop(1,ink?'rgba(20,10,38,.5)':outdoor?'rgba(12,16,14,.32)':'rgba(12,16,14,.42)');x.fillStyle=v;x.fillRect(0,0,960,540);
    }),0,0);
    if(outdoor){
      // Slow god-rays from the sun side, warm in the late scenes.
      const warm=mood!=='day'&&mood!=='plaza';c.save();
      for(let i=0;i<4;i++){const sway=Math.sin(t*.25+i*1.7)*18,x0=620+i*70+sway-camera*.02%60,a=warm?.07:.055;c.fillStyle=warm?`rgba(255,206,140,${a})`:`rgba(255,250,215,${a})`;c.beginPath();c.moveTo(x0,0);c.lineTo(x0+60+i*10,0);c.lineTo(x0-260+i*40,440);c.lineTo(x0-380+i*30,440);c.closePath();c.fill();}
      c.restore();
      c.save();for(let i=0;i<18;i++){const life=(animT*.05+hash(i+300))%1,bx=560+hash(i+310)*330-life*170+Math.sin(animT*.9+i)*9,by=40+hash(i+320)*360-life*60,tw=.35+.35*Math.sin(animT*3+i*2.1);c.globalAlpha=tw*(1-Math.abs(life-.5)*2);r(c,bx-(bx>740?0:0),by,2,2,warm?'#ffe2b0':'#fffbe2');}c.restore();
      c.save();for(let i=0;i<3;i++){const span=2200,cx=((i*760+t*16-camera*.85)%span+span)%span-500,w=260+hash(i+400)*160;c.drawImage(cachedLayer('cloud-shadow',256,256,(x)=>{const g=x.createRadialGradient(128,128,4,128,128,128);g.addColorStop(0,'rgba(60,70,90,.16)');g.addColorStop(1,'rgba(60,70,90,0)');x.fillStyle=g;x.fillRect(0,0,256,256);}),cx-w,470-w*.32,w*2,w*.64);}c.restore();
      if(warm){c.save();c.globalCompositeOperation='soft-light';c.fillStyle=mood==='golden'?'rgba(255,170,90,.32)':'rgba(255,200,130,.22)';c.fillRect(0,0,960,440);c.restore();}
    }
  }

  function sky(c,scene,camera,t) {
    if(scene===2||scene===6||scene===8||scene===10){r(c,0,0,960,440,'#c9e7ec');return;}
    const mood=skyFor(scene);c.drawImage(ditherRamp('sky-'+mood,960,440,SKIES[mood],2),0,0);
    const sx=scene===3?762:734;sunGlow(c,sx-camera*.025,99,mood==='golden'||mood==='afternoon');
    {const range=farRange(scene),off=((camera*.05)%960+960)%960;c.drawImage(range,-off,150);c.drawImage(range,960-off,150);}oval(c,sx-camera*.025,99,35,35,scene===3?'#fff0c4':'#fff6cc',4);
    for(let i=-1;i<6;i++){const x=((i*283+t*5+1800)%1800)-283-camera*.09;cloud(c,x,50+hash(i+10)*95,.8+hash(i)*.6,'#fffef5');}
    for(let i=-2;i<7;i++)steppedHill(c,i*318-camera*.12,197+hash(i+5)*34,422,250,scene===3?'#7eada0':'#89b7a0');
    for(let i=-2;i<8;i++)steppedHill(c,i*289-camera*.25,271+hash(i+21)*25,400,190,scene===3?'#5b937b':'#64a068');
    for(let i=0;i<7;i++){let x=((i*179-camera*.16+t*15)%1200+1200)%1200-80;let y=90+hash(i+77)*80;const flap=Math.round(Math.sin(t*9+i)*3);r(c,x,y,3,2,'#4b6b73');r(c,x-4,y-2+flap,4,2,'#4b6b73');r(c,x+3,y-2+flap,4,2,'#4b6b73');}
  }
  function tree(c,x,y,s=1,kind=0) {
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);
    if(kind===1){
      poly(c,[[-5,0],[5,0],[12,-83],[2,-83]],'#79553b');r(c,4,-78,6,28,'#98704b');
      {const sw=Math.round(windAt(screenX(c,0))*2.2);c.translate(sw,Math.abs(sw)>1?1:0);}for(let i=0;i<7;i++){const a=-Math.PI+i*.48+Math.sin(animT*1.7+i)*.03;const ex=Math.cos(a)*61,ey=-97+Math.sin(a)*27;poly(c,[[7,-84],[ex,ey],[ex+13,ey+12],[15,-75]],i%2?'#367c42':'#64a147');}
      r(c,-4,-91,13,11,'#334f36');r(c,6,-86,9,10,'#817744');
    }else{
      r(c,-8,-104,17,104,'#674c36');r(c,2,-91,7,91,'#896241');r(c,-17,-62,13,10,'#674c36');r(c,-22,-80,7,25,'#674c36');r(c,7,-78,18,8,'#674c36');r(c,21,-100,7,25,'#674c36');
      {const sw=Math.round(windAt(screenX(c,0))*1.6);c.translate(sw,0);}oval(c,0,-127,64,51,'#285a38',4);oval(c,-27,-122,45,35,'#3b7c43',4);oval(c,26,-141,47,35,'#4c8b43',4);oval(c,-5,-160,40,23,'#6ba346',4);oval(c,-35,-145,24,21,'#88b54e',4);
      for(let i=0;i<35;i++){const xx=(hash(i+6)-.5)*103,yy=-169+hash(i+30)*67;r(c,xx,yy,6+hash(i)*8,3,i%3?'#7fac42':'#2c633b');}
      for(let i=0;i<6;i++)r(c,(hash(i+93)-.5)*85,-147+hash(i+6)*53,5,5,'#c9924e');
    }c.restore();
  }
  function bush(c,x,y,w=46,color='#4e7440') {oval(c,x,y-10,w/2,18,'#344e37',3);oval(c,x-5,y-17,w/2-4,16,color,3);for(let i=0;i<6;i++)r(c,x-w/2+hash(i+2)*w,y-28+hash(i+3)*20,5,3,'#86a153');}
  function fence(c,x,y,w) {r(c,x,y-32,w,7,'#6c6945');r(c,x,y-16,w,6,'#6c6945');r(c,x,y-33,w,3,'#b7ab70');for(let xx=x;xx<x+w;xx+=33){r(c,xx,y-47,8,47,'#756c48');r(c,xx,y-49,7,4,'#c1ae76');r(c,xx+2,y-45,2,39,'#a38e5e');}}
  function grass(c,x,y,seed=1) {const w=windAt(screenX(c,x));for(let i=0;i<5;i++){const xx=x+i*4,h=5+hash(i+seed)*8,col=i%2?'#7dad42':'#3e863d',lean=Math.round(w*(1.4+h*.18)+Math.sin(animT*3.1+i+seed)*.4);r(c,xx,y-h*.5+1,3,h*.5,col);r(c,xx+Math.round(lean*.5),y-h*.75+1,3,h*.3,col);r(c,xx+lean,y-h-hash(i+seed)*1+1,2,h*.3,i%2?'#a6c95a':'#58a046');}}
  function flower(c,x,y,col='#f1c966'){const w=Math.round(windAt(screenX(c,x))*2);r(c,x,y-5,2,7,'#456841');r(c,x+Math.round(w/2),y-11,2,7,'#456841');r(c,x-3+w,y-13,8,4,col);r(c,x-1+w,y-15,4,8,col);r(c,x+w,y-12,2,2,'#ad6c3e');}
  function house(c,x,y) {
    r(c,x-6,y-101,194,101,'#795846');r(c,x,y-112,182,112,'#efd5a0');r(c,x,y-27,182,27,'#d1ad79');r(c,x+8,y-105,166,5,'#fff0bd');
    // Overlapping terracotta roof tiles.
    poly(c,[[x-19,y-110],[x+16,y-154],[x+152,y-154],[x+202,y-110]],'#653e36');
    for(let row=0;row<4;row++){let start=x+15-row*10,end=x+151+row*13,yy=y-150+row*10;r(c,start,yy,end-start,9,row%2?'#c96545':'#d9774d');for(let xx=start;xx<end;xx+=22)r(c,xx,yy,2,8,'#f0a56d');r(c,start,yy+8,end-start,2,'#8f4739');}
    r(c,x-22,y-114,228,8,'#7b4737');r(c,x-18,y-114,221,3,'#d18b59');
    r(c,x+74,y-71,39,71,'#886641');r(c,x+79,y-66,29,66,'#5c5140');r(c,x+82,y-63,23,62,'#655d49');r(c,x+100,y-32,4,4,'#e4ba73');
    for(let xx of [x+15,x+132]){r(c,xx,y-81,38,39,'#ac7c52');r(c,xx+4,y-77,30,31,'#536a62');r(c,xx+6,y-74,12,12,'#8ba397');r(c,xx+20,y-59,10,10,'#6e8b7f');r(c,xx+16,y-77,3,31,'#c19969');r(c,xx+4,y-63,30,3,'#c19969');r(c,xx-4,y-40,46,5,'#b68657');}
    r(c,x+65,y-2,57,5,'#bba27a');r(c,x+62,y+3,63,5,'#d5bc86');
    // Small porch planter.
    r(c,x+145,y-10,23,13,'#b05e40');r(c,x+142,y-15,29,6,'#cf8253');grass(c,x+145,y-15,4);flower(c,x+153,y-26,'#e7ae62');
    r(c,x+24,y-128,50,13,'#573c31');c.fillStyle='#f3d595';c.font='bold 8px monospace';c.fillText('DO SAPO',x+29,y-118);
    r(c,x+153,y-175,17,27,'#9a6647');r(c,x+150,y-177,23,6,'#bf9367');
  }
  function ground(c,camera,scene) {
    const farm=scene===0, gym=scene===2;
    if(scene>=4){const palettes={4:['#aeb8b5','#e0ded0','#899c9b'],5:['#887f7a','#a6a49a','#625c5c'],6:['#6b577e','#d9c4df','#4d3c64'],7:['#448646','#a9cc70','#2e623c'],8:['#af9576','#f6dec0','#725b4a'],9:['#c3ccca','#f2f3df','#9aaeb0'],10:['#ab805b','#f0d9b0','#856747']},p=palettes[scene]||palettes[4];r(c,0,440,960,100,p[0]);r(c,0,440,960,6,p[1]);for(let i=Math.floor(camera/53);i<(camera+960)/53;i++){let x=i*53-camera;r(c,x,449,1,91,p[2]);r(c,x+5,468+hash(i)*52,22,2,p[2]);if(scene===7)grass(c,x+15,450,i);}r(c,0,498,960,1,p[2]);return;}
    r(c,0,440,960,100,farm?'#a17349':gym?'#554b48':'#97856e');
    if(farm){r(c,0,440,960,9,'#3f7f35');r(c,0,440,960,4,'#9fc84d');r(c,0,449,960,7,'#736a3a');for(let i=Math.floor(camera/17);i<(camera+960)/17;i++){let x=i*17-camera;r(c,x,451+hash(i)*5,7,4,'#b68b54');}}
    else {r(c,0,440,960,7,gym?'#8f8170':'#c4b08a');r(c,0,447,960,4,'#655c4d');}
    for(let i=Math.floor(camera/23);i<(camera+960)/23;i++){const x=i*23-camera;const y=460+hash(i+4)*75;r(c,x,y,3+hash(i+5)*10,3,scene===2?'#655956':farm?'#bb8c56':'#a8977b');if(i%3===0)r(c,x+8,y+8,3,3,'#756342');}
    if(!farm){for(let x=-camera%96;x<960;x+=96)r(c,x,452,1,88,scene===2?'#4c4240':'#817460');r(c,0,498,960,1,scene===2?'#4c4240':'#817460');}
  }
  function farm(c,camera,t) {
    c.save();c.translate(-Math.round(camera),0);
    // Foreground farmland is deliberately readable beneath the player.
    r(c,0,368,worldWidth(0),72,'#68a34b');r(c,0,387,worldWidth(0),53,'#80b751');
    fence(c,0,423,112);fence(c,332,423,315);fence(c,786,423,214);fence(c,1080,423,420);fence(c,1570,423,680);
    tree(c,53,425,1.25);tree(c,535,424,.78,1);tree(c,795,425,1.12);tree(c,1390,427,1.2,1);tree(c,1810,428,1.2);tree(c,2440,430,1.3);
    house(c,132,429);
    // Laundry line and garden.
    r(c,350,363,5,63,'#79664a');r(c,487,357,5,69,'#79664a');r(c,351,364,139,2,'#706246');for(let i=0;i<4;i++){const x=366+i*29,wave=Math.round(Math.sin(t*3+i)*4);poly(c,[[x,365],[x+20,365],[x+23+wave,389],[x-2+wave,389]],['#f0c27c','#74afb9','#d57555','#f2dda2'][i]);r(c,x+2,365,2,4,'#5e6141');}
    for(let i=0;i<22;i++){const x=935+i*17;const yy=422+(i%2)*8,wave=Math.round(Math.sin(t*2+i*.2)*2);r(c,x,yy-36,3,36,'#497f38');poly(c,[[x,yy-18],[x-12+wave,yy-29],[x-16+wave,yy-26],[x,yy-9]],'#438a39');poly(c,[[x+2,yy-23],[x+13+wave,yy-35],[x+17+wave,yy-29],[x+3,yy-15]],'#8bbb42');r(c,x-2,yy-34,7,17,'#e7c94c');r(c,x-1,yy-37,4,5,'#ffe17a');r(c,x,yy-31,2,11,'#f6df69');}
    r(c,1970,400,155,39,'#665b3e');for(let i=0;i<6;i++){r(c,1974+i*25,404,19,33,'#a27a49');r(c,1974+i*25,408,19,2,'#d3a960');}r(c,1967,396,161,7,'#d0a96c');
    // Signpost: a road out of the village.
    r(c,660,375,7,65,'#6a583d');r(c,627,370,79,23,'#72543b');r(c,630,372,73,17,'#c6ab70');c.fillStyle='#4c4c36';c.font='bold 10px monospace';c.fillText('ITABUNA →',632,384);
    for(let i=0;i<75;i++){const x=hash(i+67)*2600;const y=426+hash(i+44)*12;if(x>115&&x<330)continue;grass(c,x,y,i);if(i%5===0)flower(c,x+5,y,['#efcf71','#e3a67d','#f4df9a'][i%3]);}
    // Butterflies, with changing wing widths, wander above the living garden.
    for(let i=0;i<8;i++){const x=390+i*280+Math.sin(t*.8+i)*27,y=351+Math.sin(t*1.6+i*3)*17,w=Math.abs(Math.sin(t*9+i))*4+1;r(c,x-w-1,y-2,w,4,i%2?'#f0ce60':'#e9a66d');r(c,x+1,y-2,w,4,i%2?'#ffe5a1':'#f5bf8c');r(c,x,y-2,1,5,'#4b6240');}
    c.restore();
  }
  function school(c,camera,t) {
    c.save();c.translate(-Math.round(camera),0);r(c,0,392,worldWidth(1),48,'#b6b18a');
    // Repeating long school facade.
    r(c,90,225,1760,215,'#173755');r(c,100,222,1740,207,'#eef3f4');r(c,90,215,1760,14,'#183a5e');r(c,100,229,1740,8,'#ffffff');r(c,100,368,1740,60,'#244a70');r(c,100,368,1740,5,'#132d4a');
    for(let i=0;i<12;i++){const x=140+i*137;r(c,x,267,83,78,'#466c86');r(c,x+5,272,73,68,'#415e60');r(c,x+8,275,31,29,'#8faaa0');r(c,x+45,309,29,27,'#688b83');r(c,x+39,272,5,68,'#d7e7ec');r(c,x+5,304,73,5,'#d7e7ec');r(c,x-3,345,89,7,'#c7d9e0');}
    r(c,343,293,75,135,'#8f7657');r(c,349,298,63,130,'#526661');r(c,354,304,22,85,'#6e8980');r(c,382,304,23,85,'#5e7770');r(c,378,297,5,131,'#b49d75');r(c,371,362,4,4,'#efd49a');
    r(c,278,243,209,29,'#183c62');c.fillStyle='#f8fbfc';c.font='bold 15px monospace';c.fillText('COLÉGIO ADVENTISTA',291,263);r(c,280,272,205,3,'#7fb4cf');
    for(let x=120;x<1840;x+=275){r(c,x,237,12,192,'#b3cbd8');r(c,x+2,237,3,191,'#f9fcff');}
    // Mural and a very talkative wall.
    r(c,1885,280,423,153,'#d3c69a');r(c,1885,280,423,8,'#867b5e');for(let j=0;j<4;j++)for(let i=0;i<8;i++)r(c,1892+i*51+(j%2)*23,294+j*33,42,1,'#b7a981');
    c.fillStyle='#52766b';c.font='bold 24px monospace';c.fillText('BEM-VINDOS',1957,345);c.fillStyle='#b27857';c.font='bold 11px monospace';c.fillText('AQUI ATÉ A PAREDE TEM HISTÓRIA.',1923,370);
    for(let i=0;i<7;i++){const x=620+i*210;r(c,x,409,68,9,'#7a6148');r(c,x+6,417,7,23,'#58604b');r(c,x+54,417,7,23,'#58604b');r(c,x,386,68,7,'#a58859');r(c,x,398,68,7,'#a58859');r(c,x+5,387,5,24,'#6b6248');r(c,x+58,387,5,24,'#6b6248');}
    // Ravid's very real conversation partner, beside his usual spot at x930.
    r(c,976,311,29,122,'#b9aa85');r(c,976,311,8,122,'#f0dfb0');r(c,984,317,20,111,'#dcc99b');r(c,974,307,34,8,'#8f8c70');r(c,976,398,29,35,'#ad7153');r(c,986,326,11,1,'#b6a67f');r(c,986,350,11,1,'#b6a67f');r(c,986,375,11,1,'#b6a67f');
    r(c,1012,322,108,59,'#6f8a72');r(c,1016,326,100,51,'#e2d9ae');c.fillStyle='#54735f';c.font='bold 8px monospace';c.fillText('A PAREDE ESCUTA',1022,341);c.fillText('MAIS DO QUE FALA.',1020,355);r(c,1059,361,10,2,'#8c9b6b');
    tree(c,40,435,.9);tree(c,2380,435,1.1);bush(c,2320,435,90);bush(c,65,435,56);r(c,1665,399,27,38,'#54735b');r(c,1661,394,35,8,'#73906a');r(c,1669,405,3,26,'#a3ad79');
    c.restore();
  }
  function gym(c,camera,t) {
    // Indoor gym, warm tungsten light and teal walls.
    r(c,0,0,960,440,'#3f5654');r(c,0,0,960,28,'#293e3e');r(c,0,28,960,8,'#71806c');
    c.save();c.translate(-Math.round(camera),0);
    for(let i=0;i<Math.ceil(worldWidth(2)/280);i++){const x=i*280+46;r(c,x,65,176,181,'#2a4141');r(c,x+6,71,164,168,'#d4be8f');r(c,x+12,78,152,154,'#9da98b');r(c,x+83,73,6,164,'#536b61');r(c,x+7,148,164,6,'#536b61');r(c,x+12,77,63,62,'#dbd19f');r(c,x+95,156,65,70,'#829b82');
      r(c,x+52,27,3,24,'#272f30');r(c,x+28,50,55,7,'#e1c78c');r(c,x+34,57,43,5,'#ffe5a1');
    }
    r(c,0,268,worldWidth(2),172,'#546960');r(c,0,268,worldWidth(2),7,'#a19874');r(c,0,415,worldWidth(2),25,'#30463e');
    // Mirrors, racks, plates, benches, bags.
    for(let i=0;i<Math.ceil(worldWidth(2)/565);i++){const x=90+i*565;r(c,x,290,168,97,'#879c8a');r(c,x+5,295,158,87,'#6d8580');r(c,x+8,298,71,81,'#78958c');poly(c,[[x+18,376],[x+81,300],[x+106,300],[x+41,376]],'#8aa699');r(c,x+81,294,4,89,'#a6af98');
      r(c,x-12,369,6,71,'#263d3b');r(c,x+176,369,6,71,'#263d3b');r(c,x-15,376,200,5,'#a6aba0');r(c,x-19,365,12,28,'#283b3a');r(c,x+174,365,12,28,'#283b3a');r(c,x-24,369,7,20,'#75897c');r(c,x+185,369,7,20,'#75897c');r(c,x+25,413,106,9,'#a56d48');r(c,x+30,423,7,17,'#293e3b');r(c,x+119,423,7,17,'#293e3b');
    }
    for(let i=0;i<Math.ceil(worldWidth(2)/790);i++){const x=450+i*790;const swing=Math.sin(t*1.5+i)*3;r(c,x+18,95,3,188,'#a6a18a');r(c,x+3+swing,282,36,96,'#392f2c');r(c,x+6+swing,285,30,88,'#a95f48');r(c,x+11+swing,290,5,75,'#c37a55');r(c,x+5+swing,302,32,7,'#7c493b');r(c,x+5+swing,352,32,6,'#7c493b');r(c,x+9+swing,374,23,5,'#2a3c35');}
    r(c,745,299,240,36,'#2c4440');c.fillStyle='#e6cc8d';c.font='bold 19px monospace';c.fillText('CALEB — SEM DESCULPA',754,324);
    for(let i=0;i<6;i++){const x=1060+i*45;r(c,x,409,33,5,'#9eac92');r(c,x+11,402,8,8,'#526b5f');r(c,x+2,394,8,22,'#233f3b');r(c,x+23,394,8,22,'#233f3b');}
    for(let i=0;i<Math.ceil(worldWidth(2)/790);i++){
      const fx=347+i*790,fy=113,angle=t*9+i;c.save();c.translate(fx,fy);r(c,-2,-79,4,77,'#314644');
      for(let blade=0;blade<3;blade++){const a=angle+blade*Math.PI*2/3,dx=Math.cos(a),dy=Math.sin(a)*.34;poly(c,[[dx*4-dy*5,dy*4+dx*3],[dx*42-dy*5,dy*42+dx*5],[dx*43+dy*5,dy*43-dx*5],[dx*8+dy*5,dy*8-dx*3]],'#a8b6a0');}
      oval(c,0,0,7,5,'#405951',2);r(c,-2,-3,4,3,'#d6cfaa');c.restore();
    }
    // A cable machine's stack travels as a quiet background exercise loop.
    r(c,1597,276,7,164,'#263f3b');r(c,1666,276,7,164,'#263f3b');r(c,1597,276,76,6,'#a4ad96');r(c,1632,282,2,79,'#b6baa5');const lift=Math.round((1+Math.sin(t*1.8))*7);for(let j=0;j<5;j++){r(c,1610,371+j*9-lift,48,7,'#334a43');r(c,1613,372+j*9-lift,41,2,'#738773');}
    c.restore();
  }
  function court(c,camera,t) {
    c.save();c.translate(-Math.round(camera),0);
    r(c,0,342,worldWidth(3),98,'#7f9a86');r(c,0,381,worldWidth(3),59,'#a6795b');r(c,0,437,worldWidth(3),3,'#d6c29a');
    // Chain link fence behind the arena.
    for(let x=0;x<worldWidth(3);x+=65){r(c,x,240,4,154,'#597a70');r(c,x+1,240,1,152,'#99a48a');}
    r(c,0,241,worldWidth(3),4,'#657e71');r(c,0,390,worldWidth(3),4,'#557169');
    c.strokeStyle='#849786';c.lineWidth=1;for(let x=-200;x<worldWidth(3)+200;x+=19){c.beginPath();c.moveTo(x,245);c.lineTo(x+150,392);c.stroke();c.beginPath();c.moveTo(x,392);c.lineTo(x+150,245);c.stroke();}
    for(let x of [300,2200]){r(c,x,231,10,207,'#425e58');r(c,x-7,229,24,7,'#d8cba9');r(c,x-61,217,73,52,'#d3d2b8');r(c,x-57,221,65,44,'#849e91');r(c,x-38,233,28,23,'#dae0bf');r(c,x-35,236,22,17,'#98afa0');r(c,x-29,260,35,5,'#c16f4e');for(let k=0;k<5;k++)r(c,x-27+k*7,265,1,18,'#c3c7ac');r(c,x-27,281,30,2,'#c3c7ac');}
    // Floodlights and small bleachers.
    for(let x of [85,2450]){r(c,x,122,8,318,'#4b6260');r(c,x-16,112,41,16,'#3e5354');for(let k=0;k<3;k++)r(c,x-11+k*11,115,8,9,'#e9d8a2');}
    for(let i=0;i<3;i++){r(c,760-i*24,363+i*20,270+i*48,10,'#a68c74');r(c,768-i*24,373+i*20,6,55-i*20,'#4c675c');r(c,1016+i*24,373+i*20,6,55-i*20,'#4c675c');}
    r(c,1250,393,620,3,'#d9c49b');r(c,1558,393,3,47,'#d9c49b');r(c,1280,424,565,3,'#d9c49b');
    tree(c,2530,437,.8);bush(c,110,439,100,'#496758');
    // Arena pennants.
    r(c,1090,198,970,2,'#586e65');for(let i=0;i<20;i++){let x=1100+i*47;poly(c,[[x,200],[x+23,200],[x+12,222+Math.sin(t+i)*2]],i%2?'#b87d59':'#879c81');}
    const ballX=1174+Math.sin(t*.65)*31,ballY=428-Math.abs(Math.sin(t*2.8))*38;oval(c,ballX,ballY,8,8,'#6f4f35',2);oval(c,ballX,ballY-1,6,6,'#e19d4e',2);r(c,ballX-1,ballY-7,2,13,'#875b38');r(c,ballX-6,ballY-1,12,2,'#875b38');
    c.restore();
  }
  function football(c,x,y,size=9,t=0) {
    c.save();c.translate(Math.round(x),Math.round(y));oval(c,0,0,size+1,size+1,'#263c3e',2);oval(c,0,-1,size,size,'#f2f2df',2);r(c,-3,-4,6,6,'#35494c');r(c,-size+1,-2,3,4,'#35494c');r(c,size-4,-1,3,5,'#35494c');r(c,-2,size-4,4,3,'#35494c');r(c,0,-size+1,4,3,'#35494c');r(c,-size+3,-size+4,2,2,'#d5ded6');c.restore();
  }
  function backgroundCitizen(c,x,y,t=0,seed=0,seat=false) {
    const skin=['#e4bd9b','#a16b49','#c59066','#f0ceb0'][seed%4],shirt=['#dce7df','#3d6785','#b5785b','#6a8b68'][seed%4],wave=Math.round(Math.sin(t*2+seed)*2);
    r(c,x-4,y-18,9,13,shirt);r(c,x-3,y-28,8,9,skin);r(c,x-4,y-30,9,4,seed%3?'#373c36':'#835d37');r(c,x-4,y-5,3,seat?5:8,'#344e5c');r(c,x+2,y-5,3,seat?5:8,'#344e5c');r(c,x+5,y-17+wave,3,10,skin);r(c,x-7,y-17-wave,3,10,skin);
  }
  function plaza(c,camera,t) {
    // A fictional pixel interpretation of Itabuna's Camacan square and riverside.
    c.save();c.translate(-Math.round(camera*.28),0);
    for(let i=-1;i<25;i++){const x=i*273;const h=70+hash(i+83)*58;r(c,x,250-h,220,h,'#bfd3d2');r(c,x+6,250-h+8,208,8,'#e2ece6');for(let k=0;k<5;k++){r(c,x+19+k*39,270-h,17,26,'#7b9da5');r(c,x+19+k*39,273-h,8,11,'#b8d8dd');if(h>105)r(c,x+19+k*39,308-h,17,25,'#83a8b0');}r(c,x,247,220,8,'#8faeb0');}
    c.restore();r(c,0,260,960,99,'#63a8be');r(c,0,262,960,7,'#badcdd');
    for(let i=0;i<40;i++){const x=((i*71-camera*.4+t*10)%1080+1080)%1080-60,yy=275+hash(i+51)*76;r(c,x,yy,19+hash(i+4)*30,2,i%2?'#96d4dd':'#83c0d1');}
    c.save();c.translate(-Math.round(camera),0);r(c,0,354,worldWidth(4),86,'#cbd0bb');r(c,0,353,worldWidth(4),6,'#edf0d7');
    const lo=Math.floor((camera-200)/320),hi=Math.ceil((camera+1160)/320);
    for(let i=lo;i<hi;i++){const x=i*320;r(c,x,329,5,51,'#697f79');r(c,x,331,320,4,'#9aa995');r(c,x,349,320,4,'#91a38e');r(c,x,370,320,5,'#799783');}
    for(let x=160;x<worldWidth(4);x+=570){if(x<camera-260||x>camera+1160)continue;tree(c,x,430,.72,1);bush(c,x+75,433,75,'#578b45');r(c,x+137,401,112,8,'#986c44');r(c,x+142,409,7,30,'#4c6d57');r(c,x+234,409,7,30,'#4c6d57');r(c,x+137,378,112,7,'#c39b65');r(c,x+137,391,112,6,'#b28856');backgroundCitizen(c,x+180,404,t,Math.floor(x/570),true);}
    for(const x of [1050,4230]){if(x<camera-280||x>camera+1240)continue;oval(c,x,425,111,18,'#698d89',3);oval(c,x,416,103,20,'#d7d4b8',3);oval(c,x,409,91,15,'#77bbca',3);oval(c,x,409,74,9,'#a5dce2',3);r(c,x-8,342,17,65,'#d9d9bd');oval(c,x,341,58,9,'#d9d9bd',3);oval(c,x,335,50,8,'#82c6cf',3);r(c,x-4,294,8,40,'#ecedcf');oval(c,x,293,21,7,'#e5e7cd',2);for(let j=0;j<5;j++){const a=j*Math.PI/4+Math.PI*.1;const ex=Math.cos(a)*44,ey=Math.sin(a)*24;limb(c,[[x,291],[x+ex*.5,259-ey],[x+ex,312]],3,'#b7eced');r(c,x+ex,306+((t*55+j*11)%19),3,5,'#edf8ee');}for(let j=0;j<12;j++){const xx=x-74+j*14,yy=409-Math.abs(Math.sin(t*3+j))*7;r(c,xx,yy,4,2,'#d6f2e8');}}
    for(const x of [1970,5030]){if(x<camera-300||x>camera+1100)continue;r(c,x,314,170,124,'#efdfb5');r(c,x-12,306,194,16,'#274d61');r(c,x+9,326,152,14,'#305a6c');r(c,x+15,350,139,61,'#4c898c');r(c,x+19,354,131,52,'#89b9b6');r(c,x+13,412,142,9,'#c79860');c.fillStyle='#f8ebc7';c.font='bold 10px monospace';c.fillText('CACAU & RESENHA',x+21,337);for(let i=0;i<3;i++){r(c,x+28+i*44,374,22,31,'#9b694b');r(c,x+31+i*44,372,15,4,'#d9ac69');}backgroundCitizen(c,x+82,412,t,3);}
    r(c,390,315,6,122,'#3c6a76');r(c,354,296,215,43,'#214e66');r(c,358,300,207,35,'#dbe8df');c.fillStyle='#285e76';c.font='bold 15px monospace';c.fillText('PRAÇA CAMACAN',370,318);c.font='bold 9px monospace';c.fillText('ITABUNA · RIO CACHOEIRA',374,332);
    for(let i=0;i<9;i++){const x=700+i*650;if(x<camera-70||x>camera+1040)continue;r(c,x,261,5,176,'#476967');r(c,x-13,251,32,13,'#294e5a');r(c,x-8,254,22,7,'#fff0b4');}
    c.restore();
  }
  function favelaHouse(c,x,y,w,h,seed,t,back=false) {
    const colors=['#bf7956','#d4a06d','#c48b70','#a8b29b','#b7855e','#9b9fa0'];const pal=colors[Math.abs(seed)%colors.length];r(c,x,y,w,h,back?'#82949a':'#513e38');r(c,x+3,y+4,w-6,h-4,pal);r(c,x-5,y-7,w+10,10,back?'#5b747b':'#71645a');r(c,x-1,y-8,w+2,3,'#b2a58a');for(let row=0;row<Math.floor(h/18);row++)for(let col=0;col<Math.floor(w/24);col++){if(back)continue;r(c,x+4+col*24+(row%2?9:0),y+13+row*18,17,1,'#a9654b');}
    const wy=y+18,wh=Math.min(42,h-27);for(let k=0;k<2;k++){const wx=x+13+k*(w*.48);r(c,wx,wy,Math.min(30,w*.3),wh,'#395462');r(c,wx+3,wy+3,Math.min(24,w*.3-6),wh-7,seed%3?'#84b6c0':'#e1c892');r(c,wx+12,wy,3,wh,'#dbd3b6');}if(!back&&h>88){r(c,x+w*.39,y+h-61,28,61,'#4c5851');r(c,x+w*.4,y+h-59,20,58,'#647b6f');r(c,x+w*.56,y+h-31,3,3,'#d4b584');}if(!back){r(c,x+8,y-21,35,16,'#7e9297');r(c,x+12,y-27,26,8,'#bdc3b0');r(c,x+w-22,y-23,3,18,'#414d4c');r(c,x+w-35,y-26,29,3,'#414d4c');if(seed%3===0)backgroundCitizen(c,x+28,y+wh+17,t,seed);}
  }
  function favela(c,camera,t) {
    c.save();c.translate(-Math.round(camera*.2),0);for(let i=-1;i<30;i++){const x=i*181,yy=95+(i%4)*30;favelaHouse(c,x,yy,174,115+i%3*17,i+20,t,true);}c.restore();
    c.save();c.translate(-Math.round(camera*.48),0);for(let i=-1;i<40;i++){const x=i*159,yy=201+(i%3)*16;favelaHouse(c,x,yy,151,128,i+8,t,true);}c.restore();
    c.save();c.translate(-Math.round(camera),0);r(c,0,398,worldWidth(5),42,'#968a73');const lo=Math.floor((camera-170)/210),hi=Math.ceil((camera+1180)/210);for(let i=lo;i<hi;i++){const x=i*210,yy=272+(i%2)*29;favelaHouse(c,x,yy,188,163-(i%2)*29,i+100,t);r(c,x+190,yy+78,16,8,'#b3a585');r(c,x+193,yy+86,13,8,'#a69b81');r(c,x+196,yy+94,10,8,'#958c78');}
    for(let x=Math.floor(camera/390)*390;x<camera+1200;x+=390){r(c,x,117,6,322,'#4b5b56');c.strokeStyle='#394b4f';c.lineWidth=2;c.beginPath();c.moveTo(x-387,130);c.quadraticCurveTo(x-190,181,x+4,130);c.stroke();for(let j=0;j<4;j++){const xx=x-293+j*47,yy=172+Math.sin(j)*5;const wave=Math.round(Math.sin(t*3+j)*4);poly(c,[[xx,yy],[xx+24,yy+2],[xx+26+wave,yy+27],[xx-2+wave,yy+26]],['#e0c17c','#6697ac','#dc8666','#d8d0a7'][j]);}}
    for(let x=870,i=0;x<worldWidth(5);x+=900,i++){if(x<camera-260||x>camera+1100)continue;r(c,x,294,128,75,'#3c5358');r(c,x+5,299,118,65,'#2a5b65');c.fillStyle='#b0dfc5';c.font='bold 12px monospace';c.fillText(i>4?'ALTO DO MORRO':'RESPEITA A RESENHA',x+7,322);c.font='bold 9px monospace';c.fillText('GABRIEL REEIS',x+12,344);r(c,x+142,393,28,45,'#395f59');r(c,x+140,387,32,7,'#82a087');}
    // Warm tiny windows and flags make the crowded neighborhood feel inhabited.
    for(let i=0;i<10;i++){let x=camera+((i*133+t*2)%1040)-40,y=150+(i%3)*53;r(c,x,y,2,2,'#f4d78c');}c.restore();
  }
  function inkRealm(c,camera,t) {
    r(c,0,0,960,440,'#292b49');r(c,0,140,960,300,'#413b62');for(let i=0;i<28;i++){const x=((i*97-camera*.22+t*7)%1080+1080)%1080-70,y=35+(i*43)%260;r(c,x,y,3,3,i%3?'#b5a2cf':'#e3c7ed');}
    c.save();c.translate(-Math.round(camera*.3),0);for(let i=-1;i<32;i++){const x=i*245,yy=95+(i%3)*39;c.save();c.globalAlpha=.3;doodle(c,x+90,yy+50,i%3,t*.4+i,false);c.restore();poly(c,[[x,285],[x+35,101],[x+145,90],[x+174,286]],'#655579');for(let j=0;j<6;j++)r(c,x+53,128+j*19,88,2,'#9c8bac');}c.restore();
    c.save();c.translate(-Math.round(camera),0);r(c,0,361,worldWidth(6),79,'#68557f');const lo=Math.floor((camera-170)/180),hi=Math.ceil((camera+1140)/180);for(let i=lo;i<hi;i++){const x=i*180,y=235+Math.sin(t*.8+i)*12;poly(c,[[x,y],[x+132,y-12],[x+143,y+105],[x+118,y+117],[x+92,y+109],[x+70,y+122],[x+43,y+112],[x+13,y+119]],'#d7c9d7');r(c,x+17,y+15,105,2,'#b395bd');r(c,x+18,y+32,105,2,'#b395bd');r(c,x+19,y+49,102,2,'#b395bd');r(c,x+20,y+66,102,2,'#b395bd');r(c,x+19,y+14,2,81,'#c28b9f');if(i%3===0){c.save();c.translate(x+70,y+80);c.scale(1.3,1.3);doodle(c,0,0,i%3,t*.4,false);c.restore();}}
    for(let x=680,i=0;x<worldWidth(6);x+=990,i++){if(x<camera-190||x>camera+1140)continue;r(c,x,109,143,39,'#3c324f');r(c,x+4,113,135,31,'#876591');c.fillStyle='#f1d3e1';c.font='bold 11px monospace';c.fillText(i>3?'O RABISCO GIGANTE':'O CADERNO TEM FOME',x+9,132);}
    for(let i=0;i<16;i++){let xx=camera+(i*89+t*18)%1060-50,yy=65+(i*61+t*23)%330;r(c,xx,yy,6,3,i%2?'#ddb8d0':'#a5ca9c');}c.restore();
  }
  function footballField(c,camera,t) {
    c.save();c.translate(-Math.round(camera*.3),0);r(c,0,180,worldWidth(7)+1200,147,'#e2ebeb');r(c,0,180,worldWidth(7)+1200,16,'#21496c');for(let x=20;x<worldWidth(7)+900;x+=110){r(c,x,218,78,61,'#87acb7');r(c,x+4,222,70,53,'#b3d5d9');r(c,x+37,222,4,53,'#ebf2e7');}c.restore();
    c.save();c.translate(-Math.round(camera),0);r(c,0,326,worldWidth(7),114,'#438c4b');for(let i=0;i<Math.ceil(worldWidth(7)/160);i++)r(c,i*160,327,80,110,'#4e9752');r(c,0,432,worldWidth(7),4,'#ecedd1');r(c,0,342,worldWidth(7),3,'#dce9c8');
    for(let x=190;x<worldWidth(7);x+=960){if(x<camera-400||x>camera+1220)continue;for(let row=0;row<3;row++){r(c,x-row*16,264+row*20,320+row*32,7,'#6b90a4');for(let j=0;j<15;j++)backgroundCitizen(c,x+10+j*20,268+row*20,t,j+row*5,true);}r(c,x+125,258,84,4,'#183e60');}
    for(const x of [740,4410]){if(x<camera-200||x>camera+1120)continue;r(c,x,283,7,154,'#e9f2de');r(c,x+173,283,7,154,'#e9f2de');r(c,x,282,180,7,'#faffeb');for(let j=0;j<10;j++)r(c,x+5+j*18,290,1,145,'#b1ceaf');for(let j=0;j<8;j++)r(c,x+7,291+j*18,166,1,'#b1ceaf');r(c,x-17,434,216,3,'#e6efcf');}
    for(let x=1250;x<worldWidth(7);x+=2100){r(c,x,345,3,94,'#eff0d0');oval(c,x,392,87,38,'#dcebc9',3);oval(c,x,392,83,34,'#4c9450',3);}for(let x=300;x<worldWidth(7);x+=1300){r(c,x,100,7,200,'#40687b');r(c,x-18,89,43,17,'#1f425c');for(let j=0;j<3;j++)r(c,x-13+j*12,93,9,8,'#fff2b6');}
    r(c,350,204,343,38,'#153a60');c.fillStyle='#eff5de';c.font='bold 20px monospace';c.fillText('CAMPO DO MOTA · MOTA FC',363,230);football(c,1780+Math.sin(t*.7)*22,423-Math.abs(Math.sin(t*2.8))*18,8,t);c.restore();
  }

  function barberPole(c,x,y,t=0) {
    r(c,x-4,y-8,31,11,'#252d34');r(c,x-1,y-5,25,6,'#ded4bf');r(c,x,y,23,88,'#2a343d');r(c,x+3,y+3,17,82,'#f0e6cf');
    c.save();c.beginPath();c.rect(x+3,y+3,17,82);c.clip();
    for(let i=-3;i<8;i++){const yy=y+i*24+(t*16)%24;poly(c,[[x+3,yy],[x+20,yy-14],[x+20,yy-5],[x+3,yy+9]],i%2?'#bf5e51':'#476e99');}
    c.restore();r(c,x+4,y+4,3,80,'#fff8e4aa');r(c,x+21,y+3,2,82,'#647a80');r(c,x-4,y+87,31,10,'#252d34');r(c,x-1,y+89,25,4,'#beb8a7');
  }
  function barberChair(c,x,y,t=0,occupied=false) {
    oval(c,x,y-2,39,7,'#464843',3);r(c,x-25,y-7,51,7,'#26343b');r(c,x-22,y-8,44,3,'#b6bdb1');r(c,x-5,y-48,11,39,'#434f50');r(c,x-3,y-45,6,32,'#c5c5b4');
    r(c,x-33,y-111,66,72,'#283138');r(c,x-29,y-107,58,65,'#883e3f');r(c,x-25,y-103,50,5,'#b66a5b');r(c,x-26,y-62,52,4,'#66343c');r(c,x-19,y-130,39,19,'#2e3439');r(c,x-16,y-127,33,13,'#a45e50');
    r(c,x-36,y-47,73,17,'#29343a');r(c,x-31,y-45,63,10,'#9e4d47');r(c,x-31,y-45,63,3,'#c98166');
    for(const side of [-1,1]){r(c,x+side*36-3,y-80,7,39,'#8fa19b');r(c,x+side*36-9,y-84,19,8,'#27363b');r(c,x+side*36-8,y-84,17,3,'#baa78c');}
    r(c,x+20,y-35,4,24,'#455351');r(c,x+21,y-16,32,5,'#c2c4b1');r(c,x+47,y-20,5,6,'#c2c4b1');
    if(occupied){const head= Math.round(Math.sin(t*.8)*1);r(c,x-16,y-117,32,25,'#c99270');r(c,x-17,y-121,34,12,'#4a3530');poly(c,[[x-18,y-95],[x+19,y-95],[x+30,y-46],[x-30,y-46]],'#d5d6c4');r(c,x-23,y-84,45,3,'#b4b9ae');r(c,x-4,y-114+head,3,2,'#322e2d');r(c,x+8,y-114+head,3,2,'#322e2d');}
  }
  function bigodon(c,camera,t) {
    // Warm amber bulbs, black steel and a lived-in row of real barber stations.
    r(c,0,0,960,440,'#d5bea1');r(c,0,0,960,27,'#29373b');r(c,0,27,960,7,'#a97444');r(c,0,34,960,5,'#f1d3a0');
    r(c,0,278,960,162,'#74513c');r(c,0,278,960,6,'#c89b63');r(c,0,418,960,22,'#3b4140');
    c.save();c.translate(-Math.round(camera),0);const width=worldWidth(8);
    for(let xx=0;xx<width;xx+=33){r(c,xx,288,3,128,'#4d3a31');r(c,xx+6,290,1,124,'#9e7350');}
    for(let xx=65,i=0;xx<width;xx+=438,i++){
      if(xx<camera-420||xx>camera+1040)continue;
      // Framed mirrors, shelf, brushes and spray bottles are behind the walkable band.
      r(c,xx,123,213,186,'#303b3f');r(c,xx+5,128,203,176,'#b98b52');r(c,xx+11,134,191,163,'#576f75');r(c,xx+15,138,183,153,'#8dafb0');
      poly(c,[[xx+22,280],[xx+123,140],[xx+149,140],[xx+48,280]],'#a7cbcb');poly(c,[[xx+124,278],[xx+184,194],[xx+197,194],[xx+137,278]],'#9abfbd');r(c,xx+25,143,77,2,'#d2e1cc');
      r(c,xx-12,309,240,14,'#333f40');r(c,xx-9,309,234,4,'#b98a55');r(c,xx-6,323,226,47,'#a27a50');r(c,xx-6,323,226,5,'#76563c');
      for(let d=0;d<3;d++){r(c,xx+2+d*72,332,63,27,'#805a3f');r(c,xx+7+d*72,335,53,2,'#bd9561');r(c,xx+26+d*72,342,15,3,'#d3be86');}
      const colors=['#67888c','#b96851','#d5b677'];for(let j=0;j<5;j++){const bx=xx+4+j*27;r(c,bx,286-j%2*7,10,23+j%2*7,colors[j%3]);r(c,bx+2,281-j%2*7,6,6,'#28393e');r(c,bx+3,290-j%2*7,4,4,'#f0e4bb');}
      r(c,xx+153,297,31,11,'#d4dbcd');for(let j=0;j<6;j++)r(c,xx+155+j*4,294,2,11,'#28383d');r(c,xx+192,290,7,18,'#46616b');r(c,xx+190,286,11,6,'#bcc6b7');
      r(c,xx+93,40,3,47,'#3f4140');r(c,xx+64,86,63,8,'#3b3c36');poly(c,[[xx+68,92],[xx+123,92],[xx+114,105],[xx+77,105]],'#b68a53');r(c,xx+83,102,27,5,'#ffe8a4');
      barberChair(c,xx+102,435,t+i,i===3||i===5);
      for(let k=0;k<7;k++){const hx=xx+70+k*11;poly(c,[[hx,434],[hx+4,432],[hx+7,435]],k%2?'#53493e':'#403b34');}
    }
    // Signature moustache sign: original lettering and a neon outline.
    r(c,292,49,523,63,'#28373b');r(c,298,55,511,51,'#e1b16b');r(c,302,59,503,43,'#34484c');
    c.fillStyle='#fae3a8';c.font='bold 29px monospace';c.fillText('BIGODON',481,90);c.font='bold 8px monospace';c.fillStyle='#a8c9bd';c.fillText('CORTE NA RÉGUA, RESENHA SEM MEDIDA',502,102);
    for(const side of [-1,1]){poly(c,[[418,77],[418+side*11,65],[418+side*24,66],[418+side*40,80],[418+side*57,76],[418+side*49,88],[418+side*32,91],[418+side*17,84],[418,80]],'#e9c984');}
    barberPole(c,246,150,t);barberPole(c,1140,150,t+.6);
    r(c,154,339,163,18,'#293d40');r(c,160,357,151,57,'#996b46');r(c,164,361,143,4,'#c59a65');r(c,167,409,137,6,'#4a4437');r(c,184,327,45,12,'#d6dfcf');r(c,188,330,37,2,'#667e75');r(c,269,312,22,27,'#293b42');r(c,272,315,16,17,'#84b7b1');r(c,278,333,4,4,'#e4cd96');c.fillStyle='#f0d9a8';c.font='bold 9px monospace';c.fillText('RECEPÇÃO',199,352);
    // Waiting corner, folded towels and a wall clock animate the shop quietly.
    r(c,1285,231,229,22,'#2e4141');for(let j=0;j<5;j++){r(c,1293+j*41,218,33,13,'#ece1c4');r(c,1296+j*41,220,27,2,'#fff5dd');r(c,1296+j*41,228,27,2,'#b9bcae');}
    oval(c,1365,143,31,31,'#344549',3);oval(c,1365,143,25,25,'#f1dfb5',3);for(let i=0;i<12;i++){const a=i*Math.PI/6;r(c,1364+Math.cos(a)*21,142+Math.sin(a)*21,2,2,'#795a3d');}limb(c,[[1365,143],[1365+Math.sin(t*.03)*15,143-Math.cos(t*.03)*15]],2,'#5d4a37');limb(c,[[1365,143],[1355,137]],3,'#5d4a37');
    for(let x=1740;x<width-130;x+=650){r(c,x,366,214,57,'#273a3d');r(c,x+5,371,204,42,'#986553');r(c,x,353,214,18,'#a77158');r(c,x+5,354,204,4,'#cc9c76');r(c,x+10,423,9,17,'#344342');r(c,x+193,423,9,17,'#344342');for(let j=0;j<3;j++){r(c,x+15+j*64,376,53,32,'#875648');r(c,x+18+j*64,378,47,3,'#b78261');}backgroundCitizen(c,x+63,388,t,Math.floor(x/650),true);}
    r(c,2920,117,228,105,'#303b3f');r(c,2925,122,218,95,'#8c6247');c.fillStyle='#f2d69e';c.font='bold 16px monospace';c.fillText('AQUI O PAPO',2951,151);c.fillText('RENDE MAIS',2951,176);c.font='bold 11px monospace';c.fillText('QUE O DEGRADÊ.',2970,201);
    c.restore();
    // Fan and floating warm dust are screen-relative, keeping the room alive.
    const fanX=760-camera*.18,angle=t*8;c.save();c.translate(fanX,82);r(c,-2,-82,4,80,'#3e4946');for(let i=0;i<3;i++){const a=angle+i*Math.PI*2/3,dx=Math.cos(a),dy=Math.sin(a)*.34;poly(c,[[dx*5-dy*4,dy*5+dx*3],[dx*50-dy*4,dy*50+dx*4],[dx*48+dy*5,dy*48-dx*4],[dx*8+dy*4,dy*8-dx*3]],'#65736b');}oval(c,0,0,7,5,'#334344',2);c.restore();
    for(let i=0;i<14;i++){const dx=((i*113+t*4-camera*.36)%1040+1040)%1040-40,dy=80+(i*31+t*6)%290;r(c,dx,dy,2,2,i%2?'#f4d79b88':'#f5e9be66');}
  }

  function drawScene(c,scene,camera=0,t=0) {
    c.save();c.imageSmoothingEnabled=false;c.beginPath();c.rect(0,0,960,540);c.clip();camera=Number(camera)||0;t=Number(t)||0;animT=t;animCam=0;
    if(scene===11){
      if(window.BaileWorld?.draw)window.BaileWorld.draw(c,camera,t,{hideOllyan:true});
      else{r(c,0,0,960,440,'#111526');r(c,0,440,960,100,'#31324d');r(c,0,440,960,5,'#7892c3');}
      c.restore();return;
    }
    sky(c,scene,camera,t);
    if(scene===1)school(c,camera,t);else if(scene===2)gym(c,camera,t);else if(scene===3)court(c,camera,t);else if(scene===4)plaza(c,camera,t);else if(scene===5)favela(c,camera,t);else if(scene===6)inkRealm(c,camera,t);else if(scene===7)footballField(c,camera,t);else if(scene===8)bigodon(c,camera,t);else if(scene===9)courtyard(c,camera,t);else if(scene===10)rayssaHouse(c,camera,t);else farm(c,camera,t);
    if(scene!==2&&scene!==8&&scene!==10)for(let i=0;i<13;i++){const lx=((i*137+t*13-camera*.65)%1120+1120)%1120-80,ly=158+((i*43+t*15)%235);r(c,lx,ly,5,2,i%2?'#8bb65a':'#b2c56c');r(c,lx+Math.round(Math.sin(t*5+i)*2),ly+2,3,2,'#5e954c');}
    worldExtensions(c,scene,camera,t);ground(c,camera,scene);groundBridges(c,scene,camera,t);lightPass(c,scene,camera,t);c.restore();
  }
  /* Every former pit has a walking surface at the same y=440 used by collision. */
  function woodenBridge(c,x,width,t=0,scene=0,feet=440,depth=100) {
    const ink=scene===6?'#4b3559':'#57422f',wood=scene===6?'#95749f':'#a87947',lit=scene===6?'#d8b7c4':'#e0b66f';
    const bottom=Math.min(540,feet+depth);
    r(c,x,feet+13,width,bottom-feet-13,scene===6?'#4e416c':'#3a7581');
    for(let i=0;i<Math.ceil(width/36)+1;i++){const xx=x+((i*37+t*15)%Math.max(1,width));r(c,xx,feet+25+(i%4)*15,Math.min(19,x+width-xx),2,scene===6?'#a8a1c6':'#8bc8cd');}
    // Railing is scenery behind the actors; planks are exactly under their feet.
    for(let xx=x-6;xx<x+width+10;xx+=66){r(c,xx,feet-40,7,44,ink);r(c,xx+1,feet-39,2,36,lit);r(c,xx-2,feet-43,11,5,wood);}
    r(c,x-10,feet-32,width+20,7,ink);r(c,x-9,feet-32,width+18,3,wood);
    r(c,x-10,feet-15,width+20,5,ink);r(c,x-9,feet-15,width+18,2,wood);
    r(c,x-12,feet,width+24,15,ink);r(c,x-12,feet,width+24,3,lit);
    for(let xx=x-8;xx<x+width+9;xx+=16){const ww=Math.min(14,x+width+10-xx);r(c,xx,feet+3,ww,9,wood);r(c,xx+1,feet+4,Math.max(1,ww-2),2,lit);r(c,xx+2,feet+8,2,2,ink);}
    r(c,x-10,feet+15,width+20,7,ink);r(c,x-9,feet+16,width+18,3,'#82603e');
    for(let xx=x+10;xx<x+width;xx+=94){r(c,xx,feet+20,9,Math.max(0,bottom-feet-20),ink);r(c,xx+2,feet+22,2,Math.max(0,bottom-feet-22),wood);poly(c,[[xx+7,feet+23],[xx+40,feet+23],[xx+7,feet+56]],'#6e5236');}
    r(c,x-20,feet-1,9,7,'#b49a65');r(c,x+width+12,feet-1,9,7,'#b49a65');
  }
  function groundBridges(c,scene,camera,t) {
    const gaps=window.WorldData?.gaps?.[scene]||[];if(!gaps.length)return;
    c.save();c.translate(-Math.round(camera),0);
    for(const g of gaps){const x=Number(g[0]),w=Number(g[1]);if(!Number.isFinite(x)||!Number.isFinite(w)||w<=0||x+w<camera-25||x>camera+985)continue;woodenBridge(c,x,w,t,scene);}
    c.restore();
  }
  function titleChicken(c,x,y,t=0,rooster=false) {
    c.save();c.translate(Math.round(x),Math.round(y));const step=Math.round(Math.sin(t*8)*2);
    r(c,-6,0,3,5+step,'#d89536');r(c,5,0,3,5-step,'#d89536');r(c,-8,4+step,6,2,'#bd742c');r(c,4,4-step,7,2,'#bd742c');
    oval(c,0,-7,12,9,rooster?'#b27b4b':'#fcf2d9',2);r(c,-13,-12,6,7,rooster?'#315e49':'#d8d5bd');r(c,-15,-15,5,5,rooster?'#28533d':'#e8dfc2');
    r(c,5,-20,9,14,rooster?'#d9aa64':'#fff9e4');r(c,7,-23,7,5,'#c75741');r(c,12,-18,5,4,'#e1a039');r(c,10,-18,2,2,'#483a32');r(c,8,-8,4,5,'#c9513a');
    r(c,-3,-11+Math.round(Math.sin(t*3)),9,6,rooster?'#8e603e':'#e2ddc6');r(c,-2,-10,7,2,rooster?'#c58b52':'#fff8df');c.restore();
  }
  function titleWindmill(c,x,y,t) {
    c.save();c.translate(x,y);
    poly(c,[[-24,0],[-18,-138],[16,-138],[29,0]],'#cbbd8b');r(c,-18,-130,31,128,'#e7d9ae');r(c,-11,-48,17,48,'#596954');r(c,-6,-42,7,41,'#3d5647');r(c,-12,-94,12,19,'#6b9794');r(c,-10,-92,8,12,'#a8cdd0');
    poly(c,[[-32,-134],[0,-164],[34,-134]],'#9f6345');r(c,-33,-135,68,7,'#704b36');r(c,-26,-135,52,3,'#d39b61');
    c.save();c.translate(0,-134);c.rotate(t*.28);
    for(let i=0;i<4;i++){c.save();c.rotate(i*Math.PI/2);r(c,-3,-85,6,90,'#715e41');r(c,3,-82,22,54,'#bea574');r(c,5,-79,17,46,'#e0c693');for(let yy=-76;yy<-30;yy+=12)r(c,5,yy,18,2,'#8b7550');r(c,12,-81,2,51,'#8b7550');c.restore();}
    oval(c,0,0,9,9,'#634d36',2);oval(c,0,-1,5,5,'#d8b36b',2);c.restore();c.restore();
  }
  /* Original cozy panorama. Artwork is independent of any other game's assets. */
  function drawTitleScene(c,time=0,width=960,height=540) {
    c.save();c.imageSmoothingEnabled=false;const t=Number(time)||0;c.scale((Number(width)||960)/960,(Number(height)||540)/540);
    r(c,0,0,960,115,'#6bb4e6');r(c,0,115,960,115,'#8bcbea');r(c,0,230,960,190,'#b9e3e8');
    oval(c,801,73,38,38,'#fff4bd',3);oval(c,795,67,29,29,'#fff8d9',3);
    c.save();c.globalAlpha=.10;poly(c,[[776,57],[768,64],[534,423],[629,445]],'#fff5c4');poly(c,[[811,67],[803,72],[823,452],[939,410]],'#fff5c4');c.restore();
    for(let i=-1;i<6;i++){const xx=((i*237+t*(2+i%2)+1500)%1500)-220;cloud(c,xx,48+(i%3)*34,1.15+(i%2)*.30,'#fff8e4');}
    for(let i=-1;i<5;i++)steppedHill(c,i*275-90,220+hash(i+30)*36,410,194,'#82b6a5');
    for(let i=-1;i<5;i++)steppedHill(c,i*290-70,282+hash(i+47)*23,430,176,'#51956c');
    r(c,0,347,960,193,'#76b451');r(c,0,365,960,51,'#8ac15b');
    for(let i=0;i<22;i++){const xx=i*49+Math.sin(i)*12;tree(c,xx,370,.27+(i%3)*.035);}
    r(c,0,382,960,17,'#85b552');r(c,0,397,960,143,'#9bc260');
    // Village architecture frames a clear central sky for the wooden title sign.
    titleWindmill(c,836,375,t);
    house(c,84,433);r(c,108,437,130,5,'#a8bb61');
    for(let i=0;i<4;i++){const xx=238+Math.sin(t*.3+i)*8,yy=253-((t*10+i*14)%57);oval(c,xx,yy,7+i*2,4+i*2,'#e5e7cb',3);}
    // A small red-roofed barn, hay and warm stable windows.
    r(c,643,344,125,95,'#ab6b47');r(c,648,348,115,90,'#ce8b55');poly(c,[[631,346],[668,302],[735,302],[779,346]],'#8b4d3c');
    for(let row=0;row<4;row++){const xx=666-row*9,ww=71+row*21;r(c,xx,306+row*10,ww,8,row%2?'#bd6547':'#d47b4c');for(let k=0;k<ww;k+=19)r(c,xx+k,306+row*10,2,7,'#efb06c');}
    r(c,632,344,145,6,'#764b37');r(c,682,369,46,70,'#654e38');r(c,686,373,38,65,'#815738');r(c,702,374,4,64,'#cda06a');limb(c,[[688,375],[723,432]],4,'#cda06a');limb(c,[[722,375],[687,432]],4,'#cda06a');
    r(c,651,366,23,25,'#6b7970');r(c,654,369,17,18,'#a9c9b1');r(c,661,368,3,21,'#e8c98b');r(c,651,378,23,3,'#e8c98b');r(c,741,375,22,33,'#c7b47b');
    for(let i=0;i<2;i++){const xx=615+i*27;r(c,xx,421,25,20,'#a28b45');r(c,xx+2,422,21,16,'#d3b65c');r(c,xx+4,425,17,3,'#e7cd74');r(c,xx+10,422,3,18,'#8f783d');}
    // A winding stream and its safe little bridge lead the eye into the village.
    poly(c,[[951,346],[960,350],[960,540],[724,540],[769,484],[798,438],[845,396],[889,371]],'#4d9eb0');
    poly(c,[[956,351],[960,351],[960,540],[746,540],[789,484],[814,441],[860,402],[902,375]],'#7bc1cb');
    for(let i=0;i<30;i++){const xx=780+hash(i+80)*173,yy=383+hash(i+90)*151+Math.sin(t*1.2+i)*2;if(xx<800&&yy<471)continue;r(c,xx,yy,10+hash(i)*17,2,i%3?'#b4e6df':'#e8f7e5');}
    woodenBridge(c,787,110,t,0,450,90);
    // Earthen footpath and ploughed rows keep the middle foreground calm for menus.
    poly(c,[[428,389],[498,389],[508,417],[549,457],[586,540],[349,540],[390,471],[418,430]],'#cbaa71');
    poly(c,[[439,392],[483,392],[491,420],[529,461],[560,540],[378,540],[410,474],[437,430]],'#dfc28a');
    for(let i=0;i<42;i++){const yy=408+hash(i+9)*129,span=27+(yy-400)*.46,xx=463+(hash(i+14)-.5)*span*2;r(c,xx,yy,4+hash(i)*4,2,i%2?'#bca174':'#ebd3a0');}
    fence(c,16,459,286);fence(c,574,452,173);
    for(let row=0;row<3;row++){const yy=481+row*23;r(c,32,yy,282,15,'#9b703f');r(c,34,yy+1,278,2,'#c9954f');for(let j=0;j<14;j++){const xx=43+j*19,wave=Math.round(Math.sin(t*1.6+j*.4+row)*2);r(c,xx,yy-17,3,18,'#4a8338');poly(c,[[xx,yy-6],[xx-7+wave,yy-15],[xx-10+wave,yy-12],[xx,yy]],'#3a833a');poly(c,[[xx+2,yy-8],[xx+9+wave,yy-18],[xx+12+wave,yy-14],[xx+2,yy-2]],'#8bbb43');r(c,xx-1,yy-22,6,11,'#edcb5a');r(c,xx,yy-21,2,7,'#fff09b');}}
    for(let i=0;i<48;i++){const xx=14+hash(i+37)*930,yy=443+hash(i+61)*93;if(xx>342&&xx<581||xx>760&&xx<955)continue;grass(c,xx,yy,i);if(i%3===0)flower(c,xx+6+Math.sin(t*1.1+i)*1.6,yy-1,['#f2ce5b','#f2e9b5','#d88e89','#b7b9de'][i%4]);}
    titleChicken(c,585+Math.sin(t*.35)*24,471,t,true);titleChicken(c,630+Math.sin(t*.28+1)*28,481,t+.8,false);titleChicken(c,613+Math.sin(t*.25+2)*30,452,t+2,false);
    // Butterflies, birds and pollen are small, readable moving details.
    for(let i=0;i<7;i++){const xx=190+i*107+Math.sin(t*.7+i)*24,yy=360+Math.sin(t*1.1+i*2)*17,wing=1+Math.abs(Math.sin(t*8+i))*4;r(c,xx-wing-1,yy-2,wing,4,i%2?'#e8b15e':'#e7a7aa');r(c,xx+1,yy-2,wing,4,'#fff0af');r(c,xx,yy-2,1,5,'#597450');}
    for(let i=0;i<6;i++){const xx=((i*193+t*11)%1150)-80,yy=114+(i%3)*28,flap=Math.round(Math.sin(t*8+i)*3);r(c,xx,yy,3,2,'#577e87');r(c,xx-4,yy-2+flap,4,2,'#577e87');r(c,xx+3,yy-2+flap,4,2,'#577e87');}
    for(let i=0;i<19;i++){const xx=(i*73+t*(2+i%3))%1020-30,yy=305+(i*43+t*6)%228;r(c,xx,yy,2,2,i%2?'#f7e7a5':'#b8d879');}
    // Foreground orchard silhouettes frame the view without covering its central title.
    tree(c,-18,548,1.45);tree(c,976,557,1.5);bush(c,6,538,128,'#4b8a42');bush(c,934,544,125,'#4c8c44');
    c.restore();
  }

  // Stepped limb strokes keep the animation on the pixel grid without rotating sprites.
  function limb(c,points,width,color) {
    for(let i=1;i<points.length;i++){
      const a=points[i-1],b=points[i],steps=Math.max(1,Math.ceil(Math.max(Math.abs(b[0]-a[0]),Math.abs(b[1]-a[1]))/2));
      for(let j=0;j<=steps;j++){let q=j/steps;r(c,Math.round((a[0]+(b[0]-a[0])*q)/2)*2-width/2,Math.round((a[1]+(b[1]-a[1])*q)/2)*2-width/2,width,width,color);}
    }
  }
  function energyAura(c,x,y,t=0,o={}) {
    c.save();c.translate(Math.round(x),Math.round(y));
    const s=Number(o.scale)||1,intensity=Math.max(.15,Math.min(1,Number(o.intensity)||.7));c.scale(s,s);
    const red=!!o.red||typeof o.color==='string';const glow=red?['#f33b35','#ff7162','#ffd8b8','#ff4a48','#ff9b7c','#fff1df']:['#f39425','#ffdd41','#fff6ba','#ffc435','#ffce42','#fff9dc'];
    const pulse=Math.sin(t*13)*2,tip=-96-pulse,alpha=c.globalAlpha;
    const outer=[[-30,0],[-39,-24],[-27,-30],[-37,-58],[-20,-54],[-22,-79],[-9,-67],[0,tip],[10,-68],[25,-83],[21,-54],[37,-61],[28,-32],[39,-24],[29,0]];
    // Saturated flame layers remain visible against the bright blue daytime sky.
    c.globalAlpha=alpha*intensity*.4;poly(c,outer,glow[0]);
    c.globalAlpha=alpha*intensity*.37;poly(c,[[-23,-1],[-31,-24],[-20,-31],[-27,-57],[-13,-51],[-15,-74],[-4,-66],[1,-87-pulse],[9,-63],[18,-74],[14,-48],[28,-55],[21,-27],[30,-19],[22,-1]],glow[1]);
    c.globalAlpha=alpha*intensity*.16;poly(c,[[-14,-2],[-23,-27],[-12,-44],[-13,-62],[0,-78],[12,-61],[11,-43],[23,-25],[13,-2]],glow[2]);
    c.globalAlpha=alpha*intensity*.88;
    limb(c,outer.slice(0,9),2,glow[3]);limb(c,outer.slice(8),2,glow[4]);
    for(let i=0;i<9;i++){
      const side=i%2?1:-1,yy=-8-i*10,xx=side*(21+Math.sin(t*10+i)*5);
      limb(c,[[xx+side*3,yy+5],[xx-side*3,yy-3],[xx+side*2,yy-10]],2,i%3?glow[4]:glow[5]);
    }
    // Long alternating bolts snap around the silhouette, never across the face.
    for(let side of [-1,1]){const j=Math.round(Math.sin(t*24+side)*3),bx=side*(31+j);limb(c,[[bx,-16],[bx-side*6,-29],[bx+side*3,-39],[bx-side*4,-53],[bx+side*2,-69]],3,glow[3]);limb(c,[[bx,-16],[bx-side*6,-29],[bx+side*3,-39],[bx-side*4,-53],[bx+side*2,-69]],1,glow[5]);}
    if(o.charging){
      for(let i=0;i<14;i++){let yy=-((t*105+i*17)%110),xx=(hash(i+56)-.5)*70;r(c,xx,yy,2,i%3?6:9,glow[2]);}
    }else{
      for(let i=0;i<9;i++){const xx=Math.cos(t*3+i*1.25)*32,yy=-((t*82+i*19)%98);r(c,xx,yy,3,6,glow[2]);}
    }
    c.restore();
  }
  function supremeAura(c,t,o={}) {
    c.save();const alpha=c.globalAlpha,pulse=Math.sin(t*7)*4;
    c.globalAlpha*=.21;oval(c,0,-49,57+pulse,85,'#73d7e4',3);c.globalAlpha*=1.9;
    poly(c,[[-39,1],[-47,-32],[-33,-46],[-39,-68],[-19,-62],[-12,-102],[0,-85],[17,-107],[22,-69],[39,-79],[33,-42],[48,-29],[34,1]],'#f3d27b');
    c.globalAlpha=alpha;for(let i=0;i<8;i++){const a=t*.9+i*Math.PI/4,xx=Math.cos(a)*48,yy=-48+Math.sin(a)*59;r(c,xx,yy,3,3,i%2?'#d3fbef':'#f8d784');r(c,xx-3,yy+2,9,1,'#8de3e0');}
    for(const side of [-1,1]){const xx=side*(40+Math.sin(t*12+side)*3);limb(c,[[xx,-7],[xx-side*9,-26],[xx+side*4,-41],[xx-side*5,-61],[xx+side*2,-80]],2,'#98ebe7');}
    if(o.charging)for(let i=0;i<14;i++){const yy=-((t*100+i*13)%120),xx=(hash(i+43)-.5)*100;r(c,xx,yy,2,6,i%2?'#ffe8a1':'#98ebe7');}
    c.restore();
  }
  function newCharacter(c,type,x,y,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale((o.facing<0?-1:1)*(o.scale||1),o.scale||1);
    if(Number.isFinite(o.opacity))c.globalAlpha*=Math.max(0,Math.min(1,o.opacity));
    const t=Number(o.frame)||0,moving=!!o.moving||Number(o.speed)>8,walk=moving?Math.sin(t*9):0,bob=moving?Math.round(Math.abs(Math.cos(t*9))*2):Math.round(Math.sin(t*2)*.7);
    const supreme=type==='nicolas'&&!!(o.supreme||o.powered||o.transformed),attack=!!o.attack,strike=attack?Math.max(0,Math.sin((Number.isFinite(o.attackProgress)?o.attackProgress:.5+Math.sin(t*7)*.5)*Math.PI)):0;
    const skins={davi:'#ecc5ab',vitor:'#f1cfb8',freddy:'#815133',nicolas:'#f1cdb5'},skin=skins[type],shade=type==='freddy'?'#52372a':'#bd947b';
    const coats={davi:'#252c31',vitor:'#a9afb1',freddy:'#34424a',nicolas:supreme?'#e0bc69':'#e7e1c9'},coat=coats[type],edge=type==='vitor'?'#737f85':type==='nicolas'?'#8f6746':'#18272e';
    const belly=type==='davi',strong=false,slim=type==='freddy',wide=belly?18:slim?9:12,legCol=type==='davi'?'#3d4852':type==='vitor'?'#384d61':type==='freddy'?'#493d42':'#3d5268';
    if(supreme){supremeAura(c,t,o);poly(c,[[-17,-44],[-35-Math.sin(t*3)*4,-5],[-21,1],[-13,-9],[14,-8],[27,2],[40+Math.sin(t*3)*4,-5],[17,-44]],'#245967');poly(c,[[-17,-42],[-29,-3],[-17,-8],[-10,-38]],'#68b5bb');r(c,-18,-41,38,4,'#f5d58a');}
    oval(c,0,-1,belly?23:strong?21:17,3,'#2e433d',2);
    for(const side of [-1,1]){let fx=side*7+Math.round(walk*12*side),fy=moving?Math.max(0,Math.cos(t*9+(side>0?0:Math.PI)))*6:0;if(o.grounded===false){fx=side>0?10:-12;fy=side>0?3:11;}
      limb(c,[[side*7,-25],[side*7+walk*side*4,-12],[fx,-4-fy]],strong?11:slim?7:9,'#27333a');limb(c,[[side*7,-25],[side*7+walk*side*4,-12],[fx,-4-fy]],strong?7:slim?4:5,legCol);
      r(c,fx-4,-6-fy,13,6,'#26353a');r(c,fx-3,-2-fy,11,2,type==='nicolas'?'#ede8d7':'#b6b8a6');if(supreme)r(c,fx-3,-5-fy,10,2,'#efce7b');}
    c.translate(o.dash?5:Math.round(walk*1.5),-bob);
    let leftHand=[-wide-5+Math.round(walk*7),-18],rightHand=[wide+5-Math.round(walk*7),-18];
    if(type==='davi'&&!moving){rightHand=[wide+17,-29+Math.round(Math.sin(t*3)*3)];leftHand=[-wide-7,-25];}
    if(type==='vitor'&&!moving){rightHand=[wide+12,-27+Math.round(Math.sin(t*2)*2)];leftHand=[-wide-2,-23];}
    if(type==='freddy'&&!moving){leftHand=[-11,-34];rightHand=[25,-27];}
    if(type==='nicolas'&&!moving){rightHand=[28,-35+Math.round(Math.sin(t*2)*3)];leftHand=[-14,-21];}
    if(attack){rightHand=[27+strike*19,-34-strike*12];leftHand=[-13,-36];}
    if(o.charging){leftHand=[-27,-24];rightHand=[27,-24];}
    if(o.pose==='fistbump'||o.gesture==='fistbump')rightHand=[38,-35];
    function hand(side,front){const end=side>0?rightHand:leftHand,shoulder=[side*wide,-36],elbow=[side*(wide+5),-27+Math.round(walk*side*3)];limb(c,[shoulder,elbow,end],strong?11:slim?6:8,'#243137');limb(c,[shoulder,elbow],strong?7:slim?4:5,coat);limb(c,[elbow,end],strong?7:slim?4:5,type==='freddy'?skin:coat);r(c,end[0]-3,end[1]-3,strong?8:6,strong?7:6,skin);if(type==='freddy'){r(c,end[0]-4,end[1]-2,9,3,'#c4b690');}}
    hand(-1,false);
    if(belly){oval(c,1,-30,23,20,'#202a31',2);oval(c,1,-31,20,17,coat,2);r(c,-14,-20,31,3,'#151f25');r(c,-9,-28,22,9,'#303940');r(c,-7,-27,18,2,'#47504f');}
    else{poly(c,[[-wide-1,-42],[wide+2,-42],[wide,-17],[-wide,-17]],'#243037');poly(c,[[-wide+1,-40],[wide,-40],[wide-2,-19],[-wide+2,-19]],coat);r(c,-wide+3,-38,3,17,type==='vitor'?'#cdd0c9':type==='freddy'?'#657273':supreme?'#ffe6a4':'#f8f0d9');r(c,-wide+2,-21,wide*2-2,3,edge);}
    if(['davi','vitor'].includes(type)){r(c,-7,-42,16,8,edge);r(c,-5,-40,12,5,type==='vitor'?'#c5c8c2':'#3a4244');r(c,-5,-35,2,12,'#d8d2bc');r(c,6,-35,2,12,'#d8d2bc');}
    if(type==='freddy'){r(c,-12,-37,26,3,'#8b6753');poly(c,[[-9,-38],[-5,-31],[5,-29],[12,-36],[10,-35],[4,-32],[-4,-34]],'#c4a268');r(c,1,-31,6,6,'#dfbb72');r(c,3,-30,2,3,'#866745');r(c,-9,-25,19,4,'#25343a');}
    if(type==='nicolas'){if(supreme){poly(c,[[-16,-41],[-10,-46],[0,-38],[10,-46],[17,-40],[11,-26],[0,-21],[-11,-26]],'#9c783b');poly(c,[[-12,-40],[-8,-42],[0,-35],[8,-42],[13,-40],[8,-29],[0,-25],[-8,-29]],'#eed28a');r(c,-2,-34,5,5,'#8be0dc');r(c,-15,-42,7,5,'#d8b469');r(c,9,-42,7,5,'#f4dda0');}else{r(c,-11,-38,5,17,'#647f96');r(c,9,-38,4,17,'#647f96');r(c,0,-35,4,7,'#c6944d');}}
    hand(1,true);
    r(c,-4,-45,10,8,shade);r(c,-3,-45,8,8,skin);r(c,-12,-61,27,21,'#2c3030');r(c,-10,-59,23,18,skin);r(c,-11,-55,3,12,shade);r(c,12,-53,4,6,skin);r(c,3,-53,3,3,'#2d3031');r(c,12,-48,4,2,shade);r(c,2,-44,8,2,shade);
    if(type==='freddy'){oval(c,0,-63,15,8,'#1c2528',2);r(c,-15,-63,30,8,'#1c2528');for(let i=0;i<8;i++){const xx=-13+i*4,yy=-57+(i%2);oval(c,xx,yy,3,4,i%2?'#28322e':'#1b2427',2);r(c,xx,yy-2,1,1,'#485149');}r(c,-14,-58,4,10,'#1c2528');r(c,11,-59,3,7,'#1c2528');r(c,-2,-55,10,2,'#382b29');r(c,1,-45,10,3,'#472e26');r(c,3,-45,8,1,'#e2c6a5');}
    else{const hair=type==='vitor'?'#20292e':type==='davi'?'#634a37':'#72533c';r(c,-12,-63,26,type==='vitor'?7:10,hair);r(c,-9,-65,20,type==='vitor'?3:5,hair);r(c,-12,-58,4,8,hair);r(c,11,-58,4,5,hair);r(c,-8,-62,14,2,type==='vitor'?'#3c4446':type==='davi'?'#866548':'#9a7650');if(type==='davi')r(c,-4,-65,14,2,'#8c6847');}
    if(type==='vitor'){r(c,-7,-55,11,7,'#28373f');r(c,5,-55,11,7,'#28373f');r(c,-5,-53,7,3,'#b8d2d3');r(c,7,-53,7,3,'#b8d2d3');r(c,3,-53,3,2,'#28373f');r(c,-5,-54,3,1,'#f3eed7');r(c,7,-54,3,1,'#f3eed7');}
    if(type==='davi'){r(c,-3,-44,13,3,'#80563f');r(c,0,-44,8,1,'#f4dcc2');const hx=rightHand[0],hy=rightHand[1];r(c,hx+1,hy-12,9,16,'#17272d');r(c,hx+2,hy-12,7,4,'#c7d2c9');for(let i=0;i<3;i++)r(c,hx+2+i*2,hy-15,1,4,'#e2dfc8');r(c,hx+3,hy-7,4,5,'#607d79');r(c,-6,-33,12,4,'#6e8d88');}
    if(type==='vitor'){const hx=rightHand[0],hy=rightHand[1];r(c,hx+2,hy-9,15,3,'#dac69a');for(let i=0;i<6;i++)r(c,hx+3+i*2,hy-6,1,5,'#dac69a');r(c,leftHand[0]-4,leftHand[1],11,13,'#ede6d1');r(c,leftHand[0]-2,leftHand[1]+2,2,9,'#b0beb8');}
    if(type==='nicolas'){r(c,-1,-56,10,2,'#805d40');if(supreme){r(c,0,-52,8,2,'#e5fff4');r(c,2,-52,3,2,'#7ce6e1');const orbit=Math.sin(t*3)*3;for(let i=0;i<3;i++){const xx=-13+i*12;r(c,xx,-72-orbit+(i%2)*3,7,2,'#f7d893');r(c,xx+2,-76-orbit+(i%2)*3,2,9,'#f7d893');}r(c,-3,-71-orbit,7,2,'#94ece6');}
      if(o.emotion==='embarrassed'||o.emotion==='confused'){r(c,-7,-47,5,2,'#d99b8b');r(c,9,-47,5,2,'#d99b8b');r(c,1,-43,8,2,'#8e6551');}else{r(c,2,-44,10,2,'#855e43');r(c,4,-44,6,1,'#f9e7c9');}
      if(attack&&supreme){const hx=rightHand[0],hy=rightHand[1];oval(c,hx+9,hy-2,7+strike*6,7+strike*6,'#83d8d9',2);oval(c,hx+9,hy-2,3+strike*3,3+strike*3,'#fff0b2',2);for(let i=0;i<3;i++)r(c,hx+18+i*5,hy-4+i*3,3,2,'#c3f3e5');}}
    if(attack&&type==='freddy'){limb(c,[[27,-48],[39,-41],[47,-32]],2,'#efcb8a');r(c,42,-33,10,2,'#ffe4a5');}
    if(o.dash){r(c,-39,-45,16,2,supreme?'#a1eeeb':'#d7b184');r(c,-48,-31,21,2,supreme?'#f9dfa0':'#aa8a78');}
    if(o.hit){c.save();c.globalAlpha*=.5;r(c,-wide-6,-66,wide*2+13,65,'#ffe7bd');c.restore();}
    c.restore();
  }

  function smokePuffs(c,x,y,t=0,intensity=1) {
    c.save();const base=c.globalAlpha;
    for(let i=0;i<9;i++){const rise=(t*24+i*11)%103,xx=x+Math.sin(t*.8+i*1.7)*(8+rise*.18),yy=y-rise,sz=6+rise*.1;
      c.globalAlpha=base*(.12+(1-rise/110)*.19)*intensity;oval(c,xx,yy,sz*1.5,sz,'#aac7c8',3);oval(c,xx-3,yy-3,sz,sz*.75,'#e2ebda',3);}
    c.restore();
  }
  /* Social cast share the school uniform, with hair and tiny proportions kept distinct. */
  function socialCharacter(c,type,x,y,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale((o.facing<0?-1:1)*(o.scale||1),o.scale||1);
    if(Number.isFinite(o.opacity))c.globalAlpha*=Math.max(0,Math.min(1,o.opacity));
    const t=Number(o.frame)||0,moving=!!o.moving||Number(o.speed)>8,walk=moving?Math.sin(t*8):0,bob=moving?Math.round(Math.abs(Math.cos(t*8))*2):Math.round(Math.sin(t*2)*.7);
    const receptionist=type==='allef',skin={allef:'#805136',eloisa:'#d9af90',giselle:'#795035',rayssa:'#815338',analaura:'#f2ccb2'}[type],shade=receptionist?'#4e352a':type==='eloisa'?'#b47e61':type==='analaura'?'#be947b':'#4c352c';
    const hair=type==='eloisa'?'#4d372c':type==='analaura'?'#51362d':'#232d2b',pants='#203b60',half=receptionist?18:10;
    oval(c,0,-1,receptionist?23:17,3,'#39483e',2);
    // Loose curls and crochet braids sit behind the body; the face remains unobscured.
    if(!receptionist){
      if(type==='eloisa'){r(c,-14,-64,29,43,hair);r(c,-15,-57,5,42,hair);r(c,11,-56,5,37,hair);r(c,-14,-20,10,3,hair);r(c,8,-22,8,3,hair);}
      else if(type==='giselle'){
        r(c,-14,-63,29,25,hair);
        for(let strand=0;strand<7;strand++){const hx=-15+strand*5,lean=Math.sin(t*1.7+strand)*.7;for(let j=0;j<12;j++){const yy=-60+j*3;r(c,hx+lean+(j%2),yy,4,4,j%3?'#25302e':'#3a4238');r(c,hx+1+lean+(j%2),yy,1,2,'#626151');}r(c,hx+1,-24+(strand%2)*3,2,3,'#bca67e');}
      }else{
        const long=type==='analaura';
        oval(c,0,-57,19,long?22:19,hair,2);
        for(const side of [-1,1])for(let i=0;i<(long?10:6);i++){const yy=-61+i*4,xx=side*(14+Math.sin(i*1.5+t*.4)*2);oval(c,xx,yy,5,5,i%3===0?(long?'#6a4734':'#303b32'):hair,2);if(i%2===0)r(c,xx-1,yy-2,2,2,long?'#7a543c':'#455044');}
        if(long){oval(c,-13,-22,6,6,hair,2);oval(c,14,-20,6,6,hair,2);}
      }
    }
    for(const side of [-1,1]){const fx=side*(receptionist?7:5)+Math.round(walk*11*side),fy=moving?Math.max(0,Math.cos(t*8+(side>0?0:Math.PI)))*5:0;
      limb(c,[[side*(receptionist?7:4),-23],[side*5,-13],[fx,-4-fy]],receptionist?10:8,'#263640');limb(c,[[side*(receptionist?7:4),-23],[side*5,-13],[fx,-4-fy]],receptionist?6:4,pants);r(c,fx-4,-5-fy,12,5,'#e8e6d7');r(c,fx-3,-2-fy,11,2,'#9dafb1');}
    c.translate(Math.round(walk),-bob);
    let leftHand=[-half-6+Math.round(walk*8),-19],rightHand=[half+6-Math.round(walk*8),-19];
    if(!moving){leftHand=receptionist?[-22,-25]:[-13,-22];rightHand=receptionist?[31,-33+Math.sin(t*3)*3]:[23,-29+Math.sin(t*2.5)*3];}
    if(o.talking){rightHand=[receptionist?34:29,-31+Math.sin(t*6)*5];leftHand=[-half-5,-26+Math.sin(t*3)*2];}
    if(o.pose==='offer'){rightHand=[36,-26];}if(o.pose==='fistbump'){rightHand=[37,-35];}
    function socialArm(side){const end=side>0?rightHand:leftHand,elbow=[side*(half+5),-29+walk*side*3],shoulder=[side*half,-36];limb(c,[shoulder,elbow,end],receptionist?10:7,'#28383d');limb(c,[shoulder,elbow],receptionist?6:4,receptionist?'#3b5260':'#eeeedd');limb(c,[elbow,end],receptionist?6:4,skin);r(c,end[0]-3,end[1]-3,receptionist?7:6,6,skin);
      // The stripe is on anatomical left, so it follows the sprite when he/she turns.
      if(side<0&&!receptionist)limb(c,[[shoulder[0],shoulder[1]+2],[elbow[0]*.7+shoulder[0]*.3,-32]],5,'#22496d');}
    socialArm(-1);
    if(receptionist){oval(c,0,-29,23,19,'#263840',2);oval(c,0,-30,20,16,'#3b5260',2);r(c,-13,-22,28,4,'#283c47');r(c,-7,-29,15,8,'#53717a');r(c,-4,-27,8,2,'#a9b9a4');r(c,-17,-39,34,3,'#6b8690');}
    else{const extra=type==='analaura'?1:0;r(c,-12-extra,-41,26+extra,25,'#293e4b');r(c,-10-extra,-39,22+extra,21,'#f1f0df');r(c,-9-extra,-37,4,17,'#234c73');r(c,-10-extra,-20,22+extra,3,'#213e60');poly(c,[[-6,-40],[0,-35],[7,-40],[5,-34],[0,-31],[-5,-35]],'#294f71');r(c,5,-32,5,5,'#315d7c');r(c,6,-31,3,2,'#c3d7d5');r(c,0,-33,2,13,'#d2d9ce');}
    socialArm(1);r(c,-4,-45,10,8,shade);r(c,-3,-45,8,8,skin);r(c,-12,-61,27,21,'#293431');r(c,-10,-59,23,18,skin);r(c,-11,-55,3,12,shade);r(c,12,-52,4,6,skin);r(c,3,-53,3,3,'#29312e');r(c,12,-48,3,2,shade);
    if(receptionist){
      // Upward black curls, distinct from Freddy's bowl fringe.
      r(c,-12,-63,26,8,hair);poly(c,[[-12,-60],[-13,-68],[-8,-66],[-4,-73],[2,-69],[6,-73],[10,-67],[14,-69],[13,-59]],hair);for(let i=0;i<8;i++){const hx=-11+i*3.5,hy=-66-(i%3===1?7:i%3===2?4:1);oval(c,hx,hy,4,5,i%3===0?'#303b31':hair,2);r(c,hx-1,hy-2,2,2,'#424b3c');}r(c,-12,-58,4,7,hair);r(c,11,-58,4,5,hair);r(c,0,-45,12,o.talking?5:3,'#47352d');r(c,2,-45,8,2,'#ead4ae');if(o.talking)r(c,3,-42,7,2,'#8c6753');r(c,-2,-56,11,2,'#394033');
    }else{
      if(type==='eloisa'){r(c,-13,-64,28,8,hair);r(c,-10,-67,21,5,hair);r(c,-13,-59,5,29,hair);r(c,11,-58,5,33,hair);r(c,-8,-63,7,2,'#76543b');r(c,4,-63,7,2,'#76543b');}
      else if(type==='giselle'){r(c,-13,-64,28,7,hair);for(let i=0;i<6;i++){const hx=-10+i*4;r(c,hx,-65+(i%2),3,7,'#31392f');r(c,hx+1,-64,1,2,'#63614d');}r(c,-13,-58,4,17,hair);r(c,12,-58,4,23,hair);}
      else{for(let i=0;i<8;i++){const hx=-12+i*3.5,hy=-65-(i%3===1?3:0);oval(c,hx,hy,5,5,hair,2);}for(let i=0;i<7;i++){const hx=-11+i*4,hy=-66-(i%3===1?3:0);r(c,hx-1,hy-1,2,2,type==='analaura'?'#7d573e':'#455044');}r(c,-13,-60,5,13,hair);r(c,12,-60,5,15,hair);}
      r(c,1,-55,8,1,'#5c4033');const lip=type==='eloisa'?'#d35e8c':type==='analaura'?'#a96964':'#a06655';r(c,1,-45,10,o.talking?4:2,lip);r(c,3,-45,6,1,type==='eloisa'?'#f4a1c0':'#e1bba2');if(o.talking)r(c,3,-43,6,2,'#674337');
    }
    if(o.hit){c.save();c.globalAlpha*=.4;r(c,-25,-76,52,76,'#f8e8c6');c.restore();}c.restore();
  }
  function rayssaHouse(c,camera,t) {
    // A long, welcoming house: front porch, living-room nooks, kitchen and veranda.
    r(c,0,0,960,440,'#eddcbf');r(c,0,0,960,28,'#40575a');r(c,0,28,960,9,'#b18b63');r(c,0,37,960,4,'#f8e6bc');r(c,0,328,960,112,'#84aaa2');r(c,0,328,960,6,'#416d70');r(c,0,415,960,25,'#537579');
    c.save();c.translate(-Math.round(camera),0);const width=worldWidth(10);
    for(let x=0;x<width;x+=420){r(c,x+12,37,8,290,'#d2ba96');r(c,x+15,39,3,286,'#fff0ce');r(c,x+26,104,321,5,'#d8c49d');}
    // Large windows reveal sky and soft garden shadows behind drifting curtains.
    for(let x=125,i=0;x<width;x+=660,i++){if(x<camera-300||x>camera+1120)continue;r(c,x,130,206,152,'#80684d');r(c,x+6,136,194,140,'#d7e5cf');r(c,x+12,142,182,128,'#8fc7d4');cloud(c,x+27,174,.8,'#f9f2d6');poly(c,[[x+14,267],[x+46,223],[x+90,254],[x+137,213],[x+193,260],[x+193,270],[x+14,270]],'#74a68b');r(c,x+98,137,6,139,'#f1e4c4');r(c,x+7,208,194,5,'#f1e4c4');r(c,x-5,282,216,7,'#b18b5d');r(c,x-13,116,233,7,'#705d48');const flutter=Math.round(Math.sin(t*1.6+i)*3);for(const side of [-1,1]){const cx=side<0?x-3:x+179;poly(c,[[cx,123],[cx+30,123],[cx+27+flutter,253],[cx+7+flutter,262],[cx-3,244]],i%2?'#d6a5a0':'#b9b9cf');for(let j=0;j<3;j++)r(c,cx+4+j*8,127,2,116,'#f1d5bc');}}
    // Original sign above the first gathering corner.
    r(c,344,55,514,53,'#425c5e');r(c,349,60,504,43,'#718c7d');r(c,353,64,496,3,'#bbd2b0');c.fillStyle='#fff0c9';c.font='bold 23px monospace';c.fillText('CASA DE RAYSSA',406,89);c.font='bold 8px monospace';c.fillStyle='#dce7bc';c.fillText('PORTA ABERTA · CAFÉ NA MESA · RESENHA EM DIA',423,101);
    for(let x=350,i=0;x<2050;x+=470,i++){if(x<camera-300||x>camera+1060)continue;r(c,x-18,386,258,43,'#5a5e50');r(c,x-13,342,248,72,i%2?'#b56e68':'#bb8b5b');r(c,x-11,340,244,8,i%2?'#d99987':'#e4b47a');r(c,x-27,367,21,49,i%2?'#a65e5c':'#a7774d');r(c,x+229,367,21,49,i%2?'#a65e5c':'#a7774d');for(let j=0;j<3;j++){r(c,x+3+j*73,355,66,48,i%2?'#c07b70':'#d09e68');r(c,x+6+j*73,357,60,4,i%2?'#dda18d':'#edc18a');}r(c,x+13,415,9,25,'#625844');r(c,x+210,415,9,25,'#625844');r(c,x+24,352,32,31,i%2?'#e4d59d':'#8eafa3');r(c,x+28,356,24,23,i%2?'#f2e3af':'#b7cfb4');r(c,x+186,354,30,28,'#d9b0b5');}
    // Plants and side tables create distinct places to stop and talk.
    for(const x of [70,705,1115,1710,2470,3200]){if(x<camera-100||x>camera+1070)continue;r(c,x,395,44,45,'#94704e');r(c,x-5,389,54,9,'#c29961');r(c,x+6,404,32,2,'#d8b47a');r(c,x+13,372,21,17,'#bf755a');r(c,x+10,369,27,5,'#d99572');for(let j=0;j<5;j++){const xx=x+22+(j-2)*5,yy=354-Math.sin(t+j)*2;limb(c,[[x+23,371],[xx,yy]],2,'#466e4a');oval(c,xx+(j%2?5:-5),yy-2,8,4,j%2?'#6f9c60':'#91b374',2);}}
    // Framed art, a clock and a little mirror make the rooms feel inhabited.
    for(const [x,label,color] of [[1000,'SE TOCA, MENINO','#b08b9c'],[1640,'AFF VEYR JURO','#85a9a6'],[2700,'AQUI TEM RESENHA','#b39268']]){r(c,x,137,205,101,'#76624b');r(c,x+5,142,195,91,'#efdfbd');r(c,x+11,148,183,72,color);poly(c,[[x+28,205],[x+53,169],[x+85,199],[x+116,163],[x+159,205]],'#ead5ae');c.fillStyle='#4b6257';c.font='bold 11px monospace';c.fillText(label,x+12,231);}
    oval(c,2290,142,32,32,'#74614c',3);oval(c,2290,142,26,26,'#f0e3bb',3);for(let j=0;j<12;j++){const a=j*Math.PI/6;r(c,2289+Math.cos(a)*22,141+Math.sin(a)*22,2,2,'#8e7757');}limb(c,[[2290,142],[2290+Math.sin(t*.03)*16,142-Math.cos(t*.03)*16]],2,'#4e5e52');limb(c,[[2290,142],[2278,134]],3,'#4e5e52');
    // Kitchen at the back, with gentle steam over the kettle.
    r(c,2020,297,531,124,'#b3b49a');for(let i=0;i<6;i++){r(c,2026+i*86,305,79,103,'#d4c7a0');r(c,2030+i*86,309,71,3,'#f3e3bb');r(c,2055+i*86,320,20,3,'#7d8673');}r(c,2014,290,543,14,'#7c8572');r(c,2016,290,539,4,'#e6dcc0');r(c,2040,178,271,95,'#758b80');for(let i=0;i<3;i++){r(c,2045+i*89,184,81,82,'#c1c5ab');r(c,2049+i*89,188,73,3,'#e8e3c6');r(c,2077+i*89,247,19,3,'#728574');}r(c,2361,268,97,21,'#5c6c65');oval(c,2410,270,39,9,'#a9bbb0',2);r(c,2408,247,5,26,'#b6c8bd');r(c,2411,245,20,4,'#dbe4ce');r(c,2155,267,35,21,'#736c64');r(c,2153,263,39,6,'#c0b8a0');for(let i=0;i<4;i++){const yy=256-((t*13+i*8)%37),xx=2172+Math.sin(t+i)*5;oval(c,xx,yy,5,3,'#e1e6d19a',2);}
    // Rear veranda and a small tiled rug remain behind the actor band.
    r(c,2900,216,369,198,'#5f8780');r(c,2907,223,355,184,'#a0c1ae');r(c,2920,241,326,151,'#83aeaa');for(let j=0;j<5;j++)r(c,2923+j*65,242,4,149,'#d2dfc3');r(c,2920,310,326,4,'#d2dfc3');r(c,2887,209,395,12,'#3f6a68');
    c.restore();
    // Ceiling fan is distant and screen-relative, keeping motion subtle.
    const fanX=785-camera*.17;c.save();c.translate(fanX,76);r(c,-2,-77,4,75,'#58655a');for(let i=0;i<3;i++){const a=t*5+i*Math.PI*2/3,dx=Math.cos(a),dy=Math.sin(a)*.32;poly(c,[[dx*5-dy*4,dy*5+dx*4],[dx*51-dy*4,dy*51+dx*5],[dx*47+dy*5,dy*47-dx*5],[dx*6+dy*3,dy*6-dx*3]],'#8d9e89');}oval(c,0,0,7,5,'#526c64',2);c.restore();
    for(let i=0;i<12;i++){const dx=((i*137+t*3-camera*.2)%1080+1080)%1080-40,dy=75+(i*33+t*4)%311;r(c,dx,dy,2,2,'#fff1c74d');}
  }

  function storyCharacter(c,type,x,y,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale((o.facing<0?-1:1)*(o.scale||1),o.scale||1);
    if(Number.isFinite(o.opacity))c.globalAlpha*=Math.max(0,Math.min(1,o.opacity));
    const t=Number(o.frame)||0,moving=!!o.moving||Number(o.speed)>8,walk=moving?Math.sin(t*8):0,bob=moving?Math.round(Math.abs(Math.sin(t*8))*2):Math.round(Math.sin(t*2)*.7);
    const skin={dede:'#b98b6c',aica:'#d8ad89',ravile:'#b17d57',arthur:'#f0cdb6'}[type],shadow=type==='arthur'?'#c0947d':type==='aica'?'#af805f':'#815a42';
    const slim=type==='dede'||type==='ravile',bodyHalf=slim?8:11;
    const coat=type==='dede'?'#516563':type==='aica'?'#e5e7d6':type==='ravile'?'#8fafbf':'#6d99a0',pants=type==='dede'?'#3a434d':'#2c435c';
    const helping=type==='aica'&&(o.helping||o.pose==='helping'),earPull=type==='ravile'&&(o.pose==='earpull'||o.gesture==='earpull'),earPulled=type==='arthur'&&(o.pose==='earpulled'||o.gesture==='earpulled');
    const attack=!!o.attack,progress=Number.isFinite(o.attackProgress)?Math.max(0,Math.min(1,o.attackProgress)):.5+.5*Math.sin(t*6),strike=attack?Math.sin(progress*Math.PI):0;
    if(type==='dede'&&o.smoke!==false){smokePuffs(c,-20,-24,t,.8);if(o.smoking||o.smoke||o.charging||o.hiddenInSmoke)smokePuffs(c,24,-33,t+2,o.charging?1.3:.8);}
    oval(c,0,-1,slim?14:17,3,'#35453d',2);
    if(type==='ravile'&&(o.injured||o.fallen)){
      // A readable, non-graphic resting pose: she holds a bent knee until helped.
      r(c,-41,-20,26,25,'#3b302c');r(c,-40,-24,21,20,'#49372d');r(c,-35,-24,17,18,skin);r(c,-36,-20,3,12,shadow);r(c,-34,-13,7,1,'#4a392f');r(c,-24,-13,5,1,'#4a392f');r(c,-27,-7,6,2,'#7d503c');
      poly(c,[[-21,-12],[1,-15],[18,-10],[14,-4],[-21,-4]],'#2b3f4e');poly(c,[[-20,-10],[2,-13],[14,-9],[11,-5],[-20,-5]],coat);
      limb(c,[[10,-6],[22,-25],[36,-8]],6,'#263b4e');limb(c,[[10,-6],[22,-25],[36,-8]],3,pants);limb(c,[[9,-5],[27,-3],[44,-3]],6,'#263b4e');r(c,33,-9,14,7,'#ecdfc1');r(c,40,-5,13,5,'#e8dfc8');
      limb(c,[[-11,-12],[5,-22],[22,-19]],5,'#2b3c44');limb(c,[[-11,-12],[5,-22]],3,coat);limb(c,[[5,-22],[22,-19]],3,skin);r(c,19,-22,6,6,skin);
      for(let i=0;i<3;i++){const xx=-33+i*12,yy=-35-Math.sin(t*2+i)*3;r(c,xx,yy,3,3,'#efd78a');r(c,xx-2,yy+1,7,1,'#efd78a');}c.restore();return;
    }
    if(type==='dede'&&o.hiddenInSmoke)c.globalAlpha*=.66;
    const hip=type==='arthur'?Math.sin(t*(moving?4:2))*2.3:0;
    // Long, straight hair sits behind shoulders rather than resembling a hood.
    if(type==='aica'||type==='ravile'){const hair=type==='aica'?'#4d392f':'#362f2b';r(c,-15,-62,29,42,hair);r(c,-14,-56,5,39,hair);r(c,10,-53,5,35,hair);r(c,-13,-21,8,3,hair);r(c,7,-21,7,3,hair);}
    for(const side of [-1,1]){
      let footX=side*(slim?5:6)+Math.round(walk*11*side),footY=moving?Math.max(0,Math.cos(t*8+(side>0?0:Math.PI)))*5:0;
      if(o.grounded===false){footX=side>0?11:-9;footY=side>0?3:10;}
      if(helping){footX=side>0?18:-9;footY=0;limb(c,[[side*5,-17],[side>0?11:-15,-6],[footX,-3]],8,'#263c4b');limb(c,[[side*5,-17],[side>0?11:-15,-6],[footX,-3]],5,pants);}
      else{limb(c,[[side*(slim?4:5)+hip,-24],[side*(slim?4:5)+hip*.5,-13],[footX,-4-footY]],slim?6:9,'#263a47');limb(c,[[side*(slim?4:5)+hip,-24],[side*(slim?4:5)+hip*.5,-13],[footX,-4-footY]],slim?3:5,pants);}
      r(c,footX-4,-5-footY,12,5,type==='dede'?'#26363b':'#e8e4d5');r(c,footX-3,-2-footY,11,2,type==='dede'?'#aab5a4':'#98afb0');
    }
    c.translate((o.dash?5:walk)+hip,-bob+(helping?16:0));
    let leftHand=[-16+walk*7,-19],rightHand=[17-walk*7,-19];
    if(type==='dede'){leftHand=[-22,-29];rightHand=[26,-35+Math.sin(t*3)*3];}
    if(type==='aica'&&!moving){leftHand=[-11,-21];rightHand=[20,-26+Math.sin(t*2)*2];}
    if(helping){leftHand=[-12,-13];rightHand=[35,-15];}
    if(type==='ravile'&&!moving){leftHand=[-13,-20];rightHand=[19,-24];}
    if(type==='arthur'&&!moving){leftHand=[-9,-24];rightHand=[26+Math.sin(t*2)*3,-35+Math.sin(t*3)*4];}
    if(type==='arthur'&&moving){leftHand=[-13+walk*10,-27+Math.cos(t*4)*5];rightHand=[18-walk*8,-30-Math.cos(t*4)*6];}
    if(attack){rightHand=type==='arthur'?[27+strike*20,-37-strike*5]:[27+strike*12,-35-strike*11];leftHand=[-13,-34];}
    if(o.charging&&type==='dede'){leftHand=[-28,-30];rightHand=[29,-35];}
    if(earPull){rightHand=[59,-53];leftHand=[-11,-25];}
    if(earPulled){leftHand=[-17,-49];rightHand=[-6,-42];}
    function arm(side){const end=side>0?rightHand:leftHand,elbow=[side>0?(slim?15:18):-(slim?14:17),-29+walk*side*3];limb(c,[[side*bodyHalf,-36],elbow,end],slim?6:8,'#293a40');limb(c,[[side*bodyHalf,-36],elbow],slim?3:5,coat);limb(c,[elbow,end],slim?3:5,type==='dede'?coat:skin);r(c,end[0]-3,end[1]-3,6,6,skin);}
    arm(-1);r(c,-bodyHalf-2,-41,bodyHalf*2+5,25,'#263b43');r(c,-bodyHalf,-39,bodyHalf*2+1,21,coat);r(c,-bodyHalf+1,-36,2,13,type==='dede'?'#788b80':'#d7e3dc');r(c,-bodyHalf,-21,bodyHalf*2+1,3,type==='dede'?'#334748':'#325577');
    if(type==='dede'){poly(c,[[-9,-40],[-3,-43],[0,-29],[-6,-34]],'#9ba797');poly(c,[[9,-40],[3,-43],[0,-29],[6,-34]],'#7c968d');r(c,0,-28,2,9,'#c6c4a2');r(c,-7,-27,5,1,'#bfd2ba');}
    else{poly(c,[[-7,-40],[0,-34],[7,-40],[5,-33],[0,-30],[-5,-33]],'#214d6e');r(c,5,-32,5,5,'#315c7e');r(c,6,-31,3,2,'#b9d8d9');}
    arm(1);r(c,-4,-45,10,8,shadow);r(c,-3,-45,8,8,skin);r(c,-12,-61,27,21,'#2b3435');r(c,-10,-59,23,18,skin);r(c,-11,-55,3,12,shadow);r(c,12,-52,4,6,skin);r(c,3,-53,3,3,'#2d3334');r(c,12,-48,3,2,shadow);r(c,2,-44,8,2,shadow);
    if(type==='arthur'){
      // Short buzz stubble and glasses; his hands and hips carry the expression.
      oval(c,0,-60,12,9,skin,2);r(c,-9,-65,19,2,'#d2b89b');for(let i=0;i<12;i++)r(c,-10+(i%7)*3,-64+Math.floor(i/7)*3+(i%2),1,1,'#676758');r(c,-12,-56,2,7,'#727566');
      r(c,-7,-55,11,7,'#263d49');r(c,5,-55,11,7,'#263d49');r(c,-5,-53,7,3,'#c5d9d7');r(c,7,-53,7,3,'#c5d9d7');r(c,3,-53,3,2,'#263d49');r(c,-4,-54,3,1,'#f6eed7');r(c,8,-54,3,1,'#f6eed7');
      const hx=rightHand[0],hy=rightHand[1];if(!earPulled){r(c,hx-2,hy-5,4,9,skin);for(let i=0;i<3;i++)r(c,hx+1+i*2,hy-5+i,1,5,skin);r(c,hx-4,hy-1,3,2,skin);}
      if(earPulled){r(c,-17,-55,7,7,skin);r(c,-18,-54,3,5,'#d5967c');r(c,0,-44,10,4,'#986549');r(c,2,-44,6,2,'#f5e1c5');r(c,5,-42,3,2,'#b78064');}
      if(attack){r(c,hx-2,hy-6,9,12,skin);for(let i=0;i<4;i++)r(c,hx-3+i*3,hy-9,2,6,skin);limb(c,[[hx+4,hy-17],[hx+15,hy-10],[hx+20,hy+2]],2,'#f8dba3');limb(c,[[hx+10,hy-19],[hx+22,hy-10],[hx+26,hy+1]],2,'#d68d85');}
    }else if(type==='dede'){
      // Short upward dark tufts and a clear smile make his braces readable at game scale.
      r(c,-12,-63,25,7,'#252f2d');poly(c,[[-11,-61],[-11,-66],[-7,-64],[-6,-68],[-2,-65],[1,-70],[4,-65],[8,-68],[10,-64],[14,-66],[13,-60]],'#26322d');r(c,-8,-64,6,2,'#465044');r(c,2,-65,5,2,'#414c40');r(c,-12,-57,4,6,'#252f2d');r(c,10,-58,4,5,'#252f2d');
      r(c,0,-46,12,5,'#78513e');r(c,1,-46,10,4,'#f3e2c4');r(c,1,-44,10,1,'#858e92');for(let j=0;j<3;j++){r(c,2+j*3,-45,2,2,'#c6d8dc');r(c,2+j*3,-44,1,1,'#5e7c8c');}r(c,2,-41,8,1,'#a66f51');
      if(o.smoke!==false){const hx=rightHand[0],hy=rightHand[1];smokePuffs(c,hx+4,hy-4,t,1);for(let i=0;i<3;i++){const a=t*2+i*2,xx=hx+Math.cos(a)*13,yy=hy-5+Math.sin(a)*8;r(c,xx,yy,3,2,'#a2d2cf');}}
    }else{
      const hair=type==='aica'?'#4d392f':'#362f2b';r(c,-13,-64,28,9,hair);r(c,-10,-67,22,5,hair);r(c,-13,-59,5,26,hair);r(c,11,-58,4,32,hair);r(c,-9,-63,7,2,type==='aica'?'#77573d':'#65503a');r(c,6,-63,7,2,type==='aica'?'#77573d':'#65503a');
      r(c,-1,-55,9,1,'#624635');r(c,2,-45,9,2,'#8b5b42');r(c,4,-45,5,1,'#ebc7a7');if(type==='aica'&&o.shouting){r(c,0,-45,12,6,'#774a3d');r(c,2,-45,8,2,'#f5dac0');}
      if(earPull){r(c,56,-56,9,7,skin);r(c,62,-56,3,5,shadow);r(c,59,-58,6,3,skin);}
    }
    if(o.dash){r(c,-34,-44,12,2,'#b9d4ca');r(c,-43,-29,18,2,'#e0dfba');}if(o.hit){c.save();c.globalAlpha*=.45;r(c,-18,-66,39,66,'#fff1cd');c.restore();}c.restore();
  }
  function courtyard(c,camera,t) {
    c.save();c.translate(-Math.round(camera),0);const width=worldWidth(9);
    // Open sky, a covered arcade and the school's white/navy facade make this a patio.
    r(c,0,352,width,88,'#cbd5cb');r(c,0,352,width,6,'#f1f0da');r(c,0,390,width,50,'#d9d8c3');
    r(c,0,212,width,144,'#f0f4ef');r(c,0,212,width,9,'#173e65');r(c,0,223,width,4,'#ffffff');r(c,0,322,width,34,'#254f75');r(c,0,322,width,4,'#183d5d');
    for(let x=55;x<width;x+=187){if(x<camera-180||x>camera+1150)continue;r(c,x,244,101,64,'#294e68');r(c,x+5,249,91,54,'#7bafb7');r(c,x+9,253,36,20,'#c2dfe0');r(c,x+51,278,40,20,'#9fc8c9');r(c,x+47,249,4,54,'#e6eee1');r(c,x+5,275,91,4,'#e6eee1');r(c,x-4,308,109,5,'#acbcb7');}
    // A high blue awning and spaced columns leave the front actor band clear.
    r(c,10,187,width-20,14,'#163e63');r(c,10,187,width-20,4,'#457c9d');for(let x=22;x<width;x+=365){r(c,x,200,11,156,'#becfcf');r(c,x+2,201,4,153,'#f7f9ec');r(c,x-4,349,19,8,'#7eaaad');}
    r(c,333,229,400,43,'#1b4467');c.fillStyle='#f0f4e6';c.font='bold 18px monospace';c.fillText('COLÉGIO ADVENTISTA',357,255);c.font='bold 9px monospace';c.fillStyle='#a9d5da';c.fillText('PÁTIO · UM RECREIO DE MUITAS HISTÓRIAS',356,267);
    for(const x of [70,1220,2170,3490]){if(x<camera-150||x>camera+1120)continue;tree(c,x,428,.72,1);oval(c,x,432,55,8,'#6e9b8b',3);r(c,x-49,426,97,10,'#436d72');r(c,x-46,426,91,3,'#b2d1bd');}
    for(const x of [90,1460,1980,3370]){if(x<camera-200||x>camera+1120)continue;r(c,x,396,130,10,'#2c5e8e');r(c,x+4,399,122,3,'#6296b7');r(c,x+9,406,7,33,'#587e8d');r(c,x+113,406,7,33,'#587e8d');r(c,x,372,130,7,'#386e9d');r(c,x,385,130,6,'#386e9d');for(let j=0;j<2;j++)backgroundCitizen(c,x+40+j*43,400,t,Math.floor(x/90)+j,true);}
    for(let x=750;x<width;x+=850){r(c,x,165,5,188,'#365f75');r(c,x-9,152,24,15,'#244b69');r(c,x-6,155,18,7,'#fff0b4');}
    // Banners move gently above the arcade, with a bird settling on the roof.
    r(c,1640,143,833,2,'#557e85');for(let i=0;i<18;i++){const xx=1650+i*45;poly(c,[[xx,145],[xx+22,145],[xx+13,166+Math.sin(t*2+i)*3]],i%3===0?'#659fbe':i%3===1?'#f1e4ba':'#94bc9b');}
    const pigeonX=1020+Math.sin(t*.8)*5;r(c,pigeonX,180,9,7,'#9caaa9');r(c,pigeonX+7,176,5,8,'#c6ccc3');r(c,pigeonX+10,178,2,1,'#3d5b62');r(c,pigeonX+12,181,3,1,'#ba9d60');r(c,pigeonX+1,187,2,3,'#b59872');r(c,pigeonX+6,187,2,3,'#b59872');
    r(c,3770,282,190,50,'#32617b');c.fillStyle='#e8efdc';c.font='bold 13px monospace';c.fillText('RESPEITO & RESENHA',3780,305);c.font='bold 9px monospace';c.fillText('TODO MUNDO TEM VEZ.',3799,322);c.restore();
  }
  function questArena(c,type,camera,t,homeX) {
    c.save();const center=homeX?homeX-camera:480;
    if(type==='arthur'){
      sky(c,9,0,t);courtyard(c,Math.max(0,homeX-480),t);c.save();c.translate(Math.round(center-480),0);
      r(c,217,118,528,46,'#16476a');r(c,223,124,516,34,'#2d6686');c.fillStyle='#eff2d8';c.font='bold 21px monospace';c.fillText('UM ACERTO NO PÁTIO',354,148);
      for(const x of [110,809]){r(c,x,331,49,104,'#315d7a');r(c,x+4,335,41,96,'#527c91');r(c,x-8,326,65,9,'#bed4cf');r(c,x+9,348,24,2,'#91b5b8');r(c,x+9,367,24,2,'#91b5b8');}
      // Chalk arcs resemble open palms, keeping the conflict cartoon-like.
      for(let i=0;i<6;i++){const xx=191+i*112,yy=301+Math.sin(t+i)*4;r(c,xx,yy,20,2,'#b6d8d5');r(c,xx+4,yy-7,2,7,'#b6d8d5');r(c,xx+10,yy-9,2,9,'#b6d8d5');r(c,xx+16,yy-6,2,6,'#b6d8d5');}
      c.restore();r(c,0,440,960,100,'#bacbc7');r(c,0,440,960,6,'#f3efcf');for(let i=0;i<18;i++){r(c,i*59,451,1,89,'#80a6aa');r(c,i*59+6,479,45,2,'#dfe7d4');}c.restore();return;
    }
    r(c,0,0,960,440,'#254858');r(c,0,155,960,285,'#537f84');c.save();c.translate(Math.round(center-480),0);
    for(let i=-1;i<9;i++){const xx=i*139,hh=103+hash(i+91)*108;favelaHouse(c,xx,356-hh,128,hh,i+9,t,true);r(c,xx+9,365-hh,22,25,'#b3c6aa');r(c,xx+13,369-hh,13,16,'#f1d7a4');}
    r(c,-200,350,1360,90,'#536766');r(c,-200,347,1360,9,'#a6bcb0');for(let i=0;i<20;i++)r(c,-150+i*69,363,2,76,'#8b9a8b');
    for(const x of [95,791]){r(c,x,117,73,231,'#364e56');r(c,x+6,123,61,221,'#6c8582');for(let j=0;j<4;j++)r(c,x+8,147+j*45,56,3,'#455f65');r(c,x-8,107,89,16,'#b6b9a0');smokePuffs(c,x+36,103,t+x*.03,.8);}
    r(c,257,177,451,43,'#263f4b');c.fillStyle='#dbe6ce';c.font='bold 19px monospace';c.fillText('DEDÊ · ENTRE AS NUVENS',285,205);
    // Low-opacity drifting smoke belongs behind the combatants, never a blank screen.
    for(let i=0;i<7;i++){c.save();c.globalAlpha*=.16;const xx=-100+((i*177+t*12)%1220),yy=220+Math.sin(t*.7+i)*25;oval(c,xx,yy,75,20,'#c3d5cb',4);oval(c,xx+40,yy-16,61,25,'#dce5d3',4);c.restore();}
    c.restore();r(c,0,440,960,100,'#5b7474');r(c,0,440,960,6,'#bfd6c5');for(let i=0;i<18;i++){r(c,i*59,451,1,89,'#3c5b65');r(c,i*59+6,480,33,2,'#90aaa1');}c.restore();
  }
  function rat(c,x,y,t=0,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale((o.facing<0?-1:1)*(o.scale||1),o.scale||1);const step=Math.sin(t*18)*3;
    limb(c,[[-13,-8],[-25,-12+Math.sin(t*5)*3],[-35,-6+Math.cos(t*4)*3]],3,'#bd9c8c');oval(c,-2,-10,18,10,'#3f4b4a',2);oval(c,-5,-13,13,6,'#69736c',2);poly(c,[[8,-18],[21,-17],[29,-6],[21,-3],[7,-7]],'#4d5853');oval(c,11,-20,6,6,'#3d4a45',2);oval(c,11,-20,3,3,'#ae8b83',2);r(c,21,-13,3,3,'#1f3337');r(c,21,-13,1,1,'#f3e8c8');r(c,27,-7,3,3,'#bc8c85');
    for(const side of [-1,1]){r(c,-12+side*3,-2-Math.max(0,step*side),9,3,'#a99a82');r(c,7+side*3,-2-Math.max(0,-step*side),9,3,'#a99a82');}limb(c,[[23,-5],[34,-9]],1,'#d3c7aa');limb(c,[[23,-5],[35,-3]],1,'#d3c7aa');if(o.hit){c.globalAlpha*=.5;oval(c,0,-10,22,13,'#f5dfbd',2);}c.restore();
  }
  function strangeMinion(c,x,y,t=0,kind='spindle',o={}) {
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(o.facing<0?-1:1,1);const bob=Math.round(Math.sin(t*6)*3);oval(c,0,-1,24,4,'#37413b',2);c.translate(0,-bob);
    if(kind==='spindle'){
      poly(c,[[-20,-42],[0,-57],[22,-42],[12,-23],[0,-10],[-13,-24]],'#333346');poly(c,[[-16,-41],[0,-52],[17,-41],[8,-25],[0,-15],[-9,-26]],'#aa81b2');r(c,-18,-40,37,5,'#e4b9c7');r(c,-11,-31,23,3,'#e8d2b1');r(c,-3,-56,6,8,'#739da4');oval(c,0,-39,8,10,'#d7edc9',2);r(c,1,-41,3,6,'#42394b');limb(c,[[-13,-27],[-31,-20],[-27,-13]],4,'#bca1c2');limb(c,[[13,-27],[31,-34],[34,-23]],4,'#bca1c2');for(let i=0;i<3;i++)r(c,-32+i*23,-5+(i%2)*2,15,3,'#a5c0bb');if(Math.sin(t*13)>0){r(c,-30,-44,8,2,'#d7bdcf');r(c,24,-23,10,2,'#d7bdcf');}
    }else if(kind==='wobbler'){
      const sway=Math.sin(t*5)*3;poly(c,[[-21,-40],[-13,-55],[8,-55],[22,-43],[20,-13],[3,-7],[-18,-14]],'#36443e');poly(c,[[-18,-39],[-10,-51],[8,-51],[18,-42],[16,-15],[2,-11],[-15,-17]],'#8ac29a');r(c,-10,-48,17,3,'#c3e0ac');for(let i=0;i<3;i++){oval(c,-11+i*10,-34-(i%2)*8,5,7,'#eef0c6',2);r(c,-10+i*10,-34-(i%2)*8,2,4,'#3c4640');}r(c,-7,-22,17,5,'#466052');r(c,0,-18,7,6,'#cb9e9a');for(const side of [-1,1]){limb(c,[[side*15,-30],[side*29+sway,-28],[side*31,-18]],4,'#9fc5a7');r(c,side>0?8:-18,-8,13,9,'#627d74');r(c,side>0?11:-17,-2,13,4,'#d8d6b2');}
    }else{
      oval(c,0,-23,26,13,'#3d3b44',2);poly(c,[[-25,-24],[25,-24],[18,-8],[8,-3],[-9,-3],[-19,-8]],'#a66955');oval(c,0,-25,24,8,'#d8bd84',2);for(let i=0;i<10;i++){const xx=-20+i*4,yy=-29-Math.sin(t*2+i)*2;limb(c,[[xx,yy],[xx-3,-39-i%3*3],[xx+4,-45+i%3],[xx+7,-35]],3,i%2?'#e3c780':'#f4dfa1');}r(c,-12,-29,6,8,'#f5edd4');r(c,6,-29,6,8,'#f5edd4');r(c,-9,-27,2,4,'#493e3a');r(c,8,-27,2,4,'#493e3a');r(c,-6,-18,15,3,'#633e37');r(c,-20,-5,12,7,'#3e5364');r(c,10,-5,12,7,'#3e5364');limb(c,[[-20,-20],[-33,-30],[-31,-42]],4,'#a0b6ae');for(let i=0;i<3;i++)r(c,-35+i*3,-48,2,10,'#d4d7bd');limb(c,[[20,-19],[31,-24],[36,-16]],4,'#a0b6ae');
    }if(o.hit){c.save();c.globalAlpha*=.45;r(c,-28,-58,57,61,'#ffe5cb');c.restore();}c.restore();
  }
  function acai(c,x,y,t=0,o={}) {
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(o.scale||1,o.scale||1);oval(c,0,-1,26,5,'#354c43',2);poly(c,[[-27,-24],[27,-24],[21,-5],[10,1],[-11,1],[-22,-5]],'#573b42');poly(c,[[-23,-21],[23,-21],[18,-7],[9,-3],[-9,-3],[-18,-7]],'#b87155');r(c,-14,-13,29,3,'#dbb27a');oval(c,0,-25,28,10,'#e2c6a0',2);oval(c,0,-26,24,8,'#542c61',2);oval(c,-3,-29,17,5,'#744071',2);r(c,-18,-27,11,2,'#976489');
    for(let i=0;i<5;i++){const xx=-15+i*7,yy=-29+(i%2)*4;oval(c,xx,yy,5,3,'#eee1a0',1);r(c,xx-1,yy-1,2,2,'#b79c67');}
    for(let i=0;i<12;i++){const xx=(hash(i+42)-.5)*39,yy=-31+hash(i+61)*11;r(c,xx,yy,2,2,i%2?'#c99653':'#efd09a');}limb(c,[[17,-28],[31,-48]],3,'#b7c9c0');oval(c,33,-51,5,7,'#d8e2d3',2);r(c,32,-55,2,6,'#f4efdc');c.restore();
  }

  function schoolMonitor(c,type,x,y,o={}) {
    c.save();c.translate(Math.round(x),Math.round(y));c.scale((o.facing<0?-1:1)*(o.scale||1),o.scale||1);const t=Number(o.frame)||0,moving=!!o.moving,walk=moving?Math.sin(t*7)*4:0,skin=type==='igor'?'#e7a079':'#f0cbb4',ink='#34404b';
    oval(c,0,1,type==='igor'?27:19,4,'#243b3c55',3);
    if(type==='igor'&&o.bellyRolling){c.translate(0,-36);c.rotate(o.rollAngle||0);oval(c,0,0,35,36,ink,3);oval(c,0,1,32,33,o.monitorBattle?'#277ab8':'#e3a47b',3);oval(c,3,4,24,24,o.monitorBattle?'#3a96ce':'#efb38c',3);r(c,-3,-3,6,5,o.monitorBattle?'#1c5a91':'#bb785b');r(c,-13,-17,7,3,'#f4c9a0');r(c,6,-17,7,3,'#f4c9a0');r(c,-13,-14,3,4,ink);r(c,9,-14,3,4,ink);r(c,-9,14,18,4,'#765043');r(c,-7,17,14,4,'#5d4237');r(c,-36,-6,7,18,'#4f7391');r(c,28,-6,7,18,'#4f7391');c.restore();return;}
    if(type==='igor'){
      r(c,-18+walk,-23,14,21,'#233a58');r(c,5-walk,-23,14,21,'#233a58');r(c,-21+walk,-8,20,8,'#edf0dd');r(c,3-walk,-8,20,8,'#edf0dd');
      oval(c,0,-40,31,32,ink,3);oval(c,0,-41,28,29,o.monitorBattle?'#226ca8':'#7c8075',3);oval(c,5,-38,25,23,o.monitorBattle?'#318ac3':skin,3);oval(c,8,-39,19,18,o.monitorBattle?'#45a0d2':'#efb28b',3);r(c,6,-39,5,4,o.monitorBattle?'#246caa':'#bc7b5d');if(o.monitorBattle){r(c,-17,-25,37,4,'#1d568c');r(c,-2,-50,19,3,'#77c1e4');r(c,11,-29,10,3,'#266da7');r(c,-27,-62,12,12,'#2b7bb6');r(c,19,-62,12,12,'#2b7bb6');}r(c,-15,-61,10,17,'#d3d9cb');r(c,-13,-58,6,11,'#e4c87c');
      limb(c,[[-25,-57],[-33,-38+walk],[-29,-28+walk]],9,ink);limb(c,[[-25,-57],[-33,-38+walk],[-29,-28+walk]],6,skin);limb(c,[[25,-58],[34,-39-walk],[29,-26-walk]],9,ink);limb(c,[[25,-58],[34,-39-walk],[29,-26-walk]],6,skin);
      oval(c,-1,-74,19,16,ink,3);oval(c,-1,-75,17,14,skin,3);r(c,-9,-88,12,3,'#ffd5ac');r(c,-12,-77,7,2,'#72503e');r(c,4,-77,7,2,'#72503e');r(c,-10,-74,3,4,'#30353b');r(c,5,-74,3,4,'#30353b');r(c,-4,-70,7,4,'#c18462');r(c,-10,-64,19,5,'#654c3e');r(c,-6,-60,12,4,'#654c3e');r(c,-5,-65,10,2,'#f3c4a4');
    }else{
      limb(c,[[-6,-39],[-10+walk,-20],[-10+walk,-5]],8,ink);limb(c,[[-6,-39],[-10+walk,-20],[-10+walk,-5]],5,'#233b59');limb(c,[[6,-39],[10-walk,-19],[10-walk,-5]],8,ink);limb(c,[[6,-39],[10-walk,-19],[10-walk,-5]],5,'#233b59');r(c,-14+walk,-6,14,6,'#dbe6df');r(c,4-walk,-6,14,6,'#dbe6df');
      r(c,-12,-79,25,43,ink);r(c,-10,-77,21,39,'#edf0dd');r(c,-10,-77,21,10,'#396b92');r(c,-5,-67,3,25,'#2b5f86');r(c,3,-65,7,9,'#d8ba6b');r(c,-4,-85,8,10,skin);
      oval(c,0,-94,13,15,ink,2);oval(c,0,-94,11,13,skin,2);r(c,-12,-109,24,10,'#232930');r(c,-12,-101,4,10,'#232930');r(c,-8,-95,5,2,ink);r(c,4,-95,5,2,ink);r(c,-7,-92,3,3,o.rage?'#ec6668':'#25313b');r(c,5,-92,3,3,o.rage?'#ec6668':'#25313b');r(c,-7,-84,16,6,'#282d32');r(c,-4,-84,9,2,'#e6bba2');
      const aiming=o.monitorBattle;limb(c,[[-12,-72],[-17,-57],[aiming?18:-13,-50]],6,ink);limb(c,[[-12,-72],[-17,-57],[aiming?18:-13,-50]],4,skin);limb(c,[[12,-72],[19,-57],[aiming?33:19,-50]],6,ink);limb(c,[[12,-72],[19,-57],[aiming?33:19,-50]],4,skin);
      if(aiming){r(c,10,-56,38,11,'#34454a');r(c,22,-59,21,4,'#4f6467');r(c,35,-54,22,5,'#223338');r(c,19,-45,9,15,'#34454a');r(c,24,-43,9,11,'#667675');r(c,7,-53,9,5,'#a58c66');if(o.firing&&Math.sin(t*35)>.1){poly(c,[[57,-55],[69,-60],[65,-52],[74,-49],[62,-48]],'#ffd888');}}
    }
    if(o.rage){r(c,-10,type==='igor'?-74:-93,4,3,'#f45c68');r(c,5,type==='igor'?-74:-93,4,3,'#f45c68');}if(o.hit){c.globalAlpha*=.45;r(c,-32,type==='igor'?-90:-112,66,type==='igor'?90:112,'#fff3d5');}c.restore();
  }
  // The final villain keeps his first sprite; later forms grow from the same
  // purple clothes, dark hair and potato nose. Bounds describe the body only.
  const nikolasFormGeometry=Object.freeze({
    1:Object.freeze({halfWidth:24,height:66,centerY:33,visualHalfWidth:30}),
    2:Object.freeze({halfWidth:55,height:140,centerY:70,visualHalfWidth:82}),
    3:Object.freeze({halfWidth:55,height:140,centerY:70,visualHalfWidth:82}),
    4:Object.freeze({halfWidth:185,height:340,centerY:170,visualHalfWidth:210})
  });
  const nikolasBounds=phase=>nikolasFormGeometry[Math.max(1,Math.min(4,Math.floor(Number(phase)||1)))];
  function nikolasPowerAura(c,t,phase,amount=1){
    c.save();const p=Math.max(0,Math.min(1,amount));
    if(phase===2){energyAura(c,0,5,t,{scale:1.85,intensity:.6+p*.4,charging:p<1,powered:true});}
    else if(phase===3){
      // A huge energy mantle rises from the body: no wings or ear shapes.
      c.globalAlpha*=.16+p*.15;
      const pulse=Math.round(Math.sin(t*7)*3);
      poly(c,[[-25,14],[-62,5],[-62,-17],[-89,-17],[-89,-44],[-111,-44],[-111,-74],[-126,-74],[-126,-106],[-112,-106],[-112,-143],[-85,-143],[-85,-181],[-52,-181],[-52,-213],[-23,-213],[-23,-240-pulse],[2,-258-pulse],[25,-237],[25,-211],[56,-211],[56,-178],[89,-178],[89,-140],[113,-140],[113,-106],[125,-106],[125,-71],[107,-71],[107,-40],[84,-40],[84,-15],[57,-15],[57,6],[23,16]],'#8c6add');
      c.globalAlpha/=1.4;oval(c,0,-106,93,136,'#f8d779',5);c.globalAlpha*=1.8;
      for(const side of [-1,1]){const xx=side*(104+Math.round(Math.sin(t*9+side)*5));limb(c,[[xx,0],[xx-side*13,-31],[xx+side*7,-61],[xx-side*9,-93],[xx+side*6,-129],[xx-side*15,-159],[side*64,-196],[side*49,-220]],3,'#e4d0ff');limb(c,[[xx,0],[xx-side*13,-31],[xx+side*7,-61],[xx-side*9,-93],[xx+side*6,-129],[xx-side*15,-159],[side*64,-196]],1,'#fff1ba');}
      c.globalAlpha=1;energyAura(c,0,7,t,{scale:2.15,intensity:.76,charging:false,powered:true});
      for(let i=0;i<13;i++){const xx=Math.round(Math.sin(i*2.1+t*.6)*106),yy=20-((t*65+i*23)%270);r(c,xx,yy,3,7,i%3?'#d5b8ff':'#fff1b7');}
    }else{
      c.globalAlpha*=.11+p*.1;oval(c,0,-165,204,186,'#c55970',6);c.globalAlpha*=1.6;
      for(let i=0;i<12;i++){const xx=-194+i*35,yy=-25-((t*37+i*29)%321);r(c,xx,yy,4,12,i%2?'#dc9fb8':'#d7b8ef');}
      for(const side of [-1,1]){limb(c,[[side*161,-18],[side*188,-65],[side*171,-116],[side*199,-161],[side*179,-210],[side*158,-259],[side*121,-304]],4,'#d68ba7');}
    }
    c.restore();
  }
  function nikolasForm(c,x,y,o={}){
    const phase=Math.max(2,Math.min(4,Math.floor(Number(o.bossPhase)||2))),t=Number(o.frame)||0;
    const changing=!!o.phaseChanging||o.state==='phaseChange',p=changing?Math.max(0,Math.min(1,Number(o.transformProgress)||0)):1;
    const ease=v=>v*v*(3-2*v),face=o.facing<0?-1:1;
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));
    if(Number.isFinite(o.opacity))c.globalAlpha*=Math.max(0,Math.min(1,o.opacity));
    nikolasPowerAura(c,t,phase,phase===3?Math.max(.1,p):p);
    if(phase===2&&changing&&p<.34){
      // The same single pair of arms charges before the bright growth beat.
      character(c,'nikolas',0,0,{...o,bossPhase:1,scale:1+ease(p/.34)*.16,charging:true,frame:t,noseRub:false});
      c.restore();return;
    }
    let scale=phase===4?(changing?1.36+(3.30-1.36)*ease(p):3.30):1.36;
    if(phase===2&&changing)scale*=.78+.22*ease(Math.max(0,(p-.34)/.66));
    c.scale(face*scale,scale);
    const skin='#e1b28a',light='#f6d1a3',shade='#a86c4e',ink='#352e34',purple=phase===4?'#805579':'#8c6594',clothLight='#b38bb7',pants='#423e59';
    const breath=Math.round(Math.sin(t*2.5)*.7),attack=!!o.attack||o.state==='windup'||o.state==='firing',charge=changing||o.charging;
    c.translate(0,breath);
    // Heavy shoes and two grounded legs keep the figure readable at every scale.
    r(c,-25,-27,22,25,ink);r(c,4,-27,22,25,ink);r(c,-22,-25,16,22,pants);r(c,7,-25,16,22,pants);r(c,-20,-23,4,16,'#655771');r(c,8,-22,4,16,'#6b5a77');
    r(c,-29,-6,26,6,ink);r(c,3,-6,27,6,ink);r(c,-28,-6,24,3,'#c3b8c3');r(c,5,-6,24,3,'#c3b8c3');r(c,-26,-2,22,2,'#e8d8d0');r(c,6,-2,22,2,'#e8d8d0');
    let backElbow=[-47,-49],backHand=[-47,-29],frontElbow=[49,-49],frontHand=[45,-28];
    const noseX=o.view==='front'?5:23,rubbing=o.noseRub!==false&&!attack&&!charge;
    if(charge){backElbow=[-48,-59];backHand=[-38,-38];frontElbow=[49,-58];frontHand=[39,-38];}
    else if(rubbing){frontElbow=[48,-62];frontHand=[noseX+10,-81+Math.round(Math.sin(t*13)*2)];}
    else if(attack){const strike=Math.max(0,Math.sin(t*8));frontElbow=[46+strike*5,-57];frontHand=[61+strike*3,-49];backElbow=[-46,-53];backHand=[-54,-36];}
    function powerArm(front){
      const elbow=front?frontElbow:backElbow,hand=front?frontHand:backHand,shoulder=[front?31:-31,-67];
      limb(c,[shoulder,elbow,hand],18,ink);limb(c,[shoulder,elbow],14,skin);limb(c,[elbow,hand],12,skin);
      oval(c,(shoulder[0]+elbow[0])*.5,(shoulder[1]+elbow[1])*.5,9,11,skin,2);
      r(c,elbow[0]-5,elbow[1]-7,5,3,light);r(c,elbow[0]-5,elbow[1]+4,9,3,shade);
      r(c,hand[0]-6,hand[1]-6,13,12,ink);r(c,hand[0]-5,hand[1]-5,11,10,skin);r(c,hand[0]-4,hand[1]-4,8,2,light);
      if(phase>=3){limb(c,[[elbow[0]-2,elbow[1]-8],[elbow[0]+2,elbow[1]-1],[hand[0]-2,hand[1]-2]],1,phase===4?'#db939c':'#c2e7cf');}
    }
    powerArm(false);
    // Caleb-like shoulders, a broad chest and visible abs under torn purple cloth.
    poly(c,[[-35,-74],[35,-74],[35,-66],[32,-66],[32,-51],[27,-51],[27,-39],[20,-39],[20,-22],[-20,-22],[-20,-39],[-27,-39],[-27,-51],[-32,-51],[-32,-66],[-35,-66]],ink);
    poly(c,[[-32,-72],[32,-72],[32,-65],[29,-65],[29,-50],[24,-50],[24,-38],[17,-38],[17,-24],[-17,-24],[-17,-38],[-24,-38],[-24,-50],[-29,-50],[-29,-65],[-32,-65]],purple);
    r(c,-26,-69,19,16,skin);r(c,7,-69,19,16,skin);r(c,-19,-57,38,8,skin);r(c,-17,-67,8,3,light);r(c,8,-67,11,3,light);r(c,-24,-54,17,3,shade);r(c,7,-54,17,3,shade);
    r(c,-11,-49,23,23,skin);r(c,-10,-47,8,7,'#cf946f');r(c,3,-47,8,7,'#edbc90');r(c,-9,-38,8,6,'#cf946f');r(c,3,-38,7,6,'#edbc90');r(c,-10,-41,21,2,shade);r(c,-8,-32,18,2,shade);
    r(c,-29,-72,5,16,clothLight);r(c,25,-72,5,16,clothLight);r(c,-18,-25,36,5,'#5c425f');r(c,-7,-24,15,3,'#c6a7bc');
    // One neck, one head and the unmistakable potato nose; no extra rubbing arm.
    r(c,-10,-79,21,10,ink);r(c,-8,-78,17,9,skin);r(c,-6,-73,14,3,shade);
    r(c,-19,-100,40,30,ink);r(c,-17,-99,36,27,skin);r(c,-18,-92,5,16,shade);r(c,-13,-96,17,3,light);r(c,17,-88,7,10,skin);
    r(c,-19,-103,39,10,'#353334');r(c,-10,-106,31,5,'#353334');r(c,13,-100,11,10,'#353334');r(c,-20,-96,7,15,'#353334');r(c,-12,-102,9,2,'#5e4c51');
    r(c,-11,-91,12,3,'#51373b');r(c,8,-92,12,3,'#51373b');r(c,-5,-88,6,5,'#f8e9d0');r(c,12,-89,6,5,'#f8e9d0');r(c,-2,-88,3,5,'#342c2d');r(c,15,-89,3,5,'#342c2d');
    if(phase>=3){r(c,-1,-88,2,4,phase===4?'#f6a395':'#f5d986');r(c,16,-89,2,4,phase===4?'#f6a395':'#f5d986');}
    oval(c,noseX,-82,13,10,'#704536',2);oval(c,noseX,-83,11,8,'#edbd94',2);r(c,noseX-5,-90,10,3,'#ffdbb3');r(c,noseX+4,-84,3,4,'#d69c77');r(c,noseX-5,-77,4,2,'#a56a55');r(c,noseX+3,-77,4,2,'#a56a55');
    r(c,-4,-73,15,3,'#684638');r(c,-2,-73,11,1,'#f9dfbd');
    if(phase>=3){r(c,noseX+6,-73,3,6,'#a7b85f');r(c,noseX+5,-67,5,3,'#d0e48b');}
    powerArm(true);
    if(phase===3){for(let i=0;i<4;i++){const yy=4+i*9+Math.round(Math.sin(t*8+i)*2),xx=(i%2?1:-1)*(13+i*3);r(c,xx,yy,4,6,i%2?'#f7df88':'#c7afea');}}
    if(changing&&p>.31&&p<.44){c.save();c.globalAlpha*=Math.sin((p-.31)/.13*Math.PI)*.78;oval(c,0,-56,48,58,'#fff4c2',3);c.restore();}
    if(o.hit){c.save();c.globalAlpha*=.38;oval(c,0,-56,45,55,'#fff2d2',3);c.restore();}
    c.restore();
  }
  function character(c,type,x,y,o={}) {
    if(type==='nikolas'&&Number(o.bossPhase)>=2){nikolasForm(c,x,y,o);return;}
    if(type==='ollyan'&&window.BaileWorld?.drawOllyan){window.BaileWorld.drawOllyan(c,x,y,Number(o.frame)||0,o);return;}
    if(type==='igor'||type==='kaique'){schoolMonitor(c,type,x,y,o);return;}
    if(['allef','eloisa','giselle','rayssa','analaura'].includes(type)){socialCharacter(c,type,x,y,o);return;}if(['dede','aica','ravile','arthur'].includes(type)){storyCharacter(c,type,x,y,o);return;}if(['davi','vitor','freddy','nicolas'].includes(type)){newCharacter(c,type,x,y,o);return;}if(type==='giant'){giant(c,x,y,Number(o.frame)||0,o);return;}if(type==='thug'){thug(c,x,y,Number(o.frame)||0,o);return;}if(type==='reeisBoss'){type='reeis';o={...o,transformed:true,powered:true};}
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));const face=o.facing<0?-1:1;const scl=o.scale||1;c.scale(face*scl,scl);
    if(Number.isFinite(o.opacity))c.globalAlpha*=Math.max(0,Math.min(1,o.opacity));
    const frame=Number(o.frame)||0,rawPhase=frame*9;
    const inferred=o.attack&&o.attackType==='fart'?'fart':o.attack&&(!o.attackType||o.attackType==='paper')?'paper':Number(o.land)>0?'land':o.dash?'dash':o.flight?'flight':o.grounded===false?(Number(o.vy)<0?'jump':'fall'):o.moving||Number(o.speed)>8?'walk':'idle';
    const heroAnim=type==='daroca'&&heroFrameCatalog[o.animation||inferred]?(o.animation||inferred):'';
    const count=heroFrameCatalog[heroAnim]||1;
    const naturalIndex=heroAnim==='walk'||heroAnim==='dash'?Math.floor(rawPhase/(Math.PI*2)*count):heroAnim==='paper'||heroAnim==='fart'?Math.round((Number(o.attackProgress)||0)*(count-1)):heroAnim==='jump'||heroAnim==='fall'?Math.min(2,Math.floor(Math.abs(Number(o.vy)||0)/150)):Math.floor(frame*4);
    const poseIndex=Number.isFinite(o.spriteFrame)?((Math.floor(o.spriteFrame)%count)+count)%count:((naturalIndex%count)+count)%count;
    const phase=heroAnim==='walk'||heroAnim==='dash'?poseIndex/count*Math.PI*2:rawPhase;
    const moving=o.moving===true||Number(o.speed)>8||heroAnim==='walk'||heroAnim==='dash',grounded=['jump','fall','flight'].includes(heroAnim)?false:o.grounded!==false,flight=!!o.flight||heroAnim==='flight',air=!grounded,rising=heroAnim==='jump'||Number(o.vy)<-20;
    const walk=moving&&grounded?Math.sin(phase):0, hit=o.hit, recoil=Math.max(0,Math.min(1,Number(o.recoil)||(hit?.6:0)));
    const attackOn=!!o.attack||heroAnim==='paper'||heroAnim==='fart'||(o.attackType&&Number(o.attackProgress)>0&&Number(o.attackProgress)<1);
    const progress=Number.isFinite(o.attackProgress)&&!Number.isFinite(o.spriteFrame)?Math.max(0,Math.min(1,o.attackProgress)):heroAnim&&(heroAnim==='paper'||heroAnim==='fart')?poseIndex/(count-1):(.5+Math.sin(frame*7)*.5);
    const attackType=heroAnim==='paper'||heroAnim==='fart'?heroAnim:o.attackType||(type==='reeis'?'gun':type==='daroca'?'paper':'cast');
    const strike=attackOn?Math.max(0,1-Math.abs(progress-.48)/.26):0;
    const fart=attackOn&&attackType==='fart';
    // The gas attack compresses before firing, then springs upward into recovery.
    const landAmount=heroAnim==='land'&&Number.isFinite(o.spriteFrame)?1-poseIndex/2:Math.max(0,Math.min(1,Number(o.land)||0));
    const squat=fart?Math.round(progress<.28?Math.sin(progress/.28*Math.PI*.5)*5:progress<.5?5*(1-(progress-.28)/.22)-3*Math.sin((progress-.28)/.22*Math.PI):-2*(1-(progress-.5)/.5)):landAmount?Math.round(landAmount*6):o.charging?4+Math.round(Math.sin(frame*16)):o.dash||heroAnim==='dash'?3:0;
    const bob=heroAnim==='idle'?[0,-1,-2,-1][poseIndex]:moving&&grounded?Math.round((1-Math.cos(phase*2))*1.2):Math.round(Math.sin(frame*2.5)*.7);
    const lean=Math.round((o.dash||heroAnim==='dash'?8:moving?2:0)+(flight?4:0)-recoil*6+(attackOn&&attackType==='paper'?(progress<.32?-3:4*strike):0));
    if(type==='reeis'&&(o.transformed||o.charging||o.powered||o.aura||o.energy))energyAura(c,0,0,frame,{scale:o.transformed?1.75:1,intensity:o.charging?.92:.98,charging:o.charging,powered:o.powered});
    if(type==='marco'&&(o.angry||o.rage)){
      energyAura(c,0,0,frame,{scale:1.15,intensity:.95,charging:o.charging,red:true});
      c.save();c.globalAlpha=.28;oval(c,0,-34,31+Math.sin(frame*11)*3,43,'#f26154',3);c.restore();
      for(let i=0;i<9;i++){let ax=Math.round(Math.cos(i*.9+frame*.8)*25),ay=-35+Math.round(Math.sin(i*.9+frame*.8)*35);r(c,ax,ay,5,3,i%2?'#ec715f':'#a94249');r(c,ax+3,ay-4,2,5,'#e59c73');}
    }
    oval(c,0,-1,air?11:type==='mota'?14:17,3,'#304333',2);
    if(type==='lucas')c.scale(.84,.78);
    if(type==='reeis'&&o.transformed)c.scale(1.9,1.75);
    const skin=type==='reeis'?'#825033':type==='caleb'?'#f0c9af':type==='lucas'?'#efc9b0':type==='menezes'?'#b47d54':type==='marco'?'#f0cdb8':type==='mota'?'#f1ccb4':type==='nikolas'?'#e1b28a':type==='miqueias'?'#f0cbb5':type==='almiro'?'#b47b53':'#d6a071';
    const shadow=type==='reeis'?'#51382c':type==='almiro'?'#8a573d':type==='caleb'||type==='miqueias'||type==='mota'||type==='marco'?'#c3977f':'#a86c4e';
    const shirt={daroca:'#dc8c47',lucas:'#9a9e9e',reeis:'#4d7374',nikolas:'#8c6594',menezes:'#647c84',caleb:'#e1b563',ravid:'#7c93a1',marco:'#222b30',kaua:'#66888a',almiro:'#367cba',miqueias:'#617b70',mota:'#1b4677'}[type]||'#dc8c47';
    const pants=type==='marco'?'#2b353e':type==='nikolas'?'#423e59':type==='caleb'?'#564d3e':type==='almiro'||type==='lucas'?'#1e3355':type==='miqueias'?'#354c53':type==='mota'?'#1c3558':'#455b62';
    // Feet travel through contact, passing and lifted swing poses; knees bend separately.
    function leg(front){
      const sign=front?1:-1, swing=front?walk:-walk;
      let footX=(moving?Math.round(swing*13):sign*6),lift=moving&&grounded?Math.round(Math.max(0,Math.cos(phase+(front?0:Math.PI)))*7):0;
      let footY=-lift,hipX=sign*4+Math.round(lean*.25),hipY=-23-bob+squat;
      if(air){footX=front?(flight?-5:rising?8:11):(flight?-18:rising?-8:-5);footY=front?(flight?-3:rising?-7:-1):(flight?-12:rising?-13:-6);}
      if(heroAnim==='jump'){footX+=front?poseIndex*2:-poseIndex*2;footY-=front?[0,3,5][poseIndex]:[0,2,0][poseIndex];}
      if(heroAnim==='fall'){footX+=front?poseIndex*2:-poseIndex;footY+=front?[0,1,3][poseIndex]:[0,2,4][poseIndex];}
      if(heroAnim==='flight')footY+=Math.round(Math.sin(poseIndex*Math.PI*.5+(front?0:1))*3);
      if(landAmount)footX+=front?Math.round(landAmount*4):-Math.round(landAmount*4);
      if(type==='daroca'&&attackOn&&attackType==='paper'){footX+=front?Math.round(strike*3):-Math.round(strike*2);}
      const kneeX=air?footX-5:Math.round((footX+hipX)/2)+(front?2:-2)-Math.round(squat*.7),kneeY=-12-bob+Math.round(squat*.7)-lift*.45;
      const pts=[[hipX,hipY],[kneeX,kneeY],[footX,footY-4]];
      limb(c,pts,type==='mota'||type==='marco'?7:9,P.ink);limb(c,pts,type==='mota'||type==='marco'?4:5,front?pants:(type==='lucas'||type==='almiro'||type==='mota'?'#17283e':'#374a50'));
      const shoe=type==='lucas'?'#f4f7f3':type==='almiro'?'#9ef13d':type==='mota'?'#18394d':'#343b35';r(c,footX-4,footY-5,12,5,shoe);r(c,footX-3,footY-2,11,2,type==='lucas'?'#bac6cd':type==='almiro'?'#d1ff77':type==='mota'?'#f1ede3':front?'#bba784':'#8e8c70');if(type==='mota')for(let i=0;i<3;i++)r(c,footX-3+i*4,footY,2,2,'#dbe4d7');
    }
    leg(false);leg(true);
    c.translate(lean,-bob+squat+Math.round(recoil*2));if(type==='daroca'&&attackOn&&attackType==='paper')c.rotate(progress<.3?-.035*Math.sin(progress/.3*Math.PI*.5):Math.sin((progress-.3)/.7*Math.PI)*.045);
    const muscular=type==='caleb'||(type==='reeis'&&o.transformed)||(type==='daroca'&&o.muscular),heroStrong=type==='daroca'&&o.muscular,slim=type==='mota'||type==='marco',shoulder=muscular?20:slim?9:12;
    const gesture=moving?0:heroAnim==='idle'?[0,1,2,0][poseIndex]:Math.round(Math.sin(frame*2.4+1)*2);
    let backElbow=[-(muscular?23:slim?12:15)+Math.round(walk*5),-27],backHand=[-(muscular?23:slim?12:14)+Math.round(walk*9),-18-gesture];
    let frontElbow=[(muscular?23:slim?12:15)-Math.round(walk*5),-27],frontHand=[(muscular?23:slim?12:15)-Math.round(walk*10),-18+gesture];
    if(type==='ravid'&&(!moving||o.talking)){frontElbow=[22,-33];frontHand=[29+Math.round(Math.sin(frame*3)*4),-43+Math.round(Math.sin(frame*5)*5)];backHand=[-17,-26+gesture];}
    if((type==='almiro'||type==='miqueias')&&!moving){frontElbow=[18,-28];frontHand=[24,-25+Math.round(Math.sin(frame*2)*4)];}
    if(air){backElbow=[-18,-33];backHand=[flight?-26:-20,flight?-26:rising?-40:-31];frontElbow=[18,-34];frontHand=[flight?25:20,flight?-40:rising?-46:-36];}
    if(heroAnim==='flight'){frontHand[1]+=Math.round(Math.sin(poseIndex*Math.PI*.5)*4);backHand[1]+=Math.round(Math.cos(poseIndex*Math.PI*.5)*3);}
    if(landAmount){backElbow=[-21,-30];backHand=[-27,-27+landAmount*3];frontElbow=[22,-30];frontHand=[28,-27+landAmount*3];}
    if(recoil){backElbow=[-20,-36];backHand=[-18,-47];frontElbow=[13,-35];frontHand=[20,-41];}
    if(o.charging){backElbow=[-27,-29];backHand=[-19,-24];frontElbow=[27,-29];frontHand=[19,-24];}
    if(o.dash||heroAnim==='dash'){backElbow=[-24,-30];backHand=[-32,-32];frontElbow=[12,-41];frontHand=[22,-45];}
    if(o.pose==='fistbump'||o.gesture==='fistbump'){frontElbow=[23,-34];frontHand=[37,-35];}
    if(o.pose==='offer'||o.gesture==='offer'){frontElbow=[22,-26];frontHand=[36,-24];}
    if(o.pose==='steal'||o.gesture==='steal'){frontElbow=[25,-28];frontHand=[41,-26];backElbow=[-10,-29];backHand=[3,-25];}
    if(attackOn){
      if(attackType==='paper'){
        if(progress<.3){const raw=progress/.3,q=raw*raw*(3-2*raw);frontElbow=[11-13*q,-30-12*q];frontHand=[13-21*q,-24-28*q];}
        else if(progress<.55){const raw=(progress-.3)/.25,q=raw*raw*(3-2*raw);frontElbow=[-2+25*q,-42+6*q];frontHand=[-8+45*q,-52+14*q];}
        else{const raw=(progress-.55)/.45,q=raw*raw*(3-2*raw);frontElbow=[23-8*q,-36+9*q];frontHand=[37-22*q,-38+20*q];}
        backElbow=[-17,-28];backHand=[-22,-19];
      }else if(fart){backElbow=[-20,-30];backHand=[-25,-34];frontElbow=[19,-29];frontHand=[25,-34];}
      else if(type==='reeis'||type==='caleb'||attackType==='punch'){
        frontElbow=[16+strike*9,-31-strike*3];frontHand=[20+strike*20,-27-strike*9];backElbow=[-16,-37];backHand=[-7,-40];
      }else if(type==='nikolas'){frontElbow=[21,-39];frontHand=[21,-49+Math.round(Math.sin(frame*15)*2)];}
      else if(type==='marco'){frontElbow=[17,-37];frontHand=[27+strike*3,-40-strike*7];backHand=[-17,-23];}
      else{frontElbow=[19,-34-strike*4];frontHand=[27+strike*7,-37-strike*5];}
    }
    const noseRubbing=type==='nikolas'&&(o.noseRub!==false||attackOn)&&!['fistbump','offer','steal'].includes(o.pose||o.gesture);
    if(noseRubbing){frontElbow=[22,-37];frontHand=[(o.view==='front'?4:18)+2,-49+Math.round(Math.sin(frame*13)*3)];}
    function arm(front){
      let elbow=front?frontElbow:backElbow,hand=front?frontHand:backHand;const should=[front?shoulder:-shoulder,muscular?-38:-34];
      if(type==='daroca'&&attackOn){const upper=muscular?14:11,lower=muscular?15:12,dx=hand[0]-should[0],dy=hand[1]-should[1],distance=Math.min(upper+lower-.05,Math.max(Math.abs(upper-lower)+.05,Math.hypot(dx,dy))),angle=Math.atan2(dy,dx),bend=(front?-1:1)*Math.acos(Math.max(-1,Math.min(1,(upper*upper+distance*distance-lower*lower)/(2*upper*distance))));elbow=[should[0]+Math.cos(angle+bend)*upper,should[1]+Math.sin(angle+bend)*upper];hand=[should[0]+Math.cos(angle)*distance,should[1]+Math.sin(angle)*distance];if(front){frontHand=hand;frontElbow=elbow;}else{backHand=hand;backElbow=elbow;}}

      limb(c,[should,elbow,hand],muscular?13:slim?6:8,P.ink);
      limb(c,[should,elbow],muscular?9:slim?4:5,muscular?skin:shirt);
      if(heroStrong)limb(c,[should,[should[0]*.86,-33]],11,shirt);
      limb(c,[elbow,hand],muscular?8:slim?4:5,type==='marco'?shirt:skin);r(c,hand[0]-3,hand[1]-3,muscular?9:slim?5:6,muscular?8:slim?5:6,skin);
      if(muscular){r(c,elbow[0]-2,elbow[1]-4,4,2,type==='reeis'?'#a26c45':'#f5d8bb');r(c,elbow[0]-3,elbow[1]+2,5,2,shadow);}
    }
    arm(false);
    if(muscular){
      poly(c,[[-22,-44],[22,-44],[20,-33],[13,-18],[-13,-18],[-20,-33]],P.ink);
      poly(c,[[-19,-42],[19,-42],[17,-32],[11,-20],[-11,-20],[-17,-32]],shirt);
      if(heroStrong){r(c,-17,-40,13,6,'#edab59');r(c,4,-40,13,6,'#edab59');r(c,-12,-31,25,2,'#ad6b36');r(c,-7,-26,15,2,'#bd783b');}
      else{r(c,-15,-42,8,12,skin);r(c,8,-42,8,12,skin);r(c,-8,-38,17,4,skin);r(c,-7,-27,15,3,type==='reeis'?'#3b5b5b':'#b18b51');}
    }else if(slim){
      // Mota has a lean runner's silhouette, with the same full-size head and stride.
      poly(c,[[-10,-39],[11,-39],[10,-29],[8,-17],[-8,-17],[-10,-29]],P.ink);
      poly(c,[[-8,-37],[9,-37],[8,-28],[6,-19],[-6,-19],[-8,-28]],shirt);
    }else{
      const broad=fart?(progress<.32?Math.round(Math.sin(progress/.32*Math.PI*.5)*2):progress<.65?-1:0):0;
      r(c,-13-broad,-39,27+broad*2,23,P.ink);r(c,-11-broad,-38,23+broad*2,19,shirt);r(c,-10,-35,3,12,type==='lucas'?'#c3c9c7':type==='almiro'?'#80b2dc':'#e7ac65');if(type==='miqueias'){oval(c,3,-26,18,13,P.ink,2);oval(c,3,-27,16,11,shirt,2);r(c,-10,-30,27,2,'#8aa498');r(c,-8,-21,23,2,'#344e45');}
    }
    arm(true);
    r(c,-5,-43,12,7,P.ink);r(c,-4,-43,9,8,skin);r(c,-11,-59,24,19,P.ink);r(c,-10,-58,22,17,skin);r(c,-11,-54,3,10,shadow);r(c,11,-51,5,6,skin);r(c,4,-51,3,3,'#302f2c');r(c,11,-47,4,2,shadow);r(c,3,-43,7,2,shadow);
    if(type==='daroca'){
      r(c,-12,-59,25,6,'#5f4934');r(c,-9,-57,4,4,'#5f4934');
      r(c,-7,-54,3,4,'#72513b');r(c,1,-53,8,1,'#855b3d');r(c,5,-51,2,3,'#252f2b');r(c,3,-44,7,1,'#8e5e43');r(c,4,-43,5,1,'#e9b684');
      if(heroAnim==='idle'&&poseIndex===3){r(c,3,-52,6,4,skin);r(c,3,-50,6,1,'#4a3e30');}
      // The straw hat is the hero's signature.
      c.save();c.translate(flight?-2:Math.round(-walk),flight?-3:Math.round(-Math.abs(walk)));
      r(c,-20,-61,41,5,'#6e5335');r(c,-19,-65,39,5,'#dbb969');r(c,-12,-76,27,13,'#a98045');r(c,-10,-76,23,10,'#dfb96a');r(c,-8,-78,19,3,'#f0ce7e');r(c,-11,-67,25,4,'#8a5a3b');r(c,-17,-64,34,2,'#f1cf7a');r(c,-5,-73,3,3,'#f5d68b');
      c.restore();
      c.save();c.translate(moving?Math.round(-walk*2):0,moving?Math.round(Math.abs(walk)*2):flight?-2:0);
      r(c,-17,-37,5,18,'#5f6041');r(c,-20,-35,6,15,'#8d814a');r(c,-19,-33,3,7,'#b1a262');
      c.restore();
      r(c,3,-36,5,3,'#f4cf81');r(c,-4,-20,8,3,'#b5814a');
      r(c,-9,-28,7,2,'#bd7135');r(c,4,-30,6,2,'#f0ab59');r(c,-11,-21,23,4,'#6e5339');r(c,-2,-22,6,5,'#d7bb72');r(c,0,-21,2,3,'#6d573a');
    }else if(type==='reeis'){
      if(o.transformed||o.powered||o.charging){
        c.save();if(o.charging)c.globalAlpha*=.7+Math.sin(frame*18)*.15;
        const crown=[[-15,-60],[-22,-75],[-12,-71],[-10,-84],[-3,-75],[4,-88],[9,-73],[20,-80],[16,-65],[20,-59]];
        poly(c,crown,'#c68125');poly(c,[[-12,-62],[-17,-72],[-10,-68],[-8,-78],[-2,-70],[4,-81],[8,-68],[16,-75],[12,-63]],'#ffda46');
        r(c,-7,-74,2,5,'#fff2a3');r(c,2,-79,2,6,'#fff4b7');r(c,11,-71,2,4,'#fff0a1');c.restore();
      }
      r(c,-12,-61,25,8,'#252b2b');for(let i=0;i<6;i++)r(c,-11+i*4,-63+(i%2),4,4,'#232b29');r(c,-12,-55,4,5,'#252b2b');r(c,-4,-37,10,3,'#d3b362');r(c,0,-36,3,10,'#d3b362');r(c,-2,-28,7,4,'#e7cb73');
      if(o.transformed){
        c.save();c.translate(attackOn?-Math.round(strike*4):0,attackOn?-Math.round(strike*2):0);
        r(c,19,-30,33,8,'#242e30');r(c,24,-22,9,13,'#293334');r(c,21,-33,26,3,'#83918a');r(c,47,-29,7,5,'#56635e');r(c,17,-23,8,5,skin);
        if(attackOn&&progress>.34&&progress<.56){poly(c,[[55,-30],[63,-35],[61,-29],[68,-27],[61,-24],[63,-19],[55,-23]],'#f4d392');r(c,54,-28,7,3,'#fff0ba');}
        c.restore();
      }
      if(o.powered||o.charging){r(c,-9,-51,2,7,'#b78c50');r(c,2,-61,8,2,'#a88f54');r(c,16,-38,3,9,'#d2ac62');}
    }else if(type==='nikolas'){
      r(c,-12,-63,25,10,'#353334');r(c,-6,-66,20,5,'#353334');r(c,8,-61,8,6,'#353334');r(c,-13,-55,5,9,'#353334');r(c,0,-53,8,2,'#463835');
      // A large, round potato nose is a readable silhouette even in the full world view.
      const noseX=o.view==='front'?4:18;oval(c,noseX,-49,10,8,'#6c4638',2);oval(c,noseX,-50,8,6,'#edbd94',2);r(c,noseX-3,-55,7,2,'#ffdbb3');r(c,noseX+3,-51,2,3,'#d69c77');r(c,noseX-4,-46,3,2,'#b77c5e');r(c,noseX+2,-46,3,2,'#b77c5e');
      // A constant nose rub builds the villain's ridiculous mucus power.
      if(noseRubbing){
        // Only the same hand is brought in front of the nose; no new limb is drawn.
        r(c,frontHand[0]-3,frontHand[1]-3,6,6,skin);r(c,frontHand[0],frontHand[1]-2,2,1,'#f3c79f');r(c,noseX+5,-43,3,3,'#a4b56a');
      }
      r(c,-6,-35,15,3,'#b798b4');
      if(o.emotion==='friend'){limb(c,[[1,-43],[5,-41],[10,-43]],1,'#80543d');r(c,2,-54,6,1,'#73503a');}
      else if(o.emotion==='greed'){r(c,-1,-56,9,2,'#463835');r(c,1,-43,12,4,'#654233');r(c,3,-43,8,2,'#fff0c9');r(c,6,-40,5,1,'#edb89a');}
      else if(o.emotion==='sad'){limb(c,[[0,-53],[4,-55],[8,-54]],2,'#463835');limb(c,[[1,-41],[6,-43],[10,-41]],1,'#80543d');r(c,7,-48,2,3,'#c4d9d1');}
      else if(o.emotion==='taunted'){limb(c,[[0,-55],[8,-52]],2,'#463835');r(c,1,-43,11,3,'#714738');r(c,3,-43,7,1,'#fff0cb');}
    }else if(type==='menezes'){
      r(c,-13,-64,29,12,'#252b2c');for(let i=0;i<7;i++){oval(c,-10+i*4,-64-(i%2)*2,4,4,i%2?'#242a2b':'#333b38',2);}r(c,-13,-56,5,9,'#252b2c');r(c,11,-57,4,7,'#252b2c');
      r(c,-7,-55,11,7,'#25383d');r(c,6,-55,11,7,'#25383d');r(c,-5,-53,7,3,'#b4c9cc');r(c,8,-53,7,3,'#b4c9cc');r(c,3,-53,4,2,'#25383d');r(c,-1,-53,2,3,'#3d342b');r(c,11,-53,2,3,'#3d342b');r(c,-6,-54,4,1,'#f4efe0');r(c,8,-54,4,1,'#f4efe0');
      r(c,-1,-37,2,18,'#c0d1ca');r(c,-7,-22,16,2,'#435b62');r(c,-6,-33,4,4,'#a8b8a0');r(c,4,-33,4,4,'#a8b8a0');r(c,-2,-31,6,4,'#a8b8a0');r(c,-1,-30,1,1,'#3c4b45');r(c,3,-30,1,1,'#3c4b45');
      if(attackOn){r(c,0,-44,12,4+Math.round(strike*3),'#513a35');r(c,2,-44,8,2,'#eee2c8');for(let i=0;i<3;i++)r(c,20+i*5,-46+i*3,3,2,'#cab1cd');}else r(c,3,-43,8,1,'#6a4738');
    }else if(type==='caleb'){
      // Blond hair and a warm brown iris also read clearly in the enlarged portrait.
      r(c,-11,-62,24,8,'#b78b43');r(c,-9,-65,18,5,'#e4bc62');r(c,-6,-67,12,3,'#f3d584');r(c,-9,-58,5,5,'#d2a54f');r(c,1,-62,10,3,'#f6d78b');
      r(c,2,-52,7,4,'#eddfbf');r(c,5,-52,3,4,'#80522e');r(c,6,-51,1,2,'#392c27');r(c,2,-54,8,2,'#a47c3e');r(c,-8,-44,19,3,'#8f6942');r(c,7,-48,3,2,'#46372f');
    }else if(type==='lucas'){
      r(c,-12,-63,25,8,'#242c30');r(c,-8,-66,18,5,'#242c30');r(c,-12,-58,5,7,'#242c30');r(c,9,-58,5,5,'#30383a');r(c,-7,-61,9,2,'#4b5456');
      r(c,-10,-37,7,20,'#a8afae');r(c,6,-37,7,20,'#7f8b8e');r(c,-3,-37,8,19,'#e4e7dd');r(c,0,-36,2,17,'#526473');r(c,-10,-20,7,2,'#6f7d81');r(c,7,-20,6,2,'#576a75');r(c,3,-44,7,1,'#9e6f55');
    }else if(type==='mota'){
      // A swept blond quiff stays legible in the small field sprite and portraits.
      r(c,-12,-63,26,9,'#a57832');r(c,-10,-65,23,7,'#e3b64e');r(c,-7,-68,17,5,'#edc966');r(c,-3,-70,12,3,'#f6da84');r(c,2,-65,12,3,'#f9e49a');r(c,-11,-56,4,7,'#c19740');r(c,-9,-61,4,5,'#e3b64e');r(c,2,-43,9,2,'#7a5239');r(c,1,-42,7,1,'#edcfad');
      r(c,-8,-38,18,3,'#edf0e5');r(c,-5,-34,2,14,'#f6f4e6');r(c,5,-34,2,14,'#f6f4e6');r(c,-1,-32,3,8,'#d8e6e4');r(c,2,-32,3,8,'#d8e6e4');r(c,-7,-19,15,3,'#133154');
      football(c,-22,-10+Math.round(Math.sin(frame*2)*2),9);
    }else if(type==='ravid'){
      r(c,-11,-62,25,9,'#5b4938');r(c,-8,-65,20,5,'#5b4938');r(c,-11,-56,5,8,'#5b4938');r(c,-6,-37,15,5,'#c1c7ae');r(c,6,-49,9,3,'#353c38');r(c,0,-49,4,3,'#353c38');r(c,4,-48,3,1,'#353c38');
      if(o.talking||Math.sin(frame*5)>0){r(c,5,-44,7,Math.sin(frame*11)>0?4:2,'#4e3c32');r(c,7,-44,3,1,'#e4c7a0');}
      if(o.talking||!moving){r(c,frontHand[0]+2,frontHand[1]-5,2,5,skin);r(c,frontHand[0]+3,frontHand[1]-7,4,2,skin);}
    }else if(type==='marco'){
      // White, slim, black straight hair and a black hoodie with its hood down.
      r(c,-12,-63,26,8,'#1c2429');r(c,-9,-65,21,4,'#1c2429');r(c,-12,-58,4,8,'#1c2429');r(c,11,-59,3,6,'#1c2429');r(c,-7,-62,13,1,'#424b4b');
      r(c,3,-53,8,2,o.angry?'#9c3f45':'#473a36');r(c,5,-50,3,2,o.angry||o.rage?'#ff302f':'#3a3039');if(o.angry||o.rage){r(c,3,-53,8,3,'#ff392f');r(c,5,-52,3,1,'#ffd1a2');r(c,-6,-53,5,3,'#ec312f');}
      r(c,-9,-41,20,5,'#151f26');r(c,-6,-39,14,4,'#3b4446');r(c,-5,-36,2,12,'#c2c6bb');r(c,6,-36,2,11,'#c2c6bb');r(c,-8,-22,18,3,'#141f25');
      r(c,-3,-32,8,6,'#747d75');r(c,-5,-34,3,4,'#747d75');r(c,4,-34,3,4,'#747d75');r(c,-1,-30,2,2,'#1c2429');r(c,3,-30,2,2,'#1c2429');
      // Always carries a tangible sketchbook and a sharpened pencil.
      r(c,14,-31,21,22,'#292a35');r(c,16,-29,17,18,'#dccca9');r(c,17,-27,2,14,'#7b6a65');r(c,20,-25,9,2,'#8d7e7c');r(c,22,-22,6,2,'#8d7e7c');r(c,21,-20,10,2,'#8d7e7c');r(c,24,-24,2,7,'#5d4d69');r(c,13,-22,5,5,skin);
      if(attackOn){
        c.save();c.translate(Math.round(strike*3),-Math.round(strike*6));
        poly(c,[[23,-37],[36,-52],[39,-49],[26,-34]],'#e4b861');poly(c,[[36,-52],[41,-55],[39,-49]],'#e4d3ad');r(c,39,-55,2,2,'#302c35');
        const ink=o.angry?'#e67c68':'#b59ac6';
        for(let i=0;i<5;i++){let xx=34+i*5,yy=-41-Math.round(Math.sin(frame*7+i)*8);r(c,xx,yy,4,2,ink);r(c,xx+2,yy-3,2,5,ink);}
        r(c,24,-24,5,2,ink);r(c,27,-21,3,2,ink);
        c.restore();
      }else{poly(c,[[-15,-32],[-13,-34],[-3,-21],[-5,-19]],'#d5ac57');r(c,-16,-35,3,4,'#a96c70');}
    }else if(type==='kaua'){
      // A cheerful inventor: copper hair, teal goggles, workshop apron.
      r(c,-12,-62,25,8,'#694b36');r(c,-9,-65,21,5,'#946a43');r(c,-7,-67,10,4,'#bb8c51');r(c,-10,-58,4,6,'#694b36');
      r(c,-11,-54,26,7,'#363c3a');r(c,-8,-53,8,5,'#95bcb0');r(c,5,-53,8,5,'#95bcb0');r(c,-6,-53,2,2,'#e4e7c4');r(c,7,-53,2,2,'#e4e7c4');r(c,0,-52,5,2,'#c4a773');
      r(c,-8,-37,3,9,'#ba925d');r(c,7,-37,3,9,'#ba925d');r(c,-8,-29,19,14,'#a47d50');r(c,-6,-27,15,9,'#bd9863');r(c,-2,-25,9,5,'#7b6448');r(c,0,-29,2,8,'#e2ba62');r(c,3,-27,2,6,'#c78479');r(c,-8,-17,20,3,'#674f3a');
      // Oversized school-supply launcher: ruler stock, eraser chamber, pencil barrel.
      c.save();c.translate(attackOn?-Math.round(strike*5):0,attackOn?-Math.round(strike*2):0);
      r(c,15,-33,37,11,'#3e4c43');r(c,18,-31,31,7,'#ceaf69');for(let i=0;i<6;i++)r(c,20+i*5,-31,1,i%2?3:5,'#705a3b');r(c,21,-22,8,10,'#936c47');r(c,24,-12,7,3,'#5b503c');
      r(c,36,-40,11,8,'#414b43');r(c,38,-39,7,6,'#d29392');r(c,39,-39,5,2,'#ebbcaa');r(c,50,-30,14,5,'#e2ba66');poly(c,[[64,-30],[71,-28],[64,-25]],'#eee1b7');r(c,69,-29,3,2,'#3d4140');r(c,15,-25,7,5,skin);r(c,31,-34,4,5,'#89ada0');
      c.restore();
    }else if(type==='almiro'){
      // Almiro: medium brown skin and a spectacularly polished bald head.
      oval(c,0,-60,13,12,P.ink,2);oval(c,0,-60,11,10,skin,2);r(c,-8,-63,3,9,shadow);r(c,-4,-69,9,2,'#d7a77a');r(c,-2,-68,8,2,'#e7bd8d');
      const glint=Math.sin(frame*4.2),glintX=4+Math.round(Math.sin(frame*2)*2),glintY=-69;
      r(c,glintX-4,glintY,9,2,'#fff2c8');r(c,glintX,glintY-4,2,9,'#fff2c8');r(c,glintX,glintY,2,2,'#ffffff');if(glint>.25){r(c,glintX+6,glintY-5,2,2,'#fff9e0');r(c,glintX-6,glintY+4,2,2,'#fff0bc');}
      r(c,-1,-55,16,8,skin);r(c,-1,-54,6,1,'#6e5038');r(c,8,-54,5,1,'#6e5038');r(c,1,-52,2,3,'#343f35');r(c,10,-52,2,3,'#343f35');
      r(c,1,-45,12,3,'#5c473a');r(c,3,-46,7,2,'#765644');r(c,5,-42,4,2,'#8e6b51');
      r(c,-2,-38,3,18,'#c6d0b7');for(let i=0;i<3;i++)r(c,-1,-34+i*5,1,1,'#526d73');r(c,5,-34,5,4,'#546f78');r(c,7,-36,1,4,'#dedcb6');
      c.save();c.translate(0,gesture);r(c,-20,-28,13,17,'#384f54');r(c,-18,-26,9,13,'#c8c2a0');r(c,-16,-23,5,1,'#7d8d80');r(c,-16,-20,5,1,'#7d8d80');c.restore();r(c,frontHand[0]+2,frontHand[1]-4,7,3,'#f1ead0');
    }else if(type==='miqueias'){
      // Broad ginger lumberjack beard, light skin and clear glasses.
      r(c,-12,-63,26,10,'#8d482b');r(c,-9,-66,20,5,'#b25e32');r(c,-6,-68,12,3,'#d17c42');r(c,-12,-58,5,12,'#91492a');r(c,10,-58,4,10,'#91492a');
      poly(c,[[-11,-47],[14,-47],[18,-40],[15,-31],[8,-25],[-2,-26],[-10,-33],[-13,-41]],'#753b25');poly(c,[[-9,-45],[13,-45],[15,-39],[12,-32],[6,-28],[-1,-29],[-8,-35]],'#b85d2c');r(c,-6,-44,18,3,'#d7803d');r(c,1,-44,9,2,'#f1c8a1');for(let i=0;i<5;i++)r(c,-5+i*4,-38+(i%2)*2,2,7,'#d47e3d');r(c,0,-31,6,3,'#e0964c');
      r(c,-5,-55,11,7,'#303b3a');r(c,6,-55,11,7,'#303b3a');r(c,-3,-53,6,3,'#cadce0');r(c,8,-53,6,3,'#cadce0');r(c,1,-53,2,3,'#514235');r(c,11,-53,2,3,'#514235');r(c,4,-53,3,2,'#303b3a');r(c,-1,-54,3,1,'#f6f4e5');r(c,9,-54,3,1,'#f6f4e5');
      r(c,-12,-30,29,2,'#90a99a');r(c,-10,-23,25,2,'#8aa398');r(c,-6,-31,2,12,'#476453');r(c,4,-29,2,10,'#476453');r(c,12,-27,2,7,'#476453');
      c.save();c.translate(0,-gesture);
      r(c,13,-34,18,25,'#2e4840');r(c,15,-32,14,21,'#59816b');r(c,15,-31,2,20,'#cdb87d');r(c,18,-28,10,9,'#e3d5ab');
      c.fillStyle='#47624c';c.font='bold 6px monospace';c.fillText('EN',19,-21);r(c,19,-16,8,1,'#c5cfaa');r(c,19,-13,6,1,'#c5cfaa');r(c,13,-21,5,5,skin);
      c.restore();
    }
    if(attackOn&&type==='daroca'&&attackType==='paper'){
      if(progress<.5){const hx=frontHand[0],hy=frontHand[1];if(o.attackObject==='ruler'){r(c,hx-12,hy-4,25,7,'#725b43');r(c,hx-10,hy-3,21,4,'#e6b76a');for(let i=0;i<5;i++)r(c,hx-8+i*4,hy-1,1,2,'#7d663d');}else if(o.attackObject==='case'){r(c,hx-8,hy-5,17,11,'#29494e');r(c,hx-6,hy-3,13,7,'#6ab6b4');r(c,hx-5,hy-2,11,1,'#c2e6d0');}else if(o.attackObject==='papaia'){poly(c,[[hx-6,hy-4],[hx+2,hy-6],[hx+7,hy],[hx+3,hy+5],[hx-5,hy+3]],'#5c683a');poly(c,[[hx-4,hy-3],[hx+1,hy-4],[hx+5,hy],[hx+2,hy+3],[hx-4,hy+2]],o.attackElement==='electric'?'#b1e5e7':'#f2b260');r(c,hx+2,hy-7,5,2,'#75a04c');}else{r(c,hx-3,hy-5,7,7,'#725b43');r(c,hx-2,hy-5,5,5,'#efe0b3');r(c,hx-1,hy-4,2,2,'#fff0c7');}}
      if(progress>.4&&progress<.7){r(c,29,-42,11,2,'#f0c786');r(c,35,-37,8,2,'#ebc07c');}
    }
    if(flight&&type==='daroca'){r(c,-22,-57,8,2,'#e5cb94');r(c,-29,-51,9,2,'#d1bd87');}
    if(attackOn&&strike>.5&&(attackType==='punch'||(type==='reeis'&&!o.transformed)||type==='caleb')){
      limb(c,[[26,-49],[35,-45],[42,-37],[43,-29]],2,'#f6d68e');limb(c,[[30,-51],[40,-44],[46,-34]],2,'#fff0b7');
    }
    if(o.dash||heroAnim==='dash'){r(c,-31,-39,11+poseIndex,2,'#d2daba');r(c,-39,-29,15-poseIndex,2,'#e7e4b9');r(c,-27,-51,8,2,'#e8d6a0');}
    if(hit){c.globalAlpha=.55;r(c,-17,-63,35,61,'#ffe4bc');}
    c.restore();
  }
  function vehicle(c,x,y,t=0) {
    c.save();c.translate(Math.round(x),Math.round(y+Math.sin(t*5)*2));
    // Father's homemade flying gas car: riveted body, canisters and a visible propeller.
    for(let i=0;i<5;i++){c.save();c.globalAlpha*=.7-i*.1;oval(c,-68-i*14,-8+Math.sin(t*12-i)*4,5+i*2,3+i,'#b9d774',2);c.restore();}
    r(c,-51,-25,103,29,P.ink);r(c,-47,-24,95,26,'#6c8651');r(c,-44,-22,87,7,'#a2ac65');r(c,-48,-7,97,8,'#3c5943');
    poly(c,[[-28,-25],[-20,-48],[19,-48],[34,-25]],P.ink);poly(c,[[-23,-26],[-16,-44],[15,-44],[27,-26]],'#9cad92');r(c,-4,-43,4,18,'#455e50');r(c,-18,-41,10,12,'#d2d2a0');
    r(c,-38,-2,20,13,'#2e3e35');r(c,23,-2,20,13,'#2e3e35');r(c,-33,1,10,7,'#9f9d71');r(c,28,1,10,7,'#9f9d71');r(c,45,-18,8,9,'#f2d78b');r(c,-54,-16,8,9,'#b06c49');
    r(c,-48,-43,13,18,'#a98e57');r(c,-45,-48,7,6,'#806b42');r(c,-47,-38,11,2,'#dec384');r(c,-47,-29,11,2,'#dec384');
    r(c,-33,-42,10,16,'#8caa98');r(c,-30,-47,5,5,'#456b5b');r(c,-32,-36,8,2,'#d6dfb4');r(c,-32,-29,8,2,'#d6dfb4');r(c,-51,-26,31,3,'#4d6752');
    for(let i=0;i<8;i++)r(c,-42+i*11,-19,2,2,'#c4ca8f');r(c,-1,-20,3,20,'#4c6d50');r(c,8,-13,5,2,'#3a5641');
    const prop=Math.sin(t*38),propY=Math.cos(t*38)*17;limb(c,[[-58-prop*3,-14-propY],[-58+prop*3,-14+propY]],4,'#d5dbc0');r(c,-63,-18,9,7,'#3b5547');r(c,-61,-17,5,4,'#a5b492');
    r(c,5,-17,18,7,'#e0c581');c.fillStyle='#455d45';c.font='bold 6px monospace';c.fillText('GÁS',7,-11);
    for(let i=0;i<4;i++)r(c,-25+i*19,14+Math.sin(t*12+i)*3,10,3,'#b4c26e');
    c.restore();
  }
  function cake(c,x,y) {
    c.save();c.translate(Math.round(x),Math.round(y));oval(c,0,0,20,4,'#dac99b',2);r(c,-17,-17,34,16,'#563d31');r(c,-16,-12,32,4,'#b18a56');r(c,-17,-19,34,7,'#744c35');r(c,-14,-22,28,5,'#94613d');r(c,-13,-18,4,6,'#ba8a55');r(c,7,-18,5,5,'#ba8a55');
    // Chocolate frog topper.
    r(c,-8,-29,17,8,'#71904e');r(c,-9,-33,6,7,'#91a65b');r(c,3,-33,6,7,'#91a65b');r(c,-7,-31,2,2,'#303d2c');r(c,5,-31,2,2,'#303d2c');r(c,-4,-25,10,2,'#435b36');r(c,-13,-24,7,3,'#71904e');r(c,7,-24,7,3,'#71904e');c.restore();
  }
  function doodle(c,x,y,variant=0,time=0,enraged=false) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));
    const v=((Number(variant)||0)%3+3)%3,t=Number(time)||0,wiggle=Math.round(Math.sin(t*13+v)*2);
    const ink=enraged?'#692f42':'#3d354c',edge=enraged?'#db7467':'#9e84ac',paper='#f1dbad';
    if(enraged){c.save();c.globalAlpha=.25;oval(c,0,0,25,23,'#e47660',3);c.restore();}
    // Monsters retain uneven notebook strokes rather than becoming realistic creatures.
    if(v===0){
      poly(c,[[-6,-6],[-23,-15],[-21,-4],[-15,-5],[-12,3],[-5,1]],ink);poly(c,[[6,-6],[23,-15],[21,-4],[15,-5],[12,3],[5,1]],ink);
      poly(c,[[-12,-8],[-13,-19],[-5,-12],[4,-12],[12,-19],[11,-8],[14,3],[8,12],[-8,12],[-14,3]],ink);
      r(c,-8,-8,5,6,paper);r(c,3,-8,5,6,paper);r(c,-6,-7,2,4,enraged?'#c5484b':'#61456f');r(c,4,-7,2,4,enraged?'#c5484b':'#61456f');r(c,-5,2,10,4,'#201e2c');r(c,-4,2,3,3,paper);r(c,2,2,3,3,paper);r(c,-11,10,5,4,edge);r(c,7,10,5,4,edge);
    }else if(v===1){
      poly(c,[[-15,-7],[-10,-11],[-12,-17],[-3,-13],[2,-19],[7,-12],[16,-13],[13,-4],[18,3],[11,11],[3,9],[-3,16],[-9,9],[-16,8],[-12,0]],ink);
      r(c,-9,-7,18,10,edge);r(c,-7,-8,14,12,paper);r(c,-2,-7,6,10,enraged?'#b64b56':'#705280');r(c,0,-5,3,7,'#252435');r(c,0,-6,2,2,'#fff0c6');
      r(c,-8,7,15,2,'#c2a8c5');r(c,-4,9,3,3,paper);poly(c,[[-12,4],[-23,1],[-24,4],[-13,7]],edge);poly(c,[[12,4],[23,1],[24,4],[13,7]],edge);
    }else{
      poly(c,[[-19,-4],[-15,-12],[-8,-11],[-5,-17],[2,-13],[10,-16],[14,-9],[21,-7],[17,0],[22,7],[15,13],[7,10],[0,16],[-5,10],[-16,12],[-19,4]],ink);
      r(c,-12,-7,5,5,paper);r(c,-2,-10,5,5,paper);r(c,8,-6,5,5,paper);r(c,-10,-6,2,3,'#6b4d79');r(c,0,-9,2,3,'#6b4d79');r(c,10,-5,2,3,'#6b4d79');r(c,-12,2,25,6,'#242230');
      for(let i=0;i<4;i++){r(c,-10+i*6,2,3,3,paper);r(c,-7+i*6,5,3,3,paper);}
    }
    // Orbiting short scribbles make the drawing feel alive even between attacks.
    for(let i=0;i<6;i++){let xx=Math.round(Math.cos(i*1.05+t*2)*22),yy=Math.round(Math.sin(i*1.05+t*2)*18);r(c,xx,yy+wiggle,4,2,edge);if(i%2)r(c,xx+2,yy+wiggle-3,2,3,edge);}
    c.restore();
  }
  function material(c,x,y,type='pencil') {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));
    const kind=typeof type==='number'?['pencil','eraser','clip'][type%3]:String(type).toLowerCase().replace(/s$/,'');
    if(kind==='eraser'){
      poly(c,[[-11,5],[-2,-8],[10,-5],[10,2],[1,11]],'#563f43');poly(c,[[-8,4],[-1,-5],[8,-3],[0,7]],'#db9b96');poly(c,[[-8,4],[0,7],[0,9],[-8,6]],'#aa7477');poly(c,[[0,7],[8,-3],[8,1],[0,10]],'#f0c8af');r(c,-1,-3,3,2,'#ebbbb0');
    }else if(kind==='clip'){
      c.strokeStyle='#3c4e4c';c.lineWidth=5;c.beginPath();c.moveTo(-5,9);c.lineTo(8,-4);c.lineTo(8,-8);c.lineTo(4,-11);c.lineTo(0,-10);c.lineTo(-10,1);c.lineTo(-10,5);c.lineTo(-6,8);c.lineTo(-2,7);c.lineTo(6,-2);c.lineTo(5,-5);c.lineTo(2,-5);c.lineTo(-5,3);c.stroke();
      c.strokeStyle='#b6c5af';c.lineWidth=2;c.stroke();
    }else{
      poly(c,[[-10,8],[6,-10],[10,-7],[-6,11]],'#5b4937');poly(c,[[-8,8],[6,-8],[8,-6],[-6,10]],'#e1bc67');poly(c,[[-8,8],[-6,10],[-12,13]],'#eadab2');r(c,-12,11,2,2,'#36362f');poly(c,[[6,-10],[9,-13],[13,-10],[10,-7]],'#d28e85');r(c,6,-7,4,2,'#d5cfad');
    }
    c.restore();
  }
  function classroomDoor(c,x,id,t=0) {
    const english=id==='miqueias',accent=english?'#796080':'#527f93';
    r(c,x-53,269,106,164,'#806d54');r(c,x-49,273,98,157,accent);r(c,x-43,281,86,149,'#38595d');r(c,x-39,285,78,144,english?'#93868d':'#7f9ba1');
    r(c,x-32,294,64,72,'#bccbd1');r(c,x-28,298,56,64,'#d8e3d9');r(c,x-2,294,4,72,accent);r(c,x-31,330,62,4,accent);r(c,x+27,386,5,5,'#f1d896');r(c,x-47,425,94,7,'#c9b792');
    r(c,x-76,241,152,25,accent);r(c,x-73,244,146,19,english?'#a38ba8':'#7fa0af');c.fillStyle='#fff1cb';c.font='bold 11px monospace';c.fillText(english?'SALA · MIQUEIAS':'SALA · ALMIRO',x-66,258);
    c.fillStyle='#c9ddbc';c.font='bold 8px monospace';c.fillText(english?'ENGLISH IS VERY BOM':'CIÊNCIAS DA ROÇA',x-53,311);
    for(let i=0;i<2;i++){r(c,x-58+i*110,276,5,154,'#eddbb1');r(c,x-58+i*110,276,2,152,'#fff0c7');}
  }
  function worldExtensions(c,scene,camera,t) {
    const width=worldWidth(scene);c.save();c.translate(-Math.round(camera),0);
    if(scene===0){
      for(let x=2590,i=0;x<width;x+=245,i++){
        fence(c,x,425,223);if(i%3===0)tree(c,x+149,430,.8+i%2*.2,i%2);else bush(c,x+145,434,83,'#659347');
        if(i%3===1){r(c,x+10,415,68,23,'#a77c45');r(c,x+8,410,72,7,'#dfbd6c');r(c,x+14,419,61,2,'#d1a75d');r(c,x+14,430,61,2,'#d1a75d');}
        for(let j=0;j<9;j++){let xx=x+15+j*22;grass(c,xx,435,i+j);if((j+i)%5===0)flower(c,xx,430,'#f7d265');}
      }
      house(c,3505,430);r(c,4320,367,7,73,'#795b3e');r(c,4280,358,89,25,'#c5a46a');c.fillStyle='#4a5e3b';c.font='bold 10px monospace';c.fillText('TRILHA DA ROÇA',4284,375);
    }else if(scene===1){
      // The long school corridor continues all the way to the last playground gate.
      r(c,1840,225,width-1840,208,'#edf3f4');r(c,1840,215,width-1840,14,'#193b61');r(c,1840,229,width-1840,7,'#ffffff');r(c,1840,368,width-1840,65,'#244c73');r(c,1840,368,width-1840,5,'#16324f');
      for(let x=1900;x<width-100;x+=180){r(c,x,270,92,71,'#4c6c80');r(c,x+4,274,84,62,'#749b9c');r(c,x+8,278,34,24,'#b5cfc6');r(c,x+47,309,36,23,'#8bb5aa');r(c,x+42,275,4,61,'#d8e8ec');r(c,x+4,303,84,4,'#d8e8ec');r(c,x-3,341,98,6,'#b9cfdc');}
      classroomDoor(c,1350,'almiro',t);classroomDoor(c,2350,'miqueias',t);
      // Early nightmare sketches foreshadow Marco's living paper monsters.
      for(let i=0;i<5;i++){
        const x=2670+i*169;poly(c,[[x-57,267],[x+51,263],[x+58,349],[x+38,359],[x+16,353],[x-9,362],[x-56,353]],'#d4cfb5');r(c,x-40,277,75,2,'#a7a296');
        c.save();c.translate(x,321);c.scale(1.35,1.35);doodle(c,0,0,i%3,t*.35+i,false);c.restore();
        c.fillStyle='#675975';c.font='bold 8px monospace';c.fillText(['NÃO ABRA O CADERNO','ELES ESTÃO OLHANDO','SÓ UM RABISCO...','O PAPEL RESPIRA','MARCO ESTEVE AQUI'][i],x-53,375);
      }
      const phrases=['da roça poudiaaam','reeeis pouddiaaam','da roça pegou ar','teketeketeketeke','o pra ravid falando sozinho'];
      for(let i=0;i<5;i++){
        const x=4020+i*183; r(c,x,263,172,103,'#6e6951');r(c,x+5,268,162,92,'#77bcb6');r(c,x+10,274,152,2,'#a5e2da');
        c.fillStyle='#204f57';c.font='bold '+(i===4?9:11)+'px monospace';const words=phrases[i].split(' ');let line='',yy=304;for(const word of words){if((line+word).length>(i===4?21:18)){c.fillText(line.trim(),x+13,yy);line='';yy+=17;}line+=word+' ';}c.fillText(line.trim(),x+13,yy);r(c,x+11,352,145,3,'#85977a');
      }
      for(let x=2700;x<width;x+=470){r(c,x,402,58,8,'#977343');r(c,x+6,410,6,29,'#536952');r(c,x+47,410,6,29,'#536952');bush(c,x+114,435,48);}
      r(c,width-150,285,97,146,'#52736a');r(c,width-145,292,87,132,'#8ba997');c.fillStyle='#dfe6bb';c.font='bold 10px monospace';c.fillText('SAÍDA →',width-138,314);
    }else if(scene===2){
      for(let x=2680,i=0;x<width;x+=350,i++){
        r(c,x,314,130,102,'#263e3b');r(c,x+7,321,116,89,'#7d9889');r(c,x+15,330,42,67,'#99afa1');r(c,x+63,328,3,74,'#c5ccb0');
        r(c,x-15,413,152,8,'#293f39');for(let j=0;j<4;j++){const xx=x+j*33;r(c,xx,396,26,5,'#a6b69c');r(c,xx+2,389,6,19,'#304e43');r(c,xx+18,389,6,19,'#304e43');}
        c.fillStyle='#c0c99a';c.font='bold 12px monospace';c.fillText(['FORÇA DA ROÇA','UMA REPETIÇÃO A MAIS','FOCO NO BOLO'][i%3],x-5,293);
      }
    }else if(scene===3){
      for(let x=2700,i=0;x<width;x+=420,i++){
        r(c,x,202,7,236,'#4b7267');r(c,x-25,193,56,13,'#405c57');for(let j=0;j<4;j++)r(c,x-19+j*12,196,9,7,'#e1e8be');
        for(let j=0;j<3;j++){r(c,x+64-j*9,361+j*21,190+j*18,8,'#b3997b');r(c,x+70-j*9,369+j*21,5,61-j*21,'#4b6d5b');r(c,x+239+j*9,369+j*21,5,61-j*21,'#4b6d5b');}
        r(c,x+76,347,142,2,'#78966f');
      }
      r(c,3920,247,216,35,'#4d7263');c.fillStyle='#e2dab1';c.font='bold 13px monospace';c.fillText('QUADRA · FINAL DO RECREIO',3931,270);
    }
    c.restore();
  }
  function platform(c,x,y,w,theme='wood') {
    const kind=typeof theme==='object'?theme.theme||'wood':theme;
    const colors={house:['#80634d','#f0dbb4'],rayssa:['#80634d','#f0dbb4'],patio:['#426d82','#e7ede0'],bigodon:['#5d4c3b','#e5c28c'],barber:['#5d4c3b','#e5c28c'],favela:['#70615b','#d9b68d'],caderno:['#6b567e','#e6cddd'],campo:['#44734a','#c6dca6'],plaza:['#738c91','#dae5de'],wood:['#77603f','#c7a66a'],school:['#7f8c80','#d5d4ac'],doodles:['#5a4c75','#c6a9da'],words:['#4e7059','#dedcb3'],gym:['#3e514c','#a4b39c'],court:['#6f7968','#d7c39b']};
    const pal=colors[kind]||colors.wood;c.save();r(c,x-2,y,w+4,16,'#2c3b31');r(c,x,y+2,w,10,pal[0]);r(c,x,y,w,4,pal[1]);for(let i=8;i<w;i+=23){r(c,x+i,y+5,2,6,pal[1]);r(c,x+i+3,y+8,8,1,'#334238');}r(c,x+4,y+14,w-8,3,pal[0]);c.restore();
  }
  function classroom(c,roomId,t=0) {
    c.save();c.imageSmoothingEnabled=false;const en=roomId==='miqueias';
    r(c,0,0,960,540,en?'#e3eef0':'#e9f2f3');r(c,0,0,960,29,'#1c3f64');r(c,0,29,960,9,'#e8dec1');
    for(let row=0;row<7;row++)for(let col=0;col<17;col++){let x=col*62+(row%2)*31;r(c,x,45+row*47,54,1,en?'#c3b4a5':'#9ab8c1');r(c,x,45+row*47,1,41,en?'#c3b4a5':'#9ab8c1');}
    r(c,0,352,960,88,'#2d5278');r(c,0,349,960,7,'#e8d8b2');
    // Windows and a clearly marked exit remain readable behind the desks.
    for(const x of [155,803]){r(c,x,81,111,113,'#6b817d');r(c,x+5,86,101,103,'#a4d2e5');cloud(c,x+12,116,.7,'#fffdf0');r(c,x+52,86,4,103,'#eadfc0');r(c,x+5,135,101,4,'#eadfc0');r(c,x-4,194,119,7,'#7e8d7a');}
    r(c,40,241,96,199,'#665d4c');r(c,47,247,82,193,en?'#7b7a83':'#6d8c97');r(c,55,260,66,92,'#a9c5c8');r(c,59,264,58,84,'#d3dfcf');r(c,112,376,5,5,'#edcc86');r(c,36,433,104,7,'#d1bd91');r(c,48,213,81,22,'#3e665b');c.fillStyle='#f4eccb';c.font='bold 12px monospace';c.fillText('← SAÍDA',55,229);
    // Broad chalkboards, with each teacher's own comic classroom identity.
    r(c,294,65,488,169,'#8f7653');r(c,301,72,474,154,'#78bfb8');r(c,308,79,460,2,'#beeee4');poly(c,[[332,80],[368,80],[497,220],[461,220]],'#9fded34d');poly(c,[[612,80],[629,80],[757,220],[740,220]],'#d4f7ec45');r(c,300,228,477,8,'#bd9f69');
    c.fillStyle='#1d5155';c.font='bold '+(en?18:23)+'px monospace';c.fillText(en?'MY ENGLISH IS VERY BOM TODAY!':'CIÊNCIAS DA ROÇA',en?315:331,107);
    c.font='bold 14px monospace';c.fillText(en?'The bolo are disappear.':'Bolo + sapo = aventura',325,140);c.fillText(en?'You is ready? ALLRIGHT!':'Hipótese: o bolo foi roubado.',325,163);c.font='bold 12px monospace';c.fillText(en?'BELEZA CREUZA!  CONCORDA OU SEM CORDA?':'Observação + amizade + muita coragem',325,192);
    r(c,311,219,20,3,'#eee9c7');r(c,699,218,35,8,'#c6b37e');r(c,702,215,29,4,'#85998b');
    for(let i=0;i<2;i++){const x=160+i*644;r(c,x,224,95,61,'#8b785d');r(c,x+3,227,89,55,'#f0dfb0');c.fillStyle=en?'#74627f':'#597687';c.font='bold 9px monospace';c.fillText(en?(i?'HELLO, TURMA!':'BOOK = LIVRO'):(i?'AULA COM HUMOR':'PENSE. OBSERVE.'),x+8,249);c.fillText(en?(i?'GOOD LANCHE!':'CAKE = BOLO'):(i?'E CURIOSIDADE!':'FAÇA PERGUNTAS.'),x+8,267);}
    // Twelve decorative students, each seated and idly writing rather than walking.
    const skins=['#edc5a0','#9a6546','#c18b60','#e7b994'],hairs=['#3d362d','#705239','#2d3330','#b3945b'];
    for(let row=0;row<3;row++)for(let col=0;col<4;col++){
      const i=row*4+col,xx=244+col*139,yy=259+row*47,bob=Math.round(Math.sin(t*1.7+i)*.8),skin=skins[i%4];
      r(c,xx-17,yy+15,37,22,'#337ab3');r(c,xx-13,yy+21,5,18,'#234d75');r(c,xx+10,yy+21,5,18,'#234d75');
      r(c,xx-14,yy-2+bob,29,25,i%3===0?'#e3ebed':'#244e7b');r(c,xx-9,yy-21+bob,21,20,'#4b4034');r(c,xx-8,yy-20+bob,19,17,skin);r(c,xx-9,yy-23+bob,21,7,hairs[i%4]);r(c,xx-9,yy-17+bob,4,7,hairs[i%4]);r(c,xx+5,yy-13+bob,2,2,'#393c31');
      if(Math.sin(t*3+i*2)>.92)r(c,xx+4,yy-13+bob,5,1,'#76513a');
      r(c,xx-18,yy+6,6,11,skin);r(c,xx+12,yy+5,6,11,skin);r(c,xx+14+Math.round(Math.sin(t*3+i)*2),yy+13,8,4,skin);
      r(c,xx-39,yy+19,80,8,'#8e714d');r(c,xx-38,yy+19,78,3,'#d2b27a');r(c,xx-32,yy+27,4,19,'#65735e');r(c,xx+30,yy+27,4,19,'#65735e');r(c,xx-16,yy+16,24,4,'#f0e5bb');r(c,xx-12,yy+15,13,1,'#72908a');r(c,xx+19,yy+15,11,3,'#cfb065');
    }
    // The teacher stands in the clear foreground by x600; the desk is to the right.
    r(c,736,377,145,14,'#ac8756');r(c,741,391,9,48,'#786846');r(c,866,391,9,48,'#786846');r(c,752,393,104,36,'#9b7c50');r(c,785,402,5,4,'#d5bf87');r(c,759,367,34,9,en?'#678b6f':'#7b96a6');r(c,763,365,29,3,'#e7deb7');r(c,824,365,13,12,'#d4ba7d');r(c,826,358,2,13,'#7c8460');r(c,830,355,2,16,'#a8684b');
    r(c,0,440,960,100,en?'#a58d70':'#8e9384');r(c,0,440,960,6,'#d2c5a0');for(let x=0;x<960;x+=80)r(c,x,447,1,93,'#747d6c');r(c,0,495,960,1,'#747d6c');
    c.restore();
  }
  function newArena(c,type,camera,t,homeX) {
    c.save();const center=homeX?homeX-camera:480;c.translate(Math.round(center-480),0);
    if(type==='nicolas'){
      // His imagined heaven has its own visual language: living constellations and a sunwheel.
      r(c,-500,0,1960,440,'#183650');r(c,-500,155,1960,285,'#326975');r(c,-500,280,1960,160,'#5a9795');
      const halo=94+Math.sin(t*.9)*3;oval(c,480,171,halo+16,halo+16,'#739b8c',4);oval(c,480,171,halo,halo,'#d5c58a',4);oval(c,480,171,halo-7,halo-7,'#346d7a',4);oval(c,480,171,54,54,'#c4dcc0',4);oval(c,480,171,44,44,'#f7e8af',4);
      for(let i=0;i<12;i++){const a=i*Math.PI/6+t*.07,xx=480+Math.cos(a)*(halo+3),yy=171+Math.sin(a)*(halo+3);poly(c,[[xx-4,yy],[xx,yy-8],[xx+4,yy],[xx,yy+8]],'#ffecb1');}
      for(let i=0;i<8;i++){const x=-65+i*158,yy=235+Math.sin(t*.8+i)*8;poly(c,[[x,yy],[x+110,yy-9],[x+80,yy+16],[x+21,yy+22]],'#8abeb3');r(c,x+29,yy+22,48,8,'#3d7580');}
      for(const xx of [-72,109,747,920]){r(c,xx,149,48,283,'#294c60');r(c,xx+6,154,36,269,'#aeb99b');r(c,xx+9,157,7,264,'#e0d3a2');r(c,xx+25,158,8,263,'#819c93');r(c,xx-7,142,62,16,'#e4ce8e');r(c,xx-11,133,70,11,'#a38b59');r(c,xx-8,414,64,18,'#d6c28c');for(let j=0;j<5;j++){const yy=182+j*39;r(c,xx+19,yy,10,3,'#dbf5d7');r(c,xx+22,yy-4,3,11,'#93dace');}}
      // Cracks of cyan light separate gold-capped stone, with no borrowed insignia.
      poly(c,[[72,295],[123,272],[153,286],[166,310],[196,299],[209,332],[245,313],[272,337]],'#bcdbc1');
      for(let i=0;i<28;i++){const xx=hash(i+37)*1160-100,yy=24+hash(i+53)*290+Math.sin(t+i)*7;r(c,xx,yy,2,2,i%2?'#e0f8d9':'#f7e6aa');if(i%4===0){r(c,xx-3,yy+1,8,1,'#a2dfd7');r(c,xx+1,yy-3,1,8,'#a2dfd7');}}
      r(c,-500,390,1960,50,'#446a74');r(c,-500,389,1960,7,'#b7d0b8');for(let i=0;i<11;i++){const xx=-110+i*111;r(c,xx,408,88,3,'#80aaa2');r(c,xx+23,404,3,17,'#80aaa2');}
      c.restore();r(c,0,440,960,100,'#657f7d');r(c,0,440,960,6,'#f0dc9b');r(c,0,447,960,4,'#315a65');for(let i=0;i<20;i++){const xx=i*57;r(c,xx,450,2,90,'#3f626b');r(c,xx+3,493,53,2,'#bad3b1');if(i%3===0){r(c,xx+21,460,3,17,'#abe9da');r(c,xx+15,467,15,3,'#ddedb6');}}return;
    }
    // Freddy guards an original rooftop fighting ring above the evening favela.
    r(c,-500,0,1960,120,'#6d6c91');r(c,-500,120,1960,135,'#c38f91');r(c,-500,255,1960,185,'#e2b28a');oval(c,728,175,45,45,'#f5d3a0',4);
    for(let i=-2;i<10;i++){const xx=i*141,hh=85+hash(i+13)*100;favelaHouse(c,xx,360-hh,132,hh,i+30,t,true);for(let j=0;j<3;j++)r(c,xx+14+j*36,341-hh,15,23,'#ebcc93');}
    r(c,-500,348,1960,92,'#5a555d');r(c,-500,347,1960,8,'#c2987c');for(let xx=-500;xx<1460;xx+=45){r(c,xx,357,2,79,'#8d7370');r(c,xx+9,389,28,1,'#9f8178');}
    for(const xx of [71,842]){r(c,xx,142,7,207,'#344a59');r(c,xx-19,132,47,15,'#263b4b');for(let j=0;j<4;j++)r(c,xx-14+j*10,135,7,7,'#f7d997');r(c,xx-24,270,58,78,'#293c47');r(c,xx-20,274,50,70,'#58636a');oval(c,xx+5,307,23,23,'#253c48',3);oval(c,xx+5,307,14,14,'#a7b5aa',3);}
    r(c,245,151,470,46,'#3b4555');r(c,250,156,460,36,'#77556b');c.fillStyle='#f5dca5';c.font='bold 22px monospace';c.fillText('FREDDY · ÚLTIMO RECADO',274,182);
    r(c,-200,236,1360,2,'#46505a');for(let i=0;i<21;i++){const xx=-195+i*65,wave=Math.sin(t*1.5+i)*3;poly(c,[[xx,238],[xx+26,238],[xx+14,259+wave]],i%3===0?'#e3b887':i%3===1?'#8dc4bf':'#cb8e9f');}
    r(c,353,309,253,16,'#263d49');c.fillStyle='#e9ca9b';c.font='bold 11px monospace';c.fillText('ÔÔÔ REEEIS, ASSISTE ESSA!',374,321);c.restore();
    r(c,0,440,960,100,'#77645e');r(c,0,440,960,6,'#d7b38a');for(let i=0;i<20;i++){r(c,i*51,452,1,88,'#4d4e56');r(c,i*51+8,480,26,2,'#a88a78');}r(c,0,499,960,2,'#b59880');
  }

  function monitorArena(c,type,camera,t,homeX){
    const center=homeX?homeX-camera:480;r(c,0,0,960,540,'#dbe9e6');r(c,0,292,960,148,'#225075');r(c,0,288,960,8,'#f3f4e5');c.save();c.translate(Math.round(center-480),0);
    for(let i=0;i<6;i++){const x=-80+i*200;r(c,x,126,130,135,'#3a667f');r(c,x+6,132,118,123,'#96c9ce');r(c,x+62,132,5,123,'#eef1df');r(c,x+6,191,118,5,'#edf2de');r(c,x-6,258,142,8,'#c3d9ce');}
    r(c,125,45,710,45,'#f7f1da');r(c,131,51,698,33,'#254e71');c.fillStyle='#fff0c4';c.font='bold 21px monospace';c.textAlign='center';c.fillText(type==='igor'?'CANTINA · FISCALIZAÇÃO DO LANCHE':'CORREDOR · FISCALIZAÇÃO MÁXIMA',480,75);
    if(type==='igor'){
      r(c,65,319,210,121,'#b08c65');r(c,59,308,222,15,'#edd9ad');r(c,76,331,188,14,'#8c7356');for(let j=0;j<5;j++){oval(c,89+j*35,302,13,7,'#d8a269',3);r(c,82+j*35,299,14,3,'#efc68d');}r(c,695,324,190,116,'#668d99');r(c,688,314,204,13,'#d4ddd0');c.font='bold 13px monospace';c.fillStyle='#f0e8bd';c.fillText('LANCHES ACABARAM',172,363);c.fillText('BARRIGA EM SERVIÇO',789,361);
    }else{for(const start of[45,760])for(let j=0;j<3;j++){const x=start+j*52;r(c,x,301,45,139,'#5c8ca2');r(c,x+3,306,39,132,'#7aa6b2');r(c,x+6,311,33,8,'#31617e');r(c,x+7,350,8,4,'#e3dfc1');}r(c,350,140,260,100,'#75b5b4');r(c,357,147,246,86,'#8bcac5');c.font='bold 16px monospace';c.fillStyle='#295d68';c.fillText('BOLINHAS NO CESTO!',480,179);c.font='bold 12px monospace';c.fillText('OLHE A MIRA. ATAQUE NA RECARGA.',480,210);}
    r(c,-300,440,1560,100,'#a7bcb9');r(c,-300,440,1560,6,'#f2edcf');for(let x=-300;x<1260;x+=64){r(c,x,446,2,94,'#8fa7a5');r(c,x+7,479,46,2,'#c7d4c8');}c.restore();
  }
  function arena(c,bossType,camera=0,t=0,homeX=0) {
    c.save();c.imageSmoothingEnabled=false;const type=typeof bossType==='object'?bossType.type:bossType;if(type==='dede'||type==='arthur'){questArena(c,type,camera,t,homeX);c.restore();return;}if(type==='nicolas'||type==='freddy'){newArena(c,type,camera,t,homeX);c.restore();return;}if(type==='reeisBoss'||type==='giant'){specialArena(c,type,camera,t,homeX);c.restore();return;}const center=homeX?homeX-camera:480;
    if(type==='igor'||type==='kaique'){monitorArena(c,type,camera,t,homeX);c.restore();return;}
    const marco=type==='marco',menezes=type==='menezes';
    r(c,0,0,960,540,marco?'#27233d':menezes?'#382b35':'#8bb7d3');
    c.save();c.translate(Math.round(center-480),0);
    if(marco){
      for(let i=0;i<10;i++){let x=-100+i*120;poly(c,[[x,0],[x+94,0],[x+103,237],[x+81,229],[x+55,244],[x+34,230],[x+8,239]],i%2?'#69617d':'#5a546e');r(c,x+16,43,62,2,'#a69bad');r(c,x+22,61,54,2,'#a69bad');}
      r(c,177,49,609,41,'#3f3653');r(c,182,54,599,31,'#6c5677');c.fillStyle='#f2d8a6';c.font='bold 22px monospace';c.fillText('RABISCOS À SOLTA',332,78);
      for(let i=0;i<5;i++){const x=70+i*203,y=170+(i%2)*59;c.save();c.translate(x,y);c.scale(2.5,2.5);doodle(c,0,0,i%3,t*.35+i,true);c.restore();}
      for(let i=0;i<13;i++){const x=hash(i+3)*1000,yy=70+hash(i+18)*230;r(c,x,yy+Math.sin(t+i)*5,4,8,'#d8c6dd');}
      r(c,-300,347,1560,93,'#4b3b60');for(let x=-300;x<1260;x+=49){r(c,x,347,3,93,'#76547f');r(c,x+17,380,18,2,'#9a6d94');}
      // A central giant sketchbook is a backdrop, leaving the actor band uncluttered.
      poly(c,[[302,278],[476,292],[477,387],[300,369]],'#b1a2bb');poly(c,[[480,292],[654,277],[657,369],[481,387]],'#cfbfd0');r(c,476,291,6,97,'#68546f');
      for(let j=0;j<5;j++){r(c,323,299+j*13,116,2,'#7c6385');r(c,513,299+j*13,116,2,'#997ea1');}
    }else if(menezes){
      r(c,-300,27,1560,27,'#6c514b');r(c,-300,54,1560,13,'#c1a16f');
      for(let side=0;side<2;side++){const x=side?817:-200;r(c,x,54,345,344,'#7b4252');for(let j=0;j<12;j++)r(c,x+j*28,60,10,330,'#a85e61');poly(c,[[x,253],[x+344,315],[x+344,343],[x,286]],'#c39865');}
      r(c,181,83,600,227,'#8c7552');r(c,188,90,586,213,'#2f5147');r(c,197,98,568,2,'#668168');c.fillStyle='#e7e2bd';c.font='bold 22px monospace';c.fillText('PALCO DA PROVOCAÇÃO',265,129);c.font='bold 19px monospace';c.fillText('da roça poudiaaam',262,170);c.fillText('reeeis pouddiaaam',417,199);c.fillText('da roça pegou ar',250,232);c.font='bold 15px monospace';c.fillText('teketeketeketeke',438,261);c.fillText('o pra ravid falando sozinho',229,285);
      for(const x of [107,779]){r(c,x,286,81,152,'#263b37');r(c,x+5,291,71,142,'#47544c');oval(c,x+40,326,25,25,'#25342f',3);oval(c,x+40,326,17,17,'#8b9978',3);oval(c,x+40,326,7,7,'#3f5749',2);oval(c,x+40,395,28,28,'#25342f',3);oval(c,x+40,395,18,18,'#839572',3);oval(c,x+40,395,7,7,'#3f5749',2);}
      r(c,0,398,960,42,'#68594e');for(let x=0;x<960;x+=53)r(c,x,400,2,40,'#9d8262');
    }else{
      cloud(c,64,63,1.6,'#fff4d6');cloud(c,701,96,1.4,'#fff4d6');oval(c,751,83,30,30,'#ffe7a8',4);
      r(c,-200,239,1360,201,'#9e7256');r(c,-200,243,1360,9,'#d1a273');
      // Chocolate pavilion, icing drips and a ridiculous mucus-and-cake throne.
      r(c,211,154,541,45,'#6f4937');r(c,202,147,558,15,'#e4bf83');for(let i=0;i<12;i++)r(c,215+i*46,159,13,15+(i%3)*6,'#d8b17a');
      for(const x of [227,718]){r(c,x,192,16,237,'#644634');r(c,x+4,193,5,231,'#aa8055');}
      r(c,374,262,214,152,'#624937');r(c,385,272,192,132,'#85a45d');r(c,393,279,176,125,'#a8bd69');r(c,410,300,143,7,'#72994f');r(c,410,329,143,7,'#72994f');
      poly(c,[[374,267],[380,235],[406,258],[434,222],[461,254],[486,213],[513,255],[544,229],[565,259],[588,237],[588,272]],'#6b8d43');
      r(c,356,365,35,67,'#74643e');r(c,570,365,35,67,'#74643e');r(c,359,360,33,12,'#b6c26b');r(c,570,360,33,12,'#b6c26b');
      for(const x of [128,806]){r(c,x-48,372,96,58,'#704934');r(c,x-44,382,88,16,'#d0a66b');r(c,x-49,369,98,13,'#e5c58e');for(let i=0;i<5;i++)r(c,x-43+i*19,380,7,8+i%2*5,'#e5c58e');cake(c,x,369);}
      c.fillStyle='#f7e4bc';c.font='bold 18px monospace';c.fillText('O TRONO DO BOLO ROUBADO',339,183);
      for(let i=0;i<10;i++){const x=116+i*78;oval(c,x,433,22,5,'#84a24e',2);r(c,x+4,425-Math.abs(Math.sin(t*2+i))*6,3,6,'#bbcb6c');}
    }
    c.restore();
    r(c,0,440,960,100,marco?'#4c3a5e':menezes?'#755d47':'#865c40');r(c,0,440,960,6,marco?'#c19bc6':menezes?'#dbbd86':'#d8ba7b');
    for(let i=0;i<20;i++){r(c,i*53,451,1,89,marco?'#735780':menezes?'#a18461':'#a98256');r(c,i*53+7,473,26,2,marco?'#8b6594':menezes?'#8f7255':'#b2925c');}
    c.restore();
  }
  function thug(c,x,y,t=0,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale(o.facing<0?-1:1,1);const scale=Number(o.scale)||1;c.scale(scale,scale);const tier=Math.max(1,Math.min(4,Number(o.tier)||1)),walking=o.moving!==false,step=walking?Math.sin(t*9)*7:0,bob=walking?Math.round(Math.abs(Math.sin(t*9))*2):Math.round(Math.sin(t*2));
    oval(c,0,0,17,3,'#2a443b',2);for(const side of [-1,1]){const fx=side*6+Math.round(step*side);limb(c,[[side*5,-22],[side*4,-12],[fx,-4]],9,'#2d3035');limb(c,[[side*5,-22],[side*4,-12],[fx,-4]],5,tier%2?'#3e5267':'#4f4b59');r(c,fx-4,-5,12,5,'#242f35');r(c,fx-3,-2,10,2,'#b1b59e');}
    c.translate(0,-bob);const hood=['#567573','#6b576e','#7b634a','#443f64'][tier-1],skin=['#a47550','#d1aa84','#bc8762','#9a684b'][tier-1];r(c,-15,-41,31,24,'#252b33');r(c,-13,-40,27,21,hood);r(c,-2,-38,3,19,'#93aca4');r(c,-14,-25,28,4,'#38494c');r(c,-14,-60,29,22,'#282e36');r(c,-13,-65,27,12,hood);r(c,-10,-59,21,17,skin);r(c,-11,-58,4,16,hood);r(c,9,-58,5,15,hood);r(c,-6,-54,6,2,'#27373a');r(c,5,-54,6,2,'#27373a');r(c,-8,-48,21,8,'#34484d');r(c,-4,-45,12,1,'#657a79');
    const recoil=o.attack?Math.round((.5+.5*Math.sin(t*25))*4):0;const barrel=o.weapon==='carbine'?37:o.weapon==='scatter'?31:20;c.save();c.translate(-recoil,0);limb(c,[[-11,-35],[-7,-27],[17,-28]],8,'#26353a');limb(c,[[-11,-35],[-7,-27],[17,-28]],5,hood);limb(c,[[12,-36],[20,-31],[26,-29]],8,'#26353a');limb(c,[[12,-36],[20,-31],[26,-29]],5,skin);r(c,15,-33,barrel,7,'#263b43');r(c,18,-35,barrel-6,3,'#9aabaa');r(c,23,-26,7,10,'#52616a');r(c,27,-17,8,3,'#253942');if(o.weapon==='scatter'){r(c,26,-30,18,3,'#ad8664');r(c,20,-26,8,8,'#92714e');}else if(o.weapon==='carbine'){r(c,13,-31,7,7,'#5c6e68');r(c,37,-29,5,7,'#849c91');r(c,28,-40,9,4,'#354d56');}if(o.attack&&Math.sin(t*29)>.7)poly(c,[[15+barrel,-33],[24+barrel,-38],[22+barrel,-31],[30+barrel,-29],[22+barrel,-26],[24+barrel,-21],[15+barrel,-26]],'#ffd593');c.restore();if(tier>1){r(c,-8,-36,17,12,'#3c5158');r(c,-6,-34,13,2,'#718a83');for(let i=0;i<tier-1;i++)r(c,-5+i*4,-29,2,2,'#dab473');}if(o.hit){c.globalAlpha*=.55;r(c,-15,-64,32,46,'#ffe4bf');}c.restore();
  }
  function giant(c,x,y,t=0,o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale(o.facing<0?-1:1,1);const size=Number(o.scale)||1;c.scale(size,size);const pulse=Math.round(Math.sin(t*3)*3),attack=!!o.attack,raise=attack?Math.round((.5+.5*Math.sin(t*5))*30):0;
    oval(c,0,0,83,10,'#263b39',4);for(const side of [-1,1]){const lift=o.moving?Math.max(0,Math.sin(t*5+side))*8:0;poly(c,[[side*18,-48],[side*49,-42],[side*61,-lift],[side*25,-lift]],'#252039');r(c,side>0?23:-62,-13-lift,40,12,'#8c6aa1');r(c,side>0?27:-57,-10-lift,31,4,'#c4a2b8');}
    // A colossal ink creature stitched from ugly notebook margins and torn paper.
    poly(c,[[-59,-133],[-34,-157],[-15,-150],[0,-169],[20,-150],[41,-159],[63,-133],[70,-78],[53,-39],[17,-27],[-17,-26],[-56,-44],[-72,-81]],'#211e37');poly(c,[[-51,-129],[-30,-149],[-12,-139],[1,-157],[17,-140],[37,-147],[55,-125],[59,-82],[43,-47],[15,-37],[-15,-37],[-47,-51],[-60,-84]],'#4a3c65');poly(c,[[-52,-96],[-40,-121],[-15,-126],[12,-123],[44,-115],[54,-89],[31,-62],[-8,-61],[-41,-72]],'#6d527f');
    for(const side of [-1,1]){const yy=-106-raise+(side>0?pulse:-pulse);limb(c,[[side*48,-111],[side*83,yy],[side*98,yy+45]],31,'#211e37');limb(c,[[side*48,-111],[side*83,yy],[side*98,yy+45]],22,'#655076');poly(c,[[side*84,yy+29],[side*108,yy+27],[side*117,yy+49],[side*105,yy+64],[side*82,yy+56]],'#29243f');for(let j=0;j<3;j++)r(c,side>0?91+j*7:-112+j*7,yy+46,5,15,'#bca5b7');}
    // 6 / 7 eyes are deliberately hand-drawn meme-like figures, not borrowed artwork.
    oval(c,-23,-116+pulse,19,23,'#c8e0b3',3);oval(c,24,-118-pulse,19,22,'#d3b8da',3);r(c,-33,-131+pulse,17,4,'#293347');r(c,-33,-128+pulse,4,24,'#293347');r(c,-33,-116+pulse,16,4,'#293347');r(c,-21,-115+pulse,4,13,'#293347');r(c,-32,-105+pulse,14,4,'#293347');r(c,15,-132-pulse,20,4,'#3b2e4c');limb(c,[[33,-128-pulse],[22,-105-pulse]],4,'#3b2e4c');r(c,-27,-126+pulse,4,4,'#f1f4cb');r(c,24,-128-pulse,4,4,'#f6e3ed');
    const maw=attack?23:15+Math.round(Math.sin(t*2)*2);r(c,-35,-87,73,maw,'#151a2b');for(let i=0;i<7;i++){r(c,-31+i*10,-87,6,7+(i%2)*3,'#d5c7cc');r(c,-26+i*10,-87+maw-6,5,6,'#a0c5a0');}r(c,-17,-79,37,2,'#8d667d');for(let i=0;i<7;i++){const xx=-45+i*15,yy=-51+(i%3)*4;r(c,xx,yy,5,8+((t*12+i*3)%11),'#9ab276');}for(let i=0;i<9;i++){const xx=Math.sin(t*2+i)*78,yy=-22-((t*32+i*19)%157);r(c,xx,yy,3,6,i%2?'#c6a1cb':'#98ba8a');}if(o.hit){c.globalAlpha*=.6;oval(c,0,-95,67,67,'#f6d8df',4);}c.restore();
  }
  function sarueTrap(c,x,y,t=0,active=false) {
    c.save();c.translate(Math.round(x),Math.round(y));const alpha=c.globalAlpha;c.globalAlpha*=active?.9:.65;oval(c,0,-2,36,7,active?'#a13c45':'#5d416b',2);r(c,-32,-7,65,10,active?'#e14b4b':'#9e78a7');r(c,-29,-6,59,6,active?'#582b40':'#3a344f');c.fillStyle=active?'#ffe1ca':'#d9b9d8';c.font='bold 9px monospace';c.textAlign='center';c.fillText('SARUÊ!',0,1);c.textAlign='left';if(active){c.globalAlpha=alpha*.65;for(let i=0;i<8;i++){const yy=-((t*70+i*12)%60);r(c,-27+i*8,yy,3,7,'#ef695e');}}else{r(c,-27,-8,3,2,'#b49ac1');r(c,24,-8,3,2,'#b49ac1');}c.restore();
  }
  function specialArena(c,type,camera,t,homeX) {
    c.save();const center=homeX?homeX-camera:480;
    if(type==='reeisBoss'){
      sky(c,5,camera*.1,t);favela(c,camera*.24,t);r(c,0,0,960,440,'#18354f44');c.save();c.translate(Math.round(center-480),0);r(c,-150,332,1260,108,'#765449');r(c,-150,329,1260,12,'#c7a97a');for(let x=-150;x<1110;x+=43){r(c,x,344,1,95,'#a97553');r(c,x,361,34,1,'#a97553');r(c,x+17,385,24,1,'#a97553');}
      for(const x of [70,842]){r(c,x,134,9,197,'#293e45');r(c,x-22,120,53,19,'#304f5c');for(let i=0;i<4;i++)r(c,x-16+i*11,124,8,9,'#ffd99c');r(c,x-25,230,60,101,'#253842');r(c,x-20,234,50,94,'#47606a');for(let j=0;j<2;j++){oval(c,x+5,255+j*48,20,20,'#1e303b',3);oval(c,x+5,255+j*48,12,12,'#849b91',3);}}
      r(c,276,87,413,78,'#153c54');r(c,284,95,397,62,'#286577');c.fillStyle='#dfc372';c.font='bold 24px monospace';c.fillText('O TRONO DO MORRO',332,127);c.fillStyle='#a4e2d6';c.font='bold 12px monospace';c.fillText('GABRIEL REEIS · RESPEITA O REI',343,149);r(c,404,233,149,107,'#243d49');r(c,413,240,131,91,'#587a6b');r(c,420,245,117,80,'#718e6d');r(c,402,304,153,17,'#a48c58');for(let i=0;i<5;i++)poly(c,[[418+i*26,240],[430+i*26,216-i%2*9],[443+i*26,240]],'#d1b76f');
      for(let i=0;i<14;i++){const x=130+i*47,y=174+Math.sin(i)*13;r(c,x,y,23,2,'#293f4b');poly(c,[[x,y+2],[x+23,y+2],[x+11,y+24]],i%2?'#7fc6c6':'#d8bd78');}c.restore();r(c,0,440,960,100,'#746a60');r(c,0,440,960,6,'#d4be8b');for(let x=0;x<960;x+=64)r(c,x,448,1,92,'#514f4e');
    }else{
      inkRealm(c,camera*.22,t);r(c,0,0,960,440,'#201f37aa');c.save();c.translate(Math.round(center-480),0);for(let i=0;i<9;i++){const x=36+i*112,yy=32+Math.sin(t+i)*9;poly(c,[[x,yy],[x+79,yy+5],[x+84,yy+139],[x+63,yy+132],[x+45,yy+143],[x+17,yy+132]],'#9b86ad');for(let j=0;j<5;j++)r(c,x+12,yy+23+j*18,55,2,'#655476');}
      poly(c,[[177,230],[474,265],[475,416],[171,375]],'#c6b1cb');poly(c,[[480,265],[785,227],[790,375],[480,416]],'#e1cbd9');r(c,474,263,8,155,'#695578');for(let i=0;i<7;i++){r(c,206,258+i*16,215,2,'#9a7ca9');r(c,535,258+i*16,215,2,'#ae8dac');}r(c,300,79,369,46,'#473652');c.fillStyle='#f0cddd';c.font='bold 22px monospace';c.fillText('O RABISCO COLOSSAL',354,109);for(let i=0;i<13;i++){const xx=50+i*74,yy=376+Math.sin(t*2+i)*8;poly(c,[[xx,440],[xx+5,yy],[xx+14,yy-8],[xx+22,yy],[xx+26,440]],'#333049');}c.restore();r(c,0,440,960,100,'#564669');r(c,0,440,960,6,'#dec6d7');for(let x=0;x<960;x+=51){r(c,x,450,1,90,'#332f49');r(c,x+5,477,35,2,'#856d96');}
    }c.restore();
  }

  function memeMinion(c,x,y,t=0,kind='brainrot',o={}) {
    c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(x),Math.round(y));c.scale(o.facing<0?-1:1,1);const bob=Math.round(Math.sin(t*7)*3);oval(c,0,0,25,4,'#37403c',2);c.translate(0,-bob);
    if(kind==='sixseven'){
      const green='#a8d676',purple='#bc8fd3';r(c,-25,-44,21,6,'#2b343b');r(c,-27,-40,6,30,'#2b343b');r(c,-24,-27,20,5,'#2b343b');r(c,-9,-26,6,17,'#2b343b');r(c,-24,-11,20,6,'#2b343b');r(c,-22,-41,17,3,green);r(c,-24,-38,3,27,green);r(c,-22,-24,15,3,green);r(c,-8,-23,3,12,green);r(c,-21,-9,15,3,green);
      r(c,2,-45,27,7,'#2b343b');limb(c,[[25,-40],[9,-8]],8,'#2b343b');r(c,5,-42,20,3,purple);limb(c,[[24,-37],[10,-9]],4,purple);r(c,-20,-3,11,5,'#b6c6d0');r(c,8,-2,12,5,'#c8adba');r(c,-18,-21,4,4,'#263c39');r(c,7,-39,4,4,'#3d324b');r(c,17,-39,4,4,'#3d324b');limb(c,[[-25,-24],[-37,-20],[-32,-13]],4,green);limb(c,[[26,-31],[35,-22],[31,-17]],4,purple);r(c,-17,-13,7,2,'#faeccb');if(o.attack){c.fillStyle='#f5d5e7';c.font='bold 8px monospace';c.textAlign='center';c.fillText('SIX SEVEN!',0,-54);c.textAlign='left';}
    }else{
      // Original tomato-in-a-sneaker doodle: strange, playful and deliberately homemade.
      poly(c,[[-18,-28],[-13,-42],[-3,-48],[12,-43],[20,-31],[18,-17],[4,-11],[-12,-15]],'#402d45');oval(c,1,-29,17,17,'#cf6a68',3);oval(c,-4,-33,9,10,'#e3987a',3);poly(c,[[-11,-42],[-15,-50],[-5,-47],[0,-56],[5,-47],[15,-50],[12,-42]],'#7aa05e');r(c,-10,-33,6,8,'#ede4c4');r(c,1,-36,6,8,'#ede4c4');r(c,10,-30,5,6,'#ede4c4');r(c,-7,-31,2,4,'#49374f');r(c,3,-34,2,4,'#49374f');r(c,12,-29,2,3,'#49374f');r(c,-4,-22,12,4,'#593746');r(c,-2,-22,8,2,'#f8dfb9');poly(c,[[-13,-12],[-2,-9],[16,-13],[22,-6],[29,-6],[30,1],[-21,1],[-23,-5]],'#e9dfcf');r(c,-20,0,49,4,'#587a8c');r(c,-13,-7,20,2,'#a5b8bd');for(let i=0;i<3;i++)r(c,-8+i*5,-11,2,6,'#f9f1d7');limb(c,[[-15,-29],[-29,-24],[-26,-18]],4,'#b8899c');limb(c,[[17,-28],[29,-24],[28,-18]],4,'#b8899c');r(c,-30,-22,8,6,'#ddbaad');r(c,25,-21,8,6,'#ddbaad');
    }if(o.hit){c.globalAlpha*=.5;r(c,-30,-55,61,58,'#fce7d8');}c.restore();
  }

  function minion(c,x,y,kind=0,t=0,o={}) {
    const design=String(o.design||o.variant||(o.type&&o.type!=='doodle'?o.type:kind));if(['spindle','wobbler','pasta'].includes(design)){strangeMinion(c,x,y,t,design,o);return;}if(design==='rat'){rat(c,x,y,t,o);return;}if(design==='brainrot'||design==='sixseven'){memeMinion(c,x,y,t,design,o);return;}
    c.save();c.translate(Math.round(x),Math.round(y));c.scale(o.facing<0?-1:1,1);const k=Number(kind)||0,bob=o.moving===false?0:Math.round(Math.sin(t*9+k)*2);
    oval(c,0,0,18,3,'#314938',2);r(c,-13,-5,9,5,'#5f4d69');r(c,5,-4,9,4,'#5f4d69');doodle(c,0,-19-bob,k,t,o.angry);
    if(k===1){poly(c,[[-9,-32],[-15,-54],[-6,-49],[-3,-33]],'#735876');poly(c,[[5,-33],[11,-53],[17,-48],[12,-30]],'#735876');r(c,-12,-48,3,10,'#bea1b0');r(c,11,-47,3,10,'#bea1b0');}
    if(k===2){r(c,13,-22,9,8,'#5d4269');r(c,18,-20,9,4,'#c29cab');r(c,25,-19,2,3,'#2b2939');}
    if(o.hit){c.save();c.globalAlpha*=.65;r(c,-16,-37,33,34,'#fff1c8');c.restore();}c.restore();
  }
  window.Art={nikolasBounds,drawAcai:acai,drawRat:rat,drawTitleScene,drawGroundBridges:groundBridges,drawScene,drawCharacter:character,drawVehicle:vehicle,drawCake:cake,drawDoodle:doodle,drawMaterial:material,drawEnergyAura:energyAura,heroFrameCatalog,drawClassroom:classroom,drawArena:arena,drawPlatform:platform,drawMinion:minion,drawThug:thug,drawSarueTrap:sarueTrap,drawFootball:football};
})();
