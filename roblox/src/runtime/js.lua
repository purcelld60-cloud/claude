--[[ Regras do JavaScript para o código do Da Roça convertido para Lua/Luau (roblox/ferramentas/converter.mjs).
  O conversor troca tudo o que no JS depende do tipo por chamadas a este arquivo:
  - __t: verdade do JS (0, '', NaN, nil e false são falsos);
  - listas: __arrL/__arr criam listas (guardadas a partir do índice 1, com o tamanho certo mesmo com buracos),
    __get/__set/__inc/__del/__len/__setlen leem e escrevem com índice do JS (0, 1, 2...), __call chama
    métodos de lista, texto e número (map, push, split, toFixed...) ou o método do próprio objeto;
  - __add (+ do JS: soma ou junta texto), __mod (% do JS), __str (número vira texto como no JS), bits de 32 bits;
  - objetos: __keys/__values/__entries/__assign, ordem das chaves, __pk (chave numérica vira texto);
  - expressões regulares (runtime/regex.lua), JSON, Date, listas tipadas (Uint8ClampedArray...).
  Funções que o jogo chama como método recebem o objeto como 1º parâmetro (convenção do conversor). ]]
local JS = {}
local floor, ceil, huge, abs, max, min, sqrt = math.floor, math.ceil, math.huge, math.abs, math.max, math.min, math.sqrt
local sfmt, ssub, sbyte, schar, sfind, sgsub, srep = string.format, string.sub, string.byte, string.char, string.find, string.gsub, string.rep
local concat, tinsert, tremove = table.concat, table.insert, table.remove
local unpack = table.unpack or unpack
local rawlen = rawlen or function(t) return #t end
local utf8 = utf8
local RX = require(script and script.Parent and script.Parent:FindFirstChild("regex") or "regex")
local NaN = 0 / 0

-- verdade do JavaScript -----------------------------------------------------------------------------------
local function truthy(v)
  if v == nil or v == false or v == 0 or v == "" then return false end
  if v ~= v then return false end
  return true
end
JS.__t = truthy

-- listas: metatable ARR; o tamanho fica em LENK só quando há buracos (nil) ----------------------------------
local ARR = { __name = "Array" }
local LENK = setmetatable({}, { __tostring = function() return "<length>" end })
ARR.__len = function(a) return rawget(a, LENK) or rawlen(a) end
JS.ARR, JS.LENK = ARR, LENK
local TYPED = {} -- metatables das listas tipadas (Uint8ClampedArray...)
local function ehLista(o) local mt = getmetatable(o); return mt == ARR or (mt ~= nil and rawget(mt, "__typed") ~= nil) end
local function alen(a) return rawget(a, LENK) or rawlen(a) end
local function novaLista(t, n) t = t or {}; if n and n > 0 and (rawlen(t) ~= n) then t[LENK] = n end; return setmetatable(t, ARR) end
JS.lista = novaLista
-- lista literal sem "...": __arrL({a, b, c}, 3)
function JS.__arrL(t, n)
  for i = 1, n do if t[i] == nil then t[LENK] = n; break end end
  return setmetatable(t, ARR)
end
function JS.__arr(...)
  local n = select("#", ...)
  local t = { ... }
  return JS.__arrL(t, n)
end
-- tabela comum do Lua (sem marca) que é lista? (parâmetros "...resto", resultados do lualib)
local function pareceLista(o) return getmetatable(o) == nil and rawget(o, 1) ~= nil end

-- números e textos como no JS ------------------------------------------------------------------------------
local function numstr(v)
  if v ~= v then return "NaN" end
  if v == huge then return "Infinity" elseif v == -huge then return "-Infinity" end
  if v == 0 then return "0" end
  if v == floor(v) and abs(v) < 1e21 then return sfmt("%.0f", v) end
  for p = 1, 17 do
    local s = sfmt("%." .. p .. "g", v)
    if tonumber(s) == v then
      local mant, e = s:match("^(.-)e([-+]%d+)$")
      if mant then
        e = tonumber(e)
        if e >= -6 and e < 21 then s = sfmt("%." .. max(0, p - 1 - e) .. "f", v)
        else s = mant .. "e" .. (e > 0 and "+" or "-") .. abs(e) end
      end
      return s
    end
  end
  return sfmt("%.17g", v)
end
JS.numstr = numstr
local join
local function str(v)
  local t = type(v)
  if t == "string" then return v end
  if t == "number" then return numstr(v) end
  if t == "nil" then return "undefined" end
  if t == "boolean" then return v and "true" or "false" end
  if t == "table" then
    if ehLista(v) then return join(v, ",") end
    if rawget(v, "__re") then return "/" .. v.source .. "/" .. v.flags end
    local mt = getmetatable(v)
    if mt and mt.__tostring then return tostring(v) end
    local f = v.toString
    if type(f) == "function" then return str(f(v)) end
    if pareceLista(v) then return join(v, ",") end
    return "[object Object]"
  end
  if t == "function" then return "function () { [native code] }" end
  return tostring(v)
end
JS.__str = str
local function tonum(v)
  local t = type(v)
  if t == "number" then return v end
  if t == "string" then
    local s = v:match("^%s*(.-)%s*$")
    if s == "" then return 0 end
    if s:match("^[-+]?0[xX]%x+$") then return tonumber(s) end
    if s == "Infinity" or s == "+Infinity" then return huge elseif s == "-Infinity" then return -huge end
    if s:match("^[-+]?%d*%.?%d*[eE]?[-+]?%d*$") then local n = tonumber(s); if n then return n end end
    return NaN
  end
  if t == "boolean" then return v and 1 or 0 end
  if t == "nil" then return NaN end
  if t == "table" then if ehLista(v) then local n = alen(v); if n == 0 then return 0 elseif n == 1 then return tonum(v[1]) end end; return NaN end
  return NaN
end
JS.tonum = tonum
-- + do JavaScript
function JS.__add(a, b)
  local ta, tb = type(a), type(b)
  if ta == "number" and tb == "number" then return a + b end
  if ta == "string" or tb == "string" then return str(a) .. str(b) end
  if ta == "table" then a = str(a); return a .. str(b) end
  if tb == "table" then return str(a) .. str(b) end
  return tonum(a) + tonum(b)
end
-- % do JavaScript (resto com o sinal do dividendo)
local fmod = math.fmod
function JS.__mod(a, b)
  if type(a) ~= "number" then a = tonum(a) end
  if type(b) ~= "number" then b = tonum(b) end
  if b == 0 or a ~= a or b ~= b or a == huge or a == -huge then return NaN end
  if b == huge or b == -huge then return a end
  return fmod(a, b)
end
-- chave de objeto: números viram texto (no JS, o[1] e o["1"] são a mesma coisa)
local function numkey(k) if k == floor(k) and abs(k) < 1e15 then return sfmt("%d", k) end; return numstr(k) end
function JS.__pk(k) if type(k) == "number" then return numkey(k) end; if type(k) ~= "string" then return str(k) end; return k end

-- textos em UTF-8 (o JS conta caracteres; o Lua conta bytes) ------------------------------------------------
local function ascii(s) return not sfind(s, "[\128-\255]") end
local cacheCh, nCacheCh = {}, 0
local function chars(s)
  local r = cacheCh[s]
  if r then return r end
  r = {}
  local n = 0
  for ch in s:gmatch("[\1-\127\192-\255][\128-\191]*") do n = n + 1; r[n] = ch end
  nCacheCh = nCacheCh + 1
  if nCacheCh > 3000 then cacheCh = {}; nCacheCh = 0 end
  cacheCh[s] = r
  return r
end
local function slen(s) if ascii(s) then return #s end; return #chars(s) end
local function charAt(s, i)
  if i ~= floor(i) or i < 0 then return nil end
  if ascii(s) then if i < #s then return ssub(s, i + 1, i + 1) end; return nil end
  return chars(s)[i + 1]
end
local function subs(s, a, b) -- caracteres [a, b), já limitados
  if b <= a then return "" end
  if ascii(s) then return ssub(s, a + 1, b) end
  return concat(chars(s), "", a + 1, b)
end
local function cp(ch) if not ch then return nil end; local ok, c = pcall(utf8.codepoint, ch); if ok then return c end; return sbyte(ch) end
-- maiúsculas/minúsculas com acentos (Latin-1)
local function upper(s)
  s = s:upper()
  if ascii(s) then return s end
  return (s:gsub("\195([\160-\190])", function(b) local c = sbyte(b); if c == 183 then return nil end; return "\195" .. schar(c - 32) end))
