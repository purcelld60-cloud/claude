/* Fliperama da Roça: minigames 2D em pixel art, sozinho ou em dupla no mesmo aparelho.
   - Abre pelo menu inicial, pela pausa, pelo INVENTÁRIO e pelas máquinas de fliperama nos mapas.
   - Cada jogo tem regras e controles antes de começar, contagem regressiva, placar, ranking local
     (top 5 com iniciais), medalhas de bronze/prata/ouro e fichas.
   - Dupla: P1 no teclado WASD + J/K, P2 nas setas + Enter/Shift direito; dois controles (gamepad)
     também funcionam; no celular cada jogador ganha seu próprio direcional e botões.
   - Enquanto está aberto, a campanha fica parada (não conta tempo) e o jogo ignora as teclas.
   Progresso salvo só neste aparelho: 'daroca-fliperama-v1'. Não mexe no save da campanha.
   Para criar um minigame novo, veja docs/FLIPERAMA.md: é só acrescentar um objeto em GAMES. */
(() => {
  'use strict';
  if (window.Fliperama) return;
  const W = 960, H = 540, LW = 480, LH = 270, KEY = 'daroca-fliperama-v1';
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v)), rnd = (a, b) => a + Math.random() * (b - a), irnd = (a, b) => Math.floor(rnd(a, b + 1));
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const MEDALS = ['', 'BRONZE', 'PRATA', 'OURO'], MEDAL_COL = ['#7a7a7a', '#c98a4a', '#cfd6dc', '#ffd75a'];

  /* ---------------- dados salvos ---------------- */
  let data = { fichas: 0, games: {} };
  try { const d = JSON.parse(localStorage.getItem(KEY)); if (d && typeof d === 'object') data = { fichas: Number(d.fichas) || 0, games: d.games && typeof d.games === 'object' ? d.games : {} }; } catch (e) {}
  const persist = () => { try { localStorage.setItem(KEY, JSON.stringify(data)); } catch (e) {} };
  const rec = (id) => (data.games[id] = data.games[id] || { solo: [], duo: [], medal: 0, plays: 0, wins: [0, 0] });

  /* ---------------- sons sintetizados ---------------- */
  let actx = null, muted = false;
  function sfx(name) {
    if (muted) return;
    try {
      actx = actx || new (window.AudioContext || window.webkitAudioContext)(); if (actx.state === 'suspended') actx.resume();
      const now = actx.currentTime, out = actx.createGain(); out.gain.value = .045; out.connect(actx.destination);
      const tone = (f, f2, d, type = 'square', at = 0, vol = 1) => { const o = actx.createOscillator(), g = actx.createGain(); o.type = type; o.frequency.setValueAtTime(f, now + at); if (f2) o.frequency.exponentialRampToValueAtTime(Math.max(30, f2), now + at + d); g.gain.setValueAtTime(vol, now + at); g.gain.exponentialRampToValueAtTime(.001, now + at + d); o.connect(g); g.connect(out); o.start(now + at); o.stop(now + at + d + .02); };
      const noise = (d, vol = 1, at = 0) => { const len = Math.floor(actx.sampleRate * d), buf = actx.createBuffer(1, len, actx.sampleRate), ch = buf.getChannelData(0); for (let i = 0; i < len; i++) ch[i] = (Math.random() * 2 - 1) * (1 - i / len); const s = actx.createBufferSource(), g = actx.createGain(); s.buffer = buf; g.gain.value = vol; s.connect(g); g.connect(out); s.start(now + at); };
      ({
        pick: () => { tone(880, 1320, .08); tone(1320, 1760, .08, 'square', .06); },
        hit: () => { tone(220, 110, .12); noise(.06, .5); },
        bounce: () => tone(520, 480, .05),
        break: () => { noise(.12, .7); tone(330, 160, .1, 'triangle'); },
        lose: () => { tone(330, 220, .18); tone(220, 110, .3, 'square', .16); },
        win: () => [523, 659, 784, 1046].forEach((f, i) => tone(f, f, .16, 'square', i * .1)),
        tick: () => tone(660, 660, .05),
        go: () => tone(990, 990, .25),
        move: () => tone(330, 330, .03, 'triangle', 0, .6),
        pull: () => tone(180 + Math.random() * 40, 120, .06, 'triangle'),
        power: () => [660, 880, 1100].forEach((f, i) => tone(f, f * 1.1, .07, 'square', i * .05)),
        crow: () => { tone(520, 900, .18, 'sawtooth'); tone(900, 700, .25, 'sawtooth', .2); tone(760, 420, .5, 'sawtooth', .46); },
        fake: () => { tone(400, 380, .08, 'sawtooth'); tone(420, 360, .1, 'sawtooth', .12); },
        menu: () => tone(440, 660, .06)
      }[name] || (() => tone(500, 500, .05)))();
    } catch (e) {}
  }

  /* ---------------- entrada: P1 e P2 ---------------- */
  const keys = {}, touch = [{ x: 0, y: 0, a: false, b: false }, { x: 0, y: 0, a: false, b: false }];
  const P = [0, 1].map(() => ({ x: 0, y: 0, a: false, b: false, ap: false, bp: false, dirs: [], px: 0, py: 0, pa: false, pb: false }));
  let solo = true, anyPress = { a: false, b: false, back: false, up: false, down: false, left: false, right: false };
  const K1 = { up: ['KeyW'], down: ['KeyS'], left: ['KeyA'], right: ['KeyD'], a: ['KeyJ', 'Space'], b: ['KeyK'] };
  const K2 = { up: ['ArrowUp'], down: ['ArrowDown'], left: ['ArrowLeft'], right: ['ArrowRight'], a: ['Enter', 'NumpadEnter', 'Period', 'Numpad0'], b: ['ShiftRight', 'Comma', 'Numpad1'] };
  const held = (list) => list.some((k) => keys[k]);
  function readPads() {
    const out = [null, null];
    try { const pads = [...(navigator.getGamepads?.() || [])].filter(Boolean); pads.slice(0, 2).forEach((g, i) => { const ax = g.axes[0] || 0, ay = g.axes[1] || 0, bt = (n) => !!g.buttons[n]?.pressed; out[i] = { x: (ax < -.4 || bt(14) ? -1 : ax > .4 || bt(15) ? 1 : 0), y: (ay < -.4 || bt(12) ? -1 : ay > .4 || bt(13) ? 1 : 0), a: bt(0), b: bt(1) || bt(2), start: bt(9) }; }); } catch (e) {}
    return out;
  }
  function pollInput() {
    const pads = readPads();
    for (let i = 0; i < 2; i++) {
      const p = P[i], k = i === 0 ? K1 : K2, both = solo && i === 0; // sozinho: P1 também usa as setas e Enter
      const kk = (n) => held(k[n]) || (both && held(K2[n])), pad = pads[i], t = touch[i];
      const x = (kk('left') ? -1 : 0) + (kk('right') ? 1 : 0) || pad?.x || t.x, y = (kk('up') ? -1 : 0) + (kk('down') ? 1 : 0) || pad?.y || t.y;
      const a = kk('a') || !!pad?.a || t.a, b = kk('b') || !!pad?.b || t.b;
      p.ap = a && !p.pa; p.bp = b && !p.pb;
      if (x && x !== p.px) p.dirs.push(x < 0 ? 'l' : 'r'); if (y && y !== p.py) p.dirs.push(y < 0 ? 'u' : 'd');
      if (p.dirs.length > 3) p.dirs.splice(0, p.dirs.length - 3);
      p.x = x; p.y = y; p.a = a; p.b = b; p.px = x; p.py = y; p.pa = a; p.pb = b;
    }
    const pad0 = pads[0];
    menuNav.start = !!pad0?.start && !menuNav.pstart; menuNav.pstart = !!pad0?.start;
  }
  const menuNav = { start: false, pstart: false };

  /* ---------------- desenho base ---------------- */
  let root = null, cv = null, ctx = null, low = null, g = null, touchUI = null;
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  function txt(c, s, x, y, size = 16, col = '#fff1ca', align = 'center', shadow = '#1b1410') {
    c.font = `${size}px Pixel, monospace`; c.textAlign = align; c.textBaseline = 'middle';
    if (shadow) { c.fillStyle = shadow; c.fillText(s, Math.round(x) + 2, Math.round(y) + 2); }
    c.fillStyle = col; c.fillText(s, Math.round(x), Math.round(y));
  }
  function frame(c, x, y, w, h, fill = '#2a2018', edge = '#e8c27a', inner = '#5a4028') {
    R(c, x + 4, y, w - 8, h, edge); R(c, x, y + 4, w, h - 8, edge); R(c, x + 2, y + 2, w - 4, h - 4, edge);
    R(c, x + 4, y + 4, w - 8, h - 8, inner); R(c, x + 6, y + 6, w - 12, h - 12, fill);
  }
  function hero(c, type, x, y, opt = {}) { try { window.Art?.drawCharacter?.(c, type, x, y, { facing: 1, frame: 0, scale: 1, grounded: true, ...opt }); } catch (e) {} }
  const PLAYER_TYPES = ['daroca', 'reeis'], PLAYER_COL = ['#ffb347', '#7ad1ff'], PLAYER_NAME = ['DA ROÇA', 'REEIS'];

  /* ---------------- minigames ---------------- */
  // Cada jogo: init(st), update(st, dt), drawLow(g, st) em 480x270, drawMain(c, st) em 960x540 (texto e personagens).
  const GAMES = [];

  // 1. MINHOCA DO CAFEZAL (estilo "cobrinha")
  GAMES.push({
    id: 'minhoca', name: 'MINHOCA DO CAFEZAL', sub: 'Coma café, cresça e não se enrole.', color: '#e86a8a', duo: 'versus', medals: [120, 300, 600],
    rules: ['Coma os grãos de café para crescer (+10).', 'O milho dourado vale +50, mas some rápido.', 'Bateu na cerca ou no próprio corpo, acabou.'],
    rulesDuo: ['Cada um tem sua minhoca e come o que achar.', 'Quem bater em corpo ou cerca primeiro perde.', 'Cabeça com cabeça: empate.'],
    controls: ['Direcional: virar a minhoca'],
    init(st) {
      st.cols = 58; st.rows = 30; st.ox = 8; st.oy = 18; st.cell = 8; st.step = 0; st.food = []; st.gold = null; st.goldT = 10;
      const mk = (x, y, dx, col, head) => ({ body: [0, 1, 2, 3].map((i) => ({ x: x - dx * i, y })), dir: { x: dx, y: 0 }, q: [], alive: true, col, head, eat: 0 });
      st.worms = st.mode === 'duo' ? [mk(8, 8, 1, '#ff8fb0', '#e8507a'), mk(49, 21, -1, '#8fe0ff', '#3a9ad0')] : [mk(10, 15, 1, '#ff8fb0', '#e8507a')];
      for (let i = 0; i < 3; i++) this.spawn(st);
    },
    free(st, x, y) { return !st.worms.some((w) => w.body.some((b) => b.x === x && b.y === y)) && !st.food.some((f) => f.x === x && f.y === y); },
    spawn(st) { for (let k = 0; k < 200; k++) { const x = irnd(1, st.cols - 2), y = irnd(1, st.rows - 2); if (this.free(st, x, y)) { st.food.push({ x, y }); return; } } },
    update(st, dt) {
      st.worms.forEach((w, i) => { const p = P[i]; while (p.dirs.length) { const d = p.dirs.shift(), v = { u: [0, -1], d: [0, 1], l: [-1, 0], r: [1, 0] }[d], last = w.q.length ? w.q[w.q.length - 1] : w.dir; if (v[0] === -last.x && v[1] === -last.y || v[0] === last.x && v[1] === last.y) continue; if (w.q.length < 2) w.q.push({ x: v[0], y: v[1] }); } });
      st.goldT -= dt; if (!st.gold && st.goldT <= 0) { for (let k = 0; k < 100; k++) { const x = irnd(1, st.cols - 2), y = irnd(1, st.rows - 2); if (this.free(st, x, y)) { st.gold = { x, y, life: 6 }; break; } } st.goldT = 14; }
      if (st.gold) { st.gold.life -= dt; if (st.gold.life <= 0) st.gold = null; }
      const len = Math.max(...st.worms.map((w) => w.body.length)), period = st.mode === 'duo' ? .1 : Math.max(.055, .12 - len * .0016);
      st.step += dt; if (st.step < period) return; st.step = 0;
      const heads = st.worms.map((w) => { if (!w.alive) return null; if (w.q.length) w.dir = w.q.shift(); return { x: w.body[0].x + w.dir.x, y: w.body[0].y + w.dir.y }; });
      st.worms.forEach((w, i) => { const h = heads[i]; if (!h) return; let dead = h.x < 0 || h.y < 0 || h.x >= st.cols || h.y >= st.rows;
        for (const o of st.worms) for (let j = 0; j < o.body.length - (o === w && !w.eat ? 1 : 0); j++) if (o.body[j].x === h.x && o.body[j].y === h.y) dead = true;
        heads.forEach((h2, k) => { if (k !== i && h2 && h2.x === h.x && h2.y === h.y) dead = true; });
        if (dead) { w.alive = false; w.deadAt = st.t; } });
      st.worms.forEach((w, i) => { const h = heads[i]; if (!h || !w.alive) return; w.body.unshift(h); if (w.eat > 0) w.eat--; else w.body.pop();
        const fi = st.food.findIndex((f) => f.x === h.x && f.y === h.y); if (fi >= 0) { st.food.splice(fi, 1); this.spawn(st); w.eat += 2; st.score[i] += 10; sfx('pick'); st.pop.push({ x: st.ox + h.x * 8 + 4, y: st.oy + h.y * 8, s: '+10', t: 0 }); }
        if (st.gold && st.gold.x === h.x && st.gold.y === h.y) { st.gold = null; w.eat += 4; st.score[i] += 50; sfx('power'); st.pop.push({ x: st.ox + h.x * 8 + 4, y: st.oy + h.y * 8, s: '+50', t: 0 }); } });
      const dead = st.worms.filter((w) => !w.alive).length;
      if (dead) { sfx('lose'); if (st.mode === 'solo') st.end({ score: st.score[0], text: 'A minhoca se enrolou!' });
        else if (dead === 2) st.end({ winner: null, text: 'Bateram juntos: empate!' });
        else { const win = st.worms[0].alive ? 0 : 1; st.end({ winner: win, text: PLAYER_NAME[win] + ' venceu a corrida da minhoca!' }); } }
    },
    drawLow(g, st) {
      R(g, 0, 0, LW, LH, '#5a3a22');
      for (let y = 0; y < st.rows; y++) for (let x = 0; x < st.cols; x++) { const v = hash(x * 31 + y * 7); R(g, st.ox + x * 8, st.oy + y * 8, 8, 8, (x + y) % 2 ? '#6e4a2c' : '#684528'); if (v > .93) R(g, st.ox + x * 8 + 3, st.oy + y * 8 + 3, 2, 1, '#8a6040'); }
      for (let x = 0; x < st.cols; x += 6) { R(g, st.ox + x * 8 + 2, st.oy - 6, 4, 5, '#2f6b3c'); R(g, st.ox + x * 8, st.oy - 4, 8, 2, '#3f8a4a'); }
      R(g, st.ox - 4, st.oy - 2, st.cols * 8 + 8, 2, '#a07848'); R(g, st.ox - 4, st.oy + st.rows * 8, st.cols * 8 + 8, 2, '#a07848'); R(g, st.ox - 4, st.oy, 2, st.rows * 8, '#a07848'); R(g, st.ox + st.cols * 8 + 2, st.oy, 2, st.rows * 8, '#a07848');
      for (const f of st.food) { const x = st.ox + f.x * 8, y = st.oy + f.y * 8; R(g, x + 2, y + 2, 4, 5, '#b8242c'); R(g, x + 3, y + 2, 2, 1, '#ff7a6a'); R(g, x + 4, y + 1, 1, 2, '#3f8a4a'); }
      if (st.gold) { const x = st.ox + st.gold.x * 8, y = st.oy + st.gold.y * 8, bl = st.gold.life < 2 && Math.floor(st.t * 8) % 2; if (!bl) { R(g, x + 2, y + 1, 4, 7, '#f6c445'); R(g, x + 3, y + 2, 1, 1, '#fff2a0'); R(g, x + 5, y + 4, 1, 1, '#fff2a0'); R(g, x + 1, y + 5, 2, 3, '#7ab84a'); } }
      st.worms.forEach((w) => { w.body.forEach((b, j) => { const x = st.ox + b.x * 8, y = st.oy + b.y * 8, col = !w.alive && Math.floor(st.t * 10) % 2 ? '#fff' : j === 0 ? w.head : w.col; R(g, x + 1, y + 1, 6, 6, col); if (j % 3 === 1) R(g, x + 1, y + 3, 6, 1, w.head); });
        const h = w.body[0], x = st.ox + h.x * 8, y = st.oy + h.y * 8; R(g, x + 2 + Math.max(0, w.dir.x) * 2, y + 2 + Math.max(0, w.dir.y) * 2, 2, 2, '#fff'); R(g, x + 3 + Math.max(0, w.dir.x) * 2, y + 3 + Math.max(0, w.dir.y) * 2, 1, 1, '#000'); });
    },
    drawMain(c, st) {
      if (st.mode === 'solo') txt(c, 'PONTOS ' + st.score[0] + '   TAMANHO ' + st.worms[0].body.length, W / 2, 16, 14);
      else { txt(c, PLAYER_NAME[0] + ' ' + st.score[0], 20, 16, 14, PLAYER_COL[0], 'left'); txt(c, st.score[1] + ' ' + PLAYER_NAME[1], W - 70, 16, 14, PLAYER_COL[1], 'right'); }
    }
  });

  // 2. PINGUE-PONGUE DO PÁTIO (estilo "pong")
  GAMES.push({
    id: 'pong', name: 'PINGUE-PONGUE DO PÁTIO', sub: 'Chinelo na mão, bolinha de papel no ar.', color: '#6ac8a0', duo: 'versus', medals: [400, 800, 1200],
    rules: ['Rebata a bolinha com o chinelo. Quem fizer 7 pontos ganha.', 'Bater com o chinelo em movimento dá efeito na bola.', 'A cada rebatida a bola fica mais rápida.'],
    rulesDuo: ['Um de cada lado da mesa.', 'Quem fizer 7 pontos primeiro vence.', 'Chinelo em movimento dá efeito na bola.'],
    controls: ['Cima e baixo: mover o chinelo'],
    init(st) { st.pads = [{ y: 135, vy: 0 }, { y: 135, vy: 0 }]; st.pts = [0, 0]; st.hits = 0; st.serve(st, Math.random() < .5 ? -1 : 1); st.trail = []; },
    update(st, dt) {
      const b = st.ball, ph = 34;
      st.pads.forEach((p, i) => { let want; if (i === 1 && st.mode === 'solo') { const lag = st.cpuLag = (st.cpuLag || 0) + dt; const target = b.vx > 0 ? b.y + Math.sin(st.t * 1.3) * 10 : 135; want = clamp((target - p.y) / 18, -1, 1); const max = .62 + Math.min(.35, st.pts[0] * .05); want = clamp(want, -max, max); } else want = P[i].y; const nv = want * 210; p.vy = nv; p.y = clamp(p.y + nv * dt, 22 + ph / 2, LH - 6 - ph / 2); });
      if (b.wait > 0) { b.wait -= dt; return; }
      b.x += b.vx * dt; b.y += b.vy * dt; b.vy += b.spin * dt; b.spin *= .985;
      st.trail.push({ x: b.x, y: b.y }); if (st.trail.length > 6) st.trail.shift();
      if (b.y < 24 || b.y > LH - 8) { b.vy = -b.vy; b.y = clamp(b.y, 24, LH - 8); sfx('bounce'); }
      for (const [i, px] of [[0, 22], [1, LW - 22]]) { const p = st.pads[i]; if (Math.abs(b.x - px) < 5 && Math.abs(b.y - p.y) < ph / 2 + 3 && (i === 0 ? b.vx < 0 : b.vx > 0)) { const off = (b.y - p.y) / (ph / 2), sp = Math.min(430, Math.hypot(b.vx, b.vy) + 14); b.vx = (i === 0 ? 1 : -1) * sp * Math.cos(off * .8); b.vy = sp * Math.sin(off * .8); b.spin = p.vy * .9; b.x = px + (i === 0 ? 5 : -5); st.hits++; sfx('hit'); st.shake = .12; } }
      if (b.x < -10 || b.x > LW + 10) { const who = b.x < 0 ? 1 : 0; st.pts[who]++; sfx(who === 0 || st.mode === 'duo' ? 'pick' : 'lose');
        if (st.pts[who] >= 7) { if (st.mode === 'solo') { const sc = Math.max(0, st.pts[0] * 100 - st.pts[1] * 30 + (who === 0 ? 500 : 0) + st.hits * 5); st.end({ score: sc, win: who === 0, text: who === 0 ? 'Você venceu o Nikolas!' : 'Nikolas venceu desta vez.' }); } else st.end({ winner: who, text: PLAYER_NAME[who] + ' venceu por ' + st.pts[who] + ' a ' + st.pts[1 - who] + '!' }); }
        else st.serve(st, who === 0 ? 1 : -1); }
    },
    drawLow(g, st) {
      R(g, 0, 0, LW, LH, '#2c5a44'); for (let y = 20; y < LH; y += 4) R(g, 0, y, LW, 2, '#2f6048');
      R(g, 6, 20, LW - 12, 2, '#e8f0d8'); R(g, 6, LH - 4, LW - 12, 2, '#e8f0d8'); for (let y = 24; y < LH - 4; y += 10) R(g, LW / 2 - 1, y, 2, 6, '#c8d8b8');
      for (const t of st.trail) R(g, t.x - 1, t.y - 1, 2, 2, 'rgba(255,255,240,.35)');
      const b = st.ball; if (!(b.wait > 0 && Math.floor(st.t * 8) % 2)) { R(g, b.x - 2, b.y - 3, 5, 6, '#f4f0e0'); R(g, b.x - 3, b.y - 2, 7, 4, '#f4f0e0'); R(g, b.x - 1, b.y - 1, 2, 1, '#b8b4a0'); R(g, b.x + 1, b.y + 1, 1, 1, '#b8b4a0'); }
      [[22, 0], [LW - 22, 1]].forEach(([x, i]) => { const y = st.pads[i].y, col = i ? '#3a9ad0' : '#e8823a'; R(g, x - 3, y - 17, 6, 34, col); R(g, x - 2, y - 16, 4, 32, i ? '#7ad1ff' : '#ffb347'); R(g, x - 1, y - 12, 2, 6, '#fff3d0'); R(g, x - 3, y + 6, 6, 2, '#5a3a22'); });
    },
    drawMain(c, st) { txt(c, String(st.pts[0]), W / 2 - 60, 22, 28, PLAYER_COL[0]); txt(c, String(st.pts[1]), W / 2 + 60, 22, 28, st.mode === 'solo' ? '#c9a8ff' : PLAYER_COL[1]); txt(c, PLAYER_NAME[0], 120, 22, 12, PLAYER_COL[0]); txt(c, st.mode === 'solo' ? 'NIKOLAS' : PLAYER_NAME[1], W - 120, 22, 12, st.mode === 'solo' ? '#c9a8ff' : PLAYER_COL[1]); },
    extra: { serve(st, dir) { st.ball = { x: LW / 2, y: 135, vx: 175 * dir, vy: rnd(-60, 60), spin: 0, wait: .9 }; } }
  });

  // 3. QUEBRA-CADERNO (estilo "quebra-blocos")
  GAMES.push({
    id: 'quebra', name: 'QUEBRA-CADERNO', sub: 'Régua, bolinha de papel e um caderno inteiro.', color: '#f0c050', duo: 'coop', medals: [800, 2000, 4000],
    rules: ['Rebata a bolinha com a régua e rasgue todas as páginas.', 'Páginas manchadas de tinta precisam de 2 batidas.', 'Itens: lápis (régua grande), borracha (3 bolas), cola (gruda), coração.'],
    rulesDuo: ['Duas réguas, uma vida em conjunto.', 'P1 na régua de baixo, P2 na de cima.', 'Itens servem para os dois.'],
    controls: ['Esquerda e direita: mover', 'A: soltar a bolinha'],
    init(st) { st.lives = 3; st.level = 0; st.pads = [{ x: 240, w: 52, y: 252 }].concat(st.mode === 'duo' ? [{ x: 240, w: 40, y: 232 }] : []); st.drops = []; st.fx = []; st.wide = 0; st.glue = 0; this.level(st); },
    level(st) {
      const L = st.level % 4; st.bricks = [];
      for (let r = 0; r < 6; r++) for (let c = 0; c < 12; c++) { const on = L === 0 || (L === 1 && (r + c) % 2 === 0) || (L === 2 && Math.abs(c - 5.5) < 6 - r) || (L === 3 && (c % 3 !== 1 || r % 2 === 0)); if (!on) continue; const hp = (r === 0 || (L === 3 && r === 2)) ? 2 : 1; st.bricks.push({ x: 24 + c * 36, y: 34 + r * 13, w: 34, h: 11, hp, row: r }); }
      st.balls = [{ x: 240, y: 240, vx: 0, vy: 0, stuck: 0, sp: 190 + st.level * 18 }]; st.wide = 0; st.glue = 0;
    },
    update(st, dt) {
      st.pads.forEach((p, i) => { p.w = (i ? 40 : 52) + (st.wide > 0 ? 26 : 0); p.x = clamp(p.x + P[i].x * 250 * dt, p.w / 2 + 6, LW - 6 - p.w / 2); });
      st.wide = Math.max(0, st.wide - dt); st.glue = Math.max(0, st.glue - dt);
      for (const b of st.balls) {
        if (b.stuck !== false && b.stuck !== undefined && b.stuck !== null) { const p = st.pads[b.stuck]; b.x = p.x + (b.off || 0); b.y = p.y - 5; if (P[b.stuck].ap || (st.mode === 'solo' && P[0].ap)) { const a = rnd(-.5, .5); b.vx = Math.sin(a) * b.sp; b.vy = -Math.cos(a) * b.sp; b.stuck = null; sfx('bounce'); } continue; }
        b.x += b.vx * dt; b.y += b.vy * dt;
        if (b.x < 6) { b.x = 6; b.vx = Math.abs(b.vx); sfx('bounce'); } if (b.x > LW - 6) { b.x = LW - 6; b.vx = -Math.abs(b.vx); sfx('bounce'); } if (b.y < 22) { b.y = 22; b.vy = Math.abs(b.vy); sfx('bounce'); }
        st.pads.forEach((p, i) => { if (b.vy > 0 && b.y > p.y - 5 && b.y < p.y + 2 && Math.abs(b.x - p.x) < p.w / 2 + 3) { const off = (b.x - p.x) / (p.w / 2), sp = Math.hypot(b.vx, b.vy) * 1.01; b.vx = Math.sin(off * 1.05) * sp; b.vy = -Math.abs(Math.cos(off * 1.05) * sp); b.y = p.y - 5; if (st.glue > 0) { b.stuck = i; b.off = b.x - p.x; } sfx('hit'); } });
        for (const k of st.bricks) { if (k.hp <= 0) continue; if (b.x > k.x - 2 && b.x < k.x + k.w + 2 && b.y > k.y - 2 && b.y < k.y + k.h + 2) { const ox = Math.min(b.x - k.x + 2, k.x + k.w + 2 - b.x), oy = Math.min(b.y - k.y + 2, k.y + k.h + 2 - b.y); if (ox < oy) b.vx = -b.vx; else b.vy = -b.vy; k.hp--; if (k.hp <= 0) { st.score[0] += k.row === 0 ? 25 : 10; sfx('break'); for (let j = 0; j < 6; j++) st.fx.push({ x: k.x + rnd(0, k.w), y: k.y + rnd(0, k.h), vx: rnd(-60, 60), vy: rnd(-80, 10), t: 0 }); if (Math.random() < .14) st.drops.push({ x: k.x + k.w / 2, y: k.y, kind: ['lapis', 'borracha', 'cola', 'coracao'][Math.random() < .1 ? 3 : irnd(0, 2)] }); } else sfx('hit'); break; } }
      }
      st.balls = st.balls.filter((b) => b.y < LH + 6);
      if (!st.balls.length) { st.lives--; sfx('lose'); st.shake = .3; if (st.lives <= 0) { st.end({ score: st.score[0], text: 'O caderno venceu desta vez.' }); return; } st.balls = [{ x: 240, y: 240, stuck: 0, sp: 190 + st.level * 18 }]; }
      for (const d of st.drops) { d.y += 70 * dt; st.pads.forEach((p) => { if (!d.got && Math.abs(d.y - p.y) < 6 && Math.abs(d.x - p.x) < p.w / 2 + 5) { d.got = true; sfx('power'); if (d.kind === 'lapis') st.wide = 12; else if (d.kind === 'cola') st.glue = 10; else if (d.kind === 'coracao') st.lives = Math.min(5, st.lives + 1); else { const src = st.balls.find((b) => b.stuck === null || b.stuck === undefined) || st.balls[0]; if (src) for (const a of [-.5, .5]) st.balls.push({ x: src.x, y: src.y, vx: Math.sin(a) * src.sp, vy: -Math.cos(a) * src.sp, sp: src.sp, stuck: null }); } } }); }
      st.drops = st.drops.filter((d) => !d.got && d.y < LH);
      for (const f of st.fx) { f.t += dt; f.x += f.vx * dt; f.y += f.vy * dt; f.vy += 200 * dt; } st.fx = st.fx.filter((f) => f.t < .7);
      if (!st.bricks.some((k) => k.hp > 0)) { st.score[0] += 200; st.level++; sfx('win'); st.banner = { s: 'CADERNO ' + (st.level + 1), t: 1.6 }; this.level(st); }
    },
    drawLow(g, st) {
      R(g, 0, 0, LW, LH, '#f2ead2'); for (let y = 26; y < LH; y += 10) R(g, 0, y, LW, 1, '#bcd2e6'); R(g, 18, 18, 1, LH, '#e8a0a0');
      const pal = ['#d06a5a', '#e8a04a', '#e8d04a', '#7ab86a', '#5a9ad0', '#9a7ad0'];
      for (const k of st.bricks) { if (k.hp <= 0) continue; R(g, k.x, k.y, k.w, k.h, '#4a3a2a'); R(g, k.x + 1, k.y + 1, k.w - 2, k.h - 2, k.hp > 1 ? '#3a3a6a' : pal[k.row]); R(g, k.x + 2, k.y + 2, k.w - 4, 1, 'rgba(255,255,255,.5)'); if (k.hp > 1) { R(g, k.x + 6, k.y + 4, 5, 3, '#1a1a3a'); R(g, k.x + 20, k.y + 3, 4, 4, '#1a1a3a'); } else R(g, k.x + 4, k.y + 5, k.w - 8, 1, 'rgba(0,0,0,.18)'); }
      for (const d of st.drops) { const col = { lapis: '#e8c23a', borracha: '#e88aa0', cola: '#f4f4f4', coracao: '#e84a5a' }[d.kind]; R(g, d.x - 5, d.y - 4, 10, 8, '#3a2a1a'); R(g, d.x - 4, d.y - 3, 8, 6, col); }
      for (const f of st.fx) R(g, f.x, f.y, 2, 2, '#c8b890');
      st.pads.forEach((p, i) => { R(g, p.x - p.w / 2, p.y, p.w, 5, '#6a4a2a'); R(g, p.x - p.w / 2 + 1, p.y + 1, p.w - 2, 3, i ? '#7ad1ff' : (st.glue > 0 ? '#e0f0e0' : '#e8c070')); for (let x = 4; x < p.w - 2; x += 4) R(g, p.x - p.w / 2 + x, p.y + 1, 1, x % 8 ? 1 : 2, '#6a4a2a'); });
      for (const b of st.balls) { R(g, b.x - 2, b.y - 3, 5, 6, '#fffaf0'); R(g, b.x - 3, b.y - 2, 7, 4, '#fffaf0'); R(g, b.x - 1, b.y - 1, 2, 1, '#a8a490'); }
    },
    drawMain(c, st) { txt(c, 'PONTOS ' + st.score[0], 20, 16, 14, '#fff1ca', 'left'); txt(c, 'CADERNO ' + (st.level + 1), W / 2, 16, 14); txt(c, '♥'.repeat(Math.max(0, st.lives)), W - 70, 16, 16, '#ff6a7a', 'right'); if (st.balls.some((b) => b.stuck !== null && b.stuck !== undefined)) txt(c, 'APERTE A PARA SOLTAR', W / 2, 420, 14, '#3a2a1a', 'center', null); }
  });

  // 4. CABO DE GUERRA
  GAMES.push({
    id: 'cabo', name: 'CABO DE GUERRA', sub: 'Puxa que é de puxar!', color: '#e8823a', duo: 'versus', medals: [500, 900, 1200],
    rules: ['Aperte A e B alternando, bem rápido, para puxar a corda.', 'Apertar quando o círculo fica verde dá puxão dobrado.', 'Leve a fita até o seu lado. Melhor de 3 contra o Nikolas.'],
    rulesDuo: ['Cada um puxa para o seu lado alternando A e B.', 'Círculo verde: puxão dobrado.', 'Melhor de 3 rodadas.'],
    controls: ['A e B alternados: puxar'],
    init(st) { st.rope = 0; st.v = 0; st.round = 1; st.wins = [0, 0]; st.last = [null, null]; st.taps = [0, 0]; st.pulse = [0, .5]; st.cpuT = 0; st.pause = 1.2; st.mud = []; },
    update(st, dt) {
      st.pulse = st.pulse.map((p, i) => (p + dt * (1.1 + i * .13)) % 1);
      if (st.pause > 0) { st.pause -= dt; return; }
      const force = [0, 0];
      for (let i = 0; i < 2; i++) { const cpu = i === 1 && st.mode === 'solo'; let press = null;
        if (cpu) { st.cpuT -= dt; if (st.cpuT <= 0) { press = st.last[1] === 'a' ? 'b' : 'a'; st.cpuT = 1 / (5.6 + st.round * .9 + Math.sin(st.t * 2) * 1.2); } }
        else press = P[i].ap ? 'a' : P[i].bp ? 'b' : null;
        if (!press) continue; const sweet = Math.abs(st.pulse[i] - .5) < .12;
        if (press !== st.last[i]) { force[i] += (cpu ? .017 : .02) * (sweet ? 2 : 1); st.taps[i]++; if (sweet && !cpu) st.pop.push({ x: i ? 360 : 120, y: 70, s: 'FORTE!', t: 0 }); sfx('pull'); } else force[i] += .003;
        st.last[i] = press; }
      st.v += (force[1] - force[0]) * 6; st.v *= Math.pow(.02, dt); st.rope = clamp(st.rope + st.v * dt, -1.05, 1.05);
      if (Math.abs(st.rope) >= 1) { const w = st.rope < 0 ? 0 : 1; st.wins[w]++; sfx(w === 0 || st.mode === 'duo' ? 'win' : 'lose'); st.shake = .4; for (let j = 0; j < 14; j++) st.mud.push({ x: 240 + rnd(-20, 20), y: 214, vx: rnd(-90, 90), vy: rnd(-140, -40), t: 0 });
        if (st.wins[w] >= 2) { if (st.mode === 'solo') st.end({ score: st.wins[0] * 300 + (w === 0 ? 400 : 0) + st.taps[0] * 2, win: w === 0, text: w === 0 ? 'Nikolas caiu na lama!' : 'Você foi parar na lama!' }); else st.end({ winner: w, text: (w ? PLAYER_NAME[1] : PLAYER_NAME[0]) + ' venceu o cabo de guerra!' }); }
        else { st.round++; st.rope = 0; st.v = 0; st.pause = 1.4; st.banner = { s: 'RODADA ' + st.round, t: 1.3 }; } }
      for (const m of st.mud) { m.t += dt; m.x += m.vx * dt; m.y += m.vy * dt; m.vy += 300 * dt; } st.mud = st.mud.filter((m) => m.t < 1);
    },
    drawLow(g, st) {
      for (let i = 0; i < 12; i++) R(g, 0, i * 12, LW, 12, ['#f3b06a', '#f0a060', '#e89058', '#e08050', '#d87850', '#c87050', '#b8684e', '#a8624e', '#98604e', '#885a4c', '#78544a', '#685048'][i]);
      R(g, 0, 140, LW, 70, '#5a8a4a'); for (let x = 0; x < LW; x += 30) R(g, x + (x % 60 ? 0 : 8), 150 + (x % 3) * 6, 20, 2, '#6a9a52');
      R(g, 0, 210, LW, 60, '#6a9a4a'); R(g, 210, 208, 60, 10, '#5a3a22'); R(g, 214, 210, 52, 6, '#7a4a2a'); for (let i = 0; i < 6; i++) R(g, 216 + i * 9, 211 + (i % 2) * 2, 4, 1, '#9a6a3a');
      const off = st.rope * 150, ry = 178; for (let x = 60; x < 420; x += 4) R(g, x + off % 4, ry + Math.round(Math.sin((x + st.t * 40) * .05) * (Math.abs(st.v) * 2)), 4, 3, x % 8 ? '#c8a060' : '#a88040');
      R(g, 238 + off, ry - 8, 4, 18, '#e84a3a'); R(g, 236 + off, ry - 10, 8, 4, '#ff7a5a');
      R(g, 240 - 150, 200, 2, 16, '#fff'); R(g, 240 + 150, 200, 2, 16, '#fff');
      for (const m of st.mud) R(g, m.x, m.y, 3, 3, '#5a3a22');
      for (let i = 0; i < 2; i++) { const x = i ? 400 : 80, y = 60, p = st.pulse[i], r = 6 + Math.abs(p - .5) * 22, sweet = Math.abs(p - .5) < .12; if (i === 1 && st.mode === 'solo') continue; for (let a = 0; a < 24; a++) { const an = a / 24 * Math.PI * 2; R(g, x + Math.cos(an) * r, y + Math.sin(an) * r, 2, 2, sweet ? '#7af07a' : '#fff3d0'); } R(g, x - 1, y - 1, 3, 3, '#7af07a'); }
    },
    drawMain(c, st) {
      const off = st.rope * 300, lean = Math.min(1, Math.abs(st.v) * 3);
      hero(c, 'daroca', 300 + off - 70, 430, { facing: 1, moving: lean > .2, frame: st.t * (1 + lean * 3), scale: 1.3 });
      hero(c, st.mode === 'solo' ? 'nikolas' : 'reeis', 660 + off + 70, 430, { facing: -1, moving: lean > .2, frame: st.t * (1 + lean * 3), scale: 1.3 });
      txt(c, 'RODADA ' + st.round, W / 2, 20, 14); txt(c, '● '.repeat(st.wins[0]) + '○ '.repeat(2 - st.wins[0]), 30, 20, 14, PLAYER_COL[0], 'left'); txt(c, '○ '.repeat(2 - st.wins[1]) + '● '.repeat(st.wins[1]), W - 70, 20, 14, st.mode === 'solo' ? '#c9a8ff' : PLAYER_COL[1], 'right');
      if (st.pause > 0 && st.t > .1) txt(c, 'PREPARA...', W / 2, 250, 24, '#fff3d0');
    }
  });

  // 5. CHUVA DE CHINELO (desviar)
  GAMES.push({
    id: 'chinelo', name: 'CHUVA DE CHINELO', sub: 'A mãe ficou brava. Corre!', color: '#7a9ae8', duo: 'coop', medals: [800, 2000, 4000],
    rules: ['Desvie dos chinelos que caem. A sombra mostra onde vão cair.', 'Pegue os copos de açaí (+50). O coração devolve uma vida.', 'O chinelo voador passa rasteiro: pule!'],
    rulesDuo: ['Os dois correm juntos e somam pontos.', 'Cada um tem 3 vidas. Coração revive o parceiro.', 'Acaba quando os dois caírem.'],
    controls: ['Esquerda e direita: correr', 'A: pular'],
    init(st) { st.pl = (st.mode === 'duo' ? [180, 300] : [240]).map((x, i) => ({ x, y: 0, vy: 0, hp: 3, inv: 0, face: 1, i })); st.items = []; st.spawn = 0; st.flyT = 8; st.time = 0; st.acai = 0; },
    update(st, dt) {
      st.time += dt; const diff = Math.min(1, st.time / 90);
      st.pl.forEach((p) => { if (p.hp <= 0) return; const i = p.i; p.x = clamp(p.x + P[i].x * 170 * dt, 12, LW - 12); if (P[i].x) p.face = P[i].x; if (p.y === 0 && P[i].ap) { p.vy = 230; sfx('bounce'); } p.vy -= 620 * dt; p.y = Math.max(0, p.y + p.vy * dt); if (p.y === 0) p.vy = 0; p.inv = Math.max(0, p.inv - dt); });
      st.spawn -= dt; if (st.spawn <= 0) { st.spawn = Math.max(.22, .85 - diff * .6); const x = rnd(14, LW - 14), r = Math.random(); st.items.push({ kind: r < .1 ? 'acai' : r < .118 ? 'coracao' : 'chinelo', x, y: -30, vy: 0, warn: .7 - diff * .25, rot: rnd(0, 6) }); }
      st.flyT -= dt; if (st.flyT <= 0) { st.flyT = rnd(6, 11) - diff * 3; const dir = Math.random() < .5 ? 1 : -1; st.items.push({ kind: 'voador', x: dir > 0 ? -20 : LW + 20, y: 232, vx: dir * (190 + diff * 90), warn: .8 }); }
      for (const it of st.items) {
        if (it.warn > 0) { it.warn -= dt; continue; }
        if (it.kind === 'voador') it.x += it.vx * dt; else { it.vy += 520 * dt; it.y += it.vy * dt; it.rot += dt * 8; }
        for (const p of st.pl) { if (p.hp <= 0 || it.done) continue; const py = 248 - p.y, hit = it.kind === 'voador' ? Math.abs(it.x - p.x) < 10 && p.y < 14 : Math.abs(it.x - p.x) < 12 && it.y > py - 30 && it.y < py;
          if (!hit) continue;
          if (it.kind === 'acai') { it.done = true; st.acai++; st.score[0] += 50; sfx('pick'); st.pop.push({ x: it.x, y: py - 30, s: '+50', t: 0 }); }
          else if (it.kind === 'coracao') { it.done = true; const dead = st.pl.find((q) => q.hp <= 0); if (dead) { dead.hp = 1; dead.inv = 2; } else p.hp = Math.min(3, p.hp + 1); sfx('power'); }
          else if (p.inv <= 0) { p.hp--; p.inv = 1.3; it.done = it.kind !== 'voador'; sfx('hit'); st.shake = .25; } }
        if (it.kind !== 'voador' && it.y > 250) { it.done = true; if (it.kind === 'chinelo') for (let j = 0; j < 3; j++) st.pop.push({ x: it.x + rnd(-6, 6), y: 248, s: '·', t: 0 }); }
        if (it.kind === 'voador' && (it.x < -40 || it.x > LW + 40)) it.done = true;
      }
      st.items = st.items.filter((it) => !it.done);
      st.score[0] += dt * 10;
      if (st.pl.every((p) => p.hp <= 0)) { sfx('lose'); st.end({ score: Math.round(st.score[0]), text: 'Sobreviveu ' + Math.floor(st.time) + ' segundos e pegou ' + st.acai + ' açaí.' }); }
    },
    drawLow(g, st) {
      R(g, 0, 0, LW, 250, '#c4cca8'); for (let i = 0; i < 10; i++) R(g, 0, i * 20, LW, 20, ['#8ec7e1', '#94cbe2', '#9ccfe2', '#a6d3e0', '#b0d6dc', '#bad8d6', '#c2d8cc', '#c8d6c0', '#c8d2b4', '#c4cca8'][i]);
      for (let i = 0; i < 6; i++) { const x = i * 90 + 10, h = 40 + (i % 3) * 18; R(g, x, 250 - h - 20, 70, h, ['#d4a06d', '#bf7956', '#c48b70', '#d98a8a', '#a8b29b', '#b7855e'][i]); for (let w = 0; w < 3; w++) R(g, x + 10 + w * 20, 250 - h - 8, 8, 10, '#5a7a8a'); R(g, x - 3, 250 - h - 22, 76, 4, '#8a5a3a'); }
      R(g, 0, 250, LW, 20, '#9a8a6a'); R(g, 0, 250, LW, 2, '#b8a888'); for (let x = 0; x < LW; x += 24) R(g, x, 258, 12, 1, '#8a7a5a');
      for (const it of st.items) {
        if (it.kind === 'voador') { if (it.warn > 0) { if (Math.floor(st.t * 10) % 2) txt(g, '!', it.vx > 0 ? 10 : LW - 10, 232, 10, '#e84a3a', 'center', null); continue; } R(g, it.x - 10, it.y - 3, 20, 6, '#2a5ad0'); R(g, it.x - 8, it.y - 2, 16, 4, '#4a8af0'); R(g, it.x - 2, it.y - 5, 4, 3, '#f0f0f0'); continue; }
        const sw = Math.max(4, 14 - Math.max(0, 250 - it.y) / 25); R(g, it.x - sw, 249, sw * 2, 2, 'rgba(20,20,30,.35)');
        if (it.warn > 0) continue;
        if (it.kind === 'chinelo') { const v = Math.floor(it.rot) % 2; if (v) { R(g, it.x - 4, it.y - 9, 8, 18, '#2a5ad0'); R(g, it.x - 3, it.y - 8, 6, 16, '#4a8af0'); R(g, it.x - 1, it.y - 6, 2, 5, '#f0f0f0'); } else { R(g, it.x - 9, it.y - 4, 18, 8, '#2a5ad0'); R(g, it.x - 8, it.y - 3, 16, 6, '#4a8af0'); R(g, it.x - 4, it.y - 1, 5, 2, '#f0f0f0'); } }
        else if (it.kind === 'acai') { R(g, it.x - 5, it.y - 8, 10, 10, '#f0f0f0'); R(g, it.x - 4, it.y - 7, 8, 4, '#5a1a5a'); R(g, it.x - 3, it.y - 9, 6, 2, '#9a3a8a'); R(g, it.x + 1, it.y - 13, 1, 5, '#e84a3a'); }
        else { R(g, it.x - 5, it.y - 4, 4, 4, '#e84a5a'); R(g, it.x + 1, it.y - 4, 4, 4, '#e84a5a'); R(g, it.x - 5, it.y - 1, 10, 3, '#e84a5a'); R(g, it.x - 3, it.y + 2, 6, 2, '#e84a5a'); }
      }
    },
    drawMain(c, st) {
      st.pl.forEach((p) => { if (p.hp <= 0) { hero(c, PLAYER_TYPES[p.i], p.x * 2, 500, { facing: p.face, emotion: 'sad', opacity: .4 }); return; } if (p.inv > 0 && Math.floor(st.t * 14) % 2) return; hero(c, PLAYER_TYPES[p.i], p.x * 2, 500 - p.y * 2, { facing: p.face, moving: Math.abs(P[p.i].x) > 0, frame: st.t * 1.5, grounded: p.y === 0, vy: -p.vy }); });
      txt(c, 'PONTOS ' + Math.round(st.score[0]), W / 2, 16, 14);
      st.pl.forEach((p, i) => txt(c, (st.mode === 'duo' ? PLAYER_NAME[i] + ' ' : '') + '♥'.repeat(Math.max(0, p.hp)) + '♡'.repeat(3 - Math.max(0, p.hp)), i ? W - 20 : 20, 16, 14, PLAYER_COL[i], i ? 'right' : 'left'));
    }
  });

  // 6. REFLEXO DO GALO
  GAMES.push({
    id: 'galo', name: 'REFLEXO DO GALO', sub: 'Cocoricó! Quem aperta primeiro?', color: '#e8c050', duo: 'versus', medals: [1200, 1800, 2200],
    rules: ['Espere o galo cantar COCORICÓ! e aperte A o mais rápido que puder.', 'Cuidado: a galinha e o pato também fazem barulho. Não caia!', '5 rodadas. Quanto mais rápido, mais pontos.'],
    rulesDuo: ['Os dois esperam o COCORICÓ!', 'Quem apertar primeiro ganha a rodada.', 'Apertou antes da hora? O ponto vai para o outro. Vence quem fizer 3.'],
    controls: ['A: apertar'],
    init(st) { st.round = 0; st.times = []; st.pts = [0, 0]; st.next(st); },
    update(st, dt) {
      const r = st.r;
      if (r.state === 'wait') {
        r.wait -= dt; if (r.fakeAt !== null && r.wait <= r.fakeAt) { r.fake = { s: Math.random() < .5 ? 'COCÓ...' : 'QUÉN!', t: .8 }; r.fakeAt = null; sfx('fake'); }
        if (r.fake) { r.fake.t -= dt; if (r.fake.t <= 0) r.fake = null; }
        for (let i = 0; i < (st.mode === 'duo' ? 2 : 1); i++) if (P[i].ap) { r.state = 'early'; r.who = i; r.t = 0; sfx('lose'); st.shake = .2; if (st.mode === 'duo') st.pts[1 - i]++; else st.times.push(600); }
        if (r.state === 'wait' && r.wait <= 0) { r.state = 'go'; r.t = 0; sfx('crow'); }
      } else if (r.state === 'go') {
        r.t += dt; for (let i = 0; i < (st.mode === 'duo' ? 2 : 1); i++) if (P[i].ap && r.state === 'go') { r.state = 'hit'; r.who = i; r.ms = Math.round(r.t * 1000); r.t2 = 0; sfx('pick'); if (st.mode === 'duo') st.pts[i]++; else st.times.push(r.ms); }
        if (r.state === 'go' && r.t > 2) { r.state = 'hit'; r.who = null; r.ms = 2000; r.t2 = 0; if (st.mode === 'solo') st.times.push(1000); }
      } else { r.t2 = (r.t2 || 0) + dt; r.t = (r.t || 0) + dt;
        if ((r.t2 > 1.6 && r.state === 'hit') || (r.state === 'early' && r.t > 1.6)) {
          const done = st.mode === 'solo' ? st.times.length >= 5 : Math.max(...st.pts) >= 3;
          if (done) { if (st.mode === 'solo') { const sc = st.times.reduce((s, ms) => s + Math.max(0, 800 - ms), 0), avg = Math.round(st.times.reduce((a, b) => a + b, 0) / st.times.length); st.end({ score: sc, text: 'Tempo médio: ' + avg + ' ms' }); } else { const w = st.pts[0] > st.pts[1] ? 0 : 1; st.end({ winner: w, text: PLAYER_NAME[w] + ' tem o reflexo mais rápido da roça!' }); } }
          else st.next(st);
        } }
    },
    drawLow(g, st) {
      const r = st.r, go = r.state === 'go' || r.state === 'hit';
      for (let i = 0; i < 12; i++) R(g, 0, i * 12, LW, 12, go ? ['#f8d890', '#f8d088', '#f4c880', '#f0c078', '#ecb870', '#e8b068', '#e0a860', '#d8a058', '#d09850', '#c89048', '#c08840', '#b88038'][i] : ['#2a3058', '#323862', '#3a406a', '#444870', '#4e5076', '#5a587a', '#66607c', '#72687e', '#7e7080', '#8a7880', '#968080', '#a08880'][i]);
      R(g, 0, 150, LW, 120, go ? '#6a9a4a' : '#3a5a3a'); for (let x = 0; x < LW; x += 40) { R(g, x, 160, 4, 40, '#7a5a3a'); } R(g, 0, 168, LW, 3, '#8a6a4a'); R(g, 0, 184, LW, 3, '#8a6a4a');
      const bx = 240, by = 168 - (go ? 6 : 0);
      R(g, bx - 10, by - 18, 20, 16, '#f4f0e0'); R(g, bx - 14, by - 16, 6, 10, '#2a5a3a'); R(g, bx - 16, by - 22, 6, 10, '#3a7a4a'); R(g, bx + 6, by - 30, 10, 12, '#f4f0e0'); R(g, bx + 8, by - 34, 6, 4, '#e83a3a'); R(g, bx + 16, by - 26, go ? 6 : 4, 3, '#e8a83a'); R(g, bx + 12, by - 27, 2, 2, '#1a1a1a'); R(g, bx + 10, by - 20, 4, 4, '#e83a3a'); R(g, bx - 4, by - 2, 2, 4, '#e8a83a'); R(g, bx + 3, by - 2, 2, 4, '#e8a83a');
      if (go) for (let i = 0; i < 8; i++) { const a = i / 8 * Math.PI * 2 + st.t; R(g, bx + Math.cos(a) * (40 + (st.t * 60) % 30), by - 24 + Math.sin(a) * (24 + (st.t * 40) % 20), 3, 3, '#fff3a0'); }
      if (r.fake) { R(g, 90, 150, 14, 10, '#e8d8c0'); R(g, 100, 146, 6, 6, '#e8d8c0'); R(g, 106, 148, 3, 2, '#e8a83a'); }
    },
    drawMain(c, st) {
      const r = st.r;
      if (r.state === 'wait') txt(c, r.fake ? r.fake.s : 'ESPERA...', W / 2, 140, r.fake ? 26 : 22, r.fake ? '#ffd0a0' : '#c8c8e8');
      if (r.state === 'go') txt(c, 'COCORICÓ!', W / 2, 140, 44, '#fff3a0', 'center', '#a04010');
      if (r.state === 'early') txt(c, (st.mode === 'duo' ? PLAYER_NAME[r.who] + ' ' : '') + 'APERTOU ANTES!', W / 2, 140, 26, '#ff8a7a');
      if (r.state === 'hit') txt(c, r.who === null ? 'NINGUÉM APERTOU!' : (st.mode === 'duo' ? PLAYER_NAME[r.who] + ' · ' : '') + r.ms + ' ms', W / 2, 140, 32, r.who === null ? '#ff8a7a' : PLAYER_COL[r.who || 0]);
      const n = st.mode === 'duo' ? 2 : 1; for (let i = 0; i < n; i++) { const x = n === 1 ? W / 2 : i ? 720 : 240, react = r.state === 'hit' && r.who === i; hero(c, PLAYER_TYPES[i], x, 520, { facing: i ? -1 : 1, attack: react, attackProgress: .5, emotion: r.state === 'early' && r.who === i ? 'embarrassed' : undefined, frame: st.t, scale: 1.4 }); }
      if (st.mode === 'solo') txt(c, 'RODADA ' + Math.min(5, st.times.length + (r.state === 'wait' || r.state === 'go' ? 1 : 0)) + ' / 5', W / 2, 18, 14);
      else { txt(c, PLAYER_NAME[0] + ' ' + st.pts[0], 20, 18, 14, PLAYER_COL[0], 'left'); txt(c, st.pts[1] + ' ' + PLAYER_NAME[1], W - 70, 18, 14, PLAYER_COL[1], 'right'); }
    },
    extra: { next(st) { st.round++; const wait = rnd(1.6, 4.4); st.r = { state: 'wait', wait, fakeAt: Math.random() < .55 ? rnd(.6, wait - .5) : null, fake: null, t: 0 }; } }
  });

  /* ---------------- telas: menu, regras, jogo, fim ---------------- */
  let open = false, screen = 'menu', sel = 0, modeSel = 0, st = null, game = null, cd = 0, from = null, t = 0, last = 0, raf = 0, clicks = [], initials = null, overSel = 0, paused = false, pauseSel = 0;
  function startGame(gm, mode) {
    game = gm; solo = mode === 'solo';
    st = { mode, t: 0, score: [0, 0], pop: [], shake: 0, banner: null, ended: null };
    Object.assign(st, gm.extra || {});
    st.end = (r) => { if (!st.ended) { st.ended = r; st.endT = 0; } };
    gm.init(st); screen = 'count'; cd = 3.2; paused = false; P.forEach((p) => (p.dirs = [])); sfx('menu');
    const r = rec(gm.id); r.plays++; persist();
  }
  function finish() {
    const r = rec(game.id), res = st.ended; let fichas = 0, medal = 0, newMedal = false, qualifies = false;
    if (st.mode === 'solo' || game.duo === 'coop') {
      const score = Math.round(res.score || 0); fichas = 1 + Math.floor(score / 150);
      if (st.mode === 'solo') { medal = game.medals.filter((m) => score >= m).length; if (medal > r.medal) { r.medal = medal; newMedal = true; fichas += medal * 3; } }
      const list = r[st.mode]; qualifies = score > 0 && (list.length < 5 || score > list[list.length - 1].s);
      res.score = score;
    } else { fichas = 2; if (res.winner !== null && res.winner !== undefined) r.wins[res.winner]++; }
    data.fichas += fichas; persist();
    screen = 'over'; overSel = 0; initials = qualifies ? { s: (localStorage.getItem('daroca-fliperama-nome') || 'DRC').slice(0, 3).padEnd(3, 'A').split(''), i: 0 } : null;
    st.summary = { fichas, medal, newMedal };
    sfx(res.win === false || (st.mode === 'solo' && medal === 0 && !res.win) ? 'lose' : 'win');
  }
  function saveInitials() {
    const name = initials.s.join(''); try { localStorage.setItem('daroca-fliperama-nome', name); } catch (e) {}
    const list = rec(game.id)[st.mode]; list.push({ n: name, s: st.ended.score, d: Date.now() }); list.sort((a, b) => b.s - a.s); list.splice(5); persist(); initials = null; sfx('pick');
  }
  const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  function back() {
    sfx('menu');
    if (screen === 'play' || screen === 'count') { paused = !paused; pauseSel = 0; return; }
    if (screen === 'mode') { screen = 'menu'; return; }
    if (screen === 'over') { screen = 'menu'; return; }
    close();
  }
  function updateScreens(dt) {
    const p = P[0], p2 = P[1], ap = p.ap || p2.ap || menuNav.start, nav = (v) => { sfx('move'); return v; };
    const dirs = P[0].dirs.concat(P[1].dirs); P[0].dirs = []; P[1].dirs = [];
    if (paused) { for (const d of dirs) if (d === 'u' || d === 'd') pauseSel = nav(1 - pauseSel); if (ap) { if (pauseSel === 0) paused = false; else { paused = false; screen = 'menu'; } sfx('menu'); } return; }
    if (screen === 'menu') {
      for (const d of dirs) { if (d === 'l') sel = nav((sel + GAMES.length - 1) % GAMES.length); if (d === 'r') sel = nav((sel + 1) % GAMES.length); if (d === 'u') sel = nav((sel + GAMES.length - 3) % GAMES.length); if (d === 'd') sel = nav((sel + 3) % GAMES.length); }
      if (ap) { screen = 'mode'; modeSel = 0; sfx('menu'); }
      if (p.bp || p2.bp) close();
    } else if (screen === 'mode') {
      for (const d of dirs) if (d === 'l' || d === 'r' || d === 'u' || d === 'd') modeSel = nav(1 - modeSel);
      if (ap) startGame(GAMES[sel], modeSel ? 'duo' : 'solo');
      if (p.bp || p2.bp) { screen = 'menu'; sfx('menu'); }
    } else if (screen === 'count') { const before = Math.ceil(cd); cd -= dt; if (Math.ceil(cd) !== before && cd > 0) sfx('tick'); if (cd <= 0) { screen = 'play'; sfx('go'); } st.t += dt; }
    else if (screen === 'play') { st.t += dt; st.shake = Math.max(0, st.shake - dt); for (const q of st.pop) q.t += dt; st.pop = st.pop.filter((q) => q.t < .9); if (st.banner) { st.banner.t -= dt; if (st.banner.t <= 0) st.banner = null; }
      if (!st.ended) game.update(st, dt); else { st.endT += dt; if (st.endT > 1.3) finish(); } }
    else if (screen === 'over') {
      if (initials) { for (const d of dirs) { const k = LETTERS.indexOf(initials.s[initials.i]); if (d === 'u') initials.s[initials.i] = nav(LETTERS[(k + 1) % LETTERS.length]); if (d === 'd') initials.s[initials.i] = nav(LETTERS[(k + LETTERS.length - 1) % LETTERS.length]); if (d === 'l') initials.i = nav(Math.max(0, initials.i - 1)); if (d === 'r') initials.i = nav(Math.min(2, initials.i + 1)); } if (ap) { if (initials.i < 2) { initials.i++; sfx('move'); } else saveInitials(); } return; }
      for (const d of dirs) if (d === 'l' || d === 'r' || d === 'u' || d === 'd') overSel = nav(1 - overSel);
      if (ap) { if (overSel === 0) startGame(game, st.mode); else { screen = 'menu'; sfx('menu'); } }
      if (p.bp || p2.bp) screen = 'menu';
    }
  }
  function medalIcon(c, x, y, m, s = 1) { if (!m) return; R(c, x - 6 * s, y - 14 * s, 4 * s, 8 * s, '#3a6ad0'); R(c, x + 2 * s, y - 14 * s, 4 * s, 8 * s, '#d03a3a'); R(c, x - 7 * s, y - 7 * s, 14 * s, 14 * s, '#2a1a10'); R(c, x - 6 * s, y - 6 * s, 12 * s, 12 * s, MEDAL_COL[m]); R(c, x - 3 * s, y - 4 * s, 3 * s, 3 * s, 'rgba(255,255,255,.6)'); }
  function gameIcon(c, gm, x, y) {
    const s = 4; const px = (a, b, w, h, col) => R(c, x + a * s, y + b * s, w * s, h * s, col);
    if (gm.id === 'minhoca') { px(0, 6, 3, 3, '#ff8fb0'); px(3, 6, 3, 3, '#ff8fb0'); px(6, 3, 3, 3, '#ff8fb0'); px(6, 6, 3, 3, '#ff8fb0'); px(9, 3, 3, 3, '#e8507a'); px(10, 4, 1, 1, '#fff'); px(13, 4, 2, 3, '#b8242c'); }
    if (gm.id === 'pong') { px(0, 1, 2, 8, '#ffb347'); px(13, 2, 2, 8, '#7ad1ff'); px(7, 4, 2, 2, '#fff'); px(5, 6, 1, 1, 'rgba(255,255,255,.4)'); }
    if (gm.id === 'quebra') { for (let i = 0; i < 4; i++) px(i * 4, 0, 3, 2, ['#d06a5a', '#e8a04a', '#7ab86a', '#5a9ad0'][i]); for (let i = 0; i < 3; i++) px(2 + i * 4, 3, 3, 2, ['#e8d04a', '#9a7ad0', '#d06a5a'][i]); px(7, 6, 1, 1, '#fff'); px(4, 9, 8, 1, '#e8c070'); }
    if (gm.id === 'cabo') { px(0, 5, 15, 1, '#c8a060'); px(7, 3, 1, 5, '#e84a3a'); px(0, 3, 2, 5, '#ffb347'); px(13, 3, 2, 5, '#c9a8ff'); px(6, 8, 3, 1, '#5a3a22'); }
    if (gm.id === 'chinelo') { px(2, 0, 2, 4, '#4a8af0'); px(9, 2, 4, 2, '#4a8af0'); px(6, 6, 2, 4, '#4a8af0'); px(12, 7, 2, 2, '#9a3a8a'); px(0, 9, 15, 1, '#9a8a6a'); }
    if (gm.id === 'galo') { px(4, 3, 5, 4, '#f4f0e0'); px(8, 1, 3, 3, '#f4f0e0'); px(9, 0, 2, 1, '#e83a3a'); px(11, 2, 2, 1, '#e8a83a'); px(2, 2, 2, 3, '#2a5a3a'); px(5, 7, 1, 2, '#e8a83a'); px(7, 7, 1, 2, '#e8a83a'); }
  }
  function button(c, label, x, y, w, h, on, act) { frame(c, x, y, w, h, on ? '#4a7a3a' : '#2a2018', on ? '#fff3a0' : '#e8c27a'); txt(c, label, x + w / 2, y + h / 2 + 1, 14, on ? '#fff' : '#e8d8b0'); clicks.push({ x, y, w, h, act }); }
  function drawScreens(c) {
    clicks = [];
    if (screen === 'menu') {
      R(c, 0, 0, W, H, '#1a1420'); for (let i = 0; i < 40; i++) R(c, (hash(i) * W) | 0, (hash(i + 9) * H) | 0, 2, 2, `rgba(255,220,160,${.2 + .3 * Math.sin(t * 2 + i)})`);
      // letreiro neon
      frame(c, 250, 18, 460, 70, '#2a1030', '#ff6ab0', '#6a2a5a'); txt(c, 'FLIPERAMA DA ROÇA', W / 2, 46, 26, Math.sin(t * 6) > -.8 ? '#ffd0f0' : '#a06a90', 'center', '#a02a6a'); txt(c, 'SOZINHO OU EM DUPLA', W / 2, 72, 10, '#ffb0d8', 'center', null);
      txt(c, '◎ ' + data.fichas + ' FICHAS', W - 70, 30, 12, '#ffd75a', 'right');
      GAMES.forEach((gm, i) => { const col = i % 3, row = Math.floor(i / 3), x = 60 + col * 290, y = 112 + row * 186, on = i === sel, r = rec(gm.id), best = r.solo[0]?.s;
        frame(c, x, y + (on ? -4 : 0), 260, 170, on ? '#3a2a40' : '#241a20', on ? '#fff3a0' : gm.color, '#3a2a2a');
        R(c, x + 16, y + 18 + (on ? -4 : 0), 76, 52, '#120c10'); gameIcon(c, gm, x + 24, y + 24 + (on ? -4 : 0));
        txt(c, gm.name, x + 130, y + 92 + (on ? -4 : 0), 11, on ? '#fff' : '#f0e0c0'); txt(c, gm.duo === 'coop' ? 'DUPLA JUNTOS' : 'DUPLA CONTRA', x + 130, y + 112 + (on ? -4 : 0), 9, gm.color, 'center', null);
        txt(c, best ? 'RECORDE ' + best : 'SEM RECORDE', x + 130, y + 136 + (on ? -4 : 0), 10, '#c8b890', 'center', null);
        medalIcon(c, x + 230, y + 40 + (on ? -4 : 0), r.medal, 2);
        clicks.push({ x, y, w: 260, h: 170, act: () => { if (sel === i) { screen = 'mode'; modeSel = 0; } else sel = i; sfx('menu'); } }); });
      txt(c, GAMES[sel].sub, W / 2, 498, 12, '#e8d8b0', 'center', null);
      button(c, 'SAIR', 24, 470, 120, 50, false, close);
      txt(c, 'Setas/WASD escolhem · A, J ou Enter abre · Esc sai', W / 2, 524, 9, '#8a7a6a', 'center', null);
    } else if (screen === 'mode') {
      const gm = GAMES[sel], r = rec(gm.id);
      R(c, 0, 0, W, H, '#1a1420'); frame(c, 30, 20, 900, 500, '#2a2018', gm.color, '#3a2a2a');
      R(c, 60, 50, 92, 68, '#120c10'); gameIcon(c, gm, 70, 58);
      txt(c, gm.name, 172, 70, 22, '#fff', 'left'); txt(c, gm.sub, 172, 100, 11, gm.color, 'left', null);
      txt(c, 'COMO JOGAR', 60, 150, 13, '#ffd75a', 'left'); (modeSel ? gm.rulesDuo : gm.rules).forEach((l, i) => txt(c, '• ' + l, 60, 180 + i * 26, 10, '#f0e0c0', 'left', null));
      txt(c, 'CONTROLES', 60, 270, 13, '#ffd75a', 'left');
      const ctrl = modeSel ? ['P1: WASD + J (A) / K (B)', 'P2: setas + Enter (A) / Shift direito (B)', 'Controles e toque também funcionam'] : ['Setas ou WASD · A: J, Espaço ou Enter · B: K', 'Controle (gamepad) e toque também funcionam'];
      gm.controls.concat(ctrl).forEach((l, i) => txt(c, l, 60, 298 + i * 22, 10, '#d8c8a8', 'left', null));
      // ranking
      frame(c, 600, 140, 300, 230, '#1e1612', '#a08060', '#3a2a2a'); txt(c, 'RANKING ' + (modeSel ? (gm.duo === 'coop' ? 'DUPLA' : 'VITÓRIAS') : 'SOZINHO'), 750, 166, 11, '#ffd75a');
      if (modeSel && gm.duo === 'versus') { txt(c, PLAYER_NAME[0] + '  ' + r.wins[0], 750, 220, 14, PLAYER_COL[0]); txt(c, PLAYER_NAME[1] + '  ' + r.wins[1], 750, 256, 14, PLAYER_COL[1]); }
      else { const list = r[modeSel ? 'duo' : 'solo']; if (!list.length) txt(c, 'Ninguém ainda. Seja o primeiro!', 750, 250, 9, '#a89878', 'center', null); list.forEach((e, i) => { txt(c, (i + 1) + '. ' + e.n, 640, 200 + i * 30, 13, i ? '#e8d8b0' : '#ffd75a', 'left'); txt(c, String(e.s), 870, 200 + i * 30, 13, i ? '#e8d8b0' : '#ffd75a', 'right'); }); }
      if (!modeSel) { txt(c, 'MEDALHAS: ' + gm.medals.join(' / '), 750, 352, 9, '#c8b890', 'center', null); }
      button(c, 'SOZINHO', 300, 410, 170, 56, modeSel === 0, () => { if (modeSel === 0) startGame(gm, 'solo'); else { modeSel = 0; sfx('move'); } });
      button(c, gm.duo === 'coop' ? 'DUPLA JUNTOS' : 'DUPLA CONTRA', 490, 410, 200, 56, modeSel === 1, () => { if (modeSel === 1) startGame(gm, 'duo'); else { modeSel = 1; sfx('move'); } });
      button(c, 'VOLTAR', 60, 410, 140, 56, false, () => { screen = 'menu'; sfx('menu'); });
      txt(c, 'Escolha com as setas e aperte A para começar', W / 2, 490, 9, '#8a7a6a', 'center', null);
    } else if (screen === 'over') {
      const res = st.ended, sm = st.summary;
      c.fillStyle = 'rgba(10,8,12,.78)'; c.fillRect(0, 0, W, H); frame(c, 180, 40, 600, 460, '#2a2018', game.color, '#3a2a2a');
      const versus = st.mode === 'duo' && game.duo === 'versus';
      txt(c, versus ? 'FIM DE JOGO' : res.win === false ? 'NÃO FOI DESSA VEZ' : 'FIM DE JOGO', W / 2, 84, 24, '#fff');
      txt(c, res.text || '', W / 2, 120, 11, '#e8d8b0', 'center', null);
      if (versus) { if (res.winner !== null && res.winner !== undefined) hero(c, PLAYER_TYPES[res.winner], W / 2, 260, { scale: 1.6, emotion: 'friend', frame: t }); txt(c, res.winner === null || res.winner === undefined ? 'EMPATE' : PLAYER_NAME[res.winner] + ' VENCEU!', W / 2, 296, 20, res.winner === null || res.winner === undefined ? '#fff' : PLAYER_COL[res.winner]); }
      else { txt(c, String(res.score), W / 2, 180, 40, '#ffd75a'); txt(c, 'PONTOS', W / 2, 214, 11, '#c8b890', 'center', null); if (sm.medal) { medalIcon(c, W / 2, 262, sm.medal, 3); txt(c, 'MEDALHA DE ' + MEDALS[sm.medal] + (sm.newMedal ? ' · NOVA!' : ''), W / 2, 306, 12, MEDAL_COL[sm.medal]); } }
      txt(c, '+' + sm.fichas + ' FICHAS  (TOTAL ' + data.fichas + ')', W / 2, 336, 12, '#ffd75a');
      if (initials) { txt(c, 'NOVO RECORDE! SUAS INICIAIS:', W / 2, 372, 11, '#fff'); initials.s.forEach((ch, i) => { const x = W / 2 - 60 + i * 60; frame(c, x - 22, 388, 44, 54, i === initials.i ? '#4a3a20' : '#1e1612', i === initials.i ? '#fff3a0' : '#a08060', '#3a2a2a'); txt(c, ch, x, 416, 22, '#fff'); clicks.push({ x: x - 22, y: 388, w: 44, h: 54, act: () => { if (initials.i === i) { initials.s[i] = LETTERS[(LETTERS.indexOf(ch) + 1) % LETTERS.length]; } else initials.i = i; sfx('move'); } }); });
        button(c, 'OK', W / 2 + 120, 392, 80, 46, false, saveInitials); txt(c, 'Cima/baixo troca a letra · A confirma', W / 2, 466, 9, '#8a7a6a', 'center', null); }
      else { button(c, 'DE NOVO', 300, 400, 170, 56, overSel === 0, () => startGame(game, st.mode)); button(c, 'MENU', 490, 400, 170, 56, overSel === 1, () => { screen = 'menu'; sfx('menu'); }); }
    }
  }
  function drawPlay(c) {
    const sh = st.shake > 0 ? Math.round((Math.random() - .5) * 8 / 2) * 2 : 0;
    g.save(); g.imageSmoothingEnabled = false; g.clearRect(0, 0, LW, LH); game.drawLow(g, st); g.restore();
    c.save(); c.imageSmoothingEnabled = false; c.fillStyle = '#000'; c.fillRect(0, 0, W, H); c.drawImage(low, sh, sh, W, H);
    game.drawMain(c, st);
    for (const q of st.pop) txt(c, q.s, q.x * 2, q.y * 2 - q.t * 40, 14, '#fff3a0');
    if (st.banner) txt(c, st.banner.s, W / 2, 200, 30, '#fff3a0');
    if (screen === 'count') { c.fillStyle = 'rgba(10,8,12,.55)'; c.fillRect(0, 0, W, H); const n = Math.ceil(cd); txt(c, n > 0 ? String(n) : 'VAI!', W / 2, 220, 64, '#ffd75a');
      frame(c, 250, 300, 460, 120, '#2a2018', game.color, '#3a2a2a'); txt(c, game.name, W / 2, 326, 13, '#fff'); game.controls.forEach((l, i) => txt(c, l, W / 2, 354 + i * 22, 11, '#e8d8b0', 'center', null)); if (st.mode === 'duo') txt(c, 'P1: WASD + J/K   ·   P2: setas + Enter/Shift', W / 2, 400, 9, '#c8b890', 'center', null); }
    if (st.ended && screen === 'play') { txt(c, st.mode === 'duo' && game.duo === 'versus' ? 'FIM!' : 'FIM DE JOGO', W / 2, 250, 40, '#fff3a0'); }
    c.restore();
    clicks = [];
    if (paused) { c.fillStyle = 'rgba(10,8,12,.7)'; c.fillRect(0, 0, W, H); frame(c, 330, 160, 300, 220, '#2a2018', '#e8c27a'); txt(c, 'PAUSA', W / 2, 200, 22, '#fff'); button(c, 'CONTINUAR', 380, 230, 200, 50, pauseSel === 0, () => { paused = false; }); button(c, 'SAIR DO JOGO', 380, 296, 200, 50, pauseSel === 1, () => { paused = false; screen = 'menu'; }); }
  }
  function loop(now) {
    if (!open) return;
    const dt = Math.min(.05, (now - last) / 1000 || 0); last = now; t += dt;
    pollInput();
    updateScreens(paused ? 0 : dt);
    ctx.save(); ctx.imageSmoothingEnabled = false;
    if (screen === 'play' || screen === 'count') drawPlay(ctx); else { if (st && screen === 'over') drawPlay(ctx); drawScreens(ctx); }
    ctx.restore();
    if (touchUI) touchUI.dataset.mode = (screen === 'play' || screen === 'count') && !paused ? (solo ? 'solo' : 'duo') : 'menu';
    raf = requestAnimationFrame(loop);
  }

  /* ---------------- janela, teclado e toque ---------------- */
  function build() {
    if (root) return;
    root = document.createElement('div'); root.id = 'fliperama'; root.className = 'fliperama'; root.hidden = true; root.setAttribute('role', 'dialog'); root.setAttribute('aria-label', 'Fliperama da Roça');
    cv = document.createElement('canvas'); cv.width = W; cv.height = H; cv.className = 'fliperama-canvas'; cv.tabIndex = 0; cv.setAttribute('aria-label', 'Fliperama da Roça: use as setas e A para escolher');
    low = document.createElement('canvas'); low.width = LW; low.height = LH; g = low.getContext('2d'); ctx = cv.getContext('2d');
    const close = document.createElement('button'); close.className = 'fliperama-close'; close.type = 'button'; close.textContent = '✕'; close.setAttribute('aria-label', 'Voltar'); close.addEventListener('click', back);
    touchUI = document.createElement('div'); touchUI.className = 'fliperama-touch'; touchUI.dataset.mode = 'menu';
    const pad = (i, side) => { const box = document.createElement('div'); box.className = 'fp-pad fp-' + side + ' fp-p' + (i + 1);
      const dirs = [['u', 0, -1, '▲'], ['l', -1, 0, '◀'], ['r', 1, 0, '▶'], ['d', 0, 1, '▼']], dp = document.createElement('div'); dp.className = 'fp-dpad';
      for (const [n, x, y, s] of dirs) { const b = document.createElement('button'); b.type = 'button'; b.className = 'fp-dir fp-' + n; b.textContent = s; bindHold(b, (on) => { if (x) touch[i].x = on ? x : (touch[i].x === x ? 0 : touch[i].x); if (y) touch[i].y = on ? y : (touch[i].y === y ? 0 : touch[i].y); }); dp.append(b); }
      const ab = document.createElement('div'); ab.className = 'fp-ab'; for (const n of ['a', 'b']) { const b = document.createElement('button'); b.type = 'button'; b.className = 'fp-btn fp-' + n; b.textContent = n.toUpperCase(); bindHold(b, (on) => { touch[i][n] = on; }); ab.append(b); }
      if (side === 'left') box.append(dp, ab); else box.append(ab, dp); return box; };
    touchUI.append(pad(0, 'left'), pad(1, 'right'));
    root.append(cv, touchUI, close);
    (document.getElementById('gameShell') || document.body).append(root);
    cv.addEventListener('pointerdown', (e) => { const r = cv.getBoundingClientRect(), x = (e.clientX - r.left) / r.width * W, y = (e.clientY - r.top) / r.height * H; for (const k of clicks.slice().reverse()) if (x >= k.x && x <= k.x + k.w && y >= k.y && y <= k.y + k.h) { e.preventDefault(); k.act(); return; } });
    window.addEventListener('keydown', (e) => { if (!open) return; if (e.code === 'Escape' || e.code === 'Backspace') { e.preventDefault(); back(); } else if (e.code === 'KeyP' && (screen === 'play' || screen === 'count')) back(); keys[e.code] = true; if (e.code.startsWith('Arrow') || e.code === 'Space' || e.code === 'Enter') e.preventDefault(); e.stopImmediatePropagation(); }, true);
    window.addEventListener('keyup', (e) => { keys[e.code] = false; if (open) e.stopImmediatePropagation(); }, true);
    window.addEventListener('blur', () => { for (const k in keys) keys[k] = false; });
  }
  function bindHold(b, fn) {
    const on = (e) => { e.preventDefault(); b.classList.add('on'); fn(true); try { b.setPointerCapture(e.pointerId); } catch (x) {} };
    const off = (e) => { b.classList.remove('on'); fn(false); };
    b.addEventListener('pointerdown', on); b.addEventListener('pointerup', off); b.addEventListener('pointercancel', off); b.addEventListener('lostpointercapture', off);
  }
  function openUp(id, opts = {}) {
    build(); if (open) return;
    from = opts.from || null; muted = window.Game?.soundOn ? !window.Game.soundOn() && from !== 'title' : false;
    open = true; root.hidden = false; screen = 'menu'; paused = false; modeSel = 0; const i = GAMES.findIndex((x) => x.id === id); if (i >= 0) { sel = i; screen = 'mode'; }
    for (const k in keys) keys[k] = false; touch.forEach((x) => Object.assign(x, { x: 0, y: 0, a: false, b: false }));
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
    document.getElementById('gameShell')?.classList.add('is-fliperama');
    last = performance.now(); raf = requestAnimationFrame(loop); setTimeout(() => cv.focus(), 30);
  }
  function close() {
    if (!open) return; open = false; root.hidden = true; cancelAnimationFrame(raf);
    for (const k in keys) keys[k] = false;
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } }));
    document.getElementById('gameShell')?.classList.remove('is-fliperama');
    updateInventory();
    document.getElementById('gameCanvas')?.focus?.();
  }

  /* ---------------- máquinas de fliperama nos mapas ---------------- */
  // posições em pixels do mundo (perto de lugares de lazer de cada fase)
  const CABINETS = { 0: [2290], 1: [3020], 4: [2230], 5: [1180], 9: [1390], 3: [760], 7: [1060] };
  function near(scene, x) { return (CABINETS[scene] || []).some((cx) => Math.abs(cx - x) < 46); }
  function drawCabinet(c, x, y, tm) {
    const P2 = (a, b, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x + a), Math.round(y + b), w, h); };
    P2(-22, -2, 44, 4, 'rgba(18,30,52,.35)');
    P2(-18, -92, 36, 92, '#2a1a3a'); P2(-16, -90, 32, 88, '#5a2a6a'); P2(-18, -100, 36, 12, '#1a1020'); P2(-16, -98, 32, 8, Math.sin(tm * 5) > -.6 ? '#ff6ab0' : '#a03a70');
    c.fillStyle = '#fff'; c.font = '6px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillText('FLIPER', x, y - 94);
    P2(-14, -84, 28, 24, '#0a0a14'); P2(-12, -82, 24, 20, ['#1a3a5a', '#3a1a5a', '#1a5a3a'][Math.floor(tm * 1.5) % 3]);
    for (let i = 0; i < 4; i++) P2(-10 + ((tm * 18 + i * 7) % 20), -78 + (i * 5) % 14, 2, 2, ['#ffd75a', '#7ad1ff', '#ff8fb0', '#7af07a'][i]);
    P2(-18, -58, 36, 10, '#3a1a4a'); P2(-10, -56, 4, 4, '#e84a3a'); P2(4, -56, 4, 4, '#4ae84a'); P2(10, -55, 3, 3, '#e8e84a'); P2(-8, -60, 2, 4, '#c8c8c8');
    P2(-12, -44, 24, 30, '#4a2058'); P2(-6, -36, 12, 4, '#ffd75a'); P2(-4, -30, 8, 2, '#1a1020');
  }
  function drawWorld(c, o) {
    if (o.arena || o.room) return; const list = CABINETS[o.scene]; if (!list) return;
    for (const x of list) { if (x - o.camera < -60 || x - o.camera > 1020) continue; drawCabinet(c, x, 440, o.time || 0); }
  }

  /* ---------------- entradas: menu inicial, pausa e inventário ---------------- */
  function addEntries() {
    const entries = document.querySelector('#startScreen .ranch-mode-entries');
    if (entries && !entries.querySelector('[data-open-fliperama]')) { const b = document.createElement('button'); b.type = 'button'; b.dataset.openFliperama = '1'; b.innerHTML = '<b>🕹 FLIPERAMA</b><small>6 minigames · sozinho ou em dupla</small>'; b.addEventListener('click', () => openUp(null, { from: 'title' })); entries.append(b); }
    const modal = document.querySelector('#pauseScreen .game-modal');
    if (modal && !modal.querySelector('[data-open-fliperama]')) { const b = document.createElement('button'); b.type = 'button'; b.className = 'text-button'; b.dataset.openFliperama = '1'; b.textContent = 'Fliperama da Roça'; b.addEventListener('click', () => openUp(null, { from: 'pause' })); modal.append(b); }
    updateInventory();
  }
  function updateInventory() {
    const panel = document.getElementById('hudInvPanel'); if (!panel) return;
    let row = panel.querySelector('.hud-fliperama');
    if (!row) { row = document.createElement('div'); row.className = 'hud-row hud-fliperama'; const btn = document.createElement('button'); btn.type = 'button'; btn.className = 'hud-fliperama-btn'; btn.textContent = 'JOGAR'; btn.addEventListener('click', () => openUp(null, { from: 'inventory' })); row.innerHTML = '<span>🕹 FLIPERAMA</span><b class="hud-fp-count"></b>'; row.append(btn); panel.append(row); }
    const medals = GAMES.map((gm) => rec(gm.id).medal).filter(Boolean), gold = medals.filter((m) => m === 3).length;
    row.querySelector('.hud-fp-count').textContent = data.fichas + ' fichas · ' + medals.length + '/' + GAMES.length + ' medalhas' + (gold ? ' (' + gold + ' ouro)' : '');
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', addEntries); else addEntries();
  setTimeout(addEntries, 1500);

  window.Fliperama = Object.freeze({
    open: openUp, close, isOpen: () => open, near, drawWorld, games: () => GAMES.map((gm) => ({ id: gm.id, name: gm.name, duo: gm.duo })),
    stats: () => JSON.parse(JSON.stringify(data)), register: (gm) => { if (gm && gm.id && !GAMES.some((x) => x.id === gm.id)) GAMES.push(gm); },
    debug: () => ({ screen, sel, st, P })
  });
})();
