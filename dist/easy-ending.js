/* Original, seekable comic interlude. The Jorge finale remains its own film. */
(() => {
 'use strict';
 const original=window.Cinematics;if(!original)return;
 const KIND='easy_finish',W=960,H=540;
 const frames=Object.freeze([
  Object.freeze({id:'prize',duration:2.2,title:'O PRÊMIO DO MODO FÁCIL',speaker:'Irmão de Clara Swift',text:'Zerou no Fácil? O bolo voltou… e a chupeta veio de brinde, bebezinho!'}),
  Object.freeze({id:'pacifier',duration:2.6,title:'UMA CONQUISTA BEM DIFERENTE',speaker:'Da Roça',text:'Eu só pedi mais tempo entre os ataques, pô… E me deram logo uma chupeta!'}),
  Object.freeze({id:'babble',duration:3.6,title:'CHUPETA CONQUISTADA',speaker:'Da Roça',text:'Gugu dada!'})
 ]);
 let cursor=0,serial=0;
 const shots=Object.freeze(frames.map((f,index)=>{const shot=Object.freeze({...f,label:f.title,index,start:cursor});cursor+=f.duration;return shot;}));
 const total=Math.round(cursor*100)/100;
 const info=Object.freeze({id:KIND,duration:total,manualDefault:false,shots});
 const clamp=(n,a=0,b=1)=>Math.max(a,Math.min(b,Number(n)||0)),ease=n=>{n=clamp(n);return n*n*(3-2*n);},mix=(a,b,n)=>a+(b-a)*n;
 const isEasy=s=>s?.kind===KIND;
 function position(s){if(!s)return 0;if(s.done)return total;const index=clamp(Math.floor(s.index),0,frames.length-1);return clamp(shots[index].start+Math.max(0,Number(s.time)||0),0,total);}
 function create(options={}){return {kind:KIND,index:0,time:0,elapsed:0,done:false,token:'easy-finish-'+(++serial),sfxPlayed:false,options:{...options}};}
 function stateAt(seconds=0,options={}){const elapsed=clamp(seconds,0,total);let index=shots.findIndex(shot=>elapsed<shot.start+shot.duration);if(index<0)index=shots.length-1;return{kind:KIND,index,time:elapsed-shots[index].start,elapsed,done:elapsed>=total,sfxPlayed:true,options:{...options,musicTimed:true,preview:true}};}
 function voice(s){if(s.sfxPlayed||s.options?.preview||s.index!==2||s.time<.08)return;s.sfxPlayed=true;window.ArenaSound?.play?.('gugu-dada',{id:'easy-babble-'+(s.audioToken??s.token)});}
 function update(s,dt){if(!s||s.done)return;s.time+=clamp(dt,0,.1);while(!s.done&&s.time>=frames[s.index].duration){s.time-=frames[s.index].duration;if(s.index+1>=frames.length){s.done=true;s.time=frames[s.index].duration;}else s.index++;}s.elapsed=position(s);voice(s);}
 function advance(s){if(!s||s.done)return false;if(s.index+1>=frames.length){s.done=true;s.time=frames[s.index].duration;s.elapsed=total;return false;}s.index++;s.time=0;s.elapsed=shots[s.index].start;return true;}
 function rect(c,x,y,w,h,color){c.fillStyle=color;c.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
 function text(c,value,x,y,size=14,color='#fff0c1',align='center'){c.font='bold '+size+'px monospace';c.textAlign=align;c.textBaseline='middle';c.fillStyle='#513321';c.fillText(value,x+2,y+2);c.fillStyle=color;c.fillText(value,x,y);}
 function pennants(c,t){rect(c,0,46,W,3,'#3c5966');for(let i=0;i<25;i++){const x=i*40-7,y=49+Math.round(Math.sin(t*2+i)*3),color=['#e95239','#ffd04b','#338bcc'][i%3];rect(c,x,y,24,8,color);rect(c,x+3,y+8,18,6,color);rect(c,x+7,y+14,10,5,color);rect(c,x+10,y+19,4,4,color);}}
 function pacifier(c,x,y,scale=1,bob=0){c.save();c.translate(Math.round(x),Math.round(y+bob));c.scale(scale,scale);
  // Stepped pixels form the teat, shield and open handle; no blurred circles.
  rect(c,-13,-2,7,6,'#fff1bc');rect(c,-11,-4,7,10,'#d5ae70');rect(c,-10,-3,6,7,'#f4d89d');
  rect(c,-5,-8,14,18,'#7e2932');rect(c,-7,-5,18,12,'#7e2932');rect(c,-4,-7,12,16,'#f3cb45');rect(c,-6,-4,16,10,'#ffdb50');rect(c,-2,-5,8,3,'#fff3af');rect(c,-3,5,11,3,'#eaa82c');
  rect(c,1,-2,12,6,'#962f38');rect(c,4,-3,8,8,'#e84d55');rect(c,8,-1,9,4,'#e84d55');
  rect(c,12,1,9,3,'#284a82');rect(c,17,3,6,10,'#284a82');rect(c,11,12,9,4,'#284a82');rect(c,7,5,5,8,'#284a82');
  rect(c,12,4,7,2,'#6ecbff');rect(c,19,6,2,5,'#3faaf0');rect(c,11,12,7,2,'#3faaf0');rect(c,9,7,2,4,'#6ecbff');
  c.restore();
 }
 function toy(c,x,y,t,withPacifier=true){c.save();c.translate(x,y);c.rotate(Math.sin(t*2)*.035);rect(c,-61,0,122,37,'#855139');rect(c,-65,-6,130,8,'#e2ac65');rect(c,-55,30,11,22,'#5b3c2d');rect(c,44,30,11,22,'#5b3c2d');rect(c,-45,5,90,3,'#b97b46');if(withPacifier)pacifier(c,-8,-18,1.1,Math.sin(t*3)*2);rect(c,-45,-30,29,20,'#e84b3b');rect(c,-41,-26,21,12,'#ffda51');rect(c,-34,-23,7,7,'#f5efc6');c.restore();}
 function backdrop(c,s){const t=position(s);rect(c,0,0,W,H,'#4ba9e0');for(let i=0;i<5;i++){const x=(i*251+t*7)%1250-170,y=87+(i%2)*59;rect(c,x,y,84,15,'#fff4ce');rect(c,x+15,y-13,49,15,'#fff4ce');rect(c,x+30,y-23,22,10,'#fff4ce');}
  rect(c,0,290,W,135,'#81b953');for(let i=0;i<8;i++){rect(c,i*137-35,264+(i%3)*14,104,94,'#5ba358');rect(c,i*137-12,245+(i%3)*14,60,44,'#6bac5a');}
  rect(c,0,398,W,142,'#bc793e');rect(c,0,397,W,8,'#f6c04f');for(let i=0;i<25;i++)rect(c,(i*79+17)%960,422+(i*37)%100,10+i%4,3,'#e3a25e');
  for(let i=0;i<12;i++){const x=i*88-7;rect(c,x,335,9,64,'#e9d3a5');rect(c,x+1,335,7,8,'#fff0c9');}rect(c,0,353,W,8,'#dca96d');rect(c,0,380,W,7,'#dca96d');
  pennants(c,t);rect(c,77,224,313,66,'#65412c');rect(c,82,229,303,56,'#d8a766');rect(c,90,235,287,2,'#f7d491');text(c,'FINALIZOU NO FÁCIL',234,252,18,'#fff0b0');text(c,'PACOTINHO DE CORAGEM',234,274,10,'#6e4126');toy(c,245,405,t,s.index===0);
 }
 function draw(c,s){if(!c||!s)return;c.save();c.imageSmoothingEnabled=false;backdrop(c,s);const t=Number(s.time)||0,i=clamp(s.index,0,2),globalTime=position(s),bouncing=i===2?Math.abs(Math.sin(t*5.1))*11:0,actorX=i===0?625:615,actorY=475-bouncing,scale=i===0?3.45:3.9,tilt=i===2?Math.sin(t*5.1)*.035:0,reach=i===1?ease(t/1.8):i===2?1:0;
  c.save();c.translate(actorX,actorY);c.rotate(tilt);
  if(window.Art?.drawCharacter)window.Art.drawCharacter(c,'daroca',0,0,{scale,facing:1,frame:i===2?t*.8:0,moving:false,grounded:true,muscular:!!s.options?.trained,attack:i===1&&t<1.65,attackType:i===1?'paper':undefined,animation:'idle',attackProgress:i===1?.02+reach*.16:0,pose:i===0?'offer':undefined});
  else{rect(c,-45,-158,90,111,'#dd8a43');rect(c,-35,-242,70,87,'#d9a073');rect(c,-72,-245,144,18,'#e3bb65');rect(c,-45,-294,90,50,'#e3bb65');rect(c,-33,-47,24,47,'#344c58');rect(c,14,-47,24,47,'#344c58');}
  if(i>0){const handProgress=(.02+reach*.16)/.3,handX=13-21*handProgress,handY=-24-28*handProgress,attach=ease((reach-.74)/.26),localX=i===2?10:mix(handX+4,10,attach),localY=i===2?-43.8:mix(handY-1,-43.8,attach),wobble=i===2?Math.sin(t*11)*1.5:0;pacifier(c,localX*scale,localY*scale,1.65,wobble);}
  c.restore();
  if(i===2){const words=t<1.55?'GUGU…':'DADA!';text(c,words,239,333+Math.sin(t*5)*4,t<1.55?35:44,t<1.55?'#fff2a0':'#ffda50');for(let j=0;j<9;j++){const x=490+(j*51+globalTime*19)%330,y=135+(j*31+globalTime*35)%175;rect(c,x,y,4,6,['#ffdd52','#f36052','#fff6c9'][j%3]);}rect(c,99,444,289,38,'#344b7a');rect(c,104,449,279,28,'#4489c4');text(c,'CHUPETA CONQUISTADA!',244,463,14,'#fff1b3');}
  rect(c,0,0,W,24,'#31241f');rect(c,0,520,W,20,'#31241f');text(c,'DA ROÇA · UM PRÊMIO À ALTURA DA RESENHA',480,531,10,'#e8cba4');c.restore();
 }
 const api={...original,
  create:(kind='intro',options={})=>kind===KIND?create(options):original.create(kind,options),
  stateAt:(kind,seconds=0,options={})=>kind===KIND?stateAt(seconds,options):original.stateAt(kind,seconds,options),
  timeline:(kind='intro')=>isEasy(kind)?position(kind):kind===KIND?info:original.timeline(kind),
  timelinePosition:s=>isEasy(s)?position(s):original.timelinePosition(s),
  update:(s,dt)=>isEasy(s)?update(s,dt):original.update(s,dt),
  advance:s=>isEasy(s)?advance(s):original.advance(s),
  beat:s=>isEasy(s)?{...frames[clamp(s.index,0,2)],index:clamp(s.index,0,2),number:clamp(s.index,0,2)+1,total:frames.length}:original.beat(s),
  draw:(c,s)=>isEasy(s)?draw(c,s):original.draw(c,s),
  anchor:s=>isEasy(s)?{x:235,y:62,width:390,tail:'right',speakerX:650,speakerY:293,safeBottom:224}:original.anchor(s),
  metadata:{...original.metadata,[KIND]:frames.map(frame=>({...frame}))}
 };
 window.Cinematics=api;
 window.EasyEnding=Object.freeze({kind:KIND,duration:total,frames,drawPacifier:pacifier});
})();
