/* Da Roça Adventure — tela inicial "roça viva".
   - Fundo novo em pixel art (480x270 ampliado), todo desenhado em código: a roça do Sapo com casa, celeiro, moinho,
     pé de cacau, árvore do balanço, horta, rio, galinhas, o sapo, o próprio Da Roça e o céu com hora do dia.
   - Dá para mexer no fundo: tocar no chão planta (girassol, milho, cacau, abóbora, flores, couve), as galinhas pulam,
     o sol/lua troca a hora do dia, o céu solta passarinhos ou estrela cadente, a nuvem chove, o moinho dispara,
     a casa solta fumaça e acende a luz, o rio pula peixe, o sapo pula, o Da Roça acena, o balanço balança...
   - Logo novo: placa de tábuas com letras desenhadas à mão (contorno, relevo e brilho), faixa ADVENTURE, milho,
     girassol, cacau, a galinha e o sapo. As letras caem uma a uma na entrada; tocar no logo faz uma onda.
   - Botões ganham ícones em pixel (o estilo de tábua fica no tela-inicial.css). Nenhum id ou função dos botões muda. */
(() => {
  'use strict';
  const tela = document.getElementById('startScreen'), cvFundo = document.getElementById('titleCanvas');
  if (!tela || !cvFundo || window.TelaInicial) return;
  tela.classList.add('tela-roca');

  /* ---------------- utilidades ---------------- */
  const hash = (n) => { const s = Math.sin(n * 127.1 + 311.7) * 43758.5453; return s - Math.floor(s); };
  const mk = (w, h) => { const c = document.createElement('canvas'); c.width = w; c.height = h; const x = c.getContext('2d'); x.imageSmoothingEnabled = false; return [c, x]; };
  const lerp = (a, b, k) => a + (b - a) * k, clamp = (v, a, b) => Math.max(a, Math.min(b, v)), rnd = (a, b) => a + Math.random() * (b - a);
  const hx = (h) => { const n = parseInt(h.slice(1), 16); return [n >> 16 & 255, n >> 8 & 255, n & 255]; };
  const mixc = (a, b, k) => { const A = hx(a), B = hx(b); return '#' + A.map((v, i) => Math.round(v + (B[i] - v) * clamp(k, 0, 1)).toString(16).padStart(2, '0')).join(''); };
  const pinta = (c) => (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const bola = (c) => (cx, cy, r, col, ry = r) => { c.fillStyle = col; for (let y = -ry; y <= ry; y++) { const w = Math.round(r * Math.sqrt(Math.max(0, 1 - (y / ry) * (y / ry)))); c.fillRect(Math.round(cx - w), Math.round(cy + y), w * 2 + 1, 1); } };
  const reduzido = matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---------------- sons curtinhos (respeitam o botão de som) ---------------- */
  let ac = null;
  function tom(f1, f2, dur, tipo = 'square', vol = .05, atraso = 0) {
    const t = ac.currentTime + atraso, o = ac.createOscillator(), g = ac.createGain(); o.type = tipo; o.frequency.setValueAtTime(f1, t); o.frequency.exponentialRampToValueAtTime(Math.max(20, f2), t + dur);
    g.gain.setValueAtTime(vol, t); g.gain.exponentialRampToValueAtTime(.0001, t + dur); o.connect(g); g.connect(ac.destination); o.start(t); o.stop(t + dur + .02);
  }
  function ruido(dur, vol = .05, corte = 1800) { const n = Math.floor(ac.sampleRate * dur), b = ac.createBuffer(1, n, ac.sampleRate), d = b.getChannelData(0); for (let i = 0; i < n; i++) d[i] = (Math.random() * 2 - 1) * (1 - i / n); const s = ac.createBufferSource(), f = ac.createBiquadFilter(), g = ac.createGain(); f.type = 'lowpass'; f.frequency.value = corte; g.gain.value = vol; s.buffer = b; s.connect(f); f.connect(g); g.connect(ac.destination); s.start(); }
  function som(tipo) {
    try {
      if (window.Game?.soundOn && !window.Game.soundOn()) return;
      ac = ac || new (window.AudioContext || window.webkitAudioContext)(); if (ac.state === 'suspended') ac.resume();
      ({
        planta: () => { tom(330, 660, .09, 'triangle', .07); tom(660, 990, .1, 'triangle', .05, .07); },
        galinha: () => { tom(900, 1300, .06, 'square', .03); tom(1000, 1500, .07, 'square', .03, .09); tom(800, 1100, .05, 'square', .025, .2); },
        dia: () => { [523, 659, 784, 1047].forEach((f, i) => tom(f, f, .18, 'triangle', .045, i * .07)); },
        estrela: () => { [1568, 1319, 1175, 1568].forEach((f, i) => tom(f, f * 1.01, .12, 'sine', .04, i * .06)); },
        agua: () => { ruido(.25, .08, 1200); tom(500, 180, .15, 'sine', .05); },
        sapo: () => { tom(160, 110, .12, 'square', .05); tom(150, 100, .12, 'square', .045, .14); },
        vento: () => { ruido(.6, .05, 700); },
        oi: () => { tom(587, 784, .1, 'triangle', .05); tom(784, 988, .12, 'triangle', .05, .1); },
        pop: () => { tom(600, 900, .06, 'triangle', .05); },
        chuva: () => { ruido(.9, .04, 3000); },
        logo: () => { [392, 494, 587, 784, 988].forEach((f, i) => tom(f, f, .12, 'square', .03, i * .05)); }
      })[tipo]?.();
    } catch (e) {}
  }

  /* =================================================================
     CENÁRIO (480 x 270)
     ================================================================= */
  const LW = 480, LH = 270, HZ = 150;
  const [cena, g] = mk(LW, LH), [chao, q] = mk(LW, LH), [fixo, f] = mk(LW, LH);
  const R = pinta(q), B = bola(q), Rg = pinta(g), Bg = bola(g);
  // geometria compartilhada (desenho e toque)
  const kY = (y) => clamp((y - HZ) / (LH - HZ), 0, 1);
  const rioL = (y) => lerp(438, 326, kY(y)) + Math.sin(kY(y) * 3) * 8, rioR = (y) => lerp(448, 510, kY(y)) + Math.sin(kY(y) * 3) * 6;
  const noRio = (x, y) => y > HZ + 1 && x > rioL(y) && x < rioR(y);
  const trilhaC = (y) => lerp(238, 212, kY(y)) + Math.sin(kY(y) * 2.2) * 10, trilhaW = (y) => lerp(3, 36, kY(y));
  const naTrilha = (x, y) => y > HZ && Math.abs(x - trilhaC(y)) < trilhaW(y);
  const CASA = { x0: 30, x1: 128, y0: 104, y1: 192 }, CELEIRO = { x0: 284, x1: 350, y0: 126, y1: 192 }, MOINHO = { hx: 379, hy: 110, x0: 362, x1: 396, y1: 192 };
  const JANELAS = [[44, 160, 16, 14], [98, 160, 16, 14], [312, 136, 8, 7], [375, 140, 7, 8]];
  const CACAUS = [[218, 170], [240, 166], [262, 171]], ARVORE = { x: 172, y: 196, cx: 176, cy: 122 }, BALANCO = { x: 200, y: 141, L: 34 };

  function montarFixo() {
    const R = pinta(f), B = bola(f); f.clearRect(0, 0, LW, LH);
    // serras ao longe com pés de cacau e a cidade pequenininha
    for (let x = 0; x < LW; x++) { const h = Math.round(122 + Math.sin(x * .02) * 6 + Math.sin(x * .053 + 1) * 4); R(x, h, 1, HZ + 4 - h, mixc('#8fb8a0', '#7aa88a', (x % 7) / 14)); if (hash(x * 3.1) > .7) R(x, h, 1, 1, '#a8cbb4'); }
    for (const [bx, bw, bh] of [[300, 7, 10], [309, 5, 15], [316, 9, 8], [327, 6, 12], [335, 8, 9], [345, 5, 7]]) { R(bx, 141 - bh, bw, bh, '#b4c8cc'); for (let k = 2; k < bh - 1; k += 3) R(bx + 1, 141 - bh + k, bw - 2, 1, '#c8d8da'); }
    R(320, 120, 1, 6, '#b4c8cc'); R(318, 122, 5, 1, '#b4c8cc'); // igrejinha
    for (let x = 0; x < LW; x++) { const h = Math.round(136 + Math.sin(x * .031 + 2) * 6 + Math.sin(x * .07) * 3); R(x, h, 1, HZ + 6 - h, '#6aa064'); if (x % 9 === 0) B(x + 2, h + 1, 3, hash(x) > .5 ? '#4f8a4a' : '#5a944e', 2); }
    // chão com degradê e capim
    for (let y = HZ; y < LH; y++) R(0, y, LW, 1, mixc('#6aa84e', '#84c85c', kY(y)));
    for (let i = 0; i < 1800; i++) { const x = hash(i) * LW | 0, y = HZ + 2 + (hash(i + .5) * (LH - HZ - 2)) | 0; R(x, y, 1, hash(i + .7) > .75 ? 2 : 1, hash(i + .3) > .5 ? '#5a9a40' : '#9ad86e'); }
    // trilha de terra até o horizonte
    for (let y = HZ + 1; y < LH; y++) { const c = trilhaC(y), w = trilhaW(y); R(c - w - 1, y, 2 * w + 2, 1, '#b8955c'); R(c - w, y, 2 * w, 1, mixc('#d8bc84', '#e2c690', hash(y))); }
    for (let i = 0; i < 90; i++) { const y = HZ + 4 + hash(i * 2.3) * (LH - HZ - 4), c = trilhaC(y), w = trilhaW(y); R(c + (hash(i * 5.1) * 2 - 1) * w * .8, y, 2, 1, hash(i) > .5 ? '#a88a58' : '#f0dcae'); }
    // rio com margem de areia
    for (let y = HZ + 1; y < LH; y++) { const a = rioL(y), b = rioR(y); R(a - 3, y, 3, 1, '#d8c08a'); R(a, y, b - a, 1, mixc('#9ad0ec', '#3a8cc8', kY(y))); R(a, y, 1, 1, '#2a6a9a'); }
    // pontezinha de madeira
    for (let x = 0; x < 34; x++) { const y = 206 + Math.round(Math.sin(x / 33 * Math.PI) * -4); R(392 + x, y, 1, 4, x % 4 ? '#a8743e' : '#7a4a24'); }
    R(392, 202, 34, 1, '#6a3c1c'); for (const x of [393, 424]) R(x, 206, 2, 10, '#6a3c1c');
    // horta do Sapo (canteiros)
    for (let r = 0; r < 6; r++) { const y = 214 + r * 8; R(10, y, 166, 6, '#8a5a34'); R(10, y, 166, 1, '#a8744a'); R(10, y + 6, 166, 2, '#6a4024'); for (let x = 12; x < 174; x += 3) if (hash(x + r * 31) > .7) R(x, y + 2 + (x % 3), 1, 1, '#6a4024'); }
    for (let x = 18; x < 172; x += 12) { B(x, 225, 4, '#3f8a32', 3); B(x - 1, 224, 2, '#6abf4a', 2); } // couves
    for (let x = 16; x < 172; x += 9) { R(x, 236, 1, 3, '#4f9a32'); R(x + 1, 235, 1, 2, '#6abf4a'); R(x, 239, 2, 1, '#e8782a'); } // cenouras
    // cercas
    const cerca = (x0, x1, y) => { R(x0, y + 3, x1 - x0, 2, '#a8743e'); R(x0, y + 9, x1 - x0, 2, '#a8743e'); R(x0, y + 3, x1 - x0, 1, '#c8945a'); for (let x = x0; x <= x1; x += 14) { R(x, y, 3, 15, '#8a5a30'); R(x, y, 1, 15, '#b07a44'); R(x, y - 1, 3, 1, '#c8945a'); } };
    cerca(4, 200, 196); cerca(282, 358, 192);
    // mangueira atrás da casa (com mangas)
    R(10, 130, 6, 66, '#6a4426'); for (const [x, y, r] of [[4, 118, 22], [24, 110, 18], [-4, 100, 16], [18, 94, 14], [30, 126, 14]]) { B(x, y, r, '#3a6e2e'); B(x - 3, y - 3, r - 4, '#4f8a3a'); B(x - 6, y - 6, Math.max(2, r - 10), '#6aa84a'); }
    for (let i = 0; i < 9; i++) { const x = 2 + hash(i * 9) * 34, y = 96 + hash(i * 4) * 36; R(x, y, 2, 3, '#f0a030'); R(x, y, 1, 1, '#f8d040'); }
    // casa do Sapo
    const { x0, x1 } = CASA, cx = (x0 + x1) / 2;
    B(cx, 193, 52, 'rgba(0,0,0,.12)', 3);
    R(36, 150, 86, 42, '#f0dfbc'); R(110, 150, 12, 42, '#dcc8a0'); R(36, 186, 86, 6, '#b8a07a');
    for (let i = 0; i < 70; i++) R(37 + hash(i * 2.2) * 84, 151 + hash(i * 3.7) * 34, 1, 1, '#e0caa0');
    R(104, 106, 9, 22, '#a8543a'); for (let y = 108; y < 126; y += 3) R(104 + ((y / 3) % 2 ? 0 : 4), y, 4, 1, '#8a3c28'); R(102, 104, 13, 3, '#5a3a2a');
    for (let y = 118; y < 151; y++) { const k = (y - 118) / 32, hw = Math.round(lerp(38, 52, k)), row = Math.floor((y - 118) / 4); R(cx - hw, y, hw * 2, 1, row % 2 ? '#c8583a' : '#b44c32'); if ((y - 118) % 4 === 3) R(cx - hw, y, hw * 2, 1, '#8a3424'); }
    for (let y = 118; y < 150; y += 4) for (let x = -52; x < 52; x += 7) if (Math.abs(x) < lerp(38, 52, (y - 118) / 32)) R(cx + x + ((y / 4) % 2 ? 3 : 0), y, 1, 3, '#9a3c2a');
    R(cx - 38, 117, 76, 2, '#7a2c1e'); R(cx - 52, 150, 104, 2, '#5a2a1a');
    R(72, 166, 14, 26, '#7a4a28'); R(72, 166, 14, 1, '#5a3418'); for (let x = 75; x < 86; x += 4) R(x, 167, 1, 25, '#6a3c20'); R(83, 179, 2, 2, '#e8c86a');
    R(62, 156, 34, 8, '#6a3a20'); R(63, 157, 32, 6, '#8a5030');
    const mini = { D: ['11.', '1.1', '1.1', '1.1', '11.'], O: ['.1.', '1.1', '1.1', '1.1', '.1.'], S: ['.11', '1..', '.1.', '..1', '11.'], A: ['.1.', '1.1', '111', '1.1', '1.1'], P: ['11.', '1.1', '11.', '1..', '1..'] };
    let px = 66; for (const ch of 'DO SAPO') { if (ch !== ' ') mini[ch].forEach((row, y) => [...row].forEach((v, x) => { if (v === '1') R(px + x, 158 + y, 1, 1, '#f6e6b8'); })); px += ch === ' ' ? 2 : 4; }
    for (const [wx, wy, ww, wh] of JANELAS.slice(0, 2)) { R(wx - 1, wy - 1, ww + 2, wh + 2, '#f8f4ea'); R(wx, wy, ww, wh, '#5a7a9a'); for (let k = 0; k < 5; k++) R(wx + 2 + k, wy + 1 + k, 2, 1, '#8ab0c8'); R(wx + ww / 2, wy, 1, wh, '#f8f4ea'); R(wx, wy + wh / 2, ww, 1, '#f8f4ea'); R(wx - 2, wy + wh + 1, ww + 4, 3, '#8a5030'); for (let k = 0; k < ww; k += 3) R(wx + k, wy + wh, 2, 2, k % 2 ? '#e8504a' : '#f8d040'); }
    // banquinho e vasos na varanda
    R(40, 184, 14, 2, '#8a5030'); R(41, 186, 1, 4, '#6a3c20'); R(52, 186, 1, 4, '#6a3c20'); R(92, 184, 6, 6, '#b8583a'); B(95, 181, 4, '#4f9a3a', 3); R(94, 178, 2, 2, '#e8504a');
    // celeiro
    B(317, 193, 36, 'rgba(0,0,0,.12)', 3);
    for (let y = 126; y < 151; y++) { const hw = Math.round((y - 126) * 34 / 24); R(317 - hw, y, hw * 2, 1, (y % 3) ? '#7a2a24' : '#6a2420'); }
    R(286, 150, 62, 42, '#b8463a'); for (let x = 289; x < 346; x += 5) R(x, 150, 1, 42, '#9a3a30'); R(286, 150, 2, 42, '#f2ead8'); R(346, 150, 2, 42, '#f2ead8'); R(286, 150, 62, 2, '#f2ead8');
    R(302, 166, 28, 26, '#9a3a30'); R(302, 166, 28, 2, '#f2ead8'); R(302, 166, 2, 26, '#f2ead8'); R(328, 166, 2, 26, '#f2ead8'); R(315, 166, 2, 26, '#f2ead8');
    for (let k = 0; k < 13; k++) { R(304 + k, 168 + k * 2, 2, 2, '#f2ead8'); R(326 - k, 168 + k * 2, 2, 2, '#f2ead8'); }
    R(311, 135, 10, 9, '#f2ead8'); R(312, 136, 8, 7, '#3a2a20');
    for (const [bx, by] of [[348, 182], [356, 182], [352, 174]]) { R(bx, by, 9, 10, '#e8c860'); R(bx, by, 9, 1, '#f8e080'); R(bx + 3, by, 1, 10, '#c8a040'); R(bx + 6, by, 1, 10, '#c8a040'); }
    // moinho (as pás giram por cima)
    const { hx: mx } = MOINHO; B(mx, 193, 22, 'rgba(0,0,0,.12)', 3);
    for (let y = 112; y < 192; y++) { const k = (y - 112) / 80, hw = Math.round(lerp(9, 16, k)); R(mx - hw, y, hw * 2, 1, '#e8dcc4'); R(mx + hw - 5, y, 5, 1, '#cbbd9f'); if (y % 6 === 0) for (let x = -hw; x < hw; x += 6) R(mx + x + ((y / 6) % 2 ? 3 : 0), y, 1, 1, '#b8a888'); }
    for (let y = 98; y < 113; y++) { const hw = Math.round((y - 98) * 13 / 14); R(mx - hw, y, hw * 2, 1, y % 3 ? '#8a4a2a' : '#7a3c22'); }
    R(mx - 5, 178, 10, 14, '#6a4426'); R(mx - 5, 178, 10, 1, '#4a2a18'); R(375, 140, 7, 8, '#5a7a9a'); R(375, 140, 7, 1, '#f8f4ea');
    // árvore do balanço
    const A = ARVORE; R(A.x - 4, 138, 9, 58, '#6a4426'); R(A.x - 4, 138, 2, 58, '#8a5a34'); for (let y = 142; y < 196; y += 5) R(A.x + 1 + (y % 2), y, 2, 1, '#4a2e18');
    for (let x = 0; x < 30; x++) R(A.x + 4 + x, 147 - Math.round(x * .2), 1, 3, '#6a4426');
    for (const [x, y, r] of [[A.cx, A.cy, 26], [A.cx - 22, A.cy + 8, 17], [A.cx + 22, A.cy + 6, 18], [A.cx - 10, A.cy - 16, 16], [A.cx + 12, A.cy - 14, 15], [A.cx + 30, A.cy + 18, 11]]) { B(x, y, r, '#3a6e2e'); B(x - 3, y - 3, r - 4, '#4f8a3a'); B(x - 6, y - 6, Math.max(2, r - 11), '#6aa84a'); }
    for (let i = 0; i < 60; i++) R(A.cx - 40 + hash(i * 7.3) * 80, A.cy - 26 + hash(i * 1.9) * 48, 1, 1, hash(i) > .5 ? '#2f5a26' : '#86c25a');
    // pés de cacau com frutos
    for (const [x, y] of CACAUS) { R(x - 1, y - 14, 3, 14, '#5a3a22'); B(x, y - 18, 9, '#2f6a2e', 7); B(x - 2, y - 20, 6, '#3f8a3a', 4); B(x - 3, y - 22, 3, '#5aa84a', 2); for (const [dx, dy, c] of [[-3, -9, '#e8882a'], [2, -7, '#f0c030'], [-1, -4, '#c8562a']]) { R(x + dx, y + dy, 2, 4, c); R(x + dx, y + dy, 1, 1, '#ffffff55'); } }
    // florzinhas espalhadas no capim
    for (let i = 0; i < 70; i++) { const x = hash(i * 13.1) * LW, y = 200 + hash(i * 3.3) * 66; if (naTrilha(x, y) || noRio(x - 4, y) || noRio(x + 4, y) || (x < 180 && y > 210)) continue; R(x, y, 1, 2, '#4f9a32'); R(x, y - 1, 2, 1, ['#f8f4ea', '#f8d040', '#e87aa8', '#a87ae8'][i % 4]); }
  }
  // no Roblox o carregamento não pode pausar no meio de um script: o fundo fixo é montado no primeiro quadro
  if (window.DAROCA_ROBLOX) requestAnimationFrame(() => montarFixo()); else montarFixo();

  /* --- estado do mundo --- */
  let hora = (new Date().getHours() + new Date().getMinutes() / 60) / 24, horaAlvo = null; // 0 = meia-noite, .5 = meio-dia
  let pas = 0, pasVel = .55, balanco = .18, balancoV = 0, ultimo = 0, tempo = 0;
  const parts = [], plantas = [], aves = [], cadentes = [], chuvas = [], aneis = [];
  const nuvens = Array.from({ length: 6 }, (_, i) => ({ x: hash(i * 3) * LW, y: 14 + hash(i * 7) * 60, w: 18 + hash(i * 11) * 26, v: 2 + hash(i * 5) * 3 }));
  const estrelas = Array.from({ length: 70 }, (_, i) => ({ x: hash(i * 1.3) * LW, y: hash(i * 2.9) * 120, f: hash(i * 4.1) * 6 }));
  const borboletas = Array.from({ length: 4 }, (_, i) => ({ x: 60 + i * 90, y: 200 + (i % 2) * 20, f: i * 1.7, c: ['#f8d040', '#e87aa8', '#ffffff', '#7ac8f8'][i] }));
  const vagalumes = Array.from({ length: 26 }, (_, i) => ({ x: hash(i * 9.7) * LW, y: 170 + hash(i * 3.1) * 90, f: hash(i) * 6 }));
  const galinhas = [{ x: 250, y: 222, d: 1, br: true }, { x: 290, y: 236, d: -1, br: false }, { x: 330, y: 214, d: 1, br: true }].map((gal) => ({ ...gal, alvo: null, t: rnd(0, 2), z: 0, vz: 0, bica: 0, susto: 0 }));
  const sapo = { x: 344, y: 250, z: 0, vz: 0, pisca: 0, papo: 0 }, roca = { x: 192, y: 238, aceno: 0, chapeu: 0, vChapeu: 0 };
  let peixe = null, fumacaExtra = 0, luzCasa = 0, dicaUsos = 0;

  function fase() { // cores e luz do céu pela hora (com amanhecer e entardecer)
    const p = ((hora % 1) + 1) % 1, K = [[0, 'noite'], [.2, 'noite'], [.27, 'aurora'], [.35, 'dia'], [.66, 'dia'], [.74, 'tarde'], [.81, 'noite'], [1, 'noite']];
    const C = { noite: { a: '#0b1030', b: '#2a3566', n: 1, w: 0 }, aurora: { a: '#4a5a9a', b: '#f6a86a', n: .35, w: .6 }, dia: { a: '#5aa8e8', b: '#c4e8f8', n: 0, w: 0 }, tarde: { a: '#4a3a7a', b: '#f48a4a', n: .3, w: .9 } };
    let i = 0; while (i < K.length - 2 && p > K[i + 1][0]) i++; const [p0, n0] = K[i], [p1, n1] = K[i + 1], k = (p - p0) / Math.max(1e-6, p1 - p0), A = C[n0], Bc = C[n1];
    return { p, a: mixc(A.a, Bc.a, k), b: mixc(A.b, Bc.b, k), noite: lerp(A.n, Bc.n, k), quente: lerp(A.w, Bc.w, k) };
  }
  const posSol = (p) => { if (p < .22 || p > .78) return null; const u = (p - .22) / .56; return { x: 40 + u * 400, y: 140 - Math.sin(u * Math.PI) * 112 }; };
  const posLua = (p) => { const pp = p < .5 ? p + 1 : p; if (pp < .72 || pp > 1.28) return null; const u = (pp - .72) / .56; return { x: 40 + u * 400, y: 140 - Math.sin(u * Math.PI) * 104 }; };

  /* --- personagens --- */
  function galinha(c, x, y, d, bica, branca, z = 0) {
    const Rr = pinta(c), RM = (dx, dy, w, h, col) => Rr(d > 0 ? x + dx : x - dx - w + 1, y + dy - z, w, h, col);
    const corpo = branca ? '#f6f2ea' : '#b8743a', sombra = branca ? '#d8d0c4' : '#8a5228';
    Rr(x - 3, y, 7, 1, 'rgba(0,0,0,.22)');
    RM(-1, -1, 1, 1, '#e8a030'); RM(1, -1, 1, 1, '#e8a030');
    RM(-4, -6, 7, 5, corpo); RM(-3, -7, 5, 1, corpo); RM(-6, -9, 2, 4, sombra); RM(-5, -8, 1, 2, corpo); RM(-2, -5, 3, 2, sombra);
    if (bica) { RM(2, -6, 3, 3, corpo); RM(3, -7, 2, 1, '#e03a2a'); RM(5, -4, 1, 1, '#f0b030'); RM(4, -5, 1, 1, '#1c1c1c'); }
    else { RM(2, -10, 3, 4, corpo); RM(3, -11, 2, 1, '#e03a2a'); RM(5, -9, 1, 1, '#f0b030'); RM(4, -9, 1, 1, '#1c1c1c'); RM(4, -7, 1, 1, '#e03a2a'); }
  }
  function daRoca(c, o, t) {
    const Rr = pinta(c), x = Math.round(o.x), y = Math.round(o.y), resp = Math.round(Math.sin(t * 2) * .5), pele = '#c98a5a';
    Rr(x - 5, y, 11, 1, 'rgba(0,0,0,.22)');
    Rr(x - 3, y - 8, 3, 7, '#3a3a52'); Rr(x + 1, y - 8, 3, 7, '#3a3a52'); Rr(x - 3, y - 2, 3, 2, '#4a2a18'); Rr(x + 1, y - 2, 3, 2, '#4a2a18');
    Rr(x - 4, y - 17 + resp, 9, 9 - resp, '#d8783a'); Rr(x + 3, y - 17 + resp, 2, 9 - resp, '#b05a28'); Rr(x - 4, y - 9, 9, 1, '#4a2a18'); Rr(x - 6, y - 16 + resp, 2, 6, '#6a4a2a');
    Rr(x - 6, y - 15 + resp, 2, 6, '#d8783a'); Rr(x - 6, y - 9 + resp, 2, 2, pele);
    if (o.aceno > 0) { const a = Math.round(Math.sin(t * 16) * 1.5); Rr(x + 5, y - 22 + resp, 2, 7, '#d8783a'); Rr(x + 5 + a, y - 25 + resp, 2, 3, pele); } else { Rr(x + 5, y - 15 + resp, 2, 6, '#d8783a'); Rr(x + 5, y - 9 + resp, 2, 2, pele); }
    const hy = y - 23 + resp; Rr(x - 3, hy, 7, 6, pele); Rr(x + 3, hy + 1, 1, 4, '#b87a4a');
    if (Math.floor(t * 1.3) % 6 === 0 && (t * 1.3) % 1 < .15) Rr(x, hy + 2, 4, 1, '#2a1a10'); else { Rr(x, hy + 2, 1, 1, '#2a1a10'); Rr(x + 2, hy + 2, 1, 1, '#2a1a10'); }
    Rr(x, hy + 4, 3, 1, '#7a3a2a');
    const cy = hy - 1 - Math.round(o.chapeu); Rr(x - 6, cy, 13, 2, '#e8c86a'); Rr(x - 6, cy + 1, 13, 1, '#b8963a'); Rr(x - 3, cy - 4, 7, 4, '#f0d27a'); Rr(x - 3, cy - 1, 7, 1, '#8a3a2a'); Rr(x - 2, cy - 4, 2, 1, '#fff0b0');
  }
  function sapinho(c, o, t) {
    const Rr = pinta(c), x = Math.round(o.x), y = Math.round(o.y - o.z);
    Rr(x - 4, Math.round(o.y), 9, 1, 'rgba(0,0,0,.2)');
    Rr(x - 4, y - 4, 9, 4, '#4a9a3a'); Rr(x - 3, y - 5, 7, 1, '#4a9a3a'); Rr(x - 3, y - 2, 7, 2, '#a8d878'); Rr(x - 5, y - 1, 2, 1, '#3a7a2a'); Rr(x + 4, y - 1, 2, 1, '#3a7a2a');
    Rr(x - 3, y - 7, 3, 3, '#4a9a3a'); Rr(x + 1, y - 7, 3, 3, '#4a9a3a');
    if (o.pisca > 0) { Rr(x - 2, y - 6, 2, 1, '#2a5a20'); Rr(x + 2, y - 6, 2, 1, '#2a5a20'); } else { Rr(x - 2, y - 6, 2, 2, '#ffffff'); Rr(x + 2, y - 6, 2, 2, '#ffffff'); Rr(x - 1, y - 6, 1, 1, '#1c1c1c'); Rr(x + 3, y - 6, 1, 1, '#1c1c1c'); }
    if (o.papo > 0) bola(c)(x, y - 2, 2 + Math.round(o.papo * 2), '#d8f0a0', 2);
  }
  const TIPOS = ['girassol', 'milho', 'flores', 'abobora', 'cacau', 'couve', 'girassol', 'flores'];
  function planta(c, p, t) {
    const Rr = pinta(c), Bb = bola(c), x = Math.round(p.x), y = Math.round(p.y), idade = t - p.t0, fim = p.fim ? clamp(1 - (t - p.fim) / .8, 0, 1) : 1;
    if (fim <= 0) return; if (fim < 1) c.globalAlpha = fim;
    Rr(x - 3, y, 7, 2, '#7a4a28'); Rr(x - 2, y - 1, 5, 1, '#8a5a34');
    if (idade < .35) { Rr(x, y - 2, 1, 1, '#e8d8a0'); c.globalAlpha = 1; return; }
    if (idade < .9) { const s = Math.round(clamp((idade - .35) / .3, 0, 1) * 3); Rr(x, y - 1 - s, 1, s + 1, '#4f9a32'); Rr(x - 2, y - 2 - s, 2, 1, '#6abf4a'); Rr(x + 1, y - 2 - s, 2, 1, '#6abf4a'); c.globalAlpha = 1; return; }
    const pop = idade < 1.15 ? 1 + Math.sin((idade - .9) / .25 * Math.PI) * .3 : 1, h = (n) => Math.round(n * pop), bal = Math.round(Math.sin(t * 1.6 + p.x) * (idade > 1.15 ? 1 : 0));
    if (p.tipo === 'girassol') { Rr(x, y - h(18), 1, h(18), '#3f8a2a'); Rr(x - 3, y - h(9), 3, 2, '#4f9a32'); Rr(x + 1, y - h(12), 3, 2, '#4f9a32'); const hx2 = x + bal, hy = y - h(20); Bb(hx2, hy, 4, '#f8c820'); Bb(hx2, hy, 2, '#7a4a1c'); Rr(hx2 - 1, hy - 1, 1, 1, '#a8642a'); }
    else if (p.tipo === 'milho') { Rr(x, y - h(20), 2, h(20), '#4f9a32'); for (let k = 0; k < 4; k++) { const yy = y - h(5 + k * 4), dd = k % 2 ? 1 : -1; Rr(dd > 0 ? x + 2 : x - 4, yy, 4, 1, '#6abf4a'); Rr(dd > 0 ? x + 5 : x - 5, yy + 1, 1, 1, '#6abf4a'); } Rr(x + 2, y - h(13), 2, 5, '#f0c838'); Rr(x + 2, y - h(13), 1, 5, '#e0a828'); Rr(x + bal, y - h(23), 1, 3, '#e8d878'); Rr(x - 1 + bal, y - h(22), 3, 1, '#e8d878'); }
    else if (p.tipo === 'flores') { for (const [dx, hh, col] of [[-3, 6, '#e87aa8'], [0, 9, '#a87ae8'], [3, 5, '#f8f4ea']]) { Rr(x + dx, y - h(hh), 1, h(hh), '#4f9a32'); const fx = x + dx + bal, fy = y - h(hh) - 1; Rr(fx - 1, fy, 3, 1, col); Rr(fx, fy - 1, 1, 3, col); Rr(fx, fy, 1, 1, '#f8d040'); } }
    else if (p.tipo === 'abobora') { Rr(x - 6, y - 1, 12, 1, '#3f8a2a'); Bb(x - 6, y - 3, 2, '#4f9a32'); Bb(x + 6, y - 2, 2, '#4f9a32'); Bb(x, y - h(4), h(5), '#e8782a', h(4)); Rr(x - 2, y - h(8), 1, h(8), '#c85a1a'); Rr(x + 2, y - h(8), 1, h(7), '#c85a1a'); Rr(x, y - h(9), 1, 2, '#4a6a2a'); Rr(x - 3, y - h(7), 2, 1, '#f8a858'); }
    else if (p.tipo === 'cacau') { Rr(x, y - h(13), 2, h(13), '#5a3a22'); Bb(x + bal, y - h(16), h(6), '#2f6a2e', h(5)); Bb(x - 1 + bal, y - h(17), h(3), '#4f9a3a', h(3)); Rr(x - 2, y - h(9), 2, 3, '#e8882a'); Rr(x + 2, y - h(7), 2, 3, '#f0c030'); }
    else { Bb(x, y - h(3), h(5), '#3f8a32', h(3)); Bb(x - 1, y - h(4), h(3), '#6abf4a', h(2)); Rr(x, y - h(5), 1, 1, '#a8e07a'); }
    c.globalAlpha = 1;
  }

  /* --- partículas --- */
  const P = (o) => parts.push({ vx: 0, vy: 0, gr: 0, t: 0, vida: 1, tam: 1, tipo: 'px', ...o });
  function brilho(x, y, n = 8, cores = ['#fff6b0', '#ffffff', '#f8d040']) { for (let i = 0; i < n; i++) { const a = rnd(0, 6.28), v = rnd(15, 45); P({ x, y, vx: Math.cos(a) * v, vy: Math.sin(a) * v - 10, gr: 30, vida: rnd(.4, .8), cor: cores[i % cores.length], tipo: 'estrela' }); } }
  function folhas(x, y, n = 6, cores = ['#4f8a3a', '#6aa84a', '#86c25a']) { for (let i = 0; i < n; i++) P({ x: x + rnd(-14, 14), y: y + rnd(-8, 8), vx: rnd(-12, 12), vy: rnd(-6, 4), gr: 18, vida: rnd(1.4, 2.4), cor: cores[i % cores.length], tipo: 'folha', f: rnd(0, 6) }); }

  /* --- atualização --- */
  function atualizar(dt) {
    tempo += dt;
    if (horaAlvo !== null) { const d = horaAlvo - hora; const passo = Math.sign(d) * Math.min(Math.abs(d), dt * .2); hora += passo; if (Math.abs(horaAlvo - hora) < .002) { hora = horaAlvo % 1; horaAlvo = null; } }
    else hora = (hora + dt / 1200) % 1; // o dia anda devagarinho sozinho
    pas += pasVel * dt; pasVel += (.55 - pasVel) * Math.min(1, dt * .5);
    balancoV += (-balanco * 9 - balancoV * .25) * dt; balanco += balancoV * dt; if (Math.abs(balanco) < .12 && Math.abs(balancoV) < .4) balancoV += Math.sign(balancoV || 1) * .5 * dt;
    for (const n of nuvens) { n.x += n.v * dt; if (n.x - n.w > LW + 20) n.x = -n.w - 20; }
    for (const gal of galinhas) {
      gal.t -= dt; gal.bica = Math.max(0, gal.bica - dt); gal.susto = Math.max(0, gal.susto - dt);
      if (gal.z > 0 || gal.vz) { gal.vz += 300 * dt; gal.z -= gal.vz * dt; if (gal.z <= 0) { gal.z = 0; gal.vz = 0; } }
      if (gal.alvo) { const dx = gal.alvo[0] - gal.x, dy = gal.alvo[1] - gal.y, d = Math.hypot(dx, dy), v = gal.susto > 0 ? 55 : 16; if (d < 1.5) gal.alvo = null; else { gal.x += dx / d * v * dt; gal.y += dy / d * v * dt; gal.d = dx >= 0 ? 1 : -1; } }
      else if (gal.t <= 0) { gal.t = rnd(1.2, 3.5); if (Math.random() < .45) gal.bica = rnd(.6, 1.4); else gal.alvo = [clamp(gal.x + rnd(-40, 40), 196, 318), clamp(gal.y + rnd(-14, 14), 204, 252)]; }
    }
    roca.aceno = Math.max(0, roca.aceno - dt); roca.vChapeu -= 220 * dt; roca.chapeu = Math.max(0, roca.chapeu + roca.vChapeu * dt); if (roca.chapeu === 0) roca.vChapeu = 0;
    sapo.pisca = Math.max(0, sapo.pisca - dt); if (Math.random() < dt * .25) sapo.pisca = .15; sapo.papo = Math.max(0, sapo.papo - dt * 1.5); if (Math.random() < dt * .15) sapo.papo = 1;
    if (sapo.z > 0 || sapo.vz) { sapo.vz += 320 * dt; sapo.z -= sapo.vz * dt; if (sapo.z <= 0) { sapo.z = 0; sapo.vz = 0; aneis.push({ x: sapo.x + 10, y: sapo.y, r: 1, t: 0 }); } }
    if (peixe) { peixe.t += dt; if (peixe.t > .9) { aneis.push({ x: peixe.x + 14, y: peixe.y0, r: 1, t: 0 }); peixe = null; } }
    fumacaExtra = Math.max(0, fumacaExtra - dt); luzCasa = Math.max(0, luzCasa - dt);
    if (Math.random() < dt * (fumacaExtra > 0 ? 14 : 1.6)) P({ x: 108 + rnd(-1, 1), y: 104, vx: rnd(2, 6), vy: -rnd(8, 14), vida: rnd(2, 3), cor: '#f2f2ee', tipo: 'fumaca' });
    for (const a of aves) a.x += a.v * dt; for (let i = aves.length - 1; i >= 0; i--) if (aves[i].x > LW + 60 || aves[i].x < -80) aves.splice(i, 1);
    const fz = fase(); if (fz.noite < .5 && Math.random() < dt * .05) aves.push({ x: -40, y: rnd(20, 80), v: rnd(26, 40), n: 3 + (Math.random() * 3 | 0), f: rnd(0, 6) });
    if (fz.noite > .7 && Math.random() < dt * .04) cadentes.push({ x: rnd(80, 420), y: rnd(10, 40), vx: rnd(-140, -90), vy: rnd(40, 70), t: 0 });
    for (const s of cadentes) { s.t += dt; s.x += s.vx * dt; s.y += s.vy * dt; } for (let i = cadentes.length - 1; i >= 0; i--) if (cadentes[i].t > 1.1) cadentes.splice(i, 1);
    for (const ch of chuvas) { ch.t += dt; if (ch.t < 2.2) for (let k = 0; k < 3; k++) P({ x: ch.x + rnd(-ch.w, ch.w), y: ch.y + 4, vy: rnd(120, 160), vx: -6, vida: 1.2, cor: '#8ac8f0', tipo: 'gota', chao: rnd(170, 262) }); }
    for (let i = chuvas.length - 1; i >= 0; i--) if (chuvas[i].t > 2.4) chuvas.splice(i, 1);
    for (const a of aneis) { a.t += dt; a.r += dt * 14; } for (let i = aneis.length - 1; i >= 0; i--) if (aneis[i].t > .9) aneis.splice(i, 1);
    for (const p of parts) { p.t += dt; p.vy += p.gr * dt; p.x += p.vx * dt; p.y += p.vy * dt; if (p.tipo === 'folha') { p.vx = Math.sin(p.t * 3 + p.f) * 14; p.vy = Math.min(p.vy, 14); } if (p.tipo === 'gota' && p.y > p.chao) { p.t = p.vida; aneis.push({ x: p.x, y: p.y, r: .5, t: .55, chuva: true }); for (const pl of plantas) if (Math.abs(pl.x - p.x) < 8 && Math.abs(pl.y - p.y) < 8) pl.t0 = Math.min(pl.t0, tempo - 1.2); } }
    for (let i = parts.length - 1; i >= 0; i--) if (parts[i].t >= parts[i].vida) parts.splice(i, 1);
    for (let i = plantas.length - 1; i >= 0; i--) if (plantas[i].fim && tempo - plantas[i].fim > .8) plantas.splice(i, 1);
  }

  /* --- desenho --- */
  function desenharCena() {
    const fz = fase(), t = tempo;
    for (let y = 0; y < HZ + 6; y += 2) Rg(0, y, LW, 2, mixc(fz.a, fz.b, y / (HZ + 6)));
    if (fz.noite > .05) for (const s of estrelas) { const a = fz.noite * (.4 + .6 * Math.abs(Math.sin(t * 1.3 + s.f))); g.globalAlpha = a; Rg(s.x, s.y, 1, 1, '#fffbe0'); if (s.f > 5.2) { Rg(s.x - 1, s.y, 3, 1, '#fffbe0'); Rg(s.x, s.y - 1, 1, 3, '#fffbe0'); } } g.globalAlpha = 1;
    const sol = posSol(fz.p), lua = posLua(fz.p);
    if (sol) { g.globalAlpha = .25; Bg(sol.x, sol.y, 20, '#fff2a0'); g.globalAlpha = 1; for (let k = 0; k < 8; k++) { const a = t * .4 + k * .785; for (let j = 14; j < 19; j++) Rg(sol.x + Math.cos(a) * j, sol.y + Math.sin(a) * j, 1, 1, '#fff2a0'); } Bg(sol.x, sol.y, 11, '#ffd23a'); Bg(sol.x - 2, sol.y - 2, 7, '#ffe88a'); Rg(sol.x - 5, sol.y - 6, 3, 2, '#fffbe0'); }
    if (lua) { g.globalAlpha = .18; Bg(lua.x, lua.y, 18, '#e8f0ff'); g.globalAlpha = 1; Bg(lua.x, lua.y, 9, '#f4f2e0'); Bg(lua.x + 4, lua.y - 3, 8, fz.a); Rg(lua.x - 5, lua.y + 1, 2, 2, '#d8d6c4'); Rg(lua.x - 3, lua.y + 4, 1, 1, '#d8d6c4'); }
    for (const s of cadentes) { for (let k = 0; k < 14; k++) { g.globalAlpha = (1 - k / 14) * (1 - s.t / 1.1); Rg(s.x - s.vx * k * .008, s.y - s.vy * k * .008, 2, 1, '#fffbe0'); } } g.globalAlpha = 1;
    const corN = mixc('#ffffff', '#4a4a7a', fz.noite * .8), corNs = mixc('#d8e8f4', '#2a2a52', fz.noite * .8);
    for (const n of nuvens) { const cx = n.x, cy = n.y, w = n.w; Bg(cx, cy + 3, w, corNs, 6); Bg(cx - w * .4, cy, w * .45, corN, 6); Bg(cx + w * .1, cy - 3, w * .5, corN, 8); Bg(cx + w * .5, cy + 1, w * .35, corN, 5); Rg(cx - w, cy + 6, w * 2, 3, corNs); }
    for (const a of aves) for (let i = 0; i < a.n; i++) { const lado = i % 2 ? 1 : -1, k = Math.ceil(i / 2), bx = a.x - k * 7, by = a.y + lado * k * 4 + Math.sin(t * 2 + a.f) * 3, asa = Math.sin(t * 12 + i + a.f) > 0; Rg(bx - 3, by - (asa ? 2 : 0), 2, 1, '#2a2a3a'); Rg(bx - 1, by, 2, 1, '#2a2a3a'); Rg(bx + 1, by - (asa ? 2 : 0), 2, 1, '#2a2a3a'); }

    // tudo que fica no chão (vai escurecer junto à noite)
    q.clearRect(0, 0, LW, LH); q.drawImage(fixo, 0, 0);
    for (let i = 0; i < 26; i++) { const y = HZ + 6 + (i * 37) % (LH - HZ - 8), ph = (t * .5 + hash(i) * 4) % 1, x0 = rioL(y), x1 = rioR(y), x = x0 + 3 + ((hash(i * 3) + ph * .3) % 1) * Math.max(1, x1 - x0 - 8); q.globalAlpha = Math.sin(ph * Math.PI) * .7; R(x, y + ph * 4, 3 + kY(y) * 4, 1, '#e2f6ff'); } q.globalAlpha = 1;
    for (const a of aneis) { q.globalAlpha = Math.max(0, 1 - a.t / .9); q.strokeStyle = a.chuva ? '#cfe8ff' : '#e8f8ff'; q.lineWidth = 1; q.beginPath(); q.ellipse(a.x, a.y, a.r * 1.6, a.r * .6, 0, 0, Math.PI * 2); q.stroke(); } q.globalAlpha = 1;
    if (peixe) { const u = peixe.t / .9, x = peixe.x + u * 28, y = peixe.y0 - Math.sin(u * Math.PI) * 22, ang = Math.cos(u * Math.PI); R(x - 3, y - 1, 7, 3, '#f08a3a'); R(x - 3, y - 1, 7, 1, '#f8b060'); R(x + (ang > 0 ? 3 : -5), y - 1 + Math.round(ang), 2, 3, '#d86a2a'); R(x + 2, y - 1, 1, 1, '#1c1c1c'); }
    // pás do moinho
    const { hx: mx, hy: my } = MOINHO;
    for (let b = 0; b < 4; b++) { const a = pas + b * Math.PI / 2, ca = Math.cos(a), sa = Math.sin(a); for (let j = 4; j < 36; j++) { const x = mx + ca * j, y = my + sa * j; R(x, y, 2, 2, '#6a4a30'); if (j > 9) for (let w = 2; w < 8; w++) R(x - sa * w, y + ca * w, 1, 1, (j + w) % 4 === 0 ? '#a88a6a' : '#f2e8d0'); } }
    B(mx, my, 3, '#4a3020'); R(mx - 1, my - 1, 2, 2, '#8a6a4a');
    // balanço na árvore
    const sx = BALANCO.x + Math.sin(balanco) * BALANCO.L, sy = BALANCO.y + Math.cos(balanco) * BALANCO.L;
    q.strokeStyle = '#d8c8a0'; q.lineWidth = 1; for (const o of [-4, 4]) { q.beginPath(); q.moveTo(BALANCO.x + o, BALANCO.y); q.lineTo(sx + o, sy); q.stroke(); } R(sx - 6, sy, 13, 2, '#8a5030'); R(sx - 6, sy, 13, 1, '#b07a44');
    // atores do chão, por profundidade
    const atores = [...galinhas.map((o) => ({ y: o.y, f: () => galinha(q, Math.round(o.x), Math.round(o.y), o.d, o.bica > 0, o.br, Math.round(o.z)) })), { y: roca.y, f: () => daRoca(q, roca, t) }, { y: sapo.y, f: () => sapinho(q, sapo, t) }, ...plantas.map((p) => ({ y: p.y, f: () => planta(q, p, t) }))];
    atores.sort((a, b) => a.y - b.y); for (const a of atores) a.f();
    if (fz.noite < .6) for (const b of borboletas) { const bt = t + b.f, x = b.x + Math.sin(bt * .6) * 30, y = b.y + Math.sin(bt * 1.3) * 10 - 10, ab = Math.sin(bt * 14) > 0; R(x - (ab ? 2 : 1), y, ab ? 2 : 1, 2, b.c); R(x + 1, y, ab ? 2 : 1, 2, b.c); R(x, y, 1, 2, '#2a1a10'); }
    for (const p of parts) { const k = 1 - p.t / p.vida; if (p.tipo === 'fumaca') { q.globalAlpha = k * .55; B(p.x, p.y, 1.5 + (1 - k) * 4, p.cor); } else if (p.tipo === 'folha') { q.globalAlpha = Math.min(1, k * 3); R(p.x, p.y, 2, 1, p.cor); R(p.x + (Math.sin(p.t * 6) > 0 ? 1 : 0), p.y - 1, 1, 1, p.cor); } else if (p.tipo === 'gota') { q.globalAlpha = .8; R(p.x, p.y, 1, 3, p.cor); } else if (p.tipo === 'pena') { q.globalAlpha = k; R(p.x, p.y, 2, 1, p.cor); } else if (p.tipo === 'coracao') { q.globalAlpha = k; R(p.x - 2, p.y, 2, 1, '#e84a6a'); R(p.x + 1, p.y, 2, 1, '#e84a6a'); R(p.x - 2, p.y + 1, 5, 1, '#e84a6a'); R(p.x - 1, p.y + 2, 3, 1, '#e84a6a'); R(p.x, p.y + 3, 1, 1, '#e84a6a'); } else if (p.tipo === 'pod') { q.globalAlpha = 1; R(p.x - 1, p.y - 2, 3, 4, p.cor); R(p.x - 1, p.y - 2, 1, 1, '#ffffff66'); } q.globalAlpha = 1; }
    // noite e entardecer escurecem/esquentam só o que está no chão
    q.globalCompositeOperation = 'source-atop';
    if (fz.noite > 0) { q.fillStyle = `rgba(10,14,44,${fz.noite * .58})`; q.fillRect(0, 0, LW, LH); }
    if (fz.quente > 0) { q.fillStyle = `rgba(255,128,48,${fz.quente * .14})`; q.fillRect(0, 0, LW, LH); }
    q.globalCompositeOperation = 'source-over';
    g.drawImage(chao, 0, 0);
    // luzes (janelas, lampião, vaga-lumes) por cima, somando luz
    const luz = Math.max(fz.noite, luzCasa > 0 ? .8 : 0);
    if (luz > .05) { g.globalCompositeOperation = 'lighter';
      const halo = (x, y, r, a) => { const gr = g.createRadialGradient(x, y, 0, x, y, r); gr.addColorStop(0, `rgba(255,170,60,${a})`); gr.addColorStop(1, 'rgba(255,170,60,0)'); g.fillStyle = gr; g.fillRect(x - r, y - r, r * 2, r * 2); };
      for (const [wx, wy, ww, wh] of JANELAS) { g.globalAlpha = luz * .85; Rg(wx, wy, ww, wh, '#c87a20'); g.globalAlpha = 1; halo(wx + ww / 2, wy + wh / 2, ww + 8, .28 * luz); }
      halo(348, 160, 12, .4 * luz); g.globalAlpha = luz; Rg(347, 158, 2, 3, '#ffd080');
      if (fz.noite > .3) for (const v of vagalumes) { const a = Math.max(0, Math.sin(t * 2 + v.f)) * fz.noite; g.globalAlpha = a; Rg(v.x + Math.sin(t * .7 + v.f) * 10, v.y + Math.cos(t * .5 + v.f) * 6, 1, 1, '#e8ff80'); g.globalAlpha = a * .3; Bg(v.x + Math.sin(t * .7 + v.f) * 10, v.y + Math.cos(t * .5 + v.f) * 6, 3, '#c8ff60'); }
      g.globalAlpha = 1; g.globalCompositeOperation = 'source-over'; }
    for (const p of parts) if (p.tipo === 'estrela') { const k = 1 - p.t / p.vida; g.globalAlpha = k; Rg(p.x, p.y, 1, 1, p.cor); if (k > .5) { Rg(p.x - 1, p.y, 3, 1, p.cor); Rg(p.x, p.y - 1, 1, 3, p.cor); } } g.globalAlpha = 1;
  }

  /* --- toques no cenário --- */
  function tocar(x, y) {
    dicaUsos++; if (dicaUsos >= 3) dica?.classList.add('some');
    const fz = fase(), t = tempo;
    for (const gal of galinhas) if (Math.abs(gal.x - x) < 8 && y > gal.y - 14 - gal.z && y < gal.y + 3) { gal.vz = -110; gal.z = .1; gal.susto = 1.6; gal.alvo = [clamp(gal.x + (gal.x > x ? 1 : -1) * rnd(30, 60), 196, 318), clamp(gal.y + rnd(-14, 14), 204, 252)]; for (let i = 0; i < 6; i++) P({ x: gal.x, y: gal.y - 8, vx: rnd(-30, 30), vy: rnd(-50, -20), gr: 40, vida: rnd(.8, 1.4), cor: gal.br ? '#ffffff' : '#c8844a', tipo: 'pena' }); som('galinha'); return; }
    if (Math.abs(roca.x - x) < 8 && y > roca.y - 30 && y < roca.y + 2) { roca.aceno = 1.6; roca.vChapeu = 70; P({ x: roca.x + 6, y: roca.y - 32, vy: -14, vida: 1.2, tipo: 'coracao' }); som('oi'); return; }
    if (Math.abs(sapo.x - x) < 9 && Math.abs(sapo.y - 3 - y) < 8 && sapo.z === 0) { sapo.vz = -120; sapo.z = .1; sapo.papo = 1; som('sapo'); return; }
    for (const p of plantas) if (!p.fim && Math.abs(p.x - x) < 5 && y < p.y + 2 && y > p.y - 24) { brilho(p.x, p.y - 12, 6); if (tempo - p.t0 > 1.2) p.fim = tempo; som('pop'); return; }
    const sx = BALANCO.x + Math.sin(balanco) * BALANCO.L, sy = BALANCO.y + Math.cos(balanco) * BALANCO.L; if (Math.abs(x - sx) < 10 && Math.abs(y - sy) < 8) { balancoV += (balancoV >= 0 ? 1 : -1) * 3.2; som('vento'); return; }
    const sol = posSol(fz.p), lua = posLua(fz.p), astro = sol || lua;
    if (astro && Math.hypot(x - astro.x, y - astro.y) < 18) { const p = fz.p, alvos = [.45, .74, .9, 1.27]; let alvo = alvos.find((a) => a > p + .02) ?? 1.45; horaAlvo = alvo; hora = p; brilho(astro.x, astro.y, 12); som('dia'); return; }
    for (const n of nuvens) if (Math.abs(x - n.x) < n.w + 4 && Math.abs(y - n.y) < 9) { chuvas.push({ x: n.x, y: n.y, w: n.w * .8, t: 0 }); som('chuva'); return; }
    const { hx: mx, hy: my } = MOINHO; if (Math.hypot(x - mx, y - my) < 38 || (x > MOINHO.x0 && x < MOINHO.x1 && y > 98 && y < 192)) { pasVel = 7; folhas(mx, my, 6, ['#f2e8d0', '#e8dcc4', '#c8b898']); som('vento'); return; }
    if (x > CASA.x0 && x < CASA.x1 && y > CASA.y0 && y < CASA.y1) { fumacaExtra = 1.4; luzCasa = 3; brilho(108, 106, 6, ['#ffffff', '#f2f2ee']); som('pop'); return; }
    if (x > CELEIRO.x0 && x < CELEIRO.x1 && y > CELEIRO.y0 && y < CELEIRO.y1) { for (let i = 0; i < 10; i++) P({ x: 316 + rnd(-10, 10), y: 150, vx: rnd(-30, 30), vy: rnd(-50, -20), gr: 50, vida: rnd(.8, 1.4), cor: i % 2 ? '#e8c860' : '#f8e080', tipo: 'pena' }); som('pop'); return; }
    for (const [cxx, cyy] of CACAUS) if (Math.abs(x - cxx) < 10 && y > cyy - 28 && y < cyy) { P({ x: cxx + rnd(-3, 3), y: cyy - 8, vx: rnd(-20, 20), vy: -30, gr: 260, vida: 1.2, cor: Math.random() < .5 ? '#e8882a' : '#f0c030', tipo: 'pod' }); folhas(cxx, cyy - 18, 4); som('pop'); return; }
    if (Math.hypot(x - ARVORE.cx, y - ARVORE.cy) < 34 || (x > 2 && x < 40 && y > 86 && y < 140)) { folhas(x, y, 9); balancoV += 1; som('vento'); return; }
    if (noRio(x, y)) { peixe = { x: x - 14, y0: y, t: 0 }; aneis.push({ x, y, r: 1, t: 0 }); for (let i = 0; i < 8; i++) P({ x, y, vx: rnd(-30, 30), vy: rnd(-70, -30), gr: 200, vida: .6, cor: '#cfeaff', tipo: 'gota', chao: y + 2 }); som('agua'); return; }
    if (y < HZ - 4) { if (fz.noite > .5) { cadentes.push({ x, y, vx: -120, vy: 55, t: 0 }); brilho(x, y, 6); som('estrela'); } else { aves.push({ x: x - 60, y, v: 46, n: 5, f: rnd(0, 6) }); brilho(x, y, 4); som('pop'); } return; }
    if (naTrilha(x, y)) { for (let i = 0; i < 6; i++) P({ x, y, vx: rnd(-20, 20), vy: rnd(-20, -6), gr: 60, vida: .5, cor: '#e2c690', tipo: 'pena' }); return; }
    if (y > HZ + 24) { if (plantas.filter((p) => !p.fim).length >= 24) { const velha = plantas.find((p) => !p.fim); if (velha) velha.fim = tempo; } plantas.push({ x, y, tipo: TIPOS[(Math.random() * TIPOS.length) | 0], t0: tempo }); brilho(x, y - 2, 5, ['#e8d8a0', '#8ad05a', '#ffffff']); som('planta'); }
  }

  /* =================================================================
     LOGO (340 x 168)
     ================================================================= */
  const GL = {
    D: ['#######...', '########..', '###..####.', '###...###.', '###....###', '###....###', '###....###', '###....###', '###...###.', '###..####.', '########..', '#######...'],
    A: ['...####...', '..######..', '.###..###.', '.###..###.', '###....###', '###....###', '##########', '##########', '###....###', '###....###', '###....###', '###....###'],
    R: ['#######...', '########..', '###...###.', '###...###.', '###...###.', '########..', '#######...', '###.###...', '###..###..', '###...###.', '###...###.', '###....###'],
    O: ['..######..', '.########.', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '.########.', '..######..'],
    Ç: ['..#######.', '.#########', '###.....##', '###.......', '###.......', '###.......', '###.......', '###.......', '###.......', '###.....##', '.#########', '..#######.', '.....##...', '......##..', '....###...'],
    V: ['###....###', '###....###', '###....###', '###....###', '###....###', '.###..###.', '.###..###.', '.###..###.', '..######..', '..######..', '...####...', '....##....'],
    E: ['##########', '##########', '###.......', '###.......', '###.......', '########..', '########..', '###.......', '###.......', '###.......', '##########', '##########'],
    N: ['###....###', '####...###', '#####..###', '######.###', '###.######', '###..#####', '###...####', '###....###', '###....###', '###....###', '###....###', '###....###'],
    T: ['##########', '##########', '...####...', '...####...', '...####...', '...####...', '...####...', '...####...', '...####...', '...####...', '...####...', '...####...'],
    U: ['###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '###....###', '####..####', '.########.', '..######..']
  };
  // monta uma letra estilizada: contorno, relevo para baixo, degradê, brilho em cima e sombra embaixo
  function letra(ch, s, E) {
    const gl = GL[ch], gw = 10 * s, gh = gl.length * s, alt12 = 12 * s, pad = E.borda, W = gw + pad * 2, H = gh + pad * 2 + E.ext;
    const m = new Uint8Array(W * H), at = (x, y) => (x >= 0 && y >= 0 && x < W && y < H ? m[y * W + x] : 0);
    gl.forEach((row, y) => [...row].forEach((v, x) => { if (v === '#') for (let a = 0; a < s; a++) for (let b = 0; b < s; b++) m[(pad + y * s + a) * W + pad + x * s + b] = 1; }));
    const ext = new Uint8Array(W * H); for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) if (!m[y * W + x]) for (let k = 1; k <= E.ext; k++) if (at(x, y - k) === 1) { ext[y * W + x] = k; break; }
    const [cv, c] = mk(W, H), Rr = pinta(c);
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { if (m[y * W + x] || ext[y * W + x]) continue; let perto = false; for (let dy = -pad; dy <= pad && !perto; dy++) for (let dx = -pad; dx <= pad; dx++) { if (Math.abs(dx) + Math.abs(dy) > pad + (pad > 1 ? 1 : 0)) continue; const xx = x + dx, yy = y + dy; if (xx >= 0 && yy >= 0 && xx < W && yy < H && (m[yy * W + xx] || ext[yy * W + xx])) { perto = true; break; } } if (perto) Rr(x, y, 1, 1, E.contorno); }
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { const k = ext[y * W + x]; if (k) Rr(x, y, 1, 1, k >= E.ext ? E.extFundo : E.extCor); }
    for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { if (!m[y * W + x]) continue; const ry = clamp((y - pad) / alt12, 0, 1); let i = 0; while (i < E.grad.length - 1 && ry > E.grad[i + 1][0]) i++; const [a0, c0] = E.grad[i], [a1, c1] = E.grad[Math.min(i + 1, E.grad.length - 1)], kk = a1 > a0 ? (ry - a0) / (a1 - a0) : 0; let col = (kk > .5) !== ((x + y) % 2 === 0 && Math.abs(kk - .5) < .2) ? c1 : c0;
      if (!at(x, y - 1)) col = E.luz; else if (!at(x, y + 1)) col = E.fundo; else if (!at(x - 1, y)) col = mixc(col, '#ffffff', .25); else if (E.textura && hash(x * 7.1 + y * 3.3) > .92) col = mixc(col, '#ffffff', .3); Rr(x, y, 1, 1, col); }
    return { cv, w: W, h: H, pad };
  }
  const ESTILO_G = { borda: 2, ext: 4, contorno: '#2a1408', extCor: '#8a4a1c', extFundo: '#5a2c10', grad: [[0, '#fff8dc'], [.25, '#ffe48a'], [.6, '#f6b840'], [1, '#d8802a']], luz: '#ffffff', fundo: '#b8641e', textura: true };
  const ESTILO_P = { borda: 1, ext: 2, contorno: '#1a3410', extCor: '#2a5a1c', extFundo: '#1a3410', grad: [[0, '#fffbe8'], [.6, '#fff0c8'], [1, '#f0d8a0']], luz: '#ffffff', fundo: '#d8bc84', textura: false };
  // letras do logo: no navegador saem todas na hora; no Roblox uma por quadro (montar tudo no carregamento passava de 10 s)
  const TEXTO_G = [...'DA ROÇA'], TEXTO_P = [...'ADVENTURE'], BIG = [], SMALL = [];
  function montarLetras(max) {
    let feitas = 0;
    while (BIG.length < TEXTO_G.length && feitas < max) { const ch = TEXTO_G[BIG.length]; BIG.push(ch === ' ' ? null : letra(ch, 3, ESTILO_G)); feitas++; }
    while (SMALL.length < TEXTO_P.length && feitas < max) { SMALL.push(letra(TEXTO_P[SMALL.length], 1, ESTILO_P)); feitas++; }
    return BIG.length === TEXTO_G.length && SMALL.length === TEXTO_P.length;
  }
  if (!window.DAROCA_ROBLOX) montarLetras(99);
  const LOGW = 340, LOGH = 168, [logoCv, lc] = mk(LOGW, LOGH), [letrasCv, lt] = mk(LOGW, LOGH), [placaCv, pc] = mk(LOGW, LOGH);
  logoCv.className = 'tr-logo'; logoCv.setAttribute('role', 'img'); logoCv.setAttribute('aria-label', 'Da Roça Adventure');
  const L = pinta(lc), LB = bola(lc);
  function montarPlaca() { // tábuas da placa (fixas), desenhadas uma vez
    const R = pinta(pc); pc.clearRect(0, 0, LOGW, LOGH);
    const x0 = 22, x1 = 318, y0 = 24, y1 = 100, cores = ['#b47442', '#a46838', '#ba7c48'];
    R(x0 + 3, y1 + 1, x1 - x0, 4, 'rgba(40,20,8,.35)');
    R(x0, y0 + 2, x1 - x0, y1 - y0 - 4, '#2a1408'); R(x0 + 2, y0, x1 - x0 - 4, y1 - y0, '#2a1408'); R(x0 + 1, y0 + 1, x1 - x0 - 2, y1 - y0 - 2, '#2a1408');
    for (let p = 0; p < 3; p++) { const py = y0 + 2 + p * 25, ph = 24, base = cores[p];
      R(x0 + 2, py, x1 - x0 - 4, ph, base); R(x0 + 2, py, x1 - x0 - 4, 2, mixc(base, '#ffe0a8', .45)); R(x0 + 2, py + ph - 2, x1 - x0 - 4, 2, mixc(base, '#3a1a08', .35));
      for (let gy = 4; gy < ph - 3; gy += 3) for (let x = x0 + 3; x < x1 - 3; x++) { const v = Math.sin(x * .05 + gy * 1.7 + p * 3) * 1.2; if (hash(x * .37 + gy * 11 + p * 101) > .55) R(x, py + gy + Math.round(v), 1, 1, mixc(base, '#5a2c10', .22)); }
      for (let k = 0; k < 2; k++) { const kx = x0 + 40 + hash(p * 7 + k) * (x1 - x0 - 80), ky = py + 8 + hash(p * 3 + k) * 8; pc.strokeStyle = mixc(base, '#4a2008', .4); pc.lineWidth = 1; pc.beginPath(); pc.ellipse(kx, ky, 5, 2.5, 0, 0, Math.PI * 2); pc.stroke(); R(kx - 1, ky, 3, 1, mixc(base, '#4a2008', .5)); }
      if (p < 2) R(x0 + 2, py + ph, x1 - x0 - 4, 1, '#3a1a08');
      for (const nx of [x0 + 7, x1 - 10]) { R(nx, py + 10, 3, 3, '#5a5450'); R(nx, py + 10, 2, 2, '#d8d0c8'); R(nx, py + 10, 1, 1, '#ffffff'); } }
    // placa pequena de cima: UMA AVENTURA CULTIVADA EM ITABUNA
    pc.font = '8px Pixel, monospace'; const tx = 'UMA AVENTURA CULTIVADA EM ITABUNA', tw = Math.ceil(pc.measureText(tx).width), bx = Math.round((LOGW - tw) / 2) - 8;
    for (const cx of [bx + 18, bx + tw - 2]) { R(cx, 13, 1, 11, '#5a5450'); R(cx + 1, 15, 1, 2, '#8a8480'); R(cx + 1, 19, 1, 2, '#8a8480'); }
    R(bx - 1, 1, tw + 18, 14, '#2a1408'); R(bx, 2, tw + 16, 12, '#f6e6bc'); R(bx, 2, tw + 16, 1, '#fffaf0'); R(bx, 12, tw + 16, 2, '#d8c08a');
    pc.fillStyle = '#5a3418'; pc.textBaseline = 'top'; pc.fillText(tx, bx + 8, 4);
    // limpa o serrilhado do texto da fonte (deixa pixel puro)
    const d = pc.getImageData(bx, 2, tw + 16, 12); for (let i = 3; i < d.data.length; i += 4) if (d.data[i] > 0 && d.data[i] < 255) { if (d.data[i] > 110) d.data[i] = 255; } pc.putImageData(d, bx, 2);
  }
  if (window.DAROCA_ROBLOX) requestAnimationFrame(() => montarPlaca()); else montarPlaca();
  if (!window.DAROCA_ROBLOX) document.fonts?.load?.('8px Pixel').then(montarPlaca).catch(() => {}); // no Roblox a promessa resolve na hora e redesenhava a placa no carregamento
  let logo0 = null, onda = 0;
  const easeBounce = (u) => { if (u < 1 / 2.75) return 7.5625 * u * u; if (u < 2 / 2.75) return 7.5625 * (u -= 1.5 / 2.75) * u + .75; if (u < 2.5 / 2.75) return 7.5625 * (u -= 2.25 / 2.75) * u + .9375; return 7.5625 * (u -= 2.625 / 2.75) * u + .984375; };
  const easeBack = (u) => { const c1 = 1.70158, c3 = c1 + 1; return 1 + c3 * Math.pow(u - 1, 3) + c1 * Math.pow(u - 1, 2); };
  function desenharLogo(t) {
    if (!montarLetras(3)) return; // Roblox: o logo aparece quando as letras ficam prontas (3 por quadro)
    if (logo0 === null) logo0 = t; const e = reduzido ? 9 : t - logo0; onda = Math.max(0, onda - 1 / 60 * 1.2);
    lc.clearRect(0, 0, LOGW, LOGH);
    const placaY = Math.round((1 - easeBack(clamp(e / .45, 0, 1))) * -140); const flut = e > 2 ? Math.round(Math.sin(t * 1.4) * 1) : 0;
    // milho cruzado atrás da ponta esquerda
    const deco = clamp((e - 1.1) / .3, 0, 1);
    if (deco > 0) { lc.globalAlpha = deco;
      const espiga = (x, y, inc) => { for (let r = 0; r < 22; r++) { const cx2 = Math.round(x + r * inc), w = r < 3 ? r + 1 : r > 18 ? 22 - r : 4; L(cx2 - w - 1, y + r, w * 2 + 3, 1, '#2a1408'); for (let k = -w; k <= w; k++) L(cx2 + k, y + r, 1, 1, (k + r) % 2 ? '#f8d040' : (k < -w + 2 ? '#c88a18' : '#e8b020')); L(cx2 - w + 1, y + r, 1, 1, '#fff0a0'); }
        for (let k = 0; k < 16; k++) { const cx2 = Math.round(x + (16 + k) * inc); L(cx2 - 6 - Math.round(k * .5), y + 15 + k, 4, 1, k % 3 ? '#5aa83a' : '#3f8a2a'); L(cx2 + 3 + Math.round(k * .5), y + 15 + k, 4, 1, k % 3 ? '#4f9a32' : '#3f8a2a'); L(cx2 - 1, y + 18 + k, 3, 1, '#6abf4a'); } L(Math.round(x) - 1, y - 3, 1, 3, '#e8d878'); L(Math.round(x) + 1, y - 4, 1, 4, '#d8c060'); };
      espiga(9, 40 + placaY + flut, -.2); espiga(19, 47 + placaY + flut, .15);
      // girassol na ponta direita (balança)
      const sw = Math.round(Math.sin(t * 1.2) * 1.5); for (let k = 0; k < 70; k++) L(326 + Math.round(Math.sin(k * .05) * 1), 112 - k + placaY + flut, 2, 1, '#3f8a2a');
      L(318, 82 + placaY + flut, 8, 3, '#4f9a32'); L(328, 70 + placaY + flut, 8, 3, '#4f9a32');
      const hx2 = 327 + sw, hy = 38 + placaY + flut; for (let k = 0; k < 12; k++) { const a = k * .5236 + t * .2; LB(hx2 + Math.cos(a) * 9, hy + Math.sin(a) * 9, 3, k % 2 ? '#f8c820' : '#ffd84a', 3); } LB(hx2, hy, 7, '#2a1408'); LB(hx2, hy, 6, '#7a4a1c'); for (let k = 0; k < 10; k++) L(hx2 - 4 + hash(k) * 8, hy - 4 + hash(k * 3) * 8, 1, 1, '#a86a2a');
      lc.globalAlpha = 1; }
    lc.drawImage(placaCv, 0, placaY + flut);
    // trepadeira com folhas e flores por cima da placa
    if (e > .5) for (let x = 24; x < 316; x += 2) { const y = 24 + Math.round(Math.sin(x * .12) * 1.6) + placaY + flut; L(x, y, 2, 2, '#3f7a2a'); if (x % 12 === 0) { const sw = Math.round(Math.sin(t * 2 + x) * 1); L(x - 2 + sw, y - 3, 3, 2, '#5aa83a'); L(x - 1 + sw, y - 3, 1, 1, '#8ad05a'); } if (x % 12 === 6) { L(x + 1, y + 2, 3, 2, '#4f9a32'); } if (x % 36 === 18) { const fc = ['#f07aa8', '#f8d84a', '#ffffff'][(x / 36 | 0) % 3]; L(x - 1, y - 4, 3, 1, fc); L(x, y - 5, 1, 3, fc); L(x, y - 4, 1, 1, '#f8a020'); } }
    // cacau pendurado embaixo à esquerda
    if (deco > 0) { lc.globalAlpha = deco; L(56, 100 + placaY + flut, 1, 6, '#5a3a22'); L(54, 105 + placaY + flut, 5, 8, '#2a1408'); L(55, 106 + placaY + flut, 3, 6, '#e8882a'); L(55, 106 + placaY + flut, 1, 2, '#f8b860'); L(60, 102 + placaY + flut, 4, 7, '#2a1408'); L(61, 103 + placaY + flut, 2, 5, '#f0c030'); lc.globalAlpha = 1; }
    // letras grandes: caem uma a uma e depois balançam de leve
    lt.clearRect(0, 0, LOGW, LOGH); let total = 0; for (const b of BIG) total += b ? b.w - 2 : 12; let x = Math.round((LOGW - total) / 2), i = 0;
    for (const b of BIG) { if (!b) { x += 12; continue; } const t0 = .35 + i * .08, u = clamp((e - t0) / .55, 0, 1); if (u > 0) { const queda = Math.round((1 - easeBounce(u)) * -90), bob = e > 2 ? Math.round(Math.sin(t * 2.2 + i * .7) * .8 + Math.sin(t * 9 - i * .9) * onda * 6) : 0; lt.drawImage(b.cv, x, 30 + queda + bob + placaY + flut); } x += b.w - 2; i++; }
    // brilho que passa pelas letras de tempos em tempos
    const gp = (t % 5) / .7; if (e > 2 && gp < 1) { lt.globalCompositeOperation = 'source-atop'; lt.fillStyle = 'rgba(255,255,240,.55)'; const gx = 40 + gp * 280; lt.beginPath(); lt.moveTo(gx, 20); lt.lineTo(gx + 10, 20); lt.lineTo(gx - 20, 100); lt.lineTo(gx - 30, 100); lt.fill(); lt.globalCompositeOperation = 'source-over'; }
    lc.drawImage(letrasCv, 0, 0);
    // faixa ADVENTURE que se desenrola
    const fx = clamp((e - 1.0) / .35, 0, 1); if (fx > 0) { const cx = LOGW / 2, cy = 116 + placaY + flut, hw = Math.round(80 * fx), fh = 22, top = cy - fh / 2;
      if (fx >= 1) for (const s of [-1, 1]) { // pontas da faixa: dobradas para trás, com recorte em V
        for (let k = 0; k < 28; k++) { const xx = s > 0 ? cx + hw - 6 + k : cx - hw + 5 - k, y0 = top + 6, h2 = fh - 2, mid = y0 + h2 / 2, v = Math.max(0, k - 19); // v: profundidade do recorte
          for (let y = y0; y < y0 + h2; y++) { if (Math.abs(y - mid) < v * 1.2) continue; const borda = y === y0 || y === y0 + h2 - 1 || k === 27 || Math.abs(Math.abs(y - mid) - v * 1.2) < 1; L(xx, y, 1, 1, borda ? '#1a3a12' : y < y0 + 3 ? '#4f9a3a' : '#2f6a2a'); } }
        L(s > 0 ? cx + hw - 6 : cx - hw + 3, top + 6, 3, fh - 2, '#173010'); }
      L(cx - hw - 1, top, hw * 2 + 2, fh, '#1a3a12'); L(cx - hw, top + 1, hw * 2, fh - 2, '#3f8a3a'); L(cx - hw, top + 1, hw * 2, 2, '#6abf5a'); L(cx - hw, top + fh - 4, hw * 2, 3, '#2f6a2a');
      for (let k = -hw + 2; k < hw - 2; k += 5) L(cx + k, top + 3, 2, 1, '#5aaa4a');
      if (fx >= 1) { let tw3 = 0; for (const s2 of SMALL) tw3 += s2.w; let sx2 = Math.round(cx - tw3 / 2); SMALL.forEach((s2, j) => { const bob = e > 2 ? Math.round(Math.sin(t * 9 - j * .8) * onda * 3) : 0; lc.drawImage(s2.cv, sx2, cy - 8 + bob); sx2 += s2.w; }); } }
    // galinha em cima da placa e sapo na ponta da faixa
    if (deco > 0) { const bica = Math.floor(t * .7) % 4 === 0 && (t * .7) % 1 < .5; galinha(lc, 70, 23 + placaY + flut, 1, bica, true); sapinho(lc, { x: 256, y: 128 + placaY + flut, z: 0, pisca: (t % 3.3) < .15 ? 1 : 0, papo: Math.max(0, Math.sin(t * 1.1)) * .8 }, t);
      for (let k = 0; k < 2; k++) { const bt = t * .8 + k * 3, bx = 170 + Math.sin(bt) * 150, by = 14 + Math.sin(bt * 1.7) * 10 + k * 120, ab = Math.sin(t * 14 + k) > 0, cor = k ? '#f07aa8' : '#f8d040'; L(bx - (ab ? 2 : 1), by, ab ? 2 : 1, 2, cor); L(bx + 1, by, ab ? 2 : 1, 2, cor); L(bx, by, 1, 2, '#2a1408'); } }
    // brilhinhos em volta
    if (e > 1.6) for (let k = 0; k < 7; k++) { const ph = (t * .6 + hash(k) * 7) % 3; if (ph > 1) continue; const sx3 = 40 + hash(k * 5.3) * 260, sy3 = 26 + hash(k * 2.7) * 70 + placaY, a = Math.sin(ph * Math.PI); lc.globalAlpha = a; L(sx3, sy3, 1, 1, '#ffffff'); if (a > .5) { L(sx3 - 2, sy3, 5, 1, '#fff6c0'); L(sx3, sy3 - 2, 1, 5, '#fff6c0'); } } lc.globalAlpha = 1;
  }

  /* =================================================================
     ÍCONES EM PIXEL PARA OS BOTÕES
     ================================================================= */
  function icone(fn) { const [cv, c] = mk(16, 16); fn(pinta(c), bola(c)); return cv.toDataURL(); }
  const ICONES = {
    jogar: icone((R, Bb) => { R(2, 12, 12, 3, '#5a3418'); R(3, 11, 10, 1, '#8a5a30'); R(4, 13, 2, 1, '#3a200e'); R(9, 13, 2, 1, '#3a200e'); R(7, 5, 2, 7, '#3f8a2a'); R(2, 4, 5, 3, '#3f8a2a'); R(3, 4, 3, 1, '#7ad04a'); R(9, 2, 5, 3, '#3f8a2a'); R(10, 2, 3, 1, '#7ad04a'); R(5, 6, 2, 1, '#3f8a2a'); R(9, 5, 1, 1, '#3f8a2a'); }),
    multi: icone((R) => { for (const [x, y, c, b] of [[1, 6, '#e8c86a', '#8a3a2a'], [6, 3, '#f0d27a', '#3a6a9a']]) { R(x, y + 5, 10, 2, '#2a1408'); R(x, y + 5, 10, 1, c); R(x + 2, y, 6, 6, '#2a1408'); R(x + 3, y + 1, 4, 5, c); R(x + 3, y + 4, 4, 1, b); R(x + 3, y + 1, 1, 1, '#fff6c0'); } }),
    diario: icone((R) => { R(1, 3, 14, 11, '#2a1408'); R(2, 4, 5, 9, '#f6e6bc'); R(9, 4, 5, 9, '#f6e6bc'); R(7, 3, 2, 11, '#8a3a2a'); for (let y = 6; y < 12; y += 2) { R(3, y, 3, 1, '#a8906a'); R(10, y, 3, 1, '#a8906a'); } R(11, 2, 2, 5, '#e84a4a'); }),
    continuar: icone((R) => { R(7, 8, 2, 7, '#6a4426'); R(2, 3, 11, 6, '#2a1408'); R(3, 4, 9, 4, '#c88a4a'); R(12, 4, 1, 4, '#2a1408'); R(13, 5, 1, 2, '#2a1408'); R(12, 5, 1, 2, '#c88a4a'); R(4, 5, 6, 1, '#7a4a24'); R(3, 4, 9, 1, '#e8b070'); }),
    nova: icone((R, Bb) => { R(0, 11, 16, 5, '#5a9a3a'); R(0, 11, 16, 1, '#86c25a'); Bb(8, 11, 5, '#ffd23a', 5); R(0, 12, 16, 4, '#5a9a3a'); for (const [x, y] of [[8, 2], [2, 6], [14, 6], [4, 3], [12, 3]]) R(x, y, 1, 2, '#ffe88a'); R(6, 8, 2, 1, '#fff6c0'); })
  };
  function enfeitar() { // coloca os ícones nos botões (os botões e as funções continuam os mesmos)
    const por = (b, k) => { if (!b || b.querySelector('.tr-ico')) return; const i = document.createElement('i'); i.className = 'tr-ico'; i.setAttribute('aria-hidden', 'true'); i.style.backgroundImage = `url(${ICONES[k]})`; b.prepend(i); b.classList.add('tr-tabua'); };
    por(document.getElementById('menuJogarBtn'), 'jogar'); por(document.getElementById('menuMultiBtn'), 'multi'); por(document.getElementById('adventureInfoBtn'), 'diario');
    por(document.getElementById('continueBtn'), 'continuar'); por(document.getElementById('startBtn'), 'nova');
  }

  /* =================================================================
     MONTAGEM NA TELA
     ================================================================= */
  const conteudo = tela.querySelector('.start-content'), placaHtml = tela.querySelector('.wooden-title');
  if (conteudo) { if (placaHtml) placaHtml.before(logoCv); else conteudo.prepend(logoCv); }
  const dica = document.createElement('div'); dica.className = 'tr-dica'; dica.innerHTML = '<b>✿</b> <span class="longa">Toque no cenário: plante na horta, assuste as galinhas, troque o dia no sol...</span><span class="curta">Toque no cenário!</span>';
  try { if (localStorage.getItem('daroca-tela-dica') === '1') dica.classList.add('some'); } catch (e) {}
  tela.appendChild(dica);
  logoCv.addEventListener('pointerdown', (e) => { e.stopPropagation(); onda = 1; som('logo'); for (let k = 0; k < 10; k++) folhas(rnd(120, 360), rnd(20, 60), 1); });
  // toque no fundo: só quando não é num botão ou painel
  function paraCena(e) {
    const r = cvFundo.getBoundingClientRect(), esc = Math.max(r.width / 960, r.height / 540), ox = r.left + (r.width - 960 * esc) / 2, oy = r.top + (r.height - 540 * esc) / 2;
    return [((e.clientX - ox) / esc) / 2, ((e.clientY - oy) / esc) / 2];
  }
  tela.addEventListener('pointerdown', (e) => {
    const alvo = e.target; if (alvo !== tela && alvo !== cvFundo && !alvo.classList?.contains('start-content')) return;
    const [x, y] = paraCena(e); if (x < 0 || y < 0 || x > LW || y > LH) return; tocar(x, y);
    if (dicaUsos === 3) { try { localStorage.setItem('daroca-tela-dica', '1'); } catch (er) {} }
  });
  let rastro = 0; tela.addEventListener('pointermove', (e) => { if (e.pointerType !== 'mouse' || e.target !== cvFundo && e.target !== tela) return; if (performance.now() - rastro < 45) return; rastro = performance.now(); const [x, y] = paraCena(e); P({ x, y, vx: rnd(-6, 6), vy: rnd(-10, 0), vida: .5, cor: ['#fff6b0', '#ffffff', '#c8f080'][(Math.random() * 3) | 0], tipo: 'estrela' }); });
  enfeitar(); new MutationObserver(enfeitar).observe(tela, { childList: true, subtree: true });

  // o title.js chama Art.drawTitleScene a cada quadro: ela passa a desenhar a roça viva e o logo
  function desenhar(ctx, segundos, w = 960, h = 540) {
    const dt = ultimo ? clamp(segundos - ultimo, 0, .1) : 1 / 30; ultimo = segundos;
    if (!reduzido) atualizar(dt); else tempo += dt;
    desenharCena(); ctx.imageSmoothingEnabled = false; if (ctx.usarFonte) ctx.usarFonte(cena); else ctx.drawImage(cena, 0, 0, w, h); // Roblox: a placa de vídeo amplia a roça
    desenharLogo(segundos);
  }
  if (window.Art) window.Art.drawTitleScene = desenhar;
  window.TelaInicial = Object.freeze({ tocar, hora: (h) => { if (h !== undefined) { hora = ((h % 1) + 1) % 1; horaAlvo = null; } return hora; }, plantas: () => plantas.length, cena: () => cena, logo: () => logoCv });
})();
