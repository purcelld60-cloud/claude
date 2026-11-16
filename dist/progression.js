/* Persistent RPG levels and freely allocated attributes. */
(() => {
'use strict';
const keys=['vigor','forca','gas','agilidade'];
const defaults=()=>({level:1,xp:0,totalXP:0,points:0,stats:{vigor:0,forca:0,gas:0,agilidade:0},rewards:[]});
let state=defaults();
const clamp=(n,a,b)=>Math.max(a,Math.min(b,n));
const need=level=>level>=50?0:Math.floor(60+level*35+Math.pow(level,1.5)*12);
function getState(){return{level:state.level,xp:state.xp,totalXP:state.totalXP,points:state.points,nextXP:need(state.level),stats:{...state.stats}};}
function emit(levelsGained=0,reason='update'){try{window.dispatchEvent(new CustomEvent('progression-change',{detail:{...getState(),state:getState(),levelsGained,reason}}));}catch{}}
function restore(data){state=defaults();if(data&&typeof data==='object'){state.level=clamp(Math.floor(Number(data.level)||1),1,50);state.xp=clamp(Math.floor(Number(data.xp)||0),0,100000);state.totalXP=clamp(Math.floor(Number(data.totalXP)||0),0,10000000);state.points=clamp(Math.floor(Number(data.points)||0),0,250);for(const k of keys)state.stats[k]=clamp(Math.floor(Number(data.stats?.[k])||0),0,40);state.rewards=Array.isArray(data.rewards)?[...new Set(data.rewards.filter(x=>typeof x==='string'))].slice(-2500):[];while(state.level<50&&state.xp>=need(state.level)){state.xp-=need(state.level);state.level++;state.points+=2;}}if(state.level===50)state.xp=0;Promise.resolve().then(()=>emit(0,'restore'));return getState();}
function award(xp,sourceId=null){const amount=clamp(Math.floor(Number(xp)||0),0,10000);if(!amount||sourceId&&state.rewards.includes(String(sourceId)))return{...getState(),levelsGained:0,awarded:0};if(sourceId)state.rewards.push(String(sourceId));state.rewards=state.rewards.slice(-2500);state.totalXP+=amount;if(state.level<50)state.xp+=amount;let gained=0;while(state.level<50&&state.xp>=need(state.level)){state.xp-=need(state.level);state.level++;state.points+=2;gained++;}if(state.level===50)state.xp=0;emit(gained,'award');return{...getState(),levelsGained:gained,awarded:amount};}
function spend(stat){if(!keys.includes(stat)||state.points<1||state.stats[stat]>=40)return false;state.points--;state.stats[stat]++;emit(0,'spend');return true;}
function bonuses(){const s=state.stats;return{maxHP:100+s.vigor*24,maxGas:100+s.gas*20,damageMultiplier:1+s.forca*.11+(state.level-1)*.005,moveSpeed:280+s.agilidade*8+(state.level-1),dashCooldown:Math.max(.48,1.1-s.agilidade*.055),projectileTier:state.level>=7?2:state.level>=3?1:0,gasRegen:16+s.gas*1.2,airGasRegen:6+s.gas*.35};}
function serialize(){return{...getState(),stats:{...state.stats},rewards:[...state.rewards]};}
window.Progression=Object.freeze({restore,getState,award,spend,bonuses,serialize});
})();
