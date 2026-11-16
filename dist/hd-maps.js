/* Mapas da campanha no novo padrão de arte (fase 2). Pronto: 0 (A Roça).
   - Tudo em pixels de arte (480x270 ampliado 2x, sem filtro), com camadas de parallax.
   - Os objetos ficam nos mesmos lugares do mapa antigo (casas, cercas, placas, plantação),
     então portas, missões e colisões continuam valendo.
   - O cenário recebe a luz da hora do dia aqui mesmo; os personagens não são alterados.
   - No modo Leve vale a arte antiga. */
(() => {
  'use strict';
  if (window.HdMaps) return;
  const LW = 482, LH = 270, FLOOR = 220;
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const cl = (v) => Math.max(0, Math.min(1, v));
  const css = (v, a) => { const s = `${Math.round(cl(v[0]) * 255)},${Math.round(cl(v[1]) * 255)},${Math.round(cl(v[2]) * 255)}`; return a === undefined ? `rgb(${s})` : `rgba(${s},${a})`; };
  const mix = (a, b, k) => [a[0] + (b[0] - a[0]) * k, a[1] + (b[1] - a[1]) * k, a[2] + (b[2] - a[2]) * k];
  function ell(c, cx, cy, rx, ry, col) { c.fillStyle = col; for (let y = Math.ceil(cy - ry); y <= Math.floor(cy + ry); y++) { const t = (y - cy) / ry, w = rx * Math.sqrt(Math.max(0, 1 - t * t)); const xa = Math.round(cx - w), xb = Math.round(cx + w); c.fillRect(xa, y, Math.max(1, xb - xa), 1); } }
  // faixa de transição pontilhada entre duas cores (dithering)
  function dither(c, x, y, w, col) { c.fillStyle = col; for (let i = (Math.round(y) & 1); i < w; i += 2) c.fillRect(Math.round(x) + i, Math.round(y), 1, 1); }
  const [low, lc] = mk(LW, LH), [lightCv, lg] = mk(LW, LH);
  const worldW = (scene) => Math.ceil((Number(window.WorldData?.widths?.[scene]) || 4800) / 2);

  // ------------------------------------------------------------------------------- céu
  const [skyCv, sk] = mk(LW, 196); let skyH = -99;
  function sky(c, s, t, camL, arc = {}) {
    const am = arc.amb || s.amb, pre = (v) => [v[0] / am[0], v[1] / am[1], v[2] / am[2]];
    if (Math.abs(s.h - skyH) > .012) { skyH = s.h; const N = 14, bh = 14; for (let i = 0; i < N; i++) { const k = i / (N - 1), col = css(pre(mix(s.top, s.bot, k * k * .45 + k * .55))); R(sk, 0, i * bh, LW, bh, col); if (i) { dither(sk, 0, i * bh - 1, LW, col); for (let x = 1; x < LW; x += 4) sk.fillRect(x, i * bh - 2, 1, 1); } } }
    c.drawImage(skyCv, 0, 0);
    if (s.night > .25) for (let i = 0; i < 90; i++) { const tw = .5 + .5 * Math.sin(t * (1 + hash(i) * 2) + i); c.fillStyle = `rgba(255,255,255,${cl((s.night - .25) * 1.4 * (.35 + .65 * tw) * (.4 + hash(i + 9) * .6))})`; c.fillRect(Math.round(((hash(i + 300) * 560 - camL * .01) % LW + LW) % LW), Math.round(hash(i + 400) * 120), 1, 1); }
    if (s.sunT !== null) { const x = 40 + s.sunT * 400 - camL * .012, y = (arc.sb || 168) - Math.sin(s.sunT * Math.PI) * (arc.sa || 128); ell(c, x, y, 26, 26, css(pre(s.sun), .12)); ell(c, x, y, 19, 19, css(pre(s.sun), .22)); ell(c, x, y, 13, 13, css(pre(mix(s.sun, [1, 1, 1], .55)))); }
    if (s.moonT !== null) { const x = 50 + s.moonT * 380 - camL * .012, y = (arc.mb || 150) - Math.sin(s.moonT * Math.PI) * (arc.ma || 108); ell(c, x, y, 16, 16, 'rgba(200,215,255,.14)'); ell(c, x, y, 9, 9, '#ffffff'); R(c, x - 4, y - 3, 3, 3, '#dfe6ff'); R(c, x + 2, y + 3, 3, 2, '#dfe6ff'); R(c, x + 3, y - 5, 2, 2, '#dfe6ff'); }
    const cloud = pre(mix(mix(s.bot, [1, 1, 1], .7 * (1 - s.night) + .1), s.top, s.night * .45)), shade = [cloud[0] * .86, cloud[1] * .89, cloud[2] * .96];
    for (let i = 0; i < 7; i++) { const x = ((hash(i + 20) * 700 + t * (1.5 + hash(i) * 2.5) - camL * .05) % 640 + 640) % 640 - 90, y = 16 + hash(i + 30) * 86, w = 34 + hash(i + 31) * 34; R(c, x, y, w, 5, css(cloud)); R(c, x + 5, y - 4, w - 13, 4, css(cloud)); R(c, x + 11, y - 7, w * .42, 3, css(cloud)); R(c, x + w * .55, y - 6, w * .22, 2, css(cloud)); R(c, x + 3, y + 5, w - 8, 2, css(shade)); R(c, x + 9, y + 7, w - 22, 1, css(shade)); }
  }

  // ------------------------------------------------------------------------------- serras (parallax)
  const TILE = 960;
  const ridge = (x, seed, amp) => { const a = x / TILE * Math.PI * 2; return (Math.sin(a * 2 + seed) * .5 + Math.sin(a * 5 + seed * 2.3) * .28 + Math.sin(a * 11 + seed * 4.1) * .14 + Math.sin(a * 23 + seed) * .06) * amp; };
  let far = null;
  function buildFar() {
    const A = mk(TILE, 196), B = mk(TILE, 196), C = mk(TILE, 196);
    for (let x = 0; x < TILE; x++) { // serra distante, azulada pela névoa
      const y = Math.round(96 + ridge(x, 1.3, 26)); R(A[1], x, y, 1, 196 - y, '#a7c8d0'); R(A[1], x, y, 1, 1, '#c6dfe2'); if (hash(x * 3) > .6) R(A[1], x, y + 2 + hash(x) * 14, 1, 2, '#9bbdc6');
      for (let yy = y + 30; yy < 196; yy += 2) if (((x + yy) & 3) === 0) R(A[1], x, yy, 1, 1, '#b9d6d8');
    }
    for (let x = 0; x < TILE; x++) { // morros com mata
      const y = Math.round(128 + ridge(x, 4.1, 20)); R(B[1], x, y, 1, 196 - y, '#7fb098'); R(B[1], x, y, 1, 1, '#9cc8ad');
      if (hash(x * 7 + 1) > .45) { const h = 2 + Math.round(hash(x * 5) * 4); R(B[1], x, y - h + 1, 1, h, '#5f957c'); }
      for (let k = 0; k < 3; k++) if (hash(x * 13 + k) > .82) R(B[1], x, y + 4 + hash(x + k * 7) * 40, 2, 1, '#6fa48b');
    }
    for (let i = 0; i < 9; i++) { const x = Math.round(hash(i + 800) * (TILE - 20)), y = Math.round(128 + ridge(x, 4.1, 20)) + 6 + Math.round(hash(i + 810) * 18); R(B[1], x, y, 7, 5, '#f2ead6'); R(B[1], x - 1, y - 3, 9, 3, '#c9634a'); R(B[1], x, y - 4, 7, 1, '#a94e3a'); R(B[1], x + 3, y + 2, 2, 3, '#6a5444'); }
    for (let x = 0; x < TILE; x++) { // colinas próximas com roças em retalhos
      const y = Math.round(156 + ridge(x, 7.7, 13)); R(C[1], x, y, 1, 196 - y, '#5f9e62'); R(C[1], x, y, 1, 1, '#8cc477'); R(C[1], x, y + 1, 1, 1, '#74b06c');
    }
    const PATCH = ['#7bb356', '#93c05a', '#d9c46a', '#56925a', '#a8c860', '#c9a85a'];
    for (let i = 0; i < 46; i++) { const x = Math.round(hash(i + 900) * (TILE - 60)), y0 = Math.round(156 + ridge(x + 20, 7.7, 13)) + 6 + Math.round(hash(i + 910) * 22), w = 22 + Math.round(hash(i + 920) * 30), h = 5 + Math.round(hash(i + 930) * 7), col = PATCH[i % 6];
      for (let r = 0; r < h; r++) R(C[1], x + r, y0 + r, w, 1, col); for (let r = 0; r < h; r += 2) for (let k = 2; k < w; k += 3) R(C[1], x + r + k, y0 + r, 1, 1, 'rgba(40,70,40,.28)'); R(C[1], x, y0, w, 1, 'rgba(255,255,220,.25)'); }
    for (let i = 0; i < 70; i++) { const x = Math.round(hash(i + 1000) * (TILE - 12)), y = Math.round(156 + ridge(x, 7.7, 13)) + 2 + Math.round(hash(i + 1010) * 30), r = 3 + Math.round(hash(i + 1020) * 3); ell(C[1], x, y, r + 1, r, '#356f44'); ell(C[1], x - 1, y - 1, r, r - 1, '#468a4e'); R(C[1], x - 2, y - 2, 2, 1, '#6fb062'); }
    for (let i = 0; i < 14; i++) { const x = Math.round(hash(i + 1100) * (TILE - 10)), y = Math.round(156 + ridge(x, 7.7, 13)) + 12 + Math.round(hash(i + 1110) * 22); R(C[1], x, y, 4, 2, i % 3 ? '#f4f0e4' : '#6a4a3a'); R(C[1], x + 4, y - 1, 2, 2, i % 3 ? '#f4f0e4' : '#6a4a3a'); R(C[1], x + 1, y, 1, 1, '#2c2c2c'); R(C[1], x, y + 2, 1, 1, '#3a3a3a'); R(C[1], x + 3, y + 2, 1, 1, '#3a3a3a'); }
    // relevo: encostas viradas para o sol clareiam, as de trás escurecem
    const relief = (seed, amp, baseY, depth, side) => { const [cv, c] = mk(TILE, 196); for (let x = 0; x < TILE; x++) { const y = Math.round(baseY + ridge(x, seed, amp)), slope = ridge(x + 3, seed, amp) - ridge(x - 3, seed, amp), lit = slope * side > .12, dark = slope * side < -.12; if (!lit && !dark) continue; const k = Math.min(1, Math.abs(slope) / 1.2); for (let d = 0; d < depth; d++) { const f = 1 - d / depth; if (f < .5 && ((x + d) & 1)) continue; c.fillStyle = lit ? `rgba(255,244,196,${.42 * k * f})` : `rgba(18,34,70,${.36 * k * f})`; c.fillRect(x, y + d, 1, 1); } } return cv; };
    const P = [[1.3, 26, 96, 34], [4.1, 20, 128, 26], [7.7, 13, 156, 16]];
    return [A[0], B[0], C[0], P.map((p) => relief(p[0], p[1], p[2], p[3], -1)), P.map((p) => relief(p[0], p[1], p[2], p[3], 1))];
  }
  function tile(c, img, off) { const o = ((Math.round(off) % TILE) + TILE) % TILE; c.drawImage(img, -o, 0); if (TILE - o < LW) c.drawImage(img, TILE - o, 0); }

  // ------------------------------------------------------------------------------- peças da Roça
  function fence(c, x, w) { const y = 212;
    for (const ry of [195, 203]) { R(c, x, ry, w, 3, '#6c6945'); R(c, x, ry, w, 1, '#b7ab70'); R(c, x, ry + 3, w, 1, 'rgba(30,40,20,.25)'); }
    for (let xx = x; xx < x + w; xx += 16.5) { R(c, xx, y - 24, 4, 24, '#756c48'); R(c, xx, y - 24, 1, 24, '#a38e5e'); R(c, xx + 3, y - 24, 1, 24, '#544d33'); R(c, xx, y - 25, 4, 1, '#c1ae76'); R(c, xx + 1, y - 17, 1, 1, '#3d3826'); R(c, xx + 1, y - 9, 1, 1, '#3d3826'); if (hash(xx) > .7) { R(c, xx - 1, y - 3, 1, 3, '#4f9a3f'); R(c, xx + 4, y - 4, 1, 4, '#6fb24a'); } } }
  function house(c, x) { const b = 215;
    c.fillStyle = 'rgba(20,40,20,.22)'; c.fillRect(x - 6, b - 1, 106, 3);
    R(c, x, b - 56, 91, 56, '#efd5a0'); for (let i = 0; i < 260; i++) R(c, x + hash(i + x) * 90, b - 55 + hash(i + x + 3) * 40, 1, 1, hash(i) > .5 ? '#e3c890' : '#f8e4b8'); R(c, x + 80, b - 56, 11, 56, 'rgba(120,90,60,.16)');
    for (let i = 0; i < 6; i++) { let cx2 = x + 8 + hash(i + x + 9) * 70, cy2 = b - 50 + hash(i + x + 11) * 22; for (let k = 0; k < 5; k++) { R(c, cx2, cy2, 1, 1, '#c9ac78'); cx2 += hash(i * 7 + k) > .5 ? 1 : 0; cy2 += 1; } }
    R(c, x, b - 14, 91, 14, '#b8946a'); for (let r2 = 0; r2 < 3; r2++) for (let k = -1; k < 12; k++) { const sx = x + k * 9 + (r2 % 2) * 4; if (sx + 8 < x || sx > x + 90) continue; R(c, Math.max(x, sx), b - 13 + r2 * 4.5, Math.min(8, x + 91 - Math.max(x, sx)), 4, ['#c4a074', '#ab8960', '#d1ad79'][(k + r2 * 2 + 9) % 3]); } R(c, x, b - 15, 91, 1, '#f6e2b4');
    R(c, x - 3, b - 56, 4, 56, '#795846'); R(c, x - 3, b - 56, 1, 56, '#9a765c'); R(c, x + 90, b - 56, 4, 56, '#5f4435');
    // telhado de telhas
    for (let r2 = 0; r2 < 11; r2++) { const k = r2 / 10, xa = x + 8 - k * 18, xb = x + 78 + k * 24, yy = b - 78 + r2 * 2; R(c, xa, yy, xb - xa, 2, r2 % 2 ? '#c96545' : '#d9774d'); for (let xx = xa + (r2 % 2) * 3; xx < xb - 1; xx += 6) { R(c, xx, yy, 1, 2, '#f0a56d'); R(c, xx + 5, yy, 1, 2, '#8f4739'); } }
    R(c, x + 6, b - 80, 74, 2, '#8f4739'); R(c, x + 6, b - 80, 74, 1, '#e8936a'); R(c, x - 11, b - 57, 115, 3, '#7b4737'); R(c, x - 11, b - 57, 115, 1, '#d18b59'); c.fillStyle = 'rgba(60,40,30,.28)'; c.fillRect(x, b - 54, 91, 3); c.fillRect(x + 2, b - 51, 87, 1);
    R(c, x + 62, b - 92, 9, 16, '#a9684f'); R(c, x + 62, b - 92, 2, 16, '#c98a6c'); R(c, x + 61, b - 94, 11, 3, '#7b4737'); for (let k = 0; k < 3; k++) R(c, x + 63 + (k % 2) * 3, b - 89 + k * 4, 4, 1, '#8a5440');
    // porta
    R(c, x + 36, b - 37, 21, 37, '#6a4c30'); R(c, x + 37, b - 36, 19, 36, '#886641'); for (let k = 0; k < 4; k++) { R(c, x + 38 + k * 4.5, b - 35, 4, 35, k % 2 ? '#7a5a3a' : '#8f6c46'); R(c, x + 38 + k * 4.5, b - 35, 1, 35, '#a07a50'); } R(c, x + 38, b - 26, 17, 2, '#5a4028'); R(c, x + 38, b - 10, 17, 2, '#5a4028'); R(c, x + 52, b - 19, 2, 2, '#e4ba73'); R(c, x + 34, b, 25, 2, '#b9b0a0'); R(c, x + 34, b, 25, 1, '#dcd4c4');
    R(c, x + 60, b - 40, 3, 5, '#3a3a3a'); R(c, x + 60, b - 39, 3, 3, '#ffe9a8'); // lampião da varanda
    // janelas com venezianas e floreira
    for (const wx of [x + 7, x + 66]) { R(c, wx - 1, b - 41, 21, 21, '#7a5536'); R(c, wx, b - 40, 19, 19, '#ac7c52'); R(c, wx + 2, b - 38, 15, 15, '#42595a'); R(c, wx + 2, b - 38, 15, 6, '#5a7a7a'); for (let k = 0; k < 6; k++) R(c, wx + 4 + k, b - 37 + k, 3, 1, 'rgba(255,255,255,.22)'); R(c, wx + 9, b - 38, 1, 15, '#c19969'); R(c, wx + 2, b - 31, 15, 1, '#c19969');
      for (const sx of [wx - 5, wx + 19]) { R(c, sx, b - 40, 5, 19, '#3f7a52'); R(c, sx, b - 40, 1, 19, '#5a9c6c'); for (let k = 0; k < 6; k++) R(c, sx + 1, b - 38 + k * 3, 3, 1, '#2c5a3c'); }
      R(c, wx - 3, b - 21, 25, 4, '#8a5a3a'); R(c, wx - 3, b - 21, 25, 1, '#b07a50'); for (let k = 0; k < 7; k++) { R(c, wx - 2 + k * 3.5, b - 24 - (k % 2), 3, 3, '#4f9a3f'); R(c, wx - 1 + k * 3.5, b - 26 - (k % 2), 2, 2, ['#e04a4a', '#f2d24a', '#f08ab0'][k % 3]); } }
    // barril, lenha e caminho de terra
    R(c, x + 97, b - 13, 9, 13, '#8a6238'); R(c, x + 97, b - 13, 2, 13, '#a87a48'); R(c, x + 97, b - 10, 9, 1, '#4a4a4a'); R(c, x + 97, b - 4, 9, 1, '#4a4a4a'); R(c, x + 97, b - 14, 9, 1, '#5a4028');
    for (let k = 0; k < 5; k++) { ell(c, x - 12 + (k % 3) * 4 + (k > 2 ? 2 : 0), b - 2 - (k > 2 ? 4 : 0), 2, 2, '#8a6238'); R(c, x - 13 + (k % 3) * 4 + (k > 2 ? 2 : 0), b - 3 - (k > 2 ? 4 : 0), 1, 1, '#d9b98a'); }
    for (let r2 = 0; r2 < 5; r2++) { R(c, x + 36 - r2 * 2, b + r2, 21 + r2 * 4, 1, r2 % 2 ? '#b99262' : '#c4a074'); }
  }
  function sign(c, x, w, h, y, arrow) { R(c, x + w / 2 - 2, y, 4, 216 - y, '#6a583d'); R(c, x + w / 2 - 2, y, 1, 216 - y, '#8a7654'); R(c, x - 1, y - 1, w + 2, h + 2, '#4f3a28'); R(c, x, y, w, h, '#c6ab70'); R(c, x, y, w, 1, '#e6cf98'); R(c, x, y + h - 1, w, 1, '#9a8352'); for (const [nx, ny] of [[x + 1, y + 1], [x + w - 2, y + 1], [x + 1, y + h - 2], [x + w - 2, y + h - 2]]) R(c, nx, ny, 1, 1, '#5a4a30');
    if (arrow) { const axx = x + w - 9, ay = y + Math.floor(h / 2); R(c, axx, ay, 5, 1, '#4c4c36'); R(c, axx + 3, ay - 1, 1, 3, '#4c4c36'); R(c, axx + 2, ay - 2, 1, 5, '#4c4c36'); } }
  function stand(c, x) { R(c, x - 2, 196, 82, 3, '#d0a96c'); R(c, x - 2, 196, 82, 1, '#ecd09a'); R(c, x, 199, 78, 20, '#5a4a30'); for (let i = 0; i < 6; i++) { const cx2 = x + 2 + i * 12.5; R(c, cx2, 201, 10, 17, '#a27a49'); R(c, cx2, 201, 10, 1, '#d3a960'); R(c, cx2, 207, 10, 1, '#7a5a34'); R(c, cx2, 212, 10, 1, '#7a5a34'); R(c, cx2, 201, 1, 17, '#c49a5c'); const col = ['#e8842a', '#d83a3a', '#5aa83a', '#e8c83a', '#8a4aa8', '#e8842a'][i]; for (let k = 0; k < 4; k++) { R(c, cx2 + 1 + k * 2.2, 193 - (k % 2), 2, 3, col); R(c, cx2 + 1 + k * 2.2, 193 - (k % 2), 1, 1, 'rgba(255,255,255,.5)'); } }
    R(c, x - 4, 172, 2, 47, '#6a583d'); R(c, x + 80, 172, 2, 47, '#6a583d'); for (let k = 0; k < 86; k += 6) { R(c, x - 5 + k, 168, 6, 6, (k / 6) % 2 ? '#d9483b' : '#f3ead6'); R(c, x - 5 + k, 174, 6, 2, (k / 6) % 2 ? '#a8362e' : '#cfc5ae'); } R(c, x - 5, 167, 87, 1, '#fff6e0'); }
  function hay(c, x) { R(c, x, 205, 34, 12, '#a77c45'); R(c, x - 1, 202, 36, 4, '#dfbd6c'); R(c, x - 1, 202, 36, 1, '#f4dc92'); for (let k = 0; k < 34; k += 3) R(c, x + k, 206 + (k % 2), 1, 10, '#c79a56'); R(c, x, 209, 34, 1, '#8a6238'); R(c, x, 214, 34, 1, '#8a6238'); for (let k = 0; k < 6; k++) R(c, x + hash(k + x) * 32, 200, 1, 2, '#f4dc92'); }
  function bush(c, x, w) { const r = w / 4; ell(c, x, 212, r * 2, 8, '#2f5f38'); ell(c, x - r * .6, 209, r * 1.2, 8, '#3f8045'); ell(c, x + r * .7, 208, r * 1.1, 7, '#4a914c'); ell(c, x - r * .8, 206, r * .6, 4, '#68ad58'); for (let i = 0; i < 9; i++) R(c, x - r * 1.6 + hash(i + x) * r * 3.2, 202 + hash(i + x + 5) * 10, 1, 1, i % 3 ? '#8fcf6a' : '#e86a8a'); }

  // camada fixa do mapa inteiro
  const mids = {};
  function buildFarmMid() {
    const W = worldW(0), [cv, c] = mk(W, LH);
    // roça ao fundo: faixas de plantio
    R(c, 0, 184, W, 3, '#57923f'); R(c, 0, 187, W, 9, '#68a34b'); R(c, 0, 196, W, 24, '#80b751'); dither(c, 0, 186, W, '#68a34b'); dither(c, 0, 195, W, '#80b751'); R(c, 0, 184, W, 1, '#9ccc68');
    for (let i = 0; i < W / 3; i++) { const x = hash(i + 50) * W, y = 188 + hash(i + 51) * 30; if (y > 218) continue; R(c, x, y, 2 + hash(i) * 5, 1, hash(i + 3) > .5 ? '#6fa848' : '#92c860'); }
    for (let i = 0; i < W / 22; i++) { const x = hash(i + 70) * W, y = 198 + hash(i + 71) * 18; R(c, x, y - 2, 1, 3, '#3e863d'); R(c, x + 1, y - 3, 1, 4, '#58a046'); R(c, x + 2, y - 1, 1, 2, '#3e863d'); if (i % 4 === 0) { R(c, x + 4, y - 3, 2, 2, ['#efcf71', '#e86a8a', '#ffffff'][i % 3]); R(c, x + 4, y - 1, 1, 2, '#456841'); } }
    // chão: grama, terra em camadas, pedras e raízes
    R(c, 0, FLOOR, W, 50, '#a17349'); R(c, 0, 232, W, 18, '#93673f'); R(c, 0, 250, W, 20, '#825a36'); dither(c, 0, 231, W, '#93673f'); dither(c, 0, 230, W, '#93673f'); dither(c, 0, 249, W, '#825a36'); dither(c, 0, 248, W, '#825a36');
    for (let i = 0; i < W / 2; i++) { const x = hash(i + 90) * W, y = 226 + hash(i + 91) * 43; R(c, x, y, 1 + hash(i) * 3, 1, hash(i + 2) > .5 ? '#b68b54' : '#7a5230'); }
    for (let i = 0; i < W / 14; i++) { const x = hash(i + 110) * W, y = 230 + hash(i + 111) * 36, r = 1.5 + hash(i + 112) * 2.5; ell(c, x, y, r + 1, r, '#6a5a48'); ell(c, x, y - .5, r, r - .5, '#b5a58c'); R(c, x - 1, y - 1, 1, 1, '#e0d4bc'); }
    for (let i = 0; i < W / 60; i++) { let x = hash(i + 130) * W, y = 226; for (let k = 0; k < 9 + hash(i) * 8; k++) { R(c, x, y, 1, 1, '#6a4a2c'); x += hash(i * 5 + k) > .5 ? 1 : -1; y += 1; } }
    R(c, 0, FLOOR, W, 2, '#a6d055'); R(c, 0, FLOOR + 2, W, 3, '#3f7f35'); R(c, 0, FLOOR + 5, W, 2, '#736a3a');
    for (let x = 0; x < W; x++) { const h = hash(x * 3 + 7); if (h > .55) R(c, x, FLOOR + 5, 1, 1 + Math.round(h * 3), '#3f7f35'); if (h < .2) R(c, x, FLOOR - 1, 1, 1, '#c6e870'); }
    // objetos nos lugares do mapa original
    for (const [x, w] of FARM_FENCES) fence(c, x, w);
    for (let x = 1295, i = 0; x < W; x += 122.5, i++) { if (i % 3 !== 0) bush(c, x + 72, 42); if (i % 3 === 1) hay(c, x + 5); }
    house(c, 66); house(c, 1752);
    R(c, 175, 181, 2, 34, '#79664a'); R(c, 243, 178, 2, 37, '#79664a'); R(c, 175, 181, 1, 34, '#9a8462'); // postes do varal
    stand(c, 985);
    sign(c, 303, 60, 15, 183, true); sign(c, 2136, 50, 25, 176, false);
    return cv;
  }
  // árvores (desenhadas ao vivo para balançar com o vento)
  function tree(c, x, base, s, kind, t, seed, lean = 1) {
    if (kind === 1) { // coqueiro
      for (let k = 0; k < 42 * s; k++) { const px = x + Math.round(k * .08 * s), py = base - k; R(c, px - 2, py, 5, 1, k % 5 === 0 ? '#5f4530' : '#79553b'); R(c, px - 2, py, 1, 1, '#98704b'); }
      const tx = x + Math.round(42 * .08 * s * s), ty = base - Math.round(42 * s), sw = Math.sin(t * 1.4 + seed) * 1.5;
      for (let i = 0; i < 8; i++) { const a = -Math.PI + .2 + i * .39, len = 30 * s; for (let k = 0; k <= len; k++) { const u = k / len, px = tx + Math.cos(a) * k + sw * u, py = ty + Math.sin(a) * k * .55 + u * u * 16 * s; R(c, px, py, 2, 1, i % 2 ? '#367c42' : '#64a147'); if (k % 2 === 0) R(c, px, py + 1, 1, 2 + Math.round(u * 3), i % 2 ? '#2c6838' : '#4f8f3f'); } }
      ell(c, tx - 1, ty + 2, 2, 2, '#5a3f2a'); ell(c, tx + 3, ty + 3, 2, 2, '#6a4a30'); return;
    }
    const th = 46 * s; R(c, x - 4 * s, base - th, 8 * s, th, '#674c36'); R(c, x - 4 * s, base - th, 2 * s, th, '#896241'); R(c, x + 2 * s, base - th, 2 * s, th, '#4f3a29'); for (let k = 0; k < 6; k++) R(c, x - 2 * s + hash(k + seed) * 4 * s, base - 6 - k * 7 * s, 1, 3, '#4f3a29');
    R(c, x - 6 * s, base - 2, 12 * s, 2, '#5a4230'); R(c, x - 9 * s, base - 30 * s, 6 * s, 3, '#674c36'); R(c, x + 4 * s, base - 36 * s, 8 * s, 3, '#674c36');
    const CL = [[0, -58, 19], [-18, -50, 15], [18, -52, 15], [-9, -70, 15], [11, -72, 14], [0, -82, 13], [-25, -62, 11], [25, -64, 11]];
    const sway = (i) => Math.round(Math.sin(t * 1.3 + seed + i * 1.7) * 1.4);
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i), base + p[1] * s + 3, p[2] * s, p[2] * s * .92, '#2a5f36'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i), base + p[1] * s, p[2] * s, p[2] * s * .9, '#3f8a45'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i) - lean * 4 * s, base + p[1] * s - 4 * s, p[2] * s * .62, p[2] * s * .5, '#56a64c'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i) - lean * 7 * s, base + p[1] * s - 7 * s, p[2] * s * .3, p[2] * s * .2, '#7cc85a'));
    for (let i = 0; i < 46; i++) { const p = CL[i % 8], a = hash(i + seed) * 6.28, r = hash(i + seed + 3) * p[2] * s * .85, px = x + p[0] * s + Math.cos(a) * r + sway(i % 8), py = base + p[1] * s + Math.sin(a) * r * .9; R(c, px, py, 2, 1, i % 3 ? '#2f6b3c' : '#8fd468'); if (i % 9 === 0) { R(c, px, py + 1, 2, 2, '#f0a030'); R(c, px, py + 1, 1, 1, '#ffd070'); } }
  }
  const FARM_TREES = [[26, 212, 1.25, 0], [267, 212, .78, 1], [397, 212, 1.12, 0], [695, 213, 1.2, 1], [905, 214, 1.2, 0], [1220, 215, 1.3, 0]];
  { for (let x = 1295, i = 0; x < 2400; x += 122.5, i++) if (i % 3 === 0) FARM_TREES.push([x + 74, 215, .8 + (i % 2) * .2, i % 2]); }
  const FARM_HOUSES = [66, 1752];
  const FARM_FENCES = [[0, 56], [166, 157], [393, 107], [540, 210], [785, 340]]; { for (let x = 1295; x < 2400; x += 122.5) FARM_FENCES.push([x, 111]); }
  // sol: de que lado vem a luz (lean > 0 = luz da esquerda, sombras para a direita) e com que força
  function sunInfo(s) { const T = s.sunT !== null ? s.sunT : s.moonT; if (T === null) return { lean: 0, str: 0 }; return { lean: (0.5 - T) * 2, str: s.sunT !== null ? cl(Math.sin(s.sunT * Math.PI) * 1.4 + .15) : .3 * Math.sin(s.moonT * Math.PI) }; }
  function slant(c, x0, x1, y0, dx, h, col) { c.fillStyle = col; for (let r = 0; r < h; r++) c.fillRect(Math.round(x0 + dx * (r + 1) / h), y0 + r, Math.max(1, Math.round(x1 - x0)), 1); }

  function farm(c, s, t, camL) {
    if (!far) far = buildFar(); if (!mids[0]) mids[0] = buildFarmMid();
    sky(c, s, t, camL);
    const sun = sunInfo(s), lean = sun.lean, la = Math.min(1, Math.abs(lean) * 1.3) * sun.str, rel = far[lean >= 0 ? 3 : 4];
    [.04, .1, .22].forEach((p, i) => { tile(c, far[i], camL * p); if (la > .03) { c.globalAlpha = la; tile(c, rel[i], camL * p); c.globalAlpha = 1; } });
    for (const hx of FARM_HOUSES) { const x = hx - camL + 66; if (x < -30 || x > LW + 30) continue; for (let i = 0; i < 6; i++) { const k = (t * .22 + i / 6) % 1; c.fillStyle = `rgba(235,235,230,${(1 - k) * .5})`; const r = 2 + k * 4; c.fillRect(Math.round(x + Math.sin(t + i * 2) * 3 * k + k * 10 - r / 2), Math.round(119 - k * 34), Math.round(r), Math.round(r * .8)); } }
    c.drawImage(mids[0], camL, 0, LW, LH, 0, 0, LW, LH);
    // sombras projetadas no chão: acompanham o sol (compridas cedo e no fim da tarde)
    if (sun.str > .04) { const sh = `rgba(18,30,52,${.30 * sun.str})`, reach = lean * (14 + Math.abs(lean) * 26);
      for (const hx of FARM_HOUSES) { const x = hx - camL; if (x > -160 && x < LW + 160) slant(c, x - 3, x + 94, 215, reach * 1.6, 5, sh); }
      { const x = 985 - camL; if (x > -160 && x < LW + 160) slant(c, x - 4, x + 82, 219, reach, 3, sh); }
      for (const [fx, fw] of FARM_FENCES) { if (fx - camL > LW + 40 || fx + fw - camL < -40) continue; for (let xx = fx; xx < fx + fw; xx += 16.5) slant(c, xx - camL, xx - camL + 3, 212, reach * .7, 4, sh); slant(c, fx - camL, fx + fw - camL, 214, reach * .5, 2, `rgba(18,30,52,${.14 * sun.str})`); }
      for (const [tx, base, sc, kind] of FARM_TREES) { const x = tx - camL; if (x < -120 || x > LW + 120) continue; slant(c, x - 2, x + 3, base, reach * .8, 5, sh); ell(c, x + reach * (kind ? 1.5 : 1.2) * sc, base + 4, (kind ? 16 : 24) * sc, 3.2, sh); } }
    for (const [tx, base, sc, kind] of FARM_TREES) { const x = tx - camL; if (x < -70 || x > LW + 70) continue; tree(c, x, base, sc, kind, t, tx, lean >= 0 ? Math.max(.35, lean) : Math.min(-.35, lean)); }
    // sol batendo nas casas: parede do lado do sol clareia, a outra escurece, e o vidro reflete
    if (sun.str > .04) for (const hx of FARM_HOUSES) { const x = hx - camL; if (x < -120 || x > LW + 20) continue; const a = Math.min(1, Math.abs(lean) * 1.4) * sun.str, litX = lean >= 0 ? x : x + 63, darkX = lean >= 0 ? x + 63 : x;
      for (let k = 0; k < 28; k++) { const f = 1 - k / 28, px = lean >= 0 ? k : 27 - k; if (f < .4 && (k & 1)) continue; c.fillStyle = `rgba(255,240,190,${.30 * a * f})`; c.fillRect(Math.round(litX + px), 159, 1, 56); c.fillStyle = `rgba(30,24,60,${.26 * a * f})`; c.fillRect(Math.round(darkX + 27 - px), 159, 1, 56); }
      for (let r2 = 0; r2 < 11; r2++) { const k = r2 / 10, xa = x + 8 - k * 18, xb = x + 78 + k * 24, half = (xb - xa) * .45; c.fillStyle = `rgba(255,236,180,${.26 * a})`; c.fillRect(Math.round(lean >= 0 ? xa : xb - half), 137 + r2 * 2, Math.round(half), 1); c.fillStyle = `rgba(40,20,50,${.22 * a})`; c.fillRect(Math.round(lean >= 0 ? xb - half : xa), 137 + r2 * 2, Math.round(half), 2); }
      const gl = Math.max(0, 1 - Math.abs(lean) * 1.1) * .2 + Math.min(1, Math.abs(lean) * 1.5) * .75; for (const wx of [x + 9, x + 68]) { const off = Math.round((lean >= 0 ? 0 : 6) + Math.sin(t * .5) * 1); for (let k = 0; k < 9; k++) { c.fillStyle = `rgba(255,252,225,${gl * sun.str * (k < 5 ? .9 : .5)})`; c.fillRect(wx + off + (lean >= 0 ? k : 8 - k) * .6, 177 + k, k < 5 ? 4 : 2, 1); } } }
    // varal
    { const x0 = 176 - camL; if (x0 > -80 && x0 < LW) { R(c, x0, 182, 68, 1, '#706246'); for (let i = 0; i < 4; i++) { const x = x0 + 7 + i * 14.5, col = ['#f0c27c', '#74afb9', '#d57555', '#f2dda2'][i], col2 = ['#d9a85e', '#5a94a0', '#b85c40', '#dcc484'][i]; for (let r = 0; r < 13; r++) { const wv = Math.round(Math.sin(t * 3 + i + r * .25) * (r / 12) * 2.4); R(c, x + wv, 183 + r, 10, 1, r > 9 ? col2 : col); R(c, x + wv, 183 + r, 1, 1, col2); } R(c, x + 1, 182, 1, 2, '#5e6141'); R(c, x + 8, 182, 1, 2, '#5e6141'); } } }
    // milharal
    for (let i = 0; i < 22; i++) { const x = Math.round(467.5 + i * 8.5) - camL; if (x < -10 || x > LW + 10) continue; const y = 211 + (i % 2) * 4, wv = Math.round(Math.sin(t * 2 + i * .2) * 1.3); R(c, x, y - 19, 2, 19, '#497f38'); R(c, x, y - 19, 1, 19, '#6aa850'); for (let k = 0; k < 5; k++) { R(c, x - 1 - k + wv * (k / 4), y - 9 - k, 2, 1, '#438a39'); R(c, x + 2 + k + wv * (k / 4), y - 13 - k, 2, 1, '#8bbb42'); } R(c, x - 1, y - 17, 3, 8, '#e7c94c'); R(c, x - 1, y - 17, 1, 8, '#fff09a'); R(c, x, y - 20 + (wv ? 0 : 0), 2, 3, '#ffe17a'); R(c, x + wv, y - 22, 1, 2, '#d9b84a'); }
    // borboletas
    for (let i = 0; i < 8; i++) { const x = 195 + i * 140 + Math.sin(t * .8 + i) * 13 - camL, y = 175 + Math.sin(t * 1.6 + i * 3) * 8; if (x < -5 || x > LW + 5) continue; const w = Math.round(Math.abs(Math.sin(t * 9 + i)) * 2) + 1; R(c, x - w, y - 1, w, 2, i % 2 ? '#f0ce60' : '#e9a66d'); R(c, x + 1, y - 1, w, 2, i % 2 ? '#ffe5a1' : '#f5bf8c'); R(c, x, y - 1, 1, 3, '#4b6240'); }
  }
  function farmText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#4c4c36'; c.fillText('ITABUNA', 654, 382); c.fillText('TRILHA', 4322, 366); c.fillText('DA ROÇA', 4322, 388); c.restore(); }
  function farmLights(g, s, t, camL) { if (s.night <= .15) return; for (const hx of FARM_HOUSES) { const x = hx - camL; if (x < -140 || x > LW + 60) continue; for (const wx of [16, 75]) { const gr = g.createRadialGradient(x + wx, 184, 2, x + wx, 186, 34); gr.addColorStop(0, `rgba(255,200,110,${.5 * s.night})`); gr.addColorStop(1, 'rgba(255,200,110,0)'); g.fillStyle = gr; g.fillRect(x + wx - 36, 150, 72, 72); g.fillStyle = `rgba(255,226,150,${.9 * s.night})`; g.fillRect(Math.round(x + wx - 7), 177, 15, 15); } const gl = g.createRadialGradient(x + 61, 177, 1, x + 61, 180, 30); gl.addColorStop(0, `rgba(255,220,150,${.8 * s.night})`); gl.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gl; g.fillRect(x + 30, 148, 62, 62); } }


  // ------------------------------------------------------------------------------- ACADEMIA (mapa 2)
  // Janelas com persiana: o céu e o sol ficam atrás e só aparecem pelas frestas; a luz
  // atravessa cada fresta e desenha listras no chão, inclinadas conforme a hora.
  const GW = { step: 140, x0: 23, w: 88, y: 32, h: 91 };
  const gymOpen = (i) => (i % 4 === 1 ? 34 : i % 4 === 2 ? 12 : 0); // parte de baixo com a persiana levantada
  const gymSlats = (i) => { const list = []; for (let y = GW.y + 2; y < GW.y + GW.h - gymOpen(i) - 4; y += 5) list.push(y); return list; }; // lâmina de 3px + fresta de 2px
  const gymAmb = (s) => mix(s.amb, [1, 1, 1], .28);
  function buildGymMid() {
    const W = worldW(2), [cv, c] = mk(W, LH);
    R(c, 0, 0, W, 134, '#3f5654'); for (let i = 0; i < W * 1.2; i++) R(c, hash(i + 5) * W, 18 + hash(i + 6) * 114, 1, 1, hash(i) > .5 ? '#3a504e' : '#466059');
    for (let x = 0; x < W; x += 70) { R(c, x, 18, 1, 116, '#344a48'); R(c, x + 1, 18, 1, 116, '#4a625f'); }
    R(c, 0, 0, W, 10, '#22302f'); R(c, 0, 10, W, 3, '#35494a'); R(c, 0, 13, W, 1, '#1a2625'); R(c, 0, 14, W, 4, '#71806c'); R(c, 0, 14, W, 1, '#93a08a'); for (let x = 20; x < W; x += 70) { R(c, x, 0, 6, 13, '#1a2625'); R(c, x, 0, 1, 13, '#2e4040'); }
    R(c, 0, 134, W, 86, '#546960'); for (let y = 146; y < 207; y += 12) { R(c, 0, y, W, 1, '#465a52'); R(c, 0, y + 1, W, 1, '#5e746a'); } for (let i = 0; i < W; i++) R(c, hash(i + 15) * W, 138 + hash(i + 16) * 68, 2, 1, hash(i) > .5 ? '#4c6058' : '#5d7369');
    R(c, 0, 134, W, 3, '#a19874'); R(c, 0, 134, W, 1, '#c9c09a'); R(c, 0, 137, W, 1, '#3e5048'); R(c, 0, 207, W, 13, '#30463e'); R(c, 0, 207, W, 1, '#4a655a');
    // piso emborrachado
    R(c, 0, FLOOR, W, 50, '#554b48'); for (let i = 0; i < W * 2.5; i++) R(c, hash(i + 25) * W, 224 + hash(i + 26) * 46, 1, 1, ['#655956', '#463d3b', '#6f6360', '#7a8a80'][i % 4]);
    for (let x = 0; x < W; x += 48) { R(c, x, 225, 1, 45, '#463d3b'); R(c, x + 1, 225, 1, 45, '#5f5451'); } R(c, 0, 246, W, 1, '#463d3b');
    R(c, 0, FLOOR, W, 3, '#8f8170'); R(c, 0, FLOOR, W, 1, '#b3a58e'); R(c, 0, FLOOR + 3, W, 2, '#3d3533');
    // janelas com persiana
    for (let i = 0; GW.x0 + i * GW.step < W; i++) { const wx = GW.x0 + i * GW.step, sl = gymSlats(i), last = sl[sl.length - 1];
      R(c, wx - 5, GW.y - 5, GW.w + 10, GW.h + 10, '#1d2e2e'); R(c, wx - 4, GW.y - 4, GW.w + 8, GW.h + 8, '#2a4141'); R(c, wx - 4, GW.y - 4, GW.w + 8, 1, '#4a6a68'); R(c, wx - 4, GW.y - 4, 1, GW.h + 8, '#3d5a58'); R(c, wx - 1, GW.y - 1, GW.w + 2, GW.h + 2, '#152222');
      c.clearRect(wx, GW.y, GW.w, GW.h); R(c, wx, GW.y, GW.w, 2, '#8f8562');
      for (const y of sl) { R(c, wx, y, GW.w, 3, '#cdbf92'); R(c, wx, y, GW.w, 1, '#efe2b4'); R(c, wx, y + 2, GW.w, 1, '#9f946e'); }
      if (i % 4 === 3) { const y0 = sl[7]; c.clearRect(wx, y0, GW.w, 3); for (let k = 0; k < GW.w; k++) { R(c, wx + k, y0 + Math.floor(k / 15), 1, 2, '#cdbf92'); R(c, wx + k, y0 + Math.floor(k / 15), 1, 1, '#efe2b4'); } }
      R(c, wx, last + 5, GW.w, 3, '#b3a67e'); R(c, wx, last + 5, GW.w, 1, '#d9cc9e'); for (const cx of [wx + 20, wx + 67]) for (let y = GW.y + 2; y < last + 5; y++) R(c, cx, y, 1, 1, '#857b5c');
      if (gymOpen(i)) { R(c, wx + 43, last + 8, 2, GW.y + GW.h - last - 8, '#2a4141'); R(c, wx + 80, last + 8, 1, 14, '#857b5c'); R(c, wx + 79, last + 22, 3, 3, '#cdbf92'); }
      R(c, wx - 8, GW.y + GW.h + 5, GW.w + 16, 3, '#71806c'); R(c, wx - 8, GW.y + GW.h + 5, GW.w + 16, 1, '#a3ae98'); c.fillStyle = 'rgba(0,0,0,.18)'; c.fillRect(wx - 6, GW.y + GW.h + 8, GW.w + 12, 2);
      // luminária entre as janelas
      const lx = wx + 114; R(c, lx, 13, 1, 23, '#1a2625'); for (let k = 0; k < 6; k++) R(c, lx - 5 - k, 36 + k, 11 + k * 2, 1, k ? '#c9a96a' : '#8a7448'); R(c, lx - 10, 41, 21, 1, '#e8cf94'); R(c, lx - 3, 42, 7, 2, '#ffe5a1');
      // cartaz
      if (i % 2 === 0) { R(c, wx + 100, 62, 28, 36, '#1d2e2e'); R(c, wx + 101, 63, 26, 34, ['#d9a84a', '#c9574a', '#6a9a8a'][i % 3]); R(c, wx + 108, 68, 12, 12, '#2a3a38'); R(c, wx + 104, 73, 20, 2, '#2a3a38'); R(c, wx + 104, 71, 3, 6, '#2a3a38'); R(c, wx + 121, 71, 3, 6, '#2a3a38'); for (let k = 0; k < 3; k++) R(c, wx + 104, 85 + k * 3, 14 + (k % 2) * 6, 1, '#f3ead6'); } }
    // espelhos, suportes com barra e bancos
    for (let i = 0; 45 + i * 282.5 < W; i++) { const x = Math.round(45 + i * 282.5);
      R(c, x - 1, 144, 86, 51, '#3a4d48'); R(c, x, 145, 84, 49, '#879c8a'); R(c, x + 2, 147, 80, 45, '#6d8580'); R(c, x + 2, 147, 38, 45, '#78958c'); R(c, x + 2, 180, 80, 12, '#5e7570'); R(c, x + 2, 180, 80, 1, '#8aa69a');
      for (let k = 0; k < 40; k++) { c.fillStyle = 'rgba(255,255,255,.16)'; c.fillRect(x + 8 + Math.round((40 - k) * .7), 149 + k, 6, 1); c.fillStyle = 'rgba(255,255,255,.09)'; c.fillRect(x + 22 + Math.round((40 - k) * .7), 149 + k, 3, 1); } R(c, x + 40, 147, 2, 45, '#a6af98');
      for (const px of [x - 7, x + 88]) { R(c, px, 184, 3, 36, '#263d3b'); R(c, px, 184, 1, 36, '#3f5a56'); R(c, px - 1, 186, 5, 2, '#8a968c'); }
      R(c, x - 14, 188, 112, 2, '#a6aba0'); R(c, x - 14, 188, 112, 1, '#d5dad0'); for (const [px, d] of [[x - 12, 1], [x + 92, -1]]) { R(c, px, 181, 5, 16, '#283b3a'); R(c, px, 181, 1, 16, '#44605c'); R(c, px - 4 * d + (d < 0 ? 5 : -1), 184, 4, 10, '#75897c'); }
      R(c, x + 12, 206, 54, 5, '#a56d48'); R(c, x + 12, 206, 54, 1, '#c98c62'); R(c, x + 12, 210, 54, 1, '#7a4c30'); R(c, x + 15, 211, 3, 9, '#293e3b'); R(c, x + 60, 211, 3, 9, '#293e3b'); c.fillStyle = 'rgba(0,0,0,.2)'; c.fillRect(x + 10, FLOOR, 58, 2); }
    // letreiro do Caleb e estante de halteres
    R(c, 371, 148, 152, 21, '#1c2f2c'); R(c, 372, 149, 150, 19, '#2c4440'); R(c, 372, 149, 150, 1, '#4a6a64'); for (const [bx, by] of [[374, 151], [519, 151], [374, 165], [519, 165]]) R(c, bx, by, 1, 1, '#c9b06a');
    R(c, 527, 208, 138, 2, '#263d3b'); for (const lx of [529, 661]) R(c, lx, 210, 2, 10, '#263d3b');
    for (let i = 0; i < 6; i++) { const x = Math.round(530 + i * 22.5); R(c, x, 201, 17, 3, '#9eac92'); R(c, x, 201, 17, 1, '#c5d0bc'); for (const px of [x + 1, x + 12]) { R(c, px, 196, 4, 12, '#233f3b'); R(c, px, 196, 1, 12, '#3f625c'); } }
    // fundo do salão: espelhos, plataforma de halteres e faixas com frases
    for (let x = 1340, i = 0; x < W; x += 175, i++) { R(c, x, 157, 65, 51, '#263e3b'); R(c, x + 3, 160, 58, 45, '#7d9889'); R(c, x + 7, 165, 21, 34, '#99afa1'); R(c, x + 31, 164, 2, 37, '#c5ccb0'); for (let k = 0; k < 30; k++) { c.fillStyle = 'rgba(255,255,255,.14)'; c.fillRect(x + 38 + Math.round((30 - k) * .6), 164 + k, 4, 1); }
      R(c, x - 8, 207, 77, 4, '#293f39'); R(c, x - 8, 207, 77, 1, '#3f5a52'); for (let j = 0; j < 4; j++) { const xx = Math.round(x + j * 16.5); R(c, xx, 199, 13, 3, '#a6b69c'); for (const px of [xx + 1, xx + 9]) { R(c, px, 195, 3, 10, '#304e43'); R(c, px, 195, 1, 10, '#4a6e60'); } }
      R(c, x - 7, 138, 142, 14, '#1c2f2c'); R(c, x - 6, 139, 140, 12, '#2c4440'); R(c, x - 6, 139, 140, 1, '#4a6a64'); }
    // tatames azuis e bebedouro
    for (let i = 0; 208 + i * 395 < W; i++) { const x = 208 + i * 395; R(c, x, 217, 52, 3, '#3a6a9a'); R(c, x, 217, 52, 1, '#5a8cbc'); R(c, x + 25, 217, 1, 3, '#2c5078'); }
    for (let i = 0; 160 + i * 565 < W; i++) { const x = 160 + i * 565; R(c, x, 180, 12, 40, '#cfd8dc'); R(c, x, 180, 12, 1, '#ffffff'); R(c, x + 1, 164, 10, 16, '#7ec3e6'); R(c, x + 2, 166, 2, 12, '#c9ecfa'); R(c, x + 4, 194, 4, 3, '#39464c'); }
    return cv;
  }
  function gym(c, s, t, camL) {
    if (!mids[2]) mids[2] = buildGymMid();
    const am = gymAmb(s), pre = (v) => [v[0] / am[0], v[1] / am[1], v[2] / am[2]];
    sky(c, s, t, camL, { sb: 116, sa: 70, mb: 110, ma: 64, amb: am });
    // prédios e árvores lá fora, vistos entre as lâminas
    const day = 1 - s.night, far2 = pre(mix(s.bot, [.2 + .1 * day, .26 + .12 * day, .4 + .12 * day], .62));
    for (let i = 0; i < 40; i++) { const bw = 14 + Math.round(hash(i + 50) * 18), bh = 16 + Math.round(hash(i + 60) * 40), x = Math.round(i * 22 - 60 - (camL * .3) % 22 * 0), xx = ((x - camL * .3) % 860 + 860) % 860 - 60; R(c, xx, 124 - bh, bw, bh, css(far2)); for (let wy = 3; wy < bh - 3; wy += 5) for (let wx2 = 2; wx2 < bw - 2; wx2 += 4) if (hash(i * 31 + wx2 * 7 + wy) > .55 && s.night > .3) R(c, xx + wx2, 124 - bh + wy, 2, 2, `rgba(255,220,130,${cl((s.night - .3) * 2)})`); }
    for (let i = 0; i < 16; i++) { const xx = ((i * 57 - camL * .45) % 900 + 900) % 900 - 40, g2 = pre([.2 + .12 * day, .36 + .2 * day, .22 + .1 * day]); ell(c, xx + Math.sin(t * 1.2 + i) * 1.2, 112, 13, 12, css(g2)); ell(c, xx + 9, 117, 9, 8, css([g2[0] * .8, g2[1] * .8, g2[2] * .8])); }
    c.drawImage(mids[2], camL, 0, LW, LH, 0, 0, LW, LH);
    // ventiladores e sacos de pancada
    for (let i = 0; 173 + i * 395 < worldW(2); i++) { const x = 173 + i * 395 - camL; if (x < -30 || x > LW + 30) continue; R(c, x, 17, 2, 38, '#314644'); R(c, x - 3, 55, 8, 3, '#55656e'); const a = Math.round(Math.abs(Math.cos(t * 9 + i)) * 20) + 2, b = Math.round(Math.abs(Math.cos(t * 9 + i + 1.05)) * 20) + 2; R(c, x - a, 56, a * 2 + 2, 1, '#a8b6a0'); R(c, x - b, 57, b * 2 + 2, 1, '#7f8f7c'); }
    for (let i = 0; 225 + i * 395 < worldW(2); i++) { const x = 225 + i * 395 - camL; if (x < -30 || x > LW + 30) continue; const sw = Math.round(Math.sin(t * 1.5 + i) * 1.5); for (let y = 18; y < 141; y += 2) R(c, x + 9 + Math.round(sw * (y - 18) / 123), y, 1, 1, '#a6a18a'); R(c, x + sw, 140, 20, 50, '#2c2422'); R(c, x + 1 + sw, 141, 18, 48, '#a95f48'); R(c, x + 3 + sw, 144, 3, 40, '#c37a55'); R(c, x + 15 + sw, 141, 4, 48, '#874a38'); R(c, x + 1 + sw, 150, 18, 3, '#7c493b'); R(c, x + 1 + sw, 176, 18, 3, '#7c493b'); R(c, x + 4 + sw, 187, 12, 2, '#2a3c35'); c.fillStyle = 'rgba(0,0,0,.22)'; c.fillRect(Math.round(x + 1), FLOOR - 1, 18, 2); }
  }
  function gymText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#e6cc8d'; c.fillText('CALEB · SEM DESCULPA', 894, 318); const W = worldW(2); c.fillStyle = '#c0c99a'; for (let x = 1340, i = 0; x < W; x += 175, i++) { if (x * 2 < camera - 300 || x * 2 > camera + 1260) continue; c.fillText(['FORÇA DA ROÇA', 'UMA REPETIÇÃO A MAIS', 'FOCO NO BOLO'][i % 3], (x + 64) * 2, 291); } c.restore(); }
  function gquad(g, pts, col) { g.fillStyle = col; g.beginPath(); g.moveTo(pts[0][0], pts[0][1]); for (let i = 1; i < 4; i++) g.lineTo(pts[i][0], pts[i][1]); g.closePath(); g.fill(); }
  function gymLights(g, s, t, camL) {
    const sun = sunInfo(s), col = s.sunT !== null ? s.sun : [.6, .7, 1], lean = sun.lean, W = worldW(2);
    for (let i = Math.floor((camL - 200) / GW.step); GW.x0 + i * GW.step - camL < LW + 200; i++) { if (i < 0 || GW.x0 + i * GW.step > W) continue; const wx = GW.x0 + i * GW.step - camL;
      if (sun.str > .03) { const sl = gymSlats(i), gaps = sl.map((y) => [y + 3, 2]); const open = gymOpen(i); if (open) gaps.push([GW.y + GW.h - open + 2, open - 2]);
        gaps.forEach(([gy, gh], n) => { const depth = (GW.y + GW.h - gy) / GW.h, fy = FLOOR + 2 + depth * 44, fh = Math.max(2, gh * .5), sh = lean * (10 + depth * 46);
          gquad(g, [[wx + sh, fy], [wx + GW.w + sh, fy], [wx + GW.w + sh + lean * fh, fy + fh], [wx + sh + lean * fh, fy + fh]], css(col, .30 * sun.str)); // listra no chão
          if (n % 2 === 0 || gh > 2) gquad(g, [[wx, gy], [wx + GW.w, gy], [wx + GW.w + sh, fy], [wx + sh, fy]], css(col, (gh > 2 ? .07 : .028) * sun.str)); }); // lâmina de luz no ar
        for (let k = 0; k < 7; k++) { const u = (t * .1 + hash(k + i * 9)) % 1, px = wx + hash(k * 3 + i) * GW.w + lean * 30 * u, py = GW.y + u * (FLOOR - GW.y); g.fillStyle = css(col, .55 * sun.str * (.5 + .5 * Math.sin(t * 3 + k + i))); g.fillRect(Math.round(px), Math.round(py), 1, 1); } }
      // luminária de tungstênio: sempre acesa, mais forte à noite
      const lx = wx + 114, a = .32 + s.night * .5, gr = g.createLinearGradient(0, 44, 0, LH); gr.addColorStop(0, `rgba(255,214,140,${.24 * a})`); gr.addColorStop(1, `rgba(255,214,140,${.03 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(lx - 10, 44); g.lineTo(lx + 11, 44); g.lineTo(lx + 52, LH); g.lineTo(lx - 51, LH); g.closePath(); g.fill();
      const bl = g.createRadialGradient(lx, 44, 1, lx, 46, 26); bl.addColorStop(0, `rgba(255,226,160,${.7 * a})`); bl.addColorStop(1, 'rgba(255,226,160,0)'); g.fillStyle = bl; g.fillRect(lx - 28, 18, 56, 56);
      g.save(); g.translate(lx, FLOOR + 14); g.scale(1, .28); const pl = g.createRadialGradient(0, 0, 0, 0, 0, 54); pl.addColorStop(0, `rgba(255,214,140,${.3 * a})`); pl.addColorStop(1, 'rgba(255,214,140,0)'); g.fillStyle = pl; g.fillRect(-54, -54, 108, 108); g.restore(); }
  }

  // ------------------------------------------------------------------------------- peças comuns: cidade, chão, refletor
  const cities = {};
  function city(seed, baseY) { // prédios ao longe (camada fixa) + janelas acesas (para a noite)
    const key = seed + ':' + baseY; if (cities[key]) return cities[key];
    const D = mk(TILE, 196), L = mk(TILE, 196), COL = ['#8fa5b5', '#7d94a8', '#9ab0bd', '#8799ad'];
    let x = 0, i = 0; while (x < TILE - 8) { const bw = 12 + Math.round(hash(i + seed) * 20), bh = 18 + Math.round(hash(i + seed + 40) * 52), w = Math.min(bw, TILE - x), y = baseY - bh, col = COL[i % 4];
      R(D[1], x, y, w, 196 - y, col); R(D[1], x, y, 1, bh, 'rgba(255,255,255,.22)'); R(D[1], x + w - 2, y, 2, bh, 'rgba(20,40,70,.22)'); R(D[1], x, y, w, 1, 'rgba(255,255,255,.3)');
      if (hash(i + seed + 80) > .6) { R(D[1], x + 3, y - 4, 5, 4, '#6f8597'); R(D[1], x + 3, y - 4, 5, 1, '#a9bcc8'); } if (hash(i + seed + 90) > .7) R(D[1], x + w - 5, y - 7, 1, 7, '#5f7587');
      for (let wy = 3; wy < bh - 3; wy += 5) for (let wx = 2; wx < w - 3; wx += 4) { R(D[1], x + wx, y + wy, 2, 3, 'rgba(40,70,100,.42)'); if (hash(i * 31 + wx * 7 + wy + seed) > .6) { R(L[1], x + wx, y + wy, 2, 3, hash(wx + wy + i) > .5 ? '#ffd98a' : '#ffeebc'); } }
      x += w + (hash(i + seed + 120) > .7 ? 3 : 0); i++; }
    for (let xx = 0; xx < TILE; xx++) for (let yy = baseY - 10; yy < 196; yy += 2) if (((xx + yy) & 3) === 0) R(D[1], xx, yy, 1, 1, 'rgba(200,225,230,.35)');
    return (cities[key] = [D[0], L[0]]);
  }
  function floodlight(c, x, top, lamps) { R(c, x, top, 4, 220 - top, '#4b6260'); R(c, x, top, 1, 220 - top, '#7a918c'); R(c, x + 3, top, 1, 220 - top, '#33474a'); const w = lamps * 6 + 4; R(c, x + 2 - w / 2 - 1, top - 9, w + 2, 10, '#27383a'); R(c, x + 2 - w / 2, top - 8, w, 8, '#3e5354'); for (let k = 0; k < lamps; k++) { R(c, x + 4 - w / 2 + k * 6, top - 7, 5, 5, '#e9d8a2'); R(c, x + 4 - w / 2 + k * 6, top - 7, 5, 1, '#fff6d0'); } for (let y = top + 14; y < 214; y += 22) R(c, x - 1, y, 6, 1, '#33474a'); }
  function floodBeam(g, x, top, a, reach) { if (a < .02) return; const gr = g.createLinearGradient(0, top, 0, 262); gr.addColorStop(0, `rgba(235,240,255,${.34 * a})`); gr.addColorStop(1, `rgba(235,240,255,${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(x - 8, top - 4); g.lineTo(x + 12, top - 4); g.lineTo(x + reach, 262); g.lineTo(x - reach + 4, 262); g.closePath(); g.fill(); const b = g.createRadialGradient(x + 2, top - 4, 1, x + 2, top - 4, 30); b.addColorStop(0, `rgba(255,250,225,${.9 * a})`); b.addColorStop(1, 'rgba(255,250,225,0)'); g.fillStyle = b; g.fillRect(x - 30, top - 36, 64, 64); g.save(); g.translate(x + 2, 232); g.scale(1, .3); const p = g.createRadialGradient(0, 0, 0, 0, 0, reach); p.addColorStop(0, `rgba(235,240,255,${.3 * a})`); p.addColorStop(1, 'rgba(235,240,255,0)'); g.fillStyle = p; g.fillRect(-reach, -reach, reach * 2, reach * 2); g.restore(); }
  function board(c, x, y, w, h, col, edge) { R(c, x - 1, y - 1, w + 2, h + 2, edge); R(c, x, y, w, h, col); R(c, x, y, w, 1, 'rgba(255,255,255,.2)'); for (const [bx, by] of [[x + 1, y + 1], [x + w - 2, y + 1], [x + 1, y + h - 2], [x + w - 2, y + h - 2]]) R(c, bx, by, 1, 1, '#d9cc9e'); }
  function backdrop(c, s, t, camL, cityKey) { if (!far) far = buildFar(); const sun = sunInfo(s), la = Math.min(1, Math.abs(sun.lean) * 1.3) * sun.str, rel = far[sun.lean >= 0 ? 3 : 4]; sky(c, s, t, camL); tile(c, far[0], camL * .04); if (la > .03) { c.globalAlpha = la; tile(c, rel[0], camL * .04); c.globalAlpha = 1; } tile(c, far[1], camL * .1 + 300); if (la > .03) { c.globalAlpha = la; tile(c, rel[1], camL * .1 + 300); c.globalAlpha = 1; } tile(c, city(cityKey[0], cityKey[1])[0], camL * .07); return sun; }

  // ------------------------------------------------------------------------------- QUADRA (mapa 3)
  const COURT_HOOPS = [150, 1100], COURT_FLOODS = [[42, 61, 3], [1225, 61, 3]]; { for (let x = 1350; x < 2600; x += 210) COURT_FLOODS.push([x, 101, 4]); }
  function buildCourtMid() {
    const W = worldW(3), [cv, c] = mk(W, LH);
    // gramado ao fundo, calçada e piso da quadra
    R(c, 0, 168, W, 12, '#6f9a5a'); R(c, 0, 168, W, 1, '#9cc878'); for (let i = 0; i < W / 2; i++) R(c, hash(i + 3) * W, 169 + hash(i + 4) * 10, 2, 1, i % 2 ? '#5f8a4c' : '#86b56a');
    R(c, 0, 180, W, 10, '#9aa89a'); R(c, 0, 180, W, 1, '#c3cdc0'); for (let x = 0; x < W; x += 24) R(c, x, 181, 1, 9, '#7f8f82');
    R(c, 0, 190, W, 30, '#a6795b'); R(c, 0, 190, W, 1, '#c39a7a'); for (let i = 0; i < W * 1.5; i++) R(c, hash(i + 13) * W, 191 + hash(i + 14) * 28, 1 + hash(i) * 2, 1, i % 3 ? '#96694d' : '#b88a6a');
    R(c, 620, 191, 320, 28, '#3f8a6a'); for (let i = 0; i < 500; i++) R(c, 620 + hash(i + 23) * 320, 192 + hash(i + 24) * 26, 2, 1, i % 2 ? '#35785c' : '#4c9a78'); R(c, 700, 191, 160, 28, '#b8644a'); for (let i = 0; i < 260; i++) R(c, 700 + hash(i + 33) * 160, 192 + hash(i + 34) * 26, 2, 1, i % 2 ? '#a45640' : '#c87860');
    R(c, 620, 191, 320, 1, '#f1ead0'); R(c, 620, 218, 320, 1, '#f1ead0'); R(c, 620, 191, 1, 28, '#f1ead0'); R(c, 939, 191, 1, 28, '#f1ead0'); R(c, 779, 191, 2, 28, '#f1ead0'); for (let k = -14; k <= 14; k++) { const w = Math.round(Math.sqrt(196 - k * k) * 1.9); R(c, 780 - w, 205 + Math.round(k * .5), 1, 1, '#f1ead0'); R(c, 780 + w, 205 + Math.round(k * .5), 1, 1, '#f1ead0'); }
    R(c, 0, 218, W, 2, '#d6c29a');
    // chão: calçamento em placas, rachaduras e matinho
    R(c, 0, FLOOR, W, 50, '#97856e'); R(c, 0, 240, W, 30, '#8a7862'); dither(c, 0, 239, W, '#8a7862');
    for (let x = 0; x < W; x += 40) { R(c, x, 225, 1, 45, '#7a6a56'); R(c, x + 1, 225, 1, 45, '#a8977b'); } R(c, 0, 247, W, 1, '#7a6a56'); R(c, 0, 248, W, 1, '#a8977b');
    for (let i = 0; i < W * 1.5; i++) R(c, hash(i + 43) * W, 226 + hash(i + 44) * 43, 1 + hash(i) * 2, 1, i % 3 ? '#86745e' : '#ab9a80');
    for (let i = 0; i < W / 50; i++) { let x = hash(i + 53) * W, y = 226 + hash(i + 54) * 20; for (let k = 0; k < 8 + hash(i) * 10; k++) { R(c, x, y, 1, 1, '#5f5242'); x += hash(i * 5 + k) > .4 ? 1 : -1; y += hash(i * 3 + k) > .5 ? 1 : 0; } }
    R(c, 0, FLOOR, W, 3, '#c4b08a'); R(c, 0, FLOOR, W, 1, '#e6d6b0'); R(c, 0, FLOOR + 3, W, 2, '#655c4d');
    for (let i = 0; i < W / 30; i++) { const x = hash(i + 63) * W; R(c, x, FLOOR - 2, 1, 2, '#5f9a4a'); R(c, x + 1, FLOOR - 3, 1, 3, '#7ab85a'); R(c, x + 2, FLOOR - 1, 1, 1, '#5f9a4a'); }
    // alambrado
    c.fillStyle = 'rgba(132,151,134,.55)'; for (let y = 122; y < 196; y++) for (let x = (y % 8); x < W; x += 8) { c.fillRect(x, y, 1, 1); c.fillRect((x + 8 - ((y * 2) % 8)) % W, y, 1, 1); }
    R(c, 0, 120, W, 2, '#657e71'); R(c, 0, 120, W, 1, '#93a898'); R(c, 0, 195, W, 2, '#557169');
    for (let x = 0; x < W; x += 32.5) { R(c, x, 120, 3, 77, '#597a70'); R(c, x, 120, 1, 77, '#99a48a'); R(c, x - 1, 118, 5, 2, '#3f5a52'); }
    // tabelas de basquete
    for (const x of COURT_HOOPS) { R(c, x, 115, 5, 104, '#425e58'); R(c, x, 115, 1, 104, '#6f8a82'); R(c, x - 4, 114, 13, 4, '#d8cba9'); R(c, x - 32, 107, 39, 28, '#3a4a48'); R(c, x - 31, 108, 37, 26, '#d3d2b8'); R(c, x - 29, 110, 33, 22, '#849e91'); R(c, x - 20, 116, 15, 12, '#dae0bf'); R(c, x - 18, 118, 11, 8, '#98afa0'); R(c, x - 16, 130, 19, 3, '#c16f4e'); R(c, x - 16, 130, 19, 1, '#e8936a'); for (let k = 0; k < 6; k++) R(c, x - 15 + k * 3.4, 133, 1, 9 - Math.abs(k - 2.5), '#e3e6d2'); for (let k = 0; k < 3; k++) R(c, x - 14 + k, 135 + k * 3, 15 - k * 2, 1, '#c3c7ac'); }
    for (const [x, top, n] of COURT_FLOODS) floodlight(c, x, top, n);
    // arquibancadas
    const bleach = (x, y, w, rows, gap) => { for (let i = 0; i < rows; i++) { const xx = x - i * gap, yy = y + i * 10, ww = w + i * gap * 2; R(c, xx, yy, ww, 5, '#a68c74'); R(c, xx, yy, ww, 1, '#cbb294'); R(c, xx, yy + 4, ww, 1, '#7a6450'); for (let k = 8; k < ww; k += 14) R(c, xx + k, yy + 1, 1, 3, '#8f7660'); R(c, xx + 4, yy + 5, 3, 219 - yy - 5, '#4c675c'); R(c, xx + ww - 7, yy + 5, 3, 219 - yy - 5, '#4c675c'); } };
    bleach(380, 181, 135, 3, 12); for (let x = 1350; x < W; x += 210) { bleach(x + 32, 180, 95, 3, 4.5); R(c, x + 38, 173, 71, 1, '#78966f'); }
    // lixeira, mochilas e garrafas
    for (const x of [300, 980, 1650, 2250]) { if (x > W) break; R(c, x, 205, 10, 14, '#3f8a52'); R(c, x - 1, 203, 12, 3, '#57a86a'); R(c, x + 3, 209, 4, 4, '#e9f2e0'); }
    for (const [x, col] of [[395, '#c9574a'], [430, '#3a6a9a'], [505, '#e8c23a']]) { R(c, x, 175, 7, 6, col); R(c, x + 1, 174, 5, 1, col); R(c, x + 2, 177, 3, 2, 'rgba(255,255,255,.35)'); }
    board(c, 1929, 122, 170, 19, '#4d7263', '#2c4a40'); R(c, 1960, 141, 3, 78, '#425e58'); R(c, 2066, 141, 3, 78, '#425e58');
    return cv;
  }
  function court(c, s, t, camL) {
    if (!mids[3]) mids[3] = buildCourtMid();
    const sun = backdrop(c, s, t, camL, [7, 150]); tile(c, far[2], camL * .22 + 500);
    c.drawImage(mids[3], camL, 0, LW, LH, 0, 0, LW, LH);
    if (sun.str > .04) { const sh = `rgba(18,30,52,${.28 * sun.str})`, reach = sun.lean * (14 + Math.abs(sun.lean) * 26);
      for (let x = Math.floor(camL / 32.5) * 32.5 - 65; x < camL + LW + 65; x += 32.5) slant(c, x - camL, x - camL + 2, 197, reach * 1.6, 12, `rgba(18,30,52,${.12 * sun.str})`);
      for (const x of COURT_HOOPS) { slant(c, x - camL, x - camL + 5, 219, reach, 4, sh); slant(c, x - camL - 30 + reach * 3, x - camL + 6 + reach * 3, 221, reach * .3, 3, sh); }
      for (const [x] of COURT_FLOODS) slant(c, x - camL, x - camL + 4, 219, reach * 1.4, 5, sh);
      { const x = 356 - camL; if (x > -260 && x < LW + 100) slant(c, x, x + 183, 219, reach * 1.2, 4, sh); } }
    { const x = 1265 - camL; if (x > -70 && x < LW + 70) tree(c, x, 218, .8, 0, t, 1265, sun.lean >= 0 ? Math.max(.35, sun.lean) : Math.min(-.35, sun.lean)); } { const x = 55 - camL; if (x > -60) bush(c, x, 50); }
    // bandeirinhas e bola quicando
    { const x0 = 545 - camL; if (x0 < LW && x0 + 485 > 0) { R(c, x0, 99, 485, 1, '#586e65'); for (let i = 0; i < 20; i++) { const x = x0 + 5 + i * 23.5, wv = Math.round(Math.sin(t * 2 + i) * 1.2); for (let k = 0; k < 11; k++) R(c, x + k * .5 + wv * (k / 11), 100 + k, 12 - k, 1, i % 3 === 0 ? '#b87d59' : i % 3 === 1 ? '#879c81' : '#e8c86a'); } } }
    { const bx = 587 + Math.sin(t * .65) * 15 - camL, by = 214 - Math.abs(Math.sin(t * 2.8)) * 19; ell(c, bx, 219, 4, 1, 'rgba(0,0,0,.25)'); ell(c, bx, by, 4.5, 4.5, '#6f4f35'); ell(c, bx, by, 3.5, 3.5, '#e19d4e'); R(c, bx, by - 4, 1, 8, '#875b38'); R(c, bx - 3, by, 7, 1, '#875b38'); R(c, bx - 2, by - 2, 1, 1, '#ffd08a'); }
  }
  function courtText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#e2dab1'; c.fillText('QUADRA · FINAL DO RECREIO', 4028, 264); c.restore(); }
  function courtLights(g, s, t, camL) { if (s.night <= .12) return; const a = cl((s.night - .12) * 1.4); g.save(); g.beginPath(); g.rect(0, 0, LW, 144); g.clip(); g.globalAlpha = a; tile(g, city(7, 150)[1], camL * .07); g.restore(); for (const [x, top, n] of COURT_FLOODS) { const sx = x - camL; if (sx < -160 || sx > LW + 160) continue; floodBeam(g, sx, top - 4, a * (.92 + .08 * Math.sin(t * 30 + x)), 70 + n * 12); } }

  // ------------------------------------------------------------------------------- CAMPO DE FUTEBOL (mapa 7)
  const FIELD_FLOODS = []; { for (let x = 150; x < 2400; x += 650) FIELD_FLOODS.push(x); }
  const FIELD_GOALS = [370, 2205];
  let fieldBack = null;
  function buildFieldBack() { // prédio da escola atrás do campo (parallax 0,3)
    const W = 1400, [cv, c] = mk(W, 196), [lv, l] = mk(W, 196);
    R(c, 0, 86, W, 110, '#e2ebeb'); for (let i = 0; i < W; i++) R(c, hash(i + 73) * W, 100 + hash(i + 74) * 60, 2, 1, i % 2 ? '#d3dfdf' : '#f0f6f4'); R(c, 0, 86, W, 8, '#21496c'); R(c, 0, 86, W, 1, '#3a6a94'); R(c, 0, 94, W, 2, '#f7fbfa'); R(c, 0, 150, W, 14, '#c9d6d6'); R(c, 0, 150, W, 1, '#aebcbc');
    for (let x = 10, i = 0; x < W; x += 55, i++) { R(c, x - 1, 105, 41, 32, '#5f8591'); R(c, x, 106, 39, 30, '#87acb7'); R(c, x + 2, 108, 35, 26, '#b3d5d9'); R(c, x + 2, 108, 35, 9, '#c9e4e6'); R(c, x + 18, 108, 2, 26, '#ebf2e7'); R(c, x + 2, 120, 35, 1, '#ebf2e7'); for (let k = 0; k < 20; k++) R(c, x + 5 + Math.round((20 - k) * .5), 110 + k, 3, 1, 'rgba(255,255,255,.3)'); R(c, x - 3, 137, 45, 2, '#f7fbfa'); R(c, x - 3, 139, 45, 1, '#9fb0b0');
      if (i % 3 === 1) { R(c, x + 42, 126, 10, 7, '#cfd8dc'); R(c, x + 43, 128, 8, 1, '#8fa1a6'); R(c, x + 43, 130, 8, 1, '#8fa1a6'); } if (hash(i + 83) > .45) { R(l, x + 2, 108, 35, 26, '#ffe2a0'); } }
    for (let x = 80; x < W; x += 330) { R(c, x, 70, 22, 16, '#6f8597'); R(c, x, 70, 22, 1, '#a9bcc8'); R(c, x + 3, 86 - 20, 2, 4, '#5f7587'); R(c, x + 120, 76, 1, 10, '#5f7587'); R(c, x + 117, 76, 7, 1, '#5f7587'); }
    return [cv, lv];
  }
  function buildFieldMid() {
    const W = worldW(7), [cv, c] = mk(W, LH);
    // gramado em faixas de corte
    for (let x = 0; x < W; x += 40) R(c, x, 163, 40, 57, (x / 40) % 2 ? '#438c4b' : '#4e9752'); for (let i = 0; i < W * 2; i++) { const x = hash(i + 93) * W, y = 164 + hash(i + 94) * 55; R(c, x, y, 1, 2, hash(i) > .5 ? '#3a7f43' : '#62ab5e'); }
    R(c, 0, 163, W, 1, '#7cc070'); R(c, 0, 170, W, 2, '#dce9c8'); R(c, 0, 216, W, 2, '#ecedd1');
    for (let x = 625; x < W; x += 1050) { R(c, x, 172, 2, 44, '#eff0d0'); for (let a = 0; a < 200; a++) { const an = a / 200 * Math.PI * 2; R(c, x + Math.cos(an) * 43, 195 + Math.sin(an) * 18, 1, 1, '#dcebc9'); } R(c, x - 1, 194, 4, 3, '#eff0d0'); }
    for (const gx of FIELD_GOALS) { for (let i = 0; i < 60; i++) R(c, gx - 20 + hash(i + gx) * 130, 205 + hash(i + gx + 3) * 10, 3, 1, '#6a8a4a'); R(c, gx - 9, 217, 108, 1, '#e6efcf'); }
    // chão: grama alta por cima, terra por baixo
    R(c, 0, FLOOR, W, 50, '#448646'); R(c, 0, 234, W, 36, '#6a5236'); dither(c, 0, 233, W, '#6a5236'); dither(c, 0, 232, W, '#6a5236'); R(c, 0, 252, W, 18, '#584329'); dither(c, 0, 251, W, '#584329');
    for (let i = 0; i < W * 1.5; i++) { const x = hash(i + 103) * W, y = 236 + hash(i + 104) * 33; R(c, x, y, 1 + hash(i) * 3, 1, hash(i + 2) > .5 ? '#7a6040' : '#4a3822'); }
    for (let i = 0; i < W / 16; i++) { const x = hash(i + 113) * W, y = 240 + hash(i + 114) * 26, r = 1.5 + hash(i + 115) * 2; ell(c, x, y, r + 1, r, '#4a3e30'); ell(c, x, y - .5, r, r - .5, '#9a8a70'); }
    R(c, 0, FLOOR, W, 2, '#a9cc70'); R(c, 0, FLOOR + 2, W, 4, '#2e623c');
    for (let x = 0; x < W; x++) { const h = hash(x * 3 + 17); if (h > .4) R(c, x, FLOOR + 6, 1, 1 + Math.round(h * 5), '#2e623c'); if (h < .25) R(c, x, FLOOR - 1 - Math.round(h * 8), 1, 1 + Math.round(h * 8), '#7ab85a'); }
    // refletores, placas de patrocínio, arquibancadas (o povo é desenhado ao vivo) e traves
    for (const x of FIELD_FLOODS) floodlight(c, x, 50, 3);
    for (let x = 30, i = 0; x < W; x += 260, i++) { const cols = [['#21496c', '#f2c14e'], ['#c0392b', '#ffffff'], ['#2e7d32', '#fff3c4']][i % 3]; R(c, x - 1, 149, 57, 13, '#1c2a2a'); R(c, x, 150, 55, 11, cols[0]); R(c, x + 2, 152, 51, 7, cols[1]); R(c, x + 5, 154, 20, 3, cols[0]); R(c, x + 28, 154, 22, 3, cols[0]); R(c, x + 4, 161, 2, 3, '#33474a'); R(c, x + 49, 161, 2, 3, '#33474a'); }
    for (let x = 95; x < W; x += 480) { R(c, x + 60, 126, 46, 3, '#183e60'); R(c, x + 60, 126, 46, 1, '#3a6a94'); R(c, x - 20, 122, 2, 42, '#33474a'); R(c, x + 178, 122, 2, 42, '#33474a'); R(c, x - 22, 120, 204, 3, '#21496c'); R(c, x - 22, 120, 204, 1, '#3a6a94');
      for (let r2 = 0; r2 < 3; r2++) { const xx = x - r2 * 8, yy = 137 + r2 * 10, w = 160 + r2 * 16; R(c, xx, yy, w, 4, '#6b90a4'); R(c, xx, yy, w, 1, '#9cc0d0'); R(c, xx, yy + 3, w, 1, '#4a6c80'); R(c, xx, yy + 4, w, 6, '#3f5a6a'); } }
    for (const gx of FIELD_GOALS) { c.fillStyle = 'rgba(225,240,225,.5)'; for (let j = 0; j <= 18; j++) c.fillRect(gx + 2 + j * 5, 145, 1, 73); for (let j = 0; j <= 14; j++) c.fillRect(gx + 2, 145 + j * 5, 88, 1); R(c, gx, 141, 4, 78, '#e9f2de'); R(c, gx, 141, 1, 78, '#ffffff'); R(c, gx + 87, 141, 4, 78, '#e9f2de'); R(c, gx + 87, 141, 1, 78, '#ffffff'); R(c, gx, 141, 91, 4, '#faffeb'); R(c, gx, 144, 91, 1, '#b9c8b0'); }
    board(c, 175, 102, 171, 19, '#153a60', '#0c2440'); R(c, 200, 121, 3, 30, '#33474a'); R(c, 318, 121, 3, 30, '#33474a');
    // bandeirinhas de escanteio, cones e garrafas
    for (const x of [352, 480, 2190, 2310]) { R(c, x, 200, 1, 18, '#e9f2de'); R(c, x + 1, 200, 5, 4, '#e04a3a'); R(c, x + 1, 200, 5, 1, '#ff8a70'); } for (let x = 700; x < W; x += 370) { R(c, x, 213, 5, 5, '#e8842a'); R(c, x + 1, 210, 3, 3, '#e8842a'); R(c, x, 215, 5, 1, '#ffffff'); R(c, x - 1, 218, 7, 1, '#b05c18'); }
    return cv;
  }
  const FAN_SHIRT = ['#e04a3a', '#3a7fd0', '#e8c23a', '#3aa655', '#f0f0f0', '#21496c'], FAN_SKIN = ['#f0c8a0', '#c8946a', '#8a5a3c', '#e0aa80', '#6e452e'], FAN_HAIR = ['#2a1e18', '#4a2e1c', '#161616', '#7a4a24', '#d8b25a'];
  function field(c, s, t, camL) {
    if (!mids[7]) mids[7] = buildFieldMid(); if (!fieldBack) fieldBack = buildFieldBack();
    const sun = backdrop(c, s, t, camL, [19, 132]);
    { const o = Math.round(camL * .3) % 1400; c.drawImage(fieldBack[0], -o, 0); if (1400 - o < LW) c.drawImage(fieldBack[0], 1400 - o, 0); }
    c.drawImage(mids[7], camL, 0, LW, LH, 0, 0, LW, LH);
    // torcida nas arquibancadas
    for (let x = 95; x < worldW(7); x += 480) { if (x - camL > LW + 40 || x + 200 - camL < -40) continue; for (let r2 = 0; r2 < 3; r2++) for (let j = 0; j < 15 + r2; j++) { const n = x + r2 * 31 + j * 7, px = Math.round(x - r2 * 8 + 5 + j * 10.4) - camL, bob = Math.round(Math.max(0, Math.sin(t * (4 + hash(n) * 2.5) + n)) * 2), py = 128 + r2 * 10 - bob; R(c, px, py + 5, 7, 5, FAN_SHIRT[n % 6]); R(c, px + 1, py, 5, 5, FAN_SKIN[n % 5]); R(c, px + 1, py - 1, 5, 2, FAN_HAIR[(n * 3) % 5]); R(c, px + 2, py + 2, 1, 1, '#1c1c22'); R(c, px + 4, py + 2, 1, 1, '#1c1c22'); if ((n + Math.floor(t * 1.5)) % 5 === 0) { R(c, px - 1, py - 3 - bob, 2, 8, FAN_SKIN[n % 5]); R(c, px + 6, py - 3 - bob, 2, 8, FAN_SKIN[n % 5]); } if (n % 11 === 0) { R(c, px - 2, py - 7, 11, 4, FAN_SHIRT[(n + 2) % 6]); R(c, px - 2, py - 7, 1, 10, '#6a583d'); } } }
    if (sun.str > .04) { const sh = `rgba(14,40,30,${.30 * sun.str})`, reach = sun.lean * (14 + Math.abs(sun.lean) * 26);
      for (const gx of FIELD_GOALS) { const x = gx - camL; if (x < -200 || x > LW + 200) continue; slant(c, x, x + 4, 219, reach * 1.5, 5, sh); slant(c, x + 87, x + 91, 219, reach * 1.5, 5, sh); slant(c, x + reach * 1.5, x + 91 + reach * 1.5, 223, reach * .2, 2, sh); }
      for (const fx of FIELD_FLOODS) slant(c, fx - camL, fx - camL + 4, 163, reach * 1.2, 6, sh);
      for (let x = 95; x < worldW(7); x += 480) { const sx = x - camL; if (sx > -300 && sx < LW + 100) slant(c, sx - 16, sx + 192, 164, reach, 5, sh); } }
    { const bx = 890 + Math.sin(t * .7) * 11 - camL, by = 213 - Math.abs(Math.sin(t * 2.8)) * 9; ell(c, bx, 218, 4, 1, 'rgba(0,0,0,.25)'); ell(c, bx, by, 4.5, 4.5, '#2a2a2a'); ell(c, bx, by, 3.6, 3.6, '#f4f4ea'); const a = t * 5; R(c, bx - 1 + Math.cos(a) * 1.5, by - 1 + Math.sin(a) * 1.5, 2, 2, '#2a2a2a'); R(c, bx + Math.cos(a + 2.4) * 2.6, by + Math.sin(a + 2.4) * 2.6, 1, 1, '#2a2a2a'); R(c, bx + Math.cos(a + 4.2) * 2.6, by + Math.sin(a + 4.2) * 2.6, 1, 1, '#2a2a2a'); }
  }
  function fieldText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#eff5de'; c.fillText('CAMPO DO MOTA · MOTA FC', 521, 224); c.restore(); }
  function fieldLights(g, s, t, camL) { if (s.night <= .12) return; const a = cl((s.night - .12) * 1.4); g.save(); g.beginPath(); g.rect(0, 0, LW, 86); g.clip(); g.globalAlpha = a; tile(g, city(19, 132)[1], camL * .07); g.restore(); g.globalAlpha = a * .5; { const o = Math.round(camL * .3) % 1400; g.drawImage(fieldBack[1], -o, 0); if (1400 - o < LW) g.drawImage(fieldBack[1], 1400 - o, 0); } g.globalAlpha = 1; g.clearRect(174 - camL, 101, 173, 21); for (let x = 95; x < worldW(7); x += 480) g.clearRect(x - 24 - camL, 118, 208, 46); for (const x of FIELD_FLOODS) { const sx = x - camL; if (sx < -200 || sx > LW + 200) continue; floodBeam(g, sx, 46, a * (.92 + .08 * Math.sin(t * 30 + x)), 120); } }

  const MAPS = { 0: { draw: farm, text: farmText, lights: farmLights }, 2: { draw: gym, text: gymText, lights: gymLights, amb: gymAmb }, 3: { draw: court, text: courtText, lights: courtLights }, 7: { draw: field, text: fieldText, lights: fieldLights } };
  const handles = (scene) => !!MAPS[scene] && !window.Graphics?.isLite?.() && !!window.DayTime;
  let lastCam = 0, lastT = 0;
  function draw(c, scene, camera, t) {
    if (!handles(scene)) return false;
    const s = window.DayTime.state(), camL = Math.floor(camera / 2), sub = Math.round(camera) - camL * 2;
    lc.clearRect(0, 0, LW, LH); MAPS[scene].draw(lc, s, t, camL);
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(low, -sub, 0, LW * 2, LH * 2); c.restore();
    MAPS[scene].text?.(c, camera); lastCam = camera; lastT = t; return true;
  }
  // luz da hora do dia sobre o cenário pronto (chamado depois das pontes); personagens ficam de fora
  function finish(c, scene) {
    if (!handles(scene)) return;
    const s = window.DayTime.state(), camL = Math.floor(lastCam / 2), sub = Math.round(lastCam) - camL * 2;
    c.save(); c.globalCompositeOperation = 'multiply'; c.fillStyle = css(MAPS[scene].amb ? MAPS[scene].amb(s) : s.amb); c.fillRect(0, 0, 960, 540);
    if (MAPS[scene].lights) { lg.clearRect(0, 0, LW, LH); MAPS[scene].lights(lg, s, lastT, camL); c.globalCompositeOperation = 'lighter'; c.imageSmoothingEnabled = false; c.drawImage(lightCv, -sub, 0, LW * 2, LH * 2); }
    c.restore();
  }
  window.HdMaps = Object.freeze({ handles, draw: (c, scene, camera, t) => { try { return draw(c, Number(scene), Number(camera) || 0, Number(t) || 0); } catch (e) { return false; } }, finish: (c, scene) => { try { finish(c, Number(scene)); } catch (e) {} }, maps: Object.keys(MAPS).map(Number) });
})();
