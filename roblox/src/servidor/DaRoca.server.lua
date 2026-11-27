--!nocheck
--[[ Da Roça Adventure no Roblox — script do servidor (ServerScriptService).
  Guarda o save de cada jogador (o localStorage do jogo: campanha, Campanha 2, opções) no DataStore.
  O DataStore só funciona num jogo publicado, ou no Studio com "Enable Studio Access to API Services" ligado. ]]
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local RS = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

Players.CharacterAutoLoads = false

local remoto = Instance.new("RemoteFunction")
remoto.Name = "DaRocaSave"
remoto.Parent = RS

local ok, loja = pcall(function() return DataStoreService:GetDataStore("DaRocaSaves_v1") end)
if not ok then warn("[Da Roça] DataStore indisponível: " .. tostring(loja)); loja = nil end

local ultimoSalvo = {}
local cache = {}
local function chave(plr) return "jogador_" .. plr.UserId end

remoto.OnServerInvoke = function(plr, acao, dados)
  if acao == "carregar" then
    if cache[plr] then return cache[plr] end
    if not loja then return {} end
    local okG, valor = pcall(function() return loja:GetAsync(chave(plr)) end)
    local t = {}
    if okG and type(valor) == "string" then local okJ, dec = pcall(HttpService.JSONDecode, HttpService, valor); if okJ and type(dec) == "table" then t = dec end end
    cache[plr] = t
    return t
  elseif acao == "salvar" then
    if type(dados) ~= "table" then return false end
    -- só textos curtos (o localStorage do jogo é texto); limite de tamanho do DataStore (4 MB)
    local limpo, total = {}, 0
    for k, v in pairs(dados) do if type(k) == "string" and type(v) == "string" then total = total + #k + #v; if total > 3500000 then break end; limpo[k] = v end end
    cache[plr] = limpo
    local agora = os.clock()
    if ultimoSalvo[plr] and agora - ultimoSalvo[plr] < 8 then return true end
    ultimoSalvo[plr] = agora
    if not loja then return false end
    local texto = HttpService:JSONEncode(limpo)
    local okS, erro = pcall(function() loja:SetAsync(chave(plr), texto) end)
    if not okS then warn("[Da Roça] não salvou: " .. tostring(erro)) end
    return okS
  end
  return nil
end

local function salvarAoSair(plr)
  local t = cache[plr]
  if t and loja then pcall(function() loja:SetAsync(chave(plr), HttpService:JSONEncode(t)) end) end
  cache[plr] = nil; ultimoSalvo[plr] = nil
end
Players.PlayerRemoving:Connect(salvarAoSair)
game:BindToClose(function() for _, plr in ipairs(Players:GetPlayers()) do salvarAoSair(plr) end end)
