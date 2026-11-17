/* Original arcade effects and an offline, synthesized "biuriful" combo call. */
(() => {
 'use strict';
 const SILENCE='data:audio/wav;base64,UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAACAgICA';
 const voices=Array.from({length:2},()=>({audio:null,serial:0})),seen=new Map();
 let context=null,unlocked=false,index=0;
 const enabled=()=>window.GameMusic?.getStatus?.().enabled??document.getElementById('soundBtn')?.getAttribute('aria-pressed')==='true';
 function audioFor(voice){if(!voice.audio){voice.audio=new Audio();voice.audio.preload='auto';voice.audio.setAttribute('playsinline','');voice.audio.playsInline=true;}return voice.audio;}
 function unlock(){
  if(unlocked)return;unlocked=true;
  try{const Context=window.AudioContext||window.webkitAudioContext;if(Context){context=new Context();context.resume()?.catch(()=>{});}}catch{}
  for(const voice of voices){const audio=audioFor(voice),serial=++voice.serial;audio.src=SILENCE;Promise.resolve(audio.play()).then(()=>{if(voice.serial===serial)audio.pause();}).catch(()=>{});}
 }
 function sound(name,options={}){
  if(!enabled()||document.hidden)return false;
  const id=options.id;if(id!==undefined){if(seen.has(id))return false;seen.set(id,performance.now());if(seen.size>200)seen.delete(seen.keys().next().value);}
  if(!unlocked&&location.protocol==='file:')unlock();
  if(name==='biuriful'||name==='gugu-dada'){
   const voice=voices[index++%voices.length],audio=audioFor(voice);voice.serial++;audio.pause();audio.src='assets/sfx/'+name+'.mp3';audio.volume=Math.max(0,Math.min(1,(Number(options.volume)||.72)*(window.DarocaAudio?.sfx?.()??1)));audio.playbackRate=Math.max(.8,Math.min(1.3,Number(options.pitch)||1));
   Promise.resolve(audio.play()).catch(()=>{});return true;
  }
  if(!context||context.state!=='running')return false;
  const frequencies={hit:[155,65,.09],combo:[390,92,.22],ko:[460,45,.36],jump:[240,540,.08],dash:[370,130,.07],emote:[660,880,.12]},values=frequencies[name]||frequencies.hit;
  try{const at=context.currentTime,osc=context.createOscillator(),gain=context.createGain();osc.type=name==='combo'?'sawtooth':'triangle';osc.frequency.setValueAtTime(values[0],at);osc.frequency.exponentialRampToValueAtTime(values[1],at+values[2]);gain.gain.setValueAtTime(Math.max(.001,(window.DarocaAudio?.sfx?.()??1)*Math.min(.12,Number(options.volume)||.055)),at);gain.gain.exponentialRampToValueAtTime(.001,at+values[2]);osc.connect(gain);gain.connect(context.destination);osc.start(at);osc.stop(at+values[2]);osc.onended=()=>{osc.disconnect();gain.disconnect();};return true;}catch{return false;}
 }
 document.addEventListener('pointerdown',event=>{if(event.isTrusted)unlock();},{capture:true,passive:true});
 document.addEventListener('keydown',event=>{if(event.isTrusted)unlock();},{capture:true});
 window.addEventListener('arena-sfx',event=>sound(event.detail?.name||'hit',event.detail||{}));
 window.addEventListener('arena-open',()=>seen.clear());
 window.addEventListener('daroca-native-resume',()=>{if(enabled())context?.resume()?.catch(()=>{});});
 document.getElementById('soundBtn')?.addEventListener('click',()=>{if(!enabled())for(const voice of voices)voice.audio?.pause();});
 window.ArenaSound=Object.freeze({play:sound,reset:()=>seen.clear(),unlock});
})();
