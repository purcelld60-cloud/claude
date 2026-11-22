/* Conquista: coreografia em coordenadas da arena. O aviso e o dano usam a mesma trajetória. */
(() => {
  'use strict';
  const clamp = (n, min, max) => Math.min(max, Math.max(min, n));
  const mix = (a, b, t) => a + (b - a) * t;
  const tres = (a, b, c, d, e, f, g) => [[a, b, e], [c, f, a, e, b], [d, g, f, c, e, b, a]];
  const chefes = {
    creuza: { cor: '#ff96c2', fases: tres('parapeito', 'recado', 'encaminhado', 'quarteirao', 'edicao', 'varal', 'interfone') },
    tonhao: { cor: '#ffaf43', fases: tres('bandeirada', 'recibo', 'retorno', 'contramao', 'pneu', 'oleo', 'capacete') },
    valdomiro: { cor: '#ffcf74', fases: tres('rosquinha', 'quilo', 'peneira', 'balanca', 'rolo', 'fornada', 'carimbo') },
    kaua: { cor: '#76efff', fases: tres('enquadrar', 'curtidas', 'carrossel', 'reprise', 'enquete', 'corte', 'tripé') },
    barao: { cor: '#aede70', fases: tres('semeadura', 'coado', 'florada', 'safra', 'regador', 'moenda', 'terraco') },
    breno: { cor: '#ff8268', fases: tres('ribalta', 'contrapeso', 'deixa', 'bis', 'roteiro', 'mascara', 'pendulo') },
    gemeos: { cor: '#69f1dd', fases: tres('player1', 'player2', 'cabolink', 'coop', 'escape', 'invasores', 'cartucho') },
    fred: { cor: '#ffcb55', fases: tres('pao', 'pente', 'toque', 'clube', 'convite', 'pulseira', 'broche') },
    jorge: { cor: '#d2aaff', fases: [
      ['descartar', 'retratoPartido'], ['saltoBarriga', 'descartar', 'saltoBarriga', 'retratoPartido'],
      ['farpa', 'retratoPartido', 'descartar'], ['rasante', 'ruptura', 'rasante', 'farpa'],
      ['linhaCruzada', 'farpa', 'retratoPartido', 'descartar']
    ] }
  };
  const capitulos = [
    ['Bilhete sem resposta', 'bilhete', '#b5dffa'], ['O peso da lembrança', 'tenis', '#ffcb79'],
    ['Palavras que partem', 'coracao', '#ffa2ba'], ['O céu se abre', 'vitral', '#96f6ff'],
    ['Atende, sou eu', 'telefone', '#ffdb8d']
  ];
  function barras(slug, base) {
    // Jorge tinha 3,75 barras-base no motor principal. Redistribuir em cinco dá só +6,7% de vida total.
    return (slug === 'jorge' ? [.56, .68, .80, .93, 1.03] : [1, 1.25, 1.5]).map(m => Math.max(1, Math.round(base * m)));
  }

  // Gera um pequeno conjunto finito de objetos por golpe. Alturas são medidas a partir do piso.
  function palco(f, p) {
    const l = f.l + 36, r = f.r - 36;
    // Só os golpes que miram no jogador antecipam a corrida. O alvo fica travado no primeiro aviso.
    const dianteira = clamp((p.vx || 0)*Math.min(.18,(f.fase-1)*.08)/f.avisoModo, -64, 64);
    const x = clamp(p.x + dianteira, l, r), d = p.x < f.x ? -1 : 1;
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
    return {f, l, r, x, d, edge, alvo, mov, area, b: f.x, twin: f.gemeoX, centro: (l + r) / 2,
      setor: dx=>clamp(x,l+140,r-140)+dx, altura: clamp(f.piso - p.y + 27, 25, 270)};
  }

  // Cada entrada determina o desenho, a geometria, o ritmo e a abertura do golpe.
  const golpes = {
    parapeito: ['Plantão na janela', a => [a.area('janela', a.x, 78, 116)]],
    recado: ['Áudio da vizinha', a => [a.mov('audio', a.b, 68, a.edge, a.altura, 1.05, {onda: 19})]],
    encaminhado: ['Encaminhado de novo', a => [a.mov('balao', a.b, 75, a.edge, 28, .85, {arco: 55}),
      a.mov('audio', a.edge, 28, a.b, 90, 1, {atraso: .88, onda: 20})]],
    quarteirao: ['Todas as janelas!', a => [a.area('janela',a.setor(-120),105,148,0,.75),
      a.area('janela',a.setor(120),105,148,0,.75),a.area('janela',a.setor(0),115,175,.86,.60)]],

    bandeirada: ['Corta a fila!', a => [a.mov('motoTonhao',a.b,65,a.edge,65,.84,{piloto:true,rx:42,ry:19})]],
    recibo: ['Cobrança em comboio', a => window.PerseguicaoMoto.recibos(a)],
    retorno: ['Costura e volta', a => [a.mov('motoTonhao',a.b,65,a.edge,65,.82,{piloto:true,rx:41,ry:18}),
      a.mov('motoTonhao',a.edge,65,a.b,65,.79,{piloto:true,atraso:1.12,rx:41,ry:18})]],
    contramao: ['Blitz nos bagageiros', a => window.PerseguicaoMoto.setores(a,'blitz',82,true)],

    rosquinha: ['Biscoito de goma', a => [a.mov('biscoito', a.b, 58, a.x, 20, .82, {arco: 108}),
      a.mov('biscoito', a.x, 20, a.edge, 17, .78, {arco: 54, atraso: .82})]],
    quilo: ['Só vendo no quilo!', a => [a.mov('saco', a.x, 262, a.x, 20, .64, {rx: 19, ry: 20}),
      a.area('farinha', a.x, 102, 46, .64, .38)]],
    peneira: ['Sai da peneira!', a => [-88, 88].map((dx, i) => a.mov('biscoito', a.b, 70, a.alvo(dx), 17, .92, {arco: 125, atraso: i * .23}))],
    balanca: ['Balança e nuvem de polvilho', a => [-1,1].flatMap((d,i)=>[a.mov('prato',a.setor(d*96),211,a.setor(d*96),19,.54,{rx:27,ry:12,atraso:i*.26}),
      a.area('farinha',a.setor(d*96),128,76,.57+i*.26,.75)])],

    enquadrar: ['Sai do enquadramento!', a => [a.area('visor', a.x, 98, 205)]],
    curtidas: ['Chuva de curtidas', a => [-55, 55].map((dx, i) => a.mov('like', a.alvo(dx), 228, a.alvo(-dx), 18, .96, {onda: 20, atraso: i * .38}))],
    carrossel: ['Arrasta pro lado', a => [-114, 0, 114].map((n, i) => a.area('visor', a.alvo(n), 74, 196, i * .36))],
    reprise: ['Replay em tela dividida', a => [a.area('visor',a.setor(-124),118,185,0,.70),
      a.area('visor',a.setor(124),118,185,0,.70),a.area('visor',a.setor(0),130,215,.88,.57),
      a.mov('like',a.b,60,a.edge,63,1.1,{arco:55,atraso:.68})]],

    semeadura: ['Do grão ao pé de café', a => [a.mov('grao', a.b, 62, a.x, 10, .78, {arco: 103}),
      a.area('cafeeiro', a.x, 62, 125, .9, .52)]],
    coado: ['Café passado na hora', a => [a.mov('bule', a.b, 34, a.edge, 28, 1.28, {onda: 8, rx: 24, ry: 18})]],
    florada: ['Florada do cafezal', a => [-105, 0, 105].map((dx, i) => a.area('cafeeiro', a.alvo(dx), 59, 107 + i * 19, i * .3))],
    safra: ['Raízes em fileiras', a => [a.mov('grao',a.b,65,a.setor(-110),12,.61,{arco:86}),
      a.area('cafeeiro',a.setor(-110),92,138,.65,.74),a.area('cafeeiro',a.setor(110),92,138,.65,.74),
      a.area('cafeeiro',a.setor(0),108,158,1.54,.52)]],

    ribalta: ['Na mira do refletor', a => [a.area('refletor', a.x, 91, 220, 0, .45)]],
    contrapeso: ['Cuidado com o cenário!', a => [a.mov('peso', a.x, 274, a.x, 22, .57, {rx: 23, ry: 22}),
      a.mov('tabua', a.x, 13, a.edge, 13, .76, {atraso: .59, rx: 23, ry: 10})]],
    deixa: ['A deixa do Pitbull', a => [a.area('cortina', a.alvo(-76), 72, 194), a.area('cortina', a.alvo(76), 72, 194, .23),
      a.mov('luva', a.b, 47, a.x, 42, .54, {piloto: true, atraso: .74, rx: 24, ry: 17})]],
    bis: ['Último ato!', a => [a.area('refletor',a.setor(0),110,220,0,.63),
      a.area('cortina',a.setor(-128),96,204,.81,.81),a.area('cortina',a.setor(128),96,204,.81,.81),
      a.mov('tabua',a.x,14,a.b,14,.76,{atraso:1.65,rx:25,ry:10})]],

    player1: ['Ryan • comando baixo', a => [a.mov('controle1', a.b, 44, a.edge, 25, 1.1)]],
    player2: ['Bryan • comando aéreo', a => [a.mov('controle2', a.twin, 80, a.x, 20, .87, {arco: 78}),
      a.mov('controle2', a.x, 20, a.twin, 82, .85, {arco: 43, atraso: .88})]],
    cabolink: ['Cabo link desconectado', a => [a.mov('plug1', a.b, 26, a.twin, 27, 1.12, {rx: 20}),
      a.mov('plug2', a.twin, 96, a.b, 94, 1.12, {atraso: .34, rx: 20})]],
    coop: ['Checkpoint para dois', a => [a.mov('controle1',a.b,40,a.x,27,.80),
      a.mov('controle2',a.twin,84,a.x,29,.86,{arco:72,atraso:.30}),
      a.area('checkpoint',a.setor(-116),101,132,1.12,.72),a.area('checkpoint',a.setor(116),101,132,1.12,.72),
      a.area('checkpoint',a.setor(0),105,116,1.98,.46)]],

    pao: ['Pão de queijo ou biscoito?', a => [a.mov('pao', a.b, 66, a.x, 18, .82, {arco: 90}),
      a.mov('pao', a.x, 18, a.edge, 18, .73, {arco: 62, atraso: .82})]],
    pente: ['Pente do topete', a => [a.mov('pente', a.b, 75, a.edge, a.altura, .86, {arco: 48}),
      a.mov('pente', a.edge, 38, a.b, 63, .97, {atraso: .95})]],
    toque: ['Topete, topete… toca aqui!', a => [a.area('palma', a.x, 68, 97), a.area('palma', a.alvo(a.d * 96), 68, 111, .36),
      a.mov('pao', a.b, 62, a.x, 23, .78, {arco: 84, atraso: .82})]],
    clube: ['Roda do Clube do Topete', a => [a.area('palma',a.setor(-112),109,121,0,.72),
      a.area('palma',a.setor(112),109,121,0,.72),a.area('palma',a.setor(0),108,145,.88,.57),
      a.mov('pente',a.b,47,a.edge,37,.96,{atraso:1.16})]],

    edicao: ['Edição extra!', a => [a.mov('jornal', a.b, 81, a.x, 20, .81, {arco: 95, rx: 23}),
      a.mov('jornal', a.x, 20, a.edge, 33, .63, {atraso: .82, onda: -16, rx: 23})]],
    varal: ['Roupa suja no varal', a => [-84, 40].map((v,i) => a.mov('pregador', a.alvo(v), 220, a.alvo(v+34), 19, .59, {atraso: i*.38, ry: 21}))],
    interfone: ['Tocou no prédio errado', a => [a.mov('fone', a.b, 64, a.edge, 62, .83, {onda: 28, rx: 22}),
      a.mov('fone', a.edge, 62, a.x, 20, .72, {atraso: .85, arco: 50, rx: 22})]],
    pneu: ['Pneu sem freio', a => [a.mov('pneu',a.b,74,a.edge,73,1.12,{quiques:3,arco:64,rx:19,ry:19})]],
    oleo: ['Derrapagem • troque de moto', a => window.PerseguicaoMoto.setores(a,'oleo',41,a.f.fase>=3)],
    capacete: ['Capacete de carona', a => [a.mov('capacete',a.b,113,a.x,a.altura,.72,{arco:76,rx:21}),
      a.mov('capacete',a.x,a.altura,a.b,100,.68,{atraso:.81,onda:-18,rx:21})]],
    rolo: ['Abre essa massa!', a => [a.mov('rolo', a.b, 14, a.edge, 14, .80, {rx: 29, ry: 11})]],
    fornada: ['Tabuleiro quente', a => [a.mov('forma', a.b, 72, a.x, 15, .76, {arco: 108, rx: 27, ry: 11}),
      a.area('vapor', a.x, 60, 110, .80, .53)]],
    carimbo: ['Selo da feira', a => [0, -95, 88].map((dx,i) => a.mov('carimbo', a.alvo(dx), 177, a.alvo(dx), 13, .43, {atraso: i*.36, rx: 23, ry: 13}))],
    enquete: ['Vota na enquete!', a => [-1,1].map((s,i) => a.mov('voto', s<0?a.l:a.r, 37+i*66, a.x, 37+i*66, .78, {letra: i?'B':'A', rx: 23, atraso: i*.22}))],
    corte: ['Corta esse take', a => [a.mov('tesoura', a.b, 138, a.edge, 17, .73, {rx: 22}),
      a.mov('tesoura', a.edge, 17, a.b, 129, .83, {atraso: .82, rx: 22})]],
    tripé: ['Caiu a câmera!', a => [a.mov('camera', a.x, 224, a.x, 23, .56, {rx: 23, ry: 20}),
      a.area('visor', a.alvo(a.d*87), 68, 84, .70)]],
    regador: ['Aguaceiro no talhão', a => [-86,-4,78].map((dx,i) => a.mov('gota', a.alvo(dx-28), 180+i*10, a.alvo(dx), 14, .64, {arco: 25, atraso: i*.19, rx: 10, ry: 17}))],
    moenda: ['Manivela da moenda', a => [a.mov('moenda', a.b, 35, a.edge, 33, .97, {quiques: 2, arco: 39, rx: 21, ry: 21})]],
    terraco: ['Rodo do terreiro', a => [a.mov('rodo', a.edge, 19, a.b, 19, .89, {rx: 30, ry: 16}),
      a.mov('grao', a.b, 24, a.x, 38, .80, {atraso: .92, arco: 82})]],
    roteiro: ['Página arrancada', a => [a.mov('roteiro', a.b, 77, a.edge, 52, 1, {onda: 46, rx: 19})]],
    mascara: ['Troca de máscara', a => [-1,1].map((d,i) => a.mov('mascara', i?a.r:a.l, 105-i*65, a.alvo(d*28), 40+i*53, .80, {onda: 20*d, atraso: .28*i, rx: 18, ry: 20}))],
    pendulo: ['Lustre fora da marca', a => [a.mov('lustre', a.alvo(-140), 145, a.alvo(140), 145, .94, {arco: -100, rx: 30, ry: 19}),
      a.mov('lustre', a.alvo(140), 145, a.alvo(-140), 145, .89, {arco: -100, atraso: .97, rx: 30, ry: 19})]],
    escape: ['Cadê o ESC?', a => [-67,67].map((dx,i) => a.mov('tecla', a.alvo(dx), 204, a.alvo(dx), 18, .53, {atraso: i*.36, rx: 22, ry: 17}))],
    invasores: ['Invasão de oito bits', a => [0,1,2].map(i => a.mov('invasor', i%2?a.twin:a.b, 32+i*36, i%2?a.r:a.l, 32+i*36, .98, {onda: 13, atraso: i*.26, rx: 18}))],
    cartucho: ['Assopra o cartucho!', a => [a.mov('cartucho', a.b, 63, a.twin, 32, .76, {arco: 70}),
      a.mov('cartucho', a.twin, 32, a.x, 17, .62, {arco: 55, atraso: .81})]],
    convite: ['Seu nome ficou de fora', a => [a.mov('convite', a.b, 65, a.x, 22, .83, {onda: 33, rx: 23}),
      a.mov('convite', a.x, 22, a.edge, 92, .62, {atraso: .84, rx: 23})]],
    pulseira: ['Pulseira de melhores amigos', a => [a.mov('pulseira', a.b, 37, a.edge, 42, .69, {onda: 16, rx: 23}),
      a.mov('pulseira', a.edge, 42, a.b, 85, .90, {atraso: .74, arco: 63, rx: 23})]],
    broche: ['Chuva de distintivos', a => [-90,0,90].map((dx,i) => a.mov('broche', a.alvo(-dx), 220, a.alvo(dx), 18, .89, {atraso: i*.13, rx: 13, ry: 17}))],

    descartar: ['Bilhete devolvido', a => [a.mov('bilhete', a.b, 73, a.edge, a.altura, .91, {onda: 24})]],
    retratoPartido: ['Rasgou a nossa foto', a => [-1,1].map((d,i) => a.mov(i?'metade2':'metade1', a.x, 190, i?a.r:a.l, 23, .99, {arco: 27, rx: 21, ry: 20}))],
    saltoBarriga: ['Sai de baixo!', a => {
      const meio = a.alvo(-a.d*78), final = a.alvo(a.d*34);
      return [a.mov('barriga', a.b, 52, meio, 52, .79, {corpo: 52, arco: 145, rx: 39, ry: 45, dano: 20}),
        a.mov('barriga', meio, 52, final, 52, .59, {corpo: 52, arco: 86, atraso: .88, rx: 39, ry: 45, dano: 18})];
    }],
    farpa: ['Palavras que partem', a => {
      const falas = ['O trio já era.', 'Nem senti falta.', 'Você ficou pra trás.', 'Era só por pena.'];
      const fala = falas[a.f.farpas++ % falas.length], rx = Math.ceil(fala.length*3.65)+7;
      const altura = a.f.piso-a.f.y+57;
      return [a.mov('farpa', clamp(a.b,a.f.l+rx,a.f.r-rx), altura, clamp(a.edge,a.f.l+rx,a.f.r-rx), a.altura, 1.23, {palavra: fala, rx, ry: 15, onda: 13})];
    }],
    rasante: ['Rasante da saudade', a => [a.mov('rasante', a.b, a.f.piso-a.f.y+40, a.alvo(a.d*45),
      clamp(a.altura,62,198), .97, {corpo: 40, arco: -19, rx: 24, ry: 38, dano: 18})]],
    ruptura: ['Metade do céu vai cair', a => window.JorgeDuelo.marcar(a.f).map(i => ({
      art: 'fratura', ilha: i.id, x0: i.x+i.w/2, x1: i.x+i.w/2, y0: i.y-5, y1: i.y-5,
      rx: i.w/2, ry: 7, atraso: 0, dur: .28, dano: 15, area: true
    }))],
    linhaCruzada: ['A última chamada', a => [a.mov('metade1', a.l, 46, a.centro, 135, .93, {arco: 48}),
      a.mov('metade2', a.r, 46, a.centro, 135, .93, {arco: 48}), a.area('sinal',a.setor(-116),108,183,.91,.69),
      a.area('sinal',a.setor(116),108,183,.91,.69),
      a.mov('passagem', a.centro, 130, a.x, 22, .88, {atraso: 1.35, onda: 18})]]

  };

  function criar(slug, x, piso, l, r, modo = {}, recuperacao = [1, .9, .8]) {
    const f={slug, x, y: piso, piso, l, r, ceu: null, estrada: null, farpas: 0, gemeoX: slug === 'gemeos' ? l + 43 : null,
      fase: 1, indice: 0, estado: 'idle', tempo: 0, dur: 0, idade: 0, objetos: [], marcas: [], golpe: '',
      destino: x, avisoModo: modo.windup || 1, recuperacao, jogadorAnteriorX: null, jogadorAnteriorY: null};
    if(slug==='tonhao'){ f.estrada=window.PerseguicaoMoto.criar(l,r,piso); f.y=piso-65; window.PerseguicaoMoto.novaFase(f,1); }
    return f;
  }
  function terreno(f) {
    return f?.estrada ? window.PerseguicaoMoto : f?.ceu ? window.JorgeDuelo : null;
  }
  function preparar(f, p) {
    const lista = chefes[f.slug].fases[f.fase - 1];
    f.golpe = lista[f.indice++ % lista.length];
    f.objetos = golpes[f.golpe][1](palco(f, p));
    const ritmo = (1.42 + (f.fase - 1)*.085) / Math.sqrt(f.avisoModo);
    for (const o of f.objetos) { o.dur /= ritmo; o.atraso /= ritmo; }
    f.estado = 'windup'; f.tempo = 0;
    const aviso = f.golpe === 'ruptura' ? 1.24 : f.golpe === 'saltoBarriga' ? .91 : .78 - (f.fase-1)*.04;
    f.dur = Math.max(f.golpe === 'ruptura' ? 1.10 : .52, aviso*f.avisoModo);
  }
  function trocar(f, fase, jogador) {
    if (f.slug === 'jorge') window.JorgeDuelo.mudar(f, fase, jogador);
    if(f.estrada)window.PerseguicaoMoto.novaFase(f,fase);
    f.fase = fase; f.indice = 0; f.estado = 'phaseChange'; f.tempo = 0;
    f.dur = f.slug === 'jorge' ? 1.65 : 1.05;
    f.objetos = []; f.marcas = []; f.golpe = ''; f.jogadorAnteriorX=f.jogadorAnteriorY=null;
    return f.dur;
  }
  function ponto(o, t) {
    t = clamp(t, 0, 1);
    return {x: mix(o.x0, o.x1, t), y: mix(o.y0, o.y1, t) - (o.arco || 0) * (o.quiques ? Math.abs(Math.sin(t*Math.PI*o.quiques)) : 4*t*(1-t)) -
      (o.onda || 0) * Math.sin(t * Math.PI * 2)};
  }
  // Interseção contínua entre o segmento do golpe e a caixa do herói, em movimento relativo.
  function cruzaCaixa(x0,y0,x1,y1,rx,ry) {
    const dx=(x1-x0)/2, dy=(y1-y0)/2, cx=x0+dx, cy=y0+dy;
    return Math.abs(cx)<rx+Math.abs(dx) && Math.abs(cy)<ry+Math.abs(dy) &&
      Math.abs(cx*dy-cy*dx)<=rx*Math.abs(dy)+ry*Math.abs(dx);
  }
  function contatoNoQuadro(o, fim, tempo, dt, p, xAntes, yAntes) {
    const inicio = Math.max(tempo-dt,o.atraso), termino = Math.min(tempo,o.atraso+o.dur);
    const fracao = instante => dt>0 ? clamp(1-(tempo-instante)/dt,0,1) : 1;
    const inicioRel = (inicio-o.atraso)/o.dur, primeiro = ponto(o,inicioRel), u = fracao(inicio);
    let x0=primeiro.x-mix(xAntes,p.x,u), y0=primeiro.y-mix(yAntes,p.y,u)+26;
    // Curvas são amostradas até 60 Hz. Um projétil em linha reta precisa de um único segmento.
    const passos = o.arco||o.onda ? Math.max(1,Math.ceil((termino-inicio)*60)) : 1;
    for(let i=1;i<=passos;i++){
      const instante=mix(inicio,termino,i/passos), v=fracao(instante);
      const pos=i===passos ? fim : ponto(o,(instante-o.atraso)/o.dur);
      const x1=pos.x-mix(xAntes,p.x,v), y1=pos.y-mix(yAntes,p.y,v)+26;
      if(cruzaCaixa(x0,y0,x1,y1,o.rx+13,o.ry+26)) return true;
      x0=x1; y0=y1;
    }
    return false;
  }
  function impacto(f, o, pos) {
    if (f.marcas.length >= 8) f.marcas.shift();
    f.marcas.push({art: o.art, x: pos.x, y: pos.y, idade: 0});
  }
  function atualizar(f, dt, p, ferir, som) {
    const xAntes=f.jogadorAnteriorX ?? p.x, yAntes=f.jogadorAnteriorY ?? p.y;
    f.jogadorAnteriorX=p.x; f.jogadorAnteriorY=p.y;
    f.idade += dt; f.tempo += dt;
    if (f.ceu) window.JorgeDuelo.flutuar(f, dt);
    for (let i = f.marcas.length - 1; i >= 0; i--) if ((f.marcas[i].idade += dt) > .28) f.marcas.splice(i, 1);
    if (f.estado === 'idle') { preparar(f, p); return; }
    if (f.estado === 'phaseChange' || f.estado === 'recover') {
      if (f.estado === 'recover') {
        const passo=(128+10*(f.fase-1))*dt;
        f.x+=clamp(f.destino-f.x,-passo,passo);
      }
      if (f.tempo >= f.dur) preparar(f, p);
      return;
    }
    if (f.estado === 'windup') {
      if (f.tempo < f.dur) return;
      f.tempo -= f.dur; f.estado = 'firing'; f.dur = Math.max(...f.objetos.map(o => o.atraso + o.dur));
      if (f.golpe === 'ruptura') window.JorgeDuelo.romper(f,p);
      som?.(f.slug, f.fase);
    }
    for (const o of f.objetos) {
      const t = (f.tempo - o.atraso) / o.dur;
      if (t < 0 || o.fim) continue;
      const pos = ponto(o, t);
      if (o.piloto || o.corpo) f.x = pos.x;
      if (o.corpo) f.y = pos.y + o.corpo;
      if (!o.acertou && contatoNoQuadro(o,pos,f.tempo,dt,p,xAntes,yAntes)) {
        o.acertou = true; impacto(f, o, pos); ferir(o.dano, pos.x);
      }
      if (t >= 1) { o.fim = true; if (!o.acertou) impacto(f, o, pos); }
    }
    if (f.tempo < f.dur) return;
    f.estado = 'recover'; f.tempo = 0; f.objetos = [];
    const base = f.recuperacao[Math.min(f.fase-1, f.recuperacao.length-1)];
    f.dur = Math.max(.30, base*(.70-(f.fase-1)*.015));
    const dir = f.x >= p.x ? 1 : -1;
    f.destino = clamp(p.x + dir * 218, f.l + 52, f.r - 52);
  }
  function capitulo(f) { return f.slug === 'jorge' ? capitulos[f.fase - 1] : null; }
  function titulo(f) { return golpes[f.golpe]?.[0] || ''; }
  window.ConquistaCombate = Object.freeze({chefes, criar, preparar, trocar, atualizar, ponto, barras, capitulo, titulo, terreno});
})();
