// Diálogo da Campanha 2 no celular: os botões de toque somem durante a conversa, tocar avança a fala e eles voltam no fim.
const {chromium,devices}=require('playwright');(async()=>{const b=await chromium.launch();const c=await b.newContext(devices['iPhone 13 landscape']);const p=await c.newPage();const errs=[];p.on('pageerror',e=>errs.push(e.message));
await p.route('**/campanha2/jogo.js*',async r=>{const res=await r.fetch();let t=await res.text();t=t.replace('window.Campanha2 = Object.freeze({','window.__c2go=(n,x)=>irPara(n,x);window.__conversa=(npc)=>conversa(npc);window.Campanha2 = Object.freeze({');r.fulfill({response:res,body:t});});
await p.addInitScript(()=>{localStorage.setItem('daroca-sandbox-v1','1');localStorage.setItem('daroca-c2-save',JSON.stringify({v:1,passo:'zerou',cena:14,x:2200,hp:100,flags:{embarcou:1,zerou:1,venceu_jorge:1}}));});
await p.goto('http://127.0.0.1:8080/');await p.waitForTimeout(1800);
await p.evaluate(()=>window.Campanha2.abrir({}));await p.waitForTimeout(2000);
const vis=()=>p.evaluate(()=>{const e=document.querySelector('#c2GameShell .touch-controls');return e?{op:getComputedStyle(e).opacity,pe:getComputedStyle(e).pointerEvents,cls:document.querySelector('.c2j').classList.contains('c2-dialogo')}:'sem controles'});
console.log('antes',await vis());await p.screenshot({path:'d-0.png'});
await p.evaluate(()=>window.__conversa({x:2300,quem:'c2_lurdes',falas:[['c2_lurdes','Oi, Da Roça! Tudo bem?'],['daroca','Tudo certo, Dona Lurdes!']]}));await p.waitForTimeout(800);
console.log('conversa',await vis());await p.screenshot({path:'d-1.png'});
// toca na tela para avançar (onde ficavam os botões)
for(let i=0;i<6;i++){await p.touchscreen.tap(700,300);await p.waitForTimeout(500);}
await p.waitForTimeout(800);console.log('depois',await vis(),'cutscene',await p.evaluate(()=>Campanha2.estado().cutscene));await p.screenshot({path:'d-2.png'});
console.log('errs',errs);await b.close();})();
