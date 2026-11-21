/* Da Roça Adventure — aviso de confirmação no estilo do jogo (placa de madeira).
   Confirmar({ titulo, texto, sim, nao, perigo }) → Promise<boolean>.
   Também protege o "NOVA AVENTURA" da tela inicial: se já existe um save da campanha principal,
   pergunta antes de começar do zero (o progresso salvo seria substituído). */
(() => {
  'use strict';
  if (window.Confirmar) return;
  const SAVE = 'da-roca-adventure-v1';
  const css = `.dr-confirma{position:fixed;inset:0;z-index:2147483000;display:grid;place-items:center;background:rgba(14,9,5,.72);backdrop-filter:blur(2px);-webkit-backdrop-filter:blur(2px);animation:drcf .16s ease-out}
.dr-confirma[hidden]{display:none}
.dr-confirma .caixa{width:min(92vw,440px);max-height:calc(100dvh - 24px);overflow:auto;box-sizing:border-box;padding:20px 22px 18px;background:linear-gradient(#7a5532,#5d3e22);border:4px solid #2b1a0d;box-shadow:inset 0 0 0 3px #a87a49,0 10px 0 #1c1108,0 18px 40px rgba(0,0,0,.6);color:#fff4dc;font-family:'Press Start 2P','pixel',monospace;text-align:center;image-rendering:pixelated;animation:drcp .2s cubic-bezier(.2,1.6,.4,1)}
.dr-confirma .ico{font-size:30px;line-height:1;margin-bottom:8px;filter:drop-shadow(0 3px 0 #2b1a0d)}
.dr-confirma h2{margin:0 0 12px;font-size:13px;line-height:1.5;color:#ffd36b;text-shadow:0 3px 0 #2b1a0d;letter-spacing:.5px}
.dr-confirma p{margin:0 0 16px;font-size:9px;line-height:1.8;color:#fff4dc;text-shadow:0 2px 0 #2b1a0d}
.dr-confirma p b{color:#ffb39a}
.dr-confirma .bts{display:flex;gap:10px;justify-content:center;flex-wrap:wrap}
.dr-confirma button{flex:1 1 150px;min-height:46px;padding:10px 12px;font:inherit;font-size:9px;cursor:pointer;border:3px solid #2b1a0d;box-shadow:inset 0 -4px 0 rgba(0,0,0,.25),0 4px 0 #1c1108;color:#2b1a0d;background:#e9c27a;letter-spacing:.4px}
.dr-confirma button:active{transform:translateY(3px);box-shadow:inset 0 -2px 0 rgba(0,0,0,.25),0 1px 0 #1c1108}
.dr-confirma button.sim.perigo{background:#d9583b;color:#fff4dc;text-shadow:0 2px 0 #5b1a0c}
.dr-confirma button.nao{background:#8fc46b}
.dr-confirma button:focus-visible{outline:3px solid #fff4dc;outline-offset:2px}
@keyframes drcf{from{opacity:0}}@keyframes drcp{from{transform:scale(.86);opacity:0}}`;
  let el = null, pendente = null;
  function montar() {
    if (el) return el;
    const st = document.createElement('style'); st.textContent = css; document.head.appendChild(st);
    el = document.createElement('div'); el.className = 'dr-confirma'; el.hidden = true; el.setAttribute('role', 'alertdialog'); el.setAttribute('aria-modal', 'true');
    el.innerHTML = '<div class="caixa"><div class="ico" aria-hidden="true">⚠</div><h2></h2><p></p><div class="bts"><button type="button" class="nao"></button><button type="button" class="sim"></button></div></div>';
    document.body.appendChild(el);
    const fechar = (r) => { if (el.hidden) return; el.hidden = true; const f = pendente; pendente = null; f?.(r); };
    el.addEventListener('click', (e) => { if (e.target === el) fechar(false); const b = e.target.closest('button'); if (b) { e.stopPropagation(); fechar(b.classList.contains('sim')); } });
    // as teclas não vazam para o jogo enquanto o aviso está aberto
    addEventListener('keydown', (e) => { if (el.hidden) return; e.stopImmediatePropagation(); if (e.key === 'Escape') { e.preventDefault(); fechar(false); } else if (e.key === 'Tab' || e.key === 'ArrowLeft' || e.key === 'ArrowRight') { e.preventDefault(); const [n, s] = el.querySelectorAll('button'); (document.activeElement === n ? s : n).focus(); } }, true);
    return el;
  }
  function Confirmar(o = {}) {
    const d = montar(); pendente?.(false);
    d.querySelector('h2').textContent = o.titulo || 'Tem certeza?';
    d.querySelector('p').innerHTML = o.html || '';
    if (!o.html) d.querySelector('p').textContent = o.texto || '';
    const sim = d.querySelector('.sim'), nao = d.querySelector('.nao');
    sim.textContent = o.sim || 'SIM'; nao.textContent = o.nao || 'CANCELAR'; sim.classList.toggle('perigo', o.perigo !== false);
    d.hidden = false; setTimeout(() => nao.focus(), 20); // o foco começa no botão seguro
    return new Promise((r) => { pendente = r; });
  }
  window.Confirmar = Confirmar;

  // NOVA AVENTURA com save existente: pergunta antes
  const temSave = () => { try { const d = JSON.parse(localStorage.getItem(SAVE) || 'null'); return !!(d && d.q); } catch (e) { return false; } };
  let liberado = false;
  addEventListener('click', (e) => {
    const b = e.target.closest?.('#startBtn'); if (!b || liberado || !temSave()) return;
    e.preventDefault(); e.stopImmediatePropagation();
    Confirmar({ titulo: 'JOGAR DO COMEÇO?', html: 'Você já tem uma aventura salva.<br>Começar do zero <b>apaga todo o progresso da campanha principal</b>: história, itens, nível e atributos.<br><br>Tem certeza que quer reiniciar o save?', sim: 'APAGAR E COMEÇAR', nao: 'CANCELAR' })
      .then((ok) => { if (!ok) return; liberado = true; try { b.click(); } finally { liberado = false; } });
  }, true);
})();
