/* Aviso de nova versão. Reconstruído para a cópia pública: consulta
   DAROCA_APP_VERSION.updateUrl e, se o serviço anunciar um versionCode maior,
   mostra um aviso discreto. Sem backend (servidor estático) não faz nada. */
(function(){
 'use strict';
 const cur=window.DAROCA_APP_VERSION||{};
 const LATER='daroca-update-later';
 if(!cur.updateUrl||location.protocol==='file:')return;
 function store(get,k,v){try{return get?localStorage.getItem(k):localStorage.setItem(k,v);}catch(e){return null;}}
 function esc(s){return String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
 function show(info){
  if(document.querySelector('.app-update-notice'))return;
  const box=document.createElement('aside');box.className='app-update-notice';box.setAttribute('role','dialog');box.setAttribute('aria-label','Nova versão');
  const url=typeof info.url==='string'&&/^(https:\/\/|\/)/.test(info.url)?info.url:'';
  box.innerHTML='<span>ATUALIZAÇÃO DISPONÍVEL</span><button class="app-update-close" type="button" aria-label="Fechar">×</button>'+
   '<h2>Versão '+esc(info.versionName||info.versionCode)+'</h2>'+
   (info.notes?'<p>'+esc(String(info.notes).slice(0,400))+'</p>':'')+
   '<small>Você está na versão '+esc(cur.versionName||cur.versionCode||'?')+'. Seu progresso fica salvo.</small>'+
   (url?'<button class="app-update-download" type="button">BAIXAR</button>':'<button class="app-update-download" type="button">RECARREGAR</button>')+
   '<button class="app-update-later" type="button">DEPOIS</button>';
  const close=()=>box.remove();
  box.querySelector('.app-update-close').onclick=close;
  box.querySelector('.app-update-later').onclick=()=>{store(false,LATER,String(info.versionCode));close();};
  box.querySelector('.app-update-download').onclick=()=>{if(url)location.href=url;else location.reload();};
  document.body.appendChild(box);
 }
 function check(){
  fetch(cur.updateUrl,{cache:'no-store'}).then(r=>r.ok&&/json/.test(r.headers.get('content-type')||'')?r.json():null).then(info=>{
   if(!info||!(Number(info.versionCode)>Number(cur.versionCode||0)))return;
   if(store(true,LATER)===String(info.versionCode))return;
   show(info);
  }).catch(()=>{});
 }
 if(document.readyState==='complete')setTimeout(check,4000);else addEventListener('load',()=>setTimeout(check,4000));
})();
