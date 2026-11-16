/* Campaign time and difficulty history belong to the save, independently of practice. */
(() => {
 'use strict';
 const valid=mode=>['easy','normal','hard'].includes(mode),label=mode=>({easy:'FÁCIL',normal:'NORMAL',hard:'DIFÍCIL'})[mode]||'NORMAL';
 let run=null,suspended=false,lastAt=null,active=false,lastRender=0,restoring=false;
 const stamp=()=>performance.now(),finite=(value,fallback=0)=>Number.isFinite(Number(value))?Number(value):fallback;
 const copy=value=>value?JSON.parse(JSON.stringify(value)):null;
 const emit=reason=>{try{window.dispatchEvent(new CustomEvent('campaign-run-change',{detail:{reason,state:getState()}}));}catch{}};
 function tick(now=stamp(),nextActive=active){
  now=finite(now,stamp());
  if(lastAt!==null&&active&&!suspended&&run&&!run.finished){const delta=Math.max(0,now-lastAt);run.elapsedMs+=delta;run.modeTime[run.mode]=(run.modeTime[run.mode]||0)+delta;}
  lastAt=now;active=!!nextActive&&!suspended&&!!run&&!run.finished;
  if(now-lastRender>250){lastRender=now;render();}
  return run?run.elapsedMs:0;
 }
 function assignMode(mode){
  restoring=true;
  try{window.Difficulty?.setMode?.(mode);}finally{restoring=false;}
 }
 function begin(data=null,options={}){
  suspended=false;active=false;lastAt=stamp();
  const mode=valid(data?.mode)?data.mode:valid(options.mode)?options.mode:'normal';
  if(data?.schema===1){
   const used=Array.isArray(data.modesUsed)?[...new Set(data.modesUsed.filter(valid))]:[mode];
   run={schema:1,elapsedMs:Math.max(0,finite(data.elapsedMs)),mode,easyLocked:!!data.easyLocked||mode==='easy'||used.includes('easy'),modesUsed:used.length?used:[mode],history:(Array.isArray(data.history)?data.history:[]).filter(e=>e&&valid(e.mode)&&Number.isFinite(e.atMs)).slice(-40).map(e=>({mode:e.mode,atMs:Math.max(0,e.atMs)})),modeTime:{easy:Math.max(0,finite(data.modeTime?.easy)),normal:Math.max(0,finite(data.modeTime?.normal)),hard:Math.max(0,finite(data.modeTime?.hard))},partial:!!data.partial,finished:!!data.finished,initialChoicePending:!!data.initialChoicePending,result:data.result&&typeof data.result==='object'?copy(data.result):null};
   if(run.easyLocked)run.mode='easy';
   if(!run.history.length)run.history=[{mode:run.mode,atMs:0}];
  }else run={schema:1,elapsedMs:0,mode,easyLocked:mode==='easy',modesUsed:[mode],history:[{mode,atMs:0}],modeTime:{easy:0,normal:0,hard:0},partial:!!options.legacy,finished:false,initialChoicePending:!!options.initialChoicePending,result:null};
  assignMode(run.mode);
  if(options.completed&&!run.finished)finish();
  render();return getState();
 }
 function start(){return begin(null,{mode:'normal',initialChoicePending:true});}
 function restore(data,options={}){return begin(data,{...options,initialChoicePending:false});}
 function confirmInitialMode(){if(run)run.initialChoicePending=false;}
 function canSetMode(next){return valid(next)&&(!run||suspended||!run.easyLocked||next==='easy'||restoring);}
 function changeMode(next){
  if(restoring||suspended||!run||!valid(next)||next===run.mode)return;
  tick(stamp(),active);const previous=run.mode;run.mode=next;
  if(next==='easy')run.easyLocked=true;
  if(!run.finished){
   if(run.initialChoicePending){run.modesUsed=[next];run.history=[{mode:next,atMs:0}];run.modeTime={easy:0,normal:0,hard:0};run.modeTime[next]=run.elapsedMs;}
   else{if(!run.modesUsed.includes(next))run.modesUsed.push(next);run.history.push({mode:next,atMs:run.elapsedMs});run.history=run.history.slice(-40);}
  }
  emit('difficulty');render();return previous;
 }
 function modeSummary(){
  if(!run)return {mode:'normal',modeLabel:'NORMAL',mixed:false};
  const used=run.modesUsed,mode=used.includes('easy')?'easy':used.includes('normal')?'normal':'hard';
  return{mode,modeLabel:used.length>1?'MISTO · '+used.map(label).join(' / '):label(mode),mixed:used.length>1};
 }
 function finish(){
  if(!run||suspended)return null;if(run.finished)return copy(run.result);
  tick(stamp(),false);run.initialChoicePending=false;run.finished=true;
  run.result={schema:1,elapsedMs:Math.round(run.elapsedMs),...modeSummary(),partial:run.partial,modesUsed:[...run.modesUsed],modeTime:{...run.modeTime}};
  emit('finish');render();return copy(run.result);
 }
 function setSuspended(value){tick(stamp(),false);suspended=!!value;active=false;lastAt=stamp();render();}
 function serialize(){if(!run)return null;tick(stamp(),active);return copy(run);}
 function getState(){const summary=modeSummary();return run?{...copy(run),suspended,active:active&&!suspended,categoryMode:summary.mode,modeLabel:summary.modeLabel,mixed:summary.mixed}:null;}
 function getResult(){return copy(run?.result);}
 function format(ms){const seconds=Math.floor(Math.max(0,finite(ms))/1000),hours=Math.floor(seconds/3600);return(hours?String(hours).padStart(2,'0')+':':'')+String(Math.floor(seconds/60)%60).padStart(2,'0')+':'+String(seconds%60).padStart(2,'0');}
 function render(){
  if(typeof document==='undefined')return;const end=document.getElementById('chapterEndScreen'),pause=document.querySelector('#pauseScreen .rp-body')||document.querySelector('#pauseScreen .ranch-pause-body')||document.querySelector('#pauseScreen .game-modal');
  if(end&&!document.getElementById('campaignRunResult')){const card=document.createElement('section');card.id='campaignRunResult';card.className='campaign-run-result';card.setAttribute('aria-label','Tempo e dificuldade da campanha');card.innerHTML='<span>TEMPO DE CAMPANHA</span><strong></strong><b></b><small></small>';end.append(card);}
  if(pause&&!document.getElementById('campaignRunPause')){const card=document.createElement('div');card.id='campaignRunPause';card.className='campaign-run-pause';card.innerHTML='<span>⏱ TEMPO ATIVO</span><b></b><small></small>';pause.append(card);}
  const result=run?.result,card=document.getElementById('campaignRunResult');if(card){card.hidden=!result;if(result){card.dataset.mode=result.mode;card.querySelector('strong').textContent=format(result.elapsedMs);card.querySelector('b').textContent=result.modeLabel;card.querySelector('small').textContent=result.partial?'SAVE ANTERIOR · TEMPO PARCIAL DESDE A ATUALIZAÇÃO':result.mode==='easy'?'PRÊMIO: CHUPETA · GUGU DADA':'ATÉ A DERROTA DE NIKOLAS · PAUSAS DESCONTADAS';}}
  const timer=document.getElementById('campaignRunPause');if(timer){timer.hidden=!run||suspended;timer.querySelector('b').textContent=run?format(run.elapsedMs):'';timer.querySelector('small').textContent=run?(run.partial?'Tempo parcial · save anterior':run.finished?'Campanha concluída':modeSummary().modeLabel)+(run.easyLocked?' · Fácil travado neste save':''):'';}
 }
 window.addEventListener('difficulty-change',event=>changeMode(event.detail?.mode));
 window.addEventListener('chapter-ended',render);
 if(typeof document!=='undefined')document.addEventListener('visibilitychange',()=>tick(stamp(),false));
 window.CampaignRun=Object.freeze({start,restore,tick,setActive:value=>tick(stamp(),value),setSuspended,confirmInitialMode,canSetMode,isEasyLocked:()=>!!run?.easyLocked&&!suspended,serialize,getState,getResult,finish,format,render});
})();
