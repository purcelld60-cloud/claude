// Converte o código do jogo (dist/*.js) para Lua/Luau sem mudar a lógica nem o desenho.
// O jogo é JavaScript sem tipos; o TypeScriptToLua (MIT) traduz bem a sintaxe, mas precisa de tipos para saber o que é
// lista, texto ou número. Por isso, antes dele, este conversor troca o que depende de tipo por funções do runtime
// (roblox/src/runtime/js.lua) que seguem exatamente a regra do JavaScript:
//   - verdade do JS (0, '' e NaN são falsos) em toda condição, || e &&;
//   - listas: x[i] → __get/__set (o JS conta do 0, o Lua do 1), [a, b] → __arr(a, b), x.length → __len(x),
//     métodos de lista/texto/número (map, push, split, toFixed...) → __call(x, "nome", ...);
//   - a + b → __add(a, b) quando os tipos não são conhecidos (no JS, "a" + 1 junta texto);
//   - bits de 32 bits, expressões regulares do jogo, Map/Set/WeakMap, Object.keys/assign/entries, Array.from/isArray,
//     for...of, objetos com "get", Object.freeze e Math.hypot.
// Uso: node roblox/ferramentas/converter.mjs [luau|5.3] [arquivos dentro de dist/...]
import ts from 'typescript';
import tstl from 'typescript-to-lua';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const AQUI = path.dirname(fileURLToPath(import.meta.url)), RAIZ = path.resolve(AQUI, '../..');
const alvo = process.argv[2] === '5.3' ? '5.3' : 'Luau'; // 5.3 para testar fora do Roblox; Luau para o Roblox
const SAIDA = path.join(RAIZ, 'roblox', alvo === 'Luau' ? 'src/jogo' : 'teste/jogo');
const TMP = path.join(RAIZ, 'roblox', '.conversao');
const arquivos = process.argv.slice(3).length ? process.argv.slice(3) : ['art.js', 'campanha2/personagens.js'];

const K = ts.SyntaxKind;
const BOOL = new Set([K.EqualsEqualsEqualsToken, K.ExclamationEqualsEqualsToken, K.EqualsEqualsToken, K.ExclamationEqualsToken, K.LessThanToken, K.LessThanEqualsToken, K.GreaterThanToken, K.GreaterThanEqualsToken, K.InstanceOfKeyword, K.InKeyword]);
const BITS = { [K.BarToken]: '__bor', [K.AmpersandToken]: '__band', [K.CaretToken]: '__bxor', [K.LessThanLessThanToken]: '__shl', [K.GreaterThanGreaterThanToken]: '__shr', [K.GreaterThanGreaterThanGreaterThanToken]: '__ushr' };
const COMPOSTO = { [K.PlusEqualsToken]: K.PlusToken, [K.MinusEqualsToken]: K.MinusToken, [K.AsteriskEqualsToken]: K.AsteriskToken, [K.SlashEqualsToken]: K.SlashToken, [K.PercentEqualsToken]: K.PercentToken, [K.AsteriskAsteriskEqualsToken]: K.AsteriskAsteriskToken,
  [K.BarEqualsToken]: K.BarToken, [K.AmpersandEqualsToken]: K.AmpersandToken, [K.CaretEqualsToken]: K.CaretToken, [K.LessThanLessThanEqualsToken]: K.LessThanLessThanToken, [K.GreaterThanGreaterThanEqualsToken]: K.GreaterThanGreaterThanToken, [K.GreaterThanGreaterThanGreaterThanEqualsToken]: K.GreaterThanGreaterThanGreaterThanToken };
// métodos que dependem do tipo (lista, texto, número, Map/Set): o runtime decide na hora
const METODOS = new Set(('push pop shift unshift slice splice map filter forEach reduce reduceRight some every find findIndex findLast findLastIndex indexOf lastIndexOf includes join concat sort reverse fill flat flatMap at ' +
  'keys values entries split substring substr startsWith endsWith toUpperCase toLowerCase trim trimStart trimEnd padStart padEnd repeat replace replaceAll charAt charCodeAt codePointAt toFixed toString localeCompare normalize ' +
  'get set has add delete clear match search hasOwnProperty toLocaleString toPrecision valueOf').split(' '));
const GLOBAIS_FIXOS = new Set(['Math', 'Object', 'Array', 'JSON', 'Number', 'String', 'console', 'Promise', 'Date', 'Symbol', 'Reflect']);
const NEW_RUNTIME = new Set(['Date', 'ArrayBuffer', 'MouseEvent', 'PointerEvent', 'Worker', 'OffscreenCanvas', 'Image', 'Audio', 'WebSocket', 'ResizeObserver', 'IntersectionObserver', 'BroadcastChannel', 'CustomEvent', 'KeyboardEvent', 'Event', 'ImageData',
  'Uint8Array', 'Uint8ClampedArray', 'Int16Array', 'Int32Array', 'Uint16Array', 'Uint32Array', 'Float32Array', 'Float64Array', 'Array', 'AudioContext', 'OfflineAudioContext', 'DOMMatrix', 'Path2D', 'FontFace', 'MutationObserver', 'URLSearchParams', 'URL', 'Blob', 'FileReader', 'TextEncoder', 'TextDecoder', 'AbortController']);
const AJUDANTES = ['__fbind', '__newExpr', '__hasOwnV', '__sliceV', '__forEachV', '__mapV', '__filterV', '__indexOfV', '__pushV', '__toStringV', '__NumberV', '__StringV', '__BooleanV', '__identV', '__fcall', '__fapply', '__lt', '__le', '__gt', '__ge', '__isFiniteV', '__isIntegerV', '__isNaNV', '__imul', '__cbrt', '__objCreate', '__getProto', '__defProp', '__defProps', '__defPropV', '__isSafeInteger', '__isFiniteN', '__isInteger', '__getq', '__lenq', '__callq', '__mod', '__pk', '__ord', '__arrL', '__fromCharCode', '__iterar', '__t', '__get', '__set', '__inc', '__del', '__arr', '__len', '__setlen', '__call', '__add', '__new', '__iter', '__keys', '__values', '__entries', '__assign', '__isArray', '__arrayFrom', '__arrayOf',
  '__bor', '__band', '__bxor', '__shl', '__shr', '__ushr', '__bnot', '__hypot', '__getters', '__re', '__re_test', '__re_replace', '__re_split', '__re_match', '__re_exec'];


