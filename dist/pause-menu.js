/* A little roadside stop: pause settings and post-campaign boss practice. */
(() => {
 'use strict';
 const shell=document.getElementById('gameShell'),screen=document.getElementById('pauseScreen');
 const modal=screen?.querySelector('.game-modal');
 if(!shell||!screen||!modal)return;
 const UNLOCK_KEY='daroca-sandbox-v1',SAVE_KEY='da-roca-adventure-v1';
 const bosses=Object.freeze([
  {id:'igor',art:'igor',name:'Igor',subtitle:'O fiscal do lanche',stage:'Colégio Adventista',phases:3},
  {id:'kaique',art:'kaique',name:'Kaique',subtitle:'Volta pra sala, véi!',stage:'Colégio Adventista',phases:3},
  {id:'arthur',art:'arthur',name:'Arthur',subtitle:'O poder do tapa',stage:'Pátio da escola',phases:3},
  {id:'dede',art:'dede',name:'Dedé',subtitle:'SEU GILÓ HOMI!',stage:'Beco da fumaça',phases:3},
  {id:'freddy',art:'freddy',name:'Freddy',subtitle:'OPEESTY DA ROÇA!',stage:'Favela do Reeis',phases:3},
  {id:'reeisBoss',art:'reeis',name:'REEEIS',subtitle:'O rei da favela',stage:'Morro do Rei',phases:3},
  {id:'marco',art:'marco',name:'Marco',subtitle:'O caderno do caos',stage:'Pátio dos rabiscos',phases:3},
  {id:'giant',art:'giant',name:'Colosso 67',subtitle:'SIX SEVEN!',stage:'Mundo de papel',phases:1},
  {id:'nicolas',art:'nicolas',name:'Nicolas Carvalho',subtitle:'A aura suprema',stage:'Praça Camacan',phases:3},
  {id:'menezes',art:'menezes',name:'Menezes',subtitle:'Rei dos ratos',stage:'Esgoto da provocação',phases:3},
  {id:'ollyan',art:'ollyan',name:'Ollyan',subtitle:'Orelhas ao vento',stage:'Céu do baile',phases:3},
  {id:'nikolas',art:'nikolas',name:'Nikolas Arroganti',subtitle:'O titã do catarro',stage:'A última fatia',phases:4}
 ].map(row=>Object.freeze(row)));
 const modes=[['easy','FÁCIL','Mais fôlego'],['normal','NORMAL','A receita original'],['hard','DIFÍCIL','Sem colher de chá']];
 const icons={
  resume:'<path d="M10 6v20l17-10z" fill="currentColor"/>',
  controls:'<path d="M7 9h18l4 15-5 2-5-6h-6l-5 6-5-2z" fill="none" stroke="currentColor" stroke-width="2"/><path d="M11 12v8m-4-4h8m8-2h2m-4 5h2" stroke="currentColor" stroke-width="2"/>',
  sandbox:'<path d="m7 5 17 19m1-19L8 24M5 20l7 8m8 0 7-8" fill="none" stroke="currentColor" stroke-width="3"/><path d="m7 5 1 7 5-4m12-3-1 7-5-4" fill="currentColor"/>',
  sound:'<path d="M7 12h5l8-6v20l-8-6H7z" fill="currentColor"/><path d="M23 11q7 5 0 10m2-14q12 9 0 18" fill="none" stroke="currentColor" stroke-width="2"/>',
  exit:'<path d="M15 5H6v22h9m1-11h13m-6-6 6 6-6 6" fill="none" stroke="currentColor" stroke-width="2.5"/>',
  book:'<path d="M3 6h10l3 3 3-3h10v20H19l-3 3-3-3H3z" fill="none" stroke="currentColor" stroke-width="2"/><path d="M16 10v16M7 12h5m-5 5h5m8-5h5m-5 5h5" stroke="currentColor" stroke-width="2"/>',
  story:'<path d="M5 4h22v24H5zM5 10h22M10 4v6m12-6v6" fill="none" stroke="currentColor" stroke-width="2"/><path d="m13 14 8 5-8 5z" fill="currentColor"/>'
 };
 function icon(name){return '<svg viewBox="0 0 32 32" aria-hidden="true">'+(icons[name]||icons.book)+'</svg>';}
 function gameState(){try{return window.Game?.getState?.()||{};}catch{return {};}}
 function unlock(){try{localStorage.setItem(UNLOCK_KEY,'1');}catch{}return true;}
 function isSandboxUnlocked(){
  if(gameState().q?.jorgeSeen)return unlock();
  try{
   if(localStorage.getItem(UNLOCK_KEY)==='1')return true;
   const saved=JSON.parse(localStorage.getItem(SAVE_KEY)||'null');
   if(saved?.q?.jorgeSeen)return unlock();
  }catch{}
  return false;
 }
 function makeButton(id,title,description,kind,handler){
  const button=document.createElement('button');button.id=id;button.type='button';button.className='rp-action';
  button.innerHTML=icon(kind)+'<span><b></b><small></small></span><i aria-hidden="true">›</i>';
  button.querySelector('b').textContent=title;button.querySelector('small').textContent=description;
  if(handler)button.addEventListener('click',handler);
  return button;
 }
 function labelButton(button,title,description,kind){
  if(!button)return null;
  button.classList.add('rp-action');button.innerHTML=icon(kind)+'<span><b></b><small></small></span><i aria-hidden="true">›</i>';
  button.querySelector('b').textContent=title;button.querySelector('small').textContent=description;
  return button;
 }
 function difficultyPicker(id){
  const field=document.createElement('fieldset');field.className='rp-difficulty';
  const legend=document.createElement('legend');legend.textContent='QUAL É O TAMANHO DA RESENHA?';field.append(legend);
  const row=document.createElement('div');row.className='rp-difficulty-row';field.append(row);
  for(const [mode,name,subtitle]of modes){
   const button=document.createElement('button');button.type='button';button.dataset.rpDifficulty=mode;
   button.innerHTML='<span aria-hidden="true">'+(mode==='easy'?'♧':mode==='hard'?'⚡':'✦')+'</span><b>'+name+'</b><small>'+subtitle+'</small>';
   button.addEventListener('click',()=>{window.Difficulty?.setMode?.(mode);render();});row.append(button);
  }
  const description=document.createElement('p');description.id=id;description.className='rp-mode-description';description.setAttribute('aria-live','polite');field.append(description);
  return field;
 }
 // Preserve the original nodes so their game and accessibility listeners survive.
 const resume=document.getElementById('resumeBtn'),story=document.getElementById('replayIntroBtn');
 const book=document.getElementById('pauseInfoBtn'),home=document.getElementById('mainMenuBtn');
 const oldHelp=modal.querySelector('[data-open-help]');
 const extraButtons=[...modal.querySelectorAll('button')].filter(button=>![resume,story,book,home,oldHelp].includes(button));
 modal.classList.add('ranch-pause');modal.setAttribute('aria-labelledby','ranchPauseTitle');
 const heading=document.createElement('header');heading.className='rp-header';
 heading.innerHTML='<div class="rp-sky" aria-hidden="true"><i class="rp-sun"></i><i class="rp-cloud"></i><i class="rp-hill"></i><i class="rp-barn"></i><i class="rp-fence"></i><i class="rp-sprig"></i></div><span class="rp-eyebrow">PARADA NA VARANDA</span><h2 id="ranchPauseTitle">SEGURA O GÁS.</h2><p id="ranchPauseLocation">A resenha pode esperar um cadinho.</p>';
 const body=document.createElement('div');body.className='rp-body';
 const resultBanner=document.createElement('p');resultBanner.id='ranchSandboxResult';resultBanner.className='rp-sandbox-result';resultBanner.setAttribute('role','status');resultBanner.hidden=true;
 const mainActions=document.createElement('div');mainActions.className='rp-main-actions';
 if(resume)mainActions.append(labelButton(resume,'CONTINUAR','O bolo não vai se recuperar sozinho.','resume'));
 const controls=makeButton('ranchControlsBtn','CONTROLES','Teclas, resposta e joystick.','controls',()=>{
  if(window.ControlSettingsUI?.open)window.ControlSettingsUI.open();else if(window.ControlSettingsPanel?.open)window.ControlSettingsPanel.open();else window.GameView?.openHelp?.();
 });
 mainActions.append(controls);
 const audio=makeButton('ranchAudioBtn','SOM DA ROÇA','Músicas e efeitos do jogo.','sound',()=>{document.getElementById('soundBtn')?.click();render();});mainActions.append(audio);
 const gfx=makeButton('ranchGraphicsBtn','QUALIDADE: '+(window.Graphics?.label?.()||'MÉDIA'),window.Graphics?.describe?.()||'Cenário vivo, luz e partículas.','controls',()=>{window.Graphics?.toggle?.();gfx.querySelector('b').textContent='QUALIDADE: '+window.Graphics.label();gfx.querySelector('small').textContent=window.Graphics.describe();});mainActions.append(gfx);window.Graphics?.onChange?.(()=>{gfx.querySelector('b').textContent='QUALIDADE: '+window.Graphics.label();gfx.querySelector('small').textContent=window.Graphics.describe();});
 if(window.Weather){const wx=makeButton('ranchWeatherBtn','CLIMA: '+window.Weather.label(),window.Weather.describe(),'controls',()=>{window.Weather.next();wx.querySelector('b').textContent='CLIMA: '+window.Weather.label();wx.querySelector('small').textContent=window.Weather.describe();});mainActions.append(wx);}
 if(window.DayTime){const day=makeButton('ranchDayTimeBtn','HORA DO DIA: '+window.DayTime.label(),window.DayTime.describe(),'controls',()=>{window.DayTime.next();day.querySelector('b').textContent='HORA DO DIA: '+window.DayTime.label();day.querySelector('small').textContent=window.DayTime.describe();});mainActions.append(day);}
 const sandboxButton=makeButton('ranchSandboxBtn','TERREIRO DOS CHEFES','Sandbox: escolha uma revanche.','sandbox',()=>openSandbox());mainActions.append(sandboxButton);
 const retryButton=makeButton('ranchRetrySandboxBtn','TENTAR DE NOVO','Reinicie esta revanche com vida cheia.','sandbox',()=>{const state=gameState();if(window.Game?.retrySandboxBoss)window.Game.retrySandboxBoss();else if(state.sandbox?.type)window.Game?.startSandboxBoss?.(state.sandbox.type);render();});retryButton.hidden=true;mainActions.append(retryButton);
 const returnButton=makeButton('ranchExitSandboxBtn','VOLTAR À CAMPANHA','Encerre o treino e recupere sua aventura.','exit',()=>{window.Game?.exitSandbox?.();render();});returnButton.hidden=true;mainActions.append(returnButton);
 const difficulty=difficultyPicker('ranchDifficultyDescription');
 const note=document.createElement('p');note.id='ranchDifficultyNote';note.className='rp-note';
 const utility=document.createElement('div');utility.className='rp-utility';
 if(book)utility.append(labelButton(book,'DIÁRIO E TURMA','Missões, personagens e instalação.','book'));
 else utility.append(makeButton('ranchBookBtn','DIÁRIO E TURMA','Missões, personagens e instalação.','book',()=>window.AdventureMenu?.openInfo?.()));
 if(story)utility.append(labelButton(story,'REVER A HISTÓRIA','A amizade antes da última fatia.','story'));
 if(home)utility.append(labelButton(home,'MENU PRINCIPAL','Seu progresso continua guardado.','exit'));
 else utility.append(makeButton('ranchHomeBtn','MENU PRINCIPAL','Seu progresso continua guardado.','exit',()=>window.Game?.returnToMenu?.()));
 utility.append(makeButton('ranchArenaBtn','ARENA ONLINE','Crie uma sala pelo celular.','sandbox',()=>window.Arena?.open?.()));
 function preserveExtra(button){
  const isCoop=button.id==='pauseCoopBtn',title=isCoop?'DUPLA LOCAL':button.textContent.trim();
  utility.append(labelButton(button,title,isCoop?'O modo clássico de rede local.':'Mais uma parada da resenha.','controls'));
 }
 extraButtons.forEach(preserveExtra);
 const footer=document.createElement('footer');footer.className='rp-footer';footer.innerHTML='<span aria-hidden="true">✦</span> CULTIVE O SHAPE. COLHA A VITÓRIA. <span aria-hidden="true">✦</span>';
 body.append(resultBanner,mainActions,difficulty,note,utility);modal.replaceChildren(heading,body,footer);
 // Optional modes may attach their pause entry after this script has loaded.
 new MutationObserver(records=>{for(const record of records)for(const node of record.addedNodes)if(node.nodeType===1&&node.tagName==='BUTTON')preserveExtra(node);}).observe(modal,{childList:true});
 // The help node is kept as an accessible fallback without duplicating the controls action.
 if(oldHelp){oldHelp.hidden=true;body.append(oldHelp);}
 const sandbox=document.createElement('dialog');sandbox.id='ranchSandboxDialog';sandbox.className='ranch-sandbox';sandbox.setAttribute('aria-labelledby','ranchSandboxTitle');
 sandbox.innerHTML='<header class="rs-heading"><div><span class="rp-eyebrow">O BOLO VOLTOU. A REVANCHE TAMBÉM.</span><h2 id="ranchSandboxTitle">TERREIRO DOS CHEFES</h2></div><button type="button" id="ranchSandboxClose" aria-label="Fechar seleção de chefes">×</button></header><p class="rs-intro">Escolha um chefe e vá direto para a luta. Seu nível e suas habilidades acompanham você; missões, experiência e inventário da campanha ficam guardados.</p><div class="rs-top"><span id="ranchSandboxDifficulty"></span><span>SOLO · TREINO LIVRE</span></div><div class="rs-bosses" id="ranchSandboxBosses"></div><p class="rs-feedback" id="ranchSandboxFeedback" role="status"></p><footer class="rs-footer"><span>12 REVANCHES. UM CHAPÉU. NENHUMA DESCULPA.</span><button type="button" id="ranchSandboxBack">VOLTAR À VARANDA</button></footer>';
 shell.append(sandbox);
 const bossGrid=sandbox.querySelector('#ranchSandboxBosses');
 for(const boss of bosses){
  const button=document.createElement('button');button.type='button';button.className='rs-boss';button.dataset.sandboxBoss=boss.id;
  button.innerHTML='<span class="rs-portrait"><canvas width="128" height="112" aria-hidden="true"></canvas><i>'+(boss.phases===1?'67':boss.phases+' FASES')+'</i></span><span class="rs-copy"><small></small><b></b><span></span></span><span class="rs-challenge" aria-hidden="true">DESAFIAR →</span>';
  button.querySelector('.rs-copy small').textContent=boss.stage;button.querySelector('.rs-copy b').textContent=boss.name;button.querySelector('.rs-copy span').textContent=boss.subtitle;
  button.setAttribute('aria-label','Enfrentar '+boss.name+' no sandbox');button.addEventListener('click',()=>chooseBoss(boss.id));bossGrid.append(button);
 }
 let resumeAfterSandbox=false,previousFocus=null;
 function drawPortraits(){
  if(!window.Art?.drawCharacter)return;
  for(const boss of bosses){
   const canvas=bossGrid.querySelector('[data-sandbox-boss="'+boss.id+'"] canvas'),ctx=canvas.getContext('2d');
   ctx.imageSmoothingEnabled=false;ctx.clearRect(0,0,128,112);
   ctx.fillStyle=boss.id==='nikolas'?'#5c3854':boss.id==='menezes'?'#5b5660':boss.id==='marco'?'#564772':'#425d54';ctx.fillRect(0,0,128,112);
   ctx.fillStyle='#f2dba511';for(let i=0;i<12;i++)ctx.fillRect((i*37)%128,(i*19)%112,3,3);
   ctx.fillStyle='#182c2970';ctx.fillRect(25,100,78,6);
   window.Art.drawCharacter(ctx,boss.art,64,106,{facing:1,frame:0,scale:boss.id==='giant'?.43:boss.id==='reeisBoss'?.80:.94});
  }
 }
 function closeSandbox(){if(sandbox.open)sandbox.close();}
 function openSandbox(){
  if(!isSandboxUnlocked())return false;
  if(sandbox.open)return true;
  previousFocus=document.activeElement;const state=gameState();resumeAfterSandbox=!!(state.started&&!state.paused&&!state.won&&!state.defeated&&!state.chapterEnded);
  window.Game?.releaseInputs?.();if(resumeAfterSandbox)window.Game?.pause?.();
  sandbox.querySelector('#ranchSandboxFeedback').textContent='';render();drawPortraits();sandbox.showModal();
  sandbox.querySelector('#ranchSandboxClose').focus();return true;
 }
 function chooseBoss(type){
  if(!isSandboxUnlocked())return;
  if(typeof window.Game?.startSandboxBoss!=='function'){
   sandbox.querySelector('#ranchSandboxFeedback').textContent='A arena ainda está carregando. Tente novamente em um instante.';return;
  }
  const wasResume=resumeAfterSandbox;resumeAfterSandbox=false;
  // Close first: gameplay cannot take keyboard input while a native dialog is open.
  sandbox.close();
  const result=window.Game.startSandboxBoss(type);
  if(result===false||result?.ok===false){
   resumeAfterSandbox=wasResume;sandbox.showModal();
   sandbox.querySelector('#ranchSandboxFeedback').textContent=result?.error||'Termine a conversa, cena ou desafio atual antes de começar a revanche.';
  }
  render();
 }
 sandbox.querySelector('#ranchSandboxClose').addEventListener('click',closeSandbox);sandbox.querySelector('#ranchSandboxBack').addEventListener('click',closeSandbox);
 sandbox.addEventListener('close',()=>{
  if(sandbox.open)return;
  window.Game?.releaseInputs?.();if(resumeAfterSandbox){resumeAfterSandbox=false;window.Game?.resume?.();}
  if(previousFocus?.isConnected&&!previousFocus.closest?.('[hidden]'))previousFocus.focus();
 });
 sandbox.addEventListener('click',event=>{if(event.target!==sandbox)return;const r=sandbox.getBoundingClientRect();if(event.clientX<r.left||event.clientX>r.right||event.clientY<r.top||event.clientY>r.bottom)closeSandbox();});
 let titleButton=document.querySelector('#startScreen [data-open-sandbox]');
 if(!titleButton){titleButton=document.createElement('button');titleButton.type='button';titleButton.id='titleSandboxBtn';titleButton.className='menu-book-button';titleButton.innerHTML=icon('sandbox')+'<span>TERREIRO DOS CHEFES</span>';titleButton.dataset.openSandbox='';document.querySelector('#startScreen .start-menu')?.append(titleButton);}
 document.addEventListener('click',event=>{if(event.target.closest?.('[data-open-sandbox]')){event.preventDefault();openSandbox();}});
 const endingButton=document.createElement('button');endingButton.type='button';endingButton.id='endingSandboxBtn';endingButton.textContent='SANDBOX · DESAFIAR CHEFES';endingButton.addEventListener('click',()=>openSandbox());document.querySelector('#chapterEndScreen .ending-options')?.append(endingButton);
 function render(){
  const state=gameState(),unlocked=isSandboxUnlocked(),selected=window.Difficulty?.getMode?.()||'normal',settings=window.Difficulty?.getSettings?.(selected);
  const easyLocked=!!window.Difficulty?.isLocked?.();for(const button of document.querySelectorAll('[data-rp-difficulty]')){button.setAttribute('aria-pressed',String(button.dataset.rpDifficulty===selected));button.disabled=easyLocked&&button.dataset.rpDifficulty!=='easy';button.title=button.disabled?'Fácil travado neste save. Só uma nova aventura permite trocar.':'';}
  const description=document.getElementById('ranchDifficultyDescription');if(description)description.textContent=settings?.description||'A receita original do desafio.';
  const modeLabel=settings?.label||'NORMAL';sandbox.querySelector('#ranchSandboxDifficulty').textContent='DIFICULDADE '+modeLabel;
  const noteText=state.activeBoss||state.ollyan?'A escolha vale no próximo confronto. A luta atual mantém a dificuldade do início.':'A dificuldade vale nos próximos confrontos. Seus atributos e seu progresso continuam iguais.';
  note.textContent=easyLocked?'FÁCIL TRAVADO NESTE SAVE · Para mudar de dificuldade, crie uma nova aventura.':noteText;window.CampaignRun?.render?.();
  const level=state.progression?.level||window.Progression?.getState?.()?.level||1;
  const stage=document.getElementById('stageName')?.textContent||'A roça';
  heading.querySelector('#ranchPauseLocation').textContent=(state.sandbox?'SANDBOX · ':'')+stage+' · NÍVEL '+level;
  sandboxButton.disabled=!unlocked;sandboxButton.querySelector('small').textContent=unlocked?'Sandbox: escolha uma revanche.':'Libere após concluir a história de Jorge.';
  sandboxButton.setAttribute('aria-label',unlocked?'Abrir sandbox e escolher um chefe':'Sandbox bloqueado: conclua a história de Jorge');
  returnButton.hidden=!state.sandbox;retryButton.hidden=!state.sandbox;
  resultBanner.hidden=!state.sandbox?.result;resultBanner.textContent=state.sandbox?.result==='won'?'REVANCHE VENCIDA! O bolo tá vingado de novo.':state.sandbox?.result?'A POEIRA BAIXOU. Ajuste o shape e tente outra vez.':'';
  for(const button of document.querySelectorAll('[data-open-sandbox]')){button.disabled=!unlocked;button.setAttribute('aria-label',unlocked?'Sandbox: escolher um chefe':'Sandbox bloqueado: conclua a história de Jorge');}
  endingButton.hidden=!unlocked;
  const sound=document.getElementById('soundBtn')?.getAttribute('aria-pressed')==='true';
  audio.querySelector('b').textContent=sound?'SOM LIGADO':'SOM DESLIGADO';audio.setAttribute('aria-pressed',String(sound));
 }
 function open(){window.Game?.pause?.();render();}
 function close(){window.Game?.resume?.();}
 new MutationObserver(()=>{render();if(!screen.hidden&&!document.querySelector('dialog[open]'))requestAnimationFrame(()=>resume?.focus());}).observe(screen,{attributes:true,attributeFilter:['hidden']});
 const start=document.getElementById('startScreen');if(start)new MutationObserver(render).observe(start,{attributes:true,attributeFilter:['hidden']});
 window.addEventListener('difficulty-change',render);window.addEventListener('chapter-ended',()=>{unlock();render();});window.addEventListener('sandbox-change',render);
 document.getElementById('soundBtn')?.addEventListener('click',()=>requestAnimationFrame(render));
 render();
 window.RanchPause=Object.freeze({open,close,render,openSandbox,closeSandbox,isSandboxUnlocked,bosses});
})();
