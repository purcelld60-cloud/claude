--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __bor = __JSR.__add, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.LugaresFundos) then
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
    local function disco(____, c, x, y, r, cor)
        do
            local yy = __TS__Number(-r)
            while __le(yy, r) do
                local w = math.floor(math.sqrt(math.max(0, r * r - yy * yy)) + 0.5)
                R(
                    nil,
                    c,
                    x - w,
                    y + yy,
                    w * 2 + 1,
                    1,
                    cor
                )
                yy = yy + 1
            end
        end
    end
    local function mix(____, a, b, k)
        local function p(____, h)
            return __arrL(
                {
                    __TS__ParseInt(
                        __call(h, "slice", 1, 3),
                        16
                    ),
                    __TS__ParseInt(
                        __call(h, "slice", 3, 5),
                        16
                    ),
                    __TS__ParseInt(
                        __call(h, "slice", 5, 7),
                        16
                    )
                },
                3
            )
        end
        local A = p(nil, a)
        local B = p(nil, b)
        return __add(
            "#",
            __call(
                __call(
                    A,
                    "map",
                    function(____, v, i) return __call(
                        __call(
                            math.floor(v + (__get(B, i) - v) * k + 0.5),
                            "toString",
                            16
                        ),
                        "padStart",
                        2,
                        "0"
                    ) end
                ),
                "join",
                ""
            )
        )
    end
    local NOITE = "#14203a"
    local function tom(____, cor, noite)
        return if __t(noite) then mix(nil, cor, NOITE, 0.72) else cor
    end
    local function linha(____, c, x0, y0, x1, y1, cor)
        local n = math.max(
            1,
            math.floor(math.max(
                math.abs(x1 - x0),
                math.abs(y1 - y0)
            ) + 0.5)
        )
        do
            local i = 0
            while i <= n do
                R(
                    nil,
                    c,
                    x0 + (x1 - x0) * i / n,
                    y0 + (y1 - y0) * i / n,
                    1,
                    1,
                    cor
                )
                i = i + 1
            end
        end
    end
    local function oval(____, c, x, y, rx, ry, cor)
        local n = math.max(
            8,
            math.floor(__add(rx, ry) * 3 + 0.5)
        )
        do
            local i = 0
            while i < n do
                local a = i / n * math.pi * 2
                R(
                    nil,
                    c,
                    x + math.cos(a) * rx,
                    y + math.sin(a) * ry,
                    1,
                    1,
                    cor
                )
                i = i + 1
            end
        end
    end
    local function brilho(____, c, x, y, r, cor, a)
        if __le(a, 0.01) then
            return
        end
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = math.min(1, a)
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, cor)
        g:addColorStop(1, "rgba(0,0,0,0)")
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    local function ladrilhar(____, c, tile, x0, y0, x1, y1)
        do
            local y = y0
            while __lt(y, y1) do
                do
                    local x = x0
                    while __lt(x, x1) do
                        c:drawImage(tile, x, y)
                        x = __add(x, tile.width)
                    end
                end
                y = __add(y, tile.height)
            end
        end
    end
    local function poligono(____, c, pts, cor, a)
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = a
        c.fillStyle = cor
        c:beginPath()
        c:moveTo(
            __get(pts, 0),
            __get(pts, 1)
        )
        do
            local i = 2
            while __lt(
                i,
                __len(pts)
            ) do
                c:lineTo(
                    __get(pts, i),
                    __get(pts, i + 1)
                )
                i = i + 2
            end
        end
        c:closePath()
        __call(c, "fill")
        c:restore()
    end
    local function ladrilhoPiso(self, tipo)
        local cv, c = table.unpack(
            mk(nil, 12, 12),
            1,
            2
        )
        if tipo == 0 then
            R(
                nil,
                c,
                0,
                0,
                12,
                12,
                "#e2d4b4"
            )
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({0, 0}, 2),
                    __arrL({12, 0}, 2),
                    __arrL({0, 12}, 2),
                    __arrL({12, 12}, 2)
                },
                4
            ))) do
                local x = ____value[1]
                local y = ____value[2]
                disco(
                    nil,
                    c,
                    x,
                    y,
                    4,
                    "#c08466"
                )
            end
            R(
                nil,
                c,
                5,
                3,
                2,
                6,
                "#6a88b0"
            )
            R(
                nil,
                c,
                3,
                5,
                6,
                2,
                "#6a88b0"
            )
            R(
                nil,
                c,
                5,
                5,
                2,
                2,
                "#f2e8cc"
            )
            R(
                nil,
                c,
                2,
                2,
                1,
                1,
                "#3c7a5a"
            )
            R(
                nil,
                c,
                9,
                2,
                1,
                1,
                "#3c7a5a"
            )
            R(
                nil,
                c,
                2,
                9,
                1,
                1,
                "#3c7a5a"
            )
            R(
                nil,
                c,
                9,
                9,
                1,
                1,
                "#3c7a5a"
            )
        else
            R(
                nil,
                c,
                0,
                0,
                12,
                12,
                "#cfa086"
            )
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        6 - k,
                        k,
                        1,
                        1,
                        "#f2e8cc"
                    )
                    R(
                        nil,
                        c,
                        5 + k,
                        k,
                        1,
                        1,
                        "#f2e8cc"
                    )
                    R(
                        nil,
                        c,
                        6 - k,
                        11 - k,
                        1,
                        1,
                        "#f2e8cc"
                    )
                    R(
                        nil,
                        c,
                        5 + k,
                        11 - k,
                        1,
                        1,
                        "#f2e8cc"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                5,
                5,
                2,
                2,
                "#6a88b0"
            )
            R(
                nil,
                c,
                0,
                0,
                1,
                1,
                "#e2d4b4"
            )
            R(
                nil,
                c,
                11,
                11,
                1,
                1,
                "#e2d4b4"
            )
        end
        R(
            nil,
            c,
            0,
            0,
            12,
            1,
            "rgba(90,70,50,.35)"
        )
        R(
            nil,
            c,
            0,
            0,
            1,
            12,
            "rgba(90,70,50,.35)"
        )
        return cv
    end
    local function azulejo(self)
        local cv, c = table.unpack(
            mk(nil, 9, 9),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            0,
            9,
            9,
            "#f4f4ee"
        )
        R(
            nil,
            c,
            0,
            0,
            9,
            1,
            "#d8d8d0"
        )
        R(
            nil,
            c,
            0,
            0,
            1,
            9,
            "#d8d8d0"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({1, 1}, 2),
                __arrL({8, 1}, 2),
                __arrL({1, 8}, 2),
                __arrL({8, 8}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            R(
                nil,
                c,
                x - 1,
                y - 1,
                2,
                2,
                "#2c5a9e"
            )
        end
        R(
            nil,
            c,
            4,
            2,
            1,
            5,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            2,
            4,
            5,
            1,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            4,
            4,
            1,
            1,
            "#f4f4ee"
        )
        R(
            nil,
            c,
            3,
            3,
            1,
            1,
            "#5a8ad8"
        )
        R(
            nil,
            c,
            5,
            5,
            1,
            1,
            "#5a8ad8"
        )
        R(
            nil,
            c,
            5,
            3,
            1,
            1,
            "#5a8ad8"
        )
        R(
            nil,
            c,
            3,
            5,
            1,
            1,
            "#5a8ad8"
        )
        return cv
    end
    local cache = {}
    local function serra(self, noite)
        local W = 760
        local H = 90
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function altura(____, x)
            return 40 + math.sin(x * 0.011) * 16 + math.sin(x * 0.031 + 1.3) * 8 + math.sin(x * 0.087 + 0.4) * 3 + (hash(
                nil,
                math.floor(x / 3)
            ) - 0.5) * 2
        end
        local claro = tom(nil, "#8aa8b8", noite)
        local medio = tom(nil, "#6a8a9c", noite)
        local escuro = tom(nil, "#4f6e82", noite)
        local rocha = tom(nil, "#9ab0bc", noite)
        local function suave(____, x)
            return (altura(nil, x - 3) + altura(nil, x - 1) + altura(nil, x) + altura(nil, x + 1) + altura(nil, x + 3)) / 5
        end
        do
            local x = 0
            while x < W do
                local topo = H - suave(nil, x)
                local incl = suave(nil, x + 4) - suave(nil, x - 4)
                do
                    local y = math.floor(topo + 0.5)
                    while y < H do
                        local prof = (y - topo) / (H - topo)
                        local cor = if incl > 1.2 then claro else if incl < -1.2 then escuro else medio
                        local ____t_2 = __t
                        local ____t_1 = __t
                        local ____temp_0 = incl < -1.2 and prof > 0.3
                        __O[1319] = ____temp_0
                        if ____t_2(if ____t_1(____temp_0) then __mod(x + y, 2) == 0 else __O[1319]) then
                            cor = medio
                        end
                        local ____t_5 = __t
                        local ____t_4 = __t
                        local ____temp_3 = incl > 1.2 and prof > 0.45
                        __O[1320] = ____temp_3
                        if ____t_5(if ____t_4(____temp_3) then __mod(x + y, 2) == 0 else __O[1320]) then
                            cor = medio
                        end
                        local ____t_10 = __t
                        local ____t_9 = __t
                        local ____t_7 = __t
                        local ____temp_6 = __mod(
                            math.floor(y + math.sin(x * 0.05) * 3 + 0.5),
                            9
                        ) == 0 and prof > 0.12
                        __O[1321] = ____temp_6
                        local ____temp_8 = if ____t_7(____temp_6) then prof < 0.7 else __O[1321]
                        __O[1322] = ____temp_8
                        if ____t_10(if ____t_9(____temp_8) then __mod(x + y, 3) ~= 0 else __O[1322]) then
                            cor = escuro
                        end
                        if y - topo < 2 then
                            cor = rocha
                        end
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            cor
                        )
                        y = y + 1
                    end
                end
                x = x + 1
            end
        end
        do
            local y = H - 22
            while y < H do
                do
                    local x = __mod(y, 2)
                    while x < W do
                        if hash(nil, x + y * 7) < (y - (H - 22)) / 22 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                tom(nil, "#c8dce4", noite)
                            )
                        end
                        x = x + 2
                    end
                end
                y = y + 1
            end
        end
        return cv
    end
    local function morros(self, noite)
        local W = 800
        local H = 70
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function alt(____, x)
            return 34 + math.sin(x * 0.017 + 2) * 12 + math.sin(x * 0.043) * 5
        end
        do
            local x = 0
            while x < W do
                local topo = H - alt(nil, x)
                do
                    local y = math.floor(topo + 0.5)
                    while y < H do
                        local faixa = __mod(
                            math.floor((x + y * 1.6) / 46),
                            4
                        )
                        local prof = y - topo
                        local cor = __get(
                            __arrL(
                                {
                                    tom(nil, "#5f9a52", noite),
                                    tom(nil, "#76ad5c", noite),
                                    tom(nil, "#4e8a48", noite),
                                    tom(nil, "#8ab868", noite)
                                },
                                4
                            ),
                            faixa
                        )
                        local ____t_13 = __t
                        local ____t_12 = __t
                        local ____temp_11 = faixa == 0 and __mod(x, 4) == 0
                        __O[1323] = ____temp_11
                        if ____t_13(if ____t_12(____temp_11) then __mod(y, 4) == 0 else __O[1323]) then
                            cor = tom(nil, "#2f6a34", noite)
                        end
                        if __t(faixa == 3 and __mod(x + y, 3) == 0) then
                            cor = tom(nil, "#9ac878", noite)
                        end
                        if prof < 2 then
                            cor = tom(nil, "#9ac878", noite)
                        end
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            cor
                        )
                        y = y + 1
                    end
                end
                x = x + 1
            end
        end
        do
            local x = 0
            while x < W do
                local y = H - 10 - math.sin(x * 0.02) * 6
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    2,
                    tom(nil, "#b89a6a", noite)
                )
                x = x + 1
            end
        end
        do
            local x = 6
            while x < W do
                local y = H - alt(nil, x) + 8
                if y < H - 4 then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        4,
                        tom(nil, "#6a4a2a", noite)
                    )
                    if x + 9 < W then
                        R(
                            nil,
                            c,
                            x,
                            y + 1,
                            9,
                            1,
                            tom(nil, "#8a6a4a", noite)
                        )
                    end
                end
                x = x + 9
            end
        end
        do
            local k = 0
            while k < 14 do
                local x = hash(nil, k * 7) * W
                local y = H - alt(nil, x) + 10 + hash(nil, k) * 12
                if y < H - 3 then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        3,
                        2,
                        tom(nil, if __t(__mod(k, 3)) then "#f2f2ec" else "#6a4a2a", noite)
                    )
                    R(
                        nil,
                        c,
                        x + 3,
                        y - 1,
                        1,
                        1,
                        tom(nil, "#f2f2ec", noite)
                    )
                end
                k = k + 1
            end
        end
        return cv
    end
    local function arvoreSprite(self, tipo, seed, noite, balanco)
        local cv, c = table.unpack(
            mk(nil, 48, 64),
            1,
            2
        )
        local cx = 24
        local base = 63
        if tipo == "coqueiro" then
            do
                local y = 0
                while y < 40 do
                    local x = cx + math.sin(y * 0.06 + seed) * 4 + balanco * (40 - y) / 40
                    R(
                        nil,
                        c,
                        x,
                        base - y,
                        3,
                        1,
                        tom(nil, if __t(__mod(y, 4)) then "#8a6a44" else "#6a4a2a", noite)
                    )
                    y = y + 1
                end
            end
            local tx = cx + math.sin(40 * 0.06 + seed) * 4 + balanco
            local ty = base - 40
            do
                local f = 0
                while f < 7 do
                    local a = -math.pi / 2 + (f - 3) * 0.55 + balanco * 0.05
                    do
                        local k = 0
                        while k < 14 do
                            local x = tx + math.cos(a) * k + 1
                            local y = ty + math.sin(a) * k * 0.6 + k * k * 0.045
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                1,
                                tom(nil, if __t(__mod(k, 3)) then "#3a8a3a" else "#5aaa4a", noite)
                            )
                            if __t(__mod(k, 2)) then
                                R(
                                    nil,
                                    c,
                                    x,
                                    y + 1,
                                    1,
                                    2,
                                    tom(nil, "#2a6a2a", noite)
                                )
                            end
                            k = k + 1
                        end
                    end
                    f = f + 1
                end
            end
            R(
                nil,
                c,
                tx - 1,
                ty + 2,
                3,
                3,
                tom(nil, "#7a5a2a", noite)
            )
            R(
                nil,
                c,
                tx + 2,
                ty + 3,
                3,
                3,
                tom(nil, "#8a6a2a", noite)
            )
            return cv
        end
        if tipo == "bananeira" then
            do
                local y = 0
                while y < 22 do
                    R(
                        nil,
                        c,
                        cx - 1,
                        base - y,
                        3,
                        1,
                        tom(nil, "#6a8a3a", noite)
                    )
                    y = y + 1
                end
            end
            do
                local f = 0
                while f < 6 do
                    local lado = if __t(__mod(f, 2)) then 1 else -1
                    local a0 = base - 18 - f * 3
                    do
                        local k = 0
                        while k < 16 do
                            local x = cx + lado * k + balanco * (k / 16) * 2
                            local y = a0 - k * 0.5 + k * k * 0.06
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                4,
                                tom(nil, if __t(__mod(k, 4)) then "#5aa84a" else "#3a8a3a", noite)
                            )
                            R(
                                nil,
                                c,
                                x,
                                y + 4,
                                1,
                                1,
                                tom(nil, "#2a6a2a", noite)
                            )
                            k = k + 1
                        end
                    end
                    f = f + 1
                end
            end
            R(
                nil,
                c,
                cx + 3,
                base - 20,
                3,
                5,
                tom(nil, "#8a3a5a", noite)
            )
            return cv
        end
        local jaca = tipo == "jaqueira"
        R(
            nil,
            c,
            cx - 2,
            base - 24,
            5,
            24,
            tom(nil, "#5a3a22", noite)
        )
        R(
            nil,
            c,
            cx - 2,
            base - 24,
            1,
            24,
            tom(nil, "#7a5232", noite)
        )
        R(
            nil,
            c,
            cx - 6,
            base - 18,
            4,
            2,
            tom(nil, "#5a3a22", noite)
        )
        R(
            nil,
            c,
            cx + 3,
            base - 22,
            5,
            2,
            tom(nil, "#5a3a22", noite)
        )
        local cores = __arrL(
            {
                tom(nil, "#1f5a2c", noite),
                tom(nil, "#2f7a3a", noite),
                tom(nil, "#4a9a46", noite),
                tom(nil, "#7ac05a", noite)
            },
            4
        )
        local cachos = __arrL({}, 0)
        do
            local k = 0
            while k < 14 do
                local a = hash(nil, seed * 9 + k) * math.pi * 2
                local r = 4 + hash(nil, seed + k * 3) * 10
                __call(
                    cachos,
                    "push",
                    __arrL(
                        {
                            cx + math.cos(a) * r * 1.2 + balanco * (1 - math.sin(a)) * 0.8,
                            base - 36 + math.sin(a) * r * 0.8,
                            6 + hash(nil, k + seed) * 4
                        },
                        3
                    )
                )
                k = k + 1
            end
        end
        for ____, ____value in __iterar((cachos)) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            disco(
                nil,
                c,
                x,
                y + 2,
                r,
                __get(cores, 0)
            )
        end
        for ____, ____value in __iterar((cachos)) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            disco(
                nil,
                c,
                x,
                y,
                r - 1,
                __get(cores, 1)
            )
        end
        for ____, ____value in __iterar((cachos)) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            if y < base - 34 then
                disco(
                    nil,
                    c,
                    x - 1,
                    y - 2,
                    r - 3,
                    __get(cores, 2)
                )
            end
        end
        for ____, ____value in __iterar((cachos)) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            if y < base - 40 then
                disco(
                    nil,
                    c,
                    x - 2,
                    y - 3,
                    math.max(1, r - 5),
                    __get(cores, 3)
                )
            end
        end
        do
            local k = 0
            while k < 40 do
                local x = cx - 14 + hash(nil, k * 5 + seed) * 28
                local y = base - 50 + hash(nil, k * 3 + seed) * 26
                if __gt(
                    __get(
                        c:getImageData(x, y, 1, 1).data,
                        3
                    ),
                    0
                ) then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        if __t(__mod(k, 2)) then __get(cores, 3) else __get(cores, 0)
                    )
                end
                k = k + 1
            end
        end
        if __t(jaca) then
            do
                local k = 0
                while k < 4 do
                    local x = cx - 6 + k * 4
                    local y = base - 26 - __mod(k, 2) * 4
                    R(
                        nil,
                        c,
                        x,
                        y,
                        3,
                        5,
                        tom(nil, "#a8b84a", noite)
                    )
                    R(
                        nil,
                        c,
                        x,
                        y,
                        3,
                        1,
                        tom(nil, "#c8d86a", noite)
                    )
                    k = k + 1
                end
            end
        else
            do
                local k = 0
                while k < 5 do
                    local x = cx - 10 + hash(nil, k + seed) * 20
                    local y = base - 40 + hash(nil, k * 2 + seed) * 14
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        tom(nil, if __t(__mod(k, 2)) then "#f2a83a" else "#e86a3a", noite)
                    )
                    k = k + 1
                end
            end
        end
        return cv
    end
    local TIPOS = __arrL({
        "mangueira",
        "coqueiro",
        "jaqueira",
        "bananeira",
        "mangueira",
        "coqueiro",
        "bananeira",
        "jaqueira"
    }, 8)
    local function arvores(self, noite)
        local k = __add("arv", noite)
        if __t(__get(cache, k)) then
            return __get(cache, k)
        end
        local lista = __arrL({}, 0)
        do
            local i = 0
            while i < __len(TIPOS) do
                __call(
                    lista,
                    "push",
                    __call(
                        __arrL({-1, 0, 1}, 3),
                        "map",
                        function(____, b) return arvoreSprite(
                            nil,
                            __get(TIPOS, i),
                            i + 1,
                            noite,
                            b
                        ) end
                    )
                )
                i = i + 1
            end
        end
        return __set(cache, k, lista)
    end
    local function linhaArvores(self, c, camL, t, noite, y0, fator, espaco)
        local sprites = arvores(nil, noite)
        local off = camL * fator
        do
            local i = -2
            while i < 482 / espaco + 3 do
                local idx = math.floor(off / espaco) + i
                local x = idx * espaco - off + (hash(nil, idx * 3.3) - 0.5) * 14
                local s = __get(
                    sprites,
                    __mod(
                        __mod(
                            idx,
                            __len(sprites)
                        ) + __len(sprites),
                        __len(sprites)
                    )
                )
                local fase = math.sin(t * 1.3 + idx * 0.7)
                local f = if fase > 0.4 then 2 else if fase < -0.4 then 0 else 1
                local esc = 0.8 + hash(nil, idx * 1.7) * 0.4
                c:drawImage(
                    __get(s, f),
                    math.floor(x + 0.5),
                    math.floor(y0 - 64 * esc + 0.5),
                    math.floor(48 * esc + 0.5),
                    math.floor(64 * esc + 0.5)
                )
                i = i + 1
            end
        end
    end
    local function camadaAcude(self, c, s, t, camL, n)
        local noite = if __gt(n, 0.5) then 1 else 0
        local kS = __add("serra", noite)
        local kM = __add("morros", noite)
        if not __t(__get(cache, kS)) then
            __set(
                cache,
                kS,
                serra(nil, noite)
            )
        end
        if not __t(__get(cache, kM)) then
            __set(
                cache,
                kM,
                morros(nil, noite)
            )
        end
        do
            local k = 0
            while k < 5 do
                local x = __mod(t * (14 + k * 3) + k * 140 - camL * 0.05, 620) - 70
                local y = 30 + k * 9 + math.sin(t * 2 + k) * 3
                local asa = if math.sin(t * 9 + k) > 0 then 1 else 0
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    if __t(noite) then "#1a1a2a" else "#2a2a3a"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - asa,
                    2,
                    1,
                    if __t(noite) then "#1a1a2a" else "#2a2a3a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y - asa,
                    2,
                    1,
                    if __t(noite) then "#1a1a2a" else "#2a2a3a"
                )
                k = k + 1
            end
        end
        local sx = __TS__Number(-__mod(camL * 0.06, 278))
        c:drawImage(
            __get(cache, kS),
            math.floor(sx + 0.5),
            62
        )
        local mx = __TS__Number(-__mod(camL * 0.12, 318))
        c:drawImage(
            __get(cache, kM),
            math.floor(mx + 0.5),
            86
        )
    end
    local function arvoresAcude(self, c, t, camL, n)
        linhaArvores(
            nil,
            c,
            camL,
            t,
            if __gt(n, 0.5) then 1 else 0,
            152,
            0.3,
            46
        )
    end
    local function aguaAcude(self, c, t, camL, n)
        local noite = __gt(n, 0.5)
        local faixas = if __t(noite) then __arrL({
            "#1a2c52",
            "#16264a",
            "#122042",
            "#0e1a3a",
            "#0c1630"
        }, 5) else __arrL({
            "#6aaed8",
            "#5a9ac8",
            "#4a8ab8",
            "#3a7aa8",
            "#2a6a98"
        }, 5)
        do
            local i = 0
            while i < __len(faixas) do
                local y = 150 + i * 10
                R(
                    nil,
                    c,
                    0,
                    y,
                    482,
                    10,
                    __get(faixas, i)
                )
                if i < __len(faixas) - 1 then
                    do
                        local x = __mod(i, 2)
                        while x < 482 do
                            R(
                                nil,
                                c,
                                x,
                                y + 9,
                                1,
                                1,
                                __get(faixas, i + 1)
                            )
                            x = x + 2
                        end
                    end
                end
                i = i + 1
            end
        end
        local sprites = arvores(nil, if __t(noite) then 1 else 0)
        local off = camL * 0.3
        c:save()
        c.globalAlpha = if __t(noite) then 0.25 else 0.3
        do
            local i = -2
            while i < 482 / 46 + 3 do
                local idx = math.floor(off / 46) + i
                local x = idx * 46 - off + (hash(nil, idx * 3.3) - 0.5) * 14
                local s = __get(
                    __get(
                        sprites,
                        __mod(
                            __mod(
                                idx,
                                __len(sprites)
                            ) + __len(sprites),
                            __len(sprites)
                        )
                    ),
                    1
                )
                local esc = 0.8 + hash(nil, idx * 1.7) * 0.4
                do
                    local row = 0
                    while row < 40 do
                        local onda = math.floor(math.sin(t * 2.4 + row * 0.5 + idx) * (1 + row / 20) + 0.5)
                        c:drawImage(
                            s,
                            0,
                            63 - row * (64 / 48),
                            48,
                            2,
                            math.floor(x + onda + 0.5),
                            152 + row,
                            math.floor(48 * esc + 0.5),
                            2
                        )
                        row = row + 2
                    end
                end
                i = i + 1
            end
        end
        c:restore()
        do
            local k = 0
            while k < 40 do
                local x = __mod(
                    __mod(
                        k * 61 - camL * 0.7 + t * (4 + __mod(k, 3) * 2),
                        520
                    ) + 520,
                    520
                ) - 20
                local y = 156 + __mod(k * 7, 40)
                local w = 4 + __mod(k, 4) * 3
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    1,
                    if __t(noite) then if __t(__mod(k, 2)) then "#3a5a8a" else "#2a3a6a" else if __t(__mod(k, 2)) then "#b8e0f8" else "#8ac0e0"
                )
                if __mod(k, 5) == 0 then
                    R(
                        nil,
                        c,
                        x + 1,
                        y - 1,
                        w - 2,
                        1,
                        if __t(noite) then "#4a6a9a" else "#e8f8ff"
                    )
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 12 do
                local on = math.sin(t * 5 + k * 2.3) > 0.7
                if __t(on) then
                    local x = __mod(
                        hash(nil, k * 9) * 520 - __mod(camL * 0.5, 520) + 520,
                        520
                    ) - 20
                    local y = 154 + hash(nil, k * 3) * 40
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        1,
                        "#ffffff"
                    )
                    R(
                        nil,
                        c,
                        x + 0.5,
                        y - 1,
                        1,
                        3,
                        "rgba(255,255,255,.6)"
                    )
                end
                k = k + 1
            end
        end
        do
            local ciclo = __mod(t * 0.25, 1)
            if ciclo < 0.12 then
                local u = ciclo / 0.12
                local x = 300 - __mod(camL * 0.7, 600) + 200
                local y = 176 - math.sin(u * math.pi) * 14
                R(
                    nil,
                    c,
                    x + u * 18,
                    y,
                    5,
                    2,
                    if __t(noite) then "#6a7a9a" else "#c8d0d8"
                )
                R(
                    nil,
                    c,
                    x + u * 18 - 2,
                    y - 1,
                    2,
                    1,
                    if __t(noite) then "#6a7a9a" else "#c8d0d8"
                )
                if u > 0.85 then
                    do
                        local k = 0
                        while k < 5 do
                            R(
                                nil,
                                c,
                                x + 16 + k * 2 - 4,
                                176 - __mod(k, 2),
                                1,
                                1,
                                "#ffffff"
                            )
                            k = k + 1
                        end
                    end
                end
            end
        end
        if not __t(noite) then
            do
                local k = 0
                while k < 3 do
                    local x = __mod(
                        k * 170 + t * 30 + math.sin(t * 3 + k) * 20 - camL * 0.9,
                        520
                    )
                    local y = 184 + math.sin(t * 4 + k * 2) * 6
                    R(
                        nil,
                        c,
                        x,
                        y,
                        4,
                        1,
                        "#3a6ac8"
                    )
                    local asa = math.sin(t * 40 + k) > 0
                    R(
                        nil,
                        c,
                        x + 1,
                        y - if __t(asa) then 2 else 1,
                        1,
                        1,
                        "rgba(220,240,255,.8)"
                    )
                    R(
                        nil,
                        c,
                        x + 2,
                        y - if __t(asa) then 2 else 1,
                        1,
                        1,
                        "rgba(220,240,255,.8)"
                    )
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 30 do
                local wx = k * 83
                local x = __mod(
                    __mod(wx - camL, 2400) + 2400,
                    2400
                ) - 40
                if __t(x < -10 or x > 490) then
                    continue
                end
                if hash(nil, k) < 0.5 then
                    continue
                end
                do
                    local j = 0
                    while j < 4 do
                        local sw = math.sin(t * 1.8 + k + j) * 1.5
                        local h = 14 + j * 4
                        do
                            local y = 0
                            while y < h do
                                R(
                                    nil,
                                    c,
                                    x + j * 3 + sw * y / h,
                                    198 - y,
                                    1,
                                    1,
                                    if __t(noite) then "#1a3a22" else "#4a7a3a"
                                )
                                y = y + 1
                            end
                        end
                        R(
                            nil,
                            c,
                            x + j * 3 + sw - 1,
                            198 - h - 4,
                            3,
                            5,
                            if __t(noite) then "#2a2018" else "#6a4a2a"
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
    end
    local function oficinaParede(self, c, W)
        do
            local y = 30
            local r = 0
            while y < 186 do
                do
                    local x = __mod(r, 2) * 14 - 14
                    while __lt(x, W) do
                        local h = hash(nil, x * 0.31 + y * 1.7)
                        c.globalAlpha = 0.1 + h * 0.1
                        R(
                            nil,
                            c,
                            x + 1,
                            y + 1,
                            26,
                            10,
                            if h > 0.5 then "#7a8696" else "#2a323e"
                        )
                        c.globalAlpha = 1
                        R(
                            nil,
                            c,
                            x + 1,
                            y + 1,
                            26,
                            1,
                            "rgba(255,255,255,.08)"
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            y + 10,
                            26,
                            1,
                            "rgba(0,0,0,.22)"
                        )
                        R(
                            nil,
                            c,
                            x + 26,
                            y + 1,
                            1,
                            10,
                            "rgba(0,0,0,.15)"
                        )
                        if h > 0.86 then
                            local cx = x + 6 + h * 12
                            local cy = y + 2
                            do
                                local k = 0
                                while k < 6 do
                                    R(
                                        nil,
                                        c,
                                        cx,
                                        cy,
                                        1,
                                        1,
                                        "rgba(10,14,20,.6)"
                                    )
                                    cx = cx + if hash(nil, k + x) > 0.5 then 1 else -1
                                    cy = cy + 1
                                    k = k + 1
                                end
                            end
                        end
                        if h < 0.05 then
                            R(
                                nil,
                                c,
                                x + 4,
                                y + 3,
                                6,
                                4,
                                "rgba(20,24,30,.35)"
                            )
                        end
                        x = x + 28
                    end
                end
                do
                    y = y + 12
                    r = r + 1
                end
            end
        end
        do
            local i = 0
            while i < W / 18 do
                local x = hash(nil, i * 3.3) * W
                local len = 20 + hash(nil, i) * 60
                do
                    local y = 34
                    while y < 34 + len do
                        c.globalAlpha = 0.25 * (1 - (y - 34) / len)
                        R(
                            nil,
                            c,
                            x + math.sin(y * 0.2 + i) * 0.8,
                            y,
                            2,
                            2,
                            "#14181e"
                        )
                        y = y + 2
                    end
                end
                i = i + 1
            end
        end
        c.globalAlpha = 1
        R(
            nil,
            c,
            0,
            150,
            W,
            36,
            "rgba(46,92,140,.55)"
        )
        R(
            nil,
            c,
            0,
            150,
            W,
            2,
            "rgba(140,180,220,.4)"
        )
        do
            local i = 0
            while i < W / 22 do
                local x = hash(nil, i * 7.1) * W
                local y = 152 + hash(nil, i * 2.3) * 28
                local w = 4 + hash(nil, i) * 10
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    3 + hash(nil, i * 5) * 4,
                    "#56606c"
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    1,
                    "rgba(255,255,255,.15)"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            82,
            W,
            3,
            "#5a646e"
        )
        R(
            nil,
            c,
            0,
            82,
            W,
            1,
            "#8a949e"
        )
        do
            local x = 60
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x - 5,
                    78,
                    11,
                    11,
                    "#4a545e"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    79,
                    9,
                    1,
                    "#7a848e"
                )
                R(
                    nil,
                    c,
                    x,
                    89,
                    3,
                    30 + __mod(x, 3) * 12,
                    "#5a646e"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    119 + __mod(x, 3) * 12,
                    9,
                    7,
                    "#3a444e"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    121 + __mod(x, 3) * 12,
                    2,
                    2,
                    "#e8c24a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    121 + __mod(x, 3) * 12,
                    2,
                    2,
                    "#e8c24a"
                )
                x = x + 170
            end
        end
        do
            local x = 140
            while __lt(x, W) do
                do
                    local k = 0
                    while k < 30 do
                        R(
                            nil,
                            c,
                            x + k,
                            85 + math.sin(k / 30 * math.pi) * 14,
                            1,
                            1,
                            "#1c1c1c"
                        )
                        k = k + 1
                    end
                end
                x = x + 320
            end
        end
        do
            local i = 0
            while i < W / 140 do
                local x = 30 + hash(nil, i * 4.4) * (W - 60)
                local y = 120 + hash(nil, i * 6.6) * 26
                R(
                    nil,
                    c,
                    x,
                    y,
                    10,
                    7,
                    __get(
                        __arrL({"#e8c24a", "#c43c3a", "#f2f2ee", "#3a8a5a"}, 4),
                        __mod(i, 4)
                    )
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y + 2,
                    6,
                    1,
                    "rgba(0,0,0,.4)"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 200 do
                local x = hash(nil, i * 8.8) * W
                local y = 160 + hash(nil, i) * 20
                c.globalAlpha = 0.35
                R(
                    nil,
                    c,
                    x,
                    y,
                    5,
                    6,
                    "#14181e"
                )
                do
                    local d = 0
                    while d < 4 do
                        R(
                            nil,
                            c,
                            x + d,
                            y - 3,
                            1,
                            3,
                            "#14181e"
                        )
                        d = d + 1
                    end
                end
                c.globalAlpha = 1
                i = i + 1
            end
        end
    end
    local function oficinaChao(self, c, W)
        do
            local x = -400
            while __lt(x, W + 400) do
                do
                    local y = 222
                    while y < 270 do
                        local xx = x + (x - W / 2) * (y - 222) / 90
                        R(
                            nil,
                            c,
                            xx,
                            y,
                            1,
                            2,
                            "rgba(30,34,40,.35)"
                        )
                        y = y + 2
                    end
                end
                x = x + 40
            end
        end
        for ____, y in __iterar((__arrL({232, 246, 262}, 3))) do
            R(
                nil,
                c,
                0,
                y,
                W,
                1,
                "rgba(30,34,40,.3)"
            )
        end
        do
            local i = 0
            while i < W / 60 do
                local x = hash(nil, i * 1.9) * W
                local y = 224 + hash(nil, i * 3.1) * 40
                do
                    local k = 0
                    while k < 10 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            "rgba(20,22,28,.6)"
                        )
                        x = x + (1 + if hash(nil, k + i) > 0.6 then 1 else 0)
                        y = y + if hash(nil, k * 2 + i) > 0.5 then 1 else -1
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 3 do
                local y = 236 + i * 9
                do
                    local x = 120 + i * 30
                    while x < 700 do
                        R(
                            nil,
                            c,
                            x,
                            y + math.sin(x * 0.02) * 2,
                            2,
                            2,
                            "rgba(14,16,20,.25)"
                        )
                        x = x + 3
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 90 do
                local x = hash(nil, i * 4.7) * W
                local y = 232 + hash(nil, i * 1.3) * 30
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x - 6 + k * 3,
                            y + __mod(k, 2),
                            3,
                            1,
                            __get(
                                __arrL({"rgba(200,80,200,.25)", "rgba(80,200,220,.25)", "rgba(230,220,90,.25)"}, 3),
                                __mod(k, 3)
                            )
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W * 1.5 do
                R(
                    nil,
                    c,
                    hash(nil, i * 0.7) * W,
                    222 + hash(nil, i * 1.1) * 48,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "rgba(255,255,255,.06)" else "rgba(0,0,0,.1)"
                )
                i = i + 1
            end
        end
        do
            local x = 182
            while x < 434 do
                if hash(nil, x * 0.37) > 0.08 then
                    R(
                        nil,
                        c,
                        x,
                        223,
                        2,
                        2,
                        "#c8a030"
                    )
                end
                x = x + 2
            end
        end
        do
            local y = 223
            while y < 270 do
                local d = (y - 223) * 0.35
                R(
                    nil,
                    c,
                    182 - d,
                    y,
                    2,
                    2,
                    if hash(nil, y) > 0.1 then "#c8a030" else "#8a7a50"
                )
                R(
                    nil,
                    c,
                    432 + d,
                    y,
                    2,
                    2,
                    if hash(nil, y + 9) > 0.1 then "#c8a030" else "#8a7a50"
                )
                y = y + 2
            end
        end
        do
            local y = 224
            while y < 232 do
                do
                    local x = 672
                    while x < 714 do
                        R(
                            nil,
                            c,
                            x + (y - 224),
                            y,
                            4,
                            1,
                            "#c8a030"
                        )
                        R(
                            nil,
                            c,
                            x + 4 + (y - 224),
                            y,
                            4,
                            1,
                            "#26282c"
                        )
                        x = x + 8
                    end
                end
                y = y + 1
            end
        end
        do
            local i = 0
            while i < 140 do
                local a = hash(nil, i * 2.1) * math.pi * 2
                local r = hash(nil, i * 3.7) * 14
                R(
                    nil,
                    c,
                    300 + math.cos(a) * r * 1.6,
                    240 + math.sin(a) * r * 0.4,
                    1,
                    1,
                    if __t(__mod(i, 3)) then "#c8a878" else "#a88858"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            560,
            236,
            9,
            3,
            "#c43c3a"
        )
        R(
            nil,
            c,
            562,
            238,
            6,
            2,
            "#a82a2a"
        )
        R(
            nil,
            c,
            566,
            235,
            3,
            1,
            "#e86a5a"
        )
        do
            local i = 0
            while i < 14 do
                local x = 140 + hash(nil, i * 9.1) * 900
                local y = 228 + hash(nil, i * 4.3) * 36
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    2,
                    "#6a7078"
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#c8ccd0"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            900,
            252,
            14,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            912,
            250,
            4,
            6,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            913,
            252,
            2,
            2,
            "#5e636a"
        )
        do
            local i = 0
            while i < 400 do
                local x = hash(nil, i * 1.37) * 140 * hash(nil, i * 2.2)
                local y = 222 + hash(nil, i * 3.1) * 48
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "rgba(150,120,80,.4)" else "rgba(120,96,64,.35)"
                )
                i = i + 1
            end
        end
    end
    local function oficinaAnim(self, c, t, camL, n)
        do
            local x = 700 - camL
            if __t(x > -20 and x < 500) then
                local a = math.sin(t * 1.2) * 0.15
                do
                    local k = 0
                    while k < 22 do
                        R(
                            nil,
                            c,
                            x + math.sin(a) * k * 3,
                            34 + k * 3,
                            2,
                            2,
                            if __t(__mod(k, 2)) then "#6a7078" else "#9aa0a6"
                        )
                        k = k + 1
                    end
                end
                local hx = x + math.sin(a) * 66
                R(
                    nil,
                    c,
                    hx - 3,
                    100,
                    7,
                    3,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    hx,
                    103,
                    2,
                    4,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    hx - 2,
                    106,
                    2,
                    2,
                    "#9aa0a6"
                )
            end
        end
        do
            local x = 300 - camL
            if __t(x > -10 and x < 490) then
                local u = __mod(t * 0.7, 1)
                if u < 0.8 then
                    R(
                        nil,
                        c,
                        x,
                        188 + u * 30,
                        1,
                        2,
                        "#1c1c24"
                    )
                else
                    R(
                        nil,
                        c,
                        x - 2,
                        218,
                        5,
                        1,
                        "#1c1c24"
                    )
                end
            end
        end
        do
            local x = 560 - camL
            if __t(x > -20 and x < 500) then
                local a = t * 6
                R(
                    nil,
                    c,
                    x + math.cos(a) * 10,
                    62 + math.sin(a * 1.3) * 5,
                    2,
                    1,
                    "#e8e2c8"
                )
            end
        end
        if __gt(n, 0.05) then
            for ____, x0 in __iterar((__arrL({92, 492, 892}, 3))) do
                local sx = x0 - camL
                if __t(sx > -110 and sx < 490) then
                    R(
                        nil,
                        c,
                        sx,
                        1,
                        100,
                        22,
                        ("rgba(10,14,34," .. tostring(__call(
                            0.78 * math.min(1, n * 1.4),
                            "toFixed",
                            2
                        ))) .. ")"
                    )
                end
            end
        end
        if __lt(n, 0.5) then
            local a = 0.055 * (1 - n * 2)
            for ____, x0 in __iterar((__arrL({92, 492, 892}, 3))) do
                local sx = x0 - camL
                if __t(sx < -160 or sx > 560) then
                    continue
                end
                poligono(
                    nil,
                    c,
                    __arrL({
                        sx,
                        24,
                        sx + 100,
                        24,
                        sx + 150,
                        220,
                        sx + 50,
                        220
                    }, 8),
                    "#fff0c0",
                    a
                )
                do
                    local k = 0
                    while k < 6 do
                        local u = __mod(
                            t * 0.03 + hash(nil, k + x0),
                            1
                        )
                        local px = sx + 25 + u * 50 + hash(nil, k * 7 + x0) * 70 + math.sin(t + k) * 3
                        local py = 30 + u * 180
                        R(
                            nil,
                            c,
                            px,
                            py,
                            1,
                            1,
                            "rgba(255,240,200,.7)"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local sx = __TS__Number(-camL)
            if __t(sx > -160 and __lt(n, 0.7)) then
                poligono(
                    nil,
                    c,
                    __arrL({
                        sx,
                        220,
                        sx + 76,
                        220,
                        sx + 150,
                        270,
                        sx,
                        270
                    }, 8),
                    "#fff2d0",
                    0.1 * (1 - n)
                )
            end
        end
        do
            local x = 1020 - camL
            local y = 54
            if __t(x > -20 and x < 500) then
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 8 + k * math.pi / 2
                        linha(
                            nil,
                            c,
                            x,
                            y,
                            x + math.cos(a) * 8,
                            y + math.sin(a) * 8,
                            "#7a8086"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    3,
                    3,
                    "#3a3e44"
                )
            end
        end
        do
            local x = 856 - camL
            if __t(x > -10 and x < 490) then
                local L = math.floor(10 + (math.sin(t * 0.5) * 0.5 + 0.5) * 26 + 0.5)
                R(
                    nil,
                    c,
                    x,
                    42,
                    1,
                    L,
                    "rgba(220,220,230,.35)"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    42 + L,
                    3,
                    2,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    42 + L,
                    1,
                    1,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    43 + L,
                    1,
                    1,
                    "#1c1c1c"
                )
            end
        end
        do
            local x = 1056 - camL
            if __t(x > -12 and x < 494) then
                local a = math.floor(t) / 60 * math.pi * 2 - math.pi / 2
                linha(
                    nil,
                    c,
                    x,
                    112,
                    x + math.cos(a) * 6,
                    112 + math.sin(a) * 6,
                    "#c43c3a"
                )
            end
        end
        do
            local x = 691 - camL
            if __t(x > -20 and x < 500) then
                local liga = __mod(t, 9) < 2.5
                R(
                    nil,
                    c,
                    x + 10,
                    190,
                    2,
                    2,
                    if __t(liga) then "#5aff7a" else "#1a4a2a"
                )
                local a = -2.4 + if __t(liga) then 1.6 + math.sin(t * 30) * 0.12 else 0.3
                linha(
                    nil,
                    c,
                    x,
                    186,
                    x + math.cos(a) * 3,
                    186 + math.sin(a) * 3,
                    "#c43c3a"
                )
                if __t(liga) then
                    do
                        local k = 0
                        while k < 3 do
                            local u = __mod(t * 2 + k / 3, 1)
                            c.globalAlpha = 1 - u
                            R(
                                nil,
                                c,
                                x - 8 - u * 6,
                                200 - u * 8,
                                2,
                                2,
                                "#e8e8f0"
                            )
                            c.globalAlpha = 1
                            k = k + 1
                        end
                    end
                end
            end
        end
    end
    local function lancheParede(self, c, W, PORTA)
        do
            local y = 30
            while y < 128 do
                do
                    local x = PORTA + __mod(y / 2, 2)
                    while __lt(x, W) do
                        local h = hash(nil, x * 1.3 + y * 7.1)
                        if h > 0.92 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                "rgba(255,250,220,.35)"
                            )
                        elseif h < 0.06 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                "rgba(150,110,50,.3)"
                            )
                        end
                        x = x + 2
                    end
                end
                y = y + 2
            end
        end
        do
            local x = 430
            while x < 740 do
                do
                    local y = 70
                    while y < 128 do
                        if hash(nil, x + y * 3) < (y - 70) / 140 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                2,
                                "rgba(140,100,40,.18)"
                            )
                        end
                        y = y + 2
                    end
                end
                x = x + 2
            end
        end
        do
            local y = 134
            while y < 220 do
                do
                    local x = PORTA
                    while __lt(x, W) do
                        R(
                            nil,
                            c,
                            x + 1,
                            y + 1,
                            3,
                            1,
                            "rgba(255,255,255,.9)"
                        )
                        local h = hash(nil, x * 0.7 + y * 1.9)
                        if h > 0.95 then
                            R(
                                nil,
                                c,
                                x + 2,
                                y + 3,
                                1,
                                4,
                                "#b8b8b0"
                            )
                            R(
                                nil,
                                c,
                                x + 3,
                                y + 5,
                                3,
                                1,
                                "#b8b8b0"
                            )
                        end
                        if h < 0.04 then
                            R(
                                nil,
                                c,
                                x + 1,
                                y + 1,
                                7,
                                7,
                                "#e8e8dc"
                            )
                        end
                        x = x + 9
                    end
                end
                y = y + 9
            end
        end
        do
            local x = PORTA
            while __lt(x, W) do
                if hash(nil, x * 2.2) > 0.6 then
                    R(
                        nil,
                        c,
                        x,
                        15 + hash(nil, x) * 10,
                        2,
                        1,
                        "rgba(40,24,12,.5)"
                    )
                end
                x = x + 3
            end
        end
        do
            local x = PORTA + 30
            while __lt(x, W) do
                disco(
                    nil,
                    c,
                    x,
                    21,
                    2,
                    "#4a2c18"
                )
                x = x + 140
            end
        end
        do
            local i = 0
            while i < 3 do
                local x = 820 + i * 22
                local y = 112
                R(
                    nil,
                    c,
                    x,
                    y,
                    16,
                    12,
                    "#f2f2e8"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y + 2,
                    12,
                    8,
                    __get(
                        __arrL({"#8a7a6a", "#6a8a9a", "#9a7a5a"}, 3),
                        i
                    )
                )
                i = i + 1
            end
        end
        do
            local x = PORTA
            while __lt(x, W) do
                local y = 30 + math.sin(x * 0.05) * 3
                c.fillStyle = __get(
                    __arrL({"#e8433a", "#f2c94c", "#3c8a5a", "#3a6aa8"}, 4),
                    __bor(
                        __mod(x / 12, 4),
                        0
                    )
                )
                c:beginPath()
                c:moveTo(x, y)
                c:lineTo(x + 8, y)
                c:lineTo(x + 4, y + 7)
                c:closePath()
                __call(c, "fill")
                x = x + 12
            end
        end
        do
            local az = azulejo(nil)
            ladrilhar(
                nil,
                c,
                az,
                PORTA,
                139,
                W,
                148
            )
            R(
                nil,
                c,
                PORTA,
                148,
                W - PORTA,
                1,
                "#2c5a9e"
            )
        end
        R(
            nil,
            c,
            PORTA,
            211,
            W - PORTA,
            9,
            "#2a6a5a"
        )
        do
            local x = PORTA
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    211,
                    1,
                    9,
                    "#1a4a3e"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    212,
                    3,
                    1,
                    "#5a9a8a"
                )
                x = x + 9
            end
        end
        R(
            nil,
            c,
            PORTA,
            211,
            W - PORTA,
            1,
            "#4a8a7a"
        )
        do
            local i = 0
            while i < 160 do
                local x = 900 + hash(nil, i * 1.3) * 120
                local y = 32 + hash(nil, i * 2.9) * 22 * hash(nil, i * 4.1)
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    "rgba(150,110,50,.18)"
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({290, 96}, 2),
                __arrL({760, 60}, 2)
            },
            2
        ))) do
            local x0 = ____value[1]
            local y0 = ____value[2]
            local x = x0
            local y = y0
            do
                local k = 0
                while k < 12 do
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        "rgba(120,90,40,.5)"
                    )
                    x = x + if hash(nil, k + x0) > 0.5 then 1 else 0
                    y = y + 1
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            288,
            106,
            6,
            9,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            290,
            108,
            2,
            4,
            "#c8c8c0"
        )
        R(
            nil,
            c,
            290,
            28,
            1,
            78,
            "rgba(60,40,20,.35)"
        )
        R(
            nil,
            c,
            408,
            120,
            7,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            409,
            122,
            1,
            2,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            413,
            122,
            1,
            2,
            "#3a3a3a"
        )
    end
    local function lancheRua(self, c, PORTA)
        do
            local k = 0
            while k < 4 do
                local x = k * 38 - 4
                local h = 70 + __mod(k, 2) * 14
                local y = 150 - h
                R(
                    nil,
                    c,
                    x + 2,
                    y + 32,
                    32,
                    2,
                    "#3a3a3a"
                )
                do
                    local j = 0
                    while j < 8 do
                        R(
                            nil,
                            c,
                            x + 3 + j * 4,
                            y + 34,
                            1,
                            8,
                            "#3a3a3a"
                        )
                        j = j + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 2,
                    y + 42,
                    32,
                    1,
                    "#3a3a3a"
                )
                do
                    local j = 0
                    while j < 3 do
                        R(
                            nil,
                            c,
                            x + 6 + j * 10,
                            y + 28,
                            6,
                            4,
                            "#b8643a"
                        )
                        disco(
                            nil,
                            c,
                            x + 9 + j * 10,
                            y + 25,
                            3,
                            if __t(__mod(j, 2)) then "#3a8a4a" else "#c84a6a"
                        )
                        j = j + 1
                    end
                end
                do
                    local i = 0
                    while i < 40 do
                        R(
                            nil,
                            c,
                            x + hash(nil, i + k * 50) * 36,
                            y + hash(nil, i * 3 + k) * h,
                            1,
                            1,
                            "rgba(0,0,0,.12)"
                        )
                        i = i + 1
                    end
                end
                k = k + 1
            end
        end
        do
            local x = 0
            while __lt(x, PORTA) do
                R(
                    nil,
                    c,
                    x,
                    64 + math.sin(x / PORTA * math.pi) * 10,
                    1,
                    1,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x,
                    72 + math.sin(x / PORTA * math.pi) * 12,
                    1,
                    1,
                    "#1c1c1c"
                )
                x = x + 1
            end
        end
        do
            local x = 0
            while __lt(x, PORTA) do
                if hash(nil, x) > 0.6 then
                    R(
                        nil,
                        c,
                        x,
                        187,
                        3,
                        2,
                        "#6a645a"
                    )
                end
                x = x + 7
            end
        end
    end
    local function lancheChao(self, c, W, PORTA)
        do
            local A = ladrilhoPiso(nil, 0)
            local B = ladrilhoPiso(nil, 1)
            do
                local y = 222
                local r = 0
                while y < 270 do
                    do
                        local x = PORTA
                        local k = 0
                        while __lt(x, W) do
                            c:drawImage(if __t(__mod(k + r, 2)) then B else A, x, y)
                            do
                                x = x + 12
                                k = k + 1
                            end
                        end
                    end
                    do
                        y = y + 12
                        r = r + 1
                    end
                end
            end
            c.globalAlpha = 0.22
            R(
                nil,
                c,
                PORTA,
                222,
                W - PORTA,
                48,
                "#d8c8a8"
            )
            c.globalAlpha = 1
        end
        R(
            nil,
            c,
            PORTA,
            220,
            W - PORTA,
            2,
            "#a89878"
        )
        R(
            nil,
            c,
            PORTA + 4,
            220,
            34,
            3,
            "#5a3a2a"
        )
        do
            local x = PORTA + 5
            while __lt(x, PORTA + 37) do
                R(
                    nil,
                    c,
                    x,
                    221,
                    1,
                    1,
                    "#7a5a3a"
                )
                x = x + 3
            end
        end
        do
            local y = 222
            local r = 0
            while y < 270 do
                do
                    local x = __TS__Number(-__mod(r, 2)) * 4
                    while x < PORTA - 8 do
                        local h = hash(nil, x * 0.7 + y * 3.1)
                        R(
                            nil,
                            c,
                            x,
                            y,
                            7,
                            4,
                            if h > 0.6 then "#8a8478" else if h > 0.3 then "#7a7468" else "#6a645a"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y,
                            7,
                            1,
                            "rgba(255,255,255,.12)"
                        )
                        R(
                            nil,
                            c,
                            x + 6,
                            y + 1,
                            1,
                            3,
                            "rgba(0,0,0,.2)"
                        )
                        x = x + 8
                    end
                end
                do
                    y = y + 5
                    r = r + 1
                end
            end
        end
        do
            local x = PORTA
            while __lt(x, W) do
                do
                    local y = 222
                    while y < 270 do
                        local h = hash(nil, x * 3.3 + y * 0.7)
                        if h > 0.97 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                "rgba(255,255,255,.35)"
                            )
                        elseif h < 0.03 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                1,
                                "rgba(90,60,40,.3)"
                            )
                        end
                        y = y + 2
                    end
                end
                x = x + 3
            end
        end
        do
            local x = 430
            while x < 740 do
                do
                    local y = 222
                    while y < 240 do
                        if hash(nil, x + y * 5) > 0.7 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                1,
                                "rgba(255,240,220,.12)"
                            )
                        end
                        y = y + 2
                    end
                end
                x = x + 2
            end
        end
    end
    local function lancheAnim(self, c, t, camL, n)
        c:save()
        c:beginPath()
        c:rect(
            __TS__Number(-camL),
            0,
            142,
            220
        )
        c:clip()
        do
            local x = __mod(t * 40, 700) - 200 - camL
            if __t(x > -60 - camL and x < 142 - camL) then
                R(
                    nil,
                    c,
                    x,
                    168,
                    40,
                    12,
                    if __gt(n, 0.5) then "#3a2a4a" else "#c84a3a"
                )
                R(
                    nil,
                    c,
                    x + 8,
                    160,
                    22,
                    9,
                    if __gt(n, 0.5) then "#2a2a3a" else "#a83a2a"
                )
                R(
                    nil,
                    c,
                    x + 10,
                    162,
                    8,
                    6,
                    "#9ac8e0"
                )
                R(
                    nil,
                    c,
                    x + 20,
                    162,
                    8,
                    6,
                    "#9ac8e0"
                )
                disco(
                    nil,
                    c,
                    x + 8,
                    181,
                    4,
                    "#1c1c1c"
                )
                disco(
                    nil,
                    c,
                    x + 32,
                    181,
                    4,
                    "#1c1c1c"
                )
                if __gt(n, 0.3) then
                    R(
                        nil,
                        c,
                        x + 38,
                        170,
                        3,
                        2,
                        "#ffe8a0"
                    )
                end
            end
        end
        do
            local x = 160 - __mod(t * 25, 260) - camL
            if __t(x > -30 - camL and x < 142 - camL) then
                disco(
                    nil,
                    c,
                    x,
                    182,
                    4,
                    "#2a2a2a"
                )
                disco(
                    nil,
                    c,
                    x + 14,
                    182,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x,
                    176,
                    14,
                    1,
                    "#3a6aa8"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    166,
                    4,
                    10,
                    "#e8c24a"
                )
                disco(
                    nil,
                    c,
                    x + 8,
                    163,
                    2,
                    "#8a5a3c"
                )
            end
        end
        do
            local u = __mod(t, 19) / 19
            local x = math.floor(160 - u * 200 - camL + 0.5)
            local passo = __mod(
                math.floor(t * 5),
                2
            )
            if __t(x > -12 - camL and x < 150 - camL) then
                R(
                    nil,
                    c,
                    x,
                    196,
                    5,
                    2,
                    "#2a1d16"
                )
                R(
                    nil,
                    c,
                    x,
                    198,
                    5,
                    5,
                    "#8a5a3c"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    203,
                    7,
                    9,
                    "#3a8a6a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    205,
                    1,
                    6,
                    "#2a6a4a"
                )
                R(
                    nil,
                    c,
                    x + if __t(passo) then 0 else 3,
                    212,
                    2,
                    6,
                    "#2a3442"
                )
                R(
                    nil,
                    c,
                    x + if __t(passo) then 3 else 0,
                    212,
                    2,
                    6,
                    "#3a4452"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    205,
                    1,
                    5,
                    "#8a5a3c"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    207,
                    3,
                    4,
                    "#f2f2ee"
                )
            end
        end
        c:restore()
        do
            local sx = __TS__Number(-camL)
            if sx > -40 then
                local nt = __gt(n, 0.5)
                local function T(____, cor)
                    return tom(nil, cor, nt)
                end
                R(
                    nil,
                    c,
                    sx + 9,
                    120,
                    4,
                    70,
                    T(nil, "#5a3a22")
                )
                R(
                    nil,
                    c,
                    sx + 10,
                    120,
                    1,
                    70,
                    T(nil, "#7a5232")
                )
                disco(
                    nil,
                    c,
                    sx + 11,
                    112,
                    16,
                    T(nil, "#2f6a34")
                )
                disco(
                    nil,
                    c,
                    sx + 6,
                    106,
                    10,
                    T(nil, "#3f8a3e")
                )
                disco(
                    nil,
                    c,
                    sx + 16,
                    104,
                    8,
                    T(nil, "#4a9a46")
                )
                disco(
                    nil,
                    c,
                    sx + 5,
                    102,
                    4,
                    T(nil, "#6ab05a")
                )
                do
                    local k = 0
                    while k < 14 do
                        R(
                            nil,
                            c,
                            sx - 4 + hash(nil, k + 600) * 30,
                            98 + hash(nil, k + 601) * 26,
                            1,
                            1,
                            T(nil, if __t(__mod(k, 2)) then "#1f5a2c" else "#7ac05a")
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    sx + 104,
                    160,
                    2,
                    54,
                    T(nil, "#5a5e64")
                )
                do
                    local k = 0
                    while k < 14 do
                        local w = math.floor(math.sqrt(math.max(0, 49 - (k - 7) * (k - 7))) * 1.1 + 0.5)
                        R(
                            nil,
                            c,
                            sx + 105 - w,
                            150 + k,
                            w * 2,
                            1,
                            T(nil, if k < 2 then "#f2a04a" else "#e8843a")
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    sx + 101,
                    156,
                    8,
                    8,
                    T(nil, "#8a4a1a")
                )
                R(
                    nil,
                    c,
                    sx + 103,
                    158,
                    4,
                    5,
                    T(nil, "#3a3e44")
                )
                R(
                    nil,
                    c,
                    sx + 104,
                    163,
                    1,
                    4,
                    "#1c1c1c"
                )
            end
        end
        do
            local x = 78 - camL
            if __t(x > -10 and x < 490) then
                R(
                    nil,
                    c,
                    x - 3,
                    212 + if math.sin(t * 6) > 0 then -1 else 1,
                    3,
                    1,
                    "#d89a4a"
                )
            end
        end
        do
            local k = 0
            while k < 3 do
                local x = 520 - camL + math.cos(t * (3 + k) + k * 2) * (24 + k * 8)
                local y = 126 + math.sin(t * (4 + k)) * 8
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    "#14120e"
                )
                k = k + 1
            end
        end
        do
            local x0 = 144 - camL
            if __t(x0 > -20 and x0 < 490) then
                local cores = __arrL({
                    "#e8433a",
                    "#f2c94c",
                    "#3c8a5a",
                    "#3a6aa8",
                    "#f2f2ee",
                    "#c84a8a",
                    "#e8843a"
                }, 7)
                R(
                    nil,
                    c,
                    x0,
                    90,
                    14,
                    2,
                    "#5a3820"
                )
                do
                    local k = 0
                    while k < 7 do
                        local L = 26 + __mod(k, 3) * 8
                        do
                            local s = 0
                            while s < L do
                                R(
                                    nil,
                                    c,
                                    x0 + 1 + k * 2 + math.sin(t * 2.2 + k * 0.9 + s * 0.12) * s * 0.08,
                                    92 + s,
                                    1,
                                    3,
                                    __get(cores, k)
                                )
                                s = s + 3
                            end
                        end
                        k = k + 1
                    end
                end
            end
        end
        do
            local x0 = 512 - camL
            if __t(x0 > -80 and x0 < 490) then
                c:save()
                c:beginPath()
                c:rect(x0, 62, 72, 52)
                c:clip()
                local fl = if math.sin(t * 14) > 0 then 1 else 0
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x0 + 22 + k * 4,
                            99 - if __t(__mod(fl + k, 2)) then 3 else 2,
                            2,
                            3,
                            if __t(__mod(k, 2)) then "#ffb040" else "#ff7a2a"
                        )
                        k = k + 1
                    end
                end
                local u = math.sin(t * 0.45) * 0.5 + 0.5
                local px = math.floor(x0 + 10 + u * 52 + 0.5)
                local b = math.floor(math.abs(math.sin(t * 4)) + 0.5)
                R(
                    nil,
                    c,
                    px - 4,
                    92 + b,
                    9,
                    22,
                    "#f2f2ec"
                )
                R(
                    nil,
                    c,
                    px - 4,
                    96 + b,
                    9,
                    1,
                    "#d8d8d0"
                )
                R(
                    nil,
                    c,
                    px - 3,
                    84 + b,
                    7,
                    8,
                    "#c48a62"
                )
                R(
                    nil,
                    c,
                    px - 4,
                    78 + b,
                    9,
                    6,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    px - 3,
                    76 + b,
                    7,
                    2,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    px - 4,
                    83 + b,
                    9,
                    1,
                    "#e8433a"
                )
                R(
                    nil,
                    c,
                    px - 1,
                    87 + b,
                    1,
                    1,
                    "#2a1d16"
                )
                R(
                    nil,
                    c,
                    px + 2,
                    87 + b,
                    1,
                    1,
                    "#2a1d16"
                )
                R(
                    nil,
                    c,
                    px - 2,
                    90 + b,
                    5,
                    1,
                    "#2a1d16"
                )
                local vira = __mod(t, 3) < 0.5
                R(
                    nil,
                    c,
                    px + 5,
                    95 + b,
                    6,
                    1,
                    "#9aa0a6"
                )
                if __t(vira) then
                    R(
                        nil,
                        c,
                        px + 7,
                        math.floor(90 - math.sin(__mod(t, 3) / 0.5 * math.pi) * 6 + 0.5),
                        5,
                        2,
                        "#e8b860"
                    )
                end
                do
                    local k = 0
                    while k < 4 do
                        local v = __mod(t * 0.4 + k / 4, 1)
                        c.globalAlpha = (1 - v) * 0.45
                        R(
                            nil,
                            c,
                            x0 + 26 + k * 6 + math.sin(t * 2 + k) * 3,
                            96 - v * 30,
                            3,
                            2,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
                c:restore()
                brilho(
                    nil,
                    c,
                    x0 + 32,
                    99,
                    16,
                    "#ff9a40",
                    0.22 + fl * 0.05
                )
            end
        end
        do
            local x = 712 - camL
            if __t(x > -12 and x < 494) then
                local a = math.floor(t) / 60 * math.pi * 2 - math.pi / 2
                linha(
                    nil,
                    c,
                    x,
                    54,
                    x + math.cos(a) * 6,
                    54 + math.sin(a) * 6,
                    "#c43c3a"
                )
            end
        end
        do
            local vx = 880 - camL
            if __t(vx > -40 and vx < 520) then
                R(
                    nil,
                    c,
                    vx,
                    28,
                    2,
                    12,
                    "#3a3e44"
                )
                R(
                    nil,
                    c,
                    vx - 4,
                    39,
                    10,
                    3,
                    "#5a3820"
                )
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 6 + k * math.pi / 2
                        R(
                            nil,
                            c,
                            vx + 1 + math.cos(a) * 16 - 2,
                            40 + math.sin(a) * 2,
                            5,
                            2,
                            "#7a4a2a"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = 976 - camL
            local y = 112
            if __t(x > -20 and x < 500) then
                local osc = math.sin(t * 0.8) * 0.6
                local cx = math.cos(osc)
                oval(
                    nil,
                    c,
                    x,
                    y,
                    7 * cx + 1,
                    7,
                    "#7a8086"
                )
                do
                    local k = 0
                    while k < 3 do
                        local a = t * 18 + k * 2.09
                        R(
                            nil,
                            c,
                            x + math.cos(a) * 4 * cx - 1,
                            y + math.sin(a) * 4 - 1,
                            3,
                            3,
                            "#c8ccd0"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    2,
                    2,
                    "#3a3e44"
                )
            end
        end
    end
    local function oficinaProps(self, c, W)
        for ____, x0 in __iterar((__arrL({92, 492, 892}, 3))) do
            R(
                nil,
                c,
                x0,
                1,
                100,
                22,
                "#a8a47e"
            )
            do
                local x = x0
                while x < x0 + 100 do
                    R(
                        nil,
                        c,
                        x + 1,
                        1,
                        2,
                        22,
                        "#d0cca0"
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        1,
                        1,
                        22,
                        "#7a7658"
                    )
                    x = x + 5
                end
            end
            do
                local i = 0
                while i < 26 do
                    R(
                        nil,
                        c,
                        x0 + hash(nil, i + x0) * 97,
                        2 + hash(nil, i * 3 + x0) * 19,
                        1 + __mod(i, 3),
                        1,
                        if __t(__mod(i, 4)) then "rgba(70,60,30,.45)" else "#6a5a2a"
                    )
                    i = i + 1
                end
            end
        end
        local tc, tx = table.unpack(
            mk(nil, 12, 20),
            1,
            2
        )
        do
            local k = 0
            while k < 7 do
                R(
                    nil,
                    tx,
                    k,
                    17 - k * 3,
                    1,
                    3,
                    "#3a4250"
                )
                R(
                    nil,
                    tx,
                    11 - k,
                    17 - k * 3,
                    1,
                    3,
                    "#3a4250"
                )
                k = k + 1
            end
        end
        R(
            nil,
            tx,
            0,
            18,
            12,
            2,
            "#2a303a"
        )
        R(
            nil,
            tx,
            0,
            0,
            12,
            2,
            "#3a4250"
        )
        R(
            nil,
            tx,
            0,
            0,
            12,
            1,
            "#56606e"
        )
        ladrilhar(
            nil,
            c,
            tc,
            0,
            4,
            W,
            24
        )
        for ____, x in __iterar((__arrL({300, 560, 820, 1080}, 4))) do
            do
                local i = 0
                while i < 40 do
                    R(
                        nil,
                        c,
                        x + hash(nil, i + x) * 60,
                        42 + hash(nil, i * 2 + x) * 26,
                        1,
                        1,
                        "rgba(60,70,60,.35)"
                    )
                    i = i + 1
                end
            end
            do
                local y = 61
                while y < 68 do
                    do
                        local xx = x + __mod(y, 2)
                        while xx < x + 60 do
                            R(
                                nil,
                                c,
                                xx,
                                y,
                                1,
                                1,
                                "rgba(70,64,50,.28)"
                            )
                            xx = xx + 2
                        end
                    end
                    y = y + 1
                end
            end
        end
        linha(
            nil,
            c,
            836,
            44,
            842,
            50,
            "rgba(230,240,250,.8)"
        )
        linha(
            nil,
            c,
            842,
            50,
            839,
            53,
            "rgba(230,240,250,.8)"
        )
        linha(
            nil,
            c,
            842,
            50,
            846,
            48,
            "rgba(230,240,250,.8)"
        )
        linha(
            nil,
            c,
            1096,
            56,
            1108,
            67,
            "#c8b88a"
        )
        linha(
            nil,
            c,
            1096,
            67,
            1108,
            56,
            "#c8b88a"
        )
        disco(
            nil,
            c,
            470,
            52,
            6,
            "#c43c3a"
        )
        disco(
            nil,
            c,
            470,
            52,
            4,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            466,
            52,
            6,
            2,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            472,
            52,
            2,
            2,
            "#e8843a"
        )
        linha(
            nil,
            c,
            466,
            48,
            474,
            56,
            "#c43c3a"
        )
        linha(
            nil,
            c,
            467,
            48,
            475,
            56,
            "#c43c3a"
        )
        disco(
            nil,
            c,
            490,
            52,
            6,
            "#2c5a9e"
        )
        disco(
            nil,
            c,
            490,
            52,
            3,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            487,
            52,
            7,
            3,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            486,
            52,
            9,
            1,
            "#f2f2ee"
        )
        disco(
            nil,
            c,
            1020,
            54,
            11,
            "#3a444e"
        )
        disco(
            nil,
            c,
            1020,
            54,
            9,
            "#0e1218"
        )
        oval(
            nil,
            c,
            1020,
            54,
            10,
            10,
            "#5a646e"
        )
        do
            local k = -8
            while k <= 8 do
                R(
                    nil,
                    c,
                    1012,
                    54 + k,
                    17,
                    1,
                    "rgba(90,100,110,.5)"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            590,
            76,
            580,
            2,
            "#3a6aa8"
        )
        R(
            nil,
            c,
            590,
            76,
            580,
            1,
            "#6a9ad8"
        )
        for ____, x in __iterar((__arrL({640, 1000, 1150}, 3))) do
            R(
                nil,
                c,
                x,
                78,
                2,
                16,
                "#3a6aa8"
            )
            R(
                nil,
                c,
                x - 1,
                94,
                4,
                3,
                "#c8a030"
            )
            R(
                nil,
                c,
                x,
                97,
                2,
                2,
                "#6a7078"
            )
        end
        do
            local wx = 848
            local wy = 34
            do
                local k = 0
                while k < 5 do
                    local a = k / 4 * math.pi / 2
                    linha(
                        nil,
                        c,
                        wx,
                        wy,
                        wx + math.cos(a) * 16,
                        wy + math.sin(a) * 16,
                        "rgba(220,220,230,.3)"
                    )
                    k = k + 1
                end
            end
            for ____, r in __iterar((__arrL({5, 9, 13}, 3))) do
                do
                    local k = 0
                    while k <= 8 do
                        local a = k / 8 * math.pi / 2
                        R(
                            nil,
                            c,
                            wx + math.cos(a) * r,
                            wy + math.sin(a) * r,
                            1,
                            1,
                            "rgba(220,220,230,.35)"
                        )
                        k = k + 1
                    end
                end
            end
        end
        R(
            nil,
            c,
            128,
            94,
            28,
            36,
            "#3a444e"
        )
        R(
            nil,
            c,
            129,
            95,
            26,
            34,
            "#6a7480"
        )
        R(
            nil,
            c,
            129,
            95,
            26,
            1,
            "#9aa4ae"
        )
        R(
            nil,
            c,
            129,
            128,
            26,
            1,
            "#4a545e"
        )
        R(
            nil,
            c,
            151,
            106,
            2,
            7,
            "#2a3038"
        )
        R(
            nil,
            c,
            140,
            85,
            3,
            9,
            "#5a646e"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    142 - k,
                    99 + k * 2,
                    1 + k * 2,
                    2,
                    "#e8c24a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            142,
            102,
            1,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            141,
            105,
            2,
            1,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            141,
            106,
            1,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            133,
            115,
            18,
            9,
            "#2a3038"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    134 + k * 3,
                    116,
                    2,
                    6,
                    if k == 3 then "#c43c3a" else "#e8e2d0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            138,
            211,
            30,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            138,
            211,
            30,
            1,
            "#e86a5a"
        )
        R(
            nil,
            c,
            162,
            205,
            7,
            6,
            "#a82a2a"
        )
        R(
            nil,
            c,
            160,
            203,
            10,
            2,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            140,
            215,
            20,
            1,
            "#7a1a1a"
        )
        disco(
            nil,
            c,
            142,
            218,
            2,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            164,
            218,
            2,
            "#1c1c1c"
        )
        linha(
            nil,
            c,
            138,
            212,
            128,
            190,
            "#9aa0a6"
        )
        linha(
            nil,
            c,
            139,
            212,
            129,
            190,
            "#6a7078"
        )
        R(
            nil,
            c,
            126,
            187,
            4,
            4,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            426,
            102,
            10,
            3,
            "#4a545e"
        )
        disco(
            nil,
            c,
            431,
            114,
            9,
            "#3a3e44"
        )
        do
            local r = 8
            while r > 2 do
                oval(
                    nil,
                    c,
                    431,
                    114,
                    r,
                    r,
                    if __t(__mod(r, 4)) then "#e8c24a" else "#c8a030"
                )
                r = r - 2
            end
        end
        disco(
            nil,
            c,
            431,
            114,
            2,
            "#9aa0a6"
        )
        linha(
            nil,
            c,
            439,
            118,
            441,
            140,
            "#e8c24a"
        )
        R(
            nil,
            c,
            440,
            140,
            3,
            3,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            424,
            148,
            12,
            10,
            "#c43c3a"
        )
        R(
            nil,
            c,
            426,
            150,
            8,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            429,
            151,
            2,
            4,
            "#c43c3a"
        )
        R(
            nil,
            c,
            425,
            164,
            9,
            20,
            "#c43c3a"
        )
        R(
            nil,
            c,
            426,
            164,
            2,
            20,
            "#e86a5a"
        )
        R(
            nil,
            c,
            426,
            160,
            6,
            4,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            428,
            158,
            6,
            2,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            433,
            161,
            2,
            11,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            425,
            172,
            9,
            3,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            424,
            184,
            11,
            2,
            "#3a3e44"
        )
        R(
            nil,
            c,
            516,
            132,
            46,
            3,
            "#7a5232"
        )
        R(
            nil,
            c,
            516,
            132,
            46,
            1,
            "#9a7248"
        )
        R(
            nil,
            c,
            519,
            135,
            2,
            5,
            "#3a3e44"
        )
        R(
            nil,
            c,
            557,
            135,
            2,
            5,
            "#3a3e44"
        )
        do
            local x = 517
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({"#3a6aa8", 9}, 2),
                    __arrL({"#c43c3a", 9}, 2),
                    __arrL({"#e8c24a", 7}, 2)
                },
                3
            ))) do
                local cor = ____value[1]
                local h = ____value[2]
                R(
                    nil,
                    c,
                    x,
                    132 - h,
                    9,
                    h,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    x,
                    134 - h,
                    9,
                    h - 4,
                    cor
                )
                R(
                    nil,
                    c,
                    x,
                    132 - h,
                    9,
                    1,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    134 - h,
                    1,
                    h - 4,
                    "rgba(255,255,255,.35)"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    131 - h,
                    5,
                    1,
                    "#6a7078"
                )
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            x + 2 + k * 2,
                            132 - h,
                            1,
                            2 + k,
                            cor
                        )
                        k = k + 1
                    end
                end
                x = x + 10
            end
            do
                local k = 0
                while k < 2 do
                    local sx = 549 + k * 6
                    R(
                        nil,
                        c,
                        sx,
                        121,
                        4,
                        11,
                        __get(
                            __arrL({"#3a8a5a", "#1c1c1c"}, 2),
                            k
                        )
                    )
                    R(
                        nil,
                        c,
                        sx + 1,
                        119,
                        2,
                        2,
                        "#c8ccd0"
                    )
                    R(
                        nil,
                        c,
                        sx,
                        124,
                        4,
                        2,
                        "#f2f2ee"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            590,
            108,
            80,
            2,
            "#5a646e"
        )
        R(
            nil,
            c,
            590,
            108,
            80,
            1,
            "#8a949e"
        )
        do
            local x = 596
            while x < 668 do
                R(
                    nil,
                    c,
                    x,
                    110,
                    1,
                    3,
                    "#9aa0a6"
                )
                x = x + 14
            end
        end
        oval(
            nil,
            c,
            597,
            125,
            3,
            12,
            "#1c1c1c"
        )
        oval(
            nil,
            c,
            607,
            127,
            4,
            14,
            "#2a2a2a"
        )
        oval(
            nil,
            c,
            608,
            127,
            3,
            13,
            "#141414"
        )
        do
            local r = 8
            while r > 2 do
                oval(
                    nil,
                    c,
                    628,
                    124,
                    r,
                    r * 0.9,
                    if __t(__mod(r, 4)) then "#e8c24a" else "#b8922a"
                )
                r = r - 2
            end
        end
        linha(
            nil,
            c,
            628,
            132,
            631,
            156,
            "#e8c24a"
        )
        R(
            nil,
            c,
            630,
            156,
            3,
            3,
            "#9aa0a6"
        )
        oval(
            nil,
            c,
            652,
            124,
            6,
            10,
            "#e8843a"
        )
        oval(
            nil,
            c,
            653,
            125,
            5,
            9,
            "#c8642a"
        )
        R(
            nil,
            c,
            650,
            134,
            5,
            6,
            "#e8843a"
        )
        R(
            nil,
            c,
            650,
            140,
            5,
            3,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            651,
            143,
            1,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            653,
            143,
            1,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            754,
            217,
            32,
            3,
            "#1c1e24"
        )
        R(
            nil,
            c,
            758,
            217,
            12,
            1,
            "rgba(150,110,190,.5)"
        )
        R(
            nil,
            c,
            768,
            196,
            5,
            18,
            "#3a6aa8"
        )
        R(
            nil,
            c,
            752,
            213,
            40,
            3,
            "#3a6aa8"
        )
        R(
            nil,
            c,
            752,
            213,
            40,
            1,
            "#6a9ad8"
        )
        disco(
            nil,
            c,
            754,
            218,
            2,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            790,
            218,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            764,
            192,
            14,
            5,
            "#2a4a7a"
        )
        R(
            nil,
            c,
            748,
            174,
            30,
            20,
            "#6a7078"
        )
        R(
            nil,
            c,
            748,
            174,
            30,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            748,
            192,
            30,
            2,
            "#4a5058"
        )
        R(
            nil,
            c,
            750,
            168,
            26,
            7,
            "#c43c3a"
        )
        R(
            nil,
            c,
            750,
            168,
            26,
            1,
            "#e86a5a"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    753 + k * 6,
                    170,
                    2,
                    2,
                    "#e8e2d0"
                )
                k = k + 1
            end
        end
        disco(
            nil,
            c,
            744,
            186,
            6,
            "#3a3e44"
        )
        disco(
            nil,
            c,
            744,
            186,
            4,
            "#7a8086"
        )
        disco(
            nil,
            c,
            744,
            186,
            1,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            746,
            176,
            3,
            "#3a3e44"
        )
        disco(
            nil,
            c,
            746,
            176,
            1,
            "#9aa0a6"
        )
        linha(
            nil,
            c,
            739,
            184,
            743,
            174,
            "#1c1c1c"
        )
        linha(
            nil,
            c,
            749,
            184,
            749,
            176,
            "#1c1c1c"
        )
        for ____, y in __iterar((__arrL({176, 182, 188}, 3))) do
            R(
                nil,
                c,
                778,
                y,
                8,
                3,
                "#8a5a3a"
            )
            R(
                nil,
                c,
                778,
                y,
                8,
                1,
                "#b8784a"
            )
        end
        do
            local k = 0
            while k < 14 do
                R(
                    nil,
                    c,
                    749 + hash(nil, k + 70) * 28,
                    176 + hash(nil, k + 71) * 16,
                    1,
                    1,
                    if __t(__mod(k, 2)) then "#4a5058" else "#8a9096"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            806,
            186,
            38,
            30,
            "#c43c3a"
        )
        R(
            nil,
            c,
            806,
            186,
            38,
            2,
            "#e86a5a"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    808,
                    190 + k * 5,
                    34,
                    4,
                    "#a82a2a"
                )
                R(
                    nil,
                    c,
                    820,
                    191 + k * 5,
                    10,
                    1,
                    "#c8ccd0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            844,
            184,
            2,
            14,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            844,
            184,
            6,
            2,
            "#9aa0a6"
        )
        disco(
            nil,
            c,
            810,
            218,
            2,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            840,
            218,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            810,
            182,
            14,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            822,
            179,
            3,
            4,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            830,
            177,
            4,
            9,
            "#3a8a5a"
        )
        R(
            nil,
            c,
            831,
            175,
            2,
            2,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            836,
            182,
            7,
            4,
            "#c8b8a0"
        )
        R(
            nil,
            c,
            837,
            181,
            4,
            1,
            "#e8dcc0"
        )
        R(
            nil,
            c,
            862,
            196,
            26,
            20,
            "#2f6a9a"
        )
        R(
            nil,
            c,
            862,
            196,
            26,
            2,
            "#5a9ac8"
        )
        R(
            nil,
            c,
            866,
            200,
            8,
            6,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            867,
            201,
            3,
            2,
            "#e8843a"
        )
        disco(
            nil,
            c,
            880,
            203,
            3,
            "#c8ccd0"
        )
        disco(
            nil,
            c,
            880,
            203,
            1,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            866,
            210,
            18,
            2,
            "#24486a"
        )
        disco(
            nil,
            c,
            866,
            218,
            2,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            884,
            218,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            860,
            190,
            2,
            8,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            860,
            190,
            10,
            2,
            "#9aa0a6"
        )
        oval(
            nil,
            c,
            894,
            208,
            5,
            6,
            "#1c1c1c"
        )
        oval(
            nil,
            c,
            895,
            209,
            4,
            5,
            "#c43c3a"
        )
        linha(
            nil,
            c,
            888,
            204,
            890,
            210,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            903,
            150,
            1,
            4,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            898,
            154,
            12,
            14,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            899,
            155,
            10,
            1,
            "#4a4a4a"
        )
        R(
            nil,
            c,
            900,
            159,
            8,
            3,
            "#3a6a3a"
        )
        R(
            nil,
            c,
            901,
            159,
            3,
            1,
            "#7ac87a"
        )
        R(
            nil,
            c,
            912,
            172,
            10,
            48,
            "#2f7a4a"
        )
        R(
            nil,
            c,
            912,
            172,
            10,
            2,
            "#5aa86a"
        )
        R(
            nil,
            c,
            913,
            174,
            2,
            46,
            "rgba(255,255,255,.18)"
        )
        R(
            nil,
            c,
            914,
            166,
            6,
            6,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            916,
            162,
            2,
            4,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            911,
            196,
            12,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            913,
            184,
            8,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            926,
            196,
            18,
            24,
            "#3a5a3a"
        )
        R(
            nil,
            c,
            926,
            196,
            18,
            2,
            "#5a7a5a"
        )
        R(
            nil,
            c,
            926,
            202,
            18,
            1,
            "#2a3a2a"
        )
        R(
            nil,
            c,
            926,
            212,
            18,
            1,
            "#2a3a2a"
        )
        R(
            nil,
            c,
            928,
            192,
            6,
            4,
            "#c8b8a0"
        )
        R(
            nil,
            c,
            934,
            191,
            5,
            5,
            "#c43c3a"
        )
        R(
            nil,
            c,
            938,
            193,
            4,
            3,
            "#e8e2d0"
        )
        linha(
            nil,
            c,
            966,
            168,
            970,
            210,
            "#a8784a"
        )
        do
            local k = 0
            while k < 7 do
                linha(
                    nil,
                    c,
                    967 + k,
                    210,
                    964 + k * 2,
                    220,
                    "#c8a83a"
                )
                k = k + 1
            end
        end
        disco(
            nil,
            c,
            1056,
            112,
            9,
            "#3a3e44"
        )
        disco(
            nil,
            c,
            1056,
            112,
            8,
            "#f2f2ee"
        )
        do
            local k = 0
            while k < 12 do
                local a = k / 12 * math.pi * 2
                R(
                    nil,
                    c,
                    1056 + math.cos(a) * 6,
                    112 + math.sin(a) * 6,
                    1,
                    1,
                    "#3a3e44"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1056,
            107,
            1,
            5,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            1056,
            112,
            4,
            1,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            1072,
            100,
            28,
            22,
            "#5a3a22"
        )
        R(
            nil,
            c,
            1074,
            102,
            24,
            18,
            "#8ac8e0"
        )
        R(
            nil,
            c,
            1074,
            113,
            24,
            7,
            "#5a9a4a"
        )
        R(
            nil,
            c,
            1077,
            108,
            15,
            6,
            "#24467a"
        )
        R(
            nil,
            c,
            1080,
            106,
            8,
            3,
            "#9ac8e0"
        )
        disco(
            nil,
            c,
            1080,
            114,
            2,
            "#141414"
        )
        disco(
            nil,
            c,
            1089,
            114,
            2,
            "#141414"
        )
        R(
            nil,
            c,
            1094,
            105,
            2,
            3,
            "#c48a62"
        )
        R(
            nil,
            c,
            1093,
            108,
            4,
            5,
            "#c0443c"
        )
        R(
            nil,
            c,
            1104,
            134,
            22,
            2,
            "#5a3a22"
        )
        R(
            nil,
            c,
            1106,
            122,
            6,
            12,
            "#c43c3a"
        )
        R(
            nil,
            c,
            1107,
            120,
            4,
            2,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1106,
            126,
            6,
            1,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1114,
            129,
            4,
            5,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1118,
            130,
            1,
            2,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1120,
            129,
            4,
            5,
            "#e8c24a"
        )
        R(
            nil,
            c,
            1088,
            179,
            14,
            6,
            "#e8e2d0"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    1090,
                    180 + k * 2,
                    10,
                    1,
                    "#9a948a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1050,
            180,
            10,
            8,
            "#c8844a"
        )
        R(
            nil,
            c,
            1051,
            181,
            8,
            1,
            "#e8a46a"
        )
        for ____, x in __iterar((__arrL({1180, 1204}, 2))) do
            R(
                nil,
                c,
                x,
                92,
                3,
                128,
                "#d8843a"
            )
            do
                local y = 96
                while y < 218 do
                    R(
                        nil,
                        c,
                        x + 1,
                        y,
                        1,
                        2,
                        "#7a3a10"
                    )
                    y = y + 5
                end
            end
        end
        for ____, y in __iterar((__arrL({124, 158, 192}, 3))) do
            R(
                nil,
                c,
                1180,
                y,
                28,
                3,
                "#3a6aa8"
            )
            R(
                nil,
                c,
                1180,
                y,
                28,
                1,
                "#6a9ad8"
            )
        end
        do
            local j = 0
            while j < 3 do
                R(
                    nil,
                    c,
                    1183,
                    118 - j * 6,
                    22,
                    5,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    1183,
                    118 - j * 6,
                    22,
                    1,
                    "#3a3a3a"
                )
                R(
                    nil,
                    c,
                    1192,
                    119 - j * 6,
                    4,
                    2,
                    "#0a0a0a"
                )
                j = j + 1
            end
        end
        R(
            nil,
            c,
            1183,
            142,
            11,
            16,
            "#b8905a"
        )
        R(
            nil,
            c,
            1183,
            142,
            11,
            1,
            "#d8b07a"
        )
        R(
            nil,
            c,
            1185,
            147,
            6,
            3,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1195,
            146,
            10,
            12,
            "#a8804a"
        )
        R(
            nil,
            c,
            1195,
            146,
            10,
            1,
            "#c8a06a"
        )
        R(
            nil,
            c,
            1199,
            146,
            2,
            12,
            "#d8c08a"
        )
        R(
            nil,
            c,
            1183,
            180,
            12,
            12,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            1184,
            178,
            2,
            2,
            "#c43c3a"
        )
        R(
            nil,
            c,
            1192,
            178,
            2,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            1183,
            184,
            12,
            2,
            "#e8c24a"
        )
        R(
            nil,
            c,
            1197,
            178,
            7,
            14,
            "#e8c24a"
        )
        R(
            nil,
            c,
            1198,
            175,
            3,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            1183,
            206,
            22,
            14,
            "#4a4e54"
        )
        disco(
            nil,
            c,
            1193,
            213,
            5,
            "#9aa0a6"
        )
        disco(
            nil,
            c,
            1193,
            213,
            2,
            "#3a3e44"
        )
        R(
            nil,
            c,
            1180,
            74,
            22,
            11,
            "#1c6a3a"
        )
        R(
            nil,
            c,
            1181,
            75,
            20,
            9,
            "#2a9a5a"
        )
        disco(
            nil,
            c,
            1186,
            77,
            1,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1185,
            79,
            2,
            3,
            "#f2f2ee"
        )
        linha(
            nil,
            c,
            1190,
            80,
            1198,
            80,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1196,
            78,
            1,
            5,
            "#f2f2ee"
        )
    end
    local function oficinaFora(self, c, t, camL, n)
        local sx = -math.floor(camL + 0.5)
        if sx < -80 then
            return
        end
        local noite = __gt(n, 0.5)
        local g = c:createLinearGradient(0, 84, 0, 186)
        g:addColorStop(0, if __t(noite) then "#0e1430" else "#7ab8e8")
        g:addColorStop(1, if __t(noite) then "#2a2a4a" else "#d8ecf8")
        c.fillStyle = g
        c:fillRect(sx, 84, 76, 102)
        if __t(noite) then
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        sx + hash(nil, k + 9) * 72,
                        86 + hash(nil, k + 4) * 40,
                        1,
                        1,
                        "#ffffff"
                    )
                    k = k + 1
                end
            end
        end
        do
            local x = 0
            while x < 76 do
                local h = math.floor(150 - math.sin(x * 0.06 + 1) * 8 - math.sin(x * 0.17) * 3 + 0.5)
                R(
                    nil,
                    c,
                    sx + x,
                    h,
                    1,
                    186 - h,
                    if __t(noite) then "#16222a" else if __t(__mod(x, 2)) then "#7aaa5a" else "#6a9a4e"
                )
                R(
                    nil,
                    c,
                    sx + x,
                    h,
                    1,
                    1,
                    if __t(noite) then "#22323a" else "#9ac878"
                )
                x = x + 1
            end
        end
        R(
            nil,
            c,
            sx + 30,
            144,
            34,
            36,
            if __t(noite) then "#2a2638" else "#e8c8a0"
        )
        R(
            nil,
            c,
            sx + 28,
            140,
            38,
            5,
            if __t(noite) then "#221c30" else "#b8543a"
        )
        do
            local x = 28
            while x < 66 do
                R(
                    nil,
                    c,
                    sx + x,
                    140,
                    1,
                    5,
                    if __t(noite) then "#1a1628" else "#983a2a"
                )
                x = x + 3
            end
        end
        R(
            nil,
            c,
            sx + 36,
            152,
            8,
            8,
            if __t(noite) then "#ffd27a" else "#5a7a9a"
        )
        R(
            nil,
            c,
            sx + 39,
            152,
            1,
            8,
            if __t(noite) then "#c89a4a" else "#e8c8a0"
        )
        R(
            nil,
            c,
            sx + 50,
            158,
            8,
            22,
            if __t(noite) then "#1a1418" else "#8a5a3a"
        )
        R(
            nil,
            c,
            sx + 56,
            168,
            1,
            2,
            "#e8c24a"
        )
        if __t(noite) then
            brilho(
                nil,
                c,
                sx + 40,
                156,
                14,
                "#ffb050",
                0.5
            )
        end
        R(
            nil,
            c,
            sx + 12,
            140,
            4,
            46,
            if __t(noite) then "#120e0c" else "#5a3a22"
        )
        disco(
            nil,
            c,
            sx + 14,
            132,
            14,
            if __t(noite) then "#0c1612" else "#2f7a3a"
        )
        disco(
            nil,
            c,
            sx + 10,
            127,
            9,
            if __t(noite) then "#101c16" else "#4a9a46"
        )
        disco(
            nil,
            c,
            sx + 8,
            124,
            4,
            if __t(noite) then "#14241c" else "#7ac05a"
        )
        if not __t(noite) then
            do
                local k = 0
                while k < 4 do
                    R(
                        nil,
                        c,
                        sx + 6 + hash(nil, k) * 16,
                        128 + hash(nil, k + 2) * 12,
                        2,
                        2,
                        "#f2a83a"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            sx,
            180,
            76,
            40,
            if __t(noite) then "#26221c" else "#b8a078"
        )
        R(
            nil,
            c,
            sx,
            180,
            76,
            2,
            if __t(noite) then "#34302a" else "#d8c8a0"
        )
        do
            local k = 0
            while k < 24 do
                R(
                    nil,
                    c,
                    sx + hash(nil, k + 50) * 74,
                    184 + hash(nil, k + 51) * 34,
                    2,
                    1,
                    if __t(noite) then "#1a1612" else "#9a8460"
                )
                k = k + 1
            end
        end
        if not __t(noite) then
            local gx = sx + 30 + math.sin(t * 0.4) * 16
            local bica = if math.sin(t * 5) > 0.5 then 2 else 0
            local dir = if math.cos(t * 0.4) > 0 then 1 else -1
            R(
                nil,
                c,
                gx - 3,
                200,
                7,
                5,
                "#f2f2ec"
            )
            R(
                nil,
                c,
                gx - 3 - dir * 2,
                198,
                3,
                4,
                "#f2f2ec"
            )
            R(
                nil,
                c,
                gx + dir * 4,
                197 + bica,
                3,
                3,
                "#f2f2ec"
            )
            R(
                nil,
                c,
                gx + dir * 4 + 1,
                195 + bica,
                1,
                2,
                "#c43c3a"
            )
            R(
                nil,
                c,
                gx + dir * 6,
                198 + bica,
                1,
                1,
                "#e8a020"
            )
            R(
                nil,
                c,
                gx - 1,
                205,
                1,
                3,
                "#e8a020"
            )
            R(
                nil,
                c,
                gx + 1,
                205,
                1,
                3,
                "#e8a020"
            )
        end
    end
    local function lancheProps(self, c, W, PORTA)
        R(
            nil,
            c,
            510,
            60,
            76,
            58,
            "#6a4228"
        )
        R(
            nil,
            c,
            510,
            60,
            76,
            2,
            "#8a5a36"
        )
        R(
            nil,
            c,
            512,
            62,
            72,
            52,
            "#3a3a36"
        )
        do
            local y = 62
            while y < 100 do
                do
                    local x = 512
                    while x < 584 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            4,
                            4,
                            "#a8c8b8"
                        )
                        x = x + 5
                    end
                end
                y = y + 5
            end
        end
        R(
            nil,
            c,
            522,
            62,
            40,
            9,
            "#8a9096"
        )
        R(
            nil,
            c,
            522,
            62,
            40,
            1,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            526,
            71,
            32,
            3,
            "#6a7076"
        )
        do
            local k = 0
            while k < 4 do
                local px = 515 + k * 6
                R(
                    nil,
                    c,
                    px + 2,
                    76,
                    1,
                    4,
                    "#3a3a3a"
                )
                disco(
                    nil,
                    c,
                    px + 2,
                    83,
                    2,
                    __get(
                        __arrL({"#9aa0a6", "#c8843a", "#9aa0a6", "#3a3e44"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            562,
            82,
            20,
            2,
            "#5a3820"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    563 + k * 5,
                    76,
                    4,
                    6,
                    __get(
                        __arrL({"#f2c94c", "#c43c3a", "#f2f2ee", "#8a5a3a"}, 4),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    563 + k * 5,
                    75,
                    4,
                    1,
                    "#c8ccd0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            512,
            100,
            72,
            14,
            "#7a8086"
        )
        R(
            nil,
            c,
            512,
            100,
            72,
            2,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            532,
            102,
            26,
            2,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            508,
            114,
            80,
            4,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            508,
            114,
            80,
            1,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            518,
            112,
            14,
            2,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            520,
            109,
            9,
            3,
            "#e8b860"
        )
        R(
            nil,
            c,
            521,
            109,
            7,
            1,
            "#f2d090"
        )
        disco(
            nil,
            c,
            574,
            112,
            2,
            "#c8a030"
        )
        R(
            nil,
            c,
            574,
            109,
            1,
            1,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            598,
            46,
            74,
            14,
            "#5a3820"
        )
        R(
            nil,
            c,
            600,
            48,
            70,
            10,
            "#e8d8a8"
        )
        R(
            nil,
            c,
            604,
            44,
            1,
            3,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            666,
            44,
            1,
            3,
            "#3a3a3a"
        )
        disco(
            nil,
            c,
            712,
            54,
            9,
            "#5a3820"
        )
        disco(
            nil,
            c,
            712,
            54,
            8,
            "#f2f2ee"
        )
        do
            local k = 0
            while k < 12 do
                local a = k / 12 * math.pi * 2
                R(
                    nil,
                    c,
                    712 + math.cos(a) * 6,
                    54 + math.sin(a) * 6,
                    1,
                    1,
                    "#5a3820"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            712,
            49,
            1,
            5,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            712,
            54,
            4,
            1,
            "#1c1c1c"
        )
        for ____, y in __iterar((__arrL({78, 104}, 2))) do
            R(
                nil,
                c,
                596,
                y,
                108,
                3,
                "#7a4a2a"
            )
            R(
                nil,
                c,
                596,
                y,
                108,
                1,
                "#a86a3a"
            )
            R(
                nil,
                c,
                600,
                y + 3,
                2,
                5,
                "#3a2416"
            )
            R(
                nil,
                c,
                698,
                y + 3,
                2,
                5,
                "#3a2416"
            )
        end
        do
            local k = 0
            while k < 4 do
                local x = 598 + k * 5
                R(
                    nil,
                    c,
                    x,
                    69,
                    4,
                    9,
                    "#e8a020"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    66,
                    2,
                    3,
                    "#e8a020"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    65,
                    2,
                    1,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x,
                    72,
                    4,
                    2,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    70,
                    1,
                    6,
                    "rgba(255,255,255,.3)"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 3 do
                local x = 620 + k * 6
                R(
                    nil,
                    c,
                    x,
                    71,
                    5,
                    7,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x,
                    70,
                    5,
                    1,
                    "#3a8a4a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    73,
                    3,
                    2,
                    "#f2f2ee"
                )
                do
                    local j = 0
                    while j < 3 do
                        R(
                            nil,
                            c,
                            x + 1 + j,
                            76 - __mod(j, 2),
                            1,
                            1,
                            "#e86a5a"
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 2 do
                local x = 639 + k * 7
                R(
                    nil,
                    c,
                    x,
                    70,
                    6,
                    8,
                    "#c8945a"
                )
                R(
                    nil,
                    c,
                    x,
                    69,
                    6,
                    1,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    72,
                    4,
                    3,
                    "#f2e8cc"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            654,
            68,
            10,
            10,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            654,
            68,
            10,
            2,
            "#e8e2d0"
        )
        R(
            nil,
            c,
            656,
            72,
            6,
            3,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            658,
            66,
            2,
            2,
            "#c8b8a0"
        )
        do
            local k = 0
            while k < 2 do
                local x = 666 + k * 7
                R(
                    nil,
                    c,
                    x,
                    70,
                    6,
                    8,
                    if __t(k) then "#c43c3a" else "#e8c24a"
                )
                R(
                    nil,
                    c,
                    x,
                    70,
                    6,
                    1,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    73,
                    4,
                    2,
                    if __t(k) then "#f2c94c" else "#c43c3a"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 2 do
                local x = 682 + k * 7
                R(
                    nil,
                    c,
                    x,
                    66,
                    5,
                    12,
                    "#2f7a3a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    63,
                    3,
                    3,
                    "#2f7a3a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    62,
                    3,
                    1,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x,
                    70,
                    5,
                    3,
                    "#f2c94c"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    66,
                    1,
                    10,
                    "rgba(255,255,255,.3)"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 3 do
                local x = 600 + k * 12
                R(
                    nil,
                    c,
                    x,
                    94,
                    10,
                    10,
                    "rgba(210,235,245,.55)"
                )
                R(
                    nil,
                    c,
                    x,
                    93,
                    10,
                    1,
                    "#c8ccd0"
                )
                do
                    local j = 0
                    while j < 9 do
                        R(
                            nil,
                            c,
                            x + 1 + hash(nil, j + k * 9) * 8,
                            96 + hash(nil, j * 2 + k) * 7,
                            2,
                            1,
                            __get(
                                __arrL({
                                    "#e8433a",
                                    "#f2c94c",
                                    "#3c8a5a",
                                    "#3a6aa8",
                                    "#c84a8a"
                                }, 5),
                                __mod(j + k, 5)
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    640,
                    102 - k * 2,
                    14,
                    2,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    640,
                    103 - k * 2,
                    14,
                    1,
                    "#c8c8c0"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 3 do
                do
                    local j = 0
                    while j < 2 do
                        local x = 660 + k * 8
                        local y = 98 - j * 6
                        R(
                            nil,
                            c,
                            x,
                            y,
                            6,
                            6,
                            __get(
                                __arrL({"#f2f2ee", "#c43c3a", "#3a6aa8"}, 3),
                                __mod(k + j, 3)
                            )
                        )
                        R(
                            nil,
                            c,
                            x + 6,
                            y + 1,
                            1,
                            3,
                            "#c8c8c0"
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 12 do
                local x = 446 + k * 14
                R(
                    nil,
                    c,
                    x,
                    140,
                    9,
                    3,
                    "#e8b860"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    139,
                    7,
                    1,
                    "#f2d090"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    142,
                    1,
                    1,
                    "#b8843a"
                )
                R(
                    nil,
                    c,
                    x + 5,
                    142,
                    1,
                    1,
                    "#b8843a"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 8 do
                local x = 447 + k * 21
                R(
                    nil,
                    c,
                    x,
                    153,
                    6,
                    2,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    153,
                    3,
                    1,
                    "#c43c3a"
                )
                k = k + 1
            end
        end
        for ____, x in __iterar((__arrL({470, 540, 600}, 3))) do
            linha(
                nil,
                c,
                x,
                137,
                x - 8,
                155,
                "rgba(255,255,255,.45)"
            )
            linha(
                nil,
                c,
                x + 2,
                137,
                x - 6,
                155,
                "rgba(255,255,255,.25)"
            )
        end
        R(
            nil,
            c,
            726,
            140,
            7,
            18,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            727,
            142,
            5,
            10,
            "rgba(210,235,245,.6)"
        )
        R(
            nil,
            c,
            727,
            146,
            5,
            6,
            "#7a4a2a"
        )
        R(
            nil,
            c,
            726,
            138,
            7,
            2,
            "#3a3e44"
        )
        R(
            nil,
            c,
            727,
            152,
            5,
            6,
            "#5a5e64"
        )
        R(
            nil,
            c,
            426,
            214,
            308,
            6,
            "#8a9096"
        )
        R(
            nil,
            c,
            426,
            214,
            308,
            1,
            "#c8ccd0"
        )
        for ____, x in __iterar((__arrL({462, 532, 602, 672}, 4))) do
            R(
                nil,
                c,
                x - 1,
                194,
                3,
                22,
                "#c8ccd0"
            )
            R(
                nil,
                c,
                x,
                194,
                1,
                22,
                "#f2f2f2"
            )
            R(
                nil,
                c,
                x - 5,
                206,
                11,
                1,
                "#9aa0a6"
            )
            R(
                nil,
                c,
                x - 6,
                218,
                13,
                2,
                "#7a8086"
            )
            R(
                nil,
                c,
                x - 7,
                189,
                15,
                5,
                "#c43c3a"
            )
            R(
                nil,
                c,
                x - 7,
                189,
                15,
                1,
                "#e86a5a"
            )
            R(
                nil,
                c,
                x - 6,
                194,
                13,
                1,
                "#7a1a1a"
            )
        end
        __call(
            __arrL({176, 290, 846, 930}, 4),
            "forEach",
            function(____, x, i)
                R(
                    nil,
                    c,
                    x + 6,
                    178,
                    6,
                    6,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    179,
                    4,
                    4,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    177,
                    2,
                    7,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    176,
                    2,
                    1,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 17,
                    177,
                    2,
                    7,
                    "#e8c24a"
                )
                R(
                    nil,
                    c,
                    x + 17,
                    176,
                    2,
                    1,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 21,
                    180,
                    3,
                    4,
                    "#c8945a"
                )
                R(
                    nil,
                    c,
                    x + 21,
                    178,
                    1,
                    2,
                    "#e8d8a8"
                )
                R(
                    nil,
                    c,
                    x + 23,
                    178,
                    1,
                    2,
                    "#e8d8a8"
                )
                if __mod(i, 2) == 0 then
                    R(
                        nil,
                        c,
                        x + 32,
                        182,
                        14,
                        2,
                        "#f2f2ee"
                    )
                    R(
                        nil,
                        c,
                        x + 34,
                        179,
                        9,
                        3,
                        "#e8b860"
                    )
                    R(
                        nil,
                        c,
                        x + 35,
                        179,
                        7,
                        1,
                        "#f2d090"
                    )
                else
                    R(
                        nil,
                        c,
                        x + 36,
                        176,
                        5,
                        8,
                        "rgba(210,235,245,.6)"
                    )
                    R(
                        nil,
                        c,
                        x + 36,
                        179,
                        5,
                        5,
                        "#8a5a3a"
                    )
                    R(
                        nil,
                        c,
                        x + 39,
                        171,
                        1,
                        7,
                        "#c43c3a"
                    )
                end
            end
        )
        R(
            nil,
            c,
            780,
            90,
            8,
            10,
            "#1c1c24"
        )
        R(
            nil,
            c,
            782,
            93,
            4,
            7,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            781,
            87,
            6,
            4,
            "#1c1c24"
        )
        R(
            nil,
            c,
            782,
            88,
            1,
            1,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            785,
            88,
            1,
            1,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            783,
            90,
            2,
            1,
            "#e8a020"
        )
        R(
            nil,
            c,
            780,
            100,
            3,
            1,
            "#e8a020"
        )
        R(
            nil,
            c,
            785,
            100,
            3,
            1,
            "#e8a020"
        )
        for ____, x in __iterar((__arrL({167, 805}, 2))) do
            R(
                nil,
                c,
                x,
                28,
                1,
                12,
                "#3a3a3a"
            )
            R(
                nil,
                c,
                x - 5,
                40,
                11,
                6,
                "#b8643a"
            )
            R(
                nil,
                c,
                x - 5,
                40,
                11,
                1,
                "#d8844a"
            )
            do
                local f = 0
                while f < 7 do
                    local d = f - 3
                    do
                        local k = 0
                        while k < 14 do
                            R(
                                nil,
                                c,
                                x + d * k * 0.22 + if d > 0 then 2 else if d < 0 then -2 else 0,
                                42 + k * (0.9 + math.abs(d) * 0.1) + k * k * 0.03,
                                1,
                                2,
                                if __t(__mod(k, 3)) then "#3a8a3a" else "#5aaa4a"
                            )
                            k = k + 1
                        end
                    end
                    f = f + 1
                end
            end
        end
        R(
            nil,
            c,
            371,
            136,
            12,
            10,
            "#c43c3a"
        )
        R(
            nil,
            c,
            373,
            138,
            8,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            376,
            139,
            2,
            4,
            "#c43c3a"
        )
        R(
            nil,
            c,
            372,
            154,
            9,
            20,
            "#c43c3a"
        )
        R(
            nil,
            c,
            373,
            154,
            2,
            20,
            "#e86a5a"
        )
        R(
            nil,
            c,
            373,
            150,
            6,
            4,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            380,
            151,
            2,
            11,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            372,
            162,
            9,
            3,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            912,
            44,
            38,
            44,
            "#3a2416"
        )
        R(
            nil,
            c,
            914,
            46,
            34,
            40,
            "#e8e2d0"
        )
        R(
            nil,
            c,
            920,
            54,
            22,
            26,
            "#2c5a9e"
        )
        do
            local x = 922
            while x < 942 do
                R(
                    nil,
                    c,
                    x,
                    54,
                    2,
                    26,
                    "#f2f2ee"
                )
                x = x + 4
            end
        end
        R(
            nil,
            c,
            916,
            54,
            4,
            8,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            942,
            54,
            4,
            8,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            928,
            54,
            6,
            2,
            "#e8e2d0"
        )
        R(
            nil,
            c,
            927,
            60,
            2,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            931,
            60,
            3,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            932,
            61,
            1,
            4,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            958,
            40,
            44,
            56,
            "#6a4228"
        )
        R(
            nil,
            c,
            960,
            42,
            40,
            52,
            "#c8945a"
        )
        do
            local i = 0
            while i < 80 do
                R(
                    nil,
                    c,
                    960 + hash(nil, i + 300) * 39,
                    42 + hash(nil, i + 301) * 51,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "#a8743a" else "#d8a46a"
                )
                i = i + 1
            end
        end
        __call(
            __arrL(
                {
                    __arrL({962, 46, "#f2f2ee"}, 3),
                    __arrL({976, 44, "#f2e27a"}, 3),
                    __arrL({986, 52, "#f2a8c8"}, 3),
                    __arrL({964, 64, "#a8d8f0"}, 3),
                    __arrL({978, 62, "#f2f2ee"}, 3),
                    __arrL({970, 78, "#f2e27a"}, 3),
                    __arrL({986, 74, "#f2f2ee"}, 3)
                },
                7
            ),
            "forEach",
            function(____, ____bindingPattern0, i)
                local cor
                local y
                local x
                x = ____bindingPattern0[1]
                y = ____bindingPattern0[2]
                cor = ____bindingPattern0[3]
                R(
                    nil,
                    c,
                    x,
                    y,
                    11,
                    12,
                    cor
                )
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            x + 2,
                            y + 4 + k * 2,
                            7 - __mod(k, 2) * 2,
                            1,
                            "rgba(60,60,80,.5)"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 5,
                    y,
                    1,
                    1,
                    __get(
                        __arrL({"#c43c3a", "#3a6aa8", "#3a8a4a"}, 3),
                        __mod(i, 3)
                    )
                )
            end
        )
        R(
            nil,
            c,
            988,
            75,
            6,
            4,
            "#c8945a"
        )
        R(
            nil,
            c,
            987,
            74,
            2,
            2,
            "#8a5a3a"
        )
        R(
            nil,
            c,
            974,
            112,
            4,
            14,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            970,
            126,
            12,
            2,
            "#7a8086"
        )
        disco(
            nil,
            c,
            50,
            214,
            4,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            70,
            214,
            4,
            "#1c1c1c"
        )
        disco(
            nil,
            c,
            50,
            214,
            1,
            "#9aa0a6"
        )
        disco(
            nil,
            c,
            70,
            214,
            1,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            52,
            206,
            16,
            5,
            "#c43c3a"
        )
        R(
            nil,
            c,
            55,
            203,
            9,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            64,
            202,
            4,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            66,
            199,
            6,
            2,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            46,
            207,
            6,
            2,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            70,
            201,
            2,
            3,
            "#ffe8a0"
        )
        R(
            nil,
            c,
            126,
            198,
            9,
            12,
            "#e8843a"
        )
        R(
            nil,
            c,
            126,
            198,
            9,
            2,
            "#f2a04a"
        )
        R(
            nil,
            c,
            129,
            210,
            2,
            8,
            "#5a5e64"
        )
        R(
            nil,
            c,
            78,
            213,
            14,
            5,
            "#d89a4a"
        )
        R(
            nil,
            c,
            89,
            210,
            5,
            5,
            "#d89a4a"
        )
        R(
            nil,
            c,
            90,
            209,
            1,
            2,
            "#b8783a"
        )
        R(
            nil,
            c,
            92,
            209,
            1,
            2,
            "#b8783a"
        )
        R(
            nil,
            c,
            93,
            212,
            2,
            1,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            80,
            213,
            9,
            1,
            "#e8b86a"
        )
        R(
            nil,
            c,
            79,
            217,
            12,
            1,
            "#b8783a"
        )
    end
    local function mata(self, noite)
        local W = 900
        local H = 36
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function T(____, cor)
            return tom(nil, cor, noite)
        end
        local function topo(____, x)
            return 14 + math.sin(x * 0.03) * 4 + math.sin(x * 0.11 + 1) * 2 + math.sin(x * 0.007) * 3
        end
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    topo(nil, x) + 4,
                    1,
                    H,
                    T(nil, "#2a5a34")
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 150 do
                local x = hash(nil, i * 1.31) * W
                local y = topo(nil, x) + 6
                local r = 3 + math.floor(hash(nil, i * 2.7) * 4)
                disco(
                    nil,
                    c,
                    x,
                    y,
                    r,
                    T(nil, "#2a5a34")
                )
                disco(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    math.max(1, r - 1),
                    T(nil, "#3a7040")
                )
                if r > 3 then
                    disco(
                        nil,
                        c,
                        x - 2,
                        y - 2,
                        r - 3,
                        T(nil, "#5a8a4a")
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local x = math.floor(40 + i * 97 + hash(nil, i) * 30 + 0.5)
                local y = math.floor(topo(nil, x) + 3 + 0.5)
                local cor = if __mod(i, 3) == 1 then "#b86aa8" else "#e8b83a"
                local esc = T(
                    nil,
                    mix(nil, cor, "#3a2a1a", 0.35)
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    6,
                    T(nil, "#4a3a2a")
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y + 1,
                    2,
                    1,
                    T(nil, "#4a3a2a")
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y,
                    2,
                    1,
                    T(nil, "#4a3a2a")
                )
                do
                    local k = 0
                    while k < 6 do
                        local cx = x - 4 + math.floor(hash(nil, k + i * 7) * 8 + 0.5)
                        local cy = y - 2 + math.floor(hash(nil, k * 3 + i) * 3 + 0.5)
                        R(
                            nil,
                            c,
                            cx - 1,
                            cy,
                            3,
                            2,
                            esc
                        )
                        R(
                            nil,
                            c,
                            cx - 1,
                            cy - 1,
                            2,
                            1,
                            T(nil, cor)
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x - 4 + math.floor(hash(nil, k * 5 + i) * 8 + 0.5),
                            y - 3 + math.floor(hash(nil, k * 7 + i) * 3 + 0.5),
                            1,
                            1,
                            T(
                                nil,
                                mix(nil, cor, "#ffffff", 0.4)
                            )
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                local x = 90 + i * 150 + hash(nil, i * 5) * 40
                local y = topo(nil, x) - 6
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    12,
                    T(nil, "#4a3a2a")
                )
                do
                    local f = 0
                    while f < 5 do
                        local a = -math.pi / 2 + (f - 2) * 0.7
                        do
                            local k = 1
                            while k < 7 do
                                R(
                                    nil,
                                    c,
                                    x + math.cos(a) * k,
                                    y + math.sin(a) * k * 0.6 + k * k * 0.06,
                                    1,
                                    1,
                                    T(nil, "#2f6a34")
                                )
                                k = k + 1
                            end
                        end
                        f = f + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local y = H - 10
            while y < H do
                do
                    local x = __mod(y, 2)
                    while x < W do
                        if hash(nil, x * 0.7 + y * 13) < (y - (H - 10)) / 14 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                T(nil, "#a8c8b0")
                            )
                        end
                        x = x + 2
                    end
                end
                y = y + 1
            end
        end
        return cv
    end
    local function mataAcude(self, c, t, camL, n)
        local noite = if __gt(n, 0.5) then 1 else 0
        local k = __add("mata", noite)
        if not __t(__get(cache, k)) then
            __set(
                cache,
                k,
                mata(nil, noite)
            )
        end
        local wx = math.floor(342 - camL * 0.12 + 0.5)
        local wy = 100
        if __t(wx > -20 and wx < 500) then
            local cor = if __t(noite) then "#2a2a38" else "#6a6a72"
            linha(
                nil,
                c,
                wx - 5,
                128,
                wx,
                wy,
                cor
            )
            linha(
                nil,
                c,
                wx + 5,
                128,
                wx,
                wy,
                cor
            )
            do
                local j = 0
                while j < 4 do
                    R(
                        nil,
                        c,
                        wx - 4 + j,
                        110 + j * 5,
                        9 - j * 2,
                        1,
                        cor
                    )
                    j = j + 1
                end
            end
            R(
                nil,
                c,
                wx - 1,
                wy - 2,
                4,
                3,
                cor
            )
            R(
                nil,
                c,
                wx + 3,
                wy - 1,
                6,
                1,
                cor
            )
            R(
                nil,
                c,
                wx + 8,
                wy - 3,
                2,
                5,
                if __t(noite) then "#3a3a48" else "#c43c3a"
            )
            do
                local j = 0
                while j < 8 do
                    local a = t * 2.5 + j * math.pi / 4
                    linha(
                        nil,
                        c,
                        wx,
                        wy,
                        wx + math.cos(a) * 7,
                        wy + math.sin(a) * 7,
                        if __t(noite) then "#3a3a4a" else "#d8dce0"
                    )
                    j = j + 1
                end
            end
        end
        c:drawImage(
            __get(cache, k),
            math.floor(__TS__Number(-camL) * 0.2 + 0.5),
            118
        )
    end
    local function bancoCanvas(self, noite)
        local W = 1260
        local H = 36
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function T(____, cor)
            return tom(nil, cor, noite)
        end
        local function topo(____, x)
            return math.floor(11 + math.sin(x * 0.045) * 1.5 + math.sin(x * 0.013 + 2) * 1.5 + 0.5)
        end
        do
            local x = 0
            while x < W do
                local y0 = topo(nil, x)
                R(
                    nil,
                    c,
                    x,
                    y0,
                    1,
                    3,
                    T(nil, "#4a3c26")
                )
                R(
                    nil,
                    c,
                    x,
                    y0 + 3,
                    1,
                    9,
                    T(nil, "#6a5a38")
                )
                R(
                    nil,
                    c,
                    x,
                    y0 + 12,
                    1,
                    H,
                    T(nil, "#7a6a44")
                )
                if __mod(x, 2) == 0 then
                    R(
                        nil,
                        c,
                        x,
                        y0 + 3,
                        1,
                        1,
                        T(nil, "#5a4a30")
                    )
                    R(
                        nil,
                        c,
                        x + 1,
                        y0 + 12,
                        1,
                        1,
                        T(nil, "#6a5a38")
                    )
                end
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 1800 do
                local x = hash(nil, i * 1.17) * W
                local y = topo(nil, x) + 3 + hash(nil, i * 2.3) * 22
                R(
                    nil,
                    c,
                    x,
                    y,
                    if hash(nil, i * 4.1) > 0.7 then 2 else 1,
                    1,
                    T(nil, if __mod(i, 3) == 0 then "#9a8a5e" else if __mod(i, 3) == 1 then "#5a4a30" else "#8a7a50")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 90 do
                local x = hash(nil, i * 7.7) * W
                local y = topo(nil, x) + 4 + hash(nil, i * 1.9) * 18
                local w = 2 + math.floor(hash(nil, i) * 3)
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    2,
                    T(nil, if __t(__mod(i, 2)) then "#8a8a84" else "#a09a8a")
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    w - 1,
                    1,
                    T(nil, "#c8c4b8")
                )
                R(
                    nil,
                    c,
                    x,
                    y + 2,
                    w,
                    1,
                    T(nil, "#4a3c26")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 14 do
                local x = hash(nil, i * 5.3) * W
                local y = topo(nil, x) + 2
                do
                    local k = 0
                    while k < 14 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            1,
                            T(nil, "#5a3a22")
                        )
                        if __mod(k, 4) == 3 then
                            R(
                                nil,
                                c,
                                x + 1,
                                y - 1,
                                1,
                                1,
                                T(nil, "#7a5232")
                            )
                        end
                        x = x + if hash(nil, i * 3 + k) > 0.5 then 1 else -1
                        y = y + 1
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                local h = 2 + math.floor(hash(nil, x * 0.9) * 5)
                local y0 = topo(nil, x)
                R(
                    nil,
                    c,
                    x,
                    y0 - h,
                    1,
                    h,
                    T(nil, if hash(nil, x * 3.3) > 0.5 then "#4a8a3a" else "#3a7a34")
                )
                if h > 4 then
                    R(
                        nil,
                        c,
                        x,
                        y0 - h,
                        1,
                        1,
                        T(nil, "#8ac86a")
                    )
                end
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 12 do
                local x = 40 + i * 100 + hash(nil, i) * 40
                local y = topo(nil, x) - 1
                do
                    local k = 0
                    while k < 5 do
                        disco(
                            nil,
                            c,
                            x + k * 3 - 6,
                            y - __mod(k, 2),
                            2,
                            T(nil, "#2f7a3a")
                        )
                        R(
                            nil,
                            c,
                            x + k * 3 - 7,
                            y - 1 - __mod(k, 2),
                            2,
                            1,
                            T(nil, "#5aa84a")
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 1,
                    y - 8,
                    2,
                    5,
                    T(nil, "#8a6ac8")
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 9,
                    2,
                    1,
                    T(nil, "#c8b8f0")
                )
                R(
                    nil,
                    c,
                    x,
                    y - 6,
                    1,
                    1,
                    T(nil, "#f2d84a")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 60 do
                local x = hash(nil, i * 9.3) * W
                local y = topo(nil, x) + 4 + hash(nil, i * 2.9) * 14
                local cor = __get(
                    __arrL({"#f2c94c", "#f2a8c8", "#ffffff", "#c86ab8"}, 4),
                    __mod(i, 4)
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    3,
                    T(nil, "#3a7a34")
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    3,
                    1,
                    T(nil, cor)
                )
                R(
                    nil,
                    c,
                    x,
                    y - 2,
                    1,
                    3,
                    T(nil, cor)
                )
                R(
                    nil,
                    c,
                    x,
                    y - 1,
                    1,
                    1,
                    T(nil, "#f2d84a")
                )
                i = i + 1
            end
        end
        return cv
    end
    local function capimCanvas(self, noite, lado, qtd, H, hMin, hMax)
        local W = 1260
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function T(____, cor)
            return tom(nil, cor, noite)
        end
        do
            local i = 0
            while __lt(i, qtd) do
                local x = hash(nil, i * 3.71) * W
                local h = hMin + math.floor(hash(nil, i * 1.3) * (hMax - hMin))
                local cor = T(nil, if __t(__mod(i, 3)) then "#4a8a3a" else "#5a9a44")
                local ponta = T(nil, "#9ac878")
                local y0 = 0
                do
                    local y = 1
                    while y <= h - 2 do
                        if __t(y == h - 2 or math.floor(lado * (y / h) * 2 + 0.5) ~= math.floor(lado * (y0 / h) * 2 + 0.5)) then
                            R(
                                nil,
                                c,
                                x + math.floor(lado * (y0 / h) * 2 + 0.5),
                                H - y,
                                1,
                                y - y0,
                                cor
                            )
                            y0 = y
                        end
                        y = y + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + math.floor(lado * 2 * (h - 1) / h + 0.5),
                    H - h,
                    1,
                    2,
                    ponta
                )
                i = i + 1
            end
        end
        return cv
    end
    local function desenharCapim(self, c, quadros, y, t, camL, fase)
        local seg = 40
        local i0 = math.floor(camL / seg)
        local h = __get(quadros, 0).height
        do
            local i = i0
            while i < i0 + 14 do
                local sx = i * seg - camL
                if sx > 482 then
                    break
                end
                local v = math.sin(t * 1.8 + i * 0.55 + fase)
                local f = if v > 0.35 then 2 else if v < -0.35 then 0 else 1
                c:drawImage(
                    __get(quadros, f),
                    i * seg,
                    0,
                    seg,
                    h,
                    math.floor(sx + 0.5),
                    y,
                    seg,
                    h
                )
                i = i + 1
            end
        end
    end
    local function bancoAcude(self, c, t, camL, n)
        local noite = if __gt(n, 0.5) then 1 else 0
        local k = __add("banco", noite)
        local kc = __add("capimB", noite)
        if not __t(__get(cache, k)) then
            __set(
                cache,
                k,
                bancoCanvas(nil, noite)
            )
        end
        if not __t(__get(cache, kc)) then
            __set(
                cache,
                kc,
                __call(
                    __arrL({-1, 0, 1}, 3),
                    "map",
                    function(____, l) return capimCanvas(
                        nil,
                        noite,
                        l,
                        260,
                        16,
                        6,
                        14
                    ) end
                )
            )
        end
        c:drawImage(
            __get(cache, k),
            math.floor(camL + 0.5),
            0,
            482,
            36,
            0,
            186,
            482,
            36
        )
        desenharCapim(
            nil,
            c,
            __get(cache, kc),
            182,
            t,
            camL,
            1.3
        )
    end
    local function chaoCanvas(self, noite)
        local W = 1260
        local H = 50
        local cv, c = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        local function T(____, cor)
            return tom(nil, cor, noite)
        end
        R(
            nil,
            c,
            0,
            0,
            W,
            H,
            T(nil, "#8a7a56")
        )
        do
            local i = 0
            while i < 5200 do
                local x = hash(nil, i * 0.73) * W
                local y = hash(nil, i * 1.91) * H
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    T(nil, if __mod(i, 3) == 0 then "#a8946a" else if __mod(i, 3) == 1 then "#6a5a3e" else "#7a6a4a")
                )
                i = i + 1
            end
        end
        local function trilha(____, x)
            return 16 + math.sin(x * 0.012) * 7 + math.sin(x * 0.041) * 2
        end
        do
            local x = 0
            while x < W do
                local y = trilha(nil, x)
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    10,
                    T(nil, "#a89470")
                )
                if hash(nil, x) > 0.5 then
                    R(
                        nil,
                        c,
                        x,
                        y - 1,
                        2,
                        1,
                        T(nil, "#988462")
                    )
                end
                if hash(nil, x + 3) > 0.5 then
                    R(
                        nil,
                        c,
                        x,
                        y + 10,
                        2,
                        1,
                        T(nil, "#988462")
                    )
                end
                if hash(nil, x * 1.7) > 0.8 then
                    R(
                        nil,
                        c,
                        x,
                        y + 2 + hash(nil, x * 2.3) * 6,
                        2,
                        1,
                        T(nil, "#b8a47e")
                    )
                end
                x = x + 2
            end
        end
        do
            local k = 0
            local x = 30
            while x < W do
                local y = trilha(nil, x) + 2 + __mod(k, 2) * 4
                R(
                    nil,
                    c,
                    x,
                    y,
                    3,
                    2,
                    T(nil, "#8a7856")
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y + 2,
                    2,
                    1,
                    T(nil, "#8a7856")
                )
                do
                    x = x + 23
                    k = k + 1
                end
            end
        end
        do
            local i = 0
            while i < 70 do
                local x = hash(nil, i * 4.4) * W
                local y = 4 + hash(nil, i * 6.1) * 42
                local w = 3 + math.floor(hash(nil, i * 2.2) * 5)
                local h = 2 + math.floor(hash(nil, i * 3.3) * 2)
                R(
                    nil,
                    c,
                    x,
                    y + h,
                    w,
                    1,
                    T(nil, "#4a3e2a")
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    h,
                    T(nil, if __t(__mod(i, 3)) then "#8a8a84" else "#9a948a")
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y,
                    w - 2,
                    1,
                    T(nil, "#c8c4b8")
                )
                R(
                    nil,
                    c,
                    x + w - 1,
                    y + 1,
                    1,
                    h - 1,
                    T(nil, "#6a6a64")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local x = hash(nil, i * 8.1) * W
                local y = hash(nil, i * 2.9) * 12
                do
                    local k = 0
                    while k < 18 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            1,
                            T(nil, "#5a3a22")
                        )
                        if __mod(k, 3) == 0 then
                            R(
                                nil,
                                c,
                                x,
                                y - 1,
                                1,
                                1,
                                T(nil, "#7a5232")
                            )
                        end
                        x = x + 2
                        y = y + if hash(nil, i + k * 1.3) > 0.5 then 1 else 0
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 90 do
                local x = hash(nil, i * 1.77) * W
                local y = hash(nil, i * 5.5) * 48
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    T(
                        nil,
                        __get(
                            __arrL({"#c8843a", "#a8642a", "#d8a84a", "#6a8a3a"}, 4),
                            __mod(i, 4)
                        )
                    )
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y + 1,
                    1,
                    1,
                    T(nil, "#8a5a2a")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                local x = hash(nil, i * 13.1) * W
                local y = 6 + hash(nil, i * 3.9) * 36
                R(
                    nil,
                    c,
                    x,
                    y + 2,
                    1,
                    2,
                    T(nil, "#e8e2d0")
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y,
                    3,
                    2,
                    T(nil, if __t(__mod(i, 2)) then "#c43c3a" else "#b8905a")
                )
                if __t(__mod(i, 2)) then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        T(nil, "#ffffff")
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 70 do
                local x = hash(nil, i * 2.13) * W
                local y = 4 + hash(nil, i * 7.3) * 44
                do
                    local b = 0
                    while b < 5 do
                        local h = 2 + math.floor(hash(nil, i + b) * 4)
                        R(
                            nil,
                            c,
                            x + (b - 2) * 1.3,
                            y - h,
                            1,
                            h,
                            T(nil, if __t(__mod(b, 2)) then "#4a8a3a" else "#5a9a44")
                        )
                        b = b + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 2,
                    y,
                    5,
                    1,
                    T(nil, "#3a6a2a")
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 60 do
                local x = hash(nil, i * 3.03) * W
                local y = 2 + hash(nil, i * 8.7) * 46
                local cor = __get(
                    __arrL({"#f2f2ee", "#f2c94c", "#f2a8c8"}, 3),
                    __mod(i, 3)
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y,
                    3,
                    1,
                    T(nil, cor)
                )
                R(
                    nil,
                    c,
                    x,
                    y - 1,
                    1,
                    3,
                    T(nil, cor)
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    T(nil, if __t(__mod(i, 3)) then "#e8a020" else "#c8843a")
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({260, 34, 26}, 3),
                __arrL({880, 30, 20}, 3)
            },
            2
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            local w = ____value[3]
            R(
                nil,
                c,
                x - w / 2 - 1,
                y - 1,
                w + 2,
                1,
                T(nil, "#5a4a30")
            )
            do
                local k = 0
                while k < 4 do
                    R(
                        nil,
                        c,
                        x - w / 2 + k * 2,
                        y + k,
                        w - k * 4,
                        1,
                        T(nil, if __t(k) then "#5a8ab8" else "#8ac0e0")
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x - w / 2 + 3,
                y + 1,
                6,
                1,
                T(nil, "#c8e8f8")
            )
        end
        return cv
    end
    local function chaoAcude(self, c, t, camL, n)
        local noite = if __gt(n, 0.5) then 1 else 0
        local k = __add("chao", noite)
        local kc = __add("capimC", noite)
        if not __t(__get(cache, k)) then
            __set(
                cache,
                k,
                chaoCanvas(nil, noite)
            )
        end
        if not __t(__get(cache, kc)) then
            __set(
                cache,
                kc,
                __call(
                    __arrL({-1, 0, 1}, 3),
                    "map",
                    function(____, l) return capimCanvas(
                        nil,
                        noite,
                        l,
                        340,
                        9,
                        2,
                        7
                    ) end
                )
            )
        end
        c:drawImage(
            __get(cache, k),
            math.floor(camL + 0.5),
            0,
            482,
            50,
            0,
            220,
            482,
            50
        )
        desenharCapim(
            nil,
            c,
            __get(cache, kc),
            212,
            t,
            camL,
            0
        )
        do
            local i = 0
            while i < 9 do
                local wx = __mod(t * 6 + i * 9, 160) + 300
                local x = wx - camL
                local y = 252 + math.sin(wx * 0.08) * 2
                if __t(x < -4 or x > 486) then
                    continue
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    if __t(noite) then "#0e0c0a" else "#2a1a10"
                )
                if __mod(i, 3) == 0 then
                    R(
                        nil,
                        c,
                        x - 1,
                        y - 2,
                        3,
                        2,
                        if __t(noite) then "#1a2a14" else "#5aa84a"
                    )
                end
                i = i + 1
            end
        end
    end
    local function vidaAgua(self, c, t, camL, n)
        local noite = __gt(n, 0.5)
        do
            local base = __mod(
                __mod(t * 5, 1500) + 1500,
                1500
            )
            do
                local k = 0
                while k < 4 do
                    local x = math.floor(1350 - base - camL * 0.8 + k * 9 + 0.5)
                    local y = math.floor(178 + math.sin(t * 2 + k) * 0.6 + 0.5)
                    if __t(x < -12 or x > 494) then
                        continue
                    end
                    local mae = k == 0
                    local corpo = if __t(noite) then "#8a8a9a" else "#f2f2ec"
                    c.globalAlpha = 0.5
                    R(
                        nil,
                        c,
                        x + if __t(mae) then 7 else 4,
                        y + 2,
                        3,
                        1,
                        if __t(noite) then "#3a5a8a" else "#d8f0ff"
                    )
                    R(
                        nil,
                        c,
                        x + if __t(mae) then 10 else 6,
                        y + 3,
                        3,
                        1,
                        if __t(noite) then "#3a5a8a" else "#d8f0ff"
                    )
                    c.globalAlpha = 1
                    if __t(mae) then
                        R(
                            nil,
                            c,
                            x,
                            y - 2,
                            8,
                            4,
                            corpo
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            y - 1,
                            5,
                            1,
                            if __t(noite) then "#6a6a7a" else "#d8d8d0"
                        )
                        R(
                            nil,
                            c,
                            x - 1,
                            y - 6,
                            3,
                            4,
                            corpo
                        )
                        R(
                            nil,
                            c,
                            x - 3,
                            y - 5,
                            2,
                            1,
                            "#e8a020"
                        )
                        R(
                            nil,
                            c,
                            x - 1,
                            y - 5,
                            1,
                            1,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            c,
                            x + 7,
                            y - 3,
                            2,
                            1,
                            corpo
                        )
                    else
                        R(
                            nil,
                            c,
                            x,
                            y - 1,
                            4,
                            3,
                            if __t(noite) then "#8a845a" else "#f2d84a"
                        )
                        R(
                            nil,
                            c,
                            x - 1,
                            y - 3,
                            2,
                            2,
                            if __t(noite) then "#8a845a" else "#f2d84a"
                        )
                        R(
                            nil,
                            c,
                            x - 2,
                            y - 2,
                            1,
                            1,
                            "#e8a020"
                        )
                    end
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 5 do
                local x = __mod(
                    __mod(
                        hash(nil, k + 40) * 600 + t * 3 - camL * 0.75,
                        520
                    ) + 520,
                    520
                ) - 20
                local y = 160 + hash(nil, k * 3 + 40) * 30 + math.sin(t + k) * 0.6
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    if __t(noite) then "#3a3a2a" else __get(
                        __arrL({"#c8843a", "#6a8a3a", "#d8a84a"}, 3),
                        __mod(k, 3)
                    )
                )
                k = k + 1
            end
        end
        do
            local x = 810 - camL
            if __t(x > -40 and x < 520) then
                local ciclo = __mod(t, 7)
                local afunda = if ciclo > 6.3 then 2 else 0
                local fy = 184 + math.floor(math.sin(t * 3) * 0.7 + 0.5) + afunda
                local fx = x + 22
                linha(
                    nil,
                    c,
                    x - 10,
                    138,
                    fx,
                    fy - 2,
                    if __t(noite) then "rgba(200,210,230,.35)" else "rgba(240,240,240,.55)"
                )
                R(
                    nil,
                    c,
                    fx - 1,
                    fy - 3,
                    3,
                    2,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    fx - 1,
                    fy - 1,
                    3,
                    1,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    fx,
                    fy - 5,
                    1,
                    2,
                    "#f2c94c"
                )
                local r = 2 + __mod(t * 3, 3) * 2
                c.globalAlpha = 0.5 * (1 - __mod(t * 3, 3) / 3)
                oval(
                    nil,
                    c,
                    fx,
                    185,
                    r,
                    r * 0.3,
                    if __t(noite) then "#6a8ab8" else "#e8f8ff"
                )
                c.globalAlpha = 1
            end
        end
    end
    window.LugaresFundos = __ord({
        chaoAcude = chaoAcude,
        camadaAcude = camadaAcude,
        arvoresAcude = arvoresAcude,
        aguaAcude = aguaAcude,
        mataAcude = mataAcude,
        bancoAcude = bancoAcude,
        vidaAgua = vidaAgua,
        oficinaParede = oficinaParede,
        oficinaChao = oficinaChao,
        oficinaAnim = oficinaAnim,
        oficinaProps = oficinaProps,
        oficinaFora = oficinaFora,
        lancheParede = lancheParede,
        lancheRua = lancheRua,
        lancheChao = lancheChao,
        lancheAnim = lancheAnim,
        lancheProps = lancheProps
    }, "chaoAcude,camadaAcude,arvoresAcude,aguaAcude,mataAcude,bancoAcude,vidaAgua,oficinaParede,oficinaChao,oficinaAnim,oficinaProps,oficinaFora,lancheParede,lancheRua,lancheChao,lancheAnim,lancheProps")
end)(nil)
return ____exports
