/* Optional Rayssa-house quest and temporary Bivolt energy drink. No storage or DOM side effects. */
(() => {
 'use strict';
 const SCENE=10,DURATION=10,COOLDOWN=30,MAX_CHARGES=9;
 const girls={eloisa:'Eloisa',giselle:'Giselle',rayssa:'Rayssa',analaura:'Ana Laura'};
 const parts=Object.freeze([
  Object.freeze({id:'bivolt-dourada',x:1990,y:350,label:'Lata dourada · prateleira baixa',color:'#efca67'}),
  Object.freeze({id:'bivolt-azul',x:2180,y:294,label:'Lata azul · prateleira de cima',color:'#70c9dd'}),
  Object.freeze({id:'bivolt-violeta',x:2930,y:294,label:'Lata violeta · varanda',color:'#bc8ce1'})
 ]);
 const clamp=(n,a,b)=>Math.max(a,Math.min(b,n));
 const count=value=>Number.isFinite(Number(value))?clamp(Math.floor(Number(value)),0,999):0;
 const charges=q=>clamp(count(q?.bivoltCharges),0,MAX_CHARGES);
 const found=q=>new Set((Array.isArray(q?.bivoltParts)?q.bivoltParts:[]).filter(id=>parts.some(p=>p.id===id)));
 const materials=bag=>['pencil','eraser','clip'].reduce((sum,key)=>sum+count(bag?.[key]),0);
 const issued=new WeakSet(),completed=new WeakSet();let sequence=0,remaining=0,cooldown=0;
 const action=type=>{const value=Object.freeze({type,id:++sequence});issued.add(value);return value;};
 const line=(name,text)=>({name,text});
 function state(q){const collected=[...found(q)];return Object.freeze({accepted:!!q?.bivoltAccepted,unlocked:!!q?.bivoltUnlocked,charges:charges(q),collected,needed:Math.max(0,parts.length-collected.length),maxCharges:MAX_CHARGES});}
 function interact(npcId,q,bag){
  const name=girls[npcId];if(!name||!q||typeof q!=='object')return null;
  const s=state(q),opening={eloisa:'Aff veyr juro, Da Roça! Você sobe essas prateleiras ou só sobe a pressão de Nikolas?',giselle:'Aff veyr juro! O menino entrou aqui com o gás acabando e a pose carregada.',rayssa:'Aff veyr juro, menino, se toca! Pra buscar esse bolo vai precisar de uma energia extra.',analaura:'Aff veyr juro! Esse chapéu tá no modo economia de bateria, é?'}[npcId];
  if(!s.accepted&&!s.unlocked)return{lines:[line(name,opening),line(name,'Espalhamos três latas seladas de Bivolt nas prateleiras e na varanda. Pega as três e traz aqui. Tem parkour, mas não tem como culpar a cadeira!'),line('Da Roça','Três latas e uma missão? Vou buscar no gás. O energético pode ficar por conta de vocês.'),line(name,'Aff veyr juro, combinado! Lata dourada embaixo, azul lá em cima e violeta na varanda. Depois volta pra conversar.')],action:action('accept')};
  if(s.accepted&&!s.unlocked){
   if(s.needed===0)return{lines:[line(name,'Aff veyr juro! As três latas chegaram inteiras. Até que esse parkour de chapéu presta!'),line(name,'Toma três cargas de BIVOLT. Cada lata sobe vida máxima, gás, força e agilidade por DEZ segundos. Depois volta tudo ao normal, sem gastar seus pontos.'),line('Da Roça','Dez segundos no modo tomada dupla? Nikolas vai conhecer a conta de luz da roça.'),line(name,'Aff veyr juro, bestaiado! Usa B ou o botão da latinha. Não dá pra emendar: espera a recarga. Quando acabar, eu troco três materiais escolares por outra lata.')],action:action('unlock')};
   return{lines:[line(name,opening),line(name,`Ainda ${s.needed===1?'falta uma lata':'faltam '+s.needed+' latas'}! Você já pegou ${s.collected.length}/3. Confere a prateleira baixa, a de cima e a varanda. Aff veyr juro, não me volta só com o lacre!`)],action:null};
  }
  // The other girls retain their normal changing conversations after the quest.
  if(npcId!=='rayssa')return null;
  if(s.charges>=MAX_CHARGES)return{lines:[line(name,'Aff veyr juro! Nove latas já é um estoque, menino. Usa uma antes de pedir mais. Teu bolso não é a geladeira da festa.')],action:null};
  if(materials(bag)>=3)return{lines:[line(name,`Aff veyr juro! Você tem ${s.charges} ${s.charges===1?'lata':'latas'}. Troco três materiais escolares por UMA carga nova. Lápis, borracha ou clipe: a resenha aceita os três.`),line('Da Roça','Fechado. Meu estojo virou patrocinador do Bivolt!'),line(name,'Aff veyr juro, patrocinador de papel, né? Uma lata por troca. E continua gastando seus pontos de nível, porque energético não faz milagre.')],action:action('refill')};
  return{lines:[line(name,`Aff veyr juro! Você tá com ${s.charges} ${s.charges===1?'carga':'cargas'} de Bivolt. Traz três materiais escolares pra eu te dar mais uma. Por enquanto, dez segundos de boost e trinta entre uma lata e outra!`)],action:null};
 }
 function complete(q,plan,bag){
  if(!q||typeof q!=='object'||!plan||typeof plan!=='object'||!issued.has(plan)||completed.has(plan))return{ok:false,changed:false,message:'Essa conversa não tem uma entrega pendente.'};
  completed.add(plan);const s=state(q);
  if(plan.type==='accept'){
   if(s.accepted||s.unlocked)return{ok:false,changed:false,message:'A missão do Bivolt já foi aceita.'};
   q.bivoltAccepted=true;q.bivoltParts=[];return{ok:true,changed:true,accepted:true,message:'Missão Bivolt: encontre as três latas na Casa de Rayssa e volte às garotas.'};
  }
  if(plan.type==='unlock'){
   if(!s.accepted||s.unlocked||s.needed!==0)return{ok:false,changed:false,message:'Recolha as três latas antes de receber o Bivolt.'};
   q.bivoltUnlocked=true;q.bivoltCharges=3;return{ok:true,changed:true,unlocked:true,xp:240,source:'side-bivolt-unlock',message:'BIVOLT DESBLOQUEADO! 3 cargas · todos os atributos por 10 segundos · B ou latinha.'};
  }
  if(plan.type==='refill'){
   if(!s.unlocked||s.charges>=MAX_CHARGES||!bag||materials(bag)<3)return{ok:false,changed:false,message:'Separe três materiais escolares e um espaço para a lata.'};
   let needed=3;const consumed={pencil:0,eraser:0,clip:0};
   for(const key of Object.keys(consumed)){const available=count(bag[key]),use=Math.min(needed,available);consumed[key]=use;needed-=use;}
   if(needed)return{ok:false,changed:false,message:'Os materiais da troca não estão mais no estojo.'};
   for(const key of Object.keys(consumed))bag[key]=count(bag[key])-consumed[key];
   q.bivoltCharges=s.charges+1;return{ok:true,changed:true,refilled:true,consumed,message:'Rayssa trocou 3 materiais por 1 carga de Bivolt. Aff veyr juro!'};
  }
  return{ok:false,changed:false,message:'Entrega de Bivolt desconhecida.'};
 }
 function collect(q,player,scene){
  if(Number(scene)!==SCENE||!q?.bivoltAccepted||q.bivoltUnlocked||!player||!Number.isFinite(player.x)||!Number.isFinite(player.y))return null;
  const collected=found(q),part=parts.find(p=>!collected.has(p.id)&&Math.abs(player.x-p.x)<=29&&Math.abs((player.y-30)-p.y)<=35);
  if(!part)return null;collected.add(part.id);q.bivoltParts=[...collected];return{collected:true,id:part.id,count:collected.size,total:parts.length,message:collected.size===parts.length?'Bivolt 3/3! Volte às garotas para receber suas três cargas.':`Bivolt ${collected.size}/3 · ${part.label}.`};
 }
 function can(c,x,y,t,color,small=false){
  const u=small ? .72 : 1;c.save();c.translate(Math.round(x),Math.round(y+Math.sin(t*3+x)*2));c.scale(u,u);c.fillStyle='#172d35';c.fillRect(-9,-16,18,29);c.fillStyle='#a9bbbc';c.fillRect(-6,-18,12,3);c.fillRect(-7,12,14,3);c.fillStyle='#586a71';c.fillRect(-2,-17,5,2);c.fillStyle=color;c.fillRect(-6,-13,12,25);c.fillStyle='#fbefc3';c.fillRect(-5,-10,10,5);c.fillStyle='#61324b';c.beginPath();c.moveTo(2,-5);c.lineTo(-4,3);c.lineTo(0,3);c.lineTo(-2,10);c.lineTo(5,0);c.lineTo(1,0);c.closePath();c.fill();c.fillStyle='#ffffff80';c.fillRect(-5,-12,2,22);c.restore();
 }
 function draw(c,camera,t,q,scene){
  if(!c||Number(scene)!==SCENE||!q?.bivoltAccepted||q.bivoltUnlocked)return;const collected=found(q);
  c.save();c.translate(-(Number(camera)||0),0);for(const p of parts){if(collected.has(p.id))continue;const pulse=.5+.5*Math.sin(t*3+p.x);c.globalAlpha=.13+pulse*.1;c.fillStyle=p.color;c.beginPath();c.arc(p.x,p.y,24+pulse*4,0,Math.PI*2);c.fill();c.globalAlpha=1;can(c,p.x,p.y,t,p.color);c.fillStyle='#efe3aa';c.font='bold 9px monospace';c.textAlign='center';c.fillText('BIVOLT',p.x,p.y-24);}c.restore();
 }
 function activate(q){
  const s=state(q);if(!s.unlocked)return{ok:false,message:'Faça a missão das garotas na Casa de Rayssa para liberar o Bivolt.'};
  if(remaining>0)return{ok:false,message:'O Bivolt já está ativo!'};if(cooldown>0)return{ok:false,message:`Aguarde ${Math.ceil(cooldown)}s para abrir outra lata.`};if(s.charges<1)return{ok:false,message:'Sem Bivolt. Rayssa troca 3 materiais escolares por uma carga.'};
  q.bivoltCharges=s.charges-1;remaining=DURATION;cooldown=COOLDOWN;return{ok:true,active:true,duration:DURATION,cooldown:COOLDOWN,charges:q.bivoltCharges,message:'BIVOLT! Vida, força, gás e agilidade aumentados por 10 segundos!'};
 }
 function update(dt){const delta=Number.isFinite(dt)?Math.max(0,dt):0,was=remaining>0;remaining=Math.max(0,remaining-delta);cooldown=Math.max(0,cooldown-delta);if(remaining<1e-8)remaining=0;if(cooldown<1e-8)cooldown=0;return{active:remaining>0,expired:was&&remaining===0,remaining,cooldown};}
 function reset(){remaining=0;cooldown=0;}
 function bonuses(base={}){
  const value={...base};if(remaining<=0)return value;
  const numeric=(key,fallback)=>Number.isFinite(Number(base[key]))?Number(base[key]):fallback;
  return{...value,maxHP:Math.round(numeric('maxHP',100)*1.35),maxGas:Math.round(numeric('maxGas',100)*1.35),damageMultiplier:numeric('damageMultiplier',1)*1.35,moveSpeed:numeric('moveSpeed',280)*1.22,dashCooldown:Math.max(.24,numeric('dashCooldown',1.1)*.7),gasRegen:numeric('gasRegen',16)*1.35,airGasRegen:numeric('airGasRegen',6)*1.35,bivoltActive:true};
 }
 function getStatus(q){const s=state(q),active=remaining>0;return Object.freeze({...s,active,remaining,cooldown,duration:DURATION,cooldownDuration:COOLDOWN,ready:s.unlocked&&s.charges>0&&!active&&cooldown===0,remainingRatio:remaining/DURATION,cooldownRatio:cooldown/COOLDOWN,label:active?`BIVOLT ${remaining.toFixed(1)}s`:cooldown>0?`BIVOLT ${Math.ceil(cooldown)}s`:`BIVOLT ×${s.charges}`});}
 const iconSVG=()=>'<svg viewBox="0 0 32 36" aria-hidden="true"><path d="M10 4h12l2 4v23H8V8Z" fill="currentColor"/><path d="M11 3h10M11 33h10M11 10h10" fill="none" stroke="#273e36" stroke-width="2"/><path d="m18 12-7 9h5l-2 9 9-13h-6Z" fill="#263c35"/></svg>';
 window.BivoltQuest=Object.freeze({scene:SCENE,parts,state,interact,complete,collect,draw});
 window.BivoltSkill=Object.freeze({activate,update,bonuses,reset,getStatus,iconSVG,duration:DURATION,cooldownDuration:COOLDOWN});
})();
