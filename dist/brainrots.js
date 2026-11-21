/* Da Roça Adventure — os bichos que o Marco desenha viraram brainrots famosos.
   Cada um é um sprite de pixel art "de verdade": desenhado em baixa resolução (1 pixel da arte =
   2 pixels do jogo), com contorno escuro, luz vindo de cima e sombra embaixo de cada parte
   (feitos sozinhos a partir das cores) e 8 quadros de animação guardados em cache.
   Só troca a aparência: vida, dano e comportamento dos inimigos continuam os mesmos.
   rabisco 0 → Brr Brr Patapim · rabisco 1 → Lirili Larilà · rabisco 2 → Trippi Troppi
   brainrot → Tralalero Tralalà · sixseven → Tung Tung Tung Sahur (taco "67")
   spindle → Ballerina Cappuccina · wobbler → Bombardiro Crocodilo · pasta → Chimpanzini Bananini */
(() => {
  'use strict';
  if (!window.Art || window.Art.__brainrots) return;
  const original = window.Art.drawMinion;
  const S = 2, W = 64, H = 56, AX = 32, AY = 54, N = 8, TAU = Math.PI * 2; // escala, tamanho da arte, âncora (pés)
  const CONTORNO = '#1a1020', PRETO = '#141018', BRANCO = '#ffffff';

  /* ---------- pincel de pixel (sem anti-serrilhado) ---------- */
  let g = null, planas = null; // contexto da arte e cores que não ganham luz/sombra (olhos, dentes, preto)
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
  // barra girada (braço, taco, casca): sai de (x,y) no ângulo dado, com larguras no começo e no fim
  const barra = (x, y, ang, len, w0, w1, col) => { const c = Math.cos(ang), s = Math.sin(ang), nx = -s, ny = c;
    poly([[x + nx * w0 / 2, y + ny * w0 / 2], [x + c * len + nx * w1 / 2, y + s * len + ny * w1 / 2], [x + c * len - nx * w1 / 2, y + s * len - ny * w1 / 2], [x - nx * w0 / 2, y - ny * w0 / 2]], col); };
  // olho: branco com pupila olhando para a frente; bravo ganha sobrancelha inclinada
  const olho = (x, y, bravo, w = 3, h = 3) => { r(x, y, w, h, plana(BRANCO)); const pw = w >= 4 ? 2 : 1; r(x + w - pw - (w >= 4 ? 1 : 0), y + h - 2, pw, 2, plana(PRETO)); if (bravo) { r(x - 1, y - 2, 2, 1, PRETO); r(x + 1, y - 1, w - 1, 1, PRETO); p(x, y, PRETO); } };

  /* ---------- acabamento: luz, sombra e contorno ---------- */
  const mistura = (a, b, k) => [0, 1, 2].map((i) => Math.round(a[i] + (b[i] - a[i]) * k));
  const LUZ = [255, 246, 216], SOMBRA = [42, 24, 56], BORDA = [26, 16, 32];
  function acabamento(cv) {
    const ctx = cv.getContext('2d'), img = ctx.getImageData(0, 0, W, H), d = img.data, cor = new Int32Array(W * H).fill(-1);
    for (let i = 0; i < W * H; i++) if (d[i * 4 + 3] > 127) cor[i] = (d[i * 4] << 16) | (d[i * 4 + 1] << 8) | d[i * 4 + 2];
    const em = (x, y) => (x < 0 || y < 0 || x >= W || y >= H) ? -1 : cor[y * W + x];
    const plano = new Set([...planas].map((c) => parseInt(c.slice(1), 16)));
    const out = new Uint8ClampedArray(d.length);
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { const i = y * W + x, c = cor[i];
      if (c < 0) { if (em(x - 1, y) >= 0 || em(x + 1, y) >= 0 || em(x, y - 1) >= 0 || em(x, y + 1) >= 0) out.set([...BORDA, 255], i * 4); continue; } // contorno
      let rgb = [(c >> 16) & 255, (c >> 8) & 255, c & 255];
      if (!plano.has(c)) {
        const cima = em(x, y - 1) !== c, baixo = em(x, y + 1) !== c, dir = em(x + 1, y) !== c, esq = em(x - 1, y) !== c;
        if (cima && !baixo) rgb = mistura(rgb, LUZ, .34);                       // borda de cima: brilho
        else if (baixo || dir) rgb = mistura(rgb, SOMBRA, baixo && dir ? .44 : .3); // borda de baixo/direita: sombra
        else if (em(x, y + 2) !== c) rgb = mistura(rgb, SOMBRA, .14);          // meia-sombra
        else if (esq || em(x - 1, y - 1) !== c || em(x, y - 2) !== c) rgb = mistura(rgb, LUZ, .14); // meia-luz
      }
      out.set([...rgb, 255], i * 4); }
    img.data.set(out); ctx.putImageData(img, 0, 0);
  }

  /* ---------- os brainrots (na arte: x para a direita, y negativo para cima, pés em y=0, olhando para a direita) ---------- */
  const SPRITES = {
    // Tralalero Tralalà: tubarão azul de tênis, três pernas andando
    tralalero(f, bravo) { const a = f / N * TAU, y0 = -19 + (f % 4 < 2 ? 0 : -1);
      [-9, -1, 7].forEach((lx, k) => { const lev = Math.max(0, Math.round(Math.sin(a + k * 2.09) * 2.4));
        r(lx, y0 + 5, 3, (-4 - lev) - (y0 + 5), '#e8b48c'); // perna
        r(lx - 1, -4 - lev, 6, 3, '#f2f2f2'); r(lx - 1, -2 - lev, 6, 1, '#2c5cc8'); p(lx + 1, -3 - lev, '#2c5cc8'); p(lx + 2, -4 - lev, '#2c5cc8'); }); // tênis com o risquinho azul
      const rabo = [0, 1, 2, 1, 0, -1, -2, -1][f];
      poly([[-14, y0 - 2], [-24, y0 - 10 + rabo], [-20, y0 - 1], [-24, y0 + 6 + rabo], [-14, y0 + 2]], '#3a72b4'); // rabo
      e(0, y0, 15, 7, '#4a88cc'); e(2, y0 + 4, 12, 3, '#eef2f4'); // corpo e barriga
      poly([[-4, y0 - 6], [0, y0 - 15], [4, y0 - 6]], '#3a72b4'); // barbatana de cima
      poly([[1, y0 + 2], [-5, y0 + 9], [6, y0 + 3]], '#3a72b4'); // nadadeira
      r(3, y0 - 2, 1, 4, '#2c5a94'); r(5, y0 - 2, 1, 4, '#2c5a94'); // guelras
      r(8, y0 + 2, 8, 3, plana('#6a1424')); for (let k = 0; k < 4; k++) { p(9 + k * 2, y0 + 2, plana(BRANCO)); p(10 + k * 2, y0 + 4, BRANCO); } // boca com dentes
      olho(9, y0 - 4, bravo, 3, 3); },

    // Tung Tung Tung Sahur: tronco de madeira pulando com o taco "67"
    tungTung(f, bravo) { const y0 = -[0, 2, 4, 5, 5, 4, 2, 0][f];
      r(-5, y0 - 8, 2, 7, '#8a5630'); r(3, y0 - 8, 2, 7, '#8a5630'); r(-7, y0 - 2, 5, 2, '#6a3e20'); r(3, y0 - 2, 5, 2, '#6a3e20'); // pernas e pés
      r(-8, y0 - 36, 16, 29, '#c8864a'); e(0, y0 - 36, 8, 2, '#e8b47c'); e(0, y0 - 36, 5, 1, '#d09a60'); p(0, y0 - 36, '#a86a38'); // tronco e topo cortado
      r(-6, y0 - 31, 1, 7, '#a86a38'); r(5, y0 - 24, 1, 9, '#a86a38'); r(-4, y0 - 15, 1, 5, '#a86a38'); r(2, y0 - 33, 1, 2, '#a86a38'); // veios
      olho(-7, y0 - 29, bravo, 5, 5); olho(1, y0 - 29, bravo, 5, 5);
      if (!bravo) { r(-7, y0 - 31, 5, 1, plana('#4a2810')); r(1, y0 - 31, 5, 1, '#4a2810'); }
      r(-4, y0 - 20, 8, 3, plana('#5a1418')); r(-3, y0 - 19, 6, 1, plana('#d8484a')); p(-5, y0 - 21, '#5a1418'); p(4, y0 - 21, '#5a1418'); // boca sorrindo
      barra(-8, y0 - 20, 2.3, 9, 2, 2, '#a86a38'); // braço esquerdo
      barra(8, y0 - 20, .5, 5, 2, 2, '#a86a38'); // braço do taco
      const ang = [-1.25, -1.45, -1.65, -1.75, -.9, .25, .45, -.4][f], hx = 8 + Math.cos(.5) * 5, hy = y0 - 20 + Math.sin(.5) * 5; // taco subindo e batendo
      barra(hx, hy, ang, 20, 3, 5, '#e8c890'); const tx = hx + Math.cos(ang) * 12, ty = hy + Math.sin(ang) * 12;
      p(tx, ty, plana('#c43c3a')); p(tx + Math.cos(ang) * 3, ty + Math.sin(ang) * 3, '#c43c3a'); },

    // Ballerina Cappuccina: cabeça de xícara de cappuccino, rodopiando na ponta do pé
    ballerina(f, bravo) { const y0 = -[0, 1, 2, 2, 1, 0, 0, 0][f], cima = f % 4 >= 2;
      r(-1, y0 - 14, 2, 13, '#f2cdb4'); r(-1, y0 - 2, 2, 2, '#f08ab4'); // perna na ponta
      barra(1, y0 - 13, .9, 6, 2, 2, '#f2cdb4'); barra(5, y0 - 8, 2.6, 4, 2, 2, '#f2cdb4'); // perna dobrada
      e(0, y0 - 16, 11, 3, '#f8bcd6'); for (let k = -10; k <= 10; k += 3) p(k, y0 - 16 + (k & 1), '#ffe2ee'); // tutu
      r(-3, y0 - 25, 6, 8, '#f08ab4'); p(0, y0 - 22, '#ffd8e8'); // collant
      if (cima) { barra(-3, y0 - 24, -2.1, 9, 2, 2, '#f2cdb4'); barra(3, y0 - 24, -1.05, 9, 2, 2, '#f2cdb4'); }
      else { barra(-3, y0 - 24, Math.PI + .25, 10, 2, 2, '#f2cdb4'); barra(3, y0 - 24, -.25, 10, 2, 2, '#f2cdb4'); }
      r(-1, y0 - 27, 2, 2, '#f2cdb4'); // pescoço
      poly([[-8, y0 - 38], [8, y0 - 38], [6, y0 - 28], [-6, y0 - 28]], '#f6f2ea'); r(-5, y0 - 28, 10, 1, '#e0d8cc'); // xícara
      r(8, y0 - 36, 3, 1, '#f6f2ea'); r(10, y0 - 36, 1, 5, '#f6f2ea'); r(8, y0 - 32, 3, 1, '#f6f2ea'); // asa da xícara
      e(0, y0 - 39, 8, 1, '#c89060'); p(-1, y0 - 40, plana('#f6e6cc')); p(1, y0 - 40, '#f6e6cc'); p(0, y0 - 39, '#f6e6cc'); // espuma com coraçãozinho
      r(-3, y0 - 44, 6, 4, '#f08ab4'); p(-4, y0 - 42, '#f08ab4'); p(3, y0 - 42, '#f08ab4'); // coque com laço
      olho(-5, y0 - 35, bravo, 3, 3); olho(2, y0 - 35, bravo, 3, 3); p(-5, y0 - 31, plana('#f4a0b8')); p(5, y0 - 31, '#f4a0b8'); r(-1, y0 - 31, 2, 1, plana('#a04060')); },

    // Bombardiro Crocodilo: crocodilo-bombardeiro voando, hélice girando
    bombardiro(f, bravo) { const y0 = -26 + [0, 0, -1, -1, -2, -2, -1, -1][f], pa = f % 2;
      poly([[-13, y0 - 1], [-19, y0 - 10], [-15, y0 - 10], [-9, y0 - 3]], '#7a848c'); r(-17, y0 - 9, 2, 2, plana('#c43c3a')); // leme
      e(-2, y0, 14, 4, '#8a949c'); r(-14, y0 - 1, 6, 2, '#5a9a3a'); // fuselagem e rabo de jacaré
      for (let k = -10; k <= 6; k += 3) p(k, y0 - 4, '#3a7a2a'); // escamas nas costas
      poly([[8, y0 - 4], [24, y0 - 2], [24, y0 + 2], [8, y0 + 4]], '#5a9a3a'); r(9, y0 + 1, 15, 1, '#3a6a2a'); // focinho comprido
      for (let k = 0; k < 6; k++) p(11 + k * 2, y0 + (k & 1 ? 0 : 2), plana('#f6f6e8')); p(23, y0 - 2, plana(PRETO)); // dentes e narina
      e(9, y0 - 5, 3, 2, '#5a9a3a'); olho(8, y0 - 7, bravo, 3, 3); // olho em cima da cabeça
      e(-2, y0 + 1, 2, 2, plana('#f6f6e8')); p(-2, y0 + 1, plana('#3a6ab8')); // insígnia
      poly([[-4, y0 + 1], [5, y0 + 1], [-3, y0 + 10], [-11, y0 + 10]], '#6e7880'); r(-9, y0 + 8, 6, 1, '#c43c3a'); // asa
      r(-4, y0 + 5, 4, 3, '#4a5056'); if (pa) r(-3, y0 + 1, 1, 11, plana('#d8dce0')); else r(-8, y0 + 6, 11, 1, plana('#d8dce0')); // motor e hélice
      e(6, y0 + 9, 3, 2, '#3a3f44'); r(1, y0 + 8, 2, 3, '#4a5056'); r(5, y0 + 5, 1, 2, '#4a5056'); p(7, y0 + 8, plana('#c43c3a')); }, // bomba

    // Chimpanzini Bananini: macaquinho dentro da banana que abre e fecha
    chimpanzini(f, bravo) { const y0 = -[0, 1, 2, 2, 1, 0, 0, 0][f], abre = [.15, .3, .55, .8, .9, .8, .55, .3][f];
      r(-4, y0 - 3, 3, 3, '#6a3e1e'); r(1, y0 - 3, 3, 3, '#6a3e1e'); // pés
      e(0, y0 - 15, 7, 12, '#f2cc3a'); r(-1, y0 - 30, 2, 3, '#6a4a1a'); p(-1, y0 - 31, '#4a3010'); // banana e cabinho
      e(0, y0 - 18, 6, 6, '#7a4a26'); e(0, y0 - 16, 4, 4, '#ecc896'); r(-8, y0 - 19, 2, 3, '#7a4a26'); r(7, y0 - 19, 2, 3, '#7a4a26'); // cabeça de macaco
      olho(-3, y0 - 19, bravo, 2, 3); olho(1, y0 - 19, bravo, 2, 3); p(-1, y0 - 15, plana('#5a3018')); p(0, y0 - 15, '#5a3018'); r(-2, y0 - 13, 4, 1, '#5a3018');
      for (const lado of [-1, 1]) { const ang = -Math.PI / 2 + lado * abre; barra(lado * 4, y0 - 4, ang, 22, 5, 3, '#f2cc3a'); barra(lado * 3, y0 - 4, ang, 18, 1, 1, '#fff0a0'); } }, // casca abrindo

    // Brr Brr Patapim: árvore com cara de macaco, nariz comprido e pés gigantes pisando forte
    patapim(f, bravo) { const a = f / N * TAU;
      for (const [lado, fase] of [[-1, Math.sin(a)], [1, -Math.sin(a)]]) { const lev = Math.max(0, Math.round(fase * 3)), px = lado < 0 ? -12 : 2;
        r(lado * 5 - 2, -14 - lev, 4, 11, '#7a4a26'); r(px, -4 - lev, 10, 4, '#e0a878'); r(px, -1 - lev, 10, 1, '#b8805a'); p(px + (lado < 0 ? 0 : 9), -5 - lev, '#e0a878'); } // pernas e pezões
      r(-6, -30, 12, 17, '#8e5a2e'); r(-4, -27, 1, 8, '#6a3e1e'); r(3, -24, 1, 9, '#6a3e1e'); // tronco com casca
      barra(-6, -26, Math.PI + .5, 9, 2, 1, '#7a4a26'); barra(6, -25, -.5, 9, 2, 1, '#7a4a26'); e(-14, -31, 2, 2, '#4a9a3a'); e(14, -30, 2, 2, '#4a9a3a'); // galhos com folhas
      e(0, -33, 7, 5, '#e8c098'); r(-6, -37, 5, 5, plana('#3a2018')); r(0, -37, 5, 5, '#3a2018'); olho(-5, -36, bravo, 3, 3); olho(1, -36, bravo, 3, 3); r(1, -33, 9, 2, '#d8a878'); p(9, -32, '#c08a5a'); r(-3, -30, 4, 1, plana('#6a3018')); // cara e narigão
      e(0, -43, 10, 5, '#3a8a3a'); e(-5, -45, 4, 3, '#58aa48'); e(4, -46, 4, 2, '#58aa48'); e(8, -42, 2, 2, '#2e722e'); e(-9, -41, 2, 2, '#2e722e'); p(-2, -39, '#2e722e'); p(3, -39, '#2e722e'); }, // copa de folhas

    // Lirili Larilà: elefante-cacto de sandália, tromba balançando
    lirili(f, bravo) { const a = f / N * TAU, tr = Math.round(Math.sin(a) * 2);
      [-5, 2].forEach((lx, k) => { const lev = Math.max(0, Math.round(Math.sin(a + k * Math.PI) * 2)); r(lx, -8 - lev, 4, 7, '#4a9a44'); r(lx - 1, -2 - lev, 6, 2, '#a0603a'); p(lx + 1, -3 - lev, '#a0603a'); }); // pernas com sandália
      e(0, -16, 8, 9, '#4a9a44'); r(-1, -24, 1, 16, '#3a7a34'); r(4, -22, 1, 12, '#3a7a34'); r(-5, -21, 1, 10, '#3a7a34'); // corpo de cacto
      r(-12, -21, 3, 7, '#4a9a44'); r(-12, -16, 4, 2, '#4a9a44'); r(9, -24, 3, 7, '#4a9a44'); r(8, -19, 4, 2, '#4a9a44'); // braços de cacto
      for (const [x, y] of [[-6, -18], [-2, -12], [3, -19], [6, -13], [-3, -21], [-11, -20], [10, -23], [1, -9]]) p(x, y, plana('#f6f0c8')); // espinhos
      e(2, -30, 7, 6, '#9aa0ae'); e(-5, -30, 4, 5, '#8a90a0'); e(-5, -30, 2, 3, '#e8a0b0'); // cabeça e orelha
      olho(3, -33, bravo, 3, 3); p(8, -28, plana('#f6f6e8')); // olho e presa
      for (let k = 0; k < 7; k++) r(8 + k + Math.round(Math.sin(k * .6) * tr * .5), -29 + k * 2 + Math.round(k * k * .02 * tr), 3, 3, '#9aa0ae'); // tromba
      p(-1, -36, '#e86a8a'); r(-2, -37, 3, 1, '#e86a8a'); }, // florzinha

    // Trippi Troppi: camarão com cara de gato, rabo batendo
    trippi(f, bravo) { const y0 = -[0, 2, 3, 3, 2, 0, 0, 0][f], fl = [0, -1, -2, -1, 0, 1, 2, 1][f];
      for (let k = 0; k < 4; k++) r(-4 + k * 3, y0 - 6, 1, 5, '#c85a3a'); // perninhas
      [[-11, -17, 6, 5], [-6, -12, 6, 5], [1, -10, 6, 4], [7, -11, 5, 4]].forEach(([x, y, rx, ry], k) => e(x, y0 + y, rx, ry, k % 2 ? '#f08a50' : '#f8a06a')); // corpo em gomos
      poly([[11, y0 - 12], [18, y0 - 17 + fl], [17, y0 - 11], [18, y0 - 5 + fl], [11, y0 - 9]], '#e86a3a'); // leque do rabo
      e(-13, y0 - 26, 7, 6, '#d8d0c8'); poly([[-20, y0 - 29], [-18, y0 - 36], [-15, y0 - 31]], '#d8d0c8'); poly([[-11, y0 - 31], [-8, y0 - 36], [-6, y0 - 29]], '#d8d0c8'); // cabeça de gato
      p(-18, y0 - 33, plana('#f2a0b0')); p(-8, y0 - 33, '#f2a0b0');
      olho(-17, y0 - 28, bravo, 3, 3); olho(-11, y0 - 28, bravo, 3, 3); p(-13, y0 - 24, plana('#e87890')); r(-14, y0 - 23, 3, 1, plana('#5a3a3a'));
      r(-23, y0 - 24, 5, 1, plana('#5a5a5a')); r(-7, y0 - 24, 5, 1, '#5a5a5a'); r(-22, y0 - 22, 4, 1, '#5a5a5a'); r(-7, y0 - 22, 4, 1, '#5a5a5a'); } // bigodes
  };

  /* ---------- cache de quadros ---------- */
  const cache = new Map();
  function quadro(nome, f, bravo) {
    const chave = nome + f + (bravo ? 'b' : '');
    let q = cache.get(chave); if (q) return q;
    const cv = document.createElement('canvas'); cv.width = W; cv.height = H;
    g = cv.getContext('2d', { willReadFrequently: true }); planas = new Set([BRANCO, PRETO]);
    try { SPRITES[nome](f, bravo); acabamento(cv); } catch (err) { try { console.warn('brainrot', nome, err); } catch (e2) {} }
    const branco = document.createElement('canvas'); branco.width = W; branco.height = H; // silhueta branca para o piscar do golpe
    const b = branco.getContext('2d'); b.drawImage(cv, 0, 0); b.globalCompositeOperation = 'source-in'; b.fillStyle = '#fff8ec'; b.fillRect(0, 0, W, H);
    q = { cv, branco }; cache.set(chave, q); g = null; return q;
  }
  const VOA = { bombardiro: true };
  function pintar(ctx, nome, x, y, t, o = {}) {
    const f = ((Math.floor((t || 0) * 9) % N) + N) % N, q = quadro(nome, f, !!o.angry);
    ctx.save(); ctx.translate(Math.round(x), Math.round(y));
    const a0 = ctx.globalAlpha, sw = VOA[nome] ? 12 : 16; // sombra pixelada no chão
    ctx.globalAlpha = a0 * (VOA[nome] ? .18 : .28); ctx.fillStyle = '#0c140c'; ctx.fillRect(-sw, -2, sw * 2, 4); ctx.fillRect(-sw + 4, -4, sw * 2 - 8, 2); ctx.globalAlpha = a0;
    if (o.facing < 0) ctx.scale(-1, 1);
    const suave = ctx.imageSmoothingEnabled; ctx.imageSmoothingEnabled = false;
    ctx.drawImage(q.cv, -AX * S, -AY * S, W * S, H * S);
    if (o.hit && Math.floor((t || 0) * 18) % 2 === 0) { ctx.globalAlpha = a0 * .85; ctx.drawImage(q.branco, -AX * S, -AY * S, W * S, H * S); } // o inimigo só pisca
    ctx.imageSmoothingEnabled = suave; ctx.restore();
  }

  const DESENHOS = { brainrot: 'tralalero', sixseven: 'tungTung', spindle: 'ballerina', wobbler: 'bombardiro', pasta: 'chimpanzini' };
  const RABISCOS = ['patapim', 'lirili', 'trippi'];
  function desenhar(ctx, x, y, kind = 0, t = 0, o = {}) {
    const design = String(o.design || o.variant || (o.type && o.type !== 'doodle' ? o.type : '') || '');
    let nome = DESENHOS[design]; if (!nome && (design === '' || design === 'ink' || design === 'doodle' || /^\d$/.test(design))) nome = RABISCOS[(Number(kind) || 0) % 3];
    if (!nome) return original.call(window.Art, ctx, x, y, kind, t, o);
    pintar(ctx, nome, x, y, (t || 0) + (Number(kind) || 0) * .37, o);
  }
  window.Art.drawMinion = desenhar;
  window.Art.drawBrainrot = (ctx, nome, x, y, t, o = {}) => { if (SPRITES[nome]) pintar(ctx, nome, x, y, t, o); };
  window.Art.brainrots = Object.freeze(Object.keys(SPRITES));
  window.Art.__brainrots = true;
})();
