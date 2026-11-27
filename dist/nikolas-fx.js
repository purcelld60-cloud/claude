/* Nikolas, o nariz de batata — efeitos da luta (só desenho; vida, dano, tempos e áreas de acerto continuam os mesmos).
   - Aura de cada fase, desenhada atrás dele: fio de fedor (1), chama dourada e verde do shape (2),
     labaredas de catarro subindo enquanto voa (3) e a aura tóxica do titã com bolhas, pingos e moscas (4).
   - Catarro: as gosmas que ele cospe viram bolas de catarro amarelo-esverdeado, com fio e respingo.
   - Onda verde: os anéis de choque das fases 2 e 4 (palmas do shape e passos do titã) viram ondas de catarro.
   - Troca de fase: ele tira um pão podre do bolso (com mofo e fumaça de fedor), come em três mordidas,
     arrota uma nuvem verde, junta energia e explode na forma nova. Cada etapa tem os seus quadros desenhados
     aqui em pixel e efeitos da pixelfx (vendor/pixelfx.js, MIT) recoloridos com a paleta do catarro.
   Ganchos no game.js: NikolasFx.aura (antes do sprite), NikolasFx.frente (depois), NikolasFx.catarro (tiros)
   e NikolasFx.onda (anéis com catarro:true). */
(() => {
  'use strict';
  const C = {
    esc: '#1c2608', esc2: '#33480f', med: '#5d8423', clr: '#8fbd36', luz: '#c3e165', bri: '#ecfab0', branco: '#fbffe8',
    amarelo: '#d9cf4c', amarelo2: '#f2e98a', ouro: '#ffcf5a', ouro2: '#ffe9a6', laranja: '#f39a3a',
    pao1: '#6e4317', pao2: '#9c6427', pao3: '#c98d43', pao4: '#e6bd78', miolo: '#e9dcb0', miolo2: '#cdbd86',
    mofo1: '#3d5a16', mofo2: '#6f8f22', mofo3: '#a4bd3c', mofo4: '#4a3a5c', mosca: '#14120e', asa: '#c8d6e0'
  };
  const PAL_CATARRO = ['#101806', '#22320c', '#3e5a14', '#69922a', '#a2c946', '#d8ee8c', '#f6ffd6'];
  const PAL_AMARELO = ['#1c1806', '#3e360c', '#6e6218', '#a8962c', '#d8c84c', '#f2e88e', '#fffbe0'];
  const PAL_OURO = ['#2a1a06', '#5a3a0a', '#9a6a14', '#d8a028', '#ffd25a', '#fff0a8', '#ffffff'];
  let ctx = null;
  const hsh = (n) => { const x = Math.sin(n * 12.9898 + 78.233) * 43758.5453; return x - Math.floor(x); };
  const px = (x, y, w, h, c) => { ctx.fillStyle = c; ctx.fillRect(Math.round(x), Math.round(y), Math.max(1, Math.round(w)), Math.max(1, Math.round(h))); };
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const lerp = (a, b, k) => a + (b - a) * k;
  const suave = (k) => { k = clamp(k, 0, 1); return k * k * (3 - 2 * k); };
  const entre = (p, a, b) => clamp((p - a) / (b - a), 0, 1);
  const leve = () => !!window.Graphics?.isLite?.();
  const tocar = (id, o) => window.FxPixel?.tocar?.(id, o);

  // corpo do Nikolas em cada fase (as mesmas medidas que o jogo usa para acertar o golpe)
  const BOUNDS = { 1: { halfWidth: 35, height: 90, centerY: 30 }, 2: { halfWidth: 55, height: 140, centerY: 70 }, 3: { halfWidth: 55, height: 140, centerY: 70 }, 4: { halfWidth: 185, height: 340, centerY: 170 } };
  const medida = (f) => window.Art?.nikolasBounds?.(f) || BOUNDS[f] || BOUNDS[1];
  function progresso(e) { return e.state === 'phaseChange' ? clamp(1 - e.stateTimer / (e.phaseDuration || 1.05), 0, 1) : 1; }
  function corpo(e) {
    const f = e.phase || 1, p = progresso(e);
    let b = medida(f);
    if (e.state === 'phaseChange' && f > 1) { const a = medida(f - 1), k = suave(entre(p, .55, .85)); b = { halfWidth: lerp(a.halfWidth, b.halfWidth, k), height: lerp(a.height, b.height, k), centerY: lerp(a.centerY, b.centerY, k) }; }
    return { x: e.x, pe: e.y, topo: e.y - b.height, cy: e.y - b.centerY, meia: b.halfWidth, alto: b.height };
  }
  const boca = (e, cp, dir) => ({ x: cp.x + dir * cp.meia * .42, y: cp.topo + cp.alto * ((e.phase || 1) >= 4 ? .2 : .24) });

  /* ---------- peças em pixel ---------- */
  // labareda: coluna de blocos que sobe, afina e balança; duas passadas (borda escura e miolo claro)
  function labareda(x, base, alto, larg, t, seed, cores, a) {
    const passo = alto > 60 ? 4 : 3;
    for (let k = 0; k < alto; k += passo) {
      const f = k / alto, w = Math.max(1, larg * Math.pow(1 - f, .75) * (.78 + .22 * Math.sin(t * 13 + seed * 3 + k * .21)));
      const ox = Math.sin(t * 7 + seed + k * .09) * k * .16;
      ctx.globalAlpha = a * (f < .15 ? .55 + f * 3 : 1) * (1 - f * .35);
      px(x + ox - w / 2, base - k - passo, w, passo, f < .35 ? cores[0] : f < .7 ? cores[1] : cores[2]);
      if (w > 4) px(x + ox - w / 4, base - k - passo, w / 2, passo, f < .5 ? cores[2] : cores[3]);
    }
    ctx.globalAlpha = 1;
  }
  // bolha de catarro (círculo em pixel com brilho)
  function bolha(x, y, r, a) {
    ctx.globalAlpha = a;
    for (let yy = -r; yy <= r; yy += 2) { const w = Math.sqrt(Math.max(0, r * r - yy * yy)); px(x - w, y + yy, 2, 2, C.luz); px(x + w - 2, y + yy, 2, 2, C.med); }
    px(x - r * .4, y - r * .5, 2, 2, C.branco);
    ctx.globalAlpha = 1;
  }
  function mosca(x, y, t, seed) {
    const bate = Math.sin(t * 60 + seed) > 0;
    px(x - 1, y - 1, 3, 2, C.mosca);
    ctx.globalAlpha = .7; px(x - 3, y - (bate ? 3 : 2), 2, bate ? 2 : 1, C.asa); px(x + 2, y - (bate ? 3 : 2), 2, bate ? 2 : 1, C.asa); ctx.globalAlpha = 1;
  }
  // nuvem de fedor: bolotas com 3 tons
  function nuvem(x, y, r, a, seed, tons) {
    tons = tons || [C.esc2, C.med, C.luz];
    const n = r > 30 ? 7 : 5;
    for (let i = 0; i < n; i++) {
      const an = i / n * Math.PI * 2 + seed, rr = r * (.45 + .25 * hsh(seed + i)), cx = x + Math.cos(an) * r * .55, cy = y + Math.sin(an) * r * .35;
      ctx.globalAlpha = a * .9; disco(cx, cy, rr, tons[0]);
      ctx.globalAlpha = a; disco(cx - rr * .15, cy - rr * .2, rr * .78, tons[1]);
      ctx.globalAlpha = a * .8; disco(cx - rr * .3, cy - rr * .38, rr * .4, tons[2]);
    }
    ctx.globalAlpha = 1;
  }
  function disco(x, y, r, c) { if (r < 1) return; const s = r > 14 ? 3 : 2; for (let yy = -r; yy < r; yy += s) { const w = Math.sqrt(Math.max(0, r * r - yy * yy)); px(x - w, y + yy, w * 2, s, c); } }
  // fio de fedor (linha ondulada subindo)
  function fedor(x, y, alto, t, seed, a) {
    ctx.globalAlpha = a;
    for (let k = 0; k < alto; k += 3) { const ox = Math.sin(t * 5 + seed + k * .18) * 4; px(x + ox, y - k, 2, 3, k % 9 < 3 ? C.luz : C.clr); }
    ctx.globalAlpha = 1;
  }

  /* ---------- o pão podre (quadros em pixel, 18 x 10 na escala do mundo) ---------- */
  // mordidas: 0 a 3 (cada uma come um pedaço do lado da boca); dir = lado da boca
  function pao(x, y, esc, mordidas, dir, t) {
    const W = 18, H = 10;
    const comido = mordidas * 4;
    for (let cx = 0; cx < W; cx++) {
      // coluna em coordenadas do pão (0 = ponta longe da boca)
      const doLado = cx; // 0..17
      if (doLado >= W - comido) {
        // marca da mordida: borda irregular (dentes)
        if (doLado === W - comido && mordidas > 0) for (let cy = 2; cy < H - 1; cy++) if (cy % 3 !== 0) px(x - dir * (cx - W / 2) * esc, y + (cy - H / 2) * esc, esc, esc, C.miolo2);
        continue;
      }
      const curva = Math.round(Math.abs(cx - 8.5) / 3.2);
      for (let cy = curva; cy < H; cy++) {
        let c;
        if (cy === curva) c = C.pao1; else if (cy === curva + 1) c = C.pao3; else if (cy >= H - 2) c = C.pao1; else c = cy < 4 ? C.pao2 : C.pao3;
        if (cx === 0 || cx === W - 1 - comido) c = C.pao1;
        // corte da mordida mostra o miolo
        if (mordidas > 0 && cx === W - 1 - comido && cy > curva && cy < H - 1) c = C.miolo;
        // riscos de pão francês
        if (cy === curva + 1 && cx % 5 === 2) c = C.pao4;
        // mofo
        const m = hsh(cx * 17 + cy * 31);
        if (m > .82) c = m > .94 ? C.mofo4 : m > .88 ? C.mofo2 : C.mofo1;
        if (m > .76 && m <= .82 && cy < 5) c = C.mofo3;
        px(x - dir * (cx - W / 2) * esc, y + (cy - H / 2) * esc, esc, esc, c);
      }
    }
    // fumaça de fedor saindo do pão e moscas
    const restos = W - comido;
    if (restos > 0) {
      for (let i = 0; i < 3; i++) { const k = (t * .7 + i / 3) % 1; nuvem(x + dir * (i - 1) * 5 * esc + Math.sin(t * 3 + i) * 3, y - H / 2 * esc - k * 34 * esc / 2, (3 + k * 7) * esc / 2, (1 - k) * .75, i * 2.1); }
      for (let i = 0; i < 3; i++) fedor(x + dir * (i * 6 - 6) * esc / 2, y - H / 2 * esc - 2, 14 * esc / 2, t, i * 4, .8);
      for (let i = 0; i < 2; i++) mosca(x + Math.cos(t * 5 + i * 3) * 13 * esc / 2, y - 6 * esc + Math.sin(t * 7 + i) * 5 * esc / 2, t, i);
    }
  }

  /* ---------- aura de cada fase (atrás do sprite) ---------- */
  function aura(c, e, t, dir) {
    if (!e || e.hp <= 0) return; ctx = c; dir = dir || -1;
    const cp = corpo(e), f = e.phase || 1, lite = leve(), trocando = e.state === 'phaseChange', p = progresso(e);
    const forca = trocando ? suave(entre(p, .5, .8)) : 1;
    ctx.save();
    if (f === 1) {
      for (let i = 0; i < (lite ? 2 : 4); i++) fedor(cp.x - 18 + i * 12, cp.topo + 6, 26 + 8 * hsh(i), t, i * 3, .55);
    } else {
      const quantas = (f === 2 ? 16 : f === 3 ? 22 : 30) * (lite ? .5 : 1);
      const tons = f === 2 ? [C.laranja, C.ouro, C.ouro2, C.branco] : f === 3 ? [C.med, C.clr, C.luz, C.bri] : [C.esc2, C.med, C.clr, C.luz];
      const pulso = .85 + .15 * Math.sin(t * (f === 4 ? 4 : 7));
      // brilho de fundo
      ctx.globalAlpha = (f === 4 ? .22 : .16) * forca;
      disco(cp.x, cp.cy, Math.max(cp.meia, cp.alto * .45) * 1.25 * pulso, f === 2 ? '#c88a24' : '#5f8a1e');
      ctx.globalAlpha = 1;
      for (let i = 0; i < quantas; i++) {
        const an = i / quantas * Math.PI * 2 + (f === 3 ? t * .6 : 0);
        const ex = cp.x + Math.cos(an) * cp.meia * 1.08, ey = cp.cy + Math.sin(an) * cp.alto * .52;
        const embaixo = Math.sin(an) > .3;
        const alto = (embaixo ? .35 : 1) * (f === 4 ? 70 : f === 3 ? 44 : 32) * (.7 + .5 * hsh(i * 7)) * pulso * forca;
        if (alto < 4) continue;
        labareda(ex, ey + 6, alto, f === 4 ? 16 : 10, t, i * 1.7, tons, .82);
      }
      // fase 2: gotas de suor e listras douradas do shape
      if (f === 2 && !lite) for (let i = 0; i < 5; i++) { const k = (t * 1.3 + i / 5) % 1; ctx.globalAlpha = 1 - k; px(cp.x - cp.meia + hsh(i) * cp.meia * 2, cp.topo + 20 + k * 60, 2, 3, '#bfe6ff'); }
      // fase 3: anel sob os pés e faíscas subindo
      if (f === 3) {
        const r = 46 + Math.sin(t * 6) * 4;
        ctx.globalAlpha = .7 * forca;
        for (let k = 0; k < 40; k++) { const an = k / 40 * Math.PI * 2 + t * 2; px(cp.x + Math.cos(an) * r, cp.pe + 8 + Math.sin(an) * r * .22, 3, 2, k % 2 ? C.luz : C.clr); }
        for (let i = 0; i < (lite ? 6 : 14); i++) { const k = (t * .8 + hsh(i * 3)) % 1; ctx.globalAlpha = (1 - k) * forca; px(cp.x + (hsh(i) - .5) * cp.meia * 2.4, cp.pe - k * (cp.alto + 70), 2, 2, i % 3 ? C.luz : C.bri); }
        for (let i = 0; i < 6; i++) { const k = (t * 2.2 + i / 6) % 1; ctx.globalAlpha = .5 * (1 - k); px(cp.x - 20 + i * 8, cp.pe + 14 + k * 70, 2, 10, C.clr); }
      }
      // fase 4: poça brilhando, bolhas subindo, pingos e moscas
      if (f === 4) {
        ctx.globalAlpha = .55 * forca;
        for (let yy = 0; yy < 10; yy += 2) { const w = cp.meia * 1.5 * (1 - yy / 14); px(cp.x - w, cp.pe - 4 + yy, w * 2, 2, yy < 4 ? C.clr : C.med); }
        ctx.globalAlpha = 1;
        for (let i = 0; i < (lite ? 6 : 16); i++) { const k = (t * .45 + hsh(i * 5)) % 1; bolha(cp.x + (hsh(i) - .5) * cp.meia * 2.6 + Math.sin(t * 2 + i) * 6, cp.pe - 10 - k * (cp.alto + 40), 3 + hsh(i * 9) * 5, (1 - k) * .85 * forca); }
      }
    }
    ctx.restore();
  }

  /* ---------- frente: moscas, pingos e a troca de fase ---------- */
  const memoria = new WeakMap();
  function estadoDe(e) { let m = memoria.get(e); if (!m) { m = { fase: e.phase, feitos: new Set() }; memoria.set(e, m); } if (m.fase !== e.phase) { m.fase = e.phase; m.feitos = new Set(); } return m; }
  function uma(m, chave, f) { if (m.feitos.has(chave)) return; m.feitos.add(chave); f(); }
  function frente(c, e, t, dir) {
    if (!e || e.hp <= 0) return; ctx = c; dir = dir || -1;
    const cp = corpo(e), f = e.phase || 1, lite = leve();
    ctx.save();
    // moscas rodando (mais moscas quanto mais podre ele fica)
    const nm = (lite ? 1 : 2) + f;
    for (let i = 0; i < nm; i++) mosca(cp.x + Math.cos(t * (2 + i * .3) + i * 2) * (cp.meia + 14), cp.topo + 10 + Math.sin(t * (3.1 + i * .2) + i) * 18 + i * 6, t, i);
    // fase 4: catarro escorrendo do queixo e pingando
    if (f === 4 && e.state !== 'phaseChange') {
      const b = boca(e, cp, dir);
      for (let i = 0; i < 3; i++) { const k = (t * .9 + i / 3) % 1, len = 8 + k * 26; px(b.x + i * 8 - 8, b.y + 18, 3, len, C.clr); px(b.x + i * 8 - 8, b.y + 18 + len, 4, 4, C.luz); }
    }
    if (e.state === 'phaseChange') trocaDeFase(e, cp, t, dir, lite);
    ctx.restore();
  }

  // a sequência da troca de fase, dividida pelo progresso p (0 a 1)
  function trocaDeFase(e, cp, t, dir, lite) {
    const p = progresso(e), m = estadoDe(e), f = e.phase || 2;
    const b = boca(e, cp, dir);
    const esc = f >= 4 ? 5 : 3;
    // 1) escurece o mundo em volta e linhas de velocidade puxando para ele
    const escuro = Math.min(entre(p, 0, .08), 1 - entre(p, .86, 1)) * .45;
    if (escuro > 0) {
      ctx.globalAlpha = escuro; px(cp.x - 2000, -600, 4000, 2400, '#0a0f04'); ctx.globalAlpha = 1;
      const nl = lite ? 10 : 26;
      for (let i = 0; i < nl; i++) {
        const an = hsh(i * 3.3) * Math.PI * 2, r0 = 220 + hsh(i) * 260 - ((t * 900 + i * 40) % 260), len = 30 + hsh(i * 7) * 60;
        ctx.globalAlpha = escuro * 1.6;
        for (let k = 0; k < len; k += 4) px(cp.x + Math.cos(an) * (r0 + k), cp.cy + Math.sin(an) * (r0 + k) * .6, 3, 2, k < 8 ? C.bri : C.clr);
      }
      ctx.globalAlpha = 1;
    }
    // 2) o pão: sai do bolso (0.05–0.16), três mordidas (0.16–0.40)
    if (p >= .05 && p < .44) {
      const sobe = suave(entre(p, .05, .16));
      const mao = { x: cp.x + dir * cp.meia * .7, y: cp.pe - cp.alto * .35 };
      let mordidas = p < .2 ? 0 : p < .27 ? 1 : p < .34 ? 2 : 3;
      const tremida = (p > .16 && p < .4) ? Math.sin(p * 220) * 1.5 : 0;
      const x = lerp(mao.x, b.x + dir * 10 * esc / 2, sobe), y = lerp(mao.y, b.y + 4, sobe) + tremida;
      const sumindo = 1 - entre(p, .38, .44);
      ctx.globalAlpha = sumindo; pao(x, y, esc, mordidas, dir, t); ctx.globalAlpha = 1;
      // farelos a cada mordida
      for (const [inicio, s] of [[.2, 1], [.27, 2], [.34, 3]]) {
        const k = (p - inicio) / .12;
        if (k > 0 && k < 1) for (let i = 0; i < (lite ? 5 : 10); i++) {
          const vx = (hsh(i * s + 1) - .3) * 70 * dir, vy = -30 - hsh(i * s * 2) * 50;
          const T = k * .9;
          px(b.x + vx * T, b.y + vy * T + 160 * T * T, esc, esc, i % 3 ? C.pao3 : C.miolo);
        }
      }
    }
    // 3) o arroto de fedor: nuvem verde que estoura da boca (0.38–0.62)
    if (p >= .38 && p < .7) {
      const k = entre(p, .38, .66);
      const n = lite ? 6 : 12;
      for (let i = 0; i < n; i++) {
        const an = (i / n - .5) * 1.6 + (dir > 0 ? 0 : Math.PI), dist = 20 + k * (90 + hsh(i) * 80) * (f >= 4 ? 1.6 : 1);
        nuvem(b.x + Math.cos(an) * dist, b.y + Math.sin(an) * dist * .6 - k * 30, (5 + k * 12 + hsh(i * 3) * 5) * (f >= 4 ? 1.6 : 1), (1 - k) * (1 - k) * .7, i * 1.3);
      }
      // rosto passando mal: ondas verdes em volta da cabeça
      for (let i = 0; i < 4; i++) fedor(b.x - 20 + i * 12, b.y - 10, 30, t * 2, i * 5, (1 - k) * .9);
      uma(m, 'arroto', () => { tocar('nature/poison-cloud', { x: b.x + dir * 30, y: b.y, palette: PAL_CATARRO, duracao: 1.1 }); tocar('status/poisoned', { x: cp.x, y: cp.topo + 10, palette: PAL_CATARRO, duracao: 1.2 }); });
    }
    // 4) junta energia: pontinhos vindo de longe, rachaduras verdes no chão e anéis fechando (0.52–0.8)
    if (p >= .52 && p < .82) {
      const k = entre(p, .52, .8);
      const n = lite ? 16 : 40;
      for (let i = 0; i < n; i++) {
        const an = hsh(i * 2.1) * Math.PI * 2, r = (1 - ((k * 1.6 + hsh(i)) % 1)) * 260;
        ctx.globalAlpha = .9; px(cp.x + Math.cos(an) * r, cp.cy + Math.sin(an) * r * .7, 3, 3, i % 3 ? C.luz : C.bri);
      }
      for (let a = 0; a < 3; a++) {
        const r = (1 - ((k * 2 + a / 3) % 1)) * (cp.meia * 3 + 80);
        ctx.globalAlpha = .7;
        for (let s = 0; s < 48; s++) { const an = s / 48 * Math.PI * 2; px(cp.x + Math.cos(an) * r, cp.cy + Math.sin(an) * r * .55, 3, 3, a === 1 ? C.amarelo2 : C.luz); }
      }
      ctx.globalAlpha = 1;
      // rachaduras
      for (let i = 0; i < 6; i++) { const L = 30 + k * 90 * hsh(i + 2); let x = cp.x, y = cp.pe; const sgn = i % 2 ? 1 : -1; for (let s = 0; s < L; s += 6) { x += sgn * 6; y += (hsh(i * 9 + s) - .5) * 4; px(x, y - 1, 6, 2, s % 12 ? C.clr : C.bri); } }
      uma(m, 'carga', () => tocar('lightning/charge-up', { x: cp.x, y: cp.cy, palette: PAL_CATARRO, duracao: 1.1 }));
      if (f === 2) uma(m, 'carga-ouro', () => tocar('status/rage', { x: cp.x, y: cp.topo, palette: PAL_OURO, duracao: 1.2 }));
    }
    // 5) a explosão da forma nova (0.8–1): clarão, onda de choque, pedras voando
    if (p >= .8) {
      const k = entre(p, .8, 1);
      ctx.globalAlpha = (1 - k) * .75; px(cp.x - 2000, -600, 4000, 2400, k < .2 ? '#f4ffd8' : '#b6dc62'); ctx.globalAlpha = 1;
      const r = 20 + k * 520;
      for (let s = 0; s < 72; s++) { const an = s / 72 * Math.PI * 2; ctx.globalAlpha = 1 - k; px(cp.x + Math.cos(an) * r, cp.cy + Math.sin(an) * r * .5, 6, 4, s % 3 ? C.luz : C.bri); px(cp.x + Math.cos(an) * r * .8, cp.cy + Math.sin(an) * r * .4, 4, 3, C.clr); }
      for (let i = 0; i < (lite ? 8 : 18); i++) { const vx = (hsh(i) - .5) * 520, vy = -180 - hsh(i * 3) * 260, T = k * 1.2; ctx.globalAlpha = 1 - k; px(cp.x + vx * T, cp.pe + vy * T + 400 * T * T, 6, 6, i % 2 ? '#6d5a3c' : C.med); }
      ctx.globalAlpha = 1;
      uma(m, 'explosao', () => {
        tocar('arcane/mana-burst', { x: cp.x, y: cp.cy, palette: f === 2 ? PAL_OURO : PAL_CATARRO });
        tocar('impacts/ground-slam', { x: cp.x, y: cp.pe, palette: PAL_CATARRO, atraso: .08 });
        tocar('explosions/plasma-explosion', { x: cp.x, y: cp.cy - 20, palette: f === 2 ? PAL_OURO : PAL_CATARRO, atraso: .1 });
      });
    }
  }

  /* ---------- catarro (as gosmas que ele cospe) ---------- */
  function catarro(c, s, t) {
    ctx = c;
    const vx = Number(s.vx) || -1, vy = Number(s.vy) || 0, sp = Math.hypot(vx, vy) || 1, ux = vx / sp, uy = vy / sp;
    const seed = (s.seed ??= Math.random() * 100), r = s.damage >= 15 ? 10 : 8;
    const wob = Math.sin(t * 18 + seed);
    // fio de catarro e gotinhas para trás
    for (let i = 1; i <= 4; i++) { const d = i * (r * .9 + 2), q = Math.max(2, r * .55 - i * 1.2); px(s.x - ux * d - q / 2 + Math.sin(t * 9 + i + seed) * 1.5, s.y - uy * d - q / 2, q, q, i % 2 ? C.clr : C.luz); }
    for (let k = 0; k < r * 3; k += 2) px(s.x - ux * k, s.y - uy * k + Math.sin(k * .5 + t * 12) * 1, 1, 1, C.bri);
    // corpo: elipse esticada no sentido do voo
    const rx = r * (1.15 + .12 * wob), ry = r * (.85 - .1 * wob);
    for (let yy = -ry; yy <= ry; yy += 2) {
      const w = rx * Math.sqrt(Math.max(0, 1 - (yy * yy) / (ry * ry)));
      px(s.x - w, s.y + yy, w * 2, 2, Math.abs(yy) > ry - 2.5 ? C.esc2 : C.clr);
      if (w > 3) px(s.x - w + 2, s.y + yy, w * 2 - 4, 2, yy < -ry * .2 ? C.luz : C.clr);
    }
    // pontos amarelos (catarro velho), bolhinha e brilho
    px(s.x + 2, s.y + 1, 3, 2, C.amarelo); px(s.x - 4, s.y - 3, 2, 2, C.amarelo2); px(s.x + r * .3, s.y + r * .3, 2, 2, C.med);
    px(s.x - rx * .45, s.y - ry * .55, 3, 2, C.branco); px(s.x - rx * .45 + 3, s.y - ry * .55 + 2, 1, 1, C.branco);
    return true;
  }

  /* ---------- onda de catarro (anéis de choque com catarro:true) ---------- */
  function onda(c, h, t, lite) {
    ctx = c;
    const chao = (Number(h.y) || 0) + 5, vida = Math.max(0, h.life || 0);
    const grande = h.maxR >= 900;
    const H = grande ? 62 : 42;
    for (const dir of [-1, 1]) {
      const cx = h.x + dir * h.r;
      // rastro molhado no chão
      ctx.save();
      for (let x = h.x; dir > 0 ? x < cx - 10 : x > cx + 10; x += dir * 8) { const fade = Math.abs(x - h.x) / Math.max(1, h.r); ctx.globalAlpha = .35 + .4 * fade; px(x, chao - 4, 8, 3, C.med); if (hsh(x) > .7) px(x + 2, chao - 6, 3, 2, C.luz); }
      ctx.restore();
      // crista: colunas que sobem até a frente da onda e enrolam para a frente
      const N = 14;
      for (let i = 0; i < N; i++) {
        const k = i / (N - 1); // 0 atrás, 1 na frente
        const alt = H * Math.pow(Math.sin(k * Math.PI * .92), 1.4) * (.9 + .1 * Math.sin(t * 20 + i));
        const x = cx - dir * (N - 1 - i) * 5;
        for (let y = 0; y < alt; y += 4) {
          const f = y / Math.max(1, alt);
          px(x - 3, chao - y - 4, 6, 4, f < .3 ? C.esc2 : f < .65 ? C.med : f < .88 ? C.clr : C.luz);
        }
        if (alt > 8) px(x - 3, chao - alt - 4, 6, 3, C.bri); // espuma
      }
      // ponta enrolando
      for (let s = 0; s < 6; s++) { const an = s / 6 * Math.PI * .9; px(cx + dir * (Math.sin(an) * 12), chao - H * .9 - Math.cos(an) * 10 + 4, 5, 4, s < 2 ? C.bri : C.luz); }
      // borrifos e bolhas na frente
      if (!lite) for (let i = 0; i < 8; i++) { const k = (t * 3 + i / 8) % 1; ctx.globalAlpha = 1 - k; px(cx + dir * (6 + k * 34) + (hsh(i) - .5) * 10, chao - H * .8 - k * 30 + k * k * 50, 3, 3, i % 2 ? C.luz : C.amarelo2); }
      ctx.globalAlpha = 1;
      if (!lite) for (let i = 0; i < 3; i++) bolha(cx - dir * (8 + i * 14), chao - H * (.35 + .15 * i) - ((t * 40 + i * 13) % 20), 3, .8);
    }
    if (vida < .3) ctx.globalAlpha = 1;
  }

  window.NikolasFx = Object.freeze({ aura, frente, catarro, onda, PAL: PAL_CATARRO });
})();
