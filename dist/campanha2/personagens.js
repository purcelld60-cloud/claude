/* Campanha 2 · Personagens (Passo 1).
   Todos os personagens novos da continuação em Vitória da Conquista, desenhados com o MESMO traço
   dos personagens atuais (art.js): mesma altura (~64 px), cabeça quadrada com contorno, vista de 3/4
   (olho do lado direito), nariz em degrau, cabelo em blocos, membros feitos com limb() de 2 em 2 px,
   sombra oval no chão e as mesmas cores de contorno. O acabamento da qualidade realista (contorno,
   luz de borda e sombra suave de char-detail.js) vale para eles também, porque este arquivo entra
   antes de char-detail.js.

   Uso: Art.drawCharacter(ctx, 'miguel', x, y, { frame, facing, moving, grounded, attack, emotion, ... })
   Tipos novos: jorge, jorge_gordo, miguel, fred_conquista, os 12 aliados e os 8 vilões (lista em
   CampanhaPersonagens.lista). Versões de idade para o flashback do trio: 'crianca_daroca',
   'crianca_reeis', 'crianca_jorge', 'pre_daroca', 'pre_reeis', 'pre_jorge'.
   Nada aqui muda os personagens que já existem: tipos desconhecidos seguem para o desenho original. */
(() => {
  'use strict';
  if (!window.Art || !window.Art.drawCharacter || window.CampanhaPersonagens) return;
  const base = window.Art.drawCharacter;

  /* ---------- mesmas primitivas de art.js ---------- */
  const r = (c, x, y, w, h, color) => { c.fillStyle = color; c.fillRect(Math.round(x), Math.round(y), Math.ceil(w), Math.ceil(h)); };
  function poly(c, points, color) { c.fillStyle = color; c.beginPath(); points.forEach((p, i) => i ? c.lineTo(p[0], p[1]) : c.moveTo(p[0], p[1])); c.closePath(); c.fill(); }
  function oval(c, x, y, rx, ry, color, p = 3) { for (let yy = -ry; yy < ry; yy += p) { const ww = Math.sqrt(Math.max(0, 1 - (yy / ry) * (yy / ry))) * rx; r(c, x - ww, y + yy, ww * 2, p, color); } }
  function limb(c, points, width, color) {
    for (let i = 1; i < points.length; i++) {
      const a = points[i - 1], b = points[i], steps = Math.max(1, Math.ceil(Math.max(Math.abs(b[0] - a[0]), Math.abs(b[1] - a[1])) / 2));
      for (let j = 0; j <= steps; j++) { const q = j / steps; r(c, Math.round((a[0] + (b[0] - a[0]) * q) / 2) * 2 - width / 2, Math.round((a[1] + (b[1] - a[1]) * q) / 2) * 2 - width / 2, width, width, color); }
    }
  }
  const OUT = '#2c3030', LINE = '#243137', LEGLINE = '#27333a';

  /* ---------- fichas ----------
     skin/shade: pele e sombra · build: normal | belly | slim | strong · h: altura relativa
     top: cor da roupa de cima · topKind: tee | jacket | hoodie | polo | tank | apron | overall | coat | vest | puffer | uniform | robe | cardigan
     inner: cor por baixo da jaqueta · sleeve: 'short' mostra o braço · pants · skirt · shoes
     hair: { style, color } · hat · glasses · beard · mustache · scarf · item (objeto na mão) · pose (gesto parado) */
  const SPEC = {
    // trio
    jorge_gordo: { name: 'Jorge (época do trio)', skin: '#dcaa82', shade: '#b07e5c', build: 'chubby', top: '#1c1e22', topKind: 'pullover', print: 'pizza', pants: '#3b4b63', hair: { style: 'curly', color: '#22170f', fade: '#5a4436' }, thinGlasses: '#26221f', pose: 'relaxed' },
    jorge: { name: 'Jorge', skin: '#dcaa82', shade: '#b07e5c', build: 'slim', top: '#4b3428', topKind: 'tee', sleeve: 'short', pants: '#2c3a4f', hair: { style: 'curly', color: '#22170f', fade: '#5a4436' }, thinGlasses: '#26221f', stubble: '#7a5640', pose: 'relaxed' },
    jorge_celular: null, // preenchido abaixo: o mesmo Jorge de hoje com o celular na orelha
    // amigos
    miguel: { name: 'Miguel', skin: '#f0c9af', shade: '#c3977f', build: 'strong', top: '#2c4f78', topKind: 'tee', sleeve: 'short', pants: '#3f4a52', hair: { style: 'side', color: '#4a3426' }, glasses: '#2f78c8', strap: '#5d4a3a', pose: 'thumb' },
    fred_conquista: { name: 'Fred', skin: '#f1cfb6', shade: '#c49b80', build: 'slim', top: '#1d1f26', topKind: 'tee', sleeve: 'short', print: '#c63d4a', pants: '#34404f', hair: { style: 'wavy', color: '#121518' }, chain: '#c9ccc4', pose: 'cocky' },
    // aliados e NPCs
    c2_ze_taxi: { name: 'Seu Zé do Táxi', skin: '#c99068', shade: '#9a6849', build: 'belly', top: '#dccb98', topKind: 'polo', sleeve: 'short', pattern: '#b9a26a', pants: '#4a4a42', hair: { style: 'bald', color: '#b8b2a6' }, mustache: '#d6d0c4', item: 'keys', pose: 'talk' },
    c2_lurdes: { name: 'Dona Lurdes', skin: '#d9a57f', shade: '#ac7856', build: 'normal', h: .94, top: '#7a5a8c', topKind: 'apron', apron: '#efe6d2', skirt: '#5d4672', hair: { style: 'bun', color: '#3a312c', gray: '#9a938a' }, glasses: '#7a5a3a', scarf: '#b9524a', pose: 'hips' },
    c2_mel: { name: 'Mel', skin: '#b67a52', shade: '#875438', build: 'slim', h: .92, top: '#d96f8a', topKind: 'puffer', pants: '#384b6a', hair: { style: 'long', color: '#2b1d17' }, bag: '#7c5a3a', item: 'map', pose: 'offer' },
    c2_picole: { name: 'Tio do Picolé', skin: '#c58c63', shade: '#966446', build: 'normal', top: '#f0efe6', topKind: 'coat', pants: '#41505a', hat: { kind: 'cap', color: '#e8e6dc', band: '#3e7cc0' }, hair: { style: 'short', color: '#6c665e' }, scarf: '#3e7cc0', item: 'cooler', pose: 'carry', shiver: true },
    c2_nando: { name: 'Nando Skatista', skin: '#9c6644', shade: '#704630', build: 'slim', top: '#4f8a52', topKind: 'hoodie', inner: '#2b3a2c', pants: '#22262c', hat: { kind: 'capback', color: '#d9b347' }, hair: { style: 'short', color: '#1d1a18' }, item: 'skate', pose: 'carry' },
    c2_vo_cida: { name: 'Vó Cida', skin: '#d8a985', shade: '#ab7d5d', build: 'normal', h: .88, hunch: true, top: '#8a5aa0', topKind: 'cardigan', inner: '#efe2c8', skirt: '#5b4a62', hair: { style: 'curlyShort', color: '#d9d6d0' }, glasses: '#8a7a6a', item: 'cane', pose: 'cane' },
    c2_juninho: { name: 'Juninho Mecânico', skin: '#8a5a3c', shade: '#5f3d2a', build: 'normal', top: '#2f5d8c', topKind: 'overall', inner: '#c9c3b0', pants: '#2f5d8c', hat: { kind: 'cap', color: '#c0443c' }, hair: { style: 'short', color: '#1c1714' }, grease: true, item: 'wrench', pose: 'carry' },
    c2_larissa: { name: 'Larissa da Biblioteca', skin: '#efc6a9', shade: '#c2977c', build: 'slim', h: .95, top: '#c99a3a', topKind: 'cardigan', inner: '#f2ecda', skirt: '#4a5a6c', hair: { style: 'ponytail', color: '#3b2620' }, glasses: '#a8443c', item: 'book', pose: 'read' },
    c2_gugu: { name: 'Gugu do Ferro-Velho', skin: '#b07a52', shade: '#82563a', build: 'belly', top: '#6f6a5c', topKind: 'tank', pants: '#3f4a3c', hair: { style: 'buzz', color: '#2a231d' }, beard: '#2a231d', goggles: '#86c8d0', gloves: '#b38a3c', item: 'gadget', pose: 'carry' },
    c2_bia: { name: 'Bia do Arrocha', skin: '#7c4f35', shade: '#55362a', build: 'slim', h: .95, top: '#d94a9a', topKind: 'tee', sleeve: 'short', sparkle: true, skirt: '#2a2a3c', hair: { style: 'curlyBig', color: '#1e1512' }, earrings: '#f2cf5b', item: 'mic', pose: 'sing' },
    c2_fatima: { name: 'Dona Fátima das Fantasias', skin: '#c48a62', shade: '#93613f', build: 'normal', h: .93, top: '#d8452f', topKind: 'apron', apron: '#f2e6c8', skirt: '#2f5f8a', hat: { kind: 'straw', color: '#e2c070' }, hair: { style: 'long', color: '#3a2a20' }, earrings: '#f2c230', scarf: '#f2c230', item: 'map', pose: 'offer' },
    c2_carlinhos: { name: 'Carlinhos', skin: '#e8bf9f', shade: '#bb9277', build: 'slim', top: '#7d8590', topKind: 'hoodie', inner: '#4d5560', pants: '#2c3646', hair: { style: 'short', color: '#5a3f2c' }, pose: 'pockets', mood: 'sad' },
    // vilões
    c2_creuza: { name: 'Dona Creuza Fofoqueira', skin: '#e0ae8b', shade: '#b38163', build: 'normal', h: .94, top: '#e48fb0', topKind: 'robe', robeDots: '#f6d3df', pants: '#e48fb0', hair: { style: 'curlers', color: '#6a3d2c', curler: '#7cc7d8' }, lipstick: '#c4384e', item: 'phone', pose: 'phone' },
    c2_tonhao: { name: 'Tonhão do Mototáxi', skin: '#a96f48', shade: '#7c4f33', build: 'strong', top: '#3a3f44', topKind: 'vest', vest: '#f08a24', vestBand: '#e8f06a', pants: '#2a3038', hat: { kind: 'helmet', color: '#c9372f', visor: '#2a3a46' }, mustache: '#231b16', item: 'keys', pose: 'hips' },
    c2_valdomiro: { name: 'Seu Valdomiro da Feira', skin: '#c48a60', shade: '#956445', build: 'belly', top: '#4e7d5a', topKind: 'apron', apron: '#e9dcc0', pants: '#4f4a3e', hat: { kind: 'straw', color: '#d7b665' }, mustache: '#6f665c', hair: { style: 'short', color: '#8a847a' }, item: 'biscuit', pose: 'offer' },
    c2_kaua_influencer: { name: 'Kauã Influencer', skin: '#d9a985', shade: '#ab7c5e', build: 'slim', top: '#f2f1ec', topKind: 'puffer', pants: '#1f2430', hair: { style: 'quiff', color: '#3a2a22', tips: '#f0d36a' }, shades: true, item: 'selfie', pose: 'selfie' },
    c2_barao: { name: 'Barão do Café', skin: '#d8a27a', shade: '#a97556', build: 'belly', top: '#f1ece0', topKind: 'vest', vest: '#5a3a24', vestBand: '#7a5236', pants: '#3c2f26', hat: { kind: 'rancher', color: '#6b4a2c', band: '#2c1e14' }, mustache: '#3a2a20', item: 'mug', pose: 'mug', twitch: true },
    c2_breno: { name: 'Breno Pitbull', skin: '#b98258', shade: '#8a5c3c', build: 'strong', top: '#1f2226', topKind: 'tank', pants: '#2a3442', hair: { style: 'buzz', color: '#1b1714' }, chain: '#e8c24c', tattoo: '#3f4b5a', pose: 'fists', mood: 'angry' },
    c2_ryan: { name: 'Ryan', skin: '#e9c2a3', shade: '#bb9275', build: 'slim', top: '#2f6fb5', topKind: 'hoodie', inner: '#1d2a3c', pants: '#25303f', hair: { style: 'fringe', color: '#2a1d16' }, headset: '#20262c', item: 'pad', pose: 'game' },
    c2_bryan: { name: 'Bryan', skin: '#e9c2a3', shade: '#bb9275', build: 'slim', top: '#c23f3a', topKind: 'hoodie', inner: '#3c1d1d', pants: '#25303f', hair: { style: 'fringe', color: '#2a1d16' }, headset: '#20262c', item: 'pad', pose: 'game', mirrored: true },
    // engarrafamento da Avenida (Passo 2B): genro e sogra presos atrás do Fusca do biscoito
    c2_cleiton: { name: 'Cleiton do Ubé', skin: '#b47a50', shade: '#86583a', build: 'normal', top: '#2e6ea8', topKind: 'polo', sleeve: 'short', pattern: '#245a8c', pants: '#3a3f46', hat: { kind: 'cap', color: '#1e2a36', band: '#e8c24c' }, hair: { style: 'short', color: '#1c1612' }, mustache: '#1c1612', item: 'keys', pose: 'fists', mood: 'angry' },
    c2_rosilda: { name: 'Dona Rosilda', skin: '#e3b48f', shade: '#b58665', build: 'belly', h: .9, top: '#3f8a6a', topKind: 'cardigan', inner: '#f2e6c8', skirt: '#6a4a5a', hair: { style: 'curlers', color: '#7a4a34', curler: '#f08ab0' }, glasses: '#5a3a8a', item: 'phone', pose: 'hips', mood: 'angry' },
  };
  SPEC.jorge_celular = { ...SPEC.jorge, name: 'Jorge (no celular)', item: 'phone', pose: 'phone' };
  SPEC.jorge_farpas = { ...SPEC.jorge, name: 'Jorge das farpas', topKind: 'jacket', top: '#872f51', inner: '#302840', scarf: '#dd939c', pose: 'cocky' };
  SPEC.jorge_aura = { ...SPEC.jorge, name: 'Jorge do céu', topKind: 'coat', top: '#354d84', inner: '#93cdd6', scarf: '#acdfea', pants: '#384466', pose: 'fists' };
  SPEC.jorge_promessa = { ...SPEC.jorge_celular, name: 'Jorge da última chamada', topKind: 'jacket', top: '#e4c99c', inner: '#38576b', pants: '#34485a', shoes: '#664b41' };
  const ROLE = {
    jorge_gordo: 'trio', jorge: 'trio', jorge_celular: 'trio', miguel: 'amigo', fred_conquista: 'vilão final antes do Jorge',
    c2_ze_taxi: 'aliado', c2_lurdes: 'aliado', c2_mel: 'aliado', c2_biscoito: 'aliado', c2_picole: 'aliado', c2_nando: 'aliado', c2_vo_cida: 'aliado',
    c2_juninho: 'aliado', c2_larissa: 'aliado', c2_gugu: 'aliado', c2_bia: 'aliado', c2_carlinhos: 'aliado', c2_fatima: 'aliado',
    c2_creuza: 'vilão 1', c2_tonhao: 'vilão 2', c2_valdomiro: 'vilão 3', c2_kaua_influencer: 'vilão 4', c2_barao: 'vilão 5', c2_breno: 'vilão 6', c2_ryan: 'vilão 7', c2_bryan: 'vilão 7',
    c2_cleiton: 'NPC (engarrafamento)', c2_rosilda: 'NPC (engarrafamento)'
  };

  /* ---------- cabelos e chapéus ---------- */
  function hairBack(c, S) {
    const H = S.hair; if (!H) return; const col = H.color;
    if (H.style === 'mullet') { r(c, -17, -60, 10, 27, OUT); r(c, -16, -60, 9, 26, col); r(c, -16, -40, 4, 6, col); r(c, -11, -38, 4, 5, col); r(c, -14, -56, 2, 14, '#2a3036'); }
    if (H.style === 'long') { r(c, -15, -60, 9, 26, OUT); r(c, -14, -60, 8, 25, col); r(c, -13, -38, 6, 3, col); }
    if (H.style === 'ponytail') { r(c, -17, -60, 6, 6, OUT); r(c, -16, -59, 5, 5, col); limb(c, [[-15, -56], [-19, -48], [-17, -40]], 5, OUT); limb(c, [[-15, -56], [-19, -48], [-17, -40]], 3, col); r(c, -17, -58, 3, 2, '#c94b6a'); }
    if (H.style === 'bun') { oval(c, -13, -63, 6, 6, OUT, 2); oval(c, -13, -63, 5, 5, H.gray || col, 2); r(c, -15, -66, 3, 2, col); }
    if (H.style === 'curlyBig') { for (let i = 0; i < 7; i++) { const a = -Math.PI * .95 + i * .5; oval(c, -2 + Math.cos(a) * 15, -54 + Math.sin(a) * 11, 6, 6, OUT, 2); } for (let i = 0; i < 7; i++) { const a = -Math.PI * .95 + i * .5; oval(c, -2 + Math.cos(a) * 14, -54 + Math.sin(a) * 10, 5, 5, i % 2 ? col : '#2e211b', 2); } r(c, -16, -50, 6, 14, col); }
  }
  function hairFront(c, S, t) {
    const H = S.hair; if (!H) return; const col = H.color, hi = H.hi || shadeHex(col, 1.35);
    switch (H.style) {
      case 'bowl': { // tigela cacheada com franjinha reta acima dos olhos (Jorge)
        for (let i = 0; i < 8; i++) oval(c, -12 + i * 3.8, -64 - (i > 0 && i < 7 ? 2 : 0), 4, 4, OUT, 2);   // contorno dos cachos
        r(c, -15, -62, 31, 8, OUT); r(c, -15, -56, 6, 9, OUT);
        for (let i = 0; i < 8; i++) oval(c, -12 + i * 3.8, -64 - (i > 0 && i < 7 ? 2 : 0), 3, 3, i % 2 ? col : hi, 2); // cachos do topo
        r(c, -14, -62, 29, 6, col); r(c, -14, -56, 5, 8, col);                   // volume e lateral cobrindo a orelha
        for (let i = 0; i < 3; i++) oval(c, -12, -53 + i * 3, 2, 2, i % 2 ? hi : col, 2);
        r(c, -9, -57, 24, 2, col); for (let i = 0; i < 6; i++) r(c, -8 + i * 4, -55, 3, 1, col);      // franjinha reta em tigela
        // textura de cachinhos: pontos claros e escuros em todo o volume
        const dk = shadeHex(col, .62);
        for (let yy = -64; yy <= -58; yy += 3) for (let xx = -12 + ((yy / 3) & 1) * 2; xx < 14; xx += 4) { r(c, xx, yy, 2, 1, hi); r(c, xx + 1, yy + 1, 1, 1, dk); }
        for (let yy = -54; yy < -48; yy += 3) { r(c, -13, yy, 2, 1, hi); r(c, -11, yy + 1, 1, 1, dk); }
        break;
      }
      case 'curly': { // cachos definidos: volume alto, laterais baixas e cachinhos caindo na testa (Jorge)
        const dk = shadeHex(col, .35), hl = shadeHex(col, 2.6), fade = H.fade || col;
        r(c, -12, -60, 4, 12, fade); r(c, -12, -60, 1, 12, shadeHex(fade, .8)); r(c, 11, -58, 3, 3, fade); // laterais disfarçadas
        const curls = [[-4, -70, 4], [3, -71, 4], [10, -69, 4], [-11, -66, 4], [-4, -65, 4], [3, -66, 4], [10, -64, 4], [-12, -61, 3], [15, -61, 3], [-1, -59, 3], [4, -58, 3], [9, -59, 3], [14, -57, 3]];
        for (const [xx, yy, rr] of curls) oval(c, xx, yy, rr + 1, rr + 1, OUT, 1);
        r(c, -11, -64, 25, 6, col);
        curls.forEach(([xx, yy, rr], i) => { oval(c, xx, yy, rr, rr, i % 3 === 1 ? shadeHex(col, 1.25) : col, 1); r(c, xx - 1, yy - 1, 2, 2, dk); r(c, xx - rr + 1, yy - rr + 1, 2, 1, hl); r(c, xx + rr - 2, yy + 1, 1, 2, hl); });
        r(c, 2, -55, 1, 1, col); r(c, 12, -54, 1, 2, col); // pontinhas dos cachos na testa
        break;
      }
      case 'wavy': { // preto ondulado normal com topetinho pequeno na frente (Fred)
        const hl = '#46505a', dk = '#07090b';
        r(c, -13, -65, 28, 10, OUT); r(c, -12, -64, 26, 8, col); r(c, -12, -58, 4, 9, col); r(c, 11, -58, 3, 3, col);
        poly(c, [[5, -64], [9, -69], [15, -68], [16, -63], [10, -62]], OUT); poly(c, [[6, -64], [9, -68], [14, -67], [15, -63], [10, -63]], col); // topetinho
        for (let k = 0; k < 3; k++) { r(c, -10 + k * 7, -62 + (k % 2), 4, 1, hl); r(c, -7 + k * 7, -61 + (k % 2), 3, 1, dk); } // ondas
        r(c, 9, -67, 3, 1, hl); r(c, 2, -57, 10, 2, col); r(c, 4, -55, 2, 1, col); r(c, -11, -55, 2, 1, hl);
        break;
      }
      case 'side': // curto e liso jogado para o lado (Miguel)
        r(c, -13, -64, 28, 9, OUT); r(c, -12, -63, 26, 7, col); r(c, -12, -58, 4, 7, col); r(c, 11, -58, 3, 3, col);
        poly(c, [[-4, -63], [16, -60], [16, -57], [4, -58], [-2, -57]], col); r(c, -8, -62, 16, 1, hi); r(c, 2, -60, 10, 1, hi); break;
      case 'mullet': // topo liso e preto, nuca longa (Fred)
        r(c, -13, -65, 28, 10, OUT); r(c, -12, -64, 26, 8, col); r(c, -12, -58, 5, 12, col); r(c, 6, -58, 9, 3, col); r(c, -8, -63, 14, 1, '#3a4046'); r(c, -11, -56, 1, 9, '#30363b'); break;
      case 'short': r(c, -12, -63, 26, 9, col); r(c, -9, -65, 20, 4, col); r(c, -12, -58, 4, 8, col); r(c, 11, -58, 4, 4, col); r(c, -8, -62, 14, 2, hi); break;
      case 'fringe': r(c, -13, -64, 28, 9, OUT); r(c, -12, -63, 26, 8, col); r(c, -12, -58, 4, 8, col); r(c, 2, -57, 12, 3, col); r(c, -7, -62, 13, 1, hi); break;
      case 'buzz': r(c, -12, -62, 26, 5, col); r(c, -12, -58, 3, 6, col); r(c, -8, -61, 14, 1, hi); break;
      case 'bald': r(c, -12, -55, 3, 7, col); r(c, -9, -57, 3, 3, col); r(c, -4, -61, 12, 2, '#f0d2b8'); break;
      case 'long': r(c, -12, -64, 27, 9, OUT); r(c, -11, -63, 25, 8, col); r(c, -12, -58, 5, 16, col); r(c, 3, -58, 12, 3, col); r(c, -6, -62, 12, 1, hi); break;
      case 'ponytail': r(c, -12, -63, 26, 8, col); r(c, -12, -58, 4, 9, col); r(c, 4, -57, 10, 2, col); r(c, -7, -62, 13, 1, hi); break;
      case 'bun': r(c, -12, -63, 26, 8, col); r(c, -12, -58, 4, 8, col); r(c, 10, -58, 4, 3, col); r(c, -6, -62, 10, 1, H.gray || hi); r(c, 2, -61, 8, 1, H.gray || hi); break;
      case 'curlyShort': for (let i = 0; i < 8; i++) oval(c, -11 + i * 3.6, -61 + (i % 2) * 2, 3, 3, i % 2 ? col : '#bdb8b0', 2); r(c, -13, -58, 4, 8, col); for (let i = 0; i < 3; i++) oval(c, -12, -56 + i * 3, 2, 2, col, 2); break;
      case 'curlyBig': r(c, -12, -63, 26, 7, col); for (let i = 0; i < 6; i++) oval(c, -9 + i * 4.5, -63, 3, 3, i % 2 ? col : '#2e211b', 2); r(c, 5, -58, 9, 3, col); break;
      case 'curlers': r(c, -12, -63, 26, 8, col); r(c, -12, -58, 4, 8, col); for (let i = 0; i < 4; i++) { r(c, -10 + i * 7, -66, 6, 4, OUT); r(c, -9 + i * 7, -65, 4, 2, H.curler); } r(c, -13, -60, 2, 4, H.curler); break;
      case 'quiff': // topete com pontas pintadas (Kauã)
        r(c, -12, -62, 26, 7, col); r(c, -12, -58, 3, 6, col); poly(c, [[-6, -62], [2, -71], [14, -69], [15, -63], [6, -62]], col); poly(c, [[3, -70], [13, -69], [14, -66], [6, -66]], H.tips); r(c, -10, -60, 4, 2, '#8a8a8a'); break;
    }
  }
  function hat(c, S) {
    const H = S.hat; if (!H) return;
    if (H.kind === 'cap') { r(c, -13, -66, 28, 9, OUT); r(c, -12, -65, 26, 7, H.color); r(c, 8, -59, 13, 3, OUT); r(c, 9, -59, 11, 2, H.color); if (H.band) r(c, -12, -60, 26, 2, H.band); r(c, -6, -64, 10, 1, '#ffffff55'); }
    if (H.kind === 'capback') { r(c, -13, -66, 28, 9, OUT); r(c, -12, -65, 26, 7, H.color); r(c, -20, -60, 10, 3, OUT); r(c, -19, -60, 8, 2, H.color); r(c, 2, -64, 6, 2, '#ffffff66'); }
    if (H.kind === 'helmet') { oval(c, 0, -57, 17, 13, OUT, 2); oval(c, 0, -58, 16, 12, H.color, 2); r(c, -16, -55, 7, 13, H.color); r(c, -9, -64, 14, 2, '#ffffff55'); r(c, 6, -59, 12, 3, H.visor); r(c, -2, -66, 6, 2, '#f2f2f2'); }
    if (H.kind === 'straw') { r(c, -20, -59, 42, 4, '#5a4a2a'); r(c, -19, -60, 40, 3, H.color); r(c, -12, -70, 25, 11, '#5a4a2a'); r(c, -11, -69, 23, 10, H.color); r(c, -11, -62, 23, 2, '#8a5a3a'); for (let i = 0; i < 6; i++) r(c, -9 + i * 4, -68, 1, 6, '#c4a050'); }
    if (H.kind === 'rancher') { r(c, -22, -59, 46, 4, OUT); r(c, -21, -59, 44, 3, H.color); r(c, -12, -71, 25, 13, OUT); r(c, -11, -70, 23, 12, H.color); r(c, -4, -71, 8, 2, shadeHex(H.color, .7)); r(c, -11, -62, 23, 2, H.band); }
  }

  /* ---------- objetos na mão ---------- */
  function item(c, S, hx, hy, t, o) {
    switch (S.item) {
      case 'phone': r(c, hx - 1, hy - 10, 6, 11, OUT); r(c, hx, hy - 9, 4, 9, '#3f5f7a'); r(c, hx + 1, hy - 8, 2, 3, '#9fd4e6'); break;
      case 'keys': r(c, hx + 2, hy + 2, 2, 6, '#c8c4b4'); r(c, hx, hy + 6, 6, 3, '#d9b347'); break;
      case 'map': r(c, hx, hy - 8, 15, 11, '#5a4a32'); r(c, hx + 1, hy - 7, 13, 9, '#efe2b8'); r(c, hx + 3, hy - 5, 4, 2, '#7cb86a'); r(c, hx + 8, hy - 3, 4, 3, '#6aa2c8'); r(c, hx + 5, hy - 6, 1, 7, '#c4504a'); break;
      case 'cooler': r(c, hx - 6, hy - 2, 18, 13, OUT); r(c, hx - 5, hy - 1, 16, 11, '#eef4f6'); r(c, hx - 5, hy - 1, 16, 3, '#3e7cc0'); r(c, hx - 1, hy + 3, 8, 2, '#d8504a'); break;
      case 'skate': r(c, hx - 4, hy - 16, 6, 30, OUT); r(c, hx - 3, hy - 15, 4, 28, '#c8763a'); r(c, hx - 6, hy - 12, 2, 3, '#e8e2d0'); r(c, hx + 2, hy - 12, 2, 3, '#e8e2d0'); r(c, hx - 6, hy + 8, 2, 3, '#e8e2d0'); r(c, hx + 2, hy + 8, 2, 3, '#e8e2d0'); break;
      case 'cane': limb(c, [[hx + 1, hy], [hx + 3, hy + 22]], 3, '#5a3a24'); r(c, hx - 2, hy - 2, 6, 3, '#5a3a24'); break;
      case 'wrench': r(c, hx + 1, hy - 14, 3, 15, '#9aa3a6'); r(c, hx - 1, hy - 17, 7, 4, '#9aa3a6'); r(c, hx + 1, hy - 16, 3, 2, OUT); break;
      case 'book': r(c, hx - 2, hy - 10, 14, 11, '#3a2430'); r(c, hx - 1, hy - 9, 12, 9, '#7a3a4a'); r(c, hx + 4, hy - 9, 1, 9, '#f0e4c8'); break;
      case 'gadget': r(c, hx - 2, hy - 8, 11, 9, OUT); r(c, hx - 1, hy - 7, 9, 7, '#7a7f74'); r(c, hx + 3, hy - 15, 1, 8, '#9aa3a6'); r(c, hx + 2, hy - 17, 3, 3, (Math.sin(t * 6) > 0) ? '#ff5a4a' : '#7a2a2a'); r(c, hx, hy - 5, 3, 2, '#f2c94c'); break;
      case 'mic': r(c, hx + 1, hy - 4, 3, 9, '#2a2a30'); oval(c, hx + 2, hy - 7, 4, 4, '#b8bcc4', 2); r(c, hx, hy - 9, 2, 1, '#ffffff'); break;
      case 'biscuit': r(c, hx - 2, hy - 2, 14, 12, '#7a5a3a'); r(c, hx - 1, hy - 1, 12, 10, '#e9d6a8'); for (let i = 0; i < 3; i++) oval(c, hx + 2 + i * 3, hy - 3, 2, 2, '#fff3cf', 2); break;
      case 'selfie': { limb(c, [[hx + 2, hy], [hx + 12, hy - 18]], 2, '#2a2a30'); r(c, hx + 9, hy - 28, 9, 12, OUT); r(c, hx + 10, hy - 27, 7, 10, '#2c3a4a'); const on = (Math.sin(t * 4) > .2); oval(c, hx + 13, hy - 22, 9, 9, on ? '#fff6d0' : '#d8d0b0', 2); oval(c, hx + 13, hy - 22, 6, 6, '#2c3a4a', 2); r(c, hx + 11, hy - 25, 5, 6, '#3f6f9a'); break; }
      case 'mug': r(c, hx - 1, hy - 7, 9, 9, OUT); r(c, hx, hy - 6, 7, 7, '#e8e2d4'); r(c, hx + 7, hy - 4, 3, 4, '#e8e2d4'); r(c, hx + 1, hy - 6, 5, 2, '#5a3624'); for (let i = 0; i < 2; i++) r(c, hx + 1 + i * 3, hy - 11 - Math.round(Math.sin(t * 3 + i) * 2), 1, 3, '#e8f0f0aa'); break;
      case 'pad': r(c, hx - 6, hy - 3, 14, 7, OUT); r(c, hx - 5, hy - 2, 12, 5, '#3a3f48'); r(c, hx - 3, hy - 1, 2, 2, '#e8e2d0'); r(c, hx + 3, hy - 1, 2, 2, S.top); break;
    }
  }

  // clareia/escurece #rrggbb
  function shadeHex(hex, k) {
    if (!/^#[0-9a-f]{6}$/i.test(hex)) return hex;
    const n = parseInt(hex.slice(1), 16), f = (v) => Math.max(0, Math.min(255, Math.round(v * k)));
    return '#' + [(n >> 16) & 255, (n >> 8) & 255, n & 255].map((v) => f(v).toString(16).padStart(2, '0')).join('');
  }

  /* ---------- corpo inteiro (mesmo esqueleto de newCharacter em art.js) ---------- */
  function person(c, type, S, x, y, o) {
    c.save(); c.imageSmoothingEnabled = false; c.translate(Math.round(x), Math.round(y));
    const sc = o.scale || 1, hk = S.h || 1;
    c.scale((o.facing < 0 ? -1 : 1) * sc, sc * hk);
    if (Number.isFinite(o.opacity)) c.globalAlpha *= Math.max(0, Math.min(1, o.opacity));
    const t = Number(o.frame) || 0, moving = !!o.moving || Number(o.speed) > 8, air = o.grounded === false;
    const walk = moving && !air ? Math.sin(t * 9) : 0, bob = moving && !air ? Math.round(Math.abs(Math.cos(t * 9)) * 2) : Math.round(Math.sin(t * 2) * .7);
    const attack = !!o.attack, strike = attack ? Math.max(0, Math.sin((Number.isFinite(o.attackProgress) ? o.attackProgress : .5 + Math.sin(t * 7) * .5) * Math.PI)) : 0;
    const belly = S.build === 'belly', strong = S.build === 'strong', slim = S.build === 'slim', chubby = S.build === 'chubby';
    const wide = belly ? 18 : strong ? 17 : slim ? 10 : chubby ? 14 : 12, skin = S.skin, shade = S.shade;
    const shiver = S.shiver || o.cold ? Math.round(Math.sin(t * 40)) : 0, twitch = S.twitch && Math.sin(t * 13) > .85 ? 1 : 0;
    const mood = o.emotion || S.mood || '';
    if(!o.duelo || !air) oval(c, 0, -1, belly ? 23 : strong ? 21 : chubby ? 19 : 17, 3, '#2e433d', 2);
    if (o.rage || (type === 'c2_breno' && o.powered)) { c.save(); c.globalAlpha *= .3; oval(c, 0, -34, 30 + Math.sin(t * 11) * 3, 42, '#f26154', 3); c.restore(); }
    // pernas
    for (const side of [-1, 1]) {
      let fx = side * 7 + Math.round(walk * 12 * side), fy = moving && !air ? Math.max(0, Math.cos(t * 9 + (side > 0 ? 0 : Math.PI))) * 6 : 0;
      if (air) { fx = side > 0 ? 10 : -12; fy = side > 0 ? 3 : 11; }
      const legW = strong ? 11 : slim ? 7 : 9;
      limb(c, [[side * 7, -25], [side * 7 + walk * side * 4, -12], [fx, -4 - fy]], legW, LEGLINE);
      limb(c, [[side * 7, -25], [side * 7 + walk * side * 4, -12], [fx, -4 - fy]], strong ? 7 : slim ? 4 : 5, S.skirt ? skin : S.pants || '#3d4852');
      r(c, fx - 4, -6 - fy, 13, 6, S.shoes || '#26353a'); r(c, fx - 3, -2 - fy, 11, 2, S.sole || '#b6b8a6');
    }
    c.translate((o.dash ? 5 : Math.round(walk * 1.5)) + shiver, -bob + (S.hunch ? 2 : 0));
    if (S.hunch) c.rotate(.06);
    // mãos: gesto parado de cada personagem
    let L = [-wide - 5 + Math.round(walk * 7), -18], Rh = [wide + 5 - Math.round(walk * 7), -18];
    if (!moving && !attack) {
      const p = S.pose;
      if (p === 'phone' && o.item !== false) { Rh = [wide + 2, -47]; L = [-wide - 3, -22]; }
      if (p === 'thumb') { Rh = [wide + 12, -32 + Math.round(Math.sin(t * 2))]; L = [-wide - 4, -22]; }
      if (p === 'cocky') { Rh = [wide + 2, -30]; L = [-wide + 2, -30]; }
      if (p === 'talk') { Rh = [wide + 13, -30 + Math.round(Math.sin(t * 5) * 3)]; L = [-wide - 4, -21]; }
      if (p === 'hips') { Rh = [wide + 6, -26]; L = [-wide - 6, -26]; }
      if (p === 'offer') { Rh = [wide + 15, -29]; L = [-wide - 4, -22]; }
      if (p === 'carry') { Rh = [wide + 8, -24]; L = [-wide - 4, -21]; }
      if (p === 'cane') { Rh = [wide + 9, -22]; L = [-wide - 3, -22]; }
      if (p === 'read') { Rh = [wide + 6, -32]; L = [wide - 2, -30]; }
      if (p === 'sing') { Rh = [wide + 4, -44 + Math.round(Math.sin(t * 3) * 2)]; L = [-wide - 12, -36 + Math.round(Math.sin(t * 3 + 1) * 3)]; }
      if (p === 'pockets') { Rh = [wide - 3, -22]; L = [-wide + 3, -22]; }
      if (p === 'selfie') { Rh = [wide + 8, -38]; L = [-wide - 2, -30]; }
      if (p === 'mug') { Rh = [wide + 8, -33]; L = [-wide - 4, -22]; }
      if (p === 'fists') { Rh = [wide + 8, -34 + Math.round(Math.sin(t * 4) * 2)]; L = [wide - 2, -36]; }
      if (p === 'game') { Rh = [wide + 2, -29]; L = [wide - 6, -29]; }
      if (p === 'relaxed') { Rh = [wide + 4, -20]; L = [-wide - 3, -20]; }
    }
    if (attack) { Rh = [wide + 10 + Math.round(strike * 12), -34 - Math.round(strike * 6)]; L = [-wide + 1, -34]; }
    if (o.duelo===2 && attack) {
      Rh=air?[wide+9,-39]:[wide-3,-25]; L=air?[-wide-9,-38]:[-wide+1,-24];
    } else if (o.duelo===3 && attack) {
      Rh=[wide+8+Math.round(7*strike),-41]; L=[0,-43];
    } else if (o.duelo===4) {
      Rh=[wide+6+(attack?8:0),attack?-40:-23]; L=[-wide-7,attack?-36:-26];
    } else if (o.duelo===5) {
      Rh=[wide+2,-47]; L=attack?[wide+4,-32]:[-wide-3,-22];
    }
    if (o.charging) { L = [-27, -24]; Rh = [27, -24]; }
    if (o.reach) { Rh = [wide + 22, -32]; } // mão estendida (cutscene final)
    const sleeveSkin = S.sleeve === 'short' || S.topKind === 'tank';
    const armW = strong ? 11 : slim ? 6 : 8, armIn = strong ? 7 : slim ? 4 : 5;
    function hand(side) {
      const end = side > 0 ? Rh : L, shoulder = [side * wide, -36], elbow = [side * (wide + 5), -27 + Math.round(walk * side * 3)];
      limb(c, [shoulder, elbow, end], armW, LINE);
      limb(c, [shoulder, elbow], armIn, S.topKind === 'tank' ? skin : S.topKind === 'apron' || S.topKind === 'overall' ? S.inner || S.top : S.top);
      limb(c, [elbow, end], armIn, sleeveSkin || S.topKind === 'apron' && !S.inner ? skin : S.topKind === 'overall' ? S.inner : S.top);
      if (S.tattoo && side > 0) r(c, elbow[0] - 2, elbow[1] - 2, 4, 4, S.tattoo);
      r(c, end[0] - 3, end[1] - 3, strong ? 8 : 6, strong ? 7 : 6, S.gloves || skin);
    }
    hand(-1);
    hairBack(c, S);
    // tronco
    const top = S.top, edge = shadeHex(top, .62);
    if (belly) { oval(c, 1, -30, 23, 20, '#202a31', 2); oval(c, 1, -31, 20, 17, top, 2); r(c, -14, -20, 31, 3, shadeHex(top, .55)); }
    else if (chubby) { // gordinho: tronco um pouco mais largo e barriguinha leve (não é bola)
      poly(c, [[-wide - 1, -42], [wide + 2, -42], [wide + 4, -30], [wide + 2, -17], [-wide, -17], [-wide - 2, -30]], '#243037');
      poly(c, [[-wide + 1, -40], [wide, -40], [wide + 2, -30], [wide, -19], [-wide + 2, -19], [-wide, -30]], top); r(c, -wide + 2, -21, wide * 2, 3, edge); r(c, wide - 2, -31, 3, 8, shadeHex(top, 1.35)); }
    else { poly(c, [[-wide - 1, -42], [wide + 2, -42], [wide, -17], [-wide, -17]], '#243037'); poly(c, [[-wide + 1, -40], [wide, -40], [wide - 2, -19], [-wide + 2, -19]], top); r(c, -wide + 2, -21, wide * 2 - 2, 3, edge); }
    const bx = belly ? 16 : wide - 1;
    switch (S.topKind) {
      case 'jacket': case 'hoodie': case 'puffer': case 'cardigan': case 'coat':
        if (S.inner) r(c, -3, -40, 7, belly ? 22 : 19, S.inner);
        r(c, -4, -40, 1, belly ? 22 : 19, edge); r(c, 4, -40, 1, belly ? 22 : 19, edge);
        if (S.topKind === 'hoodie') { r(c, -bx + 1, -43, 9, 5, edge); r(c, -bx + 2, -42, 7, 3, top); r(c, 0, -33, 1, 7, '#e8e2d0'); r(c, 3, -33, 1, 6, '#e8e2d0'); }
        if (S.topKind === 'puffer') for (let k = 0; k < 3; k++) r(c, -bx + 1, -37 + k * 6, bx * 2 - 2, 1, shadeHex(top, .8));
        if (S.topKind === 'coat') { r(c, -wide, -19, wide * 2, 5, top); r(c, -wide, -15, wide * 2, 1, edge); }
        break;
      case 'pullover':
        r(c, -bx + 1, -44, 10, 5, edge); r(c, -bx + 2, -43, 8, 3, shadeHex(top, 1.6)); // capuz atrás do pescoço
        r(c, 0, -40, 1, 6, '#e8e2d0'); r(c, 4, -40, 1, 5, '#e8e2d0');                 // cordões
        r(c, -bx + 4, -25, bx * 2 - 7, 5, shadeHex(top, 1.5)); r(c, -bx + 5, -24, bx * 2 - 9, 3, top); // bolso canguru
        if (S.print === 'pizza') { // fatia de pizza com contorno branco
          poly(c, [[-8, -38], [9, -38], [1, -26]], '#f4f1e8');
          poly(c, [[-6, -37], [7, -37], [1, -28]], '#f2c14e');
          r(c, -6, -37, 13, 2, '#c47a35');
          r(c, -2, -34, 2, 2, '#c8382f'); r(c, 2, -33, 2, 2, '#c8382f'); r(c, 0, -30, 2, 2, '#c8382f');
        }
        break;
      case 'polo': r(c, -4, -41, 9, 4, shadeHex(top, .85)); r(c, 0, -38, 1, 6, edge); if (S.pattern) for (let k = 0; k < 6; k++) r(c, -bx + 3 + (k % 3) * 9, -36 + Math.floor(k / 3) * 8, 3, 3, S.pattern); break;
      case 'tank': r(c, -bx + 4, -40, 5, 3, skin); r(c, bx - 8, -40, 5, 3, skin); break;
      case 'apron': r(c, -bx + 4, -38, bx * 2 - 8, belly ? 20 : 19, S.apron); r(c, -2, -42, 1, 4, S.apron); r(c, 2, -42, 1, 4, S.apron); r(c, -bx + 6, -30, bx * 2 - 12, 4, shadeHex(S.apron, .85)); r(c, 3, -29, 4, 2, '#7a9a5a'); break;
      case 'overall': r(c, -bx + 4, -32, bx * 2 - 8, 14, S.pants); r(c, -bx + 4, -40, 3, 9, S.pants); r(c, bx - 7, -40, 3, 9, S.pants); r(c, -2, -29, 5, 3, '#9aa3a6'); if (S.grease) { r(c, -bx + 6, -24, 4, 2, '#1d1d1d'); r(c, 5, -36, 3, 2, '#1d1d1d'); } break;
      case 'vest': r(c, -bx + 2, -40, 7, 21, S.vest); r(c, bx - 9, -40, 7, 21, S.vest); r(c, -bx + 2, -30, 7, 2, S.vestBand); r(c, bx - 9, -30, 7, 2, S.vestBand); break;
      case 'robe': r(c, -3, -40, 2, 20, shadeHex(top, .7)); for (let k = 0; k < 5; k++) r(c, -bx + 3 + (k * 7) % (bx * 2 - 6), -37 + k * 4, 2, 2, S.robeDots); r(c, -wide, -19, wide * 2, 6, top); break;
      case 'uniform': r(c, -bx + 2, -40, bx * 2 - 4, 3, '#2f5f9e'); r(c, -3, -37, 7, 4, '#2f5f9e'); break;
      case 'tee': default:
        if (S.print) { r(c, -4, -34, 10, 8, S.print); r(c, -2, -32, 6, 1, '#f2e8e0'); r(c, -2, -29, 4, 1, '#f2e8e0'); }
        if (S.sparkle) for (let k = 0; k < 4; k++) if ((Math.sin(t * 6 + k * 2) > .4)) r(c, -bx + 4 + k * 6, -37 + (k % 2) * 7, 2, 2, '#ffe4f4');
    }
    if (S.uniform || o.uniform) { r(c, -bx + 2, -40, bx * 2 - 4, 3, '#2f5f9e'); r(c, -3, -37, 7, 4, '#2f5f9e'); }
    if (S.strap) { limb(c, [[-wide + 2, -41], [wide - 3, -20]], 3, S.strap); }
    if (S.bag) { limb(c, [[wide - 2, -41], [-wide + 3, -24]], 2, S.bag); r(c, -wide - 1, -26, 8, 7, S.bag); }
    if (S.chain) { r(c, -5, -40, 12, 1, S.chain); r(c, -3, -39, 8, 2, S.chain); r(c, 0, -37, 3, 3, S.chain); }
    if (S.collar) { const cc = S.collar; poly(c, [[-7, -42], [0, -42], [-1, -37], [-5, -38]], cc); poly(c, [[1, -42], [8, -42], [6, -38], [2, -37]], cc); r(c, 0, -37, 1, 17, shadeHex(S.top, .8)); for (const yb of [-35, -30, -25]) r(c, 1, yb, 1, 1, '#f6f6f0'); } // camisa social: gola e botões
    if (S.skirt) { poly(c, [[-wide, -21], [wide, -21], [wide + 4, -10], [-wide - 4, -10]], OUT); poly(c, [[-wide + 1, -20], [wide - 1, -20], [wide + 2, -11], [-wide - 2, -11]], S.skirt); }
    // cabeça (mesmas medidas dos personagens atuais)
    r(c, -4, -45, 10, 8, shade); r(c, -3, -45, 8, 8, skin);
    if (S.scarf) { r(c, -9, -45, 20, 6, shadeHex(S.scarf, .7)); r(c, -8, -45, 18, 4, S.scarf); r(c, -10, -41, 5, 9, S.scarf); r(c, -9, -36, 3, 1, '#f2e8d8'); }
    r(c, -12, -61 + twitch, 27, 21, OUT); r(c, -10, -59 + twitch, 23, 18, skin); r(c, -11, -55, 3, 12, shade); r(c, 12, -53, 4, 6, skin); r(c, 12, -48, 4, 2, shade);
    // rosto
    const ey = -53 + twitch;
    if (mood === 'angry') { r(c, 1, ey - 3, 8, 2, '#2d3031'); r(c, 3, ey, 3, 3, '#2d3031'); }
    else if (mood === 'cry') { r(c, 2, ey + 1, 5, 2, '#2d3031'); r(c, 3, ey + 3, 2, 6 + Math.round(Math.sin(t * 4) * 2), '#8fd0ea'); }
    else if (mood === 'shock') { r(c, 2, ey - 1, 5, 5, '#f4f2ec'); r(c, 4, ey + 1, 2, 2, '#2d3031'); }
    else if (mood === 'sad') { r(c, 3, ey, 3, 3, '#2d3031'); r(c, 1, ey - 3, 6, 1, shadeHex(S.hair?.color || '#3a2a20', 1)); }
    else { r(c, 3, ey, 3, 3, '#2d3031'); if (twitch) r(c, 2, ey - 1, 5, 1, '#2d3031'); }
    if (S.glasses) { r(c, -1, -56, 12, 7, S.glasses); r(c, 0, -55, 10, 5, '#d8eef4'); r(c, 3, -54, 3, 3, '#2d3031'); r(c, 1, -55, 3, 1, '#ffffff'); r(c, -9, -54, 10, 1, S.glasses); }
    if (S.stubble) { r(c, 4, -47, 9, 1, S.stubble); r(c, 6, -42, 5, 2, S.stubble); r(c, 12, -44, 2, 2, S.stubble); }
    if (S.shades) { r(c, -1, -55, 13, 5, '#14181c'); r(c, 1, -54, 3, 1, '#5a7a9a'); r(c, -9, -54, 10, 1, '#14181c'); }
    if (S.goggles) { r(c, -12, -62, 27, 3, '#3a3a34'); r(c, 1, -63, 7, 5, S.goggles); r(c, 9, -63, 6, 5, S.goggles); }
    // boca
    const mouthC = S.lipstick || '#855e43';
    if (mood === 'happy' || mood === 'smug' || S.pose === 'cocky' || S.pose === 'sing') { r(c, 2, -45, 10, 2, mouthC); r(c, 4, -45, 6, 1, '#f9e7c9'); }
    else if (mood === 'sad' || mood === 'cry') { r(c, 3, -44, 7, 1, mouthC); r(c, 2, -43, 2, 1, mouthC); r(c, 9, -43, 2, 1, mouthC); }
    else if (mood === 'angry') { r(c, 2, -45, 10, 3, '#4a2a22'); r(c, 3, -45, 8, 1, '#f2efe6'); }
    else if (mood === 'shock') { r(c, 4, -46, 5, 4, '#4a2a22'); }
    else r(c, 2, -44, 8, 2, mouthC);
    if (S.lipstick) r(c, 3, -45, 7, 1, S.lipstick);
    if (S.mustache) { r(c, 3, -48, 11, 3, S.mustache); r(c, 2, -46, 3, 2, S.mustache); }
    if (S.goatee) { r(c, 3, -42, 8, 3, S.goatee); r(c, 4, -39, 6, 2, S.goatee); } // cavanhaque
    if (S.beard) { r(c, -9, -50, 6, 9, S.beard); r(c, -4, -44, 18, 4, S.beard); r(c, 1, -47, 12, 2, S.beard); r(c, 3, -45, 7, 1, '#7a4a3a'); }
    if (S.earrings) { r(c, -9, -50, 3, 4, S.earrings); }
    hairFront(c, S, t); hat(c, S);
    if (S.thinGlasses) { // armação fina e escura, só em cima (meio aro), desenhada por cima dos cachos
      const g = S.thinGlasses; r(c, -1, -55, 13, 2, g); r(c, -1, -55, 1, 5, g); r(c, 11, -55, 1, 4, g); r(c, 0, -53, 11, 4, '#d8eef433'); r(c, 1, -53, 2, 1, '#ffffffaa'); r(c, -9, -54, 8, 1, g); r(c, 3, -53, 3, 3, '#2d3031');
    }
    if (S.headset) { r(c, -14, -63, 28, 3, S.headset); r(c, -15, -58, 5, 9, S.headset); limb(c, [[-12, -51], [-2, -45], [6, -44]], 2, S.headset); r(c, 5, -45, 3, 2, '#5ae0d0'); }
    hand(1);
    if (S.item && !attack && !o.reach && o.item !== false) item(c, S, Rh[0], Rh[1], t, o);
    if (o.dash) { r(c, -39, -45, 16, 2, '#d7b184'); r(c, -48, -31, 21, 2, '#aa8a78'); }
    if (o.hit) { c.save(); c.globalAlpha *= .5; r(c, -wide - 6, -66, wide * 2 + 13, 65, '#ffe7bd'); c.restore(); }
    c.restore();
  }

  /* ---------- Biscoito, o cachorro caramelo ---------- */
  function biscoito(c, x, y, o) {
    c.save(); c.imageSmoothingEnabled = false; c.translate(Math.round(x), Math.round(y)); c.scale((o.facing < 0 ? -1 : 1) * (o.scale || 1), o.scale || 1);
    const t = Number(o.frame) || 0, moving = !!o.moving || Number(o.speed) > 8, run = moving ? Math.sin(t * 12) : 0, wag = Math.sin(t * (moving ? 14 : 9)) * 4;
    const fur = '#c98a43', dark = '#9a6330', light = '#efc58c';
    oval(c, 0, -1, 17, 3, '#2e433d', 2);
    // patas
    [[-11, 1], [-6, -1], [7, 1], [12, -1]].forEach(([lx, ph], i) => { const s = Math.round(run * 4 * (i % 2 ? -1 : 1)); r(c, lx + s - 1, -12, 6, 12, OUT); r(c, lx + s, -12, 4, 10, i < 2 ? dark : fur); r(c, lx + s - 1, -3, 6, 3, light); void ph; });
    // rabo
    limb(c, [[-15, -18], [-20, -24 + wag], [-22, -30 + wag]], 5, OUT); limb(c, [[-15, -18], [-20, -24 + wag], [-22, -30 + wag]], 3, fur);
    // corpo
    r(c, -17, -24, 32, 14, OUT); r(c, -16, -23, 30, 12, fur); r(c, -12, -14, 22, 3, light); r(c, -14, -23, 26, 2, '#dba25c');
    // coleira e cabeça
    r(c, 10, -27, 6, 13, '#c43c3a'); r(c, 12, -18, 3, 3, '#f2c94c');
    r(c, 10, -38, 18, 16, OUT); r(c, 11, -37, 16, 14, fur); r(c, 22, -31, 9, 8, OUT); r(c, 23, -30, 8, 6, light); r(c, 28, -31, 3, 3, '#2a1a14');
    r(c, 19, -34, 3, 3, '#2d3031'); r(c, 20, -34, 1, 1, '#ffffff');
    r(c, 10, -41, 6, 9, OUT); r(c, 11, -40, 4, 8, dark); // orelha
    if (o.emotion === 'happy' || moving) { r(c, 24, -24, 4, 4, '#e86a7a'); }
    if (o.bark) { for (let i = 0; i < 3; i++) r(c, 34 + i * 4, -38 + i * 3, 3, 2, '#f2efe6'); }
    if (o.hit) { c.save(); c.globalAlpha *= .5; r(c, -18, -42, 50, 42, '#ffe7bd'); c.restore(); }
    c.restore();
  }

  /* ---------- versões de idade para o flashback do trio ----------
     criança: bem menor e mais "baixinha"; pré-adolescente: quase do tamanho atual. */
  const AGES = { crianca: { sx: .7, sy: .64 }, pre: { sx: .84, sy: .82 } };
  const KID = { daroca: 'daroca', reeis: 'reeis', jorge: 'jorge_gordo' };
  function aged(c, age, who, x, y, o) {
    const A = AGES[age], t = KID[who];
    c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(A.sx, A.sy);
    draw(c, t, 0, 0, { ...o, look: who === 'daroca' ? false : o.look });
    c.restore();
  }

  function draw(c, type, x, y, o = {}) {
    if (SPEC[type]) return person(c, type, SPEC[type], x, y, o);
    if (type === 'c2_biscoito') return biscoito(c, x, y, o);
    const m = /^(crianca|pre)_(daroca|reeis|jorge)$/.exec(type || '');
    if (m) return aged(c, m[1], m[2], x, y, o);
    return base(c, type, x, y, o);
  }
  window.Art.drawCharacter = draw;

  const lista = Object.keys(SPEC).map((id) => ({ id, nome: SPEC[id].name, papel: ROLE[id] || '' }));
  lista.splice(lista.findIndex((p) => p.id === 'c2_picole'), 0, { id: 'c2_biscoito', nome: 'Biscoito (cachorro caramelo)', papel: 'aliado' });
  // outros arquivos da Campanha 2 (2D: personagens novos e moradores) registram mais gente aqui
  function registrar(id, spec, papel = '') { if (!id || !spec || SPEC[id]) return false; SPEC[id] = spec; ROLE[id] = papel; lista.push({ id, nome: spec.name, papel }); return true; }
  window.CampanhaPersonagens = Object.freeze({
    get lista() { return Object.freeze(lista.slice()); },
    registrar,
    idades: ['crianca_daroca', 'crianca_reeis', 'crianca_jorge', 'pre_daroca', 'pre_reeis', 'pre_jorge'],
    has: (type) => !!SPEC[type] || type === 'c2_biscoito' || /^(crianca|pre)_(daroca|reeis|jorge)$/.test(type || '')
  });
})();
