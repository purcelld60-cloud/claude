const { test } = require('node:test');
const assert = require('node:assert/strict');
const { readFileSync } = require('node:fs');
const { join } = require('node:path');
const vm = require('node:vm');

const page = vm.createContext({ window: {}, location: { search: '' }, addEventListener() {} });
page.window.addEventListener = () => {};
vm.runInContext(readFileSync(join(__dirname, '../dist/golpes.js'), 'utf8'), page);
const G = page.window.Golpes;
const CHAO = 440;
G.chao(CHAO);
const heroi = (x, y = CHAO) => G.heroi({ x, y });

test('a onda de choque só machuca quem encosta na crista desenhada (26 x 58 px)', () => {
  const onda = { type: 'ring', x: 500, y: CHAO - 5, r: 200 };
  assert.equal(G.perigoAcerta(onda, heroi(700)), true); // em cima da crista
  assert.equal(G.perigoAcerta(onda, heroi(700 + 13 + 14 + 1)), false); // um pixel depois da crista
  assert.equal(G.perigoAcerta(onda, heroi(700 + 13 + 14 - 1)), true);
  assert.equal(G.perigoAcerta(onda, heroi(600)), false); // no meio, onde a onda já passou
  assert.equal(G.perigoAcerta(onda, heroi(700, CHAO - 59)), false); // pulou por cima
  assert.equal(G.perigoAcerta(onda, heroi(300)), true); // a crista do outro lado
});

test('erupção no chão cobre [x-r, x+r] até 80 px; o feixe astral pega em qualquer altura', () => {
  const erupcao = { type: 'ink', x: 400, y: CHAO - 6, r: 50 };
  assert.equal(G.perigoAcerta(erupcao, heroi(400 + 50 + 14 - 1)), true);
  assert.equal(G.perigoAcerta(erupcao, heroi(400 + 50 + 14 + 1)), false);
  assert.equal(G.perigoAcerta(erupcao, heroi(400, CHAO - 81)), false);
  const feixe = { type: 'astral', x: 400, y: CHAO - 6, r: 40 };
  assert.equal(G.perigoAcerta(feixe, heroi(400, 120)), true);
  const brasa = { type: 'smoke', brasa: true, x: 400, y: CHAO - 6, r: 26 };
  assert.equal(G.perigoAcerta(brasa, heroi(400, CHAO - 41)), false); // as brasas só sobem 40 px
});

test('tiros acertam pelo tamanho do desenho', () => {
  const corpo = heroi(300);
  assert.equal(G.tiroAcerta({ type: 'paper', x: 300 + 14 + 7, y: CHAO - 30 }, corpo), true);
  assert.equal(G.tiroAcerta({ type: 'paper', x: 300 + 14 + 9, y: CHAO - 30 }, corpo), false);
  assert.equal(G.tiroAcerta({ type: 'inkBlade', x: 300 + 14 + 21, y: CHAO - 30 }, corpo), true); // lâminas de 22 px
  assert.equal(G.tiroAcerta({ type: 'word', text: 'POUDIAAAM', x: 350, y: CHAO - 40 }, corpo), true); // faixa larga (81 px)
});

test('a nuvem do peidão é a área: quem está dentro da elipse leva, quem está fora não', () => {
  const area = G.areaGas(300, CHAO, 155);
  const freddy = (x) => G.chefe({ type: 'freddy', x, y: CHAO });
  assert.equal(G.gasAcerta(area, freddy(300 + 155 + 17 - 2)), true);
  assert.equal(G.gasAcerta(area, freddy(300 + 155 + 17 + 2)), false);
  assert.equal(G.gasAcerta(area, freddy(300 - 150)), true); // dos dois lados
});

test('corpos medidos dos chefes (Nikolas cresce por fase)', () => {
  const nik = (phase) => { const b = G.chefe({ type: 'nikolas', phase, x: 0, y: CHAO }); return [b.x1, CHAO - b.y0]; };
  assert.deepEqual(nik(1), [20, 68]);
  assert.deepEqual(nik(4), [190, 345]);
  const giant = G.chefe({ type: 'giant', x: 0, y: CHAO });
  assert.equal(giant.x1, 104);
});
