--!native
--[[ Camadas do cenário no Roblox: o jogo (HdMaps.camadas.desenhar) entrega o céu, a névoa, os fundos repetidos
  (com o fator de parallax) e o meio do cenário num quadro mais largo que a tela. Aqui sai, para a câmera de agora,
  onde cada camada fica na tela (960 x 540), com transparência e a cor da luz da hora (multiplicada pela placa de
  vídeo). O cliente do Roblox usa isto para posicionar as imagens; os testes usam para montar a tela num canvas. ]]
local K = {}
local floor = math.floor
local function arred(x) return floor(x + .5) end

-- info: resultado de HdMaps.camadas.desenhar; camera: câmera do jogo agora; tx, ty: tremor da tela neste quadro
function K.montar(info, camera, tx, ty)
  local out = {}
  tx, ty = tx or 0, ty or 0
  camera = tonumber(camera) or 0
  local camL = floor(camera / 2)
  local sub = arred(camera) - camL * 2
  local amb = info.amb
  local function add(fonte, x, w, h, alfa, tinta)
    out[#out + 1] = { fonte = fonte, x = x + tx, y = ty, w = w, h = h, alfa = alfa or 1, tinta = tinta }
  end
  for _, f in ipairs(info.fundo) do
    if f.tipo == "ceu" then add(info.ceu, -sub, info.ceu.width * 2, info.ceu.height * 2, 1, amb)
    elseif f.tipo == "nevoa" then add(f.cv, -sub, f.cv.width * 2, f.cv.height * 2, 1, amb)
    elseif f.tipo == "tile" then
      local img = f.img
      local T = img.width
      if T and T > 0 then
        local off = (tonumber(f.off) or 0) + (tonumber(f.p) or 0) * (camL - info.camW)
        local o = ((arred(off) % T) + T) % T
        local tinta = (not f.luz) and amb or nil
        add(img, -o * 2 - sub, T * 2, img.height * 2, tonumber(f.alfa) or 1, tinta)
        if T - o < 482 then add(img, (T - o) * 2 - sub, T * 2, img.height * 2, tonumber(f.alfa) or 1, tinta) end
      end
    end
  end
  -- o meio já vem com a luz da hora aplicada (multiplicada e com as luzes somadas)
  add(info.meio, info.camW * 2 - arred(camera), info.VW * 2, info.LH * 2, 1, nil)
  return out
end

-- a câmera ainda cabe no quadro do meio que está pronto? (senão o próximo desenho é urgente)
function K.cabe(info, camera)
  if not info then return false end
  local camL = floor((tonumber(camera) or 0) / 2)
  return math.abs(camL - (info.camW + info.M)) <= info.M - 6
end

return K
