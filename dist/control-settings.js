/* The adventurer's control notebook. Preferences live outside campaign saves. */
(() => {
 'use strict';
 const api=window.ControlSettings,shell=document.getElementById('gameShell');
 if(!api||!shell||window.ControlSettingsUI)return;
 const canvas=document.getElementById('gameCanvas');
 const icons={
  pad:'<path d="M5 5h14v2h3v12h-6l-3-3h-2l-3 3H2V7h3z"/><path class="ink-light" d="M6 8h2v3h3v2H8v3H6v-3H3v-2h3zm10 1h3v3h-3zm-3 4h3v3h-3z"/>',
  boots:'<path d="M3 2h7v11h4v7H2v-5h1zm11 0h7v11h2v7h-7v-5h-2z"/><path class="ink-light" d="M5 5h3v8H5zm11 0h3v8h-3zM4 16h8v2H4zm14 0h3v2h-3z"/>',
  paper:'<path d="M5 1h11l5 5v16H3V3h2zm10 2v5h4"/><path class="ink-light" d="M6 10h12v2H6zm0 4h12v2H6zm0 4h8v2H6z"/>',
  leaf:'<path d="M12 1h3v5h5v3h3v4h-4v4h-5v6h-3V13H6V9H2V6h6v3h3z"/><path class="ink-light" d="M15 8h3v3h-3zm-3 3h3v2h-3z"/>'
 };
 const svg=name=>'<svg viewBox="0 0 24 24" aria-hidden="true" shape-rendering="crispEdges">'+(icons[name]||icons.pad)+'</svg>';
 const groups=[{label:'PÉS NA ESTRADA',icon:'boots',actions:['left','right','up','down','jump']},{label:'NA HORA DA RESENHA',icon:'paper',actions:['paper','fart','dash','reeis','bivolt']},{label:'PELA AVENTURA',icon:'leaf',actions:['interact','vehicle','taunt','pause']}];
 const descriptions={left:'Andar para a esquerda',right:'Andar para a direita',up:'Subir durante o voo',down:'Descer durante o voo',jump:'Pular · segure no ar para voar',paper:'Bolinhas e papaias elementais',fart:'Peido de ataque e combo',dash:'Esquiva rápida após o treino do Mota',reeis:'Chamar o aliado depois de recrutá-lo',bivolt:'Energético após a missão das garotas',interact:'Conversar, abrir salas e confirmar desafios',vehicle:'Entrar e sair do carro a gás',taunt:'Chamar Nikolas de batata',pause:'Pausar e continuar a aventura'};
 const labels={left:'Esquerda',right:'Direita',up:'Subir',down:'Descer',jump:'Pular / voar',paper:'Papel',fart:'Peidão',dash:'Dash',reeis:'OOO REEEIS!',bivolt:'Bivolt',interact:'Interagir',vehicle:'Carro a gás',taunt:'Provocar',pause:'Pausa'};
 let capturing=null,conflict=null,resumeAfterClose=false,returnFocus=null,tab='keys',resetRequested=false,persistenceAvailable=true;
 const modal=document.createElement('dialog');modal.id='controlSettingsModal';modal.className='control-settings-modal';modal.setAttribute('aria-labelledby','controlSettingsTitle');
 modal.innerHTML='<header class="controls-notebook-header"><span class="controls-stamp">'+svg('pad')+'</span><div><span class="controls-eyebrow">O CADERNO DO AVENTUREIRO</span><h2 id="controlSettingsTitle">Do seu jeito, da roça.</h2><p>Teclas e resposta dos controles</p></div><button type="button" class="controls-close" aria-label="Fechar configurações">×</button></header><nav class="controls-tabs" aria-label="Configurações de controle" role="tablist"><button type="button" role="tab" id="controlTabKeys" aria-controls="controlKeysPage" data-control-tab="keys">TECLAS E ATAQUES</button><button type="button" role="tab" id="controlTabFeel" aria-controls="controlFeelPage" data-control-tab="feel">SENSIBILIDADE</button></nav><div class="controls-pages"><section id="controlKeysPage" role="tabpanel" aria-labelledby="controlTabKeys"><p class="controls-instructions">Clique numa tecla e pressione a nova. Cada ação aceita dois atalhos. <kbd>Esc</kbd> cancela a escolha.</p><p class="controls-mobile-note">No celular, os botões de toque continuam disponíveis. Para trocar teclas, conecte um teclado.</p><div class="controls-binding-groups"></div></section><section id="controlFeelPage" role="tabpanel" aria-labelledby="controlTabFeel" hidden><div class="controls-feel-card"><div class="controls-feel-heading">'+svg('boots')+'<div><h3>Resposta do movimento</h3><p>Encontre o ponto certo pro seu passo.</p></div><output id="controlSensitivityValue" for="controlSensitivity">1,00×</output></div><label for="controlSensitivity">Sensibilidade do joystick e da direção</label><input type="range" id="controlSensitivity" min="0.5" max="2" step="0.05"><div class="controls-range-labels"><span>Mais suave · 0,5×</span><span>Mais rápida · 2×</span></div><p class="controls-field-note">Muda a resposta da direção. A velocidade máxima continua dependendo dos seus atributos; este ajuste não dá velocidade extra.</p></div><div class="controls-feel-card"><div class="controls-feel-heading">'+svg('pad')+'<div><h3>Zona morta do joystick</h3><p>Evite que o personagem ande sem querer.</p></div><output id="controlDeadzoneValue" for="controlDeadzone">12%</output></div><label for="controlDeadzone">Área central sem movimento</label><input type="range" id="controlDeadzone" min="0" max="0.4" step="0.01"><div class="controls-range-labels"><span>0% · mais preciso</span><span>40% · centro maior</span></div><p class="controls-field-note">Movimentos dentro dessa área são ignorados. Fora dela, a direção continua suave, sem salto de velocidade.</p><div class="controls-stick-example" aria-hidden="true"><span><i></i></span><small>O centro sombreado é a zona morta.</small></div></div></section></div><aside class="controls-capture" hidden aria-live="polite"><span class="controls-capture-title"></span><p class="controls-capture-copy"></p><div class="controls-capture-actions"><button type="button" id="controlSwapBtn" hidden>TROCAR TECLAS</button><button type="button" id="controlCancelCapture">CANCELAR</button></div></aside><footer class="controls-footer"><div><span class="controls-save-mark" aria-hidden="true">✓</span><p id="controlSaveStatus" role="status" aria-live="polite">Salvo neste dispositivo · separado do progresso.</p></div><div class="controls-footer-actions"><button type="button" id="controlResetBtn">Restaurar padrões</button><button type="button" class="controls-done">PRONTO <span>✓</span></button></div></footer>';
 shell.append(modal);
 const grid=modal.querySelector('.controls-binding-groups'),captureBox=modal.querySelector('.controls-capture'),captureTitle=modal.querySelector('.controls-capture-title'),captureCopy=modal.querySelector('.controls-capture-copy'),swapButton=modal.querySelector('#controlSwapBtn'),cancelCapture=modal.querySelector('#controlCancelCapture'),status=modal.querySelector('#controlSaveStatus'),resetButton=modal.querySelector('#controlResetBtn');
 const sensitivity=modal.querySelector('#controlSensitivity'),deadzone=modal.querySelector('#controlDeadzone');
 const actionName=id=>labels[id]||api.actions.find(a=>a.id===id)?.label||id;
 const codeLabel=code=>code?api.labelForCode(code):'Adicionar';
 const actionKeys=(id,separator=' / ')=>(api.getState().bindings[id]||[]).map(codeLabel).join(separator)||'Sem tecla';
 function saveMessage(message='Alterações salvas neste dispositivo.'){status.textContent=persistenceAvailable?message:'Alterações nesta sessão. Permita o armazenamento do navegador para manter seus controles.';modal.dataset.save=persistenceAvailable?'saved':'temporary';resetRequested=false;resetButton.textContent='Restaurar padrões';}
 function keyButton(action,slot,code){
  const wrap=document.createElement('div');wrap.className='controls-key-slot';
  const button=document.createElement('button');button.type='button';button.className='controls-key';button.dataset.bindingAction=action;button.dataset.bindingSlot=slot;button.setAttribute('aria-label',actionName(action)+', atalho '+(slot+1)+': '+codeLabel(code)+'. '+(action==='pause'&&slot===0?'Escape é uma saída fixa.':'Clique para alterar.'));
  const fixed=action==='pause'&&slot===0;button.disabled=fixed;button.classList.toggle('is-empty',!code);button.classList.toggle('is-fixed',fixed);button.title=fixed?'Escape sempre permite sair ou pausar':code?'Clique para trocar esta tecla':'Adicionar outro atalho';
  const kbd=document.createElement('kbd');kbd.textContent=code?codeLabel(code):'+';button.append(kbd);
  if(!code){const add=document.createElement('small');add.textContent='atalho';button.append(add);}
  if(fixed){const lock=document.createElement('small');lock.textContent='fixo';button.append(lock);}
  button.addEventListener('click',()=>beginCapture(action,slot));wrap.append(button);
  if(code&&!fixed&&(api.getState().bindings[action]||[]).length>1){const clear=document.createElement('button');clear.type='button';clear.className='controls-key-clear';clear.textContent='×';clear.setAttribute('aria-label','Remover '+codeLabel(code)+' de '+actionName(action));clear.title='Remover este atalho';clear.addEventListener('click',()=>{stopCapture();const result=api.clearBinding(action,slot);if(result?.ok===false)saveMessage(result.message||'Mantenha pelo menos uma tecla para esta ação.');else saveMessage();refresh();});wrap.append(clear);}
  return wrap;
 }
 function renderBindings(){
  const state=api.getState();grid.replaceChildren();
  for(const group of groups){const section=document.createElement('section');section.className='controls-binding-group';const h=document.createElement('h3');h.innerHTML=svg(group.icon);h.append(document.createTextNode(group.label));section.append(h);
   for(const action of group.actions){const row=document.createElement('div');row.className='controls-binding-row';const copy=document.createElement('div');copy.className='controls-action-copy';const title=document.createElement('b');title.textContent=actionName(action);const note=document.createElement('small');note.textContent=descriptions[action]||'';copy.append(title,note);const slots=document.createElement('div');slots.className='controls-key-slots';for(let slot=0;slot<2;slot++)slots.append(keyButton(action,slot,state.bindings[action]?.[slot]));row.append(copy,slots);section.append(row);}
   grid.append(section);
  }
 }
 function refreshFeel(){const state=api.getState();sensitivity.value=state.sensitivity;deadzone.value=state.deadzone;modal.querySelector('#controlSensitivityValue').textContent=Number(state.sensitivity).toFixed(2).replace('.',',')+'×';modal.querySelector('#controlDeadzoneValue').textContent=Math.round(state.deadzone*100)+'%';modal.style.setProperty('--control-deadzone',Math.round(10+state.deadzone*100)+'%');}
 function updateHints(){
  const barActions=[null,'jump','paper','fart','interact','reeis','vehicle','dash','taunt'];
  document.querySelectorAll('.controls-bar .control-hint').forEach((hint,index)=>{const keys=hint.querySelectorAll('kbd');if(index===0){if(keys[0])keys[0].textContent=api.getLabel('left');if(keys[1])keys[1].textContent=api.getLabel('right');hint.title=actionKeys('left')+' / '+actionKeys('right');}else if(barActions[index]&&keys[0]){keys[0].textContent=api.getLabel(barActions[index]);hint.title=actionKeys(barActions[index]);}});
  const helpRows=document.querySelectorAll('#helpModal .help-grid>div');
  const helpActions=[null,'jump','paper','fart','interact','reeis','vehicle','dash','taunt','training','pause'];
  helpRows.forEach((row,index)=>{const keys=row.querySelectorAll('kbd');if(index===0){if(keys[0])keys[0].textContent=api.getLabel('left');if(keys[1])keys[1].textContent=api.getLabel('right');const copy=row.querySelector('span');if(copy)copy.textContent='Andar · '+actionKeys('left')+' / '+actionKeys('right');}else if(keys[0]&&helpActions[index])keys[0].textContent=helpActions[index]==='training'?api.getLabel('interact')+' / '+api.getLabel('jump'):actionKeys(helpActions[index]);});
  const train=document.querySelector('#trainingHitBtn kbd');if(train)train.textContent=api.getLabel('interact')+' / '+api.getLabel('jump');
  document.querySelectorAll('.touch-controls [data-action]').forEach(button=>{const action=button.dataset.action;if(!api.getState().bindings[action])return;const label=descriptions[action]||actionName(action);button.setAttribute('aria-label',label+' · teclado: '+actionKeys(action));});
  if(canvas)canvas.setAttribute('aria-label','Da Roça Adventure. Andar: '+api.getLabel('left')+' e '+api.getLabel('right')+'. Pular e voar: '+actionKeys('jump')+'. Papel: '+actionKeys('paper')+'. Peidão: '+actionKeys('fart')+'. Conversar: '+actionKeys('interact')+'. Pausar: '+actionKeys('pause')+'. Configure os controles no menu.');
  // Keep the story text, while replacing only its former hard-coded key prompts.
  const intro=document.querySelector('#helpModal>p:not(.help-tip)'),tip=document.querySelector('#helpModal>.help-tip');
  if(intro){intro.dataset.controlsOriginal??=intro.textContent;intro.textContent=intro.dataset.controlsOriginal.replace('Use E para','Use '+api.getLabel('interact')+' para');}
  if(tip){tip.dataset.controlsOriginal??=tip.textContent;tip.textContent=tip.dataset.controlsOriginal.replace('entre com V','entre com '+api.getLabel('vehicle')).replace('com E junto','com '+api.getLabel('interact')+' junto').replace('B ou o botão',''+api.getLabel('bivolt')+' ou o botão');}
 }
 function refresh(){renderBindings();refreshFeel();updateHints();}
 function selectTab(next){stopCapture();tab=next;modal.querySelectorAll('[data-control-tab]').forEach(button=>{const on=button.dataset.controlTab===next;button.setAttribute('aria-selected',String(on));button.tabIndex=on?0:-1;});modal.querySelector('#controlKeysPage').hidden=next!=='keys';modal.querySelector('#controlFeelPage').hidden=next!=='feel';}
 function beginCapture(action,slot){
  stopCapture();capturing={action,slot};window.Game?.releaseInputs?.();window.dispatchEvent(new CustomEvent('controls-capture',{detail:{active:true}}));
  modal.querySelector('[data-binding-action="'+action+'"][data-binding-slot="'+slot+'"]')?.classList.add('is-listening');captureBox.hidden=false;captureBox.dataset.state='listening';captureTitle.textContent='Pressione uma tecla para '+actionName(action).toLowerCase()+'.';captureCopy.textContent='A próxima tecla será o atalho '+(slot+1)+'. Esc cancela sem alterar nada.';swapButton.hidden=true;cancelCapture.textContent='CANCELAR';captureBox.scrollIntoView({block:'nearest',behavior:'instant'});
 }
 function stopCapture(){
  capturing=null;conflict=null;captureBox.hidden=true;swapButton.hidden=true;modal.querySelectorAll('.is-listening').forEach(el=>el.classList.remove('is-listening'));window.dispatchEvent(new CustomEvent('controls-capture',{detail:{active:false}}));window.Game?.releaseInputs?.();
 }
 function acceptKey(code){
  if(!capturing)return;const target={...capturing},result=api.setBinding(target.action,code,target.slot);
  if(result?.ok===false){
   captureBox.dataset.state='conflict';captureTitle.textContent=result.conflicts?.length?'Essa tecla já tem uma tarefa.':'Essa tecla não pode ser usada.';
   const other=result.conflicts?.[0],oldCode=api.getState().bindings[target.action]?.[target.slot];
   if(other){const canSwap=result.conflicts.length===1&&!!oldCode&&!(other.action==='pause'&&other.slot===0);captureCopy.textContent=codeLabel(code)+' está em '+actionName(other.action)+'. '+(canSwap?'Trocar coloca '+codeLabel(oldCode)+' em '+actionName(other.action)+', sem deixar ninguém sem atalho.':'Escolha uma tecla livre. Nenhum atalho foi removido.');conflict={target,code,other,oldCode};swapButton.hidden=!canSwap;capturing=null;modal.querySelectorAll('.is-listening').forEach(el=>el.classList.remove('is-listening'));window.dispatchEvent(new CustomEvent('controls-capture',{detail:{active:false}}));(canSwap?swapButton:cancelCapture).focus({preventScroll:true});}else{captureCopy.textContent=result.message||'Escolha outra tecla. Escape continua reservado para sair.';swapButton.hidden=true;}
   return;
  }
  stopCapture();saveMessage(actionName(target.action)+': '+codeLabel(code)+'. Salvo neste dispositivo.');refresh();modal.querySelector('[data-binding-action="'+target.action+'"][data-binding-slot="'+target.slot+'"]')?.focus({preventScroll:true});
 }
 function open(){
  if(modal.open)return;const state=window.Game?.getState();returnFocus=document.activeElement;resumeAfterClose=!!(state?.started&&!state.paused&&!state.won&&!state.defeated&&!state.chapterEnded&&!document.querySelector('dialog[open]'));window.Game?.releaseInputs?.();if(resumeAfterClose)window.Game?.pause?.();refresh();selectTab(tab);saveMessage('Salvo neste dispositivo · separado do progresso.');modal.showModal();modal.querySelector('[data-control-tab="'+tab+'"]')?.focus({preventScroll:true});
 }
 function close(){if(modal.open)modal.close();}
 modal.addEventListener('close',()=>{stopCapture();const shouldResume=resumeAfterClose;resumeAfterClose=false;if(shouldResume&&!document.querySelector('dialog[open]'))window.Game?.resume?.();window.Game?.releaseInputs?.();requestAnimationFrame(()=>{const state=window.Game?.getState();if(state?.started&&!state.paused&&!document.querySelector('dialog[open]'))canvas?.focus({preventScroll:true});else if(returnFocus?.isConnected&&returnFocus.getClientRects().length)returnFocus.focus({preventScroll:true});});});
 modal.addEventListener('cancel',event=>{event.preventDefault();if(capturing)stopCapture();else close();});
 modal.addEventListener('click',event=>{if(event.target!==modal)return;const r=modal.getBoundingClientRect();if(event.clientX<r.left||event.clientX>r.right||event.clientY<r.top||event.clientY>r.bottom){if(capturing)stopCapture();else close();}});
 modal.querySelectorAll('.controls-close,.controls-done').forEach(button=>button.addEventListener('click',close));
 modal.querySelectorAll('[data-control-tab]').forEach(button=>button.addEventListener('click',()=>selectTab(button.dataset.controlTab)));
 modal.querySelector('.controls-tabs').addEventListener('keydown',event=>{if(!['ArrowLeft','ArrowRight','Home','End'].includes(event.key))return;event.preventDefault();const next=event.key==='Home'?'keys':event.key==='End'?'feel':tab==='keys'?'feel':'keys';selectTab(next);modal.querySelector('[data-control-tab="'+next+'"]').focus();});
 cancelCapture.addEventListener('click',()=>{const last=capturing||conflict?.target;stopCapture();if(last)modal.querySelector('[data-binding-action="'+last.action+'"][data-binding-slot="'+last.slot+'"]')?.focus({preventScroll:true});});
 swapButton.addEventListener('click',()=>{if(!conflict)return;const {target,code}=conflict,result=api.setBinding(target.action,code,target.slot,{swapConflicts:true});if(result?.ok===false){captureCopy.textContent=result.message||'A troca não pôde ser feita. Escolha outra tecla.';return;}stopCapture();saveMessage('Teclas trocadas e salvas. Nenhuma ação ficou sem atalho.');refresh();modal.querySelector('[data-binding-action="'+target.action+'"][data-binding-slot="'+target.slot+'"]')?.focus({preventScroll:true});});
 resetButton.addEventListener('click',()=>{stopCapture();if(!resetRequested){resetRequested=true;resetButton.textContent='Confirmar restauração';status.textContent='Restaurar todas as teclas e a sensibilidade? Clique de novo para confirmar.';return;}api.reset();saveMessage('Teclas e sensibilidade restauradas. Seu progresso foi mantido.');refresh();});
 sensitivity.addEventListener('input',()=>{api.setSensitivity(Number(sensitivity.value));refreshFeel();saveMessage();});deadzone.addEventListener('input',()=>{api.setDeadzone(Number(deadzone.value));refreshFeel();saveMessage();});
 window.addEventListener('keydown',event=>{
  if(!modal.open)return;
  if(capturing){event.preventDefault();event.stopImmediatePropagation();if(event.repeat)return;if(event.code==='Escape'){const last=capturing;stopCapture();modal.querySelector('[data-binding-action="'+last.action+'"][data-binding-slot="'+last.slot+'"]')?.focus({preventScroll:true});return;}acceptKey(event.code);return;}
  if(event.code==='Escape'){event.preventDefault();event.stopImmediatePropagation();if(conflict)stopCapture();else close();return;}
  if(event.target.closest?.('[data-control-tab]')&&['ArrowLeft','ArrowRight','Home','End'].includes(event.key)){event.preventDefault();const next=event.key==='Home'?'keys':event.key==='End'?'feel':tab==='keys'?'feel':'keys';selectTab(next);modal.querySelector('[data-control-tab="'+next+'"]').focus();}
  // Block gameplay listeners, preserving native button, tab and range input behaviour.
  event.stopPropagation();
 },true);
 window.addEventListener('keyup',event=>{if(modal.open)event.stopPropagation();},true);
 window.addEventListener('controls-change',event=>{if(typeof event.detail?.saved==='boolean')persistenceAvailable=event.detail.saved;refreshFeel();updateHints();if(modal.open&&!capturing)renderBindings();});
 function settingsButton(id,className,text){const button=document.createElement('button');button.type='button';button.id=id;button.className=className;button.setAttribute('aria-haspopup','dialog');button.setAttribute('aria-controls',modal.id);button.setAttribute('aria-label','Configurar controles e sensibilidade');button.title='Configurar controles e sensibilidade';if(text)button.textContent=text;else button.innerHTML=svg('pad');button.addEventListener('click',open);return button;}
 const title=document.getElementById('startScreen');if(title)title.append(settingsButton('titleControlsBtn','title-controls'));
 const help=document.getElementById('helpModal');if(help){const button=settingsButton('helpControlsBtn','controls-configure-link','CONFIGURAR CONTROLES');help.querySelector('.help-grid')?.insertAdjacentElement('beforebegin',button)||help.append(button);}
 window.ControlSettingsUI={open,close,isOpen:()=>modal.open,refresh:updateHints};
 refresh();selectTab('keys');
})();
