--!nocheck
-- Varredura no Roblox (Open Cloud): desenha todos os cenários, abre os minigames da campanha 1, o mapa e a campanha 2
-- (ou, com o argumento "fliperama", os 11 jogos do fliperama) e mostra cada erro com a etapa em que aconteceu.
-- Uso: python3 roblox/ferramentas/nuvem.py executar <universo> <lugar> roblox/teste/nuvem-cenas.lua [versão]
local RS = game:GetService("ReplicatedStorage")
local pasta = RS:FindFirstChild("DaRoca")
local versao = pasta:FindFirstChild("Versao"); print("versão: " .. (versao and versao.Value or "?"))
local runtime, jogoPasta = pasta.runtime, pasta.jogo
local ultima = os.clock()
local function ceder() if os.clock() - ultima > .2 then task.wait(); ultima = os.clock() end end
local JS = require(runtime.js); local Canvas = require(runtime.canvas); local N = require(runtime.navegador)
local Carregar = require(runtime.carregar); local Desenhista = require(runtime.desenhista); local Audio = require(runtime.audio)
local LL = require(jogoPasta.lualib_bundle)
N.window.DAROCA_ROBLOX = true
N.som = { tocar = function() end, ajustar = function() end, parar = function() end, musica = function() end }
Canvas.ceder = ceder
local MODO = ... or "cenas"
local t0 = os.clock()
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio, ceder = ceder,
    exigir = function(nome) task.wait(); ultima = os.clock(); return require(jogoPasta[nome]) end })
end)
print(("carregou: %s em %.1f s"):format(ok and "ok" or tostring(erro), os.clock() - t0))
pcall(require, jogoPasta:FindFirstChild("vendor__pixelfx"))
local vistos, nErros = {}, 0
local function erros(etapa)
  for _, e in ipairs(N.erros or {}) do local k = tostring(e):sub(1, 240); if not vistos[k] then vistos[k] = true; nErros = nErros + 1; print(("ERRO [%s]: %s"):format(etapa, k)) end end
end
local function tentar(etapa, f, ...) local okF, e = pcall(f, ...); if not okF then nErros = nErros + 1; print(("ERRO [%s]: %s"):format(etapa, tostring(e):sub(1, 240))) end; erros(etapa); return okF, e end
erros("carregamento")
local ms = 0
local function quadros(n, etapa) for _ = 1, n do ultima = os.clock(); ms = ms + 1000 / 30; pcall(N.passo, ms); task.wait() end; erros(etapa) end
local function tecla(code, key, n) N.tecla("keydown", code, key); quadros(n or 2, "tecla " .. code); N.tecla("keyup", code, key) end
local W = N.window
quadros(3, "tela inicial")

if MODO == "fliperama" then
  local F = W.Fliperama
  for _, g in ipairs(F:games()) do
    local id = g.id
    tentar("fliperama abrir " .. id, function() F:open(id) end); quadros(3, "fliperama " .. id)
    tecla("KeyJ", "j", 3) -- A: começa sozinho
    quadros(100, "fliperama " .. id .. " contagem e jogo")
    for _, k in ipairs({ "KeyD", "KeyW", "KeyA", "KeyS" }) do tecla(k, k:sub(4):lower(), 6) end
    tecla("KeyJ", "j", 4)
    local cur = select(2, pcall(F.current, F))
    print(("fliperama %s: jogando=%s"):format(id, tostring(cur)))
    tentar("fliperama fechar " .. id, function() F:close() end); quadros(2, "fechou " .. id)
  end
  print(("erros diferentes: %d · %.0f s"):format(nErros, os.clock() - t0))
  return "fim"
end

-- todos os cenários desenhados direto (duas câmeras e duas horas)
local cv = N.document:createElement("canvas"); cv.width = 960; cv.height = 540; local ctx = cv:getContext("2d")
local cenas = {}
for i = 0, 11 do cenas[#cenas + 1] = i end
for _, i in ipairs({ 40, 41, 42 }) do cenas[#cenas + 1] = i end
for _, hora in ipairs({ 11, 22 }) do
  pcall(function() W.DayTime:force(hora) end)
  for _, cena in ipairs(cenas) do
    for _, cam in ipairs({ 0, 900 }) do
      ultima = os.clock(); local t = os.clock()
      tentar(("cenário %d câmera %d hora %d"):format(cena, cam, hora), function() W.Art:drawScene(ctx, cena, cam, 3.2) end)
      local dt = os.clock() - t
      if dt > .25 then print(("  cenário %d câmera %d hora %d: %.2f s"):format(cena, cam, hora, dt)) end
      task.wait()
    end
  end
end
pcall(function() W.DayTime:force(nil) end)
-- minigames da campanha 1
tentar("pescaria abrir", function() W.PescariaBene:abrir({}) end); quadros(60, "pescaria"); tecla("Space", " ", 3); quadros(30, "pescaria"); tecla("Escape", "Escape", 2)
tentar("concurso abrir", function() W.BaileConcurso:abrir({}) end); quadros(40, "concurso"); for _, k in ipairs({ "ArrowLeft", "ArrowDown", "ArrowUp", "ArrowRight" }) do tecla(k, k, 2) end; quadros(20, "concurso"); tecla("Escape", "Escape", 2)
tentar("rima abrir", function() W.BaileConcurso:abrir({ config = { titulo = "BATALHA DE RIMA", rival = "freddy", versos = { { "a", "b" }, { "c", "d" } } } }) end); quadros(40, "rima"); tecla("Escape", "Escape", 2)
local A = W.Activities
for _, kind in ipairs({ "quiz", "football", "dinner" }) do
  tentar("atividade " .. kind, function()
    local s = A:create(kind, {})
    for k = 1, 30 do A:update(s, 1 / 30); if k == 10 then A:submit(s, 0) end; if k == 20 then A:submit(s, 0) end end
    A:draw(ctx, s)
  end)
end
-- começa a campanha, abre o mapa e a campanha 2
local function clicar(sel) local el = N.document:querySelector(sel); if el then pcall(el.click, el); return true end end
clicar("#menuJogarBtn"); quadros(3, "menu"); _ = clicar("#startBtn") or clicar("#continueBtn"); quadros(3, "começar")
local G = W.Game
for _ = 1, 8 do pcall(G.skipCutscene, G); pcall(G.closeDialogue, G); quadros(2, "história") end
tentar("treino", function() end)
tentar("mapa abrir", function() W.MapasJogo:abrirCampanha1() end); quadros(20, "mapa"); tecla("ArrowRight", "ArrowRight", 3); quadros(10, "mapa andando"); tentar("mapa fechar", function() W.Mapa3D:fechar() end); quadros(3, "mapa fechado")
tentar("mapa 2 abrir", function() W.MapasJogo:abrirCampanha2(0, function() end, {}) end); quadros(20, "mapa 2"); tentar("mapa 2 fechar", function() W.Mapa3D:fechar() end); quadros(3, "mapa 2 fechado")
tentar("campanha 2 abrir", function() W.Campanha2:abrir() end); quadros(30, "campanha 2"); tecla("KeyD", "d", 10); tecla("Space", " ", 4)
local st = select(2, pcall(W.Campanha2.estado, W.Campanha2)); print("campanha 2: " .. (type(st) == "table" and ("cena " .. tostring(st.cena) .. " x=" .. tostring(st.x)) or tostring(st)))
tentar("campanha 2 fechar", function() W.Campanha2:fechar() end); quadros(3, "fim")
print(("erros diferentes: %d · %.0f s"):format(nErros, os.clock() - t0))
return "fim"
