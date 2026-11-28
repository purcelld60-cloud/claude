--!nocheck
-- Teste do cenário em camadas num servidor do Roblox (Open Cloud): roda o jogo igual ao cliente (rotina do cenário
-- em fatias, interface só quando muda), mede o tempo por quadro e manda uma miniatura da tela montada.
local RS = game:GetService("ReplicatedStorage")
local pasta = RS:FindFirstChild("DaRoca")
local versao = pasta:FindFirstChild("Versao"); print("versão: " .. (versao and versao.Value or "?"))
local runtime, jogoPasta = pasta.runtime, pasta.jogo
local JS = require(runtime.js); local Canvas = require(runtime.canvas); local N = require(runtime.navegador)
local Carregar = require(runtime.carregar); local Desenhista = require(runtime.desenhista); local Audio = require(runtime.audio)
local Camadas = require(runtime.camadas)
local LL = require(jogoPasta.lualib_bundle)
local W = N.window
W.DAROCA_ROBLOX = true; W.DAROCA_CAMADAS = true
N.som = { tocar = function() end, ajustar = function() end, parar = function() end, musica = function() end }
local ultima = os.clock()
local fundoCo, fatiaAte = nil, 0
Canvas.ceder = function()
  if fundoCo and coroutine.running() == fundoCo then if os.clock() > fatiaAte and coroutine.isyieldable() then coroutine.yield() end; return end
  if os.clock() - ultima > .2 and coroutine.isyieldable() then task.wait(); ultima = os.clock() end
end
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio, ceder = Canvas.ceder,
    exigir = function(nome) task.wait(); ultima = os.clock(); return require(jogoPasta[nome]) end })
end)
print("carregou: " .. tostring(ok and "ok" or erro))
pcall(require, jogoPasta:FindFirstChild("vendor__pixelfx"))
local D = Carregar.desenhista
local HdCam = W.HdMaps.camadas
local vistos, nErros = {}, 0
local function erros(etapa) for _, e in ipairs(N.erros or {}) do local k = tostring(e):sub(1, 240); if not vistos[k] then vistos[k] = true; nErros = nErros + 1; print(("ERRO [%s]: %s"):format(etapa, k)) end end end
local pronto, frente, desenhando, renders = nil, nil, false, 0
local copias = {}
local function guardar(cv) local c = copias[cv]; if not c or c.width ~= cv.width or c.height ~= cv.height then c = Canvas.novo(cv.width, cv.height); copias[cv] = c end; Canvas.copiar(c, cv); return c end
fundoCo = coroutine.create(function()
  while true do
    local cena = W.DAROCA_QUADRO_CAMADAS
    if cena and cena >= 0 and not pronto then
      desenhando = true
      local okD, info = pcall(function() return HdCam:desenhar(cena, W.DAROCA_QUADRO_CAMERA or 0, W.DAROCA_QUADRO_TEMPO or 0) end)
      desenhando = false
      if okD then pronto = info; renders = renders + 1 else nErros = nErros + 1; print("ERRO fundo: " .. tostring(info)) end
    end
    coroutine.yield()
  end
end)
local ms = 0
local med = { jogo = 0, pagina = 0, fundo = 0, n = 0, pior = 0 }
local function quadros(n, etapa)
  for _ = 1, n do
    ultima = os.clock(); ms = ms + 1000 / 60
    local a = os.clock(); pcall(N.passo, ms); local tj = os.clock() - a
    local b = os.clock(); pcall(D.desenhar, { camadas = true }); local tp = os.clock() - b
    local cena = W.DAROCA_QUADRO_CAMADAS
    local tf = 0
    if (cena and cena >= 0) or desenhando then
      local urg = (desenhando and not (cena and cena >= 0)) or (cena and cena >= 0 and (not frente or frente.cena ~= cena or not Camadas.cabe(frente, W.DAROCA_QUADRO_CAMERA)))
      fatiaAte = os.clock() + (urg and 1.5 or .005)
      local c = os.clock(); local okR, e = coroutine.resume(fundoCo); tf = os.clock() - c
      if not okR then nErros = nErros + 1; print("ERRO rotina: " .. tostring(e)) end
    end
    if pronto then
      local info = pronto; pronto = nil
      local snap = { meio = guardar(info.meio), ceu = guardar(info.ceu) }
      for _, f in ipairs(info.fundo) do if f.tipo == "nevoa" then snap[f.cv] = guardar(f.cv) end end
      frente = info; frente.snap = snap
    end
    med.jogo = med.jogo + tj; med.pagina = med.pagina + tp; med.fundo = med.fundo + tf; med.n = med.n + 1
    local tot = tj + tp + tf; if tot > med.pior then med.pior = tot end
    task.wait()
  end
  erros(etapa)
