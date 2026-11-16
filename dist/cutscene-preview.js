/* Seekable soundtrack previews rendered by the campaign's actual film engine. */
(() => {
 'use strict';
 const W=960,H=540,clamp=(value,min,max)=>Math.max(min,Math.min(max,value));
 const clean=id=>String(id||'').replace(/^(?:cutscenes|events)\./,'');
 function get(id){
  const kind=clean(id),timing=kind==='ollyan_flight'?window.OllyanEncounter?.previewTimeline?.():window.Cinematics?.timeline?.(kind);
  if(!timing)return null;
  const label=window.MusicCutscenes?.find(scene=>scene.id===kind)?.label||kind;
  return Object.freeze({...timing,contextId:'cutscenes.'+kind,label});
 }
 function list(){
  const known=Object.keys(window.Cinematics?.metadata||{});if(window.OllyanEncounter?.previewTimeline)known.push('ollyan_flight');const ordered=window.MusicCutscenes?.map(scene=>scene.id)||known;
  return Object.freeze(ordered.filter(kind=>known.includes(kind)).map(get).filter(Boolean));
 }
 function duration(id){return get(id)?.duration||0;}
 function stateAt(id,seconds=0,options={}){
  const kind=clean(id);if(kind!=='ollyan_flight')return window.Cinematics?.stateAt?.(kind,seconds,options)||null;
  const info=get(kind);if(!info)return null;const elapsed=clamp(Number(seconds)||0,0,info.duration);let index=info.shots.findIndex((shot,i)=>elapsed<(info.shots[i+1]?.start??info.duration));if(index<0)index=Math.max(0,info.shots.length-1);
  return {kind,index,time:elapsed-(info.shots[index]?.start||0),elapsed,done:elapsed>=info.duration,options:{...options}};
 }
 function rounded(c,x,y,w,h,r){
  c.beginPath();c.moveTo(x+r,y);c.lineTo(x+w-r,y);c.quadraticCurveTo(x+w,y,x+w,y+r);c.lineTo(x+w,y+h-r);c.quadraticCurveTo(x+w,y+h,x+w-r,y+h);c.lineTo(x+r,y+h);c.quadraticCurveTo(x,y+h,x,y+h-r);c.lineTo(x,y+r);c.quadraticCurveTo(x,y,x+r,y);c.closePath();
 }
 function wrapped(c,value,width){
  const lines=[];let current='';
  for(const word of String(value||'').split(/\s+/)){const next=current?current+' '+word:word;if(current&&c.measureText(next).width>width){lines.push(current);current=word;}else current=next;}
  if(current)lines.push(current);return lines;
 }
 function speech(c,state){
  const beat=window.Cinematics.beat(state);if(!beat||beat.cinematic)return;
  const anchor=window.Cinematics.anchor(state),width=anchor.width||410,left=clamp(anchor.x-width/2,16,W-width-16),top=clamp(anchor.y||65,42,190);
  c.save();c.font='17px Arial,sans-serif';const lines=wrapped(c,beat.text,width-32),height=49+lines.length*22,tail=clamp((anchor.speakerX||left+width/2)-left,26,width-26);
  c.shadowColor='#11251977';c.shadowBlur=0;c.shadowOffsetX=3;c.shadowOffsetY=4;c.fillStyle='#fff5dc';c.strokeStyle='#263f32';c.lineWidth=2;
  rounded(c,left,top,width,height,10);c.fill();c.stroke();
  c.shadowOffsetX=0;c.shadowOffsetY=0;c.beginPath();c.moveTo(left+tail-10,top+height-1);c.lineTo(left+tail+2,top+height+15);c.lineTo(left+tail+13,top+height-1);c.fill();c.stroke();
  c.fillStyle='#376442';c.font='bold 13px Arial,sans-serif';c.textBaseline='top';c.textAlign='left';c.fillText(String(beat.speaker||'').toUpperCase(),left+16,top+13);
  c.fillStyle='#26382e';c.font='17px Arial,sans-serif';lines.forEach((line,index)=>c.fillText(line,left+16,top+36+index*22));c.restore();
 }
 function render(canvas,id,seconds=0,options={}){
  if(!canvas||typeof canvas.getContext!=='function')return null;
  const state=stateAt(id,seconds,options),info=get(id),c=canvas.getContext('2d');if(!state||!info||!c)return null;
  const width=canvas.width||W,height=canvas.height||H,scale=Math.min(width/W,height/H),x=(width-W*scale)/2,y=(height-H*scale)/2;
  c.save();c.setTransform(1,0,0,1,0,0);c.fillStyle='#050a0a';c.fillRect(0,0,width,height);c.translate(x,y);c.scale(scale,scale);c.imageSmoothingEnabled=false;
  if(state.kind==='ollyan_flight')window.OllyanEncounter.drawIntro(c,clamp(Number(seconds)||0,0,info.duration),options);else{window.Cinematics.draw(c,state);if(options.dialogue!==false)speech(c,state);}c.restore();
  const shot=info.shots[state.index];return Object.freeze({id:info.id,contextId:info.contextId,time:clamp(Number(seconds)||0,0,info.duration),duration:info.duration,index:state.index,shot,done:state.done});
 }
 window.CutscenePreview=Object.freeze({version:1,list,get,duration,stateAt,render});
})();
