/* Cenário interativo (fase 4).
   Objetos espalhados pelos mapas e arenas que reagem ao jogador, aos inimigos e aos golpes:
   - quebráveis: caixotes, vasos, fardos de feno, melancias, barris e cercas (voltam depois);
   - empurráveis: pneus, baldes, lixeiras e bolas (rolam e quicam);
   - portas que abrem quando você chega perto; alavancas que ligam coisas (irrigador,
     chafariz, luzes de festa, sirene da escola, refletores);
   - poças que ondulam e espirram; ratoeiras que estalam; churrasqueiras com brasa;
   - capim seco que pega fogo e espalha (chuva apaga; nada causa dano);
   - plataformas móveis (elevador e balsa) em cada fase ao ar livre — rotas opcionais;
   - pousos e golpes fortes de chefe fazem tudo pular, balançar e cair folhas.
   Nada disso causa dano nem muda a dificuldade. Na qualidade BAIXA fica tudo desligado,
   exceto as plataformas móveis (que fazem parte do caminho). */
(() => {
  'use strict';
  if (window.Interact) return;
  const FLOOR = 440, OUT = [0, 1, 3, 4, 5, 7, 9];
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, Math.max(2, Math.round(w / 2) * 2), Math.max(2, Math.round(h / 2) * 2)); };
  const lite = () => !!window.Graphics?.isLite?.();
  const worldW = (scene) => Number(window.WorldData?.widths?.[scene]) || Number(window.CampanhaCenarios?.largura?.(scene)) || 4800;

  // ------------------------------------------------------------------ lista de objetos por fase
  const SPEC = {
    0: [['crate', 1000], ['crate', 1030, 1], ['crate', 2300], ['hay', 1500], ['hay', 2650], ['melon', 900], ['melon', 1950], ['melon', 1975], ['pot', 120], ['pot', 3480], ['bucket', 620], ['tire', 2100], ['door', 204, 42, 74], ['door', 3576, 42, 74], ['lever', 880, 'sprinkler'], ['puddle', 1400, 70], ['puddle', 2500, 90], ['grass', 1600, 300], ['grass', 2720, 260], ['fence', 2200, 90], ['grill', 3300]],
    1: [['crate', 1440], ['crate', 2640], ['pot', 700], ['pot', 3200], ['trash', 2100], ['lever', 1700, 'bell'], ['puddle', 2800, 80], ['door', 1324, 52, 150, 'class'], ['door', 2324, 52, 150, 'class'], ['door', 342, 76, 130, 'main']],
    3: [['ball', 900], ['ball', 2000], ['crate', 1300], ['crate', 1328, 1], ['cone', 1700], ['cone', 1760], ['lever', 2200, 'flood'], ['puddle', 1550, 80], ['grill', 2440], ['grass', 2800, 300], ['trash', 3100]],
    4: [['lever', 1180, 'fountain'], ['pot', 800], ['pot', 2600], ['trash', 1600], ['puddle', 1400, 90], ['puddle', 3000, 70], ['crate', 2000], ['bucket', 2240]],
    5: [['barrel', 900], ['barrel', 2600], ['crate', 1500], ['crate', 1528, 1], ['trap', 1200], ['trap', 3000], ['lever', 2000, 'party'], ['grill', 1800], ['puddle', 2300, 80], ['puddle', 3400, 70], ['tire', 2900], ['grass', 3700, 260], ['favdoors']],
    7: [['ball', 1300], ['ball', 2600], ['crate', 900], ['cone', 1100], ['cone', 1160], ['cone', 1220], ['lever', 1600, 'flood'], ['puddle', 2100, 90], ['bucket', 3000]],
    9: [['pot', 400], ['pot', 1500], ['trash', 2300], ['lever', 1960, 'party'], ['puddle', 2600, 80], ['crate', 3000], ['ball', 1100]]
  };
  const ARENA_SPEC = [['crate', -340], ['crate', -312, 1], ['pot', -390], ['crate', 340], ['pot', 390], ['barrel', 300]];
  const BREAK = { crate: [30, 28], pot: [18, 24], hay: [40, 26], melon: [22, 16], barrel: [26, 34], fence: [0, 34] };
  const PUSH = { tire: [26, 26], bucket: [18, 20], trash: [22, 30], ball: [16, 16], cone: [14, 18] };

  const sets = {};
  function build(key, spec, off = 0) {
    const out = { props: [], fx: [], texts: [], plat: [], key };
    for (const s of spec) {
      const [type, x0] = s, x = (x0 || 0) + off;
      if (BREAK[type]) out.props.push({ type, x: x + (type === 'fence' ? 0 : 0), w: type === 'fence' ? s[2] : BREAK[type][0], h: BREAK[type][1], y: 0, vy: 0, hp: type === 'barrel' ? 2 : 1, broken: 0, wob: 0, stack: s[2] === 1 && type !== 'fence' ? 1 : 0, alpha: 1, segs: type === 'fence' ? Array.from({ length: Math.round(s[2] / 18) }, () => 0) : null });
      else if (PUSH[type]) out.props.push({ type, x, home: x, w: PUSH[type][0], h: PUSH[type][1], y: 0, vx: 0, vy: 0, rot: 0 });
      else if (type === 'door') out.props.push({ type, x, w: s[2], h: s[3], kind: s[4] || 'house', open: 0 });
      else if (type === 'lever') out.props.push({ type, x, effect: s[2], on: false, flip: 0, w: 14, h: 24 });
      else if (type === 'puddle') out.props.push({ type, x, w: s[2], ripples: [] });
      else if (type === 'trap') out.props.push({ type, x, w: 18, armed: true, t: 0 });
      else if (type === 'grill') out.props.push({ type, x, w: 30, burst: 0 });
      else if (type === 'grass') out.props.push({ type, x, w: s[2], cells: Array.from({ length: Math.round(s[2] / 8) }, () => ({ s: 0, t: 0 })) });
      else if (type === 'favdoors') { for (let i = 1; i * 210 < 7000; i += 3) out.props.push({ type: 'door', x: i * 210 + 74, w: 28, h: 62, kind: 'fav', open: 0 }); }
    }
    return out;
  }
  // plataformas móveis: elevador até a plataforma mais alta e balsa sobre o maior vão
  function buildPlatforms(scene) {
    const ps = (window.WorldData?.platforms?.[scene] || []).slice().sort((a, b) => a[0] - b[0]), out = [];
    if (!ps.length) return out;
    const free = (x, w, y0, y1) => !ps.some((p) => x < p[0] + p[2] + 30 && x + w > p[0] - 30 && p[1] > y0 - 20 && p[1] < y1 + 20);
    const tops = ps.filter((p) => p[1] <= 330).sort((a, b) => a[1] - b[1]);
    search: for (const top of tops) for (const x of [top[0] - 90, top[0] + top[2] + 20, top[0] - 170, top[0] + top[2] + 100]) if (x > 200 && free(x, 70, top[1] + 30, FLOOR - 30)) { out.push({ kind: 'lift', x, w: 70, y0: FLOOR - 34, y1: top[1], period: 7.5, cx: x, cy: FLOOR - 34, dx: 0 }); break search; }
    let best = null; for (let i = 0; i < ps.length - 1; i++) { const a = ps[i], b = ps[i + 1], gap = b[0] - (a[0] + a[2]); if (gap > 180 && gap < 1200 && (!best || gap > best.gap)) best = { a, b, gap }; }
    if (best) { const y = Math.min(best.a[1], best.b[1]) - 10; out.push({ kind: 'ferry', x0: best.a[0] + best.a[2] + 14, x1: best.b[0] - 84, y, w: 70, period: 6 + best.gap / 160, cx: best.a[0] + best.a[2] + 14, cy: y, dx: 0 }); }
    return out;
  }
  function getSet(o) {
    if (o.room) return null;
    if (o.arena) { const key = 'arena:' + o.arenaType + ':' + o.homeX; if (!sets[key]) sets[key] = build(key, ARENA_SPEC, o.homeX); return sets[key]; }
    if (!OUT.includes(o.scene)) return null;
    const key = 'scene:' + o.scene; if (!sets[key]) { sets[key] = build(key, SPEC[o.scene] || []); sets[key].plat = buildPlatforms(o.scene); } return sets[key];
  }

  // ------------------------------------------------------------------ efeitos (partículas, textos)
  function debris(S, x, y, cols, n, spread = 1, up = 1) { for (let i = 0; i < n; i++) S.fx.push({ k: 'chunk', x: x + (Math.random() - .5) * 20, y: y - Math.random() * 16, vx: (Math.random() - .5) * 360 * spread, vy: -(160 + Math.random() * 260) * up, s: 2 + (Math.random() * 3 | 0) * 2, col: cols[i % cols.length], life: 1.2 + Math.random() * .6, rot: 0 }); }
  function dust(S, x, y, n, col = 'rgba(214,196,160,.8)') { for (let i = 0; i < n; i++) S.fx.push({ k: 'puff', x: x + (Math.random() - .5) * 26, y: y - Math.random() * 8, vx: (Math.random() - .5) * 90, vy: -20 - Math.random() * 40, s: 4 + Math.random() * 6, col, life: .7 + Math.random() * .4, max: 1.1 }); }
  function drops(S, x, y, n, power = 1) { for (let i = 0; i < n; i++) S.fx.push({ k: 'drop', x: x + (Math.random() - .5) * 16, y, vx: (Math.random() - .5) * 220 * power, vy: -(120 + Math.random() * 200) * power, s: 2, col: Math.random() > .5 ? '#bfe6f6' : '#e8f8ff', life: .9 }); }
  function sparks(S, x, y, n, col = '#ffd27a') { for (let i = 0; i < n; i++) S.fx.push({ k: 'spark', x, y, vx: (Math.random() - .5) * 300, vy: -60 - Math.random() * 260, s: 2, col: i % 3 ? col : '#fff6d0', life: .5 + Math.random() * .5 }); }
  // cada onomatopeia tem seu som (audio.js); um som por vez a cada 60 ms para não embolar
  const SOUND = { 'CRAC!': 'quebra', 'CRÁS!': 'quebra', 'BLAM!': 'quebra', 'PLAFT!': 'quebra', 'SPLOC!': 'agua', 'TÁC!': 'tac', 'FUFF!': 'fogo', 'LIGOU!': 'alavanca', 'DESLIGOU': 'alavanca' }; let lastSound = 0;
  function sound(name) { const t = performance.now(); if (t - lastSound < 60) return; lastSound = t; try { window.DarocaAudio?.play?.(name); } catch (e) {} }
  function say(S, x, y, txt, col = '#fff0c4') { S.texts.push({ x, y, txt, col, life: 1.1 }); const snd = SOUND[txt] || (String(txt).startsWith('LIGOU') ? 'alavanca' : null); if (snd) sound(snd); }
  function leaves(S, x, n) { for (let i = 0; i < n; i++) S.fx.push({ k: 'leaf', x: x + (Math.random() - .5) * 260, y: 120 + Math.random() * 140, vx: (Math.random() - .5) * 60, vy: 30 + Math.random() * 40, s: 4, col: ['#6aa850', '#c9a24a', '#a8c060', '#d8783a'][i % 4], life: 2.6 + Math.random(), ph: Math.random() * 6 }); }

  // ------------------------------------------------------------------ reações
  function hitProp(S, p, dir, power, t) {
    if (BREAK[p.type]) {
      if (p.broken) return; p.wob = 1; p.vy = -120 * power;
      if (--p.hp > 0) { debris(S, p.x + p.w / 2, FLOOR - p.h / 2, ['#8a6238', '#5a4028'], 4); return; }
      p.broken = t;
      const cx = p.x + p.w / 2, cy = FLOOR - p.h / 2 - (p.stack ? 28 : 0);
      if (p.type === 'crate') { debris(S, cx, cy, ['#a87a48', '#8a6238', '#c49a5c', '#5a4028'], 14); dust(S, cx, FLOOR, 6); say(S, cx, cy - 20, 'CRAC!'); }
      if (p.type === 'pot') { debris(S, cx, cy, ['#bf755a', '#a85a40', '#d99572'], 9); debris(S, cx, cy, ['#5a3a20', '#4a2e1a'], 6, .6); debris(S, cx, cy - 10, ['#4f9a3f', '#6fb24a'], 4, .8, 1.3); say(S, cx, cy - 20, 'PLAFT!'); }
      if (p.type === 'hay') { debris(S, cx, cy, ['#dfbd6c', '#f4dc92', '#c79a56'], 22, 1.3); dust(S, cx, FLOOR, 8, 'rgba(240,220,150,.8)'); say(S, cx, cy - 20, 'FUFF!'); }
      if (p.type === 'melon') { debris(S, cx, cy, ['#e04a4a', '#ff7a6a', '#3a7a3a', '#1a1a1a'], 14, 1.1); say(S, cx, cy - 16, 'SPLOC!', '#ffb0a0'); }
      if (p.type === 'barrel') { debris(S, cx, cy, ['#8a6238', '#a87a48', '#4a4a4a'], 14); drops(S, cx, cy, 16, 1.1); say(S, cx, cy - 24, 'BLAM!'); }
      if (p.type === 'fence') { for (let k = 0; k < p.segs.length; k++) p.segs[k] = t; debris(S, cx, FLOOR - 18, ['#756c48', '#a38e5e', '#c1ae76'], 12); say(S, cx, FLOOR - 50, 'CRÁS!'); }
      return;
    }
    if (PUSH[p.type]) { p.vx = dir * 380 * power; p.vy = -200 * power; return; }
    if (p.type === 'lever') { p.on = !p.on; p.flip = 1; sparks(S, p.x + 7, FLOOR - 40, 6, '#ffe9a0'); say(S, p.x + 7, FLOOR - 60, p.on ? 'LIGOU!' : 'DESLIGOU', p.on ? '#b8ff9a' : '#ffd0a0'); return; }
    if (p.type === 'grill') { p.burst = 1; sparks(S, p.x + 15, FLOOR - 40, 18, '#ffb030'); igniteNear(S, p.x + 15, 140, t); return; }
    if (p.type === 'trap' && p.armed) { snap(S, p, t); }
  }
  function snap(S, p, t) { p.armed = false; p.t = t; S.fx.push({ k: 'chunk', x: p.x + 9, y: FLOOR - 6, vx: (Math.random() - .5) * 120, vy: -320, s: 6, col: '#f2d24a', life: 1.4 }); say(S, p.x + 9, FLOOR - 30, 'TÁC!'); }
  function igniteNear(S, x, r, t) { for (const p of S.props) if (p.type === 'grass' && x > p.x - r && x < p.x + p.w + r) { const wet = (window.Weather?.state?.().rain || 0) > .35 || S.wet > 0; if (wet) continue; const i = Math.max(0, Math.min(p.cells.length - 1, Math.round((x - p.x) / 8))); if (p.cells[i].s === 0) { p.cells[i].s = 1; p.cells[i].t = t; } } }
  function shock(S, x, power, t) {
    for (const p of S.props) { const cx = p.x + (p.w || 0) / 2, d = Math.abs(cx - x); if (d > 300) continue; const k = 1 - d / 300;
      if (BREAK[p.type] && !p.broken) { p.vy = -260 * k * power; p.wob = 1; if (k > .75 && power > .8) hitProp(S, p, Math.sign(cx - x) || 1, 1, t); }
      if (PUSH[p.type]) { p.vy = -300 * k * power; p.vx += Math.sign(cx - x) * 160 * k * power; }
      if (p.type === 'puddle') { p.ripples.push({ x: Math.max(p.x, Math.min(p.x + p.w, x)), t }); drops(S, p.x + p.w / 2, FLOOR, Math.round(8 * k), 1.2); }
      if (p.type === 'trap' && p.armed && k > .5) snap(S, p, t);
      if (p.type === 'door') p.open = Math.min(1, p.open + .6 * k);
    }
    leaves(S, x, Math.round(10 * power)); dust(S, x, FLOOR, Math.round(10 * power));
  }

  // ------------------------------------------------------------------ atualização
  let lastAttack = 0, attackId = 0, lastT = 0, cur = null, shotSeen = new WeakSet(), enemyVy = new WeakMap(), playerVy = 0;
  function update(dt, o) {
    const S = getSet(o); cur = S; if (!S) return;
    const t = Number(o.time) || 0, p = o.player; dt = Math.min(.05, dt || .016);
    // plataformas móveis: posição pela hora do jogo, com dx para carregar quem está em cima
    for (const m of S.plat) { const u = (Math.sin(t * Math.PI * 2 / m.period) + 1) / 2, e = u * u * (3 - 2 * u); if (m.kind === 'lift') { m.cx = m.x; m.cy = m.y0 + (m.y1 - m.y0) * e; m.dx = 0; } else { const nx = m.x0 + (m.x1 - m.x0) * e; m.dx = nx - m.cx; m.cx = nx; m.cy = m.y; } }
    if (lite()) return;
    const W = o.arena ? 1e9 : worldW(o.scene), f = p.facing < 0 ? -1 : 1;
    // golpe do jogador (cada golpe acerta cada objeto uma vez)
    if (p.attack > 0 && lastAttack <= 0) attackId++;
    lastAttack = p.attack;
    const atk = p.attack > 0 ? { x0: Math.min(p.x + f * 6, p.x + f * 90), x1: Math.max(p.x + f * 6, p.x + f * 90), y0: p.y - 95, y1: p.y + 6 } : null;
    for (const q of S.props) {
      const top = FLOOR - (q.h || 20) - (q.stack ? 28 : 0) + (q.y || 0), x0 = q.x, x1 = q.x + (q.w || 20);
      if (atk && q.hitBy !== attackId && atk.x1 > x0 && atk.x0 < x1 && atk.y1 > top && atk.y0 < FLOOR + 4 && (q.type !== 'door' && q.type !== 'puddle' && q.type !== 'grass')) { q.hitBy = attackId; hitProp(S, q, f, 1, t); }
      for (const s of o.shots || []) { if (!s || shotSeen.has(s) || (s.delay || 0) > 0) continue; if (s.x > x0 && s.x < x1 && s.y > top - 4 && s.y < FLOOR + 4 && q.type !== 'door' && q.type !== 'puddle' && q.type !== 'grass') { shotSeen.add(s); hitProp(S, q, Math.sign(s.vx || f) || f, .7, t); } }
    }
    // pouso do jogador perto de objetos e poças
    if (playerVy > 420 && p.ground) { for (const q of S.props) if (Math.abs(q.x + (q.w || 0) / 2 - p.x) < 90) { if (q.type === 'puddle' && p.x > q.x && p.x < q.x + q.w) { q.ripples.push({ x: p.x, t }); drops(S, p.x, FLOOR, 10, 1); } else if (BREAK[q.type] || PUSH[q.type]) { q.vy = Math.min(q.vy || 0, -90); q.wob = .6; } } }
    playerVy = p.vy || 0;
    // inimigos: pousos pesados viram onda de choque; correria quebra e empurra
    for (const e of o.enemies || []) { if (!e || e.hp <= 0) continue; const pv = enemyVy.get(e) || 0, big = ['giant', 'igor', 'reeisBoss', 'nikolas', 'freddy'].includes(e.type); if (pv > 380 && Math.abs(e.vy || 0) < 60 && e.y >= FLOOR - 6) shock(S, e.x, big ? 1.2 : .7, t); enemyVy.set(e, e.vy || 0);
      for (const q of S.props) { const x0 = q.x, x1 = q.x + (q.w || 20); if (e.x < x0 - 20 || e.x > x1 + 20 || e.y < FLOOR - 120) continue; if (PUSH[q.type]) { q.vx = (e.vx || 0) * 1.1; } if (BREAK[q.type] && Math.abs(e.vx || 0) > 260) hitProp(S, q, Math.sign(e.vx) || 1, 1, t); if (q.type === 'puddle' && Math.random() < .2) q.ripples.push({ x: e.x, t }); if (q.type === 'trap' && q.armed) snap(S, q, t); } }
    for (const m of o.minions || []) { if (!m || m.dead) continue; for (const q of S.props) if (q.type === 'trap' && q.armed && Math.abs(m.x - q.x - 9) < 14) snap(S, q, t); }
    // corrida (dash) levanta folhas e empurra o que é leve
    if (o.dashing) { for (const q of S.props) if (PUSH[q.type] && Math.abs(q.x - p.x) < 70) q.vx = f * 300; if (Math.random() < .5) S.fx.push({ k: 'leaf', x: p.x - f * 20, y: FLOOR - 10, vx: -f * 120, vy: -60, s: 4, col: '#a8c060', life: 1.2, ph: 0 }); }
    for (const q of S.props) {
      // quebráveis: quicam, balançam, voltam depois de um tempo
      if (BREAK[q.type]) { q.vy = (q.vy || 0) + 900 * dt; q.y = Math.min(0, (q.y || 0) + q.vy * dt); if (q.y >= 0 && q.vy > 0) { if (q.vy > 160) { q.vy = -q.vy * .3; dust(S, q.x + q.w / 2, FLOOR, 2); } else q.vy = 0; } q.wob = Math.max(0, q.wob - dt * 2);
        if (q.broken && t - q.broken > 28) { const far = Math.abs(q.x - (o.camera + 480)) > 560; if (far || t - q.broken > 40) { q.broken = 0; q.hp = q.type === 'barrel' ? 2 : 1; q.alpha = 0; if (q.segs) q.segs.fill(0); } } q.alpha = Math.min(1, (q.alpha ?? 1) + dt * 2); }
      // empurráveis: o jogador encosta e empurra; rolam, quicam e param
      if (PUSH[q.type]) { const near = p.x > q.x - 10 && p.x < q.x + q.w + 10 && p.y > FLOOR - 40; if (near && Math.abs(p.vx || 0) > 30 && Math.sign(p.vx) === Math.sign(q.x + q.w / 2 - p.x)) { q.vx = p.vx * 1.15; if (q.type === 'cone' && Math.abs(p.vx) > 200 && !q.fall) { q.fall = 1; } }
        q.vy = (q.vy || 0) + 1000 * dt; q.y = Math.min(0, (q.y || 0) + q.vy * dt); if (q.y >= 0 && q.vy > 0) q.vy = q.vy > 140 ? -q.vy * (q.type === 'ball' ? .62 : .25) : 0;
        q.x += q.vx * dt; q.vx *= Math.pow(q.y < 0 ? .9 : (q.type === 'ball' || q.type === 'tire' ? .55 : .12), dt); if (Math.abs(q.vx) < 4) q.vx = 0; q.rot += q.vx * dt / (q.w / 2);
        if (q.x < 20 || q.x > W - 40) { q.x = Math.max(20, Math.min(W - 40, q.x)); q.vx = -q.vx * .5; } }
      if (q.type === 'door') { const near = Math.abs(p.x - (q.x + q.w / 2)) < (q.kind === 'class' ? 90 : 70) && p.y > FLOOR - 80; { const was = q.open; q.open += ((near ? 1 : 0) - q.open) * Math.min(1, dt * 6); if (was < .05 && q.open >= .05) sound('porta'); }; }
      if (q.type === 'lever') q.flip = Math.max(0, q.flip - dt * 3);
      if (q.type === 'puddle') { if (p.x > q.x && p.x < q.x + q.w && p.ground && Math.abs(p.vx || 0) > 60 && Math.random() < dt * 8) { q.ripples.push({ x: p.x, t }); drops(S, p.x, FLOOR, 2, .5); } const rain = window.Weather?.state?.().rain || 0; if (rain > .1 && Math.random() < rain * dt * 10) q.ripples.push({ x: q.x + Math.random() * q.w, t, small: 1 }); q.ripples = q.ripples.filter((r) => t - r.t < 1.2); }
      if (q.type === 'trap') { if (q.armed && Math.abs(p.x - q.x - 9) < 12 && p.ground) snap(S, q, t); if (!q.armed && t - q.t > 8) q.armed = true; }
      if (q.type === 'grill') q.burst = Math.max(0, q.burst - dt * 1.5);
      if (q.type === 'grass') { const rain = window.Weather?.state?.().rain || 0;
        q.cells.forEach((cell, i) => { if (cell.s === 1) { if (rain > .35) { cell.s = 2; cell.t = t; } else { if (t - cell.t > .35 && Math.random() < dt * 3) for (const j of [i - 1, i + 1]) if (q.cells[j] && q.cells[j].s === 0) { q.cells[j].s = 1; q.cells[j].t = t; } if (t - cell.t > 2.6) { cell.s = 2; cell.t = t; } if (Math.random() < dt * 6) S.fx.push({ k: 'ember', x: q.x + i * 8 + 4, y: FLOOR - 10, vx: (Math.random() - .5) * 30, vy: -60 - Math.random() * 80, s: 2, col: Math.random() > .5 ? '#ffb030' : '#ff6a20', life: .9 }); } } else if (cell.s === 2 && t - cell.t > 30) { cell.s = 0; } }); }
    }
    // irrigador molha o capim (não pega fogo)
    S.wet = Math.max(0, (S.wet || 0) - dt); for (const q of S.props) if (q.type === 'lever' && q.on && q.effect === 'sprinkler') S.wet = 2;
    // tempestade: raio pode acender capim seco à vista
    const wx = window.Weather?.state?.(); if (wx && wx.flash > .95 && Math.random() < .3) igniteNear(S, o.camera + 200 + Math.random() * 560, 60, t);
    // partículas
    for (const fx of S.fx) { fx.life -= dt; fx.vy += (fx.k === 'puff' ? -10 : fx.k === 'leaf' ? 0 : fx.k === 'ember' ? -40 : 900) * dt; if (fx.k === 'leaf') { fx.vx += Math.sin(t * 3 + fx.ph) * 40 * dt; } fx.x += fx.vx * dt; fx.y += fx.vy * dt; if ((fx.k === 'chunk' || fx.k === 'drop') && fx.y > FLOOR - 2) { fx.y = FLOOR - 2; fx.vy *= -.25; fx.vx *= .6; if (fx.k === 'drop') fx.life = Math.min(fx.life, .1); } if (fx.k === 'leaf' && fx.y > FLOOR - 4) { fx.y = FLOOR - 4; fx.vy = 0; fx.vx *= .9; } }
    S.fx = S.fx.filter((fx) => fx.life > 0).slice(-420); S.texts.forEach((x) => { x.life -= dt; x.y -= 30 * dt; }); S.texts = S.texts.filter((x) => x.life > 0);
    lastT = t;
  }

  // ------------------------------------------------------------------ desenho
  const vis = (o, x, w = 100) => x + w > o.camera - 60 && x < o.camera + 1020;
  function drawProp(c, q, t, o) {
    const b = FLOOR + (q.y || 0) - (q.stack ? 28 : 0), x = q.x;
    if (BREAK[q.type]) {
      if (q.broken) { if (q.type !== 'fence') { R(c, x + 2, FLOOR - 4, q.w - 4, 4, 'rgba(60,40,20,.35)'); R(c, x + 6, FLOOR - 6, 6, 2, '#8a6238'); R(c, x + q.w - 12, FLOOR - 4, 8, 2, '#5a4028'); } }
      c.save(); c.globalAlpha = q.alpha ?? 1; const wob = Math.round(Math.sin(t * 30) * q.wob * 2);
      if (q.type === 'crate' && !q.broken) { R(c, x + wob, b - 28, 30, 28, '#5a4028'); R(c, x + 2 + wob, b - 26, 26, 24, '#a87a48'); for (let k = 0; k < 3; k++) R(c, x + 2 + wob, b - 26 + k * 8, 26, 2, '#8a6238'); R(c, x + 2 + wob, b - 26, 26, 2, '#c49a5c'); R(c, x + 2 + wob, b - 26, 2, 24, '#c49a5c'); for (let k = 0; k < 12; k++) R(c, x + 4 + k * 2 + wob, b - 24 + k * 2, 2, 2, '#7a5430'); }
      if (q.type === 'pot' && !q.broken) { R(c, x + 1, b - 14, 16, 14, '#a85a40'); R(c, x + 1, b - 14, 4, 14, '#cf7a5a'); R(c, x - 1, b - 16, 20, 4, '#d99572'); for (let k = 0; k < 4; k++) { const sw = Math.round(Math.sin(t * 2 + k + x) * 1.5); R(c, x + 3 + k * 4 + sw, b - 26 + (k % 2) * 3, 4, 10, k % 2 ? '#4f9a3f' : '#6fb24a'); } R(c, x + 7, b - 30, 4, 4, '#e86a8a'); }
      if (q.type === 'hay' && !q.broken) { R(c, x, b - 26, 40, 26, '#a77c45'); R(c, x - 2, b - 30, 44, 6, '#dfbd6c'); for (let k = 0; k < 40; k += 4) R(c, x + k, b - 24, 2, 22, '#c79a56'); R(c, x, b - 18, 40, 2, '#8a6238'); R(c, x, b - 8, 40, 2, '#8a6238'); }
      if (q.type === 'melon' && !q.broken) { R(c, x, b - 16, 22, 16, '#2f7a3a'); R(c, x + 2, b - 14, 18, 2, '#5aaa5a'); for (let k = 0; k < 4; k++) R(c, x + 3 + k * 5, b - 16, 2, 16, '#1f5a2a'); R(c, x + 10, b - 18, 2, 2, '#5a4028'); }
      if (q.type === 'barrel' && !q.broken) { R(c, x + wob, b - 34, 26, 34, '#8a6238'); R(c, x + 2 + wob, b - 34, 4, 34, '#a87a48'); R(c, x + 20 + wob, b - 34, 4, 34, '#5a4028'); for (const yy of [6, 16, 28]) R(c, x + wob, b - 34 + yy, 26, 2, '#3a3a3a'); R(c, x + 2 + wob, b - 36, 22, 2, '#5a4028'); }
      if (q.type === 'fence') { for (let k = 0; k < q.segs.length; k++) { if (q.segs[k]) continue; const fx = x + k * 18; R(c, fx, b - 34, 6, 34, '#756c48'); R(c, fx, b - 34, 2, 34, '#a38e5e'); R(c, fx, b - 36, 6, 2, '#c1ae76'); if (k < q.segs.length - 1 && !q.segs[k + 1]) { R(c, fx, b - 26, 18, 4, '#6c6945'); R(c, fx, b - 14, 18, 4, '#6c6945'); R(c, fx, b - 26, 18, 2, '#b7ab70'); } } }
      c.restore(); return;
    }
    if (PUSH[q.type]) { const cx = x + q.w / 2, cy = FLOOR + q.y - q.h / 2; c.save(); R(c, x + 2, FLOOR - 2, q.w - 4, 2, 'rgba(0,0,0,.25)'); c.translate(Math.round(cx / 2) * 2, Math.round(cy / 2) * 2);
      if (q.type === 'tire') { c.rotate(Math.round(q.rot * 4) / 4); R(c, -13, -13, 26, 26, '#1e1e22'); R(c, -7, -7, 14, 14, '#4a4a4e'); R(c, -4, -4, 8, 8, '#2a2a2e'); for (let k = 0; k < 4; k++) { c.rotate(Math.PI / 2); R(c, -2, -13, 4, 3, '#3a3a40'); } }
      if (q.type === 'ball') { c.rotate(Math.round(q.rot * 4) / 4); R(c, -8, -6, 16, 12, '#f4f4ea'); R(c, -6, -8, 12, 16, '#f4f4ea'); R(c, -2, -2, 4, 4, '#2a2a2a'); R(c, -8, -2, 2, 4, '#2a2a2a'); R(c, 6, -2, 2, 4, '#2a2a2a'); R(c, -2, -8, 4, 2, '#2a2a2a'); }
      if (q.type === 'bucket') { c.rotate(q.vx ? Math.round(q.rot * 4) / 4 : 0); R(c, -9, -10, 18, 20, '#3a7ab8'); R(c, -9, -10, 4, 20, '#5a9ad8'); R(c, -10, -12, 20, 3, '#2a5a8a'); R(c, -8, -16, 16, 2, '#8a96a0'); }
      if (q.type === 'trash') { R(c, -11, -15, 22, 30, '#3f8a52'); R(c, -11, -15, 4, 30, '#57a86a'); R(c, -12, -17, 24, 4, '#2f6a3e'); R(c, -4, -6, 8, 8, '#e9f2e0'); }
      if (q.type === 'cone') { if (q.fall) c.rotate(Math.PI / 2 * Math.sign(q.vx || 1)); R(c, -7, 6, 14, 3, '#b05c18'); R(c, -5, -4, 10, 10, '#e8842a'); R(c, -3, -9, 6, 6, '#e8842a'); R(c, -5, 0, 10, 2, '#ffffff'); }
      c.restore(); return; }
    if (q.type === 'door') { const op = Math.max(0, Math.min(1, q.open)); if (op < .02) return; const top = FLOOR - q.h - (q.kind === 'house' ? 4 : 0), w = q.w;
      R(c, x, top, w, q.h, '#1a1410'); const night = window.DayTime?.state?.().night || 0; if (night > .1) R(c, x + 2, top + 2, w - 4, q.h - 4, `rgba(255,200,120,${.35 * night})`); R(c, x + 4, FLOOR - 12, w - 8, 4, 'rgba(255,220,160,.12)');
      const pw = Math.round(w * (1 - op * .82)); const col = q.kind === 'class' ? '#7f9ba1' : q.kind === 'fav' ? '#647b6f' : q.kind === 'main' ? '#526661' : '#886641'; R(c, x, top, pw, q.h, col); R(c, x, top, 2, q.h, 'rgba(255,255,255,.2)'); R(c, x + pw - 2, top, 2, q.h, 'rgba(0,0,0,.3)'); R(c, x + pw - 6, top + q.h * .5, 2, 4, '#e4ba73'); return; }
    if (q.type === 'lever') { R(c, x - 2, FLOOR - 30, 18, 30, '#4a4a52'); R(c, x, FLOOR - 28, 14, 26, '#6a6a74'); R(c, x, FLOOR - 28, 14, 2, '#9a9aa8'); R(c, x + 2, FLOOR - 24, 10, 4, q.on ? '#6ad86a' : '#d83a3a'); const ang = (q.on ? -.6 : .6) * (1 - q.flip * .3); c.save(); c.translate(x + 7, FLOOR - 12); c.rotate(ang); R(c, -2, -20, 4, 20, '#2a2a2e'); R(c, -4, -24, 8, 6, '#e04a3a'); c.restore(); return; }
    if (q.type === 'puddle') { const y = FLOOR + 6; R(c, x, y, q.w, 6, 'rgba(120,170,200,.45)'); R(c, x + 6, y - 2, q.w - 12, 2, 'rgba(120,170,200,.45)'); R(c, x + 6, y + 6, q.w - 12, 2, 'rgba(120,170,200,.35)'); R(c, x + 10, y, q.w * .4, 2, 'rgba(230,245,255,.5)'); for (const r of q.ripples) { const u = (t - r.t) / 1.2, rr = (r.small ? 10 : 24) * u + 2; c.fillStyle = `rgba(230,245,255,${(1 - u) * .8})`; for (let a = 0; a < 16; a++) { const an = a / 16 * Math.PI * 2, px = r.x + Math.cos(an) * rr, py = y + 3 + Math.sin(an) * rr * .25; if (px > x && px < x + q.w) c.fillRect(Math.round(px / 2) * 2, Math.round(py / 2) * 2, 2, 2); } } return; }
    if (q.type === 'trap') { R(c, x, FLOOR - 4, 18, 4, '#8a6238'); R(c, x, FLOOR - 4, 18, 2, '#a87a48'); if (q.armed) { R(c, x + 2, FLOOR - 8, 2, 4, '#a8a8b0'); R(c, x + 2, FLOOR - 8, 14, 2, '#a8a8b0'); R(c, x + 12, FLOOR - 8, 4, 4, '#f2d24a'); } else { R(c, x + 2, FLOOR - 6, 14, 2, '#a8a8b0'); } return; }
    if (q.type === 'grill') { R(c, x, FLOOR - 22, 30, 4, '#2a2a2e'); R(c, x + 2, FLOOR - 18, 26, 6, '#3a3a40'); R(c, x + 4, FLOOR - 12, 2, 12, '#2a2a2e'); R(c, x + 24, FLOOR - 12, 2, 12, '#2a2a2e'); for (let k = 0; k < 6; k++) R(c, x + 4 + k * 4, FLOOR - 24, 2, 2, Math.sin(t * 9 + k) > 0 ? '#ff8a30' : '#ffd060'); for (let k = 0; k < 4; k++) { const u = (t * .7 + k / 4) % 1; c.fillStyle = `rgba(200,200,200,${(1 - u) * .45})`; c.fillRect(Math.round((x + 10 + Math.sin(t + k) * 4 * u) / 2) * 2, Math.round((FLOOR - 28 - u * 50) / 2) * 2, 4 + u * 6, 4 + u * 4); } R(c, x + 6, FLOOR - 26, 8, 2, '#c94f45'); R(c, x + 16, FLOOR - 26, 8, 2, '#e8c070'); return; }
    if (q.type === 'grass') { q.cells.forEach((cell, i) => { const gx = x + i * 8, sw = Math.round(Math.sin(t * 2.5 + gx * .05) * 2); if (cell.s === 0) { R(c, gx + sw, FLOOR - 12, 2, 12, '#c8b060'); R(c, gx + 4, FLOOR - 9, 2, 9, '#a89048'); R(c, gx + 2 + sw, FLOOR - 15, 2, 4, '#e0c878'); } else if (cell.s === 2) { R(c, gx, FLOOR - 3, 6, 3, '#2a2420'); if ((i + Math.floor(t)) % 5 === 0) R(c, gx + 2, FLOOR - 5, 2, 2, '#5a5048'); } else { const fh = 22 + Math.sin(t * 15 + i * 1.7) * 8 + Math.sin(t * 23 + i) * 4; c.save(); c.globalAlpha = .35; R(c, gx - 6, FLOOR - fh - 16, 20, fh + 16, '#ff9a30'); c.restore(); R(c, gx - 1, FLOOR - fh, 10, fh, '#e8401a'); R(c, gx + 1, FLOOR - fh * .8, 6, fh * .8, '#ff8a20'); R(c, gx + 2, FLOOR - fh * .5, 4, fh * .5, '#ffd040'); R(c, gx + 3, FLOOR - fh * .25, 2, fh * .25, '#fff6c0'); if ((i + Math.floor(t * 6)) % 3 === 0) R(c, gx + 2, FLOOR - fh - 6, 2, 4, '#ffb030'); const u = (t * .8 + i * .37) % 1; c.fillStyle = `rgba(70,64,60,${(1 - u) * .45})`; c.fillRect(Math.round((gx + Math.sin(t + i) * 8 * u) / 2) * 2, Math.round((FLOOR - fh - 10 - u * 70) / 2) * 2, 6 + u * 10, 6 + u * 8); } }); return; }
  }
  function drawEffects(c, S, t, o) {
    for (const q of S.props) if (q.type === 'lever' && q.on) {
      const x = q.x; if (!vis(o, x - 300, 700)) continue;
      if (q.effect === 'sprinkler') { const sx = x + 240; R(c, sx - 4, FLOOR - 8, 8, 8, '#5a6a72'); R(c, sx - 2, FLOOR - 18, 4, 10, '#5a6a72'); for (let j = 0; j < 90; j++) { const u = ((t * 1.1 + j / 90) % 1), side = j % 2 ? 1 : -1, px = sx + side * u * (130 + (j % 5) * 26) + Math.sin(t * 2) * 24 * u, py = FLOOR - 18 - Math.sin(u * Math.PI) * (90 + (j % 3) * 20); R(c, px, py, j % 4 ? 2 : 4, 4, j % 3 ? '#7ac4ee' : '#e8f8ff'); } for (let j = 0; j < 8; j++) { const u = (t * 1.5 + j / 8) % 1, px = sx + (j % 2 ? 1 : -1) * (100 + j * 12); c.fillStyle = `rgba(230,245,255,${(1 - u) * .7})`; c.fillRect(Math.round((px - u * 10) / 2) * 2, FLOOR - 2, Math.round((4 + u * 20) / 2) * 2, 2); } const sun = window.DayTime?.state?.(); if (sun && sun.sunT !== null && (window.Weather?.state?.().rain || 0) < .3) { c.save(); c.globalAlpha = .28; ['#ff4040', '#ffa030', '#ffe040', '#40d040', '#4080ff', '#9040e0'].forEach((col, k) => { for (let a = 0; a <= 30; a++) { const an = Math.PI + a / 30 * Math.PI, rr = 110 - k * 4; R(c, sx + Math.cos(an) * rr, FLOOR - 20 + Math.sin(an) * rr * .7, 2, 2, col); } }); c.restore(); } }
      if (q.effect === 'fountain') { const fx = 1050, h = 150 + Math.sin(t * 3) * 20; for (let k = 0; k < h; k += 4) { const w = 6 + Math.sin(k * .2 + t * 8) * 2; R(c, fx - w / 2, FLOOR - 140 - k, w, 4, k % 8 ? '#bfe6f6' : '#ffffff'); } for (let j = 0; j < 30; j++) { const u = (t * .9 + j / 30) % 1, side = j % 2 ? 1 : -1, px = fx + side * u * 80, py = FLOOR - 140 - h + u * u * (h + 40) - Math.sin(u * Math.PI) * 30; R(c, px, py, 2, 4, '#dff4ff'); } }
      if (q.effect === 'party') { const y0 = 230; for (let k = -10; k < 40; k++) { const px = x - 300 + k * 24, py = y0 + Math.sin(k * .5) * 6, on = (k + Math.floor(t * 8)) % 3 === 0; R(c, px, py - 2, 24, 2, '#2a2220'); R(c, px + 10, py, 4, 6, on ? ['#ff4a8a', '#4ad8ff', '#ffe040', '#6aff6a'][(k + 400) % 4] : '#5a4a40'); } for (let j = 0; j < 6; j++) { const u = (t * .4 + j / 6) % 1; R(c, x + 40 + j * 30 + Math.sin(t * 2 + j) * 10, FLOOR - 60 - u * 120, 4, 6, '#fff0c4'); R(c, x + 44 + j * 30 + Math.sin(t * 2 + j) * 10, FLOOR - 66 - u * 120, 2, 8, '#fff0c4'); } }
      if (q.effect === 'bell') { const bx = x + 40, by = 250; R(c, bx - 10, by - 10, 20, 20, '#c94f45'); R(c, bx - 6, by - 6, 12, 12, '#e8c84a'); const sh = Math.round(Math.sin(t * 50) * 2); R(c, bx - 2 + sh, by - 2, 4, 4, '#3a2a20'); for (let k = 0; k < 3; k++) { const u = (t * 1.5 + k / 3) % 1, rr = 14 + u * 60; c.fillStyle = `rgba(255,240,180,${(1 - u) * .7})`; for (let a = 0; a < 20; a++) { const an = a / 20 * Math.PI * 2; c.fillRect(Math.round((bx + Math.cos(an) * rr) / 2) * 2, Math.round((by + Math.sin(an) * rr * .6) / 2) * 2, 2, 2); } } }
      if (q.effect === 'flood') { c.save(); c.globalCompositeOperation = 'lighter'; for (const k of [-1, 1]) { const ox = x + k * 260, ang = Math.sin(t * .8 + k) * .4; const g = c.createLinearGradient(0, 120, 0, FLOOR); g.addColorStop(0, 'rgba(255,250,220,.35)'); g.addColorStop(1, 'rgba(255,250,220,.02)'); c.fillStyle = g; c.beginPath(); c.moveTo(ox - 8, 120); c.lineTo(ox + 8, 120); c.lineTo(ox + Math.sin(ang) * 300 + 70, FLOOR); c.lineTo(ox + Math.sin(ang) * 300 - 70, FLOOR); c.closePath(); c.fill(); } c.restore(); }
    }
    for (const fx of S.fx) { if (!vis(o, fx.x, 10)) continue; const a = Math.max(0, Math.min(1, fx.life * 2)); c.globalAlpha = a; if (fx.k === 'puff') { const s = fx.s * (1.6 - fx.life); R(c, fx.x - s / 2, fx.y - s / 2, s, s, fx.col); } else if (fx.k === 'leaf') { R(c, fx.x, fx.y, 4, 2, fx.col); R(c, fx.x + 2, fx.y - 2, 2, 2, fx.col); } else R(c, fx.x, fx.y, fx.s, fx.s, fx.col); }
    c.globalAlpha = 1;
    c.save(); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; for (const x of S.texts) { c.globalAlpha = Math.min(1, x.life * 2); c.fillStyle = '#2a1a10'; c.fillText(x.txt, x.x + 2, x.y + 2); c.fillStyle = x.col; c.fillText(x.txt, x.x, x.y); } c.restore();
  }
  function drawPlatformRigs(c, S, o) { for (const m of S.plat) { if (!vis(o, (m.x ?? m.x0) - 40, 300)) continue; if (m.kind === 'lift') { const cx = m.x + 35; for (let y = 0; y < m.cy; y += 6) R(c, cx - 1, y, 2, 4, '#5a5a62'); R(c, cx - 10, m.cy - 10, 20, 8, '#3a3a42'); R(c, m.x - 4, m.cy + 12, 2, FLOOR - m.cy - 12, 'rgba(90,90,98,.35)'); R(c, m.x + 72, m.cy + 12, 2, FLOOR - m.cy - 12, 'rgba(90,90,98,.35)'); } else { R(c, m.x0, m.y - 8, m.x1 - m.x0 + 70, 2, '#5a5a62'); for (let x = m.x0; x < m.x1 + 70; x += 30) R(c, x, m.y - 10, 2, 4, '#3a3a42'); const cx = m.cx + 35; R(c, cx - 1, m.y - 8, 2, 8, '#5a5a62'); } } }

  function drawBack(c, o) { const S = getSet(o); if (!S) return; drawPlatformRigs(c, S, o); if (lite()) return; const t = Number(o.time) || 0; for (const q of S.props) if (vis(o, q.x, q.w || 60) && (q.type === 'door' || q.type === 'puddle' || q.type === 'grass' || q.type === 'lever' || q.type === 'grill' || q.type === 'trap')) drawProp(c, q, t, o); for (const q of S.props) if (vis(o, q.x, q.w || 60) && (BREAK[q.type] || PUSH[q.type])) drawProp(c, q, t, o); }
  function drawFront(c, o) { const S = getSet(o); if (!S || lite()) return; drawEffects(c, S, Number(o.time) || 0, o); }
  // luz do fogo, da brasa e dos efeitos (aditiva, chamada pela camada de luz)
  function platforms(o) { const S = getSet(o); if (!S) return []; return S.plat.map((m) => [Math.round(m.cx), Math.round(m.cy), m.w, m.dx || 0]); }
  // Fases de fora (Campanha 2, cenas 12+): mesma lista de objetos do SPEC acima. Não muda as fases 0 a 11.
  function addScene(scene, list) { scene = Number(scene); if (!(scene >= 12) || !Array.isArray(list)) return false; SPEC[scene] = list; if (!OUT.includes(scene)) OUT.push(scene); delete sets['scene:' + scene]; return true; }
  window.Interact = Object.freeze({ addScene, update: (dt, o) => { try { update(dt, o || {}); } catch (e) { window.__interactError = e; } }, drawBack: (c, o) => { try { drawBack(c, o || {}); } catch (e) { window.__interactError = e; } }, drawFront: (c, o) => { try { drawFront(c, o || {}); } catch (e) { window.__interactError = e; } }, platforms: (o) => { try { return platforms(o || {}); } catch (e) { return []; } }, shock: (x, power) => { if (cur) shock(cur, x, power || 1, lastT); }, ignite: (x) => { if (cur) igniteNear(cur, x, 12, lastT); }, debug: () => cur });
})();
