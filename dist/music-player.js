/* Two reusable media voices, smooth transitions, and local-only music inside APKs. */
(() => {
 'use strict';
 const VERSION=1,CONFIG_CACHE='daroca-music-config-cache-v1',PREF='daroca-music-enabled',DAY=86400000;
 const SCENES=['roca','escola','academia','quadra','camacan','favela','caderno','campo','bigodon','patio','rayssa','baile'];
 const SILENCE='data:audio/wav;base64,UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAACAgICA';
 const isNative=location.protocol==='file:';
 const nativeAndroid=isNative&&new URLSearchParams(location.search).get('native')==='android';
 const isWeb=['https:','http:'].includes(location.protocol);
 const clamp=(v,a,b)=>Math.max(a,Math.min(b,v)),number=(v,f)=>Number.isFinite(Number(v))?Number(v):f;
 const now=()=>performance.now();
 const empty=()=>({schema:1,revision:0,masterVolume:.7,defaultFadeMs:1200,categories:[],tracks:[],bindings:Object.create(null)});
 let config=empty(),source='bundled',ready=false,enabled=false,unlocked=false,audioContext=null,voices=[],active=-1,requestGeneration=0,loadGeneration=0,loading=null;
 let context='menu.title',matchedContext=null,override=null,desired=null,lastAttempt='',lastError='',configError='',lastRemoteAt=0,lastControl='',lastPressed=null,nativePaused=false;
 let transition=false,lastFocusReload=0,lastContextSync=-Infinity,lastAudioState=null,gamePaused=false,overrideSerial=0,filmClock=null;
 const ARENA_SHUFFLE='arena.shuffle';
 const arenaPlaylist={open:false,session:0,matchId:null,currentId:null,lastId:null,bag:[],library:'',serial:0,failed:new Set()};
 // A native game can start its bundled soundtrack immediately; an explicit mute
 // remains authoritative on every following launch. Browsers still need a gesture.
 try{const preference=localStorage.getItem(PREF);enabled=preference===null?isNative:preference==='true';}catch{enabled=isNative;}
 function normaliseConfig(raw){
  if(!raw||raw.schema!==VERSION||!Array.isArray(raw.tracks)||!raw.bindings||typeof raw.bindings!=='object')throw Error('Configuração de trilhas inválida.');
  const c=empty();c.revision=Math.max(0,Math.floor(number(raw.revision,0)));c.masterVolume=clamp(number(raw.masterVolume,.7),0,1);c.defaultFadeMs=clamp(number(raw.defaultFadeMs,1200),0,10000);
  c.categories=(Array.isArray(raw.categories)?raw.categories:[]).filter(x=>x&&typeof x.id==='string'&&typeof x.name==='string').slice(0,100).map(x=>({id:x.id.slice(0,80),name:x.name.slice(0,100)}));
  const seen=new Set();
  for(const t of raw.tracks.slice(0,200)){
   if(!t||typeof t.id!=='string'||!(/^[a-f0-9]{64}$/i.test(t.id))||seen.has(t.id))continue;
   const id=t.id.toLowerCase(),file='music/'+id+'.mp3';if(t.file&&t.file!==file)continue;seen.add(id);
   c.tracks.push({id,title:String(t.title||'Trilha').slice(0,140),categoryId:String(t.categoryId||'maps').slice(0,80),file,sha256:id,bytes:Math.max(0,number(t.bytes,0)),duration:Math.max(0,number(t.duration,0)),volume:clamp(number(t.volume,1),0,1),loop:t.loop!==false,fadeMs:clamp(number(t.fadeMs,c.defaultFadeMs),0,10000),url:!isNative&&typeof t.url==='string'&&t.url==='/music/'+id+'.mp3'?t.url:undefined});
  }
  for(const[id,b]of Object.entries(raw.bindings)){
   if(!/^[a-zA-Z0-9_.-]{1,90}$/.test(id)||!b||typeof b!=='object'||!c.tracks.some(t=>t.id===b.trackId))continue;
   c.bindings[id]={trackId:b.trackId,enabled:b.enabled!==false};
   if(b.volume!==undefined)c.bindings[id].volume=clamp(number(b.volume,1),0,1);
   if(b.loop!==undefined)c.bindings[id].loop=b.loop!==false;
   if(b.fadeMs!==undefined)c.bindings[id].fadeMs=clamp(number(b.fadeMs,c.defaultFadeMs),0,10000);
   if(b.startSeconds!==undefined)c.bindings[id].startSeconds=clamp(Math.round(number(b.startSeconds,0)*100)/100,0,86400);
   if(b.delaySeconds!==undefined)c.bindings[id].delaySeconds=clamp(Math.round(number(b.delaySeconds,0)*100)/100,0,3600);
  }
  return c;
 }
 function readCache(){if(isNative)return null;try{const cached=JSON.parse(localStorage.getItem(CONFIG_CACHE)||'null');return cached&&Date.now()-cached.at<DAY?normaliseConfig(cached.config):null;}catch{return null;}}
 function saveCache(c){try{localStorage.setItem(CONFIG_CACHE,JSON.stringify({at:Date.now(),config:c}));}catch{}}
 async function fetchConfig(url){const controller=typeof AbortController==='function'?new AbortController():null,timer=setTimeout(()=>controller?.abort(),6000);try{const r=await fetch(url,{cache:'no-store',credentials:'same-origin',signal:controller?.signal});if(!r.ok)throw Error('HTTP '+r.status);return normaliseConfig(await r.json());}finally{clearTimeout(timer);}}
 function applyConfig(c,nextSource){config=c;source=nextSource;ready=true;configError='';lastAttempt='';arenaPlaylist.failed.clear();refreshArenaLibrary();syncSelection();try{window.dispatchEvent(new CustomEvent('music-config-ready',{detail:{revision:c.revision,source:nextSource,tracks:c.tracks.length}}));}catch{}}
 async function reload(){
  if(loading)return loading;
  const generation=++loadGeneration;
  loading=(async()=>{
   let bundled=null;try{if(window.DAROCA_MUSIC_CONFIG)bundled=normaliseConfig(window.DAROCA_MUSIC_CONFIG);else bundled=await fetchConfig('music/config.json');}catch(e){configError='Não foi possível ler a configuração incluída no jogo.';}
   if(generation!==loadGeneration)return getStatus();
   const cached=readCache();if(bundled||cached)applyConfig(cached&&(!bundled||cached.revision>=bundled.revision)?cached:bundled,cached&&(!bundled||cached.revision>=bundled.revision)?'cache':'bundled');
   if(!isNative&&isWeb&&!window.DAROCA_LAN){
    try{const remote=await fetchConfig('/api/music/config');if(generation===loadGeneration){lastRemoteAt=Date.now();applyConfig(remote,'remote');saveCache(remote);}}
    catch(e){if(!ready){ready=true;source='bundled';}configError='A configuração online não respondeu; usando as trilhas disponíveis neste aparelho.';}
   }else if(!ready)ready=true;
   return getStatus();
  })().finally(()=>{loading=null;});
  return loading;
 }
 function currentVolume(v,time=now()){if(!v.ramp)return v.volume||0;const r=v.ramp,p=r.end<=r.start?1:clamp((time-r.start)/(r.end-r.start),0,1);return r.from+(r.to-r.from)*p;}
 function gain(v,value,duration=0){const time=now(),from=currentVolume(v,time),target=clamp(value,0,1);v.volume=from;v.ramp={from,to:target,start:time,end:time+duration};if(v.gain&&audioContext){try{const t=audioContext.currentTime;v.gain.gain.cancelScheduledValues(t);v.gain.gain.setValueAtTime(from,t);if(duration>0)v.gain.gain.linearRampToValueAtTime(target,t+duration/1000);else v.gain.gain.setValueAtTime(target,t);}catch{}}else{try{v.audio.volume=duration>0?from:target;}catch{}}}
 function makeVoices(){
  if(voices.length)return;
  const Context=window.AudioContext||window.webkitAudioContext;
  try{if(Context&&!nativeAndroid)audioContext=new Context();}catch{audioContext=null;}
  for(let index=0;index<2;index++){
   const audio=new Audio();audio.preload='auto';audio.setAttribute?.('playsinline','');audio.playsInline=true;audio.loop=false;audio.volume=1;
   const v={audio,index,gain:null,volume:0,ramp:null,id:null,src:null,loop:false,loads:0,plays:0,seeks:0,ended:false,warming:false,pending:0,cueKey:null,startSeconds:0,cutsceneIndex:null,cancelMetadata:null};
   try{if(audioContext){const media=audioContext.createMediaElementSource(audio),node=audioContext.createGain();node.gain.value=0;media.connect(node);node.connect(audioContext.destination);v.gain=node;}}catch{v.gain=null;}
   if(!v.gain)audio.volume=0;
   audio.addEventListener('ended',()=>{v.ended=true;if(desired?.arenaShuffle&&arenaPlaylist.open&&active===v.index&&v.cueKey===desired.cueKey){nextArenaTrack();lastAttempt='';syncSelection(true);}else if(v.loop&&enabled&&unlocked&&!suspended()&&active===v.index){lastAttempt='';syncSelection(true);}});audio.addEventListener('playing',()=>{v.ended=false;});
   audio.addEventListener('error',()=>{if(v.id&&!v.warming){lastError='Não foi possível reproduzir “'+(config.tracks.find(t=>t.id===v.id)?.title||'esta trilha')+'”.';if(active===v.index)active=-1;if(desired?.arenaShuffle&&arenaPlaylist.open&&arenaPlaylist.currentId===v.id){arenaPlaylist.failed.add(v.id);nextArenaTrack();lastAttempt='';syncSelection(true);}}});
   voices.push(v);
  }
 }
 function suspended(){return nativePaused||gamePaused||!!document.hidden;}
 function unlock(){
  makeVoices();unlocked=true;lastAttempt='';
  try{const resume=audioContext?.resume();resume?.catch(()=>{lastError='Toque no botão de som para liberar o áudio.';});}catch{}
  // Safari authorizes each reused media element during this direct user gesture.
  for(const v of voices)if(!v.src&&!v.warming){v.warming=true;const generation=requestGeneration;try{v.audio.src=SILENCE;v.audio.loop=false;const p=v.audio.play();Promise.resolve(p).then(()=>{if(v.warming&&!v.id&&generation===requestGeneration)v.audio.pause();}).catch(()=>{}).finally(()=>{v.warming=false;});}catch{v.warming=false;}}
  syncSelection(true);return Promise.resolve(audioContext?.state==='running'||!audioContext);
 }
 function setEnabled(value,persist=true){enabled=!!value;if(persist)try{localStorage.setItem(PREF,String(enabled));}catch{}if(!enabled){requestGeneration++;lastAttempt='';for(const v of voices){v.cancelMetadata?.();gain(v,0,0);v.audio.pause();}transition=false;}else{lastAttempt='';if(unlocked)syncSelection(true);}return enabled;}
 function normalName(value){return String(value||'').normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/[^a-z0-9]+/g,' ').trim();}
 const speakers=[['irmao de clara swift','swift'],['igor','igor'],['kaique','kaique'],['ana laura','analaura'],['nicolas carvalho','nicolas'],['nicolas','nicolas'],['nikolas','nikolas'],['da roca','daroca'],['gabriel mota','mota'],['gabriel reis','reeis'],['reeis','reeis'],['reis','reeis'],['menezes','menezes'],['lucas','lucas'],['caleb','caleb'],['kaua','kaua'],['marco','marco'],['ravid','ravid'],['mota','mota'],['colosso','giant'],['almiro','almiro'],['miqueias','miqueias'],['davi','davi'],['vitor','vitor'],['freddy','freddy'],['dede','dede'],['aica','aica'],['ravile','ravile'],['arthur','arthur'],['allef','allef'],['eloisa','eloisa'],['giselle','giselle'],['rayssa','rayssa']];
 function shuffled(ids){const bag=[...ids];for(let i=bag.length-1;i>0;i--){const j=Math.floor(Math.random()*(i+1));[bag[i],bag[j]]=[bag[j],bag[i]];}return bag;}
 function refreshArenaLibrary(){
  const ids=config.tracks.map(track=>track.id),signature=[...ids].sort().join('|');
  if(signature===arenaPlaylist.library)return;
  arenaPlaylist.library=signature;
  for(const id of arenaPlaylist.failed)if(!ids.includes(id))arenaPlaylist.failed.delete(id);
  if(arenaPlaylist.currentId&&!ids.includes(arenaPlaylist.currentId))arenaPlaylist.currentId=null;
  arenaPlaylist.bag=shuffled(ids.filter(id=>id!==arenaPlaylist.currentId&&!arenaPlaylist.failed.has(id)));
 }
 function nextArenaTrack(){
  refreshArenaLibrary();
  const ids=config.tracks.map(track=>track.id).filter(id=>!arenaPlaylist.failed.has(id));
  arenaPlaylist.bag=arenaPlaylist.bag.filter(id=>ids.includes(id));
  if(!ids.length){arenaPlaylist.currentId=null;return null;}
  if(!arenaPlaylist.bag.length)arenaPlaylist.bag=shuffled(ids);
  // Avoid a repeat at the boundary between two shuffled passes or two sessions.
  const previous=arenaPlaylist.currentId||arenaPlaylist.lastId;
  if(arenaPlaylist.bag[0]===previous&&ids.length>1){
   const alternative=arenaPlaylist.bag.findIndex(id=>id!==previous);
   if(alternative>=0)[arenaPlaylist.bag[0],arenaPlaylist.bag[alternative]]=[arenaPlaylist.bag[alternative],arenaPlaylist.bag[0]];
   else{arenaPlaylist.bag=[];return nextArenaTrack();}
  }
  arenaPlaylist.currentId=arenaPlaylist.bag.shift();arenaPlaylist.lastId=arenaPlaylist.currentId;arenaPlaylist.serial++;
  return arenaPlaylist.currentId;
 }
 function arenaStatus(){try{return window.Arena?.getStatus?.()||null;}catch{return null;}}
 function updateArenaPlaylist(arena){
  if(!arena?.open){arenaPlaylist.open=false;arenaPlaylist.currentId=null;arenaPlaylist.matchId=null;return false;}
  refreshArenaLibrary();
  const matchId=typeof arena.matchId==='string'&&arena.matchId?arena.matchId:null;
  if(!arenaPlaylist.open){arenaPlaylist.open=true;arenaPlaylist.session++;arenaPlaylist.failed.clear();arenaPlaylist.matchId=matchId;nextArenaTrack();}
  else if(matchId&&matchId!==arenaPlaylist.matchId){
   const rematch=arenaPlaylist.matchId!==null;arenaPlaylist.matchId=matchId;
   // Entering the first countdown keeps the lobby song flowing. A rematch
   // gets a fresh song, while repeated snapshots keep the same selection.
   if(rematch)nextArenaTrack();
  }
  if(!arenaPlaylist.currentId)nextArenaTrack();
  return true;
 }
 function selectArena(){
  const track=config.tracks.find(t=>t.id===arenaPlaylist.currentId);if(!track){matchedContext=null;return null;}
  matchedContext=ARENA_SHUFFLE;
  return{track,key:ARENA_SHUFFLE,src:isNative?track.file:track.url||track.file,loop:false,volume:clamp(config.masterVolume*track.volume,0,1),fadeMs:track.fadeMs,startSeconds:0,delaySeconds:0,cutscene:false,token:null,elapsed:0,index:null,arenaShuffle:true,cueKey:'arena|'+arenaPlaylist.session+'|'+arenaPlaylist.serial+'|'+track.id};
 }
 function candidates(){
  lastAudioState=null;if(override){try{lastAudioState=window.Game?.getAudioState?.()||null;}catch{}return[override];}
  let party=null,coop=null,state=null;try{party=window.PartyGame?.getStatus?.();}catch{}
  if(updateArenaPlaylist(arenaStatus()))return[ARENA_SHUFFLE];
  try{const challenge=window.WorldLife?.getStatus?.();if(challenge?.open&&['pump','memory','sort'].includes(challenge.kind)){const game=window.Game?.getAudioState?.();lastAudioState=game||null;return['activities.'+challenge.kind,'maps.'+(SCENES[game?.scene]||'roca'),'menu.title'];}}catch{}
  if(party?.open){if(party.view!=='live')return['party.menu','menu.title'];if(party.phase==='board')return['party.board','party.menu'];if(party.phase==='ceremony')return['party.ceremony','party.menu'];if(party.phase==='results')return['party.results',party.game?'party.'+party.game:'party.menu','party.menu'];return[party.game?'party.'+party.game:'party.menu','party.menu'];}
  try{coop=window.CoopArena?.getStatus?.();}catch{}
  if(coop?.open){if(!coop.stage)return['coop.menu','menu.title'];if(coop.stage==='victory')return['events.celebration','coop.menu'];if(coop.stage==='defeat')return['events.defeat','coop.menu'];return[coop.boss?.type?'coop.'+coop.boss.type:'coop.menu','coop.menu'];}
  if(window.Fliperama?.isOpen?.())return['minigames.fliperama','activities.memory','menu.title'];try{state=window.Game?.getAudioState?.();lastAudioState=state||null;}catch{}
  if(!state)return['menu.title'];
  const map='maps.'+(SCENES[Number(state.scene)]||SCENES[0]);
  if(state.chapterEnded)return['events.chapter_end'];
  if(!state.started||state.playing===false)return['menu.title'];
  if(state.cutscene)return['cutscenes.'+String(state.cutscene),...(window.Roteiro?.musicFor?.(state.cutscene)||[]),'events.'+String(state.cutscene),map];
  if(state.paused)return['menu.pause',map];
  if(state.defeated)return['events.defeat',map];
  if(state.boss)return[...(Number.isInteger(state.bossPhase)&&state.bossPhase>0?['battles.'+state.boss+'.phase'+state.bossPhase]:[]),'battles.'+state.boss,map];
  if(state.reeis&&['running','charging','transforming','arriving','invoke'].includes(state.reeis))return['events.reeis_transform',map];
  if(state.training)return['activity.caleb',map];
  if(state.activity){const key=['football','mota','soccer'].includes(state.activity)?'mota':['english','quiz'].includes(state.activity)?'english':state.activity;return['activity.'+key,map];}
  const room=state.room?'rooms.'+state.room:null;
  if(state.dialogue){const name=normalName(state.dialogue),character=speakers.find(([alias])=>name===alias||name.startsWith(alias+' ')||name.endsWith(' '+alias));if(character)return['characters.'+character[1],...(room?[room]:[]),map];}
  return[...(room?[room]:[]),map];
 }
 function isCutsceneTimed(kind){const b=config.bindings['cutscenes.'+kind];return !!(b&&b.enabled!==false&&config.tracks.some(t=>t.id===b.trackId));}
 function select(){
  const list=candidates();context=list[0]||'menu.title';
  if(context===ARENA_SHUFFLE)return selectArena();
  for(const key of list){
   const binding=config.bindings[key];if(!binding||binding.enabled===false)continue;const track=config.tracks.find(t=>t.id===binding.trackId);if(!track)continue;
   const cutsceneKind=lastAudioState?.cutscene,legacyCue=key==='events.'+cutsceneKind&&(binding.startSeconds!==undefined||binding.delaySeconds!==undefined),cutscene=!!(cutsceneKind&&(key==='cutscenes.'+cutsceneKind||legacyCue))||!!(override&&key.startsWith('cutscenes.'));
   const startSeconds=binding.startSeconds||0,delaySeconds=cutscene?binding.delaySeconds||0:0,token=cutscene?(override?'override-'+overrideSerial:lastAudioState?.cutsceneToken??cutsceneKind):null;
   matchedContext=key;
   return{track,key,src:isNative?track.file:track.url||track.file,loop:binding.loop===undefined?track.loop:binding.loop,volume:clamp(config.masterVolume*track.volume*(binding.volume===undefined?1:binding.volume),0,1),fadeMs:binding.fadeMs===undefined?track.fadeMs:binding.fadeMs,startSeconds,delaySeconds,cutscene,token,elapsed:cutscene?Math.max(0,number(lastAudioState?.cutsceneElapsed,0)):0,index:cutscene?lastAudioState?.cutsceneIndex??0:null,cueKey:cutscene?'film|'+token+'|'+key+'|'+startSeconds+'|'+delaySeconds:startSeconds>0?'offset|'+track.id+'|'+startSeconds:null};
  }
  matchedContext=null;return null;
 }
 function timelineSelection(selection){
  if(!selection?.cutscene){filmClock=null;return selection;}
  const time=now(),running=!nativePaused&&!document.hidden&&!lastAudioState?.paused;
  if(!filmClock||filmClock.key!==selection.cueKey)filmClock={key:selection.cueKey,elapsed:selection.elapsed,lastAt:time,running};
  else{if(filmClock.running)filmClock.elapsed+=Math.max(0,time-filmClock.lastAt)/1000;filmClock.lastAt=time;filmClock.running=running;}
  // A shot's edited start time jumps when the player advances a speech bubble.
  // The soundtrack has its own continuous clock, so neither that jump nor a
  // slow animation frame seeks an already playing MP3. A replay gets a new token.
  return {...selection,elapsed:filmClock.elapsed};
 }
 function targetPosition(selection,audio){
  const duration=Number.isFinite(audio.duration)&&audio.duration>0?audio.duration:selection.track.duration,start=duration>0?Math.min(selection.startSeconds,Math.max(0,duration-.01)):selection.startSeconds;
  const raw=start+(selection.cutscene?Math.max(0,selection.elapsed-selection.delaySeconds):0);
  if(duration>0&&raw>=duration){if(selection.loop&&duration-start>.01)return{seconds:start+(raw-start)%(duration-start),ended:false};return{seconds:duration,ended:true};}
  return{seconds:raw,ended:false};
 }
 function waitMetadata(v,generation){
  if(typeof v.audio.readyState==='number'?v.audio.readyState>=1:Number.isFinite(v.audio.duration)&&v.audio.duration>0)return Promise.resolve(true);
  v.cancelMetadata?.();
  return new Promise(resolve=>{
   let timer,done=false;const finish=ok=>{if(done)return;done=true;clearTimeout(timer);v.audio.removeEventListener?.('loadedmetadata',loaded);v.audio.removeEventListener?.('error',failed);if(v.cancelMetadata===cancel)v.cancelMetadata=null;resolve(ok&&generation===requestGeneration&&v.pending===generation&&!suspended()&&enabled);};
   const loaded=()=>finish(true),failed=()=>finish(false),cancel=()=>finish(false);v.cancelMetadata=cancel;v.audio.addEventListener('loadedmetadata',loaded);v.audio.addEventListener('error',failed);timer=setTimeout(failed,8000);
  });
 }
 async function playVoice(v,selection,generation,seek=false){
  const same=v.id===selection.track.id&&v.src===selection.src;
  v.cancelMetadata?.();
  if(!same){v.audio.pause();gain(v,0,0);v.id=selection.track.id;v.src=selection.src;v.ended=false;v.warming=false;v.cueKey=null;v.audio.src=selection.src;v.loads++;v.audio.load?.();}
  v.loop=selection.loop;v.startSeconds=selection.startSeconds;v.audio.loop=selection.loop&&selection.startSeconds===0;
  const needsSeek=!same||seek||v.cueKey!==selection.cueKey||v.ended&&selection.loop;
  if(needsSeek&&(selection.cutscene||selection.arenaShuffle||selection.startSeconds>0||v.cueKey?.startsWith('offset|'))){
   if(!await waitMetadata(v,generation)){if(generation===requestGeneration&&!suspended()&&enabled)lastError='Não foi possível carregar o trecho da música. Toque no som para tentar novamente.';return false;}
   if(generation!==requestGeneration||v.pending!==generation||!enabled||suspended())return false;
   selection=timelineSelection(selection);const target=v.ended&&selection.loop?{seconds:Math.min(selection.startSeconds,Math.max(0,(v.audio.duration||selection.track.duration||Infinity)-.01)),ended:false}:targetPosition(selection,v.audio);
   if(target.ended){v.ended=true;v.cueKey=selection.cueKey;v.cutsceneIndex=selection.index;gain(v,0,0);v.audio.pause();return false;}
   try{v.audio.currentTime=target.seconds;v.seeks++;v.ended=false;}catch{lastError='Não foi possível posicionar o trecho da música.';return false;}
  }else if(needsSeek&&!same){try{v.audio.currentTime=0;}catch{}}
  v.cueKey=selection.cueKey;v.cutsceneIndex=selection.index;
  if(v.ended&&!selection.loop)return false;
  // A stale play promise must not pause a newer request reusing this element.
  try{if(audioContext&&audioContext.state!=='running')await audioContext.resume();if(generation!==requestGeneration||v.pending!==generation||!enabled||suspended())return false;const p=v.audio.play();v.plays++;await Promise.resolve(p);if(generation!==requestGeneration||!enabled||suspended()){if(active!==v.index&&v.pending===generation){gain(v,0,0);v.audio.pause();}return false;}return true;}
  catch(e){if(generation===requestGeneration){lastError=e?.name==='NotAllowedError'?'Toque novamente no botão de som para liberar a música.':'Não foi possível iniciar “'+selection.track.title+'”.';}return false;}
 }
 function silenceSelection(key,fade){
  if(lastAttempt===key)return;lastAttempt=key;requestGeneration++;active=-1;
  for(const v of voices){v.cancelMetadata?.();if(!v.audio.paused){gain(v,0,fade);if(fade<=0)v.audio.pause();}}transition=voices.some(v=>!v.audio.paused);
 }
 function syncSelection(force=false){
  const selection=timelineSelection(select());desired=selection;
  const nextPaused=!!(lastAudioState?.cutscene&&lastAudioState.paused);
  if(nextPaused!==gamePaused){gamePaused=nextPaused;if(gamePaused)pauseForLifecycle();else{lastAttempt='';try{audioContext?.resume()?.catch(()=>{});}catch{}}}
  if(!ready||!enabled||!unlocked||suspended())return;
  makeVoices();
  if(!selection){silenceSelection('none|'+context+'|'+config.revision,config.defaultFadeMs);return;}
  if(selection.cutscene&&selection.elapsed+.005<selection.delaySeconds){silenceSelection('wait|'+selection.cueKey+'|'+config.revision,selection.fadeMs);return;}
  const same=voices.find(v=>v.id===selection.track.id&&v.src===selection.src),cueChanged=same&&(selection.cueKey!==null&&same.cueKey!==selection.cueKey||selection.cueKey===null&&same.cueKey?.startsWith('offset|'));
  if(selection.cutscene&&(!same||same.cueKey!==selection.cueKey)&&targetPosition(selection,{duration:selection.track.duration}).ended){silenceSelection('end|'+selection.cueKey,selection.fadeMs);return;}
  if(same&&active===same.index&&!same.audio.paused&&!cueChanged){
   same.cueKey=selection.cueKey;same.cutsceneIndex=selection.index;same.loop=selection.loop;same.startSeconds=selection.startSeconds;same.audio.loop=selection.loop&&selection.startSeconds===0;const target=same.ramp?.to??same.volume;if(Math.abs(target-selection.volume)>.0001)gain(same,selection.volume,Math.min(300,selection.fadeMs));return;
  }
  const attempt=selection.track.id+'|'+selection.src+'|'+selection.loop+'|'+selection.key+'|'+selection.cueKey+'|'+config.revision;
  if(!force&&lastAttempt===attempt)return;
  if(same?.ended&&!selection.loop&&same.cueKey===selection.cueKey&&!cueChanged){lastAttempt=attempt;return;}
  lastAttempt=attempt;const generation=++requestGeneration,index=same?same.index:active===0?1:0,v=voices[index],old=active>=0?voices[active]:null;
  if(old!==v)gain(v,0,0);v.pending=generation;
  playVoice(v,selection,generation,cueChanged).then(ok=>{if(!ok||generation!==requestGeneration)return;active=index;lastError='';gain(v,selection.volume,selection.fadeMs);for(const other of voices)if(other!==v&&!other.audio.paused)gain(other,0,selection.fadeMs);transition=selection.fadeMs>0;}).finally(()=>{if(v.pending===generation)v.pending=0;});
 }
 function control(){let party=false;try{party=!!window.PartyGame?.getStatus?.().open;}catch{}const button=document.getElementById(party?'partySoundBtn':'soundBtn');if(!button)return;const pressed=button.getAttribute('aria-pressed')==='true',key=button.id;if(lastControl!==key||lastPressed!==pressed){const first=!lastControl;lastControl=key;lastPressed=pressed;if(!first||!enabled)setEnabled(pressed,false);}}
 function tick(){
  const time=now();let fading=false;
  for(const v of voices){const level=currentVolume(v,time);if(!v.gain)try{v.audio.volume=clamp(level,0,1);}catch{}if(v.ramp&&time>=v.ramp.end){v.volume=v.ramp.to;v.ramp=null;if(v.volume===0&&active!==v.index&&!v.pending&&!v.audio.paused)v.audio.pause();}if(v.ramp)fading=true;}
  transition=fading;if(time-lastContextSync>=(lastAudioState?.cutscene?40:150)){lastContextSync=time;control();syncSelection();}
 }
 function pauseForLifecycle(){if(filmClock){if(filmClock.running)filmClock.elapsed+=Math.max(0,now()-filmClock.lastAt)/1000;filmClock.lastAt=now();filmClock.running=false;}requestGeneration++;lastAttempt='';for(const v of voices){v.cancelMetadata?.();gain(v,0,0);v.audio.pause();}transition=false;try{audioContext?.suspend()?.catch(()=>{});}catch{}}
 function resumeForLifecycle(){if(filmClock){filmClock.lastAt=now();filmClock.running=!suspended();}if(suspended()||!enabled||!unlocked)return;lastAttempt='';try{audioContext?.resume()?.then(()=>syncSelection(true)).catch(()=>{lastError='Toque no botão de som para retomar a música.';});if(!audioContext)syncSelection(true);}catch{}}
 function isPlaying(){return enabled&&unlocked&&!suspended()&&(!audioContext||audioContext.state==='running')&&voices.some(v=>!v.audio.paused&&!v.audio.ended&&currentVolume(v)>.0001);}
 function getStatus(){return{ready,enabled,unlocked,native:isNative,source,revision:config.revision,context,matchedContext,trackId:desired?.track.id||null,title:desired?.track.title||null,startSeconds:desired?.startSeconds||0,delaySeconds:desired?.delaySeconds||0,cutsceneToken:desired?.token??null,cutsceneElapsed:desired?.elapsed??null,waiting:!!(desired?.cutscene&&desired.elapsed<desired.delaySeconds),playing:isPlaying(),transitioning:transition,error:lastError||null,configError:configError||null,playlist:arenaPlaylist.open?{mode:'shuffle',size:config.tracks.length,currentTrackId:arenaPlaylist.currentId,remaining:arenaPlaylist.bag.length,session:arenaPlaylist.session,matchId:arenaPlaylist.matchId}:null,voices:voices.map(v=>({trackId:v.id,playing:!v.audio.paused&&!v.audio.ended,volume:Number(currentVolume(v).toFixed(5)),currentTime:Number(v.audio.currentTime)||0,duration:Number.isFinite(v.audio.duration)?v.audio.duration:0,loop:v.loop,loads:v.loads,plays:v.plays,seeks:v.seeks,cueKey:v.cueKey}))};}
 function setContext(id){override=typeof id==='string'&&id?id:null;overrideSerial++;lastAttempt='';syncSelection(true);return getStatus();}
 document.addEventListener('click',event=>{const button=event.target?.closest?.('#soundBtn,#partySoundBtn,#epilogueSoundBtn');if(!button)return;const pressed=button.getAttribute('aria-pressed')==='true';setEnabled(!pressed);if(!pressed)unlock();},true);
 document.addEventListener('visibilitychange',()=>{if(document.hidden)pauseForLifecycle();else{resumeForLifecycle();if(Date.now()-lastFocusReload>10000){lastFocusReload=Date.now();reload();}}});
 window.addEventListener('daroca-native-pause',()=>{nativePaused=true;pauseForLifecycle();});window.addEventListener('daroca-native-resume',()=>{nativePaused=false;resumeForLifecycle();});
 window.addEventListener('online',()=>{lastAttempt='';reload();});window.addEventListener('music-config-changed',()=>reload());
 window.addEventListener('storage',e=>{if(e.key==='daroca-music-revision')reload();});
 try{if(typeof BroadcastChannel==='function'){const channel=new BroadcastChannel('daroca-music');channel.addEventListener('message',e=>{if(e.data?.type==='config-updated')reload();});}}catch{}
 const title=document.getElementById('startScreen'),sourceButton=document.getElementById('soundBtn');if(title&&sourceButton&&typeof title.append==='function'&&!document.getElementById('menuMusicBtn')){const button=document.createElement('button');button.id='menuMusicBtn';button.type='button';button.className='menu-music-control';button.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 18V5l11-2v13M9 9l11-2"/><circle cx="6" cy="18" r="3"/><circle cx="17" cy="16" r="3"/></svg><small>SOM</small>';const reflect=()=>{const on=sourceButton.getAttribute('aria-pressed')==='true';button.setAttribute('aria-pressed',String(on));button.setAttribute('aria-label',on?'Desativar músicas e efeitos':'Ativar músicas e efeitos');};button.addEventListener('click',()=>sourceButton.click());title.append(button);if(typeof MutationObserver==='function')new MutationObserver(reflect).observe(sourceButton,{attributes:true,attributeFilter:['aria-pressed']});reflect();}
 window.GameMusic=Object.freeze({hasSelection:()=>enabled&&!!desired,version:'3.7.0',isCutsceneTimed,unlock,setEnabled,isPlaying,getStatus,reload,setContext});
 // Retry pending browser autoplay on the first real interaction, without waiting
 // for the remote configuration request or requiring a second tap on the speaker.
 const firstGesture=event=>{if(event.isTrusted&&enabled&&(!unlocked||!isPlaying()))unlock();};
 document.addEventListener('pointerdown',firstGesture,{capture:true,passive:true});
 document.addEventListener('keydown',firstGesture,{capture:true});
 setInterval(tick,50);reload();
 if(enabled){if(sourceButton&&sourceButton.getAttribute('aria-pressed')!=='true')sourceButton.click();else unlock();}
})();
