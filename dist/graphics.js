/* Graphics quality: "realista" (full scenery life and lighting) or "leve" (for weaker phones).
   The choice is stored only on this device. In automatic mode, sustained low frame rates
   switch to the light mode once and tell the player how to change it back. */
(() => {
  'use strict';
  const KEY = 'daroca-graphics-v1';
  const read = () => { try { return localStorage.getItem(KEY); } catch (e) { return null; } };
  const write = (v) => { try { localStorage.setItem(KEY, v); } catch (e) {} };
  let stored = read();
  let mode = stored === 'lite' || stored === 'full' || stored === 'shader' ? stored : 'auto';
  let autoLite = stored === 'auto-lite';
  if (stored === 'auto-lite') mode = 'auto';
  const listeners = new Set();
  const isLite = () => mode === 'lite' || (mode === 'auto' && autoLite);
  function apply() { document.documentElement.dataset.graphics = mode === 'shader' ? 'shader' : isLite() ? 'lite' : 'full'; for (const fn of listeners) { try { fn(isLite()); } catch (e) {} } }
  function set(next) {
    mode = next === 'lite' || next === 'full' || next === 'shader' ? next : 'auto';
    if (mode !== 'auto') autoLite = false;
    write(mode === 'auto' ? (autoLite ? 'auto-lite' : 'auto') : mode);
    apply();
  }
  const isShader = () => mode === 'shader' && !!window.Shader?.supported?.();
  function label() { return isShader() ? 'SHADER' : isLite() ? 'LEVE' : 'REALISTA'; }
  function describe() {
    if (mode === 'auto' && autoLite) return 'Leve automático: seu aparelho estava travando. Toque para voltar ao realista.';
    if (isShader()) return 'Luz de cinema: brilho, raios de sol e cores quentes. Pesado. Toque para o modo leve.';
    return isLite() ? 'Menos efeitos para celulares mais simples. Toque para o realista.' : 'Cenário vivo, luz e partículas. Toque para o SHADER.';
  }
  // Frame-rate watchdog: only while a game canvas is visible and the tab is active.
  let last = 0, slow = 0, samples = 0, sum = 0;
  function watch(now) {
    if (last && !document.hidden) {
      const dt = now - last;
      if (dt < 250) { sum += dt; samples++; }
      if (samples >= 120) {
        const avg = sum / samples; sum = 0; samples = 0;
        slow = avg > 26 ? slow + 1 : Math.max(0, slow - 1);
        if (slow >= 3 && mode === 'auto' && !autoLite) {
          autoLite = true; write('auto-lite'); apply();
          const toast = document.getElementById('toast');
          if (toast) { toast.textContent = 'Modo LEVE ligado para o jogo rodar liso. Dá para trocar na pausa.'; toast.hidden = false; toast.classList.add('show'); setTimeout(() => { toast.classList.remove('show'); toast.hidden = true; }, 4200); }
        }
      }
    }
    last = now;
    requestAnimationFrame(watch);
  }
  requestAnimationFrame(watch);
  apply();
  window.Graphics = Object.freeze({
    isLite, isShader, set, label, describe,
    getMode: () => mode,
    toggle: () => set(isShader() ? 'lite' : isLite() ? 'full' : (window.Shader?.supported?.() ? 'shader' : 'lite')),
    onChange: (fn) => { listeners.add(fn); return () => listeners.delete(fn); }
  });
})();
