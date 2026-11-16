/* Original pixel arena: visible props, impact poses and opaque, stepped effects. */
(() => {
 'use strict';
 const TAU=Math.PI*2,INK='#203c44',CREAM='#fff0be';
 const clamp=(n,a,b)=>Math.max(a,Math.min(b,Number(n)||0));
 const girls=new Set(['aica','ravile','eloisa','giselle','rayssa','analaura']);
 const skin={daroca:'#d9a171',reeis:'#825033',nikolas:'#e1b28a',marco:'#f0cdb8',menezes:'#b47d54',ollyan:'#f0c9b3',igor:'#e7a079',kaique:'#f0cbb4',freddy:'#805137',dede:'#b98b6c',arthur:'#f0cdb6',nicolas:'#f0cdb6',caleb:'#f0c9af',lucas:'#efc9b0',kaua:'#b88361',mota:'#f1ccb4',ravid:'#c9976e',almiro:'#b47b53',miqueias:'#f0cbb5',davi:'#dab18e',vitor:'#edc9ae',allef:'#805136',aica:'#d8ad89',ravile:'#b17d57',eloisa:'#d9af90',giselle:'#795035',rayssa:'#815338',analaura:'#f2ccb2'};
 const heightCache=new Map();
 function rect(c,x,y,w,h,color){c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
 function poly(c,points,color){c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(Math.round(p[0]),Math.round(p[1])):c.moveTo(Math.round(p[0]),Math.round(p[1])));c.closePath();c.fill();}
 function line(c,points,color,width=2){
  const size=Math.max(1,Math.round(width));c.fillStyle=color;
  for(let n=1;n<points.length;n++){let x=Math.round(points[n-1][0]),y=Math.round(points[n-1][1]);const ex=Math.round(points[n][0]),ey=Math.round(points[n][1]),dx=Math.abs(ex-x),dy=-Math.abs(ey-y),sx=x<ex?1:-1,sy=y<ey?1:-1;let err=dx+dy;
   for(let guard=0;guard<4000;guard++){c.fillRect(x-Math.floor(size/2),y-Math.floor(size/2),size,size);if(x===ex&&y===ey)break;const e=2*err;if(e>=dy){err+=dy;x+=sx;}if(e<=dx){err+=dx;y+=sy;}}
  }
 }
 function pixelOval(c,x,y,rx,ry,color){
  rx=Math.max(1,Number(rx)||1);ry=Math.max(1,Number(ry)||1);const step=3;
  for(let yy=-ry;yy<ry;yy+=step){const mid=Math.max(-1,Math.min(1,(yy+step*.5)/ry)),span=Math.max(step,Math.round(rx*Math.sqrt(Math.max(0,1-mid*mid))/step)*step);rect(c,x-span,y+yy,span*2,Math.min(step,ry-yy),color);}
 }
 function puff(c,x,y,size,color,accent='#ffffff'){const n=Math.max(2,Math.round(size/4));rect(c,x-n*3,y-n,n*6,n*3,INK);rect(c,x-n*2,y-n*2,n*4,n*5,INK);rect(c,x-n*3+2,y-n+2,n*6-4,n*3-4,color);rect(c,x-n*2+2,y-n*2+2,n*4-4,n*5-4,color);rect(c,x-n,y-n*2+4,n*2,n,accent);}
 function impact(c,x,y,size,color=CREAM,progress=.5){c.save();c.translate(Math.round(x),Math.round(y));const n=Math.max(8,Math.round(size));poly(c,[[-n,-3],[-n*.35,-n*.3],[-n*.55,-n],[-2,-n*.55],[n*.4,-n],[n*.35,-n*.3],[n,-n*.2],[n*.5,2],[n*.8,n*.7],[n*.2,n*.35],[-n*.1,n],[-n*.3,n*.35],[-n,n*.5],[-n*.5,n*.1]],INK);poly(c,[[-n+4,-1],[-n*.2,-n*.15],[-n*.4,-n+4],[0,-n*.35],[n*.25,-n+5],[n*.2,-n*.15],[n-5,-n*.1],[n*.28,2],[n*.48,n*.45],[n*.12,n*.2],[-n*.08,n-5],[-n*.18,n*.15],[-n+5,n*.27],[-n*.3,0]],color);rect(c,-4,-4,8,8,'#ffffff');for(let i=0;i<3;i++){const d=7+progress*18;rect(c,n+d+i*4,-n+7+i*8,4,4,i%2?color:'#ffe45a');}c.restore();}
 function smear(c,x,y,angle,progress,color,width=12){c.save();c.translate(Math.round(x),Math.round(y));c.rotate(angle);const travel=Math.round(Math.sin(clamp(progress,0,1)*Math.PI)*28),length=18+travel;poly(c,[[-length,-width*.45],[-length+9,-width*.45],[-length+9,-width*.8],[-6,-width*.8],[-6,-width],[11,-width],[17,-4],[23,-4],[23,4],[14,4],[14,width],[-7,width],[-7,width*.7],[-length,width*.4]],color);rect(c,-length+12,-3,length-3,6,'#fff7d2');for(let i=0;i<3;i++)rect(c,-length-8-i*9,-width+3+(i%2)*9,6,4,color);c.restore();}
 function crack(c,x,y,progress,color='#e9a24c'){const spread=20+progress*55;line(c,[[x-spread,y+4],[x-spread*.65,y-1],[x-spread*.45,y+6],[x-4,y-2],[x+11,y+8],[x+spread*.45,y+1],[x+spread*.6,y+6],[x+spread,y+1]],INK,5);for(let i=0;i<7;i++){const xx=x+(i-3)*(8+progress*6),yy=y-6-Math.sin(progress*Math.PI)*(9+(i%3)*6);rect(c,xx-4,yy,9,6,'#67412e');rect(c,xx-3,yy,7,3,color);}}

 
 function label(c,value,x,y,size=11,color=CREAM,align='center'){c.font='bold '+size+'px monospace';c.textAlign=align;c.textBaseline='middle';c.fillStyle=INK;c.fillText(value,Math.round(x)+1,Math.round(y)+2);c.fillStyle=color;c.fillText(value,Math.round(x),Math.round(y));}
 function kit(id){return window.ArenaRoster?.get?.(id)||{color:'#e9c27c',name:id};}
 function bodyHeight(type){
  if(heightCache.has(type))return heightCache.get(type);
  let height={igor:90,kaique:111,giant:190,ollyan:110,lucas:54}[type]||70;
  try{const canvas=document.createElement('canvas');canvas.width=380;canvas.height=360;const c=canvas.getContext('2d',{willReadFrequently:true});window.Art?.drawCharacter?.(c,type,190,320,{frame:0,facing:1,grounded:true,monitorBattle:true,noseRub:false,scale:1});const data=c.getImageData(0,0,380,321).data;let first=320;for(let y=0;y<320;y++){let found=false;for(let x=0;x<380;x++){if(data[(y*380+x)*4+3]>220){first=y;found=true;break;}}if(found)break;}if(first<320)height=320-first;}catch{}
  heightCache.set(type,Math.max(36,height));return Math.max(36,height);
 }
 function cloud(c,x,y,s=1,color='#ffffff'){
  c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);for(const [xx,yy,w,h]of[[-43,9,112,12],[-29,-3,83,18],[-9,-15,42,24],[-50,15,127,8]])rect(c,xx,yy,w,h,color);c.restore();
 }
 function mountain(c,x,y,s,color){poly(c,[[x-190*s,y],[x-143*s,y-57*s],[x-76*s,y-85*s],[x-8*s,y-155*s],[x+47*s,y-99*s],[x+88*s,y-78*s],[x+171*s,y]],color);}
 function windmill(c,x,y,t,s=1){c.save();c.translate(x,y);c.scale(s,s);poly(c,[[-23,0],[-17,-76],[18,-76],[24,0]],'#fff0c5');rect(c,-16,-76,32,7,'#187ed1');poly(c,[[-24,-77],[0,-100],[25,-77]],'#d63e33');rect(c,-7,-34,15,34,'#456e72');rect(c,-10,-59,20,12,'#6fa2ae');rect(c,-6,-56,4,8,'#d0e5cd');c.save();c.translate(0,-76);c.rotate(t*.45);for(let i=0;i<4;i++){c.rotate(Math.PI/2);rect(c,7,-5,52,11,'#704f37');rect(c,19,-10,40,20,'#ffd04e');for(let j=0;j<5;j++)rect(c,22+j*8,-10,2,20,'#b4782e');rect(c,19,-1,40,2,'#fff38a');}c.restore();pixelOval(c,0,-76,6,6,'#2c4f80');rect(c,-2,-78,4,4,'#fff2a2');c.restore();}
 function village(c,x,y,t,s=1){c.save();c.translate(x,y);c.scale(s,s);for(let i=0;i<5;i++){const xx=i*69,yy=(i%2)*11;rect(c,xx,yy-68,59,70,['#fff0d0','#ffdb73','#ffd8c9'][i%3]);poly(c,[[xx-6,yy-68],[xx+27,yy-91],[xx+65,yy-68]],i%2?'#e94b3d':'#256cd8');rect(c,xx+8,yy-55,14,24,'#278edb');rect(c,xx+35,yy-56,14,24,'#278edb');rect(c,xx+25,yy-25,17,27,'#95542e');rect(c,xx+8,yy-52,3,18,'#e9fbff');}line(c,[[0,-98],[290,-98]],'#8e5b35',2);for(let i=0;i<12;i++){const xx=i*25;poly(c,[[xx,-98],[xx+13,-98],[xx+8,-81+Math.sin(t*2+i)*2]],['#ffce32','#f0443d','#2789ed','#fff2bd'][i%4]);}c.restore();}
 // Static artwork is painted once per viewport/platform size, then reused. Both
 // caches are bounded: rotating a phone cannot accumulate full-size canvases.
 const sceneryCache=new Map(),platformCache=new Map();
 function cachedCanvas(cache,key,w,h,paint,limit=3){
  let canvas=cache.get(key);if(canvas){cache.delete(key);cache.set(key,canvas);return canvas;}
  canvas=document.createElement('canvas');canvas.width=Math.ceil(w);canvas.height=Math.ceil(h);const g=canvas.getContext('2d');g.imageSmoothingEnabled=false;paint(g);cache.set(key,canvas);while(cache.size>limit)cache.delete(cache.keys().next().value);return canvas;
 }
 function tree(c,x,y,s=1,kind=0){
  c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);
  rect(c,-7,-57,13,59,'#85522d');rect(c,-5,-56,4,55,'#b6783e');line(c,[[0,-25],[-18,-57]],'#85522d',6);line(c,[[2,-37],[20,-62]],'#85522d',5);
  for(const [xx,yy,ww,hh] of [[-35,-89,62,24],[-43,-73,84,25],[-30,-54,62,20],[-19,-98,40,17]])rect(c,xx,yy,ww,hh,'#247f46');
  for(const [xx,yy,ww,hh] of [[-30,-85,51,20],[-36,-70,64,21],[-18,-94,35,19],[-21,-52,35,12]])rect(c,xx,yy,ww,hh,kind?'#63bc3b':'#45ab44');
  for(let i=0;i<9;i++){const xx=-30+(i*17)%62,yy=-86+(i*13)%41;rect(c,xx,yy,7,3,i%2?'#86d343':'#75cc56');if(kind&&i%2===0){rect(c,xx+2,yy+5,5,6,'#fa8b32');rect(c,xx+3,yy+5,2,2,'#ffd55a');}}
  rect(c,-17,-1,35,3,'#519c39');c.restore();
 }
 function fence(c,x,y,w,s=1){
  c.save();c.translate(x,y);c.scale(s,s);rect(c,0,-19,w,5,'#e7bf75');rect(c,0,-7,w,4,'#b8884c');rect(c,0,-20,w,2,'#fff0ad');for(let xx=0;xx<=w;xx+=35){rect(c,xx-3,-27,7,33,'#805936');rect(c,xx-2,-27,4,31,'#efcd89');rect(c,xx-2,-27,4,3,'#fff2ba');rect(c,xx,-17,2,2,'#7b5734');}c.restore();
 }
 function barn(c,x,y,s=1){
  c.save();c.translate(x,y);c.scale(s,s);rect(c,0,-83,133,83,'#a32d37');rect(c,6,-79,121,77,'#d94a3f');for(let i=0;i<11;i++)rect(c,8+i*11,-78,2,75,'#b43735');
  poly(c,[[-12,-81],[58,-122],[74,-122],[145,-81]],'#694644');poly(c,[[-10,-86],[64,-127],[144,-86],[137,-78],[65,-116],[-5,-78]],'#ef6b45');for(let i=0;i<6;i++)line(c,[[9+i*10,-95-i*5],[68+i*10,-95+i*5]],'#b24238',2);
  rect(c,45,-56,45,56,'#f2d5a0');rect(c,49,-53,37,53,'#6e4932');rect(c,52,-51,31,51,'#9d5c35');line(c,[[52,-49],[82,-2],[52,-2],[82,-49]],'#e6c48f',4);rect(c,66,-49,3,48,'#f5d8a5');rect(c,66,-101,16,18,'#e7c68e');rect(c,69,-98,10,12,'#365d72');rect(c,73,-98,2,12,'#b6e8ee');rect(c,69,-93,10,2,'#b6e8ee');
  for(const xx of [12,104]){rect(c,xx,-57,17,25,'#f2cf95');rect(c,xx+3,-54,11,19,'#417f93');rect(c,xx+7,-54,2,19,'#c1eff2');rect(c,xx+3,-46,11,2,'#c1eff2');}
  rect(c,-7,-1,147,5,'#8a683b');c.restore();
 }
 function paintScenery(c,W,H){
  const sky=c.createLinearGradient(0,0,0,H);sky.addColorStop(0,'#238fe5');sky.addColorStop(.54,'#91d9ff');sky.addColorStop(1,'#e4f5f1');c.fillStyle=sky;c.fillRect(0,0,W,H);
  const sx=W*.76,sy=H*.17;rect(c,sx-19,sy-27,38,54,'#ffcf36');rect(c,sx-27,sy-19,54,38,'#ffcf36');rect(c,sx-23,sy-23,46,46,'#fff185');rect(c,sx-12,sy-20,24,4,'#fff8bd');
  // Layered ridgelines and their small facets give depth without a green wash.
  for(let i=-1;i<8;i++){const xx=i*216,yy=H*.68;mountain(c,xx,yy,.95,i%2?'#6ca7ce':'#77b5d8');poly(c,[[xx-82,yy-74],[xx-8,yy-147],[xx+37,yy-95],[xx+20,yy-93],[xx-4,yy-122],[xx-36,yy-77]],'#99c9e3');poly(c,[[xx-8,yy-147],[xx+37,yy-95],[xx+86,yy-75],[xx+40,yy-76]],'#6198c4');}
  poly(c,[[0,H*.75],[W*.12,H*.61],[W*.27,H*.69],[W*.43,H*.58],[W*.6,H*.7],[W*.81,H*.58],[W,H*.71],[W,H],[0,H]],'#4caa49');
  poly(c,[[0,H*.84],[W*.18,H*.72],[W*.34,H*.81],[W*.55,H*.7],[W*.74,H*.79],[W,H*.69],[W,H],[0,H]],'#80c94c');
  for(let i=0;i<62;i++){const xx=(i*197+83)%W,yy=H*.7+(i*37)%(H*.26);rect(c,xx,yy,15+(i%4)*7,2,i%3?'#6cb84a':'#a1da61');}
  // Orchard, fenced paddocks, a barn and tiny terraces occupy the distant valley.
  for(let i=0;i<13;i++)tree(c,40+i*(W-80)/12,H*.77+(i%3)*7,.28+(i%3)*.035,i%3===0);
  poly(c,[[W*.43,H*.77],[W*.48,H*.77],[W*.58,H],[W*.37,H]],'#c9df8b');poly(c,[[W*.442,H*.77],[W*.477,H*.77],[W*.55,H],[W*.39,H]],'#27b1dc');
  for(let i=0;i<7;i++)rect(c,W*.438+i*2,H*.8+i*H*.03,24+i*6,2,'#99e7ef');
  const bx=W*.12,by=H*.91;poly(c,[[bx-68,by],[bx+102,by],[bx+180,H],[bx-120,H]],'#d7b571');for(let i=0;i<4;i++)line(c,[[bx-58+i*37,by+3],[bx-111+i*71,H]],'#ad864a',3);barn(c,bx,by,.69);
  fence(c,W*.015,H*.92,W*.23,.76);fence(c,W*.64,H*.91,W*.29,.68);
  for(let i=0;i<6;i++){const xx=W*.04+i*26,yy=H*.97+(i%2)*5;rect(c,xx,yy-15,23,17,'#d8a23d');rect(c,xx+2,yy-15,19,3,'#f7d06c');rect(c,xx+5,yy-12,2,12,'#b78230');rect(c,xx+16,yy-12,2,12,'#b78230');}
  // A small village on the right. Buildings are cached, bunting moves separately.
  for(let i=0;i<5;i++){const xx=W*.66+i*58,yy=H*.92+(i%2)*10;rect(c,xx,yy-44,49,45,i%2?'#fff0cc':'#eee8cf');rect(c,xx+1,yy-7,47,8,'#c5b48a');poly(c,[[xx-5,yy-44],[xx+24,yy-64],[xx+54,yy-44]],i%2?'#c14439':'#2c69a0');rect(c,xx+8,yy-34,11,15,'#3d8ab1');rect(c,xx+32,yy-34,10,15,'#3d8ab1');rect(c,xx+22,yy-21,12,22,'#91613c');rect(c,xx+8,yy-33,3,11,'#c0e9ed');rect(c,xx+32,yy-33,3,11,'#c0e9ed');rect(c,xx+4,yy-3,42,2,'#d9cf9f');}
  const fx=W*.86,fy=H*.98;for(let row=0;row<4;row++){line(c,[[fx-110,fy+row*11],[fx+130,fy+row*11]],'#9e743e',3);for(let i=0;i<12;i++){const xx=fx-105+i*21,yy=fy+row*11;rect(c,xx,yy-7,3,8,'#347f3f');rect(c,xx-3,yy-5,8,3,'#5caf41');}}
  for(const [xx,yy,sz]of [[W*.015,H*1.04,.9],[W*.965,H*1.03,.92],[W*.59,H*1.05,.49]])tree(c,xx,yy,sz,1);
  // Narrow timber footbridge across the stream.
  const mx=W*.457,my=H*.87;poly(c,[[mx-31,my],[mx+45,my-4],[mx+54,my+7],[mx-37,my+12]],'#98613b');for(let i=0;i<10;i++)line(c,[[mx-29+i*8,my],[mx-32+i*9,my+9]],'#e0b46a',3);line(c,[[mx-32,my-12],[mx+44,my-16]],'#f0d69a',3);for(const dx of [-32,5,44])rect(c,mx+dx,my-15,3,27,'#a57b43');
 }
 function drawBackground(c,camera={},time=0,W=960,H=540){
  W=Math.max(1,Math.round(W));H=Math.max(1,Math.round(H));const x=Number(camera.x)||640,y=Number(camera.y)||340,t=Number(time)||0,over=256,shift=over/2+clamp((x-640)*.045,-85,85),sy=clamp((y-340)*.016,-8,8);
  const bg=cachedCanvas(sceneryCache,W+':'+H,W+over,H+18,g=>paintScenery(g,W+over,H+18),2);c.save();c.imageSmoothingEnabled=false;c.drawImage(bg,Math.round(shift),9+Math.round(sy),W,H,0,0,W,H);
  for(let i=0;i<6;i++){const xx=((i*241+t*(i%2?2.1:3.2)-x*.065)%(W+240)+W+240)%(W+240)-120;cloud(c,xx,35+(i%4)*36-y*.017,.52+(i%3)*.14,i%2?'#e0f5ff':'#ffffff');}
  windmill(c,W*.2-(x-640)*.025,H*.88-(y-340)*.012,t,.63);
  const bx=W*.69-(x-640)*.035,by=H*.88;line(c,[[bx-15,by-52],[bx+195,by-52]],'#7a6848',1);for(let i=0;i<9;i++){const xx=bx+i*23;poly(c,[[xx,by-52],[xx+12,by-52],[xx+7,by-39+Math.sin(t*2.4+i)*2]],['#ed5c41','#ffd24b','#348fd0','#fff2c5'][i%4]);}
  for(let i=0;i<4;i++){const xx=W*.38+Math.sin(i*1.9)*23,yy=H*.87+i*18+(t*7)%14;rect(c,xx,yy,21+i*6,2,'#c2f5f6');}
  for(let i=0;i<4;i++){const bx=((i*233+t*10-x*.11)%(W+120)+W+120)%(W+120)-60,by=77+(i%3)*38+Math.sin(t*.7+i)*4,wing=Math.round(Math.sin(t*4+i)*3);line(c,[[bx-5,by+wing],[bx,by],[bx+5,by+wing]],'#3679a2',2);}
  c.restore();
 }
 function grass(c,x,y,t,seed=0){for(let i=0;i<4;i++){const px=x+i*8,sway=Math.round(Math.sin(t*2+seed+i)*1.4);line(c,[[px,y],[px+sway-2,y-5-i%2*3]],i%2?'#298d3c':'#81d94b',2);}}
 function paintPlatform(c,w,main){
  const y=8; // Drawing coordinates include a small transparent top margin.
  if(main){
   poly(c,[[5,y+8],[w-5,y+8],[w-31,y+42],[w*.85,y+58],[w*.75,y+99],[w*.61,y+86],[w*.49,y+124],[w*.35,y+92],[w*.25,y+109],[w*.12,y+64],[28,y+42]],'#4b423b');
   poly(c,[[8,y+10],[w-9,y+10],[w-37,y+35],[w*.83,y+50],[w*.74,y+82],[w*.61,y+69],[w*.48,y+105],[w*.35,y+75],[w*.25,y+90],[w*.14,y+52],[31,y+34]],'#a56f45');
   for(let i=0;i<Math.floor(w/23);i++){const xx=15+i*23,yy=y+16+(i*17)%39;rect(c,xx,yy,14+i%3*4,5,['#c98a4b','#77523a','#d8a368'][i%3]);rect(c,xx+2,yy+5,9,2,'#866044');}
   for(let i=0;i<8;i++){const xx=35+i*(w-70)/7;poly(c,[[xx,y+13],[xx+24,y+15],[xx+33,y+38],[xx+10,y+49],[xx-5,y+31]],i%2?'#7d7970':'#989282');rect(c,xx+2,y+17,15,4,'#b0aa96');rect(c,xx+8,y+36,13,3,'#5e645d');}
   for(let i=0;i<8;i++){const xx=65+i*(w-130)/7;line(c,[[xx,y+25],[xx-5,y+58],[xx+9,y+77]],'#725035',5);line(c,[[xx-4,y+52],[xx-17,y+61]],'#725035',3);}
   // Board-and-rope plaque is below the surface, leaving all fighting space clear.
   const cx=w/2;line(c,[[cx-62,y+13],[cx-62,y+35],[cx+62,y+35],[cx+62,y+13]],'#59432e',2);rect(c,cx-74,y+30,148,26,'#5b3d2b');rect(c,cx-71,y+33,142,20,'#b47a40');rect(c,cx-69,y+34,138,2,'#efbf6a');for(let i=0;i<3;i++)rect(c,cx-66+i*59,y+48,41,1,'#8b5b33');label(c,'TERREIRO DA RESENHA',cx,y+44,9,'#ffedbd');
  }else{
   poly(c,[[0,y+5],[w,y+5],[w-15,y+23],[w*.7,y+30],[w*.55,y+45],[w*.37,y+33],[14,y+25]],'#55433a');poly(c,[[5,y+8],[w-7,y+8],[w-20,y+19],[w*.67,y+23],[w*.54,y+34],[w*.36,y+24],[17,y+19]],'#a97647');
   // A shaped timber lip, end grain, nails and stone pockets, rather than a slab.
   rect(c,0,y+3,w,10,'#765237');rect(c,4,y+4,w-8,3,'#e0ac61');rect(c,8,y+9,w-16,2,'#b37c42');for(let i=0;i<Math.floor(w/30);i++){const xx=12+i*30;rect(c,xx,y+5,2,6,'#6b4e35');rect(c,xx+13,y+6,2,2,'#354443');}
   for(const xx of [16,w-36]){poly(c,[[xx,y+16],[xx+16,y+13],[xx+25,y+23],[xx+12,y+31]],'#8a8c7a');rect(c,xx+5,y+17,10,3,'#c2bea0');}
  }
  rect(c,main?3:0,y,main?w-6:w,7,'#257b38');rect(c,main?4:1,y-2,main?w-8:w-2,5,'#70ca43');rect(c,main?7:3,y-3,main?w-14:w-6,2,'#c0ee78');
  for(let i=0;i<Math.floor(w/16);i++){const xx=7+i*16;rect(c,xx,y+1,7,2,i%3?'#8fda4d':'#44a13b');if(i%4===0)rect(c,xx,y+5,5,3,'#419038');}
 }
 function drawStage(c,platforms=[],time=0){
  const t=Number(time)||0;c.save();c.imageSmoothingEnabled=false;
  for(const p of platforms){const x=Number(p.x)||0,y=Number(p.y)||0,w=Math.round(Number(p.w)||100),main=!!p.main,key=(main?'m:':'p:')+w;const image=cachedCanvas(platformCache,key,w+2,main?148:67,g=>paintPlatform(g,w,main),8);c.drawImage(image,Math.round(x),Math.round(y)-8);
   if(main){for(const side of [-1,1]){const xx=side<0?x+36:x+w-44;rect(c,xx,y+33,9,108,'#228fce');rect(c,xx+2,y+33,4,108,'#6dd7f2');for(let j=0;j<4;j++)rect(c,xx+2,y+35+(t*61+j*29)%104,3,8,'#dbffff');}
    for(let i=0;i<5;i++){const xx=x+72+i*(w-144)/4;line(c,[[xx,y+32],[xx-4,y+56],[xx+Math.sin(t*1.5+i),y+76]],'#36733c',2);rect(c,xx-6,y+45,7,4,'#62ab43');rect(c,xx-1,y+64,7,4,'#8bc751');}
   }
   grass(c,x+11,y-3,t,x);if(w>160)grass(c,x+w-42,y-3,t,x+w);
   for(const [i,xx] of [x+26,x+w-28].entries()){if(!main&&i===0)continue;const sway=Math.round(Math.sin(t*2+i)*1);rect(c,xx+sway,y-11,2,9,'#3e873b');rect(c,xx+sway-2,y-15,6,5,i?'#ffcf3f':'#f7694c');rect(c,xx+sway,y-14,2,2,'#fff4b6');}
  }c.restore();
 }
 function glove(c,x,y,color,rotation=0){c.save();c.translate(x,y);c.rotate(rotation);rect(c,-6,-8,18,16,INK);rect(c,-4,-6,14,12,color);rect(c,-3,-6,4,3,'#ffe4be');rect(c,-10,1,7,6,color);rect(c,9,-5,2,8,'#b67c62');c.restore();}
 function weight(c,x,y,r=0,s=1,color='#8eabc0'){c.save();c.translate(x,y);c.rotate(r);c.scale(s,s);rect(c,-18,-3,36,6,'#d0d9cd');for(const xx of [-21,13]){rect(c,xx,-11,8,22,INK);rect(c,xx+2,-9,4,18,color);rect(c,xx-4,-7,5,14,'#587487');}rect(c,-3,-2,6,2,'#f1eedb');c.restore();}
 function heel(c,x,y,r=0,s=1,color='#e196af'){c.save();c.translate(x,y);c.rotate(r);c.scale(s,s);poly(c,[[-14,-5],[-6,-5],[-2,1],[12,3],[15,8],[-11,8],[-14,4]],INK);poly(c,[[-12,-3],[-7,-3],[-3,3],[11,5],[12,6],[-10,6]],color);rect(c,-13,5,4,13,INK);rect(c,-11,8,2,9,color);rect(c,-9,-2,4,3,'#ffe6d3');c.restore();}
 function ball(c,x,y,r=0,s=1){c.save();c.translate(x,y);c.rotate(r);c.scale(s,s);rect(c,-9,-6,18,12,'#f7efcf');rect(c,-6,-9,12,18,'#f7efcf');poly(c,[[-3,-4],[3,-4],[5,1],[0,5],[-5,1]],'#283e4a');rect(c,-9,-3,4,6,'#283e4a');rect(c,5,-4,4,5,'#283e4a');rect(c,-3,6,5,3,'#283e4a');c.restore();}
 function claw(c,x,y,t,color='#e8ebd8'){for(let i=0;i<3;i++)line(c,[[x-12+i*8,y+15],[x-4+i*8,y],[x+1+i*8,y-13]],color,3);}
 const trouser={daroca:'#526251',reeis:'#294b68',nikolas:'#353a55',marco:'#252e34',menezes:'#3b5059',ollyan:'#384454',igor:'#216da6',kaique:'#243b53',freddy:'#293c50',dede:'#3a434d',arthur:'#2c435c',nicolas:'#34455d',caleb:'#344854',lucas:'#263f5b',kaua:'#455264',mota:'#23426a',ravid:'#40584a',almiro:'#263e5a',miqueias:'#4d5149',davi:'#30343c',vitor:'#414c53',allef:'#34424d'};
 const gait={igor:7.7,lucas:13.3,kaique:10.4,freddy:12.1,mota:11.8,caleb:9.2,menezes:12.8,ollyan:10.8};
 const smooth=(a,b,v)=>{const n=clamp((v-a)/(b-a),0,1);return n*n*(3-2*n);};
 function legProfile(id){
  if(id==='igor')return{hipY:-13,upper:5.5,lower:7.5,spread:7,width:7};
  if(id==='lucas')return{hipY:-20,upper:9,lower:10,spread:4,width:6};
  if(id==='kaique')return{hipY:-28,upper:13,lower:14,spread:4,width:5};
  if(girls.has(id))return{hipY:-24,upper:11,lower:12,spread:5,width:6};
  return{hipY:-24,upper:11,lower:12,spread:id==='caleb'?6:5,width:id==='caleb'?7:6};
 }
 function solveLeg(hip,target,upper,lower,bend=1){
  const dx=target[0]-hip[0],dy=target[1]-hip[1],raw=Math.hypot(dx,dy),d=clamp(raw,Math.abs(upper-lower)+.01,upper+lower-.015),ux=raw>.0001?dx/raw:0,uy=raw>.0001?dy/raw:1,a=(upper*upper-lower*lower+d*d)/(2*d),offset=Math.sqrt(Math.max(0,upper*upper-a*a));
  return{hip:[hip[0],hip[1]],knee:[hip[0]+ux*a-uy*offset*bend,hip[1]+uy*a+ux*offset*bend],foot:[hip[0]+ux*d,hip[1]+uy*d]};
 }
 // All leg poses, including attacks, share two rigid segments. No frame scales a
 // calf or extends a foot past the character's anatomical reach.
 function legPose(id,motion='idle',time=0,direction='side',progress=0,combo=false,kinematics={}){
  const pr=legProfile(id),phase=(Number(time)||0)*(gait[id]||10.7),L=pr.upper+pr.lower,hips=[[-pr.spread,pr.hipY],[pr.spread,pr.hipY]],feet=[[-pr.spread-2,-1.5],[pr.spread+2,-1.5]],bends=[-1,1],strike=smooth(.16,.44,progress)*(1-smooth(.61,1,progress));
  const mt=Math.max(0,Number(kinematics.motionTime??kinematics.mt??time)||0),vy=Number(kinematics.vy)||0,wall=Number(kinematics.wall)||1,bodyX=Number(kinematics.dx)||0,bodyY=Number(kinematics.dy)||0;
  for(let i=0;i<2;i++){
   const side=i?1:-1,wave=Math.sin(phase+(i?Math.PI:0)),lift=Math.max(0,Math.cos(phase+(i?Math.PI:0)));
   if(motion==='run'){feet[i]=[hips[i][0]+wave*L*.78,-1.5-lift*L*.5];bends[i]=wave>0?-1:1;}
   else if(motion==='jump'){
    const launch=1-smooth(.02,.14,mt),rise=clamp((-vy-50)/370,0,1),apex=1-clamp(Math.abs(vy)/100,0,1),second=kinematics.jumps===2;
    feet[i]=[hips[i][0]+(i?L*.46:-L*.44)*(1-launch*.3),i?-2-L*(.28+rise*.45+apex*.12):-.5-L*(.1+rise*.2)];
    if(launch&&!second){feet[i][0]=hips[i][0]+side*L*.2;feet[i][1]+=(i?8:3)*launch;}
    bends[i]=i?-1:1;
   }
   else if(motion==='doubleJump'){const tuck=Math.sin(clamp(mt/.26,0,1)*Math.PI);feet[i]=[hips[i][0]+side*L*(.27+tuck*.33),-L*(.38+tuck*.63)+(i?-3:1)];bends[i]=i?-1:1;}
   else if(motion==='fall'){const extend=smooth(30,500,vy);feet[i]=[hips[i][0]+side*L*(.26-.08*extend),-L*(i?.27*(1-extend)+.025:.15*(1-extend)+.015)];bends[i]=i?1:-1;}
   else if(motion==='dash'){feet[i]=[hips[i][0]+(i?L*.51:-L*.85),i?-L*.61:-L*.13];bends[i]=i?-1:1;}
   else if(motion==='wallSlide'){feet[i]=[wall*L*(i?.91:.61),-L*(i?.16:.52)];bends[i]=i?-wall:wall;}
   else if(motion==='wallJump'){const push=1-smooth(.02,.23,mt);feet[i]=[hips[i][0]+(i?L*(.35+push*.42):-L*.4),-L*(i?.23:.54)];bends[i]=i?-1:1;}
   else if(motion==='land'){const squat=1-smooth(.01,.13,mt);feet[i]=[hips[i][0]+side*L*(.1+squat*.37),-1.5];bends[i]=side;}
   hips[i][0]+=bodyX;hips[i][1]+=bodyY;
   if(!['run','land','idle'].includes(motion)){feet[i][0]+=bodyX;feet[i][1]+=bodyY;}
  }
  // The planted knee yields a little during a kick instead of locking straight.
  // Both bones keep the same length through windup, contact and recovery.
  if(progress>0&&girls.has(id)){hips[0][1]+=strike*1.2;feet[0][0]-=strike*1.6;}
  const legs=hips.map((h,i)=>solveLeg(h,feet[i],pr.upper,pr.lower,bends[i]));
  if(progress>0&&strike>0){
   const h=hips[1];let target;
   if(combo&&direction!=='down'){
    // A bent knee lifts within one thigh length of the hip; the shin folds back.
    const thighAngle=Math.PI/2-strike*(direction==='up'?2.8:direction==='neutral'?1.95:2.45),knee=[h[0]+Math.cos(thighAngle)*pr.upper,h[1]+Math.sin(thighAngle)*pr.upper],shinAngle=Math.PI/2+strike*.75;
    legs[1]={hip:h,knee,foot:[knee[0]+Math.cos(shinAngle)*pr.lower,knee[1]+Math.sin(shinAngle)*pr.lower]};
   }else{
    const idle=[pr.spread+2,-1.5];target=direction==='up'?[h[0]+L*.4,h[1]-L*.91]:direction==='down'?[h[0]+L*.68,h[1]+L*.71]:direction==='neutral'?[h[0]+L*.78,h[1]-L*.35]:[h[0]+L*.98,h[1]-L*.12];
    target=[idle[0]+(target[0]-idle[0])*strike,idle[1]+(target[1]-idle[1])*strike];legs[1]=solveLeg(h,target,pr.upper,pr.lower,-1);
   }
  }
  return{hipY:pr.hipY,upper:pr.upper,lower:pr.lower,width:pr.width,legs};
 }
 function drawLegs(c,id,pose,kicking,color){
  const colorPants=trouser[id]||'#2b4662';
  for(const [i,l] of pose.legs.entries()){
   line(c,[l.hip,l.knee,l.foot],INK,pose.width+3);line(c,[l.hip,l.knee,l.foot],colorPants,pose.width);
   line(c,[[l.hip[0]-1,l.hip[1]+2],[l.knee[0]-1,l.knee[1]]],i?'#5e7482':'#526775',2);
   if(girls.has(id)&&kicking&&i===1){const angle=Math.atan2(l.foot[1]-l.knee[1],l.foot[0]-l.knee[0])-Math.PI/2;heel(c,l.foot[0]+1,l.foot[1]-3,angle*.28,.43,color);}
   else{rect(c,l.foot[0]-4,l.foot[1]-2,11,4,id==='daroca'?'#b48b50':id==='almiro'?'#9ef13d':id==='marco'||id==='dede'?'#748078':'#e3e4ce');rect(c,l.foot[0]-4,l.foot[1]+1,12,2,'#516b69');rect(c,l.foot[0]-2,l.foot[1]-2,5,1,'#fff4d4');}
  }
 }
 // Neutral head/clothes are retained as pixel cut-outs; the two arms and two
 // legs are articulated independently so movement never inherits a frozen pose.
 const sleeveColors={daroca:'#dc8c47',reeis:'#4d7374',nikolas:'#8c6594',marco:'#222b30',menezes:'#647c84',ollyan:'#252a36',igor:'#287eb8',kaique:'#edf0dd',freddy:'#34424a',dede:'#516563',arthur:'#6d99a0',nicolas:'#e7e1c9',caleb:'#f0c9af',lucas:'#9a9e9e',kaua:'#66888a',mota:'#1b4677',ravid:'#7c93a1',almiro:'#367cba',miqueias:'#617b70',davi:'#252c31',vitor:'#a9afb1',allef:'#3b5260',aica:'#e5e7d6',ravile:'#8fafbf',eloisa:'#f1f0df',giselle:'#f1f0df',rayssa:'#f1f0df',analaura:'#f1f0df'};
 const longSleeves=new Set(['marco','ollyan','dede','davi','vitor']);
 const motionBodyCache=new Map();
 function rigProfile(id){
  const h=id==='lucas'?60:70,s=h/bodyHeight(id),small=id==='lucas',sx=s*(small?.84:1),sy=s*(small?.78:1),social=girls.has(id)||['allef','arthur','dede','davi','vitor','freddy','nicolas'].includes(id),wide=id==='caleb'?20:id==='davi'?19:id==='allef'?20:social?(id==='freddy'||id==='dede'||id==='ravile'?10:12):id==='mota'||id==='marco'?10:13;
  let profile={shoulderY:(social?-36:id==='caleb'?-38:-34)*sy,shoulderX:wide*sx,neckY:(social?-43:-42)*sy,coreHalf:(wide+1)*sx,upper:small?7.5:9.5,lower:small?9:11.5,width:id==='caleb'?7:id==='freddy'||id==='mota'||id==='marco'?4:5};
  if(id==='igor')profile={shoulderY:-57*s,shoulderX:25*s,neckY:-63*s,coreHalf:29*s,upper:11,lower:12,width:6};
  if(id==='kaique')profile={shoulderY:-72*s,shoulderX:12*s,neckY:-84*s,coreHalf:12*s,upper:10,lower:11,width:4};
  if(id==='ollyan')profile={shoulderY:-52*s,shoulderX:15*s,neckY:-59*s,coreHalf:14*s,upper:9,lower:11,width:4};
  return profile;
 }
 function motionBody(id){
  if(motionBodyCache.has(id))return motionBodyCache.get(id);
  const size=144,ox=72,oy=116,canvas=document.createElement('canvas');canvas.width=canvas.height=size;const g=canvas.getContext('2d',{willReadFrequently:true});g.imageSmoothingEnabled=false;window.Art?.drawCharacter?.(g,id,ox,oy,{scale:(id==='lucas'?60:70)/bodyHeight(id),facing:1,frame:0,grounded:true,moving:false,speed:0,vy:0,noseRub:false,monitorBattle:true,cup:false,smoke:false});
  const profile=rigProfile(id),hip=legProfile(id).hipY,image=g.getImageData(0,0,size,size),hair= girls.has(id)?new Set((id==='aica'?['#4d392f','#77573d']:id==='ravile'?['#362f2b','#65503a']:id==='eloisa'?['#4d372c','#76543b']:id==='analaura'?['#51362d','#6a4734','#7a543c','#7d573e']:['#232d2b','#25302e','#3a4238','#626151','#303b32','#455044','#31392f','#63614d']).map(value=>parseInt(value.slice(1),16))):null;
  for(let y=0;y<size;y++)for(let x=0;x<size;x++){const i=(y*size+x)*4;if(!image.data[i+3])continue;const xx=x-ox,yy=y-oy,color=(image.data[i]<<16)|(image.data[i+1]<<8)|image.data[i+2],hairPixel=hair?.has(color)&&yy<hip+7,backpack=id==='daroca'&&xx< -10&&yy> -39&&yy< -14&&[0x5f6041,0x8d814a,0xb1a262].includes(color);let half=profile.coreHalf;if(id==='igor'&&yy>profile.neckY){const q=(yy+33)/28;half=Math.max(8,profile.coreHalf*Math.sqrt(Math.max(0,1-q*q)));}const torso=yy<=hip+(id==='igor'?5:1)&&Math.abs(xx)<=half,headHalf=id==='ollyan'?37:id==='daroca'?25:girls.has(id)?27:id==='nikolas'?28:18,head=yy<profile.neckY&&Math.abs(xx)<=headHalf; if(!(head||torso||hairPixel||backpack))image.data[i+3]=0;}
  g.putImageData(image,0,0);const part={canvas,ox,oy,profile};motionBodyCache.set(id,part);return part;
 }
 function movementPose(id,p,time){
  const motion=inferMotion(p),mt=Math.max(0,Number(p.motionTime)||0),vy=Number(p.vy)||0,phase=time*(gait[id]||10.7),wall=(Number(p.wallSide)||Number(p.facing)||1)*(p.facing<0?-1:1),heavy=id==='igor'||id==='davi'||id==='allef',quick=id==='lucas'||id==='menezes',land=motion==='land'?1-smooth(.01,.13,mt):0;
  let lean=0,dx=0,dy=0,armLift=0;
  if(motion==='run'){lean=heavy?.055:quick?.17:.12;dy=-Math.abs(Math.sin(phase))*2.7;}
  else if(motion==='jump'){const launch=p.jumps===2?0:1-smooth(.025,.15,mt);lean=-.07+launch*.08;dy=launch*1.8;armLift=clamp((-vy-80)/340,0,1);}
  else if(motion==='doubleJump'){const tuck=Math.sin(clamp(mt/.24,0,1)*Math.PI);lean=-.12+tuck*.21;dy=-tuck*2;armLift=1;}
  else if(motion==='fall'){lean=.055;armLift=clamp((vy-70)/430,0,1);}
  else if(motion==='dash'){const drive=smooth(0,.035,mt)*(1-smooth(.12,.19,mt));lean=(heavy?.22:.39)*drive;dx=drive*5;dy=-1.5;}
  else if(motion==='wallSlide'){lean=-wall*.1;dx=-wall*2;}
  else if(motion==='wallJump'){const push=1-smooth(.02,.22,mt);lean=-.22*push;dx=-push*2;armLift=push;}
  else if(motion==='land'){dy=land*(heavy?5:6);lean=-.07*land;}
  return{motion,mt,vy,phase,wall,heavy,quick,land,lean,dx,dy,armLift};
 }
 function movementArms(id,p,time,pose=movementPose(id,p,time)){
  const pr=rigProfile(id),m=pose.motion,phase=pose.phase,mt=pose.mt,sy=pr.shoulderY,spread=pr.shoulderX,L=pr.upper+pr.lower,arms=[];
  for(const side of [-1,1]){
   const shoulder=[side*spread,sy];let target=[side*(spread+3),sy+L*.91],bend=side;
   if(m==='run'){const swing=Math.sin(phase+(side<0?Math.PI:0));target=[side*spread+swing*L*.86,sy+L*(.24+.28*(1-Math.abs(swing)))];bend=side<0?-1:1;}
   else if(m==='jump'){const launch=p.jumps===2?0:1-smooth(.02,.16,mt),rise=clamp((-pose.vy-50)/360,0,1);target=side>0?[spread+L*.43,sy+L*(.72-launch*1.13-rise*.16)]:[-spread-L*.38,sy+L*(.7-launch*.62)];}
   else if(m==='doubleJump'){const open=smooth(.04,.2,mt);target=[side*(spread+L*(.34+open*.42)),sy-L*(.75-open*.62)];}
   else if(m==='fall'){target=[side*(spread+L*(.62+pose.armLift*.12)),sy+L*(.37-pose.armLift*.44)];}
   else if(m==='dash'){target=side<0?[-spread-L*.9,sy+L*.16]:[spread-L*.24,sy-L*.46];bend=side<0?1:-1;}
   else if(m==='wallSlide'){target=[pose.wall*(spread+L*.48),sy-L*(side<0?.46:.03)];bend=pose.wall;}
   else if(m==='wallJump'){const release=1-smooth(.02,.2,mt);target=side<0?[-spread-L*.52,sy-L*.42*release]:[spread+L*.54,sy+L*(.22-.64*release)];}
   else if(m==='land'){target=[side*(spread+L*(.15+pose.land*.55)),sy+L*(.88-pose.land*.4)];}
   // Mota keeps a runner's compact elbows; the rat and Lucas use lighter fists.
   if(id==='mota'&&m==='run')target[1]-=4;if(id==='menezes'&&m==='run')target[1]-=3;if(id==='arthur'&&m==='run')target[1]+=side*2;
   arms.push({side,...solveLeg(shoulder,target,pr.upper,pr.lower,bend)});
  }
  return{arms,upper:pr.upper,lower:pr.lower,width:pr.width};
 }
 function drawMovementArm(c,id,arm,width,back=false){
  const shirt=sleeveColors[id]||'#d9a763',flesh=skin[id]||'#d5a478',long=longSleeves.has(id),outline=width+3;c.save();if(back)c.globalAlpha*=.93;line(c,[arm.hip,arm.knee,arm.foot],INK,outline);line(c,[arm.hip,arm.knee],shirt,width);line(c,[arm.knee,arm.foot],long?shirt:flesh,width);rect(c,arm.foot[0]-2,arm.foot[1]-2,width+1,width+1,flesh);if(girls.has(id)&&arm.side<0){line(c,[arm.hip,[(arm.hip[0]+arm.knee[0])*.5,(arm.hip[1]+arm.knee[1])*.5]],'#244d74',Math.max(2,width-1));}c.restore();
 }
 function movementProp(c,id,arm,time){
  const x=arm.foot[0],y=arm.foot[1];
  if(id==='reeis'||id==='kaique'){rect(c,x-5,y-3,21,6,'#263d45');rect(c,x-2,y+2,5,8,'#263d45');rect(c,x-3,y-2,15,2,'#8ca6a4');}
  else if(id==='marco'){rect(c,x-7,y-3,13,17,'#3a4040');rect(c,x-5,y-2,9,14,'#ded2a5');line(c,[[x-3,y+2],[x+2,y+3],[x-1,y+6],[x+2,y+9]],'#755583',1);}
  else if(id==='caleb')weight(c,x,y,Math.sin(time*8)*.13,.43,'#9eb9c2');
  else if(id==='kaua'){rect(c,x-1,y-5,3,14,'#e9b452');rect(c,x-1,y-5,3,3,'#f5deb3');}
 }
 function drawMovementRig(c,id,p,time){
  const pose=movementPose(id,p,time),part=motionBody(id),legs=legPose(id,pose.motion,time,'side',0,false,{...p,...pose}),arms=movementArms(id,p,time,pose),hip=legProfile(id).hipY;
  c.save();c.translate(pose.dx,pose.dy);c.translate(0,hip);c.rotate(pose.lean);c.translate(0,-hip);drawMovementArm(c,id,arms.arms[0],arms.width,true);c.drawImage(part.canvas,-part.ox,-part.oy);drawMovementArm(c,id,arms.arms[1],arms.width);movementProp(c,id,arms.arms[id==='marco'?0:1],time);c.restore();
  drawLegs(c,id,legs,false,kit(id).color);
 }

 // The render pose reads the same windup and combo beat times as the combat
 // descriptor. It never publishes a hit, changes reach or advances simulation.
 const attackVisualCache=new Map();
 function attackVisual(id,kind,dir){const key=id+':'+kind+':'+dir;if(attackVisualCache.has(key))return attackVisualCache.get(key);const d=window.ArenaCombat?.attack?.(id,kind,dir,{facing:1})||{windup:.1,duration:.13,recovery:.2};attackVisualCache.set(key,d);return d;}
 function attackPose(id,p){
  const kind=p.attackType||'physical',dir=p.attackDirection||'side',d=attackVisual(id,kind,dir),total=Math.max(.35,Number(p.attackTotal)||d.windup+d.duration+d.recovery),progress=clamp(Number(p.attackProgress)||0,0,1),at=progress*total,beats=kind==='combo'?(d.finisher?.hits||[{delay:0}]):[{delay:0}];
  let beat=beats[0],distance=Infinity;for(const h of beats){const diff=at-(d.windup+(h.delay||0));if(Math.abs(diff)<distance){beat=h;distance=Math.abs(diff);}}
  const contact=d.windup+(beat.delay||0),relative=at-contact,wind=relative<0?smooth(-.14,-.025,relative):0,drive=smooth(-.035,.025,relative)*(1-smooth(.09,.23,relative)),recover=smooth(.035,.23,relative),power=kind==='combo'?1.15:kind==='ranged'?.75:1,heavy=['igor','caleb','davi','allef'].includes(id),kick=(girls.has(id)||id==='freddy'||id==='mota')&&kind!=='ranged',angle=dir==='up'?-1.15:dir==='down'?1.05:0;
  return{kind,dir,d,total,at,progress,relative,wind,drive,recover,power,heavy,kick,angle,settle:smooth(total-.2,total,at),guard:smooth(0,.065,at),shape:beat.shape||d.shape,dx:(drive*(heavy?2.6:4.5)-wind*2.5)*power,dy:dir==='down'?drive*2.6:dir==='up'?-drive*2:wind*1.3,lean:(dir==='up'?-.10:dir==='down'?.14:.12)*drive*power-.075*wind,release:kind==='ranged'&&relative>=0&&relative<.065};
 }
 function attackArms(id,p,pose=attackPose(id,p)){
  const pr=rigProfile(id),sx=pr.shoulderX,sy=pr.shoulderY,L=pr.upper+pr.lower,arms=[];
  for(const side of [-1,1]){
   const shoulder=[side*sx,sy];let target,bend=side;
   if(side<0){target=[-sx-L*(.20+pose.wind*.25),sy+L*(.38-pose.drive*.26)];if(pose.kind==='ranged'&&['reeis','kaique'].includes(id))target=[sx*.16,sy+L*.22];}
   else if(pose.kick){target=[sx+L*(.28-pose.drive*.51),sy+L*(.54-pose.drive*.68)];bend=-1;}
   else{
    const reach=L*(.66+.32*pose.drive),start=[sx+L*.12-pose.wind*L*.54,sy+L*.71-pose.wind*L*.76],end=[sx+Math.cos(pose.angle)*reach,sy+Math.sin(pose.angle)*reach+L*.05];
    target=[start[0]+(end[0]-start[0])*pose.drive,start[1]+(end[1]-start[1])*pose.drive];bend=-1;
    if(pose.kind==='ranged'&&['reeis','kaique'].includes(id)){target=[sx+L*(.85-pose.drive*.22),sy+L*.12];}
    if(id==='nikolas'&&pose.kind==='ranged'&&pose.wind>0){target=[target[0]+(21-target[0])*pose.wind,target[1]+(-50-target[1])*pose.wind];}
    if(id==='daroca'&&pose.kind!=='ranged')target=[sx+L*(.15+pose.drive*.43)-pose.wind*6,sy+L*(.32-pose.drive*.2)];
    if(id==='menezes'&&pose.kind!=='ranged')target[1]-=pose.wind*4;
    if(id==='lucas'&&pose.kind==='physical')target[1]+=8*pose.drive;
   }
   const blend=pose.guard*(1-pose.settle),rest=[side*(sx+3),sy+L*.91];target=[rest[0]+(target[0]-rest[0])*blend,rest[1]+(target[1]-rest[1])*blend];
   arms.push({side,...solveLeg(shoulder,target,pr.upper,pr.lower,bend)});
  }
  return{arms,upper:pr.upper,lower:pr.lower,width:pr.width};
 }
 function firearm(c,x,y,angle=0,flash=false){
  c.save();c.translate(x,y);c.rotate(angle);rect(c,-6,-6,28,10,INK);rect(c,-4,-4,23,4,'#8fa9ad');rect(c,0,3,6,11,INK);rect(c,19,-4,10,5,'#c1d4cb');rect(c,-3,-5,17,2,'#d4e2d5');
  if(flash){poly(c,[[29,-3],[33,-8],[35,-4],[44,-4],[40,0],[43,4],[34,3],[31,7]],'#ffe36c');rect(c,30,-2,8,4,'#fff9d5');}c.restore();
 }
 function heldProp(c,id,hand,pose,time){
  const x=hand.foot[0],y=hand.foot[1],a=pose.angle,color=kit(id).color,ranged=pose.kind==='ranged',hold=!ranged||pose.relative<.015,turn=-pose.wind*.9+pose.drive*.65;
  if(['reeis','kaique'].includes(id)){firearm(c,x,y,a+(ranged?-pose.drive*.16:turn*.45),ranged&&pose.release);return;}
  if(id==='caleb'){if(hold)weight(c,x+4,y,a+turn,.57,color);return;}
  if(id==='marco'||id==='kaua'||id==='miqueias'){
   c.save();c.translate(x,y);c.rotate(a-.65+turn);rect(c,-3,-23,6,33,INK);rect(c,-2,-21,4,29,id==='marco'?'#e8bd70':id==='kaua'?'#efc85d':'#d2dcbd');for(let i=0;i<4;i++)rect(c,-2,-17+i*6,2,1,'#916b42');poly(c,[[-3,10],[3,10],[0,17]],'#f5db9a');rect(c,-1,14,2,4,INK);c.restore();
   if(id==='marco'&&ranged&&pose.wind>.1){line(c,[[x+8,y-6],[x+16,y-12],[x+23,y-4],[x+16,y+1],[x+8,y-6]],'#c69ad6',2);rect(c,x+12,y-8,2,3,'#f6ebc9');}return;
  }
  if(id==='davi'){if(hold){c.save();c.translate(x,y);c.rotate(a+turn*.3);rect(c,-6,-13,12,23,INK);rect(c,-4,-10,8,17,'#a1bec5');for(let i=0;i<4;i++)rect(c,-6+i*4,-17,2,6,'#e2e8d2');rect(c,-2,-7,3,7,'#e9dbb6');c.restore();}return;}
  if(id==='vitor'){if(hold){c.save();c.translate(x,y);c.rotate(a+turn*.6);rect(c,-12,-5,30,11,'#e5ecdc');rect(c,-10,-4,25,3,'#9ebeb1');for(let i=0;i<4;i++)rect(c,18,-4+i*3,4,1,'#a7c7bd');c.restore();}return;}
  if(girls.has(id)){if(ranged&&hold)heel(c,x+3,y,a-.3,.42,color);return;}
  if(id==='mota'){if(hold)ball(c,ranged?x+2:15,ranged?y:-9,time*3+pose.drive*2,.63);return;}
  if(id==='menezes'){if(!ranged&&pose.drive>.12){c.save();c.translate(x+2,y);c.rotate(a-.5+pose.drive);for(let i=0;i<3;i++)line(c,[[i*4-3,4],[i*4+1,-5],[i*4+2,-8]],'#e5e8cf',2);c.restore();}return;}
  if(!ranged&&['arthur','almiro','allef'].includes(id)){c.save();c.translate(x,y);c.rotate(a+turn*.2);rect(c,-3,-5,8,10,skin[id]);for(let i=0;i<4;i++)rect(c,i*3-3,-11-i%2*2,2,10,skin[id]);rect(c,-6,-1,4,3,skin[id]);if(id==='allef'){rect(c,3,-6,10,14,'#f4e6b8');for(let i=0;i<3;i++)rect(c,5,-3+i*4,6,1,'#99784b');}c.restore();return;}
  if(id==='ravid'&&!ranged){line(c,[[x,y],[x+8,y-3]],skin[id],3);rect(c,x+6,y-5,5,3,skin[id]);return;}
  if(id==='ollyan'&&!ranged&&pose.drive>.4){for(let i=0;i<2;i++)poly(c,[[x-16-i*6,y-6+i*8],[x-4-i*6,y-11+i*8],[x+7,y-4+i*8],[x-4,y-3+i*8]],i?'#84c9eb':'#e8f6ee');return;}
  if(id==='dede'&&!ranged&&pose.drive>.5){puff(c,x+3,y,6,'#9cb1be','#dce9e6');return;}
  if(id==='lucas'){if(ranged&&pose.wind>.1){rect(c,11,-40,8,3,'#e49aa4');}return;}
  if(ranged&&hold){
   if(id==='daroca'){poly(c,[[x-5,y-5],[x+4,y-6],[x+7,y],[x+2,y+6],[x-6,y+3]],'#f7eed0');line(c,[[x-3,y-2],[x+2,y],[x-1,y+3]],'#a9b6a1',1);}
   else if(id==='nikolas'){pixelOval(c,x,y,7,5,'#9cbb5e');rect(c,x-3,y-3,4,2,'#def1a9');}
   else if(id==='freddy'){poly(c,[[x-6,y-3],[x,y-7],[x+7,y-2],[x+5,y+5],[x-4,y+4]],'#8c9e8e');rect(c,x-3,y-4,5,2,'#c4cfb5');}
   else if(['ravid','almiro','allef'].includes(id)){rect(c,x-5,y-6,11,14,'#f3eac8');rect(c,x-3,y-3,7,1,'#7c8a72');rect(c,x-3,y,5,1,'#7c8a72');}
   else if(id==='dede'){puff(c,x,y,7,'#a2b6bf','#e1e8de');}
   else if(id==='nicolas'){poly(c,[[x,y-8],[x+3,y-2],[x+8,y],[x+3,y+2],[x,y+8],[x-3,y+2],[x-8,y],[x-3,y-2]],'#f8dc87');}
  }
 }
 function drawAttackRig(c,id,p,time){
  const pose=attackPose(id,p),part=motionBody(id),arms=attackArms(id,p,pose),kickProgress=pose.kick?clamp(.08+pose.drive*.47,0,.55):0,legs=legPose(id,p.ground===false?inferMotion(p):'idle',time,pose.dir,kickProgress,pose.kind==='combo',{...p,dx:pose.dx,dy:pose.dy}),hip=legProfile(id).hipY;
  c.save();c.translate(pose.dx,pose.dy);c.translate(0,hip);c.rotate(pose.lean);c.translate(0,-hip);drawMovementArm(c,id,arms.arms[0],arms.width,true);
  if(id==='igor'&&pose.kind==='combo'){const squeeze=pose.drive*.065;c.save();c.translate(0,-13);c.scale(1+squeeze,1-squeeze*.75);c.translate(0,13);c.drawImage(part.canvas,-part.ox,-part.oy);c.restore();}else c.drawImage(part.canvas,-part.ox,-part.oy);
  drawMovementArm(c,id,arms.arms[1],arms.width);heldProp(c,id,arms.arms[1],pose,time);c.restore();drawLegs(c,id,legs,pose.kick,kit(id).color);
  // This follows the swung limb, not a hit target. Contact flashes are emitted
  // separately by confirmed combat events, so misses do not fake an impact.
  if(pose.kind!=='ranged'&&pose.drive>.6&&pose.relative<.095){
   const foot=pose.kick?legs.legs[1].foot:arms.arms[1].foot,x=foot[0]+(pose.kick?0:pose.dx),y=foot[1]+(pose.kick?0:pose.dy),a=pose.kick?(pose.dir==='up'?-1.4:pose.dir==='down'?.7:0):pose.angle;
   c.save();c.translate(x,y);c.rotate(a);poly(c,[[-19,-4],[-11,-6],[-5,-4],[3,-2],[2,2],[-8,3],[-17,1]],'#f6e5bc');rect(c,-25,-1,5,2,kit(id).color);c.restore();
  }
 }

 function inferMotion(p){if(p.motion)return p.motion;if(p.dashTime>0)return'dash';if(p.ground===false)return(p.vy||0)<-20?'jump':'fall';return Math.abs(p.vx||0)>15?'run':'idle';}
 function drawFighter(c,p,time=0){
  if(!p||p.stocks===0||p.eliminated)return;const id=p.character||'daroca',k=kit(id),face=p.facing<0?-1:1,t=Number(time)||0,height=id==='lucas'?60:70,scale=height/bodyHeight(id),emoting=p.emote>0,attack=(p.attackAnim>0||p.attackProgress>0&&p.attackProgress<1),progress=clamp(p.attackProgress??(1-(p.attackAnim||0)/.42),0,1),physical=attack&&p.attackType!=='ranged',combo=attack&&p.attackType==='combo',dir=p.attackDirection||'side',shape=String(p.attackShape||''),skinColor=skin[id]||'#d5a478',motion=inferMotion(p),mt=Number(p.motionTime)||0,strike=smooth(.16,.44,progress)*(1-smooth(.61,1,progress)),active=attack&&progress>.2&&progress<.8,wallLocal=(Number(p.wallSide)||face)*face;
  c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(p.x),Math.round(p.y));c.scale(face,1);
  const say=(value,x,y,size,color)=>{c.save();c.scale(face,1);label(c,value,x*face,y,size,color);c.restore();};
  if(p.respawn>0)for(let i=0;i<3;i++)rect(c,-13+i*12,-height-5+((t*40+i*13)%18),3,6,i%2?'#fff3c6':'#ffd265');
  if((p.transform||0)>0){for(let i=0;i<4;i++){const xx=-20+i*14,yy=-8-(t*46+i*17)%(height+15);rect(c,xx,yy,3,8,k.color);rect(c,xx,yy-3,2,3,'#fff3bd');}}
  // Launch/brake dust remains at the foot. It never masks the torso or target.
  if(motion==='dash'){for(let i=0;i<2;i++){rect(c,-24-i*8,-5+i*3,7-i*2,3,'#f1dca6');rect(c,-19-i*12,-13+i*4,6,2,'#fff0c7');}}
  if((motion==='doubleJump'||motion==='wallJump')&&mt<.18){const q=mt/.18,xx=motion==='wallJump'?wallLocal*21:0;for(let i=0;i<3;i++)rect(c,xx+(i-1)*(6+q*7),-7-q*(i%2?6:2),3,3,i%2?k.color:'#fff0b4');}
  if(motion==='wallSlide'&&p.wallGrip>0){rect(c,wallLocal*23,-27+(t*35)%18,2,4,'#e7cf9a');}
  c.save();
  const useMovementRig=!attack&&!emoting&&motion!=='idle'&&id!=='giant';
  if(attack&&id!=='giant'){drawAttackRig(c,id,p,t);}else if(useMovementRig){drawMovementRig(c,id,p,t);}else{
  if(emoting&&p.emoteKind==='dance'){c.translate(Math.sin(t*7)*3,-Math.abs(Math.sin(t*7))*(id==='lucas'?7:3));c.rotate(Math.sin(t*7)*.065);}
  else if(physical){const windup=progress<.18?Math.sin(progress/.18*Math.PI)*-3:0;c.translate(windup+strike*3,dir==='down'?strike*2:0);c.rotate((dir==='up'?-.07:dir==='down'?.025:.075)*strike);}
  else if(motion==='run'){const phase=t*(gait[id]||10.7);c.translate(0,-Math.abs(Math.sin(phase))*1.8);c.rotate(id==='igor'?.035:.07);}
  else if(motion==='dash'){c.translate(3,-3);c.rotate(id==='igor'?.16:.24);c.scale(1.03,.94);}
  else if(motion==='doubleJump'){c.translate(0,-2);c.rotate(-.16+Math.sin(clamp(mt/.28,0,1)*Math.PI)*.34);}
  else if(motion==='jump'){c.rotate(-.06);c.scale(.98,1.02);}
  else if(motion==='fall'){c.rotate(.045);}
  else if(motion==='wallSlide'){c.translate(-wallLocal*2,0);c.rotate(-wallLocal*.08);}
  else if(motion==='wallJump'){c.rotate(wallLocal*.17);c.translate(-wallLocal*2,-2);}
  else if(motion==='land'){const squash=1-clamp(mt/.12,0,1);c.scale(1+squash*.035,1-squash*.065);}
  const kick=((girls.has(id)||id==='freddy')&&physical)||(id==='mota'&&attack),kickGuard=girls.has(id)&&physical,pose=legPose(id,motion,t,dir,kick?progress:0,combo),armHalf=id==='igor'?22:14,replaceArm=id!=='giant'&&((motion==='wallSlide'&&!attack)||(attack&&active&&!kick)||kickGuard),aimX=dir==='up'?9:dir==='down'?17:dir==='neutral'?23:29,aimY=dir==='up'?-height+14:dir==='down'?-23:-35,drawBase=()=>window.Art?.drawCharacter?.(c,id,0,0,{scale,facing:1,frame:emoting?t*1.65:t*(gait[id]||10.7)/10.7,grounded:!['jump','doubleJump','fall','wallSlide','wallJump'].includes(motion),moving:motion==='run'||motion==='dash'||emoting&&p.emoteKind==='dance',speed:Math.abs(p.vx||0),vy:p.vy||0,monitorBattle:true,noseRub:id==='nikolas'&&emoting||!attack&&!emoting&&motion==='idle',attack:false,attackType:'paper',attackProgress:progress,hit:p.hit>0,bossPhase:1,flight:false,smoke:false,bellyRolling:false,expressive:id==='arthur',talking:emoting&&p.emoteKind==='taunt',injured:false});
  if(window.Art?.drawCharacter){
   if(id==='giant')drawBase();else{
    // Only the original legs are masked. Side strips preserve lowered hands,
    // long hair and carried props; there is exactly one visible pair of legs.
    c.save();c.beginPath();c.rect(-110,-150,220,150+pose.hipY+1);if(pose.hipY<-12){c.rect(-110,pose.hipY,95,-12-pose.hipY);c.rect(15,pose.hipY,95,-12-pose.hipY);}c.clip();
    if(replaceArm){const side=motion==='wallSlide'?wallLocal:1;c.beginPath();c.rect(-110,-150,220,106);if(side>0)c.rect(-110,-44,110+armHalf,44);else c.rect(-armHalf,-44,110+armHalf,44);c.clip();}drawBase();c.restore();
    if((motion==='wallSlide'||motion==='wallJump')&&wallLocal<0)for(const leg of pose.legs)for(const joint of ['hip','knee','foot'])leg[joint][0]*=-1;
    drawLegs(c,id,pose,kick,k.color);
   }
  }else{rect(c,-13,-height,26,height,skinColor);rect(c,-12,-height+25,24,30,k.color);}
  if(motion==='wallSlide'&&!attack&&id!=='giant'){
   const wx=wallLocal*(id==='igor'?29:21),sx=wallLocal*(id==='igor'?19:9);line(c,[[sx,-43],[wallLocal*(id==='igor'?26:16),-37],[wx,-47]],INK,6);line(c,[[sx,-43],[wallLocal*(id==='igor'?26:16),-37],[wx,-47]],skinColor,3);rect(c,wx-2,-50,5,6,skinColor);
  }
  if(kickGuard){
   const lift=dir==='up'?12:dir==='down'?7:10,guard=solveLeg([9,-42],[18-strike*14,-22-strike*lift],9,11,-1);
   line(c,[guard.hip,guard.knee,guard.foot],INK,7);line(c,[guard.hip,guard.knee],'#e4ece2',4);line(c,[guard.knee,guard.foot],skinColor,4);rect(c,guard.foot[0]-2,guard.foot[1]-2,5,5,skinColor);
  }
  if(attack&&active&&!kick&&id!=='giant'){
   const sleeve={daroca:'#c4934e',reeis:'#49818e',nikolas:'#87689b',marco:'#30363b',menezes:'#779097',ollyan:'#252f3b',igor:'#287eb8',kaique:'#b8dce3',dede:'#516563',arthur:'#6d99a0',davi:'#252b34',vitor:'#a3adb0',almiro:'#3288c7',miqueias:'#d8ca9c',allef:'#2a333a'}[id]||'#e4d8b7',shoulder=[id==='igor'?19:9,-42],hand=solveLeg(shoulder,[aimX,aimY],10,12,-1);line(c,[hand.hip,hand.knee,hand.foot],INK,7);line(c,[hand.hip,hand.knee],sleeve,4);line(c,[hand.knee,hand.foot],skinColor,4);rect(c,hand.foot[0]-3,hand.foot[1]-3,6,6,skinColor);
   if(!physical&&girls.has(id))heel(c,hand.foot[0]+2,hand.foot[1],-.5,.38,k.color);
  }
  if(id==='mota'&&attack&&active&&!physical){const foot=pose.legs[1].foot;ball(c,foot[0]+6,foot[1]-4,t*8,.65);}
  if(id==='mota'&&!attack&&!p.ballAway&&motion==='idle'){const by=-8-Math.abs(Math.sin(t*4))*20;ball(c,19,by,t*3,.55);}
  if(id==='caleb'&&!attack&&!emoting)weight(c,20,-29,.05,.48);
  if(physical&&active){
   const hitX=aimX,hitY=aimY,hitAngle=dir==='up'?-Math.PI/2:dir==='down'?Math.PI/2:0,hitScale=.75+.2*strike;
   c.save();c.translate(hitX,hitY);c.scale(hitScale,hitScale);
   // One readable prop is the primary strike. A short two-pixel trail appears
   // only through the contact window, keeping four-player fights legible.
   if(progress>.32&&progress<.57&&!girls.has(id)&&id!=='dede'&&id!=='ollyan'){c.save();c.rotate(hitAngle);rect(c,-19,-3,13,3,k.color);rect(c,-26,3,9,2,'#fff0bb');c.restore();}
   if(id==='menezes')claw(c,2,-2,t,'#f2e7c8');
   else if(id==='caleb')weight(c,7,0,hitAngle-.35+strike*.6,.65,k.color);
   else if(id==='reeis'||id==='kaique'){c.rotate(hitAngle-.18);rect(c,-15,-7,33,11,'#203841');rect(c,-12,-4,26,5,'#769193');rect(c,-8,4,7,11,'#263d45');rect(c,14,-4,9,4,'#bec3ab');rect(c,-11,-6,21,2,'#a4b2a4');}
   else if(['marco','kaua','miqueias'].includes(id)){c.rotate(hitAngle-.9+strike*.5);rect(c,-3,-22,6,39,'#283940');rect(c,-2,-20,4,30,id==='marco'?'#e8bd70':id==='miqueias'?'#b8d7cd':'#e6ad52');for(let i=0;i<4;i++)rect(c,-2,-16+i*6,3,1,'#68715c');poly(c,[[-3,10],[3,10],[0,20]],'#fae6b6');rect(c,-1,17,2,4,'#29323b');}
   else if(id==='davi'){rect(c,-6,-12,13,24,'#263d46');rect(c,-4,-9,9,15,'#b3bdb4');for(let i=0;i<4;i++)rect(c,-6+i*4,-16,2,5,'#e7e9d0');rect(c,-2,-8,3,7,'#f2e2b7');}
   else if(id==='vitor'){c.rotate(hitAngle+strike*1.2-.6);rect(c,-17,-7,37,13,'#e5e9d6');rect(c,-15,-5,32,3,'#9bbab0');rect(c,-14,3,31,1,'#718e89');for(let i=0;i<5;i++)rect(c,18,-6+i*3,5,1,'#c5d4c0');}
   else if(id==='almiro'){glove(c,3,0,skinColor,hitAngle);if(progress>.35&&progress<.55){line(c,[[-5,-height+35],[-5,-height+22]],'#fff1b0',2);line(c,[[-12,-height+29],[3,-height+29]],'#fff1b0',2);}}
   else if(id==='ravid'||id==='allef'){glove(c,3,0,skinColor,hitAngle);}
   else if(id==='ollyan'){c.rotate(hitAngle);poly(c,[[-16,-6],[2,-13],[18,-3],[6,7],[-20,5],[-2,0]],'#d9eff7');rect(c,-9,-4,18,3,'#81b9ea');}
   else if(id==='mota')ball(c,6,6,t*7,.75);
   else if(id==='lucas')glove(c,-3,14,k.color,hitAngle-.15);
   else if(id==='igor'){glove(c,5,2,skinColor,.1+hitAngle);if(combo){rect(c,-10,-4,24+strike*5,18,'#2e8dd0');rect(c,-8,-3,21+strike*4,3,'#7bc8eb');rect(c,-10,11,23+strike*5,3,'#25609b');}}
   else if(id==='giant'){say(progress<.5?'6':'7',11,0,22,k.color);}
   else if(id==='nicolas'){glove(c,5,0,'#e6c56e',hitAngle-.15);if(progress>.35&&progress<.55){rect(c,-2,-16,2,7,'#fff1c0');rect(c,-5,-13,8,2,'#fff1c0');}}
   else if(id==='dede'){glove(c,5,0,skinColor,hitAngle);puff(c,-7,3,7,'#91a5b5','#d6e4e9');}
   else if(!girls.has(id))glove(c,4,0,skinColor,hitAngle-.15);
   c.restore();
  }
  }
  c.restore(); // Body pose ends before lettering, which always stays upright.
  if(combo&&progress>.3&&progress<.6){const phrase=girls.has(id)?'BIURIFUL!':id==='mota'?'GOLAÇO!':id==='igor'?'REBATE!':id==='lucas'?'SAPO NINJA!':id==='menezes'?'POUDII!':id==='reeis'?'OOO REEEIS!':'';if(phrase)say(phrase,0,-height-13,8,k.color);}
  if(emoting){const dance=p.emoteKind==='dance';if(dance){for(let i=0;i<2;i++){const xx=-23+i*45,yy=-height-5-Math.sin(t*5+i)*4;rect(c,xx,yy,2,7,k.color);rect(c,xx,yy-1,6,2,k.color);rect(c,xx-2,yy+6,4,3,k.color);}if(id==='caleb')weight(c,0,-height-11+Math.sin(t*7)*5,0,.65);if(id==='mota')ball(c,23,-18-Math.abs(Math.sin(t*5))*32,t*5,.55);if(id==='menezes')window.Art?.drawRat?.(c,24,-1,t,{scale:.35,facing:-1});}
   else{const phrase=girls.has(id)?'AFF VEYR JURO':id==='caleb'?'CADÊ O SHAPE?':id==='igor'?'TEM LANCHE?':id==='lucas'?'BAIXINHO LIGEIRO':id==='menezes'?'PEGOU AR?':id==='reeis'?'CHAMOU O REI?':id==='mota'?'SÓ EMBAIXADINHA':'RESPEITA A ROÇA',w=phrase.length*4.8+12;rect(c,-w/2,-height-29,w,18,'#fff0c9');poly(c,[[-4,-height-11],[3,-height-11],[0,-height-7]],'#fff0c9');say(phrase,0,-height-20,8,'#31534b');if(id==='ravid'){rect(c,25,-51,15,49,'#9cb5a9');for(let i=0;i<4;i++)rect(c,26,-48+i*11,13,1,'#64847c');}}
  }
  c.restore();
 }
 function projectileType(s){return String(s.type||s.shape||s.effect||'paper').toLowerCase();}
 function drawProjectile(c,s,time=0){
  if(!s)return;const type=projectileType(s),r=Math.max(4,Math.min(28,Number(s.r)||Number(s.radius)||9)),color=s.color||'#f3d28a',t=Number(time)||0,vx=Number(s.vx)||0,vy=Number(s.vy)||0,angle=Math.atan2(vy,vx),age=Number.isFinite(s.maxLife)&&Number.isFinite(s.life)?Math.max(0,s.maxLife-s.life):t,spin=age*(type.includes('weight')?7:10)*(vx<0?-1:1);c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(s.x),Math.round(s.y));
  // Three tiny material-colored marks show velocity and return direction.
  // Their size is independent of projectile damage and no history is allocated.
  if(Math.hypot(vx,vy)>220&&/paper|heel|shoe|weight|ball|bullet|pen|ink|stone|brush/.test(type)&&type!=='67'){
   c.save();c.rotate(angle);for(let i=0;i<3;i++){const len=7-i*2;rect(c,-r-8-i*8,-2+(i%2)*4,len,i===0?2:1,i===0?'#fff0c1':color);}c.restore();
  }
  if(['tongue','tether'].some(q=>type.includes(q))||s.motion==='tether'){
   const ox=Number.isFinite(s.originX)?s.originX-s.x:Number.isFinite(s.startX)?s.startX-s.x:-Math.cos(angle)*32,oy=Number.isFinite(s.originY)?s.originY-s.y:Number.isFinite(s.startY)?s.startY-s.y-7:-Math.sin(angle)*32;line(c,[[ox,oy],[-Math.cos(angle)*12,Math.sin(t*14)*4],[0,0]],'#9d5c69',7);line(c,[[ox,oy],[-Math.cos(angle)*12,Math.sin(t*14)*4],[0,0]],'#eda0ab',4);pixelOval(c,0,0,7,5,'#f5b0b7');
  }else if(type.includes('heel')||type.includes('shoe')){heel(c,0,0,spin,.82,color);if(s.returning){c.save();c.rotate(angle);rect(c,-24,-6,8,4,'#fff2bd');rect(c,-32,1,6,3,color);c.restore();}}
  else if(type.includes('weight')||type.includes('dumbbell')||type.includes('plate')||type.includes('anilha'))weight(c,0,0,spin,.8,color);
  else if(type.includes('ball')||type.includes('football')||type.includes('futebol'))ball(c,0,0,spin,.95);
  else if(type.includes('word')||type.includes('text')||type.includes('chalk')||type==='monologue'||type==='english'||type==='ticket'){const phrase=String(s.text||(type==='english'?'ALLRIGHT!':type==='monologue'?'BLÁ BLÁ BLÁ':type==='ticket'?'SENHA 67':'POUDII!')).slice(0,18);const w=phrase.length*6+14;rect(c,-w/2,-12,w,24,type==='ticket'?'#eddbaf':'#243c48');rect(c,-w/2,-12,3,24,color);if(type==='ticket')for(let i=0;i<6;i++)rect(c,-w/2+i*w/6,-13,3,3,INK);label(c,phrase,0,1,11,type==='ticket'?'#3f4e42':'#f5e5bc');}
  else if(type==='wind'){smear(c,0,0,angle,.6,'#e9fbff',12);rect(c,-8,-6,17,4,'#81d7ff');rect(c,-5,3,21,3,color);}
  else if(type==='light'){c.rotate(angle);poly(c,[[-21,0],[-9,-5],[-1,-12],[6,-5],[17,0],[6,5],[-1,12],[-9,5]],'#f0ce74');poly(c,[[-12,0],[-2,-6],[9,0],[-2,6]],'#fff6c2');rect(c,-33,-1,10,2,color);}
  else if(type==='stone'){c.rotate(spin*.5);poly(c,[[-10,-8],[1,-12],[11,-5],[10,6],[0,12],[-12,5]],'#677b78');poly(c,[[-8,-6],[0,-9],[7,-4],[1,1],[-8,1]],'#9eb4a4');rect(c,2,5,5,2,'#3f5a59');}
  else if(type.includes('wave')||s.motion==='wave'){for(let i=0;i<4;i++){const xx=-i*10;poly(c,[[xx-8,12],[xx-2,-8-i%2*8],[xx+6,-17-i%2*6],[xx+11,12]],i%2?color:'#e9dfaa');}rect(c,-40,12,52,3,color);}
  else if(type.includes('smoke')||type.includes('gas')||type.includes('fart')){puff(c,-5,2,r,type.includes('smoke')?'#aabed4':'#9bcf47',type.includes('smoke')?'#e9f3ff':'#dffa79');puff(c,7,-5,r*.7,color,'#effac7');rect(c,-25,-5,9,4,color);rect(c,-29,5,7,4,color);}
  else if(type.includes('goo')||type.includes('slime')||type.includes('catarro')){c.rotate(angle);poly(c,[[-r-6,0],[-r,-r*.65],[r*.4,-r],[r,0],[r*.3,r],[-r,r*.5]],'#79974c');rect(c,-r*.3,-r*.4,r,r*.5,'#d2e693');}
  else if(type.includes('pencil')||type.includes('pen')||type.includes('ruler')){c.rotate(angle);rect(c,-19,-4,33,8,INK);rect(c,-17,-3,29,6,'#dfbc6b');rect(c,-13,-2,23,2,'#fff0b6');poly(c,[[12,-4],[22,0],[12,4]],'#f2d69d');rect(c,19,-1,4,2,INK);}
  else if(type.includes('cake')||type.includes('bolo')){c.rotate(spin*.25);rect(c,-12,-5,24,15,'#ac7750');rect(c,-13,-8,26,6,'#f4dfba');rect(c,-8,-13,16,5,'#728d56');rect(c,-7,1,4,3,'#e7c897');rect(c,3,1,4,3,'#e7c897');}
  else if(type.includes('comb')||type.includes('pente')){c.rotate(spin);rect(c,-18,-5,36,7,'#e3b77a');for(let i=0;i<8;i++)rect(c,-17+i*5,2,3,10,INK);}
  else if(type==='brush'){c.rotate(spin);rect(c,-18,-3,18,6,'#a8c8c0');rect(c,-2,-10,23,20,'#805e4a');rect(c,1,-8,17,16,'#d4b77a');for(let i=0;i<4;i++)rect(c,1+i*5,-13,2,6,INK);}
  else if(type.includes('six')||type==='67'){label(c,Math.floor(t*12)%2?'6':'7',0,0,26,color);rect(c,-18,15,36,2,'#e9efb3');}
  else if(type.includes('bullet')||type.includes('spark')||type.includes('shot')){c.rotate(angle);rect(c,-12,-3,23,6,'#e9bc75');rect(c,-6,-2,15,3,'#fff2c8');rect(c,-23,-1,8,2,color);}
  else if(type.includes('ribbon')||type.includes('rope')){line(c,[[-18,-3],[-8,Math.sin(t*15)*8],[3,-5],[16,2]],color,5);line(c,[[-18,-4],[-8,Math.sin(t*15)*8-1],[3,-6],[16,1]],'#fff0c5',1);}
  else if(type.includes('slap')||type==='palm'){glove(c,0,0,color,angle-.2);for(let i=0;i<3;i++)rect(c,-7+i*5,-17,4,12,color);}
  else if(type.includes('ink')||type.includes('drawing')||type.includes('brainrot')){const n=Math.floor(age*8)%3,variant=String(s.variant||'');
   if(variant==='spindle'){poly(c,[[-4,-r-8],[4,-r-8],[r*.6,r*.5],[-r*.6,r*.5]],color);line(c,[[-3,6],[-8,17],[-13,18]],INK,3);line(c,[[3,6],[9,15],[14,15]],INK,3);}
   else if(variant==='pasta'){for(let i=0;i<3;i++){const xx=(i-1)*7;line(c,[[xx,-r],[xx-3,-4],[xx+3,5],[xx,15+n]],INK,6);line(c,[[xx,-r],[xx-3,-4],[xx+3,5],[xx,15+n]],i%2?'#f2d1a0':color,3);}}
   else{poly(c,[[-r,-r],[r*.2,-r-4],[r,r*.2],[r*.5,r],[-r*.7,r*.7]],color);if(variant==='ink')for(let i=0;i<3;i++)rect(c,-r-3+i*9,r-3+(i%2)*4,4,6,color);}
   rect(c,-7,-5,5,7,'#fff2d2');rect(c,3,-5,5,7,'#fff2d2');rect(c,-5,-3,2,4,INK);rect(c,5,-3,2,4,INK);rect(c,-4,7,10,2,INK);for(let i=0;i<3;i++)rect(c,-r-6+i*7,-r-7-n,4,2,color);}
  else{c.rotate(spin);poly(c,[[-r,-r*.65],[r*.4,-r],[r,r*.2],[r*.5,r],[-r,r*.7]],'#eaf0d6');rect(c,-4,-3,8,3,color);rect(c,-6,4,9,2,'#b3bba7');}
  c.restore();
 }
 function sewer(c,x,y,amount=1){c.save();c.translate(x,y);const lift=clamp(amount,0,1);rect(c,-37,-10,74,25,'#584b45');rect(c,-33,-7,66,21,'#c47842');rect(c,-27,-4,54,17,'#172d40');for(let i=0;i<5;i++)rect(c,-23+i*10,-2,5,13,'#5686a5');c.save();c.translate(-31,-7);c.rotate(-lift*.9);rect(c,0,-9,64,10,'#263f59');rect(c,3,-7,58,4,'#8ba8bd');for(let i=0;i<5;i++)rect(c,7+i*10,-6,4,5,'#35536a');c.restore();for(let i=0;i<3;i++)rect(c,-39+i*28,15,23,4,'#f3bb71');c.restore();}
 function contactImpact(c,progress,radius,color,angle=0){
  const burst=smooth(0,.09,progress)*(1-smooth(.11,.62,progress)),r=Math.min(24,Math.max(10,radius*.6))*(.55+burst*.45);c.save();c.rotate(angle);
  if(progress<.62){poly(c,[[-r,-2],[-r*.34,-r*.22],[-r*.2,-r*.8],[2,-r*.31],[r*.78,-r*.6],[r*.55,-2],[r,2],[r*.3,r*.18],[r*.48,r*.75],[0,r*.35],[-r*.58,r*.64],[-r*.32,2]],INK);poly(c,[[-r+3,-1],[-r*.2,-r*.1],[-r*.1,-r*.5],[2,-r*.14],[r*.45,-r*.28],[r*.3,0],[r-4,2],[r*.12,r*.06],[r*.2,r*.4],[0,r*.18],[-r*.3,r*.28],[-r*.1,1]],color);rect(c,-2,-2,5,5,'#fff8db');}
  const distance=8+progress*30,size=Math.max(1,Math.round(4*(1-progress)));for(let i=0;i<4;i++){const a=-.9+i*.6,x=Math.cos(a)*distance,y=Math.sin(a)*distance*.75;rect(c,x,y,size+2,size,i%2?color:'#fff0bf');}c.restore();
 }
 function drawEffect(c,e,time=0){
  if(!e)return;const t=Number(time)||0,type=String(e.type||''),shape=String(e.shape||''),max=Math.max(.001,Number(e.maxLife)||Number(e.duration)||.45),life=Number(e.life),progress=Number.isFinite(e.progress)?clamp(e.progress,0,1):Number.isFinite(life)?1-clamp(life/max,0,1):.4,color=e.color||'#ffca3d';
  c.save();c.imageSmoothingEnabled=false;c.translate(Math.round(Number(e.x)||0),Math.round(Number(e.y)||0));
  const face=e.facing<0?-1:1,angle=shape.includes('upper')||shape.includes('-up')?-Math.PI/2:shape.includes('-low')||shape.includes('-down')?Math.PI/2:face<0?Math.PI:0;
  if(shape.includes('sewer')||shape.includes('burrow')||type==='sewer'){sewer(c,0,0,Math.sin(progress*Math.PI));for(let i=0;i<5;i++){const xx=(i-2)*(9+progress*5),yy=-8-Math.sin(progress*Math.PI)*(10+i%2*8);rect(c,xx,yy,7,5,i%2?'#d18d51':'#a9cbe0');}}
  else if(shape.includes('army')||type==='army'){for(let i=0;i<4;i++){const x=(i-1.5)*29,y=Math.sin(progress*Math.PI)*-4;window.Art?.drawCharacter?.(c,'reeis',x,y,{frame:t+i,facing:i<2?1:-1,scale:.62,grounded:true,attack:true,attackType:'gun',attackProgress:progress});rect(c,x+(i<2?17:-27),y-27,12,4,'#ffdf48');}label(c,'O EXÉRCITO CHEGOU!',0,-69,10,color);}
  else if(shape.includes('rats')||type==='rats'){for(let i=0;i<5;i++)window.Art?.drawRat?.(c,(i-2)*20,Math.sin(progress*Math.PI)*-5,t+i,{scale:.65,facing:i%2?1:-1});}
  else if(shape.includes('belly')){const rebound=Math.sin(progress*Math.PI);impact(c,face*(7+rebound*14),-24,17+rebound*3,'#ffe251',progress);for(let i=0;i<3;i++){rect(c,-23-i*9,-39+(i%2)*16,7,4,'#43aeed');rect(c,30+i*9,-30+(i%2)*11,6,4,'#8edfff');}label(c,'REBATE!',0,-62,11,'#fff0b0');}
  else if(shape.includes('knee')){impact(c,face*9,-26,19,'#ffdc60',progress);for(let i=0;i<3;i++)rect(c,-25-i*8,-22+i*7,6,4,i%2?'#fff0bc':color);label(c,'BIURIFUL!',0,-69,14,color);}
  else if(shape.includes('football')||shape.includes('juggle')){const lift=shape.includes('lift')||shape.includes('juggle'),yy=-12-(lift?Math.sin(progress*Math.PI)*40:0);ball(c,Math.sin(progress*Math.PI)*17,yy,t*12,1.1);for(let i=0;i<4;i++)rect(c,-18-i*7,yy-2+(i%2)*6,5,4,i%2?'#fff4b3':'#55b6f0');if(shape.includes('bicycle'))label(c,'GOLAÇO!',0,-65,12,color);}
  else if(shape.includes('gas-burst')){for(let i=0;i<3;i++)puff(c,(i-1)*(17+progress*15),-8-Math.sin(progress*Math.PI)*(i%2?18:4),20-i*2,i%2?'#b0d546':'#7fb937','#eeff9d');rect(c,-6,-9,6,5,'#fbffd2');}
  else if(shape.includes('tongue')||shape.includes('frog-upper')){for(let i=0;i<3;i++){const yy=-10-i*13;line(c,[[-22,yy+5],[-22,yy-4],[20,yy-4],[24,yy+3],[17,yy+6],[-16,yy+6]],'#9d4e6e',7);line(c,[[-20,yy+3],[-20,yy-3],[18,yy-3],[20,yy+2]],'#f395b2',3);}if(shape.includes('upper'))impact(c,10,-44,18,'#ffed7d',progress);}
  else if(shape.includes('rat-')){for(let i=0;i<3;i++)window.Art?.drawRat?.(c,(i-1)*24,-progress*16,t+i,{scale:.65,facing:i%2?-1:1});label(c,'POUDII!',0,-43,11,color);}
  else if(shape.includes('slime')||shape.includes('nose')){for(let i=0;i<4;i++){const a=i*2.1;drawProjectile(c,{x:Math.cos(a)*progress*40,y:Math.sin(a)*progress*33,type:'goo',vx:Math.cos(a),vy:Math.sin(a),r:9,color},t);}if(shape.includes('nose')){pixelOval(c,0,-15,19,14,'#e2b286');rect(c,-7,-21,8,4,'#ffdbad');}}
  else if(shape.includes('sketch-cage')){const h=28+Math.sin(progress*Math.PI)*24;rect(c,-31,-h,62,h+8,'#171f39');rect(c,-27,-h+4,54,h,'#f3ddbb');for(let i=0;i<5;i++)rect(c,-24+i*11,-h+5,4,h-3,'#51354e');rect(c,-31,-h,62,5,'#f74850');rect(c,-31,3,62,5,'#f74850');for(let i=0;i<3;i++)rect(c,35+i*8,-h+12+i*7,6,4,'#ffd044');}
  else if(shape.includes('brainrot')||shape.includes('sketch')||shape.includes('sixseven')||shape.includes('seven-smash')||shape.includes('six-fist')){const six=shape.includes('seven')||shape.includes('six');if(six)label(c,shape.includes('seven')?'67':'6',0,-10,35,color);else if(window.Art?.drawMinion)window.Art.drawMinion(c,0,0,1,t,{design:'brainrot',variant:'brainrot',facing:1});else label(c,'RABISCO!',0,-12,14,color);for(let i=0;i<5;i++)rect(c,Math.cos(i*2)*34*progress,-15+Math.sin(i*2)*30*progress,5,8,color);}
  else if(shape.includes('iraci')||shape.includes('confiscate')){c.save();c.rotate(-.12);rect(c,-43,-22,86,32,'#ffe4a4');rect(c,-40,-19,80,26,'#f4bd59');label(c,shape.includes('iraci')?'IRACI!':'CONFISCADO',0,-5,12,'#ae332e');c.restore();}
  else if(shape.includes('smoke')||shape.includes('braces')){for(let i=0;i<3;i++)puff(c,(i-1)*(15+progress*10),-12-i%2*17,20,i%2?'#a2b9d0':'#c6daed','#f0faff');if(shape.includes('braces')){rect(c,-24,-21,48,21,INK);rect(c,-21,-18,42,15,'#ffffff');for(let i=0;i<6;i++)rect(c,-18+i*7,-16,4,10,'#789cbb');rect(c,-21,-11,42,3,'#324d68');}}
  else if(shape.includes('divine')||shape.includes('aura-')||shape.includes('protagonist')){poly(c,[[-8,-12],[-3,-43],[4,-43],[8,-12],[31,-8],[31,-2],[8,3],[4,28],[-3,28],[-8,3],[-31,-2],[-31,-8]],'#ffe356');poly(c,[[-4,-8],[0,-28],[4,-8],[18,-4],[4,0],[0,16],[-4,0],[-18,-4]],'#fff9c6');for(let i=0;i<4;i++)rect(c,-36+i*23,-44+(i%2)*70,5,8,'#fff2a6');}
  else if(shape.includes('palm')||shape.includes('slap')){c.save();c.scale(shape.includes('giant')?1.55:1,shape.includes('giant')?1.55:1);glove(c,0,-9,color,-.15);for(let i=0;i<4;i++)rect(c,-8+i*5,-30,4,16,color);c.restore();if(progress>.3)impact(c,23,-10,14,'#ffdd6b',progress);}
  else if(shape.includes('wall-')||shape.includes('monologue-wall')){rect(c,-31,-51,62,57,'#e8d1a3');for(let i=0;i<5;i++){rect(c,-31,-48+i*11,62,2,'#b17a4a');for(let j=0;j<3;j++)rect(c,-24+j*25+(i%2?10:0),-47+i*11,2,9,'#b17a4a');}rect(c,-25,-35,50,20,'#275f9b');label(c,'BLÁ BLÁ',0,-24,11,'#fff3bd');}
  else if(shape.includes('bald')){pixelOval(c,0,-23,22,18,'#e9b581');rect(c,-10,-31,13,5,'#fff8c6');impact(c,-8,-31,13,'#fff28c',progress);}
  else if(shape.includes('beard')||shape.includes('english')){rect(c,-42,-23,84,30,'#173f7a');rect(c,-39,-20,78,24,'#5ab5ea');label(c,'ALLRIGHT!',0,-8,13,'#fff0bf');if(shape.includes('beard'))poly(c,[[-17,-36],[-13,-17],[0,-9],[15,-18],[19,-36]],'#b76a42');}
  else if(shape.includes('barber')){rect(c,-24,-37,48,33,'#4f91c2');rect(c,-27,-7,54,11,'#a8d9ef');rect(c,-17,-42,35,10,'#253d47');rect(c,-5,4,10,21,'#4c6768');rect(c,-23,23,46,5,'#8da596');for(let i=0;i<3;i++)rect(c,32+i*8,-35+i*5,5,14,'#ffdc78');}
  else if(shape.includes('towel')||shape.includes('brush')){c.save();c.rotate(progress*TAU);rect(c,-38,-11,76,22,'#f8ffff');rect(c,-34,-8,68,5,'#8fc8e7');for(let i=0;i<6;i++){rect(c,-44,-9+i*4,7,2,'#cedce9');rect(c,37,-9+i*4,7,2,'#cedce9');}c.restore();}
  else if(shape.includes('reception')||shape.includes('queue')||shape.includes('receipt')){rect(c,-25,-33,50,38,'#fff0bc');for(let i=0;i<5;i++)rect(c,-20,-26+i*6,35-i%2*12,2,'#99704c');label(c,'67',0,-49,21,color);if(shape.includes('bell')){pixelOval(c,0,-16,22,12,'#ffd23d');rect(c,-24,-10,48,6,'#8d6835');rect(c,-3,-33,6,9,'#ce883c');}}
  else if(shape.includes('pencil-case')||shape.includes('eraser')){if(shape.includes('eraser')){c.save();c.rotate(-.4);rect(c,-24,-15,48,29,'#f2a8bf');rect(c,-24,0,48,14,'#63bde3');rect(c,-21,-12,35,3,'#ffe3ea');c.restore();}else{rect(c,-25,-21,50,31,'#258cc6');rect(c,-25,-20,50,6,'#86d9ff');rect(c,-10,-16,20,26,'#d3f2ff');for(let i=0;i<4;i++)rect(c,27+i*8,-11+(i%2)*7,6,4,'#ffdf68');}}
  else if(shape.includes('claw')||shape.includes('scratch')){claw(c,0,0,t,'#244956');claw(c,2,-1,t,'#fff0ba');for(let i=0;i<3;i++)rect(c,-20+i*17,21,7,4,color);}
  else if(shape.includes('wave')||shape.includes('stomp')){crack(c,0,0,progress,'#ffc65c');for(let i=0;i<5;i++){const xx=(i-2)*(13+progress*11);poly(c,[[xx-7,4],[xx-3,-12-Math.sin(progress*Math.PI)*14],[xx+3,-17-Math.sin(progress*Math.PI)*12],[xx+8,4]],i%2?'#98582f':'#e4a35d');}}
  else if(type==='attack'){
   if(shape.includes('weight')||shape.includes('dumbbell')||shape.includes('supino')){smear(c,-7,-2,angle,progress,'#b4d8e9',9);weight(c,face*19,-6,t*7,.8,'#4b87be');}
   else if(shape.includes('heel')||shape.includes('kick')||shape.includes('capoeira')){smear(c,-2,-3,angle,progress,'#ffe1a3',10);heel(c,face*21,-1,shape.includes('upper')?-1.2:face<0?Math.PI:0,.85,color);}
   else if(shape.includes('tongue'))drawProjectile(c,{type:'tongue',x:0,y:0,color,vx:face},t);
   else if(shape.includes('lowblow')){glove(c,face*18,11,'#efc5a4',face<0?Math.PI:0);impact(c,face*29,9,12,'#ffe66c',progress);}
   else if(shape.includes('gun')||shape.includes('stock')){c.save();c.scale(face,1);rect(c,-8,-9,42,11,INK);rect(c,-5,-7,32,5,'#7199b2');rect(c,1,2,8,16,INK);rect(c,28,-6,13,5,'#aec9d8');c.restore();smear(c,-8,1,angle,progress,'#8bafc7',6);}
   else if(shape.includes('ruler')||shape.includes('tool')){c.save();c.rotate(angle-.7);rect(c,-4,-27,9,48,'#633f27');rect(c,-2,-25,5,43,'#ffce5d');for(let i=0;i<7;i++)rect(c,-2,-20+i*6,3,2,'#7e552e');c.restore();}
   else if(shape.includes('clipper')){rect(c,-9,-20,18,32,INK);rect(c,-6,-17,12,23,'#8ec2dc');for(let i=0;i<5;i++)rect(c,-9+i*4,-26,2,8,'#effaff');}
   else if(shape.includes('ear')||shape.includes('wind')){smear(c,0,0,angle,progress,'#d8f6ff',14);rect(c,-11,-6,22,4,'#84d5ff');}
   else{const palm=shape.includes('teacher')||shape.includes('point')||shape.includes('receipt');smear(c,-9,0,angle,progress,palm?'#ffe4b9':color,8);glove(c,face*(14+Math.sin(progress*Math.PI)*12),-4,palm?'#e0b08a':color,face<0?Math.PI:0);}
  }
  else if(type==='ko'){const n=16+progress*38;impact(c,0,0,n,color,progress);for(let i=0;i<7;i++){const xx=(i-3)*(12+progress*13),yy=(i%2?-1:1)*(13+progress*27);rect(c,xx,yy,7,11,i%2?'#fff4bd':'#ffcf3d');}label(c,'POW!',0,-n-18,16,'#fff1b2');}
  else if(type==='respawn'){rect(c,-24,9,48,8,'#71472c');rect(c,-21,6,42,5,'#ffce64');for(let i=0;i<5;i++){const yy=-5-(progress*60+i*13)%75;rect(c,-24+i*12,yy,5,10,i%2?'#f8f4bc':color);}}
  else if(type==='combo'){contactImpact(c,progress,32,color,angle);label(c,'3 ACERTOS!',0,-39,10,'#fff0bf');}
  else if(type==='hit'||type==='spark'){contactImpact(c,progress,Number(e.radius)||22,color,angle);}
  else{rect(c,-4,-4,8,8,color);rect(c,-9,-2,18,4,'#fff0b5');}
  if(e.text)label(c,String(e.text).slice(0,34),0,-27-progress*18,12,color);c.restore();
 }
 window.ArenaArt=Object.freeze({drawBackground,drawStage,drawFighter,drawProjectile,drawEffect,bodyHeight,legPose,normalizedHeight:type=>type==='lucas'?60:70,movementPose,movementArms,attackPose,attackArms,version:5});
})();
