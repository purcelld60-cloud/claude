/* Campanha 2 · ALIADOS e MISSÕES EXTRAS (as histórias próprias dos 12 aliados do roteiro).
   Cada aliado fica num lugar da cidade, com "!" em cima quando tem missão nova e "?" quando dá para entregar.
   - Dona Lurdes: o radinho roubado (achar na avenida) → +20 de vida máxima.
   - Mel: os 3 pedaços do mapa verdadeiro (centro, feira e lagoa) → a seta passa a mostrar as missões extras.
   - Biscoito (cachorro caramelo): dar um biscoito de polvilho → vira companheiro e morde os inimigos.
   - Tio do Picolé: vende picolés de nome de meme (cura) e o biscoito do cachorro.
   - Nando Skatista: corrida de skate no centro (ir até a bandeira e voltar a tempo) → skate: anda mais rápido.
   - Juninho Mecânico: conserta a bicicleta (corrente do Gugu + pneu da rodoviária) → bicicleta: mais rápido ainda.
   - Bia do Arrocha: minijogo de ritmo no palco do teatro → MORAL: +15% de força.
   - Gugu do Ferro-Velho: a OFICINA DE MELHORIAS dos poderes (campanha2/oficina.js).
   - Vó Cida, Larissa e Carlinhos: as PISTAS DO JORGE (as três juntas dão 90 moedas e um diário).
   - Seu Zé: o táxi (já existe).
   O estado fica no save da Campanha 2 (flags.extra). API usada pelo jogo: candidatos, atualizar, desenhar, velocidade,
   vidaMax, forca, missoes, alvos. */
