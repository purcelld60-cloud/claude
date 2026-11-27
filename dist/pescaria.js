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
    if (j.fase === 'mordeu') { j.peixes++; j.ultimo = PEIXES[Math.floor(Math.random() * PEIXES.length)]; (j.peixesTipo = j.peixesTipo || []).push(j.ultimo[0]); j.fase = 'pegou'; j.tf = 0; j.msg = 'PEGOU UMA ' + j.ultimo[0] + '!'; }
    else if (j.fase === 'espera') { j.fase = 'espantou'; j.tf = 0; j.msg = 'CEDO DEMAIS! O PEIXE FUGIU'; }
  }
  function quadro(agora) {
    if (!j) return; const dt = Math.min(.1, (agora - (j.ultimoT || agora)) / 1000); j.ultimoT = agora; j.t += dt; j.tf += dt;
    if (j.fase === 'espera' && j.tf >= j.espera) { j.fase = 'mordeu'; j.tf = 0; }
    else if (j.fase === 'mordeu' && j.tf >= JANELA) { j.fase = 'escapou'; j.tf = 0; j.msg = 'ESCAPOU! PUXE QUANDO A BOIA AFUNDAR'; }
    else if (['pegou', 'espantou', 'escapou'].includes(j.fase) && j.tf >= 1.3) { j.tent++; if (j.tent >= TENTATIVAS) { j.fim = true; setTimeout(() => fechar(j?.peixes || 0), 1400); } else novoArremesso(); }
    desenhar(); raf = requestAnimationFrame(quadro);
  }
  // fundo parado (céu, serra, mata, casinha, píer) desenhado uma vez por hora do dia
  const fundos = {};
  function fundo(noite) {
    const k = noite ? 'n' : 'd'; if (fundos[k]) return fundos[k];
    const PK = window.PixelKit, cvf = document.createElement('canvas'); cvf.width = LW; cvf.height = LH; const c = cvf.getContext('2d'); c.imageSmoothingEnabled = false;
    const T = (d, n) => (noite ? n : d), h = PK.hash;
    PK.faixas(c, 0, 0, LW, 104, noite ? ['#0a1028', '#0e1634', '#121c3e', '#18244a', '#1e2c54', '#26365e'] : ['#4a92da', '#5aa0e0', '#6aaee6', '#7cbcea', '#90caf0', '#a8d8f4']);
    if (noite) { for (let i = 0; i < 70; i++) R(c, h(i) * LW, h(i + 9) * 80, 1, 1, i % 7 ? '#c8d0f0' : '#ffffff'); for (let y = -7; y <= 7; y++) { const w = Math.round(Math.sqrt(49 - y * y)); R(c, 236 - w, 34 + y, w * 2, 1, '#f2f2e0'); } R(c, 233, 31, 3, 2, '#d8d8c8'); R(c, 239, 37, 2, 2, '#d8d8c8'); }
    else { for (let y = -9; y <= 9; y++) { const w = Math.round(Math.sqrt(81 - y * y)); R(c, 236 - w, 36 + y, w * 2, 1, y < -3 ? '#fffbe0' : '#fff2b0'); } for (let k = 0; k < 24; k++) { const a = k / 24 * TAU; if (k % 2) R(c, 236 + Math.cos(a) * 13, 36 + Math.sin(a) * 13, 1, 1, '#fff6c8'); } }
    // nuvens de pixel: bolotas com base reta e sombra embaixo
    for (const [cx, cy, n] of [[70, 30, 5], [190, 18, 4], [300, 50, 3], [440, 70, 3]]) { for (let k = 0; k < n; k++) { const r = 5 + (k % 2) * 3, x = cx + k * 9 - n * 4; for (let y = -r; y <= 0; y++) { const w = Math.round(Math.sqrt(r * r - y * y)); R(c, x - w, cy + y, w * 2, 1, T('#ffffff', '#3a4468')); } } R(c, cx - n * 4 - 4, cy, n * 9 + 6, 2, T('#d8e8f4', '#2a3254')); }
    // serra azulada, morros verdes com roças de cacau e a mata na beira
    for (let x = 0; x < LW; x++) { const y1 = Math.round(76 + Math.sin(x * .021) * 8 + Math.sin(x * .07 + 1) * 3), y2 = Math.round(90 + Math.sin(x * .03 + 2) * 6 + Math.sin(x * .11) * 2);
      const sobe = Math.cos(x * .021) * 8 * .021 + Math.cos(x * .07 + 1) * 3 * .07; R(c, x, y1, 1, 112 - y1, T(sobe < 0 ? '#86a4b8' : '#6a8aa4', '#1e2a44')); R(c, x, y1, 1, 1, T('#b8cedc', '#2a3858')); if (h(x * 1.3) > .6) R(c, x, y1 + 3 + Math.floor(h(x) * 8), 1, 1, T('#5a7a94', '#18223a'));
      R(c, x, y2, 1, 112 - y2, T((Math.floor((x + y2) / 14) % 2) ? '#5a9a4e' : '#6aaa58', '#16281e')); if (x % 4 === 0 && y2 + 4 < 108) R(c, x, y2 + 4, 1, 1, T('#3a7a3a', '#0e1c16')); }
    for (let i = 0; i < 40; i++) { const x = i * 12 + h(i) * 8, y = 106 - h(i * 3) * 4, r = 4 + Math.floor(h(i * 7) * 4); for (let yy = -r; yy <= 0; yy++) { const w = Math.round(Math.sqrt(r * r - yy * yy)); R(c, x - w, y + yy, w * 2, 1, T(yy < -r / 2 ? '#4a8a40' : '#2f6a34', yy < -r / 2 ? '#1a3226' : '#12241a')); } }
    for (const x of [150, 330]) { for (let y = 0; y < 24; y++) R(c, x + Math.sin(y * .1) * 2, 106 - y, 2, 1, T('#7a5a34', '#2a2018')); for (let f = 0; f < 6; f++) { const a = -Math.PI / 2 + (f - 2.5) * .55; for (let k = 1; k < 10; k++) R(c, x + 1 + Math.cos(a) * k, 82 + Math.sin(a) * k * .6 + k * k * .05, 1, 1, T('#3a8a3a', '#16301e')); } }
    // casinha do Vagner do outro lado, com janela e chaminé
    R(c, 400, 92, 26, 16, T('#e8d8b8', '#3a3448')); for (let k = 0; k < 8; k++) R(c, 398 + k, 92 - k, 30 - k * 2, 1, T('#b8543a', '#2a2238')); R(c, 418, 82, 4, 8, T('#8a4a3a', '#2a2020')); R(c, 405, 96, 6, 6, noite ? '#ffd27a' : '#5a7a9a'); R(c, 415, 98, 6, 10, T('#7a4a2a', '#1a1418'));
    // água em faixas com pontilhado
    PK.faixas(c, 0, 110, LW, 160, noite ? ['#1e3058', '#1a2a50', '#162448', '#132040', '#101c38', '#0e1830', '#0c1428', '#0a1222'] : ['#8ac4e4', '#78b6dc', '#68a8d2', '#5a9ac8', '#4c8cbc', '#407eb0', '#3670a4', '#2c6298']);
    // aguapés e vitórias-régias com flor, taboas na beira direita
    for (const [x, y, w] of [[260, 214, 14], [290, 222, 10], [420, 190, 16], [446, 200, 11], [380, 240, 13]]) { R(c, x - w / 2, y, w, 3, T('#3a8a3a', '#14301e')); R(c, x - w / 2 + 1, y, w - 2, 1, T('#5aaa4a', '#1e4028')); R(c, x, y + 1, 2, 2, T('#2a6a2a', '#0e2414')); if (w > 12) { R(c, x - 2, y - 2, 3, 2, '#f2a8c8'); R(c, x - 1, y - 3, 1, 1, '#ffffff'); } }
    for (let k = 0; k < 9; k++) { const x = 452 + k * 3, hh = 26 + (k % 3) * 9; for (let y = 0; y < hh; y++) R(c, x + (y > hh * .6 ? 1 : 0), 268 - y, 1, 1, T('#4a7a3a', '#16301e')); R(c, x, 268 - hh - 6, 2, 6, T('#6a4a2a', '#22180e')); }
    // píer de tábuas com pregos, frente escura, pilares e musgo na linha d'água
    for (let x = 0; x < 158; x += 10) { R(c, x, 174, 9, 4, T(['#b8844e', '#a8784a', '#c08a52'][(x / 10) % 3], '#4a3420')); R(c, x + 9, 174, 1, 4, T('#6a4224', '#22160c')); R(c, x + 2, 175, 1, 1, '#3a2414'); R(c, x + 6, 175, 1, 1, '#3a2414'); }
    R(c, 0, 178, 158, 7, T('#7a5230', '#2a1c10')); R(c, 0, 178, 158, 1, T('#5a3a20', '#1c120a')); for (let x = 4; x < 158; x += 26) R(c, x, 180, 14, 1, T('#6a4628', '#24180e'));
    for (let x = 8; x < 158; x += 30) { R(c, x, 185, 6, 85, T('#5a3a22', '#1e140c')); R(c, x, 185, 2, 85, T('#7a5230', '#2a1c10')); R(c, x, 196, 6, 4, T('#4a7a3a', '#16301e')); R(c, x - 2, 200, 10, 1, T('#a8d8f0', '#3a5a8a')); }
    // balde, lata de minhoca e caixa de anzol no píer
    R(c, 136, 160, 14, 14, T('#3a6aa8', '#18243a')); R(c, 135, 160, 16, 2, T('#6a9ad8', '#24365a')); R(c, 137, 156, 12, 1, T('#9aa0a6', '#3a3e48')); R(c, 136, 157, 1, 3, T('#9aa0a6', '#3a3e48')); R(c, 149, 157, 1, 3, T('#9aa0a6', '#3a3e48'));
    R(c, 6, 166, 9, 8, T('#9aa0a6', '#3a3e48')); R(c, 6, 166, 9, 2, T('#c43c3a', '#3a1a1a')); R(c, 8, 164, 2, 2, T('#c87a7a', '#3a2a2a')); R(c, 11, 163, 1, 3, T('#c87a7a', '#3a2a2a'));
    R(c, 18, 168, 14, 6, T('#2f7a4a', '#10261a')); R(c, 18, 168, 14, 1, T('#5aa86a', '#1e3a28')); R(c, 24, 170, 2, 2, T('#e8c24a', '#3a3418'));
    return (fundos[k] = cvf);
  }
  function desenhar() {
    const c = ctx, t = j.t, PK = window.PixelKit; c.setTransform(1, 0, 0, 1, 0, 0); c.imageSmoothingEnabled = false;
    if (!PK) { R(c, 0, 0, LW, LH, '#3a7aa8'); return; }
    const noite = (window.DayTime?.state?.()?.night || 0) > .55;
    c.drawImage(fundo(noite), 0, 0);
    // reflexo da mata e da casinha tremendo na água; marolas andando; brilhos
    const f = fundo(noite); for (let y = 0; y < 14; y++) { const dx = Math.round(Math.sin(t * 2.2 + y * .8) * (1 + y * .15)); c.globalAlpha = .28 - y * .015; c.drawImage(f, 0, 108 - y, LW, 1, dx, 111 + y, LW, 1); } c.globalAlpha = 1;
    for (let k = 0; k < 34; k++) { const x = ((k * 61 + t * (6 + (k % 3) * 3)) % 520) - 20, y = 118 + (k * 23) % 150, w = 3 + (k % 4) * 2; R(c, x, y, w, 1, noite ? (k % 2 ? '#3a5a8a' : '#2a4a7a') : (k % 2 ? '#a8d8f0' : '#8ac0e0')); }
    for (let k = 0; k < 8; k++) if (Math.sin(t * 4 + k * 2.1) > .6) PK.brilho4(c, Math.round(170 + PK.hash(k) * 300), Math.round(116 + PK.hash(k + 4) * 120), 2, noite ? '#c8d8ff' : '#ffffff');
    { const x = 236; for (let y = 112; y < 170; y += 2) { const w = 2 + Math.round(Math.sin(t * 3 + y * .7) * 1.5 + (y - 110) * .06); c.globalAlpha = .5 - (y - 110) / 140; R(c, x - w + Math.sin(t * 2 + y) * 2, y, w * 2, 1, noite ? '#e8f0ff' : '#fff6c8'); } c.globalAlpha = 1; }
    // sombra de peixe passando no fundo
    { const u = (t * .07) % 1, x = 520 - u * 600, y = 236 + Math.sin(t * .8) * 6; c.globalAlpha = .25; R(c, x, y, 14, 3, '#0a1a2a'); R(c, x + 3, y - 1, 8, 5, '#0a1a2a'); R(c, x + 14, y - 1, 3, 5, '#0a1a2a'); c.globalAlpha = 1; }
    // libélula
    if (!noite) { const x = 220 + Math.sin(t * .7) * 60, y = 150 + Math.sin(t * 1.9) * 12, a = Math.sin(t * 40) > 0; R(c, x, y, 6, 1, '#3a6ac8'); R(c, x + 1, y - (a ? 2 : 1), 3, 1, 'rgba(220,240,255,.8)'); }
    // Vagner e o Da Roça no píer
    try { window.Art?.drawCharacter?.(c, 'vagner', 40, 174, { frame: t, facing: 1, grounded: true, scale: .85 }); window.Art?.drawCharacter?.(c, 'daroca', 108, 174, { frame: t, facing: 1, grounded: true, scale: .9, attack: j.fase === 'pegou' && j.tf < .4 }); } catch (e) {}
    // vara em pixel (cabo com molinete), linha pontilhada em curva e a boia
    const puxa = j.fase === 'pegou' ? Math.max(0, 1 - j.tf * 2) : 0, tx = 186 - puxa * 14, ty = 92 - puxa * 18;
    for (let k = 0; k <= 22; k++) { const u = k / 22, x = 118 + (tx - 118) * u, y = 142 + (ty - 142) * u - Math.sin(u * Math.PI) * (j.fase === 'mordeu' ? 5 : 2); R(c, x, y, k < 6 ? 2 : 1, 2, k < 6 ? '#3a2414' : '#8a5a2a'); }
    R(c, 120, 140, 4, 4, '#9aa0a6'); R(c, 121, 141, 2, 2, '#3a3e44');
    const bx = 300, base = 158, afunda = j.fase === 'mordeu' ? 5 + Math.round(Math.sin(j.tf * 30) * 2) : j.fase === 'espera' ? Math.round(Math.sin(t * 2) * 1.2) : 0;
    if (j.fase !== 'pegou') { for (let k = 0; k <= 30; k++) { const u = k / 30, x = tx + (bx - tx) * u, y = ty + (base + afunda - 8 - ty) * u * u + Math.sin(u * Math.PI) * -6; R(c, x, y, 1, 1, noite ? 'rgba(200,210,240,.6)' : 'rgba(255,255,255,.8)'); }
      const by = base + afunda; R(c, bx - 3, by - 6, 6, 3, '#e8433a'); R(c, bx - 2, by - 7, 4, 1, '#ff7a6a'); R(c, bx - 3, by - 3, 6, 3, '#f2f2ee'); R(c, bx - 2, by, 4, 1, '#c8c8c0'); R(c, bx, by - 12, 1, 5, '#1c1c1c'); R(c, bx - 4, by + 1, 9, 1, noite ? '#4a6a9a' : '#c8e8f8'); }
    if (j.fase === 'mordeu') { for (let k = 0; k < 3; k++) { const r = 6 + k * 5 + Math.round(j.tf * 18), a = .7 - k * .2; c.globalAlpha = Math.max(0, a); for (let i = 0; i < 24; i++) { const an = i / 24 * TAU; R(c, bx + Math.cos(an) * r, base + 4 + Math.sin(an) * r * .3, 1, 1, '#ffffff'); } } c.globalAlpha = 1;
      for (let k = 0; k < 5; k++) { const u = (j.tf * 3 + k / 5) % 1; R(c, bx - 6 + k * 3, base - u * 8, 1, 1, '#e8f8ff'); }
      if (Math.floor(j.tf * 8) % 2 === 0) PK.contorno(c, '!', bx, base - 26, 16, '#ffd24a', '#3a1a0a'); }
    // peixe pulando para a mão do Da Roça, com gotas
    if (j.fase === 'pegou' && j.ultimo) { const u = Math.min(1, j.tf / .6), fx = bx - (bx - 140) * u, fy = base - Math.sin(u * Math.PI) * 70 - u * 20; PK.peixe(c, j.ultimo[0], fx, fy, 1, false);
      for (let k = 0; k < 6; k++) { const v = (j.tf * 2 + k / 6) % 1; R(c, fx + (PK.hash(k) - .5) * 20, fy + v * 24, 1, 2, '#c8e8ff'); } }
    // peixes no balde (um rabo para cada peixe pego)
    for (let k = 0; k < Math.min(j.peixes, 5); k++) { const x = 138 + k * 2.5, y = 158 - (k % 2); R(c, x, y, 2, 3, j.peixesTipo?.[k] ? '#c8d0d8' : '#a8b8c0'); R(c, x - 1, y - 1, 1, 1, '#a8b8c0'); R(c, x + 2, y - 1, 1, 1, '#a8b8c0'); }
    // placar: um peixinho por pegada e a contagem dos arremessos
    PK.painel(c, 300, 6, 172, 30, { fundo: '#13283a', borda: '#9ad0e8', rebite: '#5a8aa8' });
    for (let k = 0; k < TENTATIVAS; k++) { const x = 318 + k * 22, y = 21; if (k < j.peixes) PK.peixe(c, (j.peixesTipo && j.peixesTipo[k]) || 'TILÁPIA', x, y, 1); else { c.globalAlpha = .3; PK.peixe(c, 'PIABA', x, y, 1); c.globalAlpha = 1; } }
    PK.texto(c, `${Math.min(j.tent + 1, TENTATIVAS)}/${TENTATIVAS}`, 448, 21, 8, '#fff6dc');
    PK.painel(c, 6, 6, 118, 20, { fundo: '#2a1e12', borda: '#e8c24a' }); PK.texto(c, 'PESCARIA', 65, 16, 8, '#ffe9a8');
    if (j.fase === 'mordeu') PK.contorno(c, 'PUXA!', bx, 112, 16, Math.floor(t * 10) % 2 ? '#ffd24a' : '#ffffff', '#3a1a0a');
    if (j.msg) { const bom = j.fase === 'pegou'; PK.painel(c, 120, 238, 240, 24, { fundo: bom ? '#14301e' : '#3a1414', borda: bom ? '#7af07a' : '#ff9a7a' }); PK.texto(c, j.msg, LW / 2, 250, 8, bom ? '#b8ffb8' : '#ffd0c0'); }
    if (j.fim) { PK.painel(c, 70, 96, 340, 64, { fundo: '#101c2a', borda: j.peixes >= 3 ? '#7af07a' : '#ffd24a', rebite: '#5a8aa8' }); PK.texto(c, j.peixes >= 3 ? `${j.peixes} PEIXES!` : `${j.peixes} PEIXE(S)`, LW / 2, 116, 16, j.peixes >= 3 ? '#b8ffb8' : '#ffe9a8'); PK.texto(c, j.peixes >= 3 ? 'PESCADOR DE VERDADE!' : 'O VAGNER RIU DE VOCÊ.', LW / 2, 140, 8, '#fff6dc'); }
  }
  function tecla(e) { if (!box) return; if (e.code === 'Escape') { e.preventDefault(); e.stopPropagation(); fechar(j?.peixes || 0); return; } if (['KeyE', 'Space', 'Enter', 'KeyJ'].includes(e.code)) { e.preventDefault(); e.stopPropagation(); if (!e.repeat) puxar(); } }
  function abrir(o = {}) {
    if (box) return false; aoFim = o.onFim || null;
    if (!document.getElementById('pbEstilo')) { const st = document.createElement('style'); st.id = 'pbEstilo'; st.textContent = '.pb-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,14,20,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.pb-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:4px solid #5a3a22;box-shadow:0 0 0 2px #e8c24a,0 6px 0 2px #2a1a0e;border-radius:0}.pb-puxar{font:16px Pixel,monospace;color:#fff6dc;background:#2a5a7a;border:0;border-radius:0;padding:14px 36px;box-shadow:0 0 0 3px #0a1a2a,inset 0 -4px 0 #1a3a52,inset 0 3px 0 #5a9ac8;text-shadow:2px 2px 0 #0a1a2a}.pb-puxar:active{background:#3a7aa8;transform:translateY(2px)}.pb-sair{font:8px Pixel,monospace;color:#ffd24a;background:#2a1e12;border:0;border-radius:0;padding:8px 14px;box-shadow:0 0 0 2px #ffd24a}'; document.head.append(st); }
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
