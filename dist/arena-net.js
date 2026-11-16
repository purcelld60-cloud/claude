/* Data-only peer transport. HTTPS remains active during negotiation and failures. */
(() => {
 'use strict';
 const supported=()=>typeof window.RTCPeerConnection==='function';
 const seq=n=>Number.isSafeInteger(n)&&n>=0&&n<=2147483647;
 const nonce=()=>window.crypto?.randomUUID?.()||('rtc_'+Date.now().toString(36)+'_'+Math.random().toString(36).slice(2));
 function validInput(value){
  if(!value||typeof value!=='object'||Array.isArray(value)||!seq(value.seq))return false;
  for(const[key,item]of Object.entries(value)){
   if(key==='x'||key==='y'){if(typeof item!=='number'||!Number.isFinite(item)||Math.abs(item)>1)return false;}
   else if(key==='response'){if(typeof item!=='number'||!Number.isFinite(item)||item<.5||item>2)return false;}
   else if(key==='jump'){if(typeof item!=='boolean')return false;}
   else if(key==='aim'){if(!Number.isInteger(item)||item<0||item>4)return false;}
   else if(!['seq','jumpPress','attack','special','ultimate','dash','emote'].includes(key)||!seq(item))return false;
  }
  return true;
 }
 function create(options={}){
  const code=options.code||options.roomCode,myId=options.playerId,isHost=!!options.isHost,hostId=isHost?myId:options.hostPlayerId;
  const peers=new Map(),retry=new Map(),pendingIce=new Map(),metrics={signals:0,batches:0,polls:0,descriptions:0};
  let roster=new Set(),closed=false,cursor=0,pollTimer=0,polling=false,pollSoon=false,sending=false,lastInputAt=0,lastStateAt=0,lastNegotiationAt=performance.now(),statusKey='',queue=[];
  const enabled=supported()&&/^[A-Z0-9]{6}$/.test(code||'')&&typeof myId==='string'&&typeof hostId==='string'&&typeof options.request==='function';
  const endpoint='/api/arena/rooms/'+code+'/signal',safeCall=(name,...args)=>{try{options[name]?.(...args);}catch{}};
  const connected=peer=>peer.channel?.readyState==='open'&&!['failed','closed','disconnected'].includes(peer.pc.connectionState);
  function getStatus(){
   const list=[...peers.values()].map(p=>({id:p.id,open:connected(p),connection:p.pc.connectionState||'new',stage:connected(p)?'open':p.stage,pingMs:Number.isFinite(p.ping)?Math.round(p.ping):null,negotiationMs:Math.round((p.connectedAt||performance.now())-p.createdAt)})),count=list.filter(p=>p.open).length,total=isHost?Math.max(0,roster.size-1):roster.has(hostId)?1:0,pings=list.filter(p=>p.open&&p.pingMs!==null).map(p=>p.pingMs);
   return{supported:enabled,connected:count,directPeers:count,total,status:count>0?'realtime':'relay',pingMs:pings.length?Math.max(...pings):null,handshakeRequests:metrics.signals,iceBatches:metrics.batches,signalingPolls:metrics.polls,pendingSignals:queue.length+(sending?1:0),peers:list};
  }
  function status(){const value=getStatus(),key=JSON.stringify(value);if(key!==statusKey){statusKey=key;safeCall('onStatus',value);}}
  async function api(body){
   const response=await options.request(endpoint,{body}),data=typeof response?.json==='function'?await response.json():response;
   if(response?.ok===false||response?.status>=400||data?.error){const error=new Error(typeof data?.error==='string'?data.error:'Conexão direta indisponível.');error.status=response?.status;throw error;}
   return data;
  }
  function insert(item){
   if(item.kind==='offer'||item.kind==='answer'){const at=queue.findIndex(q=>q.kind!=='offer'&&q.kind!=='answer');queue.splice(at<0?queue.length:at,0,item);}
   else queue.push(item);
  }
  function enqueue(to,kind,data){if(closed||queue.length>=80)return;insert({op:'send',to,kind,data,nonce:nonce(),attempts:0});drain();}
  async function drain(){
   if(sending||closed)return;sending=true;
   try{while(queue.length&&!closed){const item=queue.shift();try{metrics.signals++;if(item.kind==='ice-batch')metrics.batches++;else if(item.kind==='offer'||item.kind==='answer')metrics.descriptions++;await api(item);}catch(error){if([401,403,404,410].includes(error.status)||++item.attempts>=3){status();continue;}await new Promise(resolve=>setTimeout(resolve,error.status===429?1100:400*item.attempts));if(!closed)insert(item);}}}
   finally{sending=false;status();}
  }
  function remove(id,again=false){
   const peer=peers.get(id);if(peer){peers.delete(id);pendingIce.delete(id+'|'+peer.session);clearTimeout(peer.iceTimer);clearTimeout(peer.pingTimer);queue=queue.filter(q=>q.to!==id||q.data?.session!==peer.session);try{peer.channel?.close();peer.pc.close();}catch{}}
   if(again){const old=retry.get(id)||{tries:0};retry.set(id,{tries:old.tries,nextAt:performance.now()+Math.min(15000,2500*Math.max(1,old.tries))});}status();
  }
  function flushLocalIce(peer){
   clearTimeout(peer.iceTimer);peer.iceTimer=0;if(closed||peers.get(peer.id)!==peer||!peer.descriptionQueued)return;
   while(peer.outgoingIce.length){const candidates=[];while(peer.outgoingIce.length&&candidates.length<16){const value=peer.outgoingIce[0];if(candidates.length&&JSON.stringify([...candidates,value]).length>22000)break;candidates.push(peer.outgoingIce.shift());}enqueue(peer.id,'ice-batch',{session:peer.session,candidates});}
  }
  function ping(peer){
   clearTimeout(peer.pingTimer);if(closed||peers.get(peer.id)!==peer)return;
   if(connected(peer)){const n=++peer.pingSeq,t=performance.now();peer.pendingPing={n,t};try{peer.channel.send(JSON.stringify({v:1,kind:'ping',n,t}));}catch{}}
   peer.pingTimer=setTimeout(()=>ping(peer),3000);
  }
  function bindChannel(peer,channel){
   if(channel.label!=='roca-arena-v1'){channel.close();return;}peer.channel=channel;
   channel.onopen=()=>{if(closed)return;peer.connectedAt=performance.now();ping(peer);status();};channel.onclose=()=>status();channel.onerror=()=>status();
   channel.onmessage=event=>{
    if(closed||peers.get(peer.id)!==peer||!roster.has(peer.id)||typeof event.data!=='string'||event.data.length>32768)return;
    let packet;try{packet=JSON.parse(event.data);}catch{return;}if(packet?.v!==1)return;
    if(packet.kind==='ping'&&seq(packet.n)&&Number.isFinite(packet.t)){try{channel.send(JSON.stringify({v:1,kind:'pong',n:packet.n,t:packet.t}));}catch{}return;}
    if(packet.kind==='pong'){const sent=peer.pendingPing;if(sent&&packet.n===sent.n&&packet.t===sent.t){const elapsed=performance.now()-sent.t;if(elapsed>=0&&elapsed<10000){peer.ping=Number.isFinite(peer.ping)?peer.ping*.7+elapsed*.3:elapsed;peer.pendingPing=null;status();}}return;}
    if(!packet.value||typeof packet.value!=='object')return;
    if(isHost&&packet.kind==='input'&&validInput(packet.value)&&packet.value.seq>peer.inputSeq){peer.inputSeq=packet.value.seq;safeCall('onInput',peer.id,packet.value);}
    else if(!isHost&&peer.id===hostId&&packet.kind==='state'&&seq(packet.value.seq)&&packet.value.seq>peer.stateSeq){peer.stateSeq=packet.value.seq;safeCall('onState',packet.value);}
   };
  }
  function makePeer(id,session){
   lastNegotiationAt=performance.now();const pc=new RTCPeerConnection({iceServers:[{urls:'stun:stun.cloudflare.com:3478'},{urls:'stun:stun.l.google.com:19302'}],iceCandidatePoolSize:0});
   const peer={id,pc,session,stage:isHost?'creating-offer':'answering',descriptionQueued:false,channel:null,inputSeq:-1,stateSeq:-1,ice:[],outgoingIce:[],candidateKeys:new Set(),iceTimer:0,pingTimer:0,pingSeq:0,pendingPing:null,ping:null,createdAt:performance.now(),connectedAt:null};peers.set(id,peer);
   pc.onicecandidate=event=>{
    if(!event.candidate){flushLocalIce(peer);return;}if(closed||peers.get(id)!==peer||peer.candidateKeys.size>=48)return;
    const value=typeof event.candidate.toJSON==='function'?event.candidate.toJSON():event.candidate,key=value.candidate+'|'+value.sdpMid+'|'+value.sdpMLineIndex;if(peer.candidateKeys.has(key))return;peer.candidateKeys.add(key);
    peer.outgoingIce.push({candidate:value.candidate,sdpMid:value.sdpMid??null,sdpMLineIndex:value.sdpMLineIndex??null});if(peer.outgoingIce.length>=16)flushLocalIce(peer);else if(!peer.iceTimer)peer.iceTimer=setTimeout(()=>flushLocalIce(peer),120);
   };
   pc.onicegatheringstatechange=()=>{if(pc.iceGatheringState==='complete')flushLocalIce(peer);};
   pc.onconnectionstatechange=()=>{if(closed||peers.get(id)!==peer)return;if(pc.connectionState==='failed'||pc.connectionState==='closed')remove(id,isHost);else status();};
   if(isHost)bindChannel(peer,pc.createDataChannel('roca-arena-v1',{ordered:false,maxRetransmits:0}));else pc.ondatachannel=event=>bindChannel(peer,event.channel);
   status();return peer;
  }
  async function offer(id){
   if(closed||peers.has(id)||!roster.has(id))return;const history=retry.get(id)||{tries:0,nextAt:0};if(history.tries>=4||history.nextAt>performance.now())return;retry.set(id,{tries:history.tries+1,nextAt:performance.now()+3000});let peer;
   try{peer=makePeer(id,nonce());const description=await peer.pc.createOffer();await peer.pc.setLocalDescription(description);if(!closed&&peers.get(id)===peer){peer.descriptionQueued=true;peer.stage='awaiting-answer';enqueue(id,'offer',{type:'offer',sdp:peer.pc.localDescription.sdp,session:peer.session});flushLocalIce(peer);}}catch{if(peer&&peers.get(id)===peer)remove(id,true);}
  }
  async function flushRemoteIce(peer){const key=peer.id+'|'+peer.session,candidates=[...(pendingIce.get(key)||[]),...peer.ice];pendingIce.delete(key);peer.ice=[];for(const value of candidates){try{await peer.pc.addIceCandidate(value);}catch{}}}
  async function accept(item){
   if(closed||item?.to!==myId||!roster.has(item.from)||item.from===myId||!item.data||typeof item.data.session!=='string')return;
   if(isHost&&item.from===hostId||!isHost&&item.from!==hostId)return;const data=item.data;let peer=peers.get(item.from);
   if(item.kind==='offer'){
    if(isHost)return;if(peer?.session===data.session&&peer.pc.remoteDescription)return;if(peer)remove(item.from);
    try{peer=makePeer(item.from,data.session);await peer.pc.setRemoteDescription({type:'offer',sdp:data.sdp});await flushRemoteIce(peer);const answer=await peer.pc.createAnswer();await peer.pc.setLocalDescription(answer);if(closed||peers.get(item.from)!==peer)return;peer.descriptionQueued=true;peer.stage='connecting';enqueue(item.from,'answer',{type:'answer',sdp:peer.pc.localDescription.sdp,session:peer.session});flushLocalIce(peer);}catch{if(peer)remove(item.from);}return;
   }
   if(item.kind==='answer'){
    if(!isHost||!peer||peer.session!==data.session||peer.pc.remoteDescription)return;try{await peer.pc.setRemoteDescription({type:'answer',sdp:data.sdp});peer.stage='connecting';await flushRemoteIce(peer);}catch{remove(item.from,true);}return;
   }
   if(item.kind==='ice'||item.kind==='ice-batch'){
    const candidates=item.kind==='ice-batch'?data.candidates:[data];if(!Array.isArray(candidates)||candidates.length>16)return;
    for(const c of candidates){if(!c||typeof c.candidate!=='string'||c.candidate.length>2048)continue;const candidate={candidate:c.candidate,sdpMid:c.sdpMid??null,sdpMLineIndex:c.sdpMLineIndex??null};
     if(peer&&peer.session===data.session){if(peer.pc.remoteDescription){try{await peer.pc.addIceCandidate(candidate);}catch{}}else if(peer.ice.length<48)peer.ice.push(candidate);}
     else{if(isHost)continue;const key=item.from+'|'+data.session;if(pendingIce.size>=12&&!pendingIce.has(key))continue;const list=pendingIce.get(key)||[];if(list.length<48){list.push(candidate);pendingIce.set(key,list);}}
    }
   }
  }
  function schedulePoll(delay){clearTimeout(pollTimer);if(closed||!enabled)return;if(polling){pollSoon=true;return;}pollTimer=setTimeout(poll,Math.max(0,delay));}
  async function poll(){
   if(closed||!enabled||polling)return;polling=true;pollSoon=false;const started=performance.now();metrics.polls++;
   try{const data=await api({op:'poll',after:cursor});if(closed)return;for(const item of data.signals||[]){try{await accept(item);}catch{}}if(Number.isSafeInteger(data.cursor)&&data.cursor>=cursor)cursor=data.cursor;}
   catch(error){if([401,403,404,410].includes(error.status)){close();return;}status();}
   finally{polling=false;if(!closed){reconcile();const value=getStatus(),idle=value.total===0||value.connected===value.total||performance.now()-lastNegotiationAt>25000;schedulePoll(pollSoon?0:Math.max(0,(idle?3000:250)-(performance.now()-started)));}}
  }
  function reconcile(){
   if(closed||!enabled)return;for(const[id,peer]of peers)if(!roster.has(id)||!isHost&&id!==hostId)remove(id);else if(!connected(peer)&&performance.now()-peer.createdAt>25000)remove(id,isHost);
   if(isHost)for(const id of roster)if(id!==myId&&!peers.has(id))offer(id);status();
  }
  function updateRoster(players){const previous=[...roster].sort().join('|');roster=new Set((Array.isArray(players)?players:[]).map(p=>typeof p==='string'?p:p?.id).filter(id=>typeof id==='string'));roster.add(myId);const changed=[...roster].sort().join('|')!==previous;if(changed)lastNegotiationAt=performance.now();for(const key of pendingIce.keys())if(!roster.has(key.split('|')[0]))pendingIce.delete(key);for(const id of retry.keys())if(!roster.has(id))retry.delete(id);reconcile();if(changed)schedulePoll(0);}
  function transmit(kind,value){
   if(closed||!enabled||!value||!seq(value.seq)||kind==='input'&&!validInput(value))return false;
   let data;try{data=JSON.stringify({v:1,kind,value});}catch{return false;}if(data.length>32768)return false;let sent=false;
   for(const peer of peers.values())if(connected(peer)&&peer.channel.bufferedAmount<65536){try{peer.channel.send(data);sent=true;}catch{}}return sent;
  }
  function sendInput(value){if(isHost)return false;const now=performance.now();if(now-lastInputAt<1000/30)return false;lastInputAt=now;return transmit('input',value);}
  function sendState(value){if(!isHost)return false;const now=performance.now();if(now-lastStateAt<1000/30)return false;lastStateAt=now;return transmit('state',value);}
  function close(){if(closed)return;closed=true;clearTimeout(pollTimer);queue=[];for(const id of [...peers.keys()])remove(id);pendingIce.clear();status();}
  if(enabled){updateRoster(options.players||[]);schedulePoll(0);}else status();
  return Object.freeze({updateRoster,sendInput,sendState,close,getStatus});
 }
 window.ArenaNet=Object.freeze({create,supported});
})();
