--!nocheck
--[[ Da Roça Adventure no Roblox — script do jogador (StarterPlayerScripts).
  Roda o jogo original (convertido de JavaScript para Luau pela pasta roblox/ferramentas) e mostra a tela
  numa imagem 2D (EditableImage) do tamanho do jogo, 960 x 540, ampliada sem filtro para manter o pixel.
  - PC: teclado e mouse com as mesmas teclas do jogo;
  - celular: toque nos mesmos botões do jogo (o jogo desenha os botões de toque dele);
  - Xbox e PlayStation: controle mapeado para as teclas do jogo (página "Como jogar" explica cada botão);
  - a qualidade gráfica do Roblox (Configurações > Qualidade gráfica) escolhe a qualidade do jogo:
    1 a 7 = BAIXA, 8 a 10 = MÉDIA, Automático = AUTOMÁTICA do jogo começando na BAIXA;
  - os cenários HD da campanha 1 ficam em camadas na placa de vídeo (céu, fundos, meio), deslizando a cada quadro;
    F2 liga e desliga isso para comparar;
  - o save (localStorage do jogo) fica no DataStore do jogador (script do servidor). ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local AssetService = game:GetService("AssetService")
local StarterGui = game:GetService("StarterGui")
local RS = game:GetService("ReplicatedStorage")
local jogador = Players.LocalPlayer

-- tela cheia, sem o mundo 3D e sem os controles padrão do Roblox
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
GuiService.AutoSelectGuiEnabled = false
-- sem o direcional e o pulo padrão do Roblox no celular (o jogo tem os próprios controles de toque)
pcall(function() GuiService.TouchControlsEnabled = false end)
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CFrame.new(0, 10000, 0)

local gui = Instance.new("ScreenGui")
gui.Name = "DaRoca"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = jogador:WaitForChild("PlayerGui")
local fundo = Instance.new("Frame"); fundo.Size = UDim2.fromScale(1, 1); fundo.BackgroundColor3 = Color3.new(0, 0, 0); fundo.BorderSizePixel = 0; fundo.Parent = gui
-- palco 16:9 com as camadas: cenário (imagens próprias, embaixo), canvas do jogo e a interface por cima
local palco = Instance.new("Frame")
palco.AnchorPoint = Vector2.new(.5, .5); palco.Position = UDim2.fromScale(.5, .5); palco.Size = UDim2.fromScale(1, 1)
palco.BackgroundTransparency = 1; palco.ClipsDescendants = true; palco.Parent = fundo
local proporcao = Instance.new("UIAspectRatioConstraint"); proporcao.AspectRatio = 16 / 9; proporcao.Parent = palco
local imagem = Instance.new("ImageLabel")
imagem.Size = UDim2.fromScale(1, 1); imagem.ZIndex = 50
imagem.BackgroundTransparency = 1; imagem.ResampleMode = Enum.ResamplerMode.Pixelated; imagem.Parent = palco

local PIXEL = Font.new("rbxasset://fonts/families/PressStart2P.json")
local aviso = Instance.new("TextLabel")
aviso.Size = UDim2.fromScale(1, 1); aviso.BackgroundTransparency = 1; aviso.TextColor3 = Color3.fromRGB(255, 233, 168); aviso.FontFace = PIXEL; aviso.TextSize = 18
aviso.Text = "CARREGANDO DA ROÇA ADVENTURE..."; aviso.Parent = fundo
aviso.TextWrapped = true

-- ===== imagem da tela (EditableImage): criada antes de carregar o jogo =====
-- Se o Roblox não deixar criar (opção "Allow Mesh / Image APIs" desligada, lugar não publicado, conta sem verificação
-- ou memória de imagem cheia), o script parava aqui calado e a tela de carregamento ficava congelada. Agora explica.
local W, H = 960, 540
local ei, erroImagem
do
  local okE, r = pcall(function() return AssetService:CreateEditableImage({ Size = Vector2.new(W, H) }) end)
  if okE and r then
    local okC, eC = pcall(function() imagem.ImageContent = Content.fromObject(r) end)
    if okC then ei = r else erroImagem = eC end
  else erroImagem = okE and "o Roblox devolveu nil (memória de imagem cheia)" or r end
end
-- camada da interface (página) por cima da imagem do jogo: só é enviada de novo quando muda
local imagemPagina, eiPagina
if ei then
  local okP, rP = pcall(function() return AssetService:CreateEditableImage({ Size = Vector2.new(W, H) }) end)
  if okP and rP then
    imagemPagina = Instance.new("ImageLabel")
    imagemPagina.Size = UDim2.fromScale(1, 1); imagemPagina.BackgroundTransparency = 1; imagemPagina.ResampleMode = Enum.ResamplerMode.Pixelated; imagemPagina.ZIndex = 100
    local okC = pcall(function() imagemPagina.ImageContent = Content.fromObject(rP) end)
    if okC then eiPagina = rP; imagemPagina.Parent = palco else imagemPagina:Destroy(); imagemPagina = nil end
  end
end
-- interface "de baixo" (embaixo do logo e dos canvas pequenos), criada quando precisar
local imagemBaixo, eiBaixo
local function novaImagemCv(w, h)
  local ok, r = pcall(function() return AssetService:CreateEditableImage({ Size = Vector2.new(w, h) }) end)
  if ok then return r end
  return nil
end
imagem.Visible = true
if not ei then
  aviso.TextSize = 14
  aviso.Text = "O ROBLOX NÃO DEIXOU DESENHAR A TELA DO JOGO.\n\n"
    .. "No Studio: aba Home > Game Settings > Security > ligue \"Allow Mesh / Image APIs\" e clique em Save.\n"
    .. "Se o botão estiver cinza, publique antes (File > Publish to Roblox) e volte lá.\n\n"
    .. "A conta dona do jogo precisa ter 13 anos ou mais e a verificação de idade/ID feita.\n\n"
    .. "Detalhe: " .. tostring(erroImagem)
  warn("[Da Roça] EditableImage: " .. tostring(erroImagem))
  return
end
print("[Da Roça] imagem da tela criada")

-- ===== save: o localStorage do jogo vai para o DataStore pelo servidor =====
local remoto = RS:WaitForChild("DaRocaSave", 30)
local salvosIniciais = {}
if remoto then local ok, dados = pcall(function() return remoto:InvokeServer("carregar") end); if ok and type(dados) == "table" then salvosIniciais = dados end end

-- ===== carrega o jogo =====
local pasta = RS:WaitForChild("DaRoca")
local runtime, jogoPasta = pasta:WaitForChild("runtime"), pasta:WaitForChild("jogo")
local JS = require(runtime.js)
local Canvas = require(runtime.canvas)
local N = require(runtime.navegador)
local Carregar = require(runtime.carregar)
local Desenhista = require(runtime.desenhista)
local Audio = require(runtime.audio)
local LL = require(jogoPasta.lualib_bundle)
local window = N.window
window.DAROCA_ROBLOX = true
window.DAROCA_CAMADAS = eiPagina ~= nil -- cenário HD em camadas na placa de vídeo (precisa das imagens extras)
N.toque = UIS.TouchEnabled and not UIS.KeyboardEnabled
window.navigator.maxTouchPoints = N.toque and 5 or 0
window.localStorage._carregar(salvosIniciais)

-- qualidade do Roblox → qualidade do jogo (antes de carregar, para o jogo já nascer na certa)
local configuracoes = UserSettings():GetService("UserGameSettings")
local function nivelDoRoblox()
  local q = configuracoes.SavedQualityLevel
  -- Automático começa na BAIXA (o jogo desenha tudo no processador); o automático do jogo continua valendo dali
  if q == Enum.SavedQualitySetting.Automatic then return "auto-low" end
  -- com o cenário em camadas a BAIXA já mostra o cenário completo; a MÉDIA acrescenta o acabamento dos personagens,
  -- que ainda pesa no processador (fica para as qualidades 8 a 10)
  local n = tonumber(tostring(q):match("(%d+)$")) or 5
  if n <= 7 then return "low" end
  return "medium"
end
window.localStorage:setItem("daroca-graphics-v1", nivelDoRoblox())

-- ===== som: WebAudio imitado (runtime/audio.lua) tocado com Sounds em laço =====
local SoundService = game:GetService("SoundService")
local okS, IDS = pcall(require, runtime:FindFirstChild("sons"))
if not okS or type(IDS) ~= "table" then IDS = {} end
local VOLUME = tonumber(IDS.volume) or 3
local tocando, livres = {}, {}
local function pegarSom(tipo)
  local lista = livres[tipo]; if lista and #lista > 0 then return table.remove(lista) end
  local id = IDS[tipo]; if not id or id == "" then return nil end
  local snd = Instance.new("Sound"); snd.SoundId = id; snd.Looped = true; snd.Parent = SoundService
  return snd
end
N.som = {
  tocar = function(id, tipo, taxa, vol, duracao)
    local snd = pegarSom(tipo) or pegarSom("sine"); if not snd then return end
    snd.PlaybackSpeed = math.clamp(taxa, .02, 20); snd.Volume = math.clamp(vol * VOLUME, 0, 4)
    snd.TimePosition = 0; snd:Play(); tocando[id] = { snd, tipo }
    -- sons curtos (bipes) param sozinhos na hora certa, mesmo se o jogo estiver lento
    if duracao then task.delay(duracao, function() local t = tocando[id]; if t and t[1] == snd then N.som.parar(id) end end) end
  end,
  ajustar = function(id, taxa, vol) local t = tocando[id]; if t then t[1].PlaybackSpeed = math.clamp(taxa, .02, 20); t[1].Volume = math.clamp(vol * VOLUME, 0, 4) end end,
  parar = function(id) local t = tocando[id]; if t then t[1]:Stop(); livres[t[2]] = livres[t[2]] or {}; table.insert(livres[t[2]], t[1]); tocando[id] = nil end end,
  musica = (function()
    local atual
    return function(el, tocar)
      local src = tostring(el._attr and el._attr.src or ""):gsub("[?#].*$", ""):gsub("^.*musicas/", ""):gsub("^.*music/", "")
      local id = IDS.musicas and IDS.musicas[src]
      if not tocar then if atual and atual.el == el then atual.snd:Stop() end; return end
      if not id then return end
      if not atual then atual = { snd = Instance.new("Sound") }; atual.snd.Parent = SoundService end
      atual.el = el; atual.snd.SoundId = id; atual.snd.Looped = el.loop == true; atual.snd.Volume = math.clamp((tonumber(el.volume) or 1) * 1.5, 0, 3); atual.snd:Play()
    end
  end)(),
}

-- ===== campo de texto no celular: abre o teclado do Roblox =====
local caixaTexto = Instance.new("TextBox")
caixaTexto.Size = UDim2.new(.6, 0, 0, 44); caixaTexto.AnchorPoint = Vector2.new(.5, 0); caixaTexto.Position = UDim2.new(.5, 0, 0, 20)
caixaTexto.BackgroundColor3 = Color3.fromRGB(242, 230, 200); caixaTexto.TextColor3 = Color3.fromRGB(40, 24, 12); caixaTexto.Font = Enum.Font.GothamBold; caixaTexto.TextSize = 20
caixaTexto.Visible = false; caixaTexto.ZIndex = 20; caixaTexto.ClearTextOnFocus = false; caixaTexto.Parent = gui
local campoAtual
N.aoFocarCampo = function(el)
  if not N.toque then return end
  campoAtual = el; caixaTexto.Text = tostring(el.value or ""); caixaTexto.PlaceholderText = tostring(el._attr.placeholder or ""); caixaTexto.Visible = true; caixaTexto:CaptureFocus()
end
caixaTexto.FocusLost:Connect(function() if campoAtual then N.digitar(campoAtual, caixaTexto.Text); campoAtual = nil end; caixaTexto.Visible = false end)

local carregados = 0
local totalModulos = #jogoPasta:GetChildren()
local versaoValor = pasta:FindFirstChild("Versao")
local VERSAO = versaoValor and versaoValor.Value or "local"
print("[Da Roça] versão " .. VERSAO)
-- pausa um quadro quando já faz um tempo sem pausar: o Roblox derruba scripts que ficam ~10 s sem pausar
local ultimaPausa = os.clock()
-- o cenário em camadas é desenhado numa rotina à parte, em fatias curtas a cada quadro (fundoCo/fatiaAte, mais abaixo)
local fundoCo, fatiaAte = nil, 0
local function ceder()
  if fundoCo and coroutine.running() == fundoCo then
    if os.clock() > fatiaAte and coroutine.isyieldable() then coroutine.yield() end
    return
  end
  if os.clock() - ultimaPausa > .25 and coroutine.isyieldable() then task.wait(); ultimaPausa = os.clock() end
end
Canvas.ceder = ceder
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio, ceder = ceder,
    exigir = function(nome)
      local m = jogoPasta:FindFirstChild(nome); if not m then error("módulo " .. nome .. " não encontrado") end
      -- mostra qual parte está carregando (se travar, a foto da tela diz onde) e começa cada parte com o tempo zerado
      aviso.Text = ("CARREGANDO... %d%%\n\n%s\n%s"):format(math.min(99, math.floor(carregados / math.max(1, totalModulos) * 100)), nome, VERSAO)
      if coroutine.isyieldable() then task.wait(); ultimaPausa = os.clock() end
      local t0 = os.clock()
      local r = require(m)
      local dt = os.clock() - t0
      if dt > .5 then warn(("[Da Roça] %s levou %.1f s para carregar"):format(nome, dt)) end
      carregados = carregados + 1
      ceder()
      return r
    end,
    aoCarregar = function() end })
  -- a biblioteca de efeitos (4 MB) carrega aqui, na tela de carregamento, e não no meio do jogo
  local fx = jogoPasta:FindFirstChild("vendor__pixelfx")
  if fx then
    aviso.Text = ("CARREGANDO... 99%%\n\nefeitos especiais\n%s"):format(VERSAO)
    if coroutine.isyieldable() then task.wait(); ultimaPausa = os.clock() end
    local t0 = os.clock(); local okFx, eFx = pcall(require, fx)
    print(("[Da Roça] efeitos: %s em %.1f s"):format(okFx and "ok" or tostring(eFx), os.clock() - t0)); ceder()
  end