// ===== pré-passo (texto → texto): "var" içado para o topo da função e laços com rótulo (break/continue rótulo) =====
const ehLaco = (n) => ts.isForStatement(n) || ts.isForInStatement(n) || ts.isForOfStatement(n) || ts.isWhileStatement(n) || ts.isDoStatement(n);
const prePasso = (ctx) => {
  const f = ctx.factory;
  let nRot = 0;
  // nomes declarados com var dentro de um corpo (sem entrar em funções internas)
  const varsDe = (corpo) => { const nomes = []; const v = (n) => { if (ts.isFunctionLike(n) && n !== corpo) return;
      if (ts.isVariableDeclarationList(n) && !(n.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))) for (const d of n.declarations) { const junta = (b) => { if (ts.isIdentifier(b)) nomes.push(b.text); else for (const e of b.elements) if (!ts.isOmittedExpression(e)) junta(e.name); }; junta(d.name); }
      ts.forEachChild(n, v); }; ts.forEachChild(corpo, v); return [...new Set(nomes)]; };
  const semVar = (n) => {
    if (ts.isVariableStatement(n) && !(n.declarationList.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))) {
      const ats = n.declarationList.declarations.filter((d) => d.initializer).map((d) => f.createAssignment(d.name, ts.visitNode(d.initializer, visitar)));
      if (!ats.length) return f.createEmptyStatement();
      return f.createExpressionStatement(ats.reduce((a, b) => f.createComma(a, b)));
    }
    if ((ts.isForStatement(n)) && n.initializer && ts.isVariableDeclarationList(n.initializer) && !(n.initializer.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))) {
      const ats = n.initializer.declarations.filter((d) => d.initializer).map((d) => f.createAssignment(d.name, ts.visitNode(d.initializer, visitar)));
      return f.updateForStatement(n, ats.length ? ats.reduce((a, b) => f.createComma(a, b)) : undefined, ts.visitNode(n.condition, visitar), ts.visitNode(n.incrementor, visitar), ts.visitNode(n.statement, visitar));
    }
    if ((ts.isForInStatement(n) || ts.isForOfStatement(n)) && ts.isVariableDeclarationList(n.initializer) && !(n.initializer.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))) {
      const nome = n.initializer.declarations[0].name;
      return ts.isForInStatement(n) ? f.updateForInStatement(n, nome, ts.visitNode(n.expression, visitar), ts.visitNode(n.statement, visitar))
        : f.updateForOfStatement(n, n.awaitModifier, nome, ts.visitNode(n.expression, visitar), ts.visitNode(n.statement, visitar));
    }
    return null;
  };
  const comLets = (stmts, nomes) => nomes.length ? [f.createVariableStatement(undefined, f.createVariableDeclarationList(nomes.map((x) => f.createVariableDeclaration(x)), ts.NodeFlags.Let)), ...stmts] : stmts;
  // laço com rótulo: break/continue rótulo viram bandeira + break
  const rotulo = (n) => {
    const nome = n.label.text, laco = n.statement;
    if (!ehLaco(laco)) return ts.visitEachChild(n, visitar, ctx); // bloco rotulado: raro, deixa como está
    const flag = '__rot' + (++nRot) + '_' + nome;
    let usaFlag = false;
    // reescreve o corpo do laço
    const trocar = (no, prof) => { // prof = quantos laços/switch existem entre "no" e o laço rotulado
      if (ts.isFunctionLike(no)) return no;
      if ((ts.isBreakStatement(no) || ts.isContinueStatement(no)) && no.label && no.label.text === nome) {
        const ehCont = ts.isContinueStatement(no);
        if (prof === 0) return ehCont ? f.createContinueStatement() : f.createBreakStatement();
        usaFlag = true;
        return f.createBlock([f.createExpressionStatement(f.createAssignment(f.createIdentifier(flag), f.createNumericLiteral(ehCont ? 2 : 1))), f.createBreakStatement()], false);
      }
      const dentro = ehLaco(no) || ts.isSwitchStatement(no);
      const novo = ts.visitEachChild(no, (c) => trocar(c, dentro ? prof + 1 : prof), ctx);
      return novo;
    };
    // depois de cada laço/switch interno que contém o salto, confere a bandeira
    const conferir = (no, prof) => {
      if (ts.isFunctionLike(no)) return no;
      if (ts.isBlock(no) || ts.isSourceFile(no) || ts.isCaseClause(no) || ts.isDefaultClause(no)) {
        const out = [];
        for (const st of (no.statements)) {
          const dentro = ehLaco(st) || ts.isSwitchStatement(st) || ts.isLabeledStatement(st);
          out.push(conferir(st, prof));
          if (dentro && usaFlag) {
            const id = f.createIdentifier(flag);
            if (prof === 0) {
              out.push(f.createIfStatement(f.createStrictEquality(id, f.createNumericLiteral(1)), f.createBreakStatement()));
              out.push(f.createIfStatement(f.createStrictEquality(f.createIdentifier(flag), f.createNumericLiteral(2)), f.createBlock([f.createExpressionStatement(f.createAssignment(f.createIdentifier(flag), f.createNumericLiteral(0))), f.createContinueStatement()], true)));
            } else out.push(f.createIfStatement(f.createBinaryExpression(id, K.GreaterThanToken, f.createNumericLiteral(0)), f.createBreakStatement()));
          }
        }
        if (ts.isBlock(no)) return f.updateBlock(no, out);
        if (ts.isCaseClause(no)) return f.updateCaseClause(no, no.expression, out);
        if (ts.isDefaultClause(no)) return f.updateDefaultClause(no, out);
        return no;
      }
      const dentro = ehLaco(no) || ts.isSwitchStatement(no);
      return ts.visitEachChild(no, (c) => conferir(c, dentro ? prof + 1 : prof), ctx);
    };
    let corpo = trocar(laco.statement, 0);
    if (!ts.isBlock(corpo)) corpo = f.createBlock([corpo], true);
    if (usaFlag) corpo = conferir(corpo, 0);
    let novoLaco;
    if (ts.isForStatement(laco)) novoLaco = f.updateForStatement(laco, laco.initializer, laco.condition, laco.incrementor, corpo);
    else if (ts.isForOfStatement(laco)) novoLaco = f.updateForOfStatement(laco, laco.awaitModifier, laco.initializer, laco.expression, corpo);
    else if (ts.isForInStatement(laco)) novoLaco = f.updateForInStatement(laco, laco.initializer, laco.expression, corpo);
    else if (ts.isWhileStatement(laco)) novoLaco = f.updateWhileStatement(laco, laco.expression, corpo);
    else novoLaco = f.updateDoStatement(laco, corpo, laco.expression);
    novoLaco = ts.visitNode(novoLaco, visitar);
    if (!usaFlag) return novoLaco;
    return [f.createVariableStatement(undefined, f.createVariableDeclarationList([f.createVariableDeclaration(flag, undefined, undefined, f.createNumericLiteral(0))], ts.NodeFlags.Let)), novoLaco];
  };
  // funções que usam "arguments": parâmetros viram ...__args e são lidos da lista
  const usaArguments = (fn) => { let usa = false; const v = (n) => { if (usa) return; if (n !== fn && ts.isFunctionLike(n) && !ts.isArrowFunction(n)) return; if (ts.isIdentifier(n) && n.text === 'arguments') usa = true; ts.forEachChild(n, v); }; ts.forEachChild(fn, v); return usa; };
  const trocarArguments = (no) => { const v = (n) => { if (ts.isFunctionLike(n) && !ts.isArrowFunction(n)) return n; if (ts.isIdentifier(n) && n.text === 'arguments') return f.createIdentifier('__args'); return ts.visitEachChild(n, v, ctx); }; return ts.visitEachChild(no, v, ctx); };
  const visitar = (n) => {
    if ((ts.isFunctionDeclaration(n) || ts.isFunctionExpression(n) || ts.isMethodDeclaration(n)) && n.body && usaArguments(n)) {
      const pad = n.parameters.length ? [f.createVariableStatement(undefined, f.createVariableDeclarationList([f.createVariableDeclaration(f.createArrayBindingPattern(n.parameters.map((p) => f.createBindingElement(p.dotDotDotToken, undefined, p.name, p.initializer))), undefined, undefined, f.createIdentifier('__args'))], ts.NodeFlags.Let))] : [];
      const corpo = f.updateBlock(n.body, [...pad, ...trocarArguments(n.body).statements]);
      const params = [f.createParameterDeclaration(undefined, f.createToken(K.DotDotDotToken), '__args')];
      let novo;
      if (ts.isFunctionDeclaration(n)) novo = f.updateFunctionDeclaration(n, n.modifiers, n.asteriskToken, n.name, n.typeParameters, params, n.type, corpo);
      else if (ts.isFunctionExpression(n)) novo = f.updateFunctionExpression(n, n.modifiers, n.asteriskToken, n.name, n.typeParameters, params, n.type, corpo);
      else novo = f.updateMethodDeclaration(n, n.modifiers, n.asteriskToken, n.name, n.questionToken, n.typeParameters, params, n.type, corpo);
      return visitar(novo);
    }
    if (ts.isLabeledStatement(n)) return rotulo(n);
    const sv = semVar(n); if (sv) return sv;
    if ((ts.isFunctionDeclaration(n) || ts.isFunctionExpression(n) || ts.isArrowFunction(n) || ts.isMethodDeclaration(n) || ts.isGetAccessor(n) || ts.isSetAccessor(n) || ts.isConstructorDeclaration(n)) && n.body && ts.isBlock(n.body)) {
      const nomes = varsDe(n.body);
      const corpo = f.updateBlock(n.body, comLets(ts.visitNodes(n.body.statements, visitar), nomes));
      if (ts.isFunctionDeclaration(n)) return f.updateFunctionDeclaration(n, n.modifiers, n.asteriskToken, n.name, n.typeParameters, ts.visitNodes(n.parameters, visitar), n.type, corpo);
      if (ts.isFunctionExpression(n)) return f.updateFunctionExpression(n, n.modifiers, n.asteriskToken, n.name, n.typeParameters, ts.visitNodes(n.parameters, visitar), n.type, corpo);
      if (ts.isArrowFunction(n)) return f.updateArrowFunction(n, n.modifiers, n.typeParameters, ts.visitNodes(n.parameters, visitar), n.type, n.equalsGreaterThanToken, corpo);
      if (ts.isMethodDeclaration(n)) return f.updateMethodDeclaration(n, n.modifiers, n.asteriskToken, n.name, n.questionToken, n.typeParameters, ts.visitNodes(n.parameters, visitar), n.type, corpo);
      if (ts.isGetAccessor(n)) return f.updateGetAccessorDeclaration(n, n.modifiers, n.name, ts.visitNodes(n.parameters, visitar), n.type, corpo);
      if (ts.isSetAccessor(n)) return f.updateSetAccessorDeclaration(n, n.modifiers, n.name, ts.visitNodes(n.parameters, visitar), corpo);
      return f.updateConstructorDeclaration(n, n.modifiers, ts.visitNodes(n.parameters, visitar), corpo);
    }
    return ts.visitEachChild(n, visitar, ctx);
  };
  return (sf) => { const nomes = varsDe(sf); return f.updateSourceFile(sf, comLets(ts.visitNodes(sf.statements, visitar), nomes)); };
};

