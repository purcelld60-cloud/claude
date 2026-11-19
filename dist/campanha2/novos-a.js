/* Campanha 2 · Passo 2C (parte 1): cenários novos 28 a 31, no mesmo estilo dos outros
   (pixels de arte 482x270 escalados 2x, chão em y=220, várias camadas com parallax, gente, animações e luzes).
   28 Reserva Florestal do Poço Escuro · 29 Estádio Lomanto Júnior · 30 Terminal Rodoviário · 31 UESB.
   As lojas e empresas são paródias (só o nome). Nada aqui muda a campanha original. */
(() => {
  'use strict';
  if (window.CampanhaNovos || !window.CampanhaCenarios?.arte || !window.CampanhaCamadas?.kit) return;
  const CC = window.CampanhaCenarios, A = CC.arte, K = window.CampanhaCamadas.kit;
  const { R, ell, mk, hash, cl, mix, limb, tile, sky, haze, tree, vis, night, shadeHex, pick, lightAdd, lampGlow, vgrad, reflexo, gente, pessoa, plaster, brick, roofTiles, janela, caixaDagua, antena,
    cartaz, bandeirinhas, gato, cachorro, plantaVaso, lampPost, bench, ipe, fog, conquistaBack, passaros, objetos, chaoDetalhe, terra, pedraPortuguesa, calcada, asfalto, pisoInterno, grafite, Q, QL, sombra, concretoBase, lerpC, GY, sunInfo } = A;
  const { pxText, largura, pessoinha, carrinho, arvoreM, nevoa, buildRua, noiteTile, andaRua, scr, wrap, balao, SKIN, ROUPA, T, OUTDOORS } = K;
  const LW = 482, LH = 270, TAU = Math.PI * 2;
  const HERO = () => A.heroiPos();
  const drawMid = (c, mid, camL) => c.drawImage(mid, camL, 0, LW, LH, 0, 0, LW, LH);
  const indoor = (k) => (s) => mix(s.amb, [1, 1, 1], k);
  const placa = (c, x, y, w, h, col = '#8a6a45') => { R(c, x + 3, y + h, 2, 210 - y - h, '#5a3a20'); R(c, x + w - 5, y + h, 2, 210 - y - h, '#5a3a20'); R(c, x - 1, y - 1, w + 2, h + 2, '#4a2e18'); R(c, x, y, w, h, col); R(c, x, y, w, 1, shadeHex(col, 1.25)); };
  const nota = (c, x, y, col) => { R(c, x, y, 2, 2, col); R(c, x + 1, y - 5, 1, 5, col); R(c, x + 2, y - 5, 2, 1, col); }; // notinha musical
  const vaoAgua = { fundo: '#163c3a', borda: '#7ac0b8' };

  /* =====================================================================
     28 · RESERVA FLORESTAL DO POÇO ESCURO (mata atlântica dentro da cidade)
     ===================================================================== */
  const POCO = { W: 2600, POOL: 1290, GUARITA: 2150, ARV: [[70, 22], [420, 26], [770, 18], [1110, 24], [1700, 26], [1990, 20], [2420, 24]] };
  const F28 = {};
  function buildMataLonge() { // morros cobertos de mata, azulados pela distância
    const [cv, c] = mk(T, LH), hy = (x) => 96 + Math.sin(x / T * TAU * 3) * 9 + Math.sin(x / T * TAU * 8 + 1) * 4;
    for (let x = 0; x < T; x++) { const y = Math.round(hy(x)); R(c, x, y, 1, LH - y, '#7f9c8e'); R(c, x, y, 1, 1, '#9ab8a8'); }
    for (let i = 0; i < 600; i++) { const x = hash(i + 280) * T, y = hy(x) + 2 + hash(i + 281) * 60; ell(c, x, y, 3 + hash(i) * 5, 2.5 + hash(i * 3) * 3, pick(['#86a596', '#7a988a', '#90ae9e', '#749284'], i)); }
    nevoa(c, T, 'rgba(205,220,228,.32)'); return cv;
  }
  function buildCopa() { // copas mais perto, com troncos claros aparecendo
    const [cv, c] = mk(T, LH);
    for (let i = 0; i < 100; i++) { const x = hash(i + 290) * T, top = 72 + hash(i + 291) * 52; R(c, x, top + 10, 2, 200 - top, '#6a7a64');
      for (let k = 0; k < 8; k++) ell(c, x + (hash(i * 9 + k) - .5) * 32, top + hash(i * 5 + k) * 26, 9 + hash(k + i) * 7, 7 + hash(k * 3 + i) * 5, pick(['#5a8a5e', '#62926a', '#4f7e54', '#72a270'], i + k)); }
    R(c, 0, 184, T, LH - 184, '#4a6e4c'); nevoa(c, T, 'rgba(196,214,206,.24)'); return cv;
  }
  function buildTroncos() { // interior da mata: troncos, cipós, samambaias, bromélias e o teto de folhas
    const [cv, c] = mk(T, LH);
    for (let i = 0; i < 48; i++) { const x = Math.round(hash(i + 300) * T), w = 3 + Math.round(hash(i + 301) * 6), col = pick(['#5a4e3e', '#6a5a46', '#4e4436', '#7a6a52'], i);
      R(c, x, 0, w, 206, col); R(c, x, 0, 1, 206, shadeHex(col, 1.25)); R(c, x + w - 1, 0, 1, 206, shadeHex(col, .72)); for (let y = 10; y < 200; y += 9) if (hash(x + y) > .62) R(c, x, y, w, 2, '#6a9450');
      if (hash(i + 302) > .5) { const by = 60 + hash(i + 303) * 100; ell(c, x + (hash(i) > .5 ? w + 2 : -2), by, 4, 2, '#4a8a46'); R(c, x + w, by - 3, 1, 3, '#d84a6a'); } }
    for (let i = 0; i < 34; i++) { const x0 = hash(i + 320) * T, x1 = x0 + 20 + hash(i + 321) * 50, sag = 30 + hash(i + 322) * 70; for (let k = 0; k <= 24; k++) { const u = k / 24; R(c, x0 + (x1 - x0) * u, 6 + Math.sin(u * Math.PI) * sag, 1, 2, '#5a6a3a'); } }
    for (let x = 0; x < T; x += 2) { const h = 6 + hash(x * .7) * 14; limb(c, [[x, 208], [x + (hash(x) - .5) * 7, 208 - h]], 1, x % 3 ? '#4a7a40' : '#62904c'); }
    for (let i = 0; i < 80; i++) { const x = hash(i + 340) * T; for (let k = 0; k < 6; k++) ell(c, x + (k - 3) * 6, 3 + hash(i * 7 + k) * 22, 9, 7, pick(['#2f5a32', '#3a6a3a', '#28502c', '#447a40'], i + k)); }
    R(c, 0, 205, T, 4, '#3a3024'); nevoa(c, T, 'rgba(160,196,160,.16)');
    return { cv, f: .38 };
  }
  function arvoreGrande(c, x, w, seed) { // tronco grosso com sapopemba, musgo, bromélia, orquídea e oco
    const col = pick(['#5a4632', '#4e3e2c', '#64503a'], seed);
    R(c, x, 0, w, 214, col); for (let k = 0; k < w; k += 3) R(c, x + k, 0, 1, 214, shadeHex(col, hash(k + seed) > .5 ? .8 : 1.15));
    R(c, x, 0, 3, 214, shadeHex(col, 1.22)); R(c, x + w - 4, 0, 4, 214, shadeHex(col, .62));
    for (let y = 16; y < 204; y += 5) if (hash(y + seed) > .58) { R(c, x - 1, y, 3 + hash(y) * 7, 3, '#5f8a46'); R(c, x, y, 2, 1, '#86b45e'); }
    for (const side of [-1, 1]) for (let k = 0; k < 3; k++) { const h = 24 - k * 7; for (let j = 0; j < h; j++) { const rx = side < 0 ? x - 3 - k * 6 + j * .25 : x + w + k * 6 - j * .25; R(c, rx, 214 - j, 4, 1, shadeHex(col, .9 - k * .06)); } }
    const by = 84 + hash(seed) * 60; for (let k = 0; k < 7; k++) limb(c, [[x + w + 1, by], [x + w + 3 + k, by - 7 + Math.abs(k - 3)]], 1, k % 2 ? '#3f7a3a' : '#5a9a46'); R(c, x + w + 4, by - 4, 2, 3, '#e8433a');
    if (hash(seed + 1) > .35) { const oy = by + 34; R(c, x - 3, oy, 3, 2, '#e8a8d8'); R(c, x - 2, oy - 2, 2, 2, '#f6d8ee'); R(c, x - 1, oy + 2, 1, 5, '#5a8a46'); }
    for (let k = 0; k < 4; k++) { const cy = 150 + k * 9 + hash(seed + k) * 4; ell(c, x + w + 1, cy, 3, 1.5, pick(['#e8833a', '#f2c94c', '#f2efe6'], seed + k)); } // orelha-de-pau
    ell(c, x + w / 2, 118, 4, 6, '#1c140c'); ell(c, x + w / 2, 117, 3, 5, '#2a1e12');
  }
  function buildPoco() {
    const W = POCO.W, [cv, c] = mk(W, LH), p = POCO.POOL;
    R(c, 0, 194, W, 26, '#4a3a28'); for (let i = 0; i < W * 2; i++) R(c, hash(i * 1.3) * W, 194 + hash(i * 2.1) * 26, 2, 1, pick(['#6a4a2a', '#8a5a2a', '#5a7a3a', '#a86a2a', '#3a2a1a', '#b8862a'], i));
    for (let x = 0; x < W; x += 3) if (hash(x * .37) > .4) { const h = 5 + hash(x) * 12; limb(c, [[x, 200], [x + (hash(x * 3) - .5) * 6, 200 - h]], 1, x % 2 ? '#3f6a36' : '#5a8a46'); }
    // cerquinha da trilha (corrimão de madeira)
    for (let x = 0; x < W; x += 64) { if (x > p - 90 && x < p + 330) continue; R(c, x, 194, 3, 18, '#6a4a2a'); R(c, x + 32, 194, 3, 18, '#6a4a2a'); R(c, x, 197, 64, 2, '#8a6a45'); R(c, x, 197, 64, 1, '#a8845a'); R(c, x, 204, 64, 2, '#8a6a45'); }
    // o poço: paredão de pedra com musgo, cascata e a água escura lá embaixo
    for (let i = 0; i < 46; i++) { const rx = p + 10 + hash(i + 500) * 250, ry = 70 + hash(i + 501) * 120, rw = 14 + hash(i) * 18, rh = 10 + hash(i * 3) * 12; ell(c, rx, ry, rw, rh, pick(['#5f5f58', '#6a6a62', '#52524c', '#76766c'], i)); ell(c, rx - rw * .2, ry - rh * .3, rw * .6, rh * .45, pick(['#7a7a70', '#86867c'], i)); if (hash(i + 502) > .4) ell(c, rx + rw * .2, ry - rh * .7, rw * .5, 3, '#5f8a46'); }
    for (let k = 0; k < 24; k++) limb(c, [[p + 40 + k * 9, 70 + hash(k) * 30], [p + 38 + k * 9 + hash(k * 2) * 4, 100 + hash(k * 3) * 60]], 1, '#4a7a3a'); // raízes e trepadeiras
    R(c, p + 112, 70, 34, 8, '#4a4a44'); R(c, p + 112, 70, 34, 2, '#6a6a62');
    ell(c, p + 130, 202, 128, 13, '#0e2422'); ell(c, p + 130, 201, 120, 10, '#163634'); for (let k = 0; k < 14; k++) R(c, p + 30 + k * 15, 198 + (k % 3) * 2, 8, 1, 'rgba(160,220,210,.25)');
    for (const [rx, ry] of [[p + 10, 200], [p + 250, 198], [p + 60, 210], [p + 200, 210]]) { ell(c, rx, ry, 14, 7, '#6a6a62'); ell(c, rx - 3, ry - 2, 8, 3, '#86867c'); ell(c, rx + 2, ry - 5, 6, 2, '#5f8a46'); }
    // tronco caído com cogumelos, cupinzeiro e pedras
    const tx = 560; R(c, tx, 202, 76, 11, '#5a4030'); R(c, tx, 202, 76, 2, '#7a5a40'); ell(c, tx + 76, 207, 5, 6, '#c8a06a'); ell(c, tx + 76, 207, 3, 4, '#9a7046'); for (let k = 0; k < 5; k++) { R(c, tx + 10 + k * 13, 198, 2, 4, '#f2e8d0'); ell(c, tx + 11 + k * 13, 198, 4, 2, k % 2 ? '#e8833a' : '#c43c3a'); R(c, tx + 9 + k * 13, 197, 1, 1, '#f2efe6'); }
    for (let k = 0; k < 9; k++) R(c, 980 + 6 - (9 - k) * .7, 210 - k * 2.4, (9 - k) * 1.4 + 3, 3, k % 2 ? '#b07a4a' : '#a06a3e');
    // placas da trilha
    placa(c, 180, 158, 64, 18); placa(c, 880, 160, 70, 16, '#7a5a3a'); placa(c, p - 70, 156, 54, 16, '#6a8a3a'); placa(c, 1830, 162, 50, 14);
    R(c, 892, 163, 10, 10, '#f2c94c'); R(c, 894, 165, 6, 6, '#8a8a80'); R(c, 893, 169, 8, 1, '#c43c3a');
    // guarita do guarda-parque
    const g = POCO.GUARITA; for (let k = 0; k < 64; k += 4) { R(c, g + k, 148, 4, 62, k % 8 ? '#8a6a45' : '#7a5a3a'); R(c, g + k, 148, 1, 62, '#a8845a'); } roofTiles(c, g - 6, 140, 76, 8, '#6a4a32');
    R(c, g + 8, 160, 22, 16, '#3a2a1a'); vgrad(c, g + 9, 161, 20, 14, '#8ab0b8', '#5a7a84'); R(c, g + 18, 161, 1, 14, '#3a2a1a'); ell(c, g + 13, 170, 3, 3, '#9a6440'); R(c, g + 10, 173, 6, 3, '#3c6a3a'); R(c, g + 11, 166, 5, 2, '#5a6a3a');
    R(c, g + 40, 168, 16, 42, '#5a3a20'); R(c, g + 52, 188, 2, 3, '#e8c24c'); R(c, g + 20, 150, 26, 7, '#3c6a3a'); R(c, g + 21, 151, 24, 5, '#5a8a46'); R(c, g + 66, 172, 4, 6, '#2a2a2a'); R(c, g + 67, 173, 2, 3, '#ffe39a');
    // árvores grandes por cima e o teto de folhas
    for (const [x, w] of POCO.ARV) arvoreGrande(c, x, w, x);
    for (let i = 0; i < W / 5; i++) { const x = hash(i + 600) * W; ell(c, x, hash(i + 601) * 30, 10 + hash(i) * 8, 7 + hash(i * 2) * 5, pick(['#2a4e2c', '#335c34', '#24452a', '#3e6a3a'], i)); }
    for (let i = 0; i < W / 30; i++) { const x = hash(i + 620) * W; for (let k = 0; k < 18; k++) R(c, x + Math.sin(k * .5) * 2, 28 + k * 2, 1, 2, '#3a5a2e'); ell(c, x, 66, 2, 2, '#4a7a3a'); } // cipós pendurados
    terra(c, W, '#5a7a36', '#4a6a2e'); for (let i = 0; i < W * 3; i++) R(c, hash(i * 3.7) * W, 222 + hash(i * 1.9) * 48, 2, 1, pick(['#8a5a2a', '#a86a2a', '#6a4a2a', '#c88a3a', '#5a7a3a'], i));
    chaoDetalhe(c, W, 'natureza');
    return cv;
  }
  function poco(c, s, t, camL) {
    if (!F28.mid) { F28.longe = buildMataLonge(); F28.copa = buildCopa(); F28.tr = buildTroncos(); F28.mid = buildPoco(); }
    const nt = night(s), p = POCO.POOL;
    sky(c, s, t, camL); tile(c, F28.longe, camL * .05); haze(c, s, t, camL, 90, 170); tile(c, F28.copa, camL * .14);
    { const per = 38, ph = (t % per) / per; if (ph < .35 && nt < .6) { const k = ph / .35, x = -30 + k * 560, y = 70 + Math.sin(k * 9) * 5, f = Math.sin(t * 14) > 0; R(c, x, y, 9, 4, '#1c1c1c'); R(c, x + 9, y, 7, 3, '#f08a24'); R(c, x + 14, y + 1, 2, 2, '#c43c3a'); R(c, x + 6, y + 1, 3, 3, '#f2efe6'); R(c, x + 1, y - (f ? 4 : -3), 6, 2, '#2a2a2a'); R(c, x - 4, y + 1, 4, 2, '#1c1c1c'); } } // tucano
    tile(c, F28.tr.cv, camL * F28.tr.f);
    for (let i = 0; i < 4; i++) { const cyc = 6 + i, ph = ((t + i * 2.3) % cyc) / cyc, j = Math.floor((t + i * 2.3) / cyc), x0 = 120 + ((j * 97 + i * 211) % 1100), x1 = x0 + 50, u = cl(ph * 3), x = x0 + (x1 - x0) * u, y = 70 + i * 22 - Math.sin(u * Math.PI) * 18, sx = scr({ f: F28.tr.f }, x, camL); // saguis pulando de galho em galho
      if (!vis(sx, 10)) continue; R(c, sx, y, 5, 3, '#8a8478'); R(c, sx + 4, y - 2, 3, 3, '#6a645a'); R(c, sx + 4, y - 3, 1, 1, '#f2efe6'); R(c, sx + 6, y - 3, 1, 1, '#f2efe6'); for (let k = 0; k < 6; k++) R(c, sx - 1 - k, y + 1 + Math.round(Math.sin(k * .8 + t * 3)), 1, 1, k % 2 ? '#3a3630' : '#b8b0a2'); }
    if (nt < .5) { c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 6; i++) { const x = ((i * 157 - camL * .9) % 700 + 700) % 700 - 80, a = (.05 + Math.sin(t * .4 + i) * .025) * (1 - nt * 2); c.fillStyle = `rgba(255,248,200,${a})`; c.beginPath(); c.moveTo(x, 0); c.lineTo(x + 14, 0); c.lineTo(x + 60, 220); c.lineTo(x + 34, 220); c.fill(); } c.restore(); } // raios de sol entre as folhas
    drawMid(c, F28.mid, camL);
    { const x = p + 116 - camL; if (vis(x, 60)) { for (let k = 0; k < 26; k += 2) { const y0 = 78 + ((t * 70 + k * 13) % 110); R(c, x + k, 78, 2, 118, k % 4 ? 'rgba(170,220,228,.55)' : 'rgba(220,244,248,.7)'); R(c, x + k, y0, 2, 6, 'rgba(255,255,255,.8)'); }
      for (let i = 0; i < 8; i++) { const q = (t * .6 + i / 8) % 1; ell(c, x + 13 + (i - 4) * 5 * q, 194 - q * 14, 3 + q * 6, 2 + q * 3, `rgba(240,250,250,${(1 - q) * .5})`); } // espuma e névoa
      for (let k = 0; k < 3; k++) { const r = ((t * 14 + k * 20) % 60); c.strokeStyle = `rgba(190,235,230,${(1 - r / 60) * .5})`; c.beginPath(); c.ellipse(x + 13, 200, r * 1.4, r * .14, 0, 0, TAU); c.stroke(); } } }
    { const x = p + 248 - camL, puff = Math.sin(t * 2.4) > .6; if (vis(x, 10)) { R(c, x, 188, 6, 4, '#4a8a3a'); R(c, x + 1, 187, 1, 1, '#f2c94c'); R(c, x + 4, 187, 1, 1, '#f2c94c'); if (puff) ell(c, x + 3, 192, 3, 2, '#c8e0a0'); } } // sapinho na pedra
    if (nt > .3) for (const [ax, w] of POCO.ARV) { const x = ax + w / 2 - camL; if (vis(x, 10) && Math.floor(t * .7 + ax) % 5) { R(c, x - 2, 116, 1, 1, '#ffe24a'); R(c, x + 1, 116, 1, 1, '#ffe24a'); } } // coruja no oco
    for (let i = 0; i < 4; i++) { const x = ((i * 233 + t * 14) % 900) - camL * .0 - 40 + Math.sin(t * .8 + i) * 30, y = 130 + i * 18 + Math.sin(t * 1.6 + i * 2) * 16, f = Math.sin(t * 16 + i) > 0; if (nt > .6) break; R(c, x, y, 1, 3, '#2a2a2a'); R(c, x - 3, y + (f ? 0 : 1), 3, f ? 3 : 1, '#3a8ae8'); R(c, x + 1, y + (f ? 0 : 1), 3, f ? 3 : 1, '#3a8ae8'); } // borboletas azuis
    for (let i = 0; i < 12; i++) { const k = (t * .05 + i / 12) % 1, x = ((i * 97 - camL * .9) % 520 + 520) % 520 - 20 + Math.sin(t * 1.3 + i) * 10, y = k * 230; R(c, x, y, 2, 1, pick(['#c8882a', '#a86a2a', '#7a9a3a', '#d8a83a'], i)); } // folhas caindo
    if (nt > .2) for (let i = 0; i < 30; i++) { const x = ((hash(i) * 700 - camL * .7) % 600 + 600) % 600 - 60 + Math.sin(t * .7 + i) * 12, y = 120 + hash(i * 3) * 90 + Math.sin(t * .9 + i * 2) * 8; if (Math.sin(t * 2 + i * 1.7) > .1) { c.globalAlpha = nt; R(c, x, y, 1, 1, '#d8ff7a'); c.globalAlpha = 1; } } // vaga-lumes
    fog(c, s, t, camL, .32);
  }
  function pocoLights(g, s, t, camL) { const a = night(s); if (a > .2) { for (let i = 0; i < 30; i++) { const x = ((hash(i) * 700 - camL * .7) % 600 + 600) % 600 - 60 + Math.sin(t * .7 + i) * 12, y = 120 + hash(i * 3) * 90 + Math.sin(t * .9 + i * 2) * 8; if (Math.sin(t * 2 + i * 1.7) > .1) lightAdd(x, y, .25 * a, 10); } const gx = POCO.GUARITA + 68 - camL; if (vis(gx)) lightAdd(gx, 175, .7 * a, 50); } }

  /* =====================================================================
     29 · ESTÁDIO LOMANTO JÚNIOR (o Lomantão): lado de fora, portão e a pista com o jogo rolando
     ===================================================================== */
  const EST = { W: 2800, PORTAO: 650, BANCO: [1150, 1950], STX: 380, SW: 1500 };
  const F29 = {};
  const PLACAR = () => { const t = performance.now() / 1000, gols = Math.floor(t / 45); return { a: 1 + Math.floor((gols + 1) / 2), b: Math.floor(gols / 2), gol: (t % 45) < 4, min: 1 + Math.floor((t * 1.5) % 45) }; };
  function buildArquibancada() { // o outro lado do campo: arquibancada cheia, cobertura, refletores e placas de publicidade
    const SW = EST.SW, [cv, c] = mk(SW, LH), [nv, n] = mk(SW, LH);
    R(c, 0, 60, SW, 112, '#8a8e94');
    for (let r = 0; r < 14; r++) { const y = 70 + r * 7; R(c, 0, y, SW, 7, r % 2 ? '#9a9ea4' : '#8a8e94'); R(c, 0, y + 6, SW, 1, '#6a6e74'); }
    for (let k = 0; k < SW; k += 220) { R(c, k, 64, 6, 108, '#6a6e74'); R(c, k + 1, 64, 1, 108, '#a8acb2'); } // escadas
    R(c, 0, 48, SW, 14, '#c8ccd2'); R(c, 0, 48, SW, 2, '#e8ecef'); for (let k = 0; k < SW; k += 30) { R(c, k, 62, 3, 10, '#7a7e84'); } R(c, 0, 60, SW, 2, '#5a5e64'); // cobertura
    R(c, 0, 168, SW, 12, '#2a2e34'); for (let k = 0, i = 0; k < SW; k += 60, i++) { const L = OUTDOORS[i % OUTDOORS.length]; R(c, k + 1, 169, 58, 10, L[1]); pxText(c, L[0].split(':')[0].slice(0, 14), k + 30, 171, L[2]); } // placas de publicidade
    for (const fx of [120, 520, 980, 1380]) { R(c, fx, 0, 4, 64, '#6a6e74'); R(c, fx - 14, 0, 32, 16, '#3a3e44'); for (let k = 0; k < 6; k++) for (let j = 0; j < 2; j++) { R(c, fx - 12 + k * 5, 2 + j * 7, 4, 5, '#e8eaec'); R(n, fx - 12 + k * 5, 2 + j * 7, 4, 5, '#fffbe0'); } }
    const px = 700; R(c, px - 60, 4, 120, 40, '#1a1c20'); R(c, px - 58, 6, 116, 36, '#0c0e10'); R(c, px - 4, 44, 8, 16, '#5a5e64');
    nevoa(c, SW, 'rgba(200,214,226,.12)');
    return { cv, nv };
  }
  function torcida(c, x0, x1, y0, t, ola, pulo, rows = 13) { // a torcida de longe: cabecinhas e camisas, com ola e pulo de gol
    for (let r = 0; r < rows; r++) { const y = y0 + r * 7; for (let x = x0 + (r % 2) * 2; x < x1; x += 4) { const i = Math.floor(x * 7 + r * 13), sx = x; if (hash(i) < .18) continue; const up = (Math.abs(sx - ola) < 18 ? 3 : 0) + (pulo ? Math.round(Math.abs(Math.sin(t * 9 + i)) * 2) : 0);
      R(c, sx, y + 2 - up, 3, 3, pick(['#e8433a', '#f2efe6', '#2c5a9e', '#e8c24c', '#e8433a', '#2a2a2a'], i)); R(c, sx + 1, y - up, 2, 2, pick(SKIN, i)); } } }
  function buildEstadio() {
    const W = EST.W, [cv, c] = mk(W, LH), g = EST.PORTAO;
    // lado de fora: fachada curva de concreto com nervuras e arcos
    plaster(c, 0, 40, g + 20, 170, '#d8d4ca', 290); for (let k = 0; k < g + 20; k += 24) { R(c, k, 40, 6, 170, '#c4c0b6'); R(c, k, 40, 2, 170, '#ece8de'); R(c, k + 5, 40, 1, 170, '#a8a49a'); }
    R(c, 0, 34, g + 20, 8, '#bcb8ae'); R(c, 0, 34, g + 20, 2, '#e8e4da'); for (let k = 0; k < g; k += 48) { R(c, k + 10, 60, 30, 30, '#2a2e34'); ell(c, k + 25, 60, 15, 7, '#2a2e34'); R(c, k + 12, 62, 26, 26, 'rgba(120,150,170,.4)'); torcida(c, k + 12, k + 37, 66, 0, -99, false, 3); }
    R(c, 40, 100, 420, 22, '#c43c3a'); R(c, 40, 100, 420, 2, '#e85a4a'); R(c, 40, 120, 420, 2, '#8a2a2a');
    // bilheteria com fila e vendedores
    for (let k = 0; k < 3; k++) { const bx = 70 + k * 60; R(c, bx, 150, 44, 34, '#3a4048'); R(c, bx + 4, 154, 36, 18, '#9fc4d0'); R(c, bx + 4, 172, 36, 4, '#c8ccd0'); ell(c, bx + 22, 164, 4, 4, pick(SKIN, k)); R(c, bx + 18, 168, 8, 4, '#c43c3a'); R(c, bx + 2, 140, 40, 8, '#f2c94c'); }
    for (let k = 0; k < 2; k++) { const ex = 300 + k * 140; R(c, ex, 172, 40, 30, '#8a6a45'); R(c, ex, 172, 40, 3, '#c4955c'); R(c, ex + 2, 166, 36, 6, '#2a2a2a'); for (let j = 0; j < 6; j++) { R(c, ex + 4 + j * 6, 165, 1, 6, '#c8a24a'); R(c, ex + 3 + j * 6, 167, 3, 2, pick(['#8a3a2a', '#c4743a'], j)); } ell(c, ex + 20, 150, 22, 6, k ? '#2c5a9e' : '#e8433a'); R(c, ex + 19, 150, 2, 22, '#5a5a56'); }
    for (let k = 0; k < 5; k++) { const jx = 520 + k * 18; R(c, jx, 140, 1, 4, '#5a5a56'); R(c, jx - 6, 144, 14, 16, pick(['#e8433a', '#f2efe6', '#2c5a9e'], k)); R(c, jx - 8, 144, 3, 7, pick(['#e8433a', '#f2efe6', '#2c5a9e'], k)); R(c, jx + 7, 144, 3, 7, pick(['#e8433a', '#f2efe6', '#2c5a9e'], k)); pxText(c, String(k + 7), jx + 1, 149, '#2a2a2a'); } R(c, 512, 138, 96, 2, '#5a5a56');
    // portão 3 com catracas
    R(c, g - 10, 30, 40, 180, '#a8aca8'); R(c, g - 6, 120, 32, 90, '#2a2e34'); for (let k = 0; k < 32; k += 4) R(c, g - 6 + k, 120, 2, 90, '#5a6066'); R(c, g - 10, 106, 40, 12, '#2c5a9e'); for (let k = 0; k < 2; k++) { R(c, g + 40 + k * 18, 186, 4, 24, '#9aa0a6'); R(c, g + 36 + k * 18, 196, 12, 2, '#c8ccd0'); }
    // dentro: pista de atletismo, mureta de placas, banco de reservas, câmera e repórter
    R(c, g + 30, 206, W - g - 30, 4, '#3a6a3a'); R(c, g + 30, 206, W - g - 30, 1, '#5a9a4a');
    for (let x = g + 30, i = 0; x < W; x += 72, i++) { const L = OUTDOORS[(i + 3) % OUTDOORS.length]; R(c, x, 198, 70, 10, '#1c1e22'); R(c, x + 1, 199, 68, 8, L[1]); pxText(c, L[0].split(':')[0].slice(0, 16), x + 35, 200, L[2]); }
    for (const bx of EST.BANCO) { R(c, bx, 172, 100, 4, '#c8ccd0'); for (let k = 0; k < 100; k += 10) R(c, bx + k, 176, 2, 30, '#9aa0a6'); R(c, bx, 172, 100, 30, 'rgba(180,220,240,.35)'); for (let k = 0; k < 7; k++) { const px = bx + 8 + k * 13; R(c, px, 190, 8, 6, '#2c5a9e'); R(c, px + 1, 182, 7, 8, k % 3 ? '#e8433a' : '#f2c94c'); R(c, px + 2, 177, 5, 5, pick(SKIN, k + 2)); } }
    const cx = 1580; R(c, cx, 186, 2, 20, '#3a3a36'); R(c, cx - 6, 206, 14, 2, '#3a3a36'); R(c, cx - 8, 176, 18, 10, '#2a2a2a'); R(c, cx + 10, 179, 5, 4, '#1a1a1a'); pxText(c, 'TV', cx + 1, 178, '#c43c3a');
    // pista vermelha (chão)
    R(c, 0, 210, g + 30, 10, '#d0c8b6'); asfalto(c, g + 30); R(c, g + 30, 210, W - g - 30, LH - 210, '#b4523a'); for (let y = 222; y < LH; y += 12) R(c, g + 30, y, W - g - 30, 1, '#f2e8dc'); for (let i = 0; i < W * 2; i++) { const x = g + 30 + hash(i * 1.7) * (W - g - 30); R(c, x, 210 + hash(i * 2.9) * 60, 1, 1, i % 2 ? '#a44a32' : '#c45e44'); }
    R(c, g + 30, 210, W - g - 30, 2, '#e8e4dc');
    return cv;
  }
  function estadio(c, s, t, camL) {
    if (!F29.mid) { F29.arq = buildArquibancada(); F29.mid = buildEstadio(); }
    const nt = night(s), P = PLACAR();
    conquistaBack(c, s, t, camL, { seed: 29, birds: true });
    const ax = EST.STX - camL * .55;
    if (ax + EST.SW > 0 && ax < LW) {
      c.save(); c.translate(0, -18); c.drawImage(F29.arq.cv, Math.round(ax), 0);
      const ola = ((t * 120) % (EST.SW + 400)) - 200 + ax, pulo = P.gol; torcida(c, Math.max(0, ax), Math.min(LW, ax + EST.SW), 74, t, ola, pulo);
      if (nt > .05) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = nt; c.drawImage(F29.arq.nv, Math.round(ax), 0); c.restore(); } c.restore();
      { const px = ax + 700; R(c, px - 56, 8, 112, 32, '#0c0e10'); pxText(c, 'PLANALTO', px - 30, 12, '#ffa83a'); pxText(c, 'CACAUEIROS', px + 28, 12, '#ffa83a'); pxText(c, `${P.a} X ${P.b}`, px, 22, '#ffe39a', { s: 2 }); pxText(c, P.gol ? 'GOOOL!' : `2T ${P.min}'`, px, 33, P.gol && Math.floor(t * 6) % 2 ? '#ff5a5a' : '#8ae08a'); }
      if (P.gol) for (let i = 0; i < 4; i++) { const fx = ax + 200 + i * 300; for (let k = 0; k < 8; k++) { const q = (t * .8 + k / 8) % 1; ell(c, fx + Math.sin(k + t) * 6, 76 - q * 50, 4 + q * 8, 3 + q * 5, `rgba(230,70,60,${(1 - q) * .45})`); } } // sinalizadores
      // o gramado com faixas e o jogo
      const gx = -camL * .75; for (let k = 0; k < 40; k++) { const x = Math.round(gx + k * 60 + 500), w = 60; if (x > LW || x + w < 0) continue; R(c, Math.max(x, ax + 0), 162, w, 38, k % 2 ? '#4a8a3e' : '#56984a'); }
      R(c, Math.max(0, ax), 162, LW, 1, '#f2f2ee'); R(c, Math.max(0, ax), 180, LW, 1, 'rgba(255,255,255,.35)'); { const mx = gx + 500 + 60 * 16; if (vis(mx, 40)) { R(c, mx, 162, 1, 38, 'rgba(255,255,255,.6)'); c.strokeStyle = 'rgba(255,255,255,.6)'; c.beginPath(); c.ellipse(mx, 180, 26, 6, 0, 0, TAU); c.stroke(); } }
      for (const gxx of [500 + 60 * 2, 500 + 60 * 30]) { const x = gx + gxx; if (vis(x, 20)) { R(c, x, 164, 2, 16, '#f2f2ee'); R(c, x + 14, 164, 2, 16, '#f2f2ee'); R(c, x, 164, 16, 2, '#f2f2ee'); for (let k = 2; k < 14; k += 3) R(c, x + k, 166, 1, 14, 'rgba(255,255,255,.4)'); } }
      const bxw = 500 + 60 * 16 + Math.sin(t * .37) * 600 + Math.sin(t * 1.1) * 80, by = 182 + Math.sin(t * 2.3) * 8 - Math.abs(Math.sin(t * 3.1)) * 5;
      for (let i = 0; i < 12; i++) { const home = 500 + 60 * (4 + i * 2.2), px = home + (bxw - home) * .35 + Math.sin(t * .8 + i) * 30, sx = gx + px, y = 172 + (i % 5) * 5, f = Math.floor(t * 8 + i) % 2; if (!vis(sx, 6)) continue; R(c, sx, y - 6, 3, 4, i % 2 ? '#e8433a' : '#f2c94c'); R(c, sx, y - 2, 1, 2 + f, '#f2efe6'); R(c, sx + 2, y - 2, 1, 3 - f, '#f2efe6'); R(c, sx, y - 8, 3, 2, pick(SKIN, i)); }
      { const sx = gx + bxw; if (vis(sx, 4)) R(c, sx, by, 2, 2, '#ffffff'); const ax2 = gx + bxw - 40 + Math.sin(t * .5) * 20; R(c, ax2, 182, 3, 6, '#1c1c1c'); R(c, ax2, 180, 3, 2, pick(SKIN, 3)); }
    }
    drawMid(c, F29.mid, camL);
    for (let k = 0; k < 5; k++) { const x = 90 - camL + k * 11, bob = Math.round(Math.sin(t * 1.4 + k) * .6); if (vis(x, 10)) pessoa(c, x, 208 + bob, k + 7); } // fila da bilheteria
    for (const ex of [300, 440]) { const x = ex + 20 - camL; if (vis(x, 30)) for (let i = 0; i < 6; i++) { const q = (t * .4 + i / 6) % 1; ell(c, x + Math.sin(t + i) * 3, 162 - q * 30, 2 + q * 4, 2 + q * 2, `rgba(230,230,226,${(1 - q) * .45})`); } } // fumaça do espetinho
    { const x = EST.BANCO[0] + 112 - camL, arm = Math.sin(t * 5); if (vis(x, 20)) { gente(c, x, 208, 4, false); limb(c, [[x + 6, 196], [x + 12, 190 - arm * 4]], 1, pick(SKIN, 4)); if (Math.floor(t / 3) % 2) balao(c, x + 4, 186, 'MARCA ESSE CARA!'); } } // técnico
    { const x = 1700 - camL + Math.sin(t * .6) * 30, j = Math.abs(Math.sin(t * 6)) * 4; if (vis(x, 20)) { R(c, x, 186 - j, 12, 14, '#f2efe6'); R(c, x + 2, 178 - j, 8, 8, '#e8e2d0'); R(c, x + 1, 174 - j, 2, 4, '#c8a24a'); R(c, x + 9, 174 - j, 2, 4, '#c8a24a'); R(c, x + 4, 181 - j, 1, 1, '#2a2a2a'); R(c, x + 7, 181 - j, 1, 1, '#2a2a2a'); R(c, x + 4, 184 - j, 4, 3, '#d8c8b0'); R(c, x + 2, 200 - j, 3, 8, '#e8433a'); R(c, x + 7, 200 - j, 3, 8, '#e8433a'); pxText(c, 'BODAO', x + 6, 189 - j, '#e8433a'); } } // mascote
    fog(c, s, t, camL, .12);
  }
  function estadioLights(g, s, t, camL) { const a = night(s), ax = EST.STX - camL * .55; if (a > .05) for (const fx of [120, 520, 980, 1380]) { const sx = ax + fx; if (sx < -200 || sx > LW + 200) continue; lightAdd(sx, 10, a, 120); const gr = g.createLinearGradient(0, 10, 0, 220); gr.addColorStop(0, `rgba(255,252,230,${.22 * a})`); gr.addColorStop(1, 'rgba(255,252,230,0)'); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 10, 10); g.lineTo(sx + 14, 10); g.lineTo(sx + 160, 220); g.lineTo(sx - 150, 220); g.fill(); } }
  function torcidaFrente(c, camLk, t) { // primeiro plano do estádio: a torcida de costas, com bandeira e braços pra cima no gol
    const P = PLACAR(), x0 = (EST.PORTAO + 40) * 1.45; for (let px = x0; px < EST.W * 1.45; px += 9) { const sx = px - camLk; if (sx < -20 || sx > LW + 20) continue; const i = Math.floor(px), up = P.gol ? Math.abs(Math.sin(t * 8 + i)) * 4 : Math.max(0, Math.sin(t * 2 + i * .3)) * 1.5;
      R(c, sx, LH - 10 - up, 8, 12, pick(['#c43c3a', '#e8e2d0', '#2c4a7a', '#c43c3a', '#1c1c1c'], i)); ell(c, sx + 4, LH - 13 - up, 4, 4, pick(['#1c1612', '#3a2a1a', '#6a4a2a', '#2a201a'], i));
      if (P.gol || hash(i) > .8) { R(c, sx - 1, LH - 22 - up, 2, 10, pick(SKIN, i)); R(c, sx + 8, LH - 22 - up, 2, 10, pick(SKIN, i)); }
      if (i % 11 === 3) { R(c, sx + 3, LH - 46, 1, 36, '#3a3a36'); for (let k = 0; k < 16; k++) R(c, sx + 4 + k, LH - 46 + Math.round(Math.sin(t * 6 + k * .5) * 2), 1, 12, k < 8 ? '#c43c3a' : '#f2efe6'); } } }

  /* =====================================================================
     30 · TERMINAL RODOVIÁRIO: saguão com guichês e painel de partidas; plataformas com ônibus chegando e saindo
     ===================================================================== */
  const ROD = { W: 2400, HALL: 1250, BAYS: [1300, 1450, 1600, 1750, 1900, 2050, 2200] };
  const EMPRESAS = [['NOVO HORIZONTINHO', '#2c5a9e', '#f2c94c'], ['AGUIA BRANQUINHA', '#f2f2ee', '#2c5a9e'], ['SAO GERALDINHO', '#c43c3a', '#ffffff'], ['RAPIDO FEDERALZINHO', '#3c8a5a', '#ffffff'], ['GONTIJINHO', '#e8833a', '#ffffff'], ['CAMURUJIPINHO', '#7a3a8a', '#f2c94c']];
  const DESTINOS = [['SALVADOR', '22:30'], ['ITABUNA', '14:10'], ['JEQUIE', '15:45'], ['BRUMADO', '16:20'], ['ILHEUS', '17:00'], ['BELO HORIZONTE', '19:15'], ['SAO PAULO', '20:40'], ['FEIRA DE SANTANA', '21:05']];
  const F30 = {};
  function onibus(c, x, y, E, dest, aberto) { // ônibus de lado (virado pra esquerda): 112 x 46
    const [nome, cor, cor2] = E; R(c, x + 4, y, 104, 3, 'rgba(0,0,0,.25)'); R(c, x, y - 44, 112, 40, cor); R(c, x, y - 44, 112, 2, shadeHex(cor, 1.2)); R(c, x + 2, y - 40, 108, 13, '#24303a'); for (let k = 0; k < 7; k++) { R(c, x + 18 + k * 13, y - 39, 11, 11, '#3a5a6a'); R(c, x + 19 + k * 13, y - 39, 3, 11, 'rgba(255,255,255,.18)'); }
    R(c, x + 2, y - 40, 12, 18, '#4a6a7a'); R(c, x + 2, y - 47, 30, 4, '#14161a'); pxText(c, dest, x + 17, y - 47, '#ffa83a'); R(c, x, y - 24, 112, 4, cor2); pxText(c, nome, x + 62, y - 18, shadeHex(cor, .55) === cor ? '#2a2a2a' : (cor === '#f2f2ee' ? '#2c5a9e' : '#ffffff'));
    R(c, x + 4, y - 20, 12, 18, aberto ? '#1c2228' : '#3a4a54'); R(c, x + 40, y - 12, 50, 9, aberto ? '#1a1a1e' : shadeHex(cor, .85)); R(c, x - 1, y - 10, 3, 3, '#fff2b0'); R(c, x + 110, y - 12, 2, 4, '#e8433a');
    for (const wx of [x + 22, x + 92]) { ell(c, wx, y - 3, 6, 6, '#1c1c1c'); ell(c, wx, y - 3, 3, 3, '#9aa0a6'); }
    if (aberto) for (let k = 0; k < 4; k++) R(c, x + 44 + k * 11, y - 10, 9, 7, pick(['#c43c3a', '#2c4a6a', '#e8c24c', '#4a8a5a', '#7a3a8a'], k + x));
  }
  function buildRodo() {
    const W = ROD.W, H = ROD.HALL, [cv, c] = mk(W, LH);
    // saguão: laje alta, janelas altas (o céu aparece) e parede de azulejo
    R(c, 0, 0, H, 24, '#c8c4ba'); R(c, 0, 22, H, 3, '#8a8a84'); for (let x = 20; x < H; x += 60) { R(c, x, 14, 30, 4, '#fff6d8'); }
    plaster(c, 0, 25, H, 185, '#e2ddd0', 300); for (let x = 0; x < H; x += 130) { c.clearRect(x + 14, 32, 102, 40); R(c, x + 12, 30, 106, 2, '#5a6066'); R(c, x + 12, 72, 106, 2, '#5a6066'); for (let k = 0; k < 4; k++) R(c, x + 12 + k * 35, 30, 2, 44, '#5a6066'); }
    A.azulejo(c, 0, 120, H, 90, '#e8e4da', '#d8d2c4'); R(c, 0, 118, H, 3, '#2c5a9e');
    // guichês das viações
    EMPRESAS.forEach((E, i) => { const x = 30 + i * 132, [nome, cor, letra] = E; R(c, x, 128, 120, 82, '#5a6066'); R(c, x + 2, 130, 116, 12, cor); R(c, x + 2, 130, 116, 1, shadeHex(cor, 1.3)); pxText(c, nome, x + 60, 133, letra);
      for (let k = 0; k < 2; k++) { const gx = x + 8 + k * 56; R(c, gx, 148, 48, 30, '#9fc4d0'); R(c, gx + 1, 149, 46, 3, 'rgba(255,255,255,.4)'); ell(c, gx + 24, 162, 5, 5, pick(SKIN, i + k)); R(c, gx + 18, 167, 12, 11, pick(ROUPA, i * 2 + k)); R(c, gx + 18, 170, 12, 1, cor); R(c, gx - 1, 178, 50, 4, '#c8ccd0'); R(c, gx + 18, 152, 12, 3, '#2a2a2a'); } R(c, x, 182, 120, 28, '#7a8086'); });
    // painel de partidas (parte fixa), lanchonete, banca, guarda-volumes e sanitário
    R(c, 820, 36, 170, 72, '#14161a'); R(c, 822, 38, 166, 10, '#2c5a9e'); pxText(c, 'PARTIDAS', 905, 40, '#ffffff');
    const lx = 1010; R(c, lx, 120, 110, 90, '#c47a35'); R(c, lx + 4, 124, 102, 14, '#8a4a20'); R(c, lx + 6, 142, 98, 26, '#f2e8d0'); for (let k = 0; k < 6; k++) { ell(c, lx + 14 + k * 15, 156, 4, 5, '#d8943a'); R(c, lx + 12 + k * 15, 150, 3, 2, '#c47a35'); } R(c, lx, 168, 110, 4, '#e8e2d2'); R(c, lx, 172, 110, 38, '#8a4a20'); pxText(c, 'COXINHA DO TERMINAL', lx + 55, 128, '#fff6d0');
    R(c, 1140, 150, 50, 60, '#2c5a8a'); R(c, 1138, 146, 54, 5, '#1d4070'); for (let k = 0; k < 12; k++) R(c, 1143 + (k % 6) * 7.5, 154 + Math.floor(k / 6) * 14, 6, 11, pick(['#d9634a', '#e8c24c', '#5f9fd0', '#f2efe6', '#c86ab8'], k));
    R(c, 1196, 130, 50, 80, '#8a949a'); for (let k = 0; k < 8; k++) { R(c, 1198 + (k % 2) * 24, 132 + Math.floor(k / 2) * 19, 22, 17, '#a8b0b6'); R(c, 1216 + (k % 2) * 24, 140 + Math.floor(k / 2) * 19, 2, 3, '#5a5e62'); } pxText(c, 'GUARDA-VOLUMES', 1221, 122, '#2a2a2a');
    R(c, 790, 128, 24, 20, '#2c5a9e'); pxText(c, 'WC', 802, 131, '#ffffff'); pxText(c, 'R$1', 802, 139, '#f2c94c');
    // cadeiras de espera
    for (let r = 0; r < 3; r++) for (let k = 0; k < 6; k++) { const x = 60 + r * 300 + k * 13; R(c, x, 196, 11, 4, '#3c6aa8'); R(c, x, 186, 11, 10, '#4f80b0'); R(c, x + 1, 200, 1, 10, '#5a5e62'); R(c, x + 9, 200, 1, 10, '#5a5e62'); }
    // plataformas: marquise com colunas, números das plataformas, meio-fio e faixa amarela
    R(c, H - 20, 26, W - H + 20, 18, '#b8b4aa'); R(c, H - 20, 26, W - H + 20, 3, '#d8d4ca'); R(c, H - 20, 44, W - H + 20, 4, '#8a8680'); for (let x = H + 20; x < W; x += 50) R(c, x, 46, 18, 2, '#fff6d8');
    ROD.BAYS.forEach((bx, i) => { R(c, bx - 6, 48, 6, 162, '#c8c4ba'); R(c, bx - 6, 48, 2, 162, '#e8e4da'); R(c, bx - 18, 60, 30, 16, '#2c5a9e'); pxText(c, String(i + 1), bx - 3, 62, '#ffffff', { s: 2 }); });
    R(c, H, 196, W - H, 14, '#cfc8b6'); for (let x = H; x < W; x += 12) R(c, x, 206, 6, 3, '#e8c24c');
    pisoInterno(c, W, '#d8d2c4', '#c2bcae', 22);
    return cv;
  }
  function rodo(c, s, t, camL) {
    if (!F30.mid) { F30.mid = buildRodo(); F30.rua = buildRua({ seed: 300, base: 168, f: [2, 6], w: [26, 44], pal: ['#ebe8de', '#e0d6c2', '#dfe6ea'], lojas: K.LOJAS_RUA, lojaIni: 4, lojaChance: .7, outdoors: 4, outIni: 5, rua: true, gente: 16 }); }
    conquistaBack(c, s, t, camL, { seed: 30 }); tile(c, F30.rua.cv, camL * F30.rua.f); noiteTile(c, s, F30.rua.nv, camL * F30.rua.f); andaRua(c, F30.rua, s, t, camL);
    // ônibus nas plataformas: chegam, param pra embarque e vão embora
    ROD.BAYS.forEach((bx, i) => { const cyc = 34 + i * 3, ph = ((t + i * 9) % cyc) / cyc, E = EMPRESAS[(i + Math.floor((t + i * 9) / cyc)) % EMPRESAS.length], dest = DESTINOS[(i * 3 + Math.floor((t + i * 9) / cyc)) % DESTINOS.length][0];
      let x = bx + 4, aberto = false; if (ph < .15) x += (1 - ph / .15) * 520; else if (ph > .85) x -= ((ph - .85) / .15) * 700; else aberto = ph > .22 && ph < .78;
      const sx = x - camL; if (!vis(sx, 120)) return; onibus(c, sx, 196, E, dest, aberto);
      if (aberto) for (let k = 0; k < 3; k++) { const q = ((t * .25 + k / 3) % 1), px = sx + 10 + q * -0; pessoinha(c, sx - 6 - k * 6, 196, i * 3 + k, t, false); } });
    drawMid(c, F30.mid, camL);
    { const x = 820 - camL; if (vis(x, 180)) for (let r = 0; r < 7; r++) { const D = DESTINOS[(r + Math.floor(t / 8)) % DESTINOS.length], y = 51 + r * 8, st = r === 0 ? (Math.floor(t * 2) % 2 ? 'EMBARQUE' : '') : r === 3 ? 'ATRASADO' : 'NO HORARIO';
      pxText(c, D[0], x + 4, y, '#f2c94c', { align: 'left' }); pxText(c, D[1], x + 104, y, '#e8eaec', { align: 'left' }); pxText(c, st, x + 164, y, r === 3 ? '#ff6a5a' : '#6ae08a', { align: 'right' }); } }
    const nt = night(s);
    for (let i = 0; i < 6; i++) { const x = ((i * 113 + Math.sin(t * .5 + i) * 20) % 1100) + 40 - camL, hop = Math.max(0, Math.sin(t * 4 + i * 2)) * 2; if (vis(x, 6)) { R(c, x, 216 - hop, 5, 3, '#8a8f98'); R(c, x + 4, 214 - hop + (Math.sin(t * 6 + i) > .5 ? 2 : 0), 2, 2, '#6a6f78'); } } // pombos
    { const x = 66 + 26 - camL; if (vis(x, 20)) { R(c, x, 180, 24, 8, '#3a4a6a'); ell(c, x + 3, 182, 3, 3, '#9a6440'); pxText(c, 'Z', x + 8 + Math.sin(t * 2) * 2, 170 - (t * 4) % 8, '#5a6a8a'); } } // dorminhoco nas cadeiras
    { const x = 400 - camL + Math.sin(t * .2) * 120; if (vis(x, 20)) { gente(c, x, 216, 6); R(c, x + 6, 200, 6, 8, '#c8a06a'); if (Math.floor(t / 2.5) % 3 === 0) balao(c, x + 3, 192, 'OLHA O AMENDOIM!'); } }
    if (Math.floor(t / 12) % 2 === 0) { const msg = 'ATENCAO, PASSAGEIROS COM DESTINO A SALVADOR: EMBARQUE NA PLATAFORMA 1', w = largura(msg), x = 820 + 168 - ((t * 30) % (w + 170)) - camL; c.save(); c.beginPath(); c.rect(820 - camL + 2, 100, 166, 7); c.clip(); R(c, 820 - camL + 2, 100, 166, 7, '#0c0e10'); pxText(c, msg, x, 101, '#ffa83a', { align: 'left' }); c.restore(); }
    void nt;
  }
  function rodoLights(g, s, t, camL) { for (let x = 20; x < ROD.HALL; x += 60) { const sx = x + 15 - camL; if (vis(sx)) lightAdd(sx, 16, .25, 50); } const a = night(s); if (a > .05) for (let x = ROD.HALL + 20; x < ROD.W; x += 50) { const sx = x + 9 - camL; if (vis(sx)) lightAdd(sx, 47, .5 * a, 60); } }

  /* =====================================================================
     31 · UESB: módulos de aula, cantina, biblioteca, mural do DCE, RU, xerox e a área verde
     ===================================================================== */
  const UE = { W: 2600, MOD: 60, CANT: 530, BIB: 820, DCE: 1200, RU: 1440, XER: 1860, VERDE: 2100 };
  const F31 = {};
  function buildCampusTras() { // atrás: mais módulos, caixa-d'água da UESB, eucaliptos e o ônibus circular
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH), b = 182;
    for (let x = 0; x < T; x += 4) { const h = 30 + hash(x * .3) * 26; R(c, x, b - 10 - h, 3, h + 10, '#6a8a5a'); ell(c, x + 1, b - 12 - h, 4, 8, pick(['#5a7e4e', '#6a9058', '#4e7246'], x)); }
    for (let x = 30, i = 0; x < T - 140; i++) { const w = 90 + Math.round(hash(i + 31) * 60); R(c, x, b - 34, w, 34, '#ece8dc'); R(c, x, b - 34, w, 3, '#2c5a9e'); R(c, x, b - 18, w, 2, '#2c5a9e'); for (let k = 0; k < w - 8; k += 9) { K.janelaM(c, n, x + 4 + k, b - 30, i * 30 + k, .6); K.janelaM(c, n, x + 4 + k, b - 14, i * 31 + k, .7); } R(c, x - 2, b - 37, w + 4, 3, '#bcb6a8'); x += w + 30 + Math.round(hash(i) * 40); }
    const tx = 700; R(c, tx, b - 90, 4, 90, '#9aa0a6'); R(c, tx + 26, b - 90, 4, 90, '#9aa0a6'); R(c, tx - 6, b - 112, 42, 24, '#e8e4dc'); R(c, tx - 6, b - 112, 42, 3, '#2c5a9e'); pxText(c, 'UESB', tx + 15, b - 104, '#2c5a9e');
    R(c, 0, b, T, 4, '#cfc8b6'); R(c, 0, b + 4, T, 8, '#6a6e72'); nevoa(c, T, 'rgba(204,218,228,.2)');
    return { cv, nv, base: b, f: .4, gente: 24, rua: false };
  }
  function modulo(c, x, w, seed) { // módulo de aulas de 2 andares com pilotis e corredor aberto
    plaster(c, x, 104, w, 106, '#efebe0', seed); R(c, x, 100, w, 6, '#2c5a9e'); R(c, x, 154, w, 4, '#2c5a9e'); R(c, x - 2, 98, w + 4, 3, '#c8c2b4');
    for (let k = 0; k < w - 10; k += 22) { janela(c, x + 6 + k, 112, 14, 16, 'vidro', seed + k); R(c, x + 4 + k, 164, 4, 46, '#d8d2c4'); R(c, x + 4 + k, 164, 1, 46, '#f2efe6'); }
    R(c, x, 158, w, 6, '#c8c2b4'); R(c, x + 2, 164, w - 4, 46, 'rgba(60,60,70,.25)'); for (let k = 0; k < w - 10; k += 22) { R(c, x + 10 + k, 176, 8, 16, pick(['#c88a6a', '#6a8aa8', '#a8a86a', '#8a6aa8'], seed + k)); }
    for (let k = 0; k < 8; k++) R(c, x + w - 30 + k * 3, 158 + k * 6.5, 14, 2, '#bcb6a8'); // escada
  }
  function buildUesb() {
    const W = UE.W, [cv, c] = mk(W, LH);
    modulo(c, UE.MOD, 420, 3100); R(c, UE.MOD + 120, 86, 180, 12, '#f2c94c'); R(c, UE.MOD + 120, 86, 180, 1, '#ffe8a0'); pxText(c, 'SEMANA DO CALOURO: BEM-VINDES!', UE.MOD + 210, 89, '#2a2a2a');
    // cantina
    const ct = UE.CANT; R(c, ct, 140, 110, 70, '#e8833a'); R(c, ct + 4, 146, 102, 26, '#f2e8d0'); R(c, ct, 132, 110, 10, '#c43c3a'); for (let k = 0; k < 110; k += 10) R(c, ct + k, 132, 5, 10, '#f2efe6'); R(c, ct + 2, 174, 106, 4, '#e8e2d2');
    R(c, ct + 6, 148, 40, 22, '#2a2a2a'); pxText(c, 'PASTEL 4', ct + 26, 150, '#f2c94c'); pxText(c, 'SUCO 3', ct + 26, 157, '#f2efe6'); pxText(c, 'CAFE 1,50', ct + 26, 164, '#f2efe6');
    for (let k = 0; k < 2; k++) { const tx = ct + 130 + k * 60; ell(c, tx + 10, 170, 18, 5, k ? '#2c8a5a' : '#c43c3a'); R(c, tx + 9, 170, 2, 24, '#8a8a86'); R(c, tx, 192, 22, 3, '#e8e2d2'); R(c, tx + 10, 195, 2, 15, '#8a8a86'); for (const sx of [tx - 6, tx + 24]) { R(c, sx, 200, 6, 2, '#c8ccd0'); R(c, sx + 2, 202, 2, 8, '#8a8a86'); } }
    // biblioteca de vidro com estantes
    const bb = UE.BIB; R(c, bb, 80, 330, 130, '#3a5a6a'); for (let k = 0; k < 330; k += 30) { R(c, bb + k, 80, 2, 130, '#2a3a44'); } R(c, bb, 80, 330, 4, '#e8e4dc'); R(c, bb, 140, 330, 3, '#2a3a44');
    for (let r = 0; r < 2; r++) for (let k = 0; k < 10; k++) { const sx = bb + 6 + k * 32, sy = 92 + r * 60; for (let j = 0; j < 3; j++) { R(c, sx, sy + j * 14 + 12, 24, 2, '#8a6a45'); for (let b2 = 0; b2 < 22; b2 += 3) R(c, sx + b2, sy + j * 14 + 4 + hash(b2 + k + j) * 3, 2, 9 - hash(b2 + j) * 3, pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#3c8a5a', '#7a3a8a', '#e8833a'], b2 + k + j + r)); } }
    reflexo(c, bb, 84, 330, 126); R(c, bb + 140, 170, 50, 40, '#2a3a44'); R(c, bb + 142, 172, 22, 38, 'rgba(160,210,230,.5)'); R(c, bb + 166, 172, 22, 38, 'rgba(160,210,230,.5)');
    // DCE: muro grafitado e mural de avisos
    const d = UE.DCE; plaster(c, d, 120, 210, 90, '#e8e2d2', 3200); grafite(c, d + 4, 124, 120, 60, 3201); R(c, d + 130, 128, 74, 56, '#8a6a45'); R(c, d + 133, 131, 68, 50, '#c8a46a'); for (let k = 0; k < 8; k++) cartaz(c, d + 136 + (k % 4) * 16, 134 + Math.floor(k / 4) * 22, 3210 + k);
    pxText(c, 'DCE', d + 60, 190, '#2a2a2a', { s: 2 });
    // RU com a grade da fila
    const ru = UE.RU; plaster(c, ru, 110, 380, 100, '#f2efe6', 3300); R(c, ru, 106, 380, 6, '#c43c3a'); R(c, ru + 150, 82, 80, 26, '#c43c3a'); R(c, ru + 152, 84, 76, 22, '#e8433a'); pxText(c, 'RU', ru + 190, 88, '#ffffff', { s: 3 });
    for (let k = 0; k < 6; k++) janela(c, ru + 20 + k * 60, 122, 30, 20, 'vidro', 3301 + k); R(c, ru + 170, 150, 40, 60, '#5a3a24'); R(c, ru + 172, 152, 18, 58, '#8a5a3a'); R(c, ru + 190, 152, 18, 58, '#8a5a3a');
    R(c, ru - 10, 190, 170, 2, '#9aa0a6'); for (let k = 0; k < 170; k += 20) R(c, ru - 10 + k, 190, 2, 20, '#9aa0a6'); R(c, ru + 300, 150, 60, 30, '#2a2a2a'); pxText(c, 'HOJE: FEIJOADA', ru + 330, 156, '#f2c94c'); pxText(c, 'R$ 2,00', ru + 330, 166, '#ffffff');
    // xerox
    const xr = UE.XER; plaster(c, xr, 140, 170, 70, '#f2e2a8', 3400); R(c, xr + 4, 144, 162, 12, '#2c5a9e'); pxText(c, 'XEROX DO SEU ZE', xr + 85, 147, '#ffffff'); R(c, xr + 10, 162, 70, 48, '#9fc4d0'); R(c, xr + 20, 176, 30, 16, '#e8eaec'); R(c, xr + 22, 172, 26, 4, '#c8ccd0'); R(c, xr + 90, 162, 70, 30, '#2a2a2a'); pxText(c, 'APOSTILA', xr + 125, 168, '#ffffff'); pxText(c, 'R$0,10 A FOLHA', xr + 125, 177, '#f2c94c');
    // área verde com ipês, bicicletário e ponto do circular
    for (let k = 0; k < 8; k++) { const bx = UE.VERDE + 20 + k * 9; ell(c, bx, 204, 5, 5, '#2a2a2a'); ell(c, bx, 204, 3, 3, 'rgba(0,0,0,0)'); limb(c, [[bx - 4, 204], [bx, 196], [bx + 4, 204]], 1, pick(['#c43c3a', '#2c5a9e', '#3c8a5a'], k)); } R(c, UE.VERDE + 12, 200, 80, 2, '#8a8a86');
    A.ponto(c, UE.VERDE + 400); R(c, UE.VERDE + 404, GY - 31, 30, 6, '#2c5a9e'); pxText(c, 'CIRCULAR', UE.VERDE + 419, GY - 30, '#ffffff');
    for (let lx = 40; lx < W; lx += 240) lampPost(c, lx, 120);
    objetos(c, 31, W, 'cidade', 30, W - 30, [120, 220]); pedraPortuguesa(c, W, 210); R(c, 0, 210, W, 2, '#c8c2b0'); chaoDetalhe(c, W, 'cidade');
    return cv;
  }
  function uesb(c, s, t, camL) {
    if (!F31.mid) { F31.mid = buildUesb(); F31.tras = buildCampusTras(); }
    const nt = night(s);
    conquistaBack(c, s, t, camL, { seed: 31, kites: true }); tile(c, F31.tras.cv, camL * F31.tras.f); noiteTile(c, s, F31.tras.nv, camL * F31.tras.f); andaRua(c, F31.tras, s, t, camL);
    { const sx = scr(F31.tras, wrap(t * 20), camL); if (vis(sx, 40)) { const y = 192; R(c, sx, y - 14, 40, 12, '#f2f2ee'); R(c, sx, y - 9, 40, 2, '#2c5a9e'); for (let k = 0; k < 6; k++) R(c, sx + 4 + k * 6, y - 13, 4, 4, '#3a5a6a'); pxText(c, 'UESB', sx + 26, y - 7, '#2c5a9e'); R(c, sx + 4, y - 2, 4, 3, '#1c1c1c'); R(c, sx + 31, y - 2, 4, 3, '#1c1c1c'); } } // circular
    for (const x of [UE.VERDE + 120, UE.VERDE + 300, UE.CANT - 30, UE.RU + 400]) { const sx = x - camL; if (vis(sx, 60)) ipe(c, sx, 212, x % 2 ? '#e8c84a' : '#b86ac8', x, .95); }
    drawMid(c, F31.mid, camL);
    for (let k = 0; k < 9; k++) { const x = UE.RU + 140 - k * 16 + Math.round(((t * 3) % 16)) - camL; if (vis(x, 10)) { gente(c, x, 212, k + 3, false); R(c, x + (k % 2 ? 6 : -4), 198, 4, 8, pick(['#c43c3a', '#2c5a9e', '#2a2a2a', '#e8833a'], k)); } } // fila do RU com mochila
    { const x0 = UE.VERDE + 170 - camL; if (vis(x0, 80)) { for (let k = 0; k < 4; k++) { const a = k / 4 * TAU, x = x0 + Math.cos(a) * 22, y = 212 + Math.sin(a) * 3; R(c, x, y - 7, 6, 7, pick(ROUPA, k + 2)); R(c, x + 1, y - 11, 4, 4, pick(SKIN, k)); } R(c, x0 - 4, 203, 9, 4, '#a8742a'); R(c, x0 + 5, 204, 8, 1, '#5a3a20'); const st = Math.sin(t * 10) > 0; R(c, x0 + 1, 203 + (st ? 1 : 0), 3, 1, pick(SKIN, 1)); for (let i = 0; i < 3; i++) { const q = (t * .4 + i / 3) % 1; c.globalAlpha = 1 - q; nota(c, x0 + 4 + i * 6 + q * 8, 196 - q * 26, '#2a2a2a'); c.globalAlpha = 1; } } } // roda de violão
    { const u = (Math.sin(t * 1.4) + 1) / 2, xa = UE.VERDE + 340, xb = UE.VERDE + 440, fx = xa + (xb - xa) * u - camL, fy = 196 - Math.sin(u * Math.PI) * 30; if (vis(fx, 60)) { gente(c, xa - camL - 8, 214, 9, false); gente(c, xb - camL + 4, 214, 2, false); ell(c, fx, fy, 4, 1.5, '#ff5a8a'); } } // frisbee
    { const cyc = 20, ph = (t % cyc) / cyc; if (ph < .5) { const x = UE.MOD + ph / .5 * 1500 - camL, f = Math.floor(t * 10) % 2; if (vis(x, 30)) { gente(c, x, 214, 5, false); R(c, x - 4, 198, 5, 7, '#2c4a7a'); for (let i = 0; i < 5; i++) { const q = ((t * 1.3 + i / 5) % 1); R(c, x - 8 - q * 40, 200 - Math.sin(q * 3 + i) * 10 + q * 12, 3, 4, '#f6f4ee'); } if (f) balao(c, x + 3, 192, 'ATRASADO PRA PROVA!'); } } } // estudante atrasado
    { const x = UE.CANT + 60 - camL; if (vis(x, 20)) { cachorro(c, x, 212, '#c98a43'); if (nt < .5) pxText(c, 'ZZZ', x + 22 + Math.sin(t) * 2, 194 - (t * 5) % 10, '#5a5a66'); } } // o Caramelo do campus
    fog(c, s, t, camL, .16);
  }
  function uesbLights(g, s, t, camL) { const a = night(s); if (a < .05) return; for (let x = 40; x < UE.W; x += 240) lampGlow(g, x - camL, 120, a); const bx = UE.BIB - camL; if (vis(bx, 330)) { g.fillStyle = `rgba(255,236,190,${.3 * a})`; g.fillRect(bx, 84, 330, 126); } }

  /* ---------- plataformas temáticas (em pixels do mundo) ---------- */
  const PLAT = {
    tronco: (c, x, y, w, t, sd) => { sombra(c, x, y, w); Q(c, x - 2, y - 2, w + 4, 20, '#3a2a1a'); Q(c, x, y, w, 16, '#6a4a32'); for (let k = 0; k < w; k += 8) Q(c, x + k, y + 4 + (k % 16 ? 0 : 2), 6, 2, '#5a3a24'); Q(c, x, y, w, 4, '#5f8a46'); Q(c, x, y, w, 2, '#86b45e');
      for (const ex of [x - 4, x + w - 6]) { Q(c, ex, y, 10, 16, '#c8a06a'); Q(c, ex + 2, y + 4, 6, 8, '#9a7046'); Q(c, ex + 4, y + 6, 2, 4, '#c8a06a'); }
      for (let k = 0; k < 3; k++) { const mx = x + 14 + hash(sd + k) * (w - 30); Q(c, mx, y - 6, 2, 6, '#f2e8d0'); Q(c, mx - 4, y - 10, 10, 4, k % 2 ? '#e8833a' : '#c43c3a'); Q(c, mx - 2, y - 10, 2, 2, '#f2efe6'); }
      for (let k = 0; k < w / 20; k++) { const vx = x + 8 + k * 20, len = 6 + hash(sd + k * 3) * 14; for (let j = 0; j < len; j += 2) Q(c, vx + Math.sin(j * .5 + t + k) * 2, y + 16 + j, 2, 2, '#4a7a3a'); } },
    arquibancada: (c, x, y, w, t, sd) => { sombra(c, x, y, w); concretoBase(c, x, y, w, 24, '#d8d4ca', '#b4b0a6', sd); for (let k = 4; k < w - 10; k += 12) { const col = pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#f2efe6'], Math.floor((x + k) / 12)); Q(c, x + k, y - 8, 10, 8, col); Q(c, x + k, y - 8, 10, 2, shadeHex(col, 1.3)); Q(c, x + k + 2, y, 6, 2, shadeHex(col, .6)); } Q(c, x, y + 14, w, 2, '#e8e4da'); },
    malas: (c, x, y, w, t, sd) => { sombra(c, x, y, w); for (let k = 0; k < w; ) { const mw = Math.min(w - k, 28 + Math.round(hash(sd + k) * 20)), col = pick(['#c43c3a', '#2c4a6a', '#e8c24c', '#4a8a5a', '#7a3a8a', '#3a3a3a'], sd + k);
      Q(c, x + k, y, mw - 2, 22, col); Q(c, x + k, y, mw - 2, 2, shadeHex(col, 1.3)); Q(c, x + k + mw - 4, y, 2, 22, shadeHex(col, .7)); Q(c, x + k + 4, y + 8, mw - 10, 2, shadeHex(col, .8)); Q(c, x + k + mw / 2 - 4, y - 4, 8, 4, '#3a3a36'); Q(c, x + k + 6, y + 12, 6, 4, '#f2efe6'); k += mw; } },
    livros: (c, x, y, w, t, sd) => { sombra(c, x, y, w); for (let r = 0; r < 3; r++) { const off = (hash(sd + r) - .5) * 10, col = pick(['#c43c3a', '#2c5a9e', '#3c8a5a', '#e8833a', '#7a3a8a', '#e8c24c'], sd + r); Q(c, x + off, y + r * 8, w, 8, col); Q(c, x + off, y + r * 8, w, 2, shadeHex(col, 1.3)); Q(c, x + off + w - 6, y + r * 8 + 2, 6, 4, '#f6f2e8'); for (let k = 8; k < w - 10; k += 3) Q(c, x + off + w - 6, y + r * 8 + 2 + (k % 4 ? 0 : 2), 6, 1, '#e0dccc'); Q(c, x + off + 10, y + r * 8 + 3, Math.min(30, w / 3), 2, '#f2d898'); } }
  };

  /* ---------- registro ---------- */
  const REG = CC.registrar;
  REG({ id: 28, key: 'poco-escuro', nome: 'Reserva do Poço Escuro', lugar: 'Reserva Florestal do Poço Escuro · mata atlântica no meio da cidade', grupo: 'novo', width: POCO.W * 2, draw: poco, lights: pocoLights, amb: (s) => mix(s.amb, [.66, .78, .66], .4), vao: vaoAgua, plat: PLAT.tronco,
    labels: [[212, 167, 'TRILHA DO POÇO ESCURO', 4, '#f2e8c8'], [918, 168, 'NÃO ALIMENTE OS SAGUIS', 3, '#f2e8c8'], [POCO.POOL - 43, 164, 'POÇO ESCURO →', 4, '#f2f2e6'], [1855, 169, 'SILÊNCIO', 4, '#f2e8c8'], [POCO.GUARITA + 33, 154, 'GUARITA', 4, '#f2efe6']],
    interact: [['grass', 500, 220], ['grass', 2500, 200], ['crate', 1500], ['bucket', 1900], ['fence', 1200, 90], ['puddle', 2900, 70], ['hay', 4300], ['grass', 4700, 240], ['trap', 3900]] },
    { platforms: [[700, 384, 150], [890, 328, 140], [2000, 384, 150], [2190, 328, 140], [2380, 272, 140], [3080, 384, 220], [3600, 384, 150], [3790, 328, 140], [4500, 384, 150]], gaps: [[3100, 180]] });
  REG({ id: 29, key: 'lomantao', nome: 'Estádio Lomanto Júnior', lugar: 'O Lomantão: bilheteria, portão 3 e a pista em dia de jogo', grupo: 'novo', width: EST.W * 2, draw: estadio, lights: estadioLights, plat: PLAT.arquibancada,
    labels: [[250, 111, 'ESTÁDIO LOMANTO JÚNIOR', 10, '#ffffff'], [135, 144, 'BILHETERIA', 5, '#2a2a2a'], [EST.PORTAO + 10, 112, 'PORTÃO 3', 5, '#ffffff'], [320, 155, 'ESPETINHO', 4, '#ffffff'], [460, 155, 'PIPOCA', 4, '#ffffff'], [EST.BANCO[0] + 50, 168, 'BANCO DE RESERVAS', 4, '#2a2a2a']],
    interact: [['ball', 1700], ['ball', 3100], ['ball', 4600], ['cone', 2400], ['cone', 2460], ['cone', 2520], ['trash', 560], ['trash', 3500], ['bucket', 2900], ['crate', 1100], ['grill', 640], ['lever', 4200, 'party']] },
    { platforms: [[900, 384, 150], [1600, 384, 150], [1790, 328, 140], [1980, 272, 140], [3300, 384, 150], [3490, 328, 140], [4400, 384, 150], [4590, 328, 140]], gaps: [] });
  REG({ id: 30, key: 'rodoviaria', nome: 'Terminal Rodoviário', lugar: 'Rodoviária de Vitória da Conquista: guichês, partidas e plataformas', grupo: 'novo', width: ROD.W * 2, draw: rodo, lights: rodoLights, amb: indoor(.5), plat: PLAT.malas,
    labels: [[ROD.HALL / 2, 12, 'TERMINAL RODOVIÁRIO', 9, '#2c3a44'], [1040, 112, 'LANCHONETE', 5, '#2a2a2a'], [1165, 143, 'REVISTAS', 4, '#ffffff'], [1800, 36, 'PLATAFORMAS DE EMBARQUE', 7, '#2c3a44']],
    interact: [['trash', 700], ['trash', 2300], ['crate', 1500], ['crate', 1528, 1], ['pot', 100], ['pot', 2480], ['bucket', 1900], ['cone', 3000], ['cone', 3800], ['tire', 4200], ['puddle', 3400, 70]] },
    { platforms: [[600, 384, 150], [790, 328, 140], [1700, 384, 150], [2800, 384, 150], [2990, 328, 140], [3180, 272, 140], [4300, 384, 150]], gaps: [] });
  REG({ id: 31, key: 'uesb', nome: 'UESB', lugar: 'Universidade Estadual do Sudoeste da Bahia · campus de Conquista', grupo: 'novo', width: UE.W * 2, draw: uesb, lights: uesbLights, plat: PLAT.livros,
    labels: [[UE.MOD + 210, 92, 'MÓDULO DE AULAS', 7, '#2c3a44'], [UE.CANT + 55, 137, 'CANTINA DA TIA', 5, '#ffffff'], [UE.BIB + 165, 74, 'BIBLIOTECA CENTRAL', 8, '#2c3a44'], [UE.DCE + 167, 124, 'AVISOS', 4, '#5a3a20'], [UE.RU + 190, 116, 'RESTAURANTE UNIVERSITÁRIO', 6, '#c43c3a']],
    interact: [['ball', 4400], ['ball', 4500], ['trash', 1000], ['trash', 3600], ['pot', 1700], ['pot', 4200], ['crate', 2900], ['crate', 2928, 1], ['bucket', 2600], ['lever', 3000, 'bell'], ['puddle', 2000, 70], ['grass', 4800, 180]] },
    { platforms: [[700, 384, 150], [890, 328, 140], [1080, 272, 140], [2300, 384, 150], [2490, 328, 140], [3900, 384, 150], [4090, 328, 140]], gaps: [] });

  const CAMS = window.CampanhaCamadas;
  CAMS.configurar(28, { povo: 4, trilha: true, fg: 'natureza' }); CAMS.configurar(29, { povo: 10, fgDraw: torcidaFrente }); CAMS.configurar(30, { povo: 20, fg: 'interno' }); CAMS.configurar(31, { povo: 22, fg: 'cidade' });
  const PL = window.CampanhaPlantas; if (PL?.adicionar) { PL.adicionar(28, [['samambaia', 300, 160], ['capim', 1000, 120], ['flores', 1500, 90], ['samambaia', 2300, 140], ['capim', 3400, 160], ['samambaia', 4100, 120], ['flores', 4800, 100]]); PL.adicionar(31, [['floreira', 600, 100], ['flores', 4300, 140], ['capim', 4700, 160], ['floreira', 3100, 100]]); }
  window.CampanhaNovos = { PLAT, placa, nota, vaoAgua, indoor, drawMid };
})();
