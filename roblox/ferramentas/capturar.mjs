// Fotografa a interface do jogo no navegador para o Roblox desenhar igual (o Roblox não tem HTML/CSS).
// Gera, em src/jogo (Luau) e teste/jogo (Lua 5.3):
//   fontes.lua    — as letras das fontes do jogo (Pixel, Space, monospace, Arial) em cada tamanho, com a largura exata;
//   interface.lua — cada elemento visível da página (por chave estável) com posição, a "pele" (fundo, borda, ícones,
//                   sem o texto e sem os filhos) e onde fica o texto; em vários estados (tela inicial, jogando, pausa...)
//                   e em dois modos: pc (teclado e mouse) e toque (celular).
// Uso: com o jogo servido em http://127.0.0.1:8080 → node roblox/ferramentas/capturar.mjs
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
const require = createRequire(import.meta.url);
let chromium;
try { ({ chromium } = require('playwright')); } catch (e) { ({ chromium } = require(path.join(require('child_process').execSync('npm root -g').toString().trim(), 'playwright'))); }
const AQUI = path.dirname(fileURLToPath(import.meta.url)), RAIZ = path.resolve(AQUI, '../..');
const URL0 = process.env.DAROCA_URL || 'http://127.0.0.1:8080/';
const W = 960, H = 540;

// ---------- PNG → RGBA (decodificador mínimo: 8 bits, RGBA, sem entrelaçamento) ----------
function lerPNG(buf) {
  let p = 8, w = 0, h = 0, tipo = 6; const idat = [];
  while (p < buf.length) { const len = buf.readUInt32BE(p), t = buf.toString('ascii', p + 4, p + 8), dados = buf.subarray(p + 8, p + 8 + len);
    if (t === 'IHDR') { w = dados.readUInt32BE(0); h = dados.readUInt32BE(4); tipo = dados[9]; } else if (t === 'IDAT') idat.push(dados); p += 12 + len; }
  // tipo 6 = RGBA, tipo 2 = RGB (o Chromium usa RGB quando a imagem não tem transparência)
  const raw = zlib.inflateSync(Buffer.concat(idat)), bpp = tipo === 2 ? 3 : 4, stride = w * bpp, lin0 = Buffer.alloc(w * h * bpp);
  for (let y = 0; y < h; y++) { const f = raw[y * (stride + 1)], lin = raw.subarray(y * (stride + 1) + 1, (y + 1) * (stride + 1));
    for (let x = 0; x < stride; x++) { const a = x >= bpp ? lin0[y * stride + x - bpp] : 0, b = y > 0 ? lin0[(y - 1) * stride + x] : 0, c = x >= bpp && y > 0 ? lin0[(y - 1) * stride + x - bpp] : 0; let v = lin[x];
      if (f === 1) v += a; else if (f === 2) v += b; else if (f === 3) v += (a + b) >> 1; else if (f === 4) { const pp = a + b - c, pa = Math.abs(pp - a), pb = Math.abs(pp - b), pc = Math.abs(pp - c); v += pa <= pb && pa <= pc ? a : pb <= pc ? b : c; }
      lin0[y * stride + x] = v & 255; } }
  if (bpp === 4) return { w, h, px: lin0 };
  const out = Buffer.alloc(w * h * 4);
  for (let i = 0; i < w * h; i++) { out[i * 4] = lin0[i * 3]; out[i * 4 + 1] = lin0[i * 3 + 1]; out[i * 4 + 2] = lin0[i * 3 + 2]; out[i * 4 + 3] = 255; }
  return { w, h, px: out };
}
// pele em texto compacto: sequências "quantidade*cor" (cor = R+G*256+B*65536+A*16777216 em base 36)
function codificar(img) {
  const partes = []; let ult = -1, n = 0;
  for (let i = 0; i < img.w * img.h; i++) { const q = (x) => Math.min(255, Math.round(x / 6) * 6), a0 = img.px[i * 4 + 3], a = a0 < 6 ? 0 : Math.min(255, Math.round(a0 / 17) * 17), r = q(img.px[i * 4]), g = q(img.px[i * 4 + 1]), b = q(img.px[i * 4 + 2]); const v = a === 0 ? 0 : r + g * 256 + b * 65536 + a * 16777216;
    if (v === ult) n++; else { if (n) partes.push((n > 1 ? n.toString(36) + '*' : '') + ult.toString(36)); ult = v; n = 1; } }
  if (n) partes.push((n > 1 ? n.toString(36) + '*' : '') + ult.toString(36));
  return partes.join(',');
}
// texto em Lua (vale no Lua 5.3 e no Luau): ASCII visível fica, o resto vira \ddd byte a byte
const luaStr = (t) => '"' + [...Buffer.from(String(t), 'utf8')].map((b) => (b >= 32 && b < 127 && b !== 34 && b !== 92 ? String.fromCharCode(b) : '\\' + b)).join('') + '"';
const vazio = (img) => { for (let i = 3; i < img.px.length; i += 4) if (img.px[i] > 8) return false; return true; };
const lua = (v) => (typeof v === 'string' ? luaStr(v) : typeof v === 'number' ? (Number.isFinite(v) ? String(Math.round(v * 100) / 100) : '0') : typeof v === 'boolean' ? String(v) : v == null ? 'nil' : Array.isArray(v) ? '{' + v.map(lua).join(',') + '}' : '{' + Object.entries(v).map(([k, x]) => (/^[A-Za-z_][A-Za-z0-9_]*$/.test(k) ? k : `[${luaStr(k)}]`) + '=' + lua(x)).join(',') + '}');