end)
-- Canvas.ceder continua ligado: um quadro pesado (ex.: o primeiro da tela inicial, que monta os fundos) pausa no meio
-- em vez de passar de 10 s; o laço de quadros abaixo roda um quadro de cada vez, então nada se mistura.
if not ok then aviso.Text = "ERRO AO CARREGAR (" .. VERSAO .. "): " .. tostring(erro); warn(erro); return end
print("[Da Roça] carregou")
local desenhista = Carregar.desenhista
N.aoErro = function(msg) warn("[Da Roça] " .. msg) end

local function aplicarQualidade()
  local G = window.Graphics
  if G and G.set then pcall(G.set, G, nivelDoRoblox()) end
end
configuracoes:GetPropertyChangedSignal("SavedQualityLevel"):Connect(aplicarQualidade)
aplicarQualidade()

-- salva de tempos em tempos quando o jogo mudar o localStorage
local mudou = false
window.localStorage._aoMudar = function() mudou = true end
task.spawn(function()
  while true do
    task.wait(12)
    if mudou and remoto then mudou = false; pcall(function() remoto:InvokeServer("salvar", window.localStorage._dados()) end) end
  end
end)

-- ===== imagem da tela =====
local quadro = buffer.create(W * H * 4)
local tamanho = Vector2.new(W, H)
aviso.Text = "ABRINDO A TELA INICIAL...\n\n" .. VERSAO

