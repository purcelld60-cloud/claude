/* Analog movement pad, independent of the right-thumb action buttons. */
(() => {
'use strict';
const pad=document.getElementById('moveJoystick');if(!pad)return;
const knob=pad.querySelector('.joystick-knob');let pointer=null,cx=0,cy=0,radius=1;
function render(x=0,y=0){knob.style.transform=`translate(${x*radius}px,${y*radius}px)`;pad.classList.toggle('engaged',!!(Math.abs(x)+Math.abs(y)));pad.setAttribute('aria-valuenow',Math.round(x*100));}
function reset(send=true){const id=pointer;pointer=null;if(id!==null){try{if(pad.hasPointerCapture(id))pad.releasePointerCapture(id);}catch{}}render();if(send)window.Game?.setJoystick?.(0,0);}
function move(e){if(e.pointerId!==pointer)return;let x=(e.clientX-cx)/radius,y=(e.clientY-cy)/radius;const mag=Math.hypot(x,y);if(mag>1){x/=mag;y/=mag;}window.Game?.setJoystick?.(x,y);render(x,y);if(e.cancelable)e.preventDefault();}
pad.addEventListener('pointerdown',e=>{if(pointer!==null||e.pointerType==='mouse'&&e.button!==0)return;const s=window.Game?.getState();if(!s?.started||s.paused||s.dialog||s.training?.active||s.defeated||s.won||s.cutscene)return;if(e.cancelable)e.preventDefault();const rect=pad.getBoundingClientRect();cx=rect.left+rect.width/2;cy=rect.top+rect.height/2;radius=rect.width*.34;pointer=e.pointerId;try{pad.setPointerCapture(pointer);}catch{}move(e);});
pad.addEventListener('pointermove',move);
function end(e){if(e.pointerId===pointer)reset();}
for(const target of [pad,document,window])for(const type of ['pointerup','pointercancel','lostpointercapture'])target.addEventListener(type,end,true);
pad.addEventListener('touchstart',e=>{if(e.cancelable)e.preventDefault();},{passive:false});pad.addEventListener('touchmove',e=>{if(e.cancelable)e.preventDefault();},{passive:false});
window.addEventListener('game-input-reset',()=>reset(false));window.addEventListener('blur',()=>reset());window.addEventListener('pagehide',()=>reset());window.addEventListener('orientationchange',()=>reset());document.addEventListener('visibilitychange',()=>{if(document.hidden)reset();});
window.Joystick={reset:()=>reset(),getState:()=>({pointerId:pointer})};
})();
