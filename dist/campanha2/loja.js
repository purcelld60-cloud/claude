/* Campanha 2 · Loja de garrafadas do SEU LINDOMAR (raizeiro da Feira do Planalto).
   Os inimigos derrotados deixam MOEDAS. Com elas o Da Roça compra garrafadas: cada uma ensina um poder novo.
   Depois é só montar a build no Mural dos Poderes, no quarto.
   A tela da loja é uma cena pixelada própria: o vendedor grande atrás do balcão (pisca, mexe o bigode, aponta, ri),
   prateleiras de ervas, lamparina balançando, poeira no ar e as oito garrafas no balcão, cada uma com seu formato e cor.
   Tocar numa garrafa faz ela subir e brilhar; o pergaminho mostra nome, efeito e preço, com COMPRAR.
   Inspirado no tipo de loja dos jogos de plataforma antigos, com personagem e arte próprios. */
(() => {
  'use strict';
  if (window.CampanhaLoja || !window.CampanhaPoderes) return;
  const PW = window.CampanhaPoderes, KEY = 'daroca-c2-loja', LW = 480, LH = 270;
  const PRECO = { fofoca: 30, buzina: 40, biscoito: 45, flash: 60, cafezao: 70, supersoco: 85, clone: 110, aura: 150 };
  const GARRAFA = { fofoca: 'redonda', buzina: 'alta', biscoito: 'pote', flash: 'frasco', cafezao: 'bule', supersoco: 'quadrada', clone: 'tubo', aura: 'coracao' };
  const FALA = { oi: ['Chegue, freguês! Garrafada boa cura até falta de coragem.', 'Ô, o rapaz do chapéu! Veio montar a sua sorte?', 'Tudo raiz da serra, colhida na lua certa. Quase tudo.'],
    olhar: { fofoca: 'Essa aí é de língua solta. Um gole e todo mundo briga com todo mundo.', buzina: 'Raiz de buzina de mototáxi. Não me pergunte como se colhe.', biscoito: 'Polvilho benzido. Crocante por fora, perigoso por dentro.', flash: 'Feita com a luz de mil stories. Não olhe direto.', cafezao: 'Café do planalto com mais três cafés dentro. Coração fraco, não.', supersoco: 'Essa é forte. Segura, carrega e solta. Igual saudade.', clone: 'Garrafada digital. Veio num pendrive, juro.', aura: 'A mais rara. Não é feita de raiz... é feita de amizade.' },
    comprou: ['Boa escolha, meu rei! Volte sempre!', 'Vendido! Agora vai lá no mural do quarto e equipa, viu?', 'Hé hé! Essa vai fazer diferença.'], pobre: ['Tá faltando moeda, freguês. Vai lá, que os encrenqueiros da cidade pagam bem.', 'Fiado só amanhã. E amanhã nunca chega.'], tem: 'Essa você já tem, meu filho. Não precisa de duas.' };

  let st = { moedas: 0 };
  try { const s = JSON.parse(localStorage.getItem(KEY) || 'null'); if (s && Number.isFinite(s.moedas)) st = s; } catch (e) {}
  const salvar = () => { try { localStorage.setItem(KEY, JSON.stringify(st)); } catch (e) {} };
  const ouvintes = new Set();
  function ganhar(n) { st.moedas = Math.max(0, Math.round(st.moedas + n)); salvar(); for (const f of ouvintes) try { f(st.moedas); } catch (e) {} }

  /* ---------- tela ---------- */
  let box = null, cv = null, c = null, aberto = false, raf = 0, t = 0, last = 0, sel = 0, falaTxt = '', falaT = 0, humor = 'oi', humorT = 0, moedaFx = [], aoFechar = null, abriuT = 0;
  const lista = () => PW.lista();
  function css() {
    if (document.getElementById('c2LojaCss')) return; const s = document.createElement('style'); s.id = 'c2LojaCss';
    s.textContent = `.c2-loja{position:fixed;inset:0;z-index:2147483150;background:#120c08;display:grid;place-items:center;font-family:Pixel,monospace;color:#2a1a10;opacity:0;transition:opacity .3s}.c2-loja.on{opacity:1}.c2-loja[hidden]{display:none}
.c2-loja .tela{position:relative;width:min(100vw,177.7vh);aspect-ratio:16/9;max-height:100vh}.c2-loja canvas{width:100%;height:100%;image-rendering:pixelated;display:block}
.c2-loja .perg{position:absolute;right:2.5%;top:6%;width:30%;background:#f2e2b8;border:3px solid #5a3a20;box-shadow:4px 4px 0 #2a1a10;padding:10px 12px;font-size:clamp(8px,1.15vw,12px);line-height:1.5;transform:rotate(1deg)}.c2-loja .perg b{display:block;font-size:1.15em;color:#7a2a1a;margin-bottom:4px}.c2-loja .perg .p{margin-top:6px;font-size:1.1em}
.c2-loja button{font:inherit;font-size:clamp(9px,1.2vw,12px);padding:8px 12px;background:#e8a83a;color:#1c1408;border:3px solid #5a3a20;box-shadow:0 4px 0 #3a2410;cursor:pointer}.c2-loja button:active{transform:translateY(3px);box-shadow:0 1px 0 #3a2410}.c2-loja button[disabled]{opacity:.5;cursor:default}.c2-loja .bts{display:flex;gap:6px;margin-top:8px;flex-wrap:wrap}
.c2-loja .sair{position:absolute;left:2%;top:3%;background:#4a3420;color:#f6ead0;border-color:#e8c66a}`;
    document.head.appendChild(s);
  }
  function montar() {
    css(); box = document.createElement('div'); box.className = 'c2-loja'; box.hidden = true; box.setAttribute('role', 'dialog'); box.setAttribute('aria-label', 'Garrafadas do Seu Lindomar');
    box.innerHTML = '<div class="tela"><canvas width="480" height="270"></canvas><div class="perg"></div><button type="button" class="sair">✕ SAIR DA LOJA</button></div>'; document.body.appendChild(box);
    cv = box.querySelector('canvas'); c = cv.getContext('2d'); c.imageSmoothingEnabled = false;
    box.querySelector('.sair').addEventListener('click', fechar);
    cv.addEventListener('pointerdown', (e) => { const r = cv.getBoundingClientRect(), x = (e.clientX - r.left) / r.width * LW, y = (e.clientY - r.top) / r.height * LH; const i = garrafaEm(x, y); if (i >= 0) { if (i === sel) comprar(); else escolher(i); } });
    addEventListener('keydown', (e) => { if (!aberto) return; const k = e.key; if (k === 'Escape') fechar(); else if (k === 'ArrowRight') escolher((sel + 1) % 8); else if (k === 'ArrowLeft') escolher((sel + 7) % 8); else if (k === 'Enter' || k === ' ') comprar(); else return; e.preventDefault(); e.stopImmediatePropagation(); }, true);
  }
  const pos = (i) => ({ x: 196 + i * 34, y: 214 });
  function garrafaEm(x, y) { for (let i = 0; i < 8; i++) { const p = pos(i); if (Math.abs(x - p.x) < 15 && y > p.y - 50 && y < p.y + 22) return i; } return -1; }
  function falar(s, h = 'fala') { falaTxt = s; falaT = 0; humor = h; humorT = 0; }
  const sorte = (a) => a[Math.floor(Math.random() * a.length)];
  function escolher(i) { sel = i; const p = lista()[i]; falar(FALA.olhar[p.id], 'aponta'); perg(); }
  function perg() {
    const p = lista()[sel], tem = PW.estado().desbloqueados.includes(p.id), preco = PRECO[p.id], pode = st.moedas >= preco && !tem;
    box.querySelector('.perg').innerHTML = `<b>GARRAFADA DE ${p.nome}</b>${p.desc}<div class="p">${tem ? '✔ VOCÊ JÁ TEM' : `PREÇO: ● ${preco} moedas`}</div><div class="bts"><button type="button" class="comprar" ${pode ? '' : 'disabled'}>${tem ? 'JÁ É SUA' : 'COMPRAR'}</button><button type="button" class="mural">MONTAR BUILD</button></div>`;
    box.querySelector('.comprar').addEventListener('click', comprar); box.querySelector('.mural').addEventListener('click', () => { const tst = !!aberto.teste; fechar(); PW.abrirMural({ teste: tst }); });
  }
  function comprar() {
    const p = lista()[sel], preco = PRECO[p.id];
    if (PW.estado().desbloqueados.includes(p.id)) { falar(FALA.tem, 'nega'); return; }
    if (st.moedas < preco) { falar(sorte(FALA.pobre), 'nega'); return; }
    ganhar(-preco); PW.desbloquear(p.id); falar(sorte(FALA.comprou), 'ri'); const q = pos(sel); for (let k = 0; k < 14; k++) moedaFx.push({ x: 440, y: 22, tx: q.x, ty: q.y - 20, t: -k * .04 }); perg();
  }
  function abrir(o = {}) { if (!box) montar(); aberto = { teste: !!o.teste }; aoFechar = o.onClose || null; box.hidden = false; requestAnimationFrame(() => box.classList.add('on')); sel = 0; falar(sorte(FALA.oi), 'oi'); perg(); abriuT = 0; last = performance.now(); cancelAnimationFrame(raf); raf = requestAnimationFrame(loop); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: true } })); return true; }
  function fechar() { if (!aberto) return; aberto = false; box.classList.remove('on'); setTimeout(() => { if (!aberto) box.hidden = true; }, 320); cancelAnimationFrame(raf); window.dispatchEvent(new CustomEvent('controls-capture', { detail: { active: false } })); const f = aoFechar; aoFechar = null; f?.(); }

  /* ---------- desenho da loja ---------- */
  const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), Math.round(w), Math.round(h)); };
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  function fundo() {
    // parede de tábuas, janela com o dia lá fora, prateleiras com potes de raiz e ramos de erva pendurados
    for (let x = 0; x < LW; x += 16) { R(x, 0, 16, 190, x % 32 ? '#6a4428' : '#5e3c24'); R(x, 0, 1, 190, '#4a2e18'); for (let y = 10; y < 190; y += 37) R(x + 3 + (x % 5), y, 2, 2, '#3a2414'); }
    R(30, 22, 80, 56, '#3a2414'); R(34, 26, 72, 48, '#9ac8e0'); R(34, 56, 72, 18, '#7aa852'); for (let k = 0; k < 6; k++) R(40 + k * 11, 50 - (k % 3) * 3, 8, 8, '#e8dcc8'); R(69, 26, 3, 48, '#3a2414'); R(34, 48, 72, 3, '#3a2414');
    for (const sy of [40, 92]) { R(130, sy, 330, 5, '#8a5a32'); R(130, sy + 5, 330, 2, '#3a2414'); for (let k = 0; k < 15; k++) { const px = 136 + k * 21, h = 14 + (k % 3) * 4, col = ['#c8a46a', '#7a9a52', '#a8743a', '#c43c3a', '#d8c8a0', '#5a7a8a'][k % 6]; R(px, sy - h, 14, h, '#e8eef0'); R(px + 1, sy - h + 4, 12, h - 5, col); R(px, sy - h - 3, 14, 3, '#8a5a32'); R(px + 2, sy - h + 2, 3, h - 4, 'rgba(255,255,255,.35)'); } }
    for (let k = 0; k < 9; k++) { const hx = 20 + k * 52 + (k > 1 ? 70 : 0), sw = Math.sin(t * 1.3 + k) * 1.5; if (hx > LW) break; R(hx, 0, 1, 10, '#3a2414'); for (let j = 0; j < 9; j++) R(hx - 5 + j + sw * (j / 9), 10 + Math.abs(j - 4) * 2, 2, 12 - Math.abs(j - 4), ['#6a8a3a', '#8aa04a', '#a89a4a'][(j + k) % 3]); }
    // lamparina balançando e o brilho dela
    const ang = Math.sin(t * 1.6) * .18, lx = 300 + Math.sin(ang) * 30, ly = Math.cos(ang) * 30 + 10; c.strokeStyle = '#2a1a10'; c.beginPath(); c.moveTo(300, 0); c.lineTo(lx, ly); c.stroke(); R(lx - 6, ly, 12, 14, '#3a3a3a'); R(lx - 4, ly + 2, 8, 9, '#ffd98a'); R(lx - 2, ly - 3, 4, 3, '#3a3a3a');
    const g = c.createRadialGradient(lx, ly + 6, 4, lx, ly + 6, 160); g.addColorStop(0, 'rgba(255,214,140,.32)'); g.addColorStop(1, 'rgba(255,214,140,0)'); c.fillStyle = g; c.fillRect(0, 0, LW, LH);
    for (let i = 0; i < 26; i++) { const x = (hash(i) * LW + t * (4 + i % 5)) % LW, y = (hash(i * 3) * 180 + Math.sin(t + i) * 8); R(x, y, 1, 1, 'rgba(255,240,200,.5)'); } // poeira no ar
  }
  function vendedor() { // Seu Lindomar: chapéu de palha, bigode branco, óculos, avental; respira, pisca, aponta, ri, nega
    const bx = 70, by = 190, resp = Math.round(Math.sin(t * 2) * 1.2), pisca = (t % 3.4) < .12, h = humor;
    const lean = h === 'aponta' ? Math.min(1, humorT * 4) * 6 : 0, ri = h === 'ri' && humorT < 1.6, nega = h === 'nega' && humorT < 1.2, shake = nega ? Math.round(Math.sin(humorT * 30) * 3) : 0;
    const y0 = by - 120 + resp;
    R(bx - 2, y0 + 50, 92, 90, '#2a1a10'); R(bx, y0 + 52, 88, 88, '#8a5a3a'); R(bx + 18, y0 + 56, 52, 84, '#efe4cc'); R(bx + 18, y0 + 56, 52, 4, '#d8cba8'); R(bx + 40, y0 + 64, 8, 10, '#c43c3a'); // corpo e avental
    const braco = h === 'aponta' ? -18 - lean : ri ? -10 + Math.sin(humorT * 12) * 4 : 0; R(bx + 80, y0 + 60 + braco, 20, 12, '#8a5a3a'); R(bx + 96, y0 + 58 + braco, 12, 12, '#d8a07a'); if (h === 'aponta') R(bx + 106, y0 + 61 + braco, 10, 4, '#d8a07a');
    R(bx - 10, y0 + 70, 16, 30, '#8a5a3a'); R(bx - 10, y0 + 98, 14, 12, '#d8a07a');
    const hx = bx + 22 + lean + shake, hy = y0 + 4; R(hx, hy + 8, 44, 44, '#d8a07a'); R(hx + 34, hy + 8, 10, 44, '#c48a64'); R(hx, hy + 44, 44, 8, '#c48a64');
    R(hx - 2, hy + 24, 4, 10, '#c48a64'); R(hx + 42, hy + 24, 4, 10, '#c48a64'); // orelhas
    R(hx + 6, hy + 20, 14, 10, '#2a2a2a'); R(hx + 24, hy + 20, 14, 10, '#2a2a2a'); R(hx + 8, hy + 22, 10, 6, '#c8e0e8'); R(hx + 26, hy + 22, 10, 6, '#c8e0e8'); R(hx + 20, hy + 23, 4, 2, '#2a2a2a'); // óculos
    if (!pisca) { R(hx + 11, hy + 23, 4, 4, '#2a2a2a'); R(hx + 29, hy + 23, 4, 4, '#2a2a2a'); } else { R(hx + 10, hy + 25, 6, 1, '#2a2a2a'); R(hx + 28, hy + 25, 6, 1, '#2a2a2a'); }
    R(hx + 18, hy + 30, 8, 8, '#c48a64'); const bg = Math.round(Math.sin(t * 5) * (ri ? 2 : .6)); R(hx + 6, hy + 37 + bg, 32, 7, '#f2efe6'); R(hx + 4, hy + 40 + bg, 6, 6, '#f2efe6'); R(hx + 34, hy + 40 + bg, 6, 6, '#f2efe6'); // bigodão
    if (ri) { R(hx + 14, hy + 45, 16, 5, '#5a2a1a'); R(hx + 16, hy + 45, 12, 2, '#ffffff'); } else R(hx + 16, hy + 46, 12, 2, '#7a3a2a');
    R(hx - 14, hy + 2, 72, 8, '#d7b665'); R(hx - 14, hy + 2, 72, 2, '#f2d898'); R(hx + 2, hy - 14, 40, 18, '#d7b665'); R(hx + 2, hy - 2, 40, 4, '#c43c3a'); for (let k = 0; k < 40; k += 4) R(hx + 2 + k, hy - 14, 2, 16, '#c8a050'); // chapéu de palha
    if (ri) { c.font = '10px Pixel, monospace'; c.fillStyle = '#ffd98a'; c.fillText('HÉ HÉ!', hx + 50, hy - 4 - humorT * 6); }
  }
  function balcao() { R(0, 190, LW, 80, '#5a3a20'); R(0, 190, LW, 6, '#8a5a32'); R(0, 196, LW, 2, '#3a2414'); for (let x = 0; x < LW; x += 40) R(x, 198, 2, 72, '#4a2e18'); R(0, 236, LW, 3, '#3a2414'); R(10, 244, 120, 18, '#3a2414'); R(12, 246, 116, 14, '#c8a46a'); c.font = '8px Pixel, monospace'; c.fillStyle = '#3a2414'; c.fillText('GARRAFADAS DO SEU LINDOMAR', 16, 256); }
  function garrafa(i) {
    const p = lista()[i], q = pos(i), tem = PW.estado().desbloqueados.includes(p.id), on = i === sel, sobe = on ? 10 + Math.sin(t * 3) * 2 : Math.sin(t * 2 + i) * .6, x = q.x, y = q.y - sobe, cor = p.cor, forma = GARRAFA[p.id];
    if (on) { const g = c.createRadialGradient(x, y - 18, 2, x, y - 18, 34); g.addColorStop(0, `${cor}aa`); g.addColorStop(1, `${cor}00`); c.fillStyle = g; c.fillRect(x - 40, y - 60, 80, 80); }
    R(x - 11, q.y + 2, 22, 3, 'rgba(0,0,0,.35)');
    const vid = '#dceef2', liq = (yy, h, w) => { R(x - w / 2, yy, w, h, cor); R(x - w / 2, yy, w, 2, '#ffffff66'); R(x - w / 2 + 1, yy + Math.round(Math.sin(t * 4 + i) * 1) + 2, w - 2, 1, '#ffffff44'); };
    if (forma === 'redonda') { c.fillStyle = vid; c.beginPath(); c.arc(x, y - 10, 11, 0, Math.PI * 2); c.fill(); c.fillStyle = cor; c.beginPath(); c.arc(x, y - 8, 9, 0, Math.PI); c.fill(); R(x - 3, y - 28, 6, 9, vid); R(x - 4, y - 31, 8, 4, '#8a5a32'); }
    if (forma === 'alta') { R(x - 7, y - 34, 14, 34, vid); liq(y - 22, 22, 12); R(x - 3, y - 44, 6, 10, vid); R(x - 4, y - 47, 8, 4, '#8a5a32'); }
    if (forma === 'pote') { R(x - 11, y - 22, 22, 22, vid); liq(y - 16, 16, 20); R(x - 12, y - 26, 24, 5, '#8a5a32'); }
    if (forma === 'frasco') { R(x - 9, y - 20, 18, 20, vid); liq(y - 14, 14, 16); R(x - 4, y - 30, 8, 10, vid); R(x - 5, y - 33, 10, 4, '#c8ccd0'); R(x + 5, y - 18, 2, 2, '#ffffff'); }
    if (forma === 'bule') { R(x - 10, y - 18, 20, 18, '#f6f2ea'); R(x - 8, y - 16, 16, 4, cor); R(x + 10, y - 14, 6, 3, '#f6f2ea'); R(x - 4, y - 22, 8, 4, '#f6f2ea'); for (let k = 0; k < 3; k++) R(x - 4 + k * 4, y - 30 - Math.sin(t * 5 + k) * 2, 2, 5, 'rgba(255,255,255,.6)'); }
    if (forma === 'quadrada') { R(x - 10, y - 26, 20, 26, vid); liq(y - 20, 20, 18); R(x - 3, y - 32, 6, 6, vid); R(x - 4, y - 35, 8, 4, '#8a5a32'); R(x - 6, y - 16, 12, 8, '#f2e8c8'); R(x - 3, y - 14, 6, 4, '#c43c3a'); }
    if (forma === 'tubo') { R(x - 5, y - 36, 10, 36, vid); liq(y - 28, 28, 8); for (let k = 0; k < 4; k++) R(x - 4, y - 26 + k * 6, 8, 1, '#0e1016'); R(x - 6, y - 39, 12, 4, '#2a2c34'); }
    if (forma === 'coracao') { c.fillStyle = vid; c.beginPath(); c.arc(x - 5, y - 16, 7, 0, Math.PI * 2); c.arc(x + 5, y - 16, 7, 0, Math.PI * 2); c.fill(); c.beginPath(); c.moveTo(x - 12, y - 14); c.lineTo(x + 12, y - 14); c.lineTo(x, y); c.fill(); c.fillStyle = cor; c.beginPath(); c.arc(x - 5, y - 14, 5, 0, Math.PI * 2); c.arc(x + 5, y - 14, 5, 0, Math.PI * 2); c.fill(); R(x - 2, y - 28, 4, 6, vid); R(x - 3, y - 31, 6, 4, '#e8c24c'); }
    c.font = '7px Pixel, monospace'; c.textAlign = 'center';
    if (tem) { c.save(); c.translate(x, q.y + 12); c.rotate(-.2); R(-14, -5, 28, 10, '#c43c3a'); c.fillStyle = '#fff6dc'; c.fillText('É SUA', 0, 3); c.restore(); }
    else { R(x - 13, q.y + 8, 26, 10, '#f2e2b8'); R(x - 13, q.y + 8, 26, 1, '#ffffff'); c.fillStyle = st.moedas >= PRECO[p.id] ? '#3a2414' : '#a83a2a'; c.fillText('●' + PRECO[p.id], x, q.y + 16); }
    c.textAlign = 'left';
  }
  function hud() {
    R(LW - 92, 8, 84, 20, '#2a1a10'); R(LW - 90, 10, 80, 16, '#4a3420'); c.fillStyle = '#ffd24a'; c.beginPath(); c.arc(LW - 78, 18, 6, 0, Math.PI * 2); c.fill(); R(LW - 79, 14, 2, 8, '#c8962a'); c.font = '10px Pixel, monospace'; c.fillStyle = '#ffe9a8'; c.fillText(String(st.moedas), LW - 66, 22);
    if (falaTxt) { const n = Math.min(falaTxt.length, Math.floor(falaT * 40)), txt = falaTxt.slice(0, n), lines = [], words = txt.split(' '); let cur = ''; for (const w of words) { if ((cur + ' ' + w).length > 34) { lines.push(cur); cur = w; } else cur = (cur + ' ' + w).trim(); } lines.push(cur);
      const bw = 190, bh = 10 + lines.length * 11, bx = 128, by = 26; R(bx, by, bw, bh, '#2a1a10'); R(bx + 2, by + 2, bw - 4, bh - 4, '#fbf2dc'); R(bx + 2, by + bh - 2, 10, 8, '#fbf2dc'); R(bx, by + bh, 4, 8, '#2a1a10'); c.font = '8px Pixel, monospace'; c.fillStyle = '#3a2414'; lines.forEach((l, k) => c.fillText(l, bx + 8, by + 14 + k * 11)); }
    for (const m of moedaFx) { if (m.t < 0) continue; const u = Math.min(1, m.t / .5), x = m.x + (m.tx - m.x) * u, y = m.y + (m.ty - m.y) * u - Math.sin(u * Math.PI) * 30; c.fillStyle = '#ffd24a'; c.beginPath(); c.arc(x, y, 3, 0, Math.PI * 2); c.fill(); }
  }
  function loop(now) {
    if (!aberto) return; raf = requestAnimationFrame(loop); const dt = Math.max(0, Math.min(.05, (now - last) / 1000)); last = now; t += dt; falaT += dt; humorT += dt; abriuT += dt;
    moedaFx = moedaFx.filter((m) => { m.t += dt; return m.t < .55; });
    c.save(); const zoom = 1 + Math.max(0, .3 - abriuT) * .6; c.translate(LW / 2, LH / 2); c.scale(zoom, zoom); c.translate(-LW / 2, -LH / 2);
    fundo(); vendedor(); balcao(); for (let i = 0; i < 8; i++) garrafa(i); hud(); c.restore();
  }

  /* ---------- no mundo: a carroça de garrafadas na feira ---------- */
  window.CampanhaPersonagens?.registrar?.('c2_lindomar', { name: 'Seu Lindomar Raizeiro', skin: '#d8a07a', shade: '#c48a64', build: 'belly', h: .95, top: '#8a5a3a', topKind: 'apron', apron: '#efe4cc', pants: '#4a4a3a', hat: { kind: 'straw', color: '#d7b665' }, hair: { style: 'short', color: '#e0dcd4' }, mustache: '#f2efe6', glasses: '#2a2a2a', pose: 'offer' }, 'vendedor (loja de poções)');
  const BANCA = { cena: 17, x: 1460 };
  function desenharBanca(c2, o) {
    if (Number(o.scene) !== BANCA.cena) return; const x = BANCA.x, y = 440, t2 = Number(o.time) || 0, R2 = (a, b, w, h, col) => { c2.fillStyle = col; c2.fillRect(Math.round(a), Math.round(b), w, h); };
    if (Math.abs(x - (Number(o.camera) || 0) - 480) > 640) return;
    R2(x - 70, y - 50, 120, 30, '#8a5a32'); R2(x - 70, y - 50, 120, 4, '#c8985a'); for (const wx of [x - 50, x + 30]) { R2(wx - 12, y - 24, 24, 24, '#3a2414'); R2(wx - 4, y - 16, 8, 8, '#8a5a32'); } R2(x + 50, y - 40, 40, 4, '#6a4428');
    const cores = ['#e48fb0', '#f08a24', '#e9d6a8', '#c8d8ff', '#a8743a', '#e8433a', '#5ae0d0', '#ffd24a']; cores.forEach((col, k) => { const bx = x - 64 + k * 14, h = 16 + (k % 3) * 6; R2(bx, y - 50 - h, 10, h, '#dceef2'); R2(bx + 1, y - 50 - h + 6, 8, h - 7, col); R2(bx + 2, y - 54 - h, 6, 4, '#8a5a32'); });
    R2(x - 76, y - 120, 4, 70, '#6a4428'); R2(x + 50, y - 120, 4, 70, '#6a4428'); R2(x - 84, y - 128, 146, 12, '#c43c3a'); for (let k = 0; k < 146; k += 12) R2(x - 84 + k, y - 128, 6, 12, '#f6ead0');
    R2(x - 70, y - 146, 116, 16, '#3a2414'); R2(x - 68, y - 144, 112, 12, '#f2e2b8'); c2.font = '9px Pixel, monospace'; c2.textAlign = 'center'; c2.fillStyle = '#7a2a1a'; c2.fillText('GARRAFADAS', x - 12, y - 134); c2.textAlign = 'left';
    window.Art?.drawCharacter?.(c2, 'c2_lindomar', x + 74, y, { frame: t2, facing: -1, moving: false, grounded: true });
    const hx = Number(o.player?.x) || -9999; if (Math.abs(hx - x) < 110) { const dy = Math.round(Math.sin(t2 * 5) * 3); R2(x + 64, y - 132 + dy, 22, 22, '#2a1a14'); R2(x + 66, y - 130 + dy, 18, 18, '#ffd24a'); c2.fillStyle = '#2a1a14'; c2.font = '14px Pixel, monospace'; c2.textAlign = 'center'; c2.fillText('●', x + 75, y - 115 + dy); c2.textAlign = 'left'; }
  }
  window.CampanhaLoja = Object.freeze({ abrir, fechar, aberta: () => !!aberto, moedas: () => st.moedas, ganhar, ouvir: (f) => { ouvintes.add(f); return () => ouvintes.delete(f); }, precos: () => ({ ...PRECO }),
    perto: (cena, x) => (cena === BANCA.cena && Math.abs(x - BANCA.x) < 110 ? { id: 'loja', x: BANCA.x + 20, rotulo: 'COMPRAR GARRAFADAS DO SEU LINDOMAR', botao: 'LOJA' } : null), desenhar: desenharBanca, banca: () => ({ ...BANCA }) });
})();
