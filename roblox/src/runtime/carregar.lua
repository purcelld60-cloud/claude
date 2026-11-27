--[[ Liga o jogo convertido no navegador simulado (usado pelo Roblox e pelos testes em Lua 5.3):
  monta o <body> do index.html, carrega os scripts na mesma ordem do navegador e dispara DOMContentLoaded/load.
  op.exigir(nome) carrega um módulo convertido (require no teste; ModuleScript no Roblox). ]]
local Carregar = {}
function Carregar.iniciar(op)
  local JS, N, Canvas, LL = op.JS, op.N, op.Canvas, op.lualib
  local window, document = N.window, N.document
  N.Canvas = Canvas
  N.Promise = LL.__TS__Promise
  Canvas.novaLista = function(n) return JS.tipada("Uint8ClampedArray", n) end
  N.arquivos = op.exigir("arquivos")
  N.JS = JS
  -- interface fotografada e fontes reais do jogo (ferramentas/capturar.mjs)
  local okI, interface = pcall(op.exigir, "interface")
  local okF, fontes = pcall(op.exigir, "fontes")
  if okI and okF and op.Desenhista then Carregar.desenhista = op.Desenhista.iniciar({ N = N, Canvas = Canvas, interface = interface, fontes = fontes }) end
  local pag = op.exigir("pagina")
  rawset(document, "title", pag.titulo)
  document.body.className = pag.classe
  N.carregandoPagina = true
  N.lerHTML(pag.html, document.body)
  N.carregandoPagina = false
  rawset(document, "readyState", "loading")
  local carregados = {}
  local function rodarScript(src)
    local mod = src:gsub("[?#].*$", ""):gsub("^https?://[^/]+/", ""):gsub("^%./", ""):gsub("^/", ""):gsub("%.js$", ""):gsub("/", "__")
    if carregados[mod] then return true end
    carregados[mod] = true
    local t0 = os.clock()
    local ok, e = pcall(op.exigir, mod)
    if not ok then N.erro("script " .. src, e) end
    if op.aoCarregar then op.aoCarregar(mod, os.clock() - t0, ok) end
    return ok
  end
  -- scripts criados pelo jogo depois (ex.: vendor/pixelfx.js) carregam o módulo convertido correspondente
  N.aoInserir = function(no)
    if N.carregandoPagina then return end
    if no.nodeType == 1 and rawget(no, "_tag") == "script" and no._attr.src then
      local src = no._attr.src
      window.setTimeout(nil, function() local ok = rodarScript(src); N.despachar(no, N.novoEvento(ok and "load" or "error")) end, 0)
    end
  end
  for _, s in ipairs(op.exigir("ordem")) do rodarScript(s[1]) end
  rawset(document, "readyState", "interactive")
  N.despachar(document, N.novoEvento("readystatechange"))
  N.despachar(document, N.novoEvento("DOMContentLoaded", { bubbles = true }))
  rawset(document, "readyState", "complete")
  N.despachar(document, N.novoEvento("readystatechange"))
  N.despachar(window, N.novoEvento("load"))
  N.despachar(window, N.novoEvento("pageshow"))
end
return Carregar
