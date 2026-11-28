--!nocheck
-- Diagnóstico rodado num servidor do Roblox (Open Cloud, Luau Execution) com o lugar do jogo:
-- carrega o jogo igual ao cliente, mede cada parte, desenha alguns quadros da tela inicial e conta os IDs de som.
-- Uso: python3 roblox/ferramentas/nuvem.py executar <universo> <lugar> roblox/teste/nuvem-diagnostico.lua [versão]
local RS = game:GetService("ReplicatedStorage")
local pasta = RS:FindFirstChild("DaRoca")
if not pasta then print("SEM a pasta ReplicatedStorage.DaRoca neste lugar"); return "sem jogo" end
local versao = pasta:FindFirstChild("Versao"); print("versão do jogo no lugar: " .. (versao and versao.Value or "?"))
local runtime, jogoPasta = pasta.runtime, pasta.jogo
local okS, sons = pcall(require, runtime:FindFirstChild("sons"))
if okS and type(sons) == "table" then local n = 0; for k, v in pairs(sons) do if type(v) == "string" and v:match("rbxassetid://%d+") then n = n + 1 end end; print("IDs de som preenchidos: " .. n) end
local inicio = os.clock()
local ultima = os.clock()
local function ceder() if os.clock() - ultima > .2 then task.wait(); ultima = os.clock() end end
local JS = require(runtime.js); local Canvas = require(runtime.canvas); local N = require(runtime.navegador)
local Carregar = require(runtime.carregar); local Desenhista = require(runtime.desenhista); local Audio = require(runtime.audio)
local LL = require(jogoPasta.lualib_bundle)
N.window.DAROCA_ROBLOX = true
N.som = { tocar = function() end, ajustar = function() end, parar = function() end, musica = function() end }
Canvas.ceder = ceder
local lentos = {}
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio, ceder = ceder,
    exigir = function(nome)
      task.wait(); ultima = os.clock()
      local m = jogoPasta:FindFirstChild(nome); if not m then error("módulo " .. nome .. " não encontrado") end
      local t = os.clock(); local r = require(m); local dt = os.clock() - t
      if dt > .05 then lentos[#lentos + 1] = ("%s %.2fs"):format(nome, dt) end
      return r
    end })
end)
print(("carregamento: %s em %.1f s"):format(ok and "ok" or ("ERRO " .. tostring(erro)), os.clock() - inicio))
print("módulos lentos: " .. table.concat(lentos, " | "))
for _, e in ipairs(N.erros or {}) do print("erro do jogo: " .. tostring(e):sub(1, 300)) end
local fx = jogoPasta:FindFirstChild("vendor__pixelfx")
if fx then task.wait(); local t = os.clock(); local okFx, eFx = pcall(require, fx); print(("efeitos: %s em %.2f s"):format(okFx and "ok" or tostring(eFx), os.clock() - t)) end
if not ok then return "erro no carregamento" end
-- quadros da tela inicial: o primeiro monta os fundos; os outros mostram o custo normal
local desenhista = Carregar.desenhista
for k = 1, 12 do
  ultima = os.clock()
  local t = os.clock()
  local okQ, eQ = pcall(function() N.passo(os.clock() * 1000) end)
  local tJogo = os.clock() - t
  local t2 = os.clock()
  local okD, eD = pcall(function() if desenhista then desenhista.desenhar() end end)
  print(("quadro %d: jogo %.3f s, página %.3f s%s%s"):format(k, tJogo, os.clock() - t2, okQ and "" or (" ERRO jogo: " .. tostring(eQ):sub(1, 200)), okD and "" or (" ERRO página: " .. tostring(eD):sub(1, 200))))
  task.wait()
end
local tela = N.document:getElementById("startScreen")
print("tela inicial aberta: " .. tostring(tela and not tela.hidden))
return "fim"
