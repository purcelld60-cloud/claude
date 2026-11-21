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
    for (const sh of document.styleSheets) { let rules; try { rules = sh.cssRules; } catch (e) { continue; } for (const r of rules || []) if (r.selectorText && /crafted-controls/.test(r.selectorText) && /touch-btn|control-icon|kbd|-btn\b/.test(r.selectorText)) txt += r.cssText.replace(/#gameShell\s*/g, '').replace(/\.crafted-controls/g, '.c2-treino-ctl') + '\n'; }
    txt += `.c2-treino-ctl{position:absolute;right:2%;bottom:3%;display:grid;grid-template-columns:repeat(4,auto);gap:8px;z-index:3}.c2-treino-ctl .touch-btn{width:54px;height:54px;touch-action:none;user-select:none;-webkit-user-select:none}
.c2-treino-ctl .touch-btn kbd{position:absolute;top:2px;left:4px;font:6px Pixel,monospace;opacity:.6}.c2-treino-ctl .touch-btn.pressed{transform:translateY(3px);filter:brightness(1.1)}.c2-treino-ctl .c2-poder-btn small{position:static;transform:none;color:inherit}.c2-treino-ctl .c2-poder-btn{--key-face:#c8a8e8;--key-edge:#8a6ab8;--key-ink:#4a2a6a;--key-light:#f0e0ff}.c2-treino-ctl .interact-btn{--key-face:#f0dcae;--key-edge:#b8955a;--key-ink:#5a3a1a;--key-light:#fff6d8}
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
    dano: (e, n, tipo, dir) => { if (e.hp <= 0) return; e.piscaAte = performance.now() + 400; // no golpe o inimigo pisca
      if (e.onDano) { const r = e.onDano(n, tipo, dir); if (r !== false) textos.push({ x: e.x + (Math.random() - .5) * 20, y: e.y - (e.alto || 90), n: r || n, t: 0, cor: tipo === 'soco' ? '#ffd24a' : tipo === 'confuso' ? '#e48fb0' : '#fff6dc' }); return; } e.hp = Math.max(0, e.hp - n); e.hit = .18; textos.push({ x: e.x + (Math.random() - .5) * 20, y: e.y - 90, n, t: 0, cor: tipo === 'soco' ? '#ffd24a' : tipo === 'confuso' ? '#e48fb0' : '#fff6dc' }); if (e.hp <= 0) { e.morto = 2.2; window.CampanhaLoja?.ganhar?.(8); textos.push({ x: e.x, y: e.y - 120, n: '+8 ●', t: 0, cor: '#ffd24a' }); } }, // inimigo derrotado deixa moedas
    empurrar: (e, vx, vy) => { e.vx = vx; e.vy = vy; }, atordoar: (e, s) => { e.stun = s; }, confundir: (e, s) => { e.conf = s; }, tremer: (n) => { shake = Math.max(shake, n); } });
  function bater(e, n, tipo, dir) { mundo().dano(e, Math.round(n * PW.multiplicadores().forca * (window.CampanhaAliados?.forca?.() || 1)), tipo, dir); }

  /* ---------- ações básicas: EXATAMENTE as da campanha 1 (mesmos números de game.js) ----------
     papel: reto a 600, mira no inimigo mais perto à frente, 30 de munição (recarrega 1 a cada 1,1 s), segurar = rajada (0,23 s)
     voo: segurar o pulo no ar sobe até 235 (1050/s), gasta 17 de gás por segundo; gás recarrega 16/s no chão e 6/s no ar
     dash: 600 por 0,2 s, rastro do Da Roça, poeira e invencível 0,18 s; recarga 1,1 s
     peido: em volta do Da Roça (raio 155/205/260 no combo de 3), gasta gás 20/17/20, recarga 0,24 entre golpes do combo e 1,5 no fim */
  const CFG = { mover: 280, pulo: 365, grav: 850, voo: 235, empuxo: 1050, gasVoo: 17, gasChao: 16, gasAr: 6, gasMax: 100, papel: 600, papelVida: 1.5, papelCd: .23, papelMax: 30, dash: 600, dashT: .2, dashCd: 1.1 };
  let papeis = CFG.papelMax, municao = 0, cdPapel = 0, cdPeido = 0, combo = 0, janela = 0, dashDir = 1, segura = { paper: false, fart: false }, rastro = [], parts = [];
  let ctxSom = null;
  function beep(freq = 440, dur = .09, type = 'square', vol = .025) { // o mesmo "bip" da campanha 1
    try { if (window.Game?.soundOn && !window.Game.soundOn()) return; vol *= window.DarocaAudio?.sfx?.() ?? 1; if (vol <= .0005) return; ctxSom = ctxSom || new (window.AudioContext || window.webkitAudioContext)(); ctxSom.resume();
      const o = ctxSom.createOscillator(), g = ctxSom.createGain(), t0 = ctxSom.currentTime; o.type = type; o.frequency.setValueAtTime(freq, t0); o.frequency.exponentialRampToValueAtTime(Math.max(35, freq * .5), t0 + dur); g.gain.setValueAtTime(vol, t0); g.gain.exponentialRampToValueAtTime(.001, t0 + dur); o.connect(g); g.connect(ctxSom.destination); o.start(); o.stop(t0 + dur); } catch (e) {} }
  function fx(x, y, color, count = 10, power = 90) { const n = Math.min(12, Math.max(0, Math.round(count * .5)), Math.max(0, 96 - parts.length)); for (let i = 0; i < n; i++) parts.push({ x, y, vx: (Math.random() * 2 - 1) * power, vy: -power + Math.random() * power * 1.35, life: .18 + Math.random() * .3, color, size: 2 + Math.random() * 2 }); }
  function papel(P) {
    if (cdPapel > 0) return; if (papeis <= 0) { aviso('O papel recarrega sozinho. Use o combo de gás enquanto espera!'); cdPapel = .4; return; }
    cdPapel = CFG.papelCd; papeis--; shake = Math.max(shake, 1.2); P.attack = .24; P.attackType = 'paper'; P.attackDuration = .24; const dir = P.facing < 0 ? -1 : 1;
    const alvo = bonecos.filter((b) => b.hp > 0 && !b.intocavel && Math.sign(b.x - P.x) === dir && Math.abs(b.x - P.x) < 650).sort((a, b) => Math.abs(a.x - P.x) - Math.abs(b.x - P.x))[0];
    const mira = alvo ? Math.max(-.85, Math.min(.85, Math.atan2((alvo.y - (alvo.alto || 80) / 2) - (P.y - 32), Math.abs(alvo.x - P.x)))) : 0;
    tiros.push({ x: P.x + dir * 28, y: P.y - 32, vx: dir * Math.cos(mira) * CFG.papel, vy: Math.sin(mira) * CFG.papel, vida: CFG.papelVida });
    VFX()?.emit?.('cast', { x: P.x + dir * 26, y: P.y - 32, dir }); fx(P.x + dir * 30, P.y - 32, '#f8f3da', 4, 35); beep(760, .045);
  }
  function peido(P) {
    if (cdPeido > 0) return; const corrente = janela > 0; combo = corrente ? Math.min(3, combo + 1) : 1; const custo = combo === 3 ? 20 : combo === 2 ? 17 : 20;
    if (gas < custo) { aviso('Seu gás precisa recarregar. Espere no chão!'); combo = 0; cdPeido = .3; return; }
    gas -= custo; cdPeido = combo === 3 ? 1.5 : .24; janela = combo < 3 ? .85 : 0; P.attack = .36; P.attackType = 'fart'; P.attackDuration = .36; shake = Math.max(shake, combo === 3 ? 9 : 4); beep(80 - combo * 8, .2, 'sawtooth', .045);
    const dir = P.facing < 0 ? -1 : 1, raio = combo === 3 ? 260 : combo === 2 ? 205 : 155, mult = combo === 3 ? 1.8 : combo === 2 ? 1.25 : 1;
    VFX()?.emit?.('gas', { x: P.x + dir * 9, y: P.y - 23, dir, stage: combo, radius: raio }); fx(P.x + dir * 38, P.y - 22, combo === 3 ? '#e0ef82' : '#b9df55', combo === 3 ? 52 : 25, raio * .75);
    for (const b of bonecos) if (b.hp > 0 && !b.intocavel && Math.abs(b.x - P.x) < raio + ((b.largura || 22) - 22) && Math.abs((b.y || FLOOR) - P.y) < 180) bater(b, Math.round(9 * mult), 'peido', 0);
  }
  function acao(id, down, P) {
    heroRef = P; const dir = P.facing < 0 ? -1 : 1;
    if (id === 'poder1' || id === 'poder2') { const r = PW.usar(id === 'poder1' ? 0 : 1, mundo(), down ? 'down' : 'up'); if (down && !r.ok && r.motivo === 'vazio') aviso('Equipe um poder no Mural dos Poderes (quarto da pensão).'); if (down && !r.ok && r.motivo === 'recarga') aviso(`Recarregando: ${r.falta.toFixed(1).replace('.', ',')} s`); return true; }
    if (id === 'paper' || id === 'fart') { segura[id] = !!down; if (down) (id === 'paper' ? papel : peido)(P); return true; } // segurar dispara de novo quando a recarga acaba (como na principal)
    if (!down) return id !== 'jump' && id !== 'interact';
    if (id === 'dash') { if (dashCd <= 0) { dashDir = P.facing < 0 ? -1 : 1; dashT = CFG.dashT; dashCd = CFG.dashCd; P.vx = dashDir * CFG.dash; P.inv = Math.max(P.inv || 0, .18); VFX()?.emit?.('dash', { x: P.x, y: P.y - 3, dir: dashDir }); fx(P.x, P.y - 22, '#c0dfb8', 18, 130); beep(310, .08, 'sawtooth'); } return true; }
    if (id === 'jump') return false; // o pulo (365) e o voo estão na física do jogo e no passo abaixo
    return false;
  }
  const VFX = () => window.CampaignVfx;
  const musculoso = () => { try { return !!window.Game?.getState?.()?.q?.trained; } catch (e) { return false; } }; // continuação: o Da Roça segue como terminou a campanha 1
  let voandoAgora = false;
  let avisoTxt = '', avisoT = 0; const aviso = (s) => { if (modoJogo && window.Campanha2?.aviso) { try { window.Campanha2.aviso(s); return; } catch (e) {} } avisoTxt = s; avisoT = 2.4; };

  function passo(dt, P, o) {
    if (!on) return; heroRef = P; cam = o.cam; PW.atualizar(dt, mundo());
    cdPapel = Math.max(0, cdPapel - dt); cdPeido = Math.max(0, cdPeido - dt); janela = Math.max(0, janela - dt); if (P.attack > 0) P.attack = Math.max(0, P.attack - dt); dashCd = Math.max(0, dashCd - dt); shake = Math.max(0, shake - dt * 28); avisoT = Math.max(0, avisoT - dt);
    municao += dt; if (municao > 1.1) { municao = 0; papeis = Math.min(CFG.papelMax, papeis + 1); }
    if (segura.paper) papel(P); if (segura.fart) peido(P);
    if (dashT > 0) { dashT -= dt; P.vx = dashDir * CFG.dash; rastro.push({ x: P.x, y: P.y, facing: P.facing, life: .2 }); }
    voandoAgora = !P.ground && gas > 0 && !!o.segurandoPulo;
    if (voandoAgora) { if (P.vy > -CFG.voo) P.vy = Math.max(-CFG.voo, P.vy - CFG.empuxo * dt); gas = Math.max(0, gas - CFG.gasVoo * dt); if (Math.random() < .35) fx(P.x, P.y + 3, '#bed970', 1, 50); }
    else if (!o.segurandoPulo) gas = Math.min(CFG.gasMax, gas + dt * (P.ground ? CFG.gasChao : CFG.gasAr));
    VFX()?.update?.(dt); for (const a of rastro) a.life -= dt; rastro = rastro.filter((a) => a.life > 0); for (const q of parts) { q.x += q.vx * dt; q.y += q.vy * dt; q.vy += 180 * dt; q.life -= dt; } parts = parts.filter((q) => q.life > 0);
    if (!modoJogo) for (const b of bonecos) {
      if (b.morto > 0) { b.morto -= dt; if (b.morto <= 0) Object.assign(b, novoBoneco(b.base)); continue; }
      b.hit = Math.max(0, b.hit - dt); b.stun = Math.max(0, b.stun - dt); b.conf = Math.max(0, b.conf - dt); b.golpe = Math.max(0, b.golpe - dt);
      b.x += b.vx * dt; b.vx *= Math.pow(.02, dt); b.vy += 1400 * dt; b.y = Math.min(FLOOR, b.y + b.vy * dt); if (b.y >= FLOOR) b.vy = 0;
      if (b.conf > 0 && b.stun <= 0) { const alvo = bonecos.filter((q) => q !== b && q.hp > 0).sort((p, q) => Math.abs(p.x - b.x) - Math.abs(q.x - b.x))[0]; // confuso: vai bater no colega
        if (alvo) { const d = alvo.x - b.x; if (Math.abs(d) > 40) b.x += Math.sign(d) * 120 * dt; else if (b.golpe <= 0) { b.golpe = .7; mundo().dano(alvo, 4, 'confuso', Math.sign(d)); alvo.vx = Math.sign(d) * 160; textos.push({ x: b.x, y: b.y - 110, n: 'TOMA!', t: 0, cor: '#e48fb0' }); } } }
      else if (b.stun <= 0) b.x += (b.base - b.x) * Math.min(1, dt * .8); // volta devagar pro lugar
    }
    tiros = tiros.filter((q) => { q.vida -= dt; q.x += q.vx * dt; q.y += q.vy * dt; for (const b of bonecos) if (b.hp > 0 && !b.intocavel && Math.abs(b.x - q.x) < (b.largura || 22) && q.y > b.y - (b.alto || 80) && q.y < b.y + 4) { bater(b, 6, 'papel', Math.sign(q.vx)); b.vx = Math.sign(q.vx) * 90; return false; } return q.vida > 0; });
    nuvens = [];
    textos = textos.filter((x) => { x.t += dt; return x.t < .9; });
  }

  const piscando = (e) => (e.piscaAte || 0) > performance.now() && Math.floor(performance.now() / 55) % 2 === 0;
  function espantalho(c, b, t) { // boneco de treino: espantalho de palha com camisa e chapéu
    const R = (x, y, w, h, col) => { c.fillStyle = col; c.fillRect(Math.round(x), Math.round(y), w, h); };
    const caido = b.hp <= 0, sh = b.hit > 0 ? Math.round(Math.sin(t * 60) * 2) : 0, x = b.x + sh, y = b.y;
    c.save(); if (!caido && piscando(b)) c.globalAlpha = .25; if (caido) { c.translate(x, y); c.rotate(-1.4 * Math.min(1, (2.2 - b.morto) * 4)); c.translate(-x, -y); }
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
    for (const q of parts) { c.globalAlpha = Math.max(0, Math.min(1, q.life * 2)); c.fillStyle = q.color; c.fillRect(Math.round(q.x), Math.round(q.y), q.size, q.size); } c.globalAlpha = 1; // partículas iguais às da principal
    for (const q of tiros) { if (VFX()?.drawProjectile?.(c, { type: 'paper', x: q.x, y: q.y, vx: q.vx, vy: q.vy, owner: 'player' }, t)) continue; c.fillStyle = '#f6f4ee'; c.fillRect(Math.round(q.x - 5), Math.round(q.y - 5), 10, 10); }
    VFX()?.draw?.(c, t, 'front');
    PW.desenhar(c, mundo());
    c.font = '14px Pixel, monospace'; c.textAlign = 'center';
    for (const x of textos) { c.globalAlpha = 1 - x.t / .9; c.fillStyle = '#2a1a14'; c.fillText(String(x.n), x.x + 2, x.y - x.t * 40 + 2); c.fillStyle = x.cor; c.fillText(String(x.n), x.x, x.y - x.t * 40); } c.globalAlpha = 1;
    if (avisoT > 0) { c.font = '12px Pixel, monospace'; const w = c.measureText(avisoTxt).width + 20; c.fillStyle = 'rgba(28,20,12,.85)'; c.fillRect(P.x - w / 2, P.y - 150, w, 22); c.fillStyle = '#f3d89e'; c.fillText(avisoTxt, P.x, P.y - 135); }
    if (barra) { barra.querySelector('.c2-treino-gas i').style.width = `${gas}%`; const m = PW.multiplicadores(), eq = PW.estado().equipados;
      barra.querySelector('.c2-treino-info').innerHTML = `TREINO DE PODERES · ● ${window.CampanhaLoja?.moedas?.() ?? 0} MOEDAS<br>J PAPEL · K PEIDO · L DASH · ␣ VOAR · U/I PODERES<br>${eq.filter(Boolean).length ? 'Equipados: ' + eq.map((id) => PW.lista().find((p) => p.id === id)?.curto || '—').join(' + ') : 'Sem poder equipado: abra o MURAL'}${m.vel > 1 ? '<br>☕ CAFEZÃO ATIVO' : ''}${PW.escudo() ? '<br>♥ AURA ATIVA' : ''}`;
      [0, 1].forEach((i) => { const id = eq[i], b = barra.querySelector(`[data-acao="poder${i + 1}"] .c2-cd`); if (!b || !id) return; const max = PW.recargaTotal(id), f = Math.min(1, PW.recarga(id) / max); b.style.setProperty('--cd', `${Math.round((1 - f) * 100)}%`); }); }
  }
  window.CampanhaTreino = Object.freeze({ dashFalta: () => dashCd, voandoAgora: () => voandoAgora, som: (f, d, ty, v) => beep(f, d, ty, v), desenharAtras: (c, t) => { if (!on) return; VFX()?.draw?.(c, t, 'back'); for (const a of rastro) { c.save(); c.globalAlpha = Math.min(1, a.life * 2); try { window.Art?.drawCharacter?.(c, 'daroca', a.x, a.y, { facing: a.facing, frame: t, dash: true, moving: true, muscular: musculoso(), grounded: true }); } catch (e) {} c.restore(); } }, papeis: () => papeis, musculoso: () => musculoso(), piscando, ligar, ligado: () => on, gas: () => gas, inimigos: (lista) => { if (Array.isArray(lista)) bonecos = lista; return bonecos; }, dashing: () => on && dashT > 0, acao, passo, desenhar, montarBarra, tremor: () => shake, velocidade: () => (on ? PW.multiplicadores().vel : 1) });
})();
