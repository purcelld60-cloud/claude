// Botões: em cada tela e aparelho, confere se cada botão visível está dentro da tela, não está coberto e tem tamanho de dedo.
const { chromium, devices, abrir, comecarC1 } = require('./comum');
const fs = require('fs'); fs.mkdirSync('bt', { recursive: true });
const checar = (tela) => {
  const vw = innerWidth, vh = innerHeight, out = [], vis = [];
  const els = [...document.querySelectorAll('button, [role=button], a[href], input, select, .ctrl, [data-action]')];
  for (const el of els) {
    const r = el.getBoundingClientRect(), cs = getComputedStyle(el);
    if (r.width < 2 || r.height < 2 || cs.visibility === 'hidden' || cs.display === 'none' || +cs.opacity === 0) continue;
    let p = el, escondido = false; while (p) { const s = getComputedStyle(p); if (s.display === 'none' || s.visibility === 'hidden' || +s.opacity === 0 || p.hidden) { escondido = true; break; } p = p.parentElement; } if (escondido) continue;
    const nome = (el.id ? '#' + el.id + ' ' : '') + (el.getAttribute('aria-label') || el.textContent || el.dataset.action || el.className || '').replace(/\s+/g, ' ').trim().slice(0, 28);
    vis.push(nome);
    let fora = r.left < -1 || r.top < -1 || r.right > vw + 1 || r.bottom > vh + 1;
    if (fora) { let q = el.parentElement; while (q && q !== document.documentElement) { const s = getComputedStyle(q); if (/(auto|scroll)/.test(s.overflowY + s.overflowX) && (q.scrollHeight > q.clientHeight + 2 || q.scrollWidth > q.clientWidth + 2)) { const qr = q.getBoundingClientRect(); if (qr.top >= -1 && qr.bottom <= vh + 1 && qr.left >= -1 && qr.right <= vw + 1) { fora = false; break; } } q = q.parentElement; } }
    if (!fora && (r.bottom > vh + 1 || r.top < -1)) continue; // dá para rolar até ele: não mede cobertura nem tamanho agora
    const cx = Math.min(vw - 1, Math.max(0, r.left + r.width / 2)), cy = Math.min(vh - 1, Math.max(0, r.top + r.height / 2)), top = document.elementFromPoint(cx, cy);
    const coberto = top && !el.contains(top) && !top.contains(el) && !(el.getRootNode() !== document) && !(top.closest('label') && top.closest('label').contains(el));
    let atras = false; if (coberto) { let q = top; while (q && q !== document.body) { const rr = q.getBoundingClientRect(); if (rr.width * rr.height > vw * vh * .35 && !q.contains(el)) { atras = true; break; } q = q.parentElement; } }
    if (atras) continue; // está atrás de um painel aberto: normal
    const pequeno = (r.width < 30 || r.height < 30) && matchMedia('(pointer:coarse)').matches;
    if (fora || coberto || pequeno) out.push({ tela, nome, r: [Math.round(r.left), Math.round(r.top), Math.round(r.width), Math.round(r.height)], fora, coberto: coberto ? (top.id ? '#' + top.id : top.className || top.tagName).toString().slice(0, 40) : false, pequeno });
  }
  return { out, n: vis.length };
};
(async () => {
  const b = await chromium.launch(); const tudo = [];
  const aparelhos = [['pc', { viewport: { width: 1280, height: 720 } }], ['pc-fhd', { viewport: { width: 1920, height: 1080 } }], ['iphone13', devices['iPhone 13 landscape']], ['iphoneSE', devices['iPhone SE landscape']], ['ipad', devices['iPad (gen 7) landscape']], ['pixel5', devices['Pixel 5 landscape']]];
  for (const [nome, ctxo] of aparelhos) {
    const { ctx, p, errs } = await abrir(b, ctxo, { init: () => { try { localStorage.setItem('daroca-sandbox-v1', '1'); localStorage.setItem('da-roca-adventure-v1', JSON.stringify({ q: { lucas: true }, scene: 0, x: 600 })); } catch (e) {} } });
    const ver = async (tela) => { const r = await p.evaluate(checar, tela); tudo.push(...r.out.map((x) => ({ ap: nome, ...x }))); await p.screenshot({ path: `bt/${nome}-${tela}.jpg`, type: 'jpeg', quality: 55 }); return r.n; };
    const clicar = async (sel) => { await p.evaluate((sel) => { const e = document.querySelector(sel); e?.click(); return !!e; }, sel); await p.waitForTimeout(350); };
    const clicarTexto = async (re) => { await p.evaluate((re) => { const e = [...document.querySelectorAll('button')].find((b) => b.offsetParent && new RegExp(re, 'i').test(b.textContent)); e?.click(); }, re); await p.waitForTimeout(350); };
    await ver('inicio');
    await clicar('#menuJogarBtn'); await ver('jogar');
    await clicar('.me-mais'); await ver('jogar-mais'); await clicar('.me-voltar');
    await clicar('#menuMultiBtn'); await ver('multi'); await clicar('.me-voltar');
    await clicar('#menuJogarBtn'); await clicar('#startBtn'); await ver('aviso-save'); await clicar('.dr-confirma .nao');
    await comecarC1(p); await p.waitForTimeout(500); await ver('c1-jogo');
    await clicar('#pauseBtn'); await ver('c1-pausa');
    await clicarTexto('OPÇÕES'); await ver('c1-opcoes');
    await clicarTexto('CONTROLES E TECLAS'); await ver('c1-controles'); await p.keyboard.press('Escape'); await p.waitForTimeout(300);
    await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} }); await p.waitForTimeout(300);
    await p.evaluate(() => { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo: 'tonhao', cena: 16, x: 1500, hp: 100, flags: { embarcou: 1, venceu_creuza: 1 } })); }); await clicar('#menuJogarBtn'); await clicar('[data-open-campanha2]'); await ver('c2-painel');
    await clicar('#c2Painel [data-a="cont"]'); await p.waitForTimeout(1800); for (let k = 0; k < 6; k++) { await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|ok/i.test(b.textContent)) b.click(); }); await p.waitForTimeout(150); }
    await ver('c2-jogo');
    await clicar('#c2GameShell #pauseBtn'); await ver('c2-pausa');
    tudo.push({ ap: nome, errs }); await ctx.close();
  }
  fs.writeFileSync('botoes.json', JSON.stringify(tudo, null, 1));
  const resumo = {}; for (const x of tudo) if (x.tela) { const k = `${x.ap} ${x.tela}`; (resumo[k] = resumo[k] || []).push(`${x.nome}${x.fora ? ' [FORA]' : ''}${x.coberto ? ' [COBERTO por ' + x.coberto + ']' : ''}${x.pequeno ? ' [PEQUENO ' + x.r[2] + 'x' + x.r[3] + ']' : ''}`); }
  for (const [k, v] of Object.entries(resumo)) console.log(k, '→', v.join(' | ')); console.log('errs', tudo.filter((x) => x.errs).map((x) => x.ap + ':' + x.errs.join(';'))); await b.close();
})();
