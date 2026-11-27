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
  const lx = (i) => 300 + i * 40;
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
    if (melhor && dist <= .16) { melhor.ok = dist <= .06 ? 1 : .7; jogo.combo++; jogo.melhorCombo = Math.max(jogo.melhorCombo, jogo.combo); jogo.msg = dist <= .06 ? 'PERFEITO!' : 'BOM!'; jogo.msgT = .45; jogo.pulo = .25; som(dist <= .06 ? 880 : 660); }
    else { jogo.combo = 0; jogo.msg = 'FORA DO RITMO'; jogo.msgT = .35; som(150, .08, 'sawtooth', .02); }
  }
  function nota() { const n = jogo.notas; return Math.round(n.reduce((s, x) => s + (x.ok || 0), 0) / n.length * 100); }
  function parcial() { const n = jogo.notas.filter((x) => x.ok !== null); return n.length ? Math.round(n.reduce((s, x) => s + x.ok, 0) / n.length * 100) : 100; }
  function quadro(agora) {
    if (!jogo) return; const dt = Math.min(.1, (agora - (jogo.ultimo || agora)) / 1000); jogo.ultimo = agora; jogo.t += dt; jogo.msgT -= dt; jogo.pulo = Math.max(0, jogo.pulo - dt);
    for (let i = 0; i < 4; i++) jogo.trilha[i] = Math.max(0, jogo.trilha[i] - dt);
    for (const n of jogo.notas) if (n.ok === null && jogo.t - n.t > .18) { n.ok = 0; jogo.combo = 0; }
    desenhar();
    if (jogo.t > DURACAO && !jogo.fim) { jogo.fim = true; const pct = nota(); setTimeout(() => fechar(pct >= META, pct), 900); }
    raf = requestAnimationFrame(quadro);
  }
  function desenhar() {
    const c = ctx, t = jogo.t, beat = Math.floor(t / BEAT), fase = (t % BEAT) / BEAT;
    c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false;
    const g = c.createLinearGradient(0, 0, 0, LH); g.addColorStop(0, '#0a0618'); g.addColorStop(1, '#2a1438'); c.fillStyle = g; c.fillRect(0, 0, LW, LH);
    // palco do concurso: feixes, telão e o prêmio no manequim
    c.save(); c.globalCompositeOperation = 'lighter'; for (let i = 0; i < 5; i++) { const x = 30 + i * 55, a = Math.sin(t * .9 + i) * .4; c.globalAlpha = .12; c.fillStyle = CORES[(i + beat) % 4]; c.beginPath(); c.moveTo(x, 0); c.lineTo(x + Math.sin(a) * 260 - 30, 230); c.lineTo(x + Math.sin(a) * 260 + 30, 230); c.closePath(); c.fill(); } c.restore();
    R(c, 20, 18, 230, 26, '#120e1e'); c.strokeStyle = '#ff4fa8'; c.lineWidth = 1; c.strokeRect(20.5, 18.5, 229, 25); c.font = 'bold 12px monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#ffd24a'; c.fillText(cfg.titulo, 135, 31);
    R(c, 0, 230, 280, 40, '#1a1428'); for (let x = 0; x < 280; x += 20) R(c, x, 230, 19, 4, (x / 20 + beat) % 3 ? '#2a2040' : CORES[(x / 20 + beat) % 4]);
    try {
      window.Art?.drawCharacter?.(c, cfg.rival, 52, 230, { frame: t * 2, facing: 1, grounded: true, scale: .9, attack: cfg.versos && Math.floor(t / (BEAT * 8)) % 2 === 0, attackProgress: (t % BEAT) / BEAT });
      const pula = Math.abs(Math.sin(t * Math.PI / BEAT)) * 6 + jogo.pulo * 14;
      window.Art?.drawCharacter?.(c, 'daroca', 138, 230 - pula, { frame: t * 2.2, facing: beat % 2 ? 1 : -1, moving: true, grounded: pula < 2, scale: 1 });
      if (cfg.premioLook) { R(c, 212, 160, 4, 70, '#8a7a5a'); R(c, 200, 228, 28, 4, '#6a5a3a');
      window.Art?.drawCharacter?.(c, 'daroca', 214, 226, { frame: 0, facing: -1, grounded: true, scale: .82, look: { costume: cfg.premioLook, hat: 'palha', hatColor: '#c0392b', hairStyle: 'curto', hairColor: '#5f4934', shirt: '#dc8c47', shirtLight: '#e7ac65', pants: '#455b62' } }); }
    } catch (e) {}
    c.font = 'bold 8px monospace'; c.fillStyle = '#ffd24a'; if (cfg.premio) c.fillText('PRÊMIO: ' + cfg.premio, 214, 246);
    if (cfg.versos) { const i = Math.floor(Math.max(0, t) / (BEAT * 8)), seu = i % 2 === 1, v = cfg.versos[i % cfg.versos.length]; R(c, 14, 54, 252, 30, 'rgba(10,6,20,.75)'); c.font = 'bold 9px monospace'; c.textAlign = 'left'; c.fillStyle = seu ? '#7af0ff' : '#ff9ad0'; c.fillText((seu ? 'DA ROÇA: ' : 'FREDDY: ') + v[0], 20, 64); c.fillStyle = '#f2f2ea'; c.fillText(v[1], 20, 76); c.textAlign = 'center'; }
    for (let k = 0; k < 14; k++) { const x = 8 + k * 20, y = 262 - Math.abs(Math.sin(t * 4 + k)) * 5; c.fillStyle = '#05030a'; c.beginPath(); c.arc(x, y, 7, 0, Math.PI * 2); c.fill(); R(c, x - 8, y + 3, 16, 10, '#05030a'); }
    // trilhas
    for (let i = 0; i < 4; i++) { R(c, lx(i) - 15, 0, 30, LH, 'rgba(10,6,20,.6)'); R(c, lx(i) - 16, LINHA - 2, 32, 4, jogo.trilha[i] > 0 ? CORES[i] : '#3a2a4a'); seta(lx(i), LINHA, i, jogo.trilha[i] > 0 ? '#ffffff' : '#5a4a6a', 1); }
    for (const n of jogo.notas) { if (n.ok) continue; const y = LINHA - (n.t - t) * VEL; if (y < -14 || y > LH + 14) continue; seta(lx(n.lane), y, n.lane, n.ok === 0 ? '#5a3a3a' : CORES[n.lane], 1 + (Math.abs(n.t - t) < .1 ? .15 : 0)); }
    const pct = jogo.fim ? nota() : parcial(); c.font = 'bold 11px monospace'; c.textAlign = 'center'; c.fillStyle = pct >= META ? '#ffe9a8' : '#ff9a7a'; c.fillText(`ACERTO ${pct}% · META ${META}%`, 360, 10);
    if (jogo.combo > 2) { c.font = 'bold 14px monospace'; c.fillStyle = '#ffd24a'; c.fillText('COMBO ' + jogo.combo, 360, 252); }
    if (jogo.msgT > 0) { c.font = 'bold 14px monospace'; c.fillStyle = jogo.msg === 'FORA DO RITMO' ? '#ff5a4a' : '#7af07a'; c.fillText(jogo.msg, 360, 130); }
    const prog = Math.min(1, t / DURACAO); R(c, 290, 262, 160, 4, '#2a2040'); R(c, 290, 262, 160 * prog, 4, '#ff4fa8');
    if (jogo.t < 2) { c.font = 'bold 16px monospace'; c.fillStyle = '#ffffff'; c.fillText(jogo.t < 1 ? 'PREPARA...' : 'VAI!', 360, 100); }
    if (jogo.fim) { R(c, 0, 100, LW, 60, 'rgba(0,0,0,.7)'); c.font = 'bold 18px monospace'; c.fillStyle = pct >= META ? '#7af07a' : '#ffd24a'; c.fillText(pct >= META ? `NOTA ${pct}%! ${cfg.ganhou}` : `NOTA ${pct}%. FALTOU POUCO!`, LW / 2, 130); }
  }
  function seta(x, y, i, cor, esc) {
    const c = ctx; c.save(); c.translate(Math.round(x), Math.round(y)); c.scale(esc, esc); c.rotate([Math.PI, Math.PI / 2, -Math.PI / 2, 0][i]);
    c.fillStyle = '#05030a'; c.beginPath(); c.moveTo(12, 0); c.lineTo(0, -12); c.lineTo(0, -5); c.lineTo(-11, -5); c.lineTo(-11, 5); c.lineTo(0, 5); c.lineTo(0, 12); c.closePath(); c.fill();
    c.fillStyle = cor; c.beginPath(); c.moveTo(9, 0); c.lineTo(1, -8); c.lineTo(1, -3); c.lineTo(-9, -3); c.lineTo(-9, 3); c.lineTo(1, 3); c.lineTo(1, 8); c.closePath(); c.fill(); c.restore();
  }
  function tecla(e) {
    if (!box) return; if (e.code === 'Escape') { e.preventDefault(); e.stopPropagation(); fechar(false, jogo ? nota() : 0, true); return; }
    const lane = TECLAS[e.code]; if (lane === undefined) return; e.preventDefault(); e.stopPropagation(); if (!e.repeat) apertar(lane);
  }
  function montar() {
    if (box) return;
    if (!document.getElementById('bcEstilo')) { const st = document.createElement('style'); st.id = 'bcEstilo'; st.textContent = '.bc-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,4,14,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.bc-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:2px solid #ff4fa8;border-radius:6px;background:#0a0618}.bc-botoes{display:flex;gap:10px}.bc-botoes button{width:64px;height:56px;font:bold 26px monospace;color:#fff;background:#2a1438;border:2px solid #5a3a6a;border-radius:10px}.bc-botoes button:active{background:#5a2a6a}.bc-sair{font:bold 12px monospace;color:#ffd24a;background:transparent;border:1px solid #ffd24a;border-radius:6px;padding:6px 12px}'; document.head.append(st); }
    box = document.createElement('div'); box.className = 'bc-overlay'; box.setAttribute('role', 'dialog'); box.setAttribute('aria-label', 'Concurso da Fantasia');
    cv = document.createElement('canvas'); cv.width = LW; cv.height = LH; ctx = cv.getContext('2d'); box.append(cv);
    const bt = document.createElement('div'); bt.className = 'bc-botoes';
    SETAS.forEach((s, i) => { const b = document.createElement('button'); b.type = 'button'; b.textContent = s; b.style.borderColor = CORES[i]; b.setAttribute('aria-label', 'seta ' + ['esquerda', 'baixo', 'cima', 'direita'][i]); b.addEventListener('pointerdown', (e) => { e.preventDefault(); apertar(i); }); bt.append(b); });
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