(() => {
  'use strict';
  if (window.CampanhaAliados) return;
  const FLOOR = 440, TAU = Math.PI * 2, clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  let api = null, t = 0, cao = null, corrida = null, ritmo = null;
  const X = () => { const S = api.S(); S.flags.extra = S.flags.extra || {}; return S.flags.extra; };
  const tem = (k) => !!X()[k], marca = (k, v = 1) => { X()[k] = v; api.salvar(); };
  const moedas = () => window.CampanhaLoja?.moedas?.() ?? 0, ganhar = (n) => window.CampanhaLoja?.ganhar?.(n);
  const F = (quem, texto, emo) => [quem, texto, emo];

  /* ---------- itens espalhados pela cidade ---------- */
  const ITENS = [
    { id: 'radio', cena: 16, x: 1960, nome: 'RADINHO DA DONA LURDES', quando: () => X().lurdes === 'ativa', cor: '#c43c3a' },
    { id: 'mapa1', cena: 14, x: 4300, nome: 'PEDAÇO DO MAPA (1/3)', quando: () => X().mel === 'ativa', cor: '#e8c24c' },
    { id: 'mapa2', cena: 17, x: 3980, nome: 'PEDAÇO DO MAPA', quando: () => X().mel === 'ativa', cor: '#e8c24c' },
    { id: 'mapa3', cena: 32, x: 2400, nome: 'PEDAÇO DO MAPA', quando: () => X().mel === 'ativa', cor: '#e8c24c' },
    { id: 'pneu', cena: 30, x: 2300, nome: 'PNEU DE BICICLETA', quando: () => X().juninho === 'ativa', cor: '#3a3a3a' }
  ];
  const pegou = (id) => !!X()['item_' + id];
  const pedacos = () => ['mapa1', 'mapa2', 'mapa3'].filter(pegou).length;

  /* ---------- os aliados ---------- */
  const ALIADOS = [
    { id: 'lurdes', quem: 'c2_lurdes', nome: 'Dona Lurdes', cena: 13, x: 1980,
      estado: () => (X().lurdes === 'feita' ? 'ok' : X().lurdes === 'ativa' ? (pegou('radio') ? 'entregar' : 'andando') : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_lurdes', 'Ô menino, me ajuda? Roubaram meu radinho de pilha. Trinta anos ouvindo a rádio da cidade nele!', 'sad'), F('daroca', 'Quem levaria um radinho?'), F('c2_lurdes', 'Um moleque de bicicleta. Saiu correndo pro lado do Monumento ao Índio.'), F('c2_lurdes', 'Se achar, eu faço um café que levanta até defunto.', 'friend')]
        : st === 'andando' ? [F('c2_lurdes', 'O moleque foi pro lado do Monumento ao Índio. Procura na avenida!')]
          : st === 'entregar' ? [F('daroca', 'Achei, Dona Lurdes! Tava largado na calçada da avenida.'), F('c2_lurdes', 'MEU RADINHO! Ai, que alegria!', 'friend'), F('c2_lurdes', 'Toma esse café passado na hora. Daqui pra frente, você aguenta muito mais pancada.', 'friend')]
            : [F('c2_lurdes', 'O radinho tá tocando arrocha o dia inteiro. Obrigada de novo, meu filho.', 'friend')],
      fim: (st) => { if (st === 'nova') marca('lurdes', 'ativa'); if (st === 'entregar') { marca('lurdes', 'feita'); api.item('CAFÉ DA DONA LURDES · +20 DE VIDA MÁXIMA'); api.P.hp = vidaMax(); api.sfx('fanfarra'); } } },
    { id: 'mel', quem: 'c2_mel', nome: 'Mel', cena: 14, x: 960,
      estado: () => (X().mel === 'feita' ? 'ok' : X().mel === 'ativa' ? (pedacos() >= 3 ? 'entregar' : 'andando') : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_mel', 'Mapa da cidade! Só cinco reais! Com todos os atalhos secretos!'), F('daroca', 'Esse mapa tem o desenho de um castelo.'), F('c2_mel', '...É um mapa artístico.', 'embarrassed'), F('c2_mel', 'Tá bom, é falso. O verdadeiro, do meu avô, rasgou em três. Um pedaço voou pro fim do centro, outro pra feira e outro pra lagoa.'), F('c2_mel', 'Se você achar os três, eu monto o mapa verdadeiro pra você. De graça!', 'friend')]
        : st === 'andando' ? [F('c2_mel', `Já achou ${pedacos()} de 3 pedaços. Fim do centro, fim da feira e a beira da lagoa!`)]
          : st === 'entregar' ? [F('c2_mel', 'Os três! Deixa eu colar...', 'friend'), F('c2_mel', 'Pronto: o mapa do meu avô. Ele marca tudo que tem pra fazer na cidade.'), F('c2_mel', 'Agora a sua seta mostra também onde tem gente precisando de ajuda.', 'friend')]
            : [F('c2_mel', 'Quer um mapa falso de lembrança? Brincadeira!', 'friend')],
      fim: (st) => { if (st === 'nova') marca('mel', 'ativa'); if (st === 'entregar') { marca('mel', 'feita'); ganhar(40); api.item('MAPA VERDADEIRO · A SETA MOSTRA AS MISSÕES EXTRAS'); api.sfx('fanfarra'); } } },
    { id: 'biscoito', quem: 'c2_biscoito', nome: 'Biscoito', cena: 13, x: 640, cao: true,
      estado: () => (tem('cao') ? 'ok' : tem('biscoito_cao') ? 'entregar' : X().cao_visto ? 'andando' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_biscoito', 'Au... (ele olha pra você com cara de fome)', 'sad'), F('daroca', 'Tá com fome, caramelo? Eu não tenho nada...'), F('narrador', 'Dizem que o Tio do Picolé, na feira, vende biscoito de polvilho. Cachorro caramelo nenhum resiste.')]
        : st === 'andando' ? [F('c2_biscoito', 'Au? (ele cheira o seu bolso vazio)', 'sad'), F('narrador', 'Biscoito de polvilho: na banca do Tio do Picolé, na feira.')]
          : st === 'entregar' ? [F('daroca', 'Toma, caramelo. Biscoito de polvilho.'), F('c2_biscoito', 'AU! AU AU!', 'friend'), F('narrador', 'O Biscoito agora vai com você. Nas brigas, ele morde quem chegar perto.')]
            : [F('c2_biscoito', 'AU! (abana o rabo)', 'friend')],
      fim: (st) => { if (st === 'nova') marca('cao_visto'); if (st === 'entregar') { marca('cao'); api.item('BISCOITO AGORA É SEU COMPANHEIRO'); api.sfx('fanfarra'); } } },
    { id: 'picole', quem: 'c2_picole', nome: 'Tio do Picolé', cena: 17, x: 2280, loja: true,
      estado: () => 'loja', falas: () => [F('c2_picole', 'Olha o picolé! Picolé no frio de onze graus, quem vai querer?!'), F('daroca', 'Picolé... no frio?'), F('c2_picole', 'Por isso eu vendo com nome de meme. As pessoas riem e compram!', 'friend')],
      fim: () => lojaPicole() },
    { id: 'nando', quem: 'c2_nando', nome: 'Nando Skatista', cena: 14, x: 3520,
      estado: () => (tem('skate') ? 'ok' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_nando', 'Aí, forasteiro! Aposta uma corrida? Até a bandeira lá no fim do centro e de volta aqui.'), F('c2_nando', 'Se você chegar antes de mim, o skate reserva é seu. Ele te deixa bem mais rápido.'), F('daroca', 'Fechou. Mas eu vou a pé.'), F('c2_nando', 'Kkkk aí que tá a graça!', 'friend')]
        : [F('c2_nando', 'O skate tá rodando bonito, hein? Cuidado com os buracos da avenida.', 'friend')],
      fim: (st) => { if (st === 'nova') iniciarCorrida(); } },
    { id: 'juninho', quem: 'c2_juninho', nome: 'Juninho Mecânico', cena: 16, x: 2420,
      estado: () => (X().juninho === 'feita' ? 'ok' : X().juninho === 'ativa' ? (pegou('pneu') && tem('corrente') ? 'entregar' : 'andando') : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_juninho', 'Tá vendo essa bicicleta? Era do meu avô. Falta só uma corrente e um pneu.'), F('c2_juninho', 'Corrente, o Gugu do ferro-velho tem (no fim da rua da pensão). Pneu, vi um largado na rodoviária.'), F('c2_juninho', 'Traz os dois que eu monto e te empresto. De bicicleta você atravessa a cidade voando!', 'friend')]
        : st === 'andando' ? [F('c2_juninho', `Falta: ${tem('corrente') ? '' : 'a corrente (com o Gugu) '}${pegou('pneu') ? '' : 'o pneu (na rodoviária)'}.`)]
          : st === 'entregar' ? [F('c2_juninho', 'Corrente e pneu! Deixa comigo...', 'friend'), F('c2_juninho', 'Pronto! Pedala com cuidado. E freia antes da rotatória.', 'friend')]
            : [F('c2_juninho', 'E a bicicleta, tá rodando bem? Se furar, já sabe.', 'friend')],
      fim: (st) => { if (st === 'nova') marca('juninho', 'ativa'); if (st === 'entregar') { marca('juninho', 'feita'); marca('bike'); api.item('BICICLETA · VOCÊ ANDA MUITO MAIS RÁPIDO'); api.sfx('fanfarra'); } } },
    { id: 'bia', quem: 'c2_bia', nome: 'Bia do Arrocha', cena: 19, x: 1720,
      estado: () => (tem('moral') ? 'ok' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_bia', 'Ei, você! Meu dançarino faltou e o show começa agora. Sabe dançar arrocha?'), F('daroca', 'Eu sei peidar no ritmo. Serve?'), F('c2_bia', '...Serve. Sobe no palco! Aperta as setas quando elas chegarem na linha.', 'friend')]
        : [F('c2_bia', 'Ainda falam do seu show. O forasteiro que dança arrocha!', 'friend')],
      fim: (st) => { if (st === 'nova') iniciarRitmo(); } },
    { id: 'gugu', quem: 'c2_gugu', nome: 'Gugu do Ferro-Velho', cena: 13, x: 4040, oficina: true,
      estado: () => (X().juninho === 'ativa' && !tem('corrente') ? 'entregar' : 'loja'),
      falas: (st) => st === 'entregar' ? [F('c2_gugu', 'Corrente de bicicleta pro Juninho? Tenho uma aqui, já lubrificada.'), F('c2_gugu', 'Leva. E volta pra turbinar essas garrafadas na minha oficina!', 'friend')] : null,
      fim: (st) => { if (st === 'entregar') { marca('corrente'); api.item('CORRENTE DE BICICLETA'); } else window.CampanhaOficina?.abrir?.({}); } },
    { id: 'vocida', quem: 'c2_vo_cida', nome: 'Vó Cida', cena: 13, x: 1080, pista: true,
      estado: () => (tem('pista_vocida') ? 'ok' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_vo_cida', 'Você é o amigo de Itabuna, né? Do menino de cachinhos.'), F('c2_vo_cida', 'Quando ele chegou aqui, sentava na minha calçada todo fim de tarde. Sozinho.', 'sad'), F('c2_vo_cida', 'Uma vez perguntei se ele tinha amigos. Ele disse: "tinha dois. Os melhores do mundo."', 'sad'), F('daroca', '...Tinha.', 'sad')]
        : [F('c2_vo_cida', 'Vai com Deus, menino. E não desiste dele.', 'friend')],
      fim: (st) => { if (st === 'nova') { marca('pista_vocida'); pistas(); } } },
    { id: 'larissa', quem: 'c2_larissa', nome: 'Larissa da Biblioteca', cena: 31, x: 3400, pista: true,
      estado: () => (tem('pista_larissa') ? 'ok' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_larissa', 'Psiu, biblioteca! ...Ah, você procura o Jorge?'), F('c2_larissa', 'Ele vinha aqui ler sobre Itabuna. Pegou o mesmo livro de história do cacau umas cinco vezes.'), F('c2_larissa', 'Na última página tem um desenho de três bonequinhos. Não fui eu que fiz.', 'sad')]
        : [F('c2_larissa', 'Boa leitura. E boa sorte com o seu amigo.', 'friend')],
      fim: (st) => { if (st === 'nova') { marca('pista_larissa'); pistas(); } } },
    { id: 'carlinhos', quem: 'c2_carlinhos', nome: 'Carlinhos', cena: 20, x: 2080, pista: true,
      estado: () => (tem('pista_carlinhos') ? 'ok' : 'nova'),
      falas: (st) => st === 'nova' ? [F('c2_carlinhos', 'Eu andava com o Jorge antes do Fred aparecer. Depois, ele só andava grudado no Fred.', 'sad'), F('c2_carlinhos', 'Mas sabe? Ele falava de Itabuna quando achava que ninguém tava ouvindo.'), F('c2_carlinhos', 'Ele não admite. Mas sente falta. Muita.', 'sad')]
        : [F('c2_carlinhos', 'Se você conseguir falar com ele... fala que eu mandei um oi.', 'sad')],
      fim: (st) => { if (st === 'nova') { marca('pista_carlinhos'); pistas(); } } }
  ];
  function pistas() { const n = ['pista_vocida', 'pista_larissa', 'pista_carlinhos'].filter(tem).length; if (n >= 3 && !tem('pistas_ok')) { marca('pistas_ok'); ganhar(90); api.item('AS 3 PISTAS DO JORGE · +90 MOEDAS'); api.sfx('fanfarra'); } else api.aviso(`PISTA DO JORGE (${n}/3)`); }
  const disponivel = () => { const S = api.S(); return !!S.flags.embarcou && !['taxi1', 'lurdes'].includes(S.passo); };

  /* ---------- a lojinha do Tio do Picolé ---------- */
  function lojaPicole() {
    const ops = [
      { t: `Picolé Sigma (cura 40) · ● 15`, preco: 15, f: () => { api.P.hp = Math.min(vidaMax(), api.P.hp + 40); api.aviso('+40 DE VIDA · SIGMA DEMAIS'); } },
      { t: `Picolé Mega Chad (cura tudo) · ● 40`, preco: 40, f: () => { api.P.hp = vidaMax(); api.aviso('VIDA CHEIA · CHAD SUPREMO'); } },
      { t: tem('biscoito_cao') || tem('cao') ? 'Biscoito do cachorro (já comprado)' : 'Biscoito de polvilho pro cachorro · ● 10', preco: 10, f: () => { marca('biscoito_cao'); api.item('BISCOITO DE POLVILHO'); }, usado: tem('biscoito_cao') || tem('cao') },
      { t: 'Só olhando', sair: true }];
    api.escolher('TIO DO PICOLÉ', 'Picolé com nome de meme! O que vai ser?', ops.map((o) => ({ t: o.t, ok: true, f: o })), (o) => {
      const p = o?.f; if (!p || p.sair || p.usado) return; if (moedas() < p.preco) { api.aviso('Moedas não dão. Derrote uns inimigos!'); return; } ganhar(-p.preco); p.f(); api.sfx('plim'); });
  }

  /* ---------- corrida de skate do Nando ---------- */
  function iniciarCorrida() { corrida = { t: 0, lim: 26, ida: false, nando: 3520, fim: 4700, volta: 3520, fase: 'contagem', cont: 3 }; api.aviso('CORRIDA! ATÉ A BANDEIRA E DE VOLTA'); }
  function atualizaCorrida(dt) {
    const c0 = corrida, P = api.P; if (api.cena() !== 14) { corrida = null; api.aviso('A corrida foi cancelada.'); return; }
    if (c0.fase === 'contagem') { c0.cont -= dt; if (c0.cont <= 0) { c0.fase = 'corre'; api.sfx('buzina'); } return; }
    c0.t += dt; const vN = 300; if (!c0.nIda) { c0.nando += vN * dt; if (c0.nando >= c0.fim) c0.nIda = true; } else c0.nando = Math.max(c0.volta, c0.nando - vN * dt);
    if (!c0.ida && P.x >= c0.fim - 20) { c0.ida = true; api.sfx('plim'); api.aviso('BANDEIRA! AGORA VOLTA!'); }
    if (c0.ida && P.x <= c0.volta + 30) { corrida = null; marca('skate'); api.item('VOCÊ GANHOU! SKATE · ANDA MAIS RÁPIDO'); api.sfx('fanfarra'); return; }
    if (c0.nIda && c0.nando <= c0.volta + 1 || c0.t > c0.lim) { corrida = null; api.aviso('O Nando chegou primeiro! Fala com ele de novo pra revanche.'); api.sfx('risada'); }
  }

  /* ---------- minijogo de ritmo da Bia (no palco do teatro) ---------- */
  const CORES = ['#e85ad0', '#5ae0d0', '#ffe23a', '#5a9aff'];
  function iniciarRitmo() {
    const el = document.createElement('div'); el.className = 'c2-ritmo'; api.tela().appendChild(el); const cv = document.createElement('canvas'); cv.width = 480; cv.height = 270; el.appendChild(cv);
    if (!document.getElementById('c2RitmoCss')) { const st = document.createElement('style'); st.id = 'c2RitmoCss'; st.textContent = `.c2-ritmo{position:absolute;inset:0;z-index:20;background:#05030a;touch-action:none}.c2-ritmo canvas{width:100%;height:100%;image-rendering:pixelated;display:block}`; document.head.appendChild(st); }
    const LANES = ['ArrowLeft', 'ArrowDown', 'ArrowUp', 'ArrowRight'], ALT = ['KeyD', 'KeyF', 'KeyJ', 'KeyK'], N = 28, BPM = 112, beat = 60 / BPM;
    const notas = []; for (let i = 0; i < N; i++) notas.push({ t: 2 + i * beat * (i % 7 === 6 ? 1 : .75 + (i % 3 === 0 ? .25 : 0)), lane: [0, 2, 1, 3, 0, 1, 2, 3, 3, 0, 2, 1][i % 12], ok: null });
    for (let i = 1; i < N; i++) notas[i].t = Math.max(notas[i].t, notas[i - 1].t + beat * .75);
    ritmo = { t: 0, notas, acertos: 0, combo: 0, msg: '', msgT: 0, fim: notas[N - 1].t + 2, el, c: cv.getContext('2d') };
    const tecla = (e) => { const i = LANES.indexOf(e.code) >= 0 ? LANES.indexOf(e.code) : ALT.indexOf(e.code); if (i < 0 || !ritmo) return; e.preventDefault(); e.stopImmediatePropagation(); bater(i); };
    const toque = (e) => { const r = cv.getBoundingClientRect(); bater(clamp(Math.floor((e.clientX - r.left) / r.width * 4), 0, 3)); };
    ritmo.sair = () => { removeEventListener('keydown', tecla, true); el.remove(); }; addEventListener('keydown', tecla, true); cv.addEventListener('pointerdown', toque);
    api.pausar(true);
  }
  function bater(i) {
    const r = ritmo; let best = null, d = .26; for (const n of r.notas) if (n.ok === null && n.lane === i && Math.abs(n.t - r.t) < d) { d = Math.abs(n.t - r.t); best = n; }
    if (best) { best.ok = d < .12 ? 2 : 1; r.acertos += best.ok === 2 ? 1 : .7; r.combo++; r.msg = best.ok === 2 ? 'PERFEITO!' : 'BOM!'; try { window.Roteiro?.sfx?.('plim'); } catch (e) {} } else { r.combo = 0; r.msg = 'ERROU!'; } r.msgT = .5; r.lane = i; r.laneT = .15;
  }
  function atualizaRitmo(dt) {
    const r = ritmo, c = r.c, W = 480, H = 270; r.t += dt; r.msgT -= dt; r.laneT = (r.laneT || 0) - dt;
    for (const n of r.notas) if (n.ok === null && r.t - n.t > .26) { n.ok = 0; r.combo = 0; r.msg = 'ERROU!'; r.msgT = .4; }
    if (Math.floor(r.t / (60 / 112)) !== r.ultBat) { r.ultBat = Math.floor(r.t / (60 / 112)); try { window.Roteiro?.sfx?.('tambor'); } catch (e) {} }
    // palco: cortina, luzes coloridas girando, plateia e a Bia cantando
    c.fillStyle = '#12081e'; c.fillRect(0, 0, W, H); for (let x = 0; x < W; x += 6) { c.fillStyle = x % 12 ? '#6a1a2a' : '#5a1424'; c.fillRect(x, 0, 6, 40); c.fillRect(x < 80 || x > 400 ? x : -10, 0, 6, x < 80 || x > 400 ? 200 : 0); }
    for (let k = 0; k < 4; k++) { const a = Math.sin(r.t * 1.5 + k * 1.7) * .5, x0 = 80 + k * 106; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .18; c.fillStyle = ['#ff5ad0', '#5ae0ff', '#ffe23a', '#7a5aff'][k]; c.beginPath(); c.moveTo(x0, 20); c.lineTo(x0 + 10, 20); c.lineTo(x0 + 60 + a * 160, 210); c.lineTo(x0 - 50 + a * 160, 210); c.fill(); c.restore(); }
    c.fillStyle = '#3a2418'; c.fillRect(0, 200, W, 70); c.fillStyle = '#5a3a24'; c.fillRect(0, 200, W, 4);
    try { window.Art.drawCharacter(c, 'c2_bia', 150, 200, { frame: r.t * 2, facing: 1, scale: 1.3, moving: true, grounded: true }); window.Art.drawCharacter(c, 'daroca', 330, 200 - Math.abs(Math.sin(r.t * 5.6)) * 6, { frame: r.t * 2, facing: -1, scale: 1.3, moving: r.laneT > 0, attack: r.laneT > 0, attackType: 'fart', grounded: true }); } catch (e) {}
    for (let k = 0; k < 22; k++) { const x = 10 + k * 22, y = 254 + Math.abs(Math.sin(r.t * 4 + k)) * -4; c.fillStyle = '#0a0610'; c.beginPath(); c.arc(x, y, 9, 0, TAU); c.fill(); c.fillRect(x - 10, y + 4, 20, 14); if ((k + Math.floor(r.t * 2)) % 5 === 0) { c.fillRect(x + 6, y - 14, 3, 10); } }
    // trilhas das notas
    const lx = (i) => 186 + i * 28, ly = 176;
    for (let i = 0; i < 4; i++) { c.fillStyle = 'rgba(10,6,16,.55)'; c.fillRect(lx(i) - 11, 16, 22, 170); c.fillStyle = r.laneT > 0 && r.lane === i ? CORES[i] : '#3a2a4a'; c.fillRect(lx(i) - 12, ly - 2, 24, 4); }
    const seta = (x, y, i, cor) => { c.save(); c.translate(x, y); c.rotate([-Math.PI / 2, Math.PI, 0, Math.PI / 2][i] + Math.PI / 2); c.fillStyle = '#0a0610'; c.beginPath(); c.moveTo(0, -10); c.lineTo(10, 2); c.lineTo(4, 2); c.lineTo(4, 10); c.lineTo(-4, 10); c.lineTo(-4, 2); c.lineTo(-10, 2); c.fill(); c.fillStyle = cor; c.beginPath(); c.moveTo(0, -7); c.lineTo(7, 1); c.lineTo(2, 1); c.lineTo(2, 8); c.lineTo(-2, 8); c.lineTo(-2, 1); c.lineTo(-7, 1); c.fill(); c.restore(); };
    for (let i = 0; i < 4; i++) seta(lx(i), ly, i, '#5a4a6a');
    for (const n of r.notas) { if (n.ok) continue; const y = ly - (n.t - r.t) * 120; if (y < 10 || y > 200) continue; seta(lx(n.lane), y, n.lane, n.ok === 0 ? '#5a3a3a' : CORES[n.lane]); }
    const tx = window.CampanhaCamadas?.kit?.pxText; const pct = Math.round(r.acertos / r.notas.length * 100);
    if (tx) { tx(c, 'SHOW DA BIA · ' + pct + '%', 240, 4, '#ffe9a8', { sombra: '#000' }); if (r.combo > 2) tx(c, 'COMBO ' + r.combo, 240, 194, '#ffd24a', { s: 2, sombra: '#000' }); if (r.msgT > 0) tx(c, r.msg, 240, 120, r.msg === 'ERROU!' ? '#ff5a4a' : '#7af07a', { s: 3, sombra: '#000' }); tx(c, '← ↓ ↑ →  OU  D F J K  (OU TOQUE NAS TRILHAS)', 240, 262, '#c8b8d8'); }
    if (r.t > r.fim) { const ok = pct >= 65; ritmo.sair(); ritmo = null; api.pausar(false);
      if (ok) { marca('moral'); api.item(`SHOW NOTA ${pct}! MORAL · +15% DE FORÇA`); api.sfx('fanfarra'); } else { api.aviso(`Nota ${pct}%. A Bia pediu bis: fala com ela de novo!`); api.sfx('risada'); } }
  }

  /* ---------- o cachorro companheiro ---------- */
  function atualizaCao(dt, inimigos) {
    const P = api.P; if (!tem('cao')) { cao = null; return; } if (!cao || cao.cena !== api.cena()) cao = { x: P.x - 50, cena: api.cena(), alvo: null, cd: 1, mordeT: 0, dir: 1 };
    cao.cd -= dt; cao.mordeT -= dt; const vivos = (inimigos || []).filter((e) => e.hp > 0 && e.onDano && Math.abs(e.x - P.x) < 340 && (e.y ?? FLOOR) > FLOOR - 40);
    if (!cao.alvo || cao.alvo.hp <= 0 || !vivos.includes(cao.alvo)) cao.alvo = vivos.sort((a, b) => Math.abs(a.x - cao.x) - Math.abs(b.x - cao.x))[0] || null;
    const destino = cao.alvo ? cao.alvo.x - Math.sign(cao.alvo.x - cao.x) * 18 : P.x - P.facing * 46, dx = destino - cao.x;
    if (Math.abs(dx) > 6) { cao.x += Math.sign(dx) * Math.min(Math.abs(dx), (cao.alvo ? 340 : Math.abs(dx) > 160 ? 420 : 220) * dt); cao.dir = Math.sign(dx); }
    if (cao.alvo && Math.abs(cao.alvo.x - cao.x) < 30 && cao.cd <= 0) { cao.cd = 2.4; cao.mordeT = .3; cao.alvo.onDano(35, 'mordida'); /* na escala do dano da campanha 1 */ try { window.Roteiro?.sfx?.('risada'); } catch (e) {} }
  }

  /* ---------- interface com o jogo ---------- */
  function candidatos(cena) {
    if (!disponivel()) return []; const out = [];
    for (const a of ALIADOS) { if (a.cena !== cena || (a.cao && tem('cao'))) continue; const st = a.estado();
      out.push({ tipo: 'aliado', x: a.x, rotulo: (a.loja ? 'COMPRAR COM ' : a.oficina && st !== 'entregar' ? 'OFICINA DO ' : 'FALAR COM ') + a.nome.toUpperCase(), botao: a.loja ? 'COMPRAR' : a.oficina && st !== 'entregar' ? 'OFICINA' : 'FALAR',
        acao: () => { const fl = a.falas(st); if (fl) api.conversa({ id: 'al_' + a.id, quem: a.quem, x: a.x, falas: fl, fim: () => a.fim(st) }); else a.fim(st); } }); }
    for (const it of ITENS) if (it.cena === cena && it.quando() && !pegou(it.id)) out.push({ tipo: 'item', x: it.x, rotulo: 'PEGAR: ' + it.nome, botao: 'PEGAR', acao: () => { marca('item_' + it.id); api.item(it.id.startsWith('mapa') ? `PEDAÇO DO MAPA (${pedacos()}/3)` : it.nome); api.sfx('plim'); } });
    if (cena === 14 && corrida) return out.filter((o) => o.tipo !== 'aliado');
    return out;
  }
  function atualizar(dt, inimigos) { if (!api) return; t += dt; if (corrida) atualizaCorrida(dt); if (ritmo) atualizaRitmo(dt); atualizaCao(dt, inimigos); }
  function desenhar(c, cena) {
    if (!api || !disponivel()) return; const P = api.P, R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); };
    if (cena === 13) ferroVelho(c);
    for (const a of ALIADOS) { if (a.cena !== cena || (a.cao && tem('cao'))) continue; const st = a.estado();
      try { window.Art.drawCharacter(c, a.quem, a.x, FLOOR, { frame: t + a.x, facing: P.x < a.x ? -1 : 1, grounded: true, emotion: a.cao && st !== 'ok' ? 'sad' : undefined }); } catch (e) {}
      const marcaTxt = st === 'nova' ? '!' : st === 'entregar' ? '?' : a.loja || a.oficina ? '●' : ''; if (marcaTxt) { const y = FLOOR - (a.cao ? 52 : 96) + Math.sin(t * 4 + a.x) * 3, cor = marcaTxt === '!' ? '#ffd24a' : marcaTxt === '?' ? '#7af07a' : '#e8c66a'; R(a.x - 8, y - 18, 16, 20, '#1c1408'); R(a.x - 6, y - 16, 12, 16, cor); window.CampanhaCamadas?.kit?.pxText?.(c, marcaTxt, a.x, y - 13, '#1c1408', { s: 2 }); } }
    for (const it of ITENS) if (it.cena === cena && it.quando() && !pegou(it.id)) { const y = FLOOR - 20 + Math.sin(t * 3 + it.x) * 4; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .35 + Math.sin(t * 5) * .15; c.fillStyle = it.cor; c.beginPath(); c.arc(it.x, y, 18, 0, TAU); c.fill(); c.restore();
      if (it.id === 'radio') { R(it.x - 10, y - 8, 20, 14, '#1c1408'); R(it.x - 9, y - 7, 18, 12, '#c43c3a'); R(it.x - 7, y - 5, 7, 7, '#2a2a2a'); R(it.x + 2, y - 4, 5, 2, '#e8c24c'); R(it.x + 6, y - 14, 1, 7, '#9aa0a6'); }
      else if (it.id === 'pneu') { c.strokeStyle = '#1c1c1c'; c.lineWidth = 4; c.beginPath(); c.arc(it.x, y, 10, 0, TAU); c.stroke(); c.lineWidth = 1; }
      else { R(it.x - 9, y - 7, 18, 14, '#5a3a14'); R(it.x - 8, y - 6, 16, 12, '#f2e2b8'); R(it.x - 5, y - 3, 8, 1, '#a87a4a'); R(it.x - 2, y, 6, 1, '#c43c3a'); } }
    if (cao && cao.cena === cena) { try { window.Art.drawCharacter(c, 'c2_biscoito', cao.x, FLOOR, { frame: t * 1.6, facing: cao.dir, moving: true, grounded: true, attack: cao.mordeT > 0 }); } catch (e) {} if (cao.mordeT > 0) window.CampanhaCamadas?.kit?.pxText?.(c, 'NHAC!', cao.x, FLOOR - 50, '#ffd24a', { sombra: '#000' }); }
    if (corrida && cena === 14) { // bandeira, Nando no skate e o relógio
      R(corrida.fim - 2, FLOOR - 90, 4, 90, '#5a5e62'); for (let k = 0; k < 4; k++) for (let j = 0; j < 3; j++) R(corrida.fim + 2 + k * 6, FLOOR - 90 + j * 6, 6, 6, (k + j) % 2 ? '#1c1c1c' : '#f6f6f0');
      try { window.Art.drawCharacter(c, 'c2_nando', corrida.nando, FLOOR - 6, { frame: t, facing: corrida.nIda ? -1 : 1, grounded: true }); } catch (e) {} R(corrida.nando - 14, FLOOR - 6, 28, 4, '#d9b347'); R(corrida.nando - 10, FLOOR - 2, 4, 3, '#1c1c1c'); R(corrida.nando + 6, FLOOR - 2, 4, 3, '#1c1c1c'); }
  }
  function ferroVelho(c) { // a fachada do ferro-velho do Gugu, no fim da rua da pensão
    const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); }, x0 = 3930;
    R(x0, FLOOR - 120, 260, 120, '#4a5058'); for (let x = 0; x < 260; x += 4) R(x0 + x, FLOOR - 120, 2, 120, x % 8 ? '#5a6068' : '#3a4048'); for (let i = 0; i < 30; i++) R(x0 + (i * 37) % 250, FLOOR - 118 + (i * 23) % 100, 6 + i % 8, 3 + i % 5, '#7a4224');
    R(x0 + 70, FLOOR - 80, 120, 80, '#1c1612'); R(x0 + 74, FLOOR - 76, 112, 76, '#2a2420'); for (let y = FLOOR - 74; y < FLOOR; y += 6) R(x0 + 74, y, 112, 2, '#3a3430');
    R(x0 + 20, FLOOR - 150, 220, 30, '#1c1408'); R(x0 + 22, FLOOR - 148, 216, 26, '#c8a24a'); window.CampanhaCamadas?.kit?.pxText?.(c, 'FERRO-VELHO DO GUGU', x0 + 130, FLOOR - 143, '#3a1a08', { s: 2 });
    for (let k = 0; k < 3; k++) { c.fillStyle = '#121212'; c.beginPath(); c.ellipse(x0 + 30, FLOOR - 6 - k * 12, 22, 7, 0, 0, TAU); c.fill(); } R(x0 + 200, FLOOR - 30, 50, 30, '#7a2a24'); R(x0 + 204, FLOOR - 28, 20, 10, '#3a4a5a');
    if (Math.floor(t * 6) % 7 === 0) for (let k = 0; k < 6; k++) R(x0 + 130 + Math.random() * 20, FLOOR - 40 - Math.random() * 20, 2, 2, '#ffe23a');
  }
  function velocidade() { return tem('bike') ? 1.4 : tem('skate') ? 1.2 : 1; }
  function vidaMax() { return 100 + (X().lurdes === 'feita' ? 20 : 0); }
  function forca() { return tem('moral') ? 1.15 : 1; }
  function missoes() {
    if (!api) return []; const x = X(), st = (k) => (x[k] === 'feita' ? 'feita' : x[k] === 'ativa' ? 'ativa' : 'nova'), L = [];
    L.push(['O radinho da Dona Lurdes', st('lurdes'), 'Ache o radinho na avenida (Monumento ao Índio).']);
    L.push(['O mapa verdadeiro da Mel', st('mel'), `Pedaços: ${pedacos()}/3 (fim do centro, fim da feira e beira da lagoa).`]);
    L.push(['Um amigo caramelo', tem('cao') ? 'feita' : x.cao_visto ? 'ativa' : 'nova', 'Compre biscoito de polvilho com o Tio do Picolé (feira) e dê ao Biscoito (rua da pensão).']);
    L.push(['Corrida do Nando', tem('skate') ? 'feita' : 'nova', 'Vença a corrida de skate no centro.']);
    L.push(['A bicicleta do Juninho', st('juninho'), `Corrente com o Gugu ${tem('corrente') ? '✔' : ''} · pneu na rodoviária ${pegou('pneu') ? '✔' : ''}.`]);
    L.push(['O show da Bia', tem('moral') ? 'feita' : 'nova', 'Dance arrocha no palco do teatro.']);
    L.push(['As pistas do Jorge', tem('pistas_ok') ? 'feita' : ['pista_vocida', 'pista_larissa', 'pista_carlinhos'].some(tem) ? 'ativa' : 'nova', 'Vó Cida (rua da pensão), Larissa (UESB) e Carlinhos (shopping).']);
    return L;
  }
  function alvos(cena) { if (!api || X().mel !== 'feita') return []; return ALIADOS.filter((a) => a.cena === cena && ['nova', 'entregar'].includes(a.estado())).map((a) => a.x).concat(ITENS.filter((i) => i.cena === cena && i.quando() && !pegou(i.id)).map((i) => i.x)); }
  window.CampanhaAliados = Object.freeze({ ligar: (a) => { api = a; cao = null; corrida = null; }, candidatos, atualizar, desenhar, velocidade, vidaMax, forca, missoes, alvos, ocupado: () => !!ritmo, correndo: () => corrida && { t: corrida.t, lim: corrida.lim, cont: corrida.cont, fase: corrida.fase } });
})();
