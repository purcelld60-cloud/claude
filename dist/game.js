/* Da Roça Adventure — canvas game engine. Original arcade combat and story. */
(() => {
  'use strict';
  const $ = id => document.getElementById(id);
  const canvas = $('gameCanvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d', {alpha:false});
  canvas.width=960; canvas.height=540; ctx.imageSmoothingEnabled=false;
  const W=960,H=540,FLOOR=440,SAVE='da-roca-adventure-v1';
  let WORLD=Number(window.WorldData?.widths?.[0])||2600;
  const scenes=window.Campaign?.sceneNames||['A roça','Colégio Adventista','Academia do Caleb','A quadra','Praça Camacan','Favela do Reeis','Caderno do Caos','Campo do Mota','Bigodon · barbearia','Pátio da escola','Casa de Rayssa','Baile funk'];
  const phrases=['da roça poudiaaam','reeeis pouddiaaam','da roça pegou ar','teketeketeketeke','ó pra Ravid falando sozinho'];
  const npcInfo={...window.Campaign?.npcEntries,swift:{name:'Irmão de Clara Swift',scene:0,x:340},ollyan:{name:'Ollyan · Orelhas ao Vento',scene:11,x:3260},neide:{name:'Tia Neide · secretaria',scene:9,x:1060},mc_batidao:{name:'MC Batidão · concurso de fantasia',scene:11,x:1960},lucas:{name:'Lucas · o Sapo',scene:0,x:480},kaua:{name:'Kauã · inventor',scene:0,x:760},reeis:{name:'Gabriel Reeis',scene:1,x:390},ravid:{name:'Ravid',scene:1,x:930},caleb:{name:'Caleb',scene:2,x:400},mota:{name:'Gabriel Mota',scene:7,x:500},davi:{name:'Davi Costa · barbeiro',scene:8,x:520},vitor:{name:'Vitor · ajudante',scene:8,x:850},freddy:{name:'Freddy · resenha do morro',scene:5,x:5680},nicolas:{name:'Nicolas Carvalho',scene:4,x:5350},dede:{name:'Dedé · Fumacinha',scene:5,x:5000},aica:{name:'Aica',scene:9,x:500},ravile:{name:'Ravile',scene:9,x:670},arthur:{name:'Arthur',scene:9,x:2850},allef:{name:'Allef · recepção',scene:8,x:240},eloisa:{name:'Eloisa',scene:10,x:450},giselle:{name:'Giselle',scene:10,x:820},rayssa:{name:'Rayssa',scene:10,x:1220},analaura:{name:'Ana Laura',scene:10,x:1580}};
  const platforms=window.WorldData?.platforms||[[[790,340,160],[1270,290,160],[1840,330,170]],[[1080,338,150],[1450,285,140],[2100,335,140]],[[850,350,150],[1340,310,140],[1950,350,140]],[[680,340,150],[1180,290,140],[2100,345,150]]];
  const emptyQuest=()=>({carMissionAccepted:false,carParts:[],almiroAccepted:false,notebooks:[],lucas:false,kaua:false,mota:false,almiro:false,miqueias:false,reeis:false,marco:false,giant:false,menezes:false,training:false,trained:false,nikolas:false,freddy:false,nicolas:false,bigodon:false,vitor:false,amandaInvited:false,amandaDating:false,jaglionClaimed:false,dede:false,patioAccepted:false,arthur:false,acai:false,celebrationSeen:false,easyEndingSeen:false,jorgeSeen:false,jorgeStarted:false,rayssaVisit:false,ollyan:false,bivoltAccepted:false,bivoltParts:[],bivoltUnlocked:false,bivoltCharges:0,igor:false,kaique:false,igorSneak:false,kaiqueSneak:false,npcVisits:{}});
  let q=emptyQuest(),player,scene=0,camera=0,time=0,playing=false,paused=false,dialog=null,started=false,won=false,sound=false,vehicle=false,transition=0;
  let particles=[],shots=[],enemies=[],pickups=[],targets=[],damageTexts=[],shake=0,hitFlash=0,hazards=[],afterimages=[];
  // Visual-only boss drama: impact freeze, intro plate, phase shockwaves and the defeat burst.
  let hitStop=0;const epic={intro:null,rings:[],flash:0,flashColor:'#fff6d8',plate:null};const calmMotion=matchMedia('(prefers-reduced-motion: reduce)').matches;
  let joystick={x:0,y:0},dashTimer=0,dashCooldown=0,dashDir=1,activeBoss=null,defeated=false,chapterEnded=false,respawnCheckpoint=null,routeTransition=null,routeEdgeCooldown=0,releasingInputs=false;
  let reeisPhase='idle',reeisPhaseTimer=0,reeisX=0,reeisY=FLOOR,reeisFacing=1,reeisFireTimer=0;
  let sandbox=null;
  let audioCutsceneSerial=0,ollyanEncounter=null,ollyanRetryGrace=0;
  let room=null,arena=null,cutscene=null,cutsceneCallback=null,minions=[],minionKills=[],lastSafeX=230,tauntCooldown=0;
  let items={pencil:0,eraser:0,clip:0},collected=[],weapon=0,training=null,activity=null,activityCallback=null,seenBossIntros=[],comboStep=0,comboWindow=0,bossHintCooldown=0,marcoTrapTriggered=false;
  const baseBonus=()=>({...{maxHP:100,maxGas:100,damageMultiplier:1,moveSpeed:280,dashCooldown:1.1,projectileTier:0},...(window.Progression?.bonuses?.()||{})});
  const bonus=()=>window.BivoltSkill?.bonuses?.(baseBonus())||baseBonus();

  function bivoltStatus(){return window.BivoltSkill?.getStatus?.(q)||{unlocked:false,charges:0,remaining:0,cooldown:0,active:false,ready:false};}
  function createBivoltControl(){
    const container=document.querySelector('.touch-extras');if(!container||$('bivoltBtn')||!window.BivoltSkill)return;
    const button=document.createElement('button');button.id='bivoltBtn';button.type='button';button.className='touch-btn bivolt-btn';button.dataset.action='bivolt';
    button.innerHTML=window.BivoltSkill.iconSVG()+'<small class="bivolt-label">BIVOLT</small><span class="bivolt-count">0</span><kbd>B</kbd>';container.prepend(button);
  }
  function updateBivoltUI(){const state=bivoltStatus(),button=$('bivoltBtn');if(button){button.hidden=!started;for(const name of ['active','cooling','locked','empty'])button.classList.toggle(name,name==='active'?state.active:name==='cooling'?state.cooldown>0&&!state.active:name==='locked'?!state.unlocked:state.charges<=0);const label=button.querySelector('.bivolt-label'),count=button.querySelector('.bivolt-count');if(label)label.textContent=state.active?state.remaining.toFixed(1)+'s':state.cooldown>0?Math.ceil(state.cooldown)+'s':'BIVOLT';if(count)count.textContent=state.charges;button.setAttribute('aria-label',state.active?'Bivolt ativo por mais '+state.remaining.toFixed(1)+' segundos':!state.unlocked?'Bivolt: encontre as garotas na Casa de Rayssa':state.cooldown>0?'Bivolt recarregando por '+Math.ceil(state.cooldown)+' segundos':'Usar Bivolt por 10 segundos. '+state.charges+' latas');button.setAttribute('aria-disabled',String(!state.ready||paused||!!dialog||!!cutscene));button.title=state.active?'Todos os atributos fortalecidos por 10 segundos':!state.unlocked?'Missão do Bivolt na Casa de Rayssa':'B · energético: vida, gás, força e agilidade por 10 segundos';} $('gameShell')?.classList.toggle('is-bivolt',state.active);}
  function syncOllyanPlayer(){if(!ollyanEncounter)return;window.OllyanEncounter.setBonuses(ollyanEncounter,bonus());window.OllyanEncounter.setPlayer(ollyanEncounter,{hp:player.hp,gas:player.gas});}
  function activateBivolt(){
    if(!started||paused||dialog||cutscene||routeTransition||training?.active||activity||won||defeated||ollyanEncounter&&ollyanEncounter.stage!=='fight')return false;
    const before=bonus(),result=window.BivoltSkill?.activate?.(q);if(!result?.ok){toast(result?.message||'Converse com as garotas na Casa de Rayssa para encontrar o Bivolt.');return false;}
    const after=bonus();player.hp=Math.min(after.maxHP,player.hp+Math.max(0,after.maxHP-before.maxHP));player.gas=Math.min(after.maxGas,player.gas+Math.max(0,after.maxGas-before.maxGas));syncOllyanPlayer();
    floating(player.x,player.y-112,'BIVOLT! 10 SEGUNDOS!','#ffe68f');fx(player.x,player.y-40,'#f2d874',26,125);beep(770,.15,'triangle');toast(result.message||'BIVOLT! Todos os atributos fortalecidos por 10 segundos.');updateUI();save();return true;
  }
  function updateBivolt(dt){const result=window.BivoltSkill?.update?.(dt);if(result?.expired){player.hp=Math.min(player.hp,bonus().maxHP);player.gas=Math.min(player.gas,bonus().maxGas);syncOllyanPlayer();updateUI();}}
  function resetBivolt(){window.BivoltSkill?.reset?.();if(player){player.hp=Math.min(player.hp,baseBonus().maxHP);player.gas=Math.min(player.gas,baseBonus().maxGas);}}
  function drawBivoltAura(c,x,y){if(!bivoltStatus().active)return;c.save();c.globalAlpha=.35+Math.sin(time*5)*.08;c.strokeStyle='#f5d775';c.lineWidth=2;c.beginPath();c.ellipse(x,y,35,43,Math.sin(time)*.08,0,Math.PI*2);c.stroke();for(let i=0;i<5;i++){const a=time*1.8+i*Math.PI*2/5;c.fillStyle=i%2?'#cce8a4':'#ffe6a0';c.fillRect(x+Math.cos(a)*34-2,y+Math.sin(a)*43-2,4,4);}c.restore();}
  function beginOllyanEncounter(force=false){
    if(!started||paused||dialog||cutscene||activity||training?.active||arena||room||routeTransition||ollyanEncounter||defeated||won||scene!==11||q.ollyan)return false;
    const npc=window.BaileWorld?.getNPC?.()||npcInfo.ollyan;if(!force&&Math.abs(player.x-npc.x)>190)return false;if(!q.lucas){toast('Conserte o carro a gás com Lucas antes de seguir Ollyan no céu.');return false;}if(!window.OllyanEncounter)return false;
    releaseInputs();shots=[];hazards=[];reeisPhase='idle';reeisTimer=0;player.vx=0;player.vy=0;player.y=FLOOR;player.ground=true;lastSafeX=2900;q.ollyanTeto=true;respawnCheckpoint={scene:11,x:2900};vehicle=true;
    const mode=window.Difficulty?.getMode?.()||'normal',settings=window.Difficulty?.getSettings?.(mode)||{hp:1,incomingDamage:1,windup:1,recovery:1};ollyanEncounter=window.OllyanEncounter.create({...bonus(),hp:player.hp,gas:player.gas,trained:q.trained,difficultyMode:mode,bossHP:Math.round(2600*settings.hp),enemyDamageMultiplier:1.5*settings.incomingDamage,windupMultiplier:settings.windup,recoveryMultiplier:settings.recovery});updateUI();save();return true;
  }
  function finishOllyanEncounter(result){
    const encounter=ollyanEncounter;if(!encounter)return;window.FxPixel?.limpar?.('ollyan');if(sandbox){finishSandbox(result==='won'?'won':result==='defeated'?'defeated':'retreat');return;}const status=window.OllyanEncounter.getStatus(encounter);player.hp=Math.max(0,Math.min(bonus().maxHP,status.playerHP));player.gas=Math.max(0,Math.min(bonus().maxGas,status.gas));ollyanEncounter=null;releaseInputs();vehicle=false;shots=[];hazards=[];player.vx=0;player.vy=0;player.ground=true;player.y=FLOOR;player.x=result==='won'?3500:2900;lastSafeX=player.x;camera=clamp(player.x-W*.36,0,WORLD-W);ollyanRetryGrace=3;
    if(result==='won'){const first=!q.ollyan;q.ollyan=true;if(first)awardXP(700,'side-ollyan');toast('Orelhas pousadas! Ollyan voltou ao baile. +700 XP pela vitória no céu.');save();updateUI();}
    else if(result==='defeated'){respawnCheckpoint={scene:11,x:2900};resetBivolt();defeat();}
    else{toast('Você voltou ao baile. O carro estacionou em segurança; Ollyan continua no desafio.');updateUI();save();}
  }
  function consumeOllyanEvents(){if(!ollyanEncounter)return;for(const event of window.OllyanEncounter.drainEvents(ollyanEncounter)){efeitoOllyan(event);if(event.type==='hurt'){player.hp=Math.max(0,event.hp??window.OllyanEncounter.getStatus(ollyanEncounter).playerHP);hitFlash=.18;beep(110,.1,'sawtooth');}else if(event.type==='phase'){toast('Ollyan · fase '+event.phase+'/3: '+(event.name||'o céu mudou de compasso'));}else if(event.type==='won'||event.type==='defeated'||event.type==='retreat'){finishOllyanEncounter(event.type);break;}}}
  // efeitos do pixelfx na luta no céu (coordenadas da tela da luta); no acerto o inimigo só pisca
  function efeitoOllyan(ev){const F=window.FxPixel,E=ollyanEncounter;if(!F?.tocar||!E||!ev)return;const b=E.boss||{},p=E.player||{},o={dono:'ollyan',mundo:false};
    if(ev.type==='phase'){F.tocar('holy/sunburst',{...o,x:b.x,y:b.y,palette:F.PAL.ouro,duracao:1.2});F.tocar('explosions/firework-burst',{...o,x:b.x,y:b.y+40,atraso:.2});}
    else if(ev.type==='attack')F.tocar('spawn/poof',{...o,x:b.x,y:b.y+20,palette:['#3a4a6a','#6a7aa0','#a8b8d8','#dce6f6','#ffffff','#ffffff']});
    else if(ev.type==='fart')F.tocar('spawn/poof',{...o,x:p.x-20,y:p.y+10,palette:F.PAL.peido});
    else if(ev.type==='dash')F.tocar('spawn/poof',{...o,x:p.x-24,y:p.y+12,palette:F.PAL.poeira});
    else if(ev.type==='defeated'){F.tocar('explosions/firework-burst',{...o,x:b.x,y:b.y,palette:F.PAL.ouro});F.tocar('explosions/firework-burst',{...o,x:b.x-120,y:b.y+30,atraso:.35});F.tocar('explosions/firework-burst',{...o,x:b.x+120,y:b.y+10,atraso:.7});F.tocar('holy/feather-burst',{...o,x:b.x,y:b.y});}}
  function updateOllyan(dt){
    if(!ollyanEncounter)return;const state=ollyanEncounter,input={x:clamp(joystick.x+(keyHeld('right')||touch.right?1:0)-(keyHeld('left')||touch.left?1:0),-1,1),y:clamp(joystick.y+(keyHeld('down')||touch.down?1:0)-(keyHeld('up')||keyHeld('jump')||touch.jump?1:0),-1,1),fire:keyHeld('paper'),fart:keyHeld('fart'),jump:!!(keyHeld('jump')||keyHeld('up')||touch.jump||touch.up||joystick.y<-.55)};
    window.OllyanEncounter.update(state,dt,input,bonus());const status=window.OllyanEncounter.getStatus(state);player.hp=status.playerHP;player.gas=status.gas;consumeOllyanEvents();uiTimer+=dt;if(uiTimer>.1){uiTimer=0;updateUI();}updateEffects(dt);
  }
  function retreatOllyan(){if(!ollyanEncounter||paused||dialog)return false;window.OllyanEncounter.cancel(ollyanEncounter);consumeOllyanEvents();return true;}

  const bossProfile=e=>e.difficultyProfile||window.Difficulty?.boss(e.type)||{hp:e.max,level:1,damage:1,projectileSpeed:1,dashSpeed:1,windup:1,minWindup:.62,recovery:[1.5,1.42,1.34],armor:.32};
  const bossRecovery=e=>bossProfile(e).recovery[Math.max(0,Math.min(2,(e.phase||1)-1))]*(e.type==='kaique'&&e.rage?.88:1);
  const levelState=()=>window.Progression?.getState?.()||{level:1,xp:0,nextXP:100,points:0,stats:{vigor:0,forca:0,gas:0,agilidade:0}};
  function awardXP(xp,id){if(sandbox)return {...levelState(),awarded:0,levelsGained:0};const before=levelState().level,r=window.Progression?.award?.(xp,id);if(r&&levelState().level>before){player.hp=bonus().maxHP;player.gas=bonus().maxGas;floating(player.x,player.y-105,'NÍVEL '+levelState().level+'!','#ffec91');toast('Nível '+levelState().level+'! Abra ATRIBUTOS para distribuir seus pontos.');beep(920,.22,'triangle');}return r;}
  function spendStat(stat){if(sandbox){toast('Distribua seus pontos na campanha antes da revanche.');return false;}if(window.Campanha2?.aberto?.()){const ok=window.Progression?.spend?.(stat)||false;if(ok)window.dispatchEvent(new CustomEvent('c2-atributo',{detail:{stat}}));return ok;}/* na Campanha 2: só gasta o ponto; ela mesma guarda a progressão (sem regravar o save da principal) */const old=bonus();const ok=window.Progression?.spend?.(stat)||false;if(ok){const b=bonus();player.hp=Math.min(b.maxHP,player.hp+Math.max(0,b.maxHP-old.maxHP));player.gas=Math.min(b.maxGas,player.gas+Math.max(0,b.maxGas-old.maxGas));syncOllyanPlayer();updateUI();save();}return ok;}
  const weaponNames=['Bolinhas de papel','Lançador de régua','Canhão de estojo'];
  const itemNames={pencil:'lápis',eraser:'borracha',clip:'clipe'};
  const kauaVoice='ummhumhumm... rato poudii! Oprai da roça!';
  const materialCount=()=>items.pencil+items.eraser+items.clip;
  let last=performance.now(),saveTimer=0,uiTimer=0,toastTimer=0,reeisTimer=0,reeisCooldown=0,attackCooldown=0,fartCooldown=0,ammoTimer=0;
  let keys={},touch={},prevJump=false,nearNPC=null,audioCtx=null,dialogCallback=null,killCount=0;
  const defaultKeys={left:['KeyA','ArrowLeft'],right:['KeyD','ArrowRight'],up:['KeyW','ArrowUp'],down:['KeyS','ArrowDown'],jump:['Space'],paper:['KeyJ'],fart:['KeyK'],dash:['KeyL','ShiftLeft','ShiftRight'],reeis:['KeyR'],vehicle:['KeyV'],bivolt:['KeyB'],taunt:['KeyT'],interact:['KeyE','Enter'],pause:['Escape']};
  let inputCaptured=false;
  const keyHeld=action=>window.ControlSettings?window.ControlSettings.pressed(action,keys):!!defaultKeys[action]?.some(code=>keys[code]);
  const keyMatches=(action,code)=>window.ControlSettings?window.ControlSettings.matches(action,code):!!defaultKeys[action]?.includes(code);
  const rand=(a,b)=>a+Math.random()*(b-a),clamp=(x,a,b)=>Math.max(a,Math.min(b,x));
  const activePointers=new Map(),heldActions=new Set(['left','right','up','down','jump']),pointerTimes=new WeakMap(),keyboardClicks=new WeakMap();
  const npcAvailable=id=>id==='reeis'?q.reeis:id==='freddy'?q.freddy:id==='nicolas'?q.nicolas:id==='dede'?q.dede:id==='arthur'?q.arthur:true;
  function closestNPC(){if(room?.phase==='inside')return Math.abs(player.x-room.teacherX)<105&&Math.abs(player.y-FLOOR)<100?[room.id,{name:room.id==='almiro'?'Professor Almiro':'Professor Miqueias',scene,x:room.teacherX}]:null;return Object.entries(npcInfo).filter(([id,n])=>npcAvailable(id)&&n.scene===scene&&Math.abs(player.x-n.x)<105&&Math.abs(player.y-FLOOR)<100).sort((a,b)=>Math.abs(a[1].x-player.x)-Math.abs(b[1].x-player.x))[0];}
  const bossNames={igor:'Igor · Fiscal do Lanche',kaique:'Kaique · Monitor do Corredor',marco:'Marco',menezes:'Menezes · Rato',nikolas:'Nikolas Arroganti',reeisBoss:'Reeis · Rei da Favela',giant:'Rabiscão · Monstro Gigante',freddy:'Freddy · Braço Forte do Reeis',nicolas:'Nicolas Carvalho · Aura Suprema',dede:'Dedé · Fumacinha',arthur:'Arthur · Duelo do pátio'};const nomeBoss=t=>window.C2Luta?.skin&&t===window.C2Luta.skin.kit?window.C2Luta.skin.nome:bossNames[t];
  function bossAccess(e){
    const tasks={patioAccepted:'Vá ao Pátio da escola e converse com Aica ou Ravile, perto da entrada.',freddy:'Enfrente Freddy, o capanga mais forte, no caminho antes de Reeis.',mota:'Vença o futebol do Mota no Campo do Mota para aprender o dash.',almiro:'Entre na sala 01 do colégio e devolva os três cadernos ao professor Almiro.',miqueias:'Entre na sala 02 e complete o quiz de inglês do professor Miqueias.',reeis:'Vá à Favela do Reeis, vença o rei do morro e recrute sua ajuda.',marco:'Vença Marco no pátio do Colégio Adventista.',giant:'Vá ao Caderno do Caos e vença o monstro gigante.',menezes:'Vença Menezes no final do Colégio Adventista.',trained:'Termine o treino de reflexo com Caleb na academia.'};
    const requirements={marco:['almiro','miqueias','reeis'],menezes:['almiro','miqueias','marco','giant'],reeisBoss:['mota','almiro','miqueias',...(q.reeis?[]:['freddy'])],freddy:['mota','almiro','miqueias'],nicolas:['mota'],dede:['mota','almiro','miqueias'],arthur:['patioAccepted'],giant:['marco'],nikolas:['giant','menezes','trained']};
    const missing=(requirements[e.type]||[]).filter(flag=>!q[flag]);const campaign=window.Campaign?.bossRequirement?.(e.type,q);
    return {ok:missing.length===0&&campaign?.ok!==false,missing,lines:missing.map(flag=>tasks[flag]),reason:missing.length?tasks[missing[0]]:campaign?.reason||''};
  }
  function closestBoss(){return !room&&!arena?enemies.filter(e=>e.hp>0&&Math.abs(e.x-player.x)<=390&&Math.abs(e.y-player.y)<180).sort((a,b)=>Math.abs(a.x-player.x)-Math.abs(b.x-player.x))[0]||null:null;}
  function interactBoss(e){
    if(e.type==='igor'||e.type==='kaique')return confrontMonitor(e,false);
    const access=bossAccess(e);if(access.ok)return engageBoss(e);
    const lines=[{name:nomeBoss(e.type),text:'Quer me desafiar? Primeiro termine sua preparação. Vou te mostrar exatamente o que falta.'},...access.lines.map(text=>({name:'Diário da aventura',text}))];if(!access.lines.length)lines.push({name:'Diário da aventura',text:access.reason||'Conclua a missão que aparece no diário antes deste confronto.'});lines.push({name:'Da Roça',text:'Agora entendi! Vou terminar essas missões e volto aqui para apertar E e começar a luta.'});say(lines);return false;
  }
  function getDialogueAnchor(){
    if(!dialog)return null;const line=dialog.lines[dialog.index];if(!line)return null;const speaker=line.name||'Da Roça',norm=speaker.normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase();let x=player.x,y=player.y-62,type='daroca';
    if(room&&norm.includes(room.id)){x=room.teacherX;y=FLOOR-76;type=room.id;}
    else if(!norm.includes('da roca')&&!norm.includes('diario')){
      const npc=Object.entries(npcInfo).find(([id,n])=>n.scene===scene&&(norm.includes(id)||norm.includes(n.name.normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase())));
      const enemy=enemies.find(e=>norm.includes(e.type==='reeisBoss'?'reeis':e.type==='giant'?'rabiscao':e.type));
      if(enemy){x=enemy.x;y=enemy.y-(enemy.type==='giant'?190:enemy.type==='reeisBoss'?115:76);type=enemy.type;}else if(npc){x=npc[1].x;y=FLOOR-76;type=npc[0];}
    }
    return {x:clamp(x-(room?0:camera),35,W-35),y:clamp(y,60,H-60),speaker,type};
  }
  function playerSpriteOptions(scale=1){const attacking=player.attack>0,progress=attacking?1-player.attack/player.attackDuration:0;return {facing:player.facing,frame:Math.abs(player.vx)>8?player.anim/9:time,attack:attacking,hit:hitFlash>0,scale,moving:!vehicle&&Math.abs(player.vx)>8,speed:Math.abs(player.vx),grounded:player.ground,vy:player.vy,attackProgress:progress,attackType:player.attackType,attackObject:q.miqueias?'papaia':weapon===2?'case':weapon===1?'ruler':'paper',attackElement:q.miqueias?(bonus().projectileTier>=2?'electric':'fire'):null,flight:vehicle||(!activeBoss?.conquista?.estrada&&!player.ground&&(keyHeld('jump')||touch.jump)&&player.gas>0),recoil:attacking&&player.attackType==='paper'?Math.max(0,1-progress*3):0,muscular:q.trained,dash:dashTimer>0,land:player.landTimer/.15,landTimer:player.landTimer};}
  const worldWidthFor=n=>Number(window.WorldData?.widths?.[n])||2600;
  const bossHome=(type,fallback)=>Number(window.WorldData?.bosses?.[type]?.x)||fallback;
  function terrenoConquista(f=activeBoss?.conquista){return window.ConquistaCombate?.terreno(f);}
  function scenePlatforms(){
    const f=activeBoss?.conquista,ceu=f?.ceu;
    if(f?.estrada){const w=window.PerseguicaoMoto.largura;return f.estrada.motos.map(m=>[m.x-w/2,m.y,w]);}
    if(ceu)return ceu.ilhas.filter(i=>i.estado!=='ausente').map(i=>[i.x,i.y,i.w]);
    return room?[]:arena?(window.WorldData?.arenaPlatforms?.[arena.type]||[]).map(p=>[arena.homeX+p[0],p[1],p[2]]):platforms[scene].concat(window.Interact?.platforms?.({scene})||[]);}
  // Parkour runs above safe paths and bridges. Scenery gaps are never invisible collision holes.
  function gapAt(){return null;}
  // chão embaixo do jogador (plataforma mais alta abaixo dos pés, ou o piso) para a sombra projetada
  function heroFloor(){let best=null;for(const p of scenePlatforms())if(player.x>=p[0]-4&&player.x<=p[0]+p[2]+4&&p[1]>=player.y-2&&(best===null||p[1]<best))best=p[1];return best===null?FLOOR:Math.min(best,FLOOR);}
  function resetWorldSize(){WORLD=worldWidthFor(scene);}
  // Roteiros em dist/roteiros/*.json podem tocar antes ou depois de uma cena do jogo (Roteiro.antes/depois).
  function startCutscene(kind,done){
    if(!window.Cinematics?.create){if(done)done();return false;}
    const R=window.Roteiro,pre=R?.antes?.(kind,q),post=R?.depois?.(kind,q);
    if(post){const after=done;done=()=>{R.visto(post,q);save();playCutscene(post,after);};}
    if(pre){R.visto(pre,q);return playCutscene(pre,()=>playCutscene(kind,done));}
    return playCutscene(kind,done);
  }
  function playCutscene(kind,done){
    if(!window.Cinematics?.create){if(done)done();return false;}
    window.CampaignVfx?.reset?.();releaseInputs();cutscene=window.Cinematics.create(kind,{trained:q.trained,musicTimed:!!window.GameMusic?.isCutsceneTimed?.(kind)});cutscene.audioToken=++audioCutsceneSerial;cutscene.audioElapsed=0;cutsceneCallback=done||null;show('dialogBox',false);updateUI();return true;
  }
  function finishCutscene(){if(!cutscene)return;const done=cutsceneCallback;cutscene=null;cutsceneCallback=null;releaseInputs();updateUI();if(done)done();}
  function advanceCutscene(){if(ollyanEncounter&&!paused){const changed=window.OllyanEncounter?.advance?.(ollyanEncounter)||false;consumeOllyanEvents();updateUI();return changed;}if(!cutscene||paused)return false;window.Cinematics.advance(cutscene);if(cutscene.done)finishCutscene();else{epilogueCue(cutscene);updateUI();}return true;}
  function skipCutscene(){if(ollyanEncounter?.stage==='intro'&&!paused){for(let i=0;i<3&&ollyanEncounter?.stage==='intro';i++)window.OllyanEncounter.advance(ollyanEncounter);releaseInputs();updateUI();return true;}if(!cutscene||paused)return false;cutscene.done=true;finishCutscene();return true;}
  function replayIntro(){if(!started||defeated||activeBoss||arena||room||routeTransition||dialog||training?.active||cutscene||ollyanEncounter){toast('Retome a exploração para rever a história.');return false;}resume();show('victoryScreen',false);return startCutscene('intro',()=>toast('História revista! Seu progresso continua igual.'));}
  function enterRoom(id){
    if(!started||paused||cutscene||room||arena||activeBoss||routeTransition||dialog||defeated)return false;
    const door=(window.WorldData?.doors||[]).find(d=>d.id===id&&d.scene===scene);
    if(!door||Math.abs(player.x-door.x)>110||Math.abs(player.y-FLOOR)>50){toast('Chegue à porta da sala e aperte E.');return false;}
    if(vehicle){toast('Estacione o carro com V antes de entrar na sala.');return false;}
    releaseInputs();shots=[];hazards=[];room={id,phase:'entering',blend:0,t:0,returnX:player.x,returnY:FLOOR,exteriorCamera:camera,teacherX:door.teacherX||600,exitX:door.exitX||90};updateUI();beep(330,.12,'triangle');return true;
  }
  function exitRoom(){if(!room||room.phase!=='inside'||dialog||paused||cutscene)return false;releaseInputs();room.phase='exiting';room.t=0;updateUI();return true;}
  function updateRoomTransition(dt){room.t+=dt;room.blend=room.phase==='entering'?clamp(room.t/.65,0,1):1-clamp(room.t/.65,0,1);if(room.t>=.65){if(room.phase==='entering'){room.phase='inside';room.blend=1;player.x=120;player.y=FLOOR;player.vy=0;player.ground=true;WORLD=960;camera=0;}else{const x=room.returnX;room=null;resetWorldSize();player.x=x;player.y=FLOOR;player.vy=0;player.ground=true;camera=clamp(x-W*.36,0,WORLD-W);lastSafeX=x;releaseInputs();}updateUI();}}
  function recoverFall(){
    const safeX=Number.isFinite(lastSafeX)?lastSafeX:230;
    releaseInputs();player.x=clamp(safeX,40,Math.max(40,WORLD-40));player.y=FLOOR;player.vx=0;player.vy=0;player.ground=true;player.landTimer=.15;player.inv=Math.max(Number(player.inv)||0,1);camera=room?0:arena?arena.homeX-W/2:clamp(player.x-W*.36,0,WORLD-W);lastSafeX=player.x;updateUI();
  }

  function makeArena(e){window.CampaignVfx?.reset?.();const bounds=window.WorldData?.arenaBounds?.[e.type]||[-430,430];arena={type:e.type,homeX:e.homeX,bounds:[e.homeX+bounds[0],e.homeX+bounds[1]],phase:'entering',blend:0,t:0,exteriorCamera:camera,retreatHold:0,returnX:Math.max(180,e.homeX-480),won:false};shots=[];hazards=[];releaseInputs();player.x=clamp(player.x,arena.bounds[0]+35,arena.bounds[1]-35);player.y=FLOOR;player.vy=0;player.ground=true;e.state='idle';updateUI();}
  function leaveArena(won=false){if(!arena)return;minions=minions.filter(m=>!m.summoned);releaseInputs();arena.phase='exiting';arena.t=0;arena.won=won;arena.returnX=won?Math.min(WORLD-80,arena.homeX+(['freddy','nicolas','dede','arthur'].includes(arena.type)?90:460)):Math.max(180,arena.homeX-480);if(activeBoss&&!won){activeBoss.hp=activeBoss.max;activeBoss.x=activeBoss.homeX;bossDefaults(activeBoss);marcoTrapTriggered=false;}activeBoss=null;shots=[];hazards=[];}
  function retreatBoss(){if(sandbox&&window.C2Luta?.skin){emitGameEvent('sandbox-change',{type:sandbox.type,result:'retreat'});return true;}/* luta da Campanha 2: avisa a C2, que volta ao ponto de controle */if(sandbox){return exitSandbox();}if(!arena||arena.phase!=='active'||dialog||paused)return false;leaveArena(false);toast('Você recuou da arena. O chefe voltou à força total.');return true;}
  function updateArenaTransition(dt){
    arena.t+=dt;arena.blend=arena.phase==='entering'?clamp(arena.t/.6,0,1):1-clamp(arena.t/.6,0,1);camera=arena.exteriorCamera+(arena.homeX-W/2-arena.exteriorCamera)*arena.blend;
    if(arena.t>=.6){if(arena.phase==='entering'){arena.phase='active';arena.blend=1;camera=arena.homeX-W/2;if(activeBoss){const e=activeBoss,key=e.type==='reeisBoss'?'boss_reeis':'boss_'+e.type;if(e.type==='igor'||e.type==='kaique'){e.state='monitorTransform';e.stateTimer=1.25;e.monitorTransform=0;player.inv=Math.max(player.inv,1.5);floating(e.x,e.y-150,e.type==='igor'?'SEM LANCHE? BARRIGA GIGANTE!':e.rage?'NÃO PISA NO NOME DA IRACI!':'ENTREGA ESSAS BOLINHAS!','#ffd49c');shake=7;fx(e.x,e.y-45,e.rage?'#e66f73':'#e8c386',35,130);}else if(!seenBossIntros.includes(e.type)){seenBossIntros.push(e.type);startCutscene(key,()=>{if(activeBoss===e)beginBossWindup(e);save();});}else beginBossWindup(e);}}else{const x=arena.returnX;arena=null;resetWorldSize();player.x=x;player.y=FLOOR;player.vy=0;player.ground=true;lastSafeX=x;player.inv=Math.max(player.inv,1.2);camera=clamp(x-W*.36,0,WORLD-W);releaseInputs();}updateUI();}
  }
  function damageMinion(m,n,element){
    if(m.dead||m.hit>0)return;m.hp-=n;m.hit=.14;window.SceneLife?.impact?.(m.x,m.y-22,element==='electric'?'#a9e7f4':element==='fire'?'#f4ad60':'#e9c27a',n,-player.facing);window.CampaignVfx?.emit?.('hit',{x:m.x,y:m.y-22,dir:player.facing,element,damage:n,kind:m.type});if(element==='fire')m.burn=2.5;fx(m.x,m.y-20,element==='electric'?'#a9e7f4':element==='fire'?'#f4ad60':'#d2afd9',7,75);floating(m.x,m.y-55,'−'+Math.round(n));
    if(element==='electric'){const others=minions.filter(a=>!a.dead&&a!==m&&Math.abs(a.x-m.x)<150);for(const a of others){a.hp-=Math.max(3,n*.35);window.CampaignVfx?.emit?.('hit',{x:a.x,y:a.y-22,dir:player.facing,element:'electric',damage:n*.35,kind:a.type});fx(a.x,a.y-20,'#b9edf7',6,60);if(a.hp<=0)damageMinion(a,1);}}
    if(m.hp<=0){m.hp=0;m.dead=true;if(!m.summoned){if(!minionKills.includes(m.id))minionKills.push(m.id);awardXP(m.xp??25+(m.tier||1)*10,'minion-'+m.id);player.papers=Math.min(30,player.papers+4);player.gas=Math.min(bonus().maxGas,player.gas+8);}fx(m.x,m.y-20,'#ecd2f0',15,120);save();}updateUI();
  }
  function updateMinions(dt){
    for(const m of minions){
      // Temporary creatures expire even beyond the normal enemy activation distance.
      if(m.temporary){m.life-=dt;if(m.life<=0){m.dead=true;continue;}}
      if(m.dead||arena&&!m.summoned)continue;
      m.hit=Math.max(0,m.hit-dt);
      if(m.burn>0){m.burn-=dt;m.burnTick=(m.burnTick||0)+dt;if(m.burnTick>.6){m.burnTick=0;damageMinion(m,4);}}
      if(m.dead||Math.abs(m.x-player.x)>650)continue;
      m.tauntTimer=(m.tauntTimer??1.2)-dt;
      if(m.tauntTimer<=0&&Math.abs(m.x-player.x)<410){m.tauntTimer=5+(m.tier||1)*.3;floating(m.x,m.y-65,m.provocation||(m.type==='rat'?'O REI DOS RATOS MANDOU!':m.design==='sixseven'?'SIX SEVEN!':'DA ROÇA PEGOU AR!'),m.type==='thug'?'#edce9a':'#e1b6ee');}
      m.t-=dt;const thug=m.type==='thug'||m.kind==='thug';
      if(m.type==='rat'){
        m.dir=Math.sign(player.x-m.x)||m.dir;
        const bounds=arena?.bounds||[25,WORLD-25];m.x=clamp(m.x+m.dir*(m.speed||115)*dt,bounds[0]+20,bounds[1]-20);m.y=FLOOR;
      }else if(thug||m.kind===2){
        const tier=m.tier||1;if(m.t<.4)m.charging=true;
        if(m.t<=0){m.charging=false;m.t=thug?Math.max(1.25,2.8-tier*.3):2.3;const a=Math.atan2(player.y-30-(m.y-30),player.x-m.x),count=thug?(m.weapon==='scatter'?3:m.weapon==='carbine'?2:1):1;for(let i=0;i<count;i++){const spread=(i-(count-1)/2)*.15;shots.push({x:m.x,y:m.y-30,vx:Math.cos(a+spread)*(185+tier*16)*(m.projectileSpeed||1),vy:Math.sin(a+spread)*(185+tier*16)*(m.projectileSpeed||1),life:4,type:thug?'enemyBullet':'doodle',owner:'enemy',damage:m.damage||8,variant:1});}beep(145,.035,'square',.008);}
      }else{
        m.x+=m.dir*(m.speed||(m.kind===1?75:58))*dt;if(Math.abs(m.x-m.homeX)>m.range)m.dir*=-1;
        if(m.kind===1&&m.t<=0&&m.y>=FLOOR){m.vy=-240;m.t=1.5;}m.vy+=760*dt;m.y=Math.min(FLOOR,m.y+m.vy*dt);if(m.y===FLOOR)m.vy=0;
      }
      if(Math.abs(m.x-player.x)<(m.type==='rat'?24:30)&&Math.abs(m.y-player.y)<(m.type==='rat'?42:52)){if(dashTimer>0)damageMinion(m,Math.round(30*bonus().damageMultiplier));else hurt(m.damage||8,m.x);}
    }
    minions=minions.filter(m=>!m.temporary||(!m.dead&&m.life>0));
  }
  function movePlayer(dt){
    if(![player.x,player.y,player.vx,player.vy].every(Number.isFinite)){recoverFall();return;}
    const duelo=activeBoss?.conquista;
    const terreno=terrenoConquista(duelo);
    if(terreno)terreno.avancar(duelo,dt,player);
    const left=keyHeld('left')||touch.left,right=keyHeld('right')||touch.right,up=keyHeld('up')||touch.up,down=keyHeld('down')||touch.down,jump=keyHeld('jump')||touch.jump;
    const sensitivity=window.ControlSettings?.getSensitivity?.()||1,dir=((right?1:0)-(left?1:0))||joystick.x,targetVX=dir*(vehicle?420:bonus().moveSpeed),accel=(dir?(vehicle?1600:player.ground?1800:1150):(player.ground?2200:950))*sensitivity;
    if(dashTimer>0){player.vx=dashDir*600;afterimages.push({x:player.x,y:player.y,facing:player.facing,life:.2});}else player.vx+=clamp(targetVX-player.vx,-accel*dt,accel*dt);if(Math.abs(player.vx)<.1)player.vx=0;if(dir&&dashTimer<=0)player.facing=Math.sign(dir);player.anim+=Math.abs(player.vx)*dt/18.3;
    if(vehicle&&player.gas>0){player.vy=jump||up?-190:down?180:joystick.y?joystick.y*190:Math.sin(time*2)*7;player.gas=Math.max(0,player.gas-dt*(dir||jump||up?8:3));if(!player.gas){vehicle=false;toast('Acabou o gás! Aguarde a recarga no chão.');}if(Math.random()<.4)fx(player.x-player.facing*45,player.y-12,'#c1db7b',1,25);}
    else{if(jump&&!prevJump&&player.ground){player.vy=duelo?.estrada?-405:-365;player.ground=false;beep(320,.06,'triangle');}if(jump&&!duelo?.estrada&&!player.ground&&player.gas>0){/* Flight adds lift without clipping the stronger initial jump impulse. */if(player.vy>-235)player.vy=Math.max(-235,player.vy-1050*dt);player.gas=Math.max(0,player.gas-17*dt);if(Math.random()<.35)fx(player.x,player.y+3,'#bed970',1,50);}player.vy+=850*dt;}
    prevJump=!!jump;const oldY=player.y,wasGrounded=player.ground,bounds=arena?.bounds||[25,WORLD-25];player.x=clamp(player.x+player.vx*dt,bounds[0],bounds[1]);player.y+=player.vy*dt;player.ground=false;
    if(terreno)terreno.pousar(duelo,player,oldY,hurt);
    else if(player.y>=FLOOR&&!gapAt(player.x)){player.y=FLOOR;player.vy=0;player.ground=true;}if(player.y<95){player.y=95;player.vy=Math.max(0,player.vy);}
    if(!terreno&&!vehicle&&player.vy>=0)for(const p of scenePlatforms())if(player.x>p[0]-8&&player.x<p[0]+p[2]+8&&oldY<=p[1]+3&&player.y>=p[1]){player.y=p[1];player.vy=0;player.ground=true;if(p[3])player.x+=p[3];}
    if(!wasGrounded&&player.ground)player.landTimer=.15;if(!vehicle&&!jump)player.gas=Math.min(bonus().maxGas,player.gas+dt*(player.ground?(bonus().gasRegen||16):(bonus().airGasRegen||6)));
    if(!room&&!arena&&player.ground&&player.y===FLOOR&&!gapAt(player.x))lastSafeX=player.x;
    if(player.y>H+80)recoverFall();
    camera=room?0:terreno?(duelo.l+duelo.r-W)/2:arena?arena.homeX-W/2:clamp(player.x-W*.36,0,WORLD-W);
    // Movement and dodging never cancel a fight. Retreat is an explicit E interaction.
    if(arena)arena.retreatHold=0;
  }

  function basePlayer(){return {x:230,y:FLOOR,vx:0,vy:0,hp:bonus().maxHP,gas:bonus().maxGas,papers:30,facing:1,ground:true,inv:0,attack:0,attackType:'paper',attackDuration:.22,anim:0,landTimer:0};}
  player=basePlayer();
  function safe(fn){try{return fn();}catch(e){return null;}}
  function setText(id,t){const e=$(id);if(e&&e.textContent!==String(t))e.textContent=t;}
  function show(id,yes){const e=$(id);if(e){e.hidden=!yes;e.style.display=yes?'':'none';}}
  function toast(t){setText('toast',t);const e=$('toast');if(e){e.classList.add('show');e.hidden=false;}toastTimer=4;}
  function beep(freq=440,dur=.09,type='square',volume=.025){if(!sound)return;volume*=window.DarocaAudio?.sfx?.()??1;if(volume<=.0005)return;safe(()=>{audioCtx=audioCtx||new(window.AudioContext||window.webkitAudioContext)();audioCtx.resume();const o=audioCtx.createOscillator(),g=audioCtx.createGain();o.type=type;o.frequency.setValueAtTime(freq,audioCtx.currentTime);o.frequency.exponentialRampToValueAtTime(Math.max(35,freq*.5),audioCtx.currentTime+dur);g.gain.setValueAtTime(volume,audioCtx.currentTime);g.gain.exponentialRampToValueAtTime(.001,audioCtx.currentTime+dur);o.connect(g);g.connect(audioCtx.destination);o.start();o.stop(audioCtx.currentTime+dur);});}
  function fx(x,y,color,count=10,power=90){const amount=Math.min(12,Math.max(0,Math.round(count*.5)),Math.max(0,96-particles.length));for(let i=0;i<amount;i++)particles.push({x,y,vx:rand(-power,power),vy:rand(-power,power*.35),life:rand(.18,.48),max:.48,color,size:rand(2,4)});}
  function floating(x,y,text,color='#fff4d1'){damageTexts.push({x,y,text,color,life:1.2});}
  function save(){if(!started||sandbox)return;safe(()=>localStorage.setItem(SAVE,JSON.stringify({q,scene,hp:player.hp,papers:player.papers,items,collected,weapon,minionKills,seenBossIntros,position:{x:!room&&!arena?player.x:lastSafeX,scene},progression:window.Progression?.serialize?.(),run:window.CampaignRun?.serialize?.(),campaignVersion:3.9,version:1})));updateContinue();}
  function load(){return safe(()=>{const a=JSON.parse(localStorage.getItem(SAVE));return a&&a.version===1&&a.q?a:null;});}
  let menuLookQuest=load()?.q;
  function getJaglionStatus(){
    const quest=started?q:menuLookQuest;
    if(!quest?.amandaDating)return 'locked';
    return quest.jaglionClaimed?'ready':'reserved';
  }
  function updateContinue(){const b=$('continueBtn');if(b){const yes=!!load();b.hidden=!yes;b.style.display=yes?'':'none';}}
  function mission(){
    if(scene===8&&getJaglionStatus()==='reserved')return ['A entrega da Amanda','O Jaglion está pronto. Fale com Davi na Bigodon e receba o traje para vestir no espelho.'];
    if(scene===10&&!q.bivoltUnlocked){const s=window.BivoltQuest?.state?.(q);return ['Bivolt · energia da resenha',q.bivoltAccepted?`${s?.collected?.length||0}/3 latas encontradas. Suba as prateleiras e a varanda; depois volte às garotas.`:'Converse com as garotas na Casa de Rayssa para descobrir um energético que fortalece todos os atributos por 10 segundos.'];}
    const fardaObj=window.MissaoFarda?.objetivo?.(q,scene);if(fardaObj)return fardaObj;
    if(scene===11&&!q.ollyan)return ['Orelhas ao vento','Ollyan está no meio do baile. Use o carro a gás para persegui-lo numa luta aérea de três fases. Invista nos atributos antes de decolar.'];
    if(window.Campaign?.currentQuest){const result=window.Campaign.currentQuest(q,{level:levelState().level,carParts:q.carParts.length,notebooks:q.notebooks.length,activity,training});if(Array.isArray(result))return result;}
    if(!q.carMissionAccepted)return ['O carro do pai quebrou','Fale com Lucas na roça. Ele sabe quais peças faltam para consertar o carro a gás.'];
    if(!q.lucas)return ['Oficina no meio do parkour',`Encontre as 3 peças pelas plataformas da roça (${q.carParts.length}/3) e volte ao Lucas.`];
    if(!q.mota)return ['Futebol antes da aventura','Entre no carro e vá ao Campo do Mota. Vença o minigame para aprender o dash!'];
    if(!q.almiro)return ['Os cadernos do Almiro',q.almiroAccepted?`Recupere os 3 cadernos no corredor (${q.notebooks.length}/3) e entregue ao professor na sala 01.`:'Vá à escola e entre na sala do Almiro. Ele tem uma missão e ensina o combo de gás.'];
    if(!q.miqueias)return ['ALLRIGHT, uma aula especial','Na segunda sala, complete o quiz do Miqueias para liberar as papaias elementais.'];
    if(!q.reeis)return ['O rei do morro','Viaje à favela. Enfrente os capangas, vença Reeis no topo e peça sua ajuda pelo bolo.'];
    if(!q.marco)return ['Rabiscos que pegam vida','Volte à escola, atravesse os monstros de Marco e enfrente o desenhista. Cuidado com o piso SARUÊ!'];
    if(!q.giant)return ['O maior rabisco do caderno','O caminho ao Caderno do Caos foi aberto. Vença o monstro gigante criado por Marco.'];
    if(!q.menezes)return ['A última provocação da escola','Retorne ao fim do colégio para enfrentar as paredes, ecos e ondas de Menezes.'];
    if(!q.trained)return ['Treino de respeito','Vá à academia e complete as 3 rodadas do Caleb. Seu shape e seus ataques vão mudar!'];
    if(!q.nikolas)return ['A amizade e o último pedaço','Entre no carro para a quadra. Derrote Nikolas, o nariz de batata, e recupere o bolo.'];
    return ['O bolo voltou para a turma!','Campanha concluída! Explore os 8 lugares, repita o futebol e continue evoluindo seus atributos.'];
  }
  function updateUI(){
    updateBivoltUI();
    const hearts=clamp(Math.ceil(player.hp/bonus().maxHP*5),0,5);setText('hpValue',('♥ '.repeat(hearts)+'♡ '.repeat(5-hearts)).trim());$('hpValue')?.setAttribute('aria-label',`Vida: ${Math.ceil(player.hp)} de ${bonus().maxHP}`);setText('paperValue',player.papers);const localC2=window.C2Luta?.skin?.lugar;
    setText('stageName',localC2||scenes[scene]);setText('sceneLabel',localC2?'CONQUISTA / '+localC2.toUpperCase():String(scene+1).padStart(2,'0')+' / '+scenes[scene].toUpperCase());
    const gas=$('gasFill');if(gas)gas.style.width=(player.gas/bonus().maxGas*100)+'%';
    const hp=$('hpFill');if(hp)hp.style.width=clamp(player.hp/bonus().maxHP*100,0,100)+'%';
    const gf=$('gasPercent')||$('gasValue');if(gf)gf.textContent=Math.floor(player.gas/bonus().maxGas*100)+'%';
    const [title,desc]=mission();setText('missionTitle',title);setText('missionDesc',desc+(q.kaua&&weapon<2&&materialCount()>=(weapon===0?3:5)?' Kauã já pode fabricar sua próxima arma na roça!':''));
    setText('materialValue',materialCount());setText('weaponValue','Nível '+weapon);$('weaponValue')?.setAttribute('title',weaponNames[weapon]);
    show('trainingAction',!!training?.active&&!paused&&!dialog);const shell=$('gameShell');if(shell){shell.classList.toggle('is-training',!!training?.active&&!activity);shell.classList.toggle('is-paused',paused);shell.classList.toggle('is-dialog',!!dialog);}document.querySelectorAll('[data-action="taunt"]').forEach(el=>{el.hidden=scene!==3;el.setAttribute('aria-label','Provocar Nikolas: nariz de batata');const label=el.querySelector?.('small');if(label)label.textContent='BATATA!';});const hitButton=$('trainingHitBtn');if(hitButton)hitButton.setAttribute('aria-label',training?.active?'Acertar na faixa verde — E ou Espaço':'Treino indisponível');
    document.querySelectorAll('[data-scene]').forEach(el=>{const n=Number(el.dataset.scene);el.classList.toggle('active',n===scene);el.classList.toggle('locked',!!routeReason(n));el.setAttribute('aria-current',n===scene?'location':'false');});
    document.querySelectorAll('[data-action="reeis"]').forEach(el=>{el.classList.toggle('unlocked',q.reeis);el.title=q.reeis?(reeisCooldown>0?`Reeis recarregando: ${Math.ceil(reeisCooldown)}s`:'Chamar Reeis (R)'):'Vença Reeis na favela para conquistar sua ajuda';});
    setText('dashValue',dashCooldown>0?dashCooldown.toFixed(1)+'s':'PRONTO');document.querySelectorAll('[data-action="dash"]').forEach(el=>{el.classList.toggle('cooldown',dashCooldown>0);el.setAttribute('aria-disabled',String(dashCooldown>0||vehicle||!q.mota&&!q.trained));});
    if(shell){shell.classList.toggle('is-epilogue',cutscene?.kind==='jorge_epilogue');shell.classList.toggle('is-chapter-ended',chapterEnded);shell.classList.toggle('is-cutscene',!!cutscene||ollyanEncounter?.stage==='intro');shell.classList.toggle('is-ollyan-flight',!!ollyanEncounter);shell.classList.toggle('is-room',!!room);shell.classList.toggle('is-arena',!!arena);}
    show('chapterEndScreen',chapterEnded);show('cinematicOverlay',(!!cutscene||ollyanEncounter?.stage==='intro')&&!paused);show('roomOverlay',!!room&&!cutscene&&!activity);setText('roomName',room?(room.id==='almiro'?'Sala do Professor Almiro':'Sala do Professor Miqueias'):'');if(cutscene){const beat=window.Cinematics.beat(cutscene);setText('cinematicTitle',beat.title);setText('cinematicName',beat.speaker);setText('cinematicText',beat.text);setText('cinematicCounter',`${beat.index+1} / ${beat.total}`);}const exit=$('roomExitBtn');if(exit)exit.disabled=room?.phase!=='inside';
    const dinner=activity?.kind==='dinner';
    show('activityOverlay',!!activity&&!paused&&!dialog&&!cutscene);
    shell?.classList.toggle('is-activity',!!activity);
    shell?.classList.toggle('is-dinner',dinner);
    show('dinnerBreath',dinner&&activity.phase==='breath');
    show('dinnerSpeaker',dinner);
    if(activity){
      const view=window.Activities.view(activity);
      if(dinner){
        setText('dinnerSpeaker',view.speaker);
        $('activityOverlay').dataset.phase=activity.phase;
      }
      setText('activityTitle',view.title);
      setText('activityText',view.text);
      setText('activityScore',view.scoreLabel??activity.score);
      setText('activityMainBtn',view.actionLabel||'CHUTAR');
      setText('activityExitBtn',dinner?'Voltar à praça':'Sair do desafio');
      show('activityMainBtn',!view.choices?.length);
      show('activityExitBtn',!(dinner&&activity.phase==='outcome'&&(activity.score<2||activity.options.dating)));
      for(let i=0;i<3;i++){
        const button=$('activityChoice'+i),choice=view.choices?.[i];
        if(!button)continue;
        button.hidden=!choice;
        if(choice){
          setText(button.id,choice.label??String(choice));
          button.dataset.value=String(choice.value??i);
        }
      }
    }
    const p=$('pauseBtn');if(p)p.setAttribute('aria-label',paused?'Continuar jogo':'Pausar jogo');const nearby=closestBoss();document.querySelectorAll('[data-action=\"interact\"]').forEach(el=>{const label=el.querySelector?.('small');if(label)label.textContent=ollyanEncounter?(ollyanEncounter.stage==='intro'?'AVANÇAR':'RECUAR'):arena&&player.x<=arena.bounds[0]+78?'RECUAR':nearby?(bossAccess(nearby).ok?'DESAFIAR':'MISSÕES'):'FALAR';});
  }
  function populate(){
    resetWorldSize();shots=[];particles=[];damageTexts=[];enemies=[];pickups=[];targets=[];hazards=[];activeBoss=null;minions=[];arena=null;marcoTrapTriggered=false;
    for(let i=0;i<Math.ceil(WORLD/300);i++)pickups.push({x:620+i*280,y:FLOOR-24-(i%3===1?105:0),type:i%3===0?'gas':'paper',taken:false,t:i});
    if(scene===0||scene===1||scene===4){const places=scene===0?[590,645,700,850,900,950,1080,1135]:scene===1?[530,590,650,710,780,1040,1120,1200,1510,1620]:[580,740,980,1450,1830,2460];places.forEach((x,i)=>{const id=`${scene}-material-${i}`;pickups.push({x,y:FLOOR-24,type:['pencil','eraser','clip'][i%3],id,taken:collected.includes(id),t:i});});}
    const specs=[['igor',1,1810,850],['kaique',1,3000,1100],['marco',1,3700,1100],['menezes',1,5200,760],['nikolas',3,4300,1400],['reeisBoss',5,6300,850],['giant',6,5500,1200],['freddy',5,5680,520],['nicolas',4,5350,1050],['dede',5,5000,430],['arthur',9,2850,650]];
    for(const [type,where,x,hp] of specs){const flag=type==='reeisBoss'?'reeis':type;if(scene===where&&!q[flag]){const max=window.Difficulty?.boss(type)?.hp||hp;enemies.push({type,x:bossHome(type,x),y:FLOOR,hp:max,max,t:1,charge:0,hit:0,angry:0,rage:false,drawCount:0});}}
    minions=(window.WorldData?.minions||[]).filter(m=>m.scene===scene).map(m=>({...m,homeX:m.x,max:m.hp,dead:minionKills.includes(m.id),hit:0,t:.8+(m.kind||0)*.4,vy:0,dir:1}));
    if(scene===5&&!minions.length)for(let i=0;i<20;i++){const tier=1+Math.floor(i/5),id='favela-thug-'+i;minions.push({id,scene,x:900+i*245,homeX:900+i*245,y:FLOOR,kind:'thug',tier,weapon:['pistol','shotgun','rifle','launcher'][tier-1],hp:35+tier*20,max:35+tier*20,damage:7+tier*3,range:75,dead:minionKills.includes(id),hit:0,t:1+i%3*.3,vy:0,dir:1});}
    for(const p of window.WorldData?.collectibles||[])if(p.scene===scene&&!['repair','notebook'].includes(p.type))pickups.push({...p,t:0,taken:false});
    const repair=(window.WorldData?.questPickups?.filter(p=>p.type==='carPart')||window.WorldData?.repairParts||[{id:'motor',scene:0,x:1300,y:300},{id:'ventoinha',scene:0,x:2500,y:280},{id:'cilindro',scene:0,x:4200,y:285}]);
    for(const p of repair)if((p.scene??0)===scene)pickups.push({...p,type:'repair',t:0,taken:q.lucas||q.carParts.includes(p.id)});
    const books=window.WorldData?.questPickups?.filter(p=>p.type==='notebook')||window.WorldData?.notebooks||[{id:'caderno-1',scene:1,x:1600,y:355},{id:'caderno-2',scene:1,x:2100,y:350},{id:'caderno-3',scene:1,x:2900,y:235}];
    for(const p of books)if((p.scene??1)===scene)pickups.push({...p,type:'notebook',t:1,taken:q.almiro||q.notebooks.includes(p.id)});
    enemies.forEach(bossDefaults);
  }
  function emitGameEvent(name,detail){safe(()=>window.dispatchEvent(new CustomEvent(name,{detail})));}
  function requestRoutePicker(reason='car'){if(!vehicle||activeBoss||arena||room||cutscene||routeTransition||defeated||ollyanEncounter)return false;releaseInputs();emitGameEvent('car-route-request',{scene,reason});return true;}
  function travel(n){
    n=Number(n);if(!Number.isInteger(n)||n<0||n>=scenes.length)return false;releaseInputs();
    if(!started){toast('Comece a aventura para explorar o mapa.');return false;}
    if(paused||won||chapterEnded||defeated||room||arena||cutscene||activity||routeTransition||ollyanEncounter){toast('Aguarde a chegada ou retome a aventura.');return false;}
    if(activity){toast('Termine o minigame ou use SAIR antes de viajar.');return false;}if(training?.active){toast('Termine o treino ou use SAIR DO TREINO antes de viajar.');return false;}
    if(dialog){toast('Termine a conversa antes de viajar.');return false;}
    if(activeBoss){toast('O chefe está na sua cola! Termine a luta ou recue antes de viajar.');return false;}
    if(!q.lucas){toast('Fale com Lucas para recuperar as chaves do carro a gás do seu pai.');return false;}
    if(!vehicle){toast('Entre no carro a gás com V para escolher uma rota.');return false;}
    const blocked=routeReason(n);if(blocked){toast(blocked);beep(120,.15);return false;}
    if(n===scene){toast('Você já está aqui. Dirija e explore à direita!');return false;}
    if(window.ChegadaCarro){shots=[];hazards=[];reeisPhase='idle';reeisTimer=0;beep(160,.25,'sawtooth');routeTransition={from:scene,to:n,t:0,duration:window.EstradaViagem?.duracao||.01,estrada:true};return true;} /* estrada (estrada.js) e depois a chegada animada dentro da fase (chegada-carro.js) */
    routeTransition={from:scene,to:n,t:0,duration:1.2};shots=[];hazards=[];reeisPhase='idle';reeisTimer=0;beep(160,.25,'sawtooth');return true;
  }
  function routeReason(n){
    if(window.Campaign?.canTravel){const g=window.Campaign.canTravel(n,q);if(g&&g.ok===false)return g.reason;}
    if(n===5&&!(q.mota&&q.almiro&&q.miqueias))return 'Complete o futebol do Mota e as missões dos dois professores antes de subir à favela.';
    if(n===6&&!q.marco)return 'Vença Marco na escola para abrir o Caderno do Caos.';if(n===2&&!q.menezes)return 'Vença Menezes no fim da escola antes do treino com Caleb.';if(n===3&&!(q.trained&&q.giant&&q.menezes))return 'Vença o gigante, Menezes e complete o treino do Caleb antes do final.';return '';
  }
  function arrive(n){window.CampaignVfx?.reset?.();room=null;arena=null;lastSafeX=230;scene=n;resetWorldSize();player.x=230;player.y=FLOOR;player.vx=0;player.vy=0;player.ground=true;player.hp=Math.min(bonus().maxHP,player.hp+18);player.gas=bonus().maxGas;vehicle=true;camera=0;activeBoss=null;reeisTimer=0;reeisPhase='idle';transition=.45;routeEdgeCooldown=2;populate();updateUI();save();toast(`Chegou: ${scenes[n]}. V estaciona o carro a gás. E conversa.`);const arrival=window.Roteiro?.chegada?.(n,q);if(arrival&&!sandbox){window.Roteiro.visto(arrival,q);save();const tocar=()=>playCutscene(arrival);if(window.ChegadaCarro?.ativa?.())window.ChegadaCarro.depois(tocar);else tocar();}}
  let dialogueReopenUntil=0;
  function say(lines,done){
    const pages=[];for(const raw of lines){const line=typeof raw==='string'?{name:'Da Roça',text:raw}:raw;const words=String(line.text||'').trim().split(/\s+/);let chunk='';const chunks=[];for(const word of words){if(chunk&&chunk.length+word.length+1>108){chunks.push(chunk);chunk=word;}else chunk+=(chunk?' ':'')+word;}if(chunk||!chunks.length)chunks.push(chunk);chunks.forEach((text,i)=>{const page={...line,text};if(i!==chunks.length-1)delete page.actionLabel;pages.push(page);});}if(!pages.length)return false;dialog={lines:pages,index:0,completionRequired:!!won};dialogCallback=typeof done==='function'?done:null;releaseInputs();show('dialogBox',true);show('dialogControls',!paused&&!cutscene);renderDialog();updateUI();return true;
  }
  function renderDialog(){if(!dialog)return;const line=dialog.lines[dialog.index];setText('dialogName',line.name);setText('dialogText',line.text);setText('dialogNext',line.actionLabel||(dialog.index===dialog.lines.length-1?'Concluir  ↵':'Próximo  ↵'));setText('dialogClose',dialog.completionRequired?'Pular fala · Esc':'Fechar · Esc');emitGameEvent('dialogue-update',getDialogueAnchor());}
  function closeDialogue(completed=false){
    if(!dialog)return false;
    // Skipping the final victory speech must still hand control to its ending.
    // Cancelling an ordinary conversation never spends items or accepts a quest.
    const finish=completed||dialog.completionRequired,callback=finish?dialogCallback:null;
    dialog=null;dialogCallback=null;dialogueReopenUntil=performance.now()+300;
    releaseInputs();show('dialogBox',false);show('dialogControls',false);
    if(paused){paused=false;show('pauseScreen',false);}
    updateUI();safe(()=>canvas.focus({preventScroll:true}));
    emitGameEvent('dialogue-closed',{completed:!!finish,cancelled:!finish});
    try{if(callback)callback();}catch(error){console.error('Dialogue action failed:',error);toast('Conversa encerrada. Você pode falar com o personagem novamente.');}
    finally{updateUI();save();}
    return true;
  }
  function nextDialog(){if(!dialog)return false;if(paused){resume();return true;}beep(560,.035,'triangle',.012);if(++dialog.index>=dialog.lines.length)return closeDialogue(true);renderDialog();return true;}
  function getDialogueView(){return{dialog:!!dialog,paused,cutscene:cutscene?{...cutscene}:null};}
  function visitTalk(id){
    if(!q.npcVisits||typeof q.npcVisits!=='object'||Array.isArray(q.npcVisits))q.npcVisits={};
    const visit=Math.max(0,Math.floor(Number(q.npcVisits[id])||0));q.npcVisits[id]=visit+1;save();
    const lines=window.Resenha?.talk?.(id,visit,q);
    if(Array.isArray(lines)&&lines.length)return lines;
    const name=npcInfo[id]?.name?.split(' ·')[0]||id;
    const fallback={
      aica:['Aff veyr juro, Arthur é bestaiado. Puxar cabelo? Você se passou, menino!','Aff veyr juro! Arthur, esse idiota confundiu recreio com salão. Se toca, menino!'],
      ravile:['Aff veyr juro, Arthur se passou. Bestaiado! Da Roça, me ajuda com esse idiota.','Aff veyr juro! Meu cabelo não é corda de pular, Arthur. Você se passou demais!'],
      eloisa:['Aff veyr juro, chegou o menino da ventilação natural. Se toca, Da Roça!','Aff veyr juro, esse chapéu tá entregando mais personagem que a sua entrada.'],
      giselle:['Aff veyr juro, menino! Guarda esse papel que a sala não é arena.','Aff veyr juro, tu se passou. Aqui a fofoca tem trança e horário marcado.'],
      rayssa:['Aff veyr juro, entra. Só não usa o peido pra ligar meu ventilador.','Aff veyr juro! O menino chegou em casa como se fosse personagem desbloqueável.'],
      analaura:['Aff veyr juro, eu ia ficar quieta, mas esse chapéu pediu opinião.','Aff veyr juro! Se toca, menino. A sala é de visita, não de boss final.'],
      allef:['Da Roça chegou! Davi, recebe a entidade do chapéu antes que ela estacione no balcão.','Esse chapéu tem horário na agenda ou veio só fiscalizar o degradê?'],
      dede:['SEU GILÓ HOMI! Tu furou minha fumaça com papel de caderno!','SEU GILÓ HOMI! Era neblina de respeito, não fumaça de churrasqueira.'],
      freddy:['OPEESTY DA ROÇA! Passou por mim e ainda quer tirar onda com o Reeis?','OPEESTY DA ROÇA! Essa bolinha veio com peso de academia!']
    };
    const pool=fallback[id]||['A resenha muda, mas o bolo continua no assunto.'];
    return [{name,text:pool[visit%pool.length]}];
  }
  function openSwiftGuide(){return window.SwiftGuide?.open?.({say,toast})||false;}
  function interact(){
    if(dialog){nextDialog();return;}if(ollyanEncounter&&!paused){if(ollyanEncounter.stage==='intro'||['victory','defeat'].includes(ollyanEncounter.stage))advanceCutscene();else retreatOllyan();return;}if(!started||paused||chapterEnded||defeated||cutscene||routeTransition||performance.now()<dialogueReopenUntil)return;if(won)return;if(!activity&&!training?.active&&!arena&&!room&&!activeBoss&&!vehicle&&window.Balanco?.near?.(scene,player.x)){releaseInputs();window.Balanco.sit();return;}if(!activity&&!training?.active&&!arena&&!room&&!activeBoss&&!vehicle&&window.Fliperama?.near?.(scene,player.x)){releaseInputs();window.Fliperama.open(null,{from:'world'});return;}if(activity){submitActivity();return;}if(training?.active){submitTraining();return;}
    if(room?.phase==='inside'&&Math.abs(player.x-room.exitX)<105){exitRoom();return;}
    if(arena?.phase==='active'&&player.x<=arena.bounds[0]+78){retreatBoss();return;}
    const boss=closestBoss();if(boss){interactBoss(boss);return;}
    if(!room&&!arena){const door=(window.WorldData?.doors||[]).filter(d=>d.scene===scene&&Math.abs(player.x-d.x)<105&&Math.abs(player.y-FLOOR)<65).sort((a,b)=>Math.abs(a.x-player.x)-Math.abs(b.x-player.x))[0];if(door){enterRoom(door.id);return;}}
    if(!room&&!arena&&!vehicle&&window.WorldLife?.tryInteract?.({scene,player,q},{awardXP,save,updateUI,toast,addItem:(type,count)=>{if(Object.hasOwn(items,type))items[type]=Math.min(999,items[type]+Math.max(0,Math.floor(count)||0));}}))return;
    const found=closestNPC();if(!found){toast(vehicle?'Carro a gás ligado! Escolha uma rota ou dirija com o joystick.':'Chegue perto de alguém e aperte E. O diário mostra a próxima missão.');return;}
    const [id,n]=found;
    if(id==='amanda'){
      say(window.AmandaDinner.invitation(q),()=>{
        if(startActivity('dinner')){q.amandaInvited=true;save();}
      });
      return;
    }
    if(id==='swift'){openSwiftGuide();return;}
    if(id==='ollyan'){if(!q.ollyan)beginOllyanEncounter();else say([{name:n.name,text:'Foi mal, véi… minhas orelhas perderam o compasso. Hoje eu vou de carona e de água.'},{name:'Da Roça',text:'Fechou. Da próxima vez deixa a pilotagem com o carro do meu pai.'}]);return;}
    if(id==='almiro'){
      if(!q.almiroAccepted)say([{name:n.name,text:'ahahaha da roça sacana é com cerveja! Mas antes da resenha: meus três cadernos sumiram no corredor.'},'Até professor tem quest agora?',{name:n.name,text:'Tem! Procura os cadernos azuis nas plataformas e me traz os três. Te ensino um combo de gás que nem o ventilador aguenta.'}],()=>{q.almiroAccepted=true;toast('Missão: recolha 3 cadernos no corredor e volte à sala 01.');});
      else if(!q.almiro&&q.notebooks.length>=3)say([{name:n.name,text:'Aí sim! Três cadernos e nenhuma folha amassada... quase. Aprende: K, K, K no ritmo. O terceiro peido vira uma explosão!'},'O senhor acabou de transformar feijão em disciplina escolar.',{name:n.name,text:'Combo liberado! Agora ajuda Miqueias na sala 02 antes de subir à favela.'}],()=>{q.almiro=true;awardXP(240,'quest-almiro');toast('Combo de gás desbloqueado: três toques em K no ritmo!');});
      else say([{name:n.name,text:q.almiro?'Combo de gás: três toques separados, K → K → K. Não vale culpar a cadeira azul pelo barulho!':`Faltam ${3-q.notebooks.length} cadernos! Estão nas plataformas do corredor. A careca está brilhando, mas não é radar.`}]);return;
    }
    if(id==='miqueias'){
      if(q.miqueias)say([{name:n.name,text:'ALLRIGHT! Your papaias is elemental now, beleza creuza! Level up and fire go brrr, é ou não é?'}]);
      else say([{name:n.name,text:'ALLRIGHT! You is ready for the English challenge, é ou não é? Three correct and your paper get poderes!'},'Três acertos e o papel vira arma elemental?',{name:n.name,text:'Yes, concorda ou sem corda! Choose the word, beleza creuza. Wrong answer no cancela sua matrícula!'}],()=>startActivity('quiz'));return;
    }
    if(id==='aica'||id==='ravile'){
      const lines=visitTalk(id);say(lines,()=>{if(!q.arthur){q.patioAccepted=true;toast('Missão do pátio: Arthur está no fim do cenário. Aperte DESAFIAR para ajudar Ravile.');}save();updateUI();});return;
    }
    if(['eloisa','giselle','rayssa','analaura'].includes(id)){
      const first=!q.rayssaVisit,quest=window.BivoltQuest?.interact?.(id,q,items);say(quest?.lines||visitTalk(id),()=>{if(first&&!q.rayssaVisit){q.rayssaVisit=true;awardXP(90,'side-rayssa-visit');}if(quest?.action){const result=window.BivoltQuest.complete(q,quest.action,items);if(result?.xp)awardXP(result.xp,result.source||'side-bivolt-unlock');if(result?.message)toast(result.message);}save();updateUI();});return;
    }
    if(id==='allef'){say(visitTalk(id));return;}
    if(id==='mc_batidao'){ // Concurso da Fantasia: dança no ritmo e ganha o traje DA JEGUE
      const N=n.name,ja=!!q.daJegue;
      if(ja){say([{name:N,text:'Olha ele aí, o DA JEGUE em pessoa! Veste a fantasia no espelho e manda o passinho, que o baile pede bis!'}]);return;}
      say([{name:N,text:'Hoje é noite do CONCURSO DA FANTASIA! O prêmio é a fantasia mais lendária do galpão: o DA JEGUE, com orelhona, crina e rabo!'},{name:N,text:'Pra levar, tem que dançar no ritmo do tamborzão. Aperta as setas quando elas chegarem na linha. Nota 70 ou mais e a fantasia é tua!'},{name:'Da Roça',text:'Eu nasci dançando forró no terreiro. Tamborzão é só forró com grave!',actionLabel:'Entrar no concurso'}],()=>{
        if(!window.BaileConcurso?.abrir)return;releaseInputs();window.BaileConcurso.abrir({onFim:(ok,nota,desistiu)=>{releaseInputs();
          if(ok&&!q.daJegue){q.daJegue=true;window.DarocaLook?.ganhar?.('dajegue');awardXP(220,'side-dajegue');toast('DA JEGUE! Nota '+nota+'%. A fantasia de burro está no espelho (INVENTÁRIO › ESPELHO).');fx(player.x,player.y-60,'#ff4fa8',30,150);save();updateUI();}
          else if(!desistiu)toast('Nota '+nota+'%. O MC Batidão disse que você quase levou. Fale com ele de novo!');}});});
      return;}
    if(id==='neide'&&window.MissaoFarda){const r=window.MissaoFarda.falar(q);say(r.lines,()=>{const m=window.MissaoFarda.concluir(q,r.acao);if(m){toast(m.message);if(m.xp)awardXP(m.xp,'side-farda');save();updateUI();}});return;}
    if(id==='arthur'){say([{name:n.name,text:'Tá, eu pedi desculpa pelo cabelo. E minha orelha ainda está em modo alerta.'},
      {name:'Da Roça',text:'Boa. Da próxima vez chama pra conversar, sem puxar ninguém.'},
      {name:n.name,text:'Combinado! Posso pelo menos fazer uma pose dramática de reconciliação?'}]);return;}
    if(id==='dede'){say(visitTalk(id));return;}
    if(id==='davi'){
      const first=!q.bigodon, gift=getJaglionStatus()==='reserved';
      const wardrobeLine=gift?'Amanda mandou recado! Vitor guardou o Jaglion pra você. Prova ele no espelho, rei da selva.':
        q.jaglionClaimed?'Teu Jaglion tá no espelho junto dos chapéus. Hoje vai de juba ou de palha?':
        'O Jaglion ali? A Amanda encomendou. Ela vive na entrada da Praça Camacan. Os outros visuais são da casa.';

      say([{name:n.name,text:first?'Chegou na Bigodon! Aqui o degradê é na régua e a resenha é sem limite. Senta aí, Da Roça!':'Olha quem voltou! O único cliente que usa gás de fixador. Aqui a resenha recupera até a energia.'},
        {name:'Da Roça',text:'Só alinha o chapéu. Se cortar meu cabelo, vou perder a aerodinâmica do peido.'},
        {name:n.name,text:'Relaxa! Meu corte é tão alinhado que até o carro do seu pai sai daqui fazendo curva certinha.'},
        {name:'Vitor · ajudante',text:'Davi, a tesoura! Você está penteando o vento de novo.'},
        {name:n.name,text:'É o acabamento premium, pô! Pronto: vida cheia, gás no tanque e autoestima na régua.'},
        {name:n.name,text:wardrobeLine,actionLabel:gift?'Receber o Jaglion':'Abrir o espelho'}],()=>{if(gift)q.jaglionClaimed=true;q.bigodon=true;player.hp=bonus().maxHP;player.gas=bonus().maxGas;if(first)awardXP(120,'side-bigodon');save();updateUI();toast(gift?'Jaglion recebido na Bigodon!':'Resenha na Bigodon: vida e gás recuperados!');window.DarocaLook?.open?.({line:gift?'Davi: A juba é do Vitor, a ideia é da Amanda. O rugido é contigo!':'Davi: Senta na cadeira e escolhe. Aqui o visual é por conta da casa!'});});return;
    }
    if(id==='vitor'){
      const first=!q.vitor;
      say([{name:n.name,text:first?'Eu sou Vitor, ajudante da Bigodon. Organizo as máquinas, os horários e as histórias do Davi.':'A máquina tá carregada e a agenda tá cheia. Só a resenha que não tem horário pra acabar.'},
        {name:'Da Roça',text:'E qual é a história de hoje?'},
        {name:n.name,text:'Nicolas tá na Praça Camacan dizendo que nasceu protagonista. A trilha sonora só toca na cabeça dele.'},
        {name:n.name,text:'E na favela tem Freddy, o mais forte do Reeis. Ele tira onda do chefe: “Ô REEEIS, tá se achando rei?”'},
        {name:'Da Roça',text:'Um corte de cabelo e duas fofocas. Melhor parada do carro do meu pai!'}],()=>{q.vitor=true;if(first)awardXP(60,'side-vitor');save();toast('Dica do Vitor: Nicolas fica no fim da Praça Camacan; Freddy está antes de Reeis.');});return;
    }
    if(id==='freddy'){say(visitTalk(id));return;}
    if(id==='nicolas'){say([{name:n.name,text:'Você viu minha aura suprema? Eu quase parti o céu. Só parei porque a praça tem horário de silêncio.'},
      {name:'Da Roça',text:'Nicolas, tu tava parado fazendo “vush, pá, bum” com a boca. O pombo foi o único que saiu voando.'},
      {name:n.name,text:'Foi uma batalha em outra dimensão! Você ainda não desbloqueou a câmera de protagonista.'},
      {name:'Da Roça',text:'Tá certo, guerreiro. Vou ali buscar meu bolo enquanto a sua dimensão esfria.'}]);return;}
    if(id==='mota'){say([{name:n.name,text:q.mota?'Bora repetir? O gol nunca fecha e treino dá XP. Mira, escolhe a força e chuta!':'Sou Gabriel Mota, profissional da resenha e do futebol da escola. Faz 3 gols em 5 chutes pra aprender o dash!'},'Vale gol de peido?',{name:n.name,text:'Hoje só vale bola! Aperta E ou CHUTAR pra travar a mira, de novo pra força. O goleiro se mexe: capricha!'}],()=>startActivity('football'));return;}
    if(id==='lucas'){
      if(!q.carMissionAccepted)say([{name:n.name,text:'Nikolas levou o bolo... e o carro a gás do seu pai está quebrado! Preciso da ventoinha, do cano e da vela.'},'Roubaram o bolo e ainda caiu a manutenção no meu colo?',{name:n.name,text:'As três peças estão espalhadas nas plataformas da roça. Parkour primeiro, vingança depois. Traz tudo aqui que eu conserto!'}],()=>{q.carMissionAccepted=true;toast('Colete as 3 peças pelas plataformas da roça e volte ao Lucas.');});
      else if(!q.lucas&&q.carParts.length>=3)say([{name:n.name,text:'Ventoinha, cano e vela! Agora sim. *aperta um parafuso, assopra outro* O carro do seu pai voltou!'},'Vruuum! É a mistura de oficina com feijão.',{name:n.name,text:'V entra no carro e abre as rotas. Conheça Mota no campo e os professores na escola antes de enfrentar os chefões!'}],()=>{q.lucas=true;awardXP(250,'quest-repair-car');toast('Carro a gás consertado! V para entrar e escolher uma rota.');});
      else say([{name:n.name,text:q.lucas?(q.nikolas?'O bolo voltou! A receita é chocolate e amizade. Sapo é só meu apelido!':'O carro está pronto. Mota ensina o dash no campo; os professores têm missões na escola.'):`Já achou ${q.carParts.length}/3 peças. Procura nas plataformas da roça, inclusive lá no fim!`}]);return;
    }
    if(id==='kaua'){if(!q.kaua)say([{name:n.name,text:kauaVoice+' Lápis, borracha e clipe viram armas! 3 materiais criam o Lançador de régua; mais 5 fazem o Canhão de estojo.'},'Oficina de armas ou papelaria?',{name:n.name,text:'Os dois! Coleta os materiais brilhantes e volta aqui. As papaias ganham poderes na aula do Miqueias!'}],()=>{q.kaua=true;toast('Kauã: 3 materiais para arma1; outros5 para arma2.');});else craft();return;}
    if(id==='reeis'){say([{name:n.name,text:'Você ganhou meu respeito na favela! Agora é só chamar: OHHHH REEEEIS!'},'O bolo tem reforço de peso agora!',{name:n.name,text:'Marco está no colégio. Cuidado com o piso SARUÊ: pisou, o desenhista fica vermelho de raiva.'}]);return;}
    if(id==='ravid'){say([{name:'Ravid · olhando para a parede',text:'Se o quadro é verde água... será que a parede está com sede?'},'Ravid, tem monstro desenhado andando no corredor!',{name:'Ravid',text:'Eu também desenhei um futuro brilhante... mas a parede ainda não respondeu.'},'Boa conversa com a parede aí.']);return;}
    if(id==='caleb'){
      if(!q.menezes){say([{name:n.name,text:'Primeiro vence Menezes! Whey não resolve provocação física, mas uns reflexos ajudam.'}]);return;}
      if(!q.trained)say([{name:n.name,text:'Hoje tem leg day, bolo day e zero desculpa! Seu gás é monstro, mas esse braço ainda parece lápis HB.'},'Vai me fazer levantar o carro?',{name:n.name,text:'Só o marcador! Três rodadas, dois acertos no verde em cada. Depois disso teu shape assusta até o catarro do Nikolas!'}],startTraining);
      else say([{name:n.name,text:'Olha o shape do supino de bolo! Quer repetir? Só não vai fazer flexão usando a barriga do Miqueias de apoio!'},'Bora repetir o treino!',{name:n.name,text:'Verde, E e força! O treino não apaga seus músculos nem as rotas.'}],startTraining);
    }
  }
  function start(continuing=false){
    window.CampaignVfx?.reset?.();
    if(sandbox)exitSandbox();
    resetBivolt();ollyanEncounter=null;ollyanRetryGrace=0;started=true;playing=true;paused=false;won=false;defeated=false;chapterEnded=false;show('chapterEndScreen',false);activeBoss=null;respawnCheckpoint=null;routeTransition=null;room=null;arena=null;cutscene=null;cutsceneCallback=null;lastSafeX=230;tauntCooldown=0;dashTimer=0;dashCooldown=0;reeisPhase='idle';show('startScreen',false);show('pauseScreen',false);show('victoryScreen',false);show('defeatScreen',false);show('dialogBox',false);dialog=null;training=null;activity=null;activityCallback=null;comboStep=0;comboWindow=0;releaseInputs();
    const data=continuing?load():null;if(data)window.CampaignRun?.restore?.(data.run,{mode:window.Difficulty?.getMode?.()||'normal',legacy:!data.run,completed:!!data.q?.nikolas});else window.CampaignRun?.start?.();q=data?{...emptyQuest(),...data.q}:emptyQuest();q.carParts=Array.isArray(q.carParts)?q.carParts:[];q.notebooks=Array.isArray(q.notebooks)?q.notebooks:[];q.bivoltParts=Array.isArray(q.bivoltParts)?q.bivoltParts:[];q.bivoltCharges=clamp(Math.floor(Number(q.bivoltCharges)||0),0,9);q.npcVisits=q.npcVisits&&typeof q.npcVisits==='object'&&!Array.isArray(q.npcVisits)?{...q.npcVisits}:{};for(const id of Object.keys(q.npcVisits)){const count=Number(q.npcVisits[id]);q.npcVisits[id]=Number.isFinite(count)?clamp(Math.floor(count),0,1000000):0;}window.Progression?.restore?.(data?.progression);seenBossIntros=Array.isArray(data?.seenBossIntros)?data.seenBossIntros:[];items={pencil:0,eraser:0,clip:0};if(data?.items)for(const k of Object.keys(items))items[k]=clamp(Math.floor(Number(data.items[k])||0),0,999);collected=Array.isArray(data?.collected)?data.collected.filter(x=>typeof x==='string'):[];minionKills=Array.isArray(data?.minionKills)?data.minionKills.filter(x=>typeof x==='string'):[];weapon=clamp(Math.floor(Number(data?.weapon)||0),0,2);player=basePlayer();scene=data?clamp(data.scene,0,scenes.length-1):0;if(scene===3&&!q.trained)scene=2;player.hp=data?Math.min(bonus().maxHP,Math.max(55,data.hp||100)):bonus().maxHP;player.papers=data?Math.max(15,data.papers||30):30;vehicle=false;camera=0;reeisCooldown=0;reeisTimer=0;attackCooldown=0;fartCooldown=0;killCount=0;populate();if(data?.position?.scene===scene){const savedX=Number(data.position.x);const px=clamp(Number.isFinite(savedX)?savedX:230,30,WORLD-30);player.x=px;player.y=FLOOR;player.vy=0;lastSafeX=player.x;camera=clamp(player.x-W*.36,0,WORLD-W);}updateUI();save();canvas.focus();
    if(!continuing)startCutscene('intro',()=>{toast('A aventura começou! Encontre Lucas à direita.');openSwiftGuide();});
    else if(q.nikolas&&!q.celebrationSeen)beginCelebration();
    else if(q.nikolas&&(!q.jorgeSeen||q.jorgeStarted))beginPostCelebration();
    else toast('Aventura retomada! Seu objetivo está no painel.');
  }
  function returnToMenu(){
    if(sandbox)exitSandbox();
    window.CampaignRun?.setActive?.(false);if(started)save();resetBivolt();ollyanEncounter=null;ollyanRetryGrace=0;releaseInputs();
    if(activeBoss){activeBoss.hp=activeBoss.max;activeBoss.x=activeBoss.homeX;bossDefaults(activeBoss);}
    if(started)menuLookQuest=q;
    started=false;playing=false;paused=false;won=false;defeated=false;chapterEnded=false;vehicle=false;
    dialog=null;dialogCallback=null;cutscene=null;cutsceneCallback=null;training=null;activity=null;activityCallback=null;
    room=null;arena=null;activeBoss=null;routeTransition=null;reeisPhase='idle';reeisTimer=0;
    window.CampaignVfx?.reset?.();shots=[];hazards=[];minions=minions.filter(m=>!m.summoned);particles=[];damageTexts=[];afterimages=[];
    resetWorldSize();player.x=clamp(lastSafeX,30,WORLD-30);player.y=FLOOR;player.vy=0;player.ground=true;camera=clamp(player.x-W*.36,0,WORLD-W);
    for(const id of ['chapterEndScreen','pauseScreen','victoryScreen','defeatScreen','dialogBox','dialogControls','cinematicOverlay','roomOverlay','activityOverlay','trainingAction'])show(id,false);
    show('startScreen',true);updateContinue();updateUI();emitGameEvent('game-menu');return true;
  }
  function pause(){window.CampaignRun?.setActive?.(false);releaseInputs();if(!started||won||defeated||chapterEnded)return;paused=true;show('pauseScreen',true);updateUI();save();}
  function resume(){releaseInputs();if(sandbox?.result){toast('Escolha TENTAR DE NOVO ou VOLTAR À CAMPANHA.');show('pauseScreen',true);return;}if(chapterEnded)return;paused=false;show('pauseScreen',false);canvas.focus();updateUI();}
  function reset(){safe(()=>localStorage.removeItem(SAVE));q=emptyQuest();start(false);}
  function action(a){if(inputCaptured||window.Arena?.isOpen?.())return;if((scene>=12||window.C2Luta?.skin)&&window.CampanhaPoderes){if(window.CampanhaPoderes.sairam().includes(a))return;if(a==='poder1'||a==='poder2'){window.CampanhaPoderes.acionarNoJogo?.(a==='poder1'?0:1);return;}}else if(a==='poder1'||a==='poder2')return;if(a==='interact'){interact();return;}if(!started||paused||dialog||won||defeated||room||cutscene||routeTransition)return;if(a==='bivolt'){activateBivolt();return;}if(ollyanEncounter){if(['paper','fart','dash'].includes(a))window.OllyanEncounter.attack(ollyanEncounter,a);else if(a==='vehicle')toast('E ou FALAR faz o carro voltar ao baile.');updateUI();return;}if(a==='activity'){submitActivity();return;}if(activity)return;if(a==='train'){submitTraining();return;}if(training?.active)return;if(a==='dash'){dash();return;}if(a==='taunt'){taunt();return;}if(a==='paper')paperAttack();if(a==='fart')fartAttack();if(a==='reeis')summon();if(a==='vehicle')toggleVehicle();}
  function craft(){
    if(!started||paused||dialog||training?.active||activity||won||defeated||room||cutscene||routeTransition)return false;
    if(scene!==0||Math.abs(player.x-npcInfo.kaua.x)>110){toast('Procure Kauã na roça para fabricar uma arma com materiais escolares.');return false;}
    if(weapon>=2){say([{name:'Kauã · inventor',text:`${kauaVoice} Seu Canhão de estojo já está no máximo! Você ainda tem ${materialCount()} materiais. Use J para disparar três projéteis de fantasia de uma vez!`}]);return false;}
    const cost=weapon===0?3:5,next=weapon+1;
    if(materialCount()<cost){say([{name:'Kauã · inventor',text:`${kauaVoice} Você tem ${materialCount()} materiais: ${items.pencil} lápis, ${items.eraser} borracha e ${items.clip} clipe. Preciso de ${cost} materiais, em qualquer combinação, para fabricar ${weaponNames[next]}.`},{name:'Kauã · inventor',text:`Faltam ${cost-materialCount()}! Pegue os materiais brilhantes pela roça e pela escola. Depois, volte e aperte E. Não precisa trocar seu papel nem seu gás!`}]);return false;}
    say([{name:'Kauã · inventor',text:`${kauaVoice} Inventário: ${materialCount()} materiais. Vou trocar ${cost} por ${weaponNames[next]}. ${next===1?'Suas bolinhas de papel ganham um lançamento bem mais forte!':'Cada disparo lança três projéteis de fantasia!'}`},{name:'Kauã · inventor',text:`Aperte FABRICAR ou E para gastar ${cost} materiais e equipar ${weaponNames[next]}.`,actionLabel:`FABRICAR · ${cost} MATERIAIS  ↵`}],()=>{let remaining=cost;for(const type of ['pencil','eraser','clip']){const use=Math.min(items[type],remaining);items[type]-=use;remaining-=use;}weapon=next;fx(player.x,player.y-40,'#9fdac1',35,150);beep(840,.22,'triangle');toast(`${weaponNames[weapon]} equipado! Aperte J. ${materialCount()} materiais restantes.`);updateUI();save();});
    return true;
  }
  function taunt(){
    if(!started||paused||dialog||training?.active||activity||won||defeated||room||cutscene||routeTransition)return false;
    if(scene!==3){toast('O SARUÊ agora é uma armadilha no chão. Não pise nela perto de Marco!');return false;}
    const nik=enemies.find(e=>e.type==='nikolas'&&e.hp>0&&Math.abs(e.x-player.x)<560);if(!nik){toast('Chegue perto de Nikolas para provocar o nariz de batata.');return false;}if(tauntCooldown>0)return false;tauntCooldown=4;floating(player.x,player.y-115,'Ô NARIZ DE BATATA!','#ffe3ad');floating(nik.x,nik.y-135,'É AERODINÂMICO!','#ecc39b');beep(210,.12,'triangle');return true;
  }
  const dinnerMeter=$('dinnerBreath');
  dinnerMeter.style.setProperty('--band-start',(window.AmandaDinner.band.start*100)+'%');
  dinnerMeter.style.setProperty('--band-end',(window.AmandaDinner.band.end*100)+'%');
  function startActivity(kind){
    if(!window.Activities?.create){toast('Minigame indisponível. Recarregue a atualização.');return false;}
    if(kind==='football'&&scene!==7)return false;if(kind==='quiz'&&room?.id!=='miqueias')return false;
    if(kind==='dinner'&&(scene!==npcInfo.amanda.scene||closestNPC()?.[0]!=='amanda'))return false;
    releaseInputs();vehicle=false;activity=window.Activities.create(kind,{level:levelState().level,trained:q.trained,dating:q.amandaDating});activityCallback=kind;updateUI();return true;
  }
  function submitActivity(value){if(!activity||paused||dialog||cutscene)return false;const result=window.Activities.submit(activity,value);if(activity?.done)finishActivity();else updateUI();return result;}
  function finishActivity(){
    if(!activity)return;const result=activity,kind=activityCallback;activity=null;activityCallback=null;releaseInputs();
    if(kind==='dinner'){
      if(result.success&&!q.amandaDating){
        q.amandaDating=true;
        awardXP(window.Campaign.rewards.amanda,'quest-amanda');
        save();
        say(['Quero, uai! Agora eu tenho dois motivos pra dividir a sobremesa.',
          {name:'Amanda',text:'Um é sua namorada. O outro é o tamanho do seu olho, né?'},
          {name:'Amanda',text:'Passa na Bigodon. O Davi guardou o Jaglion que eu e o Vitor desenhamos pra você.'}]);
      }else toast(q.amandaDating?'De volta à praça com Amanda.':'O convite continua de pé. Fale com Amanda para tentar outra vez.');
      updateUI();
      return;
    }
    if(result.success){if(kind==='football'){const first=!q.mota;q.mota=true;awardXP(first?300:70,first?'quest-mota':null);say([{name:'Mota',text:first?'GOOOL! Três gols! Agora o dash é seu: L, Shift ou o botão » pra escapar dos golpes.':'Gol de quem treina! XP ganho. Pode repetir sempre que quiser evoluir.'},'O bolo vai receber um passe de respeito!'],()=>toast('Dash desbloqueado! Distribua seus pontos de nível nos atributos.'));}else{q.miqueias=true;awardXP(260,'quest-miqueias');say([{name:'Professor Miqueias',text:'ALLRIGHT! You win the English, beleza creuza! Your papaias got elemental powers, concorda ou sem corda?'},'A aula melhorou até meu papel!',{name:'Professor Miqueias',text:'Level3 fire, level5 electric! Go level up and visit the favela, é ou não é?'}],()=>toast('Papaias elementais liberadas! Evolua o nível para fortalecer os disparos.'));}}
    else toast(kind==='football'?'Quase! Converse com Mota para tentar os chutes de novo.':'Tente novamente com o professor.');updateUI();save();
  }
  function cancelActivity(){if(!activity)return false;window.Activities?.cancel?.(activity);activity=null;activityCallback=null;releaseInputs();updateUI();toast('Minigame interrompido. Converse para tentar novamente.');return true;}
  function setTrainingZone(){const widths=[.30,.26,.22],starts=[.34,.49,.24];training.zoneStart=starts[training.round-1];training.zoneEnd=training.zoneStart+widths[training.round-1];training.speed=.64+(training.round-1)*.14;}
  function startTraining(){
    if(scene!==2)return;
    q.training=true;vehicle=false;releaseInputs();player.vx=0;player.vy=0;player.y=FLOOR;player.ground=true;player.facing=1;
    training={active:true,round:1,hits:0,totalHits:0,score:0,combo:0,bestCombo:0,misses:0,marker:0,direction:1,cooldown:.35,zoneStart:.34,zoneEnd:.64,speed:.64,feedback:'ESPERE O MARCADOR ENTRAR NO VERDE',feedbackGood:true};
    setTrainingZone();updateUI();save();toast('Treino: E, Espaço ou ACERTAR no verde. Você pode errar e tentar de novo!');
  }
  function cancelTraining(){if(!training?.active)return;training=null;releaseInputs();updateUI();save();toast('Treino interrompido. Fale com Caleb para tentar de novo.');}
  function updateTraining(dt){training.cooldown=Math.max(0,training.cooldown-dt);training.marker+=training.direction*training.speed*dt;if(training.marker>1){training.marker=2-training.marker;training.direction=-1;}else if(training.marker<0){training.marker=-training.marker;training.direction=1;}}
  function submitTraining(){
    if(!training?.active||paused||dialog||training.cooldown>0)return false;
    const t=training;t.cooldown=.3;
    if(t.marker>=t.zoneStart&&t.marker<=t.zoneEnd){t.hits++;t.totalHits++;t.combo++;t.bestCombo=Math.max(t.bestCombo,t.combo);const center=(t.zoneStart+t.zoneEnd)/2,perfect=Math.abs(t.marker-center)<.045;t.score+=(perfect?150:100)+Math.min(5,t.combo)*20;t.feedback=perfect?'PERFEITO! REFLEXO DE CAMPEÃO!':'BOA! MANDOU BEM!';t.feedbackGood=true;beep(perfect?930:720,.12,'triangle');fx(player.x,player.y-50,'#c9e799',12,110);
      if(t.hits>=2){if(t.round>=3){finishTraining();return true;}t.round++;t.hits=0;t.cooldown=.65;t.feedback=`RODADA ${t.round}! A FAIXA MUDOU DE LUGAR.`;setTrainingZone();}
    }else{t.misses++;t.combo=0;t.feedback='QUASE! ESPERE O VERDE E TENTE DE NOVO.';t.feedbackGood=false;beep(170,.1,'triangle');}
    updateUI();return true;
  }
  function finishTraining(){const score=training.score,combo=training.bestCombo;training.active=false;q.trained=true;awardXP(380,'quest-caleb');emitGameEvent('player-trained');player.hp=bonus().maxHP;player.gas=bonus().maxGas;player.papers=30;releaseInputs();updateUI();save();say([{name:'Caleb',text:`TREINO PAGO! ${score} pontos, combo ${combo}! Esse braço saiu do tamanho de um lápis pra um bolo de três andares. Agora sim, shape de respeito!`},{name:'Da Roça',text:'Agora é papel mais forte, gás potente e reflexo afiado. Da academia direto pro bolo!'},{name:'Caleb',text:'A quadra tá liberada! Entre no carro do seu pai com V e escolha a rota. Contra Nikolas: dash no aviso laranja, ataque quando ficar vulnerável. Se apertar, chama o Reeis — suplemento de amizade!'}],()=>toast('Treino concluído! Seus ataques estão mais fortes. Vá à quadra.'));}
  function drawTraining(){
    const t=training;ctx.fillStyle='#132923c9';ctx.fillRect(0,0,W,H);ctx.fillStyle='#203b32';ctx.fillRect(85,70,790,350);ctx.strokeStyle='#d7bf7e';ctx.lineWidth=3;ctx.strokeRect(86.5,71.5,787,347);ctx.fillStyle='#314f3f';ctx.fillRect(102,87,756,6);
    text('ACADEMIA DO CALEB',480,117,13,'#dbcf9f');text('TREINO DE REFLEXO',480,154,30,'#fff0bd');text(`RODADA ${t.round} / 3`,235,199,17,'#e1d29d');text(`PONTOS ${t.score}`,480,199,17,'#d5e4ad');text(`COMBO ×${t.combo}`,725,199,17,'#d9b7df');
    for(let i=0;i<6;i++){ctx.fillStyle=i<t.totalHits?'#c9dd87':'#526b50';ctx.fillRect(410+i*26,225,17,8);}
    const bx=175,by=267,bw=610;ctx.fillStyle='#14291f';ctx.fillRect(bx-4,by-4,bw+8,43);ctx.fillStyle='#9a5a52';ctx.fillRect(bx,by,bw,35);ctx.fillStyle='#b1d979';ctx.fillRect(bx+t.zoneStart*bw,by,(t.zoneEnd-t.zoneStart)*bw,35);ctx.fillStyle='#d8eea0';ctx.fillRect(bx+t.zoneStart*bw,by,(t.zoneEnd-t.zoneStart)*bw,5);const mx=bx+t.marker*bw;ctx.fillStyle='#fff4d4';ctx.fillRect(mx-4,by-10,8,55);ctx.fillStyle='#26372d';ctx.fillRect(mx-1,by-4,2,43);
    text(t.feedback,480,337,15,t.feedbackGood?'#d8ecae':'#f0b6a0');text('E / ESPAÇO / ACERTAR — quando o marcador estiver no verde',480,371,13,'#e4d7b2');text('2 acertos por rodada. Erros não apagam seus acertos.',480,397,12,'#9fb6a3');
  }

  function paperAttack(){
    if(attackCooldown>0)return;if(player.papers<=0){toast('O papel recarrega sozinho. Use o combo de gás enquanto espera!');return;}
    attackCooldown=weapon===2?.31:.23;player.papers--;shake=Math.max(shake,1.2);player.attack=.24;player.attackType='paper';player.attackDuration=.24;
    const tier=q.miqueias?Math.max(1,bonus().projectileTier):0,element=tier>=2?'electric':tier===1?'fire':null,damage=Math.round(((q.trained?28:18)+(weapon===1?14:weapon===2?22:0))*bonus().damageMultiplier);
    const aimTarget=activeBoss?.conquista?.estrada?window.PerseguicaoMoto.alvo(activeBoss.conquista,player,activeBoss):activeBoss||(!room?minions.filter(m=>!m.dead&&Math.sign(m.x-player.x)===player.facing&&Math.abs(m.x-player.x)<650).sort((a,b)=>Math.abs(a.x-player.x)-Math.abs(b.x-player.x))[0]:null),aim=aimTarget&&Math.sign(aimTarget.x-player.x)===player.facing?clamp(Math.atan2((aimTarget.y-(aimTarget.alto?aimTarget.alto/2:aimTarget.conquista?.slug==='jorge'?window.JorgeDuelo.corpo(aimTarget.conquista).altura/2:aimTarget.type==='igor'?45*igorScale(aimTarget):aimTarget.type==='giant'?85:aimTarget.type==='nikolas'&&aimTarget.phase>=2?nikolasBounds(aimTarget).centerY:30))-(player.y-32),Math.abs(aimTarget.x-player.x)),-.85,.85):0;
    for(const spread of weapon===2?[-.11,0,.11]:[0])shots.push({x:player.x+player.facing*28,y:player.y-32,vx:player.facing*Math.cos(aim+spread)*(weapon?680:600),vy:Math.sin(aim+spread)*(weapon?680:600),life:1.5,type:element?'papaia':weapon===2?'case':weapon===1?'ruler':'paper',element,owner:'player',damage});
    window.CampaignVfx?.emit?.('cast',{x:player.x+player.facing*26,y:player.y-32,dir:player.facing,element});fx(player.x+player.facing*30,player.y-32,element==='electric'?'#a7e6f1':element?'#f7b76c':'#f8f3da',4,35);beep(element?570:760,.045);updateUI();
  }
  function fartAttack(){
    if(fartCooldown>0)return;const chain=q.almiro&&comboWindow>0;comboStep=chain?Math.min(3,comboStep+1):1;const cost=comboStep===3?20:comboStep===2?17:20;if(player.gas<cost){toast('Seu gás precisa recarregar. Espere no chão!');return;}
    player.gas-=cost;fartCooldown=q.almiro?(comboStep===3?1.5:.24):.9;comboWindow=q.almiro&&comboStep<3?.85:0;player.attack=.36;player.attackType='fart';player.attackDuration=.36;shake=comboStep===3?9:4;beep(80-comboStep*8,.2,'sawtooth',.045);
    const radius=comboStep===3?260:comboStep===2?205:155;window.CampaignVfx?.emit?.('gas',{x:player.x+player.facing*9,y:player.y-23,dir:player.facing,stage:comboStep,radius});window.SceneLife?.gas?.(player.x+player.facing*9,player.y-23,player.facing,comboStep);const damage=Math.round((q.trained?55:34)*(comboStep===3?1.8:comboStep===2?1.25:1)*bonus().damageMultiplier);fx(player.x+player.facing*38,player.y-22,comboStep===3?'#e0ef82':'#b9df55',comboStep===3?52:25,radius*.75);
    if(activeBoss?.conquista?.estrada)for(const m of activeBoss.conquista.estrada.motos){
      const r=m.rival;if(r.hp>0&&Math.abs(r.x-player.x)<radius&&Math.abs(r.y-player.y)<90)r.onDano(damage);
    }
    for(const e of enemies)if(e.conquista?.slug==='jorge'?window.JorgeDuelo.toca(e.conquista,player.x,player.y-25,radius,70):e.type==='igor'?igorContains(e,player.x,player.y-25,radius,70):e.type==='nikolas'&&e.phase>=2?nikolasContains(e,player.x,player.y-25,radius,70):(Math.abs(e.x-player.x)<radius||(e.conquista?.gemeoX!=null&&Math.abs(e.conquista.gemeoX-player.x)<radius))&&Math.abs(e.y-player.y)<180)damageEnemy(e,damage);
    for(const m of minions)if(!m.dead&&Math.abs(m.x-player.x)<radius&&Math.abs(m.y-player.y)<150)damageMinion(m,damage);
    shots=shots.filter(a=>!(a.owner==='enemy'&&Math.abs(a.x-player.x)<radius));floating(player.x,player.y-85,comboStep===3?'COMBO 3! PEIDÃO SUPREMO!':comboStep===2?'COMBO 2! PÓÓÓF!':'PÓÓÓF!','#d8f887');updateUI();
  }
  function summon(){
    if(!q.reeis){toast('Vença Freddy e Reeis na favela para conquistar a ajuda do parceiro.');return;}if(reeisCooldown>0||reeisPhase!=='idle'){toast(`Reeis recupera o fôlego em ${Math.ceil(reeisCooldown)}s.`);return;}
    reeisPhase='running';reeisPhaseTimer=.9;reeisX=player.facing>0?camera-110:camera+W+110;reeisY=FLOOR;reeisFacing=player.facing;reeisCooldown=29;reeisTimer=0;reeisFireTimer=0;player.inv=Math.max(player.inv,2.3);floating(player.x,player.y-125,'OHHHH REEEEIS!','#ffe1a0');toast('OHHHH REEEEIS! Lá vem o parceiro!');beep(130,.35,'sawtooth',.04);
  }
  function updateReeis(dt){
    if(reeisPhase==='idle')return;const target=player.x-player.facing*75;reeisFacing=player.facing;
    if(reeisPhase==='running'){reeisX+=(target-reeisX)*Math.min(1,dt*6);reeisPhaseTimer-=dt;if(reeisPhaseTimer<=0){reeisPhase='charging';reeisPhaseTimer=.9;reeisX=target;shake=5;beep(230,.2,'sawtooth');}}
    else if(reeisPhase==='charging'){player.inv=Math.max(player.inv,.2);reeisPhaseTimer-=dt;reeisX+=(target-reeisX)*Math.min(1,dt*8);if(Math.random()<.7)fx(reeisX+rand(-30,30),reeisY-45,'#f4d474',2,45);if(reeisPhaseTimer<=0){reeisPhase='burst';reeisPhaseTimer=.35;window.CampaignVfx?.emit?.('surge',{x:reeisX,y:reeisY-24,dir:reeisFacing});shake=14;fx(reeisX,reeisY-48,'#ffe09c',60,270);beep(90,.28,'sawtooth',.04);}}
    else if(reeisPhase==='burst'){player.inv=Math.max(player.inv,.15);reeisPhaseTimer-=dt;if(reeisPhaseTimer<=0){reeisPhase='active';reeisTimer=8;reeisFireTimer=.1;}}
    else if(reeisPhase==='active'){reeisTimer=Math.max(0,reeisTimer-dt);reeisX+=(target-reeisX)*Math.min(1,dt*9);reeisY=player.y;reeisFireTimer-=dt;if(reeisFireTimer<=0){reeisFireTimer=.42;const nearest=activeBoss&&Math.abs(activeBoss.x-player.x)<740?activeBoss:!arena?minions.filter(m=>!m.dead&&Math.abs(m.x-player.x)<700).sort((a,b)=>Math.abs(a.x-player.x)-Math.abs(b.x-player.x))[0]:null;if(nearest){const x=reeisX+reeisFacing*42,y=reeisY-58,a=Math.atan2(nearest.y-(nearest.type==='igor'?45*igorScale(nearest):nearest.type==='nikolas'&&nearest.phase>=2?nikolasBounds(nearest).centerY:nearest.kind!==undefined?22:32)-y,nearest.x-x);shots.push({x,y,vx:Math.cos(a)*760,vy:Math.sin(a)*760,life:1.1,type:'reeis',owner:'player',damage:14});beep(170,.035,'square',.012);}}if(reeisTimer<=0){reeisPhase='idle';fx(reeisX,reeisY-40,'#f5d58a',12,70);toast('Reeis voltou ao tamanho normal. O fôlego já está recarregando.');}}
  }
  function dash(){if(!started||paused||dialog||won||defeated||room||cutscene||activity||training?.active||routeTransition)return false;if(!q.mota&&!q.trained){toast('Vença o futebol do Mota para aprender o dash!');return false;}if(vehicle){toast('Estacione o carro com V para usar o dash.');return false;}if(dashCooldown>0)return false;dashDir=(keyHeld('left')||touch.left||joystick.x<-.15)?-1:(keyHeld('right')||touch.right||joystick.x>.15)?1:player.facing;window.CampaignVfx?.emit?.('dash',{x:player.x,y:player.y-3,dir:dashDir});dashTimer=.2;dashCooldown=bonus().dashCooldown;player.facing=dashDir;player.vx=dashDir*600;player.inv=Math.max(player.inv,.18);fx(player.x,player.y-22,'#c0dfb8',18,130);beep(310,.08,'sawtooth');return true;}
  function setJoystick(x,y){if(inputCaptured||window.Arena?.isOpen?.()||!started||paused||dialog||defeated||cutscene||activity||room&&room.phase!=='inside'||arena&&arena.phase!=='active'||training?.active||routeTransition){joystick={x:0,y:0};return;}joystick=window.ControlSettings?.transformJoystick(x,y)||{x:clamp(Number(x)||0,-1,1),y:clamp(Number(y)||0,-1,1)};}
  function toggleVehicle(){if(ollyanEncounter)return false;if(scene===11&&!vehicle&&player.x>(window.BaileGalpao?.PORTA??760)-70){toast('Dentro do galpão não dá pra ligar o carro. Volte até a porta.');return;}if(room||cutscene||arena){toast('Saia da sala ou da arena para entrar no carro.');return;}if(!q.lucas){toast('Fale com Lucas para recuperar as chaves do carro a gás do seu pai.');return;}if(activeBoss){toast('O chefe não deixa você entrar no carro! Vença ou recue primeiro.');return;}vehicle=!vehicle;releaseInputs();player.vy=0;toast(vehicle?'Carro a gás do seu pai ligado! Escolha uma rota ou dirija com o joystick.':'Carro a gás estacionado.');beep(vehicle?160:90,.2,'sawtooth');if(vehicle)requestRoutePicker('entered-car');}
  function damageEnemy(e,n,element){
    if(e.hp<=0||e.state==='underground'||e.conquista?.estado==='phaseChange'||e.damageLock>0||dialog||won||defeated||room||cutscene||arena&&arena.phase!=='active')return;if(!activeBoss&&Math.abs(player.x-e.x)>390)return;if(!activeBoss&&!engageBoss(e))return;if(activeBoss!==e)return;
    e.damageLock=.14;const exposed=e.state==='recover';n=Math.max(1,Math.round(n*(exposed?(e.type==='marco'&&e.phase>1?.9:1):bossProfile(e).armor)));e.hp-=n;window.SceneLife?.impact?.(e.x-player.facing*14,e.y-(e.type==='giant'?80:40),element==='electric'?'#a9e7f4':element==='fire'?'#f4ad60':'#ffd27a',n,-player.facing);shake=Math.max(shake,Math.min(4,1+n/14));epicFreeze(n>=18?.085:exposed?.06:.04);e.hit=.15;window.CampaignVfx?.emit?.('hit',{x:e.x,y:e.y-(e.type==='giant'?80:e.type==='igor'?45*igorScale(e):e.type==='nikolas'&&e.phase>=2?nikolasBounds(e).centerY:32),dir:player.facing,element,damage:n,kind:e.type});if(element==='fire')e.burn=3;if(element==='electric'){if(exposed&&e.conquista)e.conquista.dur+=.08;e.stateTimer+=exposed?.08:0;fx(e.x,e.y-55,'#a8e9ff',12,100);}fx(e.x,e.y-32,e.type==='nikolas'?'#a6d05d':'#e9ae68',8,90);floating(e.x,e.y-85,'−'+n);beep(220,.06);
    if(e.hp<=0&&e.type!=='giant'&&(e.phase||1)<(e.phaseCount||3)){e.hp=0;beginBossPhase(e,(e.phase||1)+1);updateUI();return;}
    if(e.hp<=0&&sandbox){
      e.hp=0;
      if(e.conquista){
        e.conquista.objetos=[];e.conquista.marcas=[];e.conquista.estado='fim';
        if(e.conquista.slug==='jorge')epicPlate('JORGE CAIU…','E AGORA, DA ROÇA?','#e0c4fb',.85);
      }
      finishSandbox('won');return;
    }
    if(e.hp<=0){e.hp=0;window.FxPixel?.derrota?.(e);shake=12;epicFreeze(.3);epic.flash=.75;epic.flashColor='#fff6d8';epicRing(e.x,e.y-60,'#ffe08b',1.6);epicRing(e.x,e.y-60,'#ff9b6a',1.1);epicPlate('DERROTADO!',(nomeBoss(e.type)||'').toUpperCase(),'#ffd25a',2.2);killCount++;const type=e.type;leaveArena(true);activeBoss=null;hazards=[];shots=shots.filter(a=>a.owner!=='enemy');
      awardXP(type==='nikolas'?900:type==='giant'?750:type==='nicolas'?700:type==='reeisBoss'?600:type==='menezes'?650:type==='freddy'?400:type==='dede'?320:type==='arthur'?450:type==='igor'?360:type==='kaique'?420:480,'boss-'+type);
      if(type==='arthur'){q.arthur=true;startCutscene('arthur_revenge',()=>{toast('Paz no pátio! Ravile levantou e Arthur aprendeu a respeitar o cabelo dos outros.');save();updateUI();});}
      else if(type==='igor'||type==='kaique'){q[type]=true;q[type+'Sneak']=true;say(type==='igor'?[{name:'Igor · monitor',text:'Oxe, véi... tu passou mesmo! Achou um pão de queijo, fortalece o pai aqui, viu?'},{name:'Da Roça',text:'Tua barriga fez mais chamada que o professor, pô! Bora que meu bolo não se acha sozinho.'}]:[{name:'Kaique · monitor',text:'Vai, se pique logo, véi! Hoje tu passou... mas se eu achar outra bolinha, já sabe, né?'},{name:'Da Roça',text:'Qual foi, Kaique? Era só um trabalho de física voando, pô!'}]);}
      else if(type==='dede'){q.dede=true;startCutscene('dede_defeat',()=>{toast('A fumaça baixou! Dedé virou resenha; Freddy continua no fim do caminho.');save();updateUI();});}
      else if(type==='nicolas'){q.nicolas=true;startCutscene('nicolas_reveal',()=>{toast('A aura era imaginação! Nicolas voltou à Praça Camacan, pronto para mais uma resenha.');save();updateUI();});}
      else if(type==='freddy'){q.freddy=true;startCutscene('freddy_defeat',()=>{toast('Freddy liberou a passagem. Continue à direita para enfrentar Reeis!');save();updateUI();});}
      else if(type==='marco'){q.marco=true;items.clip+=3;toast('Marco derrotado! O portal para o Caderno do Caos foi aberto.');}
      else if(type==='giant'){q.giant=true;toast('O rabisco gigante caiu! Volte ao colégio para enfrentar Menezes.');}
      else if(type==='reeisBoss'){q.reeis=true;startCutscene('reeis_recruit',()=>{reeisCooldown=0;toast('Reeis virou aliado! R chama a transformação dourada. Volte à escola para Marco.');save();});}
      else if(type==='menezes'){q.menezes=true;say([{name:'Menezes · Rato',text:'Da Roça pegou a— opa! Nem minhas paredes de palavras seguraram você!'},{name:'Da Roça',text:'Quem pegou ar agora foi seu quadro. Cadê o bolo?'},{name:'Menezes · Rato',text:'Nikolas está na quadra... com o bolo e aquele nariz de batata. Treina com Caleb antes!'}],()=>toast('Academia liberada! Próxima parada: treino do Caleb.'));}
      else if(type==='nikolas')win();save();updateUI();
    }
  }
  function hurt(n,from){if(player.inv>0||won||defeated||dialog||paused||routeTransition)return;if(window.C2Luta?.skin)n*=window.C2Luta.skin.dano||1;n=window.Difficulty?.scaleIncomingDamage?.(n,activeBoss?.difficultyMode)||n;player.hp=Math.max(0,player.hp-n);window.CampaignVfx?.emit?.('enemyHit',{x:player.x,y:player.y-30,dir:player.x<from?-1:1,damage:n});player.inv=.65;player.vy=-135;player.x=clamp(player.x+(player.x<from?-30:30),30,WORLD-30);hitFlash=.18;shake=7;fx(player.x,player.y-25,'#e98866',12,100);beep(100,.12,'sawtooth');if(player.hp<=0)defeat();updateUI();}
  function settleFinalWorld(){
    activeBoss=null;arena=null;room=null;routeTransition=null;shots=[];hazards=[];minions=minions.filter(m=>!m.summoned);reeisPhase='idle';reeisTimer=0;releaseInputs();
    resetWorldSize();player.x=clamp(player.x,30,WORLD-30);player.y=FLOOR;player.vx=0;player.vy=0;player.ground=true;
    player.hp=bonus().maxHP;player.gas=bonus().maxGas;player.papers=30;lastSafeX=player.x;camera=clamp(player.x-W*.36,0,WORLD-W);
  }
  function finishJorgeEpilogue(){
    q.jorgeSeen=true;q.jorgeStarted=false;chapterEnded=true;won=true;playing=false;paused=false;settleFinalWorld();
    show('victoryScreen',false);show('pauseScreen',false);updateUI();save();emitGameEvent('chapter-ended',{chapter:1,caller:'JORGE'});
  }
  function beginJorgeEpilogue(){
    q.jorgeStarted=true;chapterEnded=false;won=true;playing=true;paused=false;settleFinalWorld();show('chapterEndScreen',false);show('pauseScreen',false);save();
    return startCutscene('jorge_epilogue',finishJorgeEpilogue);
  }
  function continueExploring(){
    if(!started||!chapterEnded)return false;
    chapterEnded=false;won=false;playing=true;paused=false;settleFinalWorld();show('chapterEndScreen',false);updateUI();save();canvas.focus();return true;
  }
  function replayEpilogue(){
    if(!started||!q.nikolas||defeated||activeBoss||arena||room||routeTransition||dialog||training?.active||activity||cutscene||ollyanEncounter)return false;
    return beginJorgeEpilogue();
  }
  function finishCelebration(){
    q.acai=true;q.celebrationSeen=true;settleFinalWorld();show('victoryScreen',false);save();emitGameEvent('celebration-complete',{acai:true});
    beginPostCelebration();
  }
  function beginPostCelebration(){
    if(window.CampaignRun?.getResult?.()?.mode==='easy'&&!q.easyEndingSeen){won=true;playing=true;paused=false;return startCutscene('easy_finish',()=>{q.easyEndingSeen=true;save();beginJorgeEpilogue();});}
    return beginJorgeEpilogue();
  }
  function beginCelebration(){
    if(!q.acai){q.acai=true;awardXP(300,'reward-quarta-acai');}
    won=true;save();return startCutscene('celebration',finishCelebration);
  }
  function win(){
    q.nikolas=true;won=true;vehicle=false;window.CampaignRun?.finish?.();save();
    say([{name:'Nikolas Arroganti',text:'Meu catarro... minha força... e eu nem provei a cobertura!'},
      {name:'Nikolas Arroganti',text:'Anao da roça poudi pra que jogar a bola na mavie po seu arroganthi'},
      {name:'Da Roça',text:'O bolo é do Lucas e da turma. Aprende a pedir um pedaço, Nikolas!'},
      {name:'Reeis',text:'OHHHH REEEEIS! Missão cumprida, parceiro!'},
      {name:'Lucas · o Sapo',text:'Tem bolo pra todo mundo. Até pro Nikolas, se ele lavar as mãos primeiro.'}],
      ()=>startCutscene('outro',beginCelebration));
  }
  function epicRing(x,y,color,size=1){if(epic.rings.length>8)epic.rings.shift();epic.rings.push({x,y,color,size,age:0,life:.62*size});}
  function epicFreeze(seconds){if(!calmMotion)hitStop=Math.max(hitStop,Math.min(.35,seconds));}
  function epicPlate(title,sub,color,life=1.9){epic.plate={title,sub,color,age:0,life};}
  function updateEpic(dt){
    if(epic.intro){epic.intro.age+=dt;if(!epic.intro.slammed&&epic.intro.age>=.36){epic.intro.slammed=true;shake=Math.max(shake,calmMotion?2:7);}if(epic.intro.age>2.7)epic.intro=null;}
    for(const r of epic.rings)r.age+=dt;epic.rings=epic.rings.filter(r=>r.age<r.life);
    if(epic.plate){epic.plate.age+=dt;if(epic.plate.age>epic.plate.life)epic.plate=null;}
    epic.flash=Math.max(0,epic.flash-dt*2.2);
  }
  function drawEpicWorld(){
    const b=activeBoss;
    if(b&&!b.conquista&&b.hp>0&&(b.phase||1)>=(b.phaseCount||1)&&b.max&&b.hp/b.max<.35){
      const pulse=.5+.5*Math.sin(time*9),h=b.type==='giant'?190:b.type==='nikolas'&&b.phase>=4?210:110,g=ctx.createRadialGradient(b.x,b.y-h*.45,8,b.x,b.y-h*.45,h*.85);
      g.addColorStop(0,`rgba(255,96,64,${.2+.14*pulse})`);g.addColorStop(1,'rgba(255,60,40,0)');
      ctx.save();ctx.globalCompositeOperation='lighter';ctx.fillStyle=g;ctx.fillRect(b.x-h,b.y-h*1.3,h*2,h*1.5);
      ctx.fillStyle=`rgba(255,180,120,${.5+.4*pulse})`;for(let i=0;i<5;i++){const a=time*2.2+i*1.26,r=h*.42+Math.sin(time*4+i)*6;ctx.fillRect(Math.round(b.x+Math.cos(a)*r*.7),Math.round(b.y-h*.45+Math.sin(a)*r*.5-((time*60+i*23)%40)),3,3);}
      ctx.restore();
    }
    for(const r of epic.rings){const k=r.age/r.life,ease=1-Math.pow(1-k,2.2);ctx.save();ctx.globalAlpha=1-k*k;
      for(let i=0;i<24;i++){const a=i/24*Math.PI*2+(i%3)*.11,sp=(140+((i*37)%60))*r.size,d=ease*sp,z=Math.max(2,Math.round((i%3===0?7:5)*(1-k)*r.size));
        const px=Math.round(r.x+Math.cos(a)*d),py=Math.round(r.y+Math.sin(a)*d*.75+k*k*40);
        ctx.fillStyle=i%2?r.color:'#fff6d8';ctx.fillRect(px-z/2|0,py-z/2|0,z,z);
        ctx.globalAlpha=(1-k)*.45;ctx.fillRect(Math.round(r.x+Math.cos(a)*d*.72)-1,Math.round(r.y+Math.sin(a)*d*.54)-1,2,2);ctx.globalAlpha=1-k*k;}
      if(k<.25){const f=Math.round(18*(1-k/.25)*r.size);ctx.fillStyle='#fff6d8';ctx.fillRect(r.x-f,r.y-f/3|0,f*2,f*2/3|0);ctx.fillRect(r.x-f/3|0,r.y-f,f*2/3|0,f*2);}
      ctx.restore();}
  }
  function drawEpicScreen(){
    const I=epic.intro;
    if(I){const a=I.age,inK=clamp(a/.32,0,1),outK=clamp((a-2.25)/.4,0,1),bar=Math.round(H*.085*(inK*(1-outK)));
      if(bar>0){ctx.fillStyle='#0b1210';ctx.fillRect(0,0,W,bar);ctx.fillRect(0,H-bar,W,bar);}
      if(a>.18&&outK<1){const slide=clamp((a-.18)/.2,0,1),ease=1-Math.pow(1-slide,3),x=-420+ease*(W/2+420),y=H*.27,w=Math.min(W-40,Math.max(320,I.name.length*14+80));
        ctx.save();ctx.globalAlpha=1-outK;ctx.translate(Math.round(x),Math.round(y));
        ctx.fillStyle='#14211d';ctx.fillRect(-w/2-6,-34,w+12,72);ctx.fillStyle=I.color;ctx.fillRect(-w/2,-28,w,60);ctx.fillStyle='#1c2e28';ctx.fillRect(-w/2+5,-23,w-10,50);
        ctx.fillStyle=I.color;for(let i=0;i<6;i++)ctx.fillRect(-w/2+8+i*12,-31,6,3);
        text('CHEFE · NÍVEL '+I.level,0,-9,12,'#ffd98a');text(I.name.toUpperCase(),0,13,Math.max(12,Math.min(20,Math.floor((w-30)/Math.max(8,I.name.length)*1.55))),'#fff3d6');
        if(a>=.36&&a<.62){ctx.globalAlpha=(.62-a)/.26*.6;ctx.fillStyle='#fff6d8';ctx.fillRect(-w/2,-28,w,60);}
        ctx.restore();}
    }
    const P=epic.plate;
    if(P){const k=P.age/P.life,pop=P.age<.18?.6+P.age/.18*.5:P.age<.3?1.1-(P.age-.18)/.12*.1:1,alpha=k>.8?(1-k)/.2:1;
      ctx.save();ctx.globalAlpha=clamp(alpha,0,1);ctx.translate(W/2,H*.36);ctx.scale(pop,pop);
      ctx.font='bold 34px monospace';ctx.textAlign='center';ctx.textBaseline='middle';ctx.lineWidth=7;ctx.lineJoin='round';ctx.strokeStyle='#14211d';ctx.strokeText(P.title,0,0);ctx.fillStyle=P.color;ctx.fillText(P.title,0,0);
      if(P.sub){ctx.font='bold 14px monospace';ctx.lineWidth=4;ctx.strokeText(P.sub,0,30);ctx.fillStyle='#fff3d6';ctx.fillText(P.sub,0,30);}
      ctx.restore();}
    if(epic.flash>0){ctx.save();ctx.globalAlpha=Math.min(.55,epic.flash);ctx.fillStyle=epic.flashColor;ctx.fillRect(0,0,W,H);ctx.restore();}
  }

  // Detailed floating plank: same top line and width as the collider, only richer paint.
  function drawPlank(p){
    if(scene>=12&&window.CampanhaCenarios?.plataforma?.(ctx,scene,p,time))return; // Campanha 2: plataforma de cada cenário
    const x=Math.round(p[0]),y=Math.round(p[1]),w=Math.round(p[2]),metal=scene===2,ink=scene===6,grassy=scene===0||scene===7||scene===3;
    const dark=metal?'#3e4a45':ink?'#3d2c52':'#4f3624',mid=metal?'#63736a':ink?'#7d6596':'#8d6a45',lit=metal?'#8fa096':ink?'#b59bd0':'#b88d5c';
    ctx.fillStyle='rgba(20,28,24,.22)';ctx.fillRect(x+10,y+15,w-20,6);
    for(const sx of [x+14,x+w-20]){ctx.fillStyle=dark;ctx.fillRect(sx,y+12,6,10);ctx.fillStyle=mid;ctx.fillRect(sx+1,y+12,2,9);}
    ctx.fillStyle=dark;ctx.fillRect(x-1,y,w+2,14);ctx.fillStyle=mid;ctx.fillRect(x,y+1,w,11);
    for(let xx=x;xx<x+w;xx+=Math.max(18,Math.round(w/Math.max(2,Math.round(w/34))))){ctx.fillStyle=dark;ctx.fillRect(xx,y+1,1,11);ctx.fillStyle=lit;ctx.fillRect(xx+2,y+3,Math.min(10,x+w-xx-3),1);ctx.fillStyle=dark;ctx.fillRect(xx+5,y+7,2,2);}
    ctx.fillStyle=lit;ctx.fillRect(x,y+1,w,2);
    if(grassy){ctx.fillStyle='#4f8f3c';ctx.fillRect(x-1,y-1,w+2,3);ctx.fillStyle='#8fc451';for(let xx=x+2;xx<x+w-2;xx+=5){const h=1+((xx*7)%3),sw=Math.round(Math.sin(time*1.6+xx*.05));ctx.fillRect(xx+sw,y-1-h,2,h);}ctx.fillStyle='#3f7a34';for(let xx=x+6;xx<x+w-6;xx+=23)ctx.fillRect(xx,y+12,2,3+((xx*13)%5));}
    else{ctx.fillStyle=metal?'#b8c4bc':'#d9c08f';ctx.fillRect(x,y,w,1);}
  }

  // ---------- Pixel-art boss area attacks (visual only: hitboxes/timers live in updateHazards) ----------
  const HAZ={pink:['#7a2c4c','#d4558a','#f5a3c4','#fff0f5'],slime:['#3f5a1e','#86b23a','#c8e276','#f6ffd0'],ink:['#3a2054','#7d4fb0','#c79ae5','#f6e8ff'],astral:['#6a5a1c','#e0b83c','#ffe39a','#fffbe6'],smoke:['#4c5650','#8d9a91','#c7d2c9','#f2f5ef'],brasa:['#3a1608','#a8401a','#ff8a30','#ffe08a']};
  function hazPal(h){return h.brasa?HAZ.brasa:h.ink||h.type==='ink'?HAZ.ink:h.type==='smoke'||h.smoke?HAZ.smoke:h.type==='astral'||h.astral?HAZ.astral:h.type==='slime'?HAZ.slime:HAZ.pink;}
  const hsh=n=>{const x=Math.sin(n*12.9898+78.233)*43758.5453;return x-Math.floor(x);};
  function px(x,y,w,h,c){ctx.fillStyle=c;ctx.fillRect(Math.round(x),Math.round(y),Math.round(w),Math.round(h));}
  function spike(x,base,h,pal,seed){const w=6+(seed%2)*2;for(let yy=0;yy<h;yy+=4){const k=1-yy/h,ww=Math.max(2,Math.round(w*k));px(x-ww/2,base-yy-4,ww,4,yy<4?pal[0]:k<.35?pal[3]:k<.7?pal[2]:pal[1]);}px(x-1,base-h-2,2,2,pal[3]);}
  function crack(x0,x1,pal,a){ctx.save();ctx.globalAlpha=a;let y=FLOOR-3;for(let x=x0;x<x1;x+=4){y=FLOOR-3+Math.round(Math.sin(x*.37)*1.4);px(x,y,4,2,pal[2]);if(hsh(x)>.8)px(x+1,y-2,2,2,pal[3]);}ctx.restore();}
  function drawHazardPixel(h){
    const pal=hazPal(h),t=time,lite=!!window.Graphics?.isLite?.();
    if(h.delay>0){ // warning: pulsing ground cracks + rising embers
      const blink=.45+.35*Math.abs(Math.sin(t*14));
      if(h.type==='ring'){crack(h.x-46,h.x+46,pal,blink);}
      else crack(h.x-h.r,h.x+h.r,pal,blink);
      const span=h.type==='ring'?46:h.r;ctx.save();for(let i=0;i<(lite?4:10);i++){const k=(t*1.6+hsh(i+h.x))%1,ex=h.x+(hsh(i*7+h.x)-.5)*span*2;ctx.globalAlpha=(1-k)*blink;px(ex,FLOOR-6-k*(h.height?Math.min(160,h.height*.6):46),3,3,i%2?pal[2]:pal[3]);}ctx.restore();
      if(h.height){ctx.save();ctx.globalAlpha=.16+.1*Math.sin(t*20);for(let y=FLOOR-h.height;y<FLOOR;y+=8)px(h.x-h.r,y,h.r*2,2,pal[2]);ctx.restore();}
      if(h.cinza){ctx.save();const n=lite?8:18,dens=clamp(1.4-h.delay,0.35,1);for(let i=0;i<n;i++){const k=(t*.8+hsh(i*5+h.x))%1,fx_=h.x+(hsh(i*3+h.x)-.5)*h.r*2+Math.sin(t*3+i)*7,fy=30+k*(FLOOR-40);ctx.globalAlpha=dens*(i%4?.75:1);if(i%4)px(fx_,fy,3,2,i%3?'#8a8680':'#b8b4ac');else{px(fx_,fy,2,2,'#ff8a30');px(fx_,fy-1,1,1,'#ffe08a');}}ctx.restore();}
      return;
    }
    const life=Math.max(0,h.life||0);
    if(h.type==='ring'){ // shockwave crests running out both ways, leaving a scorched track
      for(const dir of [-1,1]){const cx=h.x+dir*h.r;
        ctx.save();ctx.globalAlpha=.55;for(let x=h.x;dir>0?x<cx-8:x>cx+8;x+=dir*8){const fade=Math.abs(x-h.x)/Math.max(1,h.r);px(x,FLOOR-3,6,2,pal[1]);if(hsh(x)>.6)px(x+2,FLOOR-5-hsh(x+3)*3,2,2,fade>.6?pal[2]:pal[0]);}ctx.restore();
        if(h.smoke){for(let i=0;i<6;i++){const sx=cx-dir*i*9,z=Math.max(6,24-i*3)*(.9+.1*Math.sin(t*20+i)),yy=FLOOR-z-((i*7)%5);ctx.save();ctx.globalAlpha=.88-i*.11;px(sx-z/2,yy,z,z,pal[1]);px(sx-z/2+2,yy+2,z-5,z-5,pal[2]);px(sx-z/2+3,yy+3,z/3,z/3,pal[3]);ctx.restore();}}
        else for(let i=0;i<5;i++){const sx=cx-dir*i*7,hgt=Math.max(8,(52-i*9)*(.85+.15*Math.sin(t*30+i)));spike(sx,FLOOR,hgt,pal,i);}
        if(!lite)for(let i=0;i<6;i++){const k=(t*3+i/6)%1;ctx.save();ctx.globalAlpha=1-k;px(cx+dir*(4+k*30)+(hsh(i)-.5)*10,FLOOR-10-k*48+k*k*30,i%2?3:2,i%2?3:2,i%3?pal[2]:pal[3]);ctx.restore();}
      }
      return;
    }
    if(h.brasa){ctx.save();const n=Math.max(4,Math.round(h.r/5)),fade=clamp(life*2,0,1);for(let i=0;i<n;i++){const ex=h.x-h.r+4+i*(h.r*2-8)/Math.max(1,n-1),f=Math.sin(t*22+i*2.3);ctx.globalAlpha=fade;px(ex-2,FLOOR-5,5,3,f>.3?pal[2]:pal[1]);if(f>.5)px(ex-1,FLOOR-6,2,1,pal[3]);if(i%2===0){const fh=(6+hsh(i+h.x)*8)*(.7+.3*Math.sin(t*28+i));px(ex-1,FLOOR-5-fh,3,fh,pal[2]);px(ex,FLOOR-5-fh,1,fh*.5,pal[3]);}}ctx.restore();}
    if(h.type==='smoke'){const sp=h.brasa?HAZ.smoke:pal,m=h.brasa?5:9;ctx.save();for(let i=0;i<m;i++){const bx=h.x+(i-(m-1)/2)*h.r/4.5,rise=(t*20+i*13)%40,z=(h.brasa?7:10)+((i*5)%3)*4;ctx.globalAlpha=(.55*(1-rise/40)+.15)*(h.brasa?.7:1);for(const [dx,dy,c] of [[0,0,sp[1]],[2,-2,sp[2]],[4,-4,sp[3]]])px(bx-z/2+dx,FLOOR-24-rise-z+dy,z-dx,z-dx,c);}ctx.restore();}
    if(h.height){ // energy pillar of blocks with a bright core and flickering edges
      const top=FLOOR-h.height,w=h.r*2;ctx.save();
      for(let y=top;y<FLOOR;y+=6){const flick=Math.round(Math.sin(t*40+y*.3)*2);ctx.globalAlpha=.55;px(h.x-h.r+flick,y,w-flick*2,6,pal[1]);ctx.globalAlpha=.85;px(h.x-h.r*.45,y,h.r*.9,6,pal[2]);px(h.x-h.r*.15,y,h.r*.3,6,pal[3]);}
      ctx.globalAlpha=.9;for(let i=0;i<(lite?3:8);i++){const k=(t*2.4+i/8)%1;px(h.x+(hsh(i+3)-.5)*w,FLOOR-k*h.height,3,6,pal[3]);}
      ctx.restore();crack(h.x-h.r-10,h.x+h.r+10,pal,.8);
    }else if(h.type!=='smoke'){ // ground eruption: a row of spikes over the whole area
      const n=Math.max(3,Math.round(h.r*2/12));for(let i=0;i<n;i++){const sx=h.x-h.r+6+i*(h.r*2-12)/Math.max(1,n-1),hgt=(18+hsh(i+h.x)*30)*(.8+.2*Math.sin(t*26+i));spike(sx,FLOOR,hgt,pal,i);}
      crack(h.x-h.r,h.x+h.r,pal,.9);
    }
    if(h.type==='astral'){ctx.save();for(let y=60;y<FLOOR;y+=6){const f=Math.round(Math.sin(t*50+y)*1.5);px(h.x-8+f,y,16-f*2,6,pal[2]);px(h.x-3,y,6,6,pal[3]);}ctx.restore();}
  }
  function drawPhaseFlames(e){
    const k=Math.max(0,Math.sin(clamp(e.stateTimer/(e.phaseDuration||1.05),0,1)*Math.PI)),pal=e.type==='nikolas'?HAZ.slime:e.type==='menezes'?HAZ.pink:HAZ.ink,spread=60+nikolasTransformProgress(e)*80;
    for(let i=0;i<14;i++){const side=i%2?1:-1,off=(14+Math.floor(i/2)*spread/7)*side,hgt=(30+hsh(i)*60)*k*(.8+.2*Math.sin(time*24+i));spike(e.x+off,FLOOR,hgt,pal,i);}
    ctx.save();for(let i=0;i<18;i++){const p=(time*1.4+i/18)%1;ctx.globalAlpha=k*(1-p);px(e.x+(hsh(i+9)-.5)*spread*2.2,FLOOR-10-p*170,i%3?3:4,i%3?3:4,i%2?pal[2]:pal[3]);}ctx.restore();
  }

  function epilogueCue(film){
    if(film?.kind!=='jorge_epilogue')return;
    const shot=window.Cinematics?.beat?.(film)?.id;
    // The visual phone vibration always plays; sound follows the player's mute choice.
    if(shot==='vibration'){beep(72,.24,'sawtooth',.025);beep(94,.15,'triangle',.014);}
    else if(shot==='caller'){beep(660,.24,'sine',.018);beep(440,.34,'sine',.014);}
    else if(shot==='recognition')beep(48,.55,'sine',.025);
    else if(shot==='falling')beep(110,.09,'triangle',.023);
  }
  function update(dt){
    time+=dt;transition=Math.max(0,transition-dt);toastTimer=Math.max(0,toastTimer-dt);if(!toastTimer){const e=$('toast');if(e){e.classList.remove('show');e.hidden=true;}}
    if(!started||paused||dialog||defeated){updateEffects(dt);return;}
    if(cutscene){const film=cutscene,before=film.index;if(window.GameMusic?.isCutsceneTimed)film.options.musicTimed=window.GameMusic.isCutsceneTimed(film.kind);film.audioElapsed=(film.audioElapsed||0)+dt;window.Cinematics.update(film,dt);if(film.done)finishCutscene();else if(film.index!==before){epilogueCue(film);updateUI();}return;}if(won){updateEffects(dt);return;}
    if(room&&room.phase!=='inside'){updateRoomTransition(dt);updateEffects(dt);return;}
    if(arena&&arena.phase!=='active'){updateArenaTransition(dt);updateEffects(dt);return;}
    if(routeTransition?.chegada){if(!window.ChegadaCarro?.atualizar?.(dt))routeTransition=null;updateEffects(dt);return;}
    if(routeTransition){routeTransition.t+=dt;if(routeTransition.t>=routeTransition.duration){const dest=routeTransition.to,de=routeTransition.from;if(routeTransition.estrada&&window.ChegadaCarro){window.ChegadaCarro.iniciar(dest);routeTransition={from:de,to:dest,t:0,duration:window.ChegadaCarro.duracao,chegada:true};arrive(dest);}else{routeTransition=null;arrive(dest);}}updateEffects(dt);return;}
    if(activity){
      window.Activities.update(activity,dt);
      if(activity.kind==='dinner'&&activity.phase==='breath')
        dinnerMeter.style.setProperty('--marker',(activity.marker*100).toFixed(2)+'%');
      if(activity.done)finishActivity();
      uiTimer+=dt;
      if(uiTimer>.1){uiTimer=0;updateUI();}
      return;
    }
    if(training?.active){updateTraining(dt);updateEffects(dt);uiTimer+=dt;if(uiTimer>.12){uiTimer=0;updateUI();}return;}
    if(!ollyanEncounter||ollyanEncounter.stage!=='intro')updateBivolt(dt);
    if(ollyanEncounter){updateOllyan(dt);return;}
    ollyanRetryGrace=Math.max(0,ollyanRetryGrace-dt);
    comboWindow=Math.max(0,comboWindow-dt);if(!comboWindow)comboStep=0;bossHintCooldown=Math.max(0,bossHintCooldown-dt);player.landTimer=Math.max(0,player.landTimer-dt);tauntCooldown=Math.max(0,tauntCooldown-dt);const wasDashing=dashTimer>0;dashTimer=Math.max(0,dashTimer-dt);if(wasDashing&&dashTimer===0)player.vx=clamp(player.vx,-bonus().moveSpeed,bonus().moveSpeed);dashCooldown=Math.max(0,dashCooldown-dt);routeEdgeCooldown=Math.max(0,routeEdgeCooldown-dt);player.inv=Math.max(0,player.inv-dt);player.attack=Math.max(0,player.attack-dt);attackCooldown=Math.max(0,attackCooldown-dt);fartCooldown=Math.max(0,fartCooldown-dt);reeisCooldown=Math.max(0,reeisCooldown-dt);
    movePlayer(dt);
    if(!room){if(keyHeld('paper'))paperAttack();if(keyHeld('fart'))fartAttack();}
    if(room){nearNPC=closestNPC()?.[0]||null;uiTimer+=dt;if(uiTimer>.12){uiTimer=0;updateUI();}updateEffects(dt);return;}
    ammoTimer+=dt;if(ammoTimer>1.1){ammoTimer=0;player.papers=Math.min(30,player.papers+1);}
    if(player.ground&&player.hp<bonus().maxHP&&!activeBoss&&!arena)player.hp=Math.min(bonus().maxHP,player.hp+dt*2.5);
    if(!terrenoConquista())camera=clamp(player.x-W*.36,0,WORLD-W);
    nearNPC=closestNPC()?.[0]||null;
    for(const p of pickups)if(!p.taken&&Math.hypot(player.x-p.x,player.y-23-p.y)<40){p.taken=true;if(p.type==='repair'){if(!q.carParts.includes(p.id))q.carParts.push(p.id);floating(p.x,p.y-25,'PEÇA '+q.carParts.length+'/3','#e7e7a8');awardXP(45,'part-'+p.id);toast('Peça do carro: '+q.carParts.length+'/3. Volte ao Lucas quando completar!');save();}else if(p.type==='notebook'){if(!q.notebooks.includes(p.id))q.notebooks.push(p.id);floating(p.x,p.y-25,'CADERNO '+q.notebooks.length+'/3','#a6dfee');awardXP(30,'notebook-'+p.id);save();}else if(p.type==='gas'){player.gas=Math.min(bonus().maxGas,player.gas+32);floating(p.x,p.y-18,'+GÁS','#c6ee85');}else if(itemNames[p.type]){items[p.type]++;collected.push(p.id);floating(p.x,p.y-18,'+1 '+itemNames[p.type].toUpperCase(),'#b9ddf4');save();}else{player.papers=Math.min(30,player.papers+8);floating(p.x,p.y-18,'+8 PAPÉIS');}beep(720,.08,'triangle');fx(p.x,p.y,'#f1d180',8,60);}
    const fardaPick=window.MissaoFarda?.coletar?.(q,player,scene);if(fardaPick){toast(fardaPick.message);floating(player.x,player.y-85,'FARDA '+fardaPick.count+'/3','#a8d4ff');beep(830,.08,'triangle');save();updateUI();}
    const bivoltPick=window.BivoltQuest?.collect?.(q,player,scene);if(bivoltPick?.collected){toast(bivoltPick.message);floating(player.x,player.y-85,'BIVOLT '+bivoltPick.count+'/3','#f7d984');beep(830,.08,'triangle');save();updateUI();}
    if(scene===11){window.BaileGalpao?.sincronizar?.({telhado:!!(q.ollyan||q.ollyanTeto)});const porta=(window.BaileGalpao?.PORTA??760)-70;if(vehicle&&!ollyanEncounter&&player.x>porta){player.x=porta;player.vx=0;vehicle=false;toast('O carro a gás fica na porta do galpão. No baile, só a pé!');}}
    if(scene===11&&!q.ollyan&&ollyanRetryGrace<=0&&Math.abs(player.x-(window.BaileWorld?.getNPC?.().x||3260))<145&&q.lucas){beginOllyanEncounter();return;}
    updateMinions(dt);updateSarueTraps();updateEnemies(dt);updateShots(dt);updateHazards(dt);updateReeis(dt);updateEffects(dt);if(vehicle&&routeEdgeCooldown<=0&&(player.x<38||player.x>WORLD-38)){routeEdgeCooldown=2;requestRoutePicker('world-edge');}
    saveTimer+=dt;if(saveTimer>8){saveTimer=0;save();}uiTimer+=dt;if(uiTimer>.12){uiTimer=0;updateUI();}
  }
  function updateSarueTraps(){
    if(scene!==1||marcoTrapTriggered||!activeBoss||activeBoss.type!=='marco'||arena?.phase!=='active')return;
    const traps=window.WorldData?.sarueTraps||[{scene:1,x:3420,width:70}];const trap=traps.find(t=>t.scene===scene&&Math.abs(player.x-t.x)<(t.width||70)/2&&player.y>FLOOR-18);
    if(!trap)return;marcoTrapTriggered=true;const e=activeBoss;e.rage=true;e.angry=99999;e.hp=Math.min(e.max,e.hp+40);e.state='idle';e.pattern=0;releaseInputs();fx(e.x,e.y-40,'#ff4d5d',60,210);shake=12;
    startCutscene('marco_rage',()=>{if(activeBoss===e)beginBossWindup(e);toast('FÚRIA VERMELHA! Marco agora desenha brainrots e SIX SEVEN!');});
  }
  function isSchoolMonitor(e){return e.type==='igor'||e.type==='kaique';}
  function igorScale(e){
    if(e.type!=='igor'||arena?.type!=='igor'||activeBoss!==e&&arena.phase!=='exiting')return 1;
    const p=arena.phase==='entering'?0:arena.phase==='exiting'?clamp(arena.blend,0,1):e.state==='monitorTransform'?clamp(e.monitorTransform||0,0,1):1;
    return 1+2*p*p*(3-2*p);
  }
  function igorContains(e,x,y,padX=0,padY=0){
    const scale=igorScale(e),rolling=e.state==='bellyRolling',rx=(rolling?36:33)*scale+padX,ry=(rolling?36:45)*scale+padY,cy=e.y-(rolling?36:45)*scale;
    return ((x-e.x)/rx)**2+((y-cy)/ry)**2<1;
  }
  function nikolasBounds(e){return window.Art?.nikolasBounds?.(e.phase||1)||(e.phase===4?{halfWidth:185,height:340,centerY:170}:e.phase>=2?{halfWidth:55,height:140,centerY:70}:{halfWidth:35,height:90,centerY:30});}
  function nikolasContains(e,x,y,padX=0,padY=0){const b=nikolasBounds(e),rx=b.halfWidth+padX,ry=b.height/2+padY;return((x-e.x)/rx)**2+((y-(e.y-b.centerY))/ry)**2<1;}
  function nikolasTransformProgress(e){return e.state==='phaseChange'?clamp(1-e.stateTimer/(e.phaseDuration||1.05),0,1):1;}
  function bossCaptionY(e){return Math.max(e.type==='igor'?145:83,e.y-(e.type==='igor'?90*igorScale(e)+30:e.type==='giant'?240:e.type==='nikolas'&&e.phase>=2?nikolasBounds(e).height+20:157));}
  function monitorSees(e){
    const distance=(player.x-e.x)*e.monitorDir;if(distance<-15||distance>300||player.y<FLOOR-92)return false;
    const eye=FLOOR-(e.type==='igor'?74:92),head=player.y-40,center=eye+(FLOOR-40-eye)*distance/300;if(Math.abs(head-center)>18+distance*.15)return false;
    const a=Math.min(e.x,player.x),b=Math.max(e.x,player.x);
    return !(window.WorldData?.schoolCovers||[]).some(c=>c.x+c.width/2>a&&c.x-c.width/2<b);
  }
  function confrontMonitor(e,iraci=false){
    if(!e||e.hp<=0||dialog||activeBoss||arena||room||cutscene||paused||defeated)return false;
    if(iraci){e.rage=true;e.iraciTriggered=true;}
    if(!engageBoss(e))return false;e.monitorSuspicion=0;
    say(e.type==='igor'?[{name:'Igor · monitor',text:'Qual foi, Da Roça? Tem um lanche aí, véi? Um salgado, um pão... fortalece o monitor, pô!'},{name:'Da Roça',text:'Tenho nada, pô! Nikolas levou meu bolo. Só sobrou a embalagem e o gás, tá ligado?'},{name:'Igor · monitor',text:'Sem lanche?! Tá tirando com minha cara, é? Oxe! Então segura a barriga, meu parceiro!'}]:iraci?[{name:'Kaique · monitor',text:'IRACI?! Qual foi, véi?! Quem botou o nome de minha mãe nesse chão? Se passou, hein!'},{name:'Da Roça',text:'Eu só pisei sem querer, pô! O chão é que tava de resenha com tu!'},{name:'Kaique · monitor',text:'Ah, é? Agora tu vai ver a resenha! Bora, Da Roça, desvia disso aqui, quero ver!'}]:[{name:'Kaique · monitor',text:'Ô, Da Roça! Bora pra sala, véi! E deixa essas bolinhas aqui. Tu acha que eu não tô vendo, é?'},{name:'Da Roça',text:'Calma, meu parceiro! Isso aqui é pesquisa de trajetória... na prática, tá ligado?'},{name:'Kaique · monitor',text:'Pesquisa nada, véi! Tu tá é de resenha! Bora ver se tu é ligeiro mesmo. Na recarga tu vem, viu?'}]);return true;
  }
  function updateSchoolMonitors(dt){
    if(scene===1&&activeBoss?.type==='kaique'&&arena?.phase==='active'&&!activeBoss.iraciTriggered&&player.y>FLOOR-18&&(window.WorldData?.iraciTraps||[]).some(t=>Math.abs(player.x-t.x)<t.width/2)){
      const e=activeBoss;e.iraciTriggered=true;e.rage=true;e.state='monitorTransform';e.stateTimer=1.25;e.monitorTransform=0;shots=shots.filter(s=>s.owner!=='enemy');hazards=[];releaseInputs();player.inv=Math.max(player.inv,1.6);floating(e.x,e.y-155,'IRACI?! FISCALIZAÇÃO MÁXIMA!','#ffb2ab');fx(e.x,e.y-45,'#f3767d',36,160);shake=8;
    }
    if(scene!==1||room||arena||activeBoss||dialog||cutscene||vehicle||paused||defeated)return;
    for(const e of enemies){if(!isSchoolMonitor(e)||e.hp<=0)continue;
      e.monitorCooldown=Math.max(0,e.monitorCooldown-dt);e.patrolTime=(e.patrolTime||0)+dt;
      e.x+=e.monitorDir*33*dt;if(e.x>e.homeX+88){e.x=e.homeX+88;e.monitorDir=-1;}else if(e.x<e.homeX-88){e.x=e.homeX-88;e.monitorDir=1;}
      if(!q[e.type+'Sneak']&&!q[e.type]&&player.x>e.homeX+390){q[e.type+'Sneak']=true;awardXP(120,'school-stealth-'+e.type);toast('Passou sem ser visto por '+(e.type==='igor'?'Igor':'Kaique')+'! +120 XP de furtividade.');save();}
      const seen=e.monitorCooldown<=0&&monitorSees(e);e.monitorSuspicion=clamp((e.monitorSuspicion||0)+(seen?dt: -dt*2.4),0,1.2);
      if(seen&&e.monitorSuspicion>.25&&!e.monitorHint){e.monitorHint=true;toast('O monitor está olhando! Saia do cone, suba nas passarelas ou se esconda atrás dos armários.');}
      if(e.monitorSuspicion===0)e.monitorHint=false;
      if(e.monitorSuspicion>=1.2){confrontMonitor(e,false);return;}
    }
    const kaique=enemies.find(e=>e.type==='kaique'&&e.hp>0&&!e.iraciTriggered);
    if(kaique&&(window.WorldData?.iraciTraps||[]).some(t=>Math.abs(player.x-t.x)<t.width/2&&player.y>FLOOR-18)){confrontMonitor(kaique,true);}
  }
  function executeMonitorAttack(e){
    if(e.type==='igor'){
      if(e.kind==='bellyBounce'){e.state='bellyAir';e.bellyDuration=.98;e.stateTimer=e.bellyDuration;e.bellyFrom=e.x;e.bellyTo=clamp(e.targetX,arena.bounds[0]+120,arena.bounds[1]-120);floating(e.x,bossCaptionY(e),'BARRIGA NO AR!','#ffe1ac');return;}
      if(e.kind==='bellyRoll'){e.state='bellyRolling';e.stateTimer=1.05;e.dashDir=Math.sign(e.targetX-e.x)||-1;e.rollAngle=0;return;}
      for(let i=0;i<(e.phase===3?2:1);i++)hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.6+i*.8,life:3,speed:180+e.phase*15,maxR:820,damage:12,triggered:false});
      e.state='firing';e.stateTimer=.9;return;
    }
    if(e.kind==='dash'){e.state='dashing';e.stateTimer=.45;e.dashDir=Math.sign(e.targetX-e.x)||-1;return;}
    if(e.kind==='monitorReload'){e.state='firing';e.stateTimer=.18;floating(e.x,e.y-130,'RECARREGANDO!','#d8e9b0');return;}
    const sweep=e.kind==='monitorSweep',count=(sweep?4+e.phase:5+e.phase)+(e.rage?2:0),direction=Math.sign(e.targetX-e.x)||-1,angle=sweep?(direction>0?0:Math.PI):Math.atan2(e.targetY-(e.y-53),e.targetX-e.x);
    for(let i=0;i<count;i++){const spread=sweep?0:[-.10,.04,-.04,.10][i%4];shots.push({x:e.x+direction*35,y:sweep?FLOOR-24:e.y-53,vx:Math.cos(angle+spread)*(e.rage?295:250),vy:Math.sin(angle+spread)*(e.rage?295:250),delay:i*(e.rage?.105:.14),life:4,type:'enemyBullet',owner:'enemy',damage:e.rage?13:10});}
    e.state='firing';e.stateTimer=1.15+(count-5)*.14;fx(e.x+direction*35,e.y-53,'#ffe4a4',12,100);beep(140,.12,'square',.018);
  }
  const bossPhaseSkills=Object.freeze({
    marco:['inkColumns','inkCrossfire'],menezes:['ratPincer','sewerEruption'],nikolas:['slimeMortar','slimeNova'],
    reeisBoss:['royalCrossfire','royalSeal'],freddy:['heavyUppercut','doubleStomp'],dede:['smokeSpiral','smokePrison'],
    nicolas:['astralOrbit','heavenCross'],arthur:['slapBoomerang','slapClap'],igor:['bellyQuake','bellyShrapnel'],kaique:['monitorCrossfire','monitorGrid']
  });
  const bossPhaseSkillNames=Object.freeze({
    inkColumns:'PILARES DE TINTA! SAIA DAS MARCAS',inkCrossfire:'RABISCO CRUZADO! OBSERVE OS DOIS LADOS',
    ratPincer:'CERCO DOS RATOS! LIMPE UM LADO',sewerEruption:'ESGOTO EXPLODINDO! SAIA DAS TAMPAS',
    slimeMortar:'CATARRO DE MORTEIRO! SAIA DO ALVO',slimeNova:'SUPERNOVA DE CATARRO! ABRA DISTÂNCIA',
    royalCrossfire:'RAJADA REAL! DESVIE EM ZIGUEZAGUE',royalSeal:'SELO DO REI! PULE E SAIA DAS MARCAS',
    heavyUppercut:'GANCHO DO FREDDY! SAIA DO ALVO',doubleStomp:'DOIS PISÕES! PULE DUAS VEZES',
    smokeSpiral:'FUMAÇA VOLTANDO! GUARDE O DASH',smokePrison:'PRISÃO DE FUMAÇA! BUSQUE O VÃO',
    astralOrbit:'ÓRBITAS VOLTANDO! OBSERVE A TRAJETÓRIA',heavenCross:'CRUZ CELESTIAL! SAIA DAS DIAGONAIS',
    slapBoomerang:'TAPA DE IDA E VOLTA! DESVIE DUAS VEZES',slapClap:'PALMAS NO CHÃO! SALTE O COMPASSO',
    bellyQuake:'TRÊS ONDAS DE BARRIGA! PULE NO RITMO',bellyShrapnel:'BARRIGA SUPREMA! DESVIE DO LEQUE',
    monitorCrossfire:'RAJADA EM DUAS ALTURAS! OLHE A MIRA',monitorGrid:'GRADE DA FISCALIZAÇÃO! USE O VÃO'
  });
  function bossPhaseHP(e){const profile=bossProfile(e),base=Number(e.baseMax)||Number(profile.hp)||Number(e.max)||100;return profile.phaseHP?[...profile.phaseHP]:(e.type==='nikolas'?[1,1.2,1.4,1.65]:[1,1.25,1.5]).map(value=>Math.round(base*value));}
  function beginBossPhase(e,phase){
    const bars=e.phaseHP||bossPhaseHP(e);e.phaseHP=bars;e.phaseCount=bars.length;e.phase=clamp(phase,1,bars.length);e.max=e.phaseMaxHp=bars[e.phase-1];e.hp=e.max;
    e.announcedPhase=e.phase;e.pattern=0;e.state='phaseChange';e.phaseDuration=e.type==='nikolas'?2.4:1.05;e.stateTimer=e.phaseDuration;e.phaseTransitionTimer=e.phaseDuration;e.damageLock=e.phaseDuration+.1;e.charge=0;e.burn=0;e.burnTick=0;e.phaseStartY=e.y;e.phaseStartX=e.x;
    if(e.conquista){
      const f=e.conquista;
      e.phaseDuration=window.ConquistaCombate.trocar(f,e.phase,player);e.stateTimer=e.phaseTransitionTimer=e.damageLock=e.phaseDuration;
      shots=shots.filter(s=>s.owner!=='enemy');hazards=[];minions=minions.filter(m=>!m.summoned);
      player.inv=Math.max(player.inv,e.phaseDuration);
      const cap=window.ConquistaCombate.capitulo(f);
      if(!cap)epicPlate('FASE '+e.phase,'VIDA RENOVADA',window.ConquistaCombate.chefes[f.slug].cor,1.0);
      beep(cap?165+e.phase*38:245,.17,'triangle',.023);return;
    }
    if(e.type==='nikolas'){e.form=['normal','muscular','flying','giant'][e.phase-1];e.kind=e.phase===2?'muscleClap':e.phase===3?'auraComets':'giantPalm';e.targetX=player.x;e.targetY=player.y-30;}
    else{e.y=FLOOR;const kit=bossPhaseSkills[e.type];e.kind=kit?.[e.phase-2]||'fan';}
    shots=shots.filter(shot=>shot.owner!=='enemy');hazards=[];minions=minions.filter(m=>!m.summoned);
    player.inv=Math.max(player.inv,e.phaseDuration);shake=Math.max(shake,e.type==='nikolas'?10:7);epicFreeze(.16);epic.flash=.4;epic.flashColor=e.type==='nikolas'?'#ffe18b':'#f3d9ff';epicRing(e.x,e.y-60,e.type==='nikolas'?'#ffe18b':'#deb4f0',1.3);fx(e.x,e.y-60,e.type==='nikolas'?'#ffe18b':e.type==='menezes'?'#efbfd3':'#deb4f0',e.type==='nikolas'?46:24,170);
    epicPlate(e.type==='nikolas'?['','NOVA FORMA!','SHAPE DO CALEB!','AURA ASCENDENTE!','TITÃ DO CATARRO!'][e.phase]:'FASE '+e.phase,e.phase>=(e.phaseCount||3)?'ÚLTIMA FASE · VIDA RENOVADA':'VIDA RENOVADA · O CHEFE FICOU MAIS FORTE','#ffb36b',1.7);beep(e.phase>=3?190:290,.24,'triangle',.025);
  }
  function phasePillar(e,x,type,delay=.95,height=310,r=34,damage=15){hazards.push({x:clamp(x,arena.bounds[0]+45,arena.bounds[1]-45),y:FLOOR-6,type,r,delay,life:.55,height,damage,triggered:false});}
  function phaseReturnFan(e,type,count=5,speed=180,spread=.18){
    const start=shots.length;bossFan(e,type,count,speed,spread);for(const shot of shots.slice(start)){shot.returnAt=2.8;shot.life=4.4;shot.damage=type==='smoke'?10:12;}
  }
  function executePhaseSkill(e){
    if(e.type==='giant'||!bossPhaseSkillNames[e.kind])return false;
    const direction=Math.sign(e.targetX-e.x)||-1,phase=e.phase||1;
    if(e.kind==='inkColumns'){for(let i=-1;i<=1;i++)phasePillar(e,e.targetX+i*145,'ink',.95+Math.abs(i)*.17,310,32,15);}
    else if(e.kind==='inkCrossfire'){for(let wave=0;wave<3;wave++)for(const side of[-1,1])shots.push({x:side<0?arena.bounds[0]+35:arena.bounds[1]-35,y:FLOOR-(wave%2?155:27),vx:-side*215,vy:0,delay:wave*.6+(side>0?.22:0),life:4,type:'doodle',owner:'enemy',damage:13,variant:wave%3});}
    else if(e.kind==='ratPincer'){
      const count=Math.min(4,6-minions.filter(m=>m.summoned&&!m.dead).length);for(let i=0;i<count;i++){const side=i%2?1:-1,x=side<0?arena.bounds[0]+45:arena.bounds[1]-45,hp=34;minions.push({id:'menezes-pincer-'+e.pattern+'-'+i,scene,x,y:FLOOR,homeX:x,summoned:true,temporary:true,life:7.5,type:'rat',design:'rat',kind:0,hp,max:hp,damage:8,speed:145,range:460,dir:-side,vy:0,t:1,hit:0,dead:false,xp:0,provocation:'CERCO POUDIAAAM!'});}
      bossFan(e,'word',3,185,.20);
    }
    else if(e.kind==='sewerEruption'){for(let i=-1;i<=1;i++)phasePillar(e,e.targetX+i*150,'word',.95+(i+1)*.19,290,34,17);}
    else if(e.kind==='slimeMortar'){
      const speed=bossProfile(e).projectileSpeed,flight=1.2,gravity=600;for(let i=-1;i<=1;i++){const target=clamp(e.targetX+i*110,arena.bounds[0]+45,arena.bounds[1]-45);shots.push({x:e.x,y:e.y-100,vx:(target-e.x)/flight/speed,vy:(100-gravity*flight*flight/2)/flight/speed,gravity:gravity/speed,delay:(i+1)*.18,life:4,type:'slime',owner:'enemy',damage:15,splash:true});}
    }
    else if(e.kind==='slimeNova'){for(let i=0;i<12;i++){const angle=i*Math.PI/6+.12;shots.push({x:e.x,y:e.y-72,vx:Math.cos(angle)*205,vy:Math.sin(angle)*205,life:3.3,type:'slime',owner:'enemy',damage:14,delay:i%2*.24});}}
    else if(e.kind==='royalCrossfire'){const angle=Math.atan2(e.targetY-(e.y-70),e.targetX-e.x);for(let i=0;i<6;i++)shots.push({x:e.x+direction*35,y:e.y-(i%2?100:35),vx:Math.cos(angle+(i%2?.12:-.12))*235,vy:Math.sin(angle+(i%2?.12:-.12))*235,delay:i*.16,life:4,type:'enemyBullet',owner:'enemy',damage:13});}
    else if(e.kind==='royalSeal'){for(const offset of[-170,170])phasePillar(e,e.targetX+offset,'word',.95,180,38,14);hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.65,life:3,speed:210,maxR:850,damage:14,triggered:false});}
    else if(e.kind==='heavyUppercut')phasePillar(e,e.targetX,'word',.85,165,49,17);
    else if(e.kind==='doubleStomp'){for(let i=0;i<2;i++)hazards.push({x:clamp(e.x+(i?140:-140),arena.bounds[0]+50,arena.bounds[1]-50),y:FLOOR-5,type:'ring',r:0,delay:.65+i*.75,life:3,speed:205,maxR:850,damage:15,triggered:false});}
    else if(e.kind==='smokeSpiral')phaseReturnFan(e,'smoke',5,170,.21);
    else if(e.kind==='smokePrison'){for(const offset of[-180,0,180])phasePillar(e,e.targetX+offset,'smoke',1.05+Math.abs(offset)/1000,260,36,12);}
    else if(e.kind==='astralOrbit')phaseReturnFan(e,'astral',7,180,.18);
    else if(e.kind==='heavenCross'){for(const side of[-1,1])for(let i=0;i<3;i++){const x=side<0?arena.bounds[0]+40:arena.bounds[1]-40,y=105+i*45,angle=Math.atan2(e.targetY-y,e.targetX-x);shots.push({x,y,vx:Math.cos(angle)*225,vy:Math.sin(angle)*225,delay:i*.3,life:4,type:'astral',owner:'enemy',damage:14});}}
    else if(e.kind==='slapBoomerang')phaseReturnFan(e,'confetti',5,185,.17);
    else if(e.kind==='slapClap'){for(let i=0;i<3;i++)hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.6+i*.65,life:3,speed:190,maxR:850,damage:11,triggered:false});}
    else if(e.kind==='bellyQuake'){for(let i=0;i<3;i++)hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.65+i*.72,life:3,speed:175,maxR:850,damage:12,triggered:false});}
    else if(e.kind==='bellyShrapnel'){const start=shots.length,anchor={...e,y:e.y-78,targetY:e.targetY};bossFan(anchor,'doodle',7,190,.22);for(const shot of shots.slice(start)){shot.damage=12;shot.life=3.2;}}
    else if(e.kind==='monitorCrossfire'){for(let i=0;i<6;i++)shots.push({x:e.x+direction*35,y:FLOOR-(i%2?145:25),vx:direction*255,vy:0,delay:i*.18,life:4,type:'enemyBullet',owner:'enemy',damage:10});}
    else if(e.kind==='monitorGrid'){for(let i=0;i<7;i++){const y=FLOOR-25-i*47;if(i===3)continue;shots.push({x:e.x+direction*35,y,vx:direction*230,vy:0,delay:(i%2)*.45,life:4,type:'enemyBullet',owner:'enemy',damage:11});}}
    e.state='firing';e.stateTimer=['bellyQuake','slapClap'].includes(e.kind)?1.65:e.kind==='doubleStomp'?1.25:.72;fx(e.x,e.y-45,e.type==='nikolas'?'#d0e58c':e.type==='menezes'?'#efc0d2':'#e4bfed',18,120);beep(145,.12,'triangle',.018);return true;
  }
  const nikolasPhasePatterns=Object.freeze({2:['muscleClap','slimeMortar','goldenRush','slimeFan','potatoUppercut'],3:['auraComets','skySlimeLances','slimeNova','auraSweep','dash'],4:['giantPalm','giantStomp','giantSlam','giantBreath','giantPalm']});
  const nikolasPhaseWarnings=Object.freeze({muscleClap:'PALMAS DO SHAPE! PULE AS ONDAS',goldenRush:'INVESTIDA DOURADA! USE O DASH',potatoUppercut:'GANCHO DE BATATA! SAIA DA MARCA',auraComets:'COMETAS DE CATARRO! MUDE DE ROTA',skySlimeLances:'AURA DO CÉU! SAIA DAS COLUNAS',auraSweep:'RAJADA AÉREA! OBSERVE AS DIAGONAIS',giantPalm:'MÃO GIGANTE! SAIA DO ALVO',giantStomp:'PASSOS DO TITÃ! PULE NO RITMO',giantSlam:'ESMAGAMENTO! ENTRE NA FAIXA VERDE',giantBreath:'SOPRO GIGANTE! DESVIE DAS GOTAS'});
  function prepareNikolasGiantLane(e){const count=5,width=(arena.bounds[1]-arena.bounds[0]-100)/count;e.slamLanes=Array.from({length:count},(_,i)=>arena.bounds[0]+50+width*(i+.5));e.safeLaneIndex=e.slamLanes.slice(0,3).reduce((best,x,i)=>Math.abs(x-e.targetX)<Math.abs(e.slamLanes[best]-e.targetX)?i:best,0);e.safeLaneX=e.slamLanes[e.safeLaneIndex];e.safeLaneWidth=width*.65;e.safeLaneTime=3.25;}
  function executeNikolasFormAttack(e){
    if(e.type!=='nikolas'||e.phase<2||!nikolasPhaseWarnings[e.kind])return false;
    if(e.kind==='goldenRush'){e.state='dashing';e.stateTimer=.38;e.dashDir=Math.sign(e.targetX-e.x)||-1;fx(e.x,e.y-65,'#ffe4a0',24,150);return true;}
    if(e.kind==='muscleClap'){for(let i=0;i<2;i++)hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.65+i*.7,life:3,speed:200,maxR:850,damage:16,triggered:false});}
    else if(e.kind==='potatoUppercut')phasePillar(e,e.targetX,'slime',.9,175,52,18);
    else if(e.kind==='auraComets'){const first=shots.length;bossFan(e,'slime',7,220,.18);for(const shot of shots.slice(first)){shot.gravity=75;shot.life=3.5;}}
    else if(e.kind==='skySlimeLances'){for(let i=-1;i<=1;i++)phasePillar(e,e.targetX+i*155,'slime',1.05+Math.abs(i)*.16,320,32,17);}
    else if(e.kind==='auraSweep'){for(let wave=0;wave<2;wave++)for(let i=0;i<4;i++){const direction=e.targetX<e.x?-1:1;shots.push({x:e.x,y:e.y-55-i*16,vx:direction*(160+i*17),vy:85+i*35,delay:wave*.7,life:4,type:'slime',owner:'enemy',damage:14});}}
    else if(e.kind==='giantPalm'){for(let i=0;i<3;i++)phasePillar(e,e.targetX+(i-1)*120,'slime',1.05+i*.3,130,48,19);}
    else if(e.kind==='giantStomp'){for(let i=0;i<3;i++)hazards.push({x:e.x-60-i*70,y:FLOOR-5,type:'ring',r:0,delay:.8+i*.7,life:3,speed:195,maxR:900,damage:18,triggered:false});}
    else if(e.kind==='giantSlam'){if(!e.slamLanes)prepareNikolasGiantLane(e);for(let i=0;i<e.slamLanes.length;i++)if(i!==e.safeLaneIndex)phasePillar(e,e.slamLanes[i],'slime',1.05,340,42,20);e.safeLaneTime=1.85;}
    else if(e.kind==='giantBreath'){for(let i=0;i<7;i++)shots.push({x:e.x-65,y:145+(i%2)*55,vx:-(145+i*10),vy:70+i*12,gravity:75,delay:i*.18,life:4,type:'slime',owner:'enemy',damage:15,splash:true});}
    e.state='firing';e.stateTimer=e.kind==='giantStomp'?1.9:e.kind==='giantSlam'?1.4:.85;fx(e.x,e.y-(e.phase===4?200:60),e.phase===3?'#cbb7ff':'#ffe2a0',22,150);beep(e.phase===4?75:125,.16,'sawtooth',.02);return true;
  }
  function bossDefaults(e){Object.assign(e,{homeX:e.homeX??e.x,state:'idle',stateTimer:0,pattern:0,phase:1,announcedPhase:1,damageLock:0,rage:false,angry:0,burn:0,targetX:0,targetY:FLOOR-30,kind:'fan',dashDir:-1,tauntTimer:2.5,emergeX:null,diveFromX:null,monitorSuspicion:0,monitorDir:-1,monitorCooldown:2,monitorHint:false,iraciTriggered:false,rollAngle:0,phaseShield:0,phaseTransitionTimer:0,phaseDuration:1.05,form:'normal',safeLaneTime:0,slamLanes:null,flightTime:0});if(e.type!=='giant'&&bossPhaseSkills[e.type]){e.phaseHP=bossPhaseHP(e);e.phaseCount=e.phaseHP.length;e.baseMax=e.phaseHP[0];e.hp=e.max=e.phaseMaxHp=e.baseMax;e.y=FLOOR;}return e;}
  function beginBossWindup(e){
    if(e.conquista){window.ConquistaCombate.preparar(e.conquista,player);sincronizarConquista(e);return;}
    if(e.type==='giant')e.phase=e.hp/e.max>.66?1:e.hp/e.max>.33?2:3;else e.phase=clamp(e.phase||1,1,e.phaseCount||3);
    let kinds=e.type==='igor'?['bellyBounce','bellyRoll','bellyClap','bellyBounce']:e.type==='kaique'?(e.rage?['monitorBurst','monitorSweep','monitorBurst','dash']:['monitorBurst','monitorSweep','monitorReload','dash']):e.type==='marco'?(e.rage?['brainrots','inkSlam','sketchLine','dash','sixseven','sketchSwarm','mines']:e.phase===1?['fan','inkSlam','sketchLine','sketchSwarm','mines']:['sketchSwarm','fan','inkSlam','sketchLine','dash','mines']):
      e.type==='menezes'?(e.phase===1?['wordWalls','sewerDive','ratsArmy','echo']:e.phase===2?['wordWalls','sewerDive','echo','ratsArmy','ring','provokeZone','dash']:['sewerDive','echo','ratsArmy','wordWalls','ring','sewerDive','provokeZone','echo','dash']):
      e.type==='dede'?(e.phase===1?['smokeFan','bitucas','smokeVeil','dash']:e.phase===2?['bitucas','tragada','smokeFan','cloudMines','smokeVeil','dash']:['tragada','cinzas','bitucas','smokeVeil','cloudMines','dash']):
      e.type==='arthur'?['poseFan','dash','poseWave','poseFan']:
      e.type==='freddy'?['heavyFan','dash','stomp','heavyFan']:
      e.type==='nicolas'?(e.phase===1?['astralFan','skyLances','dash']:e.phase===2?['skyLances','supremeRing','astralFan','dash']:['supremeRing','skyLances','dash','astralFan']):
      e.type==='reeisBoss'?['gangFan','dash','mines','gangFan']:e.type==='giant'?['slam','doodleRain','summonInk','dash']:e.type==='nikolas'&&e.phase===3?['slimeFan','slimeRain','dash','mines','slimeFan','dash']:['slimeFan','dash','slimeRain','mines'];
    if(e.type==='nikolas'&&e.phase>1)kinds=nikolasPhasePatterns[e.phase]||nikolasPhasePatterns[4];
    if(e.type!=='giant'&&e.type!=='nikolas'&&e.phase>=2){const kit=bossPhaseSkills[e.type];if(kit)kinds=[...(e.phase===3?[kit[1],kit[0]]:[kit[0]]),...kinds];}
    e.kind=kinds[e.pattern++%kinds.length];e.wallGapY=[FLOOR-42,300,e.phase===3?195:FLOOR-42][e.pattern%3];e.targetX=player.x;e.targetY=player.y-30;e.state='windup';e.stateTimer=(['nikolas','giant','nicolas'].includes(e.type)?1.25:1.05)-(e.phase-1)*.12-(e.rage?.2:0);const profile=bossProfile(e);e.stateTimer=Math.max(profile.minWindup,(e.stateTimer-(e.type==='marco'?.1:0))*profile.windup);e.windupDuration=e.stateTimer;
    if(e.type==='dede'&&e.kind==='tragada'){e.fxTrago?.parar?.();e.fxTrago=window.FxPixel?.tocar?.('arcane/spell-charge',{x:e.x+Math.sign(e.targetX-e.x)*14,y:e.y+2,palette:window.FxPixel.PAL.fumaca,duracao:1.5})||null;}
    if(e.type==='nikolas'&&e.kind==='giantSlam')prepareNikolasGiantLane(e);
    if(e.kind==='sewerDive'){const candidates=[arena.bounds[0]+90,arena.bounds[1]-90,arena.homeX];const choices=candidates.filter(x=>Math.abs(x-player.x)>140);e.emergeX=(choices.length?choices:candidates)[e.pattern%(choices.length||candidates.length)];e.diveFromX=e.x;}
    if(e.phase>e.announcedPhase){e.announcedPhase=e.phase;floating(e.x,e.y-160,'FASE '+e.phase+'!','#f5b8ae');shake=6;toast(e.type==='nicolas'?'AURA SUPREMA · FASE '+e.phase+'! Pule as ondas, saia dos raios e ataque nas pausas.':'O chefão acelerou! Observe o aviso laranja e ataque na recuperação.');}
  }
  function engageBoss(e){
    if(activeBoss||e.hp<=0||defeated||won||room||cutscene||activity||dialog||paused)return false;
    const access=bossAccess(e);if(!access.ok){if(!bossHintCooldown){toast(access.reason);bossHintCooldown=3;}return false;}
    e.difficultyMode=window.Difficulty?.getMode?.()||'normal';e.difficultyProfile=window.Difficulty?.boss?.(e.type,e.difficultyMode)||null;if(e.difficultyProfile){e.hp=e.max=e.baseMax=e.difficultyProfile.hp;e.phaseHP=e.difficultyProfile.phaseHP?[...e.difficultyProfile.phaseHP]:undefined;bossDefaults(e);}const c2=window.C2Luta?.skin;
    if(c2&&e.type===c2.kit){
      e.phaseHP=window.ConquistaCombate.barras(c2.tema,Math.round(e.hp*c2.vida));
      e.phaseCount=e.phaseHP.length;e.hp=e.max=e.baseMax=e.phaseMaxHp=e.phaseHP[0];
    }
    activeBoss=e;vehicle=false;epic.intro={age:0,name:nomeBoss(e.type)||'Chefe',level:bossProfile(e).level||1,color:e.type==='nikolas'?'#a6d05d':e.type==='menezes'?'#efbfd3':e.type==='giant'?'#f0a35b':'#e9b45c',slammed:false};releaseInputs();player.inv=Math.max(player.inv,.85);respawnCheckpoint={scene,x:Math.max(180,e.homeX-400),boss:e.type};makeArena(e);
    if(c2&&e.type===c2.kit){
      e.conquista=window.ConquistaCombate.criar(c2.tema,e.x,FLOOR,...arena.bounds,window.Difficulty?.getSettings?.(e.difficultyMode),bossProfile(e).recovery);
      // A cutscene da Conquista já apresentou o vilão. Deixe o primeiro aviso à vista.
      epic.intro=null;return true;
    }
    toast((window.Difficulty?.getSettings?.(e.difficultyMode)?.label||'NORMAL')+' · Nv. '+bossProfile(e).level+' sugerido. Invista em ATRIBUTOS e ataque nas aberturas. E na saída: recuar.');return true;
  }

  function bossFan(e,type,count,speed,spread=.16){window.CampaignVfx?.emit?.('cast',{x:e.x+Math.sign(e.targetX-e.x)*26,y:e.y-42,dir:Math.sign(e.targetX-e.x),kind:type});const a=Math.atan2(e.targetY-(e.y-42),e.targetX-e.x);for(let i=0;i<count;i++){const angle=a+(i-(count-1)/2)*spread;shots.push({x:e.x+Math.sign(e.targetX-e.x)*30,y:e.y-42,vx:Math.cos(angle)*speed,vy:Math.sin(angle)*speed,life:5,type,owner:'enemy',damage:type==='smoke'?10:type==='confetti'?12:type==='word'?12:type==='doodle'?(e.angry>0?18:13):16,text:phrases[i%phrases.length],variant:i%3,enraged:e.angry>0});}}
  function addHazard(x,type,delay=.75,r=55){hazards.push({x:clamp(x,55,WORLD-55),y:FLOOR-6,r,delay,life:.55,triggered:false,type,damage:type==='slime'?19:16});}
  function executeBossAttack(e){e.visualAttackAt=time;
    const firstShot=shots.length,firstHazard=hazards.length,firstMinion=minions.length,p=bossProfile(e);
    performBossAttack(e);
    // Tune only objects created by this attack, including special attacks with early returns.
    for(const s of shots.slice(firstShot))if(s.owner==='enemy'){
      s.vx*=p.projectileSpeed;s.vy*=p.projectileSpeed;if(s.gravity)s.gravity*=p.projectileSpeed;
      s.damage=Math.round(s.damage*p.damage);s.splashDamage=Math.round(19*p.damage);
    }
    for(const h of hazards.slice(firstHazard)){
      h.damage=Math.round(h.damage*p.damage);if(h.speed)h.speed*=p.projectileSpeed;
      h.delay=Math.max(.5,h.delay*.9);
    }
    for(const m of minions.slice(firstMinion))if(m.summoned){
      m.hp=m.max=Math.round(m.max*1.15);m.damage=Math.round(m.damage*1.25);
      m.speed=(m.speed||75)*1.2;m.projectileSpeed=1.2;
    }
    if(e.state==='firing')e.stateTimer*=.85;
  }
  function performBossAttack(e){
    e.charge=0;
    if(executeNikolasFormAttack(e))return;
    if(executePhaseSkill(e))return;
    if(e.type==='igor'||e.type==='kaique'){executeMonitorAttack(e);return;}
    if(e.type==='dede'&&e.kind!=='dash'){executeDede(e);return;}
    if(e.type==='arthur'&&e.kind!=='dash'){executeArthur(e);return;}
    if(e.type==='nicolas'&&e.kind!=='dash'){executeNicolas(e);return;}
    if(e.type==='freddy'&&e.kind!=='dash'){executeFreddy(e);return;}
    if(e.type==='menezes'&&e.kind!=='dash'){executeMenezes(e);return;}
    if(e.type==='nikolas'&&e.kind==='slimeFan'&&e.phase===3){
      // Both waves use the announced target. The second cannot track a successful dodge.
      bossFan(e,'slime',5,258,.17);
      const angle=Math.atan2(e.targetY-(e.y-42),e.targetX-e.x),direction=Math.sign(e.targetX-e.x)||-1;
      for(let i=-2;i<=2;i++)shots.push({x:e.x+direction*30,y:e.y-42,vx:Math.cos(angle+i*.20)*278,vy:Math.sin(angle+i*.20)*278,life:5,delay:.78,type:'slime',owner:'enemy',damage:14,secondWave:true});
      e.state='firing';e.stateTimer=1.15;floating(e.x,e.y-165,'DUAS RAJADAS DE CATARRO!','#d5e7a2');fx(e.x,e.y-38,'#c3da73',18,115);beep(105,.16,'sawtooth',.018);return;
    }
    if(['brainrots','sixseven','summonInk','sketchSwarm'].includes(e.kind)){summonDoodles(e);}
    else if(e.kind==='inkSlam'){hazards.push({x:e.x,y:FLOOR-5,type:'ring',ink:true,r:0,delay:.75,life:3,speed:210+e.phase*12,maxR:850,damage:15,triggered:false});addHazard(e.targetX,'ink',1,55);}
    else if(e.kind==='sketchLine'){const direction=Math.sign(e.targetX-e.x)||-1;shots.push({x:e.x+direction*25,y:FLOOR-19,vx:direction*(250+e.phase*20),vy:0,life:3.2,type:'inkBlade',owner:'enemy',damage:15});if(e.phase===3)shots.push({x:e.x-direction*25,y:FLOOR-19,vx:-direction*260,vy:0,life:3.2,type:'inkBlade',owner:'enemy',damage:15,delay:.4});}
    else if(e.kind==='slam'){for(let i=-2;i<=2;i++)addHazard(e.targetX+i*95,'ink',.75+Math.abs(i)*.1,65);hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.7,life:3,speed:230,maxR:900,damage:20,triggered:false});}
    else if(e.kind==='doodleRain'){for(let i=0;i<6+e.phase;i++)shots.push({x:clamp(e.targetX+(i-(5+e.phase)/2)*80,arena.bounds[0]+25,arena.bounds[1]-25),y:70-i%2*20,vx:0,vy:105,gravity:260,life:4,type:'doodle',owner:'enemy',damage:16,variant:i%3});}
    else if(e.kind==='gangFan')bossFan(e,'enemyBullet',3+e.phase*2,220+e.phase*22,.16);
    else if(e.kind==='dash'){e.state='dashing';e.stateTimer=.5;e.dashDir=Math.sign(e.targetX-e.x)||-1;beep(100,.14,'sawtooth');return;}
    if(e.kind==='mines'){for(let i=-1;i<=1;i++)addHazard(e.targetX+i*(e.phase===3?115:140),e.type==='nikolas'?'slime':e.type==='marco'?'ink':'word',.7+Math.abs(i)*.12,e.phase===3?63:53);}
    else if(e.kind==='slimeRain'){for(let i=0;i<4+e.phase;i++){const x=e.targetX+(i-(3+e.phase)/2)*92;shots.push({x:clamp(x,50,WORLD-50),y:125-i%2*25,vx:0,vy:115,gravity:370,life:4,type:'slime',owner:'enemy',damage:16,splash:true});}}
    else if(!['brainrots','sixseven','summonInk','sketchSwarm','inkSlam','sketchLine','slam','doodleRain','gangFan'].includes(e.kind))bossFan(e,e.kind==='fan'?'doodle':e.kind==='words'?'word':'slime',(e.phase===1?3:e.phase===2?5:7)+(e.type==='marco'&&e.phase>1?2:0),(e.angry>0?265:205)+e.phase*26+(e.type==='marco'?15:0),e.type==='menezes'?.18:.15);
    e.state='firing';e.stateTimer=.45;fx(e.x,e.y-38,e.type==='nikolas'?'#c3da73':e.type==='marco'?'#d1a6e8':'#e2acba',14,115);beep(120,.12,'sawtooth',.018);
  }
  function sincronizarConquista(e){
    const f=e.conquista;
    e.x=f.x;e.y=f.y;e.state=f.estado;e.kind=f.golpe;e.stateTimer=Math.max(0,f.dur-f.tempo);e.windupDuration=f.dur;
    e.charge=f.estado==='windup'?100*clamp(f.tempo/f.dur,0,1):0;
  }
  function atualizarConquista(e,dt){
    const f=e.conquista;
    window.ConquistaCombate.atualizar(f,dt,player,(d,x)=>hurt(Math.round(d*bossProfile(e).damage),x),()=>{
      e.visualAttackAt=time;window.C2Luta.som(f.slug,beep,f.fase);
    });
    sincronizarConquista(e);
    if(f.estado==='phaseChange'||defeated||sandbox?.result)return;
    const corpo=f.gemeoX!==null&&Math.abs(player.x-f.gemeoX)<Math.abs(player.x-e.x)?f.gemeoX:e.x;
    if(f.slug==='jorge'?window.JorgeDuelo.toca(f,player.x,player.y-26,12,26):Math.abs(player.y-e.y)<62&&Math.abs(player.x-corpo)<34)hurt(Math.round(13*bossProfile(e).damage),corpo);
  }
  function updateEnemies(dt){
    for(const e of enemies){if(e.hp<=0)continue;e.hit=Math.max(0,e.hit-dt);e.damageLock=Math.max(0,e.damageLock-dt);if(e.type==='marco'&&!e.rage)e.angry=Math.max(0,e.angry-dt);if(e.burn>0){e.burn-=dt;e.burnTick=(e.burnTick||0)+dt;if(e.burnTick>.6){e.burnTick=0;damageEnemy(e,5);}}}
    for(const e of enemies)if(!e.conquista&&e.hp>0&&e.type==='dede'&&Math.abs(e.x-player.x)<650){e.tauntTimer-=dt;if(e.tauntTimer<=0){e.tauntTimer=6;floating(e.x,e.y-115,'SEU GILÓ HOMI!','#e1eccd');}}
    for(const e of enemies)if(!e.conquista&&e.hp>0&&e.type==='freddy'&&Math.abs(e.x-player.x)<650){e.tauntTimer-=dt;if(e.tauntTimer<=0){e.tauntTimer=6;floating(e.x,e.y-125,e.pattern%2?'OPEESTY DA ROÇA!':'Ô REEEIS! Seu capanga tá trabalhando!','#efd19d');}}
    // Monitors can spot the player; story bosses still wait for a deliberate challenge.
    updateSchoolMonitors(dt);

    const e=activeBoss;if(!e||e.hp<=0||arena&&arena.phase!=='active')return;
    
    if(e.conquista){atualizarConquista(e,dt);return;}
    e.stateTimer-=dt;if(e.state==='windup')e.charge=clamp(100*(1-e.stateTimer/e.windupDuration),0,100);
    if(e.safeLaneTime>0)e.safeLaneTime=Math.max(0,e.safeLaneTime-dt);
    if(e.type==='nikolas'&&e.phase===3&&e.state!=='phaseChange'){e.flightTime=(e.flightTime||0)+dt;e.y=FLOOR-110+Math.sin(e.flightTime*2)*17;e.x=clamp(e.homeX+Math.sin(e.flightTime*.9)*130,arena.bounds[0]+85,arena.bounds[1]-85);}
    if(e.state==='phaseChange'){e.phaseTransitionTimer=Math.max(0,e.stateTimer);if(e.type==='nikolas'){const progress=nikolasTransformProgress(e);e.y=e.phase===3?FLOOR-110*progress:e.phase===4?(e.phaseStartY||FLOOR)+(FLOOR-(e.phaseStartY||FLOOR))*progress:FLOOR;if(e.phase===4)e.x=(e.phaseStartX||e.homeX)+(arena.bounds[1]-200-(e.phaseStartX||e.homeX))*progress;if(Math.random()<.65)fx(e.x+rand(-60,60),e.y-70,e.phase===3?'#d3b2ff':'#ffe4a0',2,95);}if(e.stateTimer<=0){e.damageLock=0;if(e.type==='nikolas')e.y=e.phase===3?FLOOR-110:FLOOR;beginBossWindup(e);}return;}
    if(e.state==='monitorTransform'){e.monitorTransform=clamp(1-e.stateTimer/1.25,0,1);if(e.stateTimer<=0)beginBossWindup(e);}
    else if(e.state==='bellyAir'){const t=clamp(1-e.stateTimer/e.bellyDuration,0,1);e.x=e.bellyFrom+(e.bellyTo-e.bellyFrom)*t;e.y=FLOOR-Math.sin(t*Math.PI)*(30+e.phase*4);if(e.stateTimer<=0){e.y=FLOOR;e.state='recover';e.stateTimer=bossRecovery(e);hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.45,life:3,speed:(170+e.phase*15)*bossProfile(e).projectileSpeed,maxR:820,damage:Math.round(12*bossProfile(e).damage),triggered:false});shake=8;fx(e.x,FLOOR-12,'#e2bb83',24,150);}}
    else if(e.state==='bellyRolling'){e.rollAngle=(e.rollAngle||0)+dt*9*e.dashDir;e.x=clamp(e.x+e.dashDir*350*bossProfile(e).dashSpeed*dt,arena.bounds[0]+120,arena.bounds[1]-120);if(e.stateTimer<=0){e.state='recover';e.stateTimer=bossRecovery(e);e.rollAngle=0;}}
    else if(e.state==='windup'&&e.stateTimer<=0)executeBossAttack(e);
    else if(e.state==='underground'&&e.stateTimer<=0){e.x=clamp(e.emergeX,arena.bounds[0]+60,arena.bounds[1]-60);e.y=FLOOR;e.state='recover';e.stateTimer=bossRecovery(e);fx(e.x,FLOOR-12,'#bfc69c',25,125);floating(e.x,e.y-125,'SAIU DO ESGOTO!','#dfe5b3');}
    else if(e.state==='concealed'&&e.stateTimer<=0){e.state='recover';e.stateTimer=bossRecovery(e);}
    else if(e.state==='dashing'){e.x=clamp(e.x+e.dashDir*(e.type==='giant'?450:e.type==='reeisBoss'?690:e.type==='nicolas'?710:e.type==='freddy'?630:e.type==='nikolas'?670:580)*bossProfile(e).dashSpeed*dt,Math.max(e.homeX-390,(arena?.bounds[0]??e.homeX-430)+25),Math.min(e.homeX+390,(arena?.bounds[1]??e.homeX+430)-25));if(Math.random()<.5)fx(e.x-e.dashDir*20,e.y-12,e.type==='nikolas'?'#b6cf75':'#ceaddb',1,40);if(e.stateTimer<=0){e.state='recover';e.stateTimer=bossRecovery(e);}}
    else if(e.state==='firing'&&e.stateTimer<=0){e.state='recover';e.stateTimer=bossRecovery(e);}
    else if(e.state==='recover'&&e.stateTimer<=0)beginBossWindup(e);
    if(!['underground','monitorTransform','phaseChange'].includes(e.state)&&(e.type==='igor'?igorContains(e,player.x,player.y-27,14,23):e.type==='nikolas'&&e.phase>=2?nikolasContains(e,player.x,player.y-27,14,23):Math.abs(e.x-player.x)<(e.type==='giant'?95:e.rage?60:43)&&Math.abs(e.y-player.y)<(e.type==='giant'?155:75)))hurt(Math.round((e.state==='dashing'||e.state==='bellyRolling'?24:e.type==='igor'&&e.state==='bellyAir'?20:13)*bossProfile(e).damage),e.x);
  }
  function summonDoodles(e){
    const roomLeft=6-minions.filter(m=>m.summoned&&!m.dead).length;
    const templates=window.WorldData?.rageMinions||[{design:'spindle'},{design:'wobbler'},{design:'pasta'},{design:'brainrot'}];
    for(let i=0;i<Math.min(e.phase===3?3:2,roomLeft);i++){
      const x=clamp(e.x+(i%2?170:-170),arena.bounds[0]+45,arena.bounds[1]-45);
      const design=e.kind==='sixseven'?'sixseven':templates[(e.pattern+i)%templates.length].design||'brainrot';
      const hp=40+e.phase*9;minions.push({id:e.type+'-summon-'+e.pattern+'-'+i,scene,x,y:FLOOR,homeX:x,summoned:true,temporary:true,life:10,kind:design==='sixseven'?2:1,type:'doodle',design,hp,max:hp,damage:9+e.phase,range:100,dir:i%2?1:-1,vy:0,t:1,hit:0,dead:false,xp:0});
    }
    floating(e.x,e.y-160,e.kind==='sixseven'?'SIX SEVEN!':'CADERNO, GANHA VIDA!','#ffc4d6');
  }
  function executeDede(e){
    const dir=Math.sign(e.targetX-e.x)||-1;e.fxTrago?.parar?.();e.fxTrago=null;
    if(e.kind==='smokeVeil'){e.state='concealed';e.stateTimer=1;fx(e.x,e.y-35,'#bec4c7',26,110);window.FxPixel?.tocar?.('explosions/smoke-bomb',{x:e.x,y:FLOOR-4,palette:window.FxPixel.PAL.fumaca,avancar:.9,duracao:1.7,opcoes:{semLata:true}});return;}
    if(e.kind==='bitucas'){ // joga bitucas acesas em arco; onde caem fica brasa no chão
      const n=3+e.phase,ox=e.x+dir*24,oy=e.y-56;
      for(let i=0;i<n;i++){const land=clamp(e.targetX+(i-(n-1)/2)*72,arena.bounds[0]+40,arena.bounds[1]-40),T=.72+i*.07,g=620;shots.push({x:ox,y:oy,vx:(land-ox)/T,vy:(FLOOR-8-oy)/T-g*T/2,gravity:g,life:3.2,type:'bituca',owner:'enemy',damage:8,brasa:true,spin:i*1.7});}
      e.state='firing';e.stateTimer=.5;fx(ox,oy,'#ffb070',8,70);beep(520,.05,'square',.012);return;
    }
    if(e.kind==='tragada'){ // depois da tragada funda, a baforada rola pelo chão para os dois lados
      for(let i=0;i<(e.phase===3?2:1);i++)hazards.push({x:e.x,y:FLOOR-5,type:'ring',smoke:true,r:0,delay:.3+i*.75,life:3,speed:205+e.phase*15,maxR:840,damage:13,triggered:false});
      window.FxPixel?.tocar?.('explosions/smoke-bomb',{x:e.x+dir*80,y:e.y-4,palette:window.FxPixel.PAL.fumaca,flip:dir<0,avancar:.9,duracao:1.9,opcoes:{semLata:true}});
      fx(e.x+dir*20,e.y-48,'#d4dcd6',30,170);shake=Math.max(shake,4);e.state='firing';e.stateTimer=.7;beep(80,.3,'sawtooth',.02);return;
    }
    if(e.kind==='cinzas'){ // bate a cinza do cigarro: cinza com brasa cai do alto em três marcas
      for(let i=-1;i<=1;i++)hazards.push({x:clamp(e.targetX+i*125,arena.bounds[0]+40,arena.bounds[1]-40),y:FLOOR-8,type:'smoke',brasa:true,cinza:true,r:42,delay:1.05+Math.abs(i)*.16,life:.75,damage:12,triggered:false});
      e.state='firing';e.stateTimer=.45;fx(e.x+dir*26,e.y-40,'#9a9690',10,60);beep(260,.06,'triangle',.012);return;
    }
    if(e.kind==='smokeFan')bossFan(e,'smoke',3+e.phase,175+e.phase*15,.18);
    else if(e.kind==='cloudMines')for(let i=-1;i<=1;i++)hazards.push({x:clamp(e.targetX+i*135,arena.bounds[0]+50,arena.bounds[1]-50),y:FLOOR-8,type:'smoke',r:52,delay:1.05+Math.abs(i)*.1,life:.85,damage:10,triggered:false});
    e.state='firing';e.stateTimer=.4;fx(e.x,e.y-35,'#cbd4ce',12,95);beep(150,.1,'triangle',.015);
  }
  function executeArthur(e){
    if(e.kind==='poseFan')bossFan(e,'confetti',3+e.phase,190+e.phase*18,.18);
    else if(e.kind==='poseWave')hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.7,life:3,speed:215+e.phase*15,maxR:850,damage:13,triggered:false});
    e.state='firing';e.stateTimer=.45;fx(e.x,e.y-40,'#eab9df',18,105);beep(310,.1,'triangle',.018);
  }
  function executeFreddy(e){
    if(e.kind==='heavyFan')bossFan(e,'enemyBullet',3+e.phase,220+e.phase*18,.15);
    else if(e.kind==='stomp'){
      hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.55,life:3,speed:220+e.phase*15,maxR:850,damage:16,triggered:false});
      floating(e.x,e.y-128,'SEGURA ESSA, REEEIS!','#efd19d');
    }
    e.state='firing';e.stateTimer=.45;fx(e.x,e.y-35,'#e3b477',14,105);beep(115,.12,'square',.018);
  }
  function executeNicolas(e){
    if(e.kind==='astralFan')bossFan(e,'astral',3+e.phase*2,190+e.phase*22,.18);
    else if(e.kind==='skyLances'){
      for(let i=-1;i<=1;i++)hazards.push({x:clamp(e.targetX+i*125,arena.bounds[0]+35,arena.bounds[1]-35),y:FLOOR-6,type:'astral',r:40,delay:.95+Math.abs(i)*.15,life:.5,triggered:false,damage:18});
    }else if(e.kind==='supremeRing'){
      hazards.push({x:e.x,y:FLOOR-5,type:'ring',astral:true,r:0,delay:.65,life:3,speed:240+e.phase*18,maxR:900,damage:18,triggered:false});
      if(e.phase===3)hazards.push({x:e.x,y:FLOOR-5,type:'ring',astral:true,r:0,delay:1.25,life:3,speed:240,maxR:900,damage:18,triggered:false});
    }
    e.state='firing';e.stateTimer=.5;shake=Math.max(shake,5);fx(e.x,e.y-45,'#ffe28c',22,150);beep(210,.14,'triangle',.025);
  }
  function executeMenezes(e){
    if(e.kind==='sewerDive'){e.state='underground';e.stateTimer=1;fx(e.x,FLOOR-10,'#a7b68a',18,100);return;}
    if(e.kind==='ratsArmy'){
      const count=Math.min(2+e.phase,6-minions.filter(m=>m.type==='rat'&&!m.dead).length);
      for(let i=0;i<count;i++){const x=clamp(e.x+(i%2?1:-1)*(80+Math.floor(i/2)*45),arena.bounds[0]+35,arena.bounds[1]-35),hp=24+e.phase*6;minions.push({id:'menezes-rat-'+e.pattern+'-'+i,scene,x,y:FLOOR,homeX:x,summoned:true,temporary:true,life:8,type:'rat',design:'rat',kind:0,hp,max:hp,damage:6+e.phase,speed:105+e.phase*12,range:340,dir:i%2?1:-1,vy:0,t:1,hit:0,dead:false,xp:0,provocation:'REEIS POUDIAAAM!'});}
      floating(e.x,e.y-150,'EXÉRCITO DOS RATOS!','#ddccaa');
    }
    else if(e.kind==='wordWalls'){const direction=Math.sign(e.targetX-e.x)||-1;shots.push({x:e.x+direction*30,y:200,vx:direction*(e.phase===3?185:150),vy:0,life:6,type:'wordWall',owner:'enemy',damage:17,gapY:e.wallGapY,gapHeight:115});}
    else if(e.kind==='ring'){hazards.push({x:e.x,y:FLOOR-5,type:'ring',r:0,delay:.5,life:3,speed:230+e.phase*22,maxR:860,damage:17,triggered:false});}
    else if(e.kind==='echo'){bossFan(e,'word',3,210,.16);const a=Math.atan2(e.targetY-(e.y-40),e.targetX-e.x);for(let i=-1;i<=1;i++)shots.push({x:e.x,y:e.y-40,vx:Math.cos(a+i*.12)*245,vy:Math.sin(a+i*.12)*245,life:5,delay:.8,type:'word',echo:true,owner:'enemy',damage:12,text:['PEGOU AR!','ECO POUDIAAAM','TEKETEKE'][i+1]});}
    else if(e.kind==='provokeZone'){hazards.push({x:clamp(e.targetX,arena?.bounds[0]+100||55,arena?.bounds[1]-100||WORLD-55),y:FLOOR-6,r:100,delay:1.1,life:2.1,type:'provoke',damage:12,triggered:false,didLaunch:false});}
    e.state='firing';e.stateTimer=.45;fx(e.x,e.y-40,'#ecc2d5',14,115);beep(140,.13,'triangle');
  }
  function updateHazards(dt){for(const h of hazards){h.delay-=dt;if(h.delay>0)continue;if(!h.triggered){h.triggered=true;window.FxPixel?.perigo?.(h,activeBoss);fx(h.x,h.y,h.type==='astral'||h.astral?'#ffe39a':h.type==='slime'?'#bad677':h.type==='ink'?'#d2a7eb':'#edb9cb',22,135);shake=Math.max(shake,3);}h.life-=dt;
      if(h.type==='ring'){h.r+=h.speed*dt;if(Math.abs(Math.abs(player.x-h.x)-h.r)<27&&player.y>FLOOR-57)hurt(h.damage,h.x);if(h.r>h.maxR)h.life=0;}
      else if(Math.abs(player.x-h.x)<h.r&&(h.type==='astral'||(h.height?player.y>FLOOR-h.height:player.y>FLOOR-80))){if(h.type==='provoke'&&!h.didLaunch&&player.inv<=0){hurt(h.damage,h.x);player.vy=-250;player.ground=false;h.didLaunch=true;floating(player.x,player.y-80,'PEGOU AR!','#f4c6df');}else hurt(h.damage,h.x);}
    }hazards=hazards.filter(h=>h.delay>0||h.life>0);
  }
  function defeat(){
    if(sandbox){finishSandbox('defeated');return;}
    resetBivolt();ollyanEncounter=null;defeated=true;vehicle=false;minions=minions.filter(m=>!m.summoned);releaseInputs();reeisPhase='idle';reeisTimer=0;shots=[];hazards=[];
    if(activeBoss){activeBoss.hp=activeBoss.max;activeBoss.x=activeBoss.homeX;bossDefaults(activeBoss);marcoTrapTriggered=false;}activeBoss=null;player.hp=0;player.y=FLOOR;show('defeatScreen',true);save();updateUI();beep(70,.3,'sawtooth');
  }
  function respawn(){if(!defeated)return false;window.CampaignVfx?.reset?.();resetBivolt();ollyanEncounter=null;ollyanRetryGrace=3;marcoTrapTriggered=false;defeated=false;arena=null;room=null;resetWorldSize();show('defeatScreen',false);releaseInputs();player.hp=bonus().maxHP;player.gas=bonus().maxGas;player.papers=30;player.x=respawnCheckpoint?.scene===scene?respawnCheckpoint.x:230;player.y=FLOOR;player.vy=0;player.ground=true;player.inv=1;camera=clamp(player.x-W*.36,0,WORLD-W);for(const e of enemies)if(e.hp>0){e.hp=e.max;e.x=e.homeX;bossDefaults(e);}toast('Nova tentativa: observe o aviso, use dash e ataque na recuperação do chefe.');updateUI();save();return true;}
  function updateShots(dt){
    for(const s of shots){if(s.delay>0){s.delay-=dt;continue;}if(s.owner==='enemy'&&s.returnAt!==undefined&&!s.returned&&s.life<=s.returnAt){s.vx=-s.vx;s.vy=-s.vy;s.returned=true;}s.x+=s.vx*dt;if(s.gravity)s.vy+=s.gravity*dt;s.y+=s.vy*dt;s.life-=dt;if(s.brasa&&s.vy>0&&s.y>=FLOOR-8){hazards.push({x:clamp(s.x,40,WORLD-40),y:FLOOR-6,type:'smoke',brasa:true,r:26,delay:.05,life:1.25,damage:Math.max(6,Math.round(s.damage*.8)),triggered:false});s.life=0;continue;}if(s.splash&&s.y>=FLOOR-8){addHazard(s.x,'slime',.55,54);if(s.splashDamage)hazards[hazards.length-1].damage=s.splashDamage;s.life=0;}if(s.type==='wordWall'){if(Math.abs(s.x-player.x)<35&&Math.abs(player.y-40-s.gapY)>s.gapHeight/2-14)hurt(s.damage,s.x);continue;}if(s.owner==='player'){
      if(activeBoss?.conquista?.estrada&&window.PerseguicaoMoto.acertar(activeBoss.conquista,s)){s.life=0;continue;}
      for(const e of enemies)if(e.hp>0&&e.state!=='underground'&&(e.conquista?.slug==='jorge'?window.JorgeDuelo.toca(e.conquista,s.x,s.y,7,7):e.type==='igor'?igorContains(e,s.x,s.y,7,7):e.type==='nikolas'&&e.phase>=2?nikolasContains(e,s.x,s.y,7,7):(Math.abs(s.x-e.x)<(e.type==='giant'?95:e.type==='reeisBoss'?45:35)||(e.conquista?.gemeoX!=null&&Math.abs(s.x-e.conquista.gemeoX)<35))&&Math.abs(s.y-(e.y-(e.type==='giant'?80:30)))<(e.type==='giant'?100:55))){damageEnemy(e,s.damage,s.element);s.life=0;break;}
      if(s.life>0)for(const m of minions)if(!m.dead&&Math.abs(s.x-m.x)<28&&Math.abs(s.y-(m.y-22))<28){damageMinion(m,s.damage,s.element);s.life=0;break;}
      if(s.life>0)for(const d of shots)if(d.type==='doodle'&&d.life>0&&Math.hypot(s.x-d.x,s.y-d.y)<27){d.life=0;s.life=0;fx(d.x,d.y,'#dbc1ed',8,65);break;}
    }else if(Math.abs(s.x-player.x)<(s.type==='word'?55:22)&&Math.abs(s.y-(player.y-28))<30){hurt(s.damage,s.x);s.life=0;}
    }
    shots=shots.filter(s=>s.life>0&&s.x>-100&&s.x<WORLD+100&&s.y<520&&s.y>0);
  }
  function updateEffects(dt){window.CampaignVfx?.update?.(dt);for(const a of afterimages)a.life-=dt;afterimages=afterimages.filter(a=>a.life>0);for(const p of particles){p.x+=p.vx*dt;p.y+=p.vy*dt;p.vy+=180*dt;p.life-=dt;}particles=particles.filter(p=>p.life>0);for(const d of damageTexts){d.y-=dt*30;d.life-=dt;}damageTexts=damageTexts.filter(d=>d.life>0);shake=Math.max(0,shake-28*dt);hitFlash=Math.max(0,hitFlash-dt);}
  function text(t,x,y,size=13,color='#fff0d0',align='center'){ctx.font=`bold ${size}px monospace`;ctx.textAlign=align;ctx.textBaseline='middle';ctx.fillStyle='#172b26';ctx.fillText(t,x+2,y+2);ctx.fillStyle=color;ctx.fillText(t,x,y);}
  function pill(t,x,y,color='#eed09a'){const width=t.length*7.8+22;ctx.fillStyle='#1c342de8';ctx.fillRect(x-width/2,y-13,width,26);ctx.strokeStyle='#47604b';ctx.strokeRect(x-width/2+.5,y-12.5,width-1,25);text(t,x,y,12,color);}
  function sprite(type,x,y,opt={}){if(type==='swift'&&window.SwiftGuide?.draw){window.SwiftGuide.draw(ctx,x,y,opt);return;}if(window.Art?.drawCharacter)Art.drawCharacter(ctx,type,x,y,opt);else{ctx.fillStyle=type==='daroca'?'#f0b45d':'#b29d70';ctx.fillRect(x-13,y-39,26,39);}}
  function drawSewerMarker(x,destination){
    ctx.save();ctx.fillStyle=destination?'#eee2a680':'#172e29';ctx.beginPath();ctx.ellipse(x,FLOOR-5,38,8,0,0,Math.PI*2);ctx.fill();ctx.strokeStyle=destination?'#f5c477':'#70836b';ctx.lineWidth=3;ctx.stroke();
    for(let i=-2;i<=2;i++){ctx.fillStyle=destination?'#eec98c':'#52665a';ctx.fillRect(x+i*10-2,FLOOR-10,4,10);}ctx.restore();
    if(destination)pill('VAI SAIR AQUI!',x,FLOOR-40,'#ffe2a6');
  }
  function drawIraciTrap(){
    if(scene!==1||q.kaique||arena&&arena.type!=='kaique')return;
    for(const trap of window.WorldData?.iraciTraps||[]){ctx.save();const angry=activeBoss?.type==='kaique'&&activeBoss.iraciTriggered;ctx.fillStyle=angry?'#af5e62':'#927596';ctx.fillRect(trap.x-trap.width/2,FLOOR-6,trap.width,12);ctx.strokeStyle='#f1cfac';ctx.lineWidth=2;ctx.strokeRect(trap.x-trap.width/2+.5,FLOOR-6.5,trap.width-1,12);ctx.font='bold 11px monospace';ctx.textAlign='center';ctx.fillStyle='#fff0cc';ctx.fillText('IRACI',trap.x,FLOOR+4);ctx.restore();}
  }
  function drawSchoolWatch(){
    if(scene!==1)return;drawIraciTrap();
    for(const e of enemies){if(!isSchoolMonitor(e)||e.hp<=0)continue;const d=e.monitorDir||-1;let reach=300;
      for(const cover of window.WorldData?.schoolCovers||[]){const distance=(cover.x-e.x)*d-cover.width/2;if(distance>0&&distance<reach)reach=distance;}
      const eye=FLOOR-(e.type==='igor'?74:92),center=eye+(FLOOR-40-eye)*reach/300,half=18+reach*.15;ctx.save();ctx.globalAlpha=e.monitorSuspicion>.6?.25:.13;ctx.fillStyle=e.monitorSuspicion>.6?'#eb977e':'#e9d88e';ctx.beginPath();ctx.moveTo(e.x,eye-18);ctx.lineTo(e.x+d*reach,center-half);ctx.lineTo(e.x+d*reach,Math.min(FLOOR-3,center+half));ctx.lineTo(e.x,eye+18);ctx.closePath();ctx.fill();ctx.strokeStyle='#ffe6a7';ctx.lineWidth=1;ctx.stroke();ctx.restore();
      if(e.monitorSuspicion>0){ctx.fillStyle='#304851';ctx.fillRect(e.x-35,FLOOR-126,70,7);ctx.fillStyle=e.monitorSuspicion>.7?'#e39a80':'#e4c77d';ctx.fillRect(e.x-34,FLOOR-125,68*e.monitorSuspicion/1.2,5);pill(e.monitorSuspicion>.7?'TE VI, DA ROÇA!':'QUEM TÁ NO CORREDOR?',e.x,FLOOR-147,'#ffe0a4');}
    }
  }
  function drawSchoolCover(){
    if(scene!==1||arena)return;for(const cover of window.WorldData?.schoolCovers||[]){const hiding=Math.abs(player.x-cover.x)<cover.width/2+10&&player.y>FLOOR-95;ctx.save();ctx.globalAlpha=hiding?.65:1;ctx.fillStyle='#294e70';ctx.fillRect(cover.x-cover.width/2,FLOOR-111,cover.width,111);ctx.fillStyle='#90b9be';ctx.fillRect(cover.x-cover.width/2+3,FLOOR-108,cover.width-6,105);for(let i=0;i<2;i++){const x=cover.x-cover.width/2+5+i*(cover.width-10)/2;ctx.fillStyle='#51809a';ctx.fillRect(x,FLOOR-105,(cover.width-14)/2,100);ctx.fillStyle='#d7dbc6';ctx.fillRect(x+5,FLOOR-74,7,3);ctx.fillStyle='#264e69';for(let j=0;j<3;j++)ctx.fillRect(x+4,FLOOR-96+j*5,15,2);}ctx.restore();pill(hiding?'ESCONDIDO':'ABRIGO',cover.x,FLOOR+25,hiding?'#d4edaa':'#c2d7d0');}
  }
  function drawBossTelegraphs(){
    if(activeBoss?.conquista){
      const f=activeBoss.conquista;
      if(f.estado==='windup')pill(window.ConquistaCombate.titulo(f),clamp(f.x,camera+110,camera+W-110),Math.max(88,f.y-(f.fase===2&&f.slug==='jorge'?150:111)),window.ConquistaCombate.capitulo(f)?.[2]||window.ConquistaCombate.chefes[f.slug].cor);
      if(f.estado==='recover')pill('ABERTURA!',f.x,Math.max(88,f.y-118),'#cfefab');
      return;
    }
    if(activeBoss?.type==='kaique')drawIraciTrap();
    for(const h of hazards){drawHazardPixel(h);if(h.delay>0)pill('!',h.x,FLOOR-34,'#ffe1a0');}
    const e=activeBoss;if(!e)return;if(e.state==='phaseChange'){drawPhaseFlames(e);pill('FASE '+e.phase+' · '+(nikolasPhaseWarnings[e.kind]||bossPhaseSkillNames[e.kind]||'NOVA HABILIDADE'),e.x,bossCaptionY(e),'#ffe4ad');return;}if(e.kind==='sewerDive'&&(e.state==='windup'||e.state==='underground'))drawSewerMarker(e.emergeX,true);if(e.state==='underground')pill('NO ESGOTO · PREPARE O ATAQUE',e.diveFromX??e.x,FLOOR-95,'#dbe0aa');if(e.state==='concealed')pill('FUMAÇA! OBSERVE A SILHUETA',e.x,e.y-125,'#e1e7df');if(e.state==='windup'){ctx.save();ctx.strokeStyle='#f4b878';ctx.lineWidth=e.kind==='dash'?6:2;ctx.globalAlpha=.4+Math.sin(time*19)*.2;ctx.beginPath();if(e.kind==='dash'){ctx.moveTo(e.x,FLOOR-8);ctx.lineTo(e.x+Math.sign(e.targetX-e.x)*330,FLOOR-8);}else{ctx.moveTo(e.x,e.y-40);ctx.lineTo(e.targetX,e.targetY);ctx.moveTo(e.targetX-28,e.targetY-28);ctx.lineTo(e.targetX+28,e.targetY+28);ctx.moveTo(e.targetX+28,e.targetY-28);ctx.lineTo(e.targetX-28,e.targetY+28);}ctx.stroke();ctx.restore();pill(nikolasPhaseWarnings[e.kind]||bossPhaseSkillNames[e.kind]||(e.kind==='bellyBounce'?'BARRIGA NO AR! SAIA DA MARCA':e.kind==='bellyRoll'?'BARRIGA ROLANDO! USE AS PASSARELAS':e.kind==='bellyClap'?'ONDA DA BARRIGA! PULE':e.kind==='monitorBurst'?'RAJADA! ALVO TRAVADO':e.kind==='monitorSweep'?'TIROS RASANTES! PULE':e.kind==='monitorReload'?'RECARREGANDO! PREPARE O ATAQUE':e.kind==='sewerDive'?'ESGOTO! OLHE A SAÍDA':e.kind==='ratsArmy'?'EXÉRCITO DE RATOS!':e.kind==='cloudMines'?'FUMAÇA NO CHÃO! DESVIE':e.kind==='bitucas'?'BITUCAS ACESAS! SAIA DAS BRASAS':e.kind==='tragada'?'TRAGADA FUNDA! PULE A BAFORADA':e.kind==='cinzas'?'CHUVA DE CINZA! SAIA DAS MARCAS':e.kind==='smokeVeil'?'CORTINA DE FUMAÇA!':e.kind==='sketchSwarm'||e.kind==='brainrots'?'DESENHOS GANHANDO VIDA!':e.kind==='sketchLine'?'RISCO NO CHÃO! PULE!':e.kind==='inkSlam'?'ONDA DE TINTA! PULE!':e.kind==='poseWave'?'ONDA DA POSE! PULE!':e.kind==='dash'?'INVESTIDA! USE DASH':e.kind==='skyLances'?'RAIOS! SAIA DAS MARCAS':e.kind==='supremeRing'||e.kind==='stomp'?'ONDA NO CHÃO! PULE!':e.kind==='astralFan'?'ORBITAIS! DESVIE!':e.kind==='mines'?'SAIA DAS MARCAS!':e.kind==='slimeRain'?'CHUVA DE CATARRO!':e.type==='nikolas'&&e.kind==='slimeFan'&&e.phase===3?'DUAS RAJADAS! DESVIE DUAS VEZES':'ATAQUE CARREGANDO!'),e.x,bossCaptionY(e),'#ffd096');}
    if(e.type==='nikolas'&&e.phase===4&&e.safeLaneTime>0&&Number.isFinite(e.safeLaneX)){ctx.save();ctx.fillStyle='#b9edbd24';ctx.strokeStyle='#c8f3b3';ctx.lineWidth=2;ctx.fillRect(e.safeLaneX-e.safeLaneWidth/2,105,e.safeLaneWidth,FLOOR-105);ctx.strokeRect(e.safeLaneX-e.safeLaneWidth/2,105,e.safeLaneWidth,FLOOR-105);ctx.restore();pill('FAIXA SEGURA',e.safeLaneX,FLOOR-44,'#d7f2b7');}
    if(e.state==='monitorTransform')pill(e.type==='igor'?'A BARRIGA ESTÁ CRESCENDO!':e.rage?'FÚRIA DE IRACI!':'FISCALIZAÇÃO EM POSIÇÃO!',e.x,bossCaptionY(e),e.rage?'#ffb7ae':'#ffe1a0');if(e.state==='bellyAir'){const k=clamp(1-e.stateTimer/(e.bellyDuration||1),0,1),w=Math.round(40+k*65);ctx.save();ctx.globalAlpha=.3+.35*k;for(let i=-w;i<=w;i+=4){const h=Math.round(Math.sqrt(Math.max(0,1-(i/w)**2))*(4+k*4));ctx.fillStyle=Math.abs(i)<w*.6?'#2a1a10':'#4a3020';ctx.fillRect(Math.round(e.bellyTo+i),FLOOR-3-h/2,4,Math.max(2,h));}ctx.globalAlpha=.55+.45*Math.abs(Math.sin(time*12));ctx.fillStyle='#ffd27a';for(const d of[-1,1]){const ax=e.bellyTo+d*(w+10);ctx.fillRect(ax-2,FLOOR-14,4,8);ctx.fillRect(ax-(d>0?6:-2),FLOOR-10,4,4);}ctx.restore();}if(e.state==='recover')pill(e.type==='kaique'?'RECARREGANDO! ATAQUE!':'VULNERÁVEL! ATAQUE!',e.x,bossCaptionY(e),'#d3ed9e');
  }
  function drawReeis(){
    if(reeisPhase==='idle')return;const transformed=reeisPhase==='active'||reeisPhase==='burst';sprite('reeis',reeisX,reeisY,{facing:reeisFacing,frame:time,transformed,powered:transformed,aura:reeisPhase!=='running',charging:reeisPhase==='charging',moving:reeisPhase==='running'||reeisPhase==='active'&&Math.abs(player.vx)>8,speed:reeisPhase==='running'?430:Math.abs(player.vx),grounded:reeisPhase==='active'?player.ground:true,vy:player.vy,attack:reeisPhase==='active'&&!!activeBoss,attackType:'gun',attackProgress:(time/.42)%1});
    if(reeisPhase==='charging')pill('O PODER DA RESENHA!',reeisX,reeisY-120,'#ffe39a');
    if(reeisPhase==='burst'){ctx.save();ctx.strokeStyle='#ffe2a0';ctx.lineWidth=5;ctx.globalAlpha=Math.max(0,reeisPhaseTimer/.35);ctx.beginPath();ctx.arc(reeisX,reeisY-45,(1-reeisPhaseTimer/.35)*230+35,0,Math.PI*2);ctx.stroke();ctx.restore();}
  }
  function drawRouteTransition(){const r=routeTransition;if(!r)return;if(r.estrada&&window.EstradaViagem){window.EstradaViagem.desenhar(ctx,{t:r.t,dur:r.duration,de:r.from,para:r.to,nomes:scenes,time,W,H,carro:(c,x,y)=>{if(window.Art?.drawVehicle){c.save();c.translate(Math.round(x),0);Art.drawVehicle(c,0,y,time);c.restore();}if(window.Art?.drawCharacter)Art.drawCharacter(c,'daroca',x+4,y-22,{...playerSpriteOptions(.8),facing:1,moving:false,attack:false});}});return;}ctx.fillStyle='#203e37';ctx.fillRect(0,0,W,H);if(window.Art?.drawScene)Art.drawScene(ctx,0,(r.t*630)%1640,time);ctx.fillStyle='#18352bc4';ctx.fillRect(0,0,W,H);ctx.fillStyle='#55645d';ctx.fillRect(0,350,W,190);ctx.fillStyle='#b5b194';ctx.fillRect(0,348,W,6);for(let i=-1;i<10;i++){const x=(i*160-r.t*800)%1700;ctx.fillStyle='#d6d2ae';ctx.fillRect(x,455,90,7);}if(window.Art?.drawVehicle)Art.drawVehicle(ctx,480,390,time);sprite('daroca',485,366,{facing:1,frame:time,scale:.8,muscular:q.trained,moving:false,grounded:false,flight:true});text('NO CARRO A GÁS DO PAI',480,110,15,'#d3dfae');text('PRÓXIMA PARADA: '+scenes[r.to].toUpperCase(),480,158,24,'#ffe2a7');text('Vruuum… o combustível é por nossa conta.',480,205,13,'#d8dfc3');const progress=clamp(r.t/r.duration,0,1);ctx.fillStyle='#283f35';ctx.fillRect(280,260,400,8);ctx.fillStyle='#efcb87';ctx.fillRect(280,260,400*progress,8);}

  function drawRoomFrame(){
    const r=room;if(r.phase!=='inside'){if(window.Art?.drawScene)Art.drawScene(ctx,scene,r.exteriorCamera,time);else{ctx.fillStyle='#7d9277';ctx.fillRect(0,0,W,H);}sprite('daroca',r.returnX-r.exteriorCamera,FLOOR,{...playerSpriteOptions(),moving:false});}
    ctx.save();ctx.globalAlpha=r.blend;if(window.Art?.drawClassroom)Art.drawClassroom(ctx,r.id,time);else{ctx.fillStyle='#d5c6a0';ctx.fillRect(0,0,W,H);ctx.fillStyle='#354f42';ctx.fillRect(0,FLOOR,W,H-FLOOR);}
    const px=r.phase==='entering'?120:player.x,py=r.phase==='entering'?FLOOR:player.y;sprite('daroca',px,py,playerSpriteOptions());sprite(r.id,r.teacherX,FLOOR,{facing:-1,frame:time,moving:false,grounded:true,talking:!!dialog});pill(r.id==='almiro'?'PROFESSOR ALMIRO':'PROFESSOR MIQUEIAS',r.teacherX,FLOOR-105,'#f1dba5');
    if(r.phase==='inside'&&!dialog){if(Math.abs(player.x-r.teacherX)<105&&Math.abs(player.y-FLOOR)<100)pill('[E] conversar',r.teacherX,FLOOR-140,'#d5e6a4');if(Math.abs(player.x-r.exitX)<105)pill('[E] sair da sala',r.exitX,FLOOR-110,'#f0d298');}ctx.restore();
  }
  function drawMinions(){for(const m of minions){if(m.dead||arena&&!m.summoned)continue;if(m.type==='rat'&&window.Art?.drawRat)Art.drawRat(ctx,m.x,m.y,time,{facing:m.dir,hit:m.hit>0});else if((m.type==='thug'||m.kind==='thug')&&window.Art?.drawThug)Art.drawThug(ctx,m.x,m.y,time,{facing:player.x<m.x?-1:1,tier:m.tier,weapon:m.weapon,hit:m.hit>0,moving:false,attack:!!m.charging});else if(window.Art?.drawMinion)Art.drawMinion(ctx,m.x,m.y,m.kind,time,{facing:m.dir,hit:m.hit>0,moving:m.kind!==2,angry:Math.abs(m.x-player.x)<360,type:m.design||m.variant||m.type});else if(window.Art?.drawDoodle)Art.drawDoodle(ctx,m.x,m.y-22,m.kind,time,false);else{ctx.fillStyle=m.hit>0?'#fff2d8':'#a679ac';ctx.fillRect(m.x-18,m.y-34,36,34);ctx.fillStyle='#fff3df';ctx.fillRect(m.x-11,m.y-25,7,7);ctx.fillRect(m.x+4,m.y-25,7,7);}ctx.fillStyle='#2b3f33';ctx.fillRect(m.x-20,m.y-48,40,4);ctx.fillStyle='#dab7dd';ctx.fillRect(m.x-19,m.y-47,38*m.hp/m.max,2);}}

  // Itens que dá para pegar (papel, gás, materiais, peças e cadernos de missão). Na qualidade ALTA são
  // desenhados depois do shader, para não ganharem brilho, relevo nem contorno de luz.
  let pickupsLater=false;
  function drawPickupsNow(ctx){
    for(const p of pickups)if(!p.taken){const yy=p.y+Math.sin(time*3+p.t)*4;ctx.fillStyle='#172e2540';ctx.beginPath();ctx.ellipse(p.x,p.y+22,13,4,0,0,7);ctx.fill();if(p.type==='repair'||p.type==='notebook'){ctx.fillStyle=p.type==='repair'?'#e9ca74':'#6ca7c5';ctx.fillRect(p.x-11,yy-14,22,26);ctx.strokeStyle='#f8f1b6';ctx.lineWidth=2;ctx.strokeRect(p.x-12,yy-15,24,28);ctx.fillStyle='#203c3d';ctx.fillRect(p.x-6,yy-7,12,3);ctx.fillRect(p.x-6,yy,8,3);}else if(itemNames[p.type]){if(window.Art?.drawMaterial)Art.drawMaterial(ctx,p.x,yy,p.type);else{ctx.fillStyle=p.type==='pencil'?'#edce6f':p.type==='eraser'?'#eb9eae':'#b7d1dc';ctx.fillRect(p.x-7,yy-10,p.type==='pencil'?6:15,20);ctx.strokeStyle='#f6eac2';ctx.strokeRect(p.x-10,yy-13,22,26);}}else if(p.type==='gas'){ctx.fillStyle='#d5ed9a';ctx.fillRect(p.x-8,yy-11,16,22);ctx.fillStyle='#4e775b';ctx.fillRect(p.x-4,yy-15,8,5);ctx.fillStyle='#678a45';ctx.fillRect(p.x-3,yy-6,6,11);}else{ctx.fillStyle='#fff1cc';ctx.fillRect(p.x-8,yy-10,17,20);ctx.fillStyle='#c6bc9e';ctx.fillRect(p.x-4,yy-5,10,2);ctx.fillRect(p.x-4,yy,8,2);}}
  }
  function draw(){
    ctx.save();ctx.clearRect(0,0,W,H);if(ollyanEncounter){window.OllyanEncounter.draw(ctx,ollyanEncounter,{hud:false});window.FxPixel?.desenhar?.(ctx,{dono:'ollyan',camada:'front',mundo:false,tempo:time,atualizar:true});if(ollyanEncounter.stage==='fight'){drawBivoltAura(ctx,ollyanEncounter.player.x,ollyanEncounter.player.y);pill('[E] VOLTAR AO BAILE',W-113,H-25,'#ded6be');}ctx.restore();return;}if(cutscene){window.Cinematics.draw(ctx,cutscene);ctx.restore();return;}if(activity){window.Activities.draw(ctx,activity);ctx.restore();return;}if(room){drawRoomFrame();ctx.restore();return;}if(shake>0)ctx.translate(Math.round(rand(-shake,shake)),Math.round(rand(-shake*.4,shake*.4)));
    const duelo=activeBoss?.conquista,percurso=terrenoConquista(duelo);
    if(!percurso || (duelo.ceu && duelo.ceu.tempo<.85)){
      if(window.C2Luta?.skin&&window.C2Luta.desenharFundo?.(ctx,camera,time,arena)){}else if(window.Art?.drawScene)Art.drawScene(ctx,scene,camera,time);else{ctx.fillStyle='#819379';ctx.fillRect(0,0,W,H);ctx.fillStyle='#617448';ctx.fillRect(0,FLOOR,W,H-FLOOR);}
      if(!arena)window.WorldLife?.draw?.(ctx,scene,camera,time,q,player);
      if(arena&&window.C2Luta?.skin){ctx.save();ctx.globalAlpha=arena.blend;window.BossArena?.palco?.(ctx,window.C2Luta.skin.tema,camera,time,arena.homeX);ctx.restore();}else if(arena&&window.Art?.drawArena){ctx.save();ctx.globalAlpha=arena.blend;Art.drawArena(ctx,arena.type,camera,time,arena.homeX);ctx.restore();}
    }
    if(percurso)percurso.fundo(ctx,duelo);
    ctx.save();ctx.translate(-Math.round(camera),0);
    window.CampaignVfx?.draw?.(ctx,time,'back');window.FxPixel?.desenhar?.(ctx,{dono:'luta',camada:'back',camera,tempo:time});
    if(activeBoss?.conquista)window.ConquistaEfeitos.fundo(ctx,activeBoss.conquista);
    if(percurso)percurso.plataformas(ctx,duelo);
    else for(const p of scenePlatforms()){if(p[0]+p[2]<camera-60||p[0]>camera+W+60)continue;if(window.Graphics?.isLite?.()){ctx.fillStyle=scene===2?'#63736a':'#8d724f';ctx.fillRect(p[0],p[1],p[2],12);ctx.fillStyle=scene===0?'#abc378':'#c0ab7f';ctx.fillRect(p[0],p[1],p[2],4);ctx.fillStyle='#263c303d';ctx.fillRect(p[0]+8,p[1]+12,p[2]-16,4);}else if(scene===11&&window.BaileGalpao?.camarote&&p[0]>(window.BaileGalpao.PORTA||760))window.BaileGalpao.camarote(ctx,p,time);else drawPlank(p);}
    if(!percurso){
      window.Interact?.drawBack?.(ctx,{scene,camera,time,arena:!!arena,arenaType:arena?.type,homeX:arena?.homeX,room:!!room});window.Fliperama?.drawWorld?.(ctx,{scene,camera,time,arena:!!arena,room:!!room});window.Trigal?.drawBack?.(ctx,{scene,camera,time,player,arena:!!arena,room:!!room});window.CampanhaPlantas?.drawBack?.(ctx,{scene,camera,time,player,arena:!!arena,room:!!room});if(scene>=12)window.CampanhaCenarios?.heroi?.(player.x,player.y,player.vy);
    }
    if(!arena){
    window.BivoltQuest?.draw?.(ctx,0,time,q,scene);window.MissaoFarda?.desenhar?.(ctx,time,q,scene);
    if(scene===1)drawSchoolWatch();
    if(window.Graphics?.isShader?.())pickupsLater=true;else drawPickupsNow(ctx);
    for(const [id,n] of Object.entries(npcInfo))if(n.scene===scene&&Math.abs(n.x-camera-W/2)<W/2+180&&npcAvailable(id)){sprite(id,n.x,FLOOR,{facing:id==='ravid'?1:-1,frame:time,moving:false,grounded:true,talking:id==='ravid'||!!dialog&&[n.name,n.name.split(' ·')[0]].includes(dialog.lines[dialog.index]?.name),injured:id==='ravile'&&!q.arthur,helping:id==='aica'&&!q.arthur,expressive:id==='arthur',smoking:id==='dede',smoke:id==='dede'});if(id==='swift'){pill('Irmão de Clara',n.x,FLOOR-112,nearNPC===id?'#ffe19b':'#e0d7ba');pill('Swift',n.x,FLOOR-96,'#e0d7ba');}else pill(n.name,n.x,FLOOR-100,nearNPC===id?'#ffe19b':'#e0d7ba');if(nearNPC===id&&started&&!dialog)pill('[E] conversar',n.x,FLOOR-134,'#b8e5a4');}
    if(scene===0&&window.Art?.drawVehicle)Art.drawVehicle(ctx,1040,FLOOR-5,time);
    drawMinions();for(const d of window.WorldData?.doors||[])if(d.scene===scene&&Math.abs(player.x-d.x)<110&&Math.abs(player.y-FLOOR)<80)pill(vehicle?'[V] estacionar para entrar':'[E] '+d.label,d.x,FLOOR-125,'#f3d89e');
    }
    for(const trap of window.WorldData?.sarueTraps||[])if(trap.scene===scene&&(!arena||arena.type==='marco')&&window.Art?.drawSarueTrap)Art.drawSarueTrap(ctx,trap.x,FLOOR,time,marcoTrapTriggered);
    for(const e of enemies){if(e.hp<=0||arena&&e.type!==arena.type)continue;
      if(e===activeBoss)window.FxPixel?.chefe?.(e);
      if(e.conquista){
        const f=e.conquista, ataca=f.estado==='firing', prepara=f.estado==='windup';
        const opt={frame:time,grounded:true,facing:player.x<e.x?-1:1,hit:e.hit>0,attack:ataca||prepara,
          attackProgress:prepara?.25*clamp(f.tempo/f.dur,0,1):ataca?.3+.7*clamp(f.tempo/f.dur,0,1):0,
          moving:f.estado==='recover'&&Math.abs(f.destino-f.x)>4};
        if(f.estrada)window.PerseguicaoMoto.personagem(ctx,f);
        else if(f.slug==='jorge')window.JorgeDuelo.personagem(ctx,f,opt);
        else window.ConquistaEfeitos.personagem(ctx,f,window.C2Luta.skin.tipo,e.x,e.y,opt);
        if(f.gemeoX!==null)window.ConquistaEfeitos.personagem(ctx,f,'c2_bryan',f.gemeoX,e.y,{...opt,moving:false,facing:player.x<f.gemeoX?-1:1});
        continue;
      }
      if(e.state==='underground'){drawSewerMarker(e.diveFromX??e.x,false);continue;}const fxOn=e===activeBoss;if(fxOn)window.BossFx?.drawBack?.(ctx,e,time);if(e.type==='igor')e.igorScale=igorScale(e);const bt=fxOn?window.BossFx?.transform?.(e,player):null;if(bt){ctx.save();ctx.translate(e.x+bt.dx,e.y);if(bt.rot){ctx.translate(0,-bt.py);ctx.rotate(bt.rot);ctx.translate(0,bt.py);}ctx.scale(bt.sx,bt.sy);ctx.translate(-e.x,-e.y);}sprite(e.type,e.x,e.y,{facing:isSchoolMonitor(e)&&!arena?e.monitorDir:player.x<e.x?-1:1,frame:time,bossPhase:e.type==='nikolas'?(e.phase||1):undefined,phaseChanging:e.type==='nikolas'&&e.state==='phaseChange',transformProgress:e.type==='nikolas'?nikolasTransformProgress(e):1,phaseState:e.state,giantAttack:e.kind,attackTargetX:e.targetX,hit:e.hit>0,attack:e.state==='windup'||e.state==='firing',attackProgress:e.state==='windup'?.28*clamp(1-e.stateTimer/(e.windupDuration||1),0,1):e.state==='firing'?.3+.7*clamp((time-(e.visualAttackAt??time))/.45,0,1):0,angry:e.angry>0,rage:e.rage,scale:e.type==='igor'?igorScale(e):e.type==='marco'&&e.rage?1.4:1,monitorBattle:!!arena,bellyRolling:e.state==='bellyRolling',rollAngle:e.rollAngle||0,igorPose:e.type==='igor'&&fxOn?window.BossFx?.igorPose?.(e)?.pose:undefined,igorPoseK:e.type==='igor'&&fxOn?window.BossFx?.igorPose?.(e)?.k:undefined,firing:e.state==='firing',moving:e.state==='dashing'||isSchoolMonitor(e)&&!arena,dash:e.state==='dashing',speed:e.state==='dashing'?600:isSchoolMonitor(e)&&!arena?33:0,grounded:e.y>=FLOOR,expressive:e.type==='arthur',smoking:e.type==='dede',smoke:e.type==='dede',inhale:e.type==='dede'&&e.state==='windup'&&e.kind==='tragada',hiddenInSmoke:e.state==='concealed',attackType:e.type==='marco'?'doodle':e.type==='nikolas'?'slime':e.type==='freddy'?'punch':e.type==='nicolas'?'cast':'word',supreme:e.type==='nicolas'&&arena?.type==='nicolas',charging:e.type==='nicolas'&&e.state==='windup',powered:e.type==='nicolas'&&arena?.type==='nicolas',noseRub:e.type==='nikolas'});if(bt)ctx.restore();if(fxOn)window.BossFx?.drawFront?.(ctx,e,time);const nameY=e.y-(e.type==='giant'?205:e.type==='igor'&&arena?90*igorScale(e)+28:e.type==='kaique'?115:e.type==='reeisBoss'?145:e.rage?140:96);if(!(e.type==='igor'&&arena?.type==='igor')&&!(e.type==='nikolas'&&e.phase>=2&&arena)){pill((nomeBoss(e.type)||e.type).toUpperCase(),e.x,nameY,e.type==='nicolas'?'#fff0aa':e.type==='nikolas'?'#f5b38c':'#eacb98');ctx.fillStyle='#243b31';ctx.fillRect(e.x-47,nameY+19,94,6);ctx.fillStyle='#d98c72';ctx.fillRect(e.x-46,nameY+20,92*e.hp/e.max,4);}if(e.type==='marco'&&Math.abs(e.x-player.x)<520)pill(e.angry>0?'FÚRIA VERMELHA!':'CUIDADO COM O PISO SARUÊ',e.x,e.y-126,e.angry>0?'#f5abc2':'#e1c6ec');if(e.type==='nikolas'&&e.phase===1){ctx.fillStyle='#253c31';ctx.fillRect(e.x-40,e.y-65,80,6);ctx.fillStyle='#c7e285';ctx.fillRect(e.x-39,e.y-64,78*e.charge/100,4);if(e.charge>75)pill('CATARRO CARREGADO!',e.x,e.y-126,'#d8f29d');}}
    if(!arena)drawSchoolCover();if(arena)drawMinions();drawBossTelegraphs();drawReeis();
    if(!arena&&!room&&!dialog&&started&&!vehicle&&window.Fliperama?.near?.(scene,player.x))pill('[E] JOGAR FLIPERAMA',player.x,FLOOR-140,'#ffd0f0');if(!arena&&!room&&!dialog&&started&&!vehicle&&!window.Balanco?.active?.()&&window.Balanco?.near?.(scene,player.x))pill('[E] SENTAR NO BALANÇO',player.x,FLOOR-140,'#ffe2a8');if(!arena&&!dialog&&started){const nearby=closestBoss();if(nearby){const access=bossAccess(nearby);pill(access.ok?'[E] DESAFIAR '+nomeBoss(nearby.type).toUpperCase():'[E] VER MISSÕES PARA O CHEFE',nearby.x,nearby.y-(nearby.type==='giant'?242:172),access.ok?'#daeda3':'#f3d298');}}
    if(arena?.phase==='active'&&!dialog&&(!percurso||player.x<=arena.bounds[0]+78))pill('[E] SAIR DA ARENA',arena.bounds[0]+87,duelo?.ceu?duelo.ceu.ilhas[0].y+50:FLOOR-65,'#e4ce9b');
    if(started&&!percurso)window.SceneLife?.drawBack?.(ctx,{scene,player,camera,time,arena:!!arena,gapAt});
    for(const a of afterimages){ctx.save();ctx.globalAlpha=a.life*2;sprite('daroca',a.x,a.y,{facing:a.facing,frame:time,dash:true,moving:true,muscular:q.trained,grounded:player.ground});ctx.restore();}
    if(started)drawBivoltAura(ctx,player.x,player.y-40);
    if(started&&(player.inv<=0||Math.floor(time*15)%2===0)){
      // Da Roça (ou o carro) desenhado em qualquer tela: o HeroShadow usa isso para a sombra no chão e a sombra sobre ele.
      const drawHero=(c,ox,oy)=>{const paint=(type,x,y,opt)=>{if(window.Art?.drawCharacter)Art.drawCharacter(c,type,x,y,opt);else{c.fillStyle='#f0b45d';c.fillRect(x-13,y-39,26,39);}};if(vehicle&&window.Art?.drawVehicle){const vf=player.facing<0?-1:1;c.save();c.translate(Math.round(ox),0);c.scale(vf,1);Art.drawVehicle(c,0,oy,time);c.restore();paint('daroca',ox+4*vf,oy-22,playerSpriteOptions(.8));}else{const k=window.SceneLife?.heroScale?.(player,vehicle)||{sx:1,sy:1};c.save();c.translate(Math.round(ox),Math.round(oy));c.scale(k.sx,k.sy);paint('daroca',0,0,playerSpriteOptions());c.restore();}};
      if(window.Balanco?.active?.()){}else if(routeTransition?.chegada&&window.ChegadaCarro?.desenhar?.(ctx,{x:player.x,y:player.y,time,pintar:(c,x,y)=>drawHero(c,x,y)})){}else if(percurso||!window.HeroShadow?.draw?.(ctx,{draw:drawHero,x:player.x,y:player.y,floor:heroFloor(),platforms:scenePlatforms(),scene,time,room:!!room,arena:!!arena,vehicle}))drawHero(ctx,player.x,player.y);}
    if(!percurso){
      if(started)window.SceneLife?.drawFront?.(ctx,{scene,player,camera,time,arena:!!arena,gapAt});window.Interact?.drawFront?.(ctx,{scene,camera,time,arena:!!arena,arenaType:arena?.type,homeX:arena?.homeX,room:!!room});window.Balanco?.draw?.(ctx,{scene,camera,time,arena:!!arena,room:!!room});window.Trigal?.drawFront?.(ctx,{scene,camera,time,player,arena:!!arena,room:!!room});window.CampanhaPlantas?.drawFront?.(ctx,{scene,camera,time,player,arena:!!arena,room:!!room});window.CampanhaCamadas?.primeiroPlano?.(ctx,{scene,camera,time,player,arena:!!arena,room:!!room});
    }
    if(activeBoss?.conquista)window.ConquistaEfeitos.desenhar(ctx,activeBoss.conquista);
    window.BossFx?.drawShotTrails?.(ctx,shots);
    for(const s of shots){if(window.CampaignVfx?.drawProjectile?.(ctx,s,time))continue;if(s.type==='inkBlade'){ctx.save();ctx.translate(s.x,s.y);ctx.rotate(time*9);ctx.fillStyle='#492e60';for(let i=0;i<4;i++){ctx.rotate(Math.PI/2);ctx.fillRect(-3,-23,6,46);}ctx.fillStyle='#d6a8ef';ctx.fillRect(-9,-9,18,18);ctx.fillStyle='#f4dcff';ctx.fillRect(-3,-3,6,6);ctx.restore();}else if(s.type==='smoke'){ctx.save();ctx.globalAlpha=.7;ctx.fillStyle='#bdc9bd';ctx.beginPath();ctx.ellipse(s.x,s.y,13,10,0,0,Math.PI*2);ctx.fill();ctx.fillStyle='#e9eee1';ctx.fillRect(s.x-6,s.y-6,7,4);ctx.restore();}else if(s.type==='confetti'){ctx.save();ctx.translate(s.x,s.y);ctx.rotate(time*5);ctx.fillStyle='#e9b6dc';ctx.fillRect(-7,-6,14,12);ctx.fillStyle='#fff0b8';ctx.fillRect(-3,-3,6,6);ctx.restore();}else if(s.type==='astral'){ctx.save();ctx.translate(s.x,s.y);ctx.rotate(time*2);ctx.fillStyle='#83e8ef';ctx.fillRect(-3,-14,6,28);ctx.fillRect(-14,-3,28,6);ctx.fillStyle='#ffe49a';ctx.fillRect(-7,-7,14,14);ctx.fillStyle='#fff9d5';ctx.fillRect(-3,-3,6,6);ctx.restore();}else if(s.type==='papaia'){ctx.fillStyle=s.element==='electric'?'#a3edf7':'#f5a541';ctx.beginPath();ctx.ellipse(s.x,s.y,10,7,time*3,0,Math.PI*2);ctx.fill();ctx.fillStyle='#f7e58e';ctx.fillRect(s.x-3,s.y-3,4,4);ctx.strokeStyle=s.element==='electric'?'#e1ffff':'#ffe1a6';ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(s.x-15,s.y-4);ctx.lineTo(s.x-23,s.y+3);ctx.lineTo(s.x-18,s.y+6);ctx.stroke();}else if(s.type==='enemyBullet'){ctx.fillStyle='#f6db88';ctx.fillRect(s.x-8,s.y-3,15,6);ctx.fillStyle='#fff1c4';ctx.fillRect(s.x-5,s.y-2,7,2);}else if(s.type==='wordWall'){ctx.save();ctx.fillStyle='#cf9db9';for(let yy=125;yy<440;yy+=26){if(Math.abs(yy-s.gapY)<s.gapHeight/2)continue;ctx.fillRect(s.x-25,yy-10,50,22);text('POUDI',s.x,yy,10,'#43283e');}ctx.strokeStyle='#d1ec9a';ctx.lineWidth=3;ctx.strokeRect(s.x-27,s.gapY-s.gapHeight/2,54,s.gapHeight);ctx.restore();}else if(s.type==='doodle'){if(window.Art?.drawDoodle)Art.drawDoodle(ctx,s.x,s.y,s.variant,time,s.enraged);else{ctx.strokeStyle=s.enraged?'#eb93ae':'#d0a6e6';ctx.lineWidth=3;ctx.beginPath();for(let i=0;i<13;i++){const a=i/12*Math.PI*2,r=i%2?12:21;const x=s.x+Math.cos(a+time*3)*r,y=s.y+Math.sin(a+time*3)*r;i?ctx.lineTo(x,y):ctx.moveTo(x,y);}ctx.stroke();ctx.fillStyle='#f9e8df';ctx.fillRect(s.x-9,s.y-4,6,6);ctx.fillRect(s.x+4,s.y-4,6,6);ctx.fillStyle='#442b54';ctx.fillRect(s.x-7,s.y-2,3,3);ctx.fillRect(s.x+5,s.y-2,3,3);}}else if(s.type==='word'){ctx.save();if(s.delay>0)ctx.globalAlpha=.35;ctx.fillStyle='#2c2b3ce8';const width=s.text.length*7+18;ctx.fillRect(s.x-width/2,s.y-13,width,27);ctx.fillStyle='#cc94ad';ctx.fillRect(s.x-width/2,s.y+12,width,3);text(s.text,s.x,s.y,12,s.echo?'#bddeed':'#f5c9de');ctx.restore();}else if(s.type==='slime'){ctx.fillStyle='#688a3a';ctx.fillRect(s.x-12,s.y-8,24,16);ctx.fillStyle='#c6e37e';ctx.fillRect(s.x-9,s.y-10,15,15);ctx.fillStyle='#e3f6a4';ctx.fillRect(s.x-6,s.y-7,5,4);}else{ctx.save();ctx.translate(s.x,s.y);ctx.rotate(s.type==='paper'?time*9:0);ctx.fillStyle=s.type==='paper'?'#fff3d6':s.type==='ruler'?'#e0b061':s.type==='case'?'#9dd3c3':'#ffe096';ctx.fillRect(-6,-5,s.type==='paper'?12:s.type==='ruler'?28:18,10);ctx.fillStyle='#d5c9ad';ctx.fillRect(-3,-3,6,2);ctx.restore();}}
    window.CampaignVfx?.draw?.(ctx,time,'front');window.FxPixel?.desenhar?.(ctx,{dono:'luta',camada:'front',camera,tempo:time});
    for(const p of particles){ctx.globalAlpha=clamp(p.life*2,0,1);ctx.fillStyle=p.color;ctx.fillRect(Math.round(p.x),Math.round(p.y),p.size,p.size);}ctx.globalAlpha=1;
    if(arena&&!activeBoss?.conquista&&window.HdScene){ctx.save();ctx.translate(Math.round(camera),0);window.HdScene.drawFront(ctx,arena.type,camera,time,arena.homeX,arena.blend);window.HdMaps?.arenaFront?.(ctx,arena.type,camera,time,arena.homeX,arena.blend);ctx.restore();}else if(!arena&&started&&window.HdScene&&[0,1,3,4,5,7,9].includes(scene)){ctx.save();ctx.translate(Math.round(camera),0);window.HdScene.drawAmbient(ctx,time,player.x-camera,player.y,scene);ctx.restore();}if(!arena&&started&&window.Weather){ctx.save();ctx.translate(Math.round(camera),0);window.Weather.draw(ctx,{scene,camera,time,outdoor:!cutscene&&!room&&!activity&&!ollyanEncounter,player:{x:player.x,y:player.y,vx:player.vx,vy:player.vy,ground:player.ground}});ctx.restore();}
    if(!arena&&started&&scene===6&&window.HdMaps?.darkness){ctx.save();ctx.translate(Math.round(camera),0);window.HdMaps.darkness(ctx,scene,camera,time,player.x-camera,player.y,player.facing);ctx.restore();}
    for(const d of damageTexts){ctx.globalAlpha=clamp(d.life*2,0,1);text(d.text,d.x,d.y,17,d.color);}ctx.globalAlpha=1;
    if(q.nikolas&&scene===3&&window.Art?.drawCake)Art.drawCake(ctx,1970,FLOOR-5);
    drawEpicWorld();
    ctx.restore();
    if(!started){ctx.fillStyle='#192e301c';ctx.fillRect(0,0,W,H);if(window.Art?.drawVehicle)Art.drawVehicle(ctx,760,FLOOR,time);sprite('daroca',760,FLOOR-20,{facing:1,frame:time,scale:.8});}
    if(started&&!dialog&&!paused&&!won&&!defeated&&!arena&&!routeTransition&&!training?.active&&!activity){const needPart=pickups.find(p=>p.type==='repair'&&!p.taken),needBook=pickups.find(p=>p.type==='notebook'&&!p.taken);const bivoltTarget=window.BivoltQuest?.parts?.find(p=>!q.bivoltParts.includes(p.id))?.x;const fardaAlvo=window.MissaoFarda?.alvo?.(q,scene);const objective=fardaAlvo!=null?fardaAlvo:scene===11&&!q.ollyan?3260:scene===10&&!q.bivoltUnlocked?(q.bivoltAccepted?(bivoltTarget??1220):1220):scene===10&&!q.rayssaVisit?450:scene===0&&!q.lucas?(q.carMissionAccepted&&q.carParts.length<3?needPart?.x:480):scene===7&&!q.mota?500:scene===8&&(!q.bigodon||getJaglionStatus()==='reserved')?npcInfo.davi.x:scene===9&&!q.arthur?(q.patioAccepted?bossHome('arthur',2850):500):scene===npcInfo.amanda.scene&&!q.amandaDating?npcInfo.amanda.x:scene===4&&!q.nicolas?bossHome('nicolas',5350):scene===1&&!q.almiro?(q.almiroAccepted&&q.notebooks.length<3?needBook?.x:1350):scene===1&&!q.miqueias?2350:scene===5&&!q.freddy&&!q.reeis?bossHome('freddy',5680):scene===5&&!q.reeis?bossHome('reeisBoss',6400):scene===1&&!q.marco?bossHome('marco',3700):scene===6&&!q.giant?bossHome('giant',5650):scene===1&&!q.menezes?bossHome('menezes',5200):scene===2&&!q.trained?400:scene===3&&!q.nikolas?bossHome('nikolas',4300):null;if(objective!==null&&!window.Balanco?.active?.()&&(objective<camera+45||objective>camera+W-45)){const right=objective>camera+W-45;pill(right?'OBJETIVO →':'← OBJETIVO',right?W-83:83,62,'#ffe09b');}
      if(vehicle)pill('CARRO A GÁS',W/2,30,'#cfe5a7');if(reeisCooldown>0&&q.reeis)pill('REEIS: '+Math.ceil(reeisCooldown)+'s',W-90,H-25,'#f6cda0');else if(q.reeis)pill('[R] REEIS PRONTO',W-100,H-25,'#d3e8a5');
    }
    if(reeisPhase==='charging'||reeisPhase==='burst'){ctx.save();ctx.globalAlpha=reeisPhase==='burst'?.55:.2;ctx.strokeStyle='#ffe7ab';ctx.lineWidth=2;for(let i=0;i<16;i++){const yy=20+i*33+Math.sin(time*15+i)*12;ctx.beginPath();ctx.moveTo(i%2?0:W,yy);ctx.lineTo(i%2?180:W-180,yy+Math.sin(i)*25);ctx.stroke();}ctx.restore();}
    if(training?.active)drawTraining();if(routeTransition&&!routeTransition.chegada)drawRouteTransition();
    if(hitFlash>0){ctx.fillStyle=`rgba(225,104,76,${hitFlash*.8})`;ctx.fillRect(0,0,W,H);}if(transition>0){ctx.fillStyle=`rgba(25,43,35,${transition*.5})`;ctx.fillRect(0,0,W,H);}
    drawEpicScreen();
    ctx.restore();
  }
  function frame(now){window.CampanhaPoderes?.controles?.(scene>=12||!!window.C2Luta?.skin); /* Campanha 2: só os botões básicos + PODER 1 e 2 */if(window.Fliperama?.isOpen?.()||window.Campanha2?.aberto?.()){last=now;window.CampaignRun?.tick?.(now,false);requestAnimationFrame(frame);return;} /* com a Campanha 2 aberta, a principal não desenha por trás */const challenge=window.WorldLife?.getStatus?.();const counting=started&&!sandbox&&!won&&!chapterEnded&&!defeated&&!document.hidden&&!window.Arena?.isOpen?.()&&(!paused||challenge?.open&&challenge.stage==='live');window.CampaignRun?.tick?.(now,counting);if(counting&&!cutscene&&!window.SwiftGuide?.isOpen?.())window.CampaignRun?.confirmInitialMode?.();const dt=Math.min(.035,(now-last)/1000);last=now;if(hitStop>0&&started&&!cutscene&&!paused&&!dialog){hitStop=Math.max(0,hitStop-dt);}else{hitStop=0;update(dt);if(started&&!cutscene&&!room&&!activity&&!ollyanEncounter)window.SceneLife?.update?.(dt,{scene,player,camera,time,vehicle,arena:!!arena,dashing:dashTimer>0});if(started&&!cutscene&&!room&&!activity&&!ollyanEncounter&&!arena)window.HdMaps?.touch?.(scene,player.x,player.y,player.vx,player.vy);if(!terrenoConquista())window.Interact?.update?.(dt,{scene,player,camera,time,arena:!!arena,arenaType:arena?.type,homeX:arena?.homeX,room:!!room,shots,enemies,minions,dashing:dashTimer>0});if(activeBoss&&!activeBoss.conquista)window.BossFx?.update?.(dt,{boss:activeBoss,player});}updateEpic(dt);pickupsLater=false;draw();const shaded=window.Graphics?.isShader?.()&&window.Shader?.apply?.(ctx.canvas,{scene,camera,time,outdoor:started&&!cutscene&&!room&&!activity&&!ollyanEncounter&&!arena&&[0,1,3,4,5,7,9].includes(scene)});if(pickupsLater&&!(routeTransition&&!routeTransition.chegada)){const g=(shaded&&window.Shader?.items?.())||ctx;g.save();g.setTransform(1,0,0,1,0,0);g.imageSmoothingEnabled=false;g.translate(-Math.round(camera),0);try{drawPickupsNow(g);}finally{g.restore();}}requestAnimationFrame(frame);}
  createBivoltControl();
  const editableTarget=target=>!!(target?.isContentEditable||target?.closest?.('input,textarea,select,[contenteditable=""],[contenteditable="true"],[role="textbox"]'));
  const visibleKeyboardButton=target=>{const button=target?.closest?.('button,a');return button&&!button.closest('[hidden],[inert]')&&button.getClientRects().length&&getComputedStyle(button).visibility!=='hidden'?button:null;};
  window.addEventListener('keydown',e=>{
    // Browser shortcuts, text editing, and the settings capture keep their native keys.
    if(e.defaultPrevented||inputCaptured||window.Arena?.isOpen?.()||document.querySelector?.('dialog[open]')||editableTarget(e.target))return;
    if(e.ctrlKey||e.metaKey||e.altKey){keys={};return;}
    const code=e.code,confirm=keyMatches('interact',code)||keyMatches('jump',code)||code==='Space'||code==='Enter',pauseKey=code==='Escape'||keyMatches('pause',code);
    if(dialog&&(confirm||pauseKey)){
      e.preventDefault();if(!e.repeat){if(pauseKey||e.target?.closest?.('#dialogClose'))closeDialogue(false);else nextDialog();}return;
    }
    if((cutscene||ollyanEncounter?.stage==='intro')&&!paused&&confirm){e.preventDefault();if(!e.repeat)advanceCutscene();return;}
    if(pauseKey&&started&&!won&&!defeated&&!chapterEnded){e.preventDefault();if(!e.repeat){if(paused)resume();else pause();}return;}
    // Menus keep native Enter/Space activation. Hidden buttons left focused after a
    // conversation, intro, or touch press never own input during active gameplay.
    if(!started||paused||won||defeated||chapterEnded){const button=visibleKeyboardButton(e.target);if(button&&['Enter','Space'].includes(code))keyboardClicks.set(button,performance.now());return;}
    if(activity?.kind==='dinner'&&activity.phase==='choice'&&['Digit1','Digit2','Numpad1','Numpad2'].includes(code)){
      e.preventDefault();if(!e.repeat)submitActivity(Number(code.slice(-1))-1);return;
    }
    if(activity&&confirm){
      // Quiz choices are real buttons; preserve their values and keyboard focus.
      if((activity.kind==='quiz'||activity.kind==='dinner')&&visibleKeyboardButton(e.target)&&['Enter','Space'].includes(code)){
        keyboardClicks.set(e.target.closest('button,a'),performance.now());return;
      }
      e.preventDefault();if(!e.repeat)submitActivity();return;
    }
    if(training?.active&&confirm){e.preventDefault();if(!e.repeat)submitTraining();return;}
    if(activity||training?.active||cutscene||routeTransition||room&&room.phase!=='inside'||arena&&arena.phase!=='active')return;
    if(code==='Enter'&&keyMatches('interact',code)){const button=visibleKeyboardButton(e.target);if(button){keyboardClicks.set(button,performance.now());return;}}
    const mapped=window.ControlSettings?.getActionsForCode(code)||Object.keys(defaultKeys).filter(a=>keyMatches(a,code));
    if(!mapped.length)return;
    e.preventDefault();const held=!!keys[code];if(e.repeat&&!held)return;keys[code]=true;
    if(!e.repeat&&!held)for(const a of mapped)if(!heldActions.has(a)&&a!=='pause')action(a);
  });
  function refreshTouchState(){
    touch={};for(const p of activePointers.values())if(heldActions.has(p.action))touch[p.action]=true;
    document.querySelectorAll('[data-action]').forEach(el=>el.classList.toggle('pressed',[...activePointers.values()].some(p=>p.element===el)));
  }
  function releasePointer(id){
    const p=activePointers.get(id);if(!p)return;activePointers.delete(id);
    safe(()=>{if(p.element.hasPointerCapture?.(id))p.element.releasePointerCapture(id);});refreshTouchState();
  }
  function releaseInputs(){
    if(releasingInputs)return;releasingInputs=true;const captures=[...activePointers.entries()];activePointers.clear();keys={};touch={};joystick={x:0,y:0};prevJump=false;if(player)player.vx=0;
    for(const [id,p] of captures)safe(()=>{if(p.element.hasPointerCapture?.(id))p.element.releasePointerCapture(id);});
    document.querySelectorAll('[data-action]').forEach(el=>el.classList.remove('pressed'));emitGameEvent('game-input-reset');releasingInputs=false;
  }
  function reconcileTouches(e){
    if(!e.touches)return;
    const remaining=Array.from(e.touches),records=[...activePointers.entries()].filter(([,p])=>p.pointerType==='touch'),matched=new Set();
    for(const t of remaining){let best=null,distance=Infinity;for(const [id,p] of records){if(matched.has(id))continue;const sameTarget=t.target===p.element||p.element.contains?.(t.target);const dist=Math.hypot((t.clientX??p.x)-p.x,(t.clientY??p.y)-p.y);if((sameTarget||!t.target&&dist<60)&&dist<distance){best=id;distance=dist;}}if(best!==null)matched.add(best);}
    for(const [id] of records)if(!matched.has(id))releasePointer(id);
  }
  window.addEventListener('keyup',e=>{keys[e.code]=false;});
  window.addEventListener('controls-change',releaseInputs);
  window.addEventListener('controls-capture',e=>{inputCaptured=!!e.detail?.active;releaseInputs();});
  document.addEventListener('focusin',e=>{if(editableTarget(e.target)||e.target?.closest?.('dialog[open]'))releaseInputs();});
  window.addEventListener('blur',()=>{releaseInputs();if(started&&!dialog&&!won)pause();});
  window.addEventListener('pagehide',releaseInputs);
  window.addEventListener('orientationchange',releaseInputs);
  document.addEventListener?.('visibilitychange',()=>{releaseInputs();if(document.hidden&&started&&!won&&!dialog)pause();});
  document.addEventListener?.('fullscreenchange',releaseInputs);
  for(const target of [document,window]){
    for(const eventName of ['pointerup','pointercancel','lostpointercapture'])target.addEventListener?.(eventName,e=>releasePointer(e.pointerId),true);
    target.addEventListener?.('pointermove',e=>{const p=activePointers.get(e.pointerId);if(p){p.x=e.clientX??p.x;p.y=e.clientY??p.y;}},true);
    target.addEventListener?.('touchend',reconcileTouches,{capture:true,passive:true});
    target.addEventListener?.('touchcancel',reconcileTouches,{capture:true,passive:true});
  }
  document.querySelectorAll('[data-action]').forEach(el=>{
    const a=el.dataset.action;
    el.addEventListener('pointerdown',e=>{
      if(e.pointerType==='mouse'&&e.button!==0||activePointers.has(e.pointerId))return;
      e.preventDefault();
      if(inputCaptured||window.Arena?.isOpen?.()||heldActions.has(a)&&(!started||paused||dialog||won||defeated||cutscene||room&&room.phase!=='inside'||arena&&arena.phase!=='active'||routeTransition||activity||training?.active))return;
      pointerTimes.set(el,performance.now());activePointers.set(e.pointerId,{action:a,element:el,pointerType:e.pointerType||'touch',x:e.clientX??0,y:e.clientY??0});
      safe(()=>el.setPointerCapture(e.pointerId));refreshTouchState();if(!heldActions.has(a))action(a);
    });
    for(const eventName of ['pointerup','pointercancel','lostpointercapture'])el.addEventListener(eventName,e=>releasePointer(e.pointerId));
    el.addEventListener('click',e=>{
      if(e.detail!==0||heldActions.has(a)||e.sourceCapabilities?.firesTouchEvents||e.pointerType==='touch')return;
      const pointerAt=pointerTimes.get(el),keyboardAt=keyboardClicks.get(el);
      if(pointerAt!==undefined&&performance.now()-pointerAt<750&&!(keyboardAt!==undefined&&keyboardAt>=pointerAt))return;
      action(a);
    });
  });
  document.querySelectorAll('[data-scene]').forEach(el=>el.addEventListener('click',()=>travel(Number(el.dataset.scene))));
  $('startBtn')?.addEventListener('click',()=>start(false));$('continueBtn')?.addEventListener('click',()=>start(true));$('pauseBtn')?.addEventListener('click',()=>paused?resume():pause());$('resumeBtn')?.addEventListener('click',resume);$('restartBtn')?.addEventListener('click',reset);
  function setSoundEnabled(value){
    sound=!!value;
    const button=$('soundBtn');
    if(button){
      button.classList.toggle('active',sound);
      button.classList.toggle('muted',!sound);
      button.setAttribute('aria-pressed',String(sound));
      button.title=sound?'Desligar som':'Ligar som';
      button.textContent=sound?'♫':'♪';
    }
    setText('soundState',sound?'Som ligado':'Som desligado');
  }
  $('soundBtn')?.addEventListener('click',()=>{setSoundEnabled(!sound);beep(660,.1,'triangle');});
  for(let i=0;i<3;i++)$('activityChoice'+i)?.addEventListener('click',()=>submitActivity(Number($('activityChoice'+i)?.dataset.value??i)));$('activityExitBtn')?.addEventListener('click',cancelActivity);
  $('cutsceneNextBtn')?.addEventListener('click',advanceCutscene);$('cutsceneSkipBtn')?.addEventListener('click',skipCutscene);$('replayIntroBtn')?.addEventListener('click',replayIntro);$('roomExitBtn')?.addEventListener('click',exitRoom);$('trainingExitBtn')?.addEventListener('click',cancelTraining);$('respawnBtn')?.addEventListener('click',respawn);
  function getAudioState(){const flight=ollyanEncounter?window.OllyanEncounter?.getAudioState?.(ollyanEncounter):null;return {started,playing,paused,scene,room:room?.id||null,boss:flight?.boss||activeBoss?.type||null,bossPhase:ollyanEncounter?window.OllyanEncounter.getStatus(ollyanEncounter).phase:activeBoss?.phase||null,cutscene:flight?.cutscene||cutscene?.kind||null,cutsceneToken:flight?.cutsceneToken||cutscene?.audioToken||null,cutsceneElapsed:flight?.cutscene?flight.cutsceneElapsed:cutscene?Math.max(0,Number(window.Cinematics?.timelinePosition?.(cutscene)??cutscene.elapsed??cutscene.audioElapsed)||0):0,cutsceneIndex:flight?.cutscene?flight.cutsceneIndex:cutscene?.index??null,cutsceneTimed:!!flight?.cutsceneTimed||!!cutscene?.options?.musicTimed,training:!!training?.active,activity:activity?.kind||activityCallback||null,dialogue:window.SwiftGuide?.isOpen?.()?'Irmão de Clara Swift':dialog?.lines?.[dialog.index]?.name||null,reeis:reeisPhase,sound,defeated:defeated||ollyanEncounter?.stage==='defeat',chapterEnded};}
  function getBossStatus(){if(ollyanEncounter){const status=window.OllyanEncounter.getStatus(ollyanEncounter);return status.active?{...status,phaseCount:status.phases||3,phaseBars:3,phaseMaxHp:status.max,state:status.stage,difficulty:window.Difficulty?.getSettings?.(ollyanEncounter.options.difficultyMode)?.label||'NORMAL'}:null;}const e=activeBoss;if(!e||e.hp<=0)return null;return {name:nomeBoss(e.type)||e.type,type:e.conquista?.slug||e.type,phaseName:e.conquista?window.ConquistaCombate.capitulo(e.conquista)?.[0]:undefined,hp:Math.max(0,e.hp),max:e.max,phase:e.phase||1,phaseCount:e.type==='giant'?3:e.phaseCount||3,phaseBars:e.type==='giant'?1:e.phaseCount||3,phaseMaxHp:e.max,form:e.type==='nikolas'?(e.form||'normal'):null,state:e.state,charge:e.charge||0,recommendedLevel:window.C2Luta?.skin?.nivel||bossProfile(e).level,difficulty:window.Difficulty?.getSettings?.(e.difficultyMode)?.label||'NORMAL'};}
  const sandboxScenes={igor:1,kaique:1,arthur:9,dede:5,freddy:5,reeisBoss:5,marco:1,giant:6,nicolas:4,menezes:1,ollyan:11,nikolas:3};
  const copyState=value=>JSON.parse(JSON.stringify(value));
  function sandboxUnlocked(){return !!(q.jorgeSeen||load()?.q?.jorgeSeen||safe(()=>localStorage.getItem('daroca-sandbox-v1')==='1'));}
  function finishSandbox(result){if(!sandbox)return;releaseInputs();sandbox.result=result;shots=[];hazards=[];minions=[];resetBivolt();reeisPhase='idle';reeisTimer=0;player.inv=10;paused=true;defeated=false;show('defeatScreen',false);show('pauseScreen',!window.C2Luta?.skin);updateUI();emitGameEvent('sandbox-change',{type:sandbox.type,result});}
  function startSandboxBoss(type){
    if(!Object.hasOwn(sandboxScenes,type)||!sandboxUnlocked())return false;
    if(!sandbox&&(dialog||cutscene||activeBoss||arena||room||routeTransition||activity||training?.active||ollyanEncounter||bivoltStatus().active)){toast('Termine a cena, conversa ou confronto antes de abrir a revanche.');return false;}
    if(!sandbox){window.CampaignRun?.setSuspended?.(true);sandbox={type,result:null,snapshot:copyState({difficultyMode:window.Difficulty?.getMode?.()||'normal',started,playing,paused,won,defeated,chapterEnded,scene,camera,player,q,items,collected,weapon,minionKills,seenBossIntros,killCount,lastSafeX,respawnCheckpoint,vehicle,enemies,minions,pickups,targets,progression:window.Progression?.serialize?.(),reeisCooldown,dashCooldown,attackCooldown,fartCooldown})};}
    const snapshot=sandbox.snapshot;sandbox.type=type;sandbox.result=null;sandbox.difficultyMode=window.Difficulty?.getMode?.()||'normal';
    const saved=!snapshot.started?load():null;q=copyState({...emptyQuest(),...(saved?.q||snapshot.q)});window.Progression?.restore?.(saved?.progression||snapshot.progression);weapon=saved?.weapon??snapshot.weapon;items=copyState(saved?.items||snapshot.items);collected=copyState(saved?.collected||snapshot.collected);
    for(const flag of ['lucas','mota','almiro','miqueias','reeis','marco','giant','menezes','trained','training','freddy','patioAccepted','amandaDating'])q[flag]=true;
    q[type==='reeisBoss'?'reeis':type]=false;q.bivoltUnlocked=true;q.bivoltCharges=9;
    started=true;playing=true;paused=false;won=false;defeated=false;chapterEnded=false;scene=sandboxScenes[type];room=null;arena=null;activeBoss=null;cutscene=null;cutsceneCallback=null;dialog=null;dialogCallback=null;activity=null;training=null;ollyanEncounter=null;routeTransition=null;resetBivolt();vehicle=false;reeisPhase='idle';reeisTimer=0;reeisCooldown=0;dashTimer=0;dashCooldown=0;attackCooldown=0;fartCooldown=0;seenBossIntros=[...Object.keys(sandboxScenes)];player=basePlayer();populate();minions=[];pickups=[];targets=[];
    for(const id of ['startScreen','pauseScreen','chapterEndScreen','victoryScreen','defeatScreen','dialogBox','dialogControls','cinematicOverlay','activityOverlay','trainingAction'])show(id,false);
    if(type==='ollyan'){player.x=3260;player.y=FLOOR;camera=clamp(player.x-W*.36,0,WORLD-W);beginOllyanEncounter(true);}
    else{const enemy=enemies.find(e=>e.type===type);if(!enemy){exitSandbox();return false;}enemies=[enemy];player.x=enemy.x-260;player.y=FLOOR;lastSafeX=player.x;camera=clamp(player.x-W*.36,0,WORLD-W);if(!engageBoss(enemy)){exitSandbox();return false;}}
    releaseInputs();updateUI();canvas.focus();emitGameEvent('sandbox-change',{type,difficultyMode:sandbox.difficultyMode});return true;
  }
  function retrySandboxBoss(){return sandbox?startSandboxBoss(sandbox.type):false;}
  function exitSandbox(){
    if(!sandbox)return false;const prior=sandbox.snapshot;releaseInputs();sandbox=null;ollyanEncounter=null;arena=null;activeBoss=null;room=null;dialog=null;dialogCallback=null;cutscene=null;cutsceneCallback=null;activity=null;training=null;routeTransition=null;resetBivolt();
    window.CampaignRun?.setSuspended?.(false);window.Difficulty?.setMode?.(prior.difficultyMode||'normal');
    ({started,playing,paused,won,defeated,chapterEnded,scene,camera,player,q,items,collected,weapon,minionKills,seenBossIntros,killCount,lastSafeX,respawnCheckpoint,vehicle,enemies,minions,pickups,targets,reeisCooldown,dashCooldown,attackCooldown,fartCooldown}=prior);window.Progression?.restore?.(prior.progression);resetWorldSize();shots=[];hazards=[];particles=[];damageTexts=[];afterimages=[];reeisPhase='idle';reeisTimer=0;
    for(const id of ['victoryScreen','defeatScreen','dialogBox','dialogControls','cinematicOverlay','activityOverlay','trainingAction'])show(id,false);show('startScreen',!started);show('pauseScreen',started&&paused&&!chapterEnded);updateUI();updateContinue();emitGameEvent('sandbox-change',null);if(started&&!paused&&!chapterEnded)canvas.focus();return true;
  }
  window.Game={soundOn:()=>sound,setSoundEnabled,getJaglionStatus,openSwiftGuide,startSandboxBoss,retrySandboxBoss,exitSandbox,activateBivolt,beginOllyanEncounter,retreatOllyan,advanceDialogue:nextDialog,closeDialogue,getDialogueView,getAudioState,getBossStatus,continueExploring,replayEpilogue,returnToMenu,getViewTarget:()=>({y:ollyanEncounter?.player?.y??player.y,vehicle:vehicle||!!ollyanEncounter}),getDialogueAnchor,submitActivity,cancelActivity,spendStat,routeReason,advanceCutscene,skipCutscene,replayIntro,enterRoom,exitRoom,retreatBoss,setJoystick,dash,respawn,releaseInputs,start,travel,pause,resume,reset,submitTraining,cancelTraining,taunt,craft,getState:()=>({run:window.CampaignRun?.getState?.()||null,sandbox:sandbox?{type:sandbox.type,result:sandbox.result,difficultyMode:sandbox.difficultyMode}:null,bivolt:{...bivoltStatus()},ollyan:ollyanEncounter?{...window.OllyanEncounter.getStatus(ollyanEncounter),player:{...ollyanEncounter.player}}:null,started,playing,paused,won,chapterEnded,scene,camera,nearBoss:closestBoss()?{type:closestBoss().type,name:nomeBoss(closestBoss().type),...bossAccess(closestBoss())}:null,q:{...q},player:{...player},enemies:enemies.map(e=>({...e})),targets:targets.map(t=>({...t})),dialog:dialog?{...dialog}:null,items:{...items},materialCount:materialCount(),collected:[...collected],weapon,weaponName:weaponNames[weapon],progression:levelState(),comboStep,seenBossIntros:[...seenBossIntros],activity:activity?{...activity}:null,training:training?{...training}:null,shots:shots.map(s=>({...s})),vehicle,reeisTimer,reeisCooldown,reeisPhase,reeisX,reeisPhaseTimer,joystick:{...joystick},dashTimer,dashCooldown,activeBoss:activeBoss?.type||null,defeated,routeTransition:routeTransition?{...routeTransition}:null,hazards:hazards.map(h=>({...h})),worldWidth:WORLD,room:room?{...room}:null,arena:arena?{...arena}:null,cutscene:cutscene?{...cutscene}:null,minions:minions.map(m=>({...m})),minionKills:[...minionKills],touchActions:Object.keys(touch).filter(a=>touch[a]),activePointers:[...activePointers].map(([pointerId,p])=>({pointerId,action:p.action,pointerType:p.pointerType}))})};
  window.addEventListener('campaign-run-change',event=>{if(event.detail?.reason==='difficulty'&&started&&!sandbox){save();updateUI();}});
  window.addEventListener('progression-change',()=>{if(!started||!player)return;player.hp=Math.min(player.hp,bonus().maxHP);player.gas=Math.min(player.gas,bonus().maxGas);updateUI();save();});
  show('chapterEndScreen',false);show('pauseScreen',false);show('dialogBox',false);show('victoryScreen',false);show('defeatScreen',false);show('cinematicOverlay',false);show('roomOverlay',false);updateContinue();populate();updateUI();requestAnimationFrame(frame);
})();
