/* Baile funk em LOCAL FECHADO: o galpão do Ollyan (cena 11 da Campanha 1).
   - Lado de fora (x < PORTA): rua à noite, fila, segurança, placa de estacionamento. O carro a gás só chega até a porta.
   - Lado de dentro: teto de zinco com treliças, moving heads varrendo a fumaça, lasers, globo espelhado, paredão, bar,
     grafite, fita de LED, pista que acende no ritmo e a multidão dançando (BailePixel.dancer).
   - Quando o Ollyan abre um buraco no teto (cutscene da perseguição), entra luz de lua pela abertura: feixe com poeira,
     poça de luz no chão e, com o pixelfx carregado, raios de luz (weather/god-rays). O buraco fica depois da vitória.
   API: BaileGalpao.draw(c, camera, t, opts) → true (opts.rombo 0..1 força a abertura do teto, usado na cutscene),
        BaileGalpao.sincronizar({ telhado, px }), PORTA, PALCO, NPC_X, MC_X. Sem save próprio: a campanha diz se o teto está aberto. */
(() => {
  'use strict';
  if (window.BaileGalpao) return;
  const W = 960, H = 540, FLOOR = 440, LENGTH = 4800, PORTA = 760, FACHADA = 610, NPC_X = 3260, PALCO = 2240, MC_X = 1960, TETO = 78, TAU = Math.PI * 2;
  const BPM = 128, BEAT = 60 / BPM;
  const clamp = (n, a, b) => Math.max(a, Math.min(b, n)), smooth = (x) => { x = clamp(x, 0, 1); return x * x * (3 - 2 * x); };
  const hsh = (n) => { const x = Math.sin(n * 12.9898 + 78.233) * 43758.5453; return x - Math.floor(x); };
  const lite = () => !!window.Graphics?.isLite?.();
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const poly = (c, pts, cor) => { c.fillStyle = cor; c.beginPath(); pts.forEach((p, i) => (i ? c.lineTo(p[0], p[1]) : c.moveTo(p[0], p[1]))); c.closePath(); c.fill(); };
  const linha = (c, pts, cor, w = 1) => { c.strokeStyle = cor; c.lineWidth = w; c.beginPath(); pts.forEach((p, i) => (i ? c.lineTo(p[0], p[1]) : c.moveTo(p[0], p[1]))); c.stroke(); };
  function texto(c, s, x, y, tam, cor, sombra = '#0c0a18', align = 'center') { c.save(); c.font = 'bold ' + tam + 'px monospace'; c.textAlign = align; c.textBaseline = 'middle'; c.fillStyle = sombra; c.fillText(s, x + 2, y + 2); c.fillStyle = cor; c.fillText(s, x, y); c.restore(); }
  function brilho(c, x, y, r, cor, a = .2) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha *= a; const g = c.createRadialGradient(x, y, 0, x, y, r); g.addColorStop(0, cor); g.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore(); }
  const NEON = ['#ff4fa8', '#3fe0ff', '#b56bff', '#ffd24a', '#5dff9a'];
  const LUAR = ['#0a1020', '#1a2a48', '#3a5a88', '#7aa0d0', '#b8d4f2', '#e4f0ff', '#ffffff'];

  // gente do baile: desenhada com o mesmo desenhista detalhado dos personagens da Campanha 2
  const GENTE = {
    baile_seguranca: { name: 'Segurança do baile', skin: '#7a4a2e', shade: '#55331f', build: 'strong', top: '#121216', topKind: 'tee', sleeve: 'short', print: '#f2f2ea', pants: '#1c1e24', hair: { style: 'buzz', color: '#121010' }, shades: true, pose: 'hips' },
    baile_barman: { name: 'Tonico do bar', skin: '#c48a62', shade: '#93613f', build: 'normal', top: '#1f1f2a', topKind: 'vest', vest: '#3a2a4a', vestBand: '#ff4fa8', pants: '#22252c', hair: { style: 'quiff', color: '#2a1d16' }, pose: 'talk' },
    baile_fila1: { name: 'Fila do baile', skin: '#8a5a3c', shade: '#5f3d2a', build: 'slim', top: '#f2c230', topKind: 'tee', sleeve: 'short', pants: '#2a3442', hat: { kind: 'capback', color: '#1e2a36' }, hair: { style: 'short', color: '#1c1714' }, chain: '#e8c24c', pose: 'pockets' },
    baile_fila2: { name: 'Fila do baile', skin: '#e3b48f', shade: '#b58665', build: 'slim', h: .95, top: '#ff4fa8', topKind: 'puffer', skirt: '#1f2430', hair: { style: 'ponytail', color: '#2b1d17' }, earrings: '#f2cf5b', item: 'phone', pose: 'phone' },
    baile_fila3: { name: 'Fila do baile', skin: '#5e3a26', shade: '#3e2618', build: 'normal', top: '#2f6fb5', topKind: 'hoodie', inner: '#1d2a3c', pants: '#25303f', hair: { style: 'curlyBig', color: '#121010' }, pose: 'relaxed' },
    mc_batidao: { name: 'MC Batidão', skin: '#6a4028', shade: '#4a2c1c', build: 'normal', top: '#f2f1ec', topKind: 'tee', sleeve: 'short', print: '#ff4fa8', pants: '#1f2430', hat: { kind: 'capback', color: '#ff4fa8' }, hair: { style: 'buzz', color: '#121010' }, chain: '#e8c24c', shades: true, item: 'mic', pose: 'sing' }
  };
  const registrar = () => { const CP = window.CampanhaPersonagens; if (!CP?.registrar) return false; for (const [id, spec] of Object.entries(GENTE)) CP.registrar(id, spec, 'NPC (baile)'); return true; };
  if (!registrar()) addEventListener('DOMContentLoaded', registrar, { once: true });

  let telhadoAberto = false, ultimoRombo = 0, raios = null;
  function pessoa(c, tipo, x, y, t, o = {}) { try { window.Art?.drawCharacter?.(c, tipo, x, y, { frame: t, grounded: true, ...o }); } catch (e) {} }
  function dancarino(c, x, y, t, seed, esc) { if (window.BailePixel?.dancer) window.BailePixel.dancer(c, x, y, t, seed, esc); }

  /* ---------- céu e rua ---------- */
  function ceu(c, cam, t) {
    const g = c.createLinearGradient(0, 0, 0, FLOOR); g.addColorStop(0, '#070b1e'); g.addColorStop(.5, '#1a2148'); g.addColorStop(1, '#3a2c52'); c.fillStyle = g; c.fillRect(0, 0, W, H);
    for (let i = 0; i < 60; i++) { const x = ((i * 131.7 - cam * .03) % 1000 + 1000) % 1000, y = 6 + (i * 37) % 200; R(c, x, y, i % 9 === 0 ? 2 : 1, i % 9 === 0 ? 2 : 1, i % 5 ? '#c9cfe8' : '#ffffff'); }
    const lx = 820 - cam * .02; brilho(c, lx, 40, 80, '#cfd8ff', .25); c.fillStyle = '#eef0ff'; c.beginPath(); c.arc(lx, 40, 18, 0, TAU); c.fill(); c.fillStyle = '#121a40'; c.beginPath(); c.arc(lx + 8, 34, 16, 0, TAU); c.fill();
  }
  function rua(c, cam, t) {
    const fim = FACHADA - cam; if (fim < 0) return;
    c.save(); c.beginPath(); c.rect(0, 0, Math.min(W, fim), H); c.clip();
    for (let layer = 0; layer < 2; layer++) { const v = layer ? .3 : .15; for (let i = -1; i < 10; i++) { const x = i * 150 - (cam * v % 150), h = 90 + (i * 53 + layer * 31) % 120, y = FLOOR - 30 - h + layer * 20; R(c, x, y, 138, FLOOR - y, layer ? '#1c2440' : '#141a33'); for (let r = 0; r < 5; r++) for (let k = 0; k < 6; k++) if ((i + r + k + layer) % 3) R(c, x + 10 + k * 20, y + 12 + r * 20, 8, 10, (i + r * k) % 5 ? '#2a3456' : '#d8b86a'); } }
    R(c, 0, FLOOR - 14, W, 14, '#3a3a4a'); R(c, 0, FLOOR - 14, W, 3, '#5a5a6e'); R(c, 0, FLOOR, W, H - FLOOR, '#22222e'); for (let i = -1; i < 16; i++) { const x = i * 70 - (cam % 70); R(c, x, FLOOR + 40, 36, 4, '#d8c46a'); }
    // poste
    const pX = 300 - cam; if (pX > -40 && pX < W + 40) { R(c, pX, 200, 6, FLOOR - 200, '#2a2e3e'); R(c, pX - 16, 194, 38, 8, '#3a3e50'); R(c, pX - 10, 202, 26, 4, '#ffe6a0'); c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .12; poly(c, [[pX - 10, 206], [pX + 16, 206], [pX + 70, FLOOR], [pX - 64, FLOOR]], '#ffe6a0'); c.restore(); }
    // placa: carro só até aqui
    const sX = 520 - cam; if (sX > -60 && sX < W + 60) { R(c, sX, 330, 4, 110, '#5a5e6a'); R(c, sX - 30, 300, 64, 36, '#0f2a5a'); R(c, sX - 28, 302, 60, 32, '#1f4fa8'); texto(c, 'P', sX - 14, 318, 20, '#ffffff', '#0f2a5a'); texto(c, 'CARRO', sX + 14, 312, 9, '#ffffff', '#0f2a5a'); texto(c, 'SÓ ATÉ', sX + 14, 322, 8, '#ffffff', '#0f2a5a'); texto(c, 'AQUI', sX + 14, 331, 8, '#ffd24a', '#0f2a5a'); }
    c.restore();
  }

  /* ---------- o galpão ---------- */
  function fachada(c, cam, t) {
    const x0 = FACHADA - cam, x1 = PORTA - cam; if (x1 < -40 || x0 > W + 300) return;
    R(c, x0, TETO - 24, x1 - x0, FLOOR - TETO + 24, '#2a1f3e'); for (let y = TETO; y < FLOOR; y += 16) for (let x = x0 + ((y / 16) % 2) * 12; x < x1; x += 24) R(c, x, y, 22, 1, '#3a2c52');
    R(c, x0 - 6, TETO - 30, x1 - x0 + 12, 8, '#4a3a66');
    // porta de enrolar levantada, com a luz do baile saindo
    const dx = x0 + 36, dw = 86, dy = FLOOR - 118, pulso = .5 + .5 * Math.sin(t * TAU / BEAT);
    R(c, dx - 4, dy - 12, dw + 8, 12, '#55556a'); for (let k = 0; k < 3; k++) R(c, dx - 4, dy - 12 + k * 4, dw + 8, 1, '#3a3a4c');
    const g = c.createLinearGradient(dx, dy, dx + dw, FLOOR); g.addColorStop(0, '#3a1a4a'); g.addColorStop(1, NEON[Math.floor(t / BEAT) % 2 ? 0 : 1]); c.fillStyle = g; c.fillRect(dx, dy, dw, FLOOR - dy);
    c.save(); c.globalAlpha = .25 + pulso * .2; c.globalCompositeOperation = 'lighter'; poly(c, [[dx, FLOOR], [dx + dw, FLOOR], [dx + dw - 120, FLOOR + 60], [dx - 160, FLOOR + 60]], NEON[Math.floor(t / BEAT) % 2 ? 0 : 1]); c.restore();
    // neon BAILE DO OLLYAN
    const nx = x0 - 70, ny = 150, on = Math.sin(t * 3.1) > -.92;
    R(c, nx - 4, ny - 4, 230, 58, '#120e1e'); c.save(); c.strokeStyle = on ? '#ff4fa8' : '#5a2a44'; c.lineWidth = 2; c.strokeRect(nx, ny, 222, 50); c.restore();
    texto(c, 'BAILE DO', nx + 111, ny + 15, 13, on ? '#3fe0ff' : '#1a4a5a', '#05030a'); texto(c, 'OLLYAN', nx + 111, ny + 35, 20, on ? '#ff4fa8' : '#5a2a44', '#05030a'); if (on) { brilho(c, nx + 111, ny + 25, 140, '#ff4fa8', .18); }
    for (let i = 0; i < 6; i++) { const yy = dy + 10 + i * 16; c.save(); c.globalAlpha = .35 * pulso; linha(c, [[dx - 10 - i * 3, yy], [dx - 18 - i * 3, yy + 6], [dx - 10 - i * 3, yy + 12]], '#ffb0d8', 2); c.restore(); }
  }
  function interior(c, cam, t) {
    const ini = Math.max(0, PORTA - cam), beat = Math.floor(t / BEAT), fase = (t % BEAT) / BEAT;
    c.save(); c.beginPath(); c.rect(ini, 0, W - ini, H); c.clip();
    // parede do fundo em blocos de concreto pintado
    R(c, ini, TETO, W - ini, FLOOR - TETO, '#15122a');
    for (let y = TETO + 6; y < FLOOR; y += 22) { R(c, ini, y, W - ini, 1, '#1d1936'); const off = ((y / 22) % 2) * 22; for (let x = -((cam + off) % 44); x < W; x += 44) if (x > ini - 44) R(c, x, y, 1, 22, '#1d1936'); }
    // grafites
    for (const [wx, s, cor, borda] of [[960, 'TAMBORZÃO', '#ffd24a', '#b8321a'], [2760, 'PASSINHO', '#3fe0ff', '#2a1a6a'], [3700, 'ITABUNA', '#5dff9a', '#1a4a2a'], [4330, 'ORELHAS AO VENTO', '#ff4fa8', '#3a1238']]) {
      const x = wx - cam; if (x < -320 || x > W + 320) continue; c.save(); c.translate(x, 190); c.rotate(-.04); c.font = 'bold 34px monospace'; c.textAlign = 'center'; c.lineWidth = 6; c.strokeStyle = borda; c.strokeText(s, 0, 0); c.fillStyle = cor; c.fillText(s, 0, 0); c.fillStyle = '#ffffff55'; c.fillText(s, -2, -2);
      for (let k = 0; k < 6; k++) R(c, -120 + k * 47 + hsh(wx + k) * 20, 8, 3, 6 + hsh(k + wx) * 18, cor); c.restore(); }
    // fita de LED na parede (cor corre com o tempo)
    for (let x = ini - ((cam) % 8); x < W; x += 8) { const k = Math.floor((x + cam) / 8 + t * 14) % NEON.length; R(c, x, 296, 6, 2, NEON[(k + NEON.length) % NEON.length]); R(c, x, 118, 6, 2, NEON[(k + 2) % NEON.length]); }
    // placa de SAÍDA
    const sx = 800 - cam; if (sx > -40 && sx < W) { R(c, sx, 238, 52, 18, '#0d3a1e'); R(c, sx + 2, 240, 48, 14, '#1fbf5a'); texto(c, 'SAÍDA', sx + 26, 247, 9, '#eaffea', '#0d3a1e'); brilho(c, sx + 26, 247, 40, '#1fbf5a', .2); }
    bar(c, cam, t);
    // teto de zinco + treliça
    R(c, ini, TETO - 22, W - ini, 22, '#2a2d3a'); for (let x = ini - (cam % 6); x < W; x += 6) R(c, x, TETO - 22, 2, 22, '#363a4a'); R(c, ini, TETO, W - ini, 3, '#101018');
    const ty = TETO + 8; R(c, ini, ty, W - ini, 3, '#4a4e60'); R(c, ini, ty + 18, W - ini, 3, '#4a4e60');
    for (let x = -((cam) % 24); x < W; x += 24) if (x > ini - 24) { linha(c, [[x, ty + 3], [x + 12, ty + 18], [x + 24, ty + 3]], '#3a3e50', 2); }
    // globo espelhado
    const gx = PALCO - cam; if (gx > -200 && gx < W + 200) { R(c, gx, ty + 20, 1, 36, '#8a8a9a'); c.save(); c.beginPath(); c.arc(gx, 160, 20, 0, TAU); c.clip(); R(c, gx - 20, 140, 40, 40, '#8a92a8'); for (let a = 0; a < 8; a++) for (let b = 0; b < 8; b++) if ((a + b + Math.floor(t * 4)) % 3 === 0) R(c, gx - 20 + a * 5, 140 + b * 5, 4, 4, '#f2f6ff'); c.restore(); brilho(c, gx, 160, 50, '#ffffff', .25); }
    pista(c, cam, t, ini, beat);
    c.restore();
  }
  function bar(c, cam, t) {
    const x0 = 1120 - cam; if (x0 > W + 40 || x0 < -460) return;
    R(c, x0, 210, 400, 6, '#3a2a4a'); for (let k = 0; k < 3; k++) { R(c, x0 + 10, 232 + k * 34, 380, 4, '#5a4a6a'); for (let b = 0; b < 22; b++) { const bx = x0 + 18 + b * 17, h = 12 + (b * 7) % 10; R(c, bx, 232 + k * 34 - h, 8, h, ['#3fe0ff', '#ff9a3a', '#5dff9a', '#ffd24a', '#b56bff'][(b + k) % 5]); R(c, bx + 2, 232 + k * 34 - h + 2, 2, h - 4, '#ffffff66'); } }
    R(c, x0 + 140, 140, 120, 34, '#120e1e'); c.save(); c.strokeStyle = '#3fe0ff'; c.lineWidth = 2; c.strokeRect(x0 + 140, 140, 120, 34); c.restore(); texto(c, 'BAR', x0 + 200, 157, 18, '#3fe0ff', '#05030a'); brilho(c, x0 + 200, 157, 90, '#3fe0ff', .15);
    R(c, x0 + 300, 150, 80, 50, '#1a1626'); texto(c, 'REFRI', x0 + 340, 160, 8, '#ffd24a'); texto(c, 'ÁGUA', x0 + 340, 172, 8, '#3fe0ff'); texto(c, 'AÇAÍ', x0 + 340, 184, 8, '#b56bff');
    pessoa(c, 'baile_barman', x0 + 200, 384, t, { facing: Math.sin(t * .5) > 0 ? 1 : -1 });
    R(c, x0, 352, 400, 12, '#4a3a5a'); R(c, x0, 364, 400, 76, '#2a1f38'); R(c, x0, 352, 400, 3, '#8a6aa8'); for (let k = 0; k < 10; k++) R(c, x0 + 8 + k * 40, 370, 30, 64, '#33284a'); R(c, x0, 436, 400, 4, NEON[Math.floor(t * 2) % NEON.length]);
  }
  function pista(c, cam, t, ini, beat) {
    R(c, ini, FLOOR, W - ini, H - FLOOR, '#120f22');
    const tile = 32; for (let x = -((cam) % tile); x < W; x += tile) { if (x < ini - tile) continue; const wx = x + cam; for (let y = FLOOR; y < H; y += 20) { const i = Math.floor(wx / tile), j = (y - FLOOR) / 20; R(c, x, y, tile - 1, 19, (i + j) % 2 ? '#1a1630' : '#16132a');
      if (wx > 1700 && wx < 2800 && !lite()) { const on = (i + j + beat) % 4 === 0 || (i * 3 + j + beat) % 7 === 0; if (on) { c.save(); c.globalAlpha = .38; R(c, x + 1, y + 1, tile - 3, 17, NEON[(i + j + beat) % NEON.length]); c.restore(); } } } }
    R(c, ini, FLOOR, W - ini, 3, '#4a3a6a');
  }
  /* ---------- luzes (feixes na fumaça, lasers, respingos do globo) ---------- */
  function luzes(c, cam, t) {
    const ini = Math.max(0, PORTA - cam), beat = Math.floor(t / BEAT);
    c.save(); c.beginPath(); c.rect(ini, TETO, W - ini, H - TETO); c.clip(); c.globalCompositeOperation = 'lighter';
    for (let i = -1; i < 14; i++) {
      const wx = 900 + i * 300, x = wx - cam; if (x < -400 || x > W + 400 || (lite() && i % 2)) continue;
      R(c, x - 7, TETO + 28, 14, 10, '#2a2a36'); R(c, x - 4, TETO + 38, 8, 6, '#3a3a4a');
      const ang = Math.sin(t * .8 + i * 1.7) * .55 + (i % 2 ? .1 : -.1), cor = NEON[(i + beat) % NEON.length], len = 380;
      const ex = x + Math.sin(ang) * len, ey = TETO + 44 + Math.cos(ang) * len, w1 = 4, w2 = 46, nx = Math.cos(ang), ny = -Math.sin(ang);
      c.globalAlpha = .1 + (i % 3 === beat % 3 ? .05 : 0); poly(c, [[x - nx * w1, TETO + 44 - ny * w1], [x + nx * w1, TETO + 44 + ny * w1], [ex + nx * w2, ey + ny * w2], [ex - nx * w2, ey - ny * w2]], cor);
      c.globalAlpha = .16; poly(c, [[x - nx * 1.5, TETO + 44], [x + nx * 1.5, TETO + 44], [ex + nx * 10, ey], [ex - nx * 10, ey]], cor);
    }
    // lasers verdes perto do palco
    const px0 = PALCO - cam; if (!lite() && px0 > -900 && px0 < W + 900 && Math.floor(t / (BEAT * 4)) % 2 === 0) { c.globalAlpha = .55; for (let k = 0; k < 7; k++) { const a = -Math.PI / 2 + (k - 3) * .32 + Math.sin(t * 1.3) * .2; linha(c, [[px0, 250], [px0 + Math.cos(a) * 900, 250 + Math.sin(a) * -260 + 300]], '#5dff9a', 1); } }
    // respingos de luz do globo nas paredes
    if (px0 > -1200 && px0 < W + 1200) { c.globalAlpha = .5; for (let k = 0; k < (lite() ? 10 : 26); k++) { const a = k * 2.399 + t * .6, rr = 160 + (k * 47) % 520, x = px0 + Math.cos(a) * rr, y = 160 + Math.sin(a) * rr * .45; if (y > TETO && y < FLOOR) R(c, x, y, 3, 2, '#f2f6ff'); } }
    c.restore();
  }
  function fumaca(c, cam, t) {
    if (lite()) return; const ini = Math.max(0, PORTA - cam);
    c.save(); c.beginPath(); c.rect(ini, 0, W - ini, H); c.clip();
    for (let k = 0; k < 9; k++) { const x = ((k * 260 - cam * .9 + t * (12 + k * 3)) % 1400 + 1400) % 1400 - 220, y = 330 + (k % 3) * 30; c.globalAlpha = .07; c.fillStyle = k % 2 ? '#b8a8e8' : '#e8b8e0'; c.beginPath(); c.ellipse(x, y, 190, 34, 0, 0, TAU); c.fill(); }
    c.restore();
  }
  /* ---------- multidão ---------- */
  function multidao(c, cam, t, frente) {
    const ini = PORTA + 50;
    if (!frente) {
      for (let row = 0; row < 2; row++) for (let i = 0; i < 116; i++) { const wx = 60 + i * 41 + row * 23, x = wx - cam; if (wx < ini || x < -45 || x > W + 45 || (row === 0 && wx > 1900 && wx < 2560) || (wx > 1100 && wx < 1530 && row === 0)) continue; dancarino(c, x, row === 0 ? 401 + i % 3 * 5 : 438 + i % 2 * 3, t + row * .33, i + row * 7, row === 0 ? .73 : .91); }
      return;
    }
    if (lite()) return;
    for (let i = 0; i < 70; i++) { const wx = 40 + i * 67 + ((i * 29) % 30), x = wx - cam; if (wx < ini || x < -50 || x > W + 50 || Math.abs(wx - NPC_X) < 90 || Math.abs(wx - MC_X) < 70) continue; dancarino(c, x, 486 + (i % 3) * 9, t + .6, i * 5 + 3, 1.08); }
  }
  function lado_de_fora(c, cam, t) {
    const x = (wx) => wx - cam; if (x(FACHADA) < -60) return;
    for (const [tipo, wx, f] of [['baile_fila1', 470, 1], ['baile_fila2', 512, 1], ['baile_fila3', 552, 1]]) if (x(wx) > -40 && x(wx) < W + 40) pessoa(c, tipo, x(wx), FLOOR, t + wx, { facing: f });
    // corda de veludo da fila
    if (x(440) < W + 20) { for (const px0 of [440, 580]) { R(c, x(px0), FLOOR - 34, 4, 34, '#c9a24a'); R(c, x(px0) - 2, FLOOR - 36, 8, 4, '#e8c24c'); } c.strokeStyle = '#a8223a'; c.lineWidth = 3; c.beginPath(); c.moveTo(x(442), FLOOR - 30); c.quadraticCurveTo(x(511), FLOOR - 14, x(582), FLOOR - 30); c.stroke(); }
    pessoa(c, 'baile_seguranca', x(PORTA - 128), FLOOR, t, { facing: -1 });
  }
  /* ---------- o buraco no teto e a luz da lua ---------- */
  function rombo(c, cam, t, k) {
    if (k <= 0) return; const cx = NPC_X - cam; if (cx < -500 || cx > W + 500) return;
    const meia = 30 + 100 * k, ini = Math.max(0, PORTA - cam);
    c.save(); c.beginPath(); c.rect(ini, 0, W - ini, H); c.clip();
    // céu pelo buraco (bordas irregulares de zinco rasgado)
    const pts = []; for (let i = 0; i <= 12; i++) { const x = cx - meia + i * (meia * 2 / 12); pts.push([x, TETO - 22 - (i % 2 ? 4 : 0)]); } for (let i = 12; i >= 0; i--) { const x = cx - meia + i * (meia * 2 / 12); pts.push([x, TETO + 4 + (i % 3) * 3]); }
    const g = c.createLinearGradient(0, TETO - 30, 0, TETO + 8); g.addColorStop(0, '#1a2148'); g.addColorStop(1, '#3a4a88'); poly(c, pts, g);
    for (let i = 0; i < 8; i++) R(c, cx - meia + 10 + hsh(i) * (meia * 2 - 20), TETO - 18 + hsh(i + 3) * 18, 1, 1, '#ffffff');
    // chapas dobradas penduradas
    for (const s of [-1, 1]) { c.save(); c.translate(cx + s * meia, TETO); c.rotate(s * (.5 + .1 * Math.sin(t * 2))); R(c, -4, 0, 8, 30, '#4a4e60'); for (let y = 0; y < 30; y += 4) R(c, -4, y, 8, 1, '#363a4a'); c.restore(); }
    // feixe de luar com poeira e poça de luz no chão
    c.globalCompositeOperation = 'lighter';
    const topo = TETO + 4, inc = 70, gg = c.createLinearGradient(0, topo, 0, FLOOR); gg.addColorStop(0, `rgba(200,225,255,${.34 * k})`); gg.addColorStop(1, `rgba(150,190,255,${.06 * k})`); c.fillStyle = gg;
    c.beginPath(); c.moveTo(cx - meia * .9, topo); c.lineTo(cx + meia * .9, topo); c.lineTo(cx + meia * 1.35 + inc, FLOOR); c.lineTo(cx - meia * 1.35 + inc, FLOOR); c.closePath(); c.fill();
    for (let i = 0; i < 6; i++) { const u = (i + .5) / 6, a0 = .06 + .05 * Math.sin(t * .7 + i * 1.9), xt = cx - meia * .8 + u * meia * 1.6, xb = cx - meia * 1.2 + u * meia * 2.4 + inc; c.globalAlpha = a0 * k; poly(c, [[xt - 3, topo], [xt + 3, topo], [xb + 9, FLOOR], [xb - 9, FLOOR]], '#e4f0ff'); } c.globalAlpha = 1;
    c.globalAlpha = .5 * k; c.fillStyle = '#cfe3ff'; c.beginPath(); c.ellipse(cx + inc, FLOOR + 8, meia * 1.5, 14, 0, 0, TAU); c.fill();
    c.globalAlpha = k; for (let i = 0; i < (lite() ? 12 : 34); i++) { const u = (t * .05 + hsh(i)) % 1, yy = topo + u * (FLOOR - topo), xx = cx - meia + hsh(i * 7) * meia * 2 + inc * u + Math.sin(t + i) * 4; R(c, xx, yy, 1, 1, i % 3 ? '#e4f0ff' : '#ffffff'); }
    c.restore();
  }
  // raios de luz do pixelfx (dono 'baile'): ligados enquanto o teto estiver aberto
  function luzPixel(c, cam, t, k) {
    const F = window.FxPixel; if (!F?.pronto?.()) return;
    if (k > .6) { if (!raios || raios.feito) raios = F.tocar('weather/god-rays', { dono: 'baile', x: NPC_X + 40, y: FLOOR, palette: LUAR, duracao: 600, light: .8 }); }
    else if (raios) { raios.parar(); raios = null; }
    F.desenhar(c, { dono: 'baile', camada: 'back', camera: cam, tempo: t }); F.desenhar(c, { dono: 'baile', camada: 'front', camera: cam, tempo: t });
  }
  function estouro(cam) { // o instante em que o teto rasga: estilhaços e poeira (pixelfx)
    const F = window.FxPixel; if (!F?.tocar) return;
    F.tocar('explosions/dirt-explosion', { dono: 'baile', x: NPC_X, y: TETO + 10, palette: ['#1c1c24', '#2a2d3a', '#363a4a', '#4a4e60', '#6a6e80', '#9a9eb0', '#cfd3e0'] });
    F.tocar('spawn/poof', { dono: 'baile', x: NPC_X - 60, y: TETO + 30, palette: window.FxPixel.PAL.poeira }); F.tocar('spawn/poof', { dono: 'baile', x: NPC_X + 70, y: TETO + 26, palette: window.FxPixel.PAL.poeira, atraso: .1 });
  }

  function draw(c, camera = 0, t = 0, opts = {}) {
    const cam = Number(camera) || 0; t = Number(t) || 0;
    const k = Number.isFinite(opts.rombo) ? clamp(opts.rombo, 0, 1) : telhadoAberto ? 1 : 0;
    if (k > 0 && ultimoRombo <= 0 && Number.isFinite(opts.rombo)) estouro(cam); ultimoRombo = k;
    c.save(); c.imageSmoothingEnabled = false;
    ceu(c, cam, t); rua(c, cam, t);
    // corpo do galpão (o teto vai de ponta a ponta; o céu fica por cima)
    interior(c, cam, t); fachada(c, cam, t);
    luzes(c, cam, t);
    { const ini = Math.max(0, PORTA - cam); c.save(); c.beginPath(); c.rect(ini, TETO, W - ini, H - TETO); c.clip(); try { if (window.BailePixel?.palco) window.BailePixel.palco(c, PALCO - cam, t); if (!lite()) window.BailePixel?.fx?.(c, PALCO - cam, t); } catch (e) {} c.restore(); }
    rombo(c, cam, t, k); luzPixel(c, cam, t, k);
    lado_de_fora(c, cam, t);
    multidao(c, cam, t, false); fumaca(c, cam, t);
    multidao(c, cam, t, true);
    // pulsação de cor do grave (suave, sem piscar)
    const ini = Math.max(0, PORTA - cam); if (ini < W) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .035 * (1 - ((t % BEAT) / BEAT)); R(c, ini, TETO, W - ini, H - TETO, NEON[Math.floor(t / BEAT) % 2 ? 0 : 1]); c.restore(); }
    c.restore(); return true;
  }
  // plataformas da fase dentro do galpão viram camarotes de metal com grade e fita de LED (mesma área de pisar)
  function camarote(c, p, t) {
    const [x, y, w] = p; R(c, x, y, w, 10, '#2a2d3a'); R(c, x, y, w, 2, '#6a6e80'); R(c, x, y + 10, w, 2, '#121218');
    for (let k = 0; k < w; k += 8) R(c, x + k, y - 14, 1, 14, '#4a4e60'); R(c, x, y - 15, w, 2, '#8a8ea0');
    for (let k = 0; k < w; k += 6) R(c, x + k, y + 4, 4, 2, NEON[Math.floor(k / 6 + t * 10) % NEON.length]);
    R(c, x + 6, y + 12, 3, 22, '#2a2d3a'); R(c, x + w - 9, y + 12, 3, 22, '#2a2d3a');
  }
  function sincronizar(o = {}) { if (typeof o.telhado === 'boolean') telhadoAberto = o.telhado; }
  window.BaileGalpao = Object.freeze({ draw, sincronizar, camarote, PORTA, FACHADA, PALCO, NPC_X, MC_X, TETO, BPM, aberto: () => telhadoAberto });
})();
