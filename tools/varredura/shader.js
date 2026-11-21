// Shaders e qualidades: cada cenário C1/C2 com clima e hora variando; perda de contexto WebGL; troca de qualidade com a C2 aberta.
const { chromium, devices, abrir, comecarC1 } = require('./comum');
const fs = require('fs'); fs.mkdirSync('sh', { recursive: true });
(async () => {
  const b = await chromium.launch(); const res = [];
  const { p, errs, cons } = await abrir(b, devices['iPhone 13 landscape'], { init: () => { try { localStorage.setItem('daroca-graphics-v1', 'high'); } catch (e) {} } });
  await comecarC1(p);
  const brilho = async (nome) => { await p.screenshot({ path: `sh/${nome}.jpg`, type: 'jpeg', quality: 60 }); };
  const W = ['sol', 'chuva', 'neve'];
  for (const q of ['low', 'medium', 'high']) for (let s = 0; s < 12; s++) {
    const r = await p.evaluate(([q, w, h, s]) => { try { Graphics.set(q); Weather.set(w); DayTime.force(h); __go(s, 900 + s * 37); return { lvl: Graphics.level(), shader: Graphics.isShader(), sup: Shader.supported() }; } catch (e) { return 'ERR ' + e.message; } }, [q, W[s % 3], [8, 13, 18, 22][s % 4], s]);
    await p.waitForTimeout(350); await brilho(`c1-${q}-${String(s).padStart(2, '0')}`); res.push({ q, s, r });
  }
  // perda do contexto WebGL com o shader ligado (como no iPhone em segundo plano) e volta
  await p.evaluate(() => { Graphics.set('high'); DayTime.force(13); Weather.set('sol'); __go(0, 900); }); await p.waitForTimeout(400); await brilho('perda-0-antes');
  const perda = await p.evaluate(() => { const cs = [...document.querySelectorAll('canvas')].filter((c) => { try { return !!c.getContext('webgl'); } catch (e) { return false; } }); const out = []; for (const c of cs) { const gl = c.getContext('webgl'); const ext = gl?.getExtension('WEBGL_lose_context'); out.push({ id: c.id || c.className, vis: getComputedStyle(c).display, ext: !!ext }); if (ext) { window.__ext = window.__ext || []; window.__ext.push(ext); ext.loseContext(); } } return out; });
  await p.waitForTimeout(800); await brilho('perda-1-perdido');
  await p.evaluate(() => { for (const e of window.__ext || []) try { e.restoreContext(); } catch (x) {} }); await p.waitForTimeout(1200); await brilho('perda-2-voltou');
  res.push({ perda });
  // C2 com cada qualidade
  await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} });
  await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'zerou', cena: 14, x: 2200, hp: 100, flags: { embarcou: 1, zerou: 1, venceu_jorge: 1 } })); window.Campanha2.abrir({}); }); await p.waitForTimeout(2500);
  const ids = await p.evaluate(() => CampanhaCenarios.lista.map((d) => d.id));
  for (const q of ['low', 'high']) for (const id of ids) { await p.evaluate(([q, id, w, h]) => { Graphics.set(q); Weather.set(w); DayTime.force(h); __c2go(id, 1200); }, [q, id, W[id % 3], [8, 13, 18, 22][id % 4]]); await p.waitForTimeout(300); await brilho(`c2-${q}-${id}`); }
  fs.writeFileSync('shader.json', JSON.stringify({ res, errs, cons: [...cons] }, null, 1)); console.log(JSON.stringify({ perda, errs, cons: [...cons], amostra: res.slice(24, 30) }));
  await b.close();
})();
