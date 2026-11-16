-- Da Roça Adventure (protótipo para Roblox)
-- Monta a fase lateral em blocos: roça, ponte sobre o rio, estrada, praça e a escola
-- onde o Igor espera. Tudo é criado por código, então o lugar abre vazio no Studio e
-- se constrói ao apertar Play.
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

-- Canais entre servidor e jogadores
local remotes = Instance.new("Folder")
remotes.Name = "DaRocaRemotes"
for _, nome in ipairs({ "Ataque", "Efeito" }) do
	local r = Instance.new("RemoteEvent")
	r.Name = nome
	r.Parent = remotes
end
remotes.Parent = ReplicatedStorage
local Efeito = remotes.Efeito

local mapa = Instance.new("Folder")
mapa.Name = "DaRocaMapa"
mapa.Parent = workspace

local rng = Random.new(2024)
local function rgb(r, g, b)
	return Color3.fromRGB(r, g, b)
end
local BRANCO, PRETO = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
-- Variação de tom, para dar o ar de pixel art aos blocos repetidos
local function tom(cor, quanto)
	local s = rng:NextNumber(-quanto, quanto)
	if s > 0 then
		return cor:Lerp(BRANCO, s)
	end
	return cor:Lerp(PRETO, -s)
end

local function bloco(tamanho, pos, cor, material, pai, props)
	local p = Instance.new("Part")
	p.Anchored = true
	p.Size = tamanho
	if typeof(pos) == "CFrame" then
		p.CFrame = pos
	else
		p.Position = pos
	end
	p.Color = cor
	p.Material = material or Enum.Material.SmoothPlastic
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	if props then
		for k, v in pairs(props) do
			p[k] = v
		end
	end
	p.Parent = pai or mapa
	return p
end
-- Enfeite: não colide nem atrapalha a câmera
local function enfeite(tamanho, pos, cor, material, pai)
	return bloco(tamanho, pos, cor, material, pai, { CanCollide = false, CanTouch = false, CanQuery = false })
end

local function placa(texto, pos, w, h, fundo, letra, pai)
	local p = enfeite(Vector3.new(w, h, 0.6), pos, fundo, Enum.Material.Wood, pai)
	local g = Instance.new("SurfaceGui")
	g.Face = Enum.NormalId.Back -- virada para a câmera (+Z)
	g.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	g.PixelsPerStud = 40
	g.LightInfluence = 0.6
	g.Parent = p
	local t = Instance.new("TextLabel")
	t.Size = UDim2.fromScale(1, 1)
	t.BackgroundTransparency = 1
	t.Text = texto
	t.TextScaled = true
	t.Font = Enum.Font.Arcade
	t.TextColor3 = letra
	t.TextStrokeTransparency = 0.4
	t.Parent = g
	return p
end

------------------------------------------------------------------------------------
-- Luz: fim de tarde dourado, com névoa, brilho e raios de sol (o "shader" do Roblox)
------------------------------------------------------------------------------------
Lighting.ClockTime = 16.6
Lighting.GeographicLatitude = 20
Lighting.Brightness = 2.4
Lighting.Ambient = rgb(70, 62, 70)
Lighting.OutdoorAmbient = rgb(150, 136, 128)
Lighting.EnvironmentDiffuseScale = 0.6
Lighting.EnvironmentSpecularScale = 0.4
Lighting.GlobalShadows = true
local function efeitoLuz(classe, props)
	local e = Instance.new(classe)
	for k, v in pairs(props) do
		e[k] = v
	end
	e.Parent = Lighting
end
efeitoLuz("Atmosphere", { Density = 0.3, Offset = 0.1, Haze = 1.6, Glare = 0.5, Color = rgb(255, 214, 170), Decay = rgb(120, 92, 110) })
efeitoLuz("BloomEffect", { Intensity = 0.7, Size = 28, Threshold = 1.5 })
efeitoLuz("SunRaysEffect", { Intensity = 0.14, Spread = 0.75 })
efeitoLuz("ColorCorrectionEffect", { Saturation = 0.18, Contrast = 0.08, TintColor = rgb(255, 243, 228) })
efeitoLuz("Sky", { SunAngularSize = 14, MoonAngularSize = 8, StarCount = 1500 })

