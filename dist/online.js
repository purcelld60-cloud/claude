/* Endereço do servidor online (Fase 7).
   O jogo procura o servidor nesta ordem:
   1. o próprio endereço do site (quando o jogo é aberto pelo servidor, tudo já funciona);
   2. ?servidor=https://... no endereço (fica salvo neste aparelho);
   3. o arquivo servidor.json ({"url": "https://..."}), que você edita depois do deploy, sem mexer em código.
   Com o endereço definido, os pedidos da Arena online e da Dupla online (/api/arena/...) vão para ele,
   e o Fliperama online usa o WebSocket em /ws. Veja docs/SERVIDOR-ONLINE.md. */
(() => {
  'use strict';
  if (window.DarocaOnline) return;
  const KEY = 'daroca-servidor';
  const norm = (u) => { try { const x = new URL(String(u || '').trim()); return /^https?:$/.test(x.protocol) ? x.origin : ''; } catch (e) { return ''; } };
  let base = null, configured = '', sameOrigin = false;
  try { const q = new URLSearchParams(location.search).get('servidor'); if (q !== null) { const n = norm(q); if (n) localStorage.setItem(KEY, n); else localStorage.removeItem(KEY); } configured = localStorage.getItem(KEY) || ''; } catch (e) {}
  const withTimeout = (p, ms) => Promise.race([p, new Promise((_, r) => setTimeout(() => r(new Error('tempo')), ms))]);
  const origFetch = window.fetch.bind(window);
  async function probe(origin) { try { const r = await withTimeout(origFetch(origin + '/api/health', { cache: 'no-store' }), 2500); if (!r.ok) return false; const j = await r.json(); return j && j.server === 'daroca'; } catch (e) { return false; } }
  const ready = (async () => {
    if (/^https?:$/.test(location.protocol) && await probe('')) { sameOrigin = true; base = ''; return base; }
    if (!configured) { try { const r = await withTimeout(origFetch('servidor.json', { cache: 'no-cache' }), 2500); if (r.ok) configured = norm((await r.json()).url); } catch (e) {} }
    base = configured || ''; return base;
  })();
  // pedidos da Arena e da Dupla online vão para o servidor configurado
  window.fetch = function (input, init) {
    if (typeof input === 'string' && input.startsWith('/api/arena') && base) { input = base + input; init = { ...(init || {}), mode: 'cors', credentials: 'omit' }; }
    return origFetch(input, init);
  };
  function wsUrl() { const b = base === '' && sameOrigin ? location.origin : base; if (!b) return ''; return b.replace(/^http/, 'ws') + '/ws'; }
  function set(url) { const n = norm(url); try { if (n) localStorage.setItem(KEY, n); else localStorage.removeItem(KEY); } catch (e) {} configured = n; base = sameOrigin ? '' : n; return n; }

  /* Cliente WebSocket com reconexão automática (mesma vaga por 60 s) e medida de ping. */
  function connect(opts = {}) {
    const handlers = {}, on = (t, fn) => { (handlers[t] = handlers[t] || []).push(fn); return api; }, emit = (t, m) => (handlers[t] || []).forEach((fn) => { try { fn(m); } catch (e) { console.error(e); } });
    let ws = null, tok = null, closed = false, tries = 0, pingT = 0, ping = null, timer = 0, pending = [];
    const api = { on, send, close, kick, get ping() { return ping; }, get online() { return !!ws && ws.readyState === 1; }, id: null };
    function send(m) { if (ws && ws.readyState === 1) { ws.send(JSON.stringify(m)); return true; } if (m.t !== 'input' && m.t !== 'state' && m.t !== 'ping') pending.push(m); return false; }
    function open() {
      const url = wsUrl(); if (!url) { emit('error', { m: 'Nenhum servidor online configurado. Veja como em docs/SERVIDOR-ONLINE.md.', fatal: true }); return; }
      try { ws = new WebSocket(url); } catch (e) { return retry(); }
      ws.onopen = () => { tries = 0; ws.send(JSON.stringify({ t: 'hello', v: 1, name: opts.name || 'Jogador', avatar: opts.avatar, token: tok || undefined })); emit('status', { online: true }); clearInterval(pingT); pingT = setInterval(() => send({ t: 'ping', c: performance.now() }), 2000); };
      ws.onmessage = (ev) => { let m; try { m = JSON.parse(ev.data); } catch (e) { return; } if (m.t === 'welcome') { tok = m.token; api.id = m.id; const q = pending; pending = []; q.forEach(send); } if (m.t === 'pong') ping = Math.round(ping === null ? performance.now() - m.c : ping * .7 + (performance.now() - m.c) * .3); emit(m.t, m); };
      ws.onclose = () => { clearInterval(pingT); emit('status', { online: false }); if (!closed) retry(); };
      ws.onerror = () => {};
    }
    function retry() { if (closed) return; tries++; if (tries > 12) { emit('error', { m: 'Não deu para falar com o servidor. Confira a internet.', fatal: true }); return; } clearTimeout(timer); timer = setTimeout(open, Math.min(8000, 400 * 2 ** Math.min(tries, 5))); }
    function kick() { try { ws?.close(); } catch (e) {} } // força reconectar (a vaga na sala continua guardada)
    function close() { closed = true; clearTimeout(timer); clearInterval(pingT); try { if (ws && ws.readyState === 1) ws.send(JSON.stringify({ t: 'leave' })); ws?.close(); } catch (e) {} }
    ready.then(open);
    return api;
  }
  // Botão SALA RÁPIDA na Arena online: entra numa sala aberta (ou cria uma, se não houver)
  setInterval(() => {
    const join = document.getElementById('arenaJoin'), create = document.getElementById('arenaCreate'), codeIn = document.getElementById('arenaCode');
    if (!join || !create || !codeIn || document.getElementById('arenaQuick')) return;
    const b = document.createElement('button'); b.type = 'button'; b.id = 'arenaQuick'; b.className = join.className; b.textContent = 'SALA RÁPIDA';
    b.addEventListener('click', async () => { b.disabled = true; try { await ready; const r = await fetch('/api/arena/rooms/quick', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ find: true, mode: 'arena', protocol: 3 }) }); const j = await r.json(); if (j.code) { codeIn.value = j.code; codeIn.dispatchEvent(new Event('input', { bubbles: true })); join.click(); } else create.click(); } catch (e) { create.click(); } b.disabled = false; });
    join.after(b);
  }, 1000);
  window.DarocaOnline = Object.freeze({ ready, base: () => base, configured: () => configured, sameOrigin: () => sameOrigin, wsUrl, set, connect, hasServer: () => !!(base || sameOrigin) });
})();
