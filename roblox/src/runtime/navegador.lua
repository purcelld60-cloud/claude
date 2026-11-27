--!native
--[[ Navegador simulado para o Da Roça no Roblox: window, document e os elementos HTML que o jogo cria e procura.
  - Elementos com classes, atributos, dataset, style, filhos, textContent/innerHTML (HTML é lido de verdade);
  - seletores CSS do jogo (#id, .classe, tag, [atributo], [atributo="valor"], :not(), descendente e ">");
  - eventos com captura e borbulhamento (click, keydown, pointerdown...), on<evento>;
  - temporizadores, requestAnimationFrame, localStorage, fetch dos arquivos embutidos, matchMedia, navigator...
  O hospedeiro (Roblox ou teste) chama N.passo(ms), N.tecla(...), N.ponteiro(...).
  Convenção do conversor: todo método recebe o objeto como 1º parâmetro; callbacks do jogo também. ]]
local N = {}
local JS = require(script and script.Parent and script.Parent:FindFirstChild("js") or "js")
local floor, max, min = math.floor, math.max, math.min
local sfmt, sfind, ssub, sgsub, slower = string.format, string.find, string.sub, string.gsub, string.lower
local unpack = table.unpack or unpack
local lista, arrL = JS.lista, JS.__arrL
local str, truthy = JS.__str, JS.__t

local window = {}
N.window = window
JS.window = window
window.window, window.self, window.globalThis, window.top, window.parent, window.frames = window, window, window, window, window, window

-- relógio e quadros -----------------------------------------------------------------------------------------
local agoraMs = 0
local function agora() return agoraMs end
N.agora = agora
local timers, proxT, quadros, proxQ = {}, 1, {}, 1
local function chamar(nome, f, ...)
  local ok, e = pcall(f, ...)
  if not ok then N.erro(nome, e) end
end
local erros = {}
function N.erro(onde, e)
  local msg = tostring(onde) .. ": " .. tostring(e)
  erros[#erros + 1] = msg
  if #erros > 200 then table.remove(erros, 1) end
  if N.aoErro then N.aoErro(msg) end
end
N.erros = erros
window.setTimeout = function(_, cb, ms, ...)
  local id = proxT; proxT = proxT + 1
  timers[id] = { cb = cb, em = agoraMs + max(0, JS.tonum(ms or 0) or 0), args = { ... }, n = select("#", ...) }
  return id
end
window.setInterval = function(_, cb, ms, ...)
  local id = proxT; proxT = proxT + 1
  local cada = max(4, JS.tonum(ms or 0) or 0); if cada ~= cada then cada = 4 end
  timers[id] = { cb = cb, em = agoraMs + cada, cada = cada, args = { ... }, n = select("#", ...) }
  return id
end
window.clearTimeout = function(_, id) if id ~= nil then timers[id] = nil end end
window.clearInterval = window.clearTimeout
window.requestAnimationFrame = function(_, cb) local id = proxQ; proxQ = proxQ + 1; quadros[id] = cb; return id end
window.cancelAnimationFrame = function(_, id) if id ~= nil then quadros[id] = nil end end
window.queueMicrotask = function(_, cb) return window.setTimeout(nil, cb, 0) end
window.requestIdleCallback = function(_, cb) return window.setTimeout(nil, function() cb(nil, { timeRemaining = function() return 10 end, didTimeout = false }) end, 1) end
window.cancelIdleCallback = window.clearTimeout
window.performance = { now = function() return agoraMs end, mark = function() end, measure = function() end, getEntriesByName = function() return lista({}) end, timeOrigin = 0 }
-- avança o tempo: temporizadores vencidos e depois um quadro de animação
function N.passo(ms)
  agoraMs = ms
  local vencidos = {}
  for id, t in pairs(timers) do if agoraMs >= t.em then vencidos[#vencidos + 1] = { id, t } end end
  table.sort(vencidos, function(a, b) if a[2].em ~= b[2].em then return a[2].em < b[2].em end; return a[1] < b[1] end)
  for _, v in ipairs(vencidos) do
    local id, t = v[1], v[2]
    if timers[id] == t then
      if t.cada then t.em = agoraMs + t.cada else timers[id] = nil end
      if type(t.cb) == "function" then chamar("timer", t.cb, nil, unpack(t.args, 1, t.n)) end
    end
  end
  N.microtarefas()
  local lista0 = quadros; quadros = {}
  local ids = {}
  for id in pairs(lista0) do ids[#ids + 1] = id end
  table.sort(ids)
  for _, id in ipairs(ids) do chamar("quadro", lista0[id], nil, agoraMs) end
  N.microtarefas()
  if N.aoPasso then N.aoPasso() end
end
-- as promessas do conversor (lualib) resolvem na hora; nada a fazer aqui, mas o gancho fica
function N.microtarefas() if N.avisarObservadores then N.avisarObservadores() end end

-- console --------------------------------------------------------------------------------------------------
local function juntar(...) local t = {}; for i = 1, select("#", ...) do t[i] = str((select(i, ...))) end; return table.concat(t, " ") end
N.log = function(...) print(...) end
window.console = {
  log = function(_, ...) N.log("[jogo] " .. juntar(...)) end, info = function() end, debug = function() end,
  warn = function(_, ...) N.log("[aviso] " .. juntar(...)) end, error = function(_, ...) N.log("[erro] " .. juntar(...)) end,
  trace = function() end, group = function() end, groupEnd = function() end, groupCollapsed = function() end, time = function() end, timeEnd = function() end, table = function() end, assert = function() end, count = function() end,
}

-- elementos -------------------------------------------------------------------------------------------------
local EL = {}       -- métodos
local GET, SET = {}, {} -- propriedades calculadas
local VAZIOS = { area = true, base = true, br = true, col = true, embed = true, hr = true, img = true, input = true, link = true, meta = true, source = true, track = true, wbr = true }
local elMT = {}
elMT.__index = function(o, k)
  local g = GET[k]
  if g then return g(o) end
  return EL[k]
end
elMT.__newindex = function(o, k, v)
  local s = SET[k]
  if s then s(o, v) else rawset(o, k, v) end
end
N.EL, N.GET, N.SET = EL, GET, SET
local versaoDom = 0 -- muda a cada alteração da árvore (o desenho da interface usa)
local function mudou() versaoDom = versaoDom + 1 end
function N.versao() return versaoDom end

local function novoEstilo(el)
  local st = { _el = el, _custom = {} }
  return setmetatable(st, {
    __index = function(t, k)
      if k == "setProperty" then return function(_, nome, valor) nome = str(nome); if nome:sub(1, 2) == "--" then t._custom[nome] = valor ~= nil and str(valor) or nil else rawset(t, (nome:gsub("%-(%a)", string.upper)), valor ~= nil and str(valor) or nil) end; mudou() end end
      if k == "getPropertyValue" then return function(_, nome) nome = str(nome); if nome:sub(1, 2) == "--" then return t._custom[nome] or "" end; return rawget(t, (nome:gsub("%-(%a)", string.upper))) or "" end end
      if k == "removeProperty" then return function(_, nome) nome = str(nome); if nome:sub(1, 2) == "--" then t._custom[nome] = nil else rawset(t, (nome:gsub("%-(%a)", string.upper)), nil) end; mudou() end end
      if k == "cssText" then local p = {}; for kk, vv in pairs(t) do if type(kk) == "string" and kk:sub(1, 1) ~= "_" then p[#p + 1] = kk:gsub("%u", function(c) return "-" .. c:lower() end) .. ":" .. str(vv) end end; for kk, vv in pairs(t._custom) do p[#p + 1] = kk .. ":" .. vv end; return table.concat(p, ";") end
      return ""
    end,
    __newindex = function(t, k, v)
      if k == "cssText" then
        for kk in pairs(t) do if type(kk) == "string" and kk:sub(1, 1) ~= "_" then rawset(t, kk, nil) end end
        t._custom = {}
        for decl in str(v):gmatch("[^;]+") do local nome, valor = decl:match("^%s*([%w%-]+)%s*:%s*(.-)%s*$"); if nome then if nome:sub(1, 2) == "--" then t._custom[nome] = valor else rawset(t, (nome:gsub("%-(%a)", string.upper)), valor) end end end
      else rawset(t, k, (v ~= nil and v ~= "") and str(v) or nil) end
      mudou()
    end,
  })
end
local function kebab(k) return (k:gsub("%u", function(c) return "-" .. c:lower() end)) end
local function camel(k) return (k:gsub("%-(%a)", string.upper)) end
local function novoDataset(el)
  return setmetatable({}, {
    __index = function(_, k) return el._attr["data-" .. kebab(k)] end,
    __newindex = function(_, k, v) if v == nil then el._attr["data-" .. kebab(k)] = nil else el._attr["data-" .. kebab(k)] = str(v) end; mudou() end,
    __pairs = function() local t = {}; for nome, v in pairs(el._attr) do if nome:sub(1, 5) == "data-" then t[camel(nome:sub(6))] = v end end; return next, t, nil end,
  })
end
local function novoClassList(el)
  local cl = { _el = el }
  function cl.add(_, ...) for i = 1, select("#", ...) do local c = str((select(i, ...))); if not el._cls[c] then el._cls[c] = true; el._ordem[#el._ordem + 1] = c end end; mudou() end
  function cl.remove(_, ...) for i = 1, select("#", ...) do local c = str((select(i, ...))); if el._cls[c] then el._cls[c] = nil; for j = #el._ordem, 1, -1 do if el._ordem[j] == c then table.remove(el._ordem, j) end end end end; mudou() end
  function cl.contains(_, c) return el._cls[str(c)] == true end
  function cl.toggle(_, c, forca)
    c = str(c)
    local ter
    if forca == nil then ter = not el._cls[c] else ter = truthy(forca) end
    if ter then cl.add(nil, c) else cl.remove(nil, c) end
    return ter
  end
  function cl.replace(_, a, b) if el._cls[str(a)] then cl.remove(nil, a); cl.add(nil, b); return true end; return false end
  function cl.item(_, i) return el._ordem[floor(i) + 1] end
  function cl.forEach(_, f) for i, c in ipairs(el._ordem) do f(nil, c, i - 1) end end
  setmetatable(cl, { __index = function(_, k) if k == "length" then return #el._ordem end; if k == "value" then return table.concat(el._ordem, " ") end end })
  return cl
end
local function definirClasses(el, s)
  el._cls, el._ordem = {}, {}
  for c in str(s or ""):gmatch("%S+") do if not el._cls[c] then el._cls[c] = true; el._ordem[#el._ordem + 1] = c end end
  mudou()
end

local function iniciarElemento(el, tag)
  rawset(el, "_tag", slower(tag))
  rawset(el, "_attr", {})
  rawset(el, "_filhos", {})
  rawset(el, "_ev", {})
  rawset(el, "_cls", {}); rawset(el, "_ordem", {})
  rawset(el, "nodeType", 1)
  rawset(el, "style", novoEstilo(el))
  rawset(el, "dataset", novoDataset(el))
  rawset(el, "classList", novoClassList(el))
  return el
end
local function criarElemento(tag)
  tag = slower(str(tag))
  if tag == "canvas" then return N.criarCanvas(300, 150) end
  local el = setmetatable({}, elMT)
  iniciarElemento(el, tag)
  if tag == "input" or tag == "textarea" or tag == "select" then rawset(el, "value", "") end
  return el
end
N.criarElemento = criarElemento
local function criarTexto(t) return setmetatable({ nodeType = 3, _texto = str(t) }, elMT) end
N.criarTexto = criarTexto

-- canvas como elemento: o objeto do runtime/canvas.lua ganha os métodos de elemento
function N.criarCanvas(w, h)
  local cv = N.Canvas.novo(w, h)
  local mt = getmetatable(cv)
  local idx0, nidx0 = mt.__index, mt.__newindex
  mt.__index = function(o, k) local v = idx0(o, k); if v ~= nil then return v end; return elMT.__index(o, k) end
  mt.__newindex = function(o, k, v) if k == "width" or k == "height" then nidx0(o, k, v); mudou() elseif SET[k] then SET[k](o, v) else rawset(o, k, v) end end
  iniciarElemento(cv, "canvas")
  return cv
end

-- árvore
local function filhos(el) return rawget(el, "_filhos") or {} end
local function tirar(no)
  local pai = rawget(no, "_pai")
  if not pai then return end
  local fs = pai._filhos
  for i = #fs, 1, -1 do if fs[i] == no then table.remove(fs, i) end end
  rawset(no, "_pai", nil)
  mudou()
end
local function porNo(v) if type(v) == "string" or type(v) == "number" then return criarTexto(v) end; return v end
local function inserir(pai, no, antesDe)
  no = porNo(no)
  if no == nil then return no end
  if rawget(no, "_fragmento") then
    local fs = { unpack(no._filhos) }
    for _, f in ipairs(fs) do inserir(pai, f, antesDe) end
    return no
  end
  tirar(no)
  local fs = pai._filhos
  local pos = #fs + 1
  if antesDe then for i, f in ipairs(fs) do if f == antesDe then pos = i; break end end end
  table.insert(fs, pos, no)
  rawset(no, "_pai", pai)
  mudou()
  if N.aoInserir then N.aoInserir(no) end
  return no
end
function EL.appendChild(el, c) return inserir(el, c) end
function EL.append(el, ...) for i = 1, select("#", ...) do inserir(el, (select(i, ...))) end end
function EL.prepend(el, ...) local primeiro = el._filhos[1]; for i = 1, select("#", ...) do inserir(el, (select(i, ...)), primeiro) end end
function EL.insertBefore(el, c, ref) return inserir(el, c, ref) end
function EL.removeChild(el, c) tirar(c); return c end
function EL.replaceChild(el, novo, velho) inserir(el, novo, velho); tirar(velho); return velho end
function EL.remove(el) tirar(el) end
function EL.replaceWith(el, ...) local pai = rawget(el, "_pai"); if not pai then return end; for i = 1, select("#", ...) do inserir(pai, (select(i, ...)), el) end; tirar(el) end
function EL.before(el, ...) local pai = rawget(el, "_pai"); if pai then for i = 1, select("#", ...) do inserir(pai, (select(i, ...)), el) end end end
function EL.after(el, ...)
  local pai = rawget(el, "_pai"); if not pai then return end
  local fs = pai._filhos; local prox
  for i, f in ipairs(fs) do if f == el then prox = fs[i + 1]; break end end
  for i = 1, select("#", ...) do inserir(pai, (select(i, ...)), prox) end
end
function EL.replaceChildren(el, ...) for _, f in ipairs({ unpack(el._filhos) }) do tirar(f) end; EL.append(el, ...) end
function EL.cloneNode(el, fundo)
  if el.nodeType == 3 then return criarTexto(el._texto) end
  local c = criarElemento(el._tag)
  for k, v in pairs(el._attr) do c._attr[k] = v end
  definirClasses(c, table.concat(el._ordem, " "))
  for k, v in pairs(el.style) do if type(k) == "string" and k:sub(1, 1) ~= "_" then rawset(c.style, k, v) end end
  if truthy(fundo) then for _, f in ipairs(el._filhos) do inserir(c, EL.cloneNode(f, true)) end end
  return c
end
function EL.contains(el, o) while o do if o == el then return true end; o = rawget(o, "_pai") end; return false end
function EL.hasChildNodes(el) return #filhos(el) > 0 end
GET.parentNode = function(el) return rawget(el, "_pai") end
GET.parentElement = function(el) local p = rawget(el, "_pai"); if p and p.nodeType == 1 then return p end; return nil end
GET.childNodes = function(el) local t = {}; for i, f in ipairs(filhos(el)) do t[i] = f end; return lista(t, #t) end
GET.children = function(el) local t = {}; for _, f in ipairs(filhos(el)) do if f.nodeType == 1 then t[#t + 1] = f end end; return lista(t, #t) end
GET.childElementCount = function(el) local n = 0; for _, f in ipairs(filhos(el)) do if f.nodeType == 1 then n = n + 1 end end; return n end
GET.firstChild = function(el) return filhos(el)[1] end
GET.lastChild = function(el) local f = filhos(el); return f[#f] end
GET.firstElementChild = function(el) for _, f in ipairs(filhos(el)) do if f.nodeType == 1 then return f end end; return nil end
GET.lastElementChild = function(el) local fs = filhos(el); for i = #fs, 1, -1 do if fs[i].nodeType == 1 then return fs[i] end end; return nil end
local function irmao(el, d, soEl)
  local pai = rawget(el, "_pai"); if not pai then return nil end
  local fs = pai._filhos
  for i, f in ipairs(fs) do if f == el then local j = i + d; while fs[j] do if not soEl or fs[j].nodeType == 1 then return fs[j] end; j = j + d end; return nil end end
  return nil
end
GET.nextSibling = function(el) return irmao(el, 1, false) end
GET.previousSibling = function(el) return irmao(el, -1, false) end
GET.nextElementSibling = function(el) return irmao(el, 1, true) end
GET.previousElementSibling = function(el) return irmao(el, -1, true) end
GET.isConnected = function(el) local o = el; while o do if o == N.document then return true end; o = rawget(o, "_pai") end; return false end
GET.ownerDocument = function() return N.document end
GET.tagName = function(el) return el._tag and el._tag:upper() or nil end
GET.nodeName = function(el) if el.nodeType == 3 then return "#text" end; return el._tag and el._tag:upper() or nil end
GET.localName = function(el) return el._tag end
GET.id = function(el) return el._attr and el._attr.id or "" end
SET.id = function(el, v) el._attr.id = v ~= nil and str(v) or nil; mudou() end
GET.className = function(el) return table.concat(el._ordem or {}, " ") end
SET.className = function(el, v) definirClasses(el, v) end
local function textoDe(no)
  if no.nodeType == 3 then return no._texto end
  local t = {}
  for _, f in ipairs(filhos(no)) do t[#t + 1] = textoDe(f) end
  return table.concat(t)
end
N.textoDe = textoDe
GET.textContent = function(el) return textoDe(el) end
SET.textContent = function(el, v)
  if el.nodeType == 3 then rawset(el, "_texto", str(v)); mudou(); return end
  for _, f in ipairs({ unpack(el._filhos) }) do tirar(f) end
  if v ~= nil and v ~= "" then inserir(el, criarTexto(str(v))) end
  mudou()
end
GET.innerText, SET.innerText = GET.textContent, SET.textContent
GET.data = function(el) return el._texto end
SET.data = function(el, v) rawset(el, "_texto", str(v)); mudou() end
GET.nodeValue = GET.data
GET.length = function(el) if el.nodeType == 3 then return JS.slen(el._texto) end; return nil end

-- atributos
local BOOL_ATTR = { hidden = true, disabled = true, checked = true, open = true, inert = true, selected = true, readonly = true, required = true, autofocus = true, multiple = true }
function EL.getAttribute(el, nome)
  nome = slower(str(nome))
  if nome == "class" then if #el._ordem == 0 then return nil end; return table.concat(el._ordem, " ") end
  if nome == "style" then return el.style.cssText end
  return el._attr[nome]
end
function EL.setAttribute(el, nome, v)
  nome = slower(str(nome)); v = str(v)
  if nome == "class" then definirClasses(el, v); return end
  if nome == "style" then el.style.cssText = v; return end
  if (nome == "width" or nome == "height") and el._tag == "canvas" then el[nome] = tonumber(v) or 0; return end
  el._attr[nome] = v
  mudou()
end
function EL.removeAttribute(el, nome) nome = slower(str(nome)); if nome == "class" then definirClasses(el, ""); return end; el._attr[nome] = nil; mudou() end
function EL.hasAttribute(el, nome) nome = slower(str(nome)); if nome == "class" then return #el._ordem > 0 end; return el._attr[nome] ~= nil end
function EL.toggleAttribute(el, nome, forca) nome = slower(str(nome)); local ter; if forca == nil then ter = el._attr[nome] == nil else ter = truthy(forca) end; el._attr[nome] = ter and "" or nil; mudou(); return ter end
function EL.getAttributeNames(el) local t = {}; for k in pairs(el._attr) do t[#t + 1] = k end; table.sort(t); return lista(t, #t) end
for nome in pairs(BOOL_ATTR) do
  GET[nome] = function(el) return el._attr ~= nil and el._attr[nome] ~= nil end
  SET[nome] = function(el, v) el._attr[nome] = truthy(v) and "" or nil; mudou() end
end
for _, nome in ipairs({ "title", "href", "src", "alt", "type", "name", "placeholder", "role", "lang", "dir", "for", "htmlFor", "tabIndex", "accessKey", "download", "rel", "target", "min", "max", "step", "pattern", "maxLength" }) do
  local attr = (nome == "htmlFor") and "for" or slower(nome)
  GET[nome] = function(el) return el._attr and el._attr[attr] or ((nome == "tabIndex") and -1 or "") end
  SET[nome] = function(el, v) el._attr[attr] = v ~= nil and str(v) or nil; mudou() end
end
GET.value = function(el) local v = rawget(el, "_valor"); if v ~= nil then return v end; return el._attr and el._attr.value or "" end
SET.value = function(el, v) rawset(el, "_valor", v ~= nil and str(v) or ""); mudou() end
GET.valueAsNumber = function(el) return JS.tonum(GET.value(el)) end

-- HTML: leitura (innerHTML e o index.html) e escrita ------------------------------------------------------------
local ENT = { amp = "&", lt = "<", gt = ">", quot = '"', apos = "'", nbsp = "\194\160", times = "×", middot = "·", hellip = "…", copy = "©", rarr = "→", larr = "←", uarr = "↑", darr = "↓", mdash = "—", ndash = "–", laquo = "«", raquo = "»", bull = "•", deg = "°", ordm = "º", ordf = "ª", check = "✓", hearts = "♥", star = "★", reg = "®", trade = "™", eacute = "é", aacute = "á", ccedil = "ç", atilde = "ã", otilde = "õ", ecirc = "ê", ocirc = "ô", iacute = "í", uacute = "ú", oacute = "ó", acirc = "â" }
local function entidades(s)
  if not sfind(s, "&", 1, true) then return s end
  return (s:gsub("&(#?[%w]+);", function(e)
    if e:sub(1, 2) == "#x" or e:sub(1, 2) == "#X" then local n = tonumber(e:sub(3), 16); return n and utf8.char(n) or nil end
    if e:sub(1, 1) == "#" then local n = tonumber(e:sub(2)); return n and utf8.char(n) or nil end
    return ENT[e]
  end))
end
local function lerHTML(html, pai)
  local i, n = 1, #html
  local pilha = { pai }
  local function topo() return pilha[#pilha] end
  while i <= n do
    local a = sfind(html, "<", i, true)
    if not a then
      local t = ssub(html, i)
      if t ~= "" then inserir(topo(), criarTexto(entidades(t))) end
      break
    end
    if a > i then inserir(topo(), criarTexto(entidades(ssub(html, i, a - 1)))) end
    if ssub(html, a, a + 3) == "<!--" then
      local b = sfind(html, "-->", a + 4, true); i = b and b + 3 or n + 1
    elseif ssub(html, a, a + 1) == "<!" or ssub(html, a, a + 1) == "<?" then
      local b = sfind(html, ">", a, true); i = b and b + 1 or n + 1
    elseif ssub(html, a, a + 1) == "</" then
      local b = sfind(html, ">", a, true) or n
      local nome = slower(ssub(html, a + 2, b - 1):match("^%s*([%w%-]+)") or "")
      for k = #pilha, 2, -1 do if pilha[k]._tag == nome then for _ = #pilha, k, -1 do table.remove(pilha) end; break end end
      i = b + 1
    else
      local nome = html:match("^<([%w%-]+)", a)
      if not nome then inserir(topo(), criarTexto("<")); i = a + 1
      else
        nome = slower(nome)
        local j = a + 1 + #nome
        local el = criarElemento(nome)
        local fechou = false
        while true do
          local s0 = sfind(html, "[^%s]", j) or n + 1
          j = s0
          local c = ssub(html, j, j)
          if c == ">" then j = j + 1; break end
          if c == "/" and ssub(html, j + 1, j + 1) == ">" then j = j + 2; fechou = true; break end
          if j > n then break end
          local an = html:match("^[^%s=/>]+", j)
          if not an then j = j + 1 else
            j = j + #an
            local s1 = sfind(html, "[^%s]", j) or n + 1
            local v = ""
            if ssub(html, s1, s1) == "=" then
              j = sfind(html, "[^%s]", s1 + 1) or n + 1
              local q = ssub(html, j, j)
              if q == '"' or q == "'" then local fim = sfind(html, q, j + 1, true) or n + 1; v = ssub(html, j + 1, fim - 1); j = fim + 1
              else local fim = sfind(html, "[%s>]", j) or n + 1; v = ssub(html, j, fim - 1); j = fim end
            end
            EL.setAttribute(el, an, entidades(v))
          end
        end
        inserir(topo(), el)
        i = j
        if nome == "script" or nome == "style" or nome == "textarea" or nome == "title" then
          local fim = sfind(slower(html), "</" .. nome, i, true) or n + 1
          local conteudo = ssub(html, i, fim - 1)
          if conteudo ~= "" then inserir(el, criarTexto(nome == "textarea" and entidades(conteudo) or conteudo)) end
          local b = sfind(html, ">", fim, true); i = b and b + 1 or n + 1
        elseif not fechou and not VAZIOS[nome] then pilha[#pilha + 1] = el end
      end
    end
  end
end
N.lerHTML = lerHTML
local function escapar(s, attr) s = s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"); if attr then s = s:gsub('"', "&quot;") end; return s end
local function escrever(no)
  if no.nodeType == 3 then return escapar(no._texto) end
  local t = { "<", no._tag }
  if #no._ordem > 0 then t[#t + 1] = ' class="' .. escapar(table.concat(no._ordem, " "), true) .. '"' end
  local nomes = {}
  for k in pairs(no._attr) do nomes[#nomes + 1] = k end
  table.sort(nomes)
  for _, k in ipairs(nomes) do local v = no._attr[k]; if v == "" then t[#t + 1] = " " .. k else t[#t + 1] = " " .. k .. '="' .. escapar(v, true) .. '"' end end
  t[#t + 1] = ">"
  if VAZIOS[no._tag] then return table.concat(t) end
  for _, f in ipairs(no._filhos) do t[#t + 1] = escrever(f) end
  t[#t + 1] = "</" .. no._tag .. ">"
  return table.concat(t)
end
GET.innerHTML = function(el) local t = {}; for _, f in ipairs(filhos(el)) do t[#t + 1] = escrever(f) end; return table.concat(t) end
SET.innerHTML = function(el, v) for _, f in ipairs({ unpack(el._filhos) }) do tirar(f) end; lerHTML(str(v or ""), el); mudou() end
GET.outerHTML = function(el) return escrever(el) end
function EL.insertAdjacentHTML(el, pos, html)
  local tmp = criarElemento("div"); lerHTML(str(html), tmp)
  local nos = { unpack(tmp._filhos) }
  pos = slower(str(pos))
  for _, f in ipairs(nos) do
    if pos == "beforeend" then inserir(el, f)
    elseif pos == "afterbegin" then inserir(el, f, el._filhos[1])
    elseif pos == "beforebegin" then EL.before(el, f)
    else EL.after(el, f) end
  end
end
function EL.insertAdjacentElement(el, pos, f) pos = slower(str(pos)); if pos == "beforeend" then inserir(el, f) elseif pos == "afterbegin" then inserir(el, f, el._filhos[1]) elseif pos == "beforebegin" then EL.before(el, f) else EL.after(el, f) end; return f end

-- seletores ---------------------------------------------------------------------------------------------------
local cacheSel = {}
local function lerSeletor(sel)
  local c = cacheSel[sel]
  if c then return c end
  local grupos = {}
  local i, n = 1, #sel
  local function espaco() local a = sfind(sel, "[^%s]", i); i = a or n + 1 end
  local function composto()
    local cp = { classes = {}, attrs = {}, nots = {}, pseudo = {} }
    local algo = false
    while i <= n do
      local c = ssub(sel, i, i)
      if c == "#" then local nome = sel:match("^[%w_%-]+", i + 1); cp.id = nome; i = i + 1 + #nome; algo = true
      elseif c == "." then local nome = sel:match("^[%w_%-]+", i + 1); cp.classes[#cp.classes + 1] = nome; i = i + 1 + #nome; algo = true
      elseif c == "*" then i = i + 1; algo = true
      elseif c == "[" then
        local fim = sfind(sel, "]", i, true)
        local dentro = ssub(sel, i + 1, fim - 1)
        local nome, op, val = dentro:match("^%s*([%w_%-:]+)%s*([~|%^%$%*]?=)%s*(.-)%s*$")
        if nome then val = val:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1"); cp.attrs[#cp.attrs + 1] = { slower(nome), op, val } else cp.attrs[#cp.attrs + 1] = { slower((dentro:gsub("%s", ""))) } end
        i = fim + 1; algo = true
      elseif c == ":" then
        local nome = sel:match("^:+([%w%-]+)", i)
        local j = i + #(sel:match("^:+", i)) + #nome
        local arg
        if ssub(sel, j, j) == "(" then
          local prof, k = 1, j + 1
          while k <= n and prof > 0 do local ch = ssub(sel, k, k); if ch == "(" then prof = prof + 1 elseif ch == ")" then prof = prof - 1 end; k = k + 1 end
          arg = ssub(sel, j + 1, k - 2); j = k
        end
        if nome == "not" then cp.nots[#cp.nots + 1] = lerSeletor(arg) else cp.pseudo[#cp.pseudo + 1] = { nome, arg } end
        i = j; algo = true
      elseif c:match("[%w_%-]") then local nome = sel:match("^[%w_%-]+", i); cp.tag = slower(nome); i = i + #nome; algo = true
      else break end
    end
    return algo and cp or nil
  end
  local atual = {}
  espaco()
  while i <= n do
    local cp = composto()
    if cp then atual[#atual + 1] = cp end
    local antes = i
    espaco()
    local c = ssub(sel, i, i)
    if c == "," then grupos[#grupos + 1] = atual; atual = {}; i = i + 1; espaco()
    elseif c == ">" or c == "+" or c == "~" then atual[#atual + 1] = c; i = i + 1; espaco()
    elseif i > antes and i <= n then atual[#atual + 1] = " "
    elseif not cp and i <= n then i = i + 1 end
  end
  if #atual > 0 then grupos[#grupos + 1] = atual end
  cacheSel[sel] = grupos
  return grupos
end
N.lerSeletor = lerSeletor
local bateGrupos
local function bateComposto(el, cp)
  if el.nodeType ~= 1 then return false end
  if cp.tag and el._tag ~= cp.tag then return false end
  if cp.id and el._attr.id ~= cp.id then return false end
  for _, c in ipairs(cp.classes) do if not el._cls[c] then return false end end
  for _, a in ipairs(cp.attrs) do
    local v = (a[1] == "class") and EL.getAttribute(el, "class") or el._attr[a[1]]
    if v == nil then return false end
    local op, val = a[2], a[3]
    if op == "=" and v ~= val then return false end
    if op == "~=" then local ok = false; for p in v:gmatch("%S+") do if p == val then ok = true end end; if not ok then return false end end
    if op == "^=" and v:sub(1, #val) ~= val then return false end
    if op == "$=" and (val == "" or v:sub(-#val) ~= val) then return false end
    if op == "*=" and not sfind(v, val, 1, true) then return false end
    if op == "|=" and v ~= val and v:sub(1, #val + 1) ~= val .. "-" then return false end
  end
  for _, g in ipairs(cp.nots) do if bateGrupos(el, g) then return false end end
  for _, p in ipairs(cp.pseudo) do
    local nome = p[1]
    if nome == "first-child" then if GET.previousElementSibling(el) then return false end
    elseif nome == "last-child" then if GET.nextElementSibling(el) then return false end
    elseif nome == "checked" then if not el._attr.checked then return false end
    elseif nome == "disabled" then if not el._attr.disabled then return false end
    elseif nome == "focus" or nome == "focus-visible" or nome == "focus-within" then if N.document.activeElement ~= el then return false end
    elseif nome == "hover" or nome == "active" then if not rawget(el, "_hover") then return false end
    elseif nome == "empty" then if #el._filhos > 0 then return false end
    elseif nome == "scope" or nome == "root" then if nome == "root" and el._tag ~= "html" then return false end
    elseif nome == "nth-child" then
      local idx = 0; local o = el; while o do idx = idx + 1; o = GET.previousElementSibling(o) end
      local a = p[2] or ""
      if a == "odd" then if idx % 2 ~= 1 then return false end elseif a == "even" then if idx % 2 ~= 0 then return false end elseif tonumber(a) then if idx ~= tonumber(a) then return false end end
    elseif nome == "is" or nome == "where" then if not bateGrupos(el, lerSeletor(p[2])) then return false end
    elseif nome == "has" then if not EL.querySelector(el, p[2]) then return false end
    end
  end
  return true
end
-- confere de trás para frente (o último composto é o próprio elemento)
local function bateCadeia(el, cadeia, k)
  local cp = cadeia[k]
  if not bateComposto(el, cp) then return false end
  if k == 1 then return true end
  local comb = cadeia[k - 1]
  if comb == ">" then local p = GET.parentElement(el); return p ~= nil and bateCadeia(p, cadeia, k - 2) end
  if comb == " " then local p = GET.parentElement(el); while p do if bateCadeia(p, cadeia, k - 2) then return true end; p = GET.parentElement(p) end; return false end
  if comb == "+" then local s = GET.previousElementSibling(el); return s ~= nil and bateCadeia(s, cadeia, k - 2) end
  if comb == "~" then local s = GET.previousElementSibling(el); while s do if bateCadeia(s, cadeia, k - 2) then return true end; s = GET.previousElementSibling(s) end; return false end
  return bateCadeia(el, cadeia, k - 1)
end
bateGrupos = function(el, grupos)
  for _, cadeia in ipairs(grupos) do if #cadeia > 0 and bateCadeia(el, cadeia, #cadeia) then return true end end
  return false
end
N.bate = function(el, sel) return bateGrupos(el, lerSeletor(sel)) end
local function percorrer(raiz, f) for _, c in ipairs(filhos(raiz)) do if c.nodeType == 1 then if f(c) then return true end; if percorrer(c, f) then return true end end end; return false end
N.percorrer = percorrer
function EL.querySelector(el, sel)
  local g = lerSeletor(str(sel)); local achado
  percorrer(el, function(c) if bateGrupos(c, g) then achado = c; return true end end)
  return achado
end
function EL.querySelectorAll(el, sel)
  local g = lerSeletor(str(sel)); local t = {}
  percorrer(el, function(c) if bateGrupos(c, g) then t[#t + 1] = c end end)
  return lista(t, #t)
end
function EL.getElementsByClassName(el, c) return EL.querySelectorAll(el, "." .. str(c):gsub("%s+", ".")) end
function EL.getElementsByTagName(el, t) return EL.querySelectorAll(el, str(t)) end
function EL.matches(el, sel) return bateGrupos(el, lerSeletor(str(sel))) end
function EL.closest(el, sel) local g = lerSeletor(str(sel)); local o = el; while o and o.nodeType == 1 do if bateGrupos(o, g) then return o end; o = rawget(o, "_pai") end; return nil end

-- eventos -----------------------------------------------------------------------------------------------------
local function novoEvento(tipo, init)
  local ev = { type = str(tipo), bubbles = false, cancelable = true, defaultPrevented = false, timeStamp = agoraMs, isTrusted = true, _parar = false, _pararJa = false }
  if type(init) == "table" then for k, v in pairs(init) do ev[k] = v end end
  ev.preventDefault = function(e) (e or ev).defaultPrevented = true end
  ev.stopPropagation = function(e) (e or ev)._parar = true end
  ev.stopImmediatePropagation = function(e) local x = e or ev; x._parar = true; x._pararJa = true end
  ev.composedPath = function() return lista({}) end
  return ev
end
N.novoEvento = novoEvento
local function addEv(alvo, tipo, f, op)
  if f == nil then return end
  tipo = str(tipo)
  local captura = (op == true) or (type(op) == "table" and truthy(op.capture))
  local uma = type(op) == "table" and truthy(op.once)
  local ev = rawget(alvo, "_ev")
  if not ev then ev = {}; rawset(alvo, "_ev", ev) end
  local l = ev[tipo]
  if not l then l = {}; ev[tipo] = l end
  for _, x in ipairs(l) do if x.f == f and x.cap == captura then return end end
  l[#l + 1] = { f = f, cap = captura, uma = uma }
  if type(op) == "table" and op.signal and type(op.signal) == "table" then
    local s = op.signal
    s._ouvintes = s._ouvintes or {}
    table.insert(s._ouvintes, function() for i = #l, 1, -1 do if l[i].f == f then table.remove(l, i) end end end)
  end
end
local function remEv(alvo, tipo, f, op)
  local ev = rawget(alvo, "_ev"); if not ev then return end
  local l = ev[str(tipo)]; if not l then return end
  local captura = (op == true) or (type(op) == "table" and truthy(op.capture))
  for i = #l, 1, -1 do if l[i].f == f and l[i].cap == captura then table.remove(l, i) end end
end
local function chamarOuvintes(alvo, ev, fase)
  ev.currentTarget = alvo
  local evs = rawget(alvo, "_ev")
  local l = evs and evs[ev.type]
  if l then
    for _, x in ipairs({ unpack(l) }) do
      if (fase == 2) or (fase == 1 and x.cap) or (fase == 3 and not x.cap) then
        if x.uma then remEv(alvo, ev.type, x.f, x.cap) end
        local f = x.f
        if type(f) == "table" and f.handleEvent then chamar("evento " .. ev.type, f.handleEvent, f, ev) else chamar("evento " .. ev.type, f, alvo, ev) end
        if ev._pararJa then return end
      end
    end
  end
  if fase ~= 1 then
    local h = rawget(alvo, "on" .. ev.type)
    if type(h) == "function" then local ok, r = pcall(h, alvo, ev); if not ok then N.erro("on" .. ev.type, r) elseif r == false then ev.defaultPrevented = true end end
  end
end
local function despachar(alvo, ev)
  ev.target = alvo
  if ev.srcElement == nil then ev.srcElement = alvo end
  local caminho = {}
  local o = rawget(alvo, "_pai")
  while o do caminho[#caminho + 1] = o; o = rawget(o, "_pai") end
  if alvo ~= window and (alvo == N.document or #caminho > 0 and caminho[#caminho] == N.document) then caminho[#caminho + 1] = window end
  ev.eventPhase = 1
  for k = #caminho, 1, -1 do chamarOuvintes(caminho[k], ev, 1); if ev._parar then return not ev.defaultPrevented end end
  ev.eventPhase = 2
  chamarOuvintes(alvo, ev, 2)
  if ev._parar then return not ev.defaultPrevented end
  if ev.bubbles then
    ev.eventPhase = 3
    for k = 1, #caminho do chamarOuvintes(caminho[k], ev, 3); if ev._parar then break end end
  end
  return not ev.defaultPrevented
end
N.despachar = despachar
function EL.addEventListener(el, tipo, f, op) addEv(el, tipo, f, op) end
function EL.removeEventListener(el, tipo, f, op) remEv(el, tipo, f, op) end
function EL.dispatchEvent(el, ev) return despachar(el, ev) end
function EL.click(el)
  if el._attr and el._attr.disabled then return end
  local ev = novoEvento("click", { bubbles = true, clientX = 0, clientY = 0, button = 0, detail = 1 })
  despachar(el, ev)
  if not ev.defaultPrevented and el._tag == "input" and (el._attr.type == "checkbox" or el._attr.type == "radio") then end
end
function EL.focus(el) local d = N.document; local antes = rawget(d, "_ativo"); if antes == el then return end; rawset(d, "_ativo", el); if antes then despachar(antes, novoEvento("blur")) end; despachar(el, novoEvento("focus")) end
function EL.blur(el) local d = N.document; if rawget(d, "_ativo") == el then rawset(d, "_ativo", nil); despachar(el, novoEvento("blur")) end end
function EL.select() end
function EL.scrollIntoView() end
function EL.scrollTo() end
function EL.scrollBy() end
function EL.setPointerCapture(el, id) N.capturas[id] = el end
function EL.releasePointerCapture(el, id) if N.capturas[id] == el then N.capturas[id] = nil end end
function EL.hasPointerCapture(el, id) return N.capturas[id] == el end
N.capturas = {}
function EL.requestFullscreen() return N.Promise.resolve(nil) end
EL.webkitRequestFullscreen = EL.requestFullscreen
function EL.animate() return { finished = N.Promise.resolve(nil), cancel = function() end, play = function() end, pause = function() end, onfinish = nil } end
function EL.getAnimations() return lista({}) end
function EL.attachShadow(el) return el end
-- <dialog>
function EL.showModal(el) el._attr.open = ""; mudou() end
function EL.show(el) el._attr.open = ""; mudou() end
function EL.close(el, v) if el._attr.open == nil then return end; el._attr.open = nil; if v ~= nil then rawset(el, "returnValue", str(v)) end; mudou(); despachar(el, novoEvento("close")) end
-- posição na tela (a interface calcula; sem ela, o canvas ocupa a tela toda)
function EL.getBoundingClientRect(el)
  local r = N.caixa and N.caixa(el)
  if not r then r = { x = 0, y = 0, width = 0, height = 0 } end
  return { x = r.x, y = r.y, left = r.x, top = r.y, width = r.width, height = r.height, right = r.x + r.width, bottom = r.y + r.height }
end
function EL.getClientRects(el) return lista({ EL.getBoundingClientRect(el) }) end
GET.offsetWidth = function(el) return EL.getBoundingClientRect(el).width end
GET.offsetHeight = function(el) return EL.getBoundingClientRect(el).height end
GET.clientWidth = GET.offsetWidth
GET.clientHeight = GET.offsetHeight
GET.scrollWidth = GET.offsetWidth
GET.scrollHeight = GET.offsetHeight
GET.offsetLeft = function(el) return EL.getBoundingClientRect(el).left end
GET.offsetTop = function(el) return EL.getBoundingClientRect(el).top end
GET.offsetParent = function(el) return GET.parentElement(el) end
GET.scrollTop = function() return 0 end
GET.scrollLeft = function() return 0 end
GET.files = function() return lista({}) end
GET.options = function(el) return EL.querySelectorAll(el, "option") end
GET.selectedIndex = function(el) local ops = filhos(el); local v = GET.value(el); local k = 0; for _, o in ipairs(ops) do if o.nodeType == 1 and o._tag == "option" then if (o._attr.value or textoDe(o)) == v then return k end; k = k + 1 end end; return -1 end
GET.content = function(el) local frag = criarElemento("template-content"); rawset(frag, "_fragmento", true); for _, f in ipairs(filhos(el)) do inserir(frag, EL.cloneNode(f, true)) end; return frag end

-- document ---------------------------------------------------------------------------------------------------
local document = setmetatable({}, elMT)
iniciarElemento(document, "#document")
rawset(document, "nodeType", 9)
N.document = document
window.document = document
local html = criarElemento("html"); inserir(document, html)
local head = criarElemento("head"); inserir(html, head)
local body = criarElemento("body"); inserir(html, body)
rawset(document, "documentElement", html)
rawset(document, "head", head)
rawset(document, "body", body)
rawset(document, "readyState", "complete")
rawset(document, "hidden", false)
rawset(document, "visibilityState", "visible")
rawset(document, "title", "Da Roça Adventure")
rawset(document, "cookie", "")
rawset(document, "referrer", "")
rawset(document, "fullscreenEnabled", false)
rawset(document, "pointerLockElement", nil)
GET.activeElement = function(d) if d == document then return rawget(document, "_ativo") or body end; return nil end
rawset(document, "createElement", function(_, tag) return criarElemento(tag) end)
rawset(document, "createElementNS", function(_, _ns, tag) return criarElemento(tag) end)
rawset(document, "createTextNode", function(_, t) return criarTexto(t) end)
rawset(document, "createComment", function() return criarTexto("") end)
rawset(document, "createDocumentFragment", function() local f = criarElemento("fragment"); rawset(f, "_fragmento", true); return f end)
local cacheId = {}
rawset(document, "getElementById", function(_, id)
  id = str(id)
  local c = cacheId[id]
  if c and c._attr.id == id and GET.isConnected(c) then return c end
  local achado
  percorrer(document, function(e) if e._attr.id == id then achado = e; return true end end)
  cacheId[id] = achado
  return achado
end)
rawset(document, "exitFullscreen", function() return N.Promise.resolve(nil) end)
rawset(document, "elementFromPoint", function(_, x, y) return N.elementoEm and N.elementoEm(x, y) or nil end)
rawset(document, "hasFocus", function() return true end)
rawset(document, "execCommand", function() return false end)
rawset(document, "fonts", { ready = nil, load = function() return N.Promise.resolve(lista({})) end, add = function() end, check = function() return true end, addEventListener = function() end })
GET.fullscreenElement = function() return nil end
GET.webkitFullscreenElement = GET.fullscreenElement
GET.scrollingElement = function() return html end

-- window: eventos, tela, armazenamento -------------------------------------------------------------------------
window.addEventListener = function(_, tipo, f, op) addEv(window, tipo, f, op) end
window.removeEventListener = function(_, tipo, f, op) remEv(window, tipo, f, op) end
window.dispatchEvent = function(_, ev) return despachar(window, ev) end
window.innerWidth, window.innerHeight, window.devicePixelRatio = 960, 540, 1
window.outerWidth, window.outerHeight = 960, 540
window.scrollX, window.scrollY, window.pageXOffset, window.pageYOffset = 0, 0, 0, 0
window.screen = { width = 960, height = 540, availWidth = 960, availHeight = 540, orientation = { type = "landscape-primary", angle = 0, lock = function() return N.Promise.reject("sem suporte") end, unlock = function() end, addEventListener = function() end } }
window.visualViewport = { width = 960, height = 540, scale = 1, offsetLeft = 0, offsetTop = 0, addEventListener = function() end, removeEventListener = function() end }
window.scrollTo, window.scrollBy, window.focus, window.blur, window.print, window.alert = function() end, function() end, function() end, function() end, function() end, function() end
window.confirm = function() return true end
window.prompt = function() return nil end
window.open = function() return nil end
window.close = function() end
window.postMessage = function() end
window.getSelection = function() return { removeAllRanges = function() end, toString = function() return "" end } end
window.navigator = {
  userAgent = "Mozilla/5.0 (Roblox) DaRocaRoblox", platform = "Roblox", language = "pt-BR", languages = lista({ "pt-BR", "pt" }), onLine = false, maxTouchPoints = 0, hardwareConcurrency = 4, deviceMemory = 4,
  vendor = "", standalone = false, cookieEnabled = false,
  vibrate = function() return false end, getGamepads = function() return lista({}) end,
  serviceWorker = nil, share = nil, clipboard = { writeText = function() return N.Promise.resolve(nil) end },
  wakeLock = nil, mediaSession = nil,
}
window.location = { href = "https://roblox.local/index.html", origin = "https://roblox.local", protocol = "https:", host = "roblox.local", hostname = "roblox.local", port = "", pathname = "/index.html", search = "", hash = "",
  reload = function() if N.aoRecarregar then N.aoRecarregar() end end, replace = function() end, assign = function() end }
window.history = { length = 1, state = nil, pushState = function() end, replaceState = function() end, back = function() end }
window.isSecureContext = true
window.origin = "https://roblox.local"
window.name = ""
-- media queries do jogo: decide pela tela e pelo modo (toque ou mouse)
N.toque = false
window.matchMedia = function(_, q)
  q = str(q)
  local function avalia()
    local w, h = window.innerWidth, window.innerHeight
    local ok = true
    for parte in q:gmatch("%(([^%)]+)%)") do
      local nome, valor = parte:match("^%s*([%w%-]+)%s*:?%s*(.-)%s*$")
      local num = tonumber((valor or ""):match("^([%d%.]+)"))
      if nome == "max-width" then ok = ok and w <= num
      elseif nome == "min-width" then ok = ok and w >= num
      elseif nome == "max-height" then ok = ok and h <= num
      elseif nome == "min-height" then ok = ok and h >= num
      elseif nome == "orientation" then ok = ok and ((valor == "landscape") == (w >= h))
      elseif nome == "pointer" or nome == "any-pointer" then ok = ok and ((valor == "coarse") == N.toque)
      elseif nome == "hover" or nome == "any-hover" then ok = ok and ((valor == "hover") ~= N.toque)
      elseif nome == "prefers-reduced-motion" then ok = ok and valor == "no-preference"
      elseif nome == "prefers-color-scheme" then ok = ok and valor == "dark"
      elseif nome == "display-mode" then ok = ok and valor == "browser"
      end
    end
    if q:find("^%s*not%s") then ok = not ok end
    return ok
  end
  local mq = { media = q, onchange = nil }
  setmetatable(mq, { __index = function(_, k) if k == "matches" then return avalia() end end })
  mq.addEventListener = function() end; mq.removeEventListener = function() end; mq.addListener = function() end; mq.removeListener = function() end
  return mq
end
window.getComputedStyle = function(_, el) if N.estiloCalculado then return N.estiloCalculado(el) end; return setmetatable({ getPropertyValue = function() return "" end }, { __index = function() return "" end }) end

-- localStorage / sessionStorage (o hospedeiro salva no DataStore do jogador)
local function novoArmazem()
  local dados = {}
  local a = {}
  a.getItem = function(_, k) local v = dados[str(k)]; return v end
  a.setItem = function(_, k, v) dados[str(k)] = str(v); if a._aoMudar then a._aoMudar(str(k)) end end
  a.removeItem = function(_, k) dados[str(k)] = nil; if a._aoMudar then a._aoMudar(str(k)) end end
  a.clear = function() for k in pairs(dados) do dados[k] = nil end; if a._aoMudar then a._aoMudar(nil) end end
  a.key = function(_, i) local ks = {}; for k in pairs(dados) do ks[#ks + 1] = k end; table.sort(ks); return ks[floor(i) + 1] end
  a._dados = function() return dados end
  a._carregar = function(t) for k in pairs(dados) do dados[k] = nil end; for k, v in pairs(t or {}) do dados[k] = v end end
  setmetatable(a, { __index = function(_, k) if k == "length" then local n = 0; for _ in pairs(dados) do n = n + 1 end; return n end; return dados[k] end })
  return a
end
window.localStorage = novoArmazem()
window.sessionStorage = novoArmazem()

-- objetos que o jogo cria com "new" (o conversor troca new X() por __new("X", ...)) --------------------------
local function semNada()
  return setmetatable({}, { __index = function(_, k) if k == "then" then return nil end; return function() return nil end end })
end
local CRIAR = {}
CRIAR.Array = function(...) local n = select("#", ...); if n == 1 and type((...)) == "number" then local t = { [JS.LENK] = floor((...)) }; return setmetatable(t, JS.ARR) end; return JS.__arr(...) end
for _, nome in ipairs({ "Uint8ClampedArray", "Uint8Array", "Int8Array", "Uint16Array", "Int16Array", "Uint32Array", "Int32Array", "Float32Array", "Float64Array" }) do
  CRIAR[nome] = function(a) if type(a) == "table" and a._buffer then return JS.tipada(nome, a._buffer) end; return JS.tipada(nome, a) end
end
CRIAR.ArrayBuffer = function(n) return { _buffer = floor(n or 0), byteLength = floor(n or 0) } end
CRIAR.Date = function(...) return JS.novaData(...) end
CRIAR.CustomEvent = function(tipo, init) local ev = novoEvento(tipo, init); ev.detail = init and init.detail; return ev end
CRIAR.Event = function(tipo, init) return novoEvento(tipo, init) end
CRIAR.KeyboardEvent = CRIAR.Event
CRIAR.PointerEvent = CRIAR.Event
CRIAR.MouseEvent = CRIAR.Event
CRIAR.ImageData = function(a, b, c)
  if type(a) == "table" then return { data = a, width = b, height = c or floor(JS.__len(a) / 4 / b) } end
  return { data = JS.tipada("Uint8ClampedArray", a * b * 4), width = a, height = b }
end
CRIAR.Image = function(w, h)
  local img = criarElemento("img")
  rawset(img, "width", w or 0); rawset(img, "height", h or 0); rawset(img, "naturalWidth", 0); rawset(img, "naturalHeight", 0); rawset(img, "complete", false)
  return img
end
CRIAR.Audio = function(src) local a = criarElemento("audio"); if src then a._attr.src = str(src) end; rawset(a, "paused", true); rawset(a, "volume", 1); rawset(a, "currentTime", 0); rawset(a, "loop", false); rawset(a, "muted", false); rawset(a, "readyState", 4); return a end
-- MutationObserver: avisa o jogo quando a página mudou (o jogo usa para trocar telas e classes)
local observadores = setmetatable({}, { __mode = "k" })
CRIAR.MutationObserver = function(cb)
  local o = { _alvos = {}, _versao = versaoDom }
  o.observe = function(_, alvo, op) if alvo then o._alvos[#o._alvos + 1] = { alvo = alvo, op = op or {} }; o._versao = versaoDom; observadores[o] = cb end end
  o.disconnect = function() o._alvos = {}; observadores[o] = nil end
  o.takeRecords = function() return lista({}) end
  return o
end
function N.avisarObservadores()
  for o, cb in pairs(observadores) do
    if o._versao ~= versaoDom and #o._alvos > 0 then
      o._versao = versaoDom
      local regs = {}
      for _, a in ipairs(o._alvos) do regs[#regs + 1] = { type = (a.op.attributes or a.op.attributeFilter) and "attributes" or "childList", target = a.alvo, attributeName = a.op.attributeFilter and JS.__get(a.op.attributeFilter, 0) or nil, addedNodes = lista({}), removedNodes = lista({}) } end
      chamar("MutationObserver", cb, nil, lista(regs, #regs), o)
    end
  end
end
CRIAR.ResizeObserver = function(cb) return { observe = function() end, unobserve = function() end, disconnect = function() end } end
CRIAR.IntersectionObserver = CRIAR.ResizeObserver
CRIAR.AbortController = function() local s = { aborted = false }; s.addEventListener = function() end; local c = { signal = s }; c.abort = function() s.aborted = true; for _, f in ipairs(s._ouvintes or {}) do f() end end; return c end
CRIAR.URLSearchParams = function(s)
  local dados = {}
  s = str(s or ""):gsub("^%?", "")
  for par in s:gmatch("[^&]+") do local k, v = par:match("^([^=]*)=?(.*)$"); dados[#dados + 1] = { k, v } end
  local u = {}
  u.get = function(_, k) for _, p in ipairs(dados) do if p[1] == k then return p[2] end end; return nil end
  u.has = function(_, k) for _, p in ipairs(dados) do if p[1] == k then return true end end; return false end
  u.set = function(_, k, v) dados[#dados + 1] = { k, str(v) } end
  u.toString = function() local t = {}; for _, p in ipairs(dados) do t[#t + 1] = p[1] .. "=" .. p[2] end; return table.concat(t, "&") end
  return u
end
CRIAR.URL = function(u, base) u = str(u); return { href = u, pathname = u:match("^[%w]+://[^/]+(/[^?#]*)") or u, search = u:match("(%?[^#]*)") or "", hash = u:match("(#.*)$") or "", origin = "https://roblox.local", searchParams = CRIAR.URLSearchParams(u:match("%?([^#]*)") or ""), toString = function() return u end } end
CRIAR.TextEncoder = function() return { encode = function(_, s) local t = { string.byte(str(s), 1, -1) }; return JS.tipada("Uint8Array", lista(t, #t)) end } end
CRIAR.TextDecoder = function() return { decode = function(_, a) local t = {}; for i = 1, JS.__len(a) do t[i] = string.char(JS.__get(a, i - 1)) end; return table.concat(t) end } end
CRIAR.Blob = function() return { size = 0, type = "" } end
CRIAR.FileReader = function() return semNada() end
CRIAR.WebSocket = function() local ws = { readyState = 3, send = function() end, close = function() end, addEventListener = function() end, removeEventListener = function() end }; return ws end
CRIAR.BroadcastChannel = function() return { postMessage = function() end, close = function() end, addEventListener = function() end } end
CRIAR.Worker = function() return semNada() end
CRIAR.DOMMatrix = function() return { a = 1, b = 0, c = 0, d = 1, e = 0, f = 0, isIdentity = true } end
CRIAR.Path2D = function() return { _cmds = {}, moveTo = function() end, lineTo = function() end, rect = function() end, arc = function() end, closePath = function() end } end
CRIAR.FontFace = function() return { load = function() return N.Promise.resolve(nil) end } end
CRIAR.OffscreenCanvas = function(w, h) return N.criarCanvas(w, h) end
N.CRIAR = CRIAR
-- os construtores também ficam no window (para new window.X(...) e new (a || b)(...))
for nome, f in pairs(CRIAR) do
  if window[nome] == nil then
    local tipada = nome:match("Array$") and nome ~= "Array"
    window[nome] = setmetatable({
      prototype = {}, BYTES_PER_ELEMENT = tipada and (nome:match("8") and 1 or nome:match("16") and 2 or nome:match("64") and 8 or 4) or nil,
      from = tipada and function(_, a, fm) return JS.tipada(nome, JS.__arrayFrom(a, fm)) end or nil,
      of = tipada and function(_, ...) return JS.tipada(nome, JS.__arr(...)) end or nil,
    }, { __call = function(_, _este, ...) return f(...) end })
  end
end
function JS.__new(nome, ...)
  local f = CRIAR[nome]
  if f then return f(...) end
  local c = window[nome]
  if type(c) == "function" then return c(nil, ...) end
  return semNada()
end
-- funções globais que o jogo chama sem "new"
window.Image = function(_, ...) return CRIAR.Image(...) end
window.CustomEvent = function(_, ...) return CRIAR.CustomEvent(...) end
window.Event = window.CustomEvent
window.HTMLCanvasElement = { prototype = {} }
window.HTMLElement = { prototype = {} }
window.Element = { prototype = {} }
window.CanvasRenderingContext2D = { prototype = { roundRect = true, ellipse = true } }
window.Date = JS.Date
window.JSON = JS.JSON
window.atob = function(_, s) return str(s) end
window.btoa = function(_, s) return str(s) end
window.encodeURIComponent = function(_, s) return (str(s):gsub("[^%w%-_%.!~%*'%(%)]", function(c) return sfmt("%%%02X", string.byte(c)) end)) end
window.decodeURIComponent = function(_, s) return (str(s):gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)) end
window.encodeURI = window.encodeURIComponent
window.decodeURI = window.decodeURIComponent
window.escape = window.encodeURIComponent
window.structuredClone = function(_, v) return JS.JSON.parse(nil, JS.JSON.stringify(nil, v)) end
window.isNaN = function(_, v) v = JS.tonum(v); return v ~= v end
window.isFinite = function(_, v) v = JS.tonum(v); return v == v and v ~= math.huge and v ~= -math.huge end
window.parseFloat = function(_, s) local n = tonumber(str(s):match("^%s*([-+]?%d*%.?%d+[eE]?[-+]?%d*)") or str(s):match("^%s*([-+]?%d+)")); return n or (0 / 0) end
window.parseInt = function(_, s, b) s = str(s); b = b and JS.tonum(b) or 10; local m = s:match("^%s*([-+]?[%w]+)"); local n = m and tonumber(m, b ~= 0 and b or 10); if not n and m then n = tonumber(m:match("^[-+]?%d+")) end; return n or (0 / 0) end
window.Boolean = function(_, v) return truthy(v) end
window.String = function(_, v) return str(v) end
window.Number = function(_, v) if v == nil then return 0 end; return JS.tonum(v) end

-- arquivos embutidos (roteiros, listas, manifestos) para o fetch ------------------------------------------------
N.arquivos = {}
local function caminhoLimpo(u)
  u = str(u):gsub("[?#].*$", ""):gsub("^https?://[^/]+/", ""):gsub("^%./", ""):gsub("^/", ""):gsub("^dist/", "")
  return u
end
N.caminhoLimpo = caminhoLimpo
local function resposta(texto, status)
  local r = { ok = status >= 200 and status < 300, status = status, statusText = "", url = "", redirected = false, headers = { get = function() return nil end, has = function() return false end } }
  r.text = function() return N.Promise.resolve(texto or "") end
  r.json = function() local ok, v = pcall(JS.JSON.parse, nil, texto or ""); if ok then return N.Promise.resolve(v) end; return N.Promise.reject(v) end
  r.arrayBuffer = function() return N.Promise.resolve({ byteLength = #(texto or "") }) end
  r.blob = function() return N.Promise.resolve({ size = #(texto or "") }) end
  r.clone = function() return r end
  return r
end
window.fetch = function(_, url, op)
  local p = caminhoLimpo(url)
  local conteudo = N.arquivos[p]
  if type(conteudo) == "function" then conteudo = conteudo() end
  if conteudo then return N.Promise.resolve(resposta(conteudo, 200)) end
  if p:sub(1, 4) == "api/" or str(url):find("^https?://") then return N.Promise.reject(CRIAR.Event("TypeError: sem internet no Roblox")) end
  return N.Promise.resolve(resposta("", 404))
end

-- entrada vinda do hospedeiro -------------------------------------------------------------------------------------
local teclasPresas = {}
function N.tecla(tipo, code, key, repetida)
  local alvo = rawget(document, "_ativo") or body
  local ev = novoEvento(tipo, { bubbles = true, code = code, key = key or code, ["repeat"] = repetida or false, keyCode = 0, which = 0,
    shiftKey = teclasPresas.ShiftLeft or teclasPresas.ShiftRight or false, ctrlKey = false, altKey = false, metaKey = false, isComposing = false })
  if tipo == "keydown" then teclasPresas[code] = true else teclasPresas[code] = nil end
  despachar(alvo, ev)
  N.microtarefas()
  -- digitação em <input>/<textarea> com foco (o navegador faria sozinho)
  if tipo == "keydown" and not ev.defaultPrevented and alvo ~= body and (alvo._tag == "input" or alvo._tag == "textarea") then
    local v = tostring(GET.value(alvo) or "")
    if key == "Backspace" then v = v:gsub("[%z\1-\127\194-\244][\128-\191]*$", "")
    elseif type(key) == "string" and #key >= 1 and (#key == 1 or utf8.len(key) == 1) then v = v .. key
    else return ev end
    SET.value(alvo, v)
    despachar(alvo, novoEvento("input", { bubbles = true, data = key, inputType = key == "Backspace" and "deleteContentBackward" or "insertText" }))
  end
  return ev
end
-- ponteiro (mouse ou dedo) em coordenadas da tela do jogo (window.innerWidth x innerHeight)
local ponteiros = {}
function N.ponteiro(tipo, x, y, id, toque)
  id = id or 1
  local alvo = N.capturas[id]
  if not alvo then alvo = (N.elementoEm and N.elementoEm(x, y)) or N.alvoPadrao or body end
  local init = { bubbles = true, clientX = x, clientY = y, pageX = x, pageY = y, screenX = x, screenY = y, offsetX = x, offsetY = y, pointerId = id, pointerType = toque and "touch" or "mouse", isPrimary = true,
    button = 0, buttons = (tipo == "pointerup" or tipo == "pointercancel") and 0 or 1, width = 1, height = 1, pressure = 0.5 }
  local ev = novoEvento(tipo, init)
  despachar(alvo, ev)
  if tipo == "pointerdown" then
    ponteiros[id] = alvo
    -- foco em campo de texto ou botão tocado
    local f = alvo
    while f and f ~= body and f.nodeType == 1 and f._tag ~= "input" and f._tag ~= "textarea" and f._tag ~= "button" and f._tag ~= "select" do f = rawget(f, "_pai") end
    if f and f ~= body and f.nodeType == 1 and f._tag then EL.focus(f); if (f._tag == "input" or f._tag == "textarea") and N.aoFocarCampo then N.aoFocarCampo(f) end end
  end
  if tipo == "pointerup" or tipo == "pointercancel" then
    local inicio = ponteiros[id]; ponteiros[id] = nil
    if tipo == "pointerup" and inicio and (inicio == alvo or EL.contains(inicio, alvo) or EL.contains(alvo, inicio)) and not ev.defaultPrevented then
      local c = novoEvento("click", init); c.detail = 1
      despachar(inicio, c)
    end
    N.capturas[id] = nil
  end
  -- eventos de toque (alguns trechos usam touchstart/touchmove)
  if toque then
    local mapa = { pointerdown = "touchstart", pointermove = "touchmove", pointerup = "touchend", pointercancel = "touchcancel" }
    if mapa[tipo] then
      local t = { identifier = id, clientX = x, clientY = y, pageX = x, pageY = y, target = alvo }
      local tl = lista({ t }, 1)
      despachar(alvo, novoEvento(mapa[tipo], { bubbles = true, touches = (tipo == "pointerup" or tipo == "pointercancel") and lista({}) or tl, changedTouches = tl, targetTouches = tl }))
    end
  end
  return ev
end
-- texto digitado de uma vez (teclado do celular no Roblox)
function N.digitar(el, texto)
  SET.value(el, texto)
  despachar(el, novoEvento("input", { bubbles = true, data = texto, inputType = "insertText" }))
  despachar(el, novoEvento("change", { bubbles = true }))
end
function N.redimensionar(w, h)
  window.innerWidth, window.innerHeight, window.outerWidth, window.outerHeight = w, h, w, h
  window.visualViewport.width, window.visualViewport.height = w, h
  window.screen.width, window.screen.height, window.screen.availWidth, window.screen.availHeight = w, h, w, h
  despachar(window, novoEvento("resize"))
end

return N
