--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __fcall, __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__fcall, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __arr, __len, __call, __add, __new, __iter, __keys, __bor, __band, __shl, __shr, __re = __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys, __JSR.__bor, __JSR.__band, __JSR.__shl, __JSR.__shr, __JSR.__re
local __re_test = __JSR.__re_test
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
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art)
    __O[679] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[679] else window.Art.__brainrots) then
        return
    end
    local original = window.Art.drawMinion
    local S = 2
    local W = 64
    local H = 56
    local AX = 32
    local AY = 54
    local N = 8
    local TAU = math.pi * 2
    local CONTORNO = "#1a1020"
    local PRETO = "#141018"
    local BRANCO = "#ffffff"
    local g = nil
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
                        local ____t_5 = __t
                        local ____t_4 = __t
                        local ____temp_3 = __le(ay, yc) and __gt(by, yc)
                        __O[680] = ____temp_3
                        if ____t_5(if ____t_4(____temp_3) then __O[680] else __le(by, yc) and __gt(ay, yc)) then
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
    local function barra(____, x, y, ang, len, w0, w1, col)
        local c = math.cos(ang)
        local s = math.sin(ang)
        local nx = -s
        local ny = c
        poly(
            nil,
            __arrL(
                {
                    __arrL({x + nx * w0 / 2, y + ny * w0 / 2}, 2),
                    __arrL({x + c * len + nx * w1 / 2, y + s * len + ny * w1 / 2}, 2),
                    __arrL({x + c * len - nx * w1 / 2, y + s * len - ny * w1 / 2}, 2),
                    __arrL({x - nx * w0 / 2, y - ny * w0 / 2}, 2)
                },
                4
            ),
            col
        )
    end
    local function olho(____, x, y, bravo, w, h)
        if w == nil then
            w = 3
        end
        if h == nil then
            h = 3
        end
        r(
            nil,
            x,
            y,
            w,
            h,
            plana(nil, BRANCO)
        )
        local pw = if w >= 4 then 2 else 1
        r(
            nil,
            x + w - pw - if w >= 4 then 1 else 0,
            y + h - 2,
            pw,
            2,
            plana(nil, PRETO)
        )
        if __t(bravo) then
            r(
                nil,
                x - 1,
                y - 2,
                2,
                1,
                PRETO
            )
            r(
                nil,
                x + 1,
                y - 1,
                w - 1,
                1,
                PRETO
            )
            p(nil, x, y, PRETO)
        end
    end
    local function mistura(____, a, b, k)
        return __call(
            __arrL({0, 1, 2}, 3),
            "map",
            function(____, i) return math.floor(__get(a, i) + (__get(b, i) - __get(a, i)) * k + 0.5) end
        )
    end
    local LUZ = __arrL({255, 236, 255}, 3)
    local SOMBRA = __arrL({40, 14, 64}, 3)
    local BORDA = __arrL({52, 32, 66}, 3)
    local ROXO = 0.66
    local DESBOTA = 0.3
    local CLAREIA = 0.24
    local function roxo(____, rgb, x, y)
        local L = __get(rgb, 0) * 0.3 + __get(rgb, 1) * 0.55 + __get(rgb, 2) * 0.15
        local c = mistura(
            nil,
            rgb,
            __arrL(
                {
                    math.min(255, L * 0.82 + 56),
                    math.min(255, L * 0.42),
                    math.min(255, L * 0.95 + 92)
                },
                3
            ),
            ROXO
        )
        local L2 = __get(c, 0) * 0.3 + __get(c, 1) * 0.55 + __get(c, 2) * 0.15
        c = mistura(
            nil,
            c,
            __arrL({L2, L2, L2}, 3),
            DESBOTA
        )
        c = mistura(
            nil,
            c,
            __arrL({236, 224, 246}, 3),
            CLAREIA
        )
        local h = __mod(
            math.sin(x * 12.9898 + y * 78.233) * 43758.5453,
            1
        )
        local k = if h < 0 then h + 1 else h
        if k > 0.9 then
            c = mistura(
                nil,
                c,
                __arrL({246, 240, 250}, 3),
                0.3
            )
        elseif k < 0.06 then
            c = mistura(
                nil,
                c,
                __arrL({70, 50, 90}, 3),
                0.16
            )
        end
        return c
    end
    local function acabamento(self, cv)
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
            local ____t_10 = __t
            local ____t_9 = __t
            local ____t_7 = __t
            local ____temp_6 = __lt(x, 0) or __lt(y, 0)
            __O[681] = ____temp_6
            local ____temp_8 = if ____t_7(____temp_6) then __O[681] else __ge(x, W)
            __O[682] = ____temp_8
            return if ____t_10(if ____t_9(____temp_8) then __O[682] else __ge(y, H)) then -1 else __get(cor, y * W + x)
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
            while y < H do
                do
                    local x = 0
                    while x < W do
                        local i = y * W + x
                        local c = __get(cor, i)
                        if c < 0 then
                            local ____t_15 = __t
                            local ____t_14 = __t
                            local ____t_12 = __t
                            local ____temp_11 = em(nil, x - 1, y) >= 0 or em(nil, x + 1, y) >= 0
                            __O[683] = ____temp_11
                            local ____temp_13 = if ____t_12(____temp_11) then __O[683] else em(nil, x, y - 1) >= 0
                            __O[684] = ____temp_13
                            if ____t_15(if ____t_14(____temp_13) then __O[684] else em(nil, x, y + 1) >= 0) then
                                local ____call_18 = __call
                                local ____arr_17 = __arr
                                local ____array_16 = __TS__SparseArrayNew(__TS__Spread(__iter(BORDA)))
                                __TS__SparseArrayPush(____array_16, 255)
                                ____call_18(
                                    out,
                                    "set",
                                    ____arr_17(__TS__SparseArraySpread(____array_16)),
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
                            local esq = em(nil, x - 1, y) ~= c
                            if __t(if __t(cima) then not __t(baixo) else cima) then
                                rgb = mistura(nil, rgb, LUZ, 0.34)
                            elseif __t(if __t(baixo) then baixo else dir) then
                                rgb = mistura(nil, rgb, SOMBRA, if __t(if __t(baixo) then dir else baixo) then 0.44 else 0.3)
                            elseif em(nil, x, y + 2) ~= c then
                                rgb = mistura(nil, rgb, SOMBRA, 0.14)
                            else
                                local ____t_21 = __t
                                local ____t_20 = __t
                                local ____temp_19 = if __t(esq) then esq else em(nil, x - 1, y - 1) ~= c
                                __O[685] = ____temp_19
                                if ____t_21(if ____t_20(____temp_19) then __O[685] else em(nil, x, y - 2) ~= c) then
                                    rgb = mistura(nil, rgb, LUZ, 0.14)
                                end
                            end
                        end
                        if not __t(__call(plano, "has", c)) then
                            rgb = roxo(nil, rgb, x, y)
                        end
                        local ____call_24 = __call
                        local ____arr_23 = __arr
                        local ____array_22 = __TS__SparseArrayNew(__TS__Spread(__iter(rgb)))
                        __TS__SparseArrayPush(____array_22, 255)
                        ____call_24(
                            out,
                            "set",
                            ____arr_23(__TS__SparseArraySpread(____array_22)),
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
    local SPRITES = __ord(
        {
            tralalero = function(self, f, bravo)
                local a = f / N * TAU
                local y0 = -19 + if __mod(f, 4) < 2 then 0 else -1
                __call(
                    __arrL({-9, -1, 7}, 3),
                    "forEach",
                    function(____, lx, k)
                        local lev = math.max(
                            0,
                            math.floor(math.sin(a + k * 2.09) * 2.4 + 0.5)
                        )
                        r(
                            nil,
                            lx,
                            y0 + 5,
                            3,
                            -4 - lev - (y0 + 5),
                            "#e8b48c"
                        )
                        r(
                            nil,
                            lx - 1,
                            -4 - lev,
                            6,
                            3,
                            "#f2f2f2"
                        )
                        r(
                            nil,
                            lx - 1,
                            -2 - lev,
                            6,
                            1,
                            "#2c5cc8"
                        )
                        p(nil, lx + 1, -3 - lev, "#2c5cc8")
                        p(nil, lx + 2, -4 - lev, "#2c5cc8")
                    end
                )
                local rabo = __get(
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
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-14, y0 - 2}, 2),
                            __arrL({-24, y0 - 10 + rabo}, 2),
                            __arrL({-20, y0 - 1}, 2),
                            __arrL({-24, y0 + 6 + rabo}, 2),
                            __arrL({-14, y0 + 2}, 2)
                        },
                        5
                    ),
                    "#3a72b4"
                )
                e(
                    nil,
                    0,
                    y0,
                    15,
                    7,
                    "#4a88cc"
                )
                e(
                    nil,
                    2,
                    y0 + 4,
                    12,
                    3,
                    "#eef2f4"
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-4, y0 - 6}, 2),
                            __arrL({0, y0 - 15}, 2),
                            __arrL({4, y0 - 6}, 2)
                        },
                        3
                    ),
                    "#3a72b4"
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({1, y0 + 2}, 2),
                            __arrL({-5, y0 + 9}, 2),
                            __arrL({6, y0 + 3}, 2)
                        },
                        3
                    ),
                    "#3a72b4"
                )
                r(
                    nil,
                    3,
                    y0 - 2,
                    1,
                    4,
                    "#2c5a94"
                )
                r(
                    nil,
                    5,
                    y0 - 2,
                    1,
                    4,
                    "#2c5a94"
                )
                r(
                    nil,
                    8,
                    y0 + 2,
                    8,
                    3,
                    plana(nil, "#6a1424")
                )
                do
                    local k = 0
                    while k < 4 do
                        p(
                            nil,
                            9 + k * 2,
                            y0 + 2,
                            plana(nil, BRANCO)
                        )
                        p(nil, 10 + k * 2, y0 + 4, BRANCO)
                        k = k + 1
                    end
                end
                olho(
                    nil,
                    9,
                    y0 - 4,
                    bravo,
                    3,
                    3
                )
            end,
            tungTung = function(self, f, bravo)
                local y0 = __TS__Number(-__get(
                    __arrL({
                        0,
                        2,
                        4,
                        5,
                        5,
                        4,
                        2,
                        0
                    }, 8),
                    f
                ))
                r(
                    nil,
                    -5,
                    y0 - 8,
                    2,
                    7,
                    "#8a5630"
                )
                r(
                    nil,
                    3,
                    y0 - 8,
                    2,
                    7,
                    "#8a5630"
                )
                r(
                    nil,
                    -7,
                    y0 - 2,
                    5,
                    2,
                    "#6a3e20"
                )
                r(
                    nil,
                    3,
                    y0 - 2,
                    5,
                    2,
                    "#6a3e20"
                )
                r(
                    nil,
                    -8,
                    y0 - 36,
                    16,
                    29,
                    "#c8864a"
                )
                e(
                    nil,
                    0,
                    y0 - 36,
                    8,
                    2,
                    "#e8b47c"
                )
                e(
                    nil,
                    0,
                    y0 - 36,
                    5,
                    1,
                    "#d09a60"
                )
                p(nil, 0, y0 - 36, "#a86a38")
                r(
                    nil,
                    -6,
                    y0 - 31,
                    1,
                    7,
                    "#a86a38"
                )
                r(
                    nil,
                    5,
                    y0 - 24,
                    1,
                    9,
                    "#a86a38"
                )
                r(
                    nil,
                    -4,
                    y0 - 15,
                    1,
                    5,
                    "#a86a38"
                )
                r(
                    nil,
                    2,
                    y0 - 33,
                    1,
                    2,
                    "#a86a38"
                )
                olho(
                    nil,
                    -7,
                    y0 - 29,
                    bravo,
                    5,
                    5
                )
                olho(
                    nil,
                    1,
                    y0 - 29,
                    bravo,
                    5,
                    5
                )
                if not __t(bravo) then
                    r(
                        nil,
                        -7,
                        y0 - 31,
                        5,
                        1,
                        plana(nil, "#4a2810")
                    )
                    r(
                        nil,
                        1,
                        y0 - 31,
                        5,
                        1,
                        "#4a2810"
                    )
                end
                r(
                    nil,
                    -4,
                    y0 - 20,
                    8,
                    3,
                    plana(nil, "#5a1418")
                )
                r(
                    nil,
                    -3,
                    y0 - 19,
                    6,
                    1,
                    plana(nil, "#d8484a")
                )
                p(nil, -5, y0 - 21, "#5a1418")
                p(nil, 4, y0 - 21, "#5a1418")
                barra(
                    nil,
                    -8,
                    y0 - 20,
                    2.3,
                    9,
                    2,
                    2,
                    "#a86a38"
                )
                barra(
                    nil,
                    8,
                    y0 - 20,
                    0.5,
                    5,
                    2,
                    2,
                    "#a86a38"
                )
                local ang = __get(
                    __arrL({
                        -1.25,
                        -1.45,
                        -1.65,
                        -1.75,
                        -0.9,
                        0.25,
                        0.45,
                        -0.4
                    }, 8),
                    f
                )
                local hx = 8 + math.cos(0.5) * 5
                local hy = y0 - 20 + math.sin(0.5) * 5
                barra(
                    nil,
                    hx,
                    hy,
                    ang,
                    20,
                    3,
                    5,
                    "#e8c890"
                )
                local tx = hx + math.cos(ang) * 12
                local ty = hy + math.sin(ang) * 12
                p(
                    nil,
                    tx,
                    ty,
                    plana(nil, "#c43c3a")
                )
                p(
                    nil,
                    tx + math.cos(ang) * 3,
                    ty + math.sin(ang) * 3,
                    "#c43c3a"
                )
            end,
            ballerina = function(self, f, bravo)
                local y0 = __TS__Number(-__get(
                    __arrL({
                        0,
                        1,
                        2,
                        2,
                        1,
                        0,
                        0,
                        0
                    }, 8),
                    f
                ))
                local cima = __mod(f, 4) >= 2
                r(
                    nil,
                    -1,
                    y0 - 14,
                    2,
                    13,
                    "#f2cdb4"
                )
                r(
                    nil,
                    -1,
                    y0 - 2,
                    2,
                    2,
                    "#f08ab4"
                )
                barra(
                    nil,
                    1,
                    y0 - 13,
                    0.9,
                    6,
                    2,
                    2,
                    "#f2cdb4"
                )
                barra(
                    nil,
                    5,
                    y0 - 8,
                    2.6,
                    4,
                    2,
                    2,
                    "#f2cdb4"
                )
                e(
                    nil,
                    0,
                    y0 - 16,
                    11,
                    3,
                    "#f8bcd6"
                )
                do
                    local k = -10
                    while k <= 10 do
                        p(
                            nil,
                            k,
                            y0 - 16 + __band(k, 1),
                            "#ffe2ee"
                        )
                        k = k + 3
                    end
                end
                r(
                    nil,
                    -3,
                    y0 - 25,
                    6,
                    8,
                    "#f08ab4"
                )
                p(nil, 0, y0 - 22, "#ffd8e8")
                if __t(cima) then
                    barra(
                        nil,
                        -3,
                        y0 - 24,
                        -2.1,
                        9,
                        2,
                        2,
                        "#f2cdb4"
                    )
                    barra(
                        nil,
                        3,
                        y0 - 24,
                        -1.05,
                        9,
                        2,
                        2,
                        "#f2cdb4"
                    )
                else
                    barra(
                        nil,
                        -3,
                        y0 - 24,
                        math.pi + 0.25,
                        10,
                        2,
                        2,
                        "#f2cdb4"
                    )
                    barra(
                        nil,
                        3,
                        y0 - 24,
                        -0.25,
                        10,
                        2,
                        2,
                        "#f2cdb4"
                    )
                end
                r(
                    nil,
                    -1,
                    y0 - 27,
                    2,
                    2,
                    "#f2cdb4"
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-8, y0 - 38}, 2),
                            __arrL({8, y0 - 38}, 2),
                            __arrL({6, y0 - 28}, 2),
                            __arrL({-6, y0 - 28}, 2)
                        },
                        4
                    ),
                    "#f6f2ea"
                )
                r(
                    nil,
                    -5,
                    y0 - 28,
                    10,
                    1,
                    "#e0d8cc"
                )
                r(
                    nil,
                    8,
                    y0 - 36,
                    3,
                    1,
                    "#f6f2ea"
                )
                r(
                    nil,
                    10,
                    y0 - 36,
                    1,
                    5,
                    "#f6f2ea"
                )
                r(
                    nil,
                    8,
                    y0 - 32,
                    3,
                    1,
                    "#f6f2ea"
                )
                e(
                    nil,
                    0,
                    y0 - 39,
                    8,
                    1,
                    "#c89060"
                )
                p(
                    nil,
                    -1,
                    y0 - 40,
                    plana(nil, "#f6e6cc")
                )
                p(nil, 1, y0 - 40, "#f6e6cc")
                p(nil, 0, y0 - 39, "#f6e6cc")
                r(
                    nil,
                    -3,
                    y0 - 44,
                    6,
                    4,
                    "#f08ab4"
                )
                p(nil, -4, y0 - 42, "#f08ab4")
                p(nil, 3, y0 - 42, "#f08ab4")
                olho(
                    nil,
                    -5,
                    y0 - 35,
                    bravo,
                    3,
                    3
                )
                olho(
                    nil,
                    2,
                    y0 - 35,
                    bravo,
                    3,
                    3
                )
                p(
                    nil,
                    -5,
                    y0 - 31,
                    plana(nil, "#f4a0b8")
                )
                p(nil, 5, y0 - 31, "#f4a0b8")
                r(
                    nil,
                    -1,
                    y0 - 31,
                    2,
                    1,
                    plana(nil, "#a04060")
                )
            end,
            bombardiro = function(self, f, bravo)
                local y0 = -26 + __get(
                    __arrL({
                        0,
                        0,
                        -1,
                        -1,
                        -2,
                        -2,
                        -1,
                        -1
                    }, 8),
                    f
                )
                local pa = __mod(f, 2)
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-13, y0 - 1}, 2),
                            __arrL({-19, y0 - 10}, 2),
                            __arrL({-15, y0 - 10}, 2),
                            __arrL({-9, y0 - 3}, 2)
                        },
                        4
                    ),
                    "#7a848c"
                )
                r(
                    nil,
                    -17,
                    y0 - 9,
                    2,
                    2,
                    plana(nil, "#c43c3a")
                )
                e(
                    nil,
                    -2,
                    y0,
                    14,
                    4,
                    "#8a949c"
                )
                r(
                    nil,
                    -14,
                    y0 - 1,
                    6,
                    2,
                    "#5a9a3a"
                )
                do
                    local k = -10
                    while k <= 6 do
                        p(nil, k, y0 - 4, "#3a7a2a")
                        k = k + 3
                    end
                end
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({8, y0 - 4}, 2),
                            __arrL({24, y0 - 2}, 2),
                            __arrL({24, y0 + 2}, 2),
                            __arrL({8, y0 + 4}, 2)
                        },
                        4
                    ),
                    "#5a9a3a"
                )
                r(
                    nil,
                    9,
                    y0 + 1,
                    15,
                    1,
                    "#3a6a2a"
                )
                do
                    local k = 0
                    while k < 6 do
                        p(
                            nil,
                            11 + k * 2,
                            y0 + if __t(__band(k, 1)) then 0 else 2,
                            plana(nil, "#f6f6e8")
                        )
                        k = k + 1
                    end
                end
                p(
                    nil,
                    23,
                    y0 - 2,
                    plana(nil, PRETO)
                )
                e(
                    nil,
                    9,
                    y0 - 5,
                    3,
                    2,
                    "#5a9a3a"
                )
                olho(
                    nil,
                    8,
                    y0 - 7,
                    bravo,
                    3,
                    3
                )
                e(
                    nil,
                    -2,
                    y0 + 1,
                    2,
                    2,
                    plana(nil, "#f6f6e8")
                )
                p(
                    nil,
                    -2,
                    y0 + 1,
                    plana(nil, "#3a6ab8")
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-4, y0 + 1}, 2),
                            __arrL({5, y0 + 1}, 2),
                            __arrL({-3, y0 + 10}, 2),
                            __arrL({-11, y0 + 10}, 2)
                        },
                        4
                    ),
                    "#6e7880"
                )
                r(
                    nil,
                    -9,
                    y0 + 8,
                    6,
                    1,
                    "#c43c3a"
                )
                r(
                    nil,
                    -4,
                    y0 + 5,
                    4,
                    3,
                    "#4a5056"
                )
                if __t(pa) then
                    r(
                        nil,
                        -3,
                        y0 + 1,
                        1,
                        11,
                        plana(nil, "#d8dce0")
                    )
                else
                    r(
                        nil,
                        -8,
                        y0 + 6,
                        11,
                        1,
                        plana(nil, "#d8dce0")
                    )
                end
                e(
                    nil,
                    6,
                    y0 + 9,
                    3,
                    2,
                    "#3a3f44"
                )
                r(
                    nil,
                    1,
                    y0 + 8,
                    2,
                    3,
                    "#4a5056"
                )
                r(
                    nil,
                    5,
                    y0 + 5,
                    1,
                    2,
                    "#4a5056"
                )
                p(
                    nil,
                    7,
                    y0 + 8,
                    plana(nil, "#c43c3a")
                )
            end,
            chimpanzini = function(self, f, bravo)
                local y0 = __TS__Number(-__get(
                    __arrL({
                        0,
                        1,
                        2,
                        2,
                        1,
                        0,
                        0,
                        0
                    }, 8),
                    f
                ))
                local abre = __get(
                    __arrL({
                        0.15,
                        0.3,
                        0.55,
                        0.8,
                        0.9,
                        0.8,
                        0.55,
                        0.3
                    }, 8),
                    f
                )
                r(
                    nil,
                    -4,
                    y0 - 3,
                    3,
                    3,
                    "#6a3e1e"
                )
                r(
                    nil,
                    1,
                    y0 - 3,
                    3,
                    3,
                    "#6a3e1e"
                )
                e(
                    nil,
                    0,
                    y0 - 15,
                    7,
                    12,
                    "#f2cc3a"
                )
                r(
                    nil,
                    -1,
                    y0 - 30,
                    2,
                    3,
                    "#6a4a1a"
                )
                p(nil, -1, y0 - 31, "#4a3010")
                e(
                    nil,
                    0,
                    y0 - 18,
                    6,
                    6,
                    "#7a4a26"
                )
                e(
                    nil,
                    0,
                    y0 - 16,
                    4,
                    4,
                    "#ecc896"
                )
                r(
                    nil,
                    -8,
                    y0 - 19,
                    2,
                    3,
                    "#7a4a26"
                )
                r(
                    nil,
                    7,
                    y0 - 19,
                    2,
                    3,
                    "#7a4a26"
                )
                olho(
                    nil,
                    -3,
                    y0 - 19,
                    bravo,
                    2,
                    3
                )
                olho(
                    nil,
                    1,
                    y0 - 19,
                    bravo,
                    2,
                    3
                )
                p(
                    nil,
                    -1,
                    y0 - 15,
                    plana(nil, "#5a3018")
                )
                p(nil, 0, y0 - 15, "#5a3018")
                r(
                    nil,
                    -2,
                    y0 - 13,
                    4,
                    1,
                    "#5a3018"
                )
                for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                    local ang = -math.pi / 2 + lado * abre
                    barra(
                        nil,
                        lado * 4,
                        y0 - 4,
                        ang,
                        22,
                        5,
                        3,
                        "#f2cc3a"
                    )
                    barra(
                        nil,
                        lado * 3,
                        y0 - 4,
                        ang,
                        18,
                        1,
                        1,
                        "#fff0a0"
                    )
                end
            end,
            patapim = function(self, f, bravo)
                local a = f / N * TAU
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL(
                            {
                                -1,
                                math.sin(a)
                            },
                            2
                        ),
                        __arrL(
                            {
                                1,
                                -math.sin(a)
                            },
                            2
                        )
                    },
                    2
                ))) do
                    local lado = ____value[1]
                    local fase = ____value[2]
                    local lev = math.max(
                        0,
                        math.floor(fase * 3 + 0.5)
                    )
                    local px = if lado < 0 then -12 else 2
                    r(
                        nil,
                        lado * 5 - 2,
                        -14 - lev,
                        4,
                        11,
                        "#7a4a26"
                    )
                    r(
                        nil,
                        px,
                        -4 - lev,
                        10,
                        4,
                        "#e0a878"
                    )
                    r(
                        nil,
                        px,
                        -1 - lev,
                        10,
                        1,
                        "#b8805a"
                    )
                    p(nil, px + if lado < 0 then 0 else 9, -5 - lev, "#e0a878")
                end
                r(
                    nil,
                    -6,
                    -30,
                    12,
                    17,
                    "#8e5a2e"
                )
                r(
                    nil,
                    -4,
                    -27,
                    1,
                    8,
                    "#6a3e1e"
                )
                r(
                    nil,
                    3,
                    -24,
                    1,
                    9,
                    "#6a3e1e"
                )
                barra(
                    nil,
                    -6,
                    -26,
                    math.pi + 0.5,
                    9,
                    2,
                    1,
                    "#7a4a26"
                )
                barra(
                    nil,
                    6,
                    -25,
                    -0.5,
                    9,
                    2,
                    1,
                    "#7a4a26"
                )
                e(
                    nil,
                    -14,
                    -31,
                    2,
                    2,
                    "#4a9a3a"
                )
                e(
                    nil,
                    14,
                    -30,
                    2,
                    2,
                    "#4a9a3a"
                )
                e(
                    nil,
                    0,
                    -33,
                    7,
                    5,
                    "#e8c098"
                )
                r(
                    nil,
                    -6,
                    -37,
                    5,
                    5,
                    plana(nil, "#3a2018")
                )
                r(
                    nil,
                    0,
                    -37,
                    5,
                    5,
                    "#3a2018"
                )
                olho(
                    nil,
                    -5,
                    -36,
                    bravo,
                    3,
                    3
                )
                olho(
                    nil,
                    1,
                    -36,
                    bravo,
                    3,
                    3
                )
                r(
                    nil,
                    1,
                    -33,
                    9,
                    2,
                    "#d8a878"
                )
                p(nil, 9, -32, "#c08a5a")
                r(
                    nil,
                    -3,
                    -30,
                    4,
                    1,
                    plana(nil, "#6a3018")
                )
                e(
                    nil,
                    0,
                    -43,
                    10,
                    5,
                    "#3a8a3a"
                )
                e(
                    nil,
                    -5,
                    -45,
                    4,
                    3,
                    "#58aa48"
                )
                e(
                    nil,
                    4,
                    -46,
                    4,
                    2,
                    "#58aa48"
                )
                e(
                    nil,
                    8,
                    -42,
                    2,
                    2,
                    "#2e722e"
                )
                e(
                    nil,
                    -9,
                    -41,
                    2,
                    2,
                    "#2e722e"
                )
                p(nil, -2, -39, "#2e722e")
                p(nil, 3, -39, "#2e722e")
            end,
            lirili = function(self, f, bravo)
                local a = f / N * TAU
                local tr = math.floor(math.sin(a) * 2 + 0.5)
                __call(
                    __arrL({-5, 2}, 2),
                    "forEach",
                    function(____, lx, k)
                        local lev = math.max(
                            0,
                            math.floor(math.sin(a + k * math.pi) * 2 + 0.5)
                        )
                        r(
                            nil,
                            lx,
                            -8 - lev,
                            4,
                            7,
                            "#4a9a44"
                        )
                        r(
                            nil,
                            lx - 1,
                            -2 - lev,
                            6,
                            2,
                            "#a0603a"
                        )
                        p(nil, lx + 1, -3 - lev, "#a0603a")
                    end
                )
                e(
                    nil,
                    0,
                    -16,
                    8,
                    9,
                    "#4a9a44"
                )
                r(
                    nil,
                    -1,
                    -24,
                    1,
                    16,
                    "#3a7a34"
                )
                r(
                    nil,
                    4,
                    -22,
                    1,
                    12,
                    "#3a7a34"
                )
                r(
                    nil,
                    -5,
                    -21,
                    1,
                    10,
                    "#3a7a34"
                )
                r(
                    nil,
                    -12,
                    -21,
                    3,
                    7,
                    "#4a9a44"
                )
                r(
                    nil,
                    -12,
                    -16,
                    4,
                    2,
                    "#4a9a44"
                )
                r(
                    nil,
                    9,
                    -24,
                    3,
                    7,
                    "#4a9a44"
                )
                r(
                    nil,
                    8,
                    -19,
                    4,
                    2,
                    "#4a9a44"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({-6, -18}, 2),
                        __arrL({-2, -12}, 2),
                        __arrL({3, -19}, 2),
                        __arrL({6, -13}, 2),
                        __arrL({-3, -21}, 2),
                        __arrL({-11, -20}, 2),
                        __arrL({10, -23}, 2),
                        __arrL({1, -9}, 2)
                    },
                    8
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    p(
                        nil,
                        x,
                        y,
                        plana(nil, "#f6f0c8")
                    )
                end
                e(
                    nil,
                    2,
                    -30,
                    7,
                    6,
                    "#9aa0ae"
                )
                e(
                    nil,
                    -5,
                    -30,
                    4,
                    5,
                    "#8a90a0"
                )
                e(
                    nil,
                    -5,
                    -30,
                    2,
                    3,
                    "#e8a0b0"
                )
                olho(
                    nil,
                    3,
                    -33,
                    bravo,
                    3,
                    3
                )
                p(
                    nil,
                    8,
                    -28,
                    plana(nil, "#f6f6e8")
                )
                do
                    local k = 0
                    while k < 7 do
                        r(
                            nil,
                            8 + k + math.floor(math.sin(k * 0.6) * tr * 0.5 + 0.5),
                            -29 + k * 2 + math.floor(k * k * 0.02 * tr + 0.5),
                            3,
                            3,
                            "#9aa0ae"
                        )
                        k = k + 1
                    end
                end
                p(nil, -1, -36, "#e86a8a")
                r(
                    nil,
                    -2,
                    -37,
                    3,
                    1,
                    "#e86a8a"
                )
            end,
            trippi = function(self, f, bravo)
                local y0 = __TS__Number(-__get(
                    __arrL({
                        0,
                        2,
                        3,
                        3,
                        2,
                        0,
                        0,
                        0
                    }, 8),
                    f
                ))
                local fl = __get(
                    __arrL({
                        0,
                        -1,
                        -2,
                        -1,
                        0,
                        1,
                        2,
                        1
                    }, 8),
                    f
                )
                do
                    local k = 0
                    while k < 4 do
                        r(
                            nil,
                            -4 + k * 3,
                            y0 - 6,
                            1,
                            5,
                            "#c85a3a"
                        )
                        k = k + 1
                    end
                end
                __call(
                    __arrL(
                        {
                            __arrL({-11, -17, 6, 5}, 4),
                            __arrL({-6, -12, 6, 5}, 4),
                            __arrL({1, -10, 6, 4}, 4),
                            __arrL({7, -11, 5, 4}, 4)
                        },
                        4
                    ),
                    "forEach",
                    function(____, ____bindingPattern0, k)
                        local ry
                        local rx
                        local y
                        local x
                        x = ____bindingPattern0[1]
                        y = ____bindingPattern0[2]
                        rx = ____bindingPattern0[3]
                        ry = ____bindingPattern0[4]
                        return e(
                            nil,
                            x,
                            y0 + y,
                            rx,
                            ry,
                            if __t(__mod(k, 2)) then "#f08a50" else "#f8a06a"
                        )
                    end
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({11, y0 - 12}, 2),
                            __arrL({18, y0 - 17 + fl}, 2),
                            __arrL({17, y0 - 11}, 2),
                            __arrL({18, y0 - 5 + fl}, 2),
                            __arrL({11, y0 - 9}, 2)
                        },
                        5
                    ),
                    "#e86a3a"
                )
                e(
                    nil,
                    -13,
                    y0 - 26,
                    7,
                    6,
                    "#d8d0c8"
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-20, y0 - 29}, 2),
                            __arrL({-18, y0 - 36}, 2),
                            __arrL({-15, y0 - 31}, 2)
                        },
                        3
                    ),
                    "#d8d0c8"
                )
                poly(
                    nil,
                    __arrL(
                        {
                            __arrL({-11, y0 - 31}, 2),
                            __arrL({-8, y0 - 36}, 2),
                            __arrL({-6, y0 - 29}, 2)
                        },
                        3
                    ),
                    "#d8d0c8"
                )
                p(
                    nil,
                    -18,
                    y0 - 33,
                    plana(nil, "#f2a0b0")
                )
                p(nil, -8, y0 - 33, "#f2a0b0")
                olho(
                    nil,
                    -17,
                    y0 - 28,
                    bravo,
                    3,
                    3
                )
                olho(
                    nil,
                    -11,
                    y0 - 28,
                    bravo,
                    3,
                    3
                )
                p(
                    nil,
                    -13,
                    y0 - 24,
                    plana(nil, "#e87890")
                )
                r(
                    nil,
                    -14,
                    y0 - 23,
                    3,
                    1,
                    plana(nil, "#5a3a3a")
                )
                r(
                    nil,
                    -23,
                    y0 - 24,
                    5,
                    1,
                    plana(nil, "#5a5a5a")
                )
                r(
                    nil,
                    -7,
                    y0 - 24,
                    5,
                    1,
                    "#5a5a5a"
                )
                r(
                    nil,
                    -22,
                    y0 - 22,
                    4,
                    1,
                    "#5a5a5a"
                )
                r(
                    nil,
                    -7,
                    y0 - 22,
                    4,
                    1,
                    "#5a5a5a"
                )
            end
        },
        "tralalero,tungTung,ballerina,bombardiro,chimpanzini,patapim,lirili,trippi"
    )
    local cache = __TS__New(Map)
    local function quadro(self, nome, f, bravo)
        local chave = __add(
            __add(nome, f),
            if __t(bravo) then "b" else ""
        )
        local q = __call(cache, "get", chave)
        if __t(q) then
            return q
        end
        local cv = window.document:createElement("canvas")
        cv.width = W
        cv.height = H
        g = cv:getContext("2d", {willReadFrequently = true})
        planas = __TS__New(
            Set,
            __arrL({BRANCO, PRETO}, 2)
        )
        do
            local function ____catch(err)
                do
                    pcall(function()
                        print("brainrot", nome, err)
                    end)
                end
            end
            local ____try, ____hasReturned = pcall(function()
                __get(SPRITES, nome)(nil, f, bravo)
                acabamento(nil, cv)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        local branco = window.document:createElement("canvas")
        branco.width = W
        branco.height = H
        local b = branco:getContext("2d")
        b:drawImage(cv, 0, 0)
        b.globalCompositeOperation = "source-in"
        b.fillStyle = "#f6ecff"
        b:fillRect(0, 0, W, H)
        q = {cv = cv, branco = branco}
        __call(cache, "set", chave, q)
        g = nil
        return q
    end
    local VOA = {bombardiro = true}
    local function pintar(self, ctx, nome, x, y, t, o)
        if o == nil then
            o = {}
        end
        local f = __mod(
            __mod(
                math.floor(if __t(t) then t else 0 * 9),
                N
            ) + N,
            N
        )
        local q = quadro(
            nil,
            nome,
            f,
            not not __t(o.angry)
        )
        ctx:save()
        ctx:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local a0 = ctx.globalAlpha
        local sw = if __t(__get(VOA, nome)) then 12 else 16
        ctx.globalAlpha = a0 * if __t(__get(VOA, nome)) then 0.18 else 0.28
        ctx.fillStyle = "#2a0f3a"
        ctx:fillRect(-sw, -2, sw * 2, 4)
        ctx:fillRect(-sw + 4, -4, sw * 2 - 8, 2)
        ctx.globalAlpha = a0
        if __lt(o.facing, 0) then
            ctx:scale(-1, 1)
        end
        local suave = ctx.imageSmoothingEnabled
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            q.cv,
            -AX * S,
            -AY * S,
            W * S,
            H * S
        )
        if __t(if __t(o.hit) then __mod(
            math.floor(if __t(t) then t else 0 * 18),
            2
        ) == 0 else o.hit) then
            ctx.globalAlpha = a0 * 0.85
            ctx:drawImage(
                q.branco,
                -AX * S,
                -AY * S,
                W * S,
                H * S
            )
        end
        ctx.imageSmoothingEnabled = suave
        ctx:restore()
    end
    local DESENHOS = __ord({
        brainrot = "tralalero",
        sixseven = "tungTung",
        spindle = "ballerina",
        wobbler = "bombardiro",
        pasta = "chimpanzini"
    }, "brainrot,sixseven,spindle,wobbler,pasta")
    local RABISCOS = __arrL({"patapim", "lirili", "trippi"}, 3)
    local function desenhar(self, ctx, x, y, kind, t, o)
        if kind == nil then
            kind = 0
        end
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        local ____t_28 = __t
        local ____t_26 = __t
        local ____temp_25 = if __t(o.design) then o.design else o.variant
        __O[686] = ____temp_25
        local ____temp_27 = if ____t_26(____temp_25) then __O[686] else if __t(if __t(o.type) then o.type ~= "doodle" else o.type) then o.type else ""
        __O[687] = ____temp_27
        local design = tostring(if ____t_28(____temp_27) then __O[687] else "")
        local nome = __get(DESENHOS, design)
        local ____t_35 = __t
        local ____t_30 = __t
        local ____temp_29 = not __t(nome)
        __O[690] = ____temp_29
        local ____t_34 = __t
        local ____t_32 = __t
        local ____temp_31 = design == "" or design == "ink"
        __O[688] = ____temp_31
        local ____temp_33 = if ____t_32(____temp_31) then __O[688] else design == "doodle"
        __O[689] = ____temp_33
        if ____t_35(if ____t_30(____temp_29) then if ____t_34(____temp_33) then __O[689] else __re_test(
            __re("^\\d$", ""),
            design
        ) else __O[690]) then
            local ____get_39 = __get
            local ____mod_38 = __mod
            local ____t_37 = __t
            local ____TS__Number_result_36 = __TS__Number(kind)
            __O[691] = ____TS__Number_result_36
            nome = ____get_39(
                RABISCOS,
                ____mod_38(if ____t_37(____TS__Number_result_36) then __O[691] else 0, 3)
            )
        end
        if not __t(nome) then
            return __fcall(
                original,
                window.Art,
                ctx,
                x,
                y,
                kind,
                t,
                o
            )
        end
        local ____pintar_44 = pintar
        local ____array_43 = __TS__SparseArrayNew(
            nil,
            ctx,
            nome,
            x,
            y
        )
        local ____temp_42 = if __t(t) then t else 0
        local ____t_41 = __t
        local ____TS__Number_result_40 = __TS__Number(kind)
        __O[692] = ____TS__Number_result_40
        __TS__SparseArrayPush(____array_43, ____temp_42 + if ____t_41(____TS__Number_result_40) then __O[692] else 0 * 0.37, o)
        ____pintar_44(__TS__SparseArraySpread(____array_43))
    end
    window.Art.drawMinion = desenhar
    window.Art.drawBrainrot = function(____, ctx, nome, x, y, t, o)
        if o == nil then
            o = {}
        end
        if __t(__get(SPRITES, nome)) then
            pintar(
                nil,
                ctx,
                nome,
                x,
                y,
                t,
                o
            )
        end
    end
    window.Art.brainrots = __keys(SPRITES)
    window.Art.__brainrots = true
end)(nil)
return ____exports