// ---------- estados da interface ----------
const pularCenas = async (p) => { for (let k = 0; k < 8; k++) { for (const rx of [/NÃO, BORA CONTINUAR/, /Pular história/i]) { const l = p.locator('button:visible', { hasText: rx }).first(); if (await l.count()) { await l.click().catch(() => {}); await p.waitForTimeout(150); } } await p.evaluate(() => { try { Game.skipCutscene?.(); Game.closeDialogue?.(); } catch (e) {} }); await p.waitForTimeout(120); } };
const ESTADOS = [
  { nome: 'inicio', fazer: async (p) => { await p.waitForTimeout(2200); } },
  { nome: 'jogar', fazer: async (p) => { await p.evaluate(() => document.getElementById('menuJogarBtn')?.click()); await p.waitForTimeout(500); } },
  { nome: 'cena', fazer: async (p) => { await p.click('#startBtn').catch(() => {}); await p.waitForTimeout(2500); } },
  { nome: 'jogo', fazer: async (p) => { await pularCenas(p); await p.waitForTimeout(600); } },
  { nome: 'dialogo', fazer: async (p) => { await p.evaluate(() => { try { Game.say?.([{ name: 'Da Roça', text: 'Teste de diálogo para a captura.' }]); } catch (e) {} }); await p.keyboard.press('KeyE'); await p.waitForTimeout(500); } },
  { nome: 'pausa', fazer: async (p) => { await p.evaluate(() => { try { Game.closeDialogue?.(); } catch (e) {} }); await p.keyboard.press('Escape'); await p.waitForTimeout(600); } },
  { nome: 'dados', fazer: async (p) => { await p.keyboard.press('Escape'); await p.waitForTimeout(300); await p.evaluate(() => document.getElementById('statsBtn')?.click()); await p.waitForTimeout(600); } },
];