-- ===== entradas chegam enquanto um quadro pesado está pausado: guarda e entrega depois do quadro =====
local emQuadro, filaEntradas = false, {}
for _, nome in ipairs({ "tecla", "ponteiro", "digitar" }) do
  local original = N[nome]
  N[nome] = function(...)
    if emQuadro then local a = table.pack(...); filaEntradas[#filaEntradas + 1] = function() original(table.unpack(a, 1, a.n)) end
    else return original(...) end
  end
end

-- ===== entrada: teclado =====
local TECLAS = { Left = "ArrowLeft", Right = "ArrowRight", Up = "ArrowUp", Down = "ArrowDown", Space = "Space", Return = "Enter", KeypadEnter = "Enter", Escape = "Escape",
  LeftShift = "ShiftLeft", RightShift = "ShiftRight", Backspace = "Backspace", Tab = "Tab", LeftControl = "ControlLeft", Delete = "Delete", Minus = "Minus", Equals = "Equal",
  One = "Digit1", Two = "Digit2", Three = "Digit3", Four = "Digit4", Five = "Digit5", Six = "Digit6", Seven = "Digit7", Eight = "Digit8", Nine = "Digit9", Zero = "Digit0" }
local NOMES = { ArrowLeft = "ArrowLeft", ArrowRight = "ArrowRight", ArrowUp = "ArrowUp", ArrowDown = "ArrowDown", Space = " ", Enter = "Enter", Escape = "Escape", ShiftLeft = "Shift", ShiftRight = "Shift", Backspace = "Backspace", Tab = "Tab" }
local function codigoDe(kc)
  local nome = kc.Name
  if #nome == 1 and nome:match("%a") then return "Key" .. nome, nome:lower() end
  local c = TECLAS[nome]; if c then return c, NOMES[c] or (c:match("^Digit(%d)$")) or c end
  return nil
end

-- ===== entrada: controle (Xbox e PlayStation usam os mesmos KeyCodes no Roblox) =====
local CONTROLE = {
  ButtonA = { "Space", " " },        -- A / ✕: pular
  ButtonX = { "KeyJ", "j" },         -- X / □: papel
  ButtonB = { "KeyK", "k" },         -- B / ○: peidão
  ButtonY = { "KeyE", "e" },         -- Y / △: falar, entrar, interagir
  ButtonR1 = { "KeyL", "l" },        -- RB / R1: dash
  ButtonL1 = { "KeyR", "r" },        -- LB / L1: chamar o Reeis
  ButtonR2 = { "KeyB", "b" },        -- RT / R2: bivolt
  ButtonL2 = { "KeyT", "t" },        -- LT / L2: provocar
  ButtonL3 = { "KeyV", "v" },        -- L3: carro a gás
  ButtonStart = { "Escape", "Escape" }, -- Menu / Options: pausa
  DPadLeft = { "ArrowLeft", "ArrowLeft" }, DPadRight = { "ArrowRight", "ArrowRight" }, DPadUp = { "ArrowUp", "ArrowUp" }, DPadDown = { "ArrowDown", "ArrowDown" },
}
local presas = {}
local function apertar(code, key) if not presas[code] then presas[code] = true; N.tecla("keydown", code, key, false) end end
local function soltar(code, key) if presas[code] then presas[code] = nil; N.tecla("keyup", code, key, false) end end

-- ===== entrada: mouse e toque (coordenadas da tela do jogo, 960 x 540) =====
local function posicaoNoJogo(p)
  local inset = GuiService:GetGuiInset()
  local x = (p.X + inset.X - palco.AbsolutePosition.X) / palco.AbsoluteSize.X * W
  local y = (p.Y + inset.Y - palco.AbsolutePosition.Y) / palco.AbsoluteSize.Y * H
  return x, y
end
local toques, proxToque, ignorados = {}, 1, {}
local tocouControle, ultimoToque, botaoInfo -- definidos com os controles de toque e o painel
local function idDoToque(input) local id = toques[input]; if not id then id = proxToque; proxToque = proxToque + 1; toques[input] = id end; return id end

local paginaControles -- criada mais abaixo
UIS.InputBegan:Connect(function(input, processado)
  if paginaControles and paginaControles.Visible then
    if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType.Name:match("^Gamepad") or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then paginaControles.Visible = false; return end
  end
  if input.UserInputType == Enum.UserInputType.Keyboard then
    if input.KeyCode == Enum.KeyCode.F1 then paginaControles.Visible = true; return end
    if input.KeyCode == Enum.KeyCode.F2 and eiPagina then -- liga/desliga o cenário em camadas (para comparar)
      window.DAROCA_CAMADAS = not window.DAROCA_CAMADAS
      print("[Da Roça] cenário em camadas: " .. (window.DAROCA_CAMADAS and "ligado" or "desligado")); return
    end
    local code, key = codigoDe(input.KeyCode); if code then apertar(code, key) end
  elseif input.UserInputType.Name:match("^Gamepad") then
    if input.KeyCode == Enum.KeyCode.ButtonSelect then if paginaControles then paginaControles.Visible = true end; return end
    local m = CONTROLE[input.KeyCode.Name]; if m then apertar(m[1], m[2]) end
  elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerdown", x, y, 1, false)
  elseif input.UserInputType == Enum.UserInputType.Touch then
    -- toque que começou num controle de toque do Roblox (direcional, botões) não vai para a página do jogo
    -- (o "processado" do Roblox no celular não é confiável: depende de Active e muda entre PC e celular)
    if tocouControle and tocouControle(input.Position) then ignorados[input] = true; return end
    local x, y = posicaoNoJogo(input.Position)
    ultimoToque = { x = x, y = y, alvo = (N.elementoEm and desenhista and desenhista.chave) and desenhista.chave(N.elementoEm(x, y)) or "?" }
    N.ponteiro("pointerdown", x, y, idDoToque(input), true)
  end
end)
UIS.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.Keyboard then
    local code, key = codigoDe(input.KeyCode); if code then soltar(code, key) end
  elseif input.UserInputType.Name:match("^Gamepad") then
    local m = CONTROLE[input.KeyCode.Name]; if m then soltar(m[1], m[2]) end
  elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerup", x, y, 1, false)
  elseif input.UserInputType == Enum.UserInputType.Touch then
    if ignorados[input] then ignorados[input] = nil; return end
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerup", x, y, idDoToque(input), true); toques[input] = nil
  end
end)
UIS.InputChanged:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseMovement then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointermove", x, y, 1, false)
  elseif input.UserInputType == Enum.UserInputType.Touch then
    if ignorados[input] then return end
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointermove", x, y, idDoToque(input), true)
  elseif input.KeyCode == Enum.KeyCode.Thumbstick1 then
    -- alavanca esquerda: anda (A/D) e olha para cima/baixo (W/S)
    local p = input.Position
    if p.X < -.45 then apertar("KeyA", "a") else soltar("KeyA", "a") end
    if p.X > .45 then apertar("KeyD", "d") else soltar("KeyD", "d") end
    if p.Y > .55 then apertar("KeyW", "w") else soltar("KeyW", "w") end
    if p.Y < -.55 then apertar("KeyS", "s") else soltar("KeyS", "s") end
  end
end)
UIS.LastInputTypeChanged:Connect(function(tipo)
  local toque = tipo == Enum.UserInputType.Touch
  if toque ~= N.toque then N.toque = toque; window.navigator.maxTouchPoints = toque and 5 or 0; N.redimensionar(W, H) end
end)

