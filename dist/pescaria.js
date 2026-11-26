/* Pescaria do Vagner (Açude da Roça, Campanha 1). Cinco arremessos: quando a boia afundar, PUXE
   (E, Espaço, Enter ou o botão na tela). Puxar antes da hora espanta o peixe. Esc sai.
   API: PescariaBene.abrir({ onFim(peixes) }), PescariaBene.aberto(). Sem save: a campanha decide o prêmio. */
(() => {
  'use strict';
  if (window.PescariaBene) return;
  const LW = 480, LH = 270, TENTATIVAS = 5, JANELA = .62, TAU = Math.PI * 2;
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const ell = (c, x, y, rx, ry, cor) => { c.fillStyle = cor; c.beginPath(); c.ellipse(Math.round(x), Math.round(y), rx, ry, 0, 0, TAU); c.fill(); };
  const PEIXES = [['TILÁPIA', '#a8b8c0'], ['TRAÍRA', '#7a8a5a'], ['PIABA', '#d8d0a0'], ['CARÁ', '#c8a06a'], ['TUCUNARÉ', '#e8b84a']];
  let box = null, cv = null, ctx = null, raf = 0, j = null, aoFim = null;

  function novoArremesso() { j.fase = 'espera'; j.espera = 1.2 + Math.random() * 2.3; j.tf = 0; j.msg = ''; }
  function puxar() {
    if (!j || j.fim) return;
    if (j.fase === 'mordeu') { j.peixes++; j.ultimo = PEIXES[Math.floor(Math.random() * PEIXES.length)]; j.fase = 'pegou'; j.tf = 0; j.msg = 'PEGOU UMA ' + j.ultimo[0] + '!'; }
    else if (j.fase === 'espera') { j.fase = 'espantou'; j.tf = 0; j.msg = 'CEDO DEMAIS! O PEIXE FUGIU'; }
  }
  function quadro(agora) {
    if (!j) return; const dt = Math.min(.1, (agora - (j.ultimoT || agora)) / 1000); j.ultimoT = agora; j.t += dt; j.tf += dt;
    if (j.fase === 'espera' && j.tf >= j.espera) { j.fase = 'mordeu'; j.tf = 0; }
    else if (j.fase === 'mordeu' && j.tf >= JANELA) { j.fase = 'escapou'; j.tf = 0; j.msg = 'ESCAPOU! PUXE QUANDO A BOIA AFUNDAR'; }
    else if (['pegou', 'espantou', 'escapou'].includes(j.fase) && j.tf >= 1.3) { j.tent++; if (j.tent >= TENTATIVAS) { j.fim = true; setTimeout(() => fechar(j?.peixes || 0), 1400); } else novoArremesso(); }
    desenhar(); raf = requestAnimationFrame(quadro);
  }
  function desenhar() {
    const c = ctx, t = j.t; c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false;
    const g = c.createLinearGradient(0, 0, 0, 130); g.addColorStop(0, '#7ab8e8'); g.addColorStop(1, '#cfe8f4'); c.fillStyle = g; c.fillRect(0, 0, LW, 130);
    for (let i = 0; i < 6; i++) ell(c, 40 + i * 90, 128, 70, 26, i % 2 ? '#4a8a4a' : '#3a7a3a');
    R(c, 0, 130, LW, 140, '#3a7aa8'); for (let k = 0; k < 40; k++) { const x = ((k * 61 + t * 10) % 520) - 20, y = 136 + (k * 9) % 120; R(c, x, y, 8 + (k % 3) * 4, 1, k % 2 ? '#7ab0d0' : '#5a9ac0'); }
    // píer com o Vagner e o Da Roça
    R(c, 0, 176, 150, 8, '#a8784a'); for (let k = 0; k < 150; k += 30) R(c, k + 6, 184, 5, 86, '#5a3a22');
    try { window.Art?.drawCharacter?.(c, 'vagner', 34, 176, { frame: t, facing: 1, grounded: true, scale: .85 }); window.Art?.drawCharacter?.(c, 'daroca', 108, 176, { frame: t, facing: 1, grounded: true, scale: .9, attack: j.fase === 'pegou' && j.tf < .4 }); } catch (e) {}
    // vara, linha e boia
    const bx = 300, base = 158, afunda = j.fase === 'mordeu' ? 6 + Math.sin(j.tf * 30) * 2 : j.fase === 'espera' ? Math.sin(t * 2) * 1.2 : 0;
    c.strokeStyle = '#6a4a2a'; c.lineWidth = 2; c.beginPath(); c.moveTo(120, 140); c.lineTo(178, 96); c.stroke();
    c.strokeStyle = 'rgba(255,255,255,.7)'; c.lineWidth = 1; c.beginPath(); c.moveTo(178, 96); c.quadraticCurveTo(240, 110, bx, base + afunda - 6); c.stroke();
    if (j.fase !== 'pegou') { ell(c, bx, base + afunda, 5, 6, '#f2f2ee'); R(c, bx - 5, base + afunda - 1, 10, 3, '#e8433a'); R(c, bx - 1, base + afunda - 10, 2, 5, '#1c1c1c'); }
    if (j.fase === 'mordeu') for (let k = 0; k < 3; k++) { c.strokeStyle = `rgba(255,255,255,${.6 - k * .18})`; c.beginPath(); c.ellipse(bx, base + 6, 8 + k * 6 + j.tf * 20, 3 + k * 2, 0, 0, TAU); c.stroke(); }
    if (j.fase === 'pegou') { const u = Math.min(1, j.tf / .6), fx = bx - (bx - 140) * u, fy = base - Math.sin(u * Math.PI) * 70 - u * 20; c.save(); c.translate(fx, fy); c.rotate(Math.sin(t * 20) * .4); ell(c, 0, 0, 12, 6, j.ultimo[1]); c.fillStyle = j.ultimo[1]; c.beginPath(); c.moveTo(-10, 0); c.lineTo(-18, -6); c.lineTo(-18, 6); c.closePath(); c.fill(); R(c, 6, -2, 2, 2, '#1c1c1c'); c.restore(); }
    // placar
    R(c, 300, 8, 172, 26, 'rgba(10,20,30,.7)'); c.font = 'bold 11px monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#fff6dc'; c.fillText(`PEIXES ${j.peixes} · ARREMESSO ${Math.min(j.tent + 1, TENTATIVAS)}/${TENTATIVAS}`, 386, 21);
    c.font = 'bold 14px monospace'; if (j.fase === 'mordeu') { c.fillStyle = '#ffd24a'; c.fillText('PUXA!', bx, 120); } if (j.msg) { c.fillStyle = j.fase === 'pegou' ? '#7af07a' : '#ffb0a0'; c.fillText(j.msg, LW / 2, 250); }
    if (j.fim) { R(c, 0, 100, LW, 56, 'rgba(0,0,0,.7)'); c.fillStyle = j.peixes >= 3 ? '#7af07a' : '#ffd24a'; c.font = 'bold 16px monospace'; c.fillText(j.peixes >= 3 ? `${j.peixes} PEIXES! PESCADOR DE VERDADE!` : `${j.peixes} PEIXE(S). O VAGNER RIU DE VOCÊ.`, LW / 2, 128); }
  }
  function tecla(e) { if (!box) return; if (e.code === 'Escape') { e.preventDefault(); e.stopPropagation(); fechar(j?.peixes || 0); return; } if (['KeyE', 'Space', 'Enter', 'KeyJ'].includes(e.code)) { e.preventDefault(); e.stopPropagation(); if (!e.repeat) puxar(); } }
  function abrir(o = {}) {
    if (box) return false; aoFim = o.onFim || null;
    if (!document.getElementById('pbEstilo')) { const st = document.createElement('style'); st.id = 'pbEstilo'; st.textContent = '.pb-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,14,20,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.pb-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:2px solid #7ab0d0;border-radius:6px}.pb-puxar{font:bold 20px monospace;color:#fff;background:#2a5a7a;border:2px solid #7ab0d0;border-radius:10px;padding:12px 36px}.pb-puxar:active{background:#3a7aa8}.pb-sair{font:bold 12px monospace;color:#ffd24a;background:transparent;border:1px solid #ffd24a;border-radius:6px;padding:6px 12px}'; document.head.append(st); }
    box = document.createElement('div'); box.className = 'pb-overlay'; box.setAttribute('role', 'dialog'); box.setAttribute('aria-label', 'Pescaria do Vagner');
    cv = document.createElement('canvas'); cv.width = LW; cv.height = LH; ctx = cv.getContext('2d'); box.append(cv);
    const b = document.createElement('button'); b.type = 'button'; b.className = 'pb-puxar'; b.textContent = 'PUXAR!'; b.addEventListener('pointerdown', (e) => { e.preventDefault(); puxar(); }); box.append(b);
    const s = document.createElement('button'); s.type = 'button'; s.className = 'pb-sair'; s.textContent = 'SAIR (Esc)'; s.addEventListener('click', () => fechar(j?.peixes || 0)); box.append(s);
    document.body.append(box); addEventListener('keydown', tecla, true);
    j = { t: 0, tf: 0, tent: 0, peixes: 0, fase: 'espera', espera: 1.5, msg: '', fim: false, ultimoT: 0 }; novoArremesso();
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } })); cancelAnimationFrame(raf); raf = requestAnimationFrame(quadro); return true;
  }
  function fechar(peixes) {
    if (!box) return; cancelAnimationFrame(raf); removeEventListener('keydown', tecla, true); box.remove(); box = null; j = null;
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); document.getElementById('gameCanvas')?.focus?.();
    const fn = aoFim; aoFim = null; if (fn) try { fn(peixes || 0); } catch (e) {}
  }
  window.PescariaBene = Object.freeze({ abrir, aberto: () => !!box, estado: () => j && { fase: j.fase, peixes: j.peixes, tent: j.tent } });
})();
