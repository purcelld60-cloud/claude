-- Da Roça Adventure (protótipo para Roblox)
-- Combate: soco dos jogadores, valentões que patrulham a estrada e a praça, e o chefe
-- Igor na escola, com o pulo de barriga (prepara os braços, solta no ar, pousa
-- amortecendo) e a onda de choque em blocos.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local remotes = ReplicatedStorage:WaitForChild("DaRocaRemotes")
local Ataque = remotes:WaitForChild("Ataque")
local Efeito = remotes:WaitForChild("Efeito")
local mapa = workspace:WaitForChild("DaRocaMapa")
while not mapa:GetAttribute("Pronto") do
	task.wait(0.1)
end

local pasta = Instance.new("Folder")
pasta.Name = "DaRocaInimigos"
pasta.Parent = workspace

local function rgb(r, g, b)
	return Color3.fromRGB(r, g, b)
end
local function parte(model, nome, tamanho, cor, material, forma)
	local p = Instance.new("Part")
	p.Name = nome
	p.Size = tamanho
	p.Color = cor
	p.Material = material or Enum.Material.SmoothPlastic
	p.Anchored = true
	p.CanCollide = false
	p.CanTouch = false
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	if forma == "elipse" then
		-- bloco com malha de esfera: aceita tamanhos diferentes em cada eixo (amassar/esticar)
		local malha = Instance.new("SpecialMesh")
		malha.MeshType = Enum.MeshType.Sphere
		malha.Parent = p
	elseif forma then
		p.Shape = forma
	end
	p.Parent = model
	return p
end
local function sinal(v)
	if v < 0 then
		return -1
	end
	return 1
end

-- Lista do que pode levar soco: cada alvo diz onde está e o que fazer ao ser atingido
local alvos = {}

-- Jogador vivo mais próximo de x (opcionalmente dentro de um intervalo)
local function jogadorPerto(x, alcance, xmin, xmax)
	local melhor, melhorPl, melhorD = nil, nil, alcance
	for _, pl in ipairs(Players:GetPlayers()) do
		local ch = pl.Character
		local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		if hrp and hum and hum.Health > 0 then
			local px = hrp.Position.X
			local d = math.abs(px - x)
			if d < melhorD and (not xmin or (px >= xmin and px <= xmax)) then
				melhor, melhorPl, melhorD = hrp, pl, d
			end
		end
	end
	return melhor, melhorPl
end

local function machucar(pl, dano, empurraX, empurraY)
	local ch = pl.Character
	local hum = ch and ch:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then
		return
	end
	if ch:GetAttribute("Invulneravel") then
		return
	end
	hum:TakeDamage(dano)
	ch:SetAttribute("Invulneravel", true)
	task.delay(0.8, function()
		if ch.Parent then
			ch:SetAttribute("Invulneravel", nil)
		end
	end)
	Efeito:FireClient(pl, "empurrao", empurraX, empurraY)
end

