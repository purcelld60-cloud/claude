/* Campanha 2 · Passo 5: kit de cutscenes.
   As cutscenes continuam sendo roteiros em dist/roteiros/*.json (o mesmo motor da campanha 1, roteiro.js),
   com a mesma caixa de fala, os mesmos botões e o mesmo jeito de câmera. Este arquivo acrescenta:
   - as fases da Campanha 2 e os nomes dos personagens novos;
   - FUNDOS pintados em pixel art para os closes emocionais: "celular", "aviao_janela", "aviao_ceu",
     "sala_aula", "rodoviaria", "ceu_noite" e "quarto_jorge";
   - EFEITOS: titulo_c2, coracao_partido, batimento, polaroids, foto_trio, pensamento, neblina, frio,
     estrelas, pb (a cor some), flashback, vs (apresentação de vilão), poder, fim, luz_final, barras,
     flash_memoria e chat;
   - ANIMAÇÕES extras por cima dos atores (dá para juntar com +, ex.: "tremendo+chorando"):
     chorando, frio, ajoelhado, celular, celular_mao, zzz, exclama, pergunta, raiva, suor, coracao,
     coracao_partido, brilho, chama, mao, silhueta e fantasma;
   - SONS sintetizados: vibrar, toque, coracao, quebra, aviao, vento, desliga, vs, poder, abraco, digitar, soluco;
   - TRILHA: músicas originais sintetizadas (saudade, flashback, tensao, vilao, conquista, final), tocadas
     quando o roteiro pede ("trilha" no roteiro ou na cena; null para). Se você escolheu uma música sua para
     a cena no painel de músicas, a sua toca no lugar.
   - CampanhaCutscenes.galeria(): lista para assistir a qualquer cutscene da Campanha 2 (botão no ?cenarios2).
   Tudo desenhado aqui mesmo, sem imagens de fora. */
