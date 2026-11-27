/* Original, bounded pixel combat artwork. Every impact is emitted by a confirmed hit. */
(() => {
 'use strict';
 const INK='#263b42',CREAM='#fff1bf',LIMIT=18,history=Object.create(null);let events=[],serial=0;
 const clamp=(v,a,b)=>Math.max(a,Math.min(b,Number(v)||0));
 function rect(c,x,y,w,h,color){c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
 function poly(c,points,color){c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(Math.round(p[0]),Math.round(p[1])):c.moveTo(Math.round(p[0]),Math.round(p[1])));c.closePath();c.fill();}
 function pixelLine(c,points,color,size=2){c.fillStyle=color;for(let i=1;i<points.length;i++){const a=points[i-1],b=points[i],n=Math.max(1,Math.ceil(Math.max(Math.abs(b[0]-a[0]),Math.abs(b[1]-a[1]))));for(let j=0;j<=n;j++)c.fillRect(Math.round(a[0]+(b[0]-a[0])*j/n),Math.round(a[1]+(b[1]-a[1])*j/n),size,size);}}
 function cloud(c,x,y,size,color,light){const k=Math.max(2,Math.round(size/5));rect(c,x-k*3,y-k,k*6,k*3,INK);rect(c,x-k*2,y-k*2,k*4,k*5,INK);rect(c,x-k*3+2,y-k+2,k*6-4,k*3-4,color);rect(c,x-k*2+2,y-k*2+2,k*4-4,k*5-4,color);rect(c,x-k,y-k*2+3,k*2,k,light||CREAM);}
 function emit(type,data={}){
  if(!Number.isFinite(data.x)||!Number.isFinite(data.y))return;
  const duration=type==='surge'?.62:type==='gas'?.42:type==='dash'?.28:type==='cast'?.18:.24;
  history[type]=(history[type]||0)+1;
  const event={...data,id:++serial,type,age:0,duration,dir:data.dir<0?-1:1,stage:clamp(data.stage||1,1,3)};
  // Keep the latest contacts; repeated electric chains never allocate an army of effects.
  if(events.length>=LIMIT)events.shift();events.push(event);
 }
 function update(dt){dt=clamp(dt,0,.05);for(const e of events)e.age+=dt;events=events.filter(e=>e.age<e.duration);}
 function reset(){events=[];for(const k of Object.keys(history))delete history[k];serial=0;}
 function impact(c,e,p){
  const electric=e.element==='electric',fire=e.element==='fire',color=e.type==='enemyHit'?'#e79c79':electric?'#85e3f3':fire?'#f9b457':e.kind==='nikolas'?'#b7dc6b':'#ffd376',n=(e.damage>=40?18:13)*(1-p*.35),angle=(e.dir||1)*.13;
  c.rotate(angle);if(p<.7){poly(c,[[-n,-2],[-n*.4,-n*.3],[-n*.5,-n],[1,-n*.5],[n*.5,-n],[n*.4,-n*.2],[n,-1],[n*.45,n*.3],[n*.65,n*.8],[n*.1,n*.4],[-n*.15,n],[-n*.3,n*.35],[-n,n*.5],[-n*.5,1]],INK);poly(c,[[-n+4,-1],[-n*.25,-n*.15],[-n*.3,-n+4],[2,-n*.25],[n*.3,-n+5],[n*.2,-n*.1],[n-4,0],[n*.25,n*.2],[n*.3,n*.45],[0,n*.2],[-n*.08,n-4],[-n*.15,n*.15],[-n+5,n*.25]],color);rect(c,-3,-3,6,6,CREAM);}
  for(let i=0;i<5;i++){const side=i%2?-1:1,x=side*(9+p*(18+i*2)),y=(i-2)*(3+p*3)-p*8;rect(c,x,y,i%2?3:5,2,i%2?color:CREAM);}
  if(electric&&p<.68)pixelLine(c,[[-23,-8],[-15,-13],[-9,-4],[-2,-11],[7,0],[15,-7],[23,-3]],CREAM,2);
  if(fire&&p<.7)for(let i=0;i<3;i++)rect(c,(i-1)*8,-14-p*14-i%2*4,3,5,'#f7a33e');
 }
 function draw(c,time=0,layer='front'){
  for(const e of events){if(e.type==='gas'&&window.Golpes)continue; /* a nuvem do peidão é desenhada pelo golpes.js no tamanho exato da área */const back=e.type==='gas'||e.type==='surge'||e.type==='dash';if((layer==='back')!==back)continue;const p=clamp(e.age/e.duration,0,1);c.save();c.translate(Math.round(e.x),Math.round(e.y));c.globalAlpha*=p>.7?(1-p)/.3:1;
   if(e.type==='gas'){
    c.scale(e.dir,1);const reach=Math.min(185,Math.max(80,e.radius||120));for(let i=0;i<4;i++){const q=i/3,travel=10+p*reach*(.35+q*.65),yy=Math.sin(i*2.4)*11+p*(i%2?-9:5),size=(10+e.stage*2+q*7)*(1-p*.3);cloud(c,travel,yy,size,i%2?'#9ecb4b':'#bedc69','#e6ef9c');}for(let i=0;i<3;i++)rect(c,8+p*(38+i*14),-12+i*10,6,2,'#e3ef9a');
   }else if(e.type==='surge'){
    for(let i=0;i<5;i++){const xx=(i-2)*14,lift=Math.sin(p*Math.PI)*(30+i%2*16);poly(c,[[xx-6,22],[xx-5,-lift],[xx+1,-lift-13],[xx+6,-lift+3],[xx+4,22]],i%2?'#e8b83c':'#fff0a0');}for(let i=0;i<4;i++)rect(c,(i-1.5)*21,-15-p*(45+i%2*20),3,5,CREAM);
   }else if(e.type==='dash'){
    c.scale(e.dir,1);for(let i=0;i<3;i++){const xx=-i*13-p*(16+i*7);rect(c,xx,-2-i%2*4,9-i*2,3,'#d8cc9b');rect(c,xx+2,-5-i%2*4,4,2,CREAM);}
   }else if(e.type==='cast'){
    c.scale(e.dir,1);poly(c,[[0,-2],[12,-6],[8,-2],[19,0],[8,3],[11,7],[0,2]],e.element==='electric'?'#b5f4fb':e.element==='fire'?'#ffc66d':e.kind==='slime'?'#d0e78f':e.kind==='word'?'#e9bfd5':e.kind==='doodle'?'#dab6ef':e.kind==='smoke'?'#c3d0cc':CREAM);
   }else impact(c,e,p);
   c.restore();
  }
 }
 function drawProjectile(c,s,t=0){
  if(!s||s.delay>0||!['paper','ruler','case','reeis','papaia','enemyBullet','slime','inkBlade','smoke','bituca','astral','confetti','word'].includes(s.type))return false;
  c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(s.x),Math.round(s.y));const angle=Math.atan2(Number(s.vy)||0,Number(s.vx)||1),color=s.element==='electric'?'#a0ebf4':s.element==='fire'?'#f6b152':'#f5e2b2';
  if(['paper','ruler','case','reeis','papaia','enemyBullet'].includes(s.type)){
   c.rotate(angle);if(s.type!=='ruler'&&s.type!=='case'){rect(c,-21,-1,8,2,s.type==='enemyBullet'||s.type==='reeis'?'#dcb56c':color);rect(c,-31,3,5,1,s.type==='papaia'?'#f8d878':'#e3dcc1');}
   if(s.type==='paper'){c.rotate(Math.sin(t*17)*.18);poly(c,[[-8,-3],[-3,-7],[5,-6],[9,-1],[6,6],[-2,7],[-8,3]],INK);poly(c,[[-6,-2],[-2,-5],[4,-4],[7,0],[4,4],[-2,5],[-6,2]],'#fff2d2');pixelLine(c,[[-5,0],[0,-2],[3,2],[5,0]],'#c5b992',1);rect(c,-2,-4,3,2,'#ffffff');}
   else if(s.type==='ruler'){rect(c,-15,-5,30,10,INK);rect(c,-13,-4,26,7,'#e3af58');rect(c,-12,-4,25,2,'#ffe0a2');for(let i=0;i<7;i++)rect(c,-11+i*4,0,1,i%2?2:3,'#86683c');}
   else if(s.type==='case'){rect(c,-12,-6,24,12,INK);rect(c,-10,-4,20,8,'#63b5b4');rect(c,-9,-3,18,2,'#b0e5d2');rect(c,-8,1,16,1,'#327a85');rect(c,6,-1,3,4,'#f7d992');}
   else if(s.type==='papaia'){poly(c,[[-9,-4],[-3,-8],[6,-7],[11,-1],[8,5],[0,8],[-8,4]],INK);poly(c,[[-7,-3],[-2,-6],[5,-5],[8,-1],[6,3],[0,5],[-6,3]],color);rect(c,-3,-4,5,2,'#fff2b0');rect(c,5,-8,7,2,'#568d44');rect(c,8,-11,3,4,'#89bc4e');if(s.element==='electric'){pixelLine(c,[[-17,-7],[-10,-10],[-12,-4],[-7,-2]],'#e7ffff',2);pixelLine(c,[[0,11],[6,8],[4,13],[11,9]],'#e7ffff',2);}else{poly(c,[[-10,4],[-24,7],[-19,1],[-30,-1],[-16,-4]],'#f5a34e');rect(c,-21,-2,9,3,'#ffe09a');}}
   else{const gun=s.type==='reeis';rect(c,-8,-3,17,6,INK);rect(c,-7,-2,14,4,gun?'#ffe191':'#e9bd62');rect(c,4,-1,6,2,'#fff4bb');rect(c,-16,-1,7,2,gun?'#f9dc7e':'#edbb63');}
  }else if(s.type==='slime'){
   c.rotate(angle*.15);poly(c,[[-13,-4],[-8,-9],[4,-11],[12,-5],[15,3],[8,9],[-7,8],[-14,3]],'#416b39');poly(c,[[-11,-3],[-6,-7],[3,-8],[9,-4],[11,2],[6,6],[-6,5],[-11,2]],'#a9cf63');rect(c,-5,-6,7,3,'#e4f4a0');rect(c,8,6,4,3,'#86b44d');for(let i=0;i<2;i++)rect(c,-15-i*9,3+i*4,4-i,3,'#b2cf70');
  }else if(s.type==='inkBlade'){
   c.rotate(t*9);for(let i=0;i<4;i++){c.rotate(Math.PI/2);poly(c,[[-3,-1],[-7,-15],[0,-25],[6,-13],[3,1]],INK);poly(c,[[-1,-3],[-4,-14],[0,-21],[3,-12],[1,-1]],'#9d6ec7');rect(c,0,-19,2,11,'#e6c6f5');}rect(c,-4,-4,8,8,'#f6dfef');
  }else if(s.type==='smoke'){ // anel de fumaça do Dedé: um O que gira devagar, com rastro de fumaça atrás
   const base=c.globalAlpha,w=Math.sin(t*7+(s.variant||0))*1.5;c.rotate(angle);
   for(let i=1;i<=3;i++){c.globalAlpha=base*(.42-i*.11);cloud(c,-12-i*9,Math.sin(t*5+i)*3,7-i,'#8e9c9f','#c9d4d0');}
   c.globalAlpha=base*.9;for(let k=0;k<20;k++){const a=k/20*Math.PI*2,x=Math.cos(a)*(8+w*.4),y=Math.sin(a)*(13+w);rect(c,x-2,y-2,4,4,'#7f8c8f');}
   for(let k=0;k<20;k++){const a=k/20*Math.PI*2,x=Math.cos(a)*(7+w*.4),y=Math.sin(a)*(11+w);rect(c,x-1,y-1,3,3,a>Math.PI*.9&&a<Math.PI*1.8?'#eef3ec':'#c3cfcb');}
  }else if(s.type==='bituca'){ // bituca acesa girando, com brasa e fiapo de fumaça
   const base=c.globalAlpha;c.save();c.rotate(-angle);for(let i=1;i<=4;i++){c.globalAlpha=base*(.36-i*.07);rect(c,-(s.vx||0)*.018*i-2,-(s.vy||0)*.018*i-2-i*2,5-i*.6,5-i*.6,'#b9c3c0');}c.restore();
   c.globalAlpha=base;c.rotate((s.spin||0)+t*13);c.globalAlpha=base*(.25+.15*Math.sin(t*30));rect(c,5,-5,9,9,'#ff8a30');c.globalAlpha=base;
   rect(c,-9,-3,19,6,INK);rect(c,-8,-2,6,4,'#d9953f');rect(c,-7,-2,2,1,'#f2c27a');rect(c,-2,-2,9,4,'#f4f0e4');rect(c,-2,1,9,1,'#c9c3b4');rect(c,7,-2,2,4,'#ff6a24');rect(c,8,-1,1,2,'#ffe08a');
  }
  else if(s.type==='astral'){c.rotate(t*2);poly(c,[[0,-18],[5,-5],[17,0],[5,5],[0,18],[-5,5],[-17,0],[-5,-5]],'#386c9a');poly(c,[[0,-14],[3,-3],[13,0],[3,3],[0,14],[-3,3],[-13,0],[-3,-3]],'#9de5ec');rect(c,-3,-3,6,6,'#fff0ac');}
  else if(s.type==='confetti'){c.rotate(t*5);rect(c,-7,-6,14,12,INK);rect(c,-5,-4,10,8,'#e3a7cf');rect(c,-4,-4,4,2,'#ffe3b6');rect(c,3,1,3,2,'#c17cba');}
  else if(s.type==='word'){const value=String(s.text||'POUDI'),w=Math.min(220,value.length*7+18);poly(c,[[-w/2-2,-13],[w/2,-13],[w/2+5,8],[w/2-1,15],[-w/2,15],[-w/2-5,-7]],INK);rect(c,-w/2,-10,w,22,'#f0cfdb');rect(c,-w/2+2,10,w-4,3,'#a76795');c.font='bold 12px monospace';c.textAlign='center';c.textBaseline='middle';c.fillStyle=s.echo?'#315d79':'#623950';c.fillText(value,0,1);}
  c.restore();return true;
 }
 window.CampaignVfx=Object.freeze({version:1,emit,update,draw,drawProjectile,reset,getStatus:()=>({active:events.length,back:events.filter(e=>['gas','dash','surge'].includes(e.type)).length,front:events.filter(e=>!['gas','dash','surge'].includes(e.type)).length,maxActive:LIMIT,emitted:{...history}})});
})();
