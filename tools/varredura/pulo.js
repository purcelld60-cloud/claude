const { chromium, abrir, comecarC1 } = require('./comum');
(async () => { const b = await chromium.launch(); const { p, errs } = await abrir(b, { viewport: { width: 960, height: 540 } }, { init: () => { try { localStorage.setItem('daroca-graphics-v1', 'low'); } catch (e) {} } });
 await comecarC1(p); await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} });
 await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'zerou', cena: 14, x: 2200, hp: 100, flags: { embarcou: 1, zerou: 1, venceu_jorge: 1 } })); window.Campanha2.abrir({}); }); await p.waitForTimeout(2500);
 const lista = await p.evaluate(() => window.CampanhaCenarios.lista.filter((d) => d.vaos.length).map((d) => ({ id: d.id, vaos: d.vaos, plat: d.plataformas })));
 for (const L of lista) for (const [gx, gw] of L.vaos) for (const modo of ['pulo', 'pulo+dash']) {
   await p.evaluate(([id, x]) => { __c2go(id, x); __c2P().hp = 100; }, [L.id, gx - 90]); await p.waitForTimeout(300);
   await p.keyboard.down('d'); await p.waitForTimeout(250); await p.keyboard.press(' '); if (modo !== 'pulo') { await p.waitForTimeout(160); await p.keyboard.press('l'); } await p.waitForTimeout(1300); await p.keyboard.up('d');
   const r = await p.evaluate(() => { const P = __c2P(); return [Math.round(P.x), Math.round(P.y), Math.round(P.hp)]; });
   const plats = L.plat.filter(([px, py, pw]) => px + pw > gx - 250 && px < gx + gw + 250).map((q) => q.join('/')).join(' ');
   console.log(L.id, [gx, gw], modo, '→', r, r[2] < 100 ? 'CAIU' : r[0] > gx + gw ? 'atravessou' : '?', '| plataformas perto:', plats);
 }
 console.log('errs', errs); await b.close(); })();
