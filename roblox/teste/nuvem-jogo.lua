--!nocheck
-- Teste do jogo de verdade num servidor do Roblox (Open Cloud, Luau Execution): carrega igual ao cliente,
-- mede a tela inicial, aperta JOGAR, pula a história, joga um pouco, abre uma luta e mostra os erros do jogo.
-- Uso: python3 roblox/ferramentas/nuvem.py executar <universo> <lugar> roblox/teste/nuvem-jogo.lua [versão]
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
local qual = ...
local t0 = os.clock()
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio, ceder = ceder,
    exigir = function(nome) task.wait(); ultima = os.clock(); return require(jogoPasta[nome]) end })
end)
print(("carregou: %s em %.1f s"):format(ok and "ok" or tostring(erro), os.clock() - t0))
pcall(require, jogoPasta:FindFirstChild("vendor__pixelfx"))
local vistos, nErros = {}, 0
local function erros(etapa)
  for _, e in ipairs(N.erros or {}) do local k = tostring(e):sub(1, 260); if not vistos[k] then vistos[k] = true; nErros = nErros + 1; print(("ERRO [%s]: %s"):format(etapa, k)) end end
end
erros("carregamento")
local desenhista = Carregar.desenhista
local ms = 0
local function quadros(n, etapa, medir)
  local tj, tp, maxj = 0, 0, 0
  for _ = 1, n do
    ultima = os.clock(); ms = ms + 1000 / 30
    local a = os.clock(); pcall(N.passo, ms); local dj = os.clock() - a
    task.wait(); ultima = os.clock()
    local b = os.clock(); pcall(function() if desenhista then desenhista.desenhar() end end); local dp = os.clock() - b
    tj, tp, maxj = tj + dj, tp + dp, math.max(maxj, dj)
    task.wait()
  end
  if medir then print(("%s: jogo %.3f s/quadro (pior %.2f), página %.3f s/quadro"):format(etapa, tj / n, maxj, tp / n)) end
  erros(etapa)
end
local function clicar(sel) local el = N.document:querySelector(sel); if el then pcall(el.click, el); return true end; return false end
local function botao(texto) local achou; N.percorrer(N.document.body, function(e) if not achou and e._tag == "button" and N.textoDe(e):upper():find(texto:upper(), 1, true) then achou = e; return true end end); if achou then pcall(achou.click, achou) end; return achou ~= nil end
quadros(3, "tela inicial")
clicar("#menuJogarBtn"); quadros(3, "menu"); _ = clicar("#startBtn") or clicar("#continueBtn"); quadros(3, "começar")
botao("BORA CONTINUAR"); botao("SIM")
local G = N.window.Game
for _ = 1, 8 do if G then pcall(G.skipCutscene, G); pcall(G.closeDialogue, G) end; botao("Pular"); botao("BORA CONTINUAR"); quadros(2, "pulando história") end
-- mede quanto do quadro é desenho no canvas do jogo (por método) e quanto é o resto
local cv = N.document:getElementById("gameCanvas"); local api = cv:getContext("2d")
local soma, cont = {}, {}
for _, nome in ipairs({ "fillRect", "fill", "stroke", "drawImage", "fillText", "clearRect", "getImageData", "putImageData", "strokeRect" }) do
  local orig = api[nome]
  if type(orig) == "function" then api[nome] = function(...) local t = os.clock(); local a, b = orig(...); soma[nome] = (soma[nome] or 0) + os.clock() - t; cont[nome] = (cont[nome] or 0) + 1; return a, b end end
end
for _, q in ipairs({ "low", "medium" }) do
  pcall(function() N.window.Graphics:set(q) end); quadros(3, "aquece")
  soma, cont = {}, {}
  local t = os.clock(); quadros(10, "jogando (" .. q .. ")", true); local total = os.clock() - t
  local partes = {}; local tot = 0
  for k, v in pairs(soma) do tot = tot + v; partes[#partes + 1] = ("%s %.0f ms (%d)"):format(k, v * 100, cont[k] / 10) end
  print(("  canvas do jogo: %.0f ms por quadro → %s"):format(tot * 100, table.concat(partes, " | ")))
end
-- anda um pouco para a direita e pula
N.tecla("keydown", "KeyD", "d"); quadros(8, "andando"); N.tecla("keyup", "KeyD", "d")
N.tecla("keydown", "Space", " "); quadros(4, "pulo"); N.tecla("keyup", "Space", " ")
-- uma luta (revanche do Terreiro dos Chefes)
N.window.localStorage:setItem("daroca-sandbox-v1", "1")
for _, chefe in ipairs({ "freddy", "igor" }) do
  local okB, r = pcall(G.startSandboxBoss, G, chefe); print("luta " .. chefe .. ": " .. tostring(okB and r or r))
  for _ = 1, 3 do pcall(G.skipCutscene, G); pcall(G.closeDialogue, G); quadros(2, "abrindo luta") end
  quadros(10, "luta " .. chefe, true)
  N.tecla("keydown", "KeyJ", "j"); quadros(4, "golpe"); N.tecla("keyup", "KeyJ", "j")
end
print(("erros diferentes: %d · tempo total %.0f s"):format(nErros, os.clock() - t0))
return "fim"
