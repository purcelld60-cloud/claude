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
  function nuvemChao(h, chao, t, pal) { // fumaça do Dedé: rolos desencontrados, base escura, topo claro, cinza e brasa
    const alt = ALT.chao, f = Q(t, 8), n = Math.max(3, Math.round(h.r / 13));
    for (let j = 0; j < 4; j++) for (let i = 0; i <= n - (j % 2); i++) {
      const u = (i + (j % 2 ? .5 : 0)) / Math.max(1, n), r = Math.min(h.r / n + 4, 15) * (.75 + .35 * hsh(i * 7 + j * 3)) * (1 - j * .14);
      const x = h.x - h.r + r + u * (h.r * 2 - 2 * r) + Math.sin(t * 2 + i + j) * 1.5, y = chao - r - j * (alt - 2 * r) / 3.4 - ((f + i * 2 + j) % 3);
      if (y - r < chao - alt || x - r < h.x - h.r - 1 || x + r > h.x + h.r + 1) continue;
      bolha(x, y, r, j < 2 ? pal[1] : pal[2], j === 0 ? pal[0] : null);
      bolha(x - r * .3, y - r * .35, r * .42, j < 2 ? pal[2] : pal[3]);
    }
    for (let i = 0; i < 6; i++) { const k = (t * .7 + i / 6) % 1, x = h.x - h.r + 4 + hsh(i * 5) * (h.r * 2 - 8), y = chao - 6 - k * (alt - 10); px(x, y, 2, 2, i % 3 ? '#9a948c' : '#ff8a30'); }
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
  // ======================================================================
  // ESTILO DE CADA PERSONAGEM (forma e cor do poder dele; sempre dentro da área do golpe)
  // Regras: forma reconhecível mesmo sem cor; clarão curto no impacto, forma forte, resto que some
  // com pouco contraste; animação em degraus (~12 quadros/s), como pixel art de verdade.
  // ======================================================================
  const Q = (t, fps = 12) => Math.floor(t * fps);
  const DONO = { freddy: 'soco', igor: 'comida', arthur: 'tapa', marco: 'tinta', giant: 'papel', menezes: 'esgoto', nicolas: 'astral', reeisBoss: 'ouro', kaique: 'laser', dede: 'fumaca', nikolas: 'gosma' };
  function estiloDe(h, dono) {
    if (h.catarro || h.type === 'slime') return 'gosma';
    if (h.smoke || h.type === 'smoke') return 'fumaca';
    if (h.astral || h.type === 'astral') return 'astral';
    if (h.ink || h.type === 'ink') return dono === 'giant' ? 'papel' : 'tinta';
    return DONO[h.dono || dono] || 'pedra';
  }
  const COR = {
    soco: ['#2e2824', '#5e544c', '#948a7e', '#d6ccbe', '#ff9a3a'], poeira: ['#7a6448', '#b09a78', '#dcc8a4'],
    comida: ['#5a2e14', '#a85a24', '#e8a040', '#fff0b0'], tapa: ['#5a7aa8', '#a8c8f0', '#e8f4ff', '#ffffff'],
    tinta: ['#140a22', '#3a1e5a', '#7a4ab8', '#d6b8f8'], papel: ['#2a3a6a', '#c8d4ea', '#f4f2ea', '#e05a5a'],
    esgoto: ['#1e2614', '#3e4a22', '#6a7a36', '#c8d8a0'], astral: ['#1c3a68', '#3f7fc0', '#9de5ec', '#fffbe0'],
    ouro: ['#5a3a08', '#b8860b', '#f2c94c', '#fff6c0'], laser: ['#3a0612', '#e02a4a', '#ff8aa0', '#bff6ff']
  };
  // clarão do impacto: os primeiros instantes do golpe (só dentro da área)
  function clarao(b, idade, cor) { const a = 1 - idade / .1; if (a <= 0) return; ctx.save(); ctx.globalAlpha = a * .75; px(b.x0, b.y0, b.x1 - b.x0, b.y1 - b.y0, cor); ctx.restore(); }
  function lasca(x, y, w, h, cores, seed) { // pedra angulosa em degraus
    for (let yy = 0; yy < h; yy += 3) { const k = yy / h, ww = Math.max(2, w * (1 - k * .8) + (hsh(seed + yy) - .5) * 3); px(x - ww / 2 + (hsh(seed * 3 + yy) - .5) * 2, y - yy - 3, ww, 3, k < .2 ? cores[0] : k < .55 ? cores[1] : k < .85 ? cores[2] : cores[3]); }
  }
  function pizza(x, y, s, giro) { // fatia de pizza (forma de triângulo, mesmo sem cor)
    const pontos = giro % 2 ? [[0, -s], [s, s], [-s, s]] : [[-s, -s], [s, -s], [0, s]];
    ctx.fillStyle = '#e8a040'; ctx.beginPath(); pontos.forEach((p, i) => i ? ctx.lineTo(x + p[0], y + p[1]) : ctx.moveTo(x + p[0], y + p[1])); ctx.closePath(); ctx.fill();
    px(x - 1, y - 1, 2, 2, '#c83a2a'); px(x + 1, y + 1, 1, 1, '#c83a2a'); px(x - s, y + (giro % 2 ? s - 1 : -s), s * 2, 1, '#a85a24');
  }
  function coxinha(x, y, s) { bolha(x, y + 1, s, '#c8641e', '#5a2e14'); px(x - 1, y - s - 1, 2, 2, '#e8a040'); px(x - s * .4, y - s * .3, 2, 1, '#fff0b0'); }
  function moeda(x, y, giro) { const w = [5, 3, 1, 3][giro % 4]; px(x - w, y - 4, w * 2 + 1, 8, '#b8860b'); px(x - w + 1, y - 3, Math.max(1, w * 2 - 1), 6, '#f2c94c'); if (w > 2) px(x - 1, y - 2, 1, 3, '#fff6c0'); }
  function brilho4(x, y, r, cor) { px(x - r, y, r * 2 + 1, 1, cor); px(x, y - r, 1, r * 2 + 1, cor); px(x - 1, y - 1, 3, 3, cor); }
  function ratinho(x, y, dir) { px(x - 4, y - 3, 8, 3, '#4a4448'); px(x + dir * 3, y - 4, 3, 2, '#5a5458'); px(x + dir * 5, y - 3, 1, 1, '#e88a9a'); px(x - dir * 6, y - 2, 3, 1, '#e88a9a'); }

  // cristas (onda que corre pelo chão): [cx-13, cx+13] x [chao-58, chao]
  const CRISTA = {
    soco(h, cx, dir, chao, t, lite) { // soco do Freddy: o chão de cimento racha e lascas sobem, com poeira
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.soco, P = COR.poeira;
      const alt = [.55, 1, .72], larg = [9, 11, 8];
      for (let i = 0; i < 3; i++) { const x = cx + (i - 1) * 8 * dir; lasca(x, chao, larg[i], A * alt[i] * (.92 + .08 * ((f + i) % 2)), C, i * 7 + Math.round(h.r)); }
      px(cx + dir * (M - 3), chao - A * .7, 2, A * .5, C[4]); // borda quente do impacto
      for (let i = 0; i < 3; i++) { const yy = chao - 8 - ((f * 5 + i * 13) % 22); bolha(cx - dir * (4 + i * 3), yy, 4 + (f + i) % 2, P[1], P[0]); }
      if (!lite) for (let i = 0; i < 4; i++) { const k = ((t * 2.5 + i / 4) % 1), y = chao - 6 - Math.sin(k * Math.PI) * (A - 10); px(cx + (hsh(i + f) - .5) * 2 * (M - 2), y, 3, 3, C[(i % 2) + 1]); }
    },
    comida(h, cx, dir, chao, t, lite) { // barriga do Igor: o chão balança como gelatina e a comida pula
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.comida, bal = Math.sin(t * 22) * 4;
      for (let x = -M; x < M; x += 3) { const k = 1 - Math.abs(x) / M, a = Math.max(3, (A * .45) * k + bal * k); for (let y = 0; y < a; y += 3) px(cx + x, chao - y - 3, 3, 3, y < 4 ? C[0] : y / a < .6 ? C[1] : C[2]); }
      const itens = lite ? 2 : 3;
      for (let i = 0; i < itens; i++) { const k = ((t * 1.8 + i / itens) % 1), y = chao - A * .45 - Math.sin(k * Math.PI) * (A * .5), x = cx + (i - 1) * 7 * dir; if (i % 2) pizza(x, y, 4, f + i); else coxinha(x, y, 3); }
      for (let i = 0; i < 4; i++) px(cx + (hsh(i * 3 + f) - .5) * 2 * M, chao - 4 - hsh(i + f) * (A - 8), 2, 2, C[3]);
    },
    tapa(h, cx, dir, chao, t) { // tapa do Arthur: arcos de ar empurrados (forma de lua crescente)
      const A = ONDA.alt, f = Q(t), C = COR.tapa;
      for (let j = 0; j < 3; j++) {
        const alt = A * (1 - j * .22), off = (2 - j) * 4 * dir;
        for (let y = 0; y < alt; y += 2) { const u = y / alt, bulge = Math.sin(u * Math.PI) * 7; ctx.globalAlpha = .95 - j * .25; px(cx + off + dir * bulge - 1, chao - y - 2, 2, 2, j ? C[2] : C[3]); }
      }
      ctx.globalAlpha = 1;
      for (let i = 0; i < 3; i++) { const y = chao - 10 - ((f * 6 + i * 17) % (A - 14)); px(cx - dir * 8, y, 4, 1, C[1]); }
    },
    tinta(h, cx, dir, chao, t, lite) { // rabiscos do Marco: onda de tinta com riscos de lápis
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.tinta;
      for (let x = -M; x < M; x += 3) { const k = (x * dir + M) / (2 * M), a = A * (.35 + .65 * Math.sin(k * Math.PI * .5)) * (.94 + .06 * ((f + x) % 2)); for (let y = 0; y < a; y += 3) px(cx + x, chao - y - 3, 3, 3, y / a < .3 ? C[0] : y / a < .8 ? C[1] : C[2]); }
      ctx.strokeStyle = C[3]; ctx.lineWidth = 1; ctx.beginPath(); for (let i = 0; i < 6; i++) { const y = chao - 8 - i * 8, x0 = cx - M + 3 + ((f + i) % 3); ctx.moveTo(x0, y); ctx.lineTo(x0 + 7, y - 4); ctx.lineTo(x0 + 13, y + 1); ctx.lineTo(x0 + 20, y - 3); } ctx.stroke();
      if (!lite) for (let i = 0; i < 3; i++) { const y = chao - A + 2 + ((f * 4 + i * 9) % 16); bolha(cx + (i - 1) * 7, y, 2, C[1]); }
    },
    papel(h, cx, dir, chao, t) { // Caderno do Caos: folhas de caderno rasgadas subindo
      const A = ONDA.alt, f = Q(t), C = COR.papel;
      for (let i = 0; i < 4; i++) { const k = ((t * 1.6 + i / 4) % 1), y = chao - 6 - k * (A - 14), x = cx + (hsh(i * 5) - .5) * 14, w = 9, hh = 11, inc = ((f + i) % 3) - 1;
        px(x - w / 2, y - hh, w, hh, C[2]); for (let l = 2; l < hh; l += 3) px(x - w / 2, y - hh + l, w, 1, C[1]); px(x - w / 2 + 2, y - hh, 1, hh, C[3]); px(x - w / 2 + inc, y - hh - 1, w, 1, C[0]); }
      lasca(cx, chao, 12, A * .45, [C[0], '#4a4a6a', C[1], C[2]], 3);
    },
    esgoto(h, cx, dir, chao, t, lite) { // Menezes: onda de esgoto com espuma (e um rato surfando)
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.esgoto;
      for (let x = -M; x < M; x += 3) { const k = (x * dir + M) / (2 * M), a = A * .85 * Math.pow(Math.sin(k * Math.PI * .5), .8) * (.95 + .05 * ((f + x) % 2)); for (let y = 0; y < a; y += 3) px(cx + x, chao - y - 3, 3, 3, y / a < .3 ? C[0] : y / a < .75 ? C[1] : C[2]); }
      for (let s2 = 0; s2 < 5; s2++) px(cx + dir * (M - 5 - s2 * 2), chao - A * .85 - (s2 % 2) * 2, 3, 2, C[3]); // espuma na crista
      ratinho(cx - dir * 2, chao - A * .85 - 4, dir);
      if (!lite) for (let i = 0; i < 3; i++) { const yy = chao - 8 - ((t * 30 + i * 13) % (A * .6)); bolha(cx + (i - 1) * 6, yy, 1.5, C[3]); }
    },
    astral(h, cx, dir, chao, t) { // Nicolas: parede de luz das estrelas
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.astral;
      for (let x = -M; x < M; x += 3) { const k = 1 - Math.abs(x + 1.5) / M; for (let y = 0; y < A; y += 3) px(cx + x, chao - y - 3, 3, 3, k > .75 ? C[3] : k > .45 ? C[2] : k > .2 ? C[1] : C[0]); }
      for (let i = 0; i < 4; i++) { const y = chao - 8 - ((f * 5 + i * 13) % (A - 12)), x = cx + (hsh(i + 2) - .5) * (2 * M - 8); brilho4(x, y, 1 + (f + i) % 2, '#ffffff'); }
    },
    ouro(h, cx, dir, chao, t) { // Reeis: onda de ouro com moedas girando
      const M = ONDA.meia, A = ONDA.alt, f = Q(t), C = COR.ouro;
      for (let x = -M; x < M; x += 3) { const k = 1 - Math.abs(x) / M, a = A * .5 * k + 6; for (let y = 0; y < a; y += 3) px(cx + x, chao - y - 3, 3, 3, y < 4 ? C[0] : y / a < .7 ? C[1] : C[2]); }
      for (let i = 0; i < 3; i++) { const k = ((t * 1.5 + i / 3) % 1), y = chao - A * .5 - Math.sin(k * Math.PI) * (A * .45); moeda(cx + (i - 1) * 7, y, f + i); }
      brilho4(cx + dir * 4, chao - A + 6 + (f % 3) * 3, 2, C[3]);
    },
    laser(h, cx, dir, chao, t) { // Kaique (monitor): varredura de laser com linhas de leitura
      const M = ONDA.meia, A = ONDA.alt, f = Q(t, 16), C = COR.laser;
      for (let x = -M; x < M; x += 4) { const forte = (x + M + f * 4) % 12 < 4; px(cx + x, chao - A, 2, A, forte ? C[1] : C[0]); if (forte) px(cx + x, chao - A, 1, A, C[2]); }
      for (let y = chao - A; y < chao; y += 6) px(cx - M, y + (f % 2) * 3, 2 * M, 1, C[3]);
      px(cx - M, chao - A, 2 * M, 2, C[2]);
    }
  };
  // erupções no chão por estilo: [x-r, x+r] x [chao-alt, chao]
  const CHAO_ESTILO = {
    tinta(h, chao, t, alt, lite) { // lápis do Marco furando o chão, com pingos de tinta
      const n = Math.max(3, Math.round(h.r * 2 / 14)), f = Q(t);
      for (let i = 0; i < n; i++) { const x = h.x - h.r + 7 + i * (h.r * 2 - 14) / Math.max(1, n - 1), a = alt * (i % 2 ? .82 : 1) * (.95 + .05 * ((f + i) % 2)), w = 6;
        px(x - w / 2, chao - a + 10, w, a - 10, '#f2c94c'); px(x - w / 2, chao - a + 10, 2, a - 10, '#c89a2a'); px(x - w / 2, chao - 8, w, 4, '#9aa0a6'); px(x - w / 2, chao - 4, w, 4, '#e88a9a');
        for (let k = 0; k < 7; k++) px(x - (w / 2) * (1 - k / 7), chao - a + 10 - k, w * (1 - k / 7), 1, k < 4 ? '#e8c8a0' : '#2a2a2a'); }
      px(h.x - h.r, chao - 3, h.r * 2, 3, COR.tinta[0]);
      if (!lite) for (let i = 0; i < 5; i++) bolha(h.x - h.r + hsh(i * 7 + f) * h.r * 2, chao - 4 - hsh(i + f) * 14, 2, COR.tinta[1]);
    },
    papel(h, chao, t, alt) { // páginas do caderno saltando do chão
      const n = Math.max(3, Math.round(h.r * 2 / 16)), f = Q(t), C = COR.papel;
      for (let i = 0; i < n; i++) { const x = h.x - h.r + 8 + i * (h.r * 2 - 16) / Math.max(1, n - 1), a = alt * (i % 2 ? .78 : 1), w = 12, inc = ((f + i) % 3) - 1;
        px(x - w / 2 + inc, chao - a, w, a, C[2]); for (let l = 4; l < a; l += 4) px(x - w / 2 + inc, chao - a + l, w, 1, C[1]); px(x - w / 2 + 2 + inc, chao - a, 1, a, C[3]); px(x - w / 2 + inc, chao - a, w, 1, C[0]); }
    },
    esgoto(h, chao, t, alt, lite) { // bueiro estourando: tampa de ferro e coluna de esgoto
      const f = Q(t), C = COR.esgoto;
      for (let x = h.x - h.r; x < h.x + h.r; x += 3) { const k = 1 - Math.abs(x + 1.5 - h.x) / h.r, a = alt * (.55 + .45 * k) * (.94 + .06 * ((f + x) % 2)); for (let y = 0; y < a; y += 3) px(x, chao - y - 3, 3, 3, y / a < .25 ? C[0] : y / a < .7 ? C[1] : y / a < .92 ? C[2] : C[3]); }
      px(h.x - 12, chao - 4, 24, 4, '#2a2a2e'); px(h.x - 10, chao - 3, 20, 1, '#5a5a62');
      ratinho(h.x - h.r + 8 + ((f * 3) % Math.max(1, h.r * 2 - 16)), chao - alt + 6, 1);
      if (!lite) for (let i = 0; i < 6; i++) { const k = (t * 2 + i / 6) % 1; bolha(h.x + (hsh(i) - .5) * h.r * 1.6, chao - alt + 4 + k * 10, 2, C[3]); }
    },
    comida(h, chao, t, alt) { // comida brotando do chão (barriga do Igor)
      const f = Q(t), n = Math.max(3, Math.round(h.r * 2 / 14));
      for (let i = 0; i < n; i++) { const x = h.x - h.r + 7 + i * (h.r * 2 - 14) / Math.max(1, n - 1); lasca(x, chao, 10, alt * (i % 2 ? .7 : .95), COR.comida, i * 3); if (i % 2) pizza(x, chao - alt * .7 - 4, 4, f + i); else coxinha(x, chao - alt * .95 - 3, 3); }
    },
    ouro(h, chao, t, alt) { // pilha de ouro e moedas
      const f = Q(t), C = COR.ouro;
      for (let x = h.x - h.r; x < h.x + h.r; x += 3) { const k = 1 - Math.abs(x + 1.5 - h.x) / h.r, a = alt * (.3 + .7 * k); for (let y = 0; y < a; y += 3) px(x, chao - y - 3, 3, 3, y / a < .3 ? C[0] : y / a < .8 ? C[1] : C[2]); }
      for (let i = 0; i < 4; i++) moeda(h.x + (hsh(i * 3) - .5) * h.r * 1.4, chao - alt * .5 - ((t * 40 + i * 11) % (alt * .45)), f + i);
    },
    laser(h, chao, t, alt) { // grade de laser subindo do chão
      const f = Q(t, 16), C = COR.laser;
      for (let x = h.x - h.r; x < h.x + h.r; x += 6) { px(x, chao - alt, 2, alt, ((x + f * 6) % 18) < 6 ? C[1] : C[0]); }
      for (let y = chao - alt; y < chao; y += 8) px(h.x - h.r, y + (f % 2) * 4, h.r * 2, 1, C[2]);
      px(h.x - h.r, chao - alt, h.r * 2, 2, C[3]);
    },
    soco(h, chao, t, alt) { // lascas de cimento (soco no chão)
      const n = Math.max(3, Math.round(h.r * 2 / 12));
      for (let i = 0; i < n; i++) { const x = h.x - h.r + 6 + i * (h.r * 2 - 12) / Math.max(1, n - 1); lasca(x, chao, 12, alt * (i % 2 ? .75 : 1), COR.soco, i * 5); }
    }
  };

  function desenharPerigo(c, h, t, lite, pal, dono) {
    if (!c || !h) return false;
    if (h.height && h.type !== 'astral' && h.delay <= 0) return false; // pilares de palavras: o desenho do jogo já é a área exata
    ctx = c; const p = paleta(h, pal), chao = chaoDo(h);
    if (dono && !h.dono) h.dono = dono;
    if (h.delay > 0) { aviso(h, t, p, lite); return true; }
    if (h.__t0 == null) h.__t0 = t;
    const idade = t - h.__t0, estilo = estiloDe(h, dono);
    if (h.type === 'ring') {
      for (const dir of [-1, 1]) {
        rastro(h, dir, chao, p);
        const cx = h.x + dir * h.r, f = CRISTA[estilo];
        if (f) f(h, cx, dir, chao, t, lite); else crista(h, cx, dir, chao, t, p, lite);
        clarao(caixa(cx - ONDA.meia, chao - ONDA.alt, cx + ONDA.meia, chao), idade, '#ffffff');
      }
      return true;
    }
    if (h.type === 'astral') feixe(h, chao, t, p);
    else if (h.brasa) brasas(h, chao, t, p);
    else if (h.type === 'smoke') nuvemChao(h, chao, t, p);
    else if (h.type === 'provoke') zonaProvoca(h, chao, t, p);
    else { const f = CHAO_ESTILO[estilo]; if (f) f(h, chao, t, h.height || ALT.chao, lite); else erupcao(h, chao, t, p, lite); }
    for (const b of perigoCaixas(h, chao)) clarao({ x0: b.x0, y0: Math.max(0, b.y0), x1: b.x1, y1: b.y1 - 2 }, idade, '#ffffff');
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
