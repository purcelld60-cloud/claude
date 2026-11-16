/* Carregador de sprites: permite trocar a arte do jogo por imagens PNG sem mexer em código.
   O jogo lê assets/sprites/manifest.json. Se um nome existir lá, a imagem é usada; se não
   existir (ou falhar ao carregar), vale o desenho por código de sempre.
   Especificações e exemplos: docs/SPRITES.md */
(() => {
  'use strict';
  if (window.Sprites) return;
  const BASE = 'assets/sprites/', sheets = new Map();
  let ready = false;
  function add(name, def) {
    if (!def || typeof def.arquivo !== 'string' || /^[a-z]+:|^\/|\.\./i.test(def.arquivo)) return;
    const img = new Image(), entry = { img, ok: false, def };
    img.onload = () => { entry.ok = true; };
    img.src = BASE + def.arquivo;
    sheets.set(name, entry);
  }
  fetch(BASE + 'manifest.json', { cache: 'no-cache' }).then((r) => (r.ok ? r.json() : null)).then((data) => {
    for (const [name, def] of Object.entries(data?.sprites || {})) add(name, def);
    ready = true;
  }).catch(() => { ready = true; });
  const get = (name) => { const e = sheets.get(name); return e && e.ok ? e : null; };
  // Desenha um quadro. Âncora padrão: centro da base (os pés), como os personagens do jogo.
  function draw(c, name, x, y, o = {}) {
    const e = get(name); if (!e) return false;
    const d = e.def, fw = d.quadro?.[0] || e.img.width, fh = d.quadro?.[1] || e.img.height, cols = Math.max(1, Math.floor(e.img.width / fw));
    const frames = d.animacoes?.[o.anim] || d.animacoes?.parado || [0];
    const fps = d.fps || 8, idx = frames[Math.floor((Number(o.time) || 0) * fps) % frames.length] || 0;
    const scale = (d.escala || 2) * (o.scale || 1), ax = d.ancora?.[0] ?? fw / 2, ay = d.ancora?.[1] ?? fh;
    c.save(); c.imageSmoothingEnabled = false; c.translate(Math.round(x), Math.round(y)); c.scale((o.facing < 0 ? -1 : 1) * scale, scale);
    c.drawImage(e.img, (idx % cols) * fw, Math.floor(idx / cols) * fh, fw, fh, -ax, -ay, fw, fh);
    c.restore(); return true;
  }
  window.Sprites = Object.freeze({ get, draw, has: (n) => !!get(n), ready: () => ready });
  // Personagens: "personagem-<tipo>" substitui o desenho por código daquele personagem.
  const art = window.Art;
  if (art && typeof art.drawCharacter === 'function') {
    const original = art.drawCharacter;
    art.drawCharacter = function (c, type, x, y, o = {}) {
      const name = 'personagem-' + type;
      if (sheets.size && get(name)) {
        const anim = o.hit ? 'dano' : (o.attack || o.attacking || o.punch) ? 'ataque' : o.grounded === false ? 'pulo' : o.moving ? 'andar' : 'parado';
        if (draw(c, name, x, y, { anim, time: o.frame, facing: o.facing, scale: o.scale })) return;
      }
      return original.apply(this, arguments);
    };
  }
})();
