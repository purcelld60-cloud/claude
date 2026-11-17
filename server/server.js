/* Servidor online do Da Roça Adventure (Fase 7).
   Um único processo Node.js que:
   1. serve o jogo (pasta ../dist), então quem abre o endereço do servidor já joga online;
   2. atende a API de salas que a Arena online (2 a 4 jogadores) e a Dupla online (chefes em
      dupla) já usam: /api/arena/rooms, /join, /sync, /leave, /signal e /quick (sala rápida);
   3. abre um WebSocket em /ws para o Fliperama online (salas com código, sala rápida,
      reconexão) e para o modo TV com celular como controle (Fase 8).
   Tudo fica na memória: salas vazias somem sozinhas. Sem banco de dados.
   Proteções: código de sala aleatório, token secreto por jogador, só o anfitrião manda o estado
   do jogo, limite de tamanho e de mensagens por segundo, nomes e entradas conferidos.
   Variáveis de ambiente (opcionais): PORT (padrão 8080), DIST (pasta do jogo),
   ALLOWED_ORIGINS (lista separada por vírgula; padrão: qualquer origem). */
'use strict';
const http = require('http'), fs = require('fs'), path = require('path'), crypto = require('crypto');
const { WebSocketServer } = require('ws');

const PORT = Number(process.env.PORT) || 8080;
const DIST = path.resolve(process.env.DIST || path.join(__dirname, '..', 'dist'));
const ORIGINS = (process.env.ALLOWED_ORIGINS || '*').split(',').map((s) => s.trim()).filter(Boolean);
const CODE_CHARS = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
const now = () => Date.now();
const token = () => crypto.randomBytes(24).toString('base64url');
const cleanName = (v, d = 'Convidado') => String(v || '').replace(/[<>\u0000-\u001f\u007f]/g, '').trim().slice(0, 20) || d;
const cleanChar = (v) => (typeof v === 'string' && /^[a-zA-Z]{2,20}$/.test(v) ? v : 'daroca');
const log = (...a) => console.log(new Date().toISOString(), ...a);

/* ---------------- limites (proteção básica) ---------------- */
const buckets = new Map();
function allow(key, perSecond, burst) {
  const t = now(), b = buckets.get(key) || { tokens: burst, at: t };
  b.tokens = Math.min(burst, b.tokens + (t - b.at) / 1000 * perSecond); b.at = t;
  if (b.tokens < 1) { buckets.set(key, b); return false; }
  b.tokens -= 1; buckets.set(key, b); return true;
}
setInterval(() => { const t = now(); for (const [k, b] of buckets) if (t - b.at > 60000) buckets.delete(k); }, 30000).unref();

function newCode(taken) { for (let i = 0; i < 1000; i++) { let c = ''; for (let k = 0; k < 6; k++) c += CODE_CHARS[crypto.randomInt(CODE_CHARS.length)]; if (!taken.has(c)) return c; } throw new Error('sem códigos livres'); }

