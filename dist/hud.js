/* The boss bar is separate from the film; the ending keeps its own silence. */
(() => {
 'use strict';
 const shell=document.getElementById('gameShell'),hud=document.getElementById('bossHud'),ending=document.getElementById('chapterEndScreen'),endCanvas=document.getElementById('endingCanvas');
 if(!shell||!hud||!ending||!endCanvas)return;
 const fill=document.getElementById('bossHudFill'),meter=document.getElementById('bossHudMeter'),name=document.getElementById('bossHudName'),phase=document.getElementById('bossHudPhase'),value=document.getElementById('bossHudValue'),cue=document.getElementById('bossHudCue');
 const endContext=endCanvas.getContext('2d');let last=0,endAt=0,wasEnding=false,lastFilm='';
 const heading=hud.querySelector('.boss-hud-heading');heading?.append(value);
 phase.classList.add('boss-phase-pips');phase.setAttribute('role','img');
 let phaseCount=0,lastBossType='',lastPhase=0,phaseGlowTimer=0;
 function renderBossPhase(boss){
  const count=Math.max(1,Math.min(4,Math.floor(Number(boss.phaseCount)||3))),current=Math.max(1,Math.min(count,Math.floor(Number(boss.phase)||1)));
  if(count!==phaseCount){phaseCount=count;phase.replaceChildren();for(let n=1;n<=count;n++){const mark=document.createElement('i');mark.dataset.phase=String(n);mark.setAttribute('aria-hidden','true');phase.append(mark);}const caption=document.createElement('span');caption.className='boss-phase-caption';caption.setAttribute('aria-hidden','true');phase.append(caption);}
  phase.querySelector('.boss-phase-caption').textContent=current+'/'+count;
  phase.setAttribute('aria-label','Fase '+current+' de '+count);phase.title='Fase '+current+' de '+count;
  for(const pip of phase.querySelectorAll('i[data-phase]'))pip.classList.toggle('active',Number(pip.dataset.phase)<=current);
  hud.dataset.phase=String(current);hud.dataset.phaseCount=String(count);
  if(lastBossType===boss.type&&current>lastPhase){clearTimeout(phaseGlowTimer);hud.classList.remove('phase-up');void hud.offsetWidth;hud.classList.add('phase-up');phaseGlowTimer=setTimeout(()=>hud.classList.remove('phase-up'),800);}
  lastBossType=boss.type;lastPhase=current;
 }
 const statArt={
  vigor:'<path d="M24 4 40 10v12c0 11-7 18-16 23C15 40 8 33 8 22V10z" fill="#597c4e"/><path d="M24 4 40 10v12c0 11-7 18-16 23C15 40 8 33 8 22V10z" fill="none" stroke="#35553b" stroke-width="2.5"/><path d="M24 32 14 22c-5-7 4-14 10-7 6-7 15 0 10 7z" fill="#f6c486"/><path d="m15 13 7-3" stroke="#9dc18a" stroke-width="2"/>',
  forca:'<path d="m14 33 18-22 7 6-20 24-7 2z" fill="#9a5e33" stroke="#684126" stroke-width="2.5"/><path d="m8 12 8-7 21 17-8 10z" fill="#6d8490" stroke="#3e5663" stroke-width="2.5"/><path d="m12 12 4-3 15 12-4 3z" fill="#b5c4bd"/><path d="m9 41 8 3m17-5 6 2m-3-9 7-1" stroke="#d2a44e" stroke-width="2.5" stroke-linecap="round"/>',
  gas:'<path d="M16 10h16v5l5 6v20H11V21l5-6z" fill="#78975c" stroke="#455b37" stroke-width="2.5"/><path d="M18 4h12v7H18z" fill="#ddbc70" stroke="#8e7139" stroke-width="2"/><path d="m27 17-10 14h8l-3 10 12-16h-8z" fill="#ffe19b"/><path d="M15 20v14" stroke="#a8bd7a" stroke-width="2"/><path d="M7 17 3 14m38 3 4-3M5 29H1m42 0h4" stroke="#b59c59" stroke-width="2" stroke-linecap="round"/>',
  agilidade:'<path d="m20 6 13 3-2 21 11 5v8H12l-4-7 9-6z" fill="#a66c3f" stroke="#674629" stroke-width="2.5"/><path d="m20 7 13 3-1 6-13-3z" fill="#d6b15c"/><path d="M13 36h13l5-6m-17 9h24" fill="none" stroke="#e6c891" stroke-width="2.5"/><path d="m20 20 10 2m-11 4 10 2M4 17h9M2 23h10M5 29h5" stroke="#6c8748" stroke-width="2.5" stroke-linecap="round"/>'
 };
 const statsModal=document.getElementById('statsModal');
 function ranchStats(){
  if(!statsModal||statsModal.dataset.ranchReady)return;statsModal.dataset.ranchReady='true';
  const title=statsModal.querySelector('h2');if(title){const seed=document.createElement('span');seed.className='stats-title-sprig';seed.setAttribute('aria-hidden','true');seed.innerHTML='<svg viewBox="0 0 36 44"><path d="M18 41V9m0 24L8 24m10 0L28 15" fill="none" stroke="currentColor" stroke-width="3"/><path d="M18 12C6 14 5 5 7 2c9 0 13 4 11 10Zm0 14C5 28 3 21 5 16c9-1 14 4 13 10Zm1-7C31 21 34 12 31 8c-9 0-14 5-12 11Z" fill="currentColor"/></svg>';title.prepend(seed);}
  for(const stat of ['vigor','forca','gas','agilidade']){const number=document.getElementById('stat-'+stat),row=number?.parentElement,button=row?.querySelector('[data-spend-stat]');if(!row||!button)continue;
   row.classList.add('ranch-stat-row');row.dataset.stat=stat;row.querySelector('span')?.classList.add('ranch-stat-copy');
   const icon=document.createElement('span');icon.className='ranch-stat-icon';icon.setAttribute('aria-hidden','true');icon.innerHTML='<svg viewBox="0 0 48 48">'+statArt[stat]+'</svg>';row.prepend(icon);
   const growth=document.createElement('span');growth.className='ranch-stat-growth';growth.setAttribute('aria-hidden','true');growth.innerHTML='<i></i>';row.append(growth);
   button.classList.add('ranch-stat-up');button.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4v16M4 12h16" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="square"/></svg><small>UPAR</small>';button.title='Investir 1 ponto em '+({vigor:'Vigor',forca:'Força',gas:'Gás',agilidade:'Agilidade'})[stat];
  }
  const footer=document.createElement('p');footer.className='stats-ranch-note';footer.textContent='Cada ponto é semente. Cultive o seu jeito de vencer.';statsModal.querySelector('.primary-btn')?.before(footer);
 }
 function updateRanchStats(){const state=window.Progression?.getState?.();if(!state||!statsModal)return;statsModal.dataset.available=state.points>0?'true':'false';for(const stat of ['vigor','forca','gas','agilidade']){const row=statsModal.querySelector('[data-stat="'+stat+'"]'),level=Number(state.stats?.[stat])||0;row?.style.setProperty('--stat-growth',Math.min(100,level/40*100)+'%');row?.classList.toggle('at-cap',level>=40);}}
 ranchStats();updateRanchStats();window.addEventListener('progression-change',updateRanchStats);

 document.getElementById('endingMenuBtn').addEventListener('click',()=>window.Game?.returnToMenu?.());
 document.getElementById('endingExploreBtn').addEventListener('click',()=>window.Game?.continueExploring?.());
 document.getElementById('defeatStatsBtn')?.addEventListener('click',()=>document.getElementById('statsBtn')?.click());
 const sound=document.createElement('button');sound.type='button';sound.id='epilogueSoundBtn';sound.className='epilogue-sound';sound.setAttribute('aria-label','Ativar ou desativar som da cena');
 const sourceSound=document.getElementById('soundBtn');function updateSound(){const on=sourceSound?.getAttribute('aria-pressed')==='true';sound.textContent=on?'SOM LIGADO':'LIGAR SOM';sound.setAttribute('aria-pressed',String(on));}
 sound.addEventListener('click',()=>{sourceSound?.click();updateSound();});document.querySelector('.cinematic-buttons')?.append(sound);sourceSound?.addEventListener('click',updateSound);updateSound();
 const replay=document.createElement('button');replay.type='button';replay.id='replayEpilogueBtn';replay.className='text-button';replay.textContent='Rever o epílogo';replay.hidden=true;replay.addEventListener('click',()=>{window.Game?.resume?.();window.Game?.replayEpilogue?.();});document.querySelector('#pauseScreen .game-modal')?.append(replay);
 const pause=document.getElementById('pauseScreen');if(pause)new MutationObserver(()=>{if(!pause.hidden)replay.hidden=!window.Game?.getState?.().q?.jorgeSeen;}).observe(pause,{attributes:true,attributeFilter:['hidden']});
 function tick(now){
  if(now-last>=60){last=now;const hidden=shell.classList.contains('in-main-menu')||shell.classList.contains('is-cutscene')||shell.classList.contains('is-dialog')||shell.classList.contains('is-paused')||shell.classList.contains('is-chapter-ended');const boss=hidden?null:window.Game?.getBossStatus?.();hud.hidden=!boss;
   if(boss){const hp=Math.max(0,Number(boss.hp)||0),max=Math.max(1,Number(boss.phaseMaxHp)||Number(boss.max)||1),ratio=Math.max(0,Math.min(1,hp/max));hud.dataset.boss=boss.type;name.textContent=boss.name;renderBossPhase(boss);hud.dataset.state=String(boss.state||'');value.textContent=Math.ceil(hp)+' / '+Math.ceil(max);fill.style.transform='scaleX('+ratio+')';meter.setAttribute('aria-valuemax',String(Math.ceil(max)));meter.setAttribute('aria-valuenow',String(Math.ceil(hp)));meter.setAttribute('aria-valuetext',boss.name+': '+Math.ceil(hp)+' de '+Math.ceil(max)+' de vida');cue.textContent=({underground:'NO ESGOTO',windup:'PREPARANDO GOLPE',recover:'ABERTURA PARA ATACAR',dashing:'INVESTIDA',firing:'DESVIE!'})[boss.state]||'CHEFÃO';}
   const film=shell.classList.contains('is-epilogue')?'jorge':'';if(film!==lastFilm){lastFilm=film;const skip=document.getElementById('cutsceneSkipBtn');if(skip)skip.textContent=film?'Pular epílogo':'Pular história';window.GameView?.fit?.();}
  }
  const on=!ending.hidden;if(on&&!wasEnding){endAt=now;ending.classList.remove('show-options');window.GameView?.fit?.();}if(on){if(window.JorgeEpilogue?.drawEnd)JorgeEpilogue.drawEnd(endContext,8+(now-endAt)/1000);else{endContext.fillStyle='#030207';endContext.fillRect(0,0,960,540);}ending.classList.toggle('show-options',now-endAt>1800);}wasEnding=on;
  requestAnimationFrame(tick);
 }
 requestAnimationFrame(tick);
})();
