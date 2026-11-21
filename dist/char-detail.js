/* Character finish pass for the realistic graphics mode.
   Every character keeps its original drawing (identity, clothes, colours, proportions);
   this only adds a 1px pixel-art outline, a top rim light, a lower edge shadow and a soft
   head-to-feet light falloff. Light mode, very large bosses and tiny portraits skip it. */
(() => {
  'use strict';
  if (!window.Art || !window.Art.drawCharacter || window.CharDetail) return;
  const original = window.Art.drawCharacter;
  const W = 200, H = 230, OX = 100, OY = 196; // buffer covers x -100..100, y -196..34 around the feet
  const make = () => { const c = document.createElement('canvas'); c.width = W; c.height = H; const x = c.getContext('2d'); x.imageSmoothingEnabled = false; return [c, x]; };
  const [spriteC, sprite] = make(), [tintC, tint] = make(), [outC, out] = make();
  const SKIP = new Set(['giant', 'dede']);
  let enabled = true;
  const CACHE = new Map();

  function tinted(color) {
    tint.globalCompositeOperation = 'source-over'; tint.clearRect(0, 0, W, H);
    tint.drawImage(spriteC, 0, 0);
    tint.globalCompositeOperation = 'source-in'; tint.fillStyle = color; tint.fillRect(0, 0, W, H);
    tint.globalCompositeOperation = 'source-over';
    return tintC;
  }

  function detailed(c, type, x, y, o = {}) {
    if (!enabled || window.Graphics?.isLite?.() || SKIP.has(type) || (type === 'nikolas' && Number(o.bossPhase) >= 2) || (type === 'reeisBoss') || (o.transformed && type === 'reeis')) return original(c, type, x, y, o);
    let m; try { m = c.getTransform(); } catch (e) { return original(c, type, x, y, o); }
    const scale = Math.hypot(m.a, m.b) * (o.scale || 1);
    // Skip tiny renders (HUD portraits) and anything far off the visible canvas.
    if (scale < .55) return original(c, type, x, y, o);
    const sx = m.a * x + m.c * y + m.e, cw = c.canvas?.width || 960;
    if (sx < -260 || sx > cw + 260) return;
    if ((o.scale || 1) > 1.25) return original(c, type, x, y, o);
    // Personagens de fundo (o.cache): guarda o resultado pronto por pose e reaproveita — 1 desenho em vez de ~12 por quadro.
    const ck = o.cache && Math.abs(m.a - 1) < .01 && Math.abs(m.d - 1) < .01 && !m.b && !m.c && !o.hit ? type + '|' + ((o.facing || 1) < 0 ? -1 : 1) + '|' + (((Math.floor((o.frame || 0) * 3) % 6) + 6) % 6) + '|' + (o.scale || 1) : null;
    if (ck) { const hit = CACHE.get(ck); if (hit) { c.save(); c.imageSmoothingEnabled = false; c.drawImage(hit.cv, Math.round(x) - OX + hit.x0, Math.round(y) - OY + hit.y0); c.restore(); return; } o = { ...o, frame: Math.floor((o.frame || 0) * 3) / 3 }; }

    sprite.setTransform(1, 0, 0, 1, 0, 0); sprite.globalAlpha = 1; sprite.globalCompositeOperation = 'source-over';
    sprite.clearRect(0, 0, W, H);
    original(sprite, type, OX, OY, o);

    // Light falloff: brighter head, deeper legs (only on the character's own pixels).
    sprite.globalCompositeOperation = 'source-atop';
    const g = sprite.createLinearGradient(0, OY - 110, 0, OY);
    g.addColorStop(0, 'rgba(255,244,214,.10)'); g.addColorStop(.45, 'rgba(0,0,0,0)'); g.addColorStop(1, 'rgba(24,18,28,.20)');
    sprite.fillStyle = g; sprite.fillRect(0, 0, W, H);
    // Soft volume (deliberately smooth, on top of the pixel art): key light from the front-top,
    // a cool falloff on the back.
    const face = (o.facing || 1) < 0 ? -1 : 1;
    const key = sprite.createRadialGradient(OX + face * 16, OY - 96, 4, OX + face * 16, OY - 96, 92);
    key.addColorStop(0, 'rgba(255,238,204,.24)'); key.addColorStop(.55, 'rgba(255,230,190,.07)'); key.addColorStop(1, 'rgba(255,230,190,0)');
    sprite.fillStyle = key; sprite.fillRect(0, 0, W, H);
    const back = sprite.createLinearGradient(OX - face * 26, 0, OX + face * 6, 0);
    back.addColorStop(0, 'rgba(18,14,34,.26)'); back.addColorStop(1, 'rgba(18,14,34,0)');
    sprite.fillStyle = back; sprite.fillRect(0, 0, W, H);
    sprite.globalCompositeOperation = 'source-over';

    out.globalCompositeOperation = 'source-over'; out.clearRect(0, 0, W, H);
    { const cs = out.createRadialGradient(OX, OY, 2, OX, OY, 30); cs.addColorStop(0, 'rgba(10,12,8,.32)'); cs.addColorStop(1, 'rgba(10,12,8,0)'); out.save(); out.translate(0, OY); out.scale(1, .22); out.translate(0, -OY); out.fillStyle = cs; out.fillRect(OX - 32, OY - 32, 64, 64); out.restore(); }
    // 1px outline behind the silhouette.
    const ink = tinted('#1b1714');
    out.globalAlpha = .9; out.drawImage(ink, -1, 0); out.drawImage(ink, 1, 0); out.drawImage(ink, 0, -1); out.drawImage(ink, 0, 1); out.globalAlpha = 1;
    out.drawImage(spriteC, 0, 0);
    // Rim light on top/sun side: silhouette minus itself shifted down-right.
    const rim = tinted('#fff3cf');
    tint.globalCompositeOperation = 'destination-out'; tint.drawImage(spriteC, 0, 2); tint.globalCompositeOperation = 'source-over';
    out.globalAlpha = .38; out.drawImage(rim, 0, 0);
    // Core shadow on the lower/back edge.
    const sh = tinted('#120c18');
    tint.globalCompositeOperation = 'destination-out'; tint.drawImage(spriteC, 0, -2); tint.globalCompositeOperation = 'source-over';
    out.globalAlpha = .32; out.drawImage(sh, 0, 0); out.globalAlpha = 1;

    c.save(); c.imageSmoothingEnabled = false; c.drawImage(outC, Math.round(x) - OX, Math.round(y) - OY); c.restore();
    if (ck) { try { const d = out.getImageData(0, 0, W, H).data; let x0 = W, y0 = H, x1 = -1, y1 = -1; for (let yy = 0; yy < H; yy++) for (let xx = 0; xx < W; xx++) if (d[(yy * W + xx) * 4 + 3] > 8) { if (xx < x0) x0 = xx; if (xx > x1) x1 = xx; if (yy < y0) y0 = yy; if (yy > y1) y1 = yy; }
      if (x1 >= x0) { const cv = document.createElement('canvas'); cv.width = x1 - x0 + 1; cv.height = y1 - y0 + 1; cv.getContext('2d').drawImage(outC, -x0, -y0); CACHE.set(ck, { cv, x0, y0 }); if (CACHE.size > 260) CACHE.delete(CACHE.keys().next().value); } } catch (e) {} }
  }

  window.Art.drawCharacter = detailed;
  window.CharDetail = Object.freeze({ setEnabled: (v) => { enabled = !!v; }, original });
})();
