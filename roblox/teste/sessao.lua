-- Sessão de teste (Lua 5.3): liga o jogo, executa ações e grava telas.
-- Uso (na pasta roblox): lua5.3 teste/sessao.lua <pasta_saida> ação1 ação2 ...
--   quadros:N  clique:<seletor>  tecla:<code>  segurar:<code>:N  soltar:<code>  foto:<nome>  html:<seletor>  graficos:low|medium
package.path = "./src/runtime/?.lua;./teste/jogo/?.lua;" .. package.path
local JS = require("js")
local Canvas = require("canvas")
local N = require("navegador")
local LL = require("lualib_bundle")
local Carregar = require("carregar")
local Desenhista = require("desenhista")
local Audio = require("audio")
local sonsTocados = 0
N.som = { tocar = function() sonsTocados = sonsTocados + 1 end, ajustar = function() end, parar = function() end, musica = function() end }
local pasta = arg[1] or "."
for i = 2, #arg do local g = arg[i]:match("^graficos:(.*)$"); if g then N.window.localStorage:setItem("daroca-graphics-v1", g) end end
local t0 = os.clock()
Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, exigir = require, Desenhista = Desenhista, Audio = Audio })
print(("carregou em %.2fs"):format(os.clock() - t0))
local ms = 0
local function rodar(n) local t = os.clock(); for _ = 1, n do ms = ms + 1000 / 60; N.passo(ms) end; return (os.clock() - t) / n end
local function visivel(el) while el and el ~= N.document do if el.hidden or (el.style and el.style.display == "none") then return false end; el = el.parentNode end; return true end
for i = 2, #arg do
  local tipo, v = arg[i]:match("^(%w+):(.*)$")
  if tipo == "quadros" then local dt = rodar(tonumber(v)); print(("%s quadros: %.3fs por quadro"):format(v, dt))
  elseif tipo == "clique" then local el = N.document:querySelector(v); if el then el:click(); print("clicou " .. v) else print("não achei " .. v) end
  elseif tipo == "tecla" then N.tecla("keydown", v, v); rodar(4); N.tecla("keyup", v, v); print("tecla " .. v)
  elseif tipo == "segurar" then local code, n = v:match("^(.-):(%d+)$"); N.tecla("keydown", code, code); rodar(tonumber(n)); N.tecla("keyup", code, code); print("segurou " .. code)
  elseif tipo == "foto" then
    local cv = N.document:getElementById("gameCanvas")
    local tela = N.document:getElementById("startScreen")
    if tela and visivel(tela) then cv = N.document:getElementById("titleCanvas") end
    Canvas.ppm(cv, pasta .. "/" .. v .. ".ppm"); print("foto " .. v .. " (" .. cv.id .. ")")
  elseif tipo == "tela" then
    local t0 = os.clock(); local cv = Carregar.desenhista.desenhar(); print(("tela desenhada em %.3fs"):format(os.clock() - t0))
    Canvas.ppm(cv, pasta .. "/" .. v .. ".ppm"); print("tela " .. v)
  elseif tipo == "toque" then N.toque = (v == "sim")
  elseif tipo == "botao" then
    local achou
    N.percorrer(N.document.body, function(e) if not achou and e._tag == "button" and visivel(e) and N.textoDe(e):upper():find(v:upper(), 1, true) then achou = e; return true end end)
    if achou then achou:click(); print("botão " .. v) else print("sem botão " .. v) end
  elseif tipo == "cliquexy" then local x, y = v:match("^(%d+),(%d+)$"); N.ponteiro("pointerdown", tonumber(x), tonumber(y), 1, N.toque); rodar(2); N.ponteiro("pointerup", tonumber(x), tonumber(y), 1, N.toque); print("clicou em " .. v .. " (" .. tostring(N.elementoEm(tonumber(x), tonumber(y)).id) .. ")")
  elseif tipo == "html" then local el = N.document:querySelector(v); print(el and (el.outerHTML:sub(1, 600)) or ("sem " .. v))
  elseif tipo == "visiveis" then
    N.percorrer(N.document.body, function(e) if e._tag == "button" and visivel(e) then print("  botão visível:", e.id, e.className, (N.textoDe(e):gsub("%s+", " ")):sub(1, 40)) end end)
  end
end
local vistos = {}
print("sons tocados: " .. sonsTocados)
for _, e in ipairs(N.erros) do if not vistos[e] then vistos[e] = true; print("ERRO: " .. e:sub(1, 400)) end end