------------------------------------------------------------------------------------
-- Chão em blocos (cada fatia com um tom diferente, como pixels)
------------------------------------------------------------------------------------
local Z_FUNDO = -14 -- centro do chão em profundidade; a pista dos jogadores fica em Z=0
local function chao(x0, x1, topo, terra, matTopo)
	local x = x0
	while x < x1 do
		local w = math.min(4, x1 - x)
		bloco(Vector3.new(w, 1, 40), Vector3.new(x + w / 2, -0.5, Z_FUNDO), tom(topo, 0.07), matTopo or Enum.Material.Grass)
		bloco(Vector3.new(w, 9, 40), Vector3.new(x + w / 2, -5.5, Z_FUNDO), tom(terra, 0.08), Enum.Material.Ground)
		-- pedrinhas no corte de terra que a câmera vê de frente
		if rng:NextNumber() < 0.5 then
			enfeite(Vector3.new(0.8, 0.6, 0.4), Vector3.new(x + rng:NextNumber(0.5, 3.5), rng:NextNumber(-8, -2), 6.1), tom(rgb(120, 96, 80), 0.1), Enum.Material.Slate)
		end
		x = x + w
	end
end

local X_INICIO, X_FIM = -40, 900
chao(X_INICIO, 250, rgb(96, 158, 62), rgb(118, 82, 52)) -- roça
chao(330, 460, rgb(150, 128, 90), rgb(110, 80, 56), Enum.Material.Ground) -- estrada de terra
chao(460, 720, rgb(168, 160, 150), rgb(96, 88, 84), Enum.Material.Cobblestone) -- praça
chao(720, X_FIM, rgb(176, 170, 160), rgb(92, 86, 82), Enum.Material.Concrete) -- pátio da escola

-- Paredes invisíveis: prendem todos numa pista lateral, como no jogo original em 2D
local LARG = X_FIM - X_INICIO
for _, z in ipairs({ -2.6, 2.6 }) do
	bloco(Vector3.new(LARG, 200, 1), Vector3.new((X_INICIO + X_FIM) / 2, 90, z), BRANCO, nil, nil, { Transparency = 1, Name = "ParedePista" })
end
bloco(Vector3.new(2, 200, 12), Vector3.new(X_INICIO - 1, 90, 0), BRANCO, nil, nil, { Transparency = 1 })
bloco(Vector3.new(2, 200, 12), Vector3.new(X_FIM + 1, 90, 0), BRANCO, nil, nil, { Transparency = 1 })

------------------------------------------------------------------------------------
-- Montanhas e céu ao fundo (a névoa da Atmosphere cuida da distância)
------------------------------------------------------------------------------------
for i = 0, 26 do
	local x = X_INICIO - 120 + i * 45 + rng:NextNumber(-10, 10)
	local h = rng:NextNumber(50, 110)
	local w = rng:NextNumber(60, 110)
	local m = enfeite(Vector3.new(w, h, w), CFrame.new(x, h / 2 - 12, -260 - rng:NextNumber(0, 60)) * CFrame.Angles(0, math.rad(45), 0), tom(rgb(70, 120, 90), 0.1), Enum.Material.Grass)
	m.CastShadow = false
end

------------------------------------------------------------------------------------
-- Peças de cenário
------------------------------------------------------------------------------------
local function arvore(x, z, escala)
	escala = escala or 1
	local h = 7 * escala
	enfeite(Vector3.new(1.4 * escala, h, 1.4 * escala), Vector3.new(x, h / 2, z), tom(rgb(102, 70, 44), 0.06), Enum.Material.Wood)
	local verdes = { rgb(62, 128, 52), rgb(78, 146, 58), rgb(52, 110, 46) }
	for i = 1, 5 do
		local s = (rng:NextNumber(4, 6.5)) * escala
		local copa = enfeite(Vector3.new(s, s * 0.8, s), Vector3.new(x + rng:NextNumber(-2.5, 2.5) * escala, h + rng:NextNumber(-0.5, 3.5) * escala, z + rng:NextNumber(-2, 2)), tom(verdes[(i % 3) + 1], 0.06), Enum.Material.Grass)
		CollectionService:AddTag(copa, "Copa")
	end
