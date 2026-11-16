/* Living scenery around the hero: foreground grass that bends under the player's feet,
   footstep/jump/landing dust, dash speed lines and attack smears.
   Visual only: it never changes positions, collisions, damage or timers of the game. */
(() => {
  'use strict';
  const FLOOR = 440;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const hash = (i) => { const x = Math.sin(i * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const calm = (() => { try { return matchMedia('(prefers-reduced-motion: reduce)').matches; } catch (e) { return false; } })();
  // Scenes with a soft, natural floor get a dense carpet; paved ones only weeds in the cracks.
  const MEADOW = { 0: ['#2f6e31', '#3e863d', '#5f9f3f', '#86b84a', '#a9cf5d'], 7: ['#2c6a33', '#3a7f3a', '#4f9a40', '#73b34c', '#9ccd5c'] };
  const WEEDS = { 1: 1, 3: 1, 4: 1, 5: 1, 9: 1 };
  const WEED_COLORS = ['#3f6e3a', '#55873f', '#79a64a'];
  const DUST = { 0: '#b8946a', 7: '#8fb36a', 2: '#8f8780', 6: '#a58fbd', 8: '#cdb594', 10: '#c9a77f' };

  let heroPos = null;
  const springs = new Map();
  let sparks = [], shards = [], clouds = [], particles = [], lines = [], lastStep = null, wasGround = true, lastVy = 0, squash = 0, squashV = 0, lastScene = -1, lastAttack = 0;

  function wind(t, x) { const g = .55 + .45 * Math.sin(t * .31); return (Math.sin(t * 1.15 + x * .0042) * .62 + Math.sin(t * 2.4 + x * .013) * .38) * g; }
  function dustColor(scene) { return DUST[scene] || '#bdb4a2'; }
  function puff(x, y, vx, vy, size, color, life) { if (window.Graphics?.isLite?.() && (particles.length > 14 || Math.random() < .5)) return; if (particles.length > 70) particles.shift(); particles.push({ x, y, vx, vy, size, color, life, max: life }); }

  function update(dt, s) {
    dt = clamp(Number(dt) || 0, 0, .05);
    const p = s.player;
    if (!p || !Number.isFinite(p.x)) return;
    heroPos = { x: p.x, y: p.y, scene: s.scene };
    if (s.scene !== lastScene) { springs.clear(); particles = []; lines = []; lastScene = s.scene; lastStep = null; }
    const moving = Math.abs(p.vx) > 40, onGround = !!p.ground && !s.vehicle, color = dustColor(s.scene);

    // Footfalls: two contacts per stride, matching the walk cycle phase of the sprite.
    const step = Math.floor((Number(p.anim) || 0) / Math.PI);
    if (onGround && moving && lastStep !== null && step !== lastStep) {
      const back = -Math.sign(p.vx) || -p.facing, fast = Math.abs(p.vx) > 200;
      for (let i = 0; i < (fast ? 3 : 2); i++) puff(p.x + back * (4 + i * 3), p.y - 2, back * (25 + Math.random() * 35), -12 - Math.random() * 22, 2 + Math.round(Math.random() * 2), color, .32 + Math.random() * .18);
    }
    lastStep = step;

    // Take-off and touchdown.
    if (wasGround && !p.ground && p.vy < -150 && !s.vehicle) {
      for (let i = 0; i < 6; i++) { const d = i % 2 ? 1 : -1; puff(p.x + d * (3 + i), p.y - 1, d * (30 + i * 12), -6 - i * 2, 3, color, .34); }
      squash = .14; squashV = 0;
    }
    if (!wasGround && p.ground) {
      const impact = clamp(lastVy / 520, .25, 1.2);
      for (let i = 0; i < Math.round(6 + impact * 6); i++) { const d = i % 2 ? 1 : -1; puff(p.x + d * (4 + Math.random() * 8), p.y - 1, d * (50 + Math.random() * 90) * impact, -8 - Math.random() * 30 * impact, 2 + Math.round(Math.random() * 2), color, .3 + Math.random() * .25); }
      squash = -.2 * impact; squashV = 0;
      if (impact > .7) lines.push({ x: p.x, y: p.y, age: 0, life: .28, kind: 'ring', size: impact });
    }
    wasGround = !!p.ground; lastVy = p.vy;

    // Squash & stretch: a damped spring, plus a stretch that follows vertical speed in the air.
    squashV += (-squash * 210 - squashV * 16) * dt; squash += squashV * dt;
    if (Math.abs(squash) < .002 && Math.abs(squashV) < .01) { squash = 0; squashV = 0; }

    // Dash streaks.
    if (s.dashing && !calm) lines.push({ x: p.x - p.facing * (18 + Math.random() * 30), y: p.y - 10 - Math.random() * 50, age: 0, life: .2, kind: 'streak', dir: p.facing, len: 26 + Math.random() * 30 });
    // Attack smear on the swing.
    if (p.attack > 0 && lastAttack <= 0) lines.push({ x: p.x, y: p.y, age: 0, life: .2, kind: 'smear', dir: p.facing, type: p.attackType });
    lastAttack = p.attack || 0;

    window.Critters?.update?.(dt, s);
    for (const e of sparks) { e.life -= dt; e.x += e.vx * dt; e.y += e.vy * dt; e.vy += 300 * dt; e.vx *= Math.exp(-dt * 5); }
    sparks = sparks.filter(e => e.life > 0);
    for (const e of shards) { e.life -= dt; e.x += e.vx * dt; e.y += e.vy * dt; e.vy += 620 * dt; e.rot += e.vr * dt; if (e.y > FLOOR - 1) { e.y = FLOOR - 1; e.vy *= -.25; e.vx *= .6; e.vr *= .5; } }
    shards = shards.filter(e => e.life > 0);
    for (const e of clouds) { e.life -= dt; e.x += e.vx * dt; e.y += e.vy * dt; e.vx *= Math.exp(-dt * 2.6); e.r += e.grow * dt; }
    clouds = clouds.filter(e => e.life > 0);
    for (const e of particles) { e.life -= dt; e.x += e.vx * dt; e.y += e.vy * dt; e.vx *= Math.exp(-dt * 4); e.vy += 40 * dt; }
    particles = particles.filter(e => e.life > 0);
    for (const l of lines) l.age += dt;
    lines = lines.filter(l => l.age < l.life);
    if (lines.length > 30) lines.splice(0, lines.length - 30);

    // Grass springs near the hero (only meadow scenes keep state).
    const meadow = MEADOW[s.scene] && !s.arena;
    if (meadow) {
      const near = onGround && Math.abs(p.y - FLOOR) < 6;
      const from = Math.floor((p.x - 60) / 6), to = Math.ceil((p.x + 60) / 6);
      for (let i = from; i <= to; i++) if (!springs.has(i)) springs.set(i, { d: 0, v: 0 });
      for (const [i, sp] of springs) {
        const bx = i * 6 + 3, dx = bx - p.x;
        let target = 0;
        if (near && Math.abs(dx) < 22) target = Math.sign(dx || p.facing) * (1 - Math.abs(dx) / 22) * 1.15 + clamp(p.vx / 400, -.5, .5) * (1 - Math.abs(dx) / 22);
        sp.v += ((target - sp.d) * 120 - sp.v * 9) * dt; sp.d += sp.v * dt;
        if (Math.abs(dx) > 90 && Math.abs(sp.d) < .01 && Math.abs(sp.v) < .01) springs.delete(i);
      }
    }
  }

  // Scale factors for the hero sprite, pivoting on the feet.
  function heroScale(p, vehicle) {
    if (!p || vehicle || calm) return { sx: 1, sy: 1 };
    let sy = 1 + squash;
    if (!p.ground) sy += p.vy < 0 ? clamp(-p.vy / 5200, 0, .07) : clamp(p.vy / 9000, 0, .04);
    sy = clamp(sy, .8, 1.12);
    return { sx: clamp(1 / Math.sqrt(sy), .92, 1.12), sy };
  }

  function drawBack(c, s) {
    window.Critters?.draw?.(c, s);
    // Landing ring sits on the floor behind the hero.
    for (const l of lines) if (l.kind === 'ring') {
      const k = l.age / l.life, w = (18 + k * 46) * l.size;
      c.save(); c.globalAlpha = (1 - k) * .7; c.fillStyle = dustColor(s.scene);
      for (let i = -6; i <= 6; i++) { const x = Math.round(l.x + i / 6 * w), y = Math.round(l.y - 2 - Math.cos(i / 6 * Math.PI / 2) * 5 * (1 - k)); c.fillRect(x, y, 3, 2); }
      c.restore();
    }
    for (const l of lines) if (l.kind === 'streak') {
      const k = l.age / l.life; c.save(); c.globalAlpha = (1 - k) * .55; c.fillStyle = '#fff4d4';
      c.fillRect(Math.round(l.x - (l.dir > 0 ? l.len : 0)), Math.round(l.y), Math.round(l.len * (1 - k * .5)), 2); c.restore();
    }
  }

  function drawFront(c, s) {
    const t = Number(s.time) || 0, cam = Number(s.camera) || 0, lite = !!window.Graphics?.isLite?.();
    for (const e of clouds) { const k = e.life / e.max; c.save(); c.globalAlpha = Math.min(.55, k * .7); c.fillStyle = e.col; const r = Math.round(e.r); c.beginPath(); c.arc(Math.round(e.x), Math.round(e.y), r, 0, Math.PI * 2); c.fill(); c.globalAlpha *= .6; c.fillStyle = '#f2f8c8'; c.beginPath(); c.arc(Math.round(e.x - r * .3), Math.round(e.y - r * .35), Math.round(r * .45), 0, Math.PI * 2); c.fill(); c.restore(); }
    for (const e of sparks) { c.save(); c.globalAlpha = Math.min(1, e.life * 8); c.strokeStyle = e.col; c.lineWidth = 2; c.beginPath(); c.moveTo(Math.round(e.x), Math.round(e.y)); c.lineTo(Math.round(e.x - e.vx * .025), Math.round(e.y - e.vy * .025)); c.stroke(); c.restore(); }
    for (const e of shards) { c.save(); c.globalAlpha = Math.min(1, e.life * 3); c.translate(Math.round(e.x), Math.round(e.y)); c.rotate(Math.round(e.rot * 2) / 2); c.fillStyle = e.col; c.fillRect(-2, -1, 4, 2); c.restore(); }
    // Dust in front so it partly covers the feet, like real kicked-up dirt.
    for (const e of particles) { const k = e.life / e.max; c.save(); c.globalAlpha = clamp(k * 1.4, 0, .85); c.fillStyle = e.color; const z = Math.max(1, Math.round(e.size * (1.6 - k * .6))); c.fillRect(Math.round(e.x - z / 2), Math.round(e.y - z / 2), z, z); c.restore(); }
    for (const l of lines) if (l.kind === 'smear') {
      const k = l.age / l.life, gas = l.type === 'fart', r0 = 26 + k * 10;
      c.save(); c.globalAlpha = (1 - k) * .85; c.fillStyle = gas ? '#cfe58a' : '#fff6d6';
      for (let i = 0; i <= 8; i++) { const a = -1.15 + i / 8 * 1.5, x = l.x + l.dir * Math.cos(a) * r0, y = l.y - 36 + Math.sin(a) * r0; const z = i > 2 && i < 7 ? 3 : 2; c.fillRect(Math.round(x), Math.round(y), z, z); }
      c.restore();
    }
    // Foreground grass carpet.
    if (lite) return;
    // Leaves and petals riding the wind across the whole view (outdoor maps).
    if ([0, 1, 3, 4, 5, 7, 9].includes(s.scene) && !s.arena) {
      for (let i = 0; i < 22; i++) { const sp = .045 + hash(i + 900) * .05, k = (t * sp + hash(i + 910)) % 1, gust = wind(t, i * 40);
        const x = cam + 990 - k * 1060, y = 60 + hash(i + 920) * 340 + Math.sin(t * 1.7 + i) * 16 + gust * 10;
        c.save(); c.translate(Math.round(x), Math.round(y)); c.rotate(t * (2 + hash(i) * 3) + i); c.globalAlpha = .9;
        c.fillStyle = s.scene === 4 ? ['#ffb7c8', '#ffe08a', '#ffffff'][i % 3] : ['#8fcf5a', '#c9a24a', '#e8783a', '#6aa84a'][i % 4]; c.fillRect(-3, -1, 6, 3); c.fillStyle = '#00000022'; c.fillRect(-3, 1, 6, 1); c.restore(); }
    }
    const pal = MEADOW[s.scene];
    if (pal && !s.arena) {
      const from = Math.floor(cam / 6) - 1, to = Math.ceil((cam + 960) / 6) + 1;
      for (let i = from; i <= to; i++) {
        if (s.gapAt && s.gapAt(i * 6 + 3)) continue;
        const bx = i * 6 + 3, h = 3 + Math.floor(hash(i) * 5) + (hash(i + 50) > .9 ? 3 : 0), sp = springs.get(i), push = sp ? sp.d : 0;
        const lean = wind(t, bx) * (1 + h * .12) + push * (h * .9), col = pal[Math.floor(hash(i + 9) * pal.length)];
        c.fillStyle = pal[0]; c.fillRect(bx, FLOOR - 1, 2, 2);
        for (let k = 1; k <= h; k += 2) { const f = k / h, ox = Math.round(lean * f * f); c.fillStyle = f > .7 ? pal[Math.min(pal.length - 1, pal.indexOf(col) + 1)] : col; c.fillRect(bx + ox, FLOOR - k, 2, 2); }
        if (hash(i + 77) > .965) { const ox = Math.round(lean); c.fillStyle = hash(i + 3) > .5 ? '#f3d36a' : '#f2a2b2'; c.fillRect(bx + ox - 1, FLOOR - h - 2, 4, 3); }
      }
    } else if (WEEDS[s.scene] && !s.arena) {
      const from = Math.floor(cam / 37) - 1, to = Math.ceil((cam + 960) / 37) + 1;
      for (let i = from; i <= to; i++) {
        if (hash(i + 13) < .62) continue;
        const bx = i * 37 + Math.floor(hash(i) * 20);
        if (s.gapAt && s.gapAt(bx)) continue;
        const near = s.player && Math.abs(s.player.x - bx) < 18 && s.player.ground ? Math.sign(bx - s.player.x || 1) * 2 : 0;
        for (let j = 0; j < 3; j++) { const h = 4 + Math.floor(hash(i * 3 + j) * 5), lean = Math.round(wind(t, bx) * 1.6 + near); c.fillStyle = WEED_COLORS[j]; c.fillRect(bx + j * 2, FLOOR - h + 2, 2, h - 2); c.fillRect(bx + j * 2 + lean, FLOOR - h, 2, 2); }
      }
    }
  }

  // Impact: hot sparks that streak out fast and paper/debris shards that tumble with gravity.
  function impact(x, y, color, power, dir) {
    const lite = !!window.Graphics?.isLite?.(), n = lite ? 3 : Math.min(14, 5 + Math.round((power || 10) / 6));
    for (let i = 0; i < n; i++) { const a = (Math.random() - .5) * 2.4 + (dir < 0 ? Math.PI : 0), sp = 160 + Math.random() * 260; sparks.push({ x, y, vx: Math.cos(a) * sp, vy: Math.sin(a) * sp - 40, life: .12 + Math.random() * .14, col: i % 3 ? color : '#fff6d8' }); }
    if (!lite) for (let i = 0; i < Math.min(8, 2 + Math.round((power || 10) / 10)); i++) shards.push({ x, y, vx: (dir || 1) * (40 + Math.random() * 120) + (Math.random() - .5) * 80, vy: -80 - Math.random() * 160, rot: Math.random() * 6, vr: (Math.random() - .5) * 20, life: .5 + Math.random() * .4, col: Math.random() > .5 ? '#f3ead2' : color });
    if (sparks.length > 60) sparks.splice(0, sparks.length - 60); if (shards.length > 40) shards.splice(0, shards.length - 40);
  }
  function gas(x, y, dir, stage) {
    const lite = !!window.Graphics?.isLite?.(), n = lite ? 3 : 6 + stage * 4;
    for (let i = 0; i < n; i++) clouds.push({ x: x + dir * (6 + Math.random() * 20), y: y + (Math.random() - .5) * 14, vx: dir * (60 + Math.random() * 140 * stage) + (Math.random() - .5) * 40, vy: -10 - Math.random() * 30, r: 6 + Math.random() * 8, grow: 22 + stage * 10, life: .7 + Math.random() * .5, max: 1.2, col: stage === 3 ? '#d9ee86' : '#bfdc66' });
    if (clouds.length > 50) clouds.splice(0, clouds.length - 50);
  }
  function burst(x, y, color, n) { for (let i = 0; i < n; i++) puff(x, y, (Math.random() - .5) * 120, -20 - Math.random() * 50, 2, color, .35); }
  window.Graphics?.onChange?.(() => window.Critters?.reset?.());
  window.SceneLife = Object.freeze({ update, drawBack, drawFront, heroScale, burst, impact, gas, hero: () => heroPos });
})();
