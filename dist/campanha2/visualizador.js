/* Campanha 2 · Visualizador dos cenários (para conferir o Passo 2 antes de ligar na campanha).
   Abra o jogo com ?cenarios2 no fim do endereço (ex.: .../index.html?cenarios2).
   Setas, A/D ou os botões ◀ ▶ andam; [ ] ou os botões trocam o cenário; 1 a 4 trocam a hora;
   Esc fecha. Da Roça anda pelo chão; as tábuas mostram onde ficam as plataformas da fase. */
(() => {
  'use strict';
  if (!/[?&]cenarios2\b/.test(location.search) || !window.CampanhaCenarios || !window.Art) return;
  const L = window.CampanhaCenarios.lista;
  const HOURS = [['MANHÃ', 7], ['TARDE', 15], ['PÔR DO SOL', 17.4], ['NOITE', 21]];
  let idx = 0, cam = 0, x = 300, face = 1, hour = 1, keys = new Set(), last = performance.now(), t = 0, moving = false, open = true;
  const box = document.createElement('div');
  box.style.cssText = 'position:fixed;inset:0;z-index:100000;background:#0b0f14;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;font:12px Pixel,monospace;color:#f2efe6;touch-action:none';
  box.innerHTML = '<div class="c2-top" style="display:flex;gap:6px;flex-wrap:wrap;justify-content:center"></div><div style="position:relative;width:min(100vw,177.7vh);max-height:calc(100vh - 120px);aspect-ratio:16/9"><canvas id="c2Viewer" width="960" height="540" style="width:100%;height:100%;image-rendering:pixelated;display:block"></canvas></div><div class="c2-bot" style="display:flex;gap:8px;flex-wrap:wrap;justify-content:center"></div>';
  document.body.append(box);
  const cv = box.querySelector('canvas'), c = cv.getContext('2d', { alpha: false }); c.imageSmoothingEnabled = false;
  const btn = (label, fn, hold) => { const b = document.createElement('button'); b.textContent = label; b.style.cssText = 'font:11px Pixel,monospace;padding:8px 12px;background:#2a3540;color:#f2efe6;border:2px solid #4a5a68;border-radius:4px;cursor:pointer';
    if (hold) { const on = (e) => { e.preventDefault(); keys.add(hold); }, off = () => keys.delete(hold); b.addEventListener('pointerdown', on); b.addEventListener('pointerup', off); b.addEventListener('pointerleave', off); b.addEventListener('pointercancel', off); }
    else b.addEventListener('click', fn); return b; };
  const top = box.querySelector('.c2-top'), bot = box.querySelector('.c2-bot'), title = document.createElement('span');
  title.style.cssText = 'padding:8px 10px;min-width:260px;text-align:center;color:#e8c66a';
  top.append(btn('◀ CENÁRIO', () => go(-1)), title, btn('CENÁRIO ▶', () => go(1)));
  bot.append(btn('◀', null, 'left'), btn('▶', null, 'right'));
  HOURS.forEach(([n], i) => bot.append(btn(n, () => { hour = i; })));
  bot.append(btn('FECHAR', close));
  function go(d) { idx = (idx + d + L.length) % L.length; x = 300; cam = 0; if (L[idx].noite) hour = 3; }
  function close() { open = false; box.remove(); try { window.DayTime?.force?.(null); } catch (e) {} }
  addEventListener('keydown', (e) => { if (!open) return; const k = e.code;
    if (k === 'ArrowLeft' || k === 'KeyA') keys.add('left'); if (k === 'ArrowRight' || k === 'KeyD') keys.add('right');
    if (k === 'BracketLeft') go(-1); if (k === 'BracketRight') go(1); if (/^Digit[1-4]$/.test(k)) hour = Number(k.slice(5)) - 1; if (k === 'Escape') close();
    e.stopImmediatePropagation(); }, true);
  addEventListener('keyup', (e) => { if (e.code === 'ArrowLeft' || e.code === 'KeyA') keys.delete('left'); if (e.code === 'ArrowRight' || e.code === 'KeyD') keys.delete('right'); }, true);
  function frame(now) {
    if (!open) return;
    const dt = Math.min(.05, (now - last) / 1000); last = now; t += dt;
    const d = L[idx], W = d.largura, dir = (keys.has('right') ? 1 : 0) - (keys.has('left') ? 1 : 0);
    moving = dir !== 0; if (moving) face = dir; x = Math.max(40, Math.min(W - 40, x + dir * 260 * dt));
    cam += ((Math.max(0, Math.min(W - 960, x - 360))) - cam) * Math.min(1, dt * 8);
    try { window.DayTime?.force?.(HOURS[hour][1]); } catch (e) {}
    window.Art.drawScene(c, d.id, cam, t);
    c.save(); c.translate(-Math.round(cam), 0);
    for (const [px, py, pw] of d.plataformas) if (px + pw > cam - 20 && px < cam + 980) { c.fillStyle = '#3e2a1a'; c.fillRect(px - 2, py, pw + 4, 14); c.fillStyle = '#8d6a45'; c.fillRect(px, py + 2, pw, 10); c.fillStyle = '#c4955c'; c.fillRect(px, py + 2, pw, 2); }
    window.Art.drawCharacter(c, 'daroca', x, 440, { frame: t, facing: face, moving, grounded: true, cold: true });
    c.restore();
    if (window.Graphics?.isShader?.()) window.Shader?.apply?.(cv, { scene: d.id, camera: cam, time: t, outdoor: !d.interno });
    title.textContent = (d.id - 11) + '/10 · ' + d.nome.toUpperCase();
    requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
  window.CampanhaVisualizador = Object.freeze({ go: (i) => { idx = Math.max(0, Math.min(L.length - 1, i)); x = 300; cam = 0; }, hora: (i) => { hour = i; }, fechar: close });
})();
