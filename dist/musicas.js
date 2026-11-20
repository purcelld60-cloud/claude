/* Pasta de músicas (Fase 9): coloque arquivos .mp3, .ogg ou .m4a em dist/musicas/ e diga onde
   cada um toca em dist/musicas/musicas.txt, uma linha por lugar:
       roca = tema-da-roca.mp3
       chefe-marco = batalha.ogg volume=0.8 fade=2
   Atalho sem editar nada: um arquivo com o nome do lugar (por exemplo "roca.mp3" ou
   "chefe-marco.ogg") já toca nesse lugar. A lista de arquivos (lista.json e lista.js) é gerada
   sozinha nos builds do GitHub (.github/scripts/musicas.py). Guia completo: docs/MUSICAS.md. */
(() => {
  'use strict';
  if (window.DarocaMusicas) return;
  const EXT = /\.(mp3|ogg|m4a|wav)$/i;
  const slug = (s) => String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/\.[a-z0-9]+$/, '').replace(/[^a-z0-9.]+/g, '-').replace(/^-+|-+$/g, '');
  // nome amigável -> lugar do jogo (contexto do tocador de música)
  const PLACES = {
    menu: 'menu.title', inicio: 'menu.title', pausa: 'menu.pause', derrota: 'events.defeat', fim: 'events.chapter_end', 'fim-do-capitulo': 'events.chapter_end', comemoracao: 'events.celebration', 'transformacao-reeis': 'events.reeis_transform',
    roca: 'maps.roca', escola: 'maps.escola', academia: 'maps.academia', quadra: 'maps.quadra', praca: 'maps.camacan', camacan: 'maps.camacan', favela: 'maps.favela', caderno: 'maps.caderno', tinta: 'maps.caderno', 'reino-de-tinta': 'maps.caderno', campo: 'maps.campo', bigodon: 'maps.bigodon', patio: 'maps.patio', rayssa: 'maps.rayssa', 'casa-da-rayssa': 'maps.rayssa', baile: 'maps.baile',
    'jantar-amanda': 'activity.dinner', 'sala-almiro': 'rooms.almiro', 'sala-miqueias': 'rooms.miqueias',
    arena: 'arena.battle', 'arena-menu': 'arena.menu', 'arena-resultado': 'arena.results',
    fliperama: 'minigames.fliperama', dupla: 'coop.menu', 'dupla-menu': 'coop.menu'
  };
  const BOSS = { marco: 'marco', menezes: 'menezes', nikolas: 'nikolas', reeis: 'reeisBoss', freddy: 'freddy', nicolas: 'nicolas', dede: 'dede', arthur: 'arthur', colosso: 'giant', gigante: 'giant', giant: 'giant', igor: 'igor', kaique: 'kaique', ollyan: 'ollyan' };
  const AMBIENT = ['roca', 'escola', 'academia', 'quadra', 'praca', 'favela', 'caderno', 'campo', 'bigodon', 'patio', 'rayssa'];
  function placeOf(key) {
    const k = slug(key); if (!k) return null;
    if (k.includes('.')) return /^[a-zA-Z0-9_.-]{1,90}$/.test(key.trim()) ? key.trim() : null; // contexto direto, ex.: battles.marco.phase2
    if (PLACES[k]) return PLACES[k];
    let m;
    if ((m = k.match(/^chefe-([a-z]+)(?:-fase-?(\d))?$/)) && BOSS[m[1]]) return 'battles.' + BOSS[m[1]] + (m[2] ? '.phase' + m[2] : '');
    if ((m = k.match(/^apresentacao-([a-z]+)$/)) && BOSS[m[1]]) return 'events.boss_' + (m[1] === 'reeis' ? 'reeis' : BOSS[m[1]]);
    if ((m = k.match(/^cutscene-([a-z0-9_-]+)$/))) return 'cutscenes.' + m[1].replace(/-/g, '_');
    if ((m = k.match(/^conversa-([a-z]+)$/))) return 'characters.' + m[1];
    if ((m = k.match(/^fliperama-([a-z]+)$/))) return 'minigames.fliperama.' + m[1];
    if ((m = k.match(/^minigame-([a-z]+)$/))) return 'activities.' + m[1];
    if ((m = k.match(/^evento-([a-z0-9_-]+)$/))) return 'events.' + m[1].replace(/-/g, '_');
    if ((m = k.match(/^dupla-([a-z]+)$/)) && BOSS[m[1]]) return 'coop.' + BOSS[m[1]];
    return null;
  }
  // "lugar = arquivo.mp3 volume=0.8 fade=2 inicio=10 atraso=1 sem-repetir"
  function parseTxt(text) {
    const lines = [], warnings = [], ambient = {};
    String(text || '').split(/\r?\n/).forEach((raw, n) => {
      const line = raw.replace(/#.*$/, '').trim(); if (!line) return;
      const eq = line.indexOf('='); if (eq < 0) { warnings.push('linha ' + (n + 1) + ': falta o "="'); return; }
      const key = line.slice(0, eq).trim(), rest = line.slice(eq + 1).trim();
      const fm = rest.match(/^(.+?\.(?:mp3|ogg|m4a|wav))(?:\s+(.*))?$/i); if (!fm) { warnings.push('linha ' + (n + 1) + ': escreva o nome do arquivo com .mp3, .ogg ou .m4a'); return; }
      const file = fm[1].trim().replace(/^\.?\/?(dist\/)?musicas\//, ''), opts = {};
      for (const tok of (fm[2] || '').split(/\s+/).filter(Boolean)) { const [k, v] = tok.toLowerCase().split('='); if (k === 'volume') opts.volume = Math.max(0, Math.min(1, +v)); else if (k === 'fade') opts.fadeMs = Math.max(0, Math.min(10, +v)) * 1000; else if (k === 'inicio') opts.startSeconds = Math.max(0, +v); else if (k === 'atraso') opts.delaySeconds = Math.max(0, +v); else if (k === 'sem-repetir') opts.loop = false; else if (k === 'repetir') opts.loop = true; }
      const s = slug(key);
      if (s.startsWith('ambiente-')) { const where = s.slice(9) === 'camacan' ? 'praca' : s.slice(9) === 'tinta' ? 'caderno' : s.slice(9); if (AMBIENT.includes(where)) ambient[where] = 'musicas/' + file; else warnings.push('linha ' + (n + 1) + ': lugar de ambiente desconhecido "' + key + '"'); return; }
      const place = placeOf(key); if (!place) { warnings.push('linha ' + (n + 1) + ': lugar desconhecido "' + key + '"'); return; }
      lines.push({ place, file, opts });
    });
    return { lines, warnings, ambient };
  }
  let ambientMap = {}, lastWarnings = [], loaded = null;
  async function getText(url) { try { const r = await fetch(url, { cache: 'no-cache' }); return r.ok ? await r.text() : null; } catch (e) { return null; } }
  // Monta faixas e lugares no formato do tocador (music-player.js).
  function load() {
    if (loaded) return loaded;
    loaded = (async () => {
      const pre = window.DAROCA_MUSICAS || null; // lista.js (funciona até sem servidor, no app do iPhone)
      let list = null, txt = null;
      const lj = await getText('musicas/lista.json'); if (lj) { try { list = JSON.parse(lj); } catch (e) {} }
      txt = await getText('musicas/musicas.txt');
      if (!list && pre) list = pre; if (txt === null && pre) txt = pre.txt || '';
      const files = (list?.arquivos || []).filter((f) => f && typeof f.nome === 'string' && EXT.test(f.nome) && !/[\\/]|\.\./.test(f.nome));
      const parsed = parseTxt(txt || ''); ambientMap = parsed.ambient; lastWarnings = parsed.warnings.concat(list?.avisos || []);
      const tracks = [], bindings = {}, byName = new Map();
      const track = (name, meta = {}) => { if (byName.has(name)) return byName.get(name); const id = 'm-' + slug(name).replace(/\./g, '-').slice(0, 60) + '-' + (tracks.length + 1); const t = { id, title: name.replace(EXT, ''), categoryId: 'pasta', file: 'musicas/' + name, sha256: '', bytes: +meta.bytes || 0, duration: +meta.duracao || 0, volume: 1, loop: true, fadeMs: 1200, url: 'musicas/' + encodeURI(name), local: true }; tracks.push(t); byName.set(name, t); return t; };
      // atalho: arquivo com o nome do lugar
      for (const f of files) { const place = placeOf(f.nome.replace(EXT, '')); if (place) bindings[place] = { trackId: track(f.nome, f).id, enabled: true }; }
      // musicas.txt manda mais que o atalho
      for (const l of parsed.lines) { const meta = files.find((f) => f.nome === l.file); if (!meta && files.length) lastWarnings.push('arquivo não encontrado na pasta: ' + l.file); const t = track(l.file, meta || {}); bindings[l.place] = { trackId: t.id, enabled: true, ...l.opts }; }
      if (lastWarnings.length) try { console.warn('Músicas:', lastWarnings.join(' · ')); } catch (e) {}
      return { tracks, bindings, warnings: lastWarnings };
    })();
    return loaded;
  }
  window.DarocaMusicas = Object.freeze({ load, reload: () => { loaded = null; return load(); }, ambient: () => ({ ...ambientMap }), warnings: () => lastWarnings.slice(), placeOf, parse: parseTxt });
})();
