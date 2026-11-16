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

  // ---------- Fighter animation layer: smears, hit flash, tumble, flips, squash, ghosts ----------
  const hist = new Map();
  const OX = 130, OY = 180, buf = document.createElement('canvas'); buf.width = 260; buf.height = 230; const bx = buf.getContext('2d');
  function flash(c, p, t, alpha) {
    bx.setTransform(1, 0, 0, 1, 0, 0); bx.globalCompositeOperation = 'source-over'; bx.globalAlpha = 1; bx.clearRect(0, 0, 260, 230);
    A.drawFighter(bx, { ...p, x: OX, y: OY }, t);
    bx.globalCompositeOperation = 'source-in'; bx.fillStyle = '#ffffff'; bx.fillRect(0, 0, 260, 230); bx.globalCompositeOperation = 'source-over';
    c.save(); c.globalAlpha *= alpha; c.drawImage(buf, Math.round(p.x) - OX, Math.round(p.y) - OY); c.restore();
  }
  function smear(c, p, color) {
    const prog = Number(p.attackProgress) || 0; if (!(p.attackAnim > 0) || prog < .16 || prog > .72) return;
    const k = (prog - .16) / .56, face = p.facing < 0 ? -1 : 1, dir = p.attackDirection || 'side', ranged = p.attackType === 'ranged', combo = p.attackType === 'combo';
    const cx = p.x + face * (ranged ? 10 : 16), cy = p.y - 36, r = ranged ? 26 : combo ? 50 : 40;
    let a0, a1; if (dir === 'up') { a0 = Math.PI * 1.05; a1 = Math.PI * 1.95; } else if (dir === 'down') { a0 = Math.PI * .05; a1 = Math.PI * .95; } else { a0 = -1.1; a1 = 1.0; }
    if (face < 0 && dir !== 'up' && dir !== 'down') { a0 = Math.PI - 1.0; a1 = Math.PI + 1.1; }
    const head = a0 + (a1 - a0) * Math.min(1, k * 1.4), tail = a0 + (a1 - a0) * Math.max(0, k * 1.4 - .55);
    c.save(); c.globalAlpha = (1 - k) * .9;
    for (let i = 0; i < 3; i++) { c.beginPath(); c.arc(cx, cy, r - i * 6, tail, head); c.lineWidth = (3 - i) * 4 * (1 - k * .5); c.strokeStyle = i === 0 ? '#ffffff' : color; c.lineCap = 'round'; c.stroke(); }
    c.restore();
  }
  function fighter(c, p, t) {
    if (!p || p.stocks === 0 || p.eliminated) return A.drawFighter(c, p, t);
    const id = p.id || p.character, h = hist.get(id) || { ghosts: [], spin: 0, lastT: t, puffs: [] }; hist.set(id, h);
    const dt = Math.max(0, Math.min(.05, t - h.lastT)); h.lastT = t;
    const vx = Number(p.vx) || 0, vy = Number(p.vy) || 0, speed = Math.hypot(vx, vy), air = !p.ground, launched = air && ((p.launch || 0) > 0 || (p.stun || 0) > 0) && speed > 330;
    const motion = p.motion || 'idle', mt = Number(p.motionTime) || 0, color = window.ArenaRoster?.get?.(p.character)?.color || '#ffd27a';
    // ghosts on dodge/dash and on big launches
    if ((motion === 'dash' || launched) && (!h.ghosts.length || t - h.ghosts[h.ghosts.length - 1].t > .035)) { h.ghosts.push({ ...p, t, a: .32 }); if (h.ghosts.length > 5) h.ghosts.shift(); }
    for (const g of h.ghosts) g.a -= dt * 1.6; h.ghosts = h.ghosts.filter(g => g.a > 0);
    for (const g of h.ghosts) { c.save(); c.globalAlpha *= g.a; A.drawFighter(c, { ...g, hit: 0, attackAnim: 0 }, t); c.restore(); }
    // smoke trail while flying from a hit
    if (launched && Math.random() < .7) { h.puffs.push({ x: p.x, y: p.y - 30, life: .5, r: 5 + Math.random() * 5 }); if (h.puffs.length > 24) h.puffs.shift(); }
    for (const q of h.puffs) { q.life -= dt; q.r += dt * 18; } h.puffs = h.puffs.filter(q => q.life > 0);
    c.save(); for (const q of h.puffs) { c.globalAlpha = q.life * .8; c.fillStyle = '#eef2f4'; c.beginPath(); c.arc(q.x, q.y, q.r, 0, Math.PI * 2); c.fill(); c.globalAlpha = q.life * .5; c.fillStyle = '#cfd6da'; c.beginPath(); c.arc(q.x + 2, q.y + 2, q.r * .6, 0, Math.PI * 2); c.fill(); } c.restore();
    // body transform: tumble, flip, squash & stretch (pivot at the feet / body centre)
    let rot = 0, sx = 1, sy = 1, jx = 0;
    if (launched) { h.spin += (vx / 260) * dt * 6; rot = h.spin; } else h.spin *= .8;
    if (motion === 'doubleJump' && mt < .32) rot = (p.facing < 0 ? -1 : 1) * (mt / .32) * Math.PI * 2;
    if (motion === 'land' && mt < .14) { const k = 1 - mt / .14; sy = 1 - .16 * k; sx = 1 + .14 * k; }
    else if (air && !launched && vy < -150) { sy = 1.07; sx = .95; }
    else if (motion === 'run') { sy = 1 + Math.sin(t * 22) * .025; }
    if ((p.hit || 0) > 0) jx = (Math.random() - .5) * 5;
    c.save();
    if (rot) { c.translate(p.x, p.y - 34); c.rotate(rot); c.translate(-p.x, -(p.y - 34)); }
    if (sx !== 1 || sy !== 1) { c.translate(p.x, p.y); c.scale(sx, sy); c.translate(-p.x, -p.y); }
    if (jx) c.translate(jx, 0);
    A.drawFighter(c, p, t);
    if ((p.hit || 0) > 0) flash(c, p, t, Math.min(.85, (p.hit || 0) / .18));
    c.restore();
    smear(c, p, color);
  }

  window.ArenaArt = Object.freeze({
    ...A,
    drawBackground(c, camera, t, W = 960, H = 540) { A.drawBackground(c, camera, t, W, H); if (!lite()) { try { sky(c, camera, Number(t) || 0, W, H); } catch (e) {} } },
    drawStage(c, platforms, t) { A.drawStage(c, platforms, t); if (!lite()) { try { stage(c, platforms, Number(t) || 0); } catch (e) {} } },
    drawFighter(c, p, t) { if (lite()) return A.drawFighter(c, p, t); try { fighter(c, p, Number(t) || 0); } catch (e) { A.drawFighter(c, p, t); } }
  });
  window.ArenaFx = Object.freeze({ version: 1 });
})();
