/* Cartoon balloons positioned in the empty sky, outside the actors' action area. */
(() => {
'use strict';const viewport=document.getElementById('gameViewport'),canvas=document.getElementById('gameCanvas'),normal=document.getElementById('dialogBox'),film=document.querySelector('.cinematic-caption');if(!viewport||!canvas||!normal)return;
let controls=document.getElementById('dialogControls');
if(!controls){controls=document.createElement('div');controls.id='dialogControls';controls.className='speech-controls';controls.hidden=true;viewport.append(controls);}
let next=document.getElementById('dialogNext');
if(!next){next=document.createElement('button');next.id='dialogNext';next.className='primary-btn';next.textContent='Próximo';controls.append(next);}
next.type='button';next.setAttribute('aria-label','Avançar ou concluir a conversa');
const close=document.createElement('button');close.id='dialogClose';close.type='button';close.className='dialog-close';close.textContent='Fechar · Esc';close.setAttribute('aria-label','Fechar a conversa sem confirmar ações');controls.prepend(close);
const style=document.createElement('style');style.id='dialogue-controls-style';style.textContent=`
#gameShell #dialogControls{gap:8px;right:max(12px,env(safe-area-inset-right));bottom:max(8px,env(safe-area-inset-bottom));max-width:calc(100% - 24px);flex-wrap:nowrap;z-index:39}
#gameShell #dialogControls button{min-width:0;min-height:42px;max-width:100%;touch-action:manipulation;user-select:none;-webkit-user-select:none}
#gameShell #dialogControls #dialogClose{min-width:88px;padding:5px 10px;background:#e7ddbc;color:#796142;border-color:#9a8059;font:10px Space,Arial,sans-serif}
#gameShell #dialogControls #dialogNext{min-width:min(180px,calc(100vw - 140px));max-width:calc(100vw - 140px);padding:5px 12px;white-space:normal;text-align:center;font-size:8px;line-height:1.5}
@media(orientation:landscape) and (max-height:360px){#gameShell #dialogControls button{min-height:38px}#gameShell #dialogControls #dialogNext{font-size:7px}}
`;document.head.append(style);
// Finish the tap on the original button before replacing the dialogue with the
// next screen. Otherwise a synthesized click can land on its newly exposed controls.
function bindControl(button,activate){
  button.addEventListener('touchend',event=>{
    if(!event.cancelable)return;
    event.preventDefault();
    const touch=event.changedTouches[0];
    if(!event.touches.length&&touch&&button.contains(document.elementFromPoint(touch.clientX,touch.clientY)))activate();
  },{passive:false});
  button.addEventListener('click',event=>{event.preventDefault();activate();});
  button.addEventListener('contextmenu',event=>event.preventDefault());
}
bindControl(next,()=>window.Game?.advanceDialogue?.());bindControl(close,()=>window.Game?.closeDialogue?.(false));
let prior='';const clamp=(x,a,b)=>Math.max(a,Math.min(b,x));
function bounds(){const v=viewport.getBoundingClientRect(),r=canvas.getBoundingClientRect(),contain=getComputedStyle(canvas).objectFit==='contain',scale=contain?Math.min(r.width/960,r.height/540):r.width/960,w=960*scale,h=540*scale;return{v,scale,ox:r.left-v.left+(r.width-w)/2,oy:r.top-v.top+(r.height-h)/2};}
function position(el,anchor,cinematic){
 const b=bounds(),vw=b.v.width,vh=b.v.height;
 const leftGutter=Math.max(0,b.ox),rightGutter=Math.max(0,vw-b.ox-960*b.scale);
 const onLeft=(anchor.x??480)<480,gutter=onLeft?leftGutter:rightGutter;
 // Short landscape screens have roomy side margins. Use those for the balloon
 // so even the tallest boss keeps its face and animation completely visible.
 const sideBalloon=cinematic&&vh<280&&gutter>=200;
 const wanted=(anchor.width||380)*b.scale;
 const width=sideBalloon?Math.min(230,gutter-18):clamp(wanted,Math.min(210,vw-24),Math.min(370,vw*.67));
 el.dataset.placement=sideBalloon?(onLeft?'gutter-left':'gutter-right'):'sky';
 el.style.width=Math.round(width)+'px';el.style.maxWidth='calc(100% - 24px)';
 el.style.left='0px';el.style.top='0px';el.style.bottom='auto';el.style.right='auto';
 const h=el.getBoundingClientRect().height;
 let x=sideBalloon?(onLeft?leftGutter/2:vw-rightGutter/2):b.ox+(anchor.x??480)*b.scale;
 let y=cinematic?b.oy+(anchor.y??65)*b.scale:b.oy+(anchor.y??330)*b.scale-h-18;
 const header=cinematic?document.querySelector('.cinematic-heading')?.getBoundingClientRect().height||20:0;
 const controlsSpace=cinematic?47:Math.max(47,controls.getBoundingClientRect().height+22);
 if(cinematic&&b.oy>30)y=Math.max(header+22,b.oy-h-12);
 y=clamp(y,cinematic?header+18:10,Math.max(12,vh-h-controlsSpace));
 x=clamp(x,8+width/2,vw-8-width/2);
 el.style.left=Math.round(x-width/2)+'px';el.style.top=Math.round(y)+'px';
 const speakerX=b.ox+(anchor.speakerX??anchor.x??480)*b.scale;
 const speakerY=b.oy+(anchor.speakerY??300)*b.scale;
 el.style.setProperty('--tail-left',Math.round(clamp(speakerX-(x-width/2),20,width-20))+'px');
 el.style.setProperty('--tail-top',Math.round(clamp(speakerY-y,20,h-20))+'px');
 el.dataset.tail=anchor.tail||(speakerX<x?'left':'right');el.dataset.speaker=anchor.type||anchor.speaker||'';
}
function tick(){const state=window.Game?.getDialogueView?.()||window.Game?.getState?.();if(state){const active=!!state.dialog&&!state.paused&&!state.cutscene;normal.hidden=!active;controls.hidden=!active;if(active){const a=window.Game.getDialogueAnchor?.()||{x:480,y:300,speakerX:480};position(normal,a,false);}if(film&&state.cutscene&&!state.paused){const a=window.Cinematics?.anchor?.(state.cutscene)||{x:300,y:65,width:400,speakerX:300};position(film,a,true);}const key=(active?'d':'')+(state.cutscene&&!state.paused?'c':'');if(key!==prior){prior=key;viewport.classList.toggle('has-speech',!!key);}}else{normal.hidden=true;controls.hidden=true;}requestAnimationFrame(tick);}requestAnimationFrame(tick);
})();
