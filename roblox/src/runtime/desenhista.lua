--[[ Desenha a página do jogo (HTML) dentro de um canvas de 960 x 540, igual ao navegador, a partir da
  "fotografia" da interface feita por ferramentas/capturar.mjs (interface.lua):
  - cada elemento visível tem a sua pele (fundo, borda, ícones) e o lugar dos textos;
  - o texto é o atual (vida, pontos, falas), escrito com as letras reais das fontes do jogo (fontes.lua);
  - os canvas do jogo (cena, título, retratos) são copiados para o lugar deles;
  - quem está visível segue o DOM (atributo hidden, display, <dialog open>) e o estado da tela (classes do body).
  Também informa ao navegador simulado onde cada elemento está (getBoundingClientRect) e quem está sob o dedo. ]]
local D = {}
local floor, max, min = math.floor, math.max, math.min

function D.iniciar(op)
  local N, Canvas, I, F = op.N, op.Canvas, op.interface, op.fontes
  local document = N.document
  local GET = N.GET
  local tela = Canvas.novo(960, 540)
  local ctx = tela:getContext("2d")
  D.tela = tela
  local modo = function() return N.toque and "toque" or "pc" end

  -- chave estável de cada elemento (a mesma do capturar.mjs)
  local chaves = setmetatable({}, { __mode = "k" })
  local versaoChaves = -1
  local function chave(el)
    if N.versao() ~= versaoChaves then chaves = setmetatable({}, { __mode = "k" }); versaoChaves = N.versao() end
    local c = chaves[el]; if c then return c end
    local id = el._attr and el._attr.id
    if id and id ~= "" then c = "#" .. id
    elseif el == document.body then c = "body"
    elseif el == document.documentElement then c = "html"
    else
      local pai = rawget(el, "_pai")
      if not pai or pai == document then c = el._tag or "?"
      else
        local i = 0
        for _, f in ipairs(pai._filhos) do if f == el then break end; if f.nodeType == 1 and f._tag == el._tag then i = i + 1 end end
        c = chave(pai) .. ">" .. el._tag .. ":" .. i
      end
    end
    chaves[el] = c
    return c
  end
  D.chave = chave

  -- peles decodificadas (uma vez cada)
  local peles = {}
  local function pele(id, w, h)
    local p = peles[id]; if p then return p end
    local cv = Canvas.novo(w, h); local px = cv._.px; local i = 1
    for parte in (I.peles[id] or ""):gmatch("[^,]+") do
      local n, v = parte:match("^(%w+)%*(%w+)$")
      if n then n = tonumber(n, 36); v = tonumber(v, 36) else n = 1; v = tonumber(parte, 36) end
      for _ = 1, n do px[i] = v; i = i + 1 end
    end
    peles[id] = cv
    return cv
  end

  -- estado da tela: o estado capturado mais parecido com as classes atuais do body e do #gameShell
  local function estadoAtual()
    local lista = I.estados[modo()]
    local atual = {}
    for c in pairs(document.body._cls) do atual[c] = true end
    local sh = document:getElementById("gameShell")
    if sh then for c in pairs(sh._cls) do atual["shell." .. c] = true end end
    local melhor, nota = 1, -1
    for i, e in ipairs(lista) do
      local comum, total = 0, 0
      for _, c in ipairs(e.assinatura) do total = total + 1; if atual[c] then comum = comum + 1 end end
      for c in pairs(atual) do local tem = false; for _, x in ipairs(e.assinatura) do if x == c then tem = true; break end end; if not tem then total = total + 1 end end
      local s = total > 0 and comum / total or 1
      if s > nota then nota = s; melhor = i end
    end
    return melhor
  end

  local function escondido(el)
    if el._attr.hidden ~= nil then return true end
    if el.style and rawget(el.style, "display") == "none" then return true end
    if el._tag == "dialog" and el._attr.open == nil then return true end
    if el.style and rawget(el.style, "visibility") == "hidden" then return true end
    return false
  end

  -- fontes: família pelo nome no CSS / no ctx.font
  local function familia(css, peso)
    css = (css or ""):lower()
    local f = css:find("pixel") and "pixel" or ((css:find("space") or css:find("studio")) and "space") or (css:find("mono") and "mono") or "arial"
    local negrito = peso and (peso == "bold" or (tonumber(peso) or 400) >= 600)
    if negrito and F[f .. "B"] then f = f .. "B" end
    return F[f] and f or "pixel"
  end
  local function tamanhoMaisPerto(fam, s)
    local t = F[fam]; if not t then return nil end
    if t[s] then return s, 1 end
    local melhor, d = nil, math.huge
    for k in pairs(t) do local dd = math.abs(k - s); if dd < d then d = dd; melhor = k end end
    return melhor, s / melhor
  end
  D.familia, D.tamanhoMaisPerto = familia, tamanhoMaisPerto

  -- texto com as letras capturadas: devolve a largura
  local cacheLetra = {}
  local function letras(t) local out = {}; for ch in tostring(t):gmatch("[\1-\127\192-\255][\128-\191]*") do out[#out + 1] = ch end; return out end
  function D.medir(fam, s, texto, esp)
    local tam, k = tamanhoMaisPerto(fam, s); if not tam then return 0 end
    local g = F[fam][tam].g; local w = 0
    for _, ch in ipairs(letras(texto)) do local x = g[ch] or g["?"]; w = w + (x and x[1] or s * .6) * k + (esp or 0) end
    return w
  end
  -- escreve em qualquer canvas (pixel(x, y, w, h, alfa) pinta um pontinho na cor certa)
  function D.escrever(fam, s, texto, x, y, pixel, esp)
    local tam, k = tamanhoMaisPerto(fam, s); if not tam then return 0 end
    local tab = F[fam][tam]; local g = tab.g
    local cx = x
    for _, ch in ipairs(letras(texto)) do
      local gl = g[ch] or g["?"]
      if gl then
        local adv, dx, dy, w, h, alfa = gl[1], gl[2], gl[3], gl[4], gl[5], gl[6]
        if w > 0 and alfa ~= "" then
          local i = 1
          for yy = 0, h - 1 do for xx = 0, w - 1 do
            local a = tonumber(alfa:sub(i, i), 16) or 0; i = i + 1
            if a > 0 then pixel(cx + (dx + xx) * k, y + (dy + yy) * k, k, k, a / 15) end
          end end
        end
        cx = cx + adv * k + (esp or 0)
      end
    end
    return cx - x
  end
  function D.metricas(fam, s) local tam, k = tamanhoMaisPerto(fam, s); if not tam then return s * .8, s * .2 end; local t = F[fam][tam]; return t.asc * k, t.desc * k end

  local function corCss(s)
    if type(s) ~= "string" then return nil end
    return Canvas.cor(s)
  end

  -- o que foi desenhado no último quadro (para o toque achar o elemento)
  local desenhados = {}
  local caixas = setmetatable({}, { __mode = "k" })
  N.caixa = function(el)
    local c = caixas[el]
    if c then return c end
    local r = I[modo()][chave(el)]
    if r then return { x = r.x, y = r.y, width = r.w, height = r.h } end
    if el == document.body or el == document.documentElement then return { x = 0, y = 0, width = 960, height = 540 } end
    return nil
  end
  N.elementoEm = function(x, y)
    for i = #desenhados, 1, -1 do local d = desenhados[i]; if x >= d.x and y >= d.y and x < d.x + d.w and y < d.y + d.h then return d.el end end
    return document.body
  end

  local function pixelDe(cor, alfa)
    return function(px, py, pw, ph, a)
      ctx.globalAlpha = alfa * a
      ctx.fillStyle = cor
      ctx:fillRect(px, py, pw, ph)
    end
  end

  -- desenha a página inteira no canvas da tela
  function D.desenhar()
    ctx.globalAlpha = 1; ctx.globalCompositeOperation = "source-over"
    ctx.fillStyle = "#000000"; ctx:fillRect(0, 0, 960, 540)
    local tab, idx = I[modo()], estadoAtual()
    local nomeEstado = I.estados[modo()][idx] and I.estados[modo()][idx].nome
    local lista = {}
    local function andar(el, zPai, opPai)
      if el.nodeType ~= 1 then return end
      if escondido(el) then return end
      local r = tab[chave(el)]
      local z = zPai
      if r then
        local v = r.vis and r.vis:sub(idx, idx) or "-"
        if v == "0" then return end
        if (r.z or 0) > z then z = r.z end
        lista[#lista + 1] = { el = el, r = r, z = z, n = #lista }
      end
      for _, f in ipairs(el._filhos) do andar(f, z, opPai) end
    end
    andar(document.documentElement, 0, 1)
    table.sort(lista, function(a, b) if a.z ~= b.z then return a.z < b.z end; return a.n < b.n end)
    desenhados = {}
    for _, item in ipairs(lista) do
      local el, r = item.el, item.r
      local x, y, w, h = r.x, r.y, r.w, r.h
      -- posição no estado atual da tela (o mesmo elemento pode mudar de lugar entre a tela inicial, o jogo e a pausa)
      local dx, dy = 0, 0
      local pe = r.estados and r.estados[nomeEstado]
      if pe then dx, dy = pe[1] - r.x, pe[2] - r.y; x, y = pe[1], pe[2]; if pe[3] then w, h = pe[3], pe[4] end end
      -- largura em % mudando (barras de vida, gás, xp)
      local sw = el.style and rawget(el.style, "width")
      if sw and tostring(sw):match("%%$") then local pai = rawget(el, "_pai"); local rp = pai and tab[chave(pai)]; if rp then w = rp.w * (tonumber(tostring(sw):match("^([%d%.]+)")) or 100) / 100 end end
      caixas[el] = { x = x, y = y, width = w, height = h }
      local op = r.op or 1
      if r.pele and r.pw and r.pw > 0 then
        local p = pele(r.pele, r.pw, r.ph)
        ctx.globalAlpha = 1
        if w ~= r.w and r.w > 0 then
          local k = w / r.w
          ctx:drawImage(p, 0, 0, max(1, r.pw * k), r.ph, r.px + dx, r.py + dy, max(1, r.pw * k), r.ph)
        else ctx:drawImage(p, r.px + dx, r.py + dy) end
      end
      if r.canvas and el._ then
        ctx.globalAlpha = op
        ctx:drawImage(el, x, y, w, h)
        ctx.globalAlpha = 1
      end
      if r.textos then
        local fam = familia(r.fonte, r.peso)
        local cor = (el.style and rawget(el.style, "color")) or r.cor or "#ffffff"
        local asc = D.metricas(fam, r.tam or 12)
        local k = 0
        for _, f in ipairs(el._filhos) do
          if f.nodeType == 3 and f._texto:match("%S") then
            k = k + 1
            local tr = r.textos[k] or r.textos[#r.textos]
            if tr then
              local t = f._texto:gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
              if r.maiusc then t = N.JS and N.JS.upper(t) or t:upper() end
              local larg = D.medir(fam, r.tam or 12, t, r.esp)
              local tx = tr.x + dx
              if r.alinha == "center" then tx = tr.x + dx + tr.w / 2 - larg / 2 elseif r.alinha == "right" or r.alinha == "end" then tx = tr.x + dx + tr.w - larg end
              local ty = tr.y + dy + ((tr.h / (tr.linhas or 1)) - (r.tam or 12)) / 2 + asc * .95
              if larg > tr.w * 1.05 and (tr.linhas or 1) > 1 then
                -- quebra simples em linhas dentro da caixa capturada
                local linha, ly = "", tr.y + asc
                local alt = tr.h / tr.linhas
                for palavra in t:gmatch("%S+") do
                  local teste = linha == "" and palavra or (linha .. " " .. palavra)
                  if D.medir(fam, r.tam or 12, teste, r.esp) > tr.w and linha ~= "" then D.escrever(fam, r.tam or 12, linha, tr.x, ly, pixelDe(cor, op), r.esp); ly = ly + alt; linha = palavra else linha = teste end
                end
                if linha ~= "" then D.escrever(fam, r.tam or 12, linha, tr.x, ly, pixelDe(cor, op), r.esp) end
              else
                if r.sombra and r.sombra ~= "" then D.escrever(fam, r.tam or 12, t, tx + 1, ty + 1, pixelDe("#000000", op * .6), r.esp) end
                D.escrever(fam, r.tam or 12, t, tx, ty, pixelDe(cor, op), r.esp)
              end
            end
          end
        end
      end
      if r.campo then
        local fam = familia(r.fonte, nil)
        D.escrever(fam, r.tam or 12, tostring(el.value or ""), x + 4, y + h / 2 + (r.tam or 12) * .35, pixelDe(r.cor or "#ffffff", 1))
      end
      desenhados[#desenhados + 1] = { el = el, x = x, y = y, w = w, h = h }
    end
    ctx.globalAlpha = 1
    return tela
  end

  -- texto do canvas do jogo com as letras reais (ctx.font = "bold 12px monospace" etc.)
  Canvas.textoComFonte = function(font, texto, pixel)
    local s = tonumber(tostring(font):match("(%d+%.?%d*)px")) or 10
    local peso = tostring(font):match("bold") and "bold" or tostring(font):match("([6789]00)")
    local fam = familia(font, peso)
    return fam, s
  end
  Canvas.fontes = { familia = familia, medir = D.medir, escrever = D.escrever, metricas = D.metricas }
  return D
end
return D
