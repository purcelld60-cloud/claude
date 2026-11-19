/* Campanha 2 · Visualizador dos cenários (para conferir o Passo 2 antes de ligar na campanha).
   Abra o jogo com ?cenarios2 no fim do endereço (ex.: .../index.html?cenarios2).
   Setas ou A/D andam · Espaço ou W pula · J bate · E (ou o botão que aparece) entra nas portas,
   sobe a escada rolante e usa o computador · [ ] trocam o cenário · 1 a 4 trocam a hora · Esc fecha.
   Os objetos interativos usam o mesmo sistema da campanha principal (Interact) e as passagens vêm
   de CampanhaAmbientes (portas, escada rolante, escada da escola e o computador do quarto). */
(() => {
  'use strict';
  if (!/[?&]cenarios2\b/.test(location.search) || !window.CampanhaCenarios || !window.Art) return;
  const L = window.CampanhaCenarios.lista, FLOOR = 440;
  const HOURS = [['MANHÃ', 7], ['TARDE', 15], ['PÔR DO SOL', 17.4], ['NOITE', 21]];
  const P = { x: 300, y: FLOOR, vx: 0, vy: 0, ground: true, facing: 1, attack: 0 };
  let idx = 0, cam = 0, hour = 1, keys = new Set(), last = performance.now(), t = 0, open = true, atkT = 0;
  let viagem = null, fade = 0, perto = null; // viagem: escada rolante / troca de cena em andamento
  const portais = (id) => window.CampanhaAmbientes?.portais?.(id) || [];
  const box = document.createElement('div');
  box.style.cssText = 'position:fixed;inset:0;z-index:100000;background:#0b0f14;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;font:12px Pixel,monospace;color:#f2efe6;touch-action:none';
  box.innerHTML = '<div class="c2-top" style="display:flex;gap:6px;flex-wrap:wrap;justify-content:center"></div><div class="c2-tela" style="position:relative;width:min(100vw,177.7vh);max-height:calc(100vh - 120px);aspect-ratio:16/9"><canvas id="c2Viewer" width="960" height="540" style="width:100%;height:100%;image-rendering:pixelated;display:block"></canvas><button class="c2-entrar" hidden style="position:absolute;right:3%;bottom:6%;font:12px Pixel,monospace;padding:12px 16px;background:#e8a83a;color:#1c1408;border:3px solid #fff2c8;border-radius:6px;cursor:pointer;box-shadow:0 4px 0 #8a5a1a"></button></div><div class="c2-bot" style="display:flex;gap:8px;flex-wrap:wrap;justify-content:center"></div>';
  document.body.append(box);
  const cv = box.querySelector('canvas'), c = cv.getContext('2d', { alpha: false }); c.imageSmoothingEnabled = false;
  const entrar = box.querySelector('.c2-entrar'); entrar.addEventListener('click', () => usar());
  const btn = (label, fn, hold) => { const b = document.createElement('button'); b.textContent = label; b.style.cssText = 'font:11px Pixel,monospace;padding:8px 12px;background:#2a3540;color:#f2efe6;border:2px solid #4a5a68;border-radius:4px;cursor:pointer';
    if (hold) { const on = (e) => { e.preventDefault(); keys.add(hold); if (hold === 'jump') jump(); if (hold === 'hit') hit(); }, off = () => keys.delete(hold); b.addEventListener('pointerdown', on); b.addEventListener('pointerup', off); b.addEventListener('pointerleave', off); b.addEventListener('pointercancel', off); }
    else b.addEventListener('click', fn); return b; };
  const top = box.querySelector('.c2-top'), bot = box.querySelector('.c2-bot'), title = document.createElement('span');
  title.style.cssText = 'padding:8px 10px;min-width:260px;text-align:center;color:#e8c66a';
  top.append(btn('◀ CENÁRIO', () => go(-1)), title, btn('CENÁRIO ▶', () => go(1)));
  bot.append(btn('◀', null, 'left'), btn('▶', null, 'right'), btn('PULAR', null, 'jump'), btn('BATER', null, 'hit'));
  HOURS.forEach(([n], i) => bot.append(btn(n, () => { hour = i; })));
  bot.append(btn('TREINO (P)', () => alternarTreino()), btn('MURAL', () => window.CampanhaPoderes?.abrirMural?.({ teste: true })), btn('FECHAR', close));
  function alternarTreino() { const TR = window.CampanhaTreino; if (!TR) return; if (!box.querySelector('.c2-treino-wrap')) TR.montarBarra(box.querySelector('.c2-tela'), (id, down) => { if (TR.acao(id, down, P)) return; if (id === 'jump') { if (down) { keys.add('jump'); jump(); } else keys.delete('jump'); } if (id === 'interact' && down) usar(); }); TR.ligar(undefined, P); }
  const idxOf = (id) => Math.max(0, L.findIndex((d) => d.id === id));
  function go(d) { idx = (idx + d + L.length) % L.length; P.x = 300; P.y = FLOOR; P.vy = 0; cam = 0; viagem = null; if (L[idx].noite) hour = 3; }
  function irPara(id, x) { idx = idxOf(id); P.x = x; P.y = FLOOR; P.vy = 0; P.ground = true; cam = Math.max(0, Math.min(L[idx].largura - 960, x - 360)); if (L[idx].noite) hour = 3; }
  function close() { open = false; box.remove(); try { window.DayTime?.force?.(null); } catch (e) {} }
  function jump() { if (P.ground && !viagem) { P.vy = -620; P.ground = false; } }
  function hit() { if (atkT <= 0 && !viagem) atkT = .32; }
  // usar a passagem mais perto: porta (escurece e troca), escada rolante (sobe/desce andando sozinho) ou computador
  const cobre = () => !!(window.Fliperama?.isOpen?.() || window.DarocaLook?.isOpen?.() || window.CampanhaPoderes?.muralAberto?.() || window.Mapa3D?.aberto?.() || window.CampanhaLoja?.aberta?.()); // telas que cobrem o visualizador
  const ocupado = () => cobre() || !!window.CampanhaMoradores?.aberto?.(); // e a conversa, que só pausa o controle // Fliperama ou armário abertos por cima
  function usar() {
    if (viagem || !perto) return; const p = perto;
    if (p.tipo === 'extra') { keys.clear(); if (p.id === 'loja') window.CampanhaLoja?.abrir?.({ teste: true }); else window.CampanhaTaxi?.abrir?.(L[idx].id, (cena, x) => { viagem = null; fade = 0; irPara(cena, x + 120); }); return; }
    if (p.tipo === 'poderes') { keys.clear(); window.CampanhaPoderes?.abrirMural?.({ teste: true }); return; }
    if (p.tipo === 'conversa') { keys.clear(); window.CampanhaMoradores?.conversar?.(p.id); return; }
    if (p.tipo === 'armario') { if (window.DarocaLook?.open) { keys.clear(); window.DarocaLook.open({ title: 'ARMÁRIO DO QUARTO 4', line: 'Escolha a roupa do Da Roça para hoje.' }); } return; }
    if (p.tipo === 'pc') { if (window.Fliperama?.open) { keys.clear(); window.Fliperama.open(null, { from: 'quarto' }); } return; }
    if (p.tipo === 'rolante') { keys.clear(); viagem = { tipo: 'rolante', t: 0, dur: 2.2, de: [P.x, P.y], ini: p.de, fim: p.ate, para: p.para }; return; }
    keys.clear(); viagem = { tipo: 'porta', t: 0, para: p.para };
  }
  addEventListener('keydown', (e) => { if (!open || ocupado()) return; const k = e.code;
    if (k === 'ArrowLeft' || k === 'KeyA') keys.add('left'); if (k === 'ArrowRight' || k === 'KeyD') keys.add('right');
    const TR = window.CampanhaTreino, treino = TR?.ligado?.(), mapa = { KeyJ: 'paper', KeyK: 'fart', KeyL: 'dash', KeyU: 'poder1', KeyI: 'poder2' };
    if (k === 'KeyP') alternarTreino(); if (treino && mapa[k] && !e.repeat) TR.acao(mapa[k], true, P);
    if (k === 'Space' || k === 'KeyW' || k === 'ArrowUp') { keys.add('jump'); jump(); if (treino) TR.acao('jump', true, P); } if (k === 'KeyJ' && !treino) hit(); if (k === 'KeyE' || k === 'Enter') usar();
    if (k === 'BracketLeft') go(-1); if (k === 'BracketRight') go(1); if (/^Digit[1-4]$/.test(k)) hour = Number(k.slice(5)) - 1; if (k === 'Escape') close();
    e.preventDefault(); e.stopImmediatePropagation(); }, true);
  addEventListener('keyup', (e) => { const TR = window.CampanhaTreino; if (TR?.ligado?.()) { if (e.code === 'KeyU') TR.acao('poder1', false, P); if (e.code === 'KeyI') TR.acao('poder2', false, P); if (e.code === 'Space' || e.code === 'KeyW' || e.code === 'ArrowUp') TR.acao('jump', false, P); } if (e.code === 'Space' || e.code === 'KeyW' || e.code === 'ArrowUp') keys.delete('jump');
    if (e.code === 'ArrowLeft' || e.code === 'KeyA') keys.delete('left'); if (e.code === 'ArrowRight' || e.code === 'KeyD') keys.delete('right'); }, true);
  // chão, plataformas (só por cima), vãos e rampas (escada da escola)
  function physics(d, dt) {
    const dir = (keys.has('right') ? 1 : 0) - (keys.has('left') ? 1 : 0); if (dir) P.facing = dir;
    const TR = window.CampanhaTreino; P.vx = TR?.dashing?.() ? P.vx : dir * 260 * (TR?.velocidade?.() || 1); const lim = d.limites || [40, d.largura - 40]; P.x = Math.max(lim[0], Math.min(lim[1], P.x + P.vx * dt)); // interiores estilo Terraria têm paredes
    const prevY = P.y; P.vy = Math.min(900, P.vy + 1700 * dt); P.y += P.vy * dt; P.ground = false;
    const overGap = d.vaos.some(([gx, gw]) => P.x > gx + 10 && P.x < gx + gw - 10);
    for (const r of portais(d.id)) if (r.tipo === 'rampa' && P.x >= r.x0 && P.x <= r.x1) { const ry = r.y0 + (r.y1 - r.y0) * (P.x - r.x0) / (r.x1 - r.x0); if (P.vy >= 0 && P.y >= ry - 14 && prevY <= ry + 40) { P.y = ry; P.vy = 0; P.ground = true; } if (P.x >= r.x1 - 4 && P.ground && dir > 0) viagem = { tipo: 'porta', t: 0, para: r.para }; }
    if (P.vy >= 0 && !P.ground) { for (const [px, py, pw] of d.plataformas) if (P.x > px - 6 && P.x < px + pw + 6 && prevY <= py + 2 && P.y >= py) { P.y = py; P.vy = 0; P.ground = true; } if (!P.ground && !overGap && P.y >= FLOOR) { P.y = FLOOR; P.vy = 0; P.ground = true; } }
    if (P.y > 600) { P.x = Math.max(60, P.x - 260); P.y = FLOOR - 200; P.vy = 0; } // caiu no vão: volta um pouco
    atkT = Math.max(0, atkT - dt); P.attack = atkT;
  }
  function andarViagem(dt) {
    const v = viagem; v.t += dt;
    if (v.tipo === 'rolante') { const u = Math.min(1, v.t / v.dur), k = u < .15 ? 0 : (u - .15) / .85; P.x = (k <= 0 ? v.de[0] + (v.ini[0] - v.de[0]) * (u / .15) : v.ini[0] + (v.fim[0] - v.ini[0]) * k); P.y = k <= 0 ? FLOOR : v.ini[1] + (v.fim[1] - v.ini[1]) * k; P.facing = v.fim[0] > v.ini[0] ? 1 : -1; P.vx = 0; P.ground = true; fade = Math.max(0, (u - .78) / .22); if (u >= 1) { irPara(v.para.cena, v.para.x); viagem = { tipo: 'chegada', t: 0 }; } return; }
    if (v.tipo === 'porta') { fade = Math.min(1, v.t / .35); P.vx = 0; if (v.t >= .35) { irPara(v.para.cena, v.para.x); viagem = { tipo: 'chegada', t: 0 }; } return; }
    if (v.tipo === 'chegada') { fade = Math.max(0, 1 - v.t / .35); if (v.t >= .35) { viagem = null; fade = 0; } }
  }
  function frame(now) {
    if (!open) return;
    const dt = Math.min(.05, (now - last) / 1000); last = now;
    const fl = cobre(); if (window.CampanhaMoradores?.aberto?.()) { keys.clear(); P.vx = 0; } box.style.visibility = fl ? 'hidden' : 'visible'; if (fl) { requestAnimationFrame(frame); return; }
    t += dt; const d = L[idx];
    window.CampanhaTreino?.passo?.(dt, P, { cam, segurandoPulo: keys.has('jump') });
    if (viagem) andarViagem(dt); else physics(d, dt);
    const D = L[idx]; cam += ((Math.max(0, Math.min(D.largura - 960, P.x - 360))) - cam) * Math.min(1, dt * 8);
    try { window.DayTime?.force?.(HOURS[hour][1]); } catch (e) {}
    const o = { scene: D.id, camera: cam, time: t, player: P, shots: [], enemies: [], minions: [] };
    try { window.Interact?.update?.(dt, o); } catch (e) {} window.CampanhaCenarios.heroi?.(P.x, P.y, P.vy);
    window.Art.drawScene(c, D.id, cam, t);
    c.save(); { const sh = window.CampanhaTreino?.tremor?.() || 0; c.translate(-Math.round(cam) + Math.round((Math.random() - .5) * sh), Math.round((Math.random() - .5) * sh)); }
    for (const pl of D.plataformas) if (pl[0] + pl[2] > cam - 20 && pl[0] < cam + 980) window.CampanhaCenarios.plataforma(c, D.id, pl, t);
    window.Interact?.drawBack?.(c, o); window.CampanhaPlantas?.drawBack?.(c, o); window.CampanhaTaxi?.desenhar?.(c, o); window.CampanhaLoja?.desenhar?.(c, o); window.CampanhaMoradores?.desenhar?.(c, o);
    window.Art.drawCharacter(c, 'daroca', P.x, P.y, { frame: t, facing: P.facing, moving: (!!P.vx && P.ground) || viagem?.tipo === 'porta', grounded: P.ground, vy: P.vy, attack: atkT > 0, attackType: 'paper', attackProgress: 1 - atkT / .32 });
    window.CampanhaTreino?.desenhar?.(c, t);
    window.Interact?.drawFront?.(c, o); window.CampanhaPlantas?.drawFront?.(c, o); window.CampanhaCamadas?.primeiroPlano?.(c, o);
    // passagem mais perto: balão "[E] ..." em cima e o botão grande na tela
    perto = null; if (!viagem && P.ground) { let best = 1e9; for (const p of portais(D.id)) { if (p.tipo === 'rampa') continue; const dd = Math.abs(p.x - P.x); if (dd < 70 && dd < best) { best = dd; perto = p; } } const m = window.CampanhaMoradores?.perto?.(D.id, P.x); if (m && Math.abs(m.x - P.x) < best) perto = { tipo: 'conversa', id: m.id, x: m.x, rotulo: 'CONVERSAR COM ' + m.nome.toUpperCase() };
      for (const X of [window.CampanhaTaxi, window.CampanhaLoja]) { const e = X?.perto?.(D.id, P.x); if (e && (!perto || Math.abs(e.x - P.x) < Math.abs(perto.x - P.x))) perto = { tipo: 'extra', ...e }; } }
    if (perto) { const w = perto.rotulo.length * 7.6 + 34, x = perto.x, y = FLOOR - 150; c.fillStyle = '#1c342de8'; c.fillRect(x - w / 2, y - 13, w, 26); c.strokeStyle = '#e8c66a'; c.strokeRect(x - w / 2 + .5, y - 12.5, w - 1, 25); c.font = '11px Pixel, monospace'; c.textAlign = 'center'; c.textBaseline = 'middle'; c.fillStyle = '#f3d89e'; c.fillText('[E] ' + perto.rotulo, x, y + 1); }
    c.restore(); window.CampanhaAmbientes?.cobrir?.(c, D.id, cam);
    entrar.hidden = !perto; if (perto) entrar.textContent = perto.tipo === 'extra' ? perto.botao : perto.tipo === 'conversa' ? 'FALAR' : perto.tipo === 'poderes' ? 'PODERES' : perto.tipo === 'pc' ? 'USAR' : perto.tipo === 'armario' ? 'ABRIR' : perto.tipo === 'rolante' ? (perto.ate[1] < FLOOR ? 'SUBIR' : 'DESCER') : /^SAIR|DESCER/.test(perto.rotulo) ? 'SAIR' : 'ENTRAR';
    if (window.Graphics?.isShader?.()) window.Shader?.apply?.(cv, { scene: D.id, camera: cam, time: t, outdoor: !D.interno });
    if (fade > 0) { c.fillStyle = `rgba(8,10,14,${fade})`; c.fillRect(0, 0, 960, 540); }
    title.textContent = (idx + 1) + '/' + L.length + ' · ' + D.nome.toUpperCase();
    requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
  window.CampanhaVisualizador = Object.freeze({ go: (i) => { idx = Math.max(0, Math.min(L.length - 1, i)); P.x = 300; P.y = FLOOR; cam = 0; viagem = null; }, cena: (id, x = 300) => { viagem = null; fade = 0; irPara(id, x); }, hora: (i) => { hour = i; }, ir: (x) => { P.x = x; }, bater: hit, usar, fechar: close, jogador: () => ({ ...P }), estado: () => ({ cena: L[idx].id, viagem: viagem?.tipo || null, perto: perto?.rotulo || null }) });
})();
