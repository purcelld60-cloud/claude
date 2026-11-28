/* Roteiros: cutscenes escritas em arquivos de dados (dist/roteiros/*.json), sem mexer em código.
   Cada roteiro tem cenas (planos). Em cada cena dá para escolher o cenário, a hora do dia, a câmera
   (posição e zoom com movimento), os atores (onde ficam, para onde andam, se pulam), as falas
   (com retrato de quem fala), efeitos de tela e sons. O guia completo está em docs/ROTEIROS.md.

   Como entra no jogo:
   - "antes": "intro" toca este roteiro logo antes da cena "intro" do jogo; "depois" toca logo depois.
   - "chegada": 4 toca quando o jogador chega de carro à fase 4 pela primeira vez.
   - "uma_vez": true faz o roteiro tocar só uma vez por save (fica marcado em q.roteiros).
   Por fora do jogo: abra o site com ?roteiro=<id> para ver um roteiro sozinho (Esc fecha).

   O motor se encaixa no sistema que já existe (window.Cinematics): os mesmos botões CONTINUAR e
   Pular história, a mesma caixa de fala e o mesmo relógio contínuo da música. Nada aqui muda
   vida, dano, progresso ou controles. Erros de roteiro aparecem no console e em
   window.__roteiroErrors, e o roteiro com problema é ignorado sem travar o jogo. */
