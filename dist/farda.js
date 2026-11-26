/* Missão "Farda nova" no Pátio do Colégio Adventista (Campanha 1).
   Tia Neide, da secretaria, avisa que chegou a farda nova do Da Roça. A caixa abriu no portão e as três peças
   (camisa, calça e crachá) se espalharam pelo pátio. Entregando as três, o traje FARDA vai para o espelho
   (DarocaLook.ganhar('farda')): camisa branca com listra vertical azul-escura no peito e calça azul-escura
   com listra azul-clara numa das pernas.
   O estado fica no save da campanha 1 (q.fardaAceita, q.fardaPecas, q.fardaFeita). Sem DOM. */
(() => {
  'use strict';
  if (window.MissaoFarda) return;
  const SCENE = 9, FLOOR = 440;
  const NPC = Object.freeze({ id: 'neide', name: 'Tia Neide · secretaria', x: 1060 });
  const PECAS = Object.freeze([
    Object.freeze({ id: 'camisa', x: 1480, y: FLOOR - 32, nome: 'Camisa branca com listra azul' }),
    Object.freeze({ id: 'calca', x: 1990, y: FLOOR - 32, nome: 'Calça azul com listra clara' }),
    Object.freeze({ id: 'cracha', x: 3720, y: FLOOR - 32, nome: 'Crachá do colégio' })
  ]);
  // a secretária usa o mesmo desenhista dos personagens da Campanha 2
  window.CampanhaPersonagens?.registrar?.('neide', { name: 'Tia Neide da secretaria', skin: '#b98258', shade: '#8a5c3c', build: 'normal', h: .93, top: '#1f3a7a', topKind: 'cardigan', inner: '#f2f2ea', skirt: '#2a3448', hair: { style: 'bun', color: '#2a1d16', gray: '#7a7068' }, glasses: '#7a3a2a', item: 'book', pose: 'read' }, 'NPC (Colégio Adventista)');

  const achadas = (q) => new Set((Array.isArray(q?.fardaPecas) ? q.fardaPecas : []).filter((id) => PECAS.some((p) => p.id === id)));
  const fala = (name, text, actionLabel) => (actionLabel ? { name, text, actionLabel } : { name, text });
  function estado(q) {
    if (!q || typeof q !== 'object') return 'nova';
    if (q.fardaFeita) return 'feita';
    if (!q.fardaAceita) return 'nova';
    return achadas(q).size >= PECAS.length ? 'entregar' : 'ativa';
  }
  function falar(q) {
    const st = estado(q), n = achadas(q).size, N = NPC.name;
    if (st === 'nova') return { acao: 'aceitar', lines: [
      fala(N, 'Da Roça, meu filho! Chegou a sua farda nova do colégio: camisa branca com a listra azul no peito e calça com a listra do lado.'),
      fala(N, 'Só que o motoboy tropeçou no portão e a caixa abriu. A camisa, a calça e o crachá voaram pelo pátio todinho!'),
      fala('Da Roça', 'Deixa comigo, tia. Eu acho tudo antes do sinal bater.', 'Aceitar a missão')] };
    if (st === 'ativa') return { acao: null, lines: [fala(N, `Achou ${n} de 3. A camisa caiu perto dos bancos, a calça foi parar no meio do pátio e o crachá voou lá pro fundo, depois da quadra do Arthur.`)] };
    if (st === 'entregar') return { acao: 'entregar', lines: [
      fala('Da Roça', 'Camisa, calça e crachá. Tá tudo aqui, tia!'),
      fala(N, 'Que beleza! Vai lá no espelho e veste. Farda nova, aluno novo!'),
      fala(N, 'E nada de rabiscar a camisa no último dia de aula, viu?', 'Receber a farda')] };
    return { acao: null, lines: [fala(N, 'A farda ficou bonita em você. Agora só falta chegar no horário!')] };
  }
  function concluir(q, acao) {
    if (acao === 'aceitar' && estado(q) === 'nova') { q.fardaAceita = true; q.fardaPecas = []; return { message: 'Missão Farda nova: ache a camisa, a calça e o crachá no pátio.' }; }
    if (acao === 'entregar' && estado(q) === 'entregar') { q.fardaFeita = true; window.DarocaLook?.ganhar?.('farda'); return { message: 'FARDA DA ESCOLA no espelho! Abra em INVENTÁRIO › ESPELHO.', xp: 150 }; }
    return null;
  }
  function coletar(q, player, scene) {
    if (Number(scene) !== SCENE || estado(q) !== 'ativa' || !player || !Number.isFinite(player.x) || !Number.isFinite(player.y)) return null;
    const a = achadas(q), p = PECAS.find((pc) => !a.has(pc.id) && Math.abs(player.x - pc.x) <= 30 && Math.abs((player.y - 30) - pc.y) <= 40);
    if (!p) return null; a.add(p.id); q.fardaPecas = [...a];
    return { count: a.size, message: a.size >= PECAS.length ? 'Farda 3/3! Volte à Tia Neide, perto da entrada do pátio.' : `${p.nome} · ${a.size}/3` };
  }
  // para onde a seta aponta (só depois de aceitar, para não tirar a vez da história principal)
  function alvo(q, scene) {
    if (Number(scene) !== SCENE) return null; const st = estado(q);
    if (st === 'ativa') { const a = achadas(q); return PECAS.find((p) => !a.has(p.id))?.x ?? NPC.x; }
    return st === 'entregar' ? NPC.x : null;
  }
  function objetivo(q, scene) {
    if (Number(scene) !== SCENE) return null; const st = estado(q);
    if (st === 'ativa') return ['Farda nova', `${achadas(q).size}/3 peças achadas no pátio. Depois volte à Tia Neide.`];
    if (st === 'entregar') return ['Farda nova', 'Leve as três peças para a Tia Neide, perto da entrada do pátio.'];
    return null;
  }
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), w, h); };
  function desenhar(c, t, q, scene) {
    if (Number(scene) !== SCENE || estado(q) !== 'ativa') return; const a = achadas(q);
    for (const p of PECAS) {
      if (a.has(p.id)) continue; const x = p.x, y = p.y + Math.sin(t * 3 + x) * 4;
      c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .3 + Math.sin(t * 5) * .12; c.fillStyle = '#6fb0e6'; c.beginPath(); c.arc(x, y, 20, 0, Math.PI * 2); c.fill(); c.restore();
      if (p.id === 'camisa') { R(c, x - 13, y - 9, 26, 18, '#263b42'); R(c, x - 12, y - 8, 24, 16, '#f1f1ea'); R(c, x - 16, y - 8, 5, 8, '#f1f1ea'); R(c, x + 11, y - 8, 5, 8, '#f1f1ea'); R(c, x + 2, y - 8, 4, 16, '#1f3a7a'); R(c, x - 3, y - 9, 6, 3, '#d8d8cc'); R(c, x - 9, y - 5, 4, 4, '#1f3a7a'); }
      else if (p.id === 'calca') { R(c, x - 10, y - 11, 20, 23, '#263b42'); R(c, x - 9, y - 10, 18, 5, '#1d2d58'); R(c, x - 9, y - 5, 8, 16, '#1d2d58'); R(c, x + 1, y - 5, 8, 16, '#1d2d58'); R(c, x + 4, y - 5, 2, 16, '#6fb0e6'); }
      else { R(c, x - 8, y - 11, 16, 21, '#263b42'); R(c, x - 7, y - 10, 14, 19, '#f2f2ea'); R(c, x - 7, y - 10, 14, 5, '#1f3a7a'); R(c, x - 4, y - 3, 8, 6, '#c9a27a'); R(c, x - 5, y + 5, 10, 1, '#7a8a9a'); R(c, x - 1, y - 15, 2, 5, '#6fb0e6'); }
    }
  }
  window.MissaoFarda = Object.freeze({ SCENE, NPC, PECAS, estado, falar, concluir, coletar, alvo, objetivo, desenhar });
})();
