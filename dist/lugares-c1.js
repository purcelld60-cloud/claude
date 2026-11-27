/* Lugares novos da Campanha 1 que já apareciam no mapa de Itabuna e agora dá para visitar com o carro a gás:
   40 · Oficina do Lucas (garagem): Tio Juca perdeu três ferramentas nas prateleiras → missão "Ferramentas sumidas".
   41 · Lanchonete do Zito: coxinha, pastel e suco de cacau; o lanche da casa enche vida e gás.
   42 · Açude da Roça: lago com píer, capivaras, fogueira e o Seu Vagner → minijogo "Pescaria do Vagner".
   As cenas usam números próprios (40+) para não encostar nas cenas da Campanha 2 (12 a 34).
   O estado fica no save da campanha 1 (q.ferramentas, q.ferramentasFeita, q.zitoVisita, q.pescaria). */
(() => {
  'use strict';
  if (window.LugaresC1) return;
  const K = window.HdMaps?.kit; const FLOOR = 440, TAU = Math.PI * 2;
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const ell = (c, x, y, rx, ry, cor) => { c.fillStyle = cor; c.beginPath(); c.ellipse(Math.round(x), Math.round(y), rx, ry, 0, 0, TAU); c.fill(); };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };

  const LUGARES = {
    40: { nome: 'Oficina do Lucas', sub: 'Garagem e ferramentas', largura: 2400, porta: null, interno: true,
      plataformas: [[480, 330, 150], [880, 300, 140], [1460, 320, 150], [1900, 290, 140]] },
    41: { nome: 'Lanchonete do Zito', sub: 'Coxinha, pastel e suco de cacau', largura: 2000, porta: 300, interno: true,
      plataformas: [[1320, 330, 170]] },
    42: { nome: 'Açude da Roça', sub: 'Píer, capivaras e pescaria', largura: 2400, porta: null, interno: false,
      plataformas: [[1180, 380, 420], [1720, 320, 140]] }
  };
  const NPCS = {
    tio_juca: { name: 'Tio Juca · mecânico', scene: 40, x: 760 },
    zito: { name: 'Seu Zito · lanchonete', scene: 41, x: 1040 },
    vagner: { name: 'Seu Vagner · pescador', scene: 42, x: 1500, y: 380 }
  };
  const FERRAMENTAS = Object.freeze([
    Object.freeze({ id: 'chave', x: 560, y: 300, nome: 'Chave inglesa' }),
    Object.freeze({ id: 'macaco', x: 950, y: 270, nome: 'Macaco hidráulico' }),
    Object.freeze({ id: 'alicate', x: 1960, y: 260, nome: 'Alicate do Tio Juca' })
  ]);
  const GENTE = {
    tio_juca: { name: 'Tio Juca', skin: '#8a5a3c', shade: '#5f3d2a', build: 'belly', top: '#2f5d8c', topKind: 'overall', inner: '#c9c3b0', pants: '#2f5d8c', hat: { kind: 'cap', color: '#c0443c' }, hair: { style: 'short', color: '#8a847a' }, mustache: '#6f665c', grease: true, item: 'wrench', pose: 'carry' },
    zito: { name: 'Seu Zito', skin: '#c48a62', shade: '#93613f', build: 'belly', top: '#f2f2ec', topKind: 'apron', apron: '#e8433a', pants: '#3a3f46', hat: { kind: 'cap', color: '#f2f2ec', band: '#e8433a' }, hair: { style: 'short', color: '#2a1d16' }, mustache: '#2a1d16', pose: 'talk' },
    // Seu Vagner: baixinho e gordinho, bigode, cavanhaque e cabelo curto, colete de pescador
    vagner: { name: 'Seu Vagner', skin: '#c48a62', shade: '#93613f', build: 'belly', h: .84, top: '#5a7a4a', topKind: 'vest', vest: '#c9a24a', vestBand: '#8a6a2a', pants: '#4a4a42', hair: { style: 'short', color: '#2a1d16' }, mustache: '#2a1d16', goatee: '#2a1d16', pose: 'relaxed' }
  };
  const registrar = () => { const CP = window.CampanhaPersonagens; if (!CP?.registrar) return false; for (const [id, sp] of Object.entries(GENTE)) CP.registrar(id, sp, 'NPC (Itabuna)'); return true; };
  if (!registrar()) addEventListener('DOMContentLoaded', registrar, { once: true });

  /* ======================= ARTE (pixels de arte 482x270, chão em y=220; mundo = 2x) =======================
     Estilo das cenas: paleta fechada, luzes quentes com halo, partículas no ar (poeira, vapor, faísca, vagalume),
     fumaça de chaminé e reflexo na água. As luzes acendem mais à noite (s.night). */
  const glow = (c, x, y, r, cor, a = .3) => { if (a <= .01) return; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = Math.min(1, a); const g = c.createRadialGradient(x, y, 0, x, y, r); g.addColorStop(0, cor); g.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore(); };
  const cone = (c, x, y, w0, w1, h, cor, a) => { c.save(); c.globalCompositeOperation = 'lighter'; const g = c.createLinearGradient(0, y, 0, y + h); g.addColorStop(0, cor); g.addColorStop(1, 'rgba(0,0,0,0)'); c.globalAlpha = a; c.fillStyle = g; c.beginPath(); c.moveTo(x - w0, y); c.lineTo(x + w0, y); c.lineTo(x + w1, y + h); c.lineTo(x - w1, y + h); c.closePath(); c.fill(); c.restore(); };
  const noiteDe = (s) => Math.max(0, Math.min(1, Number(s?.night) || 0));
  const dith = (c, x, y, w, h, cor, k = 2) => { for (let yy = 0; yy < h; yy++) for (let xx = (yy % 2); xx < w; xx += k) R(c, x + xx, y + yy, 1, 1, cor); };
  function fumacaSobe(c, x, y, t, n = 8, alt = 40, cor = '#9aa0b8') { for (let k = 0; k < n; k++) { const u = (t * .18 + k / n) % 1; c.globalAlpha = (1 - u) * .5; const r = 2 + u * 6; ell(c, x + Math.sin(t * .8 + k + u * 4) * (2 + u * 8) + u * 10, y - u * alt, r, r * .8, cor); } c.globalAlpha = 1; }
  function vagalumes(c, x0, x1, y0, y1, t, n, a, cor = '#8af0ff') { for (let k = 0; k < n; k++) { const fx = x0 + hash(k + 3) * (x1 - x0) + Math.sin(t * .7 + k) * 8, fy = y0 + hash(k + 7) * (y1 - y0) + Math.cos(t * .9 + k * 1.3) * 5, b = .5 + .5 * Math.sin(t * 3 + k * 2.1); if (b < .2) continue; R(c, fx, fy, 1, 1, '#ffffff'); glow(c, fx, fy, 6, cor, a * b); } }

  /* ---------------- 40 · OFICINA DO LUCAS ---------------- */
  let oficinaMid = null;
  const OF = { W: 1240, PEG: [230, 700], LAMP: [120, 330, 560, 790, 1010], JAN: [300, 560, 820, 1080] };
  function buildOficina() {
    const W = OF.W, [cv, c] = mk(W, 270);
    // parede de bloco com sombreado (mais escura em cima) e pontinhos de textura
    for (let y = 26; y < 220; y++) { const k = (y - 26) / 194; R(c, 0, y, W, 1, `rgb(${Math.round(52 + k * 26)},${Math.round(60 + k * 26)},${Math.round(72 + k * 22)})`); }
    for (let y = 30; y < 220; y += 12) { R(c, 0, y, W, 1, 'rgba(20,26,36,.35)'); for (let x = ((y / 12) % 2) * 14; x < W; x += 28) R(c, x, y, 1, 12, 'rgba(20,26,36,.28)'); }
    for (let i = 0; i < 2600; i++) R(c, hash(i) * W, 28 + hash(i + 1) * 190, 1, 1, i % 3 ? 'rgba(255,255,255,.05)' : 'rgba(0,0,0,.12)');
    window.LugaresFundos?.oficinaParede?.(c, W);
    R(c, 0, 186, W, 34, '#3e4652'); R(c, 0, 186, W, 2, '#d8a83a'); for (let x = 0; x < W; x += 16) R(c, x, 188, 8, 2, '#1c1c1c'); // rodapé com faixa de segurança
    // teto de zinco e vigas de aço com rebites
    R(c, 0, 0, W, 26, '#1e2128'); for (let x = 0; x < W; x += 5) R(c, x, 0, 2, 24, '#2a2e36'); R(c, 0, 24, W, 3, '#121418');
    for (let x = 40; x < W; x += 200) { R(c, x, 0, 8, 220, '#2c3440'); R(c, x + 1, 0, 2, 220, '#46505e'); for (let y = 10; y < 220; y += 22) R(c, x + 3, y, 2, 2, '#6a7482'); }
    R(c, 0, 28, W, 6, '#2c3440'); R(c, 0, 28, W, 1, '#46505e');
    // janelas altas (o céu entra no quadro dinâmico)
    for (const x of OF.JAN) { R(c, x - 2, 40, 64, 30, '#1c222a'); c.clearRect(x, 42, 60, 26); for (const m of [14, 30, 45]) R(c, x + m, 42, 2, 26, '#1c222a'); R(c, x, 54, 60, 2, '#1c222a'); R(c, x - 2, 68, 64, 2, '#3a4250'); }
    // painéis de ferramentas com silhueta pintada de cada ferramenta
    for (const px of OF.PEG) { R(c, px - 2, 94, 124, 66, '#6a4a2a'); R(c, px, 96, 120, 62, '#c8a46a'); for (let y = 99; y < 156; y += 5) for (let x = px + 3; x < px + 118; x += 5) R(c, x, y, 1, 1, '#8a6a3a');
      for (let k = 0; k < 8; k++) { const x = px + 8 + k * 14, h = 18 + (k % 3) * 7, cor = ['#9aa0a6', '#c43c3a', '#3c6aa8', '#e8c24a', '#7a8086'][k % 5]; R(c, x - 2, 100 + (k % 2) * 4, 7, h + 2, 'rgba(60,40,20,.35)'); R(c, x, 100 + (k % 2) * 4, 3, h, cor); R(c, x - 2, 100 + (k % 2) * 4, 7, 3, '#7a8086'); R(c, x, 100 + (k % 2) * 4, 1, h, 'rgba(255,255,255,.3)'); }
      for (let k = 0; k < 3; k++) { R(c, px + 10 + k * 34, 140, 22, 12, '#3a3e44'); R(c, px + 11 + k * 34, 141, 20, 3, '#5a6068'); } }
    // porta de enrolar aberta (entrada), trilho e corrente
    c.clearRect(0, 84, 74, 136); R(c, 0, 74, 78, 10, '#5a6470'); for (let k = 0; k < 2; k++) { R(c, 0, 84 + k * 4, 74, 3, '#7a8490'); R(c, 0, 86 + k * 4, 74, 1, '#4a5460'); } R(c, 30, 92, 14, 2, '#3a4450'); for (let k = 0; k < 3; k++) R(c, 0, 75 + k * 3, 78, 1, '#3a4450'); R(c, 76, 84, 3, 136, '#5a6470'); R(c, 70, 90, 1, 60, '#9aa0a6');
    // pilha de pneus, tambores, compressor e galões
    for (let k = 0; k < 5; k++) { ell(c, 104, 214 - k * 8, 17, 6, '#121212'); ell(c, 104, 213 - k * 8, 15, 5, '#262626'); ell(c, 104, 213 - k * 8, 7, 2, '#0a0a0a'); R(c, 92, 211 - k * 8, 3, 1, '#3a3a3a'); }
    for (const [x, cor] of [[596, '#2f6a3a'], [620, '#a83a2a'], [644, '#2f5a8a']]) { R(c, x, 176, 20, 44, cor); R(c, x, 176, 20, 3, 'rgba(255,255,255,.25)'); R(c, x, 186, 20, 2, 'rgba(0,0,0,.3)'); R(c, x, 206, 20, 2, 'rgba(0,0,0,.3)'); R(c, x + 2, 178, 3, 40, 'rgba(255,255,255,.12)'); R(c, x + 6, 194, 8, 6, '#e8e2d0'); }
    R(c, 676, 194, 34, 26, '#c43c3a'); R(c, 676, 194, 34, 4, '#e86a5a'); ell(c, 682, 220, 5, 4, '#1c1c1c'); ell(c, 704, 220, 5, 4, '#1c1c1c'); R(c, 684, 184, 14, 10, '#7a8086'); ell(c, 691, 186, 4, 4, '#c8ccd0');
    for (let k = 0; k < 10; k++) R(c, 710 + k * 3, 214 - Math.sin(k * .7) * 6, 3, 2, '#1c1c1c'); // mangueira
    for (const x of [1000, 1016]) { R(c, x, 200, 12, 20, '#c83a2a'); R(c, x + 3, 196, 6, 4, '#8a2a1a'); R(c, x, 206, 12, 2, '#e8c24a'); }
    // elevador com o carro velho de capô aberto e as pernas do aprendiz debaixo
    R(c, 196, 198, 10, 22, '#e8c24a'); R(c, 410, 198, 10, 22, '#e8c24a'); for (const x of [196, 410]) for (let y = 200; y < 220; y += 6) R(c, x, y, 10, 2, '#1c1c1c'); R(c, 190, 194, 236, 5, '#7a8086'); R(c, 190, 194, 236, 1, '#b8bcc0');
    R(c, 220, 156, 172, 32, '#24467a'); R(c, 220, 156, 172, 4, '#5a86c8'); R(c, 250, 134, 104, 24, '#2e5a98'); R(c, 256, 138, 42, 18, '#9ac8e0'); R(c, 304, 138, 44, 18, '#7ab0cc'); R(c, 258, 139, 10, 2, '#e8f6fc'); R(c, 220, 172, 172, 2, '#1a3458');
    R(c, 352, 140, 40, 4, '#2e5a98'); c.save(); c.translate(354, 156); c.rotate(-.6); R(c, 0, -2, 40, 4, '#2e5a98'); c.restore(); R(c, 356, 148, 32, 10, '#3a3e44'); R(c, 360, 150, 8, 6, '#6a7078'); R(c, 372, 150, 10, 4, '#c43c3a');
    for (const x of [250, 362]) { ell(c, x, 190, 13, 11, '#141414'); ell(c, x, 190, 6, 5, '#9aa0a6'); ell(c, x, 190, 2, 2, '#3a3a3a'); }
    R(c, 386, 166, 6, 6, '#ffe8a0'); R(c, 220, 166, 4, 6, '#c83a2a');
    R(c, 270, 212, 52, 5, '#3a3a3a'); ell(c, 274, 218, 2, 2, '#1c1c1c'); ell(c, 318, 218, 2, 2, '#1c1c1c'); R(c, 318, 204, 22, 8, '#2f5d8c'); R(c, 338, 204, 8, 6, '#2a2a2a'); R(c, 318, 210, 22, 3, '#24486a'); // pernas no "carrinho"
    // bancada com morsa, caixa de ferramentas, lata de óleo e trapos
    R(c, 466, 184, 118, 7, '#7a5232'); R(c, 466, 184, 118, 2, '#9a7248'); R(c, 472, 191, 6, 29, '#5a3a22'); R(c, 572, 191, 6, 29, '#5a3a22'); R(c, 470, 206, 110, 3, '#5a3a22');
    R(c, 480, 166, 40, 18, '#c43c3a'); R(c, 480, 166, 40, 4, '#e86a5a'); for (let k = 0; k < 3; k++) R(c, 482, 172 + k * 4, 36, 1, '#8a2a1a'); R(c, 494, 162, 12, 4, '#3a3a3a');
    R(c, 536, 172, 18, 12, '#4a5058'); R(c, 540, 166, 10, 6, '#6a7078'); R(c, 534, 170, 4, 4, '#3a3e44'); R(c, 560, 174, 8, 10, '#d8a83a'); R(c, 562, 170, 3, 4, '#9aa0a6'); R(c, 572, 180, 10, 4, '#c8b8a0');
    // pôster, calendário, rádio e o cantinho do café com sofá velho
    R(c, 860, 86, 74, 50, '#f2e2b8'); R(c, 862, 88, 70, 12, '#c43c3a'); R(c, 868, 106, 58, 22, '#3a6aa8'); ell(c, 897, 117, 10, 6, '#7ac8c8');
    R(c, 950, 96, 34, 40, '#f6f6f0'); R(c, 950, 96, 34, 8, '#c43c3a'); for (let k = 0; k < 20; k++) R(c, 953 + (k % 5) * 6, 108 + Math.floor(k / 5) * 6, 4, 4, k === 12 ? '#c43c3a' : '#d8d8d0');
    R(c, 970, 160, 44, 2, '#5a3a22'); R(c, 974, 150, 26, 10, '#3a3a3a'); R(c, 976, 152, 8, 6, '#9aa0a6'); R(c, 990, 152, 8, 2, '#ffd27a'); R(c, 998, 144, 1, 8, '#9aa0a6');
    R(c, 1040, 182, 80, 22, '#7a3a2a'); R(c, 1040, 176, 80, 8, '#9a4a32'); R(c, 1036, 178, 8, 26, '#6a3222'); R(c, 1116, 178, 8, 26, '#6a3222'); R(c, 1060, 186, 14, 6, '#a85a3a');
    R(c, 1134, 160, 28, 60, '#e8e8e0'); R(c, 1134, 160, 28, 2, '#ffffff'); R(c, 1136, 178, 24, 1, '#9aa0a6'); R(c, 1156, 166, 2, 8, '#7a8086'); R(c, 1140, 148, 10, 12, '#5a3a22'); R(c, 1142, 144, 6, 4, '#3a3a3a');
    window.LugaresFundos?.oficinaProps?.(c, W);
    // chão de cimento queimado: manchas de óleo, ralo e reflexo
    R(c, 0, 220, W, 50, '#5e636a'); R(c, 0, 220, W, 2, '#8a9096'); for (let x = 0; x < W; x += 64) R(c, x, 222, 1, 48, '#52575e');
    for (let i = 0; i < 26; i++) { const x = hash(i) * W, y = 230 + hash(i + 3) * 30, r = 8 + hash(i + 5) * 16; ell(c, x, y, r, 3, 'rgba(12,12,22,.45)'); ell(c, x - 2, y - 1, r * .4, 1, 'rgba(120,90,160,.25)'); }
    R(c, 620, 236, 30, 6, '#3a3e44'); for (let k = 0; k < 6; k++) R(c, 622 + k * 5, 237, 2, 4, '#1c1c1c');
    dith(c, 0, 222, W, 6, 'rgba(255,255,255,.05)', 3);
    window.LugaresFundos?.oficinaChao?.(c, W);
    return cv;
  }
  function oficina(c, s, t, camL) {
    if (!oficinaMid) oficinaMid = buildOficina(); const n = noiteDe(s);
    // céu pelas janelas altas e pela porta (acompanha a hora do dia)
    const ceuCor = n > .5 ? ['#0e1430', '#1c2650'] : ['#8ac8f0', '#c8e8f8'];
    for (const x of OF.JAN) { const sx = x - camL; if (sx < -70 || sx > 490) continue; const g = c.createLinearGradient(0, 40, 0, 70); g.addColorStop(0, ceuCor[0]); g.addColorStop(1, ceuCor[1]); c.fillStyle = g; c.fillRect(sx, 40, 60, 30); }
    if (window.LugaresFundos?.oficinaFora) window.LugaresFundos.oficinaFora(c, t, camL, n); else { const sx = -camL; if (sx > -80) { const g = c.createLinearGradient(0, 80, 0, 220); g.addColorStop(0, ceuCor[0]); g.addColorStop(1, n > .5 ? '#2a3a3a' : '#9ac87a'); c.fillStyle = g; c.fillRect(sx, 80, 74, 140); } }
    c.drawImage(oficinaMid, camL, 0, 482, 270, 0, 0, 482, 270);
    for (const x of OF.JAN) { const sx = x - camL; if (sx < -70 || sx > 490) continue; if (n > .5) for (let k = 0; k < 5; k++) R(c, sx + hash(k + x) * 58, 42 + hash(k + x + 1) * 12, 1, 1, '#ffffff');
      if (n < .5) cone(c, sx + 30, 70, 30, 60, 150, 'rgba(255,240,200,1)', .12 * (1 - n * 2)); }
    // luminárias pendentes: cone de luz, halo e poeira dentro do feixe (uma pisca, como lâmpada velha)
    for (const x of OF.LAMP) { const sx = x - camL; if (sx < -80 || sx > 560) continue; const pisca = x === 790 && Math.sin(t * 13) > .85 ? .2 : 1;
      R(c, sx, 34, 1, 22, '#1c1c1c'); R(c, sx - 10, 56, 21, 5, '#3a4a3a'); R(c, sx - 8, 61, 17, 2, '#fff6d0');
      cone(c, sx, 62, 8, 44, 150, 'rgba(255,240,190,1)', .16 * pisca); glow(c, sx, 62, 22, '#fff2c0', .5 * pisca);
      for (let k = 0; k < 7; k++) { const u = (t * .05 + hash(k + x)) % 1, px = sx - 20 + hash(k * 3 + x) * 40 + Math.sin(t + k) * 3, py = 70 + u * 140; R(c, px + (py - 70) * .15 * (hash(k) - .5), py, 1, 1, 'rgba(255,248,220,.6)'); } }
    // solda: arco azul piscando e faíscas que caem quicando
    const sx = 372 - camL; if (sx > -40 && sx < 520) { const on = Math.floor(t * 9) % 6 !== 0; if (on) { glow(c, sx, 152, 30, '#8ad0ff', .55); R(c, sx - 1, 151, 3, 3, '#ffffff'); }
      for (let k = 0; k < 10; k++) { const u = ((t * 1.4 + hash(k)) % 1), vx = (hash(k + 4) - .5) * 60, x = sx + vx * u, y = 152 + u * u * 70 - u * 20; if (y > 218) continue; R(c, x, y, 1, 1, k % 3 ? '#ffd23a' : '#ffffff'); glow(c, x, y, 3, '#ffb040', .4 * (1 - u)); } }
    // o gato culpado na prateleira lá de cima, rabo balançando e piscando
    const gx = 1000 - camL; if (gx > -30 && gx < 510) { const y = 142; ell(c, gx, y, 9, 5, '#2a2420'); ell(c, gx + 8, y - 5, 5, 4, '#2a2420'); R(c, gx + 5, y - 10, 2, 3, '#2a2420'); R(c, gx + 10, y - 10, 2, 3, '#2a2420'); if (Math.sin(t * .7) < .93) { R(c, gx + 7, y - 6, 1, 1, '#e8d24a'); R(c, gx + 10, y - 6, 1, 1, '#e8d24a'); }
      for (let k = 0; k < 6; k++) R(c, gx - 9 - k * 2, y + 1 + Math.sin(t * 2.5 - k * .5) * k * .8, 2, 2, '#2a2420'); }
    // notinhas de música saindo do rádio
    const rx = 990 - camL; if (rx > -20 && rx < 500) for (let k = 0; k < 3; k++) { const u = (t * .3 + k / 3) % 1; c.globalAlpha = 1 - u; R(c, rx + u * 14 + Math.sin(t * 3 + k) * 2, 146 - u * 26, 2, 2, '#ffd27a'); R(c, rx + 2 + u * 14 + Math.sin(t * 3 + k) * 2, 140 - u * 26, 1, 6, '#ffd27a'); c.globalAlpha = 1; }
    // ventilador de chão girando no canto do café
    const fx = 1166 - camL; if (fx > -30 && fx < 510) { R(c, fx, 184, 2, 36, '#4a5058'); ell(c, fx + 1, 180, 9, 9, 'rgba(120,130,140,.35)'); for (let k = 0; k < 3; k++) { const a = t * 11 + k * 2.09; R(c, fx + 1 + Math.cos(a) * 6 - 1, 180 + Math.sin(a) * 6 - 1, 3, 3, '#9aa0a6'); } }
    // reflexo das lâmpadas no chão encerado
    for (const x of OF.LAMP) { const sx2 = x - camL; if (sx2 < -60 || sx2 > 540) continue; c.globalAlpha = .12; ell(c, sx2, 236, 30, 4, '#fff2c0'); c.globalAlpha = 1; }
    window.LugaresFundos?.oficinaAnim?.(c, t, camL, n);
  }
  function oficinaText(c, cam) { c.save(); c.translate(-Math.round(cam), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '9px Pixel, monospace'; c.fillStyle = '#ffffff'; c.fillText('GASOLINA? NÃO! GÁS!', 1794, 190); c.font = '8px Pixel, monospace'; c.fillStyle = '#f2e2b8'; c.fillText('OFICINA DO LUCAS · DESDE 1998', 1794, 290); c.fillStyle = '#c43c3a'; c.fillText('NOVEMBRO', 1934, 200); c.fillStyle = '#ffe9a8'; c.fillText('CAFÉ DO MECÂNICO', 2160, 340); c.fillStyle = '#e8e2d0'; c.font = '7px Pixel, monospace'; for (const x of [1212, 1260, 1308]) c.fillText('ÓLEO', x, 395); c.restore(); }

  /* ---------------- 41 · LANCHONETE DO ZITO ---------------- */
  let lancheMid = null;
  const LN = { W: 1040, PEND: [230, 330, 870, 950], PORTA: 150 };
  function buildLanche() {
    const W = LN.W, [cv, c] = mk(W, 270);
    // rua: casarios coloridos do outro lado, calçada portuguesa e meio-fio
    const casas = [['#f2c4c4', '#c8544a'], ['#d4ecc8', '#7a9a5a'], ['#f2e2a8', '#c8844a'], ['#c8dcf0', '#5a7aa8']];
    for (let k = 0; k < 4; k++) { const x = k * 38 - 4, h = 70 + (k % 2) * 14, y = 150 - h; R(c, x, y, 36, h + 40, casas[k][0]); R(c, x, y, 36, 4, casas[k][1]); for (let j = 0; j < 2; j++) { R(c, x + 6 + j * 14, y + 14, 9, 14, '#3a4a5a'); R(c, x + 6 + j * 14, y + 14, 9, 3, '#5a6a7a'); R(c, x + 5 + j * 14, y + 28, 11, 2, casas[k][1]); } }
    window.LugaresFundos?.lancheRua?.(c, LN.PORTA);
    R(c, 0, 190, LN.PORTA, 30, '#c8c0a8'); for (let x = 0; x < LN.PORTA; x += 8) for (let y = 190; y < 220; y += 6) R(c, x + ((y / 6) % 2) * 4, y, 4, 3, '#a89f88'); R(c, 0, 186, LN.PORTA, 4, '#8a8478');
    // fachada: toldo listrado sobre a porta e letreiro
    R(c, LN.PORTA - 8, 26, 16, 194, '#8a5a36'); R(c, LN.PORTA - 4, 30, 2, 190, '#5a3820');
    for (let k = 0; k < 12; k++) { c.fillStyle = k % 2 ? '#e8e2d0' : '#c83a2a'; c.beginPath(); c.moveTo(70 + k * 7, 70); c.lineTo(77 + k * 7, 70); c.lineTo(80 + k * 7, 86); c.lineTo(73 + k * 7, 86); c.closePath(); c.fill(); } for (let k = 0; k < 12; k++) ell(c, 76 + k * 7, 86, 3, 2, k % 2 ? '#e8e2d0' : '#c83a2a');
    // salão: parede amarela em cima, azulejo branco embaixo com faixa azul, vigas de madeira
    R(c, LN.PORTA, 26, W - LN.PORTA, 104, '#f0d890'); for (let i = 0; i < 900; i++) R(c, LN.PORTA + hash(i) * (W - LN.PORTA), 26 + hash(i + 2) * 100, 1, 1, i % 2 ? 'rgba(255,255,255,.18)' : 'rgba(140,100,40,.12)');
    R(c, LN.PORTA, 130, W - LN.PORTA, 90, '#f4f4ee'); for (let y = 130; y < 220; y += 9) R(c, LN.PORTA, y, W - LN.PORTA, 1, '#d8d8d0'); for (let x = LN.PORTA; x < W; x += 9) R(c, x, 130, 1, 90, '#e2e2da'); R(c, LN.PORTA, 128, W - LN.PORTA, 6, '#2c5a9e'); R(c, LN.PORTA, 128, W - LN.PORTA, 1, '#5a8ad8');
    R(c, LN.PORTA, 0, W - LN.PORTA, 14, '#3a2416'); for (let x = LN.PORTA; x < W; x += 8) R(c, x, 0, 4, 14, '#4a3020'); R(c, LN.PORTA, 14, W - LN.PORTA, 14, '#6a4228'); for (let x = LN.PORTA; x < W; x += 60) { R(c, x, 14, 10, 18, '#5a3820'); R(c, x + 1, 14, 2, 18, '#8a5a36'); }
    window.LugaresFundos?.lancheParede?.(c, W, LN.PORTA);
    // quadros de Itabuna (cacau, rio, catedral) e prateleira de salgadinhos
    for (const [x, cor] of [[180, '#5a8a4a'], [216, '#3a7aa8'], [252, '#c8844a']]) { R(c, x, 48, 28, 22, '#5a3820'); R(c, x + 2, 50, 24, 18, cor); R(c, x + 2, 62, 24, 6, 'rgba(0,0,0,.25)'); }
    R(c, 180, 84, 100, 3, '#6a4228'); for (let k = 0; k < 9; k++) { R(c, 184 + k * 11, 72, 8, 12, ['#e8433a', '#f2c94c', '#3c8a5a', '#3a6aa8'][k % 4]); R(c, 185 + k * 11, 74, 2, 3, '#ffffff88'); }
    // cardápio (quadro de giz)
    R(c, 300, 40, 204, 76, '#5a3820'); R(c, 303, 43, 198, 70, '#24302a'); for (let i = 0; i < 160; i++) R(c, 304 + hash(i + 40) * 196, 44 + hash(i + 41) * 68, 2, 1, 'rgba(255,255,255,.06)');
    // balcão com vitrine estufa, fritadeira, espremedor, máquina de café e caixa
    R(c, 426, 158, 308, 62, '#a83a2a'); R(c, 426, 158, 308, 5, '#e8e8e0'); R(c, 426, 163, 308, 2, '#7a2a1a'); for (let x = 436; x < 734; x += 30) R(c, x, 168, 24, 46, '#c84a3a');
    R(c, 440, 134, 180, 24, '#24303a'); R(c, 442, 136, 176, 20, '#bfe0e8'); R(c, 442, 136, 176, 3, '#ffffff'); R(c, 442, 150, 176, 2, '#9ab8c0');
    for (let k = 0; k < 16; k++) { const x = 448 + k * 10.5, cor = ['#d88a3a', '#e8b860', '#c8682a', '#b8502a'][k % 4]; ell(c, x + 4, 148, 5, 3, cor); R(c, x + 2, 145, 3, 1, '#fff2c0'); }
    R(c, 630, 128, 34, 30, '#9aa0a6'); R(c, 632, 132, 30, 14, '#d8a83a'); for (let k = 0; k < 6; k++) R(c, 634 + k * 5, 133, 2, 2, '#ffe08a'); R(c, 630, 128, 34, 3, '#c8ccd0');
    R(c, 672, 132, 18, 26, '#3a3e44'); R(c, 674, 126, 14, 8, '#5a3a22'); ell(c, 681, 128, 6, 2, '#8a5a2a'); R(c, 700, 136, 24, 22, '#c8ccd0'); R(c, 704, 140, 16, 10, '#2a2a2a'); R(c, 706, 150, 4, 6, '#f2f2ee');
    // geladeira de refrigerante
    R(c, 744, 100, 48, 120, '#d8dce0'); R(c, 746, 104, 44, 70, '#0e2a3a'); for (let r2 = 0; r2 < 4; r2++) { R(c, 748, 120 + r2 * 16, 40, 1, '#5a7a8a'); for (let k = 0; k < 6; k++) R(c, 750 + k * 6, 108 + r2 * 16, 4, 11, ['#c43c3a', '#f2c94c', '#3c8a5a', '#e8e8e0'][(k + r2) % 4]); } R(c, 786, 130, 2, 20, '#9aa0a6'); R(c, 744, 100, 48, 6, '#c43c3a');
    // TV no suporte e mesas com toalha xadrez
    R(c, 818, 52, 86, 52, '#121212'); R(c, 822, 56, 78, 44, '#2a6a2a'); R(c, 860, 104, 4, 12, '#2a2a2a'); R(c, 852, 114, 20, 3, '#2a2a2a');
    for (const x of [176, 290, 846, 930]) { R(c, x, 184, 56, 6, '#d8d0c0'); for (let k = 0; k < 7; k++) R(c, x + k * 8, 184, 4, 6, k % 2 ? '#c43c3a' : '#e8e2d0'); R(c, x + 4, 190, 48, 2, '#b8b0a0'); R(c, x + 26, 192, 4, 28, '#7a7e84');
      for (const sd of [-1, 1]) { const cx = x + 28 + sd * 38; R(c, cx - 7, 194, 14, 4, '#c43c3a'); R(c, cx - 7, 180, 3, 18, '#a82a2a'); R(c, cx - 6, 198, 2, 22, '#7a1a1a'); R(c, cx + 4, 198, 2, 22, '#7a1a1a'); } }
    // vasos com plantas e o chão de ladrilho hidráulico
    for (const x of [400, 806]) { R(c, x, 198, 16, 22, '#b8643a'); R(c, x, 198, 16, 3, '#d8844a'); for (let k = 0; k < 7; k++) ell(c, x + 8 + Math.cos(k) * 8, 190 - Math.abs(Math.sin(k * 1.7)) * 14, 5, 3, k % 2 ? '#3a8a4a' : '#4aa85a'); }
    window.LugaresFundos?.lancheProps?.(c, W, LN.PORTA);
    R(c, LN.PORTA, 220, W - LN.PORTA, 50, '#d8c8a8'); for (let x = LN.PORTA; x < W; x += 12) for (let y = 220; y < 270; y += 12) { const on = ((x / 12) + (y / 12)) % 2; R(c, x, y, 12, 12, on ? '#c8b494' : '#e2d4b4'); R(c, x + 5, y + 5, 2, 2, on ? '#a84a3a' : '#3a6aa8'); }
    R(c, 0, 220, LN.PORTA, 50, '#7a7468'); R(c, LN.PORTA, 220, W - LN.PORTA, 2, '#a89878');
    window.LugaresFundos?.lancheChao?.(c, W, LN.PORTA);
    return cv;
  }
  function lanche(c, s, t, camL) {
    if (!lancheMid) lancheMid = buildLanche(); const n = noiteDe(s);
    // céu da rua
    { const sx = -camL; if (sx > -160) { const g = c.createLinearGradient(0, 0, 0, 190); g.addColorStop(0, n > .5 ? '#0c1230' : '#7ab8e8'); g.addColorStop(1, n > .5 ? '#2a2448' : '#d8ecf8'); c.fillStyle = g; c.fillRect(sx, 0, LN.PORTA, 190); if (n > .4) for (let k = 0; k < 14; k++) R(c, sx + hash(k) * 140, hash(k + 2) * 60, 1, 1, '#ffffff'); } }
    c.drawImage(lancheMid, camL, 0, 482, 270, 0, 0, 482, 270);
    // janelas dos casarios acendem à noite; poste da rua
    { const sx = -camL; if (sx > -160 && n > .05) R(c, sx, 0, 142, 220, `rgba(10,14,40,${(.5 * n).toFixed(2)})`); }
    { const sx = -camL; if (sx > -160 && n > .3) { for (let k = 0; k < 4; k++) for (let j = 0; j < 2; j++) if (hash(k * 3 + j) > .35) { const x = sx + k * 38 + 2 + j * 14, y = (150 - (70 + (k % 2) * 14)) + 14; R(c, x, y, 9, 14, '#ffd27a'); glow(c, x + 4, y + 7, 12, '#ffb050', .35 * n); } }
      const px = sx + 40; if (px > -30) { R(c, px, 100, 3, 90, '#3a3e44'); R(c, px - 8, 96, 19, 5, '#4a4e54'); R(c, px - 5, 101, 13, 2, '#fff2c0'); if (n > .2) { cone(c, px + 1, 103, 6, 40, 90, 'rgba(255,230,170,1)', .18 * n); glow(c, px + 1, 102, 20, '#ffe0a0', .6 * n); } } }
    // letreiro neon ZITO LANCHES (com tremidinha) por cima da porta
    { const x = 168 - camL + 60, on = Math.sin(t * 7.3) > -.9; if (x > -120 && x < 600) { R(c, x - 50, 94, 104, 20, '#1a1220'); c.save(); c.strokeStyle = on ? '#ff5aa8' : '#5a2a44'; c.lineWidth = 1; c.strokeRect(x - 49.5, 94.5, 103, 19); c.restore(); if (on) glow(c, x, 104, 70, '#ff5aa8', .35); } }
    // lâmpadas pendentes com halo quente
    for (const x of LN.PEND) { const sx = x - camL; if (sx < -60 || sx > 540) continue; R(c, sx, 28, 1, 30, '#2a2a2a'); c.fillStyle = '#2c5a3a'; c.beginPath(); c.moveTo(sx - 8, 66); c.lineTo(sx + 9, 66); c.lineTo(sx + 4, 58); c.lineTo(sx - 3, 58); c.closePath(); c.fill(); R(c, sx - 3, 66, 7, 2, '#fff6d0');
      cone(c, sx, 68, 8, 30, 120, 'rgba(255,220,150,1)', .14); glow(c, sx, 68, 26, '#ffd890', .55); }
    // luz da estufa de salgados, da geladeira e da TV
    { const sx = 530 - camL; if (sx > -120 && sx < 600) { glow(c, sx, 140, 70, '#ff9a40', .35 + Math.sin(t * 2) * .04); } }
    { const sx = 768 - camL; if (sx > -60 && sx < 540) glow(c, sx, 140, 50, '#7ad8ff', .28); }
    { const sx = 861 - camL; if (sx > -60 && sx < 540) { const k = .5 + .5 * Math.sin(t * 5.3) * Math.sin(t * 1.7); R(c, sx - 39, 56, 78, 44, `rgba(${Math.round(40 + k * 40)},${Math.round(110 + k * 30)},${Math.round(40 + k * 20)},1)`); R(c, sx - 1, 56, 1, 44, '#e8f8e8'); const bx = sx - 30 + (Math.sin(t * .9) * .5 + .5) * 60; R(c, bx, 76 + Math.sin(t * 2.3) * 8, 2, 2, '#ffffff'); glow(c, sx, 80, 60, '#8af08a', .18 + k * .06); } }
    // vapor dos salgados, bolhas da fritadeira e o ventilador de teto
    for (let k = 0; k < 8; k++) { const u = (t * .35 + k / 8) % 1, x = 452 + k * 21 - camL + Math.sin(t * 2 + k) * 3; c.globalAlpha = (1 - u) * .5; R(c, x, 132 - u * 34, 2, 2, '#ffffff'); c.globalAlpha = 1; }
    { const fx = 646 - camL; if (fx > -40 && fx < 520) for (let k = 0; k < 6; k++) { const u = (t * 2 + k / 6) % 1; R(c, fx - 12 + hash(k) * 26, 134 - u * 6, 1, 1, '#fff2c0'); } fumacaSobe(c, 646 - camL, 124, t, 5, 30, '#e8e8f0'); }
    { const vx = 600 - camL; if (vx > -40 && vx < 520) { R(c, vx, 28, 2, 12, '#3a3e44'); ell(c, vx + 1, 40, 5, 2, '#5a3820'); for (let k = 0; k < 4; k++) { const a = t * 7 + k * Math.PI / 2; R(c, vx + 1 + Math.cos(a) * 16 - 2, 40 + Math.sin(a) * 2, 5, 2, '#7a4a2a'); } } }
    // gatinho dormindo na cadeira (respira)
    { const gx = 324 - camL; if (gx > -30 && gx < 510) { const b = Math.sin(t * 1.6) * .6; ell(c, gx, 191 - b, 8, 4 + b * .4, '#e8a85a'); ell(c, gx + 7, 190, 4, 3, '#e8a85a'); R(c, gx + 5, 187, 1, 2, '#e8a85a'); R(c, gx + 9, 187, 1, 2, '#e8a85a'); R(c, gx - 8, 192, 6, 2, '#d8984a'); if (Math.floor(t * .7) % 3 === 0) { c.globalAlpha = .7; R(c, gx + 12, 180 - (t * 6 % 8), 3, 1, '#ffffff'); c.globalAlpha = 1; } } }
    // reflexo quente no chão
    for (const x of LN.PEND) { const sx = x - camL; if (sx < -60 || sx > 540) continue; c.globalAlpha = .14; ell(c, sx, 232, 26, 4, '#fff2c0'); c.globalAlpha = 1; }
    window.LugaresFundos?.lancheAnim?.(c, t, camL, n);
  }
  const CLIENTES = { cliente_dona: { name: 'Cliente', skin: '#d8a77f', shade: '#ab7856', build: 'belly', h: .92, top: '#3a8a6a', topKind: 'cardigan', inner: '#f2e6c8', skirt: '#5a4a62', hair: { style: 'curlyShort', color: '#d9d6d0' }, glasses: '#7a5a3a', bag: '#b8643a', pose: 'talk' },
    cliente_rapaz: { name: 'Cliente', skin: '#8a5a3c', shade: '#5f3d2a', build: 'slim', top: '#e8c24a', topKind: 'tee', sleeve: 'short', pants: '#2a3442', hat: { kind: 'capback', color: '#3a6aa8' }, hair: { style: 'short', color: '#1c1714' }, item: 'mug', pose: 'mug' } };
  const regClientes = () => { const CP = window.CampanhaPersonagens; if (!CP?.registrar) return false; for (const [id, sp] of Object.entries(CLIENTES)) CP.registrar(id, sp, 'NPC (lanchonete)'); return true; };
  if (!regClientes()) addEventListener('DOMContentLoaded', regClientes, { once: true });
  function lancheText(c, cam) { c.save(); c.translate(-Math.round(cam), 0);
    // clientes ao fundo (desenhados atrás do jogador)
    try { const tt = performance.now() / 1000; window.Art?.drawCharacter?.(c, 'cliente_dona', 470, 440, { frame: tt, facing: 1, grounded: true }); window.Art?.drawCharacter?.(c, 'cliente_rapaz', 1780, 440, { frame: tt + 2, facing: -1, grounded: true }); } catch (e) {}
    c.textAlign = 'left'; c.textBaseline = 'middle'; c.font = '10px Pixel, monospace';
    const itens = [['COXINHA', '5'], ['PASTEL DE QUEIJO', '7'], ['ACARAJÉ', '10'], ['SUCO DE CACAU', '6'], ['CALDO DE CANA', '5']];
    c.fillStyle = '#ffe9a8'; c.font = '12px Pixel, monospace'; c.fillText('CARDÁPIO', 622, 100); c.font = '10px Pixel, monospace';
    itens.forEach(([nm, p], i) => { c.fillStyle = '#f2f2ea'; c.fillText(nm, 622, 126 + i * 18); c.fillStyle = '#f2c94c'; c.fillText('R$ ' + p, 940, 126 + i * 18); });
    c.textAlign = 'center'; c.font = '13px Pixel, monospace'; c.fillStyle = '#ff9ad0'; c.fillText('ZITO LANCHES', 456, 208); c.font = '8px Pixel, monospace'; c.fillStyle = '#3a2a1a'; c.fillText('ABERTO', 160, 160); c.font = '7px Pixel, monospace'; c.fillStyle = '#7a2a1a'; c.fillText('FIADO SÓ AMANHÃ', 1270, 106); c.restore(); }

  /* ---------------- 42 · AÇUDE DA ROÇA ---------------- */
  const AC = { CASA: 520, FOGO: 1620, POSTES: [1190, 1390, 1590], CACH: 60 };
  function acude(c, s, t, camL) {
    const n = noiteDe(s);
    if (K?.sky) K.sky(c, s, t, camL, {}); else { R(c, 0, 0, 482, 150, '#9ad0f0'); }
    // morros distantes com a casinha de fazenda (janelas acesas e fumaça na chaminé)
    const tinta = (d, nt) => (n > .5 ? nt : d);
    const F = window.LugaresFundos;
    if (F) F.camadaAcude(c, s, t, camL, n); else for (let i = -1; i < 7; i++) { const x = i * 130 - (camL * .12 % 130); ell(c, x + 65, 150, 96, 44, tinta('#5a8a6a', '#1c2a3a')); }
    { const hx = AC.CASA * .12 * 0 + 300 - camL * .12; if (hx > -80 && hx < 560) { const y = 104;
      R(c, hx - 18, y, 36, 22, tinta('#e8d8b8', '#3a3448')); c.fillStyle = tinta('#a8543a', '#2a2238'); c.beginPath(); c.moveTo(hx - 22, y); c.lineTo(hx, y - 16); c.lineTo(hx + 22, y); c.closePath(); c.fill();
      R(c, hx + 8, y - 16, 5, 10, tinta('#8a4a3a', '#3a2a2a')); for (const wx of [hx - 12, hx + 6]) { R(c, wx, y + 6, 6, 6, n > .3 ? '#ffc860' : '#5a7a9a'); if (n > .3) glow(c, wx + 3, y + 9, 14, '#ffb040', .5 * n); }
      fumacaSobe(c, hx + 10, y - 18, t, 9, 46, n > .5 ? '#5a5a78' : '#d8dce8'); } }
    F?.mataAcude?.(c, t, camL, n);
    if (F) F.arvoresAcude(c, t, camL, n); else { for (let i = -1; i < 10; i++) { const x = i * 84 - (camL * .3 % 84); ell(c, x + 42, 156, 56, 20, tinta('#3a7a4a', '#14202a')); for (let k = 0; k < 2; k++) { const tx = x + 20 + k * 38; R(c, tx, 128, 2, 16, tinta('#4a3a2a', '#0c1218')); ell(c, tx + 1, 126, 8, 5, tinta('#2a6a3a', '#0e1820')); } } }
    // a água: degradê, reflexo da lua/sol em coluna tremida e marolas
    if (F) F.aguaAcude(c, t, camL, n); else { const wg = c.createLinearGradient(0, 150, 0, 198); wg.addColorStop(0, tinta('#5a9ac8', '#16264a')); wg.addColorStop(1, tinta('#2a6a98', '#0c1630')); c.fillStyle = wg; c.fillRect(0, 150, 482, 48); }
    { const lx = n > .5 ? (50 + (s.moonT ?? .5) * 380 - camL * .012) : (40 + (s.sunT ?? .5) * 400 - camL * .012); for (let y = 152; y < 198; y += 2) { const w = 3 + Math.sin(t * 3 + y * .7) * 2 + (y - 150) * .12; c.globalAlpha = .55 - (y - 150) / 120; R(c, lx - w + Math.sin(t * 2 + y) * 2, y, w * 2, 1, n > .5 ? '#e8f0ff' : '#fff6c8'); } c.globalAlpha = 1; }
    if (!F) { for (let k = 0; k < 44; k++) { const x = ((k * 53 - camL * .7 + t * 5) % 520 + 520) % 520 - 20, y = 154 + (k * 7) % 40; R(c, x, y, 5 + (k % 3) * 4, 1, tinta(k % 2 ? '#8ac0e0' : '#6aa8d0', k % 2 ? '#2a3a6a' : '#22325a')); } }
    // cachoeirinha descendo o morro para o açude
    { const x = AC.CACH - camL * .7; if (x > -40 && x < 520) { R(c, x - 10, 118, 22, 34, tinta('#5a6a5a', '#1a2228')); for (let k = 0; k < 12; k++) { const u = (t * 1.6 + k / 12) % 1; R(c, x - 6 + (k % 4) * 3, 120 + u * 32, 2, 4, tinta('#d8f0ff', '#6a8ab8')); } for (let k = 0; k < 6; k++) ell(c, x + (k - 3) * 4, 152 + Math.sin(t * 6 + k) , 3, 1, tinta('#ffffff', '#8aa8d8')); } }
    // vitórias-régias com flor e taboas na beira
    for (const wx of [240, 330, 980, 1900, 2150]) { const x = wx * .5 - camL; if (x < -20 || x > 500) continue; ell(c, x, 186, 9, 3, tinta('#3a8a3a', '#1a3a2a')); R(c, x + 2, 186, 4, 1, tinta('#2a6a2a', '#12281e')); if (wx % 3 === 0) { R(c, x - 1, 183, 3, 2, '#f2a8c8'); R(c, x, 182, 1, 1, '#ffffff'); } }
    // capivaras (mastigando), garça e o barco que balança
    for (const wx of [700, 1100]) { const x = wx - camL; if (x < -30 || x > 510) continue; const mast = Math.sin(t * 6 + wx) > 0 ? 1 : 0; ell(c, x, 196, 15, 8, '#7a4e30'); ell(c, x - 2, 193, 12, 4, '#8a5a36'); ell(c, x + 13, 191 + mast * .5, 7, 5, '#6a4228'); R(c, x + 16, 188, 2, 2, '#1c1c1c'); R(c, x + 12, 186, 3, 2, '#5a3a22'); R(c, x - 11, 201, 3, 6, '#5a3820'); R(c, x + 6, 201, 3, 6, '#5a3820'); }
    { const x = 900 - camL; if (x > -20 && x < 500) { R(c, x, 168, 2, 20, '#f2f2ee'); ell(c, x + 2, 166, 7, 4, '#ffffff'); R(c, x + 7, 164, 7, 1, '#e8c24a'); R(c, x + 1, 186, 1, 12, '#3a3a3a'); R(c, x + 3, 186, 1, 12, '#3a3a3a'); } }
    { const x = 260 - camL, y = 176 + Math.sin(t * 1.5) * 1.5; if (x > -60 && x < 520) { c.fillStyle = '#6a3a1a'; c.beginPath(); c.moveTo(x - 26, y); c.lineTo(x + 26, y); c.lineTo(x + 17, y + 9); c.lineTo(x - 17, y + 9); c.closePath(); c.fill(); R(c, x - 24, y, 48, 2, '#a86a3a'); R(c, x - 6, y - 2, 12, 2, '#8a5a2a'); c.globalAlpha = .3; ell(c, x, y + 12, 26, 2, '#0c1630'); c.globalAlpha = 1; } }
    F?.vidaAgua?.(c, t, camL, n);
    // margem com capim, flores e pedras com musgo
    if (F?.bancoAcude) F.bancoAcude(c, t, camL, n); else { R(c, 0, 198, 482, 22, tinta('#7a6a42', '#2a2a2a')); for (let k = 0; k < 70; k++) { const x = ((k * 37 - camL) % 500 + 500) % 500 - 10; R(c, x, 191 + (k % 4), 1, 7 + (k % 3) * 2, tinta('#4a8a3a', '#1a3a22')); if (k % 9 === 0) R(c, x + 1, 190, 2, 2, ['#f2c94c', '#f2a8c8', '#ffffff'][k % 3]); } }
    for (const wx of [150, 880, 2280]) { const x = wx * .5 - camL * .9; if (x < -30 || x > 510) continue; ell(c, x, 204, 12, 6, tinta('#6a6a6a', '#22262e')); ell(c, x - 3, 201, 7, 3, tinta('#4a7a3a', '#1a3020')); }
    // postes de lampião no píer e cordão de lâmpadas
    for (const wx of AC.POSTES) { const x = wx / 2 - camL; if (x < -40 || x > 520) continue; R(c, x, 150, 2, 40, '#3a2a1a'); R(c, x - 3, 146, 8, 6, '#2a2420'); R(c, x - 2, 147, 6, 4, n > .15 ? '#ffd27a' : '#c8c0a0'); if (n > .15) { glow(c, x + 1, 149, 26, '#ffc060', .65 * n); c.globalAlpha = .35 * n; R(c, x - 1, 170, 4, 26, '#ffd27a'); c.globalAlpha = 1; } }
    { const a = AC.POSTES[0] / 2 - camL, b = AC.POSTES[2] / 2 - camL; if (b > -20 && a < 500) for (let k = 0; k <= 24; k++) { const u = k / 24, x = a + (b - a) * u, y = 150 + Math.sin(u * Math.PI * 2 % Math.PI) * 6 + Math.abs(Math.sin(u * Math.PI * 2)) * 4; R(c, x, y, 1, 1, '#3a2a1a'); if (k % 3 === 0) { const cor = ['#ff8a5a', '#ffd27a', '#8ad8ff'][k % 3 === 0 ? (k / 3) % 3 : 0]; R(c, x, y + 1, 2, 2, cor); if (n > .15) glow(c, x + 1, y + 2, 6, cor, .5 * n); } } }
    // canto do Seu Vagner: guarda-sol vermelho, balde, vara encostada e a fogueira estalando
    { const x = AC.FOGO / 2 - camL; if (x > -60 && x < 540) {
      R(c, x - 50, 150, 2, 40, '#5a5a5a'); c.fillStyle = '#c43c3a'; c.beginPath(); c.moveTo(x - 76, 156); c.quadraticCurveTo(x - 49, 132, x - 22, 156); c.closePath(); c.fill(); for (let k = 0; k < 4; k++) R(c, x - 70 + k * 14, 152 - (k === 1 || k === 2 ? 4 : 0), 1, 4, '#8a2a2a');
      R(c, x - 32, 182, 10, 8, '#3a6aa8'); R(c, x - 32, 182, 10, 2, '#6a9ad8'); c.strokeStyle = '#6a4a2a'; c.lineWidth = 1; c.beginPath(); c.moveTo(x - 40, 190); c.lineTo(x - 10, 138); c.stroke();
      const fy = 204; R(c, x - 8, fy, 16, 3, '#3a2a1a'); R(c, x - 6, fy - 2, 3, 3, '#5a3a22'); R(c, x + 3, fy - 2, 3, 3, '#5a3a22');
      for (let k = 0; k < 5; k++) { const h = 6 + Math.abs(Math.sin(t * 8 + k * 1.7)) * 6 + (k === 2 ? 4 : 0); R(c, x - 5 + k * 2.4, fy - h, 2, h, k % 2 ? '#ff8a2a' : '#ffc640'); } R(c, x - 1, fy - 5, 2, 4, '#fff6d0');
      glow(c, x, fy - 6, 44, '#ff9a40', .55 + Math.sin(t * 9) * .06); glow(c, x, fy - 6, 14, '#fff2c0', .5);
      for (let k = 0; k < 8; k++) { const u = (t * .5 + hash(k)) % 1, ex = x + (hash(k + 3) - .5) * 10 + Math.sin(t * 2 + k) * u * 8, ey = fy - 8 - u * 50; c.globalAlpha = 1 - u; R(c, ex, ey, 1, 1, k % 2 ? '#ffb040' : '#ffe08a'); c.globalAlpha = 1; }
      fumacaSobe(c, x + 2, fy - 14, t, 6, 34, n > .5 ? '#4a4a60' : '#c8c8d0'); } }
    { const x = 695 - camL; if (x > -60 && x < 540) { R(c, x - 38, 186, 3, 26, '#5a3a20'); R(c, x + 35, 186, 3, 26, '#5a3a20'); R(c, x - 46, 136, 92, 18, '#3a2410'); R(c, x - 45, 137, 90, 16, '#8a5a32'); R(c, x - 45, 137, 90, 2, '#b8845a'); R(c, x - 2, 154, 4, 32, '#5a3a20'); } }
    // chão de terra batida com pedrinhas
    if (F) F.chaoAcude(c, t, camL, n); else { R(c, 0, 220, 482, 50, tinta('#8a7a56', '#2a2620')); for (let x = 0; x < 482; x += 10) { const wx = x + camL; R(c, x - (camL % 10), 224 + (Math.floor(wx / 10) % 4) * 6, 3, 2, tinta('#6a5a3e', '#1e1a16')); } }
    // sapinhos, vagalumes (muitos à noite) e borboletas de dia
    for (const wx of [400, 1680]) { const x = wx - camL, pulo = Math.max(0, Math.sin(t * 2 + wx)) * 6; if (x > -10 && x < 490) { ell(c, x, 216 - pulo, 4, 3, '#5aa84a'); R(c, x - 2, 213 - pulo, 1, 1, '#1c1c1c'); R(c, x + 2, 213 - pulo, 1, 1, '#1c1c1c'); } }
    if (n > .2) vagalumes(c, 0, 482, 120, 214, t, 26, .7 * n); else for (let k = 0; k < 4; k++) { const x = (hash(k) * 600 + t * 12 - camL * .5) % 520, y = 160 + Math.sin(t * 2 + k) * 14; R(c, x, y, 2, 1, ['#f2c94c', '#ffffff', '#f2a8c8', '#8ad8ff'][k]); R(c, x + (Math.sin(t * 18 + k) > 0 ? 1 : -1), y - 1, 1, 1, ['#f2c94c', '#ffffff', '#f2a8c8', '#8ad8ff'][k]); }
  }
  function acudeText(c, cam) { c.save(); c.translate(-Math.round(cam), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '9px Pixel, monospace'; c.fillStyle = '#fff6dc'; c.fillText('AÇUDE DA ROÇA', 1390, 282); c.font = '7px Pixel, monospace'; c.fillStyle = '#ffe0a8'; c.fillText('PROIBIDO NADAR COM CAPIVARA', 1390, 298); c.restore(); }

  // plataformas desenhadas no estilo de cada lugar (as mesmas áreas de pisar do jogo)
  function plataforma(c, p, scene, t) {
    const [x, y, w] = p; scene = Number(scene); if (!LUGARES[scene]) return false;
    if (scene === 40) { R(c, x, y, w, 8, '#6a7482'); R(c, x, y, w, 2, '#b8c0c8'); R(c, x, y + 8, w, 2, '#3a4250'); for (let k = 6; k < w; k += 12) R(c, x + k, y + 4, 2, 2, '#3a4250'); for (const lx of [x + 4, x + w - 8]) { R(c, lx, y + 10, 4, FLOOR - y - 10, '#4a5462'); for (let yy = y + 14; yy < FLOOR - 4; yy += 10) R(c, lx + 1, yy, 2, 4, '#2a3038'); }
      for (let k = 0, i = 0; k < w - 20; k += 28, i++) { const h = i % 2 ? 12 : 14; R(c, x + 10 + k, y - h, 22, h, i % 3 === 2 ? '#8a6a3a' : '#a8784a'); R(c, x + 10 + k, y - h, 22, 2, '#c89a68'); R(c, x + 19 + k, y - h, 4, h, 'rgba(232,212,150,.55)'); R(c, x + 12 + k, y - h + 5, 6, 4, '#f2f2ee'); R(c, x + 13 + k, y - h + 6, 4, 1, '#3a3a3a'); R(c, x + 25 + k, y - 5, 4, 3, '#c43c3a'); } return true; }
    if (scene === 41) { R(c, x, y, w, 8, '#8a5a36'); R(c, x, y, w, 2, '#b8845a'); for (let k = 0; k < w; k += 12) R(c, x + k, y - 16, 2, 16, '#5a3820'); R(c, x, y - 17, w, 3, '#7a4a2a'); for (const lx of [x + 6, x + w - 10]) R(c, lx, y + 8, 4, FLOOR - y - 8, '#5a3820'); return true; }
    if (scene === 42) { for (let k = 8; k < w; k += 70) { R(c, x + k, y + 8, 6, FLOOR - y + 10, '#5a3a20'); R(c, x + k, y + 8, 2, FLOOR - y + 10, '#7a5230'); R(c, x + k, y + 22, 6, 6, '#4a7a3a'); R(c, x + k + 1, y + 28, 4, 2, '#3a6a2a'); }
      R(c, x, y, w, 8, '#9a6a3a'); for (let k = 0, i = 0; k < w; k += 14, i++) { R(c, x + k, y, 13, 2, ['#c8945a', '#b8844e', '#d0a066'][i % 3]); R(c, x + k + 13, y, 1, 8, '#6a4224'); R(c, x + k + 2, y + 3, 1, 1, '#3a2414'); R(c, x + k + 10, y + 3, 1, 1, '#3a2414'); if (i % 4 === 1) R(c, x + k + 4, y + 5, 6, 1, '#7a5230'); }
      R(c, x, y + 8, w, 2, 'rgba(0,0,0,.3)'); R(c, x + 6, y + 10, 10, 2, '#c8b88a'); R(c, x + 8, y + 12, 6, 2, '#a8986a'); R(c, x + 14, y + 13, 2, 8, '#c8b88a'); return true; }
    return false;
  }

  if (window.HdMaps?.register) {
    const interno = () => [1, 1, 1];
    window.HdMaps.register(40, { always: true, draw: oficina, text: oficinaText, amb: interno });
    window.HdMaps.register(41, { always: true, draw: lanche, text: lancheText, amb: interno });
    window.HdMaps.register(42, { always: true, draw: acude, text: acudeText });
  }

  /* ---------------- conversas e missões ---------------- */
  const fala = (name, text, actionLabel) => (actionLabel ? { name, text, actionLabel } : { name, text });
  const achadas = (q) => new Set((Array.isArray(q?.ferramentas) ? q.ferramentas : []).filter((id) => FERRAMENTAS.some((f) => f.id === id)));
  function falar(id, q, api) {
    const N = NPCS[id]?.name || id;
    if (id === 'tio_juca') {
      if (q.ferramentasFeita) { api.say([fala(N, 'Com as ferramentas no lugar, essa oficina conserta até avião. Teu carro a gás tá voando bonito, hein?')]); return; }
      if (!q.ferramentasAceita) { api.say([fala(N, 'Ô Da Roça! Sou o Juca, tio do Lucas. Foi aqui que a gente montou o carro a gás do teu pai.'), fala(N, 'Só que o gato da oficina derrubou tudo das prateleiras: a chave inglesa, o macaco e o meu alicate da sorte.'), fala('Da Roça', 'Deixa que eu subo nas prateleiras. Parkour de oficina é comigo!', 'Procurar as ferramentas')], () => { q.ferramentasAceita = true; q.ferramentas = []; api.toast('Missão Ferramentas sumidas: ache 3 ferramentas nas prateleiras da oficina.'); api.save(); }); return; }
      const n = achadas(q).size;
      if (n < FERRAMENTAS.length) { api.say([fala(N, `Achou ${n} de 3. Olha nas prateleiras de cima: o gato adora esconder coisa no alto.`)]); return; }
      api.say([fala('Da Roça', 'Chave inglesa, macaco e alicate da sorte. Tudo aqui, Tio Juca!'), fala(N, 'Rapaz! Toma esses materiais que sobraram do conserto. Leva pro Kauã que ele transforma em arma.', 'Receber o prêmio')], () => { q.ferramentasFeita = true; api.materiais(3); api.xp(160, 'side-ferramentas'); api.toast('Ferramentas sumidas: +3 materiais escolares e XP!'); api.save(); });
      return;
    }
    if (id === 'zito') {
      const primeira = !q.zitoVisita;
      api.say([fala(N, primeira ? 'Bem-vindo à Lanchonete do Zito! Coxinha quentinha, pastel de queijo e suco de cacau da roça.' : 'Voltou, cliente de ouro! O de sempre?'), fala(N, 'Herói de Itabuna não paga lanche aqui. Senta aí que eu caprichei.'), fala('Da Roça', 'Coxinha com suco de cacau... isso é poder elemental!', 'Comer o lanche')], () => { api.curar(); if (primeira) { q.zitoVisita = true; api.xp(60, 'side-zito'); } api.toast('Lanche do Zito: vida e gás cheios!'); api.save(); });
      return;
    }
    if (id === 'vagner') {
      const ja = !!q.pescaria;
      api.say([fala(N, ja ? 'O açude ainda tá falando daquela pescaria! Bora de novo? A fogueira tá acesa pro peixe frito.' : 'Psiu... fala baixo que os peixes escutam. Sou o Vagner, pescador desse açude desde menino.'), fala(N, 'Quando a boia afundar, puxa! Aperta o botão ou E na hora certa. Pega três peixes e tu vira pescador de verdade.', 'Pescar')], () => {
        window.PescariaBene?.abrir?.({ onFim: (peixes) => { if (peixes >= 3 && !q.pescaria) { q.pescaria = true; api.xp(150, 'side-pescaria'); api.curar(); api.toast(`${peixes} peixes! Seu Vagner fritou na fogueira: vida e gás cheios e XP de pescador.`); api.save(); } else if (peixes >= 3) { api.curar(); api.toast(`${peixes} peixes! Peixe frito de novo: vida e gás cheios.`); } else api.toast(`${peixes} peixe(s). O Seu Vagner disse que a boia não espera ninguém.`); } });
      });
    }
  }
  function coletar(q, player, scene) {
    if (Number(scene) !== 40 || !q?.ferramentasAceita || q.ferramentasFeita || !player) return null;
    const a = achadas(q), f = FERRAMENTAS.find((p) => !a.has(p.id) && Math.abs(player.x - p.x) <= 34 && Math.abs((player.y - 30) - p.y) <= 44); if (!f) return null;
    a.add(f.id); q.ferramentas = [...a]; return { count: a.size, message: a.size >= 3 ? 'Ferramentas 3/3! Volte ao Tio Juca.' : `${f.nome} · ${a.size}/3` };
  }
  function desenhar(c, t, q, scene) {
    if (Number(scene) !== 40 || !q?.ferramentasAceita || q.ferramentasFeita) return; const a = achadas(q);
    for (const f of FERRAMENTAS) { if (a.has(f.id)) continue; const x = f.x, y = f.y + Math.sin(t * 3 + x) * 4;
      c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .3; c.fillStyle = '#ffd24a'; c.beginPath(); c.arc(x, y, 18, 0, TAU); c.fill(); c.restore();
      if (f.id === 'chave') { R(c, x - 12, y - 2, 24, 4, '#9aa0a6'); R(c, x - 16, y - 6, 8, 12, '#9aa0a6'); R(c, x - 13, y - 3, 3, 6, '#3a3e44'); }
      else if (f.id === 'macaco') { R(c, x - 12, y + 2, 24, 6, '#c43c3a'); R(c, x - 3, y - 10, 6, 12, '#e86a5a'); R(c, x - 6, y - 12, 12, 3, '#7a8086'); }
      else { R(c, x - 2, y - 10, 4, 10, '#c43c3a'); R(c, x + 2, y - 10, 4, 10, '#e8c24a'); R(c, x - 1, y, 6, 8, '#9aa0a6'); } }
  }
  function objetivo(q, scene) {
    if (Number(scene) === 40 && q?.ferramentasAceita && !q.ferramentasFeita) { const n = achadas(q).size; return ['Ferramentas sumidas', n >= 3 ? 'Leve as três ferramentas ao Tio Juca.' : `${n}/3 ferramentas achadas nas prateleiras da oficina.`]; }
    if (LUGARES[scene]) return [LUGARES[scene].nome, LUGARES[scene].sub + '. Use o carro a gás (mapa) para voltar à campanha.'];
    return null;
  }
  function alvo(q, scene) { if (Number(scene) !== 40 || !q?.ferramentasAceita || q.ferramentasFeita) return null; const a = achadas(q); return FERRAMENTAS.find((f) => !a.has(f.id))?.x ?? NPCS.tio_juca.x; }

  window.LugaresC1 = Object.freeze({
    ids: Object.keys(LUGARES).map(Number), tem: (n) => !!LUGARES[Number(n)], nome: (n) => LUGARES[Number(n)]?.nome || '', sub: (n) => LUGARES[Number(n)]?.sub || '',
    largura: (n) => LUGARES[Number(n)]?.largura || 0, plataformas: (n) => (LUGARES[Number(n)]?.plataformas || []).map((p) => p.slice()), porta: (n) => LUGARES[Number(n)]?.porta ?? null,
    npcs: Object.freeze({ ...NPCS }), ehNpc: (id) => !!NPCS[id], falar, coletar, desenhar, objetivo, alvo, plataforma
  });
})();
