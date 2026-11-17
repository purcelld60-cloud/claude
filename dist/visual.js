/* Espelho da Bigodon: muda o visual de Da Roça (chapéu, cabelo, camisa, calça) e veste o traje
   especial JAGLION, uma fantasia de leão. Abre depois de conversar com Davi Costa na Bigodon e,
   a partir daí, também pelo INVENTÁRIO. Só aparência: não muda vida, dano nem dificuldade.
   O visual fica salvo neste aparelho ('daroca-visual-v1'); "PADRÃO" volta ao Da Roça de sempre. */
(() => {
  'use strict';
  if (window.DarocaLook) return;
  const KEY = 'daroca-visual-v1';
  const DEFAULT = { costume: 'normal', hat: 'palha', hatColor: '#c0392b', hairStyle: 'curto', hairColor: '#5f4934', shirt: '#dc8c47', shirtLight: '#e7ac65', pants: '#455b62' };
  const OPTIONS = {
    costume: [['normal', 'NORMAL'], ['jaglion', 'JAGLION']],
    hat: [['palha', 'PALHA'], ['sem', 'SEM CHAPÉU'], ['bone', 'BONÉ'], ['couro', 'COURO'], ['preto', 'PRETO']],
    hairStyle: [['curto', 'CURTO'], ['black', 'BLACK'], ['moicano', 'MOICANO'], ['raspado', 'RASPADO'], ['comprido', 'COMPRIDO']],
    hairColor: [['#5f4934', 'castanho'], ['#1e1a18', 'preto'], ['#d8b45a', 'loiro'], ['#b5502a', 'ruivo'], ['#e6e2da', 'platinado'], ['#3a6ad0', 'azul'], ['#d0508a', 'rosa']],
    shirt: [['#dc8c47', 'laranja', '#e7ac65'], ['#3a7fd0', 'azul', '#6aa6e8'], ['#3aa655', 'verde', '#6ac884'], ['#d03a3a', 'vermelha', '#e86a6a'], ['#8a5ac8', 'roxa', '#ad86e0'], ['#e8e4d8', 'branca', '#ffffff'], ['#2a2d33', 'preta', '#4a4e57'], ['#e8c23a', 'amarela', '#f4dc78']],
    pants: [['#455b62', 'jeans'], ['#22252a', 'preta'], ['#b8a074', 'bege'], ['#5a6a3a', 'oliva'], ['#8a2a2a', 'vinho']],
    hatColor: [['#c0392b', 'vermelho'], ['#2a5ad0', 'azul'], ['#2a8a4a', 'verde'], ['#1e1a18', 'preto'], ['#e8c23a', 'amarelo']]
  };
  let look = { ...DEFAULT }, unlocked = false;
  try { const d = JSON.parse(localStorage.getItem(KEY)); if (d && typeof d === 'object') { unlocked = !!d.unlocked; for (const k of Object.keys(DEFAULT)) if (typeof d.look?.[k] === 'string') look[k] = d.look[k]; } } catch (e) {}
  const save = () => { try { localStorage.setItem(KEY, JSON.stringify({ unlocked, look })); } catch (e) {} };
  const isDefault = () => Object.keys(DEFAULT).every((k) => look[k] === DEFAULT[k]);

  /* ---------------- painel do espelho ---------------- */
  let panel = null, preview = null, raf = 0, onClose = null, t0 = 0;
  const ROWS = [
    ['costume', 'TRAJE'], ['hat', 'CHAPÉU'], ['hatColor', 'COR DO BONÉ'], ['hairStyle', 'CABELO'], ['hairColor', 'COR DO CABELO'], ['shirt', 'CAMISA'], ['pants', 'CALÇA']
  ];
  function build() {
    if (panel) return;
    panel = document.createElement('div'); panel.id = 'visualPanel'; panel.className = 'visual-panel'; panel.hidden = true; panel.setAttribute('role', 'dialog'); panel.setAttribute('aria-label', 'Espelho da Bigodon');
    panel.innerHTML = '<div class="vp-box"><div class="vp-head"><b>ESPELHO DA BIGODON</b><span class="vp-davi"></span></div><div class="vp-body"><div class="vp-mirror"><canvas width="200" height="230" aria-hidden="true"></canvas><small class="vp-note"></small></div><div class="vp-rows"></div></div><div class="vp-actions"><button type="button" class="vp-reset">PADRÃO</button><button type="button" class="vp-done primary-btn">PRONTO</button></div></div>';
    (document.getElementById('gameShell') || document.body).append(panel);
    preview = panel.querySelector('canvas');
    panel.querySelector('.vp-done').addEventListener('click', close);
    panel.querySelector('.vp-reset').addEventListener('click', () => { look = { ...DEFAULT }; save(); render(); });
    panel.addEventListener('keydown', (e) => { if (e.key === 'Escape') { e.preventDefault(); close(); } e.stopPropagation(); });
    render();
  }
  function render() {
    const rows = panel.querySelector('.vp-rows'); rows.innerHTML = '';
    const lion = look.costume === 'jaglion';
    for (const [key, label] of ROWS) {
      if (key === 'hatColor' && look.hat !== 'bone') continue;
      const row = document.createElement('div'); row.className = 'vp-row' + (lion && key !== 'costume' ? ' is-off' : ''); row.innerHTML = '<span>' + label + '</span>';
      const list = document.createElement('div'); list.className = 'vp-opts';
      for (const [val, name, light] of OPTIONS[key]) {
        const b = document.createElement('button'); b.type = 'button'; const color = val.startsWith('#');
        b.className = 'vp-opt' + (color ? ' vp-swatch' : '') + (look[key] === val ? ' on' : ''); b.setAttribute('aria-pressed', look[key] === val ? 'true' : 'false');
        if (color) { b.style.setProperty('--sw', val); b.title = name; b.setAttribute('aria-label', label.toLowerCase() + ' ' + name); } else b.textContent = name;
        if (val === 'jaglion') b.classList.add('vp-lion');
        b.disabled = lion && key !== 'costume';
        b.addEventListener('click', () => { look[key] = val; if (key === 'shirt') look.shirtLight = light || look.shirtLight; save(); render(); panel.querySelector(`[data-k="${key}"] .on`)?.focus?.(); });
        list.append(b);
      }
      row.dataset.k = key; row.append(list); rows.append(row);
    }
    panel.querySelector('.vp-note').textContent = lion ? 'JAGLION: fantasia de leão costurada pelo Vitor. Rugido não incluso.' : isDefault() ? 'O Da Roça de sempre.' : 'Visual novo, mesma resenha.';
  }
  function drawPreview(now) {
    if (panel.hidden) return; const c = preview.getContext('2d'), t = (now - t0) / 1000;
    c.setTransform(1, 0, 0, 1, 0, 0); c.clearRect(0, 0, 200, 230); c.imageSmoothingEnabled = false;
    const g = c.createLinearGradient(0, 0, 0, 230); g.addColorStop(0, '#cfe3e8'); g.addColorStop(1, '#9fbcc4'); c.fillStyle = g; c.fillRect(0, 0, 200, 230);
    c.fillStyle = 'rgba(255,255,255,.35)'; c.fillRect(24, 0, 10, 230); c.fillRect(40, 0, 4, 230);
    c.fillStyle = 'rgba(40,60,70,.25)'; c.fillRect(40, 214, 120, 6);
    try { window.Art?.drawCharacter?.(c, 'daroca', 100, 214, { facing: Math.sin(t * .6) > -.2 ? 1 : -1, frame: t, scale: 2.1, grounded: true }); } catch (e) {}
    raf = requestAnimationFrame(drawPreview);
  }
  function open(opts = {}) {
    build(); unlocked = true; save(); onClose = opts.onClose || null;
    panel.querySelector('.vp-davi').textContent = opts.line || 'Davi: E aí, Da Roça, vai querer o quê hoje?';
    render(); panel.hidden = false; t0 = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(drawPreview);
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
    setTimeout(() => panel.querySelector('.vp-opt.on')?.focus?.(), 40);
    updateInventory();
  }
  function close() {
    if (!panel || panel.hidden) return; panel.hidden = true; cancelAnimationFrame(raf); save();
    window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } }));
    document.getElementById('gameCanvas')?.focus?.();
    const fn = onClose; onClose = null; if (fn) try { fn({ ...look }); } catch (e) {}
  }
  // INVENTÁRIO: atalho para o espelho depois da primeira visita ao Davi
  function updateInventory() {
    const inv = document.getElementById('hudInvPanel'); if (!inv || !unlocked) return;
    if (inv.querySelector('.hud-visual')) return;
    const row = document.createElement('div'); row.className = 'hud-row hud-visual'; row.innerHTML = '<span>✂ VISUAL</span>';
    const b = document.createElement('button'); b.type = 'button'; b.className = 'hud-fliperama-btn'; b.textContent = 'ESPELHO'; b.addEventListener('click', () => open({ line: 'Espelho de bolso da Bigodon. O Davi aprova.' }));
    row.append(b); inv.append(row);
  }
  setTimeout(updateInventory, 1600);
  window.DarocaLook = Object.freeze({ get: () => (isDefault() ? null : look), current: () => ({ ...look }), open, close, isOpen: () => !!panel && !panel.hidden, unlocked: () => unlocked, set: (k, v) => { if (k in DEFAULT && typeof v === 'string') { look[k] = v; save(); } }, reset: () => { look = { ...DEFAULT }; save(); } });
})();
