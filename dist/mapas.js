/* Os dois mapas em pixel art (vista de cima inclinada, estilo RPG) e os táxis da Campanha 2.
   - Campanha 1 (Itabuna): abre quando você chama o carro a gás. Rio Cachoeira no meio com pontes, a roça do outro
     lado, ruas de pedra, a praça com fonte, e o morro da favela com paredões e casinhas coloridas. O carro voa.
   - Campanha 2 (Vitória da Conquista): a locomoção é de TÁXI. O Seu Zé espera nos pontos de táxi, sempre do lado de
     fora (na escola, o táxi fica na frente do portão). O mapa do táxi só mostra esses pontos; o resto é a pé.
   As descrições (botão ⓘ) dão suspense, sem spoiler. Arte própria, desenhada em pixels aqui mesmo. */
(() => {
  'use strict';
  if (window.MapasJogo || !window.Mapa3D?.arte) return;
  const { hash } = window.Mapa3D.arte, TS = 16, L16 = (n) => n * TS;
  const previaCena = (scene, camera) => { let off = null; return (c, w, h, t) => { if (!off) { off = document.createElement('canvas'); off.width = 960; off.height = 540; }
    const o = off.getContext('2d'); o.imageSmoothingEnabled = false; window.Art?.drawScene?.(o, scene, camera + Math.sin(t * .3) * 40, t); c.imageSmoothingEnabled = false; c.drawImage(off, 0, 0, w, h); }; };
  const livre = (x, y, caixas, m = 10) => !caixas.some(([bx, by, bw, bh]) => x > bx - m && x < bx + bw + m && y > by - m && y < by + bh + m);

  /* ---------- peças extras usadas nos dois mapas ---------- */
  const ponte = (P, x, y, w, h = 30) => { const R = P.R; P.sombra(x + w / 2, y + h + 4, w / 2, 4, .3); R(x, y, w, h, '#8a9096'); for (let k = 0; k < w; k += 6) { R(x + k, y + 2, 5, h - 4, '#b8bcc0'); R(x + k, y + 2, 5, 1, '#dde0e3'); } R(x - 2, y - 4, w + 4, 5, '#9aa0a6'); R(x - 2, y + h - 2, w + 4, 6, '#7a8086'); for (let k = 0; k < w; k += 10) { R(x + k, y - 7, 3, 4, '#c8ccd0'); R(x + k, y + h - 5, 3, 4, '#c8ccd0'); } R(x - 2, y + h + 4, w + 4, 2, '#5a6066'); };
  const escada = (P, x, y, n, larg = 14) => { for (let k = 0; k < n; k++) { P.R(x, y + k * 4, larg, 4, k % 2 ? '#a8aeb4' : '#bcc0c4'); P.R(x, y + k * 4, larg, 1, '#dde0e3'); } P.R(x - 1, y, 1, n * 4, '#7a8086'); P.R(x + larg, y, 1, n * 4, '#7a8086'); };
  const pessoa = (P, x, y, cor, t = 0, anda = true) => { const f = anda ? Math.floor(t * 6) % 2 : 0; P.R(x - 1, y - 2, 2, 2 + f, '#2a2f3a'); P.R(x + 1, y - 2, 2, 3 - f, '#2a2f3a'); P.R(x - 2, y - 8, 5, 6, cor); P.R(x - 1, y - 11, 3, 3, '#d9a57f'); P.R(x - 1, y - 12, 3, 1, '#2a201a'); P.R(x - 3, y, 7, 1, 'rgba(0,0,0,.25)'); };
  const carrinho = (P, x, y, cor, dir = 1, taxi = false) => { const R = P.R; R(x - 9, y + 1, 18, 2, 'rgba(0,0,0,.3)'); R(x - 9, y - 6, 18, 7, cor); R(x - 9, y - 6, 18, 1, '#ffffff55'); R(x - 5 + dir, y - 10, 10, 5, cor); R(x - 4 + dir, y - 9, 8, 3, '#9fc4d0'); R(x - 8, y, 4, 2, '#1c1c1c'); R(x + 4, y, 4, 2, '#1c1c1c'); R(dir > 0 ? x + 8 : x - 9, y - 4, 1, 2, '#fff2b0'); if (taxi) { R(x - 2 + dir, y - 12, 5, 2, '#f6f6f0'); for (let k = 0; k < 9; k++) R(x - 9 + k * 2, y - 3, 1, 1, k % 2 ? '#1c1c1c' : '#f6f6f0'); } };
  const andar = (P, t, rotas, cores, vel = 18) => { rotas.forEach((r, k) => { const [a, b] = r, len = Math.hypot(b[0] - a[0], b[1] - a[1]); for (let j = 0; j < (r[2] || 2); j++) { const u = ((t * vel / len) + j / (r[2] || 2) + k * .17) % 1, x = a[0] + (b[0] - a[0]) * u, y = a[1] + (b[1] - a[1]) * u; carrinho(P, x, y, cores[(j + k) % cores.length], b[0] >= a[0] ? 1 : -1); } }); };
  const fumaca = (P, x, y, t) => { for (let k = 0; k < 5; k++) { const q = (t * .4 + k / 5) % 1; P.c.globalAlpha = (1 - q) * .55; P.circ(x + Math.sin(t + k) * 3 + q * 6, y - q * 26, 2 + q * 4, '#f2f2ee'); } P.c.globalAlpha = 1; };

  /* =====================================================================
     CAMPANHA 1 · ITABUNA
     ===================================================================== */
  const C1 = [
    { id: 0, nome: 'A roça', sub: 'Onde tudo começou', caixa: [64, 300, 176, 120], cam: 300,
      descricao: 'Cheiro de terra molhada, galinheiro barulhento e um carro velho que não anda sozinho. Tudo começa aqui. E alguma coisa sempre precisa de conserto.',
      desenho: (P) => { P.casa(100, 330, 76, 60, { telhado: '#c8543a', parede: '#f2e2c0', chamine: true, janelas: [8, 58] }); P.R(190, 352, 26, 34, '#a8643a'); P.R(190, 352, 26, 4, '#c8844a'); for (let k = 0; k < 26; k += 4) P.R(190 + k, 356, 1, 30, '#7a4426'); P.R(186, 346, 34, 8, '#8a4a2a'); // galinheiro
        P.R(80, 310, 4, 62, '#8a6a45'); P.R(78, 306, 8, 6, '#6a4a2a'); P.cercaH(70, 404, 150); for (const [x, y] of [[196, 396], [206, 392], [214, 398]]) { P.R(x, y - 4, 5, 4, '#f6f6f0'); P.R(x + 4, y - 6, 2, 2, '#c43c3a'); } } },
    { id: 7, nome: 'Campo do Mota', sub: 'Futebol e experiência', caixa: [56, 56, 208, 150],
      descricao: 'Grama alta, trave torta e um treinador que exige o máximo. O que se aprende ali muda o jeito de correr para sempre.',
      desenho: (P) => { const R = P.R; R(64, 64, 192, 128, 'rgba(255,255,255,0)'); R(160, 66, 2, 124, '#f2f2ee'); P.circ(160, 128, 16, '#f2f2ee', 10); P.circ(160, 128, 14, '#62aa4e', 8);
        for (const gx of [66, 246]) { R(gx, 108, 3, 36, '#f6f6f0'); R(gx, 106, 10 * (gx < 100 ? 1 : -1) + 0, 3, '#f6f6f0'); R(gx + (gx < 100 ? 6 : -9), 108, 3, 36, '#e8e8e2'); }
        R(100, 58, 120, 14, '#8a9096'); R(100, 58, 120, 3, '#b8bcc0'); for (let k = 0; k < 8; k++) R(104 + k * 14, 62, 10, 4, ['#e8433a', '#2c5a9e', '#f2c94c'][k % 3]); R(140, 160, 4, 4, '#ffffff'); } },
    { id: 1, nome: 'Colégio Adventista', sub: 'Professores e provocações', caixa: [416, 20, 190, 130],
      descricao: 'Corredores compridos, professores de olho em tudo e uma provocação esperando no fim do corredor. Leve o caderno. E coragem.',
      desenho: (P) => { P.predio(430, 34, 162, 106, { topo: '#3c6aa8', parede: '#efebe0', faixa: '#2c5a9e', fachada: 36 }); P.R(480, 112, 60, 10, '#2c5a9e'); P.R(484, 114, 52, 6, '#f2efe6'); P.R(420, 30, 3, 70, '#c8ccd0'); P.R(423, 30, 14, 9, '#3c8a5a'); P.R(423, 33, 14, 2, '#f2c94c');
        for (const x of [440, 572]) P.arbusto(x, 146, x, '#e86a8a'); } },
    { id: 9, nome: 'Pátio da escola', sub: 'O intervalo mais longo do mundo', caixa: [690, 52, 132, 120],
      descricao: 'Na hora do intervalo tudo pode acontecer. Alguém por ali precisa de ajuda... e outra pessoa está doida por uma revanche.',
      desenho: (P) => { const R = P.R; R(700, 70, 60, 40, '#c8ccd0'); R(698, 66, 64, 8, '#e8433a'); R(698, 66, 64, 2, '#f26a5a'); for (const x of [702, 754]) R(x, 74, 4, 36, '#9aa0a6'); P.banco(772, 112); P.banco(772, 140); P.banco(720, 150); P.arvore(800, 100, .9, 'amarela', 3); } },
    { id: 6, nome: 'Caderno do Caos', sub: 'O monstro gigante', caixa: [432, 186, 150, 104],
      descricao: 'As páginas viraram sozinhas. Os rabiscos ganharam vida. E aquela coisa enorme desenhada na última folha... acordou.',
      desenho: (P) => { const R = P.R; P.sombra(508, 270, 70, 10, .3); R(444, 218, 64, 52, '#f6f4ee'); R(510, 218, 64, 52, '#f2f0ea'); R(444, 218, 130, 2, '#c8c4bc'); for (let k = 0; k < 7; k++) { R(448, 226 + k * 6, 56, 1, '#8ab8e8'); R(514, 226 + k * 6, 56, 1, '#8ab8e8'); } R(452, 218, 1, 52, '#e88a8a'); for (let k = 0; k < 9; k++) P.circ(509, 222 + k * 6, 2, '#8a9096', 1);
        R(526, 196, 32, 40, '#7a3a8a'); R(522, 186, 40, 18, '#8a4a9a'); R(530, 192, 8, 6, '#ffffff'); R(546, 192, 8, 6, '#ffffff'); R(533, 194, 3, 3, '#1c1c1c'); R(549, 194, 3, 3, '#1c1c1c'); for (let k = 0; k < 6; k++) R(530 + k * 4, 204, 2, 3, '#ffffff'); R(516, 214, 12, 4, '#7a3a8a'); R(556, 210, 12, 4, '#7a3a8a');
        for (let k = 0; k < 5; k++) R(460 + k * 8, 248 - (k % 2) * 4, 5, 2, '#2a2a2a'); } },
    { id: 3, nome: 'A quadra', sub: 'O bolo está por perto', caixa: [656, 336, 132, 100],
      descricao: 'O som da bola quicando chega até a rua. Tem alguém lá dentro que sabe muito bem onde o bolo foi parar...',
      desenho: (P) => { const R = P.R; R(672, 352, 112, 2, '#f2f2ee'); R(672, 430, 112, 2, '#f2f2ee'); R(727, 352, 2, 80, '#f2f2ee'); P.circ(728, 392, 12, '#f2f2ee', 9); P.circ(728, 392, 10, '#3c7ab0', 7);
        for (const x of [676, 776]) { R(x, 380, 3, 26, '#c8ccd0'); R(x - 4, 378, 11, 8, '#f6f6f0'); R(x - 1, 386, 5, 3, '#e8433a'); }
        for (let k = 0; k <= 120; k += 8) { R(664 + k, 342, 2, 12, '#7a8086'); } R(664, 344, 122, 1, '#9aa0a6'); R(664, 348, 122, 1, '#9aa0a6'); } },
    { id: 4, nome: 'Praça Camacan', sub: 'Uma pausa na resenha', caixa: [470, 380, 176, 150],
      descricao: 'Banco de praça, sorvete e fofoca fresquinha. Às vezes, uma pausa é tudo de que a resenha precisa.',
      desenho: (P) => { P.fonte(560, 452); for (const [x, y] of [[494, 412], [626, 412], [494, 512], [626, 512]]) P.arvore(x, y, 1.1, 'verde', x); for (const [x, y] of [[520, 420], [590, 420], [520, 494], [590, 494]]) P.banco(x, y); for (const [x, y] of [[500, 470], [612, 470]]) P.flores(x, y, ['#e86a8a', '#f2c94c', '#ffffff']); P.poste(482, 456); P.poste(636, 456); } },
    { id: 2, nome: 'Academia do Caleb', sub: 'Caleb e o shape', caixa: [856, 196, 120, 100],
      descricao: 'Dizem que ninguém sai de lá do mesmo jeito que entrou. Os reflexos que o digam. E o espelho também.',
      desenho: (P) => { P.predio(866, 214, 100, 74, { topo: '#3a3f48', parede: '#4a505a', faixa: '#e8433a', fachada: 30, caixa: false }); P.R(890, 206, 52, 6, '#c8ccd0'); P.R(884, 202, 10, 14, '#2a2a2a'); P.R(938, 202, 10, 14, '#2a2a2a'); P.R(896, 260, 40, 8, '#e8433a'); } },
    { id: 8, nome: 'Bigodon', sub: 'Davi Costa e Vitor', caixa: [856, 372, 100, 80],
      descricao: 'Tesoura afiada, espelho que parece mágico e a melhor conversa da cidade. Você sai de lá com outro visual?',
      desenho: (P) => { P.casa(868, 384, 76, 60, { telhado: '#2a2a30', parede: '#3a3a42', madeira: false, janelas: [8, 58] }); P.R(892, 404, 30, 8, '#c8a24a'); for (let k = 0; k < 8; k++) P.R(860, 412 + k * 3, 4, 3, k % 2 ? '#e8433a' : '#f2f2ee'); P.R(859, 410, 6, 2, '#c8ccd0'); } },
    { id: 10, nome: 'Casa de Rayssa', sub: 'As garotas e a resenha', caixa: [652, 556, 120, 96],
      descricao: 'Entra, mas limpa o tênis. As garotas estão reunidas e, lá dentro, tem um segredo elétrico esperando por você.',
      desenho: (P) => { P.casa(670, 570, 80, 62, { telhado: '#c8546a', parede: '#f8d0dc', janelas: [8, 60] }); P.cercaH(660, 646, 104); P.flores(666, 634, ['#e86a8a', '#f2c94c', '#b86ad8']); P.flores(740, 634, ['#e86a8a', '#ffffff']); P.arbusto(760, 620, 4, '#e86a8a'); } },
    { id: 11, nome: 'Baile funk', sub: 'Ollyan e a perseguição', caixa: [836, 556, 160, 120],
      descricao: 'O grave treme o chão, as luzes não param e a pista está cheia. E tem um carro por ali que não devia estar no céu...',
      desenho: (P) => { P.predio(846, 572, 140, 92, { topo: '#2a1a3a', parede: '#3a2a4a', fachada: 34, caixa: false }); for (const x of [854, 966]) { P.R(x, 630, 14, 26, '#14141a'); P.circ(x + 7, 638, 4, '#5a5a66'); P.circ(x + 7, 650, 3, '#5a5a66'); } P.R(886, 624, 60, 10, '#ff3a8a'); } },
    { id: 5, nome: 'Favela do Reeis', sub: 'Do beco ao rei', caixa: [800, 0, 224, 184],
      descricao: 'Becos que sobem, escadas que não acabam, pipa no céu e um nome que todo mundo respeita lá em cima.',
      desenho: (P) => { const cores = [['#f2c4c4', '#c8544a'], ['#f2e2a8', '#d0683a'], ['#c8dcf0', '#8a8e94'], ['#d4ecc8', '#c8544a'], ['#e8c8e8', '#d0683a'], ['#f0d0a0', '#8a8e94'], ['#c8e8e0', '#c8544a']]; let i = 0;
        for (const [y0, x0, x1] of [[132, 812, 1012], [84, 860, 1012], [36, 920, 1012]]) for (let x = x0; x < x1 - 30; x += 36) { const [par, tel] = cores[i++ % cores.length]; P.casa(x, y0 - (i % 2) * 4, 32, 34, { telhado: tel, parede: par, madeira: false, paredeH: 16, janelas: [4], porta: 18 }); }
        escada(P, 830, 150, 8); escada(P, 880, 100, 8); escada(P, 940, 52, 8); P.R(990, 10, 2, 26, '#5a5a56'); P.R(992, 10, 14, 9, '#e8433a'); } }
  ];
  const MAPA1 = {
    chave: 'itabuna2d', titulo: 'CARRO A GÁS · MAPA DE ITABUNA', subtitulo: 'Escolha um lugar. O carro do seu pai voa até lá.', lajotas: [64, 44], voa: true,
    terreno: (T) => {
      T.linha([[22, 0], [21, 9], [24, 19], [23, 30], [26, 44]], 4, { nivel: 0 });
      T.ret(50, 0, 14, 10, { nivel: 2 }); T.ret(54, 0, 10, 6, { nivel: 3 }); T.ret(58, 0, 6, 2, { nivel: 4 });
      T.ret(4, 4, 12, 8, { tipo: 'campo' }); T.ret(2, 26, 3, 6, { tipo: 'plantacao' }); T.ret(1, 18, 4, 6, { tipo: 'plantacao' });
      T.linha([[26, 19.5], [63, 19.5]], 2, { tipo: 'pedra' }); T.linha([[26, 33.5], [63, 33.5]], 2, { tipo: 'pedra' }); T.linha([[37.5, 0], [37.5, 43]], 2, { tipo: 'pedra' }); T.linha([[50.5, 12], [50.5, 43]], 2, { tipo: 'pedra' });
      T.linha([[20, 19.5], [10, 19.5], [8, 14]], 2, { tipo: 'chao' }); T.linha([[10, 19.5], [9, 25]], 2, { tipo: 'chao' }); T.linha([[20, 33.5], [6, 33.5], [3, 40]], 2, { tipo: 'chao' });
      T.ret(30, 24, 10, 8, { tipo: 'pedra' }); T.ret(42, 22, 7, 5, { tipo: 'quadra' }); T.ret(44, 4, 6, 6, { tipo: 'pedra' }); T.ret(27, 3, 10, 6, { tipo: 'pedra' });
      T.ret(53, 12, 9, 2, { tipo: 'chao' });
    },
    objetos: (add) => {
      const caixas = C1.map((L) => L.caixa);
      for (let i = 0; i < 120; i++) { const x = hash(i, 3) * 1010 + 6, y = hash(i, 7) * 690 + 8, tx = Math.floor(x / TS), ty = Math.floor(y / TS); if (!livre(x, y, caixas, 14)) continue; const t = window.Mapa3D.arte; void t;
        if ([18, 19, 20, 32, 33, 34].includes(ty) && tx > 24) continue; if ([37, 38, 50, 51].includes(tx)) continue; if (Math.abs(tx - (22 + (ty / 44) * 4)) < 4) continue; if (tx >= 50 && ty <= 11) continue;
        const k = hash(i, 11); add(y, (P) => (k > .85 ? P.arbusto(x, y, i, '#f2c94c') : k > .78 ? P.pedra(x, y) : P.arvore(x, y, .8 + hash(i, 2) * .5, k > .72 ? 'escura' : 'verde', i))); }
      add(320, (P) => ponte(P, 324, 300, 74)); add(544, (P) => ponte(P, 348, 524, 76));
      for (let x = 420; x < 1000; x += 64) { add(334, (P) => P.poste(x, 334)); add(556, (P) => P.poste(x + 20, 556)); }
      add(200, (P) => P.cercaH(408, 200, 30)); for (let x = 260; x < 330; x += 22) add(600, (P) => P.pedra(x, 600));
    },
    animar: (P, t) => { const R = P.R;
      { const cx = 82, cy = 306; for (let k = 0; k < 4; k++) { const a = t * 2 + k * Math.PI / 2; for (let j = 4; j < 20; j++) R(cx + Math.cos(a) * j, cy + Math.sin(a) * j, 2, 2, j % 4 ? '#e8e2d0' : '#c8b48a'); } R(cx - 2, cy - 2, 5, 5, '#6a4a2a'); } // moinho
      fumaca(P, 170, 326, t); fumaca(P, 900, 200, t + 1);
      for (let k = 0; k < 6; k++) { const a = t * 3 + k; R(560 + Math.cos(a) * 3, 438 - (t * 20 + k * 4) % 12, 1, 2, '#c8eaff'); } // fonte
      andar(P, t, [[[420, 318], [1010, 318], 3], [[1010, 540], [420, 540], 2], [[600, 8], [600, 690], 2]], ['#c43c3a', '#3c6aa8', '#f2f2ee', '#e8c24c']);
      for (let k = 0; k < 6; k++) { const u = (t * .05 + k / 6) % 1; pessoa(P, 470 + u * 160, 468 + (k % 3) * 18, ['#e86a8a', '#3c6aa8', '#f2c94c', '#7a3a8a'][k % 4], t); }
      for (let k = 0; k < 4; k++) { const on = Math.floor(t * 4 + k) % 2; R(890 + k * 14, 624, 10, 10, on ? ['#ff3a8a', '#3ae0ff', '#ffe23a', '#8a3aff'][k] : '#3a2a4a'); } // luzes do baile
      { const x = 1000 + Math.sin(t) * 6, y = 0 + Math.sin(t * 1.4) * 4 + 6; P.c.strokeStyle = '#2a2a2a'; P.c.beginPath(); P.c.moveTo(992, 36); P.c.lineTo(x, y + 18); P.c.stroke(); R(x - 4, y, 9, 9, '#e8433a'); R(x - 1, y + 9, 3, 6, '#f2c94c'); } // pipa
      for (let k = 0; k < 3; k++) { const x = ((t * 30 + k * 300) % 1100) - 40, y = 60 + k * 70 + Math.sin(t * 2 + k) * 6, f = Math.sin(t * 12 + k) > 0; R(x, y, 3, 1, '#2a2a2a'); R(x - 2, y - (f ? 2 : 0), 2, 1, '#2a2a2a'); R(x + 3, y - (f ? 2 : 0), 2, 1, '#2a2a2a'); } },
    veiculo: (P) => { const R = P.R; R(-12, -8, 24, 9, '#3c8a8a'); R(-12, -8, 24, 1, '#7ac8c8'); R(-6, -14, 14, 7, '#4aa0a0'); R(-5, -13, 12, 4, '#9fc4d0'); R(-16, -7, 5, 5, '#c8ccd0'); R(-10, 0, 5, 3, '#1c1c1c'); R(6, 0, 5, 3, '#1c1c1c'); R(11, -6, 2, 2, '#fff2b0'); for (let k = 0; k < 3; k++) R(-20 - k * 4, -4 + Math.sin(k + performance.now() / 90) * 2, 3, 3, 'rgba(220,230,240,.7)'); },
    locais: C1
  };
  function abrirMapa1(preferido) {
    const G = window.Game; if (!G?.getState || !window.Mapa3D) return false; const st = G.getState(), q = st.q || {}, atual = Number(preferido ?? st.scene);
    const d = { ...MAPA1, locais: C1.map((L) => ({ ...L, atual: L.id === atual, estado: st.vehicle || L.id === atual ? (window.Campaign?.canTravel?.(L.id, q) || { ok: true }) : { ok: false, motivo: 'Entre no carro a gás (tecla V ou botão CARRO) para viajar.' }, previa: previaCena(L.id, L.cam ?? 700) })),
      aoIr: (id) => G.travel?.(id), aoFechar: () => {} };
    return window.Mapa3D.abrir(d);
  }

  /* =====================================================================
     CAMPANHA 2 · VITÓRIA DA CONQUISTA (só os pontos de táxi, sempre do lado de fora)
     ===================================================================== */
  const PONTOS = [
    { id: 't12', cena: 12, x: 4000, nome: 'Aeroporto Glauber Rocha', sub: 'Ponto de táxi do desembarque', caixa: [8, 132, 200, 150],
      descricao: 'Quem desce aqui sente o frio já na escada do avião. Foi onde a história em Conquista começou, e talvez seja onde ela termine.',
      desenho: (P) => { const R = P.R; P.predio(40, 200, 150, 72, { topo: '#e8ecee', parede: '#9cc4d2', fachada: 32, faixa: '#2a3aa8' }); R(30, 192, 170, 10, '#f8f8f4'); R(30, 200, 170, 2, '#9aa4a8'); R(60, 226, 110, 6, '#2a3aa8');
        R(20, 150, 70, 14, '#f2f4f6'); R(14, 140, 12, 16, '#3c6aa8'); R(84, 152, 12, 10, '#e8ecef'); R(40, 160, 30, 6, '#c9ced2'); for (let k = 0; k < 8; k++) R(30 + k * 7, 154, 3, 3, '#3c4a5a'); R(178, 150, 10, 46, '#d8d4cc'); R(172, 140, 22, 14, '#7ac0d0'); R(170, 138, 26, 3, '#2c4a5a'); } },
    { id: 't13', cena: 13, x: 1500, nome: 'Pensão Dona Lurdes', sub: 'Bairro da pensão', caixa: [236, 216, 150, 100],
      descricao: 'Um quarto pequeno, um mural na parede e uma dona de pensão que sabe de tudo antes de acontecer. É aqui que você volta pra descansar.',
      desenho: (P) => { P.casa(270, 228, 84, 74, { telhado: '#9a4a34', parede: '#f2dfb0', paredeH: 26, chamine: true, janelas: [8, 30, 66] }); P.R(272, 262, 80, 3, '#3a3026'); for (let k = 0; k < 80; k += 4) P.R(272 + k, 258, 1, 6, '#3a3026');
        P.casa(240, 260, 30, 40, { telhado: '#b8644a', parede: '#c8dcf0', madeira: false, janelas: [4], porta: 18 }); P.casa(356, 262, 30, 38, { telhado: '#b8644a', parede: '#f2c4c4', madeira: false, janelas: [18], porta: 4 }); } },
    { id: 't14', cena: 14, x: 1700, nome: 'Centro · Catedral', sub: 'Praça da Catedral', caixa: [460, 90, 170, 150],
      descricao: 'Comércio, buzina, pombo e o sino da Catedral. Quando a neblina desce à noite, a praça guarda segredos... e encontros.',
      desenho: (P) => { const R = P.R; P.casa(520, 150, 90, 70, { telhado: '#cdb98a', parede: '#eedfb6', madeira: false, paredeH: 30, janelas: [10, 70] }); R(490, 120, 32, 100, '#eedfb6'); R(490, 120, 32, 3, '#f8f3e4'); R(488, 210, 36, 10, '#cdb98a');
        for (let k = 0; k < 14; k++) R(506 - (14 - k) * 1.1, 120 - k * 2.6, (14 - k) * 2.2, 3, k % 3 ? '#eedfb6' : '#f8f3e4'); R(505, 78, 2, 10, '#5a5248'); R(501, 81, 10, 2, '#5a5248'); P.circ(506, 140, 6, '#f8f3e4'); P.circ(506, 140, 4, '#f4f0e2'); R(506, 137, 1, 3, '#2a2a2a');
        for (const y of [160, 190]) { R(498, y, 6, 14, '#5a6f86'); R(510, y, 6, 14, '#5a6f86'); } R(500, 200, 14, 20, '#5a3c28'); P.arvore(470, 226, .9, 'roxa', 1); P.arvore(620, 228, .9, 'amarela', 2); } },
    { id: 't15', cena: 15, x: 300, nome: 'Trilha do Cristo', sub: 'Pé da Serra do Periperi', caixa: [440, 0, 100, 140],
      descricao: 'Lá em cima, o Cristo de braços abertos vê a cidade inteira. O vento sopra forte, e dizem que alguém sobe lá só pra ser visto.',
      desenho: (P) => { const R = P.R; P.sombra(492, 58, 18, 5, .3); R(484, 44, 16, 14, '#8a8478'); R(482, 42, 20, 4, '#a49c90'); R(489, 6, 6, 38, '#a49c90'); R(489, 6, 2, 38, '#c4bcb0'); R(474, 14, 36, 5, '#a49c90'); R(474, 14, 36, 2, '#c4bcb0'); P.circ(492, 6, 3, '#9a8a76');
        escada(P, 486, 62, 18); } },
    { id: 't16', cena: 16, x: 2700, nome: 'Monumento ao Índio', sub: 'Avenidas e rotatória', caixa: [680, 276, 110, 94],
      descricao: 'A rotatória mais famosa da cidade. Trânsito pesado, mototáxi pra todo lado e alguém que cobra caro demais por uma corrida.',
      desenho: (P) => { const R = P.R; P.circ(734, 332, 40, '#7a8086', 20); P.circ(734, 330, 38, '#5fae3c', 18); P.flores(712, 320, ['#e86a8a', '#f2c94c', '#ffffff']); P.flores(744, 336, ['#b86ad8', '#f2c94c']);
        R(724, 312, 20, 20, '#8a8478'); R(724, 312, 20, 3, '#b0aa9c'); R(730, 284, 8, 28, '#5e4128'); R(729, 278, 10, 8, '#5e4128'); R(726, 274, 16, 4, '#c9a24a'); R(738, 290, 14, 3, '#5e4128'); P.c.strokeStyle = '#4a3220'; P.c.beginPath(); P.c.arc(752, 292, 9, -1.3, 1.3); P.c.stroke(); } },
    { id: 't17', cena: 17, x: 400, nome: 'Feira do Planalto', sub: 'Barracas e biscoitarias', caixa: [470, 356, 176, 100],
      descricao: 'Grito de feirante, cheiro de biscoito quente e um senhor que vende garrafadas misteriosas. Tem quem diga que ali se compra até coragem.',
      desenho: (P) => { const R = P.R, cores = ['#3c6aa8', '#e8833a', '#e8c24c', '#3c8a5a', '#c43c3a', '#7a3a8a']; for (let k = 0; k < 6; k++) { const x = 480 + (k % 3) * 54, y = 372 + Math.floor(k / 3) * 40; P.sombra(x + 22, y + 30, 22, 4);
        R(x, y, 46, 12, cores[k]); for (let j = 0; j < 46; j += 6) R(x + j, y, 3, 12, '#f6f2ea'); R(x + 2, y + 12, 2, 18, '#6a5a44'); R(x + 42, y + 12, 2, 18, '#6a5a44'); R(x + 4, y + 22, 38, 8, '#8a6a45'); for (let j = 0; j < 6; j++) P.circ(x + 8 + j * 6, y + 20, 2, ['#e8c24c', '#7cbf6a', '#d9634a', '#f6ecd0'][(j + k) % 4]); } } },
    { id: 't18', cena: 18, x: 300, nome: 'Fazendas de café', sub: 'Porteira da fazenda', caixa: [970, 560, 140, 100],
      descricao: 'Fileiras de café até onde a vista alcança. O dono da fazenda vizinha anda nervoso... e não é só por causa da cafeína.',
      desenho: (P) => { P.casa(990, 580, 84, 60, { telhado: '#8a4430', parede: '#f2ece0', paredeH: 22, chamine: true, janelas: [8, 30, 64] }); P.R(1080, 608, 26, 30, '#cfcac0'); for (let k = 0; k < 26; k += 3) P.R(1080 + k, 610, 2, 26, k % 6 < 3 ? '#7a4a2a' : '#5a3420'); P.cercaH(976, 652, 120); } },
    { id: 't19', cena: 19, x: 300, nome: 'Teatro e Planetário', sub: 'Centro de Cultura', caixa: [730, 120, 150, 110],
      descricao: 'De noite, as luzes do teatro acendem e a cúpula do planetário guarda o céu inteiro. Tem show hoje... e um valentão na plateia.',
      desenho: (P) => { const R = P.R; P.predio(736, 140, 76, 76, { topo: '#8a6a4a', parede: '#b08a5a', fachada: 34, caixa: false }); R(740, 184, 68, 6, '#3a2a2a'); for (let k = 0; k < 68; k += 6) R(742 + k, 185, 3, 3, '#ffe39a');
        P.sombra(846, 214, 30, 6); P.circ(846, 200, 30, '#d8dce0', 20); P.circ(846, 196, 28, '#eef0f2', 18); P.circ(838, 188, 12, '#ffffff', 7); R(816, 200, 60, 14, '#d8dce0'); R(838, 204, 16, 10, '#5a6a7a'); } },
    { id: 't22', cena: 22, x: 1100, nome: 'Frente do Shopping', sub: 'Estacionamento e entrada', caixa: [890, 150, 190, 130],
      descricao: 'Cinema, lan house e gente fugindo do frio. Dizem que lá dentro tem um jogo dentro do jogo... e dois irmãos que não sabem perder.',
      desenho: (P) => { const R = P.R; P.predio(900, 160, 170, 90, { topo: '#c8ccd0', parede: '#e8e4dc', fachada: 36, faixa: '#2c5a9e' }); R(960, 214, 50, 34, '#5aa0c8'); R(962, 216, 22, 30, '#9ad0e8'); R(986, 216, 22, 30, '#9ad0e8'); R(946, 204, 80, 10, '#2c5a9e');
        for (let k = 0; k < 5; k++) { R(906 + k * 30, 260, 18, 10, ['#c43c3a', '#f2f2ee', '#3c6aa8', '#e8c24c', '#2a2a2a'][k]); R(906 + k * 30, 268, 4, 2, '#1c1c1c'); R(920 + k * 30, 268, 4, 2, '#1c1c1c'); } } },
    { id: 't21', cena: 21, x: 3700, nome: 'Entrada da Escola SESI', sub: 'Avenida Olívia Flores', caixa: [890, 350, 160, 120],
      descricao: 'O táxi deixa você no portão. Lá dentro tem escada, pátio e alguém que diz que o seu melhor amigo agora é dele.',
      desenho: (P) => { const R = P.R; P.predio(904, 360, 130, 80, { topo: '#e8e8e4', parede: '#f2f2ee', fachada: 32, faixa: '#2c5a9e' }); for (let x = 896; x < 1046; x += 4) R(x, 446, 1, 14, '#2c5a9e'); R(896, 446, 150, 2, '#2c5a9e'); R(956, 444, 30, 18, '#e8e4dc'); R(958, 446, 26, 16, '#c8ccd0');
        R(1040, 360, 2, 60, '#8a8a86'); R(1042, 362, 16, 10, '#2c8a3a'); R(1046, 364, 6, 6, '#e8c24c'); } },
    { id: 't28', cena: 28, x: 250, nome: 'Reserva do Poço Escuro', sub: 'Entrada da trilha', caixa: [16, 380, 200, 210],
      descricao: 'Mata fechada dentro da cidade. Água que cai das pedras, saguis curiosos e um silêncio que parece guardar alguma coisa.',
      desenho: (P) => { for (let i = 0; i < 16; i++) { const x = 30 + hash(i, 1) * 170, y = 420 + hash(i, 2) * 150; if (Math.abs(x - 100) < 20 && y > 480 && y < 540) continue; P.arvore(x, y, 1 + hash(i, 3) * .4, i % 3 ? 'escura' : 'verde', i); } P.placa(190, 580); P.R(150, 560, 28, 20, '#8a6a45'); P.R(148, 556, 32, 6, '#6a4a32'); } },
    { id: 't29', cena: 29, x: 250, nome: 'Portão do Lomantão', sub: 'Estádio Lomanto Júnior', caixa: [214, 560, 180, 150],
      descricao: 'Em dia de jogo a cidade para. Torcida cantando, espetinho na porta e um goleiro que conversa com a bola.',
      desenho: (P) => { const R = P.R; P.sombra(304, 690, 84, 12, .3); P.circ(304, 632, 82, '#9aa0a6', 56); P.circ(304, 628, 78, '#c8ccd0', 52); for (let k = 0; k < 40; k++) { const a = k / 40 * Math.PI * 2, r = 70; R(304 + Math.cos(a) * r, 628 + Math.sin(a) * r * .66, 4, 4, ['#e8433a', '#f2efe6', '#2c5a9e', '#e8c24c'][k % 4]); }
        P.circ(304, 630, 58, '#5aa046', 36); R(256, 628, 96, 1, '#f2f2ee'); P.circ(304, 630, 10, '#f2f2ee', 6); P.circ(304, 630, 9, '#5aa046', 5); for (const [x, y] of [[226, 580], [382, 580]]) { R(x, y - 40, 3, 40, '#6a6e74'); R(x - 6, y - 46, 15, 8, '#f2f2ee'); } R(290, 690, 30, 12, '#2c5a9e'); } },
    { id: 't30', cena: 30, x: 4500, nome: 'Rodoviária', sub: 'Plataformas de embarque', caixa: [730, 560, 170, 116],
      descricao: 'Gente chegando, gente partindo, um engraxate que viu a cidade inteira passar e ônibus pra todo canto do mapa.',
      desenho: (P) => { const R = P.R; P.predio(740, 570, 70, 70, { topo: '#b8b4aa', parede: '#e2ddd0', fachada: 28 }); R(810, 590, 84, 8, '#b8b4aa'); for (const x of [814, 852, 888]) R(x, 598, 4, 40, '#c8c4ba');
        for (let k = 0; k < 3; k++) { const x = 816 + k * 26, col = ['#2c5a9e', '#c43c3a', '#3c8a5a'][k]; R(x, 610, 20, 40, col); R(x + 2, 614, 16, 10, '#24303a'); R(x, 636, 20, 3, '#f2c94c'); R(x + 2, 650, 4, 3, '#1c1c1c'); R(x + 14, 650, 4, 3, '#1c1c1c'); } } },
    { id: 't31', cena: 31, x: 4300, nome: 'UESB', sub: 'Ponto do circular', caixa: [920, 16, 220, 130],
      descricao: 'Módulos de aula, cantina, biblioteca e uma professora que guarda a história da cidade em caixas de sapato.',
      desenho: (P) => { const R = P.R; P.predio(930, 40, 110, 64, { topo: '#c8c4b8', parede: '#efebe0', fachada: 28, faixa: '#2c5a9e' }); P.predio(1050, 30, 80, 80, { topo: '#e8e4dc', parede: '#3a5a6a', fachada: 34 }); R(940, 112, 3, 30, '#9aa0a6'); R(932, 104, 20, 12, '#e8e4dc'); R(932, 104, 20, 2, '#2c5a9e');
        P.arvore(1020, 140, .9, 'amarela', 5); P.arvore(960, 142, .9, 'roxa', 6); } },
    { id: 't32', cena: 32, x: 300, nome: 'Lagoa das Bateias', sub: 'Pista de caminhada', caixa: [430, 560, 220, 170],
      descricao: 'Garças pescando, pedalinhos de cisne e a lenda de uma pepita no fundo. Um menino jura que ainda vai achar.',
      desenho: (P) => { const R = P.R; R(600, 650, 40, 8, '#a87a4a'); for (let k = 0; k < 40; k += 5) R(600 + k, 650, 1, 8, '#7a4a2a'); for (const [x, y] of [[470, 612], [520, 640], [560, 600]]) { R(x, y, 14, 7, '#f6f6f0'); R(x + 11, y - 7, 3, 8, '#f6f6f0'); R(x + 12, y - 8, 4, 2, '#f6f6f0'); R(x + 15, y - 7, 2, 1, '#f08a24'); R(x + 3, y - 3, 4, 3, '#e8433a'); }
        P.coqueiro(444, 700); P.coqueiro(640, 584); P.banco(470, 716); } },
    { id: 't33', cena: 33, x: 300, nome: 'Parque da Cidade', sub: 'Portão do parque', caixa: [720, 680, 200, 86],
      descricao: 'Balanço, pista de skate, dominó dos aposentados e cachorro correndo atrás de bolinha. O lugar mais feliz da cidade. Por enquanto.',
      desenho: (P) => { const R = P.R; R(740, 700, 3, 30, '#e8433a'); R(780, 700, 3, 30, '#e8433a'); R(738, 698, 48, 4, '#f2c94c'); for (const x of [752, 768]) { R(x, 702, 1, 16, '#5a5e62'); R(x - 3, 718, 7, 2, '#3a3a36'); } R(800, 708, 40, 20, '#a8aeb4'); P.circ(820, 718, 18, '#bcc0bc', 8);
        for (const [x, y] of [[860, 716], [890, 740], [730, 750]]) P.arvore(x, y, .9, 'verde', x); P.flores(840, 744, ['#e86a8a', '#f2c94c']); } },
    { id: 't34', cena: 34, x: 300, nome: 'Serra do Marçal', sub: 'Mirante na beira da serra', caixa: [0, 588, 200, 120],
      descricao: 'A cidade acaba e o mundo despenca num mar de nuvens. Quem tem coragem pula de parapente. Quem não tem, compra mel.',
      desenho: (P) => { const R = P.R; for (const x of [30, 90]) { R(x, 600, 3, 60, '#e8ecef'); R(x - 1, 598, 5, 4, '#d8dce0'); } R(110, 660, 60, 4, '#a87a4a'); for (let k = 0; k < 60; k += 10) R(110 + k, 664, 3, 10, '#6a4a2a'); R(166, 640, 2, 22, '#9aa0a6');
        for (let x = 10; x < 190; x += 6) R(x, 690, 4, 3, '#c8ccd0'); P.R(40, 664, 40, 20, '#e8833a'); for (let k = 0; k < 40; k += 8) P.R(40 + k, 664, 4, 20, '#f6ead0'); } }
  ];
  const MAPA2 = {
    chave: 'conquista2d', titulo: 'TÁXI DO SEU ZÉ · VITÓRIA DA CONQUISTA', subtitulo: 'O táxi só para nas entradas. Lá dentro, é com você.', lajotas: [72, 48], botao: 'IR DE TÁXI ▶',
    terreno: (T) => {
      T.ret(8, 0, 48, 5, { nivel: 2 }); T.ret(24, 0, 16, 2, { nivel: 3 }); T.ret(56, 0, 16, 1, { nivel: 2 });
      T.ret(1, 23, 12, 7, { nivel: 2, tipo: 'mata' }); T.oval(6, 34, 3.2, 2.2, { nivel: 0 }); T.ret(1, 30, 12, 8, { tipo: 'mata' }); T.oval(6, 34, 3.2, 2.2, { nivel: 0 });
      T.oval(33, 41, 7, 4.5, { nivel: 0 });
      T.ret(0, 37, 12, 7, { nivel: 2 }); T.ret(0, 44, 13, 4, { tipo: 'nuvem' });
      T.ret(0, 9, 13, 3, { tipo: 'pista' }); T.ret(0, 12, 13, 6, { tipo: 'pedra' });
      T.linha([[13, 20.5], [71, 20.5]], 2, { tipo: 'asfalto' }); T.linha([[40, 30.5], [71, 30.5]], 2, { tipo: 'asfalto' }); T.linha([[26.5, 7], [26.5, 47]], 2, { tipo: 'asfalto' }); T.linha([[44.5, 7], [44.5, 47]], 2, { tipo: 'asfalto' }); T.linha([[0, 15], [26, 15]], 2, { tipo: 'asfalto' }); T.linha([[12, 36], [26, 36]], 2, { tipo: 'asfalto' });
      T.ret(29, 12, 10, 4, { tipo: 'pedra' }); T.ret(29, 23, 11, 6, { tipo: 'pedra' }); T.ret(55, 11, 13, 7, { tipo: 'pedra' }); T.ret(55, 22, 11, 7, { tipo: 'pedra' }); T.ret(45, 35, 12, 7, { tipo: 'pedra' });
      T.ret(58, 35, 14, 13, { tipo: 'cafe' }); T.ret(57, 1, 14, 8, { tipo: 'pedra' });
      T.linha([[30, 6], [30, 9]], 1, { tipo: 'chao' }); T.linha([[46, 42], [56, 47]], 2, { tipo: 'chao' }); T.linha([[12, 26], [16, 26], [16, 34]], 1, { tipo: 'chao' });
    },
    objetos: (add) => {
      const caixas = PONTOS.map((L) => L.caixa);
      for (let i = 0; i < 70; i++) { const x = hash(i, 13) * 1130 + 10, y = 110 + hash(i, 17) * 540, tx = Math.floor(x / TS), ty = Math.floor(y / TS); if (!livre(x, y, caixas, 20)) continue; if ([19, 20, 21, 22, 29, 30, 31, 32].includes(ty) || [25, 26, 27, 28, 43, 44, 45, 46].includes(tx)) continue; if (tx < 13 && ty < 18) continue; if (tx > 57 && ty > 34) continue; if (Math.hypot(tx - 33, ty - 41) < 8) continue;
        const k = hash(i, 5), cor = ['#ebe8de', '#e0d6c2', '#dfe6ea', '#e8dcc8', '#f2e2a8'][i % 5]; if (k > .35) add(y, (P) => P.predio(x - 20, y - 50, 40 + (i % 3) * 8, 50 + (i % 4) * 8, { parede: cor, fachada: 18 + (i % 3) * 6, porta: i % 2 === 0 })); else add(y, (P) => P.casa(x - 16, y - 34, 34, 34, { telhado: ['#b8644a', '#9a4a34', '#c8544a'][i % 3], parede: cor, madeira: false, janelas: [4, 24], porta: 13 })); }
      for (let i = 0; i < 90; i++) { const x = hash(i, 23) * 1140 + 6, y = hash(i, 29) * 760 + 4, tx = Math.floor(x / TS), ty = Math.floor(y / TS); if (!livre(x, y, caixas, 8)) continue; if ([20, 21, 30, 31, 15, 36].includes(ty) && tx > 12) continue; if ([26, 27, 44, 45].includes(tx)) continue; if (Math.hypot(tx - 33, ty - 41) < 8 || (ty >= 44 && tx < 13) || (tx > 57 && ty > 34)) continue;
        const k = hash(i, 31); add(y, (P) => (ty < 6 ? (k > .5 ? P.pedra(x, y) : P.arvore(x, y, .7, 'escura', i)) : k > .8 ? P.arbusto(x, y, i, '#f2c94c') : P.arvore(x, y, .8 + hash(i, 4) * .4, ['verde', 'escura', 'roxa', 'amarela'][Math.floor(k * 4)], i))); }
      for (let x = 230; x < 1150; x += 70) { add(318, (P) => P.poste(x, 318)); add(478, (P) => P.poste(x + 30, 478)); }
      add(560, (P) => { for (let x = 20; x < 180; x += 40) P.arvore(x, 560, 1.1, 'escura', x); });
    },
    animarChao: (P, t) => { const R = P.R; for (let k = 0; k < 10; k++) { const y = 506 + ((t * 40 + k * 7) % 30); R(92 + (k % 3) * 4, y, 2, 4, '#e2f4ff'); } R(88, 498, 14, 8, '#c8eaff'); // cachoeira do poço escuro
      for (let k = 0; k < 8; k++) { const x = ((t * 6 + k * 30) % 200) - 10, y = 708 + (k % 3) * 18; P.c.globalAlpha = .7; P.circ(x, y, 14, '#ffffff', 5); P.c.globalAlpha = 1; } },
    animar: (P, t) => { const R = P.R;
      andar(P, t, [[[220, 340], [1150, 340], 4], [[1150, 498], [650, 498], 3], [[430, 120], [430, 760], 2], [[718, 760], [718, 120], 2], [[0, 248], [420, 248], 1]], ['#c43c3a', '#3c6aa8', '#f2f2ee', '#e8c24c', '#2a2a2a']);
      for (const x of [30, 90]) { for (let k = 0; k < 3; k++) { const a = t * 3 + k * 2.1 + x; P.c.strokeStyle = '#f2f4f6'; P.c.lineWidth = 2; P.c.beginPath(); P.c.moveTo(x + 1, 600); P.c.lineTo(x + 1 + Math.cos(a) * 14, 600 + Math.sin(a) * 14); P.c.stroke(); } } P.c.lineWidth = 1; // torres eólicas
      { const u = (t * .12) % 1, x = 168 + u * 120, y = 640 + u * 60 - Math.sin(u * 6) * 6; for (let k = -5; k <= 5; k++) R(x + k * 2, y - 10 - Math.round(Math.sqrt(1 - (k / 6) ** 2) * 3), 2, 2, k % 2 ? '#3c8ad8' : '#f2c94c'); R(x - 1, y - 2, 3, 4, '#c43c3a'); } // parapente
      for (let k = 0; k < 3; k++) { const u = (t * .03 + k / 3) % 1, a = u * Math.PI * 2; R(33 * TS + Math.cos(a) * 70, 41 * TS + Math.sin(a) * 36 - 4, 8, 4, '#f6f6f0'); R(33 * TS + Math.cos(a) * 70 + 6, 41 * TS + Math.sin(a) * 36 - 8, 2, 5, '#f6f6f0'); } // pedalinhos
      for (let k = 0; k < 40; k++) { const on = Math.sin(t * 6 + k) > .5; if (on) R(304 + Math.cos(k / 40 * Math.PI * 2) * 70, 628 + Math.sin(k / 40 * Math.PI * 2) * 46, 3, 3, '#ffffff'); } // torcida agitando
      fumaca(P, 1066, 576, t); for (let k = 0; k < 5; k++) { const u = (t * .04 + k / 5) % 1; pessoa(P, 470 + u * 170, 448 + (k % 2) * 10, ['#e86a8a', '#3c6aa8', '#f2c94c', '#7a3a8a', '#3c8a5a'][k], t); }
      for (let k = 0; k < 4; k++) { const a = t * .5 + k * 1.6, x = 600 + Math.cos(a) * (40 + k * 12), y = 40 + Math.sin(a) * 10 + k * 8; R(x - 4, y, 3, 1, '#2a2622'); R(x + 2, y, 3, 1, '#2a2622'); R(x - 1, y, 3, 1, '#2a2622'); } },
    veiculo: (P, t) => carrinho(P, 0, 0, '#f2c94c', 1, true),
    locais: PONTOS
  };
  function abrirMapa2(cenaAtual, aoIr, opts = {}) {
    if (!window.Mapa3D) return false; const visto = opts.liberado || (() => ({ ok: true }));
    const d = { ...MAPA2, locais: PONTOS.map((L) => ({ ...L, atual: L.cena === cenaAtual, estado: visto(L), previa: previaCena(L.cena, Math.max(0, L.x - 360)) })), aoIr: (id) => { const L = PONTOS.find((q) => q.id === id); if (L) aoIr?.(L.cena, L.x); } };
    return window.Mapa3D.abrir(d);
  }

  /* ---------- o táxi parado no ponto (desenhado no mundo do jogo, em tamanho real) ---------- */
  function desenharTaxi(c, x, t, perto) {
    const y = 440, R = (a, b, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(a), Math.round(b), w, h); };
    R(x - 76, y - 4, 152, 6, 'rgba(0,0,0,.22)');
    R(x - 74, y - 44, 148, 30, '#e8b83a'); R(x - 74, y - 44, 148, 4, '#ffd86a'); R(x - 76, y - 18, 152, 8, '#c8962a'); R(x - 46, y - 70, 82, 28, '#e8b83a'); R(x - 46, y - 70, 82, 4, '#ffd86a');
    R(x - 40, y - 64, 34, 20, '#9fc4d0'); R(x - 2, y - 64, 34, 20, '#9fc4d0'); R(x - 6, y - 66, 4, 24, '#e8b83a'); R(x - 38, y - 62, 6, 16, 'rgba(255,255,255,.35)');
    R(x + 4, y - 58, 14, 14, '#c99068'); R(x + 4, y - 60, 14, 4, '#b8b2a6'); R(x + 6, y - 50, 10, 2, '#d6d0c4'); // Seu Zé
    for (let k = 0; k < 18; k++) R(x - 72 + k * 8, y - 32, 4, 4, k % 2 ? '#1c1c1c' : '#f6f6f0'); for (let k = 0; k < 18; k++) R(x - 68 + k * 8, y - 28, 4, 4, k % 2 ? '#f6f6f0' : '#1c1c1c');
    const pisca = Math.floor(t * 2) % 2; R(x - 20, y - 82, 40, 12, '#1c1c1c'); R(x - 18, y - 80, 36, 8, pisca ? '#fff2a0' : '#e8d070'); c.font = '9px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#1c1c1c'; c.fillText('TÁXI', x, y - 73);
    R(x + 70, y - 40, 6, 6, '#fff2b0'); R(x - 76, y - 40, 4, 8, '#e8433a');
    for (const wx of [x - 46, x + 46]) { R(wx - 14, y - 16, 28, 18, '#1c1c1c'); R(wx - 7, y - 10, 14, 8, '#9aa0a6'); }
    if (perto) { const dy = Math.round(Math.sin(t * 5) * 3); R(x + 30, y - 110 + dy, 22, 22, '#2a1a14'); R(x + 32, y - 108 + dy, 18, 18, '#ffd24a'); c.fillStyle = '#2a1a14'; c.font = '14px Pixel, monospace'; c.fillText('?', x + 41, y - 93 + dy); }
    c.textAlign = 'left';
  }
  const CampanhaTaxi = {
    pontos: () => PONTOS.map(({ id, cena, x, nome, sub }) => ({ id, cena, x, nome, sub })),
    perto: (cena, x) => { const p = PONTOS.find((q) => q.cena === cena && Math.abs(q.x - x) < 90); return p ? { id: p.id, x: p.x, rotulo: 'CHAMAR O TÁXI DO SEU ZÉ', botao: 'TÁXI' } : null; },
    desenhar: (c, o) => { const hx = Number(o.player?.x) || -9999, t = Number(o.time) || 0; for (const p of PONTOS) if (p.cena === Number(o.scene) && Math.abs(p.x - (Number(o.camera) || 0) - 480) < 640) desenharTaxi(c, p.x, t, Math.abs(p.x - hx) < 90); },
    abrir: abrirMapa2
  };
  window.MapasJogo = Object.freeze({ abrirCampanha1: abrirMapa1, abrirCampanha2: abrirMapa2, campanha1: () => C1.map(({ id, nome, sub, descricao }) => ({ id, nome, sub, descricao })), taxi: CampanhaTaxi });
  window.CampanhaTaxi = Object.freeze(CampanhaTaxi);
})();
