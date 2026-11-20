/* Campanha 2 · Passo 2C (parte 2): cenários novos 32 a 34.
   32 Lagoa das Bateias · 33 Parque da Cidade · 34 Serra do Marçal (mirante, rampa de voo livre e a estrada descendo a serra). */
(() => {
  'use strict';
  if (!window.CampanhaNovos || window.CampanhaNovos.b) return;
  const CC = window.CampanhaCenarios, A = CC.arte, K = window.CampanhaCamadas.kit, N = window.CampanhaNovos;
  const { R, ell, mk, hash, cl, mix, limb, tile, sky, haze, tree, vis, night, shadeHex, pick, lightAdd, lampGlow, vgrad, gente, pessoa, plaster, roofTiles, cachorro, lampPost, bench, ipe, fog, conquistaBack, objetos, chaoDetalhe, terra, pedraPortuguesa, grafite, Q, sombra, lerpC, GY, bandeirinhas } = A;
  const { pxText, pessoinha, arvoreM, nevoa, noiteTile, scr, wrap, balao, SKIN, ROUPA, T } = K;
  const LW = 482, LH = 270, TAU = Math.PI * 2, { drawMid } = N;

  /* =====================================================================
     32 · LAGOA DAS BATEIAS: pista de caminhada na beira, píer, pedalinhos, patos e garças
     ===================================================================== */
  const LAG = { W: 2600, PIER: 900, QUIOSQUE: 1480, PEDAL: 2020, ILHA: 1300 };
  const F32 = {};
  function buildMargem() { // a outra margem: árvores, casinhas e prédios baixos (com o reflexo pronto)
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH);
    for (let x = 0, i = 0; x < T; i++) { const w = 14 + Math.round(hash(i + 32) * 16), h = 8 + Math.round(hash(i + 33) * 18); if (hash(i + 34) > .45) { const col = pick(['#f2e6d0', '#e8d0c0', '#d8e0e8', '#f2e2a8', '#f6f2e8'], i); R(c, x, 162 - h, w, h, col); R(c, x + w - 2, 162 - h, 2, h, shadeHex(col, .82)); roofTiles(c, x - 1, 159 - h, w + 2, 3, pick(['#b8644a', '#a8543c'], i)); for (let k = 0; k < Math.floor(w / 6); k++) { R(c, x + 2 + k * 6, 165 - h, 3, 3, '#5a7a8a'); if (hash(i * 7 + k) > .5) R(n, x + 2 + k * 6, 165 - h, 3, 3, '#ffd98a'); } }
      else for (let k = 0; k < 5; k++) ell(c, x + w / 2 + (k - 2) * 4, 154 - hash(i * 5 + k) * 10, 6, 6, pick(['#4f7a46', '#5f8a52', '#6a9a5a'], i + k)); x += w + 2; }
    R(c, 0, 160, T, 4, '#6a8a52'); R(c, 0, 163, T, 1, '#8a8a7a'); nevoa(c, T, 'rgba(200,214,226,.22)');
    const [rv, r] = mk(T, 40); r.save(); r.translate(0, 40); r.scale(1, -1); r.drawImage(cv, 0, 124, T, 40, 0, 0, T, 40); r.restore();
    return { cv, nv, rv };
  }
  function buildLagoa() {
    const W = LAG.W, [cv, c] = mk(W, LH);
    // a beira: gramado, guarda-corpo de madeira, coqueiros, bancos e postes
    R(c, 0, 200, W, 12, '#5f8a46'); for (let x = 0; x < W; x += 3) R(c, x, 199 - Math.round(hash(x) * 3), 2, 3, '#7aa856');
    for (let x = 0; x < W; x += 40) { if (Math.abs(x - LAG.PIER - 30) < 50 || Math.abs(x - LAG.PEDAL - 40) < 60) continue; R(c, x, 192, 3, 18, '#7a5a3a'); R(c, x, 192, 1, 18, '#a8845a'); R(c, x, 195, 40, 2, '#8a6a45'); R(c, x, 202, 40, 2, '#8a6a45'); }
    // píer de madeira entrando na lagoa (em perspectiva), com o pescador
    const p = LAG.PIER; for (let k = 0; k < 20; k++) { const y = 206 - k, w = 60 - k * 1.5; R(c, p + 30 - w / 2, y, w, 1, k % 3 ? '#a87a4a' : '#8a5a32'); } for (const dx of [-26, 24]) R(c, p + 30 + dx, 190, 2, 16, '#6a4a2a'); R(c, p + 30 - 1, 172, 2, 14, '#6a4a2a');
    // quiosque de água de coco
    const q = LAG.QUIOSQUE; for (let k = 0; k < 18; k++) R(c, q - 8 + k * .8, 132 + k * 1.6, 112 - k * 1.6, 2, k % 2 ? '#c8a050' : '#b88a3a'); R(c, q + 4, 160, 4, 50, '#7a5a3a'); R(c, q + 88, 160, 4, 50, '#7a5a3a'); R(c, q, 176, 96, 34, '#8a6a45'); R(c, q, 176, 96, 3, '#c4955c');
    for (let k = 0; k < 10; k++) { ell(c, q + 10 + (k % 5) * 18, 186 + Math.floor(k / 5) * 9, 5, 4, '#5a9a3a'); ell(c, q + 9 + (k % 5) * 18, 185 + Math.floor(k / 5) * 9, 2, 2, '#7ac85a'); } R(c, q + 20, 162, 56, 10, '#2c8a5a'); pxText(c, 'AGUA DE COCO', q + 48, 165, '#ffffff');
    // aluguel de pedalinho
    const d = LAG.PEDAL; for (let k = 0; k < 12; k++) R(c, d + k * 8, 204 - (k % 2), 7, 6, '#a87a4a'); R(c, d + 10, 160, 60, 14, '#3c8ad8'); R(c, d + 12, 162, 56, 10, '#5aa0e8'); pxText(c, 'PEDALINHO R$10', d + 40, 165, '#ffffff'); R(c, d + 38, 174, 3, 30, '#5a5e62');
    // academia ao ar livre e bebedouro
    for (let k = 0; k < 3; k++) { const ax = 300 + k * 34; R(c, ax, 186, 3, 24, pick(['#e8433a', '#3c8ad8', '#e8c24c'], k)); R(c, ax + 20, 186, 3, 24, pick(['#e8433a', '#3c8ad8', '#e8c24c'], k)); R(c, ax, 186, 23, 3, pick(['#e8433a', '#3c8ad8', '#e8c24c'], k)); }
    for (let lx = 60; lx < W; lx += 220) lampPost(c, lx, 130);
    for (const bx of [520, 1200, 1800, 2380]) bench(c, bx, 212, 40, '#8a6a45', '#c4955c');
    objetos(c, 32, W, 'cidade', 40, W - 40, [160, 260]);
    // pista de caminhada (chão): faixa vermelha com marcação de metros
    R(c, 0, 212, W, 8, '#cfc8b6'); R(c, 0, 220, W, LH - 220, '#b4523a'); for (let x = 0; x < W; x += 2) R(c, x, 220 + hash(x * 1.3) * 50, 1, 1, '#c45e44'); R(c, 0, 244, W, 1, '#f2e8dc'); for (let x = 50; x < W; x += 100) pxText(c, `${x * 2}M`, x, 250, '#f2e8dc'); R(c, 0, 220, W, 2, '#e8e4dc');
    chaoDetalhe(c, W, 'cidade');
    return cv;
  }
  function lagoa(c, s, t, camL) {
    if (!F32.mid) { F32.m = buildMargem(); F32.mid = buildLagoa(); }
    const nt = night(s), sun = A.sunInfo(s);
    conquistaBack(c, s, t, camL, { seed: 32, trees: false });
    c.save(); c.translate(0, -16); tile(c, F32.m.cv, camL * .2); noiteTile(c, s, F32.m.nv, camL * .2); c.restore();
    // a água: céu refletido, reflexo da margem, brilho do sol e marolinhas
    const top = 148, bot = 204;     vgrad(c, 0, top, LW, bot - top, lerpC('#7ab8e0', '#1c2a44', nt), lerpC('#3a7aa8', '#0e1626', nt));
    { c.save(); c.globalAlpha = .2; const o = ((Math.round(camL * .2) % T) + T) % T; c.drawImage(F32.m.rv, -o, top); if (T - o < LW) c.drawImage(F32.m.rv, T - o, top); c.restore(); }
    for (let y = top + 2; y < bot; y += 3) { const sp = (y - top) / (bot - top), off = (t * (8 + sp * 14) + y * 13) % 40; for (let x = -40 + off - (camL * (.2 + sp * .6)) % 40; x < LW; x += 40) R(c, x, y, 6 + sp * 10, 1, `rgba(255,255,255,${.08 + sp * .1})`); }
    if (sun.str > .1 && nt < .3) { const sx = 40 + (1 - (s.sunT ?? .5)) * 400; for (let k = 0; k < 12; k++) { const y = top + 2 + k * 3.2, w = 4 + Math.abs(Math.sin(t * 3 + k)) * 10; R(c, sx - w / 2 + Math.sin(t * 2 + k) * 3, y, w, 1, `rgba(255,248,210,${.5 * sun.str})`); } }
    if (nt > .2) { for (let lx = 60; lx < LAG.W; lx += 220) { const x = lx + 1 - camL; if (!vis(x, 10)) continue; for (let y = top + 2; y < bot; y += 2) R(c, x - 1 + Math.sin(t * 3 + y * .7) * 2, y, 3, 1, `rgba(255,226,150,${nt * .55 * (1 - (y - top) / 50)})`); } const mx = 360; for (let y = top + 2; y < bot - 10; y += 2) R(c, mx - 3 + Math.sin(t * 2 + y) * 2, y, 6, 1, `rgba(240,240,220,${nt * .4})`); }
    R(c, 0, top, LW, 1, 'rgba(255,255,255,.35)');
    // ilhota com garças e uma garça voando
    { const x = scr({ f: .45 }, LAG.ILHA, camL); if (vis(x, 60)) { ell(c, x, 178, 34, 6, '#4f7a3a'); ell(c, x - 6, 172, 12, 10, '#3f6a32'); ell(c, x + 10, 170, 10, 12, '#4f7a3a'); R(c, x - 1, 170, 2, 8, '#5a4a32'); ell(c, x, 183, 36, 3, 'rgba(20,40,40,.4)');
      for (const [gx, gy] of [[-14, 166], [4, 162], [16, 166]]) { R(c, x + gx, gy, 4, 4, '#f6f6f0'); R(c, x + gx + 3, gy - 4, 1, 4, '#f6f6f0'); R(c, x + gx + 3, gy - 5, 3, 1, '#f6f6f0'); R(c, x + gx + 6, gy - 5, 2, 1, '#e8c24c'); R(c, x + gx + 1, gy + 4, 1, 3, '#2a2a2a'); } } }
    { const ph = (t % 26) / 26; if (ph < .5 && nt < .6) { const k = ph / .5, x = 500 - k * 600, y = 120 + Math.sin(k * 6) * 6, f = Math.sin(t * 7) > 0; R(c, x, y, 6, 3, '#f6f6f0'); R(c, x - 3, y + 1, 3, 1, '#f6f6f0'); R(c, x - 4, y + 1, 1, 1, '#e8c24c'); R(c, x + 6, y + 1, 4, 1, '#2a2a2a'); R(c, x + 1, y - (f ? 4 : -2), 5, 2, '#e8e8e2'); } }
    // pedalinhos de cisne
    for (let i = 0; i < 3; i++) { const dir = i % 2 ? 1 : -1, wx = wrap(i * 420 + t * 6 * dir, 1400), x = scr({ f: .62 }, wx, camL), y = 172 + i * 9; if (!vis(x, 30)) continue; R(c, x, y - 6, 18, 6, '#f6f6f0'); R(c, x, y, 18, 2, 'rgba(20,40,60,.35)'); const hx = dir > 0 ? x + 16 : x - 2; R(c, hx, y - 14, 3, 9, '#f6f6f0'); R(c, hx + (dir > 0 ? 2 : -2), y - 15, 3, 2, '#f6f6f0'); R(c, hx + (dir > 0 ? 4 : -3), y - 14, 2, 1, '#f08a24'); R(c, x + 4, y - 11, 4, 5, pick(ROUPA, i)); R(c, x + 4, y - 14, 4, 3, pick(SKIN, i)); R(c, x + 10, y - 11, 4, 5, pick(ROUPA, i + 3)); R(c, x + 10, y - 14, 4, 3, pick(SKIN, i + 2)); R(c, x + 6, y - 9, 6, 3, '#e8433a'); for (let k = 1; k < 4; k++) R(c, dir > 0 ? x - k * 5 : x + 18 + k * 5, y + (k % 2), 3, 1, 'rgba(255,255,255,.4)'); }
    // família de patos
    { const wx = wrap(t * 5, 1400), x = scr({ f: .75 }, wx, camL); if (vis(x, 40)) for (let k = 0; k < 5; k++) { const px = x - k * 8, py = 198 + Math.round(Math.sin(t * 3 + k)), big = k === 0; R(c, px, py - (big ? 4 : 3), big ? 7 : 4, big ? 4 : 3, big ? '#8a6a3a' : '#e8c24c'); R(c, px + (big ? 5 : 3), py - (big ? 7 : 5), big ? 3 : 2, big ? 3 : 2, big ? '#2c6a3a' : '#e8c24c'); R(c, px + (big ? 8 : 5), py - (big ? 6 : 4), 2, 1, '#f08a24'); R(c, px - 3, py, 3, 1, 'rgba(255,255,255,.4)'); } }
    { const ph = (t % 9) / 9; if (ph < .12) { const x = scr({ f: .55 }, 600 + Math.floor(t / 9) * 173 % 900, camL), k = ph / .12, y = 190 - Math.sin(k * Math.PI) * 10; R(c, x + k * 12, y, 4, 2, '#c8ccd0'); ell(c, x, 192, 4 + k * 8, 1 + k, `rgba(255,255,255,${.5 * (1 - k)})`); } } // peixe pulando
    drawMid(c, F32.mid, camL);
    { const x = LAG.PIER + 30 - camL; if (vis(x, 40)) { gente(c, x - 4, 186, 8, false); R(c, x - 6, 168, 10, 3, '#d8b878'); const bob = Math.sin(t * 2) * 1.5, pull = (t % 30) < 2; limb(c, [[x + 4, 176], [x + 26, pull ? 150 : 156]], 1, '#5a4a32'); limb(c, [[x + 26, pull ? 150 : 156], [x + 30, 182 + bob]], 1, 'rgba(240,240,240,.6)'); R(c, x + 29, 181 + bob, 2, 2, '#e8433a'); if (pull) { R(c, x + 28, 160, 6, 3, '#c8ccd0'); balao(c, x, 160, 'PEGUEI UM!'); } } } // pescador
    { const x = LAG.QUIOSQUE + 48 - camL; if (vis(x, 40)) { ell(c, x, 172, 4, 4, '#9a6440'); R(c, x - 4, 176, 8, 8, '#e8e2d0'); if (Math.sin(t * 1.3) > .7) { R(c, x + 6, 178, 6, 2, '#9a6440'); ell(c, x + 14, 178, 3, 3, '#5a9a3a'); } } }
    fog(c, s, t, camL, .28);
  }
  function lagoaLights(g, s, t, camL) { const a = night(s); if (a < .05) return; for (let lx = 60; lx < LAG.W; lx += 220) lampGlow(g, lx - camL + 1, 130, a); const q = LAG.QUIOSQUE + 48 - camL; if (vis(q, 60)) lightAdd(q, 170, .6 * a, 50); }

  /* =====================================================================
     33 · PARQUE DA CIDADE: parquinho, pista de skate, academia da terceira idade, dominó, piquenique, carrinhos e o parcão
     ===================================================================== */
  const PQ = { W: 2400, PLAY: 80, SKATE: 560, IDOSOS: 960, PIC: 1300, CARR: 1660, PARCAO: 1960 };
  const F33 = {};
  function buildArvoredo() { // fileira de árvores do parque com o trilho do trenzinho
    const [cv, c] = mk(T, LH), b = 192;
    for (let i = 0; i < 70; i++) { const x = hash(i + 330) * T, s = .9 + hash(i + 331) * .7; R(c, x, b - 26 * s, 3, 26 * s, '#5a4a36'); for (let k = 0; k < 9; k++) ell(c, x + 1 + (hash(i * 9 + k) - .5) * 26 * s, b - 30 * s - hash(i * 3 + k) * 20 * s, 8 * s, 7 * s, pick(['#4f7a46', '#5f8a52', '#6a9a5a', '#457040'], i + k)); if (hash(i + 332) > .8) for (let k = 0; k < 6; k++) R(c, x - 8 + hash(i + k) * 18, b - 40 * s + hash(i * 2 + k) * 16, 2, 2, pick(['#e86a8a', '#f2c94c'], i)); }
    R(c, 0, b, T, 3, '#8a7a5a'); for (let x = 0; x < T; x += 5) R(c, x, b + 1, 3, 1, '#5a4a32');
    nevoa(c, T, 'rgba(204,218,228,.2)'); return { cv, f: .42, base: b };
  }
  function buildParque() {
    const W = PQ.W, [cv, c] = mk(W, LH);
    R(c, 0, 196, W, 16, '#5f8a46'); for (let x = 0; x < W; x += 3) R(c, x, 195 - Math.round(hash(x) * 3), 2, 3, '#7aa856');
    // parquinho: piso emborrachado, escorregador com escada, estrutura dos balanços, gangorra e caixa de areia
    const p = PQ.PLAY; R(c, p, 200, 380, 12, '#c4583a'); for (let x = p; x < p + 380; x += 20) R(c, x, 200, 10, 12, '#3c8ad8');
    R(c, p + 10, 128, 4, 72, '#e8433a'); R(c, p + 120, 128, 4, 72, '#e8433a'); R(c, p + 8, 126, 118, 5, '#f2c94c'); // balanços (estrutura)
    R(c, p + 160, 150, 4, 50, '#3c8ad8'); R(c, p + 186, 150, 4, 50, '#3c8ad8'); R(c, p + 156, 146, 38, 6, '#e8c24c'); for (let k = 0; k < 6; k++) R(c, p + 160, 158 + k * 8, 30, 2, '#5aa0e8'); for (let k = 0; k < 40; k++) R(c, p + 194 + k * 1.6, 150 + k * 1.25, 8, 2, k % 2 ? '#e8833a' : '#f2a83a'); R(c, p + 156, 140, 38, 6, '#e8433a'); for (let k = 0; k < 38; k += 4) R(c, p + 156 + k, 134, 2, 6, '#e8433a'); // escorregador
    R(c, p + 300, 192, 70, 8, '#d8c49a'); R(c, p + 298, 190, 74, 2, '#8a6a45'); R(c, p + 316, 188, 6, 4, '#e8433a'); R(c, p + 340, 189, 10, 3, '#3c8ad8'); // caixa de areia
    // pista de skate: bowl de concreto com grafite e corrimão
    const sk = PQ.SKATE; R(c, sk, 150, 360, 50, '#a8aca8'); for (let k = 0; k <= 60; k++) { const u = k / 60, y = 150 + Math.round((1 - Math.cos(u * Math.PI / 2)) * 0 + Math.sin(u * Math.PI / 2) * 0); void y; }
    for (let x = 0; x < 360; x++) { const u = x / 360, depth = Math.round(Math.sin(u * Math.PI) * 30); R(c, sk + x, 150, 1, depth + 10, '#bcc0bc'); R(c, sk + x, 160 + depth, 1, 2, '#e8ece8'); } R(c, sk, 148, 360, 3, '#8a8e8a'); grafite(c, sk + 30, 162, 300, 26, 3301); R(c, sk + 140, 186, 80, 2, '#c8ccd0'); R(c, sk + 150, 188, 2, 12, '#8a8e92'); R(c, sk + 208, 188, 2, 12, '#8a8e92');
    // academia da terceira idade e mesa de dominó
    const id = PQ.IDOSOS; for (let k = 0; k < 4; k++) { const ax = id + k * 40, col = pick(['#e8c24c', '#3c8ad8', '#e8433a', '#3c8a5a'], k); R(c, ax, 170, 4, 30, col); R(c, ax - 6, 168, 16, 3, col); ell(c, ax + 2, 185, 8, 2, shadeHex(col, .8)); }
    R(c, id + 180, 186, 40, 4, '#e8e2d2'); R(c, id + 198, 190, 4, 10, '#8a8a86'); for (let k = 0; k < 6; k++) R(c, id + 184 + k * 6, 184, 4, 2, '#f6f6f0'); for (const sx of [id + 170, id + 224]) { R(c, sx, 194, 8, 2, '#8a8a86'); R(c, sx + 3, 196, 2, 6, '#8a8a86'); }
    // piquenique: toalhas xadrez e cesta
    for (let k = 0; k < 3; k++) { const tx = PQ.PIC + k * 110; for (let x = 0; x < 40; x += 4) for (let y = 0; y < 6; y += 3) R(c, tx + x + (y ? 2 : 0), 202 + y, 3, 3, (x / 4 + y / 3) % 2 ? '#e8433a' : '#f6f2ea'); R(c, tx + 30, 196, 10, 7, '#a8742a'); limb(c, [[tx + 30, 196], [tx + 35, 192], [tx + 40, 196]], 1, '#8a5a2a'); }
    // carrinhos: picolé, algodão-doce e pipoca
    const cr = PQ.CARR; R(c, cr, 176, 34, 22, '#eef4f6'); R(c, cr, 176, 34, 6, '#3e7cc0'); pxText(c, 'PICOLE', cr + 17, 186, '#3e7cc0'); ell(c, cr + 6, 200, 4, 4, '#2a2a2a'); ell(c, cr + 28, 200, 4, 4, '#2a2a2a'); ell(c, cr + 17, 160, 16, 5, '#f2c94c'); R(c, cr + 16, 160, 2, 16, '#8a8a86');
    R(c, cr + 80, 172, 30, 26, '#f6a8c8'); for (let k = 0; k < 4; k++) { ell(c, cr + 86 + k * 6, 164, 5, 5, '#ffd0e8'); R(c, cr + 86 + k * 6, 168, 1, 6, '#f6f2ea'); } ell(c, cr + 84, 200, 4, 4, '#2a2a2a'); ell(c, cr + 106, 200, 4, 4, '#2a2a2a'); pxText(c, 'ALGODAO', cr + 95, 184, '#c43c6a');
    A.OBJ.pipoca(c, cr + 170, 0); R(c, cr + 172, GY - 24, 18, 3, '#c43c3a');
    // parcão: cercado com obstáculos e hidrante
    const pc = PQ.PARCAO; for (let x = pc; x < pc + 400; x += 6) R(c, x, 184, 1, 16, '#5a5e62'); R(c, pc, 184, 400, 1, '#5a5e62'); R(c, pc, 192, 400, 1, '#5a5e62'); R(c, pc + 160, 172, 80, 12, '#3c8a5a'); pxText(c, 'PARCAO', pc + 200, 175, '#ffffff'); for (let k = 0; k < 3; k++) { R(c, pc + 60 + k * 90, 196, 20, 3, '#e8833a'); R(c, pc + 62 + k * 90, 199, 2, 8, '#8a8a86'); R(c, pc + 76 + k * 90, 199, 2, 8, '#8a8a86'); } A.hidrante(c, pc + 360);
    for (let lx = 40; lx < W; lx += 260) lampPost(c, lx, 124); bandeirinhas(c, PQ.PIC - 20, PQ.PIC + 320, 120, 33);
    objetos(c, 33, W, 'cidade', 40, W - 40, [180, 280]);
    pedraPortuguesa(c, W, 212); R(c, 0, 212, W, 2, '#c8c2b0'); chaoDetalhe(c, W, 'cidade');
    return cv;
  }
  function parque(c, s, t, camL) {
    if (!F33.mid) { F33.arv = buildArvoredo(); F33.mid = buildParque(); }
    const nt = night(s);
    conquistaBack(c, s, t, camL, { seed: 33, kites: true, trees: false });
    tile(c, F33.arv.cv, camL * F33.arv.f);
    { const wx = wrap(t * 16), sx = scr(F33.arv, wx, camL), y = F33.arv.base; if (vis(sx, 80)) { R(c, sx, y - 10, 12, 9, '#e8433a'); R(c, sx + 2, y - 14, 6, 4, '#2a2a2a'); R(c, sx + 9, y - 16, 2, 6, '#5a5a56'); for (let k = 1; k < 5; k++) { const vx = sx - k * 15; R(c, vx, y - 8, 13, 7, pick(['#3c8ad8', '#e8c24c', '#3c8a5a', '#c86ab8'], k)); R(c, vx + 1, y - 11, 11, 2, '#f2efe6'); R(c, vx + 3, y - 10, 3, 2, pick(SKIN, k)); R(c, vx + 7, y - 10, 3, 2, pick(SKIN, k + 1)); } } } // trenzinho
    drawMid(c, F33.mid, camL);
    { const p = PQ.PLAY - camL; if (vis(p, 220)) { for (let k = 0; k < 3; k++) { const a = Math.sin(t * 2.2 + k * 1.3) * (k === 1 ? .2 : .55), px = p + 30 + k * 34, len = 40, ex = px + Math.sin(a) * len, ey = 131 + Math.cos(a) * len; limb(c, [[px, 131], [ex, ey]], 1, '#5a5e62'); R(c, ex - 4, ey, 10, 2, '#3a3a36'); if (k !== 1) { R(c, ex - 2, ey - 9, 6, 9, pick(ROUPA, k + 4)); R(c, ex - 1, ey - 13, 4, 4, pick(SKIN, k)); R(c, ex + (a > 0 ? 3 : -2), ey + 2, 2, 4, '#2a2f3a'); } } // balanços
        const sl = (t * .35) % 1; if (sl < .5) { const u = sl / .5, x = p + 196 + u * 62, y = 144 + u * 48; R(c, x, y - 8, 5, 7, '#e8c24c'); R(c, x, y - 11, 5, 3, pick(SKIN, 2)); } else { const u = (sl - .5) / .5, y = 196 - u * 50; R(c, p + 168, y - 8, 5, 7, '#e8c24c'); R(c, p + 168, y - 11, 5, 3, pick(SKIN, 2)); } // escorregador
        const a = Math.sin(t * 1.6) * 6, gx = p + 240; limb(c, [[gx, 196 - a], [gx + 50, 196 + a]], 2, '#3c8a5a'); R(c, gx + 23, 196, 4, 6, '#3c8a5a'); for (const [dx, sg] of [[2, -1], [44, 1]]) { const y = 196 + sg * a; R(c, gx + dx, y - 8, 5, 7, pick(ROUPA, dx)); R(c, gx + dx, y - 11, 5, 3, pick(SKIN, dx)); } } } // gangorra
    { const sk = PQ.SKATE, u = (Math.sin(t * 1.3) + 1) / 2, x = sk + 20 + u * 320, depth = Math.sin(u * Math.PI) * 30, up = Math.abs(Math.cos(u * Math.PI)) > .9 ? Math.abs(Math.sin(t * 2.6)) * 10 : 0, y = 158 + depth - up, sx = x - camL; if (vis(sx, 20)) { R(c, sx - 4, y, 12, 2, '#c43c3a'); R(c, sx - 3, y + 2, 2, 2, '#f2efe6'); R(c, sx + 5, y + 2, 2, 2, '#f2efe6'); R(c, sx, y - 10, 5, 8, '#4f8a52'); R(c, sx, y - 14, 5, 4, pick(SKIN, 4)); R(c, sx - 1, y - 15, 7, 2, '#d9b347'); R(c, sx + 1, y - 2, 1, 2, '#22262c'); R(c, sx + 3, y - 2, 1, 2, '#22262c'); } } // skatista
    { const id = PQ.IDOSOS - camL; if (vis(id, 260)) { for (let k = 0; k < 3; k++) { const ax = id + k * 40, sw = Math.sin(t * 2 + k) * 4; gente(c, ax - 1, 200, k + 10, false); R(c, ax - 1 + sw, 192, 2, 8, '#2a2f3a'); R(c, ax + 4 - sw, 192, 2, 8, '#2a2f3a'); R(c, ax, 180, 6, 2, '#e8e2d0'); }
      for (const [dx, i] of [[160, 2], [222, 4]]) { gente(c, id + dx, 202, i + 10, false); R(c, id + dx + 1, 182, 5, 2, '#e8e2d0'); } const bate = (t % 5) < .3; R(c, id + 196, 184 - (bate ? 4 : 0), 4, 2, '#f6f6f0'); if ((t % 5) < 1.4) balao(c, id + 200, 178, bate ? 'BATI!' : 'É CARROÇA!'); } } // dominó
    { const b = PQ.PIC + 230 - camL; if (vis(b, 120)) { gente(c, b, 212, 3, false); for (let i = 0; i < 7; i++) { const q = (t * .18 + i / 7) % 1, x = b + 10 + q * 90 + Math.sin(t + i) * 8, y = 196 - q * 80 + Math.sin(t * 2 + i) * 4, r = 3 + (i % 3); if (q < .9) { c.strokeStyle = `rgba(220,240,255,${(1 - q) * .8})`; c.beginPath(); c.arc(x, y, r, 0, TAU); c.stroke(); R(c, x - r * .5, y - r * .5, 1, 1, 'rgba(255,255,255,.9)'); } } } } // bolhas de sabão
    { const pc = PQ.PARCAO - camL; if (vis(pc, 420)) { const u = (t * .3) % 1, bx = pc + 40 + (u < .5 ? u * 2 : 2 - u * 2) * 320; R(c, bx, 200 - Math.abs(Math.sin(t * 4)) * 8, 3, 3, '#e8f24c'); for (let k = 0; k < 3; k++) { const dx = bx - 16 - k * 22 + Math.sin(t * 3 + k) * 6; cachorro(c, dx, 210, pick(['#c98a43', '#2a2a2a', '#f2efe6'], k)); R(c, dx - 3, 210 - 9 + Math.round(Math.sin(t * 14 + k)), 4, 2, pick(['#c98a43', '#2a2a2a', '#f2efe6'], k)); } gente(c, pc + 10, 214, 6, false); } } // cachorros correndo atrás da bolinha
    for (let k = 0; k < 2; k++) { const x = PQ.PIC + 40 + k * 110 - camL; if (vis(x, 30)) { gente(c, x, 208, k + 5, false); gente(c, x + 14, 208, k + 8, false); R(c, x + 6, 200, 6, 6, pick(SKIN, k + 3)); } } // famílias no piquenique
    void nt; fog(c, s, t, camL, .16);
  }
  function parqueLights(g, s, t, camL) { const a = night(s); if (a < .05) return; for (let lx = 40; lx < PQ.W; lx += 260) lampGlow(g, lx - camL, 124, a); }

  /* =====================================================================
     34 · SERRA DO MARÇAL: mirante na beira da serra, vale lá embaixo, mar de nuvens, estrada em curvas e rampa de voo livre
     ===================================================================== */
  const MAR = { W: 2600, BARRACA: 700, CAMINHAO: 1080, RAMPA: 1600, CRUZ: 2020, TORRE: 2320 };
  const F34 = {};
  function buildVale() { // a planície lá embaixo: retalhos de plantação, rio, cidadezinhas, tudo azulado
    const [cv, c] = mk(T, LH), hz = 104;
    for (let y = hz; y < LH; y++) { const u = (y - hz) / (LH - hz); R(c, 0, y, T, 1, lerpC('#a8b8b4', '#7a9a6a', u)); }
    for (let r = 0; r < 18; r++) { const y = hz + 2 + r * r * .45, h = 1 + r * .6; for (let x = (r * 37) % 40, i = 0; x < T; i++) { const w = 12 + r * 4 + hash(i + r * 50) * 30; R(c, x, y, w, h, pick(['#8aa070', '#9aae78', '#7a9460', '#b0a878', '#a49868', '#88a87a'], i + r)); x += w + 1; } }
    for (let x = 0; x < T; x += 2) { const y = hz + 20 + Math.sin(x / T * TAU * 4) * 8 + Math.sin(x / T * TAU * 9) * 3; R(c, x, y, 2, 1, '#c8e0e8'); }
    for (let i = 0; i < 9; i++) { const x = hash(i + 340) * T, y = hz + 8 + hash(i + 341) * 40; for (let k = 0; k < 10; k++) R(c, x + hash(i * 9 + k) * 18, y + hash(i * 3 + k) * 5, 2, 1, '#f2efe6'); }
    nevoa(c, T, 'rgba(200,214,226,.35)'); return cv;
  }
  function buildEncostaSerra() { // a encosta descendo, a estrada em zigue-zague e as torres eólicas no alto
    const [cv, c] = mk(T, LH), ry = (x) => 166 + Math.sin(x / T * TAU * 2) * 10 + Math.sin(x / T * TAU * 6 + 1) * 4;
    for (let x = 0; x < T; x++) { const y = Math.round(ry(x)); for (let yy = y; yy < LH; yy += 2) R(c, x, yy, 1, 2, lerpC('#6a8a58', '#4a6a40', (yy - y) / 80)); R(c, x, y, 1, 1, '#8aa870'); }
    for (let i = 0; i < 300; i++) { const x = hash(i + 350) * T; ell(c, x, ry(x) + 6 + hash(i + 351) * 70, 2 + hash(i) * 4, 1.5 + hash(i * 3), pick(['#4f7a46', '#5a8a4e', '#3f6a3a'], i)); }
    const road = []; for (const x0 of [200, 860]) { let x = x0, y = ry(x0) + 3; const pts = [[x, y]]; for (let k = 0; k < 5; k++) { x += k % 2 ? -90 : 90; y += 7; pts.push([x, y]); } road.push(pts); for (let k = 1; k < pts.length; k++) { limb(c, [pts[k - 1], pts[k]], 3, '#5a5e62'); limb(c, [pts[k - 1], pts[k]], 1, '#8a8e90'); } }
    const TUR = []; for (const tx of [100, 380, 620, 1040, 1300]) { const ty = Math.round(ry(tx)) - 30; R(c, tx, ty - 46, 2, 46, '#e8ecef'); R(c, tx - 1, ty - 48, 4, 3, '#d8dce0'); TUR.push([tx, ty - 47]); }
    nevoa(c, T, 'rgba(204,218,228,.2)'); return { cv, road, TUR, f: .24 };
  }
  function buildMirante() {
    const W = MAR.W, [cv, c] = mk(W, LH);
    // borda da serra: rochas, capim dourado, cactos e a mureta do mirante com a defensa metálica
    for (let x = 0; x < W; x++) { const h = 14 + Math.sin(x * .02) * 4 + Math.sin(x * .07) * 2; R(c, x, 210 - h, 1, h, '#7a7058'); R(c, x, 210 - h, 1, 2, '#a89a78'); }
    for (let i = 0; i < W / 18; i++) A.rocha(c, hash(i + 3400) * W, 200 + hash(i + 3401) * 8, 8 + hash(i) * 14, 4 + hash(i * 3) * 4, i);
    for (let x = 0; x < W; x += 2) if (hash(x * .9) > .35) { const h = 5 + hash(x) * 10; limb(c, [[x, 202], [x + 2, 202 - h]], 1, x % 3 ? '#c8a858' : '#a88a40'); }
    for (let i = 0; i < 14; i++) A.cactus(c, 40 + hash(i + 3410) * (W - 80), 204);
    for (let x = 0; x < W; x += 3) { R(c, x, 196, 3, 3, '#c8ccd0'); R(c, x, 196, 3, 1, '#eef0f2'); R(c, x, 199, 3, 2, '#9aa0a6'); } for (let x = 6; x < W; x += 30) { R(c, x, 196, 3, 14, '#7a8086'); }
    // barraca de mel, requeijão e café
    const b = MAR.BARRACA; R(c, b, 150, 2, 60, '#6a4a32'); R(c, b + 98, 150, 2, 60, '#6a4a32'); for (let k = 0; k < 100; k++) R(c, b + k, 146 + Math.round(Math.sin(k / 100 * Math.PI) * -4), 1, 8, k % 10 < 5 ? '#e8833a' : '#f2e8d0');
    R(c, b + 4, 176, 92, 34, '#8a6a45'); R(c, b + 4, 176, 92, 3, '#c4955c'); for (let k = 0; k < 8; k++) { R(c, b + 8 + k * 11, 166, 8, 10, k % 2 ? '#e8a83a' : '#d89a2a'); R(c, b + 8 + k * 11, 164, 8, 2, '#f2efe6'); R(c, b + 9 + k * 11, 168, 2, 6, 'rgba(255,255,255,.4)'); } for (let k = 0; k < 4; k++) { ell(c, b + 20 + k * 18, 186, 6, 4, '#f6ecd0'); R(c, b + 14 + k * 18, 186, 12, 1, '#c8a46a'); }
    // caminhão baú parado
    const cm = MAR.CAMINHAO; R(c, cm, 140, 130, 58, '#e8e8e2'); R(c, cm, 140, 130, 3, '#ffffff'); R(c, cm + 6, 150, 118, 22, '#2c5a9e'); pxText(c, 'TRANSPORTES PLANALTO', cm + 65, 158, '#ffffff'); R(c, cm + 130, 160, 40, 38, '#c43c3a'); R(c, cm + 140, 164, 22, 14, '#9fc4d0'); R(c, cm + 166, 186, 6, 6, '#fff2b0'); R(c, cm, 196, 172, 4, '#3a3a36');
    for (const wx of [cm + 24, cm + 50, cm + 150]) { ell(c, wx, 203, 8, 8, '#1c1c1c'); ell(c, wx, 203, 4, 4, '#9aa0a6'); }
    // rampa de voo livre (estrutura de madeira avançando sobre o vale) com a biruta
    const r = MAR.RAMPA; for (let k = 0; k < 120; k++) R(c, r + k, 186 - k * .12, 1, 4, k % 8 ? '#a87a4a' : '#8a5a32'); for (let k = 0; k < 120; k += 20) R(c, r + k, 190 - k * .12, 2, 20 + k * .12, '#6a4a2a'); R(c, r + 100, 120, 2, 54, '#9aa0a6');
    // cruzeiro e torres de rádio
    const cz = MAR.CRUZ; R(c, cz, 120, 6, 84, '#6a4a32'); R(c, cz - 18, 138, 42, 6, '#6a4a32'); R(c, cz - 10, 200, 26, 6, '#8a8a80'); for (let k = 0; k < 5; k++) { R(c, cz - 8 + k * 6, 196, 2, 4, '#f6f2e8'); }
    const tw = MAR.TORRE; for (const dx of [0, 70]) { R(c, tw + dx, 30, 3, 176, '#c43c3a'); for (let y = 30; y < 206; y += 10) { R(c, tw + dx - 5, y, 13, 1, '#d8d8d0'); limb(c, [[tw + dx - 5, y], [tw + dx + 7, y + 10]], 1, '#d8d8d0'); } }
    terra(c, W, '#8a9a5a', '#6f7f48'); chaoDetalhe(c, W, 'natureza');
    return cv;
  }
  function serraMarcal(c, s, t, camL) {
    if (!F34.mid) { F34.vale = buildVale(); F34.enc = buildEncostaSerra(); F34.mid = buildMirante(); }
    const nt = night(s);
    sky(c, s, t, camL); tile(c, F34.vale, camL * .02);
    if (nt > .1) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = nt; for (let i = 0; i < 40; i++) R(c, ((hash(i + 9) * 600 - camL * .02) % LW + LW) % LW, 110 + hash(i * 3) * 50, 1, 1, '#ffd98a'); c.restore(); } // cidadezinhas acesas lá embaixo
    for (let L = 0; L < 2; L++) { c.save(); c.globalAlpha = .75 - L * .2; for (let i = 0; i < 14; i++) { const x = ((i * 97 + t * (3 + L * 2) - camL * (.05 + L * .05)) % 620 + 620) % 620 - 70, y = 134 + L * 14 + hash(i + L * 20) * 12; for (let k = 0; k < 5; k++) ell(c, x + k * 12, y - Math.abs(k - 2) * 3, 16, 7, lerpC('#f6f6f2', '#5a6a8a', nt)); } c.restore(); } // mar de nuvens
    tile(c, F34.enc.cv, camL * F34.enc.f);
    for (const pts of F34.enc.road) for (let i = 0; i < 3; i++) { const u = ((t * .015 + i * .33) % 1), n = pts.length - 1, k = Math.min(n - 1, Math.floor(u * n)), f = u * n - k, x = pts[k][0] + (pts[k + 1][0] - pts[k][0]) * f, y = pts[k][1] + (pts[k + 1][1] - pts[k][1]) * f, sx = scr(F34.enc, x, camL); if (!vis(sx, 10)) continue; const truck = i === 1; R(c, sx, y - 3, truck ? 7 : 4, truck ? 3 : 2, truck ? '#e8e8e2' : pick(['#c43c3a', '#3c6aa8', '#e8c24c'], i)); if (nt > .2) R(c, sx + (pts[k + 1][0] > pts[k][0] ? 5 : -1), y - 2, 2, 1, '#fff2b0'); } // carros e caminhões descendo a serra
    for (const [tx, ty] of F34.enc.TUR) { const sx = scr(F34.enc, tx, camL); if (!vis(sx, 20)) continue; for (let k = 0; k < 3; k++) { const a = t * 1.6 + k * TAU / 3 + tx; limb(c, [[sx + 1, ty], [sx + 1 + Math.cos(a) * 14, ty + Math.sin(a) * 14]], 1, '#f2f4f6'); } R(c, sx, ty - 1, 3, 3, '#d8dce0'); if (nt > .1 && Math.sin(t * 2.5 + tx) > .3) R(c, sx, ty - 2, 2, 1, '#ff4a3a'); } // torres eólicas girando
    drawMid(c, F34.mid, camL);
    // parapente: corre na rampa, decola e vai planando pro vale
    { const cyc = 24, ph = (t % cyc) / cyc, r = MAR.RAMPA; let x, y, voando = false; if (ph < .12) { x = r + ph / .12 * 110; y = 186 - (x - r) * .12; } else { voando = true; const u = (ph - .12) / .88; x = r + 110 + u * 340; y = 172 - Math.sin(u * 3) * 14 + u * 60; }
      const sx = x - camL; if (vis(sx, 60)) { if (voando) { for (let k = -7; k <= 7; k++) R(c, sx + k * 2, y - 26 - Math.round(Math.sqrt(1 - (k / 8) ** 2) * 4), 2, 3, k % 2 ? '#3c8ad8' : '#f2c94c'); limb(c, [[sx - 13, y - 24], [sx, y - 6]], 1, 'rgba(60,60,60,.7)'); limb(c, [[sx + 13, y - 24], [sx, y - 6]], 1, 'rgba(60,60,60,.7)'); R(c, sx - 2, y - 7, 5, 6, '#c43c3a'); R(c, sx - 1, y - 10, 3, 3, '#f2efe6'); }
        else { const f = Math.floor(t * 10) % 2; R(c, sx - 2, y - 12, 5, 7, '#c43c3a'); R(c, sx - 1, y - 15, 4, 3, '#f2efe6'); R(c, sx - 2, y - 5, 1, 4 + f, '#2a2f3a'); R(c, sx + 2, y - 5, 1, 5 - f, '#2a2f3a'); for (let k = 0; k < 10; k++) R(c, sx - 14 - k * 2, y - 4 - k * .5, 2, 2, k % 2 ? '#3c8ad8' : '#f2c94c'); } } }
    { const x = MAR.RAMPA + 102 - camL, sw = Math.sin(t * 4) * 1.5; if (vis(x, 30)) for (let k = 0; k < 6; k++) R(c, x + 2 + k * 4, 120 + k * .3 + sw * k * .3, 4, 5 - k * .5, k % 2 ? '#f2f2ee' : '#f08a24'); } // biruta
    { const x = MAR.CAMINHAO + 180 - camL; if (vis(x, 30)) { gente(c, x, 208, 6, false); R(c, x - 6, 196, 8, 4, '#e8e2d0'); for (let i = 0; i < 3; i++) { const q = (t * .5 + i / 3) % 1; R(c, x - 3 + Math.sin(t + i) * 2, 192 - q * 12, 2, 2, `rgba(240,240,236,${1 - q})`); } } } // caminhoneiro com a marmita
    { const x = MAR.BARRACA + 50 - camL; if (vis(x, 60)) { ell(c, x, 172, 4, 4, '#c88a60'); R(c, x - 4, 176, 8, 8, '#7a3a8a'); R(c, x - 5, 168, 10, 2, '#d8b878'); if ((t % 9) < 2.5) balao(c, x, 164, 'MEL DE ABELHA DA SERRA!'); } }
    for (let i = 0; i < 6; i++) { const k = (t * .4 + i / 6) % 1, x = ((i * 89 + t * 60) % 560) - 40, y = 60 + i * 22 + Math.sin(t + i) * 6; R(c, x, y, 10 + k * 6, 1, 'rgba(255,255,255,.35)'); } // vento
    fog(c, s, t * 2, camL, .45);
  }
  function serraMarcalLights(g, s, t, camL) { const a = night(s); if (a < .05) return; const tw = MAR.TORRE - camL; if (vis(tw, 100) && Math.sin(t * 3) > 0) { lightAdd(tw + 1, 30, a, 30); lightAdd(tw + 71, 30, a, 30); } const cz = MAR.CRUZ - camL; if (vis(cz, 30)) lightAdd(cz + 3, 196, .5 * a, 26); }

  /* ---------- plataformas ---------- */
  const PLAT = {
    deque: (c, x, y, w, t, sd) => { sombra(c, x, y, w); Q(c, x - 2, y - 2, w + 4, 16, '#4a2e18'); for (let k = 0; k < w; k += 10) { Q(c, x + k, y, 8, 12, k % 20 ? '#a87a4a' : '#9a6a3e'); Q(c, x + k, y, 8, 2, '#c8985a'); } for (const px of [x + 8, x + w - 14]) { Q(c, px, y + 12, 6, 30, '#6a4a2a'); for (let k = 0; k < 4; k++) Q(c, px - 1 + Math.sin(t * 2 + k) * 1, y + 30 + k * 4, 8, 2, 'rgba(160,210,220,.4)'); } },
    brinquedo: (c, x, y, w, t, sd) => { sombra(c, x, y, w); const col = pick(['#e8433a', '#3c8ad8', '#e8c24c', '#3c8a5a'], sd); Q(c, x - 2, y - 2, w + 4, 18, '#2a2a2a'); Q(c, x, y, w, 14, col); Q(c, x, y, w, 2, shadeHex(col, 1.35)); for (let k = 6; k < w - 6; k += 12) { Q(c, x + k, y + 4, 6, 6, shadeHex(col, .8)); } for (const px of [x + 6, x + w - 12]) Q(c, px, y + 14, 6, 26, pick(['#e8c24c', '#3c8ad8'], sd + px)); for (let k = 0; k < w; k += 8) Q(c, x + k, y - 8, 2, 8, '#f2efe6'); Q(c, x, y - 10, w, 2, '#f2efe6'); }
  };

  /* ---------- registro ---------- */
  const REG = CC.registrar;
  REG({ id: 32, key: 'lagoa', nome: 'Lagoa das Bateias', lugar: 'Pista de caminhada, píer, pedalinhos e garças', grupo: 'novo', width: LAG.W * 2, draw: lagoa, lights: lagoaLights, vao: N.vaoAgua, plat: PLAT.deque,
    labels: [[LAG.PIER + 30, 166, 'PÍER', 5, '#5a3a20'], [LAG.QUIOSQUE + 48, 128, 'QUIOSQUE DA LAGOA', 6, '#5a3a20'], [1300, 88, 'LAGOA DAS BATEIAS', 10, '#f2f2e6']],
    interact: [['pot', 300], ['pot', 3800], ['trash', 1500], ['trash', 4300], ['ball', 2500], ['bucket', 1900], ['crate', 2800], ['crate', 2828, 1], ['puddle', 4600, 80], ['grass', 600, 200], ['lever', 4000, 'sprinkler']] },
    { platforms: [[800, 384, 150], [990, 328, 140], [2200, 384, 150], [3270, 384, 220], [3900, 384, 150], [4090, 328, 140], [4280, 272, 140]], gaps: [[3300, 160]] });
  REG({ id: 33, key: 'parque', nome: 'Parque da Cidade', lugar: 'Parquinho, pista de skate, dominó, piquenique e o parcão', grupo: 'novo', width: PQ.W * 2, draw: parque, lights: parqueLights, plat: PLAT.brinquedo,
    labels: [[PQ.PLAY + 190, 110, 'PARQUINHO', 6, '#ffffff'], [PQ.SKATE + 180, 140, 'PISTA DE SKATE', 6, '#2a2a2a'], [PQ.IDOSOS + 60, 160, 'ACADEMIA DA TERCEIRA IDADE', 4, '#2a2a2a'], [PQ.IDOSOS + 200, 178, 'DOMINÓ', 4, '#2a2a2a']],
    interact: [['ball', 900], ['ball', 4100], ['ball', 4300], ['fountain', 2400], ['trash', 1700], ['trash', 3500], ['pot', 2900], ['crate', 3300], ['grass', 3700, 180], ['puddle', 2100, 70], ['lever', 2700, 'party']] },
    { platforms: [[400, 384, 150], [590, 328, 140], [1500, 384, 150], [1690, 328, 140], [1880, 272, 140], [3100, 384, 150], [4500, 384, 150]], gaps: [] });
  REG({ id: 34, key: 'serra-marcal', nome: 'Serra do Marçal', lugar: 'Mirante, rampa de voo livre e a estrada descendo a serra', grupo: 'novo', width: MAR.W * 2, draw: serraMarcal, lights: serraMarcalLights, plat: (c, x, y, w, t) => CC.plataforma(c, 15, [x, y, w], t),
    labels: [[MAR.BARRACA + 50, 141, 'MEL · REQUEIJÃO · CAFÉ', 5, '#5a3a20'], [MAR.RAMPA + 60, 170, 'RAMPA DE VOO LIVRE', 5, '#f2efe6'], [400, 186, 'MIRANTE DA SERRA DO MARÇAL · 1.000 m', 5, '#f2efe6']],
    interact: [['grass', 300, 260], ['grass', 2600, 240], ['grass', 4400, 260], ['hay', 1800], ['crate', 1500], ['crate', 1528, 1], ['bucket', 3500], ['tire', 2400], ['fence', 3800, 90], ['barrel', 2700]] },
    { platforms: [[600, 384, 150], [790, 320, 140], [980, 256, 140], [2700, 384, 150], [2890, 320, 140], [3700, 384, 150], [3890, 320, 140], [4080, 256, 130]], gaps: [[3400, 200]] });

  const CAMS = window.CampanhaCamadas;
  CAMS.configurar(32, { povo: 18, fgLista: ['capim', 'flores', 'arbusto', 'capim'] }); CAMS.configurar(33, { povo: 24, fgLista: ['flores', 'arbusto', 'bike', 'flores', 'sacos'] }); CAMS.configurar(34, { povo: 5, trilha: true, fgLista: ['capim', 'pedra', 'capim', 'pedra'] });
  const PL = window.CampanhaPlantas; if (PL?.adicionar) { PL.adicionar(32, [['capim', 200, 160], ['flores', 1300, 120], ['capim', 2600, 140], ['flores', 4200, 120]]); PL.adicionar(33, [['flores', 1000, 140], ['floreira', 2200, 100], ['flores', 3000, 160], ['capim', 4200, 120]]); PL.adicionar(34, [['capim', 400, 200], ['cacto', 1300, 90], ['capim', 2200, 220], ['cacto', 3200, 90], ['capim', 4300, 200]]); }
  N.b = true;
})();
