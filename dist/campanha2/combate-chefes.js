/* Conquista: coreografia em coordenadas da arena. O aviso e o dano usam a mesma trajetória. */
(() => {
  'use strict';
  const clamp = (n, min, max) => Math.min(max, Math.max(min, n));
  const mix = (a, b, t) => a + (b - a) * t;
  const tres = (a, b, c, d) => [[a, b], [c, a, b], [d, c, b, a]];
  const chefes = {
    creuza: { cor: '#ff96c2', fases: tres('parapeito', 'recado', 'encaminhado', 'quarteirao') },
    tonhao: { cor: '#ffaf43', fases: tres('bandeirada', 'recibo', 'retorno', 'contramao') },
    valdomiro: { cor: '#ffcf74', fases: tres('rosquinha', 'quilo', 'peneira', 'balanca') },
    kaua: { cor: '#76efff', fases: tres('enquadrar', 'curtidas', 'carrossel', 'reprise') },
    barao: { cor: '#aede70', fases: tres('semeadura', 'coado', 'florada', 'safra') },
    breno: { cor: '#ff8268', fases: tres('ribalta', 'contrapeso', 'deixa', 'bis') },
    gemeos: { cor: '#69f1dd', fases: tres('player1', 'player2', 'cabolink', 'coop') },
    fred: { cor: '#ffcb55', fases: tres('pao', 'pente', 'toque', 'clube') },
    jorge: { cor: '#d2aaff', fases: [
      ['descartar', 'carteado'], ['chamada', 'castigo', 'descartar'], ['apelido', 'rasura', 'chamada'],
      ['retrato', 'negativo', 'rasura'], ['ligacao', 'promessa', 'linhaCruzada', 'retrato']
    ] }
  };
  const capitulos = [
    ['Eu não te conheço', 'bilhete', '#a7d8fb'], ['Silêncio na sala', 'carteira', '#9ee9c6'],
    ['O apelido', 'letra', '#ff9cab'], ['O retrato do trio', 'foto', '#ffd28f'],
    ['A promessa de Itabuna', 'telefone', '#d4acff']
  ];
  function barras(slug, base) {
    // Jorge tinha 3,75 barras-base no motor principal. Redistribuir em cinco dá só +6,7% de vida total.
    return (slug === 'jorge' ? [.56, .68, .80, .93, 1.03] : [1, 1.25, 1.5]).map(m => Math.max(1, Math.round(base * m)));
  }

  // Gera um pequeno conjunto finito de objetos por golpe. Alturas são medidas a partir do piso.
  function palco(f, p) {
    const l = f.l + 36, r = f.r - 36, x = clamp(p.x, l, r), d = x < f.x ? -1 : 1;
    const edge = d < 0 ? l : r;
    const alvo = dx => clamp(x + dx, l, r);
    const mov = (art, x0, h0, x1, h1, dur, op = {}) => ({
      art, x0, y0: f.piso - h0, x1, y1: f.piso - h1, dur, atraso: 0,
      rx: 16, ry: 13, dano: 13, ...op
    });
    const area = (art, cx, largura, altura, atraso = 0, dur = .37) => {
      const ax = clamp(cx, f.l + largura / 2, f.r - largura / 2);
      return {art, area: true, x0: ax, x1: ax, y0: f.piso - altura / 2, y1: f.piso - altura / 2,
        rx: largura / 2, ry: altura / 2, atraso, dur, dano: 15};
    };
    return {l, r, x, d, edge, alvo, mov, area, b: f.x, twin: f.gemeoX, centro: (l + r) / 2,
      altura: clamp(f.piso - p.y + 27, 25, 270)};
  }

  // Cada entrada determina o desenho, a geometria, o ritmo e a abertura do golpe.
  const golpes = {
    parapeito: ['Plantão na janela', a => [a.area('janela', a.x, 78, 116)]],
    recado: ['Áudio da vizinha', a => [a.mov('audio', a.b, 68, a.edge, a.altura, 1.05, {onda: 19})]],
    encaminhado: ['Encaminhado de novo', a => [a.mov('balao', a.b, 75, a.edge, 28, .85, {arco: 55}),
      a.mov('audio', a.edge, 28, a.b, 90, 1, {atraso: .88, onda: 20})]],
    quarteirao: ['O bairro inteiro viu', a => [-112, 0, 112].map((n, i) => a.area('janela', a.alvo(n), 62, 136, i * .28))],

    bandeirada: ['Bandeirada • pule a moto', a => [a.mov('moto', a.b, 25, a.edge, 25, .78, {piloto: true, rx: 35, ry: 22})]],
    recibo: ['Taxa de chinelo', a => [a.mov('recibo', a.b, 65, a.edge, a.altura, 1.15, {onda: 32, rx: 14})]],
    retorno: ['Retorno proibido', a => [a.mov('moto', a.b, 25, a.edge, 25, .82, {piloto: true, rx: 35, ry: 22}),
      a.mov('moto', a.edge, 25, a.b, 25, .82, {piloto: true, atraso: 1.42, rx: 35, ry: 22})]],
    contramao: ['Faixa de mototáxi', a => [a.mov('cone', a.b, 55, a.x, 15, .63, {arco: 82}),
      a.mov('moto', a.b, 25, a.edge, 25, .75, {piloto: true, atraso: .8, rx: 35, ry: 22})]],

    rosquinha: ['Biscoito de goma', a => [a.mov('biscoito', a.b, 58, a.x, 20, .82, {arco: 108}),
      a.mov('biscoito', a.x, 20, a.edge, 17, .78, {arco: 54, atraso: .82})]],
    quilo: ['Só vendo no quilo!', a => [a.mov('saco', a.x, 262, a.x, 20, .64, {rx: 19, ry: 20}),
      a.area('farinha', a.x, 102, 46, .64, .38)]],
    peneira: ['Sai da peneira!', a => [-88, 88].map((dx, i) => a.mov('biscoito', a.b, 70, a.alvo(dx), 17, .92, {arco: 125, atraso: i * .23}))],
    balanca: ['Balança viciada', a => [-68, 68, -68].map((dx, i) => a.mov('prato', a.alvo(dx), 192, a.alvo(dx), 18, .5, {rx: 32, ry: 12, atraso: i * .52}))],

    enquadrar: ['Sai do enquadramento!', a => [a.area('visor', a.x, 98, 205)]],
    curtidas: ['Chuva de curtidas', a => [-55, 55].map((dx, i) => a.mov('like', a.alvo(dx), 228, a.alvo(-dx), 18, .96, {onda: 20, atraso: i * .38}))],
    carrossel: ['Arrasta pro lado', a => [-114, 0, 114].map((n, i) => a.area('visor', a.alvo(n), 74, 196, i * .36))],
    reprise: ['Replay ao vivo', a => [a.area('visor', a.x, 96, 214), a.area('visor', a.x, 96, 214, 1.04),
      a.mov('like', a.b, 60, a.edge, 65, 1.15, {arco: 55, atraso: .34})]],

    semeadura: ['Do grão ao pé de café', a => [a.mov('grao', a.b, 62, a.x, 10, .78, {arco: 103}),
      a.area('cafeeiro', a.x, 62, 125, .9, .52)]],
    coado: ['Café passado na hora', a => [a.mov('bule', a.b, 34, a.edge, 28, 1.28, {onda: 8, rx: 24, ry: 18})]],
    florada: ['Florada do cafezal', a => [-105, 0, 105].map((dx, i) => a.area('cafeeiro', a.alvo(dx), 59, 107 + i * 19, i * .3))],
    safra: ['Colheita apressada', a => [-74, 74].flatMap((dx, i) => [a.mov('grao', a.b, 60, a.alvo(dx), 10, .65, {arco: 94, atraso: i * .36}),
      a.area('cafeeiro', a.alvo(dx), 64, 145, .79 + i * .36)])],

    ribalta: ['Na mira do refletor', a => [a.area('refletor', a.x, 91, 220, 0, .45)]],
    contrapeso: ['Cuidado com o cenário!', a => [a.mov('peso', a.x, 274, a.x, 22, .57, {rx: 23, ry: 22}),
      a.mov('tabua', a.x, 13, a.edge, 13, .76, {atraso: .59, rx: 23, ry: 10})]],
    deixa: ['A deixa do Pitbull', a => [a.area('cortina', a.alvo(-76), 72, 194), a.area('cortina', a.alvo(76), 72, 194, .23),
      a.mov('luva', a.b, 47, a.x, 42, .54, {piloto: true, atraso: .74, rx: 24, ry: 17})]],
    bis: ['Pediram bis!', a => [a.area('refletor', a.x, 88, 212), a.mov('peso', a.x, 266, a.x, 20, .64, {atraso: .68, ry: 21}),
      a.mov('tabua', a.x, 13, a.b, 13, .78, {atraso: 1.32, rx: 24, ry: 11})]],

    player1: ['Ryan • comando baixo', a => [a.mov('controle1', a.b, 44, a.edge, 25, 1.1)]],
    player2: ['Bryan • comando aéreo', a => [a.mov('controle2', a.twin, 80, a.x, 20, .87, {arco: 78}),
      a.mov('controle2', a.x, 20, a.twin, 82, .85, {arco: 43, atraso: .88})]],
    cabolink: ['Cabo link desconectado', a => [a.mov('plug1', a.b, 26, a.twin, 27, 1.12, {rx: 20}),
      a.mov('plug2', a.twin, 96, a.b, 94, 1.12, {atraso: .34, rx: 20})]],
    coop: ['Combo dos dois controles', a => [a.mov('controle1', a.b, 38, a.x, 25, .82),
      a.mov('controle2', a.twin, 82, a.x, 26, .90, {arco: 80, atraso: .5}), a.area('checkpoint', a.x, 78, 100, 1.53)]],

    pao: ['Pão de queijo ou biscoito?', a => [a.mov('pao', a.b, 66, a.x, 18, .82, {arco: 90}),
      a.mov('pao', a.x, 18, a.edge, 18, .73, {arco: 62, atraso: .82})]],
    pente: ['Pente do topete', a => [a.mov('pente', a.b, 75, a.edge, a.altura, .86, {arco: 48}),
      a.mov('pente', a.edge, 38, a.b, 63, .97, {atraso: .95})]],
    toque: ['Topete, topete… toca aqui!', a => [a.area('palma', a.x, 68, 97), a.area('palma', a.alvo(a.d * 96), 68, 111, .36),
      a.mov('pao', a.b, 62, a.x, 23, .78, {arco: 84, atraso: .82})]],
    clube: ['Clube do Topete', a => [a.area('palma', a.alvo(-80), 65, 118), a.area('palma', a.alvo(80), 65, 118, .22),
      a.mov('pente', a.b, 44, a.edge, 30, 1.07, {atraso: .59})]],

    descartar: ['Bilhete devolvido', a => [a.mov('bilhete', a.b, 72, a.edge, a.altura, 1.08, {onda: 20})]],
    carteado: ['Recado de carteira', a => [-74, 74].map((dx, i) => a.mov('bilhete', a.b, 72, a.alvo(dx), 24, .81, {arco: 88, atraso: i * .35}))],
    chamada: ['O giz do professor', a => [a.area('lousa', a.x, 83, 148), a.mov('giz', a.b, 38, a.edge, 32, 1.05, {atraso: .48})]],
    castigo: ['Castigo em trio', a => [-115, 0, 115].map((dx, i) => a.mov('carteira', a.alvo(dx), 249, a.alvo(dx), 23, .66,
      {rx: 25, ry: 22, atraso: i * .33}))],
    apelido: ['O peso do apelido', a => {
      const meio=clamp(a.x,a.l+120,a.r-120);
      return Array.from('GORDO',(letra,i)=>{
        const x=meio+(i-2)*60;
        return a.mov('letra',x,223,x,18,.68,{letra,atraso:i*.16,rx:15,ry:17});
      });
    }],
    rasura: ['Risca esse nome!', a => [a.mov('borracha', a.b, 29, a.edge, 25, .93, {rx: 27}),
      a.mov('borracha', a.edge, 90, a.b, 78, 1.04, {atraso: 1.18, rx: 27})]],
    retrato: ['O retrato se partiu', a => [a.mov('metade1', a.x, 195, a.l, 23, 1.04, {arco: 22, rx: 22, ry: 20}),
      a.mov('metade2', a.x, 195, a.r, 23, 1.04, {arco: 22, rx: 22, ry: 20}), a.area('revelacao', a.x, 78, 155, 1.05)]],
    negativo: ['Negativos do trio', a => [-110, 0, 110].map((dx, i) => a.area('revelacao', a.alvo(dx), 68, 172, i * .35))],
    ligacao: ['Ligação de Itabuna', a => [a.mov('telefone', a.b, 67, a.edge, 40, 1.12, {onda: 24}),
      a.area('sinal', a.x, 78, 148, 1.24)]],
    promessa: ['A promessa na rodoviária', a => [a.area('sinal', a.alvo(-108), 80, 214), a.area('sinal', a.alvo(108), 80, 214),
      a.mov('passagem', a.b, 72, a.edge, 38, 1.18, {arco: 86, atraso: .55})]],
    linhaCruzada: ['A última chamada', a => [a.mov('metade1', a.l, 46, a.centro, 135, .93, {arco: 48}),
      a.mov('metade2', a.r, 46, a.centro, 135, .93, {arco: 48}), a.area('sinal', a.centro, 98, 210, 1.06),
      a.mov('passagem', a.centro, 130, a.x, 22, .88, {atraso: 1.35, onda: 18})]]
  };

  function criar(slug, x, piso, l, r, modo = {}, recuperacao = [1, .9, .8]) {
    return {slug, x, piso, l, r, gemeoX: slug === 'gemeos' ? l + 43 : null,
      fase: 1, indice: 0, estado: 'idle', tempo: 0, dur: 0, idade: 0, objetos: [], marcas: [], golpe: '',
      destino: x, avisoModo: modo.windup || 1, recuperacao};
  }
  function preparar(f, p) {
    const lista = chefes[f.slug].fases[f.fase - 1];
    f.golpe = lista[f.indice++ % lista.length];
    f.objetos = golpes[f.golpe][1](palco(f, p));
    const ritmo = 1 + (f.fase - 1) * .02;
    for (const o of f.objetos) { o.dur /= ritmo; o.atraso /= ritmo; }
    f.estado = 'windup'; f.tempo = 0;
    f.dur = Math.max(.60, (1.05 - (f.fase - 1) * .055) * f.avisoModo);
  }
  function trocar(f, fase) {
    f.fase = fase; f.indice = 0; f.estado = 'phaseChange'; f.tempo = 0;
    f.dur = f.slug === 'jorge' ? 1.65 : 1.05;
    f.objetos = []; f.marcas = []; f.golpe = '';
    return f.dur;
  }
  function ponto(o, t) {
    t = clamp(t, 0, 1);
    return {x: mix(o.x0, o.x1, t), y: mix(o.y0, o.y1, t) - (o.arco || 0) * 4 * t * (1 - t) -
      (o.onda || 0) * Math.sin(t * Math.PI * 2)};
  }
  function impacto(f, o, pos) {
    if (f.marcas.length >= 8) f.marcas.shift();
    f.marcas.push({art: o.art, x: pos.x, y: pos.y, idade: 0});
  }
  function atualizar(f, dt, p, ferir, som) {
    f.idade += dt; f.tempo += dt;
    for (let i = f.marcas.length - 1; i >= 0; i--) if ((f.marcas[i].idade += dt) > .28) f.marcas.splice(i, 1);
    if (f.estado === 'idle') { preparar(f, p); return; }
    if (f.estado === 'phaseChange' || f.estado === 'recover') {
      if (f.estado === 'recover') f.x += clamp(f.destino - f.x, -70 * dt, 70 * dt);
      if (f.tempo >= f.dur) preparar(f, p);
      return;
    }
    if (f.estado === 'windup') {
      if (f.tempo < f.dur) return;
      f.estado = 'firing'; f.tempo = 0; f.dur = Math.max(...f.objetos.map(o => o.atraso + o.dur));
      som?.(f.slug, f.fase);
    }
    for (const o of f.objetos) {
      const t = (f.tempo - o.atraso) / o.dur;
      if (t < 0 || o.fim) continue;
      const pos = ponto(o, t);
      if (o.piloto) f.x = pos.x;
      if (!o.acertou && Math.abs(p.x - pos.x) < o.rx + 13 && p.y > pos.y - o.ry && p.y - 52 < pos.y + o.ry) {
        o.acertou = true; impacto(f, o, pos); ferir(o.dano, pos.x);
      }
      if (t >= 1) { o.fim = true; if (!o.acertou) impacto(f, o, pos); }
    }
    if (f.tempo < f.dur) return;
    f.estado = 'recover'; f.tempo = 0; f.objetos = [];
    f.dur = f.recuperacao[Math.min(f.fase - 1, f.recuperacao.length - 1)] * .94;
    const dir = f.x >= p.x ? 1 : -1;
    f.destino = clamp(p.x + dir * 218, f.l + 52, f.r - 52);
  }
  function capitulo(f) { return f.slug === 'jorge' ? capitulos[f.fase - 1] : null; }
  function titulo(f) { return golpes[f.golpe]?.[0] || ''; }
  window.ConquistaCombate = Object.freeze({chefes, criar, preparar, trocar, atualizar, ponto, barras, capitulo, titulo});
})();
