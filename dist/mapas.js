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
  const fumaca = (P, x, y, t) => { for (let k = 0; k < 5; k++) { const q = (t * .4 + k / 5) % 1; P.c.globalAlpha = (1 - q) * .55; P.circ(x + Math.sin(t + k) * 3 + q * 6, y - q * 26, 2 + q * 4, '#f2f2ee'); } P.c.globalAlpha = 1; };

  const h = hash;
  /* ---------- ajudantes do mapa orgânico ---------- */
  const A = window.Mapa3D.arte, shade = A.shade;
  const txt = (P, s, x, y, col, o = {}) => { const f = window.CampanhaCamadas?.kit?.pxText; if (f) return f(P.c, s, x, y, col, o); P.c.font = '6px monospace'; P.c.fillStyle = col; P.c.textAlign = 'center'; P.c.fillText(s, x, y + 5); P.c.textAlign = 'left'; return 0; };
  const caixasDe = (lista) => lista.map((L) => { const [x, y, w, h] = L.caixa, [dx, dy] = L.desloc || [0, 0]; return [x + dx, y + dy, w, h]; });
  // lado de uma curva (faixa da mão de ida/volta)
  const faixa = (pl, off, rev) => { const o = pl.map((p, k) => { const a = pl[Math.max(0, k - 1)], b = pl[Math.min(pl.length - 1, k + 1)], dx = b[0] - a[0], dy = b[1] - a[1], l = Math.hypot(dx, dy) || 1; return [p[0] - dy / l * off, p[1] + dx / l * off]; }); return rev ? o.reverse() : o; };
  const cruza = (pl, y) => { let best = pl[0], d = 1e9; for (const p of pl) { const e = Math.abs(p[1] - y); if (e < d) { d = e; best = p; } } return best[0]; };
  // veículo em qualquer direção (de lado quando anda na horizontal, de frente/costas na vertical)
  function veiculo(P, x, y, cor, ang, tipo) { const R = P.R, vx = Math.cos(ang), vy = Math.sin(ang); x = Math.round(x); y = Math.round(y);
    if (tipo === 'moto') { R(x - 4, y, 9, 1, 'rgba(0,0,0,.3)'); R(x - 4, y - 3, 8, 2, '#2a2a2a'); R(x - 4, y - 2, 2, 2, '#1c1c1c'); R(x + 3, y - 2, 2, 2, '#1c1c1c'); R(x - 2, y - 5, 5, 2, cor); R(x - 1, y - 9, 3, 4, '#3c6aa8'); R(x - 1, y - 11, 3, 2, cor); return; }
    if (tipo === 'bus') { if (Math.abs(vy) > Math.abs(vx) * 1.1) { R(x - 7, y - 1, 15, 3, 'rgba(0,0,0,.3)'); R(x - 7, y - 20, 14, 20, cor); R(x - 6, vy > 0 ? y - 6 : y - 19, 12, 5, '#9fc4d0'); R(x - 7, y - 11, 14, 2, '#f2f2ee'); return; }
      const d = vx >= 0 ? 1 : -1; R(x - 15, y, 31, 2, 'rgba(0,0,0,.3)'); R(x - 15, y - 13, 30, 13, cor); R(x - 15, y - 13, 30, 1, '#ffffff66'); for (let k = 0; k < 5; k++) R(x - 12 + k * 5, y - 10, 4, 4, '#9fc4d0'); R(x - 15, y - 4, 30, 1, '#f2f2ee'); R(d > 0 ? x + 12 : x - 15, y - 10, 3, 6, '#9fc4d0'); R(x - 11, y, 4, 2, '#1c1c1c'); R(x + 7, y, 4, 2, '#1c1c1c'); return; }
    if (Math.abs(vy) > Math.abs(vx) * 1.1) { R(x - 6, y - 1, 13, 3, 'rgba(0,0,0,.28)'); R(x - 5, y - 13, 10, 14, cor); R(x - 5, y - 13, 10, 1, '#ffffff66'); R(x - 4, vy > 0 ? y - 4 : y - 12, 8, 3, '#9fc4d0'); R(x - 4, y - 8, 8, 3, shade(cor, .82)); for (const [a, b] of [[-6, -11], [5, -11], [-6, -4], [5, -4]]) R(x + a, y + b, 1, 3, '#1c1c1c');
      if (vy > 0) { R(x - 4, y, 2, 1, '#fff2b0'); R(x + 2, y, 2, 1, '#fff2b0'); } else { R(x - 4, y - 13, 2, 1, '#e8433a'); R(x + 2, y - 13, 2, 1, '#e8433a'); } if (tipo === 'taxi') R(x - 2, y - 10, 4, 2, '#1c1c1c'); return; }
    carrinho(P, x, y, cor, vx >= 0 ? 1 : -1, tipo === 'taxi'); }
  const naRua = (P, t, pl, n, cores, vel = 22, fase = 0, tipo) => { const tr = A.trilho(pl); for (let j = 0; j < n; j++) { const p = tr.em(t * vel / tr.total + j / n + fase); veiculo(P, p.x, p.y + 3, cores[j % cores.length], p.ang, typeof tipo === 'function' ? tipo(j) : tipo); } };
  // ocupação: o que já foi colocado no mapa, para nada nascer em cima de nada
  function Lote(Tr, caixas) {
    const rects = caixas.map(([x, y, w, h]) => [x - 6, y - 6, w + 12, h + 12]), bate = (x, y, w, h) => rects.some(([a, b, c, d]) => x < a + c && x + w > a && y < b + d && y + h > b);
    return {
      bate, marca: (x, y, w, h) => rects.push([x, y, w, h]),
      ponto: (x, y, r = 7, aceita = Tr.livre) => { if (!aceita(x, y) || bate(x - r, y - r * .6, r * 2, r * 1.2)) return false; rects.push([x - r, y - r * .6, r * 2, r * 1.2]); return true; },
      area: (x, y, w, h, aceita = Tr.livre) => { if (bate(x, y, w, h)) return false; for (let yy = y + h * .45; yy <= y + h; yy += 6) for (let xx = x; xx <= x + w; xx += 6) if (!aceita(xx, yy)) return false; rects.push([x, y, w, h]); return true; }
    };
  }
  const tipoEh = (Tr, ...tipos) => (x, y) => Tr.nivelEm(x, y) > 0 && tipos.includes(Tr.tipoEm(x, y)) && Tr.px.wd[Math.round(y) * Tr.px.W + Math.round(x)] < 0;
  // peças de referência (desenhadas uma vez)
  const pecas = {
    placaTaxi: (P, x, y) => { const R = P.R; R(x, y - 16, 2, 16, '#5a5e62'); R(x - 7, y - 24, 16, 9, '#1c1c1c'); R(x - 6, y - 23, 14, 7, '#f2c94c'); txt(P, 'TAXI', x + 1, y - 22, '#1c1c1c'); R(x - 1, y, 5, 1, 'rgba(0,0,0,.25)'); },
    outdoor: (P, x, y, s, bg, fg) => { const R = P.R, w = Math.max(40, s.length * 4 + 10); P.sombra(x + w / 2 + 3, y + 1, w / 2, 3, .22); R(x + 6, y - 12, 2, 12, '#5a5e62'); R(x + w - 8, y - 12, 2, 12, '#5a5e62'); R(x - 1, y - 27, w + 2, 17, '#2a2a2a'); R(x, y - 26, w, 15, bg); txt(P, s, x + w / 2, y - 21, fg); },
    cacto: (P, x, y) => { const R = P.R; P.sombra(x + 1, y, 5, 2); P.circ(x, y - 3, 4, '#3f7a3a', 3); P.circ(x - 1, y - 4, 2, '#5a9a4a', 1); for (let k = -3; k <= 3; k += 2) R(x + k, y - 6, 1, 5, '#2f5e2a'); P.circ(x, y - 6, 2, '#c43c5a', 1); R(x, y - 8, 1, 1, '#ff8aa0'); },
    antena: (P, x, y) => { const R = P.R; P.sombra(x + 6, y, 8, 2); for (let k = 0; k < 44; k += 4) { const w = Math.round(6 - k / 10); R(x - w, y - k - 4, 1, 4, '#8a9096'); R(x + w, y - k - 4, 1, 4, '#8a9096'); R(x - w, y - k - 2, w * 2 + 1, 1, '#a8aeb4'); } R(x, y - 50, 1, 6, '#5a5e62'); R(x - 3, y - 30, 3, 4, '#e8ecef'); },
    pessoaG: (P, x, y, roupa, pele = '#d9a57f', cabelo = '#2a201a') => { const R = P.R; R(x - 3, y, 7, 1, 'rgba(0,0,0,.25)'); R(x - 2, y - 3, 2, 3, '#2a2f3a'); R(x + 1, y - 3, 2, 3, '#2a2f3a'); R(x - 3, y - 9, 7, 6, roupa); R(x - 2, y - 13, 5, 4, pele); R(x - 2, y - 14, 5, 2, cabelo); }
  };

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
         P.R(470, 136, 80, 9, '#2c5a9e'); txt(P, 'COLÉGIO ADVENTISTA', 510, 138, '#f2efe6');for (const x of [440, 572]) P.arbusto(x, 146, x, '#e86a8a'); } },
    { id: 9, nome: 'Pátio da escola', sub: 'O intervalo mais longo do mundo', caixa: [690, 52, 132, 120],
      descricao: 'Na hora do intervalo tudo pode acontecer. Alguém por ali precisa de ajuda... e outra pessoa está doida por uma revanche.',
      desenho: (P) => { const R = P.R; // pátio: prédio branco com faixa azul, piso claro, coqueiro no canteiro, bandeirinhas e bancos
        R(692, 54, 128, 24, '#efebe0'); R(692, 52, 128, 4, '#3c6aa8'); R(692, 70, 128, 4, '#2c5a9e'); for (let x = 698; x < 816; x += 14) { R(x, 58, 9, 8, '#3a5a8a'); R(x, 58, 3, 2, '#9ac8f0'); } R(750, 62, 12, 12, '#5a6f86'); R(714, 46, 50, 8, '#2c5a9e'); txt(P, 'PÁTIO', 739, 47, '#f2efe6');
        R(692, 78, 128, 92, '#d8d4cc'); for (let y = 78; y < 170; y += 10) R(692, y, 128, 1, '#c4c0b8'); for (let x = 692; x < 820; x += 16) R(x, 78, 1, 92, '#c4c0b8');
        R(700, 118, 20, 20, '#8a8478'); R(702, 120, 16, 16, '#6a5a44'); P.coqueiro(710, 132); P.banco(732, 104); P.banco(772, 104); P.banco(752, 150); P.banco(796, 140);
        for (const x of [696, 816]) R(x, 80, 2, 22, '#7a8086'); for (let k = 0; k < 15; k++) { const x = 698 + k * 8, y = 82 + Math.round(Math.sin(k / 14 * Math.PI) * 5); R(x, y, 5, 4, ['#e8433a', '#f2c94c', '#3c8a5a', '#3c6aa8', '#e86a8a'][k % 5]); R(x + 1, y + 4, 3, 1, '#00000033'); }
        R(780, 120, 30, 12, '#a8643a'); R(780, 120, 30, 2, '#c8844a'); txt(P, 'SHOW', 795, 123, '#f2e2b8'); pessoa(P, 760, 132, '#e8433a'); pessoa(P, 790, 160, '#3c6aa8'); pessoa(P, 724, 160, '#f2c94c'); } },
    { id: 6, nome: 'Caderno do Caos', sub: 'O monstro gigante', caixa: [432, 186, 150, 104],
      descricao: 'As páginas viraram sozinhas. Os rabiscos ganharam vida. E aquela coisa enorme desenhada na última folha... acordou.',
      desenho: (P) => { const R = P.R; // caderno roxo gigante aberto, espiral, lápis enormes e o rabisco-monstro
        P.sombra(510, 286, 72, 8, .3); R(438, 204, 144, 82, '#4a1e6a'); R(438, 204, 144, 3, '#6a3a8a'); R(444, 210, 64, 70, '#f0e8f8'); R(512, 210, 64, 70, '#ebe2f4');
        for (let k = 0; k < 9; k++) { R(446, 218 + k * 7, 60, 1, '#b89ad8'); R(514, 218 + k * 7, 60, 1, '#b89ad8'); } R(454, 210, 1, 70, '#e86a8a'); for (let k = 0; k < 10; k++) { P.circ(510, 213 + k * 7, 3, '#5a5e64', 2); P.circ(510, 213 + k * 7, 2, '#c8ccd0', 1); }
        for (let k = 0; k < 5; k++) R(462 + k * 8, 262 - (k % 2) * 4, 6, 2, '#2a2a3a'); R(462, 232, 24, 2, '#2a2a3a'); R(470, 240, 30, 2, '#2a2a3a'); txt(P, 'TEM FOME', 476, 246, '#7a3a8a');
        for (const [x, cor] of [[446, '#f2c94c'], [566, '#e8433a'], [574, '#3c6aa8']]) { R(x, 188, 6, 44, cor); R(x, 188, 2, 44, '#ffffff55'); R(x, 182, 6, 6, '#f6c8c8'); R(x, 186, 6, 2, '#c8ccd0'); R(x + 1, 232, 4, 4, '#e8d0a8'); R(x + 2, 236, 2, 3, '#2a2a2a'); }
        R(528, 222, 32, 36, '#7a3a8a'); R(524, 214, 40, 16, '#8a4a9a'); R(532, 219, 8, 6, '#ffffff'); R(548, 219, 8, 6, '#ffffff'); R(535, 221, 3, 3, '#1c1c1c'); R(551, 221, 3, 3, '#1c1c1c'); for (let k = 0; k < 6; k++) R(532 + k * 4, 232, 2, 3, '#ffffff'); R(518, 236, 12, 4, '#7a3a8a'); R(558, 234, 12, 4, '#7a3a8a');
        for (const [x, y] of [[452, 276], [570, 270], [500, 284]]) P.circ(x, y, 3, '#3a1a4a', 2); } },
    { id: 3, nome: 'A quadra', sub: 'O bolo está por perto', caixa: [656, 336, 132, 100], desloc: [12, 0],
      descricao: 'O som da bola quicando chega até a rua. Tem alguém lá dentro que sabe muito bem onde o bolo foi parar...',
      desenho: (P) => { const R = P.R; // quadra de piso cor de tijolo com faixas verdes, cestas, alambrado e bandeirinhas
        R(666, 352, 124, 82, '#c8643a'); R(666, 352, 124, 6, '#3c8a5a'); R(666, 428, 124, 6, '#3c8a5a'); R(672, 358, 112, 1, '#f2f2ee'); R(672, 427, 112, 1, '#f2f2ee'); R(727, 358, 2, 70, '#f2f2ee'); P.circ(728, 392, 12, '#f2f2ee', 9); P.circ(728, 392, 10, '#c8643a', 7);
        for (const x of [676, 776]) { R(x, 380, 3, 26, '#c8ccd0'); R(x - 4, 378, 11, 8, '#f6f6f0'); R(x - 1, 386, 5, 3, '#e8433a'); }
        for (let k = 0; k <= 120; k += 8) R(664 + k, 340, 2, 14, '#7a8086'); R(664, 342, 122, 1, '#9aa0a6'); R(664, 348, 122, 1, '#9aa0a6');
        for (let k = 0; k < 15; k++) { const x = 666 + k * 8, y = 336 + Math.round(Math.sin(k / 14 * Math.PI) * 4); R(x, y, 5, 4, ['#e8433a', '#f2c94c', '#3c8a5a', '#3c6aa8'][k % 4]); }
        R(694, 410, 30, 6, '#a8643a'); R(694, 410, 30, 2, '#c8844a'); P.circ(752, 400, 3, '#e8833a'); R(751, 398, 1, 5, '#7a3a10'); pessoa(P, 704, 404, '#2c5a9e'); } },
    { id: 4, nome: 'Praça Camacan', sub: 'Uma pausa na resenha', caixa: [470, 380, 176, 150], desloc: [-20, 0],
      descricao: 'Banco de praça, sorvete e fofoca fresquinha. Às vezes, uma pausa é tudo de que a resenha precisa.',
      desenho: (P) => { const R = P.R; // praça na beira do rio: fonte, coqueiros, quiosque, placa e mureta
        P.fonte(560, 452); for (const [x, y] of [[494, 420], [626, 420], [494, 516], [626, 516]]) P.coqueiro(x, y); for (const [x, y] of [[520, 420], [590, 420], [520, 494], [590, 494]]) P.banco(x, y);
        for (const [x, y] of [[504, 470], [612, 470]]) P.flores(x, y, ['#e86a8a', '#f2c94c', '#ffffff']); P.poste(482, 456); P.poste(636, 456);
        R(476, 386, 4, 140, '#c8ccd0'); R(476, 386, 1, 140, '#eef0f2'); for (let y = 390; y < 526; y += 10) R(472, y, 4, 2, '#a8aeb4');
        R(530, 384, 60, 12, '#f2f0e8'); R(530, 384, 60, 2, '#2c5a9e'); txt(P, 'PRAÇA CAMACAN', 560, 388, '#2c5a9e'); R(536, 396, 2, 8, '#7a8086'); R(582, 396, 2, 8, '#7a8086');
        R(600, 520, 30, 14, '#e8e4dc'); for (let k = 0; k < 30; k += 6) R(600 + k, 512, 3, 8, k % 12 ? '#3c8ab0' : '#f6f6f0'); R(600, 512, 30, 2, '#2c5a9e'); R(606, 524, 18, 6, '#9ad0e8'); pessoa(P, 540, 470, '#e8833a'); pessoa(P, 584, 506, '#7a3a8a'); } },
    { id: 2, nome: 'Academia do Caleb', sub: 'Caleb e o shape', caixa: [856, 196, 120, 100],
      descricao: 'Dizem que ninguém sai de lá do mesmo jeito que entrou. Os reflexos que o digam. E o espelho também.',
      desenho: (P) => { const R = P.R; // academia: paredes verde-escuras, janelões com persiana, placa com halter e banco com pesos
        P.predio(866, 216, 100, 72, { topo: '#2e3a34', parede: '#3f5a4c', fachada: 32, caixa: false, porta: false });
        for (const x of [872, 904, 936]) { R(x, 258, 24, 18, '#24302a'); R(x + 1, 259, 22, 16, '#9ac8d8'); for (let y = 260; y < 274; y += 3) R(x + 1, y, 22, 1, '#d8e8ec'); }
        R(906, 278, 16, 10, '#1c2420'); R(907, 279, 14, 9, '#7ab0c0'); R(878, 200, 76, 14, '#1c1c1c'); R(878, 200, 76, 2, '#e8433a'); txt(P, 'CALEB', 906, 204, '#f2c94c');
        R(934, 205, 14, 2, '#c8ccd0'); R(932, 202, 3, 8, '#5a5e64'); R(947, 202, 3, 8, '#5a5e64'); R(858, 290, 26, 4, '#5a5e64'); for (const x of [856, 880]) { R(x, 286, 4, 10, '#2a2a2a'); } R(944, 288, 6, 8, '#f2f2ee'); R(945, 286, 4, 2, '#3c8ab0');
        { const y = 236; P.sombra(916, y + 12, 44, 4, .3); R(880, y - 2, 72, 5, '#3a3f44'); R(880, y - 2, 72, 2, '#c8ccd0'); R(880, y + 2, 72, 1, '#2a2e32'); // haltere gigante em cima da academia
          for (const [x, w, h, cor] of [[872, 8, 26, '#1c1c20'], [864, 7, 20, '#c43c3a'], [952, 8, 26, '#1c1c20'], [960, 7, 20, '#c43c3a']]) { R(x - 1, y - h / 2 - 1, w + 2, h + 2, '#0a0a0c'); R(x, y - h / 2, w, h, cor); R(x, y - h / 2, 2, h, '#ffffff33'); R(x, y - h / 2, w, 2, '#ffffff22'); }
          R(856, y - 4, 7, 9, '#5a5e64'); R(968, y - 4, 7, 9, '#5a5e64'); txt(P, '200KG', 916, y - 12, '#f2c94c'); } } },
    { id: 8, nome: 'Bigodon', sub: 'Davi Costa e Vitor', caixa: [848, 340, 116, 112],
      descricao: 'Tesoura afiada, espelho que parece mágico e a melhor conversa da cidade. Você sai de lá com outro visual?',
      desenho: (P) => { const R = P.R; // barbearia: parede creme e madeira, toldo listrado, placa de bigode, poste de barbeiro e cadeira vermelha na vitrine
        P.casa(868, 388, 78, 58, { telhado: '#5a3a2a', parede: '#ecd6a8', madeira: true, paredeH: 26, janelas: [8, 58], porta: 34 });
        for (let k = 0; k < 78; k += 6) R(868 + k, 412, 6, 6, k % 12 ? '#f2f2ee' : '#c43c3a'); R(868, 418, 78, 1, '#00000033');
        R(882, 344, 52, 13, '#2a1a10'); R(883, 345, 50, 11, '#3a2a1a'); txt(P, 'BIGODON', 908, 347, '#e8c66a'); R(890, 357, 2, 10, '#5a3820'); R(924, 357, 2, 10, '#5a3820');
        R(858, 404, 6, 30, '#f2f2ee'); for (let k = 0; k < 10; k++) R(858, 404 + k * 3, 6, 2, k % 3 === 0 ? '#c43c3a' : k % 3 === 1 ? '#2c5a9e' : '#f2f2ee'); R(857, 401, 8, 3, '#c8ccd0'); R(857, 434, 8, 3, '#c8ccd0');
        R(878, 424, 10, 8, '#c43c3a'); R(879, 422, 8, 3, '#e8433a'); R(926, 424, 10, 8, '#c43c3a'); R(927, 422, 8, 3, '#e8433a');
        { const cx = 907, cy = 380; P.sombra(cx + 4, cy + 12, 44, 5, .35); // bigode gigante em cima da barbearia
          for (const lado of [-1, 1]) { for (let k = 0; k < 30; k++) { const t = k / 29, x = cx + lado * (2 + t * 42), y = cy - Math.sin(t * Math.PI) * 6 + t * t * 5 - (t > .82 ? (t - .82) * 50 : 0), esp = Math.round(13 * (1 - t * .75)); R(x - 2, y - esp / 2 - 2, 4, esp + 4, '#0e0806'); }
            for (let k = 0; k < 30; k++) { const t = k / 29, x = cx + lado * (2 + t * 42), y = cy - Math.sin(t * Math.PI) * 6 + t * t * 5 - (t > .82 ? (t - .82) * 50 : 0), esp = Math.round(13 * (1 - t * .75)); R(x - 1, y - esp / 2, 3, esp, '#3a2418'); if (k % 3 === 1) R(x - 1, y - esp / 2 + 1, 3, 2, '#7a5238'); } }
          R(cx - 4, cy - 7, 8, 13, '#0e0806'); R(cx - 3, cy - 6, 6, 11, '#3a2418'); R(cx - 2, cy - 5, 2, 3, '#7a5238'); } } },
    { id: 10, nome: 'Casa de Rayssa', sub: 'As garotas e a resenha', caixa: [652, 556, 120, 96], desloc: [16, 0],
      descricao: 'Entra, mas limpa o tênis. As garotas estão reunidas e, lá dentro, tem um segredo elétrico esperando por você.',
      desenho: (P) => { const R = P.R; // casa aconchegante: parede pêssego, janelões com cortina rosa, vasos de planta e jardim
        P.casa(670, 570, 84, 64, { telhado: '#d06a4a', parede: '#f6d8b8', paredeH: 28, janelas: [6, 62], porta: 36 });
        for (const x of [676, 732]) { R(x - 1, 608, 18, 14, '#7a4a2a'); R(x, 609, 16, 12, '#bfe0f0'); R(x, 609, 5, 12, '#f29ab8'); R(x + 11, 609, 5, 12, '#f29ab8'); R(x, 609, 16, 2, '#e86a8a'); R(x + 6, 614, 4, 4, '#3c8a5a'); }
        for (const x of [664, 756]) { R(x, 626, 8, 7, '#c8643a'); R(x, 626, 8, 2, '#e8844a'); P.circ(x + 4, 622, 5, '#3f8a30', 4); P.circ(x + 3, 620, 2, '#58a83c', 2); }
        P.cercaH(660, 648, 104); P.flores(666, 636, ['#e86a8a', '#f2c94c', '#b86ad8']); P.flores(736, 636, ['#e86a8a', '#ffffff']); R(704, 556, 26, 9, '#f6eadc'); R(704, 556, 26, 1, '#e86a8a'); txt(P, 'RAYSSA', 717, 558, '#c8546a'); } },
    { id: 11, nome: 'Baile funk', sub: 'Ollyan e a perseguição', caixa: [836, 556, 160, 120], desloc: [16, 0],
      descricao: 'O grave treme o chão, as luzes não param e a pista está cheia. E tem um carro por ali que não devia estar no céu...',
      desenho: (P) => { const R = P.R; // baile de rua: palco com caixas de som, luzes coloridas, varal de lâmpadas e a multidão
        R(846, 574, 140, 90, '#2a2440'); for (let y = 574; y < 664; y += 6) R(846, y, 140, 1, '#322c4a'); R(856, 578, 120, 18, '#1a1626'); R(856, 578, 120, 2, '#5a4a7a'); R(896, 584, 40, 8, '#3a3a46'); R(900, 586, 32, 4, '#7af0ff');
        for (const x of [858, 958]) { R(x, 580, 16, 24, '#14141a'); P.circ(x + 8, 587, 4, '#5a5a66'); P.circ(x + 8, 598, 4, '#5a5a66'); P.circ(x + 8, 587, 2, '#2a2a30'); P.circ(x + 8, 598, 2, '#2a2a30'); }
        R(870, 562, 92, 12, '#1c1626'); R(870, 562, 92, 2, '#ff3a8a'); txt(P, 'BAILE FUNK', 916, 566, '#ff6ab8');
        P.c.globalAlpha = .28; for (const [x, cor] of [[880, '#ff3a8a'], [916, '#3af0ff'], [952, '#ffe14a']]) { P.c.fillStyle = cor; P.c.beginPath(); P.c.moveTo(x, 596); P.c.lineTo(x - 22, 660); P.c.lineTo(x + 22, 660); P.c.fill(); } P.c.globalAlpha = 1;
        for (let k = 0; k < 18; k++) { const x = 850 + k * 7.6; R(x, 606 + Math.round(Math.sin(k) * 2), 2, 2, ['#ff3a8a', '#ffe14a', '#3af0ff', '#7af07a'][k % 4]); } R(848, 605, 136, 1, '#5a5a66');
        for (let k = 0; k < 26; k++) { const x = 856 + (k * 37) % 120, y = 624 + Math.floor(k / 6) * 9 + (k % 2) * 3; pessoa(P, x, y, ['#e8433a', '#f2c94c', '#3c8ab0', '#7af07a', '#ff6ab8', '#f2f2ee'][k % 6]); } } },
    { id: 5, nome: 'Favela do Reeis', sub: 'Do beco ao rei', caixa: [800, 0, 224, 196],
      descricao: 'Becos que sobem, escadas que não acabam, pipa no céu e um nome que todo mundo respeita lá em cima.',
      desenho: (P) => { const cores = [['#f2c4c4', '#c8544a'], ['#f2e2a8', '#d0683a'], ['#c8dcf0', '#8a8e94'], ['#d4ecc8', '#c8544a'], ['#e8c8e8', '#d0683a'], ['#f0d0a0', '#8a8e94'], ['#c8e8e0', '#c8544a']]; let i = 0;
        for (const [y0, x0, x1] of [[132, 812, 1012], [84, 860, 1012], [36, 920, 1012]]) for (let x = x0; x < x1 - 30; x += 36) { const [par, tel] = cores[i++ % cores.length]; P.casa(x, y0 - (i % 2) * 4, 32, 34, { telhado: tel, parede: par, madeira: false, paredeH: 16, janelas: [4], porta: 18 }); }
        escada(P, 830, 152, 10); escada(P, 880, 102, 10); escada(P, 940, 54, 10); for (const [x, y] of [[822, 120], [906, 72], [966, 26], [1000, 120]]) { P.R(x, y, 9, 7, '#3c6aa8'); P.R(x, y, 9, 2, '#6a9ad0'); } P.R(990, 10, 2, 26, '#5a5a56'); P.R(992, 10, 14, 9, '#e8433a'); } }
  ];
  let RIO1 = [], TR1 = null; const RUAS1 = {};
  const MAPA1 = {
    chave: 'itabuna2d', titulo: 'CARRO A GÁS · MAPA DE ITABUNA', subtitulo: 'Escolha um lugar. O carro do seu pai voa até lá.', lajotas: [64, 44], voa: true, ilha: { margem: 300 }, relevo: true,
    terreno: (T) => {
      // morro da favela em três degraus, com beiradas tortas
      T.poli([[51.2, -1.5], [51.6, 3.8], [51, 8.2], [51.4, 10.8], [55, 10.5], [59.5, 11], [65, 10.5], [65, -1.5]], { nivel: 2 });
      T.poli([[52.9, -1.5], [53.5, 3.5], [53.1, 7.3], [57, 7.6], [61, 7.1], [65, 7.5], [65, -1.5]], { nivel: 3 });
      T.poli([[57.3, -1.5], [57.7, 2.5], [58.6, 4.4], [62, 4.1], [65, 4.6], [65, -1.5]], { nivel: 4 });
      // morro do cacau (sudoeste) e mata no alto do campo
      T.poli([[-1.5, 35.6], [6, 35], [12, 36.6], [17.2, 35.8], [18.6, 40], [17.4, 45.5], [-1.5, 45.5]], { nivel: 2, tipo: 'mata' });
      T.poli([[-1.5, -1.5], [19, -1.5], [18.4, 2.4], [11, 3.1], [4, 2.2], [-1.5, 3.4]], { tipo: 'mata' });
      // roça: trigal, horta, açude e o campo do Mota
      T.poli([[0.4, 15.4], [5, 14.8], [5.8, 19.2], [5.2, 24.6], [0.4, 25]], { tipo: 'trigo' });
      T.poli([[1, 26.4], [6.6, 26], [7.2, 30.6], [1.4, 31]], { tipo: 'plantacao' });
      T.oval(13.6, 28.6, 2.6, 1.5, { nivel: 0 });
      T.retR(4, 4, 12, 8, .8, { tipo: 'campo' });
      // Rio Cachoeira serpenteando, com prainhas
      T.curva([[20, 3], [19.8, 5], [22.6, 11], [21.4, 15]], 6.4, { tipo: 'areia' }); T.curva([[22.2, 28], [21.8, 30], [24.6, 36], [23.6, 42]], 6.4, { tipo: 'areia' });
      RIO1 = T.curva([[21.6, -1.5], [19.8, 5], [22.6, 11], [21, 17], [23.5, 24], [21.8, 30], [24.6, 36], [23.4, 45.5]], 4, { nivel: 0 });
      // trilhas de terra na roça
      T.curva([[20.5, 19.75], [16, 19.2], [12.5, 20.4], [10.2, 18.4], [9.6, 14.6], [10, 12.2]], 1.6, { tipo: 'chao' });
      T.curva([[12.5, 20.4], [12.6, 23.4], [10.6, 25.6], [8.6, 25.6]], 1.4, { tipo: 'chao' });
      T.curva([[20.5, 33.9], [16, 34.6], [12, 33.2], [8.6, 34.6], [6.6, 37.6], [5, 41], [4, 45.5]], 1.5, { tipo: 'chao' });
      // ruas de paralelepípedo da cidade (nenhuma é reta)
      RUAS1.n = T.curva([[19.6, 19.75], [24, 19.1], [28, 19.9], [33, 20.6], [38, 19.6], [42, 19.2], [47, 20.1], [52, 20.6], [57, 19.4], [61, 19.9], [65.5, 20.4]], 1.9, { tipo: 'pedra' });
      RUAS1.s = T.curva([[19.6, 33.9], [25, 34.6], [30, 33.4], [35, 33.9], [40, 34.6], [45, 33.6], [50, 34], [56, 34.5], [60, 33.6], [65.5, 34]], 1.9, { tipo: 'pedra' });
      RUAS1.a = T.curva([[41.8, -1.5], [41.6, 4], [40.2, 9.5], [39.2, 13], [40.4, 17], [40.6, 20], [39.4, 24.5], [39.2, 28], [40.4, 32], [41, 37], [40.1, 41.5], [41.2, 45.5]], 1.6, { tipo: 'pedra' });
      RUAS1.b = T.curva([[52.4, 10.4], [51.2, 14], [50.8, 17.5], [52, 20], [52.3, 23], [51.2, 27], [50.6, 30], [51.6, 34], [52.1, 37], [51.4, 41], [52, 45.5]], 1.6, { tipo: 'pedra' });
      RUAS1.c = T.curva([[26, 19.6], [26.4, 15], [26, 12.2], [27.4, 10.4]], 1.6, { tipo: 'pedra' });
      // pátios, praça, quadra e estacionamento do baile
      T.poli([[26.6, 9.4], [30, 8.7], [36, 8.8], [38.2, 9.6], [37, 11], [31, 11.3], [27.6, 10.9]], { tipo: 'pedra' }); T.poli([[43.4, 4.4], [45.5, 3.4], [48.8, 3.6], [50.2, 5.2], [50, 8.8], [48.4, 10.2], [44.6, 10], [43.2, 8]], { tipo: 'pedra' }); T.oval(33.6, 28.3, 5.6, 4.4, { tipo: 'pedra' });
      T.curva([[47.6, 10.4], [48.4, 13], [47.4, 16], [48.2, 18.6]], 1.1, { tipo: 'chao' }); T.curva([[30, 32.4], [27.6, 30], [25.6, 27], [26.2, 23.5], [25.2, 21]], 1, { tipo: 'chao' }); T.curva([[37.6, 25.2], [38.6, 23.4]], 1, { tipo: 'chao' });
      T.retR(42.5, 21.8, 7.4, 5.4, .3, { tipo: 'quadra' }); T.retR(52.9, 41.8, 10.8, 3, .6, { tipo: 'asfalto' });
    },
    objetos: (add, Tr) => {
      TR1 = Tr; const caixas = caixasDe(C1), lote = Lote(Tr, caixas), R0 = (f) => f;
      // pontes onde as ruas cruzam o rio
      for (const yy of [19.75 * TS, 33.9 * TS]) { const x = cruza(RIO1, yy); lote.marca(x - 48, yy - 20, 96, 40); add(yy + 14, (P) => ponte(P, x - 46, yy - 14, 92, 28)); }
      // ---- referências da campanha (antes do resto, para garantir o lugar) ----
      const ref = (x, y, w, h, f) => { lote.marca(x - 4, y - 4, w + 8, h + 8); add(y + h, f); };
      ref(232, 222, 60, 52, (P) => { const R = P.R, x = 238, y = 236; // oficina do Lucas, com as três peças do carro na bancada
        P.sombra(x + 26, y + 32, 32, 5, .25); R(x, y, 50, 30, '#a87a54'); for (let k = 0; k < 50; k += 5) R(x + k, y, 1, 30, '#8a5e3a'); R(x + 4, y + 6, 42, 24, '#3a2a1e');
        R(x + 8, y + 18, 30, 9, '#a85a3a'); R(x + 14, y + 13, 16, 6, '#94503a'); R(x + 15, y + 14, 6, 4, '#7ab0c8'); R(x + 10, y + 26, 5, 3, '#1c1c1c'); R(x + 31, y + 26, 5, 3, '#1c1c1c'); R(x + 38, y + 22, 3, 3, '#fff2b0');
        R(x - 4, y - 9, 58, 11, '#8a8e94'); for (let k = 0; k < 58; k += 3) R(x - 4 + k, y - 9, 1, 11, '#6a6e74'); R(x - 4, y + 1, 58, 1, '#4a4e54');
        R(x + 10, y - 18, 30, 9, '#5a3820'); txt(P, 'OFICINA', x + 25, y - 16, '#f2e2b8');
        for (let k = 0; k < 3; k++) { P.circ(x + 58, y + 26 - k * 5, 5, '#1c1c1c', 3); P.circ(x + 58, y + 26 - k * 5, 2, '#5a5e62', 1); } R(x - 9, y + 14, 7, 13, '#3c6aa8'); R(x - 9, y + 14, 7, 2, '#5a8ac8');
        R(x + 6, y + 34, 38, 3, '#7a4a2a'); R(x + 8, y + 37, 2, 5, '#5a3820'); R(x + 40, y + 37, 2, 5, '#5a3820');
        P.circ(x + 13, y + 31, 4, '#8a9096', 3); for (let a = 0; a < 4; a++) R(x + 13 + Math.cos(a * 1.57) * 2, y + 31 + Math.sin(a * 1.57) * 2, 2, 1, '#dde0e3'); // ventoinha
        R(x + 21, y + 30, 9, 2, '#9aa0a6'); R(x + 28, y + 26, 2, 6, '#9aa0a6'); R(x + 21, y + 30, 9, 1, '#dde0e3'); // cano
        R(x + 35, y + 28, 2, 5, '#f2f2ee'); R(x + 34, y + 27, 4, 2, '#a8643a'); R(x + 35, y + 33, 2, 1, '#9aa0a6'); }); // vela
      ref(268, 172, 50, 50, (P) => { P.arvore(282, 214, 1.4, 'verde', 7); P.R(292, 196, 20, 3, '#5a3820'); P.R(292, 196, 20, 1, '#8a5a36'); }); // árvore do balanço
      ref(40, 330, 24, 30, (P) => { const R = P.R, x = 52, y = 358; P.sombra(x + 2, y, 7, 2); R(x, y - 24, 2, 24, '#7a5228'); R(x - 9, y - 18, 20, 2, '#7a5228'); R(x - 5, y - 18, 12, 9, '#c8544a'); R(x - 5, y - 14, 12, 1, '#a8443a'); R(x - 3, y - 24, 8, 6, '#e8c87a'); R(x - 5, y - 26, 12, 3, '#d8b04a'); R(x - 2, y - 22, 1, 1, '#2a2a2a'); R(x + 2, y - 22, 1, 1, '#2a2a2a'); R(x - 10, y - 17, 2, 3, '#e8c87a'); R(x + 10, y - 17, 2, 3, '#e8c87a'); }); // espantalho
      ref(130, 452, 44, 26, (P) => { const R = P.R, x = 134, y = 474; P.sombra(x + 20, y, 22, 3); R(x, y - 12, 40, 12, '#a87a54'); R(x, y - 12, 40, 2, '#c89a6a'); for (let k = 0; k < 40; k += 10) R(x + k, y - 10, 1, 10, '#7a5230'); // caixote do Kauã: lápis, borracha e clipe
        R(x + 3, y - 17, 18, 4, '#f2c94c'); R(x + 3, y - 17, 18, 1, '#ffe39a'); R(x + 21, y - 17, 4, 4, '#e8c8a0'); R(x + 25, y - 16, 2, 2, '#2a2a2a'); R(x + 1, y - 17, 3, 4, '#e86a8a'); R(x + 4, y - 17, 1, 4, '#c8ccd0');
        R(x + 28, y - 18, 9, 5, '#f29ab0'); R(x + 28, y - 18, 9, 1, '#ffd0de'); R(x + 28, y - 15, 9, 2, '#3c6aa8');
        P.c.strokeStyle = '#a8aeb4'; P.c.lineWidth = 1; P.c.strokeRect(x + 12.5, y - 23.5, 8, 4); P.c.strokeRect(x + 14.5, y - 22.5, 4, 2); });
      ref(176, 588, 70, 40, (P) => { const R = P.R, x = 182, y = 596; P.sombra(x + 30, y + 26, 34, 4); R(x, y, 60, 24, '#8a5a36'); for (let k = 0; k < 140; k++) R(x + 2 + h(k, 1) * 55, y + 2 + h(k, 2) * 20, 2, 1, h(k, 3) > .5 ? '#5a3420' : '#7a4a2a'); // barcaça de cacau secando
        R(x - 2, y + 24, 64, 2, '#5a3820'); R(x + 34, y - 6, 34, 8, '#9a5a3a'); for (let k = 0; k < 34; k += 4) R(x + 34 + k, y - 6, 1, 8, '#7a4228'); R(x + 34, y + 2, 34, 1, '#5a3420'); for (const px of [x - 2, x + 60]) R(px, y - 4, 2, 30, '#6a4228'); R(x + 64, y + 2, 2, 22, '#6a4228'); });
      ref(244, 280, 40, 18, (P) => { const R = P.R, x = 246, y = 296; R(x + 4, y - 8, 2, 8, '#5a3820'); R(x + 30, y - 8, 2, 8, '#5a3820'); R(x - 1, y - 20, 38, 13, '#5a3820'); R(x, y - 19, 36, 11, '#a8643a'); R(x, y - 19, 36, 1, '#d8a070'); txt(P, 'ITABUNA', x + 18, y - 16, '#fff2c8', { sombra: '#5a3820' }); }); // placa de boas-vindas
      for (const [x, y] of [[404, 58], [398, 98], [406, 136]]) ref(x - 8, y - 22, 16, 22, (P) => P.mamoeiro(x, y)); // mamoeiros (as papaias do Miqueias)
      ref(546, 156, 30, 14, (P) => { P.banco(552, 168); for (const [k, cor] of [[0, '#3c6aa8'], [1, '#c43c3a'], [2, '#3c8a5a']]) { P.R(554 + k * 4, 159 - k, 6, 4, cor); P.R(554 + k * 4, 159 - k, 6, 1, '#ffffff88'); } }); // os três cadernos do Almiro
      ref(668, 172, 24, 18, (P) => P.arbusto(680, 188, 3)); // moita do saruê
      ref(676, 440, 108, 14, (P) => { const R = P.R; for (let k = 0; k < 3; k++) { R(682 + k * 3, 440 + k * 4, 96 - k * 6, 4, k % 2 ? '#8a9096' : '#a8aeb4'); R(682 + k * 3, 440 + k * 4, 96 - k * 6, 1, '#dde0e3'); } }); // arquibancada da quadra
      ref(744, 462, 30, 22, (P) => { const R = P.R, x = 748, y = 482; P.sombra(x + 10, y, 12, 2); R(x, y - 8, 22, 3, '#a8643a'); R(x + 2, y - 5, 2, 5, '#5a3820'); R(x + 18, y - 5, 2, 5, '#5a3820'); R(x + 5, y - 15, 12, 7, '#7a4a2a'); R(x + 5, y - 15, 12, 2, '#f29ab0'); R(x + 6, y - 13, 1, 2, '#f29ab0'); R(x + 11, y - 13, 1, 3, '#f29ab0'); R(x + 10, y - 19, 1, 4, '#f2f2ee'); }); // o bolo
      ref(578, 446, 22, 22, (P) => { const R = P.R, x = 584, y = 466; P.sombra(x + 6, y, 10, 2); R(x, y - 10, 14, 9, '#f2f2ee'); R(x, y - 10, 14, 2, '#e86a8a'); R(x + 1, y - 1, 3, 2, '#1c1c1c'); R(x + 10, y - 1, 3, 2, '#1c1c1c'); R(x + 6, y - 22, 1, 12, '#8a8e94'); }); // carrinho de sorvete
      ref(470, 448, 26, 18, (P) => { const R = P.R, x = 476, y = 462; R(x, y - 7, 14, 4, '#7a4a2a'); R(x + 6, y - 3, 2, 3, '#5a3820'); for (let k = 0; k < 4; k++) R(x + 2 + k * 3, y - 8, 2, 1, '#f6f6f0'); pecas.pessoaG(P, x - 4, y, '#3c8a5a', '#c99068', '#b8b2a6'); pecas.pessoaG(P, x + 18, y, '#c8544a', '#8a5a3a', '#e0e0e0'); }); // dominó dos aposentados
      ref(436, 574, 80, 56, (P) => { P.casa(442, 578, 58, 46, { telhado: '#c8543a', parede: '#f2e2a8', madeira: false, janelas: [6], porta: 34 }); P.R(446, 598, 28, 8, '#e8433a'); txt(P, 'LANCHE', 460, 600, '#fff6dc'); const R = P.R; R(504, 602, 12, 22, '#2a2a4a'); R(504, 602, 12, 2, '#5a5a8a'); R(506, 606, 8, 6, '#1c2a3a'); R(506, 615, 8, 2, '#5a5a8a'); R(507, 618, 2, 2, '#e8433a'); R(511, 618, 2, 2, '#f2c94c'); }); // lanchonete com fliperama na porta
      ref(978, 226, 40, 64, (P) => { const R = P.R; R(992, 280, 24, 2, '#3a3f48'); for (const x of [990, 1016]) { R(x, 276, 3, 8, '#2a2a2a'); } R(990, 279, 29, 2, '#8a9096'); R(984, 286, 6, 3, '#2a2a2a'); R(1000, 286, 6, 3, '#2a2a2a'); R(1004, 236, 2, 30, '#5a5e62'); R(1000, 228, 10, 10, '#1c1c1c'); }); // halteres e o sinal de reflexo do Caleb
      ref(704, 214, 44, 34, (P) => { const R = P.R, x = 708, y = 244; P.sombra(x + 18, y, 20, 3); R(x, y - 10, 36, 10, '#8a5a36'); R(x + 2, y - 26, 2, 16, '#6a4228'); R(x + 32, y - 26, 2, 16, '#6a4228'); for (let k = 0; k < 40; k += 8) R(x - 2 + k, y - 30, 8, 6, k % 16 ? '#f2f2ee' : '#3c8a5a'); for (let k = 0; k < 6; k++) P.circ(x + 6 + (k % 3) * 11, y - 12 - Math.floor(k / 3) * 3, 4, '#b89a6a', 3); for (let k = 0; k < 5; k++) R(x + 4 + k * 6, y - 15, 3, 2, '#e8c87a'); R(x + 6, y - 6, 24, 5, '#f2e2b8'); txt(P, 'BATATA', x + 18, y - 6, '#7a2a1a'); }); // barraca da BATATA
      // ---- casinhas da cidade, nos terrenos livres ----
      const cores = [['#f2e2c0', '#c8543a'], ['#c8dcf0', '#8a4a3a'], ['#f2c4c4', '#a8443a'], ['#d4ecc8', '#c8644a'], ['#f2e2a8', '#9a4a34'], ['#e8c8e8', '#b8644a'], ['#f0d0a0', '#8a8e94']];
      for (let i = 0; i < 3000; i++) { const w = 26 + Math.floor(h(i, 41) * 3) * 6, hh = 30 + Math.floor(h(i, 42) * 2) * 6, x = 430 + h(i, 43) * 560, y = 6 + h(i, 44) * 660; if (Tr.nivelEm(x, y + hh) > 1) continue; if (!lote.area(x - 4, y - 4, w + 10, hh + 10)) continue; const [par, tel] = cores[i % cores.length]; add(y + hh, (P) => P.casa(x, y, w, hh, { telhado: tel, parede: par, madeira: i % 3 === 0, janelas: w > 34 ? [4, w - 10] : [4], porta: Math.round(w / 2) - 4, chamine: i % 5 === 0 })); }
      // ---- coqueiros e capivaras na areia do rio ----
      const areia = tipoEh(Tr, 'areia');
      for (let i = 0; i < 70; i++) { const x = 280 + h(i, 51) * 180, y = 20 + h(i, 52) * 680; if (!lote.ponto(x, y, 8, areia)) continue; const k = h(i, 53); add(y, (P) => (k > .6 ? P.coqueiro(x, y) : k > .45 ? (P.sombra(x + 1, y, 6, 2), P.R(x - 5, y - 5, 10, 5, '#8a5a3a'), P.R(x + 4, y - 7, 4, 4, '#7a4a2a'), P.R(x - 4, y - 5, 8, 1, '#a87a4a'), P.R(x + 6, y - 6, 1, 1, '#1c1c1c')) : P.pedra(x, y))); }
      // ---- árvores: mata no norte, cacau no morro, ipês na cidade ----
      for (let i = 0; i < 900; i++) { const x = 4 + h(i, 61) * 1016, y = 8 + h(i, 62) * 694; if (!lote.ponto(x, y, 8)) continue; const tp = Tr.tipoEm(x, y), lvl = Tr.nivelEm(x, y), k = h(i, 63);
        if (lvl >= 2 && x < 320) add(y, (P) => P.cacaueiro(x, y, 1, i));
        else if (tp === 'mata') add(y, (P) => P.arvore(x, y, .9 + k * .5, k > .5 ? 'escura' : 'verde', i));
        else if (x > 420) { if (k > .55) continue; add(y, (P) => (k > .47 ? P.arvore(x, y, .9, 'amarela', i) : k > .4 ? P.arvore(x, y, .9, 'rosa', i) : k > .3 ? P.arbusto(x, y, i, '#f2c94c') : P.arvore(x, y, .8 + k * .6, 'verde', i))); }
        else { if (k > .7) continue; add(y, (P) => (k > .6 ? P.arbusto(x, y, i, '#e86a8a') : k > .55 ? P.pedra(x, y) : P.arvore(x, y, .85 + k * .5, k > .3 ? 'escura' : 'verde', i))); } }
      // ---- postes ao longo das ruas ----
      for (const pl of [RUAS1.n, RUAS1.s, RUAS1.a, RUAS1.b]) for (let k = 10; k < pl.length; k += 34) { const [x, y] = faixa(pl, 22, false)[k]; if (lote.ponto(x, y, 4)) add(y, (P) => P.poste(x - 2, y)); }
    },
    chao: (P) => { void P; },
    animarChao: (P, t) => { const R = P.R, Tr = TR1; if (!Tr) return; // vento passando no trigal
      for (let k = 0; k < 14; k++) { const u = (t * .18 + k / 14) % 1, x = 4 + u * 100, y = 244 + (k * 37) % 150; if (Tr.tipoEm(x, y) !== 'trigo') continue; P.c.globalAlpha = .45 * Math.sin(u * Math.PI); R(x, y, 10, 1, '#fff4b0'); R(x + 3, y + 1, 6, 1, '#fff4b0'); P.c.globalAlpha = 1; }
      for (let k = 0; k < 3; k++) { const a = t * .5 + k * 2.1, x = 218 + Math.cos(a) * 26, y = 458 + Math.sin(a) * 10; R(x - 3, y, 7, 1, '#9fd0f0'); R(x - 2, y - 3, 5, 3, '#f6f6f0'); R(x + (Math.cos(a + 1.6) > 0 ? 2 : -3), y - 5, 2, 2, '#3c8a5a'); R(x + (Math.cos(a + 1.6) > 0 ? 4 : -4), y - 4, 1, 1, '#f2a03a'); } // patos no açude
      { const tr = A.trilho(RIO1.filter((p) => p[1] > 380 && p[1] < 640)), u = (Math.sin(t * .06) + 1) / 2, p = tr.em(u * .999); const x = Math.round(p.x), y = Math.round(p.y); R(x - 9, y + 1, 19, 2, '#3a7ad0'); R(x - 8, y - 2, 17, 3, '#7a4a2a'); R(x - 8, y - 2, 17, 1, '#a87a4a'); R(x - 1, y - 9, 4, 7, '#c8544a'); R(x - 1, y - 12, 4, 3, '#c99068'); R(x - 2, y - 13, 6, 1, '#d8b04a'); P.c.strokeStyle = '#5a3820'; P.c.beginPath(); P.c.moveTo(x + 3, y - 8); P.c.lineTo(x + 14, y - 16); P.c.lineTo(x + 15 + Math.sin(t * 2), y - 2); P.c.stroke(); } // canoa com pescador
    },
    animar: (P, t) => { const R = P.R;
      { const cx = 82, cy = 306; for (let k = 0; k < 4; k++) { const a = t * 2 + k * Math.PI / 2; for (let j = 4; j < 20; j++) R(cx + Math.cos(a) * j, cy + Math.sin(a) * j, 2, 2, j % 4 ? '#e8e2d0' : '#c8b48a'); } R(cx - 2, cy - 2, 5, 5, '#6a4a2a'); } // moinho
      fumaca(P, 170, 326, t); fumaca(P, 900, 200, t + 1);
      for (let k = 0; k < 6; k++) { const a = t * 3 + k; R(540 + Math.cos(a) * 3, 438 - (t * 20 + k * 4) % 12, 1, 2, '#c8eaff'); } // chafariz
      // trânsito nas ruas de pedra (curvas, ida e volta)
      naRua(P, t, faixa(RUAS1.n, -5, false), 3, ['#c43c3a', '#f2f2ee', '#3c6aa8'], 26); naRua(P, t, faixa(RUAS1.n, 5, true), 2, ['#e8c24c', '#3c8a5a'], 24, .3);
      naRua(P, t, faixa(RUAS1.s, -5, false), 2, ['#7a3a8a', '#f2f2ee'], 22, .5); naRua(P, t, faixa(RUAS1.s, 5, true), 2, ['#3c6aa8', '#c43c3a'], 25, .1);
      naRua(P, t, RUAS1.a, 2, ['#f2f2ee', '#e8c24c'], 20, .2); naRua(P, t, [...RUAS1.b].reverse(), 2, ['#c43c3a', '#2a2a2a'], 18, .7, (j) => (j ? 'moto' : null));
      for (let k = 0; k < 6; k++) { const u = (t * .05 + k / 6) % 1; pessoa(P, 450 + u * 160, 468 + (k % 3) * 18, ['#e86a8a', '#3c6aa8', '#f2c94c', '#7a3a8a'][k % 4], t); } // gente na praça
      for (let k = 0; k < 5; k++) { const x = 516 + k * 9 + Math.sin(t * .7 + k) * 4, y = 486 + (k % 2) * 5, b = Math.floor(t * 4 + k) % 3 === 0; R(x, y - 3 + (b ? 1 : 0), 4, 3, '#8a9096'); R(x + (b ? 3 : 3), y - 4 + (b ? 2 : 0), 2, 2, '#6a7076'); R(x + 1, y, 1, 1, '#e8833a'); } // pombos
      { const s = Math.sin(t * 6) > 0; for (let k = 0; k < 3; k++) { const q = (t * .6 + k) % 3; if (q < .25) { R(250 + k * 9, 262 - q * 30, 1, 3, '#fff6c0'); R(249 + k * 9, 263 - q * 30, 3, 1, '#fff6c0'); } } if (s) R(250, 262, 1, 1, '#ffffff'); } // brilho das peças
      { const a = Math.sin(t * 2.2) * .55, sx = 302 + Math.sin(a) * 18, sy = 199 + Math.cos(a) * 18; P.c.strokeStyle = '#3a2a1a'; P.c.lineWidth = 1; P.c.beginPath(); P.c.moveTo(298, 199); P.c.lineTo(sx - 4, sy); P.c.moveTo(306, 199); P.c.lineTo(sx + 4, sy); P.c.stroke(); R(sx - 5, sy, 11, 2, '#7a4a2a'); } // balanço
      for (let k = 0; k < 3; k++) { const x = 150 + k * 26 + Math.sin(t * .8 + k * 2) * 10, y = 440 + (k % 2) * 6, b = Math.floor(t * 3 + k) % 4 === 0; R(x, y - 5 + (b ? 2 : 0), 5, 4, '#f6f6f0'); R(x + 4, y - 7 + (b ? 3 : 0), 2, 2, '#c43c3a'); R(x + 1, y - 1, 1, 1, '#f2a03a'); R(x + 3, y - 1, 1, 1, '#f2a03a'); } // galinhas soltas
      { const u = (Math.sin(t * .7) + 1) / 2, x = 96 + u * 128, y = 156 + Math.sin(t * 1.4) * 10; pessoa(P, x, y, '#2c5a9e', t); const by = Math.abs(Math.sin(t * 6)) * 5; R(x + 4, y - 3 - by, 3, 3, '#ffffff'); R(x + 5, y - 3 - by, 1, 1, '#1c1c1c'); for (let k = 0; k < 4; k++) { R(100 + k * 30, 180, 3, 4, '#f2833a'); R(100 + k * 30, 180, 3, 1, '#ffffff'); } } // Mota treinando com bola e cones
      { const pisca = Math.floor(t * 1.5) % 7 === 0; R(681, 182 - (pisca ? 0 : 1), 3, 2, '#8a9096'); if (!pisca) { R(681, 181, 1, 1, '#1c1c1c'); R(683, 181, 1, 1, '#1c1c1c'); } R(680, 183, 5, 1, '#f29ab0'); R(684 + Math.round(Math.sin(t * 3)), 186, 4, 1, '#e8c8c8'); } // o saruê espiando
      for (let k = 0; k < 4; k++) { const u = (t * .12 + k / 4) % 1, x = 540 - u * 40 + Math.sin(u * 12 + k) * 10, y = 150 + u * 90, f = Math.floor(t * 8 + k) % 2; R(x, y, f ? 5 : 3, f ? 3 : 4, '#f6f4ee'); R(x + 1, y + 1, f ? 3 : 1, 1, '#8ab8e8'); } // folhas de caderno voando
      for (let k = 0; k < 4; k++) { const a = t * .7 + k * 1.57, x = 508 + Math.cos(a) * 74, y = 282 + Math.sin(a) * 8; P.c.strokeStyle = '#1c1c1c'; P.c.beginPath(); for (let j = 0; j < 6; j++) P.c.lineTo(x + Math.sin(t * 9 + j * 2 + k) * 3 + j - 3, y - j * 2); P.c.stroke(); R(x - 1, y - 12, 1, 1, '#e8433a'); R(x + 2, y - 12, 1, 1, '#e8433a'); } // rabiscos do Caderno do Caos
      { const b = Math.abs(Math.sin(t * 4)) * 14; P.circ(712, 404 - b, 3, '#e8833a'); R(711, 403 - b, 1, 3, '#7a3a1a'); pessoa(P, 718, 410, '#e8433a', t, false); } // basquete na quadra
      { const on = Math.floor(t * 1.2) % 2; R(1001, 230, 8, 3, on ? '#3ce06a' : '#1c3a24'); R(1001, 234, 8, 3, on ? '#3a1414' : '#e8433a'); const d = Math.abs(Math.sin(t * 3)) * 2; R(988, 278 + d, 10, 3, '#3c6aa8'); R(997, 276 + d, 3, 3, '#c99068'); } // sinal de reflexo e flexões
      { const k = Math.floor(t * 8) % 6; for (let j = 0; j < 9; j++) R(860, 412 + j * 3, 4, 3, (j + k) % 3 === 0 ? '#e8433a' : (j + k) % 3 === 1 ? '#f2f2ee' : '#3c6aa8'); } // poste do barbeiro girando
      { const x = 906, y = 395; R(x - 12, y, 10, 3, '#1c1c1c'); R(x + 2, y, 10, 3, '#1c1c1c'); R(x - 14, y - 2, 4, 3, '#1c1c1c'); R(x + 10, y - 2, 4, 3, '#1c1c1c'); R(x - 2, y + 1, 4, 2, '#1c1c1c'); } // bigodão no telhado
      for (let k = 0; k < 3; k++) { const x = 694 + k * 12, y = 642; R(x, y - 7, 6, 8, ['#2a8ae8', '#e8c24c', '#2ad06a'][k]); R(x, y - 7, 6, 2, '#dde0e3'); R(x + 1, y - 4, 1, 3, '#ffffff'); if (Math.floor(t * 6 + k * 2) % 4 === 0) { R(x + 2, y - 13, 1, 4, '#fff27a'); R(x + 3, y - 15, 1, 3, '#fff27a'); R(x + 1, y - 10, 1, 2, '#fff27a'); } } // latinhas Bivolt
      for (let k = 0; k < 4; k++) { const on = Math.floor(t * 4 + k) % 2; R(906 + k * 14, 624, 10, 10, on ? ['#ff3a8a', '#3ae0ff', '#ffe23a', '#8a3aff'][k] : '#3a2a4a'); } // luzes do baile
      for (const sx of [877, 989]) for (let k = 0; k < 3; k++) { const q = (t * 1.6 + k / 3) % 1; P.c.globalAlpha = (1 - q) * .6; P.c.strokeStyle = '#ff6ac0'; P.c.beginPath(); P.c.ellipse(sx, 644, 6 + q * 22, (6 + q * 22) * .5, 0, 0, Math.PI * 2); P.c.stroke(); } P.c.globalAlpha = 1; // som do paredão
      { const a = t * .9, x = 932 + Math.cos(a) * 70, y = 510 + Math.sin(a * 2) * 16, d = -Math.sin(a) >= 0 ? 1 : -1; for (let k = 1; k < 6; k++) { P.c.globalAlpha = .5 - k * .08; P.circ(932 + Math.cos(a - k * .08) * 70, 513 + Math.sin((a - k * .08) * 2) * 16, 2 + k * .4, '#c1db7b'); } P.c.globalAlpha = 1; R(x - 8, y - 5, 16, 6, '#7a3a8a'); R(x - 4, y - 9, 9, 4, '#7a3a8a'); R(x - 3 + d, y - 8, 7, 2, '#9fc4d0'); R(x - 7, y + 1, 3, 2, '#1c1c1c'); R(x + 4, y + 1, 3, 2, '#1c1c1c'); } // um carro que não devia estar no céu
      for (const [bx, by, cor] of [[1000, 6, '#e8433a'], [952, 2, '#3c6aa8'], [880, 30, '#f2c94c'], [1010, 70, '#3c8a5a']]) { const x = bx + Math.sin(t + bx) * 6, y = by + Math.sin(t * 1.4 + bx) * 4 + 4; P.c.strokeStyle = '#2a2a2a'; P.c.beginPath(); P.c.moveTo(bx - 8, by + 34); P.c.lineTo(x, y + 9); P.c.stroke(); R(x - 4, y, 9, 9, cor); R(x - 1, y + 9, 3, 6, '#f2f2ee'); R(x, y + 1, 1, 7, '#ffffff66'); } // pipas
      for (const [x0, y0, n] of [[868, 122, 4], [926, 76, 3], [972, 28, 3]]) { P.c.strokeStyle = '#4a4a4a'; P.c.beginPath(); P.c.moveTo(x0, y0); P.c.lineTo(x0 + n * 7, y0 + 2); P.c.stroke(); for (let k = 0; k < n; k++) { const w = Math.round(Math.sin(t * 3 + k) * 1); R(x0 + 2 + k * 7, y0 + 1, 4, 5 + w, ['#e86a8a', '#3c6aa8', '#f2c94c', '#f6f6f0'][k % 4]); } } // varais da favela
      txt(P, 'OOO REEEIS', 930, 176, '#ffd24a', { sombra: '#7a2a1a' }); // pichação no paredão
      for (let k = 0; k < 3; k++) { const x = ((t * 30 + k * 300) % 1100) - 40, y = 60 + k * 70 + Math.sin(t * 2 + k) * 6, f = Math.sin(t * 12 + k) > 0; R(x, y, 3, 1, '#2a2a2a'); R(x - 2, y - (f ? 2 : 0), 2, 1, '#2a2a2a'); R(x + 3, y - (f ? 2 : 0), 2, 1, '#2a2a2a'); }
      { const on = Math.floor(t * 5) % 2; R(506, 606, 8, 6, on ? '#3ae0ff' : '#ff3a8a'); R(507, 607, 2, 2, '#ffffff'); } // fliperama piscando
    },
    veiculo: (P) => { const R = P.R; R(-12, -8, 24, 9, '#3c8a8a'); R(-12, -8, 24, 1, '#7ac8c8'); R(-6, -14, 14, 7, '#4aa0a0'); R(-5, -13, 12, 4, '#9fc4d0'); R(-16, -7, 5, 5, '#c8ccd0'); R(-10, 0, 5, 3, '#1c1c1c'); R(6, 0, 5, 3, '#1c1c1c'); R(11, -6, 2, 2, '#fff2b0'); for (let k = 0; k < 3; k++) R(-20 - k * 4, -4 + Math.sin(k + performance.now() / 90) * 2, 3, 3, 'rgba(220,230,240,.7)'); },
    locais: C1
  };
  // quem falta derrotar (ou o que falta fazer) para liberar cada lugar da campanha 1, seguindo as regras do jogo
  function quemC1(id, q) {
    if (!q.lucas) return { titulo: 'PRECISA PRIMEIRO', nomes: ['CONSERTAR O CARRO COM O LUCAS'] };
    if (id === 5) return { titulo: 'PRECISA VENCER', nomes: [!q.mota && 'O DESAFIO DO MOTA', !q.almiro && 'A MISSÃO DO ALMIRO', !q.miqueias && 'O ENGLISH DO MIQUEIAS'].filter(Boolean) };
    if (id === 6) return { titulo: 'PRECISA DERROTAR', nomes: ['MARCO'] };
    if (id === 2) return { titulo: 'PRECISA DERROTAR', nomes: ['MENEZES'] };
    if (id === 3) { const d = [!q.giant && 'O MONSTRO DO CADERNO DO CAOS', !q.menezes && 'MENEZES'].filter(Boolean); return { titulo: d.length ? 'PRECISA DERROTAR' : 'PRECISA', nomes: d.concat(q.trained ? [] : [(d.length ? '+ ' : '') + 'O TREINO DO CALEB']) }; }
    return { titulo: 'AINDA TRANCADO', nomes: [] };
  }
  function abrirMapa1(preferido) {
    const G = window.Game; if (!G?.getState || !window.Mapa3D) return false; const st = G.getState(), q = st.q || {}, atual = Number(preferido ?? st.scene);
    const estado = (id) => { if (id === atual) return { ok: true }; const r = window.Campaign?.canTravel?.(id, q) || { ok: true }; if (r.ok === false) return { ok: false, motivo: r.reason, trava: { ...quemC1(id, q), texto: r.reason } };
      return st.vehicle ? { ok: true } : { ok: false, motivo: 'Entre no carro a gás (tecla V ou botão CARRO) para viajar.' }; };
    const d = { ...MAPA1, locais: C1.map((L) => ({ ...L, atual: L.id === atual, estado: estado(L.id), previa: previaCena(L.id, L.cam ?? 700) })), aoIr: (id) => G.travel?.(id), aoFechar: () => {} };
    return window.Mapa3D.abrir(d);
  }


  /* =====================================================================
     CAMPANHA 2 · VITÓRIA DA CONQUISTA (só os pontos de táxi, sempre do lado de fora)
     ===================================================================== */
  // ordem dos vilões da Campanha 2 e o lugar de cada um; cada área só abre depois de vencer quem vem antes
  const VILOES = { creuza: 'DONA CREUZA', tonhao: 'TONHÃO DO MOTOTÁXI', valdomiro: 'SEU VALDOMIRO', kaua: 'KAUÃ INFLUENCER', barao: 'BARÃO DO CAFÉ', breno: 'BRENO PITBULL', gemeos: 'RYAN E BRYAN', fred: 'FRED' };
  const VNOME = { creuza: 'a Dona Creuza', tonhao: 'o Tonhão do Mototáxi', valdomiro: 'o Seu Valdomiro', kaua: 'o Kauã Influencer', barao: 'o Barão do Café', breno: 'o Breno Pitbull', gemeos: 'os gêmeos Ryan e Bryan', fred: 'o Fred' };
  const ORDEM = Object.keys(VILOES), REQUER = { t16: 'creuza', t17: 'creuza', t30: 'creuza', t32: 'creuza', t28: 'tonhao', t33: 'tonhao', t15: 'valdomiro', t29: 'valdomiro', t18: 'kaua', t31: 'kaua', t19: 'barao', t34: 'barao', t22: 'breno', t21: 'gemeos' };
  const KEY_V = 'daroca-c2-vencidos'; let vencidos = []; try { const v = JSON.parse(localStorage.getItem(KEY_V) || '[]'); if (Array.isArray(v)) vencidos = v.filter((x) => ORDEM.includes(x)); } catch (e) {}
  const salvarV = () => { try { localStorage.setItem(KEY_V, JSON.stringify(vencidos)); } catch (e) {} };
  const travaC2 = (L) => { const r = REQUER[L.id]; if (!r || vencidos.includes(r)) return { ok: true }; const nome = VILOES[r], txt = `O Seu Zé não leva ninguém pra lá enquanto ${VNOME[r]} ${r === 'gemeos' ? 'estiverem' : 'estiver'} no caminho.`; return { ok: false, motivo: `Derrote ${nome} para liberar.`, trava: { titulo: 'PRECISA DERROTAR', nomes: [nome], texto: txt } }; };
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
    { id: 't15', cena: 15, x: 300, nome: 'Trilha do Cristo', sub: 'Pé da Serra do Periperi', caixa: [440, 0, 100, 140], desloc: [-60, 0],
      descricao: 'Lá em cima, o Cristo de braços abertos vê a cidade inteira. O vento sopra forte, e dizem que alguém sobe lá só pra ser visto.',
      desenho: (P) => { const R = P.R; // alto da serra: o Cristo de braços abertos, a torre de antena vermelha e branca e a escadaria
        P.sombra(492, 58, 18, 5, .3); R(484, 44, 16, 14, '#8a8478'); R(482, 42, 20, 4, '#a49c90'); R(489, 6, 6, 38, '#a49c90'); R(489, 6, 2, 38, '#c4bcb0'); R(474, 14, 36, 5, '#a49c90'); R(474, 14, 36, 2, '#c4bcb0'); P.circ(492, 6, 3, '#9a8a76');
        R(520, 4, 3, 54, '#f2f2ee'); for (let y = 4; y < 58; y += 8) R(520, y, 3, 4, '#c43c3a'); R(516, 56, 11, 3, '#7a8086'); R(519, 2, 5, 3, '#c43c3a'); for (let y = 10; y < 56; y += 10) { R(516, y, 3, 1, '#9aa0a6'); R(523, y + 4, 3, 1, '#9aa0a6'); }
        escada(P, 486, 62, 18); P.placa(500, 128, '#5a3820'); } },
    { id: 't16', cena: 16, x: 2700, nome: 'Monumento ao Índio', sub: 'Avenidas e rotatória', caixa: [680, 276, 110, 94],
      descricao: 'A rotatória mais famosa da cidade. Trânsito pesado, mototáxi pra todo lado e alguém que cobra caro demais por uma corrida.',
      desenho: (P) => { const R = P.R; // rotatória com canteiro florido e a estátua de bronze do índio com o arco no pedestal
        P.circ(734, 334, 42, '#6a7076', 22); P.circ(734, 332, 40, '#8a9096', 20); P.circ(734, 330, 36, '#5aa046', 18); P.circ(734, 330, 30, '#7cc458', 15); for (let k = 0; k < 24; k++) { const a = k / 24 * Math.PI * 2; R(734 + Math.cos(a) * 33, 330 + Math.sin(a) * 16, 3, 3, ['#e8433a', '#f2c94c', '#ffffff', '#e86a8a'][k % 4]); }
        P.sombra(738, 334, 16, 5, .3); R(720, 318, 28, 14, '#8a8478'); R(720, 318, 28, 3, '#b0aa9c'); R(724, 310, 20, 10, '#a49c90'); R(724, 310, 20, 2, '#c4bcb0'); R(726, 324, 16, 4, '#6a6458');
        R(730, 282, 9, 28, '#7a4a20'); R(731, 282, 3, 28, '#c8904a'); R(729, 276, 11, 9, '#8a5a2a'); R(731, 277, 3, 3, '#c8904a'); for (let k = 0; k < 5; k++) R(727 + k * 3, 268 + Math.abs(k - 2), 2, 8, k % 2 ? '#e8c24c' : '#c43c3a');
        R(724, 296, 7, 6, '#7a4a20'); R(724, 300, 5, 10, '#7a4a20'); R(739, 288, 16, 3, '#7a4a20'); P.c.strokeStyle = '#5a3418'; P.c.lineWidth = 2; P.c.beginPath(); P.c.arc(754, 290, 11, -1.35, 1.35); P.c.stroke(); P.c.lineWidth = 1; R(752, 279, 1, 22, '#e8dcc0'); R(740, 289, 16, 1, '#e8dcc0'); R(756, 288, 3, 3, '#a8aeb4'); } },
    { id: 't17', cena: 17, x: 400, nome: 'Feira do Planalto', sub: 'Barracas e biscoitarias', caixa: [470, 356, 176, 100],
      descricao: 'Grito de feirante, cheiro de biscoito quente e um senhor que vende garrafadas misteriosas. Tem quem diga que ali se compra até coragem.',
      desenho: (P) => { const R = P.R, cores = ['#3c6aa8', '#e8833a', '#e8c24c', '#3c8a5a', '#c43c3a', '#7a3a8a']; for (let k = 0; k < 6; k++) { const x = 480 + (k % 3) * 54, y = 372 + Math.floor(k / 3) * 40; P.sombra(x + 22, y + 30, 22, 4);
        R(x, y, 46, 12, cores[k]); for (let j = 0; j < 46; j += 6) R(x + j, y, 3, 12, '#f6f2ea'); R(x + 2, y + 12, 2, 18, '#6a5a44'); R(x + 42, y + 12, 2, 18, '#6a5a44'); R(x + 4, y + 22, 38, 8, '#8a6a45'); for (let j = 0; j < 6; j++) P.circ(x + 8 + j * 6, y + 20, 2, ['#e8c24c', '#7cbf6a', '#d9634a', '#f6ecd0'][(j + k) % 4]); } for (let k = 0; k < 22; k++) { const x = 476 + k * 8, y = 366 + Math.round(Math.sin(k / 21 * Math.PI) * 5); R(x, y, 5, 4, ['#e8433a', '#f2c94c', '#3c8a5a', '#3c6aa8', '#e86a8a'][k % 5]); } R(600, 440, 30, 12, '#e8d8a8'); R(600, 440, 30, 2, '#a8643a'); txt(P, 'BISCOITO', 615, 443, '#7a3a10'); } },
    { id: 't18', cena: 18, x: 300, nome: 'Fazendas de café', sub: 'Porteira da fazenda', caixa: [970, 560, 140, 100],
      descricao: 'Fileiras de café até onde a vista alcança. O dono da fazenda vizinha anda nervoso... e não é só por causa da cafeína.',
      desenho: (P) => { P.casa(990, 580, 84, 60, { telhado: '#8a4430', parede: '#f2ece0', paredeH: 22, chamine: true, janelas: [8, 30, 64] }); P.R(1080, 608, 26, 30, '#cfcac0'); for (let k = 0; k < 26; k += 3) P.R(1080 + k, 610, 2, 26, k % 6 < 3 ? '#7a4a2a' : '#5a3420');  P.R(1010, 568, 46, 9, '#5a3820'); txt(P, 'FAZENDA', 1033, 570, '#f2e2b8'); for (let k = 0; k < 6; k++) P.R(1084 + (k % 2) * 8, 642 + Math.floor(k / 2) * 3, 3, 2, '#c43c3a');P.cercaH(976, 652, 120); } },
    { id: 't19', cena: 19, x: 300, nome: 'Teatro e Planetário', sub: 'Centro de Cultura', caixa: [730, 120, 150, 110],
      descricao: 'De noite, as luzes do teatro acendem e a cúpula do planetário guarda o céu inteiro. Tem show hoje... e um valentão na plateia.',
      desenho: (P) => { const R = P.R; // Centro de Cultura (bloco cinza), Teatro de tijolo com portas coloridas e a cúpula do planetário
        P.predio(734, 140, 54, 62, { topo: '#7a8086', parede: '#9aa0a6', fachada: 26, caixa: false, porta: false }); R(738, 178, 46, 6, '#3a3f44'); txt(P, 'CULTURA', 761, 179, '#e8e4dc'); R(752, 188, 18, 12, '#9ad0e8');
        P.sombra(824, 216, 34, 5, .25); R(792, 160, 64, 50, '#a8583a'); for (let y = 162; y < 210; y += 4) for (let x = 792 + ((y / 4) % 2) * 4; x < 856; x += 8) R(x, y, 7, 3, '#b86a48'); R(792, 158, 64, 4, '#5a2a1a');
        R(796, 164, 56, 10, '#3a1a14'); txt(P, 'TEATRO', 824, 166, '#ffe39a'); for (let k = 0; k < 56; k += 5) R(797 + k, 175, 2, 2, '#ffe39a');
        for (const [k, cor] of [[0, '#e8433a'], [1, '#3c6aa8'], [2, '#f2c94c'], [3, '#9a52c0']]) { R(796 + k * 14, 190, 11, 20, cor); R(796 + k * 14, 190, 11, 2, '#ffffff55'); R(800 + k * 14, 200, 1, 2, '#2a1a10'); }
        P.circ(866, 198, 14, '#c8ccd0', 10); P.circ(866, 196, 13, '#eef0f2', 9); P.circ(862, 192, 5, '#ffffff', 3); R(852, 200, 28, 10, '#d8dce0'); R(862, 202, 8, 8, '#5a6a7a'); } },
    { id: 't22', cena: 22, x: 1100, nome: 'Frente do Shopping', sub: 'Estacionamento e entrada', caixa: [890, 150, 190, 130],
      descricao: 'Cinema, lan house e gente fugindo do frio. Dizem que lá dentro tem um jogo dentro do jogo... e dois irmãos que não sabem perder.',
      desenho: (P) => { const R = P.R; // shopping: fachada bege, entrada de vidro com a placa laranja, totem colorido e o estacionamento com carros
        P.predio(900, 158, 160, 76, { topo: '#c8ccd0', parede: '#ece6d8', fachada: 34, caixa: false, porta: false });
        R(946, 186, 64, 48, '#5aa0c8'); for (let x = 948; x < 1008; x += 8) R(x, 188, 7, 44, '#9ad0e8'); for (let y = 196; y < 232; y += 10) R(948, y, 60, 1, '#f2f4f6'); R(946, 186, 64, 2, '#f2f4f6');
        R(950, 176, 56, 10, '#e8833a'); R(950, 176, 56, 2, '#f8a85a'); txt(P, 'SHOPPING', 978, 178, '#fff6e0'); for (const [x, cor] of [[956, '#e8433a'], [972, '#f2c94c'], [988, '#3c6aa8']]) R(x, 214, 6, 8, cor);
        R(1066, 166, 10, 50, '#2a2a30'); for (let k = 0; k < 6; k++) R(1067, 170 + k * 7, 8, 5, ['#e8833a', '#e8433a', '#f2c94c', '#3c8a5a', '#3c6aa8', '#e86a8a'][k]);
        R(900, 242, 170, 34, '#5b6066'); for (let x = 904; x < 1068; x += 20) R(x, 244, 1, 30, '#f2f2ee'); for (let k = 0; k < 6; k++) { if (k === 3) continue; carrinho(P, 914 + k * 28, 262, ['#c43c3a', '#f2f2ee', '#3c6aa8', '#e8c24c', '#2a2a2a', '#3c8a5a'][k]); }
        pessoa(P, 940, 240, '#e86a8a'); pessoa(P, 1014, 240, '#3c8a5a'); } },
    { id: 't21', cena: 21, x: 3700, nome: 'Entrada da Escola SESI', sub: 'Avenida Olívia Flores', caixa: [890, 350, 160, 120],
      descricao: 'O táxi deixa você no portão. Lá dentro tem escada, pátio e alguém que diz que o seu melhor amigo agora é dele.',
      desenho: (P) => { const R = P.R; // muro branco comprido com grafite colorido, prédio de janelas azuis, quadra verde e o portão
        P.predio(940, 360, 100, 60, { topo: '#e8e8e4', parede: '#f2f2ee', fachada: 26, faixa: '#2c5a9e' }); R(892, 366, 44, 56, '#3c8a5a'); R(894, 368, 40, 52, '#4a9a5a'); R(894, 393, 40, 1, '#f2f2ee'); R(894, 368, 1, 52, '#f2f2ee'); R(933, 368, 1, 52, '#f2f2ee'); P.circ(914, 393, 6, '#f2f2ee', 5); P.circ(914, 393, 5, '#4a9a5a', 4);
        R(892, 424, 156, 20, '#f6f6f2'); R(892, 424, 156, 2, '#ffffff'); R(892, 442, 156, 2, '#c8ccd0'); for (let k = 0; k < 22; k++) { const x = 896 + k * 7, cor = ['#e8433a', '#f2c94c', '#3c8a5a', '#3c6aa8', '#9a52c0', '#e8833a'][k % 6]; R(x, 430 + Math.round(Math.sin(k * .9) * 4), 6, 6, cor); R(x + 2, 428 + Math.round(Math.cos(k) * 3), 3, 3, cor); }
        R(960, 444, 30, 20, '#c8ccd0'); for (let x = 962; x < 990; x += 3) R(x, 446, 1, 16, '#5a5e64'); R(958, 442, 34, 3, '#2c5a9e'); txt(P, 'SESI', 975, 437, '#2c5a9e');
        for (let x = 896; x < 1046; x += 4) R(x, 452, 1, 12, '#2c5a9e'); R(896, 452, 150, 2, '#2c5a9e'); pessoa(P, 1010, 468, '#2c5a9e'); pessoa(P, 1024, 466, '#e8433a'); } },
    { id: 't28', cena: 28, x: 250, nome: 'Reserva do Poço Escuro', sub: 'Entrada da trilha', caixa: [16, 380, 200, 210],
      descricao: 'Mata fechada dentro da cidade. Água que cai das pedras, saguis curiosos e um silêncio que parece guardar alguma coisa.',
      desenho: (P) => { for (let i = 0; i < 16; i++) { const x = 30 + hash(i, 1) * 170, y = 420 + hash(i, 2) * 150; if (Math.abs(x - 100) < 20 && y > 480 && y < 540) continue; P.arvore(x, y, 1 + hash(i, 3) * .4, i % 3 ? 'escura' : 'verde', i); } P.placa(190, 580); P.R(150, 560, 28, 20, '#8a6a45'); P.R(148, 556, 32, 6, '#6a4a32'); } },
    { id: 't29', cena: 29, x: 250, nome: 'Portão do Lomantão', sub: 'Estádio Lomanto Júnior', caixa: [214, 560, 180, 150],
      descricao: 'Em dia de jogo a cidade para. Torcida cantando, espetinho na porta e um goleiro que conversa com a bola.',
      desenho: (P) => { const R = P.R; P.sombra(304, 690, 84, 12, .3); P.circ(304, 632, 82, '#9aa0a6', 56); P.circ(304, 628, 78, '#c8ccd0', 52); for (let k = 0; k < 40; k++) { const a = k / 40 * Math.PI * 2, r = 70; R(304 + Math.cos(a) * r, 628 + Math.sin(a) * r * .66, 4, 4, ['#e8433a', '#f2efe6', '#2c5a9e', '#e8c24c'][k % 4]); }
        P.circ(304, 630, 58, '#5aa046', 36); R(256, 628, 96, 1, '#f2f2ee'); P.circ(304, 630, 10, '#f2f2ee', 6); P.circ(304, 630, 9, '#5aa046', 5); for (const [x, y] of [[226, 580], [382, 580]]) { R(x, y - 40, 3, 40, '#6a6e74'); R(x - 6, y - 46, 15, 8, '#f2f2ee'); }  P.R(250, 660, 108, 10, '#c43c3a'); txt(P, 'LOMANTÃO', 304, 662, '#f2efe6');R(290, 690, 30, 12, '#2c5a9e'); } },
    { id: 't30', cena: 30, x: 4500, nome: 'Rodoviária', sub: 'Plataformas de embarque', caixa: [730, 560, 170, 116],
      descricao: 'Gente chegando, gente partindo, um engraxate que viu a cidade inteira passar e ônibus pra todo canto do mapa.',
      desenho: (P) => { const R = P.R; // rodoviária: prédio com placa, cobertura comprida das plataformas e os ônibus Águia Branquinha
        P.predio(738, 568, 60, 72, { topo: '#b8b4aa', parede: '#e2ddd0', fachada: 28 }); R(740, 570, 56, 10, '#2c5a9e'); txt(P, 'RODOVIÁRIA', 768, 572, '#f2efe6');
        P.sombra(850, 664, 50, 6, .25); R(802, 584, 94, 10, '#d8dcde'); R(802, 584, 94, 2, '#f2f4f4'); R(802, 593, 94, 2, '#9aa0a6'); for (const x of [806, 836, 866, 892]) R(x, 594, 3, 40, '#a8aeb4');
        for (let k = 0; k < 3; k++) { const x = 808 + k * 30; R(x, 602, 24, 50, '#f2f4f6'); R(x, 602, 24, 2, '#ffffff'); R(x + 2, 606, 20, 9, '#24303a'); R(x, 622, 24, 4, '#2c5a9e'); R(x, 627, 24, 2, '#e8c24c'); R(x + 3, 646, 5, 4, '#1c1c1c'); R(x + 16, 646, 5, 4, '#1c1c1c'); R(x + 10, 640, 4, 3, '#2c5a9e'); R(x + 2, 652, 20, 3, '#00000033'); R(x + 6, 596, 12, 6, '#9aa0a6'); txt(P, String(k + 1), x + 12, 597, '#f2efe6'); }
        pessoa(P, 790, 652, '#e8833a'); pessoa(P, 870, 668, '#3c8a5a'); } },
    { id: 't31', cena: 31, x: 4300, nome: 'UESB', sub: 'Ponto do circular', caixa: [920, 16, 220, 130],
      descricao: 'Módulos de aula, cantina, biblioteca e uma professora que guarda a história da cidade em caixas de sapato.',
      desenho: (P) => { const R = P.R; // UESB: módulos baixos e compridos de janelas azuis, ipês roxos e amarelos e o ponto do circular
        for (const [x, y, w] of [[930, 34, 100], [1046, 30, 88], [960, 82, 120]]) { P.predio(x, y, w, 40, { topo: '#c8c4b8', parede: '#f2efe6', fachada: 18, faixa: '#2c5a9e', caixa: false, porta: false }); }
        R(1000, 30, 30, 8, '#2c5a9e'); txt(P, 'UESB', 1015, 31, '#f2efe6');
        for (const [x, y, t] of [[944, 132, 'roxa'], [1092, 136, 'roxa'], [1124, 90, 'amarela'], [924, 92, 'roxa']]) P.arvore(x, y, .85, t, x);
        R(1024, 128, 34, 3, '#2c5a9e'); R(1024, 131, 34, 2, '#9aa0a6'); R(1026, 131, 2, 12, '#7a8086'); R(1054, 131, 2, 12, '#7a8086'); R(1030, 136, 22, 3, '#a8643a'); R(1060, 118, 18, 9, '#f2c94c'); txt(P, 'CIRC', 1069, 120, '#2a2a2a'); R(1068, 127, 2, 16, '#5a5e62');
        pessoa(P, 1036, 142, '#9a52c0'); pessoa(P, 1046, 142, '#3c8ab0'); } },
    { id: 't32', cena: 32, x: 300, nome: 'Lagoa das Bateias', sub: 'Pista de caminhada', caixa: [430, 560, 220, 170],
      descricao: 'Garças pescando, pedalinhos de cisne e a lenda de uma pepita no fundo. Um menino jura que ainda vai achar.',
      desenho: (P) => { const R = P.R; // lagoa: pista vermelha de caminhada com as marcas de distância, garças, pedalinhos de cisne, píer e barras de exercício
        R(600, 650, 40, 8, '#a87a4a'); for (let k = 0; k < 40; k += 5) R(600 + k, 650, 1, 8, '#7a4a2a'); for (const [x, y] of [[470, 612], [520, 640], [560, 600]]) { R(x, y, 14, 7, '#f6f6f0'); R(x + 11, y - 7, 3, 8, '#f6f6f0'); R(x + 12, y - 8, 4, 2, '#f6f6f0'); R(x + 15, y - 7, 2, 1, '#f08a24'); R(x + 3, y - 3, 4, 3, '#e8433a'); }
        for (let k = 0; k < 60; k++) { const a = Math.PI * (.08 + k / 59 * .84), x = 540 + Math.cos(a) * 104, y = 640 + Math.sin(a) * 82; R(x - 3, y - 3, 7, 7, '#c8543a'); if (k % 6 === 0) R(x - 1, y - 1, 3, 1, '#f2f2ee'); }
        for (const [x, y, t] of [[452, 690, '300M'], [540, 716, '700M'], [628, 690, '1100M']]) txt(P, t, x, y, '#f2f2ee');
        for (const [x, cor] of [[446, '#f2c94c'], [460, '#e8433a']]) { R(x, 650, 2, 14, cor); R(x + 10, 650, 2, 14, cor); R(x, 650, 12, 2, cor); }
        P.coqueiro(444, 724); P.coqueiro(648, 600); P.banco(600, 728); for (const [x, y] of [[620, 610], [470, 584]]) { R(x, y, 2, 8, '#f2f2ee'); R(x - 1, y - 3, 4, 3, '#f2f2ee'); R(x + 3, y - 2, 2, 1, '#e8c24c'); } } },
    { id: 't33', cena: 33, x: 300, nome: 'Parque da Cidade', sub: 'Portão do parque', caixa: [720, 680, 200, 86],
      descricao: 'Balanço, pista de skate, dominó dos aposentados e cachorro correndo atrás de bolinha. O lugar mais feliz da cidade. Por enquanto.',
      desenho: (P) => { const R = P.R; // parque: parquinho colorido (escorregador, balanço), muro grafitado e árvores
        R(738, 694, 3, 32, '#e8433a'); R(774, 694, 3, 32, '#e8433a'); R(736, 692, 44, 4, '#f2c94c'); for (const x of [748, 764]) { R(x, 696, 1, 18, '#5a5e62'); R(x - 3, 714, 7, 2, '#3c6aa8'); }
        R(790, 694, 22, 22, '#3c6aa8'); R(790, 694, 22, 3, '#6a9ad0'); R(792, 690, 18, 5, '#e8433a'); for (let k = 0; k < 6; k++) R(812 + k * 3, 698 + k * 4, 4, 3, '#f2c94c'); R(788, 716, 3, 12, '#3c6aa8'); R(809, 716, 3, 12, '#3c6aa8');
        R(836, 690, 76, 16, '#c8ccd0'); R(836, 690, 76, 2, '#e8ecef'); for (let k = 0; k < 18; k++) { const x = 838 + k * 4, cor = ['#e8433a', '#e8833a', '#f2c94c', '#3c8a5a', '#3c6aa8', '#9a52c0'][Math.floor(k / 3) % 6]; R(x, 694 + Math.round(Math.sin(k * 1.4) * 4) + 2, 4, 5, cor); }
        R(800, 732, 28, 12, '#e8d8a8'); R(800, 732, 28, 2, '#a8643a'); for (const [x, y] of [[860, 744], [900, 752], [736, 756], [918, 720]]) P.arvore(x, y, .9, 'verde', x); P.flores(842, 746, ['#e86a8a', '#f2c94c']); pessoa(P, 760, 740, '#e8433a'); } },
    { id: 't34', cena: 34, x: 300, nome: 'Serra do Marçal', sub: 'Mirante na beira da serra', caixa: [0, 588, 200, 120],
      descricao: 'A cidade acaba e o mundo despenca num mar de nuvens. Quem tem coragem pula de parapente. Quem não tem, compra mel.',
      desenho: (P) => { const R = P.R; for (const x of [30, 90]) { R(x, 600, 3, 60, '#e8ecef'); R(x - 1, 598, 5, 4, '#d8dce0'); } R(110, 660, 60, 4, '#a87a4a'); for (let k = 0; k < 60; k += 10) R(110 + k, 664, 3, 10, '#6a4a2a'); R(166, 640, 2, 22, '#9aa0a6');
        for (let x = 10; x < 190; x += 6) R(x, 690, 4, 3, '#c8ccd0'); P.R(40, 664, 40, 20, '#e8833a');  P.R(36, 650, 48, 10, '#f2e2b8'); P.R(36, 650, 48, 1, '#a8643a'); txt(P, 'MEL DA SERRA', 60, 652, '#7a4a10'); for (let k = 0; k < 4; k++) { P.R(44 + k * 9, 676, 6, 7, '#e8a83a'); P.R(45 + k * 9, 675, 4, 2, '#f6f6f0'); } P.c.globalAlpha = .45; for (let x = 0; x < 200; x += 18) P.circ(x + 9, 700, 12, '#ffffff', 5); P.c.globalAlpha = 1;for (let k = 0; k < 40; k += 8) P.R(40 + k, 664, 4, 20, '#f6ead0'); } }
  ];
  let TR2 = null; const RUAS2 = {};
  const MAPA2 = {
    chave: 'conquista2d', titulo: 'TÁXI DO SEU ZÉ · VITÓRIA DA CONQUISTA', subtitulo: 'O táxi só para nas entradas. Lá dentro, é com você.', lajotas: [72, 48], botao: 'IR DE TÁXI ▶', ilha: { margem: 300, eolicas: 7, parapentes: 3, balao: true }, relevo: true,
    terreno: (T) => {
      // Serra do Periperi: cerrado em dois degraus, com picos tortos
      T.poli([[6, -1.5], [7.5, 3.2], [12, 4.4], [18, 5.2], [24, 4.6], [30, 5.4], [37, 4.8], [44, 5.6], [50, 4.9], [56.5, 4.2], [57.2, -1.5]], { nivel: 2, tipo: 'cerrado' });
      T.poli([[15, -1.5], [16.2, 1.8], [20, 2.6], [23.5, 2.2], [24.2, -1.5]], { nivel: 3, tipo: 'cerrado' });
      T.poli([[33, -1.5], [34, 2.2], [38, 3], [42, 2.4], [43, -1.5]], { nivel: 3, tipo: 'cerrado' });
      // Reserva do Poço Escuro (platô de mata com cachoeira) e Serra do Marçal (beirada sobre as nuvens)
      T.poli([[-1.5, 30], [13, 30], [12.6, 36.4], [-1.5, 36.2]], { tipo: 'mata' });
      T.poli([[-1.5, 22.8], [7, 22.4], [12.4, 23.4], [12.6, 27], [12.2, 30.4], [8, 30.2], [4, 30.6], [-1.5, 30.4]], { nivel: 2, tipo: 'mata' });
      T.oval(6, 33.6, 3.2, 2, { nivel: 0 });
      T.ret(-1.5, 42, 16, 7, { tipo: 'nuvem' });
      T.poli([[-1.5, 37], [6, 36.6], [12.6, 37.4], [13, 40.4], [12, 43.1], [6, 42.9], [-1.5, 43.3]], { nivel: 3, tipo: 'cerrado' });
      // aeroporto
      T.retR(-1, 9.2, 14.5, 2.6, .5, { tipo: 'pista' }); T.retR(-1, 12, 14.2, 5.6, .6, { tipo: 'pedra' });
      // Lagoa das Bateias com prainha
      const lag = [[27.4, 38.6], [30, 36.9], [35, 36.7], [39.4, 38.3], [40.2, 41.3], [38.2, 44.2], [33.5, 45], [30.5, 43.6], [28.2, 42.6]];
      T.poli(lag.map(([x, y]) => [33.8 + (x - 33.8) * 1.14, 40.8 + (y - 40.8) * 1.2]), { tipo: 'areia' }); T.poli(lag, { nivel: 0 });
      // cafezal (fileiras curvas) com terreiro
      T.poli([[57.5, 35.2], [64, 34.6], [73.5, 35], [73.5, 49.5], [57, 49.5], [56.6, 42]], { tipo: 'cafe' });
      T.retR(60.4, 35.4, 9.2, 6.2, .6, { tipo: 'chao' }); T.retR(61, 42.4, 7, 3, .3, { tipo: 'calcada' });
      // praças, pátios e estacionamentos
      T.poli([[28.4, 12.2], [31, 11.6], [37, 11.7], [39.6, 12.6], [39, 15], [34, 15.6], [29.4, 15.2]], { tipo: 'pedra' }); T.retR(29.2, 22.4, 11.4, 6.2, .8, { tipo: 'pedra' }); T.poli([[45.8, 8.6], [48, 7.6], [53.6, 7.8], [55.2, 9.4], [54.8, 13.6], [50, 14.4], [46.2, 13.8]], { tipo: 'pedra' });
      T.retR(55.6, 15.6, 12, 2.6, .4, { tipo: 'asfalto' }); T.retR(55.4, 21.8, 10.4, 6.6, .6, { tipo: 'calcada' }); T.retR(57.4, .8, 13.6, 8.2, .8, { tipo: 'calcada' });
      T.retR(45.4, 35.2, 11, 7, .6, { tipo: 'asfalto' }); T.retR(14.8, 18.4, 9.4, 1.2, .3, { tipo: 'calcada' }); T.retR(15.2, 45, 8, 4, .5, { tipo: 'asfalto' }); T.retR(15.6, 23.4, 9.6, 9.2, 1, { tipo: 'chao' });
      // avenidas (asfalto) e a rotatória do Monumento ao Índio
      T.oval(45.9, 20.75, 3.4, 2.6, { tipo: 'asfalto' });
      RUAS2.av1 = T.curva([[13, 20.5], [20, 20.9], [28, 20.2], [36, 20.8], [42.5, 20.6]], 1.9, { tipo: 'asfalto' });
      RUAS2.av1b = T.curva([[49.3, 20.7], [56, 20.2], [64, 20.8], [73.5, 20.4]], 1.9, { tipo: 'asfalto' });
      RUAS2.av2 = T.curva([[44.2, 30.6], [50, 30.9], [57, 30.3], [64, 30.8], [73.5, 30.5]], 1.9, { tipo: 'asfalto' });
      RUAS2.nB = T.curva([[45.9, 14.6], [45.9, 18.2]], 1.7, { tipo: 'asfalto' });
      RUAS2.sB = T.curva([[45.9, 23.3], [45.2, 27], [44.2, 31], [43.3, 35], [43.1, 40], [44.2, 44], [45.8, 49.5]], 1.8, { tipo: 'asfalto' });
      RUAS2.A = T.curva([[27.2, 8.6], [26.5, 13], [26.9, 20.5], [26.2, 27], [26.6, 31], [25.6, 34.2]], 1.8, { tipo: 'asfalto' });
      RUAS2.W = T.curva([[13.4, 20.4], [14.4, 26], [14, 31], [14.5, 33.6], [18, 34.3], [22, 34.1], [25.6, 34.2]], 1.7, { tipo: 'asfalto' });
      RUAS2.aero = T.curva([[12.6, 14.6], [15, 12.4], [20, 11.9], [26.6, 12.6]], 1.6, { tipo: 'asfalto' });
      T.curva([[12.8, 14.6], [13.2, 20.4]], 1.6, { tipo: 'asfalto' }); RUAS2.C = T.curva([[71, 9.2], [71.4, 15], [70.8, 20.4]], 1.6, { tipo: 'asfalto' });
      // trilhas de terra: subida do Cristo, parque e beira da lagoa
      T.curva([[45, 46.5], [50, 45.2], [55, 46.8], [58, 45.5]], 1, { tipo: 'chao' }); T.curva([[3, 23], [5, 26.5], [9, 27.6], [12, 26]], 1, { tipo: 'chao' });
    },
    chao: (P, c, Tr) => { const R = P.R; for (const r of Tr.ruas) if (r.tipo === 'asfalto' && r.larg >= 1.8) r.pl.forEach(([x, y], k) => { if (k % 8 < 3) R(x, y, 2, 1, '#f2e2a0'); }); // faixa do meio
      for (let k = 0; k < 120; k++) R(980 + h(k, 71) * 104, 682 + h(k, 72) * 42, 2, 1, h(k, 73) > .5 ? '#5a3420' : '#7a4a2a'); }, // café secando no terreiro
    objetos: (add, Tr) => {
      TR2 = Tr; const caixas = caixasDe(PONTOS), lote = Lote(Tr, caixas), ref = (x, y, w, h, f) => { lote.marca(x - 4, y - 4, w + 8, h + 8); add(y + h, f); };
      // ---- referências da Campanha 2 ----
      ref(250, 404, 150, 116, (P) => { const R = P.R; // Ferro-Velho do Gugu
        for (let k = 0; k <= 150; k += 6) { R(250 + k, 404, 3, 12, '#8a8e94'); R(250 + k, 404, 3, 1, '#c8ccd0'); } R(250, 406, 150, 2, '#6a6e74'); R(250, 412, 150, 1, '#6a6e74');
        for (const [x, y, s] of [[276, 470, 1], [330, 490, 1.2], [372, 462, .9]]) { P.sombra(x, y + 2, 20 * s, 4); P.circ(x, y - 6 * s, 20 * s, '#6a5a4a', 10 * s); P.circ(x - 3, y - 8 * s, 15 * s, '#8a7a6a', 7 * s); for (let j = 0; j < 10; j++) R(x - 14 * s + h(j, x) * 28 * s, y - 14 * s + h(x, j) * 12 * s, 3, 2, ['#a85a3a', '#c8ccd0', '#3c6aa8', '#5a5e62'][j % 4]); }
        R(296, 430, 34, 12, '#a85a3a'); R(302, 424, 18, 7, '#94503a'); R(304, 426, 6, 4, '#4a5a6a'); R(298, 440, 5, 4, '#1c1c1c'); R(322, 440, 5, 4, '#1c1c1c'); // carcaça de carro
        for (let k = 0; k < 4; k++) { P.circ(388, 508 - k * 5, 6, '#1c1c1c', 3); P.circ(388, 508 - k * 5, 2, '#5a5e62', 1); }
        R(352, 420, 3, 44, '#e8a83a'); R(352, 420, 40, 3, '#e8a83a'); R(348, 460, 12, 6, '#c8962a');
        R(258, 386, 74, 13, '#2a2a2a'); R(259, 387, 72, 11, '#e8c24c'); txt(P, 'FERRO-VELHO', 295, 390, '#2a1a10'); R(266, 399, 2, 6, '#5a5e62'); R(322, 399, 2, 6, '#5a5e62'); });
      ref(258, 354, 40, 40, (P) => P.casa(262, 360, 34, 34, { telhado: '#9a4a34', parede: '#f2c4dc', madeira: false, janelas: [4, 24], porta: 13 })); // casa da Dona Creuza (a janela da fofoca)
      ref(796, 262, 60, 42, (P) => { const R = P.R; // ponto de mototáxi do Tonhão
        R(800, 266, 2, 26, '#5a5e62'); R(796, 258, 56, 10, '#1c1c1c'); R(797, 259, 54, 8, '#e8833a'); txt(P, 'MOTOTAXI', 824, 261, '#1c1c1c');
        for (let k = 0; k < 3; k++) { const x = 812 + k * 13, y = 296; R(x - 5, y, 11, 1, 'rgba(0,0,0,.3)'); R(x - 5, y - 4, 10, 3, '#2a2a2a'); R(x - 5, y - 3, 3, 3, '#1c1c1c'); R(x + 3, y - 3, 3, 3, '#1c1c1c'); R(x - 2, y - 7, 6, 3, ['#c43c3a', '#3c6aa8', '#e8c24c'][k]); }
        pecas.pessoaG(P, 850, 298, '#e8833a', '#a8704a', '#1c1c1c'); P.R(847, 287, 7, 3, '#1c1c1c'); });
      ref(556, 466, 66, 52, (P) => { P.casa(560, 470, 58, 44, { telhado: '#c8846a', parede: '#f6ead0', madeira: false, janelas: [6], porta: 36 }); const R = P.R; R(564, 490, 28, 9, '#7a4a2a'); txt(P, 'BISCOITO', 578, 492, '#ffe39a'); P.circ(610, 470, 7, '#e8d4a0', 7); P.circ(610, 470, 3, '#c8a46a', 3); }); // biscoitaria do Seu Valdomiro
      ref(494, 470, 34, 28, (P) => { const R = P.R, x = 496, y = 494; P.sombra(x + 14, y, 16, 3); R(x, y - 12, 28, 10, '#8a5a36'); R(x, y - 12, 28, 2, '#a87a4a'); for (let k = 0; k < 6; k++) { R(x + 2 + k * 4, y - 18 + (k % 2), 3, 6, ['#7a3a2a', '#3c8a5a', '#c8962a', '#5a2a5a'][k % 4]); R(x + 3 + k * 4, y - 20 + (k % 2), 1, 2, '#dde0e3'); } P.circ(x + 4, y - 1, 3, '#3a2414'); P.circ(x + 24, y - 1, 3, '#3a2414'); R(x - 6, y - 10, 6, 2, '#6a4228'); }); // carrinho das garrafadas do Seu Lindomar
      ref(1040, 272, 30, 30, (P) => { const R = P.R; P.c.strokeStyle = '#f6f6f0'; P.c.lineWidth = 2; P.c.beginPath(); P.c.arc(1046, 280, 6, 0, Math.PI * 2); P.c.stroke(); P.c.lineWidth = 1; R(1045, 286, 2, 14, '#5a5e62'); R(1041, 299, 10, 1, '#5a5e62'); pecas.pessoaG(P, 1060, 300, '#f29ab0', '#c99068', '#e8c24c'); R(1056, 288, 3, 4, '#1c1c1c'); }); // Kauã Influencer e o ring light
      ref(1066, 356, 74, 60, (P) => { P.predio(1070, 360, 66, 52, { parede: '#2a2a3a', topo: '#4a4a5a', fachada: 26, caixa: false }); const R = P.R; R(1084, 384, 38, 10, '#1c1c1c'); }); // LAN house dos gêmeos
      ref(828, 518, 52, 40, (P) => { const R = P.R; R(838, 520, 3, 34, '#5a5e62'); R(838, 520, 22, 3, '#5a5e62'); R(856, 523, 1, 6, '#2a2a2a'); R(852, 529, 9, 16, '#c43c3a'); R(852, 529, 9, 2, '#e8635a'); R(830, 553, 30, 2, 'rgba(0,0,0,.2)'); }); // saco de pancada do Breno
      ref(1100, 680, 46, 66, (P) => { const R = P.R; for (let k = 0; k < 6; k++) { const x = 1104 + (k % 3) * 12, y = 744 - Math.floor(k / 3) * 9; R(x, y - 9, 12, 10, '#c8b48a'); R(x, y - 9, 12, 1, '#e8d8b0'); txt(P, 'B', x + 6, y - 7, '#7a4a2a'); } R(1122, 694, 2, 30, '#5a3820'); R(1108, 672, 30, 22, '#2a1a10'); R(1110, 674, 26, 18, '#f6ead0'); R(1116, 678, 12, 10, '#f2f2ee'); R(1128, 680, 3, 5, '#f2f2ee'); R(1117, 680, 10, 3, '#5a3420'); txt(P, 'BARAO', 1123, 666, '#ffe39a', { sombra: '#2a1a10' }); }); // sacas e a xícara do Barão do Café
      ref(648, 202, 22, 34, (P) => { const R = P.R; R(658, 210, 2, 24, '#5a5e62'); R(648, 196, 22, 14, '#1c1c1c'); P.sombra(660, 234, 6, 2); }); // relógio-termômetro do centro
      ref(654, 64, 56, 58, (P) => { const R = P.R; for (const x of [664, 696]) { R(x, 96, 2, 26, '#c8ccd0'); } R(662, 120, 38, 2, '#8a8e94'); P.sombra(681, 122, 22, 3); }); // pé da roda-gigante do festival
      ref(42, 196, 1, 1, () => {}); // vaga do avião na pista
      for (const [x, y, s, bg, fg] of [[586, 304, 'SMART FAT', '#1c2a3a', '#7af0c8'], [988, 552, 'PAGUE MAIS', '#c43c3a', '#fff6dc'], [118, 332, 'CASAS BAIXA', '#2c5a9e', '#ffe39a']]) ref(x, y - 28, 60, 30, (P) => pecas.outdoor(P, x, y, s, bg, fg));
      for (const [x, y] of [[180, 52], [300, 34], [880, 52]]) ref(x - 8, y - 50, 16, 52, (P) => pecas.antena(P, x, y)); // antenas da serra
      // plaquinhas do ponto de táxi do Seu Zé
      for (const [bx, by, bw, bh] of caixas) for (const [dx, dy] of [[bw - 8, bh + 12], [8, bh + 12], [bw + 10, bh - 4], [-10, bh - 4]]) { const x = bx + dx, y = by + dy; if (lote.ponto(x, y, 5, (a, b) => Tr.nivelEm(a, b) > 0 && Tr.px.wd[Math.round(b) * Tr.px.W + Math.round(a)] < 0)) { add(y, (P) => pecas.placaTaxi(P, x, y)); break; } }
      // ---- prédios brancos e bege da cidade ----
      const paredes = ['#ebe8de', '#e0d6c2', '#dfe6ea', '#e8dcc8', '#f2e2a8', '#d8d0c0', '#f0ece4'];
      for (let i = 0; i < 4000; i++) { const alto = h(i, 81) > .35, w = alto ? 30 + Math.floor(h(i, 82) * 3) * 6 : 30, hh = alto ? 40 + Math.floor(h(i, 83) * 4) * 6 : 32, x = 210 + h(i, 84) * 930, y = 96 + h(i, 85) * 470; if (Tr.nivelEm(x, y + hh) !== 1) continue; if (!lote.area(x - 3, y - 2, w + 8, hh + 8)) continue; const cor = paredes[i % paredes.length];
        add(y + hh, (P) => (alto ? P.predio(x, y, w, hh, { parede: cor, fachada: 18 + (i % 3) * 6, porta: i % 2 === 0, faixa: i % 4 === 0 ? '#c8a46a' : null }) : P.casa(x, y, w, hh, { telhado: ['#b8644a', '#9a4a34', '#c8544a'][i % 3], parede: cor, madeira: false, janelas: [4, 22], porta: 13 }))); }
      // ---- cactos cabeça-de-frade e pedras no cerrado ----
      const cerrado = tipoEh(Tr, 'cerrado');
      for (let i = 0; i < 260; i++) { const x = h(i, 91) * 1150, y = h(i, 92) * 768; if (!lote.ponto(x, y, 6, cerrado)) continue; const k = h(i, 93); add(y, (P) => (k > .6 ? pecas.cacto(P, x, y) : k > .35 ? P.pedra(x, y) : P.arbusto(x, y, i, k > .2 ? '#f2c94c' : null))); }
      // ---- árvores: ipês nas avenidas, eucaliptos no café e na reserva, pinheiros no parque ----
      for (let i = 0; i < 900; i++) { const x = 4 + h(i, 101) * 1144, y = 8 + h(i, 102) * 756; if (!lote.ponto(x, y, 8)) continue; const tp = Tr.tipoEm(x, y), k = h(i, 103);
        if (tp === 'mata') add(y, (P) => (k > .75 ? P.eucalipto(x, y, 1, i) : P.arvore(x, y, .9 + k * .5, k > .4 ? 'escura' : 'verde', i)));
        else if (y > 660 && x > 700 && x < 940) add(y, (P) => (k > .5 ? P.pinheiro(x, y, 1, i) : P.arvore(x, y, .9, 'verde', i)));
        else if (x > 900 && y > 540) { if (k > .5) continue; add(y, (P) => P.eucalipto(x, y, .9 + k * .3, i)); }
        else { if (k > .5) continue; add(y, (P) => (k > .38 ? P.arvore(x, y, .9, 'roxa', i) : k > .3 ? P.arvore(x, y, .9, 'amarela', i) : P.arvore(x, y, .8 + k * .6, 'verde', i))); } }
      for (const pl of [RUAS2.av1, RUAS2.av1b, RUAS2.av2, RUAS2.A]) for (let k = 12; k < pl.length; k += 36) { const [x, y] = faixa(pl, 22, false)[k]; if (lote.ponto(x, y, 4)) add(y, (P) => P.poste(x - 2, y)); }
    },
    animarChao: (P, t) => { const R = P.R; for (let k = 0; k < 12; k++) { const y = 486 + ((t * 46 + k * 7) % 48); R(90 + (k % 4) * 4, y, 2, 5, k % 3 ? '#e2f4ff' : '#9fd0f0'); } for (let k = 0; k < 5; k++) { const a = t * 3 + k; P.c.globalAlpha = .6; P.circ(98 + Math.cos(a) * 8, 536 + Math.sin(a) * 2, 3, '#ffffff', 1); P.c.globalAlpha = 1; } // cachoeira do Poço Escuro
      for (let k = 0; k < 9; k++) { const x = ((t * 6 + k * 34) % 240) - 20, y = 742 + (k % 3) * 9; P.c.globalAlpha = .75; P.circ(x, y, 16, '#ffffff', 5); P.c.globalAlpha = 1; } }, // mar de nuvens embaixo do Marçal
    animar: (P, t) => { const R = P.R;
      // trânsito: avenidas, a rotatória com mototáxis e o engarrafamento na Olívia Flores
      naRua(P, t, faixa(RUAS2.av1, -5, false), 3, ['#c43c3a', '#3c6aa8', '#f2f2ee'], 26); naRua(P, t, faixa(RUAS2.av1, 5, true), 2, ['#e8c24c', '#2a2a2a'], 24, .4, (j) => (j === 0 ? 'taxi' : null));
      naRua(P, t, faixa(RUAS2.av2, 5, true), 2, ['#2c5a9e', '#c43c3a', '#3c8a5a'], 18, .2, 'bus'); naRua(P, t, faixa(RUAS2.av2, -5, false), 2, ['#f2f2ee', '#7a3a8a'], 24, .6);
      naRua(P, t, RUAS2.A, 2, ['#f2f2ee', '#c43c3a'], 20, .1); naRua(P, t, [...RUAS2.sB].reverse(), 2, ['#e8c24c', '#3c6aa8'], 20, .5, (j) => (j === 0 ? 'taxi' : null)); naRua(P, t, RUAS2.W, 1, ['#3c8a5a'], 18, .3); naRua(P, t, RUAS2.aero, 1, ['#e8c24c'], 16, .2, 'taxi');
      for (let k = 0; k < 4; k++) { const a = t * 1.1 + k * 1.57, x = 734 + Math.cos(a) * 46, y = 334 + Math.sin(a) * 30; veiculo(P, x, y, ['#c43c3a', '#e8833a', '#3c6aa8', '#e8c24c'][k], a + Math.PI / 2, 'moto'); } // mototáxis do Tonhão rodando a rotatória
      { const fila = A.trilho(faixa(RUAS2.av1b, -5, false)); for (let k = 0; k < 7; k++) { const p = fila.em(.05 + k * .055); veiculo(P, p.x, p.y + 3, ['#f2f2ee', '#c43c3a', '#3c6aa8', '#2a2a2a', '#3c8a5a', '#e8c24c', '#7a3a8a'][k], 0); if (Math.floor(t * 2 + k) % 2) R(p.x - 9, p.y - 1, 1, 2, '#ff3a3a'); }
        const q = Math.floor(t / 1.6) % 7, p = fila.em(.05 + q * .055), b = (t / 1.6) % 1; if (b < .7) { R(p.x - 12, p.y - 26, 26, 10, '#fff6dc'); R(p.x - 12, p.y - 26, 26, 1, '#2a2a2a'); R(p.x - 12, p.y - 17, 26, 1, '#2a2a2a'); R(p.x - 2, p.y - 16, 3, 3, '#fff6dc'); txt(P, q % 2 ? 'BIII!' : 'FOOM!', p.x + 1, p.y - 24, '#c43c3a'); } } // engarrafamento: Cleiton e Dona Rosilda
      // avião decolando do Glauber Rocha
      { const c = (t % 18) / 18; if (c < .55) { const u = c / .55, x = 10 + u * u * 260, sobe = Math.max(0, u - .45) * 120, y = 172 - sobe; P.c.globalAlpha = .25; P.circ(x + 4, 174, 12, '#000', 2); P.c.globalAlpha = 1; R(x - 12, y - 4, 26, 6, '#f2f4f6'); R(x - 12, y - 1, 26, 1, '#c9ced2'); R(x - 14, y - 10, 5, 7, '#3c6aa8'); R(x - 2, y - 2, 10, 3, '#e8ecef'); R(x + 12, y - 3, 3, 3, '#9fc4d0'); for (let k = 0; k < 5; k++) R(x - 6 + k * 3, y - 3, 2, 1, '#3c4a5a'); } }
      // ônibus saindo da rodoviária e gente na feira, na UESB e no parque
      fumaca(P, 1066, 576, t); for (let k = 0; k < 5; k++) { const u = (t * .04 + k / 5) % 1; pessoa(P, 470 + u * 170, 448 + (k % 2) * 10, ['#e86a8a', '#3c6aa8', '#f2c94c', '#7a3a8a', '#3c8a5a'][k], t); }
      for (let k = 0; k < 4; k++) { const u = (t * .05 + k / 4) % 1; pessoa(P, 936 + u * 190, 140 + (k % 2) * 4, ['#3c6aa8', '#c43c3a', '#3c8a5a', '#f2c94c'][k], t); R(936 + u * 190 + 2, 133 + (k % 2) * 4, 3, 3, '#f6ead0'); }
      { const a = Math.sin(t * 2.4) * .6; R(760 + Math.sin(a) * 10 - 3, 712 + Math.cos(a) * 6, 7, 2, '#3a3a36'); pessoa(P, 760 + Math.sin(a) * 10, 712 + Math.cos(a) * 6, '#e86a8a', 0, false); const u = (t * .3) % 1, bx = 840 + u * 60, d = Math.abs(Math.sin(u * Math.PI * 3)) * 6; R(bx, 748 - d, 3, 3, '#f2c94c'); R(bx - 12, 748, 8, 4, '#c8a46a'); R(bx - 6, 746, 3, 3, '#c8a46a'); R(bx - 13, 746, 2, 2, '#c8a46a'); } // balanço e cachorro correndo atrás da bolinha
      // eólicas, parapente, pedalinhos, torcida
      for (const x of [30, 90]) { for (let k = 0; k < 3; k++) { const a = t * 3 + k * 2.1 + x; P.c.strokeStyle = '#f2f4f6'; P.c.lineWidth = 2; P.c.beginPath(); P.c.moveTo(x + 1, 600); P.c.lineTo(x + 1 + Math.cos(a) * 14, 600 + Math.sin(a) * 14); P.c.stroke(); } } P.c.lineWidth = 1;
      { const u = (t * .12) % 1, x = 168 + u * 120, y = 640 + u * 80 - Math.sin(u * 6) * 6; for (let k = -5; k <= 5; k++) R(x + k * 2, y - 10 - Math.round(Math.sqrt(1 - (k / 6) ** 2) * 3), 2, 2, k % 2 ? '#3c8ad8' : '#f2c94c'); R(x - 1, y - 2, 3, 4, '#c43c3a'); }
      for (let k = 0; k < 3; k++) { const u = (t * .03 + k / 3) % 1, a = u * Math.PI * 2, x = 33 * TS + Math.cos(a) * 70, y = 41 * TS + Math.sin(a) * 36 - 4; R(x, y, 8, 4, '#f6f6f0'); R(x + 6, y - 4, 2, 5, '#f6f6f0'); R(x + 7, y - 5, 3, 2, '#f6f6f0'); R(x + 9, y - 4, 1, 1, '#f08a24'); R(x + 1, y + 4, 8, 1, '#9fd0f0'); }
      for (let k = 0; k < 40; k++) { if (Math.sin(t * 6 + k) > .5) R(304 + Math.cos(k / 40 * Math.PI * 2) * 70, 628 + Math.sin(k / 40 * Math.PI * 2) * 46, 3, 3, '#ffffff'); }
      { const x = 452, y = 640, g = Math.floor(t * 2) % 5 === 0; pessoa(P, x, y, '#3c8a5a', 0, false); P.circ(x + 6, y - 2, 4, '#7a5a3a', 1); if (g) { R(x + 5, y - 4, 2, 2, '#ffe23a'); R(x + 4, y - 6, 1, 1, '#ffffff'); } } // o menino da bateia procurando a pepita
      for (const [x, y] of [[620, 610], [600, 700]]) { R(x, y - 8, 3, 5, '#f6f6f0'); R(x + 1, y - 11, 2, 3, '#f6f6f0'); R(x + 3, y - 10, 3, 1, '#e8c24c'); R(x, y - 3, 1, 4, '#2a2a2a'); R(x + 2, y - 3, 1, 4, '#2a2a2a'); } // garças
      // saguis pulando na reserva
      for (let k = 0; k < 3; k++) { const u = (t * .25 + k / 3) % 1, x = 40 + k * 50 + u * 30, y = 420 + k * 20 - Math.abs(Math.sin(u * Math.PI * 2)) * 14; R(x, y - 4, 4, 3, '#8a7a6a'); R(x + 3, y - 6, 3, 3, '#a89a88'); R(x + 3, y - 7, 1, 1, '#f6f6f0'); R(x + 5, y - 7, 1, 1, '#f6f6f0'); R(x - 3, y - 3 + Math.round(Math.sin(t * 4 + k)), 3, 1, '#5a4a3a'); }
      // fofoca da Dona Creuza
      { const q = (t / 2.2) % 1, fr = ['PSIU', 'JURA?', 'SABIA?'][Math.floor(t / 2.2) % 3]; R(276, 372, 6, 6, '#3a5a8a'); R(277, 373, 4, 4, '#c99068'); if (q < .8) { const y = 352 - q * 8; R(266, y - 9, 30, 10, '#fff6dc'); R(266, y - 9, 30, 1, '#2a2a2a'); R(266, y, 30, 1, '#2a2a2a'); R(278, y + 1, 3, 3, '#fff6dc'); txt(P, fr, 281, y - 7, '#7a2a5a'); } }
      // Dona Lurdes regando e o varal na laje da pensão
      { pecas.pessoaG(P, 262, 314, '#7a4a8a', '#c99068', '#d0d0d0'); R(266, 304, 5, 3, '#3c8a5a'); for (let k = 0; k < 3; k++) { const q = (t * 2 + k / 3) % 1; R(272 + q * 3, 305 + q * 8, 1, 2, '#9fd0f0'); } R(276, 310, 8, 5, '#a8643a'); R(277, 306, 2, 4, '#e86a8a'); R(281, 307, 2, 3, '#f2c94c');
        P.c.strokeStyle = '#4a4a4a'; P.c.beginPath(); P.c.moveTo(284, 236); P.c.lineTo(334, 238); P.c.stroke(); for (let k = 0; k < 5; k++) R(287 + k * 9, 237, 5, 6 + Math.round(Math.sin(t * 3 + k)), ['#e86a8a', '#f6f6f0', '#3c6aa8', '#f2c94c', '#3c8a5a'][k]); }
      // vapor da biscoitaria, flash do Kauã, LAN dos gêmeos, cachorro do Breno
      for (let k = 0; k < 4; k++) { const q = (t * .5 + k / 4) % 1; P.c.globalAlpha = (1 - q) * .6; P.circ(590 + Math.sin(t + k) * 4, 470 - q * 22, 2 + q * 3, '#ffffff'); } P.c.globalAlpha = 1;
      { const f = (t % 2.6) < .12; if (f) { P.c.globalAlpha = .7; P.circ(1057, 290, 12, '#ffffff', 10); P.c.globalAlpha = 1; for (let k = 0; k < 6; k++) { const a = k * 1.05; R(1057 + Math.cos(a) * 14, 290 + Math.sin(a) * 10, 2, 2, '#fff6a0'); } } }
      { const on = Math.floor(t * 3) % 4 !== 0; txt(P, 'LAN', 1103, 386, on ? '#3ae0ff' : '#1c4a5a', { s: 2 }); for (let k = 0; k < 4; k++) R(1076 + k * 15, 400, 10, 6, Math.floor(t * 5 + k) % 3 ? '#2a6ae8' : '#5ae0ff'); }
      { const lat = Math.floor(t * 2) % 3 === 0, x = 866 + Math.sin(t * .8) * 6; R(x, 550, 11, 5, '#d8d0c4'); R(x + 9, 547, 5, 5, '#d8d0c4'); R(x + 12, 549, 1, 1, '#1c1c1c'); R(x + 1, 555, 2, 2, '#b8b0a4'); R(x + 8, 555, 2, 2, '#b8b0a4'); R(x - 2, 549, 3, 1, '#d8d0c4'); R(x + 9, 552, 3, 1, '#c43c3a'); if (lat) { R(x + 16, 538, 16, 8, '#fff6dc'); txt(P, 'AU!', x + 24, 540, '#c43c3a'); } }
      // relógio-termômetro: hora e frio de Conquista
      { const mostra = Math.floor(t / 2.5) % 2; R(650, 198, 18, 10, '#0c0c0c'); txt(P, mostra ? '12C' : '0740', 659, 200, mostra ? '#5ae0ff' : '#ff9a3a'); }
      // roda-gigante do festival
      { const cx = 681, cy = 92, r = 24; P.c.strokeStyle = '#e8ecef'; P.c.beginPath(); P.c.arc(cx, cy, r, 0, Math.PI * 2); P.c.stroke(); for (let k = 0; k < 8; k++) { const a = t * .5 + k * Math.PI / 4, x = cx + Math.cos(a) * r, y = cy + Math.sin(a) * r; P.c.beginPath(); P.c.moveTo(cx, cy); P.c.lineTo(x, y); P.c.stroke(); R(x - 3, y, 6, 5, ['#e8433a', '#f2c94c', '#3c6aa8', '#3c8a5a'][k % 4]); } R(cx - 2, cy - 2, 4, 4, '#c8ccd0'); }
      // antenas piscando, urubus no Cristo, abelhas do mel
      if (Math.floor(t * 1.5) % 2) for (const [x, y] of [[180, 52], [300, 34], [880, 52]]) R(x - 1, y - 52, 3, 3, '#ff3a3a');
      for (let k = 0; k < 4; k++) { const a = t * .5 + k * 1.6, x = 432 + Math.cos(a) * (40 + k * 12), y = 40 + Math.sin(a) * 10 + k * 8; R(x - 4, y, 3, 1, '#2a2622'); R(x + 2, y, 3, 1, '#2a2622'); R(x - 1, y, 3, 1, '#2a2622'); }
      for (let k = 0; k < 5; k++) R(60 + Math.sin(t * 5 + k * 2) * 10, 660 + Math.cos(t * 4 + k) * 5, 1, 1, '#f2c94c');
      // neblina de Conquista passando devagar
      for (let k = 0; k < 4; k++) { const x = ((t * 5 + k * 330) % 1500) - 200, y = 140 + k * 150; P.c.globalAlpha = .13; P.circ(x, y, 110, '#f4f8fa', 26); P.circ(x + 70, y + 8, 80, '#f4f8fa', 20); P.c.globalAlpha = 1; }
    },
    veiculo: (P, t) => carrinho(P, 0, 0, '#f2c94c', 1, true),
    locais: PONTOS
  };
  function abrirMapa2(cenaAtual, aoIr, opts = {}) {
    if (!window.Mapa3D) return false; const visto = opts.liberado || travaC2;
    const d = { ...MAPA2, locais: PONTOS.map((L) => ({ ...L, atual: L.cena === cenaAtual, estado: L.cena === cenaAtual ? { ok: true } : visto(L), previa: previaCena(L.cena, Math.max(0, L.x - 360)) })), aoIr: (id) => { const L = PONTOS.find((q) => q.id === id); if (L) aoIr?.(L.cena, L.x); } };
    if (opts.teste) { const prox = ORDEM.find((v) => !vencidos.includes(v)); d.teste = prox ? { rotulo: 'TESTE: VENCER ' + VILOES[prox], acao: () => { vencidos.push(prox); salvarV(); window.Mapa3D.fechar(); setTimeout(() => abrirMapa2(cenaAtual, aoIr, opts), 380); } } : { rotulo: 'TESTE: ZERAR VILÕES', acao: () => { vencidos = []; salvarV(); window.Mapa3D.fechar(); setTimeout(() => abrirMapa2(cenaAtual, aoIr, opts), 380); } }; }
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
    abrir: abrirMapa2,
    vencidos: () => vencidos.slice(), vencer: (v) => { if (ORDEM.includes(v) && !vencidos.includes(v)) { vencidos.push(v); salvarV(); } }, zerarVencidos: () => { vencidos = []; salvarV(); }, viloes: () => ({ ...VILOES })
  };
  window.MapasJogo = Object.freeze({ abrirCampanha1: abrirMapa1, abrirCampanha2: abrirMapa2, campanha1: () => C1.map(({ id, nome, sub, descricao }) => ({ id, nome, sub, descricao })), taxi: CampanhaTaxi });
  window.CampanhaTaxi = Object.freeze(CampanhaTaxi);
})();
