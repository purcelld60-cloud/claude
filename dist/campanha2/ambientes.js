/* Campanha 2 · Ambientes com entrada (Passo 2A).
   Cenas que se ligam por portas, escadas e escada rolante, no estilo da sala do Almiro:
   22 Frente do Shopping · 23 Shopping piso 2 · 24 Corredor da pensão · 25 Quarto do Da Roça
   26 Escola SESI por dentro (escada atrás da porta, com efeito de transparência) · 27 Pátio no 2º andar.
   As passagens (CampanhaAmbientes.portais) dizem de onde se entra e para onde vai; o computador do
   quarto abre o Fliperama. A ligação com o jogo de verdade (andar, apertar E) entra no Passo 5;
   até lá, tudo funciona no visualizador (?cenarios2). Nada aqui muda a campanha original. */
(() => {
  'use strict';
  if (window.CampanhaAmbientes || !window.CampanhaCenarios?.arte) return;
  const A = window.CampanhaCenarios.arte;
  const { GY, R, ell, mk, hash, cl, limb, sky, tile, tree, bench, lampPost, lampGlow, lightAdd, vis, night, shadeHex, pick,
    plaster, brick, azulejo, roofTiles, janela, caixaDagua, plantaVaso, cartaz, grafite, gato, carro, ponto, lixeira, placaRua, moto, bike, ipe,
    calcada, asfalto, pedraPortuguesa, conquistaBack, fog, pessoa, coluna, reflexo, vgrad, lojaFrente, OBJ, SHOP } = A;
  const LH = 270;
  const HERO = () => A.heroiPos();

  /* ---------- peças comuns de interior ---------- */
  function marmore(c, W) { // piso de mármore polido com veios e reflexo de quem está atrás
    R(c, 0, 210, W, 3, '#6f6a60'); R(c, 0, 210, W, 1, '#a8a294'); vgrad(c, 0, 213, W, LH - 213, '#f2ede2', '#ddd6c8');
    const rows = [213, 218, 224, 232, 243, 257, 270]; for (let r = 1; r < rows.length; r++) { R(c, 0, rows[r], W, 1, '#cdc5b4'); const step = 26 + r * 10; for (let x = (r % 2) * step / 2; x < W; x += step) R(c, x, rows[r - 1] + 1, 1, rows[r] - rows[r - 1] - 1, '#d6cfbf'); }
    for (let i = 0; i < W / 4; i++) { const vx = hash(i * 1.7) * W, vy = 216 + hash(i * 2.9) * 50; limb(c, [[vx, vy], [vx + 4 + hash(i) * 6, vy + hash(i * 5) * 3 - 1]], 1, 'rgba(150,140,125,.28)'); }
  }
  function espelharChao(c, cv, W, alpha = .15) { const H = LH - 213, [tmp, tc] = mk(W, H); tc.drawImage(cv, 0, 210 - H, W, H, 0, 0, W, H); c.save(); c.globalAlpha = alpha; c.translate(0, 213 + H); c.scale(1, -1); c.drawImage(tmp, 0, 0); c.restore(); for (let k = 0; k < H; k++) R(c, 0, 213 + k, W, 1, `rgba(238,233,222,${k / H * .55})`); }
  function tacos(c, W, y = 210) { // assoalho de madeira com tábuas, nós e brilho
    R(c, 0, y, W, LH - y, '#8a5a36'); for (let r = 0, yy = y; yy < LH; r++, yy += 6 + r) { R(c, 0, yy, W, 1, '#5a3a20'); const off = (r * 37) % 60; for (let x = off; x < W; x += 60) R(c, x, yy + 1, 1, 6 + r, '#6a4428'); for (let x = 0; x < W; x += 3) if (hash(x * 3 + r * 17) > .82) R(c, x, yy + 2 + Math.round(hash(x + r) * 3), 2, 1, hash(x + r) > .5 ? '#9a6a42' : '#7a4c2c'); } R(c, 0, y, W, 2, '#a8784a');
    for (let k = 0; k < W; k += 40) R(c, k + 10, y + 4, 14, 1, 'rgba(255,240,210,.18)');
  }
  function porta(c, x, y, w, h, col, o = {}) { // porta de madeira com almofadas, batente, maçaneta e placa
    R(c, x - 3, y - 3, w + 6, h + 3, o.batente || '#efe6d4'); R(c, x - 3, y - 3, w + 6, 1, '#ffffff'); R(c, x + w + 2, y - 3, 1, h + 3, '#c8bca4');
    R(c, x, y, w, h, col); R(c, x, y, 2, h, shadeHex(col, 1.15)); R(c, x + w - 2, y, 2, h, shadeHex(col, .75));
    for (const [py, ph] of [[y + 6, h * .38], [y + h * .5, h * .42]]) { R(c, x + 5, py, w - 10, ph, shadeHex(col, .88)); R(c, x + 5, py, w - 10, 1, shadeHex(col, .7)); R(c, x + 5, py + ph - 1, w - 10, 1, shadeHex(col, 1.12)); }
    if (o.vidro) { R(c, x + 6, y + 8, w - 12, h * .3, '#9fc4d0'); R(c, x + 7, y + 9, 3, h * .3 - 2, '#d8eef4'); }
    R(c, x + w - 7, y + h * .52, 4, 3, '#c8a24a'); R(c, x + w - 7, y + h * .52, 4, 1, '#f2d898');
    if (o.placa) { R(c, x + w / 2 - 7, y + 3, 14, 7, '#c8a24a'); R(c, x + w / 2 - 6, y + 4, 12, 5, '#f6e8b8'); }
    R(c, x - 2, y + h, w + 4, 2, '#6a5a44');
  }
  function quadro(c, x, y, w, h, kind, seed) { // moldura com pintura simples (Cristo, Catedral, cacau, paisagem)
    R(c, x - 2, y - 2, w + 4, h + 4, '#8a6a3a'); R(c, x - 2, y - 2, w + 4, 1, '#c8a46a'); vgrad(c, x, y, w, h, '#a8d0e8', '#e8d8b8');
    if (kind === 'cristo') { R(c, x, y + h - 6, w, 6, '#8a9a6a'); R(c, x + w / 2, y + 3, 1, h - 8, '#6a6258'); R(c, x + w / 2 - 4, y + 6, 9, 1, '#6a6258'); }
    if (kind === 'catedral') { R(c, x + w / 2 - 5, y + h - 14, 10, 14, '#eedfb6'); R(c, x + w / 2 - 2, y + 3, 4, 10, '#eedfb6'); R(c, x + w / 2 - 1, y + 1, 2, 2, '#eedfb6'); }
    if (kind === 'cacau') { R(c, x, y + h - 5, w, 5, '#4f8a3a'); ell(c, x + w / 2, y + h / 2, 5, 7, '#c47a35'); R(c, x + w / 2 - 1, y + h / 2 - 6, 1, 12, '#8a4a20'); }
    if (kind === 'paisagem') { R(c, x, y + h - 7, w, 7, '#5f8a46'); ell(c, x + w * .3, y + h - 8, 6, 4, '#6a8a5a'); ell(c, x + w * .7, y + 5, 3, 3, '#f2e8a8'); }
    if (kind === 'trio') { R(c, x, y, w, h, '#f6f2ea'); for (let k = 0; k < 3; k++) { const px = x + 3 + k * (w - 6) / 3; R(c, px + 1, y + 4, 3, 3, ['#d6a071', '#825033', '#dcaa82'][k]); R(c, px, y + 7, 5, 6, ['#dc8c47', '#4d7374', '#1c1e22'][k]); } }
  }
  function arandela(c, x, y) { R(c, x - 1, y, 3, 6, '#c8a24a'); ell(c, x, y - 2, 4, 3, '#f6e8c8'); R(c, x - 3, y - 2, 7, 1, '#fffaf0'); }

  /* =====================================================================
     22 · FRENTE DO SHOPPING
     ===================================================================== */
  const FR = { W: 1300, ENT: 680 };
  function buildFrente() {
    const [cv, c] = mk(FR.W, LH);
    // bloco principal: revestimento em placas, faixa de vidro, platibanda e lojas âncora
    const x0 = 300, x1 = 1060, top = 54;
    for (let x = x0; x < x1; x += 20) { R(c, x, top, 20, GY - top, (x / 20) % 2 ? '#e6e2d8' : '#dcd7cb'); R(c, x, top, 1, GY - top, '#c8c2b4'); } for (let y = top + 24; y < GY; y += 24) R(c, x0, y, x1 - x0, 1, '#c8c2b4');
    R(c, x0 - 4, top - 6, x1 - x0 + 8, 6, '#f4f0e8'); R(c, x0 - 4, top - 6, x1 - x0 + 8, 1, '#ffffff'); R(c, x0 - 4, top, x1 - x0 + 8, 2, '#a8a294'); R(c, x0, top + 6, x1 - x0, 4, '#e8833a'); R(c, x0, top + 10, x1 - x0, 1, '#b8642a');
    R(c, x0, top + 18, x1 - x0, 26, '#2c4656'); for (let x = x0; x < x1; x += 14) { vgrad(c, x + 1, top + 19, 12, 24, '#7fb0c8', '#3c6a84'); } reflexo(c, x0, top + 18, x1 - x0, 26);
    for (const [ax, col] of [[x0 + 20, '#c43c3a'], [x1 - 190, '#2c5a9e']]) { R(c, ax, top + 52, 170, 30, '#1c1f24'); vgrad(c, ax + 2, top + 54, 166, 26, shadeHex(col, 1.2), shadeHex(col, .8)); R(c, ax + 2, top + 54, 166, 1, '#ffffff66'); R(c, ax + 10, top + 90, 150, 58, '#2a3640'); for (let k = 0; k < 5; k++) { vgrad(c, ax + 12 + k * 30, top + 92, 28, 54, '#fff4dc', '#e8d8b8'); for (let j = 0; j < 3; j++) R(c, ax + 15 + k * 30 + j * 8, top + 110, 6, 14, pick(['#d9634a', '#3c6aa8', '#e8c24c', '#3c8a5a'], k + j)); } reflexo(c, ax + 10, top + 90, 150, 58); }
    // cartazes de cinema em caixas de luz
    for (let k = 0; k < 3; k++) { const px = x0 + 220 + k * 34; if (px > FR.ENT - 110) break; R(c, px, top + 92, 28, 40, '#c8a24a'); vgrad(c, px + 2, top + 94, 24, 36, pick(['#3c6ab0', '#b83a3a', '#2a7a4a'], k), '#1a1420'); R(c, px + 8, top + 106, 10, 18, '#14101a'); R(c, px + 4, top + 124, 20, 3, '#f2efe6'); }
    // átrio de vidro da entrada (mais alto) com grade de caixilhos
    const ex0 = FR.ENT - 110, ex1 = FR.ENT + 110, et = 24; R(c, ex0 - 3, et - 3, ex1 - ex0 + 6, GY - et + 3, '#5a646c'); vgrad(c, ex0, et, ex1 - ex0, GY - et, '#a8d0e4', '#4a7a92');
    for (let x = ex0; x <= ex1; x += 22) R(c, x, et, 2, GY - et, '#3c4850'); for (let y = et; y < GY; y += 26) R(c, ex0, y, ex1 - ex0, 2, '#3c4850'); reflexo(c, ex0, et, ex1 - ex0, GY - et);
    for (let k = 0; k < 6; k++) R(c, ex0 + 10 + k * 34, et + 40, 8, 26, pick(['#e8833a', '#3c8ad8', '#c43c3a', '#f2c94c'], k)); // faixas penduradas lá dentro
    R(c, FR.ENT - 70, et + 8, 140, 22, '#1c1f24'); vgrad(c, FR.ENT - 68, et + 10, 136, 18, '#f6a24a', '#d8642a'); R(c, FR.ENT - 68, et + 10, 136, 1, '#ffd8a8');
    // marquise com spots e porta giratória
    R(c, ex0 - 40, 140, ex1 - ex0 + 80, 8, '#f4f2ee'); R(c, ex0 - 40, 140, ex1 - ex0 + 80, 1, '#ffffff'); R(c, ex0 - 40, 148, ex1 - ex0 + 80, 3, '#9aa0a6'); for (let x = ex0 - 30; x < ex1 + 40; x += 20) R(c, x, 150, 6, 2, '#fff6d8'); for (const px of [ex0 - 34, ex1 + 30]) { R(c, px, 151, 4, GY - 151, '#c8ccd0'); R(c, px, 151, 1, GY - 151, '#f2f4f6'); }
    const dx = FR.ENT; ell(c, dx, 208, 30, 4, '#3c4850'); R(c, dx - 30, 162, 60, 46, 'rgba(160,210,230,.45)'); R(c, dx - 30, 160, 60, 4, '#5a646c'); R(c, dx - 1, 164, 2, 44, '#3c4850'); limb(c, [[dx - 26, 170], [dx + 24, 200]], 1, '#3c4850'); for (const sx of [dx - 70, dx + 40]) { R(c, sx, 162, 30, 46, 'rgba(160,210,230,.55)'); R(c, sx, 162, 30, 2, '#5a646c'); R(c, sx + 14, 162, 2, 46, '#5a646c'); }
    // estacionamento com carros, cancela e cabine
    for (let k = 0; k < 4; k++) carro(c, 24 + k * 62, GY + 2, pick(['#c43c3a', '#f2f2ee', '#2a2a2a', '#3c6aa8', '#9aa0a6'], k), k % 2 ? 1 : -1);
    R(c, 276, GY - 30, 18, 30, '#e8e4dc'); R(c, 276, GY - 30, 18, 3, '#c43c3a'); R(c, 279, GY - 24, 12, 8, '#9fc4d0'); limb(c, [[294, GY - 14], [330, GY - 14]], 2, '#e8433a'); for (let k = 296; k < 330; k += 8) R(c, k, GY - 15, 4, 2, '#f2efe6');
    R(c, 240, GY - 52, 2, 52, '#5a5e62'); R(c, 230, GY - 62, 22, 14, '#2c5aa8'); R(c, 233, GY - 59, 16, 8, '#f2efe6');
    // totem com o logo e as lojas
    const tx = 1140; R(c, tx, 30, 40, GY - 30, '#2a3036'); R(c, tx + 2, 32, 36, 28, '#e8833a'); R(c, tx + 2, 32, 36, 1, '#ffd8a8'); for (let k = 0; k < 7; k++) { R(c, tx + 4, 66 + k * 14, 32, 10, pick(['#c43c3a', '#2c5a9e', '#3c8a5a', '#7a3a8a', '#e8c24c', '#d84a7a', '#2a2a2a'], k)); R(c, tx + 6, 69 + k * 14, 20, 3, '#f2efe6'); }
    ponto(c, 1200); lixeira(c, 1110); placaRua(c, 1270); bike(c, 1060, '#3c8ad8'); moto(c, 1084, '#2a2a2a');
    for (let k = 0; k < 3; k++) { R(c, 1210 + k * 30, GY + 16, 28, 10, '#e8c24c'); } // táxis na fila (calçada)
    for (const px of [x0 + 10, ex0 - 60, ex1 + 50, x1 - 20]) { R(c, px - 10, GY - 10, 22, 10, '#8a8478'); R(c, px - 10, GY - 10, 22, 2, '#b4ae9e'); for (let k = 0; k < 8; k++) ell(c, px - 6 + k * 2.5, GY - 14 - (k % 3) * 3, 3, 3, pick(['#e86a7a', '#f2c94c', '#4f8a3a', '#f6f2ea'], k)); }
    pedraPortuguesa(c, FR.W, 204); R(c, 0, 220, FR.W, 1, '#8a8478'); asfalto(c, FR.W, []);
    return cv;
  }
  let frenteMid = null;
  function frente(c, s, t, camL) {
    if (!frenteMid) frenteMid = buildFrente();
    conquistaBack(c, s, t, camL, { seed: 21 });
    for (const x of [140, 1240]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 200, .8, 1, t, x); }
    c.drawImage(frenteMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    for (const x of [FR.ENT - 160, FR.ENT + 160]) { const sx = x - camL; if (vis(sx, 60)) ipe(c, sx, 206, x < FR.ENT ? '#b86ac8' : '#e8c84a', x, .8); }
    { const ph = (t * .4) % 1, dx = FR.ENT - camL; if (vis(dx, 40)) for (let k = 0; k < 3; k++) { const a = (ph + k / 3) * Math.PI, px = dx + Math.cos(a) * 26; R(c, px, 164, 2, 44, 'rgba(60,72,80,.8)'); } }
    for (let i = 0; i < 16; i++) { const wx = 40 + i * 82 + Math.sin(t * .3 + i * 2) * 40, sx = wx - camL; if (vis(sx, 20)) pessoa(c, sx, 216, i); }
    { const cx = ((t * 30) % 1700) - 200 - camL; if (vis(cx, 40)) carro(c, cx, 246, '#c43c3a', 1); const cx2 = 1500 - ((t * 24) % 1700) - camL; if (vis(cx2, 40)) carro(c, cx2, 260, '#e8c24c', -1); }
    fog(c, s, t, camL, .2);
  }
  function frenteLights(g, s, t, camL) { const a = Math.max(.15, night(s)); for (let x = FR.ENT - 140; x < FR.ENT + 150; x += 20) { const sx = x - camL; if (vis(sx)) lightAdd(sx, 150, a * .5, 50); } const tx = 1160 - camL; if (vis(tx, 40)) { g.fillStyle = `rgba(255,190,120,${.25 * a})`; g.fillRect(tx - 20, 30, 40, 180); } }

  /* =====================================================================
     23 · SHOPPING PISO 2 (lojas com paródias de marcas reais)
     ===================================================================== */
  const P2 = { W: 1600, ESC: 50 };
  const LOJAS2 = [['RIACHORRO', 'MODA'], ['MAGAZINE LURDES', 'ELETRO'], ['SENTAURO', 'TÊNIS'], ['O BUTECÁRIO', 'PERFUMES'], ['CACAU CHOU', 'CHOCOLATE'], ['LIVRARIA CUTUCADA', 'LIVROS'], ['GAMESTOPA', 'GAMES'], ['RI TRISTE', 'BRINQUEDOS'], ['AMENICANAS', 'ELETRO']];
  function buildPiso2() {
    const W = P2.W, [cv, c] = mk(W, LH), MZ = SHOP.MZ;
    // cobertura de vidro com arcos de aço (o céu aparece entre os vidros)
    R(c, 0, 0, W, 46, '#c4ccd2'); for (let x = 0; x < W; x += 40) { c.clearRect(x + 3, 2, 34, 32); R(c, x + 3, 2, 34, 32, 'rgba(205,234,248,.22)'); R(c, x + 4, 3, 10, 30, 'rgba(255,255,255,.14)'); }
    for (let x = 0; x < W; x += 160) for (let k = 0; k <= 160; k += 2) { const yy = 34 - Math.round(Math.sin(k / 160 * Math.PI) * 26); R(c, x + k, yy, 2, 3, '#7a8892'); if (k % 16 === 0) limb(c, [[x + k, yy + 3], [x + k, 40]], 1, '#98a4ae'); }
    R(c, 0, 38, W, 4, '#8a96a0'); R(c, 0, 42, W, 4, '#d8dce0'); for (let x = 20; x < W; x += 40) { R(c, x, 44, 6, 2, '#fff6d8'); }
    // parede de mármore do lado da escada
    vgrad(c, 0, 46, 196, 164, '#ece6da', '#ddd5c6'); c.clearRect(0, 46, 196, MZ - 46 - 2);
    // lojas com nome de paródia
    LOJAS2.forEach(([, kind], i) => lojaFrente(c, 200 + i * 150 + 2, 146, kind, i + 11));
    for (let i = 0; i <= LOJAS2.length; i++) { coluna(c, 196 + i * 150, 46, MZ - 2); coluna(c, 196 + i * 150, SHOP.TOP, 210); }
    // vão com guarda-corpo por cima das lojas (dá para ver o átrio)
    R(c, 0, MZ - 14, W, 14, 'rgba(188,226,238,.38)'); for (let x = 0; x < W; x += 24) R(c, x, MZ - 14, 2, 14, '#9aa6ae'); R(c, 0, MZ - 17, W, 3, '#b8c2c8'); R(c, 0, MZ - 17, W, 1, '#f6fafc');
    R(c, 0, MZ, W, 12, '#f6f4ee'); R(c, 0, MZ, W, 1, '#ffffff'); vgrad(c, 0, MZ + 12, W, 6, '#aaa496', '#d6d0c4');
    marmore(c, W);
    // escada rolante descendo: abertura no piso, degraus e corrimão
    const ex = P2.ESC; R(c, ex, 213, 120, 57, '#2a2e34'); for (let k = 0; k <= 30; k++) { const u = k / 30, sx = ex + 116 - u * 110, sy = 213 + u * 57; R(c, sx, sy, 6, 2, '#c4ccd2'); R(c, sx, sy + 2, 6, 1, '#6a747c'); }
    R(c, ex, 213, 120, 2, '#c8ccd0'); limb(c, [[ex + 124, 196], [ex + 104, 200], [ex + 20, 260]], 3, '#1e1e22'); limb(c, [[ex + 124, 195], [ex + 104, 199], [ex + 20, 259]], 1, '#4a4a52'); R(c, ex + 118, 196, 10, 14, '#8a949a'); R(c, ex + 118, 196, 10, 2, '#c8ccd0');
    espelharChao(c, cv, W);
    return cv;
  }
  let piso2Mid = null;
  function piso2(c, s, t, camL) {
    if (!piso2Mid) piso2Mid = buildPiso2();
    sky(c, s, t, camL); tile(c, A.shopFar(), camL * .4 + 300);
    for (let x = 120; x < P2.W; x += 260) { const sx = x - camL, sw = Math.round(Math.sin(t * 1.1 + x)); if (!vis(sx, 40)) continue; R(c, sx + 8, 44, 1, 6, '#5a6066'); vgrad(c, sx + 4 + sw, 50, 26, 30, '#c43c3a', '#7a1e1e'); R(c, sx + 4 + sw, 50, 26, 2, '#e86a6a'); R(c, sx + 8 + sw, 72, 18, 2, '#f2c94c'); }
    for (let i = 0; i < 8; i++) { const wx = 40 + i * 200 + Math.sin(t * .2 + i * 1.3) * 60, sx = wx - camL; if (vis(sx, 20)) pessoa(c, sx, SHOP.MZ, i + 6); }
    c.drawImage(piso2Mid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    for (let k = 0; k < 16; k++) { const u = (t * .16 + k / 16) % 1, x = P2.ESC + 116 - u * 110 - camL, y = 213 + u * 57; if (vis(x, 10)) R(c, x, y - 1, 6, 1, '#eef2f4'); }
    for (let i = 0; i < 16; i++) { const wx = 220 + i * 90 + Math.sin(t * .35 + i * 2) * 40, sx = wx - camL; if (vis(sx, 20)) pessoa(c, sx, 216, i + 3); }
  }
  function piso2Lights(g, s, t, camL) { for (let x = 20; x < P2.W; x += 40) { const sx = x + 3 - camL; if (vis(sx)) lightAdd(sx, 44, .22, 50); } }

  /* =====================================================================
     24 · CORREDOR DA PENSÃO
     ===================================================================== */
  const COR = { W: 700, QUARTO: 450 };
  function buildCorredor() {
    const W = COR.W, [cv, c] = mk(W, LH);
    vgrad(c, 0, 0, W, 22, '#f2ece0', '#d8ceba'); R(c, 0, 22, W, 3, '#b8a888'); R(c, 0, 25, W, 2, '#efe6d4');
    // papel de parede listrado com florzinhas
    for (let x = 0; x < W; x += 12) { R(c, x, 27, 6, 103, '#e8d8b8'); R(c, x + 6, 27, 6, 103, '#efe2c6'); for (let y = 34 + (x / 12 % 2) * 10; y < 128; y += 20) { R(c, x + 2, y, 2, 2, '#c47a6a'); R(c, x + 3, y + 2, 1, 2, '#6a8a4a'); } }
    for (let i = 0; i < W * 3; i++) R(c, hash(i * 1.3) * W, 27 + hash(i * 2.1) * 100, 1, 1, 'rgba(120,90,50,.12)'); // manchinhas
    R(c, 0, 128, W, 4, '#9a6a3a'); R(c, 0, 128, W, 1, '#c8945a'); for (let x = 0; x < W; x += 30) { R(c, x, 132, 30, 74, '#7a4a2a'); R(c, x + 3, 136, 24, 66, '#8a5a34'); R(c, x + 3, 136, 24, 1, '#6a3e22'); R(c, x + 3, 201, 24, 1, '#a8784a'); } R(c, 0, 204, W, 6, '#5a3a20');
    // porta da rua (com vidro e a neblina lá fora)
    porta(c, 20, 118, 36, 92, '#6a3c24', { vidro: true });
    // portas dos quartos
    [[120, '1'], [230, '2'], [340, '3'], [COR.QUARTO, '4'], [560, '5']].forEach(([x, n]) => { porta(c, x, 118, 34, 92, n === '4' ? '#7a4a2e' : '#8a5a36', { placa: true }); R(c, x + 2, 210, 30, 3, n === '4' ? '#c43c3a' : '#5a6a3a'); });
    // quadros, arandelas, mesinha do rádio (sumiu!), cabideiro, guarda-chuvas, relógio, telefone e janela do fundo
    quadro(c, 78, 60, 26, 20, 'cristo', 1); quadro(c, 180, 56, 30, 24, 'catedral', 2); quadro(c, 290, 62, 22, 18, 'paisagem', 3); quadro(c, 400, 58, 28, 22, 'cacau', 4); quadro(c, 520, 64, 22, 18, 'paisagem', 5);
    for (const x of [100, 210, 320, 430, 540]) arandela(c, x, 96);
    R(c, 270, 160, 46, 4, '#7a4a2a'); R(c, 272, 164, 3, 42, '#5a3a20'); R(c, 311, 164, 3, 42, '#5a3a20'); R(c, 272, 184, 42, 2, '#5a3a20'); R(c, 280, 154, 26, 6, 'rgba(0,0,0,.12)'); R(c, 284, 146, 18, 10, '#f6f2e8'); R(c, 286, 148, 14, 1, '#c43c3a'); R(c, 286, 151, 10, 1, '#5a5a5a'); R(c, 286, 153, 12, 1, '#5a5a5a'); // marca do rádio + bilhete
    R(c, 74, 104, 3, 102, '#5a3a20'); R(c, 66, 104, 18, 3, '#5a3a20'); for (const [cx, col] of [[64, '#3a4a6a'], [80, '#7a3a3a']]) { R(c, cx, 107, 8, 26, col); R(c, cx, 107, 8, 2, shadeHex(col, 1.2)); } limb(c, [[68, 108], [72, 140]], 2, '#e8c24c');
    R(c, 90, 186, 12, 20, '#4a5a6a'); for (let k = 0; k < 3; k++) limb(c, [[93 + k * 3, 186], [92 + k * 4, 170 - k * 4]], 1, pick(['#c43c3a', '#2c5a9e', '#2a2a2a'], k));
    ell(c, 380, 44, 8, 8, '#5a3a20'); ell(c, 380, 44, 6, 6, '#f6f2ea'); R(c, 380, 39, 1, 5, '#2a2a2a'); R(c, 380, 44, 4, 1, '#2a2a2a');
    R(c, 500, 140, 12, 20, '#3a3a3a'); R(c, 502, 142, 8, 6, '#6a6a6a'); limb(c, [[506, 160], [508, 176]], 1, '#2a2a2a');
    R(c, 628, 50, 56, 66, '#efe6d4'); vgrad(c, 632, 54, 48, 58, '#d8e2e6', '#b8c6cc'); R(c, 655, 54, 2, 58, '#efe6d4'); R(c, 632, 82, 48, 2, '#efe6d4'); for (let k = 0; k < 6; k++) ell(c, 640 + k * 8, 92 + (k % 2) * 6, 8, 4, 'rgba(255,255,255,.5)'); R(c, 622, 46, 8, 74, '#c47a6a'); R(c, 682, 46, 8, 74, '#c47a6a'); R(c, 620, 44, 72, 3, '#8a6a3a');
    R(c, 632, 168, 48, 30, '#e8e4dc'); for (let k = 0; k < 8; k++) R(c, 634 + k * 6, 170, 3, 26, '#c8c4bc'); R(c, 630, 166, 52, 3, '#f6f2e8'); // aquecedor
    tacos(c, W); for (let x = 0; x < W; x += 2) R(c, x, 224, 2, 22, hash(x * .3) > .5 ? '#9a2a2a' : '#8a2424'); R(c, 0, 224, W, 2, '#c8a24a'); R(c, 0, 244, W, 2, '#c8a24a'); for (let x = 6; x < W; x += 24) { R(c, x, 232, 6, 6, '#c8a24a'); R(c, x + 2, 234, 2, 2, '#5a1a1a'); }
    return cv;
  }
  let corMid = null;
  function corredor(c, s, t, camL) {
    if (!corMid) corMid = buildCorredor();
    c.fillStyle = '#d8ceba'; c.fillRect(0, 0, LW(), LH); c.drawImage(corMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    { const x = 30 - camL; if (vis(x, 40)) for (let k = 0; k < 4; k++) ell(c, x + 6 + k * 6, 132 + Math.sin(t * .5 + k) * 3, 6, 3, 'rgba(255,255,255,.35)'); }
    { const x = 600 - camL; if (vis(x, 30)) { const br = Math.round(Math.sin(t * 1.4) * 1); R(c, x, 202 + br, 14, 6, '#d8a24a'); R(c, x + 10, 199 + br, 6, 5, '#d8a24a'); R(c, x + 11, 198, 1, 1, '#d8a24a'); R(c, x + 14, 198, 1, 1, '#d8a24a'); R(c, x - 4, 205, 6, 2, '#d8a24a'); } }
    { const x = 632 - camL; if (vis(x, 60)) { const a = .25 + Math.sin(t * 3) * .05; R(c, x + 2, 170, 44, 26, `rgba(255,140,60,${a})`); } }
  }
  function corredorLights(g, s, t, camL) { for (const x of [100, 210, 320, 430, 540]) { const sx = x - camL; if (vis(sx)) { const gr = g.createRadialGradient(sx, 92, 2, sx, 92, 40); gr.addColorStop(0, 'rgba(255,214,150,.45)'); gr.addColorStop(1, 'rgba(255,214,150,0)'); g.fillStyle = gr; g.fillRect(sx - 40, 52, 80, 80); lightAdd(sx, 94, .6, 50); } } }

  /* =====================================================================
     25 · QUARTO DO DA ROÇA (o computador abre o Fliperama)
     ===================================================================== */
  const QT = { W: 480, PC: 186 };
  function buildQuarto() {
    const W = QT.W, [cv, c] = mk(W, LH);
    vgrad(c, 0, 0, W, 16, '#eef0f2', '#d0d4d8'); R(c, 0, 16, W, 3, '#b8bcc0');
    plaster(c, 0, 19, W, 187, '#c8d6dc', 25); for (let i = 0; i < 6; i++) ell(c, 20 + hash(i + 5) * 440, 40 + hash(i + 6) * 30, 6 + hash(i) * 6, 4, 'rgba(120,140,150,.12)'); // manchas de umidade (frio!)
    R(c, 0, 196, W, 10, '#e8ecee'); R(c, 0, 196, W, 1, '#ffffff'); R(c, 0, 205, W, 1, '#a8b0b4');
    // porta para o corredor e guarda-roupa
    porta(c, 22, 118, 34, 92, '#8a5a36');
    R(c, 70, 74, 52, 132, '#7a4e2e'); R(c, 72, 76, 23, 128, '#8a5a36'); R(c, 97, 76, 23, 128, '#8a5a36'); R(c, 94, 80, 1, 122, '#5a3a20'); R(c, 90, 136, 2, 8, '#c8a24a'); R(c, 99, 136, 2, 8, '#c8a24a'); R(c, 70, 72, 52, 3, '#a8784a'); R(c, 76, 62, 20, 12, '#c47a35'); R(c, 98, 66, 18, 8, '#3c6aa8'); // caixas em cima
    // escrivaninha com computador (o "fliperama"), cadeira gamer, estante e pôsteres
    R(c, 130, 158, 120, 6, '#6a4428'); R(c, 130, 158, 120, 1, '#9a6a42'); R(c, 134, 164, 4, 42, '#5a3a20'); R(c, 242, 164, 4, 42, '#5a3a20'); R(c, 200, 164, 42, 22, '#7a4e2e'); R(c, 218, 172, 6, 2, '#c8a24a');
    const mx = QT.PC - 26; R(c, mx, 112, 52, 34, '#14161c'); R(c, mx + 24, 146, 4, 8, '#2a2c34'); R(c, mx + 16, 154, 20, 4, '#2a2c34'); R(c, mx + 2, 114, 48, 30, '#1e2236');
    R(c, 232, 120, 16, 38, '#1c1e24'); R(c, 233, 122, 14, 34, '#2a2c36'); R(c, 235, 126, 10, 2, '#e05a8a'); R(c, 235, 130, 10, 2, '#5ae0d0'); ell(c, 240, 144, 4, 4, '#3a3c48');
    R(c, mx + 4, 156, 34, 3, '#2a2a30'); R(c, mx + 42, 156, 6, 3, '#2a2a30'); limb(c, [[138, 132], [146, 128], [150, 140]], 2, '#2a2a30'); R(c, 138, 140, 4, 6, '#2a2a30'); R(c, 150, 150, 8, 8, '#f2efe6'); R(c, 152, 152, 4, 4, '#7a4a2a'); // fone e caneca de café
    R(c, 160, 166, 26, 30, '#c43c3a'); R(c, 162, 146, 22, 22, '#c43c3a'); R(c, 164, 148, 18, 4, '#2a2a2a'); R(c, 160, 166, 26, 2, '#e86a6a'); R(c, 172, 196, 2, 8, '#3a3a3a'); R(c, 164, 204, 18, 2, '#3a3a3a');
    R(c, 136, 84, 100, 3, '#8a5a36'); for (let k = 0; k < 14; k++) R(c, 140 + k * 4, 72 + (k % 3), 3, 12 - (k % 3), pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#3c8a5a', '#7a3a8a'], k)); quadro(c, 200, 68, 16, 14, 'trio', 9); R(c, 222, 74, 8, 10, '#c8a24a'); R(c, 224, 70, 4, 4, '#c8a24a');
    R(c, 140, 30, 34, 44, '#2c3a5a'); R(c, 142, 32, 30, 40, '#e8833a'); ell(c, 157, 48, 8, 8, '#f2c94c'); R(c, 146, 62, 22, 4, '#2c3a5a'); // pôster
    R(c, 192, 26, 46, 34, '#f6f2e8'); R(c, 194, 28, 42, 30, '#d8e8d0'); limb(c, [[198, 50], [210, 36], [222, 44], [232, 32]], 1, '#c43c3a'); R(c, 210, 36, 3, 3, '#c43c3a'); // mapa de Conquista
    // janela com neblina e o Cristo lá longe
    R(c, 300, 52, 84, 76, '#efe6d4'); vgrad(c, 304, 56, 76, 68, '#c8d4dc', '#e2e6e8'); R(c, 304, 104, 76, 20, '#b8c4c8'); for (let k = 0; k < 12; k++) R(c, 306 + k * 6, 98 + Math.round(hash(k) * 6), 4, 26, '#c8d0d4'); R(c, 350, 64, 1, 18, '#7a8486'); R(c, 346, 68, 9, 1, '#7a8486');
    for (let k = 0; k < 6; k++) ell(c, 312 + k * 12, 84 + (k % 2) * 8, 12, 5, 'rgba(255,255,255,.45)'); R(c, 341, 56, 2, 68, '#efe6d4'); R(c, 304, 88, 76, 2, '#efe6d4'); R(c, 292, 46, 12, 86, '#7a5aa0'); R(c, 380, 46, 12, 86, '#7a5aa0'); R(c, 290, 44, 104, 3, '#8a6a3a'); R(c, 298, 128, 88, 4, '#f6f2e8');
    // cama com cobertor grosso, travesseiros e cobertor extra dobrado
    R(c, 330, 140, 8, 66, '#6a4428'); R(c, 330, 140, 8, 2, '#9a6a42'); R(c, 336, 168, 140, 24, '#f2efe6'); for (let x = 336; x < 476; x += 8) for (let y = 168; y < 192; y += 8) R(c, x, y, 4, 4, (x + y) % 16 ? '#b83a3a' : '#2c5a9e'); R(c, 336, 168, 140, 2, '#d84a4a'); R(c, 336, 190, 140, 4, '#8a2a2a');
    ell(c, 352, 164, 14, 6, '#f6f4ee'); ell(c, 352, 162, 12, 4, '#ffffff'); R(c, 336, 192, 140, 14, '#6a4428'); R(c, 340, 206, 4, 4, '#5a3a20'); R(c, 468, 206, 4, 4, '#5a3a20');
    for (let k = 0; k < 3; k++) R(c, 430, 156 - k * 4, 36, 4, pick(['#7a8ab8', '#c8a46a', '#5a8a6a'], k));
    R(c, 306, 168, 22, 38, '#7a4e2e'); R(c, 308, 176, 18, 2, '#5a3a20'); R(c, 314, 186, 6, 2, '#c8a24a'); R(c, 312, 156, 4, 12, '#c8a24a'); ell(c, 314, 154, 7, 5, '#f6e8c8'); R(c, 318, 162, 8, 6, '#2a2a2a'); R(c, 319, 163, 6, 3, '#e8433a');
    // aquecedor, tapete, mala aberta com roupas e caminha do Biscoito
    R(c, 264, 176, 30, 30, '#e8e4dc'); for (let k = 0; k < 5; k++) R(c, 267 + k * 5, 178, 3, 26, '#c8c4bc'); R(c, 262, 174, 34, 3, '#f6f2e8');
    tacos(c, W); ell(c, 236, 224, 70, 9, '#7a5a9a'); ell(c, 236, 224, 62, 7, '#9a7ab8'); for (let k = 0; k < 10; k++) R(c, 180 + k * 11, 223, 5, 2, '#c8b8e0');
    R(c, 70, 214, 50, 10, '#2c5a9e'); R(c, 70, 206, 50, 8, '#3c6aa8'); R(c, 74, 208, 12, 5, '#e8c24c'); R(c, 88, 207, 14, 6, '#c43c3a'); R(c, 104, 208, 12, 5, '#f2efe6');
    ell(c, 420, 230, 22, 6, '#8a5a36'); ell(c, 420, 228, 18, 4, '#c8a46a');
    return cv;
  }
  let quartoMid = null;
  function quarto(c, s, t, camL) {
    if (!quartoMid) quartoMid = buildQuarto();
    c.drawImage(quartoMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    { const x = QT.PC - 24 - camL; const tela = ['#3c8ae0', '#e05a8a', '#5ae070', '#f2c94c'][Math.floor(t / 2) % 4]; vgrad(c, x, 116, 48, 26, tela, '#1e2236'); R(c, x + 6, 120, 36, 4, '#f2efe6'); for (let k = 0; k < 3; k++) R(c, x + 8 + k * 12, 128, 8, 8, pick(['#e8433a', '#f2c94c', '#5ae0d0'], k + Math.floor(t))); R(c, x + 4 + (Math.floor(t * 6) % 40), 138, 3, 2, '#ffffff'); }
    { const h = (Math.sin(t * 2) + 1) / 2; R(c, 235, 126, 10, 2, h > .5 ? '#e05a8a' : '#5ae0d0'); }
    { const a = .3 + Math.sin(t * 3) * .06; R(c, 266, 178, 26, 26, `rgba(255,140,60,${a})`); }
    for (let k = 0; k < 2; k++) { const ph = (t * .3 + k * .5) % 1; R(c, 153 + Math.sin(t + k) * 1.5, 146 - ph * 14, 2, 3, `rgba(255,255,255,${(1 - ph) * .6})`); }
    for (let k = 0; k < 4; k++) { const x = 306 + ((t * 6 + k * 19) % 74); R(c, x, 60 + k * 14, 8, 2, 'rgba(255,255,255,.35)'); }
  }
  function quartoLights(g, s, t, camL) { const x = QT.PC - camL; const gr = g.createRadialGradient(x, 130, 4, x, 130, 70); gr.addColorStop(0, 'rgba(120,170,255,.35)'); gr.addColorStop(1, 'rgba(120,170,255,0)'); g.fillStyle = gr; g.fillRect(x - 70, 60, 140, 150); const lx = 314 - camL, gl = g.createRadialGradient(lx, 154, 2, lx, 154, 40); gl.addColorStop(0, 'rgba(255,214,150,.5)'); gl.addColorStop(1, 'rgba(255,214,150,0)'); g.fillStyle = gl; g.fillRect(lx - 40, 114, 80, 90); lightAdd(lx, 154, .6, 50); lightAdd(x, 128, .5, 60); }

  /* =====================================================================
     26 · ESCOLA SESI POR DENTRO (escada atrás da porta, com transparência)
     ===================================================================== */
  const ESC = { W: 1000, Z0: 640, Z1: 830 };
  const RAMPA = { x0: 1300, y0: 440, x1: 1580, y1: 200 };
  function paredeEscola(c, x, w) { R(c, x, 24, w, 96, '#f2f2ee'); R(c, x, 120, w, 8, '#2c5a9e'); R(c, x, 120, w, 1, '#5a8ad8'); R(c, x, 128, w, 78, '#dfe2e4'); R(c, x, 204, w, 6, '#9aa0a6'); for (let i = 0; i < w * 2; i++) R(c, x + hash(i * 1.1 + x) * w, 24 + hash(i * 2.3 + x) * 180, 1, 1, 'rgba(120,130,140,.08)'); }
  function buildEscola() {
    const W = ESC.W, [cv, c] = mk(W, LH);
    vgrad(c, 0, 0, W, 22, '#e8eaec', '#c8ccd0'); R(c, 0, 22, W, 2, '#9aa0a6'); for (let x = 30; x < W; x += 90) { R(c, x, 8, 50, 6, '#f6f8fa'); R(c, x + 2, 9, 46, 4, '#ffffff'); }
    paredeEscola(c, 0, W);
    // salas de aula (porta com visor e a turma lá dentro), armários, mural, troféus, bebedouro, extintor e relógio
    for (const [x, n] of [[90, '1º A'], [300, '2º B'], [900, 'LAB']]) { porta(c, x, 118, 34, 92, '#2c5a9e', { batente: '#c8ccd0' }); R(c, x + 8, 128, 18, 22, '#9fc4d0'); for (let k = 0; k < 3; k++) { R(c, x + 10 + k * 5, 140, 3, 3, pick(['#e0b08a', '#9a6440', '#c88a60'], k)); R(c, x + 9 + k * 5, 143, 5, 4, '#2c5a9e'); } R(c, x + 4, 106, 26, 8, '#1d3a70'); void n; }
    for (let k = 0; k < 12; k++) { const lx = 150 + k * 12; R(c, lx, 132, 11, 72, '#3c6aa8'); R(c, lx + 1, 134, 9, 30, '#4a7ab8'); R(c, lx + 1, 166, 9, 36, '#4a7ab8'); for (let j = 0; j < 3; j++) R(c, lx + 3, 137 + j * 3, 5, 1, '#2c5a9e'); R(c, lx + 8, 160, 2, 4, '#c8ccd0'); if (hash(k) > .6) R(c, lx + 2, 170, 6, 6, pick(['#f2c94c', '#e86a8a', '#7ac85a'], k)); }
    R(c, 380, 56, 120, 50, '#8a6a45'); R(c, 383, 59, 114, 44, '#c8a46a'); for (let k = 0; k < 10; k++) A.cartaz(c, 388 + (k % 5) * 22, 62 + Math.floor(k / 5) * 20, 30 + k);
    R(c, 520, 70, 90, 120, '#8a8478'); R(c, 522, 72, 86, 116, 'rgba(200,230,240,.55)'); for (let r = 0; r < 3; r++) { R(c, 522, 108 + r * 38, 86, 2, '#e8e4dc'); for (let k = 0; k < 4; k++) { const tx = 528 + k * 20, ty = 98 + r * 38; R(c, tx + 3, ty, 6, 8, '#c8a24a'); R(c, tx + 5, ty + 8, 2, 4, '#c8a24a'); R(c, tx + 2, ty + 12, 8, 3, '#8a6a3a'); R(c, tx + 3, ty, 2, 6, '#f2d898'); } } reflexo(c, 522, 72, 86, 116);
    R(c, 860, 160, 20, 44, '#c8ccd0'); R(c, 862, 160, 16, 6, '#e8eaec'); R(c, 868, 156, 4, 4, '#9aa0a6'); R(c, 840, 150, 8, 20, '#c43c3a'); R(c, 841, 146, 6, 4, '#2a2a2a');
    ell(c, 250, 48, 10, 10, '#2a2a2a'); ell(c, 250, 48, 8, 8, '#f6f8fa'); R(c, 250, 42, 1, 6, '#2a2a2a'); R(c, 250, 48, 5, 1, '#2a2a2a');
    R(c, 30, 46, 50, 16, '#2c5a9e'); R(c, 32, 48, 46, 12, '#3c6ab0');
    // poço da escada (fica por trás da parede da porta "ESCADA")
    const z0 = ESC.Z0, z1 = ESC.Z1; vgrad(c, z0, 24, z1 - z0, 186, '#cfd4d8', '#a8b0b6'); R(c, z1 - 50, 40, 40, 30, '#9fc4d0'); R(c, z1 - 48, 42, 36, 26, '#c8e0ea');
    for (let k = 0; k <= 70; k++) { const u = k / 70, sx = z0 + 10 + u * 140, sy = 210 - u * 120; R(c, sx, sy, 6, 6, '#b8bcc0'); R(c, sx, sy, 6, 1, '#e8eaec'); R(c, sx, sy + 5, 6, 1, '#7a8086'); }
    R(c, z0 + 150, 90, z1 - z0 - 150, 6, '#b8bcc0'); limb(c, [[z0 + 12, 186], [z0 + 152, 66], [z1, 66]], 2, '#2c5a9e'); for (let k = 0; k < 14; k++) { const u = k / 14; R(c, z0 + 12 + u * 140, 186 - u * 120, 1, 22, '#5a6066'); }
    tilesEscola(c, W);
    return cv;
  }
  function tilesEscola(c, W) { R(c, 0, 210, W, LH - 210, '#c8ccce'); for (let x = 0; x < W; x += 20) R(c, x, 210, 1, LH - 210, '#b4b8bc'); for (let y = 222; y < LH; y += 14) R(c, 0, y, W, 1, '#b4b8bc'); for (let x = 0; x < W; x += 40) R(c, x + 4, 214, 14, 2, 'rgba(255,255,255,.4)'); R(c, 0, 210, W, 2, '#8a9096'); }
  let escolaMid = null, PAREDE = null, revela = 0, revT = 0;
  function buildParede() { // a parede da escada com a porta: vira transparente quando Da Roça entra
    const [cv, c] = mk(ESC.Z1 - ESC.Z0, LH); paredeEscola(c, 0, ESC.Z1 - ESC.Z0); R(c, 0, 24, 2, 186, '#c8ccd0'); R(c, ESC.Z1 - ESC.Z0 - 2, 24, 2, 186, '#c8ccd0');
    porta(c, 14, 118, 34, 92, '#c47a35', { batente: '#c8ccd0', vidro: true }); R(c, 8, 100, 46, 12, '#3c8a5a'); R(c, 10, 102, 42, 8, '#4aa06a'); R(c, 12, 104, 6, 4, '#f2efe6');
    R(c, 70, 60, 100, 40, '#f2c94c'); R(c, 72, 62, 96, 36, '#f6dc7a'); return cv;
  }
  function escola(c, s, t, camL) {
    if (!escolaMid) escolaMid = buildEscola(); if (!PAREDE) PAREDE = buildParede();
    c.drawImage(escolaMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    const hx = HERO().x / 2, dentro = hx > ESC.Z0 + 6 && hx < ESC.Z1; const dt = Math.max(0, Math.min(.05, t - revT)); revT = t; revela = cl(revela + (dentro ? dt * 4 : -dt * 3));
    const x = ESC.Z0 - camL; if (vis(x, 200)) { c.save(); c.globalAlpha = 1 - revela * .88; c.drawImage(PAREDE, x, 0); c.restore(); if (revela > .02) { c.save(); c.globalAlpha = revela; R(c, x, 24, 2, 186, '#2c5a9e'); R(c, x + ESC.Z1 - ESC.Z0 - 2, 24, 2, 186, '#2c5a9e'); c.restore(); } }
    for (let i = 0; i < 9; i++) { const wx = 60 + i * 110 + Math.sin(t * .4 + i) * 30, sx = wx - camL; if (vis(sx, 20) && (wx < ESC.Z0 - 10 || wx > ESC.Z1 + 10)) { pessoa(c, sx, 216, i); R(c, sx - 1, 202, 7, 2, '#2c5a9e'); } }
  }
  function escolaLights(g, s, t, camL) { for (let x = 30; x < ESC.W; x += 90) { const sx = x + 25 - camL; if (vis(sx)) lightAdd(sx, 12, .3, 60); } }

  /* =====================================================================
     27 · PÁTIO NO 2º ANDAR DA ESCOLA (ao ar livre, com vista da cidade)
     ===================================================================== */
  const PT = { W: 1100 };
  function buildPatio() {
    const W = PT.W, [cv, c] = mk(W, LH);
    // mureta com guarda-corpo (a cidade aparece atrás)
    R(c, 0, 150, W, 56, '#e8e8e2'); R(c, 0, 150, W, 2, '#ffffff'); R(c, 0, 176, W, 6, '#2c5a9e'); for (let x = 0; x < W; x += 6) R(c, x, 128, 1, 22, '#5a6a7a'); R(c, 0, 126, W, 3, '#3c4c5c'); R(c, 0, 126, W, 1, '#7a8a9a');
    // cobertura metálica com treliça sobre a cantina e as mesas
    R(c, 0, 52, 620, 8, '#8a949a'); R(c, 0, 52, 620, 2, '#c8ccd0'); for (let x = 0; x < 620; x += 10) limb(c, [[x, 60], [x + 5, 68], [x + 10, 60]], 1, '#9aa4aa'); R(c, 0, 68, 620, 2, '#7a848a'); for (const x of [10, 200, 400, 600]) { R(c, x, 70, 6, 140, '#7a848a'); R(c, x, 70, 2, 140, '#a8b0b6'); }
    // cantina com balcão, cardápio e lanches
    plaster(c, 40, 92, 150, 114, '#f2e6c8', 270); R(c, 40, 92, 150, 12, '#c43c3a'); R(c, 40, 92, 150, 2, '#e86a6a'); R(c, 52, 110, 60, 34, '#2a2e34'); for (let k = 0; k < 5; k++) { R(c, 56, 114 + k * 6, 30, 2, '#f2efe6'); R(c, 90, 114 + k * 6, 16, 2, '#f2c94c'); }
    R(c, 120, 110, 60, 40, '#9fc4d0'); for (let k = 0; k < 6; k++) R(c, 124 + (k % 3) * 18, 118 + Math.floor(k / 3) * 14, 14, 10, pick(['#e8b85a', '#c4743a', '#f2efe6', '#e8433a'], k)); reflexo(c, 120, 110, 60, 40); pessoa(c, 150, 166, 3);
    vgrad(c, 44, 164, 142, 42, '#e2e6ea', '#8a9298'); R(c, 44, 164, 142, 2, '#f6f8fa'); R(c, 44, 170, 142, 3, '#c43c3a');
    // mesas com bancos, mural de mosaico, pingue-pongue, vasos e lixeiras de reciclagem
    for (let k = 0; k < 3; k++) { const tx = 230 + k * 120; R(c, tx, 186, 70, 6, '#9aa0a6'); R(c, tx, 186, 70, 1, '#c8ccd0'); R(c, tx + 10, 192, 6, 18, '#8a9096'); R(c, tx + 54, 192, 6, 18, '#8a9096'); R(c, tx - 4, 198, 78, 4, '#8a9096'); for (let j = 0; j < 3; j++) { R(c, tx + 8 + j * 22, 182, 8, 4, pick(['#f2efe6', '#e8c24c', '#c43c3a'], j + k)); } }
    R(c, 650, 90, 160, 116, '#f2f2ee'); for (let i = 0; i < 400; i++) R(c, 654 + (i % 38) * 4, 94 + Math.floor(i / 38) * 4, 3, 3, pick(['#e8433a', '#f2c94c', '#3c9ad8', '#7ac85a', '#c86ab8', '#f08a24', '#2c5a9e'], Math.floor(hash(i) * 7) + (i % 7 === 0 ? 1 : 0)));
    for (let k = 0; k < 6; k++) ell(c, 700 + k * 12, 140 + Math.sin(k) * 6, 6, 6, '#f6f2ea'); R(c, 690, 170, 80, 10, '#2c5a9e');
    R(c, 850, 182, 90, 6, '#2c7a4a'); R(c, 850, 182, 90, 1, '#4aa06a'); R(c, 894, 176, 2, 6, '#f2f2ee'); R(c, 856, 188, 4, 22, '#5a6066'); R(c, 930, 188, 4, 22, '#5a6066'); for (let x = 850; x < 940; x += 2) R(c, x, 177 + (x % 4 ? 0 : 1), 1, 5, '#e8eaec');
    for (const [x, col] of [[970, '#2c5a9e'], [986, '#e8c24c'], [1002, '#c43c3a'], [1018, '#3c8a5a']]) { R(c, x, 186, 14, 20, col); R(c, x, 186, 14, 2, shadeHex(col, 1.3)); }
    for (const x of [212, 612, 820, 1060]) { R(c, x, 190, 16, 20, '#8a8478'); for (let k = 0; k < 7; k++) ell(c, x + 3 + k * 2, 182 - (k % 3) * 5, 4, 5, k % 2 ? '#4f8a3a' : '#5f9a46'); }
    R(c, 1040, 70, 4, 140, '#c43c3a'); R(c, 1026, 70, 30, 20, '#f2f2ee'); R(c, 1034, 86, 14, 4, '#e86a3a'); limb(c, [[1036, 90], [1046, 104]], 1, '#f2f2ee');
    // porta da escada que desce
    R(c, 6, 106, 48, 104, '#dfe2e4'); porta(c, 12, 118, 34, 92, '#c47a35', { batente: '#c8ccd0', vidro: true }); R(c, 8, 100, 44, 10, '#3c8a5a');
    tilesEscola(c, W); for (let x = 0; x < W; x += 3) if (hash(x) > .7) R(c, x, 212 + hash(x * 3) * 50, 2, 1, 'rgba(255,255,255,.3)');
    return cv;
  }
  let patioMid = null;
  function patio(c, s, t, camL) {
    if (!patioMid) patioMid = buildPatio();
    conquistaBack(c, s, t, camL, { seed: 27, kites: true });
    c.drawImage(patioMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    { const bx = 895 + Math.sin(t * 3) * 40 - camL, by = 172 - Math.abs(Math.sin(t * 6)) * 14; if (vis(bx, 10)) R(c, bx, by, 2, 2, '#f6f2ea'); for (const k of [0, 1]) { const px = 862 + k * 70 - camL; if (vis(px, 20)) pessoa(c, px, 216, k + 4); } }
    for (let i = 0; i < 12; i++) { const wx = 220 + (i % 6) * 60 + Math.sin(t * .5 + i) * (i > 5 ? 50 : 2), sx = wx - camL; if (vis(sx, 20)) { pessoa(c, sx, i > 5 ? 216 : 202, i); R(c, sx - 1, (i > 5 ? 216 : 202) - 14, 7, 2, '#2c5a9e'); } }
    { const x = 1040 - camL + Math.sin(t * 1.3) * 12, y = 120 - Math.abs(Math.sin(t * 2.6)) * 30; if (vis(x, 20)) { ell(c, x, y, 4, 4, '#e8833a'); R(c, x - 1, y - 1, 2, 2, '#2a2a2a'); } }
  }
  function patioLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (const x of [100, 300, 500]) lampGlow(g, x - camL, 70, a); }

  /* ---------- registro das cenas ---------- */
  function LW() { return 482; }
  const indoor = (k) => (s) => A.mix(s.amb, [1, 1, 1], k);
  const REG = window.CampanhaCenarios.registrar;
  REG({ id: 22, key: 'frente-shopping', nome: 'Frente do Shopping', lugar: 'Estacionamento e entrada do Shopping Conquista', grupo: 'ambiente', width: FR.W * 2, draw: frente, lights: frenteLights, plat: (c, x, y, w, t) => window.CampanhaCenarios.plataforma(c, 16, [x, y, w], t),
    labels: [[FR.ENT, 43, 'SHOPPING CONQUISTA', 12, '#ffffff'], [405, 121, 'AMENICANAS', 9, '#ffffff'], [955, 121, 'RIACHORRO', 9, '#ffffff'], [1160, 46, 'SHOPPING', 5, '#ffffff'], [241, 152, 'E', 8, '#2c5aa8'], [FR.ENT, 132, 'ENTRADA', 6, '#2c4656'], [600, 170, 'EM CARTAZ', 5, '#f2c94c']],
    interact: [['trash', 2220], ['pot', 900], ['cone', 640], ['cone', 700], ['crate', 2400], ['ball', 1700], ['puddle', 2000, 70]] }, { platforms: [[300, 384, 150], [490, 328, 140], [1800, 384, 150], [1990, 328, 140]], gaps: [] });
  REG({ id: 23, key: 'shopping-piso2', nome: 'Shopping · piso 2', lugar: 'Lojas do segundo andar', grupo: 'ambiente', width: P2.W * 2, draw: piso2, lights: piso2Lights, amb: indoor(.8), plat: (c, x, y, w, t, sd) => window.CampanhaCenarios.plataforma(c, 20, [x, y, w], t),
    labels: LOJAS2.map(([n], i) => [200 + i * 150 + 77, SHOP.TOP + 10, n, n.length > 12 ? 5 : 7, '#f6f2ea']).concat([[110, 150, 'DESCE ↓', 6, '#5a6a72']]),
    interact: [['pot', 600], ['pot', 3000], ['trash', 1500], ['trash', 2600], ['crate', 3100], ['ball', 2000]] }, { platforms: [[800, 384, 150], [990, 328, 140], [2300, 384, 150], [2490, 328, 140]], gaps: [] });
  REG({ id: 24, key: 'corredor-pensao', nome: 'Corredor da pensão', lugar: 'Pensão de Dona Lurdes · corredor dos quartos', grupo: 'ambiente', width: COR.W * 2, draw: corredor, lights: corredorLights, amb: indoor(.55),
    labels: [[137, 124, '1', 5, '#5a3a20'], [247, 124, '2', 5, '#5a3a20'], [357, 124, '3', 5, '#5a3a20'], [COR.QUARTO + 17, 124, '4', 5, '#5a3a20'], [577, 124, '5', 5, '#5a3a20'], [293, 141, 'CADÊ MEU RÁDIO?', 3, '#c43c3a'], [293, 168, '— LURDES', 3, '#5a5a5a']],
    interact: [['pot', 150], ['bucket', 820]] }, { platforms: [], gaps: [] });
  REG({ id: 25, key: 'quarto', nome: 'Quarto do Da Roça', lugar: 'Pensão de Dona Lurdes · quarto 4', grupo: 'ambiente', width: QT.W * 2, draw: quarto, lights: quartoLights, amb: indoor(.6),
    labels: [[QT.PC, 122, 'FLIPERAMA', 4, '#f2efe6'], [215, 42, 'CONQUISTA', 3, '#2c3a5a']],
    interact: [] }, { platforms: [], gaps: [] });
  REG({ id: 26, key: 'escola-terreo', nome: 'Escola SESI · térreo', lugar: 'Corredor das salas e a escada para o pátio', grupo: 'ambiente', width: ESC.W * 2, draw: escola, lights: escolaLights, amb: indoor(.8),
    labels: [[55, 54, 'BEM-VINDO AO SESI', 4, '#f2efe6'], [107, 110, '1º A', 4, '#f2efe6'], [317, 110, '2º B', 4, '#f2efe6'], [917, 110, 'LAB', 4, '#f2efe6'], [ESC.Z0 + 31, 106, 'ESCADA', 4, '#f2efe6'], [ESC.Z0 + 120, 80, 'PÁTIO NO 2º ANDAR ↑', 5, '#5a4a10'], [440, 50, 'MURAL', 5, '#5a3a20'], [565, 64, 'TROFÉUS', 5, '#5a5a5a']],
    interact: [['trash', 700], ['ball', 1000], ['pot', 1900]] }, { platforms: [], gaps: [] });
  REG({ id: 27, key: 'patio', nome: 'Pátio · 2º andar', lugar: 'Pátio da Escola SESI, com vista da cidade', grupo: 'ambiente', width: PT.W * 2, draw: patio, lights: patioLights, plat: (c, x, y, w, t) => window.CampanhaCenarios.plataforma(c, 21, [x, y, w], t),
    labels: [[115, 98, 'CANTINA', 7, '#ffffff'], [730, 176, 'GRÊMIO ESTUDANTIL', 5, '#ffffff'], [30, 105, '↓ ESCADA', 4, '#ffffff']],
    interact: [['ball', 1400], ['ball', 1460], ['trash', 1900], ['pot', 1240], ['cone', 1600]] }, { platforms: [[1300, 384, 150], [1490, 328, 140], [1680, 272, 140]], gaps: [] });

  /* ---------- passagens entre as cenas ----------
     tipo: 'porta' (botão ENTRAR/SAIR), 'rolante' (sobe/desce de escada rolante), 'pc' (abre o Fliperama),
     'rampa' (escada que se sobe andando; no alto troca de cena). x e y em pixels do mundo. */
  const PORTAIS = [
    { cena: 22, x: FR.ENT * 2, tipo: 'porta', rotulo: 'ENTRAR NO SHOPPING', para: { cena: 20, x: 180 } },
    { cena: 20, x: 90, tipo: 'porta', rotulo: 'SAIR DO SHOPPING', para: { cena: 22, x: FR.ENT * 2 } },
    { cena: 20, x: SHOP.ESC * 2 + 20, tipo: 'rolante', rotulo: 'SUBIR A ESCADA ROLANTE', de: [SHOP.ESC * 2 + 12, 420], ate: [SHOP.ESC * 2 + 224, 192], para: { cena: 23, x: (P2.ESC + 150) * 2 } },
    { cena: 23, x: (P2.ESC + 130) * 2, tipo: 'rolante', rotulo: 'DESCER A ESCADA ROLANTE', de: [(P2.ESC + 124) * 2, 440], ate: [(P2.ESC + 20) * 2, 540], para: { cena: 20, x: SHOP.ESC * 2 - 30 } },
    { cena: 13, x: (780 + 144) * 2, tipo: 'porta', rotulo: 'ENTRAR NA PENSÃO', para: { cena: 24, x: 120 } },
    { cena: 24, x: 76, tipo: 'porta', rotulo: 'SAIR PARA A RUA', para: { cena: 13, x: (780 + 144) * 2 } },
    { cena: 24, x: (COR.QUARTO + 17) * 2, tipo: 'porta', rotulo: 'ENTRAR NO QUARTO 4', para: { cena: 25, x: 130 } },
    { cena: 25, x: 78, tipo: 'porta', rotulo: 'SAIR PARA O CORREDOR', para: { cena: 24, x: (COR.QUARTO + 17) * 2 } },
    { cena: 25, x: QT.PC * 2, tipo: 'pc', rotulo: 'USAR O COMPUTADOR (FLIPERAMA)' },
    { cena: 21, x: (1250 + 720) * 2, tipo: 'porta', rotulo: 'ENTRAR NA ESCOLA', para: { cena: 26, x: 120 } },
    { cena: 26, x: 70, tipo: 'porta', rotulo: 'SAIR DA ESCOLA', para: { cena: 21, x: (1250 + 720) * 2 } },
    { cena: 26, tipo: 'rampa', x0: RAMPA.x0, y0: RAMPA.y0, x1: RAMPA.x1, y1: RAMPA.y1, para: { cena: 27, x: 130 } },
    { cena: 27, x: 58, tipo: 'porta', rotulo: 'DESCER A ESCADA', para: { cena: 26, x: RAMPA.x0 - 50 } }
  ];
  window.CampanhaAmbientes = Object.freeze({ portais: (cena) => PORTAIS.filter((p) => p.cena === cena), todos: () => PORTAIS.slice(), rampa: RAMPA });
})();