-- ===== guia de controles antes de jogar: PC, Xbox ou PlayStation, conforme o aparelho detectado =====
local ACOES = {
  -- ação,              PC,             Xbox,     PlayStation
  { "Andar",            "A  D",         "LS",     "LS" },
  { "Pular",            "ESPAÇO",       "A",      "✕" },
  { "Jogar papel",      "J",            "X",      "□" },
  { "Peidão",           "K",            "B",      "○" },
  { "Dash",             "L",            "RB",     "R1" },
  { "Falar e entrar",   "E",            "Y",      "△" },
  { "Chamar o Reeis",   "R",            "LB",     "L1" },
  { "Bivolt",           "B",            "RT",     "R2" },
  { "Provocar",         "T",            "LT",     "L2" },
  { "Carro a gás",      "V",            "L3",     "L3" },
  { "Pausa e menu",     "ESC",          "MENU",   "OPTIONS" },
  { "Este guia",        "F1",           "VIEW",   "SHARE" },
}
local CORES = {
  xbox = { A = Color3.fromRGB(96, 176, 64), B = Color3.fromRGB(210, 64, 56), X = Color3.fromRGB(56, 120, 220), Y = Color3.fromRGB(232, 190, 40) },
  ps = { ["✕"] = Color3.fromRGB(110, 150, 230), ["○"] = Color3.fromRGB(230, 90, 90), ["□"] = Color3.fromRGB(220, 120, 200), ["△"] = Color3.fromRGB(70, 190, 160) },
}
local function aparelho()
  local ultimo = UIS:GetLastInputType()
  local controle = ultimo.Name:match("^Gamepad") ~= nil or (UIS.GamepadEnabled and not UIS.KeyboardEnabled and not UIS.TouchEnabled)
  if controle then
    local nome = ""
    pcall(function() nome = UIS:GetStringForKeyCode(Enum.KeyCode.ButtonA) .. UIS:GetStringForKeyCode(Enum.KeyCode.ButtonX) end)
    if nome:match("Cross") or nome:match("Square") then return "ps" end
    return "xbox"
  end
  if UIS.TouchEnabled and not UIS.KeyboardEnabled then return "toque" end
  return "pc"
