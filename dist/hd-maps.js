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
  function limb(c, pts, w, col) { for (let i = 0; i < pts.length - 1; i++) { const a = pts[i], b = pts[i + 1], n = Math.ceil(Math.hypot(b[0] - a[0], b[1] - a[1])) + 1; for (let k = 0; k <= n; k++) { const u = k / n; c.fillStyle = col; c.fillRect(Math.round(a[0] + (b[0] - a[0]) * u - w / 2), Math.round(a[1] + (b[1] - a[1]) * u - w / 2), Math.max(1, w), Math.max(1, w)); } } }
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
    // hora dourada: 1 com o sol perto do horizonte, 0 ao meio-dia
    const gold = s.sunT !== null ? cl(1 - Math.sin(s.sunT * Math.PI) * 1.7) : 0, sunX = s.sunT !== null ? 40 + s.sunT * 400 - camL * .012 : -999, sunY = s.sunT !== null ? (arc.sb || 168) - Math.sin(s.sunT * Math.PI) * (arc.sa || 128) : 0;
    if (gold > .02) { // brilho quente em volta do sol e o cinturão rosa do outro lado do céu
      const wash = c.createLinearGradient(0, 0, 0, 180); wash.addColorStop(0, css(pre([.6, .12, .2]), .55 * gold)); wash.addColorStop(.55, css(pre([.98, .3, .22]), .45 * gold)); wash.addColorStop(1, css(pre([1, .62, .3]), .45 * gold)); c.fillStyle = wash; c.fillRect(0, 0, LW, 196);
      c.save(); c.translate(sunX, sunY); c.scale(1.7, 1); const g1 = c.createRadialGradient(0, 0, 3, 0, 0, 220); g1.addColorStop(0, css(pre([1, .9, .55]), .9 * gold)); g1.addColorStop(.22, css(pre([1, .66, .3]), .6 * gold)); g1.addColorStop(.55, css(pre([.95, .36, .26]), .3 * gold)); g1.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = g1; c.fillRect(-260, -220, 520, 440); c.restore();
      const g2 = c.createLinearGradient(0, 40, 0, 170); g2.addColorStop(0, 'rgba(0,0,0,0)'); g2.addColorStop(.6, css(pre([.78, .45, .62]), .2 * gold)); g2.addColorStop(1, css(pre([.95, .6, .55]), .28 * gold)); c.fillStyle = g2; c.fillRect(0, 40, LW, 130); }
    if (s.sunT !== null) { const x = sunX, y = sunY, sc = mix(s.sun, [1, .45, .25], gold * .6);
      ell(c, x, y, 34 + gold * 14, 34 + gold * 10, css(pre(sc), .08 + gold * .08)); ell(c, x, y, 26, 26, css(pre(sc), .14)); ell(c, x, y, 19, 19, css(pre(sc), .24)); ell(c, x, y, 13, 13, css(pre(mix(sc, [1, 1, .92], .55))));
      if (gold > .35) { ell(c, x, y + 1, 70 * gold, 2, css(pre([1, .85, .6]), .35 * gold)); ell(c, x, y + 1, 40 * gold, 1, css(pre([1, .95, .8]), .5 * gold)); }
      if (gold > .15 && s.night < .4) { c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 9; i++) { const a = -Math.PI * .95 + i * .23 + Math.sin(t * .05 + i) * .03, len = 260, wd = .045 + hash(i + 7) * .04; c.fillStyle = css(pre([1, .78, .45]), (.05 + hash(i + 3) * .05) * gold); c.beginPath(); c.moveTo(x, y); c.lineTo(x + Math.cos(a - wd) * len, y + Math.sin(a - wd) * len); c.lineTo(x + Math.cos(a + wd) * len, y + Math.sin(a + wd) * len); c.closePath(); c.fill(); } c.restore(); } }
    if (s.moonT !== null) { const x = 50 + s.moonT * 380 - camL * .012, y = (arc.mb || 150) - Math.sin(s.moonT * Math.PI) * (arc.ma || 108); ell(c, x, y, 16, 16, 'rgba(200,215,255,.14)'); ell(c, x, y, 9, 9, '#ffffff'); R(c, x - 4, y - 3, 3, 3, '#dfe6ff'); R(c, x + 2, y + 3, 3, 2, '#dfe6ff'); R(c, x + 3, y - 5, 2, 2, '#dfe6ff'); }
    // nuvens: altas e finas (cirros) + nuvens com volume; na hora dourada a barriga das nuvens pega o laranja e o rosa do sol
    const cloud = pre(mix(mix(s.bot, [1, 1, 1], .7 * (1 - s.night) + .1), s.top, s.night * .45)), shade = [cloud[0] * .86, cloud[1] * .89, cloud[2] * .96];
    const cbody = pre(mix(mix(mix(s.bot, [1, 1, 1], .7 * (1 - s.night) + .1), s.top, s.night * .45), [.98, .5, .46], gold * .7 * (1 - s.night))), belly = pre(mix(mix(s.bot, [.62, .66, .78], .5), [1, .42, .22], gold * (1 - s.night))), rim = pre(mix([1, 1, .96], [1, .9, .56], gold)), dark = pre(mix(shade, [.5, .2, .3], gold * .6));
    for (let i = 0; i < 6; i++) { const x = ((hash(i + 60) * 900 + t * (3 + hash(i) * 2) - camL * .03) % 760 + 760) % 760 - 140, y = 18 + hash(i + 61) * 48, w = 70 + hash(i + 62) * 90;
      c.fillStyle = css(mix(cloud, belly, .6 * gold), .35 + .25 * gold); for (let k = 0; k < 3; k++) c.fillRect(Math.round(x + k * 9), Math.round(y + k * 3), Math.round(w - k * 18), 1); }
    for (let i = 0; i < 8; i++) { const x = ((hash(i + 20) * 700 + t * (1.5 + hash(i) * 2.5) - camL * .05) % 680 + 680) % 680 - 110, y = 22 + hash(i + 30) * 92, w = 34 + hash(i + 31) * 42, h = 8 + hash(i + 32) * 6;
      const puffs = [[0, 0, w * .5, h], [w * .28, -h * .7, w * .22, h * .8], [w * .55, -h * .45, w * .2, h * .7], [w * .78, 0, w * .26, h * .7], [w * .4, -h * 1.2, w * .14, h * .55]];
      for (const [px, py, rx, ry] of puffs) ell(c, x + px + w * .1, y + py + 2, rx, ry, css(dark));
      for (const [px, py, rx, ry] of puffs) ell(c, x + px + w * .1, y + py, rx, ry * .92, css(gold > .05 ? cbody : cloud));
      for (const [px, py, rx, ry] of puffs) ell(c, x + px + w * .1 + (sunX > x + w * .5 ? 2 : -2), y + py - 2, rx * .7, ry * .5, css(rim, .55 + gold * .2));
      R(c, x + w * .05, y + h * .55, w * 1.05, 3, css(gold > .05 ? belly : shade)); R(c, x + w * .15, y + h * .55 + 3, w * .8, 1, css(gold > .05 ? belly : shade, .7)); }
  }

  // névoa no horizonte (mais quente na hora dourada) e neblina baixa de manhã cedo
  function haze(c, s, t, camL, y0 = 150, y1 = 215) {
    const gold = s.sunT !== null ? cl(1 - Math.sin(s.sunT * Math.PI) * 1.7) : 0, h = s.h, morning = h > 5 && h < 9.5 ? Math.sin((h - 5) / 4.5 * Math.PI) : 0;
    const col = mix(mix(s.bot, [1, 1, 1], .35), [1, .66, .5], gold * .7), a = .16 + gold * .18 + morning * .1;
    const g = c.createLinearGradient(0, y0, 0, y1); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(.55, css(col, a)); g.addColorStop(1, css(col, a * .4)); c.fillStyle = g; c.fillRect(0, y0, LW, y1 - y0);
    if (morning > .05) for (let i = 0; i < 9; i++) { const x = ((hash(i + 90) * 900 + t * (2 + hash(i) * 3) - camL * .2) % 760 + 760) % 760 - 140, y = y1 - 26 + hash(i + 91) * 20, w = 90 + hash(i + 92) * 120; c.fillStyle = css(mix([1, 1, 1], col, .4), .12 * morning); for (let k = 0; k < 4; k++) c.fillRect(Math.round(x + k * 7), Math.round(y - k * 2), Math.round(w - k * 14), 2); }
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
  function tile(c, img, off) { const T = img.width, o = ((Math.round(off) % T) + T) % T; c.drawImage(img, -o, 0); if (T - o < LW) c.drawImage(img, T - o, 0); }

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
  // Folhas que reagem: cada árvore desenhada fica registrada (posição da copa); HdMaps.touch() recebe o
  // jogador a cada quadro e, se ele passa pela copa (por baixo ou pulando dentro), a árvore chacoalha e solta folhas.
  let TREES = [], treeScene = -1; const RUSTLE = new Map(), LEAVES = [];
  function touch(scene, wx, wy, vx, vy) {
    if (scene !== treeScene) return;
    const ax = wx / 2, top = (wy - 76) / 2, bot = wy / 2, speed = Math.min(1, (Math.abs(vx) + Math.abs(vy) * .6) / 260);
    for (const tr of TREES) { const r = tr.r * 1.05; if (Math.abs(ax - tr.x) > r) continue; if (bot < tr.y0 - 4 || top > tr.y1 + 20) continue; // até ~40 px abaixo da copa: o chapéu raspa nas folhas
      const inside = top < tr.y1 - 4, add = (inside ? .9 : .35) * (.15 + speed); const v = Math.min(1.6, (RUSTLE.get(tr.seed) || 0) + add * .12); RUSTLE.set(tr.seed, v);
      if (Math.abs(vx) + Math.abs(vy) > 20 && Math.random() < (inside ? .6 : .2) * (.3 + speed)) for (let k = 0; k < (inside ? 2 : 1); k++) LEAVES.push({ wx: tr.x + (Math.random() - .5) * r * 1.4, wy: tr.y0 + Math.random() * (tr.y1 - tr.y0), vx: (Math.random() - .5) * 10 + vx * .02, vy: 4 + Math.random() * 6, a: Math.random() * 6, life: 4 + Math.random() * 3, col: Math.random() < .25 ? '#c9a24a' : Math.random() < .5 ? '#56a64c' : '#7cc85a' }); }
    if (LEAVES.length > 140) LEAVES.splice(0, LEAVES.length - 140);
  }
  function leavesDraw(c, camL, t, dt) {
    for (const [k, v] of RUSTLE) { const n = v * Math.pow(.25, dt); if (n < .01) RUSTLE.delete(k); else RUSTLE.set(k, n); }
    for (const L of LEAVES) { L.life -= dt; L.a += dt * 3; L.wx += (L.vx + Math.sin(L.a) * 8) * dt; L.wy += L.vy * dt; if (L.wy > 214) { L.wy = 214; L.vx *= .5; L.vy = 0; } const x = L.wx - camL; if (x < -4 || x > LW + 4) continue; R(c, x, L.wy, 2, 1, L.col); if (Math.sin(L.a) > 0) R(c, x + 1, L.wy - 1, 1, 1, L.col); }
    for (let i = LEAVES.length - 1; i >= 0; i--) if (LEAVES[i].life <= 0) LEAVES.splice(i, 1);
  }
  let lastLeafT = 0;
  function tree(c, x, base, s, kind, t, seed, lean = 1) {
    const camHere = treeCam; TREES.push({ seed, x: x + camHere, r: kind === 1 ? 26 * s : 30 * s, y0: base - (kind === 1 ? 50 : 92) * s, y1: base - (kind === 1 ? 30 : 38) * s });
    const shake = RUSTLE.get(seed) || 0, snow = window.Weather?.state?.()?.cover || 0;
    if (kind === 1) { // coqueiro
      for (let k = 0; k < 42 * s; k++) { const px = x + Math.round(k * .08 * s), py = base - k; R(c, px - 2, py, 5, 1, k % 5 === 0 ? '#5f4530' : '#79553b'); R(c, px - 2, py, 1, 1, '#98704b'); }
      const tx = x + Math.round(42 * .08 * s * s), ty = base - Math.round(42 * s), sw = Math.sin(t * (1.4 + shake * 6) + seed) * (1.5 + shake * 4);
      for (let i = 0; i < 8; i++) { const a = -Math.PI + .2 + i * .39, len = 30 * s; for (let k = 0; k <= len; k++) { const u = k / len, px = tx + Math.cos(a) * k + sw * u, py = ty + Math.sin(a) * k * .55 + u * u * 16 * s; R(c, px, py, 2, 1, i % 2 ? '#367c42' : '#64a147'); if (k % 2 === 0) R(c, px, py + 1, 1, 2 + Math.round(u * 3), i % 2 ? '#2c6838' : '#4f8f3f'); } }
      ell(c, tx - 1, ty + 2, 2, 2, '#5a3f2a'); ell(c, tx + 3, ty + 3, 2, 2, '#6a4a30'); return;
    }
    const th = 46 * s; R(c, x - 4 * s, base - th, 8 * s, th, '#674c36'); R(c, x - 4 * s, base - th, 2 * s, th, '#896241'); R(c, x + 2 * s, base - th, 2 * s, th, '#4f3a29'); for (let k = 0; k < 6; k++) R(c, x - 2 * s + hash(k + seed) * 4 * s, base - 6 - k * 7 * s, 1, 3, '#4f3a29');
    R(c, x - 6 * s, base - 2, 12 * s, 2, '#5a4230'); R(c, x - 9 * s, base - 30 * s, 6 * s, 3, '#674c36'); R(c, x + 4 * s, base - 36 * s, 8 * s, 3, '#674c36');
    const CL = [[0, -58, 19], [-18, -50, 15], [18, -52, 15], [-9, -70, 15], [11, -72, 14], [0, -82, 13], [-25, -62, 11], [25, -64, 11]];
    const sway = (i) => Math.round(Math.sin(t * (1.3 + shake * 9) + seed + i * 1.7) * (1.4 + shake * 3.2));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i), base + p[1] * s + 3, p[2] * s, p[2] * s * .92, '#2a5f36'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i), base + p[1] * s, p[2] * s, p[2] * s * .9, '#3f8a45'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i) - lean * 4 * s, base + p[1] * s - 4 * s, p[2] * s * .62, p[2] * s * .5, '#56a64c'));
    CL.forEach((p, i) => ell(c, x + p[0] * s + sway(i) - lean * 7 * s, base + p[1] * s - 7 * s, p[2] * s * .3, p[2] * s * .2, '#7cc85a'));
    for (let i = 0; i < 46; i++) { const p = CL[i % 8], a = hash(i + seed) * 6.28, r = hash(i + seed + 3) * p[2] * s * .85, px = x + p[0] * s + Math.cos(a) * r + sway(i % 8), py = base + p[1] * s + Math.sin(a) * r * .9; R(c, px, py, 2, 1, i % 3 ? '#2f6b3c' : '#8fd468'); if (i % 9 === 0) { R(c, px, py + 1, 2, 2, '#f0a030'); R(c, px, py + 1, 1, 1, '#ffd070'); } }
    if (snow > .05) { const a = Math.min(1, snow * 1.3); CL.forEach((p, i) => { if (p[1] > -55) return; const cx = x + p[0] * s + sway(i), cy = base + p[1] * s - p[2] * s * .62; ell(c, cx, cy + 1, p[2] * s * .78, Math.max(1.5, p[2] * s * .26 * a), `rgba(150,170,205,${.7 * a})`); ell(c, cx, cy, p[2] * s * .74, Math.max(1.2, p[2] * s * .22 * a), `rgba(250,252,255,${a})`); }); R(c, x - 9 * s, base - 31 * s, 6 * s, 1, `rgba(250,252,255,${a})`); R(c, x + 4 * s, base - 37 * s, 8 * s, 1, `rgba(250,252,255,${a})`); }
  }
  const FARM_TREES = [[26, 212, 1.25, 0], [267, 212, .78, 1], [397, 212, 1.12, 0], [695, 213, 1.2, 1], [905, 214, 1.2, 0], [1220, 215, 1.3, 0]];
  { for (let x = 1295, i = 0; x < 2400; x += 122.5, i++) if (i % 3 === 0) FARM_TREES.push([x + 74, 215, .8 + (i % 2) * .2, i % 2]); }
  const FARM_HOUSES = [66, 1752];
  const FARM_FENCES = [[0, 56], [166, 157], [393, 107], [540, 210], [785, 340]]; { for (let x = 1295; x < 2400; x += 122.5) FARM_FENCES.push([x, 111]); }
  // sol: de que lado vem a luz (lean > 0 = luz da esquerda, sombras para a direita) e com que força
  function sunInfo(s) { const T = s.sunT !== null ? s.sunT : s.moonT; if (T === null) return { lean: 0, str: 0 }; return { lean: (0.5 - T) * 2, str: s.sunT !== null ? cl(Math.sin(s.sunT * Math.PI) * 1.4 + .15) : .3 * Math.sin(s.moonT * Math.PI) }; }
  // Áreas de sombra no chão (em pixels de arte, relativos à tela) registradas a cada quadro:
  // usadas por hero-shadow.js para escurecer Da Roça quando ele passa na frente de árvores e casas.
  let SHADE = [], shadeCam = 0, shadeScene = -1, treeCam = 0;
  const shadeAdd = (x0, x1, k, leaves) => { if (x1 - x0 > 4) SHADE.push([Math.min(x0, x1), Math.max(x0, x1), k, !!leaves]); };
  function shadeAt(scene, worldX) {
    if (scene !== shadeScene) return { k: 0, leaves: false };
    const x = worldX / 2 - shadeCam; let k = 0, leaves = false;
    for (const [a, b, kk, lv] of SHADE) { const edge = Math.min(x - a, b - x); if (edge <= -3) continue; const v = kk * Math.min(1, (edge + 3) / 7); if (v > k) { k = v; leaves = lv; } }
    return { k, leaves };
  }
  // Luzes do cenário (postes, refletores, luminárias, frestas de janela) registradas a cada quadro
  // pelo passo de luz; hero-shadow.js usa para Da Roça tapar a luz e projetar sombra no chão.
  let LIGHTS = [], lightCam = 0, lightScene = -1;
  const lightAdd = (x, top, a, reach) => { if (a > .04 && x > -160 && x < LW + 160) LIGHTS.push({ x, top, a, reach }); };
  const patchAdd = (x0, x1, k, a) => { if (a > .03 && x1 > -60 && x0 < LW + 60) LIGHTS.push({ patch: true, x0: Math.min(x0, x1), x1: Math.max(x0, x1), k, a }); };
  function lightsAt(scene, worldX) {
    if (scene !== lightScene) return [];
    const out = [], fl = FLOOR * 2;
    for (const L of LIGHTS) {
      if (L.patch) { const x0 = (L.x0 + lightCam) * 2, x1 = (L.x1 + lightCam) * 2; if (worldX >= x0 - 6 && worldX <= x1 + 6) out.push({ k: L.k, a: L.a * Math.min(1, (Math.min(worldX - x0, x1 - worldX) + 6) / 14), fade: .55 }); continue; }
      const lx = (L.x + lightCam) * 2, top = L.top * 2, hl = Math.max(60, fl - top), hw = L.reach * 2 * Math.max(.2, (FLOOR - L.top) / Math.max(1, 262 - L.top)) + 30, dx = worldX - lx;
      if (Math.abs(dx) > hw) continue;
      out.push({ k: Math.max(-3, Math.min(3, dx / Math.max(40, hl - 75))), a: L.a * Math.pow(1 - Math.abs(dx) / hw, .6), fade: .8, lx, top });
    }
    return out.sort((a, b) => b.a - a.a).slice(0, 3);
  }
  function slant(c, x0, x1, y0, dx, h, col) { c.fillStyle = col; for (let r = 0; r < h; r++) c.fillRect(Math.round(x0 + dx * (r + 1) / h), y0 + r, Math.max(1, Math.round(x1 - x0)), 1); }

  function farm(c, s, t, camL) {
    if (!far) far = buildFar(); if (!mids[0]) mids[0] = buildFarmMid();
    sky(c, s, t, camL);
    const sun = sunInfo(s), lean = sun.lean, la = Math.min(1, Math.abs(lean) * 1.3) * sun.str, rel = far[lean >= 0 ? 3 : 4];
    [.04, .1, .22].forEach((p, i) => { tile(c, far[i], camL * p); if (la > .03) { c.globalAlpha = la; tile(c, rel[i], camL * p); c.globalAlpha = 1; } if (i === 1) haze(c, s, t, camL, 120, 200); });
    for (const hx of FARM_HOUSES) { const x = hx - camL + 66; if (x < -30 || x > LW + 30) continue; for (let i = 0; i < 6; i++) { const k = (t * .22 + i / 6) % 1; c.fillStyle = `rgba(235,235,230,${(1 - k) * .5})`; const r = 2 + k * 4; c.fillRect(Math.round(x + Math.sin(t + i * 2) * 3 * k + k * 10 - r / 2), Math.round(119 - k * 34), Math.round(r), Math.round(r * .8)); } }
    c.drawImage(mids[0], camL, 0, LW, LH, 0, 0, LW, LH);
    { const snow = window.Weather?.state?.()?.cover || 0; if (snow > .05) { const a = Math.min(1, snow * 1.3); for (const hx of FARM_HOUSES) { const x = hx - camL; if (x < -140 || x > LW + 40) continue; for (let r2 = 0; r2 < 4; r2++) { const k = r2 / 10, xa = x + 8 - k * 18, xb = x + 78 + k * 24; R(c, xa, 136 + r2 * 2, xb - xa, 2, `rgba(250,252,255,${a * (1 - r2 * .2)})`); } R(c, x + 50, 112, 13, 2, `rgba(250,252,255,${a})`); } } }
    // sombras projetadas no chão: acompanham o sol (compridas cedo e no fim da tarde)
    if (sun.str > .04) { const sh = `rgba(18,30,52,${.30 * sun.str})`, reach = lean * (14 + Math.abs(lean) * 26);
      for (const hx of FARM_HOUSES) { const x = hx - camL; if (x > -160 && x < LW + 160) { slant(c, x - 3, x + 94, 215, reach * 1.6, 5, sh); shadeAdd(x - 3 + reach * 1.6, x + 94 + reach * 1.6, 1); } }
      { const x = 985 - camL; if (x > -160 && x < LW + 160) slant(c, x - 4, x + 82, 219, reach, 3, sh); }
      for (const [fx, fw] of FARM_FENCES) { if (fx - camL > LW + 40 || fx + fw - camL < -40) continue; for (let xx = fx; xx < fx + fw; xx += 16.5) slant(c, xx - camL, xx - camL + 3, 212, reach * .7, 4, sh); slant(c, fx - camL, fx + fw - camL, 214, reach * .5, 2, `rgba(18,30,52,${.14 * sun.str})`); }
      for (const [tx, base, sc, kind] of FARM_TREES) { const x = tx - camL; if (x < -120 || x > LW + 120) continue; slant(c, x - 2, x + 3, base, reach * .8, 5, sh); ell(c, x + reach * (kind ? 1.5 : 1.2) * sc, base + 4, (kind ? 16 : 24) * sc, 3.2, sh); { const cx = x + reach * (kind ? 1.5 : 1.2) * sc, r = (kind ? 16 : 24) * sc; shadeAdd(cx - r, cx + r, .9, true); } } }
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
  function farmLights(g, s, t, camL) { if (s.night <= .15) return; for (const hx of FARM_HOUSES) { const x = hx - camL; if (x < -140 || x > LW + 60) continue; for (const wx of [16, 75]) { lightAdd(x + wx, 184, .7 * s.night, 40); const gr = g.createRadialGradient(x + wx, 184, 2, x + wx, 186, 34); gr.addColorStop(0, `rgba(255,200,110,${.5 * s.night})`); gr.addColorStop(1, 'rgba(255,200,110,0)'); g.fillStyle = gr; g.fillRect(x + wx - 36, 150, 72, 72); g.fillStyle = `rgba(255,226,150,${.9 * s.night})`; g.fillRect(Math.round(x + wx - 7), 177, 15, 15); } const gl = g.createRadialGradient(x + 61, 177, 1, x + 61, 180, 30); gl.addColorStop(0, `rgba(255,220,150,${.8 * s.night})`); gl.addColorStop(1, 'rgba(255,220,150,0)'); g.fillStyle = gl; g.fillRect(x + 30, 148, 62, 62); } }


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
          gquad(g, [[wx + sh, fy], [wx + GW.w + sh, fy], [wx + GW.w + sh + lean * fh, fy + fh], [wx + sh + lean * fh, fy + fh]], css(col, .30 * sun.str)); if (n === 0) patchAdd(wx + lean * 10, wx + GW.w + lean * 56, lean * 1.1, .6 * sun.str); // listra no chão
          if (n % 2 === 0 || gh > 2) gquad(g, [[wx, gy], [wx + GW.w, gy], [wx + GW.w + sh, fy], [wx + sh, fy]], css(col, (gh > 2 ? .07 : .028) * sun.str)); }); // lâmina de luz no ar
        for (let k = 0; k < 7; k++) { const u = (t * .1 + hash(k + i * 9)) % 1, px = wx + hash(k * 3 + i) * GW.w + lean * 30 * u, py = GW.y + u * (FLOOR - GW.y); g.fillStyle = css(col, .55 * sun.str * (.5 + .5 * Math.sin(t * 3 + k + i))); g.fillRect(Math.round(px), Math.round(py), 1, 1); } }
      // luminária de tungstênio: sempre acesa, mais forte à noite
      const lx = wx + 114, a = .32 + s.night * .5, _l = lightAdd(lx, 44, a * 1.1, 52), gr = g.createLinearGradient(0, 44, 0, LH); gr.addColorStop(0, `rgba(255,214,140,${.24 * a})`); gr.addColorStop(1, `rgba(255,214,140,${.03 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(lx - 10, 44); g.lineTo(lx + 11, 44); g.lineTo(lx + 52, LH); g.lineTo(lx - 51, LH); g.closePath(); g.fill();
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
  function floodBeam(g, x, top, a, reach) { if (a < .02) return; lightAdd(x + 2, top - 4, a, reach); const gr = g.createLinearGradient(0, top, 0, 262); gr.addColorStop(0, `rgba(235,240,255,${.34 * a})`); gr.addColorStop(1, `rgba(235,240,255,${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(x - 8, top - 4); g.lineTo(x + 12, top - 4); g.lineTo(x + reach, 262); g.lineTo(x - reach + 4, 262); g.closePath(); g.fill(); const b = g.createRadialGradient(x + 2, top - 4, 1, x + 2, top - 4, 30); b.addColorStop(0, `rgba(255,250,225,${.9 * a})`); b.addColorStop(1, 'rgba(255,250,225,0)'); g.fillStyle = b; g.fillRect(x - 30, top - 36, 64, 64); g.save(); g.translate(x + 2, 232); g.scale(1, .3); const p = g.createRadialGradient(0, 0, 0, 0, 0, reach); p.addColorStop(0, `rgba(235,240,255,${.3 * a})`); p.addColorStop(1, 'rgba(235,240,255,0)'); g.fillStyle = p; g.fillRect(-reach, -reach, reach * 2, reach * 2); g.restore(); }
  function board(c, x, y, w, h, col, edge) { R(c, x - 1, y - 1, w + 2, h + 2, edge); R(c, x, y, w, h, col); R(c, x, y, w, 1, 'rgba(255,255,255,.2)'); for (const [bx, by] of [[x + 1, y + 1], [x + w - 2, y + 1], [x + 1, y + h - 2], [x + w - 2, y + h - 2]]) R(c, bx, by, 1, 1, '#d9cc9e'); }
  function backdrop(c, s, t, camL, cityKey) { if (!far) far = buildFar(); const sun = sunInfo(s), la = Math.min(1, Math.abs(sun.lean) * 1.3) * sun.str, rel = far[sun.lean >= 0 ? 3 : 4]; sky(c, s, t, camL); tile(c, far[0], camL * .04); if (la > .03) { c.globalAlpha = la; tile(c, rel[0], camL * .04); c.globalAlpha = 1; } tile(c, far[1], camL * .1 + 300); if (la > .03) { c.globalAlpha = la; tile(c, rel[1], camL * .1 + 300); c.globalAlpha = 1; } haze(c, s, t, camL, 110, 190); tile(c, city(cityKey[0], cityKey[1])[0], camL * .07); return sun; }

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
      { const x = 356 - camL; if (x > -260 && x < LW + 100) { slant(c, x, x + 183, 219, reach * 1.2, 4, sh); shadeAdd(x + reach * 1.2, x + 183 + reach * 1.2, .75); } } { const x = 1265 - camL; if (x > -90 && x < LW + 90) { const cx = x + reach * 1.2; ell(c, cx, 221, 18, 2.5, sh); shadeAdd(cx - 18, cx + 18, .9, true); } } }
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
      for (const gx of FIELD_GOALS) { const x = gx - camL; if (x < -200 || x > LW + 200) continue; slant(c, x, x + 4, 219, reach * 1.5, 5, sh); slant(c, x + 87, x + 91, 219, reach * 1.5, 5, sh); slant(c, x + reach * 1.5, x + 91 + reach * 1.5, 223, reach * .2, 2, sh); shadeAdd(x + reach * 1.5, x + 91 + reach * 1.5, .45); }
      for (const fx of FIELD_FLOODS) slant(c, fx - camL, fx - camL + 4, 163, reach * 1.2, 6, sh);
      for (let x = 95; x < worldW(7); x += 480) { const sx = x - camL; if (sx > -300 && sx < LW + 100) slant(c, sx - 16, sx + 192, 164, reach, 5, sh); } }
    { const bx = 890 + Math.sin(t * .7) * 11 - camL, by = 213 - Math.abs(Math.sin(t * 2.8)) * 9; ell(c, bx, 218, 4, 1, 'rgba(0,0,0,.25)'); ell(c, bx, by, 4.5, 4.5, '#2a2a2a'); ell(c, bx, by, 3.6, 3.6, '#f4f4ea'); const a = t * 5; R(c, bx - 1 + Math.cos(a) * 1.5, by - 1 + Math.sin(a) * 1.5, 2, 2, '#2a2a2a'); R(c, bx + Math.cos(a + 2.4) * 2.6, by + Math.sin(a + 2.4) * 2.6, 1, 1, '#2a2a2a'); R(c, bx + Math.cos(a + 4.2) * 2.6, by + Math.sin(a + 4.2) * 2.6, 1, 1, '#2a2a2a'); }
  }
  function fieldText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#eff5de'; c.fillText('CAMPO DO MOTA · MOTA FC', 521, 224); c.restore(); }
  function fieldLights(g, s, t, camL) { if (s.night <= .12) return; const a = cl((s.night - .12) * 1.4); g.save(); g.beginPath(); g.rect(0, 0, LW, 86); g.clip(); g.globalAlpha = a; tile(g, city(19, 132)[1], camL * .07); g.restore(); g.globalAlpha = a * .5; { const o = Math.round(camL * .3) % 1400; g.drawImage(fieldBack[1], -o, 0); if (1400 - o < LW) g.drawImage(fieldBack[1], 1400 - o, 0); } g.globalAlpha = 1; g.clearRect(174 - camL, 101, 173, 21); for (let x = 95; x < worldW(7); x += 480) g.clearRect(x - 24 - camL, 118, 208, 46); for (const x of FIELD_FLOODS) { const sx = x - camL; if (sx < -200 || sx > LW + 200) continue; floodBeam(g, sx, 46, a * (.92 + .08 * Math.sin(t * 30 + x)), 120); } }

  // parede iluminada de um lado e sombreada do outro, conforme o sol
  function sunWall(c, x, y, w, h, lean, a) { if (a < .03) return; const n = Math.min(26, Math.floor(w * .4)); for (let k = 0; k < n; k++) { const f = 1 - k / n; if (f < .4 && (k & 1)) continue; c.fillStyle = `rgba(255,240,190,${.28 * a * f})`; c.fillRect(Math.round(lean >= 0 ? x + k : x + w - 1 - k), y, 1, h); c.fillStyle = `rgba(30,24,60,${.24 * a * f})`; c.fillRect(Math.round(lean >= 0 ? x + w - 1 - k : x + k), y, 1, h); } }
  const hexv = (h) => [parseInt(h.slice(1, 3), 16) / 255, parseInt(h.slice(3, 5), 16) / 255, parseInt(h.slice(5, 7), 16) / 255];

  // ------------------------------------------------------------------------------- FAVELA (mapa 5)
  const FV_COL = ['#bf7956', '#d4a06d', '#c48b70', '#a8b29b', '#b7855e', '#9b9fa0', '#d98a8a', '#8fb0c4'];
  function fHouse(c, L, x, y, w, h, seed, haze) {
    x = Math.round(x); y = Math.round(y); w = Math.round(w); h = Math.round(h);
    const hz = (col, k = haze) => (k ? css(mix(hexv(col), [.62, .7, .72], k)) : col), front = !haze, pal = FV_COL[Math.abs(seed) % FV_COL.length], plaster = seed % 2 === 0;
    R(c, x, y, w, h, hz('#513e38')); R(c, x + 1, y + 2, w - 2, h - 2, hz(plaster ? pal : '#b8704e'));
    if (!plaster) { for (let ry = y + 3; ry < y + h - 1; ry += 3) { R(c, x + 1, ry + 2, w - 2, 1, hz('#8f5238')); for (let bx = x + 1 + ((ry / 3) & 1) * 3; bx < x + w - 2; bx += 6) { R(c, bx, ry, 1, 2, hz('#8f5238')); if (front && hash(bx * 7 + ry + seed) > .8) R(c, bx + 1, ry, 4, 2, '#cf8866'); } } }
    else if (front) { for (let i = 0; i < w * h / 26; i++) R(c, x + 2 + hash(i + seed * 3) * (w - 4), y + 3 + hash(i + seed * 5) * (h - 5), 1, 1, hash(i) > .5 ? 'rgba(255,255,255,.14)' : 'rgba(0,0,0,.10)'); R(c, x + 1, y + h - 9, w - 2, 9, 'rgba(60,40,30,.16)'); for (let i = 0; i < 3; i++) { const sx = x + 4 + hash(i + seed) * (w - 10); R(c, sx, y + 3, 1, 6 + hash(i + seed + 2) * 14, 'rgba(60,40,30,.16)'); } }
    R(c, x - 3, y - 4, w + 6, 5, hz('#71645a')); R(c, x - 3, y - 4, w + 6, 1, hz('#b2a58a')); R(c, x - 3, y, w + 6, 1, hz('#4a3f38')); c.fillStyle = 'rgba(30,20,30,.2)'; c.fillRect(x + 1, y + 2, w - 2, 2);
    const wy = y + 9, wh = Math.min(21, h - 14), ww = Math.min(15, Math.round(w * .3));
    for (let k = 0; k < 2; k++) { const wx = Math.round(x + 6 + k * (w * .48)); R(c, wx, wy, ww, wh, hz('#395462')); R(c, wx + 1, wy + 1, ww - 2, wh - 3, hz(seed % 3 ? '#84b6c0' : '#e1c892')); R(c, wx + 1, wy + 1, ww - 2, 4, hz(seed % 3 ? '#a8d2d8' : '#f0dcae')); R(c, wx + Math.floor(ww / 2), wy, 1, wh, hz('#dbd3b6')); R(c, wx - 1, wy + wh, ww + 2, 1, hz('#b2a58a'));
      if (front) { for (let b = 2; b < ww - 1; b += 3) R(c, wx + b, wy + 1, 1, wh - 3, 'rgba(40,50,60,.5)'); if ((seed + k) % 3 === 1) { R(c, wx + 1, wy + wh - 4, 3, 3, '#b0603a'); R(c, wx + 1, wy + wh - 7, 3, 3, '#4f9a3f'); R(c, wx + 2, wy + wh - 8, 1, 1, '#e86a8a'); } if ((seed + k) % 3 === 0) { R(c, wx + 4, wy + wh - 9, 5, 5, ['#c8946a', '#8a5a3c', '#f0c8a0'][seed % 3]); R(c, wx + 4, wy + wh - 10, 5, 2, '#2a1e18'); R(c, wx + 3, wy + wh - 4, 7, 2, FV_COL[(seed + 3) % 8]); } if ((seed + k) % 5 === 2) { R(c, wx + 1, wy + wh + 2, 10, 6, '#cfd8dc'); R(c, wx + 2, wy + wh + 4, 8, 1, '#8fa1a6'); R(c, wx + 2, wy + wh + 6, 8, 1, '#8fa1a6'); } }
      if (L && hash(seed * 13 + k) > .42) { L.fillStyle = hash(seed + k) > .5 ? '#ffd98a' : '#ffe9b8'; L.fillRect(wx + 1, wy + 1, ww - 2, wh - 3); } }
    if (front && h > 44) { const dx = Math.round(x + w * .39); R(c, dx, y + h - 31, 14, 31, '#3a443e'); R(c, dx + 1, y + h - 30, 12, 30, seed % 2 ? '#647b6f' : '#7a5a3a'); R(c, dx + 1, y + h - 30, 1, 30, 'rgba(255,255,255,.2)'); R(c, dx + 10, y + h - 15, 2, 2, '#d4b584'); R(c, dx + 3, y + h - 26, 8, 9, 'rgba(0,0,0,.18)'); R(c, dx - 2, y + h, 18, 1, '#b3a585'); }
    if (front) { R(c, x + 4, y - 12, 18, 8, '#2c5f94'); R(c, x + 4, y - 12, 18, 2, '#5a94c8'); R(c, x + 3, y - 13, 20, 2, '#3a7ab8'); R(c, x + 20, y - 11, 2, 7, '#1f4a78'); R(c, x + w - 11, y - 12, 1, 9, '#414d4c'); R(c, x + w - 17, y - 13, 13, 1, '#414d4c'); R(c, x + w - 15, y - 10, 9, 1, '#414d4c');
      for (const rx of [x - 1, x + w - 1, x + Math.round(w / 2)]) R(c, rx, y - 9, 1, 5, '#5a4a40');
      if (seed % 4 === 1) { ell(c, x + w - 24, y - 8, 5, 4, '#b9c3bf'); ell(c, x + w - 23, y - 8, 3, 2.5, '#8fa1a6'); R(c, x + w - 24, y - 5, 1, 2, '#414d4c'); }
      if (seed % 3 === 1) { R(c, x + 26, y - 10, 1, 6, '#5a4a40'); R(c, x + w - 30, y - 10, 1, 6, '#5a4a40'); R(c, x + 26, y - 10, w - 55, 1, '#3a3a3a'); for (let k = 0; k < Math.floor((w - 60) / 7); k++) R(c, x + 29 + k * 7, y - 9, 5, 5, ['#e0c17c', '#6697ac', '#dc8666', '#f0f0f0'][(k + seed) % 4]); }
      if (seed % 4 === 0) { const gx = x + 5, gy = y + h - 16, col = ['#e84a8a', '#3ad0c0', '#f2d24a', '#8a5ae8'][seed % 4 + (seed >> 2) % 3 > 3 ? 0 : (seed >> 2) % 4]; for (let k = 0; k < 16; k++) R(c, gx + k, gy + Math.round(Math.sin(k * .9) * 3) + 4, 2, 2, col); R(c, gx + 2, gy + 1, 3, 8, col); R(c, gx + 10, gy, 2, 9, col); } }
  }
  const FV_BACK = [];
  function buildFavelaBack(n, step, y0, yv, w, hBase, hv, haze, sd) { const T = Math.round(n * step), D = mk(T, 230), L = mk(T, 230); for (let i = 0; i < n; i++) { const yy = y0 + (i % (yv > 20 ? 4 : 3)) * (yv > 20 ? 15 : 8), h = hBase + (i % 3) * hv; R(D[1], Math.round(i * step), yy + h - 2, Math.round(step) + 1, 230, css(mix([.45, .42, .4], [.62, .7, .72], haze))); } for (let i = 0; i < n; i++) { const yy = y0 + (i % (yv > 20 ? 4 : 3)) * (yv > 20 ? 15 : 8); fHouse(D[1], L[1], i * step, yy, w, hBase + (i % 3) * hv, i + sd, haze); } return [D[0], L[0]]; }
  const FV_SIGNS = []; { for (let x = 435, i = 0; x < 3600; x += 450, i++) FV_SIGNS.push([x, i]); }
  const fvHouse = (i) => ({ x: i * 105, y: 136 + (i % 2) * 14, w: 94, h: 82 - (i % 2) * 14 });
  function buildFavelaMid() {
    const W = worldW(5), [cv, c] = mk(W, LH), [lv, l] = mk(W, LH);
    R(c, 0, 199, W, 21, '#968a73'); R(c, 0, 199, W, 1, '#b8ab90'); for (let i = 0; i < W; i++) R(c, hash(i + 3) * W, 200 + hash(i + 4) * 19, 2, 1, i % 2 ? '#857a66' : '#a69a82');
    for (let i = 0; i * 105 < W; i++) { const h = fvHouse(i); fHouse(c, l, h.x, h.y, h.w, h.h, i + 100, 0); for (let k = 0; k < 3; k++) { R(c, h.x + 95 + k * 1.5, h.y + 39 + k * 4 + (i % 2 ? 0 : 0) + (82 - h.h) * 0 + (h.h - 43 - 12) , 8 - k * 1.5, 4, ['#b3a585', '#a69b81', '#958c78'][k]); R(c, h.x + 95 + k * 1.5, h.y + h.h - 16 + k * 4, 8 - k * 1.5, 1, '#d0c4a4'); } }
    // chão: asfalto remendado, meio-fio, bueiro e poças
    R(c, 0, FLOOR, W, 50, '#887f7a'); R(c, 0, 242, W, 28, '#7a716c'); dither(c, 0, 241, W, '#7a716c');
    for (let i = 0; i < W * 2; i++) R(c, hash(i + 13) * W, 225 + hash(i + 14) * 44, 1 + hash(i) * 2, 1, ['#766d68', '#9a918c', '#625c5c'][i % 3]);
    for (let i = 0; i < W / 70; i++) { const x = hash(i + 23) * W, w2 = 14 + hash(i + 24) * 22; R(c, x, 228 + hash(i + 25) * 24, w2, 5 + hash(i + 26) * 6, '#6a625e'); R(c, x, 228 + hash(i + 25) * 24, w2, 1, '#7d7570'); }
    for (let i = 0; i < W / 55; i++) { let x = hash(i + 33) * W, y = 226; for (let k = 0; k < 10 + hash(i) * 12; k++) { R(c, x, y, 1, 1, '#4f4947'); x += hash(i * 5 + k) > .45 ? 1 : -1; y += hash(i * 3 + k) > .4 ? 1 : 0; } }
    for (let x = 160; x < W; x += 330) { R(c, x, 226, 14, 6, '#4a4543'); for (let k = 1; k < 14; k += 3) R(c, x + k, 227, 1, 4, '#2a2726'); }
    R(c, 0, FLOOR, W, 3, '#a6a49a'); R(c, 0, FLOOR, W, 1, '#c9c7bc'); R(c, 0, FLOOR + 3, W, 2, '#625c5c'); for (let x = 0; x < W; x += 20) R(c, x, FLOOR, 1, 3, '#8a8880');
    // placas, quiosques e postes
    for (const [x, i] of FV_SIGNS) { board(c, x, 147, 64, 37, '#2a5b65', '#1f3d44'); R(c, x + 2, 149, 60, 1, '#3f7a84'); R(c, x + 30, 184, 3, 35, '#3c5358'); R(c, x + 70, 196, 15, 23, '#395f59'); R(c, x + 69, 193, 17, 4, '#82a087'); R(c, x + 73, 200, 9, 8, '#22403c'); R(c, x + 74, 201, 3, 3, '#f0c84a'); }
    for (let x = 0; x < W; x += 195) { R(c, x, 58, 3, 162, '#4b5b56'); R(c, x, 58, 1, 162, '#6f807a'); R(c, x - 8, 62, 19, 2, '#394b4f'); R(c, x - 8, 60, 1, 2, '#9aa8a0'); R(c, x + 10, 60, 1, 2, '#9aa8a0'); R(c, x + 3, 84, 10, 2, '#394b4f'); R(c, x + 10, 86, 5, 3, '#2a3a3c'); R(c, x + 11, 89, 3, 1, '#ffe9a8'); R(c, x - 3, 112, 9, 11, '#5a6a64'); R(c, x - 2, 113, 7, 3, '#8a9a92'); for (let k = 0; k < 4; k++) R(c, x - 1 + k * 2, 150 + k * 3, 6, 1, 'rgba(240,240,230,.5)'); }
    return [cv, lv];
  }
  function favela(c, s, t, camL) {
    if (!far) far = buildFar(); if (!mids[5]) mids[5] = buildFavelaMid();
    if (!FV_BACK.length) { FV_BACK.push(buildFavelaBack(10, 90.5, 47, 30, 87, 58, 8, .5, 20), buildFavelaBack(12, 79.5, 100, 8, 75, 64, 0, .25, 8)); }
    const sun = sunInfo(s), la = Math.min(1, Math.abs(sun.lean) * 1.3) * sun.str;
    sky(c, s, t, camL); tile(c, far[0], camL * .04); if (la > .03) { c.globalAlpha = la; tile(c, far[sun.lean >= 0 ? 3 : 4][0], camL * .04); c.globalAlpha = 1; }
    tile(c, FV_BACK[0][0], camL * .2); tile(c, FV_BACK[1][0], camL * .48);
    c.drawImage(mids[5][0], camL, 0, LW, LH, 0, 0, LW, LH);
    // sol nas fachadas, sombra das lajes e dos postes
    if (sun.str > .04) { const a = Math.min(1, Math.abs(sun.lean) * 1.4) * sun.str, sh = `rgba(18,24,48,${.28 * sun.str})`, reach = sun.lean * (14 + Math.abs(sun.lean) * 26);
      for (let i = Math.max(0, Math.floor((camL - 100) / 105)); i * 105 < camL + LW + 10; i++) { const h = fvHouse(i), x = h.x - camL; sunWall(c, x + 1, h.y + 2, h.w - 2, h.h - 2, sun.lean, a); slant(c, x - 3, x + h.w + 3, h.y + 1, reach * .25, 3 + Math.round(Math.abs(sun.lean) * 4), `rgba(18,24,48,${.2 * sun.str})`); slant(c, x, x + h.w, 218, reach, 2, sh); }
      for (let x = Math.floor(camL / 195) * 195 - 195; x < camL + LW + 195; x += 195) slant(c, x - camL, x - camL + 3, 219, reach * 1.5, 6, sh); }
    // fios com roupa estendida
    for (let x = Math.floor(camL / 195) * 195; x < camL + LW + 200; x += 195) { const x1 = x - 195 - camL, x2 = x - camL; for (let k = 0; k <= 48; k++) { const u = k / 48, px = x1 + (x2 - x1) * u, py = 63 + Math.sin(u * Math.PI) * 26; R(c, px, py, (x2 - x1) / 48 + 1, 1, '#394b4f'); R(c, px, py + 22 - Math.sin(u * Math.PI) * 8, (x2 - x1) / 48 + 1, 1, 'rgba(40,52,56,.7)'); }
      for (let j = 0; j < 4; j++) { const u = .25 + j * .12, px = x1 + (x2 - x1) * u, py = 64 + Math.sin(u * Math.PI) * 26; for (let r2 = 0; r2 < 13; r2++) { const wv = Math.round(Math.sin(t * 3 + j + r2 * .25) * (r2 / 12) * 2.2); R(c, px + wv, py + r2, 11, 1, ['#e0c17c', '#6697ac', '#dc8666', '#d8d0a7'][j]); R(c, px + wv, py + r2, 1, 1, 'rgba(0,0,0,.18)'); } } }
    // pipa no céu
    for (let i = 0; i < 2; i++) { const kx = ((300 + i * 420 - camL * .3) % 700 + 700) % 700 - 60, ky = 34 + i * 18 + Math.sin(t * .9 + i * 2) * 8, col = i ? '#e84a4a' : '#f2d24a'; for (let k = 0; k < 5; k++) { R(c, kx - k, ky - 4 + k, k * 2 + 1, 1, col); R(c, kx - (4 - k), ky + 1 + k, (4 - k) * 2 + 1, 1, col); } for (let k = 0; k < 14; k++) R(c, kx + Math.round(Math.sin(t * 4 + k * .6) * 2), ky + 6 + k, 1, 1, k % 3 ? '#e8e0d0' : '#3a7fd0'); }
  }
  function favelaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; for (const [x, i] of FV_SIGNS) { if (x * 2 < camera - 200 || x * 2 > camera + 1160) continue; c.font = '16px Pixel, monospace'; c.fillStyle = '#b0dfc5'; const tx = i > 4 ? ['ALTO DO', 'MORRO'] : ['RESPEITA', 'A RESENHA']; c.fillText(tx[0], x * 2 + 64, 310); c.fillText(tx[1], x * 2 + 64, 328); c.font = '8px Pixel, monospace'; c.fillStyle = '#e8d9a0'; c.fillText('GABRIEL REEIS', x * 2 + 64, 352); } c.restore(); }
  function favelaLights(g, s, t, camL) { if (s.night <= .12) return; const a = cl((s.night - .12) * 1.4); g.globalAlpha = a * .4; tile(g, FV_BACK[0][1], camL * .2); g.globalCompositeOperation = 'destination-out'; g.globalAlpha = 1; tile(g, FV_BACK[1][0], camL * .48); g.globalCompositeOperation = 'source-over'; g.globalAlpha = a * .5; tile(g, FV_BACK[1][1], camL * .48); g.globalCompositeOperation = 'destination-out'; g.globalAlpha = 1; g.drawImage(mids[5][0], camL, 0, LW, 219, 0, 0, LW, 219); g.globalCompositeOperation = 'source-over'; g.globalAlpha = a * .6; g.drawImage(mids[5][1], camL, 0, LW, LH, 0, 0, LW, LH); g.globalAlpha = 1;
    for (let x = Math.floor(camL / 195) * 195 - 195; x < camL + LW + 195; x += 195) { const sx = x - camL + 12, _l = lightAdd(x - camL + 12, 90, a, 60), gr = g.createLinearGradient(0, 90, 0, 262); gr.addColorStop(0, `rgba(255,206,130,${.34 * a})`); gr.addColorStop(1, `rgba(255,206,130,${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 3, 90); g.lineTo(sx + 4, 90); g.lineTo(sx + 58, 262); g.lineTo(sx - 56, 262); g.closePath(); g.fill(); const b = g.createRadialGradient(sx, 90, 1, sx, 92, 24); b.addColorStop(0, `rgba(255,226,160,${.85 * a})`); b.addColorStop(1, 'rgba(255,226,160,0)'); g.fillStyle = b; g.fillRect(sx - 26, 64, 52, 52); g.save(); g.translate(sx, 230); g.scale(1, .28); const p = g.createRadialGradient(0, 0, 0, 0, 0, 62); p.addColorStop(0, `rgba(255,206,130,${.32 * a})`); p.addColorStop(1, 'rgba(255,206,130,0)'); g.fillStyle = p; g.fillRect(-62, -62, 124, 124); g.restore(); } }

  // ------------------------------------------------------------------------------- PÁTIO (mapa 9), com referências a Taylor Swift
  // Homenagem só com símbolos: as eras em cores, o número 13, pulseiras da amizade, gatos,
  // violão com brilhos, cachecol vermelho, cardigã e globo espelhado. Sem retrato nem letras de música.
  const PT_MURAL = { 5: 'eras', 12: 'violao', 17: 'gatos' }, PT_WIN = (i) => 27.5 + i * 93.5;
  const ERAS = ['#7fc8a0', '#e8c84a', '#9a6ad0', '#d83a3a', '#7ac8e8', '#2a2a2a', '#f08ab8', '#b8b0a0', '#c98a5a', '#2a3a78', '#d8d0c0'];
  const PT_LAMPS = []; { for (let x = 375; x < 2100; x += 425) PT_LAMPS.push(x); }
  function ptPoster(c, x, y, k) { R(c, x - 1, y - 1, 26, 32, '#8a8f8a'); R(c, x, y, 24, 30, '#f3ead6');
    if (k === 0) { for (let e = 0; e < 11; e++) R(c, x + 1 + e * 2, y + 2, 2, 20, ERAS[e]); R(c, x + 3, y + 24, 18, 1, '#5a5a5a'); R(c, x + 6, y + 26, 12, 1, '#5a5a5a'); }
    else if (k === 1) { R(c, x, y, 24, 30, '#f7d8e4'); for (const [hx, hy] of [[4, 6], [15, 6]]) { R(c, x + hx, y + hy, 5, 3, '#d83a6a'); } R(c, x + 4, y + 9, 16, 3, '#d83a6a'); R(c, x + 6, y + 12, 12, 2, '#d83a6a'); R(c, x + 8, y + 14, 8, 2, '#d83a6a'); R(c, x + 10, y + 16, 4, 2, '#d83a6a'); R(c, x + 7, y + 21, 2, 6, '#3a3a3a'); R(c, x + 12, y + 21, 5, 1, '#3a3a3a'); R(c, x + 16, y + 22, 1, 2, '#3a3a3a'); R(c, x + 13, y + 23, 4, 1, '#3a3a3a'); R(c, x + 16, y + 24, 1, 2, '#3a3a3a'); R(c, x + 12, y + 26, 5, 1, '#3a3a3a'); } // coração e 13
    else if (k === 2) { R(c, x, y, 24, 30, '#d8e8f0'); const cat = (cx, col) => { R(c, cx, y + 12, 6, 9, col); R(c, cx, y + 8, 6, 5, col); R(c, cx, y + 6, 2, 2, col); R(c, cx + 4, y + 6, 2, 2, col); R(c, cx + 1, y + 10, 1, 1, '#2a2a2a'); R(c, cx + 4, y + 10, 1, 1, '#2a2a2a'); R(c, cx + 6, y + 17, 2, 1, col); R(c, cx + 7, y + 14, 1, 3, col); }; cat(x + 2, '#f0f0f0'); cat(x + 9, '#c8a078'); cat(x + 16, '#8a8a8a'); R(c, x + 4, y + 24, 16, 1, '#5a5a5a'); }
    else if (k === 3) { R(c, x, y, 24, 30, '#2a3a78'); for (let i = 0; i < 9; i++) { const sx = x + 2 + hash(i + 7) * 20, sy = y + 2 + hash(i + 9) * 26; R(c, sx, sy, 1, 1, '#fff6c8'); if (i % 3 === 0) { R(c, sx - 1, sy, 3, 1, '#fff6c8'); R(c, sx, sy - 1, 1, 3, '#fff6c8'); } } ell(c, x + 12, y + 19, 5, 6, '#c98a5a'); ell(c, x + 12, y + 14, 3.5, 4, '#c98a5a'); ell(c, x + 12, y + 18, 1.5, 1.5, '#3a2a1a'); R(c, x + 11, y + 3, 2, 12, '#7a5a3a'); R(c, x + 10, y + 2, 4, 3, '#3a2a1a'); }
    else if (k === 4) { R(c, x, y, 24, 30, '#1a1a1a'); for (let i = 0; i < 22; i++) { const a = i / 22 * 5.2, px = x + 12 + Math.cos(a) * (2 + i * .38), py = y + 15 + Math.sin(a) * (2 + i * .42); R(c, px, py, 2, 2, i % 4 ? '#3aa86a' : '#c8e86a'); } R(c, x + 20, y + 13, 2, 2, '#3aa86a'); R(c, x + 22, y + 14, 1, 1, '#e84a4a'); }
    else { R(c, x, y, 24, 30, '#f2d0e0'); ell(c, x + 12, y + 13, 8, 8, '#e8e8f0'); for (let i = 0; i < 26; i++) { const gx2 = x + 5 + (i % 6) * 2.6 + ((i / 6) & 1), gy = y + 7 + Math.floor(i / 6) * 2.8; R(c, gx2, gy, 2, 2, ['#ffffff', '#b8c8e8', '#f8c8e0', '#c8f0e8'][i % 4]); } R(c, x + 12, y + 1, 1, 5, '#5a5a5a'); R(c, x + 5, y + 25, 14, 1, '#8a4a6a'); } // globo espelhado
    R(c, x + 11, y - 2, 2, 2, '#c94f45'); }
  function buildPatioMid() {
    const W = worldW(9), [cv, c] = mk(W, LH), [lv, l] = mk(W, LH);
    // piso do pátio em lajotas com perspectiva
    let fy = 176; [4, 5, 6, 8, 9, 12].forEach((rh, r2) => { const tw = 18 + r2 * 4; for (let k = -1; k * tw < W; k++) { const x = k * tw + (r2 % 2) * tw / 2, lt = (k + r2) & 1; R(c, x, fy, tw, rh, lt ? css(mix([.78, .82, .78], [.87, .87, .78], r2 / 5)) : css(mix([.72, .77, .74], [.82, .83, .74], r2 / 5))); R(c, x, fy, tw, 1, 'rgba(255,255,255,.3)'); R(c, x, fy, 1, rh, 'rgba(90,110,110,.35)'); } fy += rh; }); R(c, 0, 176, W, 2, '#f1f0da');
    // fachada branca e azul-marinho
    R(c, 0, 106, W, 72, '#f0f4ef'); for (let i = 0; i < W * 1.4; i++) R(c, hash(i + 3) * W, 112 + hash(i + 4) * 48, 2, 1, i % 2 ? '#e3e9e3' : '#fafcf8'); R(c, 0, 106, W, 5, '#173e65'); R(c, 0, 106, W, 1, '#3a6a94'); R(c, 0, 111, W, 2, '#ffffff'); R(c, 0, 161, W, 17, '#254f75'); R(c, 0, 161, W, 2, '#183d5d'); R(c, 0, 163, W, 1, '#3a6a94'); for (let x = 0; x < W; x += 12) R(c, x, 164, 1, 14, '#1f4567');
    for (let i = 0; PT_WIN(i) < W; i++) { const x = Math.round(PT_WIN(i)), gap = x + 60;
      if (!PT_MURAL[i]) { R(c, x - 1, 121, 52, 34, '#1c3a50'); R(c, x, 122, 50, 32, '#294e68'); R(c, x + 2, 124, 46, 28, '#7bafb7'); R(c, x + 2, 124, 46, 9, '#9ccdd2'); for (let k = 0; k < 24; k++) R(c, x + 6 + Math.round((24 - k) * .5), 126 + k, 4, 1, 'rgba(255,255,255,.28)'); R(c, x + 24, 124, 2, 28, '#e6eee1'); R(c, x + 2, 137, 46, 2, '#e6eee1'); R(c, x - 3, 154, 56, 3, '#acbcb7'); R(c, x - 3, 154, 56, 1, '#d5e0da'); c.fillStyle = 'rgba(0,0,0,.12)'; c.fillRect(x - 1, 157, 52, 2); if (hash(i + 31) > .4) { l.fillStyle = '#ffe2a0'; l.fillRect(x + 2, 124, 46, 28); } }
      else if (PT_MURAL[i] === 'eras') { R(c, x - 2, 116, 88, 43, '#1c3a50'); for (let e = 0; e < 11; e++) { R(c, x + e * 7.6, 118, 8, 39, ERAS[e]); R(c, x + e * 7.6, 118, 1, 39, 'rgba(255,255,255,.25)'); const ix = x + e * 7.6 + 3, iy = 146; if (e % 4 === 0) { R(c, ix - 1, iy, 3, 1, '#fff6c8'); R(c, ix, iy - 1, 1, 3, '#fff6c8'); } else if (e % 4 === 1) { R(c, ix - 1, iy - 1, 1, 1, '#ffffff'); R(c, ix + 1, iy - 1, 1, 1, '#ffffff'); R(c, ix - 1, iy, 3, 1, '#ffffff'); R(c, ix, iy + 1, 1, 1, '#ffffff'); } else if (e % 4 === 2) { ell(c, ix, iy, 2, 2, '#ffffff'); } else { R(c, ix, iy - 2, 1, 4, '#ffffff'); R(c, ix - 1, iy + 1, 2, 2, '#ffffff'); } } R(c, x, 121, 84, 13, 'rgba(20,30,50,.55)'); }
      else if (PT_MURAL[i] === 'violao') { R(c, x - 2, 116, 88, 43, '#1c3a50'); R(c, x, 118, 84, 39, '#2a3a78'); for (let k = 0; k < 26; k++) { const sx = x + 2 + hash(k + 41) * 80, sy = 119 + hash(k + 43) * 36; R(c, sx, sy, 1, 1, '#fff6c8'); if (k % 3 === 0) { R(c, sx - 1, sy, 3, 1, '#fff6c8'); R(c, sx, sy - 1, 1, 3, '#fff6c8'); } } ell(c, x + 24, 144, 11, 9, '#c98a5a'); ell(c, x + 37, 141, 8, 7, '#c98a5a'); ell(c, x + 23, 143, 9, 7, '#dba06a'); ell(c, x + 28, 143, 3, 3, '#3a2a1a'); for (let k = 0; k < 30; k++) R(c, x + 42 + k, 139 - Math.round(k * .45), 2, 3, '#7a5a3a'); R(c, x + 71, 122, 7, 6, '#3a2a1a'); for (let k = 0; k < 44; k += 2) R(c, x + 27 + k, 142 - Math.round(k * .45), 1, 1, '#f0e8d0');
        R(c, x + 52, 143, 2, 11, '#f2d24a'); R(c, x + 58, 142, 8, 2, '#f2d24a'); R(c, x + 64, 144, 2, 4, '#f2d24a'); R(c, x + 59, 147, 7, 2, '#f2d24a'); R(c, x + 64, 149, 2, 4, '#f2d24a'); R(c, x + 58, 152, 8, 2, '#f2d24a'); } // 13
      else { R(c, x - 2, 116, 88, 43, '#1c3a50'); R(c, x, 118, 84, 39, '#f7d8e4'); const cat = (cx, col, col2) => { R(c, cx, 136, 16, 20, col); R(c, cx + 1, 126, 14, 12, col); R(c, cx + 1, 122, 4, 5, col); R(c, cx + 11, 122, 4, 5, col); R(c, cx + 2, 124, 2, 2, '#f0a0b0'); R(c, cx + 12, 124, 2, 2, '#f0a0b0'); R(c, cx + 4, 130, 2, 3, '#3a7a4a'); R(c, cx + 10, 130, 2, 3, '#3a7a4a'); R(c, cx + 7, 134, 2, 1, '#e87a8a'); R(c, cx + 2, 140, 12, 14, col2); R(c, cx + 16, 146, 4, 2, col); R(c, cx + 19, 140, 2, 7, col); }; cat(x + 5, '#f0f0f0', '#ffffff'); cat(x + 31, '#c8a078', '#e8d0b0'); cat(x + 57, '#8a8a8a', '#b0b0b0'); for (const [hx, hy] of [[26, 122], [52, 121], [78, 124]]) { R(c, x + hx, hy, 2, 2, '#d83a6a'); R(c, x + hx + 3, hy, 2, 2, '#d83a6a'); R(c, x + hx, hy + 2, 5, 1, '#d83a6a'); R(c, x + hx + 1, hy + 3, 3, 1, '#d83a6a'); R(c, x + hx + 2, hy + 4, 1, 1, '#d83a6a'); } }
      if (gap + 30 < W && !PT_MURAL[i]) { if (i % 3 === 0) { R(c, gap + 5, 116, 22, 13, '#cfd8dc'); R(c, gap + 5, 116, 22, 1, '#ffffff'); for (let k = 0; k < 4; k++) R(c, gap + 7, 119 + k * 2.5, 18, 1, '#8fa1a6'); R(c, gap + 14, 129, 1, 32, '#9fb0b0'); } else if (i % 3 === 1) ptPoster(c, gap + 5, 124, Math.floor(i / 3) % 6); else { R(c, gap + 15, 111, 3, 50, '#b9c8c4'); R(c, gap + 15, 111, 1, 50, '#e0ebe6'); R(c, gap + 14, 126, 5, 2, '#8fa1a0'); R(c, gap + 14, 146, 5, 2, '#8fa1a0'); } }
    }
    // marquise azul, colunas e fio de pulseiras da amizade entre elas
    R(c, 5, 93, W - 10, 8, '#163e63'); R(c, 5, 93, W - 10, 2, '#457c9d'); R(c, 5, 100, W - 10, 1, '#0e2a44'); c.fillStyle = 'rgba(10,20,40,.22)'; c.fillRect(5, 101, W - 10, 4);
    for (let x = 11; x < W; x += 182.5) { const next = x + 182.5; for (let k = 0; k <= 60; k++) { const u = k / 60, px = x + 5 + (next - x - 5) * u, py = 102 + Math.sin(u * Math.PI) * 9; if (px > W) break; R(c, px, py, 2, 2, ERAS[(k + Math.round(x)) % 11]); if (k % 6 === 3) R(c, px, py, 2, 2, '#ffffff'); } R(c, x, 100, 6, 78, '#becfcf'); R(c, x + 1, 100, 2, 78, '#f7f9ec'); R(c, x + 5, 100, 1, 78, '#8fa5a5'); R(c, x - 2, 174, 10, 4, '#7eaaad'); R(c, x - 1, 100, 8, 2, '#9fb5b5'); }
    board(c, 166, 114, 200, 23, '#1b4467', '#0e2a44');
    board(c, 1867, 140, 130, 26, '#32617b', '#1c3d50');
    // canteiros (as palmeiras são ao vivo), bancos com gente, postes
    for (const x of [35, 610, 1085, 1745]) { ell(c, x, 216, 27, 4, '#6e9b8b'); R(c, x - 25, 212, 49, 6, '#436d72'); R(c, x - 23, 212, 46, 2, '#b2d1bd'); for (let k = 0; k < 8; k++) R(c, x - 20 + k * 5.5, 210 - (k % 2), 2, 3, k % 3 ? '#4f9a3f' : '#e86a8a'); }
    [45, 730, 990, 1685].forEach((x, n) => { R(c, x, 186, 65, 4, '#386e9d'); R(c, x, 192, 65, 3, '#386e9d'); R(c, x, 186, 65, 1, '#6296b7'); R(c, x, 198, 65, 5, '#2c5e8e'); R(c, x + 2, 199, 61, 2, '#6296b7'); R(c, x + 4, 203, 4, 16, '#587e8d'); R(c, x + 56, 203, 4, 16, '#587e8d'); c.fillStyle = 'rgba(0,0,0,.18)'; c.fillRect(x + 2, 219, 61, 1);
      for (let j = 0; j < 2; j++) { const px = x + 18 + j * 22, sd = n * 2 + j; R(c, px, 188, 9, 10, FAN_SHIRT[sd % 6]); R(c, px + 1, 181, 7, 7, FAN_SKIN[sd % 5]); R(c, px + 1, 180, 7, 3, FAN_HAIR[(sd * 3) % 5]); R(c, px + 2, 184, 1, 1, '#1c1c22'); R(c, px + 5, 184, 1, 1, '#1c1c22'); R(c, px, 198, 4, 8, '#3a4a6a'); R(c, px + 5, 198, 4, 8, '#3a4a6a'); R(c, px + (j ? 8 : -2), 191, 3, 2, ERAS[(sd * 3) % 11]); }
      if (n === 1) { for (let k = 0; k < 14; k++) R(c, x + 48 + (k % 2), 186 + k, 5, 1, '#c8322e'); R(c, x + 47, 199, 7, 3, '#c8322e'); for (let k = 0; k < 3; k++) R(c, x + 47 + k * 2, 202, 1, 2, '#8a1f1c'); } // cachecol vermelho
      if (n === 2) { R(c, x + 2, 185, 13, 12, '#ece4d0'); R(c, x + 8, 185, 1, 12, '#b0a890'); R(c, x + 2, 195, 13, 2, '#3a3a5a'); for (const [sx, sy] of [[4, 188], [11, 190], [5, 192]]) R(c, x + sx, sy, 1, 1, '#3a3a5a'); } }); // cardigã
    for (const x of PT_LAMPS) { R(c, x, 82, 3, 95, '#365f75'); R(c, x, 82, 1, 95, '#5a8aa0'); R(c, x - 5, 75, 13, 8, '#244b69'); R(c, x - 3, 77, 9, 4, '#fff0b4'); R(c, x - 2, 174, 7, 3, '#244b69'); }
    // palquinho do show de talentos, microfone e mesa de troca de pulseiras
    R(c, 860, 196, 96, 5, '#8a6238'); R(c, 860, 196, 96, 1, '#b88a56'); for (let k = 0; k < 96; k += 12) R(c, 860 + k, 197, 1, 4, '#6a4a2a'); R(c, 906, 172, 1, 24, '#3a3a3a'); R(c, 904, 169, 5, 4, '#8a8a9a'); R(c, 904, 169, 5, 1, '#e0e0f0'); for (let k = 0; k < 5; k++) R(c, 905 + (k % 2) * 3, 168 - k % 3, 1, 1, '#fff6c8'); R(c, 902, 195, 9, 1, '#3a3a3a');
    R(c, 930, 178, 12, 18, '#c98a5a'); R(c, 932, 176, 8, 3, '#c98a5a'); R(c, 935, 160, 2, 17, '#7a5a3a'); R(c, 934, 158, 4, 3, '#3a2a1a'); ell(c, 936, 188, 2, 2, '#3a2a1a');
    R(c, 1378, 196, 56, 4, '#f08ab8'); R(c, 1378, 196, 56, 1, '#ffc0dc'); R(c, 1380, 200, 3, 19, '#8a6238'); R(c, 1429, 200, 3, 19, '#8a6238'); for (let k = 0; k < 8; k++) { R(c, 1381 + k * 6.5, 192, 5, 4, '#f3ead6'); for (let b = 0; b < 4; b++) R(c, 1381 + k * 6.5 + b, 193 + (b % 2), 1, 1, ERAS[(k * 3 + b) % 11]); } R(c, 1378, 200, 56, 8, 'rgba(240,138,184,.5)');
    // chão de pedra clara
    R(c, 0, FLOOR, W, 50, '#c3ccca'); R(c, 0, 242, W, 28, '#b3bdbb'); dither(c, 0, 241, W, '#b3bdbb'); for (let x = 0; x < W; x += 26.5) { R(c, x, 225, 1, 45, '#9aaeb0'); R(c, x + 1, 225, 1, 45, '#d8e0dc'); } R(c, 0, 249, W, 1, '#9aaeb0');
    for (let i = 0; i < W * 1.5; i++) R(c, hash(i + 53) * W, 226 + hash(i + 54) * 43, 1 + hash(i) * 2, 1, i % 3 ? '#b0bab8' : '#d5ddd9');
    R(c, 0, FLOOR, W, 3, '#f2f3df'); R(c, 0, FLOOR, W, 1, '#ffffff'); R(c, 0, FLOOR + 3, W, 2, '#9aaeb0');
    for (const [x, col] of [[300, '#f08ab8'], [1250, '#7ac8e8'], [1560, '#f2d24a']]) { for (let k = 0; k < 9; k++) { const a = k / 9 * 6.28; R(c, x + Math.cos(a) * 4, 216 + Math.sin(a) * 1.5, 1, 1, k % 2 ? col : '#ffffff'); } } // pulseiras caídas
    return [cv, lv];
  }
  function patio(c, s, t, camL) {
    if (!mids[9]) mids[9] = buildPatioMid();
    const sun = backdrop(c, s, t, camL, [31, 108]);
    c.drawImage(mids[9][0], camL, 0, LW, LH, 0, 0, LW, LH);
    // sombra da marquise na fachada e das colunas, conforme o sol
    if (sun.str > .04) { const el = 1 - Math.abs(sun.lean), dep = Math.round(5 + el * 16), sh = `rgba(14,24,50,${.22 * sun.str})`, reach = sun.lean * (10 + Math.abs(sun.lean) * 30); R(c, 0, 101, LW, dep, sh); for (let x = 0; x < LW; x += 2) if ((x >> 1) & 1) R(c, x, 101 + dep, 1, 1, sh);
      for (let x = Math.floor(camL / 182.5) * 182.5 + 11 - 182.5; x < camL + LW + 60; x += 182.5) { slant(c, x - camL + reach * .2, x - camL + 6 + reach * .2, 101 + dep, reach * .9, 178 - 101 - dep, `rgba(14,24,50,${.16 * sun.str})`); slant(c, x - camL + reach * 1.1, x - camL + 6 + reach * 1.1, 178, reach * .9, 30, `rgba(14,24,50,${.14 * sun.str})`); }
      for (const x of PT_LAMPS) slant(c, x - camL, x - camL + 3, 177, reach * 1.4, 8, sh); }
    for (const x of [35, 610, 1085, 1745]) { const sx = x - camL; if (sx > -60 && sx < LW + 60) tree(c, sx, 213, .72, 1, t, x); }
    // bandeirinhas nas cores das eras, pombo e globo espelhado girando
    { const x0 = 820 - camL; if (x0 < LW && x0 + 420 > 0) { R(c, x0, 71, 417, 1, '#557e85'); for (let i = 0; i < 18; i++) { const x = x0 + 5 + i * 22.5, wv = Math.round(Math.sin(t * 2 + i) * 1.2); for (let k = 0; k < 11; k++) R(c, x + k * .5 + wv * (k / 11), 72 + k, 11 - k, 1, ERAS[i % 11]); } } }
    { const px = 510 + Math.sin(t * .8) * 2.5 - camL; R(c, px, 89, 5, 4, '#9caaa9'); R(c, px + 4, 87, 3, 4, '#c6ccc3'); R(c, px + 5, 88, 1, 1, '#3d5b62'); R(c, px + 7, 89, 1, 1, '#ba9d60'); R(c, px + 1, 92, 1, 1, '#b59872'); R(c, px + 3, 92, 1, 1, '#b59872'); }
    { const mx = 908 - camL; if (mx > -20 && mx < LW + 20) { R(c, mx, 101, 1, 7, '#5a5a5a'); ell(c, mx, 114, 6, 6, '#7a8aa8'); for (let i = 0; i < 20; i++) { const a = (i % 5) / 5 * 6.28 + t * 1.2 + Math.floor(i / 5) * .6, yy = 110 + Math.floor(i / 5) * 2.6, r = Math.sqrt(Math.max(0, 36 - (yy - 114) * (yy - 114))), px = mx + Math.cos(a) * r; if (Math.sin(a) > -.2) R(c, px, yy, 2, 2, ['#ffffff', '#c8d8f8', '#f8d0e8', '#d0f0e8'][(i + Math.floor(t * 3)) % 4]); } } }
  }
  function patioText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace'; c.fillStyle = '#f0f4e6'; c.fillText('COLÉGIO ADVENTISTA', 532, 244); c.fillText('RESPEITO & RESENHA', 3864, 298);
    c.fillStyle = '#fff6c8'; c.fillText('AS ERAS', (PT_WIN(5) + 42) * 2, 256); c.fillStyle = '#f7d8e4'; c.fillText('VERSÃO DA ROÇA', (PT_WIN(12) + 42) * 2, 340); c.fillText('SWIFTIES DO PÁTIO', (PT_WIN(17) + 42) * 2, 340); c.fillText('TROCA DE PULSEIRAS', 2812, 340); c.fillStyle = '#b8d8e8'; c.fillText('1989', 1160, 340); c.fillText('SHOW DE TALENTOS', 1816, 340);
    c.font = '8px Pixel, monospace'; c.fillStyle = '#a9d5da'; c.fillText('PÁTIO · UM RECREIO DE MUITAS HISTÓRIAS', 532, 262); c.fillStyle = '#e8efdc'; c.fillText('TODO MUNDO TEM VEZ.', 3864, 318); c.restore(); }
  function patioLights(g, s, t, camL) { const a = cl((s.night - .12) * 1.4);
    if (a > .02) { g.save(); g.beginPath(); g.rect(0, 0, LW, 92); g.clip(); g.globalAlpha = a; tile(g, city(31, 108)[1], camL * .07); g.restore(); g.globalAlpha = a * .35; g.drawImage(mids[9][1], camL, 0, LW, LH, 0, 0, LW, LH); g.globalAlpha = 1;
      for (const x of PT_LAMPS) { const sx = x - camL + 1; if (sx < -120 || sx > LW + 120) continue; lightAdd(sx, 82, a, 70); const gr = g.createLinearGradient(0, 82, 0, 262); gr.addColorStop(0, `rgba(255,236,170,${.3 * a})`); gr.addColorStop(1, `rgba(255,236,170,${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 5, 82); g.lineTo(sx + 6, 82); g.lineTo(sx + 70, 262); g.lineTo(sx - 69, 262); g.closePath(); g.fill(); const b = g.createRadialGradient(sx, 79, 1, sx, 80, 26); b.addColorStop(0, `rgba(255,240,180,${.85 * a})`); b.addColorStop(1, 'rgba(255,240,180,0)'); g.fillStyle = b; g.fillRect(sx - 28, 52, 56, 56); } }
    // o globo espelhado espalha pontos de luz coloridos (mais fortes à noite)
    const mx = 908 - camL; if (mx > -220 && mx < LW + 220) { const k = .25 + a * .75; for (let i = 0; i < 26; i++) { const an = i / 26 * 6.28 + t * .5, rr = 30 + (i % 5) * 26, px = mx + Math.cos(an) * rr * 1.5, py = 150 + Math.sin(an) * rr * .55 + (i % 3) * 8, col = [[1, 1, 1], [.75, .85, 1], [1, .8, .92], [.8, 1, .95]][i % 4]; g.fillStyle = css(col, .5 * k); g.fillRect(Math.round(px), Math.round(py), 3, 2); g.fillStyle = css(col, .16 * k); g.fillRect(Math.round(px) - 1, Math.round(py) - 1, 5, 4); } } }

  // ------------------------------------------------------------------------------- peças comuns: calçamento, janela, banco, poste
  function paving(c, W, base, dark, line, top, step) { R(c, 0, FLOOR, W, 50, base); R(c, 0, 242, W, 28, dark); dither(c, 0, 241, W, dark); for (let x = 0; x < W; x += step) { R(c, x, 225, 1, 45, line); R(c, x + 1, 225, 1, 45, 'rgba(255,255,255,.16)'); } R(c, 0, 248, W, 1, line); for (let i = 0; i < W * 1.5; i++) R(c, hash(i + 143) * W, 226 + hash(i + 144) * 43, 1 + hash(i) * 2, 1, i % 3 ? 'rgba(0,0,0,.10)' : 'rgba(255,255,255,.14)'); for (let i = 0; i < W / 55; i++) { let x = hash(i + 153) * W, y = 226 + hash(i + 154) * 18; for (let k = 0; k < 8 + hash(i) * 10; k++) { R(c, x, y, 1, 1, 'rgba(40,40,50,.45)'); x += hash(i * 5 + k) > .45 ? 1 : -1; y += hash(i * 3 + k) > .5 ? 1 : 0; } } R(c, 0, FLOOR, W, 3, top); R(c, 0, FLOOR, W, 1, 'rgba(255,255,255,.45)'); R(c, 0, FLOOR + 3, W, 2, line); }
  function win(c, l, x, y, w, h, lit) { x = Math.round(x); R(c, x - 1, y - 1, w + 2, h + 2, '#22405a'); R(c, x, y, w, h, '#466c86'); R(c, x + 2, y + 2, w - 4, h - 4, '#7ba6ae'); R(c, x + 2, y + 2, w - 4, Math.round(h * .3), '#a5cbd0'); for (let k = 0; k < h - 8; k++) R(c, x + 5 + Math.round((h - k) * .4), y + 3 + k, 4, 1, 'rgba(255,255,255,.26)'); R(c, x + Math.floor(w / 2) - 1, y + 2, 2, h - 4, '#d7e7ec'); R(c, x + 2, y + Math.floor(h / 2), w - 4, 2, '#d7e7ec'); R(c, x - 3, y + h + 1, w + 6, 3, '#c7d9e0'); R(c, x - 3, y + h + 1, w + 6, 1, '#eef6f8'); c.fillStyle = 'rgba(0,0,0,.13)'; c.fillRect(x - 1, y + h + 4, w + 2, 2); if (l && lit) { l.fillStyle = '#ffe2a0'; l.fillRect(x + 2, y + 2, w - 4, h - 4); } }
  function bench(c, x, y, w, col, hi) { R(c, x, y - 12, w, 3, col); R(c, x, y - 12, w, 1, hi); R(c, x, y - 7, w, 3, col); R(c, x, y - 7, w, 1, hi); R(c, x + 3, y - 12, 2, 12, '#5a5a48'); R(c, x + w - 5, y - 12, 2, 12, '#5a5a48'); R(c, x, y, w, 4, col); R(c, x, y, w, 1, hi); R(c, x, y + 3, w, 1, 'rgba(0,0,0,.25)'); R(c, x + 3, y + 4, 3, 12, '#58604b'); R(c, x + w - 6, y + 4, 3, 12, '#58604b'); c.fillStyle = 'rgba(0,0,0,.18)'; c.fillRect(Math.round(x + 1), 219, Math.round(w - 2), 1); }
  function lampPost(c, x, top) { R(c, x, top, 3, 220 - top - 1, '#476967'); R(c, x, top, 1, 220 - top - 1, '#6f918e'); R(c, x - 6, top - 6, 15, 7, '#294e5a'); R(c, x - 4, top - 4, 11, 3, '#fff0b4'); R(c, x - 2, 216, 7, 3, '#294e5a'); }
  function lampGlow(g, sx, top, a, rgb = '255,236,170', reach = 66) { if (a < .02 || sx < -140 || sx > LW + 140) return; lightAdd(sx, top, a, reach); const gr = g.createLinearGradient(0, top, 0, 262); gr.addColorStop(0, `rgba(${rgb},${.3 * a})`); gr.addColorStop(1, `rgba(${rgb},${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 5, top); g.lineTo(sx + 6, top); g.lineTo(sx + reach, 262); g.lineTo(sx - reach + 1, 262); g.closePath(); g.fill(); const b = g.createRadialGradient(sx, top - 2, 1, sx, top, 26); b.addColorStop(0, `rgba(${rgb},${.85 * a})`); b.addColorStop(1, `rgba(${rgb},0)`); g.fillStyle = b; g.fillRect(sx - 28, top - 28, 56, 56); }

  // ------------------------------------------------------------------------------- ESCOLA (mapa 1)
  const SC_DOORS = [[675, 0], [1175, 1]], SC_SKETCH = [0, 1, 2, 3, 4].map((i) => 1335 + i * 84.5), SC_BOARDS = [0, 1, 2, 3, 4].map((i) => 2010 + i * 91.5);
  const SC_PHRASES = ['da roça poudiaaam', 'reeeis pouddiaaam', 'da roça pegou ar', 'teketeketeketeke', 'o pra ravid falando sozinho'], SC_CAPS = ['NÃO ABRA O CADERNO', 'ELES ESTÃO OLHANDO', 'SÓ UM RABISCO...', 'O PAPEL RESPIRA', 'MARCO ESTEVE AQUI'];
  const SC_BUSY = [[128, 256], [165, 215], [482, 562], [632, 718], [940, 1218], [1295, 1700], [1995, 2480]];
  function buildSchoolMid() {
    const W = worldW(1), [cv, c] = mk(W, LH), [lv, l] = mk(W, LH);
    R(c, 0, 196, W, 24, '#b6b18a'); R(c, 0, 196, W, 1, '#d3cea8'); for (let x = 0; x < W; x += 30) R(c, x, 197, 1, 23, '#9c976f'); for (let i = 0; i < W; i++) R(c, hash(i + 3) * W, 198 + hash(i + 4) * 21, 2, 1, i % 2 ? '#a8a37c' : '#c6c19a');
    // fachada comprida: parede clara, faixa e barrado azul-marinho
    R(c, 45, 111, W - 45, 103, '#eef3f4'); for (let i = 0; i < W * 2; i++) R(c, 45 + hash(i + 13) * (W - 45), 120 + hash(i + 14) * 62, 2, 1, i % 2 ? '#e0e8ea' : '#fbfdfd');
    R(c, 40, 107, W - 40, 7, '#183a5e'); R(c, 40, 107, W - 40, 1, '#3a6a94'); R(c, 45, 114, W - 45, 4, '#ffffff'); c.fillStyle = 'rgba(20,40,70,.16)'; c.fillRect(45, 118, W - 45, 3);
    R(c, 45, 184, W - 45, 30, '#244a70'); R(c, 45, 184, W - 45, 2, '#132d4a'); R(c, 45, 186, W - 45, 1, '#3a6a94'); for (let x = 45; x < W; x += 10) R(c, x, 187, 1, 27, '#1d3f61'); R(c, 45, 200, W - 45, 1, '#1d3f61'); R(c, 40, 111, 5, 103, '#173755');
    const busy = (x, w) => SC_BUSY.some(([a, b]) => x + w > a && x < b) || x + w > W - 82;
    for (let i = 0; i < 12; i++) { const x = 70 + i * 68.5; if (!busy(x, 41)) win(c, l, x, 133, 41, 39, hash(i + 61) > .45); }
    for (let x = 950; x < W - 50; x += 90) if (!busy(x, 46)) win(c, l, x, 135, 46, 36, hash(x + 71) > .45);
    for (let x = 60; x < W; x += 137.5) { R(c, x, 118, 6, 96, '#b3cbd8'); R(c, x + 1, 118, 2, 96, '#f9fcff'); R(c, x + 5, 118, 1, 96, '#8ea9b8'); R(c, x - 1, 211, 8, 3, '#8ea9b8'); }
    // entrada principal e letreiro
    R(c, 169, 144, 42, 70, '#6a563c'); R(c, 171, 146, 38, 68, '#8f7657'); R(c, 174, 149, 32, 65, '#526661'); R(c, 176, 152, 12, 42, '#6e8980'); R(c, 192, 152, 12, 42, '#5e7770'); for (let k = 0; k < 30; k++) R(c, 178 + Math.round((30 - k) * .25), 154 + k, 3, 1, 'rgba(255,255,255,.22)'); R(c, 189, 149, 2, 65, '#b49d75'); R(c, 186, 181, 2, 2, '#efd49a'); R(c, 192, 181, 2, 2, '#efd49a'); R(c, 165, 214, 50, 2, '#c9c4a4'); R(c, 162, 216, 56, 2, '#b6b18a');
    board(c, 128, 121, 126, 15, '#183c62', '#0e2a44'); R(c, 129, 136, 124, 1, '#7fb4cf'); R(c, 186, 139, 8, 4, '#2a3a3c'); R(c, 187, 143, 6, 1, '#ffe9a8');
    // mural de boas-vindas pintado pelos alunos
    R(c, 942, 140, 212, 77, '#d3c69a'); R(c, 942, 140, 212, 4, '#867b5e'); R(c, 942, 140, 212, 1, '#a89c7c'); for (let j = 0; j < 9; j++) for (let i = 0; i < 9; i++) R(c, 946 + i * 24 + (j % 2) * 11, 147 + j * 8, 20, 1, '#b7a981');
    for (let i = 0; i < 14; i++) { const hx = 950 + hash(i + 81) * 190, hy = 186 + hash(i + 82) * 18, col = ['#d86a5a', '#5a9ad8', '#e8c84a', '#6ab86a', '#b87ad8'][i % 5]; R(c, hx, hy, 5, 5, col); for (let f = 0; f < 4; f++) R(c, hx + f * 1.4, hy - 3, 1, 3, col); R(c, hx - 2, hy + 1, 2, 2, col); }
    for (let i = 0; i < 7; i++) bench(c, 310 + i * 105, 204, 34, '#a58859', '#c9aa76');
    // a parede do Ravid
    R(c, 487, 153, 17, 4, '#8f8c70'); R(c, 488, 155, 15, 61, '#b9aa85'); R(c, 488, 155, 4, 61, '#f0dfb0'); R(c, 492, 158, 10, 56, '#dcc99b'); R(c, 488, 199, 15, 17, '#ad7153'); for (const yy of [163, 175, 187]) R(c, 493, yy, 6, 1, '#b6a67f'); board(c, 506, 161, 54, 29, '#e2d9ae', '#6f8a72'); R(c, 529, 185, 5, 1, '#8c9b6b');
    bush(c, 1160, 45); bush(c, 32, 28); R(c, 832, 199, 14, 19, '#54735b'); R(c, 830, 197, 18, 4, '#73906a'); R(c, 835, 203, 2, 13, '#a3ad79');
    // portas das salas
    for (const [x, en] of SC_DOORS) { const ac = en ? '#796080' : '#527f93', pn = en ? '#93868d' : '#7f9ba1'; R(c, x - 27, 134, 54, 82, '#806d54'); R(c, x - 25, 136, 50, 79, ac); R(c, x - 22, 140, 44, 75, '#38595d'); R(c, x - 20, 142, 40, 72, pn); R(c, x - 20, 142, 1, 72, 'rgba(255,255,255,.25)'); R(c, x - 16, 147, 32, 36, '#bccbd1'); R(c, x - 14, 149, 28, 32, '#d8e3d9'); for (let k = 0; k < 26; k++) R(c, x - 10 + Math.round((26 - k) * .3), 151 + k, 3, 1, 'rgba(255,255,255,.4)'); R(c, x - 1, 147, 2, 36, ac); R(c, x - 16, 165, 32, 2, ac); R(c, x + 13, 193, 3, 3, '#f1d896'); R(c, x - 24, 212, 48, 4, '#c9b792'); board(c, x - 38, 120, 76, 13, ac, '#2a3a44'); if (hash(x) > .2) { l.fillStyle = '#ffe2a0'; l.fillRect(x - 14, 149, 28, 32); } }
    // folhas de caderno com rabiscos e lousas com as frases da turma
    for (const x of SC_SKETCH) { R(c, x - 29, 131, 56, 45, '#8a8672'); R(c, x - 28, 132, 54, 44, '#d4cfb5'); for (let k = 0; k < 54; k += 3) R(c, x - 28 + k, 176, 3, 1 + Math.round(hash(k + x) * 3), '#d4cfb5'); R(c, x - 20, 138, 38, 1, '#a7a296'); R(c, x - 24, 132, 1, 44, '#c8a0a0'); R(c, x - 6, 129, 10, 4, 'rgba(240,230,170,.8)'); }
    for (const x of SC_BOARDS) { R(c, x - 1, 130, 88, 54, '#4a4636'); R(c, x, 131, 86, 52, '#6e6951'); R(c, x + 2, 134, 82, 46, '#3f7a74'); for (let i = 0; i < 90; i++) R(c, x + 3 + hash(i + x) * 79, 135 + hash(i + x + 2) * 43, 2, 1, i % 2 ? '#478880' : '#376e68'); R(c, x + 2, 134, 82, 1, '#5aa39a'); R(c, x + 5, 180, 76, 2, '#85977a'); R(c, x + 8, 178, 8, 2, '#f3f0e2'); R(c, x + 66, 177, 10, 3, '#c9b28a'); }
    for (let x = 1350; x < W - 100; x += 235) { bench(c, x, 205, 29, '#977343', '#bb9560'); bush(c, x + 57, 24); }
    const ex = W - 75; R(c, ex - 1, 141, 51, 75, '#2f4a44'); R(c, ex, 142, 49, 73, '#52736a'); R(c, ex + 2, 146, 44, 66, '#8ba997'); R(c, ex + 24, 146, 1, 66, '#52736a'); R(c, ex + 19, 180, 2, 3, '#f1d896'); R(c, ex + 27, 180, 2, 3, '#f1d896'); R(c, ex + 6, 150, 36, 11, '#3d5a52');
    paving(c, W, '#97856e', '#8a7862', '#7a6a56', '#c4b08a', 40);
    return [cv, lv];
  }
  function school(c, s, t, camL) {
    if (!mids[1]) mids[1] = buildSchoolMid();
    const sun = backdrop(c, s, t, camL, [43, 104]); tile(c, far[2], camL * .22 + 200); R(c, 0, 186, LW, 12, '#7fa86a');
    c.drawImage(mids[1][0], camL, 0, LW, LH, 0, 0, LW, LH);
    if (sun.str > .04) { const el = 1 - Math.abs(sun.lean), dep = Math.round(3 + el * 9), reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.24 * sun.str})`; R(c, Math.max(0, 45 - camL), 118, LW, dep, `rgba(14,24,50,${.2 * sun.str})`);
      for (let x = Math.floor(camL / 137.5) * 137.5 + 60 - 137.5; x < camL + LW + 40; x += 137.5) { const sx = x - camL + (sun.lean >= 0 ? 6 : -Math.round(Math.abs(reach) * .3)); R(c, sx, 118, Math.max(1, Math.round(Math.abs(reach) * .3)), 96, `rgba(14,24,50,${.13 * sun.str})`); }
      for (let i = 0; i < 7; i++) { const x = 310 + i * 105 - camL; if (x > -80 && x < LW + 40) slant(c, x, x + 34, 219, reach, 3, sh); } }
    for (const [tx, sc] of [[20, .9], [1190, 1.1]]) { const x = tx - camL; if (x > -80 && x < LW + 80) { if (sun.str > .04) ell(c, x + sun.lean * 30 * sc, 220, 24 * sc, 3, `rgba(14,24,50,${.24 * sun.str})`); tree(c, x, 217, sc, 0, t, tx, sun.lean >= 0 ? Math.max(.35, sun.lean) : Math.min(-.35, sun.lean)); } }
  }
  function schoolText(c, camera) { const W = worldW(1); c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; const vis = (x) => x > camera - 260 && x < camera + 1220;
    c.font = '16px Pixel, monospace'; c.fillStyle = '#f8fbfc'; c.fillText('COLÉGIO ADVENTISTA', 382, 258); c.fillStyle = '#52766b'; if (vis(2096)) c.fillText('BEM-VINDOS', 2096, 314); c.fillStyle = '#dfe6bb'; if (vis((W - 51) * 2)) c.fillText('SAÍDA', (W - 51) * 2, 312);
    c.font = '8px Pixel, monospace'; c.fillStyle = '#b27857'; if (vis(2096)) c.fillText('AQUI ATÉ A PAREDE TEM HISTÓRIA.', 2096, 334); c.fillStyle = '#54735f'; c.fillText('A PAREDE ESCUTA', 1066, 342); c.fillText('MAIS DO QUE FALA.', 1066, 356); c.fillStyle = '#fff1cb'; for (const [x, en] of SC_DOORS) if (vis(x * 2)) c.fillText(en ? 'SALA · MIQUEIAS' : 'SALA · ALMIRO', x * 2, 254);
    SC_SKETCH.forEach((x, i) => { if (!vis(x * 2)) return; c.fillStyle = '#675975'; c.fillText(SC_CAPS[i], x * 2 - 2, 374); if (window.Art?.drawDoodle) { c.save(); c.translate(x * 2 - 2, 318); c.scale(1.2, 1.2); try { window.Art.drawDoodle(c, 0, 0, i % 3, lastT * .35 + i, false); } catch (e) {} c.restore(); } });
    SC_BOARDS.forEach((x, i) => { if (!vis(x * 2)) return; c.fillStyle = '#e8f4ee'; const words = SC_PHRASES[i].split(' '); let line = '', yy = 300; for (const w of words) { if ((line + w).length > 14) { c.fillText(line.trim().toUpperCase(), (x + 43) * 2, yy); line = ''; yy += 18; } line += w + ' '; } c.fillText(line.trim().toUpperCase(), (x + 43) * 2, yy); });
    c.restore(); }
  function schoolLights(g, s, t, camL) { const a = cl((s.night - .12) * 1.4); if (a < .02) return; g.save(); g.beginPath(); g.rect(0, 0, LW, 106); g.clip(); g.globalAlpha = a; tile(g, city(43, 104)[1], camL * .07); g.restore(); g.globalAlpha = a * .4; g.drawImage(mids[1][1], camL, 0, LW, LH, 0, 0, LW, LH); g.globalAlpha = 1; lampGlow(g, 190 - camL, 143, a, '255,226,160', 60); for (const [x] of SC_DOORS) lampGlow(g, x - camL, 134, a * .8, '255,226,160', 52); }

  // ------------------------------------------------------------------------------- PRAÇA CAMACAN (mapa 4)
  let plazaBack = null;
  const PZ_FOUNT = [525, 2115], PZ_KIOSK = [985, 2515], PZ_LAMPS = [0, 1, 2, 3, 4, 5, 6, 7, 8].map((i) => 350 + i * 325);
  function buildPlazaBack() { const T = 956, D = mk(T, 196), L = mk(T, 196); for (let i = 0; i < 7; i++) { const x = Math.round(i * 136.5), h = Math.round(35 + hash(i + 83) * 30), y = 125 - h, col = ['#bfd3d2', '#c9d6c8', '#b5cad0', '#d0d2c0'][i % 4]; R(D[1], x, y, 110, h, col); R(D[1], x, y, 110, 1, '#eef4ee'); R(D[1], x + 3, y + 4, 104, 4, '#e2ece6'); R(D[1], x, y, 2, h, 'rgba(255,255,255,.3)'); R(D[1], x + 106, y, 4, h, 'rgba(30,60,80,.18)'); for (let r2 = 0; r2 * 17 + 12 < h - 6; r2++) for (let k = 0; k < 6; k++) { const wx = x + 8 + k * 17, wy = y + 12 + r2 * 17; R(D[1], wx, wy, 9, 12, '#7b9da5'); R(D[1], wx, wy, 9, 4, '#b8d8dd'); R(D[1], wx + 4, wy, 1, 12, '#e2ece6'); if (hash(i * 9 + k + r2 * 5) > .5) { L[1].fillStyle = '#ffe2a0'; L[1].fillRect(wx, wy, 9, 12); } } if (i % 2) { R(D[1], x + 20, y - 6, 14, 6, '#8faeb0'); R(D[1], x + 70, y - 10, 1, 10, '#6f8f92'); } R(D[1], x, 121, 110, 4, '#8faeb0'); }
    for (let x = 0; x < T; x += 9) { ell(D[1], x + 4, 124, 6, 4, x % 18 ? '#5f9a6a' : '#4f8a5c'); } R(D[1], 0, 126, T, 4, '#6f9a7a'); return [D[0], L[0]]; }
  function buildPlazaMid() {
    const W = worldW(4), [cv, c] = mk(W, LH);
    // calçadão em pedra portuguesa
    R(c, 0, 177, W, 43, '#cbd0bb'); for (let y = 180; y < 220; y += 4) for (let x = ((y / 4) & 1) * 4; x < W; x += 8) R(c, x, y, 4, 4, 'rgba(90,100,90,.10)'); for (let x = 0; x < W; x += 64) { for (let k = 0; k < 24; k++) { const yy = 186 + Math.round(Math.sin(k / 24 * 6.28) * 5); R(c, x + k * 2.6, yy + 12, 2, 2, '#5a6660'); R(c, x + k * 2.6, yy + 22, 2, 2, '#5a6660'); } } R(c, 0, 176, W, 3, '#edf0d7'); R(c, 0, 176, W, 1, '#ffffff');
    // mureta e grade do rio
    for (let x = 0; x < W; x += 160) { R(c, x, 164, 3, 26, '#697f79'); R(c, x, 164, 1, 26, '#9ab0a8'); R(c, x - 1, 162, 5, 2, '#4f655f'); } R(c, 0, 165, W, 2, '#9aa995'); R(c, 0, 165, W, 1, '#c8d4c0'); R(c, 0, 174, W, 2, '#91a38e'); for (let x = 0; x < W; x += 8) R(c, x, 167, 1, 7, '#8a9c88');
    for (let x = 80; x < W; x += 285) { bush(c, x + 37, 38); bench(c, x + 68, 204, 56, '#c39b65', '#e0bd88'); R(c, x + 88, 191, 8, 9, FAN_SHIRT[Math.floor(x / 285) % 6]); R(c, x + 89, 185, 6, 6, FAN_SKIN[Math.floor(x / 285) % 5]); R(c, x + 89, 184, 6, 2, FAN_HAIR[Math.floor(x / 285) % 5]); R(c, x + 88, 200, 4, 8, '#3a4a6a'); R(c, x + 92, 200, 4, 8, '#3a4a6a'); }
    // chafarizes (a água é ao vivo)
    for (const x of PZ_FOUNT) { ell(c, x, 213, 56, 8, '#698d89'); ell(c, x, 209, 52, 9, '#d7d4b8'); ell(c, x, 208, 50, 8, '#eeebd2'); ell(c, x, 205, 46, 7, '#77bbca'); ell(c, x, 205, 37, 4, '#a5dce2'); R(c, x - 4, 171, 9, 33, '#d9d9bd'); R(c, x - 4, 171, 3, 33, '#f2f2dc'); R(c, x + 3, 171, 2, 33, '#b0b098'); ell(c, x, 171, 29, 4, '#d9d9bd'); ell(c, x, 168, 25, 3, '#82c6cf'); R(c, x - 2, 147, 4, 20, '#ecedcf'); ell(c, x, 147, 10, 3, '#e5e7cd'); }
    // quiosques
    for (const x of PZ_KIOSK) { R(c, x - 1, 156, 87, 64, '#8a7a5a'); R(c, x, 157, 85, 62, '#efdfb5'); for (let i = 0; i < 80; i++) R(c, x + 2 + hash(i + x) * 81, 160 + hash(i + x + 3) * 56, 2, 1, i % 2 ? '#e3d2a4' : '#f8ecc8'); for (let k = 0; k < 97; k += 8) { R(c, x - 6 + k, 152, 8, 8, (k / 8) % 2 ? '#274d61' : '#f3ead6'); R(c, x - 6 + k, 160, 8, 2, (k / 8) % 2 ? '#1a3848' : '#cfc5ae'); } R(c, x - 6, 151, 97, 1, '#3a6a84'); R(c, x + 4, 163, 77, 7, '#305a6c'); R(c, x + 7, 175, 70, 31, '#4c898c'); R(c, x + 9, 177, 66, 26, '#89b9b6'); for (let k = 0; k < 20; k++) R(c, x + 14 + Math.round((20 - k) * .5), 179 + k, 4, 1, 'rgba(255,255,255,.25)'); R(c, x + 6, 206, 72, 4, '#c79860'); R(c, x + 6, 206, 72, 1, '#e8bd84'); for (let i = 0; i < 3; i++) { R(c, x + 14 + i * 22, 187, 11, 15, '#9b694b'); R(c, x + 15 + i * 22, 186, 8, 2, '#d9ac69'); R(c, x + 16 + i * 22, 191, 6, 5, '#f3ead6'); } R(c, x + 41, 196, 6, 7, FAN_SKIN[1]); R(c, x + 41, 195, 6, 2, FAN_HAIR[0]); R(c, x + 39, 203, 10, 3, '#f0f0f0'); }
    board(c, 177, 148, 108, 22, '#dbe8df', '#214e66'); R(c, 195, 170, 3, 49, '#3c6a76'); R(c, 264, 170, 3, 49, '#3c6a76');
    for (const x of PZ_LAMPS) if (x < W) lampPost(c, x, 131);
    for (let x = 240; x < W; x += 410) { R(c, x, 205, 10, 14, '#3f8a52'); R(c, x - 1, 203, 12, 3, '#57a86a'); R(c, x + 3, 209, 4, 4, '#e9f2e0'); }
    paving(c, W, '#aeb8b5', '#9faaa7', '#899c9b', '#e0ded0', 26.5);
    return cv;
  }
  function plaza(c, s, t, camL) {
    if (!mids[4]) mids[4] = buildPlazaMid(); if (!plazaBack) plazaBack = buildPlazaBack(); if (!far) far = buildFar();
    const sun = sunInfo(s), la = Math.min(1, Math.abs(sun.lean) * 1.3) * sun.str;
    sky(c, s, t, camL); tile(c, far[0], camL * .04); if (la > .03) { c.globalAlpha = la; tile(c, far[sun.lean >= 0 ? 3 : 4][0], camL * .04); c.globalAlpha = 1; } tile(c, plazaBack[0], camL * .28);
    // rio: água em faixas, ondinhas andando e o reflexo do sol ou da lua
    for (let i = 0; i < 10; i++) R(c, 0, 130 + i * 5, LW, 5, css(mix([.39, .66, .75], [.27, .5, .64], i / 9))); R(c, 0, 130, LW, 2, '#badcdd');
    for (let i = 0; i < 48; i++) { const x = ((i * 37 - camL * .4 + t * (4 + (i % 3) * 2)) % 540 + 540) % 540 - 30, yy = 134 + hash(i + 51) * 42; R(c, x, yy, 9 + hash(i + 4) * 15, 1, i % 2 ? '#96d4dd' : '#83c0d1'); }
    { const T = s.sunT !== null ? s.sunT : s.moonT; if (T !== null && sun.str > .03) { const sx = (s.sunT !== null ? 40 + T * 400 : 50 + T * 380) - camL * .012, col = s.sunT !== null ? '255,244,200' : '210,225,255'; for (let i = 0; i < 46; i++) { const yy = 132 + (i % 23) * 2, sp = 3 + (yy - 132) * .45, x = sx + (hash(i + Math.floor(t * 5)) - .5) * sp * 2, w = 2 + hash(i * 3 + Math.floor(t * 4)) * (3 + (yy - 132) * .2); c.fillStyle = `rgba(${col},${(.35 + hash(i + Math.floor(t * 6)) * .55) * Math.min(1, sun.str * 1.4)})`; c.fillRect(Math.round(x - w / 2), yy, Math.round(w), 1); } } }
    { const bx = ((t * 6 - camL * .4) % 700 + 700) % 700 - 60; R(c, bx, 150, 22, 3, '#7a5a3a'); R(c, bx + 2, 153, 18, 1, '#5a4028'); R(c, bx + 9, 143, 4, 7, '#c8946a'); R(c, bx + 9, 141, 4, 3, '#e8c84a'); R(c, bx + 13, 144, 9, 1, '#5a4028'); R(c, bx - 2, 154, 28, 1, 'rgba(255,255,255,.35)'); }
    c.drawImage(mids[4], camL, 0, LW, LH, 0, 0, LW, LH);
    const reach = sun.lean * (12 + Math.abs(sun.lean) * 26), sh = `rgba(14,24,50,${.24 * sun.str})`;
    if (sun.str > .04) { for (const x of PZ_LAMPS) slant(c, x - camL, x - camL + 3, 219, reach * 1.5, 5, sh); for (const x of PZ_KIOSK) { const sx = x - camL; if (sx > -200 && sx < LW + 120) { slant(c, sx, sx + 85, 219, reach, 3, sh); shadeAdd(sx + reach, sx + 85 + reach, .9); sunWall(c, sx, 157, 85, 62, sun.lean, Math.min(1, Math.abs(sun.lean) * 1.4) * sun.str); } } for (let x = Math.floor(camL / 160) * 160 - 160; x < camL + LW + 60; x += 160) slant(c, x - camL, x - camL + 3, 190, reach * .8, 6, `rgba(14,24,50,${.14 * sun.str})`); }
    for (let x = 80; x < worldW(4); x += 285) { const sx = x - camL; if (sx > -70 && sx < LW + 70) { if (sun.str > .04) { ell(c, sx + reach * 1.2, 219, 14, 2.5, sh); shadeAdd(sx + reach * 1.2 - 14, sx + reach * 1.2 + 14, .85, true); } tree(c, sx, 216, .72, 1, t, x); } }
    for (const x of PZ_FOUNT) { const sx = x - camL; if (sx < -80 || sx > LW + 80) continue; for (let j = 0; j < 7; j++) { const a = (j - 3) / 3, ph = (t * 1.6 + j * .13) % 1; for (let k = 0; k < 14; k++) { const u = k / 13, px = sx + a * 24 * u, py = 146 - Math.sin(u * Math.PI) * (14 - Math.abs(a) * 5) + u * 22; R(c, px, py, 1, 2, k % 3 === Math.floor(ph * 3) ? '#edf8ee' : '#b7eced'); } R(c, sx + a * 24, 166 + ph * 3, 2, 2, '#edf8ee'); } for (let j = 0; j < 12; j++) R(c, sx - 37 + j * 7, 204 - Math.abs(Math.sin(t * 3 + j)) * 3, 2, 1, '#d6f2e8'); for (let j = 0; j < 6; j++) R(c, sx - 22 + j * 9, 172 + ((t * 20 + j * 7) % 30), 1, 3, 'rgba(210,240,240,.7)'); }
  }
  function plazaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace'; c.fillStyle = '#285e76'; c.fillText('PRAÇA CAMACAN', 462, 312); c.font = '8px Pixel, monospace'; c.fillText('ITABUNA · RIO CACHOEIRA', 462, 330); c.fillStyle = '#f8ebc7'; for (const x of PZ_KIOSK) c.fillText('CACAU & RESENHA', (x + 42) * 2, 334); c.restore(); }
  function plazaLights(g, s, t, camL) { const a = cl((s.night - .12) * 1.4); if (a < .02) return; g.globalAlpha = a * .45; tile(g, plazaBack[1], camL * .28); g.globalAlpha = 1; for (const x of PZ_LAMPS) lampGlow(g, x - camL + 1, 127, a); for (const x of PZ_KIOSK) { const sx = x - camL + 42; if (sx < -120 || sx > LW + 120) continue; const b = g.createRadialGradient(sx, 190, 4, sx, 192, 58); b.addColorStop(0, `rgba(255,214,140,${.6 * a})`); b.addColorStop(1, 'rgba(255,214,140,0)'); g.fillStyle = b; g.fillRect(sx - 60, 132, 120, 120); } for (const x of PZ_FOUNT) { const sx = x - camL; if (sx < -90 || sx > LW + 90) continue; const b = g.createRadialGradient(sx, 200, 4, sx, 200, 60); b.addColorStop(0, `rgba(120,220,255,${.45 * a})`); b.addColorStop(1, 'rgba(120,220,255,0)'); g.fillStyle = b; g.fillRect(sx - 60, 140, 120, 120); } }

  // ------------------------------------------------------------------------------- REINO DA TINTA (mapa 6): escuro, visto à luz da tocha
  const INK_GLOW = [], INK_SIGNS = []; { for (let x = 120, i = 0; x < 3300; x += 215, i++) INK_GLOW.push([x + (i % 2) * 36, i % 3]); for (let x = 340, i = 0; x < 3300; x += 495, i++) INK_SIGNS.push([x, i]); }
  const INK_COL = [[.35, .95, 1], [1, .45, .9], [.75, 1, .45]];
  let inkBack = null;
  function buildInkBack() { const A = mk(TILE, LH), B = mk(TILE, LH);
    let x = 0, i = 0; while (x < TILE) { const w = 14 + Math.round(hash(i + 5) * 26), h = 70 + Math.round(hash(i + 6) * 110), col = ['#3a3458', '#44385f', '#352f52', '#4a3d66'][i % 4]; R(A[1], x, 200 - h, w, h + 70, col); R(A[1], x, 200 - h, 1, h + 70, 'rgba(255,255,255,.08)'); R(A[1], x + w - 2, 200 - h, 2, h + 70, 'rgba(0,0,0,.2)'); R(A[1], x + 2, 208 - h, w - 4, 2, '#6a5a80'); R(A[1], x + 2, 214 - h, w - 4, 1, '#6a5a80'); if (i % 3 === 0) R(A[1], x + 3, 230 - h, w - 6, 10, '#584a72'); x += w + (i % 5 === 0 ? 4 : 0); i++; }
    for (let k = 0; k < 4; k++) { const px = k * 240 + 20, top = 44 + (k % 3) * 18; for (let r2 = 0; r2 < 98; r2++) { const u = r2 / 98, xa = px + 18 * (1 - u), xb = px + 72 + 15 * u + 58 * (1 - u) * 0 + 58; R(B[1], xa, top + r2, xb - xa, 1, '#655579'); } for (let j = 0; j < 7; j++) R(B[1], px + 26, top + 16 + j * 10, 46 + j * 2, 1, '#9c8bac'); R(B[1], px + 24, top + 10, 1, 80, '#b07a94');
      let sx = px + 40 + k * 6, sy = top + 40; for (let n = 0; n < 60; n++) { const a = n * .42; R(B[1], sx + Math.cos(a) * (2 + n * .22), sy + Math.sin(a) * (2 + n * .18), 1, 1, 'rgba(210,190,230,.4)'); } R(B[1], sx - 4, sy - 2, 2, 2, 'rgba(230,210,240,.5)'); R(B[1], sx + 3, sy - 2, 2, 2, 'rgba(230,210,240,.5)'); }
    return [A[0], B[0]]; }
  function buildInkMid() {
    const W = worldW(6), [cv, c] = mk(W, LH);
    R(c, 0, 180, W, 40, '#68557f'); R(c, 0, 180, W, 1, '#8a76a0'); for (let i = 0; i < W * 1.5; i++) R(c, hash(i + 3) * W, 182 + hash(i + 4) * 37, 2, 1, i % 2 ? '#5b4a72' : '#77648e'); for (let i = 0; i < W / 40; i++) { const x = hash(i + 13) * W, y = 190 + hash(i + 14) * 24; ell(c, x, y, 8 + hash(i) * 12, 2.5, '#1c1830'); ell(c, x - 2, y - 1, 3, 1, '#4a4470'); }
    // lápis gigantes como colunas e penas espetadas no chão
    for (let x = 200, i = 0; x < W; x += 400, i++) { const col = ['#c9a23a', '#b84a4a', '#3a8ab8'][i % 3], dk2 = ['#8f701f', '#7f2c2c', '#225f84'][i % 3]; R(c, x, 60, 16, 160, col); R(c, x, 60, 5, 160, 'rgba(255,255,255,.22)'); R(c, x + 11, 60, 5, 160, dk2); R(c, x, 196, 16, 5, '#b9c3bf'); R(c, x, 201, 16, 19, '#e8a0b0'); for (let k = 0; k < 8; k++) R(c, x + k, 60 - k * 2 - 2, 16 - k * 2, 2, k > 5 ? '#2a2a30' : '#e8cfa0'); }
    for (let x = 90, i = 0; x < W; x += 310, i++) { for (let k = 0; k < 44; k++) R(c, x + k * .35, 218 - k, 1, 1, '#e8e0d0'); for (let k = 8; k < 44; k += 2) { R(c, x + k * .35 - Math.min(7, (44 - k) * .3), 218 - k, Math.min(7, (44 - k) * .3), 1, i % 2 ? '#b8a8d8' : '#d8c8e8'); R(c, x + k * .35 + 1, 218 - k, Math.min(6, (44 - k) * .25), 1, i % 2 ? '#9888c0' : '#c0b0d8'); } }
    // tinteiros luminosos: a única luz além da tocha
    for (const [x, k] of INK_GLOW) { const col = css(INK_COL[k]); R(c, x - 6, 207, 13, 12, '#2a2440'); R(c, x - 5, 208, 11, 10, '#3a3458'); R(c, x - 4, 211, 9, 6, col); R(c, x - 4, 211, 9, 1, '#ffffff'); R(c, x - 2, 203, 5, 5, '#2a2440'); R(c, x - 1, 204, 3, 3, col); R(c, x - 5, 208, 1, 10, 'rgba(255,255,255,.3)'); for (let d = 0; d < 3; d++) R(c, x + 8 + d * 3, 218 - d, 2, 1, col); }
    for (const [x] of INK_SIGNS) { board(c, x - 26, 54, 124, 20, '#876591', '#3c324f'); R(c, x + 4, 30, 1, 24, '#3c324f'); R(c, x + 66, 30, 1, 24, '#3c324f'); }
    paving(c, W, '#6b577e', '#5a486c', '#4d3c64', '#d9c4df', 26.5);
    for (let i = 0; i < W / 30; i++) { const x = hash(i + 23) * W; R(c, x, 223, 1, 3 + hash(i) * 9, '#1c1830'); R(c, x, 223 + 3 + hash(i) * 9, 2, 2, '#1c1830'); }
    return cv;
  }
  function ink(c, s, t, camL) {
    if (!mids[6]) mids[6] = buildInkMid(); if (!inkBack) inkBack = buildInkBack();
    for (let i = 0; i < 14; i++) R(c, 0, i * 14, LW, 14, css(mix([.12, .12, .25], [.26, .23, .39], i / 13)));
    for (let i = 0; i < 40; i++) { const x = ((i * 49 - camL * .22 + t * 3.5) % 540 + 540) % 540 - 35, y = 18 + (i * 21) % 150; R(c, x, y, 1, 1, i % 3 ? '#b5a2cf' : '#e3c7ed'); }
    tile(c, inkBack[0], camL * .15); tile(c, inkBack[1], camL * .3);
    // cascatas de tinta escorrendo
    for (let i = 0; i < 6; i++) { const x = ((i * 190 + 60 - camL * .3) % 1140 + 1140) % 1140 - 40, col = css(mix(INK_COL[i % 3], [.1, .08, .2], .55)); R(c, x, 0, 5, 182, col); R(c, x, 0, 1, 182, 'rgba(255,255,255,.18)'); for (let k = 0; k < 7; k++) { const yy = ((t * 60 + k * 27 + i * 13) % 182); R(c, x + 1 + (k % 3), yy, 2, 6, css(mix(INK_COL[i % 3], [1, 1, 1], .25))); } ell(c, x + 2, 182, 9, 2, col); }
    c.drawImage(mids[6], camL, 0, LW, LH, 0, 0, LW, LH);
    // folhas arrancadas flutuando
    for (let i = Math.floor((camL - 90) / 90); i * 90 < camL + LW + 20; i++) { const x = i * 90 - camL, y = Math.round(117 + Math.sin(t * .8 + i) * 6); R(c, x - 1, y - 1, 70, 54, '#8a7a94'); R(c, x, y, 68, 52, '#d7c9d7'); for (let k = 0; k < 68; k += 4) R(c, x + k, y + 52, 4, 1 + Math.round(hash(k + i * 7) * 4), '#d7c9d7'); for (let j = 0; j < 5; j++) R(c, x + 8, y + 8 + j * 8, 54, 1, '#b395bd'); R(c, x + 9, y + 6, 1, 42, '#c28b9f'); R(c, x, y, 68, 1, '#efe4ef'); }
    for (let i = 0; i < 16; i++) { const x = ((i * 45 + t * 9 - camL) % 540 + 540) % 540 - 20, y = 32 + (i * 31 + t * 11) % 165; R(c, x, y, 3, 2, i % 2 ? '#ddb8d0' : '#a5ca9c'); }
    for (const [x, k] of INK_GLOW) { const sx = x - camL; if (sx < -20 || sx > LW + 20) continue; for (let b = 0; b < 3; b++) { const u = (t * .5 + b / 3 + x) % 1; R(c, sx - 2 + b * 2, 203 - u * 18, 1, 1, css(INK_COL[k], 1 - u)); } }
  }
  function inkText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace'; c.fillStyle = '#f1d3e1'; for (const [x, i] of INK_SIGNS) { if (x * 2 < camera - 300 || x * 2 > camera + 1260) continue; c.fillText(i > 3 ? 'O RABISCO GIGANTE' : 'O CADERNO TEM FOME', (x + 36) * 2, 129); }
    if (window.Art?.drawDoodle) for (let i = Math.floor((camera - 180) / 180); i * 180 < camera + 1000; i++) { if (((i % 3) + 3) % 3 !== 0) continue; c.save(); c.translate(i * 180 + 68, Math.round(117 + Math.sin(lastT * .8 + i) * 6) * 2 + 62); c.scale(1.2, 1.2); try { window.Art.drawDoodle(c, 0, 0, 0, lastT * .4, false); } catch (e) {} c.restore(); } c.restore(); }
  function inkLights(g, s, t, camL) { for (const [x, k] of INK_GLOW) { const sx = x - camL; if (sx < -60 || sx > LW + 60) continue; const p = .75 + .25 * Math.sin(t * 2 + x), b = g.createRadialGradient(sx, 210, 1, sx, 210, 34); b.addColorStop(0, css(INK_COL[k], .55 * p)); b.addColorStop(1, css(INK_COL[k], 0)); g.fillStyle = b; g.fillRect(sx - 36, 174, 72, 72); } }
  // Escuridão: tudo preto, menos em volta da tocha do herói e dos tinteiros luminosos.
  const [darkCv, dk] = mk(LW, LH);
  function darkness(c, scene, camera, t, hx, hy, facing) {
    if (scene !== 6) return;
    const camL = Math.floor(camera / 2), sub = Math.round(camera) - camL * 2, f = facing < 0 ? -1 : 1, fl = 1 + Math.sin(t * 13) * .035 + Math.sin(t * 31) * .02, tx = (hx + sub) / 2 + f * 7, ty = hy / 2 - 22;
    dk.globalCompositeOperation = 'source-over'; dk.clearRect(0, 0, LW, LH); dk.fillStyle = 'rgba(5,3,14,.96)'; dk.fillRect(0, 0, LW, LH); dk.globalCompositeOperation = 'destination-out';
    const hole = (x, y, r) => { for (const [k, a] of [[1, .28], [.84, .42], [.66, .6], [.46, 1]]) ell(dk, x, y, r * k, r * k * .86, `rgba(0,0,0,${a})`); };
    hole(tx, ty, 84 * fl); for (const [x] of INK_GLOW) { const sx = x - camL; if (sx > -50 && sx < LW + 50) hole(sx, 208, 30 + Math.sin(t * 2 + x) * 3); }
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(darkCv, -sub, 0, LW * 2, LH * 2);
    lg.clearRect(0, 0, LW, LH); const b = lg.createRadialGradient(tx, ty, 2, tx, ty, 80 * fl); b.addColorStop(0, 'rgba(255,170,80,.30)'); b.addColorStop(1, 'rgba(255,170,80,0)'); lg.fillStyle = b; lg.fillRect(tx - 90, ty - 90, 180, 180);
    c.globalCompositeOperation = 'lighter'; c.drawImage(lightCv, -sub, 0, LW * 2, LH * 2); c.globalCompositeOperation = 'source-over';
    // a tocha na mão do herói
    const px = Math.round(hx + f * 16), py = Math.round(hy - 50); c.fillStyle = '#5a3a1e'; c.fillRect(px - 2, py, 4, 18); c.fillStyle = '#8a5a2e'; c.fillRect(px - 2, py, 2, 18); c.fillStyle = '#3a3a3a'; c.fillRect(px - 4, py - 2, 8, 4);
    for (let i = 0; i < 7; i++) { const u = (t * 2.4 + i / 7) % 1, w = Math.round((1 - u) * 5) * 2 + 2, fx = px + Math.round(Math.sin(t * 9 + i * 2) * 2 * u) * 2; c.fillStyle = u < .3 ? '#fff3b0' : u < .65 ? '#ffb030' : '#e8581c'; c.fillRect(fx - w / 2, py - 4 - Math.round(u * 9) * 2, w, 4); }
    c.restore();
  }

  // ------------------------------------------------------------------------------- peças comuns de interiores
  const roomAmb = (k) => (s) => mix(s.amb, [1, .94, .84], k);
  function tileFloor(c, W, y0, cols, step, rows = [5, 6, 8, 9, 10, 12]) { // piso em lajotas com perspectiva, entre y0 e o fim da tela
    let fy = y0; rows.forEach((rh, r2) => { const tw = step + r2 * 4; for (let k = -1; k * tw < W; k++) { const x = k * tw + (r2 % 2) * tw / 2, lt = (k + r2) & 1, f = r2 / (rows.length - 1); R(c, x, fy, tw, rh, css(mix(hexv(lt ? cols[0] : cols[1]), hexv(lt ? cols[2] : cols[3]), f))); R(c, x, fy, tw, 1, 'rgba(255,255,255,.22)'); R(c, x, fy, 1, rh, 'rgba(0,0,0,.18)'); if (hash(k * 13 + r2 * 7 + y0) > .88) R(c, x + 3, fy + 2, 4, 1, 'rgba(255,255,255,.2)'); } fy += rh; });
    R(c, 0, y0, W, 1, 'rgba(255,255,255,.35)'); for (let i = 0; i < 4; i++) { c.fillStyle = `rgba(10,16,20,${.2 - i * .045})`; c.fillRect(0, y0 + 1 + i, W, 1); } }
  function winBlind(c, x, y, w, h, i, openPx) { // janela com persiana: o céu só aparece pelas frestas
    x = Math.round(x); R(c, x - 4, y - 4, w + 8, h + 8, '#1d2e2e'); R(c, x - 3, y - 3, w + 6, h + 6, '#3a2f26'); R(c, x - 3, y - 3, w + 6, 1, '#8a6a46'); R(c, x - 3, y - 3, 1, h + 6, '#6e5236'); R(c, x - 1, y - 1, w + 2, h + 2, '#15100c'); c.clearRect(x, y, w, h); R(c, x, y, w, 2, '#c9b384');
    const list = []; for (let yy = y + 2; yy < y + h - openPx - 4; yy += 5) { list.push(yy); R(c, x, yy, w, 3, '#d9c99a'); R(c, x, yy, w, 1, '#f3e6bc'); R(c, x, yy + 2, w, 1, '#a89a70'); } const last = list[list.length - 1];
    for (const cx of [x + 14, x + w - 15]) R(c, cx, y + 2, 1, last - y + 3, '#857b5c'); R(c, x, last + 5, w, 3, '#b3a67e'); R(c, x, last + 5, w, 1, '#d9cc9e'); if (openPx) { R(c, x + w / 2, last + 8, 2, y + h - last - 8, '#3a2f26'); }
    R(c, x - 6, y + h + 4, w + 12, 3, '#a97444'); R(c, x - 6, y + h + 4, w + 12, 1, '#d8a468'); c.fillStyle = 'rgba(0,0,0,.18)'; c.fillRect(x - 4, y + h + 7, w + 8, 2); return list; }
  function blindsLight(g, s, t, wins, camL, W) { const sun = sunInfo(s), col = s.sunT !== null ? s.sun : [.6, .7, 1], lean = sun.lean; if (sun.str < .03) return;
    for (const w of wins) { const wx = w.x - camL; if (wx < -w.w - 120 || wx > LW + 120 || w.x > W) continue; const gaps = w.slats.map((y) => [y + 3, 2]); if (w.open) gaps.push([w.y + w.h - w.open + 2, w.open - 2]);
      gaps.forEach(([gy, gh], n) => { const depth = (w.y + w.h - gy) / w.h, fy = FLOOR + 2 + depth * 44, fh = Math.max(2, gh * .5), sh = lean * (10 + depth * 46);
        gquad(g, [[wx + sh, fy], [wx + w.w + sh, fy], [wx + w.w + sh + lean * fh, fy + fh], [wx + sh + lean * fh, fy + fh]], css(col, .28 * sun.str)); if (n === 0) patchAdd(wx + lean * 10, wx + w.w + lean * 56, lean * 1.1, .55 * sun.str); if (n % 2 === 0 || gh > 2) gquad(g, [[wx, gy], [wx + w.w, gy], [wx + w.w + sh, fy], [wx + sh, fy]], css(col, (gh > 2 ? .07 : .026) * sun.str)); });
      for (let k = 0; k < 6; k++) { const u = (t * .1 + hash(k + w.x)) % 1; g.fillStyle = css(col, .55 * sun.str * (.5 + .5 * Math.sin(t * 3 + k + w.x))); g.fillRect(Math.round(wx + hash(k * 3 + w.x) * w.w + lean * 30 * u), Math.round(w.y + u * (FLOOR - w.y)), 1, 1); } } }
  function bulbGlow(g, x, y, a, rgb = '255,206,120', r = 30) { if (a < .02 || x < -60 || x > LW + 60) return; const b = g.createRadialGradient(x, y, 1, x, y + 2, r); b.addColorStop(0, `rgba(${rgb},${.8 * a})`); b.addColorStop(1, `rgba(${rgb},0)`); g.fillStyle = b; g.fillRect(x - r, y - r, r * 2, r * 2); }
  function pool(g, x, y, a, rgb = '255,206,120', r = 60) { if (a < .02 || x < -90 || x > LW + 90) return; g.save(); g.translate(x, y); g.scale(1, .28); const p = g.createRadialGradient(0, 0, 0, 0, 0, r); p.addColorStop(0, `rgba(${rgb},${.3 * a})`); p.addColorStop(1, `rgba(${rgb},0)`); g.fillStyle = p; g.fillRect(-r, -r, r * 2, r * 2); g.restore(); }
  function wallClock(c, kx, ky, h, rr, face, rim) { ell(c, kx, ky, rr + 2, rr + 2, rim); ell(c, kx, ky, rr, rr, face); for (let i = 0; i < 12; i++) R(c, kx + Math.round(Math.sin(i / 6 * Math.PI) * (rr - 2)), ky - Math.round(Math.cos(i / 6 * Math.PI) * (rr - 2)), 1, 1, '#795a3d'); const hand = (ang, len, col) => { for (let k = 0; k <= len; k++) R(c, kx + Math.round(Math.sin(ang) * k), ky - Math.round(Math.cos(ang) * k), 1, 1, col); }; hand(h / 12 * Math.PI * 2, rr * .5, '#3a2c20'); hand((h % 1) * Math.PI * 2, rr * .78, '#c94f45'); R(c, kx, ky, 1, 1, '#3a2c20'); }

  // ------------------------------------------------------------------------------- BIGODON (mapa 8)
  const BG_ST = []; { for (let x = 32; x < 1800; x += 219) BG_ST.push(x); }
  const BG_WIN = []; { for (let i = 2; i < 9; i++) if (i !== 6) { const w = { x: 163 + 219 * i, y: 28, w: 64, h: 74, open: i % 3 === 0 ? 24 : i % 3 === 1 ? 0 : 10 }; BG_WIN.push(w); } }
  const BG_SOFA = [870, 1195, 1520], BG_POLES = [123, 570];
  function barberChair(c, x, y, occupied, seed) { ell(c, x, y - 1, 15, 3, 'rgba(10,14,16,.3)'); R(c, x - 2, y - 9, 4, 9, '#8a96a0'); R(c, x - 2, y - 9, 1, 9, '#d5dde4'); ell(c, x, y - 1, 11, 3, '#2a3236'); ell(c, x, y - 2, 10, 2.5, '#5a666e');
    R(c, x - 10, y - 25, 20, 3, '#6a757d'); R(c, x - 14, y - 24, 3, 12, '#8a96a0'); R(c, x + 11, y - 24, 3, 12, '#8a96a0'); R(c, x - 10, y - 24, 20, 14, '#2a3236'); R(c, x - 9, y - 23, 18, 12, '#a8322f'); R(c, x - 9, y - 23, 18, 3, '#d4564a'); R(c, x - 9, y - 23, 3, 12, '#c4443c'); R(c, x + 6, y - 23, 3, 12, '#7a2220');
    R(c, x - 12, y - 52, 24, 3, '#6a757d'); R(c, x - 9, y - 49, 18, 25, '#2a3236'); R(c, x - 8, y - 48, 16, 23, '#a8322f'); R(c, x - 8, y - 48, 16, 3, '#d4564a'); R(c, x - 8, y - 48, 3, 23, '#c4443c'); R(c, x + 5, y - 48, 3, 23, '#7a2220'); R(c, x - 5, y - 58, 10, 9, '#2a3236'); R(c, x - 4, y - 57, 8, 7, '#a8322f'); R(c, x - 4, y - 57, 8, 2, '#d4564a');
    R(c, x - 6, y - 8, 12, 2, '#6a757d'); R(c, x - 5, y - 8, 10, 1, '#d5dde4');
    if (occupied) { const sk = FAN_SKIN[seed % 5]; R(c, x - 11, y - 46, 22, 26, '#2a4a7a'); R(c, x - 11, y - 46, 5, 26, '#3a6aa8'); R(c, x + 6, y - 46, 5, 26, '#1d3558'); R(c, x - 6, y - 60, 12, 14, sk); R(c, x - 7, y - 62, 14, 5, FAN_HAIR[seed % 5]); R(c, x - 4, y - 54, 2, 2, '#1c1c22'); R(c, x + 2, y - 54, 2, 2, '#1c1c22'); R(c, x - 6, y - 50, 12, 3, '#f3f3f0'); R(c, x - 5, y - 48, 10, 2, '#f3f3f0'); } }
  const BG_PEOPLE = [3, 5];
  function buildBigodonMid() {
    const W = worldW(8), [cv, c] = mk(W, LH), [lv, l] = mk(W, LH);
    R(c, 0, 14, W, 126, '#d5bea1'); for (let i = 0; i < W * 2; i++) R(c, hash(i + 3) * W, 18 + hash(i + 4) * 118, 1, 1, i % 2 ? '#c9b393' : '#e2cfb3'); for (let x = 0; x < W; x += 12) { R(c, x, 14, 1, 126, 'rgba(255,255,255,.07)'); R(c, x + 6, 14, 1, 126, 'rgba(120,80,40,.06)'); }
    R(c, 0, 0, W, 14, '#29373b'); R(c, 0, 14, W, 3, '#a97444'); R(c, 0, 14, W, 1, '#d8a468'); R(c, 0, 17, W, 2, '#f1d3a0'); R(c, 0, 19, W, 1, 'rgba(60,40,20,.3)'); for (let x = 20; x < W; x += 100) { R(c, x, 0, 8, 14, '#1c282b'); R(c, x, 0, 1, 14, '#3c5258'); }
    R(c, 0, 139, W, 70, '#74513c'); for (let x = 0; x < W; x += 11) { R(c, x, 143, 3, 62, '#4d3a31'); R(c, x + 3, 143, 1, 62, '#9e7350'); R(c, x + 4, 144, 1, 60, 'rgba(0,0,0,.18)'); } for (let i = 0; i < 380; i++) R(c, hash(i + 13) * W, 144 + hash(i + 14) * 60, 1, 2, 'rgba(60,35,20,.35)');
    R(c, 0, 138, W, 3, '#c89b63'); R(c, 0, 138, W, 1, '#e8c48c'); R(c, 0, 141, W, 2, '#4d3a31'); R(c, 0, 205, W, 4, '#3b2a20'); R(c, 0, 205, W, 1, '#6a4a34'); R(c, 0, 209, W, 11, '#1f2628'); R(c, 0, 209, W, 1, '#4a5558');
    tileFloor(c, W, FLOOR, ['#cfc6ae', '#46514f', '#ddd5bd', '#566160'], 11);
    // janelas com persiana
    for (const w of BG_WIN) w.slats = winBlind(c, w.x, w.y, w.w, w.h, 0, w.open);
    // lâmpadas penduradas
    for (let x = 6; x < W; x += 24) { const y = 22 + Math.round(Math.sin(x * .13) * 2 + 3); R(c, x, 20, 1, y - 20, '#1c282b'); R(c, x - 1, y, 3, 2, '#3a3c36'); R(c, x - 2, y + 2, 5, 5, '#ffe1a0'); R(c, x - 1, y + 3, 3, 3, '#fff3cf'); R(c, x - 2, y + 2, 5, 1, '#d8a468'); }
    // estações de barbeiro
    BG_ST.forEach((x, i) => { R(c, x - 1, 61, 109, 94, '#1c282b'); R(c, x, 62, 107, 92, '#b98b52'); R(c, x, 62, 107, 2, '#dcae72'); R(c, x + 3, 65, 101, 86, '#303b3f'); R(c, x + 4, 66, 99, 84, '#576f75'); R(c, x + 6, 68, 95, 80, '#8dafb0'); R(c, x + 6, 68, 95, 20, '#a5c7c8');
      for (let k = 0; k < 74; k++) { c.fillStyle = 'rgba(255,255,255,.2)'; c.fillRect(x + 12 + Math.round((74 - k) * .72), 70 + k, 9, 1); c.fillStyle = 'rgba(255,255,255,.11)'; c.fillRect(x + 36 + Math.round((74 - k) * .72), 70 + k, 4, 1); } R(c, x + 12, 70, 38, 1, '#d2e1cc');
      R(c, x - 6, 154, 120, 7, '#333f40'); R(c, x - 5, 154, 118, 2, '#b98a55'); R(c, x - 3, 161, 114, 25, '#a27a50'); R(c, x - 3, 161, 114, 3, '#76563c'); for (let d = 0; d < 3; d++) { R(c, x + 1 + d * 36, 166, 31, 14, '#805a3f'); R(c, x + 3 + d * 36, 167, 27, 1, '#bd9561'); R(c, x + 13 + d * 36, 172, 8, 2, '#d3be86'); } R(c, x - 3, 186, 114, 1, 'rgba(0,0,0,.3)');
      const cols = ['#67888c', '#b96851', '#d5b677']; for (let j = 0; j < 5; j++) { const bx = x + 2 + j * 13, hh = 11 + (j % 2) * 4; R(c, bx, 154 - hh, 6, hh, cols[j % 3]); R(c, bx, 154 - hh, 2, hh, 'rgba(255,255,255,.3)'); R(c, bx + 1, 151 - hh, 4, 3, '#28393e'); R(c, bx + 1, 148 - hh + 5, 4, 3, '#f0e4bb'); }
      R(c, x + 76, 148, 16, 6, '#d4dbcd'); for (let j = 0; j < 4; j++) R(c, x + 78 + j * 3, 145, 1, 7, '#28383d'); R(c, x + 96, 145, 4, 9, '#46616b'); R(c, x + 95, 143, 6, 3, '#bcc6b7');
      R(c, x + 44, 20, 2, 24, '#3f4140'); R(c, x + 32, 43, 32, 4, '#3b3c36'); R(c, x + 34, 46, 28, 6, '#b68a53'); R(c, x + 41, 51, 14, 2, '#ffe8a4');
      barberChair(c, x + 51, 217, BG_PEOPLE.includes(i), i); R(c, x + 28, 214, 8, 2, '#403b34'); R(c, x + 62, 214, 8, 2, '#53493e'); });
    // letreiro de neon com bigode
    board(c, 146, 24, 262, 32, '#34484c', '#1c282b'); R(c, 149, 27, 256, 26, '#28373b'); R(c, 149, 27, 256, 1, '#e1b16b'); R(c, 149, 52, 256, 1, '#e1b16b'); R(c, 149, 27, 1, 26, '#e1b16b'); R(c, 404, 27, 1, 26, '#e1b16b');
    for (const sd of [-1, 1]) { const pts = [[0, 0], [5, -6], [12, -6], [20, 1], [28, -2], [24, 4], [16, 6], [8, 3]]; for (let k = 0; k < pts.length - 1; k++) { const a = pts[k], b2 = pts[k + 1], n = Math.max(Math.abs(b2[0] - a[0]), Math.abs(b2[1] - a[1])); for (let q = 0; q <= n; q++) { R(c, 209 + sd * (4 + a[0] + (b2[0] - a[0]) * q / n) - (sd > 0 ? 0 : 1), 42 + a[1] + (b2[1] - a[1]) * q / n, 2, 2, '#fae3a8'); } } }
    // postes de barbeiro (listras são ao vivo), relógio, prateleira de toalhas
    for (const x of BG_POLES) { R(c, x - 6, 52, 12, 4, '#3b3c36'); R(c, x - 6, 52, 12, 1, '#8a8a80'); R(c, x - 6, 112, 12, 4, '#3b3c36'); R(c, x - 6, 115, 12, 1, 'rgba(0,0,0,.3)'); }
    R(c, 642, 115, 115, 11, '#2e4141'); R(c, 642, 115, 115, 1, '#4a6a6a'); for (let j = 0; j < 3; j++) { R(c, 646 + j * 36, 109, 33, 7, '#ece1c4'); R(c, 646 + j * 36, 109, 33, 1, '#fff5dd'); R(c, 646 + j * 36, 114, 33, 1, '#b9bcae'); R(c, 646 + j * 36, 111, 33, 1, '#d8cdb0'); }
    // recepção
    R(c, 75, 168, 86, 9, '#293d40'); R(c, 75, 168, 86, 1, '#4a6a6e'); R(c, 79, 177, 78, 30, '#996b46'); for (let k = 0; k < 78; k += 6) R(c, 79 + k, 177, 1, 30, 'rgba(0,0,0,.2)'); R(c, 79, 177, 78, 3, '#c59a65'); R(c, 83, 204, 70, 3, '#4a4437'); R(c, 92, 162, 24, 7, '#d6dfcf'); R(c, 94, 164, 20, 3, '#667e75'); R(c, 132, 155, 12, 14, '#293b42'); R(c, 134, 157, 8, 9, '#84b7b1'); R(c, 138, 167, 2, 2, '#e4cd96'); R(c, 120, 166, 7, 3, '#d7b45a'); R(c, 122, 164, 3, 2, '#ffe9a8'); board(c, 94, 180, 46, 12, '#c9a56a', '#4a3a26');
    // sofás da espera
    for (const x of BG_SOFA) { R(c, x - 1, 182, 109, 29, '#1c282b'); R(c, x, 183, 107, 27, '#273a3d'); R(c, x + 3, 189, 101, 18, '#986553'); R(c, x + 3, 189, 101, 2, '#bd8670'); R(c, x, 177, 107, 11, '#a77158'); R(c, x, 177, 107, 2, '#cc9c76'); for (let j = 0; j < 3; j++) { R(c, x + 7 + j * 32, 192, 27, 15, '#875648'); R(c, x + 9 + j * 32, 193, 23, 2, '#b78261'); R(c, x + 30 + j * 32, 192, 1, 15, '#6a4034'); } R(c, x + 5, 209, 5, 9, '#344342'); R(c, x + 97, 209, 5, 9, '#344342'); c.fillStyle = 'rgba(0,0,0,.2)'; c.fillRect(x, 219, 107, 1); }
    board(c, 1458, 58, 116, 53, '#8c6247', '#303b3f'); R(c, 1460, 60, 112, 1, '#a97a58');
    for (let x = 90; x < W; x += 330) { if (BG_SOFA.some((s2) => Math.abs(x - s2) < 70) || BG_ST.some((s2) => x > s2 - 12 && x < s2 + 118)) continue; R(c, x, 200, 14, 19, '#94704e'); R(c, x - 2, 197, 18, 4, '#c29961'); for (let j = 0; j < 4; j++) { limb(c, [[x + 7, 197], [x + 3 + j * 3, 184 + (j % 2) * 4]], 1, '#466e4a'); ell(c, x + 3 + j * 3, 183 + (j % 2) * 4, 3, 2, j % 2 ? '#6f9c60' : '#91b374'); } }
    return [cv, lv];
  }
  function bigodon(c, s, t, camL) {
    if (!mids[8]) mids[8] = buildBigodonMid(); if (!far) far = buildFar();
    const sun = backdrop(c, s, t, camL, [47, 112]);
    if (s.night > .05) { c.fillStyle = `rgba(6,10,36,${.5 * s.night})`; c.fillRect(0, 0, LW, 140); }
    c.drawImage(mids[8][0], camL, 0, LW, LH, 0, 0, LW, LH);
    for (const x of BG_POLES) { const sx = x - camL; if (sx < -20 || sx > LW + 20) continue; for (let r2 = 0; r2 < 60; r2++) { const ph = ((r2 + t * 10) % 12) / 12, col = ph < .33 ? '#d83a3a' : ph < .66 ? '#f3f3f0' : '#3a6ad8'; R(c, sx - 4, 56 + r2, 8, 1, col); if (r2 % 3 === 0) R(c, sx - 3, 56 + r2, 2, 1, 'rgba(255,255,255,.45)'); R(c, sx + 3, 56 + r2, 1, 1, 'rgba(0,0,0,.35)'); } ell(c, sx, 55, 5, 2, '#d8d8d0'); }
    { const kx = 682 - camL; if (kx > -30 && kx < LW + 30) wallClock(c, kx, 71, window.DayTime.state().h, 14, '#f1dfb5', '#344549'); }
    for (let i = 0; i < 2; i++) { const fx = 380 + i * 780 - camL * .17 * 2 / 2, a = t * 8 + i, x0 = ((fx % LW) + LW) % LW; R(c, x0 - 1, 14, 2, 24, '#3e4946'); for (let b = 0; b < 3; b++) { const an = a + b * 2.09, dx = Math.cos(an), dy = Math.sin(an) * .34; for (let k = 4; k < 25; k++) R(c, x0 + dx * k, 38 + dy * k, 2, 1, '#65736b'); } ell(c, x0, 38, 3, 2, '#334344'); }
    for (let i = 0; i < 12; i++) { const dx = ((i * 57 + t * 2 - camL * .36) % LW + LW) % LW, dy = 40 + (i * 31 + t * 3) % 160; R(c, dx, dy, 1, 1, i % 2 ? 'rgba(244,215,155,.55)' : 'rgba(245,233,190,.4)'); }
    if (sun.str > .04) { const sh = `rgba(40,24,14,${.22 * sun.str})`; for (const x of BG_SOFA) slant(c, x - camL, x - camL + 107, 220, sun.lean * 20, 3, sh); }
  }
  function bigodonText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace'; c.fillStyle = '#7a4a1c'; c.fillText('BIGODON', 546, 82); c.fillStyle = '#fae3a8'; c.fillText('BIGODON', 544, 80); c.font = '8px Pixel, monospace'; c.fillStyle = '#a8c9bd'; c.fillText('CORTE NA RÉGUA, RESENHA SEM MEDIDA', 544, 98); c.fillStyle = '#f0d9a8'; c.fillText('RECEPÇÃO', 232, 372); c.font = '16px Pixel, monospace'; c.fillStyle = '#f2d69e'; c.fillText('AQUI O PAPO', 3032, 140); c.fillText('RENDE MAIS', 3032, 166); c.font = '8px Pixel, monospace'; c.fillText('QUE O DEGRADÊ.', 3032, 192); c.restore(); }
  function bigodonLights(g, s, t, camL) { const W = worldW(8), a = cl((s.night - .12) * 1.4), base = .4 + a * .6;
    blindsLight(g, s, t, BG_WIN, camL, W); g.save(); g.beginPath(); for (const w of BG_WIN) g.rect(w.x - camL, w.y, w.w, w.h); g.clip(); g.globalAlpha = a; tile(g, city(47, 112)[1], camL * .07); g.restore();
    for (let x = 6; x < W; x += 24) { const y = 22 + Math.round(Math.sin(x * .13) * 2 + 3), sx = x - camL; if (sx < -30 || sx > LW + 30) continue; bulbGlow(g, sx, y + 4, base * (.85 + .15 * Math.sin(t * 2 + x)), '255,200,110', 20); }
    BG_ST.forEach((x) => { const sx = x - camL + 51; if (sx < -90 || sx > LW + 90) return; lightAdd(sx, 52, base * .9, 48); const gr = g.createLinearGradient(0, 52, 0, 230); gr.addColorStop(0, `rgba(255,222,150,${.32 * base})`); gr.addColorStop(1, `rgba(255,222,150,${.04 * base})`); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 12, 52); g.lineTo(sx + 12, 52); g.lineTo(sx + 48, 232); g.lineTo(sx - 48, 232); g.closePath(); g.fill(); pool(g, sx, 224, base, '255,214,140', 48); });
    bulbGlow(g, 544 - camL, 40, .35 + a * .65, '255,190,90', 70); bulbGlow(g, 209 - camL, 42, .3 + a * .7, '255,214,150', 26); for (const x of BG_POLES) bulbGlow(g, x - camL, 84, a * .5, '255,255,255', 24); }

  // ------------------------------------------------------------------------------- CASA DA RAYSSA (mapa 10)
  const RY_WIN = []; { for (let x = 62, i = 0; x < 2100; x += 330, i++) RY_WIN.push({ x, y: 65, w: 103, h: 76, i }); }
  const RY_SOFA = []; { for (let x = 175, i = 0; x < 1025; x += 235, i++) RY_SOFA.push([x, i]); }
  const RY_ART = [[500, 'SE TOCA, MENINO', '#b08b9c'], [820, 'AFF VEYR JURO', '#85a9a6'], [1350, 'AQUI TEM RESENHA', '#b39268']];
  const RY_PLANTS = [35, 352, 557, 855, 1235, 1600], RY_LAMPS = [200, 470, 740, 1010, 1280, 1550, 1820];
  function buildRayssaMid() {
    const W = worldW(10), [cv, c] = mk(W, LH), [lv, l] = mk(W, LH);
    R(c, 0, 14, W, 150, '#eddcbf'); for (let i = 0; i < W * 2; i++) R(c, hash(i + 3) * W, 18 + hash(i + 4) * 145, 1, 1, i % 2 ? '#e0cdae' : '#f6e9d0'); for (let x = 0; x < W; x += 14) { R(c, x, 14, 1, 150, 'rgba(255,255,255,.1)'); for (let y = 30; y < 150; y += 22) { R(c, x + 6, y + ((x / 14) % 2) * 8, 2, 2, 'rgba(184,112,100,.22)'); R(c, x + 7, y + 2 + ((x / 14) % 2) * 8, 1, 1, 'rgba(110,150,110,.25)'); } }
    R(c, 0, 0, W, 14, '#40575a'); R(c, 0, 14, W, 4, '#b18b63'); R(c, 0, 14, W, 1, '#d4ad82'); R(c, 0, 18, W, 2, '#f8e6bc'); R(c, 0, 20, W, 1, 'rgba(60,40,20,.25)');
    R(c, 0, 132, W, 32, '#9db8ae'); R(c, 0, 132, W, 2, '#f8e6bc'); R(c, 0, 134, W, 1, 'rgba(60,70,60,.35)'); for (let x = 6; x < W; x += 40) { R(c, x, 138, 28, 22, '#a9c4ba'); R(c, x, 138, 28, 1, '#d3e6dc'); R(c, x, 159, 28, 1, '#7a968c'); R(c, x, 138, 1, 22, '#d3e6dc'); R(c, x + 27, 138, 1, 22, '#7a968c'); }
    R(c, 0, 162, W, 3, '#416d70'); R(c, 0, 162, W, 1, '#6a9da0'); R(c, 0, 164, W, 56, '#84aaa2');
    tileFloor(c, W, 164, ['#9bc0b6', '#7fa69d', '#a9ccc2', '#8cb2a8'], 20, [6, 7, 8, 9, 10, 11, 12, 13, 14, 16]);
    for (let x = 0; x < W; x += 210) { R(c, x + 6, 20, 4, 144, '#d2ba96'); R(c, x + 7, 20, 1, 144, '#fff0ce'); R(c, x + 9, 20, 1, 144, '#a98f68'); R(c, x + 13, 52, 160, 3, '#d8c49d'); R(c, x + 13, 52, 160, 1, '#f2e2c0'); }
    // janelas com cortinas e jardim lá fora (o céu aparece pelo vidro)
    for (const w of RY_WIN) { const x = w.x, y = w.y; R(c, x - 7, y - 8, w.w + 14, 5, '#705d48'); R(c, x - 6, y - 8, w.w + 12, 1, '#a38a68'); R(c, x - 3, y - 3, w.w + 6, w.h + 6, '#80684d'); R(c, x - 3, y - 3, w.w + 6, 1, '#a88d66'); c.clearRect(x, y, w.w, w.h); R(c, x + 50, y, 3, w.h, '#f1e4c4'); R(c, x, y + 37, w.w, 3, '#f1e4c4'); R(c, x + 51, y, 1, w.h, '#c9b88f'); R(c, x - 5, y + w.h + 3, w.w + 10, 4, '#b18b5d'); R(c, x - 5, y + w.h + 3, w.w + 10, 1, '#d9b682'); c.fillStyle = 'rgba(0,0,0,.14)'; c.fillRect(x - 3, y + w.h + 7, w.w + 6, 2);
      for (const sd of [-1, 1]) { const cx = sd < 0 ? x - 4 : x + w.w - 11, col = w.i % 2 ? ['#d6a5a0', '#bd8884'] : ['#b9b9cf', '#9a9ab4']; for (let r2 = 0; r2 < 66; r2++) { const u = r2 / 65; R(c, cx - (sd < 0 ? 0 : -1), y - 1 + r2, 15 - Math.round(u * 3), 1, col[0]); } for (let k = 0; k < 4; k++) R(c, cx + k * 3, y - 1, 1, 64, col[1]); R(c, cx, y - 1, 15, 2, '#705d48'); }
      R(c, x - 7, y - 6, w.w + 14, 2, '#3a2f26'); for (let k = 0; k < 8; k++) R(c, x - 5 + k * 14, y - 5, 2, 3, '#c9a56a'); }
    // faixa com o nome da casa
    board(c, 172, 27, 257, 27, '#718c7d', '#425c5e'); R(c, 175, 31, 251, 2, '#bbd2b0'); for (const [bx, by] of [[175, 33], [423, 33]]) R(c, bx, by, 2, 2, '#e8d9a0');
    // sofás e tapetes
    for (const [x, i] of RY_SOFA) { R(c, x - 6, 205, 134, 8, i % 2 ? '#a65e5c' : '#a7774d'); R(c, x - 5, 205, 132, 1, 'rgba(255,255,255,.25)'); for (let k = 0; k < 134; k += 5) R(c, x - 6 + k, 213, 2, 3, i % 2 ? '#7a403e' : '#7a5632'); R(c, x - 8, 186, 10, 28, i % 2 ? '#a65e5c' : '#a7774d'); R(c, x + 124, 186, 10, 28, i % 2 ? '#a65e5c' : '#a7774d'); R(c, x - 8, 186, 10, 3, '#d99987'); R(c, x + 124, 186, 10, 3, '#d99987');
      R(c, x - 2, 175, 126, 40, '#5a5e50'); R(c, x, 171, 122, 36, i % 2 ? '#b56e68' : '#bb8b5b'); R(c, x, 171, 122, 5, i % 2 ? '#d99987' : '#e4b47a'); R(c, x, 171, 5, 36, 'rgba(255,255,255,.12)'); for (let j = 0; j < 3; j++) { R(c, x + 2 + j * 40, 178, 37, 26, i % 2 ? '#c07b70' : '#d09e68'); R(c, x + 4 + j * 40, 179, 33, 2, i % 2 ? '#dda18d' : '#edc18a'); R(c, x + 38 + j * 40, 178, 1, 26, 'rgba(0,0,0,.2)'); }
      R(c, x + 8, 207, 5, 12, '#625844'); R(c, x + 108, 207, 5, 12, '#625844'); R(c, x + 12, 174, 16, 15, i % 2 ? '#e4d59d' : '#8eafa3'); R(c, x + 14, 176, 12, 11, i % 2 ? '#f2e3af' : '#b7cfb4'); R(c, x + 92, 175, 15, 14, '#d9b0b5'); R(c, x + 94, 177, 11, 10, '#ecc8cc'); c.fillStyle = 'rgba(0,0,0,.18)'; c.fillRect(x - 6, 219, 134, 1); }
    // plantas
    for (const x of RY_PLANTS) { R(c, x, 197, 22, 22, '#94704e'); R(c, x - 2, 194, 26, 4, '#c29961'); R(c, x + 3, 202, 16, 1, '#d8b47a'); R(c, x + 6, 186, 11, 8, '#bf755a'); R(c, x + 5, 184, 13, 3, '#d99572'); }
    // quadros e relógio
    for (const [x, , col] of RY_ART) { R(c, x - 1, 67, 104, 52, '#4a3a2a'); R(c, x, 68, 102, 50, '#76624b'); R(c, x + 3, 71, 96, 44, '#efdfbd'); R(c, x + 6, 74, 90, 32, col); for (let k = 0; k < 90; k += 2) { const hh = 6 + Math.round(Math.sin(k * .15) * 5 + Math.sin(k * .4) * 2.5); R(c, x + 6 + k, 74 + 32 - hh, 2, hh, '#ead5ae'); } R(c, x + 6, 74, 90, 1, 'rgba(255,255,255,.25)'); }
    // cozinha
    R(c, 1010, 148, 266, 62, '#b3b49a'); for (let i = 0; i < 6; i++) { R(c, 1013 + i * 43, 152, 40, 52, '#d4c7a0'); R(c, 1015 + i * 43, 154, 36, 2, '#f3e3bb'); R(c, 1027 + i * 43, 160, 10, 2, '#7d8673'); R(c, 1013 + i * 43, 203, 40, 1, 'rgba(0,0,0,.2)'); } R(c, 1007, 145, 272, 7, '#7c8572'); R(c, 1008, 145, 270, 2, '#e6dcc0');
    R(c, 1020, 89, 136, 48, '#758b80'); for (let i = 0; i < 3; i++) { R(c, 1022 + i * 45, 92, 41, 41, '#c1c5ab'); R(c, 1024 + i * 45, 94, 37, 2, '#e8e3c6'); R(c, 1038 + i * 45, 123, 10, 2, '#728574'); } for (let x = 1158; x < 1275; x += 6) for (let y = 112; y < 144; y += 6) { R(c, x, y, 5, 5, ((x + y) / 6) & 1 ? '#dfe8e0' : '#cfdcd4'); } R(c, 1158, 112, 117, 1, '#9fb0a8');
    R(c, 1180, 134, 49, 11, '#5c6c65'); ell(c, 1205, 135, 20, 5, '#a9bbb0'); R(c, 1204, 123, 3, 13, '#b6c8bd'); R(c, 1205, 122, 10, 2, '#dbe4ce'); R(c, 1078, 133, 18, 11, '#736c64'); R(c, 1077, 131, 20, 3, '#c0b8a0'); for (let k = 0; k < 4; k++) R(c, 1082 + k * 4, 128, 2, 3, '#c94f45');
    // varanda com portas de vidro
    R(c, 1450, 108, 185, 99, '#5f8780'); R(c, 1453, 111, 179, 93, '#a0c1ae'); R(c, 1460, 120, 163, 76, '#83aeaa'); c.clearRect(1460, 120, 163, 76); for (let j = 0; j < 4; j++) R(c, 1461 + j * 32 + 1, 120, 3, 76, '#d2dfc3'); R(c, 1460, 155, 163, 3, '#d2dfc3'); R(c, 1443, 104, 197, 6, '#3f6a68'); R(c, 1443, 104, 197, 1, '#6a9a96');
    for (let k = 0; k < 6; k++) R(c, 1450 + k * 36, 196, 20, 4, '#e8d9a0');
    return [cv, lv];
  }
  function rayssa(c, s, t, camL) {
    if (!mids[10]) mids[10] = buildRayssaMid(); if (!far) far = buildFar();
    const sun = sunInfo(s), la = Math.min(1, Math.abs(sun.lean) * 1.3) * sun.str;
    sky(c, s, t, camL, { amb: roomAmb(.6)(s) }); tile(c, far[0], camL * .04); if (la > .03) { c.globalAlpha = la; tile(c, far[sun.lean >= 0 ? 3 : 4][0], camL * .04); c.globalAlpha = 1; } tile(c, far[1], camL * .1 + 300); tile(c, far[2], camL * .22 + 500);
    for (let x = ((-camL * .4) % 90 + 90) % 90 - 90; x < LW + 90; x += 90) { const sd = Math.round((x + camL * .4) / 90); ell(c, x + 20, 150, 22, 16, '#2a6a3a'); ell(c, x + 18, 146, 18, 12, '#3f8a46'); ell(c, x + 12, 141, 9, 5, '#68ad58'); for (let k = 0; k < 6; k++) R(c, x + 6 + hash(sd * 7 + k) * 28, 140 + hash(sd * 5 + k) * 18, 2, 2, ['#e86a8a', '#f2d24a', '#ffffff'][k % 3]); }
    R(c, 0, 158, LW, 6, '#4f9a3f'); R(c, 0, 158, LW, 1, '#8fcf6a');
    if (s.night > .05) { c.fillStyle = `rgba(6,10,36,${.5 * s.night})`; c.fillRect(0, 0, LW, 164); }
    c.drawImage(mids[10][0], camL, 0, LW, LH, 0, 0, LW, LH);
    { const kx = 1145 - camL; if (kx > -30 && kx < LW + 30) wallClock(c, kx, 71, s.h, 16, '#f0e3bb', '#74614c'); }
    for (const x of RY_PLANTS) { const sx = x - camL; if (sx < -50 || sx > LW + 50) continue; for (let j = 0; j < 5; j++) { const xx = sx + 11 + (j - 2) * 5 + Math.sin(t + j) * 1, yy = 169 - Math.sin(t * .8 + j) * 1; limb(c, [[sx + 11, 184], [xx, yy]], 1, '#466e4a'); ell(c, xx + (j % 2 ? 5 : -5), yy - 1, 6, 3, j % 2 ? '#6f9c60' : '#91b374'); } }
    { const sx = 1205 - camL; if (sx > -60 && sx < LW + 60) for (let i = 0; i < 4; i++) { const yy = 126 - ((t * 6.5 + i * 4) % 18), xx = sx + Math.sin(t + i) * 2.5; ell(c, xx, yy, 3, 2, 'rgba(225,230,209,.55)'); } }
    for (let i = 0; i < 12; i++) { const dx = ((i * 69 + t * 1.5 - camL * .2) % LW + LW) % LW, dy = 38 + (i * 33 + t * 2) % 160; R(c, dx, dy, 1, 1, 'rgba(255,241,199,.5)'); }
    for (const [x] of RY_SOFA) { if (sun.str > .04) slant(c, x - camL - 6, x - camL + 128, 220, sun.lean * 18, 3, `rgba(40,30,30,${.2 * sun.str})`); }
    // luz do sol pelas janelas: vitral em quatro vidros no chão e na parede
    if (sun.str > .03) { const col = s.sunT !== null ? s.sun : [.6, .7, 1], lean = sun.lean, str = sun.str, ox = Math.round(lean * 30);
      for (const w of RY_WIN) { const wx = w.x - camL; if (wx < -140 || wx > LW + 40) continue; for (const [px, py] of [[0, 0], [52, 0], [0, 40], [52, 40]]) { const pw = px ? 51 : 50, ph = py ? 36 : 38, x0 = wx + px + ox * (py ? 1.2 : 1), yy = 168 + (py ? 24 : 6); gquad2(c, [[x0, yy], [x0 + pw, yy], [x0 + pw + lean * 12, yy + ph * .5], [x0 + lean * 12, yy + ph * .5]], css(col, .13 * str)); } } }
  }
  function gquad2(c, pts, col) { c.fillStyle = col; c.beginPath(); c.moveTo(pts[0][0], pts[0][1]); for (let i = 1; i < 4; i++) c.lineTo(pts[i][0], pts[i][1]); c.closePath(); c.fill(); }
  function rayssaText(c, camera) { c.save(); c.translate(-Math.round(camera), 0); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = '16px Pixel, monospace'; c.fillStyle = '#fff0c9'; c.fillText('CASA DE RAYSSA', 600, 82); c.font = '8px Pixel, monospace'; c.fillStyle = '#dce7bc'; c.fillText('PORTA ABERTA · CAFÉ NA MESA · RESENHA EM DIA', 600, 100); c.fillStyle = '#4b6257'; for (const [x, label] of RY_ART) c.fillText(label, (x + 51) * 2, 226); c.restore(); }
  function rayssaLights(g, s, t, camL) { const a = cl((s.night - .12) * 1.4), base = .3 + a * .7; const sun = sunInfo(s), col = s.sunT !== null ? s.sun : [.6, .7, 1];
    if (sun.str > .03) for (const w of RY_WIN) { const wx = w.x - camL; if (wx < -150 || wx > LW + 60) continue; const sh = sun.lean * 40; for (const [px, py] of [[0, 0], [52, 0], [0, 40], [52, 40]]) { const pw = px ? 50 : 50, ph = py ? 35 : 38; gquad(g, [[wx + px, w.y + py], [wx + px + pw, w.y + py], [wx + px + pw + sh, 176 + py * .3], [wx + px + sh, 176 + py * .3]], css(col, .05 * sun.str)); } }
    for (const x of RY_LAMPS) { const sx = x - camL; if (sx < -90 || sx > LW + 90) continue; lightAdd(sx, 36, base * .8, 56); bulbGlow(g, sx, 36, base, '255,214,150', 34); const gr = g.createLinearGradient(0, 36, 0, 240); gr.addColorStop(0, `rgba(255,222,160,${.24 * base})`); gr.addColorStop(1, `rgba(255,222,160,${.03 * base})`); g.fillStyle = gr; g.beginPath(); g.moveTo(sx - 8, 36); g.lineTo(sx + 8, 36); g.lineTo(sx + 56, 236); g.lineTo(sx - 56, 236); g.closePath(); g.fill(); pool(g, sx, 226, base, '255,214,150', 54); }
    bulbGlow(g, 1205 - camL, 138, .3 + a * .6, '255,190,100', 34); for (const w of RY_WIN) bulbGlow(g, w.x + 51 - camL, 100, a * .3, '150,170,255', 40); }

  // ------------------------------------------------------------------------------- ARENAS DE CHEFE (480x270, centro em x=240)
  // Cada arena tem camadas próprias (de 780 de largura) em parallax: o fundo anda devagar,
  // a frente acompanha a câmera. Todas desenhadas em pixels de arte, ampliadas 2x.
  const AO = 150, AW = 780, ARENA = {};
  const arenaLayers = {};
  const [alow, ac] = mk(LW, LH);
  function aLayer(key, build) { if (!arenaLayers[key]) { const [cv, c] = mk(AW, LH); c.translate(AO, 0); build(c); arenaLayers[key] = cv; } return arenaLayers[key]; }
  function arenaGround(c, base, dark, line, top, step) { R(c, -AO, FLOOR, AW, 50, base); R(c, -AO, 240, AW, 30, dark); dither(c, -AO, 239, AW, dark); for (let x = -AO; x < AW - AO; x += step) { R(c, x, 225, 1, 45, line); R(c, x + 1, 225, 1, 45, 'rgba(255,255,255,.14)'); } R(c, -AO, 248, AW, 1, line); for (let i = 0; i < 700; i++) R(c, -AO + hash(i + 223) * AW, 226 + hash(i + 224) * 43, 1 + hash(i) * 2, 1, i % 3 ? 'rgba(0,0,0,.12)' : 'rgba(255,255,255,.14)'); R(c, -AO, FLOOR, AW, 3, top); R(c, -AO, FLOOR, AW, 1, 'rgba(255,255,255,.4)'); R(c, -AO, FLOOR + 3, AW, 2, line); }
  function poly(c, pts, col) { c.fillStyle = col; c.beginPath(); c.moveTo(pts[0][0], pts[0][1]); for (let i = 1; i < pts.length; i++) c.lineTo(pts[i][0], pts[i][1]); c.closePath(); c.fill(); }
  function hillLine(c, x0, x1, base, amp, seed, fill, edge, edgeW = 1) { for (let x = x0; x < x1; x++) { const y = Math.round(base - amp * (.55 + .45 * Math.sin(x * .021 + seed)) * (.6 + .4 * Math.sin(x * .053 + seed * 2)) - Math.sin(x * .17 + seed) * 2); R(c, x, y, 1, LH - y, fill); if (edge) R(c, x, y, 1, edgeW, edge); } }
  function cakeHD(c, x, y) { R(c, x - 14, y - 2, 28, 3, '#e8d8c0'); R(c, x - 12, y - 10, 24, 9, '#7a4a30'); R(c, x - 12, y - 10, 24, 2, '#e8c898'); R(c, x - 9, y - 18, 18, 8, '#a8603c'); R(c, x - 9, y - 18, 18, 2, '#f0d8a8'); for (let k = 0; k < 6; k++) R(c, x - 11 + k * 4, y - 9, 2, 3 + (k % 2) * 2, '#f6ecd0'); R(c, x - 3, y - 25, 6, 7, '#f6ecd0'); R(c, x - 1, y - 30, 2, 5, '#c94f45'); R(c, x - 2, y - 32, 4, 3, '#e04a3a'); R(c, x - 2, y - 32, 1, 1, '#ff9a8a'); }
  function student(c, x, y, n, t, cheer) { const bob = cheer ? Math.round(Math.max(0, Math.sin(t * (4 + hash(n) * 2.5) + n)) * 2) : 0, yy = y - bob, sk = FAN_SKIN[n % 5]; R(c, x, yy + 5, 7, 6, FAN_SHIRT[n % 6]); R(c, x + 1, yy, 5, 5, sk); R(c, x + 1, yy - 1, 5, 2, FAN_HAIR[(n * 3) % 5]); R(c, x + 2, yy + 2, 1, 1, '#1c1c22'); R(c, x + 4, yy + 2, 1, 1, '#1c1c22'); if (cheer && (n + Math.floor(t * 1.6)) % 4 === 0) { R(c, x - 1, yy - 4, 2, 8, sk); R(c, x + 6, yy - 4, 2, 8, sk); } }

  // --- ARTHUR: duelo no pátio, com a escola, a torcida na arquibancada e a hora do dia
  const ART_FAR = (c) => {
    // prédio principal com torre do relógio
    R(c, 20, 58, 440, 96, '#e9eee9'); for (let i = 0; i < 900; i++) R(c, 20 + hash(i + 3) * 440, 60 + hash(i + 4) * 90, 1, 1, i % 2 ? '#dde4df' : '#f6f9f6'); R(c, 18, 54, 444, 5, '#173e65'); R(c, 18, 54, 444, 1, '#3a6a94'); R(c, 20, 140, 440, 14, '#254f75'); R(c, 20, 140, 440, 1, '#3a6a94');
    for (let r2 = 0; r2 < 3; r2++) for (let k = 0; k < 15; k++) { const x = 30 + k * 28.5, y = 66 + r2 * 24; if (x > 196 && x < 270) continue; R(c, x, y, 16, 16, '#294e68'); R(c, x + 1, y + 1, 14, 14, '#7bafb7'); R(c, x + 1, y + 1, 14, 5, '#a5cbd0'); R(c, x + 7, y + 1, 1, 14, '#e6eee1'); R(c, x - 1, y + 16, 18, 2, '#c7d9e0'); }
    R(c, 205, 20, 70, 120, '#f3f6f1'); R(c, 205, 20, 2, 120, '#ffffff'); R(c, 272, 20, 3, 120, '#c8d2cc'); R(c, 200, 16, 80, 5, '#173e65'); for (let r2 = 0; r2 < 12; r2++) R(c, 210 + r2 * 2, 4 + r2, 60 - r2 * 4, 1, '#2d5a86'); R(c, 239, -2, 2, 6, '#5a6a7a');
    R(c, 222, 108, 36, 32, '#5c4a36'); R(c, 224, 110, 32, 30, '#8a6a46'); R(c, 239, 110, 2, 30, '#5c4a36'); R(c, 225, 104, 30, 3, '#173e65');
    R(c, 300, 8, 2, 50, '#8a96a0'); R(c, 300, 8, 2, 1, '#e0e8ee');
    for (const [x, s] of [[48, 1], [150, .8], [330, .9], [430, 1.1]]) { for (let k = 0; k < 28 * s; k++) R(c, x + Math.round(k * .08), 154 - k, 3, 1, k % 4 ? '#7a5a3a' : '#5a4028'); for (let i = 0; i < 7; i++) { const a = -Math.PI + .25 + i * .44, L = 16 * s; for (let k = 0; k <= L; k++) { const u = k / L; R(c, x + 2 + Math.cos(a) * k, 154 - 28 * s + Math.sin(a) * k * .5 + u * u * 8 * s, 2, 1, i % 2 ? '#3f8a46' : '#5aa850'); } } }
  };
  const ART_MID = (c) => {
    // arquibancada e alambrado
    for (let r2 = 0; r2 < 3; r2++) { const y = 160 + r2 * 13; R(c, -AO, y + 9, AW, 4, '#9aa6b0'); R(c, -AO, y + 9, AW, 1, '#d0d8de'); R(c, -AO, y + 13, AW, 3, '#5f6c78'); } for (let x = -AO; x < AW - AO; x += 40) R(c, x, 169, 3, 51, '#4f5c66');
    c.fillStyle = 'rgba(160,175,170,.45)'; for (let y = 120; y < 200; y++) for (let x = -AO + (y % 6); x < AW - AO; x += 6) c.fillRect(x, y, 1, 1);
    R(c, -AO, 118, AW, 2, '#657e71'); R(c, -AO, 118, AW, 1, '#93a898'); for (let x = -AO; x < AW - AO; x += 48) { R(c, x, 118, 3, 82, '#597a70'); R(c, x, 118, 1, 82, '#99a48a'); }
    // faixas pintadas pelos alunos
    for (const [x, w, col] of [[100, 280, '#f3ead6'], [-110, 120, '#e8c84a'], [470, 110, '#7ac8e8']]) { R(c, x, 124, w, 22, col); R(c, x, 124, w, 1, 'rgba(255,255,255,.5)'); for (let k = 0; k < w; k += 4) R(c, x + k, 146, 3, 1 + (k % 3), col); R(c, x - 1, 123, 2, 3, '#5a5a5a'); R(c, x + w - 1, 123, 2, 3, '#5a5a5a'); for (let i = 0; i < 30; i++) R(c, x + hash(i + x) * w, 126 + hash(i + x + 1) * 18, 1, 1, 'rgba(0,0,0,.08)'); }
  };
  const ART_NEAR = (c) => {
    R(c, -AO, 200, AW, 20, '#b9c3bd'); for (let x = -AO; x < AW - AO; x += 30) R(c, x, 201, 1, 19, '#a3aea8'); R(c, -AO, 200, AW, 1, '#e3e8e2');
    arenaGround(c, '#bacbc7', '#a9bbb7', '#80a6aa', '#f3efcf', 29.5);
    for (let a = 0; a < 260; a++) { const an = a / 260 * Math.PI * 2, x = 240 + Math.cos(an) * 120, y = 245 + Math.sin(an) * 16; if (hash(a + 5) > .15) R(c, x, y, 2, 1, 'rgba(255,255,255,.7)'); } R(c, 238, 230, 4, 30, 'rgba(255,255,255,.5)');
    for (const x of [55, 404]) { R(c, x - 1, 164, 27, 56, '#1d3a4c'); R(c, x, 165, 25, 54, '#315d7a'); R(c, x + 2, 168, 21, 30, '#527c91'); for (let r2 = 0; r2 < 3; r2++) for (let k = 0; k < 3; k++) { R(c, x + 4 + k * 6, 171 + r2 * 9, 4, 6, ['#e04a3a', '#3a7fd0', '#e8c23a'][(k + r2) % 3]); R(c, x + 4 + k * 6, 171 + r2 * 9, 4, 1, 'rgba(255,255,255,.5)'); } R(c, x + 2, 203, 21, 8, '#1d2a30'); R(c, x + 18, 200, 3, 3, '#7ad87a'); R(c, x - 3, 162, 31, 4, '#bed4cf'); for (let k = 0; k < 18; k++) R(c, x + 4 + Math.round((18 - k) * .4), 169 + k, 2, 1, 'rgba(255,255,255,.3)'); }
    for (const [x, d] of [[-80, 1], [560, -1]]) { R(c, x, 120, 4, 100, '#425e58'); R(c, x, 120, 1, 100, '#6f8a82'); R(c, x + (d > 0 ? 4 : -34), 108, 34, 22, '#d3d2b8'); R(c, x + (d > 0 ? 6 : -32), 110, 30, 18, '#849e91'); R(c, x + (d > 0 ? 20 : -18), 128, 14, 2, '#c16f4e'); }
    for (const [x, col] of [[30, '#c9574a'], [150, '#3a6a9a'], [330, '#e8c23a'], [440, '#6ab86a']]) { R(c, x, 212, 8, 8, col); R(c, x + 1, 210, 6, 2, col); R(c, x + 2, 214, 4, 2, 'rgba(255,255,255,.3)'); R(c, x, 219, 8, 1, 'rgba(0,0,0,.25)'); }
  };
  ARENA.arthur = { daytime: true, layers: [[.3, 'arthur-far', ART_FAR], [.6, 'arthur-mid', ART_MID], [1, 'arthur-near', ART_NEAR]],
    back(c, s, t, ox) { sky(c, s, t, 0); tile(c, city(31, 108)[0], -ox * .12); },
    mid(c, s, t, ox) { const fx = Math.round(ox * .3); { const kx = 240 + fx, ky = 36; ell(c, kx, ky, 11, 11, '#173e65'); wallClock(c, kx, ky, s.h, 9, '#f6f2e2', '#c8b88a'); } for (let k = 0; k < 13; k++) { const wv = Math.round(Math.sin(t * 3 + k * .5) * (k / 12) * 2); R(c, 302 + k + fx, 9 + wv, 1, 9, k < 6 ? '#2a5ab8' : '#e8c84a'); } const mx = Math.round(ox * .6); for (let r2 = 0; r2 < 3; r2++) for (let k = 0; k < 66; k++) { const x = -AO + 4 + k * 12 + (r2 % 2) * 6 + mx, y = 160 + r2 * 13 - 2; if (x < -10 || x > LW + 10) continue; if (hash(k * 7 + r2) < .18) continue; student(c, x, y, k * 3 + r2 * 31, t, true); } },
    text(c, t, ox) { c.save(); c.translate(Math.round(ox * .6) * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#c94f45'; c.fillText('UM ACERTO NO PÁTIO', 480, 270); c.fillStyle = '#2a3a78'; c.fillText('BRIGA!', -100, 270); c.fillStyle = '#16476a'; c.fillText('UUUH!', 1050, 270); c.restore(); },
    light(g, s, t) { const a = cl((s.night - .12) * 1.4); for (const x of [-60, 540]) { if (a < .02) break; const gr = g.createLinearGradient(0, 100, 0, 262); gr.addColorStop(0, `rgba(235,240,255,${.3 * a})`); gr.addColorStop(1, `rgba(235,240,255,${.04 * a})`); g.fillStyle = gr; g.beginPath(); g.moveTo(x - 6, 100); g.lineTo(x + 6, 100); g.lineTo(x + 120 * Math.sign(240 - x), 262); g.lineTo(x + 20 * Math.sign(240 - x), 262); g.closePath(); g.fill(); } } };

  // --- MARCO: dentro do caderno, à noite
  const MAR_FAR = (c) => {
    R(c, -AO, 0, AW, LH, '#1e1b33'); for (let x = -AO; x < AW - AO; x += 8) R(c, x, 0, 1, LH, x % 40 ? '#26234a' : '#34306a'); for (let y = 0; y < LH; y += 8) R(c, -AO, y, AW, 1, y % 40 ? '#26234a' : '#34306a');
    for (let x = -AO + 6; x < AW - AO; x += 22) { ell(c, x + 4, 4, 6, 7, '#5a5878'); ell(c, x + 4, 4, 4, 5, '#1e1b33'); R(c, x, 0, 2, 6, '#b8b8d8'); R(c, x + 1, 9, 6, 2, '#0e0c1c'); }
    for (let a = 0; a < 140; a++) { const an = a / 140 * 6.28; R(c, 360 + Math.cos(an) * 18, 44 + Math.sin(an) * 18, 1, 1, '#c8d0ff'); } for (let k = -16; k < 16; k += 3) for (let j = 0; j < 30; j++) { const x = 360 + k + j * .5 - 7, y = 44 - 15 + j; if ((x - 360) ** 2 + (y - 44) ** 2 < 300) R(c, x, y, 1, 1, '#8a96e8'); }
    for (let i = 0; i < 40; i++) { const x = -AO + hash(i + 31) * AW, y = 14 + hash(i + 32) * 90; R(c, x - 1, y, 3, 1, '#9aa6ff'); R(c, x, y - 1, 1, 3, '#9aa6ff'); }
  };
  const MAR_HILLS = (c) => {
    hillLine(c, -AO, AW - AO, 150, 46, 1.7, '#2c2846', '#6a7ad8', 1);
    for (let x = -AO; x < AW - AO; x += 3) for (let y = 110; y < 200; y += 4) { if (hash(x * 7 + y) > .5) R(c, x + ((y / 4) & 1), y, 2, 1, 'rgba(106,122,216,.18)'); }
    hillLine(c, -AO, AW - AO, 182, 30, 4.2, '#3a3458', '#7f8ff0', 1);
    const cx = 110, cy = 112; for (const [dx, w, h] of [[-22, 12, 34], [-8, 18, 44], [12, 12, 30]]) { const x = cx + dx; R(c, x, cy - h, w, h, '#3a3458'); R(c, x, cy - h, w, 1, '#8a9af8'); R(c, x, cy - h, 1, h, '#8a9af8'); R(c, x + w - 1, cy - h, 1, h, '#8a9af8'); for (let k = 0; k < w; k += 4) R(c, x + k, cy - h - 3, 2, 3, '#8a9af8'); R(c, x + w / 2 - 1, cy - h + 8, 2, 4, '#ffd88a'); } R(c, cx + 1, cy - 58, 1, 14, '#8a9af8'); for (let k = 0; k < 7; k++) R(c, cx + 2, cy - 58 + k, 7 - k, 1, '#e84a9a');
    for (let i = 0; i < 14; i++) { const x = -AO + 20 + i * 56 + hash(i) * 20, y = 160 + Math.round(hash(i + 3) * 14); R(c, x, y, 1, 12, '#7f8ff0'); for (let a = 0; a < 30; a++) { const an = a / 30 * 6.28; R(c, x + Math.cos(an) * 6, y - 4 + Math.sin(an) * 5, 1, 1, '#7f8ff0'); } }
  };
  const MAR_MID = (c) => {
    for (let i = 0; i < 7; i++) { const x = -120 + i * 120 + (i % 2) * 30, h = 70 + Math.round(hash(i + 41) * 40), col = i % 2 ? '#69617d' : '#5a546e'; for (let r2 = 0; r2 < h; r2++) { const edge = r2 > h - 6 ? ((r2 + i) % 2 ? 2 : 0) : 0; R(c, x + edge, r2, 40 - edge * 2, 1, col); } R(c, x, 0, 1, h, 'rgba(255,255,255,.16)'); for (let k = 0; k < 5; k++) R(c, x + 7, 16 + k * 12, 27, 1, '#a69bad'); R(c, x + 5, 8, 1, h - 16, '#b07a94'); for (const hy of [12, 34, 56]) ell(c, x + 3, hy, 1.5, 1.5, '#1c1830'); }
    R(c, 80, 150, 160, 9, '#c9a56a'); R(c, 80, 150, 160, 2, '#e8c890'); for (let k = 0; k < 160; k += 4) R(c, 80 + k, 151, 1, k % 20 ? 3 : 5, '#5a4028'); R(c, 84, 159, 4, 61, '#8a6a46'); R(c, 232, 159, 4, 61, '#8a6a46');
    R(c, 392, 108, 34, 112, '#a8b0c0'); R(c, 392, 108, 6, 112, '#d8e0ec'); R(c, 420, 108, 6, 112, '#6a7080'); R(c, 386, 102, 46, 8, '#8a90a0'); for (let y = 118; y < 210; y += 10) R(c, 396, y, 26, 2, '#7a8090'); ell(c, 409, 132, 7, 7, '#2a2a38'); ell(c, 409, 132, 4, 4, '#14141c');
    for (const [x, r] of [[-40, 14], [300, 10], [520, 16]]) { ell(c, x, 220 - r, r, r * .9, '#c8c0d0'); for (let k = 0; k < 12; k++) { const a = hash(k + x) * 6.28, rr = hash(k + x + 1) * r * .8; R(c, x + Math.cos(a) * rr, 220 - r + Math.sin(a) * rr * .9, 3, 1, '#8a8098'); } ell(c, x - r * .3, 220 - r * 1.3, r * .3, r * .2, '#e8e0f0'); }
  };
  const MAR_NEAR = (c) => {
    arenaGround(c, '#4b3b60', '#3c2e50', '#76547f', '#c19bc6', 26); for (let y = 226; y < 270; y += 5) R(c, -AO, y, AW, 1, 'rgba(154,109,148,.35)'); R(c, 60, 225, 1, 45, 'rgba(255,90,120,.4)'); R(c, 62, 225, 1, 45, 'rgba(255,90,120,.25)');
    R(c, -AO, 196, AW, 24, '#3a2e50'); R(c, -AO, 196, AW, 1, '#6a5a88'); for (let y = 200; y < 220; y += 5) R(c, -AO, y, AW, 1, 'rgba(154,109,148,.3)');
    for (const [x0, x1, col, sd] of [[151, 238, '#b1a2bb', 1], [241, 328, '#cfbfd0', -1]]) for (let x = x0; x < x1; x++) { const k = (x - x0) / (x1 - x0), top = sd > 0 ? 150 + Math.round(k * 7) : 157 - Math.round(k * 8), bot = sd > 0 ? 194 + Math.round(k * 9) : 203 - Math.round(k * 9); R(c, x, top, 1, bot - top, col); R(c, x, bot, 1, 2, 'rgba(0,0,0,.3)'); }
    for (const [x0, sd] of [[153, 1], [243, -1]]) for (let j = 0; j < 5; j++) for (let x = 0; x < 80; x += 2) { const k = x / 80, yy = (sd > 0 ? 160 + Math.round(k * 7) : 166 - Math.round(k * 8)) + j * 6; R(c, x0 + x, yy, 2, 1, sd > 0 ? '#7c6385' : '#997ea1'); }
    R(c, 238, 156, 3, 48, '#68546f'); for (const [x, col, dk] of [[10, '#e8c84a', '#a8861f'], [455, '#d83a6a', '#8a1f40']]) { R(c, x, 104, 11, 116, col); R(c, x, 104, 3, 116, 'rgba(255,255,255,.25)'); R(c, x + 8, 104, 3, 116, dk); for (let k = 0; k < 6; k++) R(c, x + k, 104 - k * 2 - 2, 11 - k * 2, 2, k > 3 ? '#2a2a30' : '#e8cfa0'); R(c, x, 200, 11, 4, '#b9c3bf'); R(c, x, 204, 11, 16, '#e8a0b0'); }
    R(c, 346, 196, 26, 24, '#2a2040'); R(c, 348, 198, 22, 20, '#3a2e58'); R(c, 350, 204, 18, 12, '#e84a9a'); R(c, 350, 204, 18, 2, '#ff9ad0'); R(c, 354, 188, 10, 9, '#2a2040'); R(c, 356, 190, 6, 5, '#e84a9a'); ell(c, 330, 219, 18, 2.5, '#e84a9a'); ell(c, 120, 219, 12, 2, '#4ad8e8');
    R(c, 270, 210, 20, 10, '#e8a0b0'); R(c, 270, 210, 20, 2, '#ffc8d8'); R(c, 270, 217, 20, 3, '#5a8ac8'); for (let k = 0; k < 8; k++) R(c, 262 + hash(k) * 40, 218, 2, 2, '#e8a0b0');
    board(c, 120, 60, 240, 22, '#d7c9d7', '#8a7a94'); for (const x of [126, 350]) { R(c, x, 56, 6, 8, 'rgba(240,230,170,.8)'); }
  };
  ARENA.marco = { layers: [[.1, 'marco-far', MAR_FAR], [.3, 'marco-hills', MAR_HILLS], [.6, 'marco-mid', MAR_MID], [1, 'marco-near', MAR_NEAR]],
    mid(c, s, t, ox) { for (let i = 0; i < 16; i++) { const x = ((hash(i + 3) * 520 + t * (3 + hash(i) * 4)) % 560) - 40, yy = 30 + hash(i + 18) * 140 + Math.sin(t + i) * 5; R(c, x, yy, 3, 4, '#d8c6dd'); R(c, x, yy, 3, 1, '#ffffff'); } const nx = ox; for (let i = 0; i < 6; i++) { const u = (t * .45 + i / 6) % 1; R(c, 358 + (i % 3) * 3 + nx, 205 + u * 14, 1, 3, '#e84a9a'); } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#3a2848'; c.fillText('RABISCOS À SOLTA', 480, 142); if (window.Art?.drawDoodle) for (let i = 0; i < 5; i++) { const dx = Math.sin(t * .55 + i * 1.7) * 26 + Math.sin(t * 1.3 + i) * 6, dy = Math.sin(t * 1.05 + i * 2.3) * 14, sc = 2.5 * (1 + Math.sin(t * 2.2 + i) * .06); c.save(); c.translate(Math.round(70 + i * 203 + dx), Math.round(170 + (i % 2) * 59 + dy)); c.rotate(Math.sin(t * .8 + i * 1.3) * .16); c.scale(sc, sc); try { window.Art.drawDoodle(c, 0, 0, i % 3, t * .35 + i, true); } catch (e) {} c.restore(); } c.restore(); },
    light(g, s, t) { const p = .75 + .25 * Math.sin(t * 2); bulbGlow(g, 367, 208, p, '255,70,160', 38); bulbGlow(g, 330, 219, p * .6, '255,70,160', 26); bulbGlow(g, 120, 219, p * .6, '70,220,255', 26); bulbGlow(g, 240, 172, .55 * p, '170,120,255', 74); pool(g, 240, 224, .8, '170,120,255', 100); } };

  // --- MENEZES: teatro no esgoto, com túnel ao fundo e plateia de ratos
  const MEN_TUNNEL = (c) => {
    R(c, -AO, 0, AW, LH, '#120e10');
    for (let i = 0; i < 7; i++) { const w = 560 - i * 70, h = 210 - i * 24, x = 240 - w / 2, y = 205 - h, col = css(mix([.36, .25, .22], [.07, .06, .06], i / 6)), mort = css(mix([.24, .17, .15], [.05, .04, .04], i / 6));
      for (let yy = 0; yy < h; yy++) { const r = Math.min(1, yy / (w * .5)), half = yy < w * .5 ? Math.round(Math.sqrt(Math.max(0, (w * .5) ** 2 - (w * .5 - yy) ** 2))) : w / 2; R(c, 240 - half, y + yy, half * 2, 1, col); }
      for (let yy = y; yy < 205; yy += 5) for (let xx = x + ((yy / 5) & 1) * 5; xx < x + w; xx += 10) R(c, xx, yy, 1, 5, mort); for (let xx = x; xx < x + w; xx += 2) R(c, xx, 205, 1, 1, mort); }
    for (let yy = 0; yy < 26; yy++) R(c, 240 - 24 + yy * .3, 168 + yy, 48 - yy * .6, 1, `rgba(120,220,140,${.35 - yy * .01})`);
    for (let r2 = 0; r2 < 14; r2++) { const k = r2 / 13, w = 26 + k * 260, y = 180 + r2 * 2.6; R(c, 240 - w / 2, y, w, 3, css(mix([.12, .32, .24], [.18, .42, .3], k))); }
  };
  const MEN_WALLS = (c) => {
    for (const [x0, w] of [[-AO, 210], [370, 260]]) { R(c, x0, 0, w, 205, '#4a2e28'); for (let y = 0; y < 205; y += 6) for (let x = x0 + ((y / 6) & 1) * 6; x < x0 + w; x += 12) { R(c, x, y, 11, 5, ['#5a3a30', '#6a4436', '#52342c'][(x * 3 + y) % 3]); R(c, x, y, 11, 1, 'rgba(255,255,255,.07)'); } R(c, x0 + (x0 < 0 ? w - 2 : 0), 0, 2, 205, '#1c1210'); }
    for (const [y, h, col] of [[44, 9, '#6a7a72'], [64, 6, '#8a5a3a']]) { R(c, -AO, y, 210, h, col); R(c, -AO, y, 210, 2, 'rgba(255,255,255,.25)'); R(c, -AO, y + h - 2, 210, 2, 'rgba(0,0,0,.3)'); R(c, 370, y + 6, 260, h, col); R(c, 370, y + 6, 260, 2, 'rgba(255,255,255,.25)'); for (let x = -AO + 20; x < 60; x += 50) R(c, x, y - 1, 4, h + 2, '#3a4440'); for (let x = 380; x < 630; x += 50) R(c, x, y + 5, 4, h + 2, '#3a4440'); }
    for (const x of [30, 420]) { R(c, x, 0, 10, 205, '#5a6a64'); R(c, x, 0, 3, 205, '#8a9a92'); R(c, x + 8, 0, 2, 205, '#3a4440'); for (let y = 20; y < 200; y += 40) R(c, x - 2, y, 14, 4, '#3a4440'); ell(c, x + 5, 120, 8, 8, '#a83a2a'); ell(c, x + 5, 120, 5, 5, '#5a4a40'); ell(c, x + 5, 120, 2, 2, '#a83a2a'); }
    for (const [x, y, col] of [[-60, 110, '#e8c84a'], [470, 130, '#3ad0c0'], [540, 90, '#e84a8a']]) { for (let k = 0; k < 26; k++) R(c, x + k, y + Math.round(Math.sin(k * .7) * 3), 2, 2, col); R(c, x + 2, y - 5, 2, 10, col); R(c, x + 12, y - 6, 2, 11, col); R(c, x + 21, y - 4, 2, 9, col); }
  };
  const MEN_STAGE = (c) => {
    for (const sd of [0, 1]) { const x0 = sd ? 400 : -150, w = 230; for (let k = 0; k < w; k += 9) { const col = ['#7b4252', '#8a4a4a', '#6a3a48', '#9a5a50'][(k / 9 | 0) % 4]; R(c, x0 + k, 20, 9, 186, col); R(c, x0 + k, 20, 2, 186, 'rgba(255,255,255,.12)'); R(c, x0 + k + 7, 20, 2, 186, 'rgba(0,0,0,.25)'); if ((k / 9 | 0) % 3 === 1) { R(c, x0 + k + 2, 80 + (k % 50), 5, 6, '#c8a878'); R(c, x0 + k + 3, 81 + (k % 50), 1, 4, '#5a4030'); } } R(c, x0, 20, w, 3, '#3a2a20'); for (let k = 0; k < w; k += 4) R(c, x0 + k, 204, 2, 3, '#c39865'); }
    for (let x = 80, i = 0; x < 400; x += 4, i++) R(c, x, 20 + Math.round(Math.sin(i * .2) * 2), 4, 1, '#2a2220');
    for (let y = 32; y < 98; y++) { const sag = Math.round(Math.sin((y - 32) / 66 * Math.PI) * 2); R(c, 122 + sag, y, 236 - sag * 2, 1, y % 9 === 0 ? '#cfc6b4' : '#e2dccd'); } for (let k = 0; k < 7; k++) R(c, 128 + k * 34, 32, 1, 66, 'rgba(120,100,80,.18)'); for (let k = 0; k < 236; k += 3) R(c, 122 + k, 97 + (k % 2), 2, 2, '#e2dccd'); R(c, 122, 30, 236, 3, '#5a4a40'); for (const x of [126, 354]) R(c, x, 20, 2, 10, '#2a2220');
    for (const x of [53, 389]) { R(c, x - 1, 142, 43, 64, '#101614'); R(c, x, 143, 41, 62, '#263b37'); R(c, x, 143, 41, 2, '#47605a'); for (const cy of [160, 188]) { ell(c, x + 20, cy, 12, 12, '#141c19'); ell(c, x + 20, cy, 8, 8, '#8b9978'); ell(c, x + 20, cy, 3, 3, '#3f5749'); } }
    R(c, -AO, 205, AW, 15, '#68594e'); R(c, -AO, 205, AW, 2, '#dbbd86'); for (let x = -AO; x < AW - AO; x += 27) R(c, x, 207, 1, 13, '#9d8262'); for (let x = -AO + 6; x < AW - AO; x += 14) { R(c, x, 212, 4, 4, '#ffe1a0'); R(c, x + 1, 213, 2, 2, '#fff3cf'); }
    R(c, -AO, FLOOR, AW, 50, '#1c1416'); R(c, -AO, FLOOR, AW, 2, '#dbbd86');
  };
  ARENA.menezes = { layers: [[.15, 'men-tunnel', MEN_TUNNEL], [.45, 'men-walls', MEN_WALLS], [1, 'men-stage', MEN_STAGE]],
    mid(c, s, t, ox) { const tx = Math.round(ox * .15); for (let i = 0; i < 18; i++) { const k = (i % 9) / 8, w = 30 + k * 220, y = 182 + (i % 9) * 2.4, x = 240 - w / 2 + ((t * (8 + i) + i * 40) % w) + tx; R(c, x, y, 4 + k * 6, 1, 'rgba(150,255,190,.45)'); } const wx = Math.round(ox * .45); for (let i = 0; i < 8; i++) { const x = (i < 4 ? -120 + i * 50 : 390 + (i - 4) * 55) + wx, u = (t * .6 + hash(i)) % 1; R(c, x, 60 + u * 140, 1, 3, 'rgba(160,220,200,.7)'); } for (let x = -AO + 10; x < AW - AO; x += 40) { const sx = x + wx, y = 30 + Math.round(Math.sin(x * .1) * 3); if (sx < -10 || sx > LW + 10) continue; R(c, sx, 0, 1, y, '#2a2220'); R(c, sx - 2, y, 5, 5, '#ffd88a'); } },
    near(c, s, t, ox) { for (const x of [53, 389]) for (const cy of [160, 188]) { const p = Math.max(0, Math.sin(t * 9 + x + cy)); ell(c, x + 20 + ox, cy, 8 + p, 8 + p, '#8b9978'); ell(c, x + 20 + ox, cy, 3 + p * .8, 3 + p * .8, '#3f5749'); } for (let r2 = 0; r2 < 3; r2++) for (let k = 0; k < 40; k++) { const x = -AO + 6 + k * 20 + (r2 % 2) * 10 + ox, y = 236 + r2 * 11; if (x < -10 || x > LW + 10) continue; const bob = Math.round(Math.max(0, Math.sin(t * 5 + k + r2 * 2)) * 2); ell(c, x, y - bob, 6, 4, '#2a2228'); ell(c, x - 4, y - 4 - bob, 2.5, 2.5, '#3a2e34'); ell(c, x + 4, y - 4 - bob, 2.5, 2.5, '#3a2e34'); if (Math.sin(t * .7 + k * 3 + r2) > -.85) { R(c, x - 2, y - 1 - bob, 1, 1, '#ff5a6a'); R(c, x + 2, y - 1 - bob, 1, 1, '#ff5a6a'); } } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#a8322f'; c.fillText('PALCO DA PROVOCAÇÃO', 480, 88); c.font = '8px Pixel, monospace'; c.fillStyle = '#3a3a48'; c.fillText('da roça poudiaaam', 420, 116); c.fillText('reeeis pouddiaaam', 545, 134); c.fillText('da roça pegou ar', 410, 152); c.fillText('teketeketeketeke', 550, 170); c.fillText('o pra ravid falando sozinho', 470, 186); c.restore(); },
    light(g, s, t) { bulbGlow(g, 240, 178, .5, '120,240,160', 80); for (const [x, col] of [[180, '255,120,150'], [240, '255,240,200'], [300, '120,180,255']]) { const sw = Math.sin(t * .7 + x) * 40, cx = 240 + sw + (x - 240) * .4, gr = g.createLinearGradient(0, 22, 0, 222); gr.addColorStop(0, `rgba(${col},.3)`); gr.addColorStop(1, `rgba(${col},.04)`); g.fillStyle = gr; g.beginPath(); g.moveTo(x - 3, 22); g.lineTo(x + 3, 22); g.lineTo(cx + 30, 222); g.lineTo(cx - 30, 222); g.closePath(); g.fill(); pool(g, cx, 222, .9, col, 42); bulbGlow(g, x, 22, .8, col, 20); } for (let x = -AO + 8; x < AW - AO; x += 28) bulbGlow(g, x, 214, .4, '255,210,130', 12); } };

  // --- NIKOLAS: reino de doces sob a tempestade
  const NIK_FAR = (c) => {
    for (let i = 0; i < 16; i++) R(c, -AO, i * 8, AW, 8, css(mix([.16, .22, .17], [.46, .5, .38], Math.pow(i / 15, 1.2))));
    for (const [x, h, col] of [[-100, 60, '#c8a0b8'], [20, 80, '#d8b0c4'], [380, 70, '#c8a0b8'], [520, 90, '#d8b0c4']]) { for (let k = -46; k <= 46; k++) { const hh = Math.round(h * (1 - Math.abs(k) / 46)); R(c, x + k, 128 - hh, 1, hh, col); if (hh > h * .62) R(c, x + k, 128 - hh, 1, Math.min(6, hh - h * .6), '#fff6ea'); } }
    const cx = 240; for (const [w, h, y, col] of [[120, 22, 128, '#c08a68'], [90, 20, 106, '#e8a8b8'], [60, 18, 86, '#c08a68'], [34, 14, 68, '#f6ecd0']]) { R(c, cx - w / 2, y - h, w, h, col); R(c, cx - w / 2, y - h, w, 3, '#fff6ea'); for (let k = 0; k < w; k += 5) R(c, cx - w / 2 + k, y - h + 3, 3, 2 + (k % 3), '#fff6ea'); for (let k = 8; k < w - 6; k += 14) { R(c, cx - w / 2 + k, y - h + 8, 4, 6, '#3a2418'); R(c, cx - w / 2 + k + 1, y - h + 9, 2, 4, '#ffd88a'); } }
    for (const [x, h] of [[175, 52], [305, 52], [205, 70], [275, 70]]) { R(c, x - 5, 128 - h, 10, h, '#d8b0c4'); R(c, x - 5, 128 - h, 10, 2, '#fff6ea'); for (let k = 0; k < 6; k++) R(c, x - 6 + k, 128 - h - k, 12 - k * 2, 1, '#8a4a6a'); ell(c, x, 128 - h - 8, 2.5, 2.5, '#e04a3a'); } ell(c, cx, 50, 4, 4, '#e04a3a'); R(c, cx, 42, 1, 5, '#4a7a3a');
  };
  const NIK_MID = (c) => {
    R(c, -AO, 118, AW, 12, '#5a3420'); for (let x = -AO; x < AW - AO; x += 6) R(c, x, 118, 3, 1, '#8a5a3a');
    for (let i = 0; i < 12; i++) { const x = -120 + i * 68 + (i % 2) * 14, y = 122; R(c, x, y - 26, 2, 26, '#f6ecd0'); for (let a = 0; a < 70; a++) { const an = a / 70 * 6.28 * 2.2, rr = 2 + a * .13; R(c, x + 1 + Math.cos(an) * rr, y - 34 + Math.sin(an) * rr, 2, 2, ['#e84a8a', '#f6ecd0', '#4ab8e8', '#f2d24a'][i % 4]); } }
    for (let x = -AO; x < AW - AO; x += 10) { R(c, x, 120, 2, 10, '#f6ecd0'); R(c, x, 120 + ((x / 10) & 1) * 4, 2, 3, '#e04a3a'); }
    for (let i = 0; i < 16; i++) { const x = -AO + 10 + i * 50, col = ['#e84a8a', '#6ad86a', '#f2d24a', '#8a5ae8'][i % 4]; ell(c, x, 128, 6, 5, col); ell(c, x - 2, 126, 2, 1.5, 'rgba(255,255,255,.6)'); }
  };
  const NIK_NEAR = (c) => {
    R(c, -AO, 130, AW, 90, '#9e7256'); R(c, -AO, 130, AW, 3, '#d1a273'); for (let i = 0; i < 360; i++) R(c, -AO + hash(i + 3) * AW, 134 + hash(i + 4) * 84, 1 + hash(i) * 2, 1, ['#8a5e44', '#b88660', '#6a4632'][i % 3]); for (let i = 0; i < 50; i++) R(c, -AO + hash(i + 71) * AW, 136 + hash(i + 72) * 80, 2, 1, ['#e84a8a', '#f2d24a', '#4ab8e8', '#6ad86a'][i % 4]);
    R(c, 105, 73, 270, 23, '#6f4937'); R(c, 100, 70, 280, 8, '#e4bf83'); R(c, 100, 70, 280, 1, '#f6dca8'); for (let i = 0; i < 12; i++) { R(c, 107 + i * 23, 79, 7, 8 + (i % 3) * 3, '#d8b17a'); R(c, 107 + i * 23, 79, 2, 8 + (i % 3) * 3, '#f0d3a0'); } for (let x = 100; x < 380; x += 7) R(c, x, 96, 4, 2, '#4a2e22');
    for (const x of [113, 359]) { R(c, x, 96, 8, 118, '#644634'); R(c, x, 96, 2, 118, '#aa8055'); R(c, x + 6, 96, 2, 118, '#3f2a1e'); for (let k = 100; k < 210; k += 12) R(c, x + 1, k, 6, 2, '#7a5a40'); R(c, x - 2, 208, 12, 6, '#4a2e22'); }
    R(c, 187, 131, 107, 76, '#624937'); R(c, 192, 136, 96, 66, '#85a45d'); R(c, 196, 140, 88, 62, '#a8bd69'); R(c, 196, 140, 88, 2, '#c4d68a'); for (const yy of [150, 164, 178]) { R(c, 205, yy, 72, 3, '#72994f'); R(c, 205, yy, 72, 1, '#8fb468'); }
    const crown = [[187, 133], [190, 117], [203, 129], [217, 111], [230, 127], [243, 106], [256, 127], [272, 114], [282, 129], [294, 118], [294, 136]];
    for (let x = 187; x <= 294; x++) { let top = 133; for (let k = 0; k < crown.length - 1; k++) { const a = crown[k], b = crown[k + 1]; if (x >= a[0] && x <= b[0]) top = a[1] + (b[1] - a[1]) * (x - a[0]) / (b[0] - a[0]); } R(c, x, top, 1, 136 - top, '#6b8d43'); R(c, x, top, 1, 1, '#9fc064'); }
    for (const x of [178, 285]) { R(c, x, 182, 18, 34, '#74643e'); R(c, x, 180, 17, 6, '#b6c26b'); }
    for (const x of [64, 403]) { R(c, x - 24, 186, 48, 29, '#704934'); R(c, x - 22, 191, 44, 8, '#d0a66b'); R(c, x - 24, 184, 49, 6, '#e5c58e'); cakeHD(c, x, 184); }
    board(c, 165, 84, 150, 12, '#6f4937', '#3f2a1e');
    const L = [[220, 6, '#6a3a22'], [226, 4, '#f6ecd0'], [230, 8, '#e8c070'], [238, 3, '#f0a0b8'], [241, 9, '#e8c070'], [250, 3, '#f6ecd0'], [253, 17, '#5a3020']]; for (const [y, h, col] of L) R(c, -AO, y, AW, h, col); for (let i = 0; i < 300; i++) R(c, -AO + hash(i + 91) * AW, 231 + hash(i + 92) * 18, 1, 1, i % 2 ? '#d8a050' : '#f8d890'); for (let i = 0; i < 70; i++) R(c, -AO + hash(i + 51) * AW, 255 + hash(i + 52) * 12, 2, 1, ['#e84a8a', '#f2d24a', '#4ab8e8', '#6ad86a'][i % 4]); for (let x = -AO; x < AW - AO; x += 9) R(c, x, 226 + 4, 4, 2 + ((x / 9) & 1) * 2, '#f6ecd0');
  };
  ARENA.nikolas = { layers: [[.12, 'nik-far', NIK_FAR], [.35, 'nik-mid', NIK_MID], [1, 'nik-near', NIK_NEAR]],
    back(c, s, t, ox) { },
    mid(c, s, t, ox) { for (let i = 0; i < 7; i++) { const x = ((hash(i + 9) * 700 + t * (4 + i * 1.5)) % 760) - 140, y = 8 + hash(i + 12) * 40, w = 50 + hash(i + 14) * 50; R(c, x, y, w, 7, 'rgba(30,44,30,.75)'); R(c, x + 8, y - 4, w - 20, 4, 'rgba(30,44,30,.75)'); R(c, x + 4, y + 7, w - 10, 2, 'rgba(20,30,20,.6)'); } const rx = Math.round(ox * .35); for (let i = 0; i < 20; i++) { const x = ((i * 41 + t * 12) % AW) - AO + rx; R(c, x, 120 + (i % 3) * 3, 6, 1, '#8a5a3a'); } },
    near(c, s, t, ox) { for (let i = 0; i < 9; i++) { const x = 108 + i * 31 + ox, u = (t * .35 + hash(i + 5)) % 1; R(c, x, 98 + u * 40, 2, 3 + u * 4, '#a8bd69'); ell(c, x + 1, 98 + u * 40 + 5 + u * 4, 2, 1.5, '#a8bd69'); } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#2a1a10'; c.fillText('O TRONO DO BOLO ROUBADO', 482, 182); c.fillStyle = '#f7e4bc'; c.fillText('O TRONO DO BOLO ROUBADO', 480, 180); c.restore(); },
    light(g, s, t) { const sh = .5 + .5 * Math.sin(t * 1.5); bulbGlow(g, 240, 160, .35 + sh * .15, '170,230,110', 62); for (const [x, y] of [[240, 82], [222, 102], [258, 102]]) bulbGlow(g, x, y, .5, '255,214,140', 14); } };

  // --- peças comuns das arenas da favela
  function favRow(c, y0, step, hmin, hmax, haze, litP, seed, night) { const base = night ? [.1, .12, .18] : [.62, .55, .62];
    for (let x = -AO, i = 0; x < AW - AO; x += step, i++) { const w = step - 2 - Math.round(hash(i + seed) * 6), h = hmin + Math.round(hash(i + seed + 7) * (hmax - hmin)), y = y0 - h, body = css(mix(hexv(FV_COL[(i + seed) % 8]), base, haze));
      R(c, x, y, w, h + 60, body); R(c, x - 1, y - 2, w + 2, 2, css(mix([.45, .42, .4], base, haze))); R(c, x, y, 1, h, 'rgba(255,255,255,.1)'); R(c, x + w - 2, y, 2, h, 'rgba(0,0,0,.18)');
      for (let wy = y + 5; wy < y0 - 4; wy += 9) for (let wx = x + 3; wx < x + w - 5; wx += 8) { const on = hash(i * 31 + wx * 3 + wy + seed) < litP; R(c, wx, wy, 4, 5, on ? (hash(wx + wy) > .5 ? '#ffd27a' : '#ffe9b8') : css(mix([.16, .2, .26], base, haze * .6))); }
      if (hash(i + seed + 3) > .6) { R(c, x + 3, y - 6, 9, 5, css(mix([.17, .37, .58], base, haze))); } if (hash(i + seed + 5) > .7) R(c, x + w - 5, y - 9, 1, 8, css(mix([.3, .3, .3], base, haze))); } }
  function hillLights(c, base, amp, seed, fill, dots) { hillLine(c, -AO, AW - AO, base, amp, seed, fill); for (let i = 0; i < dots; i++) { const x = -AO + hash(i + seed * 13) * AW, top = Math.round(base - amp * (.55 + .45 * Math.sin(x * .021 + seed)) * (.6 + .4 * Math.sin(x * .053 + seed * 2)) - Math.sin(x * .17 + seed) * 2), y = top + 3 + hash(i + seed * 7) * (base + 30 - top); R(c, x, y, 1, 1, hash(i) > .3 ? '#ffd27a' : '#bfe0ff'); } }
  function speakerTower(c, x) { R(c, x, 70, 5, 104, '#344a59'); R(c, x, 70, 1, 104, '#5a7080'); R(c, x - 11, 64, 27, 8, '#263b4b'); for (let j = 0; j < 4; j++) R(c, x - 9 + j * 6, 66, 4, 4, '#f7d997'); R(c, x - 14, 135, 33, 40, '#1c2a33'); R(c, x - 12, 137, 29, 36, '#3a4a52'); for (const cy of [147, 163]) { ell(c, x + 2, cy, 9, 9, '#141e24'); ell(c, x + 2, cy, 6, 6, '#8a9a92'); ell(c, x + 2, cy, 2, 2, '#2a3a40'); } }

  // --- DEDÉ: laje no meio da fumaça, de noite
  ARENA.dede = { layers: [[.12, 'dede-far', (c) => { for (let i = 0; i < 14; i++) R(c, -AO, i * 12, AW, 12, css(mix([.07, .09, .15], [.2, .24, .3], i / 13))); hillLights(c, 160, 70, 2.2, '#1a222c', 900); }],
      [.4, 'dede-mid', (c) => favRow(c, 178, 34, 30, 70, .55, .45, 9, true)],
      [1, 'dede-near', (c) => { R(c, -AO, 174, AW, 46, '#5b6a6a'); R(c, -AO, 174, AW, 2, '#a6bcb0'); for (let x = -AO; x < AW - AO; x += 22) R(c, x, 176, 1, 44, '#4a5858'); for (let i = 0; i < 300; i++) R(c, -AO + hash(i + 401) * AW, 178 + hash(i + 402) * 40, 2, 1, i % 2 ? '#52605f' : '#6a7a78');
        for (let x = -AO; x < AW - AO; x += 18) { R(c, x, 156, 2, 18, '#7a8a86'); } R(c, -AO, 156, AW, 2, '#8a9a96'); R(c, -AO, 165, AW, 1, '#6a7a76');
        for (const x of [48, 392]) { R(c, x, 62, 37, 112, '#4a3a36'); for (let y = 62; y < 174; y += 5) for (let k = ((y / 5) & 1) * 5; k < 37; k += 10) R(c, x + k, y, 9, 4, ['#5a463e', '#6a5246', '#52403a'][(k + y) % 3]); R(c, x - 5, 54, 47, 9, '#2a2a2e'); R(c, x - 5, 54, 47, 2, '#5a5a62'); R(c, x + 6, 44, 25, 11, '#3a3a40'); }
        for (const x of [150, 300]) { R(c, x, 138, 22, 18, '#2c5f94'); R(c, x, 138, 22, 3, '#5a94c8'); R(c, x + 2, 135, 18, 3, '#3a7ab8'); R(c, x + 4, 156, 2, 4, '#3a3a40'); R(c, x + 16, 156, 2, 4, '#3a3a40'); }
        R(c, 128, 88, 224, 22, '#14181e'); R(c, 129, 89, 222, 20, '#1e2630'); R(c, 129, 89, 222, 1, '#e84a9a'); R(c, 129, 108, 222, 1, '#e84a9a'); R(c, 129, 89, 1, 20, '#e84a9a'); R(c, 350, 89, 1, 20, '#e84a9a'); R(c, 160, 110, 2, 46, '#3a3a40'); R(c, 318, 110, 2, 46, '#3a3a40');
        for (let k = 0; k < 60; k++) R(c, 182 + k * 2, 132 + Math.round(Math.sin(k * .2) * 4), 2, 1, '#3a3a3a'); for (let j = 0; j < 5; j++) { const x = 190 + j * 22; R(c, x, 134 + Math.round(Math.sin((x - 182) / 2 * .2) * 4), 12, 14, ['#e0c17c', '#6697ac', '#dc8666', '#d8d0a7', '#9a5ac8'][j]); } }]],
    mid(c, s, t, ox) { for (let i = 0; i < 9; i++) { const x = ((i * 130 + t * (6 + i * 1.3)) % 900) - 210, y = 120 + (i % 4) * 22 + Math.sin(t * .5 + i) * 6; c.fillStyle = `rgba(200,214,206,${.13 + (i % 3) * .04})`; ell(c, x, y, 54 + (i % 3) * 14, 10 + (i % 2) * 5, c.fillStyle); ell(c, x + 30, y - 8, 30, 9, c.fillStyle); } },
    near(c, s, t, ox) { for (const x of [48, 392]) for (let i = 0; i < 8; i++) { const u = (t * .28 + i / 8) % 1, px = x + ox + 18 + Math.sin(t + i * 1.7) * 6 * u + u * 18, py = 42 - u * 52, r = 4 + u * 13; ell(c, px, py, r, r * .8, `rgba(210,220,214,${(1 - u) * .55})`); } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#ff7ac0'; c.fillText('DEDÊ · ENTRE AS NUVENS', 480, 198); c.restore(); },
    light(g, s, t) { const f = .85 + .15 * Math.sin(t * 17) * Math.sin(t * 5); bulbGlow(g, 240, 99, .8 * f, '255,90,170', 70); for (const x of [66, 410]) bulbGlow(g, x, 40, .3, '255,180,120', 30); } };

  // --- NICOLAS: o céu imaginado, com a roda solar
  ARENA.nicolas = { layers: [[.08, 'nic-sky', (c) => { for (let i = 0; i < 16; i++) R(c, -AO, i * 12, AW, 12, css(mix([.05, .12, .24], [.2, .45, .5], Math.pow(i / 15, 1.3)))); for (const [x, y, r, col] of [[60, 60, 70, 'rgba(120,80,200,.16)'], [420, 40, 80, 'rgba(60,200,200,.12)'], [260, 120, 90, 'rgba(240,200,120,.08)']]) for (let k = 0; k < 6; k++) ell(c, x, y, r * (1 - k * .14), r * .5 * (1 - k * .14), col);
        const pts = []; for (let i = 0; i < 90; i++) { const x = -AO + hash(i + 501) * AW, y = 4 + hash(i + 502) * 150; pts.push([x, y]); R(c, x, y, 1, 1, i % 4 ? '#e0f8d9' : '#f7e6aa'); if (i % 9 === 0) { R(c, x - 2, y, 5, 1, '#a2dfd7'); R(c, x, y - 2, 1, 5, '#a2dfd7'); } } for (let i = 0; i < 40; i += 4) { const a = pts[i], b = pts[i + 1]; if (Math.hypot(a[0] - b[0], a[1] - b[1]) < 120) limb(c, [a, b], 1, 'rgba(160,220,215,.35)'); } }],
      [.35, 'nic-isles', (c) => { for (const [x, y, w] of [[-90, 110, 60], [40, 70, 44], [330, 64, 50], [470, 104, 66], [200, 130, 30]]) { for (let r2 = 0; r2 < w * .5; r2++) { const k = r2 / (w * .5), ww = w * (1 - k * k); R(c, x - ww / 2, y + r2, ww, 1, css(mix([.35, .42, .46], [.2, .26, .32], k))); } R(c, x - w / 2, y - 3, w, 4, '#6aa878'); R(c, x - w / 2, y - 3, w, 1, '#a8e0a0'); for (let k = 0; k < w; k += 6) R(c, x - w / 2 + k, y - 6 - (k % 3), 2, 3 + (k % 3), '#5a9a6a'); R(c, x - 3, y - 18, 6, 15, '#e8e0c8'); R(c, x - 5, y - 20, 10, 3, '#e4ce8e'); } }],
      [1, 'nic-near', (c) => { for (let i = 0; i < 9; i++) { const x = -AO + i * 92; ell(c, x + 40, 196, 60, 14, '#c8e0dc'); ell(c, x + 20, 190, 34, 10, '#e8f4f0'); } c.save(); c.translate(-AO, 0); tileFloor(c, AW, FLOOR, ['#e8eee6', '#9ac8c4', '#f4f8f2', '#b4dad4'], 16); c.restore(); for (let x = -AO; x < AW - AO; x += 32) R(c, x, FLOOR + 1, 1, 50, 'rgba(228,206,142,.5)');
        for (const x of [-36, 54, 373, 460]) { R(c, x - 3, 70, 30, 150, '#294c60'); R(c, x, 74, 24, 140, '#e8e8dc'); for (let k = 0; k < 24; k += 4) R(c, x + k, 74, 1, 140, 'rgba(120,140,140,.25)'); R(c, x, 74, 3, 140, '#ffffff'); R(c, x + 20, 74, 4, 140, '#b8c4bc'); R(c, x - 5, 66, 34, 9, '#e4ce8e'); R(c, x - 5, 66, 34, 2, '#fff2c0'); R(c, x - 7, 60, 38, 7, '#a38b59'); R(c, x - 5, 210, 34, 10, '#d6c28c'); for (let j = 0; j < 4; j++) { const yy = 92 + j * 30; R(c, x + 10, yy, 4, 1, '#3ad0c0'); R(c, x + 11, yy - 3, 1, 7, '#3ad0c0'); R(c, x + 8, yy + 4, 8, 1, '#3ad0c0'); } } }]],
    mid(c, s, t, ox) { const cx = 240 + Math.round(ox * .35), cy = 92, h = 47 + Math.sin(t * .9) * 1.5;
      for (let arm = 0; arm < 6; arm++) for (let r = 26; r < 190; r += 2) { const a = arm / 6 * Math.PI * 2 + r * .028 - t * .7, f = 1 - r / 190; c.fillStyle = arm % 2 ? `rgba(255,222,120,${.55 * f})` : `rgba(120,240,230,${.45 * f})`; c.fillRect(Math.round(cx + Math.cos(a) * r), Math.round(cy + Math.sin(a) * r * .72), r > 120 ? 1 : 2, r > 120 ? 1 : 2); }
      for (let k = 0; k < 4; k++) { const r = ((t * 46 + k * 52) % 208) + 40, al = Math.max(0, 1 - r / 248); for (let a = 0; a < 140; a++) { const an = a / 140 * Math.PI * 2; if (a % 3 === 0) continue; c.fillStyle = `rgba(255,236,170,${.6 * al})`; c.fillRect(Math.round(cx + Math.cos(an) * r), Math.round(cy + Math.sin(an) * r * .72), 2, 1); } } ell(c, cx, cy, h + 8, h + 8, 'rgba(115,155,140,.5)'); ell(c, cx, cy, h, h, '#d5c58a'); ell(c, cx, cy, h - 4, h - 4, '#346d7a'); ell(c, cx, cy, 27, 27, '#c4dcc0'); ell(c, cx, cy, 22, 22, '#f7e8af'); ell(c, cx - 5, cy - 6, 8, 6, '#fffbe0'); for (let i = 0; i < 12; i++) { const a = i * Math.PI / 6 + t * .07, x = cx + Math.cos(a) * (h + 2), y = cy + Math.sin(a) * (h + 2); for (let k = 0; k < 4; k++) R(c, x - k, y - 4 + k, k * 2 + 1, 1, '#ffecb1'); for (let k = 0; k < 4; k++) R(c, x - (3 - k), y + k, (3 - k) * 2 + 1, 1, '#ffecb1'); } for (const [x, y] of [[40, 70], [330, 64], [470, 104]]) { const fx = x + Math.round(ox * .35); for (let k = 0; k < 6; k++) { const u = (t * .5 + k / 6) % 1; R(c, fx + 4, y + 20 + u * 60, 2, 4, `rgba(200,250,255,${.7 * (1 - u)})`); } } },
    near(c, s, t, ox) { const fx = ox;
      for (let a = 0; a < 220; a++) { const an = a / 220 * Math.PI * 2 + t * .4, on = (a % 11) < 7; if (!on) continue; R(c, 240 + fx + Math.cos(an) * 150, 238 + Math.sin(an) * 18, 2, 1, a % 2 ? 'rgba(255,226,130,.75)' : 'rgba(120,240,230,.7)'); }
      for (let a = 0; a < 12; a++) { const an = a / 12 * Math.PI * 2 - t * .6, x = 240 + fx + Math.cos(an) * 118, y = 238 + Math.sin(an) * 14; R(c, x - 2, y, 5, 1, '#ffe6a0'); R(c, x, y - 2, 1, 5, '#ffe6a0'); }
      for (let x = -AO; x < AW - AO; x += 3) { const sx = x + fx; if (sx < -6 || sx > LW + 6) continue; const h = 6 + Math.max(0, Math.sin(x * .09 + t * 3.2) * 9 + Math.sin(x * .23 - t * 5.1) * 5 + Math.sin(x * .031 + t) * 6); for (let k = 0; k < h; k++) { const u = k / h; R(c, sx + Math.round(Math.sin(t * 6 + x + k * .4) * u * 1.5), FLOOR - k, 2, 1, u < .3 ? '#fff6d0' : u < .6 ? '#ffd25a' : u < .85 ? '#5ae8d8' : 'rgba(90,232,216,.4)'); } }
      for (let i = 0; i < 70; i++) { const u = (t * (.18 + hash(i) * .2) + hash(i + 40)) % 1, x = -AO + hash(i + 900) * AW + fx + Math.sin(t * 2 + i) * 4, y = FLOOR - u * 200; if (x < -2 || x > LW + 2) continue; R(c, x, y, i % 4 ? 1 : 2, i % 4 ? 2 : 2, i % 3 ? `rgba(255,232,150,${1 - u})` : `rgba(140,250,240,${1 - u})`); }
      for (const x of [-36, 54, 373, 460]) { const sx = x + fx + 12, p = .5 + .5 * Math.sin(t * 2.4 + x); for (let j = 0; j < 4; j++) { const yy = 92 + j * 30; c.fillStyle = `rgba(120,255,240,${.4 + .6 * p})`; c.fillRect(sx - 2, yy, 4, 1); c.fillRect(sx - 1, yy - 3, 1, 7); c.fillRect(sx - 4, yy + 4, 8, 1); } } },
    text(c, t, ox) { },
    light(g, s, t) { const pulse = .5 + .5 * Math.sin(t * 2.2); bulbGlow(g, 240, 92, .65 + pulse * .2, '255,236,170', 120); bulbGlow(g, 240, 80, .28, '120,240,230', 150);
      for (const x of [-24, 66, 385, 472]) { const gr = g.createLinearGradient(0, 220, 0, 0); gr.addColorStop(0, `rgba(255,226,140,${.14 + pulse * .08})`); gr.addColorStop(1, 'rgba(120,240,230,0)'); g.fillStyle = gr; g.fillRect(x - 10, 0, 20, 220); }
      const fl = g.createLinearGradient(0, 160, 0, 225); fl.addColorStop(0, 'rgba(255,214,90,0)'); fl.addColorStop(1, `rgba(255,214,90,${.12 + pulse * .08})`); g.fillStyle = fl; g.fillRect(-AO, 160, AW, 65); pool(g, 240, 238, .45, '255,230,140', 170);
      for (const sd of [-1, 1]) { const gx = sd < 0 ? 0 : LW, eg = g.createLinearGradient(gx, 0, gx - sd * 70, 0); eg.addColorStop(0, `rgba(255,214,110,${.22 + pulse * .1})`); eg.addColorStop(1, 'rgba(255,214,110,0)'); g.fillStyle = eg; g.fillRect(sd < 0 ? 0 : LW - 70, 0, 70, LH); } for (let i = 0; i < 10; i++) { const a = i / 10 * Math.PI * 2 + t * .12, gr = g.createLinearGradient(240, 92, 240 + Math.cos(a) * 260, 92 + Math.sin(a) * 260); gr.addColorStop(0, 'rgba(255,240,170,.16)'); gr.addColorStop(1, 'rgba(255,240,170,0)'); g.fillStyle = gr; g.beginPath(); g.moveTo(240, 92); g.lineTo(240 + Math.cos(a - .05) * 260, 92 + Math.sin(a - .05) * 260); g.lineTo(240 + Math.cos(a + .05) * 260, 92 + Math.sin(a + .05) * 260); g.closePath(); g.fill(); } } };

  // --- FREDDY: ringue na laje, com o pôr do sol na favela
  ARENA.freddy = { layers: [[.1, 'fre-sky', (c) => { for (let i = 0; i < 18; i++) R(c, -AO, i * 8, AW, 8, css(mix(mix([.43, .42, .57], [.76, .56, .57], Math.min(1, i / 9)), [.89, .7, .54], Math.max(0, (i - 9) / 8)))); for (let k = 0; k < 6; k++) ell(c, 364, 92, 40 - k * 4, 40 - k * 4, `rgba(255,214,160,${.08 + k * .03})`); ell(c, 364, 92, 21, 21, '#f5d3a0'); for (const y of [88, 95, 101]) R(c, 340, y, 48, 1, 'rgba(195,143,145,.6)'); for (let i = 0; i < 6; i++) { const x = -100 + i * 140, y = 30 + (i % 3) * 16; R(c, x, y, 60, 4, 'rgba(255,220,200,.55)'); R(c, x + 10, y - 3, 34, 3, 'rgba(255,220,200,.55)'); } hillLights(c, 150, 60, 3.4, '#6a5a78', 0); }],
      [.4, 'fre-fav', (c) => favRow(c, 176, 30, 26, 66, .3, .25, 30, false)],
      [1, 'fre-ring', (c) => { R(c, -AO, 174, AW, 46, '#5a555d'); R(c, -AO, 174, AW, 3, '#c2987c'); for (let x = -AO; x < AW - AO; x += 22) R(c, x, 177, 1, 43, '#8d7370'); arenaGround(c, '#77645e', '#685650', '#4d4e56', '#d7b38a', 25.5);
        R(c, 30, 205, 420, 15, '#2a3a6a'); R(c, 30, 205, 420, 2, '#4a6aa8'); for (let x = 30; x < 450; x += 14) R(c, x, 208, 7, 8, x % 28 ? '#24325a' : '#30427a');
        for (const x of [30, 446]) { R(c, x, 128, 5, 92, '#c8c8d0'); R(c, x, 128, 2, 92, '#ffffff'); R(c, x - 2, 126, 9, 4, '#a83a2a'); } for (const [y, col] of [[140, '#e04a3a'], [156, '#f3f3f0'], [172, '#3a6ad8']]) { R(c, 35, y, 411, 2, col); R(c, 35, y + 2, 411, 1, 'rgba(0,0,0,.3)'); }
        speakerTower(c, 0); speakerTower(c, 474); board(c, 122, 75, 236, 23, '#77556b', '#3b4555'); board(c, 176, 154, 128, 9, '#263d49', '#14222a'); for (const x of [-60, 520]) { ell(c, x, 160, 12, 6, '#d8dce0'); R(c, x - 1, 160, 2, 14, '#8a96a0'); } }]],
    mid(c, s, t, ox) { const mx = ox; for (let k = 0; k < 2; k++) { const y0 = 112 + k * 6; for (let i = 0; i < 26; i++) { const x = -AO + i * 31 + mx, wv = Math.sin(t * 1.5 + i) * 1.5; R(c, x, y0 + Math.round(Math.sin(i * .5) * 2), 31, 1, '#46505a'); if (k === 0) for (let r2 = 0; r2 < 9; r2++) R(c, x + 4 + r2 * .5 + wv * (r2 / 9), y0 + 2 + r2, 12 - r2, 1, ['#e3b887', '#8dc4bf', '#cb8e9f'][i % 3]); else ell(c, x + 10, y0 + 3, 1.5, 2, (i + Math.floor(t * 3)) % 4 ? '#ffe1a0' : '#ffffff'); } } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#f5dca5'; c.fillText('FREDDY · ÚLTIMO RECADO', 480, 173); c.font = '8px Pixel, monospace'; c.fillStyle = '#e9ca9b'; c.fillText('ÔÔÔ REEEIS, ASSISTE ESSA!', 480, 317); c.restore(); },
    light(g, s, t) { bulbGlow(g, 364, 92, .7, '255,200,140', 90); for (let i = 0; i < 26; i++) bulbGlow(g, -AO + i * 31 + 10, 121, .25, '255,220,150', 10); pool(g, 240, 214, .7, '255,190,140', 140); } };

  // --- REEIS: o trono do morro, de noite
  ARENA.reeisBoss = { layers: [[.08, 'ree-sky', (c) => { for (let i = 0; i < 16; i++) R(c, -AO, i * 10, AW, 10, css(mix([.04, .07, .16], [.16, .2, .34], i / 15))); for (let i = 0; i < 120; i++) R(c, -AO + hash(i + 601) * AW, hash(i + 602) * 120, 1, 1, i % 5 ? 'rgba(255,255,255,.7)' : '#ffe9b8'); for (let k = 0; k < 6; k++) ell(c, 90, 48, 30 - k * 3, 30 - k * 3, `rgba(220,230,255,${.04 + k * .02})`); ell(c, 90, 48, 13, 13, '#f4f6ff'); R(c, 84, 44, 4, 4, '#d8deef'); R(c, 92, 52, 5, 3, '#d8deef'); hillLights(c, 150, 76, 5.1, '#121a28', 1300); }],
      [.4, 'ree-fav', (c) => favRow(c, 178, 32, 28, 74, .5, .55, 50, true)],
      [1, 'ree-plaza', (c) => { R(c, -AO, 166, AW, 54, '#765449'); R(c, -AO, 164, AW, 6, '#c7a97a'); for (let y = 172; y < 220; y += 8) for (let x = -AO + ((y / 8) & 1) * 11; x < AW - AO; x += 22) { R(c, x, y, 21, 7, '#86604f'); R(c, x, y, 21, 1, '#9a705c'); } arenaGround(c, '#746a60', '#665c54', '#514f4e', '#d4be8b', 32);
        for (let y = 170; y < 220; y++) { const w = 36 + (y - 170) * 1.2; R(c, 240 - w / 2, y, w, 1, y % 4 ? '#a83a3a' : '#b84a44'); }
        R(c, 202, 116, 76, 54, '#243d49'); R(c, 206, 120, 68, 46, '#587a6b'); R(c, 210, 123, 60, 40, '#718e6d'); R(c, 210, 123, 60, 2, '#8eae88'); R(c, 201, 152, 78, 9, '#a48c58'); R(c, 201, 152, 78, 2, '#e8cf88'); for (let i = 0; i < 5; i++) { const x = 209 + i * 13; for (let k = 0; k < 12 - (i % 2) * 4; k++) R(c, x + k * .25, 120 - k, 7 - k * .5, 1, '#d1b76f'); ell(c, x + 3, 108 + (i % 2) * 4, 1.5, 1.5, i % 2 ? '#3ad0c0' : '#e04a3a'); } for (const x of [196, 276]) { R(c, x, 136, 9, 34, '#a48c58'); R(c, x, 136, 9, 2, '#e8cf88'); }
        R(c, 194, 166, 92, 8, '#5a4436'); R(c, 194, 166, 92, 2, '#a48c58');
        speakerTower(c, 25); speakerTower(c, 450); board(c, 138, 43, 206, 39, '#286577', '#153c54'); }]],
    mid(c, s, t, ox) { const mx = ox; for (let i = 0; i < 16; i++) { const x = 65 + i * 23.5 + mx, y = 92 + Math.round(Math.sin(i) * 6), wv = Math.sin(t * 1.4 + i) * 1.5; R(c, x, y, 23, 1, '#293f4b'); for (let r2 = 0; r2 < 11; r2++) R(c, x + 1 + r2 * .5 + wv * (r2 / 11), y + 1 + r2, 11 - r2, 1, i % 2 ? '#7fc6c6' : '#d8bd78'); } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#dfc372'; c.fillText('O TRONO DO MORRO', 482, 116); c.font = '8px Pixel, monospace'; c.fillStyle = '#a4e2d6'; c.fillText('GABRIEL REEIS · RESPEITA O REI', 482, 144); c.restore(); },
    light(g, s, t) { const p = .8 + .2 * Math.sin(t * 2); const gr = g.createLinearGradient(0, 0, 0, 175); gr.addColorStop(0, 'rgba(255,214,120,.28)'); gr.addColorStop(1, 'rgba(255,214,120,.04)'); g.fillStyle = gr; g.beginPath(); g.moveTo(232, 0); g.lineTo(248, 0); g.lineTo(290, 175); g.lineTo(190, 175); g.closePath(); g.fill(); pool(g, 240, 172, p, '255,214,120', 70); bulbGlow(g, 241, 82, .5, '120,220,210', 50); for (const x of [25, 450]) for (let j = 0; j < 4; j++) bulbGlow(g, x - 7 + j * 6, 68, .5, '255,214,150', 10); } };

  // --- GIGANTE: o rabisco colossal
  ARENA.giant = { layers: [[.08, 'gia-sky', (c) => { for (let i = 0; i < 16; i++) R(c, -AO, i * 12, AW, 12, css(mix([.06, .05, .13], [.2, .16, .32], i / 15))); for (let i = 0; i < 70; i++) R(c, -AO + hash(i + 701) * AW, hash(i + 702) * 170, 1, 1, i % 3 ? '#5a4a80' : '#b8a8e0'); for (const [x, w, h, tilt, col] of [[-80, 120, 150, .2, '#3a3256'], [130, 160, 120, -.1, '#43395f'], [380, 140, 160, .15, '#3a3256']]) { for (let r2 = 0; r2 < h; r2++) R(c, x + r2 * tilt, 190 - r2, w, 1, col); for (let j = 0; j < h; j += 9) R(c, x + j * tilt + 8, 190 - j, w - 16, 1, 'rgba(160,140,200,.25)'); R(c, x + 10, 190 - h, 1, h, 'rgba(220,120,160,.3)'); } }],
      [.35, 'gia-pages', (c) => { for (let i = 0; i < 9; i++) { const x = -40 + i * 64, y = 16 + (i % 3) * 8; for (let r2 = 0; r2 < 70; r2++) { const edge = r2 > 64 ? ((r2 + i) % 2) * 2 : 0; R(c, x + edge, y + r2, 40 - edge * 2, 1, '#9b86ad'); } R(c, x, y, 1, 70, 'rgba(255,255,255,.2)'); for (let j = 0; j < 5; j++) R(c, x + 6, y + 12 + j * 10, 28, 1, '#655476'); } }],
      [1, 'gia-near', (c) => { R(c, -AO, 140, AW, 80, '#2a2244'); for (let i = 0; i < 300; i++) R(c, -AO + hash(i + 801) * AW, 142 + hash(i + 802) * 76, 2, 1, i % 2 ? '#352c54' : '#221c3a');
        for (const [x0, x1, col, sd] of [[85, 238, '#c6b1cb', 1], [241, 395, '#e1cbd9', -1]]) for (let x = x0; x < x1; x++) { const k = (x - x0) / (x1 - x0), top = sd > 0 ? 115 + Math.round(k * 17) : 132 - Math.round(k * 19), bot = sd > 0 ? 188 + Math.round(k * 20) : 208 - Math.round(k * 20); R(c, x, top, 1, bot - top, col); R(c, x, bot, 1, 3, 'rgba(0,0,0,.35)'); }
        for (const [x0, sd] of [[100, 1], [262, -1]]) for (let j = 0; j < 7; j++) for (let x = 0; x < 120; x += 2) { const k = x / 120, yy = (sd > 0 ? 129 + Math.round(k * 14) : 145 - Math.round(k * 15)) + j * 8; R(c, x0 + x, yy, 2, 1, sd > 0 ? '#9a7ca9' : '#ae8dac'); }
        R(c, 237, 131, 4, 79, '#695578'); arenaGround(c, '#564669', '#4a3c5c', '#332f49', '#dec6d7', 25.5); board(c, 150, 40, 185, 22, '#473652', '#2a2040'); }]],
    mid(c, s, t, ox) { const nx = ox; for (let i = 0; i < 2; i++) { if ((t * .6 + i * .5) % 3 < .12) { let x = 80 + i * 300 + Math.round(ox * .08), y = 0; while (y < 120) { const nx2 = x + (hash(y + i + Math.floor(t)) - .5) * 30; limb(c, [[x, y], [nx2, y + 14]], 2, '#e8c0ff'); x = nx2; y += 14; } } } },
    near(c, s, t, ox) { for (let i = 0; i < 13; i++) { const x = 25 + i * 37 + ox, h = 22 + Math.sin(t * 2 + i) * 6; for (let k = 0; k < h; k++) R(c, x - (h - k) * .25, 220 - k, (h - k) * .5 + 1, 1, '#333049'); R(c, x, 220 - h, 1, 3, '#8a76b0'); } },
    text(c, t, ox) { c.save(); c.translate(ox * 2, 0); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#f0cddd'; c.fillText('O RABISCO COLOSSAL', 485, 102); c.restore(); },
    light(g, s, t) { bulbGlow(g, 240, 160, .5 + .1 * Math.sin(t * 3), '200,120,255', 120); } };

  // ------------------------------------------------------------------------------- SALAS DE AULA (Almiro e Miqueias)
  const ROOM_WIN = [{ x: 74, y: 38, w: 58, h: 58, open: 22 }, { x: 348, y: 38, w: 58, h: 58, open: 22 }], roomLayers = {};
  function buildRoom(en) { const [cv, c] = mk(LW, LH), wallA = en ? '#e3eef0' : '#e9f2f3', line = en ? '#c3b4a5' : '#9ab8c1';
    R(c, 0, 14, LW, 160, wallA); for (let row = 0; row < 7; row++) for (let col = 0; col < 17; col++) { const x = col * 31 + (row % 2) * 15.5, y = 22 + row * 23.5; R(c, x, y, 27, 1, line); R(c, x, y, 1, 20, line); } for (let i = 0; i < 700; i++) R(c, hash(i + 3) * LW, 16 + hash(i + 4) * 156, 1, 1, i % 2 ? 'rgba(0,0,0,.04)' : 'rgba(255,255,255,.3)');
    R(c, 0, 0, LW, 14, '#1c3f64'); R(c, 0, 14, LW, 4, '#e8dec1'); R(c, 0, 14, LW, 1, '#fff6dc'); R(c, 0, 18, LW, 1, 'rgba(0,0,0,.18)'); for (let x = 30; x < LW; x += 120) { R(c, x, 10, 44, 3, '#55656e'); R(c, x, 10, 44, 1, '#738790'); }
    R(c, 0, 174, LW, 46, '#2d5278'); R(c, 0, 172, LW, 4, '#e8d8b2'); R(c, 0, 172, LW, 1, '#fff2d0'); for (let x = 0; x < LW; x += 24) { R(c, x + 2, 180, 20, 34, '#33608a'); R(c, x + 2, 180, 20, 1, '#4a7aa4'); R(c, x + 2, 213, 20, 1, '#22446a'); } R(c, 0, 216, LW, 4, '#1c3a5a');
    c.save(); tileFloor(c, LW, FLOOR, en ? ['#d8c8b0', '#b8a48a', '#e6d8c0', '#c8b49a'] : ['#cfd8d0', '#aebcb4', '#dde6de', '#bccac2'], 18); c.restore();
    for (const w of ROOM_WIN) { w.slats = winBlind(c, w.x, w.y, w.w, w.h, 0, w.open); }
    // porta de saída
    R(c, 18, 118, 52, 102, '#4a4234'); R(c, 20, 120, 48, 100, '#665d4c'); R(c, 23, 123, 42, 97, en ? '#7b7a83' : '#6d8c97'); R(c, 23, 123, 2, 97, 'rgba(255,255,255,.2)'); R(c, 27, 130, 33, 46, '#a9c5c8'); R(c, 29, 132, 29, 42, '#d3dfcf'); for (let k = 0; k < 30; k++) R(c, 32 + Math.round((30 - k) * .3), 134 + k, 3, 1, 'rgba(255,255,255,.45)'); R(c, 56, 188, 3, 3, '#edcc86'); R(c, 16, 216, 56, 4, '#d1bd91'); R(c, 24, 104, 41, 12, '#2a6a4a'); R(c, 25, 105, 39, 10, '#3e8a5b'); R(c, 25, 105, 39, 1, '#7ad09a');
    // lousa
    R(c, 145, 30, 190, 88, '#5a4a34'); R(c, 147, 32, 186, 84, '#8f7653'); R(c, 147, 32, 186, 2, '#b8996c'); R(c, 151, 36, 178, 76, en ? '#2f5f4a' : '#2f6a62'); for (let i = 0; i < 260; i++) R(c, 152 + hash(i + 9) * 176, 37 + hash(i + 10) * 74, 2, 1, i % 2 ? 'rgba(255,255,255,.05)' : 'rgba(0,0,0,.08)'); for (let k = 0; k < 60; k++) R(c, 160 + Math.round((60 - k) * .5), 38 + k, 6, 1, 'rgba(255,255,255,.035)'); R(c, 145, 116, 190, 4, '#bd9f69'); R(c, 145, 116, 190, 1, '#e8cf98'); R(c, 152, 113, 10, 3, '#eee9c7'); R(c, 165, 114, 6, 2, '#f0c8d0'); R(c, 304, 112, 18, 4, '#c6b37e'); R(c, 305, 113, 16, 2, '#85998b');
    if (en) { for (let k = 0; k < 16; k++) { R(c, 300 + k, 96 + Math.round(Math.sin(k * .5) * 2), 1, 1, 'rgba(255,255,255,.7)'); } R(c, 302, 90, 12, 3, 'rgba(255,255,255,.6)'); R(c, 304, 86, 8, 4, 'rgba(255,255,255,.6)'); R(c, 307, 82, 2, 4, 'rgba(255,200,200,.8)'); } else { const ax = 312, ay = 94; for (let a = 0; a < 3; a++) for (let k = 0; k < 40; k++) { const an = k / 40 * 6.28; R(c, ax + Math.cos(an) * 11 * (a === 0 ? 1 : .4) * (a === 2 ? .4 : 1), ay + Math.sin(an) * 11 * (a === 1 ? 1 : .35) * (a === 0 ? .35 : 1), 1, 1, 'rgba(255,255,255,.75)'); } R(c, ax - 1, ay - 1, 3, 3, '#ffe9a0'); }
    // cartazes
    for (const [x, col] of [[80, en ? '#74627f' : '#597687'], [354, en ? '#74627f' : '#597687']]) { R(c, x - 1, 110, 49, 32, '#8b785d'); R(c, x, 111, 47, 30, '#f0dfb0'); R(c, x + 4, 114, 39, 3, col); R(c, x + 21, 108, 4, 4, '#c94f45'); }
    // relógio e mesa do professor
    R(c, 368, 182, 73, 7, '#ac8756'); R(c, 368, 182, 73, 2, '#d0a870'); R(c, 371, 189, 5, 31, '#786846'); R(c, 433, 189, 5, 31, '#786846'); R(c, 376, 190, 52, 18, '#9b7c50'); R(c, 376, 190, 52, 1, '#b8956a'); R(c, 392, 196, 3, 2, '#d5bf87'); R(c, 380, 176, 17, 6, en ? '#678b6f' : '#7b96a6'); R(c, 381, 175, 15, 2, '#e7deb7'); R(c, 380, 170, 13, 6, '#c94f45'); R(c, 381, 169, 11, 2, '#e8786a'); R(c, 412, 175, 7, 7, '#d4ba7d'); R(c, 413, 170, 1, 6, '#7c8460'); R(c, 415, 168, 1, 8, '#a8684b'); ell(c, 428, 179, 3, 3, '#d83a3a'); R(c, 428, 175, 1, 2, '#5a8a3a');
    return cv; }
  const RSKIN = ['#edc5a0', '#9a6546', '#c18b60', '#e7b994'], RHAIR = ['#3d362d', '#705239', '#2d3330', '#b3945b'];
  function drawRoom(c, id, t) {
    if (window.Graphics?.isLite?.() || !window.DayTime) return false; const en = id === 'miqueias', s = window.DayTime.state(), am = roomAmb(.6)(s);
    if (!far) far = buildFar(); if (!roomLayers[id]) roomLayers[id] = buildRoom(en);
    lc.clearRect(0, 0, LW, LH); sky(lc, s, t, 0, { amb: am, sb: 120, sa: 70, mb: 110, ma: 60 }); tile(lc, far[1], 300); tile(lc, far[2], 500); for (let x = 60; x < 420; x += 26) { ell(lc, x + Math.sin(t * 1.2 + x) * 1, 88, 12, 10, '#3f8a46'); ell(lc, x - 3, 84, 6, 4, '#68ad58'); } if (s.night > .05) { lc.fillStyle = `rgba(6,10,36,${.5 * s.night})`; lc.fillRect(0, 0, LW, 172); }
    lc.drawImage(roomLayers[id], 0, 0);
    wallClock(lc, 240, 24, s.h, 8, '#f6f2e2', '#1c3f64');
    for (let row = 0; row < 3; row++) for (let col = 0; col < 4; col++) { const i = row * 4 + col, x = Math.round(122 + col * 69.5), y = Math.round(129 + row * 23.5), bob = Math.round(Math.sin(t * 1.7 + i) * .6), sk = RSKIN[i % 4];
      R(lc, x - 8, y + 7, 18, 11, '#337ab3'); R(lc, x - 7, y - 1 + bob, 15, 12, i % 3 === 0 ? '#e3ebed' : '#244e7b'); R(lc, x - 5, y - 11 + bob, 11, 10, '#4b4034'); R(lc, x - 4, y - 10 + bob, 9, 8, sk); R(lc, x - 5, y - 12 + bob, 11, 4, RHAIR[i % 4]); R(lc, x - 5, y - 9 + bob, 2, 4, RHAIR[i % 4]); R(lc, x + 2, y - 6 + bob, 1, 1, '#393c31'); if (Math.sin(t * 3 + i * 2) > .92) R(lc, x + 1, y - 6 + bob, 3, 1, '#76513a');
      R(lc, x + 7 + Math.round(Math.sin(t * 3 + i) * 1), y + 6, 4, 2, sk); R(lc, x - 19, y + 9, 40, 4, '#8e714d'); R(lc, x - 19, y + 9, 40, 1, '#d2b27a'); R(lc, x - 16, y + 13, 2, 10, '#65735e'); R(lc, x + 15, y + 13, 2, 10, '#65735e'); R(lc, x - 8, y + 7, 12, 2, '#f0e5bb'); R(lc, x - 6, y + 7, 6, 1, '#72908a'); R(lc, x + 9, y + 7, 6, 1, '#cfb065'); }
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(low, 0, 0, 960, 540); c.textAlign = 'center'; c.textBaseline = 'middle';
    c.font = '16px Pixel, monospace'; c.fillStyle = '#e8f4ee'; c.fillText(en ? 'MY ENGLISH IS VERY BOM TODAY!' : 'CIÊNCIAS DA ROÇA', 480, 98); c.font = '8px Pixel, monospace'; c.fillStyle = '#f2e8a8';
    const L = en ? ['The bolo are disappear.', 'You is ready? ALLRIGHT!', 'BELEZA CREUZA! CONCORDA OU SEM CORDA?'] : ['Bolo + sapo = aventura', 'Hipótese: o bolo foi roubado.', 'Observação + amizade + muita coragem']; L.forEach((l, k) => c.fillText(l, 450, 136 + k * 20));
    c.fillStyle = '#f4eccb'; c.fillText('← SAÍDA', 89, 220); c.fillStyle = en ? '#74627f' : '#597687'; const P = en ? [['BOOK = LIVRO', 'CAKE = BOLO'], ['HELLO, TURMA!', 'GOOD LANCHE!']] : [['PENSE. OBSERVE.', 'FAÇA PERGUNTAS.'], ['AULA COM HUMOR', 'E CURIOSIDADE!']]; P.forEach((p, k) => { const x = (k ? 354 : 80) * 2 + 47; c.fillText(p[0], x, 248); c.fillText(p[1], x, 266); });
    c.globalCompositeOperation = 'multiply'; c.fillStyle = css(am); c.fillRect(0, 0, 960, 540); c.globalCompositeOperation = 'source-over';
    lg.clearRect(0, 0, LW, LH); blindsLight(lg, s, t, ROOM_WIN, 0, LW); const a = cl((s.night - .12) * 1.4), base = .12 + a * .78; for (let x = 30; x < LW; x += 120) { const sx = x + 22, gr = lg.createLinearGradient(0, 13, 0, 230); gr.addColorStop(0, `rgba(240,248,255,${.22 * base})`); gr.addColorStop(1, `rgba(240,248,255,${.03 * base})`); lg.fillStyle = gr; lg.beginPath(); lg.moveTo(sx - 22, 13); lg.lineTo(sx + 22, 13); lg.lineTo(sx + 60, 230); lg.lineTo(sx - 60, 230); lg.closePath(); lg.fill(); bulbGlow(lg, sx, 12, base * .8, '240,248,255', 26); }
    c.globalCompositeOperation = 'lighter'; c.drawImage(lightCv, 0, 0, 960, 540); c.restore(); return true; }

  const ARENA_TYPES = ['arthur', 'marco', 'menezes', 'nikolas', 'dede', 'nicolas', 'freddy', 'reeisBoss', 'giant'];
  const arenaHandles = (type) => { type = typeof type === 'object' ? type?.type : type; return ARENA_TYPES.includes(type) && !window.Graphics?.isLite?.() && !!window.DayTime; };
  function drawArena(c, type, camera, t, homeX) {
    type = typeof type === 'object' ? type.type : type;
    const a = ARENA[type], s = window.DayTime.state(), center = homeX ? homeX - camera : 480, ox = Math.round((center - 480) / 2);
    ac.clearRect(0, 0, LW, LH); a.back?.(ac, s, t, ox);
    a.layers.forEach(([p, key, build], i) => { ac.drawImage(aLayer(key, build), Math.round(ox * p) - AO, 0); if (i === a.layers.length - 2) a.mid?.(ac, s, t, ox); });
    a.near?.(ac, s, t, ox);
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(alow, 0, 0, 960, 540); a.text?.(c, t, ox); c.restore();
    if (a.daytime) { c.save(); c.globalCompositeOperation = 'multiply'; c.fillStyle = css(s.amb); c.fillRect(0, 0, 960, 540); c.restore(); }
  }
  function arenaFront(c, type, camera, t, homeX, blend) {
    type = typeof type === 'object' ? type.type : type; if (!arenaHandles(type)) return; const a = ARENA[type]; if (!a.light) return;
    const s = window.DayTime.state(), center = homeX ? homeX - camera : 480, ox = Math.round((center - 480) / 2);
    lg.clearRect(0, 0, LW, LH); lg.save(); lg.translate(ox, 0); a.light(lg, s, t); lg.restore();
    c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = cl(blend); c.imageSmoothingEnabled = false; c.drawImage(lightCv, 0, 0, 960, 540); c.restore();
  }

  const MAPS = { 0: { draw: farm, text: farmText, lights: farmLights }, 2: { draw: gym, text: gymText, lights: gymLights, amb: gymAmb }, 3: { draw: court, text: courtText, lights: courtLights }, 7: { draw: field, text: fieldText, lights: fieldLights }, 5: { draw: favela, text: favelaText, lights: favelaLights }, 9: { draw: patio, text: patioText, lights: patioLights }, 1: { draw: school, text: schoolText, lights: schoolLights }, 4: { draw: plaza, text: plazaText, lights: plazaLights }, 6: { draw: ink, text: inkText, lights: inkLights, amb: () => [1, 1, 1] }, 8: { draw: bigodon, text: bigodonText, lights: bigodonLights, amb: roomAmb(.62) }, 10: { draw: rayssa, text: rayssaText, lights: rayssaLights, amb: roomAmb(.6) } };
  const handles = (scene) => !!MAPS[scene] && !window.Graphics?.isLite?.() && !!window.DayTime;
  let lastCam = 0, lastT = 0;
  function draw(c, scene, camera, t) {
    if (!handles(scene)) return false;
    const s = window.DayTime.state(), camL = Math.floor(camera / 2), sub = Math.round(camera) - camL * 2;
    lc.clearRect(0, 0, LW, LH); SHADE = []; shadeCam = camL; shadeScene = scene; TREES = []; treeCam = camL; treeScene = scene; MAPS[scene].draw(lc, s, t, camL); { const dt = Math.max(0, Math.min(.1, t - lastLeafT)); lastLeafT = t; leavesDraw(lc, camL, t, dt); }
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(low, -sub, 0, LW * 2, LH * 2); c.restore();
    lastCam = camera; lastT = t; MAPS[scene].text?.(c, camera); return true;
  }
  // luz da hora do dia sobre o cenário pronto (chamado depois das pontes); personagens ficam de fora
  function finish(c, scene) {
    if (!handles(scene)) return;
    const s = window.DayTime.state(), camL = Math.floor(lastCam / 2), sub = Math.round(lastCam) - camL * 2;
    c.save(); c.globalCompositeOperation = 'multiply'; c.fillStyle = css(MAPS[scene].amb ? MAPS[scene].amb(s) : s.amb); c.fillRect(0, 0, 960, 540);
    LIGHTS = []; lightCam = camL; lightScene = scene; if (MAPS[scene].lights) { lg.clearRect(0, 0, LW, LH); MAPS[scene].lights(lg, s, lastT, camL); c.globalCompositeOperation = 'lighter'; c.imageSmoothingEnabled = false; c.drawImage(lightCv, -sub, 0, LW * 2, LH * 2); }
    c.restore();
  }
  window.HdMaps = Object.freeze({ leaves: () => ({ caindo: LEAVES.length, balancando: RUSTLE.size }), touch: (scene, x, y, vx, vy) => { try { touch(Number(scene), +x || 0, +y || 0, +vx || 0, +vy || 0); } catch (e) {} }, lightsAt: (scene, x) => { try { return lightsAt(Number(scene), Number(x) || 0); } catch (e) { return []; } }, shadeAt: (scene, x) => { try { return shadeAt(Number(scene), Number(x) || 0); } catch (e) { return { k: 0, leaves: false }; } }, sun: () => { try { return sunInfo(window.DayTime.state()); } catch (e) { return { lean: 0, str: 0 }; } }, drawRoom: (c, id, t) => { try { return drawRoom(c, id, Number(t) || 0); } catch (e) { window.__hdMapsError = e; return false; } }, arenaHandles, drawArena: (c, type, camera, t, homeX) => { try { drawArena(c, type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0); return true; } catch (e) { window.__hdMapsError = e; return false; } }, arenaFront: (c, type, camera, t, homeX, blend) => { try { arenaFront(c, type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0, blend); } catch (e) { window.__hdMapsError = e; } }, handles, darkness: (c, scene, camera, t, hx, hy, facing) => { try { darkness(c, Number(scene), Number(camera) || 0, Number(t) || 0, Number(hx) || 0, Number(hy) || 0, facing); } catch (e) {} }, draw: (c, scene, camera, t) => { try { return draw(c, Number(scene), Number(camera) || 0, Number(t) || 0); } catch (e) { window.__hdMapsError = e; return false; } }, finish: (c, scene) => { try { finish(c, Number(scene)); } catch (e) {} }, maps: Object.keys(MAPS).map(Number) });
})();
