/* Balanço da roça: pendurado no galho da árvore grande perto da Trilha da Roça (fase 0).
   Chegue perto e aperte E: Da Roça senta, a interface some, entram faixas de cinema e o tempo
   corre mais rápido (15 minutos do jogo por segundo) para apreciar o pôr do sol e o céu.
   Qualquer direção, E, Esc ou o botão LEVANTAR saem. Só aparência: não mexe em vida nem progresso. */
(() => {
  'use strict';
  if (window.Balanco) return;
  const SCENE = 0, AX = 2462, AY = 340, ROPE = 66, HALF = 13; // galho direito da árvore em x=1220 (pixels de arte)
  let active = false, theta = .05, omega = 0, sitAt = 0, hour = 0, lastT = 0, ui = null, bars = 0;
  const near = (scene, x) => scene === SCENE && Math.abs(x - AX) < 44;
  function sit() {
    if (active) return; active = true; sitAt = performance.now(); bars = 0;
    hour = window.DayTime?.hour?.() ?? 17;
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
    document.getElementById('gameShell')?.classList.add('is-balanco');
    if (!ui) { ui = document.createElement('div'); ui.className = 'balanco-ui'; ui.innerHTML = '<span class="bl-hora"></span><button type="button" class="bl-sair">LEVANTAR</button>'; ui.querySelector('.bl-sair').addEventListener('click', leave); (document.getElementById('gameViewport') || document.getElementById('gameShell') || document.body).append(ui); }
    ui.hidden = false; try { window.DarocaAudio?.play?.('porta', { volume: .4 }); } catch (e) {}
  }
  function leave() {
    if (!active) return; active = false; ui && (ui.hidden = true);
    try { window.DayTime?.force?.(null); } catch (e) {}
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } }));
    document.getElementById('gameShell')?.classList.remove('is-balanco');
    document.getElementById('gameCanvas')?.focus?.();
  }
  addEventListener('keydown', (e) => {
    if (!active || performance.now() - sitAt < 400) return;
    if (['KeyE', 'Escape', 'Space', 'Enter', 'KeyA', 'KeyD', 'KeyW', 'KeyS', 'ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(e.code)) { e.preventDefault(); e.stopImmediatePropagation(); leave(); }
  }, true);
  const lerp = (a, b, k) => a + (b - a) * k;
  // o.ctx está nas coordenadas do mundo (a câmera já foi aplicada)
  function draw(ctx, o) {
    if (o.scene !== SCENE || o.arena || o.room) { if (active) leave(); return; }
    const t = Number(o.time) || 0, dt = Math.max(0, Math.min(.05, t - lastT)); lastT = t;
    // pêndulo: sentado, Da Roça "pedala" até uma oscilação gostosa; vazio, só o vento mexe
    const target = active ? .3 : .04 + Math.sin(t * .4) * .02, amp = Math.abs(theta) + Math.abs(omega) / 3.9;
    omega += (-(9.8 / (ROPE / 40)) * Math.sin(theta)) * dt; omega *= active ? 1 : .995; if (amp < target && Math.sign(omega) === Math.sign(theta) || amp < .02) omega += Math.sign(omega || 1) * .5 * dt; if (amp > target + .05) omega *= .99;
    theta += omega * dt;
    if (Math.abs(o.camera + 480 - AX) > 700) return;
    const sx = AX + Math.sin(theta) * ROPE, sy = AY + Math.cos(theta) * ROPE, ca = Math.cos(theta), sa = Math.sin(theta);
    const L1 = [sx - HALF * ca, sy + HALF * sa], R1 = [sx + HALF * ca, sy - HALF * sa];
    ctx.save(); ctx.imageSmoothingEnabled = false;
    const rope = (x0, y0, x1, y1) => { const n = Math.ceil(Math.hypot(x1 - x0, y1 - y0) / 2); for (let i = 0; i <= n; i++) { const k = i / n; ctx.fillStyle = i % 3 ? '#e2cc96' : '#a8885a'; ctx.fillRect(Math.round(lerp(x0, x1, k) / 2) * 2, Math.round(lerp(y0, y1, k) / 2) * 2, 2, 2); } };
    if (active) {
      const k = Math.min(1, (performance.now() - sitAt) / 600);
      ctx.save(); ctx.translate(Math.round(sx), Math.round(sy)); ctx.rotate(theta * .9);
      try { window.Art?.drawCharacter?.(ctx, 'daroca', 2, 22, { facing: 1, frame: t * .3, scale: 1, grounded: true, moving: false }); } catch (e) {}
      ctx.restore();
      // tempo correndo para ver o sol se pôr
      hour = (hour + dt * .25) % 24; try { window.DayTime?.force?.(hour); } catch (e) {}
      if (ui) { const h = Math.floor(hour), m = Math.floor((hour - h) * 60); ui.querySelector('.bl-hora').textContent = 'Apreciando a vista · ' + String(h).padStart(2, '0') + ':' + String(m).padStart(2, '0'); }
      bars = Math.min(1, bars + dt * 1.5); void k;
    } else bars = Math.max(0, bars - dt * 3);
    rope(AX - 10, AY, L1[0], L1[1]); rope(AX + 10, AY, R1[0], R1[1]);
    // assento de tábua
    ctx.save(); ctx.translate(Math.round(sx), Math.round(sy)); ctx.rotate(-theta * .1);
    ctx.fillStyle = '#3e2a18'; ctx.fillRect(-HALF - 3, -3, HALF * 2 + 6, 7); ctx.fillStyle = '#9a6a3a'; ctx.fillRect(-HALF - 2, -2, HALF * 2 + 4, 4); ctx.fillStyle = '#c08a50'; ctx.fillRect(-HALF - 2, -2, HALF * 2 + 4, 1);
    ctx.restore();
    ctx.fillStyle = '#5a4026'; ctx.fillRect(AX - 14, AY - 2, 28, 4);
    ctx.restore();
    // faixas de cinema e vinheta (na tela)
    if (bars > 0) { ctx.save(); ctx.translate(Math.round(o.camera), 0); const h = Math.round(46 * bars / 2) * 2; ctx.fillStyle = '#05070a'; ctx.fillRect(0, 0, 960, h); ctx.fillRect(0, 540 - h, 960, h);
      const g = ctx.createRadialGradient(480, 270, 240, 480, 270, 620); g.addColorStop(0, 'rgba(0,0,0,0)'); g.addColorStop(1, `rgba(10,6,4,${.45 * bars})`); ctx.fillStyle = g; ctx.fillRect(0, 0, 960, 540); ctx.restore(); }
  }
  window.Balanco = Object.freeze({ near, sit, leave, active: () => active, draw });
})();