end

local function cerca(x0, x1, z)
	local x = x0
	while x <= x1 do
		enfeite(Vector3.new(0.6, 3, 0.6), Vector3.new(x, 1.5, z), tom(rgb(140, 100, 64), 0.08), Enum.Material.Wood)
		x = x + 4
	end
	for _, y in ipairs({ 1.1, 2.3 }) do
		enfeite(Vector3.new(x1 - x0, 0.35, 0.3), Vector3.new((x0 + x1) / 2, y, z + 0.1), rgb(160, 118, 76), Enum.Material.Wood)
	end
end

local function casinha(x, z)
	local w, h, d = 16, 9, 10
	enfeite(Vector3.new(w, h, d), Vector3.new(x, h / 2, z), rgb(236, 226, 204), Enum.Material.Plaster)
	enfeite(Vector3.new(w + 0.4, 1.2, d + 0.4), Vector3.new(x, 0.6, z), rgb(170, 110, 80), Enum.Material.Brick) -- barrado
	-- telhado de duas águas em cunhas
	local telha = rgb(176, 84, 52)
	enfeite(Vector3.new(d + 2, 4, (w + 2) / 2), CFrame.new(x - (w + 2) / 4, h + 2, z) * CFrame.Angles(0, math.rad(90), 0), telha, Enum.Material.Slate).Shape = Enum.PartType.Wedge
	enfeite(Vector3.new(d + 2, 4, (w + 2) / 2), CFrame.new(x + (w + 2) / 4, h + 2, z) * CFrame.Angles(0, math.rad(-90), 0), telha, Enum.Material.Slate).Shape = Enum.PartType.Wedge
	enfeite(Vector3.new(2.6, 5, 0.3), Vector3.new(x - 3, 2.5, z + d / 2 + 0.1), rgb(120, 76, 46), Enum.Material.Wood) -- porta
	for _, wx in ipairs({ 2, 5.5 }) do
		enfeite(Vector3.new(2.6, 2.4, 0.3), Vector3.new(x + wx, 5, z + d / 2 + 0.1), rgb(64, 110, 150), Enum.Material.Glass)
		enfeite(Vector3.new(3.2, 0.3, 0.4), Vector3.new(x + wx, 3.7, z + d / 2 + 0.2), rgb(120, 76, 46), Enum.Material.Wood)
	end
	local chamine = enfeite(Vector3.new(1.6, 4, 1.6), Vector3.new(x + 4.5, h + 4, z - 1), rgb(150, 90, 70), Enum.Material.Brick)
	local fumaca = Instance.new("ParticleEmitter")
	fumaca.Texture = "rbxasset://textures/particles/smoke_main.dds"
	fumaca.Rate = 4
	fumaca.Lifetime = NumberRange.new(4, 6)
	fumaca.Speed = NumberRange.new(2, 3)
	fumaca.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 5) })
	fumaca.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) })
	fumaca.Color = ColorSequence.new(rgb(230, 225, 220))
	fumaca.EmissionDirection = Enum.NormalId.Top
	fumaca.Parent = chamine
end

local function milharal(x0, x1)
	for z = -40, -64, -4 do
		local x = x0
		while x < x1 do
			local h = rng:NextNumber(4, 6)
			enfeite(Vector3.new(0.5, h, 0.5), Vector3.new(x, h / 2, z), tom(rgb(110, 150, 60), 0.08), Enum.Material.Grass)
			local folha = enfeite(Vector3.new(1.6, 0.3, 1.6), CFrame.new(x, h * 0.7, z) * CFrame.Angles(0, rng:NextNumber(0, 3), 0.4), tom(rgb(130, 170, 70), 0.08), Enum.Material.Grass)
			CollectionService:AddTag(folha, "Copa")
			if rng:NextNumber() < 0.4 then
				enfeite(Vector3.new(0.6, 1.2, 0.6), Vector3.new(x + 0.4, h * 0.6, z), rgb(232, 196, 80), Enum.Material.SmoothPlastic)
			end
			x = x + rng:NextNumber(2.2, 3.4)
		end
	end