end
local function medir(nome)
  print(("%s: jogo %.1f ms + interface %.1f ms + cenário %.1f ms = %.1f ms por quadro (pior %.0f ms), %d desenhos do cenário em %d quadros"):format(
    nome, med.jogo / med.n * 1000, med.pagina / med.n * 1000, med.fundo / med.n * 1000, (med.jogo + med.pagina + med.fundo) / med.n * 1000, med.pior * 1000, renders, med.n))
  med = { jogo = 0, pagina = 0, fundo = 0, n = 0, pior = 0 }; renders = 0
end
local function clicar(sel) local el = N.document:querySelector(sel); if el then pcall(el.click, el) end end
local function botao(texto) local achou; N.percorrer(N.document.body, function(e) if not achou and e._tag == "button" and N.textoDe(e):upper():find(texto:upper(), 1, true) then achou = e; return true end end); if achou then pcall(achou.click, achou) end end
quadros(3, "título"); clicar("#menuJogarBtn"); quadros(3, "menu"); clicar("#startBtn"); quadros(3, "começar")
local G = W.Game
for _ = 1, 8 do pcall(G.skipCutscene, G); pcall(G.closeDialogue, G); botao("BORA CONTINUAR"); quadros(2, "história") end
for _, q in ipairs({ "auto-low", "medium" }) do
  pcall(function() W.Graphics:set(q) end); quadros(20, "aquece " .. q); medir("parado (" .. q .. ")")
  N.tecla("keydown", "KeyD", "d"); quadros(60, "andando " .. q); N.tecla("keyup", "KeyD", "d"); medir("andando (" .. q .. ")")
end
-- miniatura da tela montada (64x36), como a placa de vídeo faria
local tela = Canvas.novo(960, 540); local tc = tela:getContext("2d")
local tint = {}
local function tingido(cv, t) if not t then return cv end; local c = tint[cv]; if not c or c.width ~= cv.width then c = Canvas.novo(cv.width, cv.height); tint[cv] = c end; Canvas.copiar(c, cv); c:getContext("2d"):multiplicarCor(t[1], t[2], t[3]); return c end
tc.fillStyle = "#000000"; tc:fillRect(0, 0, 960, 540)
if frente then
  for _, it in ipairs(Camadas.montar(frente, W.DAROCA_QUADRO_CAMERA, 0, 0)) do
    local fonte = (it.fonte == frente.meio and frente.snap.meio) or (it.fonte == frente.ceu and frente.snap.ceu) or frente.snap[it.fonte] or it.fonte
    tc.globalAlpha = it.alfa; tc:drawImage(tingido(fonte, it.tinta), it.x, it.y, it.w, it.h); tc.globalAlpha = 1
  end
end
if D.camadaJogo then tc:drawImage(D.camadaJogo, 0, 0) end
tc:drawImage(D.tela, 0, 0)
local linhas = {}
for yy = 0, 35 do local t = {}; for xx = 0, 63 do local v = buffer.readu32(tela._.px, ((yy * 15 + 7) * 960 + (xx * 15 + 7)) * 4); t[#t + 1] = ("%02x%02x%02x"):format(v % 256, v // 256 % 256, v // 65536 % 256) end; linhas[#linhas + 1] = table.concat(t) end
print("MINI camadas " .. table.concat(linhas, "|"))
print(("erros diferentes: %d"):format(nErros))
return "fim"
