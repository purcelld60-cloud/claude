// Filma o trailer quadro a quadro: o relógio do jogo é controlado (30 qps exatos), sem engasgo.
const { chromium } = require('playwright'); const fs = require('fs');
const SO = process.argv[2] ? process.argv[2].split(',') : null; // filma só algumas cenas (nomes separados por vírgula)
const FPS = 30, DT = 1000 / FPS;
const relogio = () => {
  const rn = performance.now.bind(performance), rd = Date.now, nRaf = window.requestAnimationFrame.bind(window), nCaf = window.cancelAnimationFrame.bind(window);
  let virt = false, vt = 0, base = 0, id = 1e7; const q = new Map();
  performance.now = () => (virt ? vt : rn()); Date.now = () => (virt ? base + vt : rd());
  window.requestAnimationFrame = (cb) => { if (!virt) return nRaf(cb); const i = ++id; q.set(i, cb); return i; };
  window.cancelAnimationFrame = (i) => { if (q.has(i)) q.delete(i); else nCaf(i); };
  window.__virt = () => { if (virt) return; vt = rn(); base = rd() - vt; virt = true; };
  window.__step = (ms) => { vt += ms; const l = [...q.values()]; q.clear(); for (const cb of l) { try { cb(vt); } catch (e) { console.error('raf', e && e.message); } } };
  const ft = CanvasRenderingContext2D.prototype.fillText; CanvasRenderingContext2D.prototype.fillText = function (s, ...r) { if (typeof s === 'string' && /Esc fecha/.test(s)) return; return ft.call(this, s, ...r); };
  try {
    localStorage.setItem('daroca-graphics-v1', 'high'); localStorage.setItem('daroca-difficulty-v1', 'easy'); localStorage.setItem('daroca-sandbox-v1', '1');
    if (!localStorage.getItem('da-roca-adventure-v1')) localStorage.setItem('da-roca-adventure-v1', JSON.stringify({ q: { lucas: true, jorgeSeen: true, nikolas: true, celebrationSeen: true }, scene: 0, x: 420 }));
  } catch (e) {}
};
(async () => {
  const b = await chromium.launch(); const ctx = await b.newContext({ viewport: { width: 1280, height: 720 } }); const p = await ctx.newPage();
  p.on('pageerror', (e) => console.log('ERRO', e.message)); await p.addInitScript(relogio);
  await p.goto('http://127.0.0.1:8080/?dev'); await p.waitForTimeout(3000);
  await p.evaluate(() => { for (const d of document.querySelectorAll('body > div')) if (d.textContent === 'MODO DESENVOLVEDOR') d.remove(); window.__virt(); const D = window.Difficulty; if (D) window.Difficulty = { ...D, scaleIncomingDamage: () => 0.01 }; }); // o Da Roça não morre na filmagem
  const passo = async (n = 1) => { for (let i = 0; i < n; i++) await p.evaluate((dt) => window.__step(dt), DT); };
  const segurando = new Set(); const tecla = async (k, on) => { if (on && !segurando.has(k)) { segurando.add(k); await p.keyboard.down(k); } else if (!on && segurando.has(k)) { segurando.delete(k); await p.keyboard.up(k); } };
  const soltar = async () => { for (const k of [...segurando]) await tecla(k, false); };
  const toque = async (k) => { await p.keyboard.down(k); await passo(1); await p.keyboard.up(k); };
  async function filmar(nome, n, porQuadro) {
    if (SO && !SO.includes(nome)) return; const dir = `quadros/${nome}`; fs.rmSync(dir, { recursive: true, force: true }); fs.mkdirSync(dir, { recursive: true });
    const t0 = Date.now(); for (let f = 0; f < n; f++) { if (porQuadro) await porQuadro(f); await passo(1); await p.screenshot({ path: `${dir}/${String(f).padStart(5, '0')}.jpg`, type: 'jpeg', quality: 92 }); }
    await soltar(); console.log(nome, n, 'quadros em', ((Date.now() - t0) / 1000).toFixed(1), 's');
  }
  const quer = (nome) => !SO || SO.includes(nome);
  // bot de luta: chega perto do chefe, bate, dá dash, peida e pula
  const lutar = async (f) => {
    if (f % 4) return; const s = await p.evaluate(() => { const g = Game.getState(); return { px: g.player?.x, bx: g.activeBoss?.x ?? g.enemies?.[0]?.x }; });
    if (s.bx == null) { await tecla('d', true); return; } const d = s.bx - s.px, longe = Math.abs(d) > 120;
    await tecla('d', longe && d > 0); await tecla('a', longe && d < 0); if (!longe) { await tecla(d > 0 ? 'd' : 'a', true); }
    if (f % 8 === 0) await toque('j'); if (f % 52 === 24) await toque('l'); if (f % 72 === 40) await toque('k'); if (f % 96 === 60) await toque(' ');
  };
  const cena = async (kind) => { await p.evaluate((k) => window.DarocaDev.tocarCena(k), kind); await passo(2); };
  const fecharCena = async () => { await p.keyboard.press('Escape'); await passo(3); };

  // 1) tela inicial
  await filmar('titulo', 150);
  // 2) começo da história (abertura)
  if (quer('abertura')) { await cena('abertura'); await passo(30); await filmar('abertura', 150, async (f) => { if (f === 75) await p.keyboard.press('Enter'); }); await fecharCena(); }
  // 3) gameplay na roça
  await p.evaluate(() => document.getElementById('continueBtn')?.click()); await passo(60); await p.evaluate(() => { try { Game.closeDialogue?.(); } catch (e) {} });
  if (quer('roca')) { await passo(20); await filmar('roca', 165, async (f) => { await tecla('d', f < 150); if (f % 10 === 3) await toque('j'); if (f === 40 || f === 110) await toque(' '); if (f === 70) await toque('l'); if (f === 130) await toque('k'); }); }
  // 4) lutas da campanha 1
  for (const [nome, tipo] of [['luta_arthur', 'arthur'], ['luta_ollyan', 'ollyan'], ['luta_marco', 'marco'], ['luta_nicolas', 'nicolas']]) {
    if (!quer(nome)) continue; await p.evaluate((t) => Game.startSandboxBoss(t), tipo); await passo(70); await filmar(nome, 165, lutar);
    await p.evaluate(() => { try { Game.exitSandbox(); } catch (e) {} }); await passo(20);
  }
  // 5) Jorge (cena anime)
  if (quer('jorge_anime')) { await cena('jorge_epilogue'); await passo(20); await filmar('jorge_anime', 150, async (f) => { if (f === 70) await p.keyboard.press('Enter'); }); await fecharCena(); }
  // 6) carro a gás voando no mapa
  if (quer('mapa_c1')) {
    await p.evaluate(() => { const o = window.Mapa3D; window.Mapa3D = { ...o, abrir: (d, ...r) => o.abrir({ ...d, aoIr: () => {}, locais: d.locais.map((L) => ({ ...L, estado: L.atual ? L.estado : { ok: true } })) }, ...r) }; MapasJogo.abrirCampanha1(0); window.Mapa3D = o; });
    await passo(60); await p.evaluate(() => [...document.querySelectorAll('.m3d .lugares button')].filter((b) => !b.className)[6]?.click()); await passo(25);
    await filmar('mapa_c1', 120, async (f) => { if (f === 15) await p.evaluate(() => document.querySelector('.m3d .pv .ir')?.click()); });
    await p.evaluate(() => { try { Mapa3D.fechar(); } catch (e) {} }); await passo(10);
  }
  // 7) Campanha 2: o voo e Conquista
  if (quer('c2_voo')) { await cena('c2_voo'); await passo(20); await filmar('c2_voo', 135); await fecharCena(); }
  await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} }); await passo(10);
  if (quer('c2_cidade')) { await p.evaluate(() => window.DarocaDev.capitulo(4)); await passo(80); await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|continuar/i.test(b.textContent)) b.click(); }); await passo(30);
    await filmar('c2_cidade', 165, async (f) => { await tecla('a', f < 150); if (f % 12 === 5) await toque('j'); if (f === 50) await toque(' '); if (f === 95) await toque('l'); });
    await p.evaluate(() => { try { Campanha2.fechar(); } catch (e) {} }); await passo(10); }
  // 8) lutas da campanha 2 no motor da principal
  for (const [slug, tipo, nome, cn, x] of [['tonhao', 'c2_tonhao', 'TONHÃO', 16, 3000], ['kaua', 'c2_kaua_influencer', 'KAUÃ INFLUENCER', 15, 4290], ['jorge', 'jorge', 'JORGE', 14, 2080]]) {
    const id = 'c2_luta_' + slug; if (!quer(id)) continue;
    await p.evaluate(([slug, tipo, nome, cn, x]) => C2Luta.iniciar({ slug, tipo, nome, cena: cn, bossX: x }, () => {}), [slug, tipo, nome, cn, x]); await passo(70);
    await filmar(id, 165, lutar); await p.evaluate(() => dispatchEvent(new CustomEvent('sandbox-change', { detail: { type: 'x', result: 'retreat' } }))); await p.waitForTimeout(900); await passo(20);
  }
  // 9) táxi de Conquista no mapa
  if (quer('mapa_c2')) { await p.evaluate(() => MapasJogo.abrirCampanha2('c2_conquista_bairro', () => {}, { liberado: () => ({ ok: true }) })); await passo(60);
    await p.evaluate(() => [...document.querySelectorAll('.m3d .lugares button')].filter((b) => !b.className)[3]?.click()); await passo(25);
    await filmar('mapa_c2', 120, async (f) => { if (f === 15) await p.evaluate(() => document.querySelector('.m3d .pv .ir')?.click()); }); await p.evaluate(() => { try { Mapa3D.fechar(); } catch (e) {} }); }
  // 10) final da campanha 2
  if (quer('c2_final')) { await cena('c2_final'); await passo(20); await filmar('c2_final', 135, async (f) => { if (f === 70) await p.keyboard.press('Enter'); }); await fecharCena(); }
  await b.close();
})();
