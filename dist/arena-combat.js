/* Deterministic attack definitions. The arena owns collision, stocks and combo credit. */
(() => {
 'use strict';
 const clamp=(v,a,b)=>Math.max(a,Math.min(b,v));
 const profile={
  daroca:{physical:[10,.35,72,'elbow'],ranged:[11,.70,'paper',490,'straight'],combo:'gascombo'},
  reeis:{physical:[11,.39,70,'gunbutt'],ranged:[11,.72,'bullet',610,'straight'],combo:'army'},
  nikolas:{physical:[11,.39,70,'nosepunch'],ranged:[9,.68,'goo',390,'arc'],combo:'muscle'},
  marco:{physical:[10,.35,73,'ruler'],ranged:[11,.73,'brainrot',355,'arc'],combo:'sketch'},
  menezes:{physical:[9,.315,64,'claw'],ranged:[11,.74,'words',420,'straight'],combo:'sewer'},
  ollyan:{physical:[10,.35,73,'ear'],ranged:[10,.66,'wind',550,'straight'],combo:'earspin'},
  igor:{physical:[12,.42,68,'punch'],ranged:[12,.80,'bellywave',355,'wave'],combo:'bellybounce'},
  kaique:{physical:[11,.39,70,'stock'],ranged:[11,.72,'bullet',610,'straight'],combo:'inspection'},
  freddy:{physical:[10,.35,72,'capoeira'],ranged:[11,.73,'stone',470,'arc'],combo:'freddyspin'},
  dede:{physical:[10,.35,70,'smokepalm'],ranged:[9,.68,'smoke',375,'straight'],combo:'smokelift'},
  arthur:{physical:[10,.35,72,'slap'],ranged:[11,.73,'palm',450,'straight'],combo:'slapcombo'},
  nicolas:{physical:[10,.35,72,'divinepunch'],ranged:[11,.72,'light',505,'straight'],combo:'divine'},
  giant:{physical:[12,.42,68,'stonefist'],ranged:[12,.80,'six',370,'arc'],combo:'sixtyseven'},
  caleb:{physical:[11,.39,71,'dumbbell'],ranged:[12,.80,'weight',430,'arc'],combo:'stomp'},
  lucas:{physical:[9,.32,61,'lowblow'],ranged:[8,.56,'tongue',520,'tether'],combo:'frogcombo'},
  kaua:{physical:[10,.35,73,'rulertool'],ranged:[11,.72,'pen',520,'straight'],combo:'schoolarsenal'},
  mota:{physical:[10,.35,71,'footballkick'],ranged:[11,.76,'ball',465,'return'],combo:'juggle'},
  ravid:{physical:[10,.35,72,'point'],ranged:[11,.74,'monologue',405,'straight'],combo:'wallrant'},
  almiro:{physical:[10,.35,72,'teacherpalm'],ranged:[11,.72,'chalk',510,'straight'],combo:'baldflash'},
  miqueias:{physical:[10,.35,73,'teacheruler'],ranged:[11,.74,'english',420,'straight'],combo:'englishcombo'},
  davi:{physical:[10,.35,72,'clipper'],ranged:[10,.69,'comb',475,'return'],combo:'barberchair'},
  vitor:{physical:[9,.32,75,'towel'],ranged:[10,.69,'brush',475,'return'],combo:'towelspin'},
  allef:{physical:[11,.39,70,'receiptslap'],ranged:[11,.74,'ticket',435,'straight'],combo:'queue'},
  aica:{physical:[10,.35,72,'heelkick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'},
  ravile:{physical:[10,.35,72,'roundkick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'},
  eloisa:{physical:[10,.35,72,'highkick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'},
  giselle:{physical:[10,.35,72,'spinkick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'},
  rayssa:{physical:[10,.35,72,'sidekick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'},
  analaura:{physical:[10,.35,72,'backkick'],ranged:[10,.70,'heel',475,'return'],combo:'girlknee'}
 };
 const directions=['neutral','side','up','down'];
 const directionAngle={neutral:-.12,side:-.12,up:-Math.PI/2,down:Math.PI/2};
 const dirNames={neutral:'',side:' · lateral',up:' · alto',down:' · baixo'};
 function identity(id){return window.ArenaRoster?.get?.(id)||{id:'daroca',physical:'Cotovelada do chapéu',ranged:'Papel propulsor',combo:'Trinca do feijão',color:'#e8a35d',quote:'Bora pra resenha!'};}
 function base(id,kind,direction){const k=identity(id);id=Object.hasOwn(profile,id)?id:'daroca';direction=directions.includes(direction)?direction:'neutral';return{id:id+'.'+kind+'.'+direction,name:(kind==='physical'?k.physical:kind==='ranged'?k.ranged:k.combo)+dirNames[direction],character:id,kind,direction,damage:0,knockback:220,angle:directionAngle[direction],reach:72,radius:23,windup:.085,duration:.13,recovery:.18,cooldown:.35,color:k.color,shape:'punch',effects:[],text:'',sound:''};}
 function physical(id,dir,options){const def=profile[id]||profile.daroca,p=def.physical,d=base(id,'physical',dir);d.damage=p[0];d.cooldown=p[1];d.reach=p[2];d.shape=p[3];d.knockback=210+(p[0]-9)*18;d.windup=p[0]>=12?.12:p[0]===11?.10:.075;d.recovery=d.cooldown-d.windup-d.duration;d.effects=[d.shape];
  if(dir==='side'){d.reach+=7;d.windup+=.025;d.recovery=Math.max(.07,d.recovery-.025);d.knockback+=18;}
  if(dir==='up'){d.reach-=5;d.radius=26;d.knockback+=12;d.shape=p[3]+'-upper';}
  if(dir==='down'){d.reach-=2;d.radius=26;d.shape=p[3]+'-low';}
  if(id==='menezes'){d.effects=['claws',dir==='up'?'scratch-up':'scratch'];d.radius=21;}
  if(id==='lucas'){d.angle=dir==='up'?-1.4:dir==='down'?1.15:-.06;d.radius=20;d.effects=['lowblow','frog-star'];}
  if(id==='mota'){d.effects=['football-touch'];d.self={vx:dir==='side'?56:0};}
  if(['aica','ravile','eloisa','giselle','rayssa','analaura'].includes(id)){d.effects=['heel-slash','deboche'];d.sound='heel';}
  if(id==='caleb'&&dir==='down'){d.name='Pisada do leg day';d.shape='stomp';d.damage=8;d.reach=62;d.knockback=235;d.cooldown=.5;d.windup=.14;d.duration=.16;d.recovery=.2;d.projectile={type:'shockwave',motion:'wave',speed:370,damage:6,life:1.15,radius:14,count:1,spread:0};d.effects=['ground-crack','weight'];}
  if(id==='ollyan'&&dir==='up')d.effects=['ear-fan','wind'];
  if(id==='igor'&&dir==='down'){d.shape='belly-stomp';d.effects=['belly-ring'];}
  if(id==='arthur')d.sound='slap';
  return d;
 }
 function ranged(id,dir,options){const def=profile[id]||profile.daroca,p=def.ranged,d=base(id,'ranged',dir);d.damage=p[0];d.cooldown=p[1];d.reach=0;d.radius=10;d.windup=.13;d.duration=.16;d.recovery=Math.max(.15,d.cooldown-.29);d.knockback=185;d.shape=p[2];d.angle=dir==='up'?-1.28:dir==='down'?1.16:0;
  d.projectile={type:p[2],motion:p[4],speed:p[3],gravity:p[4]==='arc'?250:0,life:p[4]==='tether'?.50:1.5,count:1,spread:0,radius:d.radius,damage:d.damage,boomerang:p[4]==='return',maxHits:1};
  if(p[4]==='arc'&&dir!=='up'&&dir!=='down')d.angle=-.22;
  if(p[4]==='return'){d.boomerang=true;d.projectile.returnAfter=.48;d.projectile.life=2;d.effects=['return-trail'];}
  if(id==='lucas'){d.projectile.slow=d.slow=1.35;d.projectile.slowFactor=d.slowFactor=.7;d.projectile.life=.5;d.projectile.radius=11;d.effects=['tongue-tether'];d.knockback=135;}
  if(id==='nikolas'){d.projectile.slow=d.slow=.85;d.projectile.slowFactor=d.slowFactor=.78;d.projectile.gravity=200;d.effects=['nose-charge','slime'];}
  if(id==='dede'){d.projectile.slow=d.slow=.9;d.projectile.slowFactor=d.slowFactor=.76;d.effects=['smoke-ring'];d.projectile.radius=13;}
  if(id==='marco'){d.projectile.gravity=110;d.projectile.life=1.7;d.effects=['draw-spawn','brainrot'];d.projectile.variant=['ink','spindle','pasta','brainrot'][directions.indexOf(dir)];}
  if(id==='mota'){d.projectile.returnGain=d.returnGain=8;d.projectile.returnAfter=dir==='up'?.62:.48;d.projectile.gravity=dir==='up'?380:dir==='down'?340:175;d.angle=dir==='up'?-1.10:dir==='down'?1.16:dir==='side'?-.08:-.32;d.effects=['football-launch','aura-catch'];}
  if(id==='igor'){d.projectile.radius=17;d.projectile.life=1.65;d.effects=['belly-wave'];d.knockback=205;}
  if(id==='caleb'){d.projectile.radius=12;d.projectile.gravity=320;d.angle=dir==='up'?-1.22:dir==='down'?1.18:-.28;d.effects=['weight-spin'];d.knockback=210;}
  if(id==='reeis'||id==='kaique'){d.effects=['muzzle','short-burst'];d.projectile.visualCount=3;d.projectile.radius=7;d.sound='shot';}
  if(id==='ravid'){d.text='Ó PRA RAVID FALANDO SOZINHO';d.projectile.text=dir==='up'?'MAS VEJA BEM':dir==='down'?'EU DISSE':'FALANDO SOZINHO';d.projectile.radius=12;}
  if(id==='menezes'){d.text='DA ROÇA PEGOU AR';d.projectile.text=['POUDIAAAM','TEKETEKE','PEGOU AR','RATO POUDI'][directions.indexOf(dir)];d.projectile.radius=12;}
  if(id==='miqueias'){d.text='ALLRIGHT!';d.projectile.text=['ALLRIGHT!','É OU NÃO É','BELEZA CREUZA','YOU IS ERRADO'][directions.indexOf(dir)];d.projectile.radius=12;}
  if(id==='allef'){d.projectile.text='SENHA '+(directions.indexOf(dir)+1);d.effects=['queue-ticket'];}
  if(['aica','ravile','eloisa','giselle','rayssa','analaura'].includes(id)){d.effects=['heel-spin','deboche'];d.projectile.radius=11;d.projectile.gravity=dir==='up'?110:0;d.projectile.variant=id;}
  return d;
 }
 const hit=(delay,damage,knockback,angle,shape,extra={})=>({delay,damage,knockback,angle,dx:54,dy:-35,radius:35,shape,...extra});
 function combo(id,dir,options){const def=profile[id]||profile.daroca,d=base(id,'combo',dir);d.damage=32;d.knockback=745;d.reach=91;d.radius=31;d.windup=.12;d.duration=.96;d.recovery=.35;d.cooldown=3.25;d.shape=def.combo;d.requiresHits=3;d.effects=[def.combo];
  let hits=[hit(0,8,120,-.08,def.physical[3]),hit(.28,9,145,-.18,def.physical[3]),hit(.58,15,745,-.4,def.combo)];
  const f={hits,grab:0,sound:'',summon:''};
  switch(def.combo){
   case'gascombo':hits[2].shape='gas-burst';hits[2].radius=47;f.sound='fart';d.effects=['elbow','knee','gas-burst'];break;
   case'army':f.hits=[hit(0,6,70,-.05,'gunbutt'),hit(.24,6,80,-.05,'army-left'),hit(.48,6,100,-.13,'army-right'),hit(.76,14,750,-.37,'army-launch')];f.summon='army';f.grab=.22;d.transform=1.1;d.form='reeis';d.duration=1.08;d.effects=['crime-army','muzzle-flash'];d.text='OHHHH REEEEIS!';break;
   case'muscle':d.transform=1.15;d.form='nikolasMuscle';hits[0].shape='nose-rub';hits[1].shape='muscle-punch';hits[2].shape='slime-smash';d.text='É MEU BOLO!';break;
   case'sketch':f.summon='drawings';d.transform=1.1;d.form='marcoRage';hits[0].shape='sketch-cage';hits[1].shape='brainrot-stomp';hits[2].shape='sixseven-launch';d.effects=['red-aura','brainrot','sixseven'];d.text='SARUÊ É TU!';break;
   case'sewer':f.grab=.16;hits[0]={...hit(0,8,325,-.03,'claw-push'),dx:56};hits[1]={...hit(.28,8,125,-.05,'sewer-emerge'),warp:'target',dx:40,radius:41};hits[2]={...hit(.58,16,765,-.32,'rat-launch'),dx:48,radius:42};d.effects=['sewer','claws','rat-trail'];d.text='PEGOU AR NO ESGOTO!';break;
   case'earspin':hits[0].shape='ear-vacuum';hits[1].shape='ear-spin';hits[2].shape='wind-launch';hits[2].angle=-1.0;d.effects=['ear-fan','wind-ring'];break;
   case'bellybounce':f.grab=.22;hits[0]=hit(0,7,85,-.08,'punch-grab');hits[1]=hit(.28,9,105,-.05,'belly-rebound',{dx:28,radius:48});hits[2]=hit(.58,16,780,-.42,'belly-launch',{dx:37,radius:47});d.effects=['blue-belly','rebound-stars'];d.text='SEM LANCHE? REBATE AÍ!';break;
   case'inspection':hits[0].shape='stock';hits[1].shape='confiscate';hits[2].shape='iraci-stamp';d.text='IRACI! VOLTA PRA SALA!';d.effects=['monitor-badge','paper-scatter'];break;
   case'freddyspin':hits[0].shape='capoeira-elbow';hits[1].shape='capoeira-kick';hits[2].shape='capoeira-spin';d.effects=['foot-arc','opeesty'];d.text='OPEESTY DA ROÇA!';break;
   case'smokelift':hits[0].shape='smoke-grab';hits[1].shape='braces-flash';hits[2].shape='smoke-launch';hits[2].angle=-.7;d.effects=['smoke-pillar','braces-spark'];d.text='SEU GILÓ HOMI!';break;
   case'slapcombo':hits[0].shape='slap-left';hits[1].shape='slap-right';hits[2].shape='giant-palm';f.sound='slap';d.effects=['palm-print','slap-ring'];d.text='BESTAIADO É TU!';break;
   case'divine':d.transform=1.1;d.form='nicolasAura';hits[0].shape='divine-pose';hits[1].shape='aura-upper';hits[2].shape='protagonist-fall';d.effects=['gold-aura','stage-light'];d.text='ESSA CENA É MINHA!';break;
   case'sixtyseven':f.hits=[hit(0,12,140,-.1,'six-fist',{radius:38}),hit(.36,20,770,-.45,'seven-smash',{radius:43})];d.duration=.8;d.effects=['six','seven','ink-impact'];d.text='SIX... SEVEN!';break;
   case'stomp':hits[0].shape='dumbbell-hook';hits[1].shape='supino-upper';hits[2].shape='stomp-wave';hits[2].radius=48;hits[2].knockback=765;d.effects=['weight','ground-crack','shockwave'];d.text='HOJE TEM LEG DAY!';break;
   case'frogcombo':f.hits=[hit(0,9,100,-.06,'lowblow',{dx:43,dy:-19,radius:26}),hit(.28,8,125,-.2,'tongue-wrap',{dx:52,radius:30}),hit(.58,15,735,-.6,'frog-upper',{dx:48,dy:-33,radius:34})];f.grab=.18;d.effects=['frog-hop','cake-star'];d.text='MEU ALCANCE É NA HUMILDADE!';break;
   case'schoolarsenal':hits[0].shape='ruler-cross';hits[1].shape='eraser-hammer';hits[2].shape='pencil-case-cannon';d.effects=['school-parts','pencil-fan'];d.text='UMMHUMHUMM!';break;
   case'juggle':hits[0].shape='football-lift';hits[1].shape='football-juggle';hits[2].shape='football-bicycle';hits[2].angle=-.55;d.returnGain=10;d.effects=['football-trail','aura-stars'];d.text='DOMINOU! GOLAÇO!';break;
   case'wallrant':f.grab=.2;hits[0].shape='wall-point';hits[1].shape='monologue-wall';hits[2].shape='wall-launch';d.effects=['conversation-wall','word-rain'];d.text='EU NEM TAVA FALANDO CONTIGO!';break;
   case'baldflash':hits[0].shape='teacher-palm';hits[1].shape='bald-reflect';hits[2].shape='bald-flash';d.effects=['careca-glint','chalk-burst'];d.text='AHAHAHA DA ROÇA!';break;
   case'englishcombo':hits[0].shape='ruler';hits[1].shape='beard-brush';hits[2].shape='english-launch';d.effects=['english-words','creuza-star'];d.text='YOU IS VOANDO, BEAUTIFUL!';break;
   case'barberchair':f.grab=.2;hits[0].shape='clipper';hits[1].shape='barber-chair';hits[2].shape='barber-spin';d.effects=['chair-spin','comb-ring'];d.text='DEGRADÊ NA TUA MARRA!';break;
   case'towelspin':hits[0].shape='towel-snap';hits[1].shape='brush-spin';hits[2].shape='towel-launch';d.effects=['towel-arc','brush-ring'];d.text='ACABAMENTO EXPRESSO!';break;
   case'queue':hits[0].shape='receipt-slap';hits[1].shape='queue-bell';hits[2].shape='reception-launch';d.effects=['queue-ticket','bell-stars'];d.text='A FILA ANDOU!';break;
   case'girlknee':f.hits=[hit(0,9,105,-.1,def.physical[3]),hit(.28,8,115,-.12,'heel-feint'),hit(.58,15,755,-.7,'deboche-knee',{dx:47,dy:-40,radius:36})];f.sound=d.sound='biuriful';d.effects=['deboche-pose','heel-spark','knee-star'];d.text='BIURIFUL!';break;
  }
  d.finisher=f;
  if(dir==='up'||dir==='down'){
   const vertical=dir==='up'?-1:1;
   for(const h of f.hits){const reach=Math.abs(h.dx)||51;h.dx=0;h.dy=-35+vertical*reach;h.angle=dir==='up'?-Math.PI/2:Math.PI/2;h.radius=Math.max(35,h.radius);}
   // The warp follows the locked victim rather than a direction-dependent screen edge.
   d.angle=directionAngle[dir];
  }
  return d;
 }
 function attack(character,kind='physical',direction='neutral',options={}){
  const id=Object.hasOwn(profile,character)?character:'daroca',dir=directions.includes(direction)?direction:'neutral';
  const result=kind==='combo'?combo(id,dir,options):kind==='ranged'?ranged(id,dir,options):physical(id,dir,options);
  result.facing=Number(options.facing)<0?-1:1;result.airborne=!!options.airborne;
  return result;
 }
 function stats(character){const id=Object.hasOwn(profile,character)?character:'daroca';return{speed:id==='lucas'?1.08:1,weight:1,renderHeight:id==='lucas'?60:70,hurtbox:{w:34,h:id==='lucas'?60:70},stocks:3,jumps:2};}
 function damageColor(damage){const n=Math.max(0,Number(damage)||0),stops=[[0,[255,255,240]],[40,[255,225,110]],[85,[255,162,70]],[140,[244,75,68]],[220,[172,37,70]]];for(let i=1;i<stops.length;i++)if(n<=stops[i][0]){const [a,ac]=stops[i-1],[b,bc]=stops[i],t=clamp((n-a)/(b-a),0,1);return '#'+ac.map((c,j)=>Math.round(c+(bc[j]-c)*t).toString(16).padStart(2,'0')).join('');}return '#ac2546';}
 function comboReady(hits){return Number.isFinite(Number(hits))&&Number(hits)>=3;}
 function budget(character){const id=Object.hasOwn(profile,character)?character:'daroca',p=profile[id],comboAttack=combo(id,'neutral',{});return{physicalDPS:p.physical[0]/p.physical[1],rangedDPS:p.ranged[0]/p.ranged[1],comboDamage:comboAttack.finisher.hits.reduce((n,h)=>n+h.damage,0),comboKnockback:comboAttack.finisher.hits.at(-1).knockback,speed:stats(id).speed};}
 window.ArenaCombat=Object.freeze({version:2,attack,getAttack:attack,stats,damageColor,comboReady,budget,directions:Object.freeze([...directions]),ids:Object.freeze(Object.keys(profile))});
})();
