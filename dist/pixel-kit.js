/* Kit de pixel art dos minigames (campanha 1 e fliperama).
   Tudo é feito com retângulos inteiros e imagens pequenas guardadas (o Roblox não tem createPattern):
   - texto(c, txt, x, y, tam, cor, alinhar, sombra): fonte Pixel com sombra dura de 1 "pixel";
   - contorno(c, txt, x, y, tam, cor, borda, alinhar): texto com borda de 1 px em volta (lê em qualquer fundo);
   - painel(c, x, y, w, h, tema): moldura com cantos em degrau, luz em cima e sombra embaixo;
   - barra(c, x, y, w, h, valor, o): barra em gomos, com faixa boa (zona) e marcador;
   - seta(c, x, y, dir, cor, esc): seta desenhada pixel a pixel, com contorno e brilho (guardada por cor);
   - faixas(c, x, y, w, h, cores): degradê em faixas com pontilhado entre elas (céu, água, néon);
   - peixe(c, tipo, x, y, esc, olhando): peixes de pixel (tilápia, traíra, piaba, cará, tucunaré);
   - estrela(c, x, y, r, cor) e brilho4(c, x, y, r, cor): brilhos de pixel; pessoa(...) para plateias. */
(() => {
  'use strict';
  if (window.PixelKit) return;
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };
  const cache = {};

  function texto(c, t, x, y, tam = 8, cor = '#ffffff', alinhar = 'center', sombra = '#0a0a14') {
    c.font = `${tam}px Pixel, monospace`; c.textAlign = alinhar; c.textBaseline = 'middle';
    const s = Math.max(1, Math.round(tam / 8)), X = Math.round(x), Y = Math.round(y);
    if (sombra) { c.fillStyle = sombra; c.fillText(t, X + s, Y + s); }
    c.fillStyle = cor; c.fillText(t, X, Y);
  }
  function contorno(c, t, x, y, tam = 8, cor = '#ffffff', borda = '#0a0a14', alinhar = 'center') {
    c.font = `${tam}px Pixel, monospace`; c.textAlign = alinhar; c.textBaseline = 'middle';
    const s = Math.max(1, Math.round(tam / 8)), X = Math.round(x), Y = Math.round(y);
    c.fillStyle = borda; for (const [dx, dy] of [[-s, 0], [s, 0], [0, -s], [0, s], [s, s]]) c.fillText(t, X + dx, Y + dy);
    c.fillStyle = cor; c.fillText(t, X, Y);
  }
  // moldura com cantos cortados em degrau (u = tamanho do "pixel": 1 nas telas de 480, 2 nas de 960)
  function painel(c, x, y, w, h, tema = {}) {
    const u = tema.u || 1, borda = tema.borda || '#e8d8a0', fundo = tema.fundo || '#1a2030', luz = tema.luz || 'rgba(255,255,255,.22)', escuro = tema.escuro || 'rgba(0,0,0,.35)';
    x = Math.round(x); y = Math.round(y); w = Math.round(w); h = Math.round(h);
    if (tema.sombra !== false) { R(c, x + 2 * u, y + h, w - 4 * u, 2 * u, 'rgba(0,0,0,.4)'); R(c, x + w, y + 2 * u, u, h - 3 * u, 'rgba(0,0,0,.3)'); }
    R(c, x + 2 * u, y, w - 4 * u, h, borda); R(c, x, y + 2 * u, w, h - 4 * u, borda); R(c, x + u, y + u, w - 2 * u, h - 2 * u, borda);
    R(c, x + 3 * u, y + 2 * u, w - 6 * u, h - 4 * u, fundo); R(c, x + 2 * u, y + 3 * u, w - 4 * u, h - 6 * u, fundo);
    R(c, x + 3 * u, y + 2 * u, w - 6 * u, u, luz); R(c, x + 3 * u, y + h - 3 * u, w - 6 * u, u, escuro);
    if (tema.rebite) for (const [px, py] of [[x + 3 * u, y + 3 * u], [x + w - 4 * u, y + 3 * u], [x + 3 * u, y + h - 4 * u], [x + w - 4 * u, y + h - 4 * u]]) R(c, px, py, u, u, tema.rebite);
  }
  // barra em gomos: o = { u, fundo, cheio, vazio, gomos, zona: [a, b], zonaCor, ruim: [a, b], ruimCor, marcador, borda }
  function barra(c, x, y, w, h, valor, o = {}) {
    const u = o.u || 1, n = o.gomos || Math.max(6, Math.round(w / (6 * u))), gw = (w - 2 * u) / n;
    R(c, x - u, y - u, w + 2 * u, h + 2 * u, o.borda || '#0a0a14'); R(c, x, y, w, h, o.fundo || '#2a2438');
    for (let i = 0; i < n; i++) {
      const a = i / n, b = (i + 1) / n, gx = x + u + i * gw;
      let cor = o.vazio || '#3a3450';
      if (o.ruim && b > o.ruim[0] && a < o.ruim[1]) cor = o.ruimCor || '#a84a4a';
      if (o.zona && b > o.zona[0] && a < o.zona[1]) cor = o.zonaCor || '#6ad86a';
      if (o.cheio && valor >= b) cor = o.cheio;
      R(c, gx, y + u, Math.max(u, gw - u), h - 2 * u, cor); R(c, gx, y + u, Math.max(u, gw - u), u, 'rgba(255,255,255,.25)');
    }
    if (o.marcador) { const mx = x + valor * w; R(c, mx - 2 * u, y - 3 * u, 4 * u, h + 6 * u, '#0a0a14'); R(c, mx - u, y - 2 * u, 2 * u, h + 4 * u, o.marcador); R(c, mx - u, y - 2 * u, u, h + 4 * u, '#ffffff'); }
  }
  // degradê em faixas com uma linha pontilhada entre elas
  function faixas(c, x, y, w, h, cores) {
    const n = cores.length, bh = h / n;
    for (let i = 0; i < n; i++) { const y0 = Math.round(y + i * bh), y1 = Math.round(y + (i + 1) * bh); R(c, x, y0, w, y1 - y0, cores[i]);
      if (i < n - 1) for (let k = 0; k < 2; k++) for (let xx = x + ((k + i) % 2); xx < x + w; xx += 2 + k * 2) R(c, xx, y1 - 1 - k, 1, 1, cores[i + 1]); }
  }
  // setas: desenho de cima, girado para as quatro direções (0 ←, 1 ↓, 2 ↑, 3 →)
  const SETA = ['....#....', '...###...', '..#####..', '.#######.', '#########', '..#####..', '..#####..', '..#####..', '..#####..'];
  function setaSprite(dir, cor, borda) {
    const k = dir + cor + borda; if (cache[k]) return cache[k];
    const N = 9, [cv, c] = mk(N + 2, N + 2), on = (x, y) => { let sx = x, sy = y; if (dir === 1) { sx = x; sy = N - 1 - y; } else if (dir === 0) { sx = y; sy = x; } else if (dir === 3) { sx = y; sy = N - 1 - x; } return SETA[sy]?.[sx] === '#'; };
    for (let y = 0; y < N; y++) for (let x = 0; x < N; x++) if (on(x, y)) for (const [dx, dy] of [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]) R(c, x + dx, y + dy, 1, 1, borda);
    for (let y = 0; y < N; y++) for (let x = 0; x < N; x++) if (on(x, y)) R(c, x + 1, y + 1, 1, 1, cor);
    for (let y = 0; y < N; y++) for (let x = 0; x < N; x++) if (on(x, y) && (!on(x - 1, y) || !on(x, y - 1))) R(c, x + 1, y + 1, 1, 1, 'rgba(255,255,255,.55)');
    return (cache[k] = cv);
  }
  function seta(c, x, y, dir, cor, esc = 2, borda = '#0a0610') { const s = setaSprite(dir, cor, borda), w = s.width * esc; c.drawImage(s, Math.round(x - w / 2), Math.round(y - w / 2), w, w); }
  // contorno da seta (o alvo na linha de acerto)
  function alvoSprite(dir, cor) {
    const k = 'alvo' + dir + cor; if (cache[k]) return cache[k];
    const base = setaSprite(dir, '#000000', '#000000'), [cv, c] = mk(base.width, base.height), N = base.width;
    const d = base.getContext('2d').getImageData(0, 0, N, N).data, cheio = (x, y) => x >= 0 && y >= 0 && x < N && y < N && d[(y * N + x) * 4 + 3] > 0;
    for (let y = 0; y < N; y++) for (let x = 0; x < N; x++) if (cheio(x, y) && (!cheio(x - 1, y) || !cheio(x + 1, y) || !cheio(x, y - 1) || !cheio(x, y + 1))) R(c, x, y, 1, 1, cor);
    return (cache[k] = cv);
  }
  function alvo(c, x, y, dir, cor, esc = 2) { const s = alvoSprite(dir, cor), w = s.width * esc; c.drawImage(s, Math.round(x - w / 2), Math.round(y - w / 2), w, w); }
  function estrela(c, x, y, r, cor) { R(c, x - r, y, r * 2 + 1, 1, cor); R(c, x, y - r, 1, r * 2 + 1, cor); if (r > 2) { R(c, x - 1, y - 1, 3, 3, cor); } R(c, x, y, 1, 1, '#ffffff'); }
  function brilho4(c, x, y, r, cor) { for (let i = 1; i <= r; i++) { const a = 1 - i / (r + 1); c.globalAlpha = a; R(c, x - i, y, 1, 1, cor); R(c, x + i, y, 1, 1, cor); R(c, x, y - i, 1, 1, cor); R(c, x, y + i, 1, 1, cor); } c.globalAlpha = 1; R(c, x, y, 1, 1, '#ffffff'); }
  // peixes de pixel (16 x 9), olhando para a esquerda; cores por espécie
  const PEIXE = ['......####......', '....##oooo#.....', '..##ooooooo#...#', '.#e#oollooooo.##', '#ooooollloooo###', '.#oooooooooo..##', '..##bbbbbbb#...#', '....##bbb##.....', '......###.......'];
  const ESPECIES = { 'TILÁPIA': ['#8a98a0', '#b8c4c8', '#5a6870', 'listra'], 'TRAÍRA': ['#5a6a3a', '#8a9a5a', '#3a4a24', 'pinta'], 'PIABA': ['#c8c8b0', '#f2f2e0', '#9a9a80', ''], 'CARÁ': ['#b8844a', '#e0b070', '#7a5428', 'faixa'], 'TUCUNARÉ': ['#c8b030', '#f2d84a', '#6a7a2a', 'olho'] };
  function peixeSprite(tipo) {
    const k = 'peixe' + tipo; if (cache[k]) return cache[k];
    const [o, l, e, marca] = ESPECIES[tipo] || ESPECIES['TILÁPIA'], [cv, c] = mk(16, 9);
    PEIXE.forEach((row, y) => { for (let x = 0; x < 16; x++) { const ch = row[x]; if (ch === '.') continue; R(c, x, y, 1, 1, ch === '#' ? e : ch === 'l' ? l : ch === 'b' ? '#e8e8dc' : ch === 'e' ? '#1c1c1c' : o); } });
    R(c, 2, 3, 1, 1, '#ffffff');
    if (marca === 'listra') for (const x of [6, 9, 12]) R(c, x, 2, 1, 4, e);
    if (marca === 'pinta') for (const [x, y] of [[6, 2], [9, 4], [11, 2], [7, 5]]) R(c, x, y, 1, 1, e);
    if (marca === 'faixa') for (const x of [5, 8, 11]) R(c, x, 1, 2, 6, e);
    if (marca === 'olho') { R(c, 12, 3, 2, 2, '#1c1c1c'); R(c, 12, 3, 1, 1, '#e8843a'); for (const x of [5, 8]) R(c, x, 2, 1, 4, '#3a4a1a'); }
    return (cache[k] = cv);
  }
  function peixe(c, tipo, x, y, esc = 1, olhandoDireita = false) {
    const s = peixeSprite(tipo); c.save(); c.translate(Math.round(x), Math.round(y)); if (olhandoDireita) c.scale(-1, 1); c.drawImage(s, Math.round(-8 * esc), Math.round(-4.5 * esc), 16 * esc, 9 * esc); c.restore();
  }
  // pessoa da plateia (6 x 12): cabeça, corpo e braços (para cima quando "pula")
  function pessoa(c, x, y, pele, roupa, cabelo, pula, braco) {
    const dy = pula ? -1 : 0; R(c, x + 1, y + dy, 4, 4, pele); R(c, x + 1, y + dy, 4, 1, cabelo); R(c, x, y + 4 + dy, 6, 8, roupa);
    if (braco) { R(c, x - 1, y - 2 + dy, 1, 6, pele); R(c, x + 6, y - 2 + dy, 1, 6, pele); }
  }
  window.PixelKit = Object.freeze({ R, hash, mk, texto, contorno, painel, barra, faixas, seta, alvo, estrela, brilho4, peixe, pessoa, ESPECIES: Object.keys(ESPECIES) });
})();
