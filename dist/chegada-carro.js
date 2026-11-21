/* Da Roça Adventure — chegada do carro a gás em cada fase.
   Depois do voo no mapa, em vez da tela escura de viagem, o carro chega DENTRO da fase com uma
   animação própria de cada lugar (paraquedas no colégio, derrapagem na quadra, bigode na Bigodon...).
   Dura ~2,3 s; durante ela os controles ficam parados (como na viagem antiga) e no fim o carro
   termina estacionado no começo da fase, do mesmo jeito de antes. Só aparência.
   API (usada pelo game.js): iniciar(cena), ativa(), atualizar(dt), depois(fn), desenhar(ctx, o). */
(() => {
  'use strict';
  if (window.ChegadaCarro) return;
  const DUR = 2.3, FLOOR = 440;
  let ch = null, fila = [];
  const ease = (u) => 1 - Math.pow(1 - Math.max(0, Math.min(1, u)), 3), lerp = (a, b, k) => a + (b - a) * k, clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const hash = (n) => { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return x - Math.floor(x); };
  function iniciar(cena) { ch = { cena: Number(cena) || 0, t: 0, parts: [] }; return true; }
  function ativa() { return !!ch; }
  function depois(fn) { if (typeof fn === 'function') { if (ch) fila.push(fn); else fn(); } }
  function atualizar(dt) { if (!ch) return false; ch.t += dt; for (const p of ch.parts) { p.t += dt; p.x += p.vx * dt; p.y += p.vy * dt; p.vy += (p.g || 0) * dt; } ch.parts = ch.parts.filter((p) => p.t < p.vida);
    if (ch.t >= DUR) { ch = null; const f = fila; fila = []; setTimeout(() => f.forEach((fn) => { try { fn(); } catch (e) {} }), 0); return false; } return true; } // a cutscene de chegada começa logo depois
  const P = (o) => ch.parts.push(Object.assign({ t: 0, vx: 0, vy: 0, g: 0, vida: .8, tam: 3 }, o));
  // cada fase: devolve a posição/rotação/escala do carro e desenha efeitos (atrás e na frente)
  const ANIM = {
    0: (u, x1, y1, t) => { const k = clamp(u / .72, 0, 1), x = lerp(-140, x1, ease(k)), freio = u > .72 && u < .86; // roça: estrada de terra
      if (k < 1 && Math.random() < .7) P({ x: x - 40, y: y1 - 4, vx: -40 - Math.random() * 40, vy: -20 - Math.random() * 20, cor: '#d8c098', vida: .7, tam: 5 + Math.random() * 4 });
      return { x, y: y1 - (k < 1 ? Math.abs(Math.sin(u * 34)) * 3 : 0), rot: freio ? .08 : 0 }; },
    1: (u, x1, y1) => { const k = clamp(u / .8, 0, 1), y = lerp(y1 - 430, y1, ease(k)), sw = Math.sin(u * 14) * .12 * (1 - k); // colégio: paraquedas
      return { x: x1, y, rot: sw, antes: (c) => { if (k >= 1 && u > .92) return; const a = k >= 1 ? 1 - (u - .8) / .2 : 1; c.globalAlpha = clamp(a, 0, 1); const px = x1, py = y - 120;
        for (let i = 0; i < 6; i++) { c.fillStyle = ['#e8433a', '#f6f2ea', '#3c6ab8'][i % 3]; c.beginPath(); c.moveTo(px, py); c.arc(px, py, 58, Math.PI + i * Math.PI / 6, Math.PI + (i + 1) * Math.PI / 6); c.fill(); }
        c.strokeStyle = '#3a3026'; c.lineWidth = 1; for (const dx of [-56, -20, 20, 56]) { c.beginPath(); c.moveTo(px + dx, py); c.lineTo(px + dx * .3, y - 30); c.stroke(); } c.globalAlpha = 1; },
        poeira: k >= 1 && u < .86 }; },
    2: (u, x1, y1, t) => { const k = clamp(u / .4, 0, 1), x = lerp(-140, x1, ease(k)); let sy = 1, dy = 0; // academia: 3 flexões
      if (k >= 1) { const r = ((u - .4) / .6) * 3, f = r % 1; sy = 1 - Math.sin(f * Math.PI) * .22; dy = 0; if (f > .45 && f < .5 && Math.random() < .8) for (let i = 0; i < 3; i++) P({ x: x + 14 + Math.random() * 10, y: y1 - 40, vx: 30 + Math.random() * 40, vy: -80 - Math.random() * 40, g: 400, cor: '#8ad8ff', vida: .6, tam: 3 }); }
      return { x, y: y1 + dy, sy, sx: 2 - sy }; },
    3: (u, x1, y1) => { const k = clamp(u / .8, 0, 1), x = lerp(-100, x1, ease(k)), rot = (1 - ease(k)) * Math.PI * 2; // quadra: derrapagem 360
      if (k < 1) { P({ x: x - 10, y: y1 - 3, vx: 0, vy: 0, cor: '#2a2a30', vida: 1.6, tam: 4, chao: true }); if (Math.random() < .6) P({ x, y: y1 - 10, vx: -30 + Math.random() * 60, vy: -40 - Math.random() * 30, cor: '#e8e8e8', vida: .7, tam: 7 }); }
      return { x, y: y1, rot }; },
    4: (u, x1, y1) => { const k = clamp(u / .7, 0, 1), x = lerp(-140, x1, ease(k)), voo = k < 1 ? (1 - ease(k)) * 60 : 0; // praça: voo baixo e respingo
      if (k >= 1 && u < .74) for (let i = 0; i < 14; i++) P({ x: x + (Math.random() - .5) * 60, y: y1 - 4, vx: (Math.random() - .5) * 160, vy: -120 - Math.random() * 160, g: 600, cor: i % 2 ? '#7ad0f0' : '#d8f2ff', vida: .9, tam: 3 });
      return { x, y: y1 - voo, rot: k < 1 ? -.08 : 0 }; },
    5: (u, x1, y1) => { const k = clamp(u / .85, 0, 1); // favela: pulando de telhado em telhado (3 arcos)
      const seg = Math.min(2, Math.floor(k * 3)), f = k * 3 - seg, xs = [-160, 0, 140, x1], ys = [y1 - 260, y1 - 170, y1 - 80, y1], x = lerp(xs[seg], xs[seg + 1], f), y = lerp(ys[seg], ys[seg + 1], f) - Math.sin(f * Math.PI) * 70;
      if (f < .06 && seg > 0) for (let i = 0; i < 6; i++) P({ x: x + (Math.random() - .5) * 40, y: y - 2, vx: (Math.random() - .5) * 100, vy: -60 - Math.random() * 60, g: 400, cor: i % 2 ? '#c8543a' : '#a87a5a', vida: .6, tam: 3 });
      return { x: k >= 1 ? x1 : x, y: k >= 1 ? y1 : y, rot: k < 1 ? Math.sin(f * Math.PI) * .2 : 0, poeira: k >= 1 && u < .9 }; },
    6: (u, x1, y1, t) => { const a = clamp((u - .45) / .4, 0, 1); // caderno: desenhado a lápis
      return { x: x1, y: y1, alpha: a, antes: (c) => { const n = Math.floor(clamp(u / .5, 0, 1) * 40); c.strokeStyle = '#2a2a3a'; c.lineWidth = 2; c.globalAlpha = 1 - a * .9; c.beginPath();
        for (let i = 0; i < n; i++) { const ang = i * .9, r = 30 + (i % 5) * 4; c.lineTo(x1 + Math.cos(ang) * r * 1.2, y1 - 22 + Math.sin(ang) * r * .5); } c.stroke(); c.globalAlpha = 1;
        if (u < .55) { const lx = x1 + Math.cos(u * 30) * 34, ly = y1 - 22 + Math.sin(u * 30) * 14; c.fillStyle = '#f2c94c'; c.fillRect(lx - 2, ly - 18, 5, 16); c.fillStyle = '#2a2a2a'; c.fillRect(lx - 1, ly - 2, 3, 3); c.fillStyle = '#f6c8c8'; c.fillRect(lx - 2, ly - 21, 5, 3); } } }; },
    7: (u, x1, y1, t) => { const k = clamp(u / .7, 0, 1), x = lerp(-140, x1, ease(k)); // campo: empurrando a bola
      const bx = k < 1 ? x + 46 : x1 + 46 + (u - .7) / .3 * 260, by = k < 1 ? y1 - 8 - Math.abs(Math.sin(u * 20)) * 6 : y1 - 8 - Math.sin(clamp((u - .7) / .3, 0, 1) * Math.PI) * 160;
      if (k >= 1 && u < .74) for (let i = 0; i < 16; i++) P({ x: x1 + (Math.random() - .5) * 80, y: y1 - 80, vx: (Math.random() - .5) * 200, vy: -150 - Math.random() * 100, g: 300, cor: ['#f2c94c', '#3c8a5a', '#e8433a', '#3c6ab8', '#ffffff'][i % 5], vida: 1.4, tam: 3 });
      return { x, y: y1, depois: (c) => { const rr = 7; c.fillStyle = '#1c1c1c'; c.beginPath(); c.arc(bx, by, rr + 1, 0, 7); c.fill(); c.fillStyle = '#f6f6f0'; c.beginPath(); c.arc(bx, by, rr, 0, 7); c.fill(); c.fillStyle = '#1c1c1c'; c.fillRect(bx - 2, by - 2, 4, 4); c.fillRect(bx + 3, by + 2, 2, 2); c.fillRect(bx - 5, by + 1, 2, 2); } }; },
    8: (u, x1, y1, t) => { const a = clamp(u / .35, 0, 1), gira = (1 - ease(clamp(u / .75, 0, 1))) * 6; // bigodon: poste de barbeiro + bigodão no capô
      return { x: x1, y: y1, alpha: a, sx: Math.cos(gira * 3) >= 0 ? 1 : -1, antes: (c) => { if (u > .8) return; c.globalAlpha = clamp(1 - (u - .5) / .3, 0, 1) * .8;
        for (let i = 0; i < 10; i++) { const fase = (u * 4 + i / 10) % 1, yy = y1 - 80 + fase * 80; c.fillStyle = ['#c43c3a', '#f2f2ee', '#2c5a9e'][i % 3]; c.fillRect(x1 - 46, yy, 92, 4); } c.globalAlpha = 1; },
        depois: (c) => { if (u < .55) return; const s = clamp((u - .55) / .2, 0, 1), cx = x1 + 30, cy = y1 - 16; c.fillStyle = '#2a1a12'; for (const l of [-1, 1]) for (let k2 = 0; k2 < 10; k2++) { const q = k2 / 9; c.fillRect(Math.round(cx + l * q * 12 * s), Math.round(cy - Math.sin(q * Math.PI) * 3 + q * q * 2 - (q > .8 ? (q - .8) * 14 : 0)), 2, Math.max(1, Math.round(4 * (1 - q * .6) * s))); } } }; },
    9: (u, x1, y1) => { const k = clamp(u / .85, 0, 1); let y; // pátio: cai e quica como cama elástica
      if (k < .45) y = lerp(y1 - 380, y1, (k / .45) ** 2); else { const f = (k - .45) / .55, b = f < .55 ? Math.sin(f / .55 * Math.PI) * 70 : Math.sin((f - .55) / .45 * Math.PI) * 22; y = y1 - b; }
      if (k > .44 && k < .47) for (let i = 0; i < 14; i++) P({ x: x1 + (Math.random() - .5) * 90, y: y1 - 60, vx: (Math.random() - .5) * 180, vy: -160 - Math.random() * 80, g: 280, cor: ['#e8433a', '#f2c94c', '#3c8a5a', '#3c6ab8', '#e86a8a'][i % 5], vida: 1.3, tam: 4, bandeira: true });
      const sq = k > .44 && k < .52 ? .2 : 0; return { x: x1, y, sy: 1 - sq, sx: 1 + sq }; },
    10: (u, x1, y1, t) => { const k = clamp(u / .85, 0, 1), x = lerp(-120, x1, ease(k)); // rayssa: coraçõezinhos
      if (Math.random() < .25) P({ x: x + (Math.random() - .5) * 50, y: y1 - 50, vx: (Math.random() - .5) * 20, vy: -50, cor: Math.random() < .5 ? '#e86a8a' : '#f29ab8', vida: 1.4, tam: 6, coracao: true });
      return { x, y: y1 - Math.abs(Math.sin(u * 10)) * 2 }; },
    11: (u, x1, y1, t) => { const k = clamp(u / .65, 0, 1), x = lerp(-140, x1, ease(k)); // baile: neon e grave
      return { x, y: y1, antes: (c) => { const cor = Math.floor(t * 6) % 2 ? '#ff3a8a' : '#3af0ff'; c.globalAlpha = .5; c.fillStyle = cor; c.fillRect(x - 44, y1 - 4, 88, 6); c.globalAlpha = .18; c.fillRect(x - 60, y1 - 10, 120, 14);
        if (k >= 1) for (let i = 0; i < 3; i++) { const r = ((u - .65) * 3 + i / 3) % 1; c.globalAlpha = (1 - r) * .6; c.strokeStyle = i % 2 ? '#ff3a8a' : '#3af0ff'; c.lineWidth = 3; c.beginPath(); c.ellipse(x1, y1 - 20, 30 + r * 120, 12 + r * 40, 0, 0, 7); c.stroke(); } c.globalAlpha = 1; } }; }
  };
  function desenhar(ctx, o) {
    if (!ch) return false; const u = clamp(ch.t / DUR, 0, 1), x1 = o.x, y1 = o.y, fn = ANIM[ch.cena] || ANIM[0], a = fn(u, x1, y1, o.time || 0) || {};
    ctx.save();
    for (const p of ch.parts) if (p.chao) { ctx.globalAlpha = Math.max(0, 1 - p.t / p.vida) * .5; ctx.fillStyle = p.cor; ctx.fillRect(Math.round(p.x), Math.round(p.y), p.tam, 2); }
    ctx.globalAlpha = 1; try { a.antes?.(ctx); } catch (e) {}
    if (a.poeira) for (let i = 0; i < 2; i++) ch.parts.push({ x: x1 + (Math.random() - .5) * 70, y: y1 - 4, vx: (Math.random() - .5) * 120, vy: -30 - Math.random() * 30, g: 0, t: 0, vida: .6, tam: 7, cor: '#e8dcc0' });
    ctx.save(); ctx.globalAlpha = a.alpha ?? 1; const px = a.x ?? x1, py = a.y ?? y1; ctx.translate(Math.round(px), Math.round(py - 14)); if (a.rot) ctx.rotate(a.rot); ctx.scale(a.sx ?? 1, a.sy ?? 1); ctx.translate(-Math.round(px), -Math.round(py - 14));
    try { o.pintar?.(ctx, px, py); } catch (e) {} ctx.restore();
    try { a.depois?.(ctx); } catch (e) {}
    for (const p of ch.parts) { if (p.chao) continue; const al = Math.max(0, 1 - p.t / p.vida); ctx.globalAlpha = al; ctx.fillStyle = p.cor;
      if (p.coracao) { const s = 2; ctx.fillRect(p.x - 2 * s, p.y - s, 2 * s, 2 * s); ctx.fillRect(p.x, p.y - s, 2 * s, 2 * s); ctx.fillRect(p.x - s * 1.5, p.y, 3 * s, s * 1.5); ctx.fillRect(p.x - s * .5, p.y + s, s, s); }
      else if (p.bandeira) { ctx.beginPath(); ctx.moveTo(p.x, p.y); ctx.lineTo(p.x + 6, p.y); ctx.lineTo(p.x + 3, p.y + 6); ctx.fill(); }
      else { const tam = p.tam * (p.cor === '#e8dcc0' || p.cor === '#d8c098' || p.cor === '#e8e8e8' ? 1 + p.t * 1.5 : 1); ctx.fillRect(Math.round(p.x - tam / 2), Math.round(p.y - tam / 2), Math.round(tam), Math.round(tam)); } }
    ctx.restore(); return true;
  }
  window.ChegadaCarro = Object.freeze({ iniciar, ativa, atualizar, depois, desenhar, duracao: DUR });
})();
