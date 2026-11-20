/* Campanha 2 · Passo 3: TREINO DE PODERES no visualizador (?cenarios2).
   Bonecos de treino (espantalhos de palha) aparecem perto do Da Roça e a barra de controles da Campanha 2 surge
   na tela: são os próprios botões da campanha 1 (ícones e estilo copiados do jogo), só com FALAR, VOAR,
   BOLINHA DE PAPEL, PEIDO e DASH, mais PODER 1 e PODER 2. Reeis, Bivolt, Batata e o carro não aparecem.
   Teclas: J papel · K peido · L dash · ESPAÇO pular (segure no ar para voar) · E falar · U poder 1 · I poder 2. */
(() => {
  'use strict';
  if (window.CampanhaTreino || !window.CampanhaPoderes) return;
  const PW = window.CampanhaPoderes, FLOOR = 440;
  let on = false, bonecos = [], tiros = [], nuvens = [], textos = [], gas = 100, voando = false, dashT = 0, dashCd = 0, shake = 0, cam = 0, heroRef = null, barra = null;

  /* ---------- os botões da campanha 1, com o mesmo estilo ---------- */
  function copiarEstilo() {
    if (document.getElementById('c2TreinoCss')) return; const st = document.createElement('style'); st.id = 'c2TreinoCss'; let txt = '';
    for (const sh of document.styleSheets) { let rules; try { rules = sh.cssRules; } catch (e) { continue; } for (const r of rules || []) if (r.selectorText && /crafted-controls/.test(r.selectorText) && /touch-btn|control-icon|kbd/.test(r.selectorText)) txt += r.cssText.replace(/#gameShell\s*/g, '').replace(/\.crafted-controls/g, '.c2-treino-ctl') + '\n'; }
    txt += `.c2-treino-ctl{position:absolute;right:2%;bottom:3%;display:grid;grid-template-columns:repeat(4,auto);gap:8px;z-index:3}.c2-treino-ctl .touch-btn{width:54px;height:54px;touch-action:none;user-select:none;-webkit-user-select:none}
.c2-treino-ctl .touch-btn kbd{position:absolute;top:2px;left:4px;font:6px Pixel,monospace;opacity:.6}.c2-treino-ctl .touch-btn.pressed{transform:translateY(3px);filter:brightness(1.1)}.c2-treino-ctl .c2-poder-btn small{position:static;transform:none;color:inherit}
.c2-treino-ctl .c2-cd{position:absolute;inset:0;background:rgba(10,8,6,.55);clip-path:inset(var(--cd,100%) 0 0 0);pointer-events:none}.c2-treino-ctl .vazio{opacity:.5}
.c2-treino-info{position:absolute;left:2%;top:3%;font:9px Pixel,monospace;color:#f3d89e;background:rgba(20,14,8,.7);padding:6px 8px;border:2px solid #e8c66a;line-height:1.6;z-index:3;max-width:46%}
.c2-treino-gas{position:absolute;left:2%;bottom:4%;width:120px;height:10px;background:#1c1408;border:2px solid #e8c66a;z-index:3}.c2-treino-gas i{display:block;height:100%;background:linear-gradient(#9ae06a,#4a9a3a)}`;
    st.textContent = txt; document.head.appendChild(st);
  }
  const ORDEM = [['interact', 'FALAR', 'E'], ['jump', 'VOAR', '␣'], ['paper', 'PAPEL', 'J'], ['fart', 'PEIDO', 'K'], ['dash', 'DASH', 'L'], ['poder1', '', 'U'], ['poder2', '', 'I']];
  function montarBarra(tela, acionar) {
    copiarEstilo(); barra = document.createElement('div'); barra.className = 'c2-treino-wrap'; barra.innerHTML = '<div class="c2-treino-info"></div><div class="c2-treino-gas"><i></i></div><div class="c2-treino-ctl"></div>'; tela.appendChild(barra);
    const ctl = barra.querySelector('.c2-treino-ctl');
    for (const [id, nome, k] of ORDEM) {
      const b = document.createElement('button'); b.type = 'button'; b.dataset.acao = id;
      if (id.startsWith('poder')) b.className = 'touch-btn c2-poder-btn';
      else { const orig = document.querySelector(`#gameShell .touch-controls [data-action="${id}"]`); b.className = orig ? orig.className.replace(/\b(pressed|campaign-layout-target)\b/g, '') : 'touch-btn'; b.innerHTML = (orig?.querySelector('svg')?.outerHTML || '') + `<small>${nome}</small>`; }
      b.insertAdjacentHTML('afterbegin', `<kbd>${k}</kbd>`);
      const down = (e) => { e.preventDefault(); b.classList.add('pressed'); acionar(id, true); }, up = () => { if (!b.classList.contains('pressed')) return; b.classList.remove('pressed'); acionar(id, false); };
      b.addEventListener('pointerdown', down); b.addEventListener('pointerup', up); b.addEventListener('pointerleave', up); b.addEventListener('pointercancel', up); ctl.appendChild(b);
    }
    atualizarSlots(); PW.ouvir(atualizarSlots);
  }
  function atualizarSlots() { if (!barra) return; [0, 1].forEach((i) => { const b = barra.querySelector(`[data-acao="poder${i + 1}"]`), id = PW.estado().equipados[i], p = PW.lista().find((q) => q.id === id); if (!b) return; b.classList.toggle('vazio', !p);
    b.innerHTML = `<kbd>${i ? 'I' : 'U'}</kbd>${p ? PW.iconeSVG(id) : '<svg class="control-icon" viewBox="0 0 24 24" width="24" height="24"><path fill="currentColor" d="M4 4h16v2H4zM4 18h16v2H4zM4 6h2v12H4zM18 6h2v12h-2z"/></svg>'}<small>${p ? p.curto : 'VAZIO'}</small><span class="c2-cd"></span>`; }); }

  /* ---------- bonecos de treino ---------- */
  const novoBoneco = (x) => ({ x, y: FLOOR, vx: 0, vy: 0, hp: 60, max: 60, stun: 0, conf: 0, hit: 0, morto: 0, golpe: 0, base: x });
  let modoJogo = false; // no jogo da Campanha 2: sem bonecos e sem a caixa de ajuda do treino
  function ligar(v, P, o = {}) { on = v ?? !on; modoJogo = !!o.jogo; if (barra) { barra.hidden = !on; const inf = barra.querySelector('.c2-treino-info'), gs = barra.querySelector('.c2-treino-gas'); if (inf) inf.hidden = modoJogo; if (gs) gs.hidden = modoJogo; } if (on) { bonecos = modoJogo ? [] : [novoBoneco(P.x + 170), novoBoneco(P.x + 250), novoBoneco(P.x + 330)]; heroRef = P; } else { bonecos = []; tiros = []; nuvens = []; } return on; }
  const mundo = () => ({ heroi: heroRef, inimigos: () => bonecos, camera: cam,
    dano: (e, n, tipo, dir) => { if (e.hp <= 0) return; const IMP = window.CampanhaImpacto, hx = e.x - (dir || 0) * 6, hy = (e.y ?? FLOOR) - (e.alto || 80) * .6, corN = tipo === 'soco' ? '#ffd24a' : tipo === 'confuso' ? '#e48fb0' : '#fff6dc';
      const marca = (num) => { IMP?.piscar?.(e); if (IMP) IMP.acerto(hx, hy, { n: num, tipo, dir, critico: /!$/.test(String(num)), corNum: corN }); else textos.push({ x: e.x + (Math.random() - .5) * 20, y: e.y - (e.alto || 90), n: num, t: 0, cor: corN }); };
      if (e.onDano) { const r = e.onDano(n, tipo, dir); if (r !== false) marca(r || n); return; }
      e.hp = Math.max(0, e.hp - n); e.hit = .18; marca(n); if (e.hp <= 0) { e.morto = 2.2; window.CampanhaLoja?.ganhar?.(8); IMP?.morte?.(e.x, e.y - 40, '#e8c24c'); textos.push({ x: e.x, y: e.y - 120, n: '+8 ●', t: 0, cor: '#ffd24a' }); } }, // inimigo derrotado deixa moedas
    empurrar: (e, vx, vy) => { e.vx = vx; e.vy = vy; }, atordoar: (e, s) => { e.stun = s; }, confundir: (e, s) => { e.conf = s; }, tremer: (n) => { shake = Math.max(shake, n); } });
  function bater(e, n, tipo, dir) { mundo().dano(e, Math.round(n * PW.multiplicadores().forca * (window.CampanhaAliados?.forca?.() || 1)), tipo, dir); }

  /* ---------- ações básicas (as da campanha 1, num jeito simples para o treino) ---------- */
  function acao(id, down, P) {
    heroRef = P; const dir = P.facing < 0 ? -1 : 1;
    if (id === 'poder1' || id === 'poder2') { const r = PW.usar(id === 'poder1' ? 0 : 1, mundo(), down ? 'down' : 'up'); if (down && !r.ok && r.motivo === 'vazio') aviso('Equipe um poder no Mural dos Poderes (quarto da pensão).'); if (down && !r.ok && r.motivo === 'recarga') aviso(`Recarregando: ${r.falta.toFixed(1).replace('.', ',')} s`); return true; }
    if (!down) { if (id === 'jump') voando = false; return true; }
    if (modoJogo && (id === 'paper' || id === 'fart')) { if ((cdAtk[id] || 0) > 0) return true; cdAtk[id] = id === 'paper' ? .26 : .9; if (id === 'paper') { P.attack = .32; } }
    if (id === 'paper') { tiros.push({ x: P.x + dir * 22, y: P.y - 52, vx: dir * 620, vy: -90, vida: .8 }); window.CampanhaImpacto?.arco?.(P.x + dir * 14, P.y - 56, dir); return true; }
    if (id === 'fart') { nuvens.push({ x: P.x - dir * 20, y: P.y - 30, vx: -dir * 60, t: 0, hitou: new Set() }); return true; }
    if (id === 'dash') { if (dashCd <= 0) { dashT = .2; dashCd = 1.1; P.vx = dir * 620; window.CampanhaImpacto?.dash?.(P); } return true; }
    if (id === 'jump') { voando = true; return false; } // o pulo em si é do visualizador
    if (id === 'interact') return false;
    return false;
  }
  const cdAtk = {};
  let avisoTxt = '', avisoT = 0; const aviso = (s) => { avisoTxt = s; avisoT = 2.4; };

  function passo(dt, P, o) {
    if (!on) return; heroRef = P; cam = o.cam; PW.atualizar(dt, mundo()); for (const k in cdAtk) cdAtk[k] = Math.max(0, cdAtk[k] - dt); if (P.attack > 0) P.attack = Math.max(0, P.attack - dt); dashCd = Math.max(0, dashCd - dt); shake = Math.max(0, shake - dt * 30); avisoT = Math.max(0, avisoT - dt);
    if (dashT > 0) { dashT -= dt; P.vx = (P.facing < 0 ? -1 : 1) * 620; window.CampanhaImpacto?.rastro?.(P); }
    if (voando && !P.ground && gas > 0 && o.segurandoPulo) { P.vy = Math.max(-240, P.vy - 1500 * dt); gas = Math.max(0, gas - 38 * dt); } if (P.ground) gas = Math.min(100, gas + 60 * dt);
    if (!modoJogo) for (const b of bonecos) {
      if (b.morto > 0) { b.morto -= dt; if (b.morto <= 0) Object.assign(b, novoBoneco(b.base)); continue; }
      b.hit = Math.max(0, b.hit - dt); b.stun = Math.max(0, b.stun - dt); b.conf = Math.max(0, b.conf - dt); b.golpe = Math.max(0, b.golpe - dt);
      b.x += b.vx * dt; b.vx *= Math.pow(.02, dt); b.vy += 1400 * dt; b.y = Math.min(FLOOR, b.y + b.vy * dt); if (b.y >= FLOOR) b.vy = 0;
      if (b.conf > 0 && b.stun <= 0) { const alvo = bonecos.filter((q) => q !== b && q.hp > 0).sort((p, q) => Math.abs(p.x - b.x) - Math.abs(q.x - b.x))[0]; // confuso: vai bater no colega
        if (alvo) { const d = alvo.x - b.x; if (Math.abs(d) > 40) b.x += Math.sign(d) * 120 * dt; else if (b.golpe <= 0) { b.golpe = .7; mundo().dano(alvo, 4, 'confuso', Math.sign(d)); alvo.vx = Math.sign(d) * 160; textos.push({ x: b.x, y: b.y - 110, n: 'TOMA!', t: 0, cor: '#e48fb0' }); } } }
      else if (b.stun <= 0) b.x += (b.base - b.x) * Math.min(1, dt * .8); // volta devagar pro lugar
    }
    tiros = tiros.filter((q) => { q.vida -= dt; q.x += q.vx * dt; q.y += q.vy * dt; q.vy += 300 * dt; for (const b of bonecos) if (b.hp > 0 && !b.intocavel && Math.abs(b.x - q.x) < (b.largura || 22) && q.y > b.y - (b.alto || 80) && q.y < b.y + 4) { bater(b, 6, 'papel', Math.sign(q.vx)); b.vx = Math.sign(q.vx) * 90; return false; } return q.vida > 0; });
    nuvens = nuvens.filter((n) => { n.t += dt; n.x += n.vx * dt; for (const b of bonecos) if (b.hp > 0 && !b.intocavel && !n.hitou.has(b) && Math.abs(b.x - n.x) < 60 + (b.largura || 22) - 22 && Math.abs((b.y - (b.alto || 80) / 2) - n.y) < 90) { n.hitou.add(b); bater(b, 9, 'peido', 0); } return n.t < 1.1; });
    textos = textos.filter((x) => { x.t += dt; return x.t < .9; });
  }

  function espantalho(c, b, t) { // boneco de treino: espantalho de palha com camisa e chapéu
    const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); };
    const caido = b.hp <= 0, sh = b.hit > 0 ? Math.round(Math.sin(t * 60) * 2) : 0, x = b.x + sh, y = b.y;
    c.save(); if (!caido && window.CampanhaImpacto?.piscando?.(b)) c.globalAlpha = .25; if (caido) { c.translate(x, y); c.rotate(-1.4 * Math.min(1, (2.2 - b.morto) * 4)); c.translate(-x, -y); }
    R(x - 2, y - 70, 4, 70, '#6a4a2a'); R(x - 22, y - 62, 44, 4, '#6a4a2a');
    R(x - 14, y - 64, 28, 30, b.hit > 0 ? '#ffffff' : '#c43c3a'); R(x - 14, y - 64, 28, 3, '#e85a4a'); R(x - 3, y - 64, 6, 30, '#2c4a7a');
    for (let k = 0; k < 4; k++) { R(x - 24 + k * 2, y - 61 + k, 2, 4, '#e8c24c'); R(x + 20 + k * 1, y - 61 + k, 2, 4, '#e8c24c'); R(x - 10 + k * 6, y - 34, 2, 6, '#e8c24c'); }
    R(x - 10, y - 84, 20, 20, '#e9d6a8'); R(x - 6, y - 78, 3, 3, '#2a2a2a'); R(x + 3, y - 78, 3, 3, '#2a2a2a'); R(x - 5, y - 71, 10, 2, '#8a3a2a'); if (b.conf > 0) R(x - 5, y - 72, 10, 2, '#c43c6a');
    R(x - 16, y - 88, 32, 4, '#d7b665'); R(x - 9, y - 96, 18, 8, '#d7b665'); R(x - 9, y - 90, 18, 2, '#c43c3a');
    c.restore();
    if (!caido) { R(x - 20, y - 106, 40, 5, '#1c1408'); R(x - 19, y - 105, 38 * b.hp / b.max, 3, b.hp / b.max > .4 ? '#7ac85a' : '#e8433a'); }
  }
  function desenhar(c, t) {
    if (!on) return; const P = heroRef;
    if (!modoJogo) for (const b of bonecos) espantalho(c, b, t);
    const IMP = window.CampanhaImpacto;
    for (const n of nuvens) { if (IMP) { IMP.nuvem(c, n); continue; } const a = 1 - n.t / 1.1; for (let k = 0; k < 5; k++) { c.fillStyle = `rgba(150,200,90,${a * .55})`; c.beginPath(); c.arc(n.x + Math.cos(k * 1.3 + n.t * 3) * 18 * (1 + n.t), n.y - 6 + Math.sin(k * 2 + n.t * 2) * 10, 10 + n.t * 16, 0, Math.PI * 2); c.fill(); } }
    for (const q of tiros) { if (IMP) { IMP.bolaPapel(c, q, t); continue; } c.fillStyle = '#f6f4ee'; c.fillRect(Math.round(q.x - 5), Math.round(q.y - 5), 10, 10); c.fillStyle = '#d8d4c8'; c.fillRect(Math.round(q.x - 3), Math.round(q.y - 3), 4, 4); }
    PW.desenhar(c, mundo());
    c.font = '14px Pixel, monospace'; c.textAlign = 'center';
    for (const x of textos) { c.globalAlpha = 1 - x.t / .9; c.fillStyle = '#2a1a14'; c.fillText(String(x.n), x.x + 2, x.y - x.t * 40 + 2); c.fillStyle = x.cor; c.fillText(String(x.n), x.x, x.y - x.t * 40); } c.globalAlpha = 1;
    if (avisoT > 0) { c.font = '12px Pixel, monospace'; const w = c.measureText(avisoTxt).width + 20; c.fillStyle = 'rgba(28,20,12,.85)'; c.fillRect(P.x - w / 2, P.y - 150, w, 22); c.fillStyle = '#f3d89e'; c.fillText(avisoTxt, P.x, P.y - 135); }
    if (barra) { barra.querySelector('.c2-treino-gas i').style.width = `${gas}%`; const m = PW.multiplicadores(), eq = PW.estado().equipados;
      barra.querySelector('.c2-treino-info').innerHTML = `TREINO DE PODERES · ● ${window.CampanhaLoja?.moedas?.() ?? 0} MOEDAS<br>J PAPEL · K PEIDO · L DASH · ␣ VOAR · U/I PODERES<br>${eq.filter(Boolean).length ? 'Equipados: ' + eq.map((id) => PW.lista().find((p) => p.id === id)?.curto || '—').join(' + ') : 'Sem poder equipado: abra o MURAL'}${m.vel > 1 ? '<br>☕ CAFEZÃO ATIVO' : ''}${PW.escudo() ? '<br>♥ AURA ATIVA' : ''}`;
      [0, 1].forEach((i) => { const id = eq[i], b = barra.querySelector(`[data-acao="poder${i + 1}"] .c2-cd`); if (!b || !id) return; const max = PW.recargaTotal(id), f = Math.min(1, PW.recarga(id) / max); b.style.setProperty('--cd', `${Math.round((1 - f) * 100)}%`); }); }
  }
  window.CampanhaTreino = Object.freeze({ ligar, ligado: () => on, gas: () => gas, inimigos: (lista) => { if (Array.isArray(lista)) bonecos = lista; return bonecos; }, dashing: () => on && dashT > 0, acao, passo, desenhar, montarBarra, tremor: () => shake, velocidade: () => (on ? PW.multiplicadores().vel : 1) });
})();