end
local function lowerS(s)
  s = s:lower()
  if ascii(s) then return s end
  return (s:gsub("\195([\128-\158])", function(b) local c = sbyte(b); if c == 151 then return nil end; return "\195" .. schar(c + 32) end))
end
JS.upper, JS.lower = upper, lowerS
-- NFD: letra acentuada vira letra + acento combinante (o jogo usa para tirar acentos)
local DECOMP = {}
do
  local marcas = { ["`"] = "\204\128", ["´"] = "\204\129", ["^"] = "\204\130", ["~"] = "\204\131", ["¨"] = "\204\136", ["¸"] = "\204\167" }
  local tabela = { "àa`", "áa´", "âa^", "ãa~", "äa¨", "èe`", "ée´", "êe^", "ëe¨", "ìi`", "íi´", "îi^", "ïi¨", "òo`", "óo´", "ôo^", "õo~", "öo¨", "ùu`", "úu´", "ûu^", "üu¨", "çc¸", "ñn~",
    "ÀA`", "ÁA´", "ÂA^", "ÃA~", "ÄA¨", "ÈE`", "ÉE´", "ÊE^", "ËE¨", "ÌI`", "ÍI´", "ÎI^", "ÏI¨", "ÒO`", "ÓO´", "ÔO^", "ÕO~", "ÖO¨", "ÙU`", "ÚU´", "ÛU^", "ÜU¨", "ÇC¸", "ÑN~" }
  for _, e in ipairs(tabela) do local cs = chars(e); DECOMP[cs[1]] = cs[2] .. marcas[cs[3]] end
