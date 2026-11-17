/* Trigal da roça (fase 0): dois campos de trigo dourado no chão do mundo.
   - Os pés balançam com o vento (Weather.state().wind) em ondas que correm pelo campo.
   - Da Roça abre caminho ao andar: os pés tombam para os lados com física de mola,
     o trilho fica marcado por alguns segundos e volta devagar.
   - Fileira de trás desenhada antes do herói e fileira da frente depois (cobre as pernas).
   - Palha voa quando ele passa rápido, e há um "chhh" de mato (DarocaAudio 'mato').
   - Luz: lado do sol mais claro, contorno dourado no fim da tarde, escuro à noite,
     molhado na chuva e com neve por cima quando acumula.
   Só aparência: não mexe em colisão, inimigos, vida ou progresso. */
(() => {
  'use strict';
  if (window.Trigal) return;
  const SCENE = 0, FLOOR = 440;
  // trechos livres do chão: depois da casa (antes da ponte) e no fim da trilha
  const FIELDS = [[3714, 3996], [4506, 4772]];
  const hash = (i) => { const x = Math.sin(i * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const cl = (v, a = 0, b = 1) => Math.max(a, Math.min(b, v));
  let stalks = null, chaff = [], lastT = 0, stepAcc = 0, lastSound = 0;

  function build() {
    stalks = [[], []];
    let id = 0;
    for (const [a, b] of FIELDS) {
      for (const row of [0, 1]) {
        const gap = row ? 7 : 4.6;
        for (let x = a + 2; x < b - 2; x += gap) {
          const r = hash(++id), r2 = hash(id + 9000), edge = cl(Math.min(x - a, b - x) / 34);
          const h = (row ? 26 + r * 14 : 40 + r * 20) * (.55 + .45 * Math.sqrt(edge));
          stalks[row].push({ x: x + (r2 - .5) * gap * .8, base: row ? FLOOR + 4 + Math.round(r2 * 3) * 2 : FLOOR - 2 - Math.round(r * 3) * 2, h, ph: r * 6.28, tone: r2, a: 0, w: 0, flat: 0, dir: 0 });
        }
      }
    }
    for (const row of stalks) row.sort((p, q) => p.base - q.base || p.x - q.x);
  }

  // cores-base (RGB) multiplicadas pela luz do momento
  const BASE = {
    stemD: [150, 110, 46], stemL: [212, 170, 82], green: [150, 156, 70],
    ear: [228, 186, 92], earD: [178, 132, 56], grain: [248, 224, 142], awn: [238, 212, 150],
    stemB: [128, 92, 40], earB: [150, 110, 48], massTop: [186, 142, 60], massBot: [104, 74, 34]
  };
  let PAL = {};
  function palette(scene) {
    const s = window.DayTime?.state?.(), w = window.Weather?.state?.() || {}, sun = window.HdMaps?.sun?.() || { lean: 0, str: 1 };
    const selfLit = !!window.HdMaps?.handles?.(scene);
    const amb = selfLit && s ? s.amb : [1, 1, 1];
    const wet = cl(w.wet || 0), gold = s && s.sunT !== null ? cl(1 - Math.sin(s.sunT * Math.PI) * 1.7) * cl(sun.str * 1.5) : 0;
    const k = 1 - wet * .22;
    const mul = (c, boost = 0) => `rgb(${Math.round(cl(c[0] * amb[0] * k + boost * 40, 0, 255))},${Math.round(cl(c[1] * amb[1] * k + boost * 18, 0, 255))},${Math.round(cl(c[2] * amb[2] * k - boost * 8, 0, 255))})`;
    PAL = {};
    for (const n in BASE) PAL[n] = mul(BASE[n]);
    PAL.earHi = mul([255, 232, 160], gold);
    PAL.rim = `rgba(255,${Math.round(200 + 30 * (1 - gold))},${Math.round(120 + 60 * (1 - gold))},${(.25 + .55 * gold) * cl(sun.str) * (s ? 1 - s.night : 1)})`;
    PAL.lean = sun.lean; PAL.sunStr = cl(sun.str) * (s ? 1 - s.night : 1); PAL.gold = gold;
    PAL.snow = cl((w.cover || 0) * 1.4); PAL.wet = wet; PAL.wind = Number(w.wind) || .15; PAL.night = s ? s.night : 0;
    PAL.snowC = mul([248, 250, 255]);
  }

  function update(o, dt) {
    const p = o.player || {}, px = Number(p.x) || 0, py = Number(p.y) || FLOOR, vx = Number(p.vx) || 0, t = o.time;
    const wind = PAL.wind, inField = FIELDS.some(([a, b]) => px > a - 10 && px < b + 10);
    for (const row of stalks) for (const s of row) {
      if (Math.abs(s.x - (o.camera + 480)) > 620) continue;
      // vento: inclinação de base + rajadas que correm pelo campo
      const gust = Math.sin(t * 1.6 - s.x * .045 + s.ph * .3) * .5 + Math.sin(t * .7 - s.x * .012) * .5;
      let target = wind * (.18 + gust * .32) + Math.sin(t * 2.3 + s.ph) * .03 * (1 + wind) + PAL.wet * .12 * (s.tone - .5);
      // Da Roça abre caminho (só se os pés estiverem abaixo das espigas)
      const d = s.x - px, R = 17;
      if (Math.abs(d) < R + 6 && py > s.base - s.h * .85) {
        const f = cl(1 - Math.abs(d) / R), side = d > 1 ? 1 : d < -1 ? -1 : (vx >= 0 ? 1 : -1);
        if (f > 0) { target = side * (.55 + .7 * Math.sqrt(f)) + vx * .0011 * f; s.flat = Math.min(1, s.flat + dt * 3 * f); s.dir = side;
          if (Math.abs(vx) > 90 && Math.random() < dt * 9 * f) spawnChaff(s, vx); }
      } else s.flat = Math.max(0, s.flat - dt * .22);
      target += s.dir * s.flat * .45;
      const acc = (target - s.a) * 70 - s.w * 7;
      s.w += acc * dt; s.a = cl(s.a + s.w * dt, -1.35, 1.35);
    }
    // som de mato ao atravessar
    if (inField && Math.abs(vx) > 60 && py > FLOOR - 30) {
      stepAcc += Math.abs(vx) * dt;
      if (stepAcc > 42 && t - lastSound > .16) { stepAcc = 0; lastSound = t; try { window.DarocaAudio?.play?.('mato', { volume: .45 + Math.min(.5, Math.abs(vx) / 600) }); } catch (e) {} }
    } else stepAcc = Math.min(stepAcc, 30);
    // palha
    for (let i = chaff.length - 1; i >= 0; i--) { const c = chaff[i]; c.life -= dt; c.vy += 40 * dt; c.vx += (wind * 60 - c.vx) * dt * .8; c.x += c.vx * dt + Math.sin(t * 6 + c.ph) * 10 * dt; c.y += c.vy * dt; if (c.life <= 0 || c.y > FLOOR + 6) chaff.splice(i, 1); }
  }
  function spawnChaff(s, vx) {
    const max = Math.round(70 * (window.Graphics?.profile?.()?.particles ?? 1)); if (chaff.length >= max) return;
    const top = tip(s);
    chaff.push({ x: top[0], y: top[1], vx: vx * .25 + (Math.random() - .5) * 40, vy: -40 - Math.random() * 50, life: .9 + Math.random() * .9, ph: Math.random() * 6, c: Math.random() < .6 ? 'grain' : 'awn' });
  }
  const tip = (s) => [s.x + Math.sin(s.a) * s.h, s.base - Math.cos(s.a) * s.h];

  const px2 = (v) => Math.round(v / 2) * 2;
  // pé de trigo em "pixels de arte" (2x2)
  function stalk(c, s, lite, back) {
    const n = Math.max(6, Math.round(s.h / 2)), ear = Math.min(8, Math.round(n * .3)), ca = Math.cos(s.a * .9), lean = PAL.lean;
    const stem = s.tone < .15 ? PAL.green : back ? (s.tone > .7 ? PAL.stemD : PAL.stemB) : s.tone > .5 ? PAL.stemL : PAL.stemD;
    let prevX = null;
    for (let k = 0; k <= n; k++) {
      const u = k / n, off = Math.sin(s.a) * s.h * Math.pow(u, 1.7), x = px2(s.x + off), y = px2(s.base - k * 2 * ca);
      if (k < n - ear) { c.fillStyle = stem; c.fillRect(x, y, 2, 2); if (prevX !== null && Math.abs(x - prevX) > 2) c.fillRect(Math.min(x, prevX) + 2, y, Math.abs(x - prevX) - 2, 2); prevX = x; continue; }
      // espiga: haste central com grãos alternando de lado, curvada para o lado do tombo
      const j = k - (n - ear), ex = x + Math.round(s.a * 2 * (j / ear)) * 2, side = (j + (s.ph * 2 | 0)) % 2 ? -2 : 2;
      c.fillStyle = back ? PAL.earD : PAL.ear; c.fillRect(ex, y, 2, 2);
      if (j > 0 && j < ear) { c.fillStyle = j % 3 === 1 ? PAL.grain : (back ? PAL.earB : PAL.earD); c.fillRect(ex + side, y, 2, 2); }
      if (!lite && PAL.sunStr > .05 && j > 0 && (side > 0) === (lean < 0)) { c.fillStyle = PAL.rim; c.fillRect(ex + side, y, 2, 2); }
      if (k === n) {
        // barba (praganas) e neve no topo
        c.fillStyle = PAL.awn; const ax = ex + px2(Math.sin(s.a) * 4);
        if (!lite) { c.fillRect(ax, y - 2, 2, 2); if (!back) c.fillRect(ax + px2(Math.sin(s.a) * 2), y - 4, 2, 2); }
        if (PAL.snow > .08) { c.globalAlpha = PAL.snow; c.fillStyle = PAL.snowC; c.fillRect(ex - 2, y - 2, 4, 2); c.globalAlpha = 1; }
        if (PAL.gold > .15 && !lite) { c.fillStyle = PAL.earHi; c.fillRect(ex, y, 2, 2); }
      }
    }
  }
  // "corpo" do trigal atrás dos pés: dá densidade e escurece a base
  function mass(c, o) {
    for (const [a, b] of FIELDS) {
      if (b < o.camera - 40 || a > o.camera + 1000) continue;
      for (let x = px2(a); x < b; x += 2) {
        const edge = cl(Math.min(x - a, b - x) / 30), p = o.player || {}, d = Math.abs(x - (Number(p.x) || -999));
        const dip = (Number(p.y) || FLOOR) > FLOOR - 40 && d < 20 ? (1 - d / 20) * 14 : 0;
        const wave = Math.sin(o.time * 1.6 - x * .045) * 2 * PAL.wind;
        const h = Math.max(0, (22 + hash(x * .37) * 8) * Math.sqrt(edge) - dip + wave);
        if (h < 2) continue;
        const top = px2(FLOOR - h);
        c.fillStyle = PAL.massBot; c.fillRect(x, top, 2, FLOOR + 2 - top);
        c.fillStyle = PAL.massTop; c.fillRect(x, top, 2, Math.max(2, px2(h * .45)));
        if ((x / 2) % 3 === 0) { c.fillStyle = PAL.ear; c.fillRect(x, top - 2, 2, 2); }
        if (PAL.snow > .08) { c.globalAlpha = PAL.snow; c.fillStyle = PAL.snowC; c.fillRect(x, top - 2, 2, 2); c.globalAlpha = 1; }
      }
      // sombra de contato no chão
      c.fillStyle = `rgba(30,20,10,${.18 + .12 * (1 - PAL.night)})`; c.fillRect(px2(a), FLOOR, px2(b - a), 4);
    }
  }

  const visible = (o) => o.scene === SCENE && !o.arena && !o.room;
  const onScreen = (s, cam) => s.x > cam - 60 && s.x < cam + 1020;
  // ctx em coordenadas do mundo (câmera já aplicada)
  function drawBack(ctx, o) {
    if (!visible(o)) return;
    if (!FIELDS.some(([a, b]) => b > o.camera - 60 && a < o.camera + 1020)) return;
    if (!stalks) build();
    const t = Number(o.time) || 0, dt = Math.max(0, Math.min(.05, t - lastT)); lastT = t;
    palette(o.scene); update(o, dt);
    const lite = !!window.Graphics?.isLite?.();
    ctx.save(); ctx.imageSmoothingEnabled = false;
    mass(ctx, o);
    stalks[0].forEach((s, i) => { if ((!lite || i % 2 === 0) && onScreen(s, o.camera)) stalk(ctx, s, lite, true); });
    ctx.restore();
  }
  function drawFront(ctx, o) {
    if (!visible(o) || !stalks) return;
    if (!FIELDS.some(([a, b]) => b > o.camera - 60 && a < o.camera + 1020)) return;
    const lite = !!window.Graphics?.isLite?.();
    ctx.save(); ctx.imageSmoothingEnabled = false;
    stalks[1].forEach((s, i) => { if ((!lite || i % 2 === 0) && onScreen(s, o.camera)) stalk(ctx, s, lite); });
    for (const c of chaff) { ctx.globalAlpha = cl(c.life * 1.5); ctx.fillStyle = PAL[c.c]; ctx.fillRect(px2(c.x), px2(c.y), 2, 2); }
    ctx.restore();
  }
  window.Trigal = Object.freeze({ drawBack, drawFront, fields: () => FIELDS.map((f) => f.slice()), stats: () => ({ pes: stalks ? stalks[0].length + stalks[1].length : 0, palha: chaff.length }) });
})();
