/* Campanha 2 · Cenários (Passo 2, versão detalhada).
   Dez cenários de Vitória da Conquista (BA), cenas 12 a 21, no mesmo estilo dos mapas HD da campanha
   principal (HdMaps.kit): pixels de arte de 482x270 escalados 2x, chão em y=220 (440 na tela),
   fundo em várias camadas com parallax, céu com hora do dia, sombras do sol, luzes à noite e shader.
   Referências: fotos reais (Wikimedia Commons) do Cristo de Mário Cravo na Serra do Periperi, da
   Catedral Nossa Senhora das Vitórias, do Aeroporto Glauber Rocha, da Avenida Olívia Flores, do
   Centro de Cultura, do comércio do centro e da vista da cidade (planalto coberto de prédios claros).
   Piada recorrente: Conquista é fria e tem neblina.
   Objetos interativos (caixotes, vasos, lixeiras, poças, portas, alavancas...) usam o mesmo sistema
   da campanha principal (Interact.addScene). Nada aqui muda as fases 0 a 11. */
(() => {
  'use strict';
  if (window.CampanhaCenarios || !window.HdMaps?.register || !window.HdMaps.kit) return;
  const K = window.HdMaps.kit;
  const { LW, LH, FLOOR, R, ell, mk, hash, cl, mix, dither, limb, sky, haze, tile, tree, slant, sunInfo, sunWall, board, bench, lampPost, lampGlow, shadeAdd, lightAdd } = K;
  const GY = 210; // pé das fachadas (calçada de 204 a 220)
  const vis = (x, m = 80) => x > -m && x < LW + m;
  const night = (s) => cl((s.night - .12) * 1.4);
  const text = (c, str, x, y, size, col, align = 'center') => { c.font = `${size}px Pixel, monospace`; c.textAlign = align; c.textBaseline = 'middle'; c.fillStyle = col; c.fillText(str, x, y); };
  function shadeHex(hex, k) { if (!/^#[0-9a-f]{6}$/i.test(hex)) return hex; const n = parseInt(hex.slice(1), 16), f = (v) => Math.max(0, Math.min(255, Math.round(v * k))); return '#' + [(n >> 16) & 255, (n >> 8) & 255, n & 255].map((v) => f(v).toString(16).padStart(2, '0')).join(''); }
  const pick = (arr, seed) => arr[Math.floor(hash(seed) * arr.length) % arr.length];

  /* =====================================================================
     TEXTURAS
     ===================================================================== */
  function plaster(c, x, y, w, h, col, seed = 0) { // reboco com manchas e umidade perto do chão
    R(c, x, y, w, h, col); const lt = shadeHex(col, 1.05), dk = shadeHex(col, .93);
    for (let i = 0; i < w * h / 16; i++) R(c, x + hash(i * 3.1 + seed) * w, y + hash(i * 7.7 + seed + 1) * h, 1, 1, i % 2 ? lt : dk);
    for (let k = 0; k < w; k++) if (hash(k * 1.7 + seed) > .55) R(c, x + k, y + h - 2 - Math.round(hash(k + seed) * 5), 1, 3, shadeHex(col, .87));
  }
  function brick(c, x, y, w, h, col = '#b0624a', seed = 0) {
    R(c, x, y, w, h, shadeHex(col, .7));
    for (let yy = 0; yy < h; yy += 4) { const off = (yy / 4) % 2 ? 0 : 4; for (let xx = -off; xx < w; xx += 8) { const bx = Math.max(x, x + xx), bw = Math.min(x + xx + 7, x + w) - bx; if (bw > 0) R(c, bx, y + yy, bw, Math.min(3, h - yy), hash(xx * 1.3 + yy * 7 + seed) > .5 ? col : shadeHex(col, .9)); } }
  }
  function azulejo(c, x, y, w, h, a, b) { R(c, x, y, w, h, a); for (let yy = 0; yy < h; yy += 4) for (let xx = (yy / 4) % 2 * 2; xx < w; xx += 4) R(c, x + xx, y + yy, 2, 2, b); }
  function roofTiles(c, x, y, w, h, col = '#a8543c') { R(c, x, y, w, h, shadeHex(col, .8)); for (let yy = 0; yy < h; yy += 3) for (let xx = (yy / 3) % 2 * 2; xx < w; xx += 4) { R(c, x + xx, y + yy, 3, 2, col); R(c, x + xx, y + yy, 3, 1, shadeHex(col, 1.15)); } }

  /* =====================================================================
     JANELAS, FACHADAS E CASAS
     ===================================================================== */
  const CURT = ['#e8d8a8', '#c9d8e8', '#e8c4c4', '#d4e8c8', '#f2efe6', '#c8b8d8'];
  function janela(c, x, y, w, h, kind, seed) {
    R(c, x - 1, y - 1, w + 2, h + 2, '#3a3a36'); R(c, x, y, w, h, '#5f8496'); R(c, x + 1, y + 1, w - 2, Math.max(1, Math.round(h * .35)), '#8fb4c2');
    if (hash(seed) > .45) { const cc = pick(CURT, seed + 1); R(c, x, y, Math.round(w * .35), h, cc); R(c, x + w - Math.round(w * .3), y, Math.round(w * .3), h, cc); }
    if (kind === 'grade') for (let k = 2; k < w; k += 3) R(c, x + k, y, 1, h, '#2a2a28');
    if (kind === 'veneziana') { const col = pick(['#5a7a4a', '#8a5a3a', '#3c6a8a', '#7a3a3a'], seed + 2); R(c, x - 3, y - 1, 3, h + 2, col); R(c, x + w, y - 1, 3, h + 2, col); for (let k = 0; k < h; k += 2) { R(c, x - 3, y + k, 3, 1, shadeHex(col, .75)); R(c, x + w, y + k, 3, 1, shadeHex(col, .75)); } }
    if (kind === 'vidro') { R(c, x + Math.round(w / 2), y, 1, h, '#2c3a44'); R(c, x + 2, y + 2, 2, h - 4, '#c4e0e8'); }
    R(c, x - 2, y + h + 1, w + 4, 2, '#d8d2c0');
    if (hash(seed + 3) > .7) { R(c, x + 1, y + h - 3, w - 2, 4, '#7a4a2a'); for (let k = 0; k < w - 2; k += 3) R(c, x + 1 + k, y + h - 6 - Math.round(hash(k + seed) * 3), 2, 4, hash(k + seed + 9) > .5 ? '#4f8a3a' : '#e86a7a'); }
  }
  function ac(c, x, y) { R(c, x, y, 10, 7, '#d8dcdc'); R(c, x, y, 10, 1, '#f2f4f4'); for (let k = 1; k < 6; k += 2) R(c, x + 1, y + k, 6, 1, '#9aa0a2'); R(c, x + 8, y + 2, 1, 3, '#7a8082'); R(c, x + 3, y + 7, 1, 4, '#5a5e60'); }
  function caixaDagua(c, x, y, kind = 0) { if (kind) { R(c, x, y, 14, 10, '#3c6aa8'); R(c, x, y, 14, 2, '#6a9ad0'); R(c, x + 2, y - 2, 10, 2, '#2c5a98'); } else { ell(c, x + 7, y + 5, 7, 5, '#5a8ab8'); R(c, x, y + 4, 14, 6, '#3c6aa8'); R(c, x + 1, y + 2, 12, 2, '#7aaad8'); } R(c, x + 2, y + 10, 2, 4, '#6a6a66'); R(c, x + 10, y + 10, 2, 4, '#6a6a66'); }
  function antena(c, x, y) { R(c, x, y - 14, 1, 14, '#5a5a56'); for (let k = 0; k < 4; k++) R(c, x - 4 + k, y - 13 + k * 3, 9 - k * 2, 1, '#5a5a56'); }
  function parabolica(c, x, y) { ell(c, x + 4, y + 4, 5, 5, '#e8e8e4'); ell(c, x + 4, y + 4, 3, 3, '#c8c8c4'); R(c, x + 4, y + 4, 4, 1, '#5a5a56'); R(c, x + 3, y + 8, 2, 4, '#5a5a56'); }
  function varal(c, x0, x1, y, seed) { for (let x = x0; x <= x1; x += 2) R(c, x, y + Math.round(Math.sin((x - x0) / (x1 - x0) * Math.PI) * 2), 2, 1, '#4a4a46'); for (let x = x0 + 3; x < x1 - 4; x += 7) { const col = pick(['#d9634a', '#3c6aa8', '#f2efe6', '#e8c24c', '#7cbf6a', '#c86ab8', '#5ab8c8'], x + seed), yy = y + Math.round(Math.sin((x - x0) / (x1 - x0) * Math.PI) * 2) + 1; if (hash(x + seed) > .5) { R(c, x, yy, 6, 7, col); R(c, x, yy, 6, 1, shadeHex(col, .8)); } else { R(c, x + 1, yy, 4, 9, col); R(c, x + 1, yy + 4, 4, 1, shadeHex(col, .8)); } } }
  function gato(c, x, y, col = '#2a2a2a') { R(c, x, y - 5, 8, 4, col); R(c, x + 6, y - 8, 4, 4, col); R(c, x + 6, y - 9, 1, 1, col); R(c, x + 9, y - 9, 1, 1, col); R(c, x + 8, y - 7, 1, 1, '#e8d84a'); R(c, x - 3, y - 7, 4, 1, col); R(c, x - 3, y - 9, 1, 2, col); R(c, x + 1, y - 1, 1, 1, col); R(c, x + 5, y - 1, 1, 1, col); }
  function cachorro(c, x, y, col = '#c98a43') { R(c, x, y - 7, 14, 5, col); R(c, x + 12, y - 11, 6, 6, col); R(c, x + 16, y - 8, 3, 3, shadeHex(col, 1.2)); R(c, x + 14, y - 9, 1, 1, '#2a2a2a'); R(c, x + 12, y - 12, 2, 3, shadeHex(col, .7)); R(c, x - 3, y - 9, 4, 2, col); R(c, x + 1, y - 2, 2, 2, col); R(c, x + 10, y - 2, 2, 2, col); R(c, x + 12, y - 6, 2, 2, '#c43c3a'); }
  function plantaVaso(c, x, y, seed) { R(c, x, y - 7, 9, 7, '#a85a3a'); R(c, x, y - 7, 9, 1, '#c8744a'); for (let k = 0; k < 4; k++) ell(c, x + 2 + k * 2, y - 10 - (k % 2) * 3, 3, 3, k % 2 ? '#4f8a3a' : '#5f9a46'); if (hash(seed) > .5) R(c, x + 3, y - 14, 3, 2, pick(['#e86a7a', '#e8c24c', '#f2efe6', '#c86ab8'], seed)); }
  function grafite(c, x, y, w, h, seed) { const cols = ['#e8433a', '#f2c94c', '#3c9ad8', '#7ac85a', '#c86ab8', '#f08a24']; for (let i = 0; i < w * h / 30; i++) { const px = x + hash(i + seed) * w, py = y + hash(i * 3 + seed) * h; ell(c, px, py, 2 + hash(i * 5 + seed) * 4, 2 + hash(i * 7 + seed) * 3, pick(cols, i + seed)); } for (let k = 0; k < w; k += 2) R(c, x + k, y + h / 2 + Math.round(Math.sin(k * .3 + seed) * h * .3), 2, 2, '#1a1a1a'); }
  function cartaz(c, x, y, seed) { const bg = pick(['#f2e8c8', '#e8c24c', '#f2efe6', '#e86a7a', '#7ac8e8'], seed); R(c, x, y, 12, 15, bg); R(c, x, y, 12, 1, shadeHex(bg, .8)); R(c, x + 2, y + 2, 8, 2, '#2a2a2a'); R(c, x + 2, y + 6, 8, 5, pick(['#c43c3a', '#3c6aa8', '#3c8a5a'], seed + 1)); R(c, x + 2, y + 12, 6, 1, '#2a2a2a'); }
  function bandeirinhas(c, x0, x1, y, seed = 0) { const cols = ['#e8433a', '#f2c94c', '#3c9ad8', '#7ac85a', '#c86ab8', '#f08a24', '#f2efe6']; for (let x = x0; x <= x1; x += 2) R(c, x, y + Math.round(Math.sin((x - x0) / (x1 - x0) * Math.PI) * 6), 2, 1, '#3a3a36'); for (let x = x0 + 2, i = 0; x < x1 - 4; x += 8, i++) { const yy = y + 1 + Math.round(Math.sin((x - x0) / (x1 - x0) * Math.PI) * 6), col = pick(cols, i + seed); for (let k = 0; k < 5; k++) R(c, x + k, yy + k, 6 - k * 2 > 0 ? 6 - k * 2 : 1, 1, col); R(c, x, yy, 6, 1, col); } }

  // prédio de vários andares em pé na calçada; devolve o topo
  function predio(c, x, w, floors, col, seed, o = {}) {
    const fh = 26, top = GY - floors * fh - (o.loja ? 4 : 0);
    plaster(c, x, top, w, GY - top, col, seed); R(c, x, top, w, 2, shadeHex(col, 1.12)); R(c, x + w - 3, top, 3, GY - top, shadeHex(col, .85));
    for (let f = o.loja ? 1 : 0; f < floors; f++) { const yy = GY - (f + 1) * fh + 5; R(c, x, yy + fh - 6, w, 1, shadeHex(col, .88));
      const kind = pick(['grade', 'veneziana', 'vidro', 'grade'], seed + f), n = Math.max(1, Math.floor((w - 6) / 18));
      for (let k = 0; k < n; k++) { const wx = x + 5 + k * ((w - 10) / n); janela(c, wx, yy, 11, 13, kind, seed * 7 + f * 13 + k); if (hash(seed + f * 3 + k) > .78) ac(c, wx + 12, yy + 4); }
      if (f > 0 && hash(seed + f * 11) > .55) { const bw = Math.min(w - 8, 40), bx = x + 4 + Math.round(hash(seed + f) * (w - 8 - bw)); R(c, bx, yy + 14, bw, 2, '#d8d2c0'); for (let k = 0; k < bw; k += 3) R(c, bx + k, yy + 9, 1, 5, '#3a3a36'); R(c, bx, yy + 9, bw, 1, '#3a3a36'); if (hash(seed + f * 5) > .5) varal(c, bx + 2, bx + bw - 2, yy + 2, seed + f); else plantaVaso(c, bx + 3, yy + 14, seed + f); } }
    // telhado: laje com caixa-d'água, antena e parabólica (ou telhado de telha)
    if (o.telhado) { roofTiles(c, x - 3, top - 7, w + 6, 7, o.telhado); }
    else { R(c, x - 1, top - 3, w + 2, 3, shadeHex(col, .8)); if (hash(seed + 31) > .3) caixaDagua(c, x + 4 + Math.round(hash(seed + 32) * (w - 20)), top - 17, hash(seed + 33) > .5 ? 1 : 0); if (hash(seed + 34) > .4) antena(c, x + w - 6, top - 3); if (hash(seed + 35) > .6) parabolica(c, x + 6, top - 15); }
    return top;
  }
  // loja no térreo: letreiro, toldo listrado, porta de aço meio aberta e vitrine
  function loja(c, x, w, signCol, a, b, seed) {
    R(c, x, GY - 30, w, 30, '#e8e2d2'); R(c, x + 2, GY - 30, w - 4, 9, signCol); R(c, x + 2, GY - 30, w - 4, 1, shadeHex(signCol, 1.3)); R(c, x + 2, GY - 22, w - 4, 1, shadeHex(signCol, .6));
    for (let k = 0; k < w; k += 6) { R(c, x + k, GY - 21, 6, 5, (k / 6) % 2 ? a : b); R(c, x + k, GY - 16, 6, 1, '#00000033'); }
    const dw = Math.round(w * .45); R(c, x + 3, GY - 15, dw, 15, '#7a8086'); for (let k = 0; k < 8; k += 2) R(c, x + 3, GY - 15 + k, dw, 1, '#5a6066'); R(c, x + 3, GY - 7, dw, 7, '#2a2c30');
    R(c, x + dw + 5, GY - 15, w - dw - 8, 15, '#3c4c58'); R(c, x + dw + 6, GY - 14, w - dw - 10, 13, '#8fb4c2'); for (let k = 0; k < 4; k++) R(c, x + dw + 8 + k * ((w - dw - 14) / 4), GY - 7, 4, 7, pick(['#d9634a', '#e8c24c', '#5f9fd0', '#7cbf6a', '#c86ab8'], seed + k));
  }
  function casa(c, x, w, col, seed, o = {}) { // casa térrea com muro, portão e telhado de telha
    const h = o.h || 34, top = GY - h;
    if (hash(seed + 7) > .5) brick(c, x, top, w, h, '#b0624a', seed); else plaster(c, x, top, w, h, col, seed);
    roofTiles(c, x - 4, top - 8, w + 8, 8, o.telhado || pick(['#a8543c', '#9a4a34', '#b8644a'], seed));
    janela(c, x + 8, top + 8, 14, 13, hash(seed) > .4 ? 'grade' : 'veneziana', seed); if (w > 60) janela(c, x + w - 28, top + 8, 14, 13, 'grade', seed + 5);
    R(c, x + Math.round(w / 2) - 6, top + 10, 12, h - 10, '#6a4a32'); R(c, x + Math.round(w / 2) - 5, top + 11, 10, h - 12, '#8a6440'); R(c, x + Math.round(w / 2) + 2, top + 24, 2, 2, '#e8c24c');
    if (hash(seed + 21) > .5) caixaDagua(c, x + w - 20, top - 22, hash(seed + 22) > .5 ? 1 : 0); if (hash(seed + 23) > .6) antena(c, x + 6, top - 8);
    // muro baixo com grade e portão
    const mc = pick(['#e8e2d2', '#d8e2d8', '#f0e0c8', '#e0d8e8'], seed + 3); plaster(c, x - 6, GY - 10, w + 12, 10, mc, seed + 4); R(c, x - 6, GY - 11, w + 12, 2, shadeHex(mc, 1.08));
    for (let k = 0; k < w + 12; k += 3) R(c, x - 6 + k, GY - 18, 1, 7, '#2e2e2c'); R(c, x - 6, GY - 18, w + 12, 1, '#2e2e2c');
    if (hash(seed + 11) > .6) gato(c, x + Math.round(hash(seed + 12) * w), GY - 11, pick(['#2a2a2a', '#d8a24a', '#f2efe6', '#7a7a7a'], seed));
    if (hash(seed + 13) > .5) plantaVaso(c, x - 4, GY, seed); if (hash(seed + 14) > .55) varal(c, x - 4, x + w + 4, top - 2, seed);
    R(c, x + 2, top + 2, 6, 4, '#3c6aa8'); R(c, x + 3, top + 3, 4, 2, '#f2efe6');
  }

  /* =====================================================================
     PEÇAS DE RUA
     ===================================================================== */
  function orelhao(c, x) { R(c, x + 4, GY - 26, 2, 26, '#5a5a56'); ell(c, x + 5, GY - 30, 9, 8, '#2c6ab8'); ell(c, x + 5, GY - 29, 7, 6, '#4a8ad8'); R(c, x + 2, GY - 28, 6, 8, '#e8e8e4'); R(c, x + 3, GY - 26, 4, 2, '#2a2a2a'); R(c, x + 6, GY - 22, 1, 4, '#2a2a2a'); }
  function banca(c, x) { R(c, x, GY - 34, 44, 34, '#2c5a8a'); R(c, x - 2, GY - 38, 48, 5, '#1d4070'); R(c, x + 2, GY - 30, 40, 24, '#e8e2d2'); for (let k = 0; k < 12; k++) R(c, x + 3 + (k % 6) * 6.5, GY - 29 + Math.floor(k / 6) * 11, 5, 9, pick(['#d9634a', '#e8c24c', '#3c8ad8', '#7cbf6a', '#c86ab8', '#f2efe6'], k + x)); R(c, x + 4, GY - 6, 36, 6, '#1d4070'); }
  function ponto(c, x) { R(c, x, GY - 34, 2, 34, '#5a6066'); R(c, x + 38, GY - 34, 2, 34, '#5a6066'); R(c, x - 2, GY - 37, 44, 4, '#3c4a5a'); R(c, x + 2, GY - 33, 36, 18, 'rgba(160,200,220,.35)'); R(c, x + 4, GY - 31, 14, 14, '#e8c24c'); R(c, x + 6, GY - 29, 10, 4, '#c43c3a'); R(c, x + 4, GY - 12, 32, 3, '#8a6a45'); R(c, x + 44, GY - 30, 2, 30, '#5a6066'); R(c, x + 41, GY - 36, 8, 8, '#2c6ab8'); R(c, x + 43, GY - 34, 4, 4, '#f2efe6'); }
  function lixeira(c, x, col = '#f08a24') { R(c, x, GY - 13, 9, 11, col); R(c, x, GY - 13, 9, 2, shadeHex(col, 1.2)); R(c, x + 3, GY - 2, 3, 2, '#5a5a56'); R(c, x + 2, GY - 9, 5, 1, shadeHex(col, .7)); }
  function hidrante(c, x) { R(c, x, GY - 9, 6, 9, '#c43c3a'); R(c, x - 1, GY - 10, 8, 2, '#d85a4a'); R(c, x - 2, GY - 6, 10, 2, '#a82c2a'); }
  function placaRua(c, x) { R(c, x, GY - 40, 2, 40, '#6a6a66'); R(c, x - 14, GY - 46, 30, 8, '#1d4a8a'); R(c, x - 13, GY - 45, 28, 6, '#2c5aa8'); R(c, x - 11, GY - 43, 24, 1, '#f2efe6'); R(c, x - 11, GY - 41, 18, 1, '#f2efe6'); }
  function moto(c, x, col = '#c43c3a') { ell(c, x + 3, GY - 3, 3, 3, '#1c1c1c'); ell(c, x + 17, GY - 3, 3, 3, '#1c1c1c'); R(c, x + 4, GY - 9, 13, 4, col); R(c, x + 6, GY - 12, 8, 3, '#2a2a2a'); R(c, x + 15, GY - 14, 2, 6, '#5a5a56'); R(c, x + 14, GY - 15, 5, 1, '#5a5a56'); R(c, x + 16, GY - 8, 3, 2, '#fff2b0'); }
  function bike(c, x, col = '#3c8ad8') { ell(c, x + 3, GY - 4, 4, 4, '#2a2a2a'); ell(c, x + 3, GY - 4, 2, 2, '#c8c8c4'); ell(c, x + 17, GY - 4, 4, 4, '#2a2a2a'); ell(c, x + 17, GY - 4, 2, 2, '#c8c8c4'); limb(c, [[x + 3, GY - 4], [x + 9, GY - 10], [x + 17, GY - 4]], 1, col); limb(c, [[x + 9, GY - 10], [x + 15, GY - 10], [x + 17, GY - 4]], 1, col); R(c, x + 7, GY - 12, 4, 1, '#2a2a2a'); R(c, x + 15, GY - 13, 1, 3, '#5a5a56'); }
  function carro(c, x, y, col, dir = 1) { const w = 30; R(c, x, y - 8, w, 7, col); R(c, x + (dir > 0 ? 7 : 4), y - 13, 18, 6, col); R(c, x + (dir > 0 ? 9 : 6), y - 12, 14, 4, '#9fc4d0'); R(c, x + (dir > 0 ? 16 : 13), y - 12, 1, 4, col); ell(c, x + 6, y - 1, 3, 3, '#1c1c1c'); ell(c, x + w - 6, y - 1, 3, 3, '#1c1c1c'); R(c, dir > 0 ? x + w - 2 : x, y - 7, 2, 2, '#fff2b0'); R(c, dir > 0 ? x : x + w - 2, y - 7, 2, 2, '#d8443a'); R(c, x, y - 8, w, 1, 'rgba(255,255,255,.35)'); R(c, x + 2, y - 4, w - 4, 1, shadeHex(col, .7)); }
  function poste(c, x) { R(c, x, 52, 3, GY - 52, '#7a756a'); R(c, x, 52, 1, GY - 52, '#9a958a'); R(c, x - 12, 56, 27, 2, '#5a554a'); R(c, x - 8, 70, 10, 12, '#6a6a66'); R(c, x - 7, 71, 8, 2, '#8a8a86'); R(c, x + 3, 88, 10, 2, '#5a554a'); R(c, x + 11, 86, 6, 4, '#f2f0d8'); }
  function fios(c, x0, x1, y0) { for (let x = x0; x < x1; x += 2) for (const [dy, sag] of [[0, 9], [5, 12], [9, 7]]) R(c, x, y0 + dy + Math.round(Math.sin((x - x0) / (x1 - x0) * Math.PI) * sag), 2, 1, '#26262a'); }
  function canteiro(c, x, w) { R(c, x, GY - 6, w, 6, '#9a948a'); R(c, x + 1, GY - 7, w - 2, 2, '#6a4a32'); for (let k = 2; k < w - 2; k += 3) { R(c, x + k, GY - 10 - Math.round(hash(k + x) * 3), 2, 4, '#4f8a3a'); if (hash(k * 3 + x) > .6) R(c, x + k, GY - 12, 2, 2, pick(['#e86a7a', '#e8c24c', '#f2efe6', '#c86ab8'], k + x)); } }
  function ipe(c, x, base, col, seed, s = 1) { R(c, x - 2, base - 30 * s, 4, 30 * s, '#5a4232'); limb(c, [[x, base - 22 * s], [x - 10 * s, base - 34 * s]], 2, '#5a4232'); limb(c, [[x, base - 24 * s], [x + 11 * s, base - 36 * s]], 2, '#5a4232');
    for (let i = 0; i < 26; i++) { const a = hash(i + seed) * 6.28, r = hash(i * 3 + seed) * 16 * s; ell(c, x + Math.cos(a) * r * 1.2, base - 40 * s + Math.sin(a) * r * .7, 4 * s, 3.5 * s, i % 3 ? col : shadeHex(col, .8)); } for (let i = 0; i < 10; i++) R(c, x - 14 * s + hash(i + seed * 2) * 28 * s, base - 1 - hash(i * 5 + seed) * 2, 2, 1, col); }
  function mesaBar(c, x) { R(c, x, GY - 9, 14, 2, '#e8e2d2'); R(c, x + 6, GY - 7, 2, 7, '#8a8a86'); R(c, x - 4, GY - 7, 3, 7, '#c43c3a'); R(c, x + 15, GY - 7, 3, 7, '#c43c3a'); ell(c, x + 7, GY - 22, 12, 4, '#e8c24c'); R(c, x + 6, GY - 22, 2, 13, '#8a8a86'); }

  /* =====================================================================
     CHÃO
     ===================================================================== */
  function calcada(c, W, col = '#cfc8b6') { // calçada de placas com rachaduras e matinho + meio-fio pintado
    R(c, 0, 204, W, 16, col); for (let x = 0; x < W; x += 14) { R(c, x, 204, 1, 16, shadeHex(col, .86)); if (hash(x) > .7) { limb(c, [[x + 3, 206], [x + 6, 211], [x + 5, 216]], 1, shadeHex(col, .8)); R(c, x + 6, 217, 2, 2, '#5f8a46'); } } R(c, 0, 204, W, 1, shadeHex(col, 1.1));
    for (let x = 0; x < W; x += 24) R(c, x, 218, 12, 2, (x / 24) % 2 ? '#e8c24c' : '#2a2a2a'); R(c, 0, 220, W, 1, '#8a8478');
  }
  function asfalto(c, W, faixas = []) {
    R(c, 0, 221, W, LH - 221, '#5b5f62'); for (let i = 0; i < W * 6; i++) R(c, hash(i * 1.3) * W, 222 + hash(i * 2.7) * 48, 1, 1, i % 2 ? '#6c7073' : '#4c5053');
    for (let x = 0; x < W; x += 40) R(c, x, 246, 20, 2, '#e8dc8a'); R(c, 0, 266, W, 1, '#e8e4dc');
    for (let x = 60; x < W; x += 310) { ell(c, x, 238, 6, 2, '#3c4042'); R(c, x - 4, 237, 8, 1, '#7a7e80'); }
    for (const fx of faixas) for (let k = 0; k < 6; k++) R(c, fx + k * 8, 223, 5, 44, '#e8e8e2');
  }
  function pedraPortuguesa(c, W, y = 204) { // calçadão de pedra portuguesa: ondas finas e discretas
    R(c, 0, y, W, LH - y, '#e4dfd2'); for (let i = 0; i < W * 4; i++) R(c, hash(i * 1.9) * W, y + hash(i * 3.3) * (LH - y), 1, 1, i % 2 ? '#d2cdc0' : '#ece8de');
    for (let x = 0; x < W; x += 1) { const yy = y + 14 + Math.round(Math.sin(x * .07) * 3); R(c, x, yy, 1, 1, '#7a766c'); R(c, x, yy + 22, 1, 1, '#8a867c'); } R(c, 0, y, W, 1, '#f2eee4'); }
  function pisoInterno(c, W, a = '#dedad0', b = '#c8c4b8', step = 20) { R(c, 0, 210, W, 10, shadeHex(a, .92)); R(c, 0, 210, W, 2, '#f4f2ea'); R(c, 0, 218, W, 2, shadeHex(b, .85)); R(c, 0, 220, W, LH - 220, a); for (let x = 0; x < W; x += step) R(c, x, 220, 1, LH - 220, b); for (let y = 232; y < LH; y += 14) R(c, 0, y, W, 1, b); for (let x = 0; x < W; x += step * 2) R(c, x + 2, 222, step - 4, 6, 'rgba(255,255,255,.18)'); }
  function terra(c, W, a = '#6f8a46', b = '#557038') { R(c, 0, 220, W, LH - 220, '#7a5a3a'); R(c, 0, 220, W, 5, a); dither(c, 0, 225, W, b); for (let x = 0; x < W; x += 3) R(c, x, 217 - Math.round(hash(x) * 4), 1, 4, x % 2 ? a : '#8ab05a'); for (let i = 0; i < W / 5; i++) { R(c, hash(i + 7) * W, 232 + hash(i + 8) * 34, 3, 2, '#8a6a46'); R(c, hash(i + 17) * W, 230 + hash(i + 18) * 36, 2, 1, '#5a4228'); } for (let i = 0; i < W / 12; i++) R(c, hash(i * 5) * W, 215 - hash(i) * 2, 2, 2, pick(['#e8c24c', '#f2efe6', '#c86ab8'], i)); }

  /* =====================================================================
     FUNDO EM CAMADAS (serra, cidade longe, cidade perto, faixa de árvores)
     ===================================================================== */
  let FAR = null;
  function buildFar() {
    const T = 964, [ridge, cr] = mk(T, LH), [city, cc] = mk(T, LH), [near, cn] = mk(T, LH), [trees, ct] = mk(T, LH), [nCity, nc] = mk(T, LH), [nNear, nn] = mk(T, LH), [nRidge, nr] = mk(T, LH);
    // serra comprida azulada no horizonte, com antenas e o Cristo bem pequeno no alto
    for (let x = 0; x < T; x++) { const h = 10 + Math.sin(x * .009) * 5 + Math.sin(x * .031) * 3 + (x > 520 && x < 900 ? Math.sin((x - 520) / 380 * Math.PI) * 22 : 0); for (let y = 0; y < h; y++) R(cr, x, 150 - h + y, 1, 1, y < 2 ? '#c4d0d4' : mix([.62, .7, .74], [.55, .64, .66], y / 30).map((v) => Math.round(v * 255)).reduce((s, v) => s + v.toString(16).padStart(2, '0'), '#')); }
    R(cr, 0, 150, T, 120, '#9aaea6');
    for (const ax of [590, 640, 820]) { R(cr, ax, 110, 1, 22, '#7d8a88'); for (let k = 0; k < 22; k += 4) R(cr, ax - 1, 110 + k, 3, 1, '#8d9a98'); R(nr, ax, 109, 1, 1, '#ff5a4a'); }
    R(cr, 708, 112, 1, 14, '#6f7f7a'); R(cr, 704, 115, 9, 1, '#6f7f7a'); ell(cr, 708, 127, 3, 1, '#6f7f7a');
    // cidade longe: prédios claros com caixa-d'água, antena, faixas coloridas e dois guindastes
    const pal = ['#ebe8de', '#e0d6c2', '#f3f0e8', '#d4cab6', '#e6ded0', '#dfe6ea', '#e8dcc8'];
    for (let i = 0; i < 150; i++) {
      const x = Math.round(hash(i + 900) * T), w = 6 + Math.round(hash(i + 901) * 10), h = 8 + Math.round(Math.pow(hash(i + 902), 1.8) * 44), y = 160 - h, col = pal[i % pal.length];
      R(cc, x, y, w, h + 4, col); R(cc, x + w - 2, y, 2, h + 4, shadeHex(col, .82)); R(cc, x, y, w, 1, shadeHex(col, 1.06));
      for (let yy = y + 3; yy < 158; yy += 3) for (let xx = x + 1; xx < x + w - 2; xx += 2) { R(cc, xx, yy, 1, 1, '#93a8b2'); if (hash(xx * 7 + yy) > .64) R(nc, xx, yy, 1, 1, pick(['#ffd98a', '#ffe6b0', '#fff2d0'], xx + yy)); }
      if (hash(i + 903) > .4) { R(cc, x + 1, y - 3, 4, 3, '#4a7ab0'); } if (hash(i + 904) > .6) R(cc, x + w - 3, y - 6, 1, 6, '#7a7a76'); if (hash(i + 905) > .75) R(cc, x, y + Math.round(h * .3), w, 1, pick(['#3c8ad8', '#c4743a', '#3c9a6a'], i));
    }
    for (const gx of [210, 760]) { R(cc, gx, 92, 2, 68, '#e8a83a'); R(cc, gx - 20, 92, 48, 2, '#e8a83a'); R(cc, gx + 22, 94, 1, 18, '#5a5a56'); for (let k = 92; k < 160; k += 4) R(cc, gx - 1, k, 4, 1, '#c8882a'); }
    for (let i = 0; i < 200; i++) { const x = Math.round(hash(i + 300) * T), y = 156 + Math.round(hash(i + 301) * 8); R(cc, x, y, 5, 2, '#c4704f'); R(cc, x, y + 2, 5, 3, '#e6dccb'); if (hash(i + 302) > .55) R(nc, x + 2, y + 3, 1, 1, '#ffcf7a'); }
    R(cc, 0, 164, T, 106, '#a5b39a'); for (let x = 0; x < T; x += 3) R(cc, x, 164, 2, 1, '#bac6ab');
    // cidade perto: prédios maiores com varandas, ar-condicionado e caixa-d'água; casinhas com telhado vermelho
    for (let i = 0; i < 46; i++) {
      const x = Math.round(hash(i + 1200) * T), w = 18 + Math.round(hash(i + 1201) * 18), h = 30 + Math.round(Math.pow(hash(i + 1202), 1.5) * 70), y = 172 - h, col = pal[(i + 3) % pal.length];
      R(cn, x - 1, y - 1, w + 2, h + 1, shadeHex(col, .7)); R(cn, x, y, w, h, col); R(cn, x + w - 3, y, 3, h, shadeHex(col, .84));
      for (let yy = y + 4; yy < 168; yy += 6) { R(cn, x + 1, yy + 4, w - 2, 1, shadeHex(col, .9)); for (let xx = x + 3; xx < x + w - 4; xx += 4) { R(cn, xx, yy, 2, 3, '#7f98a6'); R(cn, xx, yy, 2, 1, '#a9c2cc'); if (hash(xx * 11 + yy) > .6) R(nn, xx, yy, 2, 3, pick(['#ffd98a', '#ffe9b8', '#fff4dc', '#ffc870'], xx * 3 + yy)); } if (hash(i * 9 + yy) > .82) R(cn, x + w - 6, yy + 1, 3, 2, '#d8dcdc'); }
      if (hash(i + 1203) > .3) caixaDagua(cn, x + 3, y - 14, hash(i + 1204) > .5 ? 1 : 0); if (hash(i + 1205) > .5) antena(cn, x + w - 4, y);
    }
    for (let i = 0; i < 90; i++) { const x = Math.round(hash(i + 1500) * T), w = 12 + Math.round(hash(i + 1501) * 10); R(cn, x, 166, w, 8, pick(['#ece6d8', '#f0e2c8', '#e0d8e8', '#d8e4d0'], i)); roofTiles(cn, x - 1, 162, w + 2, 4, pick(['#b8644a', '#a8543c'], i)); if (hash(i + 1502) > .5) R(nn, x + 3, 168, 2, 2, '#ffcf7a'); }
    R(cn, 0, 174, T, 96, '#98a98c');
    // faixa de árvores com ipês roxos e amarelos (florados no inverno)
    for (let i = 0; i < 120; i++) { const x = hash(i + 2000) * T, y = 176 + hash(i + 2001) * 6, kind = hash(i + 2002); ell(ct, x, y, 8 + hash(i) * 6, 6, kind > .82 ? '#b86ac8' : kind > .7 ? '#e8c84a' : i % 2 ? '#4f7a46' : '#5f8a52'); ell(ct, x - 2, y - 2, 5, 3, kind > .82 ? '#d48ae0' : kind > .7 ? '#f6dc6a' : '#6f9a5c'); }
    R(ct, 0, 180, T, 90, '#7a9a62');
    return { ridge, city, near, trees, nCity, nNear, nRidge };
  }
  // neblina macia (a cidade é a "Suíça Baiana")
  let FOG = null;
  function buildFog() { const [cv, c] = mk(964, LH); for (let i = 0; i < 70; i++) { const x = hash(i + 50) * 964, y = 120 + hash(i + 51) * 120, rx = 30 + hash(i + 52) * 60, ry = 6 + hash(i + 53) * 10; for (let k = 0; k < 5; k++) ell(c, x, y, rx * (1 - k * .15), ry * (1 - k * .15), `rgba(236,240,244,${.07 + k * .03})`); } return cv; }
  function fog(c, s, t, camL, amount) {
    if (amount <= .01) return; if (!FOG) FOG = buildFog();
    const morning = s.h >= 4.5 && s.h < 9.5 ? 1 - Math.abs(s.h - 7) / 2.5 : 0, k = cl(amount * (.55 + morning * .8 + s.night * .25));
    c.globalAlpha = k * .85; tile(c, FOG, camL * .5 - t * 4); c.globalAlpha = k * .55; tile(c, FOG, camL * .8 + 300 - t * 7);
    c.globalAlpha = 1; const g = c.createLinearGradient(0, 140, 0, 230); g.addColorStop(0, 'rgba(230,236,240,0)'); g.addColorStop(1, `rgba(230,236,240,${.32 * k})`); c.fillStyle = g; c.fillRect(0, 140, LW, 90);
  }
  function cityNight(c, s, img, off, dy = 0) { const a = night(s); if (a < .03 || !img) return; c.save(); c.translate(0, dy); c.globalCompositeOperation = 'lighter'; c.globalAlpha = a; tile(c, img, off); tile(c, img, off); c.restore(); }
  // pássaros em bando e pipas (como na favela da campanha principal)
  function passaros(c, t, camL, n = 7, seed = 0) { for (let g = 0; g < 2; g++) { const bx = ((t * (12 + g * 5) + seed * 300 + g * 400 - camL * .1) % 700) - 100, by = 40 + g * 26 + Math.sin(t * .6 + g) * 6; for (let i = 0; i < n; i++) { const x = bx - Math.abs(i - n / 2) * 6, y = by + Math.abs(i - n / 2) * 3, f = Math.sin(t * 9 + i) > 0; R(c, x - 2, y - (f ? 1 : 0), 2, 1, '#3a3a40'); R(c, x + 1, y - (f ? 1 : 0), 2, 1, '#3a3a40'); R(c, x, y, 1, 1, '#3a3a40'); } } }
  function pipas(c, t, camL, seed = 0) { for (let i = 0; i < 3; i++) { const x = ((hash(i + seed) * 600 - camL * .3) % 560 + 560) % 560 - 40, y = 30 + hash(i * 3 + seed) * 50 + Math.sin(t * 1.4 + i) * 5, col = ['#e8433a', '#3c9ad8', '#f2c94c'][i]; const sw = Math.sin(t * 2 + i) * 2; R(c, x + sw, y, 5, 5, col); R(c, x + 1 + sw, y + 1, 3, 3, shadeHex(col, 1.2)); for (let k = 0; k < 8; k++) R(c, x + 2 + sw + Math.sin(t * 3 + k * .7 + i) * 2, y + 5 + k * 2, 1, 1, col); for (let k = 0; k < 40; k += 2) R(c, x + 2 + k * .9, y + 6 + k * 2.6, 1, 1, 'rgba(60,60,60,.45)'); } }
  /* ---------- fundo vivo: tudo que se mexe lá longe ---------- */
  const wrap = (v, T = 964) => ((v % T) + T) % T;
  function aviao(c, s, t, camL) { // a cada ~45 s um avião cruza o céu deixando rastro
    const per = 45, ph = (t % per) / per; if (ph > .5) return; const k = ph / .5, x = -40 + k * 560 - camL * .01, y = 36 + Math.sin(k * 3) * 4;
    for (let i = 0; i < 40; i++) { const a = (1 - i / 40) * .35 * (1 - s.night * .6); R(c, x - 4 - i * 3, y + 1, 3, 1, `rgba(255,255,255,${a})`); }
    R(c, x, y, 9, 2, '#e8ecef'); R(c, x + 2, y - 2, 3, 2, '#c8ced4'); R(c, x + 3, y + 2, 3, 1, '#c8ced4'); if (s.night > .3 && Math.sin(t * 8) > 0) R(c, x + 8, y, 1, 1, '#ff4a3a');
  }
  function estradaLonge(c, s, t, camL) { // carrinhos andando na estrada do planalto (com farol à noite)
    const y = 161, off = camL * .07, nt = night(s); R(c, 0, y + 2, LW, 1, 'rgba(90,96,100,.5)');
    for (let i = 0; i < 14; i++) { const dir = i % 2 ? 1 : -1, x = wrap(i * 73 + dir * t * (6 + (i % 4) * 2) - off, 560) - 40, col = pick(['#c43c3a', '#f2f2ee', '#3c6aa8', '#2a2a2a', '#e8c24c'], i);
      R(c, x, y, 4, 2, col); if (nt > .1) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = nt; R(c, dir > 0 ? x + 4 : x - 3, y, 3, 1, '#fff2b0'); R(c, dir > 0 ? x - 1 : x + 4, y, 1, 1, '#ff3a2a'); c.restore(); } }
  }
  function guindastes(c, s, t, camL) { // guindastes girando devagar com o gancho balançando
    for (const [gx0, h, sd] of [[210, 68, 1], [760, 60, 2]]) { const x = wrap(gx0 - camL * .05) - 0, top = 160 - h, a = Math.sin(t * .12 + sd * 2) * .9, len = 26;
      if (x < -40 || x > LW + 40) continue; const ex = x + Math.cos(a) * len, back = x - Math.cos(a) * 10;
      limb(c, [[back, top], [ex, top]], 1, '#e8a83a'); R(c, back - 2, top, 4, 3, '#8a8a86'); const hk = ex - Math.sin(t * .9 + sd) * 2; limb(c, [[ex - 2, top + 1], [hk, top + 14]], 1, '#5a5a56'); R(c, hk - 1, top + 14, 3, 2, '#5a5a56'); }
  }
  function fumacas(c, s, t, camL) { for (const [x0, y0] of [[120, 132], [430, 140], [690, 128]]) { const x = wrap(x0 - camL * .05) - 0; if (x < -20 || x > LW + 20) continue; for (let i = 0; i < 6; i++) { const k = (t * .12 + i / 6) % 1; R(c, x + Math.sin(t * .5 + i) * 3 + k * 10, y0 - k * 30, 2 + k * 5, 2 + k * 2, `rgba(225,228,230,${(1 - k) * .45})`); } } }
  function bandeiras(c, s, t, camL) { for (let i = 0; i < 6; i++) { const x = wrap(i * 161 + 40 - camL * .12), y = 96 + (i % 3) * 14; if (x > LW + 10) continue; R(c, x, y, 1, 10, '#6a6a66'); for (let k = 0; k < 6; k++) R(c, x + 1 + k, y + Math.round(Math.sin(t * 5 + k * .8 + i) * 1), 1, 4, i % 2 ? (k < 3 ? '#2c8a3a' : '#e8c24c') : (k < 2 ? '#f2f2ee' : k < 4 ? '#c43c3a' : '#3c6aa8')); } }
  function janelasPiscando(c, s, t, camL) { const a = night(s); if (a < .1) return; c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 40; i++) { const slot = Math.floor(t / 3 + hash(i) * 10); if (hash(slot * 7 + i) > .5) continue; const x = wrap(hash(i + 70) * 964 - camL * .12), y = 110 + hash(i + 71) * 58; if (x > LW) continue; R(c, x, y, 2, 3, `rgba(255,214,140,${.8 * a})`); } c.restore(); }
  function antenasPiscando(c, s, t, camL) { if (Math.sin(t * 2.6) < .2) return; for (const ax of [590, 640, 820]) { const x = wrap(ax - camL * .02); if (x > LW) continue; R(c, x - 1, 108, 3, 3, `rgba(255,70,60,${.5 + night(s) * .5})`); } }
  function conquistaBack(c, s, t, camL, o = {}) {
    if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); aviao(c, s, t, camL);
    tile(c, FAR.ridge, camL * .02); cityNight(c, s, FAR.nRidge, camL * .02); antenasPiscando(c, s, t, camL);
    haze(c, s, t, camL, 100, 165);
    tile(c, FAR.city, camL * .05); cityNight(c, s, FAR.nCity, camL * .05); guindastes(c, s, t, camL); fumacas(c, s, t, camL); estradaLonge(c, s, t, camL);
    if (o.near !== false) { haze(c, s, t, camL, 130, 180); tile(c, FAR.near, camL * .12); cityNight(c, s, FAR.nNear, camL * .12); janelasPiscando(c, s, t, camL); bandeiras(c, s, t, camL); }
    if (o.trees !== false) tile(c, FAR.trees, camL * .2 + Math.sin(t * .8) * 1.2); // a copa das árvores balança com o vento
    if (o.birds !== false) passaros(c, t, camL, 7, o.seed || 0);
    if (o.kites) pipas(c, t, camL, o.seed || 0);
  }
  /* ---------- passarinhos nos fios: saem voando quando Da Roça chega perto ou pula ---------- */
  let HERO = { x: -9999, y: 440, vy: 0 };
  const FIOS = { 13: { x0: 41, step: 230, n: 8, y0: 58 }, 14: { x0: 31, step: 260, n: 9, y0: 56 } };
  const BIRDS = {}; let birdT = 0;
  function birdsOf(id) { if (BIRDS[id]) return BIRDS[id]; const F = FIOS[id], out = []; if (!F) return out; for (let i = 0; i < F.n; i++) for (let j = 0; j < 3; j++) { if (hash(i * 9 + j + id) < .35) continue; const u = .2 + hash(i * 3 + j * 7 + id) * .6, px = F.x0 + i * F.step + u * F.step, py = F.y0 + Math.round(Math.sin(u * Math.PI) * 9) - 1; out.push({ px, py, x: px, y: py, vx: 0, vy: 0, st: 0, tm: 0, col: pick(['#3a3a40', '#5a4a3a', '#6a6f78'], i + j) }); } return (BIRDS[id] = out); }
  function passarinhosFio(c, id, t, camL) {
    const L = birdsOf(id); if (!L.length) return; const dt = Math.max(0, Math.min(.05, t - birdT)); birdT = t; const hx = HERO.x / 2, jumping = HERO.vy < -250;
    for (const b of L) {
      const d = Math.abs(b.px - hx);
      if (b.st === 0 && (d < 70 || (jumping && d < 140))) { b.st = 1; b.vx = (b.px >= hx ? 1 : -1) * (40 + Math.random() * 40); b.vy = -40 - Math.random() * 20; b.tm = 7 + Math.random() * 6; }
      if (b.st === 1) { b.x += b.vx * dt; b.y += b.vy * dt; b.vy -= 4 * dt; b.tm -= dt; if (b.tm <= 0 && d > 160) b.st = 2; }
      if (b.st === 2) { b.x += (b.px - b.x) * Math.min(1, dt * 1.5); b.y += (b.py - b.y) * Math.min(1, dt * 1.5); if (Math.abs(b.x - b.px) < 1 && Math.abs(b.y - b.py) < 1) { b.st = 0; b.x = b.px; b.y = b.py; } }
      const x = b.x - camL; if (x < -10 || x > LW + 10) continue;
      if (b.st === 0) { const bob = Math.sin(t * 2 + b.px) > .9 ? 1 : 0; R(c, x, b.y - 3 + bob, 3, 3, b.col); R(c, x + 2, b.y - 4 + bob, 2, 2, b.col); R(c, x + 3, b.y - 3 + bob, 1, 1, '#e8a83a'); R(c, x - 1, b.y - 2, 1, 1, b.col); }
      else { const f = Math.sin(t * 18 + b.px) > 0; R(c, x, b.y, 3, 2, b.col); R(c, x - 2, b.y - (f ? 2 : 0), 2, 1, b.col); R(c, x + 3, b.y - (f ? 2 : 0), 2, 1, b.col); }
    }
  }
  function heroi(x, y, vy) { HERO = { x: Number(x) || -9999, y: Number(y) || 440, vy: Number(vy) || 0 }; }

  /* =====================================================================
     12 · AEROPORTOS
     ===================================================================== */
  const AIR = { W: 2200, TAR: 1050, GR: 1500 };
  function buildAir() {
    const [cv, c] = mk(AIR.W, LH);
    // ---- Aeroporto de Itabuna (0..1050): paredes com vidraças altas (a pista aparece lá fora) ----
    R(c, 0, 0, AIR.TAR, 30, '#d8dad6'); for (let x = 12; x < AIR.TAR; x += 52) { R(c, x, 24, 28, 3, '#fff6d8'); R(c, x, 27, 28, 1, '#c8c4b0'); } R(c, 0, 30, AIR.TAR, 3, '#9aa0a0');
    plaster(c, 0, 33, AIR.TAR, 177, '#ece8de', 12);
    for (let x = 0; x < AIR.TAR; x += 150) { c.clearRect(x + 14, 44, 118, 92); R(c, x + 12, 42, 122, 2, '#2c4656'); R(c, x + 12, 136, 122, 3, '#2c4656'); R(c, x + 12, 42, 2, 96, '#2c4656'); R(c, x + 132, 42, 2, 96, '#2c4656'); R(c, x + 72, 42, 2, 96, '#2c4656'); R(c, x + 14, 44, 118, 3, 'rgba(200,230,240,.4)'); }
    // balcões de check-in com esteira, balança e monitor da companhia
    for (let k = 0; k < 4; k++) { const x = 40 + k * 112; R(c, x, 168, 84, 42, '#6f7f8c'); R(c, x, 168, 84, 4, '#c9d2d8'); R(c, x + 4, 176, 76, 2, '#5a6670'); R(c, x + 6, 148, 24, 16, '#1d2a34'); R(c, x + 8, 150, 20, 12, '#3c8ad8'); R(c, x + 10, 152, 16, 3, '#f2efe6'); R(c, x + 17, 164, 2, 4, '#4a5a64'); R(c, x + 46, 180, 30, 30, '#4a5660'); R(c, x + 48, 182, 26, 3, '#7a868e'); for (let j = 0; j < 4; j++) R(c, x + 50 + j * 6, 187, 4, 23, '#3a444c'); R(c, x + 88, 196, 12, 14, pick(['#c43c3a', '#3c6aa8', '#e8c24c'], k)); R(c, x + 88, 196, 12, 2, '#2a2a2a'); }
    R(c, 32, 112, 460, 18, '#1d4a7a'); R(c, 32, 112, 460, 1, '#5a8ac0'); R(c, 36, 116, 10, 10, '#f2c94c');
    for (let x = 28; x < 500; x += 38) { R(c, x, 186, 2, 24, '#8a8f92'); R(c, x - 1, 185, 4, 2, '#c4c8ca'); } for (let x = 28; x < 490; x += 2) R(c, x, 191 + (Math.floor(x / 38) % 2 ? 0 : 0), 2, 2, '#c43c3a');
    // lanchonete, bebedouro, plantas e cartaz do cacau
    R(c, 500, 150, 70, 60, '#c47a35'); R(c, 500, 150, 70, 10, '#8a4a20'); R(c, 504, 166, 62, 20, '#f2e8d0'); for (let k = 0; k < 5; k++) R(c, 508 + k * 12, 170, 8, 10, pick(['#e8c24c', '#c4743a', '#f2efe6', '#7a4a2a'], k)); R(c, 500, 186, 70, 24, '#8a4a20'); ell(c, 535, 145, 10, 4, '#f2c94c');
    R(c, 582, 186, 10, 24, '#c8ccce'); R(c, 582, 184, 10, 3, '#e8eaea'); R(c, 585, 190, 4, 2, '#3c8ad8');
    for (const px of [10, 470, 600, 1020]) plantaVaso(c, px, GY, px);
    R(c, 340, 50, 60, 70, '#5a3a24'); R(c, 342, 52, 56, 66, '#c47a35'); ell(c, 370, 80, 14, 20, '#7a4a2a'); ell(c, 370, 80, 10, 16, '#a86a3a'); for (let k = 0; k < 5; k++) R(c, 364, 68 + k * 6, 12, 1, '#5a3a20'); R(c, 346, 106, 48, 8, '#f2e8d0');
    // raio-x: esteira, máquina com tela e pórtico detector
    R(c, 620, 170, 170, 26, '#5a6670'); R(c, 620, 196, 170, 4, '#2c3238'); for (let k = 0; k < 170; k += 6) R(c, 620 + k, 170, 3, 2, '#3a444c'); R(c, 660, 136, 80, 60, '#c4cad0'); R(c, 660, 136, 80, 4, '#e2e6ea'); R(c, 666, 146, 68, 34, '#1a2228'); for (let k = 0; k < 6; k++) R(c, 630 + k * 26, 162, 20, 8, '#3c5a8a');
    R(c, 600, 110, 32, 22, '#1d2a34'); R(c, 602, 112, 28, 18, '#2c4a5a');
    R(c, 820, 116, 8, 94, '#9aa4ac'); R(c, 884, 116, 8, 94, '#9aa4ac'); R(c, 820, 112, 72, 10, '#9aa4ac'); R(c, 828, 120, 56, 2, '#5ae070'); R(c, 848, 114, 16, 6, '#2a3238');
    // portão de embarque: cadeiras, balcão e placa
    for (let k = 0; k < 3; k++) for (let j = 0; j < 5; j++) { const x = 910 + k * 44 + j * 8; R(c, x, 196, 7, 6, '#3c6a9a'); R(c, x, 186, 7, 10, '#4f80b0'); R(c, x + 1, 202, 1, 8, '#555'); }
    R(c, 960, 160, 50, 30, '#4a5a64'); R(c, 960, 160, 50, 3, '#8a9aa4'); R(c, 1012, 100, 30, 16, '#1d4a7a'); R(c, 1014, 102, 26, 12, '#f2c94c');
    pisoInterno(c, AIR.TAR, '#dcd8ce', '#c6c2b6', 20); objetos(c, 12, AIR.W, 'interno', 40, 600, [90, 160]);
    // ---- pista (1050..1500): cerca, biruta, torre e carrinho de bagagem ----
    R(c, AIR.TAR, 196, 450, 14, '#7f878c'); for (let x = AIR.TAR; x < AIR.GR; x += 6) R(c, x, 168, 1, 28, '#8a949a'); R(c, AIR.TAR, 168, 450, 1, '#8a949a'); R(c, AIR.TAR, 182, 450, 1, '#8a949a');
    R(c, 1140, 120, 3, 76, '#9aa0a6'); R(c, 1440, 70, 26, 56, '#e8e4dc'); R(c, 1436, 60, 34, 12, '#2c4a5a'); R(c, 1438, 62, 30, 8, '#7ac0d0'); R(c, 1446, 126, 14, 70, '#d8d4cc');
    for (let k = 0; k < 4; k++) { R(c, 1240 + k * 30, 196, 26, 10, '#3c6aa8'); R(c, 1242 + k * 30, 190, 22, 8, pick(['#c43c3a', '#e8c24c', '#4a8a5a', '#7a3a8a'], k)); ell(c, 1246 + k * 30, 207, 3, 3, '#1c1c1c'); ell(c, 1260 + k * 30, 207, 3, 3, '#1c1c1c'); } R(c, 1214, 192, 26, 14, '#f2c94c'); R(c, 1218, 186, 14, 8, '#2c3a44');
    for (let x = AIR.TAR; x < AIR.GR; x += 3) { R(c, x, 220, 3, LH - 220, '#6f777c'); } for (let x = AIR.TAR + 20; x < AIR.GR; x += 60) R(c, x, 240, 30, 3, '#f2f2e6'); R(c, AIR.TAR, 228, 450, 1, '#e8c24c');
    // ---- Aeroporto Glauber Rocha (1500..2200): marquise branca com letreiro azul, colunas e vidro ----
    R(c, AIR.GR, 60, 700, 150, '#dfe3e4'); for (let x = AIR.GR + 10; x < AIR.W - 10; x += 28) { R(c, x, 74, 26, 116, '#3c5f70'); R(c, x + 1, 75, 24, 114, '#6f9cae'); R(c, x + 1, 75, 24, 26, '#9cc4d2'); R(c, x + 4, 80, 2, 100, 'rgba(255,255,255,.35)'); R(c, x + 1, 150, 24, 40, '#5a8496'); }
    for (let k = 0; k < 18; k++) { const px = AIR.GR + 40 + k * 36; R(c, px, 168, 4, 12, '#2a3a4a'); R(c, px - 1, 162, 6, 6, pick(['#e0b08a', '#9a6440', '#c88a60'], k)); }
    R(c, 1700, 176, 220, 20, '#3c444a'); for (let k = 0; k < 9; k++) R(c, 1708 + k * 24, 170, 14, 8, pick(['#c43c3a', '#3c6a9a', '#e8c24c', '#4a8a5a'], k)); R(c, 1700, 176, 220, 2, '#8a949a');
    R(c, 1480, 38, 740, 24, '#f8f8f4'); R(c, 1480, 38, 740, 2, '#ffffff'); R(c, 1480, 62, 740, 4, '#9aa4a8'); R(c, 1480, 66, 740, 8, 'rgba(60,70,80,.25)');
    for (let k = 0; k < 8; k++) { const px = AIR.GR + 20 + k * 90; R(c, px, 66, 6, 144, '#8a949a'); R(c, px + 1, 66, 2, 144, '#b4bcc0'); }
    for (const px of [1520, 1640, 2080, 2160]) { R(c, px, 196, 14, 14, '#6a6a66'); R(c, px + 1, 196, 12, 2, '#8a8a86'); for (let k = 0; k < 6; k++) ell(c, px + 3 + k * 2, 186 - (k % 2) * 6, 3, 5, k % 2 ? '#4f8a3a' : '#5f9a46'); }
    pisoInterno(c, AIR.W, '#dcd8ce', '#c6c2b6', 20); // (redesenha o piso inteiro, o trecho da pista vem a seguir)
    for (let x = AIR.TAR; x < AIR.GR; x += 3) R(c, x, 220, 3, LH - 220, '#6f777c'); for (let x = AIR.TAR + 20; x < AIR.GR; x += 60) R(c, x, 240, 30, 3, '#f2f2e6');
    return cv;
  }
  let airMid = null;
  function aeroporto(c, s, t, camL) {
    if (!airMid) airMid = buildAir(); if (!FAR) FAR = buildFar();
    conquistaBack(c, s, t, camL, { near: false, trees: false });
    // lá fora: pista com o avião, coqueiros e um avião decolando de vez em quando
    { const px = AIR.TAR - 60 - camL * .0; const ox = -camL * .35; for (let k = 0; k < 12; k++) { const x = ((k * 140 + ox) % 1680 + 1680) % 1680 - 100; R(c, x, 150, 80, 50, '#7f878c'); } R(c, 0, 150, LW, 2, '#a8b0b4'); void px;
      for (let k = 0; k < 8; k++) { const x = ((k * 230 - camL * .32) % 1840 + 1840) % 1840 - 120; R(c, x, 120, 2, 30, '#6a5a3a'); for (let j = 0; j < 5; j++) limb(c, [[x + 1, 120], [x + 1 + (j - 2) * 6, 114 + Math.abs(j - 2) * 3]], 2, '#4f8a3a'); } }
    { const ph = (t * .05) % 1, x = -80 + ph * 640, y = 132 - Math.max(0, ph - .4) * 140; if (ph < .9) { R(c, x, y, 44, 7, '#f2f4f6'); R(c, x + 40, y + 1, 7, 5, '#f2f4f6'); R(c, x - 4, y - 8, 7, 10, '#3c6aa8'); R(c, x + 14, y + 4, 18, 3, '#c9ced2'); for (let k = 0; k < 6; k++) R(c, x + 8 + k * 5, y + 2, 2, 2, '#3c4a5a'); } }
    // o avião grande no pátio, com escada
    { const ax = 1110 - camL; if (vis(ax, 420)) { R(c, ax, 118, 300, 34, '#f2f4f6'); R(c, ax + 290, 122, 34, 26, '#f2f4f6'); R(c, ax + 318, 128, 8, 14, '#e8eaec'); R(c, ax - 22, 128, 26, 20, '#f2f4f6'); R(c, ax - 34, 86, 28, 44, '#3c6aa8'); R(c, ax - 30, 90, 6, 30, '#5a8ad0');
      R(c, ax + 110, 144, 130, 9, '#c9ced2'); R(c, ax + 140, 152, 20, 12, '#5a6670'); R(c, ax + 186, 152, 20, 12, '#5a6670'); for (let k = 0; k < 16; k++) R(c, ax + 30 + k * 16, 126, 6, 6, '#3c4a5a'); R(c, ax, 140, 300, 3, '#3c6aa8'); R(c, ax, 143, 300, 1, '#f2c94c'); R(c, ax + 50, 132, 14, 20, '#c8ced4');
      for (let k = 0; k < 9; k++) R(c, ax + 40 + k * 3, 152 + k * 6, 14, 2, '#9aa0a6'); R(c, ax + 36, 152, 2, 58, '#9aa0a6'); R(c, ax + 68, 152, 2, 58, '#9aa0a6'); ell(c, ax + 120, 208, 5, 4, '#1c1c1c'); ell(c, ax + 240, 208, 5, 4, '#1c1c1c'); R(c, ax + 118, 196, 4, 12, '#5a5a56'); R(c, ax + 238, 196, 4, 12, '#5a5a56'); } }
    c.drawImage(airMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // painel de voos piscando, tela do raio-x mostrando a mala, biruta ao vento e passageiros
    { const x = 300 - camL; if (vis(x, 120)) { R(c, x - 4, 56, 128, 48, '#14202a'); for (let k = 0; k < 5; k++) { R(c, x + 2, 62 + k * 8, 56, 4, '#f2c94c'); R(c, x + 62, 62 + k * 8, 30, 4, '#c8d0d4'); R(c, x + 96, 62 + k * 8, 22, 4, (Math.sin(t * 3 + k) > 0 || k > 1) ? '#5ae070' : '#14202a'); } } }
    { const x = 666 - camL; if (vis(x, 80)) { for (let k = 0; k < 5; k++) R(c, x + 6 + k * 12, 150 + Math.round(Math.sin(t * 2 + k) * 2), 9, 22, '#3a6a9a'); R(c, x + 28, 152, 14, 10, '#c8e8ff'); R(c, x + 30, 154, 3, 6, '#ff5a4a'); } }
    for (let k = 0; k < 6; k++) { const x = ((k * 30 + t * 12) % 180) + 620 - camL; if (vis(x, 20)) R(c, x, 164, 16, 6, pick(['#c43c3a', '#3c6aa8', '#e8c24c', '#4a8a5a'], k)); }
    { const x = 1140 - camL; if (vis(x, 40)) { const sw = Math.sin(t * 2) * 2; for (let k = 0; k < 5; k++) R(c, x + 3 + k * 4, 120 + k * .8 + sw * k * .3, 4, 5 - k * .6, k % 2 ? '#f2f2ee' : '#f08a24'); } }
    for (let i = 0; i < 12; i++) { const wx = 120 + i * 175 + Math.sin(t * .3 + i) * 30, x = wx - camL; if (vis(x, 20) && (wx < AIR.TAR || wx > AIR.GR)) { gente(c, x, GY, i); R(c, x + 6, GY - 8, 6, 8, pick(['#c43c3a', '#2c4a6a', '#e8c24c'], i)); R(c, x + 8, GY - 10, 2, 2, '#2a2a2a'); } }
    { const x = 2120 - camL; if (vis(x, 60)) { carro(c, x, GY + 2, '#e8c24c', -1); R(c, x + 8, GY - 16, 14, 3, '#2a2a2a'); } }
    fog(c, s, t, camL, .2);
  }
  function aeroportoLights(g, s, t, camL) { const a = night(s); for (let x = 12; x < AIR.TAR; x += 52) { const sx = x + 14 - camL; if (vis(sx)) lightAdd(sx, 26, .3 + a * .4, 60); } for (let x = AIR.GR + 20; x < AIR.W; x += 90) { const sx = x - camL; if (vis(sx) && a > .05) { g.fillStyle = `rgba(255,246,216,${.25 * a})`; g.fillRect(sx - 20, 66, 40, 144); lightAdd(sx, 66, a * .6, 70); } } }

  /* =====================================================================
     13 · BAIRRO DA PENSÃO
     ===================================================================== */
  const BAIRRO = { W: 2100, PEN: 780 };
  function buildBairro() {
    const [cv, c] = mk(BAIRRO.W, LH);
    // fileira de casas e sobradinhos (com uma igreja pequena e uma oficina)
    for (let i = 0, x = 6; x < BAIRRO.W - 60; i++) {
      if (x > BAIRRO.PEN - 70 && x < BAIRRO.PEN + 240) { x = BAIRRO.PEN + 240; continue; }
      if (x > 1110 && x < 1360) { x = 1360; continue; }
      const w = 62 + Math.round(hash(i + 40) * 40);
      if (i % 5 === 3) predio(c, x, w, 2, pick(['#e9d8b4', '#c9dcc8', '#e8c4b4', '#d4d8e8', '#f0e2a8'], i), i + 60, { telhado: '#a8543c' }); else casa(c, x, w, pick(['#e9d8b4', '#c9dcc8', '#e8c4b4', '#d4d8e8', '#f0e2a8', '#d8c8e0'], i), i + 40);
      x += w + 16;
    }
    // Pensão Dona Lurdes: sobrado de dois andares com sacada de ferro e plantas
    const px = BAIRRO.PEN; plaster(c, px, 96, 220, GY - 96, '#f2dfb0', 77); roofTiles(c, px - 6, 86, 232, 10, '#9a4a34');
    for (let k = 0; k < 6; k++) { janela(c, px + 12 + k * 35, 108, 16, 18, 'veneziana', 80 + k); } R(c, px + 4, 128, 212, 3, '#d8c08a'); for (let k = 0; k < 212; k += 3) R(c, px + 4 + k, 131, 1, 8, '#3a3026'); R(c, px + 4, 131, 212, 1, '#3a3026'); for (let k = 0; k < 7; k++) plantaVaso(c, px + 8 + k * 30, 140, 90 + k);
    R(c, px, 150, 220, 4, '#d8c08a'); for (let k = 0; k < 3; k++) janela(c, px + 12 + k * 35, 162, 16, 18, 'grade', 100 + k); R(c, px + 130, 158, 28, 52, '#6a3c24'); R(c, px + 132, 160, 24, 48, '#8a5a3c'); R(c, px + 143, 160, 2, 48, '#6a3c24'); R(c, px + 152, 184, 2, 3, '#e8c24c');
    R(c, px + 170, 162, 40, 30, '#8a4a20'); R(c, px + 172, 164, 36, 26, '#f2e8d0'); for (let k = 0; k < 4; k++) R(c, px + 175 + k * 8, 168, 6, 8, pick(['#c43c3a', '#e8c24c', '#3c6aa8'], k)); // quadro de avisos
    board(c, px + 40, 140, 140, 10, '#f8f0d8', '#5a3c2a'); caixaDagua(c, px + 160, 64, 1); antena(c, px + 20, 86); parabolica(c, px + 60, 72);
    // padaria e mercadinho com caixotes na frente
    predio(c, 1130, 96, 2, '#f0e6cc', 140, { loja: true }); loja(c, 1130, 96, '#c47a35', '#c43c3a', '#f2efe6', 141);
    predio(c, 1240, 110, 2, '#dde8d4', 150, { loja: true }); loja(c, 1240, 110, '#3c7a4a', '#3c7a4a', '#f2efe6', 151);
    for (let k = 0; k < 4; k++) { R(c, 1260 + k * 16, GY - 10, 14, 10, '#9a6a3a'); for (let j = 0; j < 4; j++) ell(c, 1263 + k * 16 + j * 3, GY - 11, 2, 2, pick(['#e8c24c', '#d9634a', '#7cbf6a', '#f2a83a'], k * 4 + j)); }
    // postes com fiação, orelhão, banca, ponto de ônibus, placa de rua e grafite no muro
    for (let x = 40; x < BAIRRO.W; x += 230) poste(c, x); for (let x = 40; x < BAIRRO.W - 230; x += 230) fios(c, x + 1, x + 231, 58);
    orelhao(c, 1100); banca(c, 1500); ponto(c, 1700); placaRua(c, 720); lixeira(c, 1060); lixeira(c, 1820, '#3c8a5a'); hidrante(c, 1580);
    plaster(c, 1880, GY - 26, 200, 26, '#e8e2d2', 190); grafite(c, 1890, GY - 24, 180, 20, 191); cartaz(c, 1900, GY - 44, 192); cartaz(c, 1916, GY - 44, 193);
    moto(c, 1020, '#c43c3a'); bike(c, 1460, '#3c8ad8'); cachorro(c, 1640, GY, '#c98a43'); gato(c, 920, 96, '#d8a24a');
    bandeirinhas(c, 1120, 1360, 70, 3);
    objetos(c, 13, BAIRRO.W, 'cidade'); calcada(c, BAIRRO.W); asfalto(c, BAIRRO.W, [600, 1580]); chaoDetalhe(c, BAIRRO.W, 'cidade');
    return cv;
  }
  let bairroMid = null;
  function bairro(c, s, t, camL) {
    if (!bairroMid) bairroMid = buildBairro();
    conquistaBack(c, s, t, camL, { kites: true, seed: 3 });
    c.drawImage(bairroMid, camL, 0, LW, LH, 0, 0, LW, LH);
    passarinhosFio(c, 13, t, camL);
    const sun = sunInfo(s), reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.22 * sun.str})`;
    for (const x of [130, 560, 1080, 1430, 1860]) { const sx = x - camL; if (vis(sx, 80)) { if (sun.str > .04) ell(c, sx + reach, 219, 18, 2.5, sh); if (x === 560 || x === 1860) ipe(c, sx, 214, x === 560 ? '#b86ac8' : '#e8c84a', x); else tree(c, sx, 214, .8, 0, t, x); } }
    for (let i = 0; i < 8; i++) { const wx = 160 + i * 250 + Math.sin(t * .2 + i * 2) * 60, sx = wx - camL; if (vis(sx, 20)) gente(c, sx, 216, i); }
    { const cx = ((t * 34) % 2700) - 300 - camL; if (vis(cx, 40)) carro(c, cx, 242, '#c43c3a', 1); const cx2 = 2400 - ((t * 26) % 2700) - camL; if (vis(cx2, 40)) carro(c, cx2, 256, '#3c6aa8', -1); }
    // fumaça de pão quente, vapor do bueiro e o cachorro abanando o rabo
    { const x = 1170 - camL; if (vis(x, 40)) for (let i = 0; i < 6; i++) { const k = (t * .3 + i / 6) % 1; R(c, x + Math.sin(t + i) * 3 * k, 150 - k * 34, 3 + k * 4, 2, `rgba(240,240,236,${(1 - k) * .5})`); } }
    { const x = 1640 - camL; if (vis(x, 20)) R(c, x - 3, GY - 9 + Math.round(Math.sin(t * 12) * 1.5), 4, 2, '#c98a43'); }
    fog(c, s, t, camL, .5);
  }
  function bairroLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let x = 40; x < BAIRRO.W; x += 230) lampGlow(g, x - camL + 14, 86, a); for (let k = 0; k < 6; k++) { const sx = BAIRRO.PEN + 20 + k * 35 - camL; if (vis(sx) && hash(k + 9) > .3) { g.fillStyle = `rgba(255,214,140,${.55 * a})`; g.fillRect(sx - 6, 110, 12, 14); } } for (const bx of [1130, 1240]) { const sx = bx + 50 - camL; if (vis(sx)) { g.fillStyle = `rgba(255,236,190,${.4 * a})`; g.fillRect(sx - 45, GY - 15, 90, 15); } } }

  /* =====================================================================
     14 · CENTRO E PRAÇA DA CATEDRAL
     ===================================================================== */
  const CENTRO = { W: 2500, CAT: 1180 };
  function cathedral(c, x) { // fiel à foto: fachada creme, uma torre com relógio e agulha com cruz, ogivas, nave lateral e grade
    const wall = '#eedfb6', white = '#f8f3e4', sh = '#cdb98a', dark = '#4f4636', glass = '#5a6f86';
    const ogive = (gx, gy, w, h, col = glass) => { R(c, gx, gy + 3, w, h - 3, white); R(c, gx + 1, gy + 4, w - 2, h - 5, col); R(c, gx + 1, gy + 2, w - 2, 2, white); R(c, gx + Math.floor(w / 2) - 1, gy, 2, 2, white); R(c, gx + Math.floor(w / 2) - 1, gy + 2, 2, 2, col); if (col === glass) { R(c, gx + Math.floor(w / 2) - 1, gy + 4, 1, h - 6, white); R(c, gx + 2, gy + 5, 1, h - 8, '#8aa4c0'); } };
    plaster(c, x + 90, 120, 190, 90, wall, 301); R(c, x + 90, 116, 190, 5, white); for (let k = 0; k < 6; k++) { const px = x + 100 + k * 30; R(c, px, 118, 5, 92, white); R(c, px + 1, 112, 3, 6, white); ogive(px + 11, 132, 10, 34); ogive(px + 11, 176, 10, 22); } R(c, x + 278, 116, 3, 94, sh);
    plaster(c, x, 110, 92, 100, wall, 302); R(c, x, 108, 92, 3, white); for (let k = 0; k < 14; k++) { const w = 92 - 12 - k * 6.4; if (w > 2) R(c, x + 6 + k * 3.2, 108 - k, w, 1, k % 3 ? wall : white); }
    for (const px of [x - 4, x + 88]) { R(c, px, 104, 8, 106, white); R(c, px + 2, 92, 4, 12, white); R(c, px + 3, 88, 2, 4, white); }
    ogive(x + 34, 150, 24, 60, '#5a3c28'); R(c, x + 45, 156, 2, 54, '#3c2818'); ogive(x + 10, 160, 14, 50, '#5a3c28'); ogive(x + 68, 160, 14, 50, '#5a3c28');
    ogive(x + 14, 124, 8, 24); ogive(x + 70, 124, 8, 24); ogive(x + 38, 118, 7, 24); ogive(x + 47, 118, 7, 24);
    const tx = x + 28, tw = 36; plaster(c, tx, 40, tw, 70, wall, 303); R(c, tx, 40, tw, 2, white); R(c, tx - 2, 40, 3, 70, white); R(c, tx + tw - 1, 40, 3, 70, white); R(c, tx + tw - 4, 42, 3, 68, sh);
    ogive(tx + 9, 82, 8, 22); ogive(tx + 19, 82, 8, 22); ogive(tx + 9, 52, 8, 20, dark); ogive(tx + 19, 52, 8, 20, dark);
    ell(c, tx + 18, 46, 7, 5, white); ell(c, tx + 18, 46, 5, 4, '#f4f0e2'); R(c, tx + 18, 43, 1, 3, dark); R(c, tx + 18, 46, 3, 1, dark);
    for (let k = 0; k < 24; k++) { const w = Math.max(2, tw - 4 - k * 1.4); R(c, tx + tw / 2 - w / 2, 36 - k * 2.2, w, 2.3, k % 4 === 0 ? white : wall); } R(c, tx + tw / 2 - 1, -24, 2, 10, '#5a5248'); R(c, tx + tw / 2 - 4, -21, 8, 2, '#5a5248');
    for (const px of [tx - 3, tx + tw - 1]) { R(c, px, 28, 4, 12, white); R(c, px + 1, 24, 2, 4, white); }
    R(c, x - 20, 198, 320, 2, '#2e2e2c'); for (let k = 0; k < 320; k += 4) { R(c, x - 20 + k, 198, 1, 12, '#3a3a36'); R(c, x - 20 + k, 196, 1, 2, '#3a3a36'); } R(c, x + 30, 204, 36, 6, '#c9c1aa'); R(c, x + 32, 202, 32, 2, '#d8d0b8');
  }
  function buildCentro() {
    const [cv, c] = mk(CENTRO.W, LH), x = CENTRO.CAT;
    const sinal = ['#c43c3a', '#2c5a8a', '#3c7a4a', '#7a3a8a', '#c47a35', '#d84a3a', '#2a8a8a'], toldo = [['#c43c3a', '#f2efe6'], ['#2c5a8a', '#f2efe6'], ['#e8c24c', '#3c7a4a'], ['#7a3a8a', '#f2efe6'], ['#c47a35', '#f2efe6']];
    // comércio do centro: prédios de 3 a 5 andares com lojas no térreo (como na foto)
    for (let i = 0, sx = 10; sx < 880; i++) { const w = 92 + Math.round(hash(i + 400) * 30); predio(c, sx, w, 3 + Math.round(hash(i + 401) * 2), pick(['#e9e6dc', '#ddd3bf', '#e4dccb', '#dfe6ea', '#f0e6cc'], i), 400 + i, { loja: true }); const tt = toldo[i % 5]; loja(c, sx, w, sinal[i % sinal.length], tt[0], tt[1], 410 + i); sx += w + 4; }
    for (let i = 0, sx = 1700; sx < CENTRO.W - 60; i++) { const w = 92 + Math.round(hash(i + 500) * 30); if (i === 0) { sx += 180; continue; } predio(c, sx, w, 3 + Math.round(hash(i + 501) * 2), pick(['#ddd3bf', '#e9e6dc', '#cfc6b2', '#f0e6cc'], i), 500 + i, { loja: true }); const tt = toldo[(i + 2) % 5]; loja(c, sx, w, sinal[(i + 3) % sinal.length], tt[0], tt[1], 510 + i); sx += w + 4; }
    // Memorial: casarão antigo
    plaster(c, 1700, 110, 170, 100, '#f2e8c8', 600); roofTiles(c, 1696, 102, 178, 8, '#a8543c'); for (let k = 0; k < 6; k++) { janela(c, 1710 + k * 27, 128, 14, 24, 'veneziana', 600 + k); R(c, 1710 + k * 27, 168, 14, 32, '#6a4a32'); R(c, 1708 + k * 27, 166, 18, 3, '#d8c8a0'); }
    // praça: canteiros floridos, coreto, fonte e bancos
    R(c, 900, 194, 700, 16, '#5f8a46'); for (let k = 900; k < 1600; k += 4) R(c, k, 192 - Math.round(hash(k) * 2), 2, 3, '#79a556'); for (let k = 0; k < 40; k++) R(c, 906 + k * 17, 197, 3, 3, pick(['#e86a7a', '#e8c24c', '#f2efe6', '#c86ab8'], k));
    cathedral(c, x);
    // ruas: postes, fiação, banca, orelhão, ponto, camelôs e motos
    for (let lx = 30; lx < CENTRO.W; lx += 260) poste(c, lx); for (let lx = 30; lx < CENTRO.W - 260; lx += 260) fios(c, lx + 1, lx + 261, 56);
    for (let lx = 930; lx < 1600; lx += 110) lampPost(c, lx, 131);
    banca(c, 620); orelhao(c, 700); ponto(c, 1930); lixeira(c, 880); lixeira(c, 1620, '#3c8a5a'); hidrante(c, 2100); placaRua(c, 860);
    for (const cx of [300, 2250]) { R(c, cx, GY - 14, 34, 14, '#8a6a45'); R(c, cx, GY - 14, 34, 2, '#c4955c'); for (let k = 0; k < 8; k++) R(c, cx + 2 + k * 4, GY - 18, 3, 4, pick(['#d9634a', '#e8c24c', '#5f9fd0', '#f2efe6', '#2a2a2a'], k + cx)); ell(c, cx + 17, GY - 34, 20, 5, pick(['#e8433a', '#3c9ad8'], cx)); R(c, cx + 16, GY - 34, 2, 20, '#8a8a86'); }
    for (const mx of [560, 1990, 2010]) moto(c, mx, pick(['#c43c3a', '#2a2a2a', '#3c6aa8'], mx));
    bandeirinhas(c, 930, 1170, 100, 7); bandeirinhas(c, 1470, 1600, 104, 8);
    objetos(c, 14, CENTRO.W, 'cidade', 30, 880); objetos(c, 14, CENTRO.W, 'cidade', 1640, CENTRO.W - 30); pedraPortuguesa(c, CENTRO.W, 204); asfalto(c, CENTRO.W, [880, 1660]); chaoDetalhe(c, CENTRO.W, 'cidade'); R(c, 0, 220, CENTRO.W, 1, '#8a8478');
    for (let fx = 860; fx < 920; fx += 6) R(c, fx, 224, 3, 40, '#e8c24c');
    return cv;
  }
  let centroMid = null;
  function centro(c, s, t, camL) {
    if (!centroMid) centroMid = buildCentro();
    conquistaBack(c, s, t, camL, { seed: 5 });
    c.drawImage(centroMid, camL, 0, LW, LH, 0, 0, LW, LH);
    passarinhosFio(c, 14, t, camL);
    const sun = sunInfo(s), reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.22 * sun.str})`;
    if (sun.str > .04) { const cx = CENTRO.CAT - camL; if (vis(cx, 300)) { slant(c, cx - 4, cx + 282, 210, reach * 1.6, 9, sh); shadeAdd(cx - 4 + reach, cx + 282 + reach, 1); sunWall(c, cx, 110, 92, 100, sun.lean, Math.min(1, Math.abs(sun.lean) * 1.4) * sun.str); } }
    for (const x of [950, 1050, 1500, 1590]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 212, .9, 1, t, x); }
    for (const x of [1120, 1540]) { const sx = x - camL; if (vis(sx, 60)) ipe(c, sx, 212, x === 1120 ? '#b86ac8' : '#e8c84a', x, .9); }
    for (const x of [990, 1440]) { const sx = x - camL; if (vis(sx, 60)) bench(c, sx, 212, 40, '#8a6a45', '#c4955c'); }
    for (let i = 0; i < 14; i++) { const wx = 80 + i * 175 + Math.sin(t * .25 + i) * 50, sx = wx - camL; if (vis(sx, 20)) gente(c, sx, 216, i); }
    for (let i = 0; i < 9; i++) { const bx = 1080 + i * 30, hop = Math.max(0, Math.sin(t * 3 + i * 2)) * 2, sx = bx - camL + Math.sin(t * .7 + i) * 3; if (vis(sx, 10)) { R(c, sx, 214 - hop, 4, 3, '#8a8f98'); R(c, sx + 3, 212 - hop, 2, 2, '#6a6f78'); R(c, sx + 3, 213 - hop, 1, 1, '#3aa04a'); } }
    { const bx = ((t * 40) % 3000) - 300 - camL; if (vis(bx, 60)) { R(c, bx, 228, 60, 20, '#3c7aa8'); R(c, bx + 2, 230, 56, 7, '#a9ccd8'); R(c, bx, 240, 60, 2, '#f2efe6'); ell(c, bx + 10, 249, 4, 4, '#1c1c1c'); ell(c, bx + 48, 249, 4, 4, '#1c1c1c'); } }
    fog(c, s, t, camL, .22);
  }
  function centroLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let x = 930; x < 1600; x += 110) lampGlow(g, x - camL, 130, a); for (let x = 30; x < CENTRO.W; x += 260) lampGlow(g, x - camL + 14, 84, a * .8);
    const cx = CENTRO.CAT - camL; if (vis(cx, 260)) { const gr = g.createRadialGradient(cx + 70, 160, 10, cx + 70, 160, 170); gr.addColorStop(0, `rgba(255,220,160,${.35 * a})`); gr.addColorStop(1, 'rgba(255,220,160,0)'); g.fillStyle = gr; g.fillRect(cx - 120, 0, 380, 220); lightAdd(cx + 70, 100, a * .6, 160); } }

  /* =====================================================================
     15 · SERRA DO PERIPERI E O CRISTO DE MÁRIO CRAVO
     ===================================================================== */
  const SERRA = { W: 2400, CRISTO: 2180 };
  function cactus(c, x, y) { ell(c, x, y - 5, 6, 6, '#3f7a4a'); for (let k = -4; k <= 4; k += 2) R(c, x + k, y - 10, 1, 10, '#2f5f38'); R(c, x - 3, y - 13, 7, 3, '#c43c5a'); R(c, x - 2, y - 14, 5, 1, '#e86a7a'); for (let k = -3; k <= 3; k += 3) R(c, x + k, y - 7, 1, 1, '#f2efe6'); } // cabeça-de-frade, cacto típico da serra
  function rocha(c, x, y, w, h, seed) { ell(c, x, y, w, h, '#8a8a80'); ell(c, x - w * .2, y - h * .3, w * .7, h * .55, '#a6a69a'); ell(c, x + w * .3, y + h * .2, w * .5, h * .4, '#76766c'); for (let i = 0; i < 6; i++) R(c, x - w * .6 + hash(i + seed) * w * 1.2, y - h * .3 + hash(i * 3 + seed) * h * .8, 2, 1, '#6a6a60'); if (hash(seed) > .5) R(c, x - w * .3, y - h * .5, w * .4, 1, '#5f8a46'); }
  function buildSerra() {
    const [cv, c] = mk(SERRA.W, LH);
    for (let x = 0; x < SERRA.W; x++) { const h = 40 + Math.sin(x * .006) * 18 + Math.sin(x * .021) * 6 + (x / SERRA.W) * 34; R(c, x, GY - h, 1, h, '#86865f'); R(c, x, GY - h, 1, 2, '#a4a47e'); R(c, x, GY - h + 2, 1, 3, '#7a7a54'); }
    for (let i = 0; i < 2600; i++) { const x = hash(i + 4100) * SERRA.W, y = 140 + hash(i + 4101) * 70; R(c, x, y, 2, 1, i % 3 ? '#7a7a56' : '#95956c'); }
    for (let i = 0; i < 80; i++) rocha(c, hash(i + 600) * SERRA.W, 150 + hash(i + 601) * 52, 8 + hash(i + 602) * 22, 5 + hash(i + 603) * 7, i);
    for (let i = 0; i < 200; i++) { const x = hash(i + 700) * SERRA.W, y = 158 + hash(i + 701) * 50; ell(c, x, y, 3 + hash(i) * 5, 3, i % 2 ? '#5a7a3c' : '#6a8a44'); if (hash(i + 702) > .7) R(c, x - 1, y - 3, 2, 2, pick(['#e8c24c', '#c86ab8', '#f2efe6'], i)); }
    for (let i = 0; i < 40; i++) cactus(c, 30 + hash(i + 800) * (SERRA.W - 60), 204);
    for (let i = 0; i < 16; i++) { const x = 60 + hash(i + 850) * (SERRA.W - 120); for (let k = 0; k < 7; k++) limb(c, [[x, 204], [x + (k - 3) * 4, 192 - Math.abs(k - 3) * 2]], 1, '#6a8a5a'); } // agaves
    // torres de antena com escada, trilha de pedra com degraus de madeira, placas e mirante
    for (const x of [520, 1340]) { R(c, x, 40, 3, 130, '#9a3a34'); for (let k = 40; k < 170; k += 10) { R(c, x - 6, k, 15, 1, '#c8c8c0'); R(c, x - 6, k, 1, 10, '#c8c8c0'); R(c, x + 8, k, 1, 10, '#c8c8c0'); limb(c, [[x - 6, k], [x + 8, k + 10]], 1, '#b8b8b0'); } R(c, x, 34, 3, 6, '#e8443a'); ell(c, x - 6, 60, 5, 3, '#e8e8e4'); }
    for (let x = 0; x < SERRA.W; x += 14) R(c, x, 205, 10, 3, '#8a6a45');
    for (const px of [200, 1000, 1900]) { R(c, px, 176, 2, 30, '#6a4a32'); R(c, px - 16, 168, 34, 12, '#6a4a32'); R(c, px - 15, 169, 32, 10, '#d8c49a'); }
    R(c, 2040, 188, 50, 3, '#8a6a45'); R(c, 2042, 191, 2, 13, '#6a4a32'); R(c, 2086, 191, 2, 13, '#6a4a32'); for (let k = 0; k < 50; k += 4) R(c, 2040 + k, 180, 1, 8, '#6a4a32'); R(c, 2040, 180, 50, 1, '#6a4a32');
    // o Cristo: cruz alta e fina de concreto sobre um disco num pilar, Cristo alongado
    const x = SERRA.CRISTO, cc = '#a49c90', cd = '#7f776c';
    R(c, x - 6, 168, 14, 38, cd); R(c, x - 4, 168, 10, 38, cc); ell(c, x + 1, 166, 40, 5, cd); ell(c, x + 1, 164, 38, 4, '#b8b0a4'); R(c, x - 38, 165, 78, 1, '#6f675c');
    R(c, x - 3, 10, 9, 154, cd); R(c, x - 2, 10, 7, 154, cc); R(c, x - 2, 10, 2, 154, '#c4bcb0'); R(c, x - 34, 30, 72, 8, cd); R(c, x - 34, 31, 72, 6, cc); R(c, x - 34, 31, 72, 2, '#c4bcb0');
    const fig = '#6a5a4a', figL = '#9a8a76'; ell(c, x + 1, 44, 4, 5, fig); R(c, x - 2, 49, 7, 30, fig); R(c, x - 1, 79, 5, 34, fig); R(c, x - 2, 112, 7, 5, fig); R(c, x - 3, 70, 9, 8, '#7a6a58'); for (let k = 0; k < 15; k++) { R(c, x - 32 + k * 2, 36 + Math.round(k * .6), 3, 4, fig); R(c, x + 5 + k * 2, 45 - Math.round(k * .6), 3, 4, fig); } R(c, x - 1, 50, 1, 28, figL); R(c, x + 1, 80, 1, 30, figL); R(c, x - 34, 35, 3, 3, figL); R(c, x + 34, 35, 3, 3, figL);
    for (const hx of [x - 130, x - 90, x + 70]) { plaster(c, hx, 182, 26, 24, '#f2ece0', hx); roofTiles(c, hx - 2, 176, 30, 6, '#b8644a'); R(c, hx + 9, 192, 7, 14, '#6a4a32'); }
    objetos(c, 15, SERRA.W, 'natureza', 40, SERRA.W - 300, [80, 170]); terra(c, SERRA.W, '#7a8a4a', '#5f6e3a'); chaoDetalhe(c, SERRA.W, 'natureza');
    return cv;
  }
  let serraMid = null;
  function serra(c, s, t, camL) {
    if (!serraMid) serraMid = buildSerra(); if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); tile(c, FAR.ridge, camL * .02);
    c.save(); c.translate(0, 22); tile(c, FAR.city, camL * .05); c.restore(); cityNight(c, s, FAR.nCity, camL * .05, 22);
    c.save(); c.translate(0, 26); tile(c, FAR.near, camL * .1); c.restore(); cityNight(c, s, FAR.nNear, camL * .1, 26); haze(c, s, t, camL, 120, 200);
    // urubus planando em círculos e o vento passando nas nuvens baixas
    for (let i = 0; i < 4; i++) { const a = t * .4 + i * 1.6, x = 240 + Math.cos(a) * (60 + i * 20) - (camL * .15) % 480, y = 50 + Math.sin(a) * 18 + i * 8; R(c, x - 5, y, 4, 1, '#2a2622'); R(c, x + 2, y, 4, 1, '#2a2622'); R(c, x - 1, y, 3, 2, '#2a2622'); R(c, x - 6, y - 1 + Math.round(Math.sin(t * 2 + i)), 1, 1, '#2a2622'); }
    c.drawImage(serraMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (let i = 0; i < 80; i++) { const x = ((i * 31 - camL) % (LW + 40) + LW + 40) % (LW + 40) - 20, sw = Math.round(Math.sin(t * 4 + i) * 2 + 1); R(c, x + sw, FLOOR - 7, 1, 7, '#a4a46a'); R(c, x + 2 + sw, FLOOR - 5, 1, 5, '#8a8a52'); }
    fog(c, s, t * 3, camL, .55);
  }
  function serraLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (const x of [520, 1340]) { const sx = x - camL; if (vis(sx) && Math.sin(t * 3) > 0) { g.fillStyle = `rgba(255,80,60,${a})`; g.fillRect(sx - 1, 32, 5, 5); } } const cx = SERRA.CRISTO - camL; if (vis(cx, 120)) { const gr = g.createRadialGradient(cx, 90, 4, cx, 90, 90); gr.addColorStop(0, `rgba(255,236,200,${.35 * a})`); gr.addColorStop(1, 'rgba(255,236,200,0)'); g.fillStyle = gr; g.fillRect(cx - 90, 0, 180, 210); lightAdd(cx, 20, a * .7, 120); } }

  /* =====================================================================
     16 · MONUMENTO AO ÍNDIO E AVENIDAS
     ===================================================================== */
  const AVENIDA = { W: 3000, INDIO: 1500 };
  function buildAvenida() {
    const [cv, c] = mk(AVENIDA.W, LH);
    for (let i = 0, x = 10; x < AVENIDA.W; i++) { const w = 70 + Math.round(hash(i + 70) * 50); if (Math.abs(x + w / 2 - AVENIDA.INDIO) < 280 || (x > 280 && x < 480)) { x += w + 30; continue; } predio(c, x, w, 2 + Math.round(hash(i + 71) * 4), pick(['#e9e6dc', '#ddd3bf', '#f2efe6', '#cfd6dc', '#e8dcc8'], i), 700 + i, { loja: hash(i + 72) > .4 }); if (hash(i + 72) > .4) loja(c, x, w, pick(['#c43c3a', '#2c5a8a', '#3c7a4a', '#c47a35'], i), pick(['#c43c3a', '#2c5a8a', '#e8c24c'], i + 1), '#f2efe6', 710 + i); x += w + 20; }
    // posto de gasolina com bombas e borracharia com pilha de pneus
    R(c, 296, 116, 168, 10, '#c43c3a'); R(c, 296, 126, 168, 4, '#f2efe6'); for (const k of [306, 450]) R(c, k, 130, 6, 80, '#9aa0a6'); for (let k = 0; k < 3; k++) { R(c, 340 + k * 34, 176, 16, 34, '#e8e4dc'); R(c, 342 + k * 34, 180, 12, 8, '#2c3a44'); R(c, 344 + k * 34, 182, 8, 3, '#5ae070'); limb(c, [[356 + k * 34, 190], [362 + k * 34, 200]], 1, '#2a2a2a'); }
    for (let k = 0; k < 4; k++) for (let j = 0; j < 3 - (k % 2); j++) { ell(c, 2600 + k * 14, GY - 4 - j * 7, 6, 4, '#1e1e1e'); ell(c, 2600 + k * 14, GY - 4 - j * 7, 3, 2, '#3a3a3a'); }
    R(c, 2580, GY - 46, 70, 10, '#e8c24c'); R(c, 2582, GY - 44, 66, 6, '#2a2a2a');
    // ponto de mototáxi com motos e outdoors
    for (let k = 0; k < 4; k++) moto(c, 820 + k * 22, pick(['#c43c3a', '#f08a24', '#2a2a2a', '#3c6aa8'], k)); R(c, 810, GY - 40, 2, 40, '#5a5e62'); R(c, 800, GY - 50, 50, 10, '#f08a24');
    for (const bx of [620, 2140]) { R(c, bx, 56, 120, 54, '#2a2f34'); R(c, bx + 3, 59, 114, 48, bx === 620 ? '#e8c24c' : '#5f9fd0'); R(c, bx + 50, 110, 4, 100, '#5a5e62'); R(c, bx + 66, 110, 4, 100, '#5a5e62'); }
    // passarela de pedestres
    R(c, 1990, 92, 120, 8, '#9aa0a6'); R(c, 1990, 90, 120, 2, '#c8ccce'); for (let k = 0; k < 120; k += 4) R(c, 1990 + k, 82, 1, 8, '#7a7e80'); R(c, 1990, 82, 120, 1, '#7a7e80'); R(c, 2000, 100, 6, 110, '#8a8e90'); R(c, 2094, 100, 6, 110, '#8a8e90');
    // rotatória do Monumento ao Índio: canteiro, pedestal de pedra e a estátua de bronze com arco
    const x = AVENIDA.INDIO; ell(c, x, 204, 130, 9, '#4a7238'); ell(c, x, 202, 126, 8, '#5f8a46'); for (let k = 0; k < 26; k++) R(c, x - 110 + k * 9, 198, 3, 3, pick(['#e86a7a', '#e8c24c', '#f2efe6', '#c86ab8'], k));
    brick(c, x - 24, 146, 48, 54, '#8a8478', 1500); R(c, x - 24, 146, 48, 3, '#b0aa9c'); R(c, x - 28, 196, 56, 6, '#6f6a60'); R(c, x - 10, 168, 20, 10, '#c9a24a'); R(c, x - 8, 170, 16, 6, '#e8d08a');
    const b = '#5e4128', bm = '#7a5634', bh = '#a7804c';
    R(c, x - 5, 66, 11, 12, b); R(c, x - 4, 66, 4, 12, bm); R(c, x - 1, 70, 2, 2, '#3a2818');
    for (let k = 0; k < 7; k++) { const a = -1.3 + k * .43, fx = x + Math.cos(a) * 9, fy = 66 + Math.sin(a) * 9; R(c, fx - 1, fy - 5, 3, 7, ['#c9a24a', '#b8443a', '#3c7a4a'][k % 3]); } R(c, x - 8, 64, 17, 3, '#8a4a2a');
    R(c, x - 3, 78, 7, 4, b); R(c, x - 11, 82, 23, 8, b); R(c, x - 11, 82, 23, 2, bh); R(c, x - 8, 90, 17, 18, b); R(c, x - 8, 90, 5, 18, bm); R(c, x - 2, 92, 1, 12, '#4a3220');
    R(c, x - 9, 106, 19, 7, '#8a6a3c'); for (let k = 0; k < 5; k++) R(c, x - 8 + k * 4, 113, 3, 6, '#7a5a34');
    R(c, x - 7, 113, 6, 31, b); R(c, x - 7, 113, 2, 31, bm); R(c, x + 2, 113, 6, 31, b); R(c, x + 6, 113, 2, 31, '#4a3220'); R(c, x - 9, 142, 9, 4, b); R(c, x + 1, 142, 9, 4, b);
    limb(c, [[x - 10, 84], [x - 18, 92], [x - 22, 86]], 4, b); limb(c, [[x + 11, 84], [x + 22, 86], [x + 30, 84]], 4, b);
    for (let k = 0; k <= 40; k++) { const yy = 62 + k * 1.1, xx = x + 32 + Math.round(Math.sin(k / 40 * Math.PI) * 7); R(c, xx, yy, 2, 2, '#4a3220'); } R(c, x + 32, 62, 1, 46, '#d8c8a0');
    limb(c, [[x - 22, 86], [x + 34, 84]], 1, '#c8a46a'); R(c, x + 33, 83, 4, 3, '#9a9a9a'); R(c, x - 11, 82, 1, 8, bh); R(c, x - 6, 92, 1, 14, bh); R(c, x - 5, 115, 1, 26, bh);
    for (let lx = 150; lx < AVENIDA.W; lx += 300) lampPost(c, lx, 104);
    ponto(c, 1160); banca(c, 1830); orelhao(c, 1100); lixeira(c, 1220); lixeira(c, 1880, '#3c8a5a'); hidrante(c, 2400); placaRua(c, 1050); bike(c, 2300, '#c43c3a');
    objetos(c, 16, AVENIDA.W, 'cidade', 30, 1300); objetos(c, 16, AVENIDA.W, 'cidade', 1700, AVENIDA.W - 30); calcada(c, AVENIDA.W); asfalto(c, AVENIDA.W, [1340, 1640]); chaoDetalhe(c, AVENIDA.W, 'cidade');
    return cv;
  }
  let aveMid = null;
  function avenida(c, s, t, camL) {
    if (!aveMid) aveMid = buildAvenida();
    conquistaBack(c, s, t, camL, { seed: 9 });
    // faixas do fundo com trânsito (carros, ônibus e motos) e semáforos
    R(c, 0, 184, LW, 20, '#5d6164'); R(c, 0, 193, LW, 1, '#e8dc8a'); R(c, 0, 184, LW, 1, '#7a7e80');
    for (let i = 0; i < 11; i++) { const dir = i % 2 ? 1 : -1, sp = 40 + (i % 3) * 18, wx = ((i * 337 + t * sp * dir) % 3300 + 3300) % 3300 - 150, sx = wx - camL * .9; if (!vis(sx, 60)) continue;
      if (i % 4 === 3) { R(c, sx, 172, 56, 18, '#3c7aa8'); R(c, sx + 2, 174, 52, 6, '#a9ccd8'); R(c, sx, 184, 56, 2, '#f2efe6'); ell(c, sx + 8, 192, 3, 3, '#1c1c1c'); ell(c, sx + 46, 192, 3, 3, '#1c1c1c'); }
      else if (i % 3 === 2) { ell(c, sx + 2, 191, 3, 3, '#1c1c1c'); ell(c, sx + 12, 191, 3, 3, '#1c1c1c'); R(c, sx + 2, 185, 11, 4, pick(['#c43c3a', '#f08a24'], i)); R(c, sx + 5, 178, 5, 7, pick(['#c43c3a', '#f08a24'], i)); R(c, sx + 5, 175, 5, 3, '#c43c3a'); }
      else carro(c, sx, dir > 0 ? 192 : 200, pick(['#c43c3a', '#f2f2ee', '#3c6aa8', '#2a2a2a', '#9aa0a6', '#e8c24c'], i), dir); }
    c.drawImage(aveMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (const x of [600, 1200, 1800, 2400]) { const sx = x - camL; if (vis(sx, 20)) { R(c, sx, 118, 3, 92, '#3c4044'); R(c, sx - 3, 110, 9, 22, '#2a2e30'); const ph = Math.floor((t + x) / 4) % 3; ['#d8443a', '#e8c24c', '#4ac07a'].forEach((col, k) => R(c, sx - 1, 112 + k * 6, 5, 4, ph === k ? col : '#3a3a3a')); } }
    for (const x of [1360, 1640]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 204, .75, 1, t, x); }
    for (const x of [700, 2250]) { const sx = x - camL; if (vis(sx, 60)) ipe(c, sx, 210, x === 700 ? '#e8c84a' : '#b86ac8', x, .85); }
    for (let i = 0; i < 10; i++) { const wx = 100 + i * 290 + Math.sin(t * .3 + i) * 40, sx = wx - camL; if (vis(sx, 20)) gente(c, sx, 216, i); }
    for (let i = 0; i < 4; i++) { const dir = i % 2 ? 1 : -1, wx = ((i * 777 + t * (70 + i * 10) * dir) % 3400 + 3400) % 3400 - 200, sx = wx - camL; if (vis(sx, 40)) carro(c, sx, dir > 0 ? 240 : 258, pick(['#f2f2ee', '#2a2a2a', '#c43c3a', '#3c8a5a'], i + 2), dir); }
    fog(c, s, t, camL, .18);
  }
  function avenidaLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let x = 150; x < AVENIDA.W; x += 300) lampGlow(g, x - camL + 1, 100, a, '255,210,150', 80); const ix = AVENIDA.INDIO - camL; if (vis(ix, 120)) { const gr = g.createLinearGradient(0, 200, 0, 50); gr.addColorStop(0, `rgba(255,220,150,${.4 * a})`); gr.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gr; g.fillRect(ix - 30, 50, 60, 150); } for (const bx of [620, 2140]) { const sx = bx - camL; if (vis(sx, 130)) { g.fillStyle = `rgba(255,250,230,${.3 * a})`; g.fillRect(sx + 3, 59, 114, 48); } } }

  /* =====================================================================
     17 · FEIRA E BISCOITARIAS
     ===================================================================== */
  const FEIRA = { W: 2200, BISC: [380, 1240, 1900] };
  function barraca(c, x, w, tarp, goods, seed) {
    R(c, x, 116, 2, 94, '#6a5a44'); R(c, x + w - 2, 116, 2, 94, '#6a5a44'); for (let k = 0; k < w; k++) { const yy = 110 + Math.round(Math.sin(k / w * Math.PI) * -6); R(c, x + k, yy, 1, 11, tarp); if (k % 6 < 3) R(c, x + k, yy + 9, 1, 2, shadeHex(tarp, .75)); } R(c, x, 121, w, 2, shadeHex(tarp, .65));
    for (let k = 0; k < w - 8; k += 6) { limb(c, [[x + 4 + k, 123], [x + 4 + k, 128]], 1, '#5a4a34'); if (hash(k + seed) > .5) ell(c, x + 4 + k, 132, 3, 4, pick(['#e8c24c', '#7cbf6a', '#d9634a'], k + seed)); }
    R(c, x + 2, 166, w - 4, 10, '#8a6a45'); R(c, x + 2, 166, w - 4, 2, '#c4955c'); R(c, x + 4, 176, w - 8, 34, '#6a4a32'); for (let k = 0; k < w - 8; k += 8) R(c, x + 4 + k, 176, 1, 34, '#5a3a22');
    for (let k = 0; k < (w - 8) / 7; k++) { const gx = x + 6 + k * 7, g = goods[(k + seed) % goods.length]; ell(c, gx + 3, 162, 3.5, 3, g); ell(c, gx + 3, 158, 2.5, 2, g); R(c, gx + 2, 157, 2, 1, '#ffffff66'); }
    R(c, x + 8, 146, 18, 10, '#f2ece0'); R(c, x + 10, 149, 12, 1, '#c43c3a'); R(c, x + 10, 152, 8, 1, '#2a2a2a');
    R(c, x + w - 20, 150, 12, 3, '#c8c8c4'); R(c, x + w - 15, 153, 2, 10, '#8a8a86'); R(c, x + w - 18, 163, 8, 3, '#8a8a86'); // balança
    for (let k = 0; k < 2; k++) { R(c, x + 6 + k * 18, GY - 12, 14, 12, '#a87a48'); R(c, x + 6 + k * 18, GY - 12, 14, 2, '#c4955c'); for (let j = 0; j < 3; j++) ell(c, x + 9 + k * 18 + j * 4, GY - 13, 2, 2, goods[(j + k + seed) % goods.length]); }
  }
  function buildFeira() {
    const [cv, c] = mk(FEIRA.W, LH);
    for (let i = 0, x = 6; x < FEIRA.W; i++) { const w = 120 + Math.round(hash(i + 900) * 40); predio(c, x, w, 2 + Math.round(hash(i + 901) * 2), pick(['#ece4cf', '#dde4d4', '#f2e4d8', '#e4dccb'], i), 900 + i); x += w + 8; }
    for (const bx of FEIRA.BISC) { predio(c, bx, 120, 3, '#f6ecd0', bx, { loja: true }); loja(c, bx, 120, '#c47a35', '#c47a35', '#f6ecd0', bx + 1); for (let k = 0; k < 6; k++) { R(c, bx + 12 + k * 17, GY - 26, 12, 16, '#e8e4dc'); R(c, bx + 13 + k * 17, GY - 22, 10, 11, '#f2dfa8'); for (let j = 0; j < 3; j++) R(c, bx + 14 + k * 17 + j * 3, GY - 20 + j * 3, 3, 2, '#fff3cf'); R(c, bx + 12 + k * 17, GY - 27, 12, 2, '#c43c3a'); } R(c, bx + 100, GY - 50, 16, 16, '#8a4a20'); ell(c, bx + 108, GY - 42, 5, 5, '#ffb04a'); }
    const tarps = ['#3c6aa8', '#e8833a', '#e8c24c', '#3c8a5a', '#c43c3a', '#7a3a8a'], goods = [['#e8c24c', '#7cbf6a', '#d9634a'], ['#f2a83a', '#e8d84c'], ['#7a3a2a', '#c49a6a', '#f2ece0'], ['#d9634a', '#3c8a3a'], ['#f2efe6', '#e8c24c', '#c49a6a']];
    for (let i = 0, x = 16; x < FEIRA.W - 60; i++, x += 92) { if (FEIRA.BISC.some((b) => x > b - 74 && x < b + 124)) continue; barraca(c, x, 82, tarps[i % tarps.length], goods[i % goods.length], i); }
    // gaiola de galinhas, sacos de grão, carrinho de mão e um gato dormindo
    for (const gx of [700, 1660]) { R(c, gx, GY - 18, 26, 18, '#8a6a45'); for (let k = 0; k < 26; k += 3) R(c, gx + k, GY - 18, 1, 18, '#5a4a34'); for (let k = 0; k < 3; k++) { R(c, gx + 3 + k * 8, GY - 10, 5, 5, '#f2efe6'); R(c, gx + 6 + k * 8, GY - 12, 2, 2, '#c43c3a'); } }
    for (let k = 0; k < 5; k++) { const sx = 1100 + k * 12; R(c, sx, GY - 14, 11, 14, '#d8c8a0'); R(c, sx + 1, GY - 16, 9, 3, '#c4b48c'); R(c, sx + 3, GY - 8, 5, 2, '#8a6a3a'); }
    R(c, 1500, GY - 10, 22, 8, '#5a6a72'); ell(c, 1520, GY - 2, 3, 3, '#1c1c1c'); limb(c, [[1500, GY - 8], [1490, GY - 16]], 1, '#5a4a34'); gato(c, 1180, GY - 14, '#d8a24a');
    for (let k = 0; k < 6; k++) bandeirinhas(c, 20 + k * 360, 360 + k * 360, 96, k);
    for (let lx = 60; lx < FEIRA.W; lx += 300) poste(c, lx);
    pedraPortuguesa(c, FEIRA.W, 210); R(c, 0, 210, FEIRA.W, 2, '#c8c2b0'); chaoDetalhe(c, FEIRA.W, 'cidade');
    return cv;
  }
  let feiraMid = null;
  function feira(c, s, t, camL) {
    if (!feiraMid) feiraMid = buildFeira();
    conquistaBack(c, s, t, camL, { seed: 11 });
    c.drawImage(feiraMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (let i = 0; i < 20; i++) { const wx = 40 + i * 110 + Math.sin(t * .4 + i * 1.7) * 40, sx = wx - camL; if (vis(sx, 20)) { gente(c, sx, 214, i); if (i % 3 === 0) { R(c, sx + 6, 204, 5, 6, '#f2efe6'); R(c, sx + 7, 205, 3, 2, '#7cbf6a'); } } }
    for (const bx of FEIRA.BISC) { const x = bx + 108 - camL; if (!vis(x, 80)) continue; for (let i = 0; i < 6; i++) { const k = (t * .25 + i / 6) % 1; R(c, x - 6 + Math.sin(t + i) * 3, 150 - k * 30, 3 + k * 3, 2, `rgba(255,248,232,${(1 - k) * .5})`); } }
    for (const gx of [700, 1660]) { const sx = gx - camL; if (vis(sx, 30)) for (let k = 0; k < 3; k++) R(c, sx + 6 + k * 8, GY - 12 - (Math.sin(t * 6 + k) > .7 ? 1 : 0), 2, 2, '#c43c3a'); }
    fog(c, s, t, camL, .18);
  }
  function feiraLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let x = 58; x < FEIRA.W; x += 92) { const sx = x - camL; if (vis(sx)) { g.fillStyle = `rgba(255,220,150,${.35 * a})`; g.fillRect(sx - 30, 124, 60, 50); lightAdd(sx, 120, a * .5, 60); } } }

  /* =====================================================================
     18 · FAZENDAS DE CAFÉ DO PLANALTO
     ===================================================================== */
  const CAFE = { W: 2600 };
  function buildCafe() {
    const [cv, c] = mk(CAFE.W, LH);
    for (let row = 0; row < 8; row++) { const y = 112 + row * 11; for (let x = 0; x < CAFE.W; x += 7) { const yy = y + Math.round(Math.sin(x * .01 + row) * 3); ell(c, x, yy, 5, 5, row % 2 ? '#2f5a34' : '#3a6a3c'); ell(c, x - 1, yy - 2, 3, 2, '#4f8a4a'); if (hash(x + row * 99) > .7) R(c, x + 1, yy + 1, 2, 2, '#c43c3a'); if (hash(x + row * 77) > .85) R(c, x - 2, yy, 2, 2, '#e8c24c'); } }
    for (let x = 10, i = 0; x < CAFE.W; i++, x += 16 + Math.round(hash(i + 3000) * 26)) { const h = 40 + Math.round(hash(i + 3001) * 34), top = 116 - h; R(c, x, top, 2, h, '#d8ccb6'); R(c, x, top, 1, h, '#b8ac96'); for (let k = 0; k < 6; k++) ell(c, x + 1 + (hash(i * 7 + k) - .5) * 10, top + 4 + k * 5, 4 + hash(i * 3 + k) * 4, 4 + hash(i + k) * 3, k % 2 ? '#5a7a5a' : '#6f8f6a'); ell(c, x - 1, top + 2, 3, 3, '#8aa682'); }
    // sede da fazenda com varanda, rede e bancos
    const hx = 260; plaster(c, hx, 126, 180, 84, '#f2ece0', 260); roofTiles(c, hx - 8, 114, 196, 12, '#8a4430'); for (let k = 0; k < 6; k++) { R(c, hx + 10 + k * 28, 160, 4, 50, '#8a6a45'); janela(c, hx + 14 + k * 28, 134, 12, 14, 'veneziana', 260 + k); } R(c, hx, 158, 180, 3, '#c4955c');
    for (let k = 0; k < 20; k++) R(c, hx + 60 + k * 2, 176 + Math.round(Math.sin(k / 19 * Math.PI) * 6), 2, 2, '#c43c3a'); for (let k = 0; k < 4; k++) plantaVaso(c, hx + 6 + k * 50, GY, k + 270);
    caixaDagua(c, hx + 140, 92, 1);
    // terreiro de secagem com grãos em linhas, rodo e sacas de café
    R(c, 700, 196, 520, 14, '#cfcac0'); for (let k = 0; k < 520; k += 2) { const yy = 198 + Math.round(Math.sin(k * .2) * 2); R(c, 700 + k, yy, 2, 6, k % 8 < 4 ? '#7a4a2a' : '#5a3420'); } limb(c, [[820, 196], [840, 176]], 1, '#8a6a45'); R(c, 814, 195, 12, 2, '#5a4a34');
    for (let k = 0; k < 6; k++) { const sx = 1230 + (k % 3) * 14, sy = GY - 14 - Math.floor(k / 3) * 12; R(c, sx, sy, 13, 13, '#d8c8a0'); R(c, sx + 1, sy - 2, 11, 3, '#c4b48c'); R(c, sx + 3, sy + 4, 7, 3, '#5a3420'); }
    // galpão com secador rotativo e descascadora
    const gx = 1400; R(c, gx - 6, 104, 312, 6, '#7a7f84'); for (let k = 0; k < 312; k += 8) R(c, gx - 6 + k, 100, 6, 4, '#9aa0a6'); R(c, gx, 110, 4, 100, '#7a7f84'); R(c, gx + 296, 110, 4, 100, '#7a7f84');
    R(c, gx + 30, 150, 110, 44, '#4a5a64'); for (let k = 0; k < 110; k += 8) R(c, gx + 30 + k, 150, 2, 44, '#3a4852'); R(c, gx + 30, 150, 110, 3, '#8a9aa4'); R(c, gx + 40, 194, 6, 16, '#2a2a2a'); R(c, gx + 124, 194, 6, 16, '#2a2a2a');
    R(c, gx + 180, 140, 70, 60, '#c47a35'); R(c, gx + 184, 144, 62, 20, '#e8a24c'); R(c, gx + 196, 120, 14, 22, '#9aa0a6'); R(c, gx + 230, 200, 30, 10, '#5a3420');
    // trator vermelho, poço, cerca e galinhas
    const tx = 1820; R(c, tx, 178, 40, 16, '#c43c3a'); R(c, tx + 26, 164, 16, 16, '#c43c3a'); R(c, tx + 28, 166, 12, 8, '#9fc4d0'); R(c, tx + 8, 172, 3, 8, '#5a5a56'); ell(c, tx + 34, 198, 11, 11, '#1c1c1c'); ell(c, tx + 34, 198, 5, 5, '#e8c24c'); ell(c, tx + 8, 202, 7, 7, '#1c1c1c'); ell(c, tx + 8, 202, 3, 3, '#e8c24c');
    R(c, 2060, 184, 26, 26, '#9a948a'); R(c, 2058, 182, 30, 4, '#b4aea2'); R(c, 2060, 150, 3, 32, '#6a4a32'); R(c, 2083, 150, 3, 32, '#6a4a32'); R(c, 2058, 148, 30, 4, '#8a4430'); R(c, 2071, 152, 1, 18, '#3a3a36'); R(c, 2068, 170, 7, 6, '#8a6a45');
    for (let x = 2110; x < CAFE.W; x += 16) { R(c, x, 188, 3, 22, '#8a6a45'); } R(c, 2110, 192, CAFE.W - 2110, 2, '#a07a4a'); R(c, 2110, 202, CAFE.W - 2110, 2, '#a07a4a');
    R(c, 2300, 70, 50, 34, '#3c6aa8'); R(c, 2300, 70, 50, 3, '#8ab4d8'); for (const k of [2304, 2342]) R(c, k, 104, 3, 106, '#7a7f84');
    objetos(c, 18, CAFE.W, 'natureza', 40, 680, [70, 140]); objetos(c, 18, CAFE.W, 'natureza', 2400, CAFE.W - 30, [60, 120]); terra(c, CAFE.W, '#6a8a46', '#577238'); chaoDetalhe(c, CAFE.W, 'natureza');
    return cv;
  }
  let cafeMid = null;
  function cafe(c, s, t, camL) {
    if (!cafeMid) cafeMid = buildCafe(); if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); tile(c, FAR.ridge, camL * .02); haze(c, s, t, camL, 100, 160); tile(c, FAR.trees, camL * .08); passaros(c, t, camL, 5, 7);
    c.drawImage(cafeMid, camL, 0, LW, LH, 0, 0, LW, LH);
    { const x = 1400 + 85 - camL; if (vis(x, 80)) for (let k = 0; k < 6; k++) { const a = t * 2 + k; R(c, x + Math.cos(a) * 18, 172 + Math.sin(a) * 8, 3, 3, '#c8d0d4'); } }
    for (let x = ((-camL % 40) + 40) % 40 - 40; x < LW + 40; x += 40) { const wx = x + camL; if (hash(Math.floor(wx / 40)) > .55) { ell(c, x, 212, 10, 9, '#2f5a34'); ell(c, x - 2, 208, 7, 6, '#3f7a44'); for (let k = 0; k < 4; k++) R(c, x - 6 + k * 4, 210 - (k % 2) * 4, 2, 2, '#d8443a'); } }
    for (let i = 0; i < 5; i++) { const wx = 760 + i * 120 + Math.sin(t * .3 + i) * 30, sx = wx - camL; if (vis(sx, 20)) { gente(c, sx, 210, i + 2, false); R(c, sx + 5, 196, 1, 14, '#8a6a45'); R(c, sx + 2, 196, 7, 2, '#8a6a45'); } }
    for (let i = 0; i < 4; i++) { const wx = 2160 + i * 40 + Math.sin(t * .8 + i * 2) * 20, sx = wx - camL, hop = Math.max(0, Math.sin(t * 5 + i)) * 2; if (vis(sx, 10)) { R(c, sx, 212 - hop, 6, 5, '#f2efe6'); R(c, sx + 4, 209 - hop, 3, 3, '#f2efe6'); R(c, sx + 5, 208 - hop, 2, 1, '#c43c3a'); R(c, sx + 7, 210 - hop, 1, 1, '#e8c24c'); } }
    fog(c, s, t, camL, .45);
  }
  function cafeLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let k = 0; k < 6; k++) { const sx = 260 + 20 + k * 28 - camL; if (vis(sx)) { g.fillStyle = `rgba(255,214,140,${.55 * a})`; g.fillRect(sx - 6, 134, 12, 14); lightAdd(sx, 140, a * .4, 40); } } }

  /* =====================================================================
     19 · TEATRO GLAUBER ROCHA, CENTRO DE CULTURA E PLANETÁRIO (noturna)
     ===================================================================== */
  const CULTURA = { W: 2200, TEATRO: 600, DOME: 1500 };
  function buildCultura() {
    const [cv, c] = mk(CULTURA.W, LH);
    for (let i = 0, x = 10; x < CULTURA.W; i++) { const w = 60 + Math.round(hash(i + 170) * 40); predio(c, x, w, 4 + Math.round(hash(i + 171) * 3), pick(['#e9e6dc', '#cfd6dc', '#ddd3bf'], i), 170 + i); x += w + 70; }
    // Centro de Cultura: bloco cinza moderno com letreiro, árvores e vagas (como na foto)
    R(c, 110, 106, 250, 104, '#8a9094'); R(c, 110, 106, 250, 4, '#b8bec2'); for (let k = 0; k < 250; k += 24) R(c, 110 + k, 110, 2, 100, '#7a8084'); R(c, 130, 118, 130, 28, '#5f6569'); R(c, 230, 170, 60, 40, '#2c3a44'); R(c, 232, 172, 56, 36, '#9fc4d0');
    for (let k = 0; k < 3; k++) cartaz(c, 300 + k * 16, 150, 170 + k);
    // Teatro: marquise de lâmpadas, cartazes e bilheteria
    const tx = CULTURA.TEATRO; brick(c, tx, 86, 300, 124, '#b08a5a', 600); R(c, tx - 10, 138, 320, 12, '#3a2a2a'); for (let k = 0; k < 4; k++) { R(c, tx + 20 + k * 70, 158, 44, 52, '#2a2a34'); R(c, tx + 22 + k * 70, 160, 40, 30, ['#c43c3a', '#3c6aa8', '#e8c24c', '#7a3a8a'][k]); R(c, tx + 26 + k * 70, 164, 32, 6, '#f2efe6'); R(c, tx + 26 + k * 70, 174, 22, 10, shadeHex(['#c43c3a', '#3c6aa8', '#e8c24c', '#7a3a8a'][k], .7)); }
    R(c, tx + 40, 96, 220, 34, '#2a2a34'); R(c, tx + 42, 98, 216, 30, '#4a2a2a'); R(c, tx + 130, 190, 40, 20, '#c43c3a'); R(c, tx + 134, 192, 32, 8, '#f2e8d0');
    // food trucks de pipoca e cachorro-quente
    for (const [fx, col] of [[960, '#e8c24c'], [1080, '#c43c3a']]) { R(c, fx, 166, 80, 38, col); R(c, fx + 6, 172, 40, 18, '#2a2a34'); R(c, fx + 8, 174, 36, 14, '#f2e8d0'); R(c, fx, 164, 80, 3, shadeHex(col, 1.2)); ell(c, fx + 14, 206, 5, 5, '#1c1c1c'); ell(c, fx + 64, 206, 5, 5, '#1c1c1c'); R(c, fx + 52, 170, 22, 6, '#f2efe6'); }
    // Planetário: cúpula branca com estrelas pintadas
    const dx = CULTURA.DOME; for (let k = 0; k < 60; k++) { const w = Math.round(Math.sqrt(1 - (k / 60) ** 2) * 110); R(c, dx - w, 150 - k, w * 2, 1, k % 6 ? '#eef0f2' : '#d8dce0'); } R(c, dx - 112, 150, 224, 60, '#d8dce0'); for (let k = 0; k < 24; k++) R(c, dx - 100 + k * 9, 160 + (k % 3) * 9, 2, 2, '#3c4a6a'); R(c, dx - 20, 176, 40, 34, '#2c3a44');
    for (let k = 0; k < 7; k++) { const a = -Math.PI + k * .5, rx = dx + Math.cos(a) * 80, ry = 130 + Math.sin(a) * 40; R(c, rx, ry, 3, 3, '#f2c94c'); }
    // busto do cineasta, bancos e canteiros
    R(c, 1260, 180, 16, 30, '#8a8478'); R(c, 1262, 170, 12, 12, '#6a5a4a'); R(c, 1260, 162, 16, 10, '#7a6a58');
    for (const bx of [1820, 1960]) canteiro(c, bx, 60);
    for (let lx = 100; lx < CULTURA.W; lx += 260) lampPost(c, lx, 120);
    bandeirinhas(c, CULTURA.TEATRO - 20, CULTURA.TEATRO + 320, 80, 19);
    objetos(c, 19, CULTURA.W, 'cidade', 1700, CULTURA.W - 30); pedraPortuguesa(c, CULTURA.W, 210); R(c, 0, 210, CULTURA.W, 2, '#c8c2b0'); chaoDetalhe(c, CULTURA.W, 'cidade');
    return cv;
  }
  let culturaMid = null;
  function cultura(c, s, t, camL) {
    if (!culturaMid) culturaMid = buildCultura();
    conquistaBack(c, s, t, camL, { seed: 13 });
    const a = night(s); if (a > .05) for (let i = 0; i < 50; i++) { const x = (hash(i + 400) * 600 - camL * .02) % LW, y = hash(i + 401) * 100; if (Math.sin(t * 2 + i) > -.2) R(c, x, y, 1, 1, `rgba(255,255,240,${a})`); }
    c.drawImage(culturaMid, camL, 0, LW, LH, 0, 0, LW, LH);
    { const tx = CULTURA.TEATRO - camL; if (vis(tx, 340)) for (let k = 0; k < 320; k += 8) R(c, tx - 8 + k, 142, 3, 3, (Math.floor(t * 6) + k / 8) % 3 ? '#ffe39a' : '#8a6a3a'); }
    for (const x of [640, 860]) { const sx = x - camL; if (!vis(sx, 120) || a < .05) continue; const ang = Math.sin(t * .6 + x) * .5; c.fillStyle = `rgba(255,250,220,${.08 * a})`; c.beginPath(); c.moveTo(sx, 140); c.lineTo(sx + Math.sin(ang) * 260 - 20, -10); c.lineTo(sx + Math.sin(ang) * 260 + 20, -10); c.closePath(); c.fill(); }
    for (const x of [420, 1180, 1800]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 214, .85, 1, t, x); }
    for (let i = 0; i < 12; i++) { const wx = 520 + i * 100 + Math.sin(t * .3 + i) * 14, sx = wx - camL; if (vis(sx, 20)) gente(c, sx, 214, i); }
    { const x = 1000 - camL; if (vis(x, 40)) for (let i = 0; i < 4; i++) { const k = (t * .5 + i / 4) % 1; R(c, x + Math.sin(i * 2) * 4, 160 - k * 18, 2, 2, `rgba(255,250,220,${1 - k})`); } }
  }
  function culturaLights(g, s, t, camL) { const a = Math.max(.35, night(s)); const tx = CULTURA.TEATRO - camL; if (vis(tx, 340)) { g.fillStyle = `rgba(255,227,154,${.45 * a})`; g.fillRect(tx - 10, 138, 320, 14); lightAdd(tx + 150, 140, a * .7, 160); const gr = g.createLinearGradient(0, 150, 0, 214); gr.addColorStop(0, `rgba(255,220,150,${.35 * a})`); gr.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gr; g.fillRect(tx - 10, 150, 320, 64); } const dx = CULTURA.DOME - camL; if (vis(dx, 140)) { const gr = g.createRadialGradient(dx, 110, 10, dx, 110, 130); gr.addColorStop(0, `rgba(170,200,255,${.25 * a})`); gr.addColorStop(1, 'rgba(170,200,255,0)'); g.fillStyle = gr; g.fillRect(dx - 130, 0, 260, 214); } for (let x = 100; x < CULTURA.W; x += 260) lampGlow(g, x - camL, 120, a); for (const fx of [960, 1080]) { const sx = fx + 26 - camL; if (vis(sx)) { g.fillStyle = `rgba(255,236,190,${.4 * a})`; g.fillRect(sx - 20, 172, 40, 18); } } }

  /* =====================================================================
     20 · SHOPPING
     ===================================================================== */
  const SHOP = { W: 2400, ESC: 600, FOOD: 720, CINE: 1120, ELEV: 1508, FONTE: 1556, LAN: 1640, MZ: 96, TOP: 114 };
  const SIGNS = ['#c43c3a', '#2c5a9e', '#e8833a', '#7a3a8a', '#2f7a4a', '#1e2228', '#c8a24a', '#d84a7a'];
  const SHIRT = ['#3a4a6a', '#7a3a3a', '#4a6a4a', '#5a4a6a', '#c47a35', '#2a3a4a', '#e8c24c', '#3c8ad8'], SKIN = ['#e0b08a', '#9a6440', '#c88a60', '#6a4430', '#f0c8a8'];
  const hexRGB = (h) => [parseInt(h.slice(1, 3), 16) / 255, parseInt(h.slice(3, 5), 16) / 255, parseInt(h.slice(5, 7), 16) / 255];
  const lerpC = (a, b, k) => K.css(mix(hexRGB(a), hexRGB(b), cl(k)));
  function vgrad(c, x, y, w, h, a, b) { for (let k = 0; k < h; k++) R(c, x, y + k, w, 1, lerpC(a, b, k / Math.max(1, h - 1))); }
  function coluna(c, x, y0, y1, w = 10) { // coluna cilíndrica: faixas de luz e sombra, capitel e base
    const band = ['#8f8b82', '#b4b0a5', '#d8d4c8', '#f2efe6', '#fbf9f2', '#e6e2d6', '#c4c0b4', '#a09c92'];
    for (let k = 0; k < w; k++) R(c, x + k, y0, 1, y1 - y0, band[Math.min(band.length - 1, Math.floor(k / w * band.length))]);
    R(c, x - 2, y0, w + 4, 3, '#f6f2e8'); R(c, x - 2, y0 + 3, w + 4, 1, '#9a968c'); R(c, x - 2, y1 - 4, w + 4, 4, '#dcd8cc'); R(c, x - 2, y1 - 4, w + 4, 1, '#f6f2e8');
  }
  function reflexo(c, x, y, w, h) { // vidro: brilho no alto e faixas diagonais
    for (let k = 0; k < Math.round(h * .35); k++) R(c, x, y + k, w, 1, `rgba(255,255,255,${.16 * (1 - k / (h * .35))})`);
    for (let k = 6; k < w + h; k += 34) { limb(c, [[x + k, y], [x + k - h * .6, y + h]].map(([px, py]) => [Math.max(x, Math.min(x + w - 2, px)), py]), 3, 'rgba(255,255,255,.13)'); limb(c, [[x + k + 6, y], [x + k + 6 - h * .6, y + h]].map(([px, py]) => [Math.max(x, Math.min(x + w - 1, px)), py]), 1, 'rgba(255,255,255,.22)'); }
  }
  function pessoa(c, x, y, i) { // gente pequena com sombreado (2 tons) e sacola
    const sh = SHIRT[i % SHIRT.length], sk = SKIN[i % SKIN.length];
    R(c, x, y - 6, 2, 6, '#2a2f3a'); R(c, x + 3, y - 6, 2, 6, '#232833'); R(c, x - 1, y - 14, 7, 9, sh); R(c, x + 4, y - 14, 2, 9, shadeHex(sh, .75)); R(c, x - 1, y - 14, 7, 1, shadeHex(sh, 1.2));
    R(c, x, y - 19, 5, 5, sk); R(c, x + 3, y - 18, 2, 4, shadeHex(sk, .85)); R(c, x, y - 20, 5, 2, pick(['#2a201a', '#4a3226', '#1a1a1a', '#c8a050'], i)); R(c, x - 1, y, 7, 1, 'rgba(0,0,0,.18)');
    if (i % 3 !== 1) { R(c, x + 6, y - 9, 4, 6, pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#d84a7a', '#f2efe6'], i)); R(c, x + 7, y - 11, 2, 2, '#5a5a5a'); }
  }

  /* ---------- fundo: o átrio do shopping visto de longe ---------- */
  let SHOPFAR = null;
  function buildShopFar() {
    const T = 964, [cv, c] = mk(T, LH);
    vgrad(c, 0, 0, T, 125, '#efe9dc', '#e2dbcc');
    const LV = [{ y: 26, h: 24 }, { y: 55, h: 27 }, { y: 87, h: 30 }];
    LV.forEach((L, li) => {
      for (let x = 0, i = 0; x < T; i++) {
        const w = 28 + Math.round(hash(i * 3 + li * 50) * 18), sig = pick(SIGNS, i + li * 5);
        R(c, x, L.y, w, L.h, '#5e626a'); R(c, x + 1, L.y + 1, w - 2, 4, sig); R(c, x + 1, L.y + 1, w - 2, 1, '#ffffff55');
        vgrad(c, x + 2, L.y + 6, w - 4, L.h - 7, '#fff7e4', '#e8dcc2');
        const tipo = Math.floor(hash(i * 7 + li) * 3);
        if (tipo === 0) { for (const sy of [L.y + 11, L.y + 17]) { R(c, x + 3, sy, w - 6, 1, '#c8b89c'); for (let k = 0; k < (w - 8) / 6; k++) if (hash(k + i * 5 + sy) > .35) R(c, x + 4 + k * 6, sy - 3, 3, 3, pick(['#c88a6a', '#8aa0b8', '#d8c07a', '#8ab08a'], k + i)); } }
        else if (tipo === 1) { R(c, x + 3, L.y + 7, w - 6, L.h - 9, '#8a9aa6'); R(c, x + 4, L.y + 8, w - 8, 3, '#b8c8d0'); for (let k = 4; k < w - 8; k += 9) R(c, x + k, L.y + 13, 4, 6, pick(['#d8c8b0', '#c8b8a0', '#e0d0b8'], k)); }
        else { for (let k = 0; k < w - 4; k += 4) R(c, x + 2 + k, L.y + 5, 4, 3, (k / 4) % 2 ? sig : '#f2efe6'); for (let k = 0; k < 2; k++) R(c, x + 5 + k * (w - 16), L.y + 10, 6, 9, pick(['#c88a6a', '#8aa0b8', '#b88aa0'], k + i)); }
        R(c, x + Math.round(w / 2) - 4, L.y + L.h - 10, 8, 10, '#3a3630'); R(c, x + Math.round(w / 2) - 3, L.y + L.h - 9, 2, 9, '#5a544a');
        x += w + 1; if (i % 4 === 3) { coluna(c, x, L.y - 2, L.y + L.h + 4, 6); x += 8; }
      }
      R(c, 0, L.y + L.h, T, 3, '#f6f3ec'); R(c, 0, L.y + L.h + 3, T, 2, '#aaa293');
      R(c, 0, L.y + L.h - 7, T, 7, 'rgba(185,222,234,.55)'); R(c, 0, L.y + L.h - 8, T, 1, '#e2e8ea'); for (let x = 0; x < T; x += 10) R(c, x, L.y + L.h - 7, 1, 7, '#b8c4ca');
      for (let k = 0; k < 18; k++) { const px = Math.round(hash(k + li * 31) * T), i = k + li; R(c, px, L.y + L.h - 10, 3, 4, pick(SHIRT, i)); R(c, px, L.y + L.h - 12, 3, 2, pick(SKIN, i)); }
    });
    // escadas rolantes cruzando o vão entre os andares
    for (const [ex, y0, y1] of [[160, 84, 54], [610, 84, 54], [380, 54, 28], [820, 54, 28]]) { const n = y0 - y1; for (let k = 0; k <= n; k += 2) { R(c, ex + k, y0 - k, 5, 2, '#b8c0c6'); R(c, ex + k, y0 - k + 2, 5, 1, '#7a848c'); } limb(c, [[ex - 1, y0 - 3], [ex + n - 1, y1 - 3]], 1, '#2a2a2a'); c.fillStyle = 'rgba(185,222,234,.35)'; c.beginPath(); c.moveTo(ex, y0); c.lineTo(ex + n + 5, y1); c.lineTo(ex + n + 5, y1 + 6); c.lineTo(ex + 5, y0 + 4); c.closePath(); c.fill(); }
    // névoa clara: deixa o átrio lá longe
    c.fillStyle = 'rgba(242,238,230,.30)'; c.fillRect(0, 0, T, 125);
    // cobertura de vidro com treliça (o céu aparece entre os vidros)
    R(c, 0, 0, T, 20, '#c9cfd4'); for (let x = 0; x < T; x += 32) { c.clearRect(x + 2, 0, 28, 14); R(c, x + 2, 0, 28, 14, 'rgba(205,234,248,.30)'); R(c, x + 3, 1, 9, 12, 'rgba(255,255,255,.18)'); R(c, x, 0, 2, 16, '#7f8c96'); }
    R(c, 0, 14, T, 2, '#7a8892'); R(c, 0, 21, T, 2, '#7a8892'); for (let x = 0; x < T; x += 8) limb(c, [[x, 16], [x + 4, 21], [x + 8, 16]], 1, '#98a4ae');
    return cv;
  }

  /* ---------- frente: lojas do térreo ---------- */
  function produtos(c, kind, x, y, w, h, i) {
    const P = (j) => pick(['#d9634a', '#3c6aa8', '#e8c24c', '#3c8a5a', '#c86ab8', '#2a2a2a', '#f2efe6', '#e8833a'], i * 7 + j);
    const prateleira = (yy) => { R(c, x + 3, yy, w - 6, 2, '#b8a48a'); R(c, x + 3, yy + 2, w - 6, 1, '#7a6a52'); };
    if (kind === 'MODA') {
      R(c, x + 4, y + 4, w - 8, 1, '#7a7a76'); for (let j = 0; j < (w - 14) / 7; j++) { const gx = x + 6 + j * 7, col = P(j); R(c, gx + 2, y + 2, 1, 3, '#7a7a76'); R(c, gx, y + 5, 6, 15, col); R(c, gx, y + 5, 1, 15, shadeHex(col, 1.25)); R(c, gx + 5, y + 5, 1, 15, shadeHex(col, .72)); R(c, gx, y + 5, 6, 1, shadeHex(col, .8)); }
      for (const mx of [x + 10, x + w - 22]) { ell(c, mx + 6, y + 26, 3, 4, '#efe2d4'); R(c, mx + 1, y + 30, 10, 16, P(mx)); R(c, mx + 1, y + 30, 2, 16, shadeHex(P(mx), 1.3)); R(c, mx + 9, y + 30, 2, 16, shadeHex(P(mx), .7)); R(c, mx + 3, y + 46, 6, 10, '#3a4a6a'); R(c, mx + 5, y + 56, 2, 4, '#8a8a86'); R(c, mx + 2, y + 60, 8, 2, '#5a5a56'); }
    }
    if (kind === 'GAMES') {
      R(c, x + 6, y + 4, 52, 32, '#14161c'); R(c, x + 8, y + 6, 48, 28, '#6ab4e8'); R(c, x + 8, y + 24, 48, 10, '#5aa04a'); R(c, x + 8, y + 24, 48, 2, '#7ac85a'); ell(c, x + 40, y + 12, 4, 4, '#fff2a0'); R(c, x + 20, y + 16, 5, 8, '#e8433a'); R(c, x + 21, y + 14, 3, 3, '#f0c8a8'); R(c, x + 30, y + 36, 4, 4, '#2a2a2a');
      for (let j = 0; j < 12; j++) { const bx = x + 64 + (j % 4) * 13, by = y + 4 + Math.floor(j / 4) * 17, col = P(j); R(c, bx, by, 11, 15, col); R(c, bx, by, 11, 3, '#1e1e24'); R(c, bx + 1, by + 5, 9, 6, shadeHex(col, 1.3)); R(c, bx + 10, by, 1, 15, shadeHex(col, .6)); }
      R(c, x + 10, y + 44, 30, 10, '#1e2026'); R(c, x + 12, y + 46, 26, 2, '#3a3c46'); R(c, x + 16, y + 49, 4, 3, '#2c5a9e'); R(c, x + 30, y + 49, 3, 3, '#c43c3a');
    }
    if (kind === 'TÊNIS' || kind === 'LIVROS') for (let r = 0; r < 4; r++) prateleira(y + 14 + r * 13);
    if (kind === 'TÊNIS') for (let r = 0; r < 4; r++) for (let j = 0; j < (w - 12) / 14; j++) { const sx = x + 6 + j * 14, sy = y + 6 + r * 13, col = P(j + r * 3); R(c, sx, sy + 4, 11, 3, col); R(c, sx + 5, sy + 1, 6, 4, col); R(c, sx, sy + 7, 11, 2, '#f6f4ee'); R(c, sx + 2, sy + 5, 6, 1, '#f6f4ee'); R(c, sx + 9, sy + 1, 2, 2, shadeHex(col, .7)); }
    if (kind === 'LIVROS') for (let r = 0; r < 4; r++) for (let k = x + 5; k < x + w - 6; k += 3) { const hh = 7 + Math.round(hash(k + r * 7) * 4), col = P(k + r); R(c, k, y + 14 + r * 13 - hh, 3, hh, col); R(c, k, y + 14 + r * 13 - hh, 1, hh, shadeHex(col, 1.3)); R(c, k, y + 16 + r * 13 - hh, 3, 1, '#f2e8c8'); }
    if (kind === 'PERFUMES') { vgrad(c, x + 4, y + 2, w - 8, h - 6, '#fff8ee', '#f2dccc'); for (let r = 0; r < 3; r++) { R(c, x + 6, y + 20 + r * 17, w - 12, 2, 'rgba(200,230,240,.8)'); R(c, x + 6, y + 22 + r * 17, w - 12, 1, '#c8b8a8'); for (let j = 0; j < (w - 16) / 11; j++) { const bx = x + 9 + j * 11, col = pick(['#e8a8c8', '#a8c8e8', '#f2d898', '#c8e8b8', '#d8b8e8', '#f0b890'], j + r + i); R(c, bx, y + 10 + r * 17, 7, 10, col); R(c, bx + 1, y + 11 + r * 17, 2, 7, 'rgba(255,255,255,.55)'); R(c, bx + 6, y + 10 + r * 17, 1, 10, shadeHex(col, .75)); R(c, bx + 2, y + 7 + r * 17, 3, 3, '#c8a24a'); R(c, bx + 2, y + 7 + r * 17, 1, 3, '#f2d898'); } } }
    if (kind === 'CHOCOLATE') { for (let r = 0; r < 3; r++) { prateleira(y + 16 + r * 15); for (let j = 0; j < (w - 12) / 10; j++) { const bx = x + 6 + j * 10, by = y + 6 + r * 15, col = pick(['#5a2e1a', '#7a3e22', '#c43c3a', '#e8c24c', '#d84a7a'], j + r); R(c, bx, by, 8, 10, col); R(c, bx + 1, by + 2, 6, 3, '#f2e2c8'); R(c, bx, by, 8, 1, shadeHex(col, 1.3)); } } ell(c, x + w - 22, y + 50, 12, 8, '#c43c3a'); ell(c, x + w - 22, y + 48, 10, 6, '#e84a4a'); R(c, x + w - 23, y + 40, 2, 16, '#f2c94c'); }
    if (kind === 'ELETRO') { for (let j = 0; j < 3; j++) { const tx = x + 6 + j * 40; R(c, tx, y + 4, 34, 22, '#14161c'); vgrad(c, tx + 2, y + 6, 30, 18, pick(['#5ab8e8', '#e8a83a', '#7ac85a'], j), '#1e2a3a'); R(c, tx + 15, y + 26, 4, 3, '#3a3a40'); } for (let j = 0; j < 3; j++) { const gx = x + 8 + j * 40; R(c, gx, y + 34, 26, 26, '#e8eaec'); R(c, gx, y + 34, 26, 2, '#ffffff'); ell(c, gx + 13, y + 48, 8, 8, '#9aa6ae'); ell(c, gx + 13, y + 48, 6, 6, '#c8e0ea'); R(c, gx + 18, y + 36, 6, 2, '#5ae070'); } }
    if (kind === 'BRINQUEDOS') { for (let r = 0; r < 2; r++) { prateleira(y + 24 + r * 22); for (let j = 0; j < (w - 14) / 16; j++) { const px = x + 8 + j * 16, py = y + 23 + r * 22, col = P(j + r * 4); ell(c, px + 6, py - 5, 6, 6, col); ell(c, px + 6, py - 13, 5, 5, col); R(c, px + 2, py - 18, 3, 3, col); R(c, px + 8, py - 18, 3, 3, col); ell(c, px + 6, py - 4, 3, 3, shadeHex(col, 1.3)); R(c, px + 4, py - 14, 1, 1, '#1a1a1a'); R(c, px + 8, py - 14, 1, 1, '#1a1a1a'); R(c, px + 5, py - 11, 3, 1, shadeHex(col, .6)); } }
      const ux = x + w - 34; ell(c, ux + 14, y + 52, 13, 12, '#b8864a'); ell(c, ux + 14, y + 34, 10, 9, '#b8864a'); ell(c, ux + 6, y + 26, 4, 4, '#b8864a'); ell(c, ux + 22, y + 26, 4, 4, '#b8864a'); ell(c, ux + 14, y + 37, 5, 4, '#e8c896'); ell(c, ux + 14, y + 52, 8, 7, '#d8a86a'); R(c, ux + 10, y + 31, 2, 2, '#1a1a1a'); R(c, ux + 17, y + 31, 2, 2, '#1a1a1a'); R(c, ux + 13, y + 35, 3, 2, '#3a2418'); R(c, ux + 6, y + 42, 16, 3, '#c43c3a'); }
  }
  function lojaFrente(c, x, w, kind, i) {
    const top = SHOP.TOP, bot = 210, sig = pick(SIGNS, i + 2);
    R(c, x, top, w, bot - top, '#454951'); for (let k = 0; k < w * (bot - top) / 10; k++) R(c, x + hash(k + i * 99) * w, top + hash(k * 3 + i) * (bot - top), 1, 1, k % 3 ? '#52565e' : '#3a3e46'); // granito
    R(c, x, top, w, 1, '#6a6e76'); R(c, x + 3, top + 2, w - 6, 16, '#1c1f24'); vgrad(c, x + 4, top + 3, w - 8, 14, shadeHex(sig, 1.25), shadeHex(sig, .85)); R(c, x + 4, top + 3, w - 8, 1, '#ffffff66'); ell(c, x + 13, top + 10, 5, 5, '#f6f2ea'); ell(c, x + 13, top + 10, 3, 3, sig); R(c, x + 4, top + 18, w - 8, 2, '#fff2c8');
    const gx = x + 5, gy = top + 22, gw = w - 10, gh = bot - 2 - gy, wall = pick(['#f4ecdc', '#e8eef2', '#f2e6e8', '#eef2e6', '#f6eedc'], i);
    vgrad(c, gx, gy, gw, gh, '#fffaf0', wall); for (let k = 0; k < gw - 8; k += 16) { R(c, gx + 6 + k, gy + 1, 8, 1, '#fffef4'); for (let j = 0; j < 4; j++) R(c, gx + 4 + k, gy + 2 + j, 12, 1, `rgba(255,248,220,${.3 - j * .07})`); }
    R(c, gx, gy + gh - 9, gw, 9, '#d8cfbe'); for (let k = 0; k < gw; k += 8) R(c, gx + k, gy + gh - 9 + ((k / 8) % 2) * 4, 4, 4, '#cfc4b0');
    produtos(c, kind, gx, gy + 2, gw, gh - 10, i);
    R(c, gx, gy, gw, 2, '#2a2e34'); R(c, gx, gy + gh - 2, gw, 2, '#2a2e34'); R(c, gx - 1, gy, 2, gh, '#2a2e34'); R(c, gx + gw - 1, gy, 2, gh, '#2a2e34');
    const dx = gx + Math.round(gw / 2) - 14; R(c, dx, gy, 2, gh, '#2a2e34'); R(c, dx + 28, gy, 2, gh, '#2a2e34'); R(c, dx + 12, gy + gh * .45, 2, 8, '#c8ccd0'); R(c, dx + 16, gy + gh * .45, 2, 8, '#c8ccd0');
    reflexo(c, gx + 1, gy + 2, gw - 2, gh - 4);
    if (hash(i + 77) > .45) { R(c, gx + gw - 22, gy + 6, 16, 9, '#e8433a'); R(c, gx + gw - 20, gy + 8, 12, 2, '#f2efe6'); R(c, gx + gw - 20, gy + 11, 8, 2, '#f2efe6'); }
    R(c, x, bot - 2, w, 2, '#c8ccd0'); R(c, x, bot - 2, w, 1, '#eef0f2');
  }
  function pracaAlimentacao(c, x0) {
    const nomes = 3; for (let n = 0; n < nomes; n++) {
      const x = x0 + n * 130, w = 128, top = SHOP.TOP, col = ['#e8833a', '#c43c3a', '#7a3a8a'][n];
      azulejo(c, x, top, w, 96, '#f2efe6', '#e0dcd2'); R(c, x, top, w, 1, '#ffffff');
      R(c, x + 4, top + 3, w - 8, 12, '#1c1f24'); vgrad(c, x + 5, top + 4, w - 10, 10, shadeHex(col, 1.2), shadeHex(col, .85)); R(c, x + 5, top + 4, w - 10, 1, '#ffffff66');
      R(c, x + 6, top + 18, w - 12, 28, '#14161c'); for (let k = 0; k < 4; k++) { const px = x + 9 + k * 29; vgrad(c, px, top + 20, 26, 18, '#fff4dc', '#f2d8a8');
        if (n === 0) { ell(c, px + 13, top + 30, 9, 3, '#c47a35'); R(c, px + 5, top + 28, 16, 2, '#5ab040'); R(c, px + 5, top + 30, 16, 2, '#7a3a20'); ell(c, px + 13, top + 26, 9, 3, '#d89a4a'); R(c, px + 8, top + 24, 2, 1, '#f6e8c8'); }
        if (n === 1) { ell(c, px + 13, top + 31, 10, 5, '#e8b85a'); R(c, px + 3, top + 31, 20, 4, '#f2d898'); for (let j = 0; j < 4; j++) R(c, px + 6 + j * 4, top + 30, 2, 1, '#c8883a'); }
        if (n === 2) { ell(c, px + 13, top + 31, 9, 5, '#7a2a6a'); R(c, px + 4, top + 31, 18, 4, '#5a1a4a'); for (let j = 0; j < 5; j++) R(c, px + 6 + j * 3, top + 27 + (j % 2), 2, 2, pick(['#e8c24c', '#f2efe6', '#d9634a'], j + k)); }
        R(c, px + 2, top + 39, 22, 4, '#f2c94c'); R(c, px + 4, top + 40, 10, 2, '#2a2a2a'); }
      R(c, x + 30, top + 52, 12, 10, '#efe2d0'); R(c, x + 28, top + 50, 16, 3, '#f6f4ee'); R(c, x + 30, top + 62, 12, 8, col); pessoa(c, x + 80, top + 70, n + 4);
      vgrad(c, x + 2, top + 66, w - 4, 30, '#e2e6ea', '#8a9298'); R(c, x + 2, top + 66, w - 4, 2, '#f6f8fa'); R(c, x + 2, top + 72, w - 4, 3, col); R(c, x + 2, top + 75, w - 4, 1, shadeHex(col, .6)); for (let k = 12; k < w - 4; k += 26) R(c, x + k, top + 70, 1, 26, 'rgba(255,255,255,.4)');
      R(c, x + 10, top + 62, 18, 4, '#c8ccd0'); R(c, x + 12, top + 58, 4, 4, '#3c8a5a'); R(c, x + 100, top + 58, 10, 8, '#2a2a2a'); R(c, x + 101, top + 59, 8, 4, '#5ae070');
    }
  }
  function cinemaFrente(c, x, w) {
    const top = SHOP.TOP; R(c, x, top, w, 96, '#231b29'); for (let k = 0; k < w; k += 14) { R(c, x + k, top, 1, 96, '#2e2434'); R(c, x + k + 7, top + 30, 1, 66, '#1c1622'); }
    R(c, x + 6, top + 2, w - 12, 24, '#c8a24a'); R(c, x + 8, top + 4, w - 16, 20, '#140f18'); R(c, x + 6, top + 2, w - 12, 1, '#f2d898'); R(c, x + 6, top + 25, w - 12, 1, '#8a6a2a');
    for (let k = 0; k < 4; k++) { const px = x + 18 + k * 92, py = top + 32; R(c, px - 2, py - 2, 62, 50, '#c8a24a'); R(c, px - 2, py - 2, 62, 1, '#f2d898'); const pc = ['#2c4a8a', '#8a2a2a', '#2a6a4a', '#c46a2a'][k];
      vgrad(c, px, py, 58, 46, shadeHex(pc, 1.5), shadeHex(pc, .55)); ell(c, px + 29, py + 14, 10, 10, shadeHex(pc, 1.9)); R(c, px + 18, py + 22, 22, 18, '#14101a'); ell(c, px + 29, py + 20, 6, 6, '#14101a'); R(c, px + 10, py + 34, 8, 8, '#14101a'); R(c, px + 42, py + 30, 6, 12, '#14101a'); R(c, px + 4, py + 38, 50, 6, 'rgba(0,0,0,.55)'); R(c, px + 8, py + 39, 42, 2, '#f2efe6'); R(c, px + 14, py + 42, 30, 1, '#c8c4bc'); R(c, px, py, 58, 10, 'rgba(255,255,255,.08)'); }
    const ex = x + 150; R(c, ex, top + 84, 80, 12, '#a82a2a'); R(c, ex, top + 84, 80, 1, '#d84a4a'); for (const sx of [ex - 6, ex + 84]) { R(c, sx, top + 74, 2, 22, '#c8a24a'); ell(c, sx + 1, top + 73, 2, 2, '#f2d898'); } for (let k = 0; k < 20; k++) R(c, ex - 4 + k * 4.5, top + 77 + Math.round(Math.sin(k / 19 * Math.PI) * 3), 3, 2, '#c43c3a');
    R(c, x + 4, top + 82, 26, 14, '#3a2e40'); R(c, x + 6, top + 84, 22, 8, '#d8eef4'); R(c, x + 12, top + 86, 8, 6, '#f0c8a8');
  }
  function lanFrente(c, x, w) {
    const top = SHOP.TOP; R(c, x, top, w, 96, '#1a1d26'); vgrad(c, x + 6, top + 24, w - 12, 70, '#151820', '#24283a');
    R(c, x + 4, top + 3, w - 8, 16, '#0e1016'); R(c, x + 4, top + 3, w - 8, 1, '#5ae0d0'); R(c, x + 4, top + 18, w - 8, 1, '#e05a8a');
    for (let k = 0; k < 6; k++) { const px = x + 14 + k * 58; R(c, px, top + 42, 40, 26, '#0c0e14'); R(c, px + 2, top + 44, 36, 22, '#2a2c38'); R(c, px + 18, top + 68, 4, 6, '#3a3c48'); R(c, px - 2, top + 74, 44, 3, '#3a3c48'); R(c, px - 2, top + 74, 44, 1, '#5a5c68'); R(c, px + 4, top + 72, 10, 2, '#1e1e24');
      R(c, px + 8, top + 80, 22, 14, '#c43c3a'); R(c, px + 10, top + 70, 18, 12, '#c43c3a'); R(c, px + 12, top + 72, 14, 2, '#2a2a2a'); R(c, px + 8, top + 80, 2, 14, '#8a2a2a'); pessoa(c, px + 15, top + 82, k + 2); }
    for (let k = 0; k < 3; k++) { const px = x + w - 54 + (k % 2) * 22, py = top + 26 + Math.floor(k / 2) * 0 + k * 4; R(c, px, py, 18, 12, pick(['#7a3a8a', '#c43c3a', '#2c5a9e'], k)); R(c, px + 2, py + 2, 14, 4, '#f2efe6'); }
    reflexo(c, x + 6, top + 24, w - 12, 70); R(c, x + 6, top + 24, w - 12, 1, '#5ae0d0'); R(c, x + 6, top + 93, w - 12, 1, '#e05a8a');
  }
  function paredeMarmore(c, x, w) { const top = 11; vgrad(c, x, top, w, 199, '#ece6da', '#ddd5c6'); for (let y = top + 30; y < 210; y += 40) R(c, x, y, w, 1, '#cbc3b2'); for (let k = 0; k < w * 2; k++) { const vx = x + hash(k + x) * w, vy = top + hash(k * 3 + x) * 199; R(c, vx, vy, 3, 1, 'rgba(160,150,135,.35)'); } }

  function buildShop() {
    const W = SHOP.W, [cv, c] = mk(W, LH), TOP = SHOP.TOP, MZ = SHOP.MZ;
    // paredes de mármore onde não tem loja (escada, elevador e fonte)
    paredeMarmore(c, SHOP.ESC, 120); paredeMarmore(c, SHOP.ELEV - 8, 132); c.clearRect(SHOP.ESC, 11, 120, MZ - 27); c.clearRect(SHOP.ELEV - 8, 11, 132, MZ - 27);
    R(c, SHOP.ESC + 14, TOP + 8, 46, 30, '#1c1f24'); vgrad(c, SHOP.ESC + 16, TOP + 10, 42, 26, '#5ab8e8', '#2c5a9e'); R(c, SHOP.ESC + 20, TOP + 14, 34, 3, '#f2efe6'); R(c, SHOP.ESC + 20, TOP + 20, 24, 2, '#f2c94c'); R(c, SHOP.ESC + 20, TOP + 26, 30, 2, '#f2efe6');
    // lojas e espaços do térreo
    [['MODA', 0], ['GAMES', 150], ['TÊNIS', 300], ['PERFUMES', 450]].forEach(([k, x], i) => lojaFrente(c, x + 2, 146, k, i));
    pracaAlimentacao(c, SHOP.FOOD); cinemaFrente(c, SHOP.CINE, 380); lanFrente(c, SHOP.LAN, 370);
    [['LIVROS', 2014], ['BRINQUEDOS', 2164]].forEach(([k, x], i) => lojaFrente(c, x + 2, 146, k, i + 4));
    paredeMarmore(c, 2316, 84); c.clearRect(2316, 11, 84, MZ - 27);
    // máquina de pelúcia e carrinho infantil
    const mx = 2326; R(c, mx, 150, 32, 60, '#d84a7a'); R(c, mx, 150, 32, 2, '#f08ab0'); R(c, mx + 3, 154, 26, 28, '#cfeaf2'); for (let k = 0; k < 7; k++) ell(c, mx + 7 + (k % 4) * 6, 178 - Math.floor(k / 4) * 6, 3, 3, pick(['#f2c94c', '#3c9ad8', '#e8433a', '#7ac85a', '#c86ab8'], k)); R(c, mx + 3, 154, 26, 8, 'rgba(255,255,255,.25)'); R(c, mx + 4, 186, 24, 16, '#b83a64'); R(c, mx + 8, 190, 6, 4, '#f2c94c'); ell(c, mx + 22, 192, 3, 3, '#c43c3a');
    const kx = 2364; R(c, kx, 196, 30, 12, '#2c5a9e'); vgrad(c, kx + 4, 180, 22, 18, '#5ab8e8', '#3c8ad8'); R(c, kx + 6, 182, 16, 6, '#d8f0f8'); ell(c, kx + 6, 208, 3, 3, '#1c1c1c'); ell(c, kx + 24, 208, 3, 3, '#1c1c1c'); R(c, kx + 2, 194, 26, 2, '#f2c94c');
    // escada rolante: painel de vidro, degraus e corrimão
    { const x0 = SHOP.ESC + 6, y0 = 210, x1 = SHOP.ESC + 112, y1 = MZ; c.fillStyle = 'rgba(185,222,234,.45)'; c.beginPath(); c.moveTo(x0, y0); c.lineTo(x1, y1); c.lineTo(x1, y1 + 16); c.lineTo(x0 + 10, y0); c.closePath(); c.fill();
      for (let k = 0; k <= 52; k++) { const u = k / 52, sx = x0 + (x1 - x0) * u, sy = y0 - (y0 - y1) * u; R(c, sx, sy, 4, 3, '#c4ccd2'); R(c, sx, sy + 3, 4, 2, '#7a848c'); }
      limb(c, [[x0 - 2, y0 - 12], [x1, y1 - 12]], 3, '#1e1e22'); limb(c, [[x0 - 2, y0 - 13], [x1, y1 - 13]], 1, '#4a4a52'); R(c, x0 - 8, y0 - 14, 10, 14, '#8a949a'); R(c, x0 - 8, y0 - 14, 10, 2, '#c8ccd0'); }
    // poço do elevador panorâmico
    { const ex = SHOP.ELEV; R(c, ex, 11, 40, 199, 'rgba(180,220,232,.32)'); R(c, ex, 11, 3, 199, '#8a96a0'); R(c, ex + 37, 11, 3, 199, '#8a96a0'); R(c, ex + 1, 11, 1, 199, '#d8e0e4'); for (let y = 30; y < 210; y += 30) R(c, ex, y, 40, 2, '#9aa6ae'); R(c, ex + 19, 11, 2, 199, '#5a6066'); }
    // fonte com borda de mármore
    { const fx = SHOP.FONTE + 32; ell(c, fx, 207, 30, 6, '#7a848a'); ell(c, fx, 205, 28, 5, '#e6e0d4'); ell(c, fx, 204, 25, 4, '#4a9ac0'); ell(c, fx, 203, 22, 3, '#8ad0e8'); R(c, fx - 3, 186, 6, 17, '#d8d4c8'); R(c, fx - 3, 186, 2, 17, '#f6f2e8'); ell(c, fx, 186, 8, 2, '#d8d4c8'); }
    // colunas (do térreo ao teto, passando pelo mezanino)
    for (const x of [0, 148, 298, 448, 598, 718, 1110, 1500, 1630, 2012, 2162, 2312]) { coluna(c, x - 5, 11, MZ - 15); coluna(c, x - 5, TOP, 210); }
    // mezanino: guarda-corpo de vidro com corrimão cromado, laje e spots embaixo
    R(c, 0, MZ - 14, W, 14, 'rgba(188,226,238,.42)'); for (let x = 0; x < W; x += 24) { R(c, x, MZ - 14, 2, 14, '#9aa6ae'); R(c, x, MZ - 14, 1, 14, '#e2e8ec'); } for (let x = 10; x < W; x += 60) limb(c, [[x, MZ - 1], [x + 10, MZ - 13]], 2, 'rgba(255,255,255,.4)');
    R(c, 0, MZ - 17, W, 3, '#b8c2c8'); R(c, 0, MZ - 17, W, 1, '#f6fafc'); R(c, 0, MZ - 14, W, 1, '#7a868e');
    R(c, 0, MZ, W, 12, '#f6f4ee'); R(c, 0, MZ, W, 1, '#ffffff'); R(c, 0, MZ + 8, W, 1, '#dcd8cc'); R(c, 0, MZ + 11, W, 1, '#a8a294');
    vgrad(c, 0, MZ + 12, W, 6, '#aaa496', '#d6d0c4'); for (let x = 20; x < W; x += 50) { R(c, x, MZ + 12, 6, 2, '#fff6d8'); for (let j = 0; j < 4; j++) R(c, x - j * 2, MZ + 14 + j, 6 + j * 4, 1, `rgba(255,246,216,${.35 - j * .08})`); }
    // teto: forro com sanca e spots
    vgrad(c, 0, 0, W, 9, '#f6f2ea', '#d6d0c4'); R(c, 0, 9, W, 2, '#8a8478'); for (let x = 12; x < W; x += 40) { R(c, x, 3, 8, 4, '#5a564e'); R(c, x + 1, 5, 6, 2, '#fff6d8'); }
    // piso de mármore polido com veios e reflexo das lojas
    R(c, 0, 210, W, 3, '#6f6a60'); R(c, 0, 210, W, 1, '#a8a294');
    vgrad(c, 0, 213, W, LH - 213, '#f2ede2', '#ddd6c8');
    const rows = [213, 218, 224, 232, 243, 257, 270];
    for (let r = 1; r < rows.length; r++) { R(c, 0, rows[r], W, 1, '#cdc5b4'); const step = 26 + r * 10; for (let x = (r % 2) * step / 2; x < W; x += step) R(c, x, rows[r - 1] + 1, 1, rows[r] - rows[r - 1] - 1, '#d6cfbf'); }
    for (let i = 0; i < W / 4; i++) { const vx = hash(i * 1.7) * W, vy = 216 + hash(i * 2.9) * 50; limb(c, [[vx, vy], [vx + 4 + hash(i) * 6, vy + hash(i * 5) * 3 - 1]], 1, 'rgba(150,140,125,.28)'); }
    { const H = LH - 213, [tmp, tc] = mk(W, H); tc.drawImage(cv, 0, 210 - H, W, H, 0, 0, W, H); c.save(); c.globalAlpha = .15; c.translate(0, 213 + H); c.scale(1, -1); c.drawImage(tmp, 0, 0); c.restore(); for (let k = 0; k < H; k++) R(c, 0, 213 + k, W, 1, `rgba(238,233,222,${k / H * .55})`); }
    OBJ.pisoMolhado(c, 586, 0);
    return cv;
  }
  let shopMid = null;
  function shopping(c, s, t, camL) {
    if (!shopMid) shopMid = buildShop(); if (!SHOPFAR) SHOPFAR = buildShopFar();
    sky(c, s, t, camL); tile(c, SHOPFAR, camL * .4);
    // sol entrando pela cobertura
    if (s.sunT !== null) { const a = .08 * (1 - s.night); c.fillStyle = `rgba(255,246,214,${a})`; for (let x = wrap(-camL * .4, 128) - 128; x < LW + 128; x += 128) { c.beginPath(); c.moveTo(x, 14); c.lineTo(x + 40, 14); c.lineTo(x + 90, 96); c.lineTo(x + 30, 96); c.closePath(); c.fill(); } }
    // gente andando no mezanino (atrás do vidro)
    for (let i = 0; i < 11; i++) { const wx = 30 + i * 220 + Math.sin(t * .2 + i * 1.3) * 80, sx = wx - camL; if (vis(sx, 20)) pessoa(c, sx, SHOP.MZ, i + 3); }
    // faixas do Festival de Inverno e plantas penduradas no vão
    for (let x = 60; x < SHOP.W; x += 300) { const sx = x - camL, sw = Math.round(Math.sin(t * 1.1 + x) * 1); if (!vis(sx, 40)) continue; R(c, sx + 8, 11, 1, 6, '#5a6066'); R(c, sx + 26, 11, 1, 6, '#5a6066'); vgrad(c, sx + 4 + sw, 17, 28, 44, '#3c6ab0', '#1d3a70'); R(c, sx + 4 + sw, 17, 28, 2, '#7aa0d8'); for (let k = 0; k < 4; k++) R(c, sx + 5 + k * 7 + sw, 61, 5, 3 + (k % 2) * 2, '#1d3a70'); for (let k = 0; k < 3; k++) { const fy = 26 + k * 9; R(c, sx + 17 + sw, fy, 2, 6, '#f2f6fa'); R(c, sx + 15 + sw, fy + 2, 6, 2, '#f2f6fa'); } R(c, sx + 8 + sw, 55, 20, 2, '#f2c94c'); }
    for (let x = 210; x < SHOP.W; x += 300) { const sx = x - camL + Math.sin(t * .9 + x) * 1.5; if (!vis(sx, 20)) continue; R(c, sx, 11, 1, 22, '#5a6066'); R(c, sx - 6, 33, 13, 7, '#b86a3a'); R(c, sx - 6, 33, 13, 2, '#d88a4a'); for (let k = 0; k < 7; k++) R(c, sx - 7 + k * 2, 40 + (k % 3) * 2, 2, 5 + (k % 2) * 6, k % 2 ? '#3f7a3c' : '#5f9a46'); }
    c.drawImage(shopMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // elevador panorâmico subindo e descendo entre o térreo e o mezanino
    { const x = SHOP.ELEV - camL; if (vis(x, 60)) { const u = (Math.sin(t * .35) + 1) / 2, y = 62 + u * 116; R(c, x + 3, y, 34, 32, 'rgba(206,236,246,.7)'); R(c, x + 3, y, 34, 2, '#c8ccce'); R(c, x + 3, y + 30, 34, 2, '#7a848c'); R(c, x + 3, y, 2, 32, '#9aa6ae'); R(c, x + 35, y, 2, 32, '#9aa6ae'); pessoa(c, x + 9, y + 30, 4); pessoa(c, x + 22, y + 30, 7); R(c, x + 19, 11, 2, y - 11, '#2a2a2a'); } }
    // escada rolante: degraus andando e gente subindo
    { const x0 = SHOP.ESC + 6, x1 = SHOP.ESC + 112, y0 = 210, y1 = SHOP.MZ; for (let k = 0; k < 26; k++) { const u = (t * .16 + k / 26) % 1, x = x0 + (x1 - x0) * u - camL, y = y0 - (y0 - y1) * u; if (vis(x, 10)) R(c, x, y - 1, 4, 1, '#eef2f4'); }
      for (let i = 0; i < 2; i++) { const u = (t * .16 + i * .5) % 1, x = x0 + 4 + (x1 - x0) * u - camL, y = y0 - 2 - (y0 - y1) * u; if (vis(x, 10)) pessoa(c, x, y, i + 5); } }
    // fonte
    { const fx = SHOP.FONTE + 32 - camL; if (vis(fx, 40)) for (let j = 0; j < 5; j++) { const a = (j - 2) / 2; for (let k = 0; k < 11; k++) { const u = k / 10, px = fx + a * 20 * u, py = 186 - Math.sin(u * Math.PI) * (14 - Math.abs(a) * 4) + u * 17; R(c, px, py, 1, 2, (k + Math.floor(t * 8)) % 3 ? '#bfe8f0' : '#ffffff'); } } }
    // cinema: lâmpadas correndo em volta do letreiro
    { const x = SHOP.CINE + 6 - camL, y = SHOP.TOP + 2; if (vis(x, 380)) { for (let k = 0; k < 368; k += 6) { const on = (Math.floor(t * 6) + k / 6) % 4 !== 0; R(c, x + k, y, 2, 2, on ? '#fff2b0' : '#7a5a2a'); R(c, x + k, y + 22, 2, 2, on ? '#fff2b0' : '#7a5a2a'); } } }
    for (let i = 0; i < 5; i++) { const sx = SHOP.CINE + 40 + i * 13 - camL; if (vis(sx, 20)) pessoa(c, sx, 210, i + 1); }
    // lan house: telas mudando, LEDs e "GG!"
    { const lx = SHOP.LAN - camL; if (vis(lx, 380)) { for (let k = 0; k < 6; k++) { const px = lx + 16 + k * 58; R(c, px, SHOP.TOP + 44, 36, 22, ['#3c8ae0', '#5ae070', '#e05a8a', '#f2c94c'][(k + Math.floor(t * 1.4)) % 4]); R(c, px + 2 + (Math.floor(t * 9 + k * 3) % 28), SHOP.TOP + 54, 4, 4, '#f2f2ee'); R(c, px + 4, SHOP.TOP + 60, 28, 2, 'rgba(0,0,0,.25)'); }
      const hue = Math.floor(t * 3) % 3; R(c, lx + 4, SHOP.TOP + 3, 362, 1, ['#5ae0d0', '#e05a8a', '#f2c94c'][hue]); R(c, lx + 4, SHOP.TOP + 18, 362, 1, ['#e05a8a', '#f2c94c', '#5ae0d0'][hue]);
      if ((t % 4) < 1.2) { const gx = lx + 22 + (Math.floor(t / 4) % 6) * 58; R(c, gx, SHOP.TOP + 34 - (t % 4) * 6, 22, 10, '#f2efe6'); R(c, gx + 2, SHOP.TOP + 36 - (t % 4) * 6, 18, 6, '#3c8a5a'); } } }
    // máquina de pelúcia e carrinho infantil
    { const x = 2326 - camL; if (vis(x, 40)) { R(c, x + 2, 150, 28, 2, Math.sin(t * 6) > 0 ? '#f2c94c' : '#ffffff'); const gx = x + 10 + Math.sin(t * .8) * 8; R(c, gx, 156, 2, 6 + Math.abs(Math.sin(t * .5)) * 8, '#8a8a86'); R(c, gx - 2, 162 + Math.abs(Math.sin(t * .5)) * 8, 6, 2, '#8a8a86'); } }
    { const x = 2364 - camL; if (vis(x, 40)) { const rock = Math.round(Math.sin(t * 4)); pessoa(c, x + 10, 196 + rock, 9); R(c, x + 2, 194, 26, 2, Math.sin(t * 5) > 0 ? '#f2c94c' : '#e05a8a'); } }
    // faxineiro, segurança e movimento no térreo
    { const x = 560 - camL + Math.sin(t * 1.5) * 6; if (vis(x, 30)) { pessoa(c, x, 214, 6); limb(c, [[x + 5, 202], [x + 13, 213]], 1, '#8a6a45'); R(c, x + 9, 212, 10, 2, '#5a5a5a'); } }
    { const x = 1495 - camL; if (vis(x, 20)) { R(c, x - 1, 200, 7, 9, '#1e1e24'); pessoa(c, x, 214, 2); R(c, x - 1, 200, 7, 7, '#1e1e24'); R(c, x, 194, 5, 1, '#1e1e24'); } }
    for (let i = 0; i < 20; i++) { const wx = 30 + i * 120 + Math.sin(t * .35 + i * 2) * 50, sx = wx - camL; if (vis(sx, 20)) pessoa(c, sx, 216, i); }
    for (let k = 0; k < 6; k++) { const mx = SHOP.FOOD + 14 + k * 64 - camL; if (vis(mx, 30)) { mesaBar(c, mx); if (k % 2 === 0) pessoa(c, mx - 4, 210, k + 2); } }
  }
  function shoppingLights(g, s, t, camL) { for (let x = 12; x < SHOP.W; x += 40) { const sx = x + 4 - camL; if (vis(sx)) lightAdd(sx, 6, .22, 50); } const lx = SHOP.LAN - camL; if (vis(lx, 380)) { g.fillStyle = 'rgba(90,224,208,.10)'; g.fillRect(lx, SHOP.TOP, 370, 96); } const cx = SHOP.CINE - camL; if (vis(cx, 380)) { g.fillStyle = 'rgba(255,227,154,.10)'; g.fillRect(cx + 6, SHOP.TOP + 2, 368, 24); } }

  /* =====================================================================
     21 · AVENIDA OLÍVIA FLORES E ESCOLA SESI
     ===================================================================== */
  const OLIVIA = { W: 2600, SESI: 1250 };
  function buildOlivia() {
    const [cv, c] = mk(OLIVIA.W, LH);
    for (let i = 0, x = 10; x < OLIVIA.SESI - 40; i++) { const w = 46 + Math.round(hash(i + 270) * 24); predio(c, x, w, 4 + Math.round(hash(i + 271) * 3), pick(['#f2efe6', '#e9e6dc', '#dfe4e6', '#ece4d4'], i), 270 + i); x += w + 16; }
    // canteiro central com a ciclovia (faixa amarela), coqueiros e academia ao ar livre
    R(c, 0, 172, OLIVIA.SESI, 6, '#5f8a46'); R(c, 0, 178, OLIVIA.SESI, 8, '#6f7376'); for (let x = 0; x < OLIVIA.SESI; x += 12) R(c, x, 181, 6, 1, '#e8c24c'); R(c, 0, 186, OLIVIA.SESI, 6, '#5f8a46'); for (let x = 0; x < OLIVIA.SESI; x += 40) R(c, x + 4, 186, 2, 2, pick(['#e86a7a', '#e8c24c', '#f2efe6'], x));
    for (const gx of [300, 700]) { R(c, gx, 190, 2, 20, '#3c8ad8'); R(c, gx + 20, 190, 2, 20, '#3c8ad8'); R(c, gx, 190, 22, 2, '#3c8ad8'); R(c, gx + 30, 196, 16, 2, '#e8c24c'); R(c, gx + 36, 198, 2, 12, '#e8c24c'); ell(c, gx + 56, 202, 6, 6, '#c43c3a'); R(c, gx + 55, 196, 2, 14, '#c43c3a'); }
    // Escola SESI: muro com grade azul, pátio, quadra coberta em arco, auditório e laboratório
    const sx = OLIVIA.SESI; plaster(c, sx, 150, OLIVIA.W - sx, 60, '#f2f2ee', 1250); R(c, sx, 150, OLIVIA.W - sx, 3, '#2c5a9e');
    plaster(c, sx + 20, 96, 200, 54, '#f2f2ee', 1251); R(c, sx + 20, 96, 200, 6, '#2c5a9e'); for (let k = 0; k < 6; k++) janela(c, sx + 30 + k * 32, 110, 20, 14, 'vidro', 1251 + k); R(c, sx + 30, 128, 40, 20, '#c43c3a');
    for (let k = 0; k < 2; k++) { R(c, sx + 230 + k * 20, 60, 2, 92, '#8a8a86'); R(c, sx + 232 + k * 20, 62, 14, 9, k ? '#2c8a3a' : '#2c8a3a'); R(c, sx + 236 + k * 20, 64, 6, 5, k ? '#c43c3a' : '#e8c24c'); }
    const q = sx + 300; for (let k = 0; k <= 280; k++) { const h = Math.round(Math.sin(k / 280 * Math.PI) * 30); R(c, q + k, 90 - h, 1, 3, '#9aa4ac'); if (k % 20 === 0) limb(c, [[q + k, 90 - h], [q + k, 92]], 1, '#9aa4ac'); } for (let k = 0; k <= 280; k += 40) R(c, q + k, 90, 3, 120, '#7a848c'); R(c, q, 160, 280, 50, '#3c7a5a'); R(c, q + 10, 162, 260, 2, '#f2f2ee'); R(c, q + 139, 162, 2, 48, '#f2f2ee'); ell(c, q + 140, 186, 16, 10, '#f2f2ee'); ell(c, q + 140, 186, 14, 8, '#3c7a5a'); for (const hx of [q + 4, q + 268]) { R(c, hx, 136, 3, 30, '#c43c3a'); R(c, hx - 4, 136, 12, 9, '#f2f2ee'); R(c, hx - 2, 145, 8, 3, '#e86a3a'); }
    const ad = sx + 650; plaster(c, ad, 110, 180, 100, '#e8e4dc', 1900); R(c, ad, 110, 180, 6, '#2c5a9e'); R(c, ad + 70, 150, 40, 60, '#5a3c2a'); for (let k = 0; k < 3; k++) janela(c, ad + 10 + k * 60, 122, 30, 16, 'vidro', 1900 + k);
    grafite(c, ad + 6, 160, 56, 40, 1910);
    const lab = sx + 880; plaster(c, lab, 110, 220, 100, '#f2f2ee', 2130); R(c, lab, 110, 220, 6, '#2c5a9e'); for (let k = 0; k < 5; k++) { R(c, lab + 10 + k * 42, 124, 34, 26, '#2c3a44'); R(c, lab + 12 + k * 42, 126, 30, 22, '#9fc4d0'); R(c, lab + 18 + k * 42, 134, 10, 8, '#3c8ae0'); R(c, lab + 30 + k * 42, 134, 10, 8, '#3c8ae0'); }
    R(c, lab + 20, 160, 70, 40, '#5a4a34'); R(c, lab + 22, 162, 66, 36, '#c4a46a'); for (let k = 0; k < 6; k++) cartaz(c, lab + 25 + (k % 3) * 20, 164 + Math.floor(k / 3) * 17, 2140 + k); // mural de avisos
    for (let k = 0; k < 6; k++) { R(c, lab + 120 + k * 14, 166, 12, 44, '#3c6aa8'); R(c, lab + 121 + k * 14, 167, 10, 20, '#4a7ab8'); R(c, lab + 128 + k * 14, 180, 2, 3, '#c8c8c4'); } // armários
    for (let x = sx; x < OLIVIA.W; x += 6) R(c, x, 196, 1, 14, '#2c5a9e'); R(c, sx, 196, OLIVIA.W - sx, 1, '#2c5a9e');
    for (let lx = 100; lx < OLIVIA.SESI; lx += 220) lampPost(c, lx, 120);
    ponto(c, 1100); lixeira(c, 1180); lixeira(c, 1500, '#3c8a5a'); bike(c, 1300, '#e8c24c'); bike(c, 1324, '#3c8ad8'); bike(c, 1348, '#c43c3a');
    objetos(c, 21, OLIVIA.W, 'cidade', 30, OLIVIA.SESI - 20, [90, 170]); calcada(c, OLIVIA.W, '#d6d0be'); R(c, 0, 221, OLIVIA.W, LH - 221, '#d6d0be'); for (let x = 0; x < OLIVIA.W; x += 18) R(c, x, 221, 1, LH - 221, '#bfb8a6'); for (let y = 234; y < LH; y += 14) R(c, 0, y, OLIVIA.W, 1, '#bfb8a6');
    return cv;
  }
  let oliviaMid = null;
  function olivia(c, s, t, camL) {
    if (!oliviaMid) oliviaMid = buildOlivia();
    conquistaBack(c, s, t, camL, { seed: 15 });
    c.drawImage(oliviaMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (let i = 0; i < 6; i++) { const dir = i % 2 ? 1 : -1, wx = ((i * 431 + t * (50 + i * 6) * dir) % 2900 + 2900) % 2900 - 200, sx = wx - camL; if (vis(sx, 40) && wx < OLIVIA.SESI) carro(c, sx, dir > 0 ? 172 : 196, pick(['#f2f2ee', '#3c6aa8', '#c43c3a', '#2a2a2a'], i), dir); }
    for (let i = 0; i < 3; i++) { const wx = ((i * 500 + t * 22) % 1300), sx = wx - camL; if (vis(sx, 20) && wx < OLIVIA.SESI) { ell(c, sx + 1, 182, 2, 2, '#1c1c1c'); ell(c, sx + 10, 182, 2, 2, '#1c1c1c'); R(c, sx + 3, 177, 6, 2, '#c43c3a'); R(c, sx + 5, 170, 3, 7, pick(['#3c6aa8', '#e8c24c', '#3c8a5a'], i)); R(c, sx + 5, 167, 3, 3, '#e0b08a'); } }
    for (let x = 40; x < OLIVIA.SESI; x += 110) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 178, .75, 1, t, x); }
    for (const x of [560, 980]) { const sx = x - camL; if (vis(sx, 60)) ipe(c, sx, 210, x === 560 ? '#e8c84a' : '#b86ac8', x, .8); }
    for (let i = 0; i < 5; i++) { const wx = ((i * 300 + t * 30) % 1250), sx = wx - camL; if (vis(sx, 20)) { gente(c, sx, 216, i + 4, false); if (i === 2) cachorro(c, sx + 12, 216, '#f2efe6'); } }
    for (let i = 0; i < 12; i++) { const wx = OLIVIA.SESI + 60 + i * 110 + Math.sin(t * .4 + i) * 30, sx = wx - camL; if (vis(sx, 20)) { gente(c, sx, 210, i, false); R(c, sx, 199, 5, 2, '#2c5a9e'); } }
    { const bx = OLIVIA.SESI + 440 + Math.sin(t * 1.3) * 60 - camL, by = 190 - Math.abs(Math.sin(t * 3)) * 18; if (vis(bx, 20)) { ell(c, bx, by, 3, 3, '#e8833a'); R(c, bx - 1, by - 1, 1, 1, '#2a2a2a'); } }
    fog(c, s, t, camL, .18);
  }
  function oliviaLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let x = 100; x < OLIVIA.SESI; x += 220) lampGlow(g, x - camL + 1, 116, a); }

  // gente pequena ao fundo (de casaco: faz frio em Conquista)
  function gente(c, x, y, i, cold = true) {
    const coat = ['#3a4a6a', '#7a3a3a', '#4a6a4a', '#5a4a6a', '#6a5a3a', '#2a3a4a', '#8a6a3a'][i % 7], skin = ['#e0b08a', '#9a6440', '#c88a60', '#6a4430', '#f0c8a8'][i % 5], hair = ['#2a201a', '#4a3226', '#1a1a1a', '#6a4a2a', '#c8a050'][i % 5];
    R(c, x, y - 13, 6, 8, coat); R(c, x + 1, y - 18, 4, 5, skin); R(c, x + 1, y - 19, 4, 2, hair); R(c, x, y - 5, 2, 5, '#2a2f3a'); R(c, x + 4, y - 5, 2, 5, '#2a2f3a'); R(c, x - 1, y - 12, 1, 6, coat); R(c, x + 6, y - 12, 1, 6, coat);
    if (cold) { R(c, x, y - 13, 6, 2, ['#d9634a', '#e8c24c', '#5f9fd0', '#f2efe6'][i % 4]); if (i % 3 === 0) R(c, x + 1, y - 21, 4, 2, ['#c43c3a', '#3c6aa8', '#e8c24c'][i % 3]); }
  }

  /* =====================================================================
     REGISTRO: cenas 12..21, objetos interativos, plataformas e vãos
     ===================================================================== */
  const indoor = (k) => (s) => mix(s.amb, [1, 1, 1], k);
  const LIST = [
    { id: 12, key: 'aeroporto', nome: 'Aeroportos', lugar: 'Aeroporto de Itabuna → Aeroporto Glauber Rocha', width: AIR.W * 2, draw: aeroporto, lights: aeroportoLights, amb: indoor(.55), always: true,
      labels: [[260, 121, 'AEROPORTO DE ITABUNA', 10, '#f2f2e6'], [370, 110, 'ITABUNA · TERRA DO CACAU', 6, '#5a3a20'], [535, 155, 'LANCHONETE', 6, '#f2e8d0'], [700, 125, 'RAIO-X', 8, '#2c3a44'], [1027, 108, 'PORTÃO 1', 6, '#1d4a7a'], [1850, 52, 'AEROPORTO GLAUBER ROCHA · VITÓRIA DA CONQUISTA', 11, '#2a3aa8'], [1850, 76, 'BEM-VINDO À SUÍÇA BAIANA. TRAGA CASACO.', 6, '#c43c3a'], [1810, 166, 'ESTEIRA 1', 6, '#f2efe6']],
      interact: [['trash', 520], ['trash', 1900], ['pot', 640], ['pot', 3200], ['door', 3100, 60, 150, 'main'], ['cone', 2300], ['cone', 2360], ['cone', 2420], ['crate', 2580], ['crate', 2608, 1], ['tire', 2700], ['lever', 2200, 'flood'], ['puddle', 3600, 70]] },
    { id: 13, key: 'bairro', nome: 'Bairro da pensão', lugar: 'Pensão de Dona Lurdes', width: BAIRRO.W * 2, draw: bairro, lights: bairroLights, always: true,
      labels: [[BAIRRO.PEN + 110, 145, 'PENSÃO DONA LURDES · QUARTOS', 8, '#5a3c2a'], [1178, 184, 'PADARIA PÃO QUENTE', 6, '#fff4dc'], [1295, 184, 'MERCADINHO', 6, '#eef6ea'], [720, 167, 'R. DA PENSÃO', 5, '#f2efe6'], [BAIRRO.PEN + 190, 160, 'AVISOS', 5, '#5a3c2a'], [1980, 166, 'ALUGA-SE QUARTO · TRATAR C/ LURDES', 5, '#2a2a2a']],
      interact: [['door', BAIRRO.PEN * 2 + 262, 50, 100, 'house'], ['pot', 900], ['pot', 3300], ['trash', 2140], ['bucket', 1800], ['crate', 2520], ['crate', 2548, 1], ['ball', 3000], ['puddle', 2700, 80], ['lever', 2400, 'party'], ['grass', 3800, 200], ['grill', 1500]] },
    { id: 14, key: 'centro', nome: 'Centro e Praça da Catedral', lugar: 'Catedral Nossa Senhora das Vitórias · Praça Tancredo Neves', width: CENTRO.W * 2, draw: centro, lights: centroLights, always: true,
      labels: [[CENTRO.CAT + 140, 224, 'CATEDRAL NOSSA SENHORA DAS VITÓRIAS', 7, '#5a5246'], [1250, 188, 'PRAÇA TANCREDO NEVES', 7, '#f2efe6'], [1785, 106, 'MEMORIAL', 7, '#5a3c2a'], [860, 167, 'PÇA. TANCREDO NEVES', 5, '#f2efe6']],
      interact: [['pot', 1900], ['pot', 3150], ['trash', 1760], ['trash', 3260], ['crate', 620], ['crate', 4520], ['crate', 4548, 1], ['ball', 2600], ['puddle', 2200, 80], ['lever', 2050, 'party'], ['door', CENTRO.CAT * 2 + 68, 48, 120, 'main'], ['cone', 3900]] },
    { id: 15, key: 'serra', nome: 'Serra do Periperi', lugar: 'Cristo de Mário Cravo', width: SERRA.W * 2, draw: serra, lights: serraLights, always: true,
      labels: [[200, 174, 'TRILHA DO CRISTO', 5, '#5a3c2a'], [1000, 174, 'MIRANTE · 1.100 m', 5, '#5a3c2a'], [1900, 174, 'CUIDADO: VENTO', 5, '#5a3c2a'], [SERRA.CRISTO, 219, 'CRISTO DE MÁRIO CRAVO', 7, '#3a3a34']],
      interact: [['grass', 300, 260], ['grass', 2200, 300], ['grass', 3500, 240], ['fence', 1200, 90], ['crate', 2000], ['crate', 2028, 1], ['bucket', 3000], ['hay', 4200], ['ball', 1600]] },
    { id: 16, key: 'avenidas', nome: 'Monumento ao Índio', lugar: 'Avenidas e rotatória do Monumento ao Índio', width: AVENIDA.W * 2, draw: avenida, lights: avenidaLights, always: true,
      labels: [[AVENIDA.INDIO, 180, 'MONUMENTO AO ÍNDIO', 7, '#f2efe6'], [380, 121, 'POSTO DO PLANALTO', 7, '#f2efe6'], [825, 155, 'MOTOTÁXI', 6, '#2a2a2a'], [680, 83, 'MOTOTÁXI? SÓ NO PREÇO JUSTO', 6, '#2a2a2a'], [2200, 83, 'COMPRE UM CASACO. SÉRIO.', 6, '#f2efe6'], [2615, 169, 'BORRACHARIA', 6, '#e8c24c']],
      interact: [['tire', 5000], ['tire', 5060], ['tire', 1300], ['barrel', 5200], ['cone', 2500], ['cone', 2560], ['cone', 4200], ['trash', 2440], ['trash', 3760], ['lever', 3100, 'flood'], ['puddle', 3400, 80], ['crate', 1700]] },
    { id: 17, key: 'feira', nome: 'Feira e biscoitarias', lugar: 'Feira e biscoitos de polvilho', width: FEIRA.W * 2, draw: feira, lights: feiraLights, always: true,
      labels: [[FEIRA.BISC[0] + 60, 184, 'BISCOITOS DE POLVILHO', 6, '#fff4dc'], [FEIRA.BISC[1] + 60, 184, 'BISCOITARIA DA SERRA', 6, '#fff4dc'], [FEIRA.BISC[2] + 60, 184, 'BISCOITO QUENTINHO', 6, '#fff4dc'], [240, 88, 'FEIRA DO PLANALTO', 10, '#3c5a6a'], [1700, 88, 'BISCOITO CURA TUDO (MENOS O FRIO)', 6, '#3c5a6a']],
      interact: [['melon', 600], ['melon', 630], ['melon', 2000], ['melon', 3000], ['crate', 1100], ['crate', 1128, 1], ['crate', 3500], ['pot', 2300], ['bucket', 1600], ['trash', 4000], ['barrel', 3300], ['grill', 2600], ['puddle', 1400, 70]] },
    { id: 18, key: 'cafe', nome: 'Fazendas de café', lugar: 'Planalto da Conquista', width: CAFE.W * 2, draw: cafe, lights: cafeLights, always: true,
      labels: [[350, 110, 'FAZENDA CAFÉ DO PLANALTO', 8, '#5a3c2a'], [960, 190, 'TERREIRO DE SECAGEM', 7, '#3a2a1a'], [1550, 96, 'SECADOR · NÃO ENCOSTE (O BARÃO TÁ DE OLHO)', 6, '#f2efe6'], [1250, 186, 'CAFÉ', 5, '#5a3420']],
      interact: [['hay', 1300], ['hay', 3900], ['hay', 3940], ['crate', 2500], ['crate', 2528, 1], ['bucket', 4200], ['barrel', 3000], ['fence', 4400, 120], ['lever', 1700, 'sprinkler'], ['grass', 4700, 260], ['puddle', 4100, 70]] },
    { id: 19, key: 'cultura', nome: 'Teatro e Planetário', lugar: 'Teatro Glauber Rocha · Centro de Cultura · Planetário', width: CULTURA.W * 2, draw: cultura, lights: culturaLights, noite: true, always: true,
      labels: [[195, 132, 'CENTRO DE CULTURA', 8, '#f2efe6'], [CULTURA.TEATRO + 150, 113, 'TEATRO GLAUBER ROCHA', 9, '#ffe39a'], [CULTURA.TEATRO + 150, 125, 'HOJE: BIA DO ARROCHA', 6, '#f2efe6'], [CULTURA.DOME, 168, 'PLANETÁRIO', 8, '#2c3a44'], [1000, 160, 'PIPOCA', 6, '#2a2a2a'], [1120, 160, 'DOGÃO', 6, '#f2efe6'], [CULTURA.TEATRO + 150, 196, 'BILHETERIA', 5, '#2a2a2a']],
      interact: [['lever', 1500, 'party'], ['lever', 3400, 'flood'], ['pot', 900], ['pot', 3800], ['trash', 2300], ['crate', 2700], ['grill', 2100]] },
    { id: 20, key: 'shopping', nome: 'Shopping', lugar: 'Praça de alimentação, cinema e lan house', width: SHOP.W * 2, draw: shopping, lights: shoppingLights, amb: indoor(.8), always: true,
      labels: [[SHOP.CINE + 190, SHOP.TOP + 14, 'CINEMA PLANALTO', 10, '#ffe39a'], [SHOP.LAN + 185, SHOP.TOP + 11, 'LAN HOUSE PLANALTO · 24H', 8, '#5ae0d0'], [SHOP.CINE + 17, SHOP.TOP + 80, 'BILHETERIA', 4, '#f2d898'], [SHOP.ESC + 37, SHOP.TOP + 18, 'SHOPPING', 5, '#f2efe6'], [SHOP.ESC + 37, SHOP.TOP + 30, 'CONQUISTA', 5, '#f2efe6'], [2342, 147, 'PELÚCIA', 4, '#f2efe6'], [SHOP.FONTE + 32, 216, 'JOGUE UMA MOEDA', 4, '#5a6a72']]
        .concat([60, 360, 660, 960, 1260, 1560, 1860, 2160].map((x) => [x + 18, 66, 'INVERNO', 4, '#f2c94c']))
        .concat(['BURGÃO', 'PASTEL & CALDO', 'AÇAÍ DA SERRA'].map((n, i) => [SHOP.FOOD + 64 + i * 130, SHOP.TOP + 9, n, 6, '#f2efe6']))
        .concat([['MODA', 0], ['GAMES', 150], ['TÊNIS', 300], ['PERFUMES', 450], ['LIVROS', 2014], ['BRINQUEDOS', 2164]].map(([n, x]) => [x + 80, SHOP.TOP + 10, n, 7, '#f6f2ea'])),
      interact: [['pot', 300], ['pot', 4580], ['trash', 1400], ['trash', 3020], ['ball', 2600], ['crate', 4400], ['crate', 4428, 1], ['puddle', 1700, 70], ['lever', 3200, 'party'], ['bucket', 1180]] },
    { id: 21, key: 'olivia', nome: 'Olívia Flores e Escola SESI', lugar: 'Avenida Olívia Flores · Escola SESI', width: OLIVIA.W * 2, draw: olivia, lights: oliviaLights, always: true,
      labels: [[600, 165, 'AVENIDA OLÍVIA FLORES', 9, '#f2efe6'], [750, 182, 'CICLOVIA', 6, '#2a2a2a'], [OLIVIA.SESI + 120, 92, 'ESCOLA SESI', 10, '#2c5a9e'], [OLIVIA.SESI + 440, 80, 'QUADRA COBERTA', 7, '#2c3a44'], [OLIVIA.SESI + 740, 104, 'AUDITÓRIO', 7, '#2c5a9e'], [OLIVIA.SESI + 990, 104, 'LABORATÓRIO DE INFORMÁTICA', 6, '#2c5a9e'], [OLIVIA.SESI + 935, 157, 'MURAL', 5, '#2a2a2a']],
      interact: [['ball', 3200], ['ball', 3300], ['ball', 3400], ['cone', 3600], ['cone', 3660], ['trash', 2360], ['trash', 3000], ['pot', 2700], ['lever', 3800, 'bell'], ['door', (OLIVIA.SESI + 720) * 2, 80, 120, 'class'], ['crate', 4700], ['puddle', 1600, 70], ['bucket', 4300]] }
  ];
  // plataformas [x, y, largura] e vãos [x, largura] em pixels do mundo (o mesmo formato de world.js)
  const LAYOUT = {
    12: { platforms: [[1260, 384, 150], [2100, 384, 150], [2290, 328, 140], [2480, 384, 150], [3500, 384, 150]], gaps: [] },
    13: { platforms: [[900, 384, 150], [1100, 328, 140], [2700, 384, 150], [2900, 328, 140], [3100, 384, 150]], gaps: [] },
    14: { platforms: [[1300, 384, 150], [1490, 328, 140], [1680, 272, 140], [2900, 384, 150], [3090, 328, 140], [4100, 384, 150]], gaps: [] },
    15: { platforms: [[600, 384, 150], [790, 320, 140], [980, 256, 140], [1170, 320, 140], [1700, 384, 150], [1890, 320, 140], [2080, 256, 130], [2270, 192, 130], [2460, 256, 140], [3100, 384, 150], [3290, 320, 140], [3480, 256, 140], [3670, 320, 140], [3860, 384, 150]], gaps: [[1420, 220], [2700, 300], [4060, 200]] },
    16: { platforms: [[1000, 384, 150], [1900, 384, 150], [2090, 328, 140], [3500, 384, 150], [3690, 328, 140], [4700, 384, 150]], gaps: [[1400, 180], [4300, 200]] },
    17: { platforms: [[700, 384, 150], [890, 328, 140], [1700, 384, 150], [2700, 384, 150], [2890, 328, 140], [3080, 272, 140]], gaps: [] },
    18: { platforms: [[900, 384, 150], [1090, 328, 140], [2200, 384, 150], [2390, 320, 140], [2580, 256, 140], [3600, 384, 150], [3790, 328, 140]], gaps: [[1500, 200], [3200, 220]] },
    19: { platforms: [[800, 384, 150], [990, 328, 140], [1180, 272, 140], [2400, 384, 150], [2590, 320, 140], [3500, 384, 150]], gaps: [] },
    20: { platforms: [[700, 384, 150], [890, 328, 140], [1080, 272, 140], [2600, 384, 150], [2790, 328, 140], [3500, 384, 150], [4100, 384, 150], [4290, 328, 140]], gaps: [] },
    21: { platforms: [[1100, 384, 150], [2700, 384, 150], [2890, 328, 140], [3080, 272, 140], [3900, 384, 150], [4090, 328, 140]], gaps: [] }
  };
  /* =====================================================================
     OBJETOS DE CENÁRIO (pra rua não ficar vazia) e detalhes do chão
     ===================================================================== */
  const OBJ = {
    banco: (c, x) => { R(c, x, GY - 9, 30, 3, '#8a6a45'); R(c, x, GY - 9, 30, 1, '#c4955c'); R(c, x, GY - 14, 30, 3, '#8a6a45'); R(c, x, GY - 14, 30, 1, '#c4955c'); R(c, x + 2, GY - 6, 4, 6, '#8a8478'); R(c, x + 24, GY - 6, 4, 6, '#8a8478'); },
    vaso: (c, x, s) => { R(c, x, GY - 14, 16, 14, '#8a8478'); R(c, x, GY - 14, 16, 2, '#b4ae9e'); R(c, x + 2, GY - 12, 12, 1, '#5a4232'); for (let k = 0; k < 7; k++) ell(c, x + 3 + k * 1.7, GY - 18 - (k % 3) * 4, 3, 4, k % 2 ? '#4f8a3a' : '#5f9a46'); if (hash(s) > .4) for (let k = 0; k < 3; k++) R(c, x + 3 + k * 4, GY - 22 - (k % 2) * 3, 2, 2, pick(['#e86a7a', '#f2c94c', '#f6f2ea', '#b86ad8'], s + k)); },
    saco: (c, x) => { ell(c, x + 5, GY - 5, 6, 5, '#1e1e22'); ell(c, x + 13, GY - 4, 5, 4, '#2a2a30'); R(c, x + 4, GY - 11, 2, 2, '#1e1e22'); R(c, x + 3, GY - 7, 2, 1, '#4a4a52'); },
    caixa: (c, x) => { R(c, x, GY - 12, 16, 12, '#b88a52'); R(c, x, GY - 12, 16, 2, '#d4a66a'); R(c, x + 7, GY - 12, 2, 12, '#9a6e3e'); R(c, x + 18, GY - 8, 10, 8, '#c49a62'); R(c, x + 18, GY - 8, 10, 1, '#dcb07a'); },
    cavalete: (c, x) => { limb(c, [[x + 2, GY], [x + 8, GY - 22]], 2, '#4a3a2a'); limb(c, [[x + 14, GY], [x + 8, GY - 22]], 2, '#4a3a2a'); R(c, x + 2, GY - 21, 13, 16, '#2a3a30'); R(c, x + 4, GY - 19, 9, 2, '#f2efe6'); R(c, x + 4, GY - 15, 7, 1, '#f2c94c'); R(c, x + 4, GY - 12, 8, 1, '#f2efe6'); },
    pipoca: (c, x) => { R(c, x, GY - 26, 22, 18, '#c43c3a'); R(c, x + 2, GY - 24, 18, 10, '#fff6d0'); for (let k = 0; k < 8; k++) R(c, x + 3 + (k % 4) * 4, GY - 22 + Math.floor(k / 4) * 3, 2, 2, '#f6e8a8'); R(c, x - 2, GY - 30, 26, 4, '#f2c94c'); ell(c, x + 4, GY - 3, 3, 3, '#1c1c1c'); ell(c, x + 18, GY - 3, 3, 3, '#1c1c1c'); limb(c, [[x + 22, GY - 12], [x + 30, GY - 16]], 1, '#5a5a56'); },
    correio: (c, x) => { R(c, x + 3, GY - 8, 2, 8, '#5a5a56'); R(c, x, GY - 22, 9, 14, '#f2c94c'); R(c, x, GY - 22, 9, 3, '#2c5aa8'); R(c, x + 2, GY - 16, 5, 1, '#2a2a2a'); },
    cadeiras: (c, x, s) => { const col = pick(['#f2f2ee', '#c43c3a', '#2c5aa8'], s); for (let k = 0; k < 2; k++) { const cx = x + k * 14; R(c, cx, GY - 7, 9, 2, col); R(c, cx, GY - 14, 2, 7, col); R(c, cx + 1, GY - 5, 1, 5, col); R(c, cx + 7, GY - 5, 1, 5, col); } R(c, x + 4, GY - 12, 18, 2, col); R(c, x + 12, GY - 10, 2, 10, col); },
    pare: (c, x) => { R(c, x + 4, GY - 26, 2, 26, '#8a8a86'); ell(c, x + 5, GY - 30, 6, 6, '#f2efe6'); ell(c, x + 5, GY - 30, 5, 5, '#c43c3a'); R(c, x + 2, GY - 31, 7, 1, '#f2efe6'); },
    tronco: (c, x) => { R(c, x, GY - 8, 34, 8, '#6a4a32'); R(c, x, GY - 8, 34, 2, '#8a6a45'); ell(c, x + 34, GY - 4, 4, 4, '#c8a06a'); ell(c, x + 34, GY - 4, 2, 2, '#9a7046'); R(c, x + 10, GY - 10, 3, 2, '#4f8a3a'); R(c, x + 22, GY - 9, 2, 1, '#5f9a46'); },
    toco: (c, x) => { R(c, x, GY - 10, 12, 10, '#6a4a32'); ell(c, x + 6, GY - 10, 6, 2, '#c8a06a'); R(c, x - 2, GY - 2, 3, 2, '#6a4a32'); R(c, x + 11, GY - 2, 3, 2, '#6a4a32'); },
    pedras: (c, x) => { ell(c, x + 6, GY - 4, 7, 5, '#8a8a80'); ell(c, x + 4, GY - 6, 4, 2, '#a6a69a'); ell(c, x + 16, GY - 3, 5, 3, '#7a7a70'); },
    cupim: (c, x) => { for (let k = 0; k < 10; k++) R(c, x + 8 - (10 - k) * .7, GY - k * 2.2, (10 - k) * 1.4 + 2, 3, k % 2 ? '#b07a4a' : '#a06a3e'); },
    carrinhoMao: (c, x) => { R(c, x + 4, GY - 12, 20, 7, '#3c6a8a'); R(c, x + 4, GY - 12, 20, 1, '#6a9ab8'); ell(c, x + 6, GY - 3, 3, 3, '#1c1c1c'); limb(c, [[x + 24, GY - 10], [x + 34, GY - 14]], 1, '#6a4a32'); R(c, x + 22, GY - 5, 2, 5, '#6a6a66'); },
    regador: (c, x) => { R(c, x, GY - 8, 10, 8, '#3c8a5a'); limb(c, [[x + 10, GY - 6], [x + 15, GY - 10]], 1, '#3c8a5a'); R(c, x + 2, GY - 11, 6, 2, '#3c8a5a'); },
    placaTrilha: (c, x) => { R(c, x + 6, GY - 22, 2, 22, '#6a4a32'); R(c, x, GY - 24, 18, 7, '#8a6a45'); R(c, x + 16, GY - 23, 3, 5, '#8a6a45'); R(c, x + 2, GY - 22, 12, 1, '#f2e8c8'); },
    bagagem: (c, x) => { R(c, x, GY - 4, 30, 3, '#8a949a'); ell(c, x + 4, GY - 1, 2, 2, '#1c1c1c'); ell(c, x + 26, GY - 1, 2, 2, '#1c1c1c'); R(c, x + 28, GY - 22, 2, 18, '#8a949a'); R(c, x + 2, GY - 14, 12, 10, '#c43c3a'); R(c, x + 14, GY - 18, 12, 14, '#3c6aa8'); R(c, x + 4, GY - 20, 8, 6, '#e8c24c'); },
    pisoMolhado: (c, x) => { limb(c, [[x + 2, GY], [x + 7, GY - 18]], 2, '#f2c94c'); limb(c, [[x + 12, GY], [x + 7, GY - 18]], 2, '#e8b83a'); R(c, x + 4, GY - 12, 6, 4, '#2a2a2a'); R(c, x + 6, GY - 11, 2, 2, '#f2c94c'); },
    isopor: (c, x) => { R(c, x, GY - 11, 18, 11, '#eef4f6'); R(c, x, GY - 11, 18, 3, '#3e7cc0'); R(c, x + 6, GY - 7, 6, 2, '#c43c3a'); }
  };
  const SET = { cidade: ['banco', 'vaso', 'saco', 'caixa', 'cavalete', 'pipoca', 'correio', 'cadeiras', 'pare', 'isopor'], natureza: ['tronco', 'toco', 'pedras', 'cupim', 'carrinhoMao', 'regador', 'placaTrilha', 'pedras'], interno: ['bagagem', 'pisoMolhado', 'cadeiras', 'vaso', 'banco'] };
  function objetos(c, id, W, set, from = 30, to = W - 30, gap = [70, 150]) {
    for (let x = from, i = 0; x < to; i++) { const kind = pick(SET[set], id * 31 + i); OBJ[kind](c, Math.round(x), id * 17 + i); x += gap[0] + hash(id * 13 + i) * (gap[1] - gap[0]); }
  }
  function chaoDetalhe(c, W, kind) { // folhas secas, papéis, pedrinhas e flores miúdas no chão da frente
    const n = W / 9; for (let i = 0; i < n; i++) { const x = hash(i * 1.37 + W) * W, y = 224 + hash(i * 2.71 + W) * 42, r = hash(i * 3.3);
      if (kind === 'interno') { if (r > .85) R(c, x, y, 6, 1, 'rgba(255,255,255,.35)'); continue; }
      if (r < .35) { R(c, x, y, 3, 2, pick(['#c47a35', '#a85a2a', '#d8a24a', '#8a6a3a'], i)); R(c, x + 1, y - 1, 1, 1, '#6a4a2a'); }
      else if (r < .5 && kind === 'cidade') { R(c, x, y, 4, 3, '#f2efe6'); R(c, x + 1, y + 1, 2, 1, '#9aa0a6'); }
      else if (r < .75) R(c, x, y, 2, 1, kind === 'natureza' ? '#9a8a6a' : '#8a867c');
      else if (kind === 'natureza') R(c, x, y, 2, 2, pick(['#e8c24c', '#f2efe6', '#c86ab8'], i)); }
  }

  /* =====================================================================
     PLATAFORMAS TEMÁTICAS (pixels do mundo, grão 2x2; o topo é a linha de pisar)
     ===================================================================== */
  const Q = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, Math.max(2, Math.round(w / 2) * 2), Math.max(2, Math.round(h / 2) * 2)); };
  const QL = (c, pts, w, col) => { for (let i = 1; i < pts.length; i++) { const a = pts[i - 1], b = pts[i], n = Math.max(1, Math.ceil(Math.hypot(b[0] - a[0], b[1] - a[1]) / 2)); for (let k = 0; k <= n; k++) Q(c, a[0] + (b[0] - a[0]) * k / n - w / 2, a[1] + (b[1] - a[1]) * k / n - w / 2, w, w, col); } };
  function sombra(c, x, y, w) { c.fillStyle = 'rgba(16,22,30,.16)'; c.fillRect(Math.round(x + 10), Math.round(y + 24), Math.round(w - 20), 6); }
  function concretoBase(c, x, y, w, h, top, face, seed) { Q(c, x - 2, y - 2, w + 4, h + 4, '#3a3a38'); Q(c, x, y, w, h, face); Q(c, x, y, w, 4, top); Q(c, x, y + 4, w, 2, '#ffffff22'); for (let i = 0; i < w * h / 26; i++) Q(c, x + hash(i + seed) * w, y + 6 + hash(i * 3 + seed) * (h - 8), 2, 2, i % 2 ? shadeHex(face, .9) : shadeHex(face, 1.06)); Q(c, x, y + h - 2, w, 2, shadeHex(face, .75)); }
  const PLAT = {
    12: (c, x, y, w, t, sd) => { // passarela de metal com grade e faixa de segurança
      sombra(c, x, y, w); Q(c, x - 2, y - 2, w + 4, 18, '#2a3036'); Q(c, x, y, w, 6, '#9aa4ac'); for (let k = 2; k < w - 2; k += 4) for (let j = 0; j < 4; j += 4) Q(c, x + k, y + 2 + j, 2, 2, '#5a646c'); Q(c, x, y, w, 2, '#c8d0d6');
      for (let k = 0; k < w; k += 8) { Q(c, x + k, y + 6, 4, 6, '#f2c230'); Q(c, x + k + 4, y + 6, 4, 6, '#1e1e20'); } Q(c, x, y + 12, w, 4, '#5a646c'); for (let k = 6; k < w; k += 20) Q(c, x + k, y + 13, 2, 2, '#b8c0c6');
      for (const sx of [x + 14, x + w - 18]) { QL(c, [[sx, y + 16], [sx + 6, y + 30]], 2, '#4a545c'); QL(c, [[sx + 6, y + 16], [sx, y + 30]], 2, '#4a545c'); } Q(c, x + Math.round(hash(sd) * (w - 20)), y + 14, 6, 2, '#8a4a2a'); },
    13: (c, x, y, w, t, sd) => { // laje de concreto com marquise pintada, azulejo, ferro aparecendo e vasinho
      sombra(c, x, y, w); const pint = pick(['#e8a87a', '#8ac0b0', '#e8d07a', '#c8a8d8', '#9ac0e0'], sd); concretoBase(c, x, y, w, 24, '#e2ded2', '#c8c2b4', sd); Q(c, x, y + 6, w, 6, pint); Q(c, x, y + 6, w, 2, shadeHex(pint, 1.15)); Q(c, x, y + 12, w, 6, '#ece8de'); for (let k = 0; k < w; k += 4) { Q(c, x + k, y + 12 + ((k / 4) % 2) * 2, 2, 2, '#4a8ac0'); Q(c, x + k + 2, y + 14 - ((k / 4) % 2) * 2, 2, 2, '#f2efe6'); } Q(c, x, y + 18, w, 2, '#9a948a');
      for (const ex of [x - 6, x + w + 2]) { Q(c, ex, y + 4, 4, 2, '#8a5a3a'); Q(c, ex, y + 10, 4, 2, '#8a5a3a'); }
      const vx = x + 10 + Math.round(hash(sd + 1) * (w - 40)); Q(c, vx, y - 10, 12, 10, '#b8643a'); Q(c, vx, y - 10, 12, 2, '#d8844a'); for (let k = 0; k < 4; k++) Q(c, vx + 1 + k * 3, y - 16 - (k % 2) * 4, 4, 6, k % 2 ? '#4f8a3a' : '#5f9a46'); Q(c, vx + 4, y - 20, 4, 4, pick(['#e86a7a', '#f2c94c', '#f6f2ea'], sd));
      Q(c, x + Math.round(hash(sd + 2) * (w - 10)), y + 14, 2, 6, '#9a948a'); },
    14: (c, x, y, w, t, sd) => { // cornija de pedra com molduras, mísulas e pombo
      sombra(c, x, y, w); Q(c, x - 4, y - 2, w + 8, 6, '#3a3630'); Q(c, x - 2, y + 14, w + 4, 4, 'rgba(40,32,20,.25)'); Q(c, x - 2, y, w + 4, 4, '#efe6cf'); Q(c, x, y + 4, w, 4, '#dcd0b4'); Q(c, x + 2, y + 8, w - 4, 4, '#c8bc9e'); Q(c, x + 4, y + 12, w - 8, 2, '#a89c80'); for (let i = 0; i < w / 6; i++) Q(c, x + hash(i + sd) * w, y + 4 + hash(i * 3 + sd) * 8, 2, 2, '#bfb398');
      for (let k = 10; k < w - 10; k += 30) { Q(c, x + k, y + 14, 8, 6, '#cfc3a6'); Q(c, x + k + 2, y + 20, 4, 4, '#bfb398'); Q(c, x + k + 2, y + 16, 2, 2, '#9a8e74'); }
      if (hash(sd + 5) > .3) { const px = x + 20 + Math.round(hash(sd + 6) * (w - 40)), bob = Math.round(Math.max(0, Math.sin(t * 3 + sd)) * 2); Q(c, px, y - 8, 10, 6, '#8a8f98'); Q(c, px + 8, y - 12 + bob, 6, 6, '#6a6f78'); Q(c, px + 12, y - 10 + bob, 2, 2, '#e8a83a'); Q(c, px + 8, y - 8 + bob, 4, 2, '#4aa05a'); Q(c, px + 2, y - 2, 2, 2, '#c87a6a'); Q(c, px + 6, y - 2, 2, 2, '#c87a6a'); } },
    15: (c, x, y, w, t, sd) => ilhaTerra(c, x, y, w, t, sd, { top: '#6f9a3a', top2: '#9cc45a', soil: '#7a5a3a', dark: '#5a4028', rock: '#8a8a80', cacto: true }),
    16: (c, x, y, w, t, sd) => { // mureta de concreto tipo New Jersey com faixa refletiva e pichação
      sombra(c, x, y, w); Q(c, x - 2, y - 2, w + 4, 22, '#3a3a38'); Q(c, x + 4, y, w - 8, 8, '#c8c6be'); Q(c, x, y + 8, w, 12, '#b4b2aa'); Q(c, x + 4, y, w - 8, 2, '#e4e2da'); Q(c, x, y + 8, w, 2, '#d0cec6');
      for (let k = 8; k < w - 8; k += 24) { Q(c, x + k, y + 12, 8, 4, '#f2c230'); Q(c, x + k, y + 12, 8, 2, '#fff2a0'); } for (let i = 0; i < w / 5; i++) Q(c, x + hash(i + sd) * w, y + 4 + hash(i * 3 + sd) * 14, 2, 2, '#a4a29a');
      const gx = x + 10 + Math.round(hash(sd) * (w - 50)); for (let k = 0; k < 30; k += 2) Q(c, gx + k, y + 10 + Math.round(Math.sin(k * .5 + sd) * 3), 2, 2, pick(['#e8433a', '#3c9ad8', '#2a2a2a'], sd)); },
    17: (c, x, y, w, t, sd) => { // bancada de caixotes de feira com frutas
      sombra(c, x, y, w); for (let k = 0; k < w; k += 30) { const cw = Math.min(30, w - k); Q(c, x + k, y, cw, 20, '#5a3a22'); Q(c, x + k + 2, y + 2, cw - 4, 16, '#b8864a'); for (let j = 0; j < 3; j++) Q(c, x + k + 2, y + 4 + j * 5, cw - 4, 2, '#8a5a30'); Q(c, x + k + 2, y + 2, cw - 4, 2, '#d8a66a'); }
      for (let k = 4; k < w - 4; k += 7) { const col = pick(['#f08a24', '#e84a3a', '#f2c94c', '#7cbf6a', '#c43c5a'], k + sd); Q(c, x + k, y - 6, 6, 6, col); Q(c, x + k + 2, y - 6, 2, 2, '#ffffff66'); } },
    18: (c, x, y, w, t, sd) => ilhaTerra(c, x, y, w, t, sd, { top: '#5f8a3a', top2: '#86b04a', soil: '#8a4a2e', dark: '#6a3620', rock: '#9a7a5a', cafe: true }), // terra roxa do planalto
    19: (c, x, y, w, t, sd) => { // treliça de palco com piso preto e lâmpadas piscando
      sombra(c, x, y, w); Q(c, x, y, w, 6, '#1e1c22'); Q(c, x, y, w, 2, '#3a3842'); Q(c, x, y + 8, w, 2, '#c8ccd2'); Q(c, x, y + 20, w, 2, '#c8ccd2');
      for (let k = 0; k < w - 6; k += 12) { QL(c, [[x + k, y + 9], [x + k + 6, y + 20]], 2, '#a8aeb6'); QL(c, [[x + k + 6, y + 20], [x + k + 12, y + 9]], 2, '#a8aeb6'); }
      for (let k = 6; k < w - 6; k += 16) { const on = (Math.floor(t * 4) + k / 16) % 3 !== 0; Q(c, x + k, y + 22, 4, 4, on ? pick(['#ffe39a', '#ff6a8a', '#6ac8ff'], k + sd) : '#5a5040'); } },
    20: (c, x, y, w, t, sd) => { // vidro com borda cromada, reflexo e floreiras nas pontas
      sombra(c, x, y, w); c.fillStyle = 'rgba(160,214,232,.55)'; c.fillRect(Math.round(x), Math.round(y + 4), Math.round(w), 12); Q(c, x - 2, y, w + 4, 4, '#dfe6ea'); Q(c, x - 2, y, w + 4, 2, '#ffffff'); Q(c, x - 2, y + 16, w + 4, 2, '#9aa6ae');
      for (let k = 12; k < w; k += 40) QL(c, [[x + k, y + 14], [x + k + 8, y + 6]], 2, 'rgba(255,255,255,.7)');
      for (const px of [x + 2, x + w - 14]) { Q(c, px, y - 8, 12, 8, '#5a6066'); for (let k = 0; k < 4; k++) Q(c, px + k * 3, y - 14 - (k % 2) * 4, 4, 6, k % 2 ? '#4f8a3a' : '#5f9a46'); } },
    21: (c, x, y, w, t, sd) => { // concreto da escola com faixa azul e grama em cima
      sombra(c, x, y, w); concretoBase(c, x, y, w, 18, '#e8e6de', '#d4d0c6', sd); Q(c, x, y + 8, w, 4, '#2c5a9e'); Q(c, x, y + 12, w, 2, '#f2f2ee');
      for (let k = 0; k < w; k += 3) Q(c, x + k, y - 2 - Math.round(hash(k + sd) * 4), 2, 4, k % 2 ? '#5f9a46' : '#79b04a'); Q(c, x, y, w, 2, '#4f8a3a'); }
  };
  function ilhaTerra(c, x, y, w, t, sd, o) { // ilha de terra: camadas onduladas, base arredondada com torrões, raízes e musgo
    sombra(c, x, y, w);
    const depthAt = (k) => { const u = k / w; return 14 + Math.sin(u * Math.PI) * 16 + Math.sin(u * 7 + sd) * 3 + (hash(Math.floor(k / 14) + sd) > .6 ? 5 * Math.sin(((k % 14) / 14) * Math.PI) : 0); };
    const light = shadeHex(o.soil, 1.18), strata = shadeHex(o.soil, .82);
    for (let k = 0; k < w; k += 2) { const d = Math.round(depthAt(k) / 2) * 2;
      Q(c, x + k, y + 4, 2, d, o.soil); Q(c, x + k, y + 4, 2, 4, light); // terra de cima mais clara
      for (let s = 10; s < d - 2; s += 7) Q(c, x + k, y + 4 + s + Math.round(Math.sin(k * .12 + s + sd) * 1.5), 2, 2, strata); // camadas
      Q(c, x + k, y + 4 + d - 2, 2, 2, o.dark); Q(c, x + k, y + 4 + d, 2, 2, 'rgba(30,20,10,.35)'); }
    Q(c, x - 2, y + 4, 2, depthAt(0) * .6, o.dark); Q(c, x + w, y + 4, 2, depthAt(w) * .6, o.dark);
    for (let i = 0; i < w / 9; i++) { const sx = x + 4 + hash(i * 1.7 + sd) * (w - 8), sy = y + 10 + hash(i * 2.3 + sd) * (depthAt(sx - x) - 12); Q(c, sx, sy, 2, 2, hash(i + sd) > .5 ? o.dark : light); }
    for (let i = 0; i < w / 34; i++) { const rx = x + 10 + hash(i + sd) * (w - 24), ry = y + 12 + hash(i * 3 + sd) * 8; Q(c, rx, ry, 10, 6, o.rock); Q(c, rx + 2, ry, 6, 2, shadeHex(o.rock, 1.25)); Q(c, rx, ry + 4, 10, 2, shadeHex(o.rock, .8)); }
    for (let i = 0; i < w / 36; i++) { const rx = x + 14 + hash(i * 5 + sd) * (w - 28), base = y + 4 + depthAt(rx - x), len = 8 + hash(i * 7 + sd) * 14; for (let k = 0; k < len; k += 2) Q(c, rx + Math.sin(k * .4 + t * 1.2 + i) * 2, base + k - 2, 2, 2, k > len - 4 ? '#8a6a3a' : '#5a3a20'); }
    for (const ex of [x - 2, x + w - 4]) for (let k = 0; k < 10; k += 2) Q(c, ex + Math.sin(k + t) * 1, y + 4 + k, 4, 2, k < 6 ? o.top : shadeHex(o.top, .8)); // musgo escorrendo nas pontas
    Q(c, x - 2, y, w + 4, 6, o.top); Q(c, x - 2, y, w + 4, 2, o.top2); Q(c, x - 2, y + 6, w + 4, 2, shadeHex(o.top, .7));
    for (let k = 0; k < w; k += 3) { const sw = Math.round(Math.sin(t * 2.4 + k * .2 + sd) * 1); Q(c, x + k + sw, y - 2 - Math.round(hash(k + sd) * 5), 2, 4, k % 2 ? o.top : o.top2); }
    for (let i = 0; i < w / 24; i++) { const fx = x + 6 + hash(i * 11 + sd) * (w - 12); Q(c, fx, y - 8, 2, 4, o.top); Q(c, fx - 2, y - 10, 6, 4, pick(['#e86a8a', '#f2c94c', '#f6f2ea', '#b86ad8'], i + sd)); Q(c, fx, y - 10, 2, 2, '#f2e06a'); }
    if (o.cacto && hash(sd) > .4) { const cx = x + 12 + Math.round(hash(sd + 3) * (w - 30)); Q(c, cx, y - 10, 12, 10, '#3f7a4a'); for (let k = 0; k < 12; k += 4) Q(c, cx + k, y - 10, 2, 10, '#2a5a32'); Q(c, cx + 2, y - 14, 8, 4, '#c43c5a'); }
    if (o.cafe) for (let k = 12; k < w - 12; k += 30) { Q(c, x + k, y - 12, 2, 10, '#6a4a2a'); Q(c, x + k - 6, y - 12, 14, 6, '#2f5a34'); Q(c, x + k - 4, y - 16, 10, 4, '#3a6a3c'); Q(c, x + k - 2, y - 8, 2, 2, '#d8343a'); Q(c, x + k + 4, y - 10, 2, 2, '#c42a2a'); }
  }
  function plataforma(c, scene, p, t) { const f = PLAT[scene]; if (!f) return false; const [x, y, w] = p; c.save(); c.imageSmoothingEnabled = false; f(c, x, y, w, Number(t) || 0, Math.round(x * 7 + y * 3)); c.restore(); return true; }

  // vãos no chão: buraco da obra, ravina da serra e canal de irrigação
  function holes(c, id, camL) {
    const L = LAYOUT[id]; if (!L || !L.gaps.length) return;
    for (const [gx, gw] of L.gaps) { const x = gx / 2 - camL, w = gw / 2; if (!vis(x, w + 20)) continue;
      const deep = id === 15 ? '#2a2620' : id === 18 ? '#3c6a8a' : '#1c1c1c'; R(c, x, FLOOR, w, LH - FLOOR, deep); R(c, x, FLOOR, w, 3, id === 18 ? '#8ac4d8' : '#3c3a34'); R(c, x - 2, FLOOR, 2, LH - FLOOR, '#4a3a2a'); R(c, x + w, FLOOR, 2, LH - FLOOR, '#4a3a2a');
      if (id === 16) for (const cx of [x - 8, x + w + 2]) { R(c, cx, FLOOR - 9, 6, 9, '#f08a24'); R(c, cx + 1, FLOOR - 6, 4, 2, '#f2f2ee'); } }
  }
  const textOf = (d) => (c, camera) => { c.save(); c.translate(-Math.round(camera), 0); for (const lb of d.labels || []) { const [x, y, str, size, col] = lb, a = d.labelAlpha ? d.labelAlpha(lb) : 1; if (a <= .01) continue; c.globalAlpha = a; text(c, str, x * 2, y * 2, size, col); } c.restore(); }; // labelAlpha: some com o cenário (ex.: escada da escola)
  const PUBLIC = [];
  function registrar(d, layout) { // usado aqui e pelos ambientes (cenas 22+)
    if (layout) LAYOUT[d.id] = layout; if (!LAYOUT[d.id]) LAYOUT[d.id] = { platforms: [], gaps: [] };
    const draw = d.draw; window.HdMaps.register(d.id, { ...d, always: true, text: textOf(d), draw: (c, s, t, camL) => { draw(c, s, t, camL); holes(c, d.id, camL); } }); window.Interact?.addScene?.(d.id, d.interact || []);
    const i = LIST.findIndex((x) => x.id === d.id); if (i >= 0) LIST[i] = d; else LIST.push(d);
    const pub = Object.freeze({ id: d.id, key: d.key, nome: d.nome, lugar: d.lugar, largura: d.width, noite: !!d.noite, interno: !!d.amb, plataformas: LAYOUT[d.id].platforms, vaos: LAYOUT[d.id].gaps, interativos: (d.interact || []).length, grupo: d.grupo || 'cenario', limites: d.limites || null });
    const j = PUBLIC.findIndex((x) => x.id === d.id); if (j >= 0) PUBLIC[j] = pub; else PUBLIC.push(pub);
    if (d.plat) PLAT[d.id] = d.plat;
  }
  for (const d of LIST.slice()) registrar(d);

  // Art.drawScene para as cenas novas (também na qualidade baixa, que não usa o HdMaps nas fases antigas)
  const baseScene = window.Art?.drawScene;
  if (baseScene) window.Art.drawScene = function (c, scene, camera = 0, t = 0) {
    if (!(scene >= 12 && LIST.some((d) => d.id === scene))) return baseScene(c, scene, camera, t);
    c.save(); c.imageSmoothingEnabled = false; c.beginPath(); c.rect(0, 0, 960, 540); c.clip();
    if (window.HdMaps.draw(c, scene, Number(camera) || 0, Number(t) || 0)) window.HdMaps.finish(c, scene);
    c.restore();
  };
  // ferramentas de desenho para os outros arquivos da Campanha 2 (mesmo estilo e mesmas peças)
  const arte = Object.freeze({ K, GY, R, ell, mk, hash, cl, mix, dither, limb, sky, haze, tile, tree, slant, sunInfo, sunWall, board, bench, lampPost, lampGlow, shadeAdd, lightAdd, vis, night, text, shadeHex, pick,
    plaster, brick, azulejo, roofTiles, janela, ac, caixaDagua, antena, parabolica, varal, gato, cachorro, plantaVaso, grafite, cartaz, bandeirinhas, predio, loja, casa,
    orelhao, banca, ponto, lixeira, hidrante, placaRua, moto, bike, carro, poste, fios, canteiro, ipe, mesaBar, calcada, asfalto, pedraPortuguesa, pisoInterno, terra,
    conquistaBack, fog, cityNight, passaros, pipas, gente, pessoa, coluna, reflexo, vgrad, lerpC, produtos, lojaFrente, OBJ, objetos, chaoDetalhe, ilhaTerra, sombra: (c, x, y, w) => sombra(c, x, y, w), Q, QL, concretoBase,
    shopFar: () => (SHOPFAR || (SHOPFAR = buildShopFar())), SHOP, heroiPos: () => HERO });

  window.CampanhaCenarios = Object.freeze({
    get lista() { return Object.freeze(PUBLIC.slice()); },
    largura: (id) => LIST.find((d) => d.id === id)?.width || 0,
    layout: (id) => LAYOUT[id] || null,
    plataforma,
    heroi,
    registrar,
    arte
  });
})();
