/* Áudio da Roça (Fase 9): volumes, efeitos sonoros e ambiente das fases.
   - Volume de MÚSICA e de EFEITOS separados (0 a 100%), salvos no aparelho ('daroca-volumes-v1').
     O tocador de música, os sons do jogo, das cutscenes, do fliperama e do cenário obedecem.
   - Efeitos sintetizados (sem arquivos): DarocaAudio.play('quebra'), 'porta', 'alavanca', 'agua', 'mato',
     'tac', 'fogo', 'moeda', 'pulo'... Só tocam com o som do jogo ligado.
   - Ambiente de cada fase (passarinhos e vento na roça, rio na praça, torcida na quadra e no campo,
     conversa no pátio e na favela, zumbido no Reino de Tinta, grilos à noite, chuva...). Também dá
     para trocar por um arquivo da pasta de músicas: "ambiente-roca = meu-som.ogg" em musicas.txt. */
(() => {
  'use strict';
  if (window.DarocaAudio) return;
  const KEY = 'daroca-volumes-v1';
  let vol = { music: 1, sfx: 1, ambient: true };
  try { const d = JSON.parse(localStorage.getItem(KEY)); if (d) vol = { music: clamp(+d.music, 0, 1, 1), sfx: clamp(+d.sfx, 0, 1, 1), ambient: d.ambient !== false }; } catch (e) {}
  function clamp(v, a, b, def) { return Number.isFinite(v) ? Math.max(a, Math.min(b, v)) : def; }
  const listeners = new Set(), save = () => { try { localStorage.setItem(KEY, JSON.stringify(vol)); } catch (e) {} listeners.forEach((fn) => { try { fn({ ...vol }); } catch (e) {} }); };
  const soundOn = () => (window.Game?.soundOn ? window.Game.soundOn() : true);

  let ctx = null, master = null;
  function ac() {
    if (!ctx) { try { ctx = new (window.AudioContext || window.webkitAudioContext)(); master = ctx.createGain(); master.connect(ctx.destination); } catch (e) { return null; } }
    if (ctx.state === 'suspended') ctx.resume().catch(() => {});
    return ctx;
  }
  /* ---------------- efeitos sintetizados ---------------- */
  function play(name, opts = {}) {
    if (!soundOn() || vol.sfx <= 0) return;
    const a = ac(); if (!a) return;
    const now = a.currentTime, out = a.createGain(); out.gain.value = .05 * vol.sfx * (opts.volume || 1); out.connect(master);
    const tone = (f, f2, d, type = 'square', at = 0, v = 1) => { const o = a.createOscillator(), g = a.createGain(); o.type = type; o.frequency.setValueAtTime(f, now + at); if (f2) o.frequency.exponentialRampToValueAtTime(Math.max(30, f2), now + at + d); g.gain.setValueAtTime(v, now + at); g.gain.exponentialRampToValueAtTime(.001, now + at + d); o.connect(g); g.connect(out); o.start(now + at); o.stop(now + at + d + .02); };
    const noise = (d, v = 1, at = 0, f = 0, type = 'highpass') => { const len = Math.max(1, Math.floor(a.sampleRate * d)), buf = a.createBuffer(1, len, a.sampleRate), ch = buf.getChannelData(0); for (let i = 0; i < len; i++) ch[i] = (Math.random() * 2 - 1) * (1 - i / len); const s = a.createBufferSource(), g = a.createGain(); s.buffer = buf; g.gain.value = v; let n = s; if (f) { const fl = a.createBiquadFilter(); fl.type = type; fl.frequency.value = f; s.connect(fl); n = fl; } n.connect(g); g.connect(out); s.start(now + at); };
    switch (name) {
      case 'quebra': noise(.18, 1.2, 0, 900); tone(220, 90, .14, 'triangle', 0, .8); noise(.08, .6, .06, 2400); break;
      case 'porta': tone(180, 140, .25, 'sawtooth', 0, .35); tone(320, 260, .2, 'triangle', .05, .3); noise(.06, .5, .25, 300, 'lowpass'); break;
      case 'alavanca': tone(400, 600, .06, 'square'); tone(900, 900, .05, 'square', .08); break;
      case 'agua': noise(.25, .9, 0, 1200, 'bandpass'); tone(700, 300, .12, 'sine', 0, .6); break;
      case 'mato': noise(.16, .7, 0, 3400); noise(.12, .5, .05, 1500, 'bandpass'); break;
      case 'tac': tone(1400, 800, .04, 'square'); noise(.04, .7, 0, 3000); break;
      case 'fogo': noise(.5, .8, 0, 500, 'lowpass'); noise(.3, .4, .1, 2000); break;
      case 'moeda': tone(988, 988, .07, 'square'); tone(1319, 1319, .14, 'square', .07); break;
      case 'pulo': tone(300, 600, .1, 'square', 0, .6); break;
      case 'impacto': tone(140, 40, .3, 'square'); noise(.2, .8); break;
      case 'sino': tone(880, 870, 1, 'sine'); tone(1320, 1300, .8, 'sine', 0, .5); break;
      case 'buzina': tone(392, 392, .18, 'sawtooth'); tone(392, 392, .28, 'sawtooth', .22); break;
      default: tone(660, 600, .1, 'square');
    }
  }
  /* ---------------- ambiente das fases ---------------- */
  // Cada perfil: camadas de ruído filtrado (vento, rio, torcida) + eventos aleatórios (pássaros, apito...).
  const PROFILES = {
    0: { name: 'roca', beds: [['lowpass', 380, .5, .12]], events: ['passaro', 'passaro', 'galinha'] },
    1: { name: 'escola', beds: [['bandpass', 700, .25, .5]], events: ['criancas'] },
    2: { name: 'academia', beds: [['lowpass', 120, .45, .05]], events: ['ferro'] },
    3: { name: 'quadra', beds: [['bandpass', 520, .4, .7]], events: ['apito', 'torcida'] },
    4: { name: 'praca', beds: [['bandpass', 900, .5, .2], ['lowpass', 160, .2, .05]], events: ['passaro'] },
    5: { name: 'favela', beds: [['bandpass', 650, .3, .5]], events: ['cachorro', 'criancas'] },
    6: { name: 'caderno', beds: [['lowpass', 90, .6, .03]], drone: true, events: ['sussurro'] },
    7: { name: 'campo', beds: [['bandpass', 480, .45, .7]], events: ['apito', 'torcida'] },
    8: { name: 'bigodon', beds: [['lowpass', 140, .3, .05]], events: ['maquina'] },
    9: { name: 'patio', beds: [['bandpass', 760, .3, .5]], events: ['criancas'] },
    10: { name: 'rayssa', beds: [['lowpass', 110, .25, .04]], events: ['relogio'] }
  };
  let amb = null, ambNoise = null, fileAmb = null, fileAmbKey = '', nextEvent = 0, lastKey = '';
  function noiseBuffer(a) { if (ambNoise) return ambNoise; const len = a.sampleRate * 3, buf = a.createBuffer(1, len, a.sampleRate), ch = buf.getChannelData(0); let b = 0; for (let i = 0; i < len; i++) { b = b * .97 + (Math.random() * 2 - 1) * .03; ch[i] = (Math.random() * 2 - 1) * .6 + b * 6; } return (ambNoise = buf); }
  function stopAmb() { if (!amb) return; const old = amb; amb = null; try { old.gain.gain.cancelScheduledValues(old.ctx.currentTime); old.gain.gain.setTargetAtTime(0, old.ctx.currentTime, .4); setTimeout(() => old.nodes.forEach((n) => { try { n.stop?.(); n.disconnect(); } catch (e) {} }), 2500); } catch (e) {} }
  function startAmb(scene, night) {
    const a = ac(), p = PROFILES[scene]; if (!a || !p) return;
    const gain = a.createGain(); gain.gain.value = 0; gain.connect(master); const nodes = [gain];
    for (const [type, f, v, mod] of p.beds) { const s = a.createBufferSource(); s.buffer = noiseBuffer(a); s.loop = true; const fl = a.createBiquadFilter(); fl.type = type; fl.frequency.value = f; fl.Q.value = type === 'bandpass' ? .7 : .5; const g = a.createGain(); g.gain.value = v;
      if (mod) { const lfo = a.createOscillator(), lg = a.createGain(); lfo.frequency.value = .07 + Math.random() * .1; lg.gain.value = v * mod; lfo.connect(lg); lg.connect(g.gain); lfo.start(); nodes.push(lfo); }
      s.connect(fl); fl.connect(g); g.connect(gain); s.start(0, Math.random() * 2); nodes.push(s, fl, g); }
    if (p.drone) for (const f of [55, 58.3, 110.4]) { const o = a.createOscillator(), g = a.createGain(); o.type = 'sine'; o.frequency.value = f; g.gain.value = .12; o.connect(g); g.connect(gain); o.start(); nodes.push(o, g); }
    amb = { scene, night, ctx: a, gain, nodes, rain: null };
  }
  function ambEvent(kind, night) {
    const a = ctx; if (!a || !amb) return; const now = a.currentTime, out = a.createGain(); out.gain.value = .5; out.connect(amb.gain);
    const chirp = (f, f2, d, at, v = .5, type = 'sine') => { const o = a.createOscillator(), g = a.createGain(); o.type = type; o.frequency.setValueAtTime(f, now + at); o.frequency.exponentialRampToValueAtTime(f2, now + at + d); g.gain.setValueAtTime(0, now + at); g.gain.linearRampToValueAtTime(v, now + at + d * .2); g.gain.exponentialRampToValueAtTime(.001, now + at + d); o.connect(g); g.connect(out); o.start(now + at); o.stop(now + at + d + .05); };
    if (night && (kind === 'passaro' || kind === 'galinha')) kind = 'grilo';
    switch (kind) {
      case 'passaro': { const base = 2400 + Math.random() * 1600; for (let i = 0; i < 2 + (Math.random() * 3 | 0); i++) chirp(base, base * (1.2 + Math.random() * .4), .08, i * .13, .25); break; }
      case 'galinha': chirp(700, 600, .12, 0, .2, 'sawtooth'); chirp(750, 520, .18, .16, .2, 'sawtooth'); break;
      case 'grilo': for (let i = 0; i < 6; i++) chirp(4600, 4500, .03, i * .06, .12, 'square'); break;
      case 'apito': chirp(2500, 2450, .35, 0, .2); break;
      case 'torcida': { const s = a.createBufferSource(); s.buffer = noiseBuffer(a); const fl = a.createBiquadFilter(); fl.type = 'bandpass'; fl.frequency.value = 600; const g = a.createGain(); g.gain.setValueAtTime(0, now); g.gain.linearRampToValueAtTime(.9, now + .4); g.gain.linearRampToValueAtTime(0, now + 1.8); s.connect(fl); fl.connect(g); g.connect(out); s.start(now, Math.random()); s.stop(now + 2); break; }
      case 'criancas': for (let i = 0; i < 3; i++) chirp(500 + Math.random() * 300, 650 + Math.random() * 300, .15, i * .2, .06, 'triangle'); break;
      case 'cachorro': chirp(420, 260, .14, 0, .25, 'sawtooth'); chirp(440, 250, .14, .25, .25, 'sawtooth'); break;
      case 'ferro': chirp(320, 300, .5, 0, .2, 'triangle'); chirp(900, 880, .3, 0, .08, 'square'); break;
      case 'sussurro': chirp(180, 120, 1.2, 0, .1, 'triangle'); break;
      case 'maquina': chirp(110, 112, 1.2, 0, .08, 'sawtooth'); break;
      case 'relogio': chirp(1800, 1800, .02, 0, .15, 'square'); chirp(1500, 1500, .02, .5, .12, 'square'); break;
    }
  }
  // arquivo de ambiente (musicas.txt: ambiente-<lugar> = arquivo)
  function fileAmbient(scene) { const map = window.DarocaMusicas?.ambient?.() || {}, p = PROFILES[scene]; return p ? map[p.name] || null : null; }
  function tick() {
    let st = null; try { st = window.Game?.getAudioState?.(); } catch (e) {}
    const fl = window.Fliperama?.isOpen?.(), live = !!st && st.started && st.playing !== false && !st.paused && !st.cutscene && !st.room && !fl && soundOn() && vol.ambient && vol.sfx > 0;
    const scene = live ? Number(st.scene) : -1, s = window.DayTime?.state?.(), night = !!s && s.night > .55, file = live ? fileAmbient(scene) : null;
    // arquivo de ambiente no lugar do sintetizado
    if (file) { if (fileAmbKey !== file) { try { fileAmb?.pause(); } catch (e) {} fileAmb = new Audio(file); fileAmb.loop = true; fileAmbKey = file; fileAmb.play().catch(() => {}); } fileAmb.volume = Math.min(1, .5 * vol.sfx * (st.boss ? .4 : 1)); if (amb) stopAmb(); }
    else if (fileAmb) { try { fileAmb.pause(); } catch (e) {} fileAmb = null; fileAmbKey = ''; }
    const key = !file && live && PROFILES[scene] ? scene + '' : '';
    if (key !== lastKey) { lastKey = key; stopAmb(); if (key) startAmb(scene, night); }
    if (amb && ctx) {
      const level = .07 * vol.sfx * (st?.boss ? .35 : 1);
      amb.gain.gain.setTargetAtTime(level, ctx.currentTime, .6);
      // chuva por cima do ambiente
      const rain = window.Weather?.state?.()?.rain || 0;
      if (rain > .15 && !amb.rain) { const s2 = ctx.createBufferSource(); s2.buffer = noiseBuffer(ctx); s2.loop = true; const f = ctx.createBiquadFilter(); f.type = 'highpass'; f.frequency.value = 1400; const g = ctx.createGain(); g.gain.value = 0; s2.connect(f); f.connect(g); g.connect(amb.gain); s2.start(); amb.rain = g; amb.nodes.push(s2, f, g); }
      if (amb.rain) amb.rain.gain.setTargetAtTime(Math.min(1.2, rain * 1.4), ctx.currentTime, 1);
      const t = performance.now(); if (t > nextEvent) { nextEvent = t + 1500 + Math.random() * 4500; const ev = PROFILES[amb.scene].events; if (ev?.length && Math.random() < .8) ambEvent(ev[Math.random() * ev.length | 0], night); }
    }
  }
  setInterval(tick, 400);
  // o navegador só libera áudio depois de um toque ou tecla
  const unlock = () => { if (soundOn()) ac(); };
  addEventListener('pointerdown', unlock, { passive: true }); addEventListener('keydown', unlock);

  window.DarocaAudio = Object.freeze({
    music: () => vol.music, sfx: () => vol.sfx, ambientOn: () => vol.ambient,
    setMusic: (v) => { vol.music = clamp(+v, 0, 1, 1); save(); }, setSfx: (v) => { vol.sfx = clamp(+v, 0, 1, 1); save(); }, setAmbient: (on) => { vol.ambient = !!on; save(); },
    onChange: (fn) => { listeners.add(fn); return () => listeners.delete(fn); }, play,
    status: () => ({ ambiente: amb ? PROFILES[amb.scene]?.name : fileAmbKey || null, chuva: !!amb?.rain, contexto: ctx?.state || 'sem áudio' })
  });
})();
