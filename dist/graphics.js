/* Qualidade gráfica: BAIXA, MÉDIA, ALTA ou AUTOMÁTICA.
   - BAIXA: arte antiga, sem efeitos de cenário (celulares fracos).
   - MÉDIA: cenários novos, hora do dia, clima e partículas, sem WebGL (celulares e TVs).
   - ALTA: tudo da média + pós-processamento em WebGL (relevo de luz, brilho, raios de sol,
     névoa, reflexo na água, calor e correção de cor).
   No modo automático o jogo escolhe pelo aparelho e desce um nível se o jogo travar.
   A escolha fica salva só neste aparelho. Os nomes antigos (lite/full/shader) continuam valendo. */
(() => {
  'use strict';
  const KEY = 'daroca-graphics-v1';
  const read = () => { try { return localStorage.getItem(KEY); } catch (e) { return null; } };
  const write = (v) => { try { localStorage.setItem(KEY, v); } catch (e) {} };
  const OLD = { lite: 'low', full: 'medium', shader: 'high' };
  const LEVELS = ['low', 'medium', 'high'];
  const webgl = () => { try { const c = document.createElement('canvas'); return !!(c.getContext('webgl')); } catch (e) { return false; } };

  // Perfil do aparelho: celular simples, celular bom, TV, computador.
  function detect() {
    const ua = navigator.userAgent || '', mem = Number(navigator.deviceMemory) || 4, cores = Number(navigator.hardwareConcurrency) || 4;
    const tv = /Android TV|GoogleTV|BRAVIA|AFT[A-Z]|SmartTV|SMART-TV|Tizen|WebOS|HbbTV|CrKey/i.test(ua);
    const mobile = /Android|iPhone|iPad|iPod|Mobile/i.test(ua) || (navigator.maxTouchPoints > 1 && Math.min(screen.width, screen.height) < 820);
    if (tv) return { kind: 'tv', level: 'medium' };
    // iPhone e iPad: o Safari esconde o número real de núcleos (informa 2 ou 4), então não dá para medir por ali.
    // Começa na MÉDIA; se travar, o modo automático desce sozinho para a BAIXA.
    const ios = /iPhone|iPad|iPod/i.test(ua) || (/Macintosh/i.test(ua) && navigator.maxTouchPoints > 1);
    if (ios) return { kind: 'mobile', level: 'medium' };
    if (mobile) return { kind: 'mobile', level: mem <= 3 || cores <= 4 ? 'low' : 'medium' };
    return { kind: 'desktop', level: webgl() ? 'high' : 'medium' };
  }
  const device = detect();
  let stored = read() || 'auto';
  let mode = 'auto', autoLevel = device.level;
  if (OLD[stored]) mode = OLD[stored];
  else if (LEVELS.includes(stored)) mode = stored;
  else if (/^auto-(low|medium|high)$/.test(stored)) autoLevel = stored.slice(5);
  else if (stored === 'auto-lite') autoLevel = 'low';
  const listeners = new Set();

  const level = () => { const l = mode === 'auto' ? autoLevel : mode; return l === 'high' && !window.Shader?.supported?.() ? 'medium' : l; };
  const isLite = () => level() === 'low';
  const isShader = () => level() === 'high';
  function apply() {
    document.documentElement.dataset.graphics = isShader() ? 'shader' : isLite() ? 'lite' : 'full';
    document.documentElement.dataset.quality = level();
    for (const fn of listeners) { try { fn(isLite()); } catch (e) {} }
  }
  function set(next) {
    next = OLD[next] || next;
    mode = LEVELS.includes(next) ? next : 'auto';
    if (mode === 'auto') autoLevel = device.level;
    write(mode === 'auto' ? 'auto' : mode);
    apply();
  }
  const NAMES = { low: 'BAIXA', medium: 'MÉDIA', high: 'ALTA' };
  function label() { return mode === 'auto' ? 'AUTO (' + NAMES[level()] + ')' : NAMES[level()]; }
  function describe() {
    const l = level();
    const what = l === 'high' ? 'Luz com relevo, brilho, raios de sol, névoa e reflexo na água.' : l === 'medium' ? 'Cenários novos, hora do dia, clima e partículas.' : 'Sem efeitos, para aparelhos simples.';
    return (mode === 'auto' ? 'Escolhida pelo aparelho. ' : '') + what + ' Toque para trocar.';
  }
  // Partículas e efeitos por nível (usado por clima e outros enfeites).
  const profile = () => ({ low: { particles: 0, weather: false }, medium: { particles: .6, weather: true }, high: { particles: 1, weather: true } })[level()];

  // Vigia de quadros: no automático, desce um nível se o jogo ficar lento por alguns segundos.
  let last = 0, slow = 0, samples = 0, sum = 0;
  function watch(now) {
    if (last && !document.hidden) {
      const dt = now - last;
      if (dt < 250) { sum += dt; samples++; }
      if (samples >= 120) {
        const avg = sum / samples; sum = 0; samples = 0;
        slow = avg > 26 ? slow + 1 : Math.max(0, slow - 1);
        if (slow >= 3 && mode === 'auto' && autoLevel !== 'low') {
          autoLevel = autoLevel === 'high' ? 'medium' : 'low'; slow = 0; write('auto-' + autoLevel); apply();
          const toast = document.getElementById('toast');
          if (toast) { toast.textContent = 'Qualidade ' + NAMES[autoLevel] + ' ligada para o jogo rodar liso. Dá para trocar na pausa.'; toast.hidden = false; toast.classList.add('show'); setTimeout(() => { toast.classList.remove('show'); toast.hidden = true; }, 4200); }
        }
      }
    }
    last = now;
    requestAnimationFrame(watch);
  }
  requestAnimationFrame(watch);
  apply();
  window.addEventListener('DOMContentLoaded', apply);
  window.Graphics = Object.freeze({
    isLite, isShader, set, label, describe, level, profile, device: () => device.kind,
    getMode: () => mode,
    // AUTO → BAIXA → MÉDIA → ALTA → AUTO
    toggle: () => set(mode === 'auto' ? 'low' : mode === 'low' ? 'medium' : mode === 'medium' ? (window.Shader?.supported?.() ? 'high' : 'auto') : 'auto'),
    onChange: (fn) => { listeners.add(fn); return () => listeners.delete(fn); }
  });
})();
