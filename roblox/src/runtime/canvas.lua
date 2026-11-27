--[[ Canvas 2D em Lua puro: desenha, pixel por pixel, o que o jogo manda (a mesma API do navegador).
  Suporta: fillRect/clearRect/strokeRect, caminhos (moveTo, lineTo, rect, arc, ellipse, curvas, roundRect), fill/stroke,
  clip, transformações (save/restore, translate, scale, rotate, setTransform, transform), globalAlpha,
  globalCompositeOperation (source-over, lighter, screen, multiply, destination-out/in, source-atop, copy...),
  degradês linear e radial, drawImage entre canvas (vizinho mais próximo, como o jogo usa), getImageData,
  putImageData, createImageData e texto em fonte de pixel (runtime/fonte.lua).
  Cada pixel é um número só: R + G*256 + B*65536 + A*16777216 (a mesma ordem de bytes do EditableImage do Roblox),
  guardado em canvas._.px[1..w*h]. Funciona igual no Luau (Roblox) e no Lua 5.3 (testes). ]]
local Fonte = require(script and script.Parent and script.Parent:FindFirstChild("fonte") or "fonte")
local floor, ceil, max, min, sqrt, abs, cos, sin, pi, huge = math.floor, math.ceil, math.max, math.min, math.sqrt, math.abs, math.cos, math.sin, math.pi, math.huge
local criarTabela = table.create or function(n, v) local t = {}; for i = 1, n do t[i] = v end; return t end
local C = {}
-- listas de pixels do getImageData (o navegador simulado troca por Uint8ClampedArray)
C.novaLista = function(n) local d = {}; for k = 1, n do d[k] = 0 end; return d end
local OPACO = 4278190080 -- 255 * 16777216

-- cores: "#rgb", "#rrggbb", "#rrggbbaa", "rgb()", "rgba()", "hsl()", nomes; guardadas em cache como {r, g, b, a(0..1)}
local NOMES = { white = "#ffffff", black = "#000000", red = "#ff0000", green = "#008000", blue = "#0000ff", yellow = "#ffff00", orange = "#ffa500", purple = "#800080", pink = "#ffc0cb",
  transparent = "#00000000", gray = "#808080", grey = "#808080", silver = "#c0c0c0", gold = "#ffd700", cyan = "#00ffff", magenta = "#ff00ff", lime = "#00ff00", brown = "#a52a2a", navy = "#000080", teal = "#008080", maroon = "#800000", olive = "#808000", crimson = "#dc143c", tomato = "#ff6347", khaki = "#f0e68c", beige = "#f5f5dc", ivory = "#fffff0", wheat = "#f5deb3", tan = "#d2b48c", coral = "#ff7f50", salmon = "#fa8072", violet = "#ee82ee", indigo = "#4b0082", skyblue = "#87ceeb", whitesmoke = "#f5f5f5", lightgray = "#d3d3d3", darkgray = "#a9a9a9", dimgray = "#696969" }
local cache, nCache = {}, 0
local function hsl(h, s, l) h = (h % 360) / 360; s = s / 100; l = l / 100
  local function f(n) local k = (n + h * 12) % 12; return l - s * min(l, 1 - l) * max(-1, min(k - 3, 9 - k, 1)) end
  return f(0) * 255, f(8) * 255, f(4) * 255 end