(() => {
  'use strict';
  if (window.CampanhaCutscenes || !window.Roteiro?.estender) return;
  const W = 960, H = 540, TAU = Math.PI * 2;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v)), ease = (k) => { k = clamp(k, 0, 1); return k * k * (3 - 2 * k); }, lerp = (a, b, k) => a + (b - a) * k;
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const P = (c, x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, Math.max(2, Math.round(w / 2) * 2), Math.max(2, Math.round(h / 2) * 2)); };
  const circ = (c, cx, cy, r, col, ry = r) => { c.fillStyle = col; for (let y = -ry; y <= ry; y += 2) { const w = Math.round(r * Math.sqrt(Math.max(0, 1 - (y / ry) * (y / ry))) / 2) * 2; c.fillRect(Math.round((cx - w) / 2) * 2, Math.round((cy + y) / 2) * 2, w * 2 + 2, 2); } };
  const txt = (c, s, x, y, col, o = {}) => { const f = window.CampanhaCamadas?.kit?.pxText; if (f) return f(c, s, x, y, col, o); c.font = `${8 * (o.s || 1)}px Pixel, monospace`; c.fillStyle = col; c.textAlign = 'center'; c.fillText(s, x, y + 6 * (o.s || 1)); c.textAlign = 'left'; return 0; };
  const larg = (s, sc = 1) => String(s).length * 4 * sc - sc;
  const ator = (c, type, x, y, o = {}) => { try { window.Art?.drawCharacter?.(c, type, x, y, { facing: 1, frame: 0, scale: 1, grounded: true, ...o }); } catch (e) {} };
  const grad = (c, y0, y1, cores) => { const n = cores.length; for (let y = y0; y < y1; y += 2) { const k = (y - y0) / (y1 - y0) * (n - 1), i = Math.min(n - 2, Math.floor(k)), f = k - i, d = ((y / 2) % 2) * .5; c.fillStyle = (f + (hash(y) - .5) * .12 > .5 + d * 0) ? cores[i + 1] : cores[i]; c.fillRect(0, y, W, 2); } };
  const retratos = {}; const retrato = (type, emo) => { const k = type + (emo || ''); if (retratos[k]) return retratos[k]; const cv = document.createElement('canvas'); cv.width = cv.height = 64; try { window.Roteiro.portrait(cv.getContext('2d'), type, 64, 0, emo); } catch (e) {} return (retratos[k] = cv); };
  const SKIN = { daroca: '#c68a5e', jorge: '#e2b48a', reeis: '#7a4a2e', miguel: '#f0c8a8' };
  const sfx = (n) => { try { window.Roteiro.sfx(n); } catch (e) {} };

  /* =====================================================================
     NOMES E FASES
     ===================================================================== */
  const nomes = { jorge: 'Jorge', jorge_gordo: 'Jorge', jorge_celular: 'Jorge', miguel: 'Miguel', fred_conquista: 'Fred', crianca_daroca: 'Da Roça', crianca_reeis: 'Reeis', crianca_jorge: 'Jorge', pre_daroca: 'Da Roça', pre_reeis: 'Reeis', pre_jorge: 'Jorge', c2_biscoito: 'Biscoito', piloto: 'Comandante', comissaria: 'Comissária' };
  try { for (const p of window.CampanhaPersonagens?.lista || []) if (!nomes[p.id]) nomes[p.id] = p.nome; } catch (e) {}
  const cenarios = { pensao: 13, bairro: 13, centro: 14, catedral: 14, serra: 15, cristo: 15, monumento: 16, avenidas: 16, feira: 17, cafe: 18, fazenda: 18, teatro: 19, cultura: 19, planetario: 19, shopping: 20, sesi: 21, olivia: 21, escola_sesi: 21, corredor: 24, quarto: 25, patio_sesi: 27, poco: 28, lomantao: 29, rodoviaria_conquista: 30, uesb: 31, lagoa: 32, parque: 33, marcal: 34, aeroporto: 12 };
  try { for (const d of window.CampanhaCenarios?.lista || []) if (d.key && !(d.key in cenarios) && !['patio'].includes(d.key)) cenarios[d.key] = d.id; } catch (e) {}

  /* =====================================================================
     FUNDOS PINTADOS (closes)
     ===================================================================== */
  function ceuRoca(c, tt) { // noite na roça, desfocada atrás do celular
    grad(c, 0, H, ['#0a0e24', '#141a3a', '#241f4a', '#3a2850']);
    for (let i = 0; i < 70; i++) { const tw = Math.sin(tt * 2 + i * 1.7) > .2; if (tw) P(c, hash(i) * W, hash(i + 9) * 300, 2, 2, i % 9 ? '#c8d0ff' : '#fff6c0'); }
    c.fillStyle = '#0c1020'; c.beginPath(); c.moveTo(0, 380); for (let x = 0; x <= W; x += 40) c.lineTo(x, 370 - Math.sin(x / 140) * 40 - Math.sin(x / 57) * 12); c.lineTo(W, H); c.lineTo(0, H); c.fill();
    P(c, 120, 330, 70, 50, '#10142a'); P(c, 110, 316, 90, 16, '#14182e'); P(c, 146, 350, 12, 14, '#e8b04a'); // casinha com a luz acesa
    for (let i = 0; i < 14; i++) { const on = Math.sin(tt * 1.6 + i * 2.3) > .4; if (on) { const x = (hash(i + 3) * W + Math.sin(tt * .4 + i) * 30), y = 380 + hash(i + 5) * 140; P(c, x, y, 2, 2, '#e8f87a'); c.fillStyle = 'rgba(232,248,122,.18)'; c.fillRect(x - 4, y - 4, 10, 10); } }
  }
  function quartoJorge(c, tt, sem) { // o quarto do Jorge em Conquista: frio, neblina na janela... e uma foto antiga no espelho
    grad(c, 0, H, ['#2a2e46', '#262a40', '#1e2236']); for (let y = 0; y < 420; y += 22) P(c, 0, y, W, 2, '#2e3250');
    // janela com a cidade e neblina
    P(c, 610, 70, 270, 220, '#5a4a3a'); P(c, 620, 80, 250, 200, '#0e1a34'); for (let i = 0; i < 40; i++) P(c, 624 + hash(i) * 240, 80 + hash(i + 2) * 70, 2, 2, '#c8d0ff');
    for (let i = 0; i < 9; i++) { const bx = 620 + i * 28, bh = 40 + hash(i + 7) * 70; P(c, bx, 280 - bh, 24, bh, '#18223a'); for (let j = 0; j < bh / 12; j++) if (hash(i * 9 + j) > .45) P(c, bx + 6 + (j % 2) * 8, 284 - bh + j * 12, 4, 4, '#ffd27a'); }
    c.save(); c.beginPath(); c.rect(620, 80, 250, 200); c.clip(); for (let k = 0; k < 3; k++) { c.globalAlpha = .22; circ(c, 620 + ((tt * 12 + k * 110) % 330) - 40, 250 - k * 30, 90, '#c8d0e0', 16); c.globalAlpha = 1; } c.restore();
    P(c, 744, 80, 4, 200, '#5a4a3a'); P(c, 620, 178, 250, 4, '#5a4a3a'); circ(c, 830, 112, 14, '#e8ecf8');
    // espelho com a foto do trio presa no canto
    P(c, 410, 170, 140, 220, '#8a6a4a'); P(c, 418, 178, 124, 204, '#5a6a8a'); P(c, 426, 186, 34, 140, '#7a8aaa');
    { const fx0 = 484, fy0 = 196; P(c, fx0, fy0, 48, 56, '#f2ece0'); P(c, fx0 + 4, fy0 + 4, 40, 36, '#9ad0f0'); P(c, fx0 + 4, fy0 + 30, 40, 10, '#6aa850'); // a foto antiga do trio, presa no espelho
      const kid = (x, pele, cab, roupa, chapeu) => { P(c, x, fy0 + 16, 8, 8, pele); P(c, x, fy0 + 14, 8, 4, cab); if (chapeu) { P(c, x - 2, fy0 + 12, 12, 2, '#d8b04a'); P(c, x, fy0 + 8, 8, 4, '#d8b04a'); } P(c, x + 4, fy0 + 18, 2, 2, '#1c1c1c'); P(c, x, fy0 + 24, 8, 10, roupa); P(c, x - 2, fy0 + 26, 2, 6, pele); P(c, x + 8, fy0 + 26, 2, 6, pele); };
      kid(fx0 + 8, '#c68a5e', '#3a2414', '#e8c24c', true); kid(fx0 + 20, '#7a4a2e', '#1c1c1c', '#c43c3a', false); kid(fx0 + 32, '#e2b48a', '#5a3a20', '#3c6aa8', false); P(c, fx0 + 31, fy0 + 12, 10, 4, '#5a3a20');
      txt(c, 'TRIO', fx0 + 24, fy0 + 44, '#7a4a2a'); P(c, fx0 + 20, fy0 - 4, 8, 8, '#c43c3a'); P(c, fx0 + 22, fy0 - 2, 2, 2, '#ff8a7a'); }
    // pôster, cama, mesa com o computador, abajur
    P(c, 250, 90, 110, 140, '#3c6aa8'); P(c, 258, 98, 94, 124, '#e8433a'); txt(c, 'SKATE', 305, 150, '#ffe39a', { s: 2 });
    P(c, 40, 330, 330, 110, '#3a3020'); P(c, 46, 320, 320, 50, '#2c5a9e'); P(c, 46, 320, 320, 6, '#5a8ad0'); P(c, 52, 300, 80, 30, '#e8ecf0');
    P(c, 560, 330, 200, 14, '#6a4a2e'); P(c, 570, 344, 10, 96, '#5a3a20'); P(c, 740, 344, 10, 96, '#5a3a20'); P(c, 600, 266, 110, 64, '#1c1c24'); P(c, 606, 272, 98, 50, '#2a4a8a');
    if (!sem) { txt(c, 'FRED: KKKKK', 655, 282, '#9adcff'); txt(c, 'FRED: BORA LAN?', 655, 296, '#9adcff'); }
    P(c, 790, 250, 8, 80, '#8a8a8a'); P(c, 770, 230, 48, 24, '#e8c87a'); c.save(); c.globalCompositeOperation = 'lighter'; const g = c.createRadialGradient(794, 250, 10, 794, 250, 220); g.addColorStop(0, 'rgba(255,200,120,.28)'); g.addColorStop(1, 'rgba(255,200,120,0)'); c.fillStyle = g; c.fillRect(560, 40, 400, 420); c.restore();
    P(c, 0, 440, W, 100, '#2a2420'); for (let x = 0; x < W; x += 48) P(c, x, 440, 2, 100, '#201a16');
  }
  const fundos = {
    celular(c, { t, tt, p }) {
      const lado = p.lado || 'daroca', pele = p.pele || SKIN[lado === 'jorge' ? 'jorge' : 'daroca'];
      if (p.fundo === 'quarto') { quartoJorge(c, tt, true); c.fillStyle = 'rgba(8,10,24,.55)'; c.fillRect(0, 0, W, H); } else ceuRoca(c, tt);
      const aperta = p.aperta !== undefined ? Number(p.aperta) : null, apertou = aperta !== null && t >= aperta;
      let estado = p.estado || 'chamando'; if (apertou) estado = 'recusada';
      const vib = estado === 'chamando' && (tt % 1.2) < .7, dx = vib ? Math.round(Math.sin(tt * 90) * 3) : 0, X = 480 + dx, Y = 52;
      if (vib) for (let k = 0; k < 3; k++) { P(c, X - 150 - k * 14, Y + 120 + k * 30, 4, 40 - k * 6, '#ffffffaa'); P(c, X + 146 + k * 14, Y + 120 + k * 30, 4, 40 - k * 6, '#ffffffaa'); }
      if (vib) txt(c, 'BZZ', X + 190, Y + 80, '#fff6c0', { s: 3, sombra: '#1c1408' });
      // aparelho
      P(c, X - 124, Y, 248, 436, '#14161c'); P(c, X - 120, Y + 4, 240, 428, '#2a2e38'); P(c, X - 112, Y + 18, 224, 392, '#0a0c12'); P(c, X - 20, Y + 8, 40, 4, '#0a0c12');
      const sx = X - 108, sy = Y + 22, sw = 216, sh = 384;
      const bg = estado === 'recusada' ? ['#3a1418', '#1a0a0e'] : estado === 'video' ? ['#1a2a3a', '#0a1420'] : ['#3a2a5a', '#141a30'];
      for (let y = 0; y < sh; y += 2) { c.fillStyle = y / sh + hash(y) * .08 > .5 ? bg[1] : bg[0]; c.fillRect(sx, sy + y, sw, 2); }
      txt(c, p.hora || '23:47', sx + 12, sy + 8, '#e8ecf8', { align: 'left' }); for (let k = 0; k < 4; k++) P(c, sx + sw - 44 + k * 6, sy + 16 - k * 3, 4, 4 + k * 3, '#e8ecf8'); P(c, sx + sw - 18, sy + 8, 12, 8, '#7ae07a');
      if (estado === 'video') { // videochamada: o rosto enorme de quem ligou
        c.imageSmoothingEnabled = false; c.drawImage(retrato(p.foto || 'reeis', p.emocao), 0, 0, 64, 64, sx + 4, sy + 30, sw - 8, sw - 8);
        P(c, sx + sw - 64, sy + sh - 132, 56, 72, '#2a2e38'); c.drawImage(retrato(p.eu || 'daroca'), 0, 0, 64, 64, sx + sw - 62, sy + sh - 128, 52, 52);
        txt(c, p.quem || 'REEIS', X, sy + sw + 36, '#ffffff', { s: 3, sombra: '#000' }); txt(c, 'VIDEOCHAMADA · ' + String(Math.floor(t / 60)).padStart(2, '0') + ':' + String(Math.floor(t % 60)).padStart(2, '0'), X, sy + sw + 64, '#9adcff', { s: 1 });
      } else {
        const cy = sy + 130, r = 54; for (let k = 0; k < 3 && (estado === 'chamando' || estado === 'ligando'); k++) { const q = (tt * .8 + k / 3) % 1; c.globalAlpha = (1 - q) * .5; c.strokeStyle = '#c8b0ff'; c.lineWidth = 2; c.beginPath(); c.arc(X, cy, r + q * 50, 0, TAU); c.stroke(); } c.globalAlpha = 1;
        c.save(); c.beginPath(); c.arc(X, cy, r, 0, TAU); c.clip(); c.imageSmoothingEnabled = false; c.drawImage(retrato(p.foto || 'jorge_gordo', p.emocao), X - r, cy - r, r * 2, r * 2); if (estado === 'recusada') { c.fillStyle = 'rgba(20,0,0,.5)'; c.fillRect(X - r, cy - r, r * 2, r * 2); } c.restore();
        c.strokeStyle = '#e8ecf8'; c.lineWidth = 3; c.beginPath(); c.arc(X, cy, r, 0, TAU); c.stroke();
        txt(c, p.quem || 'JORGE', X, cy + 78, '#ffffff', { s: 3, sombra: '#000' });
        const dots = '.'.repeat(1 + Math.floor(tt * 2) % 3), sub = { chamando: 'CHAMADA DE VOZ', ligando: 'LIGANDO' + dots, recusada: 'CHAMADA RECUSADA', perdida: '1 CHAMADA PERDIDA', encerrada: 'CHAMADA ENCERRADA' }[estado] || '';
        txt(c, sub, X, cy + 112, estado === 'recusada' ? '#ff6a5a' : '#c8d0f0', { s: 2 });
        if (estado === 'recusada' && aperta !== null && t - aperta < .4) { c.fillStyle = `rgba(255,60,40,${.5 - (t - aperta)})`; c.fillRect(sx, sy, sw, sh); }
        const by = sy + sh - 70, botao = (bx, cor, desliga, apertado) => { circ(c, bx, by + (apertado ? 2 : 0), 26, '#0a0c12'); circ(c, bx, by - 2 + (apertado ? 2 : 0), 24, apertado ? '#a82a24' : cor); P(c, bx - 14, by - 6 + (apertado ? 2 : 0) + (desliga ? 2 : 0), 28, 6, '#ffffff'); P(c, bx - 16, by - (desliga ? 2 : 10) + (apertado ? 2 : 0), 8, 8, '#ffffff'); P(c, bx + 8, by - (desliga ? 2 : 10) + (apertado ? 2 : 0), 8, 8, '#ffffff'); };
        if (estado === 'chamando') { botao(X - 56, '#e8433a', true, apertou); const b = Math.abs(Math.sin(tt * 5)) * 4; c.save(); c.translate(0, -b); botao(X + 56, '#3ac25a', false, false); c.restore(); }
        else if (estado === 'ligando') botao(X, '#e8433a', true, false);
        else if (estado === 'recusada') { P(c, X - 30, by - 30, 60, 60, '#5a1418'); txt(c, 'X', X, by - 22, '#ff6a5a', { s: 6 }); }
      }
      // mão segurando (dedos na lateral, polegar e palma embaixo)
      const sh2 = (col, k) => { const n = parseInt(col.slice(1), 16), f = (v) => Math.max(0, Math.min(255, Math.round(v * k))); return '#' + [(n >> 16) & 255, (n >> 8) & 255, n & 255].map((v) => f(v).toString(16).padStart(2, '0')).join(''); };
      const rr = (x, y, w, h, r, col) => { c.fillStyle = col; c.beginPath(); if (c.roundRect) c.roundRect(Math.round(x), Math.round(y), w, h, r); else c.rect(Math.round(x), Math.round(y), w, h); c.fill(); };
      const manga = p.manga || (lado === 'jorge' ? '#7a5a3a' : '#c8a24a');
      for (let k = 0; k < 4; k++) { const fy = Y + 150 + k * 44, fw = 40 - Math.abs(k - 1.4) * 4; rr(X - 138 - fw / 3, fy - 2, fw + 4, 34, 14, sh2(pele, .62)); rr(X - 136 - fw / 3, fy, fw, 30, 12, pele); rr(X - 132 - fw / 3, fy + 4, fw * .5, 8, 4, sh2(pele, 1.12)); rr(X - 112, fy + 6, 10, 18, 5, sh2(pele, 1.22)); }
      rr(X - 170, Y + 360, 340, 200, 70, sh2(pele, .62)); rr(X - 166, Y + 364, 332, 196, 66, pele); rr(X - 150, Y + 380, 120, 16, 8, sh2(pele, 1.1)); rr(X - 60, Y + 420, 120, 6, 3, sh2(pele, .85));
      rr(X - 190, Y + 470, 380, 120, 30, sh2(manga, .7)); rr(X - 186, Y + 474, 372, 116, 28, manga); for (let k = 0; k < 6; k++) P(c, X - 170 + k * 62, Y + 480, 30, 4, sh2(manga, 1.15));
      let tx = X + 112, ty = Y + 260; if (aperta !== null) { const k = ease((t - (aperta - .7)) / .7); tx = lerp(X + 112, X - 56, k); ty = lerp(Y + 260, Y + 22 + sh - 74, k); }
      rr(tx - 18, ty - 2, 42, 84, 18, sh2(pele, .62)); rr(tx - 16, ty, 38, 80, 16, pele); rr(tx - 10, ty + 4, 22, 16, 8, sh2(pele, 1.2)); rr(tx - 6, ty + 6, 14, 10, 5, '#f2d8c8');
    },
    aviao_janela(c, { tt, p }) {
      const fase = p.fase || 'voo';
      P(c, 0, 0, W, H, '#d8d2c4'); for (let x = 0; x < W; x += 120) P(c, x, 0, 2, H, '#c4bdae'); P(c, 0, 470, W, 70, '#5a6a8a'); P(c, 0, 470, W, 4, '#7a8aaa');
      const wx = 300, wy = 70, ww = 360, wh = 300;
      c.save(); c.beginPath(); c.roundRect ? c.roundRect(wx, wy, ww, wh, 90) : c.rect(wx, wy, ww, wh); c.clip();
      if (fase === 'voo') { grad(c, wy, wy + wh, ['#3a7ad0', '#6aa8e8', '#a8d4f6', '#e8f4ff']); circ(c, wx + 270, wy + 70, 26, '#fff6c0'); c.globalAlpha = .25; circ(c, wx + 270, wy + 70, 60, '#fff6c0'); c.globalAlpha = 1;
        for (let i = 0; i < 18; i++) { const x = wx + ((i * 61 - tt * (60 + (i % 3) * 30)) % (ww + 200) + ww + 200) % (ww + 200) - 100, y = wy + 190 + (i % 4) * 26; circ(c, x, y, 50 + (i % 3) * 14, i % 2 ? '#ffffff' : '#eef4fa', 14); } }
      else { const decol = fase === 'decolagem', off = decol ? tt * 26 : -tt * 10, hz = wy + (decol ? 90 + Math.min(70, tt * 8) : 120);
        grad(c, wy, hz, decol ? ['#5a9ae0', '#9ac8f0', '#d8ecfa'] : ['#8aa4c0', '#b8c8d8', '#dfe6ee']);
        grad(c, hz, wy + wh, decol ? ['#7aa860', '#5a9048', '#4a7a3c'] : ['#9aa080', '#8a9070', '#7a8060']);
        for (let i = 0; i < 40; i++) { const x = wx + ((hash(i) * 600 + off * (1 + hash(i + 1))) % 600) - 100, y = hz + 6 + hash(i + 2) * (wy + wh - hz - 10); if (decol) { if (i % 3) circ(c, x, y, 6, '#2f6a2a', 4); else { P(c, x, y, 16, 10, '#e8e0d0'); P(c, x, y - 4, 16, 4, '#c8543a'); } } else { P(c, x, y, 14 + (i % 3) * 6, 18, i % 4 ? '#e8e4dc' : '#d8d0c0'); P(c, x + 3, y + 4, 3, 3, '#5a6a8a'); } }
        if (decol) { c.strokeStyle = '#4a92e2'; c.lineWidth = 6; c.beginPath(); c.moveTo(wx - 20, hz + 120 + off % 40); c.quadraticCurveTo(wx + 180, hz + 40, wx + ww + 20, hz + 90); c.stroke(); }
        else { c.globalAlpha = .45; for (let k = 0; k < 4; k++) circ(c, wx + ((tt * 18 + k * 120) % 520) - 80, hz + 20 + k * 30, 90, '#f4f8fa', 14); c.globalAlpha = 1; P(c, wx + 60, hz - 30, 2, 30, '#8a8478'); P(c, wx + 54, hz - 24, 14, 2, '#8a8478'); } }
      for (let i = 0; i < 5; i++) { const x = wx + ww - ((tt * 300 + i * 160) % (ww + 200)), y = wy + 40 + i * 50; c.globalAlpha = .5; P(c, x, y, 80, 4, '#ffffff'); c.globalAlpha = 1; }
      c.fillStyle = '#b8bcc4'; c.beginPath(); c.moveTo(wx - 10, wy + wh - 40); c.lineTo(wx + 230, wy + wh - 96); c.lineTo(wx + 250, wy + wh - 84); c.lineTo(wx - 10, wy + wh + 10); c.fill(); P(c, wx + 220, wy + wh - 98, 6, 8, fase === 'voo' ? '#e8433a' : (Math.floor(tt * 2) % 2 ? '#e8433a' : '#5a1a1a'));
      c.restore();
      c.lineWidth = 14; c.strokeStyle = '#ece6d8'; c.beginPath(); c.roundRect ? c.roundRect(wx - 6, wy - 6, ww + 12, wh + 12, 96) : c.rect(wx - 6, wy - 6, ww + 12, wh + 12); c.stroke(); c.lineWidth = 4; c.strokeStyle = '#b8b0a0'; c.beginPath(); c.roundRect ? c.roundRect(wx - 14, wy - 14, ww + 28, wh + 28, 104) : c.rect(wx - 14, wy - 14, ww + 28, wh + 28); c.stroke();
      P(c, wx + 30, wy - 4, ww - 60, 40, '#e8e2d4'); P(c, wx + ww / 2 - 16, wy + 30, 32, 6, '#a8a090'); c.lineWidth = 1;
      P(c, 0, 220, 250, 330, '#2c4a7a'); P(c, 0, 220, 250, 16, '#3c5a8a'); for (let y = 240; y < H; y += 12) P(c, 0, y, 250, 2, '#284470'); P(c, 210, 220, 40, 320, '#243e66'); P(c, 30, 200, 160, 40, '#e8e2d4'); P(c, 30, 200, 160, 6, '#f6f2e8');
      // mesinha com o cafezinho tremendo
      P(c, 120, 420, 260, 16, '#8a8a92'); P(c, 120, 436, 260, 6, '#6a6a72'); const tr = fase !== 'voo' ? Math.round(Math.sin(tt * 40) * 1) : 0; P(c, 230 + tr, 392, 30, 28, '#f6f2ea'); P(c, 234 + tr, 396, 22, 6, '#5a3420'); P(c, 260 + tr, 400, 8, 10, '#f6f2ea');
      for (let k = 0; k < 3; k++) { const q = (tt * .6 + k / 3) % 1; c.globalAlpha = (1 - q) * .5; P(c, 240 + k * 6 + Math.sin(tt * 3 + k) * 3, 386 - q * 30, 2, 6, '#ffffff'); } c.globalAlpha = 1;
    },
    aviao_ceu(c, { t, tt }) {
      grad(c, 0, H, ['#4a8ad8', '#7ab4ec', '#b8dcf8', '#e8f4ff']); circ(c, 800, 90, 34, '#fff6c0'); c.globalAlpha = .2; circ(c, 800, 90, 80, '#fff6c0'); c.globalAlpha = 1;
      for (let L = 0; L < 3; L++) for (let i = 0; i < 9; i++) { const sp = 20 + L * 40, x = ((i * 170 - tt * sp) % 1300 + 1300) % 1300 - 170, y = 150 + L * 130 + (i % 3) * 20; c.globalAlpha = .7 + L * .1; circ(c, x, y, 70 + L * 20, L === 2 ? '#ffffff' : '#f0f6fc', 18 + L * 4); circ(c, x + 40, y - 12, 40 + L * 10, '#ffffff', 14); } c.globalAlpha = 1;
      const x0 = 60 + t * 60, y0 = 270 - t * 10 + Math.sin(tt * 2) * 4;
      for (let k = 1; k < 34; k++) { c.globalAlpha = .55 - k * .015; P(c, x0 - 110 - k * 16, y0 + 10 + k * 2.4, 18, 6, '#ffffff'); P(c, x0 - 110 - k * 16, y0 + 36 + k * 2.4, 18, 6, '#ffffff'); } c.globalAlpha = 1;
      c.save(); c.translate(x0, y0); c.scale(1.8, 1.8); const x = 0, y = 0;
      P(c, x - 70, y, 150, 26, '#f2f4f6'); P(c, x - 70, y + 18, 150, 8, '#c9ced2'); P(c, x - 70, y + 8, 150, 4, '#2c5a9e'); P(c, x + 80, y + 4, 14, 18, '#f2f4f6'); P(c, x + 86, y + 6, 8, 6, '#3a4a5a');
      P(c, x - 82, y - 30, 26, 34, '#2c5a9e'); P(c, x - 76, y - 24, 12, 12, '#e8c24c'); for (let k = 0; k < 9; k++) P(c, x - 50 + k * 14, y + 4, 6, 6, '#3a4a5a');
      P(c, x - 20, y + 14, 70, 10, '#d8dce0'); P(c, x - 30, y + 22, 50, 8, '#b8bcc4'); c.restore();
    },
    sala_aula(c, { tt }) {
      P(c, 0, 0, W, 330, '#efe2c0'); for (let x = 0; x < W; x += 6) if (hash(x) > .7) P(c, x, hash(x + 1) * 320, 2, 2, '#e4d4ac'); P(c, 0, 330, W, 110, '#5a8a5a'); P(c, 0, 326, W, 6, '#3c6a40'); P(c, 0, 440, W, 100, '#8a5a36'); for (let x = 0; x < W; x += 64) P(c, x, 440, 2, 100, '#6a4228');
      P(c, 240, 80, 480, 190, '#7a4a2a'); P(c, 250, 90, 460, 170, '#2a4a36'); for (let i = 0; i < 30; i++) P(c, 254 + hash(i) * 450, 94 + hash(i + 3) * 160, 4, 2, '#3a5a46');
      txt(c, 'NAO CONVERSAR!', 360, 104, '#e8ecef', { s: 2 }); txt(c, '6+7 = ?', 620, 110, '#f2e2a8', { s: 2 });
      for (let k = 0; k < 3; k++) { const x = 300 + k * 34; circ(c, x, 170, 7, '#e8ecef'); circ(c, x, 170, 5, '#2a4a36'); P(c, x - 1, 178, 2, 24, '#e8ecef'); P(c, x - 10, 186, 20, 2, '#e8ecef'); P(c, x - 8, 202, 2, 12, '#e8ecef'); P(c, x + 6, 202, 2, 12, '#e8ecef'); }
      txt(c, 'TRIO', 334, 222, '#ffd27a', { s: 2 }); P(c, 386, 160, 4, 4, '#e86a8a'); P(c, 394, 160, 4, 4, '#e86a8a'); P(c, 384, 164, 16, 4, '#e86a8a'); P(c, 388, 168, 8, 4, '#e86a8a');
      P(c, 250, 262, 460, 8, '#a87a54'); for (let k = 0; k < 4; k++) P(c, 280 + k * 30, 258, 12, 4, ['#f6f6f0', '#f2c94c', '#e86a8a', '#7ac0d0'][k]);
      P(c, 40, 90, 160, 200, '#e8e2d0'); P(c, 48, 98, 144, 184, '#8ac8f0'); circ(c, 140, 230, 40, '#4a9a3a', 30); P(c, 116, 98, 4, 184, '#e8e2d0'); P(c, 48, 186, 144, 4, '#e8e2d0');
      c.save(); c.globalCompositeOperation = 'lighter'; c.fillStyle = 'rgba(255,240,190,.08)'; c.beginPath(); c.moveTo(48, 98); c.lineTo(192, 98); c.lineTo(420, 440); c.lineTo(180, 440); c.fill(); c.restore();
      circ(c, 820, 110, 30, '#f6f6f0'); c.strokeStyle = '#2a2a2a'; c.lineWidth = 3; c.beginPath(); c.moveTo(820, 110); c.lineTo(820 + Math.cos(tt * .5) * 20, 110 + Math.sin(tt * .5) * 20); c.moveTo(820, 110); c.lineTo(832, 102); c.stroke(); c.lineWidth = 1;
      P(c, 760, 360, 160, 80, '#7a4a2a'); P(c, 760, 356, 160, 8, '#a87a54'); circ(c, 860, 346, 8, '#c43c3a'); P(c, 859, 336, 2, 4, '#3a2a1a');
      for (let k = 0; k < 4; k++) { P(c, 60 + k * 170, 400, 110, 10, '#a87a54'); P(c, 70 + k * 170, 410, 6, 30, '#6a4228'); P(c, 160 + k * 170, 410, 6, 30, '#6a4228'); }
      { const u = (tt * .25) % 1, x = 80 + u * 800, y = 200 - Math.sin(u * Math.PI) * 80; c.fillStyle = '#ffffff'; c.beginPath(); c.moveTo(x + 18, y); c.lineTo(x - 10, y - 8); c.lineTo(x - 4, y); c.lineTo(x - 10, y + 6); c.fill(); }
    },
    rodoviaria(c, { t, tt, p }) {
      grad(c, 0, 300, ['#3a2a5a', '#8a4a6a', '#e8835a', '#f6c06a']); circ(c, 220, 250, 40, '#ffd27a'); c.globalAlpha = .25; circ(c, 220, 250, 90, '#ffd27a'); c.globalAlpha = 1;
      P(c, 0, 0, W, 60, '#3a3a42'); P(c, 0, 56, W, 8, '#2a2a30'); for (let x = 40; x < W; x += 160) { P(c, x, 64, 6, 240, '#4a4a52'); P(c, x - 20, 62, 46, 6, '#ffe6a8'); }
      P(c, 0, 300, W, 140, '#6a6a72'); for (let x = 0; x < W; x += 40) P(c, x, 300, 20, 4, '#e8c24c'); P(c, 0, 440, W, 100, '#5a5a62');
      const parte = p.parte !== undefined ? Number(p.parte) : 99, k = t > parte ? Math.pow(t - parte, 2) * 60 : 0, bx = 360 - k;
      for (let i = 0; i < 6 && t > parte; i++) { const q = ((tt * 1.2) + i / 6) % 1; c.globalAlpha = (1 - q) * .5; circ(c, bx + 520 + q * 60, 420 - q * 30, 10 + q * 20, '#c8c8c8'); } c.globalAlpha = 1;
      P(c, bx, 210, 520, 220, '#e8ecef'); P(c, bx, 210, 520, 10, '#ffffff'); P(c, bx, 330, 520, 30, '#2c5a9e'); P(c, bx, 360, 520, 10, '#e8c24c'); P(c, bx + 4, 222, 120, 26, '#14161c'); txt(c, 'V. DA CONQUISTA', bx + 64, 230, '#ff9a3a');
      for (let k2 = 0; k2 < 5; k2++) { P(c, bx + 140 + k2 * 74, 240, 64, 70, '#1a2a3a'); P(c, bx + 144 + k2 * 74, 244, 20, 30, '#2a4a6a'); }
      const jx = bx + 140 + 2 * 74; c.imageSmoothingEnabled = false; c.save(); c.beginPath(); c.rect(jx, 240, 64, 70); c.clip(); c.drawImage(retrato(p.quem || 'pre_jorge', p.emocao || 'sad'), 0, 0, 64, 64, jx, 244, 64, 64); c.restore();
      const aceno = Math.round(Math.sin(tt * 7) * 6); P(c, jx + 48 + aceno, 250, 12, 16, SKIN.jorge); P(c, jx + 50 + aceno, 246, 3, 6, SKIN.jorge); P(c, jx + 54 + aceno, 245, 3, 6, SKIN.jorge);
      for (const wx of [bx + 90, bx + 430]) { circ(c, wx, 430, 30, '#1c1c1c'); circ(c, wx, 430, 14, '#8a8e94'); }
      P(c, bx + 500, 300, 20, 20, '#fff2b0');
    },
    ceu_noite(c, { tt }) {
      grad(c, 0, 440, ['#06081c', '#0e1430', '#1c2048', '#2a2a5a']);
      for (let i = 0; i < 120; i++) { const tw = Math.sin(tt * (1 + hash(i) * 2) + i) > -.2; if (tw) P(c, hash(i + 1) * W, hash(i + 2) * 330, 2, 2, i % 11 ? '#c8d0ff' : '#ffe6a8'); }
      circ(c, 760, 100, 36, '#f2eed8'); circ(c, 772, 92, 30, '#0e1430'); P(c, 744, 104, 6, 6, '#d8d4c0');
      const q = (tt % 7) / 7; if (q < .14) { const k = q / .14, x = 200 + k * 420, y = 60 + k * 120; for (let j = 0; j < 10; j++) { c.globalAlpha = (1 - j / 10) * (1 - k); P(c, x - j * 12, y - j * 3.4, 4, 2, '#ffffff'); } c.globalAlpha = 1; }
      c.fillStyle = '#0a0c1c'; c.beginPath(); c.moveTo(0, 400); for (let x = 0; x <= W; x += 30) c.lineTo(x, 392 - Math.sin(x / 160) * 34 - Math.sin(x / 47) * 8); c.lineTo(W, H); c.lineTo(0, H); c.fill();
      P(c, 640, 330, 120, 70, '#0c0e1e'); c.fillStyle = '#0c0e1e'; c.beginPath(); c.moveTo(630, 334); c.lineTo(700, 290); c.lineTo(770, 334); c.fill(); P(c, 676, 350, 18, 16, '#e8b04a');
      P(c, 120, 300, 6, 120, '#0c0e1e'); for (let k = 0; k < 4; k++) { const a = tt * .6 + k * Math.PI / 2; c.strokeStyle = '#0c0e1e'; c.lineWidth = 4; c.beginPath(); c.moveTo(123, 300); c.lineTo(123 + Math.cos(a) * 40, 300 + Math.sin(a) * 40); c.stroke(); } c.lineWidth = 1;
      P(c, 0, 440, W, 100, '#0a0c18'); for (let x = 0; x < W; x += 40) { P(c, x, 420, 4, 24, '#14162a'); P(c, x, 426, 40, 3, '#14162a'); }
      for (let i = 0; i < 10; i++) { if (Math.sin(tt * 1.4 + i * 2.1) > .3) { const x = hash(i + 50) * W + Math.sin(tt * .5 + i) * 20, y = 360 + hash(i + 51) * 160; P(c, x, y, 2, 2, '#e8f87a'); c.fillStyle = 'rgba(232,248,122,.15)'; c.fillRect(x - 4, y - 4, 10, 10); } }
    },
    quarto_jorge(c, { tt }) { quartoJorge(c, tt, false); }
  };

  /* =====================================================================
     EFEITOS
     ===================================================================== */
  const CORACAO = ['.XX...XX.', 'XXXX.XXXX', 'XXXXXXXXX', 'XXXXXXXXX', '.XXXXXXX.', '..XXXXX..', '...XXX...', '....X....'];
  function desenhaCoracao(c, x, y, s, metade, cor = '#e8433a') { // metade: 0 inteiro, -1 esquerda, 1 direita
    CORACAO.forEach((row, j) => { for (let i = 0; i < 9; i++) if (row[i] === 'X') { if (metade < 0 && i > 4 - (j % 2)) continue; if (metade > 0 && i <= 4 - (j % 2)) continue; const hl = (j === 1 && (i === 1 || i === 2)) || (j === 2 && i === 1); c.fillStyle = hl ? '#ffb0a0' : j > 4 ? '#b02a2a' : cor; c.fillRect(Math.round(x + (i - 4.5) * s), Math.round(y + (j - 4) * s), Math.ceil(s), Math.ceil(s)); } });
  }
  const iconCache = {}; function icone(id) { if (iconCache[id]) return iconCache[id]; const img = new Image(); try { img.src = 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent((window.CampanhaPoderes?.iconeSVG?.(id, 96) || '').replace('<svg ', '<svg xmlns="http://www.w3.org/2000/svg" ').replace(/currentColor/g, '#fff6dc')); } catch (e) {} return (iconCache[id] = img); }
  const desatura = (c, a) => { if (a <= 0) return; c.save(); c.globalCompositeOperation = 'saturation'; c.globalAlpha = clamp(a, 0, 1); c.fillStyle = '#808080'; c.fillRect(0, 0, W, H); c.restore(); };
  function polaroid(c, x, y, w, h, rot, fn, legenda) {
    c.save(); c.translate(x, y); c.rotate(rot); c.fillStyle = 'rgba(0,0,0,.35)'; c.fillRect(-w / 2 + 6, -h / 2 + 8, w, h); c.fillStyle = '#f6f2e8'; c.fillRect(-w / 2, -h / 2, w, h);
    const iw = w - 20, ih = h - 54; c.save(); c.beginPath(); c.rect(-iw / 2, -h / 2 + 10, iw, ih); c.clip(); c.translate(-iw / 2, -h / 2 + 10); fn(c, iw, ih); c.restore();
    c.fillStyle = 'rgba(255,230,180,.12)'; c.fillRect(-iw / 2, -h / 2 + 10, iw, ih); if (legenda) txt(c, legenda, 0, h / 2 - 32, '#3a2a1a', { s: 1 }); c.restore();
  }
  function cenaFoto(c, iw, ih, quem, ceu = ['#8ac8f0', '#c8e8f8'], chao = '#6aa850', escala = 1.1) {
    for (let y = 0; y < ih; y += 2) { c.fillStyle = y < ih * .62 ? (y / ih > .3 ? ceu[1] : ceu[0]) : chao; c.fillRect(0, y, iw, 2); } circ(c, iw * .8, ih * .2, 12, '#fff6c0');
    const n = quem.length; quem.forEach((q, i) => ator(c, q, iw * (i + 1) / (n + 1), ih * .92, { scale: escala, facing: i < n / 2 ? 1 : -1, emotion: 'friend', frame: 0 }));
  }
  const efeitos = {
    titulo_c2(c, e, t, { win }) {
      const f = win(Number(e.dur) || 6); if (!f.on) return; const k = t - f.t0, a = Math.min(1, k / .6, (f.t0 + f.d - t) / .6);
      c.save(); c.globalAlpha = a; grad(c, 0, H, ['#0a1020', '#14203a', '#24345a', '#3a4a6a']);
      for (let i = 0; i < 6; i++) { c.globalAlpha = a * .18; circ(c, ((k * 20 + i * 220) % 1300) - 170, 300 + (i % 3) * 70, 200, '#c8d8e8', 40); } c.globalAlpha = a;
      for (let i = 0; i < 60; i++) { const x = (hash(i) * W + Math.sin(k + i) * 20) % W, y = (hash(i + 3) * H + k * (20 + hash(i) * 30)) % H; P(c, x, y, 2, 2, '#e8f4ff'); }
      const T = 'DA ROCA ADVENTURE', s = 5, w = larg(T, s); let x = W / 2 - w / 2;
      for (let i = 0; i < T.length; i++) { const ki = clamp((k - .3 - i * .06) / .35, 0, 1), dy = (1 - ease(ki)) * -60; if (ki > 0) { c.globalAlpha = a * ki; txt(c, T[i], x, 150 + dy, '#ffe9b0', { s, align: 'left', sombra: '#2a1c10' }); } x += 4 * s; }
      c.globalAlpha = a; const k2 = clamp((k - 1.6) / .5, 0, 1); if (k2 > 0) { const ww = 280 * ease(k2); P(c, W / 2 - ww / 2, 214, ww, 30, '#8a2a2a'); P(c, W / 2 - ww / 2, 214, ww, 4, '#c84a3a'); if (k2 >= 1) txt(c, 'CAMPANHA 2', W / 2, 222, '#fff6dc', { s: 2 }); }
      const k3 = clamp((k - 2.3) / .7, 0, 1); if (k3 > 0) { c.globalAlpha = a * k3; txt(c, 'VITORIA DA CONQUISTA', W / 2, 290, '#c8e8ff', { s: 4, sombra: '#0a1020' }); for (let i = 0; i < 12; i++) if (Math.sin(k * 6 + i * 2) > .7) { const sx = W / 2 - 230 + hash(i) * 460, sy = 286 + hash(i + 1) * 30; P(c, sx, sy - 4, 2, 10, '#ffffff'); P(c, sx - 4, sy, 10, 2, '#ffffff'); } }
      const k4 = clamp((k - 3.2) / .6, 0, 1); if (k4 > 0) { c.globalAlpha = a * k4; txt(c, '- A SUICA BAIANA -', W / 2, 336, '#9ab4d0', { s: 2 }); }
      c.restore();
    },
    coracao_partido(c, e, t, { win }) {
      const f = win(Number(e.dur) || 3.4); if (!f.on) return; const k = (t - f.t0) / f.d, x = Number(e.x) || 480, y = Number(e.y) || 250, s = 16 * (Number(e.escala) || 1);
      c.fillStyle = `rgba(10,4,8,${Math.min(.6, k * 3) * (e.fundo === false ? 0 : 1)})`; c.fillRect(0, 0, W, H);
      const pulso = k < .3 ? 1 + Math.max(0, Math.sin(k / .3 * Math.PI * 3)) * .12 : 1, tre = k > .42 && k < .58 ? Math.sin(t * 70) * 3 : 0;
      if (k < .58) { desenhaCoracao(c, x + tre, y, s * pulso, 0); if (k > .3) { const n = Math.floor(clamp((k - .3) / .12, 0, 1) * 8); c.fillStyle = '#1a0608'; let px = x - s * .2, py = y - s * 3; for (let i = 0; i < n; i++) { const nx = x + (i % 2 ? s * .6 : -s * .5) + tre, ny = py + s * .8; c.fillRect(Math.min(px, nx), py, Math.abs(nx - px) + 4, 4); c.fillRect(nx, py, 4, s * .8 + 2); px = nx; py = ny; } } }
      else { const q = (k - .58) / .42, sep = ease(q) * 70, cai = q * q * 220, cor = q > .3 ? '#a03030' : '#e8433a';
        c.save(); c.translate(x - sep, y + cai); c.rotate(-q * .5); desenhaCoracao(c, 0, 0, s, -1, cor); c.restore(); c.save(); c.translate(x + sep, y + cai * .9); c.rotate(q * .5); desenhaCoracao(c, 0, 0, s, 1, cor); c.restore();
        for (let i = 0; i < 16; i++) { const a = hash(i) * TAU, v = 80 + hash(i + 1) * 160; P(c, x + Math.cos(a) * v * q, y + Math.sin(a) * v * q + q * q * 200, 6, 6, i % 3 ? '#e8433a' : '#ffb0a0'); }
        desatura(c, q * .6); }
    },
    batimento(c, e, t) { const b = (t * 1.15) % 1, pulso = b < .12 ? b / .12 : b < .24 ? 1 - (b - .12) / .12 : b < .32 ? (b - .24) / .08 * .7 : b < .5 ? .7 - (b - .32) / .18 * .7 : 0, f = (Number(e.forca) || .5) * (.4 + pulso * .6); const g = c.createRadialGradient(W / 2, H / 2, 160, W / 2, H / 2, 600); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(1, `rgba(90,0,10,${f})`); c.fillStyle = g; c.fillRect(0, 0, W, H); },
    polaroids(c, e, t) {
      const fotos = Array.isArray(e.fotos) ? e.fotos : [], t0 = Number(e.t) || 0, iv = Number(e.intervalo) || 1.3; if (t < t0) return;
      c.fillStyle = `rgba(20,14,10,${Math.min(.72, (t - t0) * 1.5)})`; c.fillRect(0, 0, W, H);
      const n = fotos.length; fotos.forEach((ft, i) => { const ti = t0 + i * iv; if (t < ti) return; const k = ease((t - ti) / .55), col = n <= 3 ? i : i % 4, lin = n <= 3 ? 0 : Math.floor(i / 4), porLinha = n <= 3 ? n : 4, x = W / 2 + (col - (porLinha - 1) / 2) * (n <= 3 ? 250 : 210) + (lin % 2) * 40, y = (n <= 4 ? 260 : 170 + lin * 200) - (1 - k) * 400, rot = (hash(i + 4) - .5) * .3 + (1 - k) * .8;
        polaroid(c, x, y, n <= 4 ? 200 : 170, n <= 4 ? 230 : 196, rot, (cc, iw, ih) => cenaFoto(cc, iw, ih, ft.quem || [], ft.ceu, ft.chao, ft.escala || (n <= 4 ? 1 : .85)), ft.legenda); });
    },
    foto_trio(c, e, t, { win }) {
      const f = win(Number(e.dur) || 5); if (!f.on) return; const k = (t - f.t0), a = Math.min(1, k / .5, (f.t0 + f.d - t) / .5), era = e.era || 'crianca';
      const quem = era === 'agora' ? ['daroca', 'reeis', 'jorge'] : era === 'pre' ? ['pre_daroca', 'pre_reeis', 'pre_jorge'] : ['crianca_daroca', 'crianca_reeis', 'crianca_jorge'];
      c.save(); c.globalAlpha = a; c.fillStyle = 'rgba(16,10,6,.6)'; c.fillRect(0, 0, W, H);
      polaroid(c, Number(e.x) || 480, 260 - (1 - ease(k / .6)) * 60, 380, 400, (Number(e.giro) || -.05) + Math.sin(k * .8) * .015, (cc, iw, ih) => { cenaFoto(cc, iw, ih, quem, era === 'agora' ? ['#f2b06a', '#f8d8a0'] : ['#8ac8f0', '#c8e8f8'], era === 'agora' ? '#5a9a4a' : '#6aa850', era === 'agora' ? 1.35 : 1.6); if (era === 'agora') for (let i = 0; i < 8; i++) P(cc, hash(i) * iw, hash(i + 1) * ih * .5, 2, 2, '#fff6c0'); }, e.legenda || (era === 'agora' ? 'O TRIO · DE NOVO' : 'O TRIO · PRA SEMPRE'));
      for (let i = 0; i < 10; i++) if (Math.sin(k * 5 + i * 1.9) > .6) { const x = 300 + hash(i) * 360, y = 80 + hash(i + 2) * 360; P(c, x, y - 6, 2, 14, '#fff3a8'); P(c, x - 6, y, 14, 2, '#fff3a8'); }
      c.restore();
    },
    pensamento(c, e, t) {
      const t0 = Number(e.t) || 0; if (t < t0 || t > t0 + (Number(e.dur) || 99)) return; const k = ease((t - t0) / .8), x = Number(e.x) || 520, y = Number(e.y) || 300;
      for (let i = 0; i < 3; i++) if (k > i * .2) circ(c, x + 30 + i * 26, y - 30 - i * 34, 6 + i * 4, '#f6f2e8');
      const bx = x + 150, by = y - 190, bw = 300 * k, bh = 160 * k; if (k < .3) return;
      c.save(); c.globalAlpha = Math.min(1, k * 1.4); for (let i = 0; i < 10; i++) { const a = i / 10 * TAU; circ(c, bx + Math.cos(a) * bw * .45, by + Math.sin(a) * bh * .42, 46 * k, '#f6f2e8', 34 * k); } circ(c, bx, by, bw * .46, '#f6f2e8', bh * .44);
      c.beginPath(); c.ellipse(bx, by, bw * .44, bh * .4, 0, 0, TAU); c.clip(); c.fillStyle = '#e8c890'; c.fillRect(bx - bw / 2, by - bh / 2, bw, bh); c.fillStyle = '#c8a468'; c.fillRect(bx - bw / 2, by + bh * .2, bw, bh);
      const quem = e.quem || ['crianca_daroca', 'crianca_reeis', 'crianca_jorge']; quem.forEach((q, i) => ator(c, q, bx - 80 + i * 80, by + bh * .32, { scale: 1, facing: i === 2 ? -1 : 1, frame: t * 2, moving: !!e.andando, emotion: 'friend' }));
      c.fillStyle = 'rgba(160,110,60,.25)'; c.fillRect(bx - bw / 2, by - bh / 2, bw, bh); c.restore();
    },
    neblina(c, e, t, { s }) { const f = Number(e.forca) || .5, tt = s.elapsed; for (let i = 0; i < 7; i++) { c.globalAlpha = f * .22; circ(c, ((tt * (8 + i * 3) + i * 190) % 1400) - 220, 300 + (i % 4) * 60, 220, '#e8eef4', 34); } c.globalAlpha = 1; },
    frio(c) { c.fillStyle = 'rgba(80,130,200,.14)'; c.fillRect(0, 0, W, H); for (const [cx, cy] of [[0, 24], [W, 24], [0, H - 20], [W, H - 20]]) for (let i = 0; i < 26; i++) { const a = hash(i + cx) * TAU, r = hash(i + cy) * 70; P(c, cx + Math.cos(a) * r, cy + Math.sin(a) * r, 2 + (i % 3) * 2, 2, '#e8f4ff'); } },
    estrelas(c, e, t, { s }) { const tt = s.elapsed; for (let i = 0; i < 60; i++) if (Math.sin(tt * (1 + hash(i) * 2) + i) > 0) P(c, hash(i + 7) * W, 30 + hash(i + 8) * 180, 2, 2, '#e8ecff'); },
    pb(c, e, t) { const t0 = Number(e.t) || 0, d = Number(e.dur) || 1.5; if (t < t0) return; desatura(c, clamp((t - t0) / d, 0, 1) * (Number(e.forca) || 1)); },
    flashback(c, e, t, { s }) { const tt = s.elapsed; c.fillStyle = 'rgba(170,120,60,.26)'; c.fillRect(0, 0, W, H); desatura(c, .35);
      const g = c.createRadialGradient(W / 2, H / 2, 180, W / 2, H / 2, 600); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(1, 'rgba(40,24,10,.6)'); c.fillStyle = g; c.fillRect(0, 0, W, H);
      for (let i = 0; i < 40; i++) P(c, hash(i + Math.floor(tt * 14)) * W, hash(i * 3 + Math.floor(tt * 14)) * H, 2, 2, 'rgba(255,240,210,.3)');
      if (hash(Math.floor(tt * 6)) > .6) P(c, hash(Math.floor(tt * 6) + 1) * W, 0, 2, H, 'rgba(255,240,210,.18)');
      c.save(); c.globalCompositeOperation = 'lighter'; c.fillStyle = `rgba(255,150,60,${.06 + .05 * Math.sin(tt * .7)})`; c.beginPath(); c.ellipse(80, 80, 260, 180, 0, 0, TAU); c.fill(); c.restore(); },
    vs(c, e, t, { win }) {
      const f = win(Number(e.dur) || 3.4); if (!f.on) return; const k = t - f.t0, a = Math.min(1, (f.t0 + f.d - t) / .35), cor = e.cor || '#e8433a';
      c.save(); c.globalAlpha = a; c.fillStyle = '#0c0e1a'; c.fillRect(0, 0, W, H);
      c.save(); c.beginPath(); c.moveTo(W / 2 + 60, 0); c.lineTo(W, 0); c.lineTo(W, H); c.lineTo(W / 2 - 60, H); c.clip(); c.fillStyle = cor; c.fillRect(0, 0, W, H); for (let i = -10; i < 30; i++) { c.fillStyle = 'rgba(0,0,0,.14)'; const x = ((i * 60 + k * 240) % 1800) - 400; c.beginPath(); c.moveTo(x, 0); c.lineTo(x + 30, 0); c.lineTo(x - 270, H); c.lineTo(x - 300, H); c.fill(); } c.restore();
      for (let i = 0; i < 30; i++) { const x = ((hash(i) * W - k * (400 + hash(i + 1) * 500)) % W + W) % W; P(c, x, hash(i + 2) * H, 40, 2, 'rgba(255,255,255,.18)'); }
      const ent = ease(k / .4), dl = (1 - ent) * -400, dr = (1 - ent) * 400;
      ator(c, 'daroca', 250 + dl, 470, { scale: 3.6, facing: 1, frame: k, emotion: 'taunted' });
      const vilao = String(e.vilao || 'c2_creuza'); if (vilao === 'gemeos') { ator(c, 'c2_ryan', 660 + dr, 470, { scale: 3, facing: -1, frame: k }); ator(c, 'c2_bryan', 800 + dr, 480, { scale: 3, facing: -1, frame: k + .5 }); } else ator(c, vilao, 720 + dr, 470, { scale: 3.6, facing: -1, frame: k });
      c.fillStyle = '#ffffff'; c.beginPath(); c.moveTo(W / 2 + 54, 0); c.lineTo(W / 2 + 66, 0); c.lineTo(W / 2 - 54, H); c.lineTo(W / 2 - 66, H); c.fill();
      const kv = clamp((k - .35) / .25, 0, 1); if (kv > 0) { const sc = 1 + (1 - kv) * 2.5; c.save(); c.translate(W / 2, 250); c.scale(sc, sc); c.globalAlpha = a * kv; txt(c, 'VS', 0, -28, '#ffe23a', { s: 10, sombra: '#2a0a0a' }); c.restore(); if (kv < 1) { c.fillStyle = `rgba(255,255,255,${(1 - kv) * .6})`; c.fillRect(0, 0, W, H); } }
      const kn = clamp((k - .6) / .3, 0, 1); c.globalAlpha = a * kn; P(c, 40, 470, 300, 46, '#0c0e1a'); txt(c, 'DA ROCA', 60, 480, '#ffffff', { s: 3, align: 'left' });
      const nome = String(e.nome || ''), tit = String(e.titulo || ''); P(c, W - 40 - Math.max(larg(nome, 4), larg(tit, 2)) - 30, 400, Math.max(larg(nome, 4), larg(tit, 2)) + 30, 100, '#0c0e1a'); txt(c, nome, W - 55, 412, '#ffffff', { s: 4, align: 'right' }); txt(c, tit, W - 55, 458, cor === '#ffffff' ? '#ffe23a' : '#ffe9b0', { s: 2, align: 'right' });
      c.restore();
    },
    poder(c, e, t, { win }) {
      const f = win(Number(e.dur) || 4.2); if (!f.on) return; const k = t - f.t0, a = Math.min(1, k / .3, (f.t0 + f.d - t) / .4), id = String(e.poder || 'fofoca'), info = (window.CampanhaPoderes?.lista?.() || []).find((p) => p.id === id) || { nome: id.toUpperCase(), cor: '#ffd24a' };
      c.save(); c.globalAlpha = a; c.fillStyle = 'rgba(8,8,16,.82)'; c.fillRect(0, 0, W, H);
      c.save(); c.translate(W / 2, 220); c.rotate(k * .4); for (let i = 0; i < 12; i++) { c.rotate(TAU / 12); c.fillStyle = info.cor + '33'; c.beginPath(); c.moveTo(0, 0); c.lineTo(40, -500); c.lineTo(-40, -500); c.fill(); } c.restore();
      const b = Math.sin(k * 3) * 6, sc = ease(k / .5); circ(c, W / 2, 220 + b, 70 * sc, info.cor + '55'); const img = icone(id); if (img.complete && img.naturalWidth) { c.imageSmoothingEnabled = false; c.drawImage(img, W / 2 - 64 * sc, 156 + b - 64 * (sc - 1), 128 * sc, 128 * sc); } else desenhaCoracao(c, W / 2, 220 + b, 12 * sc, 0, info.cor);
      if (k > .4) { txt(c, 'NOVO PODER!', W / 2, 330, '#ffe23a', { s: 4, sombra: '#2a1a0a' }); txt(c, info.nome, W / 2, 384, info.cor, { s: 3, sombra: '#0a0a10' }); }
      if (k > 1.1) txt(c, String(e.texto || 'GARRAFADA LIBERADA NA BANCA DO SEU LINDOMAR'), W / 2, 432, '#e8e2d0', { s: 2 });
      for (let i = 0; i < 16; i++) if (Math.sin(k * 6 + i * 1.3) > .5) { const x = W / 2 + Math.cos(i * 1.7 + k) * (120 + i * 6), y = 220 + Math.sin(i * 2.3 + k) * (80 + i * 4); P(c, x, y - 6, 2, 14, '#fff3a8'); P(c, x - 6, y, 14, 2, '#fff3a8'); }
      c.restore();
    },
    fim(c, e, t) {
      const t0 = Number(e.t) || 0; if (t < t0) return; const k = t - t0;
      c.fillStyle = `rgba(6,6,12,${Math.min(1, k / 1.2)})`; c.fillRect(0, 0, W, H);
      for (let i = 0; i < 26; i++) { const x = hash(i) * W + Math.sin(k * .5 + i) * 20, y = H - ((k * (16 + hash(i + 1) * 20) + hash(i + 2) * H) % H); c.globalAlpha = .5; P(c, x, y, 2, 2, i % 2 ? '#ffd27a' : '#e8f87a'); } c.globalAlpha = 1;
      const kf = clamp((k - 1) / 1.2, 0, 1); if (kf > 0) { c.save(); c.globalAlpha = kf; const sc = 1 + (1 - ease(kf)) * .3; c.translate(W / 2, 220); c.scale(sc, sc); txt(c, 'FIM', 0, -60, '#ffe9b0', { s: 16, sombra: '#3a1a0a' }); c.restore(); }
      const kc = clamp((k - 2.4) / .8, 0, 1); if (kc > 0) { const pul = 1 + Math.max(0, Math.sin(k * 7)) * .1; c.globalAlpha = kc; desenhaCoracao(c, W / 2, 330, 6 * pul, 0); txt(c, String(e.sub || 'O TRIO VOLTOU.'), W / 2, 380, '#e8e2d0', { s: 2 }); c.globalAlpha = 1; }
    },
    luz_final(c, e, t, { s }) { const tt = s.elapsed; c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 6; i++) { const x = 160 + i * 130 + Math.sin(tt * .3 + i) * 20; c.fillStyle = `rgba(255,214,140,${.07 + .03 * Math.sin(tt * .8 + i)})`; c.beginPath(); c.moveTo(x, 0); c.lineTo(x + 60, 0); c.lineTo(x - 60, H); c.lineTo(x - 160, H); c.fill(); } c.restore(); for (let i = 0; i < 30; i++) { const x = (hash(i) * W + Math.sin(tt * .4 + i) * 30), y = H - ((tt * (10 + hash(i + 1) * 16) + hash(i + 2) * H) % H); P(c, x, y, 2, 2, '#fff0c0'); } },
    barras(c, e, t) { const t0 = Number(e.t) || 0, k = ease((t - t0) / (Number(e.dur) || 1)), h = (Number(e.altura) || 60) * k; c.fillStyle = '#05060a'; c.fillRect(0, 0, W, 24 + h); c.fillRect(0, H - 20 - h, W, 20 + h); },
    flash_memoria(c, e, t, { win }) { const f = win(Number(e.dur) || .9); if (!f.on) return; const k = f.k; c.fillStyle = `rgba(255,248,230,${(1 - k) * .9})`; c.fillRect(0, 0, W, H); c.save(); c.globalAlpha = Math.sin(k * Math.PI) * .75; polaroid(c, Number(e.x) || 480, Number(e.y) || 250, 300, 300, Number(e.giro) || .06, (cc, iw, ih) => cenaFoto(cc, iw, ih, e.quem || ['crianca_daroca', 'crianca_reeis', 'crianca_jorge'], undefined, undefined, 1.4), e.legenda || ''); c.restore(); },
    chat(c, e, t) {
      const t0 = Number(e.t) || 0; if (t < t0 || t > t0 + (Number(e.dur) || 99)) return; const msgs = Array.isArray(e.mensagens) ? e.mensagens : [], X = Number(e.x) || 760, Y = 70;
      P(c, X - 130, Y, 260, 400, '#14161c'); P(c, X - 122, Y + 10, 244, 380, '#e8e2d8'); P(c, X - 122, Y + 10, 244, 40, '#2c5a9e'); txt(c, String(e.titulo || 'GRUPO'), X, Y + 24, '#ffffff', { s: 2 });
      let y = Y + 64; msgs.forEach((m) => { const tm = t0 + (Number(m.t) || 0); if (t < tm) return; const eu = !!m.eu, s2 = String(m.texto || ''), linhas = []; let lin = ''; for (const w2 of s2.split(' ')) { if ((lin + ' ' + w2).trim().length > 18) { linhas.push(lin); lin = w2; } else lin = (lin + ' ' + w2).trim(); } linhas.push(lin);
        const bw = Math.max(...linhas.map((l) => larg(l, 1))) + 20, bh = linhas.length * 10 + 18, bx = eu ? X + 112 - bw : X - 112, pop = ease((t - tm) / .2);
        c.save(); c.translate(bx + bw / 2, y + bh / 2); c.scale(pop, pop); P(c, -bw / 2, -bh / 2, bw, bh, eu ? '#c8f0b0' : '#ffffff'); txt(c, String(m.de || '').toUpperCase(), -bw / 2 + 8, -bh / 2 + 4, eu ? '#3a7a2a' : '#c43c3a', { align: 'left' }); linhas.forEach((l, i) => txt(c, l, -bw / 2 + 8, -bh / 2 + 14 + i * 10, '#1c1c1c', { align: 'left' })); c.restore(); y += bh + 8; });
    }
  };

  /* =====================================================================
     ANIMAÇÕES EXTRAS (por cima ou em volta do personagem)
     ===================================================================== */
  const cab = (x) => { const S = x.o.scale || 1, alt = (220 - (x.head?.top ?? 150)) * S, fx = x.o.facing < 0 ? -1 : 1; return { S, alt, fx, topo: x.y - alt, olhoX: x.x + fx * ((x.head ? x.head.cx - 100 : 0) * S + 5 * S), olhoY: x.y - alt + 13 * S, boca: x.y - alt + 20 * S }; };
  const anims = {
    chorando: { depois(w, x) { const h = cab(x); w.fillStyle = '#8ad0ff'; w.fillRect(Math.round(h.olhoX), Math.round(h.olhoY + 2 * h.S), 2, Math.round(9 * h.S)); for (let k = 0; k < 2; k++) { const q = (x.t * 1.3 + k * .5) % 1; w.globalAlpha = 1 - q; w.fillRect(Math.round(h.olhoX + h.fx * 2), Math.round(h.olhoY + 10 * h.S + q * 50 * h.S), 2, 4); } w.globalAlpha = 1; } },
    frio: { antes(w, x) { w.save(); w.translate(Math.round(Math.sin(x.t * 55) * 1.4), 0); }, depois(w, x) { w.restore(); const h = cab(x); for (let k = 0; k < 3; k++) { const q = (x.t * .7 + k / 3) % 1; w.globalAlpha = (1 - q) * .7; circ(w, h.olhoX + h.fx * (8 + q * 26) * h.S, h.boca - q * 18 * h.S, (2 + q * 8) * h.S, '#f4f8ff'); } w.globalAlpha = 1; } },
    treme: { antes(w, x) { w.save(); w.translate(Math.round(Math.sin(x.t * 47) * 2), Math.round(Math.cos(x.t * 31))); }, depois(w) { w.restore(); } },
    deitado: { antes(w, x) { w.save(); w.translate(x.x, x.y); w.rotate(Math.PI / 2 * (x.o.facing < 0 ? -1 : 1)); w.translate(-x.x, -x.y); }, depois(w, x) { w.restore(); const h = cab(x), d = x.o.facing < 0 ? -1 : 1, L = h.alt * .62, x0 = d > 0 ? x.x - 4 : x.x - L + 4; for (let i = 0; i < L; i += 4) for (let j = 0; j < 22; j += 4) P(w, x0 + i, x.y - 2 + j, 4, 4, ((i + j) / 4) % 2 ? '#b83a3a' : '#8a2424'); P(w, x0, x.y - 2, L, 2, '#d85a4a'); } },
    // Da Roça deitado no chão, agarrado nas pernas de quem está na frente (é arrastado junto quando a pessoa sacode)
    agarra_pernas: {
      cabeca: (x) => ({ x: x.x + (x.facing < 0 ? -1 : 1) * x.alto * .82, y: x.y - 14 }),
      antes(w, x) { const d = x.o.facing < 0 ? -1 : 1, puxa = Math.sin(x.t * 7) * 3 + Math.sin(x.t * 13) * 1.5; w.save(); w.translate(Math.round(puxa), 0); w.save(); w.translate(x.x, x.y); w.rotate(Math.PI / 2 * d); w.translate(-x.x, -x.y); },
      depois(w, x) { w.restore(); const h = cab(x), d = h.fx, ombro = x.x + d * h.alt * .62, ponta = x.x + d * (h.alt + 10 * h.S), pele = x.a.opts?.pele || '#c68a5e', manga = x.a.opts?.manga || '#d8823a';
        for (const [k, dy] of [[0, 6], [1, 13]]) { const yy = x.y + dy * h.S - (k ? Math.round(Math.sin(x.t * 9) * 1) : 0); P(w, Math.min(ombro, ponta), yy, Math.abs(ponta - ombro), 5 * h.S, manga); P(w, ponta - (d < 0 ? 6 * h.S : 0), yy - h.S, 7 * h.S, 7 * h.S, pele); P(w, ponta - (d < 0 ? 6 * h.S : 0), yy - h.S, 7 * h.S, 2, '#e8b088'); }
        for (let k = 0; k < 4; k++) { const q = (x.t * 1.4 + k / 4) % 1; w.globalAlpha = (1 - q) * .5; circ(w, x.x + d * (k * 14) - d * q * 20, x.y - 2 - q * 10, 4 + q * 6, '#d8d0c0', 2 + q * 2); } w.globalAlpha = 1; w.restore(); } },
    // quem está sendo agarrado: balança, puxa a perna e chuta o ar tentando se soltar
    sacudindo: {
      antes(w, x) { const ang = Math.sin(x.t * 7) * .1 + Math.sin(x.t * 13) * .04, dx = Math.sin(x.t * 7) * 3 + Math.sin(x.t * 13) * 1.5; w.save(); w.translate(Math.round(dx), Math.round(-Math.abs(Math.sin(x.t * 7)) * 3)); w.translate(x.x, x.y); w.rotate(ang); w.translate(-x.x, -x.y); },
      depois(w, x) { w.restore(); const h = cab(x); for (let k = 0; k < 3; k++) { const q = (x.t * 2 + k / 3) % 1; w.globalAlpha = (1 - q) * .8; P(w, x.x - h.fx * (14 + q * 16) * h.S, x.y - h.alt * (.3 + k * .2), 10 * h.S * (1 - q), 2, '#ffffff'); P(w, x.x + h.fx * (14 + q * 16) * h.S, x.y - h.alt * (.4 + k * .18), 10 * h.S * (1 - q), 2, '#ffffff'); } w.globalAlpha = 1;
        const q = (x.t * 1.1) % 1; P(w, x.x - h.fx * 8 * h.S, h.topo + 4 + q * 16, 4, 6, '#8ad0ff'); } },
    ajoelhado: { antes(w, x) { w.save(); w.translate(x.x, x.y); w.scale(1.06, .76); w.translate(-x.x, -x.y); }, depois(w) { w.restore(); } },
    celular: { depois(w, x) { const h = cab(x); P(w, h.olhoX + h.fx * 2 * h.S - (h.fx < 0 ? 6 * h.S : 0), h.olhoY - 2 * h.S, 6 * h.S, 12 * h.S, '#1c1e24'); P(w, h.olhoX + h.fx * 3 * h.S - (h.fx < 0 ? 5 * h.S : 0), h.olhoY, 4 * h.S, 8 * h.S, '#5a8ad0'); } },
    celular_mao: { depois(w, x) { const h = cab(x), px = x.x + h.fx * 10 * h.S, py = x.y - h.alt * .55; P(w, px - 4 * h.S, py, 8 * h.S, 12 * h.S, '#1c1e24'); P(w, px - 3 * h.S, py + h.S, 6 * h.S, 9 * h.S, Math.floor(x.t * 3) % 2 ? '#8ab8ff' : '#5a8ad0'); w.save(); w.globalCompositeOperation = 'lighter'; w.fillStyle = 'rgba(120,170,255,.12)'; w.fillRect(px - 20 * h.S, h.topo, 40 * h.S, 30 * h.S); w.restore(); } },
    zzz: { depois(w, x) { const h = cab(x), deit = String(x.a.anim).includes('deitado'), bx = deit ? x.x + h.fx * h.alt * .85 : h.olhoX + 10, by = deit ? x.y - 30 : h.topo - 10; for (let k = 0; k < 3; k++) { const q = (x.t * .5 + k / 3) % 1; w.globalAlpha = Math.sin(q * Math.PI); txt(w, 'Z', bx + q * 30, by - q * 50, '#e8ecff', { s: 2 + k % 2 }); } w.globalAlpha = 1; } },
    exclama: { depois(w, x) { const h = cab(x), pop = Math.min(1, x.t * 6), y = h.topo - 30 * pop; P(w, x.x - 10, y - 30, 20, 32, '#fff6dc'); P(w, x.x - 3, y - 26, 6, 16, '#e8433a'); P(w, x.x - 3, y - 6, 6, 6, '#e8433a'); } },
    pergunta: { depois(w, x) { const h = cab(x), y = h.topo - 30 + Math.sin(x.t * 3) * 3; txt(w, '?', x.x, y - 24, '#ffe23a', { s: 4, sombra: '#2a1a0a' }); } },
    raiva: { depois(w, x) { const h = cab(x), pul = Math.sin(x.t * 10) > 0 ? 1 : 0, cx = x.x + h.fx * 10 * h.S, cy = h.topo - 2; for (const [dx, dy] of [[-1, -1], [1, -1], [-1, 1], [1, 1]]) P(w, cx + dx * (4 + pul), cy + dy * (4 + pul), 6, 6, '#e8433a'); } },
    suor: { depois(w, x) { const h = cab(x), q = (x.t * .8) % 1; P(w, x.x - h.fx * 8 * h.S, h.topo + 4 + q * 20, 4, 6, '#8ad0ff'); P(w, x.x - h.fx * 8 * h.S + 1, h.topo + 2 + q * 20, 2, 2, '#8ad0ff'); } },
    coracao: { depois(w, x) { const h = cab(x); desenhaCoracao(w, x.x, h.topo - 22 + Math.sin(x.t * 3) * 4, 3 * (1 + Math.max(0, Math.sin(x.t * 6)) * .15), 0); } },
    coracao_partido: { depois(w, x) { const h = cab(x), y = h.topo - 22; desenhaCoracao(w, x.x - 4, y, 3, -1, '#a83030'); desenhaCoracao(w, x.x + 4, y + 2, 3, 1, '#a83030'); } },
    brilho: { antes(w, x) { const h = cab(x); w.save(); w.globalCompositeOperation = 'lighter'; const g = w.createRadialGradient(x.x, x.y - h.alt / 2, 4, x.x, x.y - h.alt / 2, h.alt); g.addColorStop(0, `rgba(255,220,120,${.35 + Math.sin(x.t * 4) * .1})`); g.addColorStop(1, 'rgba(255,220,120,0)'); w.fillStyle = g; w.fillRect(x.x - h.alt, x.y - h.alt * 1.6, h.alt * 2, h.alt * 2); w.restore(); }, depois(w, x) { const h = cab(x); for (let i = 0; i < 6; i++) if (Math.sin(x.t * 5 + i * 2) > .5) { const a = i * 1.1 + x.t, r = h.alt * .6; P(w, x.x + Math.cos(a) * r, x.y - h.alt / 2 + Math.sin(a) * r, 2, 6, '#fff3a8'); } } },
    chama: { antes(w, x) { const h = cab(x); for (let i = 0; i < 14; i++) { const q = (x.t * 1.6 + i / 14) % 1, px = x.x + (hash(i) - .5) * 30 * h.S, py = x.y - q * h.alt * 1.2; w.globalAlpha = (1 - q) * .7; P(w, px, py, 4 * h.S, 6 * h.S, q < .4 ? '#ffd23a' : q < .7 ? '#f08a24' : '#c43c3a'); } w.globalAlpha = 1; } },
    mao: { depois(w, x) { const h = cab(x), y = x.y - h.alt * .56, x0 = x.x + h.fx * 4 * h.S, k = Math.min(1, x.t * 1.5), x1 = x0 + h.fx * 22 * h.S * k, pele = x.a.opts?.pele || '#c68a5e'; P(w, Math.min(x0, x1), y, Math.abs(x1 - x0) + 2, 6 * h.S, x.a.opts?.manga || '#a8704a'); P(w, x1 - (h.fx < 0 ? 6 * h.S : 0), y - h.S, 7 * h.S, 8 * h.S, pele); } },
    silhueta: { antes(w) { w.save(); w.filter = 'brightness(0.1) saturate(0)'; }, depois(w) { w.restore(); } },
    fantasma: { antes(w) { w.save(); w.globalAlpha = .5; }, depois(w) { w.restore(); } }
  };

  /* =====================================================================
     SONS (sintetizados)
     ===================================================================== */
  const sons = {
    vibrar: ({ tone }) => { for (let i = 0; i < 3; i++) tone(70, 68, .22, 'sawtooth', i * .3, .9); },
    toque: ({ tone }) => { [659, 784, 988, 784, 659, 523].forEach((f, i) => tone(f, f, .16, 'sine', i * .17, .8)); },
    coracao: ({ tone }) => { tone(70, 40, .18, 'sine', 0, 1.6); tone(64, 36, .2, 'sine', .22, 1.3); },
    quebra: ({ tone, noise }) => { noise(.5, .9, 0, 2400); tone(1800, 600, .3, 'square', 0, .3); for (let i = 0; i < 5; i++) tone(2400 - i * 300, 1600 - i * 200, .08, 'triangle', .1 + i * .06, .4); },
    aviao: ({ noise, tone }) => { noise(2.6, .8, 0, 300); tone(180, 420, 2.4, 'sawtooth', 0, .18); },
    vento: ({ noise }) => { noise(2.2, .6, 0, 600); },
    desliga: ({ tone }) => { tone(480, 480, .18, 'sine'); tone(380, 380, .18, 'sine', .22); tone(300, 300, .3, 'sine', .44); },
    vs: ({ tone, noise }) => { tone(90, 40, .5, 'square', 0, 1.4); noise(.4, 1); tone(880, 440, .3, 'sawtooth', .05, .4); },
    poder: ({ tone }) => { [523, 659, 784, 1046, 1318].forEach((f, i) => tone(f, f * 1.01, .22, 'square', i * .09, .7)); tone(1568, 1568, .6, 'sine', .5, .6); },
    abraco: ({ tone }) => { [349, 440, 523, 698].forEach((f, i) => tone(f, f, 1.8, 'sine', i * .04, .5)); },
    digitar: ({ noise }) => { for (let i = 0; i < 6; i++) noise(.03, .5, i * .09 + (i % 2) * .03, 2000); },
    soluco: ({ tone }) => { tone(330, 260, .25, 'triangle', 0, .6); tone(300, 220, .3, 'triangle', .35, .5); }
  };

  /* =====================================================================
     TRILHA SINTETIZADA (músicas originais, em loop enquanto a cutscene pede)
     ===================================================================== */
  const NOTA = (n) => { if (!n) return 0; const m = /^([A-G])(#|b)?(\d)$/.exec(n); if (!m) return 0; const i = { C: -9, D: -7, E: -5, F: -4, G: -2, A: 0, B: 2 }[m[1]] + (m[2] === '#' ? 1 : m[2] === 'b' ? -1 : 0) + (Number(m[3]) - 4) * 12; return 440 * Math.pow(2, i / 12); };
  const AC = (s) => s.split(' ');
  const TRILHAS = {
    saudade: { bpm: 66, timbre: 'sine', arp: 'triangle', vol: .9, bat: null, comp: [
      [AC('A3 C4 E4'), 'A2', ['E5', 0, 'D5', 'C5', 'B4', 0, 'C5', 0]], [AC('F3 A3 C4'), 'F2', ['A4', 0, 0, 'C5', 'E5', 0, 'D5', 0]], [AC('C4 E4 G4'), 'C3', ['G4', 0, 'E5', 'D5', 'C5', 0, 'B4', 0]], [AC('G3 B3 D4'), 'G2', ['D5', 0, 0, 'B4', 'G4', 0, 0, 0]],
      [AC('A3 C4 E4'), 'A2', ['E5', 0, 'G5', 'E5', 'D5', 0, 'C5', 0]], [AC('F3 A3 C4'), 'F2', ['C5', 0, 'D5', 'E5', 'F5', 0, 'E5', 0]], [AC('C4 E4 G4'), 'C3', ['E5', 0, 'D5', 'C5', 'G4', 0, 'A4', 0]], [AC('E3 G#3 B3'), 'E2', ['B4', 0, 0, 0, 'G#4', 0, 0, 0]]] },
    flashback: { bpm: 92, timbre: 'sine', arp: 'sine', sino: true, vol: .8, bat: null, comp: [
      [AC('C5 E5 G5'), 'C3', ['E6', 0, 0, 0, 'D6', 0, 'C6', 0]], [AC('A4 C5 E5'), 'A2', ['C6', 0, 0, 0, 'B5', 0, 'A5', 0]], [AC('F4 A4 C5'), 'F2', ['A5', 0, 'C6', 0, 'F6', 0, 'E6', 0]], [AC('G4 B4 D5'), 'G2', ['D6', 0, 0, 0, 'G5', 0, 0, 0]]] },
    tensao: { bpm: 58, timbre: 'triangle', arp: null, drone: true, vol: .9, bat: 'k.k.....', comp: [
      [AC('D3 F3 A3'), 'D2', [0, 0, 0, 0, 'A4', 0, 'Bb4', 0]], [AC('D3 F3 Bb3'), 'D2', [0, 0, 0, 0, 'A4', 0, 0, 0]], [AC('C3 E3 G3'), 'C2', [0, 0, 0, 0, 'G4', 0, 'F4', 0]], [AC('Db3 F3 A3'), 'Db2', [0, 0, 0, 0, 'E4', 0, 0, 0]]] },
    vilao: { bpm: 136, timbre: 'square', arp: null, riff: true, vol: .7, bat: 'k.h.s.hk', comp: [
      [AC('E3 G3 B3'), 'E2', ['E5', 0, 'G5', 'E5', 0, 'B4', 'D5', 'E5']], [AC('C3 E3 G3'), 'C2', ['E5', 0, 'G5', 'A5', 0, 'G5', 'E5', 0]], [AC('D3 F#3 A3'), 'D2', ['F#5', 0, 'A5', 'F#5', 0, 'D5', 'E5', 'F#5']], [AC('B2 D#3 F#3'), 'B1', ['D#5', 0, 'F#5', 'B5', 0, 'A5', 'F#5', 'D#5']]] },
    conquista: { bpm: 108, timbre: 'square', arp: 'triangle', pizz: true, vol: .6, bat: 'k.h.k.h.', comp: [
      [AC('C4 E4 G4'), 'C3', ['C5', 'E5', 'G5', 'E5', 'C5', 0, 'G4', 0]], [AC('F3 A3 C4'), 'F2', ['A4', 'C5', 'F5', 'C5', 'A4', 0, 'F4', 0]], [AC('G3 B3 D4'), 'G2', ['B4', 'D5', 'G5', 'D5', 'B4', 0, 'A4', 'B4']], [AC('C4 E4 G4'), 'C3', ['C5', 0, 'G4', 0, 'C5', 0, 0, 0]]] },
    final: { bpm: 70, timbre: 'sine', arp: 'triangle', pad: true, vol: 1, bat: null, comp: [
      [AC('F3 A3 C4'), 'F2', ['A4', 0, 'C5', 0, 'F5', 0, 'E5', 0]], [AC('C3 E3 G3'), 'C2', ['E5', 0, 'D5', 0, 'C5', 0, 'G4', 0]], [AC('D3 F3 A3'), 'D2', ['F4', 0, 'A4', 0, 'D5', 0, 'C5', 0]], [AC('Bb2 D3 F3'), 'Bb1', ['D5', 0, 'C5', 'Bb4', 'A4', 0, 'G4', 0]],
      [AC('F3 A3 C4'), 'F2', ['A4', 0, 'C5', 0, 'F5', 0, 'G5', 0]], [AC('C3 E3 G3'), 'C2', ['G5', 0, 'E5', 0, 'C5', 0, 'E5', 0]], [AC('Bb2 D3 F3'), 'Bb1', ['F5', 0, 'D5', 0, 'Bb4', 0, 'D5', 0]], [AC('C3 E3 G3'), 'C2', ['E5', 0, 0, 0, 'C5', 0, 0, 0]]] }
  };
  const musica = (() => {
    let ac = null, master = null, atual = null, prox = 0, passo = 0, timer = 0, ultimo = 0;
    const ligado = () => !(window.Game?.soundOn && !window.Game.soundOn() && !window.__somCutscene);
    function nota(f, t0, dur, tipo, vol, o = {}) { if (!f) return; const osc = ac.createOscillator(), g = ac.createGain(); osc.type = tipo; osc.frequency.setValueAtTime(f, t0); if (o.vib) { const l = ac.createOscillator(), lg = ac.createGain(); l.frequency.value = 5; lg.gain.value = f * .006; l.connect(lg); lg.connect(osc.frequency); l.start(t0); l.stop(t0 + dur + .1); }
      const at = o.at ?? .02; g.gain.setValueAtTime(0, t0); g.gain.linearRampToValueAtTime(vol, t0 + at); g.gain.exponentialRampToValueAtTime(Math.max(.0001, vol * (o.sus ?? .5)), t0 + Math.max(at + .01, dur * .6)); g.gain.exponentialRampToValueAtTime(.0001, t0 + dur + (o.rel ?? .25));
      let n = osc; if (o.lp) { const fl = ac.createBiquadFilter(); fl.type = 'lowpass'; fl.frequency.value = o.lp; osc.connect(fl); n = fl; } n.connect(g); g.connect(master); osc.start(t0); osc.stop(t0 + dur + (o.rel ?? .25) + .05); }
    function ruido(t0, dur, vol, hp) { const len = Math.floor(ac.sampleRate * dur), b = ac.createBuffer(1, len, ac.sampleRate), d = b.getChannelData(0); for (let i = 0; i < len; i++) d[i] = (Math.random() * 2 - 1) * (1 - i / len); const s = ac.createBufferSource(), g = ac.createGain(), f = ac.createBiquadFilter(); f.type = 'highpass'; f.frequency.value = hp; s.buffer = b; g.gain.value = vol; s.connect(f); f.connect(g); g.connect(master); s.start(t0); }
    function agendar() {
      const tr = TRILHAS[atual]; if (!tr) return; const dt = 60 / tr.bpm / 2;
      while (prox < ac.currentTime + .25) {
        const bar = tr.comp[Math.floor(passo / 8) % tr.comp.length], [acorde, baixo, mel] = bar, i = passo % 8, t0 = prox;
        if (i === 0) { nota(NOTA(baixo), t0, dt * (tr.riff ? 1 : 7), 'triangle', .26, { at: .03, lp: 600 }); if (tr.pad || tr.drone) for (const n of acorde) nota(NOTA(n), t0, dt * 8, 'sawtooth', tr.drone ? .05 : .035, { at: dt * 2, lp: tr.drone ? 500 : 900, sus: .9, rel: 1 }); }
        if (tr.riff) nota(NOTA(baixo) * (i % 2 ? 2 : 1), t0, dt * .8, 'square', .08, { at: .005, lp: 1200, sus: .3 });
        if (tr.arp) { const n = acorde[(i % 4 === 3 ? 1 : i % 4) % acorde.length]; nota(NOTA(n) * (tr.sino ? 2 : 1), t0, dt * (tr.pizz ? .5 : 1.6), tr.arp, tr.sino ? .07 : .08, { at: .005, sus: .3, rel: tr.sino ? .9 : .3 }); }
        if (mel[i]) { let d = 1; while (i + d < 8 && !mel[i + d]) d++; nota(NOTA(mel[i]), t0, dt * d * (tr.pizz ? .55 : .95), tr.timbre, tr.timbre === 'square' ? .06 : .14, { at: tr.pizz ? .005 : .04, vib: !tr.pizz && tr.timbre === 'sine', sus: .6, rel: .4, lp: tr.timbre === 'square' ? 2400 : 0 }); if (tr.pad) nota(NOTA(mel[i]) / 2, t0, dt * d, 'triangle', .05, { at: .05 }); }
        const b = tr.bat?.[i]; if (b === 'k') nota(90, t0, .14, 'sine', .5, { at: .002, sus: .1, rel: .05 }); else if (b === 's') ruido(t0, .14, .25, 1500); else if (b === 'h') ruido(t0, .04, .12, 6000);
        prox += dt; passo++;
      }
    }
    function tocar(id) {
      if (id === atual) return; parar(.9); if (!id || !TRILHAS[id] || !ligado()) return;
      try { ac = ac || new (window.AudioContext || window.webkitAudioContext)(); if (ac.state === 'suspended') ac.resume(); } catch (e) { return; }
      master = ac.createGain(); const vol = .5 * (TRILHAS[id].vol || 1) * (window.DarocaAudio?.music?.() ?? 1); master.gain.setValueAtTime(0, ac.currentTime); master.gain.linearRampToValueAtTime(vol, ac.currentTime + 1.2);
      const eco = ac.createDelay(); eco.delayTime.value = .28; const fb = ac.createGain(); fb.gain.value = .28; const sai = ac.createGain(); sai.gain.value = .7; master.connect(sai); sai.connect(ac.destination); master.connect(eco); eco.connect(fb); fb.connect(eco); eco.connect(ac.destination);
      atual = id; passo = 0; prox = ac.currentTime + .08; clearInterval(timer); timer = setInterval(agendar, 60); agendar();
    }
    function parar(fade = .8) { if (!master) { atual = null; return; } const m = master; try { m.gain.cancelScheduledValues(ac.currentTime); m.gain.setValueAtTime(m.gain.value, ac.currentTime); m.gain.linearRampToValueAtTime(0, ac.currentTime + fade); setTimeout(() => { try { m.disconnect(); } catch (e) {} }, fade * 1000 + 200); } catch (e) {} master = null; atual = null; clearInterval(timer); }
    setInterval(() => { if (atual && performance.now() - ultimo > 700) parar(1.2); }, 300);
    return { tocar, parar, quadro: () => { ultimo = performance.now(); }, atual: () => atual, lista: () => Object.keys(TRILHAS) };
  })();
  const gancho = {
    quadro(s, sc, shot) {
      musica.quadro(); if (!sc?.raw || !/^c2_/.test(sc.id)) return;
      if (shot.scene === 14 || shot.scene === 16) { const quer = !!shot.raw?.engarrafamento; try { if (window.CampanhaCamadas?.engarrafado?.(shot.scene) !== quer) window.CampanhaCamadas?.engarrafamento?.(shot.scene, quer); } catch (e) {} } // nada de buzinaço no meio da cena
      let quer = sc.raw.trilha ?? null; for (const sh of sc.shots) { if (sh.index > shot.index) break; if (sh.raw && Object.prototype.hasOwnProperty.call(sh.raw, 'trilha')) quer = sh.raw.trilha; }
      if (window.GameMusic?.isPlaying?.()) quer = null; musica.tocar(quer);
    }
  };

  window.Roteiro.estender({ cenarios, nomes, fundos, efeitos, anims, sons, gancho });
  setTimeout(() => { try { for (const p of window.CampanhaPoderes?.lista?.() || []) icone(p.id); } catch (e) {} }, 400); // ícones dos poderes já carregados

  /* =====================================================================
     GALERIA (para assistir no visualizador ?cenarios2)
     ===================================================================== */
  const ORDEM = ['c2_abertura', 'c2_aeroporto', 'c2_voo', 'c2_chegada', 'c2_primeira_noite', 'c2_vilao_creuza', 'c2_derrota_creuza', 'c2_vilao_tonhao', 'c2_derrota_tonhao', 'c2_vilao_valdomiro', 'c2_derrota_valdomiro', 'c2_vilao_kaua', 'c2_derrota_kaua', 'c2_vilao_barao', 'c2_derrota_barao', 'c2_vilao_breno', 'c2_derrota_breno', 'c2_vilao_gemeos', 'c2_derrota_gemeos', 'c2_vilao_fred', 'c2_derrota_fred', 'c2_centro', 'c2_final', 'c2_creditos'];
  let gal = null, tocando = null;
  const aberta = () => !!(gal && !gal.hidden) || !!(tocando && tocando.isConnected);
  function galeria() {
    if (!gal) { gal = document.createElement('div'); gal.className = 'c2-galeria'; gal.hidden = true; document.body.appendChild(gal);
      const st = document.createElement('style'); st.textContent = `.c2-galeria{position:fixed;inset:0;z-index:2147483400;background:#0b0d14ee;font-family:Pixel,monospace;color:#f6ead0;display:flex;flex-direction:column;align-items:center;padding:20px;overflow:auto}.c2-galeria[hidden]{display:none}.c2-galeria h2{font-size:16px;color:#ffd98a;margin:6px 0 4px}.c2-galeria p{font-size:9px;color:#c8b48a;margin:0 0 14px;text-align:center;max-width:620px;line-height:1.6}.c2-galeria .g{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:8px;width:min(900px,96vw)}.c2-galeria button{font:inherit;font-size:10px;text-align:left;padding:10px 12px;background:#2a1e14;color:#f6ead0;border:3px solid #8a6a3a;box-shadow:0 4px 0 #120c08;cursor:pointer;line-height:1.5}.c2-galeria button:hover,.c2-galeria button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.c2-galeria button small{display:block;font-size:8px;opacity:.75}.c2-galeria .x{position:fixed;top:12px;right:14px;text-align:center}`; document.head.appendChild(st); }
    const lista = ORDEM.filter((id) => window.Roteiro.has(id)).concat(window.Roteiro.list().filter((id) => /^c2_/.test(id) && !ORDEM.includes(id)));
    gal.innerHTML = `<button type="button" class="x">✕ FECHAR</button><h2>CUTSCENES · CAMPANHA 2</h2><p>Clique numa cutscene para assistir. Clique ou Enter avança as falas, Esc volta. A trilha e os sons tocam aqui mesmo com o som do jogo desligado.</p><div class="g"></div>`;
    const g = gal.querySelector('.g'); for (const id of lista) { const sc = window.Roteiro.get(id), b = document.createElement('button'); b.type = 'button'; b.innerHTML = `${(sc?.title || id).replace(/[<>&]/g, '')}<small>${sc ? sc.beats.length + ' falas · ~' + Math.round(sc.duration) + ' s' : ''}</small>`; b.addEventListener('click', () => { window.__somCutscene = true; const antes = new Set(document.querySelectorAll('body > canvas')); window.Roteiro.preview(id); for (const cv of document.querySelectorAll('body > canvas')) if (!antes.has(cv)) { cv.style.zIndex = '2147483500'; tocando = cv; } }); g.appendChild(b); }
    if (!lista.length) g.innerHTML = '<p>Os roteiros ainda estão carregando...</p>';
    gal.querySelector('.x').addEventListener('click', () => { gal.hidden = true; window.__somCutscene = false; musica.parar(); });
    gal.hidden = false;
  }
  window.CampanhaCutscenes = Object.freeze({ galeria, aberta, ordem: () => ORDEM.slice(), musica: { tocar: musica.tocar, parar: musica.parar, lista: musica.lista }, efeitos: () => Object.keys(efeitos), fundos: () => Object.keys(fundos), anims: () => Object.keys(anims) });
})();
