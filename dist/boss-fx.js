/* Boss fight staging: anticipation, recoil, dash ghosts, dizzy stars, landing dust and
   projectile trails. Reads boss state only; never changes timers, damage, hitboxes,
   positions or difficulty. Light graphics mode keeps only the cheap cues. */
(() => {
  'use strict';
  const FLOOR = 440;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); };
  const COLORS = { igor: '#f2c14e', kaique: '#7fb6e8', arthur: '#f08a5d', dede: '#c9d3c4', freddy: '#f4a04a', reeisBoss: '#ffd166', marco: '#ef5d5d', giant: '#f0a35b', nicolas: '#fff0aa', menezes: '#efbfd3', nikolas: '#a6d05d' };
  const mem = new WeakMap();
  const shotTrails = new WeakMap();
  const lite = () => !!window.Graphics?.isLite?.();
  const color = (e) => COLORS[e.type] || '#ffe08b';
  const headY = (e) => e.y - (e.type === 'giant' ? 205 : e.type === 'igor' ? 92 * (e.igorScale || 1) : e.type === 'nikolas' && e.phase >= 4 ? 230 : e.rage ? 130 : 100);
  function state(e) { let m = mem.get(e); if (!m) { m = { last: e.state, age: 0, ghosts: [], motes: [], rings: [], ghostT: 0, prevY: e.y, jitter: 0 }; mem.set(e, m); } return m; }

  function update(dt, s) {
    dt = clamp(Number(dt) || 0, 0, .05);
    const e = s.boss; if (!e || e.hp <= 0) return;
    const m = state(e), full = !lite();
    if (m.last !== e.state) { m.last = e.state; m.age = 0; if (e.state === 'firing' && full) m.rings.push({ x: e.x + (s.player && s.player.x < e.x ? -30 : 30), y: e.y - 42, age: 0, life: .25, size: .6, col: color(e) }); }
    else m.age += dt;
    // Windup: motes converge on the boss.
    if (e.state === 'windup' && full && m.motes.length < 26) { const a = Math.random() * Math.PI * 2, r = 70 + Math.random() * 40; m.motes.push({ x: e.x + Math.cos(a) * r, y: e.y - 50 + Math.sin(a) * r * .7, life: .45 }); }
    for (const p of m.motes) { p.life -= dt; p.x += (e.x - p.x) * dt * 5; p.y += (e.y - 50 - p.y) * dt * 5; }
    m.motes = m.motes.filter(p => p.life > 0);
    // Dash ghosts.
    m.ghostT -= dt;
    if ((e.state === 'dashing' || e.state === 'bellyRolling') && m.ghostT <= 0 && full) { m.ghosts.push({ x: e.x, y: e.y, face: s.player && s.player.x < e.x ? -1 : 1, life: .22 }); m.ghostT = .045; if (m.ghosts.length > 5) m.ghosts.shift(); }
    for (const g of m.ghosts) g.life -= dt; m.ghosts = m.ghosts.filter(g => g.life > 0);
    // Landing dust.
    if (m.prevY < FLOOR - 12 && e.y >= FLOOR - 1) { m.rings.push({ x: e.x, y: FLOOR - 2, age: 0, life: .35, size: e.type === 'giant' ? 1.6 : 1, col: '#d8c7a4', dust: true }); window.SceneLife?.burst?.(e.x, FLOOR - 3, '#cdbb95', full ? 10 : 4); }
    m.prevY = e.y;
    for (const r of m.rings) r.age += dt; m.rings = m.rings.filter(r => r.age < r.life);
  }

  // Squash, stretch, recoil and hit jitter applied around the boss sprite (feet pivot).
  function transform(e, player) {
    if (!e || e.hp <= 0 || e.state === 'underground') return null;
    const m = state(e), face = player && player.x < e.x ? -1 : 1;
    let sx = 1, sy = 1, dx = 0;
    if (e.state === 'windup') { const k = clamp(1 - (e.stateTimer || 0) / (e.windupDuration || 1), 0, 1); sy = 1 - .07 * k; sx = 1 + .05 * k; dx = -face * Math.round(k * 2); }
    else if (e.state === 'dashing') { sx = 1.07; sy = .95; }
    else if (e.state === 'firing' && m.age < .14) { dx = -face * Math.round((1 - m.age / .14) * 4); sy = 1.03; sx = .98; }
    if (e.hit > 0 && !lite()) dx += Math.round((Math.random() - .5) * 4);
    if (sx === 1 && sy === 1 && dx === 0) return null;
    return { sx, sy, dx };
  }

  function drawBack(c, e, t) {
    if (!e || e.hp <= 0) return;
    const m = mem.get(e); if (!m) return;
    const col = color(e), full = !lite();
    // Ghost trail.
    if (full && window.CharDetail?.original) for (const g of m.ghosts) { c.save(); c.globalAlpha = g.life / .22 * .28; window.CharDetail.original(c, e.type, g.x, g.y, { facing: g.face, frame: t, dash: true, moving: true, grounded: g.y >= FLOOR - 1, bossPhase: e.phase, scale: e.rage && e.type === 'marco' ? 1.4 : 1 }); c.restore(); }
    // Windup ground glow.
    if (e.state === 'windup') { const k = clamp(1 - (e.stateTimer || 0) / (e.windupDuration || 1), 0, 1), pulse = .5 + .5 * Math.sin(t * 20); c.save(); c.globalAlpha = .25 + .35 * k * pulse; c.fillStyle = col; const w = 26 + k * 22; for (let i = -w; i <= w; i += 3) { const h = Math.round(Math.sqrt(Math.max(0, 1 - (i / w) ** 2)) * 4); c.fillRect(Math.round(e.x + i), FLOOR - h, 3, h * 2); } c.restore(); }
    for (const r of m.rings) if (r.dust) { const k = r.age / r.life, w = (20 + k * 60) * r.size; c.save(); c.globalAlpha = (1 - k) * .7; c.fillStyle = r.col; for (let i = -8; i <= 8; i++) c.fillRect(Math.round(r.x + i / 8 * w), Math.round(r.y - Math.cos(i / 8 * Math.PI / 2) * 6 * (1 - k)), 3, 2); c.restore(); }
  }

  function drawFront(c, e, t) {
    if (!e || e.hp <= 0) return;
    const m = mem.get(e); if (!m) return;
    const col = color(e);
    for (const p of m.motes) { c.globalAlpha = clamp(p.life * 3, 0, 1); R(c, p.x, p.y, 3, 3, col); R(c, p.x + 1, p.y + 1, 1, 1, '#ffffff'); }
    c.globalAlpha = 1;
    for (const r of m.rings) if (!r.dust) { const k = r.age / r.life, rad = 8 + k * 26; c.save(); c.globalAlpha = 1 - k; c.fillStyle = '#fff6d8'; for (let i = 0; i < 8; i++) { const a = i / 8 * Math.PI * 2; R(c, r.x + Math.cos(a) * rad - 2, r.y + Math.sin(a) * rad - 2, 4, 4, i % 2 ? col : '#fff6d8'); } R(c, r.x - 5, r.y - 5, 10, 10, col); c.restore(); }
    // Dizzy stars while the boss is open to attacks.
    if (e.state === 'recover') { const y = headY(e) - 6; for (let i = 0; i < 3; i++) { const a = t * 5 + i * 2.09, x = e.x + Math.cos(a) * 18, yy = y + Math.sin(a) * 5, s = Math.sin(a) > 0 ? 2 : 1; c.fillStyle = '#ffe36b'; c.fillRect(Math.round(x) - s, Math.round(yy), s * 2 + 1, 1); c.fillRect(Math.round(x), Math.round(yy) - s, 1, s * 2 + 1); } }
  }

  // Fading trail behind enemy projectiles.
  function drawShotTrails(c, shots) {
    if (lite()) return;
    for (const s of shots) {
      if (s.owner !== 'enemy') continue;
      let tr = shotTrails.get(s); if (!tr) { tr = []; shotTrails.set(s, tr); }
      tr.push([s.x, s.y]); if (tr.length > 6) tr.shift();
      for (let i = 0; i < tr.length - 1; i++) { const a = (i + 1) / tr.length; c.globalAlpha = a * .45; const z = Math.max(2, Math.round(a * 6)); c.fillStyle = s.enraged ? '#ff8a7a' : '#fff1c4'; c.fillRect(Math.round(tr[i][0] - z / 2), Math.round(tr[i][1] - z / 2), z, z); }
    }
    c.globalAlpha = 1;
  }

  window.BossFx = Object.freeze({ update, transform, drawBack, drawFront, drawShotTrails });
})();
