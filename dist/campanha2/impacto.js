/* Da Roça Adventure — Campanha 2: efeitos de luta (impacto).
   Tudo em pixel, desenhado em código. Faz o "peso" dos golpes:
   - hitstop: o mundo congela por uma fração de segundo no acerto;
   - câmera lenta no nocaute do chefe;
   - faíscas, estrela de impacto, anel de choque, lascas de papel, poeira;
   - no golpe, o inimigo só pisca e mostra o número do dano;
   - fantasmas do dash, fumaça e moedas quando um inimigo cai;
   - energia se juntando no chefe antes do golpe (aviso mais bonito).
   API: CampanhaImpacto.tempo(dt) devolve a escala de tempo do mundo (0 no hitstop).
   Camadas: atras(c) antes do herói, frente(c) depois, tela(c, W, H) sem câmera. */
(() => {
  'use strict';
  if (window.CampanhaImpacto) return;
  const TAU = Math.PI * 2, rnd = (a, b) => a + Math.random() * (b - a), pick = (l) => l[Math.floor(Math.random() * l.length)];
  let ps = [], parado = 0, lento = 0, lentoEsc = 1, telaFlash = 0, telaCor = '#ffffff', linhas = 0, relogio = 0, chao = 440;
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const add = (p) => { if (ps.length > 420) ps.splice(0, ps.length - 420); ps.push(Object.assign({ t: 0, vx: 0, vy: 0, g: 0 }, p)); };
  const leve = () => !!window.Graphics?.isLight?.();

  /* ---------- tempo ---------- */
  function tempo(dt) {
    if (parado > 0) { parado -= dt; return 0.02; }
    if (lento > 0) { lento -= dt; return lento < .25 ? lentoEsc + (1 - lentoEsc) * (1 - lento / .25) : lentoEsc; } // volta ao normal suavemente
    return 1;
  }
  const parar = (s) => { parado = Math.max(parado, s); };
  const camLenta = (s, esc = .3) => { lento = Math.max(lento, s); lentoEsc = esc; };

  /* ---------- desenhos base ---------- */
  function circuloPx(c, x, y, r, cor, passo = 3) { // círculo cheio "de pixel", em fileiras
    c.fillStyle = cor; for (let dy = -r; dy <= r; dy += passo) { const w = Math.sqrt(Math.max(0, r * r - dy * dy)); c.fillRect(Math.round((x - w) / passo) * passo, Math.round((y + dy) / passo) * passo, Math.round(w * 2 / passo) * passo || passo, passo); }
  }
  function anelPx(c, x, y, rx, ry, cor, tam = 3) { const n = Math.max(12, Math.round(rx * .5)); c.fillStyle = cor; for (let i = 0; i < n; i++) { const a = i / n * TAU; c.fillRect(Math.round(x + Math.cos(a) * rx - tam / 2), Math.round(y + Math.sin(a) * ry - tam / 2), tam, tam); } }
  function estrela(c, x, y, r, pontas, cor, rot = 0) { c.fillStyle = cor; c.beginPath(); for (let i = 0; i < pontas * 2; i++) { const a = rot + i / (pontas * 2) * TAU, rr = i % 2 ? r * .45 : r; c.lineTo(x + Math.cos(a) * rr, y + Math.sin(a) * rr); } c.closePath(); c.fill(); }
  function textoContorno(c, s, x, y, cor, borda = '#1c0e08', esp = 2) { for (const [ox, oy] of [[-esp, 0], [esp, 0], [0, -esp], [0, esp], [esp, esp]]) { c.fillStyle = borda; c.fillText(s, x + ox, y + oy); } c.fillStyle = cor; c.fillText(s, x, y); }

  /* ---------- efeitos que o jogo chama ---------- */
  function acerto(x, y, o = {}) { // golpe no inimigo: só um tranquinho de tempo e o número do dano (quem pisca é o inimigo)
    parar(o.critico ? .06 : .035);
    if (o.n != null) numero(x + rnd(-10, 10), y - 26, o.n, o.critico ? '#ffd24a' : o.corNum || '#fff6dc', o.critico);
  }
  const piscar = (e, s = .4) => { if (e) e.piscaAte = performance.now() + s * 1000; };
  const piscando = (e) => !!e && (e.piscaAte || 0) > performance.now() && Math.floor(performance.now() / 55) % 2 === 0;
  function numero(x, y, n, cor = '#fff6dc', grande = false) { add({ k: 'num', x, y, vx: rnd(-30, 30), vy: -170, g: 420, vida: .95, s: String(n), cor, grande }); }
  function heroi(x, y, dir = 1, n = 0) { parar(.07); } // o Da Roça tomou um golpe: ele já pisca sozinho
  function morte(x, y, cor = '#e8e0d0', moedas = 3) { // inimigo comum caiu: fumaça, estrelinhas e moedas pulando
    parar(.06);
    for (let i = 0; i < (leve() ? 6 : 12); i++) { const a = rnd(0, TAU), v = rnd(30, 120); add({ k: 'fumaca', x: x + Math.cos(a) * 10, y: y + Math.sin(a) * 10, vx: Math.cos(a) * v, vy: Math.sin(a) * v - 30, vida: rnd(.5, .9), r: rnd(8, 16), cor: i % 3 ? '#efe6d4' : cor }); }
    for (let i = 0; i < 4; i++) add({ k: 'estrelinha', x, y: y - 20, vida: 1, a0: i / 4 * TAU, cor: '#ffd24a' });
    for (let i = 0; i < moedas; i++) add({ k: 'moeda', x, y: y - 10, vx: rnd(-140, 140), vy: rnd(-420, -260), g: 1300, vida: 1.3, quica: 0 });
    add({ k: 'anel', x, y, vida: .32, r0: 10, r1: 70, cor: '#fff2b0' });
  }
  function poeira(x, y, forca = 1, dir = 0) { // pulo, aterrissagem, freada
    const n = leve() ? 3 : Math.round(4 + forca * 4);
    for (let i = 0; i < n; i++) { const s = dir || (i % 2 ? 1 : -1); add({ k: 'fumaca', x: x + rnd(-6, 6), y: y - 4, vx: s * rnd(40, 140) * forca, vy: rnd(-40, -8), vida: rnd(.3, .55), r: rnd(4, 7) * (0.8 + forca * .3), cor: '#e6dcc6' }); }
  }
  function dash(P) { // início do dash: poeira, linhas de velocidade e o "VUPT!"
    const d = P.facing < 0 ? -1 : 1; poeira(P.x - d * 10, P.y, 1.4, -d); linhas = .35;
  }
  const ghostCv = document.createElement('canvas'); ghostCv.width = 200; ghostCv.height = 220; const gctx = ghostCv.getContext('2d');
  let ultimoFantasma = 0;
  function rastro(P, cor = '#7ad8ff') { // fantasmas do herói durante o dash
    if (relogio - ultimoFantasma < .035 || leve()) return; ultimoFantasma = relogio;
    try { gctx.clearRect(0, 0, 200, 220); gctx.globalCompositeOperation = 'source-over'; window.Art.drawCharacter(gctx, 'daroca', 100, 200, { frame: relogio, facing: P.facing, moving: true, grounded: P.ground, vy: P.vy }); gctx.globalCompositeOperation = 'source-atop'; gctx.fillStyle = cor; gctx.fillRect(0, 0, 200, 220); gctx.globalCompositeOperation = 'source-over';
      const img = document.createElement('canvas'); img.width = 200; img.height = 220; img.getContext('2d').drawImage(ghostCv, 0, 0); add({ k: 'fantasma', x: P.x, y: P.y, vida: .22, img }); } catch (e) {}
  }
  function arco(x, y, dir) { add({ k: 'arco', x, y, dir, vida: .14 }); } // "swoosh" do arremesso
  function onda(x, y, cor = '#ffd24a', grande = 1) { // choque no chão
    add({ k: 'anelChao', x, y, vida: .5, r1: 150 * grande, cor });
    for (let i = 0; i < (leve() ? 4 : 9); i++) add({ k: 'pedra', x: x + rnd(-30, 30), y: y - 4, vx: rnd(-220, 220), vy: rnd(-420, -200), g: 1400, vida: rnd(.6, .9), tam: pick([3, 4, 6]), cor: pick(['#8a7a62', '#6a5a46', '#b0a084']) });
    poeira(x, y, 1.6);
  }
  function explosao(x, y, cor = '#ffd24a') { // troca de fase do chefe
    parar(.16); camLenta(.55, .4); telaFlash = Math.max(telaFlash, .35); telaCor = '#ffffff';
    for (const [r, v] of [[90, .4], [150, .55], [220, .7]]) add({ k: 'anel', x, y, vida: v, r0: 10, r1: r, cor: r === 150 ? cor : '#ffffff', grosso: true });
    for (let i = 0; i < (leve() ? 10 : 26); i++) { const a = rnd(0, TAU), v = rnd(200, 620); add({ k: 'faisca', x, y, vx: Math.cos(a) * v, vy: Math.sin(a) * v, g: 500, vida: rnd(.4, .8), cor: i % 2 ? cor : '#ffffff', tam: pick([3, 4, 5]) }); }
    add({ k: 'raios', x, y, vida: .5, cor });
  }
  function nocaute(x, y, cor = '#ffd24a') { // chefe derrotado: congela, câmera lenta e explosão de luz
    parar(.32); camLenta(1.5, .28); telaFlash = Math.max(telaFlash, .55); telaCor = '#fff6d8'; explosao(x, y, cor); linhas = 1.2;
    for (let i = 0; i < (leve() ? 12 : 34); i++) add({ k: 'confete', x: x + rnd(-40, 40), y: y - rnd(20, 80), vx: rnd(-260, 260), vy: rnd(-560, -220), g: 700, vida: rnd(1.2, 2), rot: rnd(0, TAU), vr: rnd(-12, 12), cor: pick(['#ffd24a', '#ff6a8a', '#7ae0ff', '#7af07a', '#ffffff', cor]) });
    for (let i = 0; i < 8; i++) add({ k: 'moeda', x, y, vx: rnd(-260, 260), vy: rnd(-620, -360), g: 1300, vida: 1.8, quica: 0 });
  }
  function golpe(x, y, g, dir = 1, cor = '#ffd24a') { // o chefe soltou o golpe
    if (g === 'investida' || g === 'combo') { poeira(x - dir * 20, y, 1.8, -dir); linhas = .45; }
    if (g === 'soco') poeira(x, y, 1.4, -dir);
    if (g === 'onda') onda(x, y, cor, 1.3);
    if (g === 'topete') for (let i = 0; i < 10; i++) { const a = i / 10 * TAU; add({ k: 'faisca', x: x + Math.cos(a) * 50, y: y - 60 + Math.sin(a) * 40, vx: -Math.sin(a) * 300, vy: Math.cos(a) * 200, g: 0, vida: .35, cor: '#d8e0ff', tam: 3 }); }
    if (g === 'invocar') { add({ k: 'anel', x, y: y - 60, vida: .45, r0: 10, r1: 110, cor }); }
  }
  function raio(x, y) { // raio/flash caiu no chão
    onda(x, y, '#c8d8ff', .6); for (let i = 0; i < 8; i++) add({ k: 'faisca', x, y: y - 6, vx: rnd(-300, 300), vy: rnd(-420, -120), g: 1100, vida: rnd(.25, .5), cor: i % 2 ? '#ffffff' : '#c8d8ff', tam: 3 });
  }

  /* ---------- aviso de golpe do chefe (chamado a cada quadro durante a carga) ---------- */
  function carga(c, x, y, k, cor = '#ff3a2a', t = relogio) {
    k = Math.max(0, Math.min(1, k));
    if (!leve()) for (let i = 0; i < 14; i++) { const q = (t * 1.8 + i / 14) % 1, a = i * 2.39 + Math.floor(t * 1.8 + i / 14) * 1.3, r = (1 - q) * (70 + k * 40); c.globalAlpha = q * (.4 + k * .6); R(c, x + Math.cos(a) * r - 2, y + Math.sin(a) * r * .8 - 2, 4, 4, i % 3 ? cor : '#ffffff'); }
    c.globalAlpha = .18 + k * .3; anelPx(c, x, y, 26 + (1 - k) * 40, 22 + (1 - k) * 30, cor, 3);
    if (k > .72 && Math.floor(t * 20) % 2) { c.globalAlpha = .35; circuloPx(c, x, y, 18 + k * 10, '#ffffff', 3); }
    c.globalAlpha = 1;
  }

  /* ---------- projéteis do herói, com mais detalhe ---------- */
  function bolaPapel(c, q, t) { // papel amassado girando, com rastro
    const a = t * 22 + q.x * .05, sp = Math.sign(q.vx) || 1;
    for (let k = 1; k <= 3; k++) { c.globalAlpha = .28 - k * .07; R(c, q.x - sp * k * 9 - 3, q.y - 3 + k, 6, 6, '#f6f4ee'); } c.globalAlpha = 1;
    c.save(); c.translate(Math.round(q.x), Math.round(q.y)); c.rotate(Math.round(a / (Math.PI / 4)) * (Math.PI / 4));
    R(c, -6, -5, 12, 10, '#3a2a1c'); R(c, -5, -6, 10, 12, '#3a2a1c'); R(c, -5, -4, 10, 8, '#f6f4ee'); R(c, -4, -5, 8, 10, '#f6f4ee'); R(c, -2, -3, 3, 2, '#c8c4b6'); R(c, 1, 0, 3, 2, '#c8c4b6'); R(c, -3, 2, 2, 1, '#a8a496'); R(c, -4, -4, 2, 2, '#ffffff');
    c.restore();
  }
  function nuvem(c, n) { // peido: nuvem de pixel com contorno, bolhas e cheirinho subindo
    const a = Math.max(0, 1 - n.t / 1.1), cresce = 1 + n.t * 1.1;
    for (let k = 0; k < 6; k++) { const x = n.x + Math.cos(k * 1.3 + n.t * 3) * 16 * cresce, y = n.y - 6 + Math.sin(k * 2 + n.t * 2) * 9, r = (9 + n.t * 13) * (k % 2 ? .85 : 1);
      c.globalAlpha = a * .8; circuloPx(c, x, y + 2, r + 2, '#4a6a22'); c.globalAlpha = a * .7; circuloPx(c, x, y, r, k % 2 ? '#a8d060' : '#c4e07a'); c.globalAlpha = a * .5; circuloPx(c, x - r * .3, y - r * .3, r * .35, '#e8f6b0'); }
    c.globalAlpha = a * .8; for (let k = 0; k < 3; k++) { const bx = n.x - 18 + k * 18, by = n.y - 30 - n.t * 40 - k * 6; for (let j = 0; j < 4; j++) R(c, bx + Math.sin(n.t * 9 + j + k) * 3, by - j * 5, 2, 4, '#6a8a2a'); }
    c.globalAlpha = 1;
  }

  /* ---------- quadro a quadro ---------- */
  function atualizar(dt) {
    relogio += dt; telaFlash = Math.max(0, telaFlash - dt * 2.2); linhas = Math.max(0, linhas - dt);
    for (const p of ps) { p.t += dt; p.vy += p.g * dt; p.x += p.vx * dt; p.y += p.vy * dt;
      if (p.k === 'fumaca') { p.vx *= Math.pow(.15, dt); p.vy *= Math.pow(.3, dt); }
      if (p.k === 'lasca' || p.k === 'confete') { p.rot += (p.vr || 0) * dt; p.vx *= Math.pow(.4, dt); if (p.vy > 120) p.vy = 120 + (p.vy - 120) * .9; }
      if ((p.k === 'moeda' || p.k === 'pedra') && p.y > chao - 4 && p.vy > 0) { p.y = chao - 4; if ((p.quica || 0) < 2) { p.vy *= -.45; p.vx *= .6; p.quica = (p.quica || 0) + 1; } else { p.vy = 0; p.vx *= .8; } }
      if (p.k === 'faisca') { p.vx *= Math.pow(.2, dt); } }
    ps = ps.filter((p) => p.t < p.vida);
  }
  function desenharP(c, p) {
    const k = p.t / p.vida, a = 1 - k;
    switch (p.k) {
      case 'faisca': { c.globalAlpha = a; const tx = p.vx * .025, ty = p.vy * .025; c.strokeStyle = p.cor; c.lineWidth = Math.max(1, p.tam - 1); c.beginPath(); c.moveTo(Math.round(p.x), Math.round(p.y)); c.lineTo(Math.round(p.x - tx), Math.round(p.y - ty)); c.stroke(); R(c, p.x - p.tam / 2, p.y - p.tam / 2, p.tam, p.tam, '#ffffff'); break; }
      case 'estrela': { const s = .6 + k * .8; c.globalAlpha = 1; estrela(c, p.x, p.y, p.r * s + 4, 8, '#1c0e08', p.rot); estrela(c, p.x, p.y, p.r * s, 8, '#ffffff', p.rot); estrela(c, p.x, p.y, p.r * s * .6, 8, p.cor, p.rot + .2); break; }
      case 'anel': { const r = p.r0 + (p.r1 - p.r0) * (1 - Math.pow(1 - k, 3)); c.globalAlpha = a * .9; anelPx(c, p.x, p.y, r, r * .8, p.cor, p.grosso ? 5 : 3); break; }
      case 'anelChao': { const r = p.r1 * (1 - Math.pow(1 - k, 2)); c.globalAlpha = a; anelPx(c, p.x, p.y, r, Math.max(4, r * .12), p.cor, 4); c.globalAlpha = a * .5; anelPx(c, p.x, p.y, r * .7, Math.max(3, r * .08), '#ffffff', 3); break; }
      case 'fumaca': { c.globalAlpha = a * .75; circuloPx(c, p.x, p.y, p.r * (1 + k * .8), p.cor, 3); c.globalAlpha = a * .4; circuloPx(c, p.x - 2, p.y - 2, p.r * .45, '#ffffff', 3); break; }
      case 'lasca': { c.globalAlpha = a; c.save(); c.translate(Math.round(p.x), Math.round(p.y)); c.rotate(p.rot); R(c, -3, -2, 6, 4, p.cor); c.restore(); break; }
      case 'confete': { c.globalAlpha = Math.min(1, a * 2); c.save(); c.translate(Math.round(p.x), Math.round(p.y)); c.scale(Math.cos(p.rot), 1); R(c, -3, -2, 6, 4, p.cor); c.restore(); break; }
      case 'pedra': { c.globalAlpha = Math.min(1, a * 2); R(c, p.x - p.tam / 2, p.y - p.tam / 2, p.tam, p.tam, '#2a1a10'); R(c, p.x - p.tam / 2 + 1, p.y - p.tam / 2 + 1, p.tam - 2, p.tam - 2, p.cor); break; }
      case 'moeda': { c.globalAlpha = Math.min(1, a * 3); const w = Math.max(2, Math.round(Math.abs(Math.cos(p.t * 14)) * 10)); R(c, p.x - w / 2 - 1, p.y - 6, w + 2, 12, '#5a3a08'); R(c, p.x - w / 2, p.y - 5, w, 10, '#ffd24a'); if (w > 5) R(c, p.x - w / 2 + 1, p.y - 4, 2, 4, '#fff6b0'); break; }
      case 'estrelinha': { c.globalAlpha = a; const ang = p.a0 + p.t * 6, r = 10 + p.t * 30; const x = p.x + Math.cos(ang) * r, y = p.y + Math.sin(ang) * r * .5 - p.t * 30; estrela(c, x, y, 6, 5, '#1c0e08', ang); estrela(c, x, y, 4.5, 5, p.cor, ang); break; }
      case 'num': { const pop = p.t < .12 ? 1.7 - p.t / .12 * .7 : 1; c.globalAlpha = Math.min(1, a * 2.2); c.save(); c.translate(Math.round(p.x), Math.round(p.y)); c.scale(pop, pop); c.font = (p.grande ? '20px' : '15px') + ' Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; textoContorno(c, p.s, 0, 0, p.cor, '#1c0e08', 2); c.restore(); break; }
      case 'fantasma': { c.globalAlpha = a * .45; c.drawImage(p.img, Math.round(p.x - 100), Math.round(p.y - 200)); break; }
      case 'arco': { c.globalAlpha = a; c.strokeStyle = '#ffffff'; c.lineWidth = 4; c.beginPath(); const a0 = p.dir > 0 ? -1.4 : Math.PI + 1.4; c.arc(p.x, p.y, 22 + k * 10, a0, a0 + p.dir * (1.2 + k * 1.2), p.dir < 0); c.stroke(); c.lineWidth = 1; break; }
      case 'raios': { c.globalAlpha = a * .8; c.fillStyle = p.cor; for (let i = 0; i < 12; i++) { const ang = i / 12 * TAU + p.t, r0 = 30 + k * 80, r1 = r0 + 60 + k * 120; c.beginPath(); c.moveTo(p.x + Math.cos(ang - .05) * r0, p.y + Math.sin(ang - .05) * r0); c.lineTo(p.x + Math.cos(ang) * r1, p.y + Math.sin(ang) * r1); c.lineTo(p.x + Math.cos(ang + .05) * r0, p.y + Math.sin(ang + .05) * r0); c.fill(); } break; }
    }
    c.globalAlpha = 1;
  }
  const ATRAS = new Set(['fantasma', 'anelChao', 'fumaca']);
  function atras(c) { for (const p of ps) if (ATRAS.has(p.k)) desenharP(c, p); }
  function frente(c) { for (const p of ps) if (!ATRAS.has(p.k)) desenharP(c, p); c.textAlign = 'left'; c.textBaseline = 'alphabetic'; }
  function tela(c, W, H) { // sem câmera: clarão, linhas de velocidade e moldura da câmera lenta
    if (linhas > 0 && !leve()) { c.globalAlpha = Math.min(.55, linhas * 1.2); c.fillStyle = '#ffffff'; for (let i = 0; i < 18; i++) { const y = ((i * 97 + Math.floor(relogio * 30) * 37) % H), x = (i * 131 + Math.floor(relogio * 60) * 53) % W; c.fillRect(x, y, 60 + (i % 4) * 30, 2); } c.globalAlpha = 1; }
    if (lento > 0) { const a = Math.min(1, lento * 2) * .5; c.fillStyle = `rgba(10,6,4,${a})`; c.fillRect(0, 0, W, 26); c.fillRect(0, H - 26, W, 26); }
    if (telaFlash > 0) { c.globalAlpha = Math.min(.6, telaFlash); c.fillStyle = telaCor; c.fillRect(0, 0, W, H); c.globalAlpha = 1; }
  }
  function limpar() { ps = []; parado = 0; lento = 0; telaFlash = 0; linhas = 0; }

  window.CampanhaImpacto = Object.freeze({ tempo, parar, camLenta, atualizar, atras, frente, tela, limpar, acerto, numero, piscar, piscando, heroi, morte, poeira, dash, rastro, arco, onda, explosao, nocaute, golpe, raio, carga, bolaPapel, nuvem,
    chao: (y) => { if (y != null) chao = y; return chao; }, quantos: () => ps.length, lento: () => lento > 0 || parado > 0 });
})();
