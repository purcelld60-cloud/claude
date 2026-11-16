(() => {
'use strict';
const nativeApp=location.protocol==='file:'||new URLSearchParams(location.search).has('native');
const standalone=()=>matchMedia('(display-mode: standalone)').matches||!!navigator.standalone;
const isIOS=/iPhone|iPad|iPod/.test(navigator.userAgent)||(navigator.platform==='MacIntel'&&navigator.maxTouchPoints>1);
const status=document.getElementById('offlineStatus'),buttons=[...document.querySelectorAll('#installAppBtn,[data-install-app]')],guide=document.getElementById('installGuide');let installPrompt=null,guideModal=null,resumeAfterGuide=false;
if(nativeApp||standalone()){document.body.classList.add('installed-game');window.GameView?.enterFullscreen();}
function showGuide(){
 if(!guideModal){
  guideModal=document.createElement('dialog');guideModal.className='iphone-screen-guide';guideModal.id='phoneInstallGuide';guideModal.setAttribute('aria-labelledby','phoneInstallHeading');
  guideModal.innerHTML=isIOS?'<h2 id="phoneInstallHeading">A ROÇA NA TELA TODA</h2><p>O Safari controla as barras do navegador. Para jogar sem essas barras:</p><ol><li>Toque em <b>Compartilhar</b> no Safari: o quadrado com uma seta para cima.</li><li>Escolha <b>Adicionar à Tela de Início</b> e confirme em <b>Adicionar</b>.</li><li>Abra o ícone <b>Da Roça</b> na Tela de Início e deite o iPhone.</li></ol><p>Abra conectado uma vez para preparar o jogo offline. O jogo salva o progresso no aparelho. A Tela de Início pode ter um save separado do Safari.</p><button type="button" class="primary-btn">ENTENDI · VOLTAR AO JOGO</button>':'<h2 id="phoneInstallHeading">LEVE A AVENTURA COM VOCÊ</h2><p>No menu do navegador, escolha <b>Instalar app</b> ou <b>Adicionar à Tela de Início</b>. Abra o ícone Da Roça para jogar sem as barras do navegador.</p><p>Essa opção instala a versão do site. O APK continua disponível para instalação direta.</p><button type="button" class="primary-btn">ENTENDI · VOLTAR AO JOGO</button>';
  (document.getElementById('gameShell')||document.body).append(guideModal);
  guideModal.querySelector('button').addEventListener('click',()=>guideModal.close());
  guideModal.addEventListener('click',e=>{if(e.target===guideModal){const b=guideModal.getBoundingClientRect();if(e.clientX<b.left||e.clientX>b.right||e.clientY<b.top||e.clientY>b.bottom)guideModal.close();}});
  guideModal.addEventListener('close',()=>{if(resumeAfterGuide){resumeAfterGuide=false;window.Game?.resume?.();}});
 }
 if(guideModal.open)return;
 const state=window.Game?.getState();resumeAfterGuide=!!(state?.started&&!state.paused&&!state.won&&!state.defeated);
 window.Game?.releaseInputs?.();if(resumeAfterGuide)window.Game?.pause?.();guideModal.showModal();
}
window.GameInstall={showGuide};
window.addEventListener('beforeinstallprompt',e=>{e.preventDefault();installPrompt=e;buttons.forEach(button=>button.textContent='INSTALAR NA TELA DE INÍCIO');});
async function install(){
 if(installPrompt){const prompt=installPrompt;installPrompt=null;await prompt.prompt();await prompt.userChoice;return;}
 if(guide){guide.hidden=false;guide.textContent=isIOS?'No Safari, toque em Compartilhar → Adicionar à Tela de Início → Adicionar. Abra pelo ícone Da Roça e deite o iPhone para jogar sem as barras do navegador.':'Use o menu do navegador → Instalar app ou Adicionar à Tela de Início. Essa opção instala o jogo do site sem baixar o APK.';}
 showGuide();
}
buttons.forEach(button=>button.addEventListener('click',install));
window.addEventListener('appinstalled',()=>{installPrompt=null;document.body.classList.add('installed-game');buttons.forEach(button=>button.textContent='INSTALADO NA TELA DE INÍCIO');});
const offlineAllowed=!['localhost','127.0.0.1'].includes(location.hostname)||new URLSearchParams(location.search).has('offline-test');
if(!nativeApp&&offlineAllowed&&'serviceWorker' in navigator&&['https:','http:'].includes(location.protocol))navigator.serviceWorker.register('./sw.js').then(()=>navigator.serviceWorker.ready).then(()=>{if(status)status.textContent='Jogo preparado para abrir offline pela Tela de Início.';}).catch(()=>{if(status)status.textContent='Abra conectado para preparar o offline. No Android, o APK inclui o jogo completo.';});
})();
