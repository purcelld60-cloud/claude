importScripts('./music/config.js?v=trilhas21');
const CACHE='daroca-offline-v4.5.2-roblox';
const SHELL=['./music/config.json','./amanda.js?v=1','./amanda-art.js?v=1','./amanda.css?v=1','./interact.js?v=3.12','./weather.js?v=3.12','./hud-minimal.js?v=3.12','./menu-inicio.js?v=3.12','./confirmar.js?v=1','./tela-inicial.js?v=3','./tela-inicial.css?v=2','./menu-inicio.css?v=3.12','./hud-minimal.css?v=3.12','./ui-pixel.css?v=3.12','./daytime.js?v=3.12','./sprites.js?v=3.12','./hd-scene.js?v=3.12','./hd-maps.js?v=colegio1','./hero-shadow.js?v=3.12','./balanco.js?v=3.12','./trigal.js?v=3.12','./campanha2/personagens.js?v=achados1','./campanha2/cenarios.js?v=3.12','./campanha2/plantas.js?v=3.12','./campanha2/ambientes.js?v=3.12','./campanha2/camadas.js?v=3.12','./campanha2/novos-a.js?v=3.12','./campanha2/novos-b.js?v=3.12','./campanha2/moradores.js?v=3.12','./campanha2/poderes.js?v=3.12','./campanha2/treino.js?v=3.12','./campanha2/loja.js?v=3.12','./mapa3d.js?v=viagem4','./mapas.js?v=viagem3','./campanha2/visualizador.js?v=3.12','./assets/sprites/manifest.json','./campaign-controls.js?v=3.12','./campaign-controls.css?v=3.12','./campaign-vfx.js?v=golpes1','./fx-pixel.js?v=5','./vendor/pixelfx.js?v=2','./vendor/pixelfx-LICENSE.txt','./scene-details.js?v=3.12','./boss-arena.js?v=3.12','./arena-fx.js?v=3.12','./campaign-run.js?v=3.12','./campaign-run.css?v=3.12','./easy-ending.js?v=3.12','./arena-controls.js?v=3.12','./arena-controls.css?v=3.12','./swift.js?v=3.12','./arena-combat.js?v=3.12','./arena-art.js?v=3.12','./arena-sound.js?v=3.12','./arena-net.js?v=3.12','./arena-roster.js?v=3.12','./controls.js?v=3.12','./control-settings.js?v=3.12','./control-settings.css?v=3.12','./pause-menu.js?v=3.12','./pause-menu.css?v=3.12','./network.js?v=3.12','./arena-motion.js?v=3.12','./arena.js?v=3.12','./arena.css?v=3.12','./world-life.js?v=3.12','./world-life.css?v=3.12','./','./index.html','./abertura.js?v=3.12','./abertura.css?v=3.12','./style.css?v=3.12','./theme.css?v=3.12','./safari.css?v=3.12','./menu.css?v=3.12','./menu.js?v=3.12','./cinema.css?v=3.12','./ranch-stats.css?v=infinito1','./bivolt.css?v=3.12','./baile.css?v=3.12','./hud.js?v=infinito1','./epilogue.js?v=3.12','./resenha.js?v=3.12','./coop.js?v=3.12','./coop.css?v=3.12','./graphics.js?v=autobaixa1','./shader.js?v=3.12','./world.js?v=amanda1','./campaign.js?v=lugares1','./progression.js?v=infinito1','./activities.js?v=pixel1','./art.js?v=lugares1','./char-detail.js?v=3.12','./brainrots.js?v=3.12','./chegada-carro.js?v=3.12','./estrada.js?v=3.12','./cinematics.js?v=chao1','./roteiro.js?v=3.12','./campanha2/cutscenes.js?v=3.12','./campanha2/oficina.js?v=3.12','./campanha2/aliados.js?v=trajes1','./campanha2/botoes.js?v=3.12','./campanha2/perseguicao-moto.js?v=perseguicao1','./campanha2/jorge-duelo.js?v=duelo2','./campanha2/combate-chefes.js?v=ritmo3131','./campanha2/efeitos-chefes.js?v=perseguicao1','./campanha2/fases.js?v=perseguicao1','./campanha2/luta-c1.js?v=conquista1','./campanha2/jogo.js?v=perseguicao1','./campanha2/dev.js?v=3.12','./dev-mode.js?v=3.12','./vendor/qrcode.js?v=3.12','./fliperama.js?v=igor1','./musicas.js?v=amanda1','./audio.js?v=3.12','./musicas/lista.js','./musicas/lista.json','./musicas/musicas.txt','./controle.html','./controle.js','./controle.css','./visual.js?v=trajes1','./visual.css?v=3.12','./campanha2/roca-ui.css?v=3','./online.js?v=3.12','./servidor.json','./fliperama.css?v=3.12','./roteiro.css?v=3.12','./roteiros/lista.json','./roteiros/abertura.json','./roteiros/chegada_escola.json','./roteiros/chegada_academia.json','./roteiros/chegada_quadra.json','./roteiros/chegada_praca.json','./roteiros/chegada_favela.json','./roteiros/chegada_caderno.json','./roteiros/chegada_campo.json','./roteiros/chegada_bigodon.json','./roteiros/chegada_patio.json','./roteiros/chegada_rayssa.json','./roteiros/creditos.json','./roteiros/c2_abertura.json','./roteiros/c2_aeroporto.json','./roteiros/c2_voo.json','./roteiros/c2_chegada.json','./roteiros/c2_primeira_noite.json','./roteiros/c2_vilao_creuza.json','./roteiros/c2_derrota_creuza.json','./roteiros/c2_vilao_tonhao.json','./roteiros/c2_derrota_tonhao.json','./roteiros/c2_vilao_valdomiro.json','./roteiros/c2_derrota_valdomiro.json','./roteiros/c2_vilao_kaua.json','./roteiros/c2_derrota_kaua.json','./roteiros/c2_vilao_barao.json','./roteiros/c2_derrota_barao.json','./roteiros/c2_vilao_breno.json','./roteiros/c2_derrota_breno.json','./roteiros/c2_vilao_gemeos.json','./roteiros/c2_derrota_gemeos.json','./roteiros/c2_vilao_fred.json','./roteiros/c2_derrota_fred.json','./roteiros/c2_centro.json','./roteiros/c2_final.json','./roteiros/c2_creditos.json','./difficulty.js?v=3.12','./critters.js?v=3.12','./scene-life.js?v=3.12','./jorge-anime.js?v=semfx1','./cinema-fx.js?v=3.12','./boss-fx.js?v=3.12','./golpes.js?v=3','./game.js?v=roblox2','./lugares-c1.js?v=4','./lugares-fundos.js?v=2','./favela-casas.js?v=1','./nikolas-fx.js?v=1','./pixel-kit.js?v=1','./pescaria.js?v=pixel1','./farda.js?v=2','./bivolt.js?v=3.12','./baile.js?v=galpao1','./baile-pixel.js?v=3.12','./baile-galpao.js?v=2','./baile-concurso.js?v=pixel1','./joystick.js?v=3.12','./ui.js?v=infinito1','./speech.js?v=amanda1','./title.js?v=3.12','./install.js?v=trilhas21','./app-version.js?v=3131','./music-contexts.js?v=amanda1','./music/config.js?v=trilhas21','./music-player.js?v=trilhas21','./updates.js?v=3.12','./updates.css?v=3.12','./icon.svg','./manifest.webmanifest','./assets/pixel.ttf','./assets/space.ttf','./assets/app-icon-192.png','./assets/app-icon-512.png'];
const RECORDINGS='daroca-mp3-'+self.registration.scope;
const tracks=new Map(self.DAROCA_MUSIC_CONFIG.tracks.map(t=>[new URL(t.file,self.registration.scope).href,t.bytes]));
let preparing=null;