/* ================= 1. API de salas da Arena e da Dupla online ================= */
const rooms = new Map(); // code -> room
const ONLINE_MS = 8000, HOST_SWAP_MS = 45000, PLAYER_TTL = 10 * 60000, ROOM_TTL = 30 * 60000;
function validInput(v) {
  if (!v || typeof v !== 'object' || Array.isArray(v)) return false;
  const seq = (n) => Number.isSafeInteger(n) && n >= 0 && n <= 2147483647;
  if (!seq(v.seq)) return false;
  for (const [k, x] of Object.entries(v)) {
    if (k === 'x' || k === 'y') { if (typeof x !== 'number' || !Number.isFinite(x) || Math.abs(x) > 1) return false; }
    else if (k === 'response') { if (typeof x !== 'number' || !Number.isFinite(x) || x < .5 || x > 2) return false; }
    else if (k === 'jump') { if (typeof x !== 'boolean') return false; }
    else if (k === 'aim') { if (!Number.isInteger(x) || x < 0 || x > 4) return false; }
    else if (!['seq', 'jumpPress', 'attack', 'special', 'ultimate', 'dash', 'emote'].includes(k) || !seq(x)) return false;
  }
  return true;
}
function publicRoom(r) {
  const t = now(), host = r.players.find((p) => p.id === r.hostPlayerId);
  return { code: r.code, status: r.status, mode: r.mode, protocol: r.protocol, capacity: r.capacity, hostPlayerId: r.hostPlayerId, hostConnected: !!host && t - host.seen < ONLINE_MS,
    players: r.players.map((p) => ({ id: p.id, name: p.name, character: p.character, ready: p.ready, connected: t - p.seen < ONLINE_MS, isHost: p.id === r.hostPlayerId })) };
}
function reply(r, p, extra = {}) {
  return { room: publicRoom(r), isHost: p.id === r.hostPlayerId, playerId: p.id, state: r.state, inputs: r.players.filter((q) => q.input).map((q) => ({ playerId: q.id, seq: q.input.seq, input: q.input, updatedAt: q.inputAt })), serverTime: now(), ...extra };
}
function addPlayer(r, body) {
  const p = { id: 'p' + crypto.randomBytes(5).toString('hex'), token: token(), name: cleanName(body.name, 'Da Resenha'), character: cleanChar(body.character), ready: false, seen: now(), input: null, inputAt: 0 };
  r.players.push(p); r.touched = now(); return p;
}
function createRoom(body) {
  const mode = body.mode === 'coop' ? 'coop' : 'arena', cap = Math.max(2, Math.min(mode === 'coop' ? 2 : 4, Number(body.capacity) || (mode === 'coop' ? 2 : 4)));
  const r = { code: newCode(rooms), mode, protocol: Number(body.protocol) || 1, capacity: cap, status: 'lobby', players: [], hostPlayerId: null, state: null, stateSeq: -1, signals: [], signalSeq: 0, touched: now(), created: now() };
  const p = addPlayer(r, body); r.hostPlayerId = p.id; rooms.set(r.code, r); log('sala', r.mode, r.code, 'criada');
  return { r, p };
}
function auth(req, r) { const h = req.headers.authorization || '', t = h.startsWith('Bearer ') ? h.slice(7) : ''; return t && r.players.find((p) => p.token.length === t.length && crypto.timingSafeEqual(Buffer.from(p.token), Buffer.from(t))); }
function maybeSwapHost(r) {
  const t = now(), host = r.players.find((p) => p.id === r.hostPlayerId);
  if (host && t - host.seen < HOST_SWAP_MS) return;
  const next = r.players.filter((p) => t - p.seen < ONLINE_MS).sort((a, b) => a.seen - b.seen)[0];
  if (next && next.id !== r.hostPlayerId) { r.hostPlayerId = next.id; log('sala', r.code, 'novo anfitrião'); }
}
async function arenaApi(req, res, url, ip) {
  const parts = url.pathname.split('/').filter(Boolean); // api arena rooms [CODE] [op]
  if (req.method !== 'POST') return send(res, 405, { error: 'Use POST.' });
  if (!allow('http:' + ip, 25, 60)) return send(res, 429, { error: 'Calma! Muitos pedidos ao mesmo tempo.' });
  const body = await readJson(req, 65536); if (body === null) return send(res, 413, { error: 'Pedido grande demais ou inválido.' });
  if (parts.length === 3) { if (rooms.size > 2000) return send(res, 503, { error: 'Servidor cheio. Tente daqui a pouco.' }); const { r, p } = createRoom(body); return send(res, 200, reply(r, p, { token: p.token })); }
  if (parts[3] === 'quick') { // sala rápida: entra numa sala aberta ou cria uma
    const mode = body.mode === 'coop' ? 'coop' : 'arena', t = now();
    const open = [...rooms.values()].find((r) => r.mode === mode && r.status === 'lobby' && r.open !== false && r.players.length < r.capacity && r.players.some((q) => t - q.seen < ONLINE_MS) && (Number(body.protocol) || 1) === r.protocol);
    if (body.find) return send(res, 200, { code: open ? open.code : null });
    if (open) { const p = addPlayer(open, body); return send(res, 200, reply(open, p, { token: p.token, quick: 'joined' })); }
    const { r, p } = createRoom(body); return send(res, 200, reply(r, p, { token: p.token, quick: 'created' }));
  }
  const code = String(parts[3] || '').toUpperCase(), op = parts[4], r = rooms.get(code);
  if (!/^[A-Z0-9]{6}$/.test(code) || !r) return send(res, 404, { error: 'Sala não encontrada. Confira o código.' });
  if (op === 'join') {
    if (r.status !== 'lobby') return send(res, 409, { error: 'A partida dessa sala já começou.' });
    const t = now(); r.players = r.players.filter((p) => t - p.seen < PLAYER_TTL);
    if (r.players.length >= r.capacity) return send(res, 409, { error: 'A sala está cheia.' });
    if (body.mode && (body.mode === 'coop') !== (r.mode === 'coop')) return send(res, 409, { error: 'Esse código é de outro modo de jogo.' });
    const p = addPlayer(r, body); log('sala', r.code, 'entrou', p.name); return send(res, 200, reply(r, p, { token: p.token }));
  }
  const p = auth(req, r); if (!p) return send(res, 401, { error: 'Entrada expirada. Entre de novo na sala.' });
  p.seen = now(); r.touched = now(); maybeSwapHost(r);
  if (op === 'leave') { r.players = r.players.filter((q) => q !== p); if (!r.players.length) rooms.delete(r.code); else if (r.hostPlayerId === p.id) r.hostPlayerId = r.players[0].id; return send(res, 200, { ok: true }); }
  if (op === 'sync') {
    if (body.input !== undefined) { if (!validInput(body.input)) return send(res, 400, { error: 'Comando inválido.' }); if (!p.input || body.input.seq > p.input.seq) { p.input = body.input; p.inputAt = now(); } }
    if (typeof body.character === 'string' && r.status === 'lobby') p.character = cleanChar(body.character);
    if (typeof body.ready === 'boolean') p.ready = body.ready;
    if (p.id === r.hostPlayerId) {
      if (body.state && typeof body.state === 'object') { const seq = Number(body.state.seq); if (!Number.isFinite(seq) || seq >= r.stateSeq || body.state.matchId !== r.state?.matchId) { r.state = body.state; r.stateSeq = Number.isFinite(seq) ? seq : r.stateSeq; } }
      if (['lobby', 'playing', 'finished'].includes(body.status)) { if (body.status === 'lobby' && r.status !== 'lobby') { r.players.forEach((q) => (q.ready = false)); } r.status = body.status; }
    }
    return send(res, 200, reply(r, p));
  }
  if (op === 'signal') { // sinalização para conexão direta (WebRTC) entre os aparelhos
    if (!allow('sig:' + p.id, 20, 60)) return send(res, 429, { error: 'Muitos sinais.' });
    if (body.op === 'send') { if (!r.players.some((q) => q.id === body.to) || typeof body.kind !== 'string' || JSON.stringify(body.data || null).length > 32000) return send(res, 400, { error: 'Sinal inválido.' });
      r.signals.push({ id: ++r.signalSeq, from: p.id, to: body.to, kind: body.kind.slice(0, 20), data: body.data, nonce: body.nonce, at: now() }); if (r.signals.length > 300) r.signals.splice(0, r.signals.length - 300); return send(res, 200, { ok: true, cursor: r.signalSeq }); }
    const after = Number(body.after) || 0; return send(res, 200, { signals: r.signals.filter((s) => s.id > after && s.to === p.id), cursor: r.signalSeq });
  }
  return send(res, 404, { error: 'Caminho desconhecido.' });
}
setInterval(() => { const t = now(); for (const [c, r] of rooms) { r.players = r.players.filter((p) => t - p.seen < PLAYER_TTL); if (!r.players.length || t - r.touched > ROOM_TTL) rooms.delete(c); else { maybeSwapHost(r); r.signals = r.signals.filter((s) => t - s.at < 60000); } } }, 15000).unref();

