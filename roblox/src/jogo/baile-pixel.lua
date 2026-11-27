--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __arr, __len, __call, __add, __new, __iter, __bor, __band, __shl, __shr, __hypot = __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__bor, __JSR.__band, __JSR.__shl, __JSR.__shr, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local Set = ____lualib.Set
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__New = ____lualib.__TS__New
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Map = ____lualib.Map
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.BailePixel) then
        return
    end
    local TAU = math.pi * 2
    local BPM = 2.15
    local N = 8
    local CONTORNO = __arrL({22, 14, 34}, 3)
    local PRETO = "#141018"
    local BRANCO = "#ffffff"
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local g = nil
    local AX = 0
    local AY = 0
    local planas = nil
    local function plana(____, col)
        __call(planas, "add", col)
        return col
    end
    local function r(____, x, y, w, h, col)
        w = math.floor(w + 0.5)
        h = math.floor(h + 0.5)
        if __t(__le(w, 0) or __le(h, 0)) then
            return
        end
        g.fillStyle = col
        g:fillRect(
            math.floor(x + 0.5) + AX,
            math.floor(y + 0.5) + AY,
            w,
            h
        )
    end
    local function p(____, x, y, col)
        return r(
            nil,
            x,
            y,
            1,
            1,
            col
        )
    end
    local function e(____, cx, cy, rx, ry, col)
        do
            local y = __TS__Number(-ry)
            while __le(y, ry) do
                local k = y / (ry + 0.5)
                local w = math.floor(rx * math.sqrt(math.max(0, 1 - k * k)) + 0.25 + 0.5)
                r(
                    nil,
                    cx - w,
                    cy + y,
                    w * 2 + 1,
                    1,
                    col
                )
                y = y + 1
            end
        end
    end
    local function poly(self, pts, col)
        local y0 = math.huge
        local y1 = -math.huge
        for ____, ____value in __iterar((pts)) do
            local y = ____value[2]
            y0 = math.min(y0, y)
            y1 = math.max(y1, y)
        end
        do
            local y = math.floor(y0)
            while y <= math.ceil(y1) do
                local yc = y + 0.5
                local xs = __arrL({}, 0)
                do
                    local i = 0
                    while __lt(
                        i,
                        __len(pts)
                    ) do
                        local ax, ay = table.unpack(
                            __get(pts, i),
                            1,
                            2
                        )
                        local bx, by = table.unpack(
                            __get(
                                pts,
                                __mod(
                                    i + 1,
                                    __len(pts)
                                )
                            ),
                            1,
                            2
                        )
                        local ____t_2 = __t
                        local ____t_1 = __t
                        local ____temp_0 = __le(ay, yc) and __gt(by, yc)
                        __O[1367] = ____temp_0
                        if ____t_2(if ____t_1(____temp_0) then __O[1367] else __le(by, yc) and __gt(ay, yc)) then
                            __call(xs, "push", ax + (yc - ay) / (by - ay) * (bx - ax))
                        end
                        i = i + 1
                    end
                end
                __call(
                    xs,
                    "sort",
                    function(____, a, b) return a - b end
                )
                do
                    local i = 0
                    while i + 1 < __len(xs) do
                        local a = math.floor(__get(xs, i) + 0.5)
                        local b = math.floor(__get(xs, i + 1) + 0.5)
                        r(
                            nil,
                            a,
                            y,
                            math.max(1, b - a),
                            1,
                            col
                        )
                        i = i + 2
                    end
                end
                y = y + 1
            end
        end
    end
    local function barra(____, x0, y0, x1, y1, w, col)
        local dx = x1 - x0
        local dy = y1 - y0
        local ____t_4 = __t
        local ____hypot_result_3 = __hypot(dx, dy)
        __O[1368] = ____hypot_result_3
        local L = if ____t_4(____hypot_result_3) then __O[1368] else 1
        local nx = -dy / L * w / 2
        local ny = dx / L * w / 2
        poly(
            nil,
            __arrL(
                {
                    __arrL({x0 + nx, y0 + ny}, 2),
                    __arrL({x1 + nx, y1 + ny}, 2),
                    __arrL({x1 - nx, y1 - ny}, 2),
                    __arrL({x0 - nx, y0 - ny}, 2)
                },
                4
            ),
            col
        )
    end
    local function mistura(____, a, b, k)
        return __call(
            __arrL({0, 1, 2}, 3),
            "map",
            function(____, i) return math.floor(__get(a, i) + (__get(b, i) - __get(a, i)) * k + 0.5) end
        )
    end
    local LUZ = __arrL({255, 240, 250}, 3)
    local SOMBRA = __arrL({26, 16, 48}, 3)
    local function acabamento(self, cv)
        local W = cv.width
        local H = cv.height
        local ctx = cv:getContext("2d")
        local img = ctx:getImageData(0, 0, W, H)
        local d = img.data
        local cor = __call(
            __new("Int32Array", W * H),
            "fill",
            -1
        )
        do
            local i = 0
            while i < W * H do
                if __gt(
                    __get(d, i * 4 + 3),
                    127
                ) then
                    __set(
                        cor,
                        i,
                        __bor(
                            __bor(
                                __shl(
                                    __get(d, i * 4),
                                    16
                                ),
                                __shl(
                                    __get(d, i * 4 + 1),
                                    8
                                )
                            ),
                            __get(d, i * 4 + 2)
                        )
                    )
                end
                i = i + 1
            end
        end
        local function em(____, x, y)
            local ____t_9 = __t
            local ____t_8 = __t
            local ____t_6 = __t
            local ____temp_5 = __lt(x, 0) or __lt(y, 0)
            __O[1369] = ____temp_5
            local ____temp_7 = if ____t_6(____temp_5) then __O[1369] else __ge(x, W)
            __O[1370] = ____temp_7
            return if ____t_9(if ____t_8(____temp_7) then __O[1370] else __ge(y, H)) then -1 else __get(cor, y * W + x)
        end
        local plano = __TS__New(
            Set,
            __call(
                __arr(__TS__Spread(__iter(planas))),
                "map",
                function(____, c) return __TS__ParseInt(
                    __call(c, "slice", 1),
                    16
                ) end
            )
        )
        local out = __new(
            "Uint8ClampedArray",
            __len(d)
        )
        do
            local y = 0
            while __lt(y, H) do
                do
                    local x = 0
                    while __lt(x, W) do
                        local i = y * W + x
                        local c = __get(cor, i)
                        if c < 0 then
                            local ____t_14 = __t
                            local ____t_13 = __t
                            local ____t_11 = __t
                            local ____temp_10 = em(nil, x - 1, y) >= 0 or em(nil, x + 1, y) >= 0
                            __O[1371] = ____temp_10
                            local ____temp_12 = if ____t_11(____temp_10) then __O[1371] else em(nil, x, y - 1) >= 0
                            __O[1372] = ____temp_12
                            if ____t_14(if ____t_13(____temp_12) then __O[1372] else em(nil, x, y + 1) >= 0) then
                                local ____call_17 = __call
                                local ____arr_16 = __arr
                                local ____array_15 = __TS__SparseArrayNew(__TS__Spread(__iter(CONTORNO)))
                                __TS__SparseArrayPush(____array_15, 255)
                                ____call_17(
                                    out,
                                    "set",
                                    ____arr_16(__TS__SparseArraySpread(____array_15)),
                                    i * 4
                                )
                            end
                            continue
                        end
                        local rgb = __arrL(
                            {
                                __band(
                                    __shr(c, 16),
                                    255
                                ),
                                __band(
                                    __shr(c, 8),
                                    255
                                ),
                                __band(c, 255)
                            },
                            3
                        )
                        if not __t(__call(plano, "has", c)) then
                            local cima = em(nil, x, y - 1) ~= c
                            local baixo = em(nil, x, y + 1) ~= c
                            local dir = em(nil, x + 1, y) ~= c
                            if __t(if __t(cima) then not __t(baixo) else cima) then
                                rgb = mistura(nil, rgb, LUZ, 0.3)
                            elseif __t(if __t(baixo) then baixo else dir) then
                                rgb = mistura(nil, rgb, SOMBRA, if __t(if __t(baixo) then dir else baixo) then 0.42 else 0.28)
                            elseif em(nil, x, y + 2) ~= c then
                                rgb = mistura(nil, rgb, SOMBRA, 0.12)
                            end
                        end
                        local ____call_20 = __call
                        local ____arr_19 = __arr
                        local ____array_18 = __TS__SparseArrayNew(__TS__Spread(__iter(rgb)))
                        __TS__SparseArrayPush(____array_18, 255)
                        ____call_20(
                            out,
                            "set",
                            ____arr_19(__TS__SparseArraySpread(____array_18)),
                            i * 4
                        )
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        __call(img.data, "set", out)
        ctx:putImageData(img, 0, 0)
    end
    local cache = __TS__New(Map)
    local function sprite(self, chave, W, H, ax, ay, fn)
        local q = __call(cache, "get", chave)
        if __t(q) then
            return q
        end
        local cv = window.document:createElement("canvas")
        cv.width = W
        cv.height = H
        g = cv:getContext("2d", {willReadFrequently = true})
        AX = ax
        AY = ay
        planas = __TS__New(
            Set,
            __arrL({BRANCO, PRETO}, 2)
        )
        do
            local function ____catch(err)
                do
                    pcall(function()
                        print("baile", chave, err)
                    end)
                end
            end
            local ____try, ____hasReturned = pcall(function()
                fn(nil)
                acabamento(nil, cv)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        local br = window.document:createElement("canvas")
        br.width = W
        br.height = H
        local b = br:getContext("2d")
        b:drawImage(cv, 0, 0)
        b.globalCompositeOperation = "source-in"
        b.fillStyle = "#fff6ec"
        b:fillRect(0, 0, W, H)
        q = {cv = cv, br = br, ax = ax, ay = ay}
        __call(cache, "set", chave, q)
        g = nil
        return q
    end
    local function pintar(self, c, q, x, y, s, flip, branco)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        if __t(flip) then
            c:scale(-1, 1)
        end
        local sm = c.imageSmoothingEnabled
        c.imageSmoothingEnabled = false
        c:drawImage(
            if __t(branco) then q.br else q.cv,
            __TS__Number(-q.ax) * s,
            __TS__Number(-q.ay) * s,
            q.cv.width * s,
            q.cv.height * s
        )
        c.imageSmoothingEnabled = sm
        c:restore()
    end
    local PELES = __call(
        __arrL(
            {
                __arrL({"#8d583f"}, 1),
                __arrL({"#e4b596"}, 1),
                __arrL({"#b47c55"}, 1),
                __arrL({"#6f4838"}, 1),
                __arrL({"#eec9ae"}, 1),
                __arrL({"#5c3a2c"}, 1),
                __arrL({"#c8946a"}, 1)
            },
            7
        ),
        "map",
        function(____, a) return __get(a, 0) end
    )
    local CABELOS = __arrL({
        "#1b1414",
        "#3a2418",
        "#6b3e22",
        "#c9a050",
        "#1b1414",
        "#7a2a4a",
        "#e8e0d0",
        "#2a1a3a"
    }, 8)
    local TOPS = __arrL({
        "#e2445c",
        "#2d9cdb",
        "#f2c94c",
        "#27ae60",
        "#9b51e0",
        "#f2f2f2",
        "#262630",
        "#ff7a45",
        "#ff6ad5",
        "#3ad8c8"
    }, 10)
    local BAIXOS = __arrL({
        "#2a3a5c",
        "#3c3a55",
        "#1f2a36",
        "#5a3a2a",
        "#d6d0c4",
        "#4a6a9a",
        "#262630"
    }, 7)
    local TENIS = __arrL({
        "#f4f4f4",
        "#ff5a5a",
        "#2d9cdb",
        "#f2c94c",
        "#262630",
        "#7dff9a"
    }, 6)
    local function tipo(self, v)
        local function h(____, k)
            return hash(nil, v * 13.7 + k * 3.1)
        end
        return {
            pele = __get(
                PELES,
                math.floor(h(nil, 1) * __len(PELES))
            ),
            cabelo = __get(
                CABELOS,
                math.floor(h(nil, 2) * __len(CABELOS))
            ),
            penteado = math.floor(h(nil, 3) * 7),
            top = __get(
                TOPS,
                math.floor(h(nil, 4) * __len(TOPS))
            ),
            topo = math.floor(h(nil, 5) * 5),
            baixo = __get(
                BAIXOS,
                math.floor(h(nil, 6) * __len(BAIXOS))
            ),
            roupa = math.floor(h(nil, 7) * 3),
            tenis = __get(
                TENIS,
                math.floor(h(nil, 8) * __len(TENIS))
            ),
            oculos = h(nil, 9) < 0.22,
            corrente = h(nil, 10) < 0.3,
            brinco = h(nil, 11) < 0.35,
            bone = __get(
                __arrL({"#e2445c", "#262630", "#2d9cdb", "#f2f2f2"}, 4),
                math.floor(h(nil, 12) * 4)
            ),
            passo = math.floor(h(nil, 13) * 7),
            bastao = __get(
                __arrL({"#7dff9a", "#ff7ad9", "#7adfff", "#ffe14f"}, 4),
                math.floor(h(nil, 14) * 4)
            ),
            numero = math.floor(h(nil, 15) * 89) + 10
        }
    end
    local function pessoa(self, v, f)
        local T = tipo(nil, v)
        local ph = f / N * TAU
        local b = math.abs(math.sin(ph))
        local s = math.sin(ph)
        local mv = T.passo
        local bob = -math.floor(b * 1.4 + 0.5)
        local hx = 0
        local tx = 0
        local pe = __arrL(
            {
                __arrL({-3, -1}, 2),
                __arrL({3, -1}, 2)
            },
            2
        )
        local joelho = 0
        if mv == 2 then
            bob = -math.floor(b * 4 + 0.5)
            if b > 0.6 then
                joelho = 2
            end
        end
        if mv == 4 then
            hx = math.floor(s * 2 + 0.5)
            tx = -math.floor(s + 0.5)
            joelho = 2
        end
        if mv == 1 then
            local k = __mod(f, 4)
            if __t(k == 1 or k == 2) then
                if __lt(f, 4) then
                    __set(
                        pe,
                        0,
                        __arrL({-8, -4}, 2)
                    )
                else
                    __set(
                        pe,
                        1,
                        __arrL({8, -4}, 2)
                    )
                end
            end
        end
        local quadril = -15 + bob + joelho
        local ombroY = -25 + bob + joelho
        local cabecaY = -31 + bob + joelho
        local pele = T.pele
        local sk = T.cabelo
        if T.penteado == 1 then
            r(
                nil,
                tx - 5,
                cabecaY - 4,
                11,
                12,
                sk
            )
        end
        if T.penteado == 0 then
            e(
                nil,
                tx,
                cabecaY - 3,
                6,
                5,
                sk
            )
        end
        for ____, ____value in __iterar((__call(pe, "entries"))) do
            local i = ____value[1]
            local fx = ____value[2][1]
            local fy = ____value[2][2]
            local hipX = hx + if __t(i) then 2 else -2
            local footY = fy - if __t(mv == 2 and b > 0.6) then 2 else 0
            barra(
                nil,
                hipX,
                quadril,
                fx + hx * 0.3,
                footY - 1,
                3,
                if T.roupa == 1 then T.baixo else pele
            )
            r(
                nil,
                fx + hx * 0.3 - 2,
                footY - 2,
                5,
                2,
                T.tenis
            )
            r(
                nil,
                fx + hx * 0.3 - 2,
                footY - 1 + 1,
                5,
                1,
                plana(nil, "#e8e8e8")
            )
        end
        if T.roupa == 0 then
            r(
                nil,
                hx - 4,
                quadril - 1,
                9,
                5,
                T.baixo
            )
            r(
                nil,
                hx - 4,
                quadril + 3,
                4,
                1,
                T.baixo
            )
            r(
                nil,
                hx + 1,
                quadril + 3,
                4,
                1,
                T.baixo
            )
        elseif T.roupa == 1 then
            r(
                nil,
                hx - 4,
                quadril - 1,
                9,
                4,
                T.baixo
            )
        else
            poly(
                nil,
                __arrL(
                    {
                        __arrL({hx - 4, quadril - 1}, 2),
                        __arrL({hx + 5, quadril - 1}, 2),
                        __arrL({hx + 7, quadril + 5}, 2),
                        __arrL({hx - 6, quadril + 5}, 2)
                    },
                    4
                ),
                T.baixo
            )
        end
        r(
            nil,
            tx - 4,
            ombroY,
            9,
            quadril - ombroY,
            T.top
        )
        if T.topo == 0 then
            r(
                nil,
                tx - 4,
                ombroY,
                2,
                2,
                pele
            )
            r(
                nil,
                tx + 3,
                ombroY,
                2,
                2,
                pele
            )
        end
        if T.topo == 2 then
            r(
                nil,
                tx - 4,
                ombroY + 3,
                9,
                1,
                BRANCO
            )
            p(
                nil,
                tx - 1,
                ombroY + 5,
                plana(nil, "#ffffff")
            )
            p(nil, tx + 1, ombroY + 5, BRANCO)
            p(nil, tx, ombroY + 6, BRANCO)
        end
        if T.topo == 3 then
            r(
                nil,
                tx - 3,
                quadril - 3,
                7,
                2,
                pele
            )
        end
        if T.topo == 4 then
            r(
                nil,
                tx - 1,
                ombroY,
                3,
                quadril - ombroY,
                "#262630"
            )
            r(
                nil,
                tx - 4,
                ombroY,
                2,
                quadril - ombroY,
                T.baixo
            )
            r(
                nil,
                tx + 3,
                ombroY,
                2,
                quadril - ombroY,
                T.baixo
            )
        end
        local ombE = __arrL({tx - 4, ombroY + 1}, 2)
        local ombD = __arrL({tx + 4, ombroY + 1}, 2)
        local mE
        local mD
        local cE
        local cD
        if mv == 0 then
            mE = __arrL(
                {
                    tx - 6 + math.floor(s * 2 + 0.5),
                    ombroY - 11
                },
                2
            )
            mD = __arrL(
                {
                    tx + 6 + math.floor(s * 2 + 0.5),
                    ombroY - 12
                },
                2
            )
            cE = __arrL({tx - 7, ombroY - 4}, 2)
            cD = __arrL({tx + 7, ombroY - 5}, 2)
        elseif mv == 1 then
            mE = __arrL(
                {
                    tx - 3,
                    ombroY + 5 - math.floor(b * 2 + 0.5)
                },
                2
            )
            mD = __arrL(
                {
                    tx + 3,
                    ombroY + 5 - math.floor((1 - b) * 2 + 0.5)
                },
                2
            )
            cE = __arrL({tx - 8, ombroY + 3}, 2)
            cD = __arrL({tx + 8, ombroY + 3}, 2)
        elseif mv == 2 then
            mE = __arrL(
                {
                    tx - 9,
                    ombroY - 9 - math.floor(b * 2 + 0.5)
                },
                2
            )
            mD = __arrL(
                {
                    tx + 9,
                    ombroY - 9 - math.floor(b * 2 + 0.5)
                },
                2
            )
            cE = __arrL({tx - 7, ombroY - 3}, 2)
            cD = __arrL({tx + 7, ombroY - 3}, 2)
        elseif mv == 3 then
            mE = __arrL(
                {
                    tx - 7,
                    ombroY + 8 + math.floor(s + 0.5)
                },
                2
            )
            mD = __arrL({tx + 4, ombroY - 13}, 2)
            cE = __arrL({tx - 6, ombroY + 4}, 2)
            cD = __arrL({tx + 7, ombroY - 6}, 2)
        elseif mv == 4 then
            mE = __arrL({hx - 5, quadril + 4}, 2)
            mD = __arrL({hx + 5, quadril + 4}, 2)
            cE = __arrL({tx - 7, ombroY + 5}, 2)
            cD = __arrL({tx + 7, ombroY + 5}, 2)
        elseif mv == 5 then
            mE = __arrL(
                {
                    tx - 4,
                    ombroY - 6 - math.floor(b * 6 + 0.5)
                },
                2
            )
            mD = __arrL({tx + 5, quadril}, 2)
            cE = __arrL(
                {
                    tx - 8,
                    ombroY - 2 - math.floor(b * 2 + 0.5)
                },
                2
            )
            cD = __arrL({tx + 7, ombroY + 5}, 2)
        else
            mE = __arrL(
                {
                    tx - 3 + math.floor(s * 5 + 0.5),
                    ombroY - 12
                },
                2
            )
            mD = __arrL(
                {
                    tx + 3 + math.floor(s * 5 + 0.5),
                    ombroY - 12
                },
                2
            )
            cE = __arrL({tx - 6, ombroY - 5}, 2)
            cD = __arrL({tx + 6, ombroY - 5}, 2)
        end
        local ____t_23 = __t
        local ____t_22 = __t
        local ____temp_21 = T.topo == 1 or T.topo == 2
        __O[1373] = ____temp_21
        local manga = if ____t_23(if ____t_22(____temp_21) then __O[1373] else T.topo == 4) then if T.topo == 4 then T.baixo else T.top else pele
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({ombE, cE, mE}, 3),
                __arrL({ombD, cD, mD}, 3)
            },
            2
        ))) do
            local o = ____value[1]
            local cv = ____value[2]
            local m = ____value[3]
            barra(
                nil,
                __get(o, 0),
                __get(o, 1),
                __get(cv, 0),
                __get(cv, 1),
                2,
                manga
            )
            barra(
                nil,
                __get(cv, 0),
                __get(cv, 1),
                __get(m, 0),
                __get(m, 1),
                2,
                pele
            )
            r(
                nil,
                __get(m, 0) - 1,
                __get(m, 1) - 1,
                2,
                2,
                pele
            )
        end
        if mv == 3 then
            r(
                nil,
                __get(mD, 0) - 1,
                __get(mD, 1) - 5,
                3,
                5,
                plana(nil, "#1a1a22")
            )
            r(
                nil,
                __get(mD, 0),
                __get(mD, 1) - 4,
                1,
                3,
                plana(nil, "#c8f4ff")
            )
        end
        if mv == 6 then
            for ____, m in __iterar((__arrL({mE, mD}, 2))) do
                r(
                    nil,
                    __get(m, 0) - 1,
                    __get(m, 1) - 6,
                    1,
                    6,
                    plana(nil, T.bastao)
                )
                p(
                    nil,
                    __get(m, 0) - 1,
                    __get(m, 1) - 7,
                    plana(nil, "#ffffff")
                )
            end
        end
        r(
            nil,
            tx - 1,
            cabecaY + 4,
            3,
            2,
            pele
        )
        e(
            nil,
            tx,
            cabecaY,
            4,
            4,
            pele
        )
        p(
            nil,
            tx - 2,
            cabecaY,
            plana(nil, PRETO)
        )
        p(nil, tx + 1, cabecaY, PRETO)
        r(
            nil,
            tx - 1,
            cabecaY + 2,
            3,
            1,
            plana(nil, if b > 0.7 then "#5a1a2a" else "#8a3a3a")
        )
        p(
            nil,
            tx - 3,
            cabecaY + 1,
            plana(nil, "#e88a8a")
        )
        local P = T.penteado
        if P == 0 then
            r(
                nil,
                tx - 4,
                cabecaY - 4,
                9,
                1,
                sk
            )
        elseif P == 1 then
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                2,
                sk
            )
            r(
                nil,
                tx - 4,
                cabecaY - 3,
                2,
                1,
                sk
            )
        elseif P == 2 then
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                3,
                T.bone
            )
            r(
                nil,
                tx + 2,
                cabecaY - 3,
                4,
                1,
                T.bone
            )
        elseif P == 3 then
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                2,
                sk
            )
            r(
                nil,
                tx - 5,
                cabecaY - 3,
                1,
                9,
                sk
            )
            r(
                nil,
                tx + 4,
                cabecaY - 3,
                1,
                9,
                sk
            )
        elseif P == 4 then
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                2,
                sk
            )
            e(
                nil,
                tx,
                cabecaY - 7,
                2,
                2,
                sk
            )
        elseif P == 5 then
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                2,
                sk
            )
        else
            r(
                nil,
                tx - 4,
                cabecaY - 5,
                9,
                2,
                sk
            )
            r(
                nil,
                tx - 4,
                cabecaY - 3,
                9,
                1,
                "#e2445c"
            )
            p(nil, tx + 5, cabecaY - 3, "#e2445c")
        end
        if __t(T.oculos) then
            r(
                nil,
                tx - 3,
                cabecaY - 1,
                7,
                2,
                plana(nil, "#101018")
            )
            p(
                nil,
                tx - 2,
                cabecaY - 1,
                plana(nil, "#8ad8ff")
            )
        end
        if __t(T.corrente) then
            r(
                nil,
                tx - 2,
                ombroY + 1,
                5,
                1,
                plana(nil, "#f2c94c")
            )
            p(nil, tx, ombroY + 2, "#f2c94c")
        end
        if __t(T.brinco) then
            p(
                nil,
                tx - 5,
                cabecaY + 1,
                plana(nil, "#f2c94c")
            )
        end
    end
    local VARIANTES = 40
    local function dancer(self, c, x, y, t, seed, scale)
        if seed == nil then
            seed = 0
        end
        if scale == nil then
            scale = 1
        end
        local v = __mod(
            __mod(seed, VARIANTES) + VARIANTES,
            VARIANTES
        )
        local desloc = __mod(seed, 3) * 2
        local f = __mod(
            __mod(
                math.floor(t * BPM * 4) + desloc,
                N
            ) + N,
            N
        )
        local q = sprite(
            nil,
            __add(
                __add(
                    __add("p", v),
                    "_"
                ),
                f
            ),
            30,
            50,
            15,
            48,
            function() return pessoa(nil, v, f) end
        )
        c:save()
        c.globalAlpha = c.globalAlpha * 0.35
        c.fillStyle = "#0a0818"
        c:fillRect(
            math.floor(x - 12 * scale + 0.5),
            math.floor(y - 2 + 0.5),
            math.floor(24 * scale + 0.5),
            3
        )
        c:restore()
        pintar(
            nil,
            c,
            q,
            x,
            y,
            2 * scale,
            __mod(
                math.floor(seed / VARIANTES) + seed,
                2
            ) == 1
        )
        return true
    end
    local OP = __ord({
        pele = "#ecc4a8",
        bochecha = "#f08a8a",
        moletom = "#2e3650",
        moletomEsc = "#232a40",
        short = "#3a6aa8",
        cabelo = "#1e1a26"
    }, "pele,bochecha,moletom,moletomEsc,short,cabelo")
    local function orelha(self, lado, cx, cy, abre)
        local ox = cx + lado * (9 + abre)
        e(
            nil,
            ox,
            cy,
            4 + if __gt(abre, 3) then 1 else 0,
            6,
            OP.pele
        )
        e(
            nil,
            __add(ox, lado),
            cy,
            2,
            4,
            "#f0a0a8"
        )
        p(nil, ox + lado * 2, cy - 5, "#f6d8c4")
    end
    local function ollyanFesta(self, f, feliz)
        local sw = __get(
            __arrL({
                0,
                1,
                2,
                1,
                0,
                -1,
                -2,
                -1
            }, 8),
            f
        )
        local sw2 = math.floor(sw * 1.5 + 0.5)
        local passoE = __get(
            __arrL({
                0,
                1,
                2,
                1,
                0,
                0,
                0,
                0
            }, 8),
            f
        )
        local passoD = __get(
            __arrL({
                0,
                0,
                0,
                0,
                0,
                1,
                2,
                1
            }, 8),
            f
        )
        barra(
            nil,
            -2,
            -30,
            -4 - passoE,
            -3,
            2,
            OP.pele
        )
        barra(
            nil,
            2,
            -30,
            4 + passoD,
            -3,
            2,
            OP.pele
        )
        r(
            nil,
            -8 - passoE,
            -4,
            6,
            3,
            "#f4f4f4"
        )
        r(
            nil,
            -8 - passoE,
            -2,
            6,
            1,
            plana(nil, "#e8392e")
        )
        r(
            nil,
            2 + passoD,
            -4,
            6,
            3,
            "#f4f4f4"
        )
        r(
            nil,
            2 + passoD,
            -2,
            6,
            1,
            "#e8392e"
        )
        poly(
            nil,
            __arrL(
                {
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) - 7,
                            -37
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) + 7,
                            -37
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) + 8,
                            -27
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) + 1,
                            -27
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5),
                            -31
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) - 1,
                            -27
                        },
                        2
                    ),
                    __arrL(
                        {
                            math.floor(sw / 2 + 0.5) - 8,
                            -27
                        },
                        2
                    )
                },
                7
            ),
            OP.short
        )
        r(
            nil,
            math.floor(sw / 2 + 0.5) - 8,
            -28,
            7,
            1,
            "#5a8ac8"
        )
        r(
            nil,
            math.floor(sw / 2 + 0.5) + 1,
            -28,
            7,
            1,
            "#5a8ac8"
        )
        r(
            nil,
            sw - 5,
            -58,
            11,
            3,
            OP.moletomEsc
        )
        r(
            nil,
            sw - 6,
            -56,
            13,
            20,
            OP.moletom
        )
        r(
            nil,
            sw - 4,
            -43,
            9,
            4,
            OP.moletomEsc
        )
        r(
            nil,
            sw - 6,
            -37,
            13,
            1,
            OP.moletomEsc
        )
        r(
            nil,
            sw - 2,
            -55,
            1,
            7,
            plana(nil, "#e8e8f0")
        )
        r(
            nil,
            sw + 2,
            -55,
            1,
            6,
            "#e8e8f0"
        )
        p(nil, sw - 2, -48, "#e8e8f0")
        p(nil, sw + 2, -49, "#e8e8f0")
        if __t(feliz) then
            local a = if __mod(f, 4) < 2 then 0 else 2
            barra(
                nil,
                sw - 6,
                -54,
                sw - 12,
                -63 - a,
                3,
                OP.moletom
            )
            barra(
                nil,
                sw - 12,
                -63 - a,
                sw - 10,
                -71 - a,
                2,
                OP.pele
            )
            r(
                nil,
                sw - 11,
                -73 - a,
                3,
                3,
                OP.pele
            )
            barra(
                nil,
                sw + 6,
                -54,
                sw + 12,
                -63 + a - 2,
                3,
                OP.moletom
            )
            barra(
                nil,
                sw + 12,
                -65 + a,
                sw + 10,
                -73 + a,
                2,
                OP.pele
            )
            r(
                nil,
                sw + 9,
                -75 + a,
                3,
                3,
                OP.pele
            )
        else
            local fl = __get(
                __arrL({
                    0,
                    -2,
                    -4,
                    -2,
                    0,
                    2,
                    4,
                    2
                }, 8),
                f
            )
            local sl = __get(
                __arrL({
                    0,
                    1,
                    2,
                    1,
                    0,
                    -1,
                    -2,
                    -1
                }, 8),
                f
            )
            barra(
                nil,
                sw - 6,
                -54,
                sw - 12,
                -46 + fl,
                3,
                OP.moletom
            )
            barra(
                nil,
                sw - 12,
                -46 + fl,
                sw - 16,
                -40 + fl * 2,
                2,
                OP.pele
            )
            r(
                nil,
                sw - 17,
                -41 + fl * 2,
                3,
                3,
                OP.pele
            )
            barra(
                nil,
                sw + 6,
                -54,
                sw + 10,
                -45,
                3,
                OP.moletom
            )
            barra(
                nil,
                sw + 10,
                -45,
                sw + 13,
                -50 + sl,
                2,
                OP.pele
            )
            r(
                nil,
                sw + 12,
                -51 + sl,
                3,
                3,
                OP.pele
            )
            r(
                nil,
                sw + 12,
                -58 + sl,
                5,
                7,
                "#e8392e"
            )
            r(
                nil,
                sw + 12,
                -58 + sl,
                5,
                1,
                plana(nil, "#f4f4f4")
            )
            p(nil, sw + 13, -56 + sl, "#ff7a6a")
            if __t(f == 2 or f == 6) then
                p(
                    nil,
                    sw + 18,
                    -57 + sl,
                    plana(nil, "#e8c25a")
                )
                p(nil, sw + 19, -55 + sl, "#e8c25a")
            end
        end
        local ab = if __t(__mod(f, 4) == 1 or __mod(f, 4) == 2) then 1 else 0
        local hy = -66
        orelha(
            nil,
            -1,
            sw2,
            hy - 2,
            2 + ab
        )
        orelha(
            nil,
            1,
            sw2,
            hy - 2,
            2 + (1 - ab)
        )
        r(
            nil,
            sw2 - 1,
            hy + 6,
            3,
            3,
            OP.pele
        )
        e(
            nil,
            sw2,
            hy,
            6,
            7,
            OP.pele
        )
        poly(
            nil,
            __arrL(
                {
                    __arrL({sw2 - 7, hy - 3}, 2),
                    __arrL({sw2 - 6, hy - 8}, 2),
                    __arrL({sw2 - 3, hy - 7}, 2),
                    __arrL({sw2 - 1, hy - 10}, 2),
                    __arrL({sw2 + 2, hy - 7}, 2),
                    __arrL({sw2 + 5, hy - 9}, 2),
                    __arrL({sw2 + 7, hy - 4}, 2),
                    __arrL({sw2 + 4, hy - 5}, 2),
                    __arrL({sw2 + 1, hy - 4}, 2),
                    __arrL({sw2 - 3, hy - 5}, 2)
                },
                10
            ),
            OP.cabelo
        )
        if __t(feliz) then
            r(
                nil,
                sw2 - 4,
                hy - 1,
                2,
                1,
                plana(nil, PRETO)
            )
            r(
                nil,
                sw2 + 2,
                hy - 1,
                2,
                1,
                PRETO
            )
            p(nil, sw2 - 5, hy, PRETO)
            p(nil, sw2 + 4, hy, PRETO)
            r(
                nil,
                sw2 - 3,
                hy + 3,
                6,
                2,
                plana(nil, "#7a2a3a")
            )
            r(
                nil,
                sw2 - 2,
                hy + 3,
                4,
                1,
                plana(nil, BRANCO)
            )
        else
            local pisca = f == 5
            r(
                nil,
                sw2 - 5,
                hy - 1,
                3,
                if __t(pisca) then 1 else 2,
                plana(nil, "#f6ece6")
            )
            r(
                nil,
                sw2 + 2,
                hy - 1,
                3,
                if __t(pisca) then 1 else 2,
                "#f6ece6"
            )
            if not __t(pisca) then
                p(
                    nil,
                    sw2 - 4,
                    hy,
                    plana(nil, PRETO)
                )
                p(nil, sw2 + 3, hy, PRETO)
            end
            r(
                nil,
                sw2 - 5,
                hy - 2,
                3,
                1,
                plana(nil, "#b8826a")
            )
            r(
                nil,
                sw2 + 2,
                hy - 2,
                3,
                1,
                "#b8826a"
            )
            r(
                nil,
                sw2 - 2,
                hy + 4,
                4,
                1,
                plana(nil, "#6f3040")
            )
            p(nil, sw2 + 2, hy + 3, "#6f3040")
        end
        r(
            nil,
            sw2 - 6,
            hy + 2,
            2,
            1,
            plana(nil, OP.bochecha)
        )
        r(
            nil,
            sw2 + 4,
            hy + 2,
            2,
            1,
            OP.bochecha
        )
        p(nil, sw2, hy + 1, "#d8a088")
    end
    local function ollyanVoando(self, f, bravo)
        local fl = __get(
            __arrL({
                -6,
                -3,
                0,
                3,
                5,
                3,
                0,
                -3
            }, 8),
            f
        )
        local pe = __get(
            __arrL({
                0,
                1,
                1,
                0,
                0,
                -1,
                -1,
                0
            }, 8),
            f
        )
        for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
            local function L(____, x)
                return x * lado
            end
            poly(
                nil,
                __arrL(
                    {
                        __arrL(
                            {
                                L(nil, 5),
                                -42
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 22),
                                -48 + fl * 0.4
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 44),
                                -51 + fl
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 66),
                                -47 + fl * 1.3
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 70),
                                -42 + fl * 1.3
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 56),
                                -36 + fl
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 38),
                                -32 + fl * 0.6
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 20),
                                -33
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 6),
                                -35
                            },
                            2
                        )
                    },
                    9
                ),
                OP.pele
            )
            poly(
                nil,
                __arrL(
                    {
                        __arrL(
                            {
                                L(nil, 10),
                                -40
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 26),
                                -44 + fl * 0.4
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 46),
                                -46 + fl
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 60),
                                -43 + fl * 1.2
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 48),
                                -39 + fl
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 30),
                                -37 + fl * 0.5
                            },
                            2
                        ),
                        __arrL(
                            {
                                L(nil, 12),
                                -37
                            },
                            2
                        )
                    },
                    7
                ),
                "#f0a0a8"
            )
            barra(
                nil,
                L(nil, 24),
                -41 + fl * 0.3,
                L(nil, 50),
                -44 + fl,
                1,
                "#d88890"
            )
            barra(
                nil,
                L(nil, 30),
                -37 + fl * 0.4,
                L(nil, 54),
                -40 + fl,
                1,
                "#d88890"
            )
            p(
                nil,
                L(nil, 64),
                -45 + fl * 1.3,
                "#f8dcc8"
            )
        end
        barra(
            nil,
            -2,
            -14,
            -4 + pe,
            -2,
            2,
            OP.pele
        )
        barra(
            nil,
            2,
            -14,
            4 + pe,
            -2,
            2,
            OP.pele
        )
        r(
            nil,
            -7 + pe,
            -3,
            5,
            3,
            "#f4f4f4"
        )
        r(
            nil,
            2 + pe,
            -3,
            5,
            3,
            "#f4f4f4"
        )
        r(
            nil,
            -7 + pe,
            -1,
            5,
            1,
            plana(nil, "#e8392e")
        )
        r(
            nil,
            2 + pe,
            -1,
            5,
            1,
            "#e8392e"
        )
        poly(
            nil,
            __arrL(
                {
                    __arrL({-6, -20}, 2),
                    __arrL({6, -20}, 2),
                    __arrL({7, -13}, 2),
                    __arrL({-7, -13}, 2)
                },
                4
            ),
            OP.short
        )
        r(
            nil,
            -6,
            -33,
            12,
            14,
            OP.moletom
        )
        r(
            nil,
            -4,
            -24,
            8,
            3,
            OP.moletomEsc
        )
        r(
            nil,
            -2,
            -32,
            1,
            6,
            plana(nil, "#e8e8f0")
        )
        r(
            nil,
            2,
            -32,
            1,
            5,
            "#e8e8f0"
        )
        barra(
            nil,
            -6,
            -31,
            -12,
            -24,
            3,
            OP.moletom
        )
        barra(
            nil,
            6,
            -31,
            12,
            -24,
            3,
            OP.moletom
        )
        r(
            nil,
            -14,
            -25,
            3,
            3,
            OP.pele
        )
        r(
            nil,
            11,
            -25,
            3,
            3,
            OP.pele
        )
        r(
            nil,
            -1,
            -36,
            3,
            3,
            OP.pele
        )
        e(
            nil,
            0,
            -41,
            6,
            6,
            OP.pele
        )
        poly(
            nil,
            __arrL(
                {
                    __arrL({-7, -44}, 2),
                    __arrL({-6, -49}, 2),
                    __arrL({-3, -48}, 2),
                    __arrL({-1, -51}, 2),
                    __arrL({2, -48}, 2),
                    __arrL({5, -50}, 2),
                    __arrL({7, -45}, 2),
                    __arrL({4, -46}, 2),
                    __arrL({1, -45}, 2),
                    __arrL({-3, -46}, 2)
                },
                10
            ),
            OP.cabelo
        )
        r(
            nil,
            -5,
            -43,
            4,
            1,
            plana(nil, PRETO)
        )
        r(
            nil,
            1,
            -43,
            4,
            1,
            PRETO
        )
        p(nil, -2, -42, PRETO)
        p(nil, 1, -42, PRETO)
        r(
            nil,
            -5,
            -41,
            3,
            2,
            plana(nil, "#f6ece6")
        )
        r(
            nil,
            2,
            -41,
            3,
            2,
            "#f6ece6"
        )
        p(nil, -3, -40, PRETO)
        p(nil, 2, -40, PRETO)
        r(
            nil,
            -2,
            -37,
            5,
            1,
            plana(nil, if __t(bravo) then "#5a1a2a" else "#6f3040")
        )
        if __t(bravo) then
            r(
                nil,
                -1,
                -36,
                3,
                1,
                plana(nil, BRANCO)
            )
        end
        r(
            nil,
            -6,
            -39,
            2,
            1,
            plana(nil, OP.bochecha)
        )
        r(
            nil,
            4,
            -39,
            2,
            1,
            OP.bochecha
        )
    end
    local function ollyan(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        local s = if __isFiniteN(__TS__Number(o.scale)) then __TS__Number(o.scale) else 1
        local face = o.facing == -1
        local voa = not not __t(o.flying)
        if __t(voa) then
            local f = __mod(
                math.floor(t * if __t(o.fast) then 15 else 10),
                N
            )
            local q = sprite(
                nil,
                __add(
                    __add("ov", f),
                    if __t(o.hit) then "b" else ""
                ),
                150,
                60,
                75,
                56,
                function() return ollyanVoando(nil, f, true) end
            )
            c:save()
            c:translate(
                math.floor(x + 0.5),
                math.floor(y + 0.5)
            )
            local ____c_26 = c
            local ____c_rotate_27 = c.rotate
            local ____t_25 = __t
            local ____TS__Number_result_24 = __TS__Number(o.angle)
            __O[1374] = ____TS__Number_result_24
            ____c_rotate_27(____c_26, if ____t_25(____TS__Number_result_24) then __O[1374] else 0)
            if __t(o.aura) then
                c:save()
                c.globalAlpha = c.globalAlpha * 0.22
                local gr = c:createRadialGradient(
                    0,
                    -44,
                    0,
                    0,
                    -44,
                    100
                )
                gr:addColorStop(0, o.aura)
                gr:addColorStop(1, "rgba(0,0,0,0)")
                c.fillStyle = gr
                c:fillRect(-100, -144, 200, 200)
                c:restore()
                do
                    local i = 0
                    while i < 6 do
                        local a = t * 0.8 + i * TAU / 6
                        c.fillStyle = o.aura
                        c:fillRect(
                            math.floor(math.cos(a) * 82 + 0.5),
                            math.floor(-44 + math.sin(a) * 68 + 0.5),
                            4,
                            4
                        )
                        i = i + 1
                    end
                end
            end
            pintar(
                nil,
                c,
                q,
                0,
                0,
                1.9 * s,
                face
            )
            if __t(if __t(o.hit) then __mod(
                math.floor(t * 18),
                2
            ) == 0 else o.hit) then
                c.globalAlpha = c.globalAlpha * 0.85
                pintar(
                    nil,
                    c,
                    q,
                    0,
                    0,
                    1.9 * s,
                    face,
                    true
                )
            end
            c:restore()
            return true
        end
        local feliz = o.cup == false
        local f = __mod(
            math.floor(t * if __t(feliz) then BPM * 4 else 5),
            N
        )
        local q = sprite(
            nil,
            __add(
                __add("of", f),
                if __t(feliz) then "f" else "b"
            ),
            60,
            82,
            30,
            80,
            function() return ollyanFesta(nil, f, feliz) end
        )
        c:save()
        c.globalAlpha = c.globalAlpha * 0.35
        c.fillStyle = "#0a0818"
        c:fillRect(
            math.floor(x - 16 * s + 0.5),
            math.floor(y - 2 + 0.5),
            math.floor(32 * s + 0.5),
            4
        )
        c:restore()
        pintar(
            nil,
            c,
            q,
            x,
            y,
            2 * s,
            face
        )
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.6
            pintar(
                nil,
                c,
                q,
                x,
                y,
                2 * s,
                face,
                true
            )
            c:restore()
        end
        if not __t(feliz) then
            local hic = __mod(t * 0.45, 1)
            if hic < 0.3 then
                c:save()
                c.globalAlpha = c.globalAlpha * (1 - hic / 0.3)
                c.font = "bold 11px monospace"
                c.textAlign = "center"
                c.fillStyle = "#101a30"
                c:fillText("hic!", x + if __t(face) then -26 else 26 + 1, y - 150 - hic * 30 + 2)
                c.fillStyle = "#ffd0e0"
                c:fillText("hic!", x + if __t(face) then -26 else 26, y - 150 - hic * 30)
                c:restore()
            end
        end
        return true
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function djSprite(self, f)
        local ph = f / N * TAU
        local b = math.abs(math.sin(ph))
        local nod = math.floor(b * 2 + 0.5)
        local mao = __mod(f, 4) < 2
        r(
            nil,
            -6,
            -22 + nod,
            13,
            14,
            "#262630"
        )
        r(
            nil,
            -6,
            -22 + nod,
            13,
            2,
            "#e2445c"
        )
        p(
            nil,
            0,
            -18 + nod,
            plana(nil, "#f2c94c")
        )
        barra(
            nil,
            -5,
            -20 + nod,
            -10,
            -10,
            3,
            "#262630"
        )
        r(
            nil,
            -12,
            -11,
            4,
            3,
            "#8d583f"
        )
        if __t(mao) then
            barra(
                nil,
                6,
                -20 + nod,
                11,
                -30,
                3,
                "#262630"
            )
            r(
                nil,
                10,
                -34,
                3,
                4,
                "#8d583f"
            )
        else
            barra(
                nil,
                6,
                -20 + nod,
                11,
                -12,
                3,
                "#262630"
            )
            r(
                nil,
                10,
                -13,
                4,
                3,
                "#8d583f"
            )
        end
        r(
            nil,
            -1,
            -25 + nod,
            3,
            3,
            "#8d583f"
        )
        e(
            nil,
            0,
            -30 + nod,
            5,
            5,
            "#8d583f"
        )
        r(
            nil,
            -5,
            -36 + nod,
            11,
            3,
            "#262630"
        )
        r(
            nil,
            0,
            -34 + nod,
            7,
            1,
            "#262630"
        )
        r(
            nil,
            -7,
            -32 + nod,
            2,
            5,
            plana(nil, "#e2445c")
        )
        r(
            nil,
            6,
            -32 + nod,
            2,
            5,
            "#e2445c"
        )
        r(
            nil,
            -6,
            -36 + nod,
            13,
            1,
            "#3a3a48"
        )
        r(
            nil,
            -3,
            -31 + nod,
            6,
            2,
            plana(nil, "#101018")
        )
        p(
            nil,
            -2,
            -31 + nod,
            plana(nil, "#8ad8ff")
        )
        r(
            nil,
            -1,
            -27 + nod,
            3,
            1,
            plana(nil, "#5a1a2a")
        )
    end
    local function mcSprite(self, f)
        local ph = f / N * TAU
        local b = math.abs(math.sin(ph))
        local y0 = -math.floor(b * 4 + 0.5)
        barra(
            nil,
            -2,
            -14 + y0,
            -4,
            -2 + y0 / 2,
            3,
            "#1f2a36"
        )
        barra(
            nil,
            2,
            -14 + y0,
            4,
            -2 + y0 / 2,
            3,
            "#1f2a36"
        )
        r(
            nil,
            -7,
            -3 + y0 / 2,
            5,
            2,
            "#f4f4f4"
        )
        r(
            nil,
            2,
            -3 + y0 / 2,
            5,
            2,
            "#f4f4f4"
        )
        r(
            nil,
            -5,
            -26 + y0,
            11,
            13,
            "#f2c94c"
        )
        r(
            nil,
            -5,
            -20 + y0,
            11,
            1,
            "#262630"
        )
        r(
            nil,
            -2,
            -25 + y0,
            5,
            1,
            plana(nil, "#f2c94c")
        )
        barra(
            nil,
            -5,
            -24 + y0,
            -9,
            -18 + y0,
            2,
            "#8d583f"
        )
        barra(
            nil,
            -9,
            -18 + y0,
            -6,
            -27 + y0,
            2,
            "#8d583f"
        )
        r(
            nil,
            -7,
            -31 + y0,
            3,
            4,
            plana(nil, "#262630")
        )
        p(
            nil,
            -6,
            -32 + y0,
            plana(nil, "#b8bcc0")
        )
        local ap = if __mod(f, 4) < 2 then -14 else -8
        barra(
            nil,
            5,
            -24 + y0,
            11,
            ap + y0,
            2,
            "#8d583f"
        )
        r(
            nil,
            10,
            ap - 1 + y0,
            3,
            3,
            "#8d583f"
        )
        r(
            nil,
            -1,
            -29 + y0,
            3,
            3,
            "#8d583f"
        )
        e(
            nil,
            0,
            -33 + y0,
            4,
            4,
            "#8d583f"
        )
        e(
            nil,
            0,
            -36 + y0,
            5,
            3,
            "#1b1414"
        )
        r(
            nil,
            -2,
            -33 + y0,
            1,
            1,
            plana(nil, PRETO)
        )
        p(nil, 1, -33 + y0, PRETO)
        r(
            nil,
            -1,
            -30 + y0,
            3,
            2,
            plana(nil, "#5a1a2a")
        )
        r(
            nil,
            -4,
            -26 + y0,
            9,
            1,
            plana(nil, "#f2c94c")
        )
    end
    local function palco(self, c, x, t)
        local beat = t * BPM
        local b = math.max(
            0,
            math.sin(beat * math.pi * 2)
        ) ^ 3
        local bar = math.floor(beat / 4)
        local f = __mod(
            math.floor(beat * 4),
            N
        )
        c:save()
        c:translate(
            math.floor(x + 0.5),
            0
        )
        c.imageSmoothingEnabled = false
        R(
            nil,
            c,
            -300,
            140,
            600,
            300,
            "#140f28"
        )
        do
            local yy = 150
            while yy < 400 do
                do
                    local xx = -290
                    while xx < 290 do
                        local k = hash(nil, xx * 3 + yy * 7)
                        if k > 0.93 then
                            R(
                                nil,
                                c,
                                xx,
                                yy,
                                2,
                                2,
                                if math.sin(t * 3 + k * 40) > 0.4 then "#c8a0ff" else "#4a3a7a"
                            )
                        end
                        xx = xx + 6
                    end
                end
                yy = yy + 6
            end
        end
        for ____, xx in __iterar((__arrL({-300, 290}, 2))) do
            R(
                nil,
                c,
                xx,
                120,
                10,
                300,
                "#5a6a80"
            )
            do
                local yy = 124
                while yy < 410 do
                    c.strokeStyle = "#a8b8c8"
                    c.lineWidth = 1
                    c:beginPath()
                    c:moveTo(xx, yy)
                    c:lineTo(xx + 10, yy + 8)
                    c:lineTo(xx, yy + 16)
                    c:stroke()
                    yy = yy + 16
                end
            end
        end
        R(
            nil,
            c,
            -300,
            118,
            600,
            12,
            "#5a6a80"
        )
        do
            local xx = -300
            while xx < 300 do
                c.strokeStyle = "#a8b8c8"
                c:beginPath()
                c:moveTo(xx, 118)
                c:lineTo(xx + 8, 130)
                c:lineTo(xx + 16, 118)
                c:stroke()
                xx = xx + 16
            end
        end
        R(
            nil,
            c,
            -130,
            96,
            260,
            22,
            "#2a1a40"
        )
        R(
            nil,
            c,
            -127,
            99,
            254,
            16,
            "#e2445c"
        )
        c.font = "bold 12px monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#fff2d8"
        c:fillText("★ BAILE DA ROÇA ★", 0, 108)
        local LX = -160
        local LY = 150
        local LW = 320
        local LH = 100
        local cel = 5
        R(
            nil,
            c,
            LX - 4,
            LY - 4,
            LW + 8,
            LH + 8,
            "#0a0810"
        )
        R(
            nil,
            c,
            LX,
            LY,
            LW,
            LH,
            "#06040c"
        )
        local modo = __mod(bar, 3)
        do
            local gy = 0
            while gy < LH / cel do
                do
                    local gx = 0
                    while gx < LW / cel do
                        local col = nil
                        local cx = gx - LW / cel / 2
                        local cy = gy - LH / cel / 2
                        if modo == 0 then
                            local h = math.floor((math.abs(math.sin(t * 5 + gx * 0.45)) * 0.7 + b * 0.5) * LH / cel + 0.5)
                            if LH / cel - gy <= h then
                                col = if gy < 5 then "#ff4f6a" else if gy < 10 then "#ffe14f" else "#4fd8ff"
                            end
                        elseif modo == 1 then
                            local d = __hypot(cx, cy * 1.6)
                            local k = __mod(d - t * 10, 8)
                            local ____t_30 = __t
                            local ____t_29 = __t
                            local ____temp_28 = k > -1 and k < 1.5
                            __O[1375] = ____temp_28
                            if ____t_30(if ____t_29(____temp_28) then __O[1375] else k > 7) then
                                col = __get(
                                    __arrL({"#ff4fd8", "#4fd8ff", "#7dff6a"}, 3),
                                    __mod(
                                        math.floor((d - t * 10) / 8 + 99),
                                        3
                                    )
                                )
                            end
                        else
                            local hx = cx / 7
                            local hy = cy / 7 + 0.3
                            local coracao = (hx * hx + hy * hy - 1) ^ 3 - hx * hx * hy * hy * hy
                            if coracao < 0 then
                                col = if b > 0.5 then "#ff5a8a" else "#e2445c"
                            elseif hash(
                                nil,
                                gx * 31 + gy * 17 + math.floor(t * 6)
                            ) > 0.985 then
                                col = "#ffffff"
                            end
                        end
                        if __t(col) then
                            R(
                                nil,
                                c,
                                LX + gx * cel,
                                LY + gy * cel,
                                cel - 1,
                                cel - 1,
                                col
                            )
                        end
                        gx = gx + 1
                    end
                end
                gy = gy + 1
            end
        end
        if modo == 1 then
            c.font = "bold 22px monospace"
            c.fillStyle = "#ffffff"
            c.globalAlpha = 0.9
            c:fillText("ROÇA NO GRAVE", 0, LY + LH / 2)
            c.globalAlpha = 1
        end
        for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
            local sx = lado * 235
            do
                local k = 0
                while k < 3 do
                    do
                        local j = 0
                        while j < 2 do
                            local bx = sx - 34 + j * 34
                            local by = 268 + k * 46
                            R(
                                nil,
                                c,
                                bx,
                                by,
                                32,
                                44,
                                "#0e0e16"
                            )
                            R(
                                nil,
                                c,
                                bx + 2,
                                by + 2,
                                28,
                                40,
                                "#22222e"
                            )
                            local pr = 11 + math.floor(b * 2 + 0.5)
                            c.fillStyle = "#4a4a5a"
                            c:beginPath()
                            c:arc(
                                bx + 16,
                                by + 22,
                                pr,
                                0,
                                TAU
                            )
                            __call(c, "fill")
                            c.fillStyle = "#16161e"
                            c:beginPath()
                            c:arc(
                                bx + 16,
                                by + 22,
                                pr - 4,
                                0,
                                TAU
                            )
                            __call(c, "fill")
                            c.fillStyle = "#6a6a7a"
                            c:beginPath()
                            c:arc(
                                bx + 16,
                                by + 22,
                                3 + math.floor(b * 2 + 0.5),
                                0,
                                TAU
                            )
                            __call(c, "fill")
                            R(
                                nil,
                                c,
                                bx + 4,
                                by + 4,
                                2,
                                2,
                                if __t(__mod(
                                    math.floor(beat * 2) + k + j,
                                    2
                                )) then "#7dff6a" else "#2a4a2a"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            -290,
            404,
            580,
            36,
            "#2a2040"
        )
        R(
            nil,
            c,
            -290,
            404,
            580,
            4,
            "#e8b88a"
        )
        do
            local i = 0
            while i < 36 do
                R(
                    nil,
                    c,
                    -284 + i * 16,
                    412,
                    6,
                    4,
                    if __mod(
                        i + math.floor(beat * 4),
                        6
                    ) < 2 then __get(
                        __arrL({"#ff4fd8", "#4fd8ff", "#ffe14f"}, 3),
                        __mod(i, 3)
                    ) else "#3a2a50"
                )
                i = i + 1
            end
        end
        local dj = sprite(
            nil,
            __add("dj", f),
            30,
            40,
            15,
            38,
            function() return djSprite(nil, f) end
        )
        pintar(
            nil,
            c,
            dj,
            0,
            352,
            2,
            false
        )
        R(
            nil,
            c,
            -70,
            336,
            140,
            52,
            "#1a1428"
        )
        R(
            nil,
            c,
            -66,
            340,
            132,
            6,
            "#3a3050"
        )
        R(
            nil,
            c,
            -66,
            350,
            132,
            34,
            "#2a2040"
        )
        c.font = "bold 10px monospace"
        c.fillStyle = "#ff7ad9"
        c:fillText("DJ CHAPÉU", 0, 368)
        for ____, dx in __iterar((__arrL({-44, 44}, 2))) do
            c.fillStyle = "#0a0a10"
            c:beginPath()
            c:ellipse(
                dx,
                340,
                16,
                5,
                0,
                0,
                TAU
            )
            __call(c, "fill")
            local a = t * 6
            R(
                nil,
                c,
                dx + math.cos(a) * 10 - 1,
                340 + math.sin(a) * 3 - 1,
                3,
                2,
                "#e8e8f0"
            )
        end
        do
            local i = 0
            while i < 6 do
                R(
                    nil,
                    c,
                    -12 + i * 4,
                    338,
                    2,
                    2,
                    if __t(__mod(i + f, 3)) then "#7dff6a" else "#ff4f6a"
                )
                i = i + 1
            end
        end
        local mc = sprite(
            nil,
            __add("mc", f),
            30,
            44,
            15,
            42,
            function() return mcSprite(nil, f) end
        )
        pintar(
            nil,
            c,
            mc,
            -140,
            404,
            2,
            false
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({150, 7}, 2),
                __arrL({210, 12}, 2)
            },
            2
        ))) do
            local dx = ____value[1]
            local sd = ____value[2]
            R(
                nil,
                c,
                dx - 20,
                388,
                40,
                16,
                "#3a2a50"
            )
            R(
                nil,
                c,
                dx - 20,
                388,
                40,
                3,
                "#ff7ad9"
            )
            dancer(
                nil,
                c,
                dx,
                388,
                t + 0.25,
                sd,
                1.15
            )
        end
        local k8 = __mod(beat, 8) / 8
        if k8 < 0.3 then
            local u = k8 / 0.3
            for ____, fx in __iterar((__arrL({-260, -100, 100, 260}, 4))) do
                do
                    local i = 0
                    while i < 18 do
                        local h = hash(nil, i * 7 + fx)
                        local vy = 170 + h * 90
                        local px = fx + (h - 0.5) * 30 * u
                        local py = 404 - vy * u + 160 * u * u
                        c.globalAlpha = 1 - u
                        R(
                            nil,
                            c,
                            px,
                            py,
                            2,
                            3,
                            if h > 0.5 then "#ffe9a0" else "#ffffff"
                        )
                        i = i + 1
                    end
                end
            end
            c.globalAlpha = 1
        end
        local k16 = __mod(beat, 16) / 16
        if __t(k16 > 0.5 and k16 < 0.66) then
            local u = (k16 - 0.5) / 0.16
            for ____, fx in __iterar((__arrL({-200, 200}, 2))) do
                c.globalAlpha = (1 - u) * 0.7
                do
                    local i = 0
                    while i < 6 do
                        c.fillStyle = "#f0f0ff"
                        c:beginPath()
                        c:ellipse(
                            fx + math.sin(i * 2) * 8,
                            404 - i * 30 * (0.4 + u),
                            12 + i * 4,
                            10 + i * 2,
                            0,
                            0,
                            TAU
                        )
                        __call(c, "fill")
                        i = i + 1
                    end
                end
            end
            c.globalAlpha = 1
        end
        do
            local i = 0
            while i < 6 do
                local lx = -250 + i * 100
                local ang = math.pi / 2 + math.sin(t * (0.7 + i * 0.1) + i) * 0.7
                local col = __get(
                    __arrL({"#ff4fd8", "#4fd8ff", "#ffe14f", "#7dff6a"}, 4),
                    __mod(i + bar, 4)
                )
                c:save()
                c.globalCompositeOperation = "lighter"
                c.globalAlpha = 0.1 + b * 0.08
                c.fillStyle = col
                c:beginPath()
                c:moveTo(lx, 132)
                c:lineTo(
                    lx + math.cos(ang - 0.1) * 420,
                    132 + math.sin(ang - 0.1) * 420
                )
                c:lineTo(
                    lx + math.cos(ang + 0.1) * 420,
                    132 + math.sin(ang + 0.1) * 420
                )
                c:closePath()
                __call(c, "fill")
                c:restore()
                R(
                    nil,
                    c,
                    lx - 6,
                    128,
                    12,
                    8,
                    "#2a2a38"
                )
                R(
                    nil,
                    c,
                    lx - 3,
                    134,
                    6,
                    3,
                    col
                )
                i = i + 1
            end
        end
        c:restore()
        return true
    end
    local function fx(self, c, x, t)
        local beat = t * BPM
        local b = math.max(
            0,
            math.sin(beat * math.pi * 2)
        ) ^ 3
        local bar = math.floor(beat / 4)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            0
        )
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 8 do
                local a = -math.pi / 2 + math.sin(t * (0.6 + i * 0.07) + i * 1.3) * 0.9
                local col = __get(
                    __arrL({"#ff4fd8", "#4fd8ff", "#7dff6a", "#ffe14f"}, 4),
                    __mod(i + bar, 4)
                )
                c.globalAlpha = 0.13 + 0.12 * b
                c.strokeStyle = col
                c.lineWidth = 2
                c:beginPath()
                c:moveTo((i - 3.5) * 60, 128)
                c:lineTo(
                    (i - 3.5) * 60 + math.cos(a) * 900,
                    128 + math.sin(a) * 900
                )
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
        do
            local i = 0
            while i < 10 do
                local fxx = -300 + i * 66 + math.sin(t * 0.4 + i) * 20
                local fy = 410 + math.sin(t * 0.6 + i * 2) * 6
                c:save()
                c.globalAlpha = 0.14
                c.fillStyle = "#cdb8ee"
                c:beginPath()
                c:ellipse(
                    fxx,
                    fy,
                    62,
                    16,
                    0,
                    0,
                    TAU
                )
                __call(c, "fill")
                c:restore()
                i = i + 1
            end
        end
        local cb = __mod(beat, 16) / 16
        if cb < 0.35 then
            local k = cb / 0.35
            do
                local i = 0
                while i < 60 do
                    local side = if __t(__mod(i, 2)) then 1 else -1
                    local a = -math.pi / 2 + side * (0.15 + __mod(i * 37, 50) / 100)
                    local v = 280 * (1 - k * 0.3)
                    c:save()
                    c.globalAlpha = 1 - k
                    c.fillStyle = __get(
                        __arrL({
                            "#ff4fd8",
                            "#4fd8ff",
                            "#7dff6a",
                            "#ffe14f",
                            "#ffffff"
                        }, 5),
                        __mod(i, 5)
                    )
                    c:fillRect(
                        math.floor(side * 250 + math.cos(a) * v * k + math.sin(t * 9 + i) * 4 + 0.5),
                        math.floor(130 + math.sin(a) * v * k + k * k * 260 + 0.5),
                        if __t(__mod(i, 3)) then 4 else 2,
                        if __t(__mod(i, 3)) then 2 else 4
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        c:restore()
        if __mod(beat, 8) < 0.06 then
            c:save()
            c.globalAlpha = 0.12
            c.fillStyle = "#ffffff"
            c:fillRect(0, 0, 960, 540)
            c:restore()
        end
        return true
    end
    local function cenario(self, c, camera, t)
        local beat = t * BPM
        local b = math.max(
            0,
            math.sin(beat * math.pi * 2)
        ) ^ 3
        local function vis(____, wx, w)
            return wx - camera > __TS__Number(-w) and __lt(wx - camera, 960 + w)
        end
        c:save()
        c.imageSmoothingEnabled = false
        do
            local i = 0
            while i < 9 do
                local x0 = i * 560 - camera * 0.9 + 80
                if __t(x0 < -560 or x0 > 960) then
                    continue
                end
                do
                    local k = 0
                    while k < 28 do
                        local px = x0 + k * 20
                        local py = 236 + math.sin(k / 27 * math.pi) * 26 + math.sin(t * 2 + k) * 1.5
                        c.fillStyle = __get(
                            __arrL({
                                "#e2445c",
                                "#f2c94c",
                                "#2d9cdb",
                                "#27ae60",
                                "#ff7ad9"
                            }, 5),
                            __mod(k + i, 5)
                        )
                        c:beginPath()
                        c:moveTo(px, py)
                        c:lineTo(px + 10, py)
                        c:lineTo(px + 5, py + 10)
                        c:closePath()
                        __call(c, "fill")
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        for ____, wx in __iterar((__arrL({820, 3880}, 2))) do
            if not __t(vis(nil, wx, 220)) then
                continue
            end
            local x = wx - camera
            local y = 368
            R(
                nil,
                c,
                x - 110,
                y - 46,
                220,
                42,
                "#1a1a2a"
            )
            R(
                nil,
                c,
                x - 106,
                y - 42,
                212,
                34,
                "#c8303a"
            )
            R(
                nil,
                c,
                x - 60,
                y - 70,
                110,
                26,
                "#c8303a"
            )
            R(
                nil,
                c,
                x - 54,
                y - 66,
                46,
                18,
                "#8ac0e0"
            )
            R(
                nil,
                c,
                x - 2,
                y - 66,
                44,
                18,
                "#8ac0e0"
            )
            R(
                nil,
                c,
                x - 106,
                y - 26,
                212,
                3,
                "#ffffff55"
            )
            for ____, wxx in __iterar((__arrL({-70, 70}, 2))) do
                c.fillStyle = "#101018"
                c:beginPath()
                c:arc(
                    x + wxx,
                    y - 4,
                    15,
                    0,
                    TAU
                )
                __call(c, "fill")
                c.fillStyle = "#b8bcc0"
                c:beginPath()
                c:arc(
                    x + wxx,
                    y - 4,
                    6,
                    0,
                    TAU
                )
                __call(c, "fill")
            end
            R(
                nil,
                c,
                x + 106,
                y - 108,
                70,
                66,
                "#14141e"
            )
            R(
                nil,
                c,
                x + 104,
                y - 112,
                74,
                6,
                "#c8303a"
            )
            do
                local k = 0
                while k < 2 do
                    do
                        local j = 0
                        while j < 2 do
                            local cx = x + 124 + j * 34
                            local cy = y - 92 + k * 30
                            local pr = 12 + math.floor(b * 3 + 0.5)
                            c.fillStyle = "#3a3a4a"
                            c:beginPath()
                            c:arc(
                                cx,
                                cy,
                                pr,
                                0,
                                TAU
                            )
                            __call(c, "fill")
                            c.fillStyle = "#0e0e16"
                            c:beginPath()
                            c:arc(
                                cx,
                                cy,
                                pr - 5,
                                0,
                                TAU
                            )
                            __call(c, "fill")
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
            c:save()
            c.globalAlpha = 0.15 + b * 0.25
            c.strokeStyle = "#ff7ad9"
            c.lineWidth = 2
            do
                local k = 1
                while k <= 3 do
                    c:beginPath()
                    c:arc(
                        x + 140,
                        y - 78,
                        30 + k * 18 + b * 10,
                        -1.2,
                        1.2
                    )
                    c:stroke()
                    k = k + 1
                end
            end
            c:restore()
            R(
                nil,
                c,
                x - 106,
                y - 10,
                212,
                4,
                if __t(__mod(
                    math.floor(beat * 4),
                    2
                )) then "#4fd8ff" else "#ff4fd8"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({1500, "ESPETINHO", "#e8a23a"}, 3),
                __arrL({2860, "GELADINHO", "#3ad8c8"}, 3),
                __arrL({4400, "AÇAÍ", "#9b51e0"}, 3)
            },
            3
        ))) do
            local wx = ____value[1]
            local nome = ____value[2]
            local cor = ____value[3]
            if not __t(vis(nil, wx, 160)) then
                continue
            end
            local x = wx - camera
            local y = 372
            R(
                nil,
                c,
                x - 70,
                y - 96,
                140,
                14,
                cor
            )
            do
                local k = 0
                while k < 7 do
                    R(
                        nil,
                        c,
                        x - 70 + k * 20,
                        y - 82,
                        10,
                        8,
                        cor
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 7 do
                    R(
                        nil,
                        c,
                        x - 60 + k * 20,
                        y - 82,
                        10,
                        8,
                        "#f4f4f4"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x - 66,
                y - 82,
                4,
                82,
                "#5a4a3a"
            )
            R(
                nil,
                c,
                x + 62,
                y - 82,
                4,
                82,
                "#5a4a3a"
            )
            R(
                nil,
                c,
                x - 70,
                y - 40,
                140,
                40,
                "#6a4a30"
            )
            R(
                nil,
                c,
                x - 70,
                y - 40,
                140,
                4,
                "#8a6a40"
            )
            c.font = "bold 10px monospace"
            c.textAlign = "center"
            c.fillStyle = "#fff2d8"
            c:fillText(nome, x, y - 22)
            do
                local k = 0
                while k < 8 do
                    local lx = x - 64 + k * 18
                    R(
                        nil,
                        c,
                        lx,
                        y - 74,
                        4,
                        4,
                        if math.sin(t * 4 + k) > 0 then "#ffe9a0" else "#a8884a"
                    )
                    k = k + 1
                end
            end
            if nome == "ESPETINHO" then
                R(
                    nil,
                    c,
                    x - 40,
                    y - 50,
                    50,
                    8,
                    "#2a2a2a"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            x - 36 + k * 8,
                            y - 54,
                            2,
                            6,
                            "#c86a3a"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 do
                        local u = __mod(t * 0.5 + k / 5, 1)
                        c.globalAlpha = (1 - u) * 0.35
                        c.fillStyle = "#d8d8e0"
                        c:beginPath()
                        c:arc(
                            x - 16 + math.sin(u * 6 + k) * 8,
                            y - 58 - u * 60,
                            6 + u * 10,
                            0,
                            TAU
                        )
                        __call(c, "fill")
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
            else
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x - 40 + k * 18,
                            y - 52,
                            8,
                            12,
                            __get(
                                __arrL({
                                    "#e2445c",
                                    "#f2c94c",
                                    "#3ad8c8",
                                    "#7dff6a",
                                    "#ff7ad9"
                                }, 5),
                                k
                            )
                        )
                        k = k + 1
                    end
                end
            end
        end
        c:restore()
        return true
    end
    local function ADD(____, c, fn)
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local ____try, ____error = pcall(function()
                fn(nil)
            end)
            do
                c:restore()
            end
            if not ____try then
                error(____error, 0)
            end
        end
    end
    local function brilho(self, c, x, y, rr, col, a)
        c:save()
        c.globalAlpha = c.globalAlpha * a
        local gr = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            rr
        )
        gr:addColorStop(0, col)
        gr:addColorStop(1, "rgba(0,0,0,0)")
        c.fillStyle = gr
        c:fillRect(x - rr, y - rr, rr * 2, rr * 2)
        c:restore()
    end
    local function nuvemPx(self, c, x, y, k, col, borda)
        local function b(____, dx, dy, w, h)
            R(
                nil,
                c,
                x + dx * k - 2,
                y + dy * k - 2,
                w * k + 4,
                h * k + 4,
                borda
            )
        end
        local function f(____, dx, dy, w, h, cc)
            return R(
                nil,
                c,
                x + dx * k,
                y + dy * k,
                w * k,
                h * k,
                cc
            )
        end
        b(
            nil,
            -14,
            -2,
            30,
            8
        )
        b(
            nil,
            -9,
            -7,
            12,
            6
        )
        b(
            nil,
            0,
            -9,
            12,
            8
        )
        f(
            nil,
            -14,
            -2,
            30,
            8,
            col
        )
        f(
            nil,
            -9,
            -7,
            12,
            6,
            col
        )
        f(
            nil,
            0,
            -9,
            12,
            8,
            col
        )
        f(
            nil,
            -9,
            -7,
            12,
            2,
            "#ffffff55"
        )
        f(
            nil,
            0,
            -9,
            12,
            2,
            "#ffffff66"
        )
        f(
            nil,
            -14,
            4,
            30,
            2,
            "#00000022"
        )
    end
    local function raio(self, c, x0, y0, x1, y1, seed, col)
        local pts = __arrL(
            {__arrL({x0, y0}, 2)},
            1
        )
        local n = 9
        do
            local i = 1
            while i < n do
                local u = i / n
                __call(
                    pts,
                    "push",
                    __arrL(
                        {
                            x0 + (x1 - x0) * u + (hash(nil, seed + i) - 0.5) * 34,
                            y0 + (y1 - y0) * u
                        },
                        2
                    )
                )
                i = i + 1
            end
        end
        __call(
            pts,
            "push",
            __arrL({x1, y1}, 2)
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({10, col, 0.25}, 3),
                __arrL({5, col, 0.7}, 3),
                __arrL({2, "#ffffff", 1}, 3)
            },
            3
        ))) do
            local w = ____value[1]
            local cc = ____value[2]
            local a = ____value[3]
            c:save()
            c.globalAlpha = c.globalAlpha * a
            c.strokeStyle = cc
            c.lineWidth = w
            c.lineJoin = "miter"
            c:beginPath()
            __call(
                pts,
                "forEach",
                function(____, ____bindingPattern0, i)
                    local py
                    local px
                    px = ____bindingPattern0[1]
                    py = ____bindingPattern0[2]
                    return if __t(i) then c:lineTo(px, py) else c:moveTo(px, py)
                end
            )
            c:stroke()
            c:restore()
        end
    end
    local function mira(self, c, x, y, t, col, rr)
        if rr == nil then
            rr = 22
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:rotate(t * 2.4)
        c.strokeStyle = col
        c.lineWidth = 2
        local k = rr + math.sin(t * 9) * 3
        do
            local i = 0
            while i < 4 do
                c:rotate(math.pi / 2)
                c:beginPath()
                c:moveTo(k, -6)
                c:lineTo(k, -k * 0.25 - 2)
                c:moveTo(k, 6)
                c:lineTo(k, k * 0.25 + 2)
                c:stroke()
                R(
                    nil,
                    c,
                    k - 1,
                    -1,
                    3,
                    3,
                    col
                )
                i = i + 1
            end
        end
        c:restore()
        R(
            nil,
            c,
            x - 2,
            y - 2,
            4,
            4,
            "#ffffff"
        )
    end
    local ORELHA = __arrL(
        {
            __arrL({-10, -4}, 2),
            __arrL({-4, -12}, 2),
            __arrL({8, -12}, 2),
            __arrL({12, -3}, 2),
            __arrL({6, 10}, 2),
            __arrL({-5, 8}, 2)
        },
        6
    )
    local function projetil(self, c, a, t)
        if a.owner == "player" then
            return false
        end
        local ____t_32 = __t
        local ____hypot_result_31 = __hypot(a.vx, a.vy)
        __O[1376] = ____hypot_result_31
        local sp = if ____t_32(____hypot_result_31) then __O[1376] else 1
        local ux = a.vx / sp
        local uy = a.vy / sp
        c:save()
        if __gt(a.delay, 0) then
            c.globalAlpha = c.globalAlpha * 0.3
        end
        if a.type == "ear" then
            do
                local i = 4
                while i >= 1 do
                    c:save()
                    c.globalAlpha = c.globalAlpha * (0.14 * (5 - i))
                    c:translate(a.x - ux * i * 9, a.y - uy * i * 9)
                    c:rotate((t - i * 0.03) * 4 * if __t(a.spin) then a.spin else 1)
                    c.fillStyle = "#ff9ac8"
                    c:beginPath()
                    __call(
                        ORELHA,
                        "forEach",
                        function(____, ____bindingPattern0, j)
                            local py
                            local px
                            px = ____bindingPattern0[1]
                            py = ____bindingPattern0[2]
                            return if __t(j) then c:lineTo(px, py) else c:moveTo(px, py)
                        end
                    )
                    c:closePath()
                    __call(c, "fill")
                    c:restore()
                    i = i - 1
                end
            end
            ADD(
                nil,
                c,
                function() return brilho(
                    nil,
                    c,
                    a.x,
                    a.y,
                    22,
                    "#ff7ad9",
                    0.35
                ) end
            )
            c:translate(
                math.floor(a.x + 0.5),
                math.floor(a.y + 0.5)
            )
            c:rotate(t * 4 * if __t(a.spin) then a.spin else 1)
            c.fillStyle = "#2a1420"
            c:beginPath()
            __call(
                ORELHA,
                "forEach",
                function(____, ____bindingPattern0, j)
                    local py
                    local px
                    px = ____bindingPattern0[1]
                    py = ____bindingPattern0[2]
                    return if __t(j) then c:lineTo(px * 1.18, py * 1.18) else c:moveTo(px * 1.18, py * 1.18)
                end
            )
            c:closePath()
            __call(c, "fill")
            c.fillStyle = "#ecc4a8"
            c:beginPath()
            __call(
                ORELHA,
                "forEach",
                function(____, ____bindingPattern0, j)
                    local py
                    local px
                    px = ____bindingPattern0[1]
                    py = ____bindingPattern0[2]
                    return if __t(j) then c:lineTo(px, py) else c:moveTo(px, py)
                end
            )
            c:closePath()
            __call(c, "fill")
            c.fillStyle = "#f0a0a8"
            c:beginPath()
            __call(
                ORELHA,
                "forEach",
                function(____, ____bindingPattern0, j)
                    local py
                    local px
                    px = ____bindingPattern0[1]
                    py = ____bindingPattern0[2]
                    return if __t(j) then c:lineTo(px * 0.55, py * 0.55) else c:moveTo(px * 0.55, py * 0.55)
                end
            )
            c:closePath()
            __call(c, "fill")
            R(
                nil,
                c,
                -2,
                -9,
                5,
                2,
                "#fff0e0"
            )
        elseif a.type == "pulse" then
            local k = __mod(t * 3 + if __t(a.spin) then a.spin else 0, 1)
            ADD(
                nil,
                c,
                function()
                    brilho(
                        nil,
                        c,
                        a.x,
                        a.y,
                        26,
                        "#4fd8ff",
                        0.4
                    )
                    c.strokeStyle = "#7adfff"
                    c.lineWidth = 2
                    c.globalAlpha = 1 - k
                    c:beginPath()
                    c:arc(
                        a.x,
                        a.y,
                        8 + k * 14,
                        0,
                        TAU
                    )
                    c:stroke()
                end
            )
            do
                local i = 1
                while i <= 3 do
                    c:save()
                    c.globalAlpha = c.globalAlpha * 0.2
                    R(
                        nil,
                        c,
                        a.x - ux * i * 10 - 3,
                        a.y - uy * i * 10 - 3,
                        6,
                        6,
                        "#7adfff"
                    )
                    c:restore()
                    i = i + 1
                end
            end
            c.fillStyle = "#16122a"
            c:beginPath()
            c:arc(
                a.x,
                a.y,
                9,
                0,
                TAU
            )
            __call(c, "fill")
            c.fillStyle = "#7adfff"
            c:beginPath()
            c:arc(
                a.x,
                a.y,
                7,
                0,
                TAU
            )
            __call(c, "fill")
            c.fillStyle = "#e8fcff"
            c:beginPath()
            c:arc(
                a.x - 2,
                a.y - 2,
                3,
                0,
                TAU
            )
            __call(c, "fill")
            R(
                nil,
                c,
                a.x + 1,
                a.y - 5,
                2,
                8,
                "#16122a"
            )
            R(
                nil,
                c,
                a.x - 2,
                a.y + 1,
                4,
                3,
                "#16122a"
            )
            R(
                nil,
                c,
                a.x + 3,
                a.y - 5,
                3,
                2,
                "#16122a"
            )
        elseif a.type == "comet" then
            ADD(
                nil,
                c,
                function()
                    local tl = 70
                    local gr = c:createLinearGradient(a.x, a.y, a.x - ux * tl, a.y - uy * tl)
                    gr:addColorStop(0, "rgba(200,170,255,.9)")
                    gr:addColorStop(1, "rgba(120,80,220,0)")
                    c.fillStyle = gr
                    c:beginPath()
                    c:moveTo(a.x + uy * 11, a.y - ux * 11)
                    c:lineTo(a.x - ux * tl, a.y - uy * tl)
                    c:lineTo(a.x - uy * 11, a.y + ux * 11)
                    c:closePath()
                    __call(c, "fill")
                    brilho(
                        nil,
                        c,
                        a.x,
                        a.y,
                        30,
                        "#c8a8ff",
                        0.55
                    )
                end
            )
            do
                local i = 0
                while i < 5 do
                    local h = hash(
                        nil,
                        i * 13 + math.floor(t * 12)
                    )
                    local d = 14 + h * 50
                    R(
                        nil,
                        c,
                        a.x - ux * d + (h - 0.5) * 14,
                        a.y - uy * d + (hash(nil, i + 7) - 0.5) * 14,
                        2,
                        2,
                        if h > 0.5 then "#ffffff" else "#ffd8f0"
                    )
                    i = i + 1
                end
            end
            c.fillStyle = "#2a1a4a"
            c:beginPath()
            c:arc(
                a.x,
                a.y,
                12,
                0,
                TAU
            )
            __call(c, "fill")
            c.fillStyle = "#8a6ad8"
            c:beginPath()
            c:arc(
                a.x,
                a.y,
                10,
                0,
                TAU
            )
            __call(c, "fill")
            c.fillStyle = "#d8c8ff"
            c:beginPath()
            c:arc(
                a.x + ux * 3,
                a.y + uy * 3,
                6,
                0,
                TAU
            )
            __call(c, "fill")
            R(
                nil,
                c,
                a.x + ux * 4 - 2,
                a.y + uy * 4 - 2,
                4,
                4,
                "#ffffff"
            )
        else
            c:restore()
            return false
        end
        c:restore()
        return true
    end
    local function perigo(self, c, h, t)
        c:save()
        if h.type == "gate" then
            local x = if __gt(h.delay, 0) then 930 else h.x
            local alerta = __gt(h.delay, 0)
            c.globalAlpha = c.globalAlpha * if __t(alerta) then 0.5 else 1
            do
                local yy = 90
                while yy < 494 do
                    if math.abs(yy - h.gapY) < h.gapSize * 0.5 then
                        continue
                    end
                    nuvemPx(
                        nil,
                        c,
                        x - 10 + math.sin(yy + t * 2) * 3,
                        yy + 4,
                        2,
                        if __t(alerta) then "#b8c8e0" else "#8a98c0",
                        "#2a2a48"
                    )
                    yy = yy + 29
                end
            end
            if __t(not __t(alerta) and hash(
                nil,
                math.floor(t * 7) + h.gapY
            ) > 0.82) then
                local yy = 90 + hash(
                    nil,
                    math.floor(t * 7) * 3
                ) * 380
                if math.abs(yy - h.gapY) > h.gapSize * 0.5 + 20 then
                    ADD(
                        nil,
                        c,
                        function() return raio(
                            nil,
                            c,
                            x - 30,
                            yy - 20,
                            x + 20,
                            yy + 30,
                            math.floor(t * 7),
                            "#c8d8ff"
                        ) end
                    )
                end
            end
            do
                local i = 0
                while i < 6 do
                    local wy = 90 + hash(nil, i * 3 + h.gapY) * 400
                    local wx = x + 40 + __mod(t * 300 + i * 70, 160)
                    if math.abs(wy - h.gapY) < h.gapSize * 0.5 then
                        continue
                    end
                    c:save()
                    c.globalAlpha = c.globalAlpha * 0.4
                    R(
                        nil,
                        c,
                        wx,
                        wy,
                        26,
                        2,
                        "#e8f0ff"
                    )
                    c:restore()
                    i = i + 1
                end
            end
            if __t(alerta) then
                local g0 = h.gapY - h.gapSize * 0.5
                local g1 = h.gapY + h.gapSize * 0.5
                local pis = math.sin(t * 12) > 0
                c.strokeStyle = if __t(pis) then "#9affb0" else "#58c878"
                c.lineWidth = 3
                c:beginPath()
                c:moveTo(884, g0)
                c:lineTo(906, g0)
                c:lineTo(906, g1)
                c:lineTo(884, g1)
                c:stroke()
                do
                    local k = 0
                    while k < 3 do
                        local ax = 840 + __mod(t * 60 + k * 18, 54)
                        R(
                            nil,
                            c,
                            ax,
                            h.gapY - 1,
                            10,
                            3,
                            "#9affb0"
                        )
                        R(
                            nil,
                            c,
                            ax + 6,
                            h.gapY - 4,
                            3,
                            9,
                            "#9affb0"
                        )
                        k = k + 1
                    end
                end
                c.font = "bold 11px monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#101a30"
                c:fillText("VÃO", 872, h.gapY - 14)
                c.fillStyle = "#c7efcc"
                c:fillText("VÃO", 871, h.gapY - 15)
            end
        elseif h.type == "cloudStorm" then
            local carga = __gt(h.delay, 0)
            nuvemPx(
                nil,
                c,
                h.x,
                104,
                2.2,
                if __t(carga) then "#4a4a6a" else "#2a2a40",
                "#141428"
            )
            if __t(carga) then
                local pisca = math.sin(t * (10 + (1.1 - h.delay) * 20)) > 0
                c.globalAlpha = c.globalAlpha * if __t(pisca) then 0.55 else 0.25
                R(
                    nil,
                    c,
                    h.x - 38,
                    h.y + 4,
                    76,
                    6,
                    "#ffb040"
                )
                R(
                    nil,
                    c,
                    h.x - 38,
                    h.y + 2,
                    76,
                    2,
                    "#ffe9a0"
                )
                c.globalAlpha = 1
                do
                    local k = 0
                    while k < 4 do
                        local u = __mod(t * 2 + k / 4, 1)
                        c:save()
                        c.globalAlpha = c.globalAlpha * (0.6 * (1 - u))
                        R(
                            nil,
                            c,
                            h.x - 30 + k * 18,
                            116 + u * (h.y - 120),
                            2,
                            6,
                            "#a8c8ff"
                        )
                        c:restore()
                        k = k + 1
                    end
                end
                if math.sin(t * 17) > 0.9 then
                    ADD(
                        nil,
                        c,
                        function() return brilho(
                            nil,
                            c,
                            h.x,
                            104,
                            50,
                            "#c8d8ff",
                            0.5
                        ) end
                    )
                end
            else
                ADD(
                    nil,
                    c,
                    function()
                        raio(
                            nil,
                            c,
                            h.x,
                            116,
                            h.x + (hash(nil, h.x) - 0.5) * 20,
                            h.y,
                            math.floor(t * 30) + h.x,
                            "#d8e8ff"
                        )
                        brilho(
                            nil,
                            c,
                            h.x,
                            h.y,
                            60,
                            "#e8f0ff",
                            0.7
                        )
                    end
                )
                do
                    local i = 0
                    while i < 10 do
                        local a = i / 10 * math.pi
                        local d = 10 + hash(
                            nil,
                            i + math.floor(t * 30)
                        ) * 30
                        R(
                            nil,
                            c,
                            h.x + math.cos(a) * d * if __t(__mod(i, 2)) then 1 else -1,
                            h.y - math.sin(a) * d * 0.6,
                            3,
                            3,
                            "#ffffff"
                        )
                        i = i + 1
                    end
                end
            end
        elseif h.type == "beam" then
            local dx = h.tx - h.x
            local dy = h.ty - h.y
            local ____t_34 = __t
            local ____hypot_result_33 = __hypot(dx, dy)
            __O[1377] = ____hypot_result_33
            local len = if ____t_34(____hypot_result_33) then __O[1377] else 1
            local ex = h.x + dx / len * 1200
            local ey = h.y + dy / len * 1200
            if __gt(h.delay, 0) then
                c:save()
                c:setLineDash(__arrL({12, 9}, 2))
                c.lineDashOffset = __TS__Number(-t) * 60
                c.strokeStyle = if math.sin(t * 20) > 0 then "#ffd0b0" else "#f59a7a"
                c.lineWidth = 2
                c:beginPath()
                c:moveTo(h.x, h.y)
                c:lineTo(ex, ey)
                c:stroke()
                c:restore()
                mira(
                    nil,
                    c,
                    h.tx,
                    h.ty,
                    t,
                    "#ffc8a8",
                    18 + h.delay * 30
                )
                ADD(
                    nil,
                    c,
                    function() return brilho(
                        nil,
                        c,
                        h.x,
                        h.y,
                        20 + (1 - h.delay / 0.3) * 26,
                        "#e8d8ff",
                        0.8
                    ) end
                )
            else
                ADD(
                    nil,
                    c,
                    function()
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({64, "#6a3aa8", 0.35}, 3),
                                __arrL({40, "#b890e8", 0.55}, 3),
                                __arrL({20, "#e8d8ff", 0.9}, 3),
                                __arrL({8, "#ffffff", 1}, 3)
                            },
                            4
                        ))) do
                            local w = ____value[1]
                            local col = ____value[2]
                            local al = ____value[3]
                            c:save()
                            c.globalAlpha = c.globalAlpha * al
                            c.strokeStyle = col
                            c.lineWidth = w + math.sin(t * 40) * 3
                            c.lineCap = "round"
                            c:beginPath()
                            c:moveTo(h.x, h.y)
                            c:lineTo(ex, ey)
                            c:stroke()
                            c:restore()
                        end
                        brilho(
                            nil,
                            c,
                            h.x,
                            h.y,
                            70,
                            "#f0e0ff",
                            0.9
                        )
                    end
                )
                do
                    local i = 0
                    while i < 16 do
                        local u = __mod(t * 2.5 + i / 16, 1)
                        local d = u * 900
                        local off = (hash(nil, i) - 0.5) * 40
                        R(
                            nil,
                            c,
                            h.x + dx / len * d - dy / len * off,
                            h.y + dy / len * d + dx / len * off,
                            3,
                            3,
                            if __t(__mod(i, 2)) then "#ffffff" else "#e8d0ff"
                        )
                        i = i + 1
                    end
                end
            end
        elseif __t(h.type == "ringBurst" and __gt(h.delay, 0)) then
            local k = 1 - h.delay / 0.7
            do
                local i = 0
                while i < 18 do
                    local a = i / 18 * TAU + t * 3
                    local d = 120 * (1 - k) + 20
                    c:save()
                    c.globalAlpha = c.globalAlpha * 0.7
                    R(
                        nil,
                        c,
                        h.x + math.cos(a) * d - 3,
                        h.y + math.sin(a) * d - 1,
                        6,
                        2,
                        "#bfe8ff"
                    )
                    c:restore()
                    i = i + 1
                end
            end
            ADD(
                nil,
                c,
                function() return brilho(
                    nil,
                    c,
                    h.x,
                    h.y,
                    30 + k * 40,
                    "#9ad8ff",
                    0.5
                ) end
            )
        else
            c:restore()
            return false
        end
        c:restore()
        return true
    end
    local function telegrafa(self, c, st)
        local b = st.boss
        local t = st.time
        local at = b.attack
        if at == "earFan" then
            ADD(
                nil,
                c,
                function()
                    for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                        brilho(
                            nil,
                            c,
                            b.x + lado * 80,
                            b.y - 20,
                            40 + math.sin(t * 20) * 8,
                            "#ff7ad9",
                            0.6
                        )
                    end
                end
            )
            do
                local i = 0
                while i < 10 do
                    local a = i / 10 * TAU + t * 5
                    local d = 60 - __mod(t * 80 + i * 9, 50)
                    R(
                        nil,
                        c,
                        b.x + math.cos(a) * d * 1.8,
                        b.y - 20 + math.sin(a) * d * 0.6,
                        3,
                        3,
                        "#ffb8e0"
                    )
                    i = i + 1
                end
            end
        elseif __t(at == "pulseRing" or at == "gustRing") then
            ADD(
                nil,
                c,
                function()
                    do
                        local k = 0
                        while k < 3 do
                            local u = __mod(t * 1.6 + k / 3, 1)
                            local rr = 140 * (1 - u) + 20
                            c.globalAlpha = u * 0.7
                            c.strokeStyle = if at == "gustRing" then "#bfe8ff" else "#7adfff"
                            c.lineWidth = 3
                            c:beginPath()
                            c:arc(
                                b.x,
                                b.y,
                                rr,
                                0,
                                TAU
                            )
                            c:stroke()
                            k = k + 1
                        end
                    end
                end
            )
        elseif at == "swoop" then
            c:save()
            c:setLineDash(__arrL({10, 8}, 2))
            c.lineDashOffset = __TS__Number(-t) * 80
            c.strokeStyle = "#f2d0a0"
            c.lineWidth = 3
            c:beginPath()
            c:moveTo(b.x, b.y)
            c:quadraticCurveTo(
                __add(b.x, b.targetX) / 2,
                math.max(b.y, b.targetY) + 60,
                b.targetX,
                b.targetY
            )
            c:stroke()
            c:restore()
            mira(
                nil,
                c,
                b.targetX,
                b.targetY,
                t,
                "#ffd8a0",
                22
            )
        elseif at == "moonBeam" then
            ADD(
                nil,
                c,
                function() return brilho(
                    nil,
                    c,
                    b.x,
                    b.y,
                    30 + math.sin(t * 15) * 10,
                    "#e8d8ff",
                    0.9
                ) end
            )
            mira(
                nil,
                c,
                b.targetX,
                b.targetY,
                t,
                "#ffc8a8",
                26
            )
            local dx = b.targetX - b.x
            local dy = b.targetY - b.y
            local ____t_36 = __t
            local ____hypot_result_35 = __hypot(dx, dy)
            __O[1378] = ____hypot_result_35
            local len = if ____t_36(____hypot_result_35) then __O[1378] else 1
            c:save()
            c:setLineDash(__arrL({11, 8}, 2))
            c.strokeStyle = "#e5bfa2"
            c.lineWidth = 2
            c:beginPath()
            c:moveTo(b.x, b.y)
            c:lineTo(b.x + dx / len * 1200, b.y + dy / len * 1200)
            c:stroke()
            c:restore()
        elseif at == "cometRain" then
            do
                local i = 0
                while i < 6 do
                    local x = 310 + i * 91 - 40
                    local pis = math.sin(t * 14 + i) > 0
                    ADD(
                        nil,
                        c,
                        function() return brilho(
                            nil,
                            c,
                            x,
                            20,
                            26,
                            "#c8a8ff",
                            if __t(pis) then 0.7 else 0.35
                        ) end
                    )
                    R(
                        nil,
                        c,
                        x - 1,
                        6,
                        3,
                        10,
                        "#f0e0ff"
                    )
                    R(
                        nil,
                        c,
                        x - 5,
                        10,
                        11,
                        3,
                        "#f0e0ff"
                    )
                    i = i + 1
                end
            end
        elseif __t(at == "cloudGate" or at == "crosswind") then
            do
                local i = 0
                while i < 14 do
                    local y = 90 + hash(nil, i * 5) * 400
                    local x = 960 - __mod(t * 500 + i * 80, 1100)
                    c:save()
                    c.globalAlpha = c.globalAlpha * 0.35
                    R(
                        nil,
                        c,
                        x,
                        y,
                        40 + hash(nil, i) * 40,
                        2,
                        "#e8f0ff"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        else
            return false
        end
        return true
    end
    local function antesChefe(self, c, st)
        local b = st.boss
        if not __t(b) then
            return
        end
        st.__rastro = if __t(st.__rastro) then st.__rastro else __arrL({}, 0)
        if b.state == "swoop" then
            __call(
                st.__rastro,
                "push",
                __arrL({b.x, b.y, st.time}, 3)
            )
            if __gt(
                __len(st.__rastro),
                6
            ) then
                __call(st.__rastro, "shift")
            end
        elseif __t(__len(st.__rastro)) then
            __call(st.__rastro, "shift")
        end
        __call(
            st.__rastro,
            "forEach",
            function(____, ____bindingPattern0, i)
                local y
                local x
                x = ____bindingPattern0[1]
                y = ____bindingPattern0[2]
                c:save()
                c.globalAlpha = c.globalAlpha * (0.1 + i * 0.05)
                ollyan(
                    nil,
                    c,
                    x,
                    y + 63,
                    st.time,
                    {flying = true, scale = 1.37 + (st.phase - 1) * 0.09}
                )
                c:restore()
            end
        )
        if b.state == "swoop" then
            do
                local i = 0
                while i < 8 do
                    c:save()
                    c.globalAlpha = c.globalAlpha * 0.5
                    R(
                        nil,
                        c,
                        b.x + 60 + __mod(st.time * 600 + i * 40, 200),
                        b.y - 60 + i * 16,
                        30,
                        2,
                        "#ffffff"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        if b.state == "firing" then
            local k = 1 - math.max(0, b.stateTime) / 0.38
            ADD(
                nil,
                c,
                function()
                    c.globalAlpha = 1 - k
                    c.strokeStyle = "#f0d8ff"
                    c.lineWidth = 4
                    c:beginPath()
                    c:arc(
                        b.x,
                        b.y,
                        20 + k * 90,
                        0,
                        TAU
                    )
                    c:stroke()
                end
            )
        end
    end
    window.BailePixel = __ord({
        dancer = dancer,
        ollyan = ollyan,
        palco = palco,
        fx = fx,
        cenario = cenario,
        projetil = projetil,
        perigo = perigo,
        telegrafa = telegrafa,
        antesChefe = antesChefe,
        VARIANTES = VARIANTES
    }, "dancer,ollyan,palco,fx,cenario,projetil,perigo,telegrafa,antesChefe,VARIANTES")
end)(nil)
return ____exports
