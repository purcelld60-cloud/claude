/* Fundos detalhados dos lugares novos da campanha 1 (40 oficina, 41 lanchonete, 42 açude).
   Pixels de arte 482 x 270 (ampliados 2x), chão em y = 220. Usado por lugares-c1.js:
   - Açude: serra ao longe com rochas e pontilhado, morros com roças de cacau, pasto, cercas e estradinha,
     fileira de árvores de pixel (mangueira, jaqueira, coqueiro, bananeira) balançando no vento, reflexo
     das árvores na água com ondinhas, brilhos, peixe pulando, pássaros e libélulas.
   - Oficina: bloco de concreto com luz e sombra em cada peça, rachaduras, escorrido de sujeira, faixa pintada
     descascando, eletroduto com caixas e fios, piso de cimento com juntas, trincas e manchas com arco-íris;
     corrente balançando, pingo de óleo e mariposa na lâmpada.
   - Lanchonete: reboco com textura e gordura perto da chapa, azulejo com brilho e peças trincadas, vigas com veio,
     rua lá fora com sacadas, fios, vasos e carros/bicicletas passando, piso com brilho e desgaste; moscas.
   As camadas fixas são desenhadas uma vez e guardadas (versão de dia e de noite). */
(() => {
  'use strict';
  if (window.LugaresFundos) return;
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };
  const disco = (c, x, y, r, cor) => { for (let yy = -r; yy <= r; yy++) { const w = Math.round(Math.sqrt(Math.max(0, r * r - yy * yy))); R(c, x - w, y + yy, w * 2 + 1, 1, cor); } };
  const mix = (a, b, k) => { const p = (h) => [parseInt(h.slice(1, 3), 16), parseInt(h.slice(3, 5), 16), parseInt(h.slice(5, 7), 16)]; const A = p(a), B = p(b); return '#' + A.map((v, i) => Math.round(v + (B[i] - v) * k).toString(16).padStart(2, '0')).join(''); };
  const NOITE = '#14203a';
  const tom = (cor, noite) => (noite ? mix(cor, NOITE, .72) : cor);

  /* ======================= utilidades de pixel ======================= */
  const linha = (c, x0, y0, x1, y1, cor) => { const n = Math.max(1, Math.round(Math.max(Math.abs(x1 - x0), Math.abs(y1 - y0)))); for (let i = 0; i <= n; i++) R(c, x0 + (x1 - x0) * i / n, y0 + (y1 - y0) * i / n, 1, 1, cor); };
  const oval = (c, x, y, rx, ry, cor) => { const n = Math.max(8, Math.round((rx + ry) * 3)); for (let i = 0; i < n; i++) { const a = i / n * Math.PI * 2; R(c, x + Math.cos(a) * rx, y + Math.sin(a) * ry, 1, 1, cor); } };
  const brilho = (c, x, y, r, cor, a) => { if (a <= .01) return; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = Math.min(1, a); const g = c.createRadialGradient(x, y, 0, x, y, r); g.addColorStop(0, cor); g.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore(); };
  // repete um ladrilho pequeno (o Roblox não tem createPattern)
  const ladrilhar = (c, tile, x0, y0, x1, y1) => { for (let y = y0; y < y1; y += tile.height) for (let x = x0; x < x1; x += tile.width) c.drawImage(tile, x, y); };
  const poligono = (c, pts, cor, a) => { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = a; c.fillStyle = cor; c.beginPath(); c.moveTo(pts[0], pts[1]); for (let i = 2; i < pts.length; i += 2) c.lineTo(pts[i], pts[i + 1]); c.closePath(); c.fill(); c.restore(); };

  // ladrilhos feitos uma vez (desenho de 12 e 9 pixels repetido com drawImage)
  function ladrilhoPiso(tipo) {
    const [cv, c] = mk(12, 12);
    if (tipo === 0) {
      R(c, 0, 0, 12, 12, '#e2d4b4'); for (const [x, y] of [[0, 0], [12, 0], [0, 12], [12, 12]]) disco(c, x, y, 4, '#c08466');
      R(c, 5, 3, 2, 6, '#6a88b0'); R(c, 3, 5, 6, 2, '#6a88b0'); R(c, 5, 5, 2, 2, '#f2e8cc'); R(c, 2, 2, 1, 1, '#3c7a5a'); R(c, 9, 2, 1, 1, '#3c7a5a'); R(c, 2, 9, 1, 1, '#3c7a5a'); R(c, 9, 9, 1, 1, '#3c7a5a');
    } else {
      R(c, 0, 0, 12, 12, '#cfa086'); for (let k = 0; k < 6; k++) { R(c, 6 - k, k, 1, 1, '#f2e8cc'); R(c, 5 + k, k, 1, 1, '#f2e8cc'); R(c, 6 - k, 11 - k, 1, 1, '#f2e8cc'); R(c, 5 + k, 11 - k, 1, 1, '#f2e8cc'); }
      R(c, 5, 5, 2, 2, '#6a88b0'); R(c, 0, 0, 1, 1, '#e2d4b4'); R(c, 11, 11, 1, 1, '#e2d4b4');
    }
    R(c, 0, 0, 12, 1, 'rgba(90,70,50,.35)'); R(c, 0, 0, 1, 12, 'rgba(90,70,50,.35)');
    return cv;
  }
  function azulejo() {
    const [cv, c] = mk(9, 9); R(c, 0, 0, 9, 9, '#f4f4ee'); R(c, 0, 0, 9, 1, '#d8d8d0'); R(c, 0, 0, 1, 9, '#d8d8d0');
    for (const [x, y] of [[1, 1], [8, 1], [1, 8], [8, 8]]) { R(c, x - 1, y - 1, 2, 2, '#2c5a9e'); }
    R(c, 4, 2, 1, 5, '#2c5a9e'); R(c, 2, 4, 5, 1, '#2c5a9e'); R(c, 4, 4, 1, 1, '#f4f4ee'); R(c, 3, 3, 1, 1, '#5a8ad8'); R(c, 5, 5, 1, 1, '#5a8ad8'); R(c, 5, 3, 1, 1, '#5a8ad8'); R(c, 3, 5, 1, 1, '#5a8ad8');
    return cv;
  }

  /* ======================= AÇUDE ======================= */
  const cache = {};
  // serra: cristas com rocha, pontilhado de sombra na encosta e névoa na base
  function serra(noite) {
    const W = 760, H = 90, [cv, c] = mk(W, H);
    const altura = (x) => 40 + Math.sin(x * .011) * 16 + Math.sin(x * .031 + 1.3) * 8 + Math.sin(x * .087 + .4) * 3 + (hash(Math.floor(x / 3)) - .5) * 2;
    const claro = tom('#8aa8b8', noite), medio = tom('#6a8a9c', noite), escuro = tom('#4f6e82', noite), rocha = tom('#9ab0bc', noite);
    const suave = (x) => (altura(x - 3) + altura(x - 1) + altura(x) + altura(x + 1) + altura(x + 3)) / 5;
    for (let x = 0; x < W; x++) {
      const topo = H - suave(x), incl = suave(x + 4) - suave(x - 4);
      for (let y = Math.round(topo); y < H; y++) {
        const prof = (y - topo) / (H - topo);
        // luz vinda da esquerda: encosta que sobe é clara, a que desce é escura; estratos de rocha em faixas
        let cor = incl > 1.2 ? claro : incl < -1.2 ? escuro : medio;
        if (incl < -1.2 && prof > .3 && (x + y) % 2 === 0) cor = medio;
        if (incl > 1.2 && prof > .45 && (x + y) % 2 === 0) cor = medio;
        if ((Math.round(y + Math.sin(x * .05) * 3) % 9) === 0 && prof > .12 && prof < .7 && (x + y) % 3 !== 0) cor = escuro;
        if (y - topo < 2) cor = rocha;
        R(c, x, y, 1, 1, cor);
      }
    }
    // névoa na base, em faixas pontilhadas
    for (let y = H - 22; y < H; y++) for (let x = (y % 2); x < W; x += 2) if (hash(x + y * 7) < (y - (H - 22)) / 22) R(c, x, y, 1, 1, tom('#c8dce4', noite));
    return cv;
  }
  // morros com roças: faixas de cacau, pasto, cercas e estradinha de terra
  function morros(noite) {
    const W = 800, H = 70, [cv, c] = mk(W, H);
    const alt = (x) => 34 + Math.sin(x * .017 + 2) * 12 + Math.sin(x * .043) * 5;
    for (let x = 0; x < W; x++) {
      const topo = H - alt(x);
      for (let y = Math.round(topo); y < H; y++) {
        const faixa = Math.floor((x + y * 1.6) / 46) % 4, prof = y - topo;
        let cor = [tom('#5f9a52', noite), tom('#76ad5c', noite), tom('#4e8a48', noite), tom('#8ab868', noite)][faixa];
        if (faixa === 0 && x % 4 === 0 && y % 4 === 0) cor = tom('#2f6a34', noite); // pés de cacau em fileira
        if (faixa === 3 && (x + y) % 3 === 0) cor = tom('#9ac878', noite); // pasto claro
        if (prof < 2) cor = tom('#9ac878', noite);
        R(c, x, y, 1, 1, cor);
      }
    }
    // estradinha de terra serpenteando e cercas
    for (let x = 0; x < W; x++) { const y = H - 10 - Math.sin(x * .02) * 6; R(c, x, y, 1, 2, tom('#b89a6a', noite)); }
    for (let x = 6; x < W; x += 9) { const y = H - alt(x) + 8; if (y < H - 4) { R(c, x, y, 1, 4, tom('#6a4a2a', noite)); if (x + 9 < W) R(c, x, y + 1, 9, 1, tom('#8a6a4a', noite)); } }
    // pontinhos de gado no pasto
    for (let k = 0; k < 14; k++) { const x = hash(k * 7) * W, y = H - alt(x) + 10 + hash(k) * 12; if (y < H - 3) { R(c, x, y, 3, 2, tom(k % 3 ? '#f2f2ec' : '#6a4a2a', noite)); R(c, x + 3, y - 1, 1, 1, tom('#f2f2ec', noite)); } }
    return cv;
  }
  // árvores de pixel: copa feita de cachos com luz em cima à esquerda e sombra embaixo
  function arvoreSprite(tipo, seed, noite, balanco) {
    const [cv, c] = mk(48, 64);
    const cx = 24, base = 63;
    if (tipo === 'coqueiro') {
      for (let y = 0; y < 40; y++) { const x = cx + Math.sin(y * .06 + seed) * 4 + balanco * (40 - y) / 40; R(c, x, base - y, 3, 1, tom(y % 4 ? '#8a6a44' : '#6a4a2a', noite)); }
      const tx = cx + Math.sin(40 * .06 + seed) * 4 + balanco, ty = base - 40;
      for (let f = 0; f < 7; f++) { const a = -Math.PI / 2 + (f - 3) * .55 + balanco * .05; for (let k = 0; k < 14; k++) { const x = tx + Math.cos(a) * k + 1, y = ty + Math.sin(a) * k * .6 + k * k * .045; R(c, x, y, 2, 1, tom(k % 3 ? '#3a8a3a' : '#5aaa4a', noite)); if (k % 2) R(c, x, y + 1, 1, 2, tom('#2a6a2a', noite)); } }
      R(c, tx - 1, ty + 2, 3, 3, tom('#7a5a2a', noite)); R(c, tx + 2, ty + 3, 3, 3, tom('#8a6a2a', noite));
      return cv;
    }
    if (tipo === 'bananeira') {
      for (let y = 0; y < 22; y++) R(c, cx - 1, base - y, 3, 1, tom('#6a8a3a', noite));
      for (let f = 0; f < 6; f++) { const lado = f % 2 ? 1 : -1, a0 = base - 18 - f * 3; for (let k = 0; k < 16; k++) { const x = cx + lado * k + balanco * (k / 16) * 2, y = a0 - k * .5 + k * k * .06; R(c, x, y, 1, 4, tom(k % 4 ? '#5aa84a' : '#3a8a3a', noite)); R(c, x, y + 4, 1, 1, tom('#2a6a2a', noite)); } }
      R(c, cx + 3, base - 20, 3, 5, tom('#8a3a5a', noite));
      return cv;
    }
    // mangueira / jaqueira: tronco grosso e copa redonda em cachos
    const jaca = tipo === 'jaqueira';
    R(c, cx - 2, base - 24, 5, 24, tom('#5a3a22', noite)); R(c, cx - 2, base - 24, 1, 24, tom('#7a5232', noite)); R(c, cx - 6, base - 18, 4, 2, tom('#5a3a22', noite)); R(c, cx + 3, base - 22, 5, 2, tom('#5a3a22', noite));
    const cores = [tom('#1f5a2c', noite), tom('#2f7a3a', noite), tom('#4a9a46', noite), tom('#7ac05a', noite)];
    const cachos = [];
    for (let k = 0; k < 14; k++) { const a = hash(seed * 9 + k) * Math.PI * 2, r = 4 + hash(seed + k * 3) * 10; cachos.push([cx + Math.cos(a) * r * 1.2 + balanco * (1 - Math.sin(a)) * .8, base - 36 + Math.sin(a) * r * .8, 6 + hash(k + seed) * 4]); }
    for (const [x, y, r] of cachos) disco(c, x, y + 2, r, cores[0]);
    for (const [x, y, r] of cachos) disco(c, x, y, r - 1, cores[1]);
    for (const [x, y, r] of cachos) if (y < base - 34) disco(c, x - 1, y - 2, r - 3, cores[2]);
    for (const [x, y, r] of cachos) if (y < base - 40) disco(c, x - 2, y - 3, Math.max(1, r - 5), cores[3]);
    for (let k = 0; k < 40; k++) { const x = cx - 14 + hash(k * 5 + seed) * 28, y = base - 50 + hash(k * 3 + seed) * 26; if (c.getImageData(x, y, 1, 1).data[3] > 0) R(c, x, y, 1, 1, k % 2 ? cores[3] : cores[0]); }
    if (jaca) for (let k = 0; k < 4; k++) { const x = cx - 6 + k * 4, y = base - 26 - (k % 2) * 4; R(c, x, y, 3, 5, tom('#a8b84a', noite)); R(c, x, y, 3, 1, tom('#c8d86a', noite)); }
    else for (let k = 0; k < 5; k++) { const x = cx - 10 + hash(k + seed) * 20, y = base - 40 + hash(k * 2 + seed) * 14; R(c, x, y, 2, 2, tom(k % 2 ? '#f2a83a' : '#e86a3a', noite)); }
    return cv;
  }
  const TIPOS = ['mangueira', 'coqueiro', 'jaqueira', 'bananeira', 'mangueira', 'coqueiro', 'bananeira', 'jaqueira'];
  function arvores(noite) {
    const k = 'arv' + noite; if (cache[k]) return cache[k];
    const lista = [];
    for (let i = 0; i < TIPOS.length; i++) lista.push([-1, 0, 1].map((b) => arvoreSprite(TIPOS[i], i + 1, noite, b)));
    return (cache[k] = lista);
  }
  // linha de árvores com parallax; devolve também o desenho dela (para o reflexo)
  function linhaArvores(c, camL, t, noite, y0, fator, espaco) {
    const sprites = arvores(noite), off = camL * fator;
    for (let i = -2; i < 482 / espaco + 3; i++) {
      const idx = Math.floor(off / espaco) + i, x = idx * espaco - off + (hash(idx * 3.3) - .5) * 14;
      const s = sprites[((idx % sprites.length) + sprites.length) % sprites.length];
      const fase = Math.sin(t * 1.3 + idx * .7) ; const f = fase > .4 ? 2 : fase < -.4 ? 0 : 1;
      const esc = .8 + hash(idx * 1.7) * .4;
      c.drawImage(s[f], Math.round(x), Math.round(y0 - 64 * esc), Math.round(48 * esc), Math.round(64 * esc));
    }
  }
  function camadaAcude(c, s, t, camL, n) {
    const noite = n > .5 ? 1 : 0;
    const kS = 'serra' + noite, kM = 'morros' + noite;
    if (!cache[kS]) cache[kS] = serra(noite);
    if (!cache[kM]) cache[kM] = morros(noite);
    // pássaros no céu (de dia) e morcegos (de noite)
    for (let k = 0; k < 5; k++) { const x = ((t * (14 + k * 3) + k * 140 - camL * .05) % 620) - 70, y = 30 + k * 9 + Math.sin(t * 2 + k) * 3, asa = Math.sin(t * 9 + k) > 0 ? 1 : 0;
      R(c, x, y, 2, 1, noite ? '#1a1a2a' : '#2a2a3a'); R(c, x - 2, y - asa, 2, 1, noite ? '#1a1a2a' : '#2a2a3a'); R(c, x + 2, y - asa, 2, 1, noite ? '#1a1a2a' : '#2a2a3a'); }
    const sx = -((camL * .06) % 278); c.drawImage(cache[kS], Math.round(sx), 62);
    const mx = -((camL * .12) % 318); c.drawImage(cache[kM], Math.round(mx), 86);
  }
  function arvoresAcude(c, t, camL, n) { linhaArvores(c, camL, t, n > .5 ? 1 : 0, 152, .3, 46); }
  function aguaAcude(c, t, camL, n) {
    const noite = n > .5;
    // água em faixas pontilhadas (mais clara perto da margem de lá, mais funda embaixo)
    const faixas = noite ? ['#1a2c52', '#16264a', '#122042', '#0e1a3a', '#0c1630'] : ['#6aaed8', '#5a9ac8', '#4a8ab8', '#3a7aa8', '#2a6a98'];
    for (let i = 0; i < faixas.length; i++) { const y = 150 + i * 10; R(c, 0, y, 482, 10, faixas[i]); if (i < faixas.length - 1) for (let x = (i % 2); x < 482; x += 2) R(c, x, y + 9, 1, 1, faixas[i + 1]); }
    // reflexo das árvores: a mesma linha, de cabeça para baixo, escura e ondulando
    const sprites = arvores(noite ? 1 : 0), off = camL * .3;
    c.save(); c.globalAlpha = noite ? .25 : .3;
    for (let i = -2; i < 482 / 46 + 3; i++) {
      const idx = Math.floor(off / 46) + i, x = idx * 46 - off + (hash(idx * 3.3) - .5) * 14, s = sprites[((idx % sprites.length) + sprites.length) % sprites.length][1], esc = .8 + hash(idx * 1.7) * .4;
      for (let row = 0; row < 40; row += 2) { const onda = Math.round(Math.sin(t * 2.4 + row * .5 + idx) * (1 + row / 20)); c.drawImage(s, 0, 63 - row * (64 / 48), 48, 2, Math.round(x + onda), 152 + row, Math.round(48 * esc), 2); }
    }
    c.restore();
    // linhas de brilho e marolas andando
    for (let k = 0; k < 40; k++) { const x = ((k * 61 - camL * .7 + t * (4 + (k % 3) * 2)) % 520 + 520) % 520 - 20, y = 156 + (k * 7) % 40, w = 4 + (k % 4) * 3;
      R(c, x, y, w, 1, noite ? (k % 2 ? '#3a5a8a' : '#2a3a6a') : (k % 2 ? '#b8e0f8' : '#8ac0e0')); if (k % 5 === 0) R(c, x + 1, y - 1, w - 2, 1, noite ? '#4a6a9a' : '#e8f8ff'); }
    // brilhos piscando
    for (let k = 0; k < 12; k++) { const on = Math.sin(t * 5 + k * 2.3) > .7; if (on) { const x = (hash(k * 9) * 520 - camL * .5 % 520 + 520) % 520 - 20, y = 154 + hash(k * 3) * 40; R(c, x, y, 2, 1, '#ffffff'); R(c, x + .5, y - 1, 1, 3, 'rgba(255,255,255,.6)'); } }
    // peixe pulando de vez em quando
    { const ciclo = (t * .25) % 1; if (ciclo < .12) { const u = ciclo / .12, x = 300 - (camL * .7) % 600 + 200, y = 176 - Math.sin(u * Math.PI) * 14; R(c, x + u * 18, y, 5, 2, noite ? '#6a7a9a' : '#c8d0d8'); R(c, x + u * 18 - 2, y - 1, 2, 1, noite ? '#6a7a9a' : '#c8d0d8'); if (u > .85) for (let k = 0; k < 5; k++) R(c, x + 16 + k * 2 - 4, 176 - k % 2, 1, 1, '#ffffff'); } }
    // libélulas e taboas balançando na beira
    if (!noite) for (let k = 0; k < 3; k++) { const x = (k * 170 + t * 30 + Math.sin(t * 3 + k) * 20 - camL * .9) % 520, y = 184 + Math.sin(t * 4 + k * 2) * 6; R(c, x, y, 4, 1, '#3a6ac8'); const asa = Math.sin(t * 40 + k) > 0; R(c, x + 1, y - (asa ? 2 : 1), 1, 1, 'rgba(220,240,255,.8)'); R(c, x + 2, y - (asa ? 2 : 1), 1, 1, 'rgba(220,240,255,.8)'); }
    for (let k = 0; k < 30; k++) { const wx = k * 83, x = ((wx - camL) % 2400 + 2400) % 2400 - 40; if (x < -10 || x > 490) continue; if (hash(k) < .5) continue;
      for (let j = 0; j < 4; j++) { const sw = Math.sin(t * 1.8 + k + j) * 1.5, h = 14 + j * 4; for (let y = 0; y < h; y++) R(c, x + j * 3 + sw * y / h, 198 - y, 1, 1, noite ? '#1a3a22' : '#4a7a3a'); R(c, x + j * 3 + sw - 1, 198 - h - 4, 3, 5, noite ? '#2a2018' : '#6a4a2a'); } }
  }

  /* ======================= OFICINA ======================= */
  function oficinaParede(c, W) {
    // cada bloco de concreto com luz em cima, sombra embaixo e cor variando
    for (let y = 30, r = 0; y < 186; y += 12, r++) for (let x = (r % 2) * 14 - 14; x < W; x += 28) {
      const h = hash(x * .31 + y * 1.7);
      c.globalAlpha = .1 + h * .1; R(c, x + 1, y + 1, 26, 10, h > .5 ? '#7a8696' : '#2a323e'); c.globalAlpha = 1;
      R(c, x + 1, y + 1, 26, 1, 'rgba(255,255,255,.08)'); R(c, x + 1, y + 10, 26, 1, 'rgba(0,0,0,.22)'); R(c, x + 26, y + 1, 1, 10, 'rgba(0,0,0,.15)');
      if (h > .86) { let cx = x + 6 + h * 12, cy = y + 2; for (let k = 0; k < 6; k++) { R(c, cx, cy, 1, 1, 'rgba(10,14,20,.6)'); cx += hash(k + x) > .5 ? 1 : -1; cy += 1; } } // rachadura
      if (h < .05) R(c, x + 4, y + 3, 6, 4, 'rgba(20,24,30,.35)'); // bloco quebrado
    }
    // escorrido de sujeira descendo do teto e manchas de umidade
    for (let i = 0; i < W / 18; i++) { const x = hash(i * 3.3) * W, len = 20 + hash(i) * 60; for (let y = 34; y < 34 + len; y += 2) { c.globalAlpha = .25 * (1 - (y - 34) / len); R(c, x + Math.sin(y * .2 + i) * .8, y, 2, 2, '#14181e'); } }
    c.globalAlpha = 1;
    // faixa de tinta descascando na metade de baixo
    R(c, 0, 150, W, 36, 'rgba(46,92,140,.55)'); R(c, 0, 150, W, 2, 'rgba(140,180,220,.4)');
    for (let i = 0; i < W / 22; i++) { const x = hash(i * 7.1) * W, y = 152 + hash(i * 2.3) * 28, w = 4 + hash(i) * 10; R(c, x, y, w, 3 + hash(i * 5) * 4, '#56606c'); R(c, x, y, w, 1, 'rgba(255,255,255,.15)'); }
    // eletroduto com caixas, curvas e fios caindo
    R(c, 0, 82, W, 3, '#5a646e'); R(c, 0, 82, W, 1, '#8a949e');
    for (let x = 60; x < W; x += 170) { R(c, x - 5, 78, 11, 11, '#4a545e'); R(c, x - 4, 79, 9, 1, '#7a848e'); R(c, x, 89, 3, 30 + (x % 3) * 12, '#5a646e'); R(c, x - 3, 119 + (x % 3) * 12, 9, 7, '#3a444e'); R(c, x - 1, 121 + (x % 3) * 12, 2, 2, '#e8c24a'); R(c, x + 2, 121 + (x % 3) * 12, 2, 2, '#e8c24a'); }
    for (let x = 140; x < W; x += 320) for (let k = 0; k < 30; k++) R(c, x + k, 85 + Math.sin(k / 30 * Math.PI) * 14, 1, 1, '#1c1c1c');
    // adesivos e marcas de mão
    for (let i = 0; i < W / 140; i++) { const x = 30 + hash(i * 4.4) * (W - 60), y = 120 + hash(i * 6.6) * 26; R(c, x, y, 10, 7, ['#e8c24a', '#c43c3a', '#f2f2ee', '#3a8a5a'][i % 4]); R(c, x + 2, y + 2, 6, 1, 'rgba(0,0,0,.4)'); }
    for (let i = 0; i < W / 200; i++) { const x = hash(i * 8.8) * W, y = 160 + hash(i) * 20; c.globalAlpha = .35; R(c, x, y, 5, 6, '#14181e'); for (let d = 0; d < 4; d++) R(c, x + d, y - 3, 1, 3, '#14181e'); c.globalAlpha = 1; }
  }
  function oficinaChao(c, W) {
    // juntas em perspectiva, trincas, marcas de pneu e manchas de óleo com arco-íris
    for (let x = -400; x < W + 400; x += 40) for (let y = 222; y < 270; y += 2) { const xx = x + (x - W / 2) * (y - 222) / 90; R(c, xx, y, 1, 2, 'rgba(30,34,40,.35)'); }
    for (const y of [232, 246, 262]) R(c, 0, y, W, 1, 'rgba(30,34,40,.3)');
    for (let i = 0; i < W / 60; i++) { let x = hash(i * 1.9) * W, y = 224 + hash(i * 3.1) * 40; for (let k = 0; k < 10; k++) { R(c, x, y, 1, 1, 'rgba(20,22,28,.6)'); x += 1 + (hash(k + i) > .6 ? 1 : 0); y += hash(k * 2 + i) > .5 ? 1 : -1; } }
    for (let i = 0; i < 3; i++) { const y = 236 + i * 9; for (let x = 120 + i * 30; x < 700; x += 3) R(c, x, y + Math.sin(x * .02) * 2, 2, 2, 'rgba(14,16,20,.25)'); }
    for (let i = 0; i < W / 90; i++) { const x = hash(i * 4.7) * W, y = 232 + hash(i * 1.3) * 30; for (let k = 0; k < 5; k++) R(c, x - 6 + k * 3, y + (k % 2), 3, 1, ['rgba(200,80,200,.25)', 'rgba(80,200,220,.25)', 'rgba(230,220,90,.25)'][k % 3]); }
    for (let i = 0; i < W * 1.5; i++) R(c, hash(i * .7) * W, 222 + hash(i * 1.1) * 48, 1, 1, i % 2 ? 'rgba(255,255,255,.06)' : 'rgba(0,0,0,.1)');
    // faixa amarela gasta em volta do elevador e área zebrada na frente do compressor
    for (let x = 182; x < 434; x += 2) if (hash(x * .37) > .08) R(c, x, 223, 2, 2, '#c8a030');
    for (let y = 223; y < 270; y += 2) { const d = (y - 223) * .35; R(c, 182 - d, y, 2, 2, hash(y) > .1 ? '#c8a030' : '#8a7a50'); R(c, 432 + d, y, 2, 2, hash(y + 9) > .1 ? '#c8a030' : '#8a7a50'); }
    for (let y = 224; y < 232; y++) for (let x = 672; x < 714; x += 8) { R(c, x + (y - 224), y, 4, 1, '#c8a030'); R(c, x + 4 + (y - 224), y, 4, 1, '#26282c'); }
    // serragem jogada em cima do óleo, trapo vermelho, porcas soltas e a chave esquecida
    for (let i = 0; i < 140; i++) { const a = hash(i * 2.1) * Math.PI * 2, r = hash(i * 3.7) * 14; R(c, 300 + Math.cos(a) * r * 1.6, 240 + Math.sin(a) * r * .4, 1, 1, i % 3 ? '#c8a878' : '#a88858'); }
    R(c, 560, 236, 9, 3, '#c43c3a'); R(c, 562, 238, 6, 2, '#a82a2a'); R(c, 566, 235, 3, 1, '#e86a5a');
    for (let i = 0; i < 14; i++) { const x = 140 + hash(i * 9.1) * 900, y = 228 + hash(i * 4.3) * 36; R(c, x, y, 2, 2, '#6a7078'); R(c, x, y, 1, 1, '#c8ccd0'); }
    R(c, 900, 252, 14, 2, '#9aa0a6'); R(c, 912, 250, 4, 6, '#9aa0a6'); R(c, 913, 252, 2, 2, '#5e636a');
    // poeira de terra que entra pela porta
    for (let i = 0; i < 400; i++) { const x = hash(i * 1.37) * 140 * hash(i * 2.2), y = 222 + hash(i * 3.1) * 48; R(c, x, y, 1, 1, i % 2 ? 'rgba(150,120,80,.4)' : 'rgba(120,96,64,.35)'); }
  }
  function oficinaAnim(c, t, camL, n) {
    // corrente do talha balançando
    { const x = 700 - camL; if (x > -20 && x < 500) { const a = Math.sin(t * 1.2) * .15; for (let k = 0; k < 22; k++) R(c, x + Math.sin(a) * k * 3, 34 + k * 3, 2, 2, k % 2 ? '#6a7078' : '#9aa0a6'); const hx = x + Math.sin(a) * 66; R(c, hx - 3, 100, 7, 3, '#9aa0a6'); R(c, hx, 103, 2, 4, '#9aa0a6'); R(c, hx - 2, 106, 2, 2, '#9aa0a6'); } }
    // pingo de óleo do carro
    { const x = 300 - camL; if (x > -10 && x < 490) { const u = (t * .7) % 1; if (u < .8) R(c, x, 188 + u * 30, 1, 2, '#1c1c24'); else { R(c, x - 2, 218, 5, 1, '#1c1c24'); } } }
    // mariposa rodando a lâmpada do meio
    { const x = 560 - camL; if (x > -20 && x < 500) { const a = t * 6; R(c, x + Math.cos(a) * 10, 62 + Math.sin(a * 1.3) * 5, 2, 1, '#e8e2c8'); } }
    // feixes de sol pelas telhas translúcidas (de dia), com poeira dourada flutuando
    if (n > .05) for (const x0 of [92, 492, 892]) { const sx = x0 - camL; if (sx > -110 && sx < 490) R(c, sx, 1, 100, 22, `rgba(10,14,34,${(.78 * Math.min(1, n * 1.4)).toFixed(2)})`); }
    if (n < .5) { const a = .055 * (1 - n * 2); for (const x0 of [92, 492, 892]) { const sx = x0 - camL; if (sx < -160 || sx > 560) continue; poligono(c, [sx, 24, sx + 100, 24, sx + 150, 220, sx + 50, 220], '#fff0c0', a);
      for (let k = 0; k < 6; k++) { const u = (t * .03 + hash(k + x0)) % 1, px = sx + 25 + u * 50 + hash(k * 7 + x0) * 70 + Math.sin(t + k) * 3, py = 30 + u * 180; R(c, px, py, 1, 1, 'rgba(255,240,200,.7)'); } } }
    // claridade da rua entrando pela porta e deitando no chão
    { const sx = -camL; if (sx > -160 && n < .7) poligono(c, [sx, 220, sx + 76, 220, sx + 150, 270, sx, 270], '#fff2d0', .1 * (1 - n)); }
    // hélice do exaustor
    { const x = 1020 - camL, y = 54; if (x > -20 && x < 500) { for (let k = 0; k < 4; k++) { const a = t * 8 + k * Math.PI / 2; linha(c, x, y, x + Math.cos(a) * 8, y + Math.sin(a) * 8, '#7a8086'); } R(c, x - 1, y - 1, 3, 3, '#3a3e44'); } }
    // aranha subindo e descendo do canto da teia
    { const x = 856 - camL; if (x > -10 && x < 490) { const L = Math.round(10 + (Math.sin(t * .5) * .5 + .5) * 26); R(c, x, 42, 1, L, 'rgba(220,220,230,.35)'); R(c, x - 1, 42 + L, 3, 2, '#1c1c1c'); R(c, x - 2, 42 + L, 1, 1, '#1c1c1c'); R(c, x + 2, 43 + L, 1, 1, '#1c1c1c'); } }
    // ponteiro de segundos do relógio do café
    { const x = 1056 - camL; if (x > -12 && x < 494) { const a = Math.floor(t) / 60 * Math.PI * 2 - Math.PI / 2; linha(c, x, 112, x + Math.cos(a) * 6, 112 + Math.sin(a) * 6, '#c43c3a'); } }
    // compressor ligando de tempos em tempos: luz verde, ponteiro do manômetro tremendo e sopro de ar
    { const x = 691 - camL; if (x > -20 && x < 500) { const liga = (t % 9) < 2.5; R(c, x + 10, 190, 2, 2, liga ? '#5aff7a' : '#1a4a2a'); const a = -2.4 + (liga ? 1.6 + Math.sin(t * 30) * .12 : .3); linha(c, x, 186, x + Math.cos(a) * 3, 186 + Math.sin(a) * 3, '#c43c3a');
      if (liga) for (let k = 0; k < 3; k++) { const u = (t * 2 + k / 3) % 1; c.globalAlpha = 1 - u; R(c, x - 8 - u * 6, 200 - u * 8, 2, 2, '#e8e8f0'); c.globalAlpha = 1; } } }
  }

  /* ======================= LANCHONETE ======================= */
  function lancheParede(c, W, PORTA) {
    // reboco em cima com pontilhado e gordura perto da chapa/estufa
    for (let y = 30; y < 128; y += 2) for (let x = PORTA + (y / 2 % 2); x < W; x += 2) { const h = hash(x * 1.3 + y * 7.1); if (h > .92) R(c, x, y, 1, 1, 'rgba(255,250,220,.35)'); else if (h < .06) R(c, x, y, 1, 1, 'rgba(150,110,50,.3)'); }
    for (let x = 430; x < 740; x += 2) for (let y = 70; y < 128; y += 2) if (hash(x + y * 3) < (y - 70) / 140) R(c, x, y, 2, 2, 'rgba(140,100,40,.18)');
    // azulejo: brilho em cada peça e algumas trincadas
    for (let y = 134; y < 220; y += 9) for (let x = PORTA; x < W; x += 9) { R(c, x + 1, y + 1, 3, 1, 'rgba(255,255,255,.9)'); const h = hash(x * .7 + y * 1.9); if (h > .95) { R(c, x + 2, y + 3, 1, 4, '#b8b8b0'); R(c, x + 3, y + 5, 3, 1, '#b8b8b0'); } if (h < .04) R(c, x + 1, y + 1, 7, 7, '#e8e8dc'); }
    // vigas com veio de madeira e nós
    for (let x = PORTA; x < W; x += 3) { if (hash(x * 2.2) > .6) R(c, x, 15 + hash(x) * 10, 2, 1, 'rgba(40,24,12,.5)'); }
    for (let x = PORTA + 30; x < W; x += 140) disco(c, x, 21, 2, '#4a2c18');
    // fotos antigas, alvará e varal de bandeirinhas no teto
    for (let i = 0; i < 3; i++) { const x = 820 + i * 22, y = 112; R(c, x, y, 16, 12, '#f2f2e8'); R(c, x + 2, y + 2, 12, 8, ['#8a7a6a', '#6a8a9a', '#9a7a5a'][i]); }
    for (let x = PORTA; x < W; x += 12) { const y = 30 + Math.sin(x * .05) * 3; c.fillStyle = ['#e8433a', '#f2c94c', '#3c8a5a', '#3a6aa8'][(x / 12) % 4 | 0]; c.beginPath(); c.moveTo(x, y); c.lineTo(x + 8, y); c.lineTo(x + 4, y + 7); c.closePath(); c.fill(); }
    // faixa de azulejo português azul e branco e rodapé de cerâmica verde
    { const az = azulejo(); ladrilhar(c, az, PORTA, 139, W, 148); R(c, PORTA, 148, W - PORTA, 1, '#2c5a9e'); }
    R(c, PORTA, 211, W - PORTA, 9, '#2a6a5a'); for (let x = PORTA; x < W; x += 9) { R(c, x, 211, 1, 9, '#1a4a3e'); R(c, x + 1, 212, 3, 1, '#5a9a8a'); } R(c, PORTA, 211, W - PORTA, 1, '#4a8a7a');
    // manchas de umidade no canto do teto, trincas no reboco, tomada e interruptor
    for (let i = 0; i < 160; i++) { const x = 900 + hash(i * 1.3) * 120, y = 32 + hash(i * 2.9) * 22 * hash(i * 4.1); R(c, x, y, 2, 1, 'rgba(150,110,50,.18)'); }
    for (const [x0, y0] of [[290, 96], [760, 60]]) { let x = x0, y = y0; for (let k = 0; k < 12; k++) { R(c, x, y, 1, 1, 'rgba(120,90,40,.5)'); x += hash(k + x0) > .5 ? 1 : 0; y += 1; } }
    R(c, 288, 106, 6, 9, '#f2f2ee'); R(c, 290, 108, 2, 4, '#c8c8c0'); R(c, 290, 28, 1, 78, 'rgba(60,40,20,.35)'); R(c, 408, 120, 7, 6, '#f2f2ee'); R(c, 409, 122, 1, 2, '#3a3a3a'); R(c, 413, 122, 1, 2, '#3a3a3a');
  }
  function lancheRua(c, PORTA) {
    // sacadas, fios, vasos nas janelas e a calçada com o meio-fio gasto
    for (let k = 0; k < 4; k++) { const x = k * 38 - 4, h = 70 + (k % 2) * 14, y = 150 - h;
      R(c, x + 2, y + 32, 32, 2, '#3a3a3a'); for (let j = 0; j < 8; j++) R(c, x + 3 + j * 4, y + 34, 1, 8, '#3a3a3a'); R(c, x + 2, y + 42, 32, 1, '#3a3a3a');
      for (let j = 0; j < 3; j++) { R(c, x + 6 + j * 10, y + 28, 6, 4, '#b8643a'); disco(c, x + 9 + j * 10, y + 25, 3, j % 2 ? '#3a8a4a' : '#c84a6a'); }
      for (let i = 0; i < 40; i++) R(c, x + hash(i + k * 50) * 36, y + hash(i * 3 + k) * h, 1, 1, 'rgba(0,0,0,.12)'); }
    for (let x = 0; x < PORTA; x++) { R(c, x, 64 + Math.sin(x / PORTA * Math.PI) * 10, 1, 1, '#1c1c1c'); R(c, x, 72 + Math.sin(x / PORTA * Math.PI) * 12, 1, 1, '#1c1c1c'); }
    for (let x = 0; x < PORTA; x += 7) if (hash(x) > .6) R(c, x, 187, 3, 2, '#6a645a');
  }
  function lancheChao(c, W, PORTA) {
    // ladrilho hidráulico de verdade: dois desenhos alternados (flor azul com cantos de terracota e losango)
    { const A = ladrilhoPiso(0), B = ladrilhoPiso(1); for (let y = 222, r = 0; y < 270; y += 12, r++) for (let x = PORTA, k = 0; x < W; x += 12, k++) c.drawImage((k + r) % 2 ? B : A, x, y); c.globalAlpha = .22; R(c, PORTA, 222, W - PORTA, 48, '#d8c8a8'); c.globalAlpha = 1; }
    R(c, PORTA, 220, W - PORTA, 2, '#a89878'); R(c, PORTA + 4, 220, 34, 3, '#5a3a2a'); for (let x = PORTA + 5; x < PORTA + 37; x += 3) R(c, x, 221, 1, 1, '#7a5a3a');
    // rua de paralelepípedo
    for (let y = 222, r = 0; y < 270; y += 5, r++) for (let x = -(r % 2) * 4; x < PORTA - 8; x += 8) { const h = hash(x * .7 + y * 3.1); R(c, x, y, 7, 4, h > .6 ? '#8a8478' : h > .3 ? '#7a7468' : '#6a645a'); R(c, x, y, 7, 1, 'rgba(255,255,255,.12)'); R(c, x + 6, y + 1, 1, 3, 'rgba(0,0,0,.2)'); }
    for (let x = PORTA; x < W; x += 3) for (let y = 222; y < 270; y += 2) { const h = hash(x * 3.3 + y * .7); if (h > .97) R(c, x, y, 1, 1, 'rgba(255,255,255,.35)'); else if (h < .03) R(c, x, y, 2, 1, 'rgba(90,60,40,.3)'); }
    // desgaste no caminho até o balcão
    for (let x = 430; x < 740; x += 2) for (let y = 222; y < 240; y += 2) if (hash(x + y * 5) > .7) R(c, x, y, 2, 1, 'rgba(255,240,220,.12)');
  }
  function lancheAnim(c, t, camL, n) {
    // carro, bicicleta e gente passando só na rua (recorte até o batente da porta)
    c.save(); c.beginPath(); c.rect(-camL, 0, 142, 220); c.clip();
    { const x = ((t * 40) % 700) - 200 - camL; if (x > -60 - camL && x < 142 - camL) { R(c, x, 168, 40, 12, n > .5 ? '#3a2a4a' : '#c84a3a'); R(c, x + 8, 160, 22, 9, n > .5 ? '#2a2a3a' : '#a83a2a'); R(c, x + 10, 162, 8, 6, '#9ac8e0'); R(c, x + 20, 162, 8, 6, '#9ac8e0'); disco(c, x + 8, 181, 4, '#1c1c1c'); disco(c, x + 32, 181, 4, '#1c1c1c'); if (n > .3) R(c, x + 38, 170, 3, 2, '#ffe8a0'); } }
    { const x = 160 - ((t * 25) % 260) - camL; if (x > -30 - camL && x < 142 - camL) { disco(c, x, 182, 4, '#2a2a2a'); disco(c, x + 14, 182, 4, '#2a2a2a'); R(c, x, 176, 14, 1, '#3a6aa8'); R(c, x + 6, 166, 4, 10, '#e8c24a'); disco(c, x + 8, 163, 2, '#8a5a3c'); } }
    { const u = (t % 19) / 19, x = Math.round(160 - u * 200 - camL), passo = Math.floor(t * 5) % 2; if (x > -12 - camL && x < 150 - camL) {
      R(c, x, 196, 5, 2, '#2a1d16'); R(c, x, 198, 5, 5, '#8a5a3c'); R(c, x - 1, 203, 7, 9, '#3a8a6a'); R(c, x + 1, 205, 1, 6, '#2a6a4a'); R(c, x + (passo ? 0 : 3), 212, 2, 6, '#2a3442'); R(c, x + (passo ? 3 : 0), 212, 2, 6, '#3a4452'); R(c, x - 1, 205, 1, 5, '#8a5a3c'); R(c, x - 3, 207, 3, 4, '#f2f2ee'); } }
    c.restore();
    { const sx = -camL; if (sx > -40) { const nt = n > .5, T = (cor) => tom(cor, nt);
      R(c, sx + 9, 120, 4, 70, T('#5a3a22')); R(c, sx + 10, 120, 1, 70, T('#7a5232')); disco(c, sx + 11, 112, 16, T('#2f6a34')); disco(c, sx + 6, 106, 10, T('#3f8a3e')); disco(c, sx + 16, 104, 8, T('#4a9a46')); disco(c, sx + 5, 102, 4, T('#6ab05a'));
      for (let k = 0; k < 14; k++) R(c, sx - 4 + hash(k + 600) * 30, 98 + hash(k + 601) * 26, 1, 1, T(k % 2 ? '#1f5a2c' : '#7ac05a'));
      R(c, sx + 104, 160, 2, 54, T('#5a5e64')); for (let k = 0; k < 14; k++) { const w = Math.round(Math.sqrt(Math.max(0, 49 - (k - 7) * (k - 7))) * 1.1); R(c, sx + 105 - w, 150 + k, w * 2, 1, T(k < 2 ? '#f2a04a' : '#e8843a')); }
      R(c, sx + 101, 156, 8, 8, T('#8a4a1a')); R(c, sx + 103, 158, 4, 5, T('#3a3e44')); R(c, sx + 104, 163, 1, 4, '#1c1c1c'); } }
    // rabo do caramelo abanando
    { const x = 78 - camL; if (x > -10 && x < 490) R(c, x - 3, 212 + (Math.sin(t * 6) > 0 ? -1 : 1), 3, 1, '#d89a4a'); }
    // moscas rondando a estufa
    for (let k = 0; k < 3; k++) { const x = 520 - camL + Math.cos(t * (3 + k) + k * 2) * (24 + k * 8), y = 126 + Math.sin(t * (4 + k)) * 8; R(c, x, y, 2, 1, '#14120e'); }
    // fitinhas do Bonfim no batente balançando com o vento da porta
    { const x0 = 144 - camL; if (x0 > -20 && x0 < 490) { const cores = ['#e8433a', '#f2c94c', '#3c8a5a', '#3a6aa8', '#f2f2ee', '#c84a8a', '#e8843a']; R(c, x0, 90, 14, 2, '#5a3820');
      for (let k = 0; k < 7; k++) { const L = 26 + (k % 3) * 8; for (let s = 0; s < L; s += 3) R(c, x0 + 1 + k * 2 + Math.sin(t * 2.2 + k * .9 + s * .12) * s * .08, 92 + s, 1, 3, cores[k]); } } }
    // cozinheiro passando atrás do passa-prato, fogo da chapa e vapor
    { const x0 = 512 - camL; if (x0 > -80 && x0 < 490) { c.save(); c.beginPath(); c.rect(x0, 62, 72, 52); c.clip();
      const fl = Math.sin(t * 14) > 0 ? 1 : 0; for (let k = 0; k < 5; k++) R(c, x0 + 22 + k * 4, 99 - ((fl + k) % 2 ? 3 : 2), 2, 3, k % 2 ? '#ffb040' : '#ff7a2a');
      const u = Math.sin(t * .45) * .5 + .5, px = Math.round(x0 + 10 + u * 52), b = Math.round(Math.abs(Math.sin(t * 4)));
      R(c, px - 4, 92 + b, 9, 22, '#f2f2ec'); R(c, px - 4, 96 + b, 9, 1, '#d8d8d0'); R(c, px - 3, 84 + b, 7, 8, '#c48a62'); R(c, px - 4, 78 + b, 9, 6, '#ffffff'); R(c, px - 3, 76 + b, 7, 2, '#ffffff'); R(c, px - 4, 83 + b, 9, 1, '#e8433a');
      R(c, px - 1, 87 + b, 1, 1, '#2a1d16'); R(c, px + 2, 87 + b, 1, 1, '#2a1d16'); R(c, px - 2, 90 + b, 5, 1, '#2a1d16');
      const vira = (t % 3) < .5; R(c, px + 5, 95 + b, 6, 1, '#9aa0a6'); if (vira) R(c, px + 7, Math.round(90 - Math.sin((t % 3) / .5 * Math.PI) * 6), 5, 2, '#e8b860');
      for (let k = 0; k < 4; k++) { const v = (t * .4 + k / 4) % 1; c.globalAlpha = (1 - v) * .45; R(c, x0 + 26 + k * 6 + Math.sin(t * 2 + k) * 3, 96 - v * 30, 3, 2, '#ffffff'); } c.globalAlpha = 1;
      c.restore(); brilho(c, x0 + 32, 99, 16, '#ff9a40', .22 + fl * .05); } }
    // ponteiro de segundos do relógio
    { const x = 712 - camL; if (x > -12 && x < 494) { const a = Math.floor(t) / 60 * Math.PI * 2 - Math.PI / 2; linha(c, x, 54, x + Math.cos(a) * 6, 54 + Math.sin(a) * 6, '#c43c3a'); } }
    // segundo ventilador de teto (em cima da TV) e o ventilador de parede que vira de um lado para o outro
    { const vx = 880 - camL; if (vx > -40 && vx < 520) { R(c, vx, 28, 2, 12, '#3a3e44'); R(c, vx - 4, 39, 10, 3, '#5a3820'); for (let k = 0; k < 4; k++) { const a = t * 6 + k * Math.PI / 2; R(c, vx + 1 + Math.cos(a) * 16 - 2, 40 + Math.sin(a) * 2, 5, 2, '#7a4a2a'); } } }
    { const x = 976 - camL, y = 112; if (x > -20 && x < 500) { const osc = Math.sin(t * .8) * .6, cx = Math.cos(osc); oval(c, x, y, 7 * cx + 1, 7, '#7a8086'); for (let k = 0; k < 3; k++) { const a = t * 18 + k * 2.09; R(c, x + Math.cos(a) * 4 * cx - 1, y + Math.sin(a) * 4 - 1, 3, 3, '#c8ccd0'); } R(c, x - 1, y - 1, 2, 2, '#3a3e44'); } }
  }


  /* ======================= OFICINA: objetos e teto ======================= */
  function oficinaProps(c, W) {
    // teto: telhas translúcidas sujas de folha seca e a tesoura de aço em zigue-zague por baixo
    for (const x0 of [92, 492, 892]) {
      R(c, x0, 1, 100, 22, '#a8a47e'); for (let x = x0; x < x0 + 100; x += 5) { R(c, x + 1, 1, 2, 22, '#d0cca0'); R(c, x + 4, 1, 1, 22, '#7a7658'); }
      for (let i = 0; i < 26; i++) R(c, x0 + hash(i + x0) * 97, 2 + hash(i * 3 + x0) * 19, 1 + (i % 3), 1, i % 4 ? 'rgba(70,60,30,.45)' : '#6a5a2a');
    }
    const [tc, tx] = mk(12, 20);
    for (let k = 0; k < 7; k++) { R(tx, k, 17 - k * 3, 1, 3, '#3a4250'); R(tx, 11 - k, 17 - k * 3, 1, 3, '#3a4250'); }
    R(tx, 0, 18, 12, 2, '#2a303a'); R(tx, 0, 0, 12, 2, '#3a4250'); R(tx, 0, 0, 12, 1, '#56606e');
    ladrilhar(c, tc, 0, 4, W, 24);
    // vidro das janelas: sujeira pontilhada embaixo, uma vidraça trincada e outra remendada com fita
    for (const x of [300, 560, 820, 1080]) {
      for (let i = 0; i < 40; i++) R(c, x + hash(i + x) * 60, 42 + hash(i * 2 + x) * 26, 1, 1, 'rgba(60,70,60,.35)');
      for (let y = 61; y < 68; y++) for (let xx = x + (y % 2); xx < x + 60; xx += 2) R(c, xx, y, 1, 1, 'rgba(70,64,50,.28)');
    }
    linha(c, 836, 44, 842, 50, 'rgba(230,240,250,.8)'); linha(c, 842, 50, 839, 53, 'rgba(230,240,250,.8)'); linha(c, 842, 50, 846, 48, 'rgba(230,240,250,.8)');
    linha(c, 1096, 56, 1108, 67, '#c8b88a'); linha(c, 1096, 67, 1108, 56, '#c8b88a');
    // placas: proibido fumar e use EPI
    disco(c, 470, 52, 6, '#c43c3a'); disco(c, 470, 52, 4, '#f2f2ee'); R(c, 466, 52, 6, 2, '#3a3a3a'); R(c, 472, 52, 2, 2, '#e8843a'); linha(c, 466, 48, 474, 56, '#c43c3a'); linha(c, 467, 48, 475, 56, '#c43c3a');
    disco(c, 490, 52, 6, '#2c5a9e'); disco(c, 490, 52, 3, '#f2f2ee'); R(c, 487, 52, 7, 3, '#2c5a9e'); R(c, 486, 52, 9, 1, '#f2f2ee');
    // exaustor redondo na parede (a hélice gira no quadro dinâmico)
    disco(c, 1020, 54, 11, '#3a444e'); disco(c, 1020, 54, 9, '#0e1218'); oval(c, 1020, 54, 10, 10, '#5a646e'); for (let k = -8; k <= 8; k += 4) R(c, 1012, 54 + k, 17, 1, 'rgba(90,100,110,.5)');
    // cano de ar comprimido azul com descidas e engates
    R(c, 590, 76, 580, 2, '#3a6aa8'); R(c, 590, 76, 580, 1, '#6a9ad8');
    for (const x of [640, 1000, 1150]) { R(c, x, 78, 2, 16, '#3a6aa8'); R(c, x - 1, 94, 4, 3, '#c8a030'); R(c, x, 97, 2, 2, '#6a7078'); }
    // teia de aranha no canto da coluna (a aranha desce no quadro dinâmico)
    { const wx = 848, wy = 34; for (let k = 0; k < 5; k++) { const a = k / 4 * Math.PI / 2; linha(c, wx, wy, wx + Math.cos(a) * 16, wy + Math.sin(a) * 16, 'rgba(220,220,230,.3)'); }
      for (const r of [5, 9, 13]) for (let k = 0; k <= 8; k++) { const a = k / 8 * Math.PI / 2; R(c, wx + Math.cos(a) * r, wy + Math.sin(a) * r, 1, 1, 'rgba(220,220,230,.35)'); } }
    // quadro de luz com disjuntores e o triângulo amarelo de choque
    R(c, 128, 94, 28, 36, '#3a444e'); R(c, 129, 95, 26, 34, '#6a7480'); R(c, 129, 95, 26, 1, '#9aa4ae'); R(c, 129, 128, 26, 1, '#4a545e'); R(c, 151, 106, 2, 7, '#2a3038'); R(c, 140, 85, 3, 9, '#5a646e');
    for (let k = 0; k < 6; k++) R(c, 142 - k, 99 + k * 2, 1 + k * 2, 2, '#e8c24a');
    R(c, 142, 102, 1, 3, '#1c1c1c'); R(c, 141, 105, 2, 1, '#1c1c1c'); R(c, 141, 106, 1, 3, '#1c1c1c');
    R(c, 133, 115, 18, 9, '#2a3038'); for (let k = 0; k < 6; k++) R(c, 134 + k * 3, 116, 2, 6, k === 3 ? '#c43c3a' : '#e8e2d0');
    // macaco jacaré no chão com o cabo encostado
    R(c, 138, 211, 30, 6, '#c43c3a'); R(c, 138, 211, 30, 1, '#e86a5a'); R(c, 162, 205, 7, 6, '#a82a2a'); R(c, 160, 203, 10, 2, '#3a3a3a'); R(c, 140, 215, 20, 1, '#7a1a1a');
    disco(c, 142, 218, 2, '#1c1c1c'); disco(c, 164, 218, 2, '#1c1c1c'); linha(c, 138, 212, 128, 190, '#9aa0a6'); linha(c, 139, 212, 129, 190, '#6a7078'); R(c, 126, 187, 4, 4, '#1c1c1c');
    // carretel de mangueira de ar, placa e extintor entre o elevador e a prateleira
    R(c, 426, 102, 10, 3, '#4a545e'); disco(c, 431, 114, 9, '#3a3e44'); for (let r = 8; r > 2; r -= 2) oval(c, 431, 114, r, r, r % 4 ? '#e8c24a' : '#c8a030'); disco(c, 431, 114, 2, '#9aa0a6'); linha(c, 439, 118, 441, 140, '#e8c24a'); R(c, 440, 140, 3, 3, '#9aa0a6');
    R(c, 424, 148, 12, 10, '#c43c3a'); R(c, 426, 150, 8, 6, '#f2f2ee'); R(c, 429, 151, 2, 4, '#c43c3a');
    R(c, 425, 164, 9, 20, '#c43c3a'); R(c, 426, 164, 2, 20, '#e86a5a'); R(c, 426, 160, 6, 4, '#2a2a2a'); R(c, 428, 158, 6, 2, '#2a2a2a'); R(c, 433, 161, 2, 11, '#1c1c1c'); R(c, 425, 172, 9, 3, '#f2f2ee'); R(c, 424, 184, 11, 2, '#3a3e44');
    // prateleira de parede com latas de tinta e sprays
    R(c, 516, 132, 46, 3, '#7a5232'); R(c, 516, 132, 46, 1, '#9a7248'); R(c, 519, 135, 2, 5, '#3a3e44'); R(c, 557, 135, 2, 5, '#3a3e44');
    { let x = 517; for (const [cor, h] of [['#3a6aa8', 9], ['#c43c3a', 9], ['#e8c24a', 7]]) { R(c, x, 132 - h, 9, h, '#9aa0a6'); R(c, x, 134 - h, 9, h - 4, cor); R(c, x, 132 - h, 9, 1, '#c8ccd0'); R(c, x + 1, 134 - h, 1, h - 4, 'rgba(255,255,255,.35)'); R(c, x + 2, 131 - h, 5, 1, '#6a7078'); for (let k = 0; k < 3; k++) R(c, x + 2 + k * 2, 132 - h, 1, 2 + k, cor); x += 10; }
      for (let k = 0; k < 2; k++) { const sx = 549 + k * 6; R(c, sx, 121, 4, 11, ['#3a8a5a', '#1c1c1c'][k]); R(c, sx + 1, 119, 2, 2, '#c8ccd0'); R(c, sx, 124, 4, 2, '#f2f2ee'); } }
    // trilho com correias, mangueira amarela enrolada e extensão laranja
    R(c, 590, 108, 80, 2, '#5a646e'); R(c, 590, 108, 80, 1, '#8a949e'); for (let x = 596; x < 668; x += 14) R(c, x, 110, 1, 3, '#9aa0a6');
    oval(c, 597, 125, 3, 12, '#1c1c1c'); oval(c, 607, 127, 4, 14, '#2a2a2a'); oval(c, 608, 127, 3, 13, '#141414');
    for (let r = 8; r > 2; r -= 2) oval(c, 628, 124, r, r * .9, r % 4 ? '#e8c24a' : '#b8922a'); linha(c, 628, 132, 631, 156, '#e8c24a'); R(c, 630, 156, 3, 3, '#9aa0a6');
    oval(c, 652, 124, 6, 10, '#e8843a'); oval(c, 653, 125, 5, 9, '#c8642a'); R(c, 650, 134, 5, 6, '#e8843a'); R(c, 650, 140, 5, 3, '#f2f2ee'); R(c, 651, 143, 1, 2, '#9aa0a6'); R(c, 653, 143, 1, 2, '#9aa0a6');
    // motor no cavalete, com tampa de válvulas, polias, coletor enferrujado e bandeja de óleo
    R(c, 754, 217, 32, 3, '#1c1e24'); R(c, 758, 217, 12, 1, 'rgba(150,110,190,.5)');
    R(c, 768, 196, 5, 18, '#3a6aa8'); R(c, 752, 213, 40, 3, '#3a6aa8'); R(c, 752, 213, 40, 1, '#6a9ad8'); disco(c, 754, 218, 2, '#1c1c1c'); disco(c, 790, 218, 2, '#1c1c1c'); R(c, 764, 192, 14, 5, '#2a4a7a');
    R(c, 748, 174, 30, 20, '#6a7078'); R(c, 748, 174, 30, 2, '#9aa0a6'); R(c, 748, 192, 30, 2, '#4a5058'); R(c, 750, 168, 26, 7, '#c43c3a'); R(c, 750, 168, 26, 1, '#e86a5a'); for (let k = 0; k < 4; k++) R(c, 753 + k * 6, 170, 2, 2, '#e8e2d0');
    disco(c, 744, 186, 6, '#3a3e44'); disco(c, 744, 186, 4, '#7a8086'); disco(c, 744, 186, 1, '#1c1c1c'); disco(c, 746, 176, 3, '#3a3e44'); disco(c, 746, 176, 1, '#9aa0a6'); linha(c, 739, 184, 743, 174, '#1c1c1c'); linha(c, 749, 184, 749, 176, '#1c1c1c');
    for (const y of [176, 182, 188]) { R(c, 778, y, 8, 3, '#8a5a3a'); R(c, 778, y, 8, 1, '#b8784a'); }
    for (let k = 0; k < 14; k++) R(c, 749 + hash(k + 70) * 28, 176 + hash(k + 71) * 16, 1, 1, k % 2 ? '#4a5058' : '#8a9096');
    // carrinho de ferramentas com gavetas e coisas em cima
    R(c, 806, 186, 38, 30, '#c43c3a'); R(c, 806, 186, 38, 2, '#e86a5a'); for (let k = 0; k < 5; k++) { R(c, 808, 190 + k * 5, 34, 4, '#a82a2a'); R(c, 820, 191 + k * 5, 10, 1, '#c8ccd0'); }
    R(c, 844, 184, 2, 14, '#9aa0a6'); R(c, 844, 184, 6, 2, '#9aa0a6'); disco(c, 810, 218, 2, '#1c1c1c'); disco(c, 840, 218, 2, '#1c1c1c');
    R(c, 810, 182, 14, 2, '#9aa0a6'); R(c, 822, 179, 3, 4, '#9aa0a6'); R(c, 830, 177, 4, 9, '#3a8a5a'); R(c, 831, 175, 2, 2, '#c8ccd0'); R(c, 836, 182, 7, 4, '#c8b8a0'); R(c, 837, 181, 4, 1, '#e8dcc0');
    // máquina de solda com cabos, máscara pendurada e cilindro verde de oxigênio
    R(c, 862, 196, 26, 20, '#2f6a9a'); R(c, 862, 196, 26, 2, '#5a9ac8'); R(c, 866, 200, 8, 6, '#1c1c1c'); R(c, 867, 201, 3, 2, '#e8843a'); disco(c, 880, 203, 3, '#c8ccd0'); disco(c, 880, 203, 1, '#1c1c1c'); R(c, 866, 210, 18, 2, '#24486a');
    disco(c, 866, 218, 2, '#1c1c1c'); disco(c, 884, 218, 2, '#1c1c1c'); R(c, 860, 190, 2, 8, '#9aa0a6'); R(c, 860, 190, 10, 2, '#9aa0a6');
    oval(c, 894, 208, 5, 6, '#1c1c1c'); oval(c, 895, 209, 4, 5, '#c43c3a'); linha(c, 888, 204, 890, 210, '#1c1c1c');
    R(c, 903, 150, 1, 4, '#9aa0a6'); R(c, 898, 154, 12, 14, '#2a2a2a'); R(c, 899, 155, 10, 1, '#4a4a4a'); R(c, 900, 159, 8, 3, '#3a6a3a'); R(c, 901, 159, 3, 1, '#7ac87a');
    R(c, 912, 172, 10, 48, '#2f7a4a'); R(c, 912, 172, 10, 2, '#5aa86a'); R(c, 913, 174, 2, 46, 'rgba(255,255,255,.18)'); R(c, 914, 166, 6, 6, '#9aa0a6'); R(c, 916, 162, 2, 4, '#c8ccd0'); R(c, 911, 196, 12, 2, '#1c1c1c'); R(c, 913, 184, 8, 6, '#f2f2ee');
    // tambor de lixo com estopa e a vassoura encostada
    R(c, 926, 196, 18, 24, '#3a5a3a'); R(c, 926, 196, 18, 2, '#5a7a5a'); R(c, 926, 202, 18, 1, '#2a3a2a'); R(c, 926, 212, 18, 1, '#2a3a2a'); R(c, 928, 192, 6, 4, '#c8b8a0'); R(c, 934, 191, 5, 5, '#c43c3a'); R(c, 938, 193, 4, 3, '#e8e2d0');
    linha(c, 966, 168, 970, 210, '#a8784a'); for (let k = 0; k < 7; k++) linha(c, 967 + k, 210, 964 + k * 2, 220, '#c8a83a');
    // cantinho do café: relógio, foto antiga com o carro, prateleira com garrafa térmica e canecas, jornal no sofá
    disco(c, 1056, 112, 9, '#3a3e44'); disco(c, 1056, 112, 8, '#f2f2ee'); for (let k = 0; k < 12; k++) { const a = k / 12 * Math.PI * 2; R(c, 1056 + Math.cos(a) * 6, 112 + Math.sin(a) * 6, 1, 1, '#3a3e44'); }
    R(c, 1056, 107, 1, 5, '#1c1c1c'); R(c, 1056, 112, 4, 1, '#1c1c1c');
    R(c, 1072, 100, 28, 22, '#5a3a22'); R(c, 1074, 102, 24, 18, '#8ac8e0'); R(c, 1074, 113, 24, 7, '#5a9a4a'); R(c, 1077, 108, 15, 6, '#24467a'); R(c, 1080, 106, 8, 3, '#9ac8e0'); disco(c, 1080, 114, 2, '#141414'); disco(c, 1089, 114, 2, '#141414'); R(c, 1094, 105, 2, 3, '#c48a62'); R(c, 1093, 108, 4, 5, '#c0443c');
    R(c, 1104, 134, 22, 2, '#5a3a22'); R(c, 1106, 122, 6, 12, '#c43c3a'); R(c, 1107, 120, 4, 2, '#f2f2ee'); R(c, 1106, 126, 6, 1, '#f2f2ee'); R(c, 1114, 129, 4, 5, '#f2f2ee'); R(c, 1118, 130, 1, 2, '#f2f2ee'); R(c, 1120, 129, 4, 5, '#e8c24a');
    R(c, 1088, 179, 14, 6, '#e8e2d0'); for (let k = 0; k < 3; k++) R(c, 1090, 180 + k * 2, 10, 1, '#9a948a'); R(c, 1050, 180, 10, 8, '#c8844a'); R(c, 1051, 181, 8, 1, '#e8a46a');
    // estante de aço no fundo com pneus deitados, caixas, bateria, galão e aro
    for (const x of [1180, 1204]) { R(c, x, 92, 3, 128, '#d8843a'); for (let y = 96; y < 218; y += 5) R(c, x + 1, y, 1, 2, '#7a3a10'); }
    for (const y of [124, 158, 192]) { R(c, 1180, y, 28, 3, '#3a6aa8'); R(c, 1180, y, 28, 1, '#6a9ad8'); }
    for (let j = 0; j < 3; j++) { R(c, 1183, 118 - j * 6, 22, 5, '#1c1c1c'); R(c, 1183, 118 - j * 6, 22, 1, '#3a3a3a'); R(c, 1192, 119 - j * 6, 4, 2, '#0a0a0a'); }
    R(c, 1183, 142, 11, 16, '#b8905a'); R(c, 1183, 142, 11, 1, '#d8b07a'); R(c, 1185, 147, 6, 3, '#f2f2ee'); R(c, 1195, 146, 10, 12, '#a8804a'); R(c, 1195, 146, 10, 1, '#c8a06a'); R(c, 1199, 146, 2, 12, '#d8c08a');
    R(c, 1183, 180, 12, 12, '#2a2a2a'); R(c, 1184, 178, 2, 2, '#c43c3a'); R(c, 1192, 178, 2, 2, '#1c1c1c'); R(c, 1183, 184, 12, 2, '#e8c24a'); R(c, 1197, 178, 7, 14, '#e8c24a'); R(c, 1198, 175, 3, 3, '#1c1c1c');
    R(c, 1183, 206, 22, 14, '#4a4e54'); disco(c, 1193, 213, 5, '#9aa0a6'); disco(c, 1193, 213, 2, '#3a3e44');
    R(c, 1180, 74, 22, 11, '#1c6a3a'); R(c, 1181, 75, 20, 9, '#2a9a5a'); disco(c, 1186, 77, 1, '#f2f2ee'); R(c, 1185, 79, 2, 3, '#f2f2ee'); linha(c, 1190, 80, 1198, 80, '#f2f2ee'); R(c, 1196, 78, 1, 5, '#f2f2ee');
  }

  // a rua vista pela porta de enrolar: céu, morro, casa do vizinho, mangueira e uma galinha ciscando
  function oficinaFora(c, t, camL, n) {
    const sx = -Math.round(camL); if (sx < -80) return; const noite = n > .5;
    const g = c.createLinearGradient(0, 84, 0, 186); g.addColorStop(0, noite ? '#0e1430' : '#7ab8e8'); g.addColorStop(1, noite ? '#2a2a4a' : '#d8ecf8'); c.fillStyle = g; c.fillRect(sx, 84, 76, 102);
    if (noite) for (let k = 0; k < 6; k++) R(c, sx + hash(k + 9) * 72, 86 + hash(k + 4) * 40, 1, 1, '#ffffff');
    for (let x = 0; x < 76; x++) { const h = Math.round(150 - Math.sin(x * .06 + 1) * 8 - Math.sin(x * .17) * 3); R(c, sx + x, h, 1, 186 - h, noite ? '#16222a' : (x % 2 ? '#7aaa5a' : '#6a9a4e')); R(c, sx + x, h, 1, 1, noite ? '#22323a' : '#9ac878'); }
    R(c, sx + 30, 144, 34, 36, noite ? '#2a2638' : '#e8c8a0'); R(c, sx + 28, 140, 38, 5, noite ? '#221c30' : '#b8543a'); for (let x = 28; x < 66; x += 3) R(c, sx + x, 140, 1, 5, noite ? '#1a1628' : '#983a2a');
    R(c, sx + 36, 152, 8, 8, noite ? '#ffd27a' : '#5a7a9a'); R(c, sx + 39, 152, 1, 8, noite ? '#c89a4a' : '#e8c8a0'); R(c, sx + 50, 158, 8, 22, noite ? '#1a1418' : '#8a5a3a'); R(c, sx + 56, 168, 1, 2, '#e8c24a');
    if (noite) brilho(c, sx + 40, 156, 14, '#ffb050', .5);
    R(c, sx + 12, 140, 4, 46, noite ? '#120e0c' : '#5a3a22'); disco(c, sx + 14, 132, 14, noite ? '#0c1612' : '#2f7a3a'); disco(c, sx + 10, 127, 9, noite ? '#101c16' : '#4a9a46'); disco(c, sx + 8, 124, 4, noite ? '#14241c' : '#7ac05a');
    if (!noite) for (let k = 0; k < 4; k++) R(c, sx + 6 + hash(k) * 16, 128 + hash(k + 2) * 12, 2, 2, '#f2a83a');
    R(c, sx, 180, 76, 40, noite ? '#26221c' : '#b8a078'); R(c, sx, 180, 76, 2, noite ? '#34302a' : '#d8c8a0'); for (let k = 0; k < 24; k++) R(c, sx + hash(k + 50) * 74, 184 + hash(k + 51) * 34, 2, 1, noite ? '#1a1612' : '#9a8460');
    if (!noite) { const gx = sx + 30 + Math.sin(t * .4) * 16, bica = Math.sin(t * 5) > .5 ? 2 : 0, dir = Math.cos(t * .4) > 0 ? 1 : -1;
      R(c, gx - 3, 200, 7, 5, '#f2f2ec'); R(c, gx - 3 - dir * 2, 198, 3, 4, '#f2f2ec'); R(c, gx + dir * 4, 197 + bica, 3, 3, '#f2f2ec'); R(c, gx + dir * 4 + 1, 195 + bica, 1, 2, '#c43c3a'); R(c, gx + dir * 6, 198 + bica, 1, 1, '#e8a020'); R(c, gx - 1, 205, 1, 3, '#e8a020'); R(c, gx + 1, 205, 1, 3, '#e8a020'); }
  }

  /* ======================= LANCHONETE: objetos ======================= */
  function lancheProps(c, W, PORTA) {
    // passa-prato da cozinha: azulejo verde, coifa, panelas, prateleira, chapa e balcãozinho de inox
    R(c, 510, 60, 76, 58, '#6a4228'); R(c, 510, 60, 76, 2, '#8a5a36'); R(c, 512, 62, 72, 52, '#3a3a36');
    for (let y = 62; y < 100; y += 5) for (let x = 512; x < 584; x += 5) R(c, x, y, 4, 4, '#a8c8b8');
    R(c, 522, 62, 40, 9, '#8a9096'); R(c, 522, 62, 40, 1, '#c8ccd0'); R(c, 526, 71, 32, 3, '#6a7076');
    for (let k = 0; k < 4; k++) { const px = 515 + k * 6; R(c, px + 2, 76, 1, 4, '#3a3a3a'); disco(c, px + 2, 83, 2, ['#9aa0a6', '#c8843a', '#9aa0a6', '#3a3e44'][k]); }
    R(c, 562, 82, 20, 2, '#5a3820'); for (let k = 0; k < 4; k++) { R(c, 563 + k * 5, 76, 4, 6, ['#f2c94c', '#c43c3a', '#f2f2ee', '#8a5a3a'][k]); R(c, 563 + k * 5, 75, 4, 1, '#c8ccd0'); }
    R(c, 512, 100, 72, 14, '#7a8086'); R(c, 512, 100, 72, 2, '#c8ccd0'); R(c, 532, 102, 26, 2, '#2a2a2a');
    R(c, 508, 114, 80, 4, '#c8ccd0'); R(c, 508, 114, 80, 1, '#f2f2f2'); R(c, 518, 112, 14, 2, '#f2f2ee'); R(c, 520, 109, 9, 3, '#e8b860'); R(c, 521, 109, 7, 1, '#f2d090'); disco(c, 574, 112, 2, '#c8a030'); R(c, 574, 109, 1, 1, '#3a3a3a');
    // placa "fiado só amanhã" (o texto vai no lancheText) e relógio de parede
    R(c, 598, 46, 74, 14, '#5a3820'); R(c, 600, 48, 70, 10, '#e8d8a8'); R(c, 604, 44, 1, 3, '#3a3a3a'); R(c, 666, 44, 1, 3, '#3a3a3a');
    disco(c, 712, 54, 9, '#5a3820'); disco(c, 712, 54, 8, '#f2f2ee'); for (let k = 0; k < 12; k++) { const a = k / 12 * Math.PI * 2; R(c, 712 + Math.cos(a) * 6, 54 + Math.sin(a) * 6, 1, 1, '#5a3820'); } R(c, 712, 49, 1, 5, '#1c1c1c'); R(c, 712, 54, 4, 1, '#1c1c1c');
    // prateleiras com dendê, pimenta, doce de leite, farinha, café, refrigerante e potes de bala
    for (const y of [78, 104]) { R(c, 596, y, 108, 3, '#7a4a2a'); R(c, 596, y, 108, 1, '#a86a3a'); R(c, 600, y + 3, 2, 5, '#3a2416'); R(c, 698, y + 3, 2, 5, '#3a2416'); }
    for (let k = 0; k < 4; k++) { const x = 598 + k * 5; R(c, x, 69, 4, 9, '#e8a020'); R(c, x + 1, 66, 2, 3, '#e8a020'); R(c, x + 1, 65, 2, 1, '#c43c3a'); R(c, x, 72, 4, 2, '#f2f2ee'); R(c, x + 1, 70, 1, 6, 'rgba(255,255,255,.3)'); }
    for (let k = 0; k < 3; k++) { const x = 620 + k * 6; R(c, x, 71, 5, 7, '#c43c3a'); R(c, x, 70, 5, 1, '#3a8a4a'); R(c, x + 1, 73, 3, 2, '#f2f2ee'); for (let j = 0; j < 3; j++) R(c, x + 1 + j, 76 - (j % 2), 1, 1, '#e86a5a'); }
    for (let k = 0; k < 2; k++) { const x = 639 + k * 7; R(c, x, 70, 6, 8, '#c8945a'); R(c, x, 69, 6, 1, '#f2f2ee'); R(c, x + 1, 72, 4, 3, '#f2e8cc'); }
    R(c, 654, 68, 10, 10, '#f2f2ee'); R(c, 654, 68, 10, 2, '#e8e2d0'); R(c, 656, 72, 6, 3, '#2c5a9e'); R(c, 658, 66, 2, 2, '#c8b8a0');
    for (let k = 0; k < 2; k++) { const x = 666 + k * 7; R(c, x, 70, 6, 8, k ? '#c43c3a' : '#e8c24a'); R(c, x, 70, 6, 1, '#c8ccd0'); R(c, x + 1, 73, 4, 2, k ? '#f2c94c' : '#c43c3a'); }
    for (let k = 0; k < 2; k++) { const x = 682 + k * 7; R(c, x, 66, 5, 12, '#2f7a3a'); R(c, x + 1, 63, 3, 3, '#2f7a3a'); R(c, x + 1, 62, 3, 1, '#c43c3a'); R(c, x, 70, 5, 3, '#f2c94c'); R(c, x + 1, 66, 1, 10, 'rgba(255,255,255,.3)'); }
    for (let k = 0; k < 3; k++) { const x = 600 + k * 12; R(c, x, 94, 10, 10, 'rgba(210,235,245,.55)'); R(c, x, 93, 10, 1, '#c8ccd0'); for (let j = 0; j < 9; j++) R(c, x + 1 + hash(j + k * 9) * 8, 96 + hash(j * 2 + k) * 7, 2, 1, ['#e8433a', '#f2c94c', '#3c8a5a', '#3a6aa8', '#c84a8a'][(j + k) % 5]); }
    for (let k = 0; k < 4; k++) { R(c, 640, 102 - k * 2, 14, 2, '#f2f2ee'); R(c, 640, 103 - k * 2, 14, 1, '#c8c8c0'); }
    for (let k = 0; k < 3; k++) for (let j = 0; j < 2; j++) { const x = 660 + k * 8, y = 98 - j * 6; R(c, x, y, 6, 6, ['#f2f2ee', '#c43c3a', '#3a6aa8'][(k + j) % 3]); R(c, x + 6, y + 1, 1, 3, '#c8c8c0'); }
    // vitrine: fileira de pastéis em cima, etiquetas de preço e reflexo no vidro
    for (let k = 0; k < 12; k++) { const x = 446 + k * 14; R(c, x, 140, 9, 3, '#e8b860'); R(c, x + 1, 139, 7, 1, '#f2d090'); R(c, x + 2, 142, 1, 1, '#b8843a'); R(c, x + 5, 142, 1, 1, '#b8843a'); }
    for (let k = 0; k < 8; k++) { const x = 447 + k * 21; R(c, x, 153, 6, 2, '#f2f2ee'); R(c, x + 1, 153, 3, 1, '#c43c3a'); }
    for (const x of [470, 540, 600]) { linha(c, x, 137, x - 8, 155, 'rgba(255,255,255,.45)'); linha(c, x + 2, 137, x - 6, 155, 'rgba(255,255,255,.25)'); }
    R(c, 726, 140, 7, 18, '#c8ccd0'); R(c, 727, 142, 5, 10, 'rgba(210,235,245,.6)'); R(c, 727, 146, 5, 6, '#7a4a2a'); R(c, 726, 138, 7, 2, '#3a3e44'); R(c, 727, 152, 5, 6, '#5a5e64');
    // banquetas na frente do balcão e chapa de inox embaixo
    R(c, 426, 214, 308, 6, '#8a9096'); R(c, 426, 214, 308, 1, '#c8ccd0');
    for (const x of [462, 532, 602, 672]) { R(c, x - 1, 194, 3, 22, '#c8ccd0'); R(c, x, 194, 1, 22, '#f2f2f2'); R(c, x - 5, 206, 11, 1, '#9aa0a6'); R(c, x - 6, 218, 13, 2, '#7a8086'); R(c, x - 7, 189, 15, 5, '#c43c3a'); R(c, x - 7, 189, 15, 1, '#e86a5a'); R(c, x - 6, 194, 13, 1, '#7a1a1a'); }
    // mesas: porta-guardanapo, ketchup e mostarda, paliteiro e prato de pastel ou copo de suco de cacau
    [176, 290, 846, 930].forEach((x, i) => {
      R(c, x + 6, 178, 6, 6, '#c8ccd0'); R(c, x + 7, 179, 4, 4, '#f2f2ee');
      R(c, x + 14, 177, 2, 7, '#c43c3a'); R(c, x + 14, 176, 2, 1, '#f2f2ee'); R(c, x + 17, 177, 2, 7, '#e8c24a'); R(c, x + 17, 176, 2, 1, '#c43c3a'); R(c, x + 21, 180, 3, 4, '#c8945a'); R(c, x + 21, 178, 1, 2, '#e8d8a8'); R(c, x + 23, 178, 1, 2, '#e8d8a8');
      if (i % 2 === 0) { R(c, x + 32, 182, 14, 2, '#f2f2ee'); R(c, x + 34, 179, 9, 3, '#e8b860'); R(c, x + 35, 179, 7, 1, '#f2d090'); }
      else { R(c, x + 36, 176, 5, 8, 'rgba(210,235,245,.6)'); R(c, x + 36, 179, 5, 5, '#8a5a3a'); R(c, x + 39, 171, 1, 7, '#c43c3a'); }
    });
    // pinguim de geladeira em cima da geladeira de refrigerante
    R(c, 780, 90, 8, 10, '#1c1c24'); R(c, 782, 93, 4, 7, '#f2f2ee'); R(c, 781, 87, 6, 4, '#1c1c24'); R(c, 782, 88, 1, 1, '#f2f2ee'); R(c, 785, 88, 1, 1, '#f2f2ee'); R(c, 783, 90, 2, 1, '#e8a020'); R(c, 780, 100, 3, 1, '#e8a020'); R(c, 785, 100, 3, 1, '#e8a020');
    // samambaias penduradas no teto
    for (const x of [167, 805]) { R(c, x, 28, 1, 12, '#3a3a3a'); R(c, x - 5, 40, 11, 6, '#b8643a'); R(c, x - 5, 40, 11, 1, '#d8844a');
      for (let f = 0; f < 7; f++) { const d = f - 3; for (let k = 0; k < 14; k++) R(c, x + d * k * .22 + (d > 0 ? 2 : d < 0 ? -2 : 0), 42 + k * (.9 + Math.abs(d) * .1) + k * k * .03, 1, 2, k % 3 ? '#3a8a3a' : '#5aaa4a'); } }
    // extintor com placa entre a mesa e o vaso
    R(c, 371, 136, 12, 10, '#c43c3a'); R(c, 373, 138, 8, 6, '#f2f2ee'); R(c, 376, 139, 2, 4, '#c43c3a');
    R(c, 372, 154, 9, 20, '#c43c3a'); R(c, 373, 154, 2, 20, '#e86a5a'); R(c, 373, 150, 6, 4, '#2a2a2a'); R(c, 380, 151, 2, 11, '#1c1c1c'); R(c, 372, 162, 9, 3, '#f2f2ee');
    // camisa listrada do time do bairro (número 10) e mural de cortiça com bilhetes
    R(c, 912, 44, 38, 44, '#3a2416'); R(c, 914, 46, 34, 40, '#e8e2d0'); R(c, 920, 54, 22, 26, '#2c5a9e'); for (let x = 922; x < 942; x += 4) R(c, x, 54, 2, 26, '#f2f2ee'); R(c, 916, 54, 4, 8, '#2c5a9e'); R(c, 942, 54, 4, 8, '#2c5a9e'); R(c, 928, 54, 6, 2, '#e8e2d0'); R(c, 927, 60, 2, 6, '#c43c3a'); R(c, 931, 60, 3, 6, '#c43c3a'); R(c, 932, 61, 1, 4, '#2c5a9e');
    R(c, 958, 40, 44, 56, '#6a4228'); R(c, 960, 42, 40, 52, '#c8945a'); for (let i = 0; i < 80; i++) R(c, 960 + hash(i + 300) * 39, 42 + hash(i + 301) * 51, 1, 1, i % 2 ? '#a8743a' : '#d8a46a');
    [[962, 46, '#f2f2ee'], [976, 44, '#f2e27a'], [986, 52, '#f2a8c8'], [964, 64, '#a8d8f0'], [978, 62, '#f2f2ee'], [970, 78, '#f2e27a'], [986, 74, '#f2f2ee']].forEach(([x, y, cor], i) => { R(c, x, y, 11, 12, cor); for (let k = 0; k < 3; k++) R(c, x + 2, y + 4 + k * 2, 7 - (k % 2) * 2, 1, 'rgba(60,60,80,.5)'); R(c, x + 5, y, 1, 1, ['#c43c3a', '#3a6aa8', '#3a8a4a'][i % 3]); });
    R(c, 988, 75, 6, 4, '#c8945a'); R(c, 987, 74, 2, 2, '#8a5a3a');
    R(c, 974, 112, 4, 14, '#9aa0a6'); R(c, 970, 126, 12, 2, '#7a8086');
    // rua: árvore na calçada, moto estacionada, orelhão, lixeira e o cachorro caramelo dormindo
    disco(c, 50, 214, 4, '#1c1c1c'); disco(c, 70, 214, 4, '#1c1c1c'); disco(c, 50, 214, 1, '#9aa0a6'); disco(c, 70, 214, 1, '#9aa0a6'); R(c, 52, 206, 16, 5, '#c43c3a'); R(c, 55, 203, 9, 3, '#1c1c1c'); R(c, 64, 202, 4, 6, '#c43c3a'); R(c, 66, 199, 6, 2, '#3a3a3a'); R(c, 46, 207, 6, 2, '#9aa0a6'); R(c, 70, 201, 2, 3, '#ffe8a0');
    R(c, 126, 198, 9, 12, '#e8843a'); R(c, 126, 198, 9, 2, '#f2a04a'); R(c, 129, 210, 2, 8, '#5a5e64');
    R(c, 78, 213, 14, 5, '#d89a4a'); R(c, 89, 210, 5, 5, '#d89a4a'); R(c, 90, 209, 1, 2, '#b8783a'); R(c, 92, 209, 1, 2, '#b8783a'); R(c, 93, 212, 2, 1, '#1c1c1c'); R(c, 80, 213, 9, 1, '#e8b86a'); R(c, 79, 217, 12, 1, '#b8783a');
  }

  /* ======================= AÇUDE: mata, barranco, capim e chão em cache ======================= */
  // mata atlântica ao longe: copas em cachos, ipês floridos e palmeiras despontando, névoa na base
  function mata(noite) {
    const W = 900, H = 36, [cv, c] = mk(W, H); const T = (cor) => tom(cor, noite);
    const topo = (x) => 14 + Math.sin(x * .03) * 4 + Math.sin(x * .11 + 1) * 2 + Math.sin(x * .007) * 3;
    for (let x = 0; x < W; x++) R(c, x, topo(x) + 4, 1, H, T('#2a5a34'));
    for (let i = 0; i < 150; i++) { const x = hash(i * 1.31) * W, y = topo(x) + 6, r = 3 + Math.floor(hash(i * 2.7) * 4); disco(c, x, y, r, T('#2a5a34')); disco(c, x - 1, y - 1, Math.max(1, r - 1), T('#3a7040')); if (r > 3) disco(c, x - 2, y - 2, r - 3, T('#5a8a4a')); }
    for (let i = 0; i < 9; i++) { const x = Math.round(40 + i * 97 + hash(i) * 30), y = Math.round(topo(x) + 3), cor = i % 3 === 1 ? '#b86aa8' : '#e8b83a', esc = T(mix(cor, '#3a2a1a', .35));
      R(c, x, y, 1, 6, T('#4a3a2a')); R(c, x - 2, y + 1, 2, 1, T('#4a3a2a')); R(c, x + 1, y, 2, 1, T('#4a3a2a'));
      for (let k = 0; k < 6; k++) { const cx = x - 4 + Math.round(hash(k + i * 7) * 8), cy = y - 2 + Math.round(hash(k * 3 + i) * 3); R(c, cx - 1, cy, 3, 2, esc); R(c, cx - 1, cy - 1, 2, 1, T(cor)); }
      for (let k = 0; k < 5; k++) R(c, x - 4 + Math.round(hash(k * 5 + i) * 8), y - 3 + Math.round(hash(k * 7 + i) * 3), 1, 1, T(mix(cor, '#ffffff', .4))); }
    for (let i = 0; i < 6; i++) { const x = 90 + i * 150 + hash(i * 5) * 40, y = topo(x) - 6; R(c, x, y, 1, 12, T('#4a3a2a')); for (let f = 0; f < 5; f++) { const a = -Math.PI / 2 + (f - 2) * .7; for (let k = 1; k < 7; k++) R(c, x + Math.cos(a) * k, y + Math.sin(a) * k * .6 + k * k * .06, 1, 1, T('#2f6a34')); } }
    for (let y = H - 10; y < H; y++) for (let x = y % 2; x < W; x += 2) if (hash(x * .7 + y * 13) < (y - (H - 10)) / 14) R(c, x, y, 1, 1, T('#a8c8b0'));
    return cv;
  }
  function mataAcude(c, t, camL, n) {
    const noite = n > .5 ? 1 : 0, k = 'mata' + noite; if (!cache[k]) cache[k] = mata(noite);
    // cata-vento da fazenda ao lado da casinha (gira com o vento)
    const wx = Math.round(342 - camL * .12), wy = 100;
    if (wx > -20 && wx < 500) { const cor = noite ? '#2a2a38' : '#6a6a72';
      linha(c, wx - 5, 128, wx, wy, cor); linha(c, wx + 5, 128, wx, wy, cor); for (let j = 0; j < 4; j++) R(c, wx - 4 + j, 110 + j * 5, 9 - j * 2, 1, cor);
      R(c, wx - 1, wy - 2, 4, 3, cor); R(c, wx + 3, wy - 1, 6, 1, cor); R(c, wx + 8, wy - 3, 2, 5, noite ? '#3a3a48' : '#c43c3a');
      for (let j = 0; j < 8; j++) { const a = t * 2.5 + j * Math.PI / 4; linha(c, wx, wy, wx + Math.cos(a) * 7, wy + Math.sin(a) * 7, noite ? '#3a3a4a' : '#d8dce0'); } }
    c.drawImage(cache[k], Math.round(-camL * .2), 118);
  }
  function bancoCanvas(noite) {
    const W = 1260, H = 36, [cv, c] = mk(W, H); const T = (cor) => tom(cor, noite);
    const topo = (x) => Math.round(11 + Math.sin(x * .045) * 1.5 + Math.sin(x * .013 + 2) * 1.5);
    for (let x = 0; x < W; x++) { const y0 = topo(x); R(c, x, y0, 1, 3, T('#4a3c26')); R(c, x, y0 + 3, 1, 9, T('#6a5a38')); R(c, x, y0 + 12, 1, H, T('#7a6a44')); if (x % 2 === 0) { R(c, x, y0 + 3, 1, 1, T('#5a4a30')); R(c, x + 1, y0 + 12, 1, 1, T('#6a5a38')); } }
    for (let i = 0; i < 1800; i++) { const x = hash(i * 1.17) * W, y = topo(x) + 3 + hash(i * 2.3) * 22; R(c, x, y, hash(i * 4.1) > .7 ? 2 : 1, 1, T(i % 3 === 0 ? '#9a8a5e' : i % 3 === 1 ? '#5a4a30' : '#8a7a50')); }
    for (let i = 0; i < 90; i++) { const x = hash(i * 7.7) * W, y = topo(x) + 4 + hash(i * 1.9) * 18, w = 2 + Math.floor(hash(i) * 3); R(c, x, y, w, 2, T(i % 2 ? '#8a8a84' : '#a09a8a')); R(c, x, y, w - 1, 1, T('#c8c4b8')); R(c, x, y + 2, w, 1, T('#4a3c26')); }
    for (let i = 0; i < 14; i++) { let x = hash(i * 5.3) * W, y = topo(x) + 2; for (let k = 0; k < 14; k++) { R(c, x, y, 2, 1, T('#5a3a22')); if (k % 4 === 3) R(c, x + 1, y - 1, 1, 1, T('#7a5232')); x += hash(i * 3 + k) > .5 ? 1 : -1; y += 1; } }
    for (let x = 0; x < W; x += 2) { const h = 2 + Math.floor(hash(x * .9) * 5), y0 = topo(x); R(c, x, y0 - h, 1, h, T(hash(x * 3.3) > .5 ? '#4a8a3a' : '#3a7a34')); if (h > 4) R(c, x, y0 - h, 1, 1, T('#8ac86a')); }
    for (let i = 0; i < 12; i++) { const x = 40 + i * 100 + hash(i) * 40, y = topo(x) - 1; for (let k = 0; k < 5; k++) { disco(c, x + k * 3 - 6, y - (k % 2), 2, T('#2f7a3a')); R(c, x + k * 3 - 7, y - 1 - (k % 2), 2, 1, T('#5aa84a')); } R(c, x - 1, y - 8, 2, 5, T('#8a6ac8')); R(c, x - 1, y - 9, 2, 1, T('#c8b8f0')); R(c, x, y - 6, 1, 1, T('#f2d84a')); }
    for (let i = 0; i < 60; i++) { const x = hash(i * 9.3) * W, y = topo(x) + 4 + hash(i * 2.9) * 14, cor = ['#f2c94c', '#f2a8c8', '#ffffff', '#c86ab8'][i % 4]; R(c, x, y, 1, 3, T('#3a7a34')); R(c, x - 1, y - 1, 3, 1, T(cor)); R(c, x, y - 2, 1, 3, T(cor)); R(c, x, y - 1, 1, 1, T('#f2d84a')); }
    return cv;
  }
  // capim que balança: o mesmo tufo desenhado em três quadros (vento para a esquerda, parado e para a direita)
  function capimCanvas(noite, lado, qtd, H, hMin, hMax) {
    const W = 1260, [cv, c] = mk(W, H); const T = (cor) => tom(cor, noite);
    for (let i = 0; i < qtd; i++) { const x = hash(i * 3.71) * W, h = hMin + Math.floor(hash(i * 1.3) * (hMax - hMin)), cor = T(i % 3 ? '#4a8a3a' : '#5a9a44'), ponta = T('#9ac878');
      // a folha em até três pedaços retos (menos retângulos para o Roblox montar)
      let y0 = 0; for (let y = 1; y <= h - 2; y++) { if (y === h - 2 || Math.round(lado * (y / h) * 2) !== Math.round(lado * (y0 / h) * 2)) { R(c, x + Math.round(lado * (y0 / h) * 2), H - y, 1, y - y0, cor); y0 = y; } }
      R(c, x + Math.round(lado * 2 * (h - 1) / h), H - h, 1, 2, ponta); }
    return cv;
  }
  function desenharCapim(c, quadros, y, t, camL, fase) {
    const seg = 40, i0 = Math.floor(camL / seg), h = quadros[0].height;
    for (let i = i0; i < i0 + 14; i++) { const sx = i * seg - camL; if (sx > 482) break; const v = Math.sin(t * 1.8 + i * .55 + fase), f = v > .35 ? 2 : v < -.35 ? 0 : 1; c.drawImage(quadros[f], i * seg, 0, seg, h, Math.round(sx), y, seg, h); }
  }
  function bancoAcude(c, t, camL, n) {
    const noite = n > .5 ? 1 : 0, k = 'banco' + noite, kc = 'capimB' + noite;
    if (!cache[k]) cache[k] = bancoCanvas(noite);
    if (!cache[kc]) cache[kc] = [-1, 0, 1].map((l) => capimCanvas(noite, l, 260, 16, 6, 14));
    c.drawImage(cache[k], Math.round(camL), 0, 482, 36, 0, 186, 482, 36);
    desenharCapim(c, cache[kc], 182, t, camL, 1.3);
  }
  function chaoCanvas(noite) {
    const W = 1260, H = 50, [cv, c] = mk(W, H); const T = (cor) => tom(cor, noite);
    R(c, 0, 0, W, H, T('#8a7a56'));
    for (let i = 0; i < 5200; i++) { const x = hash(i * .73) * W, y = hash(i * 1.91) * H; R(c, x, y, 2, 1, T(i % 3 === 0 ? '#a8946a' : i % 3 === 1 ? '#6a5a3e' : '#7a6a4a')); }
    const trilha = (x) => 16 + Math.sin(x * .012) * 7 + Math.sin(x * .041) * 2;
    for (let x = 0; x < W; x += 2) { const y = trilha(x); R(c, x, y, 2, 10, T('#a89470')); if (hash(x) > .5) R(c, x, y - 1, 2, 1, T('#988462')); if (hash(x + 3) > .5) R(c, x, y + 10, 2, 1, T('#988462')); if (hash(x * 1.7) > .8) R(c, x, y + 2 + hash(x * 2.3) * 6, 2, 1, T('#b8a47e')); }
    for (let k = 0, x = 30; x < W; x += 23, k++) { const y = trilha(x) + 2 + (k % 2) * 4; R(c, x, y, 3, 2, T('#8a7856')); R(c, x + 1, y + 2, 2, 1, T('#8a7856')); }
    for (let i = 0; i < 70; i++) { const x = hash(i * 4.4) * W, y = 4 + hash(i * 6.1) * 42, w = 3 + Math.floor(hash(i * 2.2) * 5), h = 2 + Math.floor(hash(i * 3.3) * 2); R(c, x, y + h, w, 1, T('#4a3e2a')); R(c, x, y, w, h, T(i % 3 ? '#8a8a84' : '#9a948a')); R(c, x + 1, y, w - 2, 1, T('#c8c4b8')); R(c, x + w - 1, y + 1, 1, h - 1, T('#6a6a64')); }
    for (let i = 0; i < 12; i++) { let x = hash(i * 8.1) * W, y = hash(i * 2.9) * 12; for (let k = 0; k < 18; k++) { R(c, x, y, 2, 1, T('#5a3a22')); if (k % 3 === 0) R(c, x, y - 1, 1, 1, T('#7a5232')); x += 2; y += hash(i + k * 1.3) > .5 ? 1 : 0; } }
    for (let i = 0; i < 90; i++) { const x = hash(i * 1.77) * W, y = hash(i * 5.5) * 48; R(c, x, y, 2, 1, T(['#c8843a', '#a8642a', '#d8a84a', '#6a8a3a'][i % 4])); R(c, x + 2, y + 1, 1, 1, T('#8a5a2a')); }
    for (let i = 0; i < 8; i++) { const x = hash(i * 13.1) * W, y = 6 + hash(i * 3.9) * 36; R(c, x, y + 2, 1, 2, T('#e8e2d0')); R(c, x - 1, y, 3, 2, T(i % 2 ? '#c43c3a' : '#b8905a')); if (i % 2) R(c, x, y, 1, 1, T('#ffffff')); }
    for (let i = 0; i < 70; i++) { const x = hash(i * 2.13) * W, y = 4 + hash(i * 7.3) * 44; for (let b = 0; b < 5; b++) { const h = 2 + Math.floor(hash(i + b) * 4); R(c, x + (b - 2) * 1.3, y - h, 1, h, T(b % 2 ? '#4a8a3a' : '#5a9a44')); } R(c, x - 2, y, 5, 1, T('#3a6a2a')); }
    for (let i = 0; i < 60; i++) { const x = hash(i * 3.03) * W, y = 2 + hash(i * 8.7) * 46, cor = ['#f2f2ee', '#f2c94c', '#f2a8c8'][i % 3]; R(c, x - 1, y, 3, 1, T(cor)); R(c, x, y - 1, 1, 3, T(cor)); R(c, x, y, 1, 1, T(i % 3 ? '#e8a020' : '#c8843a')); }
    for (const [x, y, w] of [[260, 34, 26], [880, 30, 20]]) { R(c, x - w / 2 - 1, y - 1, w + 2, 1, T('#5a4a30')); for (let k = 0; k < 4; k++) R(c, x - w / 2 + k * 2, y + k, w - k * 4, 1, T(k ? '#5a8ab8' : '#8ac0e0')); R(c, x - w / 2 + 3, y + 1, 6, 1, T('#c8e8f8')); }
    return cv;
  }
  // chão de terra do açude: trilha batida com pegadas, pedras, raízes, folhas secas, cogumelos, tufos e florzinhas
  function chaoAcude(c, t, camL, n) {
    const noite = n > .5 ? 1 : 0, k = 'chao' + noite, kc = 'capimC' + noite;
    if (!cache[k]) cache[k] = chaoCanvas(noite);
    if (!cache[kc]) cache[kc] = [-1, 0, 1].map((l) => capimCanvas(noite, l, 340, 9, 2, 7));
    c.drawImage(cache[k], Math.round(camL), 0, 482, 50, 0, 220, 482, 50);
    desenharCapim(c, cache[kc], 212, t, camL, 0);
    // fila de formigas carregando folhinha
    for (let i = 0; i < 9; i++) { const wx = ((t * 6 + i * 9) % 160) + 300, x = wx - camL, y = 252 + Math.sin(wx * .08) * 2; if (x < -4 || x > 486) continue; R(c, x, y, 2, 1, noite ? '#0e0c0a' : '#2a1a10'); if (i % 3 === 0) R(c, x - 1, y - 2, 3, 2, noite ? '#1a2a14' : '#5aa84a'); }
  }
  // patos nadando em fila, folhas boiando e a boia da vara do Seu Vagner
  function vidaAgua(c, t, camL, n) {
    const noite = n > .5;
    { const base = ((t * 5) % 1500 + 1500) % 1500; for (let k = 0; k < 4; k++) { const x = Math.round(1350 - base - camL * .8 + k * 9), y = Math.round(178 + Math.sin(t * 2 + k) * .6); if (x < -12 || x > 494) continue; const mae = k === 0, corpo = noite ? '#8a8a9a' : '#f2f2ec';
      c.globalAlpha = .5; R(c, x + (mae ? 7 : 4), y + 2, 3, 1, noite ? '#3a5a8a' : '#d8f0ff'); R(c, x + (mae ? 10 : 6), y + 3, 3, 1, noite ? '#3a5a8a' : '#d8f0ff'); c.globalAlpha = 1;
      if (mae) { R(c, x, y - 2, 8, 4, corpo); R(c, x + 1, y - 1, 5, 1, noite ? '#6a6a7a' : '#d8d8d0'); R(c, x - 1, y - 6, 3, 4, corpo); R(c, x - 3, y - 5, 2, 1, '#e8a020'); R(c, x - 1, y - 5, 1, 1, '#1c1c1c'); R(c, x + 7, y - 3, 2, 1, corpo); }
      else { R(c, x, y - 1, 4, 3, noite ? '#8a845a' : '#f2d84a'); R(c, x - 1, y - 3, 2, 2, noite ? '#8a845a' : '#f2d84a'); R(c, x - 2, y - 2, 1, 1, '#e8a020'); } } }
    for (let k = 0; k < 5; k++) { const x = ((hash(k + 40) * 600 + t * 3 - camL * .75) % 520 + 520) % 520 - 20, y = 160 + hash(k * 3 + 40) * 30 + Math.sin(t + k) * .6; R(c, x, y, 2, 1, noite ? '#3a3a2a' : ['#c8843a', '#6a8a3a', '#d8a84a'][k % 3]); }
    { const x = 810 - camL; if (x > -40 && x < 520) { const ciclo = t % 7, afunda = ciclo > 6.3 ? 2 : 0, fy = 184 + Math.round(Math.sin(t * 3) * .7) + afunda, fx = x + 22;
      linha(c, x - 10, 138, fx, fy - 2, noite ? 'rgba(200,210,230,.35)' : 'rgba(240,240,240,.55)');
      R(c, fx - 1, fy - 3, 3, 2, '#c43c3a'); R(c, fx - 1, fy - 1, 3, 1, '#f2f2ee'); R(c, fx, fy - 5, 1, 2, '#f2c94c');
      const r = 2 + (t * 3 % 3) * 2; c.globalAlpha = .5 * (1 - (t * 3 % 3) / 3); oval(c, fx, 185, r, r * .3, noite ? '#6a8ab8' : '#e8f8ff'); c.globalAlpha = 1; } }
  }
  window.LugaresFundos = Object.freeze({ chaoAcude, camadaAcude, arvoresAcude, aguaAcude, mataAcude, bancoAcude, vidaAgua, oficinaParede, oficinaChao, oficinaAnim, oficinaProps, oficinaFora, lancheParede, lancheRua, lancheChao, lancheAnim, lancheProps });
})();
