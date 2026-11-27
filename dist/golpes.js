/* Golpes: a área que machuca é exatamente o que aparece na tela.
   - Corpos medidos dos sprites (herói, chefes, capangas): caixa do corpo, sem aura, fumaça ou objeto na mão.
   - Cada golpe tem uma forma (círculo, caixa ou elipse) igual ao desenho dele; o acerto é "a forma encostou no corpo".
   - Os efeitos dos golpes (ondas de choque, erupções, fumaça, feixe, nuvem do peidão) são desenhados aqui, em pixel,
     dentro dessas mesmas formas, sem efeitos prontos da pixelfx. O aviso antes do golpe é o chão rachando na largura exata.
   - Só para testes: ?hitbox no endereço mostra as caixas (nunca aparece no jogo normal nem nos apps). */
(() => {
  'use strict';
  if (window.Golpes) return;
  // [meia-largura, altura] medidas dos desenhos (pés em y)
  const CORPO = {
    daroca: [14, 76], nicolas: [17, 66], freddy: [17, 70], menezes: [18, 70], kaique: [17, 108], dede: [16, 66], marco: [16, 66],
    arthur: [18, 68], reeisBoss: [48, 160], giant: [104, 175], marcoRage: [21, 92], nikolas1: [20, 68], nikolas2: [72, 142], nikolas3: [72, 142], nikolas4: [190, 345]
  };
  const CAPANGA = { rat: [22, 24], thug: [16, 67], k0: [28, 96], k1: [24, 76], k2: [34, 80], sixseven: [30, 88] };
  // raio de cada tiro igual ao tamanho do desenho
  const TIRO = { paper: 8, ruler: 10, case: 10, papaia: 10, reeis: 7, enemyBullet: 8, slime: 12, inkBlade: 22, smoke: 12, bituca: 9, astral: 15, confetti: 8, doodle: 20, gangFan: 12 };
  const ONDA = { meia: 13, alt: 58 };     // crista da onda de choque: 26 px de largura, 58 de altura
  const ALT = { chao: 80, brasa: 40 };     // erupções no chão e brasas
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const hsh = (n) => { const x = Math.sin(n * 12.9898 + 78.233) * 43758.5453; return x - Math.floor(x); };

  // ---------- formas ----------
  const caixa = (x0, y0, x1, y1) => ({ x0, y0, x1, y1 });
  const cruza = (a, b) => !!a && !!b && a.x0 < b.x1 && a.x1 > b.x0 && a.y0 < b.y1 && a.y1 > b.y0;
  function circuloCaixa(cx, cy, r, b) { const qx = clamp(cx, b.x0, b.x1), qy = clamp(cy, b.y0, b.y1); return (qx - cx) * (qx - cx) + (qy - cy) * (qy - cy) <= r * r; }
  function elipseCaixa(cx, cy, rx, ry, b) { const qx = clamp(cx, b.x0, b.x1), qy = clamp(cy, b.y0, b.y1), dx = (qx - cx) / rx, dy = (qy - cy) / ry; return dx * dx + dy * dy <= 1; }
  function heroi(p) { const b = CORPO.daroca; return caixa(p.x - b[0], p.y - b[1], p.x + b[0], p.y); }
  function chaveChefe(e) { return e.type === 'nikolas' ? 'nikolas' + clamp(Math.floor(e.phase || 1), 1, 4) : e.type === 'marco' && e.rage ? 'marcoRage' : e.type; }
  function chefe(e) { const b = CORPO[chaveChefe(e)] || [20, 70], s = Number(e.escalaCorpo) || 1; return caixa(e.x - b[0] * s, e.y - b[1] * s, e.x + b[0] * s, e.y); }
  function capanga(m) { const k = m.type === 'rat' ? 'rat' : (m.type === 'thug' || m.kind === 'thug') ? 'thug' : m.design === 'sixseven' ? 'sixseven' : 'k' + (m.kind || 0), b = CAPANGA[k] || [20, 60]; return caixa(m.x - b[0], m.y - b[1], m.x + b[0], m.y); }
  function formaTiro(s) {
    if (s.type === 'word') { const w = Math.min(220, String(s.text || 'POUDI').length * 7 + 18); return { caixa: caixa(s.x - w / 2 - 5, s.y - 13, s.x + w / 2 + 5, s.y + 15) }; }
    return { r: TIRO[s.type] || 10 };
  }
  function tiroAcerta(s, b) { const f = formaTiro(s); return f.caixa ? cruza(f.caixa, b) : circuloCaixa(s.x, s.y, f.r, b); }
  function perigoCaixas(h, chao) {
    if (h.type === 'ring') { const y0 = chao - ONDA.alt; return [caixa(h.x - h.r - ONDA.meia, y0, h.x - h.r + ONDA.meia, chao + 2), caixa(h.x + h.r - ONDA.meia, y0, h.x + h.r + ONDA.meia, chao + 2)]; }
    const alt = h.type === 'astral' ? chao + 600 : h.height || (h.brasa ? ALT.brasa : ALT.chao);
    return [caixa(h.x - h.r, chao - alt, h.x + h.r, chao + 2)];
  }
  let CHAO = null; // o game.js informa o chão da arena
  const chaoDo = (h) => CHAO != null ? CHAO : (Number(h.y) || 0) + (h.type === 'ring' ? 5 : 6);
  function perigoAcerta(h, b) { const c = chaoDo(h); for (const k of perigoCaixas(h, c)) if (cruza(k, b)) return true; return false; }
  // peidão: elipse em volta do Da Roça (o que a nuvem cobre)
  function areaGas(x, y, raio) { return { cx: x, cy: y - 22, rx: raio, ry: raio * .5 }; }
  const gasAcerta = (a, b) => elipseCaixa(a.cx, a.cy, a.rx, a.ry, b);
  function gasPega(a, x, y, r = 0) { const dx = (x - a.cx) / (a.rx + r), dy = (y - a.cy) / (a.ry + r); return dx * dx + dy * dy <= 1; }

  // ---------- desenho em pixel ----------
  let ctx = null;
  function px(x, y, w, h, cor) { ctx.fillStyle = cor; ctx.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); }
  // bolha de pixels (para fumaça, gás e gosma), em fileiras de 3 px
  function bolha(x, y, r, cor, borda) {
    if (borda) for (let yy = -r - 2; yy <= r + 2; yy += 3) { const w = Math.sqrt(Math.max(0, (r + 2) * (r + 2) - yy * yy)); px(x - w, y + yy, w * 2, 3, borda); }
    for (let yy = -r; yy <= r; yy += 3) { const w = Math.sqrt(Math.max(0, r * r - yy * yy)); px(x - w, y + yy, w * 2, 3, cor); }
  }
  // espinho de pedra em fileiras de 4 px (largura cai com a altura)
  function espinho(x, chao, alt, larg, pal) { for (let yy = 0; yy < alt; yy += 4) { const k = 1 - yy / alt, w = Math.max(2, Math.round(larg * k)); px(x - w / 2, chao - yy - 4, w, 4, yy < 4 ? pal[0] : k < .3 ? pal[3] : k < .65 ? pal[2] : pal[1]); } }
  const PAL = {
    gosma: ['#24401c', '#4f8a2c', '#9ccf4a', '#e4f7a0'], fumaca: ['#3a4044', '#7d8a8c', '#b8c3c0', '#eef3ec'], tinta: ['#241434', '#5a2f7a', '#9d6ec7', '#e6c6f5'],
    astral: ['#1c3a68', '#3f7fc0', '#9de5ec', '#fff0ac'], brasa: ['#3a1408', '#a8401a', '#ff8a30', '#ffe08a'], provoca: ['#4a1a38', '#a8457a', '#f0a0cc', '#ffe3f2']
  };
  function paleta(h, pal) { return h.catarro || h.type === 'slime' ? PAL.gosma : h.brasa ? PAL.brasa : h.ink || h.type === 'ink' ? PAL.tinta : h.type === 'smoke' || h.smoke ? PAL.fumaca : h.type === 'astral' || h.astral ? PAL.astral : h.type === 'provoke' ? PAL.provoca : (pal || PAL.tinta); }

  // aviso: o chão rachando e brilhando na largura exata do golpe (sem desenhar caixa)
  function aviso(h, t, pal, lite) {
    const chao = chaoDo(h), pisca = .45 + .35 * Math.abs(Math.sin(t * 12));
    ctx.save();
    for (const b of perigoCaixas(h, chao)) {
      const w = b.x1 - b.x0;
      ctx.globalAlpha = pisca;
      for (let x = b.x0; x < b.x1; x += 4) { const y = chao - 3 + Math.round(Math.sin(x * .37) * 1.2); px(x, y, 4, 2, pal[2]); if (hsh(x) > .78) px(x + 1, y - 2, 2, 2, pal[3]); }
      if (!lite) for (let i = 0; i < 4; i++) { const k = (t * 1.5 + hsh(i + b.x0)) % 1; ctx.globalAlpha = (1 - k) * pisca * .8; px(b.x0 + hsh(i * 7 + b.x0) * (w - 2), chao - 5 - k * 14, 2, 2, pal[3]); }
    }
    ctx.restore();
  }
  // crista da onda de choque dentro de [cx-13, cx+13] x [chao-58, chao]
  function crista(h, cx, dir, chao, t, pal, lite) {
    const M = ONDA.meia, A = ONDA.alt;
    if (h.smoke) { // rolo de fumaça
      for (let i = 0; i < 3; i++) { const r = 12 - i * 1.5, y = chao - r - i * (A - 24) / 2; bolha(cx + Math.sin(t * 14 + i) * 1.5, y, r, pal[1], pal[0]); bolha(cx - dir * 2, y - 2, r * .6, pal[2]); bolha(cx - dir * 4, y - 4, r * .25, pal[3]); }
      return;
    }
    if (h.catarro) { // onda de gosma que enrola para a frente
      for (let x = -M; x <= M; x += 3) { const k = (x * dir + M) / (2 * M), alt = A * (.45 + .55 * Math.sin(k * Math.PI * .5)) * (.94 + .06 * Math.sin(t * 20 + x)); for (let y = 0; y < alt; y += 3) { const f = y / alt; px(cx + x, chao - y - 3, 3, 3, f < .25 ? pal[0] : f < .65 ? pal[1] : f < .9 ? pal[2] : pal[3]); } }
      for (let s = 0; s < 5; s++) { const an = s / 5 * Math.PI * .8; px(cx + dir * (M - 4 - Math.cos(an) * 6) - 2, chao - A + 4 + Math.sin(an) * 5, 4, 3, s < 2 ? pal[3] : pal[2]); }
      if (!lite) for (let i = 0; i < 3; i++) { const yy = chao - 10 - ((t * 40 + i * 17) % (A - 16)); bolha(cx - dir * (i * 6 - 4), yy, 2, pal[3]); }
      return;
    }
    if (h.astral) { // parede de luz com estrelas
      for (let x = -M; x < M; x += 3) { const f = 1 - Math.abs(x) / M; for (let y = 0; y < A; y += 3) px(cx + x, chao - y - 3, 3, 3, f > .7 ? pal[3] : f > .35 ? pal[2] : pal[1]); }
      for (let i = 0; i < 4; i++) { const y = chao - 6 - ((t * 70 + i * 15) % (A - 8)), x = cx + (hsh(i + 3) - .5) * (2 * M - 6); px(x - 2, y, 5, 1, '#ffffff'); px(x, y - 2, 1, 5, '#ffffff'); }
      return;
    }
    // pedra / tinta: espinhos crescentes até a frente
    const alturas = [.5, .72, 1, .82, .55], n = alturas.length;
    for (let i = 0; i < n; i++) { const x = cx + (i - (n - 1) / 2) * (2 * M / n) * dir, a = A * alturas[dir > 0 ? i : n - 1 - i] * (.93 + .07 * Math.sin(t * 26 + i)); espinho(x, chao, a, 2 * M / n + 3, pal); }
    if (!lite) for (let i = 0; i < 4; i++) { const k = (t * 3 + i / 4) % 1; ctx.globalAlpha = 1 - k; px(cx + (hsh(i) - .5) * 2 * M, chao - 8 - k * (A - 12), 2, 2, pal[3]); ctx.globalAlpha = 1; }
  }
  function rastro(h, dir, chao, pal) { // marca no chão por onde a onda passou (não machuca)
    ctx.save(); ctx.globalAlpha = .45;
    const cx = h.x + dir * h.r;
    for (let x = h.x; dir > 0 ? x < cx - ONDA.meia : x > cx + ONDA.meia; x += dir * 8) { px(x, chao - 2, 6, 2, pal[0]); if (hsh(x) > .7) px(x + 2, chao - 3, 2, 1, pal[1]); }
    ctx.restore();
  }
  function erupcao(h, chao, t, pal, lite) { // ocupa [x-r, x+r] até a altura do golpe
    const alt = h.height || ALT.chao, L = h.r * 2, gosma = pal === PAL.gosma, tinta = pal === PAL.tinta;
    if (gosma) { // gêiser de gosma: colunas que borbulham e espirram até o topo da área
      const n = Math.max(3, Math.round(L / 18));
      px(h.x - h.r, chao - 10, L, 10, pal[1]); px(h.x - h.r, chao - 3, L, 3, pal[0]);
      for (let i = 0; i < n; i++) {
        const k = n > 1 ? i / (n - 1) : .5, w = L / n, x = h.x - h.r + w / 2 + k * (L - w), a = alt * (i % 2 ? .82 : 1) * (.9 + .1 * Math.sin(t * 12 + i * 1.7)) - w / 2;
        for (let y = 0; y < a; y += 3) { const f = y / a, ww = w * (1 - f * .25); px(x - ww / 2, chao - y - 3, ww, 3, f < .3 ? pal[0] : f < .7 ? pal[1] : pal[2]); }
        bolha(x, chao - a, w / 2, pal[2], pal[0]); bolha(x - w * .15, chao - a - w * .15, w * .18, pal[3]);
      }
      if (!lite) for (let i = 0; i < 8; i++) { const k = (t * 2 + i / 8) % 1, x = h.x - h.r + 4 + hsh(i * 5 + h.x) * (L - 8), y = chao - alt * (.55 + .45 * Math.sin(k * Math.PI)); ctx.globalAlpha = 1 - k * .6; bolha(x, Math.max(chao - alt + 3, y), 2.5, pal[3]); ctx.globalAlpha = 1; }
      return;
    }
    // espinhos (tinta roxa ou pedra), mais altos no meio, encostando nas bordas da área
    const n = Math.max(3, Math.round(L / 13));
    for (let i = 0; i < n; i++) {
      const k = n > 1 ? i / (n - 1) : .5, x = h.x - h.r + 6 + k * (L - 12), a = alt * (.72 + .28 * Math.sin(k * Math.PI)) * (i % 2 ? .86 : 1) * (.94 + .06 * Math.sin(t * 24 + i));
      espinho(x, chao, a, tinta ? 11 : 13, pal);
      if (tinta && !lite) px(x - 1, chao - a - 6 - Math.abs(Math.sin(t * 6 + i)) * 4, 3, 3, pal[2]);
    }
    px(h.x - h.r, chao - 3, L, 3, pal[0]);
    if (!lite) for (let i = 0; i < 6; i++) { const k = (t * 2.2 + i / 6) % 1; ctx.globalAlpha = 1 - k; px(h.x - h.r + hsh(i * 3 + h.x) * (L - 3), chao - 10 - k * (alt - 14), 3, 3, pal[3]); ctx.globalAlpha = 1; }
  }
  function nuvemChao(h, chao, t, pal) { // nuvem de fumaça enchendo [x-r, x+r] x [chao-80, chao]
    const alt = ALT.chao, cols = Math.max(2, Math.round(h.r / 16)), linhas = 3;
    for (let j = 0; j < linhas; j++) for (let i = 0; i < cols; i++) {
      const r = Math.min(h.r / cols + 4, alt / (linhas * 2) + 4), x = h.x - h.r + r + i * ((h.r * 2 - 2 * r) / Math.max(1, cols - 1)), y = chao - r - j * ((alt - 2 * r) / (linhas - 1)) + Math.sin(t * 3 + i + j) * 2;
      bolha(x, y, r, pal[1], pal[0]); bolha(x - 2, y - 3, r * .55, pal[2]); px(x - r * .4, y - r * .5, 3, 3, pal[3]);
    }
  }
  function brasas(h, chao, t, pal) { // chão em brasa com labaredas até 40 px
    const n = Math.max(4, Math.round(h.r / 5));
    for (let i = 0; i < n; i++) {
      const x = h.x - h.r + 3 + i * (h.r * 2 - 6) / Math.max(1, n - 1), f = Math.sin(t * 22 + i * 2.3);
      px(x - 2, chao - 4, 5, 3, f > .3 ? pal[2] : pal[1]);
      const a = ALT.brasa * (i % 2 ? .55 : 1) * (.75 + .25 * Math.sin(t * 28 + i));
      for (let y = 0; y < a; y += 3) { const k = y / a; px(x - 2 + Math.sin(t * 30 + i + y * .2) * k * 2, chao - 4 - y, k > .7 ? 2 : 4, 3, k < .3 ? pal[1] : k < .7 ? pal[2] : pal[3]); }
    }
  }
  function feixe(h, chao, t, pal) { // feixe astral do céu ao chão, largura 2r
    for (let x = -h.r; x < h.r; x += 4) { const f = 1 - Math.abs(x + 2) / h.r; ctx.globalAlpha = .35 + .55 * f; px(h.x + x, 0, 4, chao, f > .75 ? pal[3] : f > .45 ? pal[2] : pal[1]); }
    ctx.globalAlpha = 1;
    for (let i = 0; i < 8; i++) { const y = (t * 380 + i * 70) % chao, x = h.x + (hsh(i) - .5) * (h.r * 2 - 6); px(x - 3, y, 7, 1, '#ffffff'); px(x, y - 3, 1, 7, '#ffffff'); }
    px(h.x - h.r, chao - 3, h.r * 2, 3, pal[3]);
  }
  function zonaProvoca(h, chao, t, pal) { // parede rosa que joga o Da Roça para cima
    ctx.save(); ctx.globalAlpha = .28; px(h.x - h.r, chao - ALT.chao, h.r * 2, ALT.chao, pal[2]); ctx.restore();
    px(h.x - h.r, chao - ALT.chao, h.r * 2, 2, pal[3]); px(h.x - h.r, chao - 3, h.r * 2, 3, pal[1]);
    for (let i = 0; i < 6; i++) { const x = h.x - h.r + 12 + i * (h.r * 2 - 24) / 5, y = chao - 10 - ((t * 90 + i * 23) % (ALT.chao - 20)); px(x - 1, y, 3, 10, pal[3]); px(x - 4, y + 2, 9, 2, pal[3]); px(x - 3, y + 1, 7, 1, pal[3]); }
  }
  function desenharPerigo(c, h, t, lite, pal) {
    if (!c || !h) return false;
    if (h.height && h.type !== 'astral' && h.delay <= 0) return false; // pilares de palavras: o desenho do jogo já é a área exata
    ctx = c; const p = paleta(h, pal), chao = chaoDo(h);
    if (h.delay > 0) { aviso(h, t, p, lite); return true; }
    if (h.type === 'ring') { for (const dir of [-1, 1]) { rastro(h, dir, chao, p); crista(h, h.x + dir * h.r, dir, chao, t, p, lite); } return true; }
    if (h.type === 'astral') feixe(h, chao, t, p);
    else if (h.brasa) brasas(h, chao, t, p);
    else if (h.type === 'smoke') nuvemChao(h, chao, t, p);
    else if (h.type === 'provoke') zonaProvoca(h, chao, t, p);
    else erupcao(h, chao, t, p, lite);
    return true;
  }

  // ---------- peidão: a nuvem é a área ----------
  let gases = [];
  function gas(x, y, raio, estagio, dir) { gases.push({ ...areaGas(x, y, raio), estagio: estagio || 1, dir: dir < 0 ? -1 : 1, idade: 0, vida: .4 + (estagio || 1) * .05, seed: Math.random() * 100 }); if (gases.length > 6) gases.shift(); }
  function atualizar(dt) { for (const g of gases) g.idade += dt; gases = gases.filter((g) => g.idade < g.vida); }
  const VERDE = ['#4f7a24', '#8fbf3c', '#bfe06a', '#eaf6b0'];
  function desenharGas(c, t) {
    ctx = c;
    for (const g of gases) {
      const p = g.idade / g.vida, abre = 1 - Math.pow(1 - clamp(g.idade / .12, 0, 1), 3), some = p > .4 ? 1 - (p - .4) / .6 : 1;
      const rx = g.rx * abre, ry = g.ry * abre; if (rx < 4) continue;
      c.save();
      if (CHAO != null) { c.beginPath(); c.rect(g.cx - g.rx - 30, g.cy - g.ry - 40, g.rx * 2 + 60, CHAO - (g.cy - g.ry - 40)); c.clip(); }
      // bolinhas soltas e transparentes: a borda delas é a borda da área, mas o cenário continua aparecendo
      const n = Math.round(8 + g.rx / 18), base = ry * .38 + 3;
      for (let i = 0; i < n; i++) {
        const an = i / n * Math.PI * 2 + g.seed, br = base * (.7 + .45 * hsh(i + g.seed)) * (1 - p * .25), sobe = p * 8;
        const x = g.cx + Math.cos(an) * (rx - br), y = g.cy + Math.sin(an) * (ry - br) - sobe;
        c.globalAlpha = some * .5; bolha(x, y, br, Math.sin(an) > .2 ? VERDE[1] : VERDE[2]);
        c.globalAlpha = some * .6; bolha(x - br * .25, y - br * .3, br * .3, VERDE[3]);
      }
      for (let i = 0; i < 4; i++) { const an = i / 4 * Math.PI * 2 + g.seed + .6, br = base * .8, x = g.cx + Math.cos(an) * rx * .35, y = g.cy + Math.sin(an) * ry * .35 - p * 6; c.globalAlpha = some * .35; bolha(x, y, br, VERDE[2]); }
      if (g.estagio === 3) for (let i = 0; i < 6; i++) { const k = (t * 1.6 + i / 6) % 1, x = g.cx + (hsh(i + g.seed) - .5) * rx * 1.4, y = g.cy + (hsh(i * 3 + g.seed) - .5) * ry - k * 10; c.globalAlpha = some * (1 - k); px(x, y, 2, 2, '#ffe08a'); }
      c.restore();
    }
  }

  // ---------- caixas de acerto na tela (modo desenvolvedor) ----------
  let mostrar = /[?&]hitbox\b/.test(location.search);
  function contorno(c, b, cor) { c.strokeStyle = cor; c.lineWidth = 1; c.strokeRect(Math.round(b.x0) + .5, Math.round(b.y0) + .5, Math.round(b.x1 - b.x0), Math.round(b.y1 - b.y0)); }
  function desenharCaixas(c, s) {
    if (!mostrar || !c || !s) return;
    c.save();
    if (s.player) contorno(c, heroi(s.player), '#4dff7a');
    for (const e of s.enemies || []) if (e.hp > 0 && !e.conquista && e.type !== 'igor') contorno(c, chefe(e), '#ff5a5a');
    for (const m of s.minions || []) if (!m.dead) contorno(c, capanga(m), '#ff9a5a');
    for (const h of s.hazards || []) for (const b of perigoCaixas(h, chaoDo(h))) contorno(c, b, h.delay > 0 ? '#ffe08a' : '#ffd000');
    for (const t of s.shots || []) { const f = formaTiro(t); c.strokeStyle = t.owner === 'player' ? '#8ad8ff' : '#ff60d0'; if (f.caixa) contorno(c, f.caixa, c.strokeStyle); else { c.beginPath(); c.arc(t.x, t.y, f.r, 0, Math.PI * 2); c.stroke(); } }
    for (const g of gases) { c.strokeStyle = '#c8ff60'; c.beginPath(); c.ellipse(g.cx, g.cy, g.rx, g.ry, 0, 0, Math.PI * 2); c.stroke(); }
    c.restore();
  }

  window.Golpes = Object.freeze({
    CORPO, CAPANGA, TIRO, ONDA, ALT,
    caixa, cruza, circuloCaixa, elipseCaixa, heroi, chefe, capanga, formaTiro, tiroAcerta, perigoCaixas, perigoAcerta, areaGas, gasAcerta, gasPega,
    desenharPerigo, gas, atualizar, desenharGas, desenharCaixas, chao: (v) => { CHAO = Number.isFinite(v) ? v : null; },
    mostrarCaixas: (v) => { mostrar = v === undefined ? !mostrar : !!v; return mostrar; }
  });
})();
