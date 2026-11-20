/* Da Roça Adventure — abertura do jogo.
   Roda logo no começo do <body>: a tela preta com a logo e o título já está no HTML e anima só com CSS,
   então continua viva enquanto o resto do jogo carrega. Quando tudo terminou de carregar (e passou o
   tempo mínimo da animação), a barra completa, aparece "PRONTO!" e a abertura some revelando o menu.
   Tocar na tela pula assim que o jogo estiver pronto. Nos testes automáticos ela não aparece (use ?abertura para ver). */
(() => {
  'use strict';
  const el = document.getElementById('abertura'); if (!el) return;
  if (navigator.webdriver && !/[?&]abertura\b/.test(location.search)) { el.remove(); return; }
  const MINIMO = 4300; // ms: tempo para a logo, o título e a barra aparecerem
  const DICAS = ['Assando o bolo de sapo...', 'Afiando o chinelo...', 'Enchendo o botijão do carro...', 'Chamando a resenha...', 'Varrendo o terreiro...', 'Acordando os passarinhos...', 'Separando o açaí de quarta...'];
  const dica = el.querySelector('.ab-dica'); let n = 0;
  const troca = setInterval(() => { n = (n + 1) % DICAS.length; if (dica && !el.classList.contains('ab-pronto')) dica.textContent = DICAS[n]; }, 900);
  let carregado = false, pularPedido = false, saindo = false;
  const t0 = performance.now();
  function sair() {
    if (saindo) return; saindo = true; clearInterval(troca);
    el.classList.add('ab-sai'); setTimeout(() => { el.remove(); window.dispatchEvent(new Event('abertura-fim')); }, 600);
  }
  function pronto() {
    carregado = true; el.classList.add('ab-pronto'); if (dica) dica.textContent = 'PRONTO!';
    setTimeout(sair, pularPedido ? 150 : 900);
  }
  function quandoCarregar() { const falta = Math.max(0, MINIMO - (performance.now() - t0)); setTimeout(pronto, falta); }
  if (document.readyState === 'complete') quandoCarregar(); else addEventListener('load', quandoCarregar, { once: true });
  // tocar ou apertar uma tecla pula (depois que o jogo carregou)
  const pular = (e) => { e.preventDefault?.(); e.stopPropagation?.(); if (carregado) sair(); else pularPedido = true; };
  el.addEventListener('pointerdown', pular);
  addEventListener('keydown', (e) => { if (document.getElementById('abertura') && !saindo) pular(e); }, true);
  // segurança: nunca prende a pessoa na abertura
  setTimeout(() => { if (!saindo) { el.classList.add('ab-pronto'); sair(); } }, 15000);
})();
