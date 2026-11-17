/* HUD minimalista: reorganiza a barra de cima já existente, sem mudar os ids que o jogo atualiza.
   No canto ficam só os corações e o número de papéis; o resto vai para dois painéis
   (DADOS e INVENTÁRIO). Os elementos são movidos, então tudo continua atualizando sozinho. */
(() => {
  'use strict';
  if (window.HudMinimal) return;
  const bar = document.querySelector('.game-topbar'), progress = document.querySelector('.progress-hud');
  if (!bar || bar.dataset.minimal) return;
  bar.dataset.minimal = '1';
  const $ = (s) => bar.querySelector(s) || document.querySelector(s);
  const el = (tag, cls, html) => { const e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; };
  const hearts = $('#hpValue'), ammo = $('.ammo'), playerInfo = $('.player-info'), gas = $('.gas-block'), inv = $('.inventory-hud'), loc = $('.location'), actions = $('.game-actions');
  const statsBtn = progress?.querySelector('#statsBtn'), xp = progress?.querySelector('.xp-block'), chapter = progress?.querySelector('#campaignChapter');
  if (!hearts || !ammo || !actions) return;

  // canto esquerdo: corações + papéis (+ medidor de gás só quando o gás não está cheio)
  const left = el('div', 'hud-min-left'), gasMini = el('div', 'hud-gas-mini', 'GÁS<i><b></b></i>');
  left.append(hearts, ammo, gasMini);

  // painéis
  const dataPanel = el('div', 'hud-panel', ''), invPanel = el('div', 'hud-panel', '');
  dataPanel.id = 'hudDataPanel'; invPanel.id = 'hudInvPanel'; dataPanel.hidden = invPanel.hidden = true;
  dataPanel.setAttribute('role', 'dialog'); dataPanel.setAttribute('aria-label', 'Dados'); invPanel.setAttribute('role', 'dialog'); invPanel.setAttribute('aria-label', 'Inventário');
  dataPanel.append(el('h3', '', 'DADOS'));
  if (playerInfo) dataPanel.append(playerInfo);
  if (gas) dataPanel.append(gas);
  if (loc) dataPanel.append(loc);
  if (statsBtn) dataPanel.append(statsBtn);
  if (xp) dataPanel.append(xp);
  if (chapter) dataPanel.append(chapter);
  invPanel.append(el('h3', '', 'INVENTÁRIO'));
  const paperRow = el('div', 'hud-row', '<span>◆ PAPEL</span><b id="hudPaperMirror">∞</b>');
  invPanel.append(paperRow);
  if (inv) invPanel.append(inv);
  invPanel.append(el('div', 'hud-sub', 'Materiais servem para o Kaua melhorar a sua arma.'));

  // botões
  const dataBtn = el('button', 'hud-btn', 'DADOS<span class="hud-dot"></span>'), invBtn = el('button', 'hud-btn', 'INVENTÁRIO');
  dataBtn.type = invBtn.type = 'button'; dataBtn.setAttribute('aria-expanded', 'false'); invBtn.setAttribute('aria-expanded', 'false');
  dataBtn.setAttribute('aria-controls', 'hudDataPanel'); invBtn.setAttribute('aria-controls', 'hudInvPanel');
  const right = el('div', 'hud-min-right'); right.append(dataBtn, invBtn, actions);

  bar.textContent = ''; bar.append(left, right, dataPanel, invPanel);
  if (progress) progress.textContent = '';

  function close() { dataPanel.hidden = invPanel.hidden = true; dataBtn.setAttribute('aria-expanded', 'false'); invBtn.setAttribute('aria-expanded', 'false'); }
  function toggle(panel, btn, other, otherBtn) { const open = panel.hidden; close(); if (open) { panel.hidden = false; btn.setAttribute('aria-expanded', 'true'); } }
  dataBtn.addEventListener('click', () => toggle(dataPanel, dataBtn));
  invBtn.addEventListener('click', () => toggle(invPanel, invBtn));
  document.addEventListener('pointerdown', (e) => { if (dataPanel.hidden && invPanel.hidden) return; if (e.target.closest('.hud-panel,.hud-btn,dialog')) return; close(); }, true);
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && !(dataPanel.hidden && invPanel.hidden)) close(); });
  statsBtn?.addEventListener('click', close);

  // espelhos: papéis no inventário, gás no canto, aviso de pontos no botão DADOS
  const paper = ammo.querySelector('#paperValue'), mirror = invPanel.querySelector('#hudPaperMirror');
  if (paper && mirror) { const sync = () => { mirror.textContent = paper.textContent; }; sync(); new MutationObserver(sync).observe(paper, { childList: true, characterData: true, subtree: true }); }
  const gasPct = gas?.querySelector('#gasPercent'), gasFill = gas?.querySelector('#gasFill'), mini = gasMini.querySelector('b');
  if (gasPct && gasFill) { const sync = () => { const v = parseFloat(gasPct.textContent) || 0; mini.style.width = Math.max(0, Math.min(100, v)) + '%'; gasMini.classList.toggle('on', v < 99.5); }; sync(); new MutationObserver(sync).observe(gasPct, { childList: true, characterData: true, subtree: true }); }
  if (statsBtn) { const sync = () => dataBtn.classList.toggle('alert', statsBtn.classList.contains('has-points')); sync(); new MutationObserver(sync).observe(statsBtn, { attributes: true, attributeFilter: ['class'] }); }
  window.HudMinimal = Object.freeze({ close });
  setTimeout(() => window.dispatchEvent(new Event('resize')), 0);
})();
