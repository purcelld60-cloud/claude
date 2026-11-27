// Gera os módulos de dados que o jogo precisa no Roblox, a partir de dist/:
//   pagina.lua   — o <body> do index.html (menus, HUD, botões) para o navegador simulado montar;
//   arquivos.lua — os JSON que o jogo busca com fetch (roteiros, listas de música, manifesto de sprites);
//   ordem.lua    — a ordem em que os scripts são carregados (a mesma do index.html).
// Uso: node roblox/ferramentas/empacotar.mjs [luau|5.3]
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
const AQUI = path.dirname(fileURLToPath(import.meta.url)), RAIZ = path.resolve(AQUI, '../..'), DIST = path.join(RAIZ, 'dist');
const alvo = process.argv[2] === '5.3' ? '5.3' : 'Luau';
const SAIDA = path.join(RAIZ, 'roblox', alvo === 'Luau' ? 'src/jogo' : 'teste/jogo');
fs.mkdirSync(SAIDA, { recursive: true });
const longa = (t) => { let k = 0; while (t.includes(']' + '='.repeat(k) + ']')) k++; const e = '='.repeat(k); return `[${e}[\n${t}]${e}]`; };
const cab = alvo === 'Luau' ? '--!nocheck\n' : '';
const html = fs.readFileSync(path.join(DIST, 'index.html'), 'utf8');
const corpo = html.slice(html.indexOf('>', html.indexOf('<body')) + 1, html.lastIndexOf('</body>'));
const classeBody = (html.match(/<body[^>]*class="([^"]*)"/) || [])[1] || '';
const titulo = (html.match(/<title>([^<]*)<\/title>/) || [])[1] || 'Da Roça Adventure';
fs.writeFileSync(path.join(SAIDA, 'pagina.lua'), `${cab}-- <body> do dist/index.html (gerado por ferramentas/empacotar.mjs)\nreturn { classe = ${JSON.stringify(classeBody)}, titulo = ${JSON.stringify(titulo)}, html = ${longa(corpo)} }\n`);
// arquivos buscados com fetch
const arquivos = {};
const andar = (dir) => { for (const nome of fs.readdirSync(dir)) { const p = path.join(dir, nome); const rel = path.relative(DIST, p).split(path.sep).join('/');
  if (fs.statSync(p).isDirectory()) { if (!['node_modules', 'musicas', 'music'].includes(nome) || true) andar(p); continue; }
  if (/\.(json|txt)$/.test(nome) && !rel.startsWith('assets/licenses') && fs.statSync(p).size < 400000) arquivos[rel] = fs.readFileSync(p, 'utf8'); } };
andar(DIST);
let lua = `${cab}-- arquivos de dados do jogo para o fetch (gerado por ferramentas/empacotar.mjs)\nlocal A = {}\n`;
for (const [k, v] of Object.entries(arquivos)) lua += `A[${JSON.stringify(k)}] = ${longa(v)}\n`;
fs.writeFileSync(path.join(SAIDA, 'arquivos.lua'), lua + 'return A\n');
// ordem dos scripts
const ordem = [...html.matchAll(/<script[^>]*src="([^"]*)"/g)].map((m) => m[1].replace(/\?.*$/, '')).filter((s) => !s.includes('qrcode'));
const mod = (s) => s.replace(/\.js$/, '').split('/').join('__');
fs.writeFileSync(path.join(SAIDA, 'ordem.lua'), `${cab}-- ordem dos scripts do index.html (gerado por ferramentas/empacotar.mjs)\nreturn {\n${ordem.map((s) => `  { ${JSON.stringify(s)}, ${JSON.stringify(mod(s))} },`).join('\n')}\n}\n`);
console.log(`pagina.lua, arquivos.lua (${Object.keys(arquivos).length} arquivos), ordem.lua (${ordem.length} scripts) → ${path.relative(RAIZ, SAIDA)}`);
