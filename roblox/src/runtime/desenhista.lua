--!native
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
  -- As peles (fotos da interface) não mudam: cada uma é estudada uma vez, linha por linha, em faixas opacas,
  -- transparentes e semitransparentes. Depois, a cada quadro, as faixas opacas vão com cópia direta de memória,
  -- as transparentes são puladas e só os pixels semitransparentes são misturados. Antes era pixel a pixel (~0,1 s).
  local faixasDe = setmetatable({}, { __mode = "k" })
  local RD, WR, OPACO = Canvas.RD, Canvas.WR, 4278190080
  local function faixas(img)
    local f = faixasDe[img]; if f then return f end
    local S = img._; local w, h, px = S.w, S.h, S.px
    f = {}
    for y = 0, h - 1 do
      local linha, x = {}, 0
      while x < w do
        local v = RD(px, (y * w + x) * 4)
        local tipo = v >= OPACO and 1 or v >= 16777216 and 2 or 0
        local x0 = x
        repeat x = x + 1; local v2 = x < w and RD(px, (y * w + x) * 4) or -1; local t2 = v2 >= OPACO and 1 or v2 >= 16777216 and 2 or 0 until x >= w or t2 ~= tipo
        if tipo ~= 0 then linha[#linha + 1] = { x0, x - 1, tipo } end
      end
      f[y] = linha
    end
    faixasDe[img] = f
    return f
  end
  local copiarMem = buffer and buffer.copy or (table.move and function(dp, dof, sp, so, n) table.move(sp, so // 4 + 1, so // 4 + n // 4, dof // 4 + 1, dp) end)
  local function colarPele(img, ox, oy)
    ox, oy = math.floor(ox + .5), math.floor(oy + .5)
    local S, P = img._, tela._
    local sw, W, H, sp, dp = S.w, P.w, P.h, S.px, P.px
    local f = faixas(img)
    for y = 0, S.h - 1 do
      local dy = oy + y
      if dy >= 0 and dy < H then
        for _, fx in ipairs(f[y]) do
          local a, b = fx[1], fx[2]
          if ox + a < 0 then a = -ox end
          if ox + b > W - 1 then b = W - 1 - ox end
          if a <= b then
            local so, dof = (y * sw + a) * 4, (dy * W + ox + a) * 4
            if fx[3] == 1 then
              if copiarMem then copiarMem(dp, dof, sp, so, (b - a + 1) * 4)
              else for k = 0, b - a do WR(dp, dof + k * 4, RD(sp, so + k * 4)) end end
            else
              for k = 0, b - a do
                local v = RD(sp, so + k * 4)
                WR(dp, dof + k * 4, Canvas.sobre(RD(dp, dof + k * 4), v % 256, v // 256 % 256, v // 65536 % 256, (v // 16777216) / 255))
              end
            end
          end
        end
      end
    end
  end
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
      for _ = 1, n do Canvas.WR(px, (i - 1) * 4, v); i = i + 1 end
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
  -- Textos da página: cada frase (fonte, tamanho, cor) vira uma imagem pequena feita uma vez e colada com as faixas
  -- (antes cada pixel de cada letra era um fillRect com mistura, a cada quadro). O cache esvazia quando passa de 400.
  local cacheTexto, nTexto = {}, 0
  local escreverDireto
  local function escreverGuardado(fam, s, texto, x, y, pixel, esp)
    local chave = fam .. "|" .. s .. "|" .. texto .. "|" .. pixel.cor .. "|" .. pixel.alfa .. "|" .. (esp or 0)
    local e = cacheTexto[chave]
    if not e then
      local tam, k = tamanhoMaisPerto(fam, s); if not tam then return 0 end
      local g = F[fam][tam].g
      local x0, x1, y0, y1, cx = 0, 1, 0, 1, 0
      for _, ch in ipairs(letras(texto)) do
        local gl = g[ch] or g["?"]
        if gl then
          if gl[4] > 0 then x0 = math.min(x0, cx + gl[2] * k); x1 = math.max(x1, cx + (gl[2] + gl[4]) * k); y0 = math.min(y0, gl[3] * k); y1 = math.max(y1, (gl[3] + gl[5]) * k) end
          cx = cx + gl[1] * k + (esp or 0)
        end
      end
      local ox, oy = math.ceil(-x0) + 1, math.ceil(-y0) + 1
      local img = Canvas.novo(math.max(1, math.ceil(x1 - x0) + 3), math.max(1, math.ceil(y1 - y0) + 3))
      local c2 = img:getContext("2d")
      local avanco = escreverDireto(fam, s, texto, ox, oy, function(px, py, pw, ph, a) c2.globalAlpha = pixel.alfa * a; c2.fillStyle = pixel.cor; c2:fillRect(px, py, pw, ph) end, esp)
      e = { img = img, ox = ox, oy = oy, avanco = avanco }
      if nTexto > 400 then cacheTexto, nTexto = {}, 0 end
      cacheTexto[chave] = e; nTexto = nTexto + 1
    end
    colarPele(e.img, x - e.ox, y - e.oy)
    return e.avanco
  end
  function D.escrever(fam, s, texto, x, y, pixel, esp)
    if type(pixel) == "table" and pixel.cor then return escreverGuardado(fam, s, texto, x, y, pixel, esp) end
    return escreverDireto(fam, s, texto, x, y, pixel, esp)
  end
  escreverDireto = function(fam, s, texto, x, y, pixel, esp)
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

  local ehJanela, desenharJanela
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
  D.todosEm = function(x, y) local out = {}; for i = #desenhados, 1, -1 do local d = desenhados[i]; if x >= d.x and y >= d.y and x < d.x + d.w and y < d.y + d.h then out[#out + 1] = chave(d.el) end end; return out end
  N.elementoEm = function(x, y)
    for i = #desenhados, 1, -1 do local d = desenhados[i]; if x >= d.x and y >= d.y and x < d.x + d.w and y < d.y + d.h then return d.el end end
    return document.body
  end

  -- cor de texto da página: uma tabela (cor, alfa) que o D.escrever reconhece e guarda como imagem pronta
  local function pixelDe(cor, alfa)
    return setmetatable({ cor = tostring(cor), alfa = alfa }, { __call = function(_, px, py, pw, ph, a)
      ctx.globalAlpha = alfa * a
      ctx.fillStyle = cor
      ctx:fillRect(px, py, pw, ph)
    end })
  end

  -- Janelas que a captura não fotografou (avisos e confirmações criados na hora, como o "Tá difícil demais?"):
  -- são desenhadas automaticamente num painel no estilo do jogo, com os textos e os botões clicáveis,
  -- para nenhuma janela aberta ficar invisível travando o jogo.
  ehJanela = function(el)
    if el._tag == "dialog" then return el._attr.open ~= nil end
    local role = el._attr.role
    return role == "dialog" or role == "alertdialog" or el._attr["aria-modal"] == "true"
  end
  local function limpo(t) return (tostring(t or ""):gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")) end
  local function coletar(el, out)
    if el.nodeType ~= 1 or escondido(el) then return end
    local tag = el._tag
    if tag == "svg" or tag == "style" or tag == "script" or tag == "template" then return end
    if tag == "button" or el._attr.role == "button" or (tag == "a" and el._attr.href) then
      local t = limpo(N.textoDe(el)); if t == "" then t = limpo(el._attr["aria-label"] or el._attr.title) end
      if t ~= "" then out[#out + 1] = { tipo = "botao", el = el, texto = t } end
      return
    end
    if tag == "input" or tag == "textarea" or tag == "select" then out[#out + 1] = { tipo = "campo", el = el }; return end
    if tag == "canvas" then if el._ and el.width > 0 then out[#out + 1] = { tipo = "canvas", el = el } end; return end
    local proprio = ""
    for _, f in ipairs(el._filhos) do if f.nodeType == 3 then proprio = proprio .. f._texto end end
    proprio = limpo(proprio)
    if proprio ~= "" then out[#out + 1] = { tipo = "texto", texto = proprio, titulo = tag == "h1" or tag == "h2" or tag == "h3" or tag == "strong", pequeno = tag == "small" } end
    for _, f in ipairs(el._filhos) do coletar(f, out) end
  end
  local function quebrar(fam, s, texto, larg)
    local linhas, linha = {}, ""
    for palavra in texto:gmatch("%S+") do
      local teste = linha == "" and palavra or (linha .. " " .. palavra)
      if linha ~= "" and D.medir(fam, s, teste) > larg then linhas[#linhas + 1] = linha; linha = palavra else linha = teste end
    end
    if linha ~= "" then linhas[#linhas + 1] = linha end
    return linhas
  end
  -- minigame (janela com um canvas): o canvas vira um telão grande e os botões ficam numa fileira embaixo
  local function desenharTelao(el, itens)
    local famT = familia("space", "bold")
    local cvs, botoes = nil, {}
    for _, it in ipairs(itens) do if it.tipo == "canvas" and not cvs then cvs = it elseif it.tipo == "botao" then botoes[#botoes + 1] = it end end
    local cw, ch = cvs.el.width, cvs.el.height
    local altB = #botoes > 0 and 46 or 0
    local k = math.min(920 / math.max(1, cw), (540 - altB - 24) / math.max(1, ch))
    local w, h = math.floor(cw * k), math.floor(ch * k)
    local x0, y0 = math.floor((960 - w) / 2), math.floor((540 - altB - h) / 2)
    ctx.globalAlpha = .92; ctx.fillStyle = "#07060c"; ctx:fillRect(0, 0, 960, 540); ctx.globalAlpha = 1
    ctx.fillStyle = "#e8c24a"; ctx:fillRect(x0 - 3, y0 - 3, w + 6, h + 6); ctx.fillStyle = "#2a1a0e"; ctx:fillRect(x0 - 1, y0 - 1, w + 2, h + 2)
    ctx:drawImage(cvs.el, x0, y0, w, h)
    caixas[el] = { x = 0, y = 0, width = 960, height = 540 }
    desenhados[#desenhados + 1] = { el = el, x = 0, y = 0, w = 960, h = 540 }
    if #botoes == 0 then return end
    local gap = 8
    local bw = math.min(170, math.floor((920 - gap * (#botoes - 1)) / #botoes))
    local total = bw * #botoes + gap * (#botoes - 1)
    local bx, by = math.floor((960 - total) / 2), y0 + h + 10
    for _, it in ipairs(botoes) do
      ctx.fillStyle = "#0a0614"; ctx:fillRect(bx - 2, by - 2, bw + 4, 40)
      ctx.fillStyle = "#3a2a4a"; ctx:fillRect(bx, by, bw, 36)
      ctx.fillStyle = "#5a4a6a"; ctx:fillRect(bx, by, bw, 3)
      ctx.fillStyle = "#1e1428"; ctx:fillRect(bx, by + 32, bw, 4)
      local SETAS = { ["←"] = "<", ["↓"] = "v", ["↑"] = "^", ["→"] = ">" } -- as setas Unicode não estão nas letras capturadas
      local texto = SETAS[it.texto] or it.texto
      local tam = #texto <= 3 and 18 or 13
      local tl = D.medir(famT, tam, texto)
      D.escrever(famT, tam, texto, bx + bw / 2 - tl / 2, by + 24, pixelDe("#fff6dc", 1))
      caixas[it.el] = { x = bx, y = by, width = bw, height = 36 }
      desenhados[#desenhados + 1] = { el = it.el, x = bx, y = by, w = bw, h = 36 }
      bx = bx + bw + gap
    end
  end
  desenharJanela = function(el)
    local itens = {}
    for _, f in ipairs(el._filhos) do coletar(f, itens) end
    for _, it in ipairs(itens) do if it.tipo == "canvas" and it.el.width >= 200 then return desenharTelao(el, itens) end end
    local L, pad = N.toque and 620 or 560, 22
    local famT, famN = familia("space", "bold"), familia("space")
    local larg = L - pad * 2
    local alt = pad
    for _, it in ipairs(itens) do
      it.canto = it.tipo == "botao" and #it.texto <= 3 -- "×", "?", "<": botão pequeno no canto do painel
      if it.canto then it.h = 0
      elseif it.tipo == "texto" then
        it.s = it.titulo and 18 or it.pequeno and 11 or 14; it.fam = it.titulo and famT or famN
        it.linhas = quebrar(it.fam, it.s, it.texto, larg); it.h = #it.linhas * math.floor(it.s * 1.4) + 6
      elseif it.tipo == "botao" then it.h = 44
      elseif it.tipo == "campo" then it.h = 40
      else it.k = math.min(1, 110 / math.max(1, it.el.height), larg / math.max(1, it.el.width)); it.h = math.floor(it.el.height * it.k) + 8 end
      alt = alt + it.h
    end
    alt = math.min(510, alt + pad)
    local x0, y0 = math.floor((960 - L) / 2), math.floor((540 - alt) / 2)
    ctx.globalAlpha = .6; ctx.fillStyle = "#0c141b"; ctx:fillRect(0, 0, 960, 540)
    ctx.globalAlpha = 1
    ctx.fillStyle = "#3e2816"; ctx:fillRect(x0 - 4, y0 - 4, L + 8, alt + 8)
    ctx.fillStyle = "#f3e3bf"; ctx:fillRect(x0, y0, L, alt)
    ctx.fillStyle = "#2f5a3e"; ctx:fillRect(x0, y0, L, 5)
    caixas[el] = { x = x0, y = y0, width = L, height = alt }
    desenhados[#desenhados + 1] = { el = el, x = x0, y = y0, w = L, h = alt }
    local y = y0 + pad
    local cantoX = x0 + L - 40
    for _, it in ipairs(itens) do
      if y + it.h > y0 + alt then break end
      ctx.globalAlpha = 1
      if it.canto then
        local bx, by = cantoX, y0 + 10
        ctx.fillStyle = "#6a4a2a"; ctx:fillRect(bx, by, 30, 30); ctx.fillStyle = "#f8edd2"; ctx:fillRect(bx + 2, by + 2, 26, 26)
        local tl = D.medir(famT, 16, it.texto); D.escrever(famT, 16, it.texto, bx + 15 - tl / 2, by + 21, pixelDe("#3e2816", 1))
        caixas[it.el] = { x = bx, y = by, width = 30, height = 30 }
        desenhados[#desenhados + 1] = { el = it.el, x = bx, y = by, w = 30, h = 30 }
        cantoX = cantoX - 36
      elseif it.tipo == "texto" then
        local asc = D.metricas(it.fam, it.s)
        for i, linha in ipairs(it.linhas) do D.escrever(it.fam, it.s, linha, x0 + pad, y + (i - 1) * math.floor(it.s * 1.4) + asc, pixelDe(it.titulo and "#2f4a36" or "#3a2a1a", 1)) end
      elseif it.tipo == "botao" then
        local bx, by, bw, bh = x0 + pad, y + 3, larg, 36
        ctx.fillStyle = "#8ba353"; ctx:fillRect(bx, by, bw, bh)
        ctx.fillStyle = "#c6dd86"; ctx:fillRect(bx, by, bw, bh - 4)
        local tl = D.medir(famT, 13, it.texto)
        D.escrever(famT, 13, it.texto, bx + bw / 2 - tl / 2, by + 23, pixelDe("#1d3021", 1))
        caixas[it.el] = { x = bx, y = by, width = bw, height = bh }
        desenhados[#desenhados + 1] = { el = it.el, x = bx, y = by, w = bw, h = bh }
      elseif it.tipo == "campo" then
        local bx, by, bw, bh = x0 + pad, y + 4, larg, 30
        ctx.fillStyle = "#6a5a40"; ctx:fillRect(bx, by, bw, bh); ctx.fillStyle = "#fffaf0"; ctx:fillRect(bx + 2, by + 2, bw - 4, bh - 4)
        D.escrever(famN, 14, tostring(it.el.value or ""), bx + 8, by + 20, pixelDe("#2a2a2a", 1))
        caixas[it.el] = { x = bx, y = by, width = bw, height = bh }
        desenhados[#desenhados + 1] = { el = it.el, x = bx, y = by, w = bw, h = bh }
      else
        local w, h = math.floor(it.el.width * it.k), math.floor(it.el.height * it.k)
        ctx:drawImage(it.el, x0 + pad, y + 4, w, h)
      end
      ctx.globalAlpha = 1
      y = y + it.h
    end
  end

  -- desenha a página inteira no canvas da tela
  -- Resumo do que a página mostra (elementos visíveis, textos, larguras, cores, janelas): se não mudou desde o último
  -- quadro, a interface não precisa ser desenhada de novo (no modo em camadas ela é uma imagem separada).
  -- O jogo mexe na página todo quadro (de 4 a 90 vezes), quase sempre gravando o mesmo valor.
  local ESTILOS = { "width", "height", "color", "opacity", "transform", "left", "top", "background", "backgroundColor" }
  local function resumoJanela(el, partes)
    for _, f in ipairs(el._filhos) do
      if f.nodeType == 3 then partes[#partes + 1] = f._texto
      elseif f.nodeType == 1 and not escondido(f) then
        if f._tag == "canvas" and f._ then return true end
        partes[#partes + 1] = "<" .. f._tag .. (f._attr.disabled and "d" or "") .. tostring(rawget(f, "_valor") or "")
        if resumoJanela(f, partes) then return true end
      end
    end
    return false
  end
  local function assinar(lista, janelas, idx)
    local partes, vivo = { modo(), idx }, false
    for _, item in ipairs(lista) do
      local el, r = item.el, item.r
      partes[#partes + 1] = "\0" .. chave(el)
      local st = el.style
      if st then for _, k in ipairs(ESTILOS) do local v = rawget(st, k); if v ~= nil then partes[#partes + 1] = k .. "=" .. tostring(v) end end end
      for _, f in ipairs(el._filhos) do if f.nodeType == 3 then partes[#partes + 1] = f._texto end end
      if r.campo then partes[#partes + 1] = tostring(el.value) end
      -- canvas que não ocupa a tela toda (minigame, prévia, logo): muda sozinho, a interface é redesenhada sempre
      if r.canvas and el._ and not (r.x == 0 and r.y == 0 and r.w == 960 and r.h == 540) then vivo = true end
    end
    for _, el in ipairs(janelas) do partes[#partes + 1] = "\1J"; if resumoJanela(el, partes) then vivo = true end end
    return table.concat(partes, "\2"), vivo
  end
  local ultimaAssinatura
  D.camadaJogo = nil

  -- op.camadas: a página vira uma camada transparente por cima do canvas do jogo (que o Roblox mostra numa imagem
  -- própria, D.camadaJogo); devolve a tela e se ela mudou desde a última vez.
  function D.desenhar(op)
    local camadas = op and op.camadas
    ctx.globalAlpha = 1; ctx.globalCompositeOperation = "source-over"
    local tab, idx = I[modo()], estadoAtual()
    local nomeEstado = I.estados[modo()][idx] and I.estados[modo()][idx].nome
    local lista, janelas = {}, {}
    local function andar(el, zPai, opPai)
      if el.nodeType ~= 1 then return end
      if escondido(el) then return end
      local r = tab[chave(el)]
      if not r and ehJanela(el) then janelas[#janelas + 1] = el; return end
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
    if camadas then
      local ass, vivo = assinar(lista, janelas, idx)
      if ass == ultimaAssinatura then return tela, false end
      ultimaAssinatura = not vivo and ass or nil
      ctx:clearRect(0, 0, 960, 540)
      D.camadaJogo = nil
    else
      ultimaAssinatura = nil
      ctx.fillStyle = "#000000"; ctx:fillRect(0, 0, 960, 540)
    end
    desenhados = {}
    local jaDesenhou = false
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
      -- texto maior que o da foto (avisos e etiquetas com texto novo): a caixa estica para caber, sem deformar as bordas
      local estica
      if r.pele and r.pele ~= "" and r.textos and #r.textos == 1 and r.pw and r.pw > 24 and r.ph > 16 then
        local so
        for _, f in ipairs(el._filhos) do if f.nodeType == 3 and f._texto:match("%S") then if so then so = nil; break end; so = f end end
        if so then
          local tr = r.textos[1]
          local t = so._texto:gsub("%s+", " "):gsub("^ ", ""):gsub(" $", "")
          if r.maiusc then t = N.JS and N.JS.upper(t) or t:upper() end
          local fam = familia(r.fonte, r.peso)
          local larg = D.medir(fam, r.tam or 12, t, r.esp)
          local folga = r.w - tr.w
          if larg > tr.w * (tr.linhas or 1) + 2 or math.abs(w - r.w) > 1 then
            local w2 = math.min(900, math.max(w, math.min(larg + folga, 860)))
            local linhas = math.max(1, math.ceil(larg / math.max(40, w2 - folga)))
            local altLinha = (tr.h / (tr.linhas or 1))
            local h2 = r.h + (linhas - (tr.linhas or 1)) * altLinha
            local cx = x + w / 2
            estica = { x = math.floor(cx - w2 / 2), y = y, w = w2, h = h2, t = t, fam = fam, linhas = linhas, altLinha = altLinha, folga = folga }
          end
        end
      end
      caixas[el] = estica and { x = estica.x, y = estica.y, width = estica.w, height = estica.h } or { x = x, y = y, width = w, height = h }
      local op = r.op or 1
      if estica then
        local p = pele(r.pele, r.pw, r.ph)
        local bx, by = r.px + dx - x, r.py + dy - y -- sombra/borda que a pele tem fora da caixa
        local W2, H2 = r.pw + (estica.w - r.w), r.ph + (estica.h - r.h)
        local c = math.min(12, math.floor(r.pw / 3), math.floor(r.ph / 3))
        local ox, oy = estica.x + bx, estica.y + by
        ctx.globalAlpha = 1
        -- 9 pedaços: cantos do mesmo tamanho, meio e lados esticados
        local sxs, dxs, sws, dws = { 0, c, r.pw - c }, { 0, c, W2 - c }, { c, r.pw - 2 * c, c }, { c, W2 - 2 * c, c }
        local sys, dys, shs, dhs = { 0, c, r.ph - c }, { 0, c, H2 - c }, { c, r.ph - 2 * c, c }, { c, H2 - 2 * c, c }
        for i = 1, 3 do for j = 1, 3 do if sws[i] > 0 and shs[j] > 0 and dws[i] > 0 and dhs[j] > 0 then ctx:drawImage(p, sxs[i], sys[j], sws[i], shs[j], ox + dxs[i], oy + dys[j], dws[i], dhs[j]) end end end
        local cor = (el.style and rawget(el.style, "color")) or r.cor or "#ffffff"
        local asc = D.metricas(estica.fam, r.tam or 12)
        local tr = r.textos[1]
        local larguraTexto = estica.w - estica.folga
        local tx0 = estica.x + (tr.x - x)
        local ly = estica.y + (tr.y - y) + (estica.altLinha - (r.tam or 12)) / 2 + asc * .95
        local linha = ""
        local function escreveLinha(l) local lw = D.medir(estica.fam, r.tam or 12, l, r.esp); local lx = (r.alinha == "center") and (tx0 + larguraTexto / 2 - lw / 2) or tx0; D.escrever(estica.fam, r.tam or 12, l, lx, ly, pixelDe(cor, op), r.esp); ly = ly + estica.altLinha end
        for palavra in estica.t:gmatch("%S+") do
          local teste = linha == "" and palavra or (linha .. " " .. palavra)
          if linha ~= "" and D.medir(estica.fam, r.tam or 12, teste, r.esp) > larguraTexto + 1 then escreveLinha(linha); linha = palavra else linha = teste end
        end
        if linha ~= "" then escreveLinha(linha) end
        desenhados[#desenhados + 1] = { el = el, x = estica.x, y = estica.y, w = estica.w, h = estica.h }
        jaDesenhou = true
      end
      if not estica then -- desenho normal (a pele e os textos como na foto)
      if r.pele and r.pw and r.pw > 0 then
        local p = pele(r.pele, r.pw, r.ph)
        ctx.globalAlpha = 1
        if w ~= r.w and r.w > 0 then
          local k = w / r.w
          ctx:drawImage(p, 0, 0, max(1, r.pw * k), r.ph, r.px + dx, r.py + dy, max(1, r.pw * k), r.ph)
        else colarPele(p, r.px + dx, r.py + dy) end
      end
      if r.canvas and el._ then
        if camadas and not D.camadaJogo and op >= 1 and x == 0 and y == 0 and w == 960 and h == 540 and el.width == 960 and el.height == 540 then
          -- camada do jogo: o Roblox mostra este canvas numa imagem própria, embaixo da página; o que veio antes fica por baixo dele
          D.camadaJogo = el; ctx:clearRect(0, 0, 960, 540)
        elseif not jaDesenhou and op >= 1 and x == 0 and y == 0 and w == 960 and h == 540 and el.width == 960 and el.height == 540 then
          Canvas.copiar(tela, el) -- a cena do jogo ocupa a tela toda: cópia direta, sem misturar pixel a pixel
        else
          ctx.globalAlpha = op
          ctx:drawImage(el, x, y, w, h)
          ctx.globalAlpha = 1
        end
      end
      if r.pele or r.canvas then jaDesenhou = true end
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
    end
    for _, el in ipairs(janelas) do desenharJanela(el) end
    ctx.globalAlpha = 1
    return tela, true
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
