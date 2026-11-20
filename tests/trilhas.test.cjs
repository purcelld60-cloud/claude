const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const source = file => fs.readFileSync(path.join(__dirname, '../dist', file), 'utf8');
const catalog = JSON.parse(source('music/config.json'));
const scope = 'https://jogo.example/claude/';
const worker = vm.createContext({
  self: { registration: { scope }, addEventListener() {} },
  URL, Headers, Response, importScripts() {}
});
vm.runInContext(source('music/config.js'), worker);
vm.runInContext(source('sw.js'), worker);

test('o navegador e o cache conhecem os mesmos arquivos e associações do APK', () => {
  assert.deepEqual(JSON.parse(JSON.stringify(worker.self.DAROCA_MUSIC_CONFIG)), catalog);
  const ids = new Set(catalog.tracks.map(t => t.id));
  assert(ids.size > 0);
  for (const track of catalog.tracks) {
    assert.equal(track.file, 'music/' + track.sha256 + '.mp3');
    assert.equal(vm.runInContext('tracks', worker).get(scope + track.file), track.bytes);
  }
  for (const binding of Object.values(catalog.bindings)) assert(ids.has(binding.trackId));
  assert.equal(catalog.bindings['cutscenes.jorge_epilogue'].startSeconds, 112);
});

test('uma resposta de mídia parcial jamais substitui uma gravação completa no cache', () => {
  const complete = vm.runInContext('isCompleteRecording', worker);
  function media(status, length, range) {
    const headers = { 'Content-Type': 'audio/mpeg', 'Content-Length': String(length) };
    if (range) headers['Content-Range'] = range;
    return new Response(null, { status, headers });
  }
  assert(complete(media(200, 9), 9));
  assert(complete(media(206, 9, 'bytes 0-8/9'), 9));
  assert.equal(complete(media(206, 3, 'bytes 6-8/9'), 9), false);
  assert.equal(complete(media(200, 3), 9), false);
});

test('uma gravação offline atende buscas no meio e no fim da faixa', async () => {
  const range = vm.runInContext('cachedRange', worker);
  for (const [query, expected, value] of [
    ['bytes=2-4','bytes 2-4/9','cde'],
    ['bytes=-2','bytes 7-8/9','hi'],
    ['bytes=6-','bytes 6-8/9','ghi']
  ]) {
    const r = await range(new Response('abcdefghi'), query, 9);
    assert.equal(r.status, 206);
    assert.equal(r.headers.get('Content-Range'), expected);
    assert.equal(await r.text(), value);
  }
  const invalid = await range(new Response('abcdefghi'), 'bytes=9-', 9);
  assert.equal(invalid.status, 416);
  assert.equal(invalid.headers.get('Content-Range'), 'bytes */9');
});
