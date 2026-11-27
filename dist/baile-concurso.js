/* Concurso da Fantasia do baile funk (Campanha 1): minijogo de ritmo do MC Batidão.
   Setas caem nas quatro trilhas; aperte ← ↓ ↑ → (ou A S W D, ou os botões na tela) quando chegarem na linha.
   Nota 70% ou mais ganha a fantasia DA JEGUE. Esc ou DESISTIR sai sem perder nada.
   API: BaileConcurso.abrir({ onFim(ok, nota) }), BaileConcurso.aberto(). Sem save: quem decide o prêmio é a campanha. */
(() => {
  'use strict';
  if (window.BaileConcurso) return;
  const LW = 480, LH = 270, BPM = 128, BEAT = 60 / BPM, DURACAO = 30, LINHA = 214, VEL = 150, META = 70;
  const CORES = ['#ff4fa8', '#3fe0ff', '#5dff9a', '#ffd24a'], SETAS = ['←', '↓', '↑', '→'];
  const TECLAS = { ArrowLeft: 0, KeyA: 0, ArrowDown: 1, KeyS: 1, ArrowUp: 2, KeyW: 2, ArrowRight: 3, KeyD: 3 };
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const lx = (i) => 300 + i * 40, TAU = Math.PI * 2;
  let box = null, cv = null, ctx = null, raf = 0, jogo = null, aoFim = null, audio = null, cfg = {};
  // o mesmo motor serve para outras disputas no ritmo (ex.: a batalha de rima do Freddy): cfg muda título, rival, prêmio e versos
  const PADRAO = { titulo: 'CONCURSO DA FANTASIA', rival: 'mc_batidao', premio: 'DA JEGUE', premioLook: 'dajegue', ganhou: 'O BAILE GRITOU: DA JEGUE!', perdeu: 'FALTOU POUCO!', versos: null };

  function mapa() { // o "tamborzão": notas nos tempos e contratempos, com trilhas que dançam em padrões
    const notas = []; let seed = 7; const rnd = () => ((seed = (seed * 9301 + 49297) % 233280) / 233280);
    for (let b = 4; b < DURACAO / BEAT - 2; b++) {
      const t = b * BEAT, compasso = Math.floor(b / 8);
      notas.push({ t, lane: (b + compasso) % 4 === 0 ? 0 : Math.floor(rnd() * 4) });
      if (compasso % 2 === 1 && b % 2 === 1 && rnd() < .55) notas.push({ t: t + BEAT / 2, lane: Math.floor(rnd() * 4) });
      if (b % 16 === 15) notas.push({ t, lane: (notas[notas.length - 1].lane + 2) % 4 });
    }
    return notas.sort((a, b) => a.t - b.t).map((n) => ({ ...n, ok: null }));
  }
  function som(f, d = .07, tipo = 'square', vol = .03) {
    try { if (!window.Game?.soundOn?.()) return; audio = audio || new (window.AudioContext || window.webkitAudioContext)(); const o = audio.createOscillator(), g = audio.createGain(); o.type = tipo; o.frequency.value = f; g.gain.setValueAtTime(vol, audio.currentTime); g.gain.exponentialRampToValueAtTime(.0001, audio.currentTime + d); o.connect(g); g.connect(audio.destination); o.start(); o.stop(audio.currentTime + d); } catch (e) {}
  }
  function apertar(lane) {
    if (!jogo || jogo.fim) return; jogo.trilha[lane] = .18;
    let melhor = null, dist = 1; for (const n of jogo.notas) { if (n.ok !== null || n.lane !== lane) continue; const d = Math.abs(n.t - jogo.t); if (d < dist) { dist = d; melhor = n; } }
    if (melhor && dist <= .16) { (jogo.acerto = jogo.acerto || [0, 0, 0, 0])[lane] = .3; melhor.ok = dist <= .06 ? 1 : .7; jogo.combo++; jogo.melhorCombo = Math.max(jogo.melhorCombo, jogo.combo); jogo.msg = dist <= .06 ? 'PERFEITO!' : 'BOM!'; jogo.msgT = .45; jogo.pulo = .25; som(dist <= .06 ? 880 : 660); }
    else { jogo.combo = 0; jogo.msg = 'FORA DO RITMO'; jogo.msgT = .35; som(150, .08, 'sawtooth', .02); }
  }
  function nota() { const n = jogo.notas; return Math.round(n.reduce((s, x) => s + (x.ok || 0), 0) / n.length * 100); }
  function parcial() { const n = jogo.notas.filter((x) => x.ok !== null); return n.length ? Math.round(n.reduce((s, x) => s + x.ok, 0) / n.length * 100) : 100; }
  function quadro(agora) {
    if (!jogo) return; const dt = Math.min(.1, (agora - (jogo.ultimo || agora)) / 1000); jogo.ultimo = agora; jogo.t += dt; jogo.msgT -= dt; jogo.pulo = Math.max(0, jogo.pulo - dt);
    for (let i = 0; i < 4; i++) { jogo.trilha[i] = Math.max(0, jogo.trilha[i] - dt); if (jogo.acerto) jogo.acerto[i] = Math.max(0, jogo.acerto[i] - dt); }
    for (const n of jogo.notas) if (n.ok === null && jogo.t - n.t > .18) { n.ok = 0; jogo.combo = 0; }
    desenhar();
    if (jogo.t > DURACAO && !jogo.fim) { jogo.fim = true; const pct = nota(); setTimeout(() => fechar(pct >= META, pct), 900); }
    raf = requestAnimationFrame(quadro);
  }
  // fundo parado do palco (parede, treliça com refletores, telão, caixas de som e piso de LED), feito uma vez
  let fundoCv = null;
  function fundo() {
    if (fundoCv) return fundoCv; const PK = window.PixelKit; fundoCv = document.createElement('canvas'); fundoCv.width = LW; fundoCv.height = LH; const c = fundoCv.getContext('2d'); c.imageSmoothingEnabled = false;
    PK.faixas(c, 0, 0, LW, LH, ['#0a0614', '#0e0818', '#120a1e', '#160c24', '#1a0e2a', '#1e1030', '#221236', '#26143a']);
    for (let y = 16; y < 230; y += 6) for (let x = ((y / 6) % 2) * 6; x < 280; x += 12) { R(c, x, y, 11, 1, 'rgba(0,0,0,.35)'); R(c, x + 11, y, 1, 6, 'rgba(0,0,0,.3)'); }
    // treliça com triângulos e refletores
    R(c, 0, 2, 282, 2, '#5a5a6a'); R(c, 0, 12, 282, 2, '#5a5a6a'); for (let x = 0; x < 282; x += 10) { for (let k = 0; k < 9; k++) { R(c, x + k / 2, 12 - k, 1, 1, '#4a4a58'); R(c, x + 9 - k / 2, 12 - k, 1, 1, '#4a4a58'); } }
    for (const x of [30, 85, 140, 195, 250]) { R(c, x - 4, 14, 9, 7, '#2a2a34'); R(c, x - 3, 20, 7, 2, '#5a5a6a'); R(c, x - 2, 21, 5, 1, '#e8e8f0'); R(c, x, 13, 1, 2, '#3a3a44'); }
    // telão com moldura (o desenho dele anda no quadro dinâmico)
    PK.painel(c, 12, 46, 256, 106, { fundo: '#05030a', borda: '#3a3048', luz: 'rgba(255,255,255,.12)', sombra: false });
    for (let y = 50; y < 148; y += 2) R(c, 16, y, 248, 1, 'rgba(255,255,255,.03)');
    // caixas de som empilhadas dos dois lados
    for (const x0 of [0, 260]) for (let k = 0; k < 3; k++) { const y = 156 + k * 25; R(c, x0, y, 22, 24, '#16121e'); R(c, x0, y, 22, 1, '#3a3448'); R(c, x0 + 1, y + 1, 1, 22, '#2a2436'); for (let yy = -6; yy <= 6; yy++) { const w = Math.round(Math.sqrt(36 - yy * yy)); R(c, x0 + 11 - w, y + 12 + yy, w * 2, 1, '#0a080e'); } for (let yy = -3; yy <= 3; yy++) { const w = Math.round(Math.sqrt(9 - yy * yy)); R(c, x0 + 11 - w, y + 12 + yy, w * 2, 1, '#2a2436'); } R(c, x0 + 10, y + 11, 2, 2, '#5a5468'); }
    // borda do palco
    R(c, 0, 228, 282, 2, '#5a4a6a'); R(c, 0, 230, 282, 14, '#1a1428'); for (let x = 0; x < 282; x += 20) R(c, x, 231, 19, 12, '#221a32');
    // painel das trilhas: vidro escuro com borda neon
    PK.painel(c, 282, 2, 196, 266, { fundo: '#0a0614', borda: '#4a2a5a', luz: 'rgba(255,255,255,.1)', sombra: false });
    for (let i = 0; i < 4; i++) { R(c, lx(i) - 15, 6, 30, 258, 'rgba(255,255,255,.025)'); R(c, lx(i) - 16, 6, 1, 258, '#1e1430'); }
    return fundoCv;
  }
  const ROUPAS = ['#e8433a', '#3a6aa8', '#f2c94c', '#3c8a5a', '#c84a8a', '#f2f2ee', '#e8843a', '#6a4ac8'], PELES = ['#f0c8a0', '#c48a62', '#8a5a3c', '#5a3a28', '#e8b88a'];
  function desenhar() {
    const c = ctx, t = jogo.t, beat = Math.floor(t / BEAT), fase = (t % BEAT) / BEAT, PK = window.PixelKit;
    c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false;
    if (!PK) { R(c, 0, 0, LW, LH, '#0a0618'); return; }
    c.drawImage(fundo(), 0, 0);
    // telão: equalizador no ritmo e o nome da disputa
    for (let k = 0; k < 30; k++) { const h = Math.round((Math.abs(Math.sin(t * 3 + k * .7)) * .6 + (1 - fase) * .4) * (20 + PK.hash(k + beat) * 46)); for (let y = 0; y < h; y += 3) R(c, 20 + k * 8, 146 - y, 6, 2, y > 50 ? '#ff4fa8' : y > 30 ? '#ffd24a' : CORES[(k + beat) % 4]); }
    PK.contorno(c, cfg.titulo, 140, cfg.versos ? 60 : 64, 8, '#ffffff', '#3a1a4a');
    // feixes dos refletores mudando de cor no ritmo
    c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 5; i++) { const x = 30 + i * 55, a = Math.sin(t * .9 + i) * .4; c.globalAlpha = .1; c.fillStyle = CORES[(i + beat) % 4]; c.beginPath(); c.moveTo(x - 2, 22); c.lineTo(x + 2, 22); c.lineTo(x + Math.sin(a) * 200 + 26, 230); c.lineTo(x + Math.sin(a) * 200 - 26, 230); c.closePath(); c.fill(); } c.restore();
    // cone das caixas de som pulsando na batida
    if (fase < .2) for (const x0 of [0, 260]) for (let k = 0; k < 3; k++) { const y = 168 + k * 25; for (let a = 0; a < 16; a++) R(c, x0 + 11 + Math.cos(a / 16 * TAU) * 7, y + Math.sin(a / 16 * TAU) * 7, 1, 1, '#ff4fa8'); }
    // piso de LED aceso no ritmo
    for (let x = 0; x < 282; x += 20) if ((x / 20 + beat) % 3 === 0) { R(c, x, 231, 19, 12, CORES[(x / 20 + beat) % 4]); R(c, x, 231, 19, 2, '#ffffff'); }
    try {
      window.Art?.drawCharacter?.(c, cfg.rival, 52, 230, { frame: t * 2, facing: 1, grounded: true, scale: .9, attack: cfg.versos && Math.floor(t / (BEAT * 8)) % 2 === 0, attackProgress: (t % BEAT) / BEAT });
      const pula = Math.abs(Math.sin(t * Math.PI / BEAT)) * 6 + jogo.pulo * 14;
      window.Art?.drawCharacter?.(c, 'daroca', 138, 230 - pula, { frame: t * 2.2, facing: beat % 2 ? 1 : -1, moving: true, grounded: pula < 2, scale: 1 });
      if (cfg.premioLook) { R(c, 212, 160, 4, 70, '#8a7a5a'); R(c, 200, 228, 28, 4, '#6a5a3a');
      window.Art?.drawCharacter?.(c, 'daroca', 214, 226, { frame: 0, facing: -1, grounded: true, scale: .82, look: { costume: cfg.premioLook, hat: 'palha', hatColor: '#c0392b', hairStyle: 'curto', hairColor: '#5f4934', shirt: '#dc8c47', shirtLight: '#e7ac65', pants: '#455b62' } }); }
    } catch (e) {}
    if (cfg.premio) { PK.painel(c, 176, 236, 76, 14, { fundo: '#2a1a08', borda: '#ffd24a', sombra: false }); PK.texto(c, cfg.premio, 214, 243, 8, '#ffe9a8'); }
    if (cfg.versos) { const i = Math.floor(Math.max(0, t) / (BEAT * 8)), seu = i % 2 === 1, v = cfg.versos[i % cfg.versos.length];
      PK.painel(c, 16, 74, 248, 32, { fundo: '#0e0818', borda: seu ? '#3fe0ff' : '#ff4fa8', sombra: false });
      PK.texto(c, (seu ? 'DA ROÇA: ' : 'FREDDY: ') + v[0], 22, 83, 8, seu ? '#9af4ff' : '#ffb0d8', 'left'); PK.texto(c, v[1], 22, 95, 8, '#f2f2ea', 'left');
      const px = seu ? 138 : 52; for (let k = 0; k < 2; k++) { const u = (t * .8 + k / 2) % 1, nx = Math.round(px + 12 + k * 6 + Math.sin(t * 3 + k) * 2), ny = Math.round(168 - u * 30), cor = seu ? '#3fe0ff' : '#ff4fa8'; c.globalAlpha = 1 - u; R(c, nx + 2, ny, 1, 6, cor); R(c, nx, ny + 5, 3, 2, cor); R(c, nx + 3, ny, 2, 1, cor); R(c, nx + 4, ny + 1, 1, 1, cor); c.globalAlpha = 1; } }
    // plateia pulando: cabeças e mãos para cima na batida, luz de celular
    for (let k = 0; k < 24; k++) { const x = 2 + k * 11.5, grupo = (k + beat) % 3, pula = grupo === 0 && fase < .5, y = 250 + (k % 2) * 4;
      PK.pessoa(c, x, y, PELES[k % 5], ROUPAS[k % 8], '#1c1410', pula, (k % 4 === 1) || (pula && k % 2 === 0)); if (k % 6 === 2) { R(c, x + 7, y - 6, 2, 3, '#e8e8f0'); if (fase < .5) R(c, x + 7, y - 7, 2, 1, '#ffffff'); } }
    // trilhas: alvo na linha (aceso quando aperta), notas que descem e estouro de acerto
    for (let i = 0; i < 4; i++) { const on = jogo.trilha[i] > 0; if (on) { c.globalAlpha = .25; R(c, lx(i) - 14, 6, 28, LINHA, CORES[i]); c.globalAlpha = 1; }
      R(c, lx(i) - 16, LINHA - 1, 32, 2, on ? CORES[i] : '#3a2a4a'); if (on) PK.seta(c, lx(i), LINHA, i, '#ffffff', 2, CORES[i]); else PK.alvo(c, lx(i), LINHA, i, '#8a7a9a', 2);
      const ac = jogo.acerto ? jogo.acerto[i] : 0; if (ac > 0) { const r = Math.round(6 + (1 - ac / .3) * 14); for (let a = 0; a < 12; a++) R(c, lx(i) + Math.cos(a / 12 * TAU) * r, LINHA + Math.sin(a / 12 * TAU) * r, 2, 2, CORES[i]); PK.brilho4(c, lx(i), LINHA, 5, '#ffffff'); } }
    for (const n of jogo.notas) { if (n.ok) continue; const y = LINHA - (n.t - t) * VEL; if (y < -14 || y > LH + 14) continue; PK.seta(c, lx(n.lane), y, n.lane, n.ok === 0 ? '#5a3a3a' : CORES[n.lane], 2); }
    const pct = jogo.fim ? nota() : parcial();
    PK.painel(c, 290, 4, 180, 16, { fundo: '#120a1e', borda: pct >= META ? '#7af07a' : '#ff9a7a', sombra: false }); PK.texto(c, `ACERTO ${pct}%  META ${META}%`, 380, 12, 8, pct >= META ? '#c8ffc8' : '#ffd0c0');
    if (jogo.combo > 2) PK.contorno(c, 'COMBO ' + jogo.combo, 360, 240, jogo.pulo > .15 ? 16 : 8, '#ffd24a', '#3a1a0a');
    if (jogo.msgT > 0) PK.contorno(c, jogo.msg, 360, 130, 8, jogo.msg === 'FORA DO RITMO' ? '#ff7a6a' : '#9aff9a', '#0a0614');
    PK.barra(c, 292, 258, 156, 5, Math.min(1, t / DURACAO), { gomos: 26, cheio: '#ff4fa8', vazio: '#2a2040', borda: '#0a0614' });
    if (jogo.t < 2) PK.contorno(c, jogo.t < 1 ? 'PREPARA...' : 'VAI!', 360, 100, 16, '#ffffff', '#3a1a4a');
    if (jogo.fim) { PK.painel(c, 40, 100, 400, 64, { fundo: '#0e0818', borda: pct >= META ? '#7af07a' : '#ffd24a', rebite: '#ff4fa8' }); PK.texto(c, `NOTA ${pct}%`, LW / 2, 120, 16, pct >= META ? '#b8ffb8' : '#ffe9a8'); PK.texto(c, pct >= META ? cfg.ganhou : 'FALTOU POUCO!', LW / 2, 144, 8, '#fff6dc'); }
  }
  function tecla(e) {
    if (!box) return; if (e.code === 'Escape') { e.preventDefault(); e.stopPropagation(); fechar(false, jogo ? nota() : 0, true); return; }
    const lane = TECLAS[e.code]; if (lane === undefined) return; e.preventDefault(); e.stopPropagation(); if (!e.repeat) apertar(lane);
  }
  function montar() {
    if (box) return;
    if (!document.getElementById('bcEstilo')) { const st = document.createElement('style'); st.id = 'bcEstilo'; st.textContent = '.bc-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,4,14,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.bc-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:4px solid #2a1438;box-shadow:0 0 0 2px #ff4fa8,0 0 18px #ff4fa866;border-radius:0;background:#0a0618}.bc-botoes{display:flex;gap:10px}.bc-botoes button{width:64px;height:56px;font:24px Pixel,monospace;color:#fff;background:#2a1438;border:0;border-radius:0;box-shadow:0 0 0 3px currentColor,inset 0 -5px 0 #14081e,inset 0 3px 0 #5a3a6a;text-shadow:2px 2px 0 #0a0614}.bc-botoes button:active{background:#5a2a6a;transform:translateY(2px)}.bc-sair{font:8px Pixel,monospace;color:#ffd24a;background:#1a0e24;border:0;border-radius:0;padding:8px 14px;box-shadow:0 0 0 2px #ffd24a}'; document.head.append(st); }
    box = document.createElement('div'); box.className = 'bc-overlay'; box.setAttribute('role', 'dialog'); box.setAttribute('aria-label', 'Concurso da Fantasia');
    cv = document.createElement('canvas'); cv.width = LW; cv.height = LH; ctx = cv.getContext('2d'); box.append(cv);
    const bt = document.createElement('div'); bt.className = 'bc-botoes';
    SETAS.forEach((s, i) => { const b = document.createElement('button'); b.type = 'button'; b.textContent = s; b.style.color = CORES[i]; b.setAttribute('aria-label', 'seta ' + ['esquerda', 'baixo', 'cima', 'direita'][i]); b.addEventListener('pointerdown', (e) => { e.preventDefault(); apertar(i); }); bt.append(b); });
    box.append(bt);
    const sair = document.createElement('button'); sair.type = 'button'; sair.className = 'bc-sair'; sair.textContent = 'DESISTIR (Esc)'; sair.addEventListener('click', () => fechar(false, jogo ? nota() : 0, true)); box.append(sair);
    document.body.append(box); addEventListener('keydown', tecla, true);
  }
  function abrir(o = {}) {
    if (box) return false; aoFim = o.onFim || null; cfg = { ...PADRAO, ...(o.config || {}) }; montar(); jogo = { t: -1, notas: mapa(), combo: 0, melhorCombo: 0, msg: '', msgT: 0, pulo: 0, trilha: [0, 0, 0, 0], fim: false, ultimo: 0 };
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } })); cancelAnimationFrame(raf); raf = requestAnimationFrame(quadro); return true;
  }
  function fechar(ok, pct, desistiu = false) {
    if (!box) return; cancelAnimationFrame(raf); removeEventListener('keydown', tecla, true); box.remove(); box = null; jogo = null;
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); document.getElementById('gameCanvas')?.focus?.();
    const fn = aoFim; aoFim = null; if (fn) try { fn(!!ok, pct || 0, desistiu); } catch (e) {}
  }
  // estado(): leitura para testes automáticos (tempo e notas), sem efeito no jogo
  window.BaileConcurso = Object.freeze({ abrir, fechar: () => fechar(false, 0, true), aberto: () => !!box, META, estado: () => jogo && { t: jogo.t, nota: nota(), notas: jogo.notas.map((n) => ({ t: n.t, lane: n.lane, ok: n.ok })) } });
})();
