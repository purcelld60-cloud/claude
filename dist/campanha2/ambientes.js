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
     INTERIOR ESTILO TERRARIA: recorte no meio da tela, borda preta, blocos de 8 px
     ===================================================================== */
  const BL = 8;
  function bloco(c, x, y, base, o = {}) { // um bloco com contorno, luz em cima e textura
    R(c, x, y, BL, BL, base); R(c, x, y, BL, 1, shadeHex(base, 1.25)); R(c, x, y, 1, BL, shadeHex(base, 1.12)); R(c, x, y + BL - 1, BL, 1, shadeHex(base, .62)); R(c, x + BL - 1, y, 1, BL, shadeHex(base, .7));
    const s = Math.floor(x * 7 + y * 13); if (o.tex !== false) { R(c, x + 2 + (s % 3), y + 2 + (s % 4), 1, 1, shadeHex(base, .82)); R(c, x + 5 - (s % 2), y + 5 - (s % 3), 1, 1, shadeHex(base, 1.1)); }
    if (o.tabua) { R(c, x, y + 3, BL, 1, shadeHex(base, .78)); R(c, x + (s % 2 ? 2 : 5), y, 1, 3, shadeHex(base, .78)); R(c, x + (s % 2 ? 5 : 2), y + 4, 1, 4, shadeHex(base, .78)); }
    if (o.pedra) { R(c, x + 3, y + 2, 2, 1, shadeHex(base, .75)); R(c, x + 1, y + 5, 3, 1, shadeHex(base, .78)); }
  }
  function caixaInterior(c, b, o) { // moldura de blocos (teto, paredes, chão) com fundo preto em volta
    c.fillStyle = '#000'; c.fillRect(0, 0, 482, LH);
    for (let x = b.x0 - BL; x < b.x1 + BL; x += BL) { bloco(c, x, b.top - BL, o.teto, { pedra: true }); bloco(c, x, b.top - BL * 2, shadeHex(o.teto, .8), { pedra: true }); }
    for (let y = b.top - BL * 2; y < b.floor + BL * 2; y += BL) { bloco(c, b.x0 - BL, y, o.lado, { pedra: true }); bloco(c, b.x1, y, o.lado, { pedra: true }); }
    for (let x = b.x0 - BL; x < b.x1 + BL; x += BL) { bloco(c, x, b.floor, o.chao, { tabua: true }); bloco(c, x, b.floor + BL, shadeHex(o.lado, .85), { pedra: true }); }
    // cantos irregulares (fica com cara de bloco escavado)
    for (const [x, y] of [[b.x0 - BL * 2, b.top - BL], [b.x1 + BL, b.top], [b.x0 - BL * 2, b.floor], [b.x1 + BL, b.floor + BL]]) bloco(c, x, y, shadeHex(o.lado, .75), { pedra: true });
  }
  function papelParede(c, x0, y0, x1, y1, a, b2, flor) { for (let y = y0; y < y1; y += BL) for (let x = x0; x < x1; x += BL) { R(c, x, y, BL, BL, ((x + y) / BL) % 2 ? a : b2); if (flor && ((x / BL) + (y / BL)) % 3 === 0) { R(c, x + 3, y + 3, 2, 2, flor); R(c, x + 3, y + 5, 1, 2, '#5a7a3a'); } R(c, x, y, BL, 1, 'rgba(0,0,0,.05)'); } }
  function tabuado(c, x0, y0, x1, y1, base) { for (let y = y0; y < y1; y += 4) { R(c, x0, y, x1 - x0, 4, (y / 4) % 2 ? base : shadeHex(base, .92)); R(c, x0, y + 3, x1 - x0, 1, shadeHex(base, .72)); for (let x = x0 + ((y / 4) % 3) * 9; x < x1; x += 26) R(c, x, y, 1, 3, shadeHex(base, .72)); } }
  function portaT(c, x, chao, cor, o = {}) { // porta estilo Terraria: 3 blocos de altura
    const y = chao - 40; R(c, x - 1, y - 2, 18, 42, '#3a2414'); R(c, x, y, 16, 40, cor); R(c, x, y, 16, 1, shadeHex(cor, 1.3)); R(c, x + 15, y, 1, 40, shadeHex(cor, .65));
    for (const yy of [y + 4, y + 22]) { R(c, x + 3, yy, 10, 14, shadeHex(cor, .85)); R(c, x + 3, yy, 10, 1, shadeHex(cor, .65)); R(c, x + 3, yy + 13, 10, 1, shadeHex(cor, 1.15)); }
    if (o.vidro) { R(c, x + 4, y + 5, 8, 10, '#9fc4d0'); R(c, x + 5, y + 6, 2, 8, '#d8eef4'); }
    R(c, x + 12, y + 20, 2, 3, '#e8c24c'); if (o.num) { R(c, x + 5, y - 7, 6, 5, '#c8a24a'); R(c, x + 6, y - 6, 4, 3, '#f6e8b8'); }
  }
  function tocha(c, x, y) { R(c, x, y, 2, 6, '#6a4428'); R(c, x - 1, y - 3, 4, 3, '#f2a83a'); R(c, x, y - 5, 2, 2, '#ffe39a'); }

  /* =====================================================================
     24 · CORREDOR DA PENSÃO (recorte estilo Terraria)
     ===================================================================== */
  const COR = { W: 480, x0: 40, x1: 440, top: 112, floor: 220, Q: [[82, '1'], [154, '2'], [254, '3'], [326, '4'], [398, '5']], ENT: 48 };
  function buildCorredor() {
    const [cv, c] = mk(COR.W, LH), b = COR;
    caixaInterior(c, b, { teto: '#7a6a5a', lado: '#6a6a72', chao: '#8a5a32' });
    papelParede(c, b.x0, b.top, b.x1, 172, '#e8d4b0', '#e2cca6', '#c45a5a'); R(c, b.x0, 172, b.x1 - b.x0, 3, '#7a4a2a'); R(c, b.x0, 172, b.x1 - b.x0, 1, '#b07a4a');
    tabuado(c, b.x0, 175, b.x1, b.floor, '#8a5a34'); R(c, b.x0, b.floor - 3, b.x1 - b.x0, 3, '#4a2e18');
    for (let x = b.x0; x < b.x1; x += 2) if (hash(x * 1.7) > .8) R(c, x, b.top + hash(x) * 50, 1, 2, 'rgba(110,80,40,.12)'); // manchinhas no papel
    // vigas de madeira no teto e lustres de lamparina
    for (let x = b.x0 + 30; x < b.x1; x += 80) { R(c, x, b.top, 6, 6, '#5a3a20'); R(c, x, b.top, 6, 1, '#8a5a34'); }
    for (const x of [120, 240, 360]) { R(c, x, b.top, 1, 10, '#3a3a3a'); R(c, x - 6, b.top + 10, 13, 2, '#c8a24a'); for (const dx of [-5, 0, 5]) { R(c, x + dx, b.top + 7, 1, 3, '#c8a24a'); R(c, x + dx - 1, b.top + 5, 3, 2, '#fff2c8'); } }
    // portas: entrada (com vidro e a neblina lá fora) e os quartos 1 a 5
    portaT(c, b.ENT, b.floor, '#6a3c24', { vidro: true });
    for (const [x, n] of b.Q) { portaT(c, x, b.floor, n === '4' ? '#8a4a2a' : '#7a5232', { num: true }); R(c, x - 2, b.floor - 2, 20, 2, n === '4' ? '#b83a3a' : '#5a6a3a'); }
    // entre as portas: tochas, quadros, cabideiro, mesinha com o bilhete do rádio, relógio de pêndulo, estante, baú e vaso
    for (const x of [72, 112, 144, 184, 244, 284, 316, 352, 388]) tocha(c, x, 150);
    quadro(c, 116, 128, 20, 14, 'cristo', 1); quadro(c, 196, 126, 24, 16, 'catedral', 2); quadro(c, 360, 128, 18, 14, 'cacau', 4);
    R(c, 110, 178, 2, 42, '#5a3a20'); R(c, 106, 178, 10, 2, '#5a3a20'); R(c, 105, 180, 5, 16, '#3a4a6a'); R(c, 111, 180, 5, 14, '#8a2a2a'); limb(c, [[108, 181], [110, 196]], 1, '#e8c24c'); R(c, 120, 212, 8, 8, '#4a5a6a'); limb(c, [[122, 212], [121, 202]], 1, '#c43c3a');
    R(c, 200, 196, 30, 3, '#7a4a2a'); R(c, 201, 199, 2, 21, '#5a3a20'); R(c, 227, 199, 2, 21, '#5a3a20'); R(c, 201, 208, 28, 2, '#5a3a20'); R(c, 205, 190, 20, 6, 'rgba(0,0,0,.15)'); R(c, 207, 188, 14, 8, '#f6f2e8'); R(c, 208, 190, 12, 1, '#c43c3a'); R(c, 208, 192, 9, 1, '#5a5a5a');
    R(c, 278, 168, 14, 52, '#5a3420'); R(c, 279, 169, 12, 50, '#7a4a2a'); ell(c, 285, 178, 5, 5, '#c8a24a'); ell(c, 285, 178, 4, 4, '#f6f2ea'); R(c, 285, 175, 1, 3, '#2a2a2a'); R(c, 281, 190, 8, 22, '#3a2414'); R(c, 284, 194, 2, 12, '#c8a24a'); ell(c, 285, 206, 2, 2, '#e8c24c');
    R(c, 344, 186, 22, 34, '#6a4428'); for (let k = 0; k < 3; k++) { R(c, 345, 188 + k * 11, 20, 1, '#4a2e18'); for (let j = 0; j < 6; j++) R(c, 346 + j * 3, 190 + k * 11, 2, 8, pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#3c8a5a'], j + k)); }
    R(c, 424, 208, 15, 12, '#8a5a32'); R(c, 424, 208, 15, 2, '#c8a24a'); R(c, 424, 213, 15, 1, '#5a3a20'); R(c, 430, 211, 2, 3, '#e8c24c');
    R(c, 416, 204, 7, 16, '#8a8478'); for (let k = 0; k < 6; k++) ell(c, 418 + k * 1.2, 199 - (k % 3) * 4, 3, 4, k % 2 ? '#3f7a3c' : '#5f9a46');
    // janelinha no fim do corredor
    R(c, 412, 130, 20, 20, '#5a3a20'); vgrad(c, 414, 132, 16, 16, '#c8d4dc', '#e2e6e8'); R(c, 421, 132, 1, 16, '#5a3a20'); R(c, 414, 139, 16, 1, '#5a3a20');
    // tapete vermelho no chão
    for (let x = b.x0 + 4; x < b.x1 - 4; x += 2) R(c, x, b.floor + 1, 2, 3, hash(x) > .5 ? '#9a2a2a' : '#8a2424'); R(c, b.x0 + 4, b.floor + 1, b.x1 - b.x0 - 8, 1, '#c8a24a');
    return cv;
  }
  let corMid = null;
  function corredor(c, s, t, camL) {
    if (!corMid) corMid = buildCorredor(); c.drawImage(corMid, 0, 0);
    for (const x of [72, 112, 144, 184, 244, 284, 316, 352, 388]) { const f = Math.floor(t * 9 + x) % 3; R(c, x - 1, 147 - (f === 1 ? 1 : 0), 4, 3, f === 2 ? '#ffb04a' : '#f2a83a'); R(c, x, 145 - f, 2, 2, '#fff2b0'); }
    { const sw = Math.sin(t * 2) * 3; limb(c, [[285, 192], [285 + sw, 204]], 1, '#c8a24a'); ell(c, 285 + sw, 205, 2, 2, '#e8c24c'); }
    { const br = Math.round(Math.sin(t * 1.4)); R(c, 236, 214 + br, 10, 5, '#d8a24a'); R(c, 243, 211 + br, 5, 4, '#d8a24a'); R(c, 244, 210, 1, 1, '#d8a24a'); R(c, 247, 210, 1, 1, '#d8a24a'); }
    for (let k = 0; k < 3; k++) ell(c, 418 + ((t * 5 + k * 6) % 12), 136 + k * 4, 3, 2, 'rgba(255,255,255,.4)');
  }
  function corredorLights(g, s, t, camL) { g.save(); g.beginPath(); g.rect(COR.x0, COR.top, COR.x1 - COR.x0, COR.floor - COR.top); g.clip(); for (const x of [72, 112, 144, 184, 244, 284, 316, 352, 388]) { const fl = .24 + Math.sin(t * 11 + x) * .04, gr = g.createRadialGradient(x + 1, 146, 1, x + 1, 146, 22); gr.addColorStop(0, `rgba(255,190,110,${fl})`); gr.addColorStop(1, 'rgba(255,190,110,0)'); g.fillStyle = gr; g.fillRect(x - 26, 120, 54, 54); lightAdd(x, 146, .3, 30); } for (const x of [120, 240, 360]) { const gr = g.createRadialGradient(x, 122, 2, x, 122, 34); gr.addColorStop(0, 'rgba(255,230,170,.2)'); gr.addColorStop(1, 'rgba(255,230,170,0)'); g.fillStyle = gr; g.fillRect(x - 34, COR.top, 68, 50); } g.restore(); }

  /* =====================================================================
     25 · QUARTO DO DA ROÇA (pequeno, estilo Terraria): cama, lamparina, janela,
     mesa com computador (abre o Fliperama) e armário (personalizar a roupa)
     ===================================================================== */
  const QT = { W: 480, x0: 150, x1: 330, top: 130, floor: 220, ARM: 187, PC: 230 };
  function buildQuarto() {
    const [cv, c] = mk(QT.W, LH), b = QT;
    caixaInterior(c, b, { teto: '#7a6a5a', lado: '#6a6a72', chao: '#8a5a32' });
    tabuado(c, b.x0, b.top, b.x1, b.floor, '#9a6a40'); for (let x = b.x0 + 22; x < b.x1; x += 44) { R(c, x, b.top, 4, b.floor - b.top, '#6a4428'); R(c, x, b.top, 1, b.floor - b.top, '#8a5a34'); }
    R(c, b.x0, b.floor - 3, b.x1 - b.x0, 3, '#4a2e18');
    portaT(c, b.x0 + 2, b.floor, '#7a4a2a');
    // armário de duas portas (personalização)
    const ax = QT.ARM - 12; R(c, ax - 1, b.floor - 47, 26, 47, '#3a2414'); R(c, ax, b.floor - 46, 24, 46, '#7a4e2e'); R(c, ax, b.floor - 46, 24, 1, '#a8784a'); R(c, ax + 11, b.floor - 44, 2, 42, '#4a2e18');
    for (const dx of [1, 13]) { R(c, ax + dx + 1, b.floor - 42, 9, 18, '#8a5a36'); R(c, ax + dx + 1, b.floor - 22, 9, 18, '#8a5a36'); R(c, ax + dx + 1, b.floor - 42, 9, 1, '#6a3e22'); } R(c, ax + 9, b.floor - 26, 2, 4, '#e8c24c'); R(c, ax + 14, b.floor - 26, 2, 4, '#e8c24c'); R(c, ax + 2, b.floor - 52, 8, 6, '#3c6aa8'); R(c, ax + 12, b.floor - 50, 9, 4, '#c47a35');
    // mesa com computador e cadeira
    const mx = QT.PC; R(c, mx - 20, b.floor - 20, 40, 3, '#6a4428'); R(c, mx - 20, b.floor - 20, 40, 1, '#9a6a42'); R(c, mx - 18, b.floor - 17, 3, 17, '#5a3a20'); R(c, mx + 15, b.floor - 17, 3, 17, '#5a3a20'); R(c, mx + 4, b.floor - 17, 11, 9, '#7a4e2e'); R(c, mx + 8, b.floor - 13, 3, 1, '#c8a24a');
    R(c, mx - 15, b.floor - 37, 24, 15, '#14161c'); R(c, mx - 4, b.floor - 22, 3, 2, '#2a2c34'); R(c, mx - 14, b.floor - 36, 22, 13, '#1e2236'); R(c, mx + 11, b.floor - 34, 7, 14, '#1c1e24'); R(c, mx + 12, b.floor - 33, 5, 12, '#2a2c36'); R(c, mx - 13, b.floor - 22, 16, 2, '#2a2a30'); R(c, mx + 4, b.floor - 22, 3, 2, '#2a2a30');
    R(c, mx - 30, b.floor - 16, 9, 10, '#c43c3a'); R(c, mx - 30, b.floor - 24, 3, 10, '#c43c3a'); R(c, mx - 26, b.floor - 6, 2, 6, '#3a3a3a'); R(c, mx - 30, b.floor - 1, 10, 1, '#3a3a3a');
    // janela com neblina, o Cristo lá longe e cortinas
    const jx = 264; R(c, jx - 1, 145, 30, 28, '#5a3a20'); vgrad(c, jx + 1, 147, 26, 24, '#b8c8d4', '#e2e6e8'); R(c, jx + 1, 163, 26, 8, '#a8b8c0'); for (let k = 0; k < 6; k++) R(c, jx + 2 + k * 4, 158 + (k % 3), 3, 13, '#c0ccd2'); R(c, jx + 18, 150, 1, 8, '#6a7476'); R(c, jx + 16, 152, 5, 1, '#6a7476');
    R(c, jx + 13, 147, 2, 24, '#5a3a20'); R(c, jx + 1, 158, 26, 2, '#5a3a20'); R(c, jx - 5, 143, 6, 32, '#7a4a9a'); R(c, jx + 27, 143, 6, 32, '#7a4a9a'); R(c, jx - 6, 142, 40, 2, '#3a2414'); R(c, jx - 2, 173, 32, 3, '#c8a46a');
    // cama estilo Terraria: cabeceira alta, colchão, travesseiro e cobertor xadrez
    const bx = 296, f = b.floor; R(c, bx + 28, f - 26, 4, 26, '#5a3a20'); R(c, bx + 28, f - 26, 4, 1, '#9a6a42'); R(c, bx + 27, f - 27, 6, 2, '#7a4e2e'); R(c, bx, f - 16, 3, 16, '#5a3a20'); R(c, bx, f - 16, 3, 1, '#9a6a42');
    R(c, bx + 3, f - 6, 25, 4, '#6a4428'); R(c, bx + 3, f - 6, 25, 1, '#8a5a34'); R(c, bx + 4, f - 2, 2, 2, '#4a2e18'); R(c, bx + 25, f - 2, 2, 2, '#4a2e18');
    R(c, bx + 3, f - 10, 25, 4, '#efe8d8'); R(c, bx + 3, f - 10, 25, 1, '#ffffff'); R(c, bx + 20, f - 14, 8, 5, '#f6f2ea'); R(c, bx + 20, f - 14, 8, 1, '#ffffff'); R(c, bx + 20, f - 10, 8, 1, '#c8c0b0');
    for (let x = 0; x < 18; x++) for (let y = 0; y < 6; y++) R(c, bx + 3 + x, f - 12 + y, 1, 1, ((x >> 1) + (y >> 1)) % 2 ? '#b83a3a' : '#8a2424'); R(c, bx + 3, f - 12, 18, 1, '#d85a4a'); R(c, bx + 3, f - 7, 18, 1, '#6a1a1a'); for (let x = 0; x < 18; x += 3) R(c, bx + 4 + x, f - 12, 1, 6, '#e8c24c');
    // lamparina num banquinho do lado da cama
    R(c, 284, b.floor - 10, 9, 2, '#6a4428'); R(c, 285, b.floor - 8, 2, 8, '#5a3a20'); R(c, 290, b.floor - 8, 2, 8, '#5a3a20'); R(c, 286, b.floor - 18, 6, 8, '#3a3a3a'); R(c, 287, b.floor - 17, 4, 6, '#f6c86a'); R(c, 287, b.floor - 20, 4, 2, '#3a3a3a'); R(c, 288, b.floor - 22, 2, 2, '#3a3a3a');
    return cv;
  }
  let quartoMid = null;
  function quarto(c, s, t, camL) {
    if (!quartoMid) quartoMid = buildQuarto(); c.drawImage(quartoMid, 0, 0); const b = QT;
    { const x = QT.PC - 14, tela = ['#3c8ae0', '#e05a8a', '#5ae070', '#f2c94c'][Math.floor(t / 2) % 4]; vgrad(c, x, b.floor - 36, 22, 13, tela, '#1e2236'); R(c, x + 3, b.floor - 34, 16, 2, '#f2efe6'); for (let k = 0; k < 3; k++) R(c, x + 3 + k * 6, b.floor - 30, 4, 4, pick(['#e8433a', '#f2c94c', '#5ae0d0'], k + Math.floor(t))); R(c, QT.PC + 13, b.floor - 31, 3, 1, Math.sin(t * 3) > 0 ? '#e05a8a' : '#5ae0d0'); }
    { const f = .8 + Math.sin(t * 13) * .1 + Math.sin(t * 7) * .1; R(c, 287, b.floor - 17, 4, 6, f > .85 ? '#ffe39a' : '#f6c86a'); R(c, 288, b.floor - 16 - (f > .9 ? 1 : 0), 2, 3, '#fff6d0'); }
    { const nt = night(s); if (nt > .02) { c.save(); c.globalAlpha = nt; vgrad(c, 265, 147, 26, 24, '#0e1630', '#24305a'); for (let k = 0; k < 6; k++) R(c, 267 + hash(k * 3.1) * 22, 149 + hash(k * 5.3) * 10, 1, 1, Math.sin(t * 2 + k) > -.3 ? '#f6f2ea' : '#8a90a8'); ell(c, 284, 152, 2.5, 2.5, '#f6f2d8'); for (let k = 0; k < 5; k++) R(c, 268 + k * 5, 164 + (k % 2) * 2, 1, 1, '#f2c94c'); R(c, 277, 147, 2, 24, '#5a3a20'); R(c, 265, 158, 26, 2, '#5a3a20'); c.restore(); } } // à noite: céu escuro e luzinhas da cidade
    for (let k = 0; k < 3; k++) R(c, 265 + ((t * 4 + k * 9) % 24), 150 + k * 6, 4, 1, 'rgba(255,255,255,.4)');
  }
  function quartoLights(g, s, t, camL) { const b = QT; g.save(); g.beginPath(); g.rect(b.x0, b.top, b.x1 - b.x0, b.floor - b.top); g.clip(); const f = .55 + Math.sin(t * 13) * .05 + Math.sin(t * 7) * .04, gl = g.createRadialGradient(289, b.floor - 14, 2, 291, b.floor - 14, 60); gl.addColorStop(0, `rgba(255,190,110,${f})`); gl.addColorStop(1, 'rgba(255,190,110,0)'); g.fillStyle = gl; g.fillRect(228, b.top, 102, b.floor - b.top); const gp = g.createRadialGradient(QT.PC - 3, b.floor - 30, 2, QT.PC - 3, b.floor - 30, 40); gp.addColorStop(0, 'rgba(120,170,255,.35)'); gp.addColorStop(1, 'rgba(120,170,255,0)'); g.fillStyle = gp; g.fillRect(QT.PC - 45, b.top, 90, b.floor - b.top); g.restore(); lightAdd(289, b.floor - 14, .6, 50); lightAdd(QT.PC, b.floor - 30, .4, 40); }

  /* =====================================================================
     26 · ESCOLA SESI POR DENTRO (ao entrar na sala da escada, o resto fica preto)
     ===================================================================== */
  const ESC = { W: 1000, Z0: 640, Z1: 830 };
  const RAMPA = { x0: 1300, y0: 440, x1: 1580, y1: 200 };
  function paredeEscola(c, x, w) {
    R(c, x, 24, w, 96, '#f4f4f0'); for (let y = 30; y < 120; y += 12) R(c, x, y, w, 1, 'rgba(160,170,180,.10)'); for (let i = 0; i < w * 2; i++) R(c, x + hash(i * 1.1 + x) * w, 24 + hash(i * 2.3 + x) * 96, 1, 1, 'rgba(120,130,140,.07)');
    R(c, x, 120, w, 8, '#2c5a9e'); R(c, x, 120, w, 1, '#5a8ad8'); R(c, x, 127, w, 1, '#1d3a70');
    for (let y = 128; y < 204; y += 8) for (let xx = x + ((y / 8) % 2) * 6; xx < x + w; xx += 12) { R(c, xx, y, 12, 8, '#e2e5e8'); R(c, xx, y, 12, 1, '#eef0f2'); R(c, xx, y, 1, 8, '#c8ccd0'); } // azulejo da parte de baixo
    R(c, x, 204, w, 6, '#7a848c'); R(c, x, 204, w, 1, '#a8b0b6');
  }
  function janelaEscola(c, x, y, w, h) { R(c, x - 2, y - 2, w + 4, h + 4, '#c8ccd0'); vgrad(c, x, y, w, h, '#8ec4e8', '#d8ecf4'); ell(c, x + w * .3, y + h * .35, 8, 3, '#ffffff'); for (let k = 0; k < 5; k++) R(c, x + 2 + k * (w / 5), y + h - 8 - (k % 2) * 6, w / 6, 8 + (k % 2) * 6, '#e8e4d8'); R(c, x + w / 2 - 1, y, 2, h, '#c8ccd0'); R(c, x, y + h / 2, w, 2, '#c8ccd0'); reflexo(c, x, y, w, h); R(c, x - 3, y + h + 2, w + 6, 3, '#e8eaec'); }
  function buildEscola() {
    const W = ESC.W, [cv, c] = mk(W, LH);
    vgrad(c, 0, 0, W, 22, '#e8eaec', '#c8ccd0'); R(c, 0, 22, W, 2, '#9aa0a6'); for (let x = 0; x < W; x += 30) R(c, x, 0, 1, 22, '#d8dce0');
    for (let x = 30; x < W; x += 90) { R(c, x, 8, 50, 6, '#c8ccd0'); R(c, x + 2, 9, 46, 4, '#ffffff'); }
    paredeEscola(c, 0, W);
    // janelas para o pátio de fora
    for (const x of [140, 440, 880]) janelaEscola(c, x, 40, 54, 40);
    // salas de aula: porta azul com visor (a turma lá dentro), número e quadro de avisos
    for (const [x, n] of [[90, '1º A'], [300, '2º B'], [890, 'LAB']]) { porta(c, x, 118, 34, 92, '#2c5a9e', { batente: '#c8ccd0' }); R(c, x + 8, 128, 18, 22, '#9fc4d0'); R(c, x + 9, 129, 16, 6, '#3c8a5a'); for (let k = 0; k < 3; k++) { R(c, x + 10 + k * 5, 140, 3, 3, pick(['#e0b08a', '#9a6440', '#c88a60'], k)); R(c, x + 9 + k * 5, 143, 5, 4, '#2c5a9e'); } R(c, x + 4, 106, 26, 8, '#1d3a70'); R(c, x + 5, 107, 24, 1, '#3c6ab0'); void n; }
    // armários com cadeado e adesivos
    for (let k = 0; k < 12; k++) { const lx = 150 + k * 12; R(c, lx, 132, 11, 72, '#2f5f9a'); R(c, lx + 1, 134, 9, 30, '#4a7ab8'); R(c, lx + 1, 166, 9, 36, '#4a7ab8'); R(c, lx + 1, 134, 1, 68, '#6a9ad0'); for (let j = 0; j < 3; j++) { R(c, lx + 3, 137 + j * 3, 5, 1, '#2c5a9e'); R(c, lx + 3, 169 + j * 3, 5, 1, '#2c5a9e'); } R(c, lx + 8, 158, 2, 5, '#c8ccd0'); R(c, lx + 8, 163, 2, 2, '#e8c24c'); if (hash(k) > .55) ell(c, lx + 5, 180, 2.5, 2.5, pick(['#f2c94c', '#e86a8a', '#7ac85a', '#f2efe6'], k)); }
    // mural de cortiça com cartazes, desenhos dos alunos e quadro de horários
    R(c, 380, 56, 120, 50, '#8a6a45'); R(c, 383, 59, 114, 44, '#c8a46a'); for (let i = 0; i < 300; i++) R(c, 384 + hash(i) * 112, 60 + hash(i * 3) * 42, 1, 1, '#b8945a'); for (let k = 0; k < 10; k++) A.cartaz(c, 388 + (k % 5) * 22, 62 + Math.floor(k / 5) * 20, 30 + k);
    for (let k = 0; k < 4; k++) { const dx = 236 + (k % 2) * 30, dy = 56 + Math.floor(k / 2) * 26; R(c, dx, dy, 24, 20, '#f6f2ea'); R(c, dx, dy, 24, 1, '#c8c4bc'); ell(c, dx + 8, dy + 8, 4, 4, pick(['#e8c24c', '#e8433a', '#3c9ad8', '#7ac85a'], k)); R(c, dx + 4, dy + 14, 16, 3, '#5f9a46'); R(c, dx + 11, dy - 1, 2, 2, '#c43c3a'); }
    // estante de troféus, bebedouro, extintor, alarme, relógio, placa de saída, lixeiras e banco
    R(c, 520, 70, 90, 120, '#8a8478'); R(c, 522, 72, 86, 116, 'rgba(200,230,240,.55)'); for (let r = 0; r < 3; r++) { R(c, 522, 108 + r * 38, 86, 2, '#e8e4dc'); for (let k = 0; k < 4; k++) { const tx = 528 + k * 20, ty = 98 + r * 38; R(c, tx + 3, ty, 6, 8, '#c8a24a'); R(c, tx + 5, ty + 8, 2, 4, '#c8a24a'); R(c, tx + 2, ty + 12, 8, 3, '#8a6a3a'); R(c, tx + 3, ty, 2, 6, '#f2d898'); } } reflexo(c, 522, 72, 86, 116);
    R(c, 860, 160, 20, 44, '#c8ccd0'); R(c, 862, 160, 16, 6, '#e8eaec'); R(c, 868, 156, 4, 4, '#9aa0a6'); R(c, 840, 150, 8, 20, '#c43c3a'); R(c, 841, 146, 6, 4, '#2a2a2a'); R(c, 842, 136, 6, 6, '#c43c3a'); R(c, 843, 137, 4, 4, '#f2efe6');
    ell(c, 250, 40, 10, 10, '#2a2a2a'); ell(c, 250, 40, 8, 8, '#f6f8fa'); R(c, 250, 34, 1, 6, '#2a2a2a'); R(c, 250, 40, 5, 1, '#2a2a2a');
    R(c, 30, 46, 50, 16, '#2c5a9e'); R(c, 32, 48, 46, 12, '#3c6ab0'); R(c, 600, 26, 28, 10, '#2c8a3a'); R(c, 602, 28, 24, 6, '#4ac06a');
    for (const [x, col] of [[612, '#2c5a9e'], [626, '#e8c24c'], [940, '#c43c3a']]) { R(c, x, 186, 12, 18, col); R(c, x, 186, 12, 2, shadeHex(col, 1.3)); }
    R(c, 960, 180, 36, 4, '#8a6a45'); R(c, 962, 184, 3, 20, '#5a6066'); R(c, 991, 184, 3, 20, '#5a6066');
    // a sala da escada (fica atrás da parede da porta ESCADA): paredes, janela alta, luz, placas e a escada
    const z0 = ESC.Z0, z1 = ESC.Z1; vgrad(c, z0, 24, z1 - z0, 186, '#d8dce0', '#b0b8be'); for (let y = 30; y < 210; y += 10) R(c, z0, y, z1 - z0, 1, 'rgba(120,130,140,.12)');
    janelaEscola(c, z1 - 52, 34, 36, 28); R(c, z0 + 70, 28, 24, 4, '#f6f8fa'); R(c, z0 + 72, 29, 20, 2, '#ffffff');
    R(c, z0 + 6, 40, 40, 24, '#f2c94c'); R(c, z0 + 8, 42, 36, 20, '#f6dc7a'); R(c, z0 + 12, 46, 8, 12, '#2a2a2a'); R(c, z0 + 24, 46, 16, 3, '#2a2a2a'); R(c, z0 + 24, 52, 12, 3, '#2a2a2a');
    R(c, z0 + 120, 24, 30, 8, '#2c8a3a'); R(c, z0 + 122, 26, 26, 4, '#4ac06a');
    const rampY = (x) => 220 - (x - z0 - 10) * 120 / 140;
    for (let x = z0 + 10; x < z0 + 150; x += 10) { const top = Math.round(rampY(x + 10) / 2) * 2; R(c, x, top, 10, 220 - top, '#a8b0b6'); R(c, x, top, 10, 2, '#e8eaec'); R(c, x, top + 2, 10, 1, '#7a8086'); R(c, x + 9, top, 1, 220 - top, '#8a9298'); R(c, x, top, 10, 1, '#f2c94c'); }
    R(c, z0 + 150, 100, z1 - z0 - 150, 6, '#c8ccd0'); R(c, z0 + 150, 100, z1 - z0 - 150, 1, '#e8eaec'); R(c, z0 + 150, 106, z1 - z0 - 150, 104, '#9aa2a8');
    porta(c, z0 + 158, 54, 22, 46, '#c47a35', { batente: '#c8ccd0', vidro: true }); R(c, z0 + 156, 44, 26, 7, '#2c8a3a'); R(c, z0 + 157, 45, 24, 5, '#4ac06a'); // porta do pátio no alto da escada
    R(c, z1 - 8, 84, 6, 14, '#c43c3a'); R(c, z1 - 7, 80, 4, 4, '#2a2a2a'); R(c, z1 - 7, 86, 4, 1, '#f2efe6'); ell(c, z0 + 190 - 6, 94, 4, 5, '#5f9a46'); R(c, z0 + 181, 96, 6, 4, '#c47a35');
    R(c, z0 + 52, 110, 34, 20, '#f6f2ea'); R(c, z0 + 52, 110, 34, 3, '#c43c3a'); R(c, z0 + 55, 116, 22, 2, '#2a2a2a'); R(c, z0 + 55, 120, 26, 2, '#5a5a5a'); R(c, z0 + 55, 124, 18, 2, '#5a5a5a'); // aviso: não corra na escada
    R(c, z0 + 100, 70, 26, 18, '#f6f2ea'); R(c, z0 + 101, 71, 24, 16, '#8ec4e8'); ell(c, z0 + 113, 80, 5, 5, '#e8c24c'); R(c, z0 + 103, 84, 20, 3, '#5f9a46'); // desenho de aluno
    R(c, z0 + 8, 76, 10, 6, '#e8eaec'); R(c, z0 + 9, 77, 3, 4, '#ffffff'); R(c, z0 + 14, 77, 3, 4, '#ffffff'); // luz de emergência
    for (let k = 0; k < 15; k++) { const x = z0 + 14 + k * 10; R(c, x, rampY(x) - 22, 1, 22, '#5a6066'); } limb(c, [[z0 + 12, 196], [z0 + 152, 76], [z1, 76]], 2, '#2c5a9e'); limb(c, [[z0 + 12, 195], [z0 + 152, 75], [z1, 75]], 1, '#5a8ad8');
    limb(c, [[z0 + 4, 186], [z0 + 4, 100], [z0 + 4, 60]], 1, '#9aa0a6'); R(c, z0 + 20, 196, 22, 14, '#5a4a3a'); R(c, z0 + 22, 198, 18, 4, '#c47a35'); // material de limpeza embaixo da escada
    tilesEscola(c, W); for (let x = 0; x < W; x += 6) if (hash(x * .9) > .6) R(c, x, 224 + hash(x) * 10, 5, 1, 'rgba(255,255,255,.3)');
    return cv;
  }
  function tilesEscola(c, W) { R(c, 0, 210, W, LH - 210, '#c8ccce'); for (let x = 0; x < W; x += 20) R(c, x, 210, 1, LH - 210, '#b4b8bc'); for (let y = 222; y < LH; y += 14) R(c, 0, y, W, 1, '#b4b8bc'); for (let x = 0; x < W; x += 40) R(c, x + 4, 214, 14, 2, 'rgba(255,255,255,.4)'); R(c, 0, 210, W, 2, '#8a9096'); }
  let escolaMid = null, PAREDE = null, revela = 0, revT = 0;
  function buildParede() { // a parede da escada com a porta: some quando Da Roça entra
    const w = ESC.Z1 - ESC.Z0, [cv, c] = mk(w, LH); paredeEscola(c, 0, w); R(c, 0, 24, 2, 186, '#c8ccd0'); R(c, w - 2, 24, 2, 186, '#c8ccd0');
    porta(c, 14, 118, 34, 92, '#c47a35', { batente: '#c8ccd0', vidro: true }); R(c, 8, 100, 46, 12, '#2c8a3a'); R(c, 10, 102, 42, 8, '#4ac06a'); R(c, 12, 104, 6, 4, '#f2efe6');
    R(c, 70, 50, 100, 46, '#2c5a9e'); R(c, 72, 52, 96, 42, '#f2c94c'); R(c, 76, 56, 88, 6, '#2a2a2a'); R(c, 76, 66, 60, 4, '#5a4a10'); limb(c, [[150, 88], [158, 72], [166, 88]], 2, '#2a2a2a');
    janelaEscola(c, 120, 140, 50, 40); return cv;
  }
  function escola(c, s, t, camL) {
    if (!escolaMid) escolaMid = buildEscola(); if (!PAREDE) PAREDE = buildParede();
    c.drawImage(escolaMid, camL, 0, LW(), LH, 0, 0, LW(), LH);
    const hx = HERO().x / 2, dentro = hx > ESC.Z0 + 6 && hx < ESC.Z1; const dt = Math.max(0, Math.min(.05, t - revT)); revT = t; revela = cl(revela + (dentro ? dt * 3.5 : -dt * 3));
    for (let i = 0; i < 10; i++) { const wx = 40 + i * 100 + Math.sin(t * .4 + i) * 30, sx = wx - camL; if (vis(sx, 20) && (wx < ESC.Z0 - 10 || wx > ESC.Z1 + 10)) { pessoa(c, sx, 216, i); R(c, sx - 1, 202, 7, 2, '#2c5a9e'); } }
    const x = ESC.Z0 - camL;
    if (vis(x, 200)) { c.save(); c.globalAlpha = 1 - revela; c.drawImage(PAREDE, x, 0); c.restore(); }
    apagao(c, camL);
  }
  function apagao(c, camL) { // o resto da escola fica preto: só a sala da escada aparece, como um recorte
    if (revela <= .01) return; const x = ESC.Z0 - camL, w = ESC.Z1 - ESC.Z0;
    c.save(); c.globalAlpha = revela; c.fillStyle = '#000'; c.fillRect(-4, 0, Math.max(0, x - 4), LH); c.fillRect(x + w + 8, 0, LW() + 8, LH); c.fillRect(x - 8, 0, w + 16, 16); c.fillRect(x - 8, 236, w + 16, LH);
    for (let y = 16; y < 236; y += BL) { bloco(c, x - 8, y, '#8a9298', { pedra: true }); bloco(c, x + w, y, '#8a9298', { pedra: true }); } for (let xx = x - 8; xx < x + w + 8; xx += BL) { bloco(c, xx, 16, '#8a9298', { pedra: true }); bloco(c, xx, 220, '#9aa2a8', { tex: false }); bloco(c, xx, 228, '#7a848c', { pedra: true }); }
    c.restore();
  }
  function escolaLights(g, s, t, camL) { if (revela > .5) { lightAdd(ESC.Z0 + 82 - camL, 30, .35, 70); return; } for (let x = 30; x < ESC.W; x += 90) { const sx = x + 25 - camL; if (vis(sx)) lightAdd(sx, 12, .3, 60); } }

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
  REG({ id: 24, key: 'corredor-pensao', nome: 'Corredor da pensão', lugar: 'Pensão de Dona Lurdes · corredor dos quartos', grupo: 'ambiente', width: COR.W * 2, draw: corredor, lights: corredorLights, amb: indoor(.5),
    limites: [(COR.x0 + 6) * 2, (COR.x1 - 6) * 2],
    labels: COR.Q.map(([x, n]) => [x + 8, 177, n, 3, '#5a3a20']).concat([[214, 184, 'CADÊ MEU RÁDIO? —LURDES', 2, '#c43c3a'], [COR.ENT + 8, 176, 'RUA', 3, '#f2efe6']]),
    interact: [] }, { platforms: [], gaps: [] });
  REG({ id: 25, key: 'quarto', nome: 'Quarto do Da Roça', lugar: 'Pensão de Dona Lurdes · quarto 4', grupo: 'ambiente', width: QT.W * 2, draw: quarto, lights: quartoLights, amb: indoor(.38),
    limites: [(QT.x0 + 6) * 2, (QT.x1 - 6) * 2],
    labels: [[QT.PC - 3, 179, 'FLIPERAMA', 3, '#f2efe6']],
    interact: [] }, { platforms: [], gaps: [] });
  REG({ id: 26, key: 'escola-terreo', nome: 'Escola SESI · térreo', lugar: 'Corredor das salas e a escada para o pátio', grupo: 'ambiente', width: ESC.W * 2, draw: escola, lights: escolaLights, amb: indoor(.8),
    labelAlpha: () => 1 - revela, // as placas somem junto com o resto quando o Da Roça entra na escada
    labels: [[55, 54, 'BEM-VINDO AO SESI', 4, '#f2efe6'], [107, 110, '1º A', 4, '#f2efe6'], [317, 110, '2º B', 4, '#f2efe6'], [917, 110, 'LAB', 4, '#f2efe6'], [ESC.Z0 + 31, 106, 'ESCADA', 4, '#f2efe6'], [ESC.Z0 + 120, 76, 'PÁTIO NO 2º ANDAR ↑', 5, '#5a4a10'], [ESC.Z0 + 30, 56, 'SUBA', 4, '#f2f2ee'], [440, 50, 'MURAL', 5, '#5a3a20'], [565, 64, 'TROFÉUS', 5, '#5a5a5a']],
    interact: [['trash', 700], ['ball', 1000], ['pot', 1900]] }, { platforms: [], gaps: [] });
  REG({ id: 27, key: 'patio', nome: 'Pátio · 2º andar', lugar: 'Pátio da Escola SESI, com vista da cidade', grupo: 'ambiente', width: PT.W * 2, draw: patio, lights: patioLights, plat: (c, x, y, w, t) => window.CampanhaCenarios.plataforma(c, 21, [x, y, w], t),
    labels: [[115, 98, 'CANTINA', 7, '#ffffff'], [730, 176, 'GRÊMIO ESTUDANTIL', 5, '#ffffff'], [30, 105, '↓ ESCADA', 4, '#ffffff']],
    interact: [['ball', 1400], ['ball', 1460], ['trash', 1900], ['pot', 1240], ['cone', 1600]] }, { platforms: [[1300, 384, 150], [1490, 328, 140], [1680, 272, 140]], gaps: [] });

  /* ---------- passagens entre as cenas ----------
     tipo: 'porta' (botão ENTRAR/SAIR), 'rolante' (sobe/desce de escada rolante), 'pc' (abre o Fliperama), 'armario' (abre a personalização),
     'rampa' (escada que se sobe andando; no alto troca de cena). x e y em pixels do mundo. */
  const PORTAIS = [
    { cena: 22, x: FR.ENT * 2, tipo: 'porta', rotulo: 'ENTRAR NO SHOPPING', para: { cena: 20, x: 180 } },
    { cena: 20, x: 90, tipo: 'porta', rotulo: 'SAIR DO SHOPPING', para: { cena: 22, x: FR.ENT * 2 } },
    { cena: 20, x: SHOP.ESC * 2 + 20, tipo: 'rolante', rotulo: 'SUBIR A ESCADA ROLANTE', de: [SHOP.ESC * 2 + 12, 420], ate: [SHOP.ESC * 2 + 224, 192], para: { cena: 23, x: (P2.ESC + 150) * 2 } },
    { cena: 23, x: (P2.ESC + 130) * 2, tipo: 'rolante', rotulo: 'DESCER A ESCADA ROLANTE', de: [(P2.ESC + 124) * 2, 440], ate: [(P2.ESC + 20) * 2, 540], para: { cena: 20, x: SHOP.ESC * 2 - 30 } },
    { cena: 13, x: (780 + 144) * 2, tipo: 'porta', rotulo: 'ENTRAR NA PENSÃO', para: { cena: 24, x: (COR.ENT + 8) * 2 + 30 } },
    { cena: 24, x: (COR.ENT + 8) * 2, tipo: 'porta', rotulo: 'SAIR PARA A RUA', para: { cena: 13, x: (780 + 144) * 2 } },
    { cena: 24, x: (COR.Q[3][0] + 8) * 2, tipo: 'porta', rotulo: 'ENTRAR NO QUARTO 4', para: { cena: 25, x: (QT.x0 + 10) * 2 + 24 } },
    { cena: 25, x: (QT.x0 + 10) * 2, tipo: 'porta', rotulo: 'SAIR PARA O CORREDOR', para: { cena: 24, x: (COR.Q[3][0] + 8) * 2 } },
    { cena: 25, x: QT.ARM * 2, tipo: 'armario', rotulo: 'ABRIR O ARMÁRIO (ROUPAS)' },
    { cena: 25, x: QT.PC * 2, tipo: 'pc', rotulo: 'USAR O COMPUTADOR (FLIPERAMA)' },
    { cena: 21, x: (1250 + 720) * 2, tipo: 'porta', rotulo: 'ENTRAR NA ESCOLA', para: { cena: 26, x: 120 } },
    { cena: 26, x: 70, tipo: 'porta', rotulo: 'SAIR DA ESCOLA', para: { cena: 21, x: (1250 + 720) * 2 } },
    { cena: 26, tipo: 'rampa', x0: RAMPA.x0, y0: RAMPA.y0, x1: RAMPA.x1, y1: RAMPA.y1, para: { cena: 27, x: 130 } },
    { cena: 27, x: 58, tipo: 'porta', rotulo: 'DESCER A ESCADA', para: { cena: 26, x: RAMPA.x0 - 50 } }
  ];
  window.CampanhaAmbientes = Object.freeze({ portais: (cena) => PORTAIS.filter((p) => p.cena === cena), todos: () => PORTAIS.slice(), rampa: RAMPA,
    // desenha por cima de tudo (objetos, plantas, herói): o preto em volta da sala da escada da escola. c em pixels do mundo, sem câmera.
    cobrir: (c, cena, camera) => { if (cena !== 26 || revela <= .01) return; const camL = Math.floor(camera / 2), sub = Math.round(camera) - camL * 2; c.save(); c.translate(-sub, 0); c.scale(2, 2); apagao(c, camL); c.restore(); } });
})();
