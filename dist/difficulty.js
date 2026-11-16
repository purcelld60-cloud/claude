/* Fixed campaign encounters: investing attributes never strengthens a boss. */
(() => {
 'use strict';
 const profiles={
  igor:{hp:850,level:5,damage:1.35,projectileSpeed:1.15,dashSpeed:1.08,windup:1,minWindup:.78,recovery:[1.30,1.18,1.08],armor:.28},
  kaique:{hp:1100,level:6,damage:1.45,projectileSpeed:1.25,dashSpeed:1.12,windup:.95,minWindup:.74,recovery:[1.32,1.18,1.08],armor:.26},
  arthur:{hp:950,level:5,damage:1.5,projectileSpeed:1.28,dashSpeed:1.12,windup:.86,minWindup:.70,recovery:[1.02,.90,.84],armor:.24},
  dede:{hp:700,level:6,damage:1.55,projectileSpeed:1.33,dashSpeed:1.16,windup:.84,minWindup:.65,recovery:[1,.90,.80],armor:.23},
  freddy:{hp:900,level:6,damage:1.65,projectileSpeed:1.35,dashSpeed:1.18,windup:.81,minWindup:.62,recovery:[.98,.86,.78],armor:.22},
  reeisBoss:{hp:1450,level:7,damage:1.7,projectileSpeed:1.36,dashSpeed:1.18,windup:.80,minWindup:.60,recovery:[1,.88,.80],armor:.22},
  marco:{hp:2050,level:8,damage:1.85,projectileSpeed:1.46,dashSpeed:1.30,windup:.76,minWindup:.62,recovery:[.86,.72,.62],armor:.20},
  giant:{hp:2200,level:9,damage:1.8,projectileSpeed:1.30,dashSpeed:1.20,windup:.80,minWindup:.66,recovery:[1.08,.96,.88],armor:.21},
  menezes:{hp:2350,level:12,damage:2.12,projectileSpeed:1.62,dashSpeed:1.39,windup:.70,minWindup:.60,recovery:[.80,.68,.58],armor:.20},
  nicolas:{hp:2000,level:9,damage:1.8,projectileSpeed:1.38,dashSpeed:1.18,windup:.80,minWindup:.62,recovery:[1,.88,.80],armor:.20},
  nikolas:{hp:4100,level:13,damage:2.35,projectileSpeed:1.67,dashSpeed:1.42,windup:.71,minWindup:.62,recovery:[.84,.70,.60],armor:.18}
 };
 for(const[type,p]of Object.entries(profiles)){
  // 67 keeps its original single HP bar and HP-threshold attack patterns.
  if(type!=='giant')p.phaseHP=Object.freeze((type==='nikolas'?[1,1.2,1.4,1.65]:[1,1.25,1.5]).map(multiplier=>Math.round(p.hp*multiplier)));
  Object.freeze(p.recovery);Object.freeze(p);
 }
 Object.freeze(profiles);
 const STORAGE_KEY='daroca-difficulty-v1';
 const modes=Object.freeze({
  easy:Object.freeze({id:'easy',label:'FÁCIL',hp:.68,windup:1.22,recovery:1.4,incomingDamage:1,description:'Chefes com 32% menos vida e mais tempo para reagir e contra-atacar.'}),
  normal:Object.freeze({id:'normal',label:'NORMAL',hp:1,windup:1,recovery:1,incomingDamage:1,description:'O desafio original da campanha, com seus padrões e atributos atuais.'}),
  hard:Object.freeze({id:'hard',label:'DIFÍCIL',hp:1,windup:.82,recovery:.72,incomingDamage:2,description:'Chefes recuperam mais rápido, avisam por menos tempo e seus golpes tiram o dobro da sua vida.'})
 });
 let mode='normal';
 try{const saved=localStorage.getItem(STORAGE_KEY);if(Object.hasOwn(modes,saved))mode=saved;}catch{}
 const scaled={};
 for(const[id,settings]of Object.entries(modes)){
  scaled[id]={};
  for(const[type,profile]of Object.entries(profiles)){
   // Selecting a mode changes numbers only. The 67 keeps its single bar and its original kit.
   scaled[id][type]=id==='normal'?profile:Object.freeze({...profile,
    hp:Math.round(profile.hp*settings.hp),
    ...(profile.phaseHP?{phaseHP:Object.freeze(profile.phaseHP.map(hp=>Math.round(hp*settings.hp)))}:{}),
    windup:profile.windup*settings.windup,
    minWindup:profile.minWindup*settings.windup,
    recovery:Object.freeze(profile.recovery.map(seconds=>seconds*settings.recovery))
   });
  }
  Object.freeze(scaled[id]);
 }
 Object.freeze(scaled);
 function getMode(){return mode;}
 function getSettings(selected=mode){return modes[selected]||modes.normal;}
 function setMode(next){
  if(!Object.hasOwn(modes,next)||window.CampaignRun?.canSetMode?.(next)===false)return false;
  if(next===mode)return true;
  const previous=mode;mode=next;
  try{localStorage.setItem(STORAGE_KEY,mode);}catch{}
  try{window.dispatchEvent(new CustomEvent('difficulty-change',{detail:{mode,previous,settings:getSettings()}}));}catch{}
  return true;
 }
 function boss(type,selected=mode){return (scaled[selected]||scaled.normal)[type]||null;}
 function scaleIncomingDamage(damage,selected=mode){
  const value=Number(damage);
  return Number.isFinite(value)?Math.max(0,value)*getSettings(selected).incomingDamage:0;
 }
 window.Difficulty=Object.freeze({get id(){return mode;},get label(){return getSettings().label;},version:'3.9.0',getMode,getSettings,setMode,isLocked:()=>!!window.CampaignRun?.isEasyLocked?.(),scaleIncomingDamage,boss,modes,profiles});
})();
