// Luta da Campanha 2 pelo caminho real (menu → Campanha 2 → anda até a arena → cutscene → luta): o Da Roça precisa andar na luta, no teclado e no toque.
const {chromium,devices}=require('playwright');(async()=>{const b=await chromium.launch();
for(const [n,d] of [['pc',{viewport:{width:1280,height:720}}],['cel',devices['iPhone 13 landscape']]]){
const c=await b.newContext(d);const p=await c.newPage();const errs=[];p.on('pageerror',e=>errs.push(e.message));
await p.route('**/campanha2/jogo.js*',async r=>{const res=await r.fetch();let t=await res.text();t=t.replace('window.Campanha2 = Object.freeze({','window.__c2go=(n,x)=>irPara(n,x);window.__fase=()=>fase&&{l:fase.arena?.l,F:fase.F&&{cena:fase.F.cena,checkpoint:fase.F.checkpoint},bx:fase.chefe?.x};window.Campanha2 = Object.freeze({');r.fulfill({response:res,body:t});});
await p.addInitScript(()=>{localStorage.setItem('daroca-sandbox-v1','1');localStorage.setItem('daroca-c2-save',JSON.stringify({v:1,passo:'tonhao',cena:16,x:2000,hp:100,flags:{embarcou:1,venceu_creuza:1}}));});
await p.goto('http://127.0.0.1:8080/');await p.waitForTimeout(1800);
// entra na Campanha 2 pelo menu, como o jogador
await p.evaluate(()=>document.getElementById('menuJogarBtn').click());await p.waitForTimeout(300);await p.evaluate(()=>document.querySelector('[data-open-campanha2]').click());await p.waitForTimeout(400);await p.evaluate(()=>document.querySelector('#c2Painel [data-a="cont"]').click());await p.waitForTimeout(2500);
console.log(n,'fase',JSON.stringify(await p.evaluate(()=>window.__fase())));
await p.evaluate(()=>window.__c2go(16,4840));await p.waitForTimeout(300);// anda até a arena
for(let i=0;i<40&&!(await p.evaluate(()=>Campanha2.estado().cutscene||Campanha2.emLuta()));i++){await p.keyboard.down('d');await p.waitForTimeout(250);}
await p.keyboard.up('d');console.log(n,'cutscene',await p.evaluate(()=>Campanha2.estado().cutscene),'x',await p.evaluate(()=>Campanha2.estado().x));
// pula a cutscene
for(let i=0;i<30&&!(await p.evaluate(()=>Campanha2.emLuta()));i++){await p.evaluate(()=>{const b=[...document.querySelectorAll('.c2j button')].find(b=>b.offsetParent&&/pular/i.test(b.textContent));b?.click();});await p.keyboard.press('Enter');await p.waitForTimeout(300);}
await p.waitForTimeout(1200);
const st=()=>p.evaluate(()=>{const s=Game.getState();return {x:Math.round(s.player.x),y:Math.round(s.player.y),skin:!!C2Luta.skin,arena:!!s.arena,started:s.started,c2:Campanha2.aberto(),emLuta:Campanha2.emLuta()}});
const a=await st();
if(n==='pc'){await p.keyboard.down('a');await p.waitForTimeout(700);await p.keyboard.up('a');}
else{const j=await p.evaluate(()=>{const e=document.getElementById('moveJoystick');if(!e||!e.offsetParent)return null;const q=e.getBoundingClientRect();return [q.x+q.width/2,q.y+q.height/2];});console.log('joystick',j);
 if(j){const cdp=await c.newCDPSession(p);const t=(type,x,y)=>cdp.send('Input.dispatchTouchEvent',{type,touchPoints:type==='touchEnd'?[]:[{x,y,id:1}]});await t('touchStart',j[0],j[1]);for(let k=1;k<=6;k++){await t('touchMove',j[0]-k*8,j[1]);await p.waitForTimeout(40);}await p.waitForTimeout(700);await t('touchEnd');}}
console.log(n,'na luta',a,'depois de andar',await st(),'errs',errs);await p.screenshot({path:`real-${n}.png`});
await c.close();}
await b.close();})();
