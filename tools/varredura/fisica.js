// Física: entra em cada vão (andando e caindo), anda até as bordas do mundo, procura NaN, travas e quedas sem volta.
const { chromium, abrir, comecarC1 } = require('./comum');
(async () => {
  const b = await chromium.launch(); const out = [];
  const { ctx, p, errs } = await abrir(b, { viewport: { width: 960, height: 540 } }, { init: () => { try { localStorage.setItem('daroca-graphics-v1', 'low'); localStorage.setItem('daroca-sandbox-v1', '1'); } catch (e) {} } });
  await comecarC1(p);
  const seg = async (k, ms) => { await p.keyboard.down(k); await p.waitForTimeout(ms); await p.keyboard.up(k); };
  const amostrar = async (f, ms, n = 12) => { const a = []; for (let i = 0; i < n; i++) { await p.waitForTimeout(ms / n); a.push(await p.evaluate(f)); } return a; };
  // ---- campanha 1: vãos do world.js
  const gapsC1 = await p.evaluate(() => (window.WorldData?.gaps || []).map((g) => g.map(([x, w]) => [x, w])));
  for (let s = 0; s < gapsC1.length; s++) for (const [gx, gw] of gapsC1[s]) {
    await p.evaluate(([s, x]) => __go(s, x), [s, gx - 60]); await p.waitForTimeout(250);
    const hp0 = await p.evaluate(() => __pl().hp);
    await p.keyboard.down('d'); const a = await amostrar(() => { const P = __pl(); return [Math.round(P.x), Math.round(P.y), P.hp]; }, 2600); await p.keyboard.up('d');
    const ys = a.map((v) => v[1]), fim = a[a.length - 1];
    out.push({ c: 1, s, gap: [gx, gw], maxY: Math.max(...ys), fim, hp0, nan: a.some((v) => v.some((x) => !Number.isFinite(x))) });
  }
  // bordas do mundo C1: anda pra fora dos dois lados
  for (let s = 0; s < gapsC1.length; s++) {
    const W = await p.evaluate((s) => WorldData.widths[s], s);
    await p.evaluate(([s]) => __go(s, 80), [s]); await seg('a', 900); const e = await p.evaluate(() => [Math.round(__pl().x), Math.round(__pl().y), __mundo().scene]);
    await p.evaluate(([s, W]) => __go(s, W - 80), [s, W]); await seg('d', 900); const d = await p.evaluate(() => [Math.round(__pl().x), Math.round(__pl().y), __mundo().scene]);
    out.push({ c: 1, s, borda: { W, esq: e, dir: d } });
  }
  // ---- campanha 2
  await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} }); await p.waitForTimeout(300);
  await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'zerou', cena: 14, x: 2200, hp: 100, flags: { embarcou: 1, zerou: 1, venceu_jorge: 1 } })); window.Campanha2.abrir({}); }); await p.waitForTimeout(2500);
  for (let k = 0; k < 6; k++) { await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|continuar|ok/i.test(b.textContent)) b.click(); }); await p.waitForTimeout(150); }
  const lista = await p.evaluate(() => window.CampanhaCenarios.lista.map((d) => ({ id: d.id, w: d.largura, vaos: d.vaos, plat: d.plataformas.length, lim: d.limites })));
  for (const L of lista) {
    for (const [gx, gw] of L.vaos || []) for (const lado of ['esq', 'dir']) {
      await p.evaluate(([id, x]) => __c2go(id, x), [L.id, lado === 'esq' ? gx - 50 : gx + gw + 50]); await p.waitForTimeout(250);
      const k = lado === 'esq' ? 'd' : 'a'; await p.keyboard.down(k);
      const a = await amostrar(() => { const P = __c2P(); return [Math.round(P.x), Math.round(P.y), Math.round(P.hp)]; }, 3000, 15); await p.keyboard.up(k);
      const ys = a.map((v) => v[1]); out.push({ c: 2, id: L.id, gap: [gx, gw], lado, maxY: Math.max(...ys), quedas: a.filter((v, i) => i && v[2] < a[i - 1][2]).length, fim: a[a.length - 1], nan: a.some((v) => v.some((x) => !Number.isFinite(x))) });
    }
    // bordas
    await p.evaluate(([id]) => __c2go(id, 60), [L.id]); await seg('a', 800); const e = await p.evaluate(() => [Math.round(__c2P().x), Math.round(__c2P().y), __c2D().cena]);
    await p.evaluate(([id, w]) => __c2go(id, w - 60), [L.id, L.w]); await seg('d', 800); const d = await p.evaluate(() => [Math.round(__c2P().x), Math.round(__c2P().y), __c2D().cena]);
    out.push({ c: 2, id: L.id, borda: { w: L.w, lim: L.lim, esq: e, dir: d } });
  }
  console.log(JSON.stringify(out)); console.log('errs', errs); await b.close();
})();
