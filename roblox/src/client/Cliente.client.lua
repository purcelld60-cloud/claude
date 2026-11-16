-- Da Roça Adventure (protótipo para Roblox)
-- Lado do jogador: câmera lateral como no jogo 2D, pista travada, pulo duplo, soco com
-- rastro, efeitos (faíscas, poeira, onda de blocos, tremor), aves que fogem, torcida,
-- vento nas folhas, balsa do rio, barra de vida do chefe e avisos na tela.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local jogador = Players.LocalPlayer
local camera = workspace.CurrentCamera
local remotes = ReplicatedStorage:WaitForChild("DaRocaRemotes")
local Ataque = remotes:WaitForChild("Ataque")
local Efeito = remotes:WaitForChild("Efeito")

local function rgb(r, g, b)
	return Color3.fromRGB(r, g, b)
end
local efeitos = Instance.new("Folder")
efeitos.Name = "DaRocaEfeitos"
efeitos.Parent = workspace

local function cubo(tamanho, pos, cor, neon)
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanTouch = false
	p.CanQuery = false
	p.CastShadow = false
	p.Size = tamanho
	p.Position = pos
	p.Color = cor
	p.Material = neon and Enum.Material.Neon or Enum.Material.SmoothPlastic
	p.Parent = efeitos
	return p
