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
                        __O[1307] = ____temp_0
                        if ____t_2(if ____t_1(____temp_0) then __mod(x + y, 2) == 0 else __O[1307]) then
                            cor = medio
                        end
                        local ____t_5 = __t
                        local ____t_4 = __t
                        local ____temp_3 = incl > 1.2 and prof > 0.45
                        __O[1308] = ____temp_3
                        if ____t_5(if ____t_4(____temp_3) then __mod(x + y, 2) == 0 else __O[1308]) then
                            cor = medio
                        end
                        local ____t_10 = __t
                        local ____t_9 = __t
                        local ____t_7 = __t
                        local ____temp_6 = __mod(
                            math.floor(y + math.sin(x * 0.05) * 3 + 0.5),
                            9
                        ) == 0 and prof > 0.12
                        __O[1309] = ____temp_6
                        local ____temp_8 = if ____t_7(____temp_6) then prof < 0.7 else __O[1309]
                        __O[1310] = ____temp_8
                        if ____t_10(if ____t_9(____temp_8) then __mod(x + y, 3) ~= 0 else __O[1310]) then
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
                        __O[1311] = ____temp_11
                        if ____t_13(if ____t_12(____temp_11) then __mod(y, 4) == 0 else __O[1311]) then
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
            292,
            190
        )
        c:clip()
        do
            local PORTA = 300
            local x = __mod(t * 40, 700) - 200 - camL
            if __t(x > -80 - camL and x < PORTA - camL) then
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
            local x = 260 - __mod(t * 25, 340) - camL
            if __t(x > -30 - camL and x < 300 - camL) then
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
        c:restore()
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
    end
    local function chaoAcude(self, c, t, camL, n)
        local noite = __gt(n, 0.5)
        do
            local x = 0
            while x < 482 do
                local wx = math.floor((x + camL) / 2)
                do
                    local y = 222
                    while y < 270 do
                        local h = hash(nil, wx * 7.3 + y * 1.7)
                        if h > 0.9 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                1,
                                if __t(noite) then "#3a3428" else "#a8946a"
                            )
                        elseif h < 0.08 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                1,
                                if __t(noite) then "#1a1612" else "#6a5a3e"
                            )
                        end
                        y = y + 2
                    end
                end
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 60 do
                local wx = i * 41
                local x = __mod(
                    __mod(wx - camL, 2460) + 2460,
                    2460
                ) - 30
                if __t(x < -10 or x > 490) then
                    continue
                end
                if hash(nil, i) > 0.55 then
                    R(
                        nil,
                        c,
                        x,
                        230 + hash(nil, i * 3) * 34,
                        3,
                        2,
                        if __t(noite) then "#2a2a2e" else "#8a8a86"
                    )
                    R(
                        nil,
                        c,
                        x,
                        230 + hash(nil, i * 3) * 34,
                        3,
                        1,
                        if __t(noite) then "#3a3a40" else "#b8b8b0"
                    )
                end
                if hash(nil, i * 7) > 0.8 then
                    local y = 236 + hash(nil, i) * 24
                    do
                        local k = 0
                        while k < 6 do
                            R(
                                nil,
                                c,
                                x + k * 2,
                                y + math.sin(k) * 2,
                                2,
                                1,
                                if __t(noite) then "#2a2018" else "#5a4228"
                            )
                            k = k + 1
                        end
                    end
                end
                if hash(nil, i * 5) > 0.7 then
                    do
                        local k = 0
                        while k < 3 do
                            local y = 228 + k * 12 + hash(nil, i + k) * 4
                            R(
                                nil,
                                c,
                                x + k * 6,
                                y,
                                2,
                                3,
                                if __t(noite) then "#221e18" else "#76664a"
                            )
                            R(
                                nil,
                                c,
                                x + k * 6 + 3,
                                y + 1,
                                1,
                                2,
                                if __t(noite) then "#221e18" else "#76664a"
                            )
                            k = k + 1
                        end
                    end
                end
                i = i + 1
            end
        end
        do
            local x = 0
            while x < 482 do
                local wx = math.floor((x + camL) / 3)
                local h = 2 + hash(nil, wx) * 5
                local sw = math.sin(t * 2 + wx * 0.3) * 0.8
                do
                    local y = 0
                    while y < h do
                        R(
                            nil,
                            c,
                            x + sw * y / h,
                            220 - y,
                            1,
                            1,
                            if __t(noite) then "#1a3a22" else if y > h - 2 then "#8ac86a" else "#5a9a4a"
                        )
                        y = y + 1
                    end
                end
                x = x + 3
            end
        end
    end
    window.LugaresFundos = __ord({
        chaoAcude = chaoAcude,
        camadaAcude = camadaAcude,
        arvoresAcude = arvoresAcude,
        aguaAcude = aguaAcude,
        oficinaParede = oficinaParede,
        oficinaChao = oficinaChao,
        oficinaAnim = oficinaAnim,
        lancheParede = lancheParede,
        lancheRua = lancheRua,
        lancheChao = lancheChao,
        lancheAnim = lancheAnim
    }, "chaoAcude,camadaAcude,arvoresAcude,aguaAcude,oficinaParede,oficinaChao,oficinaAnim,lancheParede,lancheRua,lancheChao,lancheAnim")
end)(nil)
return ____exports