let tmpN = 0;
// globais que o TypeScriptToLua já entende; o resto (document, HdMaps, localStorage...) vira window.X, como no navegador
const MANTER = new Set(['Math', 'Number', 'String', 'Object', 'Array', 'Symbol', 'Promise', 'Map', 'Set', 'WeakMap', 'WeakSet', 'Error', 'TypeError', 'RangeError', 'SyntaxError', 'ReferenceError', 'EvalError',
  'NaN', 'Infinity', 'undefined', 'parseInt', 'parseFloat', 'isNaN', 'isFinite', 'arguments', 'window', 'Reflect', 'BigInt'].concat(AJUDANTES));
const ehLib = (d) => { const f = d.getSourceFile(); return f.hasNoDefaultLib || /[\\/]typescript[\\/]lib[\\/]/.test(f.fileName); };
const fabrica = (checker) => (ctx) => {
  const f = ctx.factory;
  // o Lua aceita no máximo 200 variáveis locais por função: escopos com declarações demais guardam tudo numa tabela (__L1.nome)
  const derramar = new Map(), escopos = new Map(); let nEsc = 0;
  const contarDecl = (b) => { let k = 0; for (const st of b.statements) { if (ts.isVariableStatement(st)) for (const d of st.declarationList.declarations) k += ts.isIdentifier(d.name) ? 1 : 3; else if (ts.isFunctionDeclaration(st) || ts.isClassDeclaration(st)) k++; } return k; };
  const procurar = (n) => {
    if (ts.isSourceFile(n) || (ts.isBlock(n) && n.parent && ts.isFunctionLike(n.parent))) {
      if (contarDecl(n) > 100) { const nome = '__L' + (++nEsc); escopos.set(n, nome);
        for (const st of n.statements) { if (ts.isVariableStatement(st)) { for (const d of st.declarationList.declarations) if (ts.isIdentifier(d.name)) derramar.set(d, nome); }
          else if ((ts.isFunctionDeclaration(st) || ts.isClassDeclaration(st)) && st.name) derramar.set(st, nome); } }
    }
    ts.forEachChild(n, procurar);
  };
  const declDe = (sym) => sym && (sym.valueDeclaration || (sym.declarations && sym.declarations[0]));
  const posicaoDeNome = (n) => { const p = n.parent; if (!p) return true;
    if (ts.isPropertyAccessExpression(p) && p.name === n) return true;
    if ((ts.isPropertyAssignment(p) || ts.isMethodDeclaration(p) || ts.isPropertyDeclaration(p) || ts.isGetAccessor(p) || ts.isSetAccessor(p) || ts.isPropertySignature(p)) && p.name === n) return true;
    if ((ts.isVariableDeclaration(p) || ts.isFunctionDeclaration(p) || ts.isFunctionExpression(p) || ts.isClassDeclaration(p) || ts.isClassExpression(p) || ts.isParameter(p) || ts.isBindingElement(p) || ts.isEnumDeclaration(p) || ts.isEnumMember(p)) && (p.name === n || p.propertyName === n)) return true;
    return ts.isLabeledStatement(p) || ts.isBreakOrContinueStatement(p) || ts.isShorthandPropertyAssignment(p) || ts.isQualifiedName(p); };
  const derramado = (n) => { if (n.pos < 0 || !derramar.size || posicaoDeNome(n)) return null; const d = declDe(checker.getSymbolAtLocation(n)); return d && derramar.get(d); };
  const id = (s) => f.createIdentifier(s);
  const chama = (nome, args) => f.createCallExpression(id(nome), undefined, args);
  const ehBool = (n) => (ts.isBinaryExpression(n) && BOOL.has(n.operatorToken.kind)) || n.kind === K.TrueKeyword || n.kind === K.FalseKeyword
    || (ts.isPrefixUnaryExpression(n) && n.operator === K.ExclamationToken) || (ts.isCallExpression(n) && ts.isIdentifier(n.expression) && ['__t', '__isArray', '__re_test', '__lt', '__le', '__gt', '__ge', '__isFiniteN', '__isInteger'].includes(n.expression.text))
    || (ts.isParenthesizedExpression(n) && ehBool(n.expression));
  const T = (n) => (ehBool(n) ? n : chama('__t', [n]));
  const temps = [];
  const tipo = (n) => { try { if (!n || n.pos < 0) return 'x'; if (ts.isNumericLiteral(n)) return 'n'; if (ts.isStringLiteral(n) || ts.isNoSubstitutionTemplateLiteral(n) || ts.isTemplateExpression(n)) return 's';
    const t = checker.getTypeAtLocation(n); if (!t) return 'x';
    if (t.flags & (ts.TypeFlags.NumberLike)) return 'n'; if (t.flags & ts.TypeFlags.StringLike) return 's';
    if (t.isUnion && t.isUnion() && t.types.every((u) => u.flags & ts.TypeFlags.NumberLike)) return 'n';
    if (t.isUnion && t.isUnion() && t.types.every((u) => u.flags & ts.TypeFlags.StringLike)) return 's'; return 'x'; } catch (e) { return 'x'; } };
  const simples = (x) => ts.isIdentifier(x) || x.kind === K.ThisKeyword || ts.isNumericLiteral(x) || ts.isStringLiteral(x)
    || (ts.isPropertyAccessExpression(x) && !x.questionDotToken && simples(x.expression)) || (ts.isParenthesizedExpression(x) && simples(x.expression));
  const binario = (op, a, b, origA, origB) => { // a op b já visitados
    if (BITS[op]) return chama(BITS[op], [a, b]);
    if (op === K.PercentToken) return chama('__mod', [a, b]);
    if (op === K.PlusToken) { const ta = tipo(origA), tb = tipo(origB);
      if ((ta === 'n' || tb === 'n') && ta !== 's' && tb !== 's') return f.createBinaryExpression(a, op, b);
      return chama('__add', [a, b]); }
    return f.createBinaryExpression(a, op, b);
  };
  // profundidade de funções (para saber se um objeto literal é "fixo", criado uma vez só)
  const profFuncoes = (n) => { let k = 0; for (let p = n.parent; p; p = p.parent) if (ts.isFunctionLike(p)) k++; return k; };
  const opcional = (n) => !!(n.questionDotToken || (n.flags & ts.NodeFlags.OptionalChain));
  const globalLivre = (n) => {
    if (n.pos < 0 || MANTER.has(n.text)) return false;
    const p = n.parent; if (!p) return false;
    if (ts.isPropertyAccessExpression(p) && p.name === n) return false;
    if ((ts.isPropertyAssignment(p) || ts.isMethodDeclaration(p) || ts.isPropertyDeclaration(p) || ts.isGetAccessor(p) || ts.isSetAccessor(p) || ts.isPropertySignature(p)) && p.name === n) return false;
    if ((ts.isVariableDeclaration(p) || ts.isFunctionDeclaration(p) || ts.isFunctionExpression(p) || ts.isClassDeclaration(p) || ts.isClassExpression(p) || ts.isParameter(p) || ts.isBindingElement(p) || ts.isEnumDeclaration(p) || ts.isEnumMember(p)) && (p.name === n || p.propertyName === n)) return false;
    if (ts.isLabeledStatement(p) || ts.isBreakOrContinueStatement(p) || ts.isShorthandPropertyAssignment(p) || ts.isImportSpecifier(p) || ts.isExportSpecifier(p) || ts.isMetaProperty(p) || ts.isQualifiedName(p)) return false;
    const sym = checker.getSymbolAtLocation(n);
    const ds = (sym && sym.declarations) || [];
    if (ds.length === 0) return true;
    return ds.some(ehLib);
  };
  const paraWindow = (nome) => (nome === 'globalThis' || nome === 'self') ? id('window') : f.createPropertyAccessExpression(id('window'), nome);
  const visit = (n) => {
    if (ts.isIdentifier(n)) { const t = derramado(n); if (t) return f.createPropertyAccessExpression(id(t), n.text); }
    if (ts.isIdentifier(n) && globalLivre(n)) return paraWindow(n.text);
    // Number, String e Boolean usados como função solta (ex.: lista.map(Number))
    if (ts.isIdentifier(n) && (n.text === 'Number' || n.text === 'String' || n.text === 'Boolean') && n.parent && !(ts.isCallExpression(n.parent) && n.parent.expression === n) && !(ts.isPropertyAccessExpression(n.parent) && n.parent.expression === n) && !ts.isNewExpression(n.parent) && !posicaoDeNome(n)) return id('__' + n.text + 'V');
    if ((ts.isSourceFile(n) || ts.isBlock(n)) && escopos.has(n)) {
      const nome = escopos.get(n); const prop = (x) => f.createPropertyAccessExpression(id(nome), x);
      const funcs = [], resto = [];
      for (const st of n.statements) {
        if (ts.isFunctionDeclaration(st) && derramar.has(st)) { const asy = (st.modifiers || []).filter((m) => m.kind === K.AsyncKeyword);
          funcs.push(f.createExpressionStatement(f.createAssignment(prop(st.name.text), ts.visitNode(f.createFunctionExpression(asy.length ? asy : undefined, st.asteriskToken, undefined, undefined, st.parameters, undefined, st.body), visit)))); continue; }
        if (ts.isClassDeclaration(st) && derramar.has(st)) { resto.push(f.createExpressionStatement(f.createAssignment(prop(st.name.text), ts.visitNode(f.createClassExpression(undefined, undefined, st.typeParameters, st.heritageClauses, st.members), visit)))); continue; }
        if (ts.isVariableStatement(st) && st.declarationList.declarations.some((d) => derramar.has(d))) {
          for (const d of st.declarationList.declarations) {
            if (derramar.has(d)) { if (d.initializer) resto.push(f.createExpressionStatement(f.createAssignment(prop(d.name.text), ts.visitNode(d.initializer, visit)))); }
            else resto.push(f.createVariableStatement(undefined, f.createVariableDeclarationList([ts.visitNode(d, visit)], st.declarationList.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))));
          }
          continue; }
        const r = visit(st); if (Array.isArray(r)) resto.push(...r); else if (r) resto.push(r);
      }
      const decl = f.createVariableStatement(undefined, f.createVariableDeclarationList([f.createVariableDeclaration(nome, undefined, undefined, f.createObjectLiteralExpression([]))], ts.NodeFlags.Const));
      const lista = [decl, ...funcs, ...resto];
      return ts.isSourceFile(n) ? f.updateSourceFile(n, lista) : f.updateBlock(n, lista);
    }
    // "const a = 1, b = a ? x : y" vira uma declaração por linha (o Lua precisa de a antes de calcular b)
    if (ts.isVariableStatement(n) && n.declarationList.declarations.length > 1 && n.parent && (ts.isBlock(n.parent) || ts.isSourceFile(n.parent) || ts.isCaseClause(n.parent) || ts.isDefaultClause(n.parent) || ts.isModuleBlock(n.parent)))
      return n.declarationList.declarations.map((d) => f.createVariableStatement(n.modifiers, f.createVariableDeclarationList([ts.visitNode(d, visit)], n.declarationList.flags & (ts.NodeFlags.Let | ts.NodeFlags.Const))));
    if (ts.isShorthandPropertyAssignment(n)) { const nm = n.name.text; if (MANTER.has(nm)) return n;
      const sym = checker.getShorthandAssignmentValueSymbol(n); const ds = (sym && sym.declarations) || [];
      const dd = declDe(sym); if (dd && derramar.get(dd)) return f.createPropertyAssignment(nm, f.createPropertyAccessExpression(id(derramar.get(dd)), nm));
      if (ds.length === 0 || ds.every(ehLib)) return f.createPropertyAssignment(nm, paraWindow(nm)); return n; }
    const cel = (k) => f.createElementAccessExpression(id('__O'), f.createNumericLiteral(k));
    const novaCel = () => { const k = ++tmpN; temps.push(k); return k; };
    const virgulas = (l) => f.createParenthesizedExpression(l.reduce((a, b) => f.createComma(a, b)));
    const atribuir = (alvo, val) => {
      if (ts.isElementAccessExpression(alvo)) return chama('__set', [ts.visitNode(alvo.expression, visit), ts.visitNode(alvo.argumentExpression, visit), val]);
      if (ts.isPropertyAccessExpression(alvo) && alvo.name.text === 'length') return chama('__setlen', [ts.visitNode(alvo.expression, visit), val]);
      return f.createAssignment(ts.visitNode(alvo, visit), val);
    };
    // [a, b] = [b, a] e parecidos
    if (ts.isBinaryExpression(n) && n.operatorToken.kind === K.EqualsToken && ts.isArrayLiteralExpression(n.left)) {
      const k = novaCel();
      const partes = [f.createAssignment(cel(k), chama('__iter', [ts.visitNode(n.right, visit)]))];
      n.left.elements.forEach((e, i) => {
        if (ts.isOmittedExpression(e)) return;
        if (ts.isSpreadElement(e)) { partes.push(atribuir(e.expression, chama('__call', [cel(k), f.createStringLiteral('slice'), f.createNumericLiteral(i)]))); return; }
        let alvo = e, padrao;
        if (ts.isBinaryExpression(e) && e.operatorToken.kind === K.EqualsToken) { alvo = e.left; padrao = e.right; }
        let val = chama('__get', [cel(k), f.createNumericLiteral(i)]);
        if (padrao) val = f.createBinaryExpression(val, K.QuestionQuestionToken, ts.visitNode(padrao, visit));
        partes.push(atribuir(alvo, val));
      });
      partes.push(cel(k));
      return virgulas(partes);
    }
    // a ||= v, a &&= v, a ??= v
    if (ts.isBinaryExpression(n) && [K.BarBarEqualsToken, K.AmpersandAmpersandEqualsToken, K.QuestionQuestionEqualsToken].includes(n.operatorToken.kind)) {
      const op = n.operatorToken.kind, L = n.left;
      if (ts.isElementAccessExpression(L)) {
        const ko = novaCel(), kk = novaCel();
        const get = () => chama('__get', [cel(ko), cel(kk)]);
        const set = chama('__set', [cel(ko), cel(kk), ts.visitNode(n.right, visit)]);
        const pre = [f.createAssignment(cel(ko), ts.visitNode(L.expression, visit)), f.createAssignment(cel(kk), ts.visitNode(L.argumentExpression, visit))];
        let cond;
        if (op === K.BarBarEqualsToken) cond = f.createConditionalExpression(T(get()), undefined, get(), undefined, set);
        else if (op === K.AmpersandAmpersandEqualsToken) cond = f.createConditionalExpression(T(get()), undefined, set, undefined, get());
        else cond = f.createConditionalExpression(f.createBinaryExpression(get(), K.ExclamationEqualsToken, f.createNull()), undefined, get(), undefined, set);
        return virgulas([...pre, cond]);
      }
      const bin = op === K.BarBarEqualsToken ? K.BarBarToken : op === K.AmpersandAmpersandEqualsToken ? K.AmpersandAmpersandToken : K.QuestionQuestionToken;
      return f.createAssignment(ts.visitNode(L, visit), ts.visitNode(f.createBinaryExpression(L, bin, n.right), visit));
    }
    // atribuições: x[i] = v, x[i] op= v, x.length = n, a op= b (bits, % e + com tipo desconhecido)
    if (ts.isBinaryExpression(n) && (n.operatorToken.kind === K.EqualsToken || COMPOSTO[n.operatorToken.kind])) {
      const op = n.operatorToken.kind, L = n.left;
      if (ts.isElementAccessExpression(L)) { const o = ts.visitNode(L.expression, visit), k = ts.visitNode(L.argumentExpression, visit); let v = ts.visitNode(n.right, visit);
        if (op !== K.EqualsToken) v = binario(COMPOSTO[op], chama('__get', [o, k]), v, L, n.right); return chama('__set', [o, k, v]); }
      if (ts.isPropertyAccessExpression(L) && L.name.text === 'length') { const o = ts.visitNode(L.expression, visit); let v = ts.visitNode(n.right, visit); if (op !== K.EqualsToken) v = binario(COMPOSTO[op], chama('__len', [o]), v, L, n.right); return chama('__setlen', [o, v]); }
      if (op !== K.EqualsToken && (BITS[COMPOSTO[op]] || COMPOSTO[op] === K.PlusToken || COMPOSTO[op] === K.PercentToken)) { const l = ts.visitNode(L, visit), r = ts.visitNode(n.right, visit); const novo = binario(COMPOSTO[op], l, r, L, n.right); if (ts.isCallExpression(novo)) return f.createAssignment(l, novo); return f.updateBinaryExpression(n, l, n.operatorToken, r); }
    }
    if (ts.isBinaryExpression(n) && (BITS[n.operatorToken.kind] || n.operatorToken.kind === K.PlusToken || n.operatorToken.kind === K.PercentToken)) return binario(n.operatorToken.kind, ts.visitNode(n.left, visit), ts.visitNode(n.right, visit), n.left, n.right);
    if (ts.isPrefixUnaryExpression(n) && n.operator === K.TildeToken) return chama('__bnot', [ts.visitNode(n.operand, visit)]);
    // < > <= >= : no JS, undefined < 1 é false; no Lua seria erro. Só usa a comparação nativa quando os dois lados são números (ou dois textos)
    const CMP = { [K.LessThanToken]: '__lt', [K.LessThanEqualsToken]: '__le', [K.GreaterThanToken]: '__gt', [K.GreaterThanEqualsToken]: '__ge' };
    if (ts.isBinaryExpression(n) && CMP[n.operatorToken.kind]) {
      const ta = tipo(n.left), tb = tipo(n.right);
      const a = ts.visitNode(n.left, visit), b = ts.visitNode(n.right, visit);
      if ((ta === 'n' && tb === 'n') || (ta === 's' && tb === 's')) return f.updateBinaryExpression(n, a, n.operatorToken, b);
      return chama(CMP[n.operatorToken.kind], [a, b]);
    }
    // ...x em listas e chamadas: o runtime transforma em lista (texto vira letras em UTF-8, Map/Set viram listas)
    if (ts.isSpreadElement(n)) return f.updateSpreadElement(n, chama('__iter', [ts.visitNode(n.expression, visit)]));
    // ++/-- em x[i]
    if ((ts.isPrefixUnaryExpression(n) || ts.isPostfixUnaryExpression(n)) && (n.operator === K.PlusPlusToken || n.operator === K.MinusMinusToken) && ts.isElementAccessExpression(n.operand)) {
      const o = ts.visitNode(n.operand.expression, visit), k = ts.visitNode(n.operand.argumentExpression, visit);
      return chama('__inc', [o, k, (n.operator === K.PlusPlusToken ? f.createNumericLiteral(1) : f.createPrefixUnaryExpression(K.MinusToken, f.createNumericLiteral(1))), ts.isPostfixUnaryExpression(n) ? f.createTrue() : f.createFalse()]);
    }
    if (ts.isDeleteExpression(n) && ts.isElementAccessExpression(n.expression)) return chama('__del', [ts.visitNode(n.expression.expression, visit), ts.visitNode(n.expression.argumentExpression, visit)]);
    // || e && com a regra do JavaScript, sem avaliar o lado direito à toa
    if (ts.isBinaryExpression(n) && (n.operatorToken.kind === K.BarBarToken || n.operatorToken.kind === K.AmpersandAmpersandToken)) {
      const a = ts.visitNode(n.left, visit), b = ts.visitNode(n.right, visit);
      if (ehBool(a) && ehBool(b)) return f.updateBinaryExpression(n, a, n.operatorToken, b);
      let teste, valor;
      if (simples(n.left)) { teste = a; valor = a; }
      else { const k = ++tmpN; temps.push(k); const cel = () => f.createElementAccessExpression(id('__O'), f.createNumericLiteral(k)); teste = f.createParenthesizedExpression(f.createAssignment(cel(), a)); valor = cel(); }
      return f.createParenthesizedExpression(n.operatorToken.kind === K.BarBarToken ? f.createConditionalExpression(T(teste), undefined, valor, undefined, b) : f.createConditionalExpression(T(teste), undefined, b, undefined, valor));
    }
    if (ts.isPrefixUnaryExpression(n) && n.operator === K.ExclamationToken) return f.createPrefixUnaryExpression(K.ExclamationToken, T(ts.visitNode(n.operand, visit)));
    if (ts.isIfStatement(n)) return f.updateIfStatement(n, T(ts.visitNode(n.expression, visit)), ts.visitNode(n.thenStatement, visit), n.elseStatement && ts.visitNode(n.elseStatement, visit));
    if (ts.isWhileStatement(n)) return f.updateWhileStatement(n, T(ts.visitNode(n.expression, visit)), ts.visitNode(n.statement, visit));
    if (ts.isDoStatement(n)) return f.updateDoStatement(n, ts.visitNode(n.statement, visit), T(ts.visitNode(n.expression, visit)));
    if (ts.isForStatement(n) && n.condition) return f.updateForStatement(n, n.initializer && ts.visitNode(n.initializer, visit), T(ts.visitNode(n.condition, visit)), n.incrementor && ts.visitNode(n.incrementor, visit), ts.visitNode(n.statement, visit));
    if (ts.isConditionalExpression(n)) return f.updateConditionalExpression(n, T(ts.visitNode(n.condition, visit)), n.questionToken, ts.visitNode(n.whenTrue, visit), n.colonToken, ts.visitNode(n.whenFalse, visit));
    // for (x of lista) e for (k in obj): o runtime devolve um iterador (Map, Set, texto, buracos...)
    if (ts.isForOfStatement(n)) return f.updateForOfStatement(n, n.awaitModifier, ts.visitNode(n.initializer, visit), chama('__iter', [ts.visitNode(n.expression, visit)]), ts.visitNode(n.statement, visit));
    if (ts.isForInStatement(n)) return f.createForOfStatement(undefined, ts.visitNode(n.initializer, visit), chama('__iter', [chama('__keys', [ts.visitNode(n.expression, visit)])]), ts.visitNode(n.statement, visit));
    // leituras
    if (ts.isElementAccessExpression(n)) { if (ts.isStringLiteral(n.argumentExpression) && n.argumentExpression.text !== 'length') return ts.visitEachChild(n, visit, ctx); return chama(opcional(n) ? '__getq' : '__get', [ts.visitNode(n.expression, visit), ts.visitNode(n.argumentExpression, visit)]); }
    if (ts.isPropertyAccessExpression(n) && n.name.text === 'length') return chama(opcional(n) ? '__lenq' : '__len', [ts.visitNode(n.expression, visit)]);
    if (ts.isArrayLiteralExpression(n)) {
      const els = n.elements.map((e) => (ts.isOmittedExpression(e) ? id('undefined') : ts.visitNode(e, visit)));
      if (n.elements.some((e) => ts.isSpreadElement(e) || ts.isOmittedExpression(e) || e.kind === K.NullKeyword || (ts.isIdentifier(e) && e.text === 'undefined'))) return chama('__arr', els);
      return chama('__arrL', [f.createArrayLiteralExpression(els, n.elements.length > 6), f.createNumericLiteral(els.length)]);
    }
    // new de algo que não é classe do jogo nem do conversor (ex.: new (window.AudioContext || window.webkitAudioContext)()): o runtime resolve
    if (ts.isNewExpression(n) && !(ts.isIdentifier(n.expression) && (NEW_RUNTIME.has(n.expression.text) || MANTER.has(n.expression.text)))) {
      const sym = ts.isIdentifier(n.expression) ? checker.getSymbolAtLocation(n.expression) : null;
      const ds = (sym && sym.declarations) || [];
      const classeDoJogo = ds.some((d) => (ts.isClassDeclaration(d) || ts.isClassExpression(d) || (ts.isVariableDeclaration(d) && d.initializer && ts.isClassExpression(d.initializer))) && !ehLib(d));
      if (!classeDoJogo) return chama('__newExpr', [ts.visitNode(n.expression, visit), ...(n.arguments || []).map((a) => ts.visitNode(a, visit))]);
    }
    if (ts.isNewExpression(n) && ts.isIdentifier(n.expression) && NEW_RUNTIME.has(n.expression.text)) return chama('__new', [f.createStringLiteral(n.expression.text), ...(n.arguments || []).map((a) => ts.visitNode(a, visit))]);
    if (ts.isRegularExpressionLiteral(n)) { const t = n.text, i = t.lastIndexOf('/'); return chama('__re', [f.createStringLiteral(t.slice(1, i)), f.createStringLiteral(t.slice(i + 1))]); }
    if (ts.isObjectLiteralExpression(n)) {
      const temGet = n.properties.some((p) => ts.isGetAccessorDeclaration(p));
      const props = [], getters = [];
      for (const p of n.properties) {
        if (ts.isGetAccessorDeclaration(p)) { getters.push(f.createPropertyAssignment(p.name, f.createArrowFunction(undefined, undefined, [], undefined, undefined, ts.visitNode(p.body, visit)))); continue; }
        if (ts.isSetAccessorDeclaration(p)) continue;
        let q = ts.visitNode(p, visit);
        // chaves numéricas viram texto; chaves calculadas passam por __pk
        if (q && q.name && ts.isNumericLiteral(q.name)) { if (ts.isPropertyAssignment(q)) q = f.createPropertyAssignment(f.createStringLiteral(String(Number(q.name.text))), q.initializer); }
        if (q && q.name && ts.isComputedPropertyName(q.name) && !ts.isStringLiteral(q.name.expression) && ts.isPropertyAssignment(q)) q = f.createPropertyAssignment(f.createComputedPropertyName(chama('__pk', [q.name.expression])), q.initializer);
        props.push(q);
      }
      let obj;
      if (n.properties.some((p) => ts.isSpreadAssignment(p))) {
        const partes = [f.createObjectLiteralExpression([])]; let atual = [];
        props.forEach((q) => { if (ts.isSpreadAssignment(q)) { if (atual.length) partes.push(f.createObjectLiteralExpression(atual, true)); atual = []; partes.push(q.expression); } else atual.push(q); });
        if (atual.length) partes.push(f.createObjectLiteralExpression(atual, true));
        obj = chama('__assign', partes);
      } else obj = f.createObjectLiteralExpression(props, n.properties.length > 2);
      if (temGet) obj = chama('__getters', [obj, f.createObjectLiteralExpression(getters, true)]);
      const nomes = n.properties.filter((p) => p.name && (ts.isIdentifier(p.name) || ts.isStringLiteral(p.name))).map((p) => p.name.text);
      if (nomes.length >= 2 && profFuncoes(n) <= 1) obj = chama('__ord', [obj, f.createStringLiteral(nomes.join(','))]);
      return obj;
    }
    if (ts.isPropertyAccessExpression(n) && ts.isPropertyAccessExpression(n.expression) && ts.isIdentifier(n.expression.expression) && n.expression.name.text === 'prototype') {
      const v = { 'Object.hasOwnProperty': '__hasOwnV', 'Array.slice': '__sliceV', 'Array.forEach': '__forEachV', 'Array.map': '__mapV', 'Array.filter': '__filterV', 'Array.indexOf': '__indexOfV', 'Array.push': '__pushV', 'Object.toString': '__toStringV' }[n.expression.expression.text + '.' + n.name.text];
      if (v) return id(v);
    }
    if (ts.isPropertyAccessExpression(n) && ts.isIdentifier(n.expression) && !(n.parent && ts.isCallExpression(n.parent) && n.parent.expression === n)) {
      const v = { 'Object.defineProperty': '__defPropV', 'Object.freeze': '__identV', 'Number.isFinite': '__isFiniteV', 'Number.isInteger': '__isIntegerV', 'Number.isNaN': '__isNaNV' }[n.expression.text + '.' + n.name.text];
      if (v) return id(v);
    }
    // chamadas
    if (ts.isCallExpression(n) && ts.isPropertyAccessExpression(n.expression)) {
      const nome = n.expression.name.text, recv = n.expression.expression, args = () => n.arguments.map((a) => ts.visitNode(a, visit)), a0 = n.arguments[0];
      if (ts.isIdentifier(recv) && GLOBAIS_FIXOS.has(recv.text) && !globalLivre(recv) || (ts.isIdentifier(recv) && MANTER.has(recv.text))) {
        const d = recv.text;
        if (d === 'Object' && nome === 'freeze') return a0 ? ts.visitNode(a0, visit) : f.createObjectLiteralExpression([]);
        if (d === 'Object' && (nome === 'seal' || nome === 'preventExtensions')) return a0 ? ts.visitNode(a0, visit) : f.createObjectLiteralExpression([]);
        if (d === 'Math' && nome === 'hypot') return chama('__hypot', args());
        if (d === 'Math' && nome === 'imul') return chama('__imul', args());
        if (d === 'Math' && nome === 'cbrt') return chama('__cbrt', args());
        if (d === 'Object' && nome === 'create') return chama('__objCreate', args());
        if (d === 'Object' && nome === 'getPrototypeOf') return chama('__getProto', args());
        if (d === 'Object' && nome === 'defineProperty') return chama('__defProp', args());
        if (d === 'Object' && nome === 'defineProperties') return chama('__defProps', args());
        if (d === 'Number' && nome === 'isSafeInteger') return chama('__isSafeInteger', args());
        if (d === 'Number' && nome === 'isFinite') return chama('__isFiniteN', args());
        if (d === 'Number' && nome === 'isInteger') return chama('__isInteger', args());
        if (d === 'Object' && ['keys', 'values', 'entries', 'assign'].includes(nome)) return chama('__' + nome, args());
        if (d === 'Object' && nome === 'getOwnPropertyNames') return chama('__keys', args());
        if (d === 'Object' && nome === 'hasOwn') { const a = args(); return chama('__call', [a[0], f.createStringLiteral('hasOwnProperty'), a[1]]); }
        if (d === 'Array' && nome === 'isArray') return chama('__isArray', args());
        if (d === 'Array' && nome === 'from') return chama('__arrayFrom', args());
        if (d === 'Array' && nome === 'of') return chama('__arrayOf', args());
        if (d === 'String' && nome === 'fromCharCode') return chama('__fromCharCode', args());
        if (d === 'String' && nome === 'fromCodePoint') return chama('__fromCharCode', args());
        return ts.visitEachChild(n, visit, ctx);
      }
      if ((nome === 'replace' || nome === 'split' || nome === 'match' || nome === 'replaceAll') && a0 && ts.isRegularExpressionLiteral(a0)) return chama('__re_' + (nome === 'replaceAll' ? 'replace' : nome), [ts.visitNode(recv, visit), ...args()]);
      if ((nome === 'test' || nome === 'exec') && ts.isRegularExpressionLiteral(recv)) return chama('__re_' + nome, [ts.visitNode(recv, visit), ...args()]);
      if (nome === 'bind' && !opcional(n) && !(ts.isIdentifier(recv) && MANTER.has(recv.text))) return chama('__fbind', [ts.visitNode(recv, visit), ...args()]);
      if (nome === 'call' && !opcional(n)) return chama('__fcall', [ts.visitNode(recv, visit), ...args()]);
      if (nome === 'apply' && !opcional(n)) return chama('__fapply', [ts.visitNode(recv, visit), ...args()]);
      if (METODOS.has(nome)) return chama(opcional(n) || opcional(n.expression) ? '__callq' : '__call', [ts.visitNode(recv, visit), f.createStringLiteral(nome), ...args()]);
    }
    return ts.visitEachChild(n, visit, ctx);
  };
  return (sf) => { temps.length = 0; derramar.clear(); escopos.clear(); procurar(sf); const novo = ts.visitNode(sf, visit); if (!temps.length) return novo;
    const decl = f.createVariableStatement(undefined, f.createVariableDeclarationList([f.createVariableDeclaration('__O', undefined, undefined, f.createObjectLiteralExpression([]))], ts.NodeFlags.Const));
    return f.updateSourceFile(novo, [decl, ...novo.statements]); };
};

