/* Boss arenas, staged for a fight (realistic/shader modes): a cheering crowd, sweeping
   spotlights, themed weather and particles, floor reflection and vignette. It paints over
   the original arena background only; fighters, hitboxes and timing are untouched. */
(() => {
  'use strict';
  if (!window.Art || !window.Art.drawArena || window.BossArena) return;
  const orig = window.Art.drawArena;
  const rnd = (n) => { const x = Math.sin(n * 78.233 + 12.9898) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const THEME = {
    igor: { light: '255,190,120', crowd: '#22344a', parts: 'steam', spot: true },
    kaique: { light: '255,90,90', crowd: '#22344a', parts: 'paper', spot: true, alarm: true },
    arthur: { light: '255,220,150', crowd: '#24384e', parts: 'leaves', spot: false, chant: true },
    marco: { light: '255,80,110', crowd: null, parts: 'ink', spot: true },
    menezes: { light: '255,200,230', crowd: '#2a1a24', parts: 'rats', spot: true },
    nikolas: { light: '170,230,90', crowd: null, parts: 'slime', spot: false, storm: true },
    reeisBoss: { light: '255,210,110', crowd: '#3a2a26', parts: 'embers', spot: true },
    freddy: { light: '255,160,90', crowd: '#3a2a2e', parts: 'embers', spot: true },
    giant: { light: '210,170,255', crowd: null, parts: 'paperstorm', spot: false },
    nicolas: { light: '255,240,170', crowd: null, parts: 'feathers', spot: false, rays: true },
    dede: { light: '190,220,200', crowd: '#1e2a2a', parts: 'smoke', spot: true }
  };
  function cone(c, x, top, ang, len, w, rgb, a) { c.save(); c.translate(x, top); c.rotate(ang); const g = c.createLinearGradient(0, 0, 0, len); g.addColorStop(0, `rgba(${rgb},${a})`); g.addColorStop(1, `rgba(${rgb},0)`); c.fillStyle = g; c.beginPath(); c.moveTo(-8, 0); c.lineTo(8, 0); c.lineTo(w, len); c.lineTo(-w, len); c.closePath(); c.fill(); c.restore(); }
  function crowd(c, col, t, center, cheer) {
    const beat = t * 2.4;
    for (let i = 0; i < 46; i++) {
      const x = (i * 23 + (i % 3) * 7) % 1000 - 20, depth = i % 2, y = 440 - (depth ? 6 : 0), h = 44 + rnd(i) * 16 - depth * 6, jump = Math.max(0, Math.sin(beat * Math.PI + i * 1.7)) * (cheer ? 7 : 3);
      if (Math.abs(x - center) < 150 && !depth) continue; // keep the duel lane readable
      const yy = y - jump, shade = depth ? col : col + 'ee';
      R(c, x - 7, yy - h, 14, h, shade); R(c, x - 6, yy - h - 12, 12, 12, shade);
      const up = (i + Math.floor(beat)) % 3 === 0;
      R(c, x - 11, yy - h + (up ? -20 : 2), 4, up ? 22 : 16, shade); R(c, x + 7, yy - h + (up ? -22 : 4), 4, up ? 24 : 14, shade);
      if (rnd(i * 3 + Math.floor(t * 3)) > .985) { c.save(); c.globalAlpha = .9; R(c, x + 6, yy - h - 30, 5, 7, '#ffffff'); c.globalCompositeOperation = 'lighter'; const g = c.createRadialGradient(x + 8, yy - h - 27, 1, x + 8, yy - h - 27, 22); g.addColorStop(0, 'rgba(255,255,255,.6)'); g.addColorStop(1, 'rgba(255,255,255,0)'); c.fillStyle = g; c.fillRect(x - 14, yy - h - 49, 44, 44); c.restore(); }
      else if (i % 5 === 0) R(c, x + 6, yy - h - 26, 4, 6, '#9fd0ff');
    }
  }
  function particles(c, kind, t, center) {
    c.save();
    if (kind === 'steam') for (let i = 0; i < 14; i++) { const k = (t * .25 + rnd(i)) % 1; c.globalAlpha = (1 - k) * .3; R(c, 110 + rnd(i * 2) * 140 + Math.sin(t + i) * 8, 260 - k * 160, 10 + k * 14, 8 + k * 10, '#ffffff'); }
    if (kind === 'paper' || kind === 'paperstorm') { const n = kind === 'paper' ? 16 : 60; for (let i = 0; i < n; i++) { const sp = kind === 'paper' ? 40 : 160, a = t * (kind === 'paper' ? .3 : 1.4) + i; const x = kind === 'paper' ? (rnd(i) * 1100 + t * sp) % 1100 - 70 : center + Math.cos(a) * (120 + rnd(i) * 300), y = kind === 'paper' ? 80 + rnd(i * 3) * 300 + Math.sin(t * 2 + i) * 20 : 260 + Math.sin(a * 1.3) * (60 + rnd(i * 5) * 150); c.save(); c.translate(x, y); c.rotate(a * 2); c.globalAlpha = .85; R(c, -6, -4, 12, 8, '#f1ecdf'); R(c, -4, -2, 8, 1, '#9aa4b8'); R(c, -4, 1, 6, 1, '#9aa4b8'); c.restore(); } }
    if (kind === 'ink') for (let i = 0; i < 18; i++) { const x = rnd(i) * 960, len = 20 + ((t * 30 * (0.5 + rnd(i * 2))) % 160); R(c, x, 0, 4, len, '#2a0f2a'); R(c, x - 1, len - 4, 6, 6, '#3a1238'); }
    if (kind === 'rats') for (let i = 0; i < 4; i++) { const x = ((t * (120 + i * 30) + i * 300) % 1200) - 120, dir = i % 2 ? 1 : -1, xx = dir > 0 ? x : 960 - x; R(c, xx - 8, 430, 16, 7, '#5a4a52'); R(c, xx + dir * 8, 432, 5, 4, '#5a4a52'); R(c, xx - dir * 14, 434, 8, 2, '#c9a0a8'); R(c, xx + dir * 10, 432, 1, 1, '#ff5a6a'); }
    if (kind === 'slime') for (let i = 0; i < 20; i++) { const k = (t * .35 + rnd(i)) % 1; c.globalAlpha = .7; R(c, rnd(i * 2) * 960, -10 + k * 460, 5, 8, '#a6d05d'); }
    if (kind === 'embers') for (let i = 0; i < 26; i++) { const k = (t * .2 + rnd(i)) % 1; c.globalAlpha = (1 - k) * .9; R(c, rnd(i * 4) * 960 + Math.sin(t * 2 + i) * 14, 440 - k * 380, 3, 3, i % 3 ? '#ffb347' : '#ffe08a'); }
    if (kind === 'feathers') for (let i = 0; i < 16; i++) { const k = (t * .08 + rnd(i)) % 1; c.save(); c.translate(rnd(i * 3) * 960 + Math.sin(t + i) * 30, k * 460); c.rotate(Math.sin(t * 2 + i) * .8); c.globalAlpha = .8; R(c, -2, -8, 4, 16, '#fff8e0'); R(c, -5, -6, 3, 10, '#f2e6c0'); c.restore(); }
    if (kind === 'smoke') for (let i = 0; i < 10; i++) { const x = ((i * 160 + t * 18) % 1300) - 170, y = 220 + (i % 4) * 50; c.globalAlpha = .14; c.fillStyle = '#d9e4dc'; c.beginPath(); c.ellipse(x, y, 120, 34, 0, 0, Math.PI * 2); c.fill(); }
    if (kind === 'leaves') for (let i = 0; i < 12; i++) { const k = (t * .1 + rnd(i)) % 1; c.globalAlpha = .9; R(c, (rnd(i) * 960 + t * 30) % 960, k * 440, 5, 3, i % 2 ? '#7aa84a' : '#c9a24a'); }
    c.restore();
  }
  function overlay(c, type, camera, t, homeX, hd) {
    const th = type && typeof type === 'object' && type.light ? type : THEME[type]; if (!th) return;
    const center = homeX ? homeX - camera : 480;
    c.save();
    if (th.storm) { if (!hd) { const g = c.createLinearGradient(0, 0, 0, 300); g.addColorStop(0, 'rgba(20,40,10,.6)'); g.addColorStop(1, 'rgba(20,40,10,0)'); c.fillStyle = g; c.fillRect(0, 0, 960, 300); }
      for (let i = 0; i < (hd ? 0 : 6); i++) { c.globalAlpha = .35; c.fillStyle = '#1e2e14'; c.beginPath(); c.ellipse(((i * 210 + t * 22) % 1300) - 170, 40 + (i % 3) * 30, 160, 40, 0, 0, Math.PI * 2); c.fill(); }
      c.globalAlpha = 1; const ph = t % 4.2; if (ph < .1) { c.fillStyle = 'rgba(210,255,170,.35)'; c.fillRect(0, 0, 960, 540); c.strokeStyle = '#e8ffd0'; c.lineWidth = 3; c.beginPath(); let x = 200 + (Math.floor(t / 4.2) * 337) % 600, y = 0; c.moveTo(x, y); while (y < 300) { x += (rnd(y + t) - .5) * 60; y += 30; c.lineTo(x, y); } c.stroke(); } }
    if (th.rays) { c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 10; i++) { const a = i / 10 * Math.PI * 2 + t * .12; cone(c, center, 171, a, 520, 70, th.light, .08); } c.globalCompositeOperation = 'source-over'; }
    if (th.spot) { c.globalCompositeOperation = 'lighter'; cone(c, 120, -10, -.55 + Math.sin(t * .7) * .35, 560, 90, th.light, .16); cone(c, 840, -10, .55 + Math.sin(t * .6 + 1) * .35, 560, 90, th.light, .16); cone(c, center, -10, Math.sin(t * .5) * .15, 520, 70, '255,255,255', .08); c.globalCompositeOperation = 'source-over'; }
    if (th.alarm) { const a = (Math.sin(t * 6) + 1) / 2; c.fillStyle = `rgba(255,40,40,${a * .1})`; c.fillRect(0, 0, 960, 440); R(c, 470, 92, 20, 10, a > .5 ? '#ff3a3a' : '#7a1a1a'); }
    particles(c, th.parts, t, center);
    if (th.crowd && !hd) crowd(c, th.crowd, t, center, true);
    if (th.chant) { const k = (t * .5) % 1; if (k < .6) { c.globalAlpha = 1 - k / .6; c.font = '900 22px monospace'; c.textAlign = 'center'; c.fillStyle = '#ffe36b'; c.strokeStyle = '#1a1a1a'; c.lineWidth = 4; const y = 280 - k * 30; for (const [x, s] of [[140, 'BRIGA!'], [820, 'BRIGA!'], [480, 'UUUUH!']]) { c.strokeText(s, x, y); c.fillText(s, x, y); } c.globalAlpha = 1; } }
    // floor sheen and vignette
    const fl = c.createLinearGradient(0, 440, 0, 540); fl.addColorStop(0, `rgba(${th.light},.18)`); fl.addColorStop(1, `rgba(${th.light},0)`); c.fillStyle = fl; c.fillRect(0, 440, 960, 100);
    const v = c.createRadialGradient(480, 300, 200, 480, 300, 640); v.addColorStop(0, 'rgba(0,0,0,0)'); v.addColorStop(1, 'rgba(0,0,0,.42)'); c.fillStyle = v; c.fillRect(0, 0, 960, 540);
    c.restore();
  }
  window.Art.drawArena = function (c, type, camera = 0, t = 0, homeX = 0) {
    if (window.HdMaps?.arenaHandles?.(type) && window.HdMaps.drawArena(c, type, camera, t, homeX)) {
      try { overlay(c, typeof type === 'object' ? type.type : type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0, true); } catch (e) {}
      return;
    }
    orig(c, type, camera, t, homeX);
    if (window.Graphics?.isLite?.() || window.HdScene?.active?.(type)) return;
    try { overlay(c, typeof type === 'object' ? type.type : type, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0); } catch (e) {}
  };
  // Campanha 2 (Vitória da Conquista): o mesmo palco da principal, com luz, torcida e partículas de cada vilão
  const C2 = {
    creuza: { light: '255,170,210', crowd: '#3a2430', parts: 'paper', spot: true, chant: false },
    tonhao: { light: '255,170,90', crowd: '#2a2a32', parts: 'smoke', spot: true, alarm: true },
    valdomiro: { light: '255,220,150', crowd: '#3a2a1e', parts: 'leaves', spot: true },
    kaua: { light: '200,220,255', crowd: '#20263a', parts: 'paperstorm', spot: true, rays: true },
    barao: { light: '230,180,120', crowd: '#2e2218', parts: 'steam', spot: true },
    breno: { light: '255,110,90', crowd: '#341e1e', parts: 'embers', spot: true },
    gemeos: { light: '120,240,220', crowd: '#18282a', parts: 'paper', spot: true, alarm: true },
    fred: { light: '255,230,150', crowd: '#2e2a1a', parts: 'feathers', spot: true, rays: true },
    jorge: { light: '190,150,255', crowd: null, parts: 'ink', spot: true, rays: true }
  };
  function palco(c, tema, camera = 0, t = 0, homeX = 0) { if (window.Graphics?.isLite?.()) return; try { overlay(c, C2[tema] || C2.creuza, Number(camera) || 0, Number(t) || 0, Number(homeX) || 0); } catch (e) {} }
  window.BossArena = Object.freeze({ themes: Object.keys(THEME), palco, temasC2: Object.keys(C2) });
})();
