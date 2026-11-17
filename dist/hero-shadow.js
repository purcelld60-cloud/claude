/* Sombra e luz em Da Roça.
   1. Sombra projetada: a silhueta do próprio Da Roça (na pose do quadro) deitada no chão ou na
      plataforma logo abaixo dele, no sentido do sol (comprida de manhã e no fim da tarde, curta ao
      meio-dia, fraca à noite e na chuva). Quando ele pula, a sombra fica no chão, se afasta pelo
      ângulo do sol e clareia.
   2. Sombra sobre ele: ao passar na frente de árvores, casas, quiosques e arquibancadas, a sombra
      deles (registrada pelos mapas em HdMaps.shadeAt) escurece o personagem, com manchas de luz
      passando pelas folhas. Embaixo de plataformas ele também fica na sombra.
   3. Luz do sol no corpo: o lado virado para o sol clareia um pouco e o outro escurece.
   Só aparência: não muda colisão, tempo nem dificuldade. Desligado na qualidade BAIXA. */
(() => {
  'use strict';
  if (window.HeroShadow) return;
  const OUTDOOR = { 0: 1, 1: 1, 3: 1, 4: 1, 5: 1, 7: 1, 9: 1 };
  const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
  const mk = (w, h) => { const c = document.createElement('canvas'); c.width = w; c.height = h; return c; };
  const FW = 260, FH = 240, FX = 130, FY = 210; // quadro do herói: pés em (FX, FY)
  let fig = null, sil = null, layer = null, shadeNow = 0;

  function light(o) {
    if (o.room) return { lean: .12, str: .5, indoor: true };
    if (!OUTDOOR[o.scene] && !o.arena) return { lean: .1, str: .5, indoor: true };
    const s = window.HdMaps?.sun?.() || { lean: .3, str: .8 };
    const rain = window.Weather?.state?.()?.rain || 0, snow = window.Weather?.state?.()?.snow || 0;
    return { lean: s.lean, str: s.str * (1 - rain * .6) * (1 - snow * .3), indoor: false };
  }
  // desenha a figura no quadro de trabalho (pés em FX, FY)
  function paintFigure(o) {
    if (!fig) fig = mk(FW, FH);
    const c = fig.getContext('2d'); c.setTransform(1, 0, 0, 1, 0, 0); c.clearRect(0, 0, FW, FH); c.imageSmoothingEnabled = false;
    o.draw(c, FX, FY);
    return fig;
  }
  function silhouette() {
    if (!sil) sil = mk(FW, FH);
    const c = sil.getContext('2d'); c.globalCompositeOperation = 'source-over'; c.clearRect(0, 0, FW, FH); c.drawImage(fig, 0, 0);
    c.globalCompositeOperation = 'source-in'; c.fillStyle = 'rgb(18,30,52)'; c.fillRect(0, 0, FW, FH); c.globalCompositeOperation = 'source-over';
    return sil;
  }
  // sombra no chão, montada em meia resolução e ampliada 2x (pixels iguais aos do cenário)
  function ground(ctx, o, L) {
    if (o.floor === null || o.floor === undefined) return;
    const h = Math.max(0, o.floor - o.y), fade = clamp(1 - h / 260, .2, 1);
    const k = L.indoor ? L.lean : L.lean * (.4 + .74 * Math.abs(L.lean)), d = L.indoor ? .16 : .14 + .07 * (1 - Math.min(1, Math.abs(L.lean)));
    const a = (L.str > .02 ? .26 + .4 * clamp(L.str, 0, 1) : 0) * fade;
    if (a < .02) return;
    const LWd = 300, LHd = 60; if (!layer) layer = mk(LWd, LHd);
    const g = layer.getContext('2d'); g.setTransform(1, 0, 0, 1, 0, 0); g.clearRect(0, 0, LWd, LHd); g.imageSmoothingEnabled = false;
    // camada cobre o mundo de (x-300, floor-100) a (x+300, floor+20), em meia resolução
    const ox = Math.round((o.x - 300) / 2) * 2, oy = Math.round((o.floor - 100) / 2) * 2;
    const ex = (o.x + k * h - ox) / 2, ey = (o.floor - oy) / 2;
    g.globalAlpha = a; g.setTransform(.5, 0, -k * .5, d * .5, ex, ey); g.drawImage(sil, -FX, -FY);
    // contato com o chão: sombra curtinha e mais escura embaixo dos pés
    g.setTransform(1, 0, 0, 1, 0, 0); g.globalAlpha = a * .9 * clamp(1 - h / 90, 0, 1);
    if (g.globalAlpha > .01) { const cx = (o.x - ox) / 2, w = (o.vehicle ? 30 : 13) * clamp(1 - h / 200, .5, 1); g.fillStyle = 'rgb(18,30,52)'; g.fillRect(Math.round(cx - w), Math.round(ey) - 1, Math.round(w * 2), 2); g.fillRect(Math.round(cx - w * .7), Math.round(ey), Math.round(w * 1.4), 1); }
    g.globalAlpha = 1;
    ctx.save(); ctx.imageSmoothingEnabled = false; ctx.drawImage(layer, ox, oy, LWd * 2, LHd * 2); ctx.restore();
  }
  // quanto de sombra cai em cima do herói agora
  function shadeOn(o, L) {
    let k = 0, leaves = false;
    if (!L.indoor && L.str > .04) { const r = window.HdMaps?.shadeAt?.(o.scene, o.x) || { k: 0 }; k = r.k * Math.min(1, L.str); leaves = r.leaves; }
    // plataforma logo acima: ele passa por baixo e fica na sombra dela
    if (o.platforms) for (const p of o.platforms) { if (o.x < p[0] - 6 || o.x > p[0] + p[2] + 6) continue; const gap = (o.y - 70) - p[1]; if (p[1] < o.y - 40 && gap < 150) { const edge = Math.min(o.x - p[0], p[0] + p[2] - o.x) + 6; k = Math.max(k, (L.indoor ? .4 : .55 * Math.min(1, L.str + .2)) * clamp(edge / 18, 0, 1) * clamp(1 - Math.max(0, gap) / 150, 0, 1)); } }
    return { k: clamp(k, 0, 1), leaves };
  }
  function body(ctx, o, L) {
    const c = fig.getContext('2d'), sh = shadeOn(o, L);
    shadeNow += (sh.k - shadeNow) * .25; // transição suave ao entrar e sair da sombra
    c.save(); c.globalCompositeOperation = 'source-atop';
    // luz do sol no corpo: lado do sol mais claro, lado oposto mais escuro
    if (!L.indoor && L.str > .05) { const side = L.lean >= 0 ? -1 : 1, s = Math.min(1, Math.abs(L.lean) * 1.3 + .25) * Math.min(1, L.str) * (1 - shadeNow);
      const grd = c.createLinearGradient(FX - 22, 0, FX + 22, 0); const lit = `rgba(255,236,190,${.16 * s})`, dark = `rgba(24,30,60,${.2 * s})`;
      grd.addColorStop(0, side < 0 ? lit : dark); grd.addColorStop(.5, 'rgba(0,0,0,0)'); grd.addColorStop(1, side < 0 ? dark : lit); c.fillStyle = grd; c.fillRect(0, 0, FW, FH); }
    if (shadeNow > .02) {
      c.fillStyle = `rgba(18,30,52,${.42 * shadeNow})`; c.fillRect(0, 0, FW, FH);
      // manchas de luz entre as folhas, mexendo com o vento
      if (sh.leaves && shadeNow > .2) { const t = o.time || 0; c.fillStyle = `rgba(255,236,170,${.3 * shadeNow})`;
        for (let i = 0; i < 7; i++) { const x = FX - 20 + ((i * 13 + Math.sin(t * 1.3 + i * 2.1) * 6 + o.x * .15) % 40 + 40) % 40, y = FY - 78 + ((i * 23 + Math.cos(t * .9 + i) * 5) % 74 + 74) % 74; c.fillRect(Math.round(x / 2) * 2, Math.round(y / 2) * 2, 4, 2); c.fillRect(Math.round(x / 2) * 2 + 2, Math.round(y / 2) * 2 + 2, 2, 2); } }
    }
    c.restore();
    ctx.save(); ctx.imageSmoothingEnabled = false; ctx.drawImage(fig, Math.round(o.x) - FX, Math.round(o.y) - FY); ctx.restore();
  }
  /* o: { draw(c, x, y), x, y, floor (y do chão/plataforma embaixo ou null), platforms, scene, time, room, arena, vehicle }
     Devolve true se desenhou o herói (com sombra); false para o jogo desenhar do jeito antigo. */
  function draw(ctx, o) {
    if (!o || typeof o.draw !== 'function' || window.Graphics?.isLite?.()) return false;
    try {
      const L = light(o);
      paintFigure(o); silhouette();
      ground(ctx, o, L);
      body(ctx, o, L);
      return true;
    } catch (e) { window.__heroShadowError = e; return false; }
  }
  window.HeroShadow = Object.freeze({ draw, shade: () => shadeNow });
})();
