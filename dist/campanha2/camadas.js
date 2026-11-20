/* Campanha 2 · Passo 2B: camadas de profundidade dos cenários 12 a 21 (o shopping já tem as dele).
   Cada cenário ganha:
   - MEIO: uma faixa entre a cidade lá longe e a rua do Da Roça, com parallax próprio (rua de trás com lojas,
     encosta com casinhas, cafezal, serra com trilha, roda-gigante do Festival de Inverno...), gente andando,
     carros, letreiros que piscam e janelas acesas à noite;
   - SOBRE: detalhes no mesmo plano das fachadas (letreiros das lojas paródia, gente nas janelas, feirantes);
   - FRENTE: mais população andando na calçada (não interativa) e o ENGARRAFAMENTO aleatório;
   - PRIMEIRO PLANO: coisas bem perto da câmera, na beirada de baixo, que passam mais rápido que o chão.
   As lojas são paródias de lojas reais (só o nome brinca com o original; nada de logotipo).
   O engarrafamento (Avenida e Centro, 40% de chance a cada chegada) apresenta Cleiton, motorista do Ubé,
   e a sogra dele, Dona Rosilda, presos atrás do Fusca do Seu Arlindo, que parou pra comprar biscoito.
   Nada aqui muda a jogabilidade: nada é sólido e nada interage. */
