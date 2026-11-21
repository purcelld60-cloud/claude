// Teste do macaco: aperta teclas aleatórias por um tempo em cada modo e procura erros, NaN, quedas e trava.
const { chromium, devices, abrir, comecarC1 } = require('./comum');
const TECLAS = ['a', 'd', 'w', 's', ' ', 'j', 'k', 'l', 'e', 't', 'v', 'Escape', 'Enter', 'q', 'r'];
(async () => {
  const b = await chromium.launch(); const rel = [];
  const { p, errs, cons } = await abrir(b, devices['iPhone 13 landscape'], { init: () => { try { localStorage.setItem('daroca-sandbox-v1', '1'); localStorage.setItem('daroca-graphics-v1', 'medium'); } catch (e) {} } });
  await comecarC1(p);
  let semente = 7; const rnd = () => ((semente = (semente * 16807) % 2147483647) / 2147483647);
  async function macaco(nome, ms, estado) {
    const t0 = Date.now(), ruins = []; let n = 0, parado = 0, ultimo = null;
    while (Date.now() - t0 < ms) {
      const k = TECLAS[Math.floor(rnd() * TECLAS.length)], dur = 40 + rnd() * 400; if (k === 'Escape' && rnd() < .7) continue;
      await p.keyboard.down(k); await p.waitForTimeout(dur); await p.keyboard.up(k); n++;
      if (n % 5 === 0) { // fecha menus abertos por acaso para continuar jogando
        await p.evaluate(() => { for (const b of document.querySelectorAll('#resumeBtn, .dr-confirma .nao')) if (b.offsetParent) b.click(); try { Game.closeDialogue?.(); } catch (e) {} });
        const s = await p.evaluate(estado); if (s.ruim) ruins.push(s);
        const pos = JSON.stringify(s.pos); if (pos === ultimo) parado++; else parado = 0; ultimo = pos; }
    }
    rel.push({ nome, teclas: n, ruins: ruins.slice(0, 4), paradoMuito: parado > 30 });
  }
  const est1 = () => { const P = __pl(), m = __mundo(); const ok = [P.x, P.y, P.hp, P.vx, P.vy].every(Number.isFinite) && P.y < 700 && P.x >= -50 && P.x <= m.W + 50; return { ruim: !ok && { x: P.x, y: P.y, hp: P.hp, scene: m.scene }, pos: [Math.round(P.x), Math.round(P.y)] }; };
  await macaco('C1 roça', 60000, est1);
  await p.evaluate(() => Game.startSandboxBoss('freddy')); await p.waitForTimeout(1500);
  await macaco('C1 luta Freddy', 45000, est1); await p.evaluate(() => { try { Game.exitSandbox(); } catch (e) {} });
  await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} });
  await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'zerou', cena: 16, x: 1500, hp: 100, flags: { embarcou: 1, zerou: 1, venceu_jorge: 1 } })); Campanha2.abrir({}); }); await p.waitForTimeout(2500);
  const est2 = () => { const P = __c2P(), D = __c2D(); const ok = [P.x, P.y, P.hp, P.vx, P.vy].every(Number.isFinite) && P.y < 700; return { ruim: !ok && { x: P.x, y: P.y, hp: P.hp, cena: D.cena }, pos: [Math.round(P.x), Math.round(P.y), D.cena] }; };
  await macaco('C2 cidade', 60000, est2);
  await p.evaluate(() => { Campanha2.fechar(); C2Luta.iniciar({ slug: 'breno', tipo: 'c2_breno', nome: 'BRENO', cena: 19, bossX: 2000 }, () => {}); }); await p.waitForTimeout(1500);
  await macaco('C2 luta Breno (motor C1)', 45000, est1);
  console.log(JSON.stringify(rel, null, 1)); console.log('errs', errs, [...cons]); await b.close();
})();