/* ================= 2. WebSocket: Fliperama online e TV com celular ================= */
// Mensagens em JSON com campo t. Sala: 1 anfitrião (roda o jogo) + até 7 convidados (mandam comandos).
// cliente -> servidor: hello {name, avatar, token?} · create {kind, cap} · join {code} · quick {kind} · leave
//                      input {s, i} (convidado) · state {s, d} (anfitrião) · event {e} (anfitrião) · ping {c}
// servidor -> cliente: welcome {id, token} · room {...} · input {from, s, i} · state {s, d} · event {e} · pong {c, s} · error {m}
const wsRooms = new Map(), sessions = new Map(); // token -> sessão (para reconectar)
const KINDS = new Set(['fliperama', 'tv']);
function wsRoomInfo(r) { return { t: 'room', code: r.code, kind: r.kind, cap: r.cap, hostId: r.hostId, players: r.seats.map((s) => ({ id: s.id, name: s.name, avatar: s.avatar, online: !!s.ws, slot: s.slot })) }; }
function broadcast(r, msg, except) { const text = JSON.stringify(msg); for (const s of r.seats) if (s.ws && s !== except && s.ws.readyState === 1) s.ws.send(text); }
function sendTo(s, msg) { if (s?.ws && s.ws.readyState === 1) s.ws.send(JSON.stringify(msg)); }
function leaveWsRoom(s) {
  const r = s.room && wsRooms.get(s.room); s.room = null; if (!r) return;
  r.seats = r.seats.filter((x) => x !== s);
  if (!r.seats.length) { wsRooms.delete(r.code); return; }
  if (r.hostId === s.id) { broadcast(r, { t: 'error', m: 'O anfitrião saiu da sala.', end: true }); for (const x of r.seats) x.room = null; wsRooms.delete(r.code); return; }
  broadcast(r, wsRoomInfo(r));
}
function joinWsRoom(s, r) {
  if (r.seats.length >= r.cap) return sendTo(s, { t: 'error', m: 'A sala está cheia.' });
  leaveWsRoom(s); const used = new Set(r.seats.map((x) => x.slot)); let slot = 0; while (used.has(slot)) slot++;
  s.slot = slot; s.room = r.code; r.seats.push(s); r.touched = now(); broadcast(r, wsRoomInfo(r));
}
const wss = new WebSocketServer({ noServer: true, maxPayload: 256 * 1024 });
wss.on('connection', (ws, req, ip) => {
  let s = null; ws.isAlive = true; ws.on('pong', () => { ws.isAlive = true; });
  ws.on('message', (raw) => {
    if (!allow('ws:' + ip, 120, 240)) { if (!allow('wswarn:' + ip, 1, 1)) return; return ws.send(JSON.stringify({ t: 'error', m: 'Mensagens demais. Calma!' })); }
    let m; try { m = JSON.parse(raw); } catch { return; } if (!m || typeof m.t !== 'string') return;
    if (m.t === 'hello') {
      const old = typeof m.token === 'string' && sessions.get(m.token);
      if (old) { if (old.ws && old.ws !== ws) try { old.ws.close(4000, 'outra conexão'); } catch {} s = old; s.ws = ws; s.name = cleanName(m.name, s.name); }
      else { s = { id: 'u' + crypto.randomBytes(5).toString('hex'), token: token(), ws, name: cleanName(m.name), avatar: cleanChar(m.avatar), room: null, slot: 0, seen: now() }; sessions.set(s.token, s); }
      if (m.avatar) s.avatar = cleanChar(m.avatar); s.seen = now();
      ws.send(JSON.stringify({ t: 'welcome', id: s.id, token: s.token, v: 1 }));
      const r = s.room && wsRooms.get(s.room); if (r) { broadcast(r, wsRoomInfo(r)); broadcast(r, { t: 'event', e: { kind: 'back', id: s.id } }, s); }
      return;
    }
    if (!s) return ws.send(JSON.stringify({ t: 'error', m: 'Mande hello primeiro.' }));
    s.seen = now(); const r = s.room && wsRooms.get(s.room);
    switch (m.t) {
      case 'ping': return sendTo(s, { t: 'pong', c: m.c, s: now() });
      case 'create': { if (wsRooms.size > 3000) return sendTo(s, { t: 'error', m: 'Servidor cheio.' }); const kind = KINDS.has(m.kind) ? m.kind : 'fliperama', cap = Math.max(2, Math.min(8, Number(m.cap) || (kind === 'tv' ? 5 : 2)));
        leaveWsRoom(s); const nr = { code: newCode(new Set([...wsRooms.keys(), ...rooms.keys()])), kind, cap, hostId: s.id, seats: [], touched: now(), open: m.open !== false }; wsRooms.set(nr.code, nr); joinWsRoom(s, nr); log('ws sala', kind, nr.code); return; }
      case 'join': { const code = String(m.code || '').toUpperCase().trim(), nr = wsRooms.get(code); if (!nr) return sendTo(s, { t: 'error', m: 'Sala não encontrada. Confira o código.' }); return joinWsRoom(s, nr); }
      case 'quick': { const kind = KINDS.has(m.kind) ? m.kind : 'fliperama'; const nr = [...wsRooms.values()].find((x) => x.kind === kind && x.open && x.quick && x.seats.length < x.cap && x.seats.some((y) => y.ws));
        if (nr) return joinWsRoom(s, nr); leaveWsRoom(s); const cr = { code: newCode(new Set([...wsRooms.keys(), ...rooms.keys()])), kind, cap: 2, hostId: s.id, seats: [], touched: now(), open: true, quick: true }; wsRooms.set(cr.code, cr); joinWsRoom(s, cr); return; }
      case 'leave': return leaveWsRoom(s);
      case 'input': { if (!r || r.hostId === s.id) return; const i = m.i || {}; const ok = ['x', 'y'].every((k) => [-1, 0, 1].includes(i[k] ?? 0)) && ['a', 'b'].every((k) => typeof (i[k] ?? false) === 'boolean'); if (!ok || !Number.isSafeInteger(m.s)) return;
        const host = r.seats.find((x) => x.id === r.hostId); return sendTo(host, { t: 'input', from: s.id, slot: s.slot, s: m.s, i: { x: i.x || 0, y: i.y || 0, a: !!i.a, b: !!i.b, extra: typeof i.extra === 'string' ? i.extra.slice(0, 40) : undefined } }); }
      case 'state': { if (!r || r.hostId !== s.id) return; r.touched = now(); return broadcast(r, { t: 'state', s: m.s, d: m.d }, s); }
      case 'event': { if (!r) return; const e = m.e && typeof m.e === 'object' ? m.e : null; if (!e || JSON.stringify(e).length > 4000) return; if (r.hostId !== s.id) { const host = r.seats.find((x) => x.id === r.hostId); return sendTo(host, { t: 'event', from: s.id, slot: s.slot, e }); } return broadcast(r, { t: 'event', e }, s); }
      case 'lock': { if (r && r.hostId === s.id) { r.open = !m.locked; } return; }
    }
  });
  ws.on('close', () => { if (s && s.ws === ws) { s.ws = null; const r = s.room && wsRooms.get(s.room); if (r) { broadcast(r, wsRoomInfo(r)); broadcast(r, { t: 'event', e: { kind: 'away', id: s.id } }); } } });
});
// batimento: derruba conexões mortas; sessões sem conexão por 60 s saem da sala
setInterval(() => { for (const ws of wss.clients) { if (!ws.isAlive) { ws.terminate(); continue; } ws.isAlive = false; try { ws.ping(); } catch {} }
  const t = now(); for (const [tk, s] of sessions) if (!s.ws && t - s.seen > 60000) { leaveWsRoom(s); sessions.delete(tk); } }, 15000).unref();