(() => {
  'use strict';
  if (window.CampanhaCamadas || !window.CampanhaCenarios?.arte) return;
  const A = window.CampanhaCenarios.arte;
  const { R, ell, mk, hash, cl, limb, tile, vis, night, shadeHex, pick, lightAdd, vgrad, reflexo, gente, pessoa, roofTiles, cachorro, GY } = A;
  const LW = 482, LH = 270, T = 1440;
  const wrap = (v, W = T) => ((v % W) + W) % W;
  const HERO = () => A.heroiPos();
  const TAU = Math.PI * 2;

  /* ---------- fonte pixel 3x5 (letreiros, placas e balões de fala) ---------- */
  const G = {
    A: '010101111101101', B: '110101110101110', C: '011100100100011', D: '110101101101110', E: '111100110100111', F: '111100110100100', G: '011100101101011',
    H: '101101111101101', I: '111010010010111', J: '001001001101010', K: '101101110101101', L: '100100100100111', M: '101111111101101', N: '110101101101101',
    O: '010101101101010', P: '110101110100100', Q: '010101101110011', R: '110101110101101', S: '011100010001110', T: '111010010010010', U: '101101101101111',
    V: '101101101101010', W: '101101111111101', X: '101101010101101', Y: '101101010010010', Z: '111001010100111',
    0: '111101101101111', 1: '010110010010111', 2: '110001010100111', 3: '110001010001110', 4: '101101111001001', 5: '111100110001110', 6: '011100111101111',
    7: '111001010010010', 8: '111101111101111', 9: '111101111001110', '&': '010101010101011', '.': '000000000000010', ',': '000000000010100', '!': '010010010000010',
    '-': '000000111000000', "'": '010010000000000', '°': '010101010000000', '%': '101001010100101', '/': '001001010100100', '+': '000010111010000',
    ':': '000010000010000', '?': '110001010000010', '$': '011110010011110', '#': '101111101111101', '(': '010100100100010', ')': '010001001001010'
  };
  const limpa = (s) => String(s).normalize('NFD').replace(/[̀-ͯ]/g, '').toUpperCase();
  function pxText(c, str, x, y, col, o = {}) {
    const s = limpa(str), sc = o.s || 1, w = s.length * 4 * sc - sc;
    const x0 = Math.round(o.align === 'left' ? x : o.align === 'right' ? x - w : x - w / 2);
    if (o.sombra) pxText(c, s, x0 + sc, y + sc, o.sombra, { s: sc, align: 'left' });
    c.fillStyle = col; let xx = x0;
    for (const ch of s) { const g = G[ch]; if (g) for (let i = 0; i < 15; i++) if (g[i] === '1') c.fillRect(xx + (i % 3) * sc, Math.round(y) + Math.floor(i / 3) * sc, sc, sc); xx += 4 * sc; }
    return w;
  }
  const largura = (s, sc = 1) => limpa(s).length * 4 * sc - sc;

  /* ---------- paródias de lojas e propagandas ---------- */
  // [nome, cor do letreiro, cor da letra]
  const LOJAS_RUA = [
    ['CASAS BAIXA', '#1d4ab8', '#ffffff'], ['PAGUE MAIS', '#2c8a3a', '#ffffff'], ['ESCURO CELULARES', '#c43c3a', '#ffffff'], ['RICARDO ELETRICO', '#d84a2a', '#fff6d0'],
    ['INSISTENTE', '#7a2a8a', '#ffffff'], ['OTICA DIZ-QUE-VE', '#2a2a2a', '#f2c94c'], ['LOTERICA SORTE GRANDE', '#2c5a9e', '#f2c94c'], ['C&A', '#2c6ab8', '#ffffff'],
    ['PERNAMBUCRANAS', '#3c7a4a', '#ffffff'], ['RAVAIANAS', '#f2c94c', '#2a2a2a'], ['DROGARIA SAO PAULINHO', '#c43c3a', '#ffffff'], ['HABIBIS', '#e8833a', '#ffffff'],
    ["BOBO'S", '#c43c3a', '#f2c94c'], ['CHILLI BEICO', '#2a2a2a', '#e8433a'], ['NATURRA', '#c47a35', '#fff6d0'], ['POLISHOPE', '#1c1c24', '#5ae0d0'], ['KALUNGO', '#2c5a9e', '#f2c94c'],
    ['BANCO DO BRASIU', '#f2c94c', '#1d3a8a'], ['RENE', '#2a2a2a', '#ffffff'], ['SUBUAI', '#2c8a3a', '#f2c94c'], ['BURGUER QUINGUE', '#d8642a', '#fff6d0'], ['STARBUCHO CAFE', '#1f6a4a', '#ffffff'],
    ['ATACAREJAO', '#c43c3a', '#f2c94c'], ['G. BARBUDA', '#e8833a', '#ffffff'], ['SMART FAT', '#f2c94c', '#2a2a2a'], ['MAGAZINE LURDES', '#2c6ab8', '#ffffff'], ['AMENICANAS', '#c43c3a', '#ffffff']
  ];
  const OUTDOORS = [
    ['NETFLIQUIS', '#1c1c1c', '#e8433a'], ['CASAS BAIXA: QUER PAGAR QUANTO?', '#1d4ab8', '#ffffff'], ['ESCURO 5G: SINAL? TALVEZ', '#c43c3a', '#ffffff'], ['SMART FAT: VEM SUAR', '#f2c94c', '#2a2a2a'],
    ['BISCOITO DA SERRA', '#c47a35', '#fff6d0'], ['UBE: CHEGA QUANDO DER', '#1c1c1c', '#ffffff'], ['PAGUE MAIS: E PAGUE MESMO', '#2c8a3a', '#ffffff'], ['FESTIVAL DE INVERNO', '#2c3a6a', '#f2c94c'],
    ['CAFE DO PLANALTO', '#5a3420', '#f2e8c8'], ['COMPRE UM CASACO', '#3c6aa8', '#ffffff']
  ];
  const SKIN = ['#e0b08a', '#9a6440', '#c88a60', '#6a4430', '#f0c8a8'], ROUPA = ['#3a4a6a', '#7a3a3a', '#4a6a4a', '#5a4a6a', '#c47a35', '#2a3a4a', '#d84a7a', '#e8c24c', '#3c8ad8', '#f2efe6'];
  const CURT = ['#e8d8a8', '#c9d8e8', '#e8c4c4', '#d4e8c8', '#f2efe6', '#c8b8d8'];

  /* ---------- peças da camada do meio (escala menor: andar de 11 px) ---------- */
  function pessoinha(c, x, y, i, t, anda = true) { // gente da rua de trás (10 px)
    const sh = ROUPA[i % ROUPA.length], sk = SKIN[i % SKIN.length], f = anda ? Math.floor(t * 5 + i * .7) % 2 : 0; x = Math.round(x);
    R(c, x, y - 3, 1, 3 - f, '#2a2f3a'); R(c, x + 2, y - 3, 1, 2 + f, '#2a2f3a'); R(c, x, y - 7, 3, 4, sh); R(c, x + 2, y - 7, 1, 4, shadeHex(sh, .75)); R(c, x, y - 9, 3, 2, sk); R(c, x, y - 10, 3, 1, pick(['#2a201a', '#1a1a1a', '#6a4a2a', '#c8a050'], i));
    if (i % 4 === 1) R(c, x + 3, y - 5, 2, 3, pick(['#c43c3a', '#2c5a9e', '#e8c24c'], i)); // sacola
  }
  function carrinho(c, x, y, col, dir = 1) { // carro da rua de trás
    x = Math.round(x); R(c, x, y - 5, 15, 3, col); R(c, x + (dir > 0 ? 3 : 4), y - 8, 8, 3, col); R(c, x + (dir > 0 ? 4 : 5), y - 7, 6, 2, '#9fc4d0'); R(c, x + 2, y - 2, 3, 2, '#1c1c1c'); R(c, x + 10, y - 2, 3, 2, '#1c1c1c'); R(c, dir > 0 ? x + 14 : x, y - 5, 1, 1, '#fff2b0');
  }
  function janelaM(c, n, x, y, seed, aceso = .58) {
    R(c, x - 1, y - 1, 6, 8, '#3a3a36'); vgrad(c, x, y, 4, 6, '#a4c4d0', '#5f8496');
    if (hash(seed) > .55) R(c, x, y, 1, 6, pick(CURT, seed)); if (hash(seed * 1.3) > .85) R(c, x + 1, y + 4, 2, 2, pick(['#4f8a3a', '#e86a7a'], seed));
    if (n && hash(seed * 1.7 + 3) > aceso) R(n, x, y, 4, 6, pick(['#ffd98a', '#ffe6b0', '#fff2d0', '#a8c8ff'], seed));
    R(c, x - 1, y + 6, 6, 1, '#d8d2c0');
  }
  function lojaM(c, n, x, w, base, L, seed, pos) { // térreo da rua de trás: letreiro com o nome, toldo e vitrine
    const [nome, cor, letra] = L, y = base - 16;
    R(c, x, y, w, 16, '#e8e2d2'); R(c, x + 1, y, w - 2, 8, '#1c1f24'); vgrad(c, x + 2, y + 1, w - 4, 6, shadeHex(cor, 1.15), shadeHex(cor, .85)); pxText(c, nome, x + w / 2, y + 2, letra);
    for (let k = 0; k < w; k += 4) { R(c, x + k, y + 8, Math.min(4, w - k), 3, (k / 4) % 2 ? cor : '#f2efe6'); } R(c, x, y + 11, w, 1, 'rgba(0,0,0,.25)');
    R(c, x + 2, y + 11, w - 4, 5, '#3c4c58'); R(c, x + 3, y + 12, w - 6, 4, '#9fc0cc'); for (let k = 0; k < (w - 10) / 5; k++) R(c, x + 5 + k * 5, y + 13, 3, 3, pick(['#d9634a', '#e8c24c', '#5f9fd0', '#7cbf6a', '#c86ab8', '#f2efe6'], seed + k));
    R(c, x + Math.round(w / 2) - 2, y + 11, 4, 5, '#2a2c30');
    if (n) { n.save(); n.globalAlpha = .55; R(n, x + 2, y + 1, w - 4, 6, cor); n.globalAlpha = 1; pxText(n, nome, x + w / 2, y + 2, '#fff6dc'); R(n, x + 3, y + 12, w - 6, 4, 'rgba(255,226,170,.8)'); n.restore(); }
    if (pos) pos.push({ nome, x, w, y, cor });
  }
  function outdoorM(c, n, x, top, L, w = 0) { // outdoor no telhado
    const [txt, bg, fg] = L, ww = w || largura(txt) + 10; R(c, x + 4, top - 4, 2, 4, '#5a5e62'); R(c, x + ww - 6, top - 4, 2, 4, '#5a5e62');
    R(c, x, top - 16, ww, 12, '#2a2f34'); R(c, x + 1, top - 15, ww - 2, 10, bg); R(c, x + 1, top - 15, ww - 2, 1, shadeHex(bg, 1.3)); pxText(c, txt, x + ww / 2, top - 12, fg);
    for (let k = 4; k < ww; k += 10) R(c, x + k, top - 18, 1, 2, '#5a5e62');
    if (n) { n.save(); n.globalAlpha = .4; R(n, x + 1, top - 15, ww - 2, 10, bg); n.globalAlpha = .9; pxText(n, txt, x + ww / 2, top - 12, fg); n.restore(); }
    return ww;
  }
  function predioM(c, n, x, w, floors, col, seed, base, o = {}) {
    const fh = 11, lh = o.loja ? 16 : 0, top = base - lh - floors * fh;
    R(c, x, top, w, base - top, col); for (let i = 0; i < w * (base - top) / 14; i++) R(c, x + hash(i * 3.1 + seed) * w, top + hash(i * 7.7 + seed) * (base - top), 1, 1, i % 2 ? shadeHex(col, 1.05) : shadeHex(col, .92));
    R(c, x, top, w, 2, shadeHex(col, 1.15)); R(c, x + w - 2, top, 2, base - top, shadeHex(col, .8)); R(c, x - 1, top - 2, w + 2, 2, shadeHex(col, .72));
    for (let f = 0; f < floors; f++) {
      const yy = top + f * fh + 3, nW = Math.max(1, Math.floor((w - 4) / 7));
      if (o.vidro) { vgrad(c, x + 2, yy - 2, w - 6, fh - 2, '#9cc0d2', '#4f7488'); R(c, x + 2, yy + fh - 4, w - 6, 1, '#2f4450'); for (let k = 0; k < nW; k++) { R(c, x + 2 + k * 7, yy - 2, 1, fh - 2, '#3f5a68'); if (n && hash(seed + f * 7 + k) > .55) R(n, x + 3 + k * 7, yy - 1, 5, fh - 4, pick(['#ffe6b0', '#fff2d0', '#cfe0ff'], k + f)); } continue; }
      for (let k = 0; k < nW; k++) { const wx = Math.round(x + 3 + k * ((w - 6) / nW)); janelaM(c, n, wx, yy, seed * 13 + f * 7 + k); if (hash(seed + f * 5 + k) > .84) { R(c, wx + 5, yy + 3, 3, 2, '#d8dcdc'); R(c, wx + 6, yy + 5, 1, 2, '#7a7e80'); } }
      if (o.sacada && f % 2 === 1) { R(c, x + 1, yy + 7, w - 4, 1, '#3a3a36'); for (let k = 1; k < w - 4; k += 2) R(c, x + 1 + k, yy + 5, 1, 2, '#3a3a36'); }
      R(c, x, yy + fh - 3, w, 1, shadeHex(col, .88));
    }
    if (o.vidro) reflexo(c, x + 2, top + 2, w - 6, floors * fh - 2);
    if (hash(seed + 31) > .35) { const cx = x + 3 + Math.round(hash(seed + 32) * Math.max(0, w - 12)); R(c, cx, top - 7, 8, 5, '#3c6aa8'); R(c, cx, top - 7, 8, 1, '#6a9ad0'); R(c, cx + 1, top - 2, 1, 2, '#5a5a56'); R(c, cx + 6, top - 2, 1, 2, '#5a5a56'); }
    if (hash(seed + 34) > .5) { R(c, x + w - 5, top - 11, 1, 9, '#6a6a66'); for (let k = 0; k < 3; k++) R(c, x + w - 7 + k, top - 10 + k * 2, 5 - k * 2, 1, '#6a6a66'); }
    if (n && hash(seed + 35) > .6) R(n, x + w - 5, top - 12, 1, 1, '#ff4a3a');
    if (o.loja) lojaM(c, n, x, w, base, o.loja, seed, o.pos);
    return top;
  }
  function arvoreM(c, x, base, seed, s = 1) { R(c, x, base - 12 * s, 2, 12 * s, '#5a4232'); for (let k = 0; k < 7; k++) ell(c, x + 1 + (hash(seed + k) - .5) * 10 * s, base - 14 * s - hash(seed * 3 + k) * 8 * s, 4 * s, 3.5 * s, k % 3 ? '#4f7a46' : '#6a9a52'); }
  function nevoa(c, W, col) { c.save(); c.globalCompositeOperation = 'source-atop'; c.fillStyle = col; c.fillRect(0, 0, W, LH); c.restore(); }

  // rua de trás com prédios, lojas paródia, calçada, árvores e postes
  function buildRua(cfg) {
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH), base = cfg.base, pos = [], tops = [];
    let x = 4, i = 0, li = cfg.lojaIni || 0, oi = cfg.outIni || 0;
    while (x < T - 30) {
      const L = hash(i * 3 + cfg.seed) < cfg.lojaChance ? cfg.lojas[li++ % cfg.lojas.length] : null;
      const w = Math.max(L ? largura(L[0]) + 8 : 20, cfg.w[0] + Math.round(hash(i + cfg.seed) * (cfg.w[1] - cfg.w[0])));
      if (x + w > T - 6) break;
      const floors = cfg.f[0] + Math.round(Math.pow(hash(i * 7 + cfg.seed), 1.3) * (cfg.f[1] - cfg.f[0]));
      const top = predioM(c, n, x, w, floors, pick(cfg.pal, i + cfg.seed), cfg.seed + i * 11, base, { loja: L, vidro: cfg.vidro && hash(i + 9 + cfg.seed) > .5, sacada: hash(i + 5) > .5, pos });
      tops.push({ x, w, top });
      if (cfg.outdoors && i % cfg.outdoors === 2 && w > 30) outdoorM(c, n, x + 2, top - 2, OUTDOORS[(oi++ + cfg.seed) % OUTDOORS.length]);
      x += w + (cfg.gap ?? 2) + (cfg.gapR ? Math.round(hash(i * 17 + cfg.seed) * cfg.gapR) : 0); i++;
    }
    R(c, 0, base, T, 4, '#cfc8b6'); R(c, 0, base, T, 1, '#e6e0d0'); R(c, 0, base + 3, T, 1, '#8a8478');
    if (cfg.rua) { R(c, 0, base + 4, T, 10, '#6a6e72'); for (let k = 0; k < T; k += 16) R(c, k, base + 9, 8, 1, '#e8dc8a'); }
    for (let k = 30; k < T; k += 120) { R(c, k, base - 26, 1, 26, '#6a6a66'); R(c, k - 3, base - 27, 5, 2, '#5a5a56'); if (n) { R(n, k - 3, base - 25, 5, 1, '#fff2c0'); n.save(); n.globalAlpha = .25; ell(n, k, base - 14, 9, 12, '#ffe6a0'); n.restore(); } }
    for (let k = 0; k < T; k += 40 + Math.round(hash(k) * 70)) if (k % 120 > 12) arvoreM(c, k, base + 1, k);
    nevoa(c, T, cfg.nevoa || 'rgba(200,214,226,.16)');
    return { cv, nv, base, pos, tops, f: cfg.par || .4, rua: cfg.rua, gente: cfg.gente ?? 22 };
  }
  function noiteTile(c, s, img, off, k = 1) { const a = night(s) * k; if (a < .03 || !img) return; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = a; tile(c, img, off); c.restore(); }
  function andaRua(c, M, s, t, camL) { // gente e carros da rua de trás
    const f = M.f;
    for (let i = 0; i < M.gente; i++) { const dir = i % 2 ? 1 : -1, wx = wrap(hash(i * 5 + M.base) * T + t * (5 + (i % 4) * 1.6) * dir), sx = wrap(wx - camL * f); for (const xx of [sx, sx - T]) if (xx > -6 && xx < LW + 6) pessoinha(c, xx, M.base + 2, i, t); }
    if (M.rua) for (let i = 0; i < 7; i++) { const dir = i % 2 ? 1 : -1, wx = wrap(i * 211 + t * (22 + (i % 3) * 8) * dir), sx = wrap(wx - camL * f); for (const xx of [sx, sx - T]) if (xx > -20 && xx < LW + 20) carrinho(c, xx, M.base + (dir > 0 ? 9 : 13), pick(['#c43c3a', '#f2f2ee', '#3c6aa8', '#2a2a2a', '#9aa0a6', '#e8c24c'], i), dir); }
  }
  const scr = (M, wx, camL) => { const sx = wrap(wx - camL * M.f); return sx > T - 60 ? sx - T : sx; };

  /* =====================================================================
     MEIO de cada cenário
     ===================================================================== */
  const MEIO = {};
  const lazy = (id, fn) => MEIO[id] || (MEIO[id] = fn());

  // 12 · pátio dos aviões, visto pelas vidraças: hangar, torre, aviões parados e carrinhos de bagagem
  function buildPatio() {
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH), b = 132;
    R(c, 0, b - 2, T, 3, '#9aa2a6'); R(c, 0, b + 1, T, LH - b, '#7f878c');
    for (const hx of [80, 760]) { for (let k = 0; k < 90; k++) { const h = Math.round(Math.sqrt(1 - ((k - 45) / 45) ** 2) * 14); R(c, hx + k, b - 26 - h, 1, 26 + h, k % 6 ? '#c8ccd0' : '#a8b0b4'); } R(c, hx + 14, b - 22, 62, 22, '#2a3036'); R(c, hx + 22, b - 12, 40, 6, '#e8ecef'); R(c, hx + 56, b - 16, 6, 8, '#3c6aa8'); pxText(c, 'HANGAR ' + (hx > 400 ? 2 : 1), hx + 45, b - 36, '#5a6066'); }
    const tw = 420; R(c, tw, b - 60, 8, 60, '#d8d4cc'); R(c, tw + 6, b - 60, 2, 60, '#b0aca4'); R(c, tw - 5, b - 72, 18, 12, '#2c4a5a'); R(c, tw - 4, b - 71, 16, 8, '#7ac0d0'); R(c, tw - 6, b - 74, 20, 2, '#d8d4cc'); R(c, tw + 3, b - 82, 1, 8, '#6a6a66'); R(n, tw - 4, b - 71, 16, 8, '#bfe8f2'); R(n, tw + 3, b - 83, 1, 1, '#ff4a3a');
    const aviao = (x, s, col) => { R(c, x, b - 12 * s, 60 * s, 7 * s, '#f2f4f6'); R(c, x + 58 * s, b - 11 * s, 6 * s, 5 * s, '#e8ecef'); R(c, x - 4 * s, b - 22 * s, 7 * s, 12 * s, col); R(c, x + 18 * s, b - 6 * s, 24 * s, 2 * s, '#c9ced2'); for (let k = 0; k < 10; k++) R(c, x + 8 * s + k * 5 * s, b - 10 * s, 2 * s, 2 * s, '#3c4a5a'); R(c, x, b - 7 * s, 60 * s, 1, col); R(c, x + 14 * s, b - 4 * s, 2, 4 * s, '#5a5a56'); R(c, x + 44 * s, b - 4 * s, 2, 4 * s, '#5a5a56'); };
    aviao(230, 1, '#c43c3a'); aviao(1000, 1.2, '#2c8a5a'); aviao(1260, .8, '#3c6aa8');
    for (const fx of [600, 1180]) { R(c, fx, b - 10, 22, 10, '#e8ecef'); R(c, fx, b - 10, 22, 1, '#ffffff'); ell(c, fx, b - 5, 3, 5, '#d8dce0'); ell(c, fx + 22, b - 5, 3, 5, '#d8dce0'); pxText(c, 'JET-A', fx + 11, b - 8, '#c43c3a'); }
    for (let k = 0; k < T; k += 60) { R(c, k, b - 30, 1, 30, '#8a949a'); R(c, k - 2, b - 31, 5, 2, '#5a5e62'); R(n, k - 2, b - 30, 5, 1, '#fff2c0'); }
    for (let k = 0; k < T; k += 8) R(c, k, b + 6, 4, 1, '#e8c24c');
    nevoa(c, T, 'rgba(205,218,228,.2)');
    return { cv, nv, base: b, f: .3, gente: 0, pos: [] };
  }
  function meioPatio(c, s, t, camL) {
    const M = lazy(12, buildPatio); tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f);
    { const sx = scr(M, wrap(t * 18), camL); R(c, sx, 146, 8, 4, '#e8c24c'); R(c, sx + 5, 143, 3, 3, '#2a2a2a'); for (let k = 0; k < 3; k++) { R(c, sx - 10 - k * 10, 146, 8, 3, '#3c6aa8'); R(c, sx - 9 - k * 10, 143, 6, 3, pick(['#c43c3a', '#e8c24c', '#4a8a5a'], k)); } } // trem de bagagem
    { const sx = scr(M, wrap(900 - t * 26), camL); R(c, sx, 145, 10, 4, '#f2c94c'); R(c, sx + 2, 142, 5, 3, '#2a2a2a'); if (Math.sin(t * 8) > 0) R(c, sx + 4, 141, 2, 1, '#f08a24'); pxText(c, 'SIGA-ME', sx + 5, 136, '#f2c94c'); }
    { const ph = (t / 60) % 1, sx = scr(M, 300 + ph * 900, camL); R(c, sx, 140, 30, 5, '#f2f4f6'); R(c, sx - 3, 134, 4, 7, '#e8833a'); R(c, sx + 10, 143, 12, 1, '#c9ced2'); }
    { const sx = scr(M, 296, camL), up = Math.sin(t * 3) > 0; R(c, sx, 141, 2, 8, '#f08a24'); R(c, sx - 2, up ? 140 : 143, 2, 1, '#ff6a3a'); R(c, sx + 2, up ? 143 : 140, 2, 1, '#ff6a3a'); } // sinaleiro com as varetas
  }

  // 13 · a encosta do bairro: casinhas em degraus, escadarias, igrejinha e campinho de terra
  function buildEncosta() {
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH);
    const hy = (x) => 120 + Math.sin(x / T * TAU * 2) * 14 + Math.sin(x / T * TAU * 7 + 1) * 6 + Math.sin(x / T * TAU * 19) * 2;
    for (let x = 0; x < T; x++) { const y = Math.round(hy(x)); for (let yy = y; yy < 206; yy += 2) R(c, x, yy, 1, 2, A.lerpC('#8aa462', '#6f8a4c', (yy - y) / 90)); R(c, x, y, 1, 1, '#a8c07a'); }
    for (let i = 0; i < 900; i++) R(c, hash(i + 70) * T, hy(hash(i + 70) * T) + 3 + hash(i + 71) * 70, 2, 1, i % 2 ? '#7a9456' : '#9ab46a');
    const COR = ['#f2c4c4', '#f2e2a8', '#c8dcf0', '#d4ecc8', '#f6f2e8', '#e8c8e8', '#f0d0a0', '#c8e8e0'];
    for (let r = 0; r < 4; r++) for (let x = 6 + r * 7, i = 0; x < T - 30; i++) {
      const w = 12 + Math.round(hash(i * 3 + r * 50) * 12), h = 9 + Math.round(hash(i * 5 + r * 50) * 5), cx = x + w / 2, bse = Math.round(hy(cx) + 10 + r * 18);
      if (hash(i * 7 + r * 31) < .18 || bse > 200) { arvoreM(c, x + 6, bse, i + r * 40, .9); x += w + 6; continue; }
      const col = pick(COR, i + r * 9); R(c, x, bse - h, w, h, col); R(c, x + w - 2, bse - h, 2, h, shadeHex(col, .82)); R(c, x, bse - 1, w, 1, shadeHex(col, .75));
      if (hash(i + r * 3) > .45) roofTiles(c, x - 1, bse - h - 3, w + 2, 3, pick(['#b8644a', '#a8543c'], i)); else { R(c, x - 1, bse - h - 1, w + 2, 1, shadeHex(col, .7)); if (hash(i + 1) > .4) { R(c, x + 2, bse - h - 5, 5, 4, '#3c6aa8'); R(c, x + 2, bse - h - 5, 5, 1, '#6a9ad0'); } }
      for (let k = 0; k < Math.floor(w / 6); k++) { const wx = x + 2 + k * 6; R(c, wx, bse - h + 3, 3, 3, '#4a6a7a'); R(c, wx, bse - h + 3, 3, 1, '#7a9aaa'); if (hash(i * 11 + k + r) > .5) R(n, wx, bse - h + 3, 3, 3, pick(['#ffd98a', '#ffe6b0'], k)); }
      R(c, x + w - 5, bse - 5, 3, 5, '#6a4a32'); if (hash(i + r * 7) > .7) for (let k = 0; k < w; k += 3) R(c, x + k, bse - h - 6 + Math.round(Math.sin(k / w * Math.PI)), 2, 2, pick(['#d9634a', '#3c6aa8', '#f2efe6', '#e8c24c'], k + i));
      x += w + 2 + Math.round(hash(i * 13 + r) * 6);
    }
    const ESC = [180, 520, 980, 1300];
    for (const ex of ESC) { const top = Math.round(hy(ex)) + 4; for (let y = top; y < 204; y += 2) { const xx = ex + ((Math.floor(y / 8) % 2) ? (y % 8) : 8 - (y % 8)); R(c, xx, y, 4, 1, '#ece6d6'); R(c, xx, y + 1, 4, 1, '#b8b2a2'); } for (let y = top + 10; y < 200; y += 24) { R(c, ex + 12, y - 8, 1, 8, '#6a6a66'); R(n, ex + 11, y - 8, 3, 1, '#fff2c0'); } }
    const ig = 700, iy = Math.round(hy(ig + 12)) + 12; R(c, ig, iy - 18, 26, 18, '#f6f2e8'); R(c, ig + 24, iy - 18, 2, 18, '#d8d2c0'); for (let k = 0; k < 13; k++) R(c, ig + k, iy - 18 - k * .8, 26 - k * 2, 1, '#e8e2d0'); R(c, ig + 9, iy - 40, 8, 22, '#f6f2e8'); R(c, ig + 9, iy - 40, 8, 1, '#ffffff'); R(c, ig + 11, iy - 36, 4, 5, '#5a6a7a'); R(c, ig + 12, iy - 50, 2, 10, '#5a5a56'); R(c, ig + 10, iy - 47, 6, 1, '#5a5a56'); R(c, ig + 10, iy - 10, 6, 10, '#6a4a32'); R(n, ig + 11, iy - 36, 4, 5, '#ffe6b0');
    const cp = 1100, cy = Math.round(hy(cp + 40)) + 26; R(c, cp, cy, 80, 10, '#c49a6a'); R(c, cp, cy, 80, 1, '#d8b080'); R(c, cp + 2, cy + 4, 76, 1, 'rgba(255,255,255,.5)'); for (const gx of [cp + 1, cp + 75]) { R(c, gx, cy - 5, 1, 6, '#f2efe6'); R(c, gx + 3, cy - 5, 1, 6, '#f2efe6'); R(c, gx, cy - 5, 4, 1, '#f2efe6'); }
    nevoa(c, T, 'rgba(204,218,228,.2)');
    return { cv, nv, base: 200, f: .3, gente: 0, hy, ESC, cp, cy, ig, iy };
  }
  function meioEncosta(c, s, t, camL) {
    const M = lazy(13, buildEncosta); tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f);
    for (let i = 0; i < 4; i++) { const ex = M.ESC[i], k = (t * .025 + i * .27) % 1, top = M.hy(ex) + 4, y = 204 - k * (204 - top), sx = scr(M, ex + 2 + ((Math.floor(y / 8) % 2) ? (y % 8) : 8 - (y % 8)), camL); if (sx > -10 && sx < LW + 10) pessoinha(c, sx, y, i + 3, t); }
    if (night(s) < .6) { const bx = M.cp + 40 + Math.sin(t * 1.7) * 30, by = M.cy - 2 - Math.abs(Math.sin(t * 3.4)) * 8; for (let k = 0; k < 6; k++) { const px = M.cp + 8 + k * 12 + Math.sin(t * 1.7 + k) * 6, sx = scr(M, px, camL); if (vis(sx, 10)) pessoinha(c, sx, M.cy + 6, k + 1, t); } const sb = scr(M, bx, camL); if (vis(sb, 10)) R(c, sb, by, 2, 2, '#f2efe6'); }
    { const sx = scr(M, M.ig + 13, camL); if (vis(sx, 20)) { const sw = Math.round(Math.sin(t * 2.4) * 1.5); R(c, sx - 1 + sw, M.iy - 35, 2, 3, '#c8a24a'); } }
  }

  // 14 · rua de trás do comércio (prédios altos, letreiros no alto e o relógio-termômetro)
  function meioComercio(c, s, t, camL) {
    const M = lazy(14, () => buildRua({ seed: 140, base: 188, f: [5, 10], w: [26, 46], pal: ['#ebe8de', '#e0d6c2', '#f3f0e8', '#d4cab6', '#dfe6ea', '#e8dcc8'], lojas: LOJAS_RUA, lojaChance: .9, outdoors: 3, rua: true }));
    tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f); andaRua(c, M, s, t, camL);
    const tp = M.tops[6]; if (tp) { const sx = scr(M, tp.x + tp.w / 2, camL); if (vis(sx, 30)) { // relógio-termômetro: Conquista é fria
      R(c, sx - 1, tp.top - 12, 2, 12, '#5a5e62'); R(c, sx - 17, tp.top - 24, 34, 13, '#1a1c20'); R(c, sx - 16, tp.top - 23, 32, 11, '#0c0e10');
      const h = s.h ?? 12, temp = Math.round(13 + 6 * Math.sin((h - 9) / 24 * TAU)), hh = Math.floor(h), mm = Math.floor((h - hh) * 60), txt = Math.floor(t / 3) % 2 ? `${temp}°C` : `${String(hh).padStart(2, '0')}:${String(mm).padStart(2, '0')}`;
      pxText(c, txt, sx, tp.top - 20, '#ffa83a'); } }
  }

  // 16 · rua de trás da avenida (torres, lojas e um painel de LED com propaganda)
  function meioAvenida(c, s, t, camL) {
    const M = lazy(16, () => buildRua({ seed: 160, base: 184, f: [3, 10], w: [28, 50], gap: 3, gapR: 18, nevoa: 'rgba(200,214,226,.24)', pal: ['#ebe8de', '#dfe6ea', '#f3f0e8', '#d4cab6', '#cfd6dc', '#e8dcc8'], lojas: LOJAS_RUA, lojaIni: 14, lojaChance: .85, outdoors: 4, outIni: 3, vidro: true, gente: 26 }));
    tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f); andaRua(c, M, s, t, camL);
    const tp = M.tops[9]; if (tp) { const sx = scr(M, tp.x + tp.w / 2, camL); if (vis(sx, 60)) { // painel de LED trocando de propaganda
      const L = OUTDOORS[Math.floor(t / 4) % OUTDOORS.length], w = Math.max(54, largura(L[0]) + 10); R(c, sx - 1, tp.top - 8, 2, 8, '#5a5e62'); R(c, sx - w / 2 - 1, tp.top - 24, w + 2, 16, '#14161a');
      R(c, sx - w / 2, tp.top - 23, w, 14, L[1]); for (let k = 0; k < w; k += 2) R(c, sx - w / 2 + k, tp.top - 23, 1, 14, 'rgba(0,0,0,.18)'); pxText(c, L[0], sx, tp.top - 18, L[2]); } }
  }

  // 15 · a serra de trás, com a trilha em zigue-zague, gente subindo, antena e parapente
  function buildSerraM() {
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH);
    const ry = (x) => 86 + Math.sin(x / T * TAU * 2) * 13 + Math.sin(x / T * TAU * 5 + 2) * 6 + Math.sin(x / T * TAU * 13) * 2.5;
    for (let x = 0; x < T; x++) { const y = Math.round(ry(x)); for (let yy = y; yy < 200; yy += 2) R(c, x, yy, 1, 2, A.lerpC('#8e9c8a', '#748476', (yy - y) / 100)); R(c, x, y, 1, 1, '#b4c0b4'); }
    for (let i = 0; i < 70; i++) { const x = hash(i + 15) * T, y = ry(x) + 6 + hash(i + 16) * 60; ell(c, x, y, 3 + hash(i) * 6, 2 + hash(i * 3) * 3, '#8a8a80'); ell(c, x - 1, y - 1, 2 + hash(i) * 3, 1.5, '#a6a69a'); }
    for (let i = 0; i < 260; i++) { const x = hash(i + 150) * T, y = ry(x) + 4 + hash(i + 151) * 80; ell(c, x, y, 1.5 + hash(i) * 2, 1.2, i % 2 ? '#5a7a3c' : '#6a8a44'); }
    const TR = []; for (const x0 of [140, 820]) { const pts = []; let x = x0, y = 190; for (let k = 0; y > ry(x) + 6; k++) { pts.push([x, y]); x += (k % 2 ? -34 : 38); y -= 13; } pts.push([x, ry(x) + 3]); TR.push(pts); for (let k = 1; k < pts.length; k++) limb(c, [pts[k - 1], pts[k]], 2, '#c8b48a'); }
    const ax = 520, ay = Math.round(ry(ax)); R(c, ax, ay - 40, 2, 40, '#9a3a34'); for (let k = 0; k < 40; k += 5) { R(c, ax - 3, ay - 40 + k, 8, 1, '#d8d8d0'); } R(n, ax, ay - 42, 2, 2, '#ff4a3a');
    const mx = 1120, my = Math.round(ry(mx)); R(c, mx - 10, my - 4, 22, 2, '#8a6a45'); for (let k = 0; k < 22; k += 3) R(c, mx - 10 + k, my - 8, 1, 4, '#6a4a32'); R(c, mx - 10, my - 8, 22, 1, '#6a4a32');
    nevoa(c, T, 'rgba(196,210,224,.36)');
    return { cv, nv, base: 200, f: .06, gente: 0, TR, ry, ax, ay };
  }
  function naTrilha(pts, u) { const n = pts.length - 1, k = Math.min(n - 1, Math.floor(u * n)), f = u * n - k; return [pts[k][0] + (pts[k + 1][0] - pts[k][0]) * f, pts[k][1] + (pts[k + 1][1] - pts[k][1]) * f]; }
  function meioSerra(c, s, t, camL) {
    const M = lazy(15, buildSerraM); tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f);
    if (night(s) < .7) for (let i = 0; i < 6; i++) { const pts = M.TR[i % 2], u = (t * .012 + i * .19) % 1, [x, y] = naTrilha(pts, i % 3 ? u : 1 - u), sx = scr(M, x, camL); if (vis(sx, 10)) { pessoinha(c, sx, y, i + 5, t); R(c, sx + 2, y - 7, 2, 3, pick(['#c43c3a', '#e8833a', '#3c6aa8'], i)); } }
    { const a = t * .18, x = 700 + Math.cos(a) * 120, y = 54 + Math.sin(a * 2) * 10, sx = scr(M, x, camL); if (vis(sx, 30)) { for (let k = -6; k <= 6; k++) R(c, sx + k * 2, y - Math.round(Math.sqrt(1 - (k / 7) ** 2) * 3), 2, 2, k % 2 ? '#e8433a' : '#f2c94c'); limb(c, [[sx - 11, y], [sx, y + 10]], 1, 'rgba(60,60,60,.7)'); limb(c, [[sx + 11, y], [sx, y + 10]], 1, 'rgba(60,60,60,.7)'); R(c, sx - 1, y + 9, 3, 4, '#2c4a6a'); } }
  }

  // 17 · atrás da feira: mercado municipal com cobertura em arcos, igrejinha e o comércio
  function buildMercado() {
    const M = buildRua({ seed: 170, base: 182, f: [4, 8], w: [26, 44], pal: ['#ece4cf', '#dde4d4', '#f2e4d8', '#e4dccb'], lojas: LOJAS_RUA, lojaIni: 21, lojaChance: .8, outdoors: 4, outIni: 4 });
    const c = M.cv.getContext('2d'), n = M.nv.getContext('2d');
    for (const mx of [300, 1000]) { const w = 220, b = 182; R(c, mx, b - 40, w, 40, '#f2ece0'); for (let k = 0; k < 8; k++) { const ax = mx + 8 + k * 27; R(c, ax, b - 30, 16, 30, '#7a5a3a'); ell(c, ax + 8, b - 30, 8, 6, '#7a5a3a'); R(c, ax + 2, b - 24, 12, 24, '#3a2a1a'); R(n, ax + 2, b - 24, 12, 10, 'rgba(255,214,140,.6)'); }
      for (let k = 0; k < 5; k++) { const ax = mx + k * 44; for (let j = 0; j <= 44; j++) R(c, ax + j, b - 44 - Math.round(Math.sin(j / 44 * Math.PI) * 12), 1, 4, j % 4 ? '#9aa4ac' : '#7a848c'); } R(c, mx - 2, b - 44, w + 4, 4, '#c43c3a');
      pxText(c, 'MERCADO MUNICIPAL', mx + w / 2, b - 38, '#c43c3a'); }
    const ix = 720, b = 182; R(c, ix, b - 50, 40, 50, '#f6f2e8'); R(c, ix + 38, b - 50, 2, 50, '#d8d2c0'); for (let k = 0; k < 18; k++) R(c, ix + k, b - 50 - k * .9, 40 - k * 2, 1, '#e8e2d0'); R(c, ix + 14, b - 96, 12, 46, '#f6f2e8'); R(c, ix + 14, b - 96, 12, 1, '#ffffff');
    R(c, ix + 16, b - 90, 8, 8, '#5a6a7a'); R(c, ix + 19, b - 110, 2, 14, '#5a5a56'); R(c, ix + 16, b - 106, 8, 2, '#5a5a56'); R(c, ix + 14, b - 20, 12, 20, '#6a4a32'); ell(c, ix + 20, b - 36, 4, 4, '#5a6a7a'); R(n, ix + 16, b - 90, 8, 8, '#ffe6b0');
    nevoa(c, T, 'rgba(200,214,226,.1)'); M.ig = ix + 20; M.igy = b - 86; return M;
  }
  function meioMercado(c, s, t, camL) {
    const M = lazy(17, buildMercado); tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f); andaRua(c, M, s, t, camL);
    const sx = scr(M, M.ig, camL); if (vis(sx, 40)) { const sw = Math.round(Math.sin(t * 2.2) * 2); R(c, sx - 2 + sw, M.igy, 4, 4, '#c8a24a'); for (let i = 0; i < 5; i++) { const a = t * 1.2 + i * 1.25; R(c, sx + Math.cos(a) * 20, M.igy - 16 + Math.sin(a) * 6, 2, 1, '#5a5e66'); } }
  }

  // 18 · morros do cafezal com fileiras de café, trator na estradinha, colhedores e vacas
  function buildCafezal() {
    const [cv, c] = mk(T, LH), [nv, n] = mk(T, LH);
    const morro = (x, k) => (k ? 92 : 74) + Math.sin(x / T * TAU * (k ? 3 : 2) + k * 2) * (k ? 10 : 12) + Math.sin(x / T * TAU * 7 + k) * 3;
    for (const k of [0, 1]) {
      for (let x = 0; x < T; x++) { const y = Math.round(morro(x, k)); for (let yy = y; yy < 200; yy += 2) R(c, x, yy, 1, 2, A.lerpC(k ? '#7a9a52' : '#90aa6a', k ? '#5f7f40' : '#7a9658', (yy - y) / 80)); R(c, x, y, 1, 1, k ? '#a4bc78' : '#b4c890'); }
      for (let r = 0; r < 18; r++) for (let x = (r % 2) * 2; x < T; x += 3) { const y = morro(x, k) + 5 + r * 4.5; if (y > 200) continue; R(c, x, Math.round(y), 2, 2, (r + k) % 2 ? '#2f5a34' : '#3a6a3c'); if (hash(x * 3 + r) > .93) R(c, x, Math.round(y), 1, 1, '#c43c3a'); }
      for (let i = 0; i < 14; i++) { const x = hash(i * 7 + k * 50) * T; arvoreM(c, x, morro(x, k) + 14 + hash(i) * 30, i + k * 20, 1.2); }
    }
    const road = []; for (let x = 0; x <= T; x += 24) road.push([x, morro(x, 1) + 40 + Math.sin(x / T * TAU * 4) * 8]); for (let k = 1; k < road.length; k++) limb(c, [road[k - 1], road[k]], 3, '#c8a878');
    const hx = 600, hy = Math.round(morro(hx, 0)) + 10; R(c, hx, hy - 10, 22, 10, '#f6f2e8'); roofTiles(c, hx - 2, hy - 14, 26, 4, '#a8543c'); R(c, hx + 3, hy - 7, 3, 3, '#5a6a7a'); R(c, hx + 15, hy - 7, 3, 7, '#6a4a32'); R(n, hx + 3, hy - 7, 3, 3, '#ffd98a');
    const gx = 1180, gy = Math.round(morro(gx, 0)) + 14; R(c, gx, gy - 12, 26, 12, '#a83a2a'); for (let k = 0; k < 13; k++) R(c, gx + k, gy - 12 - k * .6, 26 - k * 2, 1, '#8a2a20'); R(c, gx + 9, gy - 8, 8, 8, '#f2efe6');
    nevoa(c, T, 'rgba(204,218,226,.18)');
    return { cv, nv, base: 200, f: .26, gente: 0, road, morro };
  }
  function meioCafezal(c, s, t, camL) {
    const M = lazy(18, buildCafezal); tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f);
    { const u = (t * .01) % 1, x = u * T, k = Math.min(M.road.length - 2, Math.floor(x / 24)), y = M.road[k][1] + (M.road[k + 1][1] - M.road[k][1]) * (x / 24 - k), sx = scr(M, x, camL);
      if (vis(sx, 30)) { R(c, sx, y - 5, 8, 4, '#c43c3a'); R(c, sx + 5, y - 9, 4, 4, '#c43c3a'); R(c, sx + 6, y - 8, 2, 2, '#9fc4d0'); ell(c, sx + 1, y - 1, 2, 2, '#1c1c1c'); ell(c, sx + 7, y, 1.5, 1.5, '#1c1c1c'); for (let i = 0; i < 5; i++) { const q = (t * 1.5 + i / 5) % 1; ell(c, sx - 3 - q * 16, y - 2 - q * 4, 2 + q * 4, 1 + q * 2, `rgba(210,190,150,${(1 - q) * .45})`); } } }
    if (night(s) < .6) for (let i = 0; i < 7; i++) { const x = 200 + i * 170 + Math.sin(t * .2 + i) * 10, y = M.morro(x, 1) + 14 + (i % 3) * 9, sx = scr(M, x, camL); if (vis(sx, 10)) { pessoinha(c, sx, y, i + 2, t, false); R(c, sx - 1, y - 11, 5, 1, '#d8b878'); R(c, sx + (Math.sin(t * 3 + i) > 0 ? 3 : -2), y - 6, 2, 1, SKIN[i % 5]); } }
    for (let i = 0; i < 5; i++) { const x = 900 + i * 22 + Math.sin(t * .1 + i * 2) * 12, y = M.morro(x, 0) + 22 + (i % 2) * 4, sx = scr(M, x, camL); if (vis(sx, 10)) { R(c, sx, y - 4, 7, 3, '#f2efe6'); R(c, sx + 2, y - 4, 2, 2, '#2a2a2a'); R(c, sx + (i % 2 ? 6 : -1), y - 5 + (Math.sin(t + i) > .6 ? 1 : 0), 2, 2, '#f2efe6'); R(c, sx + 1, y - 1, 1, 1, '#2a2a2a'); R(c, sx + 5, y - 1, 1, 1, '#2a2a2a'); } }
  }

  // 19 · noite do Festival de Inverno: roda-gigante, fogos, barracas iluminadas e prédios acesos
  function meioParque(c, s, t, camL) {
    const M = lazy(19, () => { const m = buildRua({ seed: 190, base: 186, f: [2, 5], w: [24, 40], gap: 2, gapR: 10, pal: ['#c8ccd4', '#b8b4a8', '#cfd6dc', '#c4bcae'], lojas: LOJAS_RUA, lojaIni: 7, lojaChance: .6, outdoors: 5, outIni: 7, nevoa: 'rgba(40,50,90,.18)', gente: 30 });
      const c2 = m.cv.getContext('2d'), n2 = m.nv.getContext('2d'); for (let k = 0; k < 6; k++) { const bx = 940 + k * 34; R(c2, bx, 166, 30, 20, pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#3c8a5a', '#7a3a8a'], k)); for (let j = 0; j < 30; j += 4) R(c2, bx + j, 166, 2, 3, '#f2efe6'); R(c2, bx + 2, 172, 26, 10, '#3a2a1a'); R(n2, bx + 2, 172, 26, 10, 'rgba(255,214,140,.8)'); }
      for (let x = 930; x < 1150; x += 3) { const y = 160 + Math.round(Math.sin((x - 930) / 220 * Math.PI) * 6); R(c2, x, y, 1, 1, '#3a3a36'); if (x % 9 === 0) R(n2, x, y + 1, 1, 1, pick(['#ffe39a', '#ff8a8a', '#8ad0ff'], x)); } pxText(c2, 'FESTIVAL DE INVERNO', 1040, 150, '#f2c94c', { sombra: '#2a2a2a' }); return m; });
    const a = night(s);
    if (a > .2) for (let i = 0; i < 3; i++) { const per = 5 + i * 1.3, ph = ((t + i * 2.1) % per) / per, bx = 80 + ((Math.floor((t + i * 2.1) / per) * 137 + i * 151) % 320), by = 30 + i * 12; if (ph < .25) R(c, bx, by + 60 * (1 - ph / .25), 1, 3, '#f2e8c8'); else { const r = (ph - .25) * 50, al = 1 - (ph - .25) / .75, col = ['#ff6a6a', '#f2c94c', '#6ad0ff'][i]; c.save(); c.globalAlpha = al * a; for (let k = 0; k < 12; k++) { const an = k / 12 * TAU; R(c, bx + Math.cos(an) * r, by + Math.sin(an) * r * .9, 2, 2, col); } c.restore(); } }
    { const sx = scr({ f: .2 }, 620, camL), cy = 92, r = 50, rot = t * .12; if (vis(sx, 70)) { // roda-gigante
      R(c, sx - 1, cy, 3, 96, '#5a5e66'); limb(c, [[sx, cy], [sx - 30, 188]], 2, '#5a5e66'); limb(c, [[sx, cy], [sx + 30, 188]], 2, '#5a5e66');
      for (let k = 0; k < 64; k++) { const an = k / 64 * TAU; R(c, sx + Math.cos(an) * r, cy + Math.sin(an) * r, 2, 2, '#8a8e98'); }
      for (let k = 0; k < 12; k++) { const an = rot + k / 12 * TAU, ex = sx + Math.cos(an) * r, ey = cy + Math.sin(an) * r; limb(c, [[sx, cy], [ex, ey]], 1, '#7a7e88'); R(c, ex - 3, ey + 1, 7, 6, pick(['#c43c3a', '#2c5a9e', '#e8c24c', '#3c8a5a'], k)); R(c, ex - 2, ey + 2, 5, 2, '#f6e8b8'); if (a > .2 && (k + Math.floor(t * 3)) % 3 === 0) R(c, ex, ey, 2, 2, '#fff2c0'); }
      ell(c, sx, cy, 4, 4, '#c8ccd4'); } }
    tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f, 1.2); andaRua(c, M, s, t, camL);
  }

  // 21 · torres da Olívia Flores: vidro, sacadas, academia SMART FAT com esteiras e farmácia com a cruz piscando
  function meioCondominio(c, s, t, camL) {
    const M = lazy(21, () => buildRua({ seed: 210, base: 172, f: [7, 14], w: [30, 50], gap: 3, gapR: 14, pal: ['#f2efe6', '#e9e6dc', '#dfe4e6', '#ece4d4', '#d8dee6'], lojas: [LOJAS_RUA[24], LOJAS_RUA[1], LOJAS_RUA[19], LOJAS_RUA[21], LOJAS_RUA[12], LOJAS_RUA[10]], lojaChance: .5, outdoors: 6, outIni: 1, vidro: true, gente: 18 }));
    tile(c, M.cv, camL * M.f); noiteTile(c, s, M.nv, camL * M.f); andaRua(c, M, s, t, camL);
    for (const p of M.pos) { const sx = scr(M, p.x, camL); if (!vis(sx, 60)) continue;
      if (p.nome === 'SMART FAT') for (let k = 0; k < Math.floor((p.w - 8) / 9); k++) { const x = sx + 5 + k * 9, f = Math.floor(t * 8 + k) % 2; R(c, x - 1, p.y + 15, 7, 1, '#2a2a2a'); R(c, x + 1, p.y + 15 - 2 - f, 1, 2, '#2a2f3a'); R(c, x + 3, p.y + 15 - 1 - (1 - f), 1, 1 + (1 - f), '#2a2f3a'); R(c, x + 1, p.y + 11, 3, 3, pick(ROUPA, k)); R(c, x + 1, p.y + 10, 3, 1, SKIN[k % 5]); }
      if (p.nome === 'PAGUE MAIS' && Math.sin(t * 4) > -.2) { const x = sx + p.w - 6; R(c, x, p.y - 8, 2, 6, '#3ae06a'); R(c, x - 2, p.y - 6, 6, 2, '#3ae06a'); } }
  }

  /* =====================================================================
     SOBRE: detalhes no plano das fachadas
     ===================================================================== */
  function letreiros(c, id, camL, nomes, t) { // as lojas da frente ganham letreiro de caixa de luz com o nome (paródia)
    const L = A.lojas(id); L.forEach(([x, w], i) => { const sx = x - camL; if (!vis(sx, w + 10)) return; const nome = nomes[i % nomes.length], col = nome[1];
      R(c, sx + 2, GY - 31, w - 4, 11, '#1c1f24'); vgrad(c, sx + 3, GY - 30, w - 6, 9, shadeHex(col, 1.2), shadeHex(col, .8)); R(c, sx + 3, GY - 30, w - 6, 1, 'rgba(255,255,255,.35)');
      pxText(c, nome[0], sx + w / 2, GY - 28, nome[2], { sombra: 'rgba(0,0,0,.35)' });
      if (i % 3 === 1 && Math.floor(t * 1.5 + i) % 4) { const nx = sx + w - 26; R(c, nx, GY - 13, 20, 7, '#1a1a1e'); pxText(c, 'ABERTO', nx + 10, GY - 12, '#ff5a8a'); } }); }
  function sobre(id, c, s, t, camL) {
    if (id === 14) letreiros(c, 14, camL, LOJAS_RUA, t);
    else if (id === 16) { letreiros(c, 16, camL, LOJAS_RUA.slice(14).concat(LOJAS_RUA.slice(0, 6)), t);
      { const x = 620 - camL; if (vis(x, 130)) { pxText(c, 'MOTOTAXI?', x + 60, 66, '#2a2a2a', { s: 2 }); pxText(c, 'SO NO PRECO JUSTO', x + 60, 82, '#5a3a10'); pxText(c, 'LIGUE: TONHAO', x + 60, 92, '#c43c3a'); c.save(); c.translate(x + 2 - 0, 100 - GY); A.moto(c, 0, '#f08a24'); c.restore(); } }
      { const x = 2140 - camL; if (vis(x, 130)) { pxText(c, 'COMPRE UM', x + 60, 64, '#ffffff', { s: 2, sombra: '#2c5a8a' }); pxText(c, 'CASACO.', x + 60, 76, '#ffffff', { s: 2, sombra: '#2c5a8a' }); pxText(c, 'SERIO. AQUI FAZ 12°C', x + 60, 92, '#1d3a6a'); R(c, x + 6, 70, 12, 16, '#7a3a3a'); R(c, x + 4, 72, 3, 12, '#7a3a3a'); R(c, x + 17, 72, 3, 12, '#7a3a3a'); R(c, x + 11, 70, 2, 16, '#5a2a2a'); } } }
    else if (id === 13) { const x = A.BAIRRO.PEN + 82 - camL; if (vis(x, 30)) { // Dona Lurdes regando as plantas da sacada
      const nt = night(s); if (nt < .5) { R(c, x + 3, 112, 10, 14, '#3a3026'); ell(c, x + 8, 116, 3, 3, '#d9a57f'); R(c, x + 5, 112, 6, 3, '#3a312c'); R(c, x + 4, 119, 9, 8, '#7a5a8c'); const k = Math.sin(t * 1.4); R(c, x + 12, 121 + k, 7, 4, '#3c8a5a'); R(c, x + 18, 122 + k, 3, 1, '#3c8a5a'); if (k > .2) for (let i = 0; i < 3; i++) R(c, x + 21, 125 + ((t * 30 + i * 4) % 12), 1, 2, '#9fd0f0'); }
      else { R(c, x + 4, 112, 8, 14, 'rgba(40,30,20,.55)'); ell(c, x + 8, 116, 3, 3, 'rgba(40,30,20,.6)'); } } }
    else if (id === 17) { const F = A.FEIRA; for (let i = 0, x = 16; x < F.W - 60; i++, x += 92) { if (F.BISC.some((b) => x > b - 74 && x < b + 124)) continue; const sx = x - camL + 34; if (!vis(sx, 20)) continue; // feirantes atrás das bancas
      const sk = SKIN[(i + 2) % 5], sh = pick(ROUPA, i * 3); R(c, sx, 150, 7, 8, sh); R(c, sx + 1, 143, 5, 6, sk); R(c, sx + 1, 142, 5, 2, pick(['#2a201a', '#1a1a1a', '#6a6a66'], i)); if (i % 2) R(c, sx - 1, 140, 9, 2, '#d8b878'); const ar = Math.sin(t * 2.5 + i); R(c, sx + 7, 151 + Math.round(ar * 2), 4, 2, sk); if (ar > .5) R(c, sx + 10, 150, 4, 5, '#f2efe6'); } }
    else if (id === 18) for (const [x0, k] of [[880, 0], [1060, 1]]) { const x = x0 + Math.sin(t * .5 + k) * 26 - camL; if (!vis(x, 30)) continue; const sw = Math.sin(t * 2.6 + k); // trabalhadores puxando o café no terreiro com o rodo
      gente(c, x, 205, k + 3, false); R(c, x - 1, 184, 8, 2, '#d8b878'); limb(c, [[x + 5, 194], [x + 14 + sw * 4, 204]], 1, '#8a6a45'); R(c, x + 10 + sw * 4, 204, 9, 2, '#6a4a32'); }
    else if (id === 21) for (const gx of [300, 700]) { const x = gx - camL; if (!vis(x, 60)) continue; const up = Math.abs(Math.sin(t * 1.8)); // academia ao ar livre
      gente(c, x + 8, 206 - Math.round(up * 6), 7, false); R(c, x + 6, 190, 2, 4 + Math.round(up * 2), SKIN[1]); R(c, x + 13, 190, 2, 4 + Math.round(up * 2), SKIN[1]);
      const l = Math.sin(t * 3) * 4; gente(c, x + 34, 206, 2, false); R(c, x + 33 + l, 204, 2, 4, '#2a2f3a'); R(c, x + 37 - l, 204, 2, 4, '#2a2f3a'); }
    else if (id === 12) for (let k = 0; k < 4; k++) for (let j = 0; j < 3; j++) { const x = 40 + k * 112 - 18 - j * 14 - camL; if (!vis(x, 20) || (k + j) % 3 === 2) continue; const bob = Math.round(Math.sin(t * 1.3 + k + j * 2) * .6); // fila do check-in com mala
      pessoa(c, x, 208 + bob, k * 3 + j + 1); R(c, x - 6, 200, 5, 8, pick(['#2c4a6a', '#c43c3a', '#4a8a5a', '#7a3a8a'], k + j)); R(c, x - 5, 197, 3, 3, '#5a5a56'); }
    else if (id === 19) { const nt = night(s); for (let lx = 100; lx < A.CULTURA.W - 260; lx += 260) { const x0 = lx - camL, x1 = lx + 260 - camL; if (x1 < -10 || x0 > LW + 10) continue; // gambiarra de lâmpadas entre os postes
      for (let x = x0; x <= x1; x += 2) { const u = (x - x0) / 260, y = 122 + Math.round(Math.sin(u * Math.PI) * 14); R(c, x, y, 2, 1, '#2a2a2a'); if (Math.round(x - x0) % 12 === 0) R(c, x, y + 1, 2, 2, nt > .2 && (Math.floor(t * 2) + Math.round(x - x0) / 12) % 3 ? pick(['#ffe39a', '#ff9a9a', '#9ad8ff', '#b8f0a0'], Math.round(x - x0) / 12) : '#8a8478'); } } }
  }

  /* =====================================================================
     FRENTE: mais gente na rua (não interativa)
     ===================================================================== */
  const POVO = { 12: 12, 13: 12, 14: 20, 16: 16, 17: 18, 19: 16, 21: 14, 15: 3 }, TRILHA = new Set([15]);
  function populacao(id, c, s, t, camL) {
    const n = POVO[id]; if (!n) return; const W = window.CampanhaCenarios.largura(id) / 2, AIR = A.AIR;
    for (let i = 0; i < n; i++) {
      const dir = (i * 7 + id) % 2 ? 1 : -1, sp = 9 + hash(i * 3 + id) * 9, wx = wrap(hash(i * 11 + id) * W + t * sp * dir, W), sx = wx - camL;
      if (!vis(sx, 20) || (id === 12 && wx > AIR.TAR - 10 && wx < AIR.GR + 10)) continue;
      const y = 216 + (i % 3 === 0 ? 1 : 0), k = i * 5 + id, passo = Math.floor(t * 6 + i) % 2;
      if (TRILHA.has(id)) { gente(c, sx, y, k, true); R(c, sx + (dir > 0 ? -3 : 6), y - 14, 3, 7, '#c43c3a'); limb(c, [[sx + (dir > 0 ? 7 : -1), y - 9], [sx + (dir > 0 ? 10 : -4), y]], 1, '#6a4a32'); continue; }
      if (i % 3 === 0) pessoa(c, sx, y, k); else gente(c, sx, y, k, true);
      R(c, sx + 1 - passo, y - 1, 2, 1, 'rgba(0,0,0,.2)');
      if (i % 5 === 2 && (s.rain || 0) > .1) { R(c, sx - 3, y - 24, 12, 2, pick(['#2a2a2a', '#c43c3a', '#3c6aa8'], i)); R(c, sx + 2, y - 23, 1, 8, '#5a5a56'); }
      else if (i % 7 === 3) { R(c, sx + (dir > 0 ? 6 : -2), y - 16, 2, 3, '#1c1c24'); R(c, sx + (dir > 0 ? 6 : -2), y - 16, 2, 1, '#5ab8e8'); } // olhando o celular
      else if (i % 9 === 4) { const cx = sx + (dir > 0 ? 10 : -14); cachorro(c, cx, y, pick(['#c98a43', '#f2efe6', '#2a2a2a'], i)); limb(c, [[sx + 3, y - 10], [cx + (dir > 0 ? 2 : 12), y - 8]], 1, '#c43c3a'); }
      else if (i % 11 === 6) { pessoa(c, sx + (dir > 0 ? -8 : 8), y, k + 1); R(c, sx + (dir > 0 ? -4 : 7), y - 11, 4, 1, SKIN[i % 5]); } // de mãos dadas com a criança
    }
  }

  /* =====================================================================
     ENGARRAFAMENTO: Cleiton (motorista do Ubé) e a sogra, Dona Rosilda, presos atrás do Fusca do Seu Arlindo
     ===================================================================== */
  const JAM = { 14: { fusca: 2080, lane: 245 }, 16: { fusca: 930, lane: 245 } }, CHANCE = .4;
  const jamOn = {}, forcado = {}; let ultima = 0, ultimoT = 0, chegada = 0;
  function entrar(id) {
    const now = performance.now();
    if (id !== ultima || now - ultimoT > 2500) { chegada = now; if (JAM[id] && !forcado[id]) jamOn[id] = Math.random() < CHANCE; }
    ultima = id; ultimoT = now;
  }
  const engarrafado = (id) => !!(JAM[id] && jamOn[id]);
  const CORES = ['#c43c3a', '#f2f2ee', '#3c6aa8', '#2a2a2a', '#9aa0a6', '#e8c24c', '#3c8a5a', '#7a2a3a', '#d8d2c0'];
  function cabeca(c, x, y, sk, cabelo) { R(c, x, y, 4, 4, sk); R(c, x, y - 1, 4, 2, cabelo); }
  function carroG(c, x, y, col, kind, seed, t) { // carro grande da faixa da frente (de lado, virado pra direita)
    const L = kind === 'van' ? 58 : kind === 'pickup' ? 60 : kind === 'sedan' ? 58 : 52, vib = Math.floor(t * 14 + seed) % 2 ? 0 : 1, yy = y - vib * 0;
    R(c, x + 3, y, L - 6, 2, 'rgba(0,0,0,.28)');
    R(c, x, yy - 13, L, 10, col); R(c, x + 1, yy - 13, L - 2, 1, shadeHex(col, 1.3)); R(c, x, yy - 5, L, 2, shadeHex(col, .7)); R(c, x + 2, yy - 9, L - 4, 1, shadeHex(col, .85));
    if (kind === 'van') { R(c, x + 2, yy - 24, L - 10, 11, col); R(c, x + 2, yy - 24, L - 10, 1, shadeHex(col, 1.3)); for (let k = 0; k < 3; k++) R(c, x + 6 + k * 14, yy - 22, 11, 6, '#7a9aaa'); R(c, x + L - 10, yy - 20, 6, 7, '#9fc4d0'); }
    else if (kind === 'pickup') { R(c, x + L - 26, yy - 22, 20, 9, col); R(c, x + L - 23, yy - 21, 14, 6, '#9fc4d0'); R(c, x + 2, yy - 16, L - 30, 3, shadeHex(col, .8)); for (let k = 0; k < 3; k++) R(c, x + 6 + k * 8, yy - 19, 6, 4, pick(['#c49a6a', '#3c6aa8', '#e8c24c'], seed + k)); }
    else { const c0 = kind === 'sedan' ? 14 : 8; R(c, x + c0, yy - 21, 30, 8, col); R(c, x + c0 + 2, yy - 20, 12, 6, '#9fc4d0'); R(c, x + c0 + 16, yy - 20, 12, 6, '#9fc4d0'); R(c, x + c0 + 14, yy - 20, 2, 7, col); R(c, x + c0 + 3, yy - 20, 3, 6, 'rgba(255,255,255,.3)'); }
    R(c, x + L - 3, yy - 11, 3, 2, '#fff2b0'); R(c, x, yy - 11, 2, 3, '#e8433a'); R(c, x + L - 1, yy - 6, 2, 3, '#c8ccd0'); R(c, x - 1, yy - 6, 2, 3, '#c8ccd0');
    for (const wx of [x + 10, x + L - 11]) { ell(c, wx, y - 3, 4.5, 4.5, '#1c1c1c'); ell(c, wx, y - 3, 2, 2, '#9aa0a6'); }
    return L;
  }
  function fusca(c, x, y, t) {
    const col = '#7ab8d8'; R(c, x + 3, y, 40, 2, 'rgba(0,0,0,.28)'); ell(c, x + 22, y - 10, 22, 9, col); ell(c, x + 20, y - 17, 13, 7, col); R(c, x + 10, y - 20, 9, 5, '#9fc4d0'); R(c, x + 21, y - 20, 9, 5, '#9fc4d0'); R(c, x + 19, y - 21, 2, 7, col); ell(c, x + 19, y - 22, 10, 2, shadeHex(col, 1.2));
    R(c, x, y - 7, 44, 3, shadeHex(col, .75)); ell(c, x + 10, y - 3, 4.5, 4.5, '#1c1c1c'); ell(c, x + 34, y - 3, 4.5, 4.5, '#1c1c1c'); ell(c, x + 10, y - 3, 2, 2, '#c8ccd0'); ell(c, x + 34, y - 3, 2, 2, '#c8ccd0');
    const pisca = Math.floor(t * 3) % 2 ? '#ffb02a' : '#7a4a10'; R(c, x + 42, y - 11, 2, 2, pisca); R(c, x, y - 11, 2, 2, pisca); R(c, x + 41, y - 13, 2, 2, '#fff2b0');
    cabeca(c, x + 25, y - 19, '#d8a985', '#d0ccc4'); const din = Math.sin(t * 2) > 0; R(c, x + 29, y - 15, 5, 2, '#d8a985'); if (din) R(c, x + 33, y - 17, 4, 3, '#7ac85a');
    const vx = x + 47; R(c, vx, y - 2, 2, 2, '#2a2f3a'); R(c, vx + 4, y - 2, 2, 2, '#2a2f3a'); R(c, vx, y - 12, 6, 10, '#2a2f3a'); R(c, vx - 1, y - 24, 8, 12, '#f2efe6'); ell(c, vx + 3, y - 27, 3, 3, '#9a6440'); R(c, vx, y - 31, 7, 3, '#e8c24c'); // vendedor de biscoito
    R(c, vx - 10, y - 20, 12, 2, '#8a6a45'); for (let k = 0; k < 4; k++) ell(c, vx - 8 + k * 3, y - 21, 1.5, 1.5, '#f6ecd0'); R(c, vx + 8, y - 8, 7, 8, '#eef4f6'); R(c, vx + 8, y - 8, 7, 2, '#3e7cc0');
  }
  function balao(c, x, y, txt, cor = '#1c1c22') { // balão de fala com a fonte pixel (até 2 linhas)
    const s = limpa(txt), lines = []; let cur = ''; for (const w of s.split(' ')) { if ((cur + ' ' + w).trim().length > 17 && cur) { lines.push(cur); cur = w; } else cur = (cur + ' ' + w).trim(); } if (cur) lines.push(cur);
    const w = Math.max(...lines.map((l) => largura(l))) + 8, h = lines.length * 7 + 5, bx = Math.round(Math.max(2, Math.min(LW - w - 2, x - w / 2))), by = Math.round(y - h - 5);
    R(c, bx + 1, by, w - 2, h, cor); R(c, bx, by + 1, w, h - 2, cor); R(c, bx + 2, by + 1, w - 4, h - 2, '#fbf8ef'); R(c, bx + 1, by + 2, w - 2, h - 4, '#fbf8ef');
    const tx = Math.round(Math.max(bx + 4, Math.min(bx + w - 6, x))); R(c, tx, by + h - 1, 4, 2, '#fbf8ef'); R(c, tx - 1, by + h - 1, 1, 3, cor); R(c, tx + 4, by + h - 1, 1, 2, cor); R(c, tx + 1, by + h + 1, 2, 2, '#fbf8ef'); R(c, tx + 3, by + h + 1, 1, 2, cor); R(c, tx + 1, by + h + 3, 2, 1, cor);
    lines.forEach((l, i) => pxText(c, l, bx + w / 2, by + 3 + i * 7, '#2a2a2a'));
  }
  const FALAS = [['c', 'ANDA, CRIATURA!'], ['r', 'BUZINA MAIS, CLEITON!'], ['a', 'CALMA! É SÓ UM PACOTINHO!'], ['v', 'BISCOITO QUENTINHO! 3 POR 5!'], ['c', 'TÁ VERDE, MEU REI!'], ['r', 'VOU PERDER MINHA CONSULTA!'],
    ['c', 'EU TENHO CORRIDA NO SHOPPING!'], ['r', 'EU AVISEI PRA IR PELA OLÍVIA!'], ['a', 'QUER UM TAMBÉM, MOÇO?'], ['c', 'QUERO É QUE O SENHOR ANDE!']];
  const PERTO = [['c', 'Ô DA ROÇA! EMPURRA ESSE FUSCA AÍ!'], ['r', 'MOÇO, TEM BISCOITO SOBRANDO?']];
  function engarrafamento(id, c, s, t, camL) {
    const J = JAM[id], y = J.lane, fx = J.fusca, cx = fx - 66, hx = HERO().x / 2;
    // faixa de lá ainda anda, devagar
    for (let i = 0; i < 2; i++) { const wx = wrap(i * 1400 - t * 40, 3000) - 200, sx = wx - camL; if (vis(sx, 60)) carroG(c, sx, 267, pick(CORES, i + 3), i ? 'sedan' : 'hatch', i, t); }
    // a fila: do fim até o carro do Cleiton
    const vaos = (window.CampanhaCenarios.layout(id)?.gaps || []).map(([gx, gw]) => [gx / 2 - 4, (gx + gw) / 2 + 4]);
    for (let k = 1; k < 26; k++) { const x = cx - k * 64 - Math.round(hash(k + id) * 6), sx = x - camL; if (!vis(sx, 70) || vaos.some(([a, b]) => x + 60 > a && x < b)) continue; /* ninguém para em cima do buraco */ const kind = pick(['hatch', 'sedan', 'pickup', 'van', 'hatch'], k * 3 + id), col = pick(CORES, k + id);
      const L = carroG(c, sx, y, col, kind, k, t); if (kind !== 'pickup') cabeca(c, sx + (kind === 'sedan' ? 34 : kind === 'van' ? L - 9 : 28), y - 19, pick(SKIN, k), pick(['#2a201a', '#1a1a1a', '#6a4a2a', '#c8a050'], k));
      for (let i = 0; i < 2; i++) { const q = (t * 1.2 + i / 2 + k * .3) % 1; ell(c, sx - 3 - q * 10, y - 6 - q * 6, 1.5 + q * 3, 1 + q * 2, `rgba(200,200,200,${(1 - q) * .4})`); }
      const slot = Math.floor(t / 1.6 + k * 1.7); if (hash(slot * 13 + k) > .82) pxText(c, hash(slot + k) > .5 ? 'BI-BI!' : 'FOM!', sx + L / 2, y - 34, '#f2c94c', { sombra: '#2a2a2a' }); }
    // moto costurando entre os carros
    { const mx = wrap(t * 30, 1600) + fx - 1640, sx = mx - camL; if (vis(sx, 30)) { c.save(); c.translate(0, y + 9 - GY); A.moto(c, sx, '#f08a24'); R(c, sx + 7, GY - 22, 6, 8, '#f08a24'); R(c, sx + 8, GY - 27, 5, 5, '#c9372f'); c.restore(); } }
    // Cleiton e Dona Rosilda
    const sx = cx - camL;
    if (vis(sx, 140)) {
      carroG(c, sx, y, '#b8bec4', 'hatch', 99, t); pxText(c, 'UBE', sx + 24, y - 11, '#2a2a2a');
      // Dona Rosilda no banco de trás: bobes rosa e óculos
      cabeca(c, sx + 13, y - 19, '#e3b48f', '#7a4a34'); for (let k = 0; k < 3; k++) R(c, sx + 13 + k * 2, y - 21, 1, 1, '#f08ab0'); R(c, sx + 15, y - 18, 3, 1, '#5a3a8a'); if (Math.floor(t * 4) % 2) R(c, sx + 16, y - 16, 1, 1, '#7a2a2a');
      // Cleiton na direção: boné, bigode e o braço pra fora sacudindo
      cabeca(c, sx + 28, y - 19, '#b47a50', '#1c1612'); R(c, sx + 27, y - 21, 6, 2, '#1e2a36'); R(c, sx + 32, y - 20, 2, 1, '#e8c24c'); R(c, sx + 29, y - 16, 3, 1, '#1c1612'); R(c, sx + 31, y - 18, 1, 1, '#1c1612');
      const sh = Math.sin(t * 9); limb(c, [[sx + 33, y - 14], [sx + 40, y - 19 + sh * 2], [sx + 42, y - 25 + sh * 3]], 2, '#b47a50'); R(c, sx + 41, y - 28 + sh * 3, 3, 3, '#b47a50');
      fusca(c, fx - camL, y, t);
      const near = Math.abs(hx - (cx + 26)) < 80, seq = near ? PERTO : FALAS, step = Math.floor(t / 2.6), [quem, fala] = seq[step % seq.length];
      if (quem === 'c' && Math.floor(t * 5) % 2) { for (let k = 0; k < 3; k++) R(c, sx + 54 + k * 2, y - 14 - k * 2, 1, 4 + k * 2, '#f2c94c'); pxText(c, 'BEEE!', sx + 60, y - 30, '#f2c94c', { sombra: '#2a2a2a', align: 'left' }); }
      const px = { c: sx + 30, r: sx + 15, a: fx - camL + 27, v: fx - camL + 50 }[quem], py = { c: y - 24, r: y - 24, a: y - 24, v: y - 34 }[quem]; balao(c, px, py, fala);
      if (near) { pxText(c, 'CLEITON', sx + 34, y + 4, '#f2c94c', { sombra: '#2a2a2a' }); pxText(c, 'DONA ROSILDA', sx + 4, y + 10, '#f08ab0', { sombra: '#2a2a2a' }); }
    }
  }

  function frente(id, c, s, t, camL) {
    if (!(id in POVO) && !JAM[id]) return;
    populacao(id, c, s, t, camL);
    if (engarrafado(id)) engarrafamento(id, c, s, t, camL);
  }

  /* =====================================================================
     PRIMEIRO PLANO: perto da câmera, na beirada de baixo (passa mais rápido que o chão)
     ===================================================================== */
  const FG = { cidade: ['arbusto', 'grade', 'flores', 'hidrante', 'sacos', 'bike', 'cone', 'arbusto'], natureza: ['capim', 'pedra', 'samambaia', 'capim', 'flores', 'cafe'], cafe: ['cafe', 'capim', 'cafe', 'pedra', 'cafe'], interno: ['cadeiras', 'pilastra', 'vaso', 'cadeiras'] };
  const FGSET = { 12: 'interno', 13: 'cidade', 14: 'cidade', 15: 'natureza', 16: 'cidade', 17: 'cidade', 18: 'cafe', 19: 'cidade', 21: 'cidade' };
  const PEC = {
    arbusto: (c, x, y) => { for (let k = 0; k < 7; k++) ell(c, x + k * 6, y - 6 - (k % 3) * 3, 7, 6, k % 2 ? '#2a4a26' : '#35582e'); for (let k = 0; k < 6; k++) R(c, x + 2 + k * 6, y - 12 - (k % 2) * 3, 3, 1, '#4f7a3e'); },
    grade: (c, x, y) => { R(c, x, y - 14, 70, 2, '#1e2226'); R(c, x, y - 4, 70, 2, '#1e2226'); for (let k = 0; k < 70; k += 5) { R(c, x + k, y - 16, 2, 16, '#262a2e'); R(c, x + k, y - 18, 2, 2, '#3a4046'); } },
    flores: (c, x, y) => { PEC.arbusto(c, x, y); for (let k = 0; k < 9; k++) R(c, x + 2 + k * 4.5, y - 13 - (k % 3) * 2, 2, 2, pick(['#c84a5a', '#d8a83a', '#a85ab8', '#e8e2d2'], k + x)); },
    hidrante: (c, x, y) => { R(c, x, y - 16, 10, 16, '#7a2422'); R(c, x - 2, y - 18, 14, 3, '#8a2c2a'); R(c, x - 3, y - 11, 16, 3, '#6a1e1c'); R(c, x + 2, y - 16, 2, 14, '#9a3a36'); },
    sacos: (c, x, y) => { ell(c, x + 8, y - 6, 9, 7, '#121418'); ell(c, x + 20, y - 5, 7, 6, '#1a1c22'); R(c, x + 6, y - 14, 3, 3, '#121418'); R(c, x + 5, y - 9, 3, 1, '#3a3c44'); },
    bike: (c, x, y) => { for (const wx of [x + 6, x + 30]) { ell(c, wx, y - 7, 7, 7, '#16181c'); ell(c, wx, y - 7, 5, 5, 'rgba(0,0,0,0)'); R(c, wx - 1, y - 8, 2, 2, '#5a5e66'); } limb(c, [[x + 6, y - 7], [x + 16, y - 16], [x + 30, y - 7]], 2, '#7a2a2a'); limb(c, [[x + 16, y - 16], [x + 26, y - 17], [x + 30, y - 7]], 2, '#7a2a2a'); R(c, x + 13, y - 19, 7, 2, '#16181c'); },
    cone: (c, x, y) => { for (let k = 0; k < 16; k++) R(c, x + k * .35, y - k, 12 - k * .7, 1, k % 6 < 3 ? '#a8501a' : '#d8d2c0'); R(c, x - 3, y - 2, 18, 2, '#1e2226'); },
    capim: (c, x, y, seed, t) => { for (let k = 0; k < 14; k++) { const h = 10 + hash(seed + k) * 14, sw = Math.sin(t * 1.6 + k + seed) * 2; limb(c, [[x + k * 2, y], [x + k * 2 + sw + (k % 2 ? 2 : -2), y - h]], 1, k % 3 ? '#3f5a2a' : '#56703a'); } },
    pedra: (c, x, y) => { ell(c, x + 12, y - 5, 14, 8, '#4a4a44'); ell(c, x + 8, y - 8, 8, 4, '#5f5f56'); R(c, x + 4, y - 10, 5, 1, '#6f6f66'); },
    samambaia: (c, x, y) => { for (let k = 0; k < 6; k++) { const a = -2.6 + k * .45; for (let j = 0; j < 14; j++) { const px = x + 12 + Math.cos(a) * j * 1.6, py = y - Math.abs(Math.sin(a)) * j * 1.4; R(c, px, py, 2, 1, '#2f5a2e'); if (j % 2) R(c, px, py - 2, 1, 2, '#3f6a36'); } } },
    cafe: (c, x, y) => { for (let k = 0; k < 6; k++) ell(c, x + k * 6, y - 8 - (k % 2) * 4, 7, 7, k % 2 ? '#1f3a22' : '#2a4a2c'); for (let k = 0; k < 7; k++) R(c, x + 3 + k * 5, y - 10 - (k % 3) * 3, 2, 2, k % 2 ? '#8a1e1a' : '#a8302a'); },
    cadeiras: (c, x, y) => { for (let k = 0; k < 4; k++) { R(c, x + k * 13, y - 18, 11, 12, '#1f3a5a'); R(c, x + k * 13, y - 18, 11, 1, '#2f4a6a'); } R(c, x, y - 6, 52, 3, '#2a2e32'); R(c, x + 4, y - 3, 2, 3, '#2a2e32'); R(c, x + 46, y - 3, 2, 3, '#2a2e32'); },
    pilastra: (c, x, y) => { R(c, x, y - 22, 3, 22, '#5a5e64'); R(c, x + 40, y - 22, 3, 22, '#5a5e64'); R(c, x + 3, y - 20, 37, 2, '#2a3a6a'); R(c, x - 2, y - 2, 7, 2, '#3a3e44'); R(c, x + 38, y - 2, 7, 2, '#3a3e44'); },
    vaso: (c, x, y) => { R(c, x, y - 10, 16, 10, '#4a3a2e'); for (let k = 0; k < 6; k++) ell(c, x + 2 + k * 2.4, y - 16 - (k % 3) * 4, 4, 6, k % 2 ? '#24401e' : '#305028'); }
  };
  let fgCv = null, fgC = null; const FGDRAW = {};
  function primeiroPlano(ctx, o) {
    const id = o.scene, set = FG[FGSET[id]] || (FGDRAW[id] ? [] : null); if (!set || o.arena || o.room) return;
    if (!fgCv) [fgCv, fgC] = mk(LW, LH); const c = fgC, cam = Number(o.camera) || 0, camL = cam / 2, t = Number(o.time) || 0, k = 1.45, W = (window.CampanhaCenarios.largura(id) || 4000) / 2 * k;
    c.clearRect(0, 0, LW, LH);
    if (set.length) for (let i = 0, x = 60; x < W; i++) { const sx = x - camL * k; if (sx > -90 && sx < LW + 10) PEC[pick(set, i * 7 + id)](c, Math.round(sx), LH + 2, i * 13 + id, t); x += 190 + hash(i * 5 + id) * 260; }
    FGDRAW[id]?.(c, camL * k, t);
    const s = window.DayTime?.state?.() || { night: 0 }, a = night(s);
    c.save(); c.globalCompositeOperation = 'source-atop'; c.fillStyle = `rgba(8,12,26,${.25 + a * .5})`; c.fillRect(0, 0, LW, LH); c.restore();
    ctx.save(); ctx.translate(Math.round(cam), 0); ctx.imageSmoothingEnabled = false; ctx.drawImage(fgCv, 0, 0, LW * 2, LH * 2); ctx.restore();
  }

  /* =====================================================================
     LUZES (à noite) e ligação com os cenários
     ===================================================================== */
  function luzes(id, g, s, t, camL) {
    const a = night(s); if (a < .05) return;
    if (engarrafado(id)) { const J = JAM[id], y = J.lane; for (let k = 0; k < 26; k++) { const x = J.fusca - 66 - k * 64 - camL; if (vis(x, 60)) { lightAdd(x, y - 10, .35 * a, 14); lightAdd(x + 52, y - 10, .3 * a, 22); } } if (Math.floor(t * 3) % 2) lightAdd(J.fusca - camL + 2, y - 10, .6 * a, 20); }
    if (id === 19) { const sx = scr({ f: .2 }, 620, camL); if (vis(sx, 80)) lightAdd(sx, 92, .5 * a, 70); }
  }
  const MEIOFN = { 12: meioPatio, 13: meioEncosta, 14: meioComercio, 15: meioSerra, 16: meioAvenida, 17: meioMercado, 18: meioCafezal, 19: meioParque, 21: meioCondominio };
  function meio(id, c, s, t, camL) { const f = MEIOFN[id]; if (f) f(c, s, t, camL); }

  window.CampanhaCamadas = Object.freeze({
    meio, sobre, frente, luzes, entrar, primeiroPlano,
    falas: () => null,
    engarrafado,
    engarrafamento: (id, v) => { if (!JAM[id]) return false; if (v === null || v === undefined) { delete forcado[id]; return engarrafado(id); } forcado[id] = true; jamOn[id] = !!v; return jamOn[id]; },
    texto: pxText,
    // para os cenários novos (2C): mais gente e primeiro plano numa cena registrada depois
    configurar: (id, o = {}) => { if (o.povo) POVO[id] = o.povo; if (o.fg) FGSET[id] = o.fg; if (o.trilha) TRILHA.add(id); if (o.pecas) Object.assign(PEC, o.pecas); if (o.fgLista) { FG['c' + id] = o.fgLista; FGSET[id] = 'c' + id; } if (o.fgDraw) FGDRAW[id] = o.fgDraw; },
    kit: Object.freeze({ pxText, largura, pessoinha, carrinho, janelaM, lojaM, outdoorM, predioM, arvoreM, nevoa, buildRua, noiteTile, andaRua, scr, wrap, balao, carroG, cabeca, LOJAS_RUA, OUTDOORS, SKIN, ROUPA, T }),
    lojas: () => LOJAS_RUA.map((l) => l[0]),
    cenasComEngarrafamento: () => Object.keys(JAM).map(Number)
  });
})();
