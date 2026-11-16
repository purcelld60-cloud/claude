/* Festa 3D: same-Wi-Fi rooms, trusted server seats, host-authoritative simulation. */
(() => {
 'use strict';
 const VERSION=1,MAX_PACKET=192000,PHASES=new Set(['board','intro','play','results','ceremony']);
 const safeName=value=>String(value||'Convidado').replace(/[<>\u0000-\u001f\u007f]/g,'').trim().slice(0,20)||'Convidado';
 const safeCharacter=value=>typeof value==='string'&&/^[a-z]{2,20}$/.test(value)?value:'daroca';
 const validId=id=>typeof id==='string'&&/^p[0-7]$/.test(id);
 function validState(s){return !!s&&s.v===VERSION&&PHASES.has(s.phase)&&Array.isArray(s.players)&&s.players.length>=4&&s.players.length<=8&&s.players.every(p=>p&&validId(p.id)&&['x','y','z'].every(k=>Number.isFinite(p[k])))&&new Set(s.players.map(p=>p.id)).size===s.players.length;}
 function cleanConfig(c={}){return{mode:['board','circuit','practice'].includes(c.mode)?c.mode:'board',rounds:[3,5,8].includes(Number(c.rounds))?Number(c.rounds):3,gameId:['collapse','race','football','spotlight','pages','waves','harvest','sketch','raft'].includes(c.gameId)?c.gameId:'collapse'};}
 function create(callbacks={}){
  let socket=null,generation=0,role=null,lobby=null,connectionTimer=0,heartbeat=0,inputSequence=0,lastInputAt=-Infinity,lastSnapshotAt=-Infinity,closed=true;
  const notify=(name,...args)=>{try{callbacks[name]?.(...args);}catch(e){console.error('Festa: callback '+name,e);}};
  const status=text=>notify('onStatus',text);
  function send(message){if(socket?.readyState!==1)return false;try{const text=JSON.stringify(message);if(text.length>MAX_PACKET)return false;if(socket.bufferedAmount>MAX_PACKET*2)return false;socket.send(text);return true;}catch{return false;}}
  function terminate(reason='',report=false){
   const old=socket;socket=null;generation++;clearTimeout(connectionTimer);clearInterval(heartbeat);heartbeat=0;connectionTimer=0;const oldId=lobby?.selfId;lobby=null;role=null;closed=true;
   if(old){try{if(old.readyState===1)old.send(JSON.stringify({t:'party-bye'}));old.close();}catch{}}
   if(reason)status(reason);if(report)notify('onDisconnect',oldId||null,{hostLost:true,reason:reason||'A conexão com a festa foi encerrada.'});
  }
  function error(message){notify('onError',message);status(message);}
  function connect(nextRole,options={}){
   terminate();
   if(!window.DAROCA_LAN){error('Para reunir os amigos, abra o endereço do computador que executa o pacote Wi-Fi. No site, você pode jogar com a CPU.');return false;}
   const code=String(options.code||'').trim();
   if(nextRole==='guest'&&!/^[0-9]{6}$/.test(code)){error('Digite os seis números da sala do amigo.');return false;}
   const seats=Number(options.seats||4);
   if(nextRole==='host'&&(!Number.isInteger(seats)||seats<4||seats>8)){error('Escolha de quatro a oito lugares.');return false;}
   const token=generation;role=nextRole;closed=false;inputSequence=0;lastInputAt=lastSnapshotAt=-Infinity;
   status(nextRole==='host'?'Abrindo a festa na rede…':'Procurando a festa do amigo…');
   let connection;
   try{connection=socket=new WebSocket((location.protocol==='https:'?'wss://':'ws://')+location.host+'/festa');}
   catch{terminate();error('Não foi possível abrir a conexão com o computador.');return false;}
   connectionTimer=setTimeout(()=>{if(token===generation){terminate();error('O computador não respondeu. Confira o endereço e a janela do servidor.');}},12000);
   connection.onopen=()=>{
    if(token!==generation)return;clearTimeout(connectionTimer);
    send({t:nextRole==='host'?'party-host':'party-join',v:VERSION,name:safeName(options.name),character:safeCharacter(options.character),seats,code,...cleanConfig(options)});
    heartbeat=setInterval(()=>send({t:'party-ping'}),15000);
   };
   connection.onmessage=event=>{
    if(token!==generation||typeof event.data!=='string'||event.data.length>MAX_PACKET)return;
    let m;try{m=JSON.parse(event.data);}catch{return;}
    if(!m||typeof m.t!=='string')return;
    if(m.t==='party-lobby'){
     if(!/^[0-9]{6}$/.test(m.code||'')||!validId(m.selfId)||m.hostId!=='p0'||!Number.isInteger(m.seats)||m.seats<4||m.seats>8||!Array.isArray(m.players)||m.players.length<1||m.players.length>m.seats||!m.players.every(p=>p&&validId(p.id)&&typeof p.name==='string'&&typeof p.character==='string'))return;
     lobby={code:m.code,hostId:m.hostId,selfId:m.selfId,seats:m.seats,players:m.players.map(p=>({id:p.id,name:safeName(p.name),character:safeCharacter(p.character)})),started:!!m.started,config:cleanConfig(m.config)};
     role=m.selfId===m.hostId?'host':'guest';status(lobby.started?'A festa começou!':lobby.players.length+' / '+lobby.seats+' jogadores conectados. A CPU completa os lugares vazios.');notify('onLobby',{...lobby,players:lobby.players.map(p=>({...p}))});
    }else if(m.t==='party-state'&&role==='guest'&&validState(m.state))notify('onState',m.state);
    else if(m.t==='party-input'&&role==='host'&&validId(m.id)&&m.input&&Number.isFinite(m.input.x)&&Number.isFinite(m.input.z)&&Math.abs(m.input.x)<=1&&Math.abs(m.input.z)<=1)notify('onInput',m.id,{x:m.input.x,z:m.input.z,a:m.input.a===true,b:m.input.b===true,seq:m.input.seq});
    else if(m.t==='party-command'&&role==='host'&&validId(m.id)&&['roll','item','route','ready','next','buy'].includes(m.command))notify('onCommand',m.id,m.command,m.value);
    else if(m.t==='party-left'&&validId(m.id))notify('onDisconnect',m.id,{hostLost:false,reason:m.reason||'O jogador saiu; a CPU assume o lugar.'});
    else if(m.t==='party-closed'){const reason=typeof m.reason==='string'?m.reason:'Quem criou a festa saiu.';terminate(reason,true);}
    else if(m.t==='party-error')error(typeof m.message==='string'?m.message:'Não foi possível entrar nessa festa.');
   };
   connection.onerror=()=>{if(token===generation)error('A conexão encontrou um problema. Confira se o computador e os aparelhos continuam no mesmo Wi-Fi.');};
   connection.onclose=()=>{if(token===generation&&!closed)terminate('A conexão com a festa foi encerrada. Criem outra sala para continuar.',true);};
   return true;
  }
  function sendInput(input={}){
   if(!lobby?.started)return false;
   const now=performance.now();if(now-lastInputAt<28)return false;lastInputAt=now;
   const value={x:Math.max(-1,Math.min(1,Number(input.x)||0)),z:Math.max(-1,Math.min(1,Number(input.z)||0)),a:!!input.a,b:!!input.b,seq:++inputSequence};
   if(role==='host'){notify('onInput',lobby.selfId,value);return true;}return send({t:'party-input',input:value});
  }
  function sendCommand(command,value=null){
   if(!lobby?.started||!['roll','item','route','ready','next','buy'].includes(command))return false;
   if(role==='host'){notify('onCommand',lobby.selfId,command,value);return true;}return send({t:'party-command',command,value});
  }
  function broadcastState(state){
   if(role!=='host'||!lobby?.started||!validState(state))return false;
   const now=performance.now();if(now-lastSnapshotAt<65)return false;lastSnapshotAt=now;return send({t:'party-state',state});
  }
  function start(config={}){return role==='host'&&lobby&&!lobby.started?send({t:'party-start',config:cleanConfig({...lobby.config,...config})}):false;}
  return Object.freeze({host:options=>connect('host',options),join:options=>connect('guest',options),sendInput,sendCommand,broadcastState,start,close:()=>terminate(),getStatus:()=>({connected:socket?.readyState===1&&!!lobby,role,code:lobby?.code||null,selfId:lobby?.selfId||null,hostId:lobby?.hostId||null,seats:lobby?.seats||0,started:!!lobby?.started,lobby:lobby?{...lobby,players:lobby.players.map(p=>({...p}))}:null,transport:'wifi-local'})});
 }
 window.PartyNet=Object.freeze({version:VERSION,available:()=>!!window.DAROCA_LAN,create});
})();
