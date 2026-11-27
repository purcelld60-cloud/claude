-- Teste fora do Roblox (Lua 5.3): carrega o código convertido do jogo e desenha numa imagem PPM.
-- Uso (na pasta roblox): lua5.3 teste/rodar.lua <saida.ppm> <personagem | número da cena>
package.path = "./src/runtime/?.lua;./teste/jogo/?.lua;" .. package.path
local JS = require("js")
local Canvas = require("canvas")
local N = require("navegador")
N.Canvas = Canvas
Canvas.novaLista = function(n) return JS.tipada("Uint8ClampedArray", n) end
local LL = require("lualib_bundle")
N.Promise = LL.__TS__Promise
local window = N.window

local saida, oque = arg[1] or "teste.ppm", arg[2] or "personagem"
local t0 = os.clock()
for _, m in ipairs({ "art", "campanha2__personagens" }) do local ok, e = pcall(require, m); if not ok then print("ERRO ao carregar " .. m .. ": " .. tostring(e)) end end
print(("carregou em %.2fs"):format(os.clock() - t0))
local cv = Canvas.novo(960, 540); local c = cv:getContext("2d")
c.fillStyle = "#9fbcc4"; c:fillRect(0, 0, 960, 540)
t0 = os.clock()
local Art = window.Art
if oque == "personagem" then
  local ids = { "daroca", "reeis", "c2_bia", "tia_ana", "dede", "nikolas", "freddy" }
  for i, id in ipairs(ids) do local ok, e = pcall(Art.drawCharacter, Art, c, id, 70 + (i - 1) * 135, 400, { scale = 2.2, frame = 1, facing = 1, grounded = true }); if not ok then print("ERRO " .. id .. ": " .. tostring(e)) end end
else
  local cena = tonumber(oque) or 0
  local ok, e = pcall(Art.drawScene, Art, c, cena, 300, 12.3); if not ok then print("ERRO drawScene: " .. tostring(e)) end
end
print(("desenhou em %.2fs"):format(os.clock() - t0))
for _, e in ipairs(N.erros) do print("erro:", e) end
Canvas.ppm(cv, saida)