async function capturarModo(browser, modo) {
  const ctx = await browser.newContext({ viewport: { width: W, height: H }, deviceScaleFactor: 1, hasTouch: modo === 'toque', isMobile: modo === 'toque', userAgent: modo === 'toque' ? 'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 Chrome/120 Mobile Safari/537.36' : undefined });
  const p = await ctx.newPage();
  await p.addInitScript(() => { try { localStorage.setItem('daroca-graphics-v1', 'medium'); } catch (e) {} });
  await p.goto(URL0); await p.waitForTimeout(1500);
  await p.addStyleTag({ content: `.__cap *{visibility:hidden!important;animation:none!important;transition:none!important}.__cap .__alvo{visibility:visible!important;color:transparent!important;text-shadow:none!important;caret-color:transparent!important}.__cap canvas{visibility:hidden!important}.__cap,.__cap body{background:transparent!important;background-color:transparent!important}` });
  const elementos = {}, estados = [];
  for (const est of ESTADOS) {
    await est.fazer(p);
    const lista = await p.evaluate(() => {
      const chave = (el) => { if (el.id) return '#' + el.id; if (el === document.body) return 'body'; if (el === document.documentElement) return 'html'; const pai = el.parentElement; if (!pai) return el.tagName.toLowerCase(); let i = 0; for (const irmao of pai.children) { if (irmao === el) break; if (irmao.tagName === el.tagName) i++; } return chave(pai) + '>' + el.tagName.toLowerCase() + ':' + i; };
      const out = []; let ordem = 0;
      const visto = (el) => { const r = el.getBoundingClientRect(); const cs = getComputedStyle(el); return r.width > 0 && r.height > 0 && cs.visibility !== 'hidden' && cs.display !== 'none' && Number(cs.opacity) > 0.01 && r.right > 0 && r.bottom > 0 && r.left < innerWidth && r.top < innerHeight; };
      const andar = (el, opacPai) => {
        if (['SCRIPT', 'STYLE', 'LINK', 'META', 'HEAD', 'TEMPLATE', 'NOSCRIPT'].includes(el.tagName)) return;
        const cs = getComputedStyle(el); if (cs.display === 'none') { out.push({ k: chave(el), v: false }); return; }
        const op = opacPai * Number(cs.opacity || 1);
        const v = visto(el), r = el.getBoundingClientRect();
        const reg = { k: chave(el), v, o: ordem++, tag: el.tagName.toLowerCase() };
        if (v) {
          Object.assign(reg, { x: r.left, y: r.top, w: r.width, h: r.height, op, z: cs.zIndex === 'auto' ? 0 : Number(cs.zIndex) || 0, pos: cs.position });
          const textos = [];
          for (const n of el.childNodes) if (n.nodeType === 3 && n.textContent.trim()) { const rg = document.createRange(); rg.selectNodeContents(n); const rs = [...rg.getClientRects()].filter((q) => q.width > 0); if (!rs.length) continue; const a = rs[0], b = rs[rs.length - 1];
            textos.push({ x: Math.min(...rs.map((q) => q.left)), y: a.top, w: Math.max(...rs.map((q) => q.right)) - Math.min(...rs.map((q) => q.left)), h: b.bottom - a.top, linhas: rs.length, t: n.textContent }); }
          if (textos.length) Object.assign(reg, { textos, fonte: cs.fontFamily, tam: parseFloat(cs.fontSize), peso: cs.fontWeight, cor: cs.color, alinha: cs.textAlign, maiusc: cs.textTransform === 'uppercase', esp: parseFloat(cs.letterSpacing) || 0, alt: parseFloat(cs.lineHeight) || 0, sombra: cs.textShadow !== 'none' ? cs.textShadow : '' });
          if (el.tagName === 'CANVAS') reg.canvas = true;
          if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') Object.assign(reg, { campo: true, fonte: cs.fontFamily, tam: parseFloat(cs.fontSize), cor: cs.color });
        }
        out.push(reg);
        if (v || cs.display !== 'contents') for (const f of el.children) andar(f, op);
      };
      andar(document.documentElement, 1);
      const sh = document.getElementById('gameShell');
      return { lista: out, assinatura: [...document.body.classList, ...(sh ? [...sh.classList].map((c) => 'shell.' + c) : [])].sort() };
    });
    const vis = {};
    let fotos = 0;
    for (const r of lista.lista) {
      vis[r.k] = r.v;
      if (!r.v || r.canvas) { if (r.v) { const e0 = (elementos[r.k] = elementos[r.k] || { ...r, est: est.nome }); e0.estados = e0.estados || {}; e0.estados[est.nome] = [r.x, r.y, r.w, r.h]; } continue; }
      const ja = elementos[r.k];
      if (ja && ja.pele !== undefined && Math.abs(ja.w - r.w) < 1 && Math.abs(ja.h - r.h) < 1) { ja.estados = ja.estados || {}; ja.estados[est.nome] = [r.x, r.y, r.w, r.h]; continue; }
      // pele: só o próprio elemento (fundo, borda, sombra, ::before/::after), sem texto e sem filhos
      const ok = await p.evaluate((k) => { const ach = (k) => { if (k.startsWith('#')) { const i = k.indexOf('>'); const base = document.getElementById((i < 0 ? k : k.slice(0, i)).slice(1)); if (i < 0) return base; return seguir(base, k.slice(i + 1)); } if (k === 'html') return document.documentElement; if (k === 'body') return document.body; if (k.startsWith('body>')) return seguir(document.body, k.slice(5)); if (k.startsWith('html>')) return seguir(document.documentElement, k.slice(5)); return null; };
        const seguir = (el, resto) => { for (const passo of resto.split('>')) { if (!el) return null; const [tag, n] = passo.split(':'); let i = 0, achou = null; for (const f of el.children) if (f.tagName.toLowerCase() === tag) { if (i === Number(n)) { achou = f; break; } i++; } el = achou; } return el; };
        const el = ach(k); if (!el) return false; document.querySelectorAll('.__alvo').forEach((e) => e.classList.remove('__alvo')); el.classList.add('__alvo'); document.documentElement.classList.add('__cap'); return true; }, r.k);
      if (!ok) continue;
      const clip = { x: Math.max(0, Math.floor(r.x)), y: Math.max(0, Math.floor(r.y)) }; clip.width = Math.min(W, Math.ceil(r.x + r.w)) - clip.x; clip.height = Math.min(H, Math.ceil(r.y + r.h)) - clip.y;
      if (clip.width <= 0 || clip.height <= 0) continue;
      const png = await p.screenshot({ clip, omitBackground: true });
      const img = lerPNG(png);
      if (process.env.DAROCA_DEBUG_KEY === r.k) fs.writeFileSync(path.join(process.env.DAROCA_DEBUG_DIR || '.', `debug-${modo}-${est.nome}.png`), png);
      elementos[r.k] = { ...r, est: est.nome, px: clip.x, py: clip.y, pw: img.w, ph: img.h, pele: vazio(img) ? '' : codificar(img), estados: { ...(ja?.estados || {}), [est.nome]: [r.x, r.y, r.w, r.h] } };
      fotos++;
    }
    await p.evaluate(() => { document.documentElement.classList.remove('__cap'); document.querySelectorAll('.__alvo').forEach((e) => e.classList.remove('__alvo')); });
    estados.push({ nome: est.nome, assinatura: lista.assinatura, vis });
    console.log(`  ${modo}/${est.nome}: ${lista.lista.filter((r) => r.v).length} visíveis, ${fotos} peles novas`);
  }
  // fontes (só uma vez, no modo pc)
  let fontes = null;
  if (modo === 'pc') fontes = await p.evaluate(async () => {
    await document.fonts.ready;
    const letras = [...new Set((String.fromCharCode(...Array.from({ length: 95 }, (_, i) => 32 + i)) + 'ÁÀÂÃÉÊÍÓÔÕÚÜÇáàâãéêíóôõúüçÑñ•·…→←↑↓★☆♥♡✕✖✔✓◆●○■□▶◀▲▼✂ºª°×÷–—“”‘’«»€£¿¡⏱⚡🔥').split(''))];
    const FAM = { pixel: ['Pixel, monospace', [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 24, 26, 28, 32, 36, 40, 48]], space: ['Space, Arial, sans-serif', [9, 10, 11, 12, 13, 14, 16, 18, 20, 24, 28, 32]],
      mono: ['monospace', [8, 9, 10, 11, 12, 13, 14, 16]], arial: ['Arial, sans-serif', [9, 10, 11, 12, 13, 14, 16, 18]] };
    const cv = document.createElement('canvas'); cv.width = 128; cv.height = 128; const c = cv.getContext('2d', { willReadFrequently: true });
    const res = {};
    for (const [nome, [fam, tamanhos]] of Object.entries(FAM)) for (const peso of ['', 'bold ']) { if (peso && nome === 'pixel') continue; const tab = (res[nome + (peso ? 'B' : '')] = {});
      for (const s of tamanhos) { c.font = `${peso}${s}px ${fam}`; const m0 = c.measureText('Hg'); const asc = Math.ceil(m0.fontBoundingBoxAscent || s * .8), desc = Math.ceil(m0.fontBoundingBoxDescent || s * .2); const g = {};
        for (const ch of letras) { const adv = c.measureText(ch).width; c.clearRect(0, 0, 128, 128); c.fillStyle = '#fff'; c.textBaseline = 'alphabetic'; c.fillText(ch, 16, 80); const d = c.getImageData(0, 0, 128, 128).data;
          let x0 = 128, y0 = 128, x1 = -1, y1 = -1; for (let y = 0; y < 128; y++) for (let x = 0; x < 128; x++) if (d[(y * 128 + x) * 4 + 3] > 20) { if (x < x0) x0 = x; if (y < y0) y0 = y; if (x > x1) x1 = x; if (y > y1) y1 = y; }
          if (x1 < 0) { g[ch] = [Math.round(adv * 100) / 100, 0, 0, 0, 0, '']; continue; }
          let bits = ''; for (let y = y0; y <= y1; y++) for (let x = x0; x <= x1; x++) bits += Math.round(d[(y * 128 + x) * 4 + 3] / 17).toString(16);
          g[ch] = [Math.round(adv * 100) / 100, x0 - 16, y0 - 80, x1 - x0 + 1, y1 - y0 + 1, bits.replace(/0+$/, '')]; }
        tab[s] = { asc, desc, g }; } }
    return res;
  });
  await ctx.close();
  return { elementos, estados, fontes };
}

