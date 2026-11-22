/* Adereços e efeitos da Conquista. Pixels nítidos em qualquer escala, sem um emissor por partícula. */
(() => {
  'use strict';
  const combate = window.ConquistaCombate;
  const P = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const tinta = '#221d31', branco = '#fff4d8';
  // '#' é o contorno, '1' a sombra, '2' a cor local, '3' a luz e '4' o detalhe.
  const desenhos = {
    jornal: ['#737988 #e1ddc7 #fff3ce #c34853','..########## .#333333332# #3334444332# #3322233222# #3313133312# #3313131312# .#222222222# ..##########'],
    pregador: ['#7c563f #cf9763 #ffe1a2 #88929c','...###.### ...#3#.#2# ...#3#.#2# ...#33#22# ....#343# ....#244# ....#232# ...#32#22# ...#32#22# ...###.###'],
    fone: ['#714263 #b9608b #ffb6c5 #543b5e','..#######. .#3322222# #322###222# #32#...#22# #22#...#11# .###....###'],
    pneu: ['#384358 #566373 #bdc3ae #d68c3e','...######... ..#323232#.. .#22244222#. #3224##4222# #224#33#422# #224#33#422# #2224##4223# .#22244222#. ..#232323#.. ...######...'],
    capacete: ['#925433 #e77e37 #ffe098 #365268','...######... ..#332222#.. .#33222222#. #3224444444# #2224443334# #2222444444# .#2222211#.. ..#11111#... ...#####....'],
    rolo: ['#965c39 #d19963 #ffe3a5 #6b4131','....########.... ...#33333332#... ####32222222#### #44323232322244# ####21111111#### ...##########...'],
    forma: ['#5b687a #91a2aa #e4dcab #b57d47','..##########.. .#3333333333#. #234434434432# #234434434432# #322222222222# .#1111111111#. ..##########..'],
    carimbo: ['#664b42 #b37446 #ffe3aa #ab4b4a','...######... ..#332222#.. ..#222222#.. ...#2222#... ....#11#.... ..##2222##.. .#33333332#. #4444444444# .##########.'],
    voto: ['#57417a #a576c8 #f4e5fd #5bbcca','..########... .#33333332#.. #3222222222#. #3222222222#. .#222222222#. ..###222###.. .....##......'],
    tesoura: ['#9c4557 #cb6473 #e6eadb #76939c','.......###... ....###33#... .###333##.... #222####..... #2#24#....... .##224###.... #2#2#.433##.. #222#..##33## .###.....####'],
    camera: ['#36435f #617688 #e0eece #ef6569','....####..... ...#3333#.### .########.#3# #22332222#33# #22442222#23# #22442222#2## #22222222#... .########....'],
    gota: ['#346d79 #67b7bb #d7f3cf #719daa','.....#.... ....#2#... ....#3#... ...#32#... ..#3322#.. .#332222#. #32222222# #22222112# .#211112#. ..######..'],
    moenda: ['#594c47 #936b51 #deb27e #a5b0a1','....##..##.... ..##22##22##.. .#2333222232#. #232222422223# #222244442222# .#2241144222#. #222244442222# #222222222223# .#2222222122#. ..##22##22##.. ....##..##....'],
    rodo: ['#714c39 #a7724d #eac797 #466661','.........###.. ........#32#.. .......#32#... ......#32#.... .....#32#..... .###########.. #33333333332#. #44444444444#. .###########..'],
    roteiro: ['#967b65 #ddc69f #fff2ca #ba555e','..########. .#33333332# #334443332# #333333332# #311313332# #333313112# #311333332# .#23223232# ..##.##.##.'],
    mascara: ['#874558 #c87c76 #ffdda4 #4b3852','########### #322222223# #334222433# #344424443# #322222222# .#3244422#. .#2422242#. ..#22222#.. ...#211#... ....###....'],
    lustre: ['#7f5a46 #c79057 #ffdc87 #ecad5f','.....###..... .....#2#..... .#...#2#...#. #3#..#2#..#3# #4#.#33#..#4# .#222222222#. ..##22222##.. ....#333#.... .....###.....'],
    tecla: ['#365368 #708ba0 #c6f5db #5bd4c3','..########.. .#33333332#. #3222222222# #3222222222# #3222222222# .#211111112# ..##########'],
    invasor: ['#31536b #63cbaa #b4ffcd #df88b5','..#.....#.. ...#...#... ..#22222#.. .#2242422#. #332222233# #2#22222#2# #2#.....#2# ...##.##...'],
    cartucho: ['#66526d #938099 #facedb #58baa8','..#########. .#333333332# #2233333222# #2244444222# #2243344222# #2244444222# #2222222212# .#13131313#. ..#########.'],
    convite: ['#83616c #d39b96 #ffdeaf #ab5466','############ #3222222223# #3322222232# #2233223322# #2223443222# #2233443322# #3322222232# ############'],
    pulseira: ['#97664a #d69c5a #ffe0a3 #db7c98','...#######... ..#3434343#.. .#34#####43#. #34#.....#43# #43#.....#34# #34#.....#43# .#43#####34#. ..#3434343#.. ...#######...'],
    broche: ['#9e6740 #dbad56 #ffeab0 #bb6272','....###.... ..##323##.. .#3322233#. #322333222# #322232222# .#2222222#. ..##323##.. ..#44#44#.. .#44#.#44#. .###...###.'],
    tenis: ['#63546a #de9b64 #fff0af #a86251','....#####... ...#22223#.. ..#224433#.. .#2234433##. #2222222222# #3333333333# .##########.'],
    coracao: ['#8c4464 #d76883 #ffd2b6 #4b3c63','.###..###. #332##222# #33224222# #22242222# .#222422#. ..#2422#.. ...#42#... ....##....'],
    vitral: ['#4768a0 #73bad0 #d7fff0 #c098da','.....#..... ....#3#.... ...#324#... ..#32244#.. .#3224444#. #332244444# .#3224444#. ..#32444#.. ...#324#... ....#2#.... .....#.....'],
    audio: ['#914176 #ef82ae #fff1d8 #694371','..##########. .#3333333333# #322222222223# #323232323223# #323232323223# .#3333333333#. ..##2#######. ..##.........'],
    balao: ['#934370 #ef8fb8 #ffefda #753255','..##########. .#3333333333# #333333333333# #334334334333# #334334334333# .#3333333333#. ..###22#####. ....#2#...... ....##.......'],
    moto: ['#783b30 #f58326 #ffeea7 #91bbbd','..............###..... ..........####33#..... ...#####..#22#.##..... ...#111#####22#4#..... ....#22222222#44##.... ..####2222221142###... .#444#22211###44444#.. #44114#11##..#41114#.. #414114#..#..#41414#.. .#4444#.......#4444#.. ..####.........####...'],
    recibo: ['#a58457 #efd6a0 #fff4d6 #c86531','..########.. ..#333333#.. ..#344443#.. ..#333333#.. ..#311133#.. ..#311313#.. ..#333333#.. ..#344443#.. ..#232323#.. ..##.#.##...'],
    cone: ['#ac4527 #f48031 #fff1ca #d4592a','....##.... ...#22#... ...#33#... ..#3333#.. ..#2222#.. .#222222#. #11111111#'],
    biscoito: ['#aa6d37 #e9b65c #ffe8a0 #c88d4d','...######... ..#322223#.. .#32244223#. #322#..#222# #322....222# #222....242# #242#..#222# .#22222221#. ..#211121#.. ...######...'],
    saco: ['#97724e #dcb584 #fff0bd #a15132','...#2#2#... ....#4#.... ...#222#... ..#33322#.. .#3332222#. #222344322# #223444322# #223443222# #222222221# .#1111111#. ..#######..'],
    prato: ['#72645a #b0b9ad #fff1ae #bd8d43','.....###..... .....#2#..... ....#...#.... ...#.....#... ..#.......#.. .#.........#. #33333333333# .#222222222#. ..#1111111#.. ...#######...'],
    like: ['#9c315d #f14f85 #ffd9c8 #dc3c78','..###..###.. .#332##222#. #3322222222# #3222222222# .#22222221#. ..#222221#.. ...#2221#... ....#21#.... .....##.....'],
    grao: ['#673e2b #9a6037 #f5c479 #65322f','....#####... ..##33222#.. .#33224222#. #3222422222# #3224422222# #2224222221# .#24222221#. ..#222221#.. ...######...'],
    bule: ['#315276 #639d9d #ffe294 #d79043','.....####...... ....#3333#..... .##.######.###. #22#333222#..2# .#22333222#..2# ..#2332222###2# ...#222222#..## ...#222244#.... ....#1144#..... .....####......'],
    peso: ['#573e52 #8b7180 #f4b763 #e07943','....###.... ....#2#.... ...#333#... ..#22222#.. .#2222222#. #244222442# #224424422# #222444222# #222242221# .#1111111#. ..#######..'],
    tabua: ['#84462e #b77341 #ffd087 #62404a','..############.. .#332222222222#. #44422211222444# .#222222222221#. ..############..'],
    luva: ['#833545 #ef644e #ffb980 #fcda88','....######.. ..##322322#. .#322222222# #3322222222# #32222222##. .#22222221#. ..#111111#.. ..#444444#.. ...######...'],
    controle1: ['#17525b #30b9c5 #bbfff1 #fbdb72','...###..###... ..#222##222#.. .#3332222222#. #222322224422# #223332242422# #222322224422# #2211####1122# .###......###.'],
    controle2: ['#6b3c76 #db6eb2 #ffcee2 #8ef4f0','...###..###... ..#222##222#.. .#3332222222#. #222322224422# #223332242422# #222322224422# #2211####1122# .###......###.'],
    plug1: ['#214d68 #54b8c8 #d1fff2 #ffbd6c','..#########. ..#3333333#. ##22244222## #2222222222# ##111111111# ..##44####.. ...####.....'],
    plug2: ['#754465 #dc74ae #ffe3ec #a6f6ed','..#########. ..#3333333#. ##22244222## #2222222222# ##111111111# ..##44####.. ...####.....'],
    pao: ['#9c5d32 #eaa655 #ffe19a #d18c46','....####.... ..##3333##.. .#33323332#. #3322233322# #3322224222# #2224222242# .#22222221#. ..#111111#.. ...######...'],
    pente: ['#644051 #ad5572 #ffda8a #f7a85d','..###########. .#33333333333# #222222222222# .#2#2#2#2#2##. .#2#2#2#2#2#.. .#2#2#2#2#2#.. .#.#.#.#.#.#..'],
    palma: ['#a46d44 #e9a85c #ffe0a3 #ed8d52','.....##...... ...###3###... ..#32#3#32##. ..#32#3#32#2# ..#3222222#2# ##.222222222# #32#22222222# .#3222222221# ..#22222221#. ...#211111#.. ....######...'],
    bilhete: ['#7c88a1 #adc2d5 #fff1d4 #ca727b','###########. #3333333322# #3344443322# #3333333322# #3311113322# #3333333322# #3322222222# .##########.'],
    carteira: ['#805233 #ba8250 #f7ce80 #a7bfbd','..##########. .#333333333# #3333333333# .#22222222## ..####4##4#. ...#..4##4.. ...#..4##4.. ...##.4##4.. ....##4##4.. ......##.##.'],
    giz: ['#658c83 #a8cbb1 #f7ffdb #669b8f','..###########. .#33333333333# #222222222223# .############.'],
    borracha: ['#844e70 #ce6995 #ffc7c1 #778da9','....#########.. ...#333222222#. ..#3332222221#. .#3332222221##. #4444444411##.. .#44444441##... ..#########....'],
    telefone: ['#4c4268 #8d78c2 #e7d7ff #7ef1c5','...######... ..#233332#.. ..#111111#.. ..#144441#.. ..#143341#.. ..#144441#.. ..#111111#.. ..#143341#.. ..#111111#.. ..#223322#.. ...######...'],
    passagem: ['#66567f #c6a1ce #fff1cb #85516f','..###########. .#33333333332# #343444344332# .#33333333332# #344434433332# .#33333333332# ..###########.']
  };
  const cache = new Map();
  function imagem(chave) {
    if (cache.has(chave)) return cache.get(chave);
    const [paleta, mapa] = desenhos[chave], linhas = mapa.split(' '), cores = [tinta, ...paleta.split(' ')];
    const img = document.createElement('canvas');
    img.width = Math.max(...linhas.map(l => l.length)); img.height = linhas.length;
    const q = img.getContext('2d');
    linhas.forEach((l, y) => { for (let x = 0; x < l.length; x++) if (l[x] !== '.') P(q, x, y, 1, 1, cores[l[x] === '#' ? 0 : +l[x]]); });
    cache.set(chave, img); return img;
  }
  function selo(c, chave, x, y, w, h, dir = 1) {
    const img = imagem(chave);
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(dir, 1); c.imageSmoothingEnabled = false;
    c.drawImage(img, -Math.round(w / 2), -Math.round(h / 2), w, h); c.restore();
  }
  function texto(c, s, x, y, cor, px = 12) {
    c.save(); c.textAlign = 'center'; c.textBaseline = 'middle'; c.font = 'bold ' + px + 'px monospace';
    c.lineWidth = 3; c.strokeStyle = tinta; c.strokeText(s, x, y); c.fillStyle = cor; c.fillText(s, x, y); c.restore();
  }
  function cantos(c, x, y, w, h, cor, ponta = 9) {
    for (const dx of [-1, 1]) for (const dy of [-1, 1]) {
      const ex = x + dx * w / 2, ey = y + dy * h / 2;
      P(c, ex - (dx > 0 ? ponta : 0), ey, ponta, 3, cor);
      P(c, ex, ey - (dy > 0 ? ponta : 0), 3, ponta, cor);
    }
  }
  function risco(c, pts, cor, grossura = 3) {
    c.beginPath(); pts.forEach(([x,y], i) => i ? c.lineTo(Math.round(x), Math.round(y)) : c.moveTo(Math.round(x), Math.round(y)));
    c.strokeStyle = cor; c.lineWidth = grossura; c.stroke();
  }
  function retrato(c, x, y, w, h, lado = 0) {
    c.save(); c.translate(x, y); c.scale(w / 50, h / 44);
    if (lado) { c.beginPath(); c.moveTo(0,-22); c.lineTo(-3,-12); c.lineTo(2,-4); c.lineTo(-2,4); c.lineTo(2,12); c.lineTo(0,22); c.lineTo(lado*25,22); c.lineTo(lado*25,-22); c.closePath(); c.clip(); }
    P(c,-25,-22,50,44,tinta); P(c,-23,-20,46,40,'#fff0cf'); P(c,-20,-17,40,29,'#dfae7d'); P(c,-20,5,40,7,'#9b8261');
    // Foto de escola em três tons: chapéu do Da Roça, Reeis no meio e Jorge à direita.
    for (const [bx,pele,roupa] of [[-13,'#c68453','#71a774'],[0,'#89593e','#8ea4d1'],[13,'#c99167','#aa7aa5']]) {
      P(c,bx-5,2,10,9,roupa); P(c,bx-4,-9,8,11,pele); P(c,bx-4,-10,8,3,'#4c3840');
    }
    P(c,-20,-10,14,2,'#926c46'); P(c,-17,-13,8,4,'#d9af6f'); P(c,-12,15,24,1,'#b9987e'); c.restore();
  }
  function movel(c, o, p, t, cor) {
    const {x,y} = p, dir = o.x1 >= o.x0 ? 1 : -1, w = o.rx * 2, h = o.ry * 2;
    if (o.corpo) return; // O corpo e a aura já são desenhados na posição que causa dano.
    if (o.art === 'farpa') {
      P(c,x-o.rx,y-14,w,25,tinta); P(c,x-o.rx+2,y-12,w-4,21,'#722e51');
      P(c,x-o.rx+3,y-12,w-6,2,'#f6b2bd');
      risco(c,[[x-o.rx+8,y+10],[x-o.rx+8,y+16],[x-o.rx+15,y+10]],'#722e51',4);
      texto(c,o.palavra,x,y-1,'#fff1df',12); return;
    }
    if (o.art === 'metade1' || o.art === 'metade2') {
      const lado = o.art === 'metade1' ? -1 : 1;
      retrato(c,x-lado*w/2,y,w*2,h,lado); return;
    }
    if (o.art === 'peso' || o.art === 'prato') {
      risco(c,[[x,y-h/2],[x+2,y-52],[x+2,o.y0-33]],'#3e3037',3);
      if (o.art === 'prato') risco(c,[[x-15,y-7],[x,y-31],[x+15,y-7]],'#e4c78f',2);
    }
    if (/^(controle|plug)/.test(o.art)) {
      const cabo = [];
      for (let i = 0; i <= 12; i++) { const q = i / 12; cabo.push([o.x0+(x-o.x0)*q, o.y0+(y-o.y0)*q+18*Math.sin(q*Math.PI)+4*Math.sin(6*q+t*5)*Math.sin(q*Math.PI)]); }
      risco(c,cabo,tinta,4); risco(c,cabo,o.art.endsWith('2')?'#ee85b9':'#5fcbd1',2);
    }
    if(o.art==='pneu'||o.art==='moenda'){
      c.save(); c.translate(Math.round(x),Math.round(y)); c.rotate(Math.round(dir*t*24)*Math.PI/12);
      selo(c,o.art,0,0,w,h); c.restore(); return;
    }
    if(o.art==='lustre'){
      risco(c,[[(o.x0+o.x1)/2,o.y0-64],[x,y-h/2]],'#d6ac80',3);
    }
    selo(c,o.art,x,y,w,h,dir);
    if(o.art==='tecla'||o.art==='voto')texto(c,o.letra||'ESC',x,y-1,branco,11);
    if (o.art === 'moto') {
      for(let i=1;i<=4;i++) P(c,x-dir*(32+i*8),y+12-i%2*4,6,3,i%2?'#efd6a4':'#8b7974');
    } else if (o.art === 'audio' || o.art === 'telefone') {
      for (const s of [-1,1]) { const q=x+s*(w/2+4); risco(c,[[q,y-6],[q+s*3,y-3],[q+s*3,y+3],[q,y+6]],cor,2); }
    } else if (o.art === 'borracha') {
      for(let i=1;i<=4;i++) P(c,x-dir*(23+i*8),y+i%2*4,6,2,'#f4c4bb');
    } else if (o.art === 'bule') {
      for(let i=0;i<3;i++) risco(c,[[x-8+i*7,y-13],[x-10+i*7,y-19],[x-7+i*7,y-22-i%2*3]],'#f9dbac',2);
    }
  }
  function zona(c, o, u, cor) {
    const x=o.x0, bot=o.y0+o.ry, top=o.y0-o.ry, w=o.rx*2, h=o.ry*2, l=x-o.rx;
    const pulsa = Math.sin(Math.PI * u);
    P(c,l,bot-4,w,4,cor); cantos(c,x,o.y0,w-2,h-3,cor,7);
    c.save(); c.globalAlpha *= .14 + .10*pulsa; P(c,l,top,w,h,cor); c.restore();
    switch(o.art) {
      case 'fratura':
        for(let k=-2;k<=2;k++)risco(c,[[x+k*w*.17-3,bot],[x+k*w*.17,top-3-Math.sin(u*Math.PI)*7],[x+k*w*.17+4,bot]],'#ffe3a7',2);
        break;
      case 'oleo':
        P(c,l+5,bot-9,w-10,7,'#302d44'); P(c,l+13,bot-14,w-27,6,'#50455f');
        for(let i=0;i<4;i++)P(c,l+12+i*w*.19,bot-10-i%2*4,9,2,i%2?'#a1a9b7':'#947e9c'); break;
      case 'vapor':
        selo(c,'forma',x,bot-5,w*.92,13);
        for(let i=0;i<3;i++){const xx=x+(i-1)*13;risco(c,[[xx,bot-9],[xx-5,bot-h*.32],[xx+4,bot-h*.59],[xx-3,top+7+i*3]],i%2?'#ecc998':'#ffead1',4);} break;
      case 'janela': {
        const y=top+5, aba=Math.max(5,Math.round(w*(.25-.17*pulsa)));
        P(c,l,y,w,5,'#753f50'); P(c,l+2,y+6,aba,h*.54,'#91566f'); P(c,l+w-aba-2,y+6,aba,h*.54,'#91566f');
        for(let i=0;i<4;i++){ P(c,l+4,y+10+i*9,aba-3,2,'#ffbeaa'); P(c,l+w-aba,y+10+i*9,aba-3,2,'#ffbeaa'); }
        selo(c,'balao',x,top+h*.48,38,28); texto(c,'PSIU!',x,bot-19,'#ffeacb',12); break;
      }
      case 'farinha':
        for(let i=0;i<11;i++){ const a=i*Math.PI/10, r=.45+.55*pulsa; P(c,x+Math.cos(a)*o.rx*r-4,bot-Math.sin(a)*(h-7)*r,8,7,i%2?'#ffeac4':'#dbb688'); } break;
      case 'visor': {
        cantos(c,x,o.y0,w-9,h-10,'#dafbff',14);
        P(c,l+9,top+11,6,6,'#ff5262'); texto(c,'REC',l+27,top+15,branco,10);
        const y=top+9+(h-20)*u; P(c,l+6,y,w-12,3,'#a6f4ff'); P(c,x-8,o.y0,16,2,'#defbff'); P(c,x,o.y0-7,2,14,'#defbff'); break;
      }
      case 'cafeeiro': {
        const alto=h*(.7+.3*pulsa);
        risco(c,[[x,bot],[x-5,bot-alto*.3],[x+3,bot-alto*.63],[x,bot-alto]],'#614631',6);
        for(let i=1;i<=5;i++){ const s=i%2?1:-1,yy=bot-i*alto/6;
          risco(c,[[x,yy+8],[x+s*12,yy],[x+s*(o.rx-6),yy-9]],'#477746',4);
          P(c,x+s*14-5,yy-8,12,6,'#86b75b'); P(c,x+s*8-3,yy+2,6,7,'#e6744e'); P(c,x+s*16-3,yy-10,5,4,'#fde5a0');
        } break;
      }
      case 'refletor':
        c.save(); c.fillStyle='#ffdf8673'; c.beginPath(); c.moveTo(x-8,top+10); c.lineTo(x+8,top+10); c.lineTo(l+w-1,bot); c.lineTo(l+1,bot); c.fill(); c.restore();
        P(c,x-15,top,30,12,tinta); P(c,x-10,top+9,20,5,'#ffdf81'); P(c,l+6,bot-9,w-12,3,'#fff0a9'); break;
      case 'cortina':
        for(let i=0;i<6;i++){const ww=w/6; P(c,l+i*ww,top,ww,h-8+i%2*7,i%2?'#b93e54':'#872c45'); P(c,l+i*ww+2,top,2,h-13,'#e47772');}
        P(c,l,top,w,7,'#edb86e'); break;
      case 'checkpoint':
        risco(c,[[x-13,bot-3],[x-13,top+14]],'#8ae6db',4); P(c,x-11,top+14,27,22,'#2b6268');
        for(let i=0;i<3;i++) P(c,x-10+i*9,top+17+i%2*8,8,8,'#9bf5dd'); texto(c,'2P',x,bot-18,'#ffd3fd'); break;
      case 'palma':
        selo(c,'palma',x,o.y0,w*.78,h*.68); for(const s of [-1,1]) risco(c,[[x+s*17,top+12],[x+s*24,top+5]],'#fff0ad',3); break;
      case 'lousa':
        P(c,l+4,top+4,w-8,h-10,'#835c46'); P(c,l+8,top+8,w-16,h-19,'#285854');
        for(let i=0;i<3;i++) {const y=top+25+i*20; risco(c,[[l+15,y],[x-5,y-3],[x+9,y+1],[l+w-14,y-3]],'#c6dfa9',2);}
        P(c,l+11,bot-13,w-22,3,'#f0c18d'); break;
      case 'revelacao':
        retrato(c,x,o.y0,w*.88,h*.58);
        for(const s of [-1,1]) for(let i=0;i<6;i++) P(c,x+s*(o.rx-5)-2,top+8+i*(h-18)/6,4,7,'#f4d191'); break;
      case 'sinal': {
        selo(c,'telefone',x,top+29,28,42);
        const pts=[]; for(let i=0;i<=12;i++)pts.push([l+4+(w-8)*i/12,bot-28-Math.abs(Math.sin(i*1.7+u*5))*(h*.33)]);
        risco(c,pts,'#dfbaff',4); texto(c,'TRIO',x,bot-13,'#ffdda6'); break;
      }
    }
  }
  function aviso(c,o,cor,pct) {
    if (o.art==='fratura') return; // As rachaduras e setas já acompanham o piso em movimento.
    if (o.area) {
      const w=o.rx*2, h=o.ry*2; cantos(c,o.x0,o.y0,w,h,cor);
      P(c,o.x0-o.rx,o.y0+o.ry-4,w,4,tinta); P(c,o.x0-o.rx,o.y0+o.ry-4,w*pct,3,cor);
      if(o.art==='visor') { P(c,o.x0-o.rx+7,o.y0-o.ry+8,5,5,'#ff5b74'); texto(c,'REC',o.x0-o.rx+25,o.y0-o.ry+11,cor,9); }
      return;
    }
    // Gotas no próprio arco mostram altura e direção, inclusive a volta dos golpes.
    for(let i=1;i<=8;i++){const pt=combate.ponto(o,i/9);P(c,pt.x-2,pt.y-2,4,4,tinta);P(c,pt.x-1,pt.y-1,3,2,cor);}
    if(o.corpo){
      const pe=o.y1+o.corpo;
      for(const lado of [-1,1])risco(c,[[o.x1+lado*9,pe-2],[o.x1+lado*23,pe-2],[o.x1+lado*28,pe-8]],cor,3);
      return;
    }
    const vertical = Math.abs(o.x1-o.x0)<20;
    if(vertical) cantos(c,o.x1,o.y1,o.rx*2,Math.min(15,o.ry*2),cor,5);
    else { const s=Math.sign(o.x1-o.x0); risco(c,[[o.x1-s*7,o.y1-4],[o.x1,o.y1],[o.x1-s*7,o.y1+4]],cor,2); }
    const pos=combate.ponto(o,0); c.save(); c.globalAlpha*=.65; movel(c,o,pos,0,cor); c.restore();
  }
  function virada(c,f) {
    const cap=combate.capitulo(f), t=f.tempo/f.dur, a=Math.min(1,t*6,(1-t)*5);
    if(!cap||a<=0)return;
    const x=Math.max(f.l+100,Math.min(f.r-100,f.x)), y=f.piso-183;
    c.save(); c.globalAlpha*=a; c.translate(Math.round(x),Math.round(y-7*Math.sin(t*Math.PI)));
    if(cap[1]==='foto') { retrato(c,0,0,102,82); }
    else if(cap[1]==='telefone') {
      P(c,-38,-56,76,100,tinta); P(c,-35,-53,70,93,'#58486e'); P(c,-30,-43,60,70,'#241e38');
      for(const s of [-1,1]) {P(c,s*12-6,-29,12,4,'#a171df');P(c,s*12-2,-26,6,3,'#e8b2ff');}
      texto(c,'ITABUNA',0,-3,'#fff0c9',11); P(c,-10,13,20,4,'#84d3ac'); P(c,-6,32,12,3,'#d9bfd8');
      for(const s of [-1,1]){const d=45+Math.floor(t*10)%3;risco(c,[[s*d,-19],[s*(d+5),-11],[s*(d+5),4],[s*d,11]],cap[2],3);}
    } else selo(c,cap[1],0,0,56,49);
    texto(c,cap[0],0,63,cap[2],14); c.restore();
  }
  function impacto(c,slug,m,cor) {
    const u=m.idade/.28, d=5+17*u;
    c.save(); c.translate(Math.round(m.x),Math.round(m.y)); c.globalAlpha*=1-u;
    switch(slug){
      case 'creuza':
        for(const s of [-1,1]) risco(c,[[s*d,-10],[s*(d+4),-6],[s*(d+4),3],[s*d,7]],cor,2);
        break;
      case 'tonhao':
        for(let i=-2;i<=2;i++)risco(c,[[i*d/2-2,-4],[i*d/2+2,-9-i%2*3]],i%2?'#ffc77d':'#775c56',3);
        break;
      case 'valdomiro': case 'fred':
        for(let i=0;i<6;i++){const a=(i+.5)*Math.PI/6;P(c,Math.cos(a)*d,-Math.sin(a)*d,4+i%2,3,i%2?'#fbd693':'#ac784e');}
        if(slug==='fred'&&m.art!=='pao')risco(c,[[-d,-9],[-5,-3],[0,-10],[6,-4],[d,-12]],'#eb9c94',2);
        break;
      case 'kaua':
        cantos(c,0,-5,18+u*28,15+u*21,'#c3fbff',5); P(c,-5,-6,10,2,'#fff2d5'); break;
      case 'barao':
        for(const s of [-1,1]){risco(c,[[s*d,-1],[s*(d-4),-7],[s*(d+1),-14]],'#f1d4a4',2);P(c,s*d-4,-8,7,3,'#a4bf6c');}break;
      case 'breno':
        for(const s of [-1,1])risco(c,[[s*3,-1],[s*(d-3),-9],[s*(d-6),-3],[s*(d+5),-13]],'#ffca8d',3);
        break;
      case 'gemeos':
        for(let i=0;i<4;i++){P(c,(i-1.5)*d*.7,-7+i%2*7,7-i,3,'#69e4d5');P(c,(i-1.5)*d*.7+3,-4+i%2*7,5,2,'#f28abf');}break;
      case 'jorge':
        if(['metade1','metade2','revelacao','passagem','bilhete'].includes(m.art)){
          for(const s of [-1,1]){P(c,s*d-4,-7-u*4,8,5,'#ffe1b6');P(c,s*d-2,-4-u*4,6,2,'#bc9a93');}
        } else for(const s of [-1,1])risco(c,[[s*3,-5],[s*8,-13],[s*11,-3],[s*d,-8]],cor,2);
        break;
    }
    c.restore();
  }
  function fundo(c,f) {
    if(f.slug!=='jorge'||f.fase!==5)return;
    const mid=(f.l+f.r)/2, y=f.piso-235;
    c.save();
      // O sinal da última chamada une as metades. A fotografia fica acima da ação.
      c.globalAlpha*=.72;
      const d=11+4*Math.sin(f.idade*.8);
      retrato(c,mid-d,y,68,55,-1); retrato(c,mid+d,y,68,55,1);
      for(const lado of [-1,1]){
        const pts=[];
        for(let i=0;i<=16;i++)pts.push([mid+lado*(43+i*8),y+4*Math.sin(i*.9-f.idade*2)*Math.sin(i*Math.PI/16)]);
        risco(c,pts,'#d4abea',2);
      }
    c.restore();
  }
  function desenhar(c,f) {
    if(!f)return;
    c.save(); c.imageSmoothingEnabled=false;
    const cor=combate.capitulo(f)?.[2]||combate.chefes[f.slug].cor;
    if(f.estado==='phaseChange') virada(c,f);
    for(const o of f.objetos){
      const ativa=f.estado==='firing', rel=ativa?f.tempo-o.atraso:f.tempo-f.dur-o.atraso;
      if(o.fim||rel < -Math.max(.76,f.estado==='windup'?f.dur:0))continue;
      if(!ativa||rel<0){ aviso(c,o,cor,Math.max(0,Math.min(1,1+rel/(ativa?.76:f.dur)))); continue; }
      const u=Math.min(1,rel/o.dur);
      if(o.area) zona(c,o,u,cor); else movel(c,o,combate.ponto(o,u),u,cor);
    }
    for(const m of f.marcas) impacto(c,f.slug,m,cor);
    c.restore();
  }
  window.ConquistaEfeitos = Object.freeze({desenhar,fundo});
})();
