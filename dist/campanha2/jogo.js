/* Campanha 2 · Passo 6A: o JOGO da Campanha 2 (Vitória da Conquista).
   Menu "CAMPANHA 2" na tela inicial (liberado depois de zerar a campanha principal: a ligação do Jorge).
   Um motor próprio, por cima da tela do jogo, que junta tudo o que foi feito nos passos 1 a 5:
   cenários, camadas, portas e escadas, moradores, táxi do Seu Zé, loja, mural dos poderes, os botões da
   campanha 1 (sem Reeis/Bivolt/Batata) e as cutscenes com balão de fala tocando dentro do jogo.
   Missões em sequência (objetivo no alto da tela e seta até o lugar), save próprio (daroca-c2-save),
   pausa com SALVAR E SAIR. O save da campanha 1 nunca é tocado.
   6A: o prólogo inteiro jogável, da ligação até a primeira manhã na pensão. */
(() => {
  'use strict';
  if (window.Campanha2 || !window.CampanhaCenarios || !window.Art) return;
  const W = 960, H = 540, FLOOR = 440, KEY = 'daroca-c2-save';
  const CC = () => window.CampanhaCenarios, RT = () => window.Roteiro, TR = () => window.CampanhaTreino;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const safe = (f, d) => { try { return f(); } catch (e) { return d; } };

  /* ---------- liberação e save ---------- */
  function liberada() { // a Campanha 2 só abre depois de terminar a Campanha 1 (no modo desenvolvedor fica aberta)
    if (/[?&]campanha2\b/.test(location.search) || window.DAROCA_DEV) return true;
    return safe(() => !!JSON.parse(localStorage.getItem('da-roca-adventure-v1') || 'null')?.q?.jorgeSeen, false) || safe(() => localStorage.getItem('daroca-sandbox-v1') === '1', false);
  }
  const novoSave = () => ({ v: 1, passo: 'abertura', cena: 0, x: 700, hp: 100, flags: {}, criado: Date.now(), salvo: 0 });
  let S = null;
  const temSave = () => !!safe(() => JSON.parse(localStorage.getItem(KEY) || 'null')?.passo, false);
  function carregar() { const d = safe(() => JSON.parse(localStorage.getItem(KEY) || 'null'), null); if (!d || typeof d !== 'object' || d.v !== 1 || !d.passo) return null;
    // save estragado não trava o jogo: flags sempre objeto, passo conhecido, cena que existe, posição e vida numéricas
    const flags = d.flags && typeof d.flags === 'object' && !Array.isArray(d.flags) ? { ...d.flags } : {}, S2 = { ...novoSave(), ...d, flags };
    if (!PASSOS[S2.passo] && !['bairro', 'fim6b', 'fim6c'].includes(S2.passo)) { const ordem = ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos', 'fred', 'jorge']; S2.passo = flags.zerou ? 'zerou' : ordem.find((v) => !flags['venceu_' + v]) || 'zerou'; if (!PASSOS[S2.passo]) S2.passo = 'creuza'; delete S2.cena; delete S2.x; }
    const cenaOk = Number.isInteger(S2.cena) && ((S2.cena >= 0 && S2.cena <= 11) || (window.CampanhaCenarios?.lista || []).some((q) => q.id === S2.cena)); if (!cenaOk) { delete S2.cena; delete S2.x; }
    if (S2.x !== undefined && !Number.isFinite(S2.x)) delete S2.x;
    S2.hp = Number.isFinite(Number(S2.hp)) && Number(S2.hp) > 0 ? Math.min(9999, Number(S2.hp)) : 100;
    return S2; }
  function salvar(msg) { if (!S) return; S.cena = cenaId; S.x = Math.round(P.x); S.hp = Math.round(P.hp); S.salvo = Date.now(); safe(() => localStorage.setItem(KEY, JSON.stringify(S))); if (msg) aviso(msg); }

  /* ---------- cenas (as da Campanha 2 e as de Itabuna, reaproveitadas no prólogo) ---------- */
  const NOMES_C1 = () => window.Campaign?.sceneNames || [];
  const EXTRA_PLAT = { 0: [[3280, 412, 50], [3330, 384, 50], [3380, 356, 50], [3430, 328, 54]] }; // fardos de feno até o passaporte
  function cenaDef(id) {
    if (id >= 12) return CC().lista.find((d) => d.id === id) || CC().lista[0];
    const w = Number(window.WorldData?.widths?.[id]) || 4800;
    return { id, nome: NOMES_C1()[id] || 'Itabuna', largura: w, vaos: [], plataformas: EXTRA_PLAT[id] || [], limites: [40, w - 40], itabuna: true };
  }

  /* ---------- MISSÕES (prólogo) ---------- */
  const PASSOS = {
    abertura: { roteiro: 'c2_abertura', depois: () => { irPara(0, 700); passo('passaporte'); } },
    passaporte: { obj: 'Pegue seu passaporte. Ele ficou em cima dos fardos de feno, perto de casa, no fim da roça.', cena: 0, alvo: 3456, hora: 6.6 },
    lucas: { obj: 'Despeça-se da turma (se quiser) e encontre o Lucas na trilha, no fim da roça.', cena: 0, alvo: 4560, hora: 7.2 },
    checkin: { obj: 'Faça o check-in no balcão. O Miguel te explica.', cena: 12, alvo: 640, hora: 9 },
    raiox: { obj: 'Passe pelo raio-X.', cena: 12, alvo: 1330, hora: 9.2 },
    portao: { obj: 'Vá até o portão de embarque.', cena: 12, alvo: 1760, hora: 9.4 },
    taxi1: { obj: 'Pegue o táxi do Seu Zé no ponto do desembarque.', cena: 12, alvo: 4000, hora: 7.4 },
    lurdes: { obj: 'Fale com a Dona Lurdes, na porta da pensão.', cena: 13, alvo: 1830, hora: 18.2 },
    creuza: { obj: 'Saia da pensão e siga pela rua do bairro. Dizem que uma vizinha anda espalhando coisas sobre você...', cena: 13, alvo: 3520, hora: 9.5, fase: 'creuza' },
    ir_tonhao: { obj: 'Pegue o táxi do Seu Zé (em frente à pensão) até o Monumento ao Índio. Dica: na Feira, o Seu Lindomar já vende a FOFOCA CONFUSA.', cena: 13, alvo: 1500, hora: 12, ir: 16, prox: 'tonhao' },
    tonhao: { obj: 'Atravesse a avenida. O Tonhão do Mototáxi espera depois da rotatória...', cena: 16, alvo: 5320, hora: 11, fase: 'tonhao' },
    ir_valdomiro: { obj: 'Volte ao ponto de táxi perto do Monumento e vá até a Feira do Planalto.', cena: 16, alvo: 2700, hora: 12, ir: 17, prox: 'valdomiro' },
    valdomiro: { obj: 'Atravesse a Feira do Planalto. O chefão dela não gosta de forasteiro...', cena: 17, alvo: 3560, hora: 9, fase: 'valdomiro' },
    ir_kaua: { obj: 'Pegue o táxi na entrada da Feira e vá até a Trilha do Cristo, na Serra do Periperi.', cena: 17, alvo: 400, hora: 15, ir: 15, prox: 'kaua' },
    kaua: { obj: 'Suba a Serra do Periperi até o Cristo. Cuidado com os buracos e com os urubus.', cena: 15, alvo: 4520, hora: 16.8, fase: 'kaua' },
    ir_barao: { obj: 'Volte ao ponto de táxi no pé da serra e vá até as Fazendas de Café. Dizem que o Barão quer a terra de todo mundo...', cena: 15, alvo: 300, hora: 17.5, ir: 18, prox: 'barao' },
    barao: { obj: 'Atravesse o cafezal. Pule os canais de irrigação e cuidado com os capangas do Barão.', cena: 18, alvo: 4600, hora: 8, fase: 'barao' },
    ir_breno: { obj: 'Pegue o táxi na porteira da fazenda e vá ao Teatro e Planetário. Hoje tem Festival de Inverno... e um valentão.', cena: 18, alvo: 300, hora: 12, ir: 19, prox: 'breno' },
    breno: { obj: 'Passe pelo Festival de Inverno. O Breno Pitbull espera depois do Planetário.', cena: 19, alvo: 3800, hora: 20.5, fase: 'breno' },
    ir_gemeos: { obj: 'Pegue o táxi na entrada do Teatro e vá até a frente do Shopping. Entre e encontre a LAN house.', cena: 19, alvo: 300, hora: 21, ir: 22, prox: 'gemeos' },
    gemeos: { obj: 'Entre no shopping e vá até a LAN house no fim do corredor. Os gêmeos não sabem perder.', cena: 20, alvo: 3560, hora: 19, fase: 'gemeos', via: { 22: 1360 } },
    ir_fred: { obj: 'Saia do shopping e pegue o táxi até a entrada da Escola SESI. Amanhã de manhã, o Jorge vai estar no pátio.', cena: 22, alvo: 1100, hora: 9.5, ir: 21, prox: 'fred', via: { 20: 90 } },
    fred: { obj: 'Entre na escola e suba a escada até o pátio do 2º andar. O Jorge está lá... e o Fred também.', cena: 27, alvo: 1560, hora: 10, fase: 'fred', via: { 21: 3940, 26: 1560 } },
    ir_centro: { obj: 'Hoje à noite o Jorge vai estar na praça da Catedral. Desça a escada, saia da escola e pegue o táxi até o Centro.', cena: 27, alvo: 58, hora: 18.5, via: { 26: 70, 21: 3700 }, ir: 14, prox: 'jorge' },
    jorge: { obj: 'Ande até a praça da Catedral. O Jorge está lá, com a turma nova.', cena: 14, alvo: 2640, hora: 21, fase: 'jorge' },
    zerou: { obj: 'Você zerou a Campanha 2! O trio voltou. Explore Conquista à vontade: táxi, feira, garrafadas e os moradores.', cena: 14, hora: 21.5 }
  };
  const APOS_VITORIA = { creuza: 'ir_tonhao', tonhao: 'ir_valdomiro', valdomiro: 'ir_kaua', kaua: 'ir_barao', barao: 'ir_breno', breno: 'ir_gemeos', gemeos: 'ir_fred', fred: 'ir_centro', jorge: 'zerou' };
  const PASSO_INICIAL_DA_CENA = { passaporte: 0, lucas: 0, checkin: 12, raiox: 12, portao: 12, taxi1: 12, lurdes: 13, creuza: 25, ir_tonhao: 13, tonhao: 16, ir_valdomiro: 16, valdomiro: 17, ir_kaua: 17, kaua: 15, ir_barao: 15, barao: 18, ir_breno: 18, breno: 19, ir_gemeos: 19, gemeos: 22, ir_fred: 20, fred: 21, ir_centro: 27, jorge: 14, zerou: 14 };
  function passo(id) { S.passo = id; const p = PASSOS[id]; if (p?.obj) objetivoNovo(p.obj); salvar(); }

  /* ---------- objetos e pessoas do prólogo (desenhados por cima do cenário) ---------- */
  const NPC = [
    { id: 'reeis', quem: 'reeis', cena: 0, x: 1020, quando: ['passaporte', 'lucas'], rotulo: 'FALAR COM O REEIS', falas: [['reeis', 'Vai mesmo, né? Atrás do Gordo.', 'sad'], ['daroca', 'Vou. Alguém tem que olhar na cara dele.'], ['reeis', 'Então olha por mim também. E traz biscoito de Conquista.', 'friend'], ['reeis', '...E traz ele de volta, tá? O trio é o trio. OOO REEEIS!', 'friend']] },
    { id: 'caleb', quem: 'caleb', cena: 0, x: 2080, quando: ['passaporte', 'lucas'], rotulo: 'FALAR COM O CALEB', falas: [['caleb', 'Ouvi dizer que em Conquista faz frio de verdade.'], ['caleb', 'Cuidado: músculo encolhe no frio. Faz flexão no avião.'], ['daroca', 'Isso nem é verdade, Caleb.'], ['caleb', 'Tudo é verdade se você acreditar com força.']] },
    { id: 'mota', quem: 'mota', cena: 0, x: 2640, quando: ['passaporte', 'lucas'], rotulo: 'FALAR COM O MOTA', falas: [['mota', 'Vai viajar sem me chamar? Que feio, Da Roça.'], ['mota', 'Pelo menos o dash você leva. Treinou comigo, então não tem desculpa.'], ['daroca', 'O dash vai comigo pra onde eu for.', 'friend']] },
    { id: 'kaua', quem: 'kaua', cena: 0, x: 3080, quando: ['passaporte', 'lucas'], rotulo: 'FALAR COM O KAUA', falas: [['kaua', 'Achei teu passaporte mais cedo. Botei em cima do feno pra galinha não comer.'], ['daroca', 'Em cima do FENO?!'], ['kaua', 'Ué. Galinha não pula. Você pula.']] },
    { id: 'lucas', quem: 'lucas', cena: 0, x: 4560, quando: ['lucas'], rotulo: 'PEDIR CARONA PRO LUCAS', fim: () => caronaLucas(), falas: [['lucas', 'Teu pai deixou eu te levar no carro a gás. Só até o aeroporto, hein!'], ['daroca', 'Ele deixou VOCÊ dirigir o carro dele?'], ['lucas', 'Deixou. Mais ou menos. Ele estava dormindo, mas eu acho que ele deixaria.'], ['daroca', '...Bora logo.']] },
    { id: 'miguel1', quem: 'miguel', cena: 12, x: 740, quando: ['checkin'], semFala: true },
    { id: 'miguel2', quem: 'miguel', cena: 12, x: 1420, quando: ['raiox'], semFala: true },
    { id: 'miguel3', quem: 'miguel', cena: 12, x: 1840, quando: ['portao'], semFala: true },
    { id: 'lurdes', quem: 'c2_lurdes', cena: 13, x: 1830, quando: ['lurdes'], rotulo: 'FALAR COM A DONA LURDES', fim: () => tocar('c2_primeira_noite', () => { irPara(25, 450); passo('creuza'); salvar('JOGO SALVO · A CAMA DO QUARTO 4 SALVA E CURA'); }), falas: null }
  ];
  const ESTACOES = [
    { id: 'checkin', cena: 12, x: 640, quando: 'checkin', rotulo: 'BALCÃO DE CHECK-IN', botao: 'CHECK-IN', acao: () => minijogo('checkin') },
    { id: 'raiox', cena: 12, x: 1330, quando: 'raiox', rotulo: 'RAIO-X', botao: 'RAIO-X', acao: () => minijogo('raiox') },
    { id: 'portao', cena: 12, x: 1760, quando: 'portao', rotulo: 'PORTÃO DE EMBARQUE', botao: 'EMBARCAR', acao: () => minijogo('portao') },
    { id: 'cama', cena: 25, x: 624, rotulo: 'DORMIR (SALVA E CURA)', botao: 'DORMIR', acao: () => { P.hp = P.max || 100; salvar('JOGO SALVO · VIDA CHEIA'); sfx('sino'); } }
  ];
  function caronaLucas() { // o carro a gás voando até o aeroporto de Itabuna
    const raw = { id: 'c2j_carona', titulo: 'A carona', balao: true, substituir: true, trilha: 'flashback', cenas: [
      { titulo: 'A CAMINHO DO AEROPORTO', cenario: 0, hora: 7.4, duracao: 4.6, camera: { de: { x: 4300, y: 420, zoom: 1.4 }, para: { x: 4600, y: 300, zoom: 1.2 }, tempo: 4.4 }, atores: [{ quem: 'carro', x: 4480, ate: 4800, tempo: [0.6, 4.4], anim: 'voando' }], efeitos: ['raios', { tipo: 'saida', t: 3.6, dur: 1 }], sons: [{ som: 'whoosh', t: .6 }] },
      { titulo: 'A CAMINHO DO AEROPORTO', fundo: 'preto', duracao: 2.4, efeitos: [{ tipo: 'cartao', texto: 'AEROPORTO DE ITABUNA', sub: 'ALGUNS MINUTOS DEPOIS', t: .2, dur: 2.1 }] }] };
    registrar(raw); tocar('c2j_carona', () => { irPara(12, 300); tocarParte('c2_aeroporto', 0, 3, () => passo('checkin')); });
  }

  /* ---------- minijogo do Miguel: check-in, raio-X e portão ---------- */
  function minijogo(etapa) {
    if (etapa === 'checkin') escolher('MIGUEL', 'O que você entrega no balcão do check-in?', [
      { t: 'O passaporte', ok: true, r: 'Isso! Agora pega o cartão de embarque e não perde.' },
      { t: 'A carteirinha do colégio', r: 'Da Roça... isso aí só abre a cantina.' },
      { t: 'O boleto do açaí', r: 'BOLETO?! Tu tá devendo açaí até pra companhia aérea?' }], () => { item('CARTÃO DE EMBARQUE'); passo('raiox'); });
    if (etapa === 'raiox') escolher('MIGUEL', 'O alarme do raio-X apitou. O que você tira?', [
      { t: 'O cinto', ok: true, r: 'Fivela de metal apita, Da Roça. Pode passar.' },
      { t: 'O chapéu de palha', r: 'Palha não apita... mas a fila inteira tá rindo do teu chapéu.' },
      { t: 'Prender o peido', r: 'O raio-X não pega isso. Graças a Deus.' }], () => { sfx('plim'); passo('portao'); });
    if (etapa === 'portao') tocarParte('c2_aeroporto', 3, 99, () => escolher('AVISO', 'Depois de embarcar, você não poderá voltar para Itabuna. Continuar?', [
      { t: 'EMBARCAR', ok: true }, { t: 'Ainda não', voltar: true }], () => { S.flags.embarcou = 1; salvar(); tocar('c2_voo', () => tocar('c2_chegada', () => { irPara(12, 3600); passo('taxi1'); })); }, true));
  }

  /* ---------- estado do jogo ---------- */
  const P = { x: 700, y: FLOOR, vx: 0, vy: 0, ground: true, facing: 1, attack: 0, hp: 100 };
  let aberto = false, cenaId = 0, cam = 0, t = 0, last = 0, raf = 0, keys = new Set(), viagem = null, fade = 0, perto = null, cut = null, pausado = false, som = true, joy = 0;
  let fpsMedio = 60;
  let box = null, cv = null, c = null, hud = null, objT = 0, avisos = [];
  const sfx = (n) => { try { window.Roteiro?.sfx?.(n); } catch (e) {} };
  const portais = (id) => safe(() => window.CampanhaAmbientes.portais(id), []) || [];
  const D = () => cenaDef(cenaId);

  /* ---------- FASES (6B): inimigos, chefe, arena, dano, desmaio e ponto de controle ---------- */
  let fase = null, tremor = 0, clarao = 0, claraoCor = '#ffffff', morto = false;
  const apiFase = {
    P, sfx: (n) => sfx(n), tremer: (n) => { tremor = Math.max(tremor, n); }, flash: (cor) => { clarao = .5; claraoCor = cor || '#ffffff'; },
    ferir: (n, de) => ferir(n, de),
    entrarArena: () => { const f = fase; S.flags.cp = { cena: cenaId, x: f.F.checkpoint }; salvar(); tocarDeslocado(f.F.intro, f.chefe.x, f.chefe.tipo, () => lutaC1(f)); },
    vencer: () => { const f = fase, slug = f.slug;
      if (f.F.final) { ganharXP(1200, 'c2-chefe-jorge'); tocarDeslocado(f.F.derrota, f.chefe.x, f.chefe.tipo, () => tocar('c2_creditos', () => { S.flags.venceu_jorge = 1; S.flags.zerou = 1; delete S.flags.cp; fase = null; passo('zerou'); salvar(); telaFim(); })); return; }
      ganharXP(600, 'c2-chefe-' + slug); tocarDeslocado(f.F.derrota, f.chefe.x, f.chefe.tipo, () => { window.CampanhaTaxi?.vencer?.(slug); S.flags['venceu_' + slug] = 1; delete S.flags.cp; fase = null; passo(APOS_VITORIA[slug]); salvar('JOGO SALVO'); }); }
  };
  function ferir(n, de) {
    if (morto || cut || (P.inv || 0) > 0 || viagem) return; n = Math.round(n * 1.5 * (window.Difficulty?.getSettings?.().incomingDamage || 1)); // o Da Roça chega mais forte da campanha 1; no DIFÍCIL os golpes tiram o dobro
    n = window.CampanhaPoderes?.filtrarDano?.(n) ?? n; if (!n) { sfx('plim'); return; }
    P.hp = Math.max(0, P.hp - n); P.inv = .85; P.vy = -280; P.ground = false; P.x += (P.x < de ? -1 : 1) * 36; tremor = Math.max(tremor, 7); sfx('impacto'); dano.push({ x: P.x, y: P.y - 80, s: '-' + n, t: 0 });
    if (P.hp <= 0) desmaiar();
  }
  const dano = [];
  function desmaiar() {
    morto = true; keys.clear(); const el = document.createElement('div'); el.className = 'pausa';
    el.innerHTML = '<h2>VOCÊ DESMAIOU...</h2><p>O frio de Conquista não perdoa. Respire fundo e tente de novo: você volta no último ponto de controle, com a vida cheia.</p><button type="button" data-a="de-novo">▶ TENTAR DE NOVO</button>';
    el.addEventListener('click', (e) => { if (e.target.closest('button')) { el.remove(); voltarDoDesmaio(); } }); box.querySelector('.tela').appendChild(el); setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  function telaFim() {
    keys.clear(); const el = document.createElement('div'); el.className = 'pausa';
    el.innerHTML = '<h2>CAMPANHA 2 COMPLETA!</h2><p>Da Roça foi até Vitória da Conquista de chinelo, enfrentou oito vilões e um ex-melhor amigo... e trouxe o trio de volta.<br><br>Obrigado por jogar!</p><button type="button" data-a="explorar">▶ CONTINUAR EXPLORANDO</button><button type="button" data-a="menu">VOLTAR AO MENU</button>';
    el.addEventListener('click', (e) => { const a = e.target.closest('button')?.dataset.a; if (!a) return; el.remove(); if (a === 'menu') fechar(); });
    box.querySelector('.tela').appendChild(el); sfx('fanfarra'); setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  function voltarDoDesmaio() { morto = false; P.hp = P.max || 100; P.inv = 1.5; fase?.reiniciar(); const cp = S.flags.cp; if (cp) irPara(cp.cena, cp.x); else irPara(cenaId, (PASSOS[S.passo]?.fase && fase ? fase.F.checkpoint - 400 : P.x)); salvar(); }
  function faseAtual() { // cria a fase quando você chega no lugar dela
    const slug = PASSOS[S?.passo]?.fase, F = slug && window.CampanhaFases?.FASES?.[slug];
    if (!F || F.cena !== cenaId || S.flags['venceu_' + slug]) { if (fase && (!F || F.cena !== cenaId)) fase = null; return null; }
    if (!fase || fase.slug !== slug) fase = window.CampanhaFases.criar(slug, apiFase);
    if (!S.flags.cp || S.flags.cp.cena !== cenaId) { if (P.x > F.checkpoint) { S.flags.cp = { cena: cenaId, x: F.checkpoint }; salvar(); aviso('PONTO DE CONTROLE'); } }
    return fase;
  }
  // a cutscene do vilão toca no lugar da luta: tudo é deslocado para onde o chefe está
  function tocarDeslocado(id, xChefe, tipo, depois) {
    const sc = RT()?.get?.(id); if (!sc?.raw) { depois?.(); return; } const raw = JSON.parse(JSON.stringify(sc.raw)); let ref = null;
    for (const c0 of raw.cenas) { if (c0.fundo) continue; const a = (c0.atores || []).find((q) => q.quem === tipo || (tipo === 'c2_ryan' && q.quem === 'c2_ryan')); if (a) { ref = a.x; break; } }
    const dx = ref === null ? 0 : Math.round(xChefe - ref);
    for (const c0 of raw.cenas) { if (c0.fundo) continue; if (c0.camera) for (const k of ['de', 'para']) if (c0.camera[k]) c0.camera[k].x += dx; for (const a of c0.atores || []) { a.x += dx; if (a.ate !== undefined) a.ate += dx; } }
    raw.id = id + '_jogo'; raw.substituir = true; registrar(raw); tocar(raw.id, depois);
  }

  /* ---------- cutscenes dentro do jogo ---------- */
  function registrar(raw) { safe(() => RT().register(raw, 'campanha2')); }
  function tocar(id, depois) { if (!RT()?.has?.(id)) { depois?.(); return; } keys.clear(); P.vx = 0; window.__somCutscene = som; const s = RT().create(id, {}); s.preview = true; cut = { s, depois, id }; hudVisivel(false); }
  function tocarParte(id, de, ate, depois) { const sc = RT()?.get?.(id); if (!sc?.raw) { depois?.(); return; } const raw = { ...sc.raw, id: id + '_p' + de, substituir: true, cenas: sc.raw.cenas.slice(de, ate) }; registrar(raw); tocar(raw.id, depois); }
  function avancarCut() { if (cut) RT().advance(cut.s); }
  function pularCut() { if (!cut) return; let n = 0; while (!cut.s.done && n++ < 999) RT().advance(cut.s); }
  function conversa(npc) { // conversa rápida com balão, no próprio cenário
    const fx = P.x < npc.x ? 1 : -1, meio = (P.x + npc.x) / 2;
    const raw = { id: 'c2j_conversa', titulo: 'Conversa', balao: true, substituir: true, cenas: [{ titulo: '', cenario: cenaId, hora: horaAtual(), camera: { de: { x: meio, y: 420, zoom: 1.7 }, para: { x: meio, y: 420, zoom: 1.85 }, tempo: 6 },
      atores: [{ quem: 'daroca', x: Math.round(P.x), olhando: fx }, { quem: npc.quem, x: npc.x, olhando: -fx }], falas: npc.falas.map(([q, txt, e]) => ({ quem: q, texto: txt, ...(e ? { emocao: e } : {}) })) }] };
    registrar(raw); tocar('c2j_conversa', () => { S.flags['falou_' + npc.id] = 1; npc.fim?.(); salvar(); });
  }

  /* ---------- ir de um lugar para outro ---------- */
  function irPara(id, x) { cenaId = id; const d = D(); P.x = clamp(x, d.limites?.[0] ?? 40, d.limites?.[1] ?? d.largura - 40); P.y = FLOOR; P.vy = 0; P.vx = 0; P.ground = true; P.seguroX = P.x; cam = clamp(P.x - 360, 0, Math.max(0, d.largura - W)); viagem = null; fade = 0; S && (S.cena = id); }
  const horaAtual = () => { const m = window.DayTime?.mode?.(); if (m && HORAS[m] != null) return HORAS[m]; const p = PASSOS[S?.passo]; if (cenaId === 25 || cenaId === 24) return S?.passo === 'lurdes' ? 21 : 8; return p?.hora ?? 12; };

  /* ---------- usar o que está perto ---------- */
  function usar() {
    if (viagem || !perto || cut || pausado) return; const p = perto; keys.clear();
    if (p.tipo === 'npc') { if (p.npc.falas) conversa(p.npc); else p.npc.fim?.(); return; }
    if (p.tipo === 'estacao') { p.est.acao(); return; }
    if (p.tipo === 'item' || p.tipo === 'aliado') { p.acao(); return; }
    if (p.tipo === 'extra') { if (p.id === 'loja') window.CampanhaLoja?.abrir?.({}); else window.CampanhaTaxi?.abrir?.(cenaId, (cena, x) => { irPara(cena, x + 120); if (S.passo === 'taxi1' && cena === 13) passo('lurdes'); else if (PASSOS[S.passo]?.ir === cena) passo(PASSOS[S.passo].prox); salvar(); }, { liberado: S.passo === 'taxi1' ? (L) => (L.id === 't13' ? { ok: true } : { ok: false, motivo: 'Primeiro, a pensão. Você nem tem onde dormir!' }) : undefined }); return; }
    if (p.tipo === 'poderes') { window.CampanhaPoderes?.abrirMural?.({}); return; }
    if (p.tipo === 'conversa') { window.CampanhaMoradores?.conversar?.(p.id); return; }
    if (p.tipo === 'armario') { window.DarocaLook?.open?.({ title: 'ARMÁRIO DO QUARTO 4', line: 'Escolha a roupa do Da Roça para hoje.' }); return; }
    if (p.tipo === 'pc') { window.Fliperama?.open?.(null, { from: 'quarto' }); return; }
    if (p.tipo === 'rolante') { viagem = { tipo: 'rolante', t: 0, dur: 2.2, de: [P.x, P.y], ini: p.de, fim: p.ate, para: p.para }; return; }
    viagem = { tipo: 'porta', t: 0, para: p.para };
  }
  function procurarPerto() {
    perto = null; if (viagem || !P.ground) return; let best = 1e9; const d = D(), cand = [];
    for (const p of portais(d.id)) if (p.tipo !== 'rampa') cand.push(p);
    for (const n of NPC) if (n.cena === d.id && n.quando.includes(S.passo) && !n.semFala) cand.push({ tipo: 'npc', npc: n, x: n.x, rotulo: n.rotulo + (S.flags['falou_' + n.id] && n.id !== 'lucas' && n.id !== 'lurdes' ? ' ✓' : ''), botao: 'FALAR' });
    for (const e of ESTACOES) if (e.cena === d.id && (!e.quando || e.quando === S.passo)) cand.push({ tipo: 'estacao', est: e, x: e.x, rotulo: e.rotulo, botao: e.botao });
    if (d.id === 0 && S.passo === 'passaporte' && P.y < FLOOR - 100) cand.push({ tipo: 'item', x: 3456, rotulo: 'PEGAR O PASSAPORTE', botao: 'PEGAR', acao: () => { item('PASSAPORTE'); sfx('fanfarra'); passo('lucas'); } });
    if (d.id >= 12) { const m = window.CampanhaMoradores?.perto?.(d.id, P.x); if (m) cand.push({ tipo: 'conversa', id: m.id, x: m.x, rotulo: 'CONVERSAR COM ' + m.nome.toUpperCase(), botao: 'FALAR' });
      for (const X of [window.CampanhaTaxi, window.CampanhaLoja]) { const e = X?.perto?.(d.id, P.x); if (e) cand.push({ tipo: 'extra', ...e }); } }
    for (const a of window.CampanhaAliados?.candidatos?.(d.id) || []) cand.push(a);
    for (const p of cand) { const dd = Math.abs(p.x - P.x); if (dd < 70 && dd < best) { best = dd; perto = p; } }
  }

  /* ---------- física (a mesma do visualizador) ---------- */
  function fisica(dt) {
    const d = D(), dir = (keys.has('right') ? 1 : 0) - (keys.has('left') ? 1 : 0) || Math.sign(Math.round(joy * 2)); if (dir) P.facing = dir;
    // andar, pular e cair com os MESMOS números da campanha 1 (game.js): velocidade 280 com aceleração, gravidade 850
    if (!TR()?.dashing?.()) { const alvo = dir * (TR()?.bonus?.().moveSpeed || 280) * (TR()?.velocidade?.() || 1) * ((P.atordoado || 0) > 0 ? .4 : 1) * (window.CampanhaAliados?.velocidade?.() || 1), ac = dir ? (P.ground ? 1800 : 1150) : (P.ground ? 2200 : 950);
      P.vx += clamp(alvo - P.vx, -ac * dt, ac * dt); if (Math.abs(P.vx) < .1) P.vx = 0; }
    P.anim = (P.anim || 0) + Math.abs(P.vx) * dt / 18.3; const lim = d.limites || [40, d.largura - 40]; P.x = clamp(P.x + P.vx * dt, lim[0], lim[1]);
    const prevY = P.y, chao0 = P.ground; P.vy = Math.min(900, P.vy + 850 * dt); P.y += P.vy * dt; P.ground = false; if (P.y < 95) { P.y = 95; P.vy = Math.max(0, P.vy); }
    if (P.y > FLOOR + 2) for (const [gx, gw] of d.vaos || []) if (P.x > gx && P.x < gx + gw) { P.x = clamp(P.x, gx + 11, gx + gw - 11); if (Math.abs(P.vx) > 0 && (P.x === gx + 11 || P.x === gx + gw - 11)) P.vx = 0; } // dentro do vão as paredes seguram
    const overGap = (d.vaos || []).some(([gx, gw]) => P.x > gx + 10 && P.x < gx + gw - 10);
    for (const r of portais(d.id)) if (r.tipo === 'rampa' && P.x >= r.x0 && P.x <= r.x1) { const ry = r.y0 + (r.y1 - r.y0) * (P.x - r.x0) / (r.x1 - r.x0); if (P.vy >= 0 && P.y >= ry - 14 && prevY <= ry + 40) { P.y = ry; P.vy = 0; P.ground = true; } if (P.x >= r.x1 - 4 && P.ground && dir > 0) viagem = { tipo: 'porta', t: 0, para: r.para }; }
    if (P.vy >= 0 && !P.ground) { for (const [px, py, pw] of d.plataformas || []) if (P.x > px - 6 && P.x < px + pw + 6 && prevY <= py + 2 && P.y >= py) { P.y = py; P.vy = 0; P.ground = true; } if (!P.ground && !overGap && P.y >= FLOOR) { P.y = FLOOR; P.vy = 0; P.ground = true; } }
    if (!chao0 && P.ground) P.landTimer = .15; P.landTimer = Math.max(0, (P.landTimer || 0) - dt);
    if (P.ground && !overGap && P.y >= FLOOR - 1) P.seguroX = P.x; // último chão firme
    if (P.y > 600) { // caiu no vão: volta para a beirada do lado de onde veio, em pé no chão
      const g = (d.vaos || []).find(([gx, gw]) => P.x > gx - 20 && P.x < gx + gw + 20), sx = P.seguroX ?? P.x - 260;
      P.x = g ? (sx <= g[0] + g[1] / 2 ? g[0] - 40 : g[0] + g[1] + 40) : sx; P.x = clamp(P.x, lim[0], lim[1]);
      P.y = FLOOR; P.vy = 0; P.vx = 0; P.ground = true; P.inv = Math.max(P.inv || 0, 1); P.hp = Math.max(1, P.hp - 10); aviso('Ai! Cuidado com o buraco.'); }
  }
  function andarViagem(dt) {
    const v = viagem; v.t += dt;
    if (v.tipo === 'rolante') { const u = Math.min(1, v.t / v.dur), k = u < .15 ? 0 : (u - .15) / .85; P.x = (k <= 0 ? v.de[0] + (v.ini[0] - v.de[0]) * (u / .15) : v.ini[0] + (v.fim[0] - v.ini[0]) * k); P.y = k <= 0 ? FLOOR : v.ini[1] + (v.fim[1] - v.ini[1]) * k; P.facing = v.fim[0] > v.ini[0] ? 1 : -1; P.vx = 0; P.ground = true; fade = Math.max(0, (u - .78) / .22); if (u >= 1) { irPara(v.para.cena, v.para.x); viagem = { tipo: 'chegada', t: 0 }; } return; }
    if (v.tipo === 'porta') { fade = Math.min(1, v.t / .35); P.vx = 0; if (v.t >= .35) { irPara(v.para.cena, v.para.x); viagem = { tipo: 'chegada', t: 0 }; salvar(); } return; }
    if (v.tipo === 'chegada') { fade = Math.max(0, 1 - v.t / .35); if (v.t >= .35) { viagem = null; fade = 0; } }
  }
  function pular() { if (P.ground && !viagem && !cut) { P.vy = -365; P.ground = false; TR()?.som?.(320, .06, 'triangle'); } } // pulo da campanha 1

  /* ---------- desenho do mundo ---------- */
  function fardo(x, top, n) { for (let k = 0; k < n; k++) { const y = FLOOR - (k + 1) * 28; c.fillStyle = '#3a2a14'; c.fillRect(x - 1, y - 1, 52, 30); c.fillStyle = '#d8b04a'; c.fillRect(x, y, 50, 28); c.fillStyle = '#e8c86a'; c.fillRect(x, y, 50, 4); for (let j = 4; j < 50; j += 6) { c.fillStyle = '#b8902a'; c.fillRect(x + j, y + 6, 2, 20); } c.fillStyle = '#7a4a2a'; c.fillRect(x + 14, y, 3, 28); c.fillRect(x + 33, y, 3, 28); } }
  function desenharExtras() {
    const d = D();
    if (d.id === 0) { // fardos de feno e o passaporte brilhando lá em cima
      fardo(3280, 412, 1); fardo(3330, 384, 2); fardo(3380, 356, 3); fardo(3430, 328, 4);
      if (S.passo === 'passaporte') { const b = Math.sin(t * 3) * 3, x = 3448, y = 290 + b; c.fillStyle = '#2a1a3a'; c.fillRect(x - 1, y - 1, 18, 24); c.fillStyle = '#3c3a8a'; c.fillRect(x, y, 16, 22); c.fillStyle = '#e8c24c'; c.fillRect(x + 4, y + 6, 8, 8); c.fillRect(x + 3, y + 16, 10, 2);
        for (let k = 0; k < 4; k++) if (Math.sin(t * 5 + k * 1.7) > .4) { const sx = x + 8 + Math.cos(k * 1.6 + t) * 20, sy = y + 10 + Math.sin(k * 2 + t) * 16; c.fillStyle = '#fff3a8'; c.fillRect(sx, sy - 3, 2, 8); c.fillRect(sx - 3, sy, 8, 2); } }
      if (S.passo === 'lucas') { c.save(); c.translate(4640, 0); c.scale(-1, 1); safe(() => window.Art.drawVehicle(c, 0, FLOOR, t)); c.restore(); }
    }
    for (const n of NPC) if (n.cena === d.id && n.quando.includes(S.passo)) safe(() => window.Art.drawCharacter(c, n.quem, n.x, FLOOR, { frame: t, facing: P.x < n.x ? -1 : 1, grounded: true, cache: true }));
    if (d.id === 12 && ['checkin', 'raiox', 'portao'].includes(S.passo)) { const e = ESTACOES.find((q) => q.quando === S.passo); if (e) { const y = FLOOR - 128 + Math.sin(t * 4) * 4; c.fillStyle = '#ffd24a'; c.beginPath(); c.moveTo(e.x - 10, y - 12); c.lineTo(e.x + 10, y - 12); c.lineTo(e.x, y); c.fill(); } }
  }
  function setaObjetivo() {
    const p = PASSOS[S.passo]; if (!p || cut) return; const alvo = p.cena === cenaId ? p.alvo : p.via?.[cenaId]; if (alvo === undefined) return;
    const sx = alvo - cam, b = Math.sin(t * 5) * 5;
    if (sx > 30 && sx < W - 30) { const y = FLOOR - 170 + b; c.fillStyle = '#2a1a10'; c.beginPath(); c.moveTo(sx - 14, y - 18); c.lineTo(sx + 14, y - 18); c.lineTo(sx, y + 2); c.fill(); c.fillStyle = '#ffd24a'; c.beginPath(); c.moveTo(sx - 10, y - 15); c.lineTo(sx + 10, y - 15); c.lineTo(sx, y - 2); c.fill(); }
    else { const dir = sx < 0 ? -1 : 1, x = dir < 0 ? 24 : W - 24, y = 300; c.fillStyle = '#2a1a10'; c.beginPath(); c.moveTo(x + dir * (8 + b), y); c.lineTo(x - dir * (14 - b), y - 16); c.lineTo(x - dir * (14 - b), y + 16); c.fill(); c.fillStyle = '#ffd24a'; c.beginPath(); c.moveTo(x + dir * (5 + b), y); c.lineTo(x - dir * (10 - b), y - 11); c.lineTo(x - dir * (10 - b), y + 11); c.fill(); }
  }

  /* ---------- HUD, avisos, escolhas, pausa ---------- */
  function css() {
    if (document.getElementById('c2jCss')) return;
    { let txt = ''; for (const sh of document.styleSheets) { let rules; try { rules = sh.cssRules; } catch (e) { continue; } for (const r of rules || []) { const sel = r.selectorText; if (!sel || !/move-joystick|joystick-knob|joystick-directions/.test(sel) || /arena|\.is-|immersive|engaged-off/.test(sel)) continue;
        txt += r.cssText.replace(sel, sel.split(',').map((x) => '.c2j ' + x.replace(/#gameShell\s*|\.crafted-controls\s*|\.touch-controls\s*|\.game-shell\s*/g, '').trim()).join(',')) + '\n'; } }
      const sj = document.createElement('style'); sj.id = 'c2jJoyCss'; sj.textContent = txt + '.c2j .move-joystick{width:102px;height:102px}'; document.head.appendChild(sj); }
    const st = document.createElement('style'); st.id = 'c2jCss';
    st.textContent = `.c2j{position:fixed;inset:0;z-index:100000;background:#06080c;display:flex;align-items:center;justify-content:center;font-family:Pixel,monospace;color:#f6ead0;touch-action:none;user-select:none;-webkit-user-select:none}#c2Painel{display:block;overflow-y:auto;touch-action:pan-y;-webkit-overflow-scrolling:touch}#c2Painel .pausa{min-height:100%;box-sizing:border-box;padding:14px 0}@media (max-height:440px){#c2Painel .pausa{gap:6px!important;padding:8px 0}#c2Painel .pausa h2{margin:2px 0}#c2Painel .pausa p{margin:0 0 2px}}.c2j[hidden]{display:none}
.c2j .tela{position:relative;width:min(100vw,177.78vh);aspect-ratio:16/9;max-height:100vh}.c2j canvas.mundo{width:100%;height:100%;display:block;image-rendering:pixelated}
.c2j .hud{position:absolute;inset:0;pointer-events:none}.c2j .hud>*{pointer-events:auto}
.c2j .vida{position:absolute;left:1.6%;top:2.4%;display:flex;flex-direction:column;gap:4px;background:#2a1e14e6;border:3px solid #8a6a3a;box-shadow:0 0 0 2px #120c08;padding:6px 8px}
.c2j .vida .cor{display:flex;gap:3px}.c2j .vida .cor i{width:14px;height:12px;background:#5a2a24;clip-path:polygon(0 25%,25% 0,50% 25%,75% 0,100% 25%,100% 50%,50% 100%,0 50%)}.c2j .vida .cor i.on{background:#e8433a}.c2j .vida .cor i.meio{background:linear-gradient(90deg,#e8433a 50%,#5a2a24 50%)}
.c2j .vida .gas{height:6px;width:96px;background:#1c1408;border:1px solid #6a5a3a}.c2j .vida .gas b{display:block;height:100%;background:linear-gradient(#9ae06a,#4a9a3a)}.c2j .vida .moedas{font-size:9px;color:#ffd24a}.c2j .vida .papeis{font-size:9px;color:#fff1bf}.c2j.c1-topo .hud .vida,.c2j.c1-topo .hud .menu{display:none!important}.c2j.c1-topo .obj{top:clamp(54px,13%,80px)!important}#c2GameShell .game-topbar{pointer-events:auto}#c2GameShell #travelBtn{display:none!important}.c2j.preencher{display:block}.c2j.preencher .tela{position:absolute;left:0;top:0;width:100vw;height:56.25vw;max-height:none;aspect-ratio:auto;top:var(--c2-pan,0px)}.c2j.preencher .tela>.hud,.c2j.preencher .tela>.pular,.c2j.preencher .tela>.pausa,.c2j.preencher .tela>.escolha,.c2j.preencher .tela>.c2-editor{position:fixed}
.c2j .obj{position:absolute;left:50%;top:2.4%;transform:translateX(-50%);max-width:52%;background:#f2dc9ae8;color:#3a2412;border:3px solid #2a1a10;padding:6px 10px;font:clamp(9px,1.25vw,13px) Space,Arial,sans-serif;line-height:1.35;box-shadow:3px 4px 0 #0006}
.c2j .obj b{display:block;font:clamp(7px,.8vw,9px) Pixel,monospace;color:#8a4a2a;margin-bottom:2px}.c2j .obj.novo{animation:c2jObj .8s cubic-bezier(.2,1.6,.4,1)}@keyframes c2jObj{from{transform:translateX(-50%) scale(.6);opacity:0}}
.c2j .menu{position:absolute;right:1.6%;top:2.4%;width:42px;height:42px;font:16px Pixel,monospace;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}
.c2j .entrar{position:absolute;right:3%;bottom:30%;font:12px Pixel,monospace;padding:12px 16px;background:#e8a83a;color:#1c1408;border:3px solid #fff2c8;border-radius:6px;cursor:pointer;box-shadow:0 4px 0 #8a5a1a}
.c2j .avisos{position:absolute;left:50%;top:18%;transform:translateX(-50%);display:flex;flex-direction:column;gap:6px;align-items:center;pointer-events:none}.c2j .avisos div{background:#1c1408e8;border:2px solid #e8c66a;padding:8px 14px;font-size:10px;color:#ffe9a8;animation:c2jObj .5s}
.c2j .item{position:absolute;left:50%;top:40%;transform:translate(-50%,-50%);background:#2a1e14f2;border:4px solid #ffd24a;box-shadow:0 0 0 4px #120c08,0 0 40px #ffd24a66;padding:16px 26px;text-align:center;animation:c2jObj .6s}.c2j .item small{display:block;font-size:9px;color:#c8b48a;margin-bottom:6px}.c2j .item b{font-size:16px;color:#ffd24a}
.c2j .escolha{position:absolute;inset:0;background:#0008;display:flex;align-items:flex-end;justify-content:center;padding-bottom:6%}.c2j .escolha .cx{background:#fff6dc;color:#3a2412;border:4px solid #2a1a10;box-shadow:4px 6px 0 #0008;padding:14px 16px;width:min(560px,86%);font:14px Space,Arial,sans-serif;line-height:1.4}
.c2j .escolha .cx b{display:inline-block;font:9px Pixel,monospace;background:#2c6ab8;color:#fff;padding:3px 7px;margin-bottom:8px}.c2j .escolha .ops{display:flex;flex-direction:column;gap:6px;margin-top:10px}.c2j .escolha button{font:12px Space,Arial,sans-serif;text-align:left;padding:9px 12px;background:#f2dc9a;color:#3a2412;border:3px solid #2a1a10;cursor:pointer}.c2j .escolha button:hover,.c2j .escolha button:focus-visible{background:#ffd24a;outline:none}.c2j .escolha .resp{margin-top:8px;color:#a8341a;min-height:1.4em}
.c2j .pausa{position:absolute;inset:0;background:#06080cd8;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px}.c2j .pausa h2{font-size:20px;color:#ffd98a;margin:0 0 6px}.c2j .pausa button{font:12px Pixel,monospace;min-width:240px;padding:12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}.c2j .pausa button:hover,.c2j .pausa button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.c2j .pausa p{font-size:9px;color:#c8b48a;max-width:420px;text-align:center;line-height:1.7}
.c2j .pular{position:absolute;right:1.6%;bottom:4%;font:10px Pixel,monospace;padding:8px 12px;background:#1c1408cc;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}
.c2j .joy{position:absolute!important;left:3%;bottom:5%;touch-action:none}
@media (pointer:fine){.c2j .joy{display:none}}
.c2j .c2-treino-ctl{gap:6px!important}.c2j .c2-treino-ctl .touch-btn{width:clamp(40px,6.2vw,60px)!important;height:clamp(40px,6.2vw,60px)!important;min-width:0!important;min-height:0!important;padding:0!important}.c2j .c2-treino-ctl .touch-btn svg{width:46%!important;height:46%!important}.c2j .c2-treino-ctl .touch-btn small{font-size:clamp(5px,.75vw,8px)!important}
.c2j .entrar{bottom:auto;top:24%;right:3%}`;
    document.head.appendChild(st);
  }
  function montar() {
    css(); box = document.createElement('div'); box.className = 'c2j'; box.hidden = true;
    box.innerHTML = `<div class="tela"><canvas class="mundo" width="960" height="540"></canvas><div class="hud"><div class="vida"><div class="cor"></div><div class="gas"><b></b></div><div class="moedas"></div><div class="papeis"></div></div><div class="obj"><b>OBJETIVO</b><span></span></div><button type="button" class="menu" aria-label="Pausa">☰</button><button type="button" class="entrar" hidden></button><div class="joy move-joystick"><span class="joystick-directions" aria-hidden="true"></span><span class="joystick-knob" aria-hidden="true"><i></i></span></div></div><div class="avisos"></div><button type="button" class="pular" hidden>PULAR CENA ▶▶</button></div>`;
    document.body.appendChild(box); box.addEventListener('click', interceptarTopo, true); box.addEventListener('pointerdown', interceptarTopo, true); cv = box.querySelector('canvas.mundo'); c = cv.getContext('2d', { alpha: false }); c.imageSmoothingEnabled = false; hud = box.querySelector('.hud');
    box.querySelector('.menu').addEventListener('click', () => pausar(true)); box.querySelector('.entrar').addEventListener('click', usar);
    box.querySelector('.pular').addEventListener('click', (e) => { e.stopPropagation(); pularCut(); });
    cv.addEventListener('pointerdown', () => { if (cut) avancarCut(); });
    // joystick (celular): mesmo jeito do da campanha 1
    { const pad = box.querySelector('.joy'), orig = document.querySelector('#moveJoystick .joystick-directions'); if (orig) pad.querySelector('.joystick-directions').innerHTML = orig.innerHTML; ligarJoy(pad); } // reserva, se a principal não tiver os controles
    TR()?.montarBarra?.(box.querySelector('.tela'), acionarBotao);
    addEventListener('keydown', teclaDown, true); addEventListener('keyup', teclaUp, true);
  }
  // joystick: mesmo jeito do da campanha 1 (só o eixo de andar)
  function ligarJoy(pad) {
    if (!pad || pad.dataset.c2Ligado) return; pad.dataset.c2Ligado = '1'; const knob = pad.querySelector('.joystick-knob'); let pid = null;
    const mover = (e) => { if (e.pointerId !== pid) return; const r = pad.getBoundingClientRect(); let x = (e.clientX - (r.left + r.width / 2)) / (r.width * .34); x = clamp(x, -1, 1); joy = Math.abs(x) > .25 ? x : 0; if (knob) knob.style.transform = `translateX(${x * r.width * .34}px)`; };
    pad.addEventListener('pointerdown', (e) => { pid = e.pointerId; pad.classList.add('engaged', 'active'); try { pad.setPointerCapture(pid); } catch (er) {} mover(e); e.preventDefault(); });
    pad.addEventListener('pointermove', mover); const solta = (e) => { if (e.pointerId !== pid) return; pid = null; joy = 0; if (knob) knob.style.transform = ''; pad.classList.remove('engaged', 'active'); }; pad.addEventListener('pointerup', solta); pad.addEventListener('pointercancel', solta);
  }
  function acionarBotao(id, down) { if (cut) { if (down) avancarCut(); return; } if (pausado) return; if (TR().acao(id, down, P)) return; if (id === 'jump') { if (down) { keys.add('jump'); pular(); } else keys.delete('jump'); } if (id === 'interact' && down) usar(); }
  /* ---------- botões: CÓPIA LITERAL dos controles da campanha 1 (joystick, botões, posições e estilo),
     sem REEEIS, BIVOLT, CARRO A GÁS e BATATA; no lugar ficam PODER 1 e PODER 2 (como a principal já faz no modo c2-controles). ---------- */
  const FORA = /^(in-main-menu|is-paused|is-cutscene|is-dialog|is-chapter-ended|is-routing|is-training|is-activity|is-epilogue|is-ollyan-flight|campaign-layout-editing|is-room|is-arena|is-boss)$/;
  let cssC1 = false;
  function copiarCssC1() {
    if (cssC1) return; cssC1 = true; const rel = /touch|joystick|crafted|-btn|c2-poder|c2-controles|campaign-layout|topbar|hud-|player-info|gas-|ammo|paper-icon|inventory|weapon|location|pin-icon|game-actions|icon-button|fullscreen|progress|xp-|stats|hearts|miniPortrait|campaign-chapter|statsBtn|levelValue|pointsValue/; // controles, barra de cima e painéis DADOS/INVENTÁRIO
    const conv = (r) => { if (r.selectorText !== undefined) return r.selectorText.includes('#gameShell') && rel.test(r.selectorText) ? r.cssText.replace(/#gameShell/g, '#c2GameShell') + '\n' : '';
      if (r.cssRules && r.media) { let i = ''; for (const q of r.cssRules) i += conv(q); return i ? `@media ${r.media.mediaText}{${i}}\n` : ''; }
      if (r.cssRules && r.conditionText !== undefined) { let i = ''; for (const q of r.cssRules) i += conv(q); return i ? `@supports ${r.conditionText}{${i}}\n` : ''; } return ''; };
    let txt = ''; for (const sh of document.styleSheets) { let rules; try { rules = sh.cssRules; } catch (e) { continue; } for (const r of rules || []) { try { txt += conv(r); } catch (e) {} } }
    txt += `.c2j>#c2GameShell.c2-c1-shell.game-shell{position:fixed!important;inset:0!important;width:auto!important;height:auto!important;min-height:0!important;max-width:none!important;max-height:none!important;margin:0!important;padding:0!important;border:0!important;background:none!important;box-shadow:none!important;outline:0!important;overflow:visible!important;pointer-events:none!important;z-index:4!important;transform:none!important;filter:none!important}
.c2j>.c2-c1-shell .touch-controls{pointer-events:auto}.c2j.c1-botoes .c2-treino-ctl,.c2j.c1-botoes .joy{display:none!important}.c2j.c2-editando-c1 .c2-c1-shell .touch-controls{pointer-events:auto}`;
    const st = document.createElement('style'); st.id = 'c2C1BotoesCss'; st.textContent = txt; document.head.appendChild(st);
  }
  function controlesC1() {
    const tela = box.querySelector('.tela'); devolverTopo(); box.querySelector('.c2-c1-shell')?.remove(); box.classList.remove('c1-botoes');
    const shell = document.getElementById('gameShell'), orig = shell?.querySelector('.touch-controls'); if (!orig) return false;
    copiarCssC1();
    const w = document.createElement('div'); w.className = [...shell.classList].filter((k) => !FORA.test(k)).join(' ') + ' game-shell c2-c1-shell c2-controles campaign-layout-ready campaign-layout-playable'; w.id = 'c2GameShell'; const est = shell.getAttribute('style'); if (est) w.setAttribute('style', est);
    const cl = orig.cloneNode(true);
    // PODER 1 fica onde era o CARRO A GÁS e PODER 2 onde era o BIVOLT (mesma posição e tamanho do layout da principal)
    for (const [de, para] of [['vehicle', 'poder1'], ['bivolt', 'poder2']]) { const o = cl.querySelector(`[data-action="${de}"]`), p = cl.querySelector(`[data-action="${para}"]`); if (!o || !p) continue;
      p.setAttribute('style', o.getAttribute('style') || ''); p.classList.add('campaign-layout-target'); if (o.dataset.campaignLayout) p.dataset.campaignLayout = o.dataset.campaignLayout; o.parentNode.insertBefore(p, o); }
    cl.querySelectorAll('[data-action="reeis"],[data-action="vehicle"],[data-action="taunt"],[data-action="train"],[data-action="activity"],[data-action="bivolt"]').forEach((e) => e.remove());
    cl.querySelectorAll('[id]').forEach((e) => { e.dataset.c1Id = e.id; e.removeAttribute('id'); }); cl.querySelectorAll('.pressed,.engaged,.active').forEach((e) => e.classList.remove('pressed', 'engaged', 'active'));
    w.appendChild(cl); box.appendChild(w); box.classList.add('c1-botoes'); // na tela inteira, como a principal
    for (const b of cl.querySelectorAll('[data-action]')) { const id = b.dataset.action; b.dataset.acao = id;
      const down = (e) => { e.preventDefault(); b.classList.add('pressed'); acionarBotao(id, true); }, up = () => { if (!b.classList.contains('pressed')) return; b.classList.remove('pressed'); acionarBotao(id, false); };
      b.addEventListener('pointerdown', down); b.addEventListener('pointerup', up); b.addEventListener('pointerleave', up); b.addEventListener('pointercancel', up); b.addEventListener('contextmenu', (e) => e.preventDefault()); }
    ligarJoy(cl.querySelector('.move-joystick')); copiarPoderes(true); levarTopo(w);
    safe(() => window.CampanhaBotoes?.aplicar?.(tela)); return true;
  }
  function interceptarTopo(e) { if (!topo || !topo.el.contains(e.target)) return; const b = e.target.closest('#pauseBtn'); if (b) { e.preventDefault(); e.stopImmediatePropagation(); if (e.type === 'click') pausar(!pausado); } }
  let ultPoder = 0;
  function copiarPoderes(ja) { // os botões de poder da principal (atualizados pelo poderes.js) → a cópia
    const agora = performance.now(); if (!ja && agora - ultPoder < 150) return; ultPoder = agora; const w = box?.querySelector('.c2-c1-shell'); if (!w) return;
    for (const i of [1, 2]) { const o = document.getElementById('c2Poder' + i), k = w.querySelector(`[data-action="poder${i}"]`); if (!o || !k) continue; if (k.dataset.html !== o.innerHTML) { k.innerHTML = o.innerHTML; k.dataset.html = o.innerHTML; } k.classList.toggle('vazio', o.classList.contains('vazio')); }
    const dv = w.querySelector('[data-c1-id="dashValue"]'); if (dv) { const f = TR()?.dashFalta?.() || 0; const txt = f > .05 ? f.toFixed(1).replace('.', ',') + 's' : 'PRONTO'; if (dv.textContent !== txt) dv.textContent = txt; }
  }
  addEventListener('resize', () => { if (aberto && box) { clearTimeout(window.__c2RecC1); window.__c2RecC1 = setTimeout(() => safe(controlesC1), 250); } });
  const coberto = () => !!(window.CampanhaOficina?.aberta?.() || window.Fliperama?.isOpen?.() || window.DarocaLook?.isOpen?.() || window.CampanhaPoderes?.muralAberto?.() || window.Mapa3D?.aberto?.() || window.CampanhaLoja?.aberta?.());
  const ocupado = () => coberto() || !!window.CampanhaMoradores?.aberto?.() || !!box?.querySelector('.escolha');
  function teclaDown(e) {
    if (!aberto || coberto() || window.CampanhaMoradores?.aberto?.() || window.CampanhaAliados?.ocupado?.()) return; const k = e.code;
    if (box.querySelector('.escolha')) { if (/^Digit[1-3]$/.test(k)) box.querySelectorAll('.escolha .ops button')[Number(k.slice(5)) - 1]?.click(); e.stopImmediatePropagation(); return; }
    if (cut) { if (['Space', 'Enter', 'KeyE', 'ArrowRight'].includes(k) && !e.repeat) avancarCut(); if (k === 'Escape') pularCut(); e.preventDefault(); e.stopImmediatePropagation(); return; }
    if (morto) { e.stopImmediatePropagation(); return; }
    if (k === 'Escape') { pausar(!pausado); e.preventDefault(); e.stopImmediatePropagation(); return; }
    if (pausado) { e.stopImmediatePropagation(); return; }
    if (k === 'ArrowLeft' || k === 'KeyA') keys.add('left'); if (k === 'ArrowRight' || k === 'KeyD') keys.add('right');
    const mapa = { KeyJ: 'paper', KeyK: 'fart', KeyL: 'dash', ShiftLeft: 'dash', ShiftRight: 'dash', KeyU: 'poder1', KeyI: 'poder2' };
    if (mapa[k] && !e.repeat) TR()?.acao?.(mapa[k], true, P);
    if ((k === 'Space' || k === 'KeyW' || k === 'ArrowUp') && !e.repeat) { keys.add('jump'); pular(); TR()?.acao?.('jump', true, P); }
    if ((k === 'KeyE' || k === 'Enter') && !e.repeat) usar();
    e.preventDefault(); e.stopImmediatePropagation();
  }
  function teclaUp(e) { if (!aberto) return; const k = e.code; if (k === 'KeyJ') TR()?.acao?.('paper', false, P); if (k === 'KeyK') TR()?.acao?.('fart', false, P); if (k === 'KeyU') TR()?.acao?.('poder1', false, P); if (k === 'KeyI') TR()?.acao?.('poder2', false, P); if (k === 'Space' || k === 'KeyW' || k === 'ArrowUp') { keys.delete('jump'); TR()?.acao?.('jump', false, P); } if (k === 'ArrowLeft' || k === 'KeyA') keys.delete('left'); if (k === 'ArrowRight' || k === 'KeyD') keys.delete('right'); }
  function hudVisivel(v) { if (hud) hud.style.visibility = v ? 'visible' : 'hidden'; const bar = box?.querySelector('.c2-treino-wrap'); if (bar) bar.style.visibility = v ? 'visible' : 'hidden'; box.querySelector('.pular').hidden = v; }
  function objetivoNovo(txt) { const o = box?.querySelector('.obj'); if (!o) return; o.querySelector('span').textContent = txt; o.classList.remove('novo'); void o.offsetWidth; o.classList.add('novo'); sfx('plim'); }
  function aviso(txt) { const a = box?.querySelector('.avisos'); if (!a) return; const d = document.createElement('div'); d.textContent = txt; a.appendChild(d); setTimeout(() => d.remove(), 2600); }
  function item(nome) { const d = document.createElement('div'); d.className = 'item'; d.innerHTML = `<small>VOCÊ PEGOU</small><b>${nome}</b>`; box.querySelector('.tela').appendChild(d); setTimeout(() => d.remove(), 1800); }
  function escolher(quem, pergunta, ops, aoAcertar, semResposta) {
    keys.clear(); const el = document.createElement('div'); el.className = 'escolha';
    el.innerHTML = `<div class="cx"><b>${quem}</b><div>${pergunta}</div><div class="ops"></div><div class="resp"></div></div>`;
    const list = el.querySelector('.ops'); ops.forEach((o, i) => { const b = document.createElement('button'); b.type = 'button'; b.textContent = `${i + 1}. ${o.t}`; b.addEventListener('click', () => {
      if (o.voltar) { el.remove(); return; } if (o.ok) { if (o.r && !semResposta) { el.querySelector('.resp').style.color = '#2a7a3a'; el.querySelector('.resp').textContent = o.r; sfx('plim'); setTimeout(() => { el.remove(); aoAcertar(o); }, 1300); } else { el.remove(); aoAcertar(o); } return; }
      el.querySelector('.resp').textContent = o.r || 'Não...'; sfx('risada'); b.disabled = true; }); list.appendChild(b); });
    box.querySelector('.tela').appendChild(el); setTimeout(() => list.querySelector('button')?.focus(), 50);
  }
  function pausar(v) {
    pausado = v; keys.clear(); box.querySelector('.pausa')?.remove(); if (!v) return;
    const el = document.createElement('div'); el.className = 'pausa';
    el.innerHTML = `<h2>PAUSA</h2><button type="button" data-a="voltar">▶ CONTINUAR</button><button type="button" data-a="opcoes">⚙ OPÇÕES</button><button type="button" data-a="missoes">📜 MISSÕES</button><button type="button" data-a="som">♪ SOM: ${som ? 'LIGADO' : 'DESLIGADO'}</button><button type="button" data-a="sair">SALVAR E SAIR</button><p>A/D ou setas andam · ESPAÇO pula (segure no ar para voar) · E fala e entra · J papel · K peido · L dash · U/I poderes · ESC pausa</p>`;
    el.addEventListener('click', (e) => { const a = e.target.closest('button')?.dataset.a; if (a === 'voltar') pausar(false); if (a === 'som') { som = !som; window.__somCutscene = som; pausar(true); } if (a === 'sair') { salvar(); fechar(); } if (a === 'missoes') diario(); if (a === 'opcoes') opcoes(); });
    box.querySelector('.tela').appendChild(el); setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  // opções: hora do dia, clima, qualidade e posição dos botões no celular
  const HORAS = { manha: 8.2, tarde: 13.5, por: 17.7, noite: 22 };
  function opcoes() {
    box.querySelector('.pausa')?.remove(); const el = document.createElement('div'); el.className = 'pausa';
    const DT = window.DayTime, WX = window.Weather, GX = window.Graphics;
    const linhas = () => `<h2>OPÇÕES</h2>
      ${DT ? `<button type="button" data-o="hora">HORA DO DIA: <span class="val">${DT.mode() === 'auto' ? 'DA HISTÓRIA' : DT.label()}</span></button>` : ''}
      ${WX ? `<button type="button" data-o="clima">CLIMA: <span class="val">${WX.label()}</span></button>` : ''}
      ${GX ? `<button type="button" data-o="qualidade">QUALIDADE: <span class="val">${GX.label()}</span></button>` : ''}
      <button type="button" data-o="botoes">MUDAR BOTÕES DE LUGAR</button>
      <button type="button" data-o="voltar">◀ VOLTAR</button>
      <p>${DT?.mode() === 'auto' ? 'Hora do dia: segue a história.' : 'Hora do dia fixa: ' + DT?.label?.() + '.'} ${WX ? 'Clima: ' + WX.describe() : ''}<br>${GX ? 'Qualidade: ' + GX.describe() : ''}</p>`;
    const desenhar = (foco) => { el.innerHTML = linhas(); setTimeout(() => (el.querySelector(`[data-o="${foco}"]`) || el.querySelector('button'))?.focus(), 20); };
    el.addEventListener('click', (e) => { const o = e.target.closest('button')?.dataset.o; if (!o) return;
      if (o === 'voltar') { pausar(true); return; }
      if (o === 'hora') DT?.next?.(); if (o === 'clima') WX?.next?.(); if (o === 'qualidade') GX?.toggle?.();
      if (o === 'botoes') { el.hidden = true; hudVisivel(true); window.CampanhaBotoes?.editar?.(box.querySelector('.tela'), () => { el.hidden = false; desenhar('botoes'); }); return; }
      sfx('plim'); desenhar(o); });
    desenhar(); box.querySelector('.tela').appendChild(el);
  }
  function diario() {
    box.querySelector('.pausa')?.remove(); const el = document.createElement('div'); el.className = 'pausa'; const L = window.CampanhaAliados?.missoes?.() || [], ic = { feita: '✔', ativa: '▶', nova: '!' };
    el.innerHTML = `<h2>📜 MISSÕES</h2><div style="background:#f2dc9a;color:#3a2412;border:3px solid #2a1a10;padding:10px 14px;width:min(560px,86%);font:12px Space,Arial,sans-serif;line-height:1.5"><b style="font:9px Pixel,monospace;color:#8a4a2a">HISTÓRIA</b><br>${PASSOS[S.passo]?.obj || ''}</div>
      <div style="background:#2a1e14e8;border:3px solid #8a6a3a;padding:8px 12px;width:min(560px,86%);font:11px Space,Arial,sans-serif;line-height:1.5;max-height:46vh;overflow:auto">${L.map(([n, st, d]) => `<div style="margin:5px 0;opacity:${st === 'feita' ? .55 : 1}"><b style="font:9px Pixel,monospace;color:${st === 'feita' ? '#7af07a' : st === 'ativa' ? '#ffd24a' : '#e8c66a'}">${ic[st]} ${n.toUpperCase()}</b><br><span style="color:#e8dcc0">${st === 'feita' ? 'Concluída!' : d}</span></div>`).join('')}</div><button type="button" data-a="voltar">◀ VOLTAR</button>`;
    el.addEventListener('click', (e) => { if (e.target.closest('button')) pausar(true); }); box.querySelector('.tela').appendChild(el); setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  function hudAtualizar() {
    copiarPoderes();
    topoAtualizar();
    const cor = box.querySelector('.vida .cor'), n = Math.round((P.max || 100) / 20), hp = clamp(P.hp, 0, P.max || 100) / 20; let h = ''; for (let i = 0; i < n; i++) h += `<i class="${hp >= i + 1 ? 'on' : hp > i + .3 ? 'meio' : ''}"></i>`; if (cor.innerHTML !== h) cor.innerHTML = h;
    box.querySelector('.vida .gas b').style.width = `${clamp(TR()?.gas?.() ?? 100, 0, 100)}%`; box.querySelector('.vida .moedas').textContent = `● ${window.CampanhaLoja?.moedas?.() ?? 0}`; { const pp = box.querySelector('.vida .papeis'), tx = `◆ ${TR()?.papeis?.() ?? 30}`; if (pp && pp.textContent !== tx) pp.textContent = tx; }
    const e = box.querySelector('.entrar'); e.hidden = !perto || !!cut; if (perto) e.textContent = perto.botao || (perto.tipo === 'poderes' ? 'PODERES' : perto.tipo === 'pc' ? 'USAR' : perto.tipo === 'armario' ? 'ABRIR' : perto.tipo === 'rolante' ? (perto.ate[1] < FLOOR ? 'SUBIR' : 'DESCER') : /^SAIR|DESCER/.test(perto.rotulo) ? 'SAIR' : 'ENTRAR');
  }

  /* ---------- luta do vilão no motor da campanha 1 (arena, barra do chefe, golpes iguais) ---------- */
  let emLuta = false;
  function lutaC1(f) {
    const K = f.F.chefe || {}; let ok = false;
    try { ok = !!window.C2Luta?.iniciar?.({ slug: f.slug, tipo: f.chefe.tipo || K.tipo, nome: K.nome, cena: cenaId, bossX: f.chefe.x }, (r) => voltarDaLuta(f, r)); } catch (e) { ok = false; }
    if (!ok) { f.comecarLuta(); return; } // sem o motor da principal: luta antiga, para nunca travar
    emLuta = true; aberto = false; cancelAnimationFrame(raf); keys.clear(); joy = 0; devolverTopo(); box.hidden = true; salvarProgressao();
  }
  function voltarDaLuta(f, r) {
    emLuta = false; aberto = true; box.hidden = false; keys.clear(); joy = 0; safe(controlesC1); last = performance.now(); raf = requestAnimationFrame(frame);
    if (r === 'venceu') { P.hp = Math.max(P.hp, Math.round((P.max || 100) * .5)); safe(() => apiFase.vencer()); }
    else if (r === 'recuou') { safe(() => voltarDoDesmaio()); aviso('Você saiu da arena. Respire e volte quando quiser.'); }
    else desmaiar();
  }
  /* ---------- continuação da campanha 1: progressão (XP, nível, atributos), arma, itens e a barra de cima ---------- */
  const SAVE1 = 'da-roca-adventure-v1';
  const save1 = () => { try { return JSON.parse(localStorage.getItem(SAVE1) || 'null'); } catch (e) { return null; } };
  function carregarC1() {
    let st = null; try { st = window.Game?.getState?.(); } catch (e) {}
    if (st?.started) { TR()?.dadosC1?.({ weapon: st.weapon || 0, trained: !!st.q?.trained, miqueias: !!st.q?.miqueias }); return; }
    const sv = save1(); // a principal ainda não abriu nesta sessão: lê o save dela (sem regravar nada)
    if (sv) { try { const cur = window.Progression?.getState?.(); if (sv.progression && (!cur || (cur.totalXP || 0) < (sv.progression.totalXP || 0))) window.Progression.restore(sv.progression); } catch (e) {}
      TR()?.dadosC1?.({ weapon: Number(sv.weapon) || 0, trained: sv.q ? !!sv.q.trained : true, miqueias: !!sv.q?.miqueias }); }
    else if (S?.progressao) { try { window.Progression?.restore?.(S.progressao); } catch (e) {} }
  }
  let tSalvarProg = 0;
  function salvarProgressao() { clearTimeout(tSalvarProg); tSalvarProg = setTimeout(() => { // grava só a progressão no save da principal (o resto do save fica intacto)
    const pr = window.Progression?.serialize?.(); if (!pr) return; const sv = save1(); if (sv) { sv.progression = pr; try { localStorage.setItem(SAVE1, JSON.stringify(sv)); } catch (e) {} } if (S) { S.progressao = pr; salvar(); } }, 400); }
  const xpTxt = [];
  function ganharXP(n, id, x, y) {
    const antes = window.Progression?.getState?.()?.level || 1, r = window.Progression?.award?.(n, id); if (!r?.awarded) return r;
    if (x !== undefined) xpTxt.push({ x, y, s: '+' + r.awarded + ' XP', t: 0 });
    if ((r.level || antes) > antes) { P.hp = vidaMax(); TR()?.encher?.(); aviso('Nível ' + r.level + '! Abra DADOS → ATRIBUTOS para distribuir seus pontos.'); sfx('fanfarra'); }
    salvarProgressao(); return r;
  }
  const vidaMax = () => Math.round((TR()?.bonus?.().maxHP || 100) * ((window.CampanhaAliados?.vidaMax?.() || 100) / 100));
  addEventListener('c2-atributo', () => { if (!aberto) return; const antes = P.max || 100; P.max = vidaMax(); if (P.max > antes) P.hp = Math.min(P.max, P.hp + (P.max - antes)); salvarProgressao(); });
  // barra de cima da campanha 1 (retrato, corações, gás, papel, DADOS, INVENTÁRIO, XP, ATRIBUTOS, som, pausa, tela cheia)
  let topo = null;
  function levarTopo(w) {
    const shell = document.getElementById('gameShell'), bar = topo?.el || shell?.querySelector('.game-topbar'); if (!bar || !w) return;
    if (!topo) { topo = { el: bar, pai: bar.parentNode, prox: bar.nextSibling, txt: {} }; for (const id of ['hpValue', 'paperValue', 'gasPercent', 'stageName']) { const e = document.getElementById(id); if (e) topo.txt[id] = e.textContent; } topo.gasW = document.getElementById('gasFill')?.style.width || ''; }
    w.appendChild(bar); box.classList.add('c1-topo'); topoAtualizar(true);
  }
  function devolverTopo() {
    if (!topo) return; try { topo.pai.insertBefore(topo.el, topo.prox && topo.prox.parentNode === topo.pai ? topo.prox : null); } catch (e) { try { topo.pai.appendChild(topo.el); } catch (e2) {} }
    for (const [id, v] of Object.entries(topo.txt)) { const e = document.getElementById(id); if (e) e.textContent = v; } const gf = document.getElementById('gasFill'); if (gf) gf.style.width = topo.gasW; window.HudMinimal?.close?.(); topo = null; box?.classList.remove('c1-topo');
  }
  const pôr = (id, v) => { const e = document.getElementById(id); if (e && e.textContent !== v) e.textContent = v; };
  function topoAtualizar() {
    if (!topo) return; const max = P.max || 100, h = clamp(Math.ceil(P.hp / max * 5), 0, 5);
    pôr('hpValue', ('♥ '.repeat(h) + '♡ '.repeat(5 - h)).trim()); pôr('paperValue', String(TR()?.papeis?.() ?? 30));
    const g = TR()?.gas?.() ?? 100, gm = TR()?.gasMax?.() || 100, pct = Math.floor(clamp(g / gm, 0, 1) * 100); pôr('gasPercent', pct + '%'); const gf = document.getElementById('gasFill'); if (gf && gf.style.width !== pct + '%') gf.style.width = pct + '%';
    const nome = (D()?.nome || '').toUpperCase(); if (nome) pôr('stageName', nome);
  }
  /* ---------- câmera de perto, como a campanha principal (ui.js followFill) ---------- */
  let pan = null, preenche = false;
  function enquadrar(dt) {
    const shell = document.getElementById('gameShell'), w = innerWidth, h = innerHeight, sc = w / 960;
    const quer = w / h > 1.79 && !cut && (!shell || shell.classList.contains('screen-fill') || !shell.classList.contains('immersive'));
    if (quer !== preenche) { preenche = quer; box.classList.toggle('preencher', quer); pan = null; if (!quer) box.querySelector('.tela').style.removeProperty('--c2-pan'); }
    if (!quer) return;
    const fundo = Math.min(0, h - 540 * sc), pe = 72 + Math.min(64, 62 * sc) + 24, alvo = Math.min(0, Math.max(fundo, pe - P.y * sc));
    pan = pan === null ? alvo : pan + (alvo - pan) * Math.min(1, dt * 12); const v = pan.toFixed(1) + 'px', tela = box.querySelector('.tela'); if (tela.style.getPropertyValue('--c2-pan') !== v) tela.style.setProperty('--c2-pan', v);
  }
  /* ---------- quadro a quadro ---------- */
  function frame(now) {
    if (!aberto) return; raf = requestAnimationFrame(frame);
    const dt = Math.min(.05, Math.max(0, (now - last) / 1000)); fpsMedio += ((dt > 0 ? 1 / Math.max(dt, (now - last + 1e-3) / 1000) : 60) - fpsMedio) * .05; last = now;
    const cob = coberto(); box.style.visibility = cob ? 'hidden' : 'visible'; if (cob) return;
    P.max = vidaMax(); if (window.CampanhaAliados?.ocupado?.()) { window.CampanhaAliados.atualizar(dt, []); return; }
    if (cut) { RT().update(cut.s, dt); if (cut.s.done) { const f = cut.depois; cut = null; hudVisivel(true); try { window.DayTime?.force?.(null); } catch (e) {} f?.(); } else { safe(() => enquadrar(dt)); c.save(); RT().draw(c, cut.s); c.restore(); return; } } // cutscene: quadro inteiro, como as cenas de história da principal
    if (pausado || ocupado()) { keys.clear(); P.vx = 0; }
    t += dt; const d = D();
    const F = !cut ? faseAtual() : fase; TR()?.inimigos?.(F && !cut ? F.inimigos() : []);
    if (!pausado && !morto) { P.inv = Math.max(0, (P.inv || 0) - dt); P.atordoado = Math.max(0, (P.atordoado || 0) - dt); TR()?.passo?.(dt, P, { cam, segurandoPulo: keys.has('jump') }); if (viagem) andarViagem(dt); else fisica(dt); if (F) F.update(dt); safe(() => window.CampanhaAliados?.atualizar?.(dt, F ? F.inimigos() : [])); }
    tremor = Math.max(0, tremor - dt * 30); clarao = Math.max(0, clarao - dt * 1.6); for (const d0 of dano) d0.t += dt; while (dano.length && dano[0].t > 1) dano.shift();
    cam += (clamp(P.x - W * .36, 0, Math.max(0, d.largura - W)) - cam) * Math.min(1, dt * 8); safe(() => enquadrar(dt)); // câmera como na principal
    try { window.DayTime?.force?.(horaAtual()); } catch (e) {}
    const o = { scene: d.id, camera: cam, time: t, player: P, shots: [], enemies: [], minions: [] };
    safe(() => window.Interact?.update?.(dt, o)); safe(() => CC().heroi?.(P.x, P.y, P.vy));
    window.Art.drawScene(c, d.id, cam, t);
    c.save(); { const sh = Math.max(TR()?.tremor?.() || 0, tremor); c.translate(-Math.round(cam) + Math.round((Math.random() - .5) * sh), Math.round((Math.random() - .5) * sh)); }
    if (d.id >= 12) for (const pl of d.plataformas || []) if (pl[0] + pl[2] > cam - 20 && pl[0] < cam + 980) safe(() => CC().plataforma(c, d.id, pl, t));
    safe(() => window.Interact?.drawBack?.(c, o)); if (d.id >= 12) { safe(() => window.CampanhaPlantas?.drawBack?.(c, o)); safe(() => window.CampanhaTaxi?.desenhar?.(c, o)); safe(() => window.CampanhaLoja?.desenhar?.(c, o)); safe(() => window.CampanhaMoradores?.desenhar?.(c, o)); }
    desenharExtras();
    safe(() => window.CampanhaAliados?.desenhar?.(c, d.id)); if (F) F.desenhar(c);
    for (const ax of window.CampanhaAliados?.alvos?.(d.id) || []) { const y = FLOOR - 150 + Math.sin(t * 4 + ax) * 4; c.fillStyle = '#1c1408'; c.fillRect(ax - 7, y - 7, 14, 14); c.fillStyle = '#7af07a'; c.fillRect(ax - 5, y - 5, 10, 10); c.fillStyle = '#1c1408'; c.fillRect(ax - 1, y - 4, 2, 5); c.fillRect(ax - 1, y + 2, 2, 2); }
    safe(() => TR()?.desenharAtras?.(c, t)); // nuvem de gás e rastro do dash atrás do herói (como na campanha 1)
    const at = P.attack || 0, dur = P.attackDuration || .32; if (!((P.inv || 0) > 0 && Math.floor(t * 16) % 2)) window.Art.drawCharacter(c, 'daroca', P.x, P.y, { frame: Math.abs(P.vx) > 8 ? (P.anim || 0) / 9 : t, speed: Math.abs(P.vx), muscular: !!TR()?.musculoso?.(), land: (P.landTimer || 0) / .15, landTimer: P.landTimer || 0, facing: P.facing, moving: (Math.abs(P.vx) > 8 && P.ground) || viagem?.tipo === 'porta', grounded: P.ground, vy: P.vy, attack: at > 0, attackType: P.attackType || 'paper', attackProgress: 1 - at / dur, attackObject: 'paper', flight: !!TR()?.voandoAgora?.(), dash: !!TR()?.dashing?.(), recoil: at > 0 && (P.attackType || 'paper') === 'paper' ? Math.max(0, 1 - (1 - at / dur) * 3) : 0 });
    safe(() => TR()?.desenhar?.(c, t));
    safe(() => window.Interact?.drawFront?.(c, o)); if (d.id >= 12) { safe(() => window.CampanhaPlantas?.drawFront?.(c, o)); safe(() => window.CampanhaCamadas?.primeiroPlano?.(c, o)); }
    procurarPerto();
    if (perto) { c.font = '11px Pixel, monospace'; const w = perto.rotulo.length * 7.6 + 34, x = perto.x, y = FLOOR - 150; c.fillStyle = '#1c342de8'; c.fillRect(x - w / 2, y - 13, w, 26); c.strokeStyle = '#e8c66a'; c.strokeRect(x - w / 2 + .5, y - 12.5, w - 1, 25); c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#f3d89e'; c.fillText('[E] ' + perto.rotulo, x, y + 1); c.textAlign = 'left'; }
    c.font = '13px Pixel, monospace'; c.textAlign = 'center'; for (let i = xpTxt.length - 1; i >= 0; i--) { const x0 = xpTxt[i]; x0.t += 1 / 60; if (x0.t > 1.2) { xpTxt.splice(i, 1); continue; } c.globalAlpha = Math.min(1, (1.2 - x0.t) * 2); c.fillStyle = '#2a1a08'; c.fillText(x0.s, x0.x + 2, x0.y - x0.t * 30 + 2); c.fillStyle = '#ffec91'; c.fillText(x0.s, x0.x, x0.y - x0.t * 30); } c.globalAlpha = 1;
    c.font = '16px Pixel, monospace'; c.textAlign = 'center'; for (const d0 of dano) { c.globalAlpha = 1 - d0.t; c.fillStyle = '#2a0808'; c.fillText(d0.s, d0.x + 2, d0.y - d0.t * 40 + 2); c.fillStyle = '#ff5a4a'; c.fillText(d0.s, d0.x, d0.y - d0.t * 40); } c.globalAlpha = 1; c.textAlign = 'left';
    c.restore(); safe(() => window.CampanhaAmbientes?.cobrir?.(c, d.id, cam));
    if (!F?.emArena?.()) setaObjetivo(); if (F) F.desenharTela(c, W);
    { const cr = window.CampanhaAliados?.correndo?.(); if (cr) { const txt = cr.fase === 'contagem' ? String(Math.ceil(cr.cont)) : (Math.max(0, cr.lim - cr.t)).toFixed(1) + ' s'; c.fillStyle = '#1c1408'; c.fillRect(W / 2 - 70, 70, 140, 34); c.fillStyle = '#ffd24a'; c.fillRect(W / 2 - 68, 72, 136, 30); c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#1c1408'; c.fillText('🛹 ' + txt, W / 2, 88); c.textAlign = 'left'; } }
    if (clarao > 0) { c.globalAlpha = clarao; c.fillStyle = claraoCor; c.fillRect(0, 0, W, H); c.globalAlpha = 1; }
    if (P.hp < 30 && !cut) { const a = .18 + Math.sin(t * 6) * .08; const g = c.createRadialGradient(W / 2, H / 2, 200, W / 2, H / 2, 600); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(1, `rgba(140,0,10,${a})`); c.fillStyle = g; c.fillRect(0, 0, W, H); }
    box.querySelector('.obj').style.visibility = F?.emArena?.() ? 'hidden' : 'visible';
    if (window.Graphics?.isShader?.()) safe(() => window.Shader?.apply?.(cv, { scene: d.id, camera: cam, time: t, outdoor: !d.interno }));
    if (fade > 0) { c.fillStyle = `rgba(8,10,14,${fade})`; c.fillRect(0, 0, W, H); }
    hudAtualizar();
  }

  /* ---------- abrir e fechar ---------- */
  function abrir(o = {}) {
    if (!box) montar(); S = (!o.novo && carregar()) || novoSave(); if (S.passo === 'bairro') S.passo = 'creuza'; if (S.passo === 'fim6b') S.passo = 'ir_barao'; if (S.passo === 'fim6c') S.passo = 'ir_centro'; fase = null; morto = false; box.querySelector('.pausa')?.remove(); if (o.novo) safe(() => localStorage.removeItem(KEY));
    aberto = true; box.hidden = false; pausado = false; cut = null; keys.clear(); P.hp = S.hp || 100;
    window.CampanhaAliados?.ligar?.({ P, S: () => S, salvar: () => salvar(), item, aviso, sfx, conversa: (npc) => conversa(npc), escolher: (q, pg, ops, cb) => escolher(q, pg, ops, cb, true), tela: () => box.querySelector('.tela'), cena: () => cenaId, pausar: (v) => { keys.clear(); hudVisivel(!v); box.querySelector('.pular').hidden = true; } });
    TR()?.ligar?.(true, P, { jogo: true }); safe(() => window.CampanhaBotoes?.aplicar?.(box.querySelector('.tela'))); safe(carregarC1); safe(() => window.CampanhaPoderes?.controles?.(true, { forcar: true })); safe(controlesC1); dispatchEvent(new Event('c2-controles')); requestAnimationFrame(() => requestAnimationFrame(() => { if (aberto) safe(controlesC1); })); // de novo, com o layout da principal já calculado
    if (S.passo === 'abertura') { irPara(0, 700); tocar('c2_abertura', PASSOS.abertura.depois); }
    else { irPara(S.cena ?? PASSO_INICIAL_DA_CENA[S.passo] ?? 13, S.x ?? 300); objetivoNovo(PASSOS[S.passo]?.obj || ''); hudVisivel(true); }
    last = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(frame);
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
  }
  function fechar() {
    safe(devolverTopo); salvarProgressao();
    aberto = false; cancelAnimationFrame(raf); if (box) box.hidden = true; pausado = false; box?.querySelector('.pausa')?.remove();
    TR()?.ligar?.(false, P); safe(() => window.CampanhaPoderes?.controles?.(false, { forcar: false })); // devolve os botões da campanha principal intactos
    safe(() => window.CampanhaCutscenes?.musica?.parar?.()); window.__somCutscene = false; try { window.DayTime?.force?.(null); } catch (e) {}
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } }));
  }

  /* ---------- botão na tela inicial ---------- */
  function painel() {
    const ok = liberada(); let el = document.getElementById('c2Painel');
    if (!el) { el = document.createElement('div'); el.id = 'c2Painel'; el.className = 'c2j'; el.style.background = '#06080cdd'; document.body.appendChild(el); css(); }
    el.hidden = false;
    el.innerHTML = `<div class="pausa" style="position:relative;background:none"><h2>CAMPANHA 2 · VITÓRIA DA CONQUISTA</h2>${ok ? `<p>${safe(() => JSON.parse(localStorage.getItem(KEY) || 'null')?.flags?.zerou, false) ? '✔ Campanha 2 completa: o trio voltou! Continue explorando Conquista.' : 'Um ano depois. O Jorge ligou... e desligou. Agora o Da Roça vai até Conquista olhar na cara dele.'}</p>${temSave() ? '<button type="button" data-a="cont">▶ CONTINUAR</button>' : ''}<button type="button" data-a="novo">${temSave() ? 'COMEÇAR DE NOVO' : '▶ COMEÇAR'}</button>` : '<p>🔒 Termine a campanha principal (até a ligação do Jorge) para liberar a Campanha 2.</p>'}<button type="button" data-a="fechar">VOLTAR</button></div>`;
    el.onclick = (e) => { const a = e.target.closest('button')?.dataset.a; if (!a) return; if (a === 'fechar') el.hidden = true; if (a === 'cont') { el.hidden = true; abrir({}); } if (a === 'novo') { const vai = () => { el.hidden = true; abrir({ novo: true }); }; if (!temSave()) return vai(); const pergunta = { titulo: 'COMEÇAR A CAMPANHA 2 DO ZERO?', html: 'Você já tem um save da Campanha 2.<br>Começar de novo <b>apaga todo o progresso dela</b> (vilões vencidos, cenários e itens da campanha 2).<br>A campanha principal, seu nível e atributos não mudam.<br><br>Tem certeza?', sim: 'APAGAR E COMEÇAR', nao: 'CANCELAR' }; if (window.Confirmar) window.Confirmar(pergunta).then((ok) => { if (ok) vai(); }); else if (confirm('Começar a Campanha 2 de novo? O progresso dela será apagado.')) vai(); } };
    setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  function botaoMenu() {
    const lista = document.querySelector('#startScreen .ranch-mode-entries'); if (!lista || lista.querySelector('[data-open-campanha2]')) return;
    const b = document.createElement('button'); b.type = 'button'; b.dataset.openCampanha2 = ''; b.innerHTML = `<b>❄ CAMPANHA 2 · CONQUISTA</b><small>${liberada() ? 'Um ano depois · a busca pelo Jorge' : 'Complete a história para liberar'}</small>`;
    b.addEventListener('click', (e) => { e.preventDefault(); painel(); }); lista.appendChild(b);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', botaoMenu); else botaoMenu();
  window.Campanha2 = Object.freeze({ emLuta: () => emLuta, ganharXP: (n, id, x, y) => ganharXP(n, id, x, y), aviso: (txt) => aviso(txt), liberada, abrir, fechar, painel, aberto: () => aberto, estado: () => ({ passo: S?.passo, cena: cenaId, x: Math.round(P.x), y: Math.round(P.y), perto: perto?.rotulo || null, cutscene: cut?.id || null, luta: fase?.emArena?.() ? fase.slug : null, chave: D()?.key || window.CampanhaCenarios?.lista?.find?.((d) => d.id === cenaId)?.key || null, flags: { ...(S?.flags || {}) } }),
    // testes
    _ir: (id, x) => irPara(id, x), _fase: () => fase && { slug: fase.slug, chefe: { st: fase.chefe.st, hp: fase.chefe.hp, fase: fase.chefe.fase, x: Math.round(fase.chefe.x) }, arena: fase.emArena(), inimigos: fase.inimigos().length }, _hp: (n) => { P.hp = n; }, _bater: (n) => { const f = fase; if (f?.chefe) f.chefe.onDano(n, 'teste'); }, _pos: (x, y) => { P.x = x; P.y = y; P.vy = 0; P.ground = true; }, _fps: () => fpsMedio, _passo: (id) => passo(id), _usar: usar, _pular: pularCut });
})();