(() => {
  'use strict';
  if (window.Roteiro) return;
  const W = 960, H = 540, FLOOR = 440, BASE = 'roteiros/';
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const ease = (k) => { k = clamp(k, 0, 1); return k * k * (3 - 2 * k); };
  const lerp = (a, b, k) => a + (b - a) * k;
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const errors = window.__roteiroErrors = [];
  const warn = (where, msg) => { const m = 'Roteiro ' + where + ': ' + msg; errors.push(m); try { console.warn(m); } catch (e) {} };

  const SCENES = { roca: 0, escola: 1, academia: 2, quadra: 3, praca: 4, favela: 5, caderno: 6, tinta: 6, campo: 7, bigodon: 8, patio: 9, rayssa: 10, baile: 11 };
  const OUTDOOR = [0, 1, 3, 4, 5, 7, 9];
  const NAMES = {
    daroca: 'Da Roça', lucas: 'Lucas · o Sapo', nikolas: 'Nikolas Arroganti', reeis: 'Reeis', reeisBoss: 'Reeis', menezes: 'Menezes', caleb: 'Caleb', kaua: 'Kaua',
    marco: 'Marco', ravid: 'Ravid', mota: 'Gabriel Mota', almiro: 'Professor Almiro', miqueias: 'Professor Miqueias', davi: 'Davi Costa', vitor: 'Vitor',
    freddy: 'Freddy', nicolas: 'Nicolas Carvalho', dede: 'Dedé', aica: 'Aica', ravile: 'Ravile', arthur: 'Arthur', allef: 'Allef', eloisa: 'Eloisa',
    giselle: 'Giselle', rayssa: 'Rayssa', analaura: 'Ana Laura', igor: 'Igor', kaique: 'Kaique', ollyan: 'Ollyan', giant: 'Colosso Six Seven', narrador: 'Narrador'
  };
  // Extensões (a Campanha 2 usa): mais cenários e nomes, fundos pintados, efeitos, animações extras, sons e ganchos por quadro.
  const EXT = { cenarios: {}, nomes: {}, fundos: {}, efeitos: {}, anims: {}, sons: {}, ganchos: [] };
  function estender(o = {}) { for (const k of ['cenarios', 'nomes', 'fundos', 'efeitos', 'anims', 'sons']) if (o[k] && typeof o[k] === 'object') Object.assign(EXT[k], o[k]); if (o.gancho) EXT.ganchos.push(o.gancho); }
  const sceneOk = (n) => Number.isInteger(n) && n >= 0 && (n <= 11 || (n <= 99 && (window.CampanhaCenarios?.largura?.(n) > 0 || window.CampanhaCenarios?.layout?.(n))));
  const bgName = (bg) => (bg && typeof bg === 'object' ? String(bg.nome || '') : bg ? String(bg) : '');
  const scripts = Object.create(null);
  let ready = false;

  /* ---------- leitura e conferência dos arquivos ---------- */
  const num = (v, d) => (Number.isFinite(Number(v)) && v !== null && v !== '' ? Number(v) : d);
  function camPoint(p, prev) {
    p = p || {};
    return { x: num(p.x, prev?.x ?? 480), y: num(p.y, prev?.y ?? 380), zoom: clamp(num(p.zoom, prev?.zoom ?? 1), .5, 4) };
  }
  function normalize(raw, file) {
    if (!raw || typeof raw !== 'object') throw new Error('o arquivo não é um objeto JSON');
    const id = String(raw.id || '').trim();
    if (!/^[a-z0-9_]+$/.test(id)) throw new Error('"id" precisa ter só letras minúsculas, números e _ (ex.: "chegada_praca")');
    if (!Array.isArray(raw.cenas) || !raw.cenas.length) throw new Error('falta a lista "cenas"');
    const beats = [], shots = [];
    raw.cenas.forEach((c, i) => {
      if (!c || typeof c !== 'object') throw new Error('a cena ' + (i + 1) + ' não é um objeto');
      let scene = c.cenario ?? shots[i - 1]?.scene ?? 0;
      if (typeof scene === 'string') { const key = scene.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); scene = SCENES[key] ?? EXT.cenarios[key] ?? Number(scene); }
      const pintado = !!EXT.fundos[bgName(c.fundo)];
      if (!pintado && !sceneOk(scene)) throw new Error('cena ' + (i + 1) + ': "cenario" inválido (use 0 a 11, um nome como "praca" ou uma fase da Campanha 2)');
      if (pintado && !sceneOk(scene)) scene = 0;
      const cam = c.camera || {}, from = camPoint(cam.de || cam, shots[i - 1]?.camTo), to = camPoint(cam.para || cam.de || cam, from);
      const actors = (Array.isArray(c.atores) ? c.atores : []).map((a, k) => {
        const type = String(a.quem || a.tipo || '');
        if (!type) throw new Error('cena ' + (i + 1) + ': ator ' + (k + 1) + ' sem "quem"');
        const t = Array.isArray(a.tempo) ? a.tempo : [0, 2.5];
        return { type, x: num(a.x, 480), y: num(a.y, FLOOR), to: a.ate !== undefined ? num(a.ate, null) : null, t0: num(t[0], 0), t1: Math.max(num(t[0], 0) + .05, num(t[1], 2.5)),
          facing: a.olhando === undefined ? null : (Number(a.olhando) < 0 || a.olhando === 'esquerda' ? -1 : 1), scale: clamp(num(a.escala, 1), .2, 6), emotion: a.emocao || undefined,
          jump: num(a.pulo, 0), anim: String(a.anim || ''), appear: num(a.aparece, -1), vanish: num(a.some, Infinity), z: num(a.camada, 0), opts: a.opcoes && typeof a.opcoes === 'object' ? a.opcoes : {} };
      });
      const fx = (Array.isArray(c.efeitos) ? c.efeitos : []).map((e) => (typeof e === 'string' ? { tipo: e } : { ...e })).filter((e) => e.tipo);
      const sounds = (Array.isArray(c.sons) ? c.sons : []).map((s) => (typeof s === 'string' ? { som: s, t: 0 } : { som: s.som, t: num(s.t, 0) })).filter((s) => s.som);
      const shot = Object.freeze({ index: i, scene, title: String(c.titulo || raw.titulo || ''), hour: c.hora === undefined ? null : num(c.hora, null), hourTo: c.hora_ate === undefined ? null : num(c.hora_ate, null), camFrom: from, camTo: to,
        camTime: Math.max(.1, num(cam.tempo, num(c.duracao, 4))), camCurve: cam.curva === 'linear' ? 'linear' : 'suave', duration: Math.max(.3, num(c.duracao, 3.5)), actors, fx, sounds,
        bg: c.fundo || null, raw: c });
      shots.push(shot);
      const lines = Array.isArray(c.falas) ? c.falas : [];
      if (!lines.length) beats.push({ shot: i, title: shot.title, speaker: '', who: '', text: '', duration: shot.duration, first: true });
      lines.forEach((f, k) => {
        if (!f || typeof f !== 'object') throw new Error('cena ' + (i + 1) + ': fala ' + (k + 1) + ' não é um objeto');
        const who = String(f.quem || 'narrador'), text = String(f.texto || '');
        if (!text) throw new Error('cena ' + (i + 1) + ': fala ' + (k + 1) + ' sem "texto"');
        beats.push({ shot: i, title: String(f.titulo || shot.title), who, speaker: String(f.nome || NAMES[who] || EXT.nomes[who] || who), text, portrait: f.retrato !== false && who !== 'narrador' && who !== 'nenhum',
          emotion: f.emocao, duration: num(f.duracao, Math.round(clamp(text.length / 19 + 1.35, 3, 9) * 100) / 100), first: k === 0 });
      });
    });
    let start = 0;
    for (const b of beats) { b.start = start; start += b.duration; }
    const music = Array.isArray(raw.musica) ? raw.musica.map(String) : raw.musica ? [String(raw.musica)] : [];
    return Object.freeze({ id, file, raw, title: String(raw.titulo || id), before: raw.antes ? String(raw.antes) : null, after: raw.depois ? String(raw.depois) : null,
      arrival: raw.chegada === undefined ? null : Number(raw.chegada), balao: !!raw.balao, once: !!raw.uma_vez, replace: !!raw.substituir, auto: !!raw.automatico, music,
      shots: Object.freeze(shots), beats: Object.freeze(beats.map((b) => Object.freeze(b))), duration: Math.round(start * 100) / 100 });
  }
  function register(raw, file) {
    try {
      const s = normalize(raw, file);
      const builtin = window.Cinematics?.metadata && Object.prototype.hasOwnProperty.call(window.Cinematics.metadata, s.id);
      if (builtin && !s.replace) { warn(file, 'o id "' + s.id + '" já é uma cena do jogo. Use outro id ou "substituir": true.'); return null; }
      scripts[s.id] = s;
      try { if (window.Cinematics?.metadata) window.Cinematics.metadata[s.id] = s.beats.map((b) => ({ title: b.title, speaker: b.speaker, text: b.text })); } catch (e) {}
      return s;
    } catch (e) { warn(file, e.message); return null; }
  }
  async function load() {
    try {
      const res = await fetch(BASE + 'lista.json', { cache: 'no-cache' });
      if (!res.ok) throw new Error('lista.json não encontrada');
      const list = await res.json(), files = Array.isArray(list) ? list : list.roteiros || [];
      await Promise.all(files.map(async (f) => {
        try { const r = await fetch(BASE + f, { cache: 'no-cache' }); if (!r.ok) throw new Error('arquivo não encontrado'); register(await r.json(), f); }
        catch (e) { warn(f, e.message.includes('JSON') ? 'JSON com erro de digitação (vírgula ou aspas faltando?)' : e.message); }
      }));
    } catch (e) { warn('lista.json', e.message); }
    ready = true;
    try { window.dispatchEvent(new CustomEvent('roteiros-prontos', { detail: { ids: Object.keys(scripts) } })); } catch (e) {}
  }

  /* ---------- sons sintetizados (sem arquivos) ---------- */
  let actx = null;
  function sfx(name) {
    if (window.Game?.soundOn && !window.Game.soundOn() && !window.__somCutscene) return;
    try {
      actx = actx || new (window.AudioContext || window.webkitAudioContext)(); if (actx.state === 'suspended') actx.resume();
      const now = actx.currentTime, out = actx.createGain(); out.gain.value = .05 * (window.DarocaAudio?.sfx?.() ?? 1); out.connect(actx.destination);
      const tone = (f, f2, d, type = 'square', at = 0, vol = 1) => { const o = actx.createOscillator(), g = actx.createGain(); o.type = type; o.frequency.setValueAtTime(f, now + at); if (f2) o.frequency.exponentialRampToValueAtTime(Math.max(30, f2), now + at + d); g.gain.setValueAtTime(vol, now + at); g.gain.exponentialRampToValueAtTime(.001, now + at + d); o.connect(g); g.connect(out); o.start(now + at); o.stop(now + at + d + .02); };
      const noise = (d, vol = 1, at = 0, hp = 0) => { const len = Math.floor(actx.sampleRate * d), buf = actx.createBuffer(1, len, actx.sampleRate), ch = buf.getChannelData(0); for (let i = 0; i < len; i++) ch[i] = (Math.random() * 2 - 1) * (1 - i / len); const src = actx.createBufferSource(), g = actx.createGain(); src.buffer = buf; g.gain.value = vol; let node = src; if (hp) { const f = actx.createBiquadFilter(); f.type = 'highpass'; f.frequency.value = hp; src.connect(f); node = f; } node.connect(g); g.connect(out); src.start(now + at); };
      switch (name) {
        case 'sino': tone(880, 870, 1.2, 'sine'); tone(1320, 1300, .9, 'sine', 0, .5); break;
        case 'plim': tone(1046, 1040, .25, 'square'); tone(1568, 1560, .35, 'square', .08); break;
        case 'impacto': tone(140, 40, .35, 'square'); noise(.25, .8); break;
        case 'whoosh': noise(.45, .7, 0, 900); break;
        case 'passos': for (let i = 0; i < 4; i++) noise(.05, .6, i * .22, 300); break;
        case 'trovao': noise(1.6, 1.2); tone(60, 30, 1.4, 'sawtooth', 0, .6); break;
        case 'buzina': tone(392, 392, .18, 'sawtooth'); tone(392, 392, .3, 'sawtooth', .24); break;
        case 'galo': tone(520, 900, .18, 'sawtooth'); tone(900, 700, .25, 'sawtooth', .2); tone(760, 420, .5, 'sawtooth', .46); break;
        case 'tambor': tone(110, 50, .3, 'sine', 0, 1.4); tone(110, 50, .3, 'sine', .3, 1.4); tone(160, 60, .4, 'sine', .55, 1.6); break;
        case 'fanfarra': [523, 659, 784, 1046].forEach((f, i) => tone(f, f, .3, 'square', i * .14)); break;
        case 'misterio': tone(220, 200, 1.2, 'triangle'); tone(233, 210, 1.2, 'triangle', .1); break;
        case 'risada': for (let i = 0; i < 4; i++) tone(500 - i * 40, 420 - i * 40, .1, 'square', i * .13); break;
        default: if (EXT.sons[name]) EXT.sons[name]({ tone, noise, actx, out, now }); else tone(660, 600, .15, 'square');
      }
    } catch (e) {}
  }

  /* ---------- retratos (rosto recortado do próprio desenho do personagem) ---------- */
  const headCache = {};
  function headBox(type) {
    if (headCache[type]) return headCache[type];
    const c = document.createElement('canvas'); c.width = 200; c.height = 240; const x = c.getContext('2d');
    let box = { top: 150, cx: 100 };
    try {
      window.Art.drawCharacter(x, type, 100, 220, { facing: 1, frame: 0, scale: 1, grounded: true });
      const d = x.getImageData(0, 0, 200, 240).data;
      outer: for (let y = 0; y < 240; y++) for (let i = 0; i < 200; i++) if (d[(y * 200 + i) * 4 + 3] > 220) { box.top = y; break outer; }
      let sx = 0, n = 0; for (let y = box.top; y < box.top + 14 && y < 240; y++) for (let i = 0; i < 200; i++) if (d[(y * 200 + i) * 4 + 3] > 220) { sx += i; n++; }
      if (n) box.cx = sx / n;
    } catch (e) {}
    return (headCache[type] = box);
  }
  function drawPortrait(c, type, size, t, emotion) {
    c.save(); c.imageSmoothingEnabled = false; c.clearRect(0, 0, size, size);
    const g = c.createLinearGradient(0, 0, 0, size); g.addColorStop(0, '#f3d79a'); g.addColorStop(1, '#c98f52'); c.fillStyle = g; c.fillRect(0, 0, size, size);
    c.fillStyle = '#e6b878'; for (let y = 0; y < size; y += 4) for (let x = (y / 4) % 2 ? 2 : 0; x < size; x += 4) c.fillRect(x, y, 2, 2);
    if (window.Art?.drawCharacter && type && type !== 'narrador') {
      const b = headBox(type), S = size / 40, tall = (220 - b.top) > 110;
      window.Art.drawCharacter(c, type, Math.round(size / 2 - (b.cx - 100) * S), Math.round(size * (tall ? .02 : .06) + (220 - b.top) * S), { facing: 1, frame: t, scale: S, grounded: true, emotion });
    }
    c.restore();
  }

  /* ---------- estado e relógio ---------- */
  const has = (id) => !!scripts[id];
  function create(id, options = {}) { return { kind: id, roteiro: true, index: 0, time: 0, shotTime: 0, elapsed: 0, typed: 0, fired: {}, done: false, options: { ...options } }; }
  const beatOf = (s) => scripts[s.kind].beats[clamp(s.index | 0, 0, scripts[s.kind].beats.length - 1)];
  function next(s) {
    const sc = scripts[s.kind], prev = beatOf(s);
    if (s.index + 1 >= sc.beats.length) { s.done = true; release(); return false; }
    s.index++; s.time = 0; s.typed = 0;
    if (beatOf(s).shot !== prev.shot) { s.shotTime = 0; s.fired = {}; }
    return true;
  }
  function update(s, dt) {
    if (!s || s.done) return;
    dt = clamp(Number(dt) || 0, 0, .1);
    const sc = scripts[s.kind], b = beatOf(s), shot = sc.shots[b.shot];
    s.time += dt; s.shotTime += dt; s.elapsed += dt; s.typed += dt * 48;
    for (const snd of shot.sounds) { const key = snd.som + '@' + snd.t; if (!s.fired[key] && s.shotTime >= snd.t) { s.fired[key] = 1; sfx(snd.som); } }
    const auto = !b.text || s.options.musicTimed || sc.auto || s.options.auto;
    if (auto && s.time >= b.duration) next(s);
  }
  function advance(s) {
    if (!s || s.done) return false;
    const b = beatOf(s);
    if (b.text && s.typed < b.text.length) { s.typed = 1e9; return true; }
    return next(s);
  }
  function beat(s) {
    const sc = scripts[s.kind], b = beatOf(s);
    return { title: b.title, speaker: b.speaker, text: b.text, index: s.index, number: s.index + 1, total: sc.beats.length, roteiro: true, cinematic: !b.text };
  }
  function timeline(id) {
    const sc = scripts[id]; if (!sc) return null;
    return Object.freeze({ id, duration: sc.duration, manualDefault: !sc.auto, shots: Object.freeze(sc.beats.map((b, i) => Object.freeze({ id: String(i), index: i, start: b.start, duration: b.duration, label: b.title || 'Quadro ' + (i + 1), speaker: b.speaker, text: b.text }))) });
  }
  function stateAt(id, seconds = 0, options = {}) {
    const sc = scripts[id]; if (!sc) return null;
    const el = clamp(Number(seconds) || 0, 0, sc.duration);
    let i = sc.beats.findIndex((b) => el < b.start + b.duration); if (i < 0) i = sc.beats.length - 1;
    const b = sc.beats[i]; let shotStart = b.start; for (let k = i; k >= 0 && sc.beats[k].shot === b.shot; k--) shotStart = sc.beats[k].start;
    return { ...create(id, { ...options, musicTimed: true }), index: i, time: el - b.start, shotTime: el - shotStart, elapsed: el, typed: 1e9, done: el >= sc.duration };
  }

  // A hora do dia do roteiro vale só enquanto ele está na tela.
  let forced = false, lastDraw = 0;
  function release() { if (forced) { forced = false; try { window.DayTime?.force?.(null); } catch (e) {} } }
  setInterval(() => { if (forced && performance.now() - lastDraw > 400) release(); }, 300);

  /* ---------- desenho ---------- */
  let world = null;
  const P = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, w, h); };
  function camAt(shot, t) {
    const k = shot.camCurve === 'linear' ? clamp(t / shot.camTime, 0, 1) : ease(t / shot.camTime);
    return { x: lerp(shot.camFrom.x, shot.camTo.x, k), y: lerp(shot.camFrom.y, shot.camTo.y, k), zoom: lerp(shot.camFrom.zoom, shot.camTo.zoom, k) };
  }
  function actorAt(a, t, speaking) {
    const k = a.to === null ? 0 : (t - a.t0) / (a.t1 - a.t0), moving = a.to !== null && k > 0 && k < 1;
    const x = a.to === null ? a.x : lerp(a.x, a.to, clamp(k, 0, 1));
    let y = a.y - (moving && a.jump ? Math.sin(clamp(k, 0, 1) * Math.PI) * a.jump : 0);
    const o = { facing: a.facing ?? (a.to !== null && a.to < a.x ? -1 : 1), frame: t, scale: a.scale, grounded: !(moving && a.jump), moving, emotion: a.emotion, ...a.opts };
    const anims = a.anim.split('+'); a = { ...a, anim: anims.find((n) => ['pulando', 'andando', 'correndo', 'ataque', 'tremendo', 'voando'].includes(n)) || '' };
    if (a.anim === 'pulando') { y -= Math.abs(Math.sin(t * 5)) * 18; o.grounded = false; o.vy = Math.cos(t * 5) > 0 ? -100 : 100; }
    if (a.anim === 'andando' || a.anim === 'correndo') { o.moving = true; if (a.anim === 'correndo') o.frame = t * 1.8; }
    if (a.anim === 'ataque') { o.attack = true; o.attackProgress = (t * 1.4) % 1; }
    if (a.anim === 'tremendo') o.hit = Math.sin(t * 40) > 0;
    if (a.anim === 'voando') { y -= 40 + Math.sin(t * 2) * 8; o.flight = true; o.grounded = false; }
    if (anims.includes('tremendo') && a.anim !== 'tremendo') o.hit = Math.sin(t * 40) > 0;
    if (speaking && !o.moving && o.grounded !== false) y -= Math.abs(Math.sin(t * 9)) * 2;
    let alpha = 1; if (a.appear >= 0) alpha = clamp((t - a.appear) / .35, 0, 1); if (t > a.vanish) alpha = Math.min(alpha, clamp(1 - (t - a.vanish) / .35, 0, 1));
    if (alpha < 1) o.opacity = alpha;
    return { x, y, o, visible: alpha > 0, extras: anims.filter((n) => EXT.anims[n]), alpha };
  }
  function fxWindow(e, t, def) { const t0 = num(e.t, 0), d = num(e.dur, def); return { on: t >= t0 && t <= t0 + d, k: clamp((t - t0) / d, 0, 1), t0, d }; }
  function drawWorld(c, sc, shot, s, t, b) {
    if (!world) { world = document.createElement('canvas'); world.width = W; world.height = H; }
    const w = world.getContext('2d'), cam = camAt(shot, t);
    let zoom = cam.zoom;
    for (const e of shot.fx) if (e.tipo === 'zoom_soco') { const t0 = num(e.t, 0); if (t >= t0) zoom += num(e.forca, .18) * Math.exp(-(t - t0) * 7) * (t - t0 < .05 ? (t - t0) / .05 : 1); }
    const camX = Math.round(cam.x - W / 2);
    w.save(); w.imageSmoothingEnabled = false; w.clearRect(0, 0, W, H);
    const pintor = EXT.fundos[bgName(shot.bg)];
    if (pintor) { w.save(); w.translate(-camX, 0); try { pintor(w, { t, tt: s.elapsed, shot, s, p: typeof shot.bg === 'object' ? shot.bg : {}, cam, W, H, ajuda }); } catch (e) { w.fillStyle = '#0b0d10'; w.fillRect(camX, 0, W, H); } w.restore(); }
    else if (shot.bg === 'preto') { w.fillStyle = '#0b0d10'; w.fillRect(0, 0, W, H); }
    else if (window.DAROCA_FUNDO_MUNDO?.(w, shot.scene, camX, s.elapsed)) { /* Roblox: o cenário vem das camadas, embaixo */ }
    else if (window.Art?.drawScene) window.Art.drawScene(w, shot.scene, camX, s.elapsed);
    else { w.fillStyle = '#8ec7e1'; w.fillRect(0, 0, W, H); }
    const list = shot.actors.map((a, i) => ({ a, i, p: actorAt(a, t, b.who === a.type) })).filter((r) => r.p.visible).sort((p, q) => p.a.z - q.a.z || p.p.y - q.p.y || p.i - q.i);
    for (const r of list) {
      const sx = r.p.x - camX;
      if (sx < -200 || sx > W + 200) continue;
      w.fillStyle = 'rgba(20,24,18,.28)'; w.fillRect(Math.round((sx - 16 * r.a.scale) / 2) * 2, Math.round(r.a.y / 2) * 2 - 2, Math.round(32 * r.a.scale / 2) * 2, 4);
      try {
        if (r.a.type === 'carro' && window.Art?.drawVehicle) {
          // o carro a gás do pai, com Da Roça montado, igual ao jogo
          const vf = r.p.o.facing < 0 ? -1 : 1, bob = r.p.o.moving ? Math.round(Math.sin(t * 18)) : 0;
          w.save(); w.translate(Math.round(sx), 0); w.scale(vf, 1); window.Art.drawVehicle(w, 0, r.p.y + bob, t); w.restore();
          window.Art.drawCharacter(w, 'daroca', sx + 4 * vf, r.p.y - 22 + bob, { ...r.p.o, moving: false, scale: .8 * r.a.scale });
        } else {
          const ctx = { x: sx, y: r.p.y, t, a: r.a, o: r.p.o, alpha: r.p.alpha, head: headBox(r.a.type), ajuda };
          for (const n of r.p.extras) EXT.anims[n].antes?.(w, ctx);
          window.Art?.drawCharacter?.(w, r.a.type, sx, r.p.y, r.p.o);
          for (const n of r.p.extras.slice().reverse()) EXT.anims[n].depois?.(w, ctx);
        }
      } catch (e) {}
    }
    if (!pintor && shot.bg !== 'preto' && window.HdScene?.drawAmbient && OUTDOOR.includes(shot.scene)) { try { window.HdScene.drawAmbient(w, s.elapsed, W / 2, FLOOR - 40, shot.scene); } catch (e) {} }
    w.restore();
    // câmera: recorte com zoom, mantendo a linha cam.y parada na tela
    let shake = 0;
    for (const e of shot.fx) if (e.tipo === 'tremer') { const f = fxWindow(e, t, .6); if (f.on) shake = Math.max(shake, num(e.forca, 8) * (1 - f.k)); }
    const sw = W / zoom, sh = H / zoom, fy = clamp(cam.y, 0, H);
    let sx = (W - sw) / 2, sy = fy - fy / zoom;
    sx = clamp(sx, Math.min(0, W - sw), Math.max(0, W - sw)); sy = clamp(sy, Math.min(0, H - sh), Math.max(0, H - sh));
    const dx = shake ? Math.round((hash(t * 60) - .5) * shake * 2 / 2) * 2 : 0, dy = shake ? Math.round((hash(t * 60 + 9) - .5) * shake * 2 / 2) * 2 : 0;
    // Roblox em camadas: o recorte com zoom do mundo (personagens) e do cenário é feito pela placa de vídeo
    if (window.DAROCA_QUADRO_CAMADAS >= 0 && c.camadaAbaixo) { c.clearRect(0, 0, W, H); c.camadaAbaixo(world, sx, sy, sw, sh, dx, dy); window.DAROCA_QUADRO_ZOOM = { sx, sy, sw, sh, dx, dy }; return; }
    c.save(); c.imageSmoothingEnabled = false; c.fillStyle = '#0b0d10'; c.fillRect(0, 0, W, H);
    c.drawImage(world, sx, sy, sw, sh, dx, dy, W, H); c.restore();
  }
  function card(c, text, sub, a, y = 230) {
    c.save(); c.globalAlpha = a; c.textAlign = 'center'; c.textBaseline = 'middle';
    c.fillStyle = 'rgba(12,16,14,.72)'; c.fillRect(0, y - 46, W, sub ? 104 : 84);
    c.fillStyle = '#e8c27a'; c.fillRect(0, y - 46, W, 4); c.fillRect(0, y + (sub ? 54 : 34), W, 4);
    c.font = 'bold 30px Pixel, monospace'; c.fillStyle = '#2a1c10'; c.fillText(text, W / 2 + 4, y + 4); c.fillStyle = '#ffe9b0'; c.fillText(text, W / 2, y);
    if (sub) { c.font = '13px Pixel, monospace'; c.fillStyle = '#d7e7a0'; c.fillText(sub, W / 2, y + 36); }
    c.restore();
  }
  // Roblox em camadas: efeito parado da tela toda (vinheta, noite, memória) é desenhado uma vez numa imagem guardada e
  // fica embaixo do canvas da cena (a placa de vídeo junta), em vez de misturar os 518 mil pixels a cada quadro
  const FIXAS = new Map();
  function fixa(c, chave, desenho) {
    if (!(window.DAROCA_QUADRO_CAMADAS >= 0) || !c.camadaAbaixo) return false;
    let cv = FIXAS.get(chave);
    if (!cv) { cv = document.createElement('canvas'); cv.width = W; cv.height = H; const g = cv.getContext('2d'); desenho(g); FIXAS.set(chave, cv); }
    c.camadaAbaixo(cv, 0, 0, W, H, 0, 0, true); return true;
  }
  function drawFx(c, shot, t, s) {
    const tt = s.elapsed;
    for (const e of shot.fx) {
      const tipo = e.tipo;
      if (tipo === 'vinheta') { if (!fixa(c, 'v' + num(e.forca, .6), (g) => { const gr = g.createRadialGradient(W / 2, H / 2, 200, W / 2, H / 2, 620); gr.addColorStop(0, 'rgba(0,0,0,0)'); gr.addColorStop(1, `rgba(8,6,4,${num(e.forca, .6)})`); g.fillStyle = gr; g.fillRect(0, 0, W, H); })) { const g = c.createRadialGradient(W / 2, H / 2, 200, W / 2, H / 2, 620); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(1, `rgba(8,6,4,${num(e.forca, .6)})`); c.fillStyle = g; c.fillRect(0, 0, W, H); } }
      else if (tipo === 'memoria') { if (!fixa(c, 'm', (g) => { g.fillStyle = 'rgba(150,110,60,.32)'; g.fillRect(0, 0, W, H); g.fillStyle = 'rgba(255,240,200,.08)'; for (let y = 0; y < H; y += 4) g.fillRect(0, y, W, 2); })) { c.fillStyle = 'rgba(150,110,60,.32)'; c.fillRect(0, 0, W, H); c.fillStyle = 'rgba(255,240,200,.08)'; for (let y = 0; y < H; y += 4) c.fillRect(0, y, W, 2); } for (let i = 0; i < 26; i++) P(c, hash(i + Math.floor(tt * 12)) * W, hash(i * 3 + Math.floor(tt * 12)) * H, 2, 2, 'rgba(255,240,210,.35)'); }
      else if (tipo === 'noite') { if (!fixa(c, 'n', (g) => { g.fillStyle = 'rgba(20,30,70,.38)'; g.fillRect(0, 0, W, H); })) { c.fillStyle = 'rgba(20,30,70,.38)'; c.fillRect(0, 0, W, H); } }
      else if (tipo === 'confete') { for (let i = 0; i < 70; i++) { const x = (hash(i) * W + Math.sin(tt * 2 + i) * 20 + W) % W, y = (hash(i + 5) * H + tt * (60 + hash(i + 2) * 70)) % H; P(c, x, y, 4, 4, ['#f2c14e', '#e85d75', '#5bc0eb', '#9bc53d', '#fff'][i % 5]); } }
      else if (tipo === 'coracoes') { for (let i = 0; i < 9; i++) { const x = 160 + hash(i) * 640, y = H - ((tt * 40 + hash(i + 1) * H) % H); const col = '#e85d75'; P(c, x, y, 4, 4, col); P(c, x + 6, y, 4, 4, col); P(c, x - 2, y + 4, 14, 4, col); P(c, x, y + 8, 10, 2, col); P(c, x + 2, y + 10, 6, 2, col); } }
      else if (tipo === 'brilhos') { for (let i = 0; i < 18; i++) { const on = Math.sin(tt * 4 + i * 1.7) > .3; if (!on) continue; const x = hash(i + 30) * W, y = 60 + hash(i + 31) * 340; P(c, x, y - 4, 2, 10, '#fff3a8'); P(c, x - 4, y, 10, 2, '#fff3a8'); } }
      else if (tipo === 'folhas') { for (let i = 0; i < 16; i++) { const x = (hash(i + 40) * 1100 + tt * (90 + hash(i) * 70)) % 1100 - 70, y = 80 + hash(i + 41) * 300 + Math.sin(tt * 2 + i) * 20; const col = ['#6aa850', '#c9a24a', '#d8783a'][i % 3]; P(c, x, y, 4, 2, col); P(c, x + 2, y - 2, 2, 2, col); } }
      else if (tipo === 'chuva') { c.fillStyle = 'rgba(40,52,80,.22)'; c.fillRect(0, 0, W, H); for (let i = 0; i < 140; i++) { const y = (hash(i + 3) * H + tt * (700 + hash(i) * 300)) % (H + 40) - 20, x = (hash(i + 7) * 1000 + y * .3) % 1000 - 20; P(c, x, y, 2, 10, 'rgba(210,225,250,.6)'); } }
      else if (tipo === 'raios') { c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 5; i++) { const x = 120 + i * 170 + Math.sin(tt * .5 + i) * 20; c.fillStyle = `rgba(255,228,160,${.06 + .03 * Math.sin(tt + i)})`; c.beginPath(); c.moveTo(x, 0); c.lineTo(x + 50, 0); c.lineTo(x - 90, H); c.lineTo(x - 170, H); c.fill(); } c.restore(); }
    }
    // efeitos com tempo
    for (const e of shot.fx) {
      const tipo = e.tipo;
      if (tipo === 'cartao') { const f = fxWindow(e, t, 3); if (f.on) card(c, String(e.texto || ''), e.sub ? String(e.sub) : '', Math.min(1, (t - f.t0) / .3, (f.t0 + f.d - t) / .3), num(e.y, 230)); }
      else if (tipo === 'letreiro') { const f = fxWindow(e, t, 3.2); if (f.on) { const a = Math.min(1, (t - f.t0) / .3, (f.t0 + f.d - t) / .3), slide = (1 - ease((t - f.t0) / .45)) * -340; c.save(); c.globalAlpha = a; c.fillStyle = 'rgba(14,20,16,.8)'; c.fillRect(slide, 58, 380, 62); c.fillStyle = '#e8c27a'; c.fillRect(slide, 58, 6, 62); c.textBaseline = 'middle'; c.textAlign = 'left'; c.font = '11px Pixel, monospace'; c.fillStyle = '#d7e7a0'; c.fillText(String(e.sub || 'VOCÊ CHEGOU'), slide + 22, 76); c.font = 'bold 19px Pixel, monospace'; c.fillStyle = '#fff1ca'; c.fillText(String(e.texto || ''), slide + 22, 102); c.restore(); } }
      else if (tipo === 'texto') { const f = fxWindow(e, t, 1.2); if (f.on) { const pop = 1 + Math.max(0, .35 - (t - f.t0)) * 1.4; c.save(); c.translate(num(e.x, 480), num(e.y, 200)); c.scale(pop, pop); c.rotate(num(e.giro, -.06)); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = `bold ${num(e.tamanho, 34)}px Pixel, monospace`; c.globalAlpha = Math.min(1, (f.t0 + f.d - t) / .25); c.fillStyle = '#1b130c'; c.fillText(String(e.texto || ''), 4, 4); c.fillStyle = e.cor || '#ffd166'; c.fillText(String(e.texto || ''), 0, 0); c.restore(); } }
      else if (tipo === 'flash') { const f = fxWindow(e, t, .35); if (f.on) { c.fillStyle = `rgba(${e.cor === 'vermelho' ? '255,80,60' : '255,250,235'},${(1 - f.k) * .85})`; c.fillRect(0, 0, W, H); } }
      else if (tipo === 'entrada') { const d = num(e.dur, .9), t0 = num(e.t, 0); if (t < t0 + d) { c.fillStyle = `rgba(8,8,10,${t < t0 ? 1 : 1 - (t - t0) / d})`; c.fillRect(0, 0, W, H); } }
      else if (EXT.efeitos[tipo]) { try { EXT.efeitos[tipo](c, e, t, { shot, s, W, H, win: (d) => fxWindow(e, t, d), num, P, card, ease, clamp, lerp, hash, ajuda }); } catch (err) {} }
      else if (tipo === 'saida') { const t0 = num(e.t, Math.max(0, shot.duration - .9)), d = num(e.dur, .9); if (t >= t0) { c.fillStyle = `rgba(8,8,10,${clamp((t - t0) / d, 0, 1)})`; c.fillRect(0, 0, W, H); } }
    }
  }
  function draw(c, s) {
    if (!c || !s) return;
    const sc = scripts[s.kind]; if (!sc) return;
    const b = beatOf(s), shot = sc.shots[b.shot], t = s.shotTime;
    lastDraw = performance.now();
    if (shot.hour !== null) { try { window.DayTime?.force?.(shot.hourTo === null ? shot.hour : lerp(shot.hour, shot.hourTo, ease(t / shot.camTime))); forced = true; } catch (e) {} } else release();
    c.save(); c.clearRect(0, 0, W, H);
    drawWorld(c, sc, shot, s, t, b);
    drawFx(c, shot, t, s);
    for (const g of EXT.ganchos) { try { g.quadro?.(s, sc, shot, t); } catch (e) {} }
    // trilhos de cinema finos, como nas outras cenas
    c.fillStyle = '#10241ff0'; c.fillRect(0, 0, W, 24); c.fillStyle = '#10241fe0'; c.fillRect(0, H - 20, W, 20);
    if (b.first && s.time < .25 && !shot.fx.some((e) => e.tipo === 'entrada')) { c.fillStyle = `rgba(13,29,24,${(1 - s.time / .25) * .6})`; c.fillRect(0, 24, W, H - 44); }
    if (sc.balao && b.text) { try { balao(c, s, sc, shot, b, t); } catch (e) {} }
    c.restore();
    if (!s.preview) syncOverlay(s, b);
  }

  // Balão no céu, com a ponta apontando para quem fala (posição na tela depois da câmera e do zoom).
  function anchor(s) {
    const sc = scripts[s.kind], b = beatOf(s), shot = sc.shots[b.shot], t = s.shotTime, cam = camAt(shot, t);
    const a = shot.actors.find((x) => x.type === b.who || (x.type === 'carro' && b.who === 'daroca'));
    if (!a) return { x: 480, y: 52, width: 520, speakerX: 480, speakerY: 300, tail: 'left' };
    const p = actorAt(a, t, true), camX = Math.round(cam.x - W / 2), z = cam.zoom, fy = clamp(cam.y, 0, H);
    let sx = (W - W / z) / 2, sy = fy - fy / z;
    sx = clamp(sx, Math.min(0, W - W / z), Math.max(0, W - W / z)); sy = clamp(sy, Math.min(0, H - H / z), Math.max(0, H - H / z));
    const headY = p.y - (a.type === 'carro' ? 90 : 70) * a.scale;
    const x = clamp((p.x - camX - sx) * z, 60, W - 60), y = clamp((headY - sy) * z, 120, 470);
    const left = x < W / 2;
    return { x: left ? clamp(x + 150, 290, 600) : clamp(x - 150, 360, 670), y: 52, width: 500, speakerX: x, speakerY: y, tail: left ? 'left' : 'right' };
  }

  /* ---------- balão de fala desenhado em cima de quem fala ("balao": true no roteiro) ---------- */
  const CORES_NOME = { daroca: '#b8862a', reeis: '#2f7a46', jorge: '#6a4a98', jorge_gordo: '#6a4a98', jorge_celular: '#6a4a98', miguel: '#2c6ab8', fred_conquista: '#b8902a', narrador: '#5a4a3a' };
  const corNome = (who) => CORES_NOME[who] || CORES_NOME[String(who).replace(/^(crianca|pre)_/, '')] || ['#a8443a', '#3c6a8a', '#7a4a8a', '#3c7a5a', '#a8642a', '#5a5aa8'][Math.floor(hash(String(who).length * 7.3 + String(who).charCodeAt(0)) * 6)];
  function falante(sc, shot, b, t) {
    const alias = { jorge: ['jorge', 'jorge_celular', 'jorge_gordo'], daroca: ['daroca', 'carro'] }, nomes = alias[b.who] || [b.who];
    const a = shot.actors.find((x) => nomes.includes(x.type)) || shot.actors.find((x) => x.type.replace(/^(crianca|pre)_/, '') === b.who.replace(/^(crianca|pre)_/, ''));
    if (!a) return null; const p = actorAt(a, t, true); if (!p.visible) return null;
    const cam = camAt(shot, t), camX = Math.round(cam.x - W / 2), z = cam.zoom, fy = clamp(cam.y, 0, H); let sx = (W - W / z) / 2, sy = fy - fy / z;
    sx = clamp(sx, Math.min(0, W - W / z), Math.max(0, W - W / z)); sy = clamp(sy, Math.min(0, H - H / z), Math.max(0, H - H / z));
    const hb = headBox(a.type), alto = (220 - hb.top) * (a.scale || 1);
    let hx = p.x, hy = p.y - alto, by = p.y - alto * .72;
    for (const nome of String(a.anim || '').split('+')) { const f = EXT.anims[nome]?.cabeca; if (f) { const r = f({ x: p.x, y: p.y, alto, facing: p.o.facing }); hx = r.x; hy = r.y - 10; by = r.y; } } // deitado: a cabeça fica de lado
    const x = (hx - camX - sx) * z, cabeca = (hy - sy) * z, boca = (by - sy) * z;
    return { x, cabeca, boca, fora: x < -20 || x > W + 20 || cabeca > H };
  }
  function linhas(c, txt, max) { const out = []; let l = ''; for (const w2 of txt.split(' ')) { const tst = l ? l + ' ' + w2 : w2; if (c.measureText(tst).width > max && l) { out.push(l); l = w2; } else l = tst; } if (l) out.push(l); return out; }
  function balao(c, s, sc, shot, b, t) {
    const n = Math.min(b.text.length, Math.floor(s.typed)), texto = b.text.slice(0, n), cheio = b.text;
    const letras = cheio.replace(/[^A-Za-zÀ-ú]/g, ''), grito = (letras.length > 3 && letras === letras.toUpperCase()) || /!!|\?!|!\?/.test(cheio), pensa = /^\(.*\)$/.test(cheio.trim()), cochicho = /^\.\.\.?$|^…$/.test(cheio.trim()) || cheio.trim() === '...';
    c.save(); c.imageSmoothingEnabled = false; c.textAlign = 'left'; c.textBaseline = 'alphabetic';
    const tam = grito ? 18 : 16; c.font = `${grito ? 'bold ' : ''}${tam}px Space, Arial, sans-serif`;
    if (b.who === 'narrador' || b.who === 'nenhum') { // legenda de narração, estilo quadrinho
      const ls = linhas(c, cheio, 560), bw = Math.min(600, Math.max(...ls.map((l) => c.measureText(l).width)) + 36), bh = ls.length * 22 + 26, bx = 24, by = 34;
      c.fillStyle = 'rgba(0,0,0,.35)'; c.fillRect(bx + 4, by + 4, bw, bh); c.fillStyle = '#2a1a10'; c.fillRect(bx - 3, by - 3, bw + 6, bh + 6); c.fillStyle = '#f2dc9a'; c.fillRect(bx, by, bw, bh); c.fillStyle = '#e2c47a'; c.fillRect(bx, by + bh - 4, bw, 4);
      if (b.speaker && b.speaker !== 'Narrador') { c.font = '10px Pixel, monospace'; c.fillStyle = '#7a4a2a'; c.fillText(b.speaker.toUpperCase(), bx + 14, by + 16); }
      c.font = `${tam}px Space, Arial, sans-serif`; c.fillStyle = '#3a2412'; c.textBaseline = 'top'; linhas(c, texto, 560).forEach((l, i) => c.fillText(l, bx + 18, by + 13 + (b.speaker && b.speaker !== 'Narrador' ? 8 : 0) + i * 22)); c.restore(); return;
    }
    const pos = falante(sc, shot, b, t), max = grito ? 330 : 300, ls = linhas(c, cheio, max), lw = Math.max(80, ...ls.map((l) => c.measureText(l).width)), bw = Math.round(lw + 32), bh = Math.round(ls.length * (tam + 6) + 26);
    let bx, by, tx, ty, lado = 'baixo';
    if (pos && !pos.fora) { tx = clamp(pos.x, 10, W - 10); ty = clamp(pos.boca, 40, H - 30); bx = clamp(pos.x - bw / 2 + (pos.x < W / 2 ? 40 : -40), 14, W - bw - 14); by = Math.round(pos.cabeca - 30 - bh);
      if (by < 30) { by = clamp(Math.round(pos.boca - bh / 2), 30, H - 26 - bh); lado = pos.x < W / 2 ? 'esq' : 'dir'; bx = lado === 'esq' ? Math.min(W - bw - 14, Math.round(pos.x + 46)) : Math.max(14, Math.round(pos.x - 46 - bw)); } }
    else { bx = Math.round(W / 2 - bw / 2 + 30); by = H - 40 - bh; lado = 'nenhum'; }
    const tre = grito ? Math.round(Math.sin(t * 50) * 1.5) : 0; bx += tre;
    const borda = grito ? '#8a1a1a' : '#2a1a10', fundo = pensa ? '#f6f6fa' : '#fff6dc';
    // rabinho
    if (lado !== 'nenhum') { c.fillStyle = borda; const ax = clamp(tx, bx + 18, bx + bw - 18);
      if (pensa) { for (let k = 0; k < 3; k++) { const q = (k + 1) / 4, cx = lerp(ax, tx, q), cy = lerp(by + bh, ty - 10, q), r = 7 - k * 2; c.beginPath(); c.arc(cx, cy, r + 2, 0, Math.PI * 2); c.fill(); c.fillStyle = fundo; c.beginPath(); c.arc(cx, cy, r, 0, Math.PI * 2); c.fill(); c.fillStyle = borda; } }
      else { const base = lado === 'baixo' ? [[ax - 12, by + bh - 2], [ax + 12, by + bh - 2]] : lado === 'esq' ? [[bx + 2, by + bh / 2 - 12], [bx + 2, by + bh / 2 + 12]] : [[bx + bw - 2, by + bh / 2 - 12], [bx + bw - 2, by + bh / 2 + 12]], pt = [tx + (lado === 'esq' ? 10 : lado === 'dir' ? -10 : 0), ty - (lado === 'baixo' ? 14 : 0)];
        c.beginPath(); c.moveTo(base[0][0] - 3, base[0][1]); c.lineTo(pt[0], pt[1] + 3); c.lineTo(base[1][0] + 3, base[1][1]); c.fill(); c.fillStyle = fundo; c.beginPath(); c.moveTo(base[0][0] + 1, base[0][1] - 3); c.lineTo(pt[0], pt[1] - 2); c.lineTo(base[1][0] - 1, base[1][1] - 3); c.fill(); } }
    // corpo do balão (cantos em degrau, pixelado)
    const corpo = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(x + 6, y, w - 12, h); c.fillRect(x + 2, y + 2, w - 4, h - 4); c.fillRect(x, y + 6, w, h - 12); };
    c.fillStyle = 'rgba(0,0,0,.28)'; corpo(bx + 4, by + 5, bw, bh, 'rgba(0,0,0,.28)');
    corpo(bx - 3, by - 3, bw + 6, bh + 6, borda); corpo(bx, by, bw, bh, fundo);
    if (grito) { c.fillStyle = borda; for (let k = 0; k < bw; k += 22) { c.beginPath(); c.moveTo(bx + k, by - 2); c.lineTo(bx + k + 8, by - 10); c.lineTo(bx + k + 14, by - 2); c.fill(); c.beginPath(); c.moveTo(bx + k + 6, by + bh + 2); c.lineTo(bx + k + 12, by + bh + 9); c.lineTo(bx + k + 18, by + bh + 2); c.fill(); } }
    if (cochicho) { c.strokeStyle = '#ffffff'; c.setLineDash([6, 6]); c.lineWidth = 3; c.strokeRect(bx - 2, by - 2, bw + 4, bh + 4); c.setLineDash([]); }
    c.fillStyle = 'rgba(255,255,255,.55)'; c.fillRect(bx + 8, by + 3, bw - 16, 2);
    // etiqueta com o nome
    c.font = '10px Pixel, monospace'; const nome = String(b.speaker || '').toUpperCase(), nw = Math.ceil(c.measureText(nome).width) + 14, cor = corNome(b.who);
    c.fillStyle = '#2a1a10'; c.fillRect(bx + 10, by - 12, nw + 4, 18); c.fillStyle = cor; c.fillRect(bx + 12, by - 10, nw, 14); c.fillStyle = 'rgba(255,255,255,.25)'; c.fillRect(bx + 12, by - 10, nw, 2); c.fillStyle = '#ffffff'; c.textBaseline = 'middle'; c.fillText(nome, bx + 19, by - 2);
    if (lado === 'nenhum' && b.portrait) { const pc = retratoCache(b.who, b.emotion, t); c.fillStyle = '#2a1a10'; c.fillRect(bx - 66, by + bh / 2 - 30, 60, 60); c.drawImage(pc, bx - 63, by + bh / 2 - 27, 54, 54); }
    // texto letra por letra
    c.font = `${grito ? 'bold ' : ''}${tam}px Space, Arial, sans-serif`; c.fillStyle = grito ? '#7a1010' : pensa ? '#4a4a6a' : '#4a2e1a'; c.textBaseline = 'top';
    linhas(c, texto, max).forEach((l, i) => c.fillText(l, bx + 16, by + 14 + i * (tam + 6)));
    if (n >= cheio.length && Math.floor(t * 2.5) % 2) { c.fillStyle = borda; c.beginPath(); c.moveTo(bx + bw - 22, by + bh - 14); c.lineTo(bx + bw - 10, by + bh - 14); c.lineTo(bx + bw - 16, by + bh - 7); c.fill(); }
    c.restore();
  }
  let rcCanvas = null, rcKey = ''; function retratoCache(who, emo, t) { if (!rcCanvas) { rcCanvas = document.createElement('canvas'); rcCanvas.width = rcCanvas.height = 64; } const k = who + emo; if (k !== rcKey) { rcKey = k; drawPortrait(rcCanvas.getContext('2d'), who, 64, 0, emo); } return rcCanvas; }

  /* ---------- caixa de fala: retrato e texto letra por letra ---------- */
  let portraitCv = null, lastSync = '';
  function syncOverlay(s, b) {
    const overlay = document.getElementById('cinematicOverlay'); if (!overlay) return;
    overlay.classList.add('is-roteiro'); overlay.classList.toggle('roteiro-sem-fala', !b.text); overlay.classList.toggle('roteiro-balao', !!scripts[s.kind]?.balao); overlay.classList.toggle('roteiro-com-retrato', !!(b.text && b.portrait));
    if (b.text && b.portrait) {
      if (!portraitCv) { portraitCv = document.createElement('canvas'); portraitCv.width = 64; portraitCv.height = 64; portraitCv.className = 'roteiro-retrato'; portraitCv.setAttribute('aria-hidden', 'true'); }
      const cap = overlay.querySelector('.cinematic-caption'); if (cap && portraitCv.parentNode !== cap) cap.insertBefore(portraitCv, cap.firstChild);
      drawPortrait(portraitCv.getContext('2d'), b.who, 64, s.shotTime, b.emotion);
    }
    const p = document.getElementById('cinematicText');
    if (p && b.text) { const n = Math.min(b.text.length, Math.floor(s.typed)), key = s.kind + s.index + ':' + n; if (key !== lastSync) { lastSync = key; p.textContent = b.text.slice(0, n); p.setAttribute('aria-label', b.text); } }
    if (!clearer) clearer = setInterval(() => { if (performance.now() - lastDraw > 300) { overlay.classList.remove('is-roteiro', 'roteiro-sem-fala', 'roteiro-com-retrato', 'roteiro-balao'); } }, 250);
  }
  let clearer = null;

  /* ---------- ganchos para o jogo ---------- */
  const seen = (q) => (q && typeof q.roteiros === 'object' && q.roteiros) || {};
  const allowed = (s, q) => s && (!s.once || !seen(q)[s.id]);
  const find = (fn, q) => Object.values(scripts).find((s) => fn(s) && allowed(s, q))?.id || null;
  const api = {
    ready: () => ready, list: () => Object.keys(scripts), has, get: (id) => scripts[id] || null, errors: () => errors.slice(),
    antes: (kind, q) => find((s) => s.before === kind, q),
    depois: (kind, q) => find((s) => s.after === kind, q),
    chegada: (scene, q) => find((s) => s.arrival === Number(scene), q),
    visto: (id, q) => { if (!q || !scripts[id]) return; if (!q.roteiros || typeof q.roteiros !== 'object') q.roteiros = {}; q.roteiros[id] = 1; },
    musicFor: (id) => scripts[id]?.music || [],
    create, update, advance, beat, draw, timeline, stateAt, timelinePosition: (s) => (s ? (s.done ? scripts[s.kind]?.duration || 0 : s.elapsed) : 0),
    sfx, load, register, portrait: drawPortrait, estender, cabeca: headBox
  };
  const ajuda = { portrait: drawPortrait, head: headBox, sfx, hash, ease, clamp, lerp };

  // Encaixe em window.Cinematics: roteiros respondem pelos seus ids, o resto segue igual.
  function wrap() {
    const C = window.Cinematics; if (!C || C.__roteiro) return;
    const o = { ...C }, mine = (s) => s && s.roteiro && scripts[s.kind];
    C.create = (kind, opt) => (has(kind) ? create(kind, opt) : o.create(kind, opt));
    C.update = (s, dt) => (mine(s) ? update(s, dt) : o.update(s, dt));
    C.advance = (s) => (mine(s) ? advance(s) : o.advance(s));
    C.beat = (s) => (mine(s) ? beat(s) : o.beat(s));
    C.draw = (c, s) => (mine(s) ? draw(c, s) : o.draw(c, s));
    C.anchor = (s) => (mine(s) ? anchor(s) : o.anchor(s));
    C.timeline = (k) => (typeof k === 'string' && has(k) ? timeline(k) : k && typeof k === 'object' && mine(k) ? api.timelinePosition(k) : o.timeline(k));
    C.timelinePosition = (s) => (mine(s) ? api.timelinePosition(s) : o.timelinePosition(s));
    C.stateAt = (k, sec, opt) => (has(k) ? stateAt(k, sec, opt) : o.stateAt(k, sec, opt));
    C.__roteiro = true;
  }
  wrap();

  /* ---------- prévia sozinha: ?roteiro=<id> ---------- */
  function preview(id) {
    const sc = scripts[id];
    if (!sc) { alert('Roteiro "' + id + '" não encontrado.\n' + (errors.join('\n') || 'Confira o id e a lista.json.')); return; }
    const cv = document.createElement('canvas'); cv.width = W; cv.height = H;
    cv.style.cssText = 'position:fixed;inset:0;margin:auto;width:min(100vw,177.8vh);height:min(56.25vw,100vh);z-index:99999;background:#000;image-rendering:pixelated';
    document.body.appendChild(cv);
    const c = cv.getContext('2d'), pc = document.createElement('canvas'); pc.width = pc.height = 64;
    let s = create(id, {}); s.preview = true; let last = performance.now(), stop = false;
    const close = () => { stop = true; cv.remove(); release(); removeEventListener('keydown', key); };
    const step = () => { if (s.done) { s = create(id, {}); s.preview = true; } else advance(s); };
    const key = (e) => { if (e.key === 'Escape') close(); else if ([' ', 'Enter', 'e', 'E', 'ArrowRight'].includes(e.key)) { e.preventDefault(); step(); } };
    addEventListener('keydown', key); cv.addEventListener('click', step);
    const loop = (now) => {
      if (stop) return; const dt = Math.min(.1, (now - last) / 1000); last = now;
      if (!s.done) update(s, dt);
      if (!s.done) { draw(c, s); const b = beatOf(s);
        if (b.text && !sc.balao) { const x0 = b.portrait ? 120 : 40; c.fillStyle = 'rgba(16,30,24,.92)'; c.fillRect(30, 388, 900, 120); c.fillStyle = '#bacf82'; c.fillRect(30, 388, 900, 3);
          if (b.portrait) { drawPortrait(pc.getContext('2d'), b.who, 64, s.shotTime, b.emotion); c.imageSmoothingEnabled = false; c.drawImage(pc, 44, 404, 64, 64); }
          c.textAlign = 'left'; c.textBaseline = 'top'; c.font = '12px Pixel, monospace'; c.fillStyle = '#d7e7a0'; c.fillText(b.speaker, x0, 402);
          c.font = '16px Arial, sans-serif'; c.fillStyle = '#eff0d9'; const words = b.text.slice(0, Math.floor(s.typed)).split(' '); let line = '', y = 428;
          for (const w2 of words) { if (c.measureText(line + w2).width > 780 - x0) { c.fillText(line, x0, y); line = ''; y += 22; } line += w2 + ' '; } c.fillText(line, x0, y); }
        c.textAlign = 'right'; c.font = '10px Pixel, monospace'; c.fillStyle = '#ffffffaa'; c.fillText(`${sc.title} · ${s.index + 1}/${sc.beats.length} · clique ou Enter avança · Esc fecha`, 950, 6);
      } else { c.fillStyle = '#000'; c.fillRect(0, 0, W, H); c.fillStyle = '#fff'; c.textAlign = 'center'; c.font = '14px Pixel, monospace'; c.fillText('FIM · clique para ver de novo · Esc fecha', W / 2, H / 2); }
      requestAnimationFrame(loop);
    };
    requestAnimationFrame(loop);
  }
  window.Roteiro = Object.freeze({ ...api, preview });
  load().then(() => {
    try { const id = new URLSearchParams(location.search).get('roteiro'); if (id) preview(id); } catch (e) {}
  });
})();
