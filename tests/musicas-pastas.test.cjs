const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const dist = path.join(__dirname, '../dist');
const pastas = JSON.parse(fs.readFileSync(path.join(dist, 'musicas/pastas.json'), 'utf8')).pastas;
const catalog = JSON.parse(fs.readFileSync(path.join(dist, 'music/config.json'), 'utf8'));

function carregar(lista) {
  const ctx = vm.createContext({ window: { DAROCA_MUSICAS: lista }, fetch: async () => ({ ok: false }), console, Math, encodeURI });
  vm.runInContext(fs.readFileSync(path.join(dist, 'musicas.js'), 'utf8'), ctx);
  return ctx.window.DarocaMusicas.load();
}

test('cada pasta existe, tem LEIA-ME e aponta para um lugar válido', () => {
  for (const [nome, info] of Object.entries(pastas)) {
    assert.match(nome, /^[a-z0-9][a-z0-9-]{0,60}$/);
    assert.match(info.lugar, /^[a-zA-Z0-9_.-]{1,90}$/);
    assert.ok(fs.existsSync(path.join(dist, 'musicas', nome, 'LEIA-ME.txt')), nome);
  }
  // toda música original do jogo tem pelo menos uma pasta
  const lugares = Object.values(pastas).map((p) => p.lugar);
  for (const chave of Object.keys(catalog.bindings)) assert.ok(lugares.some((l) => chave === l || chave.startsWith(l + '.phase')), chave);
});

test('música na pasta toca no lugar; a cópia do original reaproveita a faixa do jogo', async () => {
  const orig = catalog.tracks[0].id;
  const r = await carregar({ arquivos: [
    { nome: 'c1-cenario-roca/minha.mp3', bytes: 10, lugar: 'maps.roca' },
    { nome: 'c2-luta-creuza/ORIGINAL - x.mp3', bytes: 10, lugar: 'c2.battles.creuza', original: orig },
    { nome: '../fora.mp3', bytes: 10, lugar: 'maps.escola' },
    { nome: 'a/b/c.mp3', bytes: 10, lugar: 'maps.escola' }
  ], avisos: [], txt: '' });
  assert.equal(r.tracks.length, 1);
  assert.equal(r.tracks[0].url, 'musicas/c1-cenario-roca/minha.mp3');
  assert.equal(r.bindings['maps.roca'].trackId, r.tracks[0].id);
  assert.equal(r.bindings['c2.battles.creuza'].trackId, orig);
  assert.equal(r.bindings['maps.escola'], undefined);
});

test('com várias músicas na mesma pasta, o jogo sorteia uma delas', async () => {
  const vistos = new Set();
  for (let i = 0; i < 30; i++) {
    const r = await carregar({ arquivos: [1, 2, 3].map((n) => ({ nome: `geral-pausa/m${n}.mp3`, bytes: 1, lugar: 'menu.pause' })), avisos: [], txt: '' });
    vistos.add(r.tracks.find((t) => t.id === r.bindings['menu.pause'].trackId).url);
  }
  assert.ok(vistos.size > 1);
});
