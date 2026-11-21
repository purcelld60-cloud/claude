/* Da Roça Adventure — Campanha 2: mudar os botões de lugar no celular.
   Arraste o joystick e cada botão para onde quiser e ajuste o tamanho. Fica salvo neste aparelho
   (daroca-c2-layout-v2, separado dos saves). RESTAURAR volta tudo ao lugar de fábrica.
   API: CampanhaBotoes.aplicar(tela), CampanhaBotoes.editar(tela, aoFechar). */
(() => {
  'use strict';
  if (window.CampanhaBotoes) return;
  const KEY = 'daroca-c2-layout-v2'; // v2: os botões agora são a cópia da campanha 1 (o layout antigo não vale mais)
  let L = {}; try { const r = JSON.parse(localStorage.getItem(KEY) || 'null'); if (r && typeof r === 'object') L = r; } catch (e) {}
  const salvar = () => { try { if (Object.keys(L).length) localStorage.setItem(KEY, JSON.stringify(L)); else localStorage.removeItem(KEY); } catch (e) {} };
  const NOMES = { joy: 'Joystick', jump: 'Pular', paper: 'Papel', fart: 'Peido', dash: 'Dash', interact: 'Falar', poder1: 'Poder 1', poder2: 'Poder 2' };
  const alvos = (tela) => { const c1 = tela.closest('.c2j')?.querySelector('.c2-c1-shell') || tela.querySelector('.c2-c1-shell'); if (c1) return [['joy', c1.querySelector('.move-joystick')], ...[...c1.querySelectorAll('[data-action]')].map((b) => [b.dataset.action, b])].filter((x) => x[1]); return [['joy', tela.querySelector('.joy')], ...[...tela.querySelectorAll('.c2-treino-ctl [data-acao]')].map((b) => [b.dataset.acao, b])].filter((x) => x[1]); };
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));

  function aplicar(tela) {
    if (!tela) return; const tem = Object.keys(L).length > 0; tela.querySelector('.c2-treino-ctl')?.classList.toggle('livre', tem);
    for (const [id, el] of alvos(tela)) { const v = L[id];
      const c1 = el.closest('.c2-c1-shell'); if (c1 && el.dataset.c1Style === undefined) el.dataset.c1Style = el.getAttribute('style') || '';
      if (!tem || !v) { el.classList.remove('c2-livre'); if (c1) el.setAttribute('style', el.dataset.c1Style); else for (const k of ['left', 'top', 'right', 'bottom', 'transform', 'margin', 'position']) el.style[k] = ''; continue; }
      if (c1) { // cópia dos botões da campanha 1: usa o mesmo sistema de posição dela (centro em px dentro da camada dos controles)
        el.setAttribute('style', el.dataset.c1Style); const lay = (el.offsetParent || el.closest('.touch-controls'))?.getBoundingClientRect() || { left: 0, top: 0 }, base = parseFloat(getComputedStyle(el).getPropertyValue('--ccl-size')) || el.getBoundingClientRect().width || 50;
        el.style.setProperty('--ccl-x', (v.x / 100 * innerWidth - lay.left).toFixed(1) + 'px'); el.style.setProperty('--ccl-y', (v.y / 100 * innerHeight - lay.top).toFixed(1) + 'px'); el.style.setProperty('--ccl-size', Math.round(base * (v.s || 1)) + 'px'); el.classList.add('c2-livre'); continue; }
      el.classList.add('c2-livre'); el.style.left = v.x + '%'; el.style.top = v.y + '%'; el.style.right = 'auto'; el.style.bottom = 'auto'; el.style.margin = '0'; el.style.transform = `translate(-50%,-50%) scale(${v.s || 1})`; }
  }
  function fotografar(tela) { // guarda onde cada botão está agora, para começar a editar dali
    const r = tela.closest('.c2j')?.querySelector('.c2-c1-shell') ? { left: 0, top: 0, width: innerWidth, height: innerHeight } : tela.getBoundingClientRect(), novo = {};
    for (const [id, el] of alvos(tela)) { const b = el.getBoundingClientRect(); if (!b.width) continue; novo[id] = { x: +((b.left + b.width / 2 - r.left) / r.width * 100).toFixed(2), y: +((b.top + b.height / 2 - r.top) / r.height * 100).toFixed(2), s: L[id]?.s || 1 }; }
    L = novo; aplicar(tela);
  }

  function editar(tela, aoFechar) {
    if (!tela || tela.querySelector('.c2-editor')) return;
    // no computador o joystick fica escondido: mostra enquanto edita
    const joy = tela.querySelector('.joy'), joyDisp = joy?.style.display; if (joy) joy.style.display = 'block';
    const tinha = Object.keys(L).length > 0; fotografar(tela); tela.classList.add('c2-editando');
    let sel = 'joy', arrasta = null, mexeu = tinha;
    const ed = document.createElement('div'); ed.className = 'c2-editor';
    ed.innerHTML = `<div class="barra"><b>ARRASTE OS BOTÕES PARA ONDE QUISER</b><span class="nome"></span><label>TAMANHO <input type="range" min="60" max="170" step="5"></label><button type="button" data-a="restaurar">RESTAURAR</button><button type="button" data-a="pronto">PRONTO</button></div>`;
    tela.appendChild(ed);
    const range = ed.querySelector('input'), nome = ed.querySelector('.nome');
    const marcar = () => { for (const [id, el] of alvos(tela)) el.classList.toggle('c2-sel', id === sel); nome.textContent = (NOMES[sel] || sel).toUpperCase() + ':'; range.value = Math.round((L[sel]?.s || 1) * 100); };
    range.addEventListener('input', () => { if (!L[sel]) return; mexeu = true; L[sel].s = +range.value / 100; aplicar(tela); salvar(); });
    // pega o toque antes do botão: editando, o botão não ataca, só se move
    const baixo = (e) => { const hit = alvos(tela).find(([, el]) => el.contains(e.target)); if (!hit) return; e.preventDefault(); e.stopPropagation(); sel = hit[0]; marcar(); arrasta = e.pointerId; };
    const move = (e) => { if (arrasta !== e.pointerId || !L[sel]) return; mexeu = true; const r = tela.closest('.c2j')?.querySelector('.c2-c1-shell') ? { left: 0, top: 0, width: innerWidth, height: innerHeight } : tela.getBoundingClientRect(); L[sel].x = +clamp((e.clientX - r.left) / r.width * 100, 4, 96).toFixed(2); L[sel].y = +clamp((e.clientY - r.top) / r.height * 100, 6, 96).toFixed(2); aplicar(tela); };
    const cima = (e) => { if (arrasta === e.pointerId) { arrasta = null; salvar(); } };
    const bloqueia = (e) => { if (alvos(tela).some(([, el]) => el.contains(e.target))) { e.preventDefault(); e.stopPropagation(); } };
    const raiz = tela.closest('.c2j') || tela; raiz.addEventListener('pointerdown', baixo, true); window.addEventListener('pointermove', move); window.addEventListener('pointerup', cima, true); window.addEventListener('pointercancel', cima, true); // captura: o bloqueio dos botões não engole o "soltar"
    for (const ev of ['pointerup', 'pointerleave', 'click', 'touchstart']) raiz.addEventListener(ev, bloqueia, true);
    const fechar = () => { raiz.removeEventListener('pointerdown', baixo, true); window.removeEventListener('pointermove', move); window.removeEventListener('pointerup', cima, true); window.removeEventListener('pointercancel', cima, true);
      for (const ev of ['pointerup', 'pointerleave', 'click', 'touchstart']) raiz.removeEventListener(ev, bloqueia, true);
      ed.remove(); tela.classList.remove('c2-editando'); for (const [, el] of alvos(tela)) el.classList.remove('c2-sel'); if (joy) joy.style.display = joyDisp || ''; if (!mexeu) L = {}; salvar(); aplicar(tela); aoFechar?.(); };
    ed.querySelector('[data-a="pronto"]').addEventListener('click', fechar);
    ed.querySelector('[data-a="restaurar"]').addEventListener('click', () => { L = {}; salvar(); aplicar(tela); fotografar(tela); mexeu = false; marcar(); });
    marcar(); setTimeout(() => ed.querySelector('[data-a="pronto"]')?.focus(), 30);
  }

  window.CampanhaBotoes = Object.freeze({ aplicar, editar, layout: () => JSON.parse(JSON.stringify(L)), zerar: () => { L = {}; salvar(); } });
})();
