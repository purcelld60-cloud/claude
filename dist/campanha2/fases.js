/* Campanha 2 · Passo 6B: as FASES dos vilões, no mesmo sistema da campanha 1.
   Cada fase tem inimigos espalhados pelo caminho (que soltam moedas), biscoitos de polvilho que curam,
   um ponto de controle antes do chefe e a ARENA: chegando perto, a cutscene de entrada toca, as barreiras
   fecham e o chefe aparece com placa de nome e nível. O chefe tem 3 FASES (a vida renova e ele fica mais
   forte e mais rápido), sempre AVISA antes do golpe (marca no chão, sombra ou faixa vermelha) e fica
   VULNERÁVEL logo depois de atacar (fora disso ele defende parte do dano). Vencido: placa DERROTADO!,
   moedas, a cutscene da derrota e a garrafada do poder liberada na banca do Seu Lindomar.
   6B: Dona Creuza (bairro), Tonhão (Monumento ao Índio), Seu Valdomiro (Feira) e Kauã (Serra do Periperi). */
(() => {
  'use strict';
  if (window.CampanhaFases) return;
  const FLOOR = 440, TAU = Math.PI * 2;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v)), rnd = (a, b) => a + Math.random() * (b - a);
  const PW = () => window.CampanhaPoderes, txt = (c, s, x, y, col, o) => window.CampanhaCamadas?.kit?.pxText?.(c, s, x, y, col, o);

  /* ---------- inimigos comuns (mesmo traço dos personagens) ---------- */
  const reg = (id, spec) => window.CampanhaPersonagens?.registrar?.(id, spec, 'inimigo');
  reg('c2i_vizinha', { name: 'Vizinha fofoqueira', skin: '#d9a57f', shade: '#ac7856', build: 'normal', h: .92, top: '#8ab8e0', topKind: 'robe', robeDots: '#d8ecf8', pants: '#8ab8e0', hair: { style: 'curlers', color: '#4a2e22', curler: '#f0a0c0' }, item: 'phone', pose: 'phone' });
  reg('c2i_vizinha2', { name: 'Vizinha fofoqueira', skin: '#b07a52', shade: '#82563a', build: 'belly', h: .9, top: '#c8a0e0', topKind: 'robe', robeDots: '#ead8f6', pants: '#c8a0e0', hair: { style: 'curlers', color: '#2a1d16', curler: '#7cc7d8' }, item: 'phone', pose: 'phone' });
  reg('c2i_motoca', { name: 'Mototaxista', skin: '#a96f48', shade: '#7c4f33', build: 'normal', top: '#3a3f44', topKind: 'vest', vest: '#f08a24', vestBand: '#e8f06a', pants: '#2a3038', hat: { kind: 'helmet', color: '#2c5a9e', visor: '#2a3a46' }, item: 'keys', pose: 'hips' });
  reg('c2i_feirante', { name: 'Feirante', skin: '#c48a60', shade: '#956445', build: 'normal', top: '#c84a3a', topKind: 'apron', apron: '#e9dcc0', pants: '#4f4a3e', hat: { kind: 'cap', color: '#3c8a5a' }, hair: { style: 'short', color: '#2a1d16' }, item: 'biscuit', pose: 'offer' });
  reg('c2i_seguidor', { name: 'Seguidor do Kauã', skin: '#e9c2a3', shade: '#bb9275', build: 'slim', top: '#2a2c34', topKind: 'puffer', pants: '#3a4252', hair: { style: 'quiff', color: '#1a1410', tips: '#c8d8ff' }, shades: true, item: 'selfie', pose: 'selfie' });

  // pombo e urubu (voam): desenho próprio em pixel
  function ave(c, x, y, t, urubu, dir, hit) {
    const R = (a, b, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(a), Math.round(b), w, h); }, asa = Math.sin(t * (urubu ? 9 : 16)) > 0, s = urubu ? 1.5 : 1;
    const corpo = hit ? '#ffffff' : urubu ? '#1c1a1a' : '#8a9096', claro = urubu ? '#3a3636' : '#b8bec4';
    c.save(); c.translate(x, y); c.scale(dir * s, s);
    R(-8, -4, 15, 7, '#120e0e'); R(-7, -3, 13, 5, corpo); R(-6, -3, 8, 2, claro); R(5, -7, 6, 6, '#120e0e'); R(6, -6, 4, 4, urubu ? '#c86a5a' : corpo); R(8, -5, 1, 1, '#000');
    R(10, -4, 3, 2, urubu ? '#d8c8a0' : '#e8833a'); if (!urubu) R(5, -2, 3, 2, '#5aa06a');
    if (asa) { R(-5, -12, 9, 9, '#120e0e'); R(-4, -11, 7, 7, corpo); } else { R(-5, 2, 9, 7, '#120e0e'); R(-4, 2, 7, 5, corpo); }
    R(-11, -2, 4, 3, corpo); c.restore();
  }
  function moto(c, x, y, cor, dir, t) {
    const R = (a, b, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(a), Math.round(b), w, h); };
    c.save(); c.translate(x, y); c.scale(dir, 1);
    R(-26, -4, 52, 3, 'rgba(0,0,0,.3)'); for (const wx of [-18, 18]) { R(wx - 9, -18, 18, 18, '#14141a'); R(wx - 5, -14, 10, 10, '#5a5e66'); R(wx - 2, -11, 4, 4, '#c8ccd0'); }
    R(-14, -24, 30, 8, cor); R(-14, -24, 30, 2, '#ffffff55'); R(10, -32, 6, 10, '#2a2a2a'); R(12, -34, 10, 3, '#3a3a3a'); R(20, -26, 5, 4, '#fff2b0'); R(-22, -20, 10, 3, '#8a8e94');
    c.restore();
  }

  /* ---------- as fases ---------- */
  const FASES = {
    creuza: { cena: 13, hora: 9.5, checkpoint: 2950,
      chefe: { tipo: 'c2_creuza', nome: 'DONA CREUZA', titulo: 'A FOFOQUEIRA DO BAIRRO', nivel: 3, x: 3520, hp: 230, cor: '#e48fb0', proj: 'balao', arena: [-380, 340], vel: 1,
        golpes: [['leque', 'investida', 'leque', 'chuva'], ['leque', 'invocar', 'chuva', 'investida', 'leque'], ['chuva', 'leque', 'onda', 'invocar', 'investida', 'leque']], minion: 'vizinha',
        falas: ['PSIU!', 'JURA?!', 'EU SEMPRE SEI!', 'FORASTEIRO!', 'VOU CONTAR PRA TODO MUNDO!'] },
      intro: 'c2_vilao_creuza', derrota: 'c2_derrota_creuza',
      inimigos: [['vizinha', 2150], ['pombo', 2320], ['vizinha', 2520], ['pombo', 2640], ['vizinha2', 2780], ['pombo', 2880], ['vizinha', 3020]], curas: [2420, 2980] },
    tonhao: { cena: 16, hora: 11, checkpoint: 4820,
      chefe: { tipo: 'c2_tonhao', nome: 'TONHÃO', titulo: 'O REI DO MOTOTÁXI', nivel: 5, x: 5320, hp: 290, cor: '#f08a24', proj: 'nota', arena: [-400, 380], vel: 1.08,
        golpes: [['investida', 'leque', 'investida', 'onda'], ['investida', 'onda', 'leque', 'invocar', 'investida'], ['investida', 'chuva', 'investida', 'onda', 'leque', 'invocar']], minion: 'motoca', moto: true,
        falas: ['CENTO E CINQUENTA!', 'TAXA DE NEBLINA!', 'NINGUÉM FOGE DO TONHÃO!', 'FOOOM!', 'PAGA A CORRIDA!'] },
      intro: 'c2_vilao_tonhao', derrota: 'c2_derrota_tonhao',
      inimigos: [['motoca', 3260], ['pombo', 3480], ['motoca', 3820], ['motoca', 4120], ['pombo', 4600], ['motoca', 4760]], curas: [3600, 4650] },
    valdomiro: { cena: 17, hora: 9, checkpoint: 3000,
      chefe: { tipo: 'c2_valdomiro', nome: 'SEU VALDOMIRO', titulo: 'O CHEFÃO DA FEIRA', nivel: 7, x: 3560, hp: 340, cor: '#e9d6a8', proj: 'biscoito', arena: [-400, 360], vel: 1.12,
        golpes: [['leque', 'chuva', 'leque', 'investida'], ['chuva', 'leque', 'onda', 'invocar', 'leque'], ['leque', 'chuva', 'investida', 'onda', 'chuva', 'invocar']], minion: 'feirante',
        falas: ['NO QUILO!', 'POLVILHO NA CARA!', 'A FEIRA É MINHA!', 'SEM A MINHA BÊNÇÃO, NÃO!', 'BISCOITO QUENTINHO!'] },
      intro: 'c2_vilao_valdomiro', derrota: 'c2_derrota_valdomiro',
      inimigos: [['feirante', 980], ['feirante', 1300], ['pombo', 1820], ['feirante', 2100], ['feirante', 2450], ['pombo', 2620], ['feirante', 2860]], curas: [1650, 2700] },
    kaua: { cena: 15, hora: 16.8, checkpoint: 4290,
      chefe: { tipo: 'c2_kaua_influencer', nome: 'KAUÃ INFLUENCER', titulo: '2 MILHÕES DE SEGUIDORES (QUASE)', nivel: 9, x: 4520, hp: 380, cor: '#c8d8ff', proj: 'flash', arena: [-220, 240], vel: 1.18,
        golpes: [['raio', 'leque', 'raio', 'investida'], ['raio', 'invocar', 'leque', 'raio', 'chuva'], ['raio', 'chuva', 'raio', 'investida', 'leque', 'invocar', 'raio']], minion: 'seguidor',
        falas: ['DEIXA O LIKE!', 'ATIVA O SININHO!', 'TÁ GRAVANDO!', 'VAI VIRALIZAR!', 'CORTA ESSA PARTE!'] },
      intro: 'c2_vilao_kaua', derrota: 'c2_derrota_kaua',
      inimigos: [['urubu', 900], ['seguidor', 1240], ['urubu', 1900], ['seguidor', 2200], ['urubu', 2500], ['seguidor', 3150], ['urubu', 3500], ['seguidor', 3900]], curas: [1260, 2350, 3700] }
  };
  const TIPO = { vizinha: 'c2i_vizinha', vizinha2: 'c2i_vizinha2', motoca: 'c2i_motoca', feirante: 'c2i_feirante', seguidor: 'c2i_seguidor', pombo: null, urubu: null };
  const STATS = { vizinha: { hp: 34, ia: 'tiro', proj: 'balao', dano: 9 }, vizinha2: { hp: 40, ia: 'tiro', proj: 'balao', dano: 10 }, pombo: { hp: 14, ia: 'voa', dano: 8 }, urubu: { hp: 22, ia: 'voa', dano: 11 },
    motoca: { hp: 46, ia: 'carga', dano: 13 }, feirante: { hp: 40, ia: 'tiro', proj: 'fruta', dano: 10 }, seguidor: { hp: 42, ia: 'flash', dano: 10 } };

  /* =====================================================================
     uma fase em andamento
     ===================================================================== */
  function criar(slug, api) {
    const F = FASES[slug]; if (!F) return null; const K = F.chefe, P = api.P;
    const efeitos = [], projs = [], textos = [], placas = []; let t = 0, falaT = 3, falaTxt = '', falaVida = 0;
    const novoInimigo = (k, x, extra = {}) => { const st = STATS[k]; const e = { k, tipo: TIPO[k], x, homeX: x, y: st.ia === 'voa' ? 300 : FLOOR, hp: st.hp, max: st.hp, dir: -1, st: 'patrulha', tt: rnd(0, 1.5), hit: 0, vx: 0, vy: 0, stun: 0, conf: 0, golpe: 0, alto: st.ia === 'voa' ? 24 : 70, largura: st.ia === 'voa' ? 20 : 22, morto: 0, ...extra };
      e.onDano = (n, tipo) => danoInimigo(e, n, tipo); return e; };
    const inimigos = F.inimigos.map(([k, x]) => novoInimigo(k, x));
    const curas = F.curas.map((x) => ({ x, pego: false }));
    const B = { tipo: K.tipo, x: K.x, y: FLOOR, homeX: K.x, hp: K.hp, max: K.hp, fase: 1, st: 'espera', tt: 0, hit: 0, golpe: null, padrao: 0, dir: -1, vx: 0, vy: 0, stun: 0, conf: 0, alto: 96, largura: 30, armor: .55, morto: 0 };
    B.onDano = (n, tipo) => danoChefe(n, tipo);
    const HPF = [1, 1.25, 1.5].map((m) => Math.round(K.hp * m));
    const arena = { ativa: false, l: K.x + K.arena[0], r: K.x + K.arena[1] };
    let vencido = false;

    function placa(titulo, sub, cor = '#ffd25a', vida = 2) { placas.push({ titulo, sub, cor, t: 0, vida }); }
    function flutua(x, y, s, cor) { textos.push({ x, y, s: String(s), cor, t: 0 }); }

    /* ----- dano nos inimigos ----- */
    function danoInimigo(e, n, tipo) {
      if (e.hp <= 0) return false; e.hp -= n; e.hit = .16; e.vx += (P.x < e.x ? 1 : -1) * 60;
      if (e.hp <= 0) { e.hp = 0; e.morto = 1; window.CampanhaLoja?.ganhar?.(6); flutua(e.x, e.y - 100, '+6 ●', '#ffd24a'); api.sfx('plim'); if (Math.random() < .22) curas.push({ x: e.x, pego: false, solta: true }); }
      return n;
    }
    function danoChefe(n, tipo) {
      if (B.st === 'espera' || B.st === 'troca' || B.st === 'derrotado' || B.st === 'entrada') return false;
      const exposto = B.st === 'recupera' || B.stun > 0, d = Math.max(1, Math.round(n * (exposto ? 1 : B.armor))); B.hp -= d; B.hit = .14; api.tremer(exposto ? 3 : 1.5);
      if (B.hp <= 0) { if (B.fase < 3) novaFase(B.fase + 1); else derrotar(); }
      return exposto ? d + '!' : d;
    }
    function novaFase(f) {
      B.fase = f; B.max = B.hp = HPF[f - 1]; B.st = 'troca'; B.tt = 1.3; B.padrao = 0; B.golpe = null; projs.length = 0; inimigos.forEach((e) => { if (e.invocado) e.hp = 0; });
      P.inv = Math.max(P.inv || 0, 1.3); api.tremer(9); api.flash('#f6d8ff'); api.sfx('vs');
      placa('FASE ' + f, f === 3 ? 'ÚLTIMA FASE · VIDA RENOVADA' : 'VIDA RENOVADA · ' + (/A$/.test(K.nome) || K.nome === 'DONA CREUZA' ? 'ELA' : 'ELE') + ' FICOU MAIS FORTE', '#ffb36b', 1.8);
      fala(['AGORA É SÉRIO!', 'VOCÊ VAI VER!', 'AINDA NÃO ACABOU!'][f - 2] || 'AH, É?');
    }
    function derrotar() {
      B.hp = 0; B.st = 'derrotado'; B.tt = 2.2; projs.length = 0; inimigos.forEach((e) => { if (e.invocado) e.hp = 0; }); vencido = true;
      api.tremer(12); api.flash('#fff6d8'); api.sfx('fanfarra'); window.CampanhaLoja?.ganhar?.(60); flutua(B.x, B.y - 120, '+60 ●', '#ffd24a');
      placa('DERROTAD' + (K.nome === 'DONA CREUZA' ? 'A' : 'O') + '!', K.nome, '#ffd25a', 2.2);
    }
    function fala(s) { falaTxt = s; falaVida = 1.6; }

    /* ----- golpes do chefe (sempre com aviso antes) ----- */
    const vel = () => K.vel * (1 + (B.fase - 1) * .14);
    function escolherGolpe() { const lista = K.golpes[B.fase - 1]; const g = lista[B.padrao % lista.length]; B.padrao++; return g; }
    function prepara(g) {
      B.golpe = { g, t: 0, aviso: Math.max(.45, .85 / vel()) }; B.st = 'carga'; B.dir = P.x < B.x ? -1 : 1;
      if (g === 'investida') B.golpe.alvo = B.dir < 0 ? arena.l + 30 : arena.r - 30;
      if (g === 'chuva') { const n = 3 + B.fase * 2; B.golpe.pontos = Array.from({ length: n }, (_, i) => clamp(P.x + (i - (n - 1) / 2) * rnd(52, 70) + rnd(-12, 12), arena.l + 20, arena.r - 20)); }
      if (g === 'raio') { const n = 1 + B.fase; B.golpe.pontos = [P.x, ...Array.from({ length: n - 1 }, () => clamp(P.x + rnd(-200, 200), arena.l + 20, arena.r - 20))]; }
      if (g === 'onda') B.y = FLOOR;
    }
    function solta(g) {
      const G = B.golpe, d = Math.round((10 + B.fase * 2) * 1);
      if (g === 'leque') { const n = 1 + B.fase * 2, a0 = Math.atan2(P.y - 40 - (B.y - 50), P.x - B.x); for (let i = 0; i < n; i++) { const a = a0 + (i - (n - 1) / 2) * .17; projs.push({ x: B.x + B.dir * 20, y: B.y - 50, vx: Math.cos(a) * 300 * vel(), vy: Math.sin(a) * 300 * vel(), g: 0, tipo: K.proj, dano: d, vida: 4, rot: 0 }); } api.sfx('whoosh'); }
      if (g === 'investida') { G.corre = true; api.sfx(K.moto ? 'buzina' : 'whoosh'); }
      if (g === 'chuva') { for (const x of G.pontos) projs.push({ x, y: -30 - rnd(0, 80), vx: 0, vy: 520, g: 0, tipo: K.proj, dano: d + 2, vida: 3, cai: true }); }
      if (g === 'onda') { for (const s of [-1, 1]) projs.push({ x: B.x + s * 20, y: FLOOR - 4, vx: s * 360 * vel(), vy: 0, g: 0, tipo: 'onda', dano: d, vida: 3, chao: true }); api.tremer(6); api.sfx('impacto'); }
      if (g === 'invocar') { const vivos = inimigos.filter((e) => e.invocado && e.hp > 0).length; for (let k = vivos; k < 2; k++) { const x = k ? arena.r - 40 : arena.l + 40; inimigos.push(novoInimigo(K.minion, x, { invocado: true, homeX: x })); efeitos.push({ k: 'poeira', x, y: FLOOR, t: 0 }); } fala('VEM, GALERA!'); api.sfx('risada'); }
      if (g === 'raio') { for (const x of G.pontos) efeitos.push({ k: 'raio', x, t: 0, dano: d + 4 }); api.flash('#ffffff'); api.sfx('impacto'); }
    }

    /* ----- quadro a quadro ----- */
    function update(dt) {
      t += dt; falaVida = Math.max(0, falaVida - dt);
      // biscoitos (cura)
      for (const q of curas) if (!q.pego && Math.abs(P.x - q.x) < 22 && P.y > FLOOR - 60) { q.pego = true; P.hp = Math.min(100, P.hp + 20); flutua(q.x, FLOOR - 70, '+20 ♥', '#ff8a7a'); api.sfx('plim'); }
      // inimigos comuns
      for (const e of inimigos) atualizaInimigo(e, dt);
      for (let i = inimigos.length - 1; i >= 0; i--) if (inimigos[i].hp <= 0 && inimigos[i].morto > 1.6) inimigos.splice(i, 1);
      // chefe
      atualizaChefe(dt);
      // projéteis inimigos
      for (const q of projs) { q.vida -= dt; q.x += q.vx * dt; q.y += q.vy * dt; q.vy += (q.g || 0) * dt; q.rot = (q.rot || 0) + dt * 8;
        if (q.cai && q.y >= FLOOR - 8) { q.vida = 0; efeitos.push({ k: 'poeira', x: q.x, y: FLOOR, t: 0 }); if (Math.abs(P.x - q.x) < 30 && P.y > FLOOR - 40) api.ferir(q.dano, q.x); continue; }
        if (q.y > FLOOR + 10) q.vida = 0;
        const alto = q.chao ? 26 : 18; if (Math.abs(P.x - q.x) < (q.chao ? 16 : 18) && P.y - 60 < q.y + 6 && P.y > q.y - alto + (q.chao ? 0 : -6)) { if (q.chao ? P.y > FLOOR - 22 : true) { api.ferir(q.dano, q.x); q.vida = 0; } } }
      for (let i = projs.length - 1; i >= 0; i--) if (projs[i].vida <= 0 || projs[i].x < arena.l - 900 || projs[i].x > arena.r + 900) projs.splice(i, 1);
      for (const f of efeitos) { f.t += dt; if (f.k === 'raio' && !f.feito && f.t > .05) { f.feito = true; if (Math.abs(P.x - f.x) < 26) api.ferir(f.dano, f.x); } }
      for (let i = efeitos.length - 1; i >= 0; i--) if (efeitos[i].t > (efeitos[i].k === 'raio' ? .5 : .6)) efeitos.splice(i, 1);
      for (const x of textos) x.t += dt; for (let i = textos.length - 1; i >= 0; i--) if (textos[i].t > 1) textos.splice(i, 1);
      for (const p of placas) p.t += dt; for (let i = placas.length - 1; i >= 0; i--) if (placas[i].t > placas[i].vida) placas.splice(i, 1);
      // a arena fecha quando você entra
      if (B.st === 'espera' && P.x > arena.l + 60 && !vencido) { arena.ativa = true; B.st = 'entrada'; api.entrarArena(); }
      if (arena.ativa) P.x = clamp(P.x, arena.l + 16, arena.r - 16);
    }
    function atualizaInimigo(e, dt) {
      if (e.hp <= 0) { e.morto += dt; return; }
      e.hit = Math.max(0, e.hit - dt); e.stun = Math.max(0, e.stun - dt); e.conf = Math.max(0, e.conf - dt); e.golpe = Math.max(0, e.golpe - dt);
      e.x += e.vx * dt; e.vx *= Math.pow(.05, dt); const st = STATS[e.k];
      if (st.ia !== 'voa') { e.vy += 1400 * dt; e.y = Math.min(FLOOR, e.y + e.vy * dt); if (e.y >= FLOOR) e.vy = 0; }
      if (arena.ativa && !e.invocado && (e.x > arena.l - 40 && e.x < arena.r + 40)) e.x = e.x < (arena.l + arena.r) / 2 ? arena.l - 50 : arena.r + 50;
      if (e.stun > 0) return;
      const dx = P.x - e.x, perto = Math.abs(dx) < 430 && Math.abs(dx) > 0;
      if (e.conf > 0) { const alvo = inimigos.filter((o) => o !== e && o.hp > 0).sort((a, b) => Math.abs(a.x - e.x) - Math.abs(b.x - e.x))[0] || (B.st !== 'espera' && B.hp > 0 ? B : null);
        if (alvo) { const d = alvo.x - e.x; e.dir = Math.sign(d) || 1; if (Math.abs(d) > 36) e.x += e.dir * 120 * dt; else if (e.golpe <= 0) { e.golpe = .8; alvo === B ? danoChefe(5, 'confuso') : danoInimigo(alvo, 6, 'confuso'); flutua(e.x, e.y - 90, 'TOMA!', '#e48fb0'); } } return; }
      e.tt -= dt; if (e.st !== 'ataca') e.dir = dx < 0 ? -1 : 1;
      if (st.ia === 'voa') { // pombo e urubu: rondam lá em cima e mergulham
        if (e.st === 'patrulha') { e.x += Math.sin(t * 1.4 + e.homeX) * 40 * dt; e.y += (290 + Math.sin(t * 2 + e.homeX) * 16 - e.y) * dt * 2; if (perto && Math.abs(dx) < 300) e.x += Math.sign(dx) * 90 * dt; if (perto && e.tt <= 0) { e.st = 'mira'; e.tt = .6; } }
        else if (e.st === 'mira') { e.y -= 30 * dt; if (e.tt <= 0) { e.st = 'ataca'; e.alvo = [P.x, P.y - 24]; e.tt = 1; } }
        else if (e.st === 'ataca') { const ax = e.alvo[0] - e.x, ay = e.alvo[1] - e.y, d = Math.hypot(ax, ay) || 1; e.x += ax / d * 420 * dt; e.y += ay / d * 420 * dt; if (Math.abs(P.x - e.x) < 20 && Math.abs(P.y - 30 - e.y) < 30) { api.ferir(st.dano, e.x); e.st = 'volta'; } if (d < 14 || e.tt <= 0) { e.st = 'volta'; e.tt = 1.6; } }
        else if (e.st === 'volta') { e.y += (290 - e.y) * dt * 2.4; if (e.tt <= 0) { e.st = 'patrulha'; e.tt = rnd(1.2, 2.4); } }
        return; }
      if (st.ia === 'carga') { // mototaxista: acelera e passa por cima
        if (e.st === 'patrulha') { e.x += Math.sin(t * .8 + e.homeX) * 30 * dt; if (perto && Math.abs(dx) < 380 && e.tt <= 0) { e.st = 'mira'; e.tt = .85; e.dir = Math.sign(dx); e.alvoX = e.x + e.dir * 520; } }
        else if (e.st === 'mira') { if (e.tt <= 0) { e.st = 'ataca'; e.tt = 1.1; api.sfx('buzina'); } }
        else if (e.st === 'ataca') { e.x += e.dir * 520 * dt; if (Math.abs(P.x - e.x) < 30 && P.y > FLOOR - 40) { api.ferir(st.dano, e.x - e.dir * 20); } if (e.tt <= 0) { e.st = 'patrulha'; e.tt = rnd(1.4, 2.2); } }
        return; }
      // a pé: tiro (vizinha, feirante) ou flash (seguidor)
      const dist = st.ia === 'tiro' ? 240 : 60;
      if (e.st === 'patrulha') { if (perto) { if (Math.abs(dx) > dist + 30) e.x += Math.sign(dx) * 70 * dt; else if (Math.abs(dx) < dist - 40 && st.ia === 'tiro') e.x -= Math.sign(dx) * 50 * dt; if (e.tt <= 0 && Math.abs(dx) < dist + 60) { e.st = 'mira'; e.tt = st.ia === 'flash' ? .7 : .6; } } else e.x += (e.homeX - e.x) * dt * .5; }
      else if (e.st === 'mira') { if (e.tt <= 0) { e.st = 'patrulha'; e.tt = rnd(1.3, 2.3);
        if (st.ia === 'tiro') { const vx = clamp(dx * 1.2, -340, 340); projs.push({ x: e.x + e.dir * 12, y: e.y - 52, vx, vy: -330, g: 900, tipo: st.proj, dano: st.dano, vida: 3 }); }
        else { efeitos.push({ k: 'flashP', x: e.x + e.dir * 30, y: e.y - 50, t: 0 }); if (Math.abs(dx) < 90 && Math.abs(P.y - e.y) < 60) { api.ferir(st.dano, e.x); P.atordoado = .5; } api.sfx('plim'); } } }
    }
    function atualizaChefe(dt) {
      B.hit = Math.max(0, B.hit - dt); B.stun = Math.max(0, B.stun - dt); B.conf = Math.max(0, B.conf - dt); B.x += B.vx * dt; B.vx *= Math.pow(.05, dt);
      if (B.st === 'espera' || B.st === 'entrada') return;
      if (B.st === 'derrotado') { B.tt -= dt; if (B.tt <= 0 && !B.fim) { B.fim = true; api.vencer(); } return; }
      B.x = clamp(B.x, arena.l + 30, arena.r - 30); B.tt -= dt;
      falaT -= dt; if (falaT <= 0) { falaT = rnd(4, 6.5); fala(K.falas[Math.floor(rnd(0, K.falas.length))]); }
      if (B.stun > 0) return;
      if (B.st === 'troca') { if (B.tt <= 0) { B.st = 'idle'; B.tt = .6; } return; }
      if (B.st === 'idle') { const dx = P.x - B.x; B.dir = dx < 0 ? -1 : 1; const ideal = 200; if (Math.abs(dx) > ideal + 40) B.x += Math.sign(dx) * 90 * vel() * dt; else if (Math.abs(dx) < ideal - 60) B.x -= Math.sign(dx) * 70 * dt;
        if (B.tt <= 0) prepara(escolherGolpe()); return; }
      if (B.st === 'carga') { const G = B.golpe; G.t += dt; if (G.t >= G.aviso) { solta(G.g); B.st = 'ataque'; G.t = 0; } return; }
      if (B.st === 'ataque') { const G = B.golpe; G.t += dt;
        if (G.g === 'investida') { const sp = (K.moto ? 640 : 520) * vel(); B.x += B.dir * sp * dt; if (Math.abs(P.x - B.x) < 30 && P.y > FLOOR - 56) api.ferir(16 + B.fase * 2, B.x - B.dir * 30); if ((B.dir > 0 && B.x >= G.alvo) || (B.dir < 0 && B.x <= G.alvo) || G.t > 2) { B.st = 'recupera'; B.tt = 1.2; api.tremer(5); } return; }
        if (G.t > .45) { B.st = 'recupera'; B.tt = Math.max(.75, 1.25 - B.fase * .12); } return; }
      if (B.st === 'recupera') { if (B.tt <= 0) { B.st = 'idle'; B.tt = Math.max(.35, .9 - B.fase * .15); } }
    }

    /* ----- desenho ----- */
    const R = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
    function projetil(c, q) {
      const x = Math.round(q.x), y = Math.round(q.y);
      if (q.tipo === 'balao') { R(c, x - 13, y - 9, 26, 16, '#2a1a10'); R(c, x - 12, y - 8, 24, 14, '#fff6dc'); R(c, x - 3, y + 6, 5, 4, '#2a1a10'); R(c, x - 2, y + 6, 3, 2, '#fff6dc'); txt(c, ['PSIU', 'JURA', '?!'][(Math.abs(x) >> 4) % 3], x, y - 5, '#c43c6a'); }
      else if (q.tipo === 'nota') { c.save(); c.translate(x, y); c.rotate(q.rot * .3); R(c, -10, -10, 20, 20, '#3a1a08'); R(c, -8, -8, 16, 16, '#f08a24'); R(c, -4, -4, 8, 8, '#ffd27a'); c.restore(); }
      else if (q.tipo === 'biscoito') { c.save(); c.translate(x, y); c.rotate(q.rot); c.strokeStyle = '#6a4a2a'; c.lineWidth = 7; c.beginPath(); c.arc(0, 0, 9, 0, TAU); c.stroke(); c.strokeStyle = '#e9d6a8'; c.lineWidth = 4; c.beginPath(); c.arc(0, 0, 9, 0, TAU); c.stroke(); c.restore(); }
      else if (q.tipo === 'fruta') { R(c, x - 7, y - 7, 14, 14, '#3a1a08'); R(c, x - 6, y - 6, 12, 12, (Math.abs(x) >> 3) % 2 ? '#e8833a' : '#c43c3a'); R(c, x - 3, y - 5, 4, 3, '#ffffff66'); R(c, x - 1, y - 10, 2, 4, '#3c8a3a'); }
      else if (q.tipo === 'flash') { const s = 8 + Math.sin(q.rot * 2) * 2; R(c, x - s, y - 2, s * 2, 4, '#ffffff'); R(c, x - 2, y - s, 4, s * 2, '#ffffff'); R(c, x - 4, y - 4, 8, 8, '#c8d8ff'); c.globalAlpha = .3; R(c, x - 14, y - 14, 28, 28, '#ffffff'); c.globalAlpha = 1; }
      else if (q.tipo === 'onda') { c.globalAlpha = .9; for (let k = 0; k < 4; k++) R(c, x - 3 - k * Math.sign(q.vx) * 6, y - 24 + k * 5, 6, 24 - k * 5, ['#ffffff', K.cor, K.cor, '#ffffff88'][k]); c.globalAlpha = 1; }
    }
    function personagem(c, tipo, x, y, o) { try { window.Art.drawCharacter(c, tipo, x, y, { frame: t, grounded: true, ...o }); } catch (e) {} }
    function barra(c, x, y, w, f, cor) { R(c, x - w / 2 - 1, y - 1, w + 2, 6, '#1c1408'); R(c, x - w / 2, y, w * clamp(f, 0, 1), 4, cor); }
    function desenhar(c) {
      // avisos no chão (chuva e raio) e a faixa da investida
      if (B.st === 'carga') { const G = B.golpe, k = G.t / G.aviso, pis = Math.floor(t * 12) % 2;
        if (G.g === 'chuva' || G.g === 'raio') for (const x of G.pontos) { c.globalAlpha = .35 + k * .5; R(c, x - 26, FLOOR - 3, 52, 6, pis ? '#ff3a2a' : '#ffd24a'); if (G.g === 'raio') { c.globalAlpha = .12 + k * .25; R(c, x - 22, 0, 44, FLOOR, '#ffffff'); } c.globalAlpha = 1; }
        if (G.g === 'investida') { const x0 = Math.min(B.x, G.alvo), x1 = Math.max(B.x, G.alvo); c.globalAlpha = .25 + k * .45; R(c, x0, FLOOR - 4, x1 - x0, 8, '#ff3a2a'); for (let x = x0; x < x1; x += 34) R(c, x + (pis ? 0 : 12), FLOOR - 12, 12, 4, '#ff3a2a'); c.globalAlpha = 1; }
        if (G.g === 'onda') { c.globalAlpha = .5 * k; c.strokeStyle = K.cor; c.lineWidth = 3; c.beginPath(); c.ellipse(B.x, FLOOR, 30 + k * 60, 8 + k * 6, 0, 0, TAU); c.stroke(); c.globalAlpha = 1; } }
      // barreiras da arena
      if (arena.ativa) for (const x of [arena.l, arena.r]) { // barreira de obra: cavalete listrado, fita e um brilho na cor do chefe
        c.globalAlpha = .16 + Math.sin(t * 4) * .06; R(c, x - 26, FLOOR - 220, 52, 220, K.cor); c.globalAlpha = .3; for (let y = FLOOR - 220; y < FLOOR; y += 22) R(c, x - 26, y + ((t * 40) % 22), 52, 2, '#ffffff'); c.globalAlpha = 1;
        R(c, x - 9, FLOOR - 150, 18, 150, '#1c1408'); for (let y = FLOOR - 148; y < FLOOR; y += 12) R(c, x - 7, y, 14, 6, '#ffd24a'); for (let y = FLOOR - 142; y < FLOOR; y += 12) R(c, x - 7, y, 14, 6, '#2a2a2a');
        R(c, x - 22, FLOOR - 8, 44, 8, '#1c1408'); R(c, x - 20, FLOOR - 6, 40, 5, '#e8833a'); R(c, x - 14, FLOOR - 158, 28, 10, '#1c1408'); R(c, x - 12, FLOOR - 156, 24, 6, Math.floor(t * 3) % 2 ? '#ff3a2a' : '#7a1a1a');
        for (const yy of [FLOOR - 112, FLOOR - 70]) { R(c, x - 40, yy, 80, 6, '#1c1408'); for (let k = 0; k < 80; k += 10) R(c, x - 39 + k, yy + 1, 6, 4, '#ffd24a'); } }
      // biscoitos de cura
      for (const q of curas) if (!q.pego) { const b = Math.sin(t * 3 + q.x) * 3, x = q.x, y = FLOOR - 18 + b; c.strokeStyle = '#6a4a2a'; c.lineWidth = 6; c.beginPath(); c.arc(x, y, 7, 0, TAU); c.stroke(); c.strokeStyle = '#f2e2b8'; c.lineWidth = 3; c.beginPath(); c.arc(x, y, 7, 0, TAU); c.stroke(); if (Math.sin(t * 5 + q.x) > .6) { R(c, x + 8, y - 12, 2, 6, '#fff3a8'); R(c, x + 6, y - 10, 6, 2, '#fff3a8'); } }
      // inimigos
      for (const e of inimigos) {
        const st = STATS[e.k], caido = e.hp <= 0; if (caido) c.globalAlpha = Math.max(0, 1 - e.morto / 1.6);
        if (st.ia === 'voa') ave(c, e.x, e.y + (caido ? e.morto * 120 : 0), t + e.homeX, e.k === 'urubu', e.dir, e.hit > 0);
        else { c.save(); if (caido) { c.translate(e.x, e.y); c.rotate(-e.dir * Math.min(1.4, e.morto * 4)); c.translate(-e.x, -e.y); }
          if (e.k === 'motoca') { const andando = e.st === 'ataca'; moto(c, e.x, e.y, '#c43c3a', e.dir, t); personagem(c, e.tipo, e.x - e.dir * 4, e.y - 18, { facing: e.dir, moving: false, hit: e.hit > 0 }); if (andando) for (let k = 1; k < 5; k++) { c.globalAlpha = .3; R(c, e.x - e.dir * (30 + k * 14), e.y - 20 + k * 3, 10, 3, '#ffffff'); c.globalAlpha = 1; } }
          else personagem(c, e.tipo, e.x, e.y, { facing: e.dir, moving: Math.abs(e.vx) > 5 || e.st === 'patrulha' && Math.abs(P.x - e.x) < 430, hit: e.hit > 0, attack: e.st === 'mira', attackProgress: .3 });
          c.restore(); }
        c.globalAlpha = 1;
        if (!caido) { if (e.st === 'mira') { const pis = Math.floor(t * 10) % 2; R(c, e.x - 3, e.y - e.alto - 30 - (st.ia === 'voa' ? -10 : 0), 6, 12, pis ? '#ff3a2a' : '#ffd24a'); R(c, e.x - 3, e.y - e.alto - 15 - (st.ia === 'voa' ? -10 : 0), 6, 5, pis ? '#ff3a2a' : '#ffd24a'); }
          if (e.hp < e.max) barra(c, e.x, e.y - e.alto - 12, 34, e.hp / e.max, '#e8433a'); if (e.conf > 0) txt(c, '?!', e.x, e.y - e.alto - 26, '#e48fb0'); if (e.stun > 0) for (let k = 0; k < 3; k++) R(c, e.x + Math.cos(t * 6 + k * 2) * 12, e.y - e.alto - 8 + Math.sin(t * 6 + k * 2) * 3, 3, 3, '#ffd24a'); }
      }
      // chefe
      if (B.st !== 'espera' || Math.abs(P.x - B.x) < 1200) {
        const caido = B.st === 'derrotado', sh = B.st === 'carga' ? Math.round(Math.sin(t * 50) * 2) : 0, aura = B.fase >= 2 && !caido;
        if (aura) for (let k = 0; k < 10; k++) { const q = (t * 1.5 + k / 10) % 1; c.globalAlpha = (1 - q) * .5; R(c, B.x + Math.sin(k * 2.3) * 22 - 3, B.y - q * 90, 6, 10, B.fase === 3 ? '#ff5a3a' : K.cor); } c.globalAlpha = 1;
        c.save(); if (caido) { c.translate(B.x, B.y); c.rotate(-B.dir * Math.min(1.5, (2.2 - B.tt) * 3)); c.translate(-B.x, -B.y); }
        if (K.moto && B.st === 'ataque' && B.golpe?.g === 'investida') { moto(c, B.x, B.y, '#c9372f', B.dir, t); personagem(c, B.tipo, B.x - B.dir * 4, B.y - 20, { scale: 1.2, facing: B.dir, hit: B.hit > 0 }); }
        else personagem(c, B.tipo, B.x + sh, B.y, { scale: 1.3, facing: B.dir, moving: B.st === 'idle', hit: B.hit > 0 || (B.st === 'troca' && Math.floor(t * 12) % 2), attack: B.st === 'carga' || B.st === 'ataque', attackProgress: B.st === 'carga' ? .2 : .8 });
        c.restore();
        if (B.st === 'carga') { const pis = Math.floor(t * 10) % 2; R(c, B.x - 4, B.y - 138, 8, 16, pis ? '#ff3a2a' : '#ffd24a'); R(c, B.x - 4, B.y - 118, 8, 7, pis ? '#ff3a2a' : '#ffd24a'); }
        if (B.st === 'recupera') { for (let k = 0; k < 3; k++) R(c, B.x + Math.cos(t * 7 + k * 2.1) * 16, B.y - 108 + Math.sin(t * 7 + k * 2.1) * 4, 4, 4, '#ffd24a'); txt(c, 'ABERTO!', B.x, B.y - 128, '#7af07a', { sombra: '#1c1408' }); }
        if (falaVida > 0 && !caido && B.st !== 'espera') { c.font = 'bold 13px Space, Arial, sans-serif'; const w = c.measureText(falaTxt).width + 20, x = clamp(B.x - w / 2, arena.l - 40, arena.r + 40 - w), y = B.y - 168; R(c, x - 2, y - 2, w + 4, 26, '#8a1a1a'); R(c, x, y, w, 22, '#fff6dc'); R(c, B.x - 4, y + 22, 8, 6, '#8a1a1a'); c.fillStyle = '#7a1010'; c.textAlign = 'left'; c.textBaseline = 'middle'; c.fillText(falaTxt, x + 10, y + 12); }
      }
      for (const q of projs) projetil(c, q);
      for (const f of efeitos) { const k = f.t / .5;
        if (f.k === 'raio') { c.globalAlpha = 1 - k; R(c, f.x - 22, 0, 44, FLOOR, '#ffffff'); R(c, f.x - 10, 0, 20, FLOOR, '#c8d8ff'); c.globalAlpha = 1; }
        if (f.k === 'poeira') { c.globalAlpha = .6 * (1 - f.t / .6); for (let j = 0; j < 4; j++) R(c, f.x - 20 + j * 12 + Math.sin(j) * 4, f.y - 8 - f.t * 30, 10 + f.t * 12, 6 + f.t * 6, '#e8e0d0'); c.globalAlpha = 1; }
        if (f.k === 'flashP') { c.globalAlpha = Math.max(0, 1 - f.t / .4); c.fillStyle = '#ffffff'; c.beginPath(); c.arc(f.x, f.y, 26 + f.t * 120, 0, TAU); c.fill(); c.globalAlpha = 1; } }
      c.font = '14px Pixel, monospace'; c.textAlign = 'center';
      for (const x of textos) { c.globalAlpha = 1 - x.t; c.fillStyle = '#2a1a14'; c.fillText(x.s, x.x + 2, x.y - x.t * 40 + 2); c.fillStyle = x.cor; c.fillText(x.s, x.x, x.y - x.t * 40); } c.globalAlpha = 1; c.textAlign = 'left';
    }
    function desenharTela(c, W) { // barra do chefe e placas (na tela, sem câmera)
      if (arena.ativa && B.st !== 'espera' && B.st !== 'entrada') {
        const w = 420, x = W / 2 - w / 2, y = 30; R(c, x - 4, y - 4, w + 8, 34, '#1c1408'); R(c, x - 2, y - 2, w + 4, 30, '#4a3420');
        R(c, x, y + 14, w, 10, '#2a1a10'); R(c, x, y + 14, w * clamp(B.hp / B.max, 0, 1), 10, B.fase === 3 ? '#ff5a3a' : B.fase === 2 ? '#f0a03a' : '#e8433a'); R(c, x, y + 14, w * clamp(B.hp / B.max, 0, 1), 3, '#ffffff55');
        c.font = '10px Pixel, monospace'; c.fillStyle = '#ffe9a8'; c.textAlign = 'left'; c.textBaseline = 'top'; c.fillText(K.nome + '  ·  NV ' + K.nivel, x + 4, y + 1);
        for (let f = 1; f <= 3; f++) { R(c, x + w - 64 + f * 18, y + 1, 12, 10, f <= B.fase ? (f === B.fase ? '#ffd24a' : '#7a6a4a') : '#2a1a10'); }
      }
      for (const p of placas) { const k = p.t, a = Math.min(1, k / .2, (p.vida - k) / .3), sc = 1 + Math.max(0, .25 - k) * 2; c.save(); c.globalAlpha = a; c.translate(W / 2, 210); c.scale(sc, sc); c.fillStyle = 'rgba(12,8,6,.75)'; c.fillRect(-300, -46, 600, 92); c.fillStyle = p.cor; c.fillRect(-300, -46, 600, 4); c.fillRect(-300, 42, 600, 4); txt(c, p.titulo, 0, -30, p.cor, { s: 5, sombra: '#2a1006' }); txt(c, p.sub, 0, 14, '#f6ead0', { s: 2 }); c.restore(); }
    }
    function reiniciar() { // depois de desmaiar: o chefe volta ao começo, os inimigos vencidos continuam vencidos
      Object.assign(B, { x: K.x, hp: K.hp, max: K.hp, fase: 1, st: 'espera', tt: 0, golpe: null, padrao: 0, stun: 0, conf: 0, fim: false }); arena.ativa = false; projs.length = 0; efeitos.length = 0; placas.length = 0; vencido = false;
      for (let i = inimigos.length - 1; i >= 0; i--) if (inimigos[i].invocado) inimigos.splice(i, 1);
    }
    function comecarLuta() { B.st = 'idle'; B.tt = 1.2; P.x = arena.l + 70; placa(K.nome, 'NV ' + K.nivel + ' · ' + K.titulo, K.cor, 2.3); api.sfx('vs'); }
    return { slug, F, chefe: B, arena, inimigos: () => inimigos.concat(B.st !== 'espera' && B.st !== 'derrotado' && B.st !== 'entrada' ? [B] : []), update, desenhar, desenharTela, reiniciar, comecarLuta, vencida: () => vencido, emArena: () => arena.ativa };
  }

  window.CampanhaFases = Object.freeze({ FASES, criar, lista: () => Object.keys(FASES) });
})();
