// Saves ruins: corrompe cada chave do jogo e confere se abre, joga, salva e volta sem erro (nem NaN na tela).
const { chromium, abrir } = require('./comum');
const LIXO = ['{{{', 'null', '[]', '123', '"texto"', '{}', 'NaN', 'undefined', '{"a":', ''];
const C1 = [
  { q: null }, { q: 'x' }, { q: [] }, { q: { lucas: true }, scene: 99, x: 'abc' }, { q: { lucas: true }, scene: -3, x: -9999 }, { q: { lucas: true }, scene: '2', x: 1e12 },
  { q: { carParts: 'x', notebooks: 5, npcVisits: [1], bivoltParts: {}, bivoltCharges: 'muito', roteiros: 7 } },
  { q: { lucas: true }, progression: { xp: 'abc', level: -3, points: 1e9, stats: { vigor: 'x', forca: -5, gas: null } } },
  { q: { lucas: true }, progression: 'quebrado', items: { pencil: -5, eraser: 'x' }, seenBossIntros: 'x', run: 5 },
  { q: { lucas: true, nikolas: true, jorgeSeen: true, celebrationSeen: true }, scene: 11, x: 300, hp: 'x' },
];
const C2 = [{ v: 1, passo: 'naoexiste' }, { v: 1, passo: 'tonhao', cena: 999, x: 'a' }, { v: 2, passo: 'tonhao' }, { v: 1, passo: 'tonhao', flags: null, hp: 'NaN' }, { v: 1, passo: 'zerou', cena: -1, x: 1e9, flags: 'x', progressao: 'quebrado' }, { v: 1, passo: 'jorge', cena: 14, x: 1820, flags: { venceu_creuza: 'sim' }, hp: -50 }];
(async () => {
  const b = await chromium.launch(); const prob = [];
  async function rodada(nome, prep) {
    const { ctx, p, errs, cons } = await abrir(b, { viewport: { width: 1280, height: 720 } }, { init: prep });
    let etapa = 'abrir';
    try {
      etapa = 'C1'; await p.evaluate(() => document.getElementById('menuJogarBtn')?.click()); await p.waitForTimeout(200);
      await p.evaluate(() => { const c = document.getElementById('continueBtn'); (c && c.offsetParent ? c : document.getElementById('startBtn')).click(); }); await p.waitForTimeout(400);
      await p.evaluate(() => document.querySelector('.dr-confirma .sim')?.click()); await p.waitForTimeout(1500);
      for (let k = 0; k < 6; k++) { await p.evaluate(() => { try { Game.closeDialogue?.(); } catch (e) {} for (const b of document.querySelectorAll('button')) if (b.offsetParent && /Pular história|BORA CONTINUAR/i.test(b.textContent)) b.click(); }); await p.waitForTimeout(120); }
      await p.keyboard.down('d'); await p.waitForTimeout(500); await p.keyboard.up('d'); await p.keyboard.press('j'); await p.waitForTimeout(300);
      const st = await p.evaluate(() => { const s = Game.getState(), P = __pl(), m = __mundo(); return { started: s.started, x: P.x, y: P.y, hp: P.hp, scene: m.scene, W: m.W, texto: /NaN|undefined|\[object Object\]/.test(document.querySelector('#gameShell')?.innerText || '') ? (document.querySelector('#gameShell').innerText.match(/.{0,30}(NaN|undefined|\[object Object\]).{0,30}/) || [''])[0] : '' }; });
      if (!st.started || ![st.x, st.y, st.hp, st.W].every(Number.isFinite) || st.scene < 0 || st.scene > 11 || st.texto) prob.push({ nome, etapa, st });
      etapa = 'C1 salvar'; await p.evaluate(() => { Game.returnToMenu?.(); }); await p.waitForTimeout(300);
      const salvo = await p.evaluate(() => { try { const d = JSON.parse(localStorage.getItem('da-roca-adventure-v1')); return d && typeof d.q === 'object' && !Array.isArray(d.q) ? 'ok' : 'save ruim: ' + localStorage.getItem('da-roca-adventure-v1')?.slice(0, 80); } catch (e) { return 'save ilegível'; } });
      if (salvo !== 'ok') prob.push({ nome, etapa, salvo });
      etapa = 'C2'; await p.evaluate(() => { if (!localStorage.getItem('daroca-sandbox-v1')) localStorage.setItem('daroca-sandbox-v1', '1'); window.Campanha2.abrir({}); }); await p.waitForTimeout(2200);
      for (let k = 0; k < 6; k++) { await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|ok/i.test(b.textContent)) b.click(); }); await p.waitForTimeout(120); }
      await p.keyboard.down('d'); await p.waitForTimeout(500); await p.keyboard.up('d');
      const s2 = await p.evaluate(() => { const P = __c2P(), D = __c2D(); return { x: P.x, y: P.y, hp: P.hp, cena: D.cena, larg: D.d?.largura, passo: Campanha2.estado().passo, texto: (document.querySelector('#c2GameShell, .c2j')?.innerText || '').match(/.{0,30}(NaN|undefined|\[object Object\]).{0,30}/)?.[0] || '' }; });
      if (![s2.x, s2.y, s2.hp, s2.larg].every(Number.isFinite) || s2.texto) prob.push({ nome, etapa, s2 });
      await p.evaluate(() => Campanha2.fechar?.()); await p.waitForTimeout(300);
    } catch (e) { prob.push({ nome, etapa, exc: e.message.slice(0, 200) }); }
    if (errs.length || cons.size) prob.push({ nome, errs: errs.slice(0, 3), cons: [...cons].slice(0, 3) });
    await ctx.close();
  }
  for (const v of LIXO) await rodada('C1 lixo ' + JSON.stringify(v), new Function(`if(!sessionStorage.k){sessionStorage.k=1;localStorage.setItem('da-roca-adventure-v1',${JSON.stringify(v)});localStorage.setItem('daroca-sandbox-v1','1');}`));
  for (const v of C1) await rodada('C1 ' + JSON.stringify(v).slice(0, 70), new Function(`if(!sessionStorage.k){sessionStorage.k=1;localStorage.setItem('da-roca-adventure-v1',${JSON.stringify(JSON.stringify(v))});localStorage.setItem('daroca-sandbox-v1','1');}`));
  for (const v of LIXO) await rodada('C2 lixo ' + JSON.stringify(v), new Function(`if(!sessionStorage.k){sessionStorage.k=1;localStorage.setItem('daroca-c2-save',${JSON.stringify(v)});localStorage.setItem('daroca-sandbox-v1','1');}`));
  for (const v of C2) await rodada('C2 ' + JSON.stringify(v).slice(0, 70), new Function(`if(!sessionStorage.k){sessionStorage.k=1;localStorage.setItem('daroca-c2-save',${JSON.stringify(JSON.stringify(v))});localStorage.setItem('daroca-sandbox-v1','1');}`));
  // todas as outras chaves com lixo ao mesmo tempo
  const outras = ['daroca-weather-v1', 'daroca-volumes-v1', 'daroca-visual-v1', 'daroca-screen-fit', 'daroca-fliperama-v1', 'daroca-c2-vencidos', 'daroca-graphics-v1', 'daroca-difficulty-v1', 'daroca-daytime-v1', 'daroca-controls-v1', 'daroca-campaign-layout-v1', 'daroca-c2-poderes', 'daroca-c2-loja', 'daroca-c2-layout-v2', 'daroca-c2-conhecidos', 'daroca-arena-layout-v1', 'daroca-music-enabled', 'daroca-music-config-cache-v1', 'daroca-native-resume'];
  for (const v of ['{{{', 'null', '[]', '{"x":1}', '-1', 'NaN']) await rodada('outras=' + v, new Function(`if(!sessionStorage.k){sessionStorage.k=1;for(const k of ${JSON.stringify(outras)})localStorage.setItem(k,${JSON.stringify(v)});localStorage.setItem('daroca-sandbox-v1','1');localStorage.setItem('da-roca-adventure-v1',JSON.stringify({q:{lucas:true},scene:0,x:600}));}`));
  console.log(JSON.stringify(prob, null, 1)); console.log('problemas:', prob.length); await b.close();
})();
