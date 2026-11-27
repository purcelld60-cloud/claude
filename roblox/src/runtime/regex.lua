--!native
--[[ Expressões regulares do JavaScript em Lua (o Lua tem "patterns", que não têm |, grupos com quantificador, etc.).
  Motor pequeno de retrocesso (backtracking) sobre pontos de código Unicode, com o que o jogo usa:
  | ( ) (?: ) (?= ) (?! ) [ ] [^ ] . ^ $ \b \B \d \D \w \W \s \S \uXXXX \xXX, * + ? {n} {n,} {n,m} (e versões preguiçosas),
  retro-referência \1 e as flags i, g, m, s, y. ]]
local R = {}
local utf8 = utf8

local function codepoints(s)
  local out, n = {}, 0
  for _, c in utf8.codes(s) do n = n + 1; out[n] = c end
  return out, n
end
R.codepoints = codepoints

local function lower(c)
  if c >= 65 and c <= 90 then return c + 32 end
  if c >= 192 and c <= 222 and c ~= 215 then return c + 32 end
  return c
end

-- classes prontas
local function isDigit(c) return c >= 48 and c <= 57 end
local function isWord(c) return (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122) or c == 95 end
local function isSpace(c) return c == 32 or (c >= 9 and c <= 13) or c == 160 or c == 0x1680 or (c >= 0x2000 and c <= 0x200a) or c == 0x2028 or c == 0x2029 or c == 0x202f or c == 0x205f or c == 0x3000 or c == 0xfeff end
local PRONTAS = { d = isDigit, w = isWord, s = isSpace }

