/* Mapa pixelado em vista de cima inclinada (estilo RPG de cima): terreno em níveis com paredões de terra, água com
   espuma na beira, caminhos de pedra, cercas, casas com telhado e fachada, árvores redondas com sombra.
   Tudo desenhado aqui mesmo, em lajotas de 16x16 pixels (nenhuma imagem de fora).
   Ao tocar num lugar: a câmera desliza até ele com zoom, o prédio dá um pulinho (estica e encolhe), saem faíscas e
   abre a prévia com IR PARA LÁ embaixo e o botão ⓘ com uma descrição sem spoiler. Ao confirmar, o carro (ou o
   táxi) anda pelo mapa até o destino, com a câmera seguindo, e a tela escurece.
   Uso: Mapa3D.abrir(def). (O nome ficou do primeiro desenho; agora é pixel art 2D com cara de 3D.) */
(() => {
  'use strict';
  if (window.Mapa3D) return;
  const TS = 16, ease = (u) => (u < .5 ? 4 * u * u * u : 1 - Math.pow(-2 * u + 2, 3) / 2), easeOut = (u) => 1 - Math.pow(1 - u, 3);
  const hash = (a, b = 0) => { const x = Math.sin(a * 127.1 + b * 311.7 + 74.7) * 43758.5453; return x - Math.floor(x); };

  /* =====================================================================
     ARTE: paleta e peças (tudo em pixels de arte)
     ===================================================================== */
  const COR = { grama: '#5fae3c', gramaC: '#76c64c', gramaE: '#4f9a34', gramaB: '#3c7a2c', borda: '#2f5e26', terra: '#c87a4a', terraE: '#a85e38', terraC: '#e29a62', terraB: '#7a4228',
    agua: '#4a92e2', aguaE: '#3a7ad0', aguaC: '#7ac2f2', espuma: '#e2f4ff', pedra: '#bcc0c4', pedraE: '#9aa0a6', pedraC: '#dde0e3', pedraB: '#7a8086', chao: '#d8a06e', chaoE: '#bf8656', asfalto: '#5b6066', asfaltoE: '#4c5156', areia: '#e8d494' };
  const shade = (hex, k) => { if (!/^#[0-9a-f]{6}$/i.test(hex)) return hex; const n = parseInt(hex.slice(1), 16), f = (v) => Math.max(0, Math.min(255, Math.round(v * k))); return '#' + [(n >> 16) & 255, (n >> 8) & 255, n & 255].map((v) => f(v).toString(16).padStart(2, '0')).join(''); };
  function Px(c) {
    const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
    const circ = (cx, cy, r, col, ry = r) => { c.fillStyle = col; for (let y = -ry; y <= ry; y++) { const w = Math.round(r * Math.sqrt(Math.max(0, 1 - (y / ry) * (y / ry)))); c.fillRect(Math.round(cx - w), Math.round(cy + y), w * 2 + 1, 1); } };
    const P = {
      c, R, circ,
      sombra: (cx, cy, rx, ry, a = .22) => { c.globalAlpha = a; circ(cx, cy, rx, '#0c1a10', ry); c.globalAlpha = 1; },
      arvore: (cx, by, s = 1, tipo = 'verde', seed = 0) => { // árvore de copa fofa (vários tufos), com contorno, luz de cima e sombra no chão
        const pal = { verde: ['#24501f', '#3a7f2e', '#55a23a', '#79c44c', '#b0e27a'], escura: ['#1c3c1a', '#2a6228', '#3a7f2e', '#55a23a', '#86c95a'], roxa: ['#3e2250', '#6e3490', '#9a52c0', '#c084de', '#ecc8f8'], amarela: ['#5a420c', '#a8841a', '#d8b026', '#f2d448', '#fff4a0'], laranja: ['#4a220c', '#9a4818', '#d0722a', '#ee9c48', '#ffd08a'], rosa: ['#5a2240', '#a84478', '#d86aa0', '#f09ac0', '#ffd8ea'] }[tipo] || ['#24501f', '#3a7f2e', '#55a23a', '#79c44c', '#b0e27a'];
        const r = Math.max(5, Math.round(9 * s)), cy = by - Math.round(8 * s) - r * .8; P.sombra(cx + 4, by, r + 4, Math.round(r * .42) + 1, .26);
        R(cx - 2, by - 9 * s, 5, 9 * s, '#5a3820'); R(cx - 1, by - 9 * s, 2, 9 * s, '#8a5a36'); R(cx - 4, by - 2, 3, 2, '#5a3820'); R(cx + 2, by - 2, 3, 2, '#4a2e18');
        const j = (k) => (hash(seed + k, 5) - .5) * r * .25, tufos = [[0, 0, r], [-r * .62 + j(1), r * .22, r * .66], [r * .62 + j(2), r * .18, r * .64], [j(3), -r * .5, r * .66], [-r * .3, -r * .1, r * .6]];
        for (const [dx, dy, rr] of tufos) circ(cx + dx, cy + dy + 1, rr + 1, pal[0]);
        for (const [dx, dy, rr] of tufos) circ(cx + dx, cy + dy, rr, pal[1]);
        for (const [dx, dy, rr] of tufos) circ(cx + dx - rr * .2, cy + dy - rr * .25, rr * .7, pal[2]);
        for (const [dx, dy, rr] of tufos) circ(cx + dx - rr * .38, cy + dy - rr * .45, Math.max(1, rr * .32), pal[3]);
        for (let k = 0; k < 7 * s; k++) { const a = hash(seed + k) * 6.28, d = hash(seed * 3 + k) * (r - 2); R(cx + Math.cos(a) * d, cy + Math.sin(a) * d * .8 - 2, 2, 1, pal[k % 3 === 0 ? 4 : 3]); }
        for (let k = 0; k < 5 * s; k++) { const a = .6 + hash(seed + k * 7) * 1.9, d = r * .9; R(cx + Math.cos(a) * d, cy + Math.sin(a) * d * .8, 2, 2, pal[0]); } },
      pinheiro: (cx, by, s = 1, seed = 0) => { P.sombra(cx + 4, by, 9 * s, 3, .26); R(cx - 1, by - 6 * s, 3, 6 * s, '#5a3820');
        for (let k = 0; k < 4; k++) { const w = (12 - k * 2.6) * s, y = by - 5 * s - k * 6 * s; for (let q = 0; q < 7 * s; q++) { const ww = w * (q / (7 * s)); R(cx - ww, y - 7 * s + q, ww * 2 + 1, 1, q === Math.floor(7 * s) - 1 ? '#1c3c1a' : q < 2 ? '#3a7f2e' : '#2a6228'); } R(cx - w * .5, y - 3 * s, 2, 1, '#55a23a'); } },
      eucalipto: (cx, by, s = 1, seed = 0) => { P.sombra(cx + 4, by, 8 * s, 3, .24); R(cx - 1, by - 22 * s, 3, 22 * s, '#d8cfc0'); R(cx, by - 22 * s, 1, 22 * s, '#f2ece2'); R(cx - 1, by - 10 * s, 3, 2, '#a89a88');
        for (const [dx, dy, rr] of [[0, -28, 6], [-5, -22, 5], [5, -21, 5], [0, -17, 4]]) { circ(cx + dx * s, by + dy * s, rr * s + 1, '#3a5a3a'); circ(cx + dx * s, by + dy * s, rr * s, '#5a8a5a'); circ(cx + dx * s - 1, by + dy * s - 1, rr * s * .5, '#8ab48a'); } },
      cacaueiro: (cx, by, s = 1, seed = 0) => { P.arvore(cx, by, .8 * s, 'escura', seed); for (let k = 0; k < 3; k++) { const x = cx - 5 + k * 4 + Math.round(hash(seed, k) * 2), y = by - 6 - (k % 2) * 3; R(x, y, 3, 4, ['#f2a03a', '#e8c24c', '#c8542a'][(k + seed) % 3]); R(x, y, 1, 4, '#ffffff44'); } },
      mamoeiro: (cx, by, s = 1) => { P.sombra(cx + 3, by, 6, 2); R(cx - 1, by - 20, 2, 20, '#9a8a6a'); for (let a = 0; a < 6; a++) { const an = a / 6 * Math.PI * 2; for (let k = 0; k < 8; k++) R(cx + Math.cos(an) * k, by - 21 + Math.sin(an) * k * .5 + k * k * .05, 2, 2, k > 5 ? '#3a7f2e' : '#58a83c'); } R(cx - 3, by - 18, 3, 4, '#f2a03a'); R(cx + 1, by - 17, 3, 4, '#e8c24c'); R(cx - 1, by - 15, 3, 4, '#58a83c'); },
      coqueiro: (cx, by) => { P.sombra(cx + 4, by, 9, 3); for (let k = 0; k < 22; k++) R(cx + Math.sin(k * .12) * 3, by - k, 3, 1, k % 3 ? '#9a7040' : '#7a5228'); const tx = cx + Math.sin(22 * .12) * 3 + 1, ty = by - 22;
        for (let a = 0; a < 6; a++) { const an = a / 6 * Math.PI * 2 + .3; for (let k = 0; k < 9; k++) R(tx + Math.cos(an) * k, ty + Math.sin(an) * k * .55 + k * k * .04, 2, 2, k > 6 ? '#3f8a30' : '#58a83c'); } R(tx - 2, ty, 4, 3, '#7a5228'); },
      arbusto: (cx, by, seed = 0, flor) => { P.sombra(cx + 1, by, 7, 2); circ(cx, by - 4, 6, '#2f5e26', 4); circ(cx, by - 4, 5, '#3f8a30', 3); circ(cx - 1, by - 5, 3, '#58a83c', 2); if (flor) for (let k = 0; k < 4; k++) R(cx - 4 + hash(seed + k) * 8, by - 7 + hash(seed * 2 + k) * 4, 2, 2, flor); },
      pedra: (cx, by) => { P.sombra(cx + 1, by, 6, 2); circ(cx, by - 3, 5, '#5a6066', 3); circ(cx, by - 3, 4, '#8a9096', 2); R(cx - 2, by - 5, 3, 1, '#c8ccd0'); },
      flores: (x, y, cores) => { for (let k = 0; k < 6; k++) { const px = x + hash(x + k, y) * 12, py = y + hash(y + k, x) * 8; R(px, py + 1, 1, 2, '#3f8a30'); R(px - 1, py, 3, 1, cores[k % cores.length]); R(px, py - 1, 1, 1, cores[k % cores.length]); } },
      cercaH: (x, y, w) => { for (let k = 0; k <= w; k += 8) { R(x + k, y - 9, 3, 10, '#7a4426'); R(x + k, y - 9, 3, 1, '#c8844a'); } R(x, y - 7, w + 3, 2, '#a8643a'); R(x, y - 3, w + 3, 2, '#a8643a'); R(x, y - 7, w + 3, 1, '#c8844a'); R(x, y, w + 3, 1, 'rgba(0,0,0,.2)'); },
      cercaV: (x, y, h) => { for (let k = 0; k <= h; k += 8) { R(x, y + k - 9, 3, 10, '#7a4426'); R(x, y + k - 9, 3, 1, '#c8844a'); } R(x + 1, y - 7, 1, h + 4, '#a8643a'); },
      banco: (x, y) => { R(x, y - 6, 14, 3, '#a8643a'); R(x, y - 6, 14, 1, '#c8844a'); R(x, y - 9, 14, 2, '#8a5030'); R(x + 1, y - 3, 2, 3, '#5a3820'); R(x + 11, y - 3, 2, 3, '#5a3820'); R(x, y, 14, 1, 'rgba(0,0,0,.2)'); },
      poste: (x, y) => { R(x + 1, y - 18, 2, 18, '#3a3f44'); R(x - 1, y - 20, 6, 3, '#3a3f44'); R(x, y - 19, 4, 2, '#fff2b0'); R(x - 1, y, 6, 1, 'rgba(0,0,0,.25)'); },
      placa: (x, y, cor = '#a8643a') => { R(x + 6, y - 6, 2, 6, '#5a3820'); R(x, y - 13, 14, 8, cor); R(x, y - 13, 14, 1, '#d8a070'); R(x + 2, y - 11, 10, 1, '#f2e2b8'); R(x + 2, y - 8, 7, 1, '#f2e2b8'); },
      // casa vista de cima inclinada: telhado de telha, fachada com madeira, porta e janelas com floreira
      casa: (x, y, w, h, o = {}) => { const tel = o.telhado || '#d0683a', par = o.parede || '#f2e6d4', pH = o.paredeH || 14, rH = h - pH;
        P.sombra(x + w / 2 + 6, y + h, w / 2 + 4, 4, .25); c.globalAlpha = .18; R(x + w, y + 6, 5, h - 6, '#0c1a10'); c.globalAlpha = 1;
        R(x, y + rH, w, pH, par); for (let k = 0; k < pH; k += 3) R(x, y + rH + k, w, 1, shade(par, .97)); R(x, y + h - 2, w, 2, shade(par, .7)); R(x, y + rH, 2, pH, shade(par, .85)); R(x + w - 2, y + rH, 2, pH, shade(par, .8));
        if (o.madeira !== false) { R(x, y + rH, w, 2, '#7a4a2a'); for (const px of [x, x + w - 3, x + Math.round(w / 2) - 1]) R(px, y + rH, 3, pH - 2, '#7a4a2a'); }
        const dx = o.porta ?? Math.round(w / 2) - 4; R(x + dx, y + h - 11, 8, 9, '#5a3220'); R(x + dx + 1, y + h - 10, 6, 8, '#8a5030'); R(x + dx + 5, y + h - 6, 1, 1, '#f2c94c'); R(x + dx - 1, y + h - 12, 10, 1, '#7a4a2a');
        for (const jx of o.janelas || [6, w - 12]) { if (Math.abs(jx - dx) < 9) continue; R(x + jx - 1, y + rH + 3, 8, 7, '#7a4a2a'); R(x + jx, y + rH + 4, 6, 5, '#3a5a8a'); R(x + jx, y + rH + 4, 2, 2, '#9ac8f0'); R(x + jx - 1, y + rH + 10, 8, 2, '#3f8a30'); R(x + jx, y + rH + 9, 1, 1, '#e86a8a'); R(x + jx + 4, y + rH + 9, 1, 1, '#f2c94c'); }
        R(x - 2, y, w + 4, rH + 2, shade(tel, .55)); R(x - 1, y, w + 2, rH, tel); for (let k = 2; k < rH; k += 3) { R(x - 1, y + k, w + 2, 1, shade(tel, .8)); for (let j = (k % 2) * 3; j < w; j += 6) R(x + j, y + k - 2, 1, 2, shade(tel, .85)); }
        R(x - 1, y, w + 2, 2, shade(tel, 1.2)); R(x - 1, y + rH - 1, w + 2, 2, shade(tel, .6)); R(x - 2, y, 2, rH + 2, shade(tel, .5)); R(x + w, y, 2, rH + 2, shade(tel, .5));
        if (o.chamine) { R(x + w - 9, y - 6, 6, 9, '#8a8e94'); R(x + w - 9, y - 6, 6, 2, '#5a5e64'); } },
      // prédio grande de laje: topo cinza com caixa-d'água e fachada alta com janelas
      predio: (x, y, w, h, o = {}) => { const par = o.parede || '#e8e4dc', topo = o.topo || '#9aa0a6', fH = o.fachada || 22, tH = h - fH;
        P.sombra(x + w / 2 + 7, y + h, w / 2 + 5, 5, .25); c.globalAlpha = .18; R(x + w, y + 4, 6, h - 4, '#0c1a10'); c.globalAlpha = 1;
        R(x, y, w, tH, topo); R(x, y, w, 2, shade(topo, 1.2)); R(x, y + tH - 2, w, 2, shade(topo, .75)); R(x + 2, y + 2, w - 4, tH - 5, shade(topo, 1.05)); for (let k = 0; k < (w * tH) / 40; k++) R(x + 3 + hash(x + k, y) * (w - 6), y + 3 + hash(y + k, x) * (tH - 6), 1, 1, shade(topo, .9));
        if (o.caixa !== false && w > 20) { R(x + w - 14, y + 3, 9, 7, '#3c6aa8'); R(x + w - 14, y + 3, 9, 2, '#6a9ad0'); R(x + 5, y + 4, 7, 4, '#d8dcdc'); R(x + 5, y + 4, 7, 1, '#f2f4f4'); }
        R(x, y + tH, w, fH, par); R(x, y + tH, 2, fH, shade(par, .85)); R(x + w - 2, y + tH, 2, fH, shade(par, .78)); R(x, y + h - 2, w, 2, shade(par, .65));
        if (o.faixa) R(x, y + tH, w, 3, o.faixa);
        for (let ry = y + tH + 5; ry < y + h - 8; ry += 7) for (let jx = x + 4; jx < x + w - 6; jx += 7) { R(jx, ry, 4, 4, '#3a5a8a'); R(jx, ry, 1, 1, '#9ac8f0'); }
        if (o.porta !== false) { const dx = x + Math.round(w / 2) - 5; R(dx, y + h - 10, 10, 8, '#2a3a4a'); R(dx + 1, y + h - 9, 4, 7, '#7ab0d0'); R(dx + 5, y + h - 9, 4, 7, '#7ab0d0'); } },
      fonte: (cx, cy) => { P.sombra(cx + 2, cy + 6, 16, 5); circ(cx, cy + 2, 15, '#7a8086', 7); circ(cx, cy, 14, '#a8aeb4', 6); circ(cx, cy, 11, COR.agua, 4); circ(cx - 2, cy - 1, 6, COR.aguaC, 2); R(cx - 2, cy - 10, 5, 10, '#a8aeb4'); R(cx - 4, cy - 12, 9, 3, '#c8ccd0'); }
    };
    return P;
  }

  /* =====================================================================
     TERRENO ORGÂNICO
     O mapa guarda o relevo e o tipo do chão numa grade fina (4 px). Na hora de pintar, cada pixel consulta a grade
     num ponto levemente deslocado por um ruído suave: assim rios, barrancos, gramados e ruas ganham bordas curvas,
     sem cara de quadradinho. Paredões de terra aparecem onde o terreno desce para o sul (vista de cima pra frente).
     ===================================================================== */
  const TIPOS = ['grama', 'mata', 'pedra', 'chao', 'asfalto', 'areia', 'plantacao', 'cafe', 'campo', 'quadra', 'pista', 'nuvem', 'trigo', 'calcada', 'cerrado'];
  const TI = Object.fromEntries(TIPOS.map((t, i) => [t, i]));
  const VERDE = new Set([TI.grama, TI.mata, TI.cerrado]), CAMINHO = new Set([TI.pedra, TI.chao, TI.asfalto, TI.areia, TI.quadra, TI.pista, TI.calcada]);
  const h2 = (x, y, s = 0) => { let h = Math.imul(x | 0, 374761393) + Math.imul(y | 0, 668265263) + Math.imul(s, 2246822519); h = Math.imul(h ^ (h >>> 13), 1274126177); return ((h ^ (h >>> 16)) >>> 0) / 4294967296; };
  const vn = (x, y, s = 0) => { const xi = Math.floor(x), yi = Math.floor(y), xf = x - xi, yf = y - yi, u = xf * xf * (3 - 2 * xf), v = yf * yf * (3 - 2 * yf), a = h2(xi, yi, s), b = h2(xi + 1, yi, s), c = h2(xi, yi + 1, s), d = h2(xi + 1, yi + 1, s); return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v; };
  // curva suave (Catmull-Rom) passando pelos pontos, em pixels; volta pontos a cada ~passo px
  function curva(pts, passo = 3) {
    const out = [], G = (i) => pts[Math.max(0, Math.min(pts.length - 1, i))];
    for (let i = 0; i < pts.length - 1; i++) { const p0 = G(i - 1), p1 = G(i), p2 = G(i + 1), p3 = G(i + 2), n = Math.max(1, Math.ceil(Math.hypot(p2[0] - p1[0], p2[1] - p1[1]) / passo));
      for (let k = 0; k < n; k++) { const t = k / n, t2 = t * t, t3 = t2 * t, f = (a, b, c, d) => .5 * (2 * b + (-a + c) * t + (2 * a - 5 * b + 4 * c - d) * t2 + (-a + 3 * b - 3 * c + d) * t3); out.push([f(p0[0], p1[0], p2[0], p3[0]), f(p0[1], p1[1], p2[1], p3[1])]); } }
    out.push([...pts[pts.length - 1]]); return out;
  }
  // percorre uma curva (lista de pontos) pela distância: u de 0 a 1 → {x, y, ang}
  function trilho(pl) { const ac = [0]; for (let k = 1; k < pl.length; k++) ac.push(ac[k - 1] + Math.hypot(pl[k][0] - pl[k - 1][0], pl[k][1] - pl[k - 1][1])); const total = ac[ac.length - 1] || 1;
    return { total, em: (u) => { const d = ((u % 1) + 1) % 1 * total; let lo = 0, hi = ac.length - 1; while (hi - lo > 1) { const m = (lo + hi) >> 1; if (ac[m] <= d) lo = m; else hi = m; } const a = pl[lo], b = pl[hi], k = (d - ac[lo]) / ((ac[hi] - ac[lo]) || 1); return { x: a[0] + (b[0] - a[0]) * k, y: a[1] + (b[1] - a[1]) * k, ang: Math.atan2(b[1] - a[1], b[0] - a[0]) }; } }; }

  function Terreno(W, H) {
    const F = 4, FW = W * F, FH = H * F, nivel = new Int8Array(FW * FH).fill(1), tipo = new Uint8Array(FW * FH), ok = (x, y) => x >= 0 && y >= 0 && x < FW && y < FH;
    const pinta = (fx, fy, o) => { if (!ok(fx, fy)) return; const i = fy * FW + fx; if (o.nivel !== undefined) nivel[i] = o.nivel; if (o.tipo) tipo[i] = TI[o.tipo] ?? 0; };
    const ruas = [], eixo = new Map();
    const T = {
      W, H, ruas,
      nivPx: (px, py) => { const fx = Math.floor(px / 4), fy = Math.floor(py / 4); return ok(fx, fy) ? nivel[fy * FW + fx] : nivel[Math.max(0, Math.min(FH - 1, fy)) * FW + Math.max(0, Math.min(FW - 1, fx))]; },
      tipPx: (px, py) => { const fx = Math.max(0, Math.min(FW - 1, Math.floor(px / 4))), fy = Math.max(0, Math.min(FH - 1, Math.floor(py / 4))); return tipo[fy * FW + fx]; },
      niv: (x, y) => T.nivPx(x * TS + 8, y * TS + 8), tip: (x, y) => TIPOS[T.tipPx(x * TS + 8, y * TS + 8)],
      // formas (em lajotas; aceita frações)
      ret: (x, y, w, h, o) => { for (let fy = Math.round(y * F); fy < Math.round((y + h) * F); fy++) for (let fx = Math.round(x * F); fx < Math.round((x + w) * F); fx++) pinta(fx, fy, o); },
      retR: (x, y, w, h, r, o) => { for (let fy = Math.round(y * F); fy < Math.round((y + h) * F); fy++) for (let fx = Math.round(x * F); fx < Math.round((x + w) * F); fx++) { const cx = (fx + .5) / F, cy = (fy + .5) / F, dx = Math.max(x + r - cx, 0, cx - (x + w - r)), dy = Math.max(y + r - cy, 0, cy - (y + h - r)); if (dx * dx + dy * dy <= r * r) pinta(fx, fy, o); } },
      oval: (cx, cy, rx, ry, o) => { for (let fy = Math.floor((cy - ry) * F); fy <= (cy + ry) * F; fy++) for (let fx = Math.floor((cx - rx) * F); fx <= (cx + rx) * F; fx++) { const x = (fx + .5) / F, y = (fy + .5) / F; if (((x - cx) / rx) ** 2 + ((y - cy) / ry) ** 2 <= 1) pinta(fx, fy, o); } },
      poli: (pts, o) => { const sm = curva(pts.concat([pts[0]]).map(([a, b]) => [a * F, b * F]), 2); let x0 = 1e9, y0 = 1e9, x1 = -1e9, y1 = -1e9; for (const [a, b] of sm) { x0 = Math.min(x0, a); y0 = Math.min(y0, b); x1 = Math.max(x1, a); y1 = Math.max(y1, b); }
        for (let fy = Math.floor(y0); fy <= y1; fy++) for (let fx = Math.floor(x0); fx <= x1; fx++) { const px = fx + .5, py = fy + .5; let dentro = false; for (let i = 0, j = sm.length - 1; i < sm.length; j = i++) { const [xi, yi] = sm[i], [xj, yj] = sm[j]; if ((yi > py) !== (yj > py) && px < (xj - xi) * (py - yi) / (yj - yi) + xi) dentro = !dentro; } if (dentro) pinta(fx, fy, o); } },
      // faixa ao longo de uma curva suave (rio, rua, trilha). Devolve a curva em pixels.
      curva: (pts, larg, o, suave = true) => { const pl = suave ? curva(pts.map(([a, b]) => [a * TS, b * TS]), 2) : pts.map(([a, b]) => [a * TS, b * TS]); const r = larg * TS / 2;
        for (const [px, py] of pl) for (let fy = Math.floor((py - r) / 4); fy <= (py + r) / 4; fy++) for (let fx = Math.floor((px - r) / 4); fx <= (px + r) / 4; fx++) { const dx = fx * 4 + 2 - px, dy = fy * 4 + 2 - py; if (dx * dx + dy * dy <= r * r) pinta(fx, fy, o); }
        if (o.tipo && ['asfalto', 'pedra', 'chao', 'calcada'].includes(o.tipo)) { // cruzamentos arredondados: onde uma rua encontra outra, abre uma pracinha redonda
          const id = ruas.length + 1, juntas = [], chave = (x, y) => ((x / 8) | 0) + ',' + ((y / 8) | 0);
          for (let k = 0; k < pl.length; k += 2) { const [px, py] = pl[k]; let achou = false; for (let dy = -1; dy <= 1 && !achou; dy++) for (let dx = -1; dx <= 1 && !achou; dx++) { const e = eixo.get(chave(px + dx * 8, py + dy * 8)); if (e && e.id !== id && e.tipo === o.tipo) achou = true; } if (achou && !juntas.some(([a, b]) => Math.hypot(a - px, b - py) < 40)) juntas.push([px, py]); }
          for (const [px, py] of pl) { const k = chave(px, py); if (!eixo.has(k)) eixo.set(k, { id, tipo: o.tipo }); }
          for (const [px, py] of juntas) { const rr = r * 1.75; for (let fy = Math.floor((py - rr) / 4); fy <= (py + rr) / 4; fy++) for (let fx = Math.floor((px - rr) / 4); fx <= (px + rr) / 4; fx++) { const dx = fx * 4 + 2 - px, dy = fy * 4 + 2 - py; if (dx * dx + dy * dy <= rr * rr && nivel[fy * FW + fx] !== 0) pinta(fx, fy, { tipo: o.tipo }); } }
          ruas.push({ tipo: o.tipo, larg, pl, juntas }); }
        return pl; },
      linha: (pts, larg, o) => T.curva(pts, larg, o, false),
      livre: () => true
    };
    return T;
  }

  // cores em [r,g,b]
  const RGB = (hex) => { const n = parseInt(hex.slice(1), 16); return [(n >> 16) & 255, (n >> 8) & 255, n & 255]; };
  const PAL = {}; const pal = (hex) => PAL[hex] || (PAL[hex] = RGB(hex));
  function pintarTerreno(Tr, extra) {
    const W = Tr.W * TS, H = Tr.H * TS, N = W * H, cv = document.createElement('canvas'); cv.width = W; cv.height = H; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false;
    const lv = new Int8Array(N), ty = new Uint8Array(N);
    // 1) relevo e tipo, com as bordas deformadas pelo ruído
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
      const n1 = vn(x / 28, y / 28, 1) - .5, n2 = vn(x / 28, y / 28, 2) - .5, m1 = vn(x / 9, y / 9, 3) - .5, m2 = vn(x / 9, y / 9, 4) - .5, ax = n1 * 12 + m1 * 3, ay = n2 * 12 + m2 * 3, i = y * W + x;
      lv[i] = Tr.nivPx(x + ax, y + ay); ty[i] = Tr.tipPx(x + ax * .3, y + ay * .3);
    }
    // 2) paredões: descendo cada coluna, onde o nível de cima é maior começa a parede de terra (22 px por degrau)
    const wd = new Int16Array(N).fill(-1), wh = new Int16Array(N), wt = new Uint8Array(N), sh = new Uint8Array(N), WH = 22;
    for (let x = 0; x < W; x++) { let eY = -1e5, h = 0, eL = -1, eT = 0;
      for (let y = 0; y < H; y++) { const i = y * W + x, L = lv[i];
        if (y > 0) { const U = lv[i - W]; if (U > L && wd[i - W] < 0) { const hh = L === 0 ? (U - 1) * WH + 7 : (U - L) * WH; if (y - eY < h) { h = Math.max(h, y - eY + hh); eL = Math.max(eL, U); } else { eY = y; h = hh; eL = U; eT = ty[i - W]; } } }
        if (L >= eL) eY = -1e5; const d = y - eY;
        if (d >= 0 && d < h) { wd[i] = d; wh[i] = h; wt[i] = eT; } else if (d >= h && d < h + 6) sh[i] = 6 - (d - h);
      } }
    for (let y = 0; y < H; y++) { let x = 0; while (x < W) { if (wd[y * W + x] < 0) { x++; continue; } let e = x; while (e < W && wd[y * W + e] >= 0) e++; if (e - x < 5) for (let k = x; k < e; k++) { wd[y * W + k] = -1; sh[y * W + k] = 0; } x = e; } } // lascas finas (beiradas quase verticais) viram só contorno
    const img = c.createImageData(W, H), px = img.data;
    const put = (i, col, f = 1) => { const o = i * 4; px[o] = Math.min(255, col[0] * f); px[o + 1] = Math.min(255, col[1] * f); px[o + 2] = Math.min(255, col[2] * f); px[o + 3] = 255; };
    const G3 = [pal('#9ad450'), pal('#a6dc58'), pal('#b0e262')], M3 = [pal('#7cbc3c'), pal('#86c442'), pal('#8ecc48')], CE3 = [pal('#9aa04a'), pal('#a8a854'), pal('#8a9a44')];
    const AG = { fundo: pal('#3a7ad0'), meio: pal('#4a92e2'), raso: pal('#6ab4f0'), espuma: pal('#e2f4ff'), onda: pal('#7cc2f6') };
    const terraCores = [pal('#c87a4a'), pal('#b86c40'), pal('#d88a56')], terraB = pal('#7a4228'), terraE = pal('#a85e38'), terraC = pal('#e8a06a'), pedrinha = pal('#8a7a6a'), pedrinhaC = pal('#b8a898');
    const agua = (x, y) => lv[Math.max(0, Math.min(H - 1, y)) * W + Math.max(0, Math.min(W - 1, x))] === 0;
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
      const i = y * W + x, L = lv[i], t = ty[i];
      if (wd[i] >= 0) { // ----- paredão de terra -----
        const d = wd[i], h = wh[i], top = wt[i], lip = 2 + Math.floor(h2(x >> 1, 7) * 3);
        if (L === 0 && h <= 8) { put(i, d < h - 2 ? (d < 2 ? terraB : terraE) : d === h - 1 ? AG.espuma : AG.raso); continue; }
        if (d < lip && (VERDE.has(top) || top === TI.campo)) { put(i, d === lip - 1 ? pal('#2f5e26') : d === 0 ? pal('#4f9a34') : pal('#3c7a2c')); continue; }
        if (d < 2 && CAMINHO.has(top)) { put(i, pal('#7a8086')); continue; }
        if (d >= h - 2) { put(i, terraB); continue; }
        const s = d + vn(x / 10, 5, 9) * 5, banda = Math.floor(s / 5), fr = s - banda * 5; let col = terraCores[banda % 3], f = 1 - (d / h) * .16;
        if (fr < 1 && h2(x >> 2, banda, 3) > .45) col = terraC; else if (fr > 4.2) col = terraE;
        if (h2(x, 99) < .035 && d > 4 && d < h - 4) col = terraB;
        const sx = x >> 2, sy = Math.floor((d + (x & 3)) / 3); if (h2(sx, sy + y * 0, 13) > .93) col = (d % 3 === 0) ? pedrinhaC : pedrinha;
        if (wd[i - 1] < 0 || wd[i + 1] < 0) f *= .72; put(i, col, f); continue;
      }
      let f = sh[i] ? 1 - sh[i] * .045 : 1;
      if (L === 0) { // ----- água -----
        let col = AG.meio; const prof = vn(x / 40, y / 40, 6);
        if (prof > .62) col = AG.fundo;
        if (agua(x - 2, y) + agua(x + 2, y) + agua(x, y - 2) + agua(x, y + 2) < 4) col = AG.espuma;
        else if (agua(x - 5, y) + agua(x + 5, y) + agua(x, y - 5) + agua(x, y + 5) + agua(x - 4, y - 4) + agua(x + 4, y + 4) < 6) col = AG.raso;
        else if (h2(x >> 3, y >> 1, 21) > .955 && (y & 1) === 0) col = AG.onda;
        put(i, col, f); continue;
      }
      const tint = 1 + (L - 1) * .035; f *= tint;
      let col;
      switch (t) {
        case TI.grama: case TI.mata: case TI.cerrado: { const P3 = t === TI.mata ? M3 : t === TI.cerrado ? CE3 : G3, m = vn(x / 36, y / 36, 7); col = P3[m < .38 ? 0 : m > .64 ? 2 : 1]; const q = h2(x >> 1, y >> 1, 8); if (q > .93) col = t === TI.cerrado ? pal('#c8c070') : pal('#c8f07a'); else if (q < .05) col = t === TI.cerrado ? pal('#7a7a3a') : pal('#7cb83c'); break; }
        case TI.pedra: { const r = Math.floor(y / 5), off = (r & 1) * 3, cl = Math.floor((x + off) / 6), lx = (x + off) % 6, ly = y % 5, hv = h2(cl, r, 11); if (lx === 5 || ly === 4) col = pal('#8a9096'); else if (ly === 0 || lx === 0) col = pal(hv > .5 ? '#e2e5e8' : '#d4d8dc'); else if (ly === 3) col = pal('#a8aeb4'); else col = pal(hv > .66 ? '#c4c8cc' : hv > .33 ? '#bcc0c4' : '#b4b9be'); break; }
        case TI.calcada: { const lx = x % 8, ly = y % 8; col = pal(lx === 7 || ly === 7 ? '#b8b0a0' : (Math.floor(x / 8) + Math.floor(y / 8)) % 2 ? '#e6dfd0' : '#ddd5c4'); break; }
        case TI.chao: { col = pal('#d8a06e'); const q = h2(x, y, 12); if (q > .9) col = pal('#c08a5a'); else if (q < .04) col = pal('#e8b888'); if (h2(x >> 2, y >> 2, 14) > .96) col = pal('#a8805a'); break; }
        case TI.asfalto: { col = pal('#5b6066'); const q = h2(x, y, 15); if (q > .88) col = pal('#4c5156'); else if (q < .05) col = pal('#6a7076'); break; }
        case TI.areia: { col = pal(vn(x / 6, y / 3, 16) > .7 ? '#d8c07a' : '#ead69a'); if (h2(x, y, 17) > .94) col = pal('#f6eac0'); break; }
        case TI.plantacao: { const r = (y + Math.sin(x / 23) * 3) / 5, fr = r - Math.floor(r); col = pal(fr < .35 ? '#6a4228' : fr < .45 ? '#8a5a36' : (x + Math.floor(r) * 2) % 3 ? '#a6dc58' : '#ccf27e'); break; }
        case TI.trigo: { const r = (y + Math.sin(x / 17) * 2), q = h2(x, Math.floor(r / 3), 18); col = pal((x & 1) ? (q > .5 ? '#e8c25a' : '#d8ae48') : (r % 3 < 1 ? '#f4dc80' : '#c89a3a')); break; }
        case TI.cafe: { const r = (y + Math.sin(x / 37) * 4) / 9, fr = r - Math.floor(r); if (fr < .62) { const b = h2(Math.floor(x / 3), Math.floor(r), 19); col = pal(fr < .12 ? '#2f5e26' : b > .85 && fr > .3 ? '#c43c3a' : (x + Math.floor(fr * 9)) % 4 === 0 ? '#58a83c' : '#3f8a30'); } else col = pal(fr < .7 ? '#6a4228' : '#8a5a36'); break; }
        case TI.campo: col = pal(Math.floor(x / 12) % 2 ? '#5aa046' : '#66ae50'); break;
        case TI.quadra: col = pal('#3c7ab0'); break;
        case TI.pista: col = pal(h2(x, y, 20) > .9 ? '#4c5156' : '#565b61'); break;
        case TI.nuvem: { const m = vn(x / 18, y / 10 + 0, 21); col = pal(m > .6 ? '#ffffff' : m > .4 ? '#eef4f8' : '#dde8f0'); break; }
        default: col = G3[1];
      }
      // bordas: onde o chão muda de tipo, a grama faz uma bordinha e joga sombra no caminho
      const tu = ty[i - W] ?? t, tb = ty[i + W] ?? t, tl = ty[i - 1] ?? t, tr = ty[i + 1] ?? t;
      if (CAMINHO.has(t)) { if (y > 0 && VERDE.has(tu) && lv[i - W] === L) f *= .74; else if (y > 1 && VERDE.has(ty[i - 2 * W]) && lv[i - 2 * W] === L) f *= .88; else if (VERDE.has(tl) || VERDE.has(tr) || VERDE.has(tb)) f *= .84;
        if (t === TI.asfalto && (tu === TI.pedra || tu === TI.calcada || tb === TI.pedra || tb === TI.calcada || tl === TI.pedra || tr === TI.pedra)) { col = pal('#d8dcdf'); } }
      else if (VERDE.has(t) && CAMINHO.has(tb) && lv[i + W] === L) col = pal('#6aa232');
      // beira do platô: risquinho escuro dos lados, e a borda de cima mais clara
      if (x > 0 && lv[i - 1] < L && wd[i - 1] < 0) { col = pal('#4f8a28'); f = 1; } else if (x < W - 1 && lv[i + 1] < L && wd[i + 1] < 0) { col = pal('#4f8a28'); f = 1; }
      else if (y > 0 && lv[i - W] < L && wd[i - W] < 0) col = pal('#d2f48a');
      put(i, col, f);
    }
    c.putImageData(img, 0, 0);
    // 3) enfeites pequenos: tufos, flores, juncos na beira d'água, vitórias-régias, cipós no paredão
    const P = Px(c), R = P.R, livre = (x, y) => { x = Math.round(x); y = Math.round(y); if (x < 2 || y < 30 || x >= W - 2 || y >= H - 2) return false; const i = y * W + x; return VERDE.has(ty[i]) && wd[i] < 0 && !sh[i] && lv[i] > 0 && lv[i - 26 * W] === lv[i] && wd[i - 26 * W] < 0 && lv[i + 3 * W] === lv[i] && ty[i - 1] === ty[i] && ty[i + 1] === ty[i]; };
    for (let k = 0; k < N / 120; k++) { const x = Math.floor(h2(k, 1, 31) * W), y = Math.floor(h2(k, 2, 31) * H), i = y * W + x; if (y < 4 || y > H - 2 || !VERDE.has(ty[i]) || wd[i] >= 0 || lv[i] === 0) continue; const q = h2(k, 3, 31), esc = ty[i] === TI.cerrado ? '#7a7a3a' : '#3c7a2c', cla = ty[i] === TI.cerrado ? '#d8d080' : '#8ad45a';
      if (q < .7) { R(x, y - 2, 1, 3, esc); R(x + 1, y - 3, 1, 4, esc); R(x + 2, y - 2, 1, 3, esc); R(x + 1, y - 3, 1, 1, cla); }
      else if (q < .86) { const cor = ['#ffffff', '#f2c94c', '#e86a8a', '#b86ad8', '#f6a04a'][Math.floor(h2(k, 4, 31) * 5)]; for (let j = 0; j < 4; j++) { const fx = x + h2(k, j, 33) * 9, fy = y + h2(j, k, 33) * 5; R(fx, fy + 1, 1, 2, '#3f8a30'); R(fx - 1, fy, 3, 1, cor); R(fx, fy - 1, 1, 1, cor); R(fx, fy, 1, 1, '#fff6c0'); } }
      else if (q < .9) { R(x, y - 2, 4, 3, '#7a8086'); R(x, y - 2, 3, 1, '#b8bcc0'); }
      else { R(x, y - 1, 3, 2, '#2f5e26'); R(x + 1, y - 2, 1, 1, '#58a83c'); } }
    for (let k = 0; k < N / 260; k++) { const x = Math.floor(h2(k, 5, 35) * W), y = Math.floor(h2(k, 6, 35) * H), i = y * W + x; if (y < 8 || lv[i] !== 0 || wd[i] >= 0) continue;
      const beira = !agua(x - 3, y) || !agua(x + 3, y) || !agua(x, y + 3) || !agua(x, y - 3), longe = agua(x - 9, y) && agua(x + 9, y) && agua(x, y - 7) && agua(x, y + 7);
      if (beira && h2(k, 7, 35) > .45) { for (let j = 0; j < 4; j++) { const hh = 4 + Math.floor(h2(k, j, 37) * 4); R(x + j * 2 - 3, y - hh, 1, hh, j % 2 ? '#3f8a30' : '#58a83c'); if (j === 1) R(x + j * 2 - 3, y - hh - 2, 1, 3, '#7a4a2a'); } }
      else if (longe && h2(k, 8, 35) > .82) { P.circ(x, y, 4, '#2f7a3a', 2); P.circ(x, y, 3, '#4aa04a', 2); R(x, y - 2, 1, 2, '#3a7ad0'); if (h2(k, 9, 35) > .7) { R(x - 1, y - 1, 3, 2, '#f6c0d8'); R(x, y - 2, 1, 1, '#ffffff'); } } }
    for (let k = 0; k < W / 3; k++) { const x = Math.floor(h2(k, 10, 39) * W); for (let y = 1; y < H; y++) { const i = y * W + x; if (wd[i] === 0 && wh[i] > 12 && VERDE.has(wt[i]) && wd[i - 3] >= 0 && wd[i + 3] >= 0 && h2(k, y, 41) > .55) { const n = 4 + Math.floor(h2(k, 11, 39) * (wh[i] - 8)); for (let j = 0; j < n; j++) { R(x + Math.round(Math.sin(j * .7 + k) * .6), y + 2 + j, 1, 1, j % 3 ? '#3f8a30' : '#58a83c'); if (j % 3 === 1) R(x + 1, y + 2 + j, 2, 1, '#4f9a34'); } break; } } }
    Tr.px = { W, H, lv, ty, wd, sh };
    Tr.livre = livre; Tr.tipoEm = (x, y) => TIPOS[ty[Math.max(0, Math.min(N - 1, Math.round(y) * W + Math.round(x)))]]; Tr.nivelEm = (x, y) => lv[Math.max(0, Math.min(N - 1, Math.round(y) * W + Math.round(x)))];
    Tr.aguaPontos = []; for (let k = 0; k < N / 300; k++) { const x = Math.floor(h2(k, 12, 43) * W), y = Math.floor(h2(k, 13, 43) * H); if (agua(x, y) && agua(x - 6, y) && agua(x + 6, y) && agua(x, y - 4) && agua(x, y + 4) && wd[y * W + x] < 0) Tr.aguaPontos.push([x, y]); }
    extra?.(P, c, Tr);
    return cv;
  }

  /* =====================================================================
     INTERFACE (HTML por cima do canvas)
     ===================================================================== */
  let ui = null, cv = null, c = null, def = null, aberto = false, raf = 0, last = 0, tempo = 0, M = null;
  let cam = { x: 0, y: 0, z: 2 }, anim = null, sel = -1, info = false, viagem = null, drag = null, previaTimer = 0, faiscas = [];
  const cache = new Map();
  function css() {
    if (document.getElementById('mapa3dCss')) return; const st = document.createElement('style'); st.id = 'mapa3dCss';
    st.textContent = `.m3d{position:fixed;inset:0;z-index:2147483200;background:#8ccfe8;font-family:Pixel,monospace;color:#f6ead0;opacity:0;transition:opacity .35s;touch-action:none;user-select:none;-webkit-user-select:none}.m3d.on{opacity:1}.m3d[hidden]{display:none}
.m3d canvas.gl{position:absolute;inset:0;width:100%;height:100%;image-rendering:pixelated;cursor:grab}.m3d canvas.gl.arrasta{cursor:grabbing}
.m3d .topo{position:absolute;left:0;right:0;top:0;display:flex;align-items:center;gap:10px;padding:10px 14px;background:linear-gradient(#2a1a10b0,#2a1a1000);pointer-events:none}.m3d .topo b{font-size:15px;color:#ffd98a;text-shadow:2px 2px #2a1a14}.m3d .topo small{font-size:9px;color:#e8eef2;text-shadow:1px 1px #000}.m3d .topo .bts{pointer-events:auto;margin-left:auto;display:flex;gap:6px}
.m3d button{font:inherit;font-size:11px;padding:8px 12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}.m3d button:hover,.m3d button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.m3d button:active{transform:translateY(3px);box-shadow:0 1px 0 #2a1a10}.m3d button[disabled]{opacity:.45;cursor:default}
.m3d .pv{position:absolute;right:14px;top:56px;bottom:14px;width:min(380px,44vw);background:#2a1e14;border:4px solid #e8c66a;box-shadow:0 0 0 4px #120c08,0 14px 30px #0009;display:flex;flex-direction:column;padding:12px;gap:10px;transform:translateX(120%);transition:transform .45s cubic-bezier(.2,.9,.25,1.15)}.m3d .pv.on{transform:none}
.m3d .pv h3{margin:0;font-size:14px;color:#ffd98a;padding-right:40px}.m3d .pv .sub{font-size:9px;color:#c8b48a;margin-top:-6px}.m3d .pv .ib{position:absolute;right:10px;top:10px;width:34px;height:34px;padding:0;font-size:16px;border-radius:50%}
.m3d .pv .tela{position:relative;flex:1;min-height:120px;background:#000;border:3px solid #120c08;overflow:hidden}.m3d .pv canvas.prev{width:100%;height:100%;object-fit:cover;image-rendering:pixelated;display:block}
.m3d .pv .desc{position:absolute;inset:0;background:#120c08ee;padding:12px;font-size:11px;line-height:1.7;color:#f6ead0;opacity:0;transform:translateY(12px);transition:.3s;pointer-events:none;overflow:auto}.m3d .pv .desc.on{opacity:1;transform:none;pointer-events:auto}.m3d .pv .desc b{color:#ffd98a;display:block;margin-bottom:6px}
.m3d .pv .ir{font-size:14px;padding:12px;background:#e8a83a;color:#1c1408;border-color:#fff2c8}.m3d .pv .ir:hover{background:#ffd98a}.m3d .pv .motivo{font-size:9px;color:#ff9a8a;line-height:1.5}.m3d .pv .x{position:absolute;left:-14px;top:-14px;width:28px;height:28px;padding:0;font-size:12px}
.m3d .dica{position:absolute;left:14px;bottom:14px;font-size:9px;color:#fff;background:#0b0f14aa;padding:6px 8px;pointer-events:none}.m3d .fade{position:absolute;inset:0;background:#000;opacity:0;pointer-events:none;transition:opacity .45s}
.m3d .trava{position:absolute;left:0;top:0;transform:translate(-50%,-100%);min-width:170px;max-width:250px;background:#2a1010;border:3px solid #ff5a4a;box-shadow:0 0 0 3px #120606,0 8px 18px #0008;padding:8px 10px;text-align:center;pointer-events:none;opacity:0;transition:opacity .2s}.m3d .trava.on{opacity:1;animation:m3dTrava .35s cubic-bezier(.2,1.6,.4,1)}
.m3d .trava b{display:block;font-size:11px;color:#ff8a7a;margin-bottom:4px}.m3d .trava .t{font-size:8px;color:#f6ead0;opacity:.85}.m3d .trava .n{font-size:12px;color:#ffd98a;margin:3px 0;line-height:1.5}.m3d .trava small{display:block;font-size:8px;color:#e8c8c0;line-height:1.5;margin-top:4px}.m3d .trava:after{content:'';position:absolute;left:50%;bottom:-11px;margin-left:-8px;border:8px solid transparent;border-top-color:#ff5a4a;border-bottom:0}
@keyframes m3dTrava{from{transform:translate(-50%,-80%) scale(.6)}to{transform:translate(-50%,-100%) scale(1)}}.m3d .topo .teste{background:#3a2a5a;border-color:#b89ae8;font-size:9px}
.m3d .zoom{position:absolute;left:14px;bottom:44px;display:flex;flex-direction:column;gap:6px}.m3d .zoom button{width:38px;height:38px;padding:0;font-size:16px}
@media (max-width:760px),(max-height:520px){.m3d .pv{left:10px;right:10px;top:auto;bottom:10px;width:auto;height:50%}.m3d .pv .tela{min-height:70px}.m3d .dica{display:none}.m3d .zoom{bottom:auto;top:60px}}
/* celular: título compacto, ficha do lugar ao lado (deitado) ou embaixo (em pé) e faixa com todos os lugares */
.m3d .lugares{display:none}
@media (max-width:760px),(max-height:520px){.m3d .topo{padding:6px 8px;gap:6px}.m3d .topo b{font-size:11px}.m3d .topo small{display:none}.m3d .topo .fechar{font-size:9px;padding:6px 8px}.m3d .zoom{top:44px;left:8px}.m3d .zoom button{width:34px;height:34px}
.m3d .lugares{display:flex;position:absolute;left:0;right:0;bottom:0;gap:6px;overflow-x:auto;padding:8px 8px max(8px,env(safe-area-inset-bottom));background:linear-gradient(#0b0f1400,#0b0f14dd 40%);-webkit-overflow-scrolling:touch;scrollbar-width:none}.m3d .lugares::-webkit-scrollbar{display:none}
.m3d .lugares button{flex:none;font-size:9px;padding:6px 8px;box-shadow:0 3px 0 #2a1a10;white-space:nowrap}.m3d .lugares button.bloq{background:#3a2a24;color:#c8b8a8;border-color:#8a6a5a}.m3d .lugares button.atual{background:#2a4a6a;border-color:#8ac8ff}
.m3d.ficha-aberta .lugares{display:none}}
@media (max-height:520px) and (orientation:landscape){.m3d .pv{left:auto;right:8px;top:8px;bottom:8px;width:44%;height:auto}}`;
    document.head.appendChild(st);
  }
  function montarUI() {
    css(); ui = document.createElement('div'); ui.className = 'm3d'; ui.hidden = true; ui.setAttribute('role', 'dialog');
    ui.innerHTML = `<canvas class="gl"></canvas><div class="topo"><div><b class="t"></b><br><small class="s"></small></div><div class="bts"><button type="button" class="teste" hidden></button><button type="button" class="fechar" aria-label="Fechar mapa">✕ FECHAR</button></div></div>
<div class="zoom"><button type="button" class="zmais" aria-label="Aproximar">+</button><button type="button" class="zmenos" aria-label="Afastar">−</button></div>
<div class="pv" aria-live="polite"><button type="button" class="x" aria-label="Voltar ao mapa">✕</button><h3></h3><div class="sub"></div><button type="button" class="ib" aria-label="Sobre o lugar" title="Sobre o lugar">ⓘ</button><div class="tela"><canvas class="prev" width="320" height="180"></canvas><div class="desc"></div></div><div class="motivo"></div><button type="button" class="ir">IR PARA LÁ ▶</button></div>
<div class="trava" aria-live="assertive"><b>🔒 TRANCADO</b><div class="t"></div><div class="n"></div><small></small></div><div class="lugares" aria-label="Lugares do mapa"></div><div class="dica">Arraste para passear · toque num lugar · ← → troca · ENTER vai · ESC fecha</div><div class="fade"></div>`;
    document.body.appendChild(ui); cv = ui.querySelector('canvas.gl'); c = cv.getContext('2d');
    ui.querySelector('.fechar').addEventListener('click', fechar); ui.querySelector('.teste').addEventListener('click', () => def?.teste?.acao?.()); ui.querySelector('.x').addEventListener('click', () => selecionar(-1));
    ui.querySelector('.ib').addEventListener('click', () => mostrarInfo(!info)); ui.querySelector('.ir').addEventListener('click', ir);
    ui.querySelector('.zmais').addEventListener('click', () => zoomPara(cam.z * 1.3)); ui.querySelector('.zmenos').addEventListener('click', () => zoomPara(cam.z / 1.3));
    const dedos = new Map(); let pinca = null; // zoom com dois dedos no celular
    const distDedos = () => { const [a, b] = [...dedos.values()]; return Math.hypot(a.x - b.x, a.y - b.y) || 1; };
    cv.addEventListener('pointerdown', (e) => { dedos.set(e.pointerId, { x: e.clientX, y: e.clientY }); if (dedos.size === 2) { pinca = { d: distDedos(), z: cam.z }; drag = null; anim = null; return; } drag = { x: e.clientX, y: e.clientY, cx: cam.x, cy: cam.y, moveu: false }; cv.setPointerCapture(e.pointerId); });
    const soltaDedo = (e) => { dedos.delete(e.pointerId); if (dedos.size < 2) pinca = null; };
    cv.addEventListener('pointercancel', soltaDedo);
    cv.addEventListener('pointermove', (e) => { if (dedos.has(e.pointerId)) dedos.set(e.pointerId, { x: e.clientX, y: e.clientY }); if (pinca && dedos.size === 2 && !viagem) { cam.z = Math.max(zMin(), Math.min(zMax, pinca.z * distDedos() / pinca.d)); limitar(); return; } if (!drag || viagem) return; const dx = e.clientX - drag.x, dy = e.clientY - drag.y; if (Math.abs(dx) + Math.abs(dy) > 6) { drag.moveu = true; cv.classList.add('arrasta'); } if (!drag.moveu) return; anim = null; cam.x = drag.cx - dx / cam.z; cam.y = drag.cy - dy / cam.z; limitar(); });
    cv.addEventListener('pointerup', (e) => { const eraPinca = !!pinca; soltaDedo(e); cv.classList.remove('arrasta'); if (drag && !drag.moveu && !eraPinca) clique(e); drag = null; });
    cv.addEventListener('wheel', (e) => { e.preventDefault(); zoomPara(cam.z * (e.deltaY > 0 ? .88 : 1.14)); }, { passive: false });
    addEventListener('keydown', (e) => { if (!aberto) return; const k = e.key;
      if (k === 'Escape') { if (info) mostrarInfo(false); else if (sel >= 0) selecionar(-1); else fechar(); } else if (k === 'ArrowRight' || k === 'ArrowDown') selecionar((sel + 1) % def.locais.length); else if (k === 'ArrowLeft' || k === 'ArrowUp') selecionar((sel - 1 + def.locais.length) % def.locais.length);
      else if (k === 'Enter' || k === ' ') { if (sel >= 0) ir(); } else if (k === 'i' || k === 'I') { if (sel >= 0) mostrarInfo(!info); } else if (k === '+' || k === '=') zoomPara(cam.z * 1.3); else if (k === '-') zoomPara(cam.z / 1.3); else return; e.preventDefault(); e.stopImmediatePropagation(); }, true);
  }
  const celular = () => Math.min(innerWidth, innerHeight) < 560;
  const zCobre = () => Math.max(cv.clientWidth / M.W, cv.clientHeight / M.H) * 1.0001;
  const zMin = () => celular() ? Math.min(cv.clientWidth / M.W, cv.clientHeight / M.H) : zCobre(), zMax = 5;
  function zoomPara(z) { anim = { de: { ...cam }, para: { x: cam.x, y: cam.y, z: Math.max(zMin(), Math.min(zMax, z)) }, t: 0, dur: .35, f: easeOut }; }
  function limitar() { const hw = cv.clientWidth / 2 / cam.z, hh = cv.clientHeight / 2 / cam.z; cam.x = hw * 2 >= M.W ? M.W / 2 : Math.max(hw, Math.min(M.W - hw, cam.x)); cam.y = hh * 2 >= M.H ? M.H / 2 : Math.max(hh, Math.min(M.H - hh, cam.y)); } // tela maior que o mapa: fica no meio

  /* ---------- luz de dia: clareia, aquece e dá mais cor (uma vez, ao montar) ---------- */
  function luzDeDia(cv) { try { const g = cv.getContext('2d'), im = g.getImageData(0, 0, cv.width, cv.height), d = im.data;
    for (let i = 0; i < d.length; i += 4) { if (!d[i + 3]) continue; let r = d[i], gg = d[i + 1], b = d[i + 2]; const L = .299 * r + .587 * gg + .114 * b;
      r = L + (r - L) * 1.2; gg = L + (gg - L) * 1.2; b = L + (b - L) * 1.12; // mais cor
      r = r * 1.08 + 16; gg = gg * 1.08 + 14; b = b * 1.03 + 8; // mais claro e um pouco mais quente (sol)
      d[i] = r > 255 ? 255 : r < 0 ? 0 : r; d[i + 1] = gg > 255 ? 255 : gg < 0 ? 0 : gg; d[i + 2] = b > 255 ? 255 : b < 0 ? 0 : b; }
    g.putImageData(im, 0, 0); } catch (e) {} }
  /* ---------- montar o mapa (uma vez) ---------- */
  function montar(d) {
    const Tr = Terreno(d.lajotas[0], d.lajotas[1]); d.terreno(Tr);
    const base = pintarTerreno(Tr, d.chao); const W = base.width, H = base.height;
    const obj = document.createElement('canvas'); obj.width = W; obj.height = H; const oc = obj.getContext('2d'); oc.imageSmoothingEnabled = false; const lista = []; d.objetos?.((y, f) => lista.push([y, f]), Tr);
    lista.sort((a, b) => a[0] - b[0]); const PO = Px(oc); for (const [, f] of lista) f(PO);
    const locs = d.locais.map((L) => { const [bx0, by0, bw, bh] = L.caixa, [dx, dy] = L.desloc || [0, 0], bx = bx0 + dx, by = by0 + dy, s = document.createElement('canvas'); s.width = bw; s.height = bh; const sc = s.getContext('2d'); sc.imageSmoothingEnabled = false; sc.translate(-bx0, -by0); L.desenho(Px(sc)); const esc = document.createElement('canvas'); esc.width = bw; esc.height = bh; const ec = esc.getContext('2d'); ec.drawImage(s, 0, 0); ec.globalCompositeOperation = 'source-atop'; ec.fillStyle = 'rgba(8,10,26,.62)'; ec.fillRect(0, 0, bw, bh); return { s, esc, bx, by, bw, bh, pulo: null, tremor: 0 }; });
    luzDeDia(base); luzDeDia(obj); for (const L of locs) { luzDeDia(L.s); // trancado: véu leve (o lugar continua reconhecível, com o cadeado em cima)
      const ec = L.esc.getContext('2d'); ec.globalCompositeOperation = 'source-over'; ec.clearRect(0, 0, L.bw, L.bh); ec.drawImage(L.s, 0, 0); ec.globalCompositeOperation = 'source-atop'; ec.fillStyle = 'rgba(40,50,84,.30)'; ec.fillRect(0, 0, L.bw, L.bh); ec.globalCompositeOperation = 'source-over'; }
    // vida: bandos de passarinhos e borboletas espalhados pelo mapa
    const aves = Array.from({ length: 4 }, (_, k) => ({ x: Math.random() * W, y: 80 + k * (H - 160) / 4, v: 34 + Math.random() * 22, dir: k % 2 ? -1 : 1, n: 4 + (k % 3), fase: Math.random() * 6 }));
    const borbo = Array.from({ length: 14 }, (_, k) => ({ x: Math.random() * W, y: Math.random() * H, fase: Math.random() * 9, cor: ['#ffe14a', '#ff8ad0', '#ffffff', '#8ad8ff', '#ffb04a'][k % 5] }));
    return { base, obj, locs, W, H, agua: Tr.aguaPontos || [], Tr, aves, borbo };
  }

  /* ---------- abrir, selecionar, ir ---------- */
  function abrir(d) {
    if (!ui) montarUI(); def = d; if (!cache.has(d.chave)) cache.set(d.chave, montar(d)); M = cache.get(d.chave);
    ui.querySelector('.t').textContent = d.titulo; ui.querySelector('.s').textContent = d.subtitulo || ''; const bt = ui.querySelector('.teste'); bt.hidden = !d.teste; bt.textContent = d.teste?.rotulo || ''; mostrarTrava(-1);
    ui.hidden = false; requestAnimationFrame(() => ui.classList.add('on')); aberto = true; sel = -1; info = false; viagem = null; faiscas = [];
    resize(); const atual = d.locais.findIndex((L) => L.atual), foco = atual >= 0 ? centro(atual) : { x: M.W / 2, y: M.H / 2 };
    cam = { x: M.W / 2, y: M.H / 2, z: zMin() }; limitar(); anim = { de: { ...cam }, para: { x: foco.x, y: foco.y, z: celular() ? Math.min(zMax, Math.max(zMin() * 1.15, zCobre() * .9)) : Math.min(zMax, zMin() * 1.9) }, t: -.25, dur: 1.4, f: ease }; montarLugares();
    ui.querySelector('.pv').classList.remove('on'); ui.querySelector('.fade').style.opacity = 0; mostrarInfo(false);
    last = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(loop);
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
    if (atual >= 0) setTimeout(() => aberto && sel < 0 && selecionar(atual), 1500);
    return true;
  }
  function fechar() { if (!aberto) return; aberto = false; ui.classList.remove('on'); setTimeout(() => { if (!aberto) ui.hidden = true; }, 360); cancelAnimationFrame(raf); clearInterval(previaTimer); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); def?.aoFechar?.(); }
  const centro = (i) => { const L = M.locs[i]; return { x: L.bx + L.bw / 2, y: L.by + L.bh * .6 }; };
  function selecionar(i) {
    if (viagem) return; sel = i; const pv = ui.querySelector('.pv'); mostrarInfo(false); clearInterval(previaTimer); mostrarTrava(i >= 0 && def.locais[i].estado?.trava ? i : -1);
    if (i < 0) { ui.classList.remove('ficha-aberta'); pv.classList.remove('on'); anim = { de: { ...cam }, para: { ...cam, z: Math.max(zMin(), cam.z * .75) }, t: 0, dur: .5, f: ease }; return; }
    const L = def.locais[i], ok = L.estado?.ok !== false, f = centro(i), largo = innerWidth > 760, cel = celular(), lado = cel && innerWidth > innerHeight, z = cel ? Math.min(zMax, Math.max(zCobre() * 1.4, 1.6)) : Math.min(zMax, Math.max(zMin() * 2.2, 3));
    anim = { de: { ...cam }, para: { x: f.x + (largo ? 170 / z : lado ? cv.clientWidth * .22 / z : 0), y: f.y + (largo || lado ? 0 : cel ? cv.clientHeight * .2 / z : 110 / z), z }, t: 0, dur: .8, f: ease }; ui.classList.add('ficha-aberta');
    M.locs[i].pulo = 0; for (let k = 0; k < 26; k++) { const a = Math.random() * Math.PI * 2, v = 30 + Math.random() * 70; faiscas.push({ x: f.x, y: f.y, vx: Math.cos(a) * v, vy: Math.sin(a) * v * .6 - 50, t: 0, cor: ['#ffd24a', '#ffffff', '#ffe9a8'][k % 3] }); }
    pv.querySelector('h3').textContent = L.nome; pv.querySelector('.sub').textContent = L.sub || ''; pv.querySelector('.desc').innerHTML = `<b>${L.nome}</b>${L.descricao || ''}`;
    pv.querySelector('.motivo').textContent = ok ? '' : '🔒 ' + (L.estado?.motivo || L.estado?.reason || 'Ainda não dá para ir.'); const bt = pv.querySelector('.ir'); bt.disabled = !ok || !!L.atual; bt.textContent = L.atual ? 'VOCÊ ESTÁ AQUI' : ok ? (def.botao || 'IR PARA LÁ ▶') : L.estado?.trava ? '🔒 TRANCADO' : 'BLOQUEADO';
    pv.classList.remove('on'); void pv.offsetWidth; pv.classList.add('on');
    const prev = pv.querySelector('canvas.prev'), pc = prev.getContext('2d'); pc.imageSmoothingEnabled = false; const desenha = () => { try { L.previa?.(pc, prev.width, prev.height, performance.now() / 1000); } catch (e) {} if (!ok) { pc.fillStyle = 'rgba(10,8,6,.55)'; pc.fillRect(0, 0, prev.width, prev.height); } if (L.estado?.trava) cadeado(prev.width / 2, prev.height / 2 + 34, 4, 0, pc); }; desenha(); previaTimer = setInterval(desenha, 120);
  }
  function montarLugares() { // faixa com todos os lugares (celular): toque e a câmera vai até lá
    const el = ui.querySelector('.lugares'); el.innerHTML = ''; ui.classList.remove('ficha-aberta');
    def.locais.forEach((L, i) => { const b = document.createElement('button'); b.type = 'button'; const bloq = L.estado?.ok === false; b.className = bloq ? 'bloq' : L.atual ? 'atual' : ''; b.textContent = (L.atual ? '● ' : bloq ? '🔒 ' : '') + L.nome; b.addEventListener('click', () => selecionar(i)); el.appendChild(b); });
  }
  let travaI = -1, travaAte = 0;
  function mostrarTrava(i) { const el = ui?.querySelector('.trava'); if (!el) return; travaI = i; el.classList.remove('on'); if (i < 0) return; const T = def.locais[i].estado.trava; el.querySelector('.t').textContent = T.titulo || 'PRECISA DERROTAR'; el.querySelector('.n').innerHTML = (T.nomes || []).map((n) => String(n).replace(/[<>&]/g, '')).join('<br>'); el.querySelector('small').textContent = T.texto || ''; void el.offsetWidth; el.classList.add('on'); travaAte = tempo + 5.5; M.locs[i].tremor = 1; }
  function mostrarInfo(v) { info = !!v; ui?.querySelector('.desc')?.classList.toggle('on', info); }
  function ir() {
    if (sel < 0 || viagem) return; const L = def.locais[sel]; if (L.estado?.ok === false || L.atual) return;
    const ai = def.locais.findIndex((q) => q.atual), para = centro(sel), de = ai >= 0 ? centro(ai) : { x: para.x - 200, y: para.y + 120 };
    const rota = def.voa ? [de, { x: (de.x + para.x) / 2, y: Math.min(de.y, para.y) - 60 }, para] : [de, { x: para.x, y: de.y }, para];
    viagem = { rota, t: 0, dur: 2.1, id: L.id }; ui.querySelector('.pv').classList.remove('on'); clearInterval(previaTimer); anim = null;
  }
  function pontoRota(v, u) { const [a, b, q] = v.rota; if (def.voa) return { x: (1 - u) * (1 - u) * a.x + 2 * (1 - u) * u * b.x + u * u * q.x, y: (1 - u) * (1 - u) * a.y + 2 * (1 - u) * u * b.y + u * u * q.y, alt: Math.sin(u * Math.PI) * 40 };
    const l1 = Math.hypot(b.x - a.x, b.y - a.y), l2 = Math.hypot(q.x - b.x, q.y - b.y), d = u * (l1 + l2); if (d <= l1) { const k = l1 ? d / l1 : 1; return { x: a.x + (b.x - a.x) * k, y: a.y + (b.y - a.y) * k, alt: 0 }; } const k = l2 ? (d - l1) / l2 : 1; return { x: b.x + (q.x - b.x) * k, y: b.y + (q.y - b.y) * k, alt: 0 }; }

  /* ---------- clique ---------- */
  function clique(e) { const r = cv.getBoundingClientRect(), p = { x: cam.x + (e.clientX - r.left - r.width / 2) / cam.z, y: cam.y + (e.clientY - r.top - r.height / 2) / cam.z }; let best = -1, bd = 1e9;
    M.locs.forEach((L, i) => { if (p.x > L.bx - 6 && p.x < L.bx + L.bw + 6 && p.y > L.by - 30 && p.y < L.by + L.bh + 6) { const f = centro(i), d = Math.hypot(f.x - p.x, f.y - p.y); if (d < bd) { bd = d; best = i; } } }); if (best >= 0) selecionar(best); }
  function resize() { const w = cv.clientWidth, h = cv.clientHeight; if (cv.width !== w || cv.height !== h) { cv.width = w; cv.height = h; } }

  /* ---------- quadro a quadro ---------- */
  function placaNome(x, y, txt, estado, ativo) { // placa de madeira com o nome (desenhada na tela, nítida)
    c.font = '10px Pixel, monospace'; const w = Math.ceil(c.measureText(txt).width) + 14, h = 18, bx = Math.round(x - w / 2), by = Math.round(y - h);
    c.fillStyle = '#2a1a10'; c.fillRect(bx - 2, by - 2, w + 4, h + 4); c.fillStyle = ativo ? '#ffd98a' : estado === 'bloq' ? '#5a5048' : estado === 'atual' ? '#3a6a8a' : '#a8643a'; c.fillRect(bx, by, w, h); c.fillStyle = 'rgba(255,255,255,.25)'; c.fillRect(bx, by, w, 2);
    c.fillStyle = ativo ? '#2a1a10' : '#fff6dc'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillText(txt, x, y - h / 2 + 1); c.fillStyle = '#2a1a10'; c.fillRect(Math.round(x) - 2, by + h + 2, 4, 5);
  }
  function cadeado(x, y, k, tremor, cx = c) { const c = cx; // cadeado vermelho em pixel art, com brilho pulsando; treme quando você tenta entrar
    x = Math.round(x + (tremor > 0 ? Math.sin(tempo * 55) * 4 * tremor : 0)); y = Math.round(y); const P = (px, py, w, h, col) => { c.fillStyle = col; c.fillRect(x + px * k, y + py * k, w * k, h * k); };
    c.save(); c.globalAlpha = .22 + Math.sin(tempo * 4) * .08 + tremor * .3; c.fillStyle = '#ff2a2a'; c.beginPath(); c.arc(x, y - 6 * k, 10 * k, 0, Math.PI * 2); c.fill(); c.globalAlpha = .35; c.fillStyle = '#000'; c.fillRect(x - 6 * k, y + k, 12 * k, k); c.restore();
    P(-4, -15, 8, 1, '#2a0808'); P(-5, -14, 1, 6, '#2a0808'); P(4, -14, 1, 6, '#2a0808'); P(-4, -14, 8, 1, '#dde0e3'); P(-4, -13, 2, 5, '#9aa0a6'); P(2, -13, 2, 5, '#9aa0a6'); P(-4, -13, 1, 5, '#c8ccd0'); P(-2, -13, 4, 1, '#2a0808'); P(-2, -12, 1, 4, '#2a0808'); P(1, -12, 1, 4, '#2a0808');
    P(-6, -9, 12, 10, '#2a0808'); P(-5, -8, 10, 8, '#d83a3a'); P(-5, -8, 10, 1, '#ff8a7a'); P(-5, -7, 1, 6, '#ff6a5a'); P(4, -8, 1, 8, '#a82424'); P(-5, -1, 10, 1, '#8a1a1a'); P(-3, -6, 1, 1, '#ffb0a0');
    P(-1, -6, 2, 2, '#2a0808'); P(-1, -4, 1, 2, '#2a0808'); P(0, -4, 1, 2, '#3a0a0a'); }
  function loop(now) {
    if (!aberto) return; raf = requestAnimationFrame(loop); const dt = Math.max(0, Math.min(.05, (now - last) / 1000)); last = now; tempo += dt; resize();
    const W = cv.width, H = cv.height;
    if (anim) { anim.t += dt; const u = anim.f(Math.max(0, Math.min(1, anim.t / anim.dur))); cam.x = anim.de.x + (anim.para.x - anim.de.x) * u; cam.y = anim.de.y + (anim.para.y - anim.de.y) * u; cam.z = anim.de.z + (anim.para.z - anim.de.z) * u; if (anim.t >= anim.dur) anim = null; }
    let veic = null; if (viagem) { const v = viagem; v.t += dt; const u = ease(Math.min(1, v.t / v.dur)); veic = pontoRota(v, u); const p2 = pontoRota(v, ease(Math.min(1, v.t / v.dur + .02))); veic.dir = p2.x >= veic.x ? 1 : -1;
      cam.x += (veic.x - cam.x) * Math.min(1, dt * 5); cam.y += (veic.y - cam.y) * Math.min(1, dt * 5); cam.z += (Math.min(zMax, 3.2) - cam.z) * Math.min(1, dt * 2);
      if (v.t > v.dur - .4) ui.querySelector('.fade').style.opacity = 1; if (v.t >= v.dur + .2) { const id = v.id; viagem = null; fechar(); setTimeout(() => def.aoIr?.(id), 60); return; } }
    limitar();
    c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false; c.fillStyle = '#8ccfe8'; c.fillRect(0, 0, W, H);
    const z = cam.z, ox = Math.round(W / 2 - cam.x * z), oy = Math.round(H / 2 - cam.y * z); c.setTransform(z, 0, 0, z, ox, oy);
    c.drawImage(M.base, 0, 0);
    const P = Px(c), R = P.R;
    for (const [x, y] of M.agua) { const ph = (tempo * .8 + hash(x, y) * 5) % 5; if (ph < .9) { R(x - 2 + ph * 2, y, Math.max(1, 5 - ph * 5), 1, '#e2f4ff'); if (ph < .3) R(x, y - 1, 1, 1, '#ffffff'); } } // brilho na água
    def.animarChao?.(P, tempo);
    c.drawImage(M.obj, 0, 0);
    def.locais.forEach((L, i) => { if (!L.estado?.trava) return; const lo = M.locs[i], cx = lo.bx + lo.bw / 2, cy = lo.by + lo.bh * .55; c.save(); c.fillStyle = '#1a2440'; for (const [k, a] of [[.74, .17], [.62, .15], [.5, .13]]) { c.globalAlpha = a; c.beginPath(); c.ellipse(cx, cy, lo.bw * k, lo.bh * k, 0, 0, Math.PI * 2); c.fill(); } c.restore(); }); // claridade menor nas áreas trancadas
    const ordem = M.locs.map((L, i) => i).sort((a, b) => (M.locs[a].by + M.locs[a].bh) - (M.locs[b].by + M.locs[b].bh));
    for (const i of ordem) { const L = M.locs[i]; let sx = 1, sy = 1; if (L.pulo !== null) { L.pulo += dt; const k = L.pulo, y = k < 1 ? Math.sin(k * 15) * Math.exp(-k * 4.5) * .22 : 0; sy = 1 + y; sx = 1 - y * .6; if (k >= 1) L.pulo = null; }
      if (i === sel) { c.save(); c.globalAlpha = .35 + Math.sin(tempo * 5) * .15; c.fillStyle = def.locais[i].estado?.trava ? '#ff4a3a' : '#fff6c0'; const r = Math.max(L.bw, L.bh) * .62; c.beginPath(); c.ellipse(L.bx + L.bw / 2, L.by + L.bh - 4, r, r * .35, 0, 0, Math.PI * 2); c.fill(); c.restore(); }
      c.save(); c.translate(L.bx + L.bw / 2, L.by + L.bh); c.scale(sx, sy); c.drawImage(def.locais[i].estado?.trava ? L.esc : L.s, -L.bw / 2, -L.bh); c.restore(); }
    def.animar?.(P, tempo, dt);
    faiscas = faiscas.filter((f) => { f.t += dt; f.vy += 160 * dt; f.x += f.vx * dt; f.y += f.vy * dt; R(f.x, f.y, 2, 2, f.cor); return f.t < .9; });
    if (veic) { c.globalAlpha = .3; P.circ(veic.x, veic.y + 3, 10, '#000', 3); c.globalAlpha = 1; c.save(); c.translate(Math.round(veic.x), Math.round(veic.y - veic.alt)); if (veic.dir < 0) c.scale(-1, 1); def.veiculo?.(P, tempo); c.restore(); }
    for (const a of M.aves) { a.x += a.v * a.dir * dt; if (a.x > M.W + 120) a.x = -120; if (a.x < -120) a.x = M.W + 120; // bando em V batendo as asas
      for (let i = 0; i < a.n; i++) { const lado = i % 2 ? 1 : -1, k = Math.ceil(i / 2), bx = a.x - a.dir * k * 9, by = a.y + lado * k * 6 + Math.sin(tempo * 2 + a.fase) * 6, asa = Math.sin(tempo * 12 + a.fase + i) > 0;
        R(bx - 3, by - (asa ? 2 : 0), 2, 1, '#2a2a3a'); R(bx - 1, by, 2, 1, '#2a2a3a'); R(bx + 1, by - (asa ? 2 : 0), 2, 1, '#2a2a3a'); c.globalAlpha = .15; R(bx - 2, by + 26, 4, 1, '#000'); c.globalAlpha = 1; } }
    for (const b of M.borbo) { const t2 = tempo + b.fase, bx = b.x + Math.sin(t2 * .7) * 24, by = b.y + Math.sin(t2 * 1.3) * 10, abre = Math.sin(t2 * 14) > 0; // borboletas
      R(bx - (abre ? 2 : 1), by, abre ? 2 : 1, 2, b.cor); R(bx + 1, by, abre ? 2 : 1, 2, b.cor); R(bx, by, 1, 2, '#2a1a10'); }
    for (let k = 0; k < 5; k++) { const nx = ((tempo * 8 + k * 260) % (M.W + 300)) - 150, ny = 60 + k * (M.H / 5); c.globalAlpha = .06; P.circ(nx + 24, ny + 46, 34, '#0c1a30', 12); c.globalAlpha = .55; P.circ(nx, ny, 26, '#ffffff', 9); P.circ(nx + 18, ny - 4, 18, '#ffffff', 8); P.circ(nx - 14, ny + 2, 14, '#ffffff', 6); c.globalAlpha = 1; } // nuvens e a sombra delas
    c.setTransform(1, 0, 0, 1, 0, 0);
    { c.save(); c.globalCompositeOperation = 'screen'; const sol = c.createRadialGradient(W * .08, -H * .1, 0, W * .08, -H * .1, Math.max(W, H) * .9); sol.addColorStop(0, 'rgba(255,236,170,.35)'); sol.addColorStop(.5, 'rgba(255,220,150,.10)'); sol.addColorStop(1, 'rgba(255,220,150,0)'); c.fillStyle = sol; c.fillRect(0, 0, W, H);
      c.globalAlpha = .07 + Math.sin(tempo * .5) * .02; c.fillStyle = '#fff2c0'; for (let k = 0; k < 4; k++) { const x0 = ((k * .27 + tempo * .004) % 1.2 - .1) * W; c.beginPath(); c.moveTo(x0, 0); c.lineTo(x0 + W * .06, 0); c.lineTo(x0 + W * .06 + H * .55, H); c.lineTo(x0 + H * .55, H); c.fill(); } c.restore(); } // raios de sol
    def.locais.forEach((L, i) => { const lo = M.locs[i], sx = ox + (lo.bx + lo.bw / 2) * z, sy = oy + lo.by * z; if (sx < -100 || sx > W + 100 || sy < -60 || sy > H + 80) return; const b = Math.round(Math.sin(tempo * 3 + i) * 3), ativo = i === sel;
      placaNome(sx, sy - 6 + b, (L.atual ? '● ' : '') + L.nome, L.estado?.ok === false ? 'bloq' : L.atual ? 'atual' : 'ok', ativo);
      if (ativo) { c.fillStyle = '#ffd24a'; const ay = sy - 34 + Math.round(Math.sin(tempo * 6) * 4); c.beginPath(); c.moveTo(sx - 8, ay - 10); c.lineTo(sx + 8, ay - 10); c.lineTo(sx, ay); c.fill(); } });
    def.locais.forEach((L, i) => { if (!L.estado?.trava) return; const lo = M.locs[i], k = Math.max(2, Math.min(4, Math.round(z * .9))), x = ox + (lo.bx + lo.bw / 2) * z, y = oy + (lo.by + lo.bh * .62) * z + Math.round(Math.sin(tempo * 2.2 + i) * 2); if (x < -60 || x > W + 60 || y < -60 || y > H + 80) return;
      lo.tremor = Math.max(0, lo.tremor - dt * 1.6); cadeado(x, y, k, lo.tremor); if (i === travaI) { const el = ui.querySelector('.trava'), pv = ui.querySelector('.pv'), r = pv.classList.contains('on') ? pv.getBoundingClientRect() : null, meia = el.offsetWidth / 2 + 10, ladoDir = r && r.top < H * .4 ? r.left : W, base = r && r.top >= H * .4 ? r.top : H; el.style.left = Math.round(Math.max(meia, Math.min(ladoDir - meia, x))) + 'px'; el.style.top = Math.round(Math.max(el.offsetHeight + 60, Math.min(base - 16, y - 17 * k - 8))) + 'px'; if (tempo > travaAte) mostrarTrava(-1); } });
  }

  window.Mapa3D = Object.freeze({ abrir, fechar, aberto: () => aberto, selecionar: (id) => { const i = def?.locais.findIndex((L) => L.id === id) ?? -1; if (i >= 0) selecionar(i); }, ir, info: mostrarInfo, arte: { Px, COR, shade, hash, TS, curva, trilho, vn } });
})();
