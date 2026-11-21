// Filmagem do trailer vertical (TikTok): quadro a quadro, relógio controlado, em 1920x1080.
// Além das imagens, grava em foco.json onde está a ação em cada quadro (x na tela), para o recorte 9:16 seguir o Da Roça.
const { chromium } = require('playwright'); const fs = require('fs');
const SO = process.argv[2] ? process.argv[2].split(',') : null;
const FPS = 30, DT = 1000 / FPS, Q = 'quadros-tt';
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
  const b = await chromium.launch(); const ctx = await b.newContext({ viewport: { width: 1920, height: 1080 } }); const p = await ctx.newPage();
  p.on('pageerror', (e) => console.log('ERRO', e.message)); await p.addInitScript(relogio);
  await p.route('**/game.js*', async (r) => { const res = await r.fetch(); let t = await res.text(); t = t.replace('window.Game={', 'window.__pl=()=>player;window.__cam=()=>camera;window.Game={'); r.fulfill({ response: res, body: t }); });
  await p.route('**/campanha2/jogo.js*', async (r) => { const res = await r.fetch(); let t = await res.text(); t = t.replace('window.Campanha2 = Object.freeze({', 'window.__c2go=(n,x)=>irPara(n,x);window.__c2P=()=>P;window.__c2cam=()=>cam;window.Campanha2 = Object.freeze({'); r.fulfill({ response: res, body: t }); });
  await p.goto('http://127.0.0.1:8080/?dev'); await p.waitForTimeout(3000);
  await p.evaluate(() => { for (const d of document.querySelectorAll('body > div')) if (d.textContent === 'MODO DESENVOLVEDOR') d.remove(); window.__virt(); const D = window.Difficulty; if (D) window.Difficulty = { ...D, scaleIncomingDamage: () => 0.01 }; });
  const passo = async (n = 1) => { for (let i = 0; i < n; i++) await p.evaluate((dt) => window.__step(dt), DT); };
  const segurando = new Set(); const tecla = async (k, on) => { if (on && !segurando.has(k)) { segurando.add(k); await p.keyboard.down(k); } else if (!on && segurando.has(k)) { segurando.delete(k); await p.keyboard.up(k); } };
  const soltar = async () => { for (const k of [...segurando]) await tecla(k, false); };
  const toque = async (k) => { await p.keyboard.down(k); await passo(1); await p.keyboard.up(k); };
  const foco = fs.existsSync('foco.json') ? JSON.parse(fs.readFileSync('foco.json')) : {};
  // onde está a ação na tela (pixels de 1920): C1/arena, C2 ou centro
  const ondeC1 = () => p.evaluate(() => { const P = __pl(), c = __cam(), s = Game.getState(); let x = P.x; const bx = s.activeBoss?.x; if (Number.isFinite(bx) && Math.abs(bx - x) < 520) x = (x + bx) / 2; return (x - c) * 2; });
  const ondeC2 = () => p.evaluate(() => (__c2P().x - __c2cam()) * 2);
  const centro = async () => 960;
  async function filmar(nome, n, porQuadro, onde = centro) {
    if (SO && !SO.includes(nome)) return; const dir = `${Q}/${nome}`; fs.rmSync(dir, { recursive: true, force: true }); fs.mkdirSync(dir, { recursive: true }); const fx = [];
    for (let f = 0; f < n; f++) { if (porQuadro) await porQuadro(f); await passo(1); fx.push(Math.round(await onde().catch(() => 960))); await p.screenshot({ path: `${dir}/${String(f).padStart(5, '0')}.jpg`, type: 'jpeg', quality: 90 }); }
    await soltar(); foco[nome] = fx; fs.writeFileSync('foco.json', JSON.stringify(foco)); console.log(nome, n);
  }
  const quer = (nome) => !SO || SO.includes(nome);
  const lutar = async (f) => {
    if (f % 3) return; const s = await p.evaluate(() => { const g = Game.getState(); return { px: g.player?.x, bx: g.activeBoss?.x ?? g.enemies?.[0]?.x }; });
    if (s.bx == null) { await tecla('d', true); return; } const d = s.bx - s.px, longe = Math.abs(d) > 110;
    await tecla('d', d > 0); await tecla('a', d < 0);
    if (f % 6 === 0) await toque('j'); if (f % 39 === 18) await toque('l'); if (f % 45 === 30) await toque('k'); if (f % 51 === 9) await toque(' ');
  };
  const cena = async (kind, pular = 0) => { await p.evaluate((k) => window.DarocaDev.tocarCena(k), kind); await passo(pular); };
  const fecharCena = async () => { await p.keyboard.press('Escape'); await passo(3); };

  await filmar('titulo', 70);
  if (quer('abertura')) { await cena('abertura', 40); await filmar('abertura', 60); await fecharCena(); }
  for (const k of ['chegada_escola', 'chegada_favela', 'chegada_rayssa']) if (quer(k)) { await cena(k, 50); await filmar(k, 34); await fecharCena(); }
  await p.evaluate(() => document.getElementById('continueBtn')?.click()); await passo(60); await p.evaluate(() => { try { Game.closeDialogue?.(); } catch (e) {} }); await passo(20);
  if (quer('roca')) await filmar('roca', 66, async (f) => { await tecla('d', true); if (f % 9 === 3) await toque('j'); if (f === 20) await toque(' '); if (f === 40) await toque('l'); if (f === 55) await toque('k'); }, ondeC1);
  for (const t of ['dede', 'kaique', 'arthur', 'freddy', 'menezes', 'giant', 'marco', 'nicolas', 'nikolas', 'reeisBoss']) {
    const nome = 'chefe_' + t; if (!quer(nome)) continue; await p.evaluate((t) => Game.startSandboxBoss(t), t); await passo(25);
    await filmar(nome, 48, lutar, ondeC1); await p.evaluate(() => { try { Game.exitSandbox(); } catch (e) {} }); await passo(15);
  }
  if (quer('ollyan')) { await p.evaluate(() => Game.startSandboxBoss('ollyan')); await passo(25); await filmar('ollyan', 110, lutar); await p.evaluate(() => { try { Game.exitSandbox(); } catch (e) {} }); await passo(15); }
  if (quer('mapa_c1')) {
    await p.evaluate(() => { const o = window.Mapa3D; window.Mapa3D = { ...o, abrir: (d, ...r) => o.abrir({ ...d, aoIr: () => {}, locais: d.locais.map((L) => ({ ...L, estado: L.atual ? L.estado : { ok: true } })) }, ...r) }; MapasJogo.abrirCampanha1(0); window.Mapa3D = o; });
    await passo(60); await p.evaluate(() => [...document.querySelectorAll('.m3d .lugares button')].filter((b) => !b.className)[6]?.click()); await passo(25);
    await p.evaluate(() => document.querySelector('.m3d .pv .ir')?.click()); await passo(14); await filmar('mapa_c1', 75);
    await p.evaluate(() => { try { Mapa3D.fechar(); } catch (e) {} }); await passo(10);
  }
  if (quer('fliperama')) { await p.evaluate(() => Fliperama.open('corrida')); await passo(40); for (let i = 0; i < 4; i++) { await toque('Enter'); await passo(15); } await passo(60);
    await filmar('fliperama', 40, async (f) => { await tecla(f % 20 < 10 ? 'a' : 'd', true); await tecla(f % 20 < 10 ? 'd' : 'a', false); if (f % 7 === 0) await toque(' '); }); await p.evaluate(() => { try { Fliperama.close(); } catch (e) {} }); await passo(10); }
  if (quer('jorge_anime')) { await cena('jorge_epilogue', 50); await p.keyboard.press('Enter'); await passo(24); await filmar('jorge_anime', 40); await fecharCena(); }
  await p.evaluate(() => { try { Game.returnToMenu?.(); } catch (e) {} }); await passo(10);
  if (quer('c2_voo')) { await cena('c2_voo', 25); await filmar('c2_voo', 40); await fecharCena(); }
  for (const v of ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos', 'fred']) { const nome = 'vilao_' + v; if (!quer(nome)) continue; await cena('c2_vilao_' + v, 70); await filmar(nome, 40, async (f) => { if (f === 20) await p.keyboard.press('Enter'); }); await fecharCena(); }
  if (quer('c2_cidade')) { await p.evaluate(() => window.DarocaDev.capitulo(4)); await passo(80); await p.evaluate(() => { for (const b of document.querySelectorAll('.c2j button')) if (/pular|fechar|continuar/i.test(b.textContent)) b.click(); }); await passo(30);
    await filmar('c2_cidade', 50, async (f) => { await tecla('a', true); if (f % 10 === 5) await toque('j'); if (f === 25) await toque(' '); }, ondeC2); await p.evaluate(() => { try { Campanha2.fechar(); } catch (e) {} }); await passo(10); }
  for (const [slug, tipo, nome, cn, x] of [['tonhao', 'c2_tonhao', 'TONHÃO', 16, 3000], ['kaua', 'c2_kaua_influencer', 'KAUÃ INFLUENCER', 15, 4290], ['barao', 'c2_barao', 'BARÃO DO CAFÉ', 18, 4100], ['jorge', 'jorge', 'JORGE', 14, 2080]]) {
    const id = 'c2_luta_' + slug; if (!quer(id)) continue;
    await p.evaluate(([slug, tipo, nome, cn, x]) => C2Luta.iniciar({ slug, tipo, nome, cena: cn, bossX: x }, () => {}), [slug, tipo, nome, cn, x]); await passo(25);
    await filmar(id, 50, lutar, ondeC1); await p.evaluate(() => dispatchEvent(new CustomEvent('sandbox-change', { detail: { type: 'x', result: 'retreat' } }))); await p.waitForTimeout(900); await passo(20);
  }
  if (quer('mapa_c2')) { await p.evaluate(() => MapasJogo.abrirCampanha2('c2_conquista_bairro', () => {}, { liberado: () => ({ ok: true }) })); await passo(60);
    await p.evaluate(() => [...document.querySelectorAll('.m3d .lugares button')].filter((b) => !b.className)[3]?.click()); await passo(25);
    await p.evaluate(() => document.querySelector('.m3d .pv .ir')?.click()); await passo(10); await filmar('mapa_c2', 60); await p.evaluate(() => { try { Mapa3D.fechar(); } catch (e) {} }); }
  if (quer('c2_final')) { await cena('c2_final', 30); await filmar('c2_final', 45); await fecharCena(); }
  await b.close();
})();