local function cor(s)
  if type(s) ~= "string" then return nil end
  local c = cache[s]; if c then return c end
  local t = s:match("^%s*(.-)%s*$"):lower()
  t = NOMES[t] or t
  local r, g, b, a = 0, 0, 0, 1
  if t:sub(1, 1) == "#" then
    local h = t:sub(2)
    if #h == 3 or #h == 4 then
      r = (tonumber(h:sub(1, 1), 16) or 0) * 17; g = (tonumber(h:sub(2, 2), 16) or 0) * 17; b = (tonumber(h:sub(3, 3), 16) or 0) * 17; if #h == 4 then a = (tonumber(h:sub(4, 4), 16) or 15) * 17 / 255 end
    else
      r = tonumber(h:sub(1, 2), 16) or 0; g = tonumber(h:sub(3, 4), 16) or 0; b = tonumber(h:sub(5, 6), 16) or 0; if #h >= 8 then a = (tonumber(h:sub(7, 8), 16) or 255) / 255 end
    end
  else
    local n = {}
    for v, pct in t:gmatch("([%d%.%-]+)(%%?)") do local x = tonumber(v); if x then n[#n + 1] = { x, pct == "%" } end end
    if t:sub(1, 3) == "hsl" then
      r, g, b = hsl(n[1] and n[1][1] or 0, n[2] and n[2][1] or 0, n[3] and n[3][1] or 0)
    else
      local function canal(k) local x = n[k]; if not x then return 0 end; if x[2] then return x[1] * 2.55 end; return x[1] end
      r, g, b = canal(1), canal(2), canal(3)
    end
    if n[4] then a = n[4][2] and n[4][1] / 100 or n[4][1] end
  end
  r = max(0, min(255, floor(r + .5))); g = max(0, min(255, floor(g + .5))); b = max(0, min(255, floor(b + .5))); a = max(0, min(1, a))
  c = { r, g, b, a }
  nCache = nCache + 1
  if nCache > 20000 then cache = {}; nCache = 0 end
  cache[s] = c
  return c
end
C.cor = cor

-- matrizes 2D [a b c d e f] como no canvas
local function mul(m, a, b, c, d, e, f) return { m[1] * a + m[3] * b, m[2] * a + m[4] * b, m[1] * c + m[3] * d, m[2] * c + m[4] * d, m[1] * e + m[3] * f + m[5], m[2] * e + m[4] * f + m[6] } end
local function inv(m) local det = m[1] * m[4] - m[2] * m[3]; if det == 0 then return nil end; local id = 1 / det
  return { m[4] * id, -m[2] * id, -m[3] * id, m[1] * id, (m[3] * m[6] - m[4] * m[5]) * id, (m[2] * m[5] - m[1] * m[6]) * id } end

-- degradês
local function novoDegrade(tipo, a) local g = { __grad = tipo, p = a, stops = {} }
  g.addColorStop = function(_, o, s) local c = cor(s) or { 0, 0, 0, 0 }; table.insert(g.stops, { tonumber(o) or 0, c }); table.sort(g.stops, function(x, y) return x[1] < y[1] end); g._lut = nil end
  return g end
local function amostra(g, t)
  local st = g.stops; local n = #st; if n == 0 then return 0, 0, 0, 0 end
  if t <= st[1][1] then local c = st[1][2]; return c[1], c[2], c[3], c[4] end
  if t >= st[n][1] then local c = st[n][2]; return c[1], c[2], c[3], c[4] end
  for i = 2, n do if t <= st[i][1] then local a, b = st[i - 1], st[i]; local k = (t - a[1]) / max(1e-9, b[1] - a[1]); local x, y = a[2], b[2]
    return x[1] + (y[1] - x[1]) * k, x[2] + (y[2] - x[2]) * k, x[3] + (y[3] - x[3]) * k, x[4] + (y[4] - x[4]) * k end end
  local c = st[n][2]; return c[1], c[2], c[3], c[4]
end
local function corDoDegrade(g, ux, uy)
  local p = g.p
  if g.__grad == "linear" then local dx, dy = p[3] - p[1], p[4] - p[2]; local L = dx * dx + dy * dy; local t = L > 0 and ((ux - p[1]) * dx + (uy - p[2]) * dy) / L or 0; return amostra(g, t) end
  -- radial (x0,y0,r0,x1,y1,r1): círculos quase concêntricos, como o jogo usa
  local d = sqrt((ux - p[4]) ^ 2 + (uy - p[5]) ^ 2); local r0, r1 = p[3], p[6]; local t = (d - r0) / max(1e-9, r1 - r0); return amostra(g, t)
end

-- mistura de um pixel (v = pixel atual) com a cor r,g,b (0..255) e opacidade a (0..1), conforme a operação
local function misturar(op, v, r, g, b, a)
  local da = v // 16777216
  local dr, dg, db = v % 256, v // 256 % 256, v // 65536 % 256
  local nr, ng, nb, na
  if op == "lighter" then
    nr = min(255, dr * da / 255 + r * a); ng = min(255, dg * da / 255 + g * a); nb = min(255, db * da / 255 + b * a); na = min(1, da / 255 + a)
    if na > 0 then local k = 1 / na; nr = min(255, nr * k); ng = min(255, ng * k); nb = min(255, nb * k) end
  elseif op == "destination-out" then return dr + dg * 256 + db * 65536 + floor(da * (1 - a) + .5) * 16777216
  elseif op == "destination-in" then return dr + dg * 256 + db * 65536 + floor(da * a + .5) * 16777216
  elseif op == "source-atop" then
    if da == 0 then return v end
    local k = 1 - a; nr = r * a + dr * k; ng = g * a + dg * k; nb = b * a + db * k; na = da / 255
  elseif op == "destination-over" then
    local A = da / 255; local oa = A + a * (1 - A); if oa <= 0 then return v end
    nr = (dr * A + r * a * (1 - A)) / oa; ng = (dg * A + g * a * (1 - A)) / oa; nb = (db * A + b * a * (1 - A)) / oa; na = oa
  elseif op == "copy" then nr, ng, nb, na = r, g, b, a
  else
    local sr, sg, sb = r, g, b
    if op == "screen" then sr = 255 - (255 - dr) * (255 - r) / 255; sg = 255 - (255 - dg) * (255 - g) / 255; sb = 255 - (255 - db) * (255 - b) / 255
    elseif op == "multiply" then sr = dr * r / 255; sg = dg * g / 255; sb = db * b / 255
    elseif op == "overlay" then
      local function ov(d, s) if d < 128 then return 2 * d * s / 255 end; return 255 - 2 * (255 - d) * (255 - s) / 255 end
      sr = ov(dr, r); sg = ov(dg, g); sb = ov(db, b)
    elseif op == "darken" then sr = min(dr, r); sg = min(dg, g); sb = min(db, b)
    elseif op == "lighten" then sr = max(dr, r); sg = max(dg, g); sb = max(db, b)
    elseif op == "soft-light" or op == "hard-light" or op == "color-dodge" or op == "color-burn" then
      local function ov(d, s) if s < 128 then return 2 * d * s / 255 end; return 255 - 2 * (255 - d) * (255 - s) / 255 end
      sr = ov(dr, r); sg = ov(dg, g); sb = ov(db, b)
    end
    if op ~= "source-over" and da > 0 then
      -- modos de mistura: onde já há cor, usa a cor misturada; onde não há, a cor original
      local A = da / 255
      sr = sr * A + r * (1 - A); sg = sg * A + g * (1 - A); sb = sb * A + b * (1 - A)
    end
    if da == 0 then nr, ng, nb, na = sr, sg, sb, a
    elseif da == 255 then local k = 1 - a; nr = sr * a + dr * k; ng = sg * a + dg * k; nb = sb * a + db * k; na = 1
    else local A = da / 255; local oa = a + A * (1 - a); if oa <= 0 then return v end; local k = A * (1 - a)
      nr = (sr * a + dr * k) / oa; ng = (sg * a + dg * k) / oa; nb = (sb * a + db * k) / oa; na = oa end
  end
  return floor(nr + .5) + floor(ng + .5) * 256 + floor(nb + .5) * 65536 + floor(na * 255 + .5) * 16777216
end
C.misturar = misturar
-- uma função de mistura por operação (escolhida uma vez por desenho, não a cada pixel)
-- cada uma recebe o pixel atual v e a cor r,g,b (0..255) com opacidade a (0..1) e devolve o novo pixel
local function pack(r, g, b, a) return floor(r + .5) + floor(g + .5) * 256 + floor(b + .5) * 65536 + floor(a * 255 + .5) * 16777216 end
local function sobre(v, r, g, b, a)
  if a >= 1 then return floor(r + .5) + floor(g + .5) * 256 + floor(b + .5) * 65536 + OPACO end
  if v >= OPACO then local k = 1 - a; return floor(r * a + (v % 256) * k + .5) + floor(g * a + (v // 256 % 256) * k + .5) * 256 + floor(b * a + (v // 65536 % 256) * k + .5) * 65536 + OPACO end
  if v < 16777216 then return pack(r, g, b, a) end
  return misturar("source-over", v, r, g, b, a)
end
-- modo de mistura separável (multiply, screen...): f(d, s) por canal, só onde o fundo é opaco é o caminho rápido
local function modoSeparavel(nome, f)
  -- tabela pronta f(d, s) para os 65536 pares (calculada na primeira vez que o modo é usado)
  local T
  return function(v, r, g, b, a)
    if v >= OPACO then
      if not T then T = {}; for s0 = 0, 255 do for d0 = 0, 255 do T[s0 * 256 + d0] = f(d0, s0) end end end
      local dr, dg, db = v % 256, v // 256 % 256, v // 65536 % 256
      local k = 1 - a
      return floor(T[floor(r + .5) * 256 + dr] * a + dr * k + .5) + floor(T[floor(g + .5) * 256 + dg] * a + dg * k + .5) * 256 + floor(T[floor(b + .5) * 256 + db] * a + db * k + .5) * 65536 + OPACO
    end
    return misturar(nome, v, r, g, b, a)
  end
end
local function softLight(d, s)
  d = d / 255; s = s / 255
  local r
  if s <= .5 then r = d - (1 - 2 * s) * d * (1 - d)
  else local D = d <= .25 and ((16 * d - 12) * d + 4) * d or sqrt(d); r = d + (2 * s - 1) * (D - d) end
  return r * 255
end
local function overlay(d, s) if d < 128 then return 2 * d * s / 255 end; return 255 - 2 * (255 - d) * (255 - s) / 255 end
local function hardLight(d, s) return overlay(s, d) end
local MODOS = {
  ["lighter"] = function(v, r, g, b, a)
    if v >= OPACO then local x, y, z = (v % 256) + r * a, (v // 256 % 256) + g * a, (v // 65536 % 256) + b * a
      return floor((x > 255 and 255 or x) + .5) + floor((y > 255 and 255 or y) + .5) * 256 + floor((z > 255 and 255 or z) + .5) * 65536 + OPACO end
    return misturar("lighter", v, r, g, b, a)
  end,
  ["multiply"] = modoSeparavel("multiply", function(d, s) return d * s / 255 end),
  ["screen"] = modoSeparavel("screen", function(d, s) return 255 - (255 - d) * (255 - s) / 255 end),
  ["overlay"] = modoSeparavel("overlay", overlay),
  ["soft-light"] = modoSeparavel("soft-light", softLight),
  ["hard-light"] = modoSeparavel("hard-light", hardLight),
  ["darken"] = modoSeparavel("darken", function(d, s) return d < s and d or s end),
  ["lighten"] = modoSeparavel("lighten", function(d, s) return d > s and d or s end),
  ["color-dodge"] = modoSeparavel("color-dodge", function(d, s) if s >= 255 then return 255 end; local x = d * 255 / (255 - s); return x > 255 and 255 or x end),
  ["color-burn"] = modoSeparavel("color-burn", function(d, s) if s <= 0 then return 0 end; local x = 255 - (255 - d) * 255 / s; return x < 0 and 0 or x end),
  ["difference"] = modoSeparavel("difference", function(d, s) return abs(d - s) end),
  ["exclusion"] = modoSeparavel("exclusion", function(d, s) return d + s - 2 * d * s / 255 end),
  ["source-atop"] = function(v, r, g, b, a)
    if v < 16777216 then return v end
    local da = v // 16777216; local k = 1 - a
    return floor(r * a + (v % 256) * k + .5) + floor(g * a + (v // 256 % 256) * k + .5) * 256 + floor(b * a + (v // 65536 % 256) * k + .5) * 65536 + da * 16777216
  end,
  ["source-in"] = function(v, r, g, b, a)
    local da = v // 16777216
    if da == 0 then return 0 end
    return floor(r + .5) + floor(g + .5) * 256 + floor(b + .5) * 65536 + floor(a * da + .5) * 16777216
  end,
  ["source-out"] = function(v, r, g, b, a) local da = v // 16777216; return floor(r + .5) + floor(g + .5) * 256 + floor(b + .5) * 65536 + floor(a * (255 - da) + .5) * 16777216 end,
  ["destination-out"] = function(v, r, g, b, a) return v % 16777216 + floor((v // 16777216) * (1 - a) + .5) * 16777216 end,
  ["destination-in"] = function(v, r, g, b, a) return v % 16777216 + floor((v // 16777216) * a + .5) * 16777216 end,
  ["destination-atop"] = function(v, r, g, b, a) return misturar("destination-over", v, r, g, b, a) end,
  ["destination-over"] = function(v, r, g, b, a) return misturar("destination-over", v, r, g, b, a) end,
  ["copy"] = function(v, r, g, b, a) return pack(r, g, b, a) end,
  ["xor"] = function(v, r, g, b, a) return misturar("source-over", v, r, g, b, a) end,
}
MODOS["source-over"] = sobre
local function modoDe(op) if not op then return sobre end; return MODOS[op] or sobre end
local function misturarOp(op, v, r, g, b, a) return modoDe(op)(v, r, g, b, a) end
C.sobre = sobre
-- degradê em tabela de 256 cores (calcula uma vez por degradê)
local function lutDe(g)
  local L = g._lut
  if L then return L end
  local R, G, B, A = {}, {}, {}, {}
  for k = 0, 255 do local r, gg, b, a = amostra(g, k / 255); R[k] = r; G[k] = gg; B[k] = b; A[k] = a end
  L = { R, G, B, A }; g._lut = L
  return L
end

-- cria um canvas (largura/altura mudam pelo próprio objeto, como no navegador)
function C.novo(w, h)
  local cv, priv = {}, { w = max(0, floor(tonumber(w) or 300)), h = max(0, floor(tonumber(h) or 150)) }
  local function limpar() priv.px = criarTabela(priv.w * priv.h, 0) end
  limpar(); priv.limpar = limpar
  priv.versao = 0
  setmetatable(cv, {
    __index = function(_, k) if k == "width" then return priv.w elseif k == "height" then return priv.h elseif k == "_" then return priv end end,
    __newindex = function(t, k, v) if k == "width" or k == "height" then priv[k == "width" and "w" or "h"] = max(0, floor(tonumber(v) or 0)); limpar(); if priv.ctx then priv.ctx.__reset() end else rawset(t, k, v) end end,
  })
  cv.getContext = function(_, tipo) if tipo ~= nil and tipo ~= "2d" then return nil end; if not priv.ctx then priv.ctx = C.contexto(cv) end; return priv.ctx end
  cv.toDataURL = function() return "data:," end
  cv.toBlob = function(_, cb) if type(cb) == "function" then cb(nil, nil) end end
  cv.transferControlToOffscreen = function() return cv end
  return cv
end

function C.contexto(cv)
  local api = {}
  local P = cv._
  local ctx = {}
  local m, pilha, sub, caminho, clipRect, clipMask = { 1, 0, 0, 1, 0, 0 }, {}, nil, {}, nil, nil
  local function padroes() ctx.fillStyle = "#000000"; ctx.strokeStyle = "#000000"; ctx.lineWidth = 1; ctx.lineCap = "butt"; ctx.lineJoin = "miter"; ctx.globalAlpha = 1; ctx.globalCompositeOperation = "source-over"
    ctx.font = "10px sans-serif"; ctx.textAlign = "start"; ctx.textBaseline = "alphabetic"; ctx.imageSmoothingEnabled = true; ctx.filter = "none"; ctx.shadowBlur = 0; ctx.shadowColor = "rgba(0,0,0,0)"; ctx.shadowOffsetX = 0; ctx.shadowOffsetY = 0; ctx.lineDashOffset = 0
    ctx.letterSpacing = "0px"; ctx.direction = "ltr"; ctx.miterLimit = 10; ctx.imageSmoothingQuality = "low"; ctx.fontKerning = "auto" end
  padroes(); ctx.canvas = cv
  ctx.__reset = function() m = { 1, 0, 0, 1, 0, 0 }; pilha = {}; caminho = {}; sub = nil; clipRect = nil; clipMask = nil; padroes() end
  local function opAtual() local op = ctx.globalCompositeOperation; if op == "source-over" or op == nil then return nil end; return op end
  local function alfaGlobal() local ga = tonumber(ctx.globalAlpha) or 1; if ga ~= ga then return 1 end; return max(0, min(1, ga)) end

  -- preenche uma faixa horizontal [x0, x1] na linha y com o estilo dado
  local function faixa(y, x0, x1, estilo, ga, im, op)
    local W = P.w
    if y < 0 or y >= P.h then return end
    if x0 < 0 then x0 = 0 end; if x1 > W - 1 then x1 = W - 1 end
    local cr = clipRect
    if cr then if x0 < cr[1] then x0 = cr[1] end; if x1 > cr[3] - 1 then x1 = cr[3] - 1 end; if y < cr[2] or y >= cr[4] then return end end
    if x1 < x0 then return end
    local px, base, cm = P.px, y * W + 1, clipMask
    if estilo.__grad then
      local L = lutDe(estilo); local LR, LG, LB, LA = L[1], L[2], L[3], L[4]
      local mx = modoDe(op)
      local p = estilo.p
      local ux, uy, dux, duy = x0 + .5, y + .5, 1, 0
      if im then ux, uy = im[1] * (x0 + .5) + im[3] * (y + .5) + im[5], im[2] * (x0 + .5) + im[4] * (y + .5) + im[6]; dux, duy = im[1], im[2] end
      if estilo.__grad == "linear" then
        local gx, gy = p[3] - p[1], p[4] - p[2]; local Lq = gx * gx + gy * gy
        local t, dt = 0, 0
        if Lq > 0 then t = ((ux - p[1]) * gx + (uy - p[2]) * gy) / Lq; dt = (dux * gx + duy * gy) / Lq end
        for x = x0, x1 do local i = base + x
          if not cm or cm[i] then
            local k = floor(t * 255 + .5); if k < 0 then k = 0 elseif k > 255 then k = 255 end
            local a = LA[k] * ga
            if a > 0 then px[i] = mx(px[i], LR[k], LG[k], LB[k], a) end
          end
          t = t + dt
        end
      else
        local cx, cy, r0 = p[4], p[5], p[3]; local dr = p[6] - r0; if dr < 1e-9 then dr = 1e-9 end
        for x = x0, x1 do local i = base + x
          if not cm or cm[i] then
            local ex, ey = ux - cx, uy - cy
            local k = floor((sqrt(ex * ex + ey * ey) - r0) / dr * 255 + .5); if k < 0 then k = 0 elseif k > 255 then k = 255 end
            local a = LA[k] * ga
            if a > 0 then px[i] = mx(px[i], LR[k], LG[k], LB[k], a) end
          end
          ux = ux + dux; uy = uy + duy
        end
      end
      return
    end
    local r, g, b, a = estilo[1], estilo[2], estilo[3], estilo[4] * ga
    if a <= 0 and op ~= "copy" and op ~= "destination-in" then return end
    if not op and a >= 1 then
      local col = r + g * 256 + b * 65536 + OPACO
      if cm then for x = x0, x1 do local i = base + x; if cm[i] then px[i] = col end end
      else for i = base + x0, base + x1 do px[i] = col end end
      return
    end
    local o = op or "source-over"
    if not op then
      -- source-over translúcido: caminho mais curto quando o fundo já é opaco
      local k = 1 - a; local ra, ga2, ba = r * a, g * a, b * a
      for x = x0, x1 do local i = base + x
        if not cm or cm[i] then
          local v = px[i]
          if v >= OPACO then
            px[i] = floor(ra + (v % 256) * k + .5) + floor(ga2 + (v // 256 % 256) * k + .5) * 256 + floor(ba + (v // 65536 % 256) * k + .5) * 65536 + OPACO
          else px[i] = misturar(o, v, r, g, b, a) end
        end
      end
      return
    end
    local mx = modoDe(op)
    for x = x0, x1 do local i = base + x; if not cm or cm[i] then px[i] = mx(px[i], r, g, b, a) end end
  end
  local function estiloDe(s) if type(s) == "table" and s.__grad then return s end; return cor(s) or { 0, 0, 0, 1 } end

  -- polígonos (lista de subcaminhos com pontos já no espaço do canvas) pela regra nonzero/evenodd
  local function preencherPoligonos(polys, estilo, regra, alvo)
    local ymin, ymax = huge, -huge
    local arestas, na = {}, 0
    for _, pts in ipairs(polys) do local n = #pts
      if n >= 3 then for k = 1, n do local a, b = pts[k], pts[k % n + 1]; if a[2] ~= b[2] then
        local dir = a[2] < b[2] and 1 or -1; local y0, y1 = min(a[2], b[2]), max(a[2], b[2])
        na = na + 1; arestas[na] = { a[1], a[2], b[1], b[2], dir, y0, y1 }
        if y0 < ymin then ymin = y0 end; if y1 > ymax then ymax = y1 end end end end end
    if na == 0 then return end
    local ya, yb = max(0, floor(ymin)), min(P.h - 1, ceil(ymax))
    local im = (not alvo and type(estilo) == "table" and estilo.__grad) and inv(m) or nil
    local ga, op = alfaGlobal(), opAtual()
    local W = P.w
    local xs, ds = {}, {}
    for y = ya, yb do
      local cy = y + .5; local k = 0
      for j = 1, na do local e = arestas[j]
        if cy >= e[6] and cy < e[7] then
          k = k + 1; local x = e[1] + (e[3] - e[1]) * ((cy - e[2]) / (e[4] - e[2]))
          -- inserção ordenada (poucas arestas por linha)
          local p = k
          while p > 1 and xs[p - 1] > x do xs[p] = xs[p - 1]; ds[p] = ds[p - 1]; p = p - 1 end
          xs[p] = x; ds[p] = e[5]
        end
      end
      if k >= 2 then
        local w = 0
        for q = 1, k - 1 do
          if regra == "evenodd" then w = (w + 1) % 2 else w = w + ds[q] end
          if w ~= 0 then local x0, x1 = ceil(xs[q] - .5), floor(xs[q + 1] - .5)
            if alvo then local base = y * W + 1; for x = max(0, x0), min(W - 1, x1) do alvo[base + x] = true end else faixa(y, x0, x1, estilo, ga, im, op) end end
        end
      end
    end
  end

  -- caminhos
  local function pt(x, y) x = tonumber(x) or 0; y = tonumber(y) or 0; return { m[1] * x + m[3] * y + m[5], m[2] * x + m[4] * y + m[6] } end
  local function escalaAtual() return sqrt(abs(m[1] * m[4] - m[2] * m[3])) end
  ctx.beginPath = function() caminho = {}; sub = nil end
  ctx.moveTo = function(x, y) sub = { pt(x, y) }; caminho[#caminho + 1] = sub; sub.u = { tonumber(x) or 0, tonumber(y) or 0 } end
  ctx.lineTo = function(x, y) if not sub then api.moveTo(x, y) return end; sub[#sub + 1] = pt(x, y); sub.u = { tonumber(x) or 0, tonumber(y) or 0 } end
  ctx.closePath = function() if sub and #sub > 0 then sub.fechado = true; local p0 = sub[1]; local novo = { p0 }; novo.u = sub.u0 or sub.u; caminho[#caminho + 1] = novo; sub = novo end end
  ctx.rect = function(x, y, w, h) api.moveTo(x, y); api.lineTo(x + w, y); api.lineTo(x + w, y + h); api.lineTo(x, y + h); api.closePath() end
  local function arco(cx, cy, rx, ry, rot, a0, a1, anti)
    rx, ry = abs(tonumber(rx) or 0), abs(tonumber(ry) or 0)
    cx, cy = tonumber(cx) or 0, tonumber(cy) or 0
    a0, a1 = tonumber(a0) or 0, tonumber(a1) or 0
    local cr, sr = cos(rot or 0), sin(rot or 0)
    if anti then if a0 - a1 >= 2 * pi then a1 = a0 - 2 * pi else while a1 > a0 do a1 = a1 - 2 * pi end end
    else if a1 - a0 >= 2 * pi then a1 = a0 + 2 * pi else while a1 < a0 do a1 = a1 + 2 * pi end end end
    local n = max(6, min(96, floor(max(rx, ry) * escalaAtual() * abs(a1 - a0) / 1.5)))
    for k = 0, n do local a = a0 + (a1 - a0) * k / n; local ex, ey = cos(a) * rx, sin(a) * ry; local x, y = cx + ex * cr - ey * sr, cy + ex * sr + ey * cr
      if k == 0 and sub then api.lineTo(x, y) elseif k == 0 then api.moveTo(x, y) else api.lineTo(x, y) end end
  end
  ctx.arc = function(x, y, r, a0, a1, anti) arco(x, y, r, r, 0, a0 or 0, a1 or 2 * pi, anti) end
  ctx.ellipse = function(x, y, rx, ry, rot, a0, a1, anti) arco(x, y, rx, ry, rot, a0 or 0, a1 or 2 * pi, anti) end
  ctx.quadraticCurveTo = function(cx, cy, x, y) local u = sub and sub.u or { cx, cy }; local x0, y0 = u[1], u[2]
    for k = 1, 12 do local t = k / 12; local a = (1 - t) ^ 2; local b = 2 * (1 - t) * t; local c = t * t; api.lineTo(a * x0 + b * cx + c * x, a * y0 + b * cy + c * y) end end
  ctx.bezierCurveTo = function(c1x, c1y, c2x, c2y, x, y) local u = sub and sub.u or { c1x, c1y }; local x0, y0 = u[1], u[2]
    for k = 1, 16 do local t = k / 16; local a = (1 - t) ^ 3; local b = 3 * (1 - t) ^ 2 * t; local c = 3 * (1 - t) * t * t; local d = t ^ 3
      api.lineTo(a * x0 + b * c1x + c * c2x + d * x, a * y0 + b * c1y + c * c2y + d * y) end end
  ctx.arcTo = function(x1, y1, x2, y2) api.lineTo(x1, y1); api.lineTo(x2, y2) end -- aproximação (cantos arredondados pequenos)
  ctx.roundRect = function(x, y, w, h, r)
    x, y, w, h = tonumber(x) or 0, tonumber(y) or 0, tonumber(w) or 0, tonumber(h) or 0
    if type(r) == "table" then r = tonumber(r[1]) or 0 else r = tonumber(r) or 0 end
    r = min(r, abs(w) / 2, abs(h) / 2)
    if r <= 0 then return api.rect(x, y, w, h) end
    api.moveTo(x + r, y); api.lineTo(x + w - r, y); arco(x + w - r, y + r, r, r, 0, -pi / 2, 0); api.lineTo(x + w, y + h - r); arco(x + w - r, y + h - r, r, r, 0, 0, pi / 2)
    api.lineTo(x + r, y + h); arco(x + r, y + h - r, r, r, 0, pi / 2, pi); api.lineTo(x, y + r); arco(x + r, y + r, r, r, 0, pi, 3 * pi / 2); api.closePath() end
  local function poligonosDoCaminho() local polys = {}; for _, s in ipairs(caminho) do if #s >= 3 then polys[#polys + 1] = s end end; return polys end
  ctx.fill = function(a, b) local regra = type(a) == "string" and a or (type(b) == "string" and b or "nonzero"); preencherPoligonos(poligonosDoCaminho(), estiloDe(ctx.fillStyle), regra) end

  -- pinta uma máscara (pixels marcados) com um estilo
  local function pintarMascara(alvo, e)
    local ga, op = alfaGlobal(), opAtual()
    local im = e.__grad and inv(m) or nil
    local W, px, cr, cm = P.w, P.px, clipRect, clipMask
    for i in pairs(alvo) do
      local x, y = (i - 1) % W, (i - 1) // W
      if (not cr or (x >= cr[1] and x < cr[3] and y >= cr[2] and y < cr[4])) and (not cm or cm[i]) then
        local r, g, b, a
        if e.__grad then local ux, uy = x + .5, y + .5; if im then ux, uy = im[1] * ux + im[3] * uy + im[5], im[2] * ux + im[4] * uy + im[6] end; r, g, b, a = corDoDegrade(e, ux, uy)
        else r, g, b, a = e[1], e[2], e[3], e[4] end
        a = a * ga
        if a > 0 then
          px[i] = misturarOp(op, px[i], r, g, b, a)
        end
      end
    end
  end
  -- traço: cada segmento vira um quadrilátero; todos entram numa máscara e pintam uma vez só
  ctx.stroke = function()
    local lw = (tonumber(ctx.lineWidth) or 1) * escalaAtual() / 2; if lw <= 0 then return end
    local alvo = {}
    local cap, join = ctx.lineCap, ctx.lineJoin
    for _, s in ipairs(caminho) do
      for k = 1, #s - 1 do local a, b = s[k], s[k + 1]; local dx, dy = b[1] - a[1], b[2] - a[2]; local L = sqrt(dx * dx + dy * dy)
        if L > 0 then local nx, ny = -dy / L * lw, dx / L * lw; local ex, ey = 0, 0; if cap == "square" then ex, ey = dx / L * lw, dy / L * lw end
          preencherPoligonos({ { { a[1] + nx - ex, a[2] + ny - ey }, { b[1] + nx + ex, b[2] + ny + ey }, { b[1] - nx + ex, b[2] - ny + ey }, { a[1] - nx - ex, a[2] - ny - ey } } }, nil, "nonzero", alvo) end end
      if (cap == "round" or join == "round") and lw > .8 then for k = 1, #s do local p = s[k]; local circ = {}
        for j = 0, 11 do local an = j / 12 * 2 * pi; circ[#circ + 1] = { p[1] + cos(an) * lw, p[2] + sin(an) * lw } end; preencherPoligonos({ circ }, nil, "nonzero", alvo) end end
      if s.fechado and #s > 2 then local a, b = s[#s], s[1]; local dx, dy = b[1] - a[1], b[2] - a[2]; local L = sqrt(dx * dx + dy * dy)
        if L > 0 then local nx, ny = -dy / L * lw, dx / L * lw; preencherPoligonos({ { { a[1] + nx, a[2] + ny }, { b[1] + nx, b[2] + ny }, { b[1] - nx, b[2] - ny }, { a[1] - nx, a[2] - ny } } }, nil, "nonzero", alvo) end end
    end
    pintarMascara(alvo, estiloDe(ctx.strokeStyle))
  end

  -- retângulos (caminho rápido quando não há rotação)
  local function retangulo(x, y, w, h, estilo, apagar)
    if w ~= w or h ~= h or x ~= x or y ~= y then return end
    if w < 0 then x = x + w; w = -w end; if h < 0 then y = y + h; h = -h end
    if m[2] == 0 and m[3] == 0 then
      local x0, y0 = m[1] * x + m[5], m[4] * y + m[6]; local x1, y1 = m[1] * (x + w) + m[5], m[4] * (y + h) + m[6]
      if x1 < x0 then x0, x1 = x1, x0 end; if y1 < y0 then y0, y1 = y1, y0 end
      local ax, bx, ay, by = ceil(x0 - .5), floor(x1 - .5), ceil(y0 - .5), floor(y1 - .5)
      if apagar then
        local W, px, cr, cm = P.w, P.px, clipRect, clipMask
        if cr then ax = max(ax, cr[1]); bx = min(bx, cr[3] - 1); ay = max(ay, cr[2]); by = min(by, cr[4] - 1) end
        ax = max(0, ax); bx = min(W - 1, bx)
        for yy = max(0, ay), min(P.h - 1, by) do local base = yy * W + 1
          if cm then for xx = ax, bx do local i = base + xx; if cm[i] then px[i] = 0 end end
          else for i = base + ax, base + bx do px[i] = 0 end end
        end
        return
      end
      local im = estilo.__grad and inv(m) or nil; local ga, op = alfaGlobal(), opAtual()
      if ay < 0 then ay = 0 end; if by > P.h - 1 then by = P.h - 1 end
      for yy = ay, by do faixa(yy, ax, bx, estilo, ga, im, op) end
    else
      local p = { pt(x, y), pt(x + w, y), pt(x + w, y + h), pt(x, y + h) }
      if apagar then local alvo = {}; preencherPoligonos({ p }, nil, "nonzero", alvo); local px = P.px; for i in pairs(alvo) do if not clipMask or clipMask[i] then px[i] = 0 end end return end
      preencherPoligonos({ p }, estilo, "nonzero")
    end
  end
  ctx.fillRect = function(x, y, w, h) retangulo(tonumber(x) or 0, tonumber(y) or 0, tonumber(w) or 0, tonumber(h) or 0, estiloDe(ctx.fillStyle)) end
  ctx.clearRect = function(x, y, w, h) retangulo(tonumber(x) or 0, tonumber(y) or 0, tonumber(w) or 0, tonumber(h) or 0, nil, true) end
  ctx.strokeRect = function(x, y, w, h) local c0, s0 = caminho, sub; api.beginPath(); api.rect(x, y, w, h); api.stroke(); caminho = c0; sub = s0 end

  -- recorte: retângulo sem rotação fica como limites; o resto vira máscara
  ctx.clip = function()
    local polys = poligonosDoCaminho()
    if #polys == 1 and #polys[1] == 5 and not clipMask then local p = polys[1]; local xs, ys = {}, {}
      for k = 1, 4 do xs[#xs + 1] = p[k][1]; ys[#ys + 1] = p[k][2] end
      local reto = (p[1][1] == p[4][1] and p[2][1] == p[3][1] and p[1][2] == p[2][2] and p[3][2] == p[4][2]) or (p[1][2] == p[4][2] and p[2][2] == p[3][2] and p[1][1] == p[2][1] and p[3][1] == p[4][1])
      if reto then local x0, x1 = ceil(min(xs[1], xs[2], xs[3], xs[4]) - .5), floor(max(xs[1], xs[2], xs[3], xs[4]) - .5) + 1; local y0, y1 = ceil(min(ys[1], ys[2], ys[3], ys[4]) - .5), floor(max(ys[1], ys[2], ys[3], ys[4]) - .5) + 1
        if clipRect then x0 = max(x0, clipRect[1]); y0 = max(y0, clipRect[2]); x1 = min(x1, clipRect[3]); y1 = min(y1, clipRect[4]) end
        clipRect = { x0, y0, x1, y1 }; return end
    end
    local alvo = {}; preencherPoligonos(polys, nil, "nonzero", alvo)
    if clipMask then for i in pairs(alvo) do if not clipMask[i] then alvo[i] = nil end end end
    if clipRect then local W = P.w; for i in pairs(alvo) do local x, y = (i - 1) % W, (i - 1) // W; if x < clipRect[1] or x >= clipRect[3] or y < clipRect[2] or y >= clipRect[4] then alvo[i] = nil end end end
    clipMask = alvo
  end

  -- estado e transformações
  local CAMPOS = { "fillStyle", "strokeStyle", "lineWidth", "lineCap", "lineJoin", "globalAlpha", "globalCompositeOperation", "font", "textAlign", "textBaseline", "imageSmoothingEnabled", "filter", "shadowBlur", "shadowColor", "shadowOffsetX", "shadowOffsetY", "letterSpacing" }
  ctx.save = function() local s = { m = m, clipRect = clipRect, clipMask = clipMask }; for _, k in ipairs(CAMPOS) do s[k] = ctx[k] end; pilha[#pilha + 1] = s end
  ctx.restore = function() local s = table.remove(pilha); if not s then return end; m = s.m; clipRect = s.clipRect; clipMask = s.clipMask; for _, k in ipairs(CAMPOS) do ctx[k] = s[k] end end
  local function n0(v, p) v = tonumber(v); if v == nil or v ~= v then return p end; return v end
  ctx.translate = function(x, y) m = mul(m, 1, 0, 0, 1, n0(x, 0), n0(y, 0)) end
  ctx.scale = function(x, y) x = n0(x, 1); m = mul(m, x, 0, 0, n0(y, x), 0, 0) end
  ctx.rotate = function(a) a = n0(a, 0); local c, s = cos(a), sin(a); m = mul(m, c, s, -s, c, 0, 0) end
  ctx.transform = function(a, b, c, d, e, f) m = mul(m, n0(a, 1), n0(b, 0), n0(c, 0), n0(d, 1), n0(e, 0), n0(f, 0)) end
  ctx.setTransform = function(a, b, c, d, e, f) if type(a) == "table" then m = { n0(a.a, 1), n0(a.b, 0), n0(a.c, 0), n0(a.d, 1), n0(a.e, 0), n0(a.f, 0) } else m = { n0(a, 1), n0(b, 0), n0(c, 0), n0(d, 1), n0(e, 0), n0(f, 0) } end end
  ctx.resetTransform = function() m = { 1, 0, 0, 1, 0, 0 } end
  ctx.getTransform = function() return { a = m[1], b = m[2], c = m[3], d = m[4], e = m[5], f = m[6], isIdentity = (m[1] == 1 and m[2] == 0 and m[3] == 0 and m[4] == 1 and m[5] == 0 and m[6] == 0) } end
  ctx.setLineDash = function() end; ctx.getLineDash = function() return {} end
  ctx.createLinearGradient = function(x0, y0, x1, y1) return novoDegrade("linear", { n0(x0, 0), n0(y0, 0), n0(x1, 0), n0(y1, 0) }) end
  ctx.createRadialGradient = function(x0, y0, r0, x1, y1, r1) return novoDegrade("radial", { n0(x0, 0), n0(y0, 0), n0(r0, 0), n0(x1, 0), n0(y1, 0), n0(r1, 0) }) end
  ctx.createConicGradient = function(_, x, y) return novoDegrade("radial", { n0(x, 0), n0(y, 0), 0, n0(x, 0), n0(y, 0), 1 }) end
  ctx.createPattern = function() return "#00000000" end
  ctx.isPointInPath = function() return false end
  ctx.isPointInStroke = function() return false end
  ctx.drawFocusIfNeeded = function() end

  -- imagens entre canvas (vizinho mais próximo, como o jogo usa)
  ctx.drawImage = function(img, a1, a2, a3, a4, a5, a6, a7, a8)
    if type(img) ~= "table" or not img._ then return end
    local S = img._; local sw0, sh0 = S.w, S.h; if sw0 == 0 or sh0 == 0 then return end
    local sx, sy, sw, sh, dx, dy, dw, dh
    if a5 ~= nil then sx, sy, sw, sh, dx, dy, dw, dh = a1, a2, a3, a4, a5, a6, a7, a8
    elseif a3 ~= nil then sx, sy, sw, sh, dx, dy, dw, dh = 0, 0, sw0, sh0, a1, a2, a3, a4
    else sx, sy, sw, sh, dx, dy, dw, dh = 0, 0, sw0, sh0, a1, a2, sw0, sh0 end
    sx, sy, sw, sh, dx, dy, dw, dh = n0(sx, 0), n0(sy, 0), n0(sw, 0), n0(sh, 0), n0(dx, 0), n0(dy, 0), n0(dw, 0), n0(dh, 0)
    if sw == 0 or sh == 0 or dw == 0 or dh == 0 then return end
    local ga, op = alfaGlobal(), opAtual()
    if ga <= 0 and op ~= "copy" then return end
    local SP, px, W, H = S.px, P.px, P.w, P.h
    local cm = clipMask
    local o = op or "source-over"
    if m[2] == 0 and m[3] == 0 and m[1] ~= 0 and m[4] ~= 0 then
      -- sem rotação: cada coluna e cada linha de destino sabem de que pixel da origem vêm
      local X0, X1 = m[1] * dx + m[5], m[1] * (dx + dw) + m[5]
      local Y0, Y1 = m[4] * dy + m[6], m[4] * (dy + dh) + m[6]
      local fx, fy = X1 < X0, Y1 < Y0
      if fx then X0, X1 = X1, X0 end; if fy then Y0, Y1 = Y1, Y0 end
      local ax, bx, ay, by = max(0, ceil(X0 - .5)), min(W - 1, floor(X1 - .5)), max(0, ceil(Y0 - .5)), min(H - 1, floor(Y1 - .5))
      if clipRect then ax = max(ax, clipRect[1]); bx = min(bx, clipRect[3] - 1); ay = max(ay, clipRect[2]); by = min(by, clipRect[4] - 1) end
      if bx < ax or by < ay then return end
      local kx, ky = sw / (X1 - X0), sh / (Y1 - Y0)
      local colunas = {}
      local s0x, s1x = max(0, sx), min(sw0, sx + sw)
      for x = ax, bx do local u = ((x + .5) - X0) * kx; if fx then u = sw - u end; u = sx + u
        if u >= s0x and u < s1x then colunas[x] = floor(u) else colunas[x] = -1 end end
      local s0y, s1y = max(0, sy), min(sh0, sy + sh)
      for y = ay, by do
        local v = ((y + .5) - Y0) * ky; if fy then v = sh - v end; v = sy + v
        if v >= s0y and v < s1y then
          local lin = floor(v) * sw0 + 1
          local base = y * W + 1
          if not op and ga >= 1 then
            for x = ax, bx do local c = colunas[x]
              if c >= 0 then local s = SP[lin + c]
                if s >= OPACO then local i = base + x; if not cm or cm[i] then px[i] = s end
                elseif s >= 16777216 then local i = base + x; if not cm or cm[i] then px[i] = sobre(px[i], s % 256, s // 256 % 256, s // 65536 % 256, (s // 16777216) / 255) end end
              end
            end
          else
            for x = ax, bx do local c = colunas[x]
              if c >= 0 then local s = SP[lin + c]
                if s >= 16777216 or o == "copy" or o == "destination-in" then local i = base + x
                  if not cm or cm[i] then px[i] = (o == "copy" or o == "destination-in") and misturar(o, px[i], s % 256, s // 256 % 256, s // 65536 % 256, (s // 16777216) / 255 * ga) or misturarOp(op, px[i], s % 256, s // 256 % 256, s // 65536 % 256, (s // 16777216) / 255 * ga) end end
              end
            end
          end
        end
      end
      return
    end
    -- com rotação: transformação inversa pixel a pixel
    local im = inv(m); if not im then return end
    local cs = { pt(dx, dy), pt(dx + dw, dy), pt(dx + dw, dy + dh), pt(dx, dy + dh) }
    local x0, x1, y0, y1 = huge, -huge, huge, -huge
    for _, p in ipairs(cs) do x0 = min(x0, p[1]); x1 = max(x1, p[1]); y0 = min(y0, p[2]); y1 = max(y1, p[2]) end
    local ax, bx, ay, by = max(0, ceil(x0 - .5)), min(W - 1, floor(x1 - .5)), max(0, ceil(y0 - .5)), min(H - 1, floor(y1 - .5))
    if clipRect then ax = max(ax, clipRect[1]); bx = min(bx, clipRect[3] - 1); ay = max(ay, clipRect[2]); by = min(by, clipRect[4] - 1) end
    local kx, ky = sw / dw, sh / dh
    for y = ay, by do local base = y * W + 1
      for x = ax, bx do local i = base + x
        if not cm or cm[i] then
          local ux, uy = im[1] * (x + .5) + im[3] * (y + .5) + im[5], im[2] * (x + .5) + im[4] * (y + .5) + im[6]
          local u, v = (ux - dx) * kx + sx, (uy - dy) * ky + sy
          if u >= sx and v >= sy and u < sx + sw and v < sy + sh then local ix, iy = floor(u), floor(v)
            if ix >= 0 and iy >= 0 and ix < sw0 and iy < sh0 then local s = SP[iy * sw0 + ix + 1]
              if s >= 16777216 then
                if not op and ga >= 1 and s >= OPACO then px[i] = s
                else px[i] = misturarOp(op, px[i], s % 256, s // 256 % 256, s // 65536 % 256, (s // 16777216) / 255 * ga) end
              end
            end
          end
        end
      end
    end
  end

  -- pixels crus (pixelfx e alguns efeitos usam isto)
  ctx.createImageData = function(w, h) if type(w) == "table" then w, h = w.width, w.height end; w, h = floor(w), floor(h); local d = C.novaLista(w * h * 4); return { width = w, height = h, data = d, colorSpace = "srgb" } end
  ctx.getImageData = function(x, y, w, h)
    x, y, w, h = floor(n0(x, 0)), floor(n0(y, 0)), floor(n0(w, 0)), floor(n0(h, 0))
    local d, W, px = C.novaLista(w * h * 4), P.w, P.px
    local k = 1
    for yy = y, y + h - 1 do for xx = x, x + w - 1 do
      if xx >= 0 and yy >= 0 and xx < W and yy < P.h then local v = px[yy * W + xx + 1]; rawset(d, k, v % 256); rawset(d, k + 1, v // 256 % 256); rawset(d, k + 2, v // 65536 % 256); rawset(d, k + 3, v // 16777216)
      else rawset(d, k, 0); rawset(d, k + 1, 0); rawset(d, k + 2, 0); rawset(d, k + 3, 0) end
      k = k + 4 end end
    return { width = w, height = h, data = d, colorSpace = "srgb" }
  end
  ctx.putImageData = function(img, x, y)
    local d, W, w, px = img.data, P.w, img.width, P.px
    x, y = floor(n0(x, 0)), floor(n0(y, 0))
    for yy = 0, img.height - 1 do for xx = 0, w - 1 do local X, Y = x + xx, y + yy
      if X >= 0 and Y >= 0 and X < W and Y < P.h then local k = (yy * w + xx) * 4 + 1
        local r, g, b, a = rawget(d, k) or 0, rawget(d, k + 1) or 0, rawget(d, k + 2) or 0, rawget(d, k + 3) or 0
        px[Y * W + X + 1] = floor(r) + floor(g) * 256 + floor(b) * 65536 + floor(a) * 16777216 end end end
  end

  -- texto: com as letras reais das fontes do jogo (C.fontes, vindas de fontes.lua) ou, sem elas, a fonte 5x7
  local function tamanhoFonte() local s = tostring(ctx.font or ""); local n = tonumber(s:match("(%d+%.?%d*)px")) or 10; local negrito = s:find("bold") ~= nil or s:find("[6789]00") ~= nil; return n, negrito end
  local function famDe() local f = tostring(ctx.font or ""); return C.fontes.familia(f, f:find("bold") and "bold" or f:match("([6789]00)")) end
  local function espaco() return tonumber(tostring(ctx.letterSpacing or "0"):match("(-?[%d%.]+)")) or 0 end
  ctx.measureText = function(t)
    local n = tamanhoFonte(); t = tostring(t)
    if C.fontes then local fam = famDe(); local w = C.fontes.medir(fam, n, t, espaco()); local a, d = C.fontes.metricas(fam, n)
      return { width = w, actualBoundingBoxAscent = a, actualBoundingBoxDescent = d, actualBoundingBoxLeft = 0, actualBoundingBoxRight = w, fontBoundingBoxAscent = a, fontBoundingBoxDescent = d } end
    local w = Fonte.largura(t, n); return { width = w, actualBoundingBoxAscent = n * .8, actualBoundingBoxDescent = n * .2, actualBoundingBoxLeft = 0, actualBoundingBoxRight = w, fontBoundingBoxAscent = n * .8, fontBoundingBoxDescent = n * .2 }
  end
  local function texto(t, x, y, estilo, maxW)
    t = tostring(t); local n, negrito = tamanhoFonte()
    if C.fontes then
      local fam = famDe(); local esp = espaco()
      local w = C.fontes.medir(fam, n, t, esp); local asc, desc = C.fontes.metricas(fam, n)
      local k = 1; if maxW and tonumber(maxW) and w > tonumber(maxW) and w > 0 then k = tonumber(maxW) / w end
      local al = ctx.textAlign; if al == "center" then x = x - w * k / 2 elseif al == "right" or al == "end" then x = x - w * k end
      local bl = ctx.textBaseline
      if bl == "top" or bl == "hanging" then y = y + asc elseif bl == "middle" then y = y + (asc - desc) / 2 elseif bl == "bottom" or bl == "ideographic" then y = y - desc end
      local niveis = {}
      local grad = estilo.__grad
      Fonte.semUso = nil
      C.fontes.escrever(fam, n, t, x, y, function(px, py, pw, ph, a)
        local nivel = floor(a * 15 + .5); if nivel <= 0 then return end
        local e = estilo
        if not grad then e = niveis[nivel]; if not e then e = { estilo[1], estilo[2], estilo[3], estilo[4] * nivel / 15 }; niveis[nivel] = e end end
        if k ~= 1 then px = x + (px - x) * k; pw = pw * k end
        retangulo(px, py, pw, ph, e)
      end, esp)
      return
    end
    local w = Fonte.largura(t, n); local esc = Fonte.escala(n)
    local al = ctx.textAlign; if al == "center" then x = x - w / 2 elseif al == "right" or al == "end" then x = x - w end
    local bl = ctx.textBaseline; local alto = 7 * esc
    if bl == "middle" then y = y - alto / 2 elseif bl == "top" or bl == "hanging" then y = y elseif bl == "bottom" or bl == "ideographic" then y = y - alto else y = y - alto + esc end
    Fonte.desenhar(t, x, y, n, function(px, py, pw, ph) retangulo(px, py, pw, ph, estilo); if negrito then retangulo(px + esc * .5, py, pw, ph, estilo) end end)
  end
  ctx.fillText = function(t, x, y, mw) texto(t, n0(x, 0), n0(y, 0), estiloDe(ctx.fillStyle), mw) end
  ctx.strokeText = function(t, x, y, mw) texto(t, n0(x, 0), n0(y, 0), estiloDe(ctx.strokeStyle), mw) end

  -- o jogo chama ctx:metodo(...) (com o próprio ctx na frente)
  for k, f in pairs(ctx) do if type(f) == "function" and k:sub(1, 2) ~= "__" then api[k] = f; ctx[k] = function(_, ...) return f(...) end end end
  return ctx
end

-- grava o canvas num arquivo PPM (usado pelos testes fora do Roblox)
function C.ppm(cv, arquivo)
  local P = cv._; local f = assert(io.open(arquivo, "wb")); f:write(("P6\n%d %d\n255\n"):format(P.w, P.h))
  local partes, px = {}, P.px
  for i = 1, P.w * P.h do local v = px[i]; local a = v // 16777216 / 255
    partes[#partes + 1] = string.char(floor((v % 256) * a + .5), floor((v // 256 % 256) * a + .5), floor((v // 65536 % 256) * a + .5))
    if #partes >= 4096 then f:write(table.concat(partes)); partes = {} end end
  f:write(table.concat(partes)); f:close()
end
return C
