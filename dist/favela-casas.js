/* Favela do Reeis (cena 5) · casas abertas
   Três casas da favela têm a porta destrancada: chegue na porta e aperte E (ou o botão de falar).
   - Casa da Dona Dalva (rosa, perto da entrada), barraco do Seu Tião (rosa, no meio) e casa da Kelly (laranja, lá em cima).
   - Lá dentro é um cômodo pequeno no estilo da pensão, mas sem a borda de recorte: as pontas do cenário
     escurecem em degradê de pixel até o preto.
   - Cada morador conta as lendas do Reeis; cada conversa conta uma diferente (o índice fica no save, q.lendasReeis).
   Usa as salas da campanha 1 (WorldData.doors + enterRoom do game.js). Nada muda na história principal. */
(() => {
  'use strict';
  if (window.FavelaCasas) return;
  const CENA = 5;
  const ROBLOX = () => /Roblox/i.test(navigator.userAgent || '') || !!window.DAROCA_ROBLOX;
  const CASAS = {
    casa_dalva: { x: 510, nome: 'Casa da Dona Dalva', porta: 'CASA DA DONA DALVA', morador: 'dona_dalva', npc: 'Dona Dalva' },
    casa_tiao: { x: 3867, nome: 'Barraco do Seu Tião', porta: 'BARRACO DO SEU TIÃO', morador: 'seu_tiao', npc: 'Seu Tião' },
    casa_kelly: { x: 5967, nome: 'Casa da Kelly', porta: 'CASA DA KELLY', morador: 'kelly_favela', npc: 'Kelly' }
  };
  const ehCasa = (id) => Object.prototype.hasOwnProperty.call(CASAS, id);

  /* ---------- moradores (no desenhista detalhado da Campanha 2) ---------- */
  const GENTE = {
    dona_dalva: { name: 'Dona Dalva', skin: '#7a4a2e', shade: '#55331f', build: 'belly', h: .86, top: '#d8708e', topKind: 'apron', apron: '#f2e6c8', skirt: '#4a5a8a', hair: { style: 'bun', color: '#e8e4dc', gray: '#c8c2b8' }, glasses: '#4a3a2a', pose: 'talk' },
    seu_tiao: { name: 'Seu Tião', skin: '#8a5a3a', shade: '#62402a', build: 'slim', h: .9, top: '#e8e8e0', topKind: 'tank', pants: '#3a5a7a', hat: { kind: 'cap', color: '#2a6a3a', band: '#f2d24a' }, hair: { style: 'short', color: '#d8d4cc' }, mustache: '#d8d4cc', pose: 'relaxed' },
    kelly_favela: { name: 'Kelly', skin: '#6a4028', shade: '#4a2c1a', build: 'slim', h: .88, top: '#f24a8a', skirt: '#1a1a24', hair: { style: 'long', color: '#1a1210' }, earrings: '#f2d24a', pose: 'hips' }
  };
  const registrar = () => { const CP = window.CampanhaPersonagens; if (!CP?.registrar) return false; for (const [id, sp] of Object.entries(GENTE)) CP.registrar(id, sp, 'Morador (Favela do Reeis)'); return true; };
  if (!registrar()) addEventListener('DOMContentLoaded', registrar, { once: true });

  // portas na lista de salas do jogo
  // (o WorldData vem congelado: troca por uma cópia com as portas novas, antes do game.js carregar)
  const porPortas = () => {
    const W = window.WorldData; if (!W?.doors) return false;
    const novas = Object.entries(CASAS).filter(([id]) => !W.doors.some((d) => d.id === id)).map(([id, c]) => Object.freeze({ id, scene: CENA, x: c.x, label: c.porta, width: 960, exitX: 90, teacherX: 640, casa: true }));
    if (!novas.length) return true;
    try { window.WorldData = Object.freeze({ ...W, doors: Object.freeze([...W.doors, ...novas]) }); } catch (e) { return false; }
    return window.WorldData.doors.length === W.doors.length + novas.length;
  };
  if (!porPortas()) addEventListener('DOMContentLoaded', porPortas, { once: true });

  /* ---------- as lendas do Reeis (uma por conversa) ---------- */
  const DR = 'Da Roça';
  const LENDAS = {
    casa_dalva: [
      (n) => [{ name: n, text: 'Senta, meu filho. Quer café? Então escuta: o Reeis assaltou o banco da avenida num domingo de chuva.' },
        { name: n, text: 'E dividiu TUDO com a favela. Cada casa ganhou um envelope com laço de fita, até a minha.' },
        { name: DR, text: 'E a polícia, Dona Dalva?' },
        { name: n, text: 'Procuraram três semanas. Ele tava aqui, comendo o meu feijão. Guardo o envelope dentro da Bíblia até hoje.' }],
      (n) => [{ name: n, text: 'Quando o gás subiu, o Reeis parou o caminhão do gás bem na entrada do morro.' },
        { name: n, text: '"Botijão é de quem cozinha", ele disse. Desceu um por casa. Nem as panelas acreditaram.' },
        { name: DR, text: 'Esse homem pensava em tudo.' }],
      (n) => [{ name: n, text: 'No Natal ele desceu a ladeira vestido de Papai Noel, com um saco cheio de brinquedo.' },
        { name: n, text: 'Só que o saco era malote de carro-forte. Os meninos ganharam bicicleta e eu ganhei um ventilador.' },
        { name: n, text: 'Esse aí que tá girando. Funciona até hoje!' }],
      (n) => [{ name: n, text: 'Aqui ninguém mexe com velho, com criança nem com cachorro de rua. Regra do Reeis.' },
        { name: n, text: 'Quem quebrou a regra uma vez foi parar pendurado na caixa d\'água pela cueca. De dia, pra todo mundo ver.' },
        { name: DR, text: 'Anotado, Dona Dalva. Respeito acima de tudo.' }]
    ],
    casa_tiao: [
      (n) => ROBLOX()
        ? [{ name: n, text: 'Conhece o Dedé Fumacinha? Uma noite o Reeis trouxe tanto doce de leite pro Dedé que ele comeu tudo e caiu duro no chão da laje.' },
          { name: n, text: 'Ficou três horas olhando pro céu, jurando que as nuvens eram algodão doce.' },
          { name: n, text: 'Quando acordou, pediu mais. O Reeis só falou: "Fecha a conta, Dedé."' }]
        : [{ name: n, text: 'Conhece o Dedé Fumacinha? Uma noite o Reeis trouxe tanta maconha pro Dedé que ele deu duas tragadas e caiu duro no chão da laje.' },
          { name: n, text: 'Ficou três horas olhando pro céu, jurando que as nuvens eram algodão doce.' },
          { name: n, text: 'Quando acordou, pediu mais. O Reeis só falou: "Fecha a conta, Dedé."' }],
      (n) => [{ name: n, text: 'Uma vez a viatura cercou o morro inteiro. Sabe o que o Reeis fez? Fugiu pulando de laje em laje...' },
        { name: n, text: '...com uma geladeira nas costas! Era da Dona Dalva, ele tava devolvendo do conserto.' },
        { name: DR, text: 'E a geladeira?' },
        { name: n, text: 'Chegou gelando. A polícia é que chegou suando.' }],
      (n) => [{ name: n, text: 'O Reeis empinou a moto da escadaria do beco até a pracinha lá de cima. Duzentos degraus.' },
        { name: n, text: 'A moto chegou sem pneu. Ele chegou rindo e ainda deu carona pra minha sogra na volta.' }],
      (n) => [{ name: n, text: 'Dizem que ele ganhou do Bigodon no dominó valendo o comando da rua.' },
        { name: n, text: 'Bateu de carroça na última pedra. O Bigodon chorou e o Reeis pagou a cerveja dele, pra não humilhar.' },
        { name: DR, text: 'Respeito até no dominó.' }]
    ],
    casa_kelly: [
      (n) => [{ name: n, text: 'Quando cortaram a luz do morro, o Reeis subiu no poste e religou a favela inteira. No escuro!' },
        { name: n, text: 'Com uma mão só, porque a outra tava segurando o espetinho. Nem derrubou a farofa.' }],
      (n) => [{ name: n, text: 'O baile de quinta é de graça porque o Reeis pagou o som pro ano todo.' },
        { name: DR, text: 'Pagou com o quê?' },
        { name: n, text: 'Melhor você não perguntar, Da Roça. Só dança.' }],
      (n) => [{ name: n, text: 'Uma madame humilhou a Dona Dalva na feira. No outro dia a bolsa dela sumiu.' },
        { name: n, text: 'Voltou vazia, com um bilhete do Reeis dentro: "Educação também é de graça."' }],
      (n) => [{ name: n, text: 'O Reeis nunca terminou a escola, mas pagou a formatura da minha turma inteira.' },
        { name: n, text: 'Teve DJ, salgadinho e fumaça de gelo seco. Eu entrei de vestido rosa com o nome dele bordado.' },
        { name: DR, text: 'Esse cara é lenda mesmo.' },
        { name: n, text: 'Lenda não. Aqui ele é o prefeito que ninguém votou e todo mundo respeita.' }]
    ]
  };
  function falar(id, q, api) {
    const c = CASAS[id]; if (!c) return false;
    q.lendasReeis = q.lendasReeis && typeof q.lendasReeis === 'object' ? q.lendasReeis : {};
    const lista = LENDAS[id], i = (Number(q.lendasReeis[id]) || 0) % lista.length;
    q.lendasReeis[id] = i + 1;
    api?.say?.(lista[i](c.npc));
    api?.save?.();
    return true;
  }

  /* ---------- desenho (pixels de arte 480 x 270, chão em y = 220, ampliado 2x) ---------- */
  const LW = 480, LH = 270, GY = 220;
  const hsh = (n) => { const x = Math.sin(n * 12.9898 + 78.233) * 43758.5453; return x - Math.floor(x); };
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const mk = (w, h) => { const cv = document.createElement('canvas'); cv.width = w; cv.height = h; const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; return [cv, c]; };
  const disco = (c, x, y, r, cor) => { for (let yy = -r; yy <= r; yy++) { const w = Math.round(Math.sqrt(Math.max(0, r * r - yy * yy))); R(c, x - w, y + yy, w * 2 + 1, 1, cor); } };
  const glow = (c, x, y, r, cor, a) => { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = a; const g = c.createRadialGradient(x, y, 0, x, y, r); g.addColorStop(0, cor); g.addColorStop(1, 'rgba(0,0,0,0)'); c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore(); };
  const noite = () => { try { return Math.max(0, Math.min(1, Number(window.DayTime?.state?.()?.night) || 0)); } catch (e) { return 0; } };

  // reboco pintado com manchas, umidade e pontinhos (textura de parede de favela)
  function parede(c, x0, y0, x1, y1, base, claro, escuro, seed) {
    R(c, x0, y0, x1 - x0, y1 - y0, base);
    for (let y = y0; y < y1; y += 2) for (let x = x0 + ((y / 2) % 2); x < x1; x += 2) { const h = hsh(x * 3.1 + y * 7.7 + seed); if (h > .93) R(c, x, y, 1, 1, claro); else if (h < .05) R(c, x, y, 1, 1, escuro); }
    // mancha de umidade embaixo e reboco caindo
    for (let x = x0; x < x1; x += 3) { const h = 6 + hsh(x + seed) * 12; c.globalAlpha = .18; R(c, x, y1 - h, 3, h, escuro); c.globalAlpha = 1; }
    // reboco caído mostrando o tijolo: mancha irregular com borda de reboco quebrado
    for (let k = 0; k < 4; k++) {
      const bx = x0 + 70 + hsh(k * 9 + seed) * (x1 - x0 - 160), by = y0 + 24 + hsh(k * 5 + seed) * (y1 - y0 - 80);
      const larg = [3, 5, 6, 5, 3];
      for (let j = 0; j < larg.length; j++) {
        const w = larg[j] * 5, ox = bx - w / 2 + (hsh(j + k * 3 + seed) - .5) * 4;
        R(c, ox - 1, by + j * 4 - 1, w + 2, 6, escuro);
        for (let i = 0; i < larg[j]; i++) { R(c, ox + i * 5 + (j % 2) * 2, by + j * 4, 4, 3, (i + j) % 3 ? '#a8634a' : '#b8735a'); R(c, ox + i * 5 + (j % 2) * 2, by + j * 4, 4, 1, '#c88a6a'); }
      }
      R(c, bx - 12, by - 2, 24, 1, claro);
    }
  }
  function piso(c, cor1, cor2, junta) { // lajota de cerâmica em perspectiva
    R(c, 0, GY, LW, LH - GY, cor1);
    const linhas = [GY, GY + 5, GY + 11, GY + 19, GY + 29, GY + 41, LH];
    for (let r = 0; r < linhas.length - 1; r++) { R(c, 0, linhas[r], LW, 1, junta); const passo = 18 + r * 8; for (let x = (r % 2) * passo / 2; x < LW; x += passo) { R(c, x, linhas[r], 1, linhas[r + 1] - linhas[r], junta); if ((x / passo + r) % 3 < 1) R(c, x + 1, linhas[r] + 1, passo - 1, linhas[r + 1] - linhas[r] - 1, cor2); } }
    for (let x = 0; x < LW; x += 7) if (hsh(x) > .7) R(c, x, GY + 2 + hsh(x * 3) * 40, 2, 1, 'rgba(255,255,255,.18)');
  }
  function rodape(c, cor) { R(c, 0, GY - 4, LW, 4, cor); R(c, 0, GY - 4, LW, 1, 'rgba(255,255,255,.25)'); }
  function janela(c, x, y, w, h, n) { // janela com grade e a favela lá fora (dia ou noite)
    R(c, x - 3, y - 3, w + 6, h + 6, '#5a3a24'); R(c, x - 3, y + h + 1, w + 6, 2, '#7a5a3a');
    const g = c.createLinearGradient(0, y, 0, y + h); g.addColorStop(0, n > .5 ? '#0e1430' : '#6aa8e0'); g.addColorStop(1, n > .5 ? '#2a2a50' : '#bcdcf0'); c.fillStyle = g; c.fillRect(x, y, w, h);
    for (let i = 0; i < 6; i++) { const bx = x + i * w / 6, bh = 8 + hsh(i + x) * (h * .55); R(c, bx, y + h - bh, w / 6 + 1, bh, n > .5 ? '#3a2a3a' : ['#c86a4a', '#d89a6a', '#b85a3a'][i % 3]); if (n > .5 && hsh(i * 3 + x) > .4) R(c, bx + 3, y + h - bh + 3, 2, 2, '#ffd27a'); }
    for (let k = 1; k < 4; k++) R(c, x + k * w / 4, y, 1, h, '#2a2a2a');
    R(c, x, y + h / 2, w, 1, '#2a2a2a');
  }
  function quadro(c, x, y, w, h, moldura, fundo, desenho) { R(c, x - 2, y - 2, w + 4, h + 4, moldura); R(c, x, y, w, h, fundo); desenho && desenho(c, x, y, w, h); R(c, x - 2, y - 2, w + 4, 1, 'rgba(255,255,255,.3)'); }
  function lampada(c, x, ytop, comp, acesa, t) { R(c, x, ytop, 1, comp, '#2a2a2a'); R(c, x - 2, ytop + comp, 5, 3, '#8a8a7a'); disco(c, x, ytop + comp + 5, 3, acesa ? '#fff2b8' : '#c8c0a8'); }

  // ---- casa da Dona Dalva: sala com sofá de crochê, TV de tubo, santinhos, geladeira e ventilador
  function salaDalva(c) {
    parede(c, 0, 0, LW, GY - 4, '#e8b8b4', '#f6d0cc', '#c0908c', 11);
    R(c, 0, 128, LW, 3, '#b8746a'); for (let x = 0; x < LW; x += 12) R(c, x + 4, 129, 4, 1, '#f2d2a2'); // faixa pintada
    piso(c, '#c8a07a', '#b8906a', '#8a6a4a'); rodape(c, '#8a5a4a');
    janela(c, 300, 52, 64, 44, 0);
    // porta de saída (aberta, com luz da rua)
    R(c, 36, 120, 34, 100, '#4a2e1a'); R(c, 39, 123, 28, 97, '#f2e0b0'); R(c, 40, 124, 26, 96, '#ffeec8'); R(c, 66, 123, 6, 97, '#7a4a2a');
    // geladeira com ímãs
    R(c, 92, 120, 34, 100, '#e8ece8'); R(c, 92, 120, 34, 2, '#ffffff'); R(c, 92, 160, 34, 1, '#a8acaa'); R(c, 121, 132, 2, 20, '#8a8e8c'); R(c, 121, 166, 2, 30, '#8a8e8c');
    for (let k = 0; k < 6; k++) R(c, 96 + (k % 3) * 8, 126 + Math.floor(k / 3) * 10, 5, 5, ['#e84a4a', '#4a8ae8', '#f2c24a', '#4ac87a', '#c84ae8', '#f28a4a'][k]);
    R(c, 97, 138, 14, 12, '#f6f2e8'); R(c, 99, 141, 10, 1, '#4a4a4a'); R(c, 99, 144, 8, 1, '#4a4a4a');
    // estante com santinhos, porta-retrato do Reeis menino e TV de tubo
    R(c, 150, 150, 80, 70, '#6a4428'); R(c, 150, 150, 80, 3, '#8a5a34'); R(c, 152, 185, 76, 2, '#4a2e18');
    R(c, 160, 118, 48, 34, '#2a2a2a'); R(c, 162, 120, 44, 28, '#3a4a5a'); R(c, 204, 108, 1, 12, '#8a8a8a'); R(c, 196, 104, 1, 14, '#8a8a8a'); R(c, 170, 152, 30, 3, '#1a1a1a');
    for (let k = 0; k < 3; k++) { R(c, 158 + k * 22, 192, 14, 20, ['#e8c24c', '#8a2a2a', '#3a6a9a'][k]); R(c, 162 + k * 22, 196, 6, 8, '#f6e8d0'); }
    quadro(c, 238, 70, 26, 32, '#c8a24a', '#e8d8b8', (cc, x, y) => { disco(cc, x + 13, y + 12, 6, '#6a4028'); R(cc, x + 7, y + 6, 12, 4, '#1a1210'); R(cc, x + 6, y + 19, 14, 13, '#e8e4dc'); R(cc, x + 9, y + 11, 2, 2, '#1a1a1a'); R(cc, x + 15, y + 11, 2, 2, '#1a1a1a'); });
    R(c, 232, 104, 38, 6, '#f2e8d8'); for (let k = 0; k < 3; k++) { R(c, 238 + k * 10, 92, 6, 12, '#f2f0e8'); R(c, 239 + k * 10, 88, 4, 4, '#e8c8a8'); R(c, 240 + k * 10, 84, 2, 4, '#c8a24a'); } // santinhos
    R(c, 274, 64, 1, 50, '#c8a24a'); disco(c, 274, 62, 2, '#c8a24a'); // terço
    // calendário de borracharia
    R(c, 372, 70, 26, 36, '#f6f2e8'); R(c, 372, 70, 26, 12, '#d84a3a'); for (let k = 0; k < 15; k++) R(c, 375 + (k % 5) * 4, 86 + Math.floor(k / 5) * 5, 2, 2, '#4a4a4a');
    // sofá de crochê
    R(c, 300, 168, 110, 40, '#8a4a5a'); R(c, 300, 150, 110, 22, '#9a5a6a'); R(c, 296, 160, 12, 48, '#7a3a4a'); R(c, 402, 160, 12, 48, '#7a3a4a');
    for (let x = 304; x < 404; x += 6) for (let y = 152; y < 170; y += 6) if ((x + y) % 12 < 6) R(c, x, y, 3, 3, '#f2e8d8');
    R(c, 300, 208, 4, 12, '#4a2e18'); R(c, 406, 208, 4, 12, '#4a2e18');
    // mesinha com toalha e garrafa térmica
    R(c, 250, 190, 40, 4, '#f2f2e8'); for (let x = 250; x < 290; x += 4) R(c, x, 194, 2, 4, '#e84a6a'); R(c, 254, 198, 3, 22, '#6a4428'); R(c, 283, 198, 3, 22, '#6a4428');
    R(c, 262, 172, 8, 18, '#c84a3a'); R(c, 263, 170, 6, 3, '#f2f2e8'); R(c, 274, 184, 6, 6, '#f2f2f2'); R(c, 280, 185, 2, 3, '#f2f2f2');
    // tapete
    for (let x = 230; x < 430; x += 2) R(c, x, GY + 8, 2, 6, (x / 2) % 4 < 2 ? '#c8a24a' : '#b8441a');
    // plantas em lata
    for (const [x, cor] of [[436, '#5a9a3a'], [452, '#3a7a2a']]) { R(c, x, 196, 12, 24, '#a8a8b0'); R(c, x, 199, 12, 3, '#d84a3a'); for (let k = 0; k < 6; k++) disco(c, x + 6 + Math.round(Math.sin(k * 2) * 6), 186 - k * 4, 4, k % 2 ? cor : '#6aaa4a'); }
    // gato dormindo no tapete
    disco(c, 360, 222, 5, '#e8a24a'); R(c, 352, 219, 16, 5, '#e8a24a'); R(c, 364, 214, 6, 5, '#e8a24a'); R(c, 364, 213, 2, 2, '#c8823a'); R(c, 368, 213, 2, 2, '#c8823a'); R(c, 350, 222, 8, 2, '#c8823a');
  }
  function animDalva(c, t, n) {
    // TV ligada (novela piscando)
    const f = Math.floor(t * 3) % 4; R(c, 162, 120, 44, 28, ['#4a6a8a', '#5a7a6a', '#6a5a7a', '#4a6a8a'][f]); for (let y = 120; y < 148; y += 2) { c.globalAlpha = .18; R(c, 162, y, 44, 1, '#000'); c.globalAlpha = 1; }
    disco(c, 176 + Math.round(Math.sin(t) * 3), 134, 5, '#e8b89a'); disco(c, 192 - Math.round(Math.sin(t) * 3), 134, 5, '#7a4a2e'); glow(c, 184, 134, 40, '#6a8ac8', .25);
    // ventilador girando
    R(c, 140, 186, 2, 32, '#6a6a6a'); R(c, 133, 217, 16, 3, '#5a5a5a'); disco(c, 141, 184, 9, 'rgba(220,230,240,.35)');
    for (let k = 0; k < 3; k++) { const a = t * 18 + k * 2.09; R(c, 141 + Math.round(Math.cos(a) * 6) - 2, 184 + Math.round(Math.sin(a) * 6) - 1, 4, 3, '#4a8ad8'); } disco(c, 141, 184, 2, '#2a2a2a');
    // fumacinha do café
    for (let k = 0; k < 4; k++) { const u = (t * .5 + k / 4) % 1; c.globalAlpha = (1 - u) * .5; R(c, 277 + Math.sin(t * 2 + k) * 2, 182 - u * 18, 2, 2, '#ffffff'); } c.globalAlpha = 1;
    // gato respirando
    const r = Math.round(Math.sin(t * 2)); R(c, 354, 217 - r, 12, 2, '#f2b85a');
    lampada(c, 230, 0, 26, true, t); glow(c, 230, 36, 120, '#ffd890', .22 + n * .2);
  }

  // ---- barraco do Seu Tião: tijolo à mostra, bancada de ferramentas, rádio, papagaio e varal
  function salaTiao(c) {
    R(c, 0, 0, LW, GY - 4, '#a8603e');
    for (let y = 0, r = 0; y < GY - 4; y += 7, r++) { R(c, 0, y, LW, 1, '#7a4028'); for (let x = (r % 2) * 9; x < LW; x += 18) { R(c, x, y, 1, 7, '#7a4028'); if (hsh(x * 7 + y) > .6) R(c, x + 2, y + 2, 12, 4, hsh(x + y) > .5 ? '#b8704a' : '#985030'); } }
    parede(c, 120, 30, 330, GY - 4, '#d8d0b0', '#ece6cc', '#a8a080', 23); // parte rebocada
    piso(c, '#8a8478', '#7a7468', '#5a554a'); rodape(c, '#4a4438');
    janela(c, 200, 50, 56, 40, 0);
    R(c, 36, 120, 34, 100, '#2a2a30'); R(c, 39, 123, 28, 97, '#f2e0b0'); R(c, 40, 124, 26, 96, '#ffeec8'); R(c, 66, 123, 6, 97, '#4a5a6a');
    // bancada com ferramentas na parede
    R(c, 90, 176, 80, 6, '#6a4428'); R(c, 92, 182, 4, 38, '#4a2e18'); R(c, 164, 182, 4, 38, '#4a2e18'); R(c, 96, 200, 68, 3, '#4a2e18');
    R(c, 92, 120, 76, 40, '#8a6a4a'); for (let k = 0; k < 6; k++) { R(c, 98 + k * 11, 126, 2, 14 + (k % 3) * 4, '#5a5a5a'); R(c, 96 + k * 11, 124, 6, 3, ['#d84a3a', '#3a6ad8', '#f2c24a'][k % 3]); }
    R(c, 104, 166, 18, 10, '#5a5a6a'); R(c, 140, 168, 12, 8, '#c8a24a'); // morsa e caixa
    // pneu de moto e capacete
    disco(c, 196, 204, 14, '#1a1a1a'); disco(c, 196, 204, 8, '#3a3a3a'); disco(c, 196, 204, 4, '#8a8a8a');
    disco(c, 230, 210, 9, '#d8d0c0'); R(c, 222, 210, 18, 8, '#d8d0c0'); R(c, 226, 206, 12, 4, '#2a3a5a');
    // pôster de time (sem nome real)
    quadro(c, 270, 60, 34, 44, '#e8e8e0', '#2a6a3a', (cc, x, y) => { R(cc, x, y + 8, 34, 6, '#f2d24a'); for (let k = 0; k < 5; k++) { disco(cc, x + 5 + k * 6, y + 26, 2, '#e8b89a'); R(cc, x + 3 + k * 6, y + 29, 5, 8, '#f2f2f2'); } });
    // cama de solteiro com cobertor xadrez
    R(c, 340, 180, 110, 24, '#5a3a24'); R(c, 342, 172, 106, 10, '#f2f2e8');
    for (let x = 342; x < 448; x += 4) for (let y = 182; y < 200; y += 4) R(c, x, y, 4, 4, ((x + y) / 4) % 2 ? '#c83a3a' : '#2a4a8a');
    R(c, 340, 204, 4, 16, '#3a2414'); R(c, 446, 204, 4, 16, '#3a2414'); R(c, 344, 166, 20, 8, '#f6f2e8');
    // botijão e garrafa de água
    R(c, 300, 196, 18, 24, '#3a5ab8'); R(c, 302, 192, 14, 4, '#3a5ab8'); R(c, 306, 188, 6, 4, '#8a8a8a');
    // gaiola
    R(c, 398, 64, 1, 22, '#5a5a5a'); R(c, 386, 86, 26, 30, 'rgba(0,0,0,0)'); for (let k = 0; k <= 6; k++) R(c, 386 + k * 4, 86, 1, 30, '#c8c0a8'); R(c, 386, 86, 26, 2, '#c8c0a8'); R(c, 386, 115, 26, 2, '#c8c0a8');
  }
  function animTiao(c, t, n) {
    // varal balançando
    R(c, 120, 34, 210, 1, '#e8e8e0');
    for (let k = 0; k < 5; k++) { const sw = Math.round(Math.sin(t * 2 + k) * 2); R(c, 136 + k * 40 + sw, 35, 18, 20, ['#e84a6a', '#4a8ad8', '#f2f2e8', '#f2c24a', '#4ac87a'][k]); R(c, 136 + k * 40 + sw, 35, 18, 2, 'rgba(0,0,0,.15)'); }
    // rádio tocando (notas subindo)
    R(c, 110, 160, 22, 14, '#2a2a2a'); disco(c, 116, 167, 4, '#5a5a5a'); R(c, 124, 163, 6, 2, '#f2c24a'); R(c, 128, 150, 1, 10, '#8a8a8a');
    for (let k = 0; k < 3; k++) { const u = (t * .6 + k / 3) % 1; c.globalAlpha = 1 - u; R(c, 120 + k * 6 + Math.sin(t * 3 + k) * 4, 156 - u * 30, 3, 3, '#f2d24a'); R(c, 122 + k * 6 + Math.sin(t * 3 + k) * 4, 150 - u * 30, 1, 6, '#f2d24a'); } c.globalAlpha = 1;
    // papagaio pulando na gaiola
    const pul = Math.abs(Math.round(Math.sin(t * 4) * 2)); R(c, 396, 100 - pul, 6, 10, '#3ac84a'); R(c, 400, 98 - pul, 4, 4, '#3ac84a'); R(c, 403, 99 - pul, 2, 2, '#f2c24a'); R(c, 398, 108 - pul, 4, 4, '#e84a3a');
    lampada(c, 250, 0, 22, true, t); glow(c, 250, 32, 110, '#ffe0a0', .2 + n * .25);
  }

  // ---- casa da Kelly: quarto-sala com fita de LED, caixa de som, espelho, pôsteres e bichinhos
  function salaKelly(c) {
    parede(c, 0, 0, LW, GY - 4, '#6a4a8a', '#8a6aaa', '#4a3068', 37);
    piso(c, '#d8c8b8', '#c8b8a8', '#a89888'); rodape(c, '#3a2a4a');
    janela(c, 370, 54, 60, 42, 1);
    R(c, 36, 120, 34, 100, '#3a2a4a'); R(c, 39, 123, 28, 97, '#f2e0b0'); R(c, 40, 124, 26, 96, '#ffeec8'); R(c, 66, 123, 6, 97, '#8a3a6a');
    // pôsteres (artistas inventados)
    quadro(c, 96, 60, 30, 40, '#f2f2f2', '#1a1a2a', (cc, x, y) => { disco(cc, x + 15, y + 14, 7, '#6a4028'); R(cc, x + 7, y + 22, 16, 14, '#f24a8a'); R(cc, x + 4, y + 33, 22, 4, '#f2d24a'); });
    quadro(c, 136, 52, 36, 26, '#f2f2f2', '#f2d24a', (cc, x, y) => { R(cc, x + 4, y + 6, 28, 4, '#1a1a1a'); R(cc, x + 4, y + 14, 20, 3, '#e84a4a'); });
    // espelho de camarim com lâmpadas
    R(c, 190, 92, 50, 60, '#e8d8c8'); R(c, 194, 96, 42, 52, '#a8c8d8'); R(c, 196, 98, 10, 40, 'rgba(255,255,255,.35)');
    R(c, 186, 152, 58, 6, '#f2f2f2'); R(c, 190, 158, 4, 62, '#d8d8d8'); R(c, 236, 158, 4, 62, '#d8d8d8');
    for (let k = 0; k < 5; k++) R(c, 196 + k * 9, 146, 4, 6, ['#f24a8a', '#f2d24a', '#4ac8f2', '#f2f2f2', '#c84af2'][k]); // maquiagem
    // caixa de som grande
    R(c, 262, 150, 40, 70, '#1a1a1e'); R(c, 262, 150, 40, 2, '#3a3a42'); disco(c, 282, 172, 11, '#2a2a30'); disco(c, 282, 202, 13, '#2a2a30');
    // cama com bichinhos de pelúcia
    R(c, 320, 178, 130, 26, '#f2f2f2'); R(c, 320, 190, 130, 14, '#f28ab8'); R(c, 320, 204, 4, 16, '#4a3a5a'); R(c, 446, 204, 4, 16, '#4a3a5a'); R(c, 318, 150, 6, 54, '#4a3a5a');
    for (const [x, cor] of [[332, '#c8a07a'], [348, '#f2f2f2'], [364, '#f2c24a']]) { disco(c, x, 172, 6, cor); disco(c, x - 4, 166, 2, cor); disco(c, x + 4, 166, 2, cor); R(c, x - 2, 171, 1, 1, '#1a1a1a'); R(c, x + 2, 171, 1, 1, '#1a1a1a'); }
    // celular carregando na tomada
    R(c, 300, 140, 6, 8, '#f2f2f2'); R(c, 302, 148, 1, 22, '#f2f2f2'); R(c, 298, 168, 8, 12, '#1a1a2a');
    // tapete felpudo
    for (let x = 240; x < 440; x += 2) R(c, x, GY + 10 + (x % 4 === 0 ? 1 : 0), 2, 6, x % 6 ? '#f2b8d8' : '#e8a0c8');
  }
  function animKelly(c, t, n) {
    // fita de LED trocando de cor
    for (let x = 0; x < LW; x += 4) { const h = (x / 60 + t * .6) % 1; const cor = `hsl(${Math.round(h * 360)},90%,60%)`; R(c, x, 10, 4, 2, cor); }
    glow(c, 240, 12, 160, '#c86ae8', .18);
    // luzinhas de cordão
    for (let k = 0; k < 16; k++) { const x = 90 + k * 14, y = 40 + Math.round(Math.sin(k * .8) * 4); const on = Math.floor(t * 3 + k) % 3; R(c, x, y, 2, 2, on ? '#fff2b8' : '#a89a6a'); if (on) glow(c, x + 1, y + 1, 6, '#ffe08a', .35); }
    // caixa de som pulsando
    const b = Math.abs(Math.sin(t * 9)) > .7 ? 1 : 0;
    disco(c, 282, 172, 7 + b, '#4a4a56'); disco(c, 282, 202, 9 + b, '#4a4a56'); disco(c, 282, 172, 2, '#8a8a96'); disco(c, 282, 202, 3, '#8a8a96');
    R(c, 266, 156, 3, 3, Math.floor(t * 6) % 2 ? '#4af24a' : '#1a5a1a');
    // tela do celular acendendo
    if (Math.floor(t * .5) % 2) { R(c, 299, 169, 6, 10, '#6ac8f2'); glow(c, 302, 174, 10, '#6ac8f2', .3); }
    lampada(c, 240, 12, 18, false, t);
  }

  const SALAS = { casa_dalva: [salaDalva, animDalva], casa_tiao: [salaTiao, animTiao], casa_kelly: [salaKelly, animKelly] };
  const fixos = {};
  let tela = null, tctx = null;
  // degradê em pixel até o preto nas pontas do cenário (sem borda de recorte)
  function degradeNasPontas(c) {
    const faixas = 12, largura = 64;
    for (let i = 0; i < faixas; i++) {
      const a = Math.pow(1 - i / faixas, 1.4);
      const x = i * (largura / faixas), w = largura / faixas;
      c.globalAlpha = a; R(c, x, 0, w, LH, '#000'); R(c, LW - x - w, 0, w, LH, '#000');
      // pontilhado na borda de cada faixa para o degradê ficar de pixel
      c.globalAlpha = a * .6; for (let y = (i % 2); y < LH; y += 2) { R(c, x + w, y, 1, 1, '#000'); R(c, LW - x - w - 1, y, 1, 1, '#000'); }
    }
    for (let i = 0; i < 6; i++) { c.globalAlpha = (1 - i / 6) * .6; R(c, 0, i * 3, LW, 3, '#000'); }
    c.globalAlpha = 1;
  }
  function desenhar(ctx, id, t) {
    const s = SALAS[id]; if (!s) return false;
    if (!fixos[id]) { const [cv, c] = mk(LW, LH); s[0](c); fixos[id] = cv; }
    if (!tela) { [tela, tctx] = mk(LW, LH); }
    const n = noite();
    tctx.globalAlpha = 1; tctx.globalCompositeOperation = 'source-over';
    tctx.clearRect(0, 0, LW, LH); tctx.drawImage(fixos[id], 0, 0);
    s[1](tctx, Number(t) || 0, n);
    // à noite o cômodo fica mais escuro e a lâmpada pesa mais
    if (n > 0) { tctx.globalAlpha = n * .25; R(tctx, 0, 0, LW, LH, '#0a0a20'); tctx.globalAlpha = 1; }
    degradeNasPontas(tctx);
    ctx.save(); ctx.imageSmoothingEnabled = false; ctx.drawImage(tela, 0, 0, LW * 2, LH * 2); ctx.restore();
    return true;
  }

  // porta destrancada na favela: luz quente saindo pela fresta e capacho
  function portas(ctx, cena, t) {
    if (cena !== CENA) return;
    for (const c of Object.values(CASAS)) {
      const x = c.x, base = 440;
      ctx.save();
      ctx.globalAlpha = .55 + .1 * Math.sin((Number(t) || 0) * 3 + x);
      ctx.fillStyle = '#ffd88a'; ctx.fillRect(x + 6, base - 58, 6, 56);
      ctx.globalAlpha = .18; ctx.fillStyle = '#ffd88a'; ctx.fillRect(x - 4, base - 2, 34, 4);
      ctx.globalAlpha = 1; ctx.fillStyle = '#8a3a2a'; ctx.fillRect(x - 18, base - 2, 36, 4); ctx.fillStyle = '#c8a24a'; ctx.fillRect(x - 16, base - 1, 32, 1);
      ctx.restore();
    }
  }

  const nomeDe = (id) => CASAS[id]?.nome || '';
  const npcDe = (id) => CASAS[id]?.npc || '';
  const falante = (id, norm) => { const n = npcDe(id).normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); return !!n && norm.includes(n.replace(/^(dona|seu) /, '')); };
  window.FavelaCasas = Object.freeze({ CASAS, ehCasa, falar, desenhar, portas, nome: nomeDe, nomeNpc: npcDe, morador: (id) => CASAS[id]?.morador || null, falante, LENDAS });
})();
