// Ajudantes da varredura: abre o jogo com ganchos de teleporte (C1 e C2) e mede faixas vazias no canvas.
const { chromium, devices } = require('playwright');
async function abrir(b, ctxo, opts = {}) {
  const ctx = await b.newContext(ctxo); const p = await ctx.newPage(); const errs = [], cons = new Map();
  p.on('pageerror', (e) => errs.push(e.message));
  p.on('console', (m) => { if (m.type() === 'error' && !/Failed to load resource/.test(m.text())) { const k = m.text().slice(0, 160); cons.set(k, (cons.get(k) || 0) + 1); } });
  await p.route('**/game.js*', async (r) => { const res = await r.fetch(); let t = await res.text();
    t = t.replace('window.Game={', 'window.__go=(n,x,y)=>{scene=n;resetWorldSize();player.x=x;player.y=y??FLOOR;player.vx=0;player.vy=0;vehicle=false;room=null;arena=null;camera=Math.max(0,Math.min(WORLD-W,player.x-W*.36));};window.__pl=()=>player;window.__mundo=()=>({W:WORLD,FLOOR,scene,camera});window.Game={');
    r.fulfill({ response: res, body: t }); });
  await p.route('**/campanha2/jogo.js*', async (r) => { const res = await r.fetch(); let t = await res.text();
    t = t.replace('window.Campanha2 = Object.freeze({', 'window.__c2go=(n,x)=>irPara(n,x);window.__c2P=()=>P;window.__c2D=()=>({cena:cenaId,cam,d:D()});window.Campanha2 = Object.freeze({');
    r.fulfill({ response: res, body: t }); });
  if (opts.init) await p.addInitScript(opts.init);
  await p.goto('http://127.0.0.1:8080/' + (opts.q || '')); await p.waitForTimeout(1800);
  return { ctx, p, errs, cons };
}
// começa a campanha 1 pulando a história
async function comecarC1(p) {
  await p.evaluate(() => document.getElementById('menuJogarBtn')?.click()); await p.waitForTimeout(200);
  await p.evaluate(() => (document.getElementById('continueBtn')?.offsetParent ? document.getElementById('continueBtn') : document.getElementById('startBtn')).click()); await p.waitForTimeout(500);
  await p.evaluate(() => document.querySelector('.dr-confirma .sim')?.click()); await p.waitForTimeout(1000);
  for (let k = 0; k < 10; k++) { for (const label of [/NÃO, BORA CONTINUAR/, /Pular história/i]) { const l = p.locator('button:visible', { hasText: label }).first(); if (await l.count()) { await l.click().catch(() => {}); await p.waitForTimeout(150); } }
    await p.evaluate(() => { try { Game.closeDialogue?.(); } catch (e) {} }); await p.waitForTimeout(100); }
}
// mede o canvas: colunas e linhas "mortas" (transparentes, pretas chapadas ou de uma cor só)
const medir = (sel) => { const cv = document.querySelector(sel); if (!cv) return null; const c = cv.getContext('2d'); if (!c) return { semCtx: true }; const w = cv.width, h = cv.height, d = c.getImageData(0, 0, w, h).data;
  const px = (x, y) => { const i = (y * w + x) * 4; return [d[i], d[i + 1], d[i + 2], d[i + 3]]; };
  const morta = (arr) => { const [r0, g0, b0, a0] = arr[0]; let uni = true, transp = 0; for (const [r, g, b, a] of arr) { if (a < 250) transp++; if (Math.abs(r - r0) + Math.abs(g - g0) + Math.abs(b - b0) > 6) uni = false; } return transp > arr.length * .5 ? 'transparente' : uni ? `uniforme(${r0},${g0},${b0})` : null; };
  const cols = [], rows = [];
  for (let x = 0; x < w; x += 2) { const a = []; for (let y = 0; y < h; y += 3) a.push(px(x, y)); const m = morta(a); if (m) cols.push([x, m]); }
  for (let y = 0; y < h; y += 2) { const a = []; for (let x = 0; x < w; x += 3) a.push(px(x, y)); const m = morta(a); if (m && !/^uniforme/.test(m) || (m && y > h * .25)) rows.push([y, m]); }
  let transp = 0; for (let i = 3; i < d.length; i += 4 * 37) if (d[i] < 250) transp++;
  return { w, h, cols: cols.length, colEx: cols.slice(0, 3), rows: rows.length, rowEx: rows.slice(0, 3), transp: transp / (d.length / 4 / 37) };
};
module.exports = { chromium, devices, abrir, comecarC1, medir };
