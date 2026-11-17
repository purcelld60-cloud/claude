/* Controle no celular (Fase 8): entra na sala da TV e manda direcional, A e B.
   Abre pelo QR code da TV (controle.html?sala=CODIGO) ou digitando o código.
   Conecta no WebSocket do mesmo endereço (o app da Android TV ou o servidor online). */
(() => {
  'use strict';
  const $ = (id) => document.getElementById(id);
  const AV = ['daroca', 'reeis', 'lucas', 'nikolas', 'aica', 'ravile', 'freddy', 'dede', 'caleb', 'mota', 'menezes', 'nicolas', 'rayssa', 'allef'];
  const NOMES = { daroca: 'Da Roça', reeis: 'Reeis', lucas: 'Lucas', nikolas: 'Nikolas', aica: 'Aica', ravile: 'Ravile', freddy: 'Freddy', dede: 'Dedé', caleb: 'Caleb', mota: 'Mota', menezes: 'Menezes', nicolas: 'Nicolas', rayssa: 'Rayssa', allef: 'Allef' };
  const q = new URLSearchParams(location.search);
  let ws = null, token = null, code = (q.get('sala') || '').toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 6), avatar = localStorage.getItem('daroca-controle-avatar') || 'daroca', me = null, seq = 0, tries = 0, joined = false;
  const input = { x: 0, y: 0, a: false, b: false }; let lastSent = '', lastAt = 0;
  $('codigo').value = code; $('nome').value = localStorage.getItem('daroca-controle-nome') || '';
  const vibe = (ms) => { try { navigator.vibrate?.(ms); } catch (e) {} };
  function show(id) { for (const s of ['entrar', 'controle', 'escolher']) $(s).hidden = s !== id; }
  function status(t) { $('status').textContent = t; }
  // ---- conexão
  function wsUrl() { return location.origin.replace(/^http/, 'ws') + '/ws'; }
  function connect() {
    try { ws = new WebSocket(wsUrl()); } catch (e) { return retry(); }
    ws.onopen = () => { tries = 0; ws.send(JSON.stringify({ t: 'hello', name: $('nome').value.trim() || 'Celular', avatar, token: token || undefined })); };
    ws.onmessage = (ev) => { let m; try { m = JSON.parse(ev.data); } catch (e) { return; }
      if (m.t === 'welcome') { const reconnect = !!token && joined; token = m.token; me = m.id; if (!reconnect) ws.send(JSON.stringify({ t: 'join', code })); status('Conectado'); }
      else if (m.t === 'room') { joined = true; show($('escolher').hidden ? 'controle' : 'escolher'); if (!m.players.some((p) => p.id === m.hostId && p.online)) status('A TV saiu do ar… esperando'); }
      else if (m.t === 'event' && m.e) { const e = m.e;
        if (e.kind === 'you' && e.to === me) { $('eu').textContent = 'P' + e.n; document.documentElement.style.setProperty('--p', e.color); if (e.avatar) { avatar = e.avatar; } vibe(30); }
        else if (e.kind === 'buzz') vibe(e.ms);
        else if (e.kind === 'status') status(e.text); }
      else if (m.t === 'error') { if (!joined) { show('entrar'); $('aviso').textContent = m.m; ws.close(); ws = null; } else status(m.m); } };
    ws.onclose = () => { if (joined) { status('Reconectando…'); retry(); } };
  }
  function retry() { if (++tries > 20) { status('Sem conexão com a TV.'); return; } setTimeout(connect, Math.min(4000, 300 * tries)); }
  function send() { if (!ws || ws.readyState !== 1 || !joined) return; const k = JSON.stringify(input), now = performance.now(); if (k === lastSent && now - lastAt < 200) return; lastSent = k; lastAt = now; ws.send(JSON.stringify({ t: 'input', s: ++seq, i: input })); }
  setInterval(send, 100);
  // ---- entrar
  $('codigo').addEventListener('input', () => { $('codigo').value = $('codigo').value.toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 6); });
  $('formEntrar').addEventListener('submit', (e) => { e.preventDefault(); code = $('codigo').value; if (code.length !== 6) { $('aviso').textContent = 'O código tem 6 letras e números.'; return; } localStorage.setItem('daroca-controle-nome', $('nome').value.trim()); $('aviso').textContent = ''; show('controle'); status('Entrando na sala ' + code + '…'); connect(); wake(); });
  // ---- direcional: arraste dentro do círculo (8 direções)
  const pad = $('dpad'), bola = $('bola'); let padId = null;
  function padAt(ev) { const r = pad.getBoundingClientRect(), dx = (ev.clientX - r.left) / r.width - .5, dy = (ev.clientY - r.top) / r.height - .5, d = Math.hypot(dx, dy);
    const x = d < .12 ? 0 : Math.abs(dx) / d > .38 ? Math.sign(dx) : 0, y = d < .12 ? 0 : Math.abs(dy) / d > .38 ? Math.sign(dy) : 0;
    if (x !== input.x || y !== input.y) { input.x = x; input.y = y; vibe(8); send(); } const k = Math.min(1, d / .5); bola.style.transform = `translate(${dx / Math.max(d, .001) * k * 60}%,${dy / Math.max(d, .001) * k * 60}%)`; marks(); }
  function padEnd() { padId = null; input.x = 0; input.y = 0; bola.style.transform = ''; marks(); send(); }
  function marks() { pad.querySelector('.s-u').classList.toggle('on', input.y < 0); pad.querySelector('.s-d').classList.toggle('on', input.y > 0); pad.querySelector('.s-l').classList.toggle('on', input.x < 0); pad.querySelector('.s-r').classList.toggle('on', input.x > 0); }
  pad.addEventListener('pointerdown', (e) => { e.preventDefault(); padId = e.pointerId; pad.setPointerCapture(e.pointerId); padAt(e); });
  pad.addEventListener('pointermove', (e) => { if (e.pointerId === padId) padAt(e); });
  pad.addEventListener('pointerup', padEnd); pad.addEventListener('pointercancel', padEnd);
  // ---- botões A e B
  for (const [id, key] of [['btnA', 'a'], ['btnB', 'b']]) { const b = $(id);
    const on = (e) => { e.preventDefault(); b.classList.add('on'); input[key] = true; vibe(15); send(); try { b.setPointerCapture(e.pointerId); } catch (x) {} };
    const off = () => { b.classList.remove('on'); input[key] = false; send(); };
    b.addEventListener('pointerdown', on); b.addEventListener('pointerup', off); b.addEventListener('pointercancel', off); }
  // teclado (para testar no computador): setas/WASD, J/Espaço = A, K = B
  const keymap = { ArrowLeft: ['x', -1], KeyA: ['x', -1], ArrowRight: ['x', 1], KeyD: ['x', 1], ArrowUp: ['y', -1], KeyW: ['y', -1], ArrowDown: ['y', 1], KeyS: ['y', 1] };
  addEventListener('keydown', (e) => { if (e.target.tagName === 'INPUT') return; const k = keymap[e.code]; if (k) input[k[0]] = k[1]; if (e.code === 'KeyJ' || e.code === 'Space') input.a = true; if (e.code === 'KeyK') input.b = true; send(); });
  addEventListener('keyup', (e) => { const k = keymap[e.code]; if (k && input[k[0]] === k[1]) input[k[0]] = 0; if (e.code === 'KeyJ' || e.code === 'Space') input.a = false; if (e.code === 'KeyK') input.b = false; send(); });
  // ---- personagem
  function lista() {
    const box = $('lista'); box.innerHTML = '';
    for (const a of AV) { const b = document.createElement('button'); b.type = 'button'; b.className = a === avatar ? 'on' : ''; const c = document.createElement('canvas'); c.width = 72; c.height = 96;
      try { const x = c.getContext('2d'); x.imageSmoothingEnabled = false; window.Art?.drawCharacter?.(x, a, 36, 90, { scale: 1, frame: 0, look: false }); } catch (e) {}
      b.append(c, document.createTextNode(NOMES[a])); b.addEventListener('click', () => { avatar = a; localStorage.setItem('daroca-controle-avatar', a); vibe(20); if (ws?.readyState === 1) ws.send(JSON.stringify({ t: 'event', e: { kind: 'pick', avatar: a } })); lista(); }); box.append(b); }
  }
  $('trocar').addEventListener('click', () => { lista(); show('escolher'); });
  $('voltar').addEventListener('click', () => show('controle'));
  // tela sempre acesa durante o jogo
  let lock = null; async function wake() { try { lock = await navigator.wakeLock?.request('screen'); } catch (e) {} }
  document.addEventListener('visibilitychange', () => { if (document.visibilityState === 'visible' && joined) wake(); });
  addEventListener('contextmenu', (e) => e.preventDefault());
  if (code.length === 6 && localStorage.getItem('daroca-controle-nome') !== null) { /* veio do QR: pede só o nome se quiser */ }
  $('codigo').value = code; if (code.length === 6) $('nome').focus();
})();