end

local function feno(x, z)
	enfeite(Vector3.new(3, 2.4, 2.4), Vector3.new(x, 1.2, z), tom(rgb(214, 180, 96), 0.05), Enum.Material.Fabric)
end

local function vaca(x, z)
	local m = Instance.new("Model")
	m.Name = "Vaca"
	enfeite(Vector3.new(4.2, 2.4, 2), Vector3.new(x, 2.6, z), rgb(240, 236, 228), nil, m)
	enfeite(Vector3.new(1.6, 1.2, 2.04), Vector3.new(x - 0.6, 2.9, z), rgb(40, 36, 36), nil, m)
	enfeite(Vector3.new(1.6, 1.6, 1.4), Vector3.new(x + 2.6, 3.2, z), rgb(240, 236, 228), nil, m)
	enfeite(Vector3.new(0.8, 0.7, 1.42), Vector3.new(x + 3.2, 2.8, z), rgb(232, 160, 160), nil, m)
	for _, lx in ipairs({ -1.5, 1.4 }) do
		enfeite(Vector3.new(0.6, 1.4, 0.6), Vector3.new(x + lx, 0.7, z + 0.6), rgb(220, 214, 206), nil, m)
		enfeite(Vector3.new(0.6, 1.4, 0.6), Vector3.new(x + lx, 0.7, z - 0.6), rgb(220, 214, 206), nil, m)
	end
	m.Parent = mapa
end

local function poste(x, z, luz)
	enfeite(Vector3.new(0.6, 12, 0.6), Vector3.new(x, 6, z), rgb(70, 74, 80), Enum.Material.Metal)
	enfeite(Vector3.new(3, 0.4, 0.6), Vector3.new(x + 1.2, 12, z), rgb(70, 74, 80), Enum.Material.Metal)
	local lamp = enfeite(Vector3.new(1.2, 0.6, 1), Vector3.new(x + 2.4, 11.6, z), rgb(255, 230, 170), Enum.Material.Neon)
	if luz then
		local l = Instance.new("PointLight")
		l.Color = rgb(255, 210, 150)
		l.Range = 18
		l.Brightness = 1.4
		l.Parent = lamp
	end
end

local function banco(x, z)
	enfeite(Vector3.new(5, 0.4, 1.6), Vector3.new(x, 1.4, z), rgb(120, 84, 56), Enum.Material.Wood)
	enfeite(Vector3.new(5, 1.4, 0.3), Vector3.new(x, 2.5, z - 0.7), rgb(120, 84, 56), Enum.Material.Wood)
	for _, lx in ipairs({ -2, 2 }) do
		enfeite(Vector3.new(0.4, 1.2, 1.4), Vector3.new(x + lx, 0.6, z), rgb(50, 54, 60), Enum.Material.Metal)
	end
end

local function predio(x, z, w, h, cor)
	enfeite(Vector3.new(w, h, 10), Vector3.new(x, h / 2, z), tom(cor, 0.05), Enum.Material.Concrete)
	enfeite(Vector3.new(w + 0.6, 0.8, 10.6), Vector3.new(x, h + 0.4, z), tom(cor, 0.15), Enum.Material.Concrete)
	local frente = z + 5.05
	local fy = 3
	while fy < h - 2 do
		local fx = x - w / 2 + 2
		while fx < x + w / 2 - 1.5 do
			local acesa = rng:NextNumber() < 0.3
			enfeite(Vector3.new(1.8, 2.2, 0.2), Vector3.new(fx + 0.5, fy, frente), acesa and rgb(255, 214, 140) or rgb(60, 78, 100), acesa and Enum.Material.Neon or Enum.Material.Glass)
			fx = fx + 3.2
		end
		fy = fy + 4
	end
	-- caixa d'água e antena no topo
	enfeite(Vector3.new(2.4, 2, 2.4), Vector3.new(x + w / 4, h + 1.8, z), rgb(70, 110, 160), Enum.Material.Plastic)
	enfeite(Vector3.new(0.2, 4, 0.2), Vector3.new(x - w / 4, h + 2.8, z), rgb(80, 80, 80), Enum.Material.Metal)
