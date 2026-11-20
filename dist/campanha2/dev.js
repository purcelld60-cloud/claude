/* Ferramentas do MODO DESENVOLVEDOR (só com window.DAROCA_DEV ligado: IPA de desenvolvedor ou ?dev).
   - Libera tudo: Campanha 2, Terreiro dos Chefes (sandbox) e o painel de capítulos da Campanha 2.
   - 🎬 CUTSCENES na tela inicial: assiste a TODAS as cutscenes das duas campanhas (as cenas do jogo, os roteiros
     da campanha 1 e as 24 da Campanha 2), com avançar, pular e fechar.
   - Na Campanha 2: ESCOLHER CAPÍTULO (do prólogo até o pós-final, com os vilões anteriores vencidos, os poderes
     deles liberados e 600 moedas) e LIBERAR TUDO (8 poderes no nível 3, 999 moedas, mapa e companheiros).
   Nada disso aparece nos apps normais. */
(() => {
  'use strict';
  if (!window.DAROCA_DEV || window.DarocaDev) return;
  try { localStorage.setItem('daroca-sandbox-v1', '1'); } catch (e) {}
  const W = 960, H = 540;
  const CAPS = [
    ['Prólogo · abertura e a roça', 'abertura', 0, 700, []], ['Aeroporto de Itabuna (Miguel)', 'checkin', 12, 520, []], ['Chegada em Conquista (Seu Zé)', 'taxi1', 12, 3700, []],
    ['Vilão 1 · Dona Creuza', 'creuza', 13, 2000, []], ['Vilão 2 · Tonhão', 'tonhao', 16, 2820, ['creuza']], ['Vilão 3 · Seu Valdomiro', 'valdomiro', 17, 520, ['creuza', 'tonhao']],
    ['Vilão 4 · Kauã Influencer', 'kaua', 15, 420, ['creuza', 'tonhao', 'valdomiro']], ['Vilão 5 · Barão do Café', 'barao', 18, 420, ['creuza', 'tonhao', 'valdomiro', 'kaua']],
    ['Vilão 6 · Breno Pitbull', 'breno', 19, 420, ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao']], ['Vilão 7 · Ryan e Bryan', 'gemeos', 20, 300, ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno']],
    ['Vilão 8 · Fred', 'fred', 27, 160, ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos']], ['BATALHA FINAL · Jorge', 'jorge', 14, 1820, ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos', 'fred']],
    ['Pós-final · Conquista livre', 'zerou', 14, 2200, ['creuza', 'tonhao', 'valdomiro', 'kaua', 'barao', 'breno', 'gemeos', 'fred']]];
  const PODER_DE = { creuza: 'fofoca', tonhao: 'buzina', valdomiro: 'biscoito', kaua: 'flash', barao: 'cafezao', breno: 'supersoco', gemeos: 'clone', fred: 'aura' };
  function capitulo(i) {
    const [, passo, cena, x, venc] = CAPS[i], flags = { embarcou: passo !== 'abertura' && passo !== 'checkin' ? 1 : 0 }; for (const v of venc) flags['venceu_' + v] = 1; if (passo === 'zerou') { flags.venceu_jorge = 1; flags.zerou = 1; }
    try { localStorage.setItem('daroca-c2-save', JSON.stringify({ v: 1, passo, cena, x, hp: 100, flags, criado: Date.now(), salvo: Date.now() })); localStorage.setItem('daroca-c2-vencidos', JSON.stringify(venc)); } catch (e) {}
    window.CampanhaTaxi?.zerarVencidos?.(); for (const v of venc) { window.CampanhaTaxi?.vencer?.(v); window.CampanhaPoderes?.desbloquear?.(PODER_DE[v]); }
    if ((window.CampanhaLoja?.moedas?.() ?? 0) < 600) window.CampanhaLoja?.ganhar?.(600 - (window.CampanhaLoja?.moedas?.() ?? 0));
    document.getElementById('c2Painel')?.setAttribute('hidden', ''); window.Campanha2?.abrir?.({});
  }
  function liberarTudo() {
    for (const p of window.CampanhaPoderes?.lista?.() || []) { window.CampanhaPoderes.desbloquear(p.id); while (window.CampanhaPoderes.upgrade(p.id)); }
    window.CampanhaLoja?.ganhar?.(999); for (const v of Object.keys(PODER_DE)) window.CampanhaTaxi?.vencer?.(v);
    try { const s = JSON.parse(localStorage.getItem('daroca-c2-save') || 'null'); if (s) { s.flags = s.flags || {}; s.flags.extra = { ...(s.flags.extra || {}), mel: 'feita', lurdes: 'feita', cao: 1, bike: 1, skate: 1, moral: 1, juninho: 'feita', pistas_ok: 1 }; localStorage.setItem('daroca-c2-save', JSON.stringify(s)); } } catch (e) {}
    alert('Modo desenvolvedor: 8 poderes no nível 3, +999 moedas, todos os pontos de táxi e os extras liberados.');
  }

  /* ---------- painel de capítulos da Campanha 2 ---------- */
  function painelDev() {
    const el = document.createElement('div'); el.className = 'c2j dev-cap'; el.style.background = '#06080c'; el.innerHTML = `<div class="pausa" style="position:relative;background:none;overflow:auto;max-height:100vh;padding:20px 0"><h2>🛠 CAPÍTULOS · MODO DESENVOLVEDOR</h2><p>Escolha de onde começar. O save da Campanha 2 é trocado (a campanha principal não muda).</p>${CAPS.map(([n], i) => `<button type="button" data-i="${i}">${n}</button>`).join('')}<button type="button" data-a="tudo">⚡ LIBERAR TUDO (PODERES NV 3, MOEDAS, EXTRAS)</button><button type="button" data-a="fechar">VOLTAR</button></div>`;
    el.addEventListener('click', (e) => { const b = e.target.closest('button'); if (!b) return; if (b.dataset.a === 'fechar') el.remove(); else if (b.dataset.a === 'tudo') liberarTudo(); else { el.remove(); capitulo(Number(b.dataset.i)); } });
    document.body.appendChild(el); setTimeout(() => el.querySelector('button')?.focus(), 30);
  }
  // acrescenta o botão no painel da Campanha 2 sempre que ele abrir
  new MutationObserver(() => { const p = document.querySelector('#c2Painel .pausa'); if (p && !p.querySelector('[data-dev]')) { const b = document.createElement('button'); b.type = 'button'; b.dataset.dev = ''; b.textContent = '🛠 ESCOLHER CAPÍTULO (DEV)'; b.addEventListener('click', (e) => { e.stopPropagation(); painelDev(); }); p.insertBefore(b, p.querySelector('[data-a="fechar"]')); } }).observe(document.body, { childList: true, subtree: true });

  /* ---------- todas as cutscenes ---------- */
  function tocarCena(kind) { // cenas do motor do jogo (campanha 1): o próprio Cinematics desenha
    const C = window.Cinematics; if (!C) return; const cv = document.createElement('canvas'); cv.width = W; cv.height = H;
    cv.style.cssText = 'position:fixed;inset:0;margin:auto;width:min(100vw,177.8vh);height:min(56.25vw,100vh);z-index:2147483600;background:#000;image-rendering:pixelated';
    document.body.appendChild(cv); const c = cv.getContext('2d'); let s = C.create(kind, {}), last = performance.now(), stop = false;
    const fim = () => { stop = true; cv.remove(); removeEventListener('keydown', tecla, true); };
    const passo = () => { if (!C.advance(s) || s.done) fim(); };
    const tecla = (e) => { if (e.key === 'Escape') fim(); else if ([' ', 'Enter', 'e', 'E', 'ArrowRight'].includes(e.key)) passo(); else return; e.preventDefault(); e.stopImmediatePropagation(); };
    addEventListener('keydown', tecla, true); cv.addEventListener('click', passo);
    const loop = (now) => { if (stop) return; const dt = Math.min(.1, (now - last) / 1000); last = now; try { C.update(s, dt); if (s.done) { fim(); return; } C.draw(c, s); const b = C.beat(s);
      if (b?.text) { c.fillStyle = 'rgba(20,14,8,.9)'; c.fillRect(30, 404, 900, 110); c.fillStyle = '#e8c66a'; c.fillRect(30, 404, 900, 3); c.font = '12px Pixel, monospace'; c.fillStyle = '#ffd98a'; c.textAlign = 'left'; c.textBaseline = 'top'; c.fillText(b.speaker || '', 46, 416);
        c.font = '16px Arial, sans-serif'; c.fillStyle = '#f6ead0'; let l = '', y = 440; for (const w of String(b.text).split(' ')) { if (c.measureText(l + w).width > 860) { c.fillText(l, 46, y); l = ''; y += 22; } l += w + ' '; } c.fillText(l, 46, y); }
      c.font = '10px Pixel, monospace'; c.textAlign = 'right'; c.fillStyle = '#ffffffaa'; c.fillText(`${kind} · clique/Enter avança · Esc fecha`, 950, 6); } catch (e) { fim(); return; } requestAnimationFrame(loop); };
    requestAnimationFrame(loop);
  }
  function galeria() {
    const el = document.createElement('div'); el.className = 'c2-galeria'; const R = window.Roteiro, cinema = Object.keys(window.Cinematics?.metadata || {}).filter((k) => !R?.has?.(k) || !/^c2_|^chegada_|^abertura$|^creditos$/.test(k));
    const roteiros1 = (R?.list?.() || []).filter((id) => !/^c2/.test(id)), roteiros2 = (window.CampanhaCutscenes?.ordem?.() || []).filter((id) => R?.has?.(id));
    const grupo = (titulo, ids, tipo) => `<h2 style="margin-top:14px">${titulo}</h2><div class="g">${ids.map((id) => `<button type="button" data-t="${tipo}" data-id="${id}">${(R?.get?.(id)?.title || id).replace(/[<>&]/g, '')}<small>${id}</small></button>`).join('')}</div>`;
    el.innerHTML = `<button type="button" class="x">✕ FECHAR</button><h2>🎬 TODAS AS CUTSCENES · DEV</h2><p>Clique para assistir. Clique ou Enter avança, Esc fecha.</p>${grupo('CAMPANHA 2 · VITÓRIA DA CONQUISTA', roteiros2, 'r')}${grupo('CAMPANHA 1 · ROTEIROS', roteiros1, 'r')}${grupo('CAMPANHA 1 · CENAS DO JOGO', cinema, 'c')}`;
    if (!document.querySelector('.c2-galeria:not([data-dev])')) window.CampanhaCutscenes?.galeria?.(); document.querySelectorAll('.c2-galeria:not([data-dev])').forEach((g) => { g.hidden = true; }); // só para carregar o estilo
    el.dataset.dev = '1'; document.body.appendChild(el);
    el.addEventListener('click', (e) => { const b = e.target.closest('button'); if (!b) return; if (b.classList.contains('x')) { el.remove(); window.__somCutscene = false; return; } window.__somCutscene = true; if (b.dataset.t === 'r') { const antes = new Set(document.querySelectorAll('body > canvas')); R.preview(b.dataset.id); for (const cv of document.querySelectorAll('body > canvas')) if (!antes.has(cv)) cv.style.zIndex = '2147483500'; } else tocarCena(b.dataset.id); });
  }
  function botaoTitulo() {
    const lista = document.querySelector('#startScreen .ranch-mode-entries'); if (!lista || lista.querySelector('[data-dev-cut]')) return;
    const b = document.createElement('button'); b.type = 'button'; b.dataset.devCut = ''; b.innerHTML = '<b>🎬 CUTSCENES · DEV</b><small>Todas as cenas das duas campanhas</small>'; b.addEventListener('click', (e) => { e.preventDefault(); galeria(); }); lista.appendChild(b);
    const tag = document.createElement('div'); tag.textContent = 'MODO DESENVOLVEDOR'; tag.style.cssText = 'position:fixed;left:8px;bottom:8px;z-index:99999;font:9px Pixel,monospace;color:#1c1408;background:#ffd24a;border:2px solid #1c1408;padding:4px 7px;pointer-events:none'; document.body.appendChild(tag);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', botaoTitulo); else botaoTitulo();
  window.DarocaDev = Object.freeze({ galeria, capitulo, liberarTudo, painel: painelDev, tocarCena });
})();
