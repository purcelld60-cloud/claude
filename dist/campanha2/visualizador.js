/* Campanha 2 · Visualizador dos cenários (para conferir o Passo 2 antes de ligar na campanha).
   Abra o jogo com ?cenarios2 no fim do endereço (ex.: .../index.html?cenarios2).
   Setas ou A/D andam · Espaço ou W pula · J bate (quebra caixotes, chuta lixeiras, liga alavancas) ·
   [ ] trocam o cenário · 1 a 4 trocam a hora · Esc fecha. No celular, use os botões embaixo.
   Os objetos interativos usam o mesmo sistema da campanha principal (Interact). */
(() => {
  'use strict';
  if (!/[?&]cenarios2\b/.test(location.search) || !window.CampanhaCenarios || !window.Art) return;
  const L = window.CampanhaCenarios.lista, FLOOR = 440;
  const HOURS = [['MANHÃ', 7], ['TARDE', 15], ['PÔR DO SOL', 17.4], ['NOITE', 21]];
  const P = { x: 300, y: FLOOR, vx: 0, vy: 0, ground: true, facing: 1, attack: 0 };
  let idx = 0, cam = 0, hour = 1, keys = new Set(), last = performance.now(), t = 0, open = true, atkT = 0;
  const box = document.createElement('div');
  box.style.cssText = 'position:fixed;inset:0;z-index:100000;background:#0b0f14;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;font:12px Pixel,monospace;color:#f2efe6;touch-action:none';
  box.innerHTML = '<div class="c2-top" style="display:flex;gap:6px;flex-wrap:wrap;justify-content:center"></div><div style="position:relative;width:min(100vw,177.7vh);max-height:calc(100vh - 120px);aspect-ratio:16/9"><canvas id="c2Viewer" width="960" height="540" style="width:100%;height:100%;image-rendering:pixelated;display:block"></canvas></div><div class="c2-bot" style="display:flex;gap:8px;flex-wrap:wrap;justify-content:center"></div>';
  document.body.append(box);
  const cv = box.querySelector('canvas'), c = cv.getContext('2d', { alpha: false }); c.imageSmoothingEnabled = false;
  const btn = (label, fn, hold) => { const b = document.createElement('button'); b.textContent = label; b.style.cssText = 'font:11px Pixel,monospace;padding:8px 12px;background:#2a3540;color:#f2efe6;border:2px solid #4a5a68;border-radius:4px;cursor:pointer';
    if (hold) { const on = (e) => { e.preventDefault(); keys.add(hold); if (hold === 'jump') jump(); if (hold === 'hit') hit(); }, off = () => keys.delete(hold); b.addEventListener('pointerdown', on); b.addEventListener('pointerup', off); b.addEventListener('pointerleave', off); b.addEventListener('pointercancel', off); }
    else b.addEventListener('click', fn); return b; };
  const top = box.querySelector('.c2-top'), bot = box.querySelector('.c2-bot'), title = document.createElement('span');
  title.style.cssText = 'padding:8px 10px;min-width:260px;text-align:center;color:#e8c66a';
  top.append(btn('◀ CENÁRIO', () => go(-1)), title, btn('CENÁRIO ▶', () => go(1)));
  bot.append(btn('◀', null, 'left'), btn('▶', null, 'right'), btn('PULAR', null, 'jump'), btn('BATER', null, 'hit'));
  HOURS.forEach(([n], i) => bot.append(btn(n, () => { hour = i; })));
  bot.append(btn('FECHAR', close));
  function go(d) { idx = (idx + d + L.length) % L.length; P.x = 300; P.y = FLOOR; P.vy = 0; cam = 0; if (L[idx].noite) hour = 3; }
  function close() { open = false; box.remove(); try { window.DayTime?.force?.(null); } catch (e) {} }
  function jump() { if (P.ground) { P.vy = -620; P.ground = false; } }
  function hit() { if (atkT <= 0) atkT = .32; }
  addEventListener('keydown', (e) => { if (!open) return; const k = e.code;
    if (k === 'ArrowLeft' || k === 'KeyA') keys.add('left'); if (k === 'ArrowRight' || k === 'KeyD') keys.add('right');
    if (k === 'Space' || k === 'KeyW' || k === 'ArrowUp') jump(); if (k === 'KeyJ') hit();
    if (k === 'BracketLeft') go(-1); if (k === 'BracketRight') go(1); if (/^Digit[1-4]$/.test(k)) hour = Number(k.slice(5)) - 1; if (k === 'Escape') close();
    e.preventDefault(); e.stopImmediatePropagation(); }, true);
  addEventListener('keyup', (e) => { if (e.code === 'ArrowLeft' || e.code === 'KeyA') keys.delete('left'); if (e.code === 'ArrowRight' || e.code === 'KeyD') keys.delete('right'); }, true);
  // chão e plataformas (só por cima) e vãos
  function physics(d, dt) {
    const dir = (keys.has('right') ? 1 : 0) - (keys.has('left') ? 1 : 0); if (dir) P.facing = dir;
    P.vx = dir * 260; P.x = Math.max(40, Math.min(d.largura - 40, P.x + P.vx * dt));
    const prevY = P.y; P.vy = Math.min(900, P.vy + 1700 * dt); P.y += P.vy * dt; P.ground = false;
    const overGap = d.vaos.some(([gx, gw]) => P.x > gx + 10 && P.x < gx + gw - 10);
    if (P.vy >= 0) { for (const [px, py, pw] of d.plataformas) if (P.x > px - 6 && P.x < px + pw + 6 && prevY <= py + 2 && P.y >= py) { P.y = py; P.vy = 0; P.ground = true; } if (!P.ground && !overGap && P.y >= FLOOR) { P.y = FLOOR; P.vy = 0; P.ground = true; } }
    if (P.y > 600) { P.x = Math.max(60, P.x - 260); P.y = FLOOR - 200; P.vy = 0; } // caiu no vão: volta um pouco
    atkT = Math.max(0, atkT - dt); P.attack = atkT;
  }
  function frame(now) {
    if (!open) return;
    const dt = Math.min(.05, (now - last) / 1000); last = now; t += dt;
    const d = L[idx]; physics(d, dt);
    cam += ((Math.max(0, Math.min(d.largura - 960, P.x - 360))) - cam) * Math.min(1, dt * 8);
    try { window.DayTime?.force?.(HOURS[hour][1]); } catch (e) {}
    const o = { scene: d.id, camera: cam, time: t, player: P, shots: [], enemies: [], minions: [] };
    try { window.Interact?.update?.(dt, o); } catch (e) {} window.CampanhaCenarios.heroi?.(P.x, P.y, P.vy);
    window.Art.drawScene(c, d.id, cam, t);
    c.save(); c.translate(-Math.round(cam), 0);
    for (const pl of d.plataformas) if (pl[0] + pl[2] > cam - 20 && pl[0] < cam + 980) window.CampanhaCenarios.plataforma(c, d.id, pl, t);
    window.Interact?.drawBack?.(c, o); window.CampanhaPlantas?.drawBack?.(c, o);
    window.Art.drawCharacter(c, 'daroca', P.x, P.y, { frame: t, facing: P.facing, moving: !!P.vx && P.ground, grounded: P.ground, vy: P.vy, attack: atkT > 0, attackType: 'paper', attackProgress: 1 - atkT / .32 });
    window.Interact?.drawFront?.(c, o); window.CampanhaPlantas?.drawFront?.(c, o);
    c.restore();
    if (window.Graphics?.isShader?.()) window.Shader?.apply?.(cv, { scene: d.id, camera: cam, time: t, outdoor: !d.interno });
    title.textContent = (d.id - 11) + '/10 · ' + d.nome.toUpperCase();
    requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
  window.CampanhaVisualizador = Object.freeze({ go: (i) => { idx = Math.max(0, Math.min(L.length - 1, i)); P.x = 300; P.y = FLOOR; cam = 0; }, hora: (i) => { hour = i; }, ir: (x) => { P.x = x; }, bater: hit, fechar: close, jogador: () => ({ ...P }) });
})();