/* ================= 3. HTTP: arquivos do jogo, CORS e saúde ================= */
const TYPES = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.json': 'application/json; charset=utf-8', '.png': 'image/png', '.jpg': 'image/jpeg', '.svg': 'image/svg+xml', '.webmanifest': 'application/manifest+json', '.ico': 'image/x-icon', '.mp3': 'audio/mpeg', '.ogg': 'audio/ogg', '.woff2': 'font/woff2', '.ttf': 'font/ttf', '.txt': 'text/plain; charset=utf-8' };
function cors(req, res) {
  const o = req.headers.origin; if (!o) return;
  if (ORIGINS.includes('*') || ORIGINS.includes(o)) { res.setHeader('Access-Control-Allow-Origin', ORIGINS.includes('*') ? '*' : o); res.setHeader('Vary', 'Origin'); res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization'); res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS'); res.setHeader('Access-Control-Max-Age', '600'); }
}
function send(res, code, obj) { if (res.headersSent) return; res.writeHead(code, { 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store' }); res.end(JSON.stringify(obj)); }
function readJson(req, max) { return new Promise((resolve) => { let size = 0; const chunks = []; req.on('data', (c) => { size += c.length; if (size > max) { resolve(null); req.destroy(); } else chunks.push(c); }); req.on('end', () => { if (size > max) return; try { const t = Buffer.concat(chunks).toString('utf8'); const v = t ? JSON.parse(t) : {}; resolve(v && typeof v === 'object' && !Array.isArray(v) ? v : null); } catch { resolve(null); } }); req.on('error', () => resolve(null)); }); }
function serveFile(req, res, url) {
  let rel = decodeURIComponent(url.pathname); if (rel.endsWith('/')) rel += 'index.html';
  const file = path.resolve(DIST, '.' + rel); if (!file.startsWith(DIST + path.sep) && file !== DIST) return send(res, 403, { error: 'proibido' });
  fs.stat(file, (err, st) => { if (err || !st.isFile()) { res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' }); return res.end('Não encontrado'); }
    res.writeHead(200, { 'Content-Type': TYPES[path.extname(file).toLowerCase()] || 'application/octet-stream', 'Cache-Control': /\.(html|json)$/.test(file) || file.endsWith('sw.js') ? 'no-cache' : 'public, max-age=3600', 'X-Content-Type-Options': 'nosniff' });
    if (req.method === 'HEAD') return res.end(); fs.createReadStream(file).pipe(res); });
}
const ipOf = (req) => String(req.headers['fly-client-ip'] || req.headers['x-forwarded-for'] || req.socket.remoteAddress || '').split(',')[0].trim();
const server = http.createServer(async (req, res) => {
  cors(req, res);
  if (req.method === 'OPTIONS') { res.writeHead(204); return res.end(); }
  const url = new URL(req.url, 'http://x');
  try {
    if (url.pathname === '/api/health') return send(res, 200, { ok: true, server: 'daroca', v: 1, rooms: rooms.size, wsRooms: wsRooms.size, players: wss.clients.size });
    if (url.pathname.startsWith('/api/arena/rooms')) return await arenaApi(req, res, url, ipOf(req));
    if (url.pathname.startsWith('/api/')) return send(res, 404, { error: 'Este servidor não tem esse recurso.' });
    if (req.method !== 'GET' && req.method !== 'HEAD') return send(res, 405, { error: 'Método não aceito.' });
    return serveFile(req, res, url);
  } catch (e) { log('erro', e.message); return send(res, 500, { error: 'Erro no servidor.' }); }
});
server.on('upgrade', (req, socket, head) => {
  const url = new URL(req.url, 'http://x'), o = req.headers.origin;
  if (url.pathname !== '/ws' || (o && !ORIGINS.includes('*') && !ORIGINS.includes(o))) { socket.destroy(); return; }
  const ip = ipOf(req); if (!allow('wsconn:' + ip, 2, 20)) { socket.destroy(); return; }
  wss.handleUpgrade(req, socket, head, (ws) => wss.emit('connection', ws, req, ip));
});
if (require.main === module) server.listen(PORT, () => log('Da Roça online em http://localhost:' + PORT, '· jogo em', DIST));
module.exports = { server, rooms, wsRooms };