end

local function chafariz(x, z)
	local base = enfeite(Vector3.new(10, 1.6, 6), Vector3.new(x, 0.8, z), rgb(190, 184, 176), Enum.Material.Marble)
	enfeite(Vector3.new(9, 0.4, 5), Vector3.new(x, 1.5, z), rgb(80, 150, 200), Enum.Material.Glass).Transparency = 0.2
	enfeite(Vector3.new(1.4, 4, 1.4), Vector3.new(x, 3, z), rgb(200, 194, 186), Enum.Material.Marble)
	local bico = enfeite(Vector3.new(3, 0.6, 3), Vector3.new(x, 5.2, z), rgb(200, 194, 186), Enum.Material.Marble)
	local agua = Instance.new("ParticleEmitter")
	agua.Rate = 60
	agua.Lifetime = NumberRange.new(0.8, 1.1)
	agua.Speed = NumberRange.new(9, 11)
	agua.SpreadAngle = Vector2.new(18, 18)
	agua.Acceleration = Vector3.new(0, -30, 0)
	agua.Size = NumberSequence.new(0.35)
	agua.Color = ColorSequence.new(rgb(200, 235, 255))
	agua.LightEmission = 0.4
	agua.Transparency = NumberSequence.new(0.2)
	agua.EmissionDirection = Enum.NormalId.Top
	agua.Parent = bico
	return base
end

-- Aves no chão: o cliente faz cada uma fugir voando quando você chega perto
local function ave(x, z, tipo)
	local m = Instance.new("Model")
	m.Name = tipo
	local corpo, cabeca, bico, asa
	if tipo == "Galinha" then
		corpo, cabeca, bico, asa = rgb(245, 242, 232), rgb(245, 242, 232), rgb(240, 170, 50), rgb(226, 220, 206)
	else -- Pombo
		corpo, cabeca, bico, asa = rgb(140, 146, 160), rgb(110, 120, 140), rgb(60, 60, 64), rgb(120, 126, 140)
	end
	local s = tipo == "Galinha" and 1 or 0.7
	local c = enfeite(Vector3.new(1.4 * s, 1 * s, 0.9 * s), Vector3.new(x, 0.9 * s, z), corpo, nil, m)
	c.Name = "Corpo"
	enfeite(Vector3.new(0.7 * s, 0.7 * s, 0.6 * s), Vector3.new(x + 0.8 * s, 1.6 * s, z), cabeca, nil, m).Name = "Cabeca"
	enfeite(Vector3.new(0.35 * s, 0.2 * s, 0.3 * s), Vector3.new(x + 1.3 * s, 1.55 * s, z), bico, nil, m)
	if tipo == "Galinha" then
		enfeite(Vector3.new(0.4, 0.35, 0.2), Vector3.new(x + 0.8, 2.05, z), rgb(220, 50, 50), nil, m)
	end
	local a1 = enfeite(Vector3.new(0.9 * s, 0.15, 0.4 * s), Vector3.new(x - 0.1, 1.1 * s, z + 0.5 * s), asa, nil, m)
	a1.Name = "Asa"
	local a2 = enfeite(Vector3.new(0.9 * s, 0.15, 0.4 * s), Vector3.new(x - 0.1, 1.1 * s, z - 0.5 * s), asa, nil, m)
	a2.Name = "Asa"
	enfeite(Vector3.new(0.15, 0.5 * s, 0.15), Vector3.new(x, 0.25 * s, z), rgb(230, 160, 60), nil, m)
	m.PrimaryPart = c
	m.Parent = mapa
	CollectionService:AddTag(m, "Ave")
