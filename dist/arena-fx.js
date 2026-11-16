/* Arena scenery in motion (realistic/shader modes): animated sun shafts, cloud shadows,
   a drifting balloon, flocks, wind-blown petals; on the islands swaying grass, hanging
   vines, crumbling dirt, glowing crystals, waterfall mist and fireflies.
   Pure decoration: platforms, hitboxes and the fight simulation are untouched. */
(() => {
  'use strict';
  const A = window.ArenaArt;
  if (!A || window.ArenaFx) return;
  const lite = () => !!window.Graphics?.isLite?.();
  const rnd = (n) => { const x = Math.sin(n * 63.71 + 9.13) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };

  function sky(c, camera, t, W, H) {
    const cx = Number(camera?.x) || 640, sunX = W * .76 - (cx - 640) * .006, sunY = H * .17;
    c.save(); c.globalCompositeOperation = 'lighter';
    for (let i = 0; i < 7; i++) {
      const a = 1.95 + i * .13 + Math.sin(t * .23 + i * 1.7) * .05, len = H * 1.4, w = 50 + (i % 3) * 34, alpha = .03 + .02 * Math.sin(t * .6 + i * 2.1);
      c.save(); c.translate(sunX, sunY); c.rotate(a); const g = c.createLinearGradient(0, 0, len, 0); g.addColorStop(0, `rgba(255,244,200,${alpha * 1.3})`); g.addColorStop(1, 'rgba(255,244,200,0)');
      c.fillStyle = g; c.beginPath(); c.moveTo(0, -14); c.lineTo(len, -w); c.lineTo(len, w); c.lineTo(0, 14); c.closePath(); c.fill(); c.restore();
    }
    const glow = c.createRadialGradient(sunX, sunY, 4, sunX, sunY, 150); glow.addColorStop(0, 'rgba(255,240,190,.35)'); glow.addColorStop(1, 'rgba(255,240,190,0)'); c.fillStyle = glow; c.fillRect(sunX - 150, sunY - 150, 300, 300);
    c.restore();
    // hot-air balloon crossing very slowly
    const bx = ((t * 6 - cx * .03) % (W + 200) + W + 200) % (W + 200) - 100, by = H * .3 + Math.sin(t * .4) * 8;
    R(c, bx - 9, by - 22, 18, 20, '#e2445c'); R(c, bx - 11, by - 18, 22, 12, '#e2445c'); R(c, bx - 3, by - 22, 6, 20, '#ffd24b'); R(c, bx - 4, by + 2, 8, 6, '#8a5a3a'); R(c, bx - 5, by - 2, 1, 4, '#3a2a20'); R(c, bx + 4, by - 2, 1, 4, '#3a2a20');
    // V flock
    const fp = (t % 19) / 19; if (fp < .7) { const k = fp / .7, fx = W + 60 - k * (W + 160), fy = H * .22 + Math.sin(t) * 6; for (let i = 0; i < 7; i++) { const row = Math.ceil(i / 2), side = i % 2 ? 1 : -1, x = fx + row * 10, y = fy + (i ? side * row * 6 : 0), f = Math.round(Math.sin(t * 9 + i) * 2); R(c, x - 3, y - f, 3, 1, '#2f5d7a'); R(c, x, y, 2, 1, '#2f5d7a'); R(c, x + 2, y - f, 3, 1, '#2f5d7a'); } }
    // cloud shadows sliding over the lower landscape
    c.save(); for (let i = 0; i < 3; i++) { const x = ((i * 520 + t * 22) % (W + 700)) - 350, g = c.createRadialGradient(x, H * .86, 10, x, H * .86, 260); g.addColorStop(0, 'rgba(30,50,60,.16)'); g.addColorStop(1, 'rgba(30,50,60,0)'); c.fillStyle = g; c.save(); c.translate(0, H * .86); c.scale(1, .3); c.translate(0, -H * .86); c.fillRect(x - 260, H * .86 - 260, 520, 520); c.restore(); } c.restore();
    // petals and leaves on the wind (screen space, in front of the far scenery)
    for (let i = 0; i < 26; i++) { const k = (t * (.05 + rnd(i) * .05) + rnd(i * 3)) % 1, x = W + 30 - k * (W + 60), y = H * (.15 + rnd(i * 5) * .7) + Math.sin(t * 2 + i) * 18; c.save(); c.translate(x, y); c.rotate(t * 3 + i); R(c, -3, -1.5, 6, 3, i % 3 === 0 ? '#ffb7c8' : i % 3 === 1 ? '#8fcf5a' : '#ffe08a'); c.restore(); }
  }

  function stage(c, platforms, t) {
    for (const p of platforms || []) {
      const x = Number(p.x) || 0, y = Number(p.y) || 0, w = Number(p.w) || 100, main = !!p.main;
      // dense swaying grass along the top edge
      for (let gx = x + 4; gx < x + w - 4; gx += 7) { const h = 4 + rnd(gx) * 6, sw = Math.round(Math.sin(t * 2.2 + gx * .05) * 2); R(c, gx, y - h + 1, 2, h, rnd(gx + 1) > .5 ? '#3f9a3a' : '#6cc44a'); R(c, gx + sw, y - h - 1, 2, 2, '#9be36a'); }
      // vines hanging from the underside
      const depth = main ? 120 : 44;
      for (let i = 0; i < Math.max(2, Math.floor(w / 70)); i++) { const vx = x + 20 + i * (w - 40) / Math.max(1, Math.floor(w / 70) - 1 || 1), len = 18 + rnd(vx) * (main ? 60 : 26); for (let k = 0; k < len; k += 4) { const sx = Math.sin(t * 1.6 + vx + k * .08) * k * .08; R(c, vx + sx, y + depth * .3 + k, 2, 4, k % 12 === 0 ? '#7ccf5a' : '#3a7a3a'); } }
      // crumbling dirt and pebbles falling
      for (let i = 0; i < (main ? 5 : 2); i++) { const k = (t * .5 + rnd(i + x)) % 1, px = x + 20 + rnd(i * 7 + x) * (w - 40), py = y + depth * .6 + k * 140; c.globalAlpha = 1 - k; R(c, px, py, 3, 3, '#7a5a3a'); R(c, px + 4, py - 6, 2, 2, '#9a7a52'); } c.globalAlpha = 1;
      // glowing crystals under the islands
      for (let i = 0; i < (main ? 4 : 1); i++) { const cx = x + w * (.2 + i * .2), cy = y + depth * .55 + (i % 2) * 14, pulse = .5 + .5 * Math.sin(t * 2 + i); c.save(); c.globalCompositeOperation = 'lighter'; const g = c.createRadialGradient(cx, cy, 1, cx, cy, 22); g.addColorStop(0, `rgba(140,230,255,${.25 + .2 * pulse})`); g.addColorStop(1, 'rgba(140,230,255,0)'); c.fillStyle = g; c.fillRect(cx - 22, cy - 22, 44, 44); c.restore(); c.fillStyle = '#9fe8ff'; c.beginPath(); c.moveTo(cx, cy - 8); c.lineTo(cx + 4, cy); c.lineTo(cx, cy + 6); c.lineTo(cx - 4, cy); c.closePath(); c.fill(); R(c, cx - 1, cy - 5, 2, 3, '#ffffff'); }
      // waterfall mist + fireflies around the main island
      if (main) {
        for (const side of [-1, 1]) { const mx = side < 0 ? x + 40 : x + w - 40; for (let i = 0; i < 6; i++) { const k = (t * .6 + i / 6) % 1; c.globalAlpha = (1 - k) * .35; c.fillStyle = '#e6fbff'; c.beginPath(); c.ellipse(mx + Math.sin(t + i) * 10, y + 150 + k * 20, 8 + k * 16, 4 + k * 6, 0, 0, Math.PI * 2); c.fill(); } }
        c.globalAlpha = 1;
        for (let i = 0; i < 10; i++) { const fx = x + rnd(i) * w + Math.sin(t * .8 + i) * 20, fy = y - 30 - rnd(i * 2) * 120 + Math.cos(t * .9 + i) * 14, a = .4 + .6 * Math.abs(Math.sin(t * 2 + i)); c.globalAlpha = a; R(c, fx, fy, 2, 2, '#fff6a8'); } c.globalAlpha = 1;
      }
    }
  }

  window.ArenaArt = Object.freeze({
    ...A,
    drawBackground(c, camera, t, W = 960, H = 540) { A.drawBackground(c, camera, t, W, H); if (!lite()) { try { sky(c, camera, Number(t) || 0, W, H); } catch (e) {} } },
    drawStage(c, platforms, t) { A.drawStage(c, platforms, t); if (!lite()) { try { stage(c, platforms, Number(t) || 0); } catch (e) {} } }
  });
  window.ArenaFx = Object.freeze({ version: 1 });
})();
