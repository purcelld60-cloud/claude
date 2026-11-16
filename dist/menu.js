/* The village title is the front door; journals and downloads live in its book. */
(() => {
 'use strict';
 const shell=document.getElementById('gameShell'),start=document.getElementById('startScreen');
 if(!shell||!start)return;
 document.body.classList.add('shell-experience');
 const menu=start.querySelector('.start-menu');
 const infoButton=document.createElement('button');infoButton.id='adventureInfoBtn';infoButton.type='button';infoButton.className='menu-book-button';infoButton.innerHTML='<svg viewBox="0 0 24 24" width="21" height="21" aria-hidden="true" shape-rendering="crispEdges"><path fill="currentColor" d="M2 3h8l2 2 2-2h8v17h-8l-2 2-2-2H2z"/><path fill="#f4dfaa" d="M5 6h4l1 1v10H5zm10 0h4v11h-5V7z"/></svg><span>DIÁRIO E TURMA</span>';menu.append(infoButton);
 const fullscreenButton=document.createElement('button');fullscreenButton.id='titleFullscreenBtn';fullscreenButton.type='button';fullscreenButton.className='menu-fullscreen';fullscreenButton.setAttribute('aria-label','Jogar em tela cheia');fullscreenButton.title='Tela cheia';fullscreenButton.innerHTML='<svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true"><path fill="currentColor" d="M3 3h7v3H6v4H3zm11 0h7v7h-3V6h-4zM3 14h3v4h4v3H3zm15 0h3v7h-7v-3h4z"/></svg>';start.append(fullscreenButton);
 function reflectFullscreen(){const active=!!window.GameView?.isNativeFullscreen?.();fullscreenButton.setAttribute('aria-pressed',String(active));fullscreenButton.setAttribute('aria-label',active?'Sair da tela cheia':'Jogar em tela cheia');fullscreenButton.title=active?'Sair da tela cheia':'Tela cheia';}
 fullscreenButton.addEventListener('click',async()=>{if(window.GameView?.isNativeFullscreen?.())await GameView.exitFullscreen();else{await window.GameView?.enterFullscreen?.();const ios=/iPhone|iPad|iPod/.test(navigator.userAgent)||(navigator.platform==='MacIntel'&&navigator.maxTouchPoints>1),installed=!!navigator.standalone||matchMedia('(display-mode: standalone)').matches||location.protocol==='file:'||new URLSearchParams(location.search).has('native');if(ios&&!installed&&!window.GameView?.isNativeFullscreen?.())window.GameInstall?.showGuide?.();}reflectFullscreen();});
 document.addEventListener('fullscreenchange',reflectFullscreen);document.addEventListener('webkitfullscreenchange',reflectFullscreen);reflectFullscreen();
 const info=document.createElement('dialog');info.id='adventureInfo';info.className='adventure-info';info.setAttribute('aria-labelledby','adventureInfoHeading');
 info.innerHTML='<div class="info-book-header"><div><span class="book-eyebrow">O CADERNO DA TURMA</span><h2 id="adventureInfoHeading">Dentro da resenha</h2></div><button id="closeAdventureInfo" aria-label="Fechar informações">×</button></div><div class="info-book-tabs" role="tablist" aria-label="Informações da aventura"><button type="button" role="tab" id="info-tab-journal" aria-controls="info-journal" data-info-tab="journal">DIÁRIO</button><button type="button" role="tab" id="info-tab-cast" aria-controls="info-cast" data-info-tab="cast">A TURMA</button><button type="button" role="tab" id="info-tab-install" aria-controls="info-install" data-info-tab="install">INSTALAR</button></div><div class="info-book-pages"><div id="info-journal" role="tabpanel" aria-labelledby="info-tab-journal"><p class="info-notice" id="infoNotice">Escolha a dificuldade no menu de pausa. Ganhe níveis, distribua os 2 pontos de cada nível e prepare seus atributos antes dos chefes.</p><div id="acaiPrize" class="acai-prize" hidden>★ PRÊMIO DA TURMA: AÇAÍ DE QUARTA-FEIRA ★</div></div><div id="info-cast" role="tabpanel" aria-labelledby="info-tab-cast" hidden></div><div id="info-install" role="tabpanel" aria-labelledby="info-tab-install" hidden></div></div><div class="info-book-footer"><button type="button" id="bookHelpBtn">CONTROLES E AJUDA</button><a href="references.html" target="_blank" rel="noopener">Créditos e referências ↗</a><a href="https://da-roca-adventure-jogo.davims99.chatgpt.site/admin" target="_blank" rel="noopener">Estúdio de trilhas ↗</a><span>DA ROÇA · EDIÇÃO 3.9</span></div>';
 shell.append(info);
 document.querySelectorAll('main > .adventure-desk,main > .campaign-journal').forEach(el=>info.querySelector('#info-journal').append(el));
 const cast=document.querySelector('main > .cast-section'),install=document.querySelector('main > .install-section');
 if(cast)info.querySelector('#info-cast').append(cast);if(install)info.querySelector('#info-install').append(install);
 let resumeAfterInfo=false,activeTab='journal';
 function selectTab(tab){
  activeTab=tab;
  info.querySelectorAll('[data-info-tab]').forEach(button=>{const on=button.dataset.infoTab===tab;button.setAttribute('aria-selected',String(on));button.tabIndex=on?0:-1;});
  for(const id of ['journal','cast','install'])info.querySelector('#info-'+id).hidden=id!==tab;
  info.querySelector('.info-book-pages').scrollTop=0;
 }
 function openInfo(tab='journal'){
  if(info.open){selectTab(tab);return;}
  const state=window.Game?.getState();resumeAfterInfo=!!(state?.started&&!state.paused&&!state.won&&!state.defeated);
  window.Game?.releaseInputs?.();if(resumeAfterInfo)Game.pause();
  document.getElementById('acaiPrize').hidden=!state?.q?.acai;
  selectTab(tab);info.showModal();
 }
 function closeInfo(){if(info.open)info.close();}
 info.addEventListener('close',()=>{if(resumeAfterInfo){resumeAfterInfo=false;window.Game?.resume?.();}});
 info.addEventListener('click',event=>{if(event.target===info){const r=info.getBoundingClientRect();if(event.clientX<r.left||event.clientX>r.right||event.clientY<r.top||event.clientY>r.bottom)closeInfo();}});
 info.querySelector('#closeAdventureInfo').addEventListener('click',closeInfo);
 info.querySelectorAll('[data-info-tab]').forEach(button=>button.addEventListener('click',()=>selectTab(button.dataset.infoTab)));
 info.querySelector('.info-book-tabs').addEventListener('keydown',event=>{if(!['ArrowLeft','ArrowRight'].includes(event.key))return;event.preventDefault();const tabs=['journal','cast','install'],i=tabs.indexOf(activeTab),next=tabs[(i+(event.key==='ArrowRight'?1:2))%3];selectTab(next);info.querySelector('[data-info-tab="'+next+'"]').focus();});
 infoButton.addEventListener('click',()=>openInfo());
 document.getElementById('bookHelpBtn').addEventListener('click',()=>window.GameView?.openHelp?.());
 // Existing map cards retain their route action after moving into the book.
 info.addEventListener('click',event=>{
  const stop=event.target.closest?.('[data-scene]');if(!stop)return;
  event.preventDefault();event.stopImmediatePropagation();const state=window.Game?.getState();
  if(!state?.started){document.getElementById('infoNotice').textContent='Escolha a dificuldade no pause. Cada nível dá 2 pontos para investir em ATRIBUTOS. Comece ou continue a aventura e prepare seu shape antes dos chefes.';return;}
  if(state.activeBoss||state.room||state.cutscene||state.activity||state.training?.active){document.getElementById('infoNotice').textContent='Retome a exploração fora da luta, sala ou desafio para escolher uma viagem.';return;}
  resumeAfterInfo=false;closeInfo();window.Game?.resume?.();window.GameView?.openRoutes?.(Number(stop.dataset.scene));
 },true);
 const pauseMenu=document.querySelector('#pauseScreen .game-modal');
 if(pauseMenu){
  const book=document.createElement('button');book.type='button';book.className='text-button';book.id='pauseInfoBtn';book.textContent='Diário, turma e instalação';book.addEventListener('click',()=>openInfo());
  const home=document.createElement('button');home.type='button';home.className='text-button';home.id='mainMenuBtn';home.textContent='Menu principal';home.addEventListener('click',()=>{window.Game?.returnToMenu?.();});
  pauseMenu.append(book,home);
 }
 function syncTitle(){
  const on=!start.hidden;shell.classList.toggle('in-main-menu',on);
  if(on){window.Game?.releaseInputs?.();window.GameView?.closeRoutes?.();}
  window.GameView?.fit?.();
 }
 new MutationObserver(syncTitle).observe(start,{attributes:true,attributeFilter:['hidden']});
 syncTitle();window.GameView?.enterFullscreen?.({pageOnly:true});syncTitle();
 window.AdventureMenu={openInfo,closeInfo,showTab:selectTab};
})();