end

------------------------------------------------------------------------------------
-- 1) A ROÇA
------------------------------------------------------------------------------------
placa("DA ROÇA", Vector3.new(6, 6, -4), 9, 3, rgb(150, 104, 64), rgb(255, 236, 170))
enfeite(Vector3.new(0.6, 4.5, 0.6), Vector3.new(3, 2.25, -4.4), rgb(110, 76, 46), Enum.Material.Wood)
enfeite(Vector3.new(0.6, 4.5, 0.6), Vector3.new(9, 2.25, -4.4), rgb(110, 76, 46), Enum.Material.Wood)
casinha(40, -18)
cerca(-36, 246, -5)
milharal(70, 240)
for _, x in ipairs({ -30, -6, 22, 64, 96, 130, 168, 200, 232 }) do
	arvore(x + rng:NextNumber(-4, 4), rng:NextNumber(-34, -12), rng:NextNumber(0.9, 1.3))
end
for _, x in ipairs({ 84, 150, 214 }) do
	feno(x, -8)
end
vaca(112, -22)
vaca(188, -27)
for i = 1, 7 do
	ave(14 + i * 22 + rng:NextNumber(-4, 4), -3.6, "Galinha")
end
-- mato rasteiro na frente da pista
for x = X_INICIO, 248, 3 do
	if rng:NextNumber() < 0.6 then
		local tufo = enfeite(Vector3.new(0.4, rng:NextNumber(0.6, 1.4), 0.4), Vector3.new(x + rng:NextNumber(0, 2), 0.5, rng:NextNumber(3.2, 5.5)), tom(rgb(90, 160, 60), 0.12), Enum.Material.Grass)
		CollectionService:AddTag(tufo, "Copa")
	end
end

------------------------------------------------------------------------------------
-- 2) O RIO: plataformas e uma balsa que vai e volta (o cliente move a balsa)
------------------------------------------------------------------------------------
local agua = enfeite(Vector3.new(84, 8, 40), Vector3.new(290, -6.5, Z_FUNDO), rgb(60, 130, 170), Enum.Material.Glass)
agua.Transparency = 0.25
bloco(Vector3.new(84, 8, 40), Vector3.new(290, -14, Z_FUNDO), rgb(70, 60, 50), Enum.Material.Mud)
local afogar = bloco(Vector3.new(84, 2, 12), Vector3.new(290, -5, 0), BRANCO, nil, nil, { Transparency = 1, CanCollide = false })
afogar.Touched:Connect(function(hit)
	local hum = hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid")
	if hum and hum.Health > 0 then
		hum.Health = 0
	end
end)
local function tabua(x0, x1, y)
	bloco(Vector3.new(x1 - x0, 1, 4), Vector3.new((x0 + x1) / 2, y - 0.5, 0), tom(rgb(150, 108, 66), 0.05), Enum.Material.WoodPlanks)
	enfeite(Vector3.new(0.8, 10, 0.8), Vector3.new(x0 + 0.6, y - 6, -1.2), rgb(100, 70, 44), Enum.Material.Wood)
	enfeite(Vector3.new(0.8, 10, 0.8), Vector3.new(x1 - 0.6, y - 6, -1.2), rgb(100, 70, 44), Enum.Material.Wood)
end
tabua(254, 262, 1)
tabua(306, 314, 2.5)
tabua(319, 327, 1)
local balsa = bloco(Vector3.new(10, 1, 4), Vector3.new(284, 1.5, 0), rgb(130, 92, 58), Enum.Material.WoodPlanks, nil, { Name = "Balsa" })
balsa:SetAttribute("CentroX", 284)
balsa:SetAttribute("Amp", 14)
balsa:SetAttribute("Vel", 0.9)
balsa:SetAttribute("Y", 1.5)
CollectionService:AddTag(balsa, "Plataforma")
for i = 1, 5 do
	local planta = enfeite(Vector3.new(1.4, 0.2, 1.4), Vector3.new(256 + i * 14, -2.4, -6 - i * 3), rgb(70, 140, 70), Enum.Material.Grass)
	CollectionService:AddTag(planta, "Copa")