end
local function nfd(s) if ascii(s) then return s end; return (s:gsub("[\195][\128-\191]", function(c) return DECOMP[c] end)) end
local COMP = {}
for k, v in pairs(DECOMP) do COMP[v] = k end
local function nfc(s) if ascii(s) then return s end; return (s:gsub("([%a])(\204[\128-\191])", function(a, b) return COMP[a .. b] end)) end
-- posição em bytes de um índice de caractere (para buscas)
local function bytePos(s, ci) if ascii(s) then return ci + 1 end; local cs = chars(s); local b = 1; for k = 1, min(ci, #cs) do b = b + #cs[k] end; return b end
local function charIdx(s, bi) if ascii(s) then return bi - 1 end; local n = 0; for k = 1, bi - 1 do local c = sbyte(s, k); if c < 128 or c >= 192 then n = n + 1 end end; return n end
local function encode(c) local ok, s = pcall(utf8.char, floor(c)); if ok then return s end; return "?" end
function JS.__fromCharCode(...) local t = {}; for i = 1, select("#", ...) do t[i] = encode(tonum((select(i, ...)))) end; return concat(t) end

-- regex ---------------------------------------------------------------------------------------------------
local REMT = {}
REMT.__index = REMT
local cacheRe = {}
function JS.__re(src, flags)
  flags = flags or ""
  local chave = src .. "/" .. flags
  local base = cacheRe[chave]
  if not base then base = RX.nova(src, flags); cacheRe[chave] = base end
  return setmetatable({ __re = true, source = src, flags = flags, global = base.F.g, ignoreCase = base.F.i, multiline = base.F.m, sticky = base.F.y, lastIndex = 0, _m = base }, REMT)
end
local function reBusca(re, s, deChar)
  local cps, n = RX.codepoints(s)
  local a, b, cap = re._m.buscar(cps, n, deChar + 1)
  return a, b, cap, cps, n
end
local function reResultado(re, s, a, b, cap, cps)
  local r = { RX.texto(cps, a, b) }
  local n = re._m.ngrupos
  for k = 1, n do local x, y = cap[2 * k - 1], cap[2 * k]; r[k + 1] = (x and y) and RX.texto(cps, x, y) or nil end
  local lista = JS.__arrL(r, n + 1)
  rawset(lista, "index", a - 1); rawset(lista, "input", s)
  return lista
end
function REMT.exec(re, s)
  s = str(s)
  local de = (re.global or re.sticky) and (re.lastIndex or 0) or 0
  local a, b, cap, cps = reBusca(re, s, de)
  if not a then if re.global or re.sticky then re.lastIndex = 0 end; return nil end
  if re.global or re.sticky then re.lastIndex = (b > a) and (b - 1) or b end
  return reResultado(re, s, a, b, cap, cps)
end
function REMT.test(re, s) return REMT.exec(re, s) ~= nil end
function REMT.toString(re) return "/" .. re.source .. "/" .. re.flags end
function JS.__re_test(re, s) return REMT.test(re, s) end
function JS.__re_exec(re, s) return REMT.exec(re, s) end
local function expandir(rep, m, cap, cps, a, b, s, ng)
  return (rep:gsub("%$([%$&`']?)(%d?%d?)", function(sym, dig)
    if sym == "$" then return "$" .. dig end
    if sym == "&" then return RX.texto(cps, a, b) .. dig end
    if sym == "`" then return RX.texto(cps, 1, a) .. dig end
    if sym == "'" then return RX.texto(cps, b, #cps + 1) .. dig end
    if dig ~= "" then local k = tonumber(dig); if k > ng and #dig == 2 then k = tonumber(dig:sub(1, 1)); local resto = dig:sub(2); local x, y = cap[2 * k - 1], cap[2 * k]; return ((x and y) and RX.texto(cps, x, y) or "") .. resto end
      if k >= 1 and k <= ng then local x, y = cap[2 * k - 1], cap[2 * k]; return (x and y) and RX.texto(cps, x, y) or "" end end
    return nil
  end))
end
local function reReplace(s, re, rep, todos)
  s = str(s)
  local cps, n = RX.codepoints(s)
  local partes, pos, ng = {}, 1, re._m.ngrupos
  local global = todos or re.global
  while pos <= n + 1 do
    local a, b, cap = re._m.buscar(cps, n, pos)
    if not a then break end
    partes[#partes + 1] = RX.texto(cps, pos, a)
    if type(rep) == "function" then
      local args = { RX.texto(cps, a, b) }
      for k = 1, ng do local x, y = cap[2 * k - 1], cap[2 * k]; args[k + 1] = (x and y) and RX.texto(cps, x, y) or nil end
      args[ng + 2] = a - 1; args[ng + 3] = s
      partes[#partes + 1] = str(rep(nil, unpack(args, 1, ng + 3)))
    else
      partes[#partes + 1] = expandir(str(rep), nil, cap, cps, a, b, s, ng)
    end
    if b == a then if a <= n then partes[#partes + 1] = utf8.char(cps[a]) end; pos = a + 1 else pos = b end
    if not global then break end
  end
  if pos <= n then partes[#partes + 1] = RX.texto(cps, pos, n + 1) end
  if global then re.lastIndex = 0 end
  return concat(partes)
end
function JS.__re_replace(s, re, rep) if type(re) == "table" and re.__re then return reReplace(s, re, rep, false) end; return JS.__call(s, "replace", re, rep) end
local function reSplit(s, re, limite)
  s = str(s)
  local cps, n = RX.codepoints(s)
  local out, pos, ng = {}, 1, re._m.ngrupos
  limite = limite and tonum(limite) or huge
  if n == 0 then if re._m.buscar(cps, n, 1) then return novaLista({}) end; return novaLista({ "" }) end
  local q = 1
  while q <= n do
    local a, b, cap = re._m.buscar(cps, n, q)
    if not a or a > n then break end
    if b == a or b == pos and a == pos and false then q = a + 1
    else
      if b == a then q = a + 1 else
        out[#out + 1] = RX.texto(cps, pos, a)
        if #out >= limite then return novaLista(out) end
        for k = 1, ng do local x, y = cap[2 * k - 1], cap[2 * k]; out[#out + 1] = (x and y) and RX.texto(cps, x, y) or nil end
        pos = b; q = b
      end
    end
  end
  out[#out + 1] = RX.texto(cps, pos, n + 1)
  local L = #out
  return JS.__arrL(out, L)
end
function JS.__re_split(s, re, lim) if type(re) == "table" and re.__re then return reSplit(s, re, lim) end; return JS.__call(s, "split", re, lim) end
local function reMatch(s, re)
  s = str(s)
  if not re.global then return REMT.exec(setmetatable({ __re = true, source = re.source, flags = re.flags, _m = re._m, lastIndex = 0 }, REMT), s) end
  local cps, n = RX.codepoints(s)
  local out, pos = {}, 1
  while pos <= n + 1 do
    local a, b = re._m.buscar(cps, n, pos)
    if not a then break end
    out[#out + 1] = RX.texto(cps, a, b)
    pos = (b > a) and b or a + 1
  end
  re.lastIndex = 0
  if #out == 0 then return nil end
  return novaLista(out)
end
function JS.__re_match(s, re) if type(re) ~= "table" or not re.__re then re = JS.__re(str(re):gsub("[%^%$%(%)%%%.%[%]%*%+%-%?{}|\\/]", "\\%0"), "") end; return reMatch(s, re) end

-- métodos de lista ----------------------------------------------------------------------------------------
local AM = {}
local function relIdx(i, n, padrao) i = (i == nil) and padrao or tonum(i); if i ~= i then i = 0 end; i = (i >= 0) and floor(i) or ceil(i); if i < 0 then i = max(0, n + i) else i = min(i, n) end; return i end
local function setlen(a, n)
  local old = alen(a)
  n = floor(tonum(n) or 0)
  if n < old then for i = n + 1, old do a[i] = nil end end
  if n ~= rawlen(a) or rawget(a, LENK) then rawset(a, LENK, n) end
  if rawget(a, LENK) == rawlen(a) then local ok = true; for i = 1, n do if a[i] == nil then ok = false; break end end; if ok then rawset(a, LENK, nil) end end
end
function AM.push(a, ...)
  local n = alen(a)
  local k = select("#", ...)
  for i = 1, k do local v = select(i, ...); a[n + i] = v end
  if rawget(a, LENK) or (k > 0 and a[n + k] == nil) or (k > 0 and select(k, ...) == nil) then rawset(a, LENK, n + k) else for i = 1, k do if a[n + i] == nil then rawset(a, LENK, n + k); break end end end
  return n + k
end
function AM.pop(a)
  local n = alen(a)
  if n == 0 then return nil end
  local v = a[n]; a[n] = nil
  if rawget(a, LENK) then rawset(a, LENK, n - 1) end
  return v
end
function AM.shift(a)
  local n = alen(a)
  if n == 0 then return nil end
  local v = a[1]
  if rawget(a, LENK) then for i = 1, n - 1 do a[i] = a[i + 1] end; a[n] = nil; rawset(a, LENK, n - 1) else tremove(a, 1) end
  return v
end
function AM.unshift(a, ...)
  local n, k = alen(a), select("#", ...)
  for i = n, 1, -1 do a[i + k] = a[i] end
  for i = 1, k do a[i] = (select(i, ...)) end
  if rawget(a, LENK) then rawset(a, LENK, n + k) else for i = 1, n + k do if a[i] == nil then rawset(a, LENK, n + k); break end end end
  return n + k
end
function AM.slice(a, s, e)
  local n = alen(a)
  s = relIdx(s, n, 0); e = relIdx(e, n, n)
  local out, k = {}, 0
  for i = s + 1, e do k = k + 1; out[k] = a[i] end
  if ehLista(a) and getmetatable(a) ~= ARR then return JS.tipada(rawget(getmetatable(a), "__typed"), out, k) end
  return JS.__arrL(out, max(0, k))
end
function AM.splice(a, s, ...)
  local n = alen(a)
  local argc = select("#", ...)
  s = relIdx(s, n, 0)
  local dc
  if argc == 0 then dc = n - s else dc = tonum((...)); if dc ~= dc then dc = 0 end; dc = max(0, min(floor(dc), n - s)) end
  local removidos = {}
  for i = 1, dc do removidos[i] = a[s + i] end
  local novos = argc > 1 and { select(2, ...) } or {}
  local nn = max(0, argc - 1)
  local resto = {}
  for i = s + dc + 1, n do resto[#resto + 1] = a[i] end
  local nr = n - s - dc
  for i = s + 1, n do a[i] = nil end
  for i = 1, nn do a[s + i] = novos[i] end
  for i = 1, nr do a[s + nn + i] = resto[i] end
  local total = s + nn + nr
  rawset(a, LENK, total)
  local ok = true; for i = 1, total do if a[i] == nil then ok = false; break end end
  if ok then rawset(a, LENK, nil) end
  return JS.__arrL(removidos, dc)
end
function AM.map(a, f, este)
  local n = alen(a); local out = {}
  for i = 1, n do out[i] = f(este, a[i], i - 1, a) end
  return JS.__arrL(out, n)
end
function AM.filter(a, f, este)
  local n = alen(a); local out, k = {}, 0
  for i = 1, n do local v = a[i]; if truthy(f(este, v, i - 1, a)) then k = k + 1; out[k] = v end end
  return JS.__arrL(out, k)
end
function AM.forEach(a, f, este) local n = alen(a); for i = 1, n do local v = a[i]; if v ~= nil or i <= alen(a) then f(este, v, i - 1, a) end end end
function AM.reduce(a, f, ...)
  local n = alen(a); local i, acc = 1, nil
  if select("#", ...) > 0 then acc = (...) else if n == 0 then error("TypeError: Reduce of empty array with no initial value") end; acc = a[1]; i = 2 end
  for k = i, n do acc = f(nil, acc, a[k], k - 1, a) end
  return acc
end
function AM.reduceRight(a, f, ...)
  local n = alen(a); local i, acc = n, nil
  if select("#", ...) > 0 then acc = (...) else acc = a[n]; i = n - 1 end
  for k = i, 1, -1 do acc = f(nil, acc, a[k], k - 1, a) end
  return acc
end
function AM.some(a, f, este) for i = 1, alen(a) do if truthy(f(este, a[i], i - 1, a)) then return true end end; return false end
function AM.every(a, f, este) for i = 1, alen(a) do if not truthy(f(este, a[i], i - 1, a)) then return false end end; return true end
function AM.find(a, f, este) for i = 1, alen(a) do local v = a[i]; if truthy(f(este, v, i - 1, a)) then return v end end; return nil end
function AM.findIndex(a, f, este) for i = 1, alen(a) do if truthy(f(este, a[i], i - 1, a)) then return i - 1 end end; return -1 end
function AM.findLast(a, f, este) for i = alen(a), 1, -1 do local v = a[i]; if truthy(f(este, v, i - 1, a)) then return v end end; return nil end
function AM.findLastIndex(a, f, este) for i = alen(a), 1, -1 do if truthy(f(este, a[i], i - 1, a)) then return i - 1 end end; return -1 end
function AM.indexOf(a, v, de) local n = alen(a); de = relIdx(de, n, 0); for i = de + 1, n do if a[i] == v then return i - 1 end end; return -1 end
function AM.lastIndexOf(a, v) for i = alen(a), 1, -1 do if a[i] == v then return i - 1 end end; return -1 end
function AM.includes(a, v, de) local n = alen(a); de = relIdx(de, n, 0); local nan = (v ~= v); for i = de + 1, n do local x = a[i]; if x == v or (nan and x ~= x) then return true end end; return false end
join = function(a, sep)
  sep = (sep == nil) and "," or str(sep)
  local n = alen(a); local t = {}
  for i = 1, n do local v = a[i]; t[i] = (v == nil) and "" or str(v) end
  return concat(t, sep, 1, n)
end
AM.join = join
function AM.toString(a) return join(a, ",") end
function AM.concat(a, ...)
  local out, k = {}, 0
  local n = alen(a)
  for i = 1, n do out[i] = a[i] end
  k = n
  for j = 1, select("#", ...) do
    local b = select(j, ...)
    if type(b) == "table" and (ehLista(b) or pareceLista(b)) then local m = ehLista(b) and alen(b) or rawlen(b); for i = 1, m do out[k + i] = b[i] end; k = k + m
    else k = k + 1; out[k] = b end
  end
  return JS.__arrL(out, k)
end
-- ordenação estável (como o JS desde 2019); sem função, compara como texto
local function msort(t, n, maior)
  if n < 2 then return end
  if n <= 12 then
    for i = 2, n do local v = t[i]; local j = i - 1; while j >= 1 and maior(t[j], v) do t[j + 1] = t[j]; j = j - 1 end; t[j + 1] = v end
    return
  end
  local src, dst, w = t, {}, 1
  while w < n do
    local i = 1
    while i <= n do
      local mid, hi = min(i + w, n + 1), min(i + 2 * w, n + 1)
      local l, r, k = i, mid, i
      while l < mid and r < hi do if maior(src[l], src[r]) then dst[k] = src[r]; r = r + 1 else dst[k] = src[l]; l = l + 1 end; k = k + 1 end
      while l < mid do dst[k] = src[l]; l = l + 1; k = k + 1 end
      while r < hi do dst[k] = src[r]; r = r + 1; k = k + 1 end
      i = i + 2 * w
    end
    src, dst = dst, src; w = w * 2
  end
  if src ~= t then for i = 1, n do t[i] = src[i] end end
end
function AM.sort(a, cmp)
  local n = alen(a)
  local vals, k, nils = {}, 0, 0
  for i = 1, n do local v = a[i]; if v == nil then nils = nils + 1 else k = k + 1; vals[k] = v end end
  local maior
  if type(cmp) == "function" then maior = function(x, y) local r = cmp(nil, x, y); if type(r) == "boolean" then r = r and 1 or 0 end; r = tonum(r); return r > 0 end
  else maior = function(x, y) return str(x) > str(y) end end
  msort(vals, k, maior)
  for i = 1, k do a[i] = vals[i] end
  for i = k + 1, n do a[i] = nil end
  return a
end
function AM.reverse(a) local n = alen(a); for i = 1, floor(n / 2) do a[i], a[n + 1 - i] = a[n + 1 - i], a[i] end; return a end
function AM.fill(a, v, s, e) local n = alen(a); s = relIdx(s, n, 0); e = relIdx(e, n, n); local mt = getmetatable(a); local tip = mt and rawget(mt, "__typed")
  for i = s + 1, e do if tip then JS.__set(a, i - 1, v) else a[i] = v end end; return a end
function AM.flat(a, d)
  d = (d == nil) and 1 or tonum(d)
  local out, k = {}, 0
  local function rec(x, nivel) for i = 1, alen(x) do local v = x[i]; if type(v) == "table" and ehLista(v) and nivel > 0 then rec(v, nivel - 1) else k = k + 1; out[k] = v end end end
  rec(a, d)
  return JS.__arrL(out, k)
end
function AM.flatMap(a, f, este) return AM.flat(AM.map(a, f, este), 1) end
function AM.at(a, i) local n = alen(a); i = floor(tonum(i) or 0); if i < 0 then i = n + i end; return a[i + 1] end
function AM.keys(a) local out = {}; for i = 1, alen(a) do out[i] = i - 1 end; return JS.__arrL(out, alen(a)) end
function AM.values(a) return AM.slice(a) end
function AM.entries(a) local out = {}; for i = 1, alen(a) do out[i] = JS.__arrL({ i - 1, a[i] }, 2) end; return JS.__arrL(out, alen(a)) end
-- métodos de objeto comuns (quando o objeto não tem o seu)
function AM.hasOwnProperty(o, k)
  if type(o) ~= "table" then return false end
  if ehLista(o) then local i = tonumber(k); if i then return rawget(o, i + 1) ~= nil end; return k == "length" or rawget(o, k) ~= nil end
  if type(k) == "number" then k = numkey(k) end
  if rawget(o, k) ~= nil then return true end
  local mt = getmetatable(o); local props = mt and rawget(mt, "__props")
  return props ~= nil and props[k] ~= nil
end
AM.propertyIsEnumerable = AM.hasOwnProperty
-- Array.prototype.x / Object.prototype.x usados com .call(obj, ...): o próprio obj chega como 1º parâmetro
function JS.__hasOwnV(o, k) return AM.hasOwnProperty(o, k) end
function JS.__sliceV(o, a, b) return AM.slice(o, a, b) end
function JS.__forEachV(o, f, e) return AM.forEach(o, f, e) end
function JS.__mapV(o, f, e) return AM.map(o, f, e) end
function JS.__filterV(o, f, e) return AM.filter(o, f, e) end
function JS.__indexOfV(o, v, d) return AM.indexOf(o, v, d) end
function JS.__pushV(o, ...) return AM.push(o, ...) end
function JS.__toStringV(o) if ehLista(o) then return "[object Array]" end; if o == nil then return "[object Undefined]" end; return "[object Object]" end
function AM.isPrototypeOf() return false end
-- listas tipadas
function AM.set(a, src, off) off = floor(tonum(off or 0)); for i = 1, JS.__len(src) do JS.__set(a, off + i - 1, JS.__get(src, i - 1)) end end
function AM.subarray(a, s, e) return AM.slice(a, s, e) end

-- métodos de texto ----------------------------------------------------------------------------------------
local SM = {}
function SM.split(s, sep, lim)
  if type(sep) == "table" and sep.__re then return reSplit(s, sep, lim) end
  lim = (lim == nil) and huge or tonum(lim)
  local out = {}
  if lim == 0 then return novaLista(out) end
  if sep == nil then return JS.__arrL({ s }, 1) end
  sep = str(sep)
  if sep == "" then local cs = ascii(s) and nil or chars(s); local n = cs and #cs or #s; for i = 1, min(n, lim) do out[i] = cs and cs[i] or ssub(s, i, i) end; return JS.__arrL(out, min(n, lim)) end
  local pos = 1
  while true do
    local a, b = sfind(s, sep, pos, true)
    if not a then out[#out + 1] = ssub(s, pos); break end
    out[#out + 1] = ssub(s, pos, a - 1); pos = b + 1
    if #out >= lim then break end
  end
  local n = min(#out, lim)
  for i = n + 1, #out do out[i] = nil end
  return JS.__arrL(out, n)
end
function SM.substring(s, a, b)
  local n = slen(s)
  a = tonum(a or 0); if a ~= a then a = 0 end
  b = (b == nil) and n or tonum(b); if b ~= b then b = 0 end
  a = max(0, min(floor(a), n)); b = max(0, min(floor(b), n))
  if a > b then a, b = b, a end
  return subs(s, a, b)
end
function SM.substr(s, a, len)
  local n = slen(s)
  a = floor(tonum(a or 0)); if a ~= a then a = 0 end
  if a < 0 then a = max(0, n + a) end
  len = (len == nil) and (n - a) or floor(tonum(len))
  if len ~= len then len = 0 end
  local b = min(n, a + max(0, len))
  return subs(s, min(a, n), b)
end
function SM.slice(s, a, b) local n = slen(s); a = relIdx(a, n, 0); b = relIdx(b, n, n); return subs(s, a, b) end
function SM.startsWith(s, p, pos) p = str(p); local b = bytePos(s, pos and floor(tonum(pos)) or 0); return ssub(s, b, b + #p - 1) == p end
function SM.endsWith(s, p, fim) p = str(p); if fim ~= nil then s = subs(s, 0, min(slen(s), floor(tonum(fim)))) end; return p == "" or ssub(s, -#p) == p end
function SM.includes(s, p, pos) p = str(p); return sfind(s, p, bytePos(s, pos and floor(tonum(pos)) or 0), true) ~= nil end
function SM.indexOf(s, p, pos) p = str(p); local de = pos and max(0, floor(tonum(pos))) or 0; local a = sfind(s, p, bytePos(s, de), true); if not a then return -1 end; return charIdx(s, a) end
function SM.lastIndexOf(s, p) p = str(p); local ult = -1; local pos = 1; while true do local a = sfind(s, p, pos, true); if not a then break end; ult = a; pos = a + 1 end; if ult < 0 then return -1 end; return charIdx(s, ult) end
function SM.toUpperCase(s) return upper(s) end
function SM.toLowerCase(s) return lowerS(s) end
SM.toLocaleUpperCase, SM.toLocaleLowerCase = SM.toUpperCase, SM.toLowerCase
local ESP = "[ \t\n\r\v\f]"
function SM.trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end
function SM.trimStart(s) return (s:gsub("^%s+", "")) end
function SM.trimEnd(s) return (s:gsub("%s+$", "")) end
local function preencher(s, n, f, inicio)
  n = floor(tonum(n) or 0); f = (f == nil) and " " or str(f)
  local L = slen(s)
  if n <= L or f == "" then return s end
  local falta = n - L
  local fl = slen(f)
  local p = srep(f, ceil(falta / fl))
  p = subs(p, 0, falta)
  if inicio then return p .. s end
  return s .. p
end
function SM.padStart(s, n, f) return preencher(s, n, f, true) end
function SM.padEnd(s, n, f) return preencher(s, n, f, false) end
SM["repeat"] = function(s, n) n = floor(tonum(n) or 0); if n <= 0 then return "" end; return srep(s, n) end
local function trocaTexto(s, p, rep, todos)
  p = str(p)
  local out, pos = {}, 1
  while true do
    local a, b = sfind(s, p, pos, true)
    if not a then break end
    out[#out + 1] = ssub(s, pos, a - 1)
    local m = ssub(s, a, b)
    if type(rep) == "function" then out[#out + 1] = str(rep(nil, m, charIdx(s, a), s)) else out[#out + 1] = (str(rep):gsub("%$&", function() return m end):gsub("%$%$", "$")) end
    if b < a then if a <= #s then out[#out + 1] = ssub(s, a, a) end; pos = a + 1 else pos = b + 1 end
    if not todos then break end
    if pos > #s + 1 then break end
  end
  out[#out + 1] = ssub(s, pos)
  return concat(out)
end
function SM.replace(s, p, rep) if type(p) == "table" and p.__re then return reReplace(s, p, rep, false) end; return trocaTexto(s, p, rep, false) end
function SM.replaceAll(s, p, rep) if type(p) == "table" and p.__re then return reReplace(s, p, rep, true) end; return trocaTexto(s, p, rep, true) end
function SM.charAt(s, i) return charAt(s, floor(tonum(i or 0))) or "" end
function SM.charCodeAt(s, i) local c = charAt(s, floor(tonum(i or 0))); if not c then return NaN end; return cp(c) end
SM.codePointAt = function(s, i) local c = charAt(s, floor(tonum(i or 0))); if not c then return nil end; return cp(c) end
function SM.at(s, i) local n = slen(s); i = floor(tonum(i or 0)); if i < 0 then i = n + i end; return charAt(s, i) end
function SM.concat(s, ...) local t = { s }; for i = 1, select("#", ...) do t[#t + 1] = str((select(i, ...))) end; return concat(t) end
function SM.toString(s) return s end
SM.valueOf = SM.toString
function SM.normalize(s, forma) if forma == "NFD" or forma == "NFKD" then return nfd(s) end; return nfc(s) end
function SM.localeCompare(a, b)
  b = str(b)
  local ka, kb = lowerS(nfd(a)):gsub("\204[\128-\191]", ""), lowerS(nfd(b)):gsub("\204[\128-\191]", "")
  if ka < kb then return -1 elseif ka > kb then return 1 end
  if a < b then return -1 elseif a > b then return 1 end
  return 0
end
function SM.match(s, re) return JS.__re_match(s, re) end
function SM.search(s, re) if type(re) ~= "table" or not re.__re then re = JS.__re(str(re), "") end; local a = reBusca(re, s, 0); return a and (a - 1) or -1 end
function SM.split_(s) return SM.split(s) end

-- métodos de número ---------------------------------------------------------------------------------------
local NM = {}
function NM.toFixed(x, d)
  d = floor(tonum(d or 0))
  if x ~= x then return "NaN" end
  if abs(x) >= 1e21 then return numstr(x) end
  local neg = x < 0; if neg then x = -x end
  local esc = 10 ^ d
  local v = x * esc
  local f = floor(v)
  local resto = v - f
  local n
  if resto > 0.5 then n = f + 1 elseif resto < 0.5 then n = f else n = f + 1 end
  -- confere com a formatação exata do C (evita erro de arredondamento de x*10^d)
  local s = sfmt("%." .. d .. "f", x)
  local viaC = tonumber((s:gsub("%.", "")))
  if viaC and abs(viaC - n) == 1 and resto ~= 0.5 then n = viaC end
  local digitos = sfmt("%.0f", n)
  if d > 0 then
    if #digitos <= d then digitos = srep("0", d - #digitos + 1) .. digitos end
    digitos = digitos:sub(1, #digitos - d) .. "." .. digitos:sub(#digitos - d + 1)
  end
  if neg and tonumber(digitos) ~= 0 then digitos = "-" .. digitos end
  return digitos
end
function NM.toString(x, base)
  base = base and tonum(base) or 10
  if base == 10 or x ~= x or x == huge or x == -huge then return numstr(x) end
  local neg = x < 0; x = abs(x)
  local int = floor(x)
  local D = "0123456789abcdefghijklmnopqrstuvwxyz"
  local s = ""
  if int == 0 then s = "0" end
  while int > 0 do local r = int % base; s = D:sub(r + 1, r + 1) .. s; int = floor(int / base) end
  local frac = x - floor(x)
  if frac > 0 then s = s .. "."; local k = 0; while frac > 0 and k < 20 do frac = frac * base; local dgt = floor(frac); s = s .. D:sub(dgt + 1, dgt + 1); frac = frac - dgt; k = k + 1 end end
  return (neg and "-" or "") .. s
end
function NM.toPrecision(x, p) if p == nil then return numstr(x) end; local s = sfmt("%." .. floor(tonum(p)) .. "g", x); return s end
function NM.toLocaleString(x, _, op)
  local minF = op and op.minimumFractionDigits or 0
  local maxF = op and op.maximumFractionDigits or max(minF, 3)
  local s = NM.toFixed(x, maxF)
  local int, frac = s:match("^(-?%d+)%.?(%d*)$")
  if not int then return s end
  frac = frac:gsub("0+$", "")
  while #frac < minF do frac = frac .. "0" end
  local neg = int:sub(1, 1) == "-"; if neg then int = int:sub(2) end
  int = int:reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
  return (neg and "-" or "") .. int .. (frac ~= "" and ("," .. frac) or "")
end
function NM.valueOf(x) return x end

-- chamada de método que depende do tipo: __call(obj, "nome", ...)
function JS.__call(o, nome, ...)
  local t = type(o)
  if t == "table" then
    local mt = getmetatable(o)
    if mt ~= ARR and not (mt and rawget(mt, "__typed")) then
      local f = o[nome]
      if f ~= nil then return f(o, ...) end
    end
    local m = AM[nome]
    if m then return m(o, ...) end
    if mt == ARR or (mt and rawget(mt, "__typed")) then local f = rawget(o, nome); if f then return f(o, ...) end end
    error("TypeError: " .. tostring(nome) .. " is not a function", 2)
  elseif t == "string" then
    local m = SM[nome]; if m then return m(o, ...) end
  elseif t == "number" then
    local m = NM[nome]; if m then return m(o, ...) end
  elseif t == "boolean" then
    if nome == "toString" then return o and "true" or "false" end
    if nome == "valueOf" then return o end
  elseif t == "nil" then
    error("TypeError: Cannot read properties of undefined (reading '" .. tostring(nome) .. "')", 2)
  elseif t == "function" then
    if nome == "call" then return o(...) end
    if nome == "bind" then local este = ...; local pre = { select(2, ...) }; return function(_, ...) local args = { unpack(pre) }; for i = 1, select("#", ...) do args[#args + 1] = (select(i, ...)) end; return o(este, unpack(args)) end end
  end
  error("TypeError: " .. t .. "." .. tostring(nome) .. " is not a function", 2)
end
function JS.__callq(o, nome, ...) if o == nil then return nil end; return JS.__call(o, nome, ...) end

-- leitura e escrita com índice do JS ----------------------------------------------------------------------
local typedSet
function JS.__get(o, k)
  local t = type(o)
  if t == "table" then
    local mt = getmetatable(o)
    if mt == ARR or (mt ~= nil and rawget(mt, "__typed")) then
      if type(k) == "number" then return rawget(o, k + 1) end
      if k == "length" then return alen(o) end
      local nk = tonumber(k)
      if nk then return rawget(o, nk + 1) end
      return rawget(o, k)
    end
    if type(k) == "number" then
      local v = o[numkey(k)]
      if v ~= nil then return v end
      return rawget(o, k + 1)
    end
    if k == nil then return o["undefined"] end
    if type(k) ~= "string" then return o[str(k)] end
    return o[k]
  elseif t == "string" then
    if type(k) == "number" then return charAt(o, k) end
    if k == "length" then return slen(o) end
    local nk = tonumber(k)
    if nk then return charAt(o, nk) end
    return nil
  elseif t == "nil" then
    error("TypeError: Cannot read properties of undefined (reading '" .. str(k) .. "')", 2)
  end
  return nil
end
function JS.__getq(o, k) if o == nil then return nil end; return JS.__get(o, k) end
function JS.__set(o, k, v)
  local t = type(o)
  if t ~= "table" then
    if t == "nil" then error("TypeError: Cannot set properties of undefined (setting '" .. str(k) .. "')", 2) end
    return v
  end
  local mt = getmetatable(o)
  if mt == ARR then
    if type(k) ~= "number" then
      if k == "length" then setlen(o, v); return v end
      local nk = tonumber(k)
      if not nk then rawset(o, k, v); return v end
      k = nk
    end
    if k >= 0 and k == floor(k) then
      local i = k + 1
      local L = rawget(o, LENK)
      if L then if i > L then rawset(o, LENK, i) end
      else
        local n = rawlen(o)
        if v == nil then if i <= n then rawset(o, LENK, n) end
        elseif i > n + 1 then rawset(o, LENK, i) end
      end
      rawset(o, i, v)
      return v
    end
    rawset(o, numstr(k), v)
    return v
  end
  if mt ~= nil and rawget(mt, "__typed") then typedSet(o, mt, k, v); return v end
  if type(k) == "number" then
    if k >= 0 and k == floor(k) and mt == nil then
      local n = rawlen(o)
      if n > 0 and k <= n then rawset(o, k + 1, v); return v end
    end
    o[numkey(k)] = v
    return v
  end
  if k == nil then k = "undefined" elseif type(k) ~= "string" then k = str(k) end
  o[k] = v
  return v
end
function JS.__inc(o, k, d, posterior)
  local velho = tonum(JS.__get(o, k))
  local novo = velho + d
  JS.__set(o, k, novo)
  if posterior then return velho end
  return novo
end
function JS.__del(o, k)
  if type(o) ~= "table" then return true end
  local mt = getmetatable(o)
  if mt == ARR then local i = tonumber(k); if i then local n = alen(o); if i + 1 <= n then rawset(o, LENK, n); rawset(o, i + 1, nil) end; return true end end
  if type(k) == "number" then k = numkey(k) end
  o[k] = nil
  return true
end
function JS.__len(o)
  local t = type(o)
  if t == "string" then return slen(o) end
  if t == "table" then
    local mt = getmetatable(o)
    if mt == ARR or (mt ~= nil and rawget(mt, "__typed")) then return rawget(o, LENK) or rawlen(o) end
    local L = o.length
    if L ~= nil then return L end
    return rawlen(o)
  end
  if t == "function" then return 0 end
  if t == "nil" then error("TypeError: Cannot read properties of undefined (reading 'length')", 2) end
  return nil
end
function JS.__lenq(o) if o == nil then return nil end; return JS.__len(o) end
function JS.__setlen(o, n)
  if type(o) == "table" and getmetatable(o) == ARR then setlen(o, n) elseif type(o) == "table" then o.length = n end
  return n
end

-- listas tipadas ------------------------------------------------------------------------------------------
local CONV = {
  Uint8ClampedArray = function(v) v = tonum(v); if v ~= v then return 0 end; if v <= 0 then return 0 end; if v >= 255 then return 255 end; local f = floor(v); local r = v - f; if r > .5 or (r == .5 and f % 2 == 1) then f = f + 1 end; return f end,
  Uint8Array = function(v) return JS.toUint32(v) % 256 end,
  Int8Array = function(v) local x = JS.toUint32(v) % 256; if x >= 128 then x = x - 256 end; return x end,
  Uint16Array = function(v) return JS.toUint32(v) % 65536 end,
  Int16Array = function(v) local x = JS.toUint32(v) % 65536; if x >= 32768 then x = x - 65536 end; return x end,
  Uint32Array = function(v) return JS.toUint32(v) end,
  Int32Array = function(v) return JS.toInt32(v) end,
  Float32Array = function(v) return tonum(v) end,
  Float64Array = function(v) return tonum(v) end,
}
for nome in pairs(CONV) do TYPED[nome] = { __typed = nome, __len = function(a) return rawget(a, LENK) or rawlen(a) end } end
typedSet = function(o, mt, k, v)
  if type(k) ~= "number" then local nk = tonumber(k); if not nk then rawset(o, k, v); return end; k = nk end
  local n = rawget(o, LENK) or rawlen(o)
  if k >= 0 and k < n and k == floor(k) then rawset(o, k + 1, CONV[rawget(mt, "__typed")](v)) end
end
function JS.tipada(nome, base, n)
  local t = {}
  local conv = CONV[nome] or CONV.Float64Array
  if type(base) == "table" then n = n or JS.__len(base); for i = 1, n do t[i] = conv(JS.__get(base, i - 1)) end
  else n = floor(tonum(base or 0)); if n ~= n then n = 0 end; for i = 1, n do t[i] = 0 end end
  t[LENK] = n
  return setmetatable(t, TYPED[nome] or TYPED.Float64Array)
end

-- objetos: chaves na ordem do JS --------------------------------------------------------------------------
local ORDEM = setmetatable({}, { __mode = "k" })
function JS.__ord(o, chaves) ORDEM[o] = chaves; return o end
local function chavesDe(o)
  if type(o) == "string" then local out = {}; for i = 1, slen(o) do out[i] = numstr(i - 1) end; return out end
  if type(o) ~= "table" then return {} end
  if ehLista(o) then local out = {}; local n = alen(o); local k = 0; for i = 1, n do if rawget(o, i) ~= nil then k = k + 1; out[k] = numstr(i - 1) end end
    for key, v in pairs(o) do if type(key) == "string" then k = k + 1; out[k] = key end end; return out end
  local ints, strs, visto = {}, {}, {}
  local ordem = ORDEM[o]
  local out = {}
  for key, v in pairs(o) do
    if v ~= nil and key ~= LENK then
      local tk = type(key)
      if tk == "number" then ints[#ints + 1] = key - 1; visto[key] = true
      elseif tk == "string" then
        local n = tonumber(key)
        if n and n >= 0 and n == floor(n) and numkey(n) == key then ints[#ints + 1] = n; visto[key] = true end
      end
    end
  end
  table.sort(ints)
  for _, n in ipairs(ints) do out[#out + 1] = numkey(n) end
  if ordem then
    for nome in ordem:gmatch("[^,]+") do if rawget(o, nome) ~= nil and not visto[nome] then out[#out + 1] = nome; visto[nome] = true end end
  end
  for key, v in pairs(o) do if type(key) == "string" and not visto[key] and v ~= nil then strs[#strs + 1] = key end end
  table.sort(strs)
  for _, s in ipairs(strs) do out[#out + 1] = s end
  local mt = getmetatable(o)
  local props = mt and rawget(mt, "__props")
  if props then for _, k in ipairs(rawget(mt, "__chaves")) do local p = props[k]; if p and p.enumerable and not visto[k] then out[#out + 1] = k; visto[k] = true end end end
  return out
end
JS.chaves = chavesDe
function JS.__keys(o) local c = chavesDe(o); return JS.__arrL(c, #c) end
function JS.__values(o) local c = chavesDe(o); local out = {}; for i, k in ipairs(c) do out[i] = JS.__get(o, k) end; return JS.__arrL(out, #c) end
function JS.__entries(o) local c = chavesDe(o); local out = {}; for i, k in ipairs(c) do out[i] = JS.__arrL({ k, JS.__get(o, k) }, 2) end; return JS.__arrL(out, #c) end
function JS.__assign(alvo, ...)
  for j = 1, select("#", ...) do
    local src = select(j, ...)
    if type(src) == "table" then for _, k in ipairs(chavesDe(src)) do JS.__set(alvo, k, JS.__get(src, k)) end end
  end
  return alvo
end
function JS.__isArray(x) return type(x) == "table" and (ehLista(x) and getmetatable(x) == ARR or pareceLista(x)) end
-- lista a partir de qualquer coisa que o JS aceite em Array.from / for...of / [...x]
local function paraLista(x)
  local t = type(x)
  if t == "string" then if ascii(x) then local out = {}; for i = 1, #x do out[i] = ssub(x, i, i) end; return out, #x end; local cs = chars(x); local out = {}; for i = 1, #cs do out[i] = cs[i] end; return out, #cs end
  if t ~= "table" then return {}, 0 end
  if ehLista(x) then local n = alen(x); local out = {}; for i = 1, n do out[i] = x[i] end; return out, n end
  if pareceLista(x) then local n = rawlen(x); local out = {}; for i = 1, n do out[i] = x[i] end; return out, n end
  -- Map e Set do conversor (lualib): forEach(valor, chave)
  if type(x.forEach) == "function" and (type(x.has) == "function") then
    local out, n = {}, 0
    local ehMapa = type(x.set) == "function" and type(x.add) ~= "function"
    x:forEach(function(_, v, k) n = n + 1; out[n] = ehMapa and JS.__arrL({ k, v }, 2) or v end)
    return out, n
  end
  if type(x.next) == "function" then
    local out, n = {}, 0
    while true do local r = x:next(); if not r or truthy(r.done) then break end; n = n + 1; out[n] = r.value end
    return out, n
  end
  local L = x.length
  if L ~= nil then L = floor(tonum(L)); local out = {}; for i = 1, L do out[i] = JS.__get(x, i - 1) end; return out, L end
  return {}, 0
end
JS.paraLista = paraLista
function JS.__arrayFrom(x, f, este)
  local out, n = paraLista(x)
  if f then for i = 1, n do out[i] = f(este, out[i], i - 1) end end
  return JS.__arrL(out, n)
end
function JS.__arrayOf(...) return JS.__arr(...) end
-- for (x of lista): iterador do Lua que respeita buracos, Map, Set, texto e iteradores
function JS.__iterar(x)
  local out, n = paraLista(x)
  local i = 0
  return function() i = i + 1; if i <= n then return i, out[i] end; return nil end
end
function JS.__iter(x) if type(x) == "table" and getmetatable(x) == ARR then return x end; local out, n = paraLista(x); return JS.__arrL(out, n) end

-- Object.defineProperty (com get/set fica num metatable; as chaves continuam aparecendo em Object.keys)
function JS.__defProp(o, k, d)
  if type(k) == "number" then k = numkey(k) end
  d = d or {}
  local get, set = d.get, d.set
  if get == nil and set == nil then if getmetatable(o) == ARR then JS.__set(o, k, d.value) else rawset(o, k, d.value) end; return o end
  local mt = getmetatable(o)
  if not mt then mt = {}; setmetatable(o, mt) end
  local props = rawget(mt, "__props")
  if not props then
    props = {}; rawset(mt, "__props", props); rawset(mt, "__chaves", {})
    local idx0, nidx0 = mt.__index, mt.__newindex
    mt.__index = function(t, key) local p = props[key]; if p then if p.get then return p.get(t) end; return nil end
      if type(idx0) == "function" then return idx0(t, key) elseif idx0 then return idx0[key] end; return nil end
    mt.__newindex = function(t, key, v) local p = props[key]; if p then if p.set then p.set(t, v) end; return end
      if type(nidx0) == "function" then nidx0(t, key, v) else rawset(t, key, v) end end
  end
  rawset(o, k, nil)
  if not props[k] then local c = mt.__chaves; c[#c + 1] = k end
  props[k] = { get = get, set = set, enumerable = truthy(d.enumerable) }
  return o
end
function JS.__defPropV(_, o, k, d) return JS.__defProp(o, k, d) end
function JS.__defProps(o, mapa) for _, k in ipairs(JS.chaves(mapa)) do JS.__defProp(o, k, mapa[k]) end; return o end
function JS.__objCreate(p) if type(p) == "table" then return setmetatable({}, { __index = p }) end; return {} end
function JS.__getProto(o) local mt = type(o) == "table" and getmetatable(o); if mt and type(mt.__index) == "table" then return mt.__index end; return nil end
function JS.__imul(a, b) local ua, ub = JS.toUint32(a), JS.toUint32(b); local lo = (ua % 65536) * ub; local hi = floor(ua / 65536) * ub; return JS.toInt32((lo + (hi % 65536) * 65536) % 4294967296) end
function JS.__cbrt(x) x = tonum(x); if x < 0 then return -((-x) ^ (1 / 3)) end; return x ^ (1 / 3) end
function JS.__isFiniteN(x) return type(x) == "number" and x == x and x ~= huge and x ~= -huge end
function JS.__isInteger(x) return JS.__isFiniteN(x) and x == floor(x) end
function JS.__identV(_, x) return x end
function JS.__NumberV(_, x) if x == nil then return 0 end; return tonum(x) end
function JS.__StringV(_, x) return str(x) end
function JS.__BooleanV(_, x) return truthy(x) end
function JS.__fcall(fn, este, ...) if type(fn) == "function" then return fn(este, ...) end; if type(fn) == "table" and fn.call then return fn:call(este, ...) end; error("TypeError: call de algo que não é função", 2) end
function JS.__fapply(fn, este, args) local t, n = {}, 0; if args ~= nil then t, n = paraLista(args) end; if type(fn) == "function" then return fn(este, unpack(t, 1, n)) end; if type(fn) == "table" and fn.apply then return fn:apply(este, args) end; error("TypeError: apply de algo que não é função", 2) end
local function cmpNum(a, b) local ta, tb = type(a), type(b); if (ta == "number" and tb == "number") or (ta == "string" and tb == "string") then return a, b end; return tonum(a), tonum(b) end
function JS.__lt(a, b) a, b = cmpNum(a, b); return a < b end
function JS.__le(a, b) a, b = cmpNum(a, b); return a <= b end
function JS.__gt(a, b) a, b = cmpNum(a, b); return a > b end
function JS.__ge(a, b) a, b = cmpNum(a, b); return a >= b end
function JS.__isFiniteV(_, x) return JS.__isFiniteN(x) end
function JS.__isIntegerV(_, x) return JS.__isInteger(x) end
function JS.__isNaNV(_, x) return type(x) == "number" and x ~= x end
function JS.__isSafeInteger(x) return JS.__isInteger(x) and abs(x) <= 9007199254740991 end

-- objeto com "get x()": a leitura do campo chama a função
function JS.__getters(campos, getters)
  return setmetatable(campos, { __index = function(o, k) local g = getters[k]; if g then return g(o) end end })
end

-- bits de 32 bits -----------------------------------------------------------------------------------------
local function toInt32(x)
  if type(x) ~= "number" then x = tonum(x) end
  if x ~= x or x == huge or x == -huge then return 0 end
  x = x >= 0 and floor(x) or ceil(x)
  if x >= -2147483648 and x <= 2147483647 then return x end
  x = x % 4294967296
  if x >= 2147483648 then x = x - 4294967296 end
  return x
end
local function toUint32(x) local v = toInt32(x); if v < 0 then v = v + 4294967296 end; return v end
JS.toInt32, JS.toUint32 = toInt32, toUint32
local function bitop(a, b, op)
  local r, p = 0, 1
  a, b = toUint32(a), toUint32(b)
  for _ = 1, 32 do
    local x, y = a % 2, b % 2
    local v
    if op == 1 then v = (x == 1 and y == 1) and 1 or 0 elseif op == 2 then v = (x == 1 or y == 1) and 1 or 0 else v = (x ~= y) and 1 or 0 end
    r = r + v * p; a = (a - x) / 2; b = (b - y) / 2; p = p * 2
    if a == 0 and b == 0 then break end
  end
  return toInt32(r)
end
if bit32 then -- Luau
  local band, bor, bxor, bnot = bit32.band, bit32.bor, bit32.bxor, bit32.bnot
  JS.__band = function(a, b) return toInt32(band(toUint32(a), toUint32(b))) end
  JS.__bor = function(a, b) if b == 0 and type(a) == "number" then return toInt32(a) end; return toInt32(bor(toUint32(a), toUint32(b))) end
  JS.__bxor = function(a, b) return toInt32(bxor(toUint32(a), toUint32(b))) end
  JS.__bnot = function(a) return toInt32(bnot(toUint32(a))) end
else
  JS.__band = function(a, b) return bitop(a, b, 1) end
  JS.__bor = function(a, b) if b == 0 then return toInt32(a) end; return bitop(a, b, 2) end
  JS.__bxor = function(a, b) return bitop(a, b, 3) end
  JS.__bnot = function(a) return toInt32(-toInt32(a) - 1) end
end
JS.__shl = function(a, b) return toInt32(toInt32(a) * 2 ^ (toUint32(b) % 32)) end
JS.__shr = function(a, b) return floor(toInt32(a) / 2 ^ (toUint32(b) % 32)) end
JS.__ushr = function(a, b) return floor(toUint32(a) / 2 ^ (toUint32(b) % 32)) end
JS.__hypot = function(...) local s = 0; for i = 1, select("#", ...) do local v = tonum((select(i, ...))); s = s + v * v end; return sqrt(s) end

-- JSON ----------------------------------------------------------------------------------------------------
local JSON = {}
local function jsonStr(s)
  return '"' .. s:gsub('[%c"\\]', function(c)
    if c == '"' then return '\\"' elseif c == "\\" then return "\\\\" elseif c == "\n" then return "\\n" elseif c == "\r" then return "\\r" elseif c == "\t" then return "\\t" end
    return sfmt("\\u%04x", sbyte(c))
  end) .. '"'
end
local function enc(v, ind, nivel, vistos)
  local t = type(v)
  if t == "nil" or t == "function" then return nil end
  if t == "boolean" then return v and "true" or "false" end
  if t == "number" then if v ~= v or v == huge or v == -huge then return "null" end; return numstr(v) end
  if t == "string" then return jsonStr(v) end
  if t == "table" then
    if JSON.NULL == v then return "null" end
    if vistos[v] then error("TypeError: Converting circular structure to JSON") end
    vistos[v] = true
    local tj = v.toJSON
    if type(tj) == "function" then local r = enc(tj(v), ind, nivel, vistos); vistos[v] = nil; return r end
    local quebra, pad, pad2 = "", "", ""
    if ind ~= "" then quebra = "\n"; pad = srep(ind, nivel + 1); pad2 = srep(ind, nivel) end
    local partes = {}
    if ehLista(v) or pareceLista(v) then
      local n = ehLista(v) and alen(v) or rawlen(v)
      for i = 1, n do partes[i] = enc(v[i], ind, nivel + 1, vistos) or "null" end
      vistos[v] = nil
      if n == 0 then return "[]" end
      return "[" .. quebra .. pad .. concat(partes, "," .. quebra .. pad) .. quebra .. pad2 .. "]"
    end
    for _, k in ipairs(chavesDe(v)) do
      local x = enc(JS.__get(v, k), ind, nivel + 1, vistos)
      if x ~= nil then partes[#partes + 1] = jsonStr(k) .. ":" .. (ind ~= "" and " " or "") .. x end
    end
    vistos[v] = nil
    if #partes == 0 then return "{}" end
    return "{" .. quebra .. pad .. concat(partes, "," .. quebra .. pad) .. quebra .. pad2 .. "}"
  end
  return nil
end
function JSON.stringify(_, v, _rep, ind)
  if type(ind) == "number" then ind = srep(" ", min(10, ind)) elseif type(ind) ~= "string" then ind = "" end
  return enc(v, ind, 0, {})
end
function JSON.parse(_, s)
  s = str(s)
  local i = 1
  local function ws() i = sfind(s, "[^ \t\r\n]", i) or #s + 1 end
  local function erro(m) error("SyntaxError: JSON " .. m .. " na posição " .. i) end
  local valor
  local function texto()
    i = i + 1
    local partes = {}
    while true do
      local a = sfind(s, '["\\]', i)
      if not a then erro("texto sem fim") end
      partes[#partes + 1] = ssub(s, i, a - 1)
      local c = ssub(s, a, a)
      if c == '"' then i = a + 1; break end
      local e = ssub(s, a + 1, a + 1)
      local mapa = { n = "\n", r = "\r", t = "\t", b = "\b", f = "\f", ["/"] = "/", ["\\"] = "\\", ['"'] = '"' }
      if e == "u" then
        local h = tonumber(ssub(s, a + 2, a + 5), 16) or 63
        local prox = a + 6
        if h >= 0xD800 and h <= 0xDBFF and ssub(s, prox, prox + 1) == "\\u" then local lo = tonumber(ssub(s, prox + 2, prox + 5), 16); if lo and lo >= 0xDC00 and lo <= 0xDFFF then h = 0x10000 + (h - 0xD800) * 0x400 + (lo - 0xDC00); prox = prox + 6 end end
        partes[#partes + 1] = encode(h); i = prox
      else partes[#partes + 1] = mapa[e] or e; i = a + 2 end
    end
    return concat(partes)
  end
  valor = function()
    ws()
    local c = ssub(s, i, i)
    if c == "{" then
      i = i + 1; local o = {}; local ordem = {}
      ws()
      if ssub(s, i, i) == "}" then i = i + 1; return o end
      while true do
        ws(); if ssub(s, i, i) ~= '"' then erro("chave") end
        local k = texto(); ws(); if ssub(s, i, i) ~= ":" then erro(":") end; i = i + 1
        local v = valor()
        o[k] = v; ordem[#ordem + 1] = k
        ws(); local d = ssub(s, i, i); i = i + 1
        if d == "}" then break elseif d ~= "," then erro(", ou }") end
      end
      ORDEM[o] = concat(ordem, ",")
      return o
    elseif c == "[" then
      i = i + 1; local a, n = {}, 0
      ws()
      if ssub(s, i, i) == "]" then i = i + 1; return novaLista(a) end
      while true do
        n = n + 1; a[n] = valor()
        ws(); local d = ssub(s, i, i); i = i + 1
        if d == "]" then break elseif d ~= "," then erro(", ou ]") end
      end
      return JS.__arrL(a, n)
    elseif c == '"' then return texto()
    elseif ssub(s, i, i + 3) == "true" then i = i + 4; return true
    elseif ssub(s, i, i + 4) == "false" then i = i + 5; return false
    elseif ssub(s, i, i + 3) == "null" then i = i + 4; return nil
    else
      local a, b = sfind(s, "^-?%d+%.?%d*[eE]?[-+]?%d*", i)
      if not a then erro("valor") end
      i = b + 1
      return tonumber(ssub(s, a, b))
    end
  end
  local r = valor()
  ws()
  if i <= #s then erro("sobrou texto") end
  return r
end
JS.JSON = JSON

-- Date (o suficiente para o jogo: agora, horas, dia) --------------------------------------------------------
local relogio = os.clock
local epoca0 = os.time() * 1000
local base0 = relogio()
JS.agora = function() return (relogio() - base0) * 1000 end
function JS.usarRelogio(f) relogio = f; base0 = f() end
local function agoraEpoca() return epoca0 + JS.agora() end
local DATA = {}
DATA.__index = DATA
local function novaData(ms) return setmetatable({ _ms = ms or agoraEpoca() }, DATA) end
local function partes(d) return os.date("*t", floor(d._ms / 1000)) end
function DATA.getTime(d) return d._ms end
DATA.valueOf = DATA.getTime
function DATA.getHours(d) return partes(d).hour end
function DATA.getMinutes(d) return partes(d).min end
function DATA.getSeconds(d) return partes(d).sec end
function DATA.getMilliseconds(d) return floor(d._ms % 1000) end
function DATA.getDate(d) return partes(d).day end
function DATA.getDay(d) return partes(d).wday - 1 end
function DATA.getMonth(d) return partes(d).month - 1 end
function DATA.getFullYear(d) return partes(d).year end
function DATA.getTimezoneOffset() return 180 end
function DATA.toISOString(d) return os.date("!%Y-%m-%dT%H:%M:%S", floor(d._ms / 1000)) .. sfmt(".%03dZ", floor(d._ms % 1000)) end
DATA.toJSON = DATA.toISOString
function DATA.toLocaleDateString(d) local p = partes(d); return sfmt("%02d/%02d/%04d", p.day, p.month, p.year) end
function DATA.toLocaleTimeString(d) local p = partes(d); return sfmt("%02d:%02d:%02d", p.hour, p.min, p.sec) end
function DATA.toLocaleString(d) return DATA.toLocaleDateString(d) .. ", " .. DATA.toLocaleTimeString(d) end
DATA.__tostring = function(d) return os.date("%a %b %d %Y %H:%M:%S", floor(d._ms / 1000)) end
JS.Date = setmetatable({ now = function() return agoraEpoca() end, parse = function() return NaN end }, { __call = function(_, ...) return str(novaData()) end })
JS.novaData = function(a, ...) if a == nil then return novaData() end; if type(a) == "number" then return novaData(a) end; if type(a) == "table" and a._ms then return novaData(a._ms) end; return novaData() end

JS.NULL = setmetatable({}, { __tostring = function() return "null" end })
JS.RX = RX
JS.chars, JS.slen, JS.subs, JS.ascii = chars, slen, subs, ascii
JS.AM, JS.SM, JS.NM = AM, SM, NM
return JS
