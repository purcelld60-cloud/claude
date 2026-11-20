const { test } = require('node:test');
const assert = require('node:assert/strict');
const { readFileSync } = require('node:fs');
const { join } = require('node:path');
const vm = require('node:vm');

const page = vm.createContext({ window: {} });
for (const name of ['world', 'campaign', 'amanda', 'activities']) {
  vm.runInContext(readFileSync(join(__dirname, '../dist', name + '.js'), 'utf8'), page);
}
const { Campaign, Activities } = page.window;
const beforeFinal = {
  lucas: true, mota: true, almiro: true, miqueias: true, freddy: true, reeis: true,
  marco: true, giant: true, menezes: true, trained: true
};
const advance = (s, seconds) => Activities.update(s, seconds);

test('o jantar aparece no diário e só a praça aparece entre os destinos', () => {
  assert.equal(Campaign.npcEntries.amanda.scene, 4);
  assert.equal(Campaign.sceneNames.length, 12);
  assert.equal(Campaign.canTravel(12, beforeFinal).ok, false);
  assert.match(Campaign.currentQuest(beforeFinal)[0], /mesa/);
  assert.match(Campaign.canTravel(3, beforeFinal).reason, /Amanda/);
  assert.equal(Campaign.bossRequirement('nikolas', beforeFinal).ok, false);
  assert.equal(Campaign.bossRequirement('nikolas', { ...beforeFinal, amandaDating: true }).ok, true);
});

test('um save antigo zerado conserva a final e pode viver o jantar no epílogo', () => {
  const legacy = { ...beforeFinal, nikolas: true, jorgeSeen: true };
  assert.equal(Campaign.completion(legacy), 100);
  assert.equal(Campaign.canTravel(3, legacy).ok, true);
  const date = Campaign.chapterState(legacy).find(c => c.id === 'jantar-amanda');
  assert.equal(date.complete, false);
  assert.equal(date.epilogue, true);
});

test('a saída e a confirmação em sequência não contam como resposta', () => {
  const s = Activities.create('dinner');
  advance(s, .95);
  assert.equal(Activities.submit(s), true);
  assert.equal(s.phase, 'choice');
  advance(s, .25);
  assert.equal(Activities.submit(s), false);
  assert.equal(Activities.submit(s, 2), false);
  Activities.cancel(s);
  assert.equal(s.success, false);
  assert.equal(Activities.submit(s, 0), false);
});

for (const [label, timed, answers, expected] of [
  ['dois pratos em sintonia', [true,true,false], [0,1,0], true],
  ['respirar e atropelar as três conversas', [true,true,true], [1,0,1], false],
  ['responder bem e perder os três ritmos', [false,false,false], [0,1,0], false]
]) {
  test(label, () => {
    const s = Activities.create('dinner');
    for (let i=0; i<3; i++) {
      const period = 3.8-i*.25;
      advance(s, timed[i] ? period/4 : period);
      assert(Activities.submit(s));
      if (!timed[i]) {
        assert.equal(s.phase,'breath');
        advance(s,period);
        assert(Activities.submit(s));
      }
      advance(s,.25);
      assert(Activities.submit(s,answers[i]));
      assert.equal(s.phase,'reply');
      advance(s,.25);
      assert(Activities.submit(s));
    }
    assert.equal(s.phase,'outcome');
    assert.equal(s.done,false);
    advance(s,.25);
    assert(Activities.submit(s));
    assert.equal(s.success,expected);
    assert.equal(Activities.submit(s),false);
  });
}