async function removeOldTracks(){
  const cache=await caches.open(RECORDINGS);
  for(const key of await cache.keys())if(!tracks.has(key.url))await cache.delete(key);
}

// Uma requisição de mídia pode trazer só alguns bytes. Só a resposta completa vai para o cache.
function isCompleteRecording(response,size){
  const total=response.headers.get('Content-Length');
  if(total!==null&&Number(total)!==size)return false;
  if(!/^(audio\/|application\/octet-stream)/i.test(response.headers.get('Content-Type')||''))return false;
  return response.status===200||response.status===206&&response.headers.get('Content-Range')==='bytes 0-'+(size-1)+'/'+size;
}
function completeRecording(response){
  if(response.status===200)return response;
  const headers=new Headers(response.headers);
  headers.delete('Content-Range');
  return new Response(response.body,{headers});
}

async function cachedRange(response,range,size){
  if(!range)return response;
  const match=/^bytes=(\d*)-(\d*)$/i.exec(range);
  if(!match||!match[1]&&!match[2])return response;
  const start=match[1]?Number(match[1]):Math.max(0,size-Number(match[2]));
  const end=match[1]&&match[2]?Math.min(size-1,Number(match[2])):size-1;
  if(start>=size||end<start)return new Response(null,{status:416,headers:{'Content-Range':'bytes */'+size}});
  const headers=new Headers(response.headers);
  headers.set('Accept-Ranges','bytes');
  headers.set('Content-Range','bytes '+start+'-'+end+'/'+size);
  headers.set('Content-Length',String(end-start+1));
  const blob=await response.blob();
  return new Response(blob.slice(start,end+1),{status:206,headers});
}

