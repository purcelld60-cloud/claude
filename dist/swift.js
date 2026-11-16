/* A friendly difficulty choice at the first bend in the campaign. */
(() => {
 'use strict';
 const npc=Object.freeze({id:'swift',name:'Irmão de Clara Swift',scene:0,x:340});
 let modal=null,session=null;
 function draw(c,x,y,options={}){
  const t=Number(options.frame)||0,bob=Math.floor(Math.sin(t*2.4)*1.2),talk=options.talking;
  c.save();c.translate(Math.round(x),Math.round(y));c.scale(options.facing===-1?-1:1,1);c.scale(options.scale||1,options.scale||1);c.imageSmoothingEnabled=false;
  const r=(xx,yy,w,h,color)=>{c.fillStyle=color;c.fillRect(xx,yy,w,h);};
  r(-13,-2,26,4,'#243a3445');r(-8,-23,6,21,'#233c52');r(3,-23,6,21,'#29465e');r(-10,-4,10,4,'#e4e4cb');r(3,-4,11,4,'#d4dcc5');
  c.translate(0,bob);r(-10,-45,20,25,'#243a43');r(-8,-43,16,23,'#65919a');r(-3,-44,6,4,'#c18d64');r(-2,-37,4,15,'#81a8ac');r(-12,-42,5,19,'#a76e48');r(8,-42,5,19,'#b78056');
  const hand=talk?Math.floor(Math.sin(t*5)*3):0;r(9,-27-hand,5,7,'#c28c61');r(-13,-27,5,7,'#bb8258');r(-10,-66,20,24,'#2b2927');r(-8,-64,16,21,'#b67b52');r(-9,-66,18,7,'#151d24');r(-10,-62,3,7,'#1c242a');r(7,-62,3,7,'#192128');r(-10,-55,3,7,'#ac714d');r(8,-55,3,7,'#b67b52');
  const blink=Math.sin(t*1.7)>.993;r(-6,-57,5,blink?1:6,'#f5ebcf');r(3,-57,5,blink?1:6,'#f5ebcf');if(!blink){r(-4,-55,2,3,'#25292a');r(5,-55,2,3,'#25292a');}r(-6,-60,5,2,'#292523');r(3,-60,5,2,'#292523');r(0,-53,2,4,'#9a603e');r(-3,-46,talk?7:6,talk?3:2,talk?'#623c32':'#794737');c.restore();
 }
 function ensureModal(){
  if(modal)return modal;
  const style=document.createElement('style');style.textContent=`
  .swift-dialog{width:min(510px,calc(100vw - 28px));max-height:calc(100dvh - 24px);overflow:auto;box-sizing:border-box;border:4px solid #78502d;border-radius:5px;padding:0;background:#f0e2bb;color:#3a3828;box-shadow:0 0 0 3px #bd9755,0 16px 60px #081d30a0;font:15px/1.6 Arial,sans-serif}.swift-dialog::backdrop{background:#12283ab8}.swift-heading{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:11px 17px;background:#38594d;color:#fff0c5;border-bottom:3px solid #b28b4f}.swift-heading span{font:bold 11px/1.4 monospace;letter-spacing:1px}.swift-close{width:36px;height:36px;flex-shrink:0;border:2px solid #849979;background:#29493f;color:#fff1cd;font:24px Arial;cursor:pointer}.swift-content{padding:16px 22px 20px}.swift-speaker{display:flex;align-items:center;gap:16px;margin-bottom:6px}.swift-speaker canvas{width:80px;height:90px;image-rendering:pixelated;flex-shrink:0;background:#cfdbc0;border:2px solid #8d9f7b}.swift-speaker h2{font:bold 22px/1.2 Georgia,serif;margin:0 0 4px}.swift-current{font:12px/1.4 monospace;color:#596643}.swift-question{margin:14px 0 18px;font-size:17px;font-weight:bold}.swift-choices{display:grid;gap:10px}.swift-choices button,.swift-back{font:bold 14px/1.4 Arial,sans-serif;min-height:49px;text-align:left;border:2px solid #887244;border-bottom-width:5px;border-radius:3px;padding:10px 14px;background:#f8edce;color:#374334;cursor:pointer;touch-action:manipulation}.swift-choices button:hover{background:#fff8df;border-color:#507347}.swift-choices button:focus-visible,.swift-close:focus-visible,.swift-back:focus-visible{outline:3px solid #2c7a95;outline-offset:3px}.swift-choices button small{display:block;font-weight:normal;color:#626a4d;font-size:12px;margin-top:3px}.swift-choices button[aria-pressed="true"]{background:#d2e2ac;border-color:#56743b}.swift-choices .swift-yes{background:#d7e5b2}.swift-back{margin-top:12px;background:transparent;min-height:40px;padding:7px 12px;font-size:12px}.swift-hint{font-size:12px;color:#6e7156;margin:15px 0 0}@media(max-height:410px) and (orientation:landscape){.swift-dialog{width:min(630px,calc(100vw - 28px))}.swift-heading{padding:6px 14px}.swift-content{padding:10px 18px}.swift-speaker canvas{width:48px;height:54px}.swift-speaker h2{font-size:20px}.swift-question{margin:7px 0 10px;font-size:15px}.swift-choices{grid-template-columns:repeat(3,minmax(0,1fr));gap:8px}.swift-choices button{font-size:12px;padding:8px;min-height:45px}.swift-choices button small{font-size:10px}.swift-hint{margin:8px 0 0}.swift-back{margin-top:8px}}
  `;document.head.append(style);
  modal=document.createElement('dialog');modal.className='swift-dialog';modal.id='swiftGuideDialog';modal.setAttribute('aria-labelledby','swiftGuideName');modal.setAttribute('aria-describedby','swiftGuideQuestion');
  modal.innerHTML='<div class="swift-heading"><span>NA ENTRADA DA ROÇA</span><button class="swift-close" type="button" aria-label="Fechar conversa">×</button></div><div class="swift-content"><div class="swift-speaker"><canvas width="80" height="90" aria-label="Irmão de Clara Swift: moreno, magro, cabelo preto curto e olhos abertos"></canvas><div><h2 id="swiftGuideName"></h2><div class="swift-current"></div></div></div><p class="swift-question" id="swiftGuideQuestion"></p><div class="swift-choices"></div><button class="swift-back" type="button" hidden>← VOLTAR À PERGUNTA</button><p class="swift-hint">Normal e Difícil podem ser trocados. Escolher Fácil trava esta aventura; para mudar, crie um novo save.</p></div>';
  (document.getElementById('gameShell')||document.body).append(modal);modal.querySelector('h2').textContent=npc.name;
  const portrait=modal.querySelector('canvas');draw(portrait.getContext('2d'),40,84,{scale:1.1,facing:1,frame:0});
  modal.querySelector('.swift-close').addEventListener('click',()=>finish());modal.querySelector('.swift-back').addEventListener('click',()=>renderQuestion());
  modal.addEventListener('cancel',e=>{e.preventDefault();finish();});
  modal.addEventListener('close',finishSession);return modal;
 }
 const settings=()=>window.Difficulty?.getSettings?.()||{id:'normal',label:'NORMAL'};
 function updateCurrent(){modal.querySelector('.swift-current').textContent='SEU JOGO: '+settings().label;}
 function addChoice(label,id,callback,description){
  const button=document.createElement('button');button.type='button';button.dataset.swiftChoice=id;button.textContent=label;
  if(description){const small=document.createElement('small');small.textContent=description;button.append(small);}button.addEventListener('click',callback);modal.querySelector('.swift-choices').append(button);return button;
 }
 function renderQuestion(){
  updateCurrent();if(window.Difficulty?.isLocked?.()){modal.querySelector('.swift-question').textContent='Fácil escolhido, chapéu! Essa aventura ficou no modo bebezinho. Só criando um novo save pra trocar, viu?';modal.querySelector('.swift-choices').replaceChildren();modal.querySelector('.swift-back').hidden=true;addChoice('SEGUIR NO FÁCIL','no',()=>finish());return;}modal.querySelector('.swift-question').textContent='Ô, Da Roça! Tá difícil demais? Quer mudar a dificuldade?';modal.querySelector('.swift-choices').replaceChildren();modal.querySelector('.swift-back').hidden=true;
  addChoice('SIM, QUERO ESCOLHER','yes',renderModes).classList.add('swift-yes');addChoice('NÃO, BORA CONTINUAR','no',()=>finish());
  if(modal.open)modal.querySelector('[data-swift-choice="yes"]').focus({preventScroll:true});
 }
 function renderModes(){
  updateCurrent();modal.querySelector('.swift-question').textContent='Escolhe aí. O bolo continua no mesmo lugar!';modal.querySelector('.swift-choices').replaceChildren();modal.querySelector('.swift-back').hidden=false;
  for(const [id,label,description]of [['easy','FÁCIL','Chefes com menos vida. Fica travado neste save; só uma nova aventura permite trocar.'],['normal','NORMAL','O desafio original da campanha.'],['hard','DIFÍCIL','Chefes mais agressivos e golpes que tiram o dobro.']]){
   const button=addChoice(label,id,()=>choose(id),description);button.setAttribute('aria-pressed',String(settings().id===id));button.disabled=!!window.Difficulty?.isLocked?.()&&id!=='easy';
  }
  modal.querySelector('[data-swift-choice="'+settings().id+'"]')?.focus({preventScroll:true});
 }
 function choose(mode){if(!session||!['easy','normal','hard'].includes(mode))return false;if(!window.Difficulty?.setMode?.(mode)){session.api.toast?.('O modo Fácil ficou travado neste save. Crie uma nova aventura para mudar.');return false;}session.result=mode;finish();return true;}
 function finishSession(){
  if(modal?.open||!session)return;const prior=session;session=null;window.Game?.releaseInputs?.();if(prior.resumeAfter)window.Game?.resume?.();
  window.CampaignRun?.confirmInitialMode?.();
  if(prior.result){const mode=prior.result;prior.api.say?.([{name:npc.name,text:mode==='easy'?'Frouxo! Bebezinho, não aguenta nem o normal, pô!':mode==='hard'?'Aí sim, Da Roça! No difícil é reflexo afiado e atributo em dia. Respeito!':'Normal? Fechou, Da Roça! Desafio de respeito. Agora vai buscar teu bolo!'}]);}
  else document.getElementById('gameCanvas')?.focus({preventScroll:true});
 }
 function finish(){if(modal?.open){modal.close();finishSession();}}
 function open(api={}){
  const state=window.Game?.getState?.();if(session||!state?.started||state.sandbox||state.cutscene||state.dialog||state.activeBoss||state.room||state.activity||state.training?.active||state.defeated||state.won||state.chapterEnded||document.querySelector('dialog[open]'))return false;
  ensureModal();session={api,resumeAfter:!state.paused,result:null};window.Game?.releaseInputs?.();if(session.resumeAfter)window.Game?.pause?.();renderQuestion();modal.showModal();modal.querySelector('[data-swift-choice]')?.focus({preventScroll:true});return true;
 }
 window.SwiftGuide=Object.freeze({npc,draw,open,firstPrompt:open,close:finish,isOpen:()=>!!modal?.open});
})();
