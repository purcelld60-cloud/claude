const test = require('node:test');
const assert = require('node:assert/strict');

global.window = {};
require('../dist/campanha2/jorge-duelo.js');
require('../dist/campanha2/combate-chefes.js');
require('../dist/campanha2/fases.js');
const c = window.ConquistaCombate;
const fases = window.CampanhaFases;
const jogador = {x: 320, y: 440};
const criar = (slug, modo = 1) => c.criar(slug, 560, 440, 160, 960, {windup: modo}, [1, .9, .8]);

test('cada vilão da história tem golpes exclusivos e desbloqueia pelo menos um por barra', () => {
  assert.deepEqual(Object.keys(c.chefes).sort(), fases.lista().sort());
  const donos = new Map();
  for (const [slug, chefe] of Object.entries(c.chefes)) {
    const vistos = new Set();
    for (const fase of chefe.fases) {
      assert(fase.some(g => !vistos.has(g)), slug);
      for (const golpe of fase) {
        assert.equal(donos.get(golpe) || slug, slug, golpe);
        donos.set(golpe, slug); vistos.add(golpe);
      }
    }
    assert.equal(vistos.size,7,slug);
  }
  assert.equal(donos.size,63);
});

test('as 63 coreografias têm aviso, colisão na marca desenhada e um intervalo seguro para atacar', () => {
  for (const [slug, cfg] of Object.entries(c.chefes)) {
    for (const [i, fase] of cfg.fases.entries()) {
      for (const [j, nome] of fase.entries()) {
        const f = criar(slug);
        c.trocar(f, i+1); f.indice = j;
        c.preparar(f, jogador);
        assert.equal(f.golpe, nome); assert(c.titulo(f).length > 3);
        assert(f.objetos.length > 0 && f.objetos.length <= 5);
        const primeiro = f.objetos[0];
        const alvo = c.ponto(primeiro, .5);
        const parado = {x: alvo.x, y: alvo.y+12};
        let acertos = 0, som = 0;
        function ferir(d, x) {
          assert.equal(f.estado,'firing'); assert(d>0 && Number.isFinite(x));
          acertos++;
        }
        c.atualizar(f, f.dur-.01, parado, ferir);
        assert.equal(acertos, 0);
        for(let k=0;k<800 && f.estado!=='recover';k++) c.atualizar(f, 1/120, parado, ferir, () => som++);
        assert(acertos>=1, nome); assert.equal(som, 1); assert.equal(f.estado,'recover');
        assert(f.dur>.6 && f.dur<=.81);
        const antes=acertos; c.atualizar(f,f.dur/2,parado,ferir); assert.equal(acertos,antes);
      }
    }
  }
});

test('fora do visor, acima da moto e durante a virada o jogador não leva dano', () => {
  for (const [slug,dist,altura] of [['kaua',100,0],['tonhao',0,95]]) {
    const f=criar(slug); c.preparar(f,jogador);
    let dano=0;
    for(let i=0;i<230 && f.estado!=='recover';i++) c.atualizar(f,1/80,{x:jogador.x+dist,y:440-altura},()=>dano++);
    assert.equal(dano,0,slug);
  }
  const j=criar('jorge'); c.preparar(j,jogador);
  for(let i=0;i<80;i++) c.atualizar(j,1/60,jogador,()=>{});
  assert.equal(j.estado,'firing'); const dur=c.trocar(j,2);
  assert.deepEqual([j.objetos.length,j.marcas.length,j.indice],[0,0,0]);
  c.atualizar(j,dur-.01,jogador,assert.fail); assert.equal(j.estado,'phaseChange');
  c.atualizar(j,.02,jogador,assert.fail); assert.equal(j.golpe,'saltoBarriga');
  const novo=criar('jorge');assert.equal(novo.fase,1);assert.deepEqual(novo.objetos,[]);
});

test('as farpas de Jorge mudam de frase e ficam legíveis junto às duas bordas', () => {
  for(const x of [161,959]){
    const f=criar('jorge'); c.trocar(f,3);
    const palavras=new Set();
    for(let n=0;n<4;n++){
      f.indice=0;c.preparar(f,{x,y:440});
      const o=f.objetos[0]; palavras.add(o.palavra);
      assert(o.rx>=o.palavra.length*3.5);
      for(const t of [0,.5,1]){const p=c.ponto(o,t);assert(p.x-o.rx>=f.l && p.x+o.rx<=f.r);}
    }
    assert.equal(palavras.size,4);
  }
});

test('Jorge sobe de verdade nos dois pulos de barriga e o alvo acompanha o corpo', () => {
  const f=criar('jorge'); c.trocar(f,2);c.preparar(f,jogador);
  const [primeiro,segundo]=f.objetos;
  assert.equal(primeiro.art,'barriga');assert.equal(segundo.art,'barriga');
  c.atualizar(f,f.dur+.001,jogador,()=>{});
  for(const o of [primeiro,segundo]){
    const alvo=o.atraso+o.dur/2;
    c.atualizar(f,alvo-f.tempo,jogador,()=>{});
    const p=c.ponto(o,.5);
    assert(Math.abs(f.x-p.x)<.001 && Math.abs(f.y-p.y-o.corpo)<.001);
    assert(f.y<f.piso-80);
    assert(window.JorgeDuelo.toca(f,p.x,p.y,5,5));
    assert(!window.JorgeDuelo.toca(f,p.x,f.piso-3,5,3));
  }
  c.atualizar(f,segundo.dur/2+.001,jogador,()=>{});
  assert.equal(f.y,f.piso);
});

