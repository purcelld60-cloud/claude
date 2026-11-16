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
  function sky(c, s, t, camL) {
    const pre = (v) => [v[0] / s.amb[0], v[1] / s.amb[1], v[2] / s.amb[2]];
    if (Math.abs(s.h - skyH) > .012) { skyH = s.h; const N = 14, bh = 14; for (let i = 0; i < N; i++) { const k = i / (N - 1), col = css(pre(mix(s.top, s.bot, k * k * .45 + k * .55))); R(sk, 0, i * bh, LW, bh, col); if (i) { dither(sk, 0, i * bh - 1, LW, col); for (let x = 1; x < LW; x += 4) sk.fillRect(x, i * bh - 2, 1, 1); } } }
    c.drawImage(skyCv, 0, 0);
    if (s.night > .25) for (let i = 0; i < 90; i++) { const tw = .5 + .5 * Math.sin(t * (1 + hash(i) * 2) + i); c.fillStyle = `rgba(255,255,255,${cl((s.night - .25) * 1.4 * (.35 + .65 * tw) * (.4 + hash(i + 9) * .6))})`; c.fillRect(Math.round(((hash(i + 300) * 560 - camL * .01) % LW + LW) % LW), Math.round(hash(i + 400) * 120), 1, 1); }
    if (s.sunT !== null) { const x = 40 + s.sunT * 400 - camL * .012, y = 168 - Math.sin(s.sunT * Math.PI) * 128; ell(c, x, y, 26, 26, css(pre(s.sun), .12)); ell(c, x, y, 19, 19, css(pre(s.sun), .22)); ell(c, x, y, 13, 13, css(pre(mix(s.sun, [1, 1, 1], .55)))); }
    if (s.moonT !== null) { const x = 50 + s.moonT * 380 - camL * .012, y = 150 - Math.sin(s.moonT * Math.PI) * 108; ell(c, x, y, 16, 16, 'rgba(200,215,255,.14)'); ell(c, x, y, 9, 9, '#ffffff'); R(c, x - 4, y - 3, 3, 3, '#dfe6ff'); R(c, x + 2, y + 3, 3, 2, '#dfe6ff'); R(c, x + 3, y - 5, 2, 2, '#dfe6ff'); }
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
  function farmLights(g, s, t, camL) { for (const hx of FARM_HOUSES) { const x = hx - camL; if (x < -140 || x > LW + 60) continue; for (const wx of [16, 75]) { const gr = g.createRadialGradient(x + wx, 184, 2, x + wx, 186, 34); gr.addColorStop(0, `rgba(255,200,110,${.5 * s.night})`); gr.addColorStop(1, 'rgba(255,200,110,0)'); g.fillStyle = gr; g.fillRect(x + wx - 36, 150, 72, 72); g.fillStyle = `rgba(255,226,150,${.9 * s.night})`; g.fillRect(Math.round(x + wx - 7), 177, 15, 15); } const gl = g.createRadialGradient(x + 61, 177, 1, x + 61, 180, 30); gl.addColorStop(0, `rgba(255,220,150,${.8 * s.night})`); gl.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gl; g.fillRect(x + 30, 148, 62, 62); } }

  const MAPS = { 0: { draw: farm, text: farmText, lights: farmLights } };
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
    c.save(); c.globalCompositeOperation = 'multiply'; c.fillStyle = css(s.amb); c.fillRect(0, 0, 960, 540);
    if (s.night > .15 && MAPS[scene].lights) { lg.clearRect(0, 0, LW, LH); MAPS[scene].lights(lg, s, lastT, camL); c.globalCompositeOperation = 'lighter'; c.imageSmoothingEnabled = false; c.drawImage(lightCv, -sub, 0, LW * 2, LH * 2); }
    c.restore();
  }
  window.HdMaps = Object.freeze({ handles, draw: (c, scene, camera, t) => { try { return draw(c, Number(scene), Number(camera) || 0, Number(t) || 0); } catch (e) { return false; } }, finish: (c, scene) => { try { finish(c, Number(scene)); } catch (e) {} }, maps: Object.keys(MAPS).map(Number) });
})();
