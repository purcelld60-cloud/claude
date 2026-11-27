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
  }
  function oficinaAnim(c, t, camL, n) {
    // corrente do talha balançando
    { const x = 700 - camL; if (x > -20 && x < 500) { const a = Math.sin(t * 1.2) * .15; for (let k = 0; k < 22; k++) R(c, x + Math.sin(a) * k * 3, 34 + k * 3, 2, 2, k % 2 ? '#6a7078' : '#9aa0a6'); const hx = x + Math.sin(a) * 66; R(c, hx - 3, 100, 7, 3, '#9aa0a6'); R(c, hx, 103, 2, 4, '#9aa0a6'); R(c, hx - 2, 106, 2, 2, '#9aa0a6'); } }
    // pingo de óleo do carro
    { const x = 300 - camL; if (x > -10 && x < 490) { const u = (t * .7) % 1; if (u < .8) R(c, x, 188 + u * 30, 1, 2, '#1c1c24'); else { R(c, x - 2, 218, 5, 1, '#1c1c24'); } } }
    // mariposa rodando a lâmpada do meio
    { const x = 560 - camL; if (x > -20 && x < 500) { const a = t * 6; R(c, x + Math.cos(a) * 10, 62 + Math.sin(a * 1.3) * 5, 2, 1, '#e8e2c8'); } }
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
    for (let x = PORTA; x < W; x += 3) for (let y = 222; y < 270; y += 2) { const h = hash(x * 3.3 + y * .7); if (h > .97) R(c, x, y, 1, 1, 'rgba(255,255,255,.35)'); else if (h < .03) R(c, x, y, 2, 1, 'rgba(90,60,40,.3)'); }
    // desgaste no caminho até o balcão
    for (let x = 430; x < 740; x += 2) for (let y = 222; y < 240; y += 2) if (hash(x + y * 5) > .7) R(c, x, y, 2, 1, 'rgba(255,240,220,.12)');
  }
  function lancheAnim(c, t, camL, n) {
    // carro e bicicleta passando na rua (só na parte de fora, antes da porta)
    c.save(); c.beginPath(); c.rect(-camL, 0, 292, 190); c.clip();
    { const PORTA = 300, x = ((t * 40) % 700) - 200 - camL; if (x > -80 - camL && x < PORTA - camL) { R(c, x, 168, 40, 12, n > .5 ? '#3a2a4a' : '#c84a3a'); R(c, x + 8, 160, 22, 9, n > .5 ? '#2a2a3a' : '#a83a2a'); R(c, x + 10, 162, 8, 6, '#9ac8e0'); R(c, x + 20, 162, 8, 6, '#9ac8e0'); disco(c, x + 8, 181, 4, '#1c1c1c'); disco(c, x + 32, 181, 4, '#1c1c1c'); if (n > .3) R(c, x + 38, 170, 3, 2, '#ffe8a0'); } }
    { const x = 260 - ((t * 25) % 340) - camL; if (x > -30 - camL && x < 300 - camL) { disco(c, x, 182, 4, '#2a2a2a'); disco(c, x + 14, 182, 4, '#2a2a2a'); R(c, x, 176, 14, 1, '#3a6aa8'); R(c, x + 6, 166, 4, 10, '#e8c24a'); disco(c, x + 8, 163, 2, '#8a5a3c'); } }
    c.restore();
    // moscas rondando a estufa
    for (let k = 0; k < 3; k++) { const x = 520 - camL + Math.cos(t * (3 + k) + k * 2) * (24 + k * 8), y = 126 + Math.sin(t * (4 + k)) * 8; R(c, x, y, 2, 1, '#14120e'); }
  }

  // chão de terra do açude: capim na beira, pedrinhas, raízes e pegadas
  function chaoAcude(c, t, camL, n) {
    const noite = n > .5;
    for (let x = 0; x < 482; x += 2) { const wx = Math.floor((x + camL) / 2); for (let y = 222; y < 270; y += 2) { const h = hash(wx * 7.3 + y * 1.7); if (h > .9) R(c, x, y, 2, 1, noite ? '#3a3428' : '#a8946a'); else if (h < .08) R(c, x, y, 2, 1, noite ? '#1a1612' : '#6a5a3e'); } }
    for (let i = 0; i < 60; i++) { const wx = i * 41, x = ((wx - camL) % 2460 + 2460) % 2460 - 30; if (x < -10 || x > 490) continue;
      if (hash(i) > .55) { R(c, x, 230 + hash(i * 3) * 34, 3, 2, noite ? '#2a2a2e' : '#8a8a86'); R(c, x, 230 + hash(i * 3) * 34, 3, 1, noite ? '#3a3a40' : '#b8b8b0'); }
      if (hash(i * 7) > .8) { const y = 236 + hash(i) * 24; for (let k = 0; k < 6; k++) R(c, x + k * 2, y + Math.sin(k) * 2, 2, 1, noite ? '#2a2018' : '#5a4228'); }
      if (hash(i * 5) > .7) for (let k = 0; k < 3; k++) { const y = 228 + k * 12 + hash(i + k) * 4; R(c, x + k * 6, y, 2, 3, noite ? '#221e18' : '#76664a'); R(c, x + k * 6 + 3, y + 1, 1, 2, noite ? '#221e18' : '#76664a'); }
    }
    for (let x = 0; x < 482; x += 3) { const wx = Math.floor((x + camL) / 3), h = 2 + hash(wx) * 5, sw = Math.sin(t * 2 + wx * .3) * .8; for (let y = 0; y < h; y++) R(c, x + sw * y / h, 220 - y, 1, 1, noite ? '#1a3a22' : (y > h - 2 ? '#8ac86a' : '#5a9a4a')); }
  }
  window.LugaresFundos = Object.freeze({ chaoAcude, camadaAcude, arvoresAcude, aguaAcude, oficinaParede, oficinaChao, oficinaAnim, lancheParede, lancheRua, lancheChao, lancheAnim });
})();
