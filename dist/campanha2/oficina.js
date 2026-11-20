/* Campanha 2 · OFICINA DE MELHORIAS do Gugu do Ferro-Velho.
   Tela própria, desenhada em pixel art com luz e sombra: galpão de zinco enferrujado, lâmpada pendurada balançando
   (o cone de luz e as sombras se mexem junto), quadro de ferramentas, prateleiras com potes e latas, pneus, capô de
   carro velho, poeira no ar e a MÁQUINA DE TURBINAR (caldeira com manômetro, canos e vapor).
   Você escolhe um poder que já tem, vê o nível de agora e o próximo, e paga em moedas. O Gugu bota a garrafada na
   máquina, martela, solda (faíscas), o manômetro sobe, a garrafa sai brilhando e um carimbo marca o NÍVEL novo.
   API: CampanhaOficina.abrir({ teste }), fechar(), aberta(), precos(). Os níveis ficam no estado dos poderes. */
(() => {
  'use strict';
  if (window.CampanhaOficina || !window.CampanhaPoderes) return;
  const PW = window.CampanhaPoderes, LW = 480, LH = 270, TAU = Math.PI * 2;
  const PRECO = [0, 80, 160]; // nível 1→2 e 2→3
  let box = null, cv = null, c = null, raf = 0, last = 0, t = 0, aberto = false, sel = 0, anim = null, poeira = [], faiscas = [], vapor = [], falaTxt = '', falaT = 0, carimbo = null, aoFechar = null;
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v)), hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const moedas = () => window.CampanhaLoja?.moedas?.() ?? 0;
  const meus = () => PW.lista().filter((p) => PW.estado().desbloqueados.includes(p.id));
  const FALAS = { oi: ['Chega mais! Sucata boa vira coisa melhor ainda.', 'Oficina do Gugu: se não tem conserto, eu invento um.', 'Traz a garrafada que eu turbino. Preço de amigo... quase.'],
    pobre: ['Sem moeda não tem solda, meu filho.', 'Volta quando tiver uns trocados. Os vilões costumam deixar cair.'], max: ['Esse aí já tá no talo. Mais que isso explode.', 'Nível 3! Nem eu sei turbinar mais que isso.'],
    feito: ['PRONTO! Saiu quentinho da máquina.', 'Ó a faísca! Ficou uma beleza.', 'Turbinado! Tenta não quebrar na primeira briga.'], vazio: ['Você ainda não tem garrafada nenhuma. Vence uns vilões e passa na banca do Seu Lindomar.'] };
  const sorte = (a) => a[Math.floor(Math.random() * a.length)];
  function falar(s) { falaTxt = s; falaT = 0; }

  /* ---------- montagem ---------- */
  function css() {
    if (document.getElementById('c2OficinaCss')) return; const st = document.createElement('style'); st.id = 'c2OficinaCss';
    st.textContent = `.c2-ofi{position:fixed;inset:0;z-index:2147483300;background:#050403;display:flex;align-items:center;justify-content:center;font-family:Pixel,monospace;color:#f6ead0;opacity:0;transition:opacity .3s}.c2-ofi.on{opacity:1}.c2-ofi[hidden]{display:none}
.c2-ofi .tela{position:relative;width:min(100vw,177.78vh);aspect-ratio:16/9;max-height:100vh}.c2-ofi canvas{width:100%;height:100%;display:block;image-rendering:pixelated}
.c2-ofi .lista{position:absolute;left:2%;top:25%;width:24%;display:flex;flex-direction:column;gap:5px}.c2-ofi .lista button{font:clamp(7px,.9vw,10px) Pixel,monospace;text-align:left;display:flex;align-items:center;gap:8px;padding:6px 8px;background:#2a1e14e8;color:#f6ead0;border:3px solid #5a4028;box-shadow:0 3px 0 #120c08;cursor:pointer}
.c2-ofi .lista button.on{background:#e8c66a;color:#2a1e14;border-color:#fff2c8}.c2-ofi .lista button svg{width:22px;height:22px;flex:none}.c2-ofi .lista .pips{margin-left:auto;letter-spacing:2px;color:#ffd24a}.c2-ofi .lista button.on .pips{color:#7a3a10}
.c2-ofi .ficha{position:absolute;right:2%;top:5%;width:28%;background:#e8dcc0;color:#2a1a10;border:4px solid #3a2a1a;box-shadow:5px 6px 0 #0008;padding:10px 12px;font:clamp(8px,1.05vw,12px) Space,Arial,sans-serif;line-height:1.45;transform:rotate(-.6deg)}
.c2-ofi .ficha:before{content:'';position:absolute;left:50%;top:-10px;width:16px;height:16px;margin-left:-8px;border-radius:50%;background:radial-gradient(#e8433a,#7a1a1a);box-shadow:0 2px 0 #0006}
.c2-ofi .ficha b{display:block;font:clamp(8px,1vw,11px) Pixel,monospace;color:#7a2a1a;margin-bottom:6px}.c2-ofi .ficha .n{display:block;margin:6px 0;padding:6px;background:#f6efd8;border:2px dashed #8a6a4a}.c2-ofi .ficha .n i{font-style:normal;font:clamp(7px,.8vw,9px) Pixel,monospace;color:#5a3a20;display:block}
.c2-ofi .ficha .p{font:clamp(8px,1vw,11px) Pixel,monospace;margin:8px 0}.c2-ofi .ficha button{font:clamp(8px,1vw,11px) Pixel,monospace;padding:9px 10px;width:100%;background:#e8a83a;color:#1c1408;border:3px solid #3a2a1a;box-shadow:0 4px 0 #3a2410;cursor:pointer}.c2-ofi .ficha button[disabled]{opacity:.45;cursor:default}
.c2-ofi .sair{position:absolute;left:2%;top:3%;font:11px Pixel,monospace;padding:8px 12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;cursor:pointer}`;
    document.head.appendChild(st);
  }
  function montar() {
    css(); box = document.createElement('div'); box.className = 'c2-ofi'; box.hidden = true; box.setAttribute('role', 'dialog'); box.setAttribute('aria-label', 'Oficina de melhorias do Gugu');
    box.innerHTML = `<div class="tela"><canvas width="${LW}" height="${LH}"></canvas><button type="button" class="sair">✕ SAIR DA OFICINA</button><div class="lista"></div><div class="ficha"></div></div>`;
    document.body.appendChild(box); cv = box.querySelector('canvas'); c = cv.getContext('2d'); c.imageSmoothingEnabled = false;
    box.querySelector('.sair').addEventListener('click', fechar);
    addEventListener('keydown', (e) => { if (!aberto) return; const k = e.code; if (k === 'Escape') fechar(); else if (k === 'ArrowDown' || k === 'KeyS') escolher(sel + 1); else if (k === 'ArrowUp' || k === 'KeyW') escolher(sel - 1); else if (k === 'Enter' || k === 'KeyE' || k === 'Space') turbinar(); else return; e.preventDefault(); e.stopImmediatePropagation(); }, true);
    for (let i = 0; i < 40; i++) poeira.push({ x: Math.random() * LW, y: Math.random() * LH, v: 2 + Math.random() * 6, f: Math.random() * TAU });
  }
  function listar() {
    const L = meus(), el = box.querySelector('.lista'); el.innerHTML = '';
    if (!L.length) { el.innerHTML = '<button type="button" class="on">NENHUMA GARRAFADA AINDA</button>'; ficha(); return; }
    sel = clamp(sel, 0, L.length - 1);
    L.forEach((p, i) => { const n = PW.estado().niveis[p.id] || 1, b = document.createElement('button'); b.type = 'button'; b.className = i === sel ? 'on' : ''; b.innerHTML = `${PW.iconeSVG(p.id)}<span>${p.curto}</span><span class="pips">${'■'.repeat(n)}${'□'.repeat(3 - n)}</span>`; b.addEventListener('click', () => escolher(i)); el.appendChild(b); });
    ficha();
  }
  function ficha() {
    const f = box.querySelector('.ficha'), L = meus(); if (!L.length) { f.innerHTML = `<b>FICHA DA OFICINA</b>${FALAS.vazio[0]}`; return; }
    const p = L[sel], n = PW.estado().niveis[p.id] || 1, preco = PRECO[n] || 0, max = n >= 3, pode = !max && moedas() >= preco && !anim;
    f.innerHTML = `<b>${p.nome}</b><span class="n"><i>AGORA · NÍVEL ${n}</i>${p.niveis[n - 1] || p.desc}</span>${max ? '<span class="n"><i>NO TALO</i>Nível máximo. Mais que isso, só com outra garrafada.</span>' : `<span class="n"><i>DEPOIS · NÍVEL ${n + 1}</i>${p.niveis[n] || ''}</span>`}<div class="p">${max ? '★ NÍVEL MÁXIMO' : `CUSTO: ● ${preco}  ·  VOCÊ TEM: ● ${moedas()}`}</div><button type="button" ${pode ? '' : 'disabled'}>${max ? 'NO TALO' : anim ? 'TURBINANDO...' : '🔧 TURBINAR'}</button>`;
    f.querySelector('button').addEventListener('click', turbinar);
  }
  function escolher(i) { const L = meus(); if (!L.length || anim) return; sel = (i + L.length) % L.length; listar(); falar(sorte(['Essa aí? Boa escolha.', 'Hmm... dá pra turbinar, sim.', 'Deixa eu ver o lacre... tá bom.'])); }
  function turbinar() {
    const L = meus(); if (!L.length || anim) return; const p = L[sel], n = PW.estado().niveis[p.id] || 1;
    if (n >= 3) { falar(sorte(FALAS.max)); return; } if (moedas() < PRECO[n]) { falar(sorte(FALAS.pobre)); sfx('risada'); return; }
    window.CampanhaLoja?.ganhar?.(-PRECO[n]); anim = { t: 0, p, n: n + 1 }; falar('Segura que lá vem faísca!'); sfx('whoosh'); ficha();
  }
  const sfx = (n) => { try { window.__somCutscene = true; window.Roteiro?.sfx?.(n); } catch (e) {} };

  /* ---------- desenho do galpão ---------- */
  let fundo = null;
  function pintarFundo() { // parte parada, pintada uma vez
    fundo = document.createElement('canvas'); fundo.width = LW; fundo.height = LH; const g = fundo.getContext('2d'); const r = (x, y, w, h, col) => { g.fillStyle = col; g.fillRect(x, y, w, h); };
    // parede de zinco ondulado com ferrugem
    for (let x = 0; x < LW; x += 2) { const onda = Math.sin(x / 6 * Math.PI); r(x, 0, 2, 200, onda > .3 ? '#5a6068' : onda < -.3 ? '#3a4048' : '#4a5058'); }
    for (let i = 0; i < 260; i++) { const x = hash(i) * LW, y = hash(i + 9) * 200, w = 2 + hash(i + 3) * 10; g.globalAlpha = .25 + hash(i + 5) * .4; r(x, y, w, 2 + hash(i + 7) * 14, hash(i + 2) > .5 ? '#8a4a24' : '#6a3a1c'); } g.globalAlpha = 1;
    for (let y = 0; y < 200; y += 50) { r(0, y, LW, 2, '#2a2e34'); for (let x = 6; x < LW; x += 24) r(x, y + 3, 2, 2, '#8a8e94'); }
    // vigas do teto e telhado
    r(0, 0, LW, 18, '#2a2420'); for (let x = 0; x < LW; x += 60) { r(x, 0, 8, 26, '#3a2e24'); r(x, 0, 2, 26, '#5a4a38'); } r(0, 16, LW, 4, '#4a3a2a');
    // janela alta com luz de fora
    r(200, 30, 80, 34, '#2a2e34'); r(204, 34, 72, 26, '#9ab8c8'); r(204, 34, 72, 8, '#c8dce8'); r(238, 34, 4, 26, '#2a2e34'); r(204, 46, 72, 2, '#2a2e34'); g.globalAlpha = .15; g.fillStyle = '#e8f0f6'; g.beginPath(); g.moveTo(204, 60); g.lineTo(276, 60); g.lineTo(320, 200); g.lineTo(160, 200); g.fill(); g.globalAlpha = 1;
    // placa pintada à mão
    r(28, 28, 150, 30, '#1c1408'); r(30, 30, 146, 26, '#c8a24a'); r(30, 30, 146, 3, '#e8c66a'); for (let i = 0; i < 40; i++) r(30 + hash(i + 50) * 146, 30 + hash(i + 51) * 26, 2, 1, '#a8822a');
    window.CampanhaCamadas?.kit?.pxText?.(g, 'FERRO-VELHO DO GUGU', 103, 36, '#3a1a08'); window.CampanhaCamadas?.kit?.pxText?.(g, 'CONSERTO · SOLDA · TURBINA', 103, 46, '#5a2a10');
    // quadro de ferramentas (madeira perfurada)
    r(28, 70, 150, 80, '#6a4a2a'); r(30, 72, 146, 76, '#9a7a4a'); for (let y = 76; y < 146; y += 6) for (let x = 34; x < 174; x += 6) r(x, y, 1, 1, '#5a3a1c');
    const chave = (x, y, h) => { r(x, y, 3, h, '#9aa0a6'); r(x - 2, y - 3, 7, 5, '#9aa0a6'); r(x - 1, y - 2, 3, 2, '#5a6068'); r(x, y, 1, h, '#d8dce0'); };
    chave(40, 82, 30); chave(50, 80, 36); chave(60, 84, 26); r(74, 80, 4, 34, '#8a5a30'); r(70, 78, 12, 8, '#5a6068'); r(70, 78, 12, 2, '#9aa0a6'); // martelo
    r(92, 82, 30, 8, '#c8ccd0'); for (let k = 0; k < 30; k += 3) r(92 + k, 90, 2, 3, '#9aa0a6'); r(118, 80, 10, 14, '#8a3a2a'); // serrote
    r(136, 80, 6, 24, '#e8c24c'); r(134, 102, 10, 10, '#3a3a3a'); r(150, 84, 18, 4, '#c43c3a'); r(156, 84, 4, 22, '#9aa0a6'); // chave de fenda e alicate
    for (const [x, y] of [[40, 120], [64, 124], [90, 120], [116, 122], [142, 120]]) { r(x, y, 18, 22, '#1c1408'); r(x + 1, y + 1, 16, 20, ['#8a5a30', '#3c6aa8', '#a8642a', '#5a8a4a', '#c8a24a'][(x / 26 | 0) % 5]); r(x + 1, y + 1, 16, 3, '#ffffff33'); } // latas
    // prateleira com potes e garrafas
    r(312, 70, 150, 4, '#5a3a1c'); r(312, 110, 150, 4, '#5a3a1c'); r(316, 74, 3, 80, '#3a2410'); r(456, 74, 3, 80, '#3a2410');
    for (let i = 0; i < 9; i++) { const x = 322 + i * 15, h = 14 + (i % 3) * 5; r(x, 70 - h, 10, h, '#1c1408'); r(x + 1, 71 - h, 8, h - 1, ['#7a9a6a', '#c8a24a', '#6a8aa8', '#a85a4a'][i % 4]); r(x + 2, 72 - h, 2, h - 3, '#ffffff44'); }
    for (let i = 0; i < 7; i++) { const x = 324 + i * 19; r(x, 96, 14, 14, '#1c1408'); r(x + 1, 97, 12, 12, '#d8d0c0'); r(x + 1, 100, 12, 3, ['#c43c3a', '#3c6aa8', '#e8c24c'][i % 3]); }
    // chão de cimento manchado de graxa
    for (let y = 200; y < LH; y += 2) r(0, y, LW, 2, y % 8 < 4 ? '#4a4440' : '#423c38'); for (let i = 0; i < 18; i++) { g.globalAlpha = .4; g.fillStyle = '#1c1612'; g.beginPath(); g.ellipse(hash(i + 70) * LW, 210 + hash(i + 71) * 55, 10 + hash(i + 72) * 22, 3 + hash(i + 73) * 5, 0, 0, TAU); g.fill(); } g.globalAlpha = 1;
    r(0, 198, LW, 4, '#2a2420');
    // pneus empilhados e capô de carro
    for (let k = 0; k < 3; k++) { const y = 196 - k * 14; g.fillStyle = '#121212'; g.beginPath(); g.ellipse(36, y, 26, 8, 0, 0, TAU); g.fill(); g.fillStyle = '#2a2a2a'; g.beginPath(); g.ellipse(36, y - 2, 24, 6, 0, 0, TAU); g.fill(); g.fillStyle = '#121212'; g.beginPath(); g.ellipse(36, y - 2, 12, 3, 0, 0, TAU); g.fill(); }
    g.fillStyle = '#7a2a24'; g.beginPath(); g.moveTo(420, 200); g.lineTo(440, 150); g.lineTo(478, 140); g.lineTo(478, 200); g.fill(); g.fillStyle = '#9a3a2a'; g.beginPath(); g.moveTo(426, 196); g.lineTo(442, 156); g.lineTo(478, 148); g.lineTo(478, 158); g.lineTo(446, 166); g.lineTo(432, 198); g.fill(); for (let i = 0; i < 20; i++) r(430 + hash(i + 90) * 44, 150 + hash(i + 91) * 46, 3, 2, '#5a2a14');
  }
  function maquina(x, y) { // a MÁQUINA DE TURBINAR: caldeira, manômetro, canos e funil
    const k = anim ? clamp(anim.t / 2.2, 0, 1) : 0, treme = anim && anim.t > .6 && anim.t < 1.9 ? Math.round(Math.sin(t * 60)) : 0; x += treme;
    R(x - 2, y + 66, 84, 6, 'rgba(0,0,0,.35)');
    R(x + 6, y + 6, 68, 62, '#1c1408'); R(x + 8, y + 8, 64, 58, '#6a7078'); R(x + 8, y + 8, 64, 6, '#9aa0a8'); R(x + 8, y + 58, 64, 8, '#4a5058'); for (let i = 0; i < 4; i++) R(x + 12 + i * 16, y + 12, 3, 52, '#5a6068');
    for (let i = 0; i < 10; i++) R(x + 10 + i * 6, y + 16, 2, 2, '#c8ccd0');
    // manômetro
    const mx = x + 40, my = y + 32; c.fillStyle = '#1c1408'; c.beginPath(); c.arc(mx, my, 13, 0, TAU); c.fill(); c.fillStyle = '#f2ecd8'; c.beginPath(); c.arc(mx, my, 11, 0, TAU); c.fill(); c.fillStyle = '#c43c3a'; c.beginPath(); c.arc(mx, my, 11, -.2, .9); c.lineTo(mx, my); c.fill();
    const ang = -2.6 + (anim ? Math.min(1, anim.t / 1.6) * 3.4 + Math.sin(t * 30) * .05 : Math.sin(t * 1.5) * .08); c.strokeStyle = '#1c1408'; c.lineWidth = 2; c.beginPath(); c.moveTo(mx, my); c.lineTo(mx + Math.cos(ang) * 9, my + Math.sin(ang) * 9); c.stroke(); c.lineWidth = 1;
    // funil em cima (onde a garrafa entra) e bico de saída
    R(x + 30, y - 4, 20, 10, '#1c1408'); R(x + 32, y - 2, 16, 8, '#9aa0a8'); R(x + 26, y - 10, 28, 6, '#1c1408'); R(x + 28, y - 8, 24, 3, '#c8ccd0');
    R(x + 72, y + 40, 18, 8, '#1c1408'); R(x + 72, y + 42, 16, 4, '#9aa0a8');
    // canos até a parede
    R(x + 70, y + 14, 30, 5, '#1c1408'); R(x + 70, y + 15, 30, 3, '#8a5a30'); R(x + 96, y - 40, 5, 58, '#1c1408'); R(x + 97, y - 40, 3, 58, '#8a5a30');
    // luz de funcionamento
    R(x + 14, y + 46, 6, 6, anim ? (Math.floor(t * 8) % 2 ? '#ff3a2a' : '#7a1a1a') : '#3ae06a'); R(x + 24, y + 46, 6, 6, anim && anim.t > 1.6 ? '#3ae06a' : '#1a3a1a');
    // a garrafa: desce no funil, some, sai pelo bico brilhando
    if (anim) { const p = anim.p, cor = p.cor;
      if (anim.t < .6) { const yy = y - 40 + anim.t / .6 * 34; R(x + 34, yy, 12, 18, '#dceef2'); R(x + 35, yy + 6, 10, 11, cor); R(x + 37, yy - 5, 6, 6, '#dceef2'); }
      if (anim.t > 1.7) { const u = clamp((anim.t - 1.7) / .5, 0, 1), bx = x + 88 + u * 30, by = y + 30 - Math.sin(u * Math.PI) * 30; c.save(); c.globalCompositeOperation = 'lighter'; const g = c.createRadialGradient(bx + 6, by + 8, 2, bx + 6, by + 8, 30); g.addColorStop(0, cor + 'cc'); g.addColorStop(1, cor + '00'); c.fillStyle = g; c.fillRect(bx - 30, by - 30, 70, 70); c.restore(); R(bx, by, 12, 18, '#f6fbff'); R(bx + 1, by + 6, 10, 11, cor); R(bx + 2, by - 5, 6, 6, '#f6fbff'); }
      if (anim.t > .6 && anim.t < 1.9 && Math.random() < .5) vapor.push({ x: x + 40 + (Math.random() - .5) * 10, y: y - 10, t: 0, v: 20 + Math.random() * 20 }); }
  }
  function gugu(x, y) {
    let o = { frame: t, facing: 1, scale: 1.45, grounded: true };
    if (anim && anim.t > .5 && anim.t < 1.8) o = { ...o, attack: true, attackProgress: (anim.t * 3) % 1, facing: 1 };
    else if (falaT < 1.2 && falaTxt) o = { ...o, moving: false };
    try { window.Art.drawCharacter(c, 'c2_gugu', x, y + Math.round(Math.sin(t * 2) * .5), o); } catch (e) {}
  }
  function lampada() { // lâmpada pendurada balançando: o cone de luz se mexe e escurece o resto
    const a = Math.sin(t * 1.1) * .16 + (anim ? Math.sin(t * 9) * .04 : 0), px = 240, py = 18, len = 40, lx = px + Math.sin(a) * len, ly = py + Math.cos(a) * len;
    c.save(); c.globalCompositeOperation = 'multiply'; const g = c.createRadialGradient(lx, ly + 90, 20, lx, ly + 90, 300); g.addColorStop(0, 'rgba(255,240,210,1)'); g.addColorStop(.45, 'rgba(190,170,150,1)'); g.addColorStop(1, 'rgba(60,50,60,1)'); c.fillStyle = g; c.fillRect(0, 0, LW, LH); c.restore();
    c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .16; c.fillStyle = '#ffe0a0'; c.beginPath(); c.moveTo(lx - 6, ly + 6); c.lineTo(lx + 6, ly + 6); c.lineTo(lx + 110 + Math.sin(a) * 80, 210); c.lineTo(lx - 110 + Math.sin(a) * 80, 210); c.fill(); c.restore();
    c.strokeStyle = '#1c1408'; c.beginPath(); c.moveTo(px, py); c.lineTo(lx, ly); c.stroke();
    R(lx - 8, ly - 2, 16, 8, '#2a3a2a'); R(lx - 10, ly + 4, 20, 3, '#3a4a3a'); R(lx - 4, ly + 6, 8, 6, '#fff2b0'); c.save(); c.globalCompositeOperation = 'lighter'; const g2 = c.createRadialGradient(lx, ly + 9, 1, lx, ly + 9, 26); g2.addColorStop(0, 'rgba(255,230,160,.9)'); g2.addColorStop(1, 'rgba(255,230,160,0)'); c.fillStyle = g2; c.fillRect(lx - 30, ly - 20, 60, 60); c.restore();
  }
  function bancada() { // bancada de madeira com morsa, peças soltas e a garrafa da vez
    R(150, 186, 200, 8, '#1c1408'); R(152, 186, 196, 6, '#8a5a30'); R(152, 186, 196, 2, '#b07a44'); R(160, 194, 8, 40, '#3a2410'); R(332, 194, 8, 40, '#3a2410'); R(150, 222, 200, 4, '#3a2410');
    R(168, 174, 24, 12, '#1c1408'); R(170, 176, 20, 8, '#4a6a8a'); R(176, 168, 8, 8, '#4a6a8a'); R(166, 184, 28, 3, '#9aa0a6'); // morsa
    for (let i = 0; i < 6; i++) R(206 + i * 9 + hash(i) * 4, 182 - (i % 2) * 2, 5, 4, ['#9aa0a6', '#c8a24a', '#7a8086'][i % 3]); // parafusos
    const L = meus(), p = L[sel]; if (p && !anim) { const x = 288, y = 160 + Math.sin(t * 3) * 1.5; c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .4; c.fillStyle = p.cor; c.beginPath(); c.arc(x + 6, y + 14, 18, 0, TAU); c.fill(); c.restore(); R(x, y, 12, 22, '#1c1408'); R(x + 1, y + 1, 10, 20, '#dceef2'); R(x + 2, y + 8, 8, 12, p.cor); R(x + 3, y - 4, 6, 6, '#dceef2'); R(x + 2, y - 6, 8, 3, '#8a5a32'); R(x + 3, y + 3, 2, 10, '#ffffff88'); }
  }

  function loop(now) {
    if (!aberto) return; raf = requestAnimationFrame(loop); const dt = clamp((now - last) / 1000, 0, .05); last = now; t += dt; falaT += dt;
    if (!fundo) pintarFundo(); c.drawImage(fundo, 0, 0);
    maquina(372, 132); gugu(250, 190); bancada();
    // vapor, faíscas da solda e poeira na luz
    for (const v of vapor) { v.t += dt; v.y -= v.v * dt; v.x += Math.sin(v.t * 3) * .3; c.globalAlpha = Math.max(0, .6 - v.t * .5); c.fillStyle = '#e8eef2'; c.beginPath(); c.arc(v.x, v.y, 3 + v.t * 8, 0, TAU); c.fill(); } c.globalAlpha = 1; vapor = vapor.filter((v) => v.t < 1.2);
    if (anim && anim.t > .7 && anim.t < 1.8) { for (let i = 0; i < 4; i++) faiscas.push({ x: 300, y: 178, vx: (Math.random() - .3) * 140, vy: -Math.random() * 160, t: 0 }); if (Math.random() < .25) sfx('impacto'); }
    for (const f of faiscas) { f.t += dt; f.x += f.vx * dt; f.y += f.vy * dt; f.vy += 420 * dt; R(f.x, f.y, 2, 2, f.t < .2 ? '#ffffff' : f.t < .4 ? '#ffe23a' : '#f08a24'); } faiscas = faiscas.filter((f) => f.t < .7 && f.y < 200);
    if (anim && anim.t > .7 && anim.t < 1.8) { c.save(); c.globalCompositeOperation = 'lighter'; c.globalAlpha = .25 + Math.random() * .25; const g = c.createRadialGradient(300, 178, 2, 300, 178, 120); g.addColorStop(0, '#d8f0ff'); g.addColorStop(1, 'rgba(216,240,255,0)'); c.fillStyle = g; c.fillRect(180, 60, 240, 240); c.restore(); }
    lampada();
    for (const d of poeira) { d.y += d.v * dt * .4; d.x += Math.sin(t + d.f) * .1; if (d.y > LH) d.y = 0; c.globalAlpha = .35 + Math.sin(t * 2 + d.f) * .2; R(d.x, d.y, 1, 1, '#fff2d0'); } c.globalAlpha = 1;
    // balão de fala do Gugu
    if (falaTxt && falaT < 4) { const n = Math.min(falaTxt.length, Math.floor(falaT * 40)); c.font = '8px Space, Arial, sans-serif'; const ls = []; let l = ''; for (const w of falaTxt.slice(0, n).split(' ')) { if (c.measureText(l + ' ' + w).width > 150 && l) { ls.push(l); l = w; } else l = (l ? l + ' ' : '') + w; } ls.push(l);
      const bw = 164, bh = ls.length * 10 + 12, bx = 190, by = 26; R(bx - 1, by - 1, bw + 2, bh + 2, '#1c1408'); R(bx, by, bw, bh, '#fff6dc'); R(262, by + bh, 6, 8, '#1c1408'); R(263, by + bh, 4, 6, '#fff6dc'); c.fillStyle = '#3a2412'; c.textBaseline = 'top'; ls.forEach((s, i) => c.fillText(s, bx + 7, by + 6 + i * 10)); }
    // carimbo do nível novo
    if (carimbo) { carimbo.t += dt; const k = carimbo.t, sc = k < .2 ? 2.5 - k * 7.5 : 1; c.save(); c.globalAlpha = Math.min(1, (2.4 - k) / .4); c.translate(240, 120); c.rotate(-.18); c.scale(sc, sc); R(-80, -24, 160, 48, '#7a1a1a'); R(-76, -20, 152, 40, '#f6efd8'); window.CampanhaCamadas?.kit?.pxText?.(c, 'TURBINADO!', 0, -15, '#c43c3a', { s: 2 }); window.CampanhaCamadas?.kit?.pxText?.(c, carimbo.txt, 0, 5, '#3a1a08'); c.restore(); if (k > 2.4) carimbo = null; }
    // moedas
    R(8, 244, 70, 20, '#1c1408'); R(10, 246, 66, 16, '#3a2a1a'); c.fillStyle = '#ffd24a'; c.beginPath(); c.arc(22, 254, 5, 0, TAU); c.fill(); window.CampanhaCamadas?.kit?.pxText?.(c, String(moedas()), 50, 252, '#ffe9a8');
    if (anim) { anim.t += dt; if (anim.t >= 2.3) { PW.upgrade(anim.p.id); carimbo = { t: 0, txt: anim.p.curto + ' · NÍVEL ' + anim.n }; falar(sorte(FALAS.feito)); sfx('poder'); anim = null; listar(); } }
  }
  function abrir(o = {}) {
    if (!box) montar(); aberto = true; aoFechar = o.onClose || null; box.hidden = false; requestAnimationFrame(() => box.classList.add('on')); anim = null; carimbo = null; sel = 0; listar(); falar(meus().length ? sorte(FALAS.oi) : FALAS.vazio[0]);
    last = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(loop); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } }));
  }
  function fechar() { if (!aberto) return; aberto = false; box.classList.remove('on'); setTimeout(() => { if (!aberto) box.hidden = true; }, 300); cancelAnimationFrame(raf); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); aoFechar?.(); }
  window.CampanhaOficina = Object.freeze({ abrir, fechar, aberta: () => aberto, precos: () => PRECO.slice() });
})();
