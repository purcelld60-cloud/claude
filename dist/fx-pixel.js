/* Da Roça Adventure — ponte com o pixelfx (efeitos de pixel art em código, MIT: Patch e Hugo Duprez; veja vendor/pixelfx-LICENSE.txt).
   - A biblioteca (vendor/pixelfx.js) carrega depois da tela inicial, sem atrasar a abertura.
   - Os efeitos são desenhados em meia resolução (480x270), a mesma densidade de pixel dos personagens, e acompanham a câmera.
   - Golpes do Da Roça (peidão, dash, papel elemental) e ataques de área dos chefes ganham efeitos. No acerto o inimigo continua só piscando.
   API: FxPixel.tocar(id, { x, y, dono, mundo, flip, palette, seed, light, opcoes, seguir }), FxPixel.desenhar(ctx, { dono, camada, camera, tempo }),
        FxPixel.perigo(h, chefe), FxPixel.limpar(dono), FxPixel.pronto(). */
(() => {
  'use strict';
  if (window.FxPixel) return;
  const FW = 480, FH = 270, ESC = 2;
  let lib = null, carregando = null, frame = null, img = null, tela = null, tctx = null;
  const ativos = [], ultimo = Object.create(null);
  const PAL = {
    peido: ['#16200c', '#2e3c14', '#56681e', '#8aa030', '#bcd25a', '#e6f6a0', '#fbffe0'],
    poeira: ['#2a2016', '#4a3a28', '#7a6448', '#a89070', '#d4c0a0', '#f2e8d4'],
    fumaca: ['#121016', '#26222c', '#3e3846', '#5c5466', '#867e8e', '#b2acb8', '#dcd8e0'],
    brasa: ['#1a0a06', '#4a1608', '#8a2a0a', '#d0501a', '#ff8a30', '#ffc870', '#fff0c8'],
    choque: ['#2a1712', '#5e2c1c', '#a4502a', '#e8893a', '#ffc764', '#fff0b4', '#ffffff'],
    tinta: ['#140a1c', '#2c1640', '#4a2a68', '#6e4296', '#9a6ec4', '#c8a4e6', '#f2e4ff'],
    ouro: ['#2a1a06', '#5a3a0a', '#9a6a14', '#d8a028', '#ffd25a', '#fff0a8', '#ffffff'],
    eletrico: ['#06101c', '#0c2a44', '#14507a', '#2a8ac0', '#6ac8f0', '#bff0ff', '#ffffff']
  };

  function carregar() {
    if (lib) return Promise.resolve(lib);
    if (carregando) return carregando;
    carregando = new Promise((ok) => {
      const s = document.createElement('script'); s.src = 'vendor/pixelfx.js?v=1'; s.async = true;
      s.onload = () => { lib = window.PixelFXLib || null; if (lib) { frame = lib.createFrame(FW, FH); tela = document.createElement('canvas'); tela.width = FW; tela.height = FH; tctx = tela.getContext('2d'); img = tctx.createImageData(FW, FH); } ok(lib); };
      s.onerror = () => ok(null); document.head.appendChild(s);
    });
    return carregando;
  }
  // carrega com calma depois que a página abriu
  const agendar = () => setTimeout(() => carregar(), 1200);
  if (document.readyState === 'complete') agendar(); else addEventListener('load', agendar, { once: true });

  const leve = () => !!window.Graphics?.isLite?.();
  const limite = () => (leve() ? 6 : 22);

  function tocar(id, o = {}) {
    if (!lib) { carregar(); return null; }
    const mod = lib.FX[id]; if (!mod) return null;
    const dono = o.dono || 'luta', meus = ativos.filter((a) => a.dono === dono);
    if (meus.length >= limite()) { const velho = meus[0]; ativos.splice(ativos.indexOf(velho), 1); }
    const op = { ...(o.opcoes || {}), seed: o.seed ?? ((Math.random() * 1e6) | 0) };
    if (o.palette) op.palette = o.palette; if (o.flip) op.flip = true; if (o.light !== undefined) op.light = o.light;
    let fx; try { fx = lib.createFx(mod, op); } catch (e) { return null; }
    const a = { fx, dono, mundo: o.mundo !== false, x: o.x || 0, y: o.y || 0, seguir: o.seguir || null, atraso: o.atraso || 0 };
    ativos.push(a); return { parar: () => fx.stop(), get feito() { return fx.done(); } };
  }

  // desenha os efeitos de um dono numa camada ('back' atrás dos personagens, 'front' na frente)
  function desenhar(ctx, o = {}) {
    if (!lib || !ativos.length) return;
    const dono = o.dono || 'luta', camada = o.camada === 'back' ? 'back' : 'front', cam = Number(o.camera) || 0;
    const meus = ativos.filter((a) => a.dono === dono); if (!meus.length) return;
    if (camada === 'back' || o.atualizar) { // o passo do tempo acontece uma vez por quadro (na camada de trás)
      const t = Number(o.tempo); let dt = 1 / 60;
      if (Number.isFinite(t)) { const u = ultimo[dono]; dt = u === undefined ? 1 / 60 : Math.max(0, Math.min(.1, t - u)); ultimo[dono] = t; }
      for (const a of meus) { if (a.atraso > 0) { a.atraso -= dt; continue; } a.fx.update(dt); }
      for (let i = ativos.length - 1; i >= 0; i--) if (ativos[i].dono === dono && ativos[i].fx.done()) ativos.splice(i, 1);
    }
    lib.clearFrame(frame); let algum = false;
    for (const a of meus) {
      if (a.atraso > 0 || a.fx.done()) continue;
      const p = a.seguir ? a.seguir() : a; if (!p) continue;
      a.fx.options.x = Math.round(((a.mundo ? p.x - cam : p.x)) / ESC); a.fx.options.y = Math.round(p.y / ESC);
      try { a.fx.draw(frame, camada); algum = true; } catch (e) { a.fx.stop(); }
    }
    if (!algum) return;
    lib.composite(frame, img.data, null); tctx.putImageData(img, 0, 0);
    ctx.save(); ctx.imageSmoothingEnabled = false; ctx.drawImage(tela, o.mundo === false ? 0 : cam, 0, FW * ESC, FH * ESC); ctx.restore();
  }

  function limpar(dono) { for (let i = ativos.length - 1; i >= 0; i--) if (!dono || ativos[i].dono === dono) ativos.splice(i, 1); if (dono) delete ultimo[dono]; else for (const k in ultimo) delete ultimo[k]; }

  /* ---------- golpes do Da Roça (eventos que o game.js já manda para o CampaignVfx) ---------- */
  function aoEvento(tipo, d) {
    if (!d || !Number.isFinite(d.x) || !Number.isFinite(d.y)) return;
    const dir = d.dir < 0 ? -1 : 1;
    if (tipo === 'gas') { // peidão: nuvem verde que estoura do lado; no combo, mais nuvens
      const st = Math.max(1, Math.min(3, d.stage || 1));
      tocar('spawn/poof', { x: d.x + dir * 18, y: d.y + 22, palette: PAL.peido, flip: dir < 0 });
      if (st >= 2) tocar('spawn/poof', { x: d.x + dir * 70, y: d.y + 26, palette: PAL.peido, atraso: .08 });
      if (st >= 3) { tocar('nature/acid-splash', { x: d.x + dir * 60, y: d.y + 30, palette: PAL.peido, atraso: .12 }); tocar('spawn/poof', { x: d.x + dir * 125, y: d.y + 26, palette: PAL.peido, atraso: .16 }); }
    } else if (tipo === 'dash') { tocar('spawn/poof', { x: d.x - dir * 14, y: d.y + 4, palette: PAL.poeira, flip: dir < 0 }); }
    else if (tipo === 'cast' && !d.kind) { // papel/papaia elemental
      if (d.element === 'fire') tocar('arcane/mana-burst', { x: d.x, y: d.y + 10, palette: PAL.brasa });
      else if (d.element === 'electric') tocar('arcane/mana-burst', { x: d.x, y: d.y + 10, palette: PAL.eletrico });
    } else if (tipo === 'surge') { tocar('explosions/plasma-explosion', { x: d.x, y: d.y + 40, palette: PAL.ouro }); }
  }
  function ligarCampaignVfx() {
    const o = window.CampaignVfx; if (!o || o.__pixel) return false;
    window.CampaignVfx = Object.freeze({ ...o, __pixel: true, emit(tipo, dados) { const r = o.emit(tipo, dados); try { aoEvento(tipo, dados); } catch (e) {} return r; } });
    return true;
  }
  if (!ligarCampaignVfx()) addEventListener('DOMContentLoaded', ligarCampaignVfx, { once: true });

  /* ---------- ataques de área dos chefes: no instante em que o perigo dispara ---------- */
  function perigo(h, chefe) {
    if (!h) return; const x = h.x, y = (h.y || 0) + 8;
    if (h.type === 'astral' || h.astral) tocar('arcane/star-fall', { x, y });
    else if (h.type === 'slime') tocar('nature/acid-splash', { x, y });
    else if (h.type === 'smoke') { tocar('spawn/poof', { x, y, palette: PAL.fumaca }); tocar('explosions/smoke-bomb', { x, y: y + 4, palette: PAL.fumaca, atraso: 0 }); }
    else if (h.ink || h.type === 'ink') tocar('shadow/dark-explosion', { x, y, palette: PAL.tinta });
    else if (h.type === 'provoke') tocar('arcane/magic-circle-cast', { x, y, palette: PAL.ouro });
    else if (h.type === 'ring') tocar('impacts/ground-slam', { x, y, palette: PAL.choque });
    else tocar('nature/quake', { x, y });
  }

  window.FxPixel = Object.freeze({ pronto: () => !!lib, carregar, tocar, desenhar, perigo, limpar, ativos: () => ativos.length, PAL, aoEvento });
})();
