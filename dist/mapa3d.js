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
      arvore: (cx, by, s = 1, tipo = 'verde', seed = 0) => { // árvore redonda com tronco, raiz e sombra
        const pal = { verde: ['#2f5e26', '#3f8a30', '#58a83c', '#7cc84e', '#a8e070'], escura: ['#244a20', '#2f6a2a', '#3f8a30', '#58a83c', '#7cc84e'], roxa: ['#4a2a5a', '#7a3a9a', '#a85ac8', '#c88ae0', '#ecc8f8'], amarela: ['#6a5010', '#b8901a', '#e0b828', '#f4d84a', '#fff4a0'], laranja: ['#5a2a10', '#a8501a', '#d8782a', '#f0a04a', '#ffd08a'] }[tipo] || ['#2f5e26', '#3f8a30', '#58a83c', '#7cc84e', '#a8e070'];
        const r = Math.round(10 * s); P.sombra(cx + 3, by, r + 2, Math.round(r * .45));
        R(cx - 2, by - 9 * s, 5, 9 * s, '#6a4228'); R(cx - 2, by - 9 * s, 2, 9 * s, '#8a5a36'); R(cx - 4, by - 2, 3, 2, '#6a4228'); R(cx + 2, by - 2, 3, 2, '#5a3820');
        const cy = by - 9 * s - r * .8; circ(cx, cy, r + 1, pal[0]); circ(cx, cy, r, pal[1]); circ(cx - 1, cy - 1, r - 2, pal[2]); circ(cx - 3, cy - 3, Math.max(2, r - 5), pal[3]);
        for (let k = 0; k < 6 * s; k++) { const a = hash(seed + k) * 6.28, d = hash(seed * 3 + k) * (r - 3); R(cx + Math.cos(a) * d, cy + Math.sin(a) * d * .8, 2, 1, pal[k % 3 === 0 ? 4 : 3]); }
        for (let k = 0; k < 4 * s; k++) { const a = 1 + hash(seed + k * 7) * 2.2, d = r - 2; R(cx + Math.cos(a) * d, cy + Math.sin(a) * d * .9, 2, 2, pal[0]); } },
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
     TERRENO EM LAJOTAS: nível (0 = água) e tipo do chão; paredão de terra onde o terreno desce para o sul
     ===================================================================== */
  function Terreno(W, H) {
    const nivel = new Int8Array(W * H).fill(1), tipo = new Array(W * H).fill('grama'), i = (x, y) => y * W + x, dentro = (x, y) => x >= 0 && y >= 0 && x < W && y < H;
    const T = {
      W, H,
      niv: (x, y) => (dentro(x, y) ? nivel[i(x, y)] : 1), tip: (x, y) => (dentro(x, y) ? tipo[i(x, y)] : 'grama'),
      ret: (x, y, w, h, o) => { for (let yy = y; yy < y + h; yy++) for (let xx = x; xx < x + w; xx++) if (dentro(xx, yy)) { if (o.nivel !== undefined) nivel[i(xx, yy)] = o.nivel; if (o.tipo) tipo[i(xx, yy)] = o.tipo; } },
      oval: (cx, cy, rx, ry, o) => { for (let yy = Math.floor(cy - ry); yy <= cy + ry; yy++) for (let xx = Math.floor(cx - rx); xx <= cx + rx; xx++) if (dentro(xx, yy) && ((xx - cx) / rx) ** 2 + ((yy - cy) / ry) ** 2 <= 1) { if (o.nivel !== undefined) nivel[i(xx, yy)] = o.nivel; if (o.tipo) tipo[i(xx, yy)] = o.tipo; } },
      linha: (pts, larg, o) => { for (let k = 1; k < pts.length; k++) { const [a, b] = [pts[k - 1], pts[k]], len = Math.hypot(b[0] - a[0], b[1] - a[1]) || 1; for (let s = 0; s <= len; s += .3) { const x = a[0] + (b[0] - a[0]) * s / len, y = a[1] + (b[1] - a[1]) * s / len; T.ret(Math.round(x - larg / 2), Math.round(y - larg / 2), larg, larg, o); } } }
    };
    return T;
  }
  function pintarTerreno(Tr, extra) {
    const cv = document.createElement('canvas'); cv.width = Tr.W * TS; cv.height = Tr.H * TS; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; const P = Px(c), R = P.R;
    const alto = (x, y) => Tr.niv(x, y);
    for (let y = 0; y < Tr.H; y++) for (let x = 0; x < Tr.W; x++) {
      const px = x * TS, py = y * TS, n = alto(x, y), t = Tr.tip(x, y), s = hash(x, y);
      if (n === 0) { // água: tons, espuma e barranco onde a terra fica ao norte
        R(px, py, TS, TS, s > .7 ? COR.aguaE : COR.agua); for (let k = 0; k < 3; k++) R(px + hash(x + k, y) * 13, py + hash(y + k, x) * 14, 3, 1, k ? '#5aa2ea' : COR.aguaE);
        if (alto(x, y - 1) > 0) { R(px, py, TS, 6, COR.terraE); R(px, py, TS, 1, COR.terraB); R(px, py + 3, TS, 1, COR.terra); R(px, py + 6, TS, 2, COR.aguaE); R(px, py + 8, TS, 1, COR.espuma); }
        if (alto(x - 1, y) > 0) { R(px, py, 3, TS, COR.aguaC); for (let k = 0; k < TS; k += 4) R(px + 3, py + k + (s * 3 | 0), 1, 2, COR.espuma); }
        if (alto(x + 1, y) > 0) { R(px + TS - 3, py, 3, TS, COR.aguaC); for (let k = 0; k < TS; k += 4) R(px + TS - 4, py + k + 1, 1, 2, COR.espuma); }
        if (alto(x, y + 1) > 0) { R(px, py + TS - 3, TS, 3, COR.aguaC); for (let k = 0; k < TS; k += 5) R(px + k + (s * 3 | 0), py + TS - 4, 2, 1, COR.espuma); }
        continue;
      }
      const topoParede = alto(x, y - 1) > n, baseParede = !topoParede && alto(x, y - 1) === n && alto(x, y - 2) > n && Tr.tip(x, y - 1) !== 'agua';
      if (topoParede || baseParede) { // paredão de terra com duas lajotas de altura: o terreno de cima desce aqui
        R(px, py, TS, TS, COR.terra); for (let k = 3; k < TS; k += 4) { R(px, py + k, TS, 1, COR.terraE); for (let j = ((k + y * 4) % 8) ? 2 : 6; j < TS; j += 8) R(px + j, py + k - 2, 2, 1, COR.terraC); }
        for (let k = 0; k < 3; k++) if (hash(x * 5 + k, y) > .6) { const sx = px + hash(x, y * 3 + k) * 12, sy = py + 2 + hash(y, x * 3 + k) * 10; R(sx, sy, 4, 3, '#8a7a6a'); R(sx, sy, 3, 1, '#b8a898'); } // pedrinhas na terra
        if (topoParede) { R(px, py, TS, 3, COR.gramaB); for (let j = 0; j < TS; j += 2) R(px + j, py + 3, 2, 1 + ((j + x) % 3 === 0 ? 3 : (j + x) % 3 === 1 ? 1 : 0), COR.gramaB); R(px, py, TS, 1, COR.gramaE); if (hash(x * 3, y) > .7) { R(px + 5, py + 4, 1, 6, '#5a3820'); R(px + 6, py + 9, 2, 1, '#5a3820'); } }
        else { R(px, py + TS - 3, TS, 3, COR.terraB); c.globalAlpha = .25; R(px, py + TS, TS, 3, '#0c1a10'); c.globalAlpha = 1; }
        const ladoE = (alto(x - 1, y - 1) <= n && alto(x - 1, y - (baseParede ? 2 : 1)) <= n) || alto(x - 1, y) > n, ladoD = (alto(x + 1, y - 1) <= n && alto(x + 1, y - (baseParede ? 2 : 1)) <= n) || alto(x + 1, y) > n;
        if (ladoE) R(px, py, 2, TS, COR.terraB); if (ladoD) R(px + TS - 2, py, 2, TS, COR.terraB);
        continue;
      }
      if (t === 'grama' || t === 'mata') { const mancha = hash(Math.floor(x / 3), Math.floor(y / 3)), base = t === 'mata' ? '#4f9a34' : mancha > .66 ? '#65b440' : mancha < .25 ? '#58a638' : COR.grama; R(px, py, TS, TS, base); // grama com manchas, tufos e florzinhas
        for (let k = 0; k < 12; k++) R(px + hash(x * 7 + k, y) * 15, py + hash(y * 5 + k, x) * 15, 1 + (k % 3 === 0), 1, k % 2 ? COR.gramaC : COR.gramaE);
        for (let k = 0; k < (s > .55 ? 2 : 0); k++) { const tx = px + 2 + hash(x + k * 9, y * 2) * 10, ty = py + 4 + hash(y + k * 7, x * 2) * 8; R(tx, ty + 1, 1, 3, COR.gramaB); R(tx + 1, ty, 1, 4, COR.gramaB); R(tx + 2, ty + 1, 1, 3, COR.gramaB); R(tx + 1, ty, 1, 1, '#8ad45a'); }
        if (s < .06) { R(px + 9, py + 4, 2, 2, '#f6f2ea'); R(px + 10, py + 5, 1, 1, '#f2c94c'); } else if (s > .97) { R(px + 4, py + 9, 2, 2, '#e86a8a'); R(px + 5, py + 10, 1, 1, '#ffe0ea'); } }
      else if (t === 'pedra') { R(px, py, TS, TS, COR.pedraE); for (let r = 0; r < 4; r++) for (let k = 0; k < 4; k++) { const sx = px + k * 4 + (r % 2) * 2, sy = py + r * 4; R(sx, sy, 3, 3, hash(x * 4 + k, y * 4 + r) > .5 ? COR.pedra : shade(COR.pedra, .94)); R(sx, sy, 2, 1, COR.pedraC); } }
      else if (t === 'chao') { R(px, py, TS, TS, COR.chao); for (let k = 0; k < 5; k++) R(px + hash(x + k, y * 3) * 14, py + hash(y + k, x * 3) * 14, 2, 1, COR.chaoE); }
      else if (t === 'asfalto') { R(px, py, TS, TS, COR.asfalto); for (let k = 0; k < 6; k++) R(px + hash(x + k, y * 2) * 15, py + hash(y + k, x * 2) * 15, 1, 1, COR.asfaltoE); }
      else if (t === 'areia') { R(px, py, TS, TS, COR.areia); for (let k = 0; k < 5; k++) R(px + hash(x + k, y) * 15, py + hash(y + k, x) * 15, 1, 1, '#d8c07a'); }
      else if (t === 'plantacao') { R(px, py, TS, TS, '#8a5a36'); for (let r = 0; r < 4; r++) { R(px, py + r * 4 + 2, TS, 1, '#6a4228'); for (let k = 1; k < TS; k += 3) { R(px + k, py + r * 4, 1, 2, '#58a83c'); R(px + k, py + r * 4, 1, 1, '#9ade6a'); } } }
      else if (t === 'cafe') { R(px, py, TS, TS, '#8a5a36'); for (let r = 0; r < 2; r++) for (let k = 0; k < 4; k++) { const cx = px + 2 + k * 4, cy = py + 3 + r * 8; R(cx - 1, cy - 1, 4, 4, '#2f5e26'); R(cx, cy - 1, 2, 2, '#3f8a30'); if (hash(x * 8 + k, y + r) > .6) R(cx + 1, cy + 1, 1, 1, '#c43c3a'); } }
      else if (t === 'campo') R(px, py, TS, TS, (x % 2) ? '#5aa046' : '#66ae50');
      else if (t === 'quadra') R(px, py, TS, TS, '#3c7ab0');
      else if (t === 'pista') R(px, py, TS, TS, '#5b6066');
      else if (t === 'nuvem') { R(px, py, TS, TS, '#e8f0f6'); for (let k = 0; k < 4; k++) R(px + hash(x + k, y) * 12, py + hash(y + k, x) * 12, 4, 2, '#ffffff'); }
      else R(px, py, TS, TS, COR.grama);
      // borda onde o chão encontra a grama (pedra, terra) com grama invadindo um pouco
      if (t !== 'grama' && t !== 'mata') for (const [dx, dy] of [[0, -1], [0, 1], [-1, 0], [1, 0]]) { const nt = Tr.tip(x + dx, y + dy); if ((nt === 'grama' || nt === 'mata') && alto(x + dx, y + dy) === n) { const col = shade(t === 'pedra' ? COR.pedraB : t === 'asfalto' ? '#8a8e92' : COR.chaoE, .95);
        if (dy) { R(px, py + (dy < 0 ? 0 : TS - 1), TS, 1, col); for (let k = 0; k < TS; k += 2) if (hash(x * 9 + k, y + dy) > .55) R(px + k, py + (dy < 0 ? 0 : TS - 2), 2, 2, COR.grama); } else { R(px + (dx < 0 ? 0 : TS - 1), py, 1, TS, col); for (let k = 0; k < TS; k += 2) if (hash(x + dx, y * 9 + k) > .55) R(px + (dx < 0 ? 0 : TS - 2), py + k, 2, 2, COR.grama); } } }
      if (alto(x, y - 1) < n && alto(x, y - 1) > 0) R(px, py, TS, 2, COR.borda);
      if (alto(x - 1, y) < n) { R(px, py, 2, TS, COR.borda); R(px + 2, py, 1, TS, COR.gramaB); } if (alto(x + 1, y) < n) { R(px + TS - 2, py, 2, TS, COR.borda); R(px + TS - 3, py, 1, TS, COR.gramaB); }
    }
    extra?.(P, c);
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
    st.textContent = `.m3d{position:fixed;inset:0;z-index:2147483200;background:#16243a;font-family:Pixel,monospace;color:#f6ead0;opacity:0;transition:opacity .35s;touch-action:none;user-select:none;-webkit-user-select:none}.m3d.on{opacity:1}.m3d[hidden]{display:none}
.m3d canvas.gl{position:absolute;inset:0;width:100%;height:100%;image-rendering:pixelated;cursor:grab}.m3d canvas.gl.arrasta{cursor:grabbing}
.m3d .topo{position:absolute;left:0;right:0;top:0;display:flex;align-items:center;gap:10px;padding:10px 14px;background:linear-gradient(#0b0f14dd,#0b0f1400);pointer-events:none}.m3d .topo b{font-size:15px;color:#ffd98a;text-shadow:2px 2px #2a1a14}.m3d .topo small{font-size:9px;color:#e8eef2;text-shadow:1px 1px #000}.m3d .topo .bts{pointer-events:auto;margin-left:auto;display:flex;gap:6px}
.m3d button{font:inherit;font-size:11px;padding:8px 12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}.m3d button:hover,.m3d button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.m3d button:active{transform:translateY(3px);box-shadow:0 1px 0 #2a1a10}.m3d button[disabled]{opacity:.45;cursor:default}
.m3d .pv{position:absolute;right:14px;top:56px;bottom:14px;width:min(380px,44vw);background:#2a1e14;border:4px solid #e8c66a;box-shadow:0 0 0 4px #120c08,0 14px 30px #0009;display:flex;flex-direction:column;padding:12px;gap:10px;transform:translateX(120%);transition:transform .45s cubic-bezier(.2,.9,.25,1.15)}.m3d .pv.on{transform:none}
.m3d .pv h3{margin:0;font-size:14px;color:#ffd98a;padding-right:40px}.m3d .pv .sub{font-size:9px;color:#c8b48a;margin-top:-6px}.m3d .pv .ib{position:absolute;right:10px;top:10px;width:34px;height:34px;padding:0;font-size:16px;border-radius:50%}
.m3d .pv .tela{position:relative;flex:1;min-height:120px;background:#000;border:3px solid #120c08;overflow:hidden}.m3d .pv canvas.prev{width:100%;height:100%;object-fit:cover;image-rendering:pixelated;display:block}
.m3d .pv .desc{position:absolute;inset:0;background:#120c08ee;padding:12px;font-size:11px;line-height:1.7;color:#f6ead0;opacity:0;transform:translateY(12px);transition:.3s;pointer-events:none;overflow:auto}.m3d .pv .desc.on{opacity:1;transform:none;pointer-events:auto}.m3d .pv .desc b{color:#ffd98a;display:block;margin-bottom:6px}
.m3d .pv .ir{font-size:14px;padding:12px;background:#e8a83a;color:#1c1408;border-color:#fff2c8}.m3d .pv .ir:hover{background:#ffd98a}.m3d .pv .motivo{font-size:9px;color:#ff9a8a;line-height:1.5}.m3d .pv .x{position:absolute;left:-14px;top:-14px;width:28px;height:28px;padding:0;font-size:12px}
.m3d .dica{position:absolute;left:14px;bottom:14px;font-size:9px;color:#fff;background:#0b0f14aa;padding:6px 8px;pointer-events:none}.m3d .fade{position:absolute;inset:0;background:#000;opacity:0;pointer-events:none;transition:opacity .45s}
.m3d .zoom{position:absolute;left:14px;bottom:44px;display:flex;flex-direction:column;gap:6px}.m3d .zoom button{width:38px;height:38px;padding:0;font-size:16px}
@media (max-width:760px),(max-height:520px){.m3d .pv{left:10px;right:10px;top:auto;bottom:10px;width:auto;height:50%}.m3d .pv .tela{min-height:70px}.m3d .dica{display:none}.m3d .zoom{bottom:auto;top:60px}}`;
    document.head.appendChild(st);
  }
  function montarUI() {
    css(); ui = document.createElement('div'); ui.className = 'm3d'; ui.hidden = true; ui.setAttribute('role', 'dialog');
    ui.innerHTML = `<canvas class="gl"></canvas><div class="topo"><div><b class="t"></b><br><small class="s"></small></div><div class="bts"><button type="button" class="fechar" aria-label="Fechar mapa">✕ FECHAR</button></div></div>
<div class="zoom"><button type="button" class="zmais" aria-label="Aproximar">+</button><button type="button" class="zmenos" aria-label="Afastar">−</button></div>
<div class="pv" aria-live="polite"><button type="button" class="x" aria-label="Voltar ao mapa">✕</button><h3></h3><div class="sub"></div><button type="button" class="ib" aria-label="Sobre o lugar" title="Sobre o lugar">ⓘ</button><div class="tela"><canvas class="prev" width="320" height="180"></canvas><div class="desc"></div></div><div class="motivo"></div><button type="button" class="ir">IR PARA LÁ ▶</button></div>
<div class="dica">Arraste para passear · toque num lugar · ← → troca · ENTER vai · ESC fecha</div><div class="fade"></div>`;
    document.body.appendChild(ui); cv = ui.querySelector('canvas.gl'); c = cv.getContext('2d');
    ui.querySelector('.fechar').addEventListener('click', fechar); ui.querySelector('.x').addEventListener('click', () => selecionar(-1));
    ui.querySelector('.ib').addEventListener('click', () => mostrarInfo(!info)); ui.querySelector('.ir').addEventListener('click', ir);
    ui.querySelector('.zmais').addEventListener('click', () => zoomPara(cam.z * 1.3)); ui.querySelector('.zmenos').addEventListener('click', () => zoomPara(cam.z / 1.3));
    cv.addEventListener('pointerdown', (e) => { drag = { x: e.clientX, y: e.clientY, cx: cam.x, cy: cam.y, moveu: false }; cv.setPointerCapture(e.pointerId); });
    cv.addEventListener('pointermove', (e) => { if (!drag || viagem) return; const dx = e.clientX - drag.x, dy = e.clientY - drag.y; if (Math.abs(dx) + Math.abs(dy) > 6) { drag.moveu = true; cv.classList.add('arrasta'); } if (!drag.moveu) return; anim = null; cam.x = drag.cx - dx / cam.z; cam.y = drag.cy - dy / cam.z; limitar(); });
    cv.addEventListener('pointerup', (e) => { cv.classList.remove('arrasta'); if (drag && !drag.moveu) clique(e); drag = null; });
    cv.addEventListener('wheel', (e) => { e.preventDefault(); zoomPara(cam.z * (e.deltaY > 0 ? .88 : 1.14)); }, { passive: false });
    addEventListener('keydown', (e) => { if (!aberto) return; const k = e.key;
      if (k === 'Escape') { if (info) mostrarInfo(false); else if (sel >= 0) selecionar(-1); else fechar(); } else if (k === 'ArrowRight' || k === 'ArrowDown') selecionar((sel + 1) % def.locais.length); else if (k === 'ArrowLeft' || k === 'ArrowUp') selecionar((sel - 1 + def.locais.length) % def.locais.length);
      else if (k === 'Enter' || k === ' ') { if (sel >= 0) ir(); } else if (k === 'i' || k === 'I') { if (sel >= 0) mostrarInfo(!info); } else if (k === '+' || k === '=') zoomPara(cam.z * 1.3); else if (k === '-') zoomPara(cam.z / 1.3); else return; e.preventDefault(); e.stopImmediatePropagation(); }, true);
  }
  const zMin = () => Math.max(cv.clientWidth / M.W, cv.clientHeight / M.H) * 1.0001, zMax = 5;
  function zoomPara(z) { anim = { de: { ...cam }, para: { x: cam.x, y: cam.y, z: Math.max(zMin(), Math.min(zMax, z)) }, t: 0, dur: .35, f: easeOut }; }
  function limitar() { const hw = cv.clientWidth / 2 / cam.z, hh = cv.clientHeight / 2 / cam.z; cam.x = Math.max(hw, Math.min(M.W - hw, cam.x)); cam.y = Math.max(hh, Math.min(M.H - hh, cam.y)); }

  /* ---------- montar o mapa (uma vez) ---------- */
  function montar(d) {
    const Tr = Terreno(d.lajotas[0], d.lajotas[1]); d.terreno(Tr);
    const base = pintarTerreno(Tr, d.chao); const W = base.width, H = base.height;
    const obj = document.createElement('canvas'); obj.width = W; obj.height = H; const oc = obj.getContext('2d'); oc.imageSmoothingEnabled = false; const lista = []; d.objetos?.((y, f) => lista.push([y, f]));
    lista.sort((a, b) => a[0] - b[0]); const PO = Px(oc); for (const [, f] of lista) f(PO);
    const locs = d.locais.map((L) => { const [bx, by, bw, bh] = L.caixa, s = document.createElement('canvas'); s.width = bw; s.height = bh; const sc = s.getContext('2d'); sc.imageSmoothingEnabled = false; sc.translate(-bx, -by); L.desenho(Px(sc)); return { s, bx, by, bw, bh, pulo: null }; });
    const agua = []; for (let y = 0; y < Tr.H; y++) for (let x = 0; x < Tr.W; x++) if (Tr.niv(x, y) === 0) agua.push([x, y]);
    return { base, obj, locs, W, H, agua, Tr };
  }

  /* ---------- abrir, selecionar, ir ---------- */
  function abrir(d) {
    if (!ui) montarUI(); def = d; if (!cache.has(d.chave)) cache.set(d.chave, montar(d)); M = cache.get(d.chave);
    ui.querySelector('.t').textContent = d.titulo; ui.querySelector('.s').textContent = d.subtitulo || '';
    ui.hidden = false; requestAnimationFrame(() => ui.classList.add('on')); aberto = true; sel = -1; info = false; viagem = null; faiscas = [];
    resize(); const atual = d.locais.findIndex((L) => L.atual), foco = atual >= 0 ? centro(atual) : { x: M.W / 2, y: M.H / 2 };
    cam = { x: M.W / 2, y: M.H / 2, z: zMin() }; limitar(); anim = { de: { ...cam }, para: { x: foco.x, y: foco.y, z: Math.min(zMax, zMin() * 1.9) }, t: -.25, dur: 1.4, f: ease };
    ui.querySelector('.pv').classList.remove('on'); ui.querySelector('.fade').style.opacity = 0; mostrarInfo(false);
    last = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(loop);
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
    if (atual >= 0) setTimeout(() => aberto && sel < 0 && selecionar(atual), 1500);
    return true;
  }
  function fechar() { if (!aberto) return; aberto = false; ui.classList.remove('on'); setTimeout(() => { if (!aberto) ui.hidden = true; }, 360); cancelAnimationFrame(raf); clearInterval(previaTimer); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); def?.aoFechar?.(); }
  const centro = (i) => { const L = M.locs[i]; return { x: L.bx + L.bw / 2, y: L.by + L.bh * .6 }; };
  function selecionar(i) {
    if (viagem) return; sel = i; const pv = ui.querySelector('.pv'); mostrarInfo(false); clearInterval(previaTimer);
    if (i < 0) { pv.classList.remove('on'); anim = { de: { ...cam }, para: { ...cam, z: Math.max(zMin(), cam.z * .75) }, t: 0, dur: .5, f: ease }; return; }
    const L = def.locais[i], ok = L.estado?.ok !== false, f = centro(i), largo = innerWidth > 760, z = Math.min(zMax, Math.max(zMin() * 2.2, 3));
    anim = { de: { ...cam }, para: { x: f.x + (largo ? 170 / z : 0), y: f.y + (largo ? 0 : 110 / z), z }, t: 0, dur: .8, f: ease };
    M.locs[i].pulo = 0; for (let k = 0; k < 26; k++) { const a = Math.random() * Math.PI * 2, v = 30 + Math.random() * 70; faiscas.push({ x: f.x, y: f.y, vx: Math.cos(a) * v, vy: Math.sin(a) * v * .6 - 50, t: 0, cor: ['#ffd24a', '#ffffff', '#ffe9a8'][k % 3] }); }
    pv.querySelector('h3').textContent = L.nome; pv.querySelector('.sub').textContent = L.sub || ''; pv.querySelector('.desc').innerHTML = `<b>${L.nome}</b>${L.descricao || ''}`;
    pv.querySelector('.motivo').textContent = ok ? '' : '🔒 ' + (L.estado?.motivo || L.estado?.reason || 'Ainda não dá para ir.'); const bt = pv.querySelector('.ir'); bt.disabled = !ok || !!L.atual; bt.textContent = L.atual ? 'VOCÊ ESTÁ AQUI' : ok ? (def.botao || 'IR PARA LÁ ▶') : 'BLOQUEADO';
    pv.classList.remove('on'); void pv.offsetWidth; pv.classList.add('on');
    const prev = pv.querySelector('canvas.prev'), pc = prev.getContext('2d'); pc.imageSmoothingEnabled = false; const desenha = () => { try { L.previa?.(pc, prev.width, prev.height, performance.now() / 1000); } catch (e) {} if (!ok) { pc.fillStyle = 'rgba(10,8,6,.55)'; pc.fillRect(0, 0, prev.width, prev.height); } }; desenha(); previaTimer = setInterval(desenha, 120);
  }
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
  function loop(now) {
    if (!aberto) return; raf = requestAnimationFrame(loop); const dt = Math.max(0, Math.min(.05, (now - last) / 1000)); last = now; tempo += dt; resize();
    const W = cv.width, H = cv.height;
    if (anim) { anim.t += dt; const u = anim.f(Math.max(0, Math.min(1, anim.t / anim.dur))); cam.x = anim.de.x + (anim.para.x - anim.de.x) * u; cam.y = anim.de.y + (anim.para.y - anim.de.y) * u; cam.z = anim.de.z + (anim.para.z - anim.de.z) * u; if (anim.t >= anim.dur) anim = null; }
    let veic = null; if (viagem) { const v = viagem; v.t += dt; const u = ease(Math.min(1, v.t / v.dur)); veic = pontoRota(v, u); const p2 = pontoRota(v, ease(Math.min(1, v.t / v.dur + .02))); veic.dir = p2.x >= veic.x ? 1 : -1;
      cam.x += (veic.x - cam.x) * Math.min(1, dt * 5); cam.y += (veic.y - cam.y) * Math.min(1, dt * 5); cam.z += (Math.min(zMax, 3.2) - cam.z) * Math.min(1, dt * 2);
      if (v.t > v.dur - .4) ui.querySelector('.fade').style.opacity = 1; if (v.t >= v.dur + .2) { const id = v.id; viagem = null; fechar(); setTimeout(() => def.aoIr?.(id), 60); return; } }
    limitar();
    c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false; c.fillStyle = '#16243a'; c.fillRect(0, 0, W, H);
    const z = cam.z, ox = Math.round(W / 2 - cam.x * z), oy = Math.round(H / 2 - cam.y * z); c.setTransform(z, 0, 0, z, ox, oy);
    c.drawImage(M.base, 0, 0);
    const P = Px(c), R = P.R;
    for (let k = 0; k < M.agua.length; k += 2) { const [x, y] = M.agua[k], ph = (tempo * .8 + hash(x, y) * 5) % 5; if (ph < .7) R(x * TS + 3 + hash(y, x) * 8, y * TS + 6 + hash(x * 2, y) * 6, 4 - ph * 4, 1, '#e2f4ff'); } // brilho na água
    def.animarChao?.(P, tempo);
    c.drawImage(M.obj, 0, 0);
    const ordem = M.locs.map((L, i) => i).sort((a, b) => (M.locs[a].by + M.locs[a].bh) - (M.locs[b].by + M.locs[b].bh));
    for (const i of ordem) { const L = M.locs[i]; let sx = 1, sy = 1; if (L.pulo !== null) { L.pulo += dt; const k = L.pulo, y = k < 1 ? Math.sin(k * 15) * Math.exp(-k * 4.5) * .22 : 0; sy = 1 + y; sx = 1 - y * .6; if (k >= 1) L.pulo = null; }
      if (i === sel) { c.save(); c.globalAlpha = .35 + Math.sin(tempo * 5) * .15; c.fillStyle = '#fff6c0'; const r = Math.max(L.bw, L.bh) * .62; c.beginPath(); c.ellipse(L.bx + L.bw / 2, L.by + L.bh - 4, r, r * .35, 0, 0, Math.PI * 2); c.fill(); c.restore(); }
      c.save(); c.translate(L.bx + L.bw / 2, L.by + L.bh); c.scale(sx, sy); c.drawImage(L.s, -L.bw / 2, -L.bh); c.restore(); }
    def.animar?.(P, tempo, dt);
    faiscas = faiscas.filter((f) => { f.t += dt; f.vy += 160 * dt; f.x += f.vx * dt; f.y += f.vy * dt; R(f.x, f.y, 2, 2, f.cor); return f.t < .9; });
    if (veic) { c.globalAlpha = .3; P.circ(veic.x, veic.y + 3, 10, '#000', 3); c.globalAlpha = 1; c.save(); c.translate(Math.round(veic.x), Math.round(veic.y - veic.alt)); if (veic.dir < 0) c.scale(-1, 1); def.veiculo?.(P, tempo); c.restore(); }
    for (let k = 0; k < 5; k++) { const nx = ((tempo * 8 + k * 260) % (M.W + 300)) - 150, ny = 60 + k * (M.H / 5); c.globalAlpha = .1; P.circ(nx + 24, ny + 46, 34, '#0c1a30', 12); c.globalAlpha = .55; P.circ(nx, ny, 26, '#ffffff', 9); P.circ(nx + 18, ny - 4, 18, '#ffffff', 8); P.circ(nx - 14, ny + 2, 14, '#ffffff', 6); c.globalAlpha = 1; } // nuvens e a sombra delas
    c.setTransform(1, 0, 0, 1, 0, 0);
    def.locais.forEach((L, i) => { const lo = M.locs[i], sx = ox + (lo.bx + lo.bw / 2) * z, sy = oy + lo.by * z; if (sx < -100 || sx > W + 100 || sy < -60 || sy > H + 80) return; const b = Math.round(Math.sin(tempo * 3 + i) * 3), ativo = i === sel;
      placaNome(sx, sy - 6 + b, (L.atual ? '● ' : '') + L.nome, L.estado?.ok === false ? 'bloq' : L.atual ? 'atual' : 'ok', ativo);
      if (ativo) { c.fillStyle = '#ffd24a'; const ay = sy - 34 + Math.round(Math.sin(tempo * 6) * 4); c.beginPath(); c.moveTo(sx - 8, ay - 10); c.lineTo(sx + 8, ay - 10); c.lineTo(sx, ay); c.fill(); } });
  }

  window.Mapa3D = Object.freeze({ abrir, fechar, aberto: () => aberto, selecionar: (id) => { const i = def?.locais.findIndex((L) => L.id === id) ?? -1; if (i >= 0) selecionar(i); }, ir, info: mostrarInfo, arte: { Px, COR, shade, hash, TS } });
})();