async function serveTrack(event,size){
  const {request}=event;
  const cache=await caches.open(RECORDINGS).catch(()=>null);
  const hit=await cache?.match(request.url);
  if(hit)return cachedRange(hit,request.headers.get('Range'),size);
  const online=await fetch(request);
  if(cache&&isCompleteRecording(online,size))event.waitUntil(cache.put(request.url,completeRecording(online.clone())).catch(()=>{}));
  return online;
}

async function prepareTracks(){
  const cache=await caches.open(RECORDINGS);
  for(const [url,size] of tracks){
    if(await cache.match(url))continue;
    const response=await fetch(url);
    if(!isCompleteRecording(response,size))throw new Error('MP3 indisponível');
    await cache.put(url,completeRecording(response));
  }
}

self.addEventListener('message',event=>{
  if(event.data?.type!=='preparar-trilhas')return;
  if(!preparing)preparing=prepareTracks().finally(()=>{preparing=null;});
  const reply=ready=>event.source?.postMessage({type:'trilhas-offline',ready});
  event.waitUntil(preparing.then(()=>reply(true),()=>reply(false)));
});
self.addEventListener('install',e=>e.waitUntil(caches.open(CACHE).then(c=>c.addAll(SHELL)).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(Promise.all([
  caches.keys().then(keys=>Promise.all(keys.filter(k=>k.startsWith('daroca-offline-')&&k!==CACHE).map(k=>caches.delete(k)))),
  removeOldTracks()
]).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{
  const u=new URL(e.request.url);
  if(e.request.method!=='GET'||u.origin!==self.location.origin)return;
  if(tracks.has(u.href)){e.respondWith(serveTrack(e,tracks.get(u.href)));return;}
  if(u.pathname.startsWith('/api/')||u.pathname.startsWith('/admin')||u.pathname.startsWith('/music/')&&u.pathname.endsWith('.mp3')||u.pathname.includes('/downloads/'))return;
  if(e.request.mode==='navigate'){
    e.respondWith(fetch(e.request).then(r=>{if(r.ok){const copy=r.clone();e.waitUntil(caches.open(CACHE).then(c=>c.put('./index.html',copy)));}return r;}).catch(()=>caches.match('./index.html')));
    return;
  }
  if(u.pathname.includes('/musicas/')&&/\.(mp3|ogg|m4a|wav)$/i.test(u.pathname))return;
  if(u.pathname.includes('/roteiros/')||u.pathname.includes('/musicas/')||u.pathname.endsWith('/servidor.json')){
    e.respondWith(fetch(e.request).then(r=>{if(r.ok){const copy=r.clone();e.waitUntil(caches.open(CACHE).then(c=>c.put(e.request,copy)));}return r;}).catch(()=>caches.match(e.request,{ignoreSearch:true})));
    return;
  }
  e.respondWith(caches.match(e.request).then(hit=>hit||fetch(e.request)));
});