end
local guia
local function botaoDesenho(pai, texto, tipo)
  -- tecla do PC (tecla de madeira), botão redondo colorido (A B X Y / ✕ ○ □ △) ou gatilho/ombro (retângulo)
  local f = Instance.new("TextLabel"); f.BorderSizePixel = 0; f.ZIndex = 13; f.Text = texto; f.TextScaled = true; f.FontFace = PIXEL; f.Parent = pai
  local canto = Instance.new("UICorner"); canto.Parent = f
  local cor = CORES[tipo] and CORES[tipo][texto]
  if cor then f.Size = UDim2.fromScale(.11, .9); f.SizeConstraint = Enum.SizeConstraint.RelativeYY; f.BackgroundColor3 = Color3.fromRGB(34, 30, 28); f.TextColor3 = cor; canto.CornerRadius = UDim.new(1, 0)
    local borda = Instance.new("UIStroke"); borda.Color = cor; borda.Thickness = 2; borda.Parent = f
  elseif tipo == "pc" then f.Size = UDim2.fromScale(math.max(.12, #texto * .035), .85); f.BackgroundColor3 = Color3.fromRGB(242, 226, 190); f.TextColor3 = Color3.fromRGB(60, 36, 18); canto.CornerRadius = UDim.new(0, 4)
    local borda = Instance.new("UIStroke"); borda.Color = Color3.fromRGB(120, 80, 40); borda.Thickness = 2; borda.Parent = f
  else f.Size = UDim2.fromScale(math.max(.12, #texto * .04), .8); f.BackgroundColor3 = Color3.fromRGB(46, 42, 40); f.TextColor3 = Color3.fromRGB(240, 236, 228); canto.CornerRadius = UDim.new(0, 8) end
  local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0, 4); pad.PaddingRight = UDim.new(0, 4); pad.Parent = f
  return f
end
local function mostrarGuia(tipo)
  if guia then guia:Destroy(); guia = nil end
  tipo = tipo or aparelho()
  if tipo == "toque" then return end
  local coluna = tipo == "pc" and 2 or tipo == "xbox" and 3 or 4
  local titulo = tipo == "pc" and "TECLADO E MOUSE" or tipo == "xbox" and "CONTROLE DE XBOX" or "CONTROLE DE PLAYSTATION"
  local p = Instance.new("Frame"); p.Name = "Guia"; p.Size = UDim2.fromScale(1, 1); p.BackgroundColor3 = Color3.fromRGB(20, 14, 8); p.BackgroundTransparency = .1; p.ZIndex = 10; p.Parent = gui
  local caixa = Instance.new("Frame"); caixa.AnchorPoint = Vector2.new(.5, .5); caixa.Position = UDim2.fromScale(.5, .5); caixa.Size = UDim2.fromScale(.9, .9); caixa.BackgroundColor3 = Color3.fromRGB(138, 90, 50); caixa.ZIndex = 11; caixa.Parent = p
  local prop = Instance.new("UIAspectRatioConstraint"); prop.AspectRatio = 16 / 9; prop.Parent = caixa
  local b1 = Instance.new("UIStroke"); b1.Color = Color3.fromRGB(74, 46, 24); b1.Thickness = 5; b1.Parent = caixa
  local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 10); c1.Parent = caixa
  -- tábuas de madeira no fundo
  for k = 0, 5 do local t = Instance.new("Frame"); t.BorderSizePixel = 0; t.Position = UDim2.fromScale(0, k / 6); t.Size = UDim2.new(1, 0, 0, 2); t.BackgroundColor3 = Color3.fromRGB(100, 64, 34); t.ZIndex = 11; t.Parent = caixa end
  local t1 = Instance.new("TextLabel"); t1.BackgroundTransparency = 1; t1.Position = UDim2.fromScale(.04, .03); t1.Size = UDim2.fromScale(.92, .09); t1.FontFace = PIXEL; t1.TextScaled = true; t1.TextColor3 = Color3.fromRGB(255, 233, 168); t1.Text = "GUIA · " .. titulo; t1.ZIndex = 12; t1.Parent = caixa
  local t2 = Instance.new("TextLabel"); t2.BackgroundTransparency = 1; t2.Position = UDim2.fromScale(.04, .12); t2.Size = UDim2.fromScale(.92, .05); t2.Font = Enum.Font.GothamBold; t2.TextScaled = true; t2.TextColor3 = Color3.fromRGB(250, 236, 200)
  t2.Text = tipo == "pc" and "Também vale: setas para andar, Shift para o dash e Enter para falar." or "As setas do direcional também andam e escolhem nos menus."; t2.ZIndex = 12; t2.Parent = caixa
  for i, a in ipairs(ACOES) do
    local col = (i - 1) % 2; local lin = math.floor((i - 1) / 2)
    local linha = Instance.new("Frame"); linha.BackgroundColor3 = lin % 2 == 0 and Color3.fromRGB(150, 100, 58) or Color3.fromRGB(122, 78, 42); linha.BorderSizePixel = 0
    linha.Position = UDim2.fromScale(.04 + col * .47, .2 + lin * .115); linha.Size = UDim2.fromScale(.45, .1); linha.ZIndex = 12; linha.Parent = caixa
    local cl = Instance.new("UICorner"); cl.CornerRadius = UDim.new(0, 6); cl.Parent = linha
    local lista = Instance.new("UIListLayout"); lista.FillDirection = Enum.FillDirection.Horizontal; lista.VerticalAlignment = Enum.VerticalAlignment.Center; lista.Padding = UDim.new(0, 8); lista.Parent = linha
    local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0, 8); pad.Parent = linha
    botaoDesenho(linha, a[coluna], tipo)
    local nome = Instance.new("TextLabel"); nome.BackgroundTransparency = 1; nome.Size = UDim2.fromScale(.7, .7); nome.Font = Enum.Font.GothamBold; nome.TextScaled = true; nome.TextXAlignment = Enum.TextXAlignment.Left
    nome.TextColor3 = Color3.fromRGB(255, 246, 220); nome.Text = a[1]; nome.ZIndex = 13; nome.Parent = linha
  end
  local rod = Instance.new("TextLabel"); rod.BackgroundTransparency = 1; rod.Position = UDim2.fromScale(.04, .91); rod.Size = UDim2.fromScale(.92, .06); rod.FontFace = PIXEL; rod.TextScaled = true; rod.TextColor3 = Color3.fromRGB(255, 233, 168)
  rod.Text = tipo == "pc" and "APERTE QUALQUER TECLA PARA JOGAR" or "APERTE QUALQUER BOTÃO PARA JOGAR"; rod.ZIndex = 12; rod.Parent = caixa
  guia = p
end
paginaControles = setmetatable({}, { __index = function(_, k) if k == "Visible" then return guia ~= nil end end,
  __newindex = function(_, k, v) if k == "Visible" then if v then mostrarGuia() elseif guia then guia:Destroy(); guia = nil end end end })
mostrarGuia()
-- se o jogador trocar de aparelho (ligar um controle, por exemplo), mostra o guia do aparelho novo uma vez
local jaMostrado = { [aparelho()] = true }
UIS.LastInputTypeChanged:Connect(function()
  local a = aparelho()
  if not jaMostrado[a] and a ~= "toque" then jaMostrado[a] = true; task.defer(mostrarGuia, a) end
end)
-- ===== controles de toque (celular): direcional e botões do próprio Roblox, por cima do jogo =====
-- Aparecem só no celular e só com o jogo rolando (jogo, conversa, luta); cada botão vira a tecla do jogo.
local controlesToque = Instance.new("Frame")
controlesToque.Name = "ControlesToque"; controlesToque.Size = UDim2.fromScale(1, 1); controlesToque.BackgroundTransparency = 1
controlesToque.Visible = false; controlesToque.ZIndex = 20; controlesToque.Parent = gui
local MADEIRA, BORDA, LETRA = Color3.fromRGB(138, 90, 50), Color3.fromRGB(58, 34, 16), Color3.fromRGB(255, 233, 168)
local function arredondar(o, raio) local c = Instance.new("UICorner"); c.CornerRadius = raio or UDim.new(1, 0); c.Parent = o end
local function borda(o, cor, esp) local b = Instance.new("UIStroke"); b.Color = cor or BORDA; b.Thickness = esp or 3; b.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; b.Parent = o end
-- direcional: aparece onde o polegar encosta (lado esquerdo); parado, fica embaixo à esquerda
local zonaDirecional = Instance.new("TextButton")
zonaDirecional.Text = ""; zonaDirecional.AutoButtonColor = false; zonaDirecional.BackgroundTransparency = 1
zonaDirecional.Size = UDim2.fromScale(.42, .62); zonaDirecional.Position = UDim2.fromScale(0, .38); zonaDirecional.ZIndex = 20; zonaDirecional.Parent = controlesToque
local PADRAO = UDim2.fromScale(.15, .74)
local baseDir = Instance.new("Frame")
baseDir.AnchorPoint = Vector2.new(.5, .5); baseDir.Size = UDim2.fromScale(.30, .30); baseDir.SizeConstraint = Enum.SizeConstraint.RelativeYY
baseDir.Position = PADRAO; baseDir.BackgroundColor3 = BORDA; baseDir.BackgroundTransparency = .5; baseDir.ZIndex = 21; baseDir.Active = false; baseDir.Parent = controlesToque
arredondar(baseDir); borda(baseDir, MADEIRA, 3)
local pinoDir = Instance.new("Frame")
pinoDir.AnchorPoint = Vector2.new(.5, .5); pinoDir.Size = UDim2.fromScale(.42, .42); pinoDir.Position = UDim2.fromScale(.5, .5)
pinoDir.BackgroundColor3 = MADEIRA; pinoDir.ZIndex = 22; pinoDir.Active = false; pinoDir.Parent = baseDir
arredondar(pinoDir); borda(pinoDir, BORDA, 3)
local dedoDir, centroDir
local function direcao(dx, dy)
  if dx < -.35 then apertar("KeyA", "a") else soltar("KeyA", "a") end
  if dx > .35 then apertar("KeyD", "d") else soltar("KeyD", "d") end
  if dy < -.5 then apertar("KeyW", "w") else soltar("KeyW", "w") end
  if dy > .5 then apertar("KeyS", "s") else soltar("KeyS", "s") end
end
zonaDirecional.InputBegan:Connect(function(input)
  if input.UserInputType ~= Enum.UserInputType.Touch or dedoDir then return end
  dedoDir = input; centroDir = Vector2.new(input.Position.X, input.Position.Y)
  local inset = GuiService:GetGuiInset()
  baseDir.Position = UDim2.fromOffset(centroDir.X, centroDir.Y + inset.Y); baseDir.BackgroundTransparency = .3
  pinoDir.Position = UDim2.fromScale(.5, .5)
end)
UIS.InputChanged:Connect(function(input)
  if input ~= dedoDir then return end
  local raio = math.max(1, baseDir.AbsoluteSize.X / 2)
  local d = Vector2.new(input.Position.X, input.Position.Y) - centroDir
  if d.Magnitude > raio then d = d.Unit * raio end
  pinoDir.Position = UDim2.new(.5, d.X, .5, d.Y)
  direcao(d.X / raio, d.Y / raio)
end)
local function soltarDirecional()
  dedoDir = nil; direcao(0, 0); pinoDir.Position = UDim2.fromScale(.5, .5); baseDir.Position = PADRAO; baseDir.BackgroundTransparency = .5
end
UIS.InputEnded:Connect(function(input) if input == dedoDir then soltarDirecional() end end)
-- botões de ação (as mesmas teclas do PC)
local botoesToque = {}
local function botaoToque(texto, code, key, x, y, tam, cor)
  local b = Instance.new("TextButton")
  b.Text = texto; b.FontFace = PIXEL; b.TextScaled = true; b.TextColor3 = LETRA; b.AutoButtonColor = false
  b.AnchorPoint = Vector2.new(.5, .5); b.Position = UDim2.fromScale(x, y); b.Size = UDim2.fromScale(tam, tam); b.SizeConstraint = Enum.SizeConstraint.RelativeYY
  b.BackgroundColor3 = cor or MADEIRA; b.BackgroundTransparency = .12; b.ZIndex = 21; b.Parent = controlesToque
  arredondar(b); borda(b, BORDA, 3)
  local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(.14, 0); pad.PaddingRight = UDim.new(.14, 0); pad.PaddingTop = UDim.new(.3, 0); pad.PaddingBottom = UDim.new(.3, 0); pad.Parent = b
  local dedos = 0
  b.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then dedos = dedos + 1; apertar(code, key); b.BackgroundTransparency = 0 end end)
  b.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then dedos = math.max(0, dedos - 1); if dedos == 0 then soltar(code, key); b.BackgroundTransparency = .12 end end end)
  botoesToque[#botoesToque + 1] = { b = b, code = code, key = key }
  return b
end
botaoToque("PULAR", "Space", " ", .90, .80, .22, Color3.fromRGB(86, 140, 58))
botaoToque("PAPEL", "KeyJ", "j", .77, .86, .17)
botaoToque("PEIDÃO", "KeyK", "k", .80, .62, .17, Color3.fromRGB(110, 120, 52))
botaoToque("DASH", "KeyL", "l", .92, .56, .15)
botaoToque("FALAR", "KeyE", "e", .68, .70, .15, Color3.fromRGB(60, 96, 140))
botaoToque("REEIS", "KeyR", "r", .70, .46, .11)
botaoToque("BIVOLT", "KeyB", "b", .80, .40, .11)
botaoToque("CARRO", "KeyV", "v", .91, .34, .11)
tocouControle = function(pos)
  local inset = GuiService:GetGuiInset()
  local x, y = pos.X + inset.X, pos.Y + inset.Y
  local function dentro(o) local a, t = o.AbsolutePosition, o.AbsoluteSize; return x >= a.X and y >= a.Y and x <= a.X + t.X and y <= a.Y + t.Y end
  if botaoInfo and botaoInfo.Visible and dentro(botaoInfo) then return true end
  if not controlesToque.Visible then return false end
  if dentro(zonaDirecional) then return true end
  for _, bt in ipairs(botoesToque) do if dentro(bt.b) then return true end end
  return false
end
local ESTADOS_JOGO = { jogo = true, dialogo = true, luta = true }
local function atualizarControlesToque()
  local mostrar = N.toque and desenhista and ESTADOS_JOGO[desenhista.estadoNome] or false
  if controlesToque.Visible ~= mostrar then
    controlesToque.Visible = mostrar
    if not mostrar then soltarDirecional(); for _, bt in ipairs(botoesToque) do soltar(bt.code, bt.key); bt.b.BackgroundTransparency = .12 end end
  end
end

-- botão "?" para abrir o guia de novo
local ajuda = Instance.new("TextButton"); ajuda.AnchorPoint = Vector2.new(1, 1); ajuda.Position = UDim2.new(1, -8, 1, -8); ajuda.Size = UDim2.fromOffset(34, 34)
ajuda.BackgroundColor3 = Color3.fromRGB(138, 90, 50); ajuda.FontFace = PIXEL; ajuda.TextSize = 16; ajuda.TextColor3 = Color3.fromRGB(255, 233, 168); ajuda.Text = "?"; ajuda.ZIndex = 9; ajuda.Parent = fundo
ajuda.Visible = not N.toque
ajuda.Activated:Connect(function() mostrarGuia() end)

-- ===== laço principal: avança o jogo, desenha a página e copia para a imagem =====
local writeu32 = buffer.writeu32
-- tela em camadas: a imagem do jogo (canvas do jogo, todo quadro) e a da interface por cima (só quando muda).
-- Sem a segunda imagem (memória de imagem cheia), volta ao jeito antigo: tudo numa imagem só.
local camadas = eiPagina ~= nil and desenhista ~= nil
local function enviar(alvo, tela)
  local px = tela._.px
  if tela.width == W and tela.height == H then alvo:WritePixelsBuffer(Vector2.zero, tamanho, px)
  else local RD = Canvas.RD; for i = 0, W * H - 1 do writeu32(quadro, i * 4, RD(px, i * 4)) end; alvo:WritePixelsBuffer(Vector2.zero, tamanho, quadro) end
end
-- cada canvas da página (jogo, fundo da tela inicial, logo, minigames) vira uma imagem própria, enviada só quando
-- o canvas muda; a imagem da primeira vez reaproveita a que foi criada no começo (ei)
local camadasCv, livreEi = {}, ei
local medidas = { jogo = 0, pagina = 0, envios = 0, imagens = 2, falhas = 0 }
-- Sem memória de imagem para alguma camada (celular com pouca memória para EditableImage): volta a desenhar tudo
-- numa imagem só, como antes, para nada sumir da tela.
local voltarParaImagemUnica
local function camadaDe(el, w, h)
  local c = camadasCv[el]
  if c and (c.w ~= w or c.h ~= h) then if c.ei ~= ei then c.ei:Destroy() end; c.label:Destroy(); camadasCv[el] = nil; c = nil end
  if not c then
    local e
    if livreEi and w == W and h == H then e = livreEi; livreEi = nil else e = (w > 0 and h > 0 and w <= 1024 and h <= 1024) and novaImagemCv(w, h) or nil; if e then medidas.imagens = medidas.imagens + 1 end end
    if not e then medidas.falhas = medidas.falhas + 1; if voltarParaImagemUnica then voltarParaImagemUnica("sem memória para a camada " .. w .. "x" .. h) end; return nil end
    local l = (e == ei) and imagem or Instance.new("ImageLabel")
    l.BackgroundTransparency = 1; l.ResampleMode = Enum.ResamplerMode.Pixelated; l.BorderSizePixel = 0; l.ImageTransparency = 0; l.Parent = palco
    if e ~= ei then l.ImageContent = Content.fromObject(e) end
    c = { ei = e, label = l, w = w, h = h, ver = -1, e = {} }
    camadasCv[el] = c
  end
  return c
end
local function mostrarCanvas()
  local usados = {}
  for i, cam in ipairs(desenhista.camadasCanvas or {}) do
    local el = cam.el
    local fonte = el._ and el._.fonte or el
    local P = fonte._
    -- canvas embaixo deste (o mundo das cenas do roteiro e os efeitos parados), recortados e ampliados pela placa de vídeo
    local base = (cam.acima and 110 or 50) + i * 6
    for j, ab in ipairs((el._ and el._.abaixos) or {}) do
      if j <= 4 and ab.fonte._ and ab.fonte._.w > 0 and ab.sw > 0 and ab.sh > 0 then
        local PA = ab.fonte._
        local c = camadaDe(ab.fonte, PA.w, PA.h)
        if c then
          usados[ab.fonte] = true
          local ver = tostring(PA.versao)
          if c.ver ~= ver then c.ver = ver; c.ei:WritePixelsBuffer(Vector2.zero, Vector2.new(PA.w, PA.h), PA.px); medidas.envios = medidas.envios + 1 end
          local e, l = c.e, c.label
          local kx, ky = cam.w / math.max(1, el.width), cam.h / math.max(1, el.height)
          local x, y = cam.x + ab.dx * kx, cam.y + ab.dy * ky
          if e.x ~= x or e.y ~= y or e.w ~= cam.w or e.h ~= cam.h then e.x, e.y, e.w, e.h = x, y, cam.w, cam.h; l.Position = UDim2.fromScale(x / W, y / H); l.Size = UDim2.fromScale(cam.w / W, cam.h / H) end
          if e.rx ~= ab.sx or e.ry ~= ab.sy or e.rw ~= ab.sw or e.rh ~= ab.sh then e.rx, e.ry, e.rw, e.rh = ab.sx, ab.sy, ab.sw, ab.sh; l.ImageRectOffset = Vector2.new(ab.sx, ab.sy); l.ImageRectSize = Vector2.new(ab.sw, ab.sh) end
          local z = base + j
          if e.z ~= z then e.z = z; l.ZIndex = z end
          if e.tr ~= 0 then e.tr = 0; l.ImageTransparency = 0 end
          if not e.vis then e.vis = true; l.Visible = true end
          c.usado = os.clock()
        end
      end
    end
    if P and P.w > 0 and P.h > 0 then
      local c = camadaDe(el, P.w, P.h)
      if c then
        usados[el] = true
        local ver = tostring(el._.versao) .. ":" .. tostring(P.versao)
        if c.ver ~= ver then c.ver = ver; c.ei:WritePixelsBuffer(Vector2.zero, Vector2.new(P.w, P.h), P.px); medidas.envios = medidas.envios + 1 end
        local e, l = c.e, c.label
        if e.x ~= cam.x or e.y ~= cam.y or e.w ~= cam.w or e.h ~= cam.h then e.x, e.y, e.w, e.h = cam.x, cam.y, cam.w, cam.h; l.Position = UDim2.fromScale(cam.x / W, cam.y / H); l.Size = UDim2.fromScale(cam.w / W, cam.h / H) end
        local z = base + 5
        if e.z ~= z then e.z = z; l.ZIndex = z end
        local tr = 1 - (tonumber(cam.op) or 1)
        if e.tr ~= tr then e.tr = tr; l.ImageTransparency = tr end
        if not e.vis then e.vis = true; l.Visible = true end
        c.usado = os.clock()
      end
    end
  end
  for el, c in pairs(camadasCv) do
    if not usados[el] then
      if c.e.vis then c.e.vis = false; c.label.Visible = false end
      -- canvas sumido faz tempo: libera a memória de imagem
      if c.ei ~= ei and os.clock() - (c.usado or 0) > 5 then c.ei:Destroy(); c.label:Destroy(); camadasCv[el] = nil end
    end
  end
end
voltarParaImagemUnica = function(motivo)
  if not camadas then return end
  warn("[Da Roça] tela em uma imagem só: " .. tostring(motivo))
  camadas = false; window.DAROCA_CAMADAS = false
  for el, c in pairs(camadasCv) do if c.label ~= imagem then c.label.Visible = false end end
  if imagemPagina then imagemPagina.Visible = false end
  if imagemBaixo then imagemBaixo.Visible = false end
  imagem.ImageContent = Content.fromObject(ei); imagem.Position = UDim2.fromScale(0, 0); imagem.Size = UDim2.fromScale(1, 1)
  imagem.ImageRectOffset = Vector2.zero; imagem.ImageRectSize = Vector2.zero; imagem.ImageTransparency = 0; imagem.ZIndex = 50; imagem.Visible = true
end
local function umQuadro()
  emQuadro = true
  local t0 = os.clock()
  N.passo(os.clock() * 1000)
  if camadas then
    local t1 = os.clock()
    local tela, mudou = desenhista.desenhar({ camadas = true })
    emQuadro = false
    if mudou then
      enviar(eiPagina, tela); medidas.envios = medidas.envios + 1
      local k = desenhista.indiceBaixo
      if k then
        if not eiBaixo then
          eiBaixo = novaImagemCv(W, H)
          if eiBaixo then
            medidas.imagens = medidas.imagens + 1
            imagemBaixo = Instance.new("ImageLabel"); imagemBaixo.Size = UDim2.fromScale(1, 1); imagemBaixo.BackgroundTransparency = 1
            imagemBaixo.ResampleMode = Enum.ResamplerMode.Pixelated; imagemBaixo.ImageContent = Content.fromObject(eiBaixo); imagemBaixo.Parent = palco
          else medidas.falhas = medidas.falhas + 1; voltarParaImagemUnica("sem memória para a interface de baixo") end
        end
        if eiBaixo then enviar(eiBaixo, desenhista.telaBaixo); imagemBaixo.ZIndex = 50 + k * 6; imagemBaixo.Visible = true end
      elseif imagemBaixo then imagemBaixo.Visible = false end
    end
    if camadas then mostrarCanvas() end
    medidas.jogo, medidas.pagina = t1 - t0, os.clock() - t1
  else
    local tela = desenhista and desenhista.desenhar() or window.document:getElementById("gameCanvas")
    emQuadro = false
    if tela then enviar(ei, tela) end
  end
  local fila = filaEntradas; filaEntradas = {}
  for _, f in ipairs(fila) do pcall(f) end
end
-- ===== cenário em camadas (cenários HD da campanha 1) =====
-- O jogo desenha o cenário num quadro mais largo que a tela, sem o céu e os fundos que se repetem (que viram imagens
-- próprias). Esse desenho é feito aos poucos, em fatias de FATIA segundos por quadro, numa rotina à parte; quando fica
-- pronto, vai para as imagens. A cada quadro a placa de vídeo só reposiciona as camadas com a câmera: o cenário
-- desliza liso, e as animações dele (árvores, bichos, luzes) andam no ritmo dos desenhos prontos.
local Camadas = require(runtime.camadas)
local HdCam = window.DAROCA_CAMADAS and window.HdMaps and window.HdMaps.camadas or nil
local FATIA, MAXW = 0.003, 1024
local imagensDe = setmetatable({}, { __mode = "k" }) -- canvas → pedaços de EditableImage (até 1024 de largura cada)
local rotulos, estadoRotulo = {}, {}
local frente, pronto, desenhando, falhasFundo = nil, nil, false, 0
local velCam, camAnterior = 0, nil
local function novaImagem(w, h)
  local ok, r = pcall(function() return AssetService:CreateEditableImage({ Size = Vector2.new(w, h) }) end)
  if ok then return r end
  return nil
end
local function imagemDe(cv, reenviar)
  local reg = imagensDe[cv]
  local w, h = cv.width, cv.height
  if reg and (reg.w ~= w or reg.h ~= h) then for _, p in ipairs(reg.pedacos) do p.ei:Destroy() end; reg = nil end
  if not reg then
    reg = { w = w, h = h, pedacos = {} }
    local x0 = 0
    while x0 < w do
      local pw = math.min(MAXW, w - x0)
      local e = novaImagem(pw, h); if not e then return nil end
      reg.pedacos[#reg.pedacos + 1] = { ei = e, x0 = x0, w = pw, conteudo = Content.fromObject(e) }
      x0 = x0 + pw
    end
    imagensDe[cv] = reg; reenviar = true
  end
  if reenviar then
    local px = cv._.px
    if #reg.pedacos == 1 then reg.pedacos[1].ei:WritePixelsBuffer(Vector2.zero, Vector2.new(w, h), px)
    else
      for _, p in ipairs(reg.pedacos) do
        local b = buffer.create(p.w * h * 4)
        for y = 0, h - 1 do buffer.copy(b, y * p.w * 4, px, (y * w + p.x0) * 4, p.w * 4) end
        p.ei:WritePixelsBuffer(Vector2.zero, Vector2.new(p.w, h), b)
      end
    end
  end
  return reg
end
-- céu e névoa mudam devagar: vão para a imagem no máximo duas vezes por segundo
local envioLento = setmetatable({}, { __mode = "k" })
local function lento(cv) local t = os.clock(); local u = envioLento[cv]; if u and t - u < .5 and imagensDe[cv] then return false end; envioLento[cv] = t; return true end
local function consumir(info)
  local ok = imagemDe(info.meio, true) ~= nil
  for _, f in ipairs(info.fundo) do
    if f.tipo == "ceu" then ok = imagemDe(info.ceu, lento(info.ceu)) ~= nil and ok
    elseif f.tipo == "nevoa" then ok = imagemDe(f.cv, lento(f.cv)) ~= nil and ok
    elseif f.tipo == "tile" then ok = imagemDe(f.img, false) ~= nil and ok end
  end
  if not ok then warn("[Da Roça] sem memória de imagem para as camadas do cenário; voltando ao desenho direto"); window.DAROCA_CAMADAS = false; HdCam = nil; frente = nil; return end
  frente = info
end
local BRANCO = Color3.new(1, 1, 1)
local function mostrarFundo()
  local cena = window.DAROCA_QUADRO_CAMADAS
  local n = 0
  if frente and cena ~= nil and cena >= 0 and frente.cena == cena then
    local itens = Camadas.montar(frente, window.DAROCA_QUADRO_CAMERA, window.DAROCA_QUADRO_TREMOR_X, window.DAROCA_QUADRO_TREMOR_Y)
    -- cenas do roteiro: o cenário passa pelo mesmo recorte com zoom do mundo (feito pela placa de vídeo)
    local Z = window.DAROCA_QUADRO_ZOOM
    if Z and (tonumber(Z.sw) or 0) > 0 and (tonumber(Z.sh) or 0) > 0 then
      local kx, ky = W / Z.sw, H / Z.sh
      for _, it in ipairs(itens) do it.x = (it.x - Z.sx) * kx + Z.dx; it.y = (it.y - Z.sy) * ky + Z.dy; it.w = it.w * kx; it.h = it.h * ky end
    end
    for z, it in ipairs(itens) do
      local reg = imagensDe[it.fonte]
      if reg then
        local k = it.w / reg.w
        for _, p in ipairs(reg.pedacos) do
          n = n + 1
          local l, e = rotulos[n], estadoRotulo[n]
          if not l then
            l = Instance.new("ImageLabel"); l.BackgroundTransparency = 1; l.ResampleMode = Enum.ResamplerMode.Pixelated; l.BorderSizePixel = 0; l.Parent = palco
            rotulos[n] = l; e = {}; estadoRotulo[n] = e
          end
          if e.conteudo ~= p.conteudo then e.conteudo = p.conteudo; l.ImageContent = p.conteudo end
          local x, w2, h2 = it.x + p.x0 * k, p.w * k, it.h
          if e.x ~= x or e.y ~= it.y or e.w ~= w2 or e.h ~= h2 then e.x, e.y, e.w, e.h = x, it.y, w2, h2; l.Position = UDim2.fromScale(x / W, it.y / H); l.Size = UDim2.fromScale(w2 / W, h2 / H) end
          local tr = 1 - it.alfa
          if e.tr ~= tr then e.tr = tr; l.ImageTransparency = tr end
          local t = it.tinta
          local cor = t and Color3.new(t[1], t[2], t[3]) or BRANCO
          if e.cor ~= cor then e.cor = cor; l.ImageColor3 = cor end
          if e.z ~= z then e.z = z; l.ZIndex = z end
          if not e.vis then e.vis = true; l.Visible = true end
        end
      end
    end
  end
  for i = n + 1, #rotulos do local e = estadoRotulo[i]; if e.vis then e.vis = false; rotulos[i].Visible = false end end
end
local function trabalhoFundo()
  while true do
    local cena = window.DAROCA_QUADRO_CAMADAS
    if HdCam and cena and cena >= 0 and not pronto then
      -- desenha um pouco à frente, para o lado em que a câmera está indo
      local cam = (window.DAROCA_QUADRO_CAMERA or 0) + math.clamp(velCam * .25, -140, 140)
      desenhando = true
      local ok, info = pcall(function() return HdCam:desenhar(cena, cam, window.DAROCA_QUADRO_TEMPO or 0, window.DAROCA_QUADRO_HORA) end)
      desenhando = false
      if ok and info then pronto = info; falhasFundo = 0
      elseif not ok then
        falhasFundo = falhasFundo + 1; warn("[Da Roça] cenário em camadas: " .. tostring(info))
        if falhasFundo >= 3 then window.DAROCA_CAMADAS = false; HdCam = nil end
      end
    end
    coroutine.yield()
  end
end
if HdCam then fundoCo = coroutine.create(trabalhoFundo) end
local function passoFundo(dt)
  if not fundoCo then return end
  local cena, cam = window.DAROCA_QUADRO_CAMADAS, window.DAROCA_QUADRO_CAMERA or 0
  if camAnterior and dt > 0 then velCam = velCam * .7 + ((cam - camAnterior) / dt) * .3 end
  camAnterior = cam
  local ativo = cena ~= nil and cena >= 0
  if ativo or desenhando then
    -- urgente: cenário novo ou câmera fora do quadro pronto (o desenho termina neste quadro mesmo)
    local urgente = desenhando and not ativo or (ativo and (not frente or frente.cena ~= cena or not Camadas.cabe(frente, cam, window.DAROCA_QUADRO_ZOOM)))
    fatiaAte = os.clock() + (urgente and 1.5 or FATIA)
    if coroutine.status(fundoCo) == "suspended" then
      local ok, e = coroutine.resume(fundoCo)
      if not ok then warn("[Da Roça] rotina do cenário: " .. tostring(e)); desenhando = false; fundoCo = HdCam and coroutine.create(trabalhoFundo) or nil end
    end
  end
  if pronto then local info = pronto; pronto = nil; consumir(info) end
end

-- ===== painel de desempenho (F3): quadros por segundo e quanto cada parte gasta, para foto/diagnóstico =====
local painel = Instance.new("TextLabel")
painel.Visible = false; painel.BackgroundColor3 = Color3.new(0, 0, 0); painel.BackgroundTransparency = .3; painel.BorderSizePixel = 0
painel.TextColor3 = Color3.fromRGB(255, 233, 168); painel.Font = Enum.Font.Code; painel.TextSize = 14
painel.TextXAlignment = Enum.TextXAlignment.Left; painel.TextYAlignment = Enum.TextYAlignment.Top
painel.Size = UDim2.fromOffset(380, 150); painel.Position = UDim2.fromOffset(8, 44); painel.ZIndex = 30; painel.Parent = gui
painel.TextWrapped = true
-- botão "i" (canto de baixo à esquerda, na faixa preta do celular): abre e fecha o painel sem teclado
botaoInfo = Instance.new("TextButton")
botaoInfo.AnchorPoint = Vector2.new(0, 1); botaoInfo.Position = UDim2.new(0, 6, 1, -6); botaoInfo.Size = UDim2.fromOffset(26, 26)
botaoInfo.BackgroundColor3 = Color3.fromRGB(40, 28, 18); botaoInfo.BackgroundTransparency = .35; botaoInfo.TextColor3 = Color3.fromRGB(255, 233, 168)
botaoInfo.Font = Enum.Font.Code; botaoInfo.TextSize = 16; botaoInfo.Text = "i"; botaoInfo.ZIndex = 31; botaoInfo.Parent = gui
botaoInfo.Activated:Connect(function() painel.Visible = not painel.Visible end)
local somaP = { n = 0, jogo = 0, pagina = 0, fundo = 0, total = 0, envios = 0, t = os.clock() }
local function atualizarPainel(tFundo, tTotal)
  somaP.n = somaP.n + 1; somaP.jogo = somaP.jogo + (medidas.jogo or 0); somaP.pagina = somaP.pagina + (medidas.pagina or 0)
  somaP.fundo = somaP.fundo + tFundo; somaP.total = somaP.total + tTotal
  local agora = os.clock()
  if agora - somaP.t < .5 then return end
  if painel.Visible then
    local n = math.max(1, somaP.n)
    local nivel = "?"; pcall(function() nivel = tostring(window.Graphics:level()) end)
    local ut = ultimoToque and ("%.0f,%.0f → %s"):format(ultimoToque.x, ultimoToque.y, tostring(ultimoToque.alvo)) or "nenhum"
    painel.Text = ("DA ROÇA · %s\n%.0f quadros/s\nlua: %.1f ms (jogo %.1f · tela %.1f · cenário %.1f)\nenvios de imagem: %.0f/s · imagens %d (falhas %d)\nqualidade: %s · camadas: %s · toque: %s\ncena: %s · tela: %s\nÚltimo toque: %s"):format(
      VERSAO, somaP.n / (agora - somaP.t), somaP.total / n * 1000, somaP.jogo / n * 1000, somaP.pagina / n * 1000, somaP.fundo / n * 1000,
      medidas.envios / (agora - somaP.t), medidas.imagens, medidas.falhas, nivel, (camadas and window.DAROCA_CAMADAS) and "sim" or "não", N.toque and "sim" or "não",
      tostring(window.DAROCA_QUADRO_CAMADAS), tostring(desenhista and desenhista.estadoNome), ut)
  end
  medidas.envios = 0
  somaP = { n = 0, jogo = 0, pagina = 0, fundo = 0, total = 0, t = agora }
end
UIS.InputBegan:Connect(function(input)
  if input.KeyCode == Enum.KeyCode.F3 then painel.Visible = not painel.Visible end
end)

-- um quadro de cada vez, num laço próprio (pode pausar no meio de um quadro pesado sem o Roblox derrubar o script)
local primeiro, errosSeguidos, inicioQuadros = true, 0, os.clock()
local ultimoQuadro, inicioLaco = nil, os.clock()
task.spawn(function()
  while true do
    ultimaPausa = os.clock(); inicioLaco = os.clock()
    local ok, e = pcall(umQuadro)
    if not ok then
      emQuadro = false; errosSeguidos = errosSeguidos + 1; warn("[Da Roça] quadro: " .. tostring(e))
      if errosSeguidos >= 3 then aviso.Visible = true; aviso.TextSize = 14
        aviso.Text = "DEU ERRO AO DESENHAR A TELA (" .. VERSAO .. ")\n\n" .. tostring(e):sub(1, 300) .. "\n\nTire uma foto desta tela e da janela Output e mande." end
    else
      errosSeguidos = 0
      if primeiro then primeiro = false; aviso.Visible = false; print(("[Da Roça] primeiro quadro em %.1f s"):format(os.clock() - inicioQuadros)) end
    end
    local tF = os.clock()
    local okF, eF = pcall(passoFundo, os.clock() - (ultimoQuadro or os.clock())); ultimoQuadro = os.clock()
    if not okF then warn("[Da Roça] camadas: " .. tostring(eF)) end
    pcall(mostrarFundo)
    pcall(atualizarControlesToque)
    pcall(atualizarPainel, os.clock() - tF, os.clock() - inicioLaco)
    RunService.RenderStepped:Wait()
  end
end)
