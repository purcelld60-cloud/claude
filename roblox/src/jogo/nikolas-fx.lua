--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __call, __hypot = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local WeakMap = ____lualib.WeakMap
local __TS__New = ____lualib.__TS__New
local Set = ____lualib.Set
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local progresso, mosca, nuvem, disco, fedor, pao, estadoDe, uma, trocaDeFase, C, PAL_CATARRO, PAL_OURO, ctx, hsh, px, clamp, lerp, suave, entre, tocar, boca, memoria
    function progresso(self, e)
        return if e.state == "phaseChange" then clamp(nil, 1 - e.stateTimer / if __t(e.phaseDuration) then e.phaseDuration else 1.05, 0, 1) else 1
    end
    function mosca(self, x, y, t, seed)
        local bate = math.sin(t * 60 + seed) > 0
        px(
            nil,
            x - 1,
            y - 1,
            3,
            2,
            C.mosca
        )
        ctx.globalAlpha = 0.7
        px(
            nil,
            x - 3,
            y - if __t(bate) then 3 else 2,
            2,
            if __t(bate) then 2 else 1,
            C.asa
        )
        px(
            nil,
            x + 2,
            y - if __t(bate) then 3 else 2,
            2,
            if __t(bate) then 2 else 1,
            C.asa
        )
        ctx.globalAlpha = 1
    end
    function nuvem(self, x, y, r, a, seed, tons)
        tons = if __t(tons) then tons else __arrL({C.esc2, C.med, C.luz}, 3)
        local n = if __gt(r, 30) then 7 else 5
        do
            local i = 0
            while i < n do
                local an = i / n * math.pi * 2 + seed
                local rr = r * (0.45 + 0.25 * hsh(nil, seed + i))
                local cx = x + math.cos(an) * r * 0.55
                local cy = y + math.sin(an) * r * 0.35
                ctx.globalAlpha = a * 0.9
                disco(
                    nil,
                    cx,
                    cy,
                    rr,
                    __get(tons, 0)
                )
                ctx.globalAlpha = a
                disco(
                    nil,
                    cx - rr * 0.15,
                    cy - rr * 0.2,
                    rr * 0.78,
                    __get(tons, 1)
                )
                ctx.globalAlpha = a * 0.8
                disco(
                    nil,
                    cx - rr * 0.3,
                    cy - rr * 0.38,
                    rr * 0.4,
                    __get(tons, 2)
                )
                i = i + 1
            end
        end
        ctx.globalAlpha = 1
    end
    function disco(self, x, y, r, c)
        if __lt(r, 1) then
            return
        end
        local s = if __gt(r, 14) then 3 else 2
        do
            local yy = __TS__Number(-r)
            while __lt(yy, r) do
                local w = math.sqrt(math.max(0, r * r - yy * yy))
                px(
                    nil,
                    x - w,
                    y + yy,
                    w * 2,
                    s,
                    c
                )
                yy = yy + s
            end
        end
    end
    function fedor(self, x, y, alto, t, seed, a)
        ctx.globalAlpha = a
        do
            local k = 0
            while __lt(k, alto) do
                local ox = math.sin(t * 5 + seed + k * 0.18) * 4
                px(
                    nil,
                    x + ox,
                    y - k,
                    2,
                    3,
                    if __mod(k, 9) < 3 then C.luz else C.clr
                )
                k = k + 3
            end
        end
        ctx.globalAlpha = 1
    end
    function pao(self, x, y, esc, mordidas, dir, t)
        local W = 18
        local H = 10
        local comido = mordidas * 4
        do
            local cx = 0
            while cx < W do
                local doLado = cx
                if doLado >= W - comido then
                    if __t(doLado == W - comido and __gt(mordidas, 0)) then
                        do
                            local cy = 2
                            while cy < H - 1 do
                                if __mod(cy, 3) ~= 0 then
                                    px(
                                        nil,
                                        x - dir * (cx - W / 2) * esc,
                                        y + (cy - H / 2) * esc,
                                        esc,
                                        esc,
                                        C.miolo2
                                    )
                                end
                                cy = cy + 1
                            end
                        end
                    end
                    continue
                end
                local curva = math.floor(math.abs(cx - 8.5) / 3.2 + 0.5)
                do
                    local cy = curva
                    while cy < H do
                        local c
                        if cy == curva then
                            c = C.pao1
                        elseif cy == curva + 1 then
                            c = C.pao3
                        elseif cy >= H - 2 then
                            c = C.pao1
                        else
                            c = if cy < 4 then C.pao2 else C.pao3
                        end
                        if __t(cx == 0 or cx == W - 1 - comido) then
                            c = C.pao1
                        end
                        local ____t_23 = __t
                        local ____t_22 = __t
                        local ____t_20 = __t
                        local ____temp_19 = __gt(mordidas, 0) and cx == W - 1 - comido
                        __O[1491] = ____temp_19
                        local ____temp_21 = if ____t_20(____temp_19) then cy > curva else __O[1491]
                        __O[1492] = ____temp_21
                        if ____t_23(if ____t_22(____temp_21) then cy < H - 1 else __O[1492]) then
                            c = C.miolo
                        end
                        if __t(cy == curva + 1 and __mod(cx, 5) == 2) then
                            c = C.pao4
                        end
                        local m = hsh(nil, cx * 17 + cy * 31)
                        if m > 0.82 then
                            c = if m > 0.94 then C.mofo4 else if m > 0.88 then C.mofo2 else C.mofo1
                        end
                        local ____t_26 = __t
                        local ____t_25 = __t
                        local ____temp_24 = m > 0.76 and m <= 0.82
                        __O[1493] = ____temp_24
                        if ____t_26(if ____t_25(____temp_24) then cy < 5 else __O[1493]) then
                            c = C.mofo3
                        end
                        px(
                            nil,
                            x - dir * (cx - W / 2) * esc,
                            y + (cy - H / 2) * esc,
                            esc,
                            esc,
                            c
                        )
                        cy = cy + 1
                    end
                end
                cx = cx + 1
            end
        end
        local restos = W - comido
        if restos > 0 then
            do
                local i = 0
                while i < 3 do
                    local k = __mod(t * 0.7 + i / 3, 1)
                    nuvem(
                        nil,
                        x + dir * (i - 1) * 5 * esc + math.sin(t * 3 + i) * 3,
                        y - H / 2 * esc - k * 34 * esc / 2,
                        (3 + k * 7) * esc / 2,
                        (1 - k) * 0.75,
                        i * 2.1
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 3 do
                    fedor(
                        nil,
                        x + dir * (i * 6 - 6) * esc / 2,
                        y - H / 2 * esc - 2,
                        14 * esc / 2,
                        t,
                        i * 4,
                        0.8
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 2 do
                    mosca(
                        nil,
                        x + math.cos(t * 5 + i * 3) * 13 * esc / 2,
                        y - 6 * esc + math.sin(t * 7 + i) * 5 * esc / 2,
                        t,
                        i
                    )
                    i = i + 1
                end
            end
        end
    end
    function estadoDe(self, e)
        local m = __call(memoria, "get", e)
        if not __t(m) then
            m = {
                fase = e.phase,
                feitos = __TS__New(Set)
            }
            __call(memoria, "set", e, m)
        end
        if m.fase ~= e.phase then
            m.fase = e.phase
            m.feitos = __TS__New(Set)
        end
        return m
    end
    function uma(self, m, chave, f)
        if __t(__call(m.feitos, "has", chave)) then
            return
        end
        __call(m.feitos, "add", chave)
        f(nil)
    end
    function trocaDeFase(self, e, cp, t, dir, lite)
        local p = progresso(nil, e)
        local m = estadoDe(nil, e)
        local f = if __t(e.phase) then e.phase else 2
        local b = boca(nil, e, cp, dir)
        local esc = if __ge(f, 4) then 5 else 3
        local escuro = math.min(
            entre(nil, p, 0, 0.08),
            1 - entre(nil, p, 0.86, 1)
        ) * 0.45
        if escuro > 0 then
            ctx.globalAlpha = escuro
            px(
                nil,
                cp.x - 2000,
                -600,
                4000,
                2400,
                "#0a0f04"
            )
            ctx.globalAlpha = 1
            local nl = if __t(lite) then 10 else 26
            do
                local i = 0
                while i < nl do
                    local an = hsh(nil, i * 3.3) * math.pi * 2
                    local r0 = 220 + hsh(nil, i) * 260 - __mod(t * 900 + i * 40, 260)
                    local len = 30 + hsh(nil, i * 7) * 60
                    ctx.globalAlpha = escuro * 1.6
                    do
                        local k = 0
                        while k < len do
                            px(
                                nil,
                                cp.x + math.cos(an) * (r0 + k),
                                cp.cy + math.sin(an) * (r0 + k) * 0.6,
                                3,
                                2,
                                if k < 8 then C.bri else C.clr
                            )
                            k = k + 4
                        end
                    end
                    i = i + 1
                end
            end
            ctx.globalAlpha = 1
        end
        if __t(p >= 0.05 and p < 0.44) then
            local sobe = suave(
                nil,
                entre(nil, p, 0.05, 0.16)
            )
            local mao = {x = cp.x + dir * cp.meia * 0.7, y = cp.pe - cp.alto * 0.35}
            local mordidas = if p < 0.2 then 0 else if p < 0.27 then 1 else if p < 0.34 then 2 else 3
            local tremida = if __t(p > 0.16 and p < 0.4) then math.sin(p * 220) * 1.5 else 0
            local x = lerp(nil, mao.x, b.x + dir * 10 * esc / 2, sobe)
            local y = lerp(nil, mao.y, b.y + 4, sobe) + tremida
            local sumindo = 1 - entre(nil, p, 0.38, 0.44)
            ctx.globalAlpha = sumindo
            pao(
                nil,
                x,
                y,
                esc,
                mordidas,
                dir,
                t
            )
            ctx.globalAlpha = 1
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({0.2, 1}, 2),
                    __arrL({0.27, 2}, 2),
                    __arrL({0.34, 3}, 2)
                },
                3
            ))) do
                local inicio = ____value[1]
                local s = ____value[2]
                local k = (p - inicio) / 0.12
                if __t(k > 0 and k < 1) then
                    do
                        local i = 0
                        while i < if __t(lite) then 5 else 10 do
                            local vx = (hsh(nil, i * s + 1) - 0.3) * 70 * dir
                            local vy = -30 - hsh(nil, i * s * 2) * 50
                            local T = k * 0.9
                            px(
                                nil,
                                b.x + vx * T,
                                b.y + vy * T + 160 * T * T,
                                esc,
                                esc,
                                if __t(__mod(i, 3)) then C.pao3 else C.miolo
                            )
                            i = i + 1
                        end
                    end
                end
            end
        end
        if __t(p >= 0.38 and p < 0.7) then
            local k = entre(nil, p, 0.38, 0.66)
            local n = if __t(lite) then 6 else 12
            do
                local i = 0
                while i < n do
                    local an = (i / n - 0.5) * 1.6 + if __gt(dir, 0) then 0 else math.pi
                    local dist = 20 + k * (90 + hsh(nil, i) * 80) * if __ge(f, 4) then 1.6 else 1
                    nuvem(
                        nil,
                        b.x + math.cos(an) * dist,
                        b.y + math.sin(an) * dist * 0.6 - k * 30,
                        (5 + k * 12 + hsh(nil, i * 3) * 5) * if __ge(f, 4) then 1.6 else 1,
                        (1 - k) * (1 - k) * 0.7,
                        i * 1.3
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 4 do
                    fedor(
                        nil,
                        b.x - 20 + i * 12,
                        b.y - 10,
                        30,
                        t * 2,
                        i * 5,
                        (1 - k) * 0.9
                    )
                    i = i + 1
                end
            end
            uma(
                nil,
                m,
                "arroto",
                function()
                    tocar(nil, "nature/poison-cloud", {x = b.x + dir * 30, y = b.y, palette = PAL_CATARRO, duracao = 1.1})
                    tocar(nil, "status/poisoned", {x = cp.x, y = cp.topo + 10, palette = PAL_CATARRO, duracao = 1.2})
                end
            )
        end
        if __t(p >= 0.52 and p < 0.82) then
            local k = entre(nil, p, 0.52, 0.8)
            local n = if __t(lite) then 16 else 40
            do
                local i = 0
                while i < n do
                    local an = hsh(nil, i * 2.1) * math.pi * 2
                    local r = (1 - __mod(
                        k * 1.6 + hsh(nil, i),
                        1
                    )) * 260
                    ctx.globalAlpha = 0.9
                    px(
                        nil,
                        cp.x + math.cos(an) * r,
                        cp.cy + math.sin(an) * r * 0.7,
                        3,
                        3,
                        if __t(__mod(i, 3)) then C.luz else C.bri
                    )
                    i = i + 1
                end
            end
            do
                local a = 0
                while a < 3 do
                    local r = (1 - __mod(k * 2 + a / 3, 1)) * (cp.meia * 3 + 80)
                    ctx.globalAlpha = 0.7
                    do
                        local s = 0
                        while s < 48 do
                            local an = s / 48 * math.pi * 2
                            px(
                                nil,
                                cp.x + math.cos(an) * r,
                                cp.cy + math.sin(an) * r * 0.55,
                                3,
                                3,
                                if a == 1 then C.amarelo2 else C.luz
                            )
                            s = s + 1
                        end
                    end
                    a = a + 1
                end
            end
            ctx.globalAlpha = 1
            do
                local i = 0
                while i < 6 do
                    local L = 30 + k * 90 * hsh(nil, i + 2)
                    local x = cp.x
                    local y = cp.pe
                    local sgn = if __t(__mod(i, 2)) then 1 else -1
                    do
                        local s = 0
                        while s < L do
                            x = x + sgn * 6
                            y = y + (hsh(nil, i * 9 + s) - 0.5) * 4
                            px(
                                nil,
                                x,
                                y - 1,
                                6,
                                2,
                                if __t(__mod(s, 12)) then C.clr else C.bri
                            )
                            s = s + 6
                        end
                    end
                    i = i + 1
                end
            end
            uma(
                nil,
                m,
                "carga",
                function() return tocar(nil, "lightning/charge-up", {x = cp.x, y = cp.cy, palette = PAL_CATARRO, duracao = 1.1}) end
            )
            if f == 2 then
                uma(
                    nil,
                    m,
                    "carga-ouro",
                    function() return tocar(nil, "status/rage", {x = cp.x, y = cp.topo, palette = PAL_OURO, duracao = 1.2}) end
                )
            end
        end
        if p >= 0.8 then
            local k = entre(nil, p, 0.8, 1)
            ctx.globalAlpha = (1 - k) * 0.75
            px(
                nil,
                cp.x - 2000,
                -600,
                4000,
                2400,
                if k < 0.2 then "#f4ffd8" else "#b6dc62"
            )
            ctx.globalAlpha = 1
            local r = 20 + k * 520
            do
                local s = 0
                while s < 72 do
                    local an = s / 72 * math.pi * 2
                    ctx.globalAlpha = 1 - k
                    px(
                        nil,
                        cp.x + math.cos(an) * r,
                        cp.cy + math.sin(an) * r * 0.5,
                        6,
                        4,
                        if __t(__mod(s, 3)) then C.luz else C.bri
                    )
                    px(
                        nil,
                        cp.x + math.cos(an) * r * 0.8,
                        cp.cy + math.sin(an) * r * 0.4,
                        4,
                        3,
                        C.clr
                    )
                    s = s + 1
                end
            end
            do
                local i = 0
                while i < if __t(lite) then 8 else 18 do
                    local vx = (hsh(nil, i) - 0.5) * 520
                    local vy = -180 - hsh(nil, i * 3) * 260
                    local T = k * 1.2
                    ctx.globalAlpha = 1 - k
                    px(
                        nil,
                        cp.x + vx * T,
                        cp.pe + vy * T + 400 * T * T,
                        6,
                        6,
                        if __t(__mod(i, 2)) then "#6d5a3c" else C.med
                    )
                    i = i + 1
                end
            end
            ctx.globalAlpha = 1
            uma(
                nil,
                m,
                "explosao",
                function()
                    tocar(nil, "arcane/mana-burst", {x = cp.x, y = cp.cy, palette = if f == 2 then PAL_OURO else PAL_CATARRO})
                    tocar(nil, "impacts/ground-slam", {x = cp.x, y = cp.pe, palette = PAL_CATARRO, atraso = 0.08})
                    tocar(nil, "explosions/plasma-explosion", {x = cp.x, y = cp.cy - 20, palette = if f == 2 then PAL_OURO else PAL_CATARRO, atraso = 0.1})
                end
            )
        end
    end
    local ____ = "use strict"
    C = __ord({
        esc = "#1c2608",
        esc2 = "#33480f",
        med = "#5d8423",
        clr = "#8fbd36",
        luz = "#c3e165",
        bri = "#ecfab0",
        branco = "#fbffe8",
        amarelo = "#d9cf4c",
        amarelo2 = "#f2e98a",
        ouro = "#ffcf5a",
        ouro2 = "#ffe9a6",
        laranja = "#f39a3a",
        pao1 = "#6e4317",
        pao2 = "#9c6427",
        pao3 = "#c98d43",
        pao4 = "#e6bd78",
        miolo = "#e9dcb0",
        miolo2 = "#cdbd86",
        mofo1 = "#3d5a16",
        mofo2 = "#6f8f22",
        mofo3 = "#a4bd3c",
        mofo4 = "#4a3a5c",
        mosca = "#14120e",
        asa = "#c8d6e0"
    }, "esc,esc2,med,clr,luz,bri,branco,amarelo,amarelo2,ouro,ouro2,laranja,pao1,pao2,pao3,pao4,miolo,miolo2,mofo1,mofo2,mofo3,mofo4,mosca,asa")
    PAL_CATARRO = __arrL({
        "#101806",
        "#22320c",
        "#3e5a14",
        "#69922a",
        "#a2c946",
        "#d8ee8c",
        "#f6ffd6"
    }, 7)
    local PAL_AMARELO = __arrL({
        "#1c1806",
        "#3e360c",
        "#6e6218",
        "#a8962c",
        "#d8c84c",
        "#f2e88e",
        "#fffbe0"
    }, 7)
    PAL_OURO = __arrL({
        "#2a1a06",
        "#5a3a0a",
        "#9a6a14",
        "#d8a028",
        "#ffd25a",
        "#fff0a8",
        "#ffffff"
    }, 7)
    ctx = nil
    hsh = function(____, n)
        local x = math.sin(n * 12.9898 + 78.233) * 43758.5453
        return x - math.floor(x)
    end
    px = function(____, x, y, w, h, c)
        ctx.fillStyle = c
        ctx:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.max(
                1,
                math.floor(w + 0.5)
            ),
            math.max(
                1,
                math.floor(h + 0.5)
            )
        )
    end
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    lerp = function(____, a, b, k) return a + (b - a) * k end
    suave = function(____, k)
        k = clamp(nil, k, 0, 1)
        return k * k * (3 - 2 * k)
    end
    entre = function(____, p, a, b) return clamp(nil, (p - a) / (b - a), 0, 1) end
    local function leve()
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isLite
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        return not not ____t_5(____opt_result_4)
    end
    tocar = function(____, id, o)
        local ____opt_8 = window.FxPixel
        if ____opt_8 ~= nil then
            ____opt_8 = ____opt_8.tocar
        end
        local ____opt_result_10
        if ____opt_8 ~= nil then
            ____opt_result_10 = ____opt_8(____opt_8, id, o)
        end
        return ____opt_result_10
    end
    local BOUNDS = {
        ["1"] = __ord({halfWidth = 35, height = 90, centerY = 30}, "halfWidth,height,centerY"),
        ["2"] = __ord({halfWidth = 55, height = 140, centerY = 70}, "halfWidth,height,centerY"),
        ["3"] = __ord({halfWidth = 55, height = 140, centerY = 70}, "halfWidth,height,centerY"),
        ["4"] = __ord({halfWidth = 185, height = 340, centerY = 170}, "halfWidth,height,centerY")
    }
    local function medida(____, f)
        local ____t_18 = __t
        local ____t_16 = __t
        local ____opt_13 = window.Art
        if ____opt_13 ~= nil then
            ____opt_13 = ____opt_13.nikolasBounds
        end
        local ____opt_result_15
        if ____opt_13 ~= nil then
            ____opt_result_15 = ____opt_13(____opt_13, f)
        end
        __O[1489] = ____opt_result_15
        local ____temp_17 = if ____t_16(____opt_result_15) then __O[1489] else __get(BOUNDS, f)
        __O[1490] = ____temp_17
        return if ____t_18(____temp_17) then __O[1490] else __get(BOUNDS, 1)
    end
    local function corpo(self, e)
        local f = if __t(e.phase) then e.phase else 1
        local p = progresso(nil, e)
        local b = medida(nil, f)
        if __t(e.state == "phaseChange" and __gt(f, 1)) then
            local a = medida(nil, f - 1)
            local k = suave(
                nil,
                entre(nil, p, 0.55, 0.85)
            )
            b = {
                halfWidth = lerp(nil, a.halfWidth, b.halfWidth, k),
                height = lerp(nil, a.height, b.height, k),
                centerY = lerp(nil, a.centerY, b.centerY, k)
            }
        end
        return {
            x = e.x,
            pe = e.y,
            topo = e.y - b.height,
            cy = e.y - b.centerY,
            meia = b.halfWidth,
            alto = b.height
        }
    end
    boca = function(____, e, cp, dir) return {x = cp.x + dir * cp.meia * 0.42, y = cp.topo + cp.alto * if __ge(if __t(e.phase) then e.phase else 1, 4) then 0.2 else 0.24} end
    local function labareda(self, x, base, alto, larg, t, seed, cores, a)
        local passo = if __gt(alto, 60) then 4 else 3
        do
            local k = 0
            while __lt(k, alto) do
                local f = k / alto
                local w = math.max(
                    1,
                    larg * (1 - f) ^ 0.75 * (0.78 + 0.22 * math.sin(t * 13 + seed * 3 + k * 0.21))
                )
                local ox = math.sin(t * 7 + seed + k * 0.09) * k * 0.16
                ctx.globalAlpha = a * if f < 0.15 then 0.55 + f * 3 else 1 * (1 - f * 0.35)
                px(
                    nil,
                    x + ox - w / 2,
                    base - k - passo,
                    w,
                    passo,
                    if f < 0.35 then __get(cores, 0) else if f < 0.7 then __get(cores, 1) else __get(cores, 2)
                )
                if w > 4 then
                    px(
                        nil,
                        x + ox - w / 4,
                        base - k - passo,
                        w / 2,
                        passo,
                        if f < 0.5 then __get(cores, 2) else __get(cores, 3)
                    )
                end
                k = k + passo
            end
        end
        ctx.globalAlpha = 1
    end
    local function bolha(self, x, y, r, a)
        ctx.globalAlpha = a
        do
            local yy = __TS__Number(-r)
            while __le(yy, r) do
                local w = math.sqrt(math.max(0, r * r - yy * yy))
                px(
                    nil,
                    x - w,
                    y + yy,
                    2,
                    2,
                    C.luz
                )
                px(
                    nil,
                    x + w - 2,
                    y + yy,
                    2,
                    2,
                    C.med
                )
                yy = yy + 2
            end
        end
        px(
            nil,
            x - r * 0.4,
            y - r * 0.5,
            2,
            2,
            C.branco
        )
        ctx.globalAlpha = 1
    end
    local function aura(self, c, e, t, dir)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        ctx = c
        dir = if __t(dir) then dir else -1
        local cp = corpo(nil, e)
        local f = if __t(e.phase) then e.phase else 1
        local lite = leve(nil)
        local trocando = e.state == "phaseChange"
        local p = progresso(nil, e)
        local forca = if __t(trocando) then suave(
            nil,
            entre(nil, p, 0.5, 0.8)
        ) else 1
        ctx:save()
        if f == 1 then
            do
                local i = 0
                while i < if __t(lite) then 2 else 4 do
                    fedor(
                        nil,
                        cp.x - 18 + i * 12,
                        cp.topo + 6,
                        26 + 8 * hsh(nil, i),
                        t,
                        i * 3,
                        0.55
                    )
                    i = i + 1
                end
            end
        else
            local quantas = if f == 2 then 16 else if f == 3 then 22 else 30 * if __t(lite) then 0.5 else 1
            local tons = if f == 2 then __arrL({C.laranja, C.ouro, C.ouro2, C.branco}, 4) else if f == 3 then __arrL({C.med, C.clr, C.luz, C.bri}, 4) else __arrL({C.esc2, C.med, C.clr, C.luz}, 4)
            local pulso = 0.85 + 0.15 * math.sin(t * if f == 4 then 4 else 7)
            ctx.globalAlpha = if f == 4 then 0.22 else 0.16 * forca
            disco(
                nil,
                cp.x,
                cp.cy,
                math.max(cp.meia, cp.alto * 0.45) * 1.25 * pulso,
                if f == 2 then "#c88a24" else "#5f8a1e"
            )
            ctx.globalAlpha = 1
            do
                local i = 0
                while i < quantas do
                    local an = i / quantas * math.pi * 2 + if f == 3 then t * 0.6 else 0
                    local ex = cp.x + math.cos(an) * cp.meia * 1.08
                    local ey = cp.cy + math.sin(an) * cp.alto * 0.52
                    local embaixo = math.sin(an) > 0.3
                    local alto = if __t(embaixo) then 0.35 else 1 * if f == 4 then 70 else if f == 3 then 44 else 32 * (0.7 + 0.5 * hsh(nil, i * 7)) * pulso * forca
                    if alto < 4 then
                        continue
                    end
                    labareda(
                        nil,
                        ex,
                        ey + 6,
                        alto,
                        if f == 4 then 16 else 10,
                        t,
                        i * 1.7,
                        tons,
                        0.82
                    )
                    i = i + 1
                end
            end
            if __t(f == 2 and not __t(lite)) then
                do
                    local i = 0
                    while i < 5 do
                        local k = __mod(t * 1.3 + i / 5, 1)
                        ctx.globalAlpha = 1 - k
                        px(
                            nil,
                            cp.x - cp.meia + hsh(nil, i) * cp.meia * 2,
                            cp.topo + 20 + k * 60,
                            2,
                            3,
                            "#bfe6ff"
                        )
                        i = i + 1
                    end
                end
            end
            if f == 3 then
                local r = 46 + math.sin(t * 6) * 4
                ctx.globalAlpha = 0.7 * forca
                do
                    local k = 0
                    while k < 40 do
                        local an = k / 40 * math.pi * 2 + t * 2
                        px(
                            nil,
                            cp.x + math.cos(an) * r,
                            cp.pe + 8 + math.sin(an) * r * 0.22,
                            3,
                            2,
                            if __t(__mod(k, 2)) then C.luz else C.clr
                        )
                        k = k + 1
                    end
                end
                do
                    local i = 0
                    while i < if __t(lite) then 6 else 14 do
                        local k = __mod(
                            t * 0.8 + hsh(nil, i * 3),
                            1
                        )
                        ctx.globalAlpha = (1 - k) * forca
                        px(
                            nil,
                            cp.x + (hsh(nil, i) - 0.5) * cp.meia * 2.4,
                            cp.pe - k * (cp.alto + 70),
                            2,
                            2,
                            if __t(__mod(i, 3)) then C.luz else C.bri
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 6 do
                        local k = __mod(t * 2.2 + i / 6, 1)
                        ctx.globalAlpha = 0.5 * (1 - k)
                        px(
                            nil,
                            cp.x - 20 + i * 8,
                            cp.pe + 14 + k * 70,
                            2,
                            10,
                            C.clr
                        )
                        i = i + 1
                    end
                end
            end
            if f == 4 then
                ctx.globalAlpha = 0.55 * forca
                do
                    local yy = 0
                    while yy < 10 do
                        local w = cp.meia * 1.5 * (1 - yy / 14)
                        px(
                            nil,
                            cp.x - w,
                            cp.pe - 4 + yy,
                            w * 2,
                            2,
                            if yy < 4 then C.clr else C.med
                        )
                        yy = yy + 2
                    end
                end
                ctx.globalAlpha = 1
                do
                    local i = 0
                    while i < if __t(lite) then 6 else 16 do
                        local k = __mod(
                            t * 0.45 + hsh(nil, i * 5),
                            1
                        )
                        bolha(
                            nil,
                            cp.x + (hsh(nil, i) - 0.5) * cp.meia * 2.6 + math.sin(t * 2 + i) * 6,
                            cp.pe - 10 - k * (cp.alto + 40),
                            3 + hsh(nil, i * 9) * 5,
                            (1 - k) * 0.85 * forca
                        )
                        i = i + 1
                    end
                end
            end
        end
        ctx:restore()
    end
    memoria = __TS__New(WeakMap)
    local function frente(self, c, e, t, dir)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        ctx = c
        dir = if __t(dir) then dir else -1
        local cp = corpo(nil, e)
        local f = if __t(e.phase) then e.phase else 1
        local lite = leve(nil)
        ctx:save()
        local nm = if __t(lite) then 1 else 2 + f
        do
            local i = 0
            while __lt(i, nm) do
                mosca(
                    nil,
                    cp.x + math.cos(t * (2 + i * 0.3) + i * 2) * (cp.meia + 14),
                    cp.topo + 10 + math.sin(t * (3.1 + i * 0.2) + i) * 18 + i * 6,
                    t,
                    i
                )
                i = i + 1
            end
        end
        if __t(f == 4 and e.state ~= "phaseChange") then
            local b = boca(nil, e, cp, dir)
            do
                local i = 0
                while i < 3 do
                    local k = __mod(t * 0.9 + i / 3, 1)
                    local len = 8 + k * 26
                    px(
                        nil,
                        b.x + i * 8 - 8,
                        b.y + 18,
                        3,
                        len,
                        C.clr
                    )
                    px(
                        nil,
                        b.x + i * 8 - 8,
                        b.y + 18 + len,
                        4,
                        4,
                        C.luz
                    )
                    i = i + 1
                end
            end
        end
        if e.state == "phaseChange" then
            trocaDeFase(
                nil,
                e,
                cp,
                t,
                dir,
                lite
            )
        end
        ctx:restore()
    end
    local function catarro(self, c, s, t)
        ctx = c
        local ____t_28 = __t
        local ____TS__Number_result_27 = __TS__Number(s.vx)
        __O[1494] = ____TS__Number_result_27
        local vx = if ____t_28(____TS__Number_result_27) then __O[1494] else -1
        local ____t_30 = __t
        local ____TS__Number_result_29 = __TS__Number(s.vy)
        __O[1495] = ____TS__Number_result_29
        local vy = if ____t_30(____TS__Number_result_29) then __O[1495] else 0
        local ____t_32 = __t
        local ____hypot_result_31 = __hypot(vx, vy)
        __O[1496] = ____hypot_result_31
        local sp = if ____t_32(____hypot_result_31) then __O[1496] else 1
        local ux = vx / sp
        local uy = vy / sp
        local ____s_34 = s
        local ____s_seed_33 = s.seed
        if ____s_seed_33 == nil then
            ____s_seed_33 = math.random() * 100
        end
        ____s_34.seed = ____s_seed_33
        local seed = ____s_seed_33
        local r = if __ge(s.damage, 15) then 10 else 8
        local wob = math.sin(t * 18 + seed)
        do
            local i = 1
            while i <= 4 do
                local d = i * (r * 0.9 + 2)
                local q = math.max(2, r * 0.55 - i * 1.2)
                px(
                    nil,
                    s.x - ux * d - q / 2 + math.sin(t * 9 + i + seed) * 1.5,
                    s.y - uy * d - q / 2,
                    q,
                    q,
                    if __t(__mod(i, 2)) then C.clr else C.luz
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < r * 3 do
                px(
                    nil,
                    s.x - ux * k,
                    s.y - uy * k + math.sin(k * 0.5 + t * 12) * 1,
                    1,
                    1,
                    C.bri
                )
                k = k + 2
            end
        end
        local rx = r * (1.15 + 0.12 * wob)
        local ry = r * (0.85 - 0.1 * wob)
        do
            local yy = -ry
            while yy <= ry do
                local w = rx * math.sqrt(math.max(0, 1 - yy * yy / (ry * ry)))
                px(
                    nil,
                    s.x - w,
                    s.y + yy,
                    w * 2,
                    2,
                    if math.abs(yy) > ry - 2.5 then C.esc2 else C.clr
                )
                if w > 3 then
                    px(
                        nil,
                        s.x - w + 2,
                        s.y + yy,
                        w * 2 - 4,
                        2,
                        if yy < -ry * 0.2 then C.luz else C.clr
                    )
                end
                yy = yy + 2
            end
        end
        px(
            nil,
            s.x + 2,
            s.y + 1,
            3,
            2,
            C.amarelo
        )
        px(
            nil,
            s.x - 4,
            s.y - 3,
            2,
            2,
            C.amarelo2
        )
        px(
            nil,
            s.x + r * 0.3,
            s.y + r * 0.3,
            2,
            2,
            C.med
        )
        px(
            nil,
            s.x - rx * 0.45,
            s.y - ry * 0.55,
            3,
            2,
            C.branco
        )
        px(
            nil,
            s.x - rx * 0.45 + 3,
            s.y - ry * 0.55 + 2,
            1,
            1,
            C.branco
        )
        return true
    end
    local function onda(self, c, h, t, lite)
        ctx = c
        local ____t_36 = __t
        local ____TS__Number_result_35 = __TS__Number(h.y)
        __O[1497] = ____TS__Number_result_35
        local chao = if ____t_36(____TS__Number_result_35) then __O[1497] else 0 + 5
        local vida = math.max(0, if __t(h.life) then h.life else 0)
        local grande = __ge(h.maxR, 900)
        local H = if __t(grande) then 62 else 42
        for ____, dir in __iterar((__arrL({-1, 1}, 2))) do
            local cx = h.x + dir * h.r
            ctx:save()
            do
                local x = h.x
                while __t(if dir > 0 then __lt(x, cx - 10) else __gt(x, cx + 10)) do
                    local fade = math.abs(x - h.x) / math.max(1, h.r)
                    ctx.globalAlpha = 0.35 + 0.4 * fade
                    px(
                        nil,
                        x,
                        chao - 4,
                        8,
                        3,
                        C.med
                    )
                    if hsh(nil, x) > 0.7 then
                        px(
                            nil,
                            x + 2,
                            chao - 6,
                            3,
                            2,
                            C.luz
                        )
                    end
                    x = x + dir * 8
                end
            end
            ctx:restore()
            local N = 14
            do
                local i = 0
                while i < N do
                    local k = i / (N - 1)
                    local alt = H * math.sin(k * math.pi * 0.92) ^ 1.4 * (0.9 + 0.1 * math.sin(t * 20 + i))
                    local x = cx - dir * (N - 1 - i) * 5
                    do
                        local y = 0
                        while y < alt do
                            local f = y / math.max(1, alt)
                            px(
                                nil,
                                x - 3,
                                chao - y - 4,
                                6,
                                4,
                                if f < 0.3 then C.esc2 else if f < 0.65 then C.med else if f < 0.88 then C.clr else C.luz
                            )
                            y = y + 4
                        end
                    end
                    if alt > 8 then
                        px(
                            nil,
                            x - 3,
                            chao - alt - 4,
                            6,
                            3,
                            C.bri
                        )
                    end
                    i = i + 1
                end
            end
            do
                local s = 0
                while s < 6 do
                    local an = s / 6 * math.pi * 0.9
                    px(
                        nil,
                        cx + dir * (math.sin(an) * 12),
                        chao - H * 0.9 - math.cos(an) * 10 + 4,
                        5,
                        4,
                        if s < 2 then C.bri else C.luz
                    )
                    s = s + 1
                end
            end
            if not __t(lite) then
                do
                    local i = 0
                    while i < 8 do
                        local k = __mod(t * 3 + i / 8, 1)
                        ctx.globalAlpha = 1 - k
                        px(
                            nil,
                            cx + dir * (6 + k * 34) + (hsh(nil, i) - 0.5) * 10,
                            chao - H * 0.8 - k * 30 + k * k * 50,
                            3,
                            3,
                            if __t(__mod(i, 2)) then C.luz else C.amarelo2
                        )
                        i = i + 1
                    end
                end
            end
            ctx.globalAlpha = 1
            if not __t(lite) then
                do
                    local i = 0
                    while i < 3 do
                        bolha(
                            nil,
                            cx - dir * (8 + i * 14),
                            chao - H * (0.35 + 0.15 * i) - __mod(t * 40 + i * 13, 20),
                            3,
                            0.8
                        )
                        i = i + 1
                    end
                end
            end
        end
        if vida < 0.3 then
            ctx.globalAlpha = 1
        end
    end
    window.NikolasFx = __ord({
        aura = aura,
        frente = frente,
        catarro = catarro,
        onda = onda,
        PAL = PAL_CATARRO
    }, "aura,frente,catarro,onda,PAL")
end)(nil)
return ____exports
