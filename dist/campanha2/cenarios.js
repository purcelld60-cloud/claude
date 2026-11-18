/* Campanha 2 · Cenários (Passo 2).
   Dez cenários novos de Vitória da Conquista (BA), cenas 12 a 21, desenhados com as mesmas ferramentas
   e o mesmo estilo dos cenários HD atuais (HdMaps.kit): pixels de arte de 482x270 escalados 2x, chão em
   y=220 (440 na tela), parallax, céu realista com hora do dia, sombras do sol, luzes à noite e shader.
   Referências: fotos reais (Wikimedia Commons) do Cristo de Mário Cravo na Serra do Periperi, da Avenida
   Olívia Flores com a ciclovia no canteiro central, do Centro de Cultura e da vista da cidade (planalto
   plano coberto de prédios brancos e bege). Piada recorrente: Conquista é fria e tem neblina.
   Nada aqui muda as fases 0 a 11. A ligação com a campanha (menu, missões, chefes) vem no Passo 5. */
(() => {
  'use strict';
  if (window.CampanhaCenarios || !window.HdMaps?.register || !window.HdMaps.kit) return;
  const K = window.HdMaps.kit;
  const { LW, LH, FLOOR, R, ell, mk, hash, cl, css, mix, dither, limb, sky, haze, tile, tree, bush, slant, sunInfo, sunWall, board, win, bench, lampPost, lampGlow, paving, shadeAdd, lightAdd } = K;
  const vis = (x, m = 80) => x > -m && x < LW + m;
  const night = (s) => cl((s.night - .12) * 1.4);
  const text = (c, str, x, y, size, col, align = 'center') => { c.font = `${size}px Pixel, monospace`; c.textAlign = align; c.textBaseline = 'middle'; c.fillStyle = col; c.fillText(str, x, y); };

  /* ---------- fundo comum de Conquista ----------
     planalto plano até o horizonte, cidade de prédios brancos e bege e a Serra do Periperi com o Cristo */
  let FAR = null;
  function buildFar() {
    const T = 964, [a, ca] = mk(T, LH), [b, cb] = mk(T, LH), [n, cn] = mk(T, LH);
    // camada 1: horizonte do planalto, serra comprida e a cruz do Cristo bem pequena
    R(ca, 0, 150, T, 120, '#9db3a2'); for (let x = 0; x < T; x++) { const h = 6 + Math.sin(x * .011) * 4 + Math.sin(x * .037) * 2 + (x > 560 && x < 860 ? Math.sin((x - 560) / 300 * Math.PI) * 16 : 0); R(ca, x, 150 - h, 1, h, '#a9bdb0'); R(ca, x, 150 - h, 1, 1, '#c4d2c4'); }
    R(ca, 708, 120, 1, 10, '#6f7f78'); R(ca, 705, 122, 7, 1, '#6f7f78'); R(ca, 760, 126, 1, 9, '#7d8c85'); R(ca, 758, 126, 5, 1, '#7d8c85');
    // camada 2: cidade (prédios brancos e bege, telhados vermelhos) — de dia e as janelas acesas à noite
    for (let i = 0; i < 110; i++) {
      const x = Math.round(hash(i + 900) * T), w = 5 + Math.round(hash(i + 901) * 9), h = 6 + Math.round(Math.pow(hash(i + 902), 2) * 34), y = 158 - h;
      const col = ['#e9e6dc', '#ddd3bf', '#f2efe6', '#cfc6b2', '#e4dccb'][i % 5];
      R(cb, x, y, w, h + 6, col); R(cb, x + w - 2, y, 2, h + 6, '#b7ae9c'); for (let yy = y + 2; yy < 158; yy += 3) for (let xx = x + 1; xx < x + w - 2; xx += 2) { R(cb, xx, yy, 1, 1, '#9fb0b6'); if (hash(xx * 7 + yy) > .62) R(cn, xx, yy, 1, 1, '#ffd98a'); }
    }
    for (let i = 0; i < 160; i++) { const x = Math.round(hash(i + 300) * T), y = 156 + Math.round(hash(i + 301) * 10); R(cb, x, y, 5, 3, '#c97a5a'); R(cb, x, y + 3, 5, 3, '#e7dfcc'); if (hash(i + 302) > .5) R(cn, x + 2, y + 4, 1, 1, '#ffcf7a'); }
    R(cb, 0, 164, T, 106, '#a8b49a'); for (let x = 0; x < T; x += 3) R(cb, x, 164, 2, 1, '#bcc6ab');
    return { a, b, n };
  }
  // neblina: faixas largas e macias que andam devagar (a cidade é a "Suíça Baiana")
  let FOG = null;
  function buildFog() { const [cv, c] = mk(964, LH); for (let i = 0; i < 70; i++) { const x = hash(i + 50) * 964, y = 120 + hash(i + 51) * 120, rx = 30 + hash(i + 52) * 60, ry = 6 + hash(i + 53) * 10; for (let k = 0; k < 5; k++) ell(c, x, y, rx * (1 - k * .15), ry * (1 - k * .15), `rgba(236,240,244,${.07 + k * .03})`); } return cv; }
  function fog(c, s, t, camL, amount) {
    if (amount <= .01) return; if (!FOG) FOG = buildFog();
    const morning = s.h >= 4.5 && s.h < 9.5 ? 1 - Math.abs(s.h - 7) / 2.5 : 0, k = cl(amount * (.55 + morning * .8 + s.night * .25));
    c.globalAlpha = k * .9; tile(c, FOG, camL * .5 - t * 4); c.globalAlpha = k * .6; tile(c, FOG, camL * .8 + 300 - t * 7);
    c.globalAlpha = 1; const g = c.createLinearGradient(0, 140, 0, 230); g.addColorStop(0, 'rgba(230,236,240,0)'); g.addColorStop(1, `rgba(230,236,240,${.35 * k})`); c.fillStyle = g; c.fillRect(0, 140, LW, 90);
  }
  function conquistaBack(c, s, t, camL, o = {}) {
    if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); tile(c, FAR.a, camL * .03); haze(c, s, t, camL, 110, 175); tile(c, FAR.b, camL * (o.cityPar || .08)); cityNight(c, s, camL * (o.cityPar || .08), 0);
  }
  // janelas acesas da cidade ao longe: desenhadas junto com a cidade do fundo (os prédios da frente cobrem)
  function cityNight(c, s, off, dy) { const a = night(s); if (a < .03 || !FAR) return; c.save(); c.translate(0, dy); c.globalCompositeOperation = 'lighter'; c.globalAlpha = a; tile(c, FAR.n, off); tile(c, FAR.n, off); c.restore(); }
  function farLights() {} // (as luzes da cidade agora saem em cityNight, atrás dos prédios da frente)

  /* ---------- peças de cenário ---------- */
  function building(c, x, y, w, h, col, o = {}) { // fachada com janelas (y = topo, base em y+h)
    R(c, x - 1, y - 1, w + 2, h + 1, o.edge || '#5b5a52'); R(c, x, y, w, h, col); R(c, x, y, w, 2, o.top || 'rgba(255,255,255,.35)'); R(c, x + w - 3, y, 3, h, 'rgba(0,0,0,.08)');
    if (o.windows !== false) for (let yy = y + 6; yy < y + h - 14; yy += o.wy || 14) for (let xx = x + 5; xx < x + w - 10; xx += o.wx || 14) win(c, null, xx, yy, o.ww || 8, o.wh || 8, false);
    if (o.roof) { R(c, x - 3, y - 4, w + 6, 4, o.roof); R(c, x - 3, y - 4, w + 6, 1, 'rgba(255,255,255,.25)'); }
  }
  function awning(c, x, y, w, a, b) { for (let k = 0; k < w; k += 6) { R(c, x + k, y, 6, 7, (k / 6) % 2 ? a : b); R(c, x + k, y + 7, 6, 2, (k / 6) % 2 ? '#00000033' : '#ffffff22'); } R(c, x, y - 1, w, 1, '#3a3a34'); }
  function shopFront(c, x, w, col, sign, a, b) { // loja térrea com letreiro, toldo e vitrine
    building(c, x, 138, w, 72, col, { windows: false }); R(c, x + 4, 142, w - 8, 14, '#2c3a44'); R(c, x + 5, 143, w - 10, 12, sign); awning(c, x + 2, 160, w - 4, a, b);
    R(c, x + 6, 172, w - 12, 34, '#3a4c58'); R(c, x + 8, 174, w - 16, 30, '#7fa4b0'); R(c, x + 8, 174, w - 16, 8, '#a9ccd2'); for (let k = 0; k < 4; k++) R(c, x + 10 + k * ((w - 22) / 3), 192, 4, 12, ['#d9634a', '#e8c24c', '#5f9fd0', '#7cbf6a'][k]);
  }
  function house(c, x, w, h, col, roof, seed) { // casa baixa com muro e portão
    R(c, x - 2, 210 - h - 6, w + 4, 6, roof); for (let k = 0; k < w + 4; k += 3) R(c, x - 2 + k, 210 - h - 6, 2, 1, 'rgba(255,255,255,.25)');
    R(c, x, 210 - h, w, h, col); R(c, x, 210 - h, w, 1, 'rgba(255,255,255,.4)'); win(c, null, x + 6, 210 - h + 8, 12, 12, false); R(c, x + w - 18, 210 - h + 8, 12, h - 8, '#5a3c2a'); R(c, x + w - 17, 210 - h + 9, 10, h - 10, '#7a5a3c');
    R(c, x - 4, 196, w + 8, 14, shadeHex(col, .9)); R(c, x - 4, 196, w + 8, 2, '#f2efe6'); for (let k = 0; k < 6; k++) R(c, x + 2 + k * 5, 199, 1, 9, '#3c3c38'); if (hash(seed) > .5) { R(c, x + 4, 188, 10, 8, '#5f9a52'); R(c, x + 6, 186, 6, 3, '#e86a7a'); }
  }
  function shadeHex(hex, k) { if (!/^#[0-9a-f]{6}$/i.test(hex)) return hex; const n = parseInt(hex.slice(1), 16), f = (v) => Math.max(0, Math.min(255, Math.round(v * k))); return '#' + [(n >> 16) & 255, (n >> 8) & 255, n & 255].map((v) => f(v).toString(16).padStart(2, '0')).join(''); }
  function person(c, x, y, i, cold = true) { // gente pequena ao fundo (de casaco: faz frio)
    const coat = ['#3a4a6a', '#7a3a3a', '#4a6a4a', '#5a4a6a', '#6a5a3a', '#2a3a4a'][i % 6], skin = ['#e0b08a', '#9a6440', '#c88a60', '#6a4430'][i % 4];
    R(c, x, y - 12, 5, 7, coat); R(c, x + 1, y - 16, 3, 4, skin); R(c, x + 1, y - 17, 3, 1, '#2a201a'); R(c, x, y - 5, 2, 5, '#2a2f3a'); R(c, x + 3, y - 5, 2, 5, '#2a2f3a'); if (cold) R(c, x, y - 12, 5, 2, ['#d9634a', '#e8c24c', '#5f9fd0'][i % 3]);
  }
  function car(c, x, y, col, dir = 1) { const w = 26; R(c, x, y - 7, w, 6, col); R(c, x + (dir > 0 ? 6 : 4), y - 11, 15, 5, col); R(c, x + (dir > 0 ? 8 : 6), y - 10, 11, 3, '#9fc4d0'); R(c, x + 3, y - 2, 6, 3, '#1c1c1c'); R(c, x + w - 9, y - 2, 6, 3, '#1c1c1c'); R(c, dir > 0 ? x + w - 2 : x, y - 6, 2, 2, '#fff2b0'); R(c, dir > 0 ? x : x + w - 2, y - 6, 2, 2, '#d8443a'); R(c, x, y - 7, w, 1, 'rgba(255,255,255,.3)'); }
  function plank(c, x, y, w, col = '#8d6a45') { R(c, x - 1, y, w + 2, 7, '#3e2a1a'); R(c, x, y + 1, w, 5, col); R(c, x, y + 1, w, 1, '#c4955c'); }
  function sign(c, x, y, w, h, bg, fg, str, size = 8) { board(c, x, y, w, h, bg, '#22303a'); void fg; void str; void size; }
  function asphalt(c, W, lane = true) { R(c, 0, FLOOR, W, 50, '#5d6164'); R(c, 0, FLOOR, W, 3, '#c9c6b8'); R(c, 0, FLOOR + 3, W, 1, '#3c4042'); for (let x = 0; x < W; x += 2) if (hash(x * 3) > .7) R(c, x, FLOOR + 6 + Math.round(hash(x) * 40), 1, 1, '#6f7376'); if (lane) for (let x = 0; x < W; x += 34) R(c, x, 246, 16, 2, '#e8dc8a'); }
  function sidewalk(c, W, col = '#c9c3b2') { R(c, 0, 204, W, 16, col); for (let x = 0; x < W; x += 12) R(c, x, 204, 1, 16, 'rgba(0,0,0,.12)'); R(c, 0, 204, W, 1, '#ece6d4'); }
  function grass(c, W, y = FLOOR, a = '#5f8a46', b = '#4a7238') { R(c, 0, y, W, LH - y, '#6a5236'); R(c, 0, y, W, 6, a); dither(c, 0, y + 6, W, b); for (let x = 0; x < W; x += 3) R(c, x, y - 2 - Math.round(hash(x) * 3), 1, 3, x % 2 ? a : '#79a556'); for (let i = 0; i < W / 9; i++) R(c, hash(i + 7) * W, y + 12 + hash(i + 8) * 34, 3, 2, '#7a6246'); }
  function tiles(c, W, y = FLOOR, a = '#d8d6cc', b = '#c4c2b6', step = 16) { R(c, 0, y, W, LH - y, a); for (let x = 0; x < W; x += step) R(c, x, y, 1, LH - y, b); for (let yy = y + 10; yy < LH; yy += 12) R(c, 0, yy, W, 1, b); R(c, 0, y, W, 2, '#f4f2ea'); }

  /* ---------- 12 · Aeroportos ---------- */
  const AIR = { W: 2200 };
  function buildAir() {
    const [cv, c] = mk(AIR.W, LH);
    // ---- Aeroporto de Itabuna (0..1050): saguão, check-in e raio-x ----
    R(c, 0, 0, 1050, 34, '#d6d8d4'); for (let x = 10; x < 1050; x += 60) { R(c, x, 30, 30, 3, '#fff6d8'); } R(c, 0, 34, 1050, 2, '#9aa0a0');
    R(c, 0, 36, 1050, 174, '#ece8de'); for (let x = 0; x < 1050; x += 140) { R(c, x + 10, 50, 110, 90, '#2c4656'); R(c, x + 12, 52, 106, 86, '#8db8cc'); R(c, x + 12, 52, 106, 20, '#b5d6e0'); R(c, x + 64, 52, 2, 86, '#2c4656'); }
    for (let k = 0; k < 4; k++) { const x = 60 + k * 110; R(c, x, 168, 80, 42, '#7a8a96'); R(c, x, 168, 80, 4, '#c9d2d8'); R(c, x + 8, 150, 22, 14, '#1d2a34'); R(c, x + 10, 152, 18, 10, '#5ae0b0'); R(c, x + 50, 176, 22, 30, '#5a6670'); }
    R(c, 40, 120, 440, 16, '#1d4a7a'); R(c, 40, 120, 440, 1, '#5a8ac0');
    for (let x = 30; x < 520; x += 40) { R(c, x, 186, 2, 24, '#8a8f92'); R(c, x - 1, 185, 4, 2, '#c4c8ca'); } R(c, 30, 192, 492, 2, '#c43c3a');
    // raio-x: esteira com caixa e o pórtico detector de metais
    R(c, 600, 168, 160, 28, '#5a6670'); R(c, 600, 196, 160, 4, '#2c3238'); R(c, 640, 140, 70, 56, '#c4cad0'); R(c, 646, 150, 58, 30, '#2a3238'); R(c, 600, 166, 160, 3, '#8a949a');
    for (let k = 0; k < 4; k++) R(c, 606 + k * 38, 160, 22, 6, '#3c5a8a');
    R(c, 820, 120, 6, 90, '#9aa4ac'); R(c, 880, 120, 6, 90, '#9aa4ac'); R(c, 820, 118, 66, 8, '#9aa4ac'); R(c, 826, 126, 54, 2, '#5ae070');
    // portão de embarque: cadeiras e balcão
    for (let k = 0; k < 3; k++) for (let j = 0; j < 5; j++) { const x = 920 + k * 46 + j * 8; R(c, x, 196, 7, 6, '#3c6a9a'); R(c, x, 188, 7, 8, '#4f80b0'); R(c, x + 1, 202, 1, 8, '#555'); }
    // ---- pista (1050..1500): o avião com a escada ----
    R(c, 1050, 0, 450, 210, 'rgba(0,0,0,0)');
    // ---- Aeroporto Glauber Rocha (1500..2200): fachada de vidro, cobertura branca e a esteira ----
    R(c, 1500, 60, 700, 150, '#dfe3e4'); R(c, 1480, 40, 740, 22, '#f8f8f4'); R(c, 1480, 62, 740, 3, '#9aa4a8'); R(c, 1480, 40, 740, 2, '#ffffff'); for (let k = 0; k < 8; k++) { R(c, 1520 + k * 90, 65, 5, 145, '#8a949a'); R(c, 1521 + k * 90, 65, 2, 145, '#b4bcc0'); }
    for (let x = 1510; x < 2190; x += 28) { R(c, x, 72, 26, 118, '#4f7a8e'); R(c, x + 1, 73, 24, 116, '#9cc6d4'); R(c, x + 1, 73, 24, 30, '#c4e0e8'); }
    R(c, 0, 210, AIR.W, 10, '#c4c8c6'); R(c, 0, 210, AIR.W, 2, '#eef0ee'); R(c, 0, 218, AIR.W, 2, '#9aa0a0');
    tiles(c, AIR.W, FLOOR, '#d9d7ce', '#c6c3b8', 20);
    R(c, 1500, 190, 700, 20, '#c9ccc8'); R(c, 1700, 176, 220, 20, '#3c444a'); for (let k = 0; k < 9; k++) R(c, 1708 + k * 24, 170, 14, 8, ['#c43c3a', '#3c6a9a', '#e8c24c', '#4a8a5a'][k % 4]); R(c, 1700, 176, 220, 2, '#8a949a');
    return cv;
  }
  let airMid = null;
  function aeroporto(c, s, t, camL) {
    if (!airMid) airMid = buildAir();
    conquistaBack(c, s, t, camL);
    // pista e avião ao fundo da parte externa
    const px = 1050 - camL;
    if (vis(px, 500)) { R(c, px, 150, 450, 60, '#7a8288'); for (let k = 0; k < 450; k += 40) R(c, px + k, 180, 20, 2, '#f2f2e6');
      const ax = px + 70; R(c, ax, 120, 300, 34, '#f2f4f6'); R(c, ax + 290, 124, 30, 24, '#f2f4f6'); R(c, ax - 20, 130, 24, 18, '#f2f4f6'); R(c, ax - 30, 90, 26, 40, '#3c6aa8'); R(c, ax + 120, 146, 120, 8, '#c9ced2'); R(c, ax + 140, 154, 18, 10, '#5a6670');
      for (let k = 0; k < 16; k++) R(c, ax + 30 + k * 16, 128, 6, 6, '#3c4a5a'); R(c, ax, 140, 300, 3, '#3c6aa8'); R(c, ax + 50, 136, 14, 18, '#c8ced4');
      for (let k = 0; k < 8; k++) R(c, ax + 40 + k * 3, 154 + k * 6, 12, 2, '#9aa0a6'); R(c, ax + 36, 154, 2, 54, '#9aa0a6'); R(c, ax + 64, 154, 2, 54, '#9aa0a6'); }
    c.drawImage(airMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // painel de voos piscando, passageiros e malas
    { const x = 300 - camL; if (vis(x, 100)) { R(c, x, 64, 120, 40, '#14202a'); for (let k = 0; k < 4; k++) { R(c, x + 6, 70 + k * 8, 60, 4, '#f2c94c'); R(c, x + 74, 70 + k * 8, 38, 4, (Math.sin(t * 3 + k) > 0 || k) ? '#5ae070' : '#14202a'); } } }
    for (let i = 0; i < 9; i++) { const wx = 150 + i * 220 + Math.sin(t * .3 + i) * 30, x = wx - camL; if (vis(x, 20)) { person(c, x, 210, i, false); R(c, x + 6, 202, 6, 8, ['#c43c3a', '#2c4a6a', '#e8c24c'][i % 3]); } }
    { const x = 1930 - camL; if (vis(x, 60)) { R(c, x, 196, 30, 14, '#e8c24c'); R(c, x, 196, 30, 3, '#2a2a2a'); text(c, 'TÁXI', x + 15, 203, 5, '#2a2a2a'); } } // táxi do Seu Zé na saída
    fog(c, s, t, camL, .25);
  }
  function aeroportoText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'AEROPORTO DE ITABUNA', 520, 258, 10, '#f2f2e6'); text(c, 'RAIO-X', 1406, 290, 8, '#2c3a44'); text(c, 'EMBARQUE · PORTÃO 1', 1950, 250, 8, '#2c3a44'); text(c, 'AEROPORTO GLAUBER ROCHA · VITÓRIA DA CONQUISTA', 3700, 102, 11, '#2a3aa8'); text(c, 'BEM-VINDO À SUÍÇA BAIANA. TRAGA CASACO.', 3700, 148, 6, '#c43c3a'); c.restore(); }
  function aeroportoLights(g, s, t, camL) { farLights(g, s, camL); const a = night(s); for (let x = 10; x < 1050; x += 60) { const sx = x + 15 - camL; if (vis(sx)) lightAdd(sx, 30, .3 + a * .4, 60); } }

  /* ---------- 13 · Bairro da pensão (hub) ---------- */
  const BAIRRO = { W: 2100 };
  function buildBairro() {
    const [cv, c] = mk(BAIRRO.W, LH); const cols = ['#e9d8b4', '#c9dcc8', '#e8c4b4', '#d4d8e8', '#f0e2a8', '#d8c8e0'], roofs = ['#a8543c', '#9a4a34', '#b8644a'];
    for (let i = 0, x = 20; x < BAIRRO.W - 40; i++) { const w = 60 + Math.round(hash(i + 40) * 40); if (x > 760 && x < 1010) { x = 1010; continue; } house(c, x, w, 34 + Math.round(hash(i + 41) * 22), cols[i % cols.length], roofs[i % 3], i); x += w + 10; }
    // Pensão Dona Lurdes: sobrado de dois andares
    const px = 780; R(c, px - 4, 92, 228, 6, '#8a4430'); R(c, px, 98, 220, 112, '#f2dfb0'); R(c, px, 98, 220, 2, '#fff5d0'); R(c, px, 152, 220, 4, '#d8c08a');
    for (let k = 0; k < 6; k++) { win(c, null, px + 12 + k * 35, 108, 16, 18, false); R(c, px + 10 + k * 35, 126, 20, 2, '#8a5a3c'); for (let j = 0; j < 5; j++) R(c, px + 11 + k * 35 + j * 4, 128, 1, 5, '#5a3c2a'); }
    for (let k = 0; k < 3; k++) win(c, null, px + 12 + k * 35, 164, 16, 18, false); R(c, px + 130, 162, 26, 48, '#6a3c24'); R(c, px + 132, 164, 22, 44, '#8a5a3c'); R(c, px + 150, 186, 2, 3, '#e8c24c');
    board(c, px + 40, 140, 140, 10, '#f8f0d8', '#5a3c2a');
    // padaria e mercadinho
    shopFront(c, 1130, 96, '#f0e6cc', '#c47a35', '#c43c3a', '#f2efe6'); shopFront(c, 1500, 110, '#dde8d4', '#3c7a4a', '#3c7a4a', '#f2efe6');
    // postes com fiação
    for (let x = 60; x < BAIRRO.W; x += 230) { R(c, x, 60, 3, 150, '#7a756a'); R(c, x - 10, 64, 23, 2, '#5a554a'); }
    for (let x = 60; x < BAIRRO.W - 230; x += 230) for (let k = 0; k < 230; k += 2) { const yy = 66 + Math.round(Math.sin(k / 230 * Math.PI) * 9); R(c, x + k, yy, 2, 1, '#2a2a2a'); R(c, x + k, yy + 4, 2, 1, '#2a2a2a'); }
    sidewalk(c, BAIRRO.W); asphalt(c, BAIRRO.W, true); return cv;
  }
  let bairroMid = null;
  function bairro(c, s, t, camL) {
    if (!bairroMid) bairroMid = buildBairro();
    conquistaBack(c, s, t, camL);
    c.drawImage(bairroMid, camL, 0, LW, LH, 0, 0, LW, LH);
    const sun = sunInfo(s), reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.22 * sun.str})`;
    for (const x of [120, 560, 1050, 1420, 1880]) { const sx = x - camL; if (vis(sx, 80)) { if (sun.str > .04) ell(c, sx + reach, 219, 18, 2.5, sh); tree(c, sx, 214, .8, 0, t, x); } }
    for (let i = 0; i < 6; i++) { const wx = 200 + i * 330 + Math.sin(t * .2 + i * 2) * 60, sx = wx - camL; if (vis(sx, 20)) person(c, sx, 204, i); }
    { const cx = ((t * 30) % 2600) - 260 - camL; if (vis(cx, 40)) car(c, cx, 240, '#c43c3a', 1); }
    // fumaça de pão quente saindo da padaria
    { const x = 1178 - camL; if (vis(x, 40)) for (let i = 0; i < 5; i++) { const k = (t * .3 + i / 5) % 1; R(c, x + Math.sin(t + i) * 3 * k, 138 - k * 30, 3 + k * 4, 2, `rgba(240,240,236,${(1 - k) * .5})`); } }
    fog(c, s, t, camL, .55);
  }
  function bairroText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'PENSÃO DONA LURDES · QUARTOS', 1780, 290, 8, '#5a3c2a'); text(c, 'PADARIA PÃO QUENTE', 2356, 299, 7, '#fff4dc'); text(c, 'MERCADINHO DO PLANALTO', 3110, 299, 7, '#eef6ea'); c.restore(); }
  function bairroLights(g, s, t, camL) { farLights(g, s, camL); const a = night(s); if (a < .03) return; for (let x = 60; x < BAIRRO.W; x += 230) lampGlow(g, x - camL + 1, 64, a); for (let k = 0; k < 6; k++) { const sx = 780 + 20 + k * 35 - camL; if (vis(sx) && hash(k + 9) > .3) { g.fillStyle = `rgba(255,214,140,${.55 * a})`; g.fillRect(sx - 6, 110, 12, 14); } } }

  /* ---------- 14 · Centro e Praça da Catedral ---------- */
  const CENTRO = { W: 2500, CAT: 1180 };
  function cathedral(c, x) { // fiel à foto: fachada creme, uma torre central com relógio e agulha com cruz,
    // janelas ogivais duplas, pináculos nos cantos, nave lateral com janelas altas e grade de ferro na frente
    const wall = '#eedfb6', white = '#f8f3e4', sh = '#cdb98a', dark = '#4f4636', glass = '#5a6f86';
    const ogive = (c, gx, gy, w, h, col = glass) => { R(c, gx, gy + 3, w, h - 3, white); R(c, gx + 1, gy + 4, w - 2, h - 5, col); R(c, gx + 1, gy + 2, w - 2, 2, white); R(c, gx + Math.floor(w / 2) - 1, gy, 2, 2, white); R(c, gx + Math.floor(w / 2) - 1, gy + 2, 2, 2, col); };
    // nave lateral (à direita) com pilastras e janelas altas
    R(c, x + 90, 120, 190, 90, wall); R(c, x + 90, 116, 190, 5, white); for (let k = 0; k < 6; k++) { const px = x + 100 + k * 30; R(c, px, 118, 5, 92, white); R(c, px + 1, 112, 3, 6, white); ogive(c, px + 11, 132, 10, 34); ogive(c, px + 11, 176, 10, 22); }
    R(c, x + 278, 116, 3, 94, sh);
    // fachada principal com frontão e pináculos
    R(c, x, 110, 92, 100, wall); R(c, x, 108, 92, 3, white); for (let k = 0; k < 14; k++) R(c, x + 6 + k * 3.2, 108 - k, 92 - 12 - k * 6.4 > 0 ? 92 - 12 - k * 6.4 : 2, 1, k % 3 ? wall : white);
    for (const px of [x - 4, x + 88]) { R(c, px, 104, 8, 106, white); R(c, px + 2, 92, 4, 12, white); R(c, px + 3, 88, 2, 4, white); }
    ogive(c, x + 34, 150, 24, 60, '#5a3c28'); R(c, x + 45, 156, 2, 54, '#3c2818'); ogive(c, x + 10, 160, 14, 50, '#5a3c28'); ogive(c, x + 68, 160, 14, 50, '#5a3c28');
    ogive(c, x + 14, 124, 8, 24); ogive(c, x + 70, 124, 8, 24); ogive(c, x + 38, 118, 7, 24); ogive(c, x + 47, 118, 7, 24);
    // torre central: dois andares de janelas ogivais duplas, relógio e agulha com cruz
    const tx = x + 28, tw = 36; R(c, tx, 40, tw, 70, wall); R(c, tx, 40, tw, 2, white); R(c, tx - 2, 40, 3, 70, white); R(c, tx + tw - 1, 40, 3, 70, white); R(c, tx + tw - 4, 42, 3, 68, sh);
    ogive(c, tx + 9, 82, 8, 22); ogive(c, tx + 19, 82, 8, 22); ogive(c, tx + 9, 52, 8, 20, dark); ogive(c, tx + 19, 52, 8, 20, dark);
    ell(c, tx + 18, 46, 7, 5, white); ell(c, tx + 18, 46, 5, 4, '#f4f0e2'); R(c, tx + 18, 43, 1, 3, dark); R(c, tx + 18, 46, 3, 1, dark);
    for (let k = 0; k < 24; k++) { const w = Math.max(2, tw - 4 - k * 1.4); R(c, tx + tw / 2 - w / 2, 36 - k * 2.2, w, 2.3, k % 4 === 0 ? white : wall); } R(c, tx + tw / 2 - 1, -24, 2, 10, '#5a5248'); R(c, tx + tw / 2 - 4, -21, 8, 2, '#5a5248');
    for (const px of [tx - 3, tx + tw - 1]) { R(c, px, 28, 4, 12, white); R(c, px + 1, 24, 2, 4, white); }
    // grade de ferro e escada na frente
    R(c, x - 20, 198, 320, 2, '#2e2e2c'); for (let k = 0; k < 320; k += 4) R(c, x - 20 + k, 198, 1, 12, '#3a3a36'); R(c, x + 30, 204, 36, 6, '#c9c1aa');
  }
  function buildCentro() {
    const [cv, c] = mk(CENTRO.W, LH), x = CENTRO.CAT;
    const shops = [['#f0e6cc', '#c43c3a', '#c43c3a', '#f2efe6'], ['#dde4ec', '#2c5a8a', '#2c5a8a', '#f2efe6'], ['#f2e4d8', '#3c7a4a', '#e8c24c', '#3c7a4a'], ['#ece4f2', '#7a3a8a', '#7a3a8a', '#f2efe6'], ['#e8f0e4', '#c47a35', '#c47a35', '#f2efe6']];
    for (let i = 0, sx = 20; sx < 900; i++, sx += 120) { building(c, sx, 60, 110, 78, ['#e9e6dc', '#ddd3bf', '#e4dccb'][i % 3]); const p = shops[i % 5]; shopFront(c, sx, 110, p[0], p[1], p[2], p[3]); }
    // praça: canteiros, palmeiras e bancos
    R(c, 920, 196, 660, 14, '#5f8a46'); for (let k = 920; k < 1580; k += 4) R(c, k, 194 - Math.round(hash(k) * 2), 2, 3, '#79a556'); for (let k = 0; k < 18; k++) R(c, 930 + k * 36, 199, 4, 3, ['#e86a7a', '#e8c24c', '#f2efe6'][k % 3]);
    cathedral(c, x);
    // Memorial (casarão antigo) e mais comércio
    building(c, 1700, 110, 170, 100, '#f2e8c8', { windows: false, roof: '#a8543c' }); for (let k = 0; k < 6; k++) { R(c, 1710 + k * 27, 128, 14, 26, '#5a7a8a'); R(c, 1708 + k * 27, 126, 18, 3, '#d8c8a0'); R(c, 1710 + k * 27, 168, 14, 32, '#6a4a32'); }
    for (let i = 0, sx = 1900; sx < CENTRO.W - 100; i++, sx += 120) { building(c, sx, 50, 110, 88, ['#ddd3bf', '#e9e6dc', '#cfc6b2'][i % 3]); const p = shops[(i + 2) % 5]; shopFront(c, sx, 110, p[0], p[1], p[2], p[3]); }
    for (let x = 30; x < CENTRO.W; x += 260) { R(c, x, 40, 3, 170, '#6a665c'); R(c, x - 8, 44, 19, 2, '#4a463c'); if (x + 260 < CENTRO.W) for (let k = 0; k < 260; k += 2) { const yy = 46 + Math.round(Math.sin(k / 260 * Math.PI) * 8); R(c, x + k, yy, 2, 1, '#2a2a2a'); R(c, x + k, yy + 5, 2, 1, '#2a2a2a'); } }
    for (let lx = 940; lx < 1600; lx += 110) lampPost(c, lx, 131);
    paving(c, CENTRO.W, '#c9c4b4', '#b4ae9c', '#a49e8c', '#e8e4d4', 24); for (let x = 880; x < 940; x += 6) R(c, x, 226, 3, 40, '#e8c24c'); return cv;
  }
  let centroMid = null;
  function centro(c, s, t, camL) {
    if (!centroMid) centroMid = buildCentro();
    conquistaBack(c, s, t, camL, { cityPar: .1 });
    c.drawImage(centroMid, camL, 0, LW, LH, 0, 0, LW, LH);
    const sun = sunInfo(s), reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.22 * sun.str})`;
    if (sun.str > .04) { const cx = CENTRO.CAT - camL; if (vis(cx, 300)) { slant(c, cx - 4, cx + 282, 210, reach * 1.6, 9, sh); shadeAdd(cx - 4 + reach, cx + 282 + reach, 1); sunWall(c, cx, 110, 92, 100, sun.lean, Math.min(1, Math.abs(sun.lean) * 1.4) * sun.str); sunWall(c, cx + 90, 120, 190, 90, sun.lean, Math.min(1, Math.abs(sun.lean) * 1.4) * sun.str * .7); } }
    for (const x of [950, 1050, 1150, 1500, 1600]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 214, .9, 1, t, x); }
    for (const x of [990, 1430]) { const sx = x - camL; if (vis(sx, 60)) bench(c, sx, 212, 40, '#8a6a45', '#c4955c'); }
    for (let i = 0; i < 10; i++) { const wx = 100 + i * 240 + Math.sin(t * .25 + i) * 50, sx = wx - camL; if (vis(sx, 20)) person(c, sx, 216, i); }
    // pombos na praça
    for (let i = 0; i < 7; i++) { const sx = 1100 + i * 40 - camL + Math.sin(t * 2 + i) * 2; if (vis(sx, 10)) { R(c, sx, 214, 4, 3, '#8a8f98'); R(c, sx + 3, 212, 2, 2, '#6a6f78'); } }
    fog(c, s, t, camL, .25);
  }
  function centroText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'CATEDRAL NOSSA SENHORA DAS VITÓRIAS', CENTRO.CAT * 2 + 280, 448, 7, '#5a5246'); text(c, 'PRAÇA TANCREDO NEVES', 2500, 384, 7, '#f2efe6'); text(c, 'MEMORIAL', 3570, 238, 7, '#5a3c2a');
    ['CALÇADOS', 'MODAS', 'FARMÁCIA', 'RELÓGIOS', 'BISCOITOS', 'ÓTICA', 'PAPELARIA', 'CELULARES'].forEach((n, i) => text(c, n, (20 + i * 120 + 55) * 2, 298, 7, '#f2efe6')); c.restore(); }
  function centroLights(g, s, t, camL) { farLights(g, s, camL, { cityPar: .1 }); const a = night(s); if (a < .03) return; for (let x = 940; x < 1600; x += 110) lampGlow(g, x - camL, 130, a);
    const cx = CENTRO.CAT - camL; if (vis(cx, 260)) { const gr = g.createRadialGradient(cx + 70, 160, 10, cx + 70, 160, 170); gr.addColorStop(0, `rgba(255,220,160,${.35 * a})`); gr.addColorStop(1, 'rgba(255,220,160,0)'); g.fillStyle = gr; g.fillRect(cx - 120, 0, 380, 220); lightAdd(cx + 70, 100, a * .6, 160); }
    for (let i = 0; i < 16; i++) { const sx = (i < 8 ? 20 + i * 120 : 1840 + (i - 8) * 120) + 55 - camL; if (vis(sx, 60)) { g.fillStyle = `rgba(255,236,190,${.4 * a})`; g.fillRect(sx - 47, 174, 94, 30); } } }

  /* ---------- 15 · Serra do Periperi e o Cristo de Mário Cravo ---------- */
  const SERRA = { W: 2400, CRISTO: 2180 };
  function cactus(c, x, y) { ell(c, x, y - 5, 6, 6, '#3f7a4a'); for (let k = -4; k <= 4; k += 2) R(c, x + k, y - 10, 1, 10, '#2f5f38'); R(c, x - 3, y - 13, 7, 3, '#c43c5a'); R(c, x - 2, y - 14, 5, 1, '#e86a7a'); } // cabeça-de-frade, cacto típico da serra
  function buildSerra() {
    const [cv, c] = mk(SERRA.W, LH);
    // morro: rochas cinza, cerrado baixo, trilha e antenas
    for (let x = 0; x < SERRA.W; x++) { const h = 40 + Math.sin(x * .006) * 18 + Math.sin(x * .021) * 6 + (x / SERRA.W) * 34; R(c, x, 210 - h, 1, h, '#86865f'); R(c, x, 210 - h, 1, 2, '#a4a47e'); R(c, x, 210 - h + 2, 1, 3, '#7a7a54'); }
    for (let i = 0; i < 2600; i++) { const x = hash(i + 4100) * SERRA.W, y = 140 + hash(i + 4101) * 70; R(c, x, y, 2, 1, i % 3 ? '#7a7a56' : '#95956c'); }
    for (let i = 0; i < 70; i++) { const x = hash(i + 600) * SERRA.W, y = 150 + hash(i + 601) * 50, w = 10 + hash(i + 602) * 26; ell(c, x, y, w, 6 + hash(i + 603) * 6, '#9a9a90'); ell(c, x - 2, y - 2, w * .7, 3, '#b8b8ae'); }
    for (let i = 0; i < 160; i++) { const x = hash(i + 700) * SERRA.W, y = 160 + hash(i + 701) * 50; ell(c, x, y, 4 + hash(i) * 5, 3, i % 2 ? '#5a7a3c' : '#6a8a44'); }
    for (let i = 0; i < 30; i++) cactus(c, 40 + hash(i + 800) * (SERRA.W - 80), 204);
    for (const x of [520, 1340]) { R(c, x, 40, 3, 130, '#9a3a34'); for (let k = 40; k < 170; k += 12) { R(c, x - 6 + (k % 24 ? 0 : 0), k, 15, 1, '#c8c8c0'); R(c, x - 6, k, 1, 12, '#c8c8c0'); R(c, x + 8, k, 1, 12, '#c8c8c0'); } R(c, x, 34, 3, 6, '#e8443a'); }
    // o Cristo: cruz alta e fina de concreto sobre um disco num pilar, Cristo alongado (Mário Cravo)
    const x = SERRA.CRISTO, cc = '#a49c90', cd = '#7f776c';
    R(c, x - 6, 168, 14, 38, cd); R(c, x - 4, 168, 10, 38, cc); ell(c, x + 1, 166, 40, 5, cd); ell(c, x + 1, 164, 38, 4, '#b8b0a4');
    R(c, x - 3, 10, 9, 154, cd); R(c, x - 2, 10, 7, 154, cc); R(c, x - 2, 10, 2, 154, '#c4bcb0'); R(c, x - 34, 30, 72, 8, cd); R(c, x - 34, 31, 72, 6, cc); R(c, x - 34, 31, 72, 2, '#c4bcb0');
    const fig = '#6a5a4a', figL = '#9a8a76'; ell(c, x + 1, 44, 4, 5, fig); R(c, x - 2, 49, 7, 30, fig); R(c, x - 1, 79, 5, 34, fig); R(c, x - 2, 112, 7, 5, fig); R(c, x - 3, 70, 9, 8, '#7a6a58'); for (let k = 0; k < 15; k++) { R(c, x - 32 + k * 2, 36 + Math.round(k * .6), 3, 4, fig); R(c, x + 5 + k * 2, 45 - Math.round(k * .6), 3, 4, fig); } R(c, x - 1, 50, 1, 28, figL); R(c, x + 1, 80, 1, 30, figL); R(c, x - 34, 35, 3, 3, figL); R(c, x + 34, 35, 3, 3, figL);
    for (const hx of [x - 120, x - 80, x + 70]) { R(c, hx, 182, 26, 24, '#f2ece0'); R(c, hx - 2, 176, 30, 6, '#b8644a'); R(c, hx + 9, 192, 7, 14, '#6a4a32'); }
    grass(c, SERRA.W, FLOOR, '#7a8a4a', '#5f6e3a'); return cv;
  }
  let serraMid = null;
  function serra(c, s, t, camL) {
    if (!serraMid) serraMid = buildSerra(); if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); tile(c, FAR.a, camL * .02);
    // do alto se vê a cidade lá embaixo, mais perto conforme sobe
    c.save(); c.translate(0, 18); tile(c, FAR.b, camL * .06); c.restore(); cityNight(c, s, camL * .06, 18); haze(c, s, t, camL, 120, 190);
    c.drawImage(serraMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // vento: capim balançando e nuvens de neblina passando rápido
    for (let i = 0; i < 70; i++) { const wx = i * 34 + 7, sx = wx - camL % 34 - (camL - (camL % 34)) * 0; const x = ((wx - camL) % (LW + 40) + LW + 40) % (LW + 40) - 20, sw = Math.round(Math.sin(t * 4 + i) * 2 + 1); R(c, x + sw, FLOOR - 7, 1, 7, '#a4a46a'); R(c, x + 2 + sw, FLOOR - 5, 1, 5, '#8a8a52'); void sx; }
    fog(c, s, t * 3, camL, .6);
  }
  function serraText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'SERRA DO PERIPERI', 400, 160, 10, '#f2efe6'); text(c, 'CRISTO DE MÁRIO CRAVO', SERRA.CRISTO * 2, 438, 7, '#3a3a34'); text(c, 'MIRANTE · VENTO FORTE · SEGURA O CHAPÉU', 2600, 300, 6, '#f2efe6'); c.restore(); }
  function serraLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (const x of [520, 1340]) { const sx = x - camL; if (vis(sx) && Math.sin(t * 3) > 0) { g.fillStyle = `rgba(255,80,60,${a})`; g.fillRect(sx - 1, 32, 5, 5); } } const cx = SERRA.CRISTO - camL; if (vis(cx, 120)) { const gr = g.createRadialGradient(cx, 90, 4, cx, 90, 90); gr.addColorStop(0, `rgba(255,236,200,${.35 * a})`); gr.addColorStop(1, 'rgba(255,236,200,0)'); g.fillStyle = gr; g.fillRect(cx - 90, 0, 180, 210); lightAdd(cx, 20, a * .7, 120); } }
  function c2tile(g, off, dy) { if (!FAR) return; g.save(); g.translate(0, dy); tile(g, FAR.n, off); g.restore(); }

  /* ---------- 16 · Monumento ao Índio e avenidas ---------- */
  const AVENIDA = { W: 3000, INDIO: 1500 };
  function buildAvenida() {
    const [cv, c] = mk(AVENIDA.W, LH);
    for (let i = 0, x = 10; x < AVENIDA.W; i++) { const w = 70 + Math.round(hash(i + 70) * 60), h = 40 + Math.round(hash(i + 71) * 90); if (Math.abs(x + w / 2 - AVENIDA.INDIO) < 260) { x += w + 30; continue; } building(c, x, 150 - h, w, h + 10, ['#e9e6dc', '#ddd3bf', '#f2efe6', '#cfd6dc'][i % 4], { wx: 12, wy: 12 }); x += w + 24; }
    // posto, concessionária e outdoors
    R(c, 300, 120, 160, 8, '#c43c3a'); R(c, 300, 128, 160, 4, '#f2efe6'); for (const k of [310, 440]) R(c, k, 132, 6, 78, '#9aa0a6'); for (let k = 0; k < 3; k++) { R(c, 340 + k * 34, 176, 14, 30, '#e8e4dc'); R(c, 342 + k * 34, 180, 10, 8, '#2c3a44'); }
    for (const bx of [800, 2200, 2700]) { R(c, bx, 60, 120, 54, '#2a2f34'); R(c, bx + 3, 63, 114, 48, ['#e8c24c', '#5f9fd0', '#e86a7a'][bx % 3]); R(c, bx + 50, 114, 4, 96, '#5a5e62'); }
    // rotatória do Monumento ao Índio: canteiro redondo, pedestal de pedra e a estátua de bronze com arco
    const x = AVENIDA.INDIO; ell(c, x, 204, 120, 8, '#4a7238'); ell(c, x, 202, 116, 7, '#5f8a46'); for (let k = 0; k < 20; k++) R(c, x - 100 + k * 10, 198, 3, 3, ['#e86a7a', '#e8c24c', '#f2efe6'][k % 3]);
    R(c, x - 22, 146, 44, 54, '#8a8478'); R(c, x - 22, 146, 44, 3, '#b0aa9c'); for (let k = 0; k < 6; k++) R(c, x - 22 + (k % 2) * 14, 152 + k * 8, 16, 1, '#6f6a60'); R(c, x - 26, 196, 52, 6, '#6f6a60');
    // estátua de bronze: guerreiro de pé com cocar, segurando o arco esticado (silhueta e luz de bronze)
    const b = '#5e4128', bm = '#7a5634', bh = '#a7804c';
    R(c, x - 5, 66, 11, 12, b); R(c, x - 4, 66, 4, 12, bm); R(c, x - 1, 70, 2, 2, '#3a2818'); // cabeça
    for (let k = 0; k < 7; k++) { const a = -1.3 + k * .43, fx = x + Math.cos(a) * 9, fy = 66 + Math.sin(a) * 9; R(c, fx - 1, fy - 5, 3, 7, ['#c9a24a', '#b8443a', '#3c7a4a'][k % 3]); } R(c, x - 8, 64, 17, 3, '#8a4a2a'); // cocar
    R(c, x - 3, 78, 7, 4, b); R(c, x - 11, 82, 23, 8, b); R(c, x - 11, 82, 23, 2, bh); R(c, x - 8, 90, 17, 18, b); R(c, x - 8, 90, 5, 18, bm); R(c, x - 2, 92, 1, 12, '#4a3220'); // ombros e tronco
    R(c, x - 9, 106, 19, 7, '#8a6a3c'); for (let k = 0; k < 5; k++) R(c, x - 8 + k * 4, 113, 3, 6, '#7a5a34'); // tanga
    R(c, x - 7, 113, 6, 31, b); R(c, x - 7, 113, 2, 31, bm); R(c, x + 2, 113, 6, 31, b); R(c, x + 6, 113, 2, 31, '#4a3220'); R(c, x - 9, 142, 9, 4, b); R(c, x + 1, 142, 9, 4, b); // pernas
    limb(c, [[x - 10, 84], [x - 18, 92], [x - 22, 86]], 4, b); limb(c, [[x + 11, 84], [x + 22, 86], [x + 30, 84]], 4, b); // braços puxando o arco
    for (let k = 0; k <= 40; k++) { const yy = 62 + k * 1.1, xx = x + 32 + Math.round(Math.sin(k / 40 * Math.PI) * 7); R(c, xx, yy, 2, 2, '#4a3220'); } R(c, x + 32, 62, 1, 46, '#d8c8a0'); // arco e corda
    limb(c, [[x - 22, 86], [x + 34, 84]], 1, '#c8a46a'); R(c, x + 33, 83, 4, 3, '#9a9a9a'); // flecha
    R(c, x - 11, 82, 1, 8, bh); R(c, x - 6, 92, 1, 14, bh); R(c, x - 5, 115, 1, 26, bh);
    sidewalk(c, AVENIDA.W, '#c9c3b2'); asphalt(c, AVENIDA.W, true); return cv;
  }
  let aveMid = null;
  function avenida(c, s, t, camL) {
    if (!aveMid) aveMid = buildAvenida();
    conquistaBack(c, s, t, camL, { cityPar: .12 });
    c.drawImage(aveMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // faixas do fundo com trânsito (carros, ônibus e motos) indo e voltando
    R(c, 0, 186, LW, 18, '#5d6164'); R(c, 0, 194, LW, 1, '#e8dc8a');
    for (let i = 0; i < 9; i++) { const dir = i % 2 ? 1 : -1, sp = 40 + (i % 3) * 18, wx = ((i * 337 + t * sp * dir) % 3200 + 3200) % 3200 - 100, sx = wx - camL; if (!vis(sx, 40)) continue;
      if (i % 4 === 3) { R(c, sx, 178, 44, 14, '#3c7aa8'); R(c, sx + 2, 180, 40, 5, '#a9ccd8'); R(c, sx + 4, 192, 6, 3, '#1c1c1c'); R(c, sx + 32, 192, 6, 3, '#1c1c1c'); }
      else if (i % 3 === 2) { R(c, sx, 188, 12, 4, '#2a2a2a'); R(c, sx + 2, 182, 5, 6, ['#c43c3a', '#f08a24'][i % 2]); R(c, sx + 3, 179, 4, 3, '#c43c3a'); }
      else car(c, sx, dir > 0 ? 194 : 202, ['#c43c3a', '#f2f2ee', '#3c6aa8', '#2a2a2a', '#9aa0a6'][i % 5], dir); }
    for (const x of [600, 1200, 1800, 2400]) { const sx = x - camL; if (vis(sx, 20)) { R(c, sx, 120, 3, 84, '#3c4044'); R(c, sx - 3, 112, 9, 22, '#2a2e30'); const ph = Math.floor((t + x) / 4) % 3; ['#d8443a', '#e8c24c', '#4ac07a'].forEach((col, k) => R(c, sx - 1, 114 + k * 6, 5, 4, ph === k ? col : '#3a3a3a')); } }
    for (const x of [1380, 1620]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 204, .7, 1, t, x); }
    fog(c, s, t, camL, .2);
  }
  function avenidaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'MONUMENTO AO ÍNDIO', AVENIDA.INDIO * 2, 360, 7, '#f2efe6'); text(c, 'POSTO DO PLANALTO', 760, 248, 7, '#f2efe6'); text(c, 'MOTOTÁXI? SÓ SE FOR NO PREÇO JUSTO', 1720, 172, 6, '#2a2a2a'); text(c, 'BISCOITO DE POLVILHO É PATRIMÔNIO', 4520, 172, 6, '#2a2a2a'); text(c, 'COMPRE UM CASACO. SÉRIO.', 5520, 172, 6, '#2a2a2a'); c.restore(); }
  function avenidaLights(g, s, t, camL) { farLights(g, s, camL, { cityPar: .12 }); const a = night(s); if (a < .03) return; for (let x = 150; x < AVENIDA.W; x += 300) lampGlow(g, x - camL, 100, a, '255,210,150', 80); for (let i = 0; i < 9; i++) { const dir = i % 2 ? 1 : -1, sp = 40 + (i % 3) * 18, wx = ((i * 337 + t * sp * dir) % 3200 + 3200) % 3200 - 100, sx = wx - camL; if (!vis(sx, 40)) continue; g.fillStyle = `rgba(255,240,180,${.6 * a})`; g.fillRect(dir > 0 ? sx + 26 : sx - 30, 190, 30, 4); } const ix = AVENIDA.INDIO - camL; if (vis(ix, 120)) { const gr = g.createLinearGradient(0, 200, 0, 50); gr.addColorStop(0, `rgba(255,220,150,${.4 * a})`); gr.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gr; g.fillRect(ix - 30, 50, 60, 150); } }

  /* ---------- 17 · Feira e biscoitarias ---------- */
  const FEIRA = { W: 2200 };
  function stall(c, x, w, tarp, goods, seed) {
    R(c, x, 120, 2, 90, '#6a5a44'); R(c, x + w - 2, 120, 2, 90, '#6a5a44'); for (let k = 0; k < w; k++) { const yy = 114 + Math.round(Math.sin(k / w * Math.PI) * -6); R(c, x + k, yy, 1, 10, tarp); } R(c, x, 124, w, 2, shadeHex(tarp, .7));
    R(c, x + 2, 168, w - 4, 10, '#8a6a45'); R(c, x + 2, 168, w - 4, 2, '#c4955c'); R(c, x + 4, 178, w - 8, 32, '#6a4a32');
    for (let k = 0; k < (w - 8) / 7; k++) { const gx = x + 6 + k * 7, g = goods[(k + seed) % goods.length]; ell(c, gx + 3, 164, 3.5, 3, g); ell(c, gx + 3, 160, 2.5, 2, g); R(c, gx + 2, 159, 2, 1, '#ffffff55'); }
    R(c, x + 8, 150, 18, 10, '#f2ece0'); R(c, x + 10, 154, 12, 1, '#c43c3a');
  }
  function buildFeira() {
    const [cv, c] = mk(FEIRA.W, LH);
    for (let i = 0, x = 10; x < FEIRA.W; i++) { building(c, x, 70, 140, 60, ['#ece4cf', '#dde4d4', '#f2e4d8'][i % 3], { wy: 16 }); x += 150; }
    // biscoitarias: lojas de biscoito de polvilho com potes no balcão
    for (const bx of [380, 1240, 1900]) { shopFront(c, bx, 120, '#f6ecd0', '#c47a35', '#c47a35', '#f6ecd0'); for (let k = 0; k < 6; k++) { R(c, bx + 12 + k * 17, 186, 12, 16, '#e8e4dc'); R(c, bx + 13 + k * 17, 190, 10, 11, '#f2dfa8'); for (let j = 0; j < 3; j++) R(c, bx + 14 + k * 17 + j * 3, 192 + j * 3, 3, 2, '#fff3cf'); R(c, bx + 12 + k * 17, 185, 12, 2, '#c43c3a'); } }
    const tarps = ['#3c6aa8', '#e8833a', '#e8c24c', '#3c8a5a', '#c43c3a'], goods = [['#e8c24c', '#7cbf6a', '#d9634a'], ['#f2a83a', '#e8d84c'], ['#7a3a2a', '#c49a6a', '#f2ece0'], ['#d9634a', '#3c8a3a']];
    for (let i = 0, x = 20; x < FEIRA.W - 60; i++, x += 92) { if ([380, 1240, 1900].some((b) => x > b - 70 && x < b + 120)) continue; stall(c, x, 80, tarps[i % tarps.length], goods[i % goods.length], i); }
    paving(c, FEIRA.W, '#bdb6a2', '#a8a08a', '#9a927c', '#ddd6c2', 30); return cv;
  }
  let feiraMid = null;
  function feira(c, s, t, camL) {
    if (!feiraMid) feiraMid = buildFeira();
    conquistaBack(c, s, t, camL);
    c.drawImage(feiraMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (let i = 0; i < 16; i++) { const wx = 60 + i * 140 + Math.sin(t * .4 + i * 1.7) * 40, sx = wx - camL; if (vis(sx, 20)) person(c, sx, 214, i); }
    // vapor do biscoito saindo do forno e sacolas balançando
    for (const bx of [380, 1240, 1900]) { const x = bx + 60 - camL; if (!vis(x, 80)) continue; for (let i = 0; i < 6; i++) { const k = (t * .25 + i / 6) % 1; R(c, x - 20 + i * 8 + Math.sin(t + i) * 2, 138 - k * 26, 3, 2, `rgba(255,248,232,${(1 - k) * .45})`); } }
    fog(c, s, t, camL, .2);
  }
  function feiraText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); for (const bx of [380, 1240, 1900]) text(c, 'BISCOITOS DE POLVILHO', (bx + 60) * 2, 298, 7, '#fff4dc'); text(c, 'FEIRA DO PLANALTO', 240, 120, 10, '#3c5a6a'); text(c, 'BISCOITO CURA TUDO (MENOS O FRIO)', 1700, 120, 6, '#3c5a6a'); c.restore(); }
  function feiraLights(g, s, t, camL) { farLights(g, s, camL); const a = night(s); if (a < .03) return; for (let x = 60; x < FEIRA.W; x += 92) { const sx = x - camL; if (vis(sx)) { g.fillStyle = `rgba(255,220,150,${.35 * a})`; g.fillRect(sx - 30, 126, 60, 50); lightAdd(sx, 120, a * .5, 60); } } }

  /* ---------- 18 · Fazendas de café do Planalto ---------- */
  const CAFE = { W: 2600 };
  function buildCafe() {
    const [cv, c] = mk(CAFE.W, LH);
    // fileiras de café em curva de nível no morro ao fundo
    for (let row = 0; row < 7; row++) { const y = 120 + row * 11; for (let x = 0; x < CAFE.W; x += 7) { const yy = y + Math.round(Math.sin(x * .01 + row) * 3); ell(c, x, yy, 5, 5, row % 2 ? '#2f5a34' : '#3a6a3c'); ell(c, x - 1, yy - 2, 3, 2, '#4f8a4a'); if (hash(x + row * 99) > .7) R(c, x + 1, yy + 1, 2, 2, '#c43c3a'); } }
    // eucaliptos quebra-vento
    for (let x = 30; x < CAFE.W; x += 26) { R(c, x, 60, 2, 60, '#c8bca8'); ell(c, x + 1, 64, 6, 14, '#5a7a5a'); ell(c, x, 58, 4, 9, '#6a8a6a'); }
    // sede da fazenda com varanda
    const hx = 260; R(c, hx - 6, 118, 192, 8, '#8a4430'); R(c, hx, 126, 180, 84, '#f2ece0'); R(c, hx, 126, 180, 2, '#fffaf0'); for (let k = 0; k < 6; k++) { R(c, hx + 10 + k * 28, 160, 4, 50, '#8a6a45'); win(c, null, hx + 16 + k * 28, 136, 12, 14, false); } R(c, hx, 158, 180, 3, '#c4955c');
    // terreiro de secagem: grãos espalhados em linhas rastelos
    R(c, 700, 196, 520, 14, '#cfcac0'); for (let k = 0; k < 520; k += 2) { const yy = 198 + Math.round(Math.sin(k * .2) * 2); R(c, 700 + k, yy, 2, 6, k % 8 < 4 ? '#7a4a2a' : '#5a3420'); }
    // secador rotativo e máquina de descascar no galpão
    const gx = 1400; R(c, gx, 110, 300, 6, '#7a7f84'); R(c, gx, 116, 4, 94, '#7a7f84'); R(c, gx + 296, 116, 4, 94, '#7a7f84'); for (let k = 0; k < 300; k += 10) R(c, gx + k, 108, 6, 2, '#9aa0a6');
    R(c, gx + 30, 150, 110, 44, '#4a5a64'); for (let k = 0; k < 110; k += 8) R(c, gx + 30 + k, 150, 2, 44, '#3a4852'); R(c, gx + 30, 150, 110, 3, '#8a9aa4'); R(c, gx + 40, 194, 6, 16, '#2a2a2a'); R(c, gx + 124, 194, 6, 16, '#2a2a2a');
    R(c, gx + 180, 140, 70, 60, '#c47a35'); R(c, gx + 184, 144, 62, 20, '#e8a24c'); R(c, gx + 196, 120, 14, 22, '#9aa0a6'); R(c, gx + 230, 200, 30, 10, '#5a3420');
    // caixa d'água
    R(c, 2100, 70, 50, 34, '#3c6aa8'); R(c, 2100, 70, 50, 3, '#8ab4d8'); for (const k of [2104, 2142]) R(c, k, 104, 3, 106, '#7a7f84');
    grass(c, CAFE.W, FLOOR, '#6a8a46', '#577238'); return cv;
  }
  let cafeMid = null;
  function cafe(c, s, t, camL) {
    if (!cafeMid) cafeMid = buildCafe(); if (!FAR) FAR = buildFar();
    sky(c, s, t, camL); tile(c, FAR.a, camL * .03); haze(c, s, t, camL, 100, 160);
    c.drawImage(cafeMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // secador girando
    { const x = 1400 + 85 - camL; if (vis(x, 80)) for (let k = 0; k < 6; k++) { const a = t * 2 + k; R(c, x + Math.cos(a) * 18, 172 + Math.sin(a) * 8, 3, 3, '#c8d0d4'); } }
    // pés de café em primeiro plano e grãos vermelhos
    for (let x = ((-camL % 40) + 40) % 40 - 40; x < LW + 40; x += 40) { const wx = x + camL, sx = x; if (hash(Math.floor(wx / 40)) > .55) { ell(c, sx, 212, 10, 9, '#2f5a34'); ell(c, sx - 2, 208, 7, 6, '#3f7a44'); for (let k = 0; k < 4; k++) R(c, sx - 6 + k * 4, 210 - (k % 2) * 4, 2, 2, '#d8443a'); } }
    for (let i = 0; i < 4; i++) { const wx = 760 + i * 120 + Math.sin(t * .3 + i) * 30, sx = wx - camL; if (vis(sx, 20)) { person(c, sx, 210, i + 2, false); R(c, sx + 5, 196, 1, 14, '#8a6a45'); R(c, sx + 2, 196, 7, 2, '#8a6a45'); } }
    fog(c, s, t, camL, .45);
  }
  function cafeText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'FAZENDA CAFÉ DO PLANALTO', 700, 230, 8, '#5a3c2a'); text(c, 'TERREIRO DE SECAGEM', 1920, 380, 7, '#3a2a1a'); text(c, 'SECADOR · NÃO ENCOSTE (O BARÃO TÁ DE OLHO)', 3100, 206, 6, '#f2efe6'); c.restore(); }
  function cafeLights(g, s, t, camL) { const a = night(s); if (a < .03) return; for (let k = 0; k < 6; k++) { const sx = 260 + 22 + k * 28 - camL; if (vis(sx)) { g.fillStyle = `rgba(255,214,140,${.55 * a})`; g.fillRect(sx - 6, 136, 12, 14); lightAdd(sx, 140, a * .4, 40); } } }

  /* ---------- 19 · Teatro, Centro de Cultura e Planetário (noturna) ---------- */
  const CULTURA = { W: 2200, DOME: 1500 };
  function buildCultura() {
    const [cv, c] = mk(CULTURA.W, LH);
    for (let i = 0, x = 10; x < CULTURA.W; i++) { const w = 60 + Math.round(hash(i + 170) * 40), h = 70 + Math.round(hash(i + 171) * 80); building(c, x, 120 - h, w, h + 4, ['#e9e6dc', '#cfd6dc', '#ddd3bf'][i % 3], { wx: 12, wy: 12 }); x += w + 60; }
    // Centro de Cultura: bloco cinza moderno com letreiro
    building(c, 120, 110, 240, 100, '#8a9094', { windows: false }); R(c, 120, 110, 240, 4, '#b8bec2'); for (let k = 0; k < 240; k += 24) R(c, 120 + k, 114, 2, 96, '#7a8084'); R(c, 140, 120, 120, 26, '#5f6569'); R(c, 230, 170, 60, 40, '#2c3a44'); R(c, 232, 172, 56, 36, '#9fc4d0');
    // Teatro Glauber Rocha: marquise com lâmpadas e cartazes
    const tx = 600; building(c, tx, 90, 300, 120, '#c9b48a', { windows: false }); R(c, tx - 10, 140, 320, 12, '#3a2a2a'); for (let k = 0; k < 320; k += 8) R(c, tx - 8 + k, 144, 3, 3, '#ffe39a'); for (let k = 0; k < 4; k++) { R(c, tx + 20 + k * 70, 158, 44, 52, '#2a2a34'); R(c, tx + 22 + k * 70, 160, 40, 30, ['#c43c3a', '#3c6aa8', '#e8c24c', '#7a3a8a'][k]); }
    R(c, tx + 40, 100, 220, 30, '#2a2a34'); R(c, tx + 42, 102, 216, 26, '#4a2a2a');
    // Planetário: cúpula branca com mural de estrelas
    const dx = CULTURA.DOME; for (let k = 0; k < 60; k++) { const w = Math.round(Math.sqrt(1 - (k / 60) ** 2) * 110); R(c, dx - w, 150 - k, w * 2, 1, k % 6 ? '#eef0f2' : '#d8dce0'); } R(c, dx - 112, 150, 224, 60, '#d8dce0'); for (let k = 0; k < 20; k++) R(c, dx - 100 + k * 10, 170 + (k % 3) * 8, 2, 2, '#3c4a6a'); R(c, dx - 20, 176, 40, 34, '#2c3a44');
    paving(c, CULTURA.W, '#a8aab0', '#94969c', '#86888e', '#cfd0d4', 26); return cv;
  }
  let culturaMid = null;
  function cultura(c, s, t, camL) {
    if (!culturaMid) culturaMid = buildCultura();
    conquistaBack(c, s, t, camL, { cityPar: .1 });
    // estrelas extras (a fase é de noite) e o feixe dos holofotes
    const a = night(s); if (a > .05) for (let i = 0; i < 40; i++) { const x = (hash(i + 400) * 600 - camL * .02) % LW, y = hash(i + 401) * 100; if (Math.sin(t * 2 + i) > -.2) R(c, x, y, 1, 1, `rgba(255,255,240,${a})`); }
    c.drawImage(culturaMid, camL, 0, LW, LH, 0, 0, LW, LH);
    for (const x of [640, 860]) { const sx = x - camL; if (!vis(sx, 120) || a < .05) continue; const ang = Math.sin(t * .6 + x) * .5; c.fillStyle = `rgba(255,250,220,${.08 * a})`; c.beginPath(); c.moveTo(sx, 140); c.lineTo(sx + Math.sin(ang) * 260 - 20, -10); c.lineTo(sx + Math.sin(ang) * 260 + 20, -10); c.closePath(); c.fill(); }
    for (const x of [420, 1100, 1800]) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 214, .85, 1, t, x); }
    for (let i = 0; i < 8; i++) { const wx = 560 + i * 60 + Math.sin(t * .3 + i) * 10, sx = wx - camL; if (vis(sx, 20)) person(c, sx, 214, i); }
  }
  function culturaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'CENTRO DE CULTURA', 400, 266, 8, '#f2efe6'); text(c, 'TEATRO GLAUBER ROCHA', 1500, 230, 9, '#ffe39a'); text(c, 'HOJE: BIA DO ARROCHA · ARROCHA SINFÔNICO', 1500, 258, 6, '#f2efe6'); text(c, 'PLANETÁRIO', CULTURA.DOME * 2, 336, 8, '#2c3a44'); c.restore(); }
  function culturaLights(g, s, t, camL) { farLights(g, s, camL, { cityPar: .1 }); const a = Math.max(.35, night(s)); const tx = 600 - camL; if (vis(tx, 340)) { g.fillStyle = `rgba(255,227,154,${.45 * a})`; g.fillRect(tx - 10, 140, 320, 14); lightAdd(tx + 150, 140, a * .7, 160); const gr = g.createLinearGradient(0, 150, 0, 214); gr.addColorStop(0, `rgba(255,220,150,${.35 * a})`); gr.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gr; g.fillRect(tx - 10, 150, 320, 64); } const dx = CULTURA.DOME - camL; if (vis(dx, 140)) { const gr = g.createRadialGradient(dx, 110, 10, dx, 110, 130); gr.addColorStop(0, `rgba(170,200,255,${.25 * a})`); gr.addColorStop(1, 'rgba(170,200,255,0)'); g.fillStyle = gr; g.fillRect(dx - 130, 0, 260, 214); } for (let x = 100; x < CULTURA.W; x += 260) lampGlow(g, x - camL, 120, a); }

  /* ---------- 20 · Shopping ---------- */
  const SHOP = { W: 2000 };
  function buildShop() {
    const [cv, c] = mk(SHOP.W, LH);
    R(c, 0, 0, SHOP.W, 30, '#cfd4d8'); for (let x = 0; x < SHOP.W; x += 80) { R(c, x + 10, 4, 60, 22, '#8ab4cc'); R(c, x + 12, 6, 56, 6, '#c4e0ec'); }
    R(c, 0, 30, SHOP.W, 180, '#ece8e0');
    // piso de cima: lojas atrás do guarda-corpo de vidro
    const names = 6; for (let x = 20, i = 0; x < SHOP.W - 100; x += 150, i++) { R(c, x, 40, 130, 60, '#d8d4cc'); R(c, x + 4, 44, 122, 12, ['#c43c3a', '#3c6aa8', '#e8833a', '#7a3a8a', '#3c8a5a', '#2a2a2a'][i % names]); R(c, x + 8, 60, 114, 38, '#9fc4d0'); R(c, x + 8, 60, 114, 10, '#c4e0ec'); }
    R(c, 0, 100, SHOP.W, 6, '#9aa0a6'); R(c, 0, 106, SHOP.W, 12, 'rgba(180,220,230,.45)'); R(c, 0, 106, SHOP.W, 1, '#f2f6f8');
    // praça de alimentação, cinema e lan house no térreo
    for (let x = 30, i = 0; x < 700; x += 120, i++) { R(c, x, 130, 100, 44, '#d8d4cc'); R(c, x + 4, 132, 92, 12, ['#e8833a', '#c43c3a', '#e8c24c', '#3c8a5a', '#7a3a8a'][i % 5]); R(c, x + 6, 148, 88, 26, '#f2ece0'); R(c, x + 10, 176, 80, 34, '#b8a48a'); }
    for (let k = 0; k < 7; k++) { const x = 60 + k * 90; R(c, x, 196, 30, 3, '#f2f2ee'); R(c, x + 13, 199, 3, 11, '#9aa0a6'); R(c, x - 8, 192, 6, 18, '#e86a7a'); R(c, x + 32, 192, 6, 18, '#e86a7a'); }
    const cx = 820; R(c, cx, 120, 380, 90, '#2a2430'); R(c, cx + 10, 126, 360, 18, '#1a1420'); for (let k = 0; k < 360; k += 6) R(c, cx + 12 + k, 128, 3, 3, '#ffe39a'); for (let k = 0; k < 4; k++) { R(c, cx + 20 + k * 90, 150, 60, 50, '#3a3440'); R(c, cx + 23 + k * 90, 153, 54, 44, ['#3c6aa8', '#c43c3a', '#3c8a5a', '#e8833a'][k]); R(c, cx + 30 + k * 90, 160, 40, 18, '#f2ece0'); }
    const lx = 1320; R(c, lx, 120, 560, 90, '#1a1c28'); R(c, lx, 120, 560, 4, '#5ae0d0'); for (let k = 0; k < 7; k++) { const x = lx + 20 + k * 76; R(c, x, 166, 50, 6, '#3a3c48'); R(c, x + 10, 140, 30, 24, '#2a2c38'); R(c, x + 12, 142, 26, 18, ['#3c8ae0', '#5ae070', '#e05a8a'][k % 3]); R(c, x + 20, 172, 6, 38, '#3a3c48'); R(c, x + 4, 186, 14, 24, '#c43c3a'); }
    // escada rolante
    for (let k = 0; k < 40; k++) R(c, 740 + k * 2, 206 - k * 2.2, 4, 2, '#9aa0a6'); limb(c, [[740, 196], [820, 108]], 2, '#5a6066');
    R(c, 0, 210, SHOP.W, 10, '#cdc6b8'); R(c, 0, 210, SHOP.W, 2, '#f2eee4'); R(c, 0, 218, SHOP.W, 2, '#a8a294');
    tiles(c, SHOP.W, FLOOR, '#e6e2d8', '#d2cec2', 24); return cv;
  }
  let shopMid = null;
  function shopping(c, s, t, camL) {
    if (!shopMid) shopMid = buildShop();
    sky(c, s, t, camL); c.drawImage(shopMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // telas da lan house e do cinema piscando, galera passando
    for (let k = 0; k < 7; k++) { const x = 1320 + 32 + k * 76 - camL; if (vis(x, 30)) { R(c, x, 142, 26, 18, ['#3c8ae0', '#5ae070', '#e05a8a'][(k + Math.floor(t * 2)) % 3]); R(c, x + 2, 144 + (Math.floor(t * 6 + k) % 12), 6, 2, '#f2f2ee'); } }
    for (let i = 0; i < 14; i++) { const wx = 40 + i * 140 + Math.sin(t * .35 + i * 2) * 50, sx = wx - camL; if (vis(sx, 20)) person(c, sx, 214, i, false); }
  }
  function shoppingText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); ['BURGÃO', 'PASTEL', 'AÇAÍ 10', 'CAFÉ', 'SUSHI', 'CALDO'].forEach((n, i) => text(c, n, (30 + i * 120 + 50) * 2, 276, 6, '#f2efe6')); ['MODA', 'GAMES', 'TÊNIS', 'PERFUMES', 'LIVROS', 'CELULAR', 'ÓCULOS', 'BRINQUEDOS', 'RELÓGIOS', 'SAPATOS', 'ESPORTE', 'MÚSICA', 'PRESENTES'].forEach((n, i) => text(c, n, (20 + i * 150 + 65) * 2, 100, 6, '#f2efe6')); text(c, 'CINEMA', 2040, 270, 9, '#ffe39a'); text(c, 'LAN HOUSE PLANALTO · 24H', 3200, 236, 8, '#5ae0d0'); text(c, 'SHOPPING CONQUISTA · PONTO DA GALERA', 1000, 210, 7, '#2c3a44'); c.restore(); }
  function shoppingLights(g, s, t, camL) { for (let x = 0; x < SHOP.W; x += 80) { const sx = x + 40 - camL; if (vis(sx)) lightAdd(sx, 26, .35, 70); } const lx = 1320 - camL; if (vis(lx, 600)) { g.fillStyle = 'rgba(90,224,208,.12)'; g.fillRect(lx, 120, 560, 94); } }

  /* ---------- 21 · Avenida Olívia Flores e Escola SESI ---------- */
  const OLIVIA = { W: 2600, SESI: 1250 };
  function buildOlivia() {
    const [cv, c] = mk(OLIVIA.W, LH);
    // prédios altos e brancos ao longo da avenida
    for (let i = 0, x = 10; x < OLIVIA.SESI - 40; i++) { const w = 40 + Math.round(hash(i + 270) * 24), h = 90 + Math.round(hash(i + 271) * 70); building(c, x, 150 - h, w, h, ['#f2efe6', '#e9e6dc', '#dfe4e6'][i % 3], { wx: 9, wy: 9, ww: 5, wh: 5 }); x += w + 14; }
    // canteiro central com a ciclovia (faixa amarela) e coqueiros
    R(c, 0, 172, OLIVIA.SESI, 6, '#5f8a46'); R(c, 0, 178, OLIVIA.SESI, 8, '#6f7376'); for (let x = 0; x < OLIVIA.SESI; x += 12) R(c, x, 181, 6, 1, '#e8c24c'); R(c, 0, 186, OLIVIA.SESI, 6, '#5f8a46');
    // Escola SESI: muro com grade, pátio, quadra coberta com teto em arco, auditório e laboratório
    const sx = OLIVIA.SESI; R(c, sx, 150, OLIVIA.W - sx, 60, '#f2f2ee'); R(c, sx, 150, OLIVIA.W - sx, 3, '#2c5a9e');
    R(c, sx + 20, 96, 200, 54, '#f2f2ee'); R(c, sx + 20, 96, 200, 6, '#2c5a9e'); for (let k = 0; k < 6; k++) win(c, null, sx + 30 + k * 32, 110, 20, 14, false); R(c, sx + 30, 128, 40, 20, '#c43c3a');
    const q = sx + 300; for (let k = 0; k <= 280; k++) { const h = Math.round(Math.sin(k / 280 * Math.PI) * 30); R(c, q + k, 90 - h, 1, 3, '#9aa4ac'); } for (let k = 0; k <= 280; k += 40) R(c, q + k, 90, 3, 120, '#7a848c'); R(c, q, 160, 280, 50, '#3c7a5a'); R(c, q + 10, 162, 260, 2, '#f2f2ee'); R(c, q + 139, 162, 2, 48, '#f2f2ee'); R(c, q + 4, 140, 3, 26, '#c43c3a'); R(c, q + 2, 140, 12, 8, '#f2f2ee'); R(c, q + 270, 140, 3, 26, '#c43c3a'); R(c, q + 264, 140, 12, 8, '#f2f2ee');
    const ad = sx + 650; R(c, ad, 110, 180, 100, '#e8e4dc'); R(c, ad, 110, 180, 6, '#2c5a9e'); R(c, ad + 70, 150, 40, 60, '#5a3c2a'); for (let k = 0; k < 3; k++) win(c, null, ad + 10 + k * 60, 122, 30, 16, false);
    const lab = sx + 880; R(c, lab, 110, 220, 100, '#f2f2ee'); R(c, lab, 110, 220, 6, '#2c5a9e'); for (let k = 0; k < 5; k++) { R(c, lab + 10 + k * 42, 124, 34, 26, '#2c3a44'); R(c, lab + 12 + k * 42, 126, 30, 22, '#9fc4d0'); R(c, lab + 18 + k * 42, 134, 10, 8, '#3c8ae0'); R(c, lab + 30 + k * 42, 134, 10, 8, '#3c8ae0'); }
    for (let x = sx; x < OLIVIA.W; x += 6) R(c, x, 196, 1, 14, '#8a949a'); R(c, sx, 196, OLIVIA.W - sx, 1, '#8a949a');
    sidewalk(c, OLIVIA.W, '#cfc9b8'); tiles(c, OLIVIA.W, FLOOR, '#d6d0be', '#bfb8a6', 18); return cv;
  }
  let oliviaMid = null;
  function olivia(c, s, t, camL) {
    if (!oliviaMid) oliviaMid = buildOlivia();
    conquistaBack(c, s, t, camL, { cityPar: .1 });
    c.drawImage(oliviaMid, camL, 0, LW, LH, 0, 0, LW, LH);
    // trânsito dos dois lados do canteiro e ciclistas na ciclovia
    for (let i = 0; i < 6; i++) { const dir = i % 2 ? 1 : -1, wx = ((i * 431 + t * (50 + i * 6) * dir) % 2900 + 2900) % 2900 - 200, sx = wx - camL; if (vis(sx, 40) && wx < OLIVIA.SESI) car(c, sx, dir > 0 ? 172 : 196, ['#f2f2ee', '#3c6aa8', '#c43c3a', '#2a2a2a'][i % 4], dir); }
    for (let i = 0; i < 2; i++) { const wx = ((i * 700 + t * 22) % 1300), sx = wx - camL; if (vis(sx, 20) && wx < OLIVIA.SESI) { R(c, sx, 180, 3, 3, '#1c1c1c'); R(c, sx + 9, 180, 3, 3, '#1c1c1c'); R(c, sx + 3, 176, 6, 2, '#c43c3a'); R(c, sx + 5, 170, 3, 6, '#3c6aa8'); R(c, sx + 5, 167, 3, 3, '#e0b08a'); } }
    for (let x = 40; x < OLIVIA.SESI; x += 110) { const sx = x - camL; if (vis(sx, 60)) tree(c, sx, 178, .75, 1, t, x); }
    for (let x = 100; x < OLIVIA.SESI; x += 220) { const sx = x - camL; if (vis(sx, 40)) lampPost(c, sx, 120); }
    for (let i = 0; i < 10; i++) { const wx = OLIVIA.SESI + 60 + i * 120 + Math.sin(t * .4 + i) * 30, sx = wx - camL; if (vis(sx, 20)) { person(c, sx, 210, i, false); R(c, sx, 199, 5, 2, '#2c5a9e'); } }
    fog(c, s, t, camL, .2);
  }
  function oliviaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); text(c, 'AVENIDA OLÍVIA FLORES', 600, 330, 9, '#f2efe6'); text(c, 'CICLOVIA', 1500, 364, 6, '#2a2a2a'); text(c, 'ESCOLA SESI', (OLIVIA.SESI + 120) * 2, 186, 10, '#2c5a9e'); text(c, 'QUADRA COBERTA', (OLIVIA.SESI + 440) * 2, 160, 7, '#2c3a44'); text(c, 'AUDITÓRIO', (OLIVIA.SESI + 740) * 2, 206, 7, '#2c5a9e'); text(c, 'LABORATÓRIO DE INFORMÁTICA', (OLIVIA.SESI + 990) * 2, 206, 6, '#2c5a9e'); c.restore(); }
  function oliviaLights(g, s, t, camL) { farLights(g, s, camL, { cityPar: .1 }); const a = night(s); if (a < .03) return; for (let x = 100; x < OLIVIA.SESI; x += 220) lampGlow(g, x - camL + 1, 116, a); }

  /* ---------- registro: cenas 12..21 ---------- */
  const indoor = (k) => (s) => mix(s.amb, [1, 1, 1], k);
  const LIST = [
    { id: 12, key: 'aeroporto', nome: 'Aeroportos', lugar: 'Aeroporto de Itabuna → Aeroporto Glauber Rocha', width: AIR.W * 2, draw: aeroporto, text: aeroportoText, lights: aeroportoLights, amb: indoor(.55), always: true },
    { id: 13, key: 'bairro', nome: 'Bairro da pensão', lugar: 'Pensão de Dona Lurdes', width: BAIRRO.W * 2, draw: bairro, text: bairroText, lights: bairroLights, always: true },
    { id: 14, key: 'centro', nome: 'Centro e Praça da Catedral', lugar: 'Catedral Nossa Senhora das Vitórias · Praça Tancredo Neves', width: CENTRO.W * 2, draw: centro, text: centroText, lights: centroLights, always: true },
    { id: 15, key: 'serra', nome: 'Serra do Periperi', lugar: 'Cristo de Mário Cravo', width: SERRA.W * 2, draw: serra, text: serraText, lights: serraLights, always: true },
    { id: 16, key: 'avenidas', nome: 'Monumento ao Índio', lugar: 'Avenidas e rotatória do Monumento ao Índio', width: AVENIDA.W * 2, draw: avenida, text: avenidaText, lights: avenidaLights, always: true },
    { id: 17, key: 'feira', nome: 'Feira e biscoitarias', lugar: 'Feira e biscoitos de polvilho', width: FEIRA.W * 2, draw: feira, text: feiraText, lights: feiraLights, always: true },
    { id: 18, key: 'cafe', nome: 'Fazendas de café', lugar: 'Planalto da Conquista', width: CAFE.W * 2, draw: cafe, text: cafeText, lights: cafeLights, always: true },
    { id: 19, key: 'cultura', nome: 'Teatro e Planetário', lugar: 'Teatro Glauber Rocha · Centro de Cultura · Planetário', width: CULTURA.W * 2, draw: cultura, text: culturaText, lights: culturaLights, noite: true, always: true },
    { id: 20, key: 'shopping', nome: 'Shopping', lugar: 'Praça de alimentação, cinema e lan house', width: SHOP.W * 2, draw: shopping, text: shoppingText, lights: shoppingLights, amb: indoor(.8), always: true },
    { id: 21, key: 'olivia', nome: 'Olívia Flores e Escola SESI', lugar: 'Avenida Olívia Flores · Escola SESI', width: OLIVIA.W * 2, draw: olivia, text: oliviaText, lights: oliviaLights, always: true }
  ];
  /* plataformas [x, y, largura] e vãos [x, largura] em pixels do mundo (o mesmo formato de world.js) */
  const LAYOUT = {
    12: { platforms: [[1260, 384, 150], [2100, 384, 150], [2290, 328, 140], [2480, 384, 150], [3500, 384, 150]], gaps: [] },
    13: { platforms: [[900, 384, 150], [1100, 328, 140], [2700, 384, 150], [2900, 328, 140], [3100, 384, 150]], gaps: [] },
    14: { platforms: [[1300, 384, 150], [1490, 328, 140], [1680, 272, 140], [2900, 384, 150], [3090, 328, 140], [4100, 384, 150]], gaps: [] },
    15: { platforms: [[600, 384, 150], [790, 320, 140], [980, 256, 140], [1170, 320, 140], [1700, 384, 150], [1890, 320, 140], [2080, 256, 130], [2270, 192, 130], [2460, 256, 140], [3100, 384, 150], [3290, 320, 140], [3480, 256, 140], [3670, 320, 140], [3860, 384, 150]], gaps: [[1420, 220], [2700, 300], [4060, 200]] },
    16: { platforms: [[1000, 384, 150], [1900, 384, 150], [2090, 328, 140], [3500, 384, 150], [3690, 328, 140], [4700, 384, 150]], gaps: [[1300, 180], [4300, 200]] },
    17: { platforms: [[700, 384, 150], [890, 328, 140], [1700, 384, 150], [2700, 384, 150], [2890, 328, 140], [3080, 272, 140]], gaps: [] },
    18: { platforms: [[900, 384, 150], [1090, 328, 140], [2200, 384, 150], [2390, 320, 140], [2580, 256, 140], [3600, 384, 150], [3790, 328, 140]], gaps: [[1500, 200], [3200, 220]] },
    19: { platforms: [[800, 384, 150], [990, 328, 140], [1180, 272, 140], [2400, 384, 150], [2590, 320, 140], [3500, 384, 150]], gaps: [] },
    20: { platforms: [[600, 384, 150], [790, 328, 140], [980, 272, 140], [2300, 384, 150], [2490, 328, 140], [3300, 384, 150]], gaps: [] },
    21: { platforms: [[1100, 384, 150], [2700, 384, 150], [2890, 328, 140], [3080, 272, 140], [3900, 384, 150], [4090, 328, 140]], gaps: [] }
  };
  // vãos desenhados no chão: buraco da obra, ravina da serra e canal de irrigação
  function holes(c, id, camL) {
    const L = LAYOUT[id]; if (!L || !L.gaps.length) return;
    for (const [gx, gw] of L.gaps) { const x = gx / 2 - camL, w = gw / 2; if (!vis(x, w + 20)) continue;
      const deep = id === 15 ? '#2a2620' : id === 18 ? '#3c6a8a' : '#1c1c1c'; R(c, x, FLOOR, w, LH - FLOOR, deep); R(c, x, FLOOR, w, 3, id === 18 ? '#8ac4d8' : '#3c3a34'); R(c, x - 2, FLOOR, 2, LH - FLOOR, '#4a3a2a'); R(c, x + w, FLOOR, 2, LH - FLOOR, '#4a3a2a');
      if (id === 16) for (const cx of [x - 8, x + w + 2]) { R(c, cx, FLOOR - 9, 6, 9, '#f08a24'); R(c, cx + 1, FLOOR - 6, 4, 2, '#f2f2ee'); } }
  }
  for (const d of LIST) { const draw = d.draw; window.HdMaps.register(d.id, { ...d, draw: (c, s, t, camL) => { draw(c, s, t, camL); holes(c, d.id, camL); } }); }

  // Art.drawScene para as cenas novas (também na qualidade baixa, que não usa o HdMaps nas fases antigas)
  const baseScene = window.Art?.drawScene;
  if (baseScene) window.Art.drawScene = function (c, scene, camera = 0, t = 0) {
    if (!(scene >= 12 && scene <= 21)) return baseScene(c, scene, camera, t);
    c.save(); c.imageSmoothingEnabled = false; c.beginPath(); c.rect(0, 0, 960, 540); c.clip();
    if (window.HdMaps.draw(c, scene, Number(camera) || 0, Number(t) || 0)) window.HdMaps.finish(c, scene);
    c.restore();
  };

  window.CampanhaCenarios = Object.freeze({
    lista: Object.freeze(LIST.map((d) => Object.freeze({ id: d.id, key: d.key, nome: d.nome, lugar: d.lugar, largura: d.width, noite: !!d.noite, interno: !!d.amb, plataformas: LAYOUT[d.id].platforms, vaos: LAYOUT[d.id].gaps }))),
    largura: (id) => LIST.find((d) => d.id === id)?.width || 0,
    layout: (id) => LAYOUT[id] || null,
    desenharPlataforma: plank
  });
})();
