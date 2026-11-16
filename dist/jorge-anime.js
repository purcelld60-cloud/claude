/* Jorge epilogue, redrawn as an anime-style sequence (original artwork, no copied frames).
   Same 10 shots, durations, lines and audio cues as epilogue.js; only the drawing changes.
   Techniques: bold line art and two-tone cel shading, eye shadowed for emptiness, extreme
   eye close-up with pupil shock, radial speed lines, impact frames, slow-motion fall,
   rain silhouette and a villain's eyes opening in the dark. */
(() => {
  'use strict';
  if (!window.JorgeEpilogue || window.JorgeAnime) return;
  if (!CanvasRenderingContext2D.prototype.roundRect) CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) { this.moveTo(x + r, y); this.arcTo(x + w, y, x + w, y + h, r); this.arcTo(x + w, y + h, x, y + h, r); this.arcTo(x, y + h, x, y, r); this.arcTo(x, y, x + w, y, r); this.closePath(); };
  const W = 960, H = 540, INK = '#150f19';
  const clamp = (v, a = 0, b = 1) => Math.max(a, Math.min(b, v));
  const smooth = (v) => { v = clamp(v); return v * v * (3 - 2 * v); };
  const ease = (v) => 1 - Math.pow(1 - clamp(v), 3);
  const lerp = (a, b, p) => a + (b - a) * p;
  const rnd = (n) => { const x = Math.sin(n * 91.345 + 12.9898) * 43758.5453; return x - Math.floor(x); };

  // ---------- drawing helpers ----------
  function path(c, pts, close = true) { c.beginPath(); pts.forEach((p, i) => i ? c.lineTo(p[0], p[1]) : c.moveTo(p[0], p[1])); if (close) c.closePath(); }
  function fill(c, pts, col) { path(c, pts); c.fillStyle = col; c.fill(); }
  function line(c, pts, col, w = 3) { path(c, pts, false); c.strokeStyle = col; c.lineWidth = w; c.lineCap = 'round'; c.lineJoin = 'round'; c.stroke(); }
  function circ(c, x, y, r, col) { c.beginPath(); c.arc(x, y, Math.max(.1, r), 0, Math.PI * 2); c.fillStyle = col; c.fill(); }
  function oval(c, x, y, rx, ry, col, rot = 0) { c.beginPath(); c.ellipse(x, y, Math.max(.1, rx), Math.max(.1, ry), rot, 0, Math.PI * 2); c.fillStyle = col; c.fill(); }
  function glow(c, x, y, r, col, a) { const g = c.createRadialGradient(x, y, 1, x, y, r); g.addColorStop(0, col.replace('A', a)); g.addColorStop(1, col.replace('A', 0)); c.save(); c.globalCompositeOperation = 'screen'; c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore(); }
  function vgrad(c, stops, y0 = 0, y1 = H) { const g = c.createLinearGradient(0, y0, 0, y1); stops.forEach(([o, col]) => g.addColorStop(o, col)); c.fillStyle = g; c.fillRect(0, y0, W, y1 - y0); }
  function speedLines(c, cx, cy, n, inner, col, alpha, t, seed = 0) {
    c.save(); c.globalAlpha = alpha; c.fillStyle = col;
    for (let i = 0; i < n; i++) { const a = rnd(i + seed + Math.floor(t * 12) * .13) * Math.PI * 2, w = .004 + rnd(i * 3 + seed) * .012, r0 = inner + rnd(i * 7 + Math.floor(t * 12)) * 60;
      c.beginPath(); c.moveTo(cx + Math.cos(a - w) * r0, cy + Math.sin(a - w) * r0); c.lineTo(cx + Math.cos(a) * 1200, cy + Math.sin(a) * 1200); c.lineTo(cx + Math.cos(a + w) * r0, cy + Math.sin(a + w) * r0); c.closePath(); c.fill(); }
    c.restore();
  }
  function rain(c, t, n, alpha, slant = .18) { c.save(); c.globalAlpha = alpha; c.strokeStyle = '#a9b8d8'; c.lineWidth = 1.2; c.beginPath(); for (let i = 0; i < n; i++) { const x = (rnd(i) * (W + 200) + t * 120 * slant * 4) % (W + 200) - 100, y = (rnd(i * 5) * H + t * (900 + rnd(i * 2) * 400)) % (H + 60) - 30, l = 14 + rnd(i * 9) * 18; c.moveTo(x, y); c.lineTo(x - l * slant, y + l); } c.stroke(); c.restore(); }
  function stars(c, t, n, y1) { for (let i = 0; i < n; i++) { const x = rnd(i * 3) * W, y = rnd(i * 7) * y1, tw = .4 + .6 * Math.abs(Math.sin(t * (1 + rnd(i)) + i)); c.globalAlpha = tw * (.5 + rnd(i * 11) * .5); c.fillStyle = '#f4f0ff'; c.fillRect(x, y, rnd(i) > .9 ? 2 : 1, rnd(i) > .9 ? 2 : 1); } c.globalAlpha = 1; }
  function bokeh(c, t, n, col, seed = 0) { c.save(); c.globalCompositeOperation = 'screen'; for (let i = 0; i < n; i++) { const x = rnd(i + seed) * W + Math.sin(t * .3 + i) * 20, y = rnd(i * 4 + seed) * H + Math.cos(t * .25 + i) * 14, r = 10 + rnd(i * 6 + seed) * 34; c.globalAlpha = .06 + rnd(i * 8) * .1; circ(c, x, y, r, col); } c.restore(); }
  function shake(c, amt, t) { c.translate(Math.sin(t * 61) * amt, Math.cos(t * 47) * amt); }
  function subtitle(c, speaker, text, a) {
    if (a <= 0 || !text) return; c.save(); c.globalAlpha = a; c.textAlign = 'center'; c.textBaseline = 'middle';
    if (speaker) { c.font = '700 13px Space,Arial,sans-serif'; c.fillStyle = '#ffd979'; c.fillText(speaker.toUpperCase(), W / 2, H - 78); }
    c.font = '600 26px Space,Arial,sans-serif'; c.lineWidth = 6; c.lineJoin = 'round'; c.strokeStyle = '#000000cc'; c.strokeText(text, W / 2, H - 52); c.fillStyle = '#ffffff'; c.fillText(text, W / 2, H - 52); c.restore();
  }
  function tracked(c, value, x, y, size, color, spacing = 4) { c.save(); c.font = `700 ${size}px Space,Arial,sans-serif`; c.textBaseline = 'middle'; const chars = [...value], w = chars.reduce((n, l) => n + c.measureText(l).width, 0) + (chars.length - 1) * spacing; let at = x - w / 2; c.fillStyle = color; for (const l of chars) { c.fillText(l, at, y); at += c.measureText(l).width + spacing; } c.restore(); }

  // ---------- Da Roça, anime proportions ----------
  const SKIN = '#c98a5e', SKIN_SH = '#93583a', SKIN_HI = '#e2a97b', SHIRT = '#d9782f', SHIRT_SH = '#9c4b1d';
  function hat(c, s, t, tilt = 0) {
    c.save(); c.rotate(tilt);
    oval(c, 0, -52, 160, 34, '#7d5a26'); oval(c, 0, -56, 156, 30, '#d9b46a'); oval(c, 0, -52, 120, 18, '#a8823e');
    path(c, [[-70, -60], [-62, -128], [-30, -142], [30, -142], [62, -128], [70, -60]]); c.fillStyle = '#e6c47a'; c.fill(); c.lineWidth = 3; c.strokeStyle = INK; c.stroke();
    path(c, [[30, -142], [62, -128], [70, -60], [40, -60]]); c.fillStyle = '#c29a54'; c.fill();
    fill(c, [[-70, -78], [70, -78], [69, -64], [-69, -64]], '#7a4a24');
    c.globalAlpha = .35; for (let i = -6; i <= 6; i++) line(c, [[i * 10, -138], [i * 11, -66]], '#8d6a32', 1); for (let i = 0; i < 12; i++) line(c, [[-150 + i * 26, -52], [-140 + i * 24, -38]], '#8d6a32', 1); c.globalAlpha = 1;
    c.beginPath(); c.ellipse(0, -56, 156, 30, 0, 0, Math.PI * 2); c.lineWidth = 3; c.strokeStyle = INK; c.stroke();
    c.restore();
  }
  // o: {look, open (0..1), pupil (0..1), empty, sweat, mouth: 'flat'|'open'|'gasp', tremble}
  function animeEye(c, x, y, side, o, t) {
    const w = 27, h = 15 * (o.open ?? 1), lx = (o.look || 0) * 5, tr = o.tremble ? Math.sin(t * 70) * 1.2 : 0;
    const shape = () => { c.beginPath(); c.moveTo(x - w, y + 3); c.bezierCurveTo(x - w * .6, y - h * 1.35, x + w * .5, y - h * 1.45, x + w, y - 2); c.bezierCurveTo(x + w * .5, y + h * 1.05, x - w * .5, y + h * 1.05, x - w, y + 3); c.closePath(); };
    c.save();
    shape(); c.fillStyle = '#f7f1ea'; c.fill(); c.save(); c.clip();
    const ir = 12.5 * (o.pupil < .35 ? .82 : 1), ix = x + lx + tr, iy = y + 1;
    const g = c.createRadialGradient(ix, iy - 4, 2, ix, iy, ir); g.addColorStop(0, o.empty ? '#3a2a24' : '#a06a36'); g.addColorStop(1, o.empty ? '#120c0c' : '#3a2010');
    c.fillStyle = g; c.beginPath(); c.arc(ix, iy, ir, 0, Math.PI * 2); c.fill();
    circ(c, ix, iy, Math.max(1.6, 7 * (o.pupil ?? .6)), '#0c0708');
    if (!o.empty) { circ(c, ix - 5, iy - 6, 4, '#ffffff'); circ(c, ix + 5, iy + 5, 1.8, '#ffffffcc'); }
    if (o.reflect) { c.save(); c.globalCompositeOperation = 'screen'; c.globalAlpha = .45; c.fillStyle = '#6a8cff'; c.beginPath(); c.roundRect(ix - 5, iy - 7, 10, 14, 2); c.fill(); c.restore(); }
    const lid = c.createLinearGradient(0, y - h, 0, y); lid.addColorStop(0, 'rgba(60,30,30,.5)'); lid.addColorStop(1, 'rgba(60,30,30,0)'); c.fillStyle = lid; c.fillRect(x - w, y - h, w * 2, h);
    c.restore();
    c.beginPath(); c.moveTo(x - w - 2, y + 3); c.bezierCurveTo(x - w * .6, y - h * 1.4, x + w * .5, y - h * 1.5, x + w + 3, y - 2); c.lineWidth = 5; c.strokeStyle = INK; c.lineCap = 'round'; c.stroke();
    line(c, [[x + side * w, y - 2], [x + side * (w + 8), y - 8]], INK, 3);
    c.beginPath(); c.moveTo(x - w * .55, y + h * .78); c.quadraticCurveTo(x, y + h * 1.05, x + w * .6, y + h * .7); c.lineWidth = 1.6; c.strokeStyle = '#5a3a32'; c.stroke();
    c.restore();
  }
  function head(c, x, y, s, t, o = {}) {
    c.save(); c.translate(x, y); c.scale(s, s); c.rotate(o.tilt || 0);
    // shirt, neck
    fill(c, [[-150, 260], [-120, 140], [-40, 112], [40, 112], [120, 140], [150, 260]], SHIRT);
    fill(c, [[40, 112], [120, 140], [150, 260], [60, 260]], SHIRT_SH);
    line(c, [[-150, 260], [-120, 140], [-40, 112], [40, 112], [120, 140], [150, 260]], INK, 4);
    fill(c, [[-30, 70], [30, 70], [34, 125], [0, 140], [-34, 125]], SKIN_SH);
    line(c, [[-40, 112], [0, 140], [40, 112]], INK, 3);
    // face
    c.beginPath(); c.moveTo(-74, -48); c.bezierCurveTo(-80, 30, -62, 88, -12, 112); c.lineTo(14, 112); c.bezierCurveTo(56, 90, 76, 30, 74, -48); c.closePath(); c.fillStyle = SKIN; c.fill();
    c.save(); c.clip();
    c.beginPath(); c.moveTo(30, -60); c.bezierCurveTo(60, 0, 50, 70, 8, 116); c.lineTo(90, 116); c.lineTo(90, -60); c.closePath(); c.fillStyle = SKIN_SH; c.fill();
    c.fillStyle = SKIN_HI; c.beginPath(); c.ellipse(-40, 30, 16, 26, -.2, 0, Math.PI * 2); c.globalAlpha = .45; c.fill(); c.globalAlpha = 1;
    c.fillStyle = 'rgba(30,15,20,.5)'; c.fillRect(-90, -80, 180, o.empty ? 74 : 22);
    if (o.empty) { const g = c.createLinearGradient(0, -10, 0, 30); g.addColorStop(0, 'rgba(20,10,20,.65)'); g.addColorStop(1, 'rgba(20,10,20,0)'); c.fillStyle = g; c.fillRect(-90, -10, 180, 40); }
    c.globalAlpha = .35; c.fillStyle = '#d96a5a'; c.fillRect(-58, 44, 22, 3); c.fillRect(-52, 49, 18, 3); c.fillRect(30, 42, 18, 3); c.globalAlpha = 1;
    c.restore();
    c.beginPath(); c.moveTo(-74, -48); c.bezierCurveTo(-80, 30, -62, 88, -12, 112); c.lineTo(14, 112); c.bezierCurveTo(56, 90, 76, 30, 74, -48); c.lineWidth = 4; c.strokeStyle = INK; c.stroke();
    // ear + sideburns + bangs
    oval(c, -78, 12, 12, 22, SKIN_SH); line(c, [[-70, -6], [-90, 4], [-88, 28], [-72, 34]], INK, 3);
    fill(c, [[-74, -50], [-60, -50], [-66, 6], [-76, 2]], '#1d1418'); fill(c, [[74, -50], [60, -50], [66, 6], [76, 2]], '#1d1418');
    fill(c, [[-60, -52], [-40, -18], [-30, -50], [-10, -14], [0, -50], [22, -20], [30, -52]], '#1d1418');
    // brows
    const bw = o.mouth === 'gasp' ? -10 : o.empty ? 6 : 0;
    line(c, [[-60, -26 + bw * .3], [-36, -32 - bw], [-12, -27]], INK, 6); line(c, [[12, -28], [36, -33 - bw], [60, -28 + bw * .3]], INK, 6);
    animeEye(c, -33, 6, -1, o, t); animeEye(c, 33, 4, 1, o, t);
    // nose & mouth
    line(c, [[4, 20], [10, 44], [0, 48]], '#6a3b28', 3);
    const tr = o.tremble ? Math.sin(t * 40) * 1.5 : 0;
    if (o.mouth === 'gasp') { oval(c, 2, 82 + tr, 14, 12 + tr, '#3a1418'); oval(c, 2, 88 + tr, 8, 4, '#a24a4a'); line(c, [[-12, 78], [16, 78]], INK, 2); }
    else if (o.mouth === 'open') { oval(c, 2, 80, 10, 6, '#3a1418'); }
    else line(c, [[-16, 80], [2, 78], [18, 81]], '#5a2e26', 3);
    if (o.sweat) for (let i = 0; i < 3; i++) { const p = (t * .5 + i * .33) % 1; const sx = [58, -64, 48][i], sy = -20 + p * 70; fill(c, [[sx, sy - 8], [sx - 4, sy + 2], [sx, sy + 6], [sx + 4, sy + 2]], '#d8ecf6'); line(c, [[sx, sy - 8], [sx - 4, sy + 2], [sx, sy + 6], [sx + 4, sy + 2], [sx, sy - 8]], '#5a7a9a', 1.2); }
    c.save(); c.translate(0, -26); hat(c, s, t, -.03); c.restore();
    c.restore();
  }

  // ---------- shots ----------
  const SHOTS = window.JorgeEpilogue.shots;
  function afterglow(c, t, p) {
    vgrad(c, [[0, '#0b0f2a'], [.55, '#2a1f4a'], [.8, '#6b3a4a'], [1, '#d98a4a']], 0, 380);
    stars(c, t, 120, 300);
    for (const [ft, fx, fy, col] of [[.3, 220, 120, '#ffd979'], [1.6, 720, 90, '#ff8ab0'], [3.1, 470, 140, '#9fe0ff']]) { const k = clamp((t - ft) / 2.4); if (k <= 0 || k >= 1) continue; c.save(); c.globalAlpha = (1 - k) * .9; for (let i = 0; i < 26; i++) { const a = i / 26 * Math.PI * 2, r = ease(k) * 70; circ(c, fx + Math.cos(a) * r, fy + Math.sin(a) * r + k * k * 30, 2, col); } c.restore(); }
    c.fillStyle = '#120f22'; path(c, [[0, 380], [0, 330], [140, 300], [300, 320], [460, 290], [640, 315], [800, 295], [960, 320], [960, 380]]); c.fill();
    for (let i = 0; i < 40; i++) { c.fillStyle = rnd(i) > .5 ? '#ffd27a' : '#ffb35a'; c.globalAlpha = .5 + .5 * Math.sin(t * 2 + i); c.fillRect(rnd(i * 3) * W, 320 + rnd(i * 5) * 50, 2, 2); } c.globalAlpha = 1;
    vgrad(c, [[0, '#1b1426'], [1, '#07050c']], 380, H);
    for (let i = 0; i < 60; i++) { c.fillStyle = ['#ff6b8a', '#ffd979', '#7ad3ff', '#9eea7a'][i % 4]; c.globalAlpha = .55; c.save(); c.translate(rnd(i) * W, 400 + rnd(i * 3) * 130); c.rotate(rnd(i * 7) * 6); c.fillRect(-3, -1.5, 6, 3); c.restore(); } c.globalAlpha = 1;
    // Da Roça from behind, rim-lit by the last glow.
    const x = lerp(520, 470, smooth(p)), y = 470;
    c.save(); c.translate(x, y); c.scale(1.1, 1.1);
    fill(c, [[-70, 0], [-60, -120], [-30, -150], [30, -150], [60, -120], [70, 0]], '#2a1a14');
    line(c, [[-60, -120], [-30, -150], [30, -150], [60, -120]], '#ffb35a', 3);
    fill(c, [[-60, -120], [-80, -60], [-70, 0], [-60, 0]], '#3a2418'); oval(c, 0, -170, 34, 30, '#1d1418');
    oval(c, 0, -196, 92, 18, '#3a2c18'); line(c, [[-92, -196], [-40, -212], [40, -212], [92, -196]], '#ffcf7a', 2); fill(c, [[-42, -200], [-34, -240], [34, -240], [42, -200]], '#4a3820'); line(c, [[-34, -240], [34, -240]], '#ffcf7a', 2);
    c.restore();
    glow(c, 480, 380, 380, 'rgba(255,150,90,A)', .18);
    tracked(c, 'DEPOIS DO ÚLTIMO PEDAÇO', W / 2, 60, 10, '#c9b2d8', 5);
    subtitle(c, 'Da Roça', 'Pera… acabou?', smooth((t - 1.1) / 1));
  }
  function empty(c, t, p) {
    vgrad(c, [[0, '#0a0d24'], [1, '#1a1030']]);
    stars(c, t, 60, 300); circ(c, 720, 150, 70, '#e8e6f6'); circ(c, 742, 140, 66, '#0f0f28'); glow(c, 700, 160, 220, 'rgba(180,190,255,A)', .2);
    for (let i = 0; i < 24; i++) { const k = (t * .12 + rnd(i)) % 1; c.save(); c.translate(W + 40 - k * (W + 120), 60 + rnd(i * 3) * 380 + Math.sin(t * 2 + i) * 14); c.rotate(t * 2 + i); c.fillStyle = i % 3 ? '#f2e6d0' : '#ffd0d8'; c.globalAlpha = .7; c.fillRect(-5, -3, 10, 6); c.restore(); }
    head(c, 470, 300 + Math.sin(t * .8) * 3, lerp(1.25, 1.42, ease(p)), t, { empty: true, open: .8, pupil: .5, look: -.4, tilt: -.04 });
    c.save(); c.globalCompositeOperation = 'screen'; line(c, [[620, 200], [640, 300], [610, 420]], 'rgba(170,190,255,.5)', 4); c.restore();
    subtitle(c, 'Da Roça', 'Pq eu ainda me sinto vazio?', smooth((t - .5) / 1.2));
  }
  function vibration(c, t, p) {
    const buzz = Math.abs(Math.sin(t * 22)) > .4 ? 1 : 0;
    c.save(); shake(c, buzz * 2.5, t);
    vgrad(c, [[0, '#1c2a52'], [1, '#0e1530']]);
    for (let y = 0; y < H; y += 6) { c.fillStyle = y % 12 ? '#22325e' : '#1a2850'; c.fillRect(0, y, W, 3); }
    c.save(); c.globalAlpha = .25; for (let x = 0; x < W; x += 5) { c.fillStyle = '#3a4c80'; c.fillRect(x, 0, 1, H); } c.restore();
    fill(c, [[250, 120], [720, 100], [740, 470], [230, 480]], '#203060'); line(c, [[250, 120], [720, 100], [740, 470], [230, 480], [250, 120]], '#d8a05a', 3);
    for (let i = 0; i < 26; i++) { c.fillStyle = '#d8a05a'; c.fillRect(260 + i * 18, 132 - i * .8, 8, 2); }
    const lightA = .25 + .4 * buzz; glow(c, 480, 300, 220, 'rgba(140,180,255,A)', lightA);
    c.save(); c.globalCompositeOperation = 'screen'; c.globalAlpha = .35 + .35 * buzz; c.fillStyle = '#7fa6ff'; c.beginPath(); c.roundRect(418, 196, 124, 220, 18); c.fill(); c.globalAlpha = .5; c.fillStyle = '#cfe0ff'; c.fillRect(452, 214, 56, 8); c.restore();
    c.save(); c.globalAlpha = .45; c.strokeStyle = '#0c1430'; c.lineWidth = 2; for (let i = 0; i < 6; i++) { c.beginPath(); c.moveTo(420, 230 + i * 34); c.quadraticCurveTo(480, 222 + i * 34 + Math.sin(t * 30) * 2, 540, 232 + i * 34); c.stroke(); } c.restore();
    c.restore();
    for (const side of [-1, 1]) for (let i = 0; i < 3; i++) { const xx = 480 + side * (140 + i * 26 + buzz * 6); line(c, [[xx, 230 + i * 10], [xx + side * 14, 270], [xx, 310], [xx + side * 14, 350]], '#ffffff', 3); }
    c.save(); c.translate(480, 470); c.rotate(-.06); c.font = 'italic 900 64px Space,Arial,sans-serif'; c.textAlign = 'center'; c.lineWidth = 8; c.strokeStyle = INK; c.strokeText('VRRR…', 0, 0); c.fillStyle = '#ffe36b'; c.fillText('VRRR…', buzz * 3, 0); c.restore();
  }
  function phoneBody(c, x, y, s, rot, t, o = {}) {
    c.save(); c.translate(x, y); c.rotate(rot); c.scale(s, s);
    glow(c, 0, 0, 260, 'rgba(120,160,255,A)', .35);
    fill(c, [[-92, -176], [92, -176], [92, 176], [-92, 176]], '#0e0f16');
    c.beginPath(); c.roundRect(-96, -180, 192, 360, 22); c.lineWidth = 6; c.strokeStyle = '#3a3e4c'; c.stroke();
    const g = c.createLinearGradient(0, -160, 0, 160); g.addColorStop(0, '#2b3c74'); g.addColorStop(1, '#141c38'); c.fillStyle = g; c.beginPath(); c.roundRect(-84, -166, 168, 332, 14); c.fill();
    c.fillStyle = '#0e0f16'; c.beginPath(); c.roundRect(-28, -160, 56, 12, 6); c.fill();
    c.textAlign = 'center'; c.fillStyle = '#c8d4ff'; c.font = '600 11px Space,Arial,sans-serif'; c.fillText('CHAMADA RECEBIDA', 0, -118);
    c.fillStyle = '#ffffff'; c.font = '800 38px Space,Arial,sans-serif'; c.fillText(o.name || 'JORGE', 0, -76);
    circ(c, 0, 0, 34, '#3a4a80'); circ(c, 0, -8, 12, '#c8d4ff'); oval(c, 0, 20, 20, 12, '#c8d4ff');
    const pulse = (t * 1.6) % 1; c.save(); c.globalAlpha = 1 - pulse; c.strokeStyle = '#9fc3ff'; c.lineWidth = 2; c.beginPath(); c.arc(0, 0, 34 + pulse * 30, 0, Math.PI * 2); c.stroke(); c.restore();
    circ(c, -44, 110, 20, '#d8434a'); circ(c, 44, 110, 20, '#3fb07a'); line(c, [[-52, 114], [-44, 106], [-36, 114]], '#fff', 3); line(c, [[36, 106], [44, 114], [52, 106]], '#fff', 3);
    c.save(); c.globalAlpha = .12; fill(c, [[-84, -60], [84, -150], [84, -110], [-84, -20]], '#ffffff'); c.restore();
    if (o.crack) { c.save(); c.globalAlpha = o.crack; c.strokeStyle = '#e8f0ff'; c.lineWidth = 1.6; for (let i = 0; i < 9; i++) { const a = i / 9 * Math.PI * 2 + .3; c.beginPath(); c.moveTo(20, 40); let px = 20, py = 40; for (let k = 0; k < 4; k++) { px += Math.cos(a + (rnd(i * 4 + k) - .5)) * 26; py += Math.sin(a + (rnd(i * 5 + k) - .5)) * 26; c.lineTo(px, py); } c.stroke(); } c.restore(); }
    c.restore();
  }
  function hand(c, x, y, s, rot) {
    c.save(); c.translate(x, y); c.rotate(rot); c.scale(s, s);
    fill(c, [[-60, 60], [-40, -10], [40, -14], [70, 60], [60, 220], [-50, 220]], SKIN); fill(c, [[20, -14], [70, 60], [60, 220], [30, 220]], SKIN_SH);
    for (let i = 0; i < 4; i++) { const fx = -40 + i * 26; fill(c, [[fx, -10], [fx + 4, -60 + i * 4], [fx + 20, -64 + i * 4], [fx + 22, -12]], i === 3 ? SKIN_SH : SKIN); line(c, [[fx, -10], [fx + 4, -60 + i * 4], [fx + 20, -64 + i * 4], [fx + 22, -12]], INK, 3); }
    line(c, [[-60, 60], [-40, -10], [40, -14], [70, 60]], INK, 3);
    fill(c, [[-60, 200], [70, 200], [80, 260], [-70, 260]], SHIRT); fill(c, [[20, 200], [70, 200], [80, 260], [30, 260]], SHIRT_SH);
    c.restore();
  }
  function reach(c, t, p) {
    vgrad(c, [[0, '#090b18'], [1, '#121630']]); bokeh(c, t, 18, '#6a8cff', 3);
    const k = ease(p * 1.15), y = lerp(640, 260, k);
    c.save(); c.translate(480, 270); c.rotate(-.08); c.translate(-480, -270);
    phoneBody(c, 500, y, .9, lerp(.25, -.06, k), t);
    hand(c, 470, y + 120, 1.05, lerp(.25, -.06, k));
    c.restore();
    for (let i = 0; i < 30; i++) { const k2 = (t * .2 + rnd(i)) % 1; c.globalAlpha = .5 * (1 - k2); c.fillStyle = '#bcd0ff'; c.fillRect(rnd(i * 3) * W, H - k2 * H, 2, 2); } c.globalAlpha = 1;
  }
  function caller(c, t, p) {
    vgrad(c, [[0, '#06070f'], [1, '#0c1020']]);
    for (let i = 0; i < 4; i++) { const k = (t * .6 + i / 4) % 1; c.save(); c.globalAlpha = (1 - k) * .4; c.strokeStyle = '#8fb0ff'; c.lineWidth = 3; c.beginPath(); c.ellipse(480, 270, 140 + k * 360, 190 + k * 300, 0, 0, Math.PI * 2); c.stroke(); c.restore(); }
    const z = lerp(1.05, 1.35, smooth((p - .65) / .35));
    c.save(); c.translate(480, 270); c.scale(z, z); c.translate(-480, -270);
    phoneBody(c, 480, 280, 1.15, 0, t);
    c.save(); c.globalAlpha = .1; c.translate(500, 250); oval(c, 0, -40, 60, 12, '#ffffff'); fill(c, [[-30, -44], [-24, -80], [24, -80], [30, -44]], '#ffffff'); oval(c, 0, 0, 34, 44, '#ffffff'); c.restore();
    c.restore();
  }
  function recognition(c, t, p) {
    const impact = t < .5 ? clamp((t - .28) / .06) * (1 - clamp((t - .36) / .12)) : 0, shrink = smooth((t - .3) / .25);
    vgrad(c, [[0, '#2a0610'], [1, '#05020a']]);
    speedLines(c, 480, 270, 140, 200, '#ff5a6a', .35 + .3 * shrink, t, 4);
    c.save(); if (t > .3) shake(c, 3 * (1 - clamp((t - .3) / 2)), t);
    // extreme close-up of one eye
    c.save(); c.translate(480, 250); c.scale(6.2, 6.2);
    c.fillStyle = SKIN; c.fillRect(-90, -50, 180, 100); c.fillStyle = SKIN_SH; c.fillRect(34, -50, 60, 100);
    line(c, [[-42, -30], [-8, -36], [36, -31]], INK, 5);
    animeEye(c, 0, 0, 1, { open: 1.6, pupil: lerp(.85, .18, shrink), look: 0, reflect: shrink > .5, tremble: shrink > .5 }, t);
    if (shrink > .5) { c.fillStyle = '#cfe0ff'; c.font = '800 3px Space,Arial,sans-serif'; c.textAlign = 'center'; c.globalAlpha = .8; c.fillText('JORGE', 0, 2); c.globalAlpha = 1; }
    for (let i = 0; i < 2; i++) { const sx = 40 + i * 8, sy = -16 + ((t * 10 + i * 9) % 24); fill(c, [[sx, sy - 7], [sx - 4, sy + 2], [sx, sy + 6], [sx + 4, sy + 2]], '#d8ecf6'); }
    c.restore(); c.restore();
    if (impact > 0) { c.save(); c.globalAlpha = impact; c.fillStyle = '#ffffff'; c.fillRect(0, 0, W, H); c.restore(); }
    subtitle(c, 'Da Roça', 'JORGE…', smooth((t - .7) / .5));
  }
  function tremor(c, t, p) {
    const beat = Math.max(0, Math.sin(t * 7.5)) ** 6;
    vgrad(c, [[0, '#14081a'], [1, '#05030a']]);
    c.save(); c.globalAlpha = .18; c.strokeStyle = '#6a3a8a'; c.lineWidth = 1; for (let i = -20; i < 40; i++) { c.beginPath(); c.moveTo(i * 30 + Math.sin(t * 3 + i) * 6, 0); c.lineTo(i * 30 - 300, H); c.stroke(); } c.restore();
    c.save(); shake(c, 1.6 + beat * 2, t);
    head(c, 430, 280, 1.15, t, { open: 1.25, pupil: .16, sweat: true, mouth: 'gasp', tremble: true, look: .2 });
    c.restore();
    c.save(); const hx = 760 + Math.sin(t * 55) * 4, hy = 470 + Math.cos(t * 49) * 3; phoneBody(c, hx, hy - 120, .45, -.3 + Math.sin(t * 40) * .03, t); hand(c, hx - 10, hy - 50, .55, -.3 + Math.sin(t * 40) * .03); c.restore();
    c.save(); c.globalAlpha = .28 * beat; const g = c.createRadialGradient(480, 270, 120, 480, 270, 560); g.addColorStop(0, 'rgba(160,0,30,0)'); g.addColorStop(1, 'rgba(160,0,30,1)'); c.fillStyle = g; c.fillRect(0, 0, W, H); c.restore();
  }
  function falling(c, t, p) {
    vgrad(c, [[0, '#04050c'], [1, '#0d0f1e']]);
    const contact = 1.95, fall = clamp(t / contact), slow = fall < .8 ? fall * .7 : .56 + (fall - .8) * 2.2;
    for (let i = 0; i < 30; i++) { c.globalAlpha = .4; c.fillStyle = '#9fb8ff'; c.fillRect(rnd(i) * W, (rnd(i * 4) * H - t * 20 * rnd(i * 2)) % H, 2, 2); } c.globalAlpha = 1;
    // floor
    vgrad(c, [[0, '#0b0d18'], [1, '#141830']], 440, H); c.fillStyle = '#1e2546'; c.fillRect(0, 440, W, 2);
    // silhouette legs buckling in the background
    { const knee = smooth((t - .9) / 1.4); c.save(); c.globalAlpha = .55 + .4 * knee; c.translate(-140, lerp(-60, 0, knee)); c.filter = 'none'; kneel(c, t); c.restore(); }
    if (t < contact) {
      const y = lerp(60, 410, Math.min(1, slow)), rot = t * 2.6;
      for (let i = 1; i < 6; i++) { c.save(); c.globalAlpha = .12 * (6 - i) / 6; phoneBody(c, 620, y - i * 26, .4, rot - i * .18, t); c.restore(); }
      phoneBody(c, 620, y, .4, rot, t);
      speedLines(c, 620, y, 50, 140, '#ffffff', .12, t, 9);
    } else {
      const k = clamp((t - contact) / .5);
      phoneBody(c, 620, 420, .4, Math.PI / 2 + .1, t, { crack: smooth(k * 2) });
      if (k < 1) { c.save(); c.globalAlpha = 1 - k; c.strokeStyle = '#d8e6ff'; c.lineWidth = 3; for (let i = 0; i < 10; i++) { const a = Math.PI + i / 9 * Math.PI; line(c, [[620 + Math.cos(a) * 30 * (1 + k * 3), 440 + Math.sin(a) * 12 * (1 + k)], [620 + Math.cos(a) * 60 * (1 + k * 3), 440 + Math.sin(a) * 24 * (1 + k)]], '#d8e6ff', 3); } c.restore(); }
      if (t - contact < .08) { c.fillStyle = '#ffffff'; c.globalAlpha = .8; c.fillRect(0, 0, W, H); c.globalAlpha = 1; }
    }
  }
  function kneeling(c, t, p) {
    vgrad(c, [[0, '#0a0c18'], [1, '#141a2e']]);
    // spotlight cone
    c.save(); c.globalCompositeOperation = 'screen'; const g = c.createLinearGradient(0, 0, 0, H); g.addColorStop(0, 'rgba(180,200,255,.22)'); g.addColorStop(1, 'rgba(180,200,255,0)'); c.fillStyle = g; path(c, [[440, -10], [520, -10], [640, 470], [320, 470]]); c.fill(); c.restore();
    vgrad(c, [[0, '#0b0e1c'], [1, '#05060c']], 440, H);
    // puddle reflection
    c.save(); c.globalAlpha = .35; c.translate(0, 880); c.scale(1, -1); kneel(c, t); c.restore();
    c.fillStyle = 'rgba(10,12,24,.55)'; c.fillRect(0, 442, W, H - 442);
    for (let i = 0; i < 8; i++) { const k = (t * .7 + i / 8) % 1; c.save(); c.globalAlpha = (1 - k) * .5; c.strokeStyle = '#9fb8e8'; c.lineWidth = 1; c.beginPath(); c.ellipse(rnd(i) * W, 460 + rnd(i * 3) * 70, 4 + k * 26, 1 + k * 5, 0, 0, Math.PI * 2); c.stroke(); c.restore(); }
    kneel(c, t);
    phoneBody(c, 690, 450, .3, Math.PI / 2 + .1, t, { crack: 1 });
    rain(c, t, 260, .5);
    const dark = smooth((t - 2.4) / 3.1); c.fillStyle = `rgba(2,2,7,${dark * .95})`; c.fillRect(0, 0, W, H);
  }
  function kneel(c, t) {
    c.save(); c.translate(480, 440); const breathe = Math.sin(t * 1.4) * 2;
    fill(c, [[-60, 0], [-50, -50], [-20, -62], [30, -62], [60, -40], [70, 0]], '#0a0b14');
    fill(c, [[-40, -60], [-46, -150 + breathe], [-10, -170 + breathe], [30, -165 + breathe], [44, -120], [40, -60]], '#0e0f1c');
    line(c, [[-46, -150 + breathe], [-10, -170 + breathe], [30, -165 + breathe]], '#7a90c8', 2);
    oval(c, -6, -184 + breathe, 22, 20, '#0e0f1c');
    oval(c, -6, -196 + breathe, 66, 13, '#1a1622'); line(c, [[-72, -196 + breathe], [-30, -207 + breathe], [20, -207 + breathe], [60, -196 + breathe]], '#9fb4e8', 2);
    fill(c, [[-34, -202 + breathe], [-28, -232 + breathe], [18, -232 + breathe], [24, -202 + breathe]], '#1a1622');
    fill(c, [[-46, -140 + breathe], [-70, -70], [-60, -20], [-50, -24], [-56, -70], [-34, -120]], '#0e0f1c');
    fill(c, [[34, -140 + breathe], [62, -70], [56, -20], [46, -24], [48, -70], [26, -120]], '#0e0f1c');
    c.restore();
  }
  function eyes(c, t, p) {
    c.fillStyle = '#020106'; c.fillRect(0, 0, W, H);
    const flashT = t % 3.3, flash = flashT < .08 || (flashT > .16 && flashT < .22);
    if (flash) { c.fillStyle = 'rgba(120,80,200,.35)'; c.fillRect(0, 0, W, H); c.save(); c.globalAlpha = .9; c.fillStyle = '#010003'; path(c, [[330, H], [360, 260], [420, 180], [540, 180], [600, 260], [630, H]]); c.fill(); oval(c, 480, 160, 50, 46, '#010003'); oval(c, 480, 128, 140, 22, '#010003'); c.restore(); line(c, [[700, 0], [660, 90], [690, 120], [620, 260]], '#e6d8ff', 3); }
    const open = smooth((t - .35) / 1.4);
    for (const [x, dir] of [[330, 1], [630, -1]]) {
      c.save(); c.translate(x, 190);
      glow(c, 0, 0, 160, 'rgba(170,80,255,A)', .35 * open);
      const h = 26 * open; path(c, [[-90, 6 * dir], [-40, -h], [50, -h * .8], [92, -4 * dir], [40, h * .55], [-50, h * .5]]); c.fillStyle = '#b06aff'; c.fill(); c.save(); c.clip();
      const g = c.createRadialGradient(0, 0, 2, 0, 0, 60); g.addColorStop(0, '#f2e0ff'); g.addColorStop(.4, '#c084ff'); g.addColorStop(1, '#5a1a9a'); c.fillStyle = g; c.fillRect(-100, -40, 200, 80);
      oval(c, Math.sin(t * .6) * 6, 0, 5, h * .9, '#120018'); c.restore();
      line(c, [[-96, 6 * dir], [-40, -h - 3], [50, -h * .8 - 3], [98, -4 * dir]], '#1a0028', 6);
      c.restore();
    }
    const words = smooth((t - 1.8) / 1.8); c.save(); c.globalAlpha = words; c.textAlign = 'center';
    c.font = '800 40px Space,Arial,sans-serif'; c.fillStyle = '#efe6ff'; c.fillText('FIM DE JOGO', 480, 360);
    c.font = '400 18px Space,Arial,sans-serif'; c.fillStyle = '#b39ad0'; c.fillText('aguardando nova atualização…', 480, 400);
    tracked(c, 'UM NOVO CAPÍTULO VAI COMEÇAR', 480, 448, 9, '#7a6690', 4); c.restore();
  }
  const RENDER = { afterglow, empty, vibration, reach, caller, recognition, tremor, falling, kneeling, eyes };

  function draw(c, s) {
    if (!c || !s) return;
    const index = clamp(Math.floor(Number(s.index) || 0), 0, SHOTS.length - 1), shot = SHOTS[index], t = Math.max(0, Number(s.time) || 0), p = clamp(t / shot.duration);
    c.save(); c.imageSmoothingEnabled = true; c.fillStyle = '#000'; c.fillRect(0, 0, W, H);
    (RENDER[shot.id] || eyes)(c, t, p);
    // cut-in fade from black on every shot, like an edited sequence
    const fadeIn = 1 - smooth(t / .25); if (fadeIn > 0 && index > 0) { c.fillStyle = `rgba(0,0,0,${fadeIn})`; c.fillRect(0, 0, W, H); }
    c.restore();
  }
  window.JorgeAnime = Object.freeze({ draw });
})();
