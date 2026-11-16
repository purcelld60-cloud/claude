/* Original scenery finish: distant atmosphere, physical materials and quiet life.
 * This layer never owns a collider, actor, quest, camera, soundtrack or save. */
(() => {
 'use strict';
 if(!window.Art||window.SceneDetails)return;
 const art=window.Art,arena=window.ArenaArt,cache=new Map(),CACHE_LIMIT=28;
 const reduced=window.matchMedia?.('(prefers-reduced-motion: reduce)');
 const clamp=(n,a,b)=>Math.max(a,Math.min(b,Number(n)||0));
 const hash=n=>{const x=Math.sin(n*127.1+93.7)*43758.5453;return x-Math.floor(x);};
 const rect=(c,x,y,w,h,color)=>{c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.ceil(w),Math.ceil(h));};
 function poly(c,points,color){c.fillStyle=color;c.beginPath();points.forEach((p,i)=>i?c.lineTo(Math.round(p[0]),Math.round(p[1])):c.moveTo(Math.round(p[0]),Math.round(p[1])));c.closePath();c.fill();}
 function line(c,points,color,width=1){c.strokeStyle=color;c.lineWidth=width;c.beginPath();points.forEach((p,i)=>i?c.lineTo(Math.round(p[0]),Math.round(p[1])):c.moveTo(Math.round(p[0]),Math.round(p[1])));c.stroke();}
 function cached(key,w,h,paint){let v=cache.get(key);if(v){cache.delete(key);cache.set(key,v);return v;}v=document.createElement('canvas');v.width=w;v.height=h;const c=v.getContext('2d');c.imageSmoothingEnabled=false;paint(c);cache.set(key,v);while(cache.size>CACHE_LIMIT)cache.delete(cache.keys().next().value);return v;}
 function time(t){return reduced?.matches?0:Number(t)||0;}
 function sceneAllowed(){try{const s=window.Game?.getAudioState?.();return !s?.cutscene&&!s?.activity;}catch{return true;}}
 function cloud(c,x,y,s=1){c.save();c.translate(Math.round(x),Math.round(y));c.scale(s,s);
  poly(c,[[-55,12],[-43,12],[-43,2],[-25,2],[-25,-11],[-5,-11],[-5,-22],[19,-22],[19,-11],[39,-11],[39,1],[58,1],[58,13],[73,13],[73,25],[-55,25]],'#afd4e7');
  poly(c,[[-54,9],[-39,9],[-39,-1],[-21,-1],[-21,-13],[0,-13],[0,-24],[18,-24],[18,-13],[35,-13],[35,-2],[53,-2],[53,10],[67,10],[67,18],[-54,18]],'#e8f6fa');
  rect(c,-21,-11,51,13,'#ffffff');rect(c,2,-22,14,15,'#ffffff');rect(c,-37,0,71,8,'#fbffff');rect(c,-43,20,94,3,'#c6e3ed');rect(c,-26,25,65,2,'#cce7ed');c.restore();
 }
 function sky(c,scene,camera,t){
  if(![0,1,3,4,5,7,9].includes(scene))return;
  if(scene===4||scene===5){for(let i=0;i<2;i++)cloud(c,((i*423+t*1.8-camera*.06+1200)%1200)-100,31+i*12,.38+i*.06);return;}
  const h=scene===9?140:180;
  const bg=cached('sky:'+scene,960,h,g=>{const grad=g.createLinearGradient(0,0,0,h);grad.addColorStop(0,scene===3?'#3f99d5':'#3199df');grad.addColorStop(.64,'#7fc9ee');grad.addColorStop(1,h<120?'#74b8e7':'#96cef0');g.fillStyle=grad;g.fillRect(0,0,960,h);for(let i=0;i<9;i++)rect(g,0,h-15+i*2,960,1,'#acd9ee0a');});
  c.drawImage(bg,0,0);c.save();c.beginPath();c.rect(0,0,960,h);c.clip();
  const sx=734-camera*.025,sy=h<120?38:80;
  for(let i=3;i>0;i--)rect(c,sx-27-i*8,sy-22-i*6,54+i*16,44+i*12,'#fff5b00b');
  poly(c,[[sx-21,sy-29],[sx+17,sy-29],[sx+17,sy-22],[sx+27,sy-22],[sx+27,sy+18],[sx+19,sy+18],[sx+19,sy+27],[sx-20,sy+27],[sx-20,sy+18],[sx-28,sy+18],[sx-28,sy-19],[sx-21,sy-19]],'#ffe69b');rect(c,sx-20,sy-23,34,41,'#fff7ce');rect(c,sx-15,sy-20,26,4,'#fffdf0');
  for(let i=0;i<5;i++){const x=((i*257+t*(2.2+i%2)-camera*.06+1500)%1500)-190;cloud(c,x,36+(i%3)*37,.57+(i%3)*.17);}
  for(let i=0;i<3;i++){const x=((i*379+t*9-camera*.1+1130)%1130)-70,y=31+(i%2)*34,flap=Math.round(Math.sin(t*5+i)*2);line(c,[[x-5,y+flap],[x,y],[x+5,y+flap]],'#4687a8',1);}
  c.restore();
  // The new sky remains behind the original floodlight silhouettes.
  if(scene===3)for(const wx of [85,2450]){const x=wx-camera;if(x< -30||x>990)continue;rect(c,x,122,8,58,'#4b6260');rect(c,x+1,122,2,58,'#9eb9b8');rect(c,x-16,112,41,16,'#3e5354');for(let k=0;k<3;k++)rect(c,x-11+k*11,115,8,9,'#f9e5ac');}
  if(scene===7)for(let wx=300;wx<camera+1000;wx+=1300){const x=wx-camera;if(x< -30||x>990)continue;rect(c,x,100,7,80,'#40687b');rect(c,x+1,100,2,80,'#9bbecb');rect(c,x-18,89,43,17,'#1f425c');for(let j=0;j<3;j++)rect(c,x-13+j*12,93,9,8,'#fff2b6');}
 }
 const palettes=[['#d3ab6d','#725339','#e5c887'],['#e2e7dc','#7c999e','#f8f5df'],['#a2ada6','#394d4b','#d1cdb6'],['#dcac7d','#805b44','#edd2a3'],['#e8e5d5','#879e9b','#f9f3de'],['#b9a18a','#665d58','#d0bc9f'],['#bda4c6','#4f4166','#e9d9e8'],['#79b75b','#397f47','#b4d17f'],['#ddbc87','#624b3d','#f1d9aa'],['#edf1e2','#8ba6aa','#ffffff'],['#e9c598','#94734f','#f9e3bc'],['#8199b6','#26374c','#b1d2de']];
 function groundTexture(c,scene,camera){
  const pal=palettes[scene]||palettes[0],start=Math.floor(camera/256);
  for(let chunk=start;chunk<=start+4;chunk++){
   const seed=(chunk%7+7)%7,layer=cached('ground:'+scene+':'+seed,256,96,g=>{
    // Broken highlights and contact shadows describe material without darkening actors.
    for(let i=0;i<36;i++){const x=hash(i+seed*71)*250,y=8+hash(i+seed*13+87)*84;
     if(scene===0){rect(g,x,y,4+hash(i+6)*9,2,i%3?pal[0]:pal[1]);if(i%4===0){rect(g,x+3,y+4,5,2,pal[2]);rect(g,x+2,y+4,2,1,'#fff0b1');}}
     else if(scene===7){rect(g,x,y,2,3,i%3?pal[0]:pal[1]);rect(g,x+2,y-1,2,2,pal[0]);}
     else{rect(g,x,y,11+hash(i+4)*14,1,i%3?pal[0]:pal[1]);if(i%5===0)rect(g,x+4,y+2,9,1,pal[2]);}
    }
    if(scene!==0&&scene!==7){for(let x=0;x<256;x+=64){rect(g,x,4,1,92,pal[1]+'44');rect(g,x+2,5,1,36,pal[2]+'55');}rect(g,0,48,256,1,pal[1]+'44');rect(g,0,49,256,1,pal[2]+'44');}
   });
   const worldX=chunk*256,gaps=window.WorldData?.gaps?.[scene]||[];c.save();c.beginPath();let cursor=worldX;
   for(const gap of gaps){const a=Number(gap[0]),b=a+Number(gap[1]);if(b<=worldX||a>=worldX+256)continue;if(a>cursor)c.rect(cursor-camera,444,a-cursor,96);cursor=Math.max(cursor,b);}
   if(cursor<worldX+256)c.rect(cursor-camera,444,worldX+256-cursor,96);c.clip();c.drawImage(layer,Math.round(worldX-camera),444);c.restore();
  }
 }
 function groundLife(c,scene,camera,t){
  const outdoor=[0,1,3,4,5,7,9].includes(scene),start=Math.floor(camera/190);
  if(outdoor){
   for(let i=start;i<=start+6;i++){const x=i*190+hash(i+9)*74-camera,yy=scene===0||scene===7?524:530;
    if(scene===0||scene===7){for(let j=0;j<4;j++){const sway=Math.round(Math.sin(t*1.5+i+j)*2),gx=x+j*7;line(c,[[gx,yy],[gx-3+sway,yy-10-j%2*5]],j%2?'#7fbb48':'#3c823e',2);line(c,[[gx,yy-3],[gx+5+sway,yy-10]],'#a9d16b',2);}if(i%3===0){rect(c,x+5,yy-17,6,4,'#f2d176');rect(c,x+7,yy-19,2,8,'#f2d176');}}
    else{rect(c,x,yy,29,3,'#5f7e7044');if(i%3===0){rect(c,x+6,yy-3,9,3,'#cec0a1');rect(c,x+7,yy-4,6,2,'#eee0bb');}}
   }
  }
  if(scene===4){for(let i=0;i<10;i++){const x=((i*113+t*6-camera*.4+1100)%1100)-70,y=281+(i*29)%63;rect(c,x,y,17+i%3*9,1,'#d3f3ee');rect(c,x+4,y+3,10,1,'#b4e6e8');}}
  if(scene===5){for(let i=0;i<3;i++){const wx=Math.floor(camera/430)*430+i*430+197,x=wx-camera;rect(c,x,482,57,5,'#4a65674d');rect(c,x+5,483,44,1,'#9fb6ad88');rect(c,x+16+Math.sin(t+i)*4,486,13,1,'#d8ded1aa');}}
  if(scene===6){for(let i=0;i<9;i++){const x=((i*137+t*5-camera*.14+1080)%1080)-60,y=25+(i*39)%290;rect(c,x,y,2,2,'#ede0ff');if(i%3===0){rect(c,x-3,y+1,8,1,'#bb97d0');rect(c,x+1,y-3,1,8,'#bb97d0');}}}
 }
 function interiorLight(c,scene,camera,t){
  if(![2,8,10].includes(scene))return;
  const spacing=scene===2?280:scene===8?438:660,start=Math.floor(camera/spacing)-1;
  c.save();
  for(let i=start;i<start+6;i++){const x=i*spacing-camera+(scene===2?84:scene===8?130:175);if(x< -180||x>1140)continue;
   // Light ends behind feet, leaving combat silhouettes untouched.
   poly(c,[[x,scene===8?105:155],[x+35,scene===8?105:155],[x+137,432],[x-83,432]],scene===8?'#ffe3a909':'#f9f5d20a');
   for(let j=0;j<4;j++){const dx=x-20+j*32,yy=460+j*8;rect(c,dx,yy,86-j*10,2,scene===8?'#ffe3a918':'#e6efda1a');}
   if(scene===8){rect(c,x-42,135,2,131,'#e5f7ef44');rect(c,x-42,135,72,1,'#e5f7ef66');}
   if(scene===2){rect(c,x+8,307,2,52,'#cee6d633');rect(c,x-13,307,21,1,'#cee6d655');}
  }
  // Slow dust only near the upper light. Eight fixed motes, no random spawning.
  for(let i=0;i<8;i++){const x=((i*157+t*3-camera*.2+1100)%1100)-70,y=89+(i*31)%195+Math.sin(t*.7+i)*4;rect(c,x,y,1,1,'#fff7df99');}
  c.restore();
 }
 function roofDetails(c,scene,camera,t){
  if(scene===1||scene===9){const y=scene===1?222:212,start=Math.floor(camera/187);for(let i=start;i<=start+6;i++){const x=i*187-camera+40;rect(c,x,y+10,71,2,'#ffffff66');rect(c,x,y+13,71,1,'#7a9eb833');}}
  if(scene===11){c.save();for(let i=0;i<10;i++){const x=((i*107-camera*.16+1100)%1100)-70,y=22+(i*47)%165,a=.18+.18*Math.sin(t*1.1+i);c.globalAlpha=a;rect(c,x,y,2,2,i%2?'#99d9f2':'#ffe7ba');}c.restore();}
 }
 function campaign(c,scene,camera,t){if(!sceneAllowed())return;t=time(t);c.save();c.imageSmoothingEnabled=false;c.beginPath();c.rect(0,0,960,540);c.clip();sky(c,scene,camera,t);roofDetails(c,scene,camera,t);groundTexture(c,scene,camera);groundLife(c,scene,camera,t);interiorLight(c,scene,camera,t);c.restore();}
 function classroom(c,id,t){if(!sceneAllowed())return;t=time(t);c.save();
  // Glass catches a thin rim and a restrained diagonal reflection, not a filter.
  rect(c,307,78,455,2,'#e3fff2');rect(c,307,81,2,135,'#c2e6da');rect(c,308,220,449,1,'#2f8b8955');
  poly(c,[[719,84],[731,84],[756,111],[756,124]],'#e3fff52e');rect(c,304,231,466,2,'#ebd9ab');
  for(const x of [155,803]){rect(c,x+7,87,2,97,'#e4f6f5');rect(c,x+8,88,43,1,'#ffffff');poly(c,[[x+10,89],[x+19,89],[x+46,130],[x+38,130]],'#f2ffff55');}
  for(let x=0;x<960;x+=80){rect(c,x+2,447,1,91,'#d6decc33');rect(c,x+5,450,58,1,'#eff0db55');}for(let i=0;i<7;i++){const x=179+i*97+Math.sin(t*.4+i)*3,y=46+(i*37)%163;rect(c,x,y,1,1,'#f9f6d9aa');}
  // Reflected window shapes remain below the walking surface.
  for(const x of [190,815]){poly(c,[[x,449],[x+55,449],[x+88,520],[x-6,520]],'#e2ecdc18');rect(c,x+27,449,2,71,'#709b9918');rect(c,x+1,481,69,2,'#71969422');}c.restore();
 }
 function boss(c,type,camera,t,homeX){if(!sceneAllowed())return;t=time(t);type=typeof type==='object'?type.type:type;const center=homeX?homeX-camera:480;c.save();
  const dark=['marco','menezes','giant','dede'].includes(type),color=dark?'#d8a9d555':'#f3dfae66';
  for(let i=0;i<7;i++){const x=((i*167+t*4+center*.07+1120)%1120)-80,y=27+(i*43)%200;rect(c,x,y,1,2,color);}
  // Fine surface imperfections stay entirely below the actors' feet.
  for(let i=0;i<19;i++){const x=i*53+Math.sin(i)*9;rect(c,x,453+(i%3)*29,24+i%2*13,1,dark?'#b391b133':'#f2d7b433');if(i%3===0)rect(c,x+6,455+(i%3)*29,12,1,dark?'#352c4922':'#5a493622');}
  if(type==='menezes'){for(const side of [-1,1]){const x=center+side*356;rect(c,x-22,69,45,2,'#f1ca8b44');rect(c,x-21,73,2,171,'#eecb9122');}}
  if(type==='marco'||type==='giant'){for(let i=0;i<4;i++){const x=center-350+i*230,y=48+(i%2)*120;line(c,[[x,y],[x+13,y-4],[x+19,y+3]],'#d6b9df44',1);}}
  c.restore();
 }
 function arenaBackdrop(c,camera,t,W,H){t=time(t);c.save();c.imageSmoothingEnabled=false;
  // Repaint only the distant atmosphere. The original lower farm, barn,
  // orchard, river, village and turning windmill remain fully visible.
  const cap=Math.floor(Math.max(45,Math.min(H*.66,H*.88-100))),pan=Number(camera?.x)||640,fade=Math.min(24,Math.floor(cap/4)),ratio=c.canvas.width/W,edge=cached('arena-edge:'+W+':'+fade,Math.ceil(W),fade,()=>{}),ec=edge.getContext('2d');ec.clearRect(0,0,W,fade);ec.drawImage(c.canvas,0,(cap-fade)*ratio,W*ratio,fade*ratio,0,0,W,fade);
  c.save();c.beginPath();c.rect(0,0,W,cap);c.clip();
  const atmosphere=cached('arena-sky:'+W+':'+H,Math.ceil(W),Math.ceil(cap),g=>{const sky=g.createLinearGradient(0,0,0,Math.max(1,cap));sky.addColorStop(0,'#268ed9');sky.addColorStop(.45,'#69bced');sky.addColorStop(1,'#b1dded');g.fillStyle=sky;g.fillRect(0,0,W,cap);});c.drawImage(atmosphere,0,0);
  const sunX=W*.76-(pan-640)*.006,sunY=H*.17;
  for(let i=3;i>0;i--)rect(c,sunX-22-i*10,sunY-22-i*8,44+i*20,44+i*16,'#fff3b00c');
  poly(c,[[sunX-19,sunY-29],[sunX+18,sunY-29],[sunX+18,sunY-22],[sunX+27,sunY-22],[sunX+27,sunY+18],[sunX+18,sunY+18],[sunX+18,sunY+27],[sunX-20,sunY+27],[sunX-20,sunY+18],[sunX-28,sunY+18],[sunX-28,sunY-19],[sunX-19,sunY-19]],'#ffe699');rect(c,sunX-18,sunY-23,32,41,'#fff6c6');rect(c,sunX-13,sunY-20,24,3,'#fffde4');
  for(let layer=0;layer<3;layer++){
   const step=Math.max(93,W/(7-layer)),shift=((pan-640)*(.02+layer*.023))%step,base=cap*(.71+layer*.13),points=[[-step,cap+20]];
   for(let i=-1;i<=Math.ceil(W/step)+1;i++){const x=i*step-shift,peak=base-(.10+layer*.015)*cap*(.45+hash(i+layer*13));points.push([x,base+cap*.03],[x+step*.21,peak+8],[x+step*.41,peak-9],[x+step*.55,peak-13],[x+step*.72,peak+3],[x+step*.89,base+cap*.02]);}
   points.push([W+step,cap+20]);poly(c,points,['#a5cbdf','#86b9d1','#6ca9c6'][layer]);
   if(layer===1)for(let i=0;i<7;i++){const x=i*step-shift+step*.45,yy=base-cap*.11;poly(c,[[x-9,yy],[x+7,yy-6],[x+20,yy+12],[x+7,yy+6]],'#bedce7');}
  }
  for(let i=0;i<5;i++){const x=((i*(W+220)/5+t*(1.7+i%2)-pan*.025+W+220)%(W+220))-110,y=H*.08+(i%3)*H*.075;cloud(c,x,y,.48+(i%3)*.11);}
  c.restore();c.save();for(let i=0;i<8;i++){c.globalAlpha=(i+1)/8;c.drawImage(edge,0,i*fade/8,W,fade/8,0,cap-fade+i*fade/8,W,fade/8);}c.restore();
  // Foreground leaves frame the lower corners; the centre of the fight stays open.
  const ground=H-4;for(const side of [1,-1]){const x=side>0?8:W-8;for(let i=0;i<4;i++){const sway=Math.sin(t*1.3+i)*2;poly(c,[[x,ground],[x+side*(16+i*8),ground-25-i*13],[x+side*(24+i*8+sway),ground-29-i*13],[x+side*(13+i*7+sway),ground-6]],i%2?'#328f4688':'#75bb4b88');}}
  // Distant white birds and sunlit dust have fixed, very small budgets.
  for(let i=0;i<3;i++){const x=((i*317+t*8-(camera?.x||0)*.09+W+140)%(W+140))-70,y=H*.2+i*19+Math.sin(t*.4+i)*3,wing=Math.round(Math.sin(t*4+i)*2);line(c,[[x-4,y+wing],[x,y],[x+4,y+wing]],'#ecfaffbb',1);}
  const sx=W*.76,sy=H*.17;rect(c,sx-14,sy-21,24,3,'#fffbd999');rect(c,sx-21,sy-12,3,19,'#fffbd966');
  c.restore();
 }
 function arenaSurface(c,platforms,t){t=time(t);c.save();c.imageSmoothingEnabled=false;
  for(const p of platforms||[]){const x=Number(p.x)||0,y=Number(p.y)||0,w=Number(p.w)||0;if(w<30)continue;
   rect(c,x+8,y+8,w-16,2,'#302e2933');for(let i=0;i<Math.min(9,Math.floor(w/35));i++){const xx=x+13+i*(w-28)/Math.max(1,Math.min(9,Math.floor(w/35)));rect(c,xx,y+3,7,1,'#e2f3ac');rect(c,xx+3,y+10,5,1,'#f0cf8b66');}
   if(p.main){for(const side of [-1,1]){const xx=side<0?x+56:x+w-57;const sway=Math.round(Math.sin(t*1.4+xx)*2);line(c,[[xx,y+31],[xx+sway,y+49],[xx-4+sway,y+64]],'#2f713e',2);for(let j=0;j<3;j++)poly(c,[[xx+sway,y+39+j*9],[xx-6+sway,y+36+j*9],[xx-8+sway,y+40+j*9],[xx-1+sway,y+44+j*9]],j%2?'#83bc55':'#5ba149');}}
  }c.restore();
 }
 const originalScene=art.drawScene,originalRoom=art.drawClassroom,originalBoss=art.drawArena;
 art.drawScene=function(c,scene,camera=0,t=0){originalScene(c,scene,camera,t);campaign(c,Number(scene),Number(camera)||0,t);};
 art.drawClassroom=function(c,id,t=0){originalRoom(c,id,t);classroom(c,id,t);};
 art.drawArena=function(c,type,camera=0,t=0,homeX=0){originalBoss(c,type,camera,t,homeX);boss(c,type,camera,t,homeX);};
 if(arena){const background=arena.drawBackground,stage=arena.drawStage;window.ArenaArt=Object.freeze({...arena,drawBackground(c,camera,t,W=960,H=540){background(c,camera,t,W,H);arenaBackdrop(c,camera,t,W,H);},drawStage(c,platforms,t){stage(c,platforms,t);arenaSurface(c,platforms,t);}});}
 window.SceneDetails=Object.freeze({version:1,getStatus:()=>({cacheEntries:cache.size,cacheLimit:CACHE_LIMIT,reducedMotion:!!reduced?.matches}),clearCache:()=>cache.clear()});
})();
