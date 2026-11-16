/* Interactive scenery life: chickens, pigeons, butterflies, a dog and a cat, kites in the
   favela sky and things the hero can kick (football, cans). Pure decoration: nothing here
   touches the player, enemies, quests, saves, collisions or timers. */
(() => {
  'use strict';
  const FLOOR = 440, GRAV = 900;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const hash = (i) => { const x = Math.sin(i * 91.7 + 17.3) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); };
  // What lives where: [type, spacing in world px, chance per slot].
  const PLAN = {
    0: [['chicken', 420, .8], ['butterfly', 360, .7], ['sparrow', 380, .85]],
    1: [['pigeon', 520, .7], ['can', 900, .6], ['sparrow', 640, .7]],
    3: [['ball', 1400, 1], ['butterfly', 700, .4], ['sparrow', 420, .85]],
    4: [['pigeon', 380, .9], ['butterfly', 600, .5], ['can', 1000, .5]],
    5: [['pigeon', 600, .6], ['dog', 1500, .9], ['cat', 1300, .8], ['kite', 700, .8], ['can', 800, .6]],
    7: [['ball', 2000, 1], ['butterfly', 500, .6], ['sparrow', 450, .9]],
    9: [['pigeon', 600, .8], ['can', 900, .5], ['sparrow', 560, .7]]
  };
  let scene = -1, list = [], worldW = 4800;

  function build(sc) {
    scene = sc; list = [];
    worldW = Number(window.WorldData?.widths?.[sc]) || [4800, 6200, 5000, 5200, 6000, 7200, 6600, 4800, 3600, 4200, 3600, 4800][sc] || 4800;
    const plan = PLAN[sc]; if (!plan) return;
    const lite = !!window.Graphics?.isLite?.();
    plan.forEach(([type, gap, chance], k) => {
      for (let x = 300 + hash(k + sc) * gap; x < worldW - 120; x += gap * (lite ? 1.8 : 1)) {
        const seed = Math.floor(x) + k * 1000 + sc * 77;
        if (hash(seed) > chance) continue;
        const n = type === 'chicken' ? 2 + Math.floor(hash(seed + 1) * 2) : type === 'pigeon' ? 2 + Math.floor(hash(seed + 2) * 3) : type === 'sparrow' ? 3 + Math.floor(hash(seed + 5) * 4) : 1;
        for (let j = 0; j < n; j++) {
          const hx = x + j * (type === 'sparrow' ? 7 + hash(seed + j) * 12 : 14 + hash(seed + j) * 22);
          list.push({ type, hx, x: hx, y: type === 'butterfly' ? FLOOR - 40 - hash(seed + j) * 50 : type === 'kite' ? 70 + hash(seed) * 70 : FLOOR, vx: 0, vy: 0, face: hash(seed + j * 3) > .5 ? 1 : -1, state: 'idle', timer: hash(seed + j) * 3, seed: seed + j, rot: 0, gone: 0 });
        }
      }
    });
  }

  function update(dt, s) {
    dt = clamp(Number(dt) || 0, 0, .05);
    if (s.scene !== scene) build(s.scene);
    if (!list.length || s.arena) return;
    const p = s.player, t = Number(s.time) || 0, onFloor = p && p.ground && Math.abs(p.y - FLOOR) < 8;
    for (const c of list) {
      const dx = p ? c.x - p.x : 999, near = Math.abs(dx), threat = p && near < 85 && (Math.abs(p.vx) > 60 || near < 34) && Math.abs(p.y - c.y) < 90;
      c.timer -= dt;
      if (c.type === 'chicken') {
        if (threat && c.state !== 'flee') { c.state = 'flee'; c.face = Math.sign(dx) || 1; c.vx = c.face * (150 + hash(c.seed) * 60); c.vy = -160 - hash(c.seed + 4) * 90; c.timer = 1.1; }
        if (c.state === 'flee') { c.vy += GRAV * dt; c.x += c.vx * dt; c.y = Math.min(FLOOR, c.y + c.vy * dt); if (c.y >= FLOOR) { c.vy = 0; c.vx *= Math.exp(-dt * 3); } if (c.timer <= 0) c.state = 'idle'; }
        else if (c.timer <= 0) { c.state = hash(c.seed + Math.floor(t)) > .5 ? 'peck' : 'walk'; c.timer = 1 + hash(c.seed + t) * 2; if (c.state === 'walk') c.face = c.x > c.hx + 40 ? -1 : c.x < c.hx - 40 ? 1 : c.face; }
        if (c.state === 'walk') c.x += c.face * 18 * dt;
      } else if (c.type === 'pigeon' || c.type === 'sparrow') {
        const fear = (c.type === 'sparrow' ? 70 : 60) + hash(c.seed + 9) * 70, scared = p && near < fear && Math.abs(p.y - c.y) < 110;
        if (c.state === 'fly') { c.vy -= 60 * dt; c.x += c.vx * dt; c.y += c.vy * dt; if (c.y < -40) { c.state = 'away'; c.timer = 6 + hash(c.seed) * 6; } }
        else if (c.state === 'away') { if (c.timer <= 0 && (!p || Math.abs(p.x - c.hx) > 520)) { c.state = 'idle'; c.x = c.hx; c.y = FLOOR; } }
        else {
          if (scared || threat) { c.state = 'fly'; c.face = Math.sign(dx) || 1; c.vx = c.face * (c.type === 'sparrow' ? 170 + hash(c.seed) * 110 : 120 + hash(c.seed) * 80); c.vy = -(c.type === 'sparrow' ? 200 : 170) - hash(c.seed + 3) * 90; }
          else if (c.state === 'hop') { c.vy += GRAV * dt; c.x += c.vx * dt; c.y = Math.min(FLOOR, c.y + c.vy * dt); if (c.y >= FLOOR) { c.state = 'peck'; c.vx = 0; } }
          else if (c.timer <= 0 && c.type === 'sparrow') { const r = hash(c.seed + Math.floor(t * 3)); c.state = r > .55 ? 'peck' : 'hop'; if (c.state === 'hop') { c.vy = -90; c.vx = c.face * 40; c.y -= 1; if (r < .2) c.face *= -1; } c.timer = .35 + hash(c.seed + t) * .9; }
          else if (c.timer <= 0) { c.state = hash(c.seed + Math.floor(t * 2)) > .4 ? 'peck' : 'walk'; c.timer = .6 + hash(c.seed + t) * 1.6; if (hash(c.seed + Math.floor(t)) > .7) c.face *= -1; }
          if (c.state === 'walk') c.x += c.face * 14 * dt;
        }
      } else if (c.type === 'butterfly') {
        const scare = p && Math.hypot(c.x - p.x, c.y - (p.y - 40)) < 70;
        const tx = c.hx + Math.sin(t * .6 + c.seed) * 60 + (scare ? Math.sign(dx || 1) * 90 : 0), ty = FLOOR - 55 + Math.sin(t * 1.3 + c.seed * 2) * 30 - (scare ? 60 : 0);
        c.vx += (tx - c.x) * dt * 2 - c.vx * dt; c.vy += (ty - c.y) * dt * 2 - c.vy * dt; c.x += c.vx * dt; c.y += c.vy * dt; c.face = c.vx >= 0 ? 1 : -1;
      } else if (c.type === 'dog') {
        if (threat && near < 60) { c.state = 'wag'; c.face = -Math.sign(dx) || 1; c.timer = 2; }
        else if (c.timer <= 0) { c.state = c.state === 'walk' ? 'sit' : 'walk'; c.timer = 2 + hash(c.seed + t) * 3; c.face = c.x > c.hx + 120 ? -1 : c.x < c.hx - 120 ? 1 : (hash(c.seed + Math.floor(t)) > .5 ? 1 : -1); }
        if (c.state === 'walk') c.x += c.face * 26 * dt;
      } else if (c.type === 'cat') {
        if (threat && c.state !== 'run') { c.state = 'run'; c.face = Math.sign(dx) || 1; c.timer = 1.4; }
        if (c.state === 'run') { c.x += c.face * 170 * dt; if (c.timer <= 0) c.state = 'sit'; }
        else if (c.timer <= 0 && Math.abs(c.x - c.hx) > 200 && (!p || Math.abs(p.x - c.hx) > 520)) { c.x = c.hx; c.state = 'sit'; }
      } else if (c.type === 'ball' || c.type === 'can') {
        const r = c.type === 'ball' ? 7 : 4;
        if (p && near < 16 + r && Math.abs(p.y - c.y) < 34 && Math.abs(p.vx) > 30 && c.timer <= 0) {
          const kick = c.type === 'ball' ? 1.5 : 1.15;
          c.vx = p.vx * kick + Math.sign(p.vx) * 40; c.vy = -(120 + Math.abs(p.vx) * (c.type === 'ball' ? .7 : .4)); c.timer = .25;
          window.SceneLife?.burst?.(c.x, FLOOR - 2, c.type === 'ball' ? '#e6f0d8' : '#c9c2b2', 4);
        }
        c.vy += GRAV * dt; c.x += c.vx * dt; c.y += c.vy * dt;
        if (c.y >= FLOOR) { c.y = FLOOR; c.vy = Math.abs(c.vy) > 80 ? -c.vy * (c.type === 'ball' ? .55 : .3) : 0; c.vx *= Math.exp(-dt * (c.type === 'ball' ? 1.1 : 3)); }
        if (c.x < 20 || c.x > worldW - 20) { c.x = clamp(c.x, 20, worldW - 20); c.vx *= -.5; }
        c.rot += c.vx * dt / r;
      }
      if (c.type !== 'kite' && c.type !== 'ball' && c.type !== 'can' && c.type !== 'butterfly' && c.state !== 'fly' && c.state !== 'away') c.x = clamp(c.x, c.hx - 260, c.hx + 260);
    }
  }

  // ---------- pixel sprites (all original, drawn with rects) ----------
  function chicken(c, x, y, f, t, k) {
    const peck = k.state === 'peck' ? Math.max(0, Math.sin(t * 9 + k.seed)) * 4 : 0, flap = k.state === 'flee' && k.y < FLOOR - 1;
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(f, 1);
    R(c, -7, -1, 14, 1, 'rgba(30,30,20,.25)');
    R(c, -2, -4, 2, 4, '#d58a2a'); R(c, 2, -4, 2, 4, '#d58a2a');
    R(c, -8, -12, 13, 9, '#f3efe2'); R(c, -9, -14, 4, 4, '#e8e2d0'); R(c, -6, -5, 9, 2, '#d9d1bd');
    if (flap) { R(c, -6, -18 + Math.round(Math.sin(t * 30) * 2), 9, 4, '#ffffff'); } else R(c, -5, -10, 7, 4, '#e4dccb');
    const hy = -17 + peck; R(c, 2, hy, 6, 7, '#f3efe2'); R(c, 3, hy - 2, 3, 2, '#d8433a'); R(c, 8, hy + 3, 3, 2, '#f0b23a'); R(c, 6, hy + 2, 1, 1, '#222'); R(c, 6, hy + 5, 2, 3, '#d8433a');
    c.restore();
  }
  function pigeon(c, x, y, f, t, k) {
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(f, 1);
    if (k.state === 'fly') { const w = Math.round(Math.sin(t * 28 + k.seed) * 4); R(c, -5, -5, 10, 4, '#8b93a0'); R(c, -3, -8 + w, 8, 3, '#a7aebb'); R(c, -3, -1 - w, 8, 2, '#737b88'); R(c, 4, -6, 3, 3, '#7e8794'); c.restore(); return; }
    const peck = k.state === 'peck' ? Math.max(0, Math.sin(t * 11 + k.seed)) * 3 : 0;
    R(c, -5, -1, 10, 1, 'rgba(30,30,30,.2)'); R(c, -1, -3, 1, 3, '#c0605a'); R(c, 1, -3, 1, 3, '#c0605a');
    R(c, -6, -8, 10, 5, '#8b93a0'); R(c, -7, -7, 3, 2, '#5f6672'); R(c, -3, -7, 5, 2, '#a7aebb');
    R(c, 2, -11 + peck, 4, 4, '#7e8794'); R(c, 2, -8 + peck, 3, 2, '#6aa38e'); R(c, 6, -10 + peck, 2, 1, '#e9d9b0'); R(c, 4, -10 + peck, 1, 1, '#f0a050');
    c.restore();
  }
  function sparrow(c, x, y, f, t, k) {
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(f, 1);
    if (k.state === 'fly') { const w = Math.round(Math.sin(t * 34 + k.seed) * 3); R(c, -3, -4, 7, 3, '#8a6a4a'); R(c, -2, -7 + w, 5, 3, '#a88560'); R(c, -2, -1 - w, 5, 2, '#6e5238'); R(c, 3, -5, 3, 2, '#7a5a3c'); R(c, -5, -4, 2, 1, '#5e4630'); c.restore(); return; }
    const peck = k.state === 'peck' ? Math.max(0, Math.sin(t * 13 + k.seed)) * 2 : 0;
    R(c, -3, -1, 7, 1, 'rgba(30,25,20,.22)'); R(c, 0, -2, 1, 2, '#c08a60');
    R(c, -4, -6, 7, 4, '#8a6a4a'); R(c, -6, -5, 3, 1, '#5e4630'); R(c, -3, -6, 4, 1, '#b08a62'); R(c, -2, -3, 4, 1, '#d8c8a8');
    R(c, 2, -8 + peck, 3, 3, '#7a5a3c'); R(c, 2, -6 + peck, 2, 1, '#e8dcc0'); R(c, 5, -7 + peck, 1, 1, '#e0b060'); R(c, 3, -8 + peck, 1, 1, '#1d1612');
    c.restore();
  }
  function butterfly(c, x, y, t, k) {
    const w = Math.abs(Math.sin(t * 16 + k.seed)) * 3 + 1, col = ['#f2b33d', '#f08bb0', '#8fd0f0', '#fff3c4'][k.seed % 4];
    R(c, x - w - 1, y - 2, w, 3, col); R(c, x + 2, y - 2, w, 3, col); R(c, x, y - 2, 2, 4, '#3a2a20');
  }
  function dog(c, x, y, f, t, k) {
    const walk = k.state === 'walk', leg = walk ? Math.round(Math.sin(t * 12 + k.seed) * 2) : 0, wag = Math.round(Math.sin(t * (k.state === 'wag' ? 22 : 6)) * 2);
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(f, 1);
    R(c, -11, -1, 22, 1, 'rgba(30,25,20,.25)');
    if (k.state === 'sit') { R(c, -8, -12, 12, 9, '#b07a46'); R(c, -6, -4, 4, 4, '#9a6a3c'); R(c, 2, -4, 3, 4, '#9a6a3c'); }
    else { R(c, -9, -12, 16, 7, '#b07a46'); R(c, -8 + leg, -5, 3, 5, '#9a6a3c'); R(c, -3 - leg, -5, 3, 5, '#9a6a3c'); R(c, 1 + leg, -5, 3, 5, '#9a6a3c'); R(c, 5 - leg, -5, 3, 5, '#9a6a3c'); }
    R(c, -12, -14 + wag, 4, 2, '#9a6a3c');
    R(c, 4, -18, 8, 8, '#b07a46'); R(c, 11, -14, 3, 3, '#d9b48a'); R(c, 13, -14, 1, 1, '#222'); R(c, 8, -16, 1, 1, '#222'); R(c, 4, -19, 3, 4, '#7d5230');
    c.restore();
  }
  function cat(c, x, y, f, t, k) {
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(f, 1);
    R(c, -7, -1, 14, 1, 'rgba(30,25,20,.25)');
    if (k.state === 'run') { const l = Math.round(Math.sin(t * 20) * 2); R(c, -8, -8, 13, 5, '#3b3a3f'); R(c, -7 + l, -3, 2, 3, '#3b3a3f'); R(c, 2 - l, -3, 2, 3, '#3b3a3f'); R(c, 4, -11, 6, 5, '#3b3a3f'); R(c, -12, -10, 5, 2, '#3b3a3f'); }
    else { const tail = Math.round(Math.sin(t * 2 + k.seed) * 2); R(c, -5, -11, 9, 10, '#3b3a3f'); R(c, -8, -3 + tail, 4, 2, '#3b3a3f'); R(c, -1, -17, 7, 6, '#3b3a3f'); R(c, -1, -19, 2, 2, '#3b3a3f'); R(c, 4, -19, 2, 2, '#3b3a3f'); R(c, 1, -15, 1, 1, '#e5d24a'); R(c, 4, -15, 1, 1, '#e5d24a'); }
    c.restore();
  }
  function kite(c, x, y, t, k, cam) {
    const sx = x + Math.sin(t * .7 + k.seed) * 30, sy = y + Math.sin(t * 1.1 + k.seed) * 14, col = ['#e2453c', '#f2c33a', '#3b8fd8', '#46b46a'][k.seed % 4];
    c.save(); c.globalAlpha = .55; c.strokeStyle = '#4d4d4d'; c.lineWidth = 1; c.beginPath(); c.moveTo(sx, sy + 8); c.lineTo(sx - 60, FLOOR - 60); c.stroke(); c.restore();
    c.fillStyle = col; c.beginPath(); c.moveTo(sx, sy - 9); c.lineTo(sx + 7, sy); c.lineTo(sx, sy + 9); c.lineTo(sx - 7, sy); c.closePath(); c.fill();
    R(c, sx - 1, sy - 9, 2, 18, 'rgba(255,255,255,.45)');
    for (let i = 1; i < 6; i++) R(c, sx + Math.sin(t * 4 + i) * 3 - i, sy + 9 + i * 4, 2, 2, i % 2 ? col : '#fff');
  }
  function ball(c, x, y, k) {
    c.save(); c.translate(Math.round(x), Math.round(y) - 7); R(c, -6, 6, 12, 1, 'rgba(20,30,20,.3)');
    R(c, -5, -7, 10, 14, '#f4f4ee'); R(c, -7, -5, 14, 10, '#f4f4ee'); R(c, -6, -6, 12, 12, '#f4f4ee');
    const a = k.rot; for (let i = 0; i < 3; i++) { const ang = a + i * 2.1; R(c, Math.round(Math.cos(ang) * 3) - 2, Math.round(Math.sin(ang) * 3) - 2, 4, 4, '#2b2b2b'); }
    R(c, -4, -6, 4, 2, '#ffffff'); c.restore();
  }
  function can(c, x, y, k) {
    c.save(); c.translate(Math.round(x), Math.round(y) - 4); c.rotate(Math.round(k.rot * 2) / 2 * Math.PI / 4 % (Math.PI * 2));
    R(c, -5, -3, 10, 7, '#b8433b'); R(c, -5, -3, 10, 2, '#e3e3e3'); R(c, -5, 3, 10, 1, '#9a9a9a'); R(c, -2, -1, 5, 2, '#f0d27a');
    c.restore();
  }

  function draw(c, s) {
    if (!list.length || s.arena) return;
    const t = Number(s.time) || 0, cam = Number(s.camera) || 0;
    for (const k of list) {
      if (k.x < cam - 80 || k.x > cam + 1040) continue;
      if (k.state === 'away') continue;
      if (s.gapAt && k.y >= FLOOR - 1 && s.gapAt(k.x) && k.type !== 'kite') continue;
      switch (k.type) {
        case 'chicken': chicken(c, k.x, k.y, k.face, t, k); break;
        case 'pigeon': pigeon(c, k.x, k.y, k.face, t, k); break;
        case 'sparrow': sparrow(c, k.x, k.y, k.face, t, k); break;
        case 'butterfly': butterfly(c, k.x, k.y, t, k); break;
        case 'dog': dog(c, k.x, k.y, k.face, t, k); break;
        case 'cat': cat(c, k.x, k.y, k.face, t, k); break;
        case 'kite': kite(c, k.x, k.y, t, k, cam); break;
        case 'ball': ball(c, k.x, k.y, k); break;
        case 'can': can(c, k.x, k.y, k); break;
      }
    }
  }
  window.Critters = Object.freeze({ update, draw, count: () => list.length, reset: () => { scene = -1; } });
})();