const browser = await chromium.launch();
const pc = await capturarModo(browser, 'pc');
const toque = await capturarModo(browser, 'toque');
await browser.close();

for (const alvo of ['src/jogo', 'teste/jogo']) {
  const pasta = path.join(RAIZ, 'roblox', alvo); fs.mkdirSync(pasta, { recursive: true });
  const cab = alvo === 'src/jogo' ? '--!nocheck\n' : '';
  // fontes
  let f = `${cab}-- letras das fontes do jogo (gerado por ferramentas/capturar.mjs): F[família][tamanho] = {asc, desc, g = {[letra] = {avanço, dx, dy, w, h, alfa em hex}}}\nlocal F = {}\n`;
  for (const [fam, tams] of Object.entries(pc.fontes)) { f += `F.${fam} = {}\n`; for (const [s, t] of Object.entries(tams)) { f += `F.${fam}[${s}] = {asc=${t.asc},desc=${t.desc},g={`; f += Object.entries(t.g).map(([ch, g]) => `[${luaStr(ch)}]={${g.slice(0, 5).join(',')},${luaStr(g[5])}}`).join(','); f += '}}\n'; } }
  fs.writeFileSync(path.join(pasta, 'fontes.lua'), f + 'return F\n');
  // interface: peles compartilhadas (pc e toque), visibilidade por estado ("1" visível, "0" escondido, "-" não existe) e arquivos em partes
  const peles = new Map(); const linhas = [];
  const idPele = (t) => { if (!peles.has(t)) peles.set(t, peles.size + 1); return peles.get(t); };
  for (const [modo, dados] of [['pc', pc], ['toque', toque]]) {
    for (const [k, e] of Object.entries(dados.elementos)) {
      const reg = { x: e.x, y: e.y, w: e.w, h: e.h, o: e.o, z: e.z, op: e.op, tag: e.tag, est: e.est };
      if (e.pele) Object.assign(reg, { px: e.px, py: e.py, pw: e.pw, ph: e.ph, pele: idPele(e.pele) });
      if (e.canvas) reg.canvas = true;
      if (e.textos) Object.assign(reg, { textos: e.textos.map((t) => ({ x: t.x, y: t.y, w: t.w, h: t.h, linhas: t.linhas, t: t.t })), fonte: e.fonte, tam: e.tam, peso: e.peso, cor: e.cor, alinha: e.alinha, maiusc: e.maiusc, esp: e.esp, alt: e.alt, sombra: e.sombra });
      if (e.estados) reg.estados = e.estados;
      if (e.campo) Object.assign(reg, { campo: true, fonte: e.fonte, tam: e.tam, cor: e.cor });
      reg.vis = dados.estados.map((est) => (est.vis[k] === true ? '1' : est.vis[k] === false ? '0' : '-')).join('');
      linhas.push(`I.${modo}[${luaStr(k)}] = ${lua(reg)}`);
    }
    for (const est of dados.estados) linhas.push(`I.estados.${modo}[#I.estados.${modo} + 1] = ${lua({ nome: est.nome, assinatura: est.assinatura })}`);
  }
  for (const [t, id] of peles) linhas.push(`I.peles[${id}] = ${luaStr(t)}`);
  for (const velho of fs.readdirSync(pasta)) if (/^interface(_\d+)?\.lua$/.test(velho)) fs.unlinkSync(path.join(pasta, velho));
  const partes = []; let atual = '';
  for (const l of linhas) { if (atual.length + l.length > 700000 && atual) { partes.push(atual); atual = ''; } atual += l + '\n'; }
  if (atual) partes.push(atual);
  partes.forEach((txt, i) => fs.writeFileSync(path.join(pasta, `interface_${i + 1}.lua`), `${cab}return function(I)\n${txt}end\n`));
  const req = alvo === 'src/jogo' ? (n) => `require(script.Parent.interface_${n})` : (n) => `require("interface_${n}")`;
  fs.writeFileSync(path.join(pasta, 'interface.lua'), `${cab}-- interface do jogo fotografada no navegador (gerado por ferramentas/capturar.mjs)\nlocal I = { pc = {}, toque = {}, estados = { pc = {}, toque = {} }, peles = {} }\n` + partes.map((_, i) => `${req(i + 1)}(I)\n`).join('') + 'return I\n');
}
console.log('fontes.lua e interface.lua gerados');
