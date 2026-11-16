/* Cinematic finish for cutscenes (realistic/shader graphics). Wraps Cinematics.draw:
   slow push-in and handheld camera, film grain, and for Jorge's epilogue motivated light
   (overhead spot, phone glow, heartbeat pulse, purple storm) plus letterbox bars.
   Only pixels change: shot timing, text and the continuous cutscene audio are untouched. */
(() => {
  'use strict';
  if (!window.Cinematics || window.CinemaFx) return;
  const orig = window.Cinematics.draw;
  const clamp = (v, a = 0, b = 1) => Math.max(a, Math.min(b, v));
  const smooth = (v) => { v = clamp(v); return v * v * (3 - 2 * v); };
  const lite = () => !!window.Graphics?.isLite?.();
  const calm = (() => { try { return matchMedia('(prefers-reduced-motion: reduce)').matches; } catch (e) { return false; } })();
  // Pre-baked grain frames.
  const grainFrames = [];
  for (let f = 0; f < 4; f++) { const g = document.createElement('canvas'); g.width = 240; g.height = 135; const x = g.getContext('2d'), img = x.createImageData(240, 135); for (let i = 0; i < img.data.length; i += 4) { const v = Math.random() * 255; img.data[i] = img.data[i + 1] = img.data[i + 2] = v; img.data[i + 3] = Math.random() < .5 ? 22 : 0; } x.putImageData(img, 0, 0); grainFrames.push(g); }
  const motes = Array.from({ length: 40 }, (_, i) => ({ x: Math.random(), y: Math.random(), s: .3 + Math.random() * .7, p: Math.random() * 6 }));

  function radial(c, x, y, r, color, alpha, mode = 'screen') {
    const g = c.createRadialGradient(x, y, 1, x, y, r); g.addColorStop(0, color.replace('A', alpha)); g.addColorStop(1, color.replace('A', 0));
    c.save(); c.globalCompositeOperation = mode; c.fillStyle = g; c.fillRect(x - r, y - r, r * 2, r * 2); c.restore();
  }
  function spot(c, x, top, bottomW, alpha, t) {
    c.save(); c.globalCompositeOperation = 'screen';
    const g = c.createLinearGradient(0, top, 0, 540); g.addColorStop(0, `rgba(255,226,176,${alpha})`); g.addColorStop(1, 'rgba(255,226,176,0)');
    c.fillStyle = g; c.beginPath(); c.moveTo(x - 40, top); c.lineTo(x + 40, top); c.lineTo(x + bottomW / 2, 540); c.lineTo(x - bottomW / 2, 540); c.closePath(); c.fill();
    for (const m of motes) { const mx = x + (m.x - .5) * bottomW * (.3 + m.y * .7), my = top + ((m.y * 540 + t * 8 * m.s) % 540), a = .25 + .25 * Math.sin(t * 2 + m.p); c.fillStyle = `rgba(255,236,200,${a * alpha * 4})`; c.fillRect(Math.round(mx + Math.sin(t * .7 + m.p) * 6), Math.round(my), 2, 2); }
    c.restore();
  }
  function grain(c, t, strength) { c.save(); c.globalAlpha = strength; c.globalCompositeOperation = 'overlay'; c.imageSmoothingEnabled = false; c.drawImage(grainFrames[Math.floor(t * 24) % 4], 0, 0, 960, 540); c.restore(); }

  function jorgeLight(c, shot, st, dur, total) {
    const k = clamp(st / dur), pulse = .5 + .5 * Math.sin(st * 9);
    switch (shot) {
      case 'afterglow': case 'empty':
        spot(c, 480, -20, 620, .13, total); radial(c, 380, 160, 360, 'rgba(255,190,130,A)', .14, 'soft-light'); radial(c, 640, 320, 360, 'rgba(60,80,160,A)', .2, 'soft-light'); break;
      case 'vibration':
        radial(c, 410, 330, 220, 'rgba(140,170,255,A)', .16 + .18 * Math.abs(Math.sin(st * 22)), 'screen'); break;
      case 'reach':
        radial(c, 620, 330, 260 + 40 * k, 'rgba(140,170,255,A)', .28 * smooth(k * 1.4), 'screen'); break;
      case 'caller':
        radial(c, 482, 280, 340, 'rgba(130,160,255,A)', .3, 'screen'); radial(c, 482, 280, 120, 'rgba(255,255,255,A)', .08 + .05 * pulse, 'screen'); break;
      case 'recognition':
        radial(c, 480, 600, 520, 'rgba(110,150,255,A)', .26, 'screen'); radial(c, 480, 270, 520, 'rgba(10,10,30,A)', .25 * pulse, 'multiply'); break;
      case 'tremor': {
        const beat = Math.max(0, Math.sin(st * 7.5)) ** 6; radial(c, 760, 480, 380, 'rgba(120,150,255,A)', .3, 'screen');
        c.save(); c.globalAlpha = .18 * beat; c.fillStyle = '#3a0010'; c.fillRect(0, 0, 960, 540); c.restore(); break; }
      case 'falling': case 'kneeling':
        spot(c, 470, -40, 380, shot === 'kneeling' ? .1 * (1 - smooth((st - 2.4) / 3.1)) : .12, total);
        radial(c, 722, 470, 160, 'rgba(120,150,255,A)', .22 + .1 * pulse, 'screen'); break;
      case 'eyes': {
        radial(c, 480, 200, 520, 'rgba(150,70,255,A)', .22 + .1 * Math.sin(st * 3), 'screen');
        const flash = (st % 3.3) < .09 || (st % 3.3 > .18 && st % 3.3 < .24);
        if (flash && !calm) { c.save(); c.globalAlpha = .22; c.fillStyle = '#b48cff'; c.fillRect(0, 0, 960, 540); c.restore(); }
        c.save(); c.globalCompositeOperation = 'screen'; for (let i = 0; i < 6; i++) { const y = 420 + i * 18, a = .05 + .03 * Math.sin(st + i); const g = c.createLinearGradient(0, y, 0, y + 40); g.addColorStop(0, `rgba(120,80,180,0)`); g.addColorStop(.5, `rgba(120,80,180,${a})`); g.addColorStop(1, 'rgba(120,80,180,0)'); c.fillStyle = g; c.fillRect(((st * 20 * (i % 2 ? 1 : -1)) % 200) - 200, y, 1400, 40); } c.restore();
        break; }
    }
  }

  function draw(c, s) {
    if (!c || !s || lite()) return orig(c, s);
    const jorge = s.kind === 'jorge_epilogue';
    if (jorge && window.JorgeAnime) { window.JorgeAnime.draw(c, s); c.fillStyle = '#000'; c.fillRect(0, 0, 960, 26); c.fillRect(0, 514, 960, 26); grain(c, Number(s.elapsed) || 0, .45); return; }
    const b = jorge ? window.JorgeEpilogue?.beat?.(s) : null, shot = b?.id, st = Number(s.time) || 0, dur = b?.duration || 8, total = Number(s.elapsed) || st;
    const k = jorge ? clamp(st / dur) : (st % 10) / 10;
    let zoom = 1.012 + (jorge ? .03 : .02) * smooth(k), amp = calm ? 0 : jorge ? (shot === 'tremor' ? 3.2 : shot === 'recognition' ? 2 : 1.1) : .6;
    const hx = (Math.sin(total * 1.3) + Math.sin(total * 2.9) * .5) * amp, hy = (Math.cos(total * 1.1) + Math.sin(total * 3.7) * .4) * amp, rot = amp * .0012 * Math.sin(total * .9);
    const py = jorge ? 220 : 270; c.save(); c.translate(480 + hx, py + hy); c.rotate(rot); c.scale(zoom, zoom); c.translate(-480, -py);
    orig(c, s);
    c.restore();
    if (jorge) {
      jorgeLight(c, shot, st, dur, total);
      const bar = 26; c.fillStyle = '#000'; c.fillRect(0, 0, 960, bar); c.fillRect(0, 540 - bar, 960, bar);
      grain(c, total, .55);
    } else grain(c, total, .3);
  }
  window.Cinematics.draw = draw;
  window.CinemaFx = Object.freeze({ original: orig });
})();
