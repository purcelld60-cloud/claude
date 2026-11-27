-- Roda o jogo inteiro convertido (Lua 5.3, fora do Roblox) e grava a tela em PPM.
-- Uso (na pasta roblox): lua5.3 teste/jogo_completo.lua <saida.ppm> [quadros] [ações...]
package.path = "./src/runtime/?.lua;./teste/jogo/?.lua;" .. package.path
local JS = require("js")
local Canvas = require("canvas")
local N = require("navegador")
local LL = require("lualib_bundle")
local Carregar = require("carregar")
local saida, quadros = arg[1] or "jogo.ppm", tonumber(arg[2] or "60")
local tempos = {}
local t0 = os.clock()
Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, exigir = require,
  aoCarregar = function(m, dt, ok) tempos[#tempos + 1] = { m, dt } end })
print(("carregou em %.2fs"):format(os.clock() - t0))
table.sort(tempos, function(a, b) return a[2] > b[2] end)
for i = 1, 5 do if tempos[i] then print(("  %s %.2fs"):format(tempos[i][1], tempos[i][2])) end end
local ms = 0
local function rodar(n) for _ = 1, n do ms = ms + 1000 / 60; local q0 = os.clock(); N.passo(ms); tempos.ultimo = os.clock() - q0 end end
if INICIAR_PERFIL then INICIAR_PERFIL() end
t0 = os.clock()
rodar(quadros)
print(("%d quadros em %.2fs (último %.3fs)"):format(quadros, os.clock() - t0, tempos.ultimo or 0))
-- ações: "clique:#id", "tecla:KeyE", "quadros:N"
for i = 3, #arg do
  local tipo, v = arg[i]:match("^(%w+):(.*)$")
  if tipo == "clique" then local el = N.document:querySelector(v); if el then el:click() else print("não achei " .. v) end
  elseif tipo == "tecla" then N.tecla("keydown", v, v); rodar(3); N.tecla("keyup", v, v)
  elseif tipo == "quadros" then rodar(tonumber(v)) end
end
local vistos = {}
for _, e in ipairs(N.erros) do if not vistos[e] then vistos[e] = true; print("ERRO: " .. e:sub(1, 300)) end end
local cv = N.document:getElementById("gameCanvas")
local alvo = cv
for _, id in ipairs({ "titleCanvas" }) do local c = N.document:getElementById(id); local tela = N.document:getElementById("startScreen"); if c and tela and not tela.hidden and not tela.classList:contains("hidden") then alvo = c end end
print("canvas:", alvo and alvo.id, alvo and alvo.width, alvo and alvo.height)
if alvo then Canvas.ppm(alvo, saida) end
if PERFIL then PERFIL(25) end