test('seis ilhas carregam o jogador, só as três sinalizadas cedem, voltam e permitem a revanche', () => {
  const f=criar('jorge'), j={x:300,y:440,vy:0,vx:0,inv:0,ground:true}, ar=window.JorgeDuelo;
  c.trocar(f,4,j); const ilhas=f.ceu.ilhas; assert.equal(ilhas.length,6);
  const i=ilhas.find(i=>j.x>=i.x&&j.x<=i.x+i.w);
  for(let n=0;n<95;n++)ar.avancar(f,1/60,j);
  assert(i.y<400); assert.equal(j.y,i.y);
  const antes=ilhas.map(i=>i.y);
  for(let n=0;n<45;n++)ar.avancar(f,1/60,j);
  assert(ilhas.every((i,k)=>Math.abs(i.y-antes[k])>.5));
  let ultimos='';
  for(let ciclo=0;ciclo<4;ciclo++){
    f.indice=1;c.preparar(f,j);assert.equal(f.golpe,'ruptura');
    const marcadas=ilhas.filter(i=>i.estado==='aviso').map(i=>i.id);
    assert.equal(marcadas.length,3);assert.notEqual(marcadas.join(),ultimos); ultimos=marcadas.join();
    assert.deepEqual(f.objetos.map(o=>o.ilha),marcadas);
    assert(f.dur>=1.1);
    c.atualizar(f,f.dur,j,()=>{});
    assert.deepEqual(ilhas.filter(i=>i.estado==='ausente').map(i=>i.id),marcadas);
    const vazia=ilhas[marcadas[0]]; j.x=vazia.x+vazia.w/2;j.y=vazia.y+4;j.vy=20;j.ground=false;
    ar.pousar(f,j,vazia.y-1,assert.fail);assert(!j.ground);
    let dano=0;j.y=f.piso+50;ar.pousar(f,j,j.y-4,d=>dano=d);
    assert(dano>0 && j.ground && j.vy===0);
    assert(ilhas.some(i=>i.estado==='inteira'&&j.x===i.x+i.w/2&&j.y===i.y));
    for(let n=0;n<150;n++)ar.avancar(f,1/60,j);
    assert(ilhas.every(i=>i.estado==='inteira'));
  }
  c.trocar(f,5,j);assert.strictEqual(f.ceu,null); assert.equal(j.y,f.piso); assert.equal(f.y,f.piso);
  const novo=criar('jorge');c.trocar(novo,4,j);assert(novo.ceu.ilhas.every(i=>i.estado==='inteira'));
  assert.equal(new Set(ar.formas).size,5);
});

test('cinco barras de Jorge respeitam o orçamento de vida e as três dificuldades', () => {
  assert.deepEqual(c.barras('jorge',4000),[2240,2720,3200,3720,4120]);
  for (const base of [2720,4000]) {
    const h=c.barras('jorge',base);
    assert(h.every((n,i)=>i===0||n>h[i-1]));
    assert(Math.abs(h.reduce((n,m)=>n+m,0)/(3.75*base)-1.0667)<.001);
  }
  const tempos=[.82,1,1.22].map(m=>{const f=criar('jorge',m);c.trocar(f,5);c.preparar(f,jogador);return f.dur;});
  assert(tempos[0]>=.6 && tempos[2]>tempos[1] && tempos[1]>tempos[0]);
  assert.deepEqual(c.barras('fred',100),[100,125,150]);
});

test('arena alternativa dá uma única vitória, depois da quinta barra, e rearma no checkpoint', () => {
  const p={x:2400,y:440,hp:100,max:100,inv:0};
  let vit=0;
  const f=fases.criar('jorge',{P:p,tremer(){},flash(){},sfx(){},ferir(){},entrarArena(){},vencer(){vit++;}});
  f.update(.02); f.comecarLuta(); f.update(.02); const inicial=f.chefe.max;
  for(let fase=1;fase<=5;fase++){
    assert.equal(f.chefe.fase,fase);
    f.chefe.onDano(1e7,'papel');assert.equal(vit,0);
    if(fase<5){
      const barra=f.chefe.hp;assert.equal(barra,f.chefe.max);assert.equal(f.chefe.fase,fase+1);
      assert.equal(f.chefe.onDano(1e7,'papel'),false);assert.equal(f.chefe.hp,barra);
      for(let i=0;i<101;i++)f.update(1/60);
    }
  }
  for(let i=0;i<180;i++)f.update(1/60);
  assert.equal(vit,1); f.reiniciar();assert.equal(f.chefe.fase,1);assert.equal(f.chefe.hp,inicial);
});
