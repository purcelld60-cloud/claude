/* Da Roça Adventure — menu principal enxuto.
   Na tela inicial ficam só três botões: JOGAR, MULTIPLAYER e DIÁRIO E TURMA.
   - JOGAR: Campanha 1 (NOVA AVENTURA / CONTINUAR) e Campanha 2 (só depois de terminar a 1).
     O botão "+" mostra o resto: Dupla online, Terreiro dos Chefes, Fliperama (e as Cutscenes no modo dev).
   - MULTIPLAYER: Arena online e Modo TV.
   Os botões são os originais de cada modo, só mudam de lugar: nenhuma função se perde. */
(() => {
  'use strict';
  const tela = document.getElementById('startScreen'); if (!tela || window.MenuInicio) return;
  const menu = tela.querySelector('.start-menu'), listaVelha = tela.querySelector('.ranch-mode-entries'); if (!menu) return;

  const novo = (id, cls, html) => { const b = document.createElement('button'); b.type = 'button'; b.id = id; b.className = cls; b.innerHTML = html; return b; };
  const jogar = novo('menuJogarBtn', 'primary-btn title-start menu-jogar', '<span>▶</span> JOGAR');
  const multi = novo('menuMultiBtn', 'menu-coop-button menu-multi', '<b aria-hidden="true">👥</b> MULTIPLAYER');

  const painel = document.createElement('div'); painel.className = 'menu-escolha'; painel.hidden = true; painel.setAttribute('role', 'dialog');
  painel.innerHTML = `<div class="me-caixa"><h3 class="me-titulo"></h3>
    <div class="me-pagina" data-pg="jogar">
      <div class="me-camp me-c1"><b>CAMPANHA 1 · ITABUNA</b><small>A missão do bolo de sapo</small><div class="me-bts"></div></div>
      <div class="me-camp me-c2"><b>CAMPANHA 2 · VITÓRIA DA CONQUISTA</b><small class="me-c2-info"></small><div class="me-bts ranch-mode-entries"></div></div>
      <button type="button" class="me-mais" aria-expanded="false">＋ MAIS MODOS</button>
      <div class="me-extra ranch-mode-entries" hidden></div>
    </div>
    <div class="me-pagina" data-pg="multi"><div class="me-lista ranch-mode-entries"></div></div>
    <button type="button" class="me-voltar">◀ VOLTAR</button></div>`;
  tela.appendChild(painel);
  const $ = (s) => painel.querySelector(s), c1 = $('.me-c1 .me-bts'), c2 = $('.me-c2 .me-bts'), extra = $('.me-extra'), multiLista = $('.me-lista');

  // para onde vai cada botão que os outros arquivos põem na tela inicial
  function destino(b) {
    if (b === jogar || b === multi || b.id === 'adventureInfoBtn') return menu;
    if (b.id === 'startBtn' || b.id === 'continueBtn') return c1;
    if (b.hasAttribute('data-open-campanha2')) return c2;
    if (b.hasAttribute('data-open-arena') || b.hasAttribute('data-open-tv')) return multiLista;
    if (b.id === 'partyEntryBtn') return null; // a Festa (party) saiu do jogo
    return extra; // dupla online, terreiro dos chefes, fliperama, cutscenes (dev) e o que vier
  }
  let obs = null;
  function arrumar() {
    obs?.disconnect(); // enquanto arruma, não reage às próprias mudanças
    try {
      for (const b of [...menu.children, ...(listaVelha ? [...listaVelha.children] : [])]) { if (b.tagName !== 'BUTTON') continue; const d = destino(b); if (d === null) { b.remove(); continue; }
        // o mesmo modo não aparece duas vezes (alguns arquivos recolocam o botão se não acham no lugar antigo)
        const chave = [...b.attributes].find((a) => a.name.startsWith('data-open-'))?.name; if (chave && b.parentElement !== d && painel.querySelector(`[${chave}]`)) { b.remove(); continue; }
        if (d !== b.parentElement) d.appendChild(b); }
      // ordem da tela principal: JOGAR, MULTIPLAYER, DIÁRIO E TURMA
      const diario = document.getElementById('adventureInfoBtn'); if (menu.firstElementChild !== jogar) menu.prepend(jogar); if (jogar.nextElementSibling !== multi) jogar.after(multi); if (diario && multi.nextElementSibling !== diario) multi.after(diario);
      // continuar vem antes de nova aventura
      const cont = document.getElementById('continueBtn'), ini = document.getElementById('startBtn'); if (cont && ini && cont.parentElement === c1 && cont.nextElementSibling !== ini) c1.insertBefore(cont, ini);
      if (listaVelha && !listaVelha.hidden) listaVelha.hidden = true;
      $('.me-mais').hidden = !extra.children.length;
    } finally { if (obs) { obs.observe(menu, { childList: true }); if (listaVelha) obs.observe(listaVelha, { childList: true }); } }
  }
  // Campanha 2 trava até terminar a Campanha 1
  function travaC2() {
    const ok = !!window.Campanha2?.liberada?.(), b = c2.querySelector('[data-open-campanha2]');
    $('.me-c2-info').textContent = ok ? 'Um ano depois · a busca pelo Jorge' : '🔒 Termine a Campanha 1 para liberar';
    painel.querySelector('.me-c2').classList.toggle('travada', !ok); if (b) { b.disabled = !ok; b.setAttribute('aria-disabled', String(!ok)); const sm = b.querySelector('small'); if (sm) sm.textContent = ok ? 'Um ano depois · a busca pelo Jorge' : 'Termine a Campanha 1'; }
  }
  function abrir(pg) {
    arrumar(); travaC2(); painel.hidden = false; painel.dataset.pg = pg;
    $('.me-titulo').textContent = pg === 'multi' ? 'MULTIPLAYER' : 'JOGAR';
    for (const p of painel.querySelectorAll('.me-pagina')) p.hidden = p.dataset.pg !== pg;
    mais(false); requestAnimationFrame(() => (painel.querySelector(`.me-pagina[data-pg="${pg}"] button:not([hidden]):not([disabled])`))?.focus());
  }
  function fechar() { painel.hidden = true; jogar.focus?.({ preventScroll: true }); }
  function mais(v) { extra.hidden = !v; const b = $('.me-mais'); b.setAttribute('aria-expanded', String(v)); b.textContent = v ? '－ MENOS MODOS' : '＋ MAIS MODOS'; }

  jogar.addEventListener('click', () => abrir('jogar'));
  multi.addEventListener('click', () => abrir('multi'));
  $('.me-voltar').addEventListener('click', fechar);
  $('.me-mais').addEventListener('click', () => mais(extra.hidden));
  painel.addEventListener('keydown', (e) => { if (e.key === 'Escape') { e.preventDefault(); e.stopPropagation(); fechar(); } });
  painel.addEventListener('click', (e) => { if (e.target === painel) fechar(); });
  // voltou para a tela inicial: menu fechado de novo
  new MutationObserver(() => { if (tela.hidden || getComputedStyle(tela).display === 'none') painel.hidden = true; }).observe(tela, { attributes: true, attributeFilter: ['hidden', 'style', 'class'] });
  // botões que outros arquivos acrescentam depois também vão para o lugar certo
  obs = new MutationObserver(() => arrumar());
  arrumar(); if (document.readyState === 'loading') addEventListener('DOMContentLoaded', arrumar); addEventListener('load', arrumar);

  window.MenuInicio = Object.freeze({ abrir, fechar, arrumar });
})();