-- análise do padrão ------------------------------------------------------------------------------
local function parse(src)
  local p, n = codepoints(src)
  local i, ngrupos = 1, 0
  local function peek(o) return p[i + (o or 0)] end
  local function erro(m) error("regex /" .. src .. "/: " .. m) end
  local parseAlt
  local function hex(qtd) local v = 0; for _ = 1, qtd do local c = p[i]; if not c then erro("hex") end
      local d = (c >= 48 and c <= 57) and c - 48 or (c >= 97 and c <= 102) and c - 87 or (c >= 65 and c <= 70) and c - 55 or erro("hex"); v = v * 16 + d; i = i + 1 end; return v end
  -- escape dentro ou fora de classe: devolve {ch=cp} ou {pronta=fn, neg=bool} ou {tipo="b"/"B"/"ref"}
  local function escape(emClasse)
    local c = p[i]; i = i + 1
    if not c then erro("\\ no fim") end
    local ch = utf8.char(c)
    if ch == "d" or ch == "w" or ch == "s" then return { pronta = PRONTAS[ch] } end
    if ch == "D" or ch == "W" or ch == "S" then return { pronta = PRONTAS[ch:lower()], neg = true } end
    if ch == "n" then return { ch = 10 } elseif ch == "r" then return { ch = 13 } elseif ch == "t" then return { ch = 9 } elseif ch == "f" then return { ch = 12 } elseif ch == "v" then return { ch = 11 } end
    if ch == "0" then return { ch = 0 } end
    if ch == "u" then if p[i] == 123 then i = i + 1; local v = 0; while p[i] and p[i] ~= 125 do v = v * 16 + hex(1) end; i = i + 1; return { ch = v } end; return { ch = hex(4) } end
    if ch == "x" then return { ch = hex(2) } end
    if not emClasse then
      if ch == "b" then return { tipo = "b" } elseif ch == "B" then return { tipo = "B" } end
      if c >= 49 and c <= 57 then local v = c - 48; while p[i] and isDigit(p[i]) do v = v * 10 + p[i] - 48; i = i + 1 end; return { tipo = "ref", n = v } end
    else
      if ch == "b" then return { ch = 8 } end
    end
    return { ch = c }
  end
  local function classe()
    -- já passou o "["
    local neg = false
    if p[i] == 94 then neg = true; i = i + 1 end
    local itens = {}
    local primeiro = true
    while true do
      local c = p[i]
      if not c then erro("[ sem ]") end
      if c == 93 and not primeiro then i = i + 1; break end
      if c == 93 and primeiro then i = i + 1; break end -- [] vazio
      primeiro = false
      local a
      if c == 92 then i = i + 1; a = escape(true) else i = i + 1; a = { ch = c } end
      if a.ch and p[i] == 45 and p[i + 1] and p[i + 1] ~= 93 then
        i = i + 1; local c2 = p[i]; local b
        if c2 == 92 then i = i + 1; b = escape(true) else i = i + 1; b = { ch = c2 } end
        if not b.ch then itens[#itens + 1] = { a.ch, a.ch }; itens[#itens + 1] = { 45, 45 }; itens[#itens + 1] = b
        else itens[#itens + 1] = { a.ch, b.ch } end
      elseif a.ch then itens[#itens + 1] = { a.ch, a.ch }
      else itens[#itens + 1] = a end
    end
    return { t = "cls", neg = neg, itens = itens }
  end
  local function atomo()
    local c = p[i]
    if c == 40 then -- (
      i = i + 1
      if p[i] == 63 then -- ?
        local k = p[i + 1]
        if k == 58 then i = i + 2; local no = parseAlt(); if p[i] ~= 41 then erro(") faltando") end; i = i + 1; return { t = "grp", no = no } end
        if k == 61 or k == 33 then i = i + 2; local no = parseAlt(); if p[i] ~= 41 then erro(") faltando") end; i = i + 1; return { t = "look", no = no, neg = (k == 33) } end
        if k == 60 and (p[i + 2] == 61 or p[i + 2] == 33) then erro("lookbehind não suportado") end
        if k == 60 then -- (?<nome>...)
          i = i + 2; while p[i] and p[i] ~= 62 do i = i + 1 end; i = i + 1
        else erro("grupo desconhecido") end
      end
      ngrupos = ngrupos + 1; local idx = ngrupos
      local no = parseAlt(); if p[i] ~= 41 then erro(") faltando") end; i = i + 1
      return { t = "grp", cap = idx, no = no }
    end
    if c == 91 then i = i + 1; return classe() end
    if c == 46 then i = i + 1; return { t = "any" } end
    if c == 94 then i = i + 1; return { t = "bol" } end
    if c == 36 then i = i + 1; return { t = "eol" } end
    if c == 92 then i = i + 1; local e = escape(false)
      if e.ch then return { t = "ch", c = e.ch } end
      if e.pronta then return { t = "cls", neg = false, itens = { e } } end
      if e.tipo == "ref" then return { t = "ref", n = e.n } end
      return { t = e.tipo } end
    i = i + 1
    return { t = "ch", c = c }
  end
  local function quant(no)
    local c = p[i]
    local mn, mx
    if c == 42 then mn, mx = 0, math.huge; i = i + 1
    elseif c == 43 then mn, mx = 1, math.huge; i = i + 1
    elseif c == 63 then mn, mx = 0, 1; i = i + 1
    elseif c == 123 then
      local j, a, b = i + 1, 0, nil
      local temDig = false
      while p[j] and isDigit(p[j]) do a = a * 10 + p[j] - 48; j = j + 1; temDig = true end
      if not temDig then return no end
      if p[j] == 44 then j = j + 1; if p[j] and isDigit(p[j]) then b = 0; while p[j] and isDigit(p[j]) do b = b * 10 + p[j] - 48; j = j + 1 end else b = math.huge end else b = a end
      if p[j] ~= 125 then return no end
      i = j + 1; mn, mx = a, b
    else return no end
    local preg = false
    if p[i] == 63 then preg = true; i = i + 1 end
    return { t = "q", no = no, min = mn, max = mx, preg = preg }
  end
  local function seq()
    local itens = {}
    while i <= n and p[i] ~= 124 and p[i] ~= 41 do itens[#itens + 1] = quant(atomo()) end
    return { t = "seq", itens = itens }
  end
  parseAlt = function()
    local alts = { seq() }
    while p[i] == 124 do i = i + 1; alts[#alts + 1] = seq() end
    if #alts == 1 then return alts[1] end
    return { t = "alt", alts = alts }
  end
  local arvore = parseAlt()
  if i <= n then erro("caractere inesperado") end
  return arvore, ngrupos
end

-- compilação em funções de continuação ----------------------------------------------------------------
-- estado da busca: S.s (pontos de código), S.n, S.cap (inícios/fins), flags
local function compilar(no, nxt, F)
  local t = no.t
  if t == "seq" then
    local f = nxt
    for k = #no.itens, 1, -1 do f = compilar(no.itens[k], f, F) end
    return f
  elseif t == "alt" then
    local ramos = {}
    for k, a in ipairs(no.alts) do ramos[k] = compilar(a, nxt, F) end
    return function(S, i) for k = 1, #ramos do local r = ramos[k](S, i); if r then return r end end; return nil end
  elseif t == "ch" then
    local c = no.c
    if F.i then local lc = lower(c); return function(S, i) local x = S.s[i]; if x and lower(x) == lc then return nxt(S, i + 1) end; return nil end end
    return function(S, i) if S.s[i] == c then return nxt(S, i + 1) end; return nil end
  elseif t == "any" then
    return function(S, i) local x = S.s[i]; if x and (F.s or (x ~= 10 and x ~= 13 and x ~= 0x2028 and x ~= 0x2029)) then return nxt(S, i + 1) end; return nil end
  elseif t == "cls" then
    local itens, neg = no.itens, no.neg
    local function bate(x)
      for k = 1, #itens do local it = itens[k]
        if it.pronta then if it.pronta(x) ~= (it.neg or false) then return true end
        elseif x >= it[1] and x <= it[2] then return true
        elseif F.i then local lx = lower(x); local up = (x >= 97 and x <= 122) and x - 32 or ((x >= 224 and x <= 254 and x ~= 247) and x - 32 or x)
          if (lx >= it[1] and lx <= it[2]) or (up >= it[1] and up <= it[2]) then return true end end
      end
      return false
    end
    return function(S, i) local x = S.s[i]; if x and bate(x) ~= neg then return nxt(S, i + 1) end; return nil end
  elseif t == "bol" then
    return function(S, i) if i == 1 or (F.m and (S.s[i - 1] == 10 or S.s[i - 1] == 13)) then return nxt(S, i) end; return nil end
  elseif t == "eol" then
    return function(S, i) if i == S.n + 1 or (F.m and (S.s[i] == 10 or S.s[i] == 13)) then return nxt(S, i) end; return nil end
  elseif t == "b" or t == "B" then
    local querLimite = (t == "b")
    return function(S, i) local a = S.s[i - 1]; local b = S.s[i]; local lim = ((a and isWord(a)) or false) ~= ((b and isWord(b)) or false)
      if lim == querLimite then return nxt(S, i) end; return nil end
  elseif t == "ref" then
    local k = no.n
    return function(S, i) local a, b = S.cap[2 * k - 1], S.cap[2 * k]; if not a or not b then return nxt(S, i) end
      local L = b - a; for d = 0, L - 1 do local x, y = S.s[a + d], S.s[i + d]; if not y then return nil end; if F.i then x, y = lower(x), lower(y) end; if x ~= y then return nil end end
      return nxt(S, i + L) end
  elseif t == "grp" then
    if not no.cap then return compilar(no.no, nxt, F) end
    local k = no.cap
    local fim = function(S, i) local antigo = S.cap[2 * k]; S.cap[2 * k] = i; local r = nxt(S, i); if not r then S.cap[2 * k] = antigo end; return r end
    local dentro = compilar(no.no, fim, F)
    return function(S, i) local a0, b0 = S.cap[2 * k - 1], S.cap[2 * k]; S.cap[2 * k - 1] = i; local r = dentro(S, i); if not r then S.cap[2 * k - 1] = a0; S.cap[2 * k] = b0 end; return r end
  elseif t == "look" then
    local dentro = compilar(no.no, function(_, i) return i end, F)
    local neg = no.neg
    return function(S, i) local r = dentro(S, i); if (r ~= nil) ~= neg then return nxt(S, i) end; return nil end
  elseif t == "q" then
    -- repetição: o corpo é compilado uma vez; a contagem de cada volta fica numa pilha por nó (S.q[no])
    local mn, mx, preg = no.min, no.max, no.preg
    local rep
    local corpoF = compilar(no.no, function(S, j)
      local fr = S.q[no]; local topo = fr[#fr]
      if j == topo[1] and topo[2] >= mn then return nil end -- volta vazia não conta
      return rep(S, j, topo[2] + 1)
    end, F)
    local function corpo(S, i, cont)
      local fr = S.q[no]; if not fr then fr = {}; S.q[no] = fr end
      fr[#fr + 1] = { i, cont }
      local r = corpoF(S, i)
      fr[#fr] = nil
      return r
    end
    rep = function(S, i, cont)
      if cont < mn then return corpo(S, i, cont) end
      if preg then local r = nxt(S, i); if r then return r end; if cont < mx then return corpo(S, i, cont) end; return nil end
      if cont < mx then local r = corpo(S, i, cont); if r then return r end end
      return nxt(S, i)
    end
    return function(S, i) return rep(S, i, 0) end
  end
  error("nó desconhecido " .. tostring(t))
end

-- expressão compilada: R.nova(fonte, flags)
function R.nova(src, flags)
  flags = flags or ""
  local F = { i = flags:find("i") ~= nil, g = flags:find("g") ~= nil, m = flags:find("m") ~= nil, s = flags:find("s") ~= nil, y = flags:find("y") ~= nil }
  local arvore, ngrupos = parse(src)
  local inicio = compilar(arvore, function(_, i) return i end, F)
  local re = { src = src, flags = flags, F = F, ngrupos = ngrupos }
  -- procura a partir do ponto de código "de" (1-based); devolve início, fim (exclusivo) e capturas
  function re.buscar(s, n, de)
    local S = { s = s, n = n, cap = {}, q = {} }
    local ultimo = F.y and de or n + 1
    for i = de, ultimo do
      S.cap = {}; S.q = {}
      local fim = inicio(S, i)
      if fim then return i, fim, S.cap end
    end
    return nil
  end
  return re
end

-- texto de volta a partir dos pontos de código
function R.texto(s, a, b) -- [a, b)
  local partes = {}
  for k = a, b - 1 do partes[#partes + 1] = utf8.char(s[k]) end
  return table.concat(partes)
end

return R