end

------------------------------------------------------------------------------------
-- 3) ESTRADA
------------------------------------------------------------------------------------
for x = 340, 450, 22 do
	poste(x, -6, false)
end
enfeite(Vector3.new(120, 0.15, 0.15), Vector3.new(395, 11.4, -5.6), rgb(30, 30, 30))
placa("PRAÇA  >", Vector3.new(445, 5, -4), 8, 2.4, rgb(40, 110, 70), BRANCO)
enfeite(Vector3.new(0.5, 4, 0.5), Vector3.new(445, 2, -4.4), rgb(80, 80, 80), Enum.Material.Metal)
-- ponto de ônibus
enfeite(Vector3.new(10, 0.4, 4), Vector3.new(400, 7, -9), rgb(60, 120, 170), Enum.Material.Metal)
enfeite(Vector3.new(0.4, 7, 0.4), Vector3.new(395.5, 3.5, -8), rgb(80, 80, 80), Enum.Material.Metal)
enfeite(Vector3.new(0.4, 7, 0.4), Vector3.new(404.5, 3.5, -8), rgb(80, 80, 80), Enum.Material.Metal)
banco(400, -9)
for _, x in ipairs({ 352, 384, 420 }) do
	arvore(x, rng:NextNumber(-30, -16), 1.1)
end

