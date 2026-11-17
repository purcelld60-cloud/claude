/* Clima: sol, chuva, neve, vento e poeira nas fases ao ar livre.
   Só aparência, desenhado por cima da cena em pixels de 2x2 (como o resto da arte):
   não muda física, tempos nem dificuldade. No AUTOMÁTICO o tempo muda sozinho a cada
   poucos minutos (neve só quando escolhida). Em qualidade BAIXA o clima fica desligado.
   Escolha salva no aparelho: 'daroca-weather-v1'. */
(() => {
  'use strict';
  if (window.Weather) return;
  const KEY = 'daroca-weather-v1', FLOOR = 440;
  const MODES = [
    { id: 'auto', label: 'AUTOMÁTICO', text: 'O tempo muda sozinho: sol, vento, chuva e poeira.' },
    { id: 'sol', label: 'SOL', text: 'Céu limpo o tempo todo.' },
    { id: 'chuva', label: 'CHUVA', text: 'Chuva com respingos, poças e trovões.' },
    { id: 'neve', label: 'NEVE', text: 'Uma frente fria impossível: neve na Bahia.' },
    { id: 'vento', label: 'VENTO', text: 'Rajadas com folhas e poeira voando.' }
  ];
  const OUTDOOR = [0, 1, 3, 4, 5, 7, 9], DUSTY = { 3: 1, 5: 1, 7: 1 };
  let mode = 'auto'; try { const v = localStorage.getItem(KEY); if (MODES.some((m) => m.id === v)) mode = v; } catch (e) {}
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  // estado suavizado (0..1) de cada fenômeno
  const st = { rain: 0, snow: 0, wind: 0, dust: 0, cover: 0, flash: 0, wet: 0 };
  // chão: poças que crescem com a chuva, pegadas na neve e respingos do jogador
  let prints = [], bits = [], rings = [], lastStepX = null, prevGround = true, lastSplash = 0, printScene = -1;
  let target = { rain: 0, snow: 0, wind: .2, dust: 0 }, nextChange = 0, lastT = 0, splashes = [], seedAuto = Math.floor(Math.random() * 1000);
  function pickAuto(t, scene) {
    const r = hash(seedAuto + Math.floor(t / 150));
    if (r < .55) return { rain: 0, snow: 0, wind: .15 + hash(seedAuto + 3) * .2, dust: DUSTY[scene] ? .3 : 0 };
    if (r < .72) return { rain: 0, snow: 0, wind: .9, dust: DUSTY[scene] ? .9 : .3 };
    if (r < .92) return { rain: .55 + hash(seedAuto + Math.floor(t / 150) + 9) * .45, snow: 0, wind: .35, dust: 0 };
    return { rain: 0, snow: 0, wind: .5, dust: DUSTY[scene] ? .6 : .1 };
  }
  function update(t, scene) {
    const dt = Math.max(0, Math.min(.1, t - lastT)); lastT = t;
    if (mode === 'auto') target = pickAuto(t, scene);
    else if (mode === 'sol') target = { rain: 0, snow: 0, wind: .1, dust: 0 };
    else if (mode === 'chuva') target = { rain: 1, snow: 0, wind: .4, dust: 0 };
    else if (mode === 'neve') target = { rain: 0, snow: 1, wind: .25, dust: 0 };
    else target = { rain: 0, snow: 0, wind: 1, dust: DUSTY[scene] ? 1 : .4 };
    for (const k of ['rain', 'snow', 'wind', 'dust']) st[k] += (target[k] - st[k]) * Math.min(1, dt * .35);
    st.cover = Math.max(0, Math.min(1, st.cover + (st.snow > .5 ? dt * .035 : -dt * .03)));
    st.flash = Math.max(0, st.flash - dt * 3);
    st.wet = Math.max(0, Math.min(1, st.wet + (st.rain > .15 ? dt * .07 * st.rain : -dt * .012)));
    if (st.rain > .7 && hash(Math.floor(t * 2) + 77) > .996) st.flash = 1;
  }
  const P = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, w, h); };
  // c em coordenadas de tela (960x540); camera para o parallax das partículas
  function draw(c, o) {
    const prof = window.Graphics?.profile?.() || { particles: 1, weather: true }, scene = Number(o.scene), t = Number(o.time) || 0;
    if (!prof.weather || !OUTDOOR.includes(scene) || !o.outdoor) { lastT = t; return; }
    update(t, scene);
    const k = prof.particles, cam = Number(o.camera) || 0, wind = st.wind * (Math.sin(t * .3) * .3 + .7), lean = .25 + wind * .55;
    c.save();
    // chuva: escurece, faz faixas inclinadas, respingos e poças brilhando no chão
    if (st.rain > .02) {
      { const g = c.createLinearGradient(0, 0, 0, 330); g.addColorStop(0, `rgba(70,78,96,${st.rain * .8})`); g.addColorStop(1, `rgba(70,78,96,${st.rain * .25})`); c.fillStyle = g; c.fillRect(0, 0, 960, 330); for (let i = 0; i < 7; i++) { const x = ((i * 190 + t * 9 - cam * .05) % 1300) - 170, y = 20 + (i % 3) * 34; c.fillStyle = `rgba(52,58,74,${st.rain * .6})`; c.fillRect(Math.round(x / 2) * 2, y, 220, 18); c.fillRect(Math.round(x / 2) * 2 + 30, y - 10, 140, 10); c.fillStyle = `rgba(96,104,124,${st.rain * .5})`; c.fillRect(Math.round(x / 2) * 2 + 30, y - 10, 140, 2); } }
      c.fillStyle = `rgba(40,52,80,${st.rain * .2})`; c.fillRect(0, 0, 960, 540);
      const n = Math.round(260 * st.rain * k);
      for (let i = 0; i < n; i++) { const sp = 700 + hash(i) * 300, y = ((hash(i + 3) * 540 + t * sp) % 600) - 60, x = ((hash(i + 7) * 1100 - cam * .2 + y * lean) % 1000 + 1000) % 1000 - 20; c.fillStyle = i % 3 ? 'rgba(200,218,245,.6)' : 'rgba(235,242,255,.85)'; for (let s2 = 0; s2 < 6; s2++) c.fillRect(Math.round((x - s2 * lean * 4) / 2) * 2, Math.round((y - s2 * 4) / 2) * 2, 2, 4); }
      if (hash(Math.floor(t * 30)) < st.rain * k) for (let j = 0; j < 3; j++) splashes.push({ x: Math.random() * 960, t0: t });
      splashes = splashes.filter((s2) => t - s2.t0 < .25);
      for (const s2 of splashes) { const u = (t - s2.t0) / .25, a = 1 - u; P(c, s2.x - 4 - u * 6, FLOOR - 2 - u * 4, 2, 2, `rgba(220,235,255,${a})`); P(c, s2.x + 4 + u * 6, FLOOR - 2 - u * 4, 2, 2, `rgba(220,235,255,${a})`); P(c, s2.x, FLOOR - 4 - u * 8, 2, 2, `rgba(220,235,255,${a})`); }
      for (let i = 0; i < 9; i++) { const x = ((hash(i + 40) * 1400 - cam) % 1400 + 1400) % 1400 - 200, w = 40 + hash(i + 41) * 60, sh = Math.sin(t * 3 + i) * .5 + .5; c.fillStyle = `rgba(200,220,255,${st.rain * (.18 + sh * .12)})`; c.fillRect(Math.round(x / 2) * 2, FLOOR + 6 + (i % 3) * 6, Math.round(w / 2) * 2, 2); }
      if (st.flash > 0) { c.fillStyle = `rgba(230,240,255,${st.flash * .35})`; c.fillRect(0, 0, 960, 540); }
    }
    // neve: flocos que balançam, chão branqueando aos poucos
    if (st.snow > .02) {
      { const g = c.createLinearGradient(0, 0, 0, 330); g.addColorStop(0, `rgba(190,200,220,${st.snow * .6})`); g.addColorStop(1, `rgba(190,200,220,${st.snow * .15})`); c.fillStyle = g; c.fillRect(0, 0, 960, 330); }
      c.fillStyle = `rgba(200,215,240,${st.snow * .12})`; c.fillRect(0, 0, 960, 540);
      const n = Math.round(200 * st.snow * k);
      for (let i = 0; i < n; i++) { const sp = 40 + hash(i) * 60, y = ((hash(i + 3) * 540 + t * sp) % 580) - 20, x = ((hash(i + 7) * 1100 - cam * (.15 + hash(i) * .3) + Math.sin(t * 1.3 + i) * 14 + t * wind * 50) % 1000 + 1000) % 1000 - 20, big = hash(i + 11) > .6; P(c, x + 2, y + 2, big ? 6 : 4, big ? 6 : 4, 'rgba(110,130,170,.35)'); P(c, x, y, big ? 6 : 4, big ? 6 : 4, '#ffffff'); }
    }
    if (st.cover > .01) { const a = Math.min(1, st.cover * 1.4); for (let x = 0; x < 960; x += 2) { const h = 2 + Math.round((Math.sin((x + cam) * .05) + Math.sin((x + cam) * .13)) * 1.2 + 2.6) * 3 * st.cover; c.fillStyle = `rgba(245,250,255,${a})`; c.fillRect(x, FLOOR - h + 2, 2, h); } }
    // vento: riscos de ar e folhas voando
    if (st.wind > .3) { const n = Math.round(24 * (st.wind - .3) * k); for (let i = 0; i < n; i++) { const y = 60 + hash(i + 5) * 380, x = ((hash(i + 9) * 1200 + t * (500 + hash(i) * 300)) % 1300) - 150, len = 30 + hash(i + 2) * 60; c.fillStyle = `rgba(255,255,255,${.12 + hash(i + 4) * .1})`; c.fillRect(Math.round(x / 2) * 2, Math.round((y + Math.sin(t * 2 + i) * 6) / 2) * 2, Math.round(len / 2) * 2, 2); }
      const leaves = Math.round(18 * st.wind * k); for (let i = 0; i < leaves; i++) { const x = ((hash(i + 21) * 1200 + t * (260 + hash(i) * 200)) % 1300) - 150, y = 120 + hash(i + 22) * 300 + Math.sin(t * 3 + i * 2) * 26, col = ['#6aa850', '#c9a24a', '#a8c060', '#d8783a'][i % 4]; P(c, x, y, 4, 2, col); P(c, x + 2, y - 2, 2, 2, col); } }
    // poeira: nuvem baixa e grãos rolando perto do chão
    if (st.dust > .05) { const g = c.createLinearGradient(0, 300, 0, FLOOR); g.addColorStop(0, 'rgba(214,190,150,0)'); g.addColorStop(1, `rgba(214,190,150,${st.dust * .22})`); c.fillStyle = g; c.fillRect(0, 300, 960, FLOOR - 300);
      const n = Math.round(80 * st.dust * k); for (let i = 0; i < n; i++) { const x = ((hash(i + 61) * 1200 + t * (120 + hash(i) * 260) * (.4 + st.wind)) % 1260) - 150, y = FLOOR - 4 - hash(i + 62) * 120 + Math.sin(t * 2 + i) * 8; P(c, x, y, 2, 2, `rgba(226,204,160,${.35 + hash(i + 63) * .4})`); } }
    ground(c, o, t, cam, k);
    c.restore();
  }
  function ground(c, o, t, cam, k) {
    const pl = o.player, dt = Math.max(0, Math.min(.1, t - (ground.lt || t))); ground.lt = t;
    if (o.scene !== printScene) { prints = []; bits = []; rings = []; printScene = o.scene; lastStepX = null; }
    // neblina baixa da chuva
    if (st.rain > .1) { const g = c.createLinearGradient(0, 340, 0, 470); g.addColorStop(0, 'rgba(200,212,228,0)'); g.addColorStop(.6, `rgba(200,212,228,${.2 * st.rain})`); g.addColorStop(1, `rgba(200,212,228,${.1 * st.rain})`); c.fillStyle = g; c.fillRect(0, 340, 960, 130);
      for (let i = 0; i < 6; i++) { const x = ((hash(i + 140) * 1400 + t * (10 + hash(i) * 14) - cam * .6) % 1400 + 1400) % 1400 - 220, y = 400 + hash(i + 141) * 50, w = 160 + hash(i + 142) * 200; c.fillStyle = `rgba(220,228,240,${.08 * st.rain})`; for (let r = 0; r < 4; r++) c.fillRect(Math.round((x + r * 14) / 2) * 2, Math.round((y - r * 4) / 2) * 2, Math.round((w - r * 28) / 2) * 2, 4); } }
    // poças crescendo
    if (st.wet > .04) { const a = Math.min(1, st.wet * 1.4);
      for (let i = 0; i < 40; i++) { const wx = 160 + i * 240 + hash(i + 170) * 120, w = (44 + hash(i + 171) * 70) * a, x = wx - cam; if (x < -120 || x > 1080) continue;
        c.fillStyle = `rgba(38,52,80,${.45 * a})`; c.fillRect(Math.round((x - w / 2) / 2) * 2, FLOOR + 4, Math.round(w / 2) * 2, 4); c.fillRect(Math.round((x - w / 2 + 6) / 2) * 2, FLOOR + 2, Math.round((w - 12) / 2) * 2, 2); c.fillRect(Math.round((x - w / 2 + 6) / 2) * 2, FLOOR + 8, Math.round((w - 12) / 2) * 2, 2);
        c.fillStyle = `rgba(190,210,240,${.35 * a})`; c.fillRect(Math.round((x - w / 3) / 2) * 2, FLOOR + 4, Math.round(w / 4 / 2) * 2, 2); c.fillRect(Math.round((x + w / 12) / 2) * 2, FLOOR + 6, Math.round(w / 6 / 2) * 2, 2);
        if (st.rain > .2 && Math.random() < .25 * st.rain * k) rings.push({ x: wx + (Math.random() - .5) * w * .8, t0: t });
        if (pl && pl.ground && Math.abs(pl.y - FLOOR) < 3 && Math.abs(pl.x - wx) < w / 2 && Math.abs(pl.vx) > 40 && t - lastSplash > .18) { lastSplash = t; for (let j = 0; j < 7; j++) bits.push({ x: pl.x + (Math.random() - .5) * 10, y: FLOOR + 2, vx: (Math.random() - .5) * 120 + pl.vx * .2, vy: -60 - Math.random() * 110, life: .45, col: 'rgba(200,220,255,.9)' }); try { window.DarocaAudio?.play?.('agua', { volume: .6 }); } catch (e) {} } } }
    rings = rings.filter((r) => t - r.t0 < .5); for (const r of rings) { const u = (t - r.t0) / .5, x = r.x - cam, rw = 4 + u * 14; c.fillStyle = `rgba(210,225,255,${.5 * (1 - u)})`; c.fillRect(Math.round((x - rw) / 2) * 2, FLOOR + 4, 2, 2); c.fillRect(Math.round((x + rw) / 2) * 2, FLOOR + 4, 2, 2); c.fillRect(Math.round((x - rw * .6) / 2) * 2, FLOOR + 2, Math.round(rw * 1.2 / 2) * 2, 2); }
    // pegadas e neve levantando
    if (pl && st.cover > .15) {
      const onFloor = pl.ground && Math.abs(pl.y - FLOOR) < 3;
      if (onFloor) { if (lastStepX === null) lastStepX = pl.x; if (Math.abs(pl.x - lastStepX) > 15) { lastStepX = pl.x; prints.push({ x: pl.x, side: prints.length % 2 ? 1 : -1, t0: t }); if (prints.length > 80) prints.shift(); if (Math.random() < .5) bits.push({ x: pl.x - Math.sign(pl.vx) * 8, y: FLOOR - 2, vx: -pl.vx * .15 + (Math.random() - .5) * 30, vy: -40 - Math.random() * 40, life: .5, col: '#ffffff' }); } }
      else lastStepX = null;
      if (onFloor && !prevGround) for (let j = 0; j < 12; j++) bits.push({ x: pl.x + (Math.random() - .5) * 26, y: FLOOR - 2, vx: (Math.random() - .5) * 140, vy: -50 - Math.random() * 90, life: .6, col: '#ffffff' });
      prevGround = pl.ground;
      const refill = 18 / (.4 + st.snow);
      prints = prints.filter((f) => t - f.t0 < refill);
      for (const f of prints) { const x = f.x + f.side * 4 - cam; if (x < -10 || x > 970) continue; const a = (1 - (t - f.t0) / refill) * Math.min(1, st.cover * 1.5); c.fillStyle = `rgba(92,112,155,${.75 * a})`; c.fillRect(Math.round((x - 4) / 2) * 2, FLOOR - 2, 8, 2); c.fillRect(Math.round((x - 3) / 2) * 2, FLOOR - 4, 6, 2); c.fillStyle = `rgba(140,160,200,${.5 * a})`; c.fillRect(Math.round((x - 4) / 2) * 2, FLOOR - 6, 8, 2); }
    } else if (pl) prevGround = pl.ground;
    for (const b of bits) { b.life -= dt; b.x += b.vx * dt; b.y += b.vy * dt; b.vy += 420 * dt; if (b.life > 0) P(c, b.x - cam, b.y, 2, 2, b.col); }
    bits = bits.filter((b) => b.life > 0 && b.y < FLOOR + 12);
  }
  function next() { const i = MODES.findIndex((m) => m.id === mode); mode = MODES[(i + 1) % MODES.length].id; try { localStorage.setItem(KEY, mode); } catch (e) {} return mode; }
  const cur = () => MODES.find((m) => m.id === mode) || MODES[0];
  window.Weather = Object.freeze({ draw: (c, o) => { try { draw(c, o || {}); } catch (e) {} }, state: () => ({ ...st }), next, mode: () => mode, label: () => cur().label, describe: () => cur().text, set: (m) => { if (MODES.some((x) => x.id === m)) { mode = m; try { localStorage.setItem(KEY, mode); } catch (e) {} } } });
})();
