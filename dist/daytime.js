/* Hora do dia: um relógio visual que as cenas novas usam para colorir céu, luz ambiente,
   raios de sol e lâmpadas. É só aparência: não mexe em regras, tempos nem dificuldade.
   Modos: automática (um dia inteiro a cada 6 minutos) ou hora fixa. */
(() => {
  'use strict';
  if (window.DayTime) return;
  const KEY = 'daroca-daytime-v1', DAY_SECONDS = 360, START_HOUR = 15.5;
  const MODES = [
    { id: 'auto', label: 'AUTOMÁTICA', text: 'O dia passa sozinho: tarde, pôr do sol, noite e manhã.' },
    { id: 'manha', label: 'MANHÃ', hour: 8.2, text: 'Luz clara e fria entrando pelas janelas.' },
    { id: 'tarde', label: 'TARDE', hour: 13.5, text: 'Sol alto e cores vivas.' },
    { id: 'por', label: 'PÔR DO SOL', hour: 17.7, text: 'Luz dourada e sombras compridas.' },
    { id: 'noite', label: 'NOITE', hour: 22, text: 'Lua, estrelas e lâmpadas acesas.' }
  ];
  // h, céu de cima, céu de baixo, luz ambiente (multiplica a cena), cor do sol/lua, noite (0..1)
  const KEYS = [
    [0, '#0b1030', '#1c2a55', '#7d8ccc', '#8fa8ff', 1],
    [4.8, '#141a44', '#30386e', '#7f8cc8', '#8fa8ff', 1],
    [6.2, '#4a5aa0', '#f0a078', '#dcbcb0', '#ffb07a', .45],
    [8, '#5aa0e0', '#c8e4f0', '#fff4e6', '#fff1c8', 0],
    [12, '#3f8fe0', '#bfe2f5', '#ffffff', '#fff8dc', 0],
    [16, '#4a90d8', '#f2dcae', '#fff0d8', '#ffe2a0', 0],
    [17.8, '#5a5aa8', '#ff9a5a', '#ffc89a', '#ff9a4a', .3],
    [19, '#2a2a68', '#a0507a', '#a890c0', '#c88ab0', .85],
    [20.5, '#0d1236', '#22305e', '#7d8ccc', '#8fa8ff', 1],
    [24, '#0b1030', '#1c2a55', '#7d8ccc', '#8fa8ff', 1]
  ];
  const rgb = (hex) => [parseInt(hex.slice(1, 3), 16) / 255, parseInt(hex.slice(3, 5), 16) / 255, parseInt(hex.slice(5, 7), 16) / 255];
  const TABLE = KEYS.map((k) => ({ h: k[0], top: rgb(k[1]), bot: rgb(k[2]), amb: rgb(k[3]), sun: rgb(k[4]), night: k[5] }));
  const mix = (a, b, k) => [a[0] + (b[0] - a[0]) * k, a[1] + (b[1] - a[1]) * k, a[2] + (b[2] - a[2]) * k];
  let mode = 'auto', forced = null;
  try { const saved = localStorage.getItem(KEY); if (MODES.some((m) => m.id === saved)) mode = saved; } catch (e) {}
  const listeners = [];
  const current = () => MODES.find((m) => m.id === mode) || MODES[0];
  function hour() {
    if (forced !== null) return forced;
    const m = current();
    if (m.hour !== undefined) return m.hour;
    return (START_HOUR + performance.now() / 1000 / DAY_SECONDS * 24) % 24;
  }
  function state() {
    const h = hour();
    let i = 0; while (i < TABLE.length - 2 && TABLE[i + 1].h <= h) i++;
    const a = TABLE[i], b = TABLE[i + 1], k = Math.max(0, Math.min(1, (h - a.h) / (b.h - a.h)));
    const sunT = h > 5.8 && h < 18.7 ? (h - 5.8) / 12.9 : null; // 0 nasce, 1 se põe
    const mh = h < 12 ? h + 24 : h, moonT = mh > 18.8 && mh < 29.6 ? (mh - 18.8) / 10.8 : null;
    return { h, top: mix(a.top, b.top, k), bot: mix(a.bot, b.bot, k), amb: mix(a.amb, b.amb, k), sun: mix(a.sun, b.sun, k), night: a.night + (b.night - a.night) * k, sunT, moonT };
  }
  function next() {
    const i = MODES.findIndex((m) => m.id === mode); mode = MODES[(i + 1) % MODES.length].id;
    try { localStorage.setItem(KEY, mode); } catch (e) {}
    listeners.forEach((fn) => { try { fn(mode); } catch (e) {} });
    return mode;
  }
  window.DayTime = Object.freeze({
    hour, state, next, mode: () => mode, label: () => current().label, describe: () => current().text,
    onChange: (fn) => { if (typeof fn === 'function') listeners.push(fn); },
    // Usado por testes e cutscenes: trava uma hora (null devolve o controle ao modo escolhido).
    force: (h) => { forced = h === null || h === undefined ? null : ((Number(h) % 24) + 24) % 24; }
  });
})();
