--!nocheck
--[[ Da Roça Adventure no Roblox — script do jogador (StarterPlayerScripts).
  Roda o jogo original (convertido de JavaScript para Luau pela pasta roblox/ferramentas) e mostra a tela
  numa imagem 2D (EditableImage) do tamanho do jogo, 960 x 540, ampliada sem filtro para manter o pixel.
  - PC: teclado e mouse com as mesmas teclas do jogo;
  - celular: toque nos mesmos botões do jogo (o jogo desenha os botões de toque dele);
  - Xbox e PlayStation: controle mapeado para as teclas do jogo (página "Como jogar" explica cada botão);
  - a qualidade gráfica do Roblox (Configurações > Qualidade gráfica) escolhe a qualidade do jogo:
    1 a 3 = BAIXA, 4 a 7 = MÉDIA, 8 a 10 = ALTA, Automático = AUTOMÁTICA do jogo;
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
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CFrame.new(0, 10000, 0)

local gui = Instance.new("ScreenGui")
gui.Name = "DaRoca"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = jogador:WaitForChild("PlayerGui")
local fundo = Instance.new("Frame"); fundo.Size = UDim2.fromScale(1, 1); fundo.BackgroundColor3 = Color3.new(0, 0, 0); fundo.BorderSizePixel = 0; fundo.Parent = gui
local imagem = Instance.new("ImageLabel")
imagem.AnchorPoint = Vector2.new(.5, .5); imagem.Position = UDim2.fromScale(.5, .5); imagem.Size = UDim2.fromScale(1, 1)
imagem.BackgroundTransparency = 1; imagem.ResampleMode = Enum.ResamplerMode.Pixelated; imagem.Parent = fundo
local proporcao = Instance.new("UIAspectRatioConstraint"); proporcao.AspectRatio = 16 / 9; proporcao.Parent = imagem

local PIXEL = Font.new("rbxasset://fonts/families/PressStart2P.json")
local aviso = Instance.new("TextLabel")
aviso.Size = UDim2.fromScale(1, 1); aviso.BackgroundTransparency = 1; aviso.TextColor3 = Color3.fromRGB(255, 233, 168); aviso.FontFace = PIXEL; aviso.TextSize = 18
aviso.Text = "CARREGANDO DA ROÇA ADVENTURE..."; aviso.Parent = fundo

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
N.toque = UIS.TouchEnabled and not UIS.KeyboardEnabled
window.navigator.maxTouchPoints = N.toque and 5 or 0
window.localStorage._carregar(salvosIniciais)

-- qualidade do Roblox → qualidade do jogo (antes de carregar, para o jogo já nascer na certa)
local configuracoes = UserSettings():GetService("UserGameSettings")
local function nivelDoRoblox()
  local q = configuracoes.SavedQualityLevel
  if q == Enum.SavedQualitySetting.Automatic then return "auto" end
  local n = tonumber(tostring(q):match("(%d+)$")) or 5
  if n <= 3 then return "low" elseif n <= 7 then return "medium" end
  return "high"
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
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista, Audio = Audio,
    exigir = function(nome) local m = jogoPasta:FindFirstChild(nome); if not m then error("módulo " .. nome .. " não encontrado") end; local r = require(m); carregados = carregados + 1; aviso.Text = ("CARREGANDO... %d"):format(carregados); task.wait(); return r end,
    aoCarregar = function() end })
end)
if not ok then aviso.Text = "ERRO AO CARREGAR: " .. tostring(erro); warn(erro); return end
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
local W, H = 960, 540
local ei = AssetService:CreateEditableImage({ Size = Vector2.new(W, H) })
imagem.ImageContent = Content.fromObject(ei)
local quadro = buffer.create(W * H * 4)
local tamanho = Vector2.new(W, H)
aviso.Visible = false

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
  local x = (p.X + 0 - imagem.AbsolutePosition.X) / imagem.AbsoluteSize.X * W
  local y = (p.Y + inset.Y - imagem.AbsolutePosition.Y) / imagem.AbsoluteSize.Y * H
  return x, y
end
local toques, proxToque = {}, 1
local function idDoToque(input) local id = toques[input]; if not id then id = proxToque; proxToque = proxToque + 1; toques[input] = id end; return id end

local paginaControles -- criada mais abaixo
UIS.InputBegan:Connect(function(input, processado)
  if paginaControles and paginaControles.Visible then
    if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType.Name:match("^Gamepad") or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then paginaControles.Visible = false; return end
  end
  if input.UserInputType == Enum.UserInputType.Keyboard then
    if input.KeyCode == Enum.KeyCode.F1 then paginaControles.Visible = true; return end
    local code, key = codigoDe(input.KeyCode); if code then apertar(code, key) end
  elseif input.UserInputType.Name:match("^Gamepad") then
    if input.KeyCode == Enum.KeyCode.ButtonSelect then if paginaControles then paginaControles.Visible = true end; return end
    local m = CONTROLE[input.KeyCode.Name]; if m then apertar(m[1], m[2]) end
  elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerdown", x, y, 1, false)
  elseif input.UserInputType == Enum.UserInputType.Touch then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerdown", x, y, idDoToque(input), true)
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
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointerup", x, y, idDoToque(input), true); toques[input] = nil
  end
end)
UIS.InputChanged:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseMovement then
    local x, y = posicaoNoJogo(input.Position); N.ponteiro("pointermove", x, y, 1, false)
  elseif input.UserInputType == Enum.UserInputType.Touch then
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
-- botão "?" para abrir o guia de novo
local ajuda = Instance.new("TextButton"); ajuda.AnchorPoint = Vector2.new(1, 1); ajuda.Position = UDim2.new(1, -8, 1, -8); ajuda.Size = UDim2.fromOffset(34, 34)
ajuda.BackgroundColor3 = Color3.fromRGB(138, 90, 50); ajuda.FontFace = PIXEL; ajuda.TextSize = 16; ajuda.TextColor3 = Color3.fromRGB(255, 233, 168); ajuda.Text = "?"; ajuda.ZIndex = 9; ajuda.Parent = fundo
ajuda.Visible = not N.toque
ajuda.Activated:Connect(function() mostrarGuia() end)

-- ===== laço principal: avança o jogo, desenha a página e copia para a imagem =====
local writeu32 = buffer.writeu32
RunService.RenderStepped:Connect(function()
  N.passo(os.clock() * 1000)
  local tela = desenhista and desenhista.desenhar() or window.document:getElementById("gameCanvas")
  if not tela then return end
  -- os pixels da tela já são um buffer RGBA do tamanho certo: vão direto para a imagem
  local px = tela._.px
  if tela.width == W and tela.height == H then ei:WritePixelsBuffer(Vector2.zero, tamanho, px)
  else local RD = Canvas.RD; for i = 0, W * H - 1 do writeu32(quadro, i * 4, RD(px, i * 4)) end; ei:WritePixelsBuffer(Vector2.zero, tamanho, quadro) end
end)
