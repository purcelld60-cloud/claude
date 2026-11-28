--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __call, __add, __keys = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__keys
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.PixelKit) then
        return
    end
    local function R(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
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
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function mk(____, w, h)
        local cv = window.document:createElement("canvas")
        cv.width = w
        cv.height = h
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        return __arrL({cv, c}, 2)
    end
    local cache = {}
    local function texto(self, c, t, x, y, tam, cor, alinhar, sombra)
        if tam == nil then
            tam = 8
        end
        if cor == nil then
            cor = "#ffffff"
        end
        if alinhar == nil then
            alinhar = "center"
        end
        if sombra == nil then
            sombra = "#0a0a14"
        end
        c.font = tostring(tam) .. "px Pixel, monospace"
        c.textAlign = alinhar
        c.textBaseline = "middle"
        local s = math.max(
            1,
            math.floor(tam / 8 + 0.5)
        )
        local X = math.floor(x + 0.5)
        local Y = math.floor(y + 0.5)
        if __t(sombra) then
            c.fillStyle = sombra
            c:fillText(t, X + s, Y + s)
        end
        c.fillStyle = cor
        c:fillText(t, X, Y)
    end
    local function contorno(self, c, t, x, y, tam, cor, borda, alinhar)
        if tam == nil then
            tam = 8
        end
        if cor == nil then
            cor = "#ffffff"
        end
        if borda == nil then
            borda = "#0a0a14"
        end
        if alinhar == nil then
            alinhar = "center"
        end
        c.font = tostring(tam) .. "px Pixel, monospace"
        c.textAlign = alinhar
        c.textBaseline = "middle"
        local s = math.max(
            1,
            math.floor(tam / 8 + 0.5)
        )
        local X = math.floor(x + 0.5)
        local Y = math.floor(y + 0.5)
        c.fillStyle = borda
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-s, 0}, 2),
                __arrL({s, 0}, 2),
                __arrL({0, -s}, 2),
                __arrL({0, s}, 2),
                __arrL({s, s}, 2)
            },
            5
        ))) do
            local dx = ____value[1]
            local dy = ____value[2]
            c:fillText(t, X + dx, Y + dy)
        end
        c.fillStyle = cor
        c:fillText(t, X, Y)
    end
    local function painel(self, c, x, y, w, h, tema)
        if tema == nil then
            tema = {}
        end
        local ____t_result_0
        if __t(tema.u) then
            ____t_result_0 = tema.u
        else
            ____t_result_0 = 1
        end
        local u = ____t_result_0
        local ____t_result_1
        if __t(tema.borda) then
            ____t_result_1 = tema.borda
        else
            ____t_result_1 = "#e8d8a0"
        end
        local borda = ____t_result_1
        local ____t_result_2
        if __t(tema.fundo) then
            ____t_result_2 = tema.fundo
        else
            ____t_result_2 = "#1a2030"
        end
        local fundo = ____t_result_2
        local ____t_result_3
        if __t(tema.luz) then
            ____t_result_3 = tema.luz
        else
            ____t_result_3 = "rgba(255,255,255,.22)"
        end
        local luz = ____t_result_3
        local ____t_result_4
        if __t(tema.escuro) then
            ____t_result_4 = tema.escuro
        else
            ____t_result_4 = "rgba(0,0,0,.35)"
        end
        local escuro = ____t_result_4
        x = math.floor(x + 0.5)
        y = math.floor(y + 0.5)
        w = math.floor(w + 0.5)
        h = math.floor(h + 0.5)
        if tema.sombra ~= false then
            R(
                nil,
                c,
                x + 2 * u,
                __add(y, h),
                w - 4 * u,
                2 * u,
                "rgba(0,0,0,.4)"
            )
            R(
                nil,
                c,
                __add(x, w),
                y + 2 * u,
                u,
                h - 3 * u,
                "rgba(0,0,0,.3)"
            )
        end
        R(
            nil,
            c,
            x + 2 * u,
            y,
            w - 4 * u,
            h,
            borda
        )
        R(
            nil,
            c,
            x,
            y + 2 * u,
            w,
            h - 4 * u,
            borda
        )
        R(
            nil,
            c,
            __add(x, u),
            __add(y, u),
            w - 2 * u,
            h - 2 * u,
            borda
        )
        R(
            nil,
            c,
            x + 3 * u,
            y + 2 * u,
            w - 6 * u,
            h - 4 * u,
            fundo
        )
        R(
            nil,
            c,
            x + 2 * u,
            y + 3 * u,
            w - 4 * u,
            h - 6 * u,
            fundo
        )
        R(
            nil,
            c,
            x + 3 * u,
            y + 2 * u,
            w - 6 * u,
            u,
            luz
        )
        R(
            nil,
            c,
            x + 3 * u,
            __add(y, h) - 3 * u,
            w - 6 * u,
            u,
            escuro
        )
        if __t(tema.rebite) then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({x + 3 * u, y + 3 * u}, 2),
                    __arrL(
                        {
                            __add(x, w) - 4 * u,
                            y + 3 * u
                        },
                        2
                    ),
                    __arrL(
                        {
                            x + 3 * u,
                            __add(y, h) - 4 * u
                        },
                        2
                    ),
                    __arrL(
                        {
                            __add(x, w) - 4 * u,
                            __add(y, h) - 4 * u
                        },
                        2
                    )
                },
                4
            ))) do
                local px = ____value[1]
                local py = ____value[2]
                R(
                    nil,
                    c,
                    px,
                    py,
                    u,
                    u,
                    tema.rebite
                )
            end
        end
    end
    local function barra(self, c, x, y, w, h, valor, o)
        if o == nil then
            o = {}
        end
        local ____t_result_5
        if __t(o.u) then
            ____t_result_5 = o.u
        else
            ____t_result_5 = 1
        end
        local u = ____t_result_5
        local ____t_result_6
        if __t(o.gomos) then
            ____t_result_6 = o.gomos
        else
            ____t_result_6 = math.max(
                6,
                math.floor(w / (6 * u) + 0.5)
            )
        end
        local n = ____t_result_6
        local gw = (w - 2 * u) / n
        local ____array_8 = __TS__SparseArrayNew(
            nil,
            c,
            x - u,
            y - u,
            w + 2 * u,
            h + 2 * u
        )
        local ____t_result_7
        if __t(o.borda) then
            ____t_result_7 = o.borda
        else
            ____t_result_7 = "#0a0a14"
        end
        __TS__SparseArrayPush(____array_8, ____t_result_7)
        R(__TS__SparseArraySpread(____array_8))
        local ____array_10 = __TS__SparseArrayNew(
            nil,
            c,
            x,
            y,
            w,
            h
        )
        local ____t_result_9
        if __t(o.fundo) then
            ____t_result_9 = o.fundo
        else
            ____t_result_9 = "#2a2438"
        end
        __TS__SparseArrayPush(____array_10, ____t_result_9)
        R(__TS__SparseArraySpread(____array_10))
        do
            local i = 0
            while __lt(i, n) do
                local a = i / n
                local b = (i + 1) / n
                local gx = __add(x, u) + i * gw
                local ____t_result_11
                if __t(o.vazio) then
                    ____t_result_11 = o.vazio
                else
                    ____t_result_11 = "#3a3450"
                end
                local cor = ____t_result_11
                local ____t_15 = __t
                local ____t_result_14
                local ____t_13 = __t
                local ____t_result_12
                if __t(o.ruim) then
                    ____t_result_12 = __gt(
                        b,
                        __get(o.ruim, 0)
                    )
                else
                    ____t_result_12 = o.ruim
                end
                __O[141] = ____t_result_12
                if ____t_13(____t_result_12) then
                    ____t_result_14 = __lt(
                        a,
                        __get(o.ruim, 1)
                    )
                else
                    ____t_result_14 = __O[141]
                end
                if ____t_15(____t_result_14) then
                    local ____t_result_16
                    if __t(o.ruimCor) then
                        ____t_result_16 = o.ruimCor
                    else
                        ____t_result_16 = "#a84a4a"
                    end
                    cor = ____t_result_16
                end
                local ____t_20 = __t
                local ____t_result_19
                local ____t_18 = __t
                local ____t_result_17
                if __t(o.zona) then
                    ____t_result_17 = __gt(
                        b,
                        __get(o.zona, 0)
                    )
                else
                    ____t_result_17 = o.zona
                end
                __O[142] = ____t_result_17
                if ____t_18(____t_result_17) then
                    ____t_result_19 = __lt(
                        a,
                        __get(o.zona, 1)
                    )
                else
                    ____t_result_19 = __O[142]
                end
                if ____t_20(____t_result_19) then
                    local ____t_result_21
                    if __t(o.zonaCor) then
                        ____t_result_21 = o.zonaCor
                    else
                        ____t_result_21 = "#6ad86a"
                    end
                    cor = ____t_result_21
                end
                local ____t_23 = __t
                local ____t_result_22
                if __t(o.cheio) then
                    ____t_result_22 = __ge(valor, b)
                else
                    ____t_result_22 = o.cheio
                end
                if ____t_23(____t_result_22) then
                    cor = o.cheio
                end
                R(
                    nil,
                    c,
                    gx,
                    __add(y, u),
                    math.max(u, gw - u),
                    h - 2 * u,
                    cor
                )
                R(
                    nil,
                    c,
                    gx,
                    __add(y, u),
                    math.max(u, gw - u),
                    u,
                    "rgba(255,255,255,.25)"
                )
                i = i + 1
            end
        end
        if __t(o.marcador) then
            local mx = x + valor * w
            R(
                nil,
                c,
                mx - 2 * u,
                y - 3 * u,
                4 * u,
                h + 6 * u,
                "#0a0a14"
            )
            R(
                nil,
                c,
                mx - u,
                y - 2 * u,
                2 * u,
                h + 4 * u,
                o.marcador
            )
            R(
                nil,
                c,
                mx - u,
                y - 2 * u,
                u,
                h + 4 * u,
                "#ffffff"
            )
        end
    end
    local function faixas(self, c, x, y, w, h, cores)
        local n = __len(cores)
        local bh = h / n
        do
            local i = 0
            while __lt(i, n) do
                local y0 = math.floor(y + i * bh + 0.5)
                local y1 = math.floor(y + (i + 1) * bh + 0.5)
                R(
                    nil,
                    c,
                    x,
                    y0,
                    w,
                    y1 - y0,
                    __get(cores, i)
                )
                if i < n - 1 then
                    do
                        local k = 0
                        while k < 2 do
                            do
                                local xx = x + __mod(k + i, 2)
                                while __lt(
                                    xx,
                                    __add(x, w)
                                ) do
                                    R(
                                        nil,
                                        c,
                                        xx,
                                        y1 - 1 - k,
                                        1,
                                        1,
                                        __get(cores, i + 1)
                                    )
                                    xx = xx + (2 + k * 2)
                                end
                            end
                            k = k + 1
                        end
                    end
                end
                i = i + 1
            end
        end
    end
    local SETA = __arrL({
        "....#....",
        "...###...",
        "..#####..",
        ".#######.",
        "#########",
        "..#####..",
        "..#####..",
        "..#####..",
        "..#####.."
    }, 9)
    local function setaSprite(self, dir, cor, borda)
        local k = __add(
            __add(dir, cor),
            borda
        )
        if __t(__get(cache, k)) then
            return __get(cache, k)
        end
        local N = 9
        local cv, c = table.unpack(
            mk(nil, N + 2, N + 2),
            1,
            2
        )
        local function on(____, x, y)
            local sx = x
            local sy = y
            if dir == 1 then
                sx = x
                sy = N - 1 - y
            elseif dir == 0 then
                sx = y
                sy = x
            elseif dir == 3 then
                sx = y
                sy = N - 1 - x
            end
            return __getq(
                __get(SETA, sy),
                sx
            ) == "#"
        end
        do
            local y = 0
            while y < N do
                do
                    local x = 0
                    while x < N do
                        if __t(on(nil, x, y)) then
                            for ____, ____value in __iterar((__arrL(
                                {
                                    __arrL({0, 0}, 2),
                                    __arrL({1, 0}, 2),
                                    __arrL({2, 0}, 2),
                                    __arrL({0, 1}, 2),
                                    __arrL({2, 1}, 2),
                                    __arrL({0, 2}, 2),
                                    __arrL({1, 2}, 2),
                                    __arrL({2, 2}, 2)
                                },
                                8
                            ))) do
                                local dx = ____value[1]
                                local dy = ____value[2]
                                R(
                                    nil,
                                    c,
                                    x + dx,
                                    y + dy,
                                    1,
                                    1,
                                    borda
                                )
                            end
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        do
            local y = 0
            while y < N do
                do
                    local x = 0
                    while x < N do
                        if __t(on(nil, x, y)) then
                            R(
                                nil,
                                c,
                                x + 1,
                                y + 1,
                                1,
                                1,
                                cor
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        do
            local y = 0
            while y < N do
                do
                    local x = 0
                    while x < N do
                        local ____t_27 = __t
                        local ____t_result_26
                        local ____t_25 = __t
                        local ____on_result_24 = on(nil, x, y)
                        __O[143] = ____on_result_24
                        if ____t_25(____on_result_24) then
                            ____t_result_26 = not __t(on(nil, x - 1, y)) or not __t(on(nil, x, y - 1))
                        else
                            ____t_result_26 = __O[143]
                        end
                        if ____t_27(____t_result_26) then
                            R(
                                nil,
                                c,
                                x + 1,
                                y + 1,
                                1,
                                1,
                                "rgba(255,255,255,.55)"
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        return __set(cache, k, cv)
    end
    local function seta(self, c, x, y, dir, cor, esc, borda)
        if esc == nil then
            esc = 2
        end
        if borda == nil then
            borda = "#0a0610"
        end
        local s = setaSprite(nil, dir, cor, borda)
        local w = s.width * esc
        c:drawImage(
            s,
            math.floor(x - w / 2 + 0.5),
            math.floor(y - w / 2 + 0.5),
            w,
            w
        )
    end
    local function alvoSprite(self, dir, cor)
        local k = __add(
            __add("alvo", dir),
            cor
        )
        if __t(__get(cache, k)) then
            return __get(cache, k)
        end
        local base = setaSprite(nil, dir, "#000000", "#000000")
        local cv, c = table.unpack(
            mk(nil, base.width, base.height),
            1,
            2
        )
        local N = base.width
        local d = base:getContext("2d"):getImageData(0, 0, N, N).data
        local function cheio(____, x, y)
            local ____t_result_34
            local ____t_33 = __t
            local ____t_result_32
            local ____t_31 = __t
            local ____t_result_30
            local ____t_29 = __t
            local ____temp_28 = __ge(x, 0) and __ge(y, 0)
            __O[144] = ____temp_28
            if ____t_29(____temp_28) then
                ____t_result_30 = __lt(x, N)
            else
                ____t_result_30 = __O[144]
            end
            __O[145] = ____t_result_30
            if ____t_31(____t_result_30) then
                ____t_result_32 = __lt(y, N)
            else
                ____t_result_32 = __O[145]
            end
            __O[146] = ____t_result_32
            if ____t_33(____t_result_32) then
                ____t_result_34 = __gt(
                    __get(d, (y * N + x) * 4 + 3),
                    0
                )
            else
                ____t_result_34 = __O[146]
            end
            return ____t_result_34
        end
        do
            local y = 0
            while __lt(y, N) do
                do
                    local x = 0
                    while __lt(x, N) do
                        local ____t_43 = __t
                        local ____t_result_42
                        local ____t_36 = __t
                        local ____cheio_result_35 = cheio(nil, x, y)
                        __O[149] = ____cheio_result_35
                        if ____t_36(____cheio_result_35) then
                            local ____t_result_41
                            local ____t_40 = __t
                            local ____t_result_39
                            local ____t_38 = __t
                            local ____temp_37 = not __t(cheio(nil, x - 1, y)) or not __t(cheio(nil, x + 1, y))
                            __O[147] = ____temp_37
                            if ____t_38(____temp_37) then
                                ____t_result_39 = __O[147]
                            else
                                ____t_result_39 = not __t(cheio(nil, x, y - 1))
                            end
                            __O[148] = ____t_result_39
                            if ____t_40(____t_result_39) then
                                ____t_result_41 = __O[148]
                            else
                                ____t_result_41 = not __t(cheio(nil, x, y + 1))
                            end
                            ____t_result_42 = ____t_result_41
                        else
                            ____t_result_42 = __O[149]
                        end
                        if ____t_43(____t_result_42) then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                cor
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        return __set(cache, k, cv)
    end
    local function alvo(self, c, x, y, dir, cor, esc)
        if esc == nil then
            esc = 2
        end
        local s = alvoSprite(nil, dir, cor)
        local w = s.width * esc
        c:drawImage(
            s,
            math.floor(x - w / 2 + 0.5),
            math.floor(y - w / 2 + 0.5),
            w,
            w
        )
    end
    local function estrela(self, c, x, y, r, cor)
        R(
            nil,
            c,
            x - r,
            y,
            r * 2 + 1,
            1,
            cor
        )
        R(
            nil,
            c,
            x,
            y - r,
            1,
            r * 2 + 1,
            cor
        )
        if __gt(r, 2) then
            R(
                nil,
                c,
                x - 1,
                y - 1,
                3,
                3,
                cor
            )
        end
        R(
            nil,
            c,
            x,
            y,
            1,
            1,
            "#ffffff"
        )
    end
    local function brilho4(self, c, x, y, r, cor)
        do
            local i = 1
            while __le(i, r) do
                local a = 1 - i / (r + 1)
                c.globalAlpha = a
                R(
                    nil,
                    c,
                    x - i,
                    y,
                    1,
                    1,
                    cor
                )
                R(
                    nil,
                    c,
                    x + i,
                    y,
                    1,
                    1,
                    cor
                )
                R(
                    nil,
                    c,
                    x,
                    y - i,
                    1,
                    1,
                    cor
                )
                R(
                    nil,
                    c,
                    x,
                    y + i,
                    1,
                    1,
                    cor
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
        R(
            nil,
            c,
            x,
            y,
            1,
            1,
            "#ffffff"
        )
    end
    local PEIXE = __arrL({
        "......####......",
        "....##oooo#.....",
        "..##ooooooo#...#",
        ".#e#oollooooo.##",
        "#ooooollloooo###",
        ".#oooooooooo..##",
        "..##bbbbbbb#...#",
        "....##bbb##.....",
        "......###......."
    }, 9)
    local ESPECIES = __ord(
        {
            ["TILÁPIA"] = __arrL({"#8a98a0", "#b8c4c8", "#5a6870", "listra"}, 4),
            ["TRAÍRA"] = __arrL({"#5a6a3a", "#8a9a5a", "#3a4a24", "pinta"}, 4),
            PIABA = __arrL({"#c8c8b0", "#f2f2e0", "#9a9a80", ""}, 4),
            ["CARÁ"] = __arrL({"#b8844a", "#e0b070", "#7a5428", "faixa"}, 4),
            ["TUCUNARÉ"] = __arrL({"#c8b030", "#f2d84a", "#6a7a2a", "olho"}, 4)
        },
        "TILÁPIA,TRAÍRA,PIABA,CARÁ,TUCUNARÉ"
    )
    local function peixeSprite(self, tipo)
        local k = __add("peixe", tipo)
        if __t(__get(cache, k)) then
            return __get(cache, k)
        end
        local ____t_result_46
        local ____t_45 = __t
        local ____get_result_44 = __get(ESPECIES, tipo)
        __O[150] = ____get_result_44
        if ____t_45(____get_result_44) then
            ____t_result_46 = __O[150]
        else
            ____t_result_46 = ESPECIES["TILÁPIA"]
        end
        local o, l, e, marca = table.unpack(____t_result_46, 1, 4)
        local cv, c = table.unpack(
            mk(nil, 16, 9),
            1,
            2
        )
        __call(
            PEIXE,
            "forEach",
            function(____, row, y)
                do
                    local x = 0
                    while x < 16 do
                        do
                            local ch = __get(row, x)
                            if ch == "." then
                                do x = x + 1 continue end
                            end
                            local ____array_49 = __TS__SparseArrayNew(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1
                            )
                            local ____temp_48
                            if ch == "#" then
                                ____temp_48 = e
                            else
                                local ____temp_47
                                if ch == "l" then
                                    ____temp_47 = l
                                else
                                    ____temp_47 = ch == "b" and "#e8e8dc" or (ch == "e" and "#1c1c1c" or o)
                                end
                                ____temp_48 = ____temp_47
                            end
                            __TS__SparseArrayPush(____array_49, ____temp_48)
                            R(__TS__SparseArraySpread(____array_49))
                        end
                        x = x + 1
                    end
                end
            end
        )
        R(
            nil,
            c,
            2,
            3,
            1,
            1,
            "#ffffff"
        )
        if marca == "listra" then
            for ____, x in __iterar((__arrL({6, 9, 12}, 3))) do
                R(
                    nil,
                    c,
                    x,
                    2,
                    1,
                    4,
                    e
                )
            end
        end
        if marca == "pinta" then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({6, 2}, 2),
                    __arrL({9, 4}, 2),
                    __arrL({11, 2}, 2),
                    __arrL({7, 5}, 2)
                },
                4
            ))) do
                local x = ____value[1]
                local y = ____value[2]
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    e
                )
            end
        end
        if marca == "faixa" then
            for ____, x in __iterar((__arrL({5, 8, 11}, 3))) do
                R(
                    nil,
                    c,
                    x,
                    1,
                    2,
                    6,
                    e
                )
            end
        end
        if marca == "olho" then
            R(
                nil,
                c,
                12,
                3,
                2,
                2,
                "#1c1c1c"
            )
            R(
                nil,
                c,
                12,
                3,
                1,
                1,
                "#e8843a"
            )
            for ____, x in __iterar((__arrL({5, 8}, 2))) do
                R(
                    nil,
                    c,
                    x,
                    2,
                    1,
                    4,
                    "#3a4a1a"
                )
            end
        end
        return __set(cache, k, cv)
    end
    local function peixe(self, c, tipo, x, y, esc, olhandoDireita)
        if esc == nil then
            esc = 1
        end
        if olhandoDireita == nil then
            olhandoDireita = false
        end
        local s = peixeSprite(nil, tipo)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        if __t(olhandoDireita) then
            c:scale(-1, 1)
        end
        c:drawImage(
            s,
            math.floor(-8 * esc + 0.5),
            math.floor(-4.5 * esc + 0.5),
            16 * esc,
            9 * esc
        )
        c:restore()
    end
    local function pessoa(self, c, x, y, pele, roupa, cabelo, pula, braco)
        local dy = __t(pula) and -1 or 0
        R(
            nil,
            c,
            x + 1,
            y + dy,
            4,
            4,
            pele
        )
        R(
            nil,
            c,
            x + 1,
            y + dy,
            4,
            1,
            cabelo
        )
        R(
            nil,
            c,
            x,
            y + 4 + dy,
            6,
            8,
            roupa
        )
        if __t(braco) then
            R(
                nil,
                c,
                x - 1,
                y - 2 + dy,
                1,
                6,
                pele
            )
            R(
                nil,
                c,
                x + 6,
                y - 2 + dy,
                1,
                6,
                pele
            )
        end
    end
    window.PixelKit = __ord(
        {
            R = R,
            hash = hash,
            mk = mk,
            texto = texto,
            contorno = contorno,
            painel = painel,
            barra = barra,
            faixas = faixas,
            seta = seta,
            alvo = alvo,
            estrela = estrela,
            brilho4 = brilho4,
            peixe = peixe,
            pessoa = pessoa,
            ESPECIES = __keys(ESPECIES)
        },
        "R,hash,mk,texto,contorno,painel,barra,faixas,seta,alvo,estrela,brilho4,peixe,pessoa,ESPECIES"
    )
end)(nil)
return ____exports