-- Estilhaços de blocos quando alguém é derrotado
local function estilhacar(pos, cores, n)
	for i = 1, n do
		local p = Instance.new("Part")
		p.Size = Vector3.new(0.6, 0.6, 0.6)
		p.Color = cores[(i % #cores) + 1]
		p.Material = Enum.Material.SmoothPlastic
		p.Position = pos + Vector3.new(math.random() - 0.5, math.random() * 2, 0)
		p.CanTouch = false
		p.CanQuery = false
		p.Parent = workspace
		p.AssemblyLinearVelocity = Vector3.new((math.random() - 0.5) * 40, 20 + math.random() * 25, 0)
		Debris:AddItem(p, 1.6)
	end
end

------------------------------------------------------------------------------------
-- Valentões
------------------------------------------------------------------------------------
local valentoes = {}
local CAMISAS = { rgb(200, 56, 56), rgb(60, 60, 70), rgb(220, 140, 40), rgb(70, 110, 60) }

local function criarValentao(x, xmin, xmax, i)
	local m = Instance.new("Model")
	m.Name = "Valentao"
	local pele = rgb(206, 150, 112)
	local camisa = CAMISAS[(i % #CAMISAS) + 1]
	local e = {
		model = m, x = x, x0 = x, xmin = xmin, xmax = xmax, dir = -1, hp = 3, vivo = true,
		empurrao = 0, ultimoGolpe = 0, flash = 0, soco = 0, p = {},
	}
	e.p.pernaE = parte(m, "PernaE", Vector3.new(0.9, 2, 0.9), rgb(50, 60, 90), Enum.Material.Fabric)
	e.p.pernaD = parte(m, "PernaD", Vector3.new(0.9, 2, 0.9), rgb(50, 60, 90), Enum.Material.Fabric)
	e.p.tronco = parte(m, "Tronco", Vector3.new(2, 2.2, 1.1), camisa, Enum.Material.Fabric)
	e.p.bracoE = parte(m, "BracoE", Vector3.new(0.8, 2, 0.8), pele)
	e.p.bracoD = parte(m, "BracoD", Vector3.new(0.8, 2, 0.8), pele)
	e.p.cabeca = parte(m, "Cabeca", Vector3.new(1.3, 1.3, 1.3), pele)
	e.p.bone = parte(m, "Bone", Vector3.new(1.4, 0.4, 1.4), camisa)
	e.p.aba = parte(m, "Aba", Vector3.new(1.2, 0.15, 0.8), camisa)
	e.p.olhoE = parte(m, "OlhoE", Vector3.new(0.2, 0.25, 0.1), rgb(20, 20, 24))
	e.p.olhoD = parte(m, "OlhoD", Vector3.new(0.2, 0.25, 0.1), rgb(20, 20, 24))
	e.p.sobr = parte(m, "Sobrancelha", Vector3.new(0.9, 0.12, 0.1), rgb(40, 30, 24))
	e.cores = {}
	for k, p in pairs(e.p) do
		e.cores[k] = p.Color
	end
	m.Parent = pasta
	table.insert(valentoes, e)
	table.insert(alvos, {
		pos = function()
			if e.vivo then
				return Vector3.new(e.x, 3, 0), 0.6
			end
		end,
		hit = function(dano, dir)
			e.hp = e.hp - dano
			e.flash = 0.1
			e.empurrao = dir * 22
			Efeito:FireAllClients("acerto", Vector3.new(e.x, 3.2, 0), dir, camisa)
			if e.hp <= 0 then
				e.vivo = false
				estilhacar(Vector3.new(e.x, 2.5, 0), { camisa, pele, rgb(50, 60, 90) }, 14)
				for _, p in pairs(e.p) do
					p.Transparency = 1
				end
				task.delay(25, function()
					e.x, e.hp, e.vivo = e.x0, 3, true
					for _, p in pairs(e.p) do
						p.Transparency = 0
					end
				end)
			end
		end,
	})
	return e
end

local function poseValentao(e, t, andando)
	local giro = e.dir > 0 and -math.pi / 2 or math.pi / 2
	local base = CFrame.new(e.x, 0, 0) * CFrame.Angles(0, giro, 0) -- frente = -Z local
	local s = andando and math.sin(t * 11) * 0.7 or 0
	local respira = math.sin(t * 2.5) * 0.05
	local p = e.p
	p.pernaE.CFrame = base * CFrame.new(-0.5, 2.1, 0) * CFrame.Angles(s, 0, 0) * CFrame.new(0, -1, 0)
	p.pernaD.CFrame = base * CFrame.new(0.5, 2.1, 0) * CFrame.Angles(-s, 0, 0) * CFrame.new(0, -1, 0)
	p.tronco.CFrame = base * CFrame.new(0, 3.2 + respira, 0)
	local socoAng = 0
	if e.soco > 0 then
		socoAng = math.rad(100) * math.sin((e.soco / 0.3) * math.pi)
	end
	p.bracoE.CFrame = base * CFrame.new(-1.4, 4.1, 0) * CFrame.Angles(-s * 0.8, 0, 0) * CFrame.new(0, -0.9, 0)
	p.bracoD.CFrame = base * CFrame.new(1.4, 4.1, 0) * CFrame.Angles(s * 0.8 + socoAng, 0, 0) * CFrame.new(0, -0.9, 0)
	local cab = base * CFrame.new(0, 4.95 + respira, 0)
	p.cabeca.CFrame = cab
	p.bone.CFrame = cab * CFrame.new(0, 0.75, 0)
	p.aba.CFrame = cab * CFrame.new(0, 0.6, -0.9)
	p.olhoE.CFrame = cab * CFrame.new(-0.3, 0.05, -0.66)
	p.olhoD.CFrame = cab * CFrame.new(0.3, 0.05, -0.66)
	p.sobr.CFrame = cab * CFrame.new(0, 0.3, -0.66) * CFrame.Angles(0, 0, 0.12)
	local branco = e.flash > 0
	for k, part in pairs(p) do
		part.Color = branco and Color3.new(1, 1, 1) or e.cores[k]
	end
end

local POS_VALENTOES = {
	{ 150, 110, 240 },
	{ 400, 340, 455 },
	{ 525, 470, 555 },
	{ 615, 570, 710 },
	{ 680, 640, 712 },
}
for i, v in ipairs(POS_VALENTOES) do
	criarValentao(v[1], v[2], v[3], i)
end

local function atualizarValentoes(dt, t)
	for _, e in ipairs(valentoes) do
		if e.vivo then
			e.flash = math.max(0, e.flash - dt)
			e.soco = math.max(0, e.soco - dt)
			local alvo, pl = jogadorPerto(e.x, 26, e.xmin - 6, e.xmax + 6)
			local andando = false
			if math.abs(e.empurrao) > 0.5 then
				e.x = e.x + e.empurrao * dt
				e.empurrao = e.empurrao * math.exp(-dt * 8)
			elseif alvo and math.abs(alvo.Position.Y - 3) < 7 then
				local dx = alvo.Position.X - e.x
				e.dir = sinal(dx)
				if math.abs(dx) > 2 then
					e.x = e.x + e.dir * 8.5 * dt
					andando = true
				end
				if math.abs(dx) < 3 and math.abs(alvo.Position.Y - 3) < 3.5 and t - e.ultimoGolpe > 1.1 then
					e.ultimoGolpe = t
					e.soco = 0.3
					machucar(pl, 12, e.dir * 45, 30)
				end
			else
				e.x = e.x + e.dir * 4 * dt
				andando = true
				if e.x > e.xmax then
					e.dir = -1
				elseif e.x < e.xmin then
					e.dir = 1
				end
			end
			e.x = math.clamp(e.x, e.xmin, e.xmax)
			poseValentao(e, t, andando)
		end
	end
end

------------------------------------------------------------------------------------
-- IGOR, o monitor da escola
------------------------------------------------------------------------------------
local ARENA_MIN, ARENA_MAX, IGOR_CASA = 742, 888, 850
local IGOR_VIDA = 30
local K = 0.15 -- 1 pixel do desenho original = 0.15 stud
local PELE, PELE2 = rgb(231, 160, 121), rgb(239, 178, 139)
local CAMISA, CALCA, TENIS = rgb(124, 128, 117), rgb(35, 58, 88), rgb(237, 240, 221)
local BARBA, SOBR = rgb(101, 76, 62), rgb(114, 80, 62)

local igorModel = Instance.new("Model")
igorModel.Name = "Igor"
local I = {}
I.pernaE = parte(igorModel, "PernaE", Vector3.new(2.1, 3.2, 2), CALCA, Enum.Material.Fabric)
I.pernaD = parte(igorModel, "PernaD", Vector3.new(2.1, 3.2, 2), CALCA, Enum.Material.Fabric)
I.tenisE = parte(igorModel, "TenisE", Vector3.new(3, 1.2, 2.4), TENIS)
I.tenisD = parte(igorModel, "TenisD", Vector3.new(3, 1.2, 2.4), TENIS)
I.corpo = parte(igorModel, "Corpo", Vector3.new(9, 9, 9), CAMISA, Enum.Material.Fabric, "elipse")
I.barriga = parte(igorModel, "Barriga", Vector3.new(7.2, 6.9, 6), PELE, nil, "elipse")
I.barriga2 = parte(igorModel, "Barriga2", Vector3.new(5.4, 5.2, 4.8), PELE2, nil, "elipse")
I.umbigo = parte(igorModel, "Umbigo", Vector3.new(0.7, 0.6, 0.3), rgb(188, 123, 93))
I.cabeca = parte(igorModel, "Cabeca", Vector3.new(5.2, 4.6, 4.6), PELE, nil, "elipse")
I.barba = parte(igorModel, "Barba", Vector3.new(2.9, 0.8, 0.6), BARBA)
I.barba2 = parte(igorModel, "Barba2", Vector3.new(1.8, 0.6, 0.6), BARBA)
I.olhoE = parte(igorModel, "OlhoE", Vector3.new(0.45, 0.6, 0.3), rgb(48, 53, 59))
I.olhoD = parte(igorModel, "OlhoD", Vector3.new(0.45, 0.6, 0.3), rgb(48, 53, 59))
I.sobrE = parte(igorModel, "SobrE", Vector3.new(1.05, 0.3, 0.3), SOBR)
I.sobrD = parte(igorModel, "SobrD", Vector3.new(1.05, 0.3, 0.3), SOBR)
I.nariz = parte(igorModel, "Nariz", Vector3.new(1, 0.6, 0.5), rgb(193, 132, 98))
I.bracoE1 = parte(igorModel, "BracoE1", Vector3.new(1.3, 1.3, 2), PELE)
I.bracoE2 = parte(igorModel, "BracoE2", Vector3.new(1.2, 1.2, 2), PELE)
I.bracoD1 = parte(igorModel, "BracoD1", Vector3.new(1.3, 1.3, 2), PELE)
I.bracoD2 = parte(igorModel, "BracoD2", Vector3.new(1.2, 1.2, 2), PELE)
I.maoE = parte(igorModel, "MaoE", Vector3.new(1.3, 1.3, 1.3), PELE2)
I.maoD = parte(igorModel, "MaoD", Vector3.new(1.3, 1.3, 1.3), PELE2)
local IGOR_CORES = {}
for k, p in pairs(I) do
	IGOR_CORES[k] = p.Color
	p.CastShadow = true
end
-- sombra de pouso em pixels e setas piscando
local marca = {}
for i = -3, 3 do
	local w = 1.6
	local h = 0.12
	local q = parte(igorModel, "Sombra", Vector3.new(w, h, (4 - math.abs(i)) * 0.9 + 0.4), rgb(20, 16, 24))
	q.Transparency = 1
	marca[#marca + 1] = { part = q, i = i }
end
local setaE = parte(igorModel, "Seta", Vector3.new(0.8, 0.8, 0.2), rgb(255, 70, 60), Enum.Material.Neon)
local setaD = parte(igorModel, "Seta", Vector3.new(0.8, 0.8, 0.2), rgb(255, 70, 60), Enum.Material.Neon)
setaE.Transparency, setaD.Transparency = 1, 1
-- estrelinhas de cansaço
local estrelas = {}
for i = 1, 3 do
	local s = parte(igorModel, "Estrela", Vector3.new(0.7, 0.7, 0.2), rgb(255, 230, 90), Enum.Material.Neon)
	s.Transparency = 1
	estrelas[i] = s
end
igorModel:SetAttribute("HP", IGOR_VIDA)
igorModel:SetAttribute("MaxHP", IGOR_VIDA)
igorModel:SetAttribute("Ativo", false)
igorModel.Parent = pasta

local B = {
	x = IGOR_CASA, y = 0, dir = -1, hp = IGOR_VIDA, estado = "espera", t = 0, ciclo = 0,
	flash = 0, tx = IGOR_CASA, x0 = IGOR_CASA, segundo = false, rolarDir = 1, rolarAng = 0,
	ultimoContato = 0,
}
local function mudar(estado)
	B.estado = estado
	B.t = 0
end
local function fase2()
	return B.hp <= IGOR_VIDA / 2
end

-- Converte um ponto do desenho 2D (x para a direita, y negativo para cima) em mundo
local function P(px, py, ys, z)
	return Vector3.new(B.x + px * K * B.dir, B.y - py * K * ys, z or 0)
end
local function membro(part, a, b)
	local d = (b - a).Magnitude
	part.Size = Vector3.new(part.Size.X, part.Size.Y, d + 0.5)
	part.CFrame = CFrame.lookAt((a + b) / 2, b)
end

-- Poses de braço iguais às da campanha (preparar, subir, cair, pousar)
local function bracos(pose, k, andar)
	local AL = { { -25, -57 }, { -33, -38 + andar }, { -29, -28 + andar } }
	local AR = { { 25, -58 }, { 34, -39 - andar }, { 29, -26 - andar } }
	if pose == "preparar" then
		AL = { { -25, -57 }, { -38, -46 + k * 4 }, { -46, -34 + k * 8 } }
		AR = { { 25, -58 }, { 16, -44 + k * 2 }, { 4, -32 + k * 6 } }
	elseif pose == "subir" then
		AL = { { -25, -57 }, { -33, -77 }, { -27, -97 } }
		AR = { { 25, -58 }, { 33, -79 }, { 27, -99 } }
	elseif pose == "cair" then
		AL = { { -25, -57 }, { -46, -63 }, { -61, -58 } }
		AR = { { 25, -58 }, { 46, -64 }, { 61, -59 } }
	elseif pose == "pousar" then
		AL = { { -25, -57 }, { -44, -46 }, { -54, -36 } }
		AR = { { 25, -58 }, { 44, -47 }, { 54, -37 } }
	elseif pose == "derrota" then
		AL = { { -25, -57 }, { -40, -50 }, { -50, -44 } }
		AR = { { 25, -58 }, { 40, -51 }, { 50, -45 } }
	end
	return AL, AR
end

local function poseIgor(t, pose, k, ys, andando)
	local andar = andando and math.sin(t * 7) * 4 or 0
	local tremor = 0
	if pose == "preparar" then
		tremor = math.sin(t * 60) * 0.12 * k
	end
	local x0 = B.x
	B.x = B.x + tremor
	-- pernas e tênis
	local lx, rx, ly, sy = -11 + andar, 12 - andar, -12.5, -4
	if pose == "subir" then
		lx, rx, ly, sy = -10, 11, -21, -11
	elseif pose == "preparar" then
		local sp = k * 5
		lx, rx = -13 - sp, 14 + sp
	end
	I.pernaE.CFrame = CFrame.new(P(lx, ly, ys))
	I.pernaD.CFrame = CFrame.new(P(rx, ly, ys))
	I.tenisE.CFrame = CFrame.new(P(lx, sy, ys, 0.4))
	I.tenisD.CFrame = CFrame.new(P(rx, sy, ys, 0.4))
	-- corpo, barriga de fora e umbigo
	local respira = 1 + math.sin(t * 2.4) * 0.015
	I.corpo.CFrame = CFrame.new(P(0, -40, ys))
	I.corpo.Size = Vector3.new(9 * respira, 9 * ys, 9)
	I.barriga.CFrame = CFrame.new(P(5, -38, ys, 1.6))
	I.barriga2.CFrame = CFrame.new(P(8, -39, ys, 2.3))
	I.umbigo.CFrame = CFrame.new(P(8.5, -37, ys, 4.6))
	-- cabeça
	local cab = P(-1, -75, ys)
	I.cabeca.CFrame = CFrame.new(cab)
	local face = function(px, py, z)
		return CFrame.new(P(px, py, ys, z))
	end
	I.olhoE.CFrame = face(-8.5, -72, 2.1)
	I.olhoD.CFrame = face(6.5, -72, 2.1)
	local raiva = fase2() and 0.25 or 0
	I.sobrE.CFrame = face(-8.5, -77, 2.05) * CFrame.Angles(0, 0, -raiva * B.dir)
	I.sobrD.CFrame = face(7.5, -77, 2.05) * CFrame.Angles(0, 0, raiva * B.dir)
	I.nariz.CFrame = face(-0.5, -69, 2.3)
	I.barba.CFrame = face(-0.5, -61.5, 1.9)
	I.barba2.CFrame = face(0, -58.5, 1.7)
	-- braços
	local AL, AR = bracos(pose, k, andar)
	local function braco(pts, p1, p2, mao)
		local a = P(pts[1][1], pts[1][2], ys, 0.5)
		local b = P(pts[2][1], pts[2][2], ys, 0.8)
		local c = P(pts[3][1], pts[3][2], ys, 0.9)
		membro(p1, a, b)
		membro(p2, b, c)
		mao.CFrame = CFrame.new(c)
	end
	braco(AL, I.bracoE1, I.bracoE2, I.maoE)
	braco(AR, I.bracoD1, I.bracoD2, I.maoD)
	B.x = x0
	-- piscar branco ao levar soco
	local branco = B.flash > 0
	for nome, p in pairs(I) do
		p.Color = branco and Color3.new(1, 1, 1) or IGOR_CORES[nome]
	end
end

local function mostrarCorpo(visivel)
	for _, p in pairs(I) do
		p.Transparency = visivel and 0 or 1
	end
end

local function mostrarMarca(x, k, piscar)
	for _, q in ipairs(marca) do
		if x then
			q.part.Transparency = 0.25 + (1 - k) * 0.6
			q.part.CFrame = CFrame.new(x + q.i * 1.6 * (0.5 + k * 0.5), 0.07, 0)
		else
			q.part.Transparency = 1
		end
	end
	local vis = x and piscar
	setaE.Transparency = vis and 0 or 1
	setaD.Transparency = vis and 0 or 1
	if x then
		local s = 7 + (1 - k) * 4
		setaE.CFrame = CFrame.new(x - s, 1.2, 0.5) * CFrame.Angles(0, 0, math.rad(45))
		setaD.CFrame = CFrame.new(x + s, 1.2, 0.5) * CFrame.Angles(0, 0, math.rad(45))
	end
end

local function mostrarEstrelas(t, vis)
	for i, s in ipairs(estrelas) do
		if vis then
			local a = t * 4 + i * 2.1
			s.Transparency = 0
			s.CFrame = CFrame.new(B.x + math.cos(a) * 2.6, B.y + 15 + math.sin(a * 2) * 0.3, math.sin(a) * 1.5) * CFrame.Angles(0, 0, a)
		else
			s.Transparency = 1
		end
	end
end

local function jogadorNaArena()
	return jogadorPerto(B.x, 400, ARENA_MIN - 8, ARENA_MAX + 8)
end

local function impacto()
	Efeito:FireAllClients("impacto", Vector3.new(B.x, 0, 0), fase2())
	for _, pl in ipairs(Players:GetPlayers()) do
		local ch = pl.Character
		local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
		if hrp then
			local dx = hrp.Position.X - B.x
			if math.abs(dx) < 11 and hrp.Position.Y < 5.5 then
				machucar(pl, 22, sinal(dx) * 60, 40)
			end
		end
	end
end

local function reiniciarIgor()
	B.x, B.y, B.hp, B.ciclo, B.segundo = IGOR_CASA, 0, IGOR_VIDA, 0, false
	igorModel:SetAttribute("HP", B.hp)
	igorModel:SetAttribute("Ativo", false)
	mostrarCorpo(true)
	mudar("espera")
end

table.insert(alvos, {
	pos = function()
		if B.estado == "espera" or B.estado == "intro" or B.estado == "derrota" then
			return nil
		end
		if B.estado == "rolar" then
			return Vector3.new(B.x, 4.5, 0), 3.5
		end
		return Vector3.new(B.x, B.y + 6.5, 0), 3.8
	end,
	hit = function(dano, dir)
		B.hp = math.max(0, B.hp - dano)
		B.flash = 0.09
		igorModel:SetAttribute("HP", B.hp)
		Efeito:FireAllClients("acerto", Vector3.new(B.x - dir * 3, B.y + 7, 0), dir, CAMISA)
		if B.hp <= 0 then
			mudar("derrota")
			Efeito:FireAllClients("vitoria")
		end
	end,
})

local function atualizarIgor(dt, t)
	B.t = B.t + dt
	B.flash = math.max(0, B.flash - dt)
	local alvo = jogadorNaArena()
	local est = B.estado
	local pose, k, ys, andando = nil, 1, 1, false
	local p2 = fase2()
	mostrarMarca(nil)
	mostrarEstrelas(t, false)

	if est ~= "espera" and est ~= "derrota" and not alvo then
		reiniciarIgor() -- todo mundo saiu ou caiu: o Igor volta inteiro
		est = B.estado
	end

	if est == "espera" then
		B.dir = -1
		if alvo then
			igorModel:SetAttribute("Ativo", true)
			Efeito:FireAllClients("banner", "IGOR", "o monitor da escola")
			mudar("intro")
		end
	elseif est == "intro" then
		pose = B.t < 1 and "preparar" or nil
		k = math.min(1, B.t * 2)
		if B.t > 2 then
			mudar("andar")
		end
	elseif est == "andar" then
		local dx = alvo.Position.X - B.x
		B.dir = sinal(dx)
		if math.abs(dx) > 4 then
			B.x = B.x + B.dir * (p2 and 7 or 5) * dt
			andando = true
		end
		if B.t > (p2 and 1 or 1.4) then
			B.tx = math.clamp(alvo.Position.X, ARENA_MIN, ARENA_MAX)
			if p2 and B.ciclo % 3 == 2 then
				mudar("rolarPrep")
			else
				mudar("preparar")
			end
		end
	elseif est == "preparar" then
		-- agacha e joga os braços para trás pegando impulso
		local dur = p2 and 0.55 or 0.8
		pose, k = "preparar", math.min(1, B.t / dur)
		ys = 1 - 0.12 * k
		B.dir = sinal(B.tx - B.x)
		mostrarMarca(B.tx, 0.2, math.floor(t * 8) % 2 == 0)
		if B.t > dur then
			B.x0 = B.x
			mudar("ar")
		end
	elseif est == "ar" then
		-- solta os braços para cima na subida, abre para equilibrar na descida
		local dur = 1.05
		local u = math.min(1, B.t / dur)
		B.x = B.x0 + (B.tx - B.x0) * u
		B.y = 4 * 16 * u * (1 - u)
		if u < 0.45 then
			pose, ys = "subir", 1.1
		elseif u < 0.8 then
			pose, ys = "cair", 1.05
		else
			pose, ys = "pousar", 1
		end
		mostrarMarca(B.tx, u, math.floor(t * 10) % 2 == 0)
		if u >= 1 then
			B.y = 0
			impacto()
			mudar("pouso")
		end
	elseif est == "pouso" then
		-- braços baixos amortecendo; o corpo amassa e volta
		pose = "pousar"
		local u = math.min(1, B.t / 0.45)
		ys = 0.84 + 0.16 * u + math.sin(u * math.pi * 3) * 0.04 * (1 - u)
		if B.t > 0.45 then
			if p2 and not B.segundo then
				B.segundo = true
				B.tx = math.clamp(alvo.Position.X, ARENA_MIN, ARENA_MAX)
				mudar("preparar")
			else
				B.segundo = false
				mudar("cansado")
			end
		end
	elseif est == "cansado" then
		ys = 1 - math.abs(math.sin(B.t * 3)) * 0.04
		mostrarEstrelas(t, true)
		if B.t > (p2 and 0.8 or 1.2) then
			B.ciclo = B.ciclo + 1
			mudar("andar")
		end
	elseif est == "rolarPrep" then
		pose, k = "preparar", math.min(1, B.t / 0.6)
		ys = 1 - 0.15 * k
		if B.t > 0.6 then
			B.rolarDir = sinal(alvo.Position.X - B.x)
			mudar("rolar")
		end
	elseif est == "rolar" then
		-- vira uma bola de barriga e atravessa o pátio: pule duas vezes por cima!
		B.x = B.x + B.rolarDir * 30 * dt
		B.rolarAng = B.rolarAng - B.rolarDir * dt * 30 / 4.5
		for _, pl in ipairs(Players:GetPlayers()) do
			local ch = pl.Character
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			if hrp and math.abs(hrp.Position.X - B.x) < 5 and hrp.Position.Y < 9 then
				machucar(pl, 20, B.rolarDir * 55, 35)
			end
		end
		if (B.rolarDir > 0 and B.x >= ARENA_MAX) or (B.rolarDir < 0 and B.x <= ARENA_MIN) or B.t > 3 then
			B.x = math.clamp(B.x, ARENA_MIN, ARENA_MAX)
			Efeito:FireAllClients("impacto", Vector3.new(B.x, 0, 0), false)
			mudar("cansado")
		end
	elseif est == "derrota" then
		pose = "derrota"
		ys = math.max(0.5, 1 - B.t * 0.5)
		if B.t > 1 and not B.estilhacado then
			B.estilhacado = true
			estilhacar(Vector3.new(B.x, 6, 0), { CAMISA, PELE, CALCA, TENIS }, 30)
			mostrarCorpo(false)
		end
		if B.t > 15 then
			B.estilhacado = false
			reiniciarIgor()
		end
	end

	B.x = math.clamp(B.x, ARENA_MIN, ARENA_MAX)
	if B.estado == "rolar" then
		-- bola: barriga gira, o resto some
		for nome, p in pairs(I) do
			p.Transparency = (nome == "corpo" or nome == "barriga" or nome == "cabeca") and 0 or 1
		end
		local centro = CFrame.new(B.x, 4.6, 0) * CFrame.Angles(0, 0, B.rolarAng)
		I.corpo.Size = Vector3.new(9, 9, 9)
		I.corpo.CFrame = centro
		I.barriga.CFrame = centro * CFrame.new(1.2, 0, 1.6)
		I.cabeca.CFrame = centro * CFrame.new(-1.5, 2.6, 2.2)
	elseif not B.estilhacado then
		if B.estado ~= "derrota" then
			mostrarCorpo(true)
		end
		poseIgor(t, pose, k, ys, andando)
	end
	-- encostar no Igor andando também machuca um pouco
	if (B.estado == "andar" or B.estado == "cansado") and alvo and t - B.ultimoContato > 1 then
		if math.abs(alvo.Position.X - B.x) < 4 and alvo.Position.Y < 9 then
			B.ultimoContato = t
			local pl = Players:GetPlayerFromCharacter(alvo.Parent)
			if pl then
				machucar(pl, 8, sinal(alvo.Position.X - B.x) * 45, 30)
			end
		end
	end
end

------------------------------------------------------------------------------------
-- Soco dos jogadores
------------------------------------------------------------------------------------
local ultimoSoco = {}
Ataque.OnServerEvent:Connect(function(pl, dir)
	local agora = os.clock()
	if ultimoSoco[pl] and agora - ultimoSoco[pl] < 0.25 then
		return
	end
	ultimoSoco[pl] = agora
	local ch = pl.Character
	local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
	local hum = ch and ch:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then
		return
	end
	dir = (type(dir) == "number" and dir < 0) and -1 or 1
	local pos = hrp.Position
	Efeito:FireAllClients("golpe", pl.UserId, pos, dir)
	for _, a in ipairs(alvos) do
		local ap, raio = a.pos()
		if ap then
			local dx = (ap.X - pos.X) * dir
			local dy = math.abs(ap.Y - pos.Y)
			if dx > -1.5 and dx < 5.5 + raio and dy < 3.5 + raio then
				a.hit(1, dir)
			end
		end
	end
end)
Players.PlayerRemoving:Connect(function(pl)
	ultimoSoco[pl] = nil
end)

local relogio = 0
RunService.Heartbeat:Connect(function(dt)
	dt = math.min(dt, 0.1)
	relogio = relogio + dt
	atualizarValentoes(dt, relogio)
	atualizarIgor(dt, relogio)
end)
