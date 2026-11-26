/* Missão "Achados e perdidos" no Pátio do Colégio Adventista (Campanha 1).
   A Tia Ana, da secretaria (cabelo branco, óculos, camisa social azul-clara e saia bege), tem a caixa de achados e
   perdidos cheia. Da Roça entrega a cada aluno o que ele esqueceu na escola: o estojo do Caio, a garrafinha da Lara
   e o casaco do Theo. De volta à Tia Ana, ganha a FARDA da escola no espelho (DarocaLook.ganhar('farda')).
   O estado fica no save da campanha 1 (q.fardaAceita, q.achados, q.fardaFeita). Sem DOM. */
(() => {
  'use strict';
  if (window.MissaoFarda) return;
  const SCENE = 9, FLOOR = 440;
  const NPCS = Object.freeze({
    tia_ana: { name: 'Tia Ana · secretaria', scene: SCENE, x: 1060 },
    aluno_caio: { name: 'Caio · 6º ano', scene: SCENE, x: 1480 },
    aluna_lara: { name: 'Lara · 7º ano', scene: SCENE, x: 2010 },
    aluno_theo: { name: 'Theo · 5º ano', scene: SCENE, x: 3720 }
  });
  const ITENS = Object.freeze({
    aluno_caio: { item: 'estojo com adesivo de foguete', curto: 'ESTOJO', cor: '#3a6ad0' },
    aluna_lara: { item: 'garrafinha roxa de unicórnio', curto: 'GARRAFINHA', cor: '#9a5ad8' },
    aluno_theo: { item: 'casaco azul do colégio', curto: 'CASACO', cor: '#1f3a7a' }
  });
  // gente do colégio, no mesmo desenhista detalhado dos personagens da Campanha 2
  const farda = { top: '#f1f1ea', pants: '#1d2d58', shoes: '#1a1a1e' };
  const GENTE = {
    tia_ana: { name: 'Tia Ana da secretaria', skin: '#f2d4c0', shade: '#d4ab94', build: 'normal', h: .93, top: '#a8cff0', collar: '#e4f2fc', skirt: '#d8c8a0', hair: { style: 'bun', color: '#f2f2ee', gray: '#d8d8d2' }, glasses: '#5a6a7a', item: 'book', pose: 'talk' },
    aluno_caio: { name: 'Caio', skin: '#c48a62', shade: '#93613f', build: 'slim', h: .82, ...farda, hair: { style: 'short', color: '#2a1d16' }, pose: 'pockets', mood: 'sad' },
    aluna_lara: { name: 'Lara', skin: '#e8bf9f', shade: '#bb9277', build: 'slim', h: .84, top: '#f1f1ea', skirt: '#1d2d58', hair: { style: 'ponytail', color: '#5a3a22' }, earrings: '#9a5ad8', pose: 'hips', mood: 'sad' },
    aluno_theo: { name: 'Theo', skin: '#7a4a2e', shade: '#55331f', build: 'slim', h: .78, ...farda, hair: { style: 'curlyBig', color: '#121010' }, pose: 'relaxed', mood: 'sad' }
  };
  const registrar = () => { const CP = window.CampanhaPersonagens; if (!CP?.registrar) return false; for (const [id, sp] of Object.entries(GENTE)) CP.registrar(id, sp, 'NPC (Colégio Adventista)'); return true; };
  if (!registrar()) addEventListener('DOMContentLoaded', registrar, { once: true });

  const ALUNOS = Object.keys(ITENS);
  const entregues = (q) => new Set((Array.isArray(q?.achados) ? q.achados : []).filter((id) => ALUNOS.includes(id)));
  const fala = (name, text, actionLabel) => (actionLabel ? { name, text, actionLabel } : { name, text });
  function estado(q) {
    if (!q || typeof q !== 'object') return 'nova';
    if (q.fardaFeita) return 'feita';
    if (!q.fardaAceita) return 'nova';
    return entregues(q).size >= ALUNOS.length ? 'entregar' : 'ativa';
  }
  function falar(id, q, api) {
    const st = estado(q), N = NPCS[id]?.name || id;
    if (id === 'tia_ana') {
      if (st === 'nova') { api.say([
        fala(N, 'Da Roça, meu filho! Me ajuda? A caixa de ACHADOS E PERDIDOS da secretaria tá transbordando.'),
        fala(N, 'O Caio esqueceu o estojo do foguete, a Lara deixou a garrafinha roxa e o Theo largou o casaco do colégio na quadra.'),
        fala(N, 'Eles estão aqui no pátio. Entrega pra cada um e volta aqui que eu tenho uma surpresa da secretaria pra você.'),
        fala('Da Roça', 'Pode deixar, Tia Ana. Entregador oficial do Colégio Adventista!', 'Pegar a caixa')], () => { q.fardaAceita = true; q.achados = []; api.toast('Achados e perdidos: entregue o estojo do Caio, a garrafinha da Lara e o casaco do Theo.'); api.save(); }); return; }
      if (st === 'ativa') { const falta = ALUNOS.filter((a) => !entregues(q).has(a)).map((a) => NPCS[a].name.split(' ·')[0]); api.say([fala(N, `Ainda falta entregar pro ${falta.join(', pra ')}. Eles estão espalhados pelo pátio, olha lá no fundo também!`)]); return; }
      if (st === 'entregar') { api.say([
        fala('Da Roça', 'Caixa vazia, Tia Ana! Estojo, garrafinha e casaco: tudo com os donos.'),
        fala(N, 'Que menino prestativo! A secretaria guardou isso pra você: a FARDA nova do colégio.'),
        fala(N, 'Camisa branca com a listra azul no peito e calça com a listra do lado. Vai no espelho e veste!', 'Receber a farda')], () => { q.fardaFeita = true; window.DarocaLook?.ganhar?.('farda'); api.xp(150, 'side-farda'); api.toast('FARDA DA ESCOLA no espelho! Abra em INVENTÁRIO › ESPELHO.'); api.save(); }); return; }
      api.say([fala(N, 'Os meninos não param de falar do entregador de chapéu. Obrigada, viu? E a farda ficou linda em você!')]); return;
    }
    const I = ITENS[id]; if (!I) return;
    if (entregues(q).has(id) || q?.fardaFeita) { api.say([fala(N, 'Valeu de novo, Da Roça! Agora eu não esqueço mais nada... acho.')]); return; }
    if (!q?.fardaAceita) { api.say([fala(N, `Ai, perdi meu ${I.item}... Será que a Tia Ana, da secretaria, guardou?`)]); return; }
    api.say([fala('Da Roça', `Ó, achei teu ${I.item} na caixa de achados e perdidos!`), fala(N, 'MEU ' + I.curto + '! Valeu demais, Da Roça! Achei que tinha perdido pra sempre.')], () => {
      const e = entregues(q); e.add(id); q.achados = [...e]; api.xp(30, 'achado-' + id);
      api.toast(e.size >= ALUNOS.length ? 'Achados e perdidos 3/3! Volte à Tia Ana, perto da entrada do pátio.' : `${I.curto} entregue · ${e.size}/3`); api.save(); });
  }
  // para onde a seta aponta (só depois de aceitar, para não tirar a vez da história principal)
  function alvo(q, scene) {
    if (Number(scene) !== SCENE) return null; const st = estado(q);
    if (st === 'ativa') { const e = entregues(q); const prox = ALUNOS.find((a) => !e.has(a)); return prox ? NPCS[prox].x : NPCS.tia_ana.x; }
    return st === 'entregar' ? NPCS.tia_ana.x : null;
  }
  function objetivo(q, scene) {
    if (Number(scene) !== SCENE) return null; const st = estado(q);
    if (st === 'ativa') return ['Achados e perdidos', `${entregues(q).size}/3 itens devolvidos aos alunos. Depois volte à Tia Ana.`];
    if (st === 'entregar') return ['Achados e perdidos', 'Tudo entregue! Volte à Tia Ana, perto da entrada do pátio.'];
    return null;
  }
  // balãozinho com o item esquecido em cima de cada aluno que ainda espera
  const R = (c, x, y, w, h, cor) => { c.fillStyle = cor; c.fillRect(Math.round(x), Math.round(y), w, h); };
  function desenhar(c, t, q, scene) {
    if (Number(scene) !== SCENE || estado(q) !== 'ativa') return; const e = entregues(q);
    for (const id of ALUNOS) { if (e.has(id)) continue; const I = ITENS[id], x = NPCS[id].x + 18, y = FLOOR - 118 + Math.sin(t * 3 + x) * 3;
      R(c, x - 14, y - 12, 28, 22, '#263b42'); R(c, x - 13, y - 11, 26, 20, '#f6f4ea'); R(c, x - 6, y + 9, 4, 4, '#f6f4ea'); R(c, x - 9, y + 13, 3, 3, '#f6f4ea');
      if (id === 'aluno_caio') { R(c, x - 9, y - 5, 18, 9, I.cor); R(c, x - 9, y - 5, 18, 2, '#6a9af0'); R(c, x + 2, y - 3, 4, 5, '#f2f2ee'); R(c, x + 3, y - 4, 2, 1, '#e8433a'); }
      else if (id === 'aluna_lara') { R(c, x - 3, y - 8, 6, 15, I.cor); R(c, x - 2, y - 10, 4, 2, '#f2f2ee'); R(c, x - 1, y - 4, 2, 4, '#ffd0f0'); }
      else { R(c, x - 9, y - 6, 18, 13, I.cor); R(c, x - 12, y - 6, 4, 10, I.cor); R(c, x + 8, y - 6, 4, 10, I.cor); R(c, x - 1, y - 6, 2, 13, '#f2f2ee'); } }
  }
  window.MissaoFarda = Object.freeze({ SCENE, npcs: NPCS, ehNpc: (id) => !!NPCS[id], estado, falar, alvo, objetivo, desenhar, coletar: () => null });
})();
