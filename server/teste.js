/* Teste rápido do servidor: node server/teste.js (sobe numa porta livre, testa e encerra). */
'use strict';
const assert = require('assert'), WebSocket = require('ws');
process.env.PORT = '0';
const { server } = require('./server.js');
server.listen(0, async () => {
  const base = 'http://127.0.0.1:' + server.address().port;
  const post = async (p, body, tk) => { const r = await fetch(base + p, { method: 'POST', headers: { 'Content-Type': 'application/json', ...(tk ? { Authorization: 'Bearer ' + tk } : {}) }, body: JSON.stringify(body || {}) }); return { status: r.status, data: await r.json() }; };
  try {
    const h = await (await fetch(base + '/api/health')).json(); assert.equal(h.server, 'daroca');
    const idx = await fetch(base + '/'); assert.equal(idx.status, 200);
    // Arena: criar, entrar, sincronizar, sinal, sair
    const a = await post('/api/arena/rooms', { name: 'Ana', character: 'daroca', capacity: 4, mode: 'arena', protocol: 3 }); assert.equal(a.status, 200); assert.ok(a.data.isHost && /^[A-Z0-9]{6}$/.test(a.data.room.code));
    const code = a.data.room.code;
    const b = await post('/api/arena/rooms/' + code + '/join', { name: 'Beto<script>', character: 'reeis', mode: 'arena', protocol: 3 }); assert.equal(b.status, 200); assert.equal(b.data.isHost, false); assert.ok(!b.data.room.players[1].name.includes('<'));
    let s = await post('/api/arena/rooms/' + code + '/sync', { input: { seq: 1, x: 1, jump: true }, ready: true }, b.data.token); assert.equal(s.status, 200);
    s = await post('/api/arena/rooms/' + code + '/sync', { input: { seq: 1, x: 9 } }, b.data.token); assert.equal(s.status, 400, 'entrada inválida recusada');
    s = await post('/api/arena/rooms/' + code + '/sync', { state: { seq: 5, matchId: 'm1', players: [] }, status: 'playing' }, b.data.token); assert.equal(s.data.room.status, 'lobby', 'convidado não muda o estado');
    s = await post('/api/arena/rooms/' + code + '/sync', { state: { seq: 5, matchId: 'm1', players: [] }, status: 'playing' }, a.data.token); assert.equal(s.data.room.status, 'playing'); assert.equal(s.data.inputs[0].input.x, 1);
    s = await post('/api/arena/rooms/' + code + '/sync', {}, b.data.token); assert.equal(s.data.state.matchId, 'm1');
    s = await post('/api/arena/rooms/' + code + '/sync', {}, 'token-falso'); assert.equal(s.status, 401);
    const late = await post('/api/arena/rooms/' + code + '/join', { name: 'Atrasado' }); assert.equal(late.status, 409);
    await post('/api/arena/rooms/' + code + '/signal', { op: 'send', to: b.data.playerId, kind: 'offer', data: { session: 'x', sdp: 'v=0' } }, a.data.token);
    s = await post('/api/arena/rooms/' + code + '/signal', { op: 'poll', after: 0 }, b.data.token); assert.equal(s.data.signals.length, 1);
    const coop = await post('/api/arena/rooms', { name: 'C', mode: 'coop', protocol: 3, capacity: 2 }); assert.equal(coop.data.room.mode, 'coop'); assert.equal(coop.data.room.protocol, 3);
    const q1 = await post('/api/arena/rooms/quick', { name: 'Q1', mode: 'arena', protocol: 3 }), q2 = await post('/api/arena/rooms/quick', { name: 'Q2', mode: 'arena', protocol: 3 }); assert.equal(q1.data.room.code, q2.data.room.code, 'sala rápida junta os dois');
    s = await post('/api/arena/rooms/' + code + '/leave', {}, b.data.token); assert.equal(s.status, 200);
    // WebSocket: fliperama online com reconexão
    const ws = (u) => new Promise((res) => { const w = new WebSocket(u); const q = []; w.next = (t) => new Promise((ok) => { const i = q.findIndex((m) => m.t === t); if (i >= 0) return ok(q.splice(i, 1)[0]); w.wait = { t, ok }; }); w.on('message', (d) => { const m = JSON.parse(d); if (w.wait && w.wait.t === m.t) { const k = w.wait; w.wait = null; k.ok(m); } else q.push(m); }); w.on('open', () => res(w)); });
    const url = base.replace('http', 'ws') + '/ws';
    const h1 = await ws(url); h1.send(JSON.stringify({ t: 'hello', name: 'Host', avatar: 'daroca' })); const w1 = await h1.next('welcome');
    h1.send(JSON.stringify({ t: 'create', kind: 'fliperama' })); const r1 = await h1.next('room');
    const g1 = await ws(url); g1.send(JSON.stringify({ t: 'hello', name: 'Guest', avatar: 'reeis' })); const wg = await g1.next('welcome');
    g1.send(JSON.stringify({ t: 'join', code: r1.code })); const rg = await g1.next('room'); assert.equal(rg.players.length, 2);
    g1.send(JSON.stringify({ t: 'input', s: 1, i: { x: 1, y: 0, a: true, b: false } })); const inp = await h1.next('input'); assert.equal(inp.i.x, 1);
    g1.send(JSON.stringify({ t: 'state', s: 1, d: { hack: true } })); // convidado não pode mandar estado
    h1.send(JSON.stringify({ t: 'state', s: 2, d: { ok: 1 } })); const st = await g1.next('state'); assert.equal(st.d.ok, 1);
    g1.close(); await new Promise((r) => setTimeout(r, 150));
    const g2 = await ws(url); g2.send(JSON.stringify({ t: 'hello', token: wg.token, name: 'Guest' })); const w2 = await g2.next('welcome'); assert.equal(w2.id, wg.id, 'reconectou na mesma vaga');
    h1.send(JSON.stringify({ t: 'state', s: 3, d: { ok: 2 } })); const st2 = await g2.next('state'); assert.equal(st2.d.ok, 2);
    h1.send(JSON.stringify({ t: 'ping', c: 1 })); const pg = await h1.next('pong'); assert.equal(pg.c, 1);
    h1.close(); g2.close();
    console.log('OK: todos os testes do servidor passaram');
  } catch (e) { console.error('FALHOU:', e); process.exitCode = 1; }
  server.close(); setTimeout(() => process.exit(), 100);
});
