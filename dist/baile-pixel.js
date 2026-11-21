/* Da Roça Adventure — baile funk redesenhado em pixel art (pessoas, palco, rua e o Ollyan).
   Tudo desenhado em baixa resolução (1 pixel da arte = 2 do jogo), com contorno, luz de cima e
   sombra embaixo feitos sozinhos, e quadros de animação no ritmo do baile, guardados em cache.
   O baile.js chama estes desenhos por ganchos (BailePixel.*); a luta, as fases e os golpes
   continuam os mesmos — aqui é só aparência. */
(() => {
  'use strict';
  if (window.BailePixel) return;
  const TAU = Math.PI * 2, BPM = 2.15, N = 8;
  const CONTORNO = [22, 14, 34], PRETO = '#141018', BRANCO = '#ffffff';
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };

  /* ---------- pincel de pixel ---------- */
  let g = null, AX = 0, AY = 0, planas = null;
  const plana = (col) => (planas.add(col), col);
  const r = (x, y, w, h, col) => { w = Math.round(w); h = Math.round(h); if (w <= 0 || h <= 0) return; g.fillStyle = col; g.fillRect(Math.round(x) + AX, Math.round(y) + AY, w, h); };
  const p = (x, y, col) => r(x, y, 1, 1, col);
  const e = (cx, cy, rx, ry, col) => { for (let y = -ry; y <= ry; y++) { const k = y / (ry + .5), w = Math.round(rx * Math.sqrt(Math.max(0, 1 - k * k)) + .25); r(cx - w, cy + y, w * 2 + 1, 1, col); } };
  function poly(pts, col) {
    let y0 = Infinity, y1 = -Infinity; for (const [, y] of pts) { y0 = Math.min(y0, y); y1 = Math.max(y1, y); }
    for (let y = Math.floor(y0); y <= Math.ceil(y1); y++) { const yc = y + .5, xs = [];
      for (let i = 0; i < pts.length; i++) { const [ax, ay] = pts[i], [bx, by] = pts[(i + 1) % pts.length]; if ((ay <= yc && by > yc) || (by <= yc && ay > yc)) xs.push(ax + (yc - ay) / (by - ay) * (bx - ax)); }
      xs.sort((a, b) => a - b); for (let i = 0; i + 1 < xs.length; i += 2) { const a = Math.round(xs[i]), b = Math.round(xs[i + 1]); r(a, y, Math.max(1, b - a), 1, col); } }
  }
  const barra = (x0, y0, x1, y1, w, col) => { const dx = x1 - x0, dy = y1 - y0, L = Math.hypot(dx, dy) || 1, nx = -dy / L * w / 2, ny = dx / L * w / 2; poly([[x0 + nx, y0 + ny], [x1 + nx, y1 + ny], [x1 - nx, y1 - ny], [x0 - nx, y0 - ny]], col); };
  const mistura = (a, b, k) => [0, 1, 2].map((i) => Math.round(a[i] + (b[i] - a[i]) * k));
  const LUZ = [255, 240, 250], SOMBRA = [26, 16, 48];
  function acabamento(cv) { // contorno escuro em volta + luz em cima e sombra embaixo de cada parte
    const W = cv.width, H = cv.height, ctx = cv.getContext('2d'), img = ctx.getImageData(0, 0, W, H), d = img.data, cor = new Int32Array(W * H).fill(-1);
    for (let i = 0; i < W * H; i++) if (d[i * 4 + 3] > 127) cor[i] = (d[i * 4] << 16) | (d[i * 4 + 1] << 8) | d[i * 4 + 2];
    const em = (x, y) => (x < 0 || y < 0 || x >= W || y >= H) ? -1 : cor[y * W + x], plano = new Set([...planas].map((c) => parseInt(c.slice(1), 16))), out = new Uint8ClampedArray(d.length);
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { const i = y * W + x, c = cor[i];
      if (c < 0) { if (em(x - 1, y) >= 0 || em(x + 1, y) >= 0 || em(x, y - 1) >= 0 || em(x, y + 1) >= 0) out.set([...CONTORNO, 255], i * 4); continue; }
      let rgb = [(c >> 16) & 255, (c >> 8) & 255, c & 255];
      if (!plano.has(c)) { const cima = em(x, y - 1) !== c, baixo = em(x, y + 1) !== c, dir = em(x + 1, y) !== c;
        if (cima && !baixo) rgb = mistura(rgb, LUZ, .3); else if (baixo || dir) rgb = mistura(rgb, SOMBRA, baixo && dir ? .42 : .28); else if (em(x, y + 2) !== c) rgb = mistura(rgb, SOMBRA, .12); }
      out.set([...rgb, 255], i * 4); }
    img.data.set(out); ctx.putImageData(img, 0, 0);
  }
  const cache = new Map();
  function sprite(chave, W, H, ax, ay, fn) { // desenha uma vez e guarda (com a silhueta branca para o piscar)
    let q = cache.get(chave); if (q) return q;
    const cv = document.createElement('canvas'); cv.width = W; cv.height = H; g = cv.getContext('2d', { willReadFrequently: true }); AX = ax; AY = ay; planas = new Set([BRANCO, PRETO]);
    try { fn(); acabamento(cv); } catch (err) { try { console.warn('baile', chave, err); } catch (e2) {} }
    const br = document.createElement('canvas'); br.width = W; br.height = H; const b = br.getContext('2d'); b.drawImage(cv, 0, 0); b.globalCompositeOperation = 'source-in'; b.fillStyle = '#fff6ec'; b.fillRect(0, 0, W, H);
    q = { cv, br, ax, ay }; cache.set(chave, q); g = null; return q;
  }
  function pintar(c, q, x, y, s, flip, branco) { c.save(); c.translate(Math.round(x), Math.round(y)); if (flip) c.scale(-1, 1); const sm = c.imageSmoothingEnabled; c.imageSmoothingEnabled = false;
    c.drawImage(branco ? q.br : q.cv, -q.ax * s, -q.ay * s, q.cv.width * s, q.cv.height * s); c.imageSmoothingEnabled = sm; c.restore(); }

  /* ---------- gente do baile: 40 tipos, 7 passos de dança, 8 quadros no ritmo ---------- */
  const PELES = [['#8d583f'], ['#e4b596'], ['#b47c55'], ['#6f4838'], ['#eec9ae'], ['#5c3a2c'], ['#c8946a']].map((a) => a[0]);
  const CABELOS = ['#1b1414', '#3a2418', '#6b3e22', '#c9a050', '#1b1414', '#7a2a4a', '#e8e0d0', '#2a1a3a'];
  const TOPS = ['#e2445c', '#2d9cdb', '#f2c94c', '#27ae60', '#9b51e0', '#f2f2f2', '#262630', '#ff7a45', '#ff6ad5', '#3ad8c8'];
  const BAIXOS = ['#2a3a5c', '#3c3a55', '#1f2a36', '#5a3a2a', '#d6d0c4', '#4a6a9a', '#262630'];
  const TENIS = ['#f4f4f4', '#ff5a5a', '#2d9cdb', '#f2c94c', '#262630', '#7dff9a'];
  function tipo(v) { const h = (k) => hash(v * 13.7 + k * 3.1);
    return { pele: PELES[Math.floor(h(1) * PELES.length)], cabelo: CABELOS[Math.floor(h(2) * CABELOS.length)], penteado: Math.floor(h(3) * 7), top: TOPS[Math.floor(h(4) * TOPS.length)], topo: Math.floor(h(5) * 5),
      baixo: BAIXOS[Math.floor(h(6) * BAIXOS.length)], roupa: Math.floor(h(7) * 3), tenis: TENIS[Math.floor(h(8) * TENIS.length)], oculos: h(9) < .22, corrente: h(10) < .3, brinco: h(11) < .35,
      bone: ['#e2445c', '#262630', '#2d9cdb', '#f2f2f2'][Math.floor(h(12) * 4)], passo: Math.floor(h(13) * 7), bastao: ['#7dff9a', '#ff7ad9', '#7adfff', '#ffe14f'][Math.floor(h(14) * 4)], numero: Math.floor(h(15) * 89) + 10 };
  }
  function pessoa(v, f) { const T = tipo(v), ph = f / N * TAU, b = Math.abs(Math.sin(ph)), s = Math.sin(ph), mv = T.passo;
    let bob = -Math.round(b * 1.4), hx = 0, tx = 0, pe = [[-3, -1], [3, -1]], joelho = 0;
    if (mv === 2) { bob = -Math.round(b * 4); if (b > .6) joelho = 2; }
    if (mv === 4) { hx = Math.round(s * 2); tx = -Math.round(s); joelho = 2; }
    if (mv === 1) { const k = f % 4; if (k === 1 || k === 2) { if (f < 4) pe[0] = [-8, -4]; else pe[1] = [8, -4]; } }
    const quadril = -15 + bob + joelho, ombroY = -25 + bob + joelho, cabecaY = -31 + bob + joelho;
    const pele = T.pele, sk = T.cabelo;
    // cabelo de trás (comprido e black power)
    if (T.penteado === 1) r(tx - 5, cabecaY - 4, 11, 12, sk); if (T.penteado === 0) e(tx, cabecaY - 3, 6, 5, sk);
    // pernas e tênis
    for (const [i, [fx, fy]] of pe.entries()) { const hipX = hx + (i ? 2 : -2), footY = fy - (mv === 2 && b > .6 ? 2 : 0);
      barra(hipX, quadril, fx + hx * .3, footY - 1, 3, T.roupa === 1 ? T.baixo : pele);
      r(fx + hx * .3 - 2, footY - 2, 5, 2, T.tenis); r(fx + hx * .3 - 2, footY - 1 + 1, 5, 1, plana('#e8e8e8')); }
    // short, calça ou saia
    if (T.roupa === 0) { r(hx - 4, quadril - 1, 9, 5, T.baixo); r(hx - 4, quadril + 3, 4, 1, T.baixo); r(hx + 1, quadril + 3, 4, 1, T.baixo); }
    else if (T.roupa === 1) r(hx - 4, quadril - 1, 9, 4, T.baixo);
    else poly([[hx - 4, quadril - 1], [hx + 5, quadril - 1], [hx + 7, quadril + 5], [hx - 6, quadril + 5]], T.baixo);
    // tronco: regata, camiseta, camisa de time, cropped ou jaqueta
    r(tx - 4, ombroY, 9, quadril - ombroY, T.top);
    if (T.topo === 0) { r(tx - 4, ombroY, 2, 2, pele); r(tx + 3, ombroY, 2, 2, pele); }
    if (T.topo === 2) { r(tx - 4, ombroY + 3, 9, 1, BRANCO); p(tx - 1, ombroY + 5, plana('#ffffff')); p(tx + 1, ombroY + 5, BRANCO); p(tx, ombroY + 6, BRANCO); }
    if (T.topo === 3) r(tx - 3, quadril - 3, 7, 2, pele);
    if (T.topo === 4) { r(tx - 1, ombroY, 3, quadril - ombroY, '#262630'); r(tx - 4, ombroY, 2, quadril - ombroY, T.baixo); r(tx + 3, ombroY, 2, quadril - ombroY, T.baixo); }
    // braços conforme o passo
    const ombE = [tx - 4, ombroY + 1], ombD = [tx + 4, ombroY + 1]; let mE, mD, cE, cD;
    if (mv === 0) { mE = [tx - 6 + Math.round(s * 2), ombroY - 11]; mD = [tx + 6 + Math.round(s * 2), ombroY - 12]; cE = [tx - 7, ombroY - 4]; cD = [tx + 7, ombroY - 5]; }
    else if (mv === 1) { mE = [tx - 3, ombroY + 5 - Math.round(b * 2)]; mD = [tx + 3, ombroY + 5 - Math.round((1 - b) * 2)]; cE = [tx - 8, ombroY + 3]; cD = [tx + 8, ombroY + 3]; }
    else if (mv === 2) { mE = [tx - 9, ombroY - 9 - Math.round(b * 2)]; mD = [tx + 9, ombroY - 9 - Math.round(b * 2)]; cE = [tx - 7, ombroY - 3]; cD = [tx + 7, ombroY - 3]; }
    else if (mv === 3) { mE = [tx - 7, ombroY + 8 + Math.round(s)]; mD = [tx + 4, ombroY - 13]; cE = [tx - 6, ombroY + 4]; cD = [tx + 7, ombroY - 6]; }
    else if (mv === 4) { mE = [hx - 5, quadril + 4]; mD = [hx + 5, quadril + 4]; cE = [tx - 7, ombroY + 5]; cD = [tx + 7, ombroY + 5]; }
    else if (mv === 5) { mE = [tx - 4, ombroY - 6 - Math.round(b * 6)]; mD = [tx + 5, quadril]; cE = [tx - 8, ombroY - 2 - Math.round(b * 2)]; cD = [tx + 7, ombroY + 5]; }
    else { mE = [tx - 3 + Math.round(s * 5), ombroY - 12]; mD = [tx + 3 + Math.round(s * 5), ombroY - 12]; cE = [tx - 6, ombroY - 5]; cD = [tx + 6, ombroY - 5]; }
    const manga = T.topo === 1 || T.topo === 2 || T.topo === 4 ? (T.topo === 4 ? T.baixo : T.top) : pele;
    for (const [o, cv, m] of [[ombE, cE, mE], [ombD, cD, mD]]) { barra(o[0], o[1], cv[0], cv[1], 2, manga); barra(cv[0], cv[1], m[0], m[1], 2, pele); r(m[0] - 1, m[1] - 1, 2, 2, pele); }
    if (mv === 3) { r(mD[0] - 1, mD[1] - 5, 3, 5, plana('#1a1a22')); r(mD[0], mD[1] - 4, 1, 3, plana('#c8f4ff')); } // celular filmando
    if (mv === 6) for (const m of [mE, mD]) { r(m[0] - 1, m[1] - 6, 1, 6, plana(T.bastao)); p(m[0] - 1, m[1] - 7, plana('#ffffff')); } // bastão de luz
    // pescoço, cabeça e rosto
    r(tx - 1, cabecaY + 4, 3, 2, pele); e(tx, cabecaY, 4, 4, pele);
    p(tx - 2, cabecaY, plana(PRETO)); p(tx + 1, cabecaY, PRETO); r(tx - 1, cabecaY + 2, 3, 1, plana(b > .7 ? '#5a1a2a' : '#8a3a3a')); // olhos e boca (cantando no tempo)
    p(tx - 3, cabecaY + 1, plana('#e88a8a'));
    // penteados da frente
    const P = T.penteado;
    if (P === 0) r(tx - 4, cabecaY - 4, 9, 1, sk);
    else if (P === 1) { r(tx - 4, cabecaY - 5, 9, 2, sk); r(tx - 4, cabecaY - 3, 2, 1, sk); }
    else if (P === 2) { r(tx - 4, cabecaY - 5, 9, 3, T.bone); r(tx + 2, cabecaY - 3, 4, 1, T.bone); }
    else if (P === 3) { r(tx - 4, cabecaY - 5, 9, 2, sk); r(tx - 5, cabecaY - 3, 1, 9, sk); r(tx + 4, cabecaY - 3, 1, 9, sk); }
    else if (P === 4) { r(tx - 4, cabecaY - 5, 9, 2, sk); e(tx, cabecaY - 7, 2, 2, sk); }
    else if (P === 5) r(tx - 4, cabecaY - 5, 9, 2, sk);
    else { r(tx - 4, cabecaY - 5, 9, 2, sk); r(tx - 4, cabecaY - 3, 9, 1, '#e2445c'); p(tx + 5, cabecaY - 3, '#e2445c'); }
    if (T.oculos) { r(tx - 3, cabecaY - 1, 7, 2, plana('#101018')); p(tx - 2, cabecaY - 1, plana('#8ad8ff')); }
    if (T.corrente) { r(tx - 2, ombroY + 1, 5, 1, plana('#f2c94c')); p(tx, ombroY + 2, '#f2c94c'); }
    if (T.brinco) p(tx - 5, cabecaY + 1, plana('#f2c94c'));
  }
  const VARIANTES = 40;
  function dancer(c, x, y, t, seed = 0, scale = 1) {
    const v = ((seed % VARIANTES) + VARIANTES) % VARIANTES, desloc = (seed % 3) * 2, f = ((Math.floor(t * BPM * 4) + desloc) % N + N) % N;
    const q = sprite('p' + v + '_' + f, 30, 50, 15, 48, () => pessoa(v, f));
    c.save(); c.globalAlpha *= .35; c.fillStyle = '#0a0818'; c.fillRect(Math.round(x - 12 * scale), Math.round(y - 2), Math.round(24 * scale), 3); c.restore(); // sombra
    pintar(c, q, x, y, 2 * scale, (Math.floor(seed / VARIANTES) + seed) % 2 === 1);
    return true;
  }

  /* ---------- Ollyan: magro, bêbado e de orelhas enormes ---------- */
  const OP = { pele: '#ecc4a8', bochecha: '#f08a8a', moletom: '#2e3650', moletomEsc: '#232a40', short: '#3a6aa8', cabelo: '#1e1a26' };
  function orelha(lado, cx, cy, abre) { // orelha grande com o miolo rosado
    const ox = cx + lado * (9 + abre); e(ox, cy, 4 + (abre > 3 ? 1 : 0), 6, OP.pele); e(ox + lado, cy, 2, 4, '#f0a0a8'); p(ox + lado * 2, cy - 5, '#f6d8c4'); }
  function ollyanFesta(f, feliz) { const sw = [0, 1, 2, 1, 0, -1, -2, -1][f], sw2 = Math.round(sw * 1.5), passoE = [0, 1, 2, 1, 0, 0, 0, 0][f], passoD = [0, 0, 0, 0, 0, 1, 2, 1][f];
    // pernas finas e tênis
    barra(-2, -30, -4 - passoE, -3, 2, OP.pele); barra(2, -30, 4 + passoD, -3, 2, OP.pele);
    r(-8 - passoE, -4, 6, 3, '#f4f4f4'); r(-8 - passoE, -2, 6, 1, plana('#e8392e')); r(2 + passoD, -4, 6, 3, '#f4f4f4'); r(2 + passoD, -2, 6, 1, '#e8392e');
    // bermudão
    poly([[Math.round(sw / 2) - 7, -37], [Math.round(sw / 2) + 7, -37], [Math.round(sw / 2) + 8, -27], [Math.round(sw / 2) + 1, -27], [Math.round(sw / 2), -31], [Math.round(sw / 2) - 1, -27], [Math.round(sw / 2) - 8, -27]], OP.short);
    r(Math.round(sw / 2) - 8, -28, 7, 1, '#5a8ac8'); r(Math.round(sw / 2) + 1, -28, 7, 1, '#5a8ac8');
    // moletom com capuz, cordões e bolso
    r(sw - 5, -58, 11, 3, OP.moletomEsc); r(sw - 6, -56, 13, 20, OP.moletom); r(sw - 4, -43, 9, 4, OP.moletomEsc); r(sw - 6, -37, 13, 1, OP.moletomEsc);
    r(sw - 2, -55, 1, 7, plana('#e8e8f0')); r(sw + 2, -55, 1, 6, '#e8e8f0'); p(sw - 2, -48, '#e8e8f0'); p(sw + 2, -49, '#e8e8f0');
    // braços compridos
    if (feliz) { const a = f % 4 < 2 ? 0 : 2; barra(sw - 6, -54, sw - 12, -63 - a, 3, OP.moletom); barra(sw - 12, -63 - a, sw - 10, -71 - a, 2, OP.pele); r(sw - 11, -73 - a, 3, 3, OP.pele);
      barra(sw + 6, -54, sw + 12, -63 + a - 2, 3, OP.moletom); barra(sw + 12, -65 + a, sw + 10, -73 + a, 2, OP.pele); r(sw + 9, -75 + a, 3, 3, OP.pele); }
    else { const fl = [0, -2, -4, -2, 0, 2, 4, 2][f], sl = [0, 1, 2, 1, 0, -1, -2, -1][f];
      barra(sw - 6, -54, sw - 12, -46 + fl, 3, OP.moletom); barra(sw - 12, -46 + fl, sw - 16, -40 + fl * 2, 2, OP.pele); r(sw - 17, -41 + fl * 2, 3, 3, OP.pele); // braço se equilibrando
      barra(sw + 6, -54, sw + 10, -45, 3, OP.moletom); barra(sw + 10, -45, sw + 13, -50 + sl, 2, OP.pele); r(sw + 12, -51 + sl, 3, 3, OP.pele); // braço do copo
      r(sw + 12, -58 + sl, 5, 7, '#e8392e'); r(sw + 12, -58 + sl, 5, 1, plana('#f4f4f4')); p(sw + 13, -56 + sl, '#ff7a6a');
      if (f === 2 || f === 6) { p(sw + 18, -57 + sl, plana('#e8c25a')); p(sw + 19, -55 + sl, '#e8c25a'); } } // bebida derramando
    // cabeça (balança mais que o corpo), orelhonas, cabelo bagunçado e cara de bêbado
    const ab = f % 4 === 1 || f % 4 === 2 ? 1 : 0, hy = -66;
    orelha(-1, sw2, hy - 2, 2 + ab); orelha(1, sw2, hy - 2, 2 + (1 - ab));
    r(sw2 - 1, hy + 6, 3, 3, OP.pele); e(sw2, hy, 6, 7, OP.pele);
    poly([[sw2 - 7, hy - 3], [sw2 - 6, hy - 8], [sw2 - 3, hy - 7], [sw2 - 1, hy - 10], [sw2 + 2, hy - 7], [sw2 + 5, hy - 9], [sw2 + 7, hy - 4], [sw2 + 4, hy - 5], [sw2 + 1, hy - 4], [sw2 - 3, hy - 5]], OP.cabelo);
    if (feliz) { r(sw2 - 4, hy - 1, 2, 1, plana(PRETO)); r(sw2 + 2, hy - 1, 2, 1, PRETO); p(sw2 - 5, hy, PRETO); p(sw2 + 4, hy, PRETO); r(sw2 - 3, hy + 3, 6, 2, plana('#7a2a3a')); r(sw2 - 2, hy + 3, 4, 1, plana(BRANCO)); }
    else { const pisca = f === 5; r(sw2 - 5, hy - 1, 3, pisca ? 1 : 2, plana('#f6ece6')); r(sw2 + 2, hy - 1, 3, pisca ? 1 : 2, '#f6ece6'); if (!pisca) { p(sw2 - 4, hy, plana(PRETO)); p(sw2 + 3, hy, PRETO); }
      r(sw2 - 5, hy - 2, 3, 1, plana('#b8826a')); r(sw2 + 2, hy - 2, 3, 1, '#b8826a'); // pálpebras pesadas
      r(sw2 - 2, hy + 4, 4, 1, plana('#6f3040')); p(sw2 + 2, hy + 3, '#6f3040'); } // sorriso torto
    r(sw2 - 6, hy + 2, 2, 1, plana(OP.bochecha)); r(sw2 + 4, hy + 2, 2, 1, OP.bochecha); p(sw2, hy + 1, '#d8a088');
  }
  function ollyanVoando(f, bravo) { const fl = [-6, -3, 0, 3, 5, 3, 0, -3][f], pe = [0, 1, 1, 0, 0, -1, -1, 0][f];
    // orelhas-asa enormes batendo
    for (const lado of [-1, 1]) { const L = (x) => x * lado;
      poly([[L(5), -42], [L(22), -48 + fl * .4], [L(44), -51 + fl], [L(66), -47 + fl * 1.3], [L(70), -42 + fl * 1.3], [L(56), -36 + fl], [L(38), -32 + fl * .6], [L(20), -33], [L(6), -35]], OP.pele);
      poly([[L(10), -40], [L(26), -44 + fl * .4], [L(46), -46 + fl], [L(60), -43 + fl * 1.2], [L(48), -39 + fl], [L(30), -37 + fl * .5], [L(12), -37]], '#f0a0a8');
      barra(L(24), -41 + fl * .3, L(50), -44 + fl, 1, '#d88890'); barra(L(30), -37 + fl * .4, L(54), -40 + fl, 1, '#d88890'); p(L(64), -45 + fl * 1.3, '#f8dcc8'); }
    // pernas penduradas e tênis
    barra(-2, -14, -4 + pe, -2, 2, OP.pele); barra(2, -14, 4 + pe, -2, 2, OP.pele); r(-7 + pe, -3, 5, 3, '#f4f4f4'); r(2 + pe, -3, 5, 3, '#f4f4f4'); r(-7 + pe, -1, 5, 1, plana('#e8392e')); r(2 + pe, -1, 5, 1, '#e8392e');
    poly([[-6, -20], [6, -20], [7, -13], [-7, -13]], OP.short);
    r(-6, -33, 12, 14, OP.moletom); r(-4, -24, 8, 3, OP.moletomEsc); r(-2, -32, 1, 6, plana('#e8e8f0')); r(2, -32, 1, 5, '#e8e8f0');
    barra(-6, -31, -12, -24, 3, OP.moletom); barra(6, -31, 12, -24, 3, OP.moletom); r(-14, -25, 3, 3, OP.pele); r(11, -25, 3, 3, OP.pele); // braços abertos
    // cabeça brava
    r(-1, -36, 3, 3, OP.pele); e(0, -41, 6, 6, OP.pele);
    poly([[-7, -44], [-6, -49], [-3, -48], [-1, -51], [2, -48], [5, -50], [7, -45], [4, -46], [1, -45], [-3, -46]], OP.cabelo);
    r(-5, -43, 4, 1, plana(PRETO)); r(1, -43, 4, 1, PRETO); p(-2, -42, PRETO); p(1, -42, PRETO); // sobrancelhas para dentro
    r(-5, -41, 3, 2, plana('#f6ece6')); r(2, -41, 3, 2, '#f6ece6'); p(-3, -40, PRETO); p(2, -40, PRETO);
    r(-2, -37, 5, 1, plana(bravo ? '#5a1a2a' : '#6f3040')); if (bravo) r(-1, -36, 3, 1, plana(BRANCO));
    r(-6, -39, 2, 1, plana(OP.bochecha)); r(4, -39, 2, 1, OP.bochecha);
  }
  function ollyan(c, x, y, t = 0, o = {}) {
    const s = Number.isFinite(Number(o.scale)) ? Number(o.scale) : 1, face = o.facing === -1, voa = !!o.flying;
    if (voa) {
      const f = Math.floor(t * (o.fast ? 15 : 10)) % N, q = sprite('ov' + f + (o.hit ? 'b' : ''), 150, 60, 75, 56, () => ollyanVoando(f, true));
      c.save(); c.translate(Math.round(x), Math.round(y)); c.rotate(Number(o.angle) || 0);
      if (o.aura) { c.save(); c.globalAlpha *= .22; const gr = c.createRadialGradient(0, -44, 0, 0, -44, 100); gr.addColorStop(0, o.aura); gr.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = gr; c.fillRect(-100, -144, 200, 200); c.restore();
        for (let i = 0; i < 6; i++) { const a = t * .8 + i * TAU / 6; c.fillStyle = o.aura; c.fillRect(Math.round(Math.cos(a) * 82), Math.round(-44 + Math.sin(a) * 68), 4, 4); } }
      pintar(c, q, 0, 0, 1.9 * s, face); if (o.hit && Math.floor(t * 18) % 2 === 0) { c.globalAlpha *= .85; pintar(c, q, 0, 0, 1.9 * s, face, true); }
      c.restore(); return true;
    }
    const feliz = o.cup === false, f = Math.floor(t * (feliz ? BPM * 4 : 5)) % N, q = sprite('of' + f + (feliz ? 'f' : 'b'), 60, 82, 30, 80, () => ollyanFesta(f, feliz));
    c.save(); c.globalAlpha *= .35; c.fillStyle = '#0a0818'; c.fillRect(Math.round(x - 16 * s), Math.round(y - 2), Math.round(32 * s), 4); c.restore();
    pintar(c, q, x, y, 2 * s, face); if (o.hit) { c.save(); c.globalAlpha *= .6; pintar(c, q, x, y, 2 * s, face, true); c.restore(); }
    if (!feliz) { const hic = (t * .45) % 1; if (hic < .3) { c.save(); c.globalAlpha *= 1 - hic / .3; c.font = 'bold 11px monospace'; c.textAlign = 'center'; c.fillStyle = '#101a30'; c.fillText('hic!', x + (face ? -26 : 26) + 1, y - 150 - hic * 30 + 2); c.fillStyle = '#ffd0e0'; c.fillText('hic!', x + (face ? -26 : 26), y - 150 - hic * 30); c.restore(); } }
    return true;
  }

  /* ---------- palco: DJ, MC, dançarinas, paredão, telão de LED, luzes e faíscas ---------- */
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  function djSprite(f) { const ph = f / N * TAU, b = Math.abs(Math.sin(ph)), nod = Math.round(b * 2), mao = f % 4 < 2;
    r(-6, -22 + nod, 13, 14, '#262630'); r(-6, -22 + nod, 13, 2, '#e2445c'); p(0, -18 + nod, plana('#f2c94c')); // camisa preta com faixa
    barra(-5, -20 + nod, -10, -10, 3, '#262630'); r(-12, -11, 4, 3, '#8d583f'); // mão no toca-discos
    if (mao) { barra(6, -20 + nod, 11, -30, 3, '#262630'); r(10, -34, 3, 4, '#8d583f'); } else { barra(6, -20 + nod, 11, -12, 3, '#262630'); r(10, -13, 4, 3, '#8d583f'); }
    r(-1, -25 + nod, 3, 3, '#8d583f'); e(0, -30 + nod, 5, 5, '#8d583f');
    r(-5, -36 + nod, 11, 3, '#262630'); r(0, -34 + nod, 7, 1, '#262630'); // boné virado
    r(-7, -32 + nod, 2, 5, plana('#e2445c')); r(6, -32 + nod, 2, 5, '#e2445c'); r(-6, -36 + nod, 13, 1, '#3a3a48'); // fone de ouvido
    r(-3, -31 + nod, 6, 2, plana('#101018')); p(-2, -31 + nod, plana('#8ad8ff')); r(-1, -27 + nod, 3, 1, plana('#5a1a2a')); }
  function mcSprite(f) { const ph = f / N * TAU, b = Math.abs(Math.sin(ph)), y0 = -Math.round(b * 4);
    barra(-2, -14 + y0, -4, -2 + y0 / 2, 3, '#1f2a36'); barra(2, -14 + y0, 4, -2 + y0 / 2, 3, '#1f2a36'); r(-7, -3 + y0 / 2, 5, 2, '#f4f4f4'); r(2, -3 + y0 / 2, 5, 2, '#f4f4f4');
    r(-5, -26 + y0, 11, 13, '#f2c94c'); r(-5, -20 + y0, 11, 1, '#262630'); r(-2, -25 + y0, 5, 1, plana('#f2c94c'));
    barra(-5, -24 + y0, -9, -18 + y0, 2, '#8d583f'); barra(-9, -18 + y0, -6, -27 + y0, 2, '#8d583f'); r(-7, -31 + y0, 3, 4, plana('#262630')); p(-6, -32 + y0, plana('#b8bcc0')); // microfone
    const ap = f % 4 < 2 ? -14 : -8; barra(5, -24 + y0, 11, ap + y0, 2, '#8d583f'); r(10, ap - 1 + y0, 3, 3, '#8d583f'); // apontando para a galera
    r(-1, -29 + y0, 3, 3, '#8d583f'); e(0, -33 + y0, 4, 4, '#8d583f'); e(0, -36 + y0, 5, 3, '#1b1414'); r(-2, -33 + y0, 1, 1, plana(PRETO)); p(1, -33 + y0, PRETO); r(-1, -30 + y0, 3, 2, plana('#5a1a2a')); r(-4, -26 + y0, 9, 1, plana('#f2c94c')); }
  function palco(c, x, t) {
    const beat = t * BPM, b = Math.pow(Math.max(0, Math.sin(beat * Math.PI * 2)), 3), bar = Math.floor(beat / 4), f = Math.floor(beat * 4) % N;
    c.save(); c.translate(Math.round(x), 0); c.imageSmoothingEnabled = false;
    // estrutura: fundo, cortina com brilho e treliças
    R(c, -300, 140, 600, 300, '#140f28'); for (let yy = 150; yy < 400; yy += 6) for (let xx = -290; xx < 290; xx += 6) { const k = hash(xx * 3 + yy * 7); if (k > .93) R(c, xx, yy, 2, 2, Math.sin(t * 3 + k * 40) > .4 ? '#c8a0ff' : '#4a3a7a'); }
    for (const xx of [-300, 290]) { R(c, xx, 120, 10, 300, '#5a6a80'); for (let yy = 124; yy < 410; yy += 16) { c.strokeStyle = '#a8b8c8'; c.lineWidth = 1; c.beginPath(); c.moveTo(xx, yy); c.lineTo(xx + 10, yy + 8); c.lineTo(xx, yy + 16); c.stroke(); } }
    R(c, -300, 118, 600, 12, '#5a6a80'); for (let xx = -300; xx < 300; xx += 16) { c.strokeStyle = '#a8b8c8'; c.beginPath(); c.moveTo(xx, 118); c.lineTo(xx + 8, 130); c.lineTo(xx + 16, 118); c.stroke(); }
    // faixa no alto
    R(c, -130, 96, 260, 22, '#2a1a40'); R(c, -127, 99, 254, 16, '#e2445c'); c.font = 'bold 12px monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#fff2d8'; c.fillText('★ BAILE DA ROÇA ★', 0, 108);
    // telão de LED (muda a cada 4 compassos)
    const LX = -160, LY = 150, LW = 320, LH = 100, cel = 5; R(c, LX - 4, LY - 4, LW + 8, LH + 8, '#0a0810'); R(c, LX, LY, LW, LH, '#06040c');
    const modo = bar % 3;
    for (let gy = 0; gy < LH / cel; gy++) for (let gx = 0; gx < LW / cel; gx++) { let col = null; const cx = gx - LW / cel / 2, cy = gy - LH / cel / 2;
      if (modo === 0) { const h = Math.round((Math.abs(Math.sin(t * 5 + gx * .45)) * .7 + b * .5) * LH / cel); if (LH / cel - gy <= h) col = gy < 5 ? '#ff4f6a' : gy < 10 ? '#ffe14f' : '#4fd8ff'; }
      else if (modo === 1) { const d = Math.hypot(cx, cy * 1.6), k = (d - t * 10) % 8; if (k > -1 && k < 1.5 || k > 7) col = ['#ff4fd8', '#4fd8ff', '#7dff6a'][Math.floor((d - t * 10) / 8 + 99) % 3]; }
      else { const hx = cx / 7, hy = cy / 7 + .3, coracao = Math.pow(hx * hx + hy * hy - 1, 3) - hx * hx * hy * hy * hy; if (coracao < 0) col = b > .5 ? '#ff5a8a' : '#e2445c'; else if (hash(gx * 31 + gy * 17 + Math.floor(t * 6)) > .985) col = '#ffffff'; }
      if (col) R(c, LX + gx * cel, LY + gy * cel, cel - 1, cel - 1, col); }
    if (modo === 1) { c.font = 'bold 22px monospace'; c.fillStyle = '#ffffff'; c.globalAlpha = .9; c.fillText('ROÇA NO GRAVE', 0, LY + LH / 2); c.globalAlpha = 1; }
    // paredão de som dos dois lados (cones pulsando)
    for (const lado of [-1, 1]) { const sx = lado * 235; for (let k = 0; k < 3; k++) for (let j = 0; j < 2; j++) { const bx = sx - 34 + j * 34, by = 268 + k * 46;
      R(c, bx, by, 32, 44, '#0e0e16'); R(c, bx + 2, by + 2, 28, 40, '#22222e'); const pr = 11 + Math.round(b * 2); c.fillStyle = '#4a4a5a'; c.beginPath(); c.arc(bx + 16, by + 22, pr, 0, TAU); c.fill(); c.fillStyle = '#16161e'; c.beginPath(); c.arc(bx + 16, by + 22, pr - 4, 0, TAU); c.fill(); c.fillStyle = '#6a6a7a'; c.beginPath(); c.arc(bx + 16, by + 22, 3 + Math.round(b * 2), 0, TAU); c.fill();
      R(c, bx + 4, by + 4, 2, 2, (Math.floor(beat * 2) + k + j) % 2 ? '#7dff6a' : '#2a4a2a'); } }
    // palco, beirada com luzinhas correndo e escadinhas
    R(c, -290, 404, 580, 36, '#2a2040'); R(c, -290, 404, 580, 4, '#e8b88a'); for (let i = 0; i < 36; i++) R(c, -284 + i * 16, 412, 6, 4, (i + Math.floor(beat * 4)) % 6 < 2 ? ['#ff4fd8', '#4fd8ff', '#ffe14f'][i % 3] : '#3a2a50');
    // cabine do DJ com toca-discos girando, mixer e notebook
    const dj = sprite('dj' + f, 30, 40, 15, 38, () => djSprite(f)); pintar(c, dj, 0, 352, 2, false);
    R(c, -70, 336, 140, 52, '#1a1428'); R(c, -66, 340, 132, 6, '#3a3050'); R(c, -66, 350, 132, 34, '#2a2040'); c.font = 'bold 10px monospace'; c.fillStyle = '#ff7ad9'; c.fillText('DJ CHAPÉU', 0, 368);
    for (const dx of [-44, 44]) { c.fillStyle = '#0a0a10'; c.beginPath(); c.ellipse(dx, 340, 16, 5, 0, 0, TAU); c.fill(); const a = t * 6; R(c, dx + Math.cos(a) * 10 - 1, 340 + Math.sin(a) * 3 - 1, 3, 2, '#e8e8f0'); }
    for (let i = 0; i < 6; i++) R(c, -12 + i * 4, 338, 2, 2, (i + f) % 3 ? '#7dff6a' : '#ff4f6a');
    // MC e dançarinas nos queijinhos
    const mc = sprite('mc' + f, 30, 44, 15, 42, () => mcSprite(f)); pintar(c, mc, -140, 404, 2, false);
    for (const [dx, sd] of [[150, 7], [210, 12]]) { R(c, dx - 20, 388, 40, 16, '#3a2a50'); R(c, dx - 20, 388, 40, 3, '#ff7ad9'); dancer(c, dx, 388, t + .25, sd, 1.15); }
    // faíscas (chafariz de fogo frio) a cada 8 tempos e jato de fumaça a cada 16
    const k8 = (beat % 8) / 8; if (k8 < .3) { const u = k8 / .3; for (const fx of [-260, -100, 100, 260]) for (let i = 0; i < 18; i++) { const h = hash(i * 7 + fx), vy = 170 + h * 90, px = fx + (h - .5) * 30 * u, py = 404 - vy * u + 160 * u * u; c.globalAlpha = 1 - u; R(c, px, py, 2, 3, h > .5 ? '#ffe9a0' : '#ffffff'); } c.globalAlpha = 1; }
    const k16 = (beat % 16) / 16; if (k16 > .5 && k16 < .66) { const u = (k16 - .5) / .16; for (const fx of [-200, 200]) { c.globalAlpha = (1 - u) * .7; for (let i = 0; i < 6; i++) { c.fillStyle = '#f0f0ff'; c.beginPath(); c.ellipse(fx + Math.sin(i * 2) * 8, 404 - i * 30 * (.4 + u), 12 + i * 4, 10 + i * 2, 0, 0, TAU); c.fill(); } } c.globalAlpha = 1; }
    // cabeças móveis na treliça
    for (let i = 0; i < 6; i++) { const lx = -250 + i * 100, ang = Math.PI / 2 + Math.sin(t * (.7 + i * .1) + i) * .7, col = ['#ff4fd8', '#4fd8ff', '#ffe14f', '#7dff6a'][(i + bar) % 4];
      c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .1 + b * .08; c.fillStyle = col; c.beginPath(); c.moveTo(lx, 132); c.lineTo(lx + Math.cos(ang - .1) * 420, 132 + Math.sin(ang - .1) * 420); c.lineTo(lx + Math.cos(ang + .1) * 420, 132 + Math.sin(ang + .1) * 420); c.closePath(); c.fill(); c.restore();
      R(c, lx - 6, 128, 12, 8, '#2a2a38'); R(c, lx - 3, 134, 6, 3, col); }
    c.restore(); return true;
  }
  function fx(c, x, t) { // lasers, névoa, confete e flash no tempo
    const beat = t * BPM, b = Math.pow(Math.max(0, Math.sin(beat * Math.PI * 2)), 3), bar = Math.floor(beat / 4);
    c.save(); c.translate(Math.round(x), 0); c.save(); c.globalCompositeOperation = 'lighter';
    for (let i = 0; i < 8; i++) { const a = -Math.PI / 2 + Math.sin(t * (.6 + i * .07) + i * 1.3) * .9, col = ['#ff4fd8', '#4fd8ff', '#7dff6a', '#ffe14f'][(i + bar) % 4]; c.globalAlpha = .13 + .12 * b; c.strokeStyle = col; c.lineWidth = 2; c.beginPath(); c.moveTo((i - 3.5) * 60, 128); c.lineTo((i - 3.5) * 60 + Math.cos(a) * 900, 128 + Math.sin(a) * 900); c.stroke(); }
    c.restore();
    for (let i = 0; i < 10; i++) { const fxx = -300 + i * 66 + Math.sin(t * .4 + i) * 20, fy = 410 + Math.sin(t * .6 + i * 2) * 6; c.save(); c.globalAlpha = .14; c.fillStyle = '#cdb8ee'; c.beginPath(); c.ellipse(fxx, fy, 62, 16, 0, 0, TAU); c.fill(); c.restore(); }
    const cb = (beat % 16) / 16; if (cb < .35) { const k = cb / .35; for (let i = 0; i < 60; i++) { const side = i % 2 ? 1 : -1, a = -Math.PI / 2 + side * (.15 + ((i * 37) % 50) / 100), v = 280 * (1 - k * .3); c.save(); c.globalAlpha = 1 - k; c.fillStyle = ['#ff4fd8', '#4fd8ff', '#7dff6a', '#ffe14f', '#ffffff'][i % 5]; c.fillRect(Math.round(side * 250 + Math.cos(a) * v * k + Math.sin(t * 9 + i) * 4), Math.round(130 + Math.sin(a) * v * k + k * k * 260), i % 3 ? 4 : 2, i % 3 ? 2 : 4); c.restore(); } }
    c.restore();
    if (beat % 8 < .06) { c.save(); c.globalAlpha = .12; c.fillStyle = '#ffffff'; c.fillRect(0, 0, 960, 540); c.restore(); }
    return true;
  }

  /* ---------- a rua do baile: paredão de carro, barracas, bandeirinhas ---------- */
  function cenario(c, camera, t) {
    const beat = t * BPM, b = Math.pow(Math.max(0, Math.sin(beat * Math.PI * 2)), 3);
    const vis = (wx, w) => wx - camera > -w && wx - camera < 960 + w;
    c.save(); c.imageSmoothingEnabled = false;
    // bandeirinhas atravessando a rua
    for (let i = 0; i < 9; i++) { const x0 = i * 560 - camera * .9 + 80; if (x0 < -560 || x0 > 960) continue; for (let k = 0; k < 28; k++) { const px = x0 + k * 20, py = 236 + Math.sin(k / 27 * Math.PI) * 26 + Math.sin(t * 2 + k) * 1.5; c.fillStyle = ['#e2445c', '#f2c94c', '#2d9cdb', '#27ae60', '#ff7ad9'][(k + i) % 5]; c.beginPath(); c.moveTo(px, py); c.lineTo(px + 10, py); c.lineTo(px + 5, py + 10); c.closePath(); c.fill(); } }
    // carro de paredão com o porta-malas aberto
    for (const wx of [820, 3880]) { if (!vis(wx, 220)) continue; const x = wx - camera, y = 368;
      R(c, x - 110, y - 46, 220, 42, '#1a1a2a'); R(c, x - 106, y - 42, 212, 34, '#c8303a'); R(c, x - 60, y - 70, 110, 26, '#c8303a'); R(c, x - 54, y - 66, 46, 18, '#8ac0e0'); R(c, x - 2, y - 66, 44, 18, '#8ac0e0'); R(c, x - 106, y - 26, 212, 3, '#ffffff55');
      for (const wxx of [-70, 70]) { c.fillStyle = '#101018'; c.beginPath(); c.arc(x + wxx, y - 4, 15, 0, TAU); c.fill(); c.fillStyle = '#b8bcc0'; c.beginPath(); c.arc(x + wxx, y - 4, 6, 0, TAU); c.fill(); }
      R(c, x + 106, y - 108, 70, 66, '#14141e'); R(c, x + 104, y - 112, 74, 6, '#c8303a'); // tampa aberta
      for (let k = 0; k < 2; k++) for (let j = 0; j < 2; j++) { const cx = x + 124 + j * 34, cy = y - 92 + k * 30, pr = 12 + Math.round(b * 3); c.fillStyle = '#3a3a4a'; c.beginPath(); c.arc(cx, cy, pr, 0, TAU); c.fill(); c.fillStyle = '#0e0e16'; c.beginPath(); c.arc(cx, cy, pr - 5, 0, TAU); c.fill(); }
      c.save(); c.globalAlpha = .15 + b * .25; c.strokeStyle = '#ff7ad9'; c.lineWidth = 2; for (let k = 1; k <= 3; k++) { c.beginPath(); c.arc(x + 140, y - 78, 30 + k * 18 + b * 10, -1.2, 1.2); c.stroke(); } c.restore(); // ondas do grave
      R(c, x - 106, y - 10, 212, 4, (Math.floor(beat * 4) % 2) ? '#4fd8ff' : '#ff4fd8'); } // neon embaixo
    // barraca de espetinho com fumaça e barraca de bebida
    for (const [wx, nome, cor] of [[1500, 'ESPETINHO', '#e8a23a'], [2860, 'GELADINHO', '#3ad8c8'], [4400, 'AÇAÍ', '#9b51e0']]) { if (!vis(wx, 160)) continue; const x = wx - camera, y = 372;
      R(c, x - 70, y - 96, 140, 14, cor); for (let k = 0; k < 7; k++) R(c, x - 70 + k * 20, y - 82, 10, 8, cor); for (let k = 0; k < 7; k++) R(c, x - 60 + k * 20, y - 82, 10, 8, '#f4f4f4'); // toldo listrado
      R(c, x - 66, y - 82, 4, 82, '#5a4a3a'); R(c, x + 62, y - 82, 4, 82, '#5a4a3a'); R(c, x - 70, y - 40, 140, 40, '#6a4a30'); R(c, x - 70, y - 40, 140, 4, '#8a6a40');
      c.font = 'bold 10px monospace'; c.textAlign = 'center'; c.fillStyle = '#fff2d8'; c.fillText(nome, x, y - 22);
      for (let k = 0; k < 8; k++) { const lx = x - 64 + k * 18; R(c, lx, y - 74, 4, 4, Math.sin(t * 4 + k) > 0 ? '#ffe9a0' : '#a8884a'); } // luzinhas
      if (nome === 'ESPETINHO') { R(c, x - 40, y - 50, 50, 8, '#2a2a2a'); for (let k = 0; k < 6; k++) R(c, x - 36 + k * 8, y - 54, 2, 6, '#c86a3a'); for (let k = 0; k < 5; k++) { const u = (t * .5 + k / 5) % 1; c.globalAlpha = (1 - u) * .35; c.fillStyle = '#d8d8e0'; c.beginPath(); c.arc(x - 16 + Math.sin(u * 6 + k) * 8, y - 58 - u * 60, 6 + u * 10, 0, TAU); c.fill(); } c.globalAlpha = 1; }
      else for (let k = 0; k < 5; k++) R(c, x - 40 + k * 18, y - 52, 8, 12, ['#e2445c', '#f2c94c', '#3ad8c8', '#7dff6a', '#ff7ad9'][k]); }
    c.restore(); return true;
  }


  /* ---------- efeitos dos ataques do Ollyan (só aparência: tamanhos e posições que acertam continuam os mesmos) ---------- */
  const ADD = (c, fn) => { c.save(); c.globalCompositeOperation = 'lighter'; try { fn(); } finally { c.restore(); } };
  function brilho(c, x, y, rr, col, a) { c.save(); c.globalAlpha *= a; const gr = c.createRadialGradient(x, y, 0, x, y, rr); gr.addColorStop(0, col); gr.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = gr; c.fillRect(x - rr, y - rr, rr * 2, rr * 2); c.restore(); }
  function nuvemPx(c, x, y, k, col, borda) { // nuvem em pixels com contorno
    const b = (dx, dy, w, h) => { R(c, x + dx * k - 2, y + dy * k - 2, w * k + 4, h * k + 4, borda); };
    const f = (dx, dy, w, h, cc) => R(c, x + dx * k, y + dy * k, w * k, h * k, cc);
    b(-14, -2, 30, 8); b(-9, -7, 12, 6); b(0, -9, 12, 8);
    f(-14, -2, 30, 8, col); f(-9, -7, 12, 6, col); f(0, -9, 12, 8, col); f(-9, -7, 12, 2, '#ffffff55'); f(0, -9, 12, 2, '#ffffff66'); f(-14, 4, 30, 2, '#00000022'); }
  function raio(c, x0, y0, x1, y1, seed, col) { // raio em zigue-zague
    const pts = [[x0, y0]]; const n = 9; for (let i = 1; i < n; i++) { const u = i / n; pts.push([x0 + (x1 - x0) * u + (hash(seed + i) - .5) * 34, y0 + (y1 - y0) * u]); } pts.push([x1, y1]);
    for (const [w, cc, a] of [[10, col, .25], [5, col, .7], [2, '#ffffff', 1]]) { c.save(); c.globalAlpha *= a; c.strokeStyle = cc; c.lineWidth = w; c.lineJoin = 'miter'; c.beginPath(); pts.forEach(([px, py], i) => i ? c.lineTo(px, py) : c.moveTo(px, py)); c.stroke(); c.restore(); } }
  function mira(c, x, y, t, col, rr = 22) { // retícula girando
    c.save(); c.translate(Math.round(x), Math.round(y)); c.rotate(t * 2.4); c.strokeStyle = col; c.lineWidth = 2; const k = rr + Math.sin(t * 9) * 3;
    for (let i = 0; i < 4; i++) { c.rotate(Math.PI / 2); c.beginPath(); c.moveTo(k, -6); c.lineTo(k, -k * .25 - 2); c.moveTo(k, 6); c.lineTo(k, k * .25 + 2); c.stroke(); R(c, k - 1, -1, 3, 3, col); }
    c.restore(); R(c, x - 2, y - 2, 4, 4, '#ffffff'); }
  const ORELHA = [[-10, -4], [-4, -12], [8, -12], [12, -3], [6, 10], [-5, 8]];
  function projetil(c, a, t) {
    if (a.owner === 'player') return false;
    const sp = Math.hypot(a.vx, a.vy) || 1, ux = a.vx / sp, uy = a.vy / sp;
    c.save(); if (a.delay > 0) c.globalAlpha *= .3;
    if (a.type === 'ear') { // orelha bumerangue com rastro de vento rosa
      for (let i = 4; i >= 1; i--) { c.save(); c.globalAlpha *= .14 * (5 - i); c.translate(a.x - ux * i * 9, a.y - uy * i * 9); c.rotate((t - i * .03) * 4 * (a.spin || 1)); c.fillStyle = '#ff9ac8'; c.beginPath(); ORELHA.forEach(([px, py], j) => j ? c.lineTo(px, py) : c.moveTo(px, py)); c.closePath(); c.fill(); c.restore(); }
      ADD(c, () => brilho(c, a.x, a.y, 22, '#ff7ad9', .35));
      c.translate(Math.round(a.x), Math.round(a.y)); c.rotate(t * 4 * (a.spin || 1));
      c.fillStyle = '#2a1420'; c.beginPath(); ORELHA.forEach(([px, py], j) => j ? c.lineTo(px * 1.18, py * 1.18) : c.moveTo(px * 1.18, py * 1.18)); c.closePath(); c.fill();
      c.fillStyle = '#ecc4a8'; c.beginPath(); ORELHA.forEach(([px, py], j) => j ? c.lineTo(px, py) : c.moveTo(px, py)); c.closePath(); c.fill();
      c.fillStyle = '#f0a0a8'; c.beginPath(); ORELHA.forEach(([px, py], j) => j ? c.lineTo(px * .55, py * .55) : c.moveTo(px * .55, py * .55)); c.closePath(); c.fill(); R(c, -2, -9, 5, 2, '#fff0e0');
    } else if (a.type === 'pulse') { // bola de grave: anéis pulsando e uma notinha musical
      const k = (t * 3 + (a.spin || 0)) % 1;
      ADD(c, () => { brilho(c, a.x, a.y, 26, '#4fd8ff', .4); c.strokeStyle = '#7adfff'; c.lineWidth = 2; c.globalAlpha = 1 - k; c.beginPath(); c.arc(a.x, a.y, 8 + k * 14, 0, TAU); c.stroke(); });
      for (let i = 1; i <= 3; i++) { c.save(); c.globalAlpha *= .2; R(c, a.x - ux * i * 10 - 3, a.y - uy * i * 10 - 3, 6, 6, '#7adfff'); c.restore(); }
      c.fillStyle = '#16122a'; c.beginPath(); c.arc(a.x, a.y, 9, 0, TAU); c.fill(); c.fillStyle = '#7adfff'; c.beginPath(); c.arc(a.x, a.y, 7, 0, TAU); c.fill(); c.fillStyle = '#e8fcff'; c.beginPath(); c.arc(a.x - 2, a.y - 2, 3, 0, TAU); c.fill();
      R(c, a.x + 1, a.y - 5, 2, 8, '#16122a'); R(c, a.x - 2, a.y + 1, 4, 3, '#16122a'); R(c, a.x + 3, a.y - 5, 3, 2, '#16122a'); // ♪
    } else if (a.type === 'comet') { // cometa lilás com cauda e faíscas
      ADD(c, () => { const tl = 70; const gr = c.createLinearGradient(a.x, a.y, a.x - ux * tl, a.y - uy * tl); gr.addColorStop(0, 'rgba(200,170,255,.9)'); gr.addColorStop(1, 'rgba(120,80,220,0)'); c.fillStyle = gr; c.beginPath(); c.moveTo(a.x + uy * 11, a.y - ux * 11); c.lineTo(a.x - ux * tl, a.y - uy * tl); c.lineTo(a.x - uy * 11, a.y + ux * 11); c.closePath(); c.fill(); brilho(c, a.x, a.y, 30, '#c8a8ff', .55); });
      for (let i = 0; i < 5; i++) { const h = hash(i * 13 + Math.floor(t * 12)), d = 14 + h * 50; R(c, a.x - ux * d + (h - .5) * 14, a.y - uy * d + (hash(i + 7) - .5) * 14, 2, 2, h > .5 ? '#ffffff' : '#ffd8f0'); }
      c.fillStyle = '#2a1a4a'; c.beginPath(); c.arc(a.x, a.y, 12, 0, TAU); c.fill(); c.fillStyle = '#8a6ad8'; c.beginPath(); c.arc(a.x, a.y, 10, 0, TAU); c.fill(); c.fillStyle = '#d8c8ff'; c.beginPath(); c.arc(a.x + ux * 3, a.y + uy * 3, 6, 0, TAU); c.fill(); R(c, a.x + ux * 4 - 2, a.y + uy * 4 - 2, 4, 4, '#ffffff');
    } else { c.restore(); return false; }
    c.restore(); return true;
  }
  function perigo(c, h, t) {
    c.save();
    if (h.type === 'gate') { // muralha de nuvens de tempestade com o vão marcado
      const x = h.delay > 0 ? 930 : h.x, alerta = h.delay > 0; c.globalAlpha *= alerta ? .5 : 1;
      for (let yy = 90; yy < 494; yy += 29) { if (Math.abs(yy - h.gapY) < h.gapSize * .5) continue; nuvemPx(c, x - 10 + Math.sin(yy + t * 2) * 3, yy + 4, 2, alerta ? '#b8c8e0' : '#8a98c0', '#2a2a48'); }
      if (!alerta && hash(Math.floor(t * 7) + h.gapY) > .82) { const yy = 90 + hash(Math.floor(t * 7) * 3) * 380; if (Math.abs(yy - h.gapY) > h.gapSize * .5 + 20) ADD(c, () => raio(c, x - 30, yy - 20, x + 20, yy + 30, Math.floor(t * 7), '#c8d8ff')); }
      for (let i = 0; i < 6; i++) { const wy = 90 + hash(i * 3 + h.gapY) * 400, wx = x + 40 + ((t * 300 + i * 70) % 160); if (Math.abs(wy - h.gapY) < h.gapSize * .5) continue; c.save(); c.globalAlpha *= .4; R(c, wx, wy, 26, 2, '#e8f0ff'); c.restore(); } // vento
      if (alerta) { const g0 = h.gapY - h.gapSize * .5, g1 = h.gapY + h.gapSize * .5, pis = Math.sin(t * 12) > 0;
        c.strokeStyle = pis ? '#9affb0' : '#58c878'; c.lineWidth = 3; c.beginPath(); c.moveTo(884, g0); c.lineTo(906, g0); c.lineTo(906, g1); c.lineTo(884, g1); c.stroke();
        for (let k = 0; k < 3; k++) { const ax = 840 + ((t * 60 + k * 18) % 54); R(c, ax, h.gapY - 1, 10, 3, '#9affb0'); R(c, ax + 6, h.gapY - 4, 3, 9, '#9affb0'); }
        c.font = 'bold 11px monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#101a30'; c.fillText('VÃO', 872, h.gapY - 14); c.fillStyle = '#c7efcc'; c.fillText('VÃO', 871, h.gapY - 15); }
    } else if (h.type === 'cloudStorm') { // nuvem escura carregando e raio caindo na plataforma
      const carga = h.delay > 0; nuvemPx(c, h.x, 104, 2.2, carga ? '#4a4a6a' : '#2a2a40', '#141428');
      if (carga) { const pisca = Math.sin(t * (10 + (1.1 - h.delay) * 20)) > 0; c.globalAlpha *= pisca ? .55 : .25; R(c, h.x - 38, h.y + 4, 76, 6, '#ffb040'); R(c, h.x - 38, h.y + 2, 76, 2, '#ffe9a0'); c.globalAlpha = 1;
        for (let k = 0; k < 4; k++) { const u = (t * 2 + k / 4) % 1; c.save(); c.globalAlpha *= .6 * (1 - u); R(c, h.x - 30 + k * 18, 116 + u * (h.y - 120), 2, 6, '#a8c8ff'); c.restore(); } // chuvinha
        if (Math.sin(t * 17) > .9) ADD(c, () => brilho(c, h.x, 104, 50, '#c8d8ff', .5)); }
      else { ADD(c, () => { raio(c, h.x, 116, h.x + (hash(h.x) - .5) * 20, h.y, Math.floor(t * 30) + h.x, '#d8e8ff'); brilho(c, h.x, h.y, 60, '#e8f0ff', .7); });
        for (let i = 0; i < 10; i++) { const a = i / 10 * Math.PI, d = 10 + hash(i + Math.floor(t * 30)) * 30; R(c, h.x + Math.cos(a) * d * (i % 2 ? 1 : -1), h.y - Math.sin(a) * d * .6, 3, 3, '#ffffff'); } }
    } else if (h.type === 'beam') { // luar cortante
      const dx = h.tx - h.x, dy = h.ty - h.y, len = Math.hypot(dx, dy) || 1, ex = h.x + dx / len * 1200, ey = h.y + dy / len * 1200;
      if (h.delay > 0) { c.save(); c.setLineDash([12, 9]); c.lineDashOffset = -t * 60; c.strokeStyle = Math.sin(t * 20) > 0 ? '#ffd0b0' : '#f59a7a'; c.lineWidth = 2; c.beginPath(); c.moveTo(h.x, h.y); c.lineTo(ex, ey); c.stroke(); c.restore(); mira(c, h.tx, h.ty, t, '#ffc8a8', 18 + h.delay * 30);
        ADD(c, () => brilho(c, h.x, h.y, 20 + (1 - h.delay / .3) * 26, '#e8d8ff', .8)); }
      else { ADD(c, () => { for (const [w, col, al] of [[64, '#6a3aa8', .35], [40, '#b890e8', .55], [20, '#e8d8ff', .9], [8, '#ffffff', 1]]) { c.save(); c.globalAlpha *= al; c.strokeStyle = col; c.lineWidth = w + Math.sin(t * 40) * 3; c.lineCap = 'round'; c.beginPath(); c.moveTo(h.x, h.y); c.lineTo(ex, ey); c.stroke(); c.restore(); } brilho(c, h.x, h.y, 70, '#f0e0ff', .9); });
        for (let i = 0; i < 16; i++) { const u = (t * 2.5 + i / 16) % 1, d = u * 900, off = (hash(i) - .5) * 40; R(c, h.x + dx / len * d - dy / len * off, h.y + dy / len * d + dx / len * off, 3, 3, i % 2 ? '#ffffff' : '#e8d0ff'); } }
    } else if (h.type === 'ringBurst' && h.delay > 0) { // vento girando e se fechando antes da espiral
      const k = 1 - h.delay / .7;
      for (let i = 0; i < 18; i++) { const a = i / 18 * TAU + t * 3, d = 120 * (1 - k) + 20; c.save(); c.globalAlpha *= .7; R(c, h.x + Math.cos(a) * d - 3, h.y + Math.sin(a) * d - 1, 6, 2, '#bfe8ff'); c.restore(); }
      ADD(c, () => brilho(c, h.x, h.y, 30 + k * 40, '#9ad8ff', .5));
    } else { c.restore(); return false; }
    c.restore(); return true;
  }
  // aviso de carga antes de cada golpe (e rastro no mergulho)
  function telegrafa(c, st) { const b = st.boss, t = st.time, at = b.attack;
    if (at === 'earFan') { ADD(c, () => { for (const lado of [-1, 1]) brilho(c, b.x + lado * 80, b.y - 20, 40 + Math.sin(t * 20) * 8, '#ff7ad9', .6); }); for (let i = 0; i < 10; i++) { const a = i / 10 * TAU + t * 5, d = 60 - ((t * 80 + i * 9) % 50); R(c, b.x + Math.cos(a) * d * 1.8, b.y - 20 + Math.sin(a) * d * .6, 3, 3, '#ffb8e0'); } }
    else if (at === 'pulseRing' || at === 'gustRing') { ADD(c, () => { for (let k = 0; k < 3; k++) { const u = ((t * 1.6 + k / 3) % 1), rr = 140 * (1 - u) + 20; c.globalAlpha = u * .7; c.strokeStyle = at === 'gustRing' ? '#bfe8ff' : '#7adfff'; c.lineWidth = 3; c.beginPath(); c.arc(b.x, b.y, rr, 0, TAU); c.stroke(); } }); }
    else if (at === 'swoop') { c.save(); c.setLineDash([10, 8]); c.lineDashOffset = -t * 80; c.strokeStyle = '#f2d0a0'; c.lineWidth = 3; c.beginPath(); c.moveTo(b.x, b.y); c.quadraticCurveTo((b.x + b.targetX) / 2, Math.max(b.y, b.targetY) + 60, b.targetX, b.targetY); c.stroke(); c.restore(); mira(c, b.targetX, b.targetY, t, '#ffd8a0', 22); }
    else if (at === 'moonBeam') { ADD(c, () => brilho(c, b.x, b.y, 30 + Math.sin(t * 15) * 10, '#e8d8ff', .9)); mira(c, b.targetX, b.targetY, t, '#ffc8a8', 26); const dx = b.targetX - b.x, dy = b.targetY - b.y, len = Math.hypot(dx, dy) || 1; c.save(); c.setLineDash([11, 8]); c.strokeStyle = '#e5bfa2'; c.lineWidth = 2; c.beginPath(); c.moveTo(b.x, b.y); c.lineTo(b.x + dx / len * 1200, b.y + dy / len * 1200); c.stroke(); c.restore(); }
    else if (at === 'cometRain') { for (let i = 0; i < 6; i++) { const x = 310 + i * 91 - 40, pis = Math.sin(t * 14 + i) > 0; ADD(c, () => brilho(c, x, 20, 26, '#c8a8ff', pis ? .7 : .35)); R(c, x - 1, 6, 3, 10, '#f0e0ff'); R(c, x - 5, 10, 11, 3, '#f0e0ff'); } }
    else if (at === 'cloudGate' || at === 'crosswind') { for (let i = 0; i < 14; i++) { const y = 90 + hash(i * 5) * 400, x = 960 - ((t * 500 + i * 80) % 1100); c.save(); c.globalAlpha *= .35; R(c, x, y, 40 + hash(i) * 40, 2, '#e8f0ff'); c.restore(); } }
    else return false;
    return true;
  }
  function antesChefe(c, st) { const b = st.boss; if (!b) return;
    st.__rastro = st.__rastro || []; if (b.state === 'swoop') { st.__rastro.push([b.x, b.y, st.time]); if (st.__rastro.length > 6) st.__rastro.shift(); } else if (st.__rastro.length) st.__rastro.shift();
    st.__rastro.forEach(([x, y], i) => { c.save(); c.globalAlpha *= .1 + i * .05; ollyan(c, x, y + 63, st.time, { flying: true, scale: 1.37 + (st.phase - 1) * .09 }); c.restore(); });
    if (b.state === 'swoop') for (let i = 0; i < 8; i++) { c.save(); c.globalAlpha *= .5; R(c, b.x + 60 + ((st.time * 600 + i * 40) % 200), b.y - 60 + i * 16, 30, 2, '#ffffff'); c.restore(); }
    if (b.state === 'firing') { const k = 1 - Math.max(0, b.stateTime) / .38; ADD(c, () => { c.globalAlpha = 1 - k; c.strokeStyle = '#f0d8ff'; c.lineWidth = 4; c.beginPath(); c.arc(b.x, b.y, 20 + k * 90, 0, TAU); c.stroke(); }); }
  }

  window.BailePixel = Object.freeze({ dancer, ollyan, palco, fx, cenario, projetil, perigo, telegrafa, antesChefe, VARIANTES });
})();
