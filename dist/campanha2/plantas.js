/* Campanha 2 · Plantinhas interativas no chão (como o trigal da roça).
   Pequenos canteiros espalhados pelos cenários de Conquista: capim, flores, samambaias, matinho de
   calçada com dente-de-leão, pés de café, o cacto cabeça-de-frade da serra e floreiras nos lugares
   fechados. As plantas se abrem quando Da Roça passa (física de mola), voltam balançando, soltam
   pétalas, folhas, sementinhas e grãos; o golpe corta e elas crescem de volta. O cacto dá um "AI!".
   Fileira de trás desenhada antes do herói e fileira da frente depois. Só aparência: sem dano. */
(() => {
  'use strict';
  if (window.CampanhaPlantas) return;
  const FLOOR = 440;
  const hash = (i) => { const x = Math.sin(i * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const cl = (v, a = 0, b = 1) => Math.max(a, Math.min(b, v));
  const P2 = (v) => Math.round(v / 2) * 2;
  const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(P2(x), P2(y), Math.max(2, P2(w)), Math.max(2, P2(h))); };

  // canteiros por cena: [tipo, x, largura] em pixels do mundo
  const PATCHES = {
    12: [['floreira', 240, 120], ['floreira', 1240, 90], ['floreira', 3040, 140], ['floreira', 4100, 120], ['capim', 2160, 120]],
    13: [['mato', 160, 70], ['flores', 520, 110], ['mato', 1380, 60], ['capim', 2050, 120], ['flores', 2940, 90], ['mato', 3460, 70], ['flores', 3880, 120]],
    14: [['flores', 1840, 160], ['flores', 2300, 120], ['capim', 2700, 140], ['flores', 3100, 110], ['mato', 420, 60], ['mato', 4300, 70], ['mato', 4700, 60]],
    15: [['capim', 120, 200], ['flores', 480, 120], ['cacto', 760, 60], ['samambaia', 1250, 90], ['capim', 1700, 220], ['cacto', 2150, 50], ['flores', 2560, 140], ['capim', 3120, 180], ['cacto', 3500, 60], ['samambaia', 3900, 100], ['flores', 4300, 160]],
    16: [['mato', 300, 70], ['capim', 1500, 120], ['flores', 2900, 140], ['flores', 3100, 120], ['mato', 3900, 60], ['capim', 4600, 100], ['mato', 5500, 70]],
    17: [['flores', 260, 90], ['mato', 1000, 60], ['capim', 2060, 80], ['flores', 3600, 100], ['mato', 4100, 60]],
    18: [['cafe', 400, 160], ['capim', 900, 160], ['flores', 1300, 100], ['cafe', 2100, 200], ['samambaia', 2900, 80], ['capim', 3400, 200], ['cafe', 4300, 180], ['flores', 4800, 120]],
    19: [['flores', 300, 140], ['capim', 1300, 90], ['flores', 2600, 120], ['samambaia', 3300, 80], ['flores', 3900, 140]],
    20: [['floreira', 160, 120], ['floreira', 1120, 100], ['floreira', 2900, 130], ['floreira', 3720, 110]],
    21: [['capim', 200, 160], ['flores', 900, 140], ['capim', 1700, 120], ['flores', 2140, 110], ['capim', 3100, 160], ['flores', 4060, 120], ['mato', 4900, 70]]
  };
  const FLOWER = ['#e86a8a', '#f2c94c', '#f6f2ea', '#b86ad8', '#f08a4a', '#e84a4a', '#7ab8f0'];
  let sets = {}, parts = [], lastT = 0, lastSound = 0, said = 0;

  function build(scene) {
    const out = [];
    for (const [type, x0, w] of PATCHES[scene] || []) {
      const step = type === 'cacto' ? 18 : type === 'cafe' ? 16 : type === 'floreira' ? 7 : type === 'samambaia' ? 12 : type === 'mato' ? 6 : 5;
      for (let x = x0; x < x0 + w; x += step) {
        const i = out.length + 1, r = hash(i + scene * 97 + x), r2 = hash(i * 7 + x);
        const edge = cl(Math.min(x - x0, x0 + w - x) / 24 + .35);
        const base = FLOOR - 4 + Math.round(r2 * 5) * 2; // 436..446: metade atrás, metade na frente
        const h = { capim: 12 + r * 14, flores: 10 + r * 12, mato: 6 + r * 6, samambaia: 14 + r * 8, cafe: 16 + r * 8, cacto: 10 + r * 4, floreira: 10 + r * 10 }[type] * edge;
        out.push({ type, x: x + (r2 - .5) * step * .7, base: type === 'floreira' ? FLOOR - 2 + (r2 > .5 ? 4 : 0) : base, h, hh: h, ph: r * 6.28, tone: r2, a: 0, w: 0, cut: 0, col: FLOWER[Math.floor(r * 7)], seeds: type === 'mato' && r > .55 });
      }
    }
    out.sort((a, b) => a.base - b.base);
    return { stems: out, pots: (PATCHES[scene] || []).filter((p) => p[0] === 'floreira') };
  }
  const get = (scene) => { if (!PATCHES[scene]) return null; if (!sets[scene]) sets[scene] = build(scene); return sets[scene]; };

  function burst(s, n, kind) {
    const lite = !!window.Graphics?.isLite?.(); if (lite) n = Math.ceil(n / 3); if (parts.length > 120) parts.splice(0, parts.length - 120);
    const tx = s.x + Math.sin(s.a) * s.h, ty = s.base - Math.cos(s.a) * s.h;
    for (let k = 0; k < n; k++) parts.push({ x: tx + (Math.random() - .5) * 6, y: ty, vx: (Math.random() - .5) * 70, vy: kind === 'semente' ? -30 - Math.random() * 30 : -60 - Math.random() * 60, life: kind === 'semente' ? 2.5 + Math.random() * 2 : 1 + Math.random() * .8, kind, col: kind === 'petala' ? s.col : kind === 'grao' ? '#d8343a' : kind === 'semente' ? '#f4f2ea' : s.tone > .5 ? '#5f9a46' : '#7ab04a' });
  }
  function say(text, x, y) { if (performance.now() - said < 900) return; said = performance.now(); parts.push({ x, y, vx: 0, vy: -30, life: 1.1, kind: 'texto', text }); }

  function update(o, dt) {
    const S = get(o.scene); if (!S) return;
    const p = o.player || {}, px = Number(p.x) || 0, py = Number(p.y) || FLOOR, vx = Number(p.vx) || 0, t = Number(o.time) || 0, atk = Number(p.attack) > 0, face = p.facing < 0 ? -1 : 1;
    const wind = (Number(window.Weather?.state?.()?.wind) || .25) * .6 + .15; let touched = false;
    for (const s of S.stems) {
      if (Math.abs(s.x - (o.camera + 480)) > 620) continue;
      const gust = Math.sin(t * 1.4 - s.x * .05 + s.ph * .3) * .5 + .5;
      let target = s.type === 'cacto' ? 0 : wind * (.15 + gust * .35) * (s.type === 'floreira' ? .3 : 1) + Math.sin(t * 2.2 + s.ph) * .04;
      const d = s.x - px, R0 = s.type === 'cacto' ? 12 : 16;
      if (Math.abs(d) < R0 + 6 && py > s.base - s.h * 1.2) {
        const f = cl(1 - Math.abs(d) / R0), side = d > 1 ? 1 : d < -1 ? -1 : (vx >= 0 ? 1 : -1);
        if (f > 0) {
          touched = true;
          if (s.type === 'cacto') { s.w += side * dt * 20 * f; if (Math.abs(vx) > 40) say('AI!', s.x, s.base - 30); }
          else { target = side * (.6 + .7 * Math.sqrt(f)) + vx * .001 * f;
            if (Math.abs(vx) > 90 && Math.random() < dt * 6 * f) burst(s, 1, s.type === 'flores' || s.type === 'floreira' ? 'petala' : s.seeds ? 'semente' : s.type === 'cafe' ? 'grao' : 'folha'); }
        }
      }
      // golpe: corta e espalha (depois cresce de novo)
      if (atk && s.cut < .5 && Math.sign(d) === face && Math.abs(d) < 90 && py > s.base - 60 && s.type !== 'cacto') { s.cut = 1; s.w += face * 8; burst(s, 4, s.type === 'flores' || s.type === 'floreira' ? 'petala' : s.seeds ? 'semente' : s.type === 'cafe' ? 'grao' : 'folha'); }
      s.cut = Math.max(0, s.cut - dt * .18); s.hh = s.h * (1 - s.cut * .65);
      const acc = (target - s.a) * (s.type === 'cacto' ? 40 : 70) - s.w * 7; s.w += acc * dt; s.a = cl(s.a + s.w * dt, -1.3, 1.3);
    }
    if (touched && Math.abs(vx) > 60 && t - lastSound > .22) { lastSound = t; try { window.DarocaAudio?.play?.('mato', { volume: .35 }); } catch (e) {} }
    for (let i = parts.length - 1; i >= 0; i--) { const q = parts[i]; q.life -= dt;
      if (q.kind === 'semente') { q.vx += (wind * 40 - q.vx) * dt; q.vy += (-6 - q.vy) * dt; q.x += q.vx * dt + Math.sin(t * 3 + i) * 8 * dt; q.y += q.vy * dt; }
      else if (q.kind === 'texto') q.y += q.vy * dt;
      else { q.vy += 160 * dt; q.vx *= 1 - dt * 1.5; q.x += q.vx * dt + (q.kind === 'petala' ? Math.sin(t * 5 + i) * 14 * dt : 0); q.y += q.vy * dt; if (q.y > FLOOR + 6) { q.y = FLOOR + 6; q.vy = 0; q.vx = 0; } }
      if (q.life <= 0) parts.splice(i, 1); }
  }

  /* ---------- desenho de cada planta (2x2 px, mesmo grão dos cenários) ---------- */
  function stem(c, s, t) {
    const n = Math.max(3, Math.round(s.hh / 2)), sa = Math.sin(s.a), ca = Math.cos(s.a * .9);
    const pt = (k) => [s.x + sa * s.hh * Math.pow(k / n, 1.6), s.base - k * 2 * ca];
    switch (s.type) {
      case 'capim': { const cols = s.tone > .6 ? ['#6f9a3a', '#9cc45a'] : s.tone > .25 ? ['#4f8a3a', '#79b04a'] : ['#a8a04a', '#d0c06a'];
        for (const off of [-2, 0, 2]) { for (let k = 0; k <= n; k++) { const [x, y] = pt(k); R(c, x + off * (1 - k / n) * 1.5, y, 2, 2, k > n * .6 ? cols[1] : cols[0]); } } break; }
      case 'mato': { for (let k = 0; k <= n; k++) { const [x, y] = pt(k); R(c, x, y, 2, 2, '#5a8a3a'); if (k === Math.floor(n / 2)) { R(c, x - 2, y, 2, 2, '#6f9a46'); R(c, x + 2, y - 2, 2, 2, '#6f9a46'); } }
        const [x, y] = pt(n); if (s.seeds && s.cut < .3) { R(c, x - 2, y - 4, 6, 6, '#f4f2ea'); R(c, x, y - 2, 2, 2, '#d8d4c8'); } else R(c, x - 2, y - 2, 6, 4, '#f2c94c'); break; }
      case 'flores': case 'floreira': { for (let k = 0; k <= n; k++) { const [x, y] = pt(k); R(c, x, y, 2, 2, '#4f8a3a'); if (k === Math.floor(n * .4)) { R(c, x - 4, y, 4, 2, '#5f9a46'); R(c, x + 2, y - 2, 4, 2, '#6aa64a'); } }
        if (s.cut < .4) { const [x, y] = pt(n); R(c, x - 4, y - 2, 10, 4, s.col); R(c, x - 2, y - 4, 6, 8, s.col); R(c, x, y - 2, 2, 2, s.col === '#f2c94c' ? '#c47a35' : '#f2e06a'); } break; }
      case 'samambaia': { for (const dir of [-1, 1]) for (let k = 0; k <= n; k++) { const u = k / n, x = s.x + dir * u * s.hh * .7 + sa * s.hh * u * u, y = s.base - Math.sin(u * Math.PI * .8) * s.hh * .8 * ca; R(c, x, y, 2, 2, '#3f7a3c'); if (k % 2 === 0 && k < n) R(c, x, y - 2, 2, 2, '#5f9a52'); } R(c, s.x - 2, s.base - 2, 6, 2, '#2f5f30'); break; }
      case 'cafe': { for (let k = 0; k <= n; k++) { const [x, y] = pt(k); R(c, x, y, 2, 2, '#6a4a2a'); if (k > 2 && k % 2 === 0) { R(c, x - 6, y, 6, 4, '#2f5a34'); R(c, x + 2, y - 2, 6, 4, '#3a6a3c'); if (s.cut < .4 && (k + Math.round(s.tone * 4)) % 4 === 0) { R(c, x - 4, y + 2, 2, 2, '#d8343a'); R(c, x + 4, y + 2, 2, 2, '#c42a2a'); } } } break; }
      case 'cacto': { const x = s.x + s.a * 3, y = s.base; R(c, x - 6, y - 12, 14, 12, '#2f6a3a'); R(c, x - 4, y - 14, 10, 14, '#3f7a4a'); for (let k = -4; k <= 4; k += 4) R(c, x + k, y - 12, 2, 12, '#2a5a32'); R(c, x - 4, y - 18, 10, 4, '#c43c5a'); R(c, x - 2, y - 20, 6, 2, '#e86a7a'); for (let k = -6; k <= 6; k += 6) R(c, x + k, y - 8, 2, 2, '#f2efe6'); break; }
    }
  }
  function pot(c, x, w) { R(c, x - 4, FLOOR - 10, w + 8, 12, '#8a8478'); R(c, x - 4, FLOOR - 10, w + 8, 2, '#b4ae9e'); R(c, x - 2, FLOOR - 8, w + 4, 2, '#5a4232'); }
  const visible = (o) => o.scene >= 12 && !o.arena && !o.room;
  function drawBack(ctx, o) {
    if (!visible(o)) return; const S = get(o.scene); if (!S) return;
    const t = Number(o.time) || 0, dt = Math.max(0, Math.min(.05, t - lastT)); lastT = t; update(o, dt);
    ctx.save(); ctx.imageSmoothingEnabled = false;
    for (const [, x, w] of S.pots) if (x + w > o.camera - 40 && x < o.camera + 1000) pot(ctx, x, w);
    for (const s of S.stems) if (s.base < FLOOR && s.x > o.camera - 40 && s.x < o.camera + 1000) stem(ctx, s, t);
    ctx.restore();
  }
  function drawFront(ctx, o) {
    if (!visible(o)) return; const S = get(o.scene); if (!S) return;
    const t = Number(o.time) || 0;
    ctx.save(); ctx.imageSmoothingEnabled = false;
    for (const s of S.stems) if (s.base >= FLOOR && s.x > o.camera - 40 && s.x < o.camera + 1000) stem(ctx, s, t);
    for (const q of parts) { if (q.kind === 'texto') { ctx.globalAlpha = cl(q.life * 2); ctx.font = '12px Pixel, monospace'; ctx.textAlign = 'center'; ctx.fillStyle = '#2a1a14'; ctx.fillText(q.text, q.x + 2, q.y + 2); ctx.fillStyle = '#ffe2a0'; ctx.fillText(q.text, q.x, q.y); continue; }
      ctx.globalAlpha = cl(q.life * 1.5); R(ctx, q.x, q.y, q.kind === 'semente' ? 2 : 4, 2, q.col); if (q.kind === 'semente') R(ctx, q.x - 2, q.y - 2, 6, 2, 'rgba(244,242,234,.6)'); }
    ctx.restore();
  }
  window.CampanhaPlantas = Object.freeze({ drawBack, drawFront, canteiros: (scene) => (PATCHES[scene] || []).map((p) => p.slice()), stats: () => ({ particulas: parts.length }) });
})();
