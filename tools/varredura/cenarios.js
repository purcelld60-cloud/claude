// Cenários da campanha 1 e 2: bordas e meio, em PC e celular. Fotos + medição de faixas vazias.
const { chromium, devices, abrir, comecarC1, medir } = require('./comum');
const fs = require('fs'); fs.mkdirSync('fotos', { recursive: true });
(async () => {
  const b = await chromium.launch(); const achados = [];
  for (const [nome, ctxo] of [['pc', { viewport: { width: 1280, height: 720 } }], ['cel', devices['iPhone 13 landscape']], ['ret', devices['iPhone 13']]]) {
    const { ctx, p, errs, cons } = await abrir(b, ctxo, { init: () => { try { localStorage.setItem('daroca-graphics-v1', 'medium'); localStorage.setItem('daroca-sandbox-v1', '1'); } catch (e) {} } });
    await comecarC1(p);
    const n = await p.evaluate(() => window.WorldData?.widths?.length || 12);
    for (let s = 0; s < n; s++) {
      const W = await p.evaluate((s) => window.WorldData.widths[s], s);
      for (const [rot, x] of [['esq', 20], ['meio', W / 2], ['dir', W - 20]]) {
        await p.evaluate(([s, x]) => { __go(s, x); }, [s, x]); await p.waitForTimeout(450);
        const st = await p.evaluate(() => ({ pl: { x: Math.round(__pl().x), y: Math.round(__pl().y) }, m: __mundo() }));
        const med = await p.evaluate(medir, '#gameCanvas');
        if (med && (med.cols > 4 || med.rows > 6 || med.transp > .02)) achados.push({ nome, s, rot, med });
        await p.screenshot({ path: `fotos/c1-${nome}-${String(s).padStart(2, '0')}-${rot}.jpg`, type: 'jpeg', quality: 70 });
      }
    }
    // campanha 2
    await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} }); await p.waitForTimeout(400);
    await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'zerou', cena: 14, x: 2200, hp: 100, flags: { embarcou: 1, zerou: 1, venceu_jorge: 1 } })); window.Campanha2.abrir({}); }); await p.waitForTimeout(2500);
    for (let k = 0; k < 6; k++) { await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|continuar|ok/i.test(b.textContent)) b.click(); }); await p.waitForTimeout(150); }
    const lista = await p.evaluate(() => (window.CampanhaCenarios?.lista || []).map((d) => ({ id: d.id, w: d.width || window.CampanhaCenarios.largura(d.id), nome: d.nome || d.title || '' })));
    for (const L of lista) {
      for (const [rot, x] of [['esq', 10], ['meio', L.w / 2], ['dir', L.w - 10]]) {
        const ok = await p.evaluate(([id, x]) => { try { __c2go(id, x); return true; } catch (e) { return e.message; } }, [L.id, x]); await p.waitForTimeout(450);
        const st = await p.evaluate(() => { const P = __c2P(); return { x: Math.round(P.x), y: Math.round(P.y), cena: __c2D().cena }; });
        const med = await p.evaluate(medir, '.c2j canvas, #c2GameShell canvas');
        if (ok !== true) achados.push({ nome, c2: L.id, rot, erro: ok });
        if (med && (med.cols > 4 || med.rows > 6 || med.transp > .02)) achados.push({ nome, c2: L.id, rot, med });
        await p.screenshot({ path: `fotos/c2-${nome}-${String(L.id).padStart(2, '0')}-${rot}.jpg`, type: 'jpeg', quality: 70 });
      }
    }
    achados.push({ nome, errs, cons: [...cons] }); await ctx.close();
  }
  fs.writeFileSync('cenarios.json', JSON.stringify(achados, null, 1)); console.log(JSON.stringify(achados).slice(0, 4000)); await b.close();
})();