end
local function tween(obj, tempo, props, estilo)
	local tw = TweenService:Create(obj, TweenInfo.new(tempo, estilo or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

------------------------------------------------------------------------------------
-- Tela: título, dicas, avisos, faixa de chefe e barra de vida
------------------------------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "DaRocaHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = jogador:WaitForChild("PlayerGui")

local function texto(pai, t, tam, pos, cor, fonte)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = tam
	l.Position = pos
	l.AnchorPoint = Vector2.new(0.5, 0.5)
	l.Text = t
	l.TextScaled = true
	l.Font = fonte or Enum.Font.Arcade
	l.TextColor3 = cor or Color3.new(1, 1, 1)
	l.TextStrokeTransparency = 0
	l.TextStrokeColor3 = rgb(30, 20, 20)
	l.Parent = pai
	return l
end

local titulo = texto(gui, "DA ROÇA ADVENTURE", UDim2.fromScale(0.8, 0.12), UDim2.fromScale(0.5, 0.3), rgb(255, 226, 120))
local sub = texto(gui, "protótipo no Roblox", UDim2.fromScale(0.5, 0.05), UDim2.fromScale(0.5, 0.39), rgb(255, 255, 255))
task.delay(4, function()
	tween(titulo, 1, { TextTransparency = 1, TextStrokeTransparency = 1 })
	tween(sub, 1, { TextTransparency = 1, TextStrokeTransparency = 1 })
end)
local toque = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local dica = texto(gui, toque and "Analógico: andar   Pular 2x no ar   SOCO: bater" or "A/D andar   Espaço pular (2x no ar)   F ou clique: soco", UDim2.new(0.6, 0, 0, 22), UDim2.new(0.5, 0, 1, -18), rgb(240, 240, 240), Enum.Font.GothamBold)
task.delay(14, function()
	tween(dica, 1.5, { TextTransparency = 1, TextStrokeTransparency = 1 })
end)

local aviso = texto(gui, "", UDim2.fromScale(0.4, 0.05), UDim2.fromScale(0.5, 0.2), rgb(140, 255, 150))
aviso.TextTransparency = 1
aviso.TextStrokeTransparency = 1
local function mostrarAviso(t)
	aviso.Text = t
	aviso.TextTransparency = 0
	aviso.TextStrokeTransparency = 0
	task.delay(1.6, function()
		if aviso.Text == t then
			tween(aviso, 0.6, { TextTransparency = 1, TextStrokeTransparency = 1 })
		end
	end)
end

local faixa = Instance.new("Frame")
faixa.Size = UDim2.new(1.4, 0, 0.16, 0)
faixa.AnchorPoint = Vector2.new(0.5, 0.5)
faixa.Position = UDim2.fromScale(-0.8, 0.42)
faixa.Rotation = -4
faixa.BackgroundColor3 = rgb(20, 16, 30)
faixa.BorderSizePixel = 0
faixa.Parent = gui
local faixaNome = texto(faixa, "", UDim2.fromScale(0.5, 0.62), UDim2.fromScale(0.5, 0.4), rgb(255, 214, 90))
local faixaSub = texto(faixa, "", UDim2.fromScale(0.4, 0.26), UDim2.fromScale(0.5, 0.82), rgb(230, 230, 240), Enum.Font.GothamBold)
local function mostrarFaixa(nome, s)
	faixaNome.Text = nome
	faixaSub.Text = s
	faixa.Position = UDim2.fromScale(-0.8, 0.42)
	tween(faixa, 0.35, { Position = UDim2.fromScale(0.5, 0.42) }, Enum.EasingStyle.Back)
	task.delay(1.9, function()
		tween(faixa, 0.35, { Position = UDim2.fromScale(1.8, 0.42) })
	end)
end

local barra = Instance.new("Frame")
barra.Size = UDim2.new(0.5, 0, 0, 18)
barra.AnchorPoint = Vector2.new(0.5, 0)
barra.Position = UDim2.new(0.5, 0, 0, 52)
barra.BackgroundColor3 = rgb(20, 16, 24)
barra.BorderSizePixel = 0
barra.Visible = false
barra.Parent = gui
local barraVida = Instance.new("Frame")
barraVida.Size = UDim2.fromScale(1, 1)
barraVida.BackgroundColor3 = rgb(230, 70, 60)
barraVida.BorderSizePixel = 0
barraVida.Parent = barra
local barraNome = texto(barra, "IGOR", UDim2.new(0.3, 0, 0, 18), UDim2.new(0.15, 0, 0, -12), rgb(255, 230, 120))

------------------------------------------------------------------------------------
-- Personagem: pista travada, virar de lado, pulo duplo, poeira
------------------------------------------------------------------------------------
local hrp, hum
local direcao = 1
local puloDuplo = false
local ultimoPedido = 0
local noAr = false

local function poeira(pos, n, forca)
	for i = 1, n do
		local c = cubo(Vector3.new(0.5, 0.5, 0.5), pos + Vector3.new((math.random() - 0.5) * 1.5, 0.2, 0), rgb(214, 196, 160))
		c.Transparency = 0.2
		local lado = (i % 2 == 0) and 1 or -1
		tween(c, 0.5 + math.random() * 0.3, { Position = c.Position + Vector3.new(lado * (1 + math.random() * forca), 0.6 + math.random(), 0), Transparency = 1, Size = Vector3.new(1.1, 1.1, 1.1) })
		Debris:AddItem(c, 0.9)
	end
end

local function aoNascer(ch)
	hum = ch:WaitForChild("Humanoid")
	hrp = ch:WaitForChild("HumanoidRootPart")
	hum.AutoRotate = false
	puloDuplo = false
	hum.StateChanged:Connect(function(_, novo)
		if novo == Enum.HumanoidStateType.Landed then
			if noAr then
				poeira(hrp.Position - Vector3.new(0, 2.8, 0), 6, 2)
			end
			noAr = false
			puloDuplo = false
		elseif novo == Enum.HumanoidStateType.Jumping or novo == Enum.HumanoidStateType.Freefall then
			noAr = true
		end
	end)
end
if jogador.Character then
	task.spawn(aoNascer, jogador.Character)
end
jogador.CharacterAdded:Connect(aoNascer)

UserInputService.JumpRequest:Connect(function()
	local agora = os.clock()
	local novoToque = agora - ultimoPedido > 0.2 -- segurar o botão não conta como 2º pulo
	ultimoPedido = agora
	if not hum or not hrp or hum.Health <= 0 then
		return
	end
	if noAr and novoToque and not puloDuplo and hum.FloorMaterial == Enum.Material.Air then
		puloDuplo = true
		local v = hrp.AssemblyLinearVelocity
		hrp.AssemblyLinearVelocity = Vector3.new(v.X, 50, 0)
		-- anel de ar em pixels sob os pés
		for i = 0, 7 do
			local a = i / 8 * math.pi * 2
			local c = cubo(Vector3.new(0.4, 0.4, 0.4), hrp.Position - Vector3.new(0, 2.6, 0), rgb(255, 255, 255), true)
			tween(c, 0.35, { Position = c.Position + Vector3.new(math.cos(a) * 2.2, math.sin(a) * 0.5, 0), Transparency = 1 })
			Debris:AddItem(c, 0.4)
		end
	end
end)

------------------------------------------------------------------------------------
-- Soco: braço vai à frente, rastro branco em arco e aviso ao servidor
------------------------------------------------------------------------------------
local ombrosOriginais = {}
local combo = 0
local ultimoSoco = 0

local function rastro(pos, dir, cor)
	for i = 0, 5 do
		local a = math.rad(-60 + i * 24)
		local p = pos + Vector3.new(dir * (1.6 + math.cos(a) * 2.4), math.sin(a) * 2.4 + 0.6, 0.4)
		local c = cubo(Vector3.new(0.5, 0.5, 0.3), p, cor or rgb(255, 250, 230), true)
		c.Transparency = 0.1 + i * 0.05
		tween(c, 0.18, { Transparency = 1, Size = Vector3.new(0.2, 0.2, 0.2) })
		Debris:AddItem(c, 0.25)
	end
end

local function animarSoco(ch)
	combo = combo + 1
	local direito = combo % 2 == 1
	local motor = ch:FindFirstChild(direito and "RightShoulder" or "LeftShoulder", true)
	local r6 = false
	if not motor then
		local torso = ch:FindFirstChild("Torso")
		motor = torso and torso:FindFirstChild(direito and "Right Shoulder" or "Left Shoulder")
		r6 = true
	end
	if not motor or not motor:IsA("Motor6D") then
		return
	end
	if not ombrosOriginais[motor] then
		ombrosOriginais[motor] = motor.C0
	end
	local orig = ombrosOriginais[motor]
	local giro
	if r6 then
		giro = CFrame.Angles(0, 0, math.rad(direito and 90 or -90))
	else
		giro = CFrame.Angles(math.rad(95), 0, 0)
	end
	local ida = TweenService:Create(motor, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { C0 = orig * giro })
	ida:Play()
	ida.Completed:Connect(function()
		TweenService:Create(motor, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { C0 = orig }):Play()
	end)
end

local function socar(_, estado)
	if estado ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	local agora = os.clock()
	if not hrp or not hum or hum.Health <= 0 or agora - ultimoSoco < 0.27 then
		return Enum.ContextActionResult.Sink
	end
	ultimoSoco = agora
	animarSoco(hrp.Parent)
	rastro(hrp.Position, direcao)
	-- passinho à frente no soco, como no jogo original
	local v = hrp.AssemblyLinearVelocity
	hrp.AssemblyLinearVelocity = Vector3.new(v.X + direcao * 14, v.Y, 0)
	Ataque:FireServer(direcao)
	return Enum.ContextActionResult.Sink
end
ContextActionService:BindAction("DaRocaSoco", socar, true, Enum.KeyCode.F, Enum.KeyCode.J, Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonX)
ContextActionService:SetTitle("DaRocaSoco", "SOCO")
ContextActionService:SetPosition("DaRocaSoco", UDim2.new(1, -190, 1, -150))

------------------------------------------------------------------------------------
-- Efeitos enviados pelo servidor
------------------------------------------------------------------------------------
local tremor = 0
local function faiscas(pos, dir, cor)
	for i = 1, 10 do
		local c = cubo(Vector3.new(0.45, 0.45, 0.45), pos, i % 3 == 0 and cor or rgb(255, 240, 180), true)
		local alvo = pos + Vector3.new(dir * math.random() * 4 + (math.random() - 0.5) * 2, (math.random() - 0.3) * 3.5, 0.6)
		tween(c, 0.25 + math.random() * 0.15, { Position = alvo, Transparency = 1, Size = Vector3.new(0.15, 0.15, 0.15) })
		Debris:AddItem(c, 0.5)
	end
	local flash = cubo(Vector3.new(2.2, 2.2, 0.2), pos + Vector3.new(0, 0, 0.8), rgb(255, 255, 255), true)
	flash.CFrame = flash.CFrame * CFrame.Angles(0, 0, math.rad(45))
	tween(flash, 0.12, { Transparency = 1, Size = Vector3.new(3.4, 3.4, 0.2) })
	Debris:AddItem(flash, 0.2)
end

-- Onda de choque do Igor: blocos do chão saltam em sequência para os dois lados
local function ondaDeChoque(pos, forte)
	tremor = math.max(tremor, forte and 1.6 or 1.2)
	poeira(pos, 14, 5)
	local cores = { rgb(176, 170, 160), rgb(150, 144, 136), rgb(200, 192, 180) }
	for lado = -1, 1, 2 do
		for i = 1, 11 do
			task.delay(i * 0.035, function()
				local x = pos.X + lado * i * 1.3
				local c = cubo(Vector3.new(1.2, 1.2, 1.4), Vector3.new(x, -0.4, 0), cores[(i % 3) + 1])
				local sobe = TweenService:Create(c, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = Vector3.new(x, 1 + (11 - i) * 0.12, 0), Orientation = Vector3.new(0, 0, lado * -20) })
				sobe:Play()
				sobe.Completed:Connect(function()
					tween(c, 0.25, { Position = Vector3.new(x, -0.8, 0), Transparency = 1 }, Enum.EasingStyle.Quad)
				end)
				Debris:AddItem(c, 0.6)
				if i % 3 == 0 then
					local lasca = cubo(Vector3.new(0.4, 0.4, 0.4), Vector3.new(x, 0.6, 0.5), rgb(120, 110, 100))
					tween(lasca, 0.5, { Position = Vector3.new(x + lado * 1.5, 3 + math.random() * 2, 0.5), Transparency = 1 })
					Debris:AddItem(lasca, 0.6)
				end
			end)
		end
	end
	-- rachaduras no chão
	for i = -3, 3 do
		local r = cubo(Vector3.new(1.2, 0.08, 0.25), Vector3.new(pos.X + i * 1.1, 0.03, 0.4 + (i % 2) * 0.3), rgb(40, 34, 30))
		r.Orientation = Vector3.new(0, (i % 2 == 0) and 25 or -25, 0)
		task.delay(1.6, function()
			tween(r, 0.8, { Transparency = 1 })
		end)
		Debris:AddItem(r, 2.6)
	end
end

local function confete()
	local cores = { rgb(255, 80, 80), rgb(80, 180, 255), rgb(255, 220, 60), rgb(90, 220, 120), rgb(240, 120, 240) }
	if not hrp then
		return
	end
	for i = 1, 60 do
		local p = hrp.Position + Vector3.new((math.random() - 0.5) * 40, 18 + math.random() * 8, (math.random() - 0.5) * 4)
		local c = cubo(Vector3.new(0.5, 0.5, 0.1), p, cores[(i % #cores) + 1], true)
		tween(c, 2.5 + math.random(), { Position = p - Vector3.new(0, 22, 0), Orientation = Vector3.new(math.random(0, 360), math.random(0, 360), 0), Transparency = 0.5 }, Enum.EasingStyle.Linear)
		Debris:AddItem(c, 3.6)
	end
end

Efeito.OnClientEvent:Connect(function(tipo, a, b, c)
	if tipo == "golpe" then
		if a ~= jogador.UserId then
			rastro(b, c)
		end
	elseif tipo == "acerto" then
		faiscas(a, b, c)
		tremor = math.max(tremor, 0.35)
	elseif tipo == "impacto" then
		ondaDeChoque(a, b)
	elseif tipo == "empurrao" then
		if hrp then
			hrp.AssemblyLinearVelocity = Vector3.new(a, b, 0)
			tremor = math.max(tremor, 0.6)
		end
	elseif tipo == "banner" then
		mostrarFaixa(a, b)
	elseif tipo == "aviso" then
		mostrarAviso(a)
	elseif tipo == "vitoria" then
		mostrarFaixa("VITÓRIA!", "o Igor foi derrotado")
		confete()
	end
end)

------------------------------------------------------------------------------------
-- Cenário vivo: aves que fogem, torcida pulando, folhas no vento, balsa
------------------------------------------------------------------------------------
local aves = {}
local function registrarAve(m)
	if m:IsA("Model") and m.PrimaryPart then
		local origem = m:GetPivot()
		local partes = {}
		for _, p in ipairs(m:GetChildren()) do
			if p:IsA("BasePart") then
				partes[p] = origem:ToObjectSpace(p.CFrame)
			end
		end
		aves[m] = { origem = origem, partes = partes, estado = "chao", t = math.random() * 3, vx = 0 }
	end
end
for _, m in ipairs(CollectionService:GetTagged("Ave")) do
	registrarAve(m)
end
CollectionService:GetInstanceAddedSignal("Ave"):Connect(registrarAve)

local balanco = {}
local function registrarBalanco(p, forca, fase)
	if p:IsA("BasePart") then
		balanco[p] = { cf = p.CFrame, forca = forca, fase = fase or (p.Position.X * 0.15) }
	end
end
for _, p in ipairs(CollectionService:GetTagged("Copa")) do
	registrarBalanco(p, 1)
end
CollectionService:GetInstanceAddedSignal("Copa"):Connect(function(p)
	registrarBalanco(p, 1)
end)
local torcida = {}
local function registrarTorcida(p)
	if p:IsA("BasePart") then
		torcida[p] = { cf = p.CFrame, fase = math.random() * 6 }
	end
end
for _, p in ipairs(CollectionService:GetTagged("Torcida")) do
	registrarTorcida(p)
end
CollectionService:GetInstanceAddedSignal("Torcida"):Connect(registrarTorcida)

-- Coloca cada peça da ave a partir da posição original (as asas batem sem acumular giro)
local function moverAve(a, cf, bater)
	for p, rel in pairs(a.partes) do
		if p.Name == "Asa" and bater then
			p.CFrame = cf * rel * CFrame.Angles(bater, 0, 0)
		else
			p.CFrame = cf * rel
		end
	end
end

local function atualizarAves(dt, t)
	for m, a in pairs(aves) do
		if m.Parent then
			a.t = a.t + dt
			local origem = a.origem.Position
			if a.estado == "chao" then
				-- bicando o chão de vez em quando
				local bica = math.max(0, math.sin(a.t * 3)) ^ 6 * 0.25
				moverAve(a, a.origem * CFrame.new(0, -bica, 0))
				if hrp and math.abs(hrp.Position.X - origem.X) < 9 and math.abs(hrp.Position.Y - origem.Y) < 8 then
					a.estado = "voando"
					a.t = 0
					a.vx = (origem.X >= hrp.Position.X) and 1 or -1
				end
			elseif a.estado == "voando" then
				-- foge assustada: arranca para longe, subindo e batendo as asas
				local x = origem.X + a.vx * (a.t * 14 + a.t * a.t * 4)
				local y = origem.Y + a.t * 9 + a.t * a.t * 3
				local cf = CFrame.new(x, y, origem.Z - a.t * 4) * CFrame.Angles(0, a.vx > 0 and 0 or math.pi, math.rad(20))
				moverAve(a, cf, math.sin(t * 40) * 0.9)
				if a.t > 3 then
					a.estado = "longe"
					a.t = 0
					moverAve(a, a.origem + Vector3.new(0, -50, 0))
				end
			elseif a.estado == "longe" then
				if a.t > 12 and (not hrp or math.abs(hrp.Position.X - origem.X) > 30) then
					a.estado = "chao"
					a.t = 0
				end
			end
		else
			aves[m] = nil
		end
	end
end

local function atualizarCenario(t)
	local vento = math.sin(t * 0.6) * 0.5 + 0.5
	for p, b in pairs(balanco) do
		if p.Parent then
			local a = (math.sin(t * 2.2 + b.fase) * 0.04 + math.sin(t * 5.1 + b.fase * 2) * 0.012) * (0.6 + vento) * b.forca
			p.CFrame = b.cf * CFrame.new(math.sin(t * 2.2 + b.fase) * 0.12 * vento, 0, 0) * CFrame.Angles(0, 0, a)
		end
	end
	for p, b in pairs(torcida) do
		if p.Parent then
			local pulo = math.max(0, math.sin(t * 7 + b.fase)) * 0.5
			p.CFrame = b.cf + Vector3.new(0, pulo, 0)
		end
	end
end

-- Balsa: movida em todos os clientes pelo relógio do servidor, empurrando quem está em cima
RunService.Stepped:Connect(function()
	local t = workspace:GetServerTimeNow()
	for _, p in ipairs(CollectionService:GetTagged("Plataforma")) do
		local cx, amp, vel, y = p:GetAttribute("CentroX"), p:GetAttribute("Amp"), p:GetAttribute("Vel"), p:GetAttribute("Y")
		if cx then
			p.CFrame = CFrame.new(cx + math.sin(t * vel) * amp, y, 0)
			p.AssemblyLinearVelocity = Vector3.new(math.cos(t * vel) * amp * vel, 0, 0)
		end
	end
end)

------------------------------------------------------------------------------------
-- Câmera lateral e trava da pista
------------------------------------------------------------------------------------
local camX, camY, camDist = 0, 6, 40
local relogio = 0
local cenaAcc = 0
local inimigos = workspace:WaitForChild("DaRocaInimigos", 30)

RunService:BindToRenderStep("DaRocaCamera", Enum.RenderPriority.Camera.Value + 1, function(dt)
	relogio = relogio + dt
	camera.CameraType = Enum.CameraType.Scriptable
	camera.FieldOfView = 50
	if hrp and hrp.Parent and hum then
		local p = hrp.Position
		-- virar para o lado em que anda (sem girar a câmera)
		local mx = hum.MoveDirection.X
		if math.abs(mx) > 0.15 then
			direcao = mx > 0 and 1 or -1
		end
		local giro = direcao > 0 and -math.pi / 2 or math.pi / 2
		local atual = hrp.CFrame
		local alvoCf = CFrame.new(p.X, p.Y, 0) * CFrame.Angles(0, giro, 0)
		hrp.CFrame = atual:Lerp(alvoCf, math.min(1, dt * 18))
		local v = hrp.AssemblyLinearVelocity
		if v.Z ~= 0 then
			hrp.AssemblyLinearVelocity = Vector3.new(v.X, v.Y, 0)
		end
		local a = 1 - math.exp(-dt * 5)
		camX = camX + (p.X + direcao * 5 - camX) * a
		camY = camY + (math.max(p.Y, 3) + 3 - camY) * a
		local naArena = p.X > 728
		camDist = camDist + ((naArena and 54 or 40) - camDist) * a
		if naArena then
			camX = camX + (math.clamp(p.X, 790, 830) - camX) * a * 0.5
		end
	end
	tremor = math.max(0, tremor - dt * 3)
	local s = tremor * tremor
	local off = Vector3.new((math.random() - 0.5) * s, (math.random() - 0.5) * s, 0)
	camera.CFrame = CFrame.new(Vector3.new(camX, camY + 4, camDist) + off, Vector3.new(camX, camY + 1, 0) + off)

	atualizarAves(dt, relogio)
	cenaAcc = cenaAcc + dt
	if cenaAcc > 1 / 30 then -- folhas e torcida a 30 quadros bastam
		cenaAcc = 0
		atualizarCenario(relogio)
	end

	-- barra de vida do Igor
	local igor = inimigos and inimigos:FindFirstChild("Igor")
	if igor and igor:GetAttribute("Ativo") and hrp and hrp.Position.X > 720 then
		barra.Visible = true
		local hp, mx = igor:GetAttribute("HP") or 0, igor:GetAttribute("MaxHP") or 1
		barraVida.Size = UDim2.fromScale(math.clamp(hp / mx, 0, 1), 1)
		barraNome.Text = hp <= mx / 2 and "IGOR  (FURIOSO)" or "IGOR"
	else
		barra.Visible = false
	end
end)