------------------------------------------------------------------------------------
-- 4) PRAÇA (Itabuna ao fundo)
------------------------------------------------------------------------------------
local cores = { rgb(214, 196, 160), rgb(186, 120, 100), rgb(140, 170, 190), rgb(230, 210, 120), rgb(170, 190, 150) }
local px = 470
while px < 715 do
	local w = rng:NextNumber(14, 22)
	predio(px + w / 2, -30 - rng:NextNumber(0, 6), w, rng:NextNumber(16, 34), cores[rng:NextInteger(1, #cores)])
	px = px + w + 1
end
placa("PRAÇA", Vector3.new(482, 7, -10), 8, 2.4, rgb(150, 60, 60), rgb(255, 240, 200))
chafariz(590, -10)
for _, x in ipairs({ 500, 540, 640, 690 }) do
	banco(x, -7)
end
for x = 480, 710, 30 do
	poste(x, -5, true)
end
for _, x in ipairs({ 520, 620, 670 }) do
	arvore(x, -16, 1.2)
end
for i = 1, 9 do
	ave(475 + i * 26 + rng:NextNumber(-5, 5), -3.6, "Pombo")
end
-- caixotes para pular por cima
bloco(Vector3.new(4, 4, 4), Vector3.new(560, 2, 0), rgb(170, 120, 70), Enum.Material.WoodPlanks)
bloco(Vector3.new(4, 4, 4), Vector3.new(564, 2, 0), rgb(160, 112, 66), Enum.Material.WoodPlanks)
bloco(Vector3.new(4, 4, 4), Vector3.new(562, 6, 0), rgb(176, 126, 74), Enum.Material.WoodPlanks)

------------------------------------------------------------------------------------
-- 5) ESCOLA: arena do Igor, com torcida na arquibancada
------------------------------------------------------------------------------------
enfeite(Vector3.new(190, 14, 2), Vector3.new(810, 7, -12), rgb(220, 206, 170), Enum.Material.Plaster)
enfeite(Vector3.new(190, 2, 2.4), Vector3.new(810, 1, -11.8), rgb(80, 120, 170), Enum.Material.Plaster)
placa("ESCOLA", Vector3.new(810, 16, -11), 22, 4, rgb(40, 70, 120), rgb(255, 230, 120))
for _, x in ipairs({ 730, 892 }) do
	enfeite(Vector3.new(2, 18, 2), Vector3.new(x, 9, -10), rgb(180, 170, 150), Enum.Material.Concrete)
end
-- arquibancada
for degrau = 0, 3 do
	enfeite(Vector3.new(170, 1.4, 3), Vector3.new(810, 15 + degrau * 2.4, -16 - degrau * 3), rgb(150, 150, 160), Enum.Material.Concrete)
end
local camisas = { rgb(220, 60, 60), rgb(60, 120, 220), rgb(240, 200, 60), rgb(60, 180, 100), rgb(240, 240, 240), rgb(160, 80, 200) }
local peles = { rgb(240, 200, 170), rgb(200, 150, 110), rgb(140, 96, 70), rgb(96, 64, 46) }
for degrau = 0, 3 do
	for x = 728, 892, 3.2 do
		if rng:NextNumber() < 0.8 then
			local y = 15.7 + degrau * 2.4
			local z = -16 - degrau * 3
			local corpo = enfeite(Vector3.new(1.6, 2, 1), Vector3.new(x, y + 1, z), camisas[rng:NextInteger(1, #camisas)], Enum.Material.Fabric)
			local cabeca = enfeite(Vector3.new(1.1, 1.1, 1.1), Vector3.new(x, y + 2.6, z), peles[rng:NextInteger(1, #peles)])
			CollectionService:AddTag(corpo, "Torcida")
			CollectionService:AddTag(cabeca, "Torcida")
		end
	end
end
-- holofotes
for _, x in ipairs({ 736, 884 }) do
	local h = enfeite(Vector3.new(3, 1.6, 1.6), Vector3.new(x, 26, -12), rgb(255, 250, 220), Enum.Material.Neon)
	local s = Instance.new("SpotLight")
	s.Face = Enum.NormalId.Bottom
	s.Angle = 70
	s.Range = 40
	s.Brightness = 3
	s.Color = rgb(255, 210, 160)
	s.Parent = h
	enfeite(Vector3.new(0.6, 26, 0.6), Vector3.new(x, 13, -12.6), rgb(70, 70, 80), Enum.Material.Metal)
end

------------------------------------------------------------------------------------
-- Pontos de controle (bandeiras) e nascimento
------------------------------------------------------------------------------------
local spawn = Instance.new("SpawnLocation")
spawn.Anchored = true
spawn.Size = Vector3.new(4, 0.4, 4)
spawn.Position = Vector3.new(0, 0.2, 0)
spawn.Transparency = 1
spawn.CanCollide = false
spawn.Neutral = true
spawn.Duration = 0
spawn.Parent = mapa

local PONTOS = { 0, 336, 468, 726 }
for _, x in ipairs(PONTOS) do
	enfeite(Vector3.new(0.4, 7, 0.4), Vector3.new(x - 1.5, 3.5, -3.6), rgb(200, 200, 200), Enum.Material.Metal)
	local bandeira = enfeite(Vector3.new(2.4, 1.6, 0.2), Vector3.new(x - 0.2, 6.2, -3.6), rgb(200, 60, 60), Enum.Material.Fabric)
	local area = bloco(Vector3.new(4, 8, 5), Vector3.new(x, 4, 0), BRANCO, nil, nil, { Transparency = 1, CanCollide = false })
	area.Touched:Connect(function(hit)
		local pl = hit.Parent and Players:GetPlayerFromCharacter(hit.Parent)
		if pl and (pl:GetAttribute("Checkpoint") or -1) < x then
			pl:SetAttribute("Checkpoint", x)
			bandeira.Color = rgb(80, 200, 90)
			if x > 0 then
				Efeito:FireClient(pl, "aviso", "Ponto salvo!")
			end
		end
	end)
end

Players.PlayerAdded:Connect(function(pl)
	pl.CharacterAdded:Connect(function(ch)
		local hum = ch:WaitForChild("Humanoid")
		ch:WaitForChild("HumanoidRootPart")
		hum.WalkSpeed = 20
		hum.UseJumpPower = true
		hum.JumpPower = 55
		local cp = pl:GetAttribute("Checkpoint") or 0
		task.wait()
		ch:PivotTo(CFrame.new(cp, 4, 0) * CFrame.Angles(0, -math.pi / 2, 0))
	end)
end)

mapa:SetAttribute("Pronto", true)
