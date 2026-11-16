/* Personagens no novo padrão de arte (fase 2), redesenhados à mão.
   Cada personagem é desenhado direto em pixels de arte (1 pixel de arte = 2 de tela),
   já no tamanho final: quando o chefe cresce, ganha detalhe em vez de pixels maiores.
   A luz vem de cima e da esquerda da tela, para os dois lados que o personagem olhar.
   Só aparência: posição, tamanho e poses são os mesmos que o jogo já usava.
   Personagens prontos: igor. */
(() => {
  'use strict';
  if (window.HdChars) return;
  const cv = document.createElement('canvas'); cv.width = 320; cv.height = 260;
  const g = cv.getContext('2d'); g.imageSmoothingEnabled = false;
  let k = 1, f = 1, ax = 0, ay = 0, lx = -1, o1 = 1;
  const X = (x) => ax + f * x * k, Y = (y) => ay + y * k;
  // elipse sem suavização, com recorte opcional de linhas (y0..y1 em unidades de desenho)
  function ell(cx, cy, rx, ry, col, y0 = -1e9, y1 = 1e9) {
    const CX = X(cx), CY = Y(cy), RX = Math.max(.5, rx * k), RY = Math.max(.5, ry * k); g.fillStyle = col;
    for (let yy = Math.ceil(CY - RY); yy <= Math.floor(CY + RY); yy++) {
      const d = (yy - ay) / k; if (d < y0 || d > y1) continue;
      const t = (yy - CY) / RY, w = RX * Math.sqrt(Math.max(0, 1 - t * t)); let xa = Math.round(CX - w), xb = Math.round(CX + w); if (xb <= xa) xb = xa + 1;
      g.fillRect(xa, yy, xb - xa, 1);
    }
  }
  function box(x, y, w, h, col) { const x1 = X(x), x2 = X(x + w), xa = Math.round(Math.min(x1, x2)), ya = Math.round(Y(y)); g.fillStyle = col; g.fillRect(xa, ya, Math.max(1, Math.round(Math.abs(x2 - x1))), Math.max(1, Math.round(h * k))); }
  function limb(pts, w, col) { for (let i = 0; i < pts.length - 1; i++) { const a = pts[i], b = pts[i + 1], n = Math.ceil(Math.hypot(b[0] - a[0], b[1] - a[1]) * k) + 1; for (let s = 0; s <= n; s++) { const t = s / n; ell(a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, w / 2, w / 2, col); } } }
  // volume: contorno, sombra, cor base deslocada para a luz e brilho
  function ball(cx, cy, rx, ry, P, y0, y1) { ell(cx, cy, rx + o1, ry + o1, P.ink, y0 === undefined ? undefined : y0 - o1, y1 === undefined ? undefined : y1 + o1); ell(cx, cy, rx, ry, P.shadow, y0, y1); ell(cx + lx * rx * .09, cy - ry * .1, rx * .9, ry * .88, P.base, y0, y1); ell(cx + lx * rx * .3, cy - ry * .42, rx * .42, ry * .28, P.light, y0, y1); }
  const INK = '#2c2233';
  const SKIN = { ink: INK, base: '#e7a079', light: '#f6bf96', shadow: '#c27a59' };
  const CASUAL = { ink: INK, base: '#7c8075', light: '#989d8e', shadow: '#5b5f57' };
  const BATTLE = { ink: INK, base: '#226ca8', light: '#439ad6', shadow: '#174d7c' };
  const PANTS = { ink: INK, base: '#233a58', light: '#35557f', shadow: '#172840' };
  const BEARD = '#654c3e', BEARD_D = '#47352b', BEARD_L = '#80624f';

  function begin(o, w, h, foot) {
    const s = Math.max(.3, Number(o.scale) || 1); k = s / 2; f = o.facing < 0 ? -1 : 1; lx = -f; o1 = 1 / k;
    const BW = Math.ceil(w * k) + 8, BH = Math.ceil(h * k) + 8; if (BW > 640 || BH > 520) return null;
    if (cv.width < BW || cv.height < BH) { cv.width = Math.max(cv.width, BW); cv.height = Math.max(cv.height, BH); g.imageSmoothingEnabled = false; }
    g.setTransform(1, 0, 0, 1, 0, 0); g.globalCompositeOperation = 'source-over'; g.globalAlpha = 1; g.clearRect(0, 0, BW, BH);
    ax = Math.round(BW / 2); ay = BH - Math.ceil(foot * k) - 3; return [BW, BH];
  }
  function end(c, x, y, size, o) {
    if (o.hit) { g.globalCompositeOperation = 'source-atop'; g.fillStyle = 'rgba(255,243,213,.6)'; g.fillRect(0, 0, size[0], size[1]); g.globalCompositeOperation = 'source-over'; }
    c.save(); c.imageSmoothingEnabled = false; c.drawImage(cv, 0, 0, size[0], size[1], Math.round(x) - ax * 2, Math.round(y) - ay * 2, size[0] * 2, size[1] * 2); c.restore();
  }

  // ------------------------------------------------------------------------------- IGOR
  function shoe(x, y) { // x,y = canto de cima-trás do tênis (20x8)
    box(x - 1, y - 1, 22, 10, INK); ell(x + 15, y + 4, 6, 4.6, INK); box(x, y, 20, 8, '#edf0dd'); ell(x + 15, y + 4, 5, 3.6, '#edf0dd'); box(x, y, 14, 2, '#ffffff');
    box(x, y + 5.5, 21, 2.5, '#3a3f48'); box(x + 4, y + 2.5, 3, 3, '#d9483b'); box(x + 9, y + 2.5, 3, 3, '#d9483b'); box(x + 15, y + 1, 4, 1.5, '#c5ccb9');
  }
  function leg(x, y, w, h) { box(x - 1, y - 1, w + 2, h + 1, INK); box(x, y, w, h, PANTS.base); box(f > 0 ? x : x + w - 3, y, 3, h, PANTS.light); box(f > 0 ? x + w - 3 : x, y, 3, h, PANTS.shadow); box(x + 2, y + h - 3, w - 4, 1.2, PANTS.shadow); }
  function arm(pts, shirt, back) {
    const skin = back ? SKIN.shadow : SKIN.base;
    limb(pts, 14.4, INK); limb(pts, 11.8, skin);
    if (!back) limb([[pts[0][0] + lx * 1.2, pts[0][1] - 1.2], [pts[1][0] + lx * 1.2, pts[1][1] - 1.2], [pts[2][0] + lx * 1.2, pts[2][1] - 1.2]], 3.4, SKIN.light);
    const m = [pts[0][0] + (pts[1][0] - pts[0][0]) * .55, pts[0][1] + (pts[1][1] - pts[0][1]) * .55];
    limb([pts[0], m], 15.6, INK); limb([pts[0], m], 13.2, back ? shirt.shadow : shirt.base); ell(m[0], m[1], 6.6, 6.6, shirt.shadow); // manga curta
    const h = pts[2]; ell(h[0], h[1], 8.4, 8.4, INK); ell(h[0], h[1], 7.1, 7.1, back ? SKIN.shadow : SKIN.base); ell(h[0] + lx * 2, h[1] - 2, 3.2, 2.8, back ? SKIN.base : SKIN.light); box(h[0] - 3, h[1] + 1.6, 6, 1, SKIN.shadow);
  }
  function igorRolling(c, x, y, o) {
    const size = begin(o, 110, 96, 6); if (!size) return false;
    const a = (Number(o.rollAngle) || 0) * f, ca = Math.cos(a), sa = Math.sin(a), cy0 = -36, shirt = o.monitorBattle ? BATTLE : CASUAL;
    const at = (px, py) => [px * ca - py * sa, cy0 + px * sa + py * ca];
    for (const [px, py, r] of [[-15, 29, 9], [11, 31, 9], [30, -8, 8], [-31, 5, 8], [-6, -30, 15]]) { const p = at(px, py); ell(p[0], p[1], r + o1, r + o1, INK); }
    ball(0, cy0, 35, 35, shirt);
    { const p = at(11, 7); ell(p[0], p[1], 22, 22, o.monitorBattle ? BATTLE.light : SKIN.base); const q = at(15, 9); ell(q[0], q[1], 3, 2.4, o.monitorBattle ? BATTLE.shadow : SKIN.shadow); const hl = at(4, -2); ell(hl[0] + lx * 3, hl[1] - 3, 8, 6, o.monitorBattle ? '#63b3e6' : SKIN.light); }
    for (const [px, py] of [[-15, 29], [11, 31]]) { const p = at(px, py); ell(p[0], p[1], 8, 8, '#c5ccb9'); ell(p[0] + lx * 1.5, p[1] - 1.5, 6, 6, '#edf0dd'); const s2 = at(px * .82, py * .82); ell(s2[0], s2[1], 3.2, 3.2, '#d9483b'); }
    for (const [px, py] of [[30, -8], [-31, 5]]) { const p = at(px, py); ell(p[0], p[1], 7, 7, SKIN.base); ell(p[0] + lx * 2, p[1] - 2, 3, 2.6, SKIN.light); }
    { const p = at(-6, -30); ell(p[0], p[1], 14, 14, SKIN.shadow); ell(p[0] + lx * 1.2, p[1] - 1.4, 12.6, 12.4, SKIN.base); const b = at(-2, -22); ell(b[0], b[1], 9, 7, BEARD); const e1 = at(-11, -33), e2 = at(-1, -35); ell(e1[0], e1[1], 1.8, 2.2, INK); ell(e2[0], e2[1], 1.8, 2.2, INK); const sh = at(-9, -40); ell(sh[0], sh[1], 4, 2, SKIN.light); }
    end(c, x, y, size, o); return true;
  }
  function igor(c, x, y, o = {}) {
    if (o.bellyRolling) return igorRolling(c, x, y, o);
    const size = begin(o, 150, 124, 12); if (!size) return false;
    const t = Number(o.frame) || 0, moving = !!o.moving, walk = moving ? Math.sin(t * 7) * 4 : 0, bob = moving ? -Math.abs(Math.cos(t * 7)) * 1.6 : Math.sin(t * 2.4) * .7;
    const IP = o.igorPose, ik = Math.max(0, Math.min(1, Number(o.igorPoseK ?? 1))), battle = !!o.monitorBattle, shirt = battle ? BATTLE : CASUAL, angry = !!o.rage || IP === 'crouch' || IP === 'fall';
    const crouch = IP === 'crouch' ? ik * 4 : IP === 'land' ? 3 : 0, by = bob + crouch;
    ell(0, 1, 30, 4, 'rgba(20,24,30,.28)');
    // pernas e tênis
    if (IP === 'rise') { leg(-17, -30, 14, 16); leg(4, -30, 14, 16); shoe(-20, -16); shoe(2, -16); }
    else if (IP === 'crouch') { const sp = ik * 5; leg(-20 - sp, -23, 14, 21); leg(7 + sp, -23, 14, 21); shoe(-23 - sp, -8); shoe(5 + sp, -8); }
    else { leg(-18 + walk, -23, 14, 21); leg(5 - walk, -23, 14, 21); shoe(-21 + walk, -8); shoe(3 - walk, -8); }
    // poses dos braços (as mesmas da luta)
    let AL = [[-25, -57], [-33, -38 + walk], [-29, -28 + walk]], AR = [[25, -58], [34, -39 - walk], [29, -26 - walk]];
    if (IP === 'crouch') { AL = [[-25, -57], [-38, -46 + ik * 4], [-46, -34 + ik * 8]]; AR = [[25, -58], [16, -44 + ik * 2], [4, -32 + ik * 6]]; }
    else if (IP === 'rise') { AL = [[-25, -57], [-33, -77], [-27, -97]]; AR = [[25, -58], [33, -79], [27, -99]]; }
    else if (IP === 'fall') { AL = [[-25, -57], [-46, -63], [-61, -58]]; AR = [[25, -58], [46, -64], [61, -59]]; }
    else if (IP === 'land') { AL = [[-25, -57], [-44, -46], [-54, -36]]; AR = [[25, -58], [44, -47], [54, -37]]; }
    const up = (pts) => pts.map((p) => [p[0], p[1] + by]);
    arm(up(AL), shirt, true);
    // barrigão: pele, camisa que não fecha (casual) ou uniforme de monitor, e cós da calça
    const cy = -40 + by, breathe = 1 + Math.sin(t * 2.4) * .012;
    ball(0, cy, 30 * breathe, 31, battle ? shirt : SKIN);
    if (!battle) { ball(0, cy, 30.6 * breathe, 31, shirt, -200, -25 + by); ell(0, cy, 30.6 * breathe, 31, shirt.shadow, -27 + by, -25 + by); ell(9, -19 + by, 2.6, 2, SKIN.shadow); ell(9 + lx, -19.6 + by, 1.2, .9, '#a5644a'); for (const wx of [-14, -3, 12]) box(wx, -31 + by, 1.2, 4, shirt.shadow); }
    else { ell(5, cy + 4, 20, 19, '#2f7fbd'); ell(5 + lx * 5, cy - 3, 9, 7, BATTLE.light); ell(0, cy, 30, 31, '#e8ecd8', -52 + by, -49.5 + by); ell(0, cy, 30, 31, BATTLE.shadow, -49.5 + by, -48.5 + by);
      box(-19, -46 + by, 9, 9, INK); box(-18, -45 + by, 7, 7, '#f0c84a'); box(-17, -43 + by, 5, 1.2, '#8a6a1c'); box(-17, -41 + by, 3, 1.2, '#8a6a1c'); // crachá
      limb([[-6, -66 + by], [8, -50 + by], [13, -44 + by]], 1.4, '#e8ecd8'); box(10, -45 + by, 7, 4.5, INK); box(11, -44 + by, 5, 2.6, '#f2d64b'); // apito
      for (const sx of [-27, 19]) { box(sx - 1, -63 + by, 10, 6, INK); box(sx, -62 + by, 8, 4, '#2b7bb6'); box(sx, -62 + by, 8, 1.2, '#f0c84a'); } }
    ball(0, cy, 30.4 * breathe, 31, PANTS, -15 + by, 200); ell(0, cy, 30.4 * breathe, 31, '#3d2b1f', -15 + by, -12.6 + by); box(-3, -15.4 + by, 6, 3.4, '#d7b45a');
    arm(up(AR), shirt, false);
    // cabeça: careca brilhando, cabelo atrás, orelha, sobrancelhão, barba cheia
    const hy = by * 1.15;
    ell(-1, -75 + hy, 18.4, 16.4, INK); ell(-1, -75 + hy, 17.2, 15.2, '#3a2a22'); ell(1.6, -75 + hy, 16, 15.2, SKIN.shadow); ell(1.6 + lx * 1.4, -76.4 + hy, 14.6, 13.6, SKIN.base);
    ell(2 + lx * 5, -85 + hy, 7, 2.8, SKIN.light); ell(1 + lx * 6, -86 + hy, 3, 1.2, '#fff0dc');
    ell(-12, -74 + hy, 3.2, 4.2, INK); ell(-12, -74 + hy, 2.2, 3.2, SKIN.shadow); ell(-12, -74 + hy, 1, 1.6, '#a5644a');
    ell(2, -65 + hy, 13.6, 8.6, BEARD_D, -70 + hy, 200); ell(2, -65.5 + hy, 12.4, 7.6, BEARD, -70 + hy, 200); ell(2 + lx * 3, -67 + hy, 6, 2.6, BEARD_L, -70 + hy, 200); for (const bx of [-6, -1, 5, 10]) box(bx, -61 + hy, 1.2, 3, BEARD_D);
    box(-7, -70.5 + hy, 18, 3.2, BEARD_D); box(-6, -70.5 + hy, 16, 1.4, BEARD);
    if (angry) { box(-3, -66.6 + hy, 11, 5.4, '#3d1414'); box(-2, -66.6 + hy, 9, 1.6, '#f7f3e4'); box(-1, -62.6 + hy, 6, 1.4, '#c9565a'); } else box(-2, -65.6 + hy, 9, 1.8, '#3a1f1f');
    ell(3, -71.5 + hy, 4.4, 3.2, SKIN.shadow); ell(3 + lx, -72.2 + hy, 3.2, 2.2, '#d98f6c'); ell(2 + lx * 1.6, -73 + hy, 1.2, .9, SKIN.light);
    for (const ex of [-6, 8]) { box(ex - 1, -79.5 + hy, 7.4, 6, INK); box(ex, -78.6 + hy, 5.4, 4.2, '#fbf7ea'); box(ex + 2.2, -78.6 + hy, 3.2, 4.2, o.rage ? '#d8323e' : '#2b3138'); if (k >= .9) box(ex + 2.2, -78.6 + hy, 1.1, 1.1, '#ffffff'); }
    if (angry) { box(-8, -82.6 + hy, 4, 2.6, BEARD_D); box(-4, -81.4 + hy, 4.4, 2.6, BEARD_D); box(7, -81.4 + hy, 4.4, 2.6, BEARD_D); box(11, -82.6 + hy, 4, 2.6, BEARD_D); }
    else { box(-8, -82 + hy, 8.4, 2.6, BEARD_D); box(7, -82 + hy, 8.4, 2.6, BEARD_D); }
    ell(12, -72 + hy, 3, 1.8, '#e58a73');
    if (o.rage) { box(-9, -90 + hy, 1.4, 4, '#d8323e'); box(-11, -88.6 + hy, 5, 1.4, '#d8323e'); }
    if (IP === 'land') { const d = (t * 2) % 1; ell(17, -80 + hy + d * 8, 1.6, 2.4, '#9fd8f2'); }
    end(c, x, y, size, o); return true;
  }

  const DRAW = { igor };
  window.HdChars = Object.freeze({
    draw(c, type, x, y, o) { const fn = DRAW[type]; if (!fn || window.Graphics?.isLite?.()) return false; try { return fn(c, x, y, o || {}) === true; } catch (e) { return false; } },
    list: Object.keys(DRAW)
  });
})();
