/* Campanha 2 · Passo 3: poderes do Da Roça e o sistema de escolher poder.
   - Na chegada a Conquista, o Da Roça só tem o básico da campanha 1: JOYSTICK, FALAR, VOAR, PEIDO, BOLINHA DE PAPEL e DASH.
     Os botões de Reeis, Bivolt, Batata e o carro a gás somem enquanto a Campanha 2 está ativa.
   - Cada vilão derrotado entrega um poder novo (8 no total). Eles são equipados no MURAL DOS PODERES, no quarto da
     pensão, em dois espaços: PODER 1 (tecla U) e PODER 2 (tecla I). Os dois botões usam o mesmo visual dos botões da campanha 1
     e ficam onde estavam os botões que saíram.
   - O Gugu do Ferro-Velho melhora os poderes (nível 1 a 3).
   O motor dos poderes não conhece o jogo: quem usa passa um "mundo" (herói, inimigos e funções de dano, empurrão,
   atordoar e confundir). Assim ele serve no treino do visualizador agora e nas lutas da campanha depois.
   O estado fica em uma chave própria (daroca-c2-poderes) até o save da Campanha 2 existir. */
(() => {
  'use strict';
  if (window.CampanhaPoderes) return;
  const KEY = 'daroca-c2-poderes', TAU = Math.PI * 2;

  /* ---------- catálogo ---------- */
  const PODERES = [
    { id: 'fofoca', nome: 'FOFOCA CONFUSA', curto: 'FOFOCA', vilao: 'Dona Creuza Fofoqueira', quem: 'c2_creuza', lugar: 'Bairro da pensão', cor: '#e48fb0',
      desc: 'Espalha uma fofoca fresquinha: quem estiver perto fica confuso e parte pra cima dos próprios colegas.', recarga: [12, 10, 8], raio: [210, 250, 300], dur: [4, 5, 6],
      nivel: ['Fofoca no raio de 210 por 4 s.', 'Raio maior e 5 s de confusão.', 'A fofoca vira notícia: 6 s, raio enorme.'],
      icone: ['..xxxxxxxx..', '.xoooooooox.', 'xoooooooooox', 'xoxxoxxoxxox', 'xoxxoxxoxxox', 'xoooooooooox', '.xoooooooox.', '..xxxxxxxx..', '...xxo......', '..xxo.......', '.xx.........', '............'] },
    { id: 'buzina', nome: 'BUZINA TURBO', curto: 'BUZINA', vilao: 'Tonhão do Mototáxi', quem: 'c2_tonhao', lugar: 'Monumento ao Índio', cor: '#f08a24',
      desc: 'Uma buzinada de mototáxi que vira onda sonora e empurra tudo que estiver na frente.', recarga: [6, 5, 4], alcance: [230, 270, 320], empurrao: [300, 360, 440], dano: [6, 9, 12],
      nivel: ['Empurra forte e dá 6 de dano.', 'Mais alcance, 9 de dano.', 'Buzina de caminhão: 12 de dano e empurrão gigante.'],
      icone: ['........x...', '..x......x..', 'xxxo..x...x.', 'xooxo..x..x.', 'xoooxo.x...x', 'xoooox.x...x', 'xoooox.x...x', 'xoooxo.x...x', 'xooxo..x..x.', 'xxxo..x...x.', '..x......x..', '........x...'] },
    { id: 'biscoito', nome: 'RAJADA DE BISCOITO', curto: 'BISCOITO', vilao: 'Seu Valdomiro da Feira', quem: 'c2_valdomiro', lugar: 'Feira', cor: '#e9d6a8',
      desc: 'Dispara um leque de biscoitos de polvilho crocantes. Cada um machuca pouco, mas são muitos.', recarga: [4, 3.5, 3], n: [5, 7, 9], dano: [5, 6, 7],
      nivel: ['5 biscoitos de 5 de dano.', '7 biscoitos de 6 de dano.', '9 biscoitos de 7: uma fornada inteira.'],
      icone: ['............', '.xxx....xxx.', 'xo.ox..xo.ox', 'xo.ox..xo.ox', '.xxx....xxx.', '............', '....xxxx....', '...xo..ox...', '...xo..ox...', '....xxxx....', '............', '............'] },
    { id: 'flash', nome: 'FLASH DO STORY', curto: 'FLASH', vilao: 'Kauã Influencer', quem: 'c2_kaua_influencer', lugar: 'Serra do Periperi', cor: '#c8d8ff',
      desc: 'Um flash de celular na cara: todo mundo em volta fica atordoado vendo estrelinha.', recarga: [10, 9, 8], raio: [250, 290, 340], dur: [2, 2.5, 3],
      nivel: ['Atordoa por 2 s.', 'Atordoa por 2,5 s, raio maior.', 'Flash com filtro: 3 s e alcance de live.'],
      icone: ['x....x....x.', '.x...x...x..', '..xxxxxxx...', '..xooooox...', 'xxxoxxxoxxx.', '..xoxxxox...', '..xooooox...', '..xooooox...', '..xxxxxxx...', '.x...x...x..', 'x....x....x.', '............'] },
    { id: 'cafezao', nome: 'CAFEZÃO', curto: 'CAFEZÃO', vilao: 'Barão do Café', quem: 'c2_barao', lugar: 'Fazendas de café', cor: '#a8743a',
      desc: 'Um gole de café do planalto: o Da Roça fica mais rápido e bate mais forte por um tempo.', recarga: [16, 14, 12], dur: [6, 8, 10], vel: [1.4, 1.5, 1.6], forca: [1.4, 1.6, 1.8],
      nivel: ['6 s: +40% velocidade e força.', '8 s: +50% velocidade, +60% força.', '10 s de café coado: +60% e +80%.'],
      icone: ['...x..x.....', '..x..x......', '...x..x.....', '............', 'xxxxxxxxx...', 'xoooooooxxx.', 'xoooooooxo.x', 'xoooooooxo.x', 'xoooooooxxx.', '.xoooooox...', '..xxxxxx....', 'xxxxxxxxxxx.'] },
    { id: 'supersoco', nome: 'SUPERSOCO', curto: 'SOCO', vilao: 'Breno Pitbull', quem: 'c2_breno', lugar: 'Teatro e Planetário', cor: '#e8433a',
      desc: 'Segure o botão para carregar e solte: um soco que arremessa o inimigo longe.', recarga: [5, 4.5, 4], dano: [20, 28, 36], carga: [1, .85, .7],
      nivel: ['Carrega em 1 s, até 20 de dano.', 'Carrega mais rápido, até 28.', 'Carrega em 0,7 s, até 36 de dano.'],
      icone: ['............', '..xxxxxxx...', '.xoxoxoxox..', '.xoxoxoxox..', '.xooooooox..', 'xxooooooox..', 'xoxooooox...', 'xooooooox...', '.xooooox....', '..xxxxx.....', '..xoox......', '..xxxx......'] },
    { id: 'clone', nome: 'CLONE DE LAN', curto: 'CLONE', vilao: 'Ryan e Bryan', quem: 'c2_ryan', lugar: 'Lan house do shopping', cor: '#5ae0d0',
      desc: 'Um Da Roça digital entra na luta e joga bolinha de papel junto com você.', recarga: [18, 16, 14], dur: [8, 10, 12], dano: [3, 4, 5],
      nivel: ['Clone por 8 s, 3 de dano por papel.', 'Clone por 10 s, 4 de dano.', 'Clone por 12 s, 5 de dano e mira melhor.'],
      icone: ['xxxxxxxxxxxx', 'xoooooooooox', 'xo.xx..xx.ox', 'xo.xx..xx.ox', 'xoxxxxxxxxox', 'xoxxxxxxxxox', 'xoooooooooox', 'xxxxxxxxxxxx', '....xxxx....', '..xxxxxxxx..', '............', '............'] },
    { id: 'aura', nome: 'AURA DE AMIZADE', curto: 'AURA', vilao: 'Fred', quem: 'fred_conquista', lugar: 'Escola SESI (antes da luta final)', cor: '#ffd24a',
      desc: 'Um escudo feito de amizade: enquanto ele brilha, nenhum golpe passa.', recarga: [22, 20, 18], dur: [4, 5, 6],
      nivel: ['Escudo de 4 s.', 'Escudo de 5 s.', 'Escudo de 6 s: amizade de verdade.'],
      icone: ['...xxxxxx...', '..x......x..', '.x.xx..xx.x.', 'x.xooxxoox.x', 'x.xoooooox.x', 'x.xoooooox.x', 'x..xoooox..x', '.x..xoox..x.', '..x..xx..x..', '...xxxxxx...', '............', '............'] }
  ];
  // o que ficou da campanha 1 (sempre com o Da Roça); os ícones vêm dos próprios botões da campanha 1
  const BASICOS = [
    { id: 'interact', nome: 'FALAR', tecla: 'E', desc: 'Conversar e interagir.' },
    { id: 'jump', nome: 'PULAR / VOAR', tecla: 'ESPAÇO', desc: 'Pula; segurando, voa.' },
    { id: 'paper', nome: 'BOLINHA DE PAPEL', tecla: 'J', desc: 'Joga bolinha de papel.' },
    { id: 'fart', nome: 'PEIDO', tecla: 'K', desc: 'A nuvem verde de sempre.' },
    { id: 'dash', nome: 'DASH', tecla: 'L', desc: 'Esquiva rápida.' }
  ];
  const SAIRAM = ['reeis', 'bivolt', 'taunt', 'vehicle']; // OOO REEEIS!, Bivolt, Batata! e o carro a gás ficam em Itabuna
  const byId = (id) => PODERES.find((p) => p.id === id);
  const lv = (p, campo) => p[campo][Math.max(0, Math.min(2, (estado.niveis[p.id] || 1) - 1))];

  /* ---------- estado salvo ---------- */
  let estado = { desbloqueados: [], equipados: [null, null], niveis: {} };
  try { const s = JSON.parse(localStorage.getItem(KEY) || 'null'); if (s && Array.isArray(s.desbloqueados)) estado = { desbloqueados: s.desbloqueados.filter(byId), equipados: (s.equipados || [null, null]).slice(0, 2).map((id) => (byId(id) ? id : null)), niveis: s.niveis || {} }; } catch (e) {}
  const salvar = () => { try { localStorage.setItem(KEY, JSON.stringify(estado)); } catch (e) {} avisar(); };
  const ouvintes = new Set(); const avisar = () => { for (const f of ouvintes) try { f(estadoPublico()); } catch (e) {} atualizarBotoes(); };
  const tem = (id) => estado.desbloqueados.includes(id);
  function desbloquear(id) { if (!byId(id) || tem(id)) return false; estado.desbloqueados.push(id); estado.niveis[id] = estado.niveis[id] || 1; const vazio = estado.equipados.indexOf(null); if (vazio >= 0) estado.equipados[vazio] = id; salvar(); return true; }
  function equipar(slot, id) { if (slot !== 0 && slot !== 1) return false; if (id !== null && !tem(id)) return false; const outro = estado.equipados.indexOf(id); if (id && outro >= 0 && outro !== slot) estado.equipados[outro] = estado.equipados[slot]; estado.equipados[slot] = id; salvar(); return true; }
  function upgrade(id) { if (!tem(id)) return false; const n = estado.niveis[id] || 1; if (n >= 3) return false; estado.niveis[id] = n + 1; salvar(); return true; }
  const estadoPublico = () => ({ desbloqueados: estado.desbloqueados.slice(), equipados: estado.equipados.slice(), niveis: { ...estado.niveis } });

  /* ---------- ícones pixelados (mesmo jeito dos botões da campanha 1: SVG com currentColor e o tom claro) ---------- */
  function iconeSVG(p, size = 24) {
    let a = '', b = ''; p.icone.forEach((row, y) => [...row].forEach((ch, x) => { const r = `M${x * 2} ${y * 2}h2v2h-2z`; if (ch === 'x') a += r; else if (ch === 'o') b += r; }));
    return `<svg class="control-icon c2-icone" viewBox="0 0 24 24" width="${size}" height="${size}" aria-hidden="true" shape-rendering="crispEdges"><path fill="currentColor" d="${a}"/><path class="icon-light" fill="${p.cor}" d="${b}"/></svg>`;
  }
  const iconeBasico = (id) => document.querySelector(`.touch-controls [data-action="${id}"] svg`)?.outerHTML || '';

  /* =====================================================================
     MOTOR: usar, atualizar e desenhar (coordenadas do mundo do jogo, chão em y=440)
     mundo = { heroi:{x,y,facing}, inimigos:()=>[...], dano(e,n,tipo,dir), empurrar(e,vx,vy), atordoar(e,s), confundir(e,s), camera, tremer(n) }
     ===================================================================== */
  const cd = {}; let efeitos = [], proj = [], buff = null, escudo = 0, escudoHit = 0, clone = null, carga = null, flashTela = 0, T = 0;
  const pronto = (id) => !(cd[id] > 0);
  function usar(slotOuId, mundo, fase = 'down') {
    const id = typeof slotOuId === 'number' ? estado.equipados[slotOuId] : slotOuId, p = byId(id); if (!p || !tem(id)) return { ok: false, motivo: p ? 'bloqueado' : 'vazio' };
    if (id === 'supersoco') return soco(p, mundo, fase);
    if (fase !== 'down') return { ok: false };
    if (!pronto(id)) return { ok: false, motivo: 'recarga', falta: cd[id] };
    const h = mundo.heroi, dir = h.facing < 0 ? -1 : 1, inim = (mundo.inimigos?.() || []).filter((e) => e.hp > 0);
    cd[id] = lv(p, 'recarga');
    if (id === 'fofoca') { const r = lv(p, 'raio'), d = lv(p, 'dur'); efeitos.push({ k: 'fofoca', x: h.x, y: h.y, t: 0, r }); for (const e of inim) if (Math.abs(e.x - h.x) < r) { mundo.confundir?.(e, d); efeitos.push({ k: 'confuso', e, t: 0, ate: d }); } }
    if (id === 'buzina') { const al = lv(p, 'alcance'); efeitos.push({ k: 'buzina', x: h.x + dir * 20, y: h.y - 40, dir, t: 0, al }); mundo.tremer?.(4);
      for (const e of inim) { const dx = (e.x - h.x) * dir; if (dx > -20 && dx < al && Math.abs((e.y ?? h.y) - h.y) < 90) { mundo.dano?.(e, lv(p, 'dano'), 'som', dir); mundo.empurrar?.(e, dir * lv(p, 'empurrao') * (1 - dx / al * .4), -160); } } }
    if (id === 'biscoito') { const n = lv(p, 'n'); for (let k = 0; k < n; k++) { const a = (k / Math.max(1, n - 1) - .5) * .7 - .08; proj.push({ k: 'biscoito', x: h.x + dir * 24, y: h.y - 46, vx: Math.cos(a) * 560 * dir, vy: Math.sin(a) * 560, dano: lv(p, 'dano'), vida: .9, rot: k }); } }
    if (id === 'flash') { const r = lv(p, 'raio'), d = lv(p, 'dur'); flashTela = .45; efeitos.push({ k: 'celular', t: 0 }); for (const e of inim) if (Math.abs(e.x - h.x) < r) { mundo.atordoar?.(e, d); efeitos.push({ k: 'estrelas', e, t: 0, ate: d }); } }
    if (id === 'cafezao') { buff = { ate: lv(p, 'dur'), vel: lv(p, 'vel'), forca: lv(p, 'forca'), t: 0 }; efeitos.push({ k: 'xicara', t: 0 }); }
    if (id === 'clone') clone = { x: h.x - dir * 60, y: h.y, facing: dir, t: 0, ate: lv(p, 'dur'), tiro: .3, dano: lv(p, 'dano') };
    if (id === 'aura') escudo = lv(p, 'dur');
    return { ok: true };
  }
  function soco(p, mundo, fase) {
    const h = mundo.heroi;
    if (fase === 'down') { if (!pronto('supersoco') || carga) return { ok: false, motivo: 'recarga', falta: cd.supersoco }; carga = { t: 0, max: lv(p, 'carga') }; return { ok: true, carregando: true }; }
    if (!carga) return { ok: false };
    const f = Math.max(.35, Math.min(1, carga.t / carga.max)), dir = h.facing < 0 ? -1 : 1; carga = null; cd.supersoco = lv(p, 'recarga');
    efeitos.push({ k: 'pow', x: h.x + dir * 54, y: h.y - 46, t: 0, f }); mundo.tremer?.(4 + f * 8);
    for (const e of (mundo.inimigos?.() || [])) { if (e.hp <= 0) continue; const dx = (e.x - h.x) * dir; if (dx > -10 && dx < 120 && Math.abs((e.y ?? h.y) - h.y) < 70) { mundo.dano?.(e, Math.round(lv(p, 'dano') * f * (buff ? buff.forca : 1)), 'soco', dir); mundo.empurrar?.(e, dir * (300 + 500 * f), -220 * f); } }
    return { ok: true, forca: f };
  }
  function atualizar(dt, mundo) {
    T += dt; for (const k in cd) cd[k] = Math.max(0, cd[k] - dt); flashTela = Math.max(0, flashTela - dt); escudoHit = Math.max(0, escudoHit - dt);
    if (escudo > 0) escudo = Math.max(0, escudo - dt);
    if (buff) { buff.t += dt; if (buff.t >= buff.ate) buff = null; }
    if (carga) { carga.t += dt; if (carga.t > carga.max + .35) soco(byId('supersoco'), mundo, 'up'); }
    efeitos = efeitos.filter((f) => { f.t += dt; return f.t < (f.ate || (f.k === 'fofoca' ? 1 : f.k === 'buzina' ? .6 : f.k === 'pow' ? .4 : 1.2)); });
    const inim = (mundo?.inimigos?.() || []).filter((e) => e.hp > 0);
    proj = proj.filter((q) => { q.vida -= dt; q.x += q.vx * dt; q.y += q.vy * dt; q.vy += 380 * dt;
      for (const e of inim) if (Math.abs(e.x - q.x) < 22 && q.y > (e.y ?? 440) - 76 && q.y < (e.y ?? 440)) { mundo.dano?.(e, Math.round(q.dano * (q.k === 'biscoito' && buff ? buff.forca : 1)), q.k, Math.sign(q.vx)); efeitos.push({ k: 'farelo', x: q.x, y: q.y, t: 0, ate: .35 }); return false; }
      return q.vida > 0 && q.y < 470; });
    if (clone) { const h = mundo.heroi; clone.t += dt; clone.facing = h.facing < 0 ? -1 : 1; const alvoX = h.x - clone.facing * 60; clone.x += (alvoX - clone.x) * Math.min(1, dt * 5); clone.y += (h.y - clone.y) * Math.min(1, dt * 6);
      clone.tiro -= dt; if (clone.tiro <= 0 && inim.length) { const alvo = inim.reduce((a, e) => (Math.abs(e.x - clone.x) < Math.abs(a.x - clone.x) ? e : a)); const dir = alvo.x > clone.x ? 1 : -1; clone.facing = dir; proj.push({ k: 'papel', x: clone.x + dir * 18, y: clone.y - 50, vx: dir * 520, vy: -60, dano: clone.dano, vida: .9 }); clone.tiro = .75; }
      if (clone.t >= clone.ate) { efeitos.push({ k: 'glitch', x: clone.x, y: clone.y, t: 0, ate: .5 }); clone = null; } }
  }
  // dano que chega no Da Roça: a aura segura; o café não muda o dano recebido
  function filtrarDano(n) { if (escudo > 0) { escudoHit = .3; return 0; } return n; }
  const multiplicadores = () => ({ vel: buff ? buff.vel : 1, forca: buff ? buff.forca : 1 });

  let cloneCv = null;
  function desenhar(c, mundo) {
    const h = mundo.heroi, t = T;
    c.save(); c.imageSmoothingEnabled = false;
    const R = (x, y, w, hh, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(hh)); };
    if (buff) { const a = .25 + Math.sin(t * 8) * .08; c.fillStyle = `rgba(168,116,58,${a})`; c.beginPath(); c.ellipse(h.x, h.y - 44, 34, 54, 0, 0, TAU); c.fill(); for (let k = 0; k < 4; k++) { const q = (t * 1.2 + k / 4) % 1; R(h.x - 14 + k * 9 + Math.sin(t * 3 + k) * 3, h.y - 70 - q * 40, 3, 6, `rgba(255,255,255,${(1 - q) * .55})`); } }
    if (clone) { if (!cloneCv) { cloneCv = document.createElement('canvas'); cloneCv.width = 120; cloneCv.height = 140; } const cc = cloneCv.getContext('2d'); cc.imageSmoothingEnabled = false; cc.clearRect(0, 0, 120, 140); window.Art?.drawCharacter?.(cc, 'daroca', 60, 130, { frame: t, facing: clone.facing, moving: true, grounded: true });
      cc.save(); cc.globalCompositeOperation = 'source-atop'; cc.fillStyle = 'rgba(90,224,208,.55)'; cc.fillRect(0, 0, 120, 140); for (let y = 0; y < 140; y += 4) { cc.fillStyle = 'rgba(10,40,60,.35)'; cc.fillRect(0, y + Math.floor(t * 20) % 4, 120, 1); } cc.restore();
      c.globalAlpha = .82 + (Math.random() < .06 ? -.4 : 0); c.drawImage(cloneCv, Math.round(clone.x - 60) + (Math.random() < .05 ? 4 : 0), Math.round(clone.y - 130)); c.globalAlpha = 1; R(clone.x - 16, clone.y - 104, 32, 9, '#0e1016'); c.font = '9px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#5ae0d0'; c.fillText('LAN', clone.x, clone.y - 97); }
    for (const q of proj) { if (q.k === 'biscoito') { c.save(); c.translate(q.x, q.y); c.rotate(t * 10 + q.rot); R(-7, -2, 14, 4, '#8a6a3a'); R(-6, -3, 12, 6, '#f6ecd0'); R(-3, -1, 6, 2, '#8a6a3a'); c.restore(); } else { R(q.x - 5, q.y - 5, 10, 10, '#f6f4ee'); R(q.x - 3, q.y - 3, 4, 4, '#d8d4c8'); } }
    for (const f of efeitos) {
      const u = f.t / (f.ate || 1);
      if (f.k === 'fofoca') { const r = f.r * Math.min(1, f.t / .6); c.strokeStyle = `rgba(228,143,176,${1 - f.t})`; c.lineWidth = 3; c.setLineDash([8, 6]); c.beginPath(); c.ellipse(f.x, f.y - 30, r, r * .28, 0, 0, TAU); c.stroke(); c.setLineDash([]); for (let k = 0; k < 5; k++) { const a = k / 5 * TAU + f.t * 2, x = f.x + Math.cos(a) * r * .7, y = f.y - 70 + Math.sin(a) * 20; R(x - 12, y - 8, 24, 14, '#fbf2f6'); R(x - 4, y + 6, 4, 4, '#fbf2f6'); c.font = '9px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#c4384e'; c.fillText(['PSIU', 'SABIA?', 'NOSSA!', 'JURA?', 'OXE!'][k], x, y + 3); } }
      if (f.k === 'confuso' && f.e.hp > 0) { const x = f.e.x, y = (f.e.y ?? 440) - 100 + Math.sin(t * 6) * 3; R(x - 14, y - 10, 28, 18, '#fbf2f6'); R(x - 14, y - 10, 28, 2, '#e48fb0'); c.font = '12px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#c4384e'; c.fillText(Math.floor(t * 3) % 2 ? '?!' : '!?', x, y + 4); }
      if (f.k === 'buzina') { for (let k = 0; k < 4; k++) { const q = Math.min(1, f.t / .5 + k * .12), r = 20 + q * f.al * .9; c.strokeStyle = `rgba(240,138,36,${(1 - q) * .9})`; c.lineWidth = 4; c.beginPath(); c.arc(f.x, f.y, r, f.dir > 0 ? -.6 : Math.PI - .6, f.dir > 0 ? .6 : Math.PI + .6); c.stroke(); } c.font = '16px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#2a1a14'; c.fillText('FOOOM!', f.x + f.dir * 70 + 2, f.y - 40 + 2); c.fillStyle = '#ffd24a'; c.fillText('FOOOM!', f.x + f.dir * 70, f.y - 40); }
      if (f.k === 'celular') { const x = h.x + (h.facing < 0 ? -26 : 26), y = h.y - 74; R(x - 7, y - 12, 14, 24, '#1c1c24'); R(x - 5, y - 10, 10, 18, '#5ab8e8'); if (f.t < .3) { c.fillStyle = `rgba(255,255,255,${1 - f.t / .3})`; c.beginPath(); c.arc(x, y - 6, 26 + f.t * 120, 0, TAU); c.fill(); } }
      if (f.k === 'estrelas' && f.e.hp > 0) for (let k = 0; k < 3; k++) { const a = t * 4 + k * 2.1, x = f.e.x + Math.cos(a) * 18, y = (f.e.y ?? 440) - 92 + Math.sin(a) * 5; R(x - 1, y - 4, 3, 9, '#ffe24a'); R(x - 4, y - 1, 9, 3, '#ffe24a'); }
      if (f.k === 'xicara' && f.t < 1.2) { const x = h.x, y = h.y - 108 - f.t * 12; R(x - 9, y, 18, 14, '#f6f2ea'); R(x + 9, y + 3, 4, 7, '#f6f2ea'); R(x - 7, y + 2, 14, 3, '#5a3624'); for (let k = 0; k < 3; k++) R(x - 6 + k * 5, y - 8 - Math.sin(t * 6 + k) * 2, 2, 6, 'rgba(255,255,255,.7)'); }
      if (f.k === 'pow') { const s = 1 + f.t * 3; c.save(); c.translate(f.x, f.y); c.scale(s, s); c.globalAlpha = 1 - f.t / .4; c.fillStyle = '#ffd24a'; c.beginPath(); for (let k = 0; k < 16; k++) { const a = k / 16 * TAU, r = k % 2 ? 10 : 22 * (.6 + f.f * .5); c.lineTo(Math.cos(a) * r, Math.sin(a) * r); } c.fill(); c.font = '10px Pixel, monospace'; c.textAlign = 'center'; c.fillStyle = '#c4384e'; c.fillText('POW!', 0, 4); c.restore(); }
      if (f.k === 'farelo') for (let k = 0; k < 5; k++) R(f.x + (k - 2) * 5 * (1 + u * 3), f.y + u * 20 - Math.abs(k - 2) * 4, 3, 3, '#f6ecd0');
      if (f.k === 'glitch') for (let k = 0; k < 6; k++) R(f.x - 30 + Math.random() * 60, f.y - 100 + k * 16, 20 + Math.random() * 30, 4, `rgba(90,224,208,${1 - u})`);
    }
    if (carga) { const f = Math.min(1, carga.t / carga.max), x = h.x + (h.facing < 0 ? -24 : 24), y = h.y - 48; c.fillStyle = `rgba(232,67,58,${.25 + f * .4})`; c.beginPath(); c.arc(x, y, 8 + f * 16 + Math.sin(t * 30) * 2, 0, TAU); c.fill(); R(h.x - 24, h.y - 120, 48, 6, '#2a1a14'); R(h.x - 23, h.y - 119, 46 * f, 4, f >= 1 ? '#ffd24a' : '#e8433a'); }
    if (escudo > 0) { const a = .35 + Math.sin(t * 5) * .1 + escudoHit; c.strokeStyle = `rgba(255,210,74,${Math.min(1, a + .3)})`; c.lineWidth = 3; c.fillStyle = `rgba(255,226,140,${a * .4})`; c.beginPath(); c.ellipse(h.x, h.y - 44, 40, 58, 0, 0, TAU); c.fill(); c.stroke();
      for (let k = 0; k < 4; k++) { const an = t * 2 + k * TAU / 4, x = h.x + Math.cos(an) * 40, y = h.y - 44 + Math.sin(an) * 56; R(x - 4, y - 2, 3, 3, '#ff6a8a'); R(x + 1, y - 2, 3, 3, '#ff6a8a'); R(x - 3, y + 1, 6, 2, '#ff6a8a'); R(x - 1, y + 3, 2, 2, '#ff6a8a'); } }
    if (flashTela > 0) { const cam = Number(mundo.camera) || 0; c.fillStyle = `rgba(255,255,255,${flashTela / .45 * .85})`; c.fillRect(cam - 20, -20, 1000, 600); }
    c.restore();
  }

  /* =====================================================================
     MURAL DOS PODERES (no quarto da pensão): escolher e equipar
     ===================================================================== */
  let painel = null, sel = 0, aoFechar = null, modoTeste = false;
  function css() {
    if (document.getElementById('c2PoderesCss')) return; const st = document.createElement('style'); st.id = 'c2PoderesCss';
    st.textContent = `#gameShell:not(.c2-controles) .c2-poder-btn{display:none!important}#gameShell.c2-controles :is(.reeis-btn,.taunt-btn,.vehicle-btn,.bivolt-btn){display:none!important}
.c2-poder-btn{position:relative}.c2-poder-btn.vazio{opacity:.45}.c2-poder-btn .c2-cd{position:absolute;inset:0;background:rgba(10,8,6,.55);clip-path:inset(var(--cd,100%) 0 0 0);pointer-events:none;border-radius:inherit}
.c2-mural{position:fixed;inset:0;z-index:2147483100;display:grid;place-items:center;background:rgba(8,6,4,.72);font-family:Pixel,monospace;color:#f6ead0;image-rendering:pixelated}.c2-mural[hidden]{display:none}
.c2-mural .mb{width:min(980px,calc(100vw - 16px));max-height:calc(100vh - 16px);overflow:auto;background:#8a6a45;border:6px solid #4a2e18;box-shadow:0 0 0 4px #1c1208,0 18px 40px rgba(0,0,0,.6);padding:14px;background-image:radial-gradient(#9a7a52 1px,transparent 1px);background-size:6px 6px}
.c2-mural h2{margin:0 0 4px;font-size:18px;color:#fff6d8;text-shadow:2px 2px #3a2414}.c2-mural .sub{font-size:10px;color:#f2e2b8;margin-bottom:10px}
.c2-mural .linha{display:flex;gap:10px;flex-wrap:wrap;align-items:stretch;margin-bottom:10px}.c2-mural .slot{flex:1;min-width:200px;background:#2a1e14;border:3px solid #e8c66a;padding:8px;display:flex;gap:8px;align-items:center;cursor:pointer}.c2-mural .slot b{font-size:11px;color:#ffd98a}.c2-mural .slot span{font-size:9px;color:#c8b48a;display:block}
.c2-mural .basicos{background:#f6efd8;color:#3a2414;border:2px solid #4a2e18;padding:6px 8px;font-size:9px;display:flex;flex-wrap:wrap;gap:8px;align-items:center}.c2-mural .basicos i{font-style:normal;display:inline-flex;gap:4px;align-items:center;background:#e8dcc0;padding:3px 6px;border:1px solid #b8a47a}.c2-mural .basicos svg{width:16px;height:16px;color:#3a2414}
.c2-mural .grade{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}@media(max-width:700px){.c2-mural .grade{grid-template-columns:repeat(2,1fr)}}
.c2-mural .card{position:relative;background:#f6efd8;color:#2a1e14;border:2px solid #4a2e18;padding:8px 8px 6px;text-align:center;cursor:pointer;transform:rotate(var(--r,0deg));box-shadow:2px 3px 0 rgba(0,0,0,.35)}.c2-mural .card::before{content:'';position:absolute;top:-6px;left:50%;width:10px;height:10px;margin-left:-5px;background:var(--pin,#c43c3a);border-radius:50%;box-shadow:inset -2px -2px rgba(0,0,0,.3)}
.c2-mural .card.sel{outline:4px solid #ffd24a;outline-offset:2px}.c2-mural .card.bloq{background:#3a2e24;color:#a8946a}.c2-mural .card canvas{width:64px;height:64px;image-rendering:pixelated;display:block;margin:0 auto 2px}.c2-mural .card b{font-size:10px;display:block}.c2-mural .card small{font-size:8px;display:block;margin-top:2px}.c2-mural .card .estr{color:#c4743a;font-size:10px}.c2-mural .card .eq{position:absolute;top:4px;right:4px;font-size:8px;background:#2c5a9e;color:#fff;padding:1px 4px}
.c2-mural .det{margin-top:10px;background:#2a1e14;border:3px solid #e8c66a;padding:10px;display:flex;gap:12px;align-items:flex-start;flex-wrap:wrap}.c2-mural .det .ic{color:#f6ead0}.c2-mural .det .ic svg{width:48px;height:48px}.c2-mural .det p{margin:2px 0;font-size:11px;line-height:1.5}.c2-mural .det .nv{font-size:9px;color:#c8b48a}
.c2-mural .bts{display:flex;gap:6px;flex-wrap:wrap;margin-top:6px}.c2-mural button{font:inherit;font-size:10px;padding:7px 10px;background:#4a3420;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}.c2-mural button:hover,.c2-mural button:focus{background:#e8c66a;color:#2a1e14;outline:none}.c2-mural button[disabled]{opacity:.4;cursor:default}
.c2-mural .rod{display:flex;justify-content:space-between;align-items:center;margin-top:10px;font-size:9px;color:#fff6d8;gap:8px;flex-wrap:wrap}`;
    document.head.appendChild(st);
  }
  function retratoVilao(cv, p, bloq) { const c = cv.getContext('2d'); c.imageSmoothingEnabled = false; c.clearRect(0, 0, 64, 64); c.save(); c.translate(32, 74); c.scale(1.05, 1.05); window.Art?.drawCharacter?.(c, p.quem, 0, 0, { frame: 1, facing: 1 }); c.restore(); if (bloq) { c.save(); c.globalCompositeOperation = 'source-atop'; c.fillStyle = '#1c140c'; c.fillRect(0, 0, 64, 64); c.restore(); } }
  function montarMural() {
    css(); painel = document.createElement('div'); painel.className = 'c2-mural'; painel.hidden = true; painel.setAttribute('role', 'dialog'); painel.setAttribute('aria-label', 'Mural dos poderes');
    painel.innerHTML = '<div class="mb"><h2>MURAL DOS PODERES</h2><div class="sub">Os poderes da campanha 1 ficaram em Itabuna. Cada vilão vencido deixa um poder novo. Escolha dois para levar.</div><div class="linha slots"></div><div class="basicos"></div><div class="grade" style="margin-top:14px"></div><div class="det"></div><div class="rod"><span class="info"></span><span class="bts"><button type="button" data-a="teste" hidden>TESTE: LIBERAR TODOS</button><button type="button" data-a="fechar">PRONTO ✓</button></span></div></div>';
    document.body.appendChild(painel);
    painel.addEventListener('click', (e) => { const b = e.target.closest('[data-a]'); if (!b) { if (e.target === painel) fecharMural(); return; } const a = b.dataset.a;
      if (a === 'fechar') fecharMural(); if (a === 'teste') { for (const p of PODERES) desbloquear(p.id); render(); } if (a === 'card') { sel = Number(b.dataset.i); render(); }
      if (a === 'eq0' || a === 'eq1') { equipar(a === 'eq0' ? 0 : 1, PODERES[sel].id); render(); } if (a === 'tirar') { equipar(Number(b.dataset.s), null); render(); } if (a === 'up') { upgrade(PODERES[sel].id); render(); } });
  }
  function render() {
    const s = estado; const slots = painel.querySelector('.slots'); slots.innerHTML = '';
    [0, 1].forEach((i) => { const id = s.equipados[i], p = byId(id), d = document.createElement('div'); d.className = 'slot';
      d.innerHTML = `${p ? iconeSVG(p, 32) : '<svg width="32" height="32"></svg>'}<div><b>PODER ${i + 1} · tecla ${i ? 'I' : 'U'}</b><span>${p ? p.nome + ' ' + '★'.repeat(s.niveis[id] || 1) : 'vazio: escolha um poder no mural'}</span></div>${p ? `<button type="button" data-a="tirar" data-s="${i}" style="margin-left:auto">TIRAR</button>` : ''}`; d.style.color = '#f6ead0'; slots.appendChild(d); });
    painel.querySelector('.basicos').innerHTML = '<b>SEMPRE COM VOCÊ:</b>' + BASICOS.map((b) => `<i>${iconeBasico(b.id)}${b.nome} <small>(${b.tecla})</small></i>`).join('') + '<i>JOYSTICK</i>';
    const g = painel.querySelector('.grade'); g.innerHTML = '';
    PODERES.forEach((p, i) => { const ok = tem(p.id), d = document.createElement('div'); d.className = 'card' + (ok ? '' : ' bloq') + (i === sel ? ' sel' : ''); d.dataset.a = 'card'; d.dataset.i = i; d.tabIndex = 0; d.style.setProperty('--r', `${(hash(i) - .5) * 4}deg`); d.style.setProperty('--pin', ['#c43c3a', '#2c5a9e', '#3c8a5a', '#e8c24c'][i % 4]);
      const eq = s.equipados.indexOf(p.id); d.innerHTML = `${eq >= 0 ? `<span class="eq">${eq + 1}</span>` : ''}<canvas width="64" height="64"></canvas><b>${ok ? p.nome : '???'}</b><small>${ok ? `<span class="estr">${'★'.repeat(s.niveis[p.id] || 1)}${'☆'.repeat(3 - (s.niveis[p.id] || 1))}</span>` : 'vença ' + p.vilao}</small>`;
      g.appendChild(d); retratoVilao(d.querySelector('canvas'), p, !ok); });
    const p = PODERES[sel], ok = tem(p.id), n = s.niveis[p.id] || 1, det = painel.querySelector('.det');
    det.innerHTML = `<div class="ic">${ok ? iconeSVG(p, 48) : '<svg width="48" height="48"></svg>'}</div><div style="flex:1;min-width:220px"><p style="color:#ffd98a">${ok ? p.nome : '??? (bloqueado)'}</p><p>${ok ? p.desc : `Derrote <b>${p.vilao}</b> (${p.lugar}) para ganhar este poder.`}</p>${ok ? `<p class="nv">NÍVEL ${n}: ${p.nivel[n - 1]}${n < 3 ? `<br>PRÓXIMO (com o Gugu do Ferro-Velho): ${p.nivel[n]}` : '<br>NÍVEL MÁXIMO'}</p><p class="nv">RECARGA: ${String(lv(p, 'recarga')).replace('.', ',')} s</p>` : ''}
      <div class="bts">${ok ? `<button type="button" data-a="eq0">EQUIPAR NO 1 (U)</button><button type="button" data-a="eq1">EQUIPAR NO 2 (I)</button>${modoTeste && n < 3 ? '<button type="button" data-a="up">TESTE: UPGRADE DO GUGU</button>' : ''}` : ''}</div></div>`;
    painel.querySelector('.info').textContent = `${s.desbloqueados.length}/8 PODERES · ← → escolher · 1/2 equipar · ESC fechar`;
    painel.querySelector('[data-a="teste"]').hidden = !modoTeste;
  }
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  function abrirMural(opts = {}) { if (!painel) montarMural(); modoTeste = !!opts.teste; aoFechar = opts.onClose || null; painel.hidden = false; render(); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } })); }
  function fecharMural() { if (!painel || painel.hidden) return; painel.hidden = true; window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); const f = aoFechar; aoFechar = null; f?.(); }
  addEventListener('keydown', (e) => { if (!painel || painel.hidden) return; const k = e.key;
    if (k === 'Escape') fecharMural(); else if (k === 'ArrowRight') { sel = (sel + 1) % 8; render(); } else if (k === 'ArrowLeft') { sel = (sel + 7) % 8; render(); } else if (k === 'ArrowDown') { sel = (sel + 4) % 8; render(); } else if (k === 'ArrowUp') { sel = (sel + 4) % 8; render(); }
    else if (k === '1' || k === '2') { equipar(Number(k) - 1, PODERES[sel].id); render(); } else if (k === 'Enter' && document.activeElement?.tagName === 'BUTTON') return; else return;
    e.preventDefault(); e.stopImmediatePropagation(); }, true);

  /* =====================================================================
     CONTROLES DA CAMPANHA 2 no jogo: os mesmos botões, sem Reeis/Bivolt/Batata/carro, mais PODER 1 e PODER 2
     ===================================================================== */
  function criarBotoes() {
    const box = document.querySelector('#gameShell .touch-extras'); if (!box || document.getElementById('c2Poder1')) return; css();
    [0, 1].forEach((i) => { const b = document.createElement('button'); b.type = 'button'; b.id = `c2Poder${i + 1}`; b.className = 'touch-btn c2-poder-btn'; b.dataset.action = `poder${i + 1}`; b.setAttribute('aria-label', `Poder equipado ${i + 1}`); box.appendChild(b); });
    atualizarBotoes();
  }
  function atualizarBotoes() {
    [0, 1].forEach((i) => { const b = document.getElementById(`c2Poder${i + 1}`); if (!b) return; const p = byId(estado.equipados[i]);
      b.classList.toggle('vazio', !p); b.innerHTML = `${p ? iconeSVG(p) : '<svg class="control-icon" viewBox="0 0 24 24" width="24" height="24"><path fill="currentColor" d="M4 4h16v2H4zM4 18h16v2H4zM4 6h2v12H4zM18 6h2v12h-2z"/></svg>'}<small>${p ? p.curto : 'VAZIO'}</small><kbd>${i ? 'I' : 'U'}</kbd><span class="c2-cd"></span>`; });
  }
  function atualizarRecarga() { [0, 1].forEach((i) => { const b = document.getElementById(`c2Poder${i + 1}`), p = byId(estado.equipados[i]); if (!b || !p) return; const f = (cd[p.id] || 0) / lv(p, 'recarga'); b.querySelector('.c2-cd')?.style.setProperty('--cd', `${Math.round((1 - f) * 100)}%`); }); }
  let ativo = false, forcado = null;
  function controles(on, o) { if (o && 'forcar' in o) forcado = o.forcar ? !!on : null; if (forcado !== null) on = forcado; on = !!on; if (on === ativo) return; ativo = on; criarBotoes(); document.getElementById('gameShell')?.classList.toggle('c2-controles', on); }
  if (document.readyState === 'loading') addEventListener('DOMContentLoaded', criarBotoes); else criarBotoes();
  setInterval(atualizarRecarga, 120);

  window.CampanhaPoderes = Object.freeze({
    lista: () => PODERES.map(({ id, nome, curto, vilao, quem, lugar, desc, cor }) => ({ id, nome, curto, vilao, quem, lugar, desc, cor })),
    basicos: () => BASICOS.slice(), sairam: () => SAIRAM.slice(),
    estado: estadoPublico, desbloquear, equipar, upgrade, ouvir: (f) => { ouvintes.add(f); return () => ouvintes.delete(f); },
    usar, atualizar, desenhar, filtrarDano, multiplicadores, recarga: (id) => cd[id] || 0, recargaTotal: (id) => (byId(id) ? lv(byId(id), 'recarga') : 1), escudo: () => escudo > 0,
    abrirMural, fecharMural, muralAberto: () => !!painel && !painel.hidden,
    controles, ativa: () => ativo, iconeSVG: (id) => (byId(id) ? iconeSVG(byId(id)) : ''),
    // só para teste
    zerar: () => { estado = { desbloqueados: [], equipados: [null, null], niveis: {} }; salvar(); for (const k in cd) cd[k] = 0; buff = null; escudo = 0; clone = null; efeitos = []; proj = []; }
  });
})();
