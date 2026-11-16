/* Cenas no novo padrão de arte (fase 2). Cena de teste: a cantina do Igor.
   - Tudo é desenhado em 480x270 e ampliado 2x sem filtro: uma densidade de pixel só.
   - A hora do dia (DayTime) muda o céu nas janelas, a luz ambiente, os raios que entram
     e acende as lâmpadas à noite. A luz é aplicada depois dos personagens, então eles
     também escurecem à noite e clareiam debaixo das lâmpadas.
   - É só aparência: hitboxes, tempos e física não mudam. No modo Leve vale a arte antiga.
   - Camadas podem ser trocadas por PNG via Sprites: "arena-igor-parede" (780x270). */
(() => {
  'use strict';
  if (!window.Art || !window.Art.drawArena || window.HdScene) return;
  const orig = window.Art.drawArena;
  const LW = 480, LH = 270, WORLD = 780, OFF = 150, FLOOR = 220;
  const HANDLED = { igor: true, kaique: true };
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const css = (v, a) => { const s = `${Math.round(Math.max(0, Math.min(1, v[0])) * 255)},${Math.round(Math.max(0, Math.min(1, v[1])) * 255)},${Math.round(Math.max(0, Math.min(1, v[2])) * 255)}`; return a === undefined ? `rgb(${s})` : `rgba(${s},${a})`; };
  const hex = (h) => [parseInt(h.slice(1, 3), 16) / 255, parseInt(h.slice(3, 5), 16) / 255, parseInt(h.slice(5, 7), 16) / 255];
  const mix = (a, b, k) => [a[0] + (b[0] - a[0]) * k, a[1] + (b[1] - a[1]) * k, a[2] + (b[2] - a[2]) * k];
  const mul = (a, b) => [a[0] * b[0], a[1] * b[1], a[2] * b[2]];
  const active = (type) => !!HANDLED[typeof type === 'object' ? type?.type : type] && !window.Graphics?.isLite?.() && !!window.DayTime;

  // Janelas (coordenadas da camada interna) e lâmpadas de teto.
  const WINS = { igor: [], kaique: [] };
  for (let i = 0; i < 7; i++) WINS.igor.push({ x: OFF - 40 + i * 100, y: 60, w: 65, h: 72 });
  for (let i = -1; i < 7; i++) if (i !== 2) WINS.kaique.push({ x: OFF + 10 + i * 100, y: 60, w: 65, h: 72 }); // o vão do meio fica para o quadro
  const CLOCK = { igor: 241, kaique: 92 }, TITLE = { igor: 'CANTINA · FISCALIZAÇÃO DO LANCHE', kaique: 'CORREDOR · FISCALIZAÇÃO MÁXIMA' };
  let WIN = WINS.igor, cur = 'igor';
  const use = (type) => { cur = HANDLED[type] ? type : 'igor'; WIN = WINS[cur]; };
  const TUBES = [-70, 50, 170, 290, 410, 530].map((x) => OFF + x);
  const FANS = [OFF + 120, OFF + 360];
  const FRIDGE = { x: OFF + 418, y: 124, w: 30, h: 96 };

  // ---------------------------------------------------------------- camada interna (fixa)
  const walls = {};
  function buildWall(type) {
    const [cv, c] = mk(WORLD, LH);
    // reboco, com manchas e pequenas rachaduras
    R(c, 0, 0, WORLD, 148, '#e4d9bd'); R(c, 0, 13, WORLD, 5, '#cfc3a3'); R(c, 0, 18, WORLD, 3, '#dacfb1');
    for (let i = 0; i < 1100; i++) R(c, hash(i) * WORLD, 14 + hash(i + .5) * 130, 1, 1, hash(i * 3) > .5 ? '#d8ccae' : '#ede4cb');
    for (let i = 0; i < 9; i++) { let x = hash(i + 40) * WORLD, y = 22 + hash(i + 60) * 90; for (let k = 0; k < 9; k++) { R(c, x, y, 1, 1, '#bfb291'); x += hash(i * 9 + k) > .5 ? 1 : -1; y += 1; } }
    for (let i = 0; i < 6; i++) { const x = hash(i + 80) * WORLD, y = 100 + hash(i + 90) * 30; c.fillStyle = 'rgba(150,135,100,.10)'; c.fillRect(Math.round(x), Math.round(y), 14 + Math.round(hash(i) * 18), 10 + Math.round(hash(i + 5) * 8)); }
    // teto com vigas
    R(c, 0, 0, WORLD, 10, '#2e3d47'); R(c, 0, 10, WORLD, 3, '#445762'); R(c, 0, 13, WORLD, 1, '#1f2a31');
    for (let x = 10; x < WORLD; x += 60) { R(c, x, 0, 6, 13, '#243038'); R(c, x, 0, 1, 13, '#3a4c57'); }
    // azulejos da meia parede
    R(c, 0, 148, WORLD, 72, '#2b5b82');
    const T = ['#2b5b82', '#2f6189', '#27557a', '#2d5e86'];
    for (let ty = 0; ty < 9; ty++) for (let tx = 0; tx < WORLD / 8; tx++) {
      const x = tx * 8, y = 148 + ty * 8, n = tx * 31 + ty * 17;
      R(c, x, y, 8, 8, T[Math.floor(hash(n) * 4)]); R(c, x, y, 8, 1, '#3d73a0'); R(c, x, y, 1, 8, '#376a94'); R(c, x + 7, y, 1, 8, '#1e4566'); R(c, x, y + 7, 8, 1, '#1e4566');
      if (hash(n + 7) > .93) R(c, x + 2, y + 2, 3, 1, '#5c8fb8'); // brilho
      if (hash(n + 3) > .975) { R(c, x + 4, y + 4, 3, 3, '#1b3d59'); R(c, x + 5, y + 3, 1, 1, '#1b3d59'); } // lascado
    }
    for (let tx = 0; tx < WORLD / 8; tx++) { const x = tx * 8; R(c, x, 156, 8, 8, tx % 2 ? '#e9dfc0' : '#d79a4a'); R(c, x, 156, 8, 1, tx % 2 ? '#fff8e0' : '#eab768'); R(c, x + 7, 156, 1, 8, tx % 2 ? '#bdb18f' : '#a8722f'); R(c, x, 163, 8, 1, tx % 2 ? '#bdb18f' : '#a8722f'); }
    R(c, 0, 143, WORLD, 1, '#fffbe6'); R(c, 0, 144, WORLD, 4, '#f1ead0'); R(c, 0, 148, WORLD, 1, '#b9ad8c');
    R(c, 0, 213, WORLD, 7, '#1d3f5c'); R(c, 0, 213, WORLD, 1, '#3a6f98');
    // piso em xadrez com perspectiva
    const rows = [5, 6, 8, 9, 10, 12]; let fy = FLOOR;
    rows.forEach((rh, r) => {
      const tw = 22 + r * 5, mid = WORLD / 2, n0 = -Math.ceil(mid / tw) - 1;
      for (let k = n0; k <= -n0; k++) {
        const x = mid + k * tw, light = (k + r) & 1, shade = r / 5;
        R(c, x, fy, tw, rh, light ? css(mix(hex('#b4c3bc'), hex('#d2ddd4'), shade)) : css(mix(hex('#8ea39d'), hex('#a9bbb5'), shade)));
        R(c, x, fy, tw, 1, light ? '#dfe8df' : '#b5c5bf'); R(c, x, fy, 1, rh, '#7f948f');
        if (hash(k * 13 + r * 7) > .86) R(c, x + 3 + hash(k + r) * (tw - 8), fy + 2, 3, 1, 'rgba(60,80,76,.35)'); // arranhão
      }
      fy += rh;
    });
    R(c, 0, FLOOR, WORLD, 1, '#eef0dc');
    for (let i = 0; i < 4; i++) { c.fillStyle = `rgba(20,36,44,${.22 - i * .05})`; c.fillRect(0, FLOOR + 1 + i, WORLD, 1); }
    // janelas: moldura, vidro (transparente), travessas, cortininha xadrez e peitoril
    for (const w of WIN) {
      R(c, w.x - 5, w.y - 5, w.w + 10, w.h + 10, '#1f3f50'); R(c, w.x - 4, w.y - 4, w.w + 8, w.h + 8, '#3b6c80'); R(c, w.x - 4, w.y - 4, w.w + 8, 1, '#5b93a8'); R(c, w.x - 4, w.y - 4, 1, w.h + 8, '#4f8498'); R(c, w.x - 1, w.y - 1, w.w + 2, w.h + 2, '#16303c');
      c.clearRect(w.x, w.y, w.w, w.h);
      for (let yy = 0; yy < w.h; yy++) { c.fillStyle = 'rgba(255,255,255,.10)'; c.fillRect(w.x + 8 + Math.round((w.h - yy) * .35), w.y + yy, 7, 1); c.fillStyle = 'rgba(255,255,255,.07)'; c.fillRect(w.x + 22 + Math.round((w.h - yy) * .35), w.y + yy, 3, 1); }
      R(c, w.x + 31, w.y, 3, w.h, '#e9ecd8'); R(c, w.x + 33, w.y, 1, w.h, '#b3bdaa'); R(c, w.x, w.y + 24, w.w, 3, '#e9ecd8'); R(c, w.x, w.y + 26, w.w, 1, '#b3bdaa');
      for (let k = 0; k < w.w; k += 3) { const red = (k / 3) & 1; R(c, w.x + k, w.y, 3, 3, red ? '#c9473d' : '#f3ead6'); R(c, w.x + k, w.y + 3, 3, 3, red ? '#f3ead6' : '#c9473d'); R(c, w.x + k, w.y + 6, 3, (k / 3) % 4 < 2 ? 2 : 1, red ? '#a8362e' : '#d9cfb8'); }
      R(c, w.x - 8, w.y + w.h + 5, w.w + 16, 4, '#eef0dc'); R(c, w.x - 8, w.y + w.h + 5, w.w + 16, 1, '#ffffff'); R(c, w.x - 8, w.y + w.h + 9, w.w + 16, 2, '#a9b3a0'); c.fillStyle = 'rgba(0,0,0,.13)'; c.fillRect(w.x - 6, w.y + w.h + 11, w.w + 12, 2);
    }
    // cartazes entre as janelas (o vão central fica para o relógio)
    const POST = [['#e8c25a', '#b5533c'], ['#8fc0a0', '#2d6a55'], ['#e9e2c8', '#3b6c96'], ['#d9c8e8', '#5a3f8c'], ['#f0b9a0', '#8c3f4f'], ['#b9d3e8', '#34577a']];
    POST.forEach((p, i) => { if (!WIN[i + 1] || WIN[i + 1].x - WIN[i].x > 110) return; const gx = WIN[i].x + WIN[i].w + 17 - OFF; if (Math.abs(gx - CLOCK[type]) < 14) return; const x = WIN[i].x + WIN[i].w + 9, y = 76 + (i % 2) * 5; R(c, x - 1, y - 1, 19, 27, '#8a7d62'); R(c, x, y, 17, 25, p[0]); R(c, x + 2, y + 2, 13, 3, p[1]); for (let k = 0; k < 4; k++) R(c, x + 2, y + 8 + k * 4, 6 + Math.round(hash(i * 5 + k) * 7), 1, p[1]); R(c, x + 6, y + 19, 5, 4, p[1]); R(c, x + 8, y - 2, 1, 2, '#c94f45'); });
    // faixa da cantina, pendurada por correntes
    const sx = OFF + 62;
    for (const cx of [sx + 24, sx + 330]) for (let y = 13; y < 21; y += 2) R(c, cx, y, 1, 1, '#8b98a0');
    R(c, sx - 3, 19, 361, 30, '#16324c'); R(c, sx - 2, 20, 359, 28, '#f5efd6'); R(c, sx, 22, 355, 24, '#1f4467'); R(c, sx, 22, 355, 1, '#3b6c96'); R(c, sx, 45, 355, 1, '#16324c');
    for (const [bx, by] of [[sx + 2, 24], [sx + 351, 24], [sx + 2, 42], [sx + 351, 42]]) R(c, bx, by, 2, 2, '#d7b45a');
    // luminárias de tubo (o brilho é dinâmico)
    for (const x of TUBES) { R(c, x - 2, 12, 48, 4, '#55656e'); R(c, x - 2, 12, 48, 1, '#738790'); R(c, x + 4, 9, 1, 3, '#1f2a31'); R(c, x + 39, 9, 1, 3, '#1f2a31'); }
    if (type === 'igor') {
    // balcão de madeira com estufa de salgados (esquerda)
    const bx = OFF + 32;
    R(c, bx, 160, 105, 60, '#a8845c'); for (let k = 0; k < 105; k += 7) { R(c, bx + k, 160, 1, 60, '#8a6a47'); R(c, bx + k + 1, 160, 1, 60, '#b99468'); }
    for (let i = 0; i < 26; i++) R(c, bx + 2 + hash(i + 200) * 100, 162 + hash(i + 220) * 54, 2 + Math.round(hash(i) * 3), 1, '#92714d');
    R(c, bx - 3, 153, 111, 7, '#ecdcb0'); R(c, bx - 3, 153, 111, 1, '#fff6d6'); R(c, bx - 3, 159, 111, 1, '#b7a57a'); c.fillStyle = 'rgba(0,0,0,.20)'; c.fillRect(bx, 160, 105, 3);
    R(c, bx + 5, 168, 95, 13, '#6f573c'); R(c, bx + 6, 169, 93, 11, '#7c6348'); R(c, bx + 6, 169, 93, 1, '#927757');
    R(c, bx + 8, 131, 66, 22, '#cfd8d0'); R(c, bx + 9, 132, 64, 20, '#3a4a4c'); R(c, bx + 9, 132, 64, 1, '#eef4ee'); R(c, bx + 10, 141, 62, 1, '#9aa7a0');
    for (let k = 0; k < 7; k++) { const px = bx + 12 + k * 9; R(c, px, 135, 6, 5, '#d8943f'); R(c, px + 1, 134, 4, 1, '#e9b25e'); R(c, px + 2, 133, 2, 1, '#e9b25e'); R(c, px + 1, 139, 4, 1, '#a9692a'); R(c, px, 144, 7, 4, k % 2 ? '#e2c27a' : '#c98a4a'); R(c, px, 144, 7, 1, '#f1dca0'); }
    c.fillStyle = 'rgba(210,235,240,.22)'; c.fillRect(bx + 9, 132, 64, 20); c.fillStyle = 'rgba(255,255,255,.25)'; for (let yy = 0; yy < 20; yy++) c.fillRect(bx + 16 + Math.round((20 - yy) * .5), 132 + yy, 3, 1);
    R(c, bx + 80, 143, 4, 10, '#c5382f'); R(c, bx + 81, 141, 2, 2, '#e8e0d0'); R(c, bx + 86, 143, 4, 10, '#e2b93a'); R(c, bx + 87, 141, 2, 2, '#e8e0d0'); R(c, bx + 93, 146, 9, 7, '#dfe6e2'); R(c, bx + 94, 144, 7, 2, '#f7faf6');
    // balcão de inox, suqueira e geladeira (direita)
    const rx = OFF + 347;
    R(c, rx, 162, 70, 58, '#6a909c'); R(c, rx, 162, 70, 1, '#8fb3be'); for (let k = 0; k < 70; k += 23) R(c, rx + k, 163, 1, 57, '#557985'); R(c, rx + 4, 168, 62, 13, '#4c6f7b'); R(c, rx + 5, 169, 60, 11, '#5b818d');
    R(c, rx - 3, 155, 76, 7, '#d9e1d6'); R(c, rx - 3, 155, 76, 1, '#ffffff'); R(c, rx - 3, 161, 76, 1, '#96a39c'); c.fillStyle = 'rgba(0,0,0,.20)'; c.fillRect(rx, 162, 70, 3);
    for (const [jx, col, col2] of [[rx + 8, '#e8973a', '#f4bd6a'], [rx + 26, '#8e4aa8', '#b77fd0']]) { R(c, jx, 150, 14, 5, '#39464c'); R(c, jx + 1, 130, 12, 20, '#cfe3e6'); R(c, jx + 2, 135, 10, 15, col); R(c, jx + 2, 135, 10, 1, col2); R(c, jx + 3, 131, 2, 18, 'rgba(255,255,255,.45)'); R(c, jx, 127, 14, 3, '#39464c'); R(c, jx + 6, 151, 2, 3, '#aab6ba'); }
    for (let k = 0; k < 4; k++) R(c, rx + 46 + k * 5, 149 - (k % 2), 4, 6 + (k % 2), k % 2 ? '#e9e2c8' : '#c9dfe6');
    const f = FRIDGE;
    R(c, f.x - 1, f.y - 1, f.w + 2, f.h + 1, '#27343a'); R(c, f.x, f.y, f.w, f.h, '#dfe6e2'); R(c, f.x, f.y, f.w, 9, '#c2433a'); R(c, f.x, f.y + 8, f.w, 1, '#8e2c26'); R(c, f.x + 3, f.y + 12, f.w - 6, f.h - 26, '#10222a');
    for (let s = 0; s < 4; s++) { const yy = f.y + 14 + s * 17; R(c, f.x + 3, yy + 14, f.w - 6, 1, '#8fa1a6'); for (let k = 0; k < 5; k++) { const col = ['#e04a3a', '#3aa655', '#e8b33a', '#3a7fd0', '#e07a2a'][(k + s) % 5]; R(c, f.x + 5 + k * 4, yy + 4, 3, 10, col); R(c, f.x + 6 + k * 4, yy + 2, 1, 2, '#e9eef0'); R(c, f.x + 5 + k * 4, yy + 8, 3, 2, '#f1efe2'); } }
    c.fillStyle = 'rgba(190,235,245,.16)'; c.fillRect(f.x + 3, f.y + 12, f.w - 6, f.h - 26); R(c, f.x + f.w - 5, f.y + 40, 2, 16, '#f7faf6'); R(c, f.x, f.y + f.h - 12, f.w, 12, '#b9c3bf'); for (let k = 0; k < 6; k++) R(c, f.x + 4, f.y + f.h - 10 + k * 2, f.w - 8, 1, '#7d8a86');
    } else {
    // corredor: armários de aço dos dois lados e quadro de avisos no meio
    const locker = (x, n) => { R(c, x - 1, 149, 28, 71, '#22394a'); R(c, x, 150, 26, 70, '#5c8ca2'); R(c, x, 150, 26, 1, '#86b4c6'); R(c, x, 150, 1, 70, '#7aa6b8'); R(c, x + 25, 150, 1, 70, '#3f6a80'); R(c, x + 3, 154, 20, 62, '#6f9db0'); R(c, x + 3, 154, 20, 1, '#8fbccb'); R(c, x + 22, 154, 1, 62, '#4f7f94');
      for (let v = 0; v < 4; v++) R(c, x + 6, 158 + v * 3, 14, 1, '#31566b'); R(c, x + 8, 173, 10, 5, '#e3dfc1'); R(c, x + 9, 174, 8, 1, '#8a8468'); R(c, x + 19, 186, 2, 7, '#d9e1d6'); R(c, x + 19, 192, 2, 1, '#8fa1a6');
      if (n % 3 === 0) { R(c, x + 6, 198, 6, 6, '#e8c23a'); R(c, x + 7, 199, 4, 1, '#fff3a8'); } if (n % 3 === 1) { R(c, x + 12, 201, 7, 5, '#e04a3a'); R(c, x + 13, 202, 2, 2, '#ffffff'); } if (n % 4 === 2) for (let d = 0; d < 5; d++) R(c, x + 5 + d * 3, 208 + (d % 2), 2, 1, '#3f6a80'); };
    for (let n = 0; n < 3; n++) { locker(OFF + 22 + n * 27, n); locker(OFF + 378 + n * 27, n + 3); }
    R(c, OFF + 30, 141, 12, 8, '#c9573f'); R(c, OFF + 30, 141, 12, 1, '#e88a6a'); R(c, OFF + 44, 143, 14, 6, '#3b6c96'); R(c, OFF + 44, 143, 14, 1, '#6a9cc4'); R(c, OFF + 430, 139, 10, 10, '#e07a2a'); R(c, OFF + 432, 141, 6, 1, '#2a1e18'); R(c, OFF + 434, 139, 1, 10, '#2a1e18'); // livros e bola em cima
    const qx = OFF + 177; R(c, qx - 3, 59, 136, 78, '#5a4030'); R(c, qx - 2, 60, 134, 76, '#8a6a47'); R(c, qx - 2, 60, 134, 1, '#b08a5c'); R(c, qx, 62, 130, 72, '#2f5f4a'); R(c, qx, 62, 130, 1, '#244a3a'); for (let i = 0; i < 160; i++) R(c, qx + 2 + hash(i + 900) * 126, 64 + hash(i + 910) * 68, 2, 1, hash(i) > .5 ? '#3a705a' : '#295442');
    R(c, qx + 6, 126, 16, 3, '#f3f0e2'); R(c, qx + 26, 127, 8, 2, '#f0c8d0'); R(c, qx + 104, 125, 18, 5, '#c9b28a'); R(c, qx + 105, 126, 16, 2, '#e8dcc0'); // giz e apagador
    R(c, qx + 58, 48, 14, 9, '#3a2a2a'); R(c, qx + 60, 44, 10, 6, '#7a1a1a'); // sirene
    // cestos de papel
    for (const bx2 of [OFF + 150, OFF + 322]) { R(c, bx2, 200, 16, 20, '#39464c'); for (let k = 0; k < 16; k += 3) R(c, bx2 + k, 201, 1, 18, '#6f8088'); R(c, bx2 - 1, 199, 18, 2, '#8fa1a6'); R(c, bx2 + 3, 195, 5, 5, '#f1ecdf'); R(c, bx2 + 9, 196, 4, 4, '#e3ddcc'); }
    }
    // lixeira, bebedouro e sombras de contato
    R(c, OFF + 4, 198, 14, 22, '#3f8a52'); R(c, OFF + 3, 195, 16, 4, '#57a86a'); R(c, OFF + 8, 204, 6, 6, '#e9f2e0'); R(c, OFF + 462, 176, 12, 44, '#cfd8dc'); R(c, OFF + 462, 176, 12, 1, '#ffffff'); R(c, OFF + 463, 160, 10, 16, '#7ec3e6'); R(c, OFF + 464, 162, 2, 12, '#c9ecfa'); R(c, OFF + 466, 190, 4, 3, '#39464c');
    c.fillStyle = 'rgba(15,30,36,.25)'; for (const [x0, w0] of (type === 'igor' ? [[OFF + 30, 109], [OFF + 345, 74], [FRIDGE.x - 2, FRIDGE.w + 4], [OFF + 3, 16], [OFF + 461, 14]] : [[OFF + 21, 83], [OFF + 377, 83], [OFF + 3, 16], [OFF + 461, 14], [OFF + 149, 18], [OFF + 321, 18]])) { c.fillRect(x0, FLOOR, w0, 2); c.fillRect(x0 + 2, FLOOR + 2, w0 - 4, 1); }
    return cv;
  }
  function wallLayer() {
    const s = window.Sprites?.get?.('arena-' + cur + '-parede'); if (s) return s.img;
    if (!walls[cur]) walls[cur] = buildWall(cur); return walls[cur];
  }

  // ---------------------------------------------------------------- lado de fora (dinâmico)
  const SKIN = ['#f0c8a0', '#c8946a', '#8a5a3c', '#e0aa80', '#6e452e'], HAIR = ['#2a1e18', '#4a2e1c', '#161616', '#7a4a24', '#d8b25a'], SHIRT = ['#e04a3a', '#3a7fd0', '#e8c23a', '#3aa655', '#f0f0f0', '#9a5ac8'];
  function pixelDisc(c, cx, cy, r, col) { c.fillStyle = col; for (let y = -r; y <= r; y++) { const w = Math.round(Math.sqrt(r * r - y * y)); c.fillRect(Math.round(cx - w), Math.round(cy + y), w * 2 + 1, 1); } }
  function outdoor(c, s, t, ox) {
    // "pre" compensa a luz ambiente que será multiplicada por cima no fim do quadro
    const pre = (v) => [Math.min(1, v[0] / s.amb[0]), Math.min(1, v[1] / s.amb[1]), Math.min(1, v[2] / s.amb[2])];
    const day = 1 - s.night, light = mix([.34, .4, .62], [1, 1, 1], day);
    for (let i = 0; i < 18; i++) { const k = i / 17, col = pre(mix(s.top, s.bot, k * k * .4 + k * .6)); R(c, 0, 50 + i * 5, LW, 5, css(col)); }
    if (s.night > .25) for (let i = 0; i < 70; i++) { const tw = .5 + .5 * Math.sin(t * (1 + hash(i) * 2) + i); c.fillStyle = `rgba(255,255,255,${(s.night - .25) * 1.3 * (.4 + .6 * tw) * (.5 + hash(i + 9) * .5)})`; c.fillRect(Math.round((hash(i + 300) * 520 + ox * .04) % 480), 52 + Math.round(hash(i + 400) * 62), 1, 1); }
    if (s.sunT !== null) { const x = 30 + s.sunT * 420 + ox * .05, y = 136 - Math.sin(s.sunT * Math.PI) * 70; pixelDisc(c, x, y, 13, css(pre(s.sun), .18)); pixelDisc(c, x, y, 10, css(pre(s.sun), .35)); pixelDisc(c, x, y, 7, css(pre(mix(s.sun, [1, 1, 1], .55)))); }
    if (s.moonT !== null) { const x = 40 + s.moonT * 400 + ox * .05, y = 128 - Math.sin(s.moonT * Math.PI) * 58; pixelDisc(c, x, y, 9, 'rgba(200,215,255,.16)'); pixelDisc(c, x, y, 6, '#ffffff'); R(c, x - 3, y - 2, 2, 2, '#c9d4f0'); R(c, x + 1, y + 2, 2, 1, '#c9d4f0'); R(c, x + 2, y - 3, 1, 1, '#c9d4f0'); }
    const cloud = pre(mix(mix(s.bot, [1, 1, 1], .55 * day + .1), s.top, s.night * .5));
    for (let i = 0; i < 6; i++) { const x = ((hash(i + 20) * 620 + t * (2 + hash(i) * 3)) % 620) - 70 + ox * .08, y = 58 + hash(i + 30) * 40, w = 28 + hash(i + 31) * 26; c.fillStyle = css(cloud, .85); c.fillRect(Math.round(x), Math.round(y), Math.round(w), 4); c.fillRect(Math.round(x + 5), Math.round(y - 3), Math.round(w - 12), 3); c.fillRect(Math.round(x + 10), Math.round(y - 5), Math.round(w * .4), 2); c.fillStyle = css(mul(cloud, [.86, .88, .95]), .85); c.fillRect(Math.round(x + 3), Math.round(y + 4), Math.round(w - 8), 1); }
    // cidade ao longe, com janelas que acendem à noite
    const far = pre(mix(s.bot, mul([.28, .34, .5], light), .6));
    for (let i = 0; i < 34; i++) { const bw = 12 + Math.round(hash(i + 50) * 16), bh = 14 + Math.round(hash(i + 60) * 34), x = Math.round(i * 19 - 80 + ox * .15), y = 133 - bh; R(c, x, y, bw, bh, css(far)); R(c, x, y, 1, bh, css(mix(far, pre(s.sun), .25 * day))); if (hash(i + 70) > .6) R(c, x + 3, y - 4, 1, 4, css(far));
      for (let wy = 3; wy < bh - 3; wy += 5) for (let wx = 2; wx < bw - 2; wx += 4) { const lit = hash(i * 31 + wx * 7 + wy) > .55; if (lit && s.night > .3) R(c, x + wx, y + wy, 2, 2, `rgba(255,${200 + Math.round(hash(wx + wy) * 50)},120,${Math.min(1, (s.night - .3) * 2)})`); else R(c, x + wx, y + wy, 2, 2, css(mul(far, [.82, .86, .92]))); } }
    // árvores do pátio balançando e muro da escola
    for (let i = 0; i < 12; i++) { const x = Math.round(i * 52 - 60 + ox * .35 + hash(i + 90) * 20), sway = Math.round(Math.sin(t * 1.3 + i * 1.7) * 1.5), g = pre(mul(hex(i % 2 ? '#3f7a45' : '#4f8f4a'), light)), g2 = pre(mul(hex('#6aa85a'), light)), g3 = pre(mul(hex('#2c5a36'), light)); R(c, x + 9, 112, 3, 22, css(pre(mul(hex('#5a4030'), light)))); pixelDisc(c, x + 10 + sway, 104, 12, css(g)); pixelDisc(c, x + 3 + sway, 110, 8, css(g3)); pixelDisc(c, x + 17 + sway, 109, 8, css(g)); pixelDisc(c, x + 7 + sway * 1.5, 99, 6, css(g2)); }
    const wallCol = pre(mul(hex('#b9a98a'), light)); R(c, 0, 122, LW, 12, css(wallCol)); R(c, 0, 122, LW, 1, css(mul(wallCol, [1.1, 1.1, 1.1]))); for (let x = -((ox * .35) % 16 + 16) % 16; x < LW; x += 16) R(c, x, 123, 1, 11, css(mul(wallCol, [.82, .82, .84])));
    // torcida espiando pelas janelas
    for (let i = 0; i < WIN.length; i++) { const w = WIN[i]; for (let k = 0; k < 4; k++) { const n = i * 7 + k, px = w.x - OFF + ox + 4 + k * 15 + Math.round(hash(n + 110) * 4), bob = Math.round(Math.max(0, Math.sin(t * (4.5 + hash(n) * 2) + n * 1.9)) * 3), py = w.y + w.h - 14 - Math.round(hash(n + 120) * 6) - bob; if (px < -16 || px > LW + 4) continue;
      const skin = css(pre(mul(hex(SKIN[n % 5]), light))), hair = css(pre(mul(hex(HAIR[(n * 3) % 5]), light))), shirt = css(pre(mul(hex(SHIRT[(n * 5) % 6]), light)));
      R(c, px - 2, py + 10, 14, 30, shirt); R(c, px, py, 10, 10, skin); R(c, px, py - 2, 10, 4, hair); R(c, px - 1, py, 1, 5, hair); R(c, px + 2, py + 5, 1, 2, '#1c1c22'); R(c, px + 6, py + 5, 1, 2, '#1c1c22'); if ((n + Math.floor(t * 2)) % 5 === 0) R(c, px + 3, py + 8, 4, 1, '#5a2a2a');
      if ((n + Math.floor(t * 1.5)) % 4 === 0) { R(c, px + 11, py - 6 - bob, 3, 14, skin); R(c, px + 10, py - 9 - bob, 5, 4, skin); } } }
  }

  // ---------------------------------------------------------------- quadro de fundo
  const [low, lc] = mk(LW, LH), [lightCv, lg] = mk(LW, LH);
  let lampFlicker = 1;
  function back(c, type, camera, t, homeX) {
    use(type);
    const s = window.DayTime.state(), center = homeX ? homeX - camera : 480, ox = Math.round((center - 480) / 2);
    lc.clearRect(0, 0, LW, LH); R(lc, 0, 0, LW, LH, '#101820');
    outdoor(lc, s, t, ox);
    lc.drawImage(wallLayer(), ox - OFF, 0);
    // relógio da parede marcando a hora do jogo
    const kx = ox + CLOCK[cur], ky = 90; pixelDisc(lc, kx, ky, 10, '#2a3840'); pixelDisc(lc, kx, ky, 8, '#f3efdf'); for (let i = 0; i < 12; i++) R(lc, kx + Math.round(Math.sin(i / 6 * Math.PI) * 7), ky - Math.round(Math.cos(i / 6 * Math.PI) * 7), 1, 1, i % 3 ? '#9aa39c' : '#2a3840');
    const hand = (ang, len, col) => { for (let k = 0; k <= len; k++) R(lc, kx + Math.round(Math.sin(ang) * k), ky - Math.round(Math.cos(ang) * k), 1, 1, col); };
    hand(s.h / 12 * Math.PI * 2, 4, '#1f2a31'); hand((s.h % 1) * Math.PI * 2, 6, '#c94f45'); R(lc, kx, ky, 1, 1, '#1f2a31');
    // tubos: apagados de dia, acesos à noite (um deles pisca)
    lampFlicker = hash(Math.floor(t * 14)) > .9 ? .35 : 1;
    TUBES.forEach((x, i) => { const on = Math.max(0, Math.min(1, (s.night - .15) * 2)) * (i === 2 ? lampFlicker : 1); R(lc, ox - OFF + x, 14, 44, 2, css(mix([.62, .68, .7], [1.6 / s.amb[0], 1.5 / s.amb[1], 1.2 / s.amb[2]], on))); });
    // ventiladores de teto
    for (const fx of FANS) { const x = ox - OFF + fx, wv = Math.round(Math.abs(Math.cos(t * 9 + fx)) * 17) + 2; R(lc, x, 13, 2, 5, '#1f2a31'); R(lc, x - 2, 18, 6, 3, '#55656e'); R(lc, x - wv, 19, wv * 2 + 2, 1, '#8a6a47'); R(lc, x - Math.round(wv * .5), 20, wv + 2, 1, '#6f573c'); }
    if (cur === 'igor') {
    // vapor da estufa e bolhas da suqueira
    for (let i = 0; i < 9; i++) { const k = (t * .35 + hash(i + 500)) % 1, x = ox + 44 + hash(i + 510) * 56 + Math.sin(t * 2 + i) * 3; lc.fillStyle = `rgba(255,255,255,${(1 - k) * .30})`; lc.fillRect(Math.round(x), Math.round(130 - k * 26), 2 + Math.round(k * 2), 2); }
    for (let i = 0; i < 6; i++) { const k = (t * .8 + hash(i + 600)) % 1, jx = ox + 347 + (i % 2 ? 26 : 8) + 3 + Math.round(hash(i + 610) * 7); lc.fillStyle = 'rgba(255,255,255,.55)'; lc.fillRect(jx, Math.round(149 - k * 13), 1, 1); }
    } else { const on = Math.sin(t * 6) > 0; R(lc, ox + 237, 44, 10, 6, on ? '#ff4a3a' : '#7a1a1a'); if (on) R(lc, ox + 239, 45, 3, 2, '#ffd0c0'); }
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(low, 0, 0, 960, 540);
    // letreiros na mesma densidade de pixel (fonte pixelada a 16px = 2x)
    c.translate(ox * 2, 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace';
    c.fillStyle = '#0f2a44'; c.fillText(TITLE[cur], 482, 70); c.fillStyle = '#fff0c4'; c.fillText(TITLE[cur], 480, 68);
    if (cur === 'igor') { c.fillStyle = '#f0e2b8'; c.fillText('SEM LANCHE', 170, 351); c.fillStyle = '#e4f0f0'; c.fillText('SUCOS', 764, 351); }
    else { c.fillStyle = '#f3f0e2'; c.fillText('BOLINHAS NO CESTO!', 484, 152); c.fillStyle = '#f7e08a'; c.fillText('OLHE A MIRA.', 484, 186); c.fillText('ATAQUE NA', 484, 210); c.fillText('RECARGA.', 484, 234); }
    c.restore();
  }

  // ---------------------------------------------------------------- luz (depois dos atores)
  function quad(g, pts, c0, c1, y0, y1) { const gr = g.createLinearGradient(0, y0, 0, y1); gr.addColorStop(0, c0); gr.addColorStop(1, c1); g.fillStyle = gr; g.beginPath(); g.moveTo(pts[0][0], pts[0][1]); for (let i = 1; i < pts.length; i++) g.lineTo(pts[i][0], pts[i][1]); g.closePath(); g.fill(); }
  function glow(g, x, y, rx, ry, col, a) { g.save(); g.translate(x, y); g.scale(1, ry / rx); const gr = g.createRadialGradient(0, 0, 0, 0, 0, rx); gr.addColorStop(0, css(col, a)); gr.addColorStop(1, css(col, 0)); g.fillStyle = gr; g.fillRect(-rx, -rx, rx * 2, rx * 2); g.restore(); }
  function front(c, type, camera, t, homeX, blend = 1) {
    if (!active(type)) return;
    use(typeof type === 'object' ? type.type : type);
    const s = window.DayTime.state(), center = homeX ? homeX - camera : 480, ox = Math.round((center - 480) / 2), b = Math.max(0, Math.min(1, blend));
    c.save();
    c.globalCompositeOperation = 'multiply'; c.fillStyle = css(mix([1, 1, 1], s.amb, b)); c.fillRect(-40, -40, 1040, 620);
    lg.clearRect(0, 0, LW, LH);
    // luz das janelas: sol de dia, lua à noite; a inclinação acompanha o astro
    const T = s.sunT !== null ? s.sunT : s.moonT, str = s.sunT !== null ? Math.min(1, Math.sin(s.sunT * Math.PI) * 1.6 + .25) : s.moonT !== null ? .45 * Math.sin(s.moonT * Math.PI) : 0;
    if (T !== null && str > .02) {
      const col = s.sunT !== null ? s.sun : [.6, .7, 1], lean = (T - .5) * 2, skew = lean * 62, reach = 20 + Math.abs(lean) * 30;
      for (const w of WIN) { const x = w.x - OFF + ox; if (x > LW + 90 || x + w.w < -90) continue;
        quad(lg, [[x, w.y], [x + w.w, w.y], [x + w.w + skew * .55, FLOOR + 1], [x + skew * .55, FLOOR + 1]], css(col, .11 * str), css(col, .04 * str), w.y, FLOOR);
        quad(lg, [[x + skew * .55, FLOOR + 1], [x + w.w + skew * .55, FLOOR + 1], [x + w.w + skew + 8, FLOOR + 1 + reach], [x + skew - 8, FLOOR + 1 + reach]], css(col, .30 * str), css(col, 0), FLOOR, FLOOR + reach);
        for (let i = 0; i < 5; i++) { const k = (t * .12 + hash(i + w.x)) % 1, mx = x + hash(i * 3 + w.x) * w.w + skew * .55 * k, my = w.y + k * (FLOOR - w.y); lg.fillStyle = css(col, .5 * str * (.5 + .5 * Math.sin(t * 3 + i + w.x))); lg.fillRect(Math.round(mx), Math.round(my), 1, 1); } }
    }
    // lâmpadas de tubo: cone de luz e poça no chão
    const lamp = Math.max(0, Math.min(1, (s.night - .15) * 2));
    if (lamp > .01) TUBES.forEach((tx, i) => { const x = tx - OFF + ox + 22, a = lamp * (i === 2 ? lampFlicker : 1); if (x < -120 || x > LW + 120) return;
      quad(lg, [[x - 22, 16], [x + 22, 16], [x + 62, LH], [x - 62, LH]], `rgba(255,236,190,${.26 * a})`, `rgba(255,236,190,${.05 * a})`, 16, LH);
      glow(lg, x, FLOOR + 14, 58, 16, [1, .93, .75], .30 * a); glow(lg, x, 15, 34, 12, [1, .95, .82], .55 * a);
      for (let m = 0; m < 2; m++) { const ang = t * (3 + m) + i * 2 + m * 3; lg.fillStyle = `rgba(255,250,220,${.8 * a})`; lg.fillRect(Math.round(x + Math.cos(ang) * (10 + m * 6)), Math.round(24 + Math.sin(ang * 1.3) * 5), 1, 1); } });
    // geladeira e estufa sempre acesas, mais fortes no escuro
    if (cur === 'igor') { glow(lg, FRIDGE.x - OFF + ox + FRIDGE.w / 2, FRIDGE.y + 44, 40, 48, [.55, .9, 1], .10 + s.night * .30); glow(lg, ox + 73, 142, 44, 20, [1, .8, .5], .06 + s.night * .26); }
    else { const pulse = .5 + .5 * Math.sin(t * 6); glow(lg, ox + 242, 47, 60, 34, [1, .2, .15], (.10 + s.night * .16) * pulse); }
    c.globalCompositeOperation = 'lighter'; c.globalAlpha = b; c.imageSmoothingEnabled = false; c.drawImage(lightCv, 0, 0, 960, 540);
    c.restore();
  }

  // ---------------------------------------------------------------- fases ao ar livre
  // Céu da hora do dia por cima do céu original (chamado pelo art.js logo após o degradê).
  function sky(c, t, camera) {
    if (window.Graphics?.isLite?.() || !window.DayTime) return false;
    const s = window.DayTime.state(), pre = (v) => [Math.min(1, v[0] / s.amb[0]), Math.min(1, v[1] / s.amb[1]), Math.min(1, v[2] / s.amb[2])];
    const away = Math.min(1, (3 - s.amb[0] - s.amb[1] - s.amb[2]) * 2.2 + s.night);
    if (away > .02) { c.save(); c.globalAlpha = away; for (let i = 0; i < 44; i++) { const k = i / 43; R(c, 0, i * 10, 960, 10, css(pre(mix(s.top, s.bot, k * k * .5 + k * .5)))); } c.restore(); }
    if (s.night > .25) for (let i = 0; i < 110; i++) { const tw = .5 + .5 * Math.sin(t * (1 + hash(i) * 2) + i); c.fillStyle = `rgba(255,255,255,${(s.night - .25) * 1.3 * (.35 + .65 * tw) * (.4 + hash(i + 9) * .6)})`; c.fillRect(Math.round(((hash(i + 300) * 1100 - camera * .01) % 960 + 960) % 960 / 2) * 2, Math.round(hash(i + 400) * 150) * 2, 2, 2); }
    const disc = (x, y, r, col) => { c.fillStyle = col; for (let yy = -r; yy <= r; yy += 2) { const w = Math.round(Math.sqrt(r * r - yy * yy) / 2) * 2; c.fillRect(Math.round(x / 2) * 2 - w, Math.round((y + yy) / 2) * 2, w * 2, 2); } };
    if (s.sunT !== null) { const x = 80 + s.sunT * 800 - camera * .025, y = 300 - Math.sin(s.sunT * Math.PI) * 215; disc(x, y, 64, css(pre(s.sun), .12)); disc(x, y, 46, css(pre(s.sun), .22)); disc(x, y, 34, css(pre(mix(s.sun, [1, 1, 1], .5)))); }
    if (s.moonT !== null) { const x = 100 + s.moonT * 760 - camera * .025, y = 280 - Math.sin(s.moonT * Math.PI) * 190; disc(x, y, 40, 'rgba(200,215,255,.14)'); disc(x, y, 24, '#ffffff'); R(c, x - 10, y - 8, 6, 6, '#c9d4f0'); R(c, x + 4, y + 6, 8, 4, '#c9d4f0'); R(c, x + 8, y - 12, 4, 4, '#c9d4f0'); }
    return true;
  }
  // Luz ambiente da hora do dia sobre a fase inteira, depois dos personagens.
  function ambient(c, t, hx, hy) {
    if (window.Graphics?.isLite?.() || !window.DayTime) return;
    const s = window.DayTime.state(); if (s.amb[0] > .995 && s.amb[1] > .995 && s.amb[2] > .995) return;
    c.save(); c.globalCompositeOperation = 'multiply'; c.fillStyle = css(s.amb); c.fillRect(-40, -40, 1040, 620);
    if (s.night > .2) { const a = (s.night - .2) * 1.25; lg.clearRect(0, 0, LW, LH);
      glow(lg, hx / 2, hy / 2 - 22, 70, 52, [1, .86, .6], .30 * a); // lampião do herói: mantém a luta legível
      for (let i = 0; i < 16; i++) { const x = (hash(i + 700) * 520 + Math.sin(t * .4 + i) * 14) % 480, y = 150 + hash(i + 710) * 62 + Math.sin(t * .7 + i * 2) * 6, on = Math.max(0, Math.sin(t * 1.6 + i * 2.3)); lg.fillStyle = `rgba(210,255,140,${on * a * .9})`; lg.fillRect(Math.round(x), Math.round(y), 1, 1); lg.fillStyle = `rgba(210,255,140,${on * a * .25})`; lg.fillRect(Math.round(x) - 1, Math.round(y) - 1, 3, 3); }
      c.globalCompositeOperation = 'lighter'; c.imageSmoothingEnabled = false; c.drawImage(lightCv, 0, 0, 960, 540); }
    c.restore();
  }

  window.Art.drawArena = function (c, type, camera = 0, t = 0, homeX = 0) {
    if (!active(type)) return orig.apply(this, arguments);
    try { back(c, typeof type === 'object' ? type.type : type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0); } catch (e) { return orig.apply(this, arguments); }
  };
  window.HdScene = Object.freeze({ active, sky: (c, t, camera) => { try { return sky(c, Number(t) || 0, Number(camera) || 0); } catch (e) { return false; } }, drawAmbient: (c, t, hx, hy) => { try { ambient(c, Number(t) || 0, Number(hx) || 480, Number(hy) || 440); } catch (e) {} }, drawFront: (c, type, camera, t, homeX, blend) => { try { front(c, type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0, blend); } catch (e) {} }, scenes: Object.keys(HANDLED) });
})();