fs.rmSync(TMP, { recursive: true, force: true }); fs.mkdirSync(TMP, { recursive: true }); fs.mkdirSync(SAIDA, { recursive: true });
// apaga a saída antiga, menos o que vem do capturar.mjs (fontes e interface)
for (const f of fs.readdirSync(SAIDA)) if (!/^(fontes|interface(_\d+)?)\.lua$/.test(f)) fs.rmSync(path.join(SAIDA, f), { recursive: true, force: true });
const PRE = path.join(TMP, 'pre'); fs.mkdirSync(PRE, { recursive: true });
const origem = arquivos.map((rel) => { const src = fs.readFileSync(path.join(RAIZ, 'dist', rel), 'utf8');
  const sf0 = ts.createSourceFile(rel, src, ts.ScriptTarget.ESNext, true, ts.ScriptKind.JS);
  const r0 = ts.transform(sf0, [prePasso]); const txt = ts.createPrinter().printFile(r0.transformed[0]); r0.dispose();
  const destino = path.join(PRE, rel.replace(/\//g, '__')); fs.writeFileSync(destino, txt); return destino; });
const prog = ts.createProgram(origem, { allowJs: true, checkJs: false, noEmit: true, target: ts.ScriptTarget.ESNext, lib: ['lib.esnext.d.ts', 'lib.dom.d.ts'] });
const checker = prog.getTypeChecker(), printer = ts.createPrinter();
const nomesTs = [];
for (const rel of arquivos) {
  const sf = prog.getSourceFile(path.join(PRE, rel.replace(/\//g, '__')));
  const r = ts.transform(sf, [fabrica(checker)]); const js = printer.printFile(r.transformed[0]); r.dispose();
  const destino = path.join(TMP, rel.replace(/\//g, '__').replace(/\.js$/, '.ts'));
  fs.writeFileSync(destino, '// @ts-nocheck\n' + js + '\nexport {};\n'); nomesTs.push(destino);
}
// os ajudantes do runtime são funções soltas (sem "this")
fs.writeFileSync(path.join(TMP, '__ajudantes.d.ts'), AJUDANTES.map((n) => `declare function ${n}(this: void, ...a: any[]): any;`).join('\n') + '\ndeclare const __O: any[];\n');
nomesTs.push(path.join(TMP, '__ajudantes.d.ts'));
const opcoes = { target: ts.ScriptTarget.ESNext, lib: ['lib.esnext.d.ts', 'lib.dom.d.ts'], strict: false, noImplicitAny: false, allowJs: true, checkJs: false, skipLibCheck: true, noEmitOnError: false,
  rootDir: TMP, outDir: SAIDA, luaTarget: alvo, luaLibImport: 'require', noHeader: true };
const res = tstl.transpileFiles(nomesTs, opcoes);
// cabeçalho de cada módulo: o runtime e os ajudantes como variáveis locais (no Roblox cada ModuleScript tem o próprio ambiente)
const caminhoJs = alvo === 'Luau' ? 'require(script.Parent.Parent.runtime.js)' : 'require("js")';
for (const arq of fs.readdirSync(SAIDA)) {
  if (!arq.endsWith('.lua') || arq === 'lualib_bundle.lua') continue;
  const p = path.join(SAIDA, arq);
  let lua = fs.readFileSync(p, 'utf8');
  lua = lua.split('__TS__Iterator(__iter(').join('__iterar((');
  if (alvo === 'Luau') lua = lua.split('require("lualib_bundle")').join('require(script.Parent.lualib_bundle)');
  const usados = AJUDANTES.filter((h) => new RegExp('\\b' + h + '\\b').test(lua) || (h === '__iterar' && lua.includes('__iterar')));
  // módulos que mais desenham ganham código nativo no Roblox (--!native; o Roblox volta ao normal se não couber)
  const NATIVOS = /^(art|hd-maps|hd-scene|campanha2__(personagens|cenarios|camadas|novos-a|novos-b|ambientes|plantas)|tela-inicial|lugares-fundos|lugares-c1|nikolas-fx|fx-pixel|vendor__pixelfx|hero-shadow|daytime|weather|cinema-fx|boss-fx|campaign-vfx|scene-life|critters|world-life|baile-pixel|baile-galpao|game|graphics|shader|mapa3d|estrada|chegada-carro|brainrots|char-detail|amanda-art|arena-art|arena-fx|trigal|balanco)\.lua$/;
  const cab = [(alvo === 'Luau' ? (NATIVOS.test(arq) ? '--!native\n' : '') + '--!nocheck\n' : '') + `local __JSR = ${caminhoJs}`, 'local window = __JSR.window', 'local tostring = __JSR.__str'];
  for (let i = 0; i < usados.length; i += 12) { const g = usados.slice(i, i + 12); cab.push(`local ${g.join(', ')} = ${g.map((h) => '__JSR.' + h).join(', ')}`); }
  fs.writeFileSync(p, cab.join('\n') + '\n' + lua);
}
const erros = res.diagnostics.filter((d) => d.category === ts.DiagnosticCategory.Error && d.source === 'typescript-to-lua');
const msgs = new Map(); for (const d of erros) { const m = ts.flattenDiagnosticMessageText(d.messageText, ' '); msgs.set(m, (msgs.get(m) || 0) + 1); }
console.log(`alvo ${alvo}: ${arquivos.length} arquivo(s) → ${path.relative(RAIZ, SAIDA)}`);
for (const [m, n] of [...msgs].sort((a, b) => b[1] - a[1]).slice(0, 25)) console.log(`  ${n}× ${m}`);
// dados do jogo (página, arquivos do fetch, ordem dos scripts)
import('node:child_process').then(({ execFileSync }) => { execFileSync(process.execPath, [path.join(AQUI, 'empacotar.mjs'), alvo === 'Luau' ? 'luau' : '5.3'], { stdio: 'inherit' }); });
