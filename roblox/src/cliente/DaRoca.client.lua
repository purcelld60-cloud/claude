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

local carregados = 0
local ok, erro = pcall(function()
  Carregar.iniciar({ JS = JS, N = N, Canvas = Canvas, lualib = LL, Desenhista = Desenhista,
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

-- ===== página "Como jogar" (PC, Xbox e PlayStation) =====
local ACOES = {
  { "Andar", "A / D ou ← →", "Alavanca esquerda ou setas", "Alavanca esquerda ou setas" },
  { "Pular", "Espaço", "A", "✕" },
  { "Jogar papel", "J", "X", "□" },
  { "Peidão", "K", "B", "○" },
  { "Dash", "L ou Shift", "RB", "R1" },
  { "Falar, entrar e pegar", "E ou Enter", "Y", "△" },
  { "Chamar o Reeis", "R", "LB", "L1" },
  { "Bivolt", "B", "RT", "R2" },
  { "Provocar", "T", "LT", "L2" },
  { "Carro a gás", "V", "Apertar a alavanca (L3)", "Apertar a alavanca (L3)" },
  { "Pausa e menu", "Esc", "Menu (☰)", "Options" },
  { "Esta página", "—", "Exibir (⧉)", "Share / Create" },
}
local function criarPagina()
  local p = Instance.new("Frame"); p.Name = "ComoJogar"; p.Size = UDim2.fromScale(1, 1); p.BackgroundColor3 = Color3.fromRGB(28, 18, 10); p.BackgroundTransparency = .08; p.ZIndex = 10; p.Parent = gui
  local caixa = Instance.new("Frame"); caixa.AnchorPoint = Vector2.new(.5, .5); caixa.Position = UDim2.fromScale(.5, .5); caixa.Size = UDim2.fromScale(.92, .9); caixa.BackgroundColor3 = Color3.fromRGB(138, 90, 50); caixa.ZIndex = 11; caixa.Parent = p
  local borda = Instance.new("UIStroke"); borda.Color = Color3.fromRGB(74, 46, 24); borda.Thickness = 4; borda.Parent = caixa
  local canto = Instance.new("UICorner"); canto.CornerRadius = UDim.new(0, 6); canto.Parent = caixa
  local titulo = Instance.new("TextLabel"); titulo.Size = UDim2.new(1, 0, .1, 0); titulo.BackgroundTransparency = 1; titulo.FontFace = PIXEL; titulo.TextScaled = true; titulo.TextColor3 = Color3.fromRGB(255, 233, 168); titulo.Text = "COMO JOGAR"; titulo.ZIndex = 12; titulo.Parent = caixa
  local colunas = { "AÇÃO", "PC", "XBOX", "PLAYSTATION" }
  local larg = { .3, .22, .24, .24 }
  local x = .0
  for c, nome in ipairs(colunas) do
    local cab = Instance.new("TextLabel"); cab.Position = UDim2.fromScale(x, .11); cab.Size = UDim2.fromScale(larg[c], .06); cab.BackgroundColor3 = Color3.fromRGB(74, 46, 24); cab.FontFace = PIXEL; cab.TextScaled = true; cab.TextColor3 = Color3.fromRGB(242, 201, 76); cab.Text = nome; cab.ZIndex = 12; cab.Parent = caixa
    for i, a in ipairs(ACOES) do
      local t = Instance.new("TextLabel"); t.Position = UDim2.fromScale(x, .17 + (i - 1) * .063); t.Size = UDim2.fromScale(larg[c], .06)
      t.BackgroundColor3 = i % 2 == 0 and Color3.fromRGB(122, 78, 42) or Color3.fromRGB(150, 100, 58); t.BorderSizePixel = 0
      t.Font = c == 1 and Enum.Font.Arcade or Enum.Font.GothamBold; t.TextScaled = true; t.TextColor3 = Color3.fromRGB(255, 246, 220); t.Text = a[c]; t.ZIndex = 12; t.Parent = caixa
      local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0, 6); pad.PaddingRight = UDim.new(0, 6); pad.Parent = t
    end
    x = x + larg[c]
  end
  local rodape = Instance.new("TextLabel"); rodape.Position = UDim2.fromScale(0, .93); rodape.Size = UDim2.fromScale(1, .06); rodape.BackgroundTransparency = 1; rodape.FontFace = PIXEL; rodape.TextScaled = true; rodape.TextColor3 = Color3.fromRGB(255, 233, 168)
  rodape.Text = N.toque and "No celular, use os botões do próprio jogo. Toque para jogar." or "Aperte qualquer tecla ou botão para jogar"; rodape.ZIndex = 12; rodape.Parent = caixa
  return p
end
paginaControles = criarPagina()
-- botão "?" para abrir a página de novo
local ajuda = Instance.new("TextButton"); ajuda.AnchorPoint = Vector2.new(1, 1); ajuda.Position = UDim2.new(1, -8, 1, -8); ajuda.Size = UDim2.fromOffset(34, 34)
ajuda.BackgroundColor3 = Color3.fromRGB(138, 90, 50); ajuda.FontFace = PIXEL; ajuda.TextSize = 16; ajuda.TextColor3 = Color3.fromRGB(255, 233, 168); ajuda.Text = "?"; ajuda.ZIndex = 9; ajuda.Parent = fundo
ajuda.Activated:Connect(function() paginaControles.Visible = true end)

-- ===== laço principal: avança o jogo, desenha a página e copia para a imagem =====
local writeu32 = buffer.writeu32
RunService.RenderStepped:Connect(function()
  N.passo(os.clock() * 1000)
  local tela = desenhista and desenhista.desenhar() or window.document:getElementById("gameCanvas")
  if not tela then return end
  local px = tela._.px
  for i = 1, W * H do writeu32(quadro, (i - 1) * 4, px[i] or 0) end
  ei:WritePixelsBuffer(Vector2.zero, tamanho, quadro)
end)
