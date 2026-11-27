--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __imul, __callq, __mod, __ord, __arrL, __iterar, __t, __get = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__imul, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get
local __set, __arr, __len, __call, __add, __new, __iter, __assign, __arrayFrom, __bor, __band, __bxor = __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__arrayFrom, __JSR.__bor, __JSR.__band, __JSR.__bxor
local __shr, __ushr, __hypot, __re, __re_test, __re_replace = __JSR.__shr, __JSR.__ushr, __JSR.__hypot, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local Map = ____lualib.Map
local ____exports = {}
local __O = {};
(function()
    local Px, zoomPara, limitar, fechar, selecionar, montarLugares, mostrarTrava, mostrarInfo, ir, montarRota, pontoRota, poeira, clique, resize, placaNome, cadeado, loop, ease, easeOut, hash, COR, shade, ui, cv, c, def, aberto, raf, last, tempo, M, cam, anim, sel, info, viagem, previaTimer, faiscas, celular, zCobre, zMin, zMax, centro, travaI, travaAte, rastro
    function Px(self, c)
        local function R(____, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                math.floor(w + 0.5),
                math.floor(h + 0.5)
            )
        end
        local function circ(____, cx, cy, r, col, ry)
            if ry == nil then
                ry = r
            end
            c.fillStyle = col
            do
                local y = __TS__Number(-ry)
                while __le(y, ry) do
                    local w = math.floor(r * math.sqrt(math.max(0, 1 - y / ry * (y / ry))) + 0.5)
                    c:fillRect(
                        math.floor(cx - w + 0.5),
                        math.floor(cy + y + 0.5),
                        w * 2 + 1,
                        1
                    )
                    y = y + 1
                end
            end
        end
        local P
        P = {
            c = c,
            R = R,
            circ = circ,
            sombra = function(____, cx, cy, rx, ry, a)
                if a == nil then
                    a = 0.22
                end
                c.globalAlpha = a
                circ(
                    nil,
                    cx,
                    cy,
                    rx,
                    "#0c1a10",
                    ry
                )
                c.globalAlpha = 1
            end,
            arvore = function(____, cx, by, s, tipo, seed)
                if s == nil then
                    s = 1
                end
                if tipo == nil then
                    tipo = "verde"
                end
                if seed == nil then
                    seed = 0
                end
                local ____t_1 = __t
                local ____get_result_0 = __get(
                    {
                        verde = __arrL({
                            "#24501f",
                            "#3a7f2e",
                            "#55a23a",
                            "#79c44c",
                            "#b0e27a"
                        }, 5),
                        escura = __arrL({
                            "#1c3c1a",
                            "#2a6228",
                            "#3a7f2e",
                            "#55a23a",
                            "#86c95a"
                        }, 5),
                        roxa = __arrL({
                            "#3e2250",
                            "#6e3490",
                            "#9a52c0",
                            "#c084de",
                            "#ecc8f8"
                        }, 5),
                        amarela = __arrL({
                            "#5a420c",
                            "#a8841a",
                            "#d8b026",
                            "#f2d448",
                            "#fff4a0"
                        }, 5),
                        laranja = __arrL({
                            "#4a220c",
                            "#9a4818",
                            "#d0722a",
                            "#ee9c48",
                            "#ffd08a"
                        }, 5),
                        rosa = __arrL({
                            "#5a2240",
                            "#a84478",
                            "#d86aa0",
                            "#f09ac0",
                            "#ffd8ea"
                        }, 5)
                    },
                    tipo
                )
                __O[504] = ____get_result_0
                local pal = if ____t_1(____get_result_0) then __O[504] else __arrL({
                    "#24501f",
                    "#3a7f2e",
                    "#55a23a",
                    "#79c44c",
                    "#b0e27a"
                }, 5)
                local r = math.max(
                    5,
                    math.floor(9 * s + 0.5)
                )
                local cy = by - math.floor(8 * s + 0.5) - r * 0.8
                P:sombra(
                    cx + 4,
                    by,
                    r + 4,
                    math.floor(r * 0.42 + 0.5) + 1,
                    0.26
                )
                R(
                    nil,
                    cx - 2,
                    by - 9 * s,
                    5,
                    9 * s,
                    "#5a3820"
                )
                R(
                    nil,
                    cx - 1,
                    by - 9 * s,
                    2,
                    9 * s,
                    "#8a5a36"
                )
                R(
                    nil,
                    cx - 4,
                    by - 2,
                    3,
                    2,
                    "#5a3820"
                )
                R(
                    nil,
                    cx + 2,
                    by - 2,
                    3,
                    2,
                    "#4a2e18"
                )
                local function j(____, k)
                    return (hash(nil, seed + k, 5) - 0.5) * r * 0.25
                end
                local tufos = __arrL(
                    {
                        __arrL({0, 0, r}, 3),
                        __arrL(
                            {
                                -r * 0.62 + j(nil, 1),
                                r * 0.22,
                                r * 0.66
                            },
                            3
                        ),
                        __arrL(
                            {
                                r * 0.62 + j(nil, 2),
                                r * 0.18,
                                r * 0.64
                            },
                            3
                        ),
                        __arrL(
                            {
                                j(nil, 3),
                                -r * 0.5,
                                r * 0.66
                            },
                            3
                        ),
                        __arrL({-r * 0.3, -r * 0.1, r * 0.6}, 3)
                    },
                    5
                )
                for ____, ____value in __iterar((tufos)) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    local rr = ____value[3]
                    circ(
                        nil,
                        cx + dx,
                        cy + dy + 1,
                        rr + 1,
                        __get(pal, 0)
                    )
                end
                for ____, ____value in __iterar((tufos)) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    local rr = ____value[3]
                    circ(
                        nil,
                        cx + dx,
                        cy + dy,
                        rr,
                        __get(pal, 1)
                    )
                end
                for ____, ____value in __iterar((tufos)) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    local rr = ____value[3]
                    circ(
                        nil,
                        cx + dx - rr * 0.2,
                        cy + dy - rr * 0.25,
                        rr * 0.7,
                        __get(pal, 2)
                    )
                end
                for ____, ____value in __iterar((tufos)) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    local rr = ____value[3]
                    circ(
                        nil,
                        cx + dx - rr * 0.38,
                        cy + dy - rr * 0.45,
                        math.max(1, rr * 0.32),
                        __get(pal, 3)
                    )
                end
                do
                    local k = 0
                    while k < 7 * s do
                        local a = hash(nil, seed + k) * 6.28
                        local d = hash(nil, seed * 3 + k) * (r - 2)
                        R(
                            nil,
                            cx + math.cos(a) * d,
                            cy + math.sin(a) * d * 0.8 - 2,
                            2,
                            1,
                            __get(pal, if __mod(k, 3) == 0 then 4 else 3)
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 * s do
                        local a = 0.6 + hash(nil, seed + k * 7) * 1.9
                        local d = r * 0.9
                        R(
                            nil,
                            cx + math.cos(a) * d,
                            cy + math.sin(a) * d * 0.8,
                            2,
                            2,
                            __get(pal, 0)
                        )
                        k = k + 1
                    end
                end
            end,
            pinheiro = function(____, cx, by, s, seed)
                if s == nil then
                    s = 1
                end
                if seed == nil then
                    seed = 0
                end
                P:sombra(
                    cx + 4,
                    by,
                    9 * s,
                    3,
                    0.26
                )
                R(
                    nil,
                    cx - 1,
                    by - 6 * s,
                    3,
                    6 * s,
                    "#5a3820"
                )
                do
                    local k = 0
                    while k < 4 do
                        local w = (12 - k * 2.6) * s
                        local y = by - 5 * s - k * 6 * s
                        do
                            local q = 0
                            while q < 7 * s do
                                local ww = w * (q / (7 * s))
                                R(
                                    nil,
                                    cx - ww,
                                    y - 7 * s + q,
                                    ww * 2 + 1,
                                    1,
                                    if q == math.floor(7 * s) - 1 then "#1c3c1a" else if q < 2 then "#3a7f2e" else "#2a6228"
                                )
                                q = q + 1
                            end
                        end
                        R(
                            nil,
                            cx - w * 0.5,
                            y - 3 * s,
                            2,
                            1,
                            "#55a23a"
                        )
                        k = k + 1
                    end
                end
            end,
            eucalipto = function(____, cx, by, s, seed)
                if s == nil then
                    s = 1
                end
                if seed == nil then
                    seed = 0
                end
                P:sombra(
                    cx + 4,
                    by,
                    8 * s,
                    3,
                    0.24
                )
                R(
                    nil,
                    cx - 1,
                    by - 22 * s,
                    3,
                    22 * s,
                    "#d8cfc0"
                )
                R(
                    nil,
                    cx,
                    by - 22 * s,
                    1,
                    22 * s,
                    "#f2ece2"
                )
                R(
                    nil,
                    cx - 1,
                    by - 10 * s,
                    3,
                    2,
                    "#a89a88"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({0, -28, 6}, 3),
                        __arrL({-5, -22, 5}, 3),
                        __arrL({5, -21, 5}, 3),
                        __arrL({0, -17, 4}, 3)
                    },
                    4
                ))) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    local rr = ____value[3]
                    circ(
                        nil,
                        cx + dx * s,
                        by + dy * s,
                        rr * s + 1,
                        "#3a5a3a"
                    )
                    circ(
                        nil,
                        cx + dx * s,
                        by + dy * s,
                        rr * s,
                        "#5a8a5a"
                    )
                    circ(
                        nil,
                        cx + dx * s - 1,
                        by + dy * s - 1,
                        rr * s * 0.5,
                        "#8ab48a"
                    )
                end
            end,
            cacaueiro = function(____, cx, by, s, seed)
                if s == nil then
                    s = 1
                end
                if seed == nil then
                    seed = 0
                end
                P:arvore(
                    cx,
                    by,
                    0.8 * s,
                    "escura",
                    seed
                )
                do
                    local k = 0
                    while k < 3 do
                        local x = cx - 5 + k * 4 + math.floor(hash(nil, seed, k) * 2 + 0.5)
                        local y = by - 6 - __mod(k, 2) * 3
                        R(
                            nil,
                            x,
                            y,
                            3,
                            4,
                            __get(
                                __arrL({"#f2a03a", "#e8c24c", "#c8542a"}, 3),
                                __mod(k + seed, 3)
                            )
                        )
                        R(
                            nil,
                            x,
                            y,
                            1,
                            4,
                            "#ffffff44"
                        )
                        k = k + 1
                    end
                end
            end,
            mamoeiro = function(____, cx, by, s)
                if s == nil then
                    s = 1
                end
                P:sombra(cx + 3, by, 6, 2)
                R(
                    nil,
                    cx - 1,
                    by - 20,
                    2,
                    20,
                    "#9a8a6a"
                )
                do
                    local a = 0
                    while a < 6 do
                        local an = a / 6 * math.pi * 2
                        do
                            local k = 0
                            while k < 8 do
                                R(
                                    nil,
                                    cx + math.cos(an) * k,
                                    by - 21 + math.sin(an) * k * 0.5 + k * k * 0.05,
                                    2,
                                    2,
                                    if k > 5 then "#3a7f2e" else "#58a83c"
                                )
                                k = k + 1
                            end
                        end
                        a = a + 1
                    end
                end
                R(
                    nil,
                    cx - 3,
                    by - 18,
                    3,
                    4,
                    "#f2a03a"
                )
                R(
                    nil,
                    cx + 1,
                    by - 17,
                    3,
                    4,
                    "#e8c24c"
                )
                R(
                    nil,
                    cx - 1,
                    by - 15,
                    3,
                    4,
                    "#58a83c"
                )
            end,
            coqueiro = function(____, cx, by)
                P:sombra(cx + 4, by, 9, 3)
                do
                    local k = 0
                    while k < 22 do
                        R(
                            nil,
                            cx + math.sin(k * 0.12) * 3,
                            by - k,
                            3,
                            1,
                            if __t(__mod(k, 3)) then "#9a7040" else "#7a5228"
                        )
                        k = k + 1
                    end
                end
                local tx = cx + math.sin(22 * 0.12) * 3 + 1
                local ty = by - 22
                do
                    local a = 0
                    while a < 6 do
                        local an = a / 6 * math.pi * 2 + 0.3
                        do
                            local k = 0
                            while k < 9 do
                                R(
                                    nil,
                                    tx + math.cos(an) * k,
                                    ty + math.sin(an) * k * 0.55 + k * k * 0.04,
                                    2,
                                    2,
                                    if k > 6 then "#3f8a30" else "#58a83c"
                                )
                                k = k + 1
                            end
                        end
                        a = a + 1
                    end
                end
                R(
                    nil,
                    tx - 2,
                    ty,
                    4,
                    3,
                    "#7a5228"
                )
            end,
            arbusto = function(____, cx, by, seed, flor)
                if seed == nil then
                    seed = 0
                end
                P:sombra(cx + 1, by, 7, 2)
                circ(
                    nil,
                    cx,
                    by - 4,
                    6,
                    "#2f5e26",
                    4
                )
                circ(
                    nil,
                    cx,
                    by - 4,
                    5,
                    "#3f8a30",
                    3
                )
                circ(
                    nil,
                    cx - 1,
                    by - 5,
                    3,
                    "#58a83c",
                    2
                )
                if __t(flor) then
                    do
                        local k = 0
                        while k < 4 do
                            R(
                                nil,
                                cx - 4 + hash(nil, seed + k) * 8,
                                by - 7 + hash(nil, seed * 2 + k) * 4,
                                2,
                                2,
                                flor
                            )
                            k = k + 1
                        end
                    end
                end
            end,
            pedra = function(____, cx, by)
                P:sombra(cx + 1, by, 6, 2)
                circ(
                    nil,
                    cx,
                    by - 3,
                    5,
                    "#5a6066",
                    3
                )
                circ(
                    nil,
                    cx,
                    by - 3,
                    4,
                    "#8a9096",
                    2
                )
                R(
                    nil,
                    cx - 2,
                    by - 5,
                    3,
                    1,
                    "#c8ccd0"
                )
            end,
            flores = function(____, x, y, cores)
                do
                    local k = 0
                    while k < 6 do
                        local px = x + hash(nil, x + k, y) * 12
                        local py = y + hash(nil, y + k, x) * 8
                        R(
                            nil,
                            px,
                            py + 1,
                            1,
                            2,
                            "#3f8a30"
                        )
                        R(
                            nil,
                            px - 1,
                            py,
                            3,
                            1,
                            __get(
                                cores,
                                __mod(
                                    k,
                                    __len(cores)
                                )
                            )
                        )
                        R(
                            nil,
                            px,
                            py - 1,
                            1,
                            1,
                            __get(
                                cores,
                                __mod(
                                    k,
                                    __len(cores)
                                )
                            )
                        )
                        k = k + 1
                    end
                end
            end,
            cercaH = function(____, x, y, w)
                do
                    local k = 0
                    while __le(k, w) do
                        R(
                            nil,
                            x + k,
                            y - 9,
                            3,
                            10,
                            "#7a4426"
                        )
                        R(
                            nil,
                            x + k,
                            y - 9,
                            3,
                            1,
                            "#c8844a"
                        )
                        k = k + 8
                    end
                end
                R(
                    nil,
                    x,
                    y - 7,
                    w + 3,
                    2,
                    "#a8643a"
                )
                R(
                    nil,
                    x,
                    y - 3,
                    w + 3,
                    2,
                    "#a8643a"
                )
                R(
                    nil,
                    x,
                    y - 7,
                    w + 3,
                    1,
                    "#c8844a"
                )
                R(
                    nil,
                    x,
                    y,
                    w + 3,
                    1,
                    "rgba(0,0,0,.2)"
                )
            end,
            cercaV = function(____, x, y, h)
                do
                    local k = 0
                    while __le(k, h) do
                        R(
                            nil,
                            x,
                            y + k - 9,
                            3,
                            10,
                            "#7a4426"
                        )
                        R(
                            nil,
                            x,
                            y + k - 9,
                            3,
                            1,
                            "#c8844a"
                        )
                        k = k + 8
                    end
                end
                R(
                    nil,
                    x + 1,
                    y - 7,
                    1,
                    h + 4,
                    "#a8643a"
                )
            end,
            banco = function(____, x, y)
                R(
                    nil,
                    x,
                    y - 6,
                    14,
                    3,
                    "#a8643a"
                )
                R(
                    nil,
                    x,
                    y - 6,
                    14,
                    1,
                    "#c8844a"
                )
                R(
                    nil,
                    x,
                    y - 9,
                    14,
                    2,
                    "#8a5030"
                )
                R(
                    nil,
                    x + 1,
                    y - 3,
                    2,
                    3,
                    "#5a3820"
                )
                R(
                    nil,
                    x + 11,
                    y - 3,
                    2,
                    3,
                    "#5a3820"
                )
                R(
                    nil,
                    x,
                    y,
                    14,
                    1,
                    "rgba(0,0,0,.2)"
                )
            end,
            poste = function(____, x, y)
                R(
                    nil,
                    x + 1,
                    y - 18,
                    2,
                    18,
                    "#3a3f44"
                )
                R(
                    nil,
                    x - 1,
                    y - 20,
                    6,
                    3,
                    "#3a3f44"
                )
                R(
                    nil,
                    x,
                    y - 19,
                    4,
                    2,
                    "#fff2b0"
                )
                R(
                    nil,
                    x - 1,
                    y,
                    6,
                    1,
                    "rgba(0,0,0,.25)"
                )
            end,
            placa = function(____, x, y, cor)
                if cor == nil then
                    cor = "#a8643a"
                end
                R(
                    nil,
                    x + 6,
                    y - 6,
                    2,
                    6,
                    "#5a3820"
                )
                R(
                    nil,
                    x,
                    y - 13,
                    14,
                    8,
                    cor
                )
                R(
                    nil,
                    x,
                    y - 13,
                    14,
                    1,
                    "#d8a070"
                )
                R(
                    nil,
                    x + 2,
                    y - 11,
                    10,
                    1,
                    "#f2e2b8"
                )
                R(
                    nil,
                    x + 2,
                    y - 8,
                    7,
                    1,
                    "#f2e2b8"
                )
            end,
            casa = function(____, x, y, w, h, o)
                if o == nil then
                    o = {}
                end
                local tel = if __t(o.telhado) then o.telhado else "#d0683a"
                local par = if __t(o.parede) then o.parede else "#f2e6d4"
                local pH = if __t(o.paredeH) then o.paredeH else 14
                local rH = h - pH
                P:sombra(
                    x + w / 2 + 6,
                    __add(y, h),
                    w / 2 + 4,
                    4,
                    0.25
                )
                c.globalAlpha = 0.18
                R(
                    nil,
                    __add(x, w),
                    y + 6,
                    5,
                    h - 6,
                    "#0c1a10"
                )
                c.globalAlpha = 1
                R(
                    nil,
                    x,
                    y + rH,
                    w,
                    pH,
                    par
                )
                do
                    local k = 0
                    while __lt(k, pH) do
                        R(
                            nil,
                            x,
                            y + rH + k,
                            w,
                            1,
                            shade(nil, par, 0.97)
                        )
                        k = k + 3
                    end
                end
                R(
                    nil,
                    x,
                    __add(y, h) - 2,
                    w,
                    2,
                    shade(nil, par, 0.7)
                )
                R(
                    nil,
                    x,
                    y + rH,
                    2,
                    pH,
                    shade(nil, par, 0.85)
                )
                R(
                    nil,
                    __add(x, w) - 2,
                    y + rH,
                    2,
                    pH,
                    shade(nil, par, 0.8)
                )
                if o.madeira ~= false then
                    R(
                        nil,
                        x,
                        y + rH,
                        w,
                        2,
                        "#7a4a2a"
                    )
                    for ____, px in __iterar((__arrL(
                        {
                            x,
                            __add(x, w) - 3,
                            x + math.floor(w / 2 + 0.5) - 1
                        },
                        3
                    ))) do
                        R(
                            nil,
                            px,
                            y + rH,
                            3,
                            pH - 2,
                            "#7a4a2a"
                        )
                    end
                end
                local ____o_porta_2 = o.porta
                if ____o_porta_2 == nil then
                    ____o_porta_2 = math.floor(w / 2 + 0.5) - 4
                end
                local dx = ____o_porta_2
                R(
                    nil,
                    __add(x, dx),
                    __add(y, h) - 11,
                    8,
                    9,
                    "#5a3220"
                )
                R(
                    nil,
                    __add(x, dx) + 1,
                    __add(y, h) - 10,
                    6,
                    8,
                    "#8a5030"
                )
                R(
                    nil,
                    __add(x, dx) + 5,
                    __add(y, h) - 6,
                    1,
                    1,
                    "#f2c94c"
                )
                R(
                    nil,
                    __add(x, dx) - 1,
                    __add(y, h) - 12,
                    10,
                    1,
                    "#7a4a2a"
                )
                for ____, jx in __iterar((if __t(o.janelas) then o.janelas else __arrL({6, w - 12}, 2))) do
                    if math.abs(jx - dx) < 9 then
                        continue
                    end
                    R(
                        nil,
                        __add(x, jx) - 1,
                        y + rH + 3,
                        8,
                        7,
                        "#7a4a2a"
                    )
                    R(
                        nil,
                        __add(x, jx),
                        y + rH + 4,
                        6,
                        5,
                        "#3a5a8a"
                    )
                    R(
                        nil,
                        __add(x, jx),
                        y + rH + 4,
                        2,
                        2,
                        "#9ac8f0"
                    )
                    R(
                        nil,
                        __add(x, jx) - 1,
                        y + rH + 10,
                        8,
                        2,
                        "#3f8a30"
                    )
                    R(
                        nil,
                        __add(x, jx),
                        y + rH + 9,
                        1,
                        1,
                        "#e86a8a"
                    )
                    R(
                        nil,
                        __add(x, jx) + 4,
                        y + rH + 9,
                        1,
                        1,
                        "#f2c94c"
                    )
                end
                R(
                    nil,
                    x - 2,
                    y,
                    w + 4,
                    rH + 2,
                    shade(nil, tel, 0.55)
                )
                R(
                    nil,
                    x - 1,
                    y,
                    w + 2,
                    rH,
                    tel
                )
                do
                    local k = 2
                    while k < rH do
                        R(
                            nil,
                            x - 1,
                            y + k,
                            w + 2,
                            1,
                            shade(nil, tel, 0.8)
                        )
                        do
                            local j = __mod(k, 2) * 3
                            while __lt(j, w) do
                                R(
                                    nil,
                                    x + j,
                                    y + k - 2,
                                    1,
                                    2,
                                    shade(nil, tel, 0.85)
                                )
                                j = j + 6
                            end
                        end
                        k = k + 3
                    end
                end
                R(
                    nil,
                    x - 1,
                    y,
                    w + 2,
                    2,
                    shade(nil, tel, 1.2)
                )
                R(
                    nil,
                    x - 1,
                    y + rH - 1,
                    w + 2,
                    2,
                    shade(nil, tel, 0.6)
                )
                R(
                    nil,
                    x - 2,
                    y,
                    2,
                    rH + 2,
                    shade(nil, tel, 0.5)
                )
                R(
                    nil,
                    __add(x, w),
                    y,
                    2,
                    rH + 2,
                    shade(nil, tel, 0.5)
                )
                if __t(o.chamine) then
                    R(
                        nil,
                        __add(x, w) - 9,
                        y - 6,
                        6,
                        9,
                        "#8a8e94"
                    )
                    R(
                        nil,
                        __add(x, w) - 9,
                        y - 6,
                        6,
                        2,
                        "#5a5e64"
                    )
                end
            end,
            predio = function(____, x, y, w, h, o)
                if o == nil then
                    o = {}
                end
                local par = if __t(o.parede) then o.parede else "#e8e4dc"
                local topo = if __t(o.topo) then o.topo else "#9aa0a6"
                local fH = if __t(o.fachada) then o.fachada else 22
                local tH = h - fH
                P:sombra(
                    x + w / 2 + 7,
                    __add(y, h),
                    w / 2 + 5,
                    5,
                    0.25
                )
                c.globalAlpha = 0.18
                R(
                    nil,
                    __add(x, w),
                    y + 4,
                    6,
                    h - 4,
                    "#0c1a10"
                )
                c.globalAlpha = 1
                R(
                    nil,
                    x,
                    y,
                    w,
                    tH,
                    topo
                )
                R(
                    nil,
                    x,
                    y,
                    w,
                    2,
                    shade(nil, topo, 1.2)
                )
                R(
                    nil,
                    x,
                    y + tH - 2,
                    w,
                    2,
                    shade(nil, topo, 0.75)
                )
                R(
                    nil,
                    x + 2,
                    y + 2,
                    w - 4,
                    tH - 5,
                    shade(nil, topo, 1.05)
                )
                do
                    local k = 0
                    while k < w * tH / 40 do
                        R(
                            nil,
                            x + 3 + hash(nil, x + k, y) * (w - 6),
                            y + 3 + hash(nil, y + k, x) * (tH - 6),
                            1,
                            1,
                            shade(nil, topo, 0.9)
                        )
                        k = k + 1
                    end
                end
                if __t(o.caixa ~= false and __gt(w, 20)) then
                    R(
                        nil,
                        __add(x, w) - 14,
                        y + 3,
                        9,
                        7,
                        "#3c6aa8"
                    )
                    R(
                        nil,
                        __add(x, w) - 14,
                        y + 3,
                        9,
                        2,
                        "#6a9ad0"
                    )
                    R(
                        nil,
                        x + 5,
                        y + 4,
                        7,
                        4,
                        "#d8dcdc"
                    )
                    R(
                        nil,
                        x + 5,
                        y + 4,
                        7,
                        1,
                        "#f2f4f4"
                    )
                end
                R(
                    nil,
                    x,
                    y + tH,
                    w,
                    fH,
                    par
                )
                R(
                    nil,
                    x,
                    y + tH,
                    2,
                    fH,
                    shade(nil, par, 0.85)
                )
                R(
                    nil,
                    __add(x, w) - 2,
                    y + tH,
                    2,
                    fH,
                    shade(nil, par, 0.78)
                )
                R(
                    nil,
                    x,
                    __add(y, h) - 2,
                    w,
                    2,
                    shade(nil, par, 0.65)
                )
                if __t(o.faixa) then
                    R(
                        nil,
                        x,
                        y + tH,
                        w,
                        3,
                        o.faixa
                    )
                end
                do
                    local ry = y + tH + 5
                    while __lt(
                        ry,
                        __add(y, h) - 8
                    ) do
                        do
                            local jx = x + 4
                            while __lt(
                                jx,
                                __add(x, w) - 6
                            ) do
                                R(
                                    nil,
                                    jx,
                                    ry,
                                    4,
                                    4,
                                    "#3a5a8a"
                                )
                                R(
                                    nil,
                                    jx,
                                    ry,
                                    1,
                                    1,
                                    "#9ac8f0"
                                )
                                jx = jx + 7
                            end
                        end
                        ry = ry + 7
                    end
                end
                if o.porta ~= false then
                    local dx = x + math.floor(w / 2 + 0.5) - 5
                    R(
                        nil,
                        dx,
                        __add(y, h) - 10,
                        10,
                        8,
                        "#2a3a4a"
                    )
                    R(
                        nil,
                        dx + 1,
                        __add(y, h) - 9,
                        4,
                        7,
                        "#7ab0d0"
                    )
                    R(
                        nil,
                        dx + 5,
                        __add(y, h) - 9,
                        4,
                        7,
                        "#7ab0d0"
                    )
                end
            end,
            fonte = function(____, cx, cy)
                P:sombra(cx + 2, cy + 6, 16, 5)
                circ(
                    nil,
                    cx,
                    cy + 2,
                    15,
                    "#7a8086",
                    7
                )
                circ(
                    nil,
                    cx,
                    cy,
                    14,
                    "#a8aeb4",
                    6
                )
                circ(
                    nil,
                    cx,
                    cy,
                    11,
                    COR.agua,
                    4
                )
                circ(
                    nil,
                    cx - 2,
                    cy - 1,
                    6,
                    COR.aguaC,
                    2
                )
                R(
                    nil,
                    cx - 2,
                    cy - 10,
                    5,
                    10,
                    "#a8aeb4"
                )
                R(
                    nil,
                    cx - 4,
                    cy - 12,
                    9,
                    3,
                    "#c8ccd0"
                )
            end
        }
        return P
    end
    function zoomPara(self, z)
        anim = {
            de = __assign({}, cam),
            para = {
                x = cam.x,
                y = cam.y,
                z = math.max(
                    zMin(nil),
                    math.min(zMax, z)
                )
            },
            t = 0,
            dur = 0.35,
            f = easeOut
        }
    end
    function limitar(self)
        local hw = cv.clientWidth / 2 / cam.z
        local hh = cv.clientHeight / 2 / cam.z
        local p = if __t(M.PAD) then M.PAD else 0
        local x0 = __TS__Number(-p)
        local x1 = __add(M.W, p)
        local y0 = __TS__Number(-p)
        local y1 = __add(M.H, p)
        cam.x = if hw * 2 >= x1 - x0 then M.W / 2 else math.max(
            x0 + hw,
            math.min(x1 - hw, cam.x)
        )
        cam.y = if hh * 2 >= y1 - y0 then M.H / 2 else math.max(
            y0 + hh,
            math.min(y1 - hh, cam.y)
        )
    end
    function fechar(self)
        if not __t(aberto) then
            return
        end
        aberto = false
        ui.classList:remove("on")
        window:setTimeout(
            function()
                if not __t(aberto) then
                    ui.hidden = true
                end
            end,
            360
        )
        window:cancelAnimationFrame(raf)
        window:clearInterval(previaTimer)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_result_230
        if def ~= nil then
            ____opt_result_230 = def.aoFechar
        end
        if ____opt_result_230 ~= nil then
            ____opt_result_230(def)
        end
    end
    function selecionar(self, i)
        if __t(viagem) then
            return
        end
        sel = i
        local pv = ui:querySelector(".pv")
        mostrarInfo(nil, false)
        window:clearInterval(previaTimer)
        local ____mostrarTrava_236 = mostrarTrava
        local ____t_235 = __t
        local ____t_232 = __t
        local ____ge_result_231 = __ge(i, 0)
        __O[592] = ____ge_result_231
        local ____opt_233 = __get(def.locais, i).estado
        if ____opt_233 ~= nil then
            ____opt_233 = ____opt_233.trava
        end
        ____mostrarTrava_236(nil, if ____t_235(if ____t_232(____ge_result_231) then ____opt_233 else __O[592]) then i else -1)
        if __lt(i, 0) then
            ui.classList:remove("ficha-aberta")
            pv.classList:remove("on")
            anim = {
                de = __assign({}, cam),
                para = __assign(
                    {},
                    cam,
                    {z = math.max(
                        zMin(nil),
                        cam.z * 0.75
                    )}
                ),
                t = 0,
                dur = 0.5,
                f = ease
            }
            return
        end
        local L = __get(def.locais, i)
        local ____opt_237 = L.estado
        if ____opt_237 ~= nil then
            ____opt_237 = ____opt_237.ok
        end
        local ok = ____opt_237 ~= false
        local f = centro(nil, i)
        local largo = window.innerWidth > 760
        local cel = celular(nil)
        local lado = if __t(cel) then window.innerWidth > window.innerHeight else cel
        local z = if __t(cel) then math.min(
            zMax,
            math.max(
                zCobre(nil) * 1.4,
                1.6
            )
        ) else math.min(
            zMax,
            math.max(
                zMin(nil) * 2.2,
                3
            )
        )
        anim = {
            de = __assign({}, cam),
            para = {x = f.x + if __t(largo) then 170 / z else if __t(lado) then cv.clientWidth * 0.22 / z else 0, y = f.y + if __t(if __t(largo) then largo else lado) then 0 else if __t(cel) then cv.clientHeight * 0.2 / z else 110 / z, z = z},
            t = 0,
            dur = 0.8,
            f = ease
        }
        __call(ui.classList, "add", "ficha-aberta")
        __get(M.locs, i).pulo = 0
        do
            local k = 0
            while k < 26 do
                local a = math.random() * math.pi * 2
                local v = 30 + math.random() * 70
                __call(
                    faiscas,
                    "push",
                    {
                        x = f.x,
                        y = f.y,
                        vx = math.cos(a) * v,
                        vy = math.sin(a) * v * 0.6 - 50,
                        t = 0,
                        cor = __get(
                            __arrL({"#ffd24a", "#ffffff", "#ffe9a8"}, 3),
                            __mod(k, 3)
                        )
                    }
                )
                k = k + 1
            end
        end
        pv:querySelector("h3").textContent = L.nome
        pv:querySelector(".sub").textContent = if __t(L.sub) then L.sub else ""
        pv:querySelector(".desc").innerHTML = (("<b>" .. tostring(L.nome)) .. "</b>") .. tostring(if __t(L.descricao) then L.descricao else "")
        local ____temp_247 = pv:querySelector(".motivo")
        local ____add_246 = __add
        local ____t_245 = __t
        local ____t_241 = __t
        local ____opt_239 = L.estado
        if ____opt_239 ~= nil then
            ____opt_239 = ____opt_239.motivo
        end
        __O[593] = ____opt_239
        local ____opt_242 = L.estado
        if ____opt_242 ~= nil then
            ____opt_242 = ____opt_242.reason
        end
        local ____temp_244 = if ____t_241(____opt_239) then __O[593] else ____opt_242
        __O[594] = ____temp_244
        ____temp_247.textContent = if __t(ok) then "" else ____add_246("🔒 ", if ____t_245(____temp_244) then __O[594] else "Ainda não dá para ir.")
        local bt = pv:querySelector(".ir")
        bt.disabled = not __t(ok) or not not __t(L.atual)
        local ____t_250 = __t
        local ____opt_248 = L.estado
        if ____opt_248 ~= nil then
            ____opt_248 = ____opt_248.trava
        end
        bt.textContent = if __t(L.atual) then "VOCÊ ESTÁ AQUI" else if __t(ok) then if __t(def.botao) then def.botao else "IR PARA LÁ ▶" else if ____t_250(____opt_248) then "🔒 TRANCADO" else "BLOQUEADO"
        pv.classList:remove("on")
        local ____ = pv.offsetWidth
        __call(pv.classList, "add", "on")
        local prev = pv:querySelector("canvas.prev")
        local pc = prev:getContext("2d")
        pc.imageSmoothingEnabled = false
        local function desenha()
            do
                pcall(function()
                    local ____opt_251 = L.previa
                    if ____opt_251 ~= nil then
                        ____opt_251(
                            L,
                            pc,
                            prev.width,
                            prev.height,
                            window.performance:now() / 1000
                        )
                    end
                end)
            end
            if not __t(ok) then
                pc.fillStyle = "rgba(10,8,6,.55)"
                pc:fillRect(0, 0, prev.width, prev.height)
            end
            local ____t_255 = __t
            local ____opt_253 = L.estado
            if ____opt_253 ~= nil then
                ____opt_253 = ____opt_253.trava
            end
            if ____t_255(____opt_253) then
                cadeado(
                    nil,
                    prev.width / 2,
                    prev.height / 2 + 34,
                    4,
                    0,
                    pc
                )
            end
        end
        desenha(nil)
        previaTimer = window:setInterval(desenha, 120)
    end
    function montarLugares(self)
        local el = ui:querySelector(".lugares")
        el.innerHTML = ""
        ui.classList:remove("ficha-aberta")
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local b = window.document:createElement("button")
                b.type = "button"
                local ____opt_256 = L.estado
                if ____opt_256 ~= nil then
                    ____opt_256 = ____opt_256.ok
                end
                local bloq = ____opt_256 == false
                b.className = if __t(bloq) then "bloq" else if __t(L.atual) then "atual" else ""
                b.textContent = __add(if __t(L.atual) then "● " else if __t(bloq) then "🔒 " else "", L.nome)
                b:addEventListener(
                    "click",
                    function() return selecionar(nil, i) end
                )
                el:appendChild(b)
            end
        )
    end
    function mostrarTrava(self, i)
        local ____opt_result_260
        if ui ~= nil then
            ____opt_result_260 = ui:querySelector(".trava")
        end
        local el = ____opt_result_260
        if not __t(el) then
            return
        end
        travaI = i
        el.classList:remove("on")
        if __lt(i, 0) then
            return
        end
        local T = __get(def.locais, i).estado.trava
        el:querySelector(".t").textContent = if __t(T.titulo) then T.titulo else "PRECISA DERROTAR"
        el:querySelector(".n").innerHTML = __call(
            __call(
                if __t(T.nomes) then T.nomes else __arrL({}, 0),
                "map",
                function(____, n) return __re_replace(
                    tostring(n),
                    __re("[<>&]", "g"),
                    ""
                ) end
            ),
            "join",
            "<br>"
        )
        el:querySelector("small").textContent = if __t(T.texto) then T.texto else ""
        local ____ = el.offsetWidth
        __call(el.classList, "add", "on")
        travaAte = tempo + 5.5
        __get(M.locs, i).tremor = 1
    end
    function mostrarInfo(self, v)
        info = not not __t(v)
        local ____opt_result_265
        if ui ~= nil then
            ____opt_result_265 = ui:querySelector(".desc")
        end
        if ____opt_result_265 ~= nil then
            ____opt_result_265.classList:toggle("on", info)
        end
    end
    function ir(self)
        local ____t_268 = __t
        local ____t_267 = __t
        local ____temp_266 = sel < 0
        __O[595] = ____temp_266
        if ____t_268(if ____t_267(____temp_266) then __O[595] else viagem) then
            return
        end
        local L = __get(def.locais, sel)
        local ____t_273 = __t
        local ____t_272 = __t
        local ____opt_269 = L.estado
        if ____opt_269 ~= nil then
            ____opt_269 = ____opt_269.ok
        end
        local ____temp_271 = ____opt_269 == false
        __O[596] = ____temp_271
        if ____t_273(if ____t_272(____temp_271) then __O[596] else L.atual) then
            return
        end
        local ai = __call(
            def.locais,
            "findIndex",
            function(____, q) return q.atual end
        )
        local para = centro(nil, sel)
        local de = if __ge(ai, 0) then centro(nil, ai) else {x = para.x - 200, y = para.y + 120}
        local rota = montarRota(nil, de, para)
        local dur = math.max(
            2,
            math.min(3.6, 1.5 + rota.total / 420)
        )
        viagem = {
            rota = rota,
            t = -0.38,
            dur = dur,
            id = L.id,
            dir = if __ge(para.x, de.x) then 1 else -1,
            ang = 0,
            roda = 0,
            emit = 0,
            ant = nil,
            spd = 0,
            pousou = false,
            sq = 0,
            treme = 0
        }
        rastro = __arrL({}, 0)
        ui:querySelector(".pv").classList:remove("on")
        window:clearInterval(previaTimer)
        anim = nil
        poeira(
            nil,
            de.x,
            de.y,
            10,
            "#d8c8a8"
        )
    end
    function montarRota(self, de, para)
        local pts = __arrL({}, 0)
        local function q(____, a, b, c2, u)
            return {x = (1 - u) * (1 - u) * a.x + 2 * (1 - u) * u * b.x + u * u * c2.x, y = (1 - u) * (1 - u) * a.y + 2 * (1 - u) * u * b.y + u * u * c2.y}
        end
        if __t(def.voa) then
            local b = {
                x = __add(de.x, para.x) / 2,
                y = math.min(de.y, para.y) - 60
            }
            do
                local i = 0
                while i <= 48 do
                    __call(
                        pts,
                        "push",
                        q(
                            nil,
                            de,
                            b,
                            para,
                            i / 48
                        )
                    )
                    i = i + 1
                end
            end
        else
            local b = {x = para.x, y = de.y}
            local l1 = __hypot(b.x - de.x, b.y - de.y)
            local l2 = __hypot(para.x - b.x, para.y - b.y)
            local r = math.min(40, l1 * 0.45, l2 * 0.45)
            if r < 2 then
                __call(
                    pts,
                    "push",
                    de,
                    b,
                    para
                )
            else
                local p1 = {x = b.x - (b.x - de.x) / l1 * r, y = b.y - (b.y - de.y) / l1 * r}
                local p2 = {x = b.x + (para.x - b.x) / l2 * r, y = b.y + (para.y - b.y) / l2 * r}
                __call(pts, "push", de, p1)
                do
                    local i = 1
                    while i < 12 do
                        __call(
                            pts,
                            "push",
                            q(
                                nil,
                                p1,
                                b,
                                p2,
                                i / 12
                            )
                        )
                        i = i + 1
                    end
                end
                __call(pts, "push", p2, para)
            end
        end
        local acc = __arrL({0}, 1)
        do
            local i = 1
            while i < __len(pts) do
                __call(
                    acc,
                    "push",
                    __get(acc, i - 1) + __hypot(
                        __get(pts, i).x - __get(pts, i - 1).x,
                        __get(pts, i).y - __get(pts, i - 1).y
                    )
                )
                i = i + 1
            end
        end
        local ____pts_276 = pts
        local ____acc_277 = acc
        local ____t_275 = __t
        local ____get_result_274 = __get(
            acc,
            __len(acc) - 1
        )
        __O[597] = ____get_result_274
        return {pts = ____pts_276, acc = ____acc_277, total = if ____t_275(____get_result_274) then __O[597] else 1}
    end
    function pontoRota(self, v, u)
        local R = v.rota
        local d = math.max(
            0,
            math.min(1, u)
        ) * R.total
        local i = 1
        while __t(i < __len(R.acc) - 1 and __lt(
            __get(R.acc, i),
            d
        )) do
            i = i + 1
        end
        local a = __get(R.pts, i - 1)
        local ____t_279 = __t
        local ____get_result_278 = __get(R.pts, i)
        __O[598] = ____get_result_278
        local b = if ____t_279(____get_result_278) then __O[598] else a
        local seg = __get(R.acc, i) - __get(R.acc, i - 1)
        local k = if __t(seg) then math.max(
            0,
            math.min(
                1,
                (d - __get(R.acc, i - 1)) / seg
            )
        ) else 1
        return {x = a.x + (b.x - a.x) * k, y = a.y + (b.y - a.y) * k, alt = if __t(def.voa) then 48 * math.sin(math.pi * math.max(
            0,
            math.min(1, u)
        )) ^ 0.55 else 0}
    end
    function poeira(self, x, y, n, cor)
        do
            local k = 0
            while __lt(k, n) do
                local a = k / n * math.pi * 2 + math.random() * 0.4
                local v = 18 + math.random() * 26
                __call(
                    rastro,
                    "push",
                    {
                        x = x,
                        y = y + 2,
                        vx = math.cos(a) * v,
                        vy = math.sin(a) * v * 0.35 - 4,
                        t = 0,
                        vida = 0.55 + math.random() * 0.35,
                        r = 2 + math.random() * 2,
                        cresce = 5,
                        cor = cor,
                        chao = true
                    }
                )
                k = k + 1
            end
        end
    end
    function clique(self, e)
        local r = cv:getBoundingClientRect()
        local p = {x = cam.x + (e.clientX - r.left - r.width / 2) / cam.z, y = cam.y + (e.clientY - r.top - r.height / 2) / cam.z}
        local best = -1
        local bd = 1000000000
        __call(
            M.locs,
            "forEach",
            function(____, L, i)
                local ____t_284 = __t
                local ____t_283 = __t
                local ____t_281 = __t
                local ____temp_280 = p.x > L.bx - 6 and __lt(
                    p.x,
                    __add(L.bx, L.bw) + 6
                )
                __O[599] = ____temp_280
                local ____temp_282 = if ____t_281(____temp_280) then p.y > L.by - 30 else __O[599]
                __O[600] = ____temp_282
                if ____t_284(if ____t_283(____temp_282) then __lt(
                    p.y,
                    __add(L.by, L.bh) + 6
                ) else __O[600]) then
                    local f = centro(nil, i)
                    local d = __hypot(f.x - p.x, f.y - p.y)
                    if d < bd then
                        bd = d
                        best = i
                    end
                end
            end
        )
        if best >= 0 then
            selecionar(nil, best)
        end
    end
    function resize(self)
        local w = cv.clientWidth
        local h = cv.clientHeight
        if __t(cv.width ~= w or cv.height ~= h) then
            cv.width = w
            cv.height = h
        end
    end
    function placaNome(self, x, y, txt, estado, ativo)
        c.font = "10px Pixel, monospace"
        local w = math.ceil(c:measureText(txt).width) + 14
        local h = 18
        local bx = math.floor(x - w / 2 + 0.5)
        local by = math.floor(y - h + 0.5)
        c.fillStyle = "#2a1a10"
        c:fillRect(bx - 2, by - 2, w + 4, h + 4)
        c.fillStyle = if __t(ativo) then "#ffd98a" else if estado == "bloq" then "#5a5048" else if estado == "atual" then "#3a6a8a" else "#a8643a"
        c:fillRect(bx, by, w, h)
        c.fillStyle = "rgba(255,255,255,.25)"
        c:fillRect(bx, by, w, 2)
        c.fillStyle = if __t(ativo) then "#2a1a10" else "#fff6dc"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c:fillText(txt, x, y - h / 2 + 1)
        c.fillStyle = "#2a1a10"
        c:fillRect(
            math.floor(x + 0.5) - 2,
            by + h + 2,
            4,
            5
        )
    end
    function cadeado(self, x, y, k, tremor, cx)
        if cx == nil then
            cx = c
        end
        local c = cx
        x = math.floor(x + if __gt(tremor, 0) then math.sin(tempo * 55) * 4 * tremor else 0 + 0.5)
        y = math.floor(y + 0.5)
        local function P(____, px, py, w, h, col)
            c.fillStyle = col
            c:fillRect(x + px * k, y + py * k, w * k, h * k)
        end
        c:save()
        c.globalAlpha = 0.22 + math.sin(tempo * 4) * 0.08 + tremor * 0.3
        c.fillStyle = "#ff2a2a"
        c:beginPath()
        c:arc(
            x,
            y - 6 * k,
            10 * k,
            0,
            math.pi * 2
        )
        __call(c, "fill")
        c.globalAlpha = 0.35
        c.fillStyle = "#000"
        c:fillRect(
            x - 6 * k,
            __add(y, k),
            12 * k,
            k
        )
        c:restore()
        P(
            nil,
            -4,
            -15,
            8,
            1,
            "#2a0808"
        )
        P(
            nil,
            -5,
            -14,
            1,
            6,
            "#2a0808"
        )
        P(
            nil,
            4,
            -14,
            1,
            6,
            "#2a0808"
        )
        P(
            nil,
            -4,
            -14,
            8,
            1,
            "#dde0e3"
        )
        P(
            nil,
            -4,
            -13,
            2,
            5,
            "#9aa0a6"
        )
        P(
            nil,
            2,
            -13,
            2,
            5,
            "#9aa0a6"
        )
        P(
            nil,
            -4,
            -13,
            1,
            5,
            "#c8ccd0"
        )
        P(
            nil,
            -2,
            -13,
            4,
            1,
            "#2a0808"
        )
        P(
            nil,
            -2,
            -12,
            1,
            4,
            "#2a0808"
        )
        P(
            nil,
            1,
            -12,
            1,
            4,
            "#2a0808"
        )
        P(
            nil,
            -6,
            -9,
            12,
            10,
            "#2a0808"
        )
        P(
            nil,
            -5,
            -8,
            10,
            8,
            "#d83a3a"
        )
        P(
            nil,
            -5,
            -8,
            10,
            1,
            "#ff8a7a"
        )
        P(
            nil,
            -5,
            -7,
            1,
            6,
            "#ff6a5a"
        )
        P(
            nil,
            4,
            -8,
            1,
            8,
            "#a82424"
        )
        P(
            nil,
            -5,
            -1,
            10,
            1,
            "#8a1a1a"
        )
        P(
            nil,
            -3,
            -6,
            1,
            1,
            "#ffb0a0"
        )
        P(
            nil,
            -1,
            -6,
            2,
            2,
            "#2a0808"
        )
        P(
            nil,
            -1,
            -4,
            1,
            2,
            "#2a0808"
        )
        P(
            nil,
            0,
            -4,
            1,
            2,
            "#3a0a0a"
        )
    end
    function loop(self, now)
        if not __t(aberto) then
            return
        end
        raf = window:requestAnimationFrame(loop)
        local dt = math.max(
            0,
            math.min(0.05, (now - last) / 1000)
        )
        last = now
        tempo = tempo + dt
        resize(nil)
        local W = cv.width
        local H = cv.height
        if __t(anim) then
            anim.t = anim.t + dt
            local u = anim:f(math.max(
                0,
                math.min(1, anim.t / anim.dur)
            ))
            cam.x = anim.de.x + (anim.para.x - anim.de.x) * u
            cam.y = anim.de.y + (anim.para.y - anim.de.y) * u
            cam.z = anim.de.z + (anim.para.z - anim.de.z) * u
            if __ge(anim.t, anim.dur) then
                anim = nil
            end
        end
        local veic = nil
        if __t(viagem) then
            local v = viagem
            v.t = v.t + dt
            local k = math.max(
                0,
                math.min(1, v.t / v.dur)
            )
            local u = ease(nil, k)
            veic = pontoRota(nil, v, u)
            local p2 = pontoRota(
                nil,
                v,
                ease(
                    nil,
                    math.min(1, k + 0.015)
                )
            )
            local dx = p2.x - veic.x
            local dy = p2.y - p2.alt - (veic.y - veic.alt)
            if math.abs(dx) > 0.08 then
                v.dir = if dx >= 0 then 1 else -1
            end
            local sx = veic.x
            local sy = veic.y - veic.alt
            v.spd = if __t(if __t(v.ant) then dt else v.ant) then __hypot(sx - v.ant.x, sy - v.ant.y) / dt else 0
            v.ant = {x = sx, y = sy}
            v.roda = v.roda + v.spd * dt / 3
            local ____t_287 = __t
            local ____t_286 = __t
            local ____temp_285 = if __t(def.voa) then __gt(v.t, 0) else def.voa
            __O[601] = ____temp_285
            local angAlvo = if ____t_287(if ____t_286(____temp_285) then k < 1 else __O[601]) then math.max(
                -0.42,
                math.min(
                    0.42,
                    math.atan2(
                        dy,
                        math.abs(dx) + 0.01
                    )
                )
            ) * 0.8 else 0
            v.ang = v.ang + (angAlvo - v.ang) * math.min(1, dt * 7)
            if __lt(v.t, 0) then
                veic.y = veic.y + math.floor(math.sin(tempo * 60) + 0.5) * 0.5
            end
            if __t(__ge(v.t, 0) and not __t(v.decolou)) then
                v.decolou = true
                v.sq = 0.7
                poeira(
                    nil,
                    veic.x,
                    veic.y,
                    if __t(def.voa) then 16 else 8,
                    "#e0d2b4"
                )
                do
                    local k2 = 0
                    while k2 < 12 do
                        __call(
                            faiscas,
                            "push",
                            {
                                x = veic.x - v.dir * 14,
                                y = veic.y - 2,
                                vx = __TS__Number(-v.dir) * (30 + math.random() * 60),
                                vy = -40 - math.random() * 50,
                                t = 0,
                                cor = if __t(__mod(k2, 2)) then "#ffd36b" else "#ff8a3a"
                            }
                        )
                        k2 = k2 + 1
                    end
                end
            elseif k < 1 then
                veic.y = veic.y + if __t(def.voa) then math.sin(tempo * 7) * 1.4 * math.min(1, veic.alt / 12) else -math.abs(math.sin(tempo * 16)) * 0.9
            end
            if __t(k >= 1 and not __t(v.pousou)) then
                v.pousou = true
                v.sq = 1
                v.treme = 0.22
                poeira(
                    nil,
                    veic.x,
                    veic.y,
                    if __t(def.voa) then 18 else 10,
                    "#e0d2b4"
                )
                for ____, wx in __iterar((__arrL({-9, 9}, 2))) do
                    do
                        local k2 = 0
                        while k2 < 6 do
                            __call(
                                faiscas,
                                "push",
                                {
                                    x = veic.x + wx,
                                    y = veic.y + 2,
                                    vx = v.dir * (20 + math.random() * 50),
                                    vy = -30 - math.random() * 40,
                                    t = 0,
                                    cor = if __t(__mod(k2, 2)) then "#fff2b0" else "#ffb040"
                                }
                            )
                            k2 = k2 + 1
                        end
                    end
                end
                v.marca = {x = veic.x, y = veic.y + 3, dir = v.dir, t = 0}
            end
            v.sq = math.max(0, v.sq - dt * 3.2)
            v.treme = math.max(0, v.treme - dt)
            v.emit = v.emit + dt
            local taxa = if k >= 1 then 1000000000 else if __lt(v.t, 0) then 0.07 else if __t(def.voa) then 0.028 else 0.045
            while __gt(v.emit, taxa) do
                v.emit = v.emit - taxa
                local ex = veic.x - v.dir * 17 * math.cos(v.ang)
                local ey = veic.y - veic.alt - 3 - math.sin(v.ang) * 17
                if __t(def.voa) then
                    __call(
                        rastro,
                        "push",
                        {
                            x = ex,
                            y = ey,
                            vx = __TS__Number(-v.dir) * (10 + math.random() * 14),
                            vy = -4 + math.random() * 8,
                            t = 0,
                            vida = 0.9 + math.random() * 0.5,
                            r = 2 + math.random() * 1.5,
                            cresce = 7,
                            cor = if math.random() < 0.5 then "#d8f2c8" else "#f4f8ee"
                        }
                    )
                else
                    __call(
                        rastro,
                        "push",
                        {
                            x = ex,
                            y = ey + 1,
                            vx = __TS__Number(-v.dir) * 8,
                            vy = -10 - math.random() * 6,
                            t = 0,
                            vida = 0.7,
                            r = 1.5,
                            cresce = 4,
                            cor = "#c8ccd0"
                        }
                    )
                    if __gt(v.spd, 30) then
                        __call(
                            rastro,
                            "push",
                            {
                                x = veic.x - v.dir * 8,
                                y = veic.y + 2,
                                vx = __TS__Number(-v.dir) * (6 + math.random() * 10),
                                vy = -3,
                                t = 0,
                                vida = 0.45,
                                r = 1.5,
                                cresce = 3,
                                cor = "#d8c8a8",
                                chao = true
                            }
                        )
                    end
                end
            end
            local zBase = math.min(zMax, 3.2)
            local zAlvo = if __t(def.voa) then zBase * (1 - 0.18 * math.sin(math.pi * k)) else zBase
            local tx = veic.x + if __t(dx) then dx else 0 * 6
            local ty = veic.y - veic.alt * 0.5 + if __t(dy) then dy else 0 * 3
            cam.x = cam.x + (tx - cam.x) * math.min(1, dt * 5)
            cam.y = cam.y + (ty - cam.y) * math.min(1, dt * 5)
            cam.z = cam.z + (zAlvo - cam.z) * math.min(1, dt * 2)
            if __gt(v.treme, 0) then
                cam.x = cam.x + math.sin(tempo * 90) * v.treme * 6 / cam.z
                cam.y = cam.y + math.cos(tempo * 77) * v.treme * 4 / cam.z
            end
            veic.dir = v.dir
            veic.ang = v.ang
            veic.v = v
            veic.k = k
            if __gt(v.t, v.dur + 0.3) then
                ui:querySelector(".fade").style.opacity = 1
            end
            if __ge(v.t, v.dur + 0.78) then
                local id = v.id
                viagem = nil
                rastro = __arrL({}, 0)
                fechar(nil)
                window:setTimeout(
                    function()
                        local ____this_289
                        ____this_289 = def
                        local ____opt_288 = ____this_289.aoIr
                        if ____opt_288 ~= nil then
                            ____opt_288 = ____opt_288(____this_289, id)
                        end
                        return ____opt_288
                    end,
                    60
                )
                return
            end
        end
        limitar(nil)
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c.imageSmoothingEnabled = false
        c.fillStyle = if __t(M.ilha) then "#3a98d8" else "#8ccfe8"
        c:fillRect(0, 0, W, H)
        local z = cam.z
        local ox = math.floor(W / 2 - cam.x * z + 0.5)
        local oy = math.floor(H / 2 - cam.y * z + 0.5)
        c:setTransform(
            z,
            0,
            0,
            z,
            ox,
            oy
        )
        if __t(M.ilha) then
            local vx0 = cam.x - W / 2 / z - 40
            local vy0 = cam.y - H / 2 / z - 40
            local vx1 = cam.x + W / 2 / z + 40
            local vy1 = cam.y + H / 2 / z + 40
            do
                local y = math.floor(vy0 / 26) * 26
                while y < vy1 do
                    do
                        local x = math.floor(vx0 / 34) * 34
                        while x < vx1 do
                            local ph = __mod(
                                tempo * 0.7 + hash(nil, x, y) * 6,
                                6
                            )
                            if ph > 1.6 then
                                continue
                            end
                            local ox2 = x + hash(nil, y, x) * 20
                            local a = math.sin(ph / 1.6 * math.pi)
                            c.globalAlpha = a * 0.7
                            c.fillStyle = "#d8f2ff"
                            c:fillRect(
                                math.floor(ox2 + 0.5),
                                math.floor(y + math.sin(tempo + x) * 2 + 0.5),
                                7,
                                1
                            )
                            c:fillRect(
                                math.floor(ox2 + 2 + 0.5),
                                math.floor(y - 1 + math.sin(tempo + x) * 2 + 0.5),
                                3,
                                1
                            )
                            x = x + 34
                        end
                    end
                    y = y + 26
                end
            end
            c.globalAlpha = 1
            c:drawImage(
                M.ilha.cv,
                __TS__Number(-M.PAD),
                __TS__Number(-M.PAD)
            )
            for ____, ____value in __iterar((if __t(M.ilha.eolicas) then M.ilha.eolicas else __arrL({}, 0))) do
                local ex = ____value[1]
                local ey = ____value[2]
                local f = ____value[3]
                local function R2(____, x, y, w, h, col)
                    c.fillStyle = col
                    c:fillRect(
                        math.floor(x + 0.5),
                        math.floor(y + 0.5),
                        w,
                        h
                    )
                end
                R2(
                    nil,
                    ex - 1,
                    ey - 40,
                    3,
                    40,
                    "#f2f4f6"
                )
                R2(
                    nil,
                    ex + 1,
                    ey - 40,
                    1,
                    40,
                    "#c8ccd0"
                )
                R2(
                    nil,
                    ex - 2,
                    ey - 43,
                    5,
                    4,
                    "#e8ecef"
                )
                local a0 = tempo * 2.2 + f
                do
                    local k = 0
                    while k < 3 do
                        local a = a0 + k * 2.094
                        do
                            local j = 2
                            while j < 18 do
                                R2(
                                    nil,
                                    ex + math.cos(a) * j,
                                    ey - 41 + math.sin(a) * j,
                                    2,
                                    2,
                                    if j > 14 then "#c43c3a" else "#ffffff"
                                )
                                j = j + 1
                            end
                        end
                        k = k + 1
                    end
                end
                R2(
                    nil,
                    ex - 1,
                    ey - 42,
                    3,
                    3,
                    "#9aa0a6"
                )
            end
            c.fillStyle = "#ffffff"
            for ____, ____value in __iterar((M.ilha.costa)) do
                local x = ____value[1]
                local y = ____value[2]
                local nx = ____value[3]
                local ny = ____value[4]
                local f = ____value[5]
                local o = 2 + math.sin(tempo * 2.2 + f) * 2.2
                c.globalAlpha = 0.55 + math.sin(tempo * 2.2 + f) * 0.35
                c:fillRect(
                    math.floor(x + nx * o + 0.5),
                    math.floor(y + ny * o + 0.5),
                    2,
                    2
                )
            end
            c.globalAlpha = 1
            local cx0 = M.W / 2
            local cy0 = M.H / 2
            for ____, b in __iterar((M.barcos)) do
                b.a = b.a + b.v * dt * 0.12
                local rx = M.W / 2 + M.PAD * 0.62
                local ry = M.H / 2 + M.PAD * 0.55
                local bx = cx0 + math.cos(b.a) * rx
                local by = cy0 + math.sin(b.a) * ry
                local dir = if -math.sin(b.a) >= 0 then 1 else -1
                c.globalAlpha = 0.5
                c.fillStyle = "#ffffff"
                do
                    local k = 1
                    while k < 5 do
                        c:fillRect(
                            math.floor(bx - dir * (10 + k * 5) + 0.5),
                            math.floor(by + 3 + __mod(k, 2) + 0.5),
                            4,
                            1
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
                c.fillStyle = "#6a3a1a"
                c:fillRect(
                    math.floor(bx - 9 + 0.5),
                    math.floor(by + 0.5),
                    18,
                    4
                )
                c.fillStyle = "#8a5030"
                c:fillRect(
                    math.floor(bx - 7 + 0.5),
                    math.floor(by + 4 + 0.5),
                    14,
                    2
                )
                c.fillStyle = "#5a3a2a"
                c:fillRect(
                    math.floor(bx + 0.5),
                    math.floor(by - 16 + 0.5),
                    1,
                    16
                )
                c.fillStyle = "#f6f6f0"
                do
                    local k = 0
                    while k < 13 do
                        c:fillRect(
                            math.floor(bx + 1 + 0.5),
                            math.floor(by - 15 + k + 0.5),
                            math.floor((13 - k) * 0.7 + 0.5) + 1,
                            1
                        )
                        k = k + 1
                    end
                end
                c.fillStyle = b.cor
                c:fillRect(
                    math.floor(bx + 1 + 0.5),
                    math.floor(by - 17 + 0.5),
                    5,
                    3
                )
            end
            for ____, g in __iterar((M.golfinhos)) do
                local ciclo = __mod(tempo * 0.5 + g.fase, 4)
                if ciclo > 1 then
                    continue
                end
                local rx = M.W / 2 + M.PAD * 0.78
                local ry = M.H / 2 + M.PAD * 0.72
                local gx = cx0 + math.cos(g.a) * rx + (ciclo - 0.5) * 30
                local gy = cy0 + math.sin(g.a) * ry - math.sin(ciclo * math.pi) * 14
                c.fillStyle = "#4a6a8a"
                c:fillRect(
                    math.floor(gx - 6 + 0.5),
                    math.floor(gy - 2 + 0.5),
                    12,
                    4
                )
                c:fillRect(
                    math.floor(gx - 1 + 0.5),
                    math.floor(gy - 5 + 0.5),
                    3,
                    3
                )
                c:fillRect(
                    math.floor(gx + 5 + 0.5),
                    math.floor(gy - 3 + 0.5),
                    3,
                    2
                )
                c.fillStyle = "#8ab0d0"
                c:fillRect(
                    math.floor(gx - 5 + 0.5),
                    math.floor(gy + 1 + 0.5),
                    9,
                    1
                )
                if __t(ciclo < 0.12 or ciclo > 0.88) then
                    c.fillStyle = "#ffffff"
                    c.globalAlpha = 0.8
                    do
                        local k = 0
                        while k < 4 do
                            c:fillRect(
                                math.floor(gx - 4 + k * 3 + 0.5),
                                math.floor(gy - 2 - __mod(k, 2) * 2 + 0.5),
                                2,
                                2
                            )
                            k = k + 1
                        end
                    end
                    c.globalAlpha = 1
                end
            end
            if __t(if __t(M.ilha.farol) then __mod(
                math.floor(tempo * 1.5),
                2
            ) else M.ilha.farol) then
                local fx, fy = table.unpack(M.ilha.farol, 1, 2)
                c.globalAlpha = 0.35
                c.fillStyle = "#fff2b0"
                c:beginPath()
                c:moveTo(fx, fy - 48)
                c:lineTo(fx + 60, fy - 62)
                c:lineTo(fx + 60, fy - 36)
                __call(c, "fill")
                c.globalAlpha = 1
            end
        end
        c:drawImage(M.base, 0, 0)
        local P = Px(nil, c)
        local R = P.R
        for ____, ____value in __iterar((M.agua)) do
            local x = ____value[1]
            local y = ____value[2]
            local ph = __mod(
                tempo * 0.8 + hash(nil, x, y) * 5,
                5
            )
            if ph < 0.9 then
                R(
                    nil,
                    x - 2 + ph * 2,
                    y,
                    math.max(1, 5 - ph * 5),
                    1,
                    "#e2f4ff"
                )
                if ph < 0.3 then
                    R(
                        nil,
                        x,
                        y - 1,
                        1,
                        1,
                        "#ffffff"
                    )
                end
            end
        end
        local ____this_291
        ____this_291 = def
        local ____opt_290 = ____this_291.animarChao
        if ____opt_290 ~= nil then
            ____opt_290(____this_291, P, tempo)
        end
        c:drawImage(M.obj, 0, 0)
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local ____t_294 = __t
                local ____opt_292 = L.estado
                if ____opt_292 ~= nil then
                    ____opt_292 = ____opt_292.trava
                end
                if not ____t_294(____opt_292) then
                    return
                end
                local lo = __get(M.locs, i)
                local cx = lo.bx + lo.bw / 2
                local cy = lo.by + lo.bh * 0.55
                c:save()
                c.fillStyle = "#1a2440"
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({0.74, 0.17}, 2),
                        __arrL({0.62, 0.15}, 2),
                        __arrL({0.5, 0.13}, 2)
                    },
                    3
                ))) do
                    local k = ____value[1]
                    local a = ____value[2]
                    c.globalAlpha = a
                    c:beginPath()
                    c:ellipse(
                        cx,
                        cy,
                        lo.bw * k,
                        lo.bh * k,
                        0,
                        0,
                        math.pi * 2
                    )
                    __call(c, "fill")
                end
                c:restore()
            end
        )
        local ordem = __call(
            __call(
                M.locs,
                "map",
                function(____, L, i) return i end
            ),
            "sort",
            function(____, a, b) return __add(
                __get(M.locs, a).by,
                __get(M.locs, a).bh
            ) - __add(
                __get(M.locs, b).by,
                __get(M.locs, b).bh
            ) end
        )
        for ____, i in __iterar((ordem)) do
            local L = __get(M.locs, i)
            local sx = 1
            local sy = 1
            if L.pulo ~= nil then
                L.pulo = L.pulo + dt
                local k = L.pulo
                local y = if __lt(k, 1) then math.sin(k * 15) * math.exp(__TS__Number(-k) * 4.5) * 0.22 else 0
                sy = 1 + y
                sx = 1 - y * 0.6
                if __ge(k, 1) then
                    L.pulo = nil
                end
            end
            if i == sel then
                c:save()
                c.globalAlpha = 0.35 + math.sin(tempo * 5) * 0.15
                local ____c_298 = c
                local ____t_297 = __t
                local ____opt_295 = __get(def.locais, i).estado
                if ____opt_295 ~= nil then
                    ____opt_295 = ____opt_295.trava
                end
                ____c_298.fillStyle = if ____t_297(____opt_295) then "#ff4a3a" else "#fff6c0"
                local r = math.max(L.bw, L.bh) * 0.62
                c:beginPath()
                c:ellipse(
                    L.bx + L.bw / 2,
                    __add(L.by, L.bh) - 4,
                    r,
                    r * 0.35,
                    0,
                    0,
                    math.pi * 2
                )
                __call(c, "fill")
                c:restore()
            end
            c:save()
            c:translate(
                L.bx + L.bw / 2,
                __add(L.by, L.bh)
            )
            c:scale(sx, sy)
            local ____c_302 = c
            local ____c_drawImage_303 = c.drawImage
            local ____t_301 = __t
            local ____opt_299 = __get(def.locais, i).estado
            if ____opt_299 ~= nil then
                ____opt_299 = ____opt_299.trava
            end
            ____c_drawImage_303(
                ____c_302,
                if ____t_301(____opt_299) then L.esc else L.s,
                __TS__Number(-L.bw) / 2,
                __TS__Number(-L.bh)
            )
            c:restore()
        end
        local ____this_305
        ____this_305 = def
        local ____opt_304 = ____this_305.animar
        if ____opt_304 ~= nil then
            ____opt_304(____this_305, P, tempo, dt)
        end
        faiscas = __call(
            faiscas,
            "filter",
            function(____, f)
                f.t = f.t + dt
                f.vy = f.vy + 160 * dt
                f.x = f.x + f.vx * dt
                f.y = f.y + f.vy * dt
                R(
                    nil,
                    f.x,
                    f.y,
                    2,
                    2,
                    f.cor
                )
                return __lt(f.t, 0.9)
            end
        )
        if __t(veic) then
            local v = veic.v
            local alt = veic.alt
            do
                local R2 = v.rota
                local d0 = ease(nil, veic.k) * R2.total
                local passo = 7
                local desl = __mod(tempo * 26, passo)
                local i2 = 1
                do
                    local d = d0 + 10 + desl
                    while d < R2.total - 4 do
                        while __t(i2 < __len(R2.acc) - 1 and __lt(
                            __get(R2.acc, i2),
                            d
                        )) do
                            i2 = i2 + 1
                        end
                        local a = __get(R2.pts, i2 - 1)
                        local b = __get(R2.pts, i2)
                        local sg = __get(R2.acc, i2) - __get(R2.acc, i2 - 1)
                        local kk = if __t(sg) then (d - __get(R2.acc, i2 - 1)) / sg else 0
                        local x = a.x + (b.x - a.x) * kk
                        local y = a.y + (b.y - a.y) * kk
                        c.globalAlpha = 0.75
                        R(
                            nil,
                            x - 1,
                            y,
                            3,
                            3,
                            "#2a1a10"
                        )
                        R(
                            nil,
                            x - 1,
                            y - 1,
                            3,
                            2,
                            "#fff6c0"
                        )
                        d = d + passo
                    end
                end
                c.globalAlpha = 1
                local fim = __get(
                    R2.pts,
                    __len(R2.pts) - 1
                )
                local pul = __mod(tempo * 1.6, 1)
                c:save()
                c.strokeStyle = "#ffd36b"
                c.lineWidth = 2
                c.globalAlpha = 1 - pul
                c:beginPath()
                c:ellipse(
                    fim.x,
                    fim.y + 2,
                    8 + pul * 22,
                    (8 + pul * 22) * 0.38,
                    0,
                    0,
                    math.pi * 2
                )
                c:stroke()
                c.globalAlpha = 0.55
                c.fillStyle = "#ffd36b"
                c:beginPath()
                c:ellipse(
                    fim.x,
                    fim.y + 2,
                    7,
                    2.8,
                    0,
                    0,
                    math.pi * 2
                )
                __call(c, "fill")
                c:restore()
                if __lt(veic.k, 1) then
                    local by = fim.y - 34 - math.abs(math.sin(tempo * 5)) * 6
                    R(
                        nil,
                        fim.x - 4,
                        by,
                        9,
                        3,
                        "#2a1a10"
                    )
                    R(
                        nil,
                        fim.x - 3,
                        by + 3,
                        7,
                        2,
                        "#2a1a10"
                    )
                    R(
                        nil,
                        fim.x - 1,
                        by + 5,
                        3,
                        2,
                        "#2a1a10"
                    )
                    R(
                        nil,
                        fim.x - 3,
                        by,
                        7,
                        2,
                        "#ffd36b"
                    )
                    R(
                        nil,
                        fim.x - 2,
                        by + 2,
                        5,
                        2,
                        "#ffd36b"
                    )
                    R(
                        nil,
                        fim.x,
                        by + 4,
                        1,
                        2,
                        "#ffd36b"
                    )
                end
            end
            c.globalAlpha = math.max(0.1, 0.34 - alt * 0.004)
            P:circ(
                veic.x,
                veic.y + 3,
                math.max(5, 13 - alt * 0.12),
                "#000",
                math.max(2, 4 - alt * 0.03)
            )
            c.globalAlpha = 1
            for ____, p in __iterar((rastro)) do
                if __t(p.chao) then
                    c.globalAlpha = math.max(0, 1 - p.t / p.vida) * 0.6
                    P:circ(
                        p.x,
                        p.y,
                        p.r + p.cresce * p.t / p.vida,
                        p.cor,
                        math.max(1, (p.r + p.cresce * p.t / p.vida) * 0.45)
                    )
                end
            end
            c.globalAlpha = 1
            for ____, p in __iterar((rastro)) do
                if not __t(p.chao) then
                    local q = p.t / p.vida
                    c.globalAlpha = math.max(0, 1 - q) * 0.7
                    P:circ(p.x, p.y, p.r + p.cresce * q, p.cor)
                end
            end
            c.globalAlpha = 1
            if __t(__gt(v.spd, 90) and __lt(veic.k, 1)) then
                c.globalAlpha = math.min(0.6, (v.spd - 90) / 260)
                do
                    local k2 = 0
                    while k2 < 4 do
                        local ly = veic.y - alt - 12 + k2 * 5 + math.sin(tempo * 30 + k2) * 1.5
                        local lx = veic.x - veic.dir * (22 + __mod(tempo * 140 + k2 * 9, 18))
                        R(
                            nil,
                            if __gt(veic.dir, 0) then lx - 10 else lx,
                            ly,
                            10,
                            1,
                            "#ffffff"
                        )
                        k2 = k2 + 1
                    end
                end
                c.globalAlpha = 1
            end
            if __t(v.marca) then
                local ____v_marca_306, ____t_307 = v.marca, "t"
                ____v_marca_306[____t_307] = ____v_marca_306[____t_307] + dt
                local a = math.max(0, 1 - v.marca.t / 2.2)
                if a > 0 then
                    c.globalAlpha = a * 0.5
                    for ____, off in __iterar((__arrL({-9, 9}, 2))) do
                        R(
                            nil,
                            v.marca.x + off - if __gt(v.marca.dir, 0) then 18 else 0,
                            v.marca.y,
                            18,
                            1,
                            "#3a2a1a"
                        )
                    end
                    c.globalAlpha = 1
                end
            end
            local ____t_310 = __t
            local ____t_309 = __t
            local ____temp_308 = if __t(def.voa) then alt > 18 else def.voa
            __O[602] = ____temp_308
            if ____t_310(if ____t_309(____temp_308) then __lt(veic.k, 1) else __O[602]) then
                do
                    local k2 = 0
                    while k2 < 3 do
                        local u = __mod(tempo * 0.9 + k2 / 3, 1)
                        local cx2 = veic.x + veic.dir * (30 - u * 70)
                        local cy2 = veic.y - alt * 0.45 + 6 + k2 * 4
                        c.globalAlpha = math.sin(u * math.pi) * 0.55
                        P:circ(cx2, cy2, 4 + k2, "#ffffff")
                        P:circ(cx2 + 5, cy2 + 1, 3 + k2 * 0.6, "#f2f6fa")
                        P:circ(cx2 - 5, cy2 + 1, 3, "#e8eef4")
                        c.globalAlpha = 1
                        k2 = k2 + 1
                    end
                end
            end
            if __t(__gt(v.spd, 140) and __lt(veic.k, 1)) then
                do
                    local j = 3
                    while j >= 1 do
                        c:save()
                        c.globalAlpha = 0.14 * (4 - j) / 3
                        c:translate(
                            math.floor(veic.x - veic.dir * j * 8 + 0.5),
                            math.floor(veic.y - alt + j * math.sin(veic.ang) * 3 + 0.5)
                        )
                        if __lt(veic.dir, 0) then
                            c:scale(-1, 1)
                        end
                        c:rotate(veic.ang)
                        local ____this_312
                        ____this_312 = def
                        local ____opt_311 = ____this_312.veiculo
                        if ____opt_311 ~= nil then
                            ____opt_311(____this_312, P, tempo, {
                                alt = alt,
                                roda = v.roda,
                                voando = alt > 3,
                                parado = false,
                                vel = v.spd
                            })
                        end
                        c:restore()
                        j = j - 1
                    end
                end
            end
            local e = if __gt(v.sq, 0) then math.sin(v.sq * math.pi) * v.sq * 0.22 else 0
            c:save()
            c:translate(
                math.floor(veic.x + 0.5),
                math.floor(veic.y - alt + 0.5)
            )
            if __lt(veic.dir, 0) then
                c:scale(-1, 1)
            end
            c:rotate(veic.ang)
            c:scale(1 + e, 1 - e)
            local ____this_314
            ____this_314 = def
            local ____opt_313 = ____this_314.veiculo
            if ____opt_313 ~= nil then
                ____opt_313(
                    ____this_314,
                    P,
                    tempo,
                    {
                        alt = alt,
                        roda = v.roda,
                        voando = alt > 3,
                        parado = __lt(v.t, 0) or __ge(veic.k, 1),
                        vel = v.spd
                    }
                )
            end
            c:restore()
        end
        rastro = __call(
            rastro,
            "filter",
            function(____, p)
                p.t = p.t + dt
                p.x = p.x + p.vx * dt
                p.y = p.y + p.vy * dt
                p.vx = p.vx * 0.25 ^ dt
                p.vy = p.vy * 0.4 ^ dt
                if not __t(p.chao) then
                    p.vy = p.vy - 6 * dt
                end
                return __lt(p.t, p.vida)
            end
        )
        for ____, a in __iterar((M.aves)) do
            a.x = a.x + a.v * a.dir * dt
            if __gt(a.x, M.W + 120) then
                a.x = -120
            end
            if __lt(a.x, -120) then
                a.x = M.W + 120
            end
            do
                local i = 0
                while __lt(i, a.n) do
                    local lado = if __t(__mod(i, 2)) then 1 else -1
                    local k = math.ceil(i / 2)
                    local bx = a.x - a.dir * k * 9
                    local by = a.y + lado * k * 6 + math.sin(tempo * 2 + a.fase) * 6
                    local asa = math.sin(tempo * 12 + a.fase + i) > 0
                    R(
                        nil,
                        bx - 3,
                        by - if __t(asa) then 2 else 0,
                        2,
                        1,
                        "#2a2a3a"
                    )
                    R(
                        nil,
                        bx - 1,
                        by,
                        2,
                        1,
                        "#2a2a3a"
                    )
                    R(
                        nil,
                        bx + 1,
                        by - if __t(asa) then 2 else 0,
                        2,
                        1,
                        "#2a2a3a"
                    )
                    c.globalAlpha = 0.15
                    R(
                        nil,
                        bx - 2,
                        by + 26,
                        4,
                        1,
                        "#000"
                    )
                    c.globalAlpha = 1
                    i = i + 1
                end
            end
        end
        for ____, b in __iterar((M.borbo)) do
            local t2 = tempo + b.fase
            local bx = b.x + math.sin(t2 * 0.7) * 24
            local by = b.y + math.sin(t2 * 1.3) * 10
            local abre = math.sin(t2 * 14) > 0
            R(
                nil,
                bx - if __t(abre) then 2 else 1,
                by,
                if __t(abre) then 2 else 1,
                2,
                b.cor
            )
            R(
                nil,
                bx + 1,
                by,
                if __t(abre) then 2 else 1,
                2,
                b.cor
            )
            R(
                nil,
                bx,
                by,
                1,
                2,
                "#2a1a10"
            )
        end
        for ____, pp in __iterar((if __t(M.parapentes) then M.parapentes else __arrL({}, 0))) do
            local a = tempo * 0.35 + pp.fase
            local px = pp.x + math.cos(a) * pp.r
            local py = pp.y + math.sin(a) * pp.r * 0.5 - 30
            local dir = if -math.sin(a) >= 0 then 1 else -1
            c.globalAlpha = 0.18
            R(
                nil,
                px - 8,
                py + 46,
                16,
                3,
                "#000"
            )
            c.globalAlpha = 1
            do
                local k = 0
                while k < 9 do
                    R(
                        nil,
                        px - 12 + k * 3,
                        py - math.floor(math.sin(k / 8 * math.pi) * 5 + 0.5),
                        3,
                        4,
                        if __t(__mod(k, 2)) then pp.cor else "#ffffff"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                px - 11,
                py + 3,
                1,
                9,
                "#5a5e62"
            )
            R(
                nil,
                px + 11,
                py + 3,
                1,
                9,
                "#5a5e62"
            )
            R(
                nil,
                px - 2,
                py + 11,
                4,
                5,
                "#2a3a4a"
            )
            R(
                nil,
                px - 1,
                py + 9,
                3,
                3,
                "#d9a57f"
            )
            R(
                nil,
                px + dir * 2,
                py + 15,
                3,
                2,
                "#2a3a4a"
            )
        end
        if __t(M.balao) then
            local b = M.balao
            b.x = b.x + dt * 9
            if __gt(b.x, M.W + 80) then
                b.x = -80
            end
            local by = b.y + math.sin(tempo * 0.6) * 10
            c.globalAlpha = 0.15
            P:circ(
                b.x + 18,
                by + 70,
                10,
                "#000",
                3
            )
            c.globalAlpha = 1
            P:circ(
                b.x,
                by,
                15,
                "#2a1a10",
                17
            )
            do
                local k = 0
                while k < 5 do
                    c.fillStyle = __get(
                        __arrL({
                            "#e8433a",
                            "#f2c94c",
                            "#3c8ab0",
                            "#3c8a5a",
                            "#9a52c0"
                        }, 5),
                        k
                    )
                    c:fillRect(
                        math.floor(b.x - 14 + k * 6 + 0.5),
                        math.floor(by - 16 + math.abs(k - 2) * 2 + 0.5),
                        5,
                        30 - math.abs(k - 2) * 4
                    )
                    k = k + 1
                end
            end
            P:circ(
                b.x - 5,
                by - 7,
                3,
                "#ffffff55",
                4
            )
            R(
                nil,
                b.x - 6,
                by + 16,
                1,
                8,
                "#5a3820"
            )
            R(
                nil,
                b.x + 5,
                by + 16,
                1,
                8,
                "#5a3820"
            )
            R(
                nil,
                b.x - 6,
                by + 24,
                12,
                7,
                "#a8643a"
            )
            R(
                nil,
                b.x - 6,
                by + 24,
                12,
                2,
                "#c8844a"
            )
        end
        do
            local k = 0
            while k < 5 do
                local nx = __mod(tempo * 8 + k * 260, M.W + 300) - 150
                local ny = 60 + k * (M.H / 5)
                c.globalAlpha = 0.06
                P:circ(
                    nx + 24,
                    ny + 46,
                    34,
                    "#0c1a30",
                    12
                )
                c.globalAlpha = 0.55
                P:circ(
                    nx,
                    ny,
                    26,
                    "#ffffff",
                    9
                )
                P:circ(
                    nx + 18,
                    ny - 4,
                    18,
                    "#ffffff",
                    8
                )
                P:circ(
                    nx - 14,
                    ny + 2,
                    14,
                    "#ffffff",
                    6
                )
                c.globalAlpha = 1
                k = k + 1
            end
        end
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        do
            c:save()
            c.globalCompositeOperation = "screen"
            local sol = c:createRadialGradient(
                W * 0.08,
                __TS__Number(-H) * 0.1,
                0,
                W * 0.08,
                __TS__Number(-H) * 0.1,
                math.max(W, H) * 0.9
            )
            sol:addColorStop(0, "rgba(255,236,170,.35)")
            sol:addColorStop(0.5, "rgba(255,220,150,.10)")
            sol:addColorStop(1, "rgba(255,220,150,0)")
            c.fillStyle = sol
            c:fillRect(0, 0, W, H)
            c.globalAlpha = 0.07 + math.sin(tempo * 0.5) * 0.02
            c.fillStyle = "#fff2c0"
            do
                local k = 0
                while k < 4 do
                    local x0 = (__mod(k * 0.27 + tempo * 0.004, 1.2) - 0.1) * W
                    c:beginPath()
                    c:moveTo(x0, 0)
                    c:lineTo(x0 + W * 0.06, 0)
                    c:lineTo(x0 + W * 0.06 + H * 0.55, H)
                    c:lineTo(x0 + H * 0.55, H)
                    __call(c, "fill")
                    k = k + 1
                end
            end
            c:restore()
        end
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local lo = __get(M.locs, i)
                local sx = ox + (lo.bx + lo.bw / 2) * z
                local sy = oy + lo.by * z
                local ____t_319 = __t
                local ____t_318 = __t
                local ____t_316 = __t
                local ____temp_315 = sx < -100 or __gt(sx, W + 100)
                __O[603] = ____temp_315
                local ____temp_317 = if ____t_316(____temp_315) then __O[603] else sy < -60
                __O[604] = ____temp_317
                if ____t_319(if ____t_318(____temp_317) then __O[604] else __gt(sy, H + 80)) then
                    return
                end
                local b = math.floor(math.sin(tempo * 3 + i) * 3 + 0.5)
                local ativo = i == sel
                local ____placaNome_324 = placaNome
                local ____temp_322 = sy - 6 + b
                local ____add_result_323 = __add(if __t(L.atual) then "● " else "", L.nome)
                local ____opt_320 = L.estado
                if ____opt_320 ~= nil then
                    ____opt_320 = ____opt_320.ok
                end
                ____placaNome_324(
                    nil,
                    sx,
                    ____temp_322,
                    ____add_result_323,
                    if ____opt_320 == false then "bloq" else if __t(L.atual) then "atual" else "ok",
                    ativo
                )
                if __t(ativo) then
                    c.fillStyle = "#ffd24a"
                    local ay = sy - 34 + math.floor(math.sin(tempo * 6) * 4 + 0.5)
                    c:beginPath()
                    c:moveTo(sx - 8, ay - 10)
                    c:lineTo(sx + 8, ay - 10)
                    c:lineTo(sx, ay)
                    __call(c, "fill")
                end
            end
        )
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local ____t_327 = __t
                local ____opt_325 = L.estado
                if ____opt_325 ~= nil then
                    ____opt_325 = ____opt_325.trava
                end
                if not ____t_327(____opt_325) then
                    return
                end
                local lo = __get(M.locs, i)
                local k = math.max(
                    2,
                    math.min(
                        4,
                        math.floor(z * 0.9 + 0.5)
                    )
                )
                local x = ox + (lo.bx + lo.bw / 2) * z
                local y = oy + (lo.by + lo.bh * 0.62) * z + math.floor(math.sin(tempo * 2.2 + i) * 2 + 0.5)
                local ____t_332 = __t
                local ____t_331 = __t
                local ____t_329 = __t
                local ____temp_328 = x < -60 or __gt(x, W + 60)
                __O[605] = ____temp_328
                local ____temp_330 = if ____t_329(____temp_328) then __O[605] else y < -60
                __O[606] = ____temp_330
                if ____t_332(if ____t_331(____temp_330) then __O[606] else __gt(y, H + 80)) then
                    return
                end
                lo.tremor = math.max(0, lo.tremor - dt * 1.6)
                cadeado(
                    nil,
                    x,
                    y,
                    k,
                    lo.tremor
                )
                if i == travaI then
                    local el = ui:querySelector(".trava")
                    local pv = ui:querySelector(".pv")
                    local r = if __t(pv.classList:contains("on")) then pv:getBoundingClientRect() else nil
                    local meia = el.offsetWidth / 2 + 10
                    local ladoDir = if __t(if __t(r) then __lt(r.top, H * 0.4) else r) then r.left else W
                    local base = if __t(if __t(r) then __ge(r.top, H * 0.4) else r) then r.top else H
                    el.style.left = __add(
                        math.floor(math.max(
                            meia,
                            math.min(ladoDir - meia, x)
                        ) + 0.5),
                        "px"
                    )
                    el.style.top = __add(
                        math.floor(math.max(
                            el.offsetHeight + 60,
                            math.min(base - 16, y - 17 * k - 8)
                        ) + 0.5),
                        "px"
                    )
                    if tempo > travaAte then
                        mostrarTrava(nil, -1)
                    end
                end
            end
        )
    end
    local ____ = "use strict"
    if __t(window.Mapa3D) then
        return
    end
    local TS = 16
    ease = function(____, u) return if __lt(u, 0.5) then 4 * u * u * u else 1 - (-2 * u + 2) ^ 3 / 2 end
    easeOut = function(____, u) return 1 - (1 - u) ^ 3 end
    hash = function(____, a, b)
        if b == nil then
            b = 0
        end
        local x = math.sin(a * 127.1 + b * 311.7 + 74.7) * 43758.5453
        return x - math.floor(x)
    end
    COR = __ord({
        grama = "#5fae3c",
        gramaC = "#76c64c",
        gramaE = "#4f9a34",
        gramaB = "#3c7a2c",
        borda = "#2f5e26",
        terra = "#c87a4a",
        terraE = "#a85e38",
        terraC = "#e29a62",
        terraB = "#7a4228",
        agua = "#4a92e2",
        aguaE = "#3a7ad0",
        aguaC = "#7ac2f2",
        espuma = "#e2f4ff",
        pedra = "#bcc0c4",
        pedraE = "#9aa0a6",
        pedraC = "#dde0e3",
        pedraB = "#7a8086",
        chao = "#d8a06e",
        chaoE = "#bf8656",
        asfalto = "#5b6066",
        asfaltoE = "#4c5156",
        areia = "#e8d494"
    }, "grama,gramaC,gramaE,gramaB,borda,terra,terraE,terraC,terraB,agua,aguaE,aguaC,espuma,pedra,pedraE,pedraC,pedraB,chao,chaoE,asfalto,asfaltoE,areia")
    shade = function(____, hex, k)
        if not __re_test(
            __re("^#[0-9a-f]{6}$", "i"),
            hex
        ) then
            return hex
        end
        local n = __TS__ParseInt(
            __call(hex, "slice", 1),
            16
        )
        local function f(____, v)
            return math.max(
                0,
                math.min(
                    255,
                    math.floor(v * k + 0.5)
                )
            )
        end
        return __add(
            "#",
            __call(
                __call(
                    __arrL(
                        {
                            __band(
                                __shr(n, 16),
                                255
                            ),
                            __band(
                                __shr(n, 8),
                                255
                            ),
                            __band(n, 255)
                        },
                        3
                    ),
                    "map",
                    function(____, v) return __call(
                        __call(
                            f(nil, v),
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
    local TIPOS = __arrL({
        "grama",
        "mata",
        "pedra",
        "chao",
        "asfalto",
        "areia",
        "plantacao",
        "cafe",
        "campo",
        "quadra",
        "pista",
        "nuvem",
        "trigo",
        "calcada",
        "cerrado"
    }, 15)
    local TI = __TS__ObjectFromEntries(__call(
        TIPOS,
        "map",
        function(____, t, i) return __arrL({t, i}, 2) end
    ))
    local VERDE = __TS__New(
        Set,
        __arrL({TI.grama, TI.mata, TI.cerrado}, 3)
    )
    local CAMINHO = __TS__New(
        Set,
        __arrL({
            TI.pedra,
            TI.chao,
            TI.asfalto,
            TI.areia,
            TI.quadra,
            TI.pista,
            TI.calcada
        }, 7)
    )
    local function h2(____, x, y, s)
        if s == nil then
            s = 0
        end
        local h = __imul(
            __bor(x, 0),
            374761393
        ) + __imul(
            __bor(y, 0),
            668265263
        ) + __imul(s, 2246822519)
        h = __imul(
            __bxor(
                h,
                __ushr(h, 13)
            ),
            1274126177
        )
        return __ushr(
            __bxor(
                h,
                __ushr(h, 16)
            ),
            0
        ) / 4294967296
    end
    local function vn(____, x, y, s)
        if s == nil then
            s = 0
        end
        local xi = math.floor(x)
        local yi = math.floor(y)
        local xf = x - xi
        local yf = y - yi
        local u = xf * xf * (3 - 2 * xf)
        local v = yf * yf * (3 - 2 * yf)
        local a = h2(nil, xi, yi, s)
        local b = h2(nil, xi + 1, yi, s)
        local c = h2(nil, xi, yi + 1, s)
        local d = h2(nil, xi + 1, yi + 1, s)
        return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v
    end
    local function curva(self, pts, passo)
        if passo == nil then
            passo = 3
        end
        local out = __arrL({}, 0)
        local function G(____, i)
            return __get(
                pts,
                math.max(
                    0,
                    math.min(
                        __len(pts) - 1,
                        i
                    )
                )
            )
        end
        do
            local i = 0
            while i < __len(pts) - 1 do
                local p0 = G(nil, i - 1)
                local p1 = G(nil, i)
                local p2 = G(nil, i + 1)
                local p3 = G(nil, i + 2)
                local n = math.max(
                    1,
                    math.ceil(__hypot(
                        __get(p2, 0) - __get(p1, 0),
                        __get(p2, 1) - __get(p1, 1)
                    ) / passo)
                )
                do
                    local k = 0
                    while k < n do
                        local t = k / n
                        local t2 = t * t
                        local t3 = t2 * t
                        local function f(____, a, b, c, d)
                            return 0.5 * (2 * b + (__TS__Number(-a) + c) * t + (2 * a - 5 * b + 4 * c - d) * t2 + (__TS__Number(-a) + 3 * b - 3 * c + d) * t3)
                        end
                        __call(
                            out,
                            "push",
                            __arrL(
                                {
                                    f(
                                        nil,
                                        __get(p0, 0),
                                        __get(p1, 0),
                                        __get(p2, 0),
                                        __get(p3, 0)
                                    ),
                                    f(
                                        nil,
                                        __get(p0, 1),
                                        __get(p1, 1),
                                        __get(p2, 1),
                                        __get(p3, 1)
                                    )
                                },
                                2
                            )
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __call(
            out,
            "push",
            __arr(__TS__Spread(__iter(__get(
                pts,
                __len(pts) - 1
            ))))
        )
        return out
    end
    local function trilho(self, pl)
        local ac = __arrL({0}, 1)
        do
            local k = 1
            while __lt(
                k,
                __len(pl)
            ) do
                __call(
                    ac,
                    "push",
                    __get(ac, k - 1) + __hypot(
                        __get(
                            __get(pl, k),
                            0
                        ) - __get(
                            __get(pl, k - 1),
                            0
                        ),
                        __get(
                            __get(pl, k),
                            1
                        ) - __get(
                            __get(pl, k - 1),
                            1
                        )
                    )
                )
                k = k + 1
            end
        end
        local ____t_4 = __t
        local ____get_result_3 = __get(
            ac,
            __len(ac) - 1
        )
        __O[505] = ____get_result_3
        local total = if ____t_4(____get_result_3) then __O[505] else 1
        return {
            total = total,
            em = function(____, u)
                local d = __mod(
                    __mod(u, 1) + 1,
                    1
                ) * total
                local lo = 0
                local hi = __len(ac) - 1
                while hi - lo > 1 do
                    local m = __shr(lo + hi, 1)
                    if __get(ac, m) <= d then
                        lo = m
                    else
                        hi = m
                    end
                end
                local a = __get(pl, lo)
                local b = __get(pl, hi)
                local ____temp_7 = d - __get(ac, lo)
                local ____t_6 = __t
                local ____temp_5 = __get(ac, hi) - __get(ac, lo)
                __O[506] = ____temp_5
                local k = ____temp_7 / if ____t_6(____temp_5) then __O[506] else 1
                return {
                    x = __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k,
                    y = __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k,
                    ang = math.atan2(
                        __get(b, 1) - __get(a, 1),
                        __get(b, 0) - __get(a, 0)
                    )
                }
            end
        }
    end
    local function Terreno(self, W, H)
        local F = 4
        local FW = W * F
        local FH = H * F
        local nivel = __call(
            __TS__New(window.Int8Array, FW * FH),
            "fill",
            1
        )
        local tipo = __new("Uint8Array", FW * FH)
        local function ok(____, x, y)
            local ____t_11 = __t
            local ____t_9 = __t
            local ____temp_8 = __ge(x, 0) and __ge(y, 0)
            __O[507] = ____temp_8
            local ____temp_10 = if ____t_9(____temp_8) then __lt(x, FW) else __O[507]
            __O[508] = ____temp_10
            return if ____t_11(____temp_10) then __lt(y, FH) else __O[508]
        end
        local function pinta(____, fx, fy, o)
            if not __t(ok(nil, fx, fy)) then
                return
            end
            local i = fy * FW + fx
            if o.nivel ~= nil then
                __set(nivel, i, o.nivel)
            end
            if __t(o.tipo) then
                local ____set_13 = __set
                local ____get_result_12 = __get(TI, o.tipo)
                if ____get_result_12 == nil then
                    ____get_result_12 = 0
                end
                ____set_13(tipo, i, ____get_result_12)
            end
        end
        local ruas = __arrL({}, 0)
        local eixo = __TS__New(Map)
        local T
        T = {
            W = W,
            H = H,
            ruas = ruas,
            nivPx = function(____, px, py)
                local fx = math.floor(px / 4)
                local fy = math.floor(py / 4)
                return if __t(ok(nil, fx, fy)) then __get(nivel, fy * FW + fx) else __get(
                    nivel,
                    math.max(
                        0,
                        math.min(FH - 1, fy)
                    ) * FW + math.max(
                        0,
                        math.min(FW - 1, fx)
                    )
                )
            end,
            tipPx = function(____, px, py)
                local fx = math.max(
                    0,
                    math.min(
                        FW - 1,
                        math.floor(px / 4)
                    )
                )
                local fy = math.max(
                    0,
                    math.min(
                        FH - 1,
                        math.floor(py / 4)
                    )
                )
                return __get(tipo, fy * FW + fx)
            end,
            niv = function(____, x, y) return T:nivPx(x * TS + 8, y * TS + 8) end,
            tip = function(____, x, y) return __get(
                TIPOS,
                T:tipPx(x * TS + 8, y * TS + 8)
            ) end,
            ret = function(____, x, y, w, h, o)
                do
                    local fy = math.floor(y * F + 0.5)
                    while fy < math.floor(__add(y, h) * F + 0.5) do
                        do
                            local fx = math.floor(x * F + 0.5)
                            while fx < math.floor(__add(x, w) * F + 0.5) do
                                pinta(nil, fx, fy, o)
                                fx = fx + 1
                            end
                        end
                        fy = fy + 1
                    end
                end
            end,
            retR = function(____, x, y, w, h, r, o)
                do
                    local fy = math.floor(y * F + 0.5)
                    while fy < math.floor(__add(y, h) * F + 0.5) do
                        do
                            local fx = math.floor(x * F + 0.5)
                            while fx < math.floor(__add(x, w) * F + 0.5) do
                                local cx = (fx + 0.5) / F
                                local cy = (fy + 0.5) / F
                                local dx = math.max(
                                    __add(x, r) - cx,
                                    0,
                                    cx - (__add(x, w) - r)
                                )
                                local dy = math.max(
                                    __add(y, r) - cy,
                                    0,
                                    cy - (__add(y, h) - r)
                                )
                                if dx * dx + dy * dy <= r * r then
                                    pinta(nil, fx, fy, o)
                                end
                                fx = fx + 1
                            end
                        end
                        fy = fy + 1
                    end
                end
            end,
            oval = function(____, cx, cy, rx, ry, o)
                do
                    local fy = math.floor((cy - ry) * F)
                    while fy <= __add(cy, ry) * F do
                        do
                            local fx = math.floor((cx - rx) * F)
                            while fx <= __add(cx, rx) * F do
                                local x = (fx + 0.5) / F
                                local y = (fy + 0.5) / F
                                if ((x - cx) / rx) ^ 2 + ((y - cy) / ry) ^ 2 <= 1 then
                                    pinta(nil, fx, fy, o)
                                end
                                fx = fx + 1
                            end
                        end
                        fy = fy + 1
                    end
                end
            end,
            poli = function(____, pts, o)
                local sm = curva(
                    nil,
                    __call(
                        __call(
                            pts,
                            "concat",
                            __arrL(
                                {__get(pts, 0)},
                                1
                            )
                        ),
                        "map",
                        function(____, ____bindingPattern0)
                            local b
                            local a
                            a = ____bindingPattern0[1]
                            b = ____bindingPattern0[2]
                            return __arrL({a * F, b * F}, 2)
                        end
                    ),
                    2
                )
                local x0 = 1000000000
                local y0 = 1000000000
                local x1 = -1000000000
                local y1 = -1000000000
                for ____, ____value in __iterar((sm)) do
                    local a = ____value[1]
                    local b = ____value[2]
                    x0 = math.min(x0, a)
                    y0 = math.min(y0, b)
                    x1 = math.max(x1, a)
                    y1 = math.max(y1, b)
                end
                do
                    local fy = math.floor(y0)
                    while fy <= y1 do
                        do
                            local fx = math.floor(x0)
                            while fx <= x1 do
                                local px = fx + 0.5
                                local py = fy + 0.5
                                local dentro = false
                                do
                                    local i = 0
                                    local j = __len(sm) - 1
                                    while i < __len(sm) do
                                        local xi, yi = table.unpack(
                                            __get(sm, i),
                                            1,
                                            2
                                        )
                                        local xj, yj = table.unpack(
                                            __get(sm, j),
                                            1,
                                            2
                                        )
                                        if __t(__gt(yi, py) ~= __gt(yj, py) and __lt(px, (xj - xi) * (py - yi) / (yj - yi) + xi)) then
                                            dentro = not __t(dentro)
                                        end
                                        local ____i_14 = i
                                        i = ____i_14 + 1
                                        j = ____i_14
                                    end
                                end
                                if __t(dentro) then
                                    pinta(nil, fx, fy, o)
                                end
                                fx = fx + 1
                            end
                        end
                        fy = fy + 1
                    end
                end
            end,
            curva = function(____, pts, larg, o, suave)
                if suave == nil then
                    suave = true
                end
                local pl = if __t(suave) then curva(
                    nil,
                    __call(
                        pts,
                        "map",
                        function(____, ____bindingPattern0)
                            local b
                            local a
                            a = ____bindingPattern0[1]
                            b = ____bindingPattern0[2]
                            return __arrL({a * TS, b * TS}, 2)
                        end
                    ),
                    2
                ) else __call(
                    pts,
                    "map",
                    function(____, ____bindingPattern0)
                        local b
                        local a
                        a = ____bindingPattern0[1]
                        b = ____bindingPattern0[2]
                        return __arrL({a * TS, b * TS}, 2)
                    end
                )
                local r = larg * TS / 2
                for ____, ____value in __iterar((pl)) do
                    local px = ____value[1]
                    local py = ____value[2]
                    do
                        local fy = math.floor((py - r) / 4)
                        while fy <= (py + r) / 4 do
                            do
                                local fx = math.floor((px - r) / 4)
                                while fx <= (px + r) / 4 do
                                    local dx = fx * 4 + 2 - px
                                    local dy = fy * 4 + 2 - py
                                    if dx * dx + dy * dy <= r * r then
                                        pinta(nil, fx, fy, o)
                                    end
                                    fx = fx + 1
                                end
                            end
                            fy = fy + 1
                        end
                    end
                end
                if __t(if __t(o.tipo) then __call(
                    __arrL({"asfalto", "pedra", "chao", "calcada"}, 4),
                    "includes",
                    o.tipo
                ) else o.tipo) then
                    local id = __len(ruas) + 1
                    local juntas = __arrL({}, 0)
                    local function chave(____, x, y)
                        return __add(
                            __add(
                                __bor(x / 8, 0),
                                ","
                            ),
                            __bor(y / 8, 0)
                        )
                    end
                    do
                        local k = 0
                        while __lt(
                            k,
                            __len(pl)
                        ) do
                            local px, py = table.unpack(
                                __get(pl, k),
                                1,
                                2
                            )
                            local achou = false
                            do
                                local dy = -1
                                while __t(dy <= 1 and not __t(achou)) do
                                    do
                                        local dx = -1
                                        while __t(dx <= 1 and not __t(achou)) do
                                            local e = __call(
                                                eixo,
                                                "get",
                                                chave(nil, px + dx * 8, py + dy * 8)
                                            )
                                            local ____t_17 = __t
                                            local ____t_16 = __t
                                            local ____temp_15 = if __t(e) then e.id ~= id else e
                                            __O[509] = ____temp_15
                                            if ____t_17(if ____t_16(____temp_15) then e.tipo == o.tipo else __O[509]) then
                                                achou = true
                                            end
                                            dx = dx + 1
                                        end
                                    end
                                    dy = dy + 1
                                end
                            end
                            if __t(if __t(achou) then not __t(__call(
                                juntas,
                                "some",
                                function(____, ____bindingPattern0)
                                    local b
                                    local a
                                    a = ____bindingPattern0[1]
                                    b = ____bindingPattern0[2]
                                    return __hypot(a - px, b - py) < 40
                                end
                            )) else achou) then
                                __call(
                                    juntas,
                                    "push",
                                    __arrL({px, py}, 2)
                                )
                            end
                            k = k + 2
                        end
                    end
                    for ____, ____value in __iterar((pl)) do
                        local px = ____value[1]
                        local py = ____value[2]
                        local k = chave(nil, px, py)
                        if not __t(__call(eixo, "has", k)) then
                            __call(eixo, "set", k, {id = id, tipo = o.tipo})
                        end
                    end
                    for ____, ____value in __iterar((juntas)) do
                        local px = ____value[1]
                        local py = ____value[2]
                        local rr = r * 1.75
                        do
                            local fy = math.floor((py - rr) / 4)
                            while fy <= (py + rr) / 4 do
                                do
                                    local fx = math.floor((px - rr) / 4)
                                    while fx <= (px + rr) / 4 do
                                        local dx = fx * 4 + 2 - px
                                        local dy = fy * 4 + 2 - py
                                        if __t(dx * dx + dy * dy <= rr * rr and __get(nivel, fy * FW + fx) ~= 0) then
                                            pinta(nil, fx, fy, {tipo = o.tipo})
                                        end
                                        fx = fx + 1
                                    end
                                end
                                fy = fy + 1
                            end
                        end
                    end
                    __call(ruas, "push", {tipo = o.tipo, larg = larg, pl = pl, juntas = juntas})
                end
                return pl
            end,
            linha = function(____, pts, larg, o) return T:curva(pts, larg, o, false) end,
            livre = function() return true end
        }
        return T
    end
    local function RGB(____, hex)
        local n = __TS__ParseInt(
            __call(hex, "slice", 1),
            16
        )
        return __arrL(
            {
                __band(
                    __shr(n, 16),
                    255
                ),
                __band(
                    __shr(n, 8),
                    255
                ),
                __band(n, 255)
            },
            3
        )
    end
    local PAL = {}
    local function pal(____, hex)
        local ____t_19 = __t
        local ____get_result_18 = __get(PAL, hex)
        __O[510] = ____get_result_18
        return if ____t_19(____get_result_18) then __O[510] else __set(
            PAL,
            hex,
            RGB(nil, hex)
        )
    end
    local function pintarTerreno(self, Tr, extra)
        local W = Tr.W * TS
        local H = Tr.H * TS
        local N = W * H
        local cv = window.document:createElement("canvas")
        cv.width = W
        cv.height = H
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        local lv = __TS__New(window.Int8Array, N)
        local ty = __new("Uint8Array", N)
        do
            local y = 0
            while y < H do
                do
                    local x = 0
                    while x < W do
                        local n1 = vn(nil, x / 28, y / 28, 1) - 0.5
                        local n2 = vn(nil, x / 28, y / 28, 2) - 0.5
                        local m1 = vn(nil, x / 9, y / 9, 3) - 0.5
                        local m2 = vn(nil, x / 9, y / 9, 4) - 0.5
                        local ax = n1 * 12 + m1 * 3
                        local ay = n2 * 12 + m2 * 3
                        local i = y * W + x
                        __set(
                            lv,
                            i,
                            Tr:nivPx(x + ax, y + ay)
                        )
                        __set(
                            ty,
                            i,
                            Tr:tipPx(x + ax * 0.3, y + ay * 0.3)
                        )
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        local wd = __call(
            __new("Int16Array", N),
            "fill",
            -1
        )
        local wh = __new("Int16Array", N)
        local wt = __new("Uint8Array", N)
        local sh = __new("Uint8Array", N)
        local WH = 22
        do
            local x = 0
            while x < W do
                local eY = -100000
                local h = 0
                local eL = -1
                local eT = 0
                do
                    local y = 0
                    while y < H do
                        local i = y * W + x
                        local L = __get(lv, i)
                        if y > 0 then
                            local U = __get(lv, i - W)
                            if __t(U > L and __get(wd, i - W) < 0) then
                                local hh = if L == 0 then (U - 1) * WH + 7 else (U - L) * WH
                                if y - eY < h then
                                    h = math.max(h, y - eY + hh)
                                    eL = math.max(eL, U)
                                else
                                    eY = y
                                    h = hh
                                    eL = U
                                    eT = __get(ty, i - W)
                                end
                            end
                        end
                        if L >= eL then
                            eY = -100000
                        end
                        local d = y - eY
                        if __t(d >= 0 and d < h) then
                            __set(wd, i, d)
                            __set(wh, i, h)
                            __set(wt, i, eT)
                        elseif __t(d >= h and d < h + 6) then
                            __set(sh, i, 6 - (d - h))
                        end
                        y = y + 1
                    end
                end
                x = x + 1
            end
        end
        do
            local y = 0
            while y < H do
                local x = 0
                while x < W do
                    if __get(wd, y * W + x) < 0 then
                        x = x + 1
                        continue
                    end
                    local e = x
                    while __t(e < W and __get(wd, y * W + e) >= 0) do
                        e = e + 1
                    end
                    if e - x < 5 then
                        do
                            local k = x
                            while k < e do
                                __set(wd, y * W + k, -1)
                                __set(sh, y * W + k, 0)
                                k = k + 1
                            end
                        end
                    end
                    x = e
                end
                y = y + 1
            end
        end
        local img = c:createImageData(W, H)
        local px = img.data
        local function put(____, i, col, f)
            if f == nil then
                f = 1
            end
            local o = i * 4
            __set(
                px,
                o,
                math.min(
                    255,
                    __get(col, 0) * f
                )
            )
            __set(
                px,
                o + 1,
                math.min(
                    255,
                    __get(col, 1) * f
                )
            )
            __set(
                px,
                o + 2,
                math.min(
                    255,
                    __get(col, 2) * f
                )
            )
            __set(px, o + 3, 255)
        end
        local G3 = __arrL(
            {
                pal(nil, "#9ad450"),
                pal(nil, "#a6dc58"),
                pal(nil, "#b0e262")
            },
            3
        )
        local M3 = __arrL(
            {
                pal(nil, "#7cbc3c"),
                pal(nil, "#86c442"),
                pal(nil, "#8ecc48")
            },
            3
        )
        local CE3 = __arrL(
            {
                pal(nil, "#9aa04a"),
                pal(nil, "#a8a854"),
                pal(nil, "#8a9a44")
            },
            3
        )
        local AG = {
            fundo = pal(nil, "#3a7ad0"),
            meio = pal(nil, "#4a92e2"),
            raso = pal(nil, "#6ab4f0"),
            espuma = pal(nil, "#e2f4ff"),
            onda = pal(nil, "#7cc2f6")
        }
        local terraCores = __arrL(
            {
                pal(nil, "#c87a4a"),
                pal(nil, "#b86c40"),
                pal(nil, "#d88a56")
            },
            3
        )
        local terraB = pal(nil, "#7a4228")
        local terraE = pal(nil, "#a85e38")
        local terraC = pal(nil, "#e8a06a")
        local pedrinha = pal(nil, "#8a7a6a")
        local pedrinhaC = pal(nil, "#b8a898")
        local function agua(____, x, y)
            return __get(
                lv,
                math.max(
                    0,
                    math.min(H - 1, y)
                ) * W + math.max(
                    0,
                    math.min(W - 1, x)
                )
            ) == 0
        end
        do
            local y = 0
            while y < H do
                do
                    local x = 0
                    while x < W do
                        local i = y * W + x
                        local L = __get(lv, i)
                        local t = __get(ty, i)
                        if __get(wd, i) >= 0 then
                            local d = __get(wd, i)
                            local h = __get(wh, i)
                            local top = __get(wt, i)
                            local lip = 2 + math.floor(h2(
                                nil,
                                __shr(x, 1),
                                7
                            ) * 3)
                            if __t(L == 0 and h <= 8) then
                                put(nil, i, if d < h - 2 then if d < 2 then terraB else terraE else if d == h - 1 then AG.espuma else AG.raso)
                                continue
                            end
                            local ____t_24 = __t
                            local ____t_21 = __t
                            local ____temp_20 = d < lip
                            __O[512] = ____temp_20
                            local ____t_23 = __t
                            local ____call_result_22 = __call(VERDE, "has", top)
                            __O[511] = ____call_result_22
                            if ____t_24(if ____t_21(____temp_20) then if ____t_23(____call_result_22) then __O[511] else top == TI.campo else __O[512]) then
                                put(nil, i, if d == lip - 1 then pal(nil, "#2f5e26") else if d == 0 then pal(nil, "#4f9a34") else pal(nil, "#3c7a2c"))
                                continue
                            end
                            local ____t_27 = __t
                            local ____t_26 = __t
                            local ____temp_25 = d < 2
                            __O[513] = ____temp_25
                            if ____t_27(if ____t_26(____temp_25) then __call(CAMINHO, "has", top) else __O[513]) then
                                put(
                                    nil,
                                    i,
                                    pal(nil, "#7a8086")
                                )
                                continue
                            end
                            if d >= h - 2 then
                                put(nil, i, terraB)
                                continue
                            end
                            local s = d + vn(nil, x / 10, 5, 9) * 5
                            local banda = math.floor(s / 5)
                            local fr = s - banda * 5
                            local col = __get(
                                terraCores,
                                __mod(banda, 3)
                            )
                            local f = 1 - d / h * 0.16
                            if __t(fr < 1 and h2(
                                nil,
                                __shr(x, 2),
                                banda,
                                3
                            ) > 0.45) then
                                col = terraC
                            elseif fr > 4.2 then
                                col = terraE
                            end
                            local ____t_30 = __t
                            local ____t_29 = __t
                            local ____temp_28 = h2(nil, x, 99) < 0.035 and d > 4
                            __O[514] = ____temp_28
                            if ____t_30(if ____t_29(____temp_28) then d < h - 4 else __O[514]) then
                                col = terraB
                            end
                            local sx = __shr(x, 2)
                            local sy = math.floor((d + __band(x, 3)) / 3)
                            if h2(nil, sx, sy + y * 0, 13) > 0.93 then
                                col = if __mod(d, 3) == 0 then pedrinhaC else pedrinha
                            end
                            if __t(__get(wd, i - 1) < 0 or __get(wd, i + 1) < 0) then
                                f = f * 0.72
                            end
                            put(nil, i, col, f)
                            continue
                        end
                        local f = if __t(__get(sh, i)) then 1 - __get(sh, i) * 0.045 else 1
                        if L == 0 then
                            local col = AG.meio
                            local prof = vn(nil, x / 40, y / 40, 6)
                            if prof > 0.62 then
                                col = AG.fundo
                            end
                            if __lt(
                                __add(
                                    __add(
                                        __add(
                                            agua(nil, x - 2, y),
                                            agua(nil, x + 2, y)
                                        ),
                                        agua(nil, x, y - 2)
                                    ),
                                    agua(nil, x, y + 2)
                                ),
                                4
                            ) then
                                col = AG.espuma
                            elseif __lt(
                                __add(
                                    __add(
                                        __add(
                                            __add(
                                                __add(
                                                    agua(nil, x - 5, y),
                                                    agua(nil, x + 5, y)
                                                ),
                                                agua(nil, x, y - 5)
                                            ),
                                            agua(nil, x, y + 5)
                                        ),
                                        agua(nil, x - 4, y - 4)
                                    ),
                                    agua(nil, x + 4, y + 4)
                                ),
                                6
                            ) then
                                col = AG.raso
                            elseif __t(h2(
                                nil,
                                __shr(x, 3),
                                __shr(y, 1),
                                21
                            ) > 0.955 and __band(y, 1) == 0) then
                                col = AG.onda
                            end
                            put(nil, i, col, f)
                            continue
                        end
                        local tint = 1 + (L - 1) * 0.035
                        f = f * tint
                        local col
                        repeat
                            local ____switch232 = t
                            local ____cond232 = ____switch232 == TI.grama or ____switch232 == TI.mata or ____switch232 == TI.cerrado
                            if ____cond232 then
                                do
                                    local P3 = if t == TI.mata then M3 else if t == TI.cerrado then CE3 else G3
                                    local m = vn(nil, x / 36, y / 36, 7)
                                    col = __get(P3, if m < 0.38 then 0 else if m > 0.64 then 2 else 1)
                                    local q = h2(
                                        nil,
                                        __shr(x, 1),
                                        __shr(y, 1),
                                        8
                                    )
                                    if q > 0.93 then
                                        col = if t == TI.cerrado then pal(nil, "#c8c070") else pal(nil, "#c8f07a")
                                    elseif q < 0.05 then
                                        col = if t == TI.cerrado then pal(nil, "#7a7a3a") else pal(nil, "#7cb83c")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.pedra
                            if ____cond232 then
                                do
                                    local r = math.floor(y / 5)
                                    local off = __band(r, 1) * 3
                                    local cl = math.floor((x + off) / 6)
                                    local lx = __mod(x + off, 6)
                                    local ly = __mod(y, 5)
                                    local hv = h2(nil, cl, r, 11)
                                    if __t(lx == 5 or ly == 4) then
                                        col = pal(nil, "#8a9096")
                                    elseif __t(ly == 0 or lx == 0) then
                                        col = pal(nil, if hv > 0.5 then "#e2e5e8" else "#d4d8dc")
                                    elseif ly == 3 then
                                        col = pal(nil, "#a8aeb4")
                                    else
                                        col = pal(nil, if hv > 0.66 then "#c4c8cc" else if hv > 0.33 then "#bcc0c4" else "#b4b9be")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.calcada
                            if ____cond232 then
                                do
                                    local lx = __mod(x, 8)
                                    local ly = __mod(y, 8)
                                    col = pal(nil, if __t(lx == 7 or ly == 7) then "#b8b0a0" else if __t(__mod(
                                        math.floor(x / 8) + math.floor(y / 8),
                                        2
                                    )) then "#e6dfd0" else "#ddd5c4")
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.chao
                            if ____cond232 then
                                do
                                    col = pal(nil, "#d8a06e")
                                    local q = h2(nil, x, y, 12)
                                    if q > 0.9 then
                                        col = pal(nil, "#c08a5a")
                                    elseif q < 0.04 then
                                        col = pal(nil, "#e8b888")
                                    end
                                    if h2(
                                        nil,
                                        __shr(x, 2),
                                        __shr(y, 2),
                                        14
                                    ) > 0.96 then
                                        col = pal(nil, "#a8805a")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.asfalto
                            if ____cond232 then
                                do
                                    col = pal(nil, "#5b6066")
                                    local q = h2(nil, x, y, 15)
                                    if q > 0.88 then
                                        col = pal(nil, "#4c5156")
                                    elseif q < 0.05 then
                                        col = pal(nil, "#6a7076")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.areia
                            if ____cond232 then
                                do
                                    col = pal(nil, if vn(nil, x / 6, y / 3, 16) > 0.7 then "#d8c07a" else "#ead69a")
                                    if h2(nil, x, y, 17) > 0.94 then
                                        col = pal(nil, "#f6eac0")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.plantacao
                            if ____cond232 then
                                do
                                    local r = (y + math.sin(x / 23) * 3) / 5
                                    local fr = r - math.floor(r)
                                    col = pal(nil, if fr < 0.35 then "#6a4228" else if fr < 0.45 then "#8a5a36" else if __t(__mod(
                                        x + math.floor(r) * 2,
                                        3
                                    )) then "#a6dc58" else "#ccf27e")
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.trigo
                            if ____cond232 then
                                do
                                    local r = y + math.sin(x / 17) * 2
                                    local q = h2(
                                        nil,
                                        x,
                                        math.floor(r / 3),
                                        18
                                    )
                                    col = pal(nil, if __t(__band(x, 1)) then if q > 0.5 then "#e8c25a" else "#d8ae48" else if __mod(r, 3) < 1 then "#f4dc80" else "#c89a3a")
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.cafe
                            if ____cond232 then
                                do
                                    local r = (y + math.sin(x / 37) * 4) / 9
                                    local fr = r - math.floor(r)
                                    if fr < 0.62 then
                                        local b = h2(
                                            nil,
                                            math.floor(x / 3),
                                            math.floor(r),
                                            19
                                        )
                                        col = pal(nil, if fr < 0.12 then "#2f5e26" else if __t(b > 0.85 and fr > 0.3) then "#c43c3a" else if __mod(
                                            x + math.floor(fr * 9),
                                            4
                                        ) == 0 then "#58a83c" else "#3f8a30")
                                    else
                                        col = pal(nil, if fr < 0.7 then "#6a4228" else "#8a5a36")
                                    end
                                    break
                                end
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.campo
                            if ____cond232 then
                                col = pal(nil, if __t(__mod(
                                    math.floor(x / 12),
                                    2
                                )) then "#5aa046" else "#66ae50")
                                break
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.quadra
                            if ____cond232 then
                                col = pal(nil, "#3c7ab0")
                                break
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.pista
                            if ____cond232 then
                                col = pal(nil, if h2(nil, x, y, 20) > 0.9 then "#4c5156" else "#565b61")
                                break
                            end
                            ____cond232 = ____cond232 or ____switch232 == TI.nuvem
                            if ____cond232 then
                                do
                                    local m = vn(nil, x / 18, y / 10 + 0, 21)
                                    col = pal(nil, if m > 0.6 then "#ffffff" else if m > 0.4 then "#eef4f8" else "#dde8f0")
                                    break
                                end
                            end
                            do
                                col = __get(G3, 1)
                            end
                        until true
                        local ____get_result_31 = __get(ty, i - W)
                        if ____get_result_31 == nil then
                            ____get_result_31 = t
                        end
                        local tu = ____get_result_31
                        local ____get_result_32 = __get(ty, i + W)
                        if ____get_result_32 == nil then
                            ____get_result_32 = t
                        end
                        local tb = ____get_result_32
                        local ____get_result_33 = __get(ty, i - 1)
                        if ____get_result_33 == nil then
                            ____get_result_33 = t
                        end
                        local tl = ____get_result_33
                        local ____get_result_34 = __get(ty, i + 1)
                        if ____get_result_34 == nil then
                            ____get_result_34 = t
                        end
                        local tr = ____get_result_34
                        if __t(__call(CAMINHO, "has", t)) then
                            local ____t_39 = __t
                            local ____t_38 = __t
                            local ____t_36 = __t
                            local ____temp_35 = y > 0
                            __O[515] = ____temp_35
                            local ____temp_37 = if ____t_36(____temp_35) then __call(VERDE, "has", tu) else __O[515]
                            __O[516] = ____temp_37
                            if ____t_39(if ____t_38(____temp_37) then __get(lv, i - W) == L else __O[516]) then
                                f = f * 0.74
                            else
                                local ____t_44 = __t
                                local ____t_43 = __t
                                local ____t_41 = __t
                                local ____temp_40 = y > 1
                                __O[517] = ____temp_40
                                local ____temp_42 = if ____t_41(____temp_40) then __call(
                                    VERDE,
                                    "has",
                                    __get(ty, i - 2 * W)
                                ) else __O[517]
                                __O[518] = ____temp_42
                                if ____t_44(if ____t_43(____temp_42) then __get(lv, i - 2 * W) == L else __O[518]) then
                                    f = f * 0.88
                                else
                                    local ____t_49 = __t
                                    local ____t_48 = __t
                                    local ____t_46 = __t
                                    local ____call_result_45 = __call(VERDE, "has", tl)
                                    __O[519] = ____call_result_45
                                    local ____temp_47 = if ____t_46(____call_result_45) then __O[519] else __call(VERDE, "has", tr)
                                    __O[520] = ____temp_47
                                    if ____t_49(if ____t_48(____temp_47) then __O[520] else __call(VERDE, "has", tb)) then
                                        f = f * 0.84
                                    end
                                end
                            end
                            local ____t_60 = __t
                            local ____t_51 = __t
                            local ____temp_50 = t == TI.asfalto
                            __O[525] = ____temp_50
                            local ____t_59 = __t
                            local ____t_57 = __t
                            local ____t_55 = __t
                            local ____t_53 = __t
                            local ____temp_52 = tu == TI.pedra or tu == TI.calcada
                            __O[521] = ____temp_52
                            local ____temp_54 = if ____t_53(____temp_52) then __O[521] else tb == TI.pedra
                            __O[522] = ____temp_54
                            local ____temp_56 = if ____t_55(____temp_54) then __O[522] else tb == TI.calcada
                            __O[523] = ____temp_56
                            local ____temp_58 = if ____t_57(____temp_56) then __O[523] else tl == TI.pedra
                            __O[524] = ____temp_58
                            if ____t_60(if ____t_51(____temp_50) then if ____t_59(____temp_58) then __O[524] else tr == TI.pedra else __O[525]) then
                                col = pal(nil, "#d8dcdf")
                            end
                        else
                            local ____t_65 = __t
                            local ____t_64 = __t
                            local ____t_62 = __t
                            local ____call_result_61 = __call(VERDE, "has", t)
                            __O[526] = ____call_result_61
                            local ____temp_63 = if ____t_62(____call_result_61) then __call(CAMINHO, "has", tb) else __O[526]
                            __O[527] = ____temp_63
                            if ____t_65(if ____t_64(____temp_63) then __get(lv, i + W) == L else __O[527]) then
                                col = pal(nil, "#6aa232")
                            end
                        end
                        local ____t_68 = __t
                        local ____t_67 = __t
                        local ____temp_66 = x > 0 and __get(lv, i - 1) < L
                        __O[528] = ____temp_66
                        if ____t_68(if ____t_67(____temp_66) then __get(wd, i - 1) < 0 else __O[528]) then
                            col = pal(nil, "#4f8a28")
                            f = 1
                        else
                            local ____t_71 = __t
                            local ____t_70 = __t
                            local ____temp_69 = x < W - 1 and __get(lv, i + 1) < L
                            __O[529] = ____temp_69
                            if ____t_71(if ____t_70(____temp_69) then __get(wd, i + 1) < 0 else __O[529]) then
                                col = pal(nil, "#4f8a28")
                                f = 1
                            else
                                local ____t_74 = __t
                                local ____t_73 = __t
                                local ____temp_72 = y > 0 and __get(lv, i - W) < L
                                __O[530] = ____temp_72
                                if ____t_74(if ____t_73(____temp_72) then __get(wd, i - W) < 0 else __O[530]) then
                                    col = pal(nil, "#d2f48a")
                                end
                            end
                        end
                        put(nil, i, col, f)
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        c:putImageData(img, 0, 0)
        local P = Px(nil, c)
        local R = P.R
        local function livre(____, x, y)
            x = math.floor(x + 0.5)
            y = math.floor(y + 0.5)
            local ____t_79 = __t
            local ____t_78 = __t
            local ____t_76 = __t
            local ____temp_75 = __lt(x, 2) or __lt(y, 30)
            __O[531] = ____temp_75
            local ____temp_77 = if ____t_76(____temp_75) then __O[531] else __ge(x, W - 2)
            __O[532] = ____temp_77
            if ____t_79(if ____t_78(____temp_77) then __O[532] else __ge(y, H - 2)) then
                return false
            end
            local i = y * W + x
            local ____t_95 = __t
            local ____t_93 = __t
            local ____t_91 = __t
            local ____t_89 = __t
            local ____t_87 = __t
            local ____t_85 = __t
            local ____t_83 = __t
            local ____t_81 = __t
            local ____call_result_80 = __call(
                VERDE,
                "has",
                __get(ty, i)
            )
            __O[533] = ____call_result_80
            local ____temp_82 = if ____t_81(____call_result_80) then __get(wd, i) < 0 else __O[533]
            __O[534] = ____temp_82
            local ____temp_84 = if ____t_83(____temp_82) then not __t(__get(sh, i)) else __O[534]
            __O[535] = ____temp_84
            local ____temp_86 = if ____t_85(____temp_84) then __get(lv, i) > 0 else __O[535]
            __O[536] = ____temp_86
            local ____temp_88 = if ____t_87(____temp_86) then __get(lv, i - 26 * W) == __get(lv, i) else __O[536]
            __O[537] = ____temp_88
            local ____temp_90 = if ____t_89(____temp_88) then __get(wd, i - 26 * W) < 0 else __O[537]
            __O[538] = ____temp_90
            local ____temp_92 = if ____t_91(____temp_90) then __get(lv, i + 3 * W) == __get(lv, i) else __O[538]
            __O[539] = ____temp_92
            local ____temp_94 = if ____t_93(____temp_92) then __get(ty, i - 1) == __get(ty, i) else __O[539]
            __O[540] = ____temp_94
            return if ____t_95(____temp_94) then __get(ty, i + 1) == __get(ty, i) else __O[540]
        end
        do
            local k = 0
            while k < N / 120 do
                local x = math.floor(h2(nil, k, 1, 31) * W)
                local y = math.floor(h2(nil, k, 2, 31) * H)
                local i = y * W + x
                local ____t_102 = __t
                local ____t_101 = __t
                local ____t_99 = __t
                local ____t_97 = __t
                local ____temp_96 = y < 4 or y > H - 2
                __O[541] = ____temp_96
                local ____temp_98 = if ____t_97(____temp_96) then __O[541] else not __t(__call(
                    VERDE,
                    "has",
                    __get(ty, i)
                ))
                __O[542] = ____temp_98
                local ____temp_100 = if ____t_99(____temp_98) then __O[542] else __get(wd, i) >= 0
                __O[543] = ____temp_100
                if ____t_102(if ____t_101(____temp_100) then __O[543] else __get(lv, i) == 0) then
                    continue
                end
                local q = h2(nil, k, 3, 31)
                local esc = if __get(ty, i) == TI.cerrado then "#7a7a3a" else "#3c7a2c"
                local cla = if __get(ty, i) == TI.cerrado then "#d8d080" else "#8ad45a"
                if q < 0.7 then
                    R(
                        nil,
                        x,
                        y - 2,
                        1,
                        3,
                        esc
                    )
                    R(
                        nil,
                        x + 1,
                        y - 3,
                        1,
                        4,
                        esc
                    )
                    R(
                        nil,
                        x + 2,
                        y - 2,
                        1,
                        3,
                        esc
                    )
                    R(
                        nil,
                        x + 1,
                        y - 3,
                        1,
                        1,
                        cla
                    )
                elseif q < 0.86 then
                    local cor = __get(
                        __arrL({
                            "#ffffff",
                            "#f2c94c",
                            "#e86a8a",
                            "#b86ad8",
                            "#f6a04a"
                        }, 5),
                        math.floor(h2(nil, k, 4, 31) * 5)
                    )
                    do
                        local j = 0
                        while j < 4 do
                            local fx = x + h2(nil, k, j, 33) * 9
                            local fy = y + h2(nil, j, k, 33) * 5
                            R(
                                nil,
                                fx,
                                fy + 1,
                                1,
                                2,
                                "#3f8a30"
                            )
                            R(
                                nil,
                                fx - 1,
                                fy,
                                3,
                                1,
                                cor
                            )
                            R(
                                nil,
                                fx,
                                fy - 1,
                                1,
                                1,
                                cor
                            )
                            R(
                                nil,
                                fx,
                                fy,
                                1,
                                1,
                                "#fff6c0"
                            )
                            j = j + 1
                        end
                    end
                elseif q < 0.9 then
                    R(
                        nil,
                        x,
                        y - 2,
                        4,
                        3,
                        "#7a8086"
                    )
                    R(
                        nil,
                        x,
                        y - 2,
                        3,
                        1,
                        "#b8bcc0"
                    )
                else
                    R(
                        nil,
                        x,
                        y - 1,
                        3,
                        2,
                        "#2f5e26"
                    )
                    R(
                        nil,
                        x + 1,
                        y - 2,
                        1,
                        1,
                        "#58a83c"
                    )
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < N / 260 do
                local x = math.floor(h2(nil, k, 5, 35) * W)
                local y = math.floor(h2(nil, k, 6, 35) * H)
                local i = y * W + x
                local ____t_105 = __t
                local ____t_104 = __t
                local ____temp_103 = y < 8 or __get(lv, i) ~= 0
                __O[544] = ____temp_103
                if ____t_105(if ____t_104(____temp_103) then __O[544] else __get(wd, i) >= 0) then
                    continue
                end
                local ____t_109 = __t
                local ____t_107 = __t
                local ____temp_106 = not __t(agua(nil, x - 3, y)) or not __t(agua(nil, x + 3, y))
                __O[545] = ____temp_106
                local ____temp_108 = if ____t_107(____temp_106) then __O[545] else not __t(agua(nil, x, y + 3))
                __O[546] = ____temp_108
                local beira = if ____t_109(____temp_108) then __O[546] else not __t(agua(nil, x, y - 3))
                local ____t_115 = __t
                local ____t_113 = __t
                local ____t_111 = __t
                local ____agua_result_110 = agua(nil, x - 9, y)
                __O[547] = ____agua_result_110
                local ____temp_112 = if ____t_111(____agua_result_110) then agua(nil, x + 9, y) else __O[547]
                __O[548] = ____temp_112
                local ____temp_114 = if ____t_113(____temp_112) then agua(nil, x, y - 7) else __O[548]
                __O[549] = ____temp_114
                local longe = if ____t_115(____temp_114) then agua(nil, x, y + 7) else __O[549]
                if __t(if __t(beira) then h2(nil, k, 7, 35) > 0.45 else beira) then
                    do
                        local j = 0
                        while j < 4 do
                            local hh = 4 + math.floor(h2(nil, k, j, 37) * 4)
                            R(
                                nil,
                                x + j * 2 - 3,
                                y - hh,
                                1,
                                hh,
                                if __t(__mod(j, 2)) then "#3f8a30" else "#58a83c"
                            )
                            if j == 1 then
                                R(
                                    nil,
                                    x + j * 2 - 3,
                                    y - hh - 2,
                                    1,
                                    3,
                                    "#7a4a2a"
                                )
                            end
                            j = j + 1
                        end
                    end
                elseif __t(if __t(longe) then h2(nil, k, 8, 35) > 0.82 else longe) then
                    P:circ(
                        x,
                        y,
                        4,
                        "#2f7a3a",
                        2
                    )
                    P:circ(
                        x,
                        y,
                        3,
                        "#4aa04a",
                        2
                    )
                    R(
                        nil,
                        x,
                        y - 2,
                        1,
                        2,
                        "#3a7ad0"
                    )
                    if h2(nil, k, 9, 35) > 0.7 then
                        R(
                            nil,
                            x - 1,
                            y - 1,
                            3,
                            2,
                            "#f6c0d8"
                        )
                        R(
                            nil,
                            x,
                            y - 2,
                            1,
                            1,
                            "#ffffff"
                        )
                    end
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < W / 3 do
                local x = math.floor(h2(nil, k, 10, 39) * W)
                do
                    local y = 1
                    while y < H do
                        local i = y * W + x
                        local ____t_124 = __t
                        local ____t_123 = __t
                        local ____t_121 = __t
                        local ____t_119 = __t
                        local ____t_117 = __t
                        local ____temp_116 = __get(wd, i) == 0 and __get(wh, i) > 12
                        __O[550] = ____temp_116
                        local ____temp_118 = if ____t_117(____temp_116) then __call(
                            VERDE,
                            "has",
                            __get(wt, i)
                        ) else __O[550]
                        __O[551] = ____temp_118
                        local ____temp_120 = if ____t_119(____temp_118) then __get(wd, i - 3) >= 0 else __O[551]
                        __O[552] = ____temp_120
                        local ____temp_122 = if ____t_121(____temp_120) then __get(wd, i + 3) >= 0 else __O[552]
                        __O[553] = ____temp_122
                        if ____t_124(if ____t_123(____temp_122) then h2(nil, k, y, 41) > 0.55 else __O[553]) then
                            local n = 4 + math.floor(h2(nil, k, 11, 39) * (__get(wh, i) - 8))
                            do
                                local j = 0
                                while j < n do
                                    R(
                                        nil,
                                        x + math.floor(math.sin(j * 0.7 + k) * 0.6 + 0.5),
                                        y + 2 + j,
                                        1,
                                        1,
                                        if __t(__mod(j, 3)) then "#3f8a30" else "#58a83c"
                                    )
                                    if __mod(j, 3) == 1 then
                                        R(
                                            nil,
                                            x + 1,
                                            y + 2 + j,
                                            2,
                                            1,
                                            "#4f9a34"
                                        )
                                    end
                                    j = j + 1
                                end
                            end
                            break
                        end
                        y = y + 1
                    end
                end
                k = k + 1
            end
        end
        Tr.px = {
            W = W,
            H = H,
            lv = lv,
            ty = ty,
            wd = wd,
            sh = sh
        }
        Tr.livre = livre
        Tr.tipoEm = function(____, x, y) return __get(
            TIPOS,
            __get(
                ty,
                math.max(
                    0,
                    math.min(
                        N - 1,
                        math.floor(y + 0.5) * W + math.floor(x + 0.5)
                    )
                )
            )
        ) end
        Tr.nivelEm = function(____, x, y) return __get(
            lv,
            math.max(
                0,
                math.min(
                    N - 1,
                    math.floor(y + 0.5) * W + math.floor(x + 0.5)
                )
            )
        ) end
        Tr.aguaPontos = __arrL({}, 0)
        do
            local k = 0
            while k < N / 300 do
                local x = math.floor(h2(nil, k, 12, 43) * W)
                local y = math.floor(h2(nil, k, 13, 43) * H)
                local ____t_135 = __t
                local ____t_134 = __t
                local ____t_132 = __t
                local ____t_130 = __t
                local ____t_128 = __t
                local ____t_126 = __t
                local ____agua_result_125 = agua(nil, x, y)
                __O[554] = ____agua_result_125
                local ____temp_127 = if ____t_126(____agua_result_125) then agua(nil, x - 6, y) else __O[554]
                __O[555] = ____temp_127
                local ____temp_129 = if ____t_128(____temp_127) then agua(nil, x + 6, y) else __O[555]
                __O[556] = ____temp_129
                local ____temp_131 = if ____t_130(____temp_129) then agua(nil, x, y - 4) else __O[556]
                __O[557] = ____temp_131
                local ____temp_133 = if ____t_132(____temp_131) then agua(nil, x, y + 4) else __O[557]
                __O[558] = ____temp_133
                if ____t_135(if ____t_134(____temp_133) then __get(wd, y * W + x) < 0 else __O[558]) then
                    __call(
                        Tr.aguaPontos,
                        "push",
                        __arrL({x, y}, 2)
                    )
                end
                k = k + 1
            end
        end
        if extra ~= nil then
            extra(nil, P, c, Tr)
        end
        return cv
    end
    ui = nil
    cv = nil
    c = nil
    def = nil
    aberto = false
    raf = 0
    last = 0
    tempo = 0
    M = nil
    cam = __ord({x = 0, y = 0, z = 2}, "x,y,z")
    anim = nil
    sel = -1
    info = false
    viagem = nil
    local drag = nil
    previaTimer = 0
    faiscas = __arrL({}, 0)
    local cache = __TS__New(Map)
    local function css(self)
        if __t(window.document:getElementById("mapa3dCss")) then
            return
        end
        local st = window.document:createElement("style")
        st.id = "mapa3dCss"
        st.textContent = ".m3d{position:fixed;inset:0;z-index:2147483200;background:#8ccfe8;font-family:Pixel,monospace;color:#f6ead0;opacity:0;transition:opacity .35s;touch-action:none;user-select:none;-webkit-user-select:none}.m3d.on{opacity:1}.m3d[hidden]{display:none}\n.m3d canvas.gl{position:absolute;inset:0;width:100%;height:100%;image-rendering:pixelated;cursor:grab}.m3d canvas.gl.arrasta{cursor:grabbing}\n.m3d .topo{position:absolute;left:0;right:0;top:0;display:flex;align-items:center;gap:10px;padding:10px 14px;background:linear-gradient(#2a1a10b0,#2a1a1000);pointer-events:none}.m3d .topo b{font-size:15px;color:#ffd98a;text-shadow:2px 2px #2a1a14}.m3d .topo small{font-size:9px;color:#e8eef2;text-shadow:1px 1px #000}.m3d .topo .bts{pointer-events:auto;margin-left:auto;display:flex;gap:6px}\n.m3d button{font:inherit;font-size:11px;padding:8px 12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}.m3d button:hover,.m3d button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.m3d button:active{transform:translateY(3px);box-shadow:0 1px 0 #2a1a10}.m3d button[disabled]{opacity:.45;cursor:default}\n.m3d .pv{position:absolute;right:14px;top:56px;bottom:14px;width:min(380px,44vw);background:#2a1e14;border:4px solid #e8c66a;box-shadow:0 0 0 4px #120c08,0 14px 30px #0009;display:flex;flex-direction:column;padding:12px;gap:10px;transform:translateX(120%);transition:transform .45s cubic-bezier(.2,.9,.25,1.15)}.m3d .pv.on{transform:none}\n.m3d .pv h3{margin:0;font-size:14px;color:#ffd98a;padding-right:40px}.m3d .pv .sub{font-size:9px;color:#c8b48a;margin-top:-6px}.m3d .pv .ib{position:absolute;right:10px;top:10px;width:34px;height:34px;padding:0;font-size:16px;border-radius:50%}\n.m3d .pv .tela{position:relative;flex:1;min-height:120px;background:#000;border:3px solid #120c08;overflow:hidden}.m3d .pv canvas.prev{width:100%;height:100%;object-fit:cover;image-rendering:pixelated;display:block}\n.m3d .pv .desc{position:absolute;inset:0;background:#120c08ee;padding:12px;font-size:11px;line-height:1.7;color:#f6ead0;opacity:0;transform:translateY(12px);transition:.3s;pointer-events:none;overflow:auto}.m3d .pv .desc.on{opacity:1;transform:none;pointer-events:auto}.m3d .pv .desc b{color:#ffd98a;display:block;margin-bottom:6px}\n.m3d .pv .ir{font-size:14px;padding:12px;background:#e8a83a;color:#1c1408;border-color:#fff2c8}.m3d .pv .ir:hover{background:#ffd98a}.m3d .pv .motivo{font-size:9px;color:#ff9a8a;line-height:1.5}.m3d .pv .x{position:absolute;left:-14px;top:-14px;width:28px;height:28px;padding:0;font-size:12px}\n.m3d .dica{position:absolute;left:14px;bottom:14px;font-size:9px;color:#fff;background:#0b0f14aa;padding:6px 8px;pointer-events:none}.m3d .fade{position:absolute;inset:0;background:#000;opacity:0;pointer-events:none;transition:opacity .45s}\n.m3d .trava{position:absolute;left:0;top:0;transform:translate(-50%,-100%);min-width:170px;max-width:250px;background:#2a1010;border:3px solid #ff5a4a;box-shadow:0 0 0 3px #120606,0 8px 18px #0008;padding:8px 10px;text-align:center;pointer-events:none;opacity:0;transition:opacity .2s}.m3d .trava.on{opacity:1;animation:m3dTrava .35s cubic-bezier(.2,1.6,.4,1)}\n.m3d .trava b{display:block;font-size:11px;color:#ff8a7a;margin-bottom:4px}.m3d .trava .t{font-size:8px;color:#f6ead0;opacity:.85}.m3d .trava .n{font-size:12px;color:#ffd98a;margin:3px 0;line-height:1.5}.m3d .trava small{display:block;font-size:8px;color:#e8c8c0;line-height:1.5;margin-top:4px}.m3d .trava:after{content:'';position:absolute;left:50%;bottom:-11px;margin-left:-8px;border:8px solid transparent;border-top-color:#ff5a4a;border-bottom:0}\n@keyframes m3dTrava{from{transform:translate(-50%,-80%) scale(.6)}to{transform:translate(-50%,-100%) scale(1)}}.m3d .topo .teste{background:#3a2a5a;border-color:#b89ae8;font-size:9px}\n.m3d .zoom{position:absolute;left:14px;bottom:44px;display:flex;flex-direction:column;gap:6px}.m3d .zoom button{width:38px;height:38px;padding:0;font-size:16px}\n@media (max-width:760px),(max-height:520px){.m3d .pv{left:10px;right:10px;top:auto;bottom:10px;width:auto;height:50%}.m3d .pv .tela{min-height:70px}.m3d .dica{display:none}.m3d .zoom{bottom:auto;top:60px}}\n/* celular: título compacto, ficha do lugar ao lado (deitado) ou embaixo (em pé) e faixa com todos os lugares */\n.m3d .lugares{display:none}\n@media (max-width:760px),(max-height:520px){.m3d .topo{padding:6px 8px;gap:6px}.m3d .topo b{font-size:11px}.m3d .topo small{display:none}.m3d .topo .fechar{font-size:9px;padding:6px 8px}.m3d .zoom{top:44px;left:8px}.m3d .zoom button{width:34px;height:34px}\n.m3d .lugares{display:flex;position:absolute;left:0;right:0;bottom:0;gap:6px;overflow-x:auto;padding:8px 8px max(8px,env(safe-area-inset-bottom));background:linear-gradient(#0b0f1400,#0b0f14dd 40%);-webkit-overflow-scrolling:touch;scrollbar-width:none}.m3d .lugares::-webkit-scrollbar{display:none}\n.m3d .lugares button{flex:none;font-size:9px;padding:6px 8px;box-shadow:0 3px 0 #2a1a10;white-space:nowrap}.m3d .lugares button.bloq{background:#3a2a24;color:#c8b8a8;border-color:#8a6a5a}.m3d .lugares button.atual{background:#2a4a6a;border-color:#8ac8ff}\n.m3d.ficha-aberta .lugares{display:none}}\n@media (max-height:520px) and (orientation:landscape){.m3d .pv{left:auto;right:8px;top:8px;bottom:8px;width:44%;height:auto}}"
        window.document.head:appendChild(st)
    end
    local function montarUI(self)
        css(nil)
        ui = window.document:createElement("div")
        ui.className = "m3d"
        ui.hidden = true
        ui:setAttribute("role", "dialog")
        ui.innerHTML = "<canvas class=\"gl\"></canvas><div class=\"topo\"><div><b class=\"t\"></b><br><small class=\"s\"></small></div><div class=\"bts\"><button type=\"button\" class=\"teste\" hidden></button><button type=\"button\" class=\"fechar\" aria-label=\"Fechar mapa\">✕ FECHAR</button></div></div>\n<div class=\"zoom\"><button type=\"button\" class=\"zmais\" aria-label=\"Aproximar\">+</button><button type=\"button\" class=\"zmenos\" aria-label=\"Afastar\">−</button></div>\n<div class=\"pv\" aria-live=\"polite\"><button type=\"button\" class=\"x\" aria-label=\"Voltar ao mapa\">✕</button><h3></h3><div class=\"sub\"></div><button type=\"button\" class=\"ib\" aria-label=\"Sobre o lugar\" title=\"Sobre o lugar\">ⓘ</button><div class=\"tela\"><canvas class=\"prev\" width=\"320\" height=\"180\"></canvas><div class=\"desc\"></div></div><div class=\"motivo\"></div><button type=\"button\" class=\"ir\">IR PARA LÁ ▶</button></div>\n<div class=\"trava\" aria-live=\"assertive\"><b>🔒 TRANCADO</b><div class=\"t\"></div><div class=\"n\"></div><small></small></div><div class=\"lugares\" aria-label=\"Lugares do mapa\"></div><div class=\"dica\">Arraste para passear · toque num lugar · ← → troca · ENTER vai · ESC fecha</div><div class=\"fade\"></div>"
        window.document.body:appendChild(ui)
        cv = ui:querySelector("canvas.gl")
        c = cv:getContext("2d")
        ui:querySelector(".fechar"):addEventListener("click", fechar)
        ui:querySelector(".teste"):addEventListener(
            "click",
            function()
                local ____opt_result_144
                if def ~= nil then
                    ____opt_result_144 = def.teste
                end
                local ____opt_result_145
                if ____opt_result_144 ~= nil then
                    ____opt_result_145 = ____opt_result_144.acao
                end
                local ____opt_result_146
                if ____opt_result_145 ~= nil then
                    ____opt_result_146 = ____opt_result_145(____opt_result_144)
                end
                return ____opt_result_146
            end
        )
        ui:querySelector(".x"):addEventListener(
            "click",
            function() return selecionar(nil, -1) end
        )
        ui:querySelector(".ib"):addEventListener(
            "click",
            function() return mostrarInfo(
                nil,
                not __t(info)
            ) end
        )
        ui:querySelector(".ir"):addEventListener("click", ir)
        ui:querySelector(".zmais"):addEventListener(
            "click",
            function() return zoomPara(nil, cam.z * 1.3) end
        )
        ui:querySelector(".zmenos"):addEventListener(
            "click",
            function() return zoomPara(nil, cam.z / 1.3) end
        )
        local dedos = __TS__New(Map)
        local pinca = nil
        local function distDedos()
            local a, b = table.unpack(
                __arr(__TS__Spread(__iter(__call(dedos, "values")))),
                1,
                2
            )
            local ____t_148 = __t
            local ____hypot_result_147 = __hypot(a.x - b.x, a.y - b.y)
            __O[559] = ____hypot_result_147
            return if ____t_148(____hypot_result_147) then __O[559] else 1
        end
        cv:addEventListener(
            "pointerdown",
            function(____, e)
                __call(dedos, "set", e.pointerId, {x = e.clientX, y = e.clientY})
                if dedos.size == 2 then
                    pinca = {
                        d = distDedos(nil),
                        z = cam.z
                    }
                    drag = nil
                    anim = nil
                    return
                end
                drag = {
                    x = e.clientX,
                    y = e.clientY,
                    cx = cam.x,
                    cy = cam.y,
                    moveu = false
                }
                cv:setPointerCapture(e.pointerId)
            end
        )
        local function soltaDedo(____, e)
            __call(dedos, "delete", e.pointerId)
            if dedos.size < 2 then
                pinca = nil
            end
        end
        cv:addEventListener("pointercancel", soltaDedo)
        cv:addEventListener(
            "pointermove",
            function(____, e)
                if __t(__call(dedos, "has", e.pointerId)) then
                    __call(dedos, "set", e.pointerId, {x = e.clientX, y = e.clientY})
                end
                local ____t_151 = __t
                local ____t_150 = __t
                local ____temp_149 = if __t(pinca) then dedos.size == 2 else pinca
                __O[560] = ____temp_149
                if ____t_151(if ____t_150(____temp_149) then not __t(viagem) else __O[560]) then
                    cam.z = math.max(
                        zMin(nil),
                        math.min(
                            zMax,
                            pinca.z * distDedos(nil) / pinca.d
                        )
                    )
                    limitar(nil)
                    return
                end
                local ____t_154 = __t
                local ____t_153 = __t
                local ____temp_152 = not __t(drag)
                __O[561] = ____temp_152
                if ____t_154(if ____t_153(____temp_152) then __O[561] else viagem) then
                    return
                end
                local dx = e.clientX - drag.x
                local dy = e.clientY - drag.y
                if math.abs(dx) + math.abs(dy) > 6 then
                    drag.moveu = true
                    __call(cv.classList, "add", "arrasta")
                end
                if not __t(drag.moveu) then
                    return
                end
                anim = nil
                cam.x = drag.cx - dx / cam.z
                cam.y = drag.cy - dy / cam.z
                limitar(nil)
            end
        )
        cv:addEventListener(
            "pointerup",
            function(____, e)
                local eraPinca = not not __t(pinca)
                soltaDedo(nil, e)
                cv.classList:remove("arrasta")
                local ____t_157 = __t
                local ____t_156 = __t
                local ____temp_155 = if __t(drag) then not __t(drag.moveu) else drag
                __O[562] = ____temp_155
                if ____t_157(if ____t_156(____temp_155) then not __t(eraPinca) else __O[562]) then
                    clique(nil, e)
                end
                drag = nil
            end
        )
        cv:addEventListener(
            "wheel",
            function(____, e)
                e:preventDefault()
                zoomPara(nil, cam.z * if __gt(e.deltaY, 0) then 0.88 else 1.14)
            end,
            {passive = false}
        )
        window:addEventListener(
            "keydown",
            function(____, e)
                if not __t(aberto) then
                    return
                end
                local k = e.key
                if k == "Escape" then
                    if __t(info) then
                        mostrarInfo(nil, false)
                    elseif sel >= 0 then
                        selecionar(nil, -1)
                    else
                        fechar(nil)
                    end
                elseif __t(k == "ArrowRight" or k == "ArrowDown") then
                    selecionar(
                        nil,
                        __mod(
                            sel + 1,
                            __len(def.locais)
                        )
                    )
                elseif __t(k == "ArrowLeft" or k == "ArrowUp") then
                    selecionar(
                        nil,
                        __mod(
                            sel - 1 + __len(def.locais),
                            __len(def.locais)
                        )
                    )
                elseif __t(k == "Enter" or k == " ") then
                    if sel >= 0 then
                        ir(nil)
                    end
                elseif __t(k == "i" or k == "I") then
                    if sel >= 0 then
                        mostrarInfo(
                            nil,
                            not __t(info)
                        )
                    end
                elseif __t(k == "+" or k == "=") then
                    zoomPara(nil, cam.z * 1.3)
                elseif k == "-" then
                    zoomPara(nil, cam.z / 1.3)
                else
                    return
                end
                e:preventDefault()
                e:stopImmediatePropagation()
            end,
            true
        )
    end
    celular = function() return math.min(window.innerWidth, window.innerHeight) < 560 end
    zCobre = function() return math.max(cv.clientWidth / (M.W + 2 * M.PAD), cv.clientHeight / (M.H + 2 * M.PAD)) * 1.0001 end
    local function zMapa()
        return math.max(cv.clientWidth / M.W, cv.clientHeight / M.H)
    end
    zMin = function() return if __t(celular(nil)) then math.min(cv.clientWidth / (M.W + 2 * M.PAD), cv.clientHeight / (M.H + 2 * M.PAD)) else zCobre(nil) end
    zMax = 5
    local function luzDeDia(self, cv)
        do
            pcall(function()
                local g = cv:getContext("2d")
                local im = g:getImageData(0, 0, cv.width, cv.height)
                local d = im.data
                do
                    local i = 0
                    while __lt(
                        i,
                        __len(d)
                    ) do
                        if not __t(__get(d, i + 3)) then
                            continue
                        end
                        local r = __get(d, i)
                        local gg = __get(d, i + 1)
                        local b = __get(d, i + 2)
                        local L = 0.299 * r + 0.587 * gg + 0.114 * b
                        r = L + (r - L) * 1.2
                        gg = L + (gg - L) * 1.2
                        b = L + (b - L) * 1.12
                        r = r * 1.08 + 16
                        gg = gg * 1.08 + 14
                        b = b * 1.03 + 8
                        __set(d, i, if __gt(r, 255) then 255 else if __lt(r, 0) then 0 else r)
                        __set(d, i + 1, if __gt(gg, 255) then 255 else if __lt(gg, 0) then 0 else gg)
                        __set(d, i + 2, if __gt(b, 255) then 255 else if __lt(b, 0) then 0 else b)
                        i = i + 4
                    end
                end
                g:putImageData(im, 0, 0)
            end)
        end
    end
    local function relevo(self, cv, ox, oy)
        if ox == nil then
            ox = 0
        end
        if oy == nil then
            oy = 0
        end
        do
            pcall(function()
                local g = cv:getContext("2d")
                local w = cv.width
                local h = cv.height
                local im = g:getImageData(0, 0, w, h)
                local d = im.data
                local function Hh(____, x, y)
                    return vn(nil, x / 74, y / 74, 31) * 0.7 + vn(nil, x / 30, y / 30, 32) * 0.3
                end
                do
                    local y = 0
                    while __lt(y, h) do
                        do
                            local x = 0
                            while __lt(x, w) do
                                local i = (y * w + x) * 4
                                if not __t(__get(d, i + 3)) then
                                    continue
                                end
                                local r = __get(d, i)
                                local gg = __get(d, i + 1)
                                local b = __get(d, i + 2)
                                if not __t(__gt(gg, r + 6) and __gt(gg, b + 18)) then
                                    continue
                                end
                                local wx = x - ox
                                local wy = y - oy
                                local sh = (Hh(nil, wx - 3, wy - 3) - Hh(nil, wx + 3, wy + 3)) * 7
                                local alto = (Hh(nil, wx, wy) - 0.5) * 0.16
                                local f = 1 + math.max(
                                    -0.16,
                                    math.min(0.16, sh)
                                ) + alto
                                __set(
                                    d,
                                    i,
                                    math.min(255, r * f)
                                )
                                __set(
                                    d,
                                    i + 1,
                                    math.min(255, gg * f)
                                )
                                __set(
                                    d,
                                    i + 2,
                                    math.min(255, b * f)
                                )
                                x = x + 1
                            end
                        end
                        y = y + 1
                    end
                end
                g:putImageData(im, 0, 0)
            end)
        end
    end
    local function fazerIlha(self, base, o, d)
        local W = base.width
        local H = base.height
        local PAD = if __t(o.margem) then o.margem else 300
        local W2 = W + PAD * 2
        local H2 = H + PAD * 2
        local cv = window.document:createElement("canvas")
        cv.width = W2
        cv.height = H2
        local g = cv:getContext("2d")
        g.imageSmoothingEnabled = false
        local bd = base:getContext("2d"):getImageData(0, 0, W, H).data
        local im = g:createImageData(W2, H2)
        local out = im.data
        local cls = __new("Uint8Array", W2 * H2)
        local trilha = __new("Uint8Array", W2 * H2)
        local function hex(____, h)
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
        local sr = 0
        local sg = 0
        local sb = 0
        local sn = 0
        do
            local k = 0
            while __lt(k, W) do
                for ____, yy in __iterar((__arrL({
                    1,
                    3,
                    5,
                    H - 2,
                    H - 4,
                    H - 6
                }, 6))) do
                    local j = (yy * W + k) * 4
                    local r = __get(bd, j)
                    local gg = __get(bd, j + 1)
                    local b = __get(bd, j + 2)
                    if __t(__gt(gg, r + 6) and __gt(gg, b + 18)) then
                        sr = sr + r
                        sg = sg + gg
                        sb = sb + b
                        sn = sn + 1
                    end
                end
                k = k + 2
            end
        end
        do
            local k = 0
            while __lt(k, H) do
                for ____, xx in __iterar((__arrL({
                    1,
                    3,
                    5,
                    W - 2,
                    W - 4,
                    W - 6
                }, 6))) do
                    local j = (k * W + xx) * 4
                    local r = __get(bd, j)
                    local gg = __get(bd, j + 1)
                    local b = __get(bd, j + 2)
                    if __t(__gt(gg, r + 6) and __gt(gg, b + 18)) then
                        sr = sr + r
                        sg = sg + gg
                        sb = sb + b
                        sn = sn + 1
                    end
                end
                k = k + 2
            end
        end
        local med = if __t(sn) then __arrL({sr / sn, sg / sn, sb / sn}, 3) else hex(nil, "#b4ea6a")
        local function tom(____, f)
            return __call(
                med,
                "map",
                function(____, v) return math.max(
                    0,
                    math.min(
                        255,
                        math.floor(v * f + 0.5)
                    )
                ) end
            )
        end
        local GR = __arrL(
            {
                tom(nil, 0.95),
                tom(nil, 1),
                tom(nil, 1.05)
            },
            3
        )
        local TERRA = __arrL(
            {
                __arrL({214, 180, 128}, 3),
                __arrL({200, 164, 112}, 3)
            },
            2
        )
        local function rua(____, r, g, b)
            local ____t_161 = __t
            local ____t_159 = __t
            local ____temp_158 = math.abs(r - g) < 22 and math.abs(g - b) < 26
            __O[563] = ____temp_158
            local ____temp_160 = if ____t_159(____temp_158) then __gt(r, 140) else __O[563]
            __O[564] = ____temp_160
            return if ____t_161(____temp_160) then not __t(__gt(g, r + 6) and __gt(g, b + 18)) else __O[564]
        end
        local AR = __call(
            __arrL({"#f6e6ae", "#eedb98", "#fbefc4"}, 3),
            "map",
            hex
        )
        local RASO = hex(nil, "#8ad8f4")
        local MEIO = hex(nil, "#62bee8")
        local function margem(____, cx, cy)
            return 34 + vn(nil, cx / 58 + 3.1, cy / 58 + 7.7, 41) * 58 + vn(nil, cx / 19, cy / 19, 42) * 10
        end
        do
            local Y = 0
            while __lt(Y, H2) do
                do
                    local X = 0
                    while __lt(X, W2) do
                        local x = X - PAD
                        local y = Y - PAD
                        local ____t_166 = __t
                        local ____t_165 = __t
                        local ____t_163 = __t
                        local ____temp_162 = x >= 0 and __lt(x, W)
                        __O[565] = ____temp_162
                        local ____temp_164 = if ____t_163(____temp_162) then y >= 0 else __O[565]
                        __O[566] = ____temp_164
                        if ____t_166(if ____t_165(____temp_164) then __lt(y, H) else __O[566]) then
                            __set(cls, Y * W2 + X, 1)
                            continue
                        end
                        local cx = if x < 0 then 0 else if __ge(x, W) then W - 1 else x
                        local cy = if y < 0 then 0 else if __ge(y, H) then H - 1 else y
                        local dd = __hypot(x - cx, y - cy)
                        local m = margem(nil, cx, cy)
                        local i = (Y * W2 + X) * 4
                        local col = nil
                        local k = 0
                        do
                            local function br(____, xx, yy)
                                xx = math.max(
                                    0,
                                    math.min(W - 1, xx)
                                )
                                yy = math.max(
                                    0,
                                    math.min(H - 1, yy)
                                )
                                local q = (yy * W + xx) * 4
                                local ____t_168 = __t
                                local ____temp_167 = __gt(
                                    __get(bd, q),
                                    236
                                ) and __gt(
                                    __get(bd, q + 1),
                                    236
                                )
                                __O[567] = ____temp_167
                                return if ____t_168(____temp_167) then __gt(
                                    __get(bd, q + 2),
                                    236
                                ) else __O[567]
                            end
                            local ____t_177 = __t
                            local ____t_176 = __t
                            local ____t_174 = __t
                            local ____t_172 = __t
                            local ____t_170 = __t
                            local ____br_result_169 = br(nil, cx, cy)
                            __O[568] = ____br_result_169
                            local ____temp_171 = if ____t_170(____br_result_169) then br(nil, cx - 10, cy - 10) else __O[568]
                            __O[569] = ____temp_171
                            local ____temp_173 = if ____t_172(____temp_171) then br(nil, cx + 10, cy + 10) else __O[569]
                            __O[570] = ____temp_173
                            local ____temp_175 = if ____t_174(____temp_173) then br(nil, cx - 10, cy + 10) else __O[570]
                            __O[571] = ____temp_175
                            if ____t_177(if ____t_176(____temp_175) then br(nil, cx + 10, cy - 10) else __O[571]) then
                                if dd < 14 then
                                    __set(
                                        out,
                                        i,
                                        __get(RASO, 0)
                                    )
                                    __set(
                                        out,
                                        i + 1,
                                        __get(RASO, 1)
                                    )
                                    __set(
                                        out,
                                        i + 2,
                                        __get(RASO, 2)
                                    )
                                    __set(out, i + 3, 255 - dd * 6)
                                    __set(cls, Y * W2 + X, 3)
                                end
                                continue
                            end
                        end
                        if dd < m - 11 then
                            local j = (cy * W + cx) * 4
                            local er = __get(bd, j)
                            local eg = __get(bd, j + 1)
                            local eb = __get(bd, j + 2)
                            if __t(__gt(eb, er + 40) and __gt(eb, eg - 10)) then
                                col = __arrL({er, eg, eb}, 3)
                                k = 3
                            else
                                local ____t_180 = __t
                                local ____t_179 = __t
                                local ____rua_result_178 = rua(nil, er, eg, eb)
                                __O[572] = ____rua_result_178
                                if ____t_180(if ____t_179(____rua_result_178) then dd < m - 16 else __O[572]) then
                                    col = __get(TERRA, if vn(nil, x / 5, y / 5, 45) < 0.5 then 0 else 1)
                                    k = 5
                                else
                                    local mx = if x < 0 then -x - 1 else if __ge(x, W) then 2 * W - 1 - x else x
                                    local my = if y < 0 then -y - 1 else if __ge(y, H) then 2 * H - 1 - y else y
                                    mx = math.max(
                                        0,
                                        math.min(W - 1, mx)
                                    )
                                    my = math.max(
                                        0,
                                        math.min(H - 1, my)
                                    )
                                    local q = (my * W + mx) * 4
                                    local mr = __get(bd, q)
                                    local mg = __get(bd, q + 1)
                                    local mb = __get(bd, q + 2)
                                    if __t(__gt(mg, mr + 6) and __gt(mg, mb + 18)) then
                                        col = __arrL({mr, mg, mb}, 3)
                                    else
                                        local n = vn(nil, x / 22, y / 22, 43)
                                        local d2 = vn(nil, x / 3, y / 3, 46)
                                        col = __get(GR, if n < 0.4 then 0 else if n > 0.62 then 2 else 1)
                                        if d2 > 0.78 then
                                            col = tom(nil, 0.86)
                                        elseif d2 < 0.12 then
                                            col = tom(nil, 1.1)
                                        end
                                    end
                                    k = 1
                                end
                            end
                        elseif dd < m then
                            local n = vn(nil, x / 9, y / 9, 44)
                            col = __get(AR, if n < 0.35 then 1 else if n > 0.7 then 2 else 0)
                            if dd > m - 3 then
                                col = __get(AR, 1)
                            end
                            k = 2
                        elseif dd < m + 13 then
                            col = RASO
                            k = 3
                        elseif dd < m + 30 then
                            col = MEIO
                            k = 3
                            __set(out, i + 3, 150)
                        end
                        if __t(col) then
                            __set(
                                out,
                                i,
                                __get(col, 0)
                            )
                            __set(
                                out,
                                i + 1,
                                __get(col, 1)
                            )
                            __set(
                                out,
                                i + 2,
                                __get(col, 2)
                            )
                            if not __t(__get(out, i + 3)) then
                                __set(out, i + 3, 255)
                            end
                            __set(cls, Y * W2 + X, if k == 5 then 1 else k)
                            if k == 5 then
                                __set(trilha, Y * W2 + X, 1)
                            end
                        end
                        X = X + 1
                    end
                end
                Y = Y + 1
            end
        end
        g:putImageData(im, 0, 0)
        relevo(nil, cv, PAD, PAD)
        local costa = __arrL({}, 0)
        local P = Px(nil, g)
        g:save()
        g:translate(PAD, PAD)
        do
            local Y = 2
            while Y < H2 - 2 do
                do
                    local X = 2
                    while X < W2 - 2 do
                        if __get(cls, Y * W2 + X) ~= 2 then
                            continue
                        end
                        local ____t_185 = __t
                        local ____t_184 = __t
                        local ____t_182 = __t
                        local ____temp_181 = __get(cls, Y * W2 + X + 3) == 3 or __get(cls, Y * W2 + X - 3) == 3
                        __O[573] = ____temp_181
                        local ____temp_183 = if ____t_182(____temp_181) then __O[573] else __get(cls, (Y + 3) * W2 + X) == 3
                        __O[574] = ____temp_183
                        if ____t_185(if ____t_184(____temp_183) then __O[574] else __get(cls, (Y - 3) * W2 + X) == 3) then
                            local x = X - PAD
                            local y = Y - PAD
                            local cx = math.max(
                                0,
                                math.min(W - 1, x)
                            )
                            local cy = math.max(
                                0,
                                math.min(H - 1, y)
                            )
                            local ____t_187 = __t
                            local ____hypot_result_186 = __hypot(x - cx, y - cy)
                            __O[575] = ____hypot_result_186
                            local dd = if ____t_187(____hypot_result_186) then __O[575] else 1
                            __call(
                                costa,
                                "push",
                                __arrL(
                                    {
                                        x,
                                        y,
                                        (x - cx) / dd,
                                        (y - cy) / dd,
                                        hash(nil, X, Y) * 6
                                    },
                                    5
                                )
                            )
                        end
                        X = X + 3
                    end
                end
                Y = Y + 3
            end
        end
        local farol = nil
        local melhor = 0
        do
            local k = 0
            while k < __len(costa) do
                local x, y, nx, ny = table.unpack(
                    __get(costa, k),
                    1,
                    4
                )
                local tx = x - nx * 6
                local ty = y - ny * 6
                local h = hash(nil, k, 3)
                if h < 0.55 then
                    P:coqueiro(tx, ty)
                elseif h < 0.7 then
                    P:pedra(tx, ty + 2)
                elseif h < 0.78 then
                    P:R(
                        tx - 6,
                        ty - 1,
                        12,
                        5,
                        __get(
                            __arrL({"#e8433a", "#3c6aa8", "#f2c94c"}, 3),
                            __mod(k, 3)
                        )
                    )
                    P:R(
                        tx - 1,
                        ty - 10,
                        1,
                        10,
                        "#7a7a7a"
                    )
                    do
                        local j = 0
                        while j < 9 do
                            P:R(
                                tx - 6 + j * 1.4,
                                ty - 11 + math.abs(j - 4) * 0.5,
                                2,
                                2,
                                if __t(__mod(j, 2)) then "#f2f2ee" else "#e8433a"
                            )
                            j = j + 1
                        end
                    end
                end
                local cxx = math.max(
                    0,
                    math.min(W - 1, x)
                )
                local cyy = math.max(
                    0,
                    math.min(H - 1, y)
                )
                local dd = __hypot(x - cxx, y - cyy)
                if __t(dd > melhor and x > W * 0.5) then
                    melhor = dd
                    farol = __arrL({x - nx * 16, y - ny * 16}, 2)
                end
                k = k + 7
            end
        end
        local function livre(____, x, y, r)
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({0, 0}, 2),
                    __arrL(
                        {
                            __TS__Number(-r),
                            0
                        },
                        2
                    ),
                    __arrL({r, 0}, 2),
                    __arrL(
                        {
                            0,
                            __TS__Number(-r)
                        },
                        2
                    ),
                    __arrL({0, 3}, 2)
                },
                5
            ))) do
                local dx = ____value[1]
                local dy = ____value[2]
                local X = math.floor(__add(
                    __add(x, dx),
                    PAD
                ) + 0.5)
                local Y = math.floor(__add(
                    __add(y, dy),
                    PAD
                ) + 0.5)
                local ____t_196 = __t
                local ____t_195 = __t
                local ____t_193 = __t
                local ____t_191 = __t
                local ____t_189 = __t
                local ____temp_188 = X < 0 or Y < 0
                __O[576] = ____temp_188
                local ____temp_190 = if ____t_189(____temp_188) then __O[576] else __ge(X, W2)
                __O[577] = ____temp_190
                local ____temp_192 = if ____t_191(____temp_190) then __O[577] else __ge(Y, H2)
                __O[578] = ____temp_192
                local ____temp_194 = if ____t_193(____temp_192) then __O[578] else __get(cls, Y * W2 + X) ~= 1
                __O[579] = ____temp_194
                if ____t_196(if ____t_195(____temp_194) then __O[579] else __get(trilha, Y * W2 + X)) then
                    return false
                end
            end
            local ____t_200 = __t
            local ____t_198 = __t
            local ____temp_197 = __lt(
                x,
                __TS__Number(-r) - 4
            ) or __gt(
                x,
                __add(W, r) + 4
            )
            __O[580] = ____temp_197
            local ____temp_199 = if ____t_198(____temp_197) then __O[580] else __lt(y, -4)
            __O[581] = ____temp_199
            return if ____t_200(____temp_199) then __O[581] else __gt(y, H + 34)
        end
        local ocupados = __arrL({}, 0)
        do
            local k = 0
            while k < 1400 do
                local x = __TS__Number(-PAD) + hash(nil, k, 7) * W2
                local y = __TS__Number(-PAD) + hash(nil, k, 8) * H2
                local h = hash(nil, k, 9)
                local raio = if h < 0.45 then 14 else if h < 0.62 then 12 else if h < 0.66 then 26 else 7
                local ____t_203 = __t
                local ____t_202 = __t
                local ____temp_201 = not __t(livre(nil, x, y, raio))
                __O[582] = ____temp_201
                if ____t_203(if ____t_202(____temp_201) then __O[582] else __call(
                    ocupados,
                    "some",
                    function(____, ____bindingPattern0)
                        local ____or
                        local oy
                        local ox
                        ox = ____bindingPattern0[1]
                        oy = ____bindingPattern0[2]
                        ____or = ____bindingPattern0[3]
                        return __hypot(ox - x, oy - y) < (____or + raio) * 0.9
                    end
                )) then
                    continue
                end
                __call(
                    ocupados,
                    "push",
                    __arrL({x, y, raio}, 3)
                )
                if h < 0.3 then
                    P:arvore(
                        x,
                        y,
                        0.8 + hash(nil, k, 10) * 0.4,
                        if __t(__mod(k, 5)) then "verde" else "amarela",
                        k
                    )
                elseif h < 0.45 then
                    P:cacaueiro(
                        x,
                        y,
                        0.9 + hash(nil, k, 10) * 0.3,
                        k
                    )
                elseif h < 0.55 then
                    P:arbusto(
                        x,
                        y,
                        k,
                        hash(nil, k, 11) > 0.5
                    )
                elseif h < 0.62 then
                    P:coqueiro(x, y)
                elseif h < 0.66 then
                    P:casa(
                        x - 12,
                        y - 20,
                        24,
                        20,
                        {
                            parede = __get(
                                __arrL({"#f2e6d4", "#d8ecf6", "#f6dede", "#f2ecc0"}, 4),
                                __mod(k, 4)
                            ),
                            telhado = __get(
                                __arrL({"#d0683a", "#b84a3a", "#c8783a"}, 3),
                                __mod(k, 3)
                            )
                        }
                    )
                    P:cercaH(x - 22, y + 8, 44)
                elseif h < 0.86 then
                    P:flores(
                        x - 6,
                        y - 4,
                        __get(
                            __arrL(
                                {
                                    __arrL({"#ffe14a", "#ffffff"}, 2),
                                    __arrL({"#ff8ab0", "#ffe14a"}, 2),
                                    __arrL({"#c8a0ff", "#ffffff"}, 2),
                                    __arrL({"#ff6a4a", "#ffe14a"}, 2)
                                },
                                4
                            ),
                            __mod(k, 4)
                        )
                    )
                else
                    P:pedra(x, y)
                end
                k = k + 1
            end
        end
        if __t(farol) then
            local fx, fy = table.unpack(farol, 1, 2)
            local R = P.R
            P:sombra(
                fx + 4,
                fy + 2,
                10,
                3,
                0.3
            )
            R(
                nil,
                fx - 7,
                fy - 4,
                14,
                6,
                "#8a9096"
            )
            do
                local j = 0
                while j < 7 do
                    local w = 10 - j * 0.7
                    R(
                        nil,
                        fx - w / 2,
                        fy - 8 - j * 6,
                        w,
                        6,
                        if __t(__mod(j, 2)) then "#f2f2ee" else "#c43c3a"
                    )
                    j = j + 1
                end
            end
            R(
                nil,
                fx - 5,
                fy - 52,
                10,
                8,
                "#2a3a4a"
            )
            R(
                nil,
                fx - 3,
                fy - 50,
                6,
                4,
                "#fff2b0"
            )
            R(
                nil,
                fx - 6,
                fy - 54,
                12,
                3,
                "#c43c3a"
            )
            R(
                nil,
                fx - 2,
                fy - 58,
                4,
                4,
                "#2a3a4a"
            )
        end
        local eolicas = __arrL({}, 0)
        do
            local k = 0
            while __t(k < 400 and __lt(
                __len(eolicas),
                if __t(o.eolicas) then o.eolicas else 0
            )) do
                local x = __TS__Number(-PAD) + hash(nil, k, 21) * W2
                local y = __TS__Number(-PAD) + hash(nil, k, 22) * H2
                local X = math.floor(x + PAD + 0.5)
                local Y = math.floor(y + PAD + 0.5)
                local ____t_218 = __t
                local ____t_217 = __t
                local ____t_211 = __t
                local ____t_209 = __t
                local ____t_207 = __t
                local ____t_205 = __t
                local ____temp_204 = X < 0 or Y < 0
                __O[583] = ____temp_204
                local ____temp_206 = if ____t_205(____temp_204) then __O[583] else __ge(X, W2)
                __O[584] = ____temp_206
                local ____temp_208 = if ____t_207(____temp_206) then __O[584] else __ge(Y, H2)
                __O[585] = ____temp_208
                local ____temp_210 = if ____t_209(____temp_208) then __O[585] else __get(cls, Y * W2 + X) ~= 1
                __O[588] = ____temp_210
                local ____t_215 = __t
                local ____t_213 = __t
                local ____temp_212 = x > -10 and __lt(x, W + 10)
                __O[586] = ____temp_212
                local ____temp_214 = if ____t_213(____temp_212) then y > -10 else __O[586]
                __O[587] = ____temp_214
                local ____temp_216 = if ____t_211(____temp_210) then __O[588] else if ____t_215(____temp_214) then __lt(y, H + 10) else __O[587]
                __O[589] = ____temp_216
                if ____t_218(if ____t_217(____temp_216) then __O[589] else __call(
                    eolicas,
                    "some",
                    function(____, ____bindingPattern0)
                        local ey
                        local ex
                        ex = ____bindingPattern0[1]
                        ey = ____bindingPattern0[2]
                        return __hypot(ex - x, ey - y) < 60
                    end
                )) then
                    continue
                end
                __call(
                    eolicas,
                    "push",
                    __arrL(
                        {
                            x,
                            y,
                            hash(nil, k, 23) * 6
                        },
                        3
                    )
                )
                P:sombra(
                    x + 6,
                    y + 1,
                    9,
                    3,
                    0.28
                )
                P:R(
                    x - 4,
                    y - 2,
                    9,
                    4,
                    "#a8aeb4"
                )
                k = k + 1
            end
        end
        g:restore()
        return {
            cv = cv,
            pad = PAD,
            costa = costa,
            farol = farol,
            eolicas = eolicas
        }
    end
    local function montar(self, d)
        local Tr = Terreno(
            nil,
            __get(d.lajotas, 0),
            __get(d.lajotas, 1)
        )
        d:terreno(Tr)
        local base = pintarTerreno(nil, Tr, d.chao)
        local W = base.width
        local H = base.height
        local obj = window.document:createElement("canvas")
        obj.width = W
        obj.height = H
        local oc = obj:getContext("2d")
        oc.imageSmoothingEnabled = false
        local lista = __arrL({}, 0)
        local ____this_220
        ____this_220 = d
        local ____opt_219 = ____this_220.objetos
        if ____opt_219 ~= nil then
            ____opt_219(
                ____this_220,
                function(____, y, f) return __call(
                    lista,
                    "push",
                    __arrL({y, f}, 2)
                ) end,
                Tr
            )
        end
        __call(
            lista,
            "sort",
            function(____, a, b) return __get(a, 0) - __get(b, 0) end
        )
        local PO = Px(nil, oc)
        for ____, ____value in __iterar((lista)) do
            local f = ____value[2]
            f(nil, PO)
        end
        local locs = __call(
            d.locais,
            "map",
            function(____, L)
                local bx0, by0, bw, bh = table.unpack(L.caixa, 1, 4)
                local dx, dy = table.unpack(if __t(L.desloc) then L.desloc else __arrL({0, 0}, 2), 1, 2)
                local bx = __add(bx0, dx)
                local by = __add(by0, dy)
                local s = window.document:createElement("canvas")
                s.width = bw
                s.height = bh
                local sc = s:getContext("2d")
                sc.imageSmoothingEnabled = false
                sc:translate(
                    __TS__Number(-bx0),
                    __TS__Number(-by0)
                )
                L:desenho(Px(nil, sc))
                local esc = window.document:createElement("canvas")
                esc.width = bw
                esc.height = bh
                local ec = esc:getContext("2d")
                ec:drawImage(s, 0, 0)
                ec.globalCompositeOperation = "source-atop"
                ec.fillStyle = "rgba(8,10,26,.62)"
                ec:fillRect(0, 0, bw, bh)
                return {
                    s = s,
                    esc = esc,
                    bx = bx,
                    by = by,
                    bw = bw,
                    bh = bh,
                    pulo = nil,
                    tremor = 0
                }
            end
        )
        luzDeDia(nil, base)
        luzDeDia(nil, obj)
        for ____, L in __iterar((locs)) do
            luzDeDia(nil, L.s)
            local ec = L.esc:getContext("2d")
            ec.globalCompositeOperation = "source-over"
            ec:clearRect(0, 0, L.bw, L.bh)
            ec:drawImage(L.s, 0, 0)
            ec.globalCompositeOperation = "source-atop"
            ec.fillStyle = "rgba(40,50,84,.30)"
            ec:fillRect(0, 0, L.bw, L.bh)
            ec.globalCompositeOperation = "source-over"
        end
        if __t(d.relevo) then
            relevo(nil, base)
        end
        local ilha = if __t(d.ilha) then fazerIlha(nil, base, d.ilha, d) else nil
        local aves = __arrayFrom(
            {length = 4},
            function(____, _, k) return {
                x = math.random() * W,
                y = 80 + k * (H - 160) / 4,
                v = 34 + math.random() * 22,
                dir = if __t(__mod(k, 2)) then -1 else 1,
                n = 4 + __mod(k, 3),
                fase = math.random() * 6
            } end
        )
        local borbo = __arrayFrom(
            {length = 14},
            function(____, _, k) return {
                x = math.random() * W,
                y = math.random() * H,
                fase = math.random() * 9,
                cor = __get(
                    __arrL({
                        "#ffe14a",
                        "#ff8ad0",
                        "#ffffff",
                        "#8ad8ff",
                        "#ffb04a"
                    }, 5),
                    __mod(k, 5)
                )
            } end
        )
        local parapentes = if __t(ilha) then __arrayFrom(
            {length = if __t(d.ilha.parapentes) then d.ilha.parapentes else 0},
            function(____, _, k) return {
                x = W * (0.2 + k * 0.3),
                y = H * (0.3 + __mod(k, 2) * 0.35),
                r = 40 + k * 14,
                fase = k * 2,
                cor = __get(
                    __arrL({"#e8433a", "#f2c94c", "#3c8ab0", "#9a52c0"}, 4),
                    __mod(k, 4)
                )
            } end
        ) else __arrL({}, 0)
        local balao = if __t(if __t(ilha) then d.ilha.balao else ilha) then {x = -60, y = H * 0.35} else nil
        local barcos = if __t(ilha) then __call(
            __arrL({0, 1, 2}, 3),
            "map",
            function(____, k) return {
                a = k * 2.1,
                v = 0.05 + k * 0.015,
                cor = __get(
                    __arrL({"#e8433a", "#f2c94c", "#3c6aa8"}, 3),
                    k
                )
            } end
        ) else __arrL({}, 0)
        local golfinhos = if __t(ilha) then __call(
            __arrL({0, 1, 2, 3}, 4),
            "map",
            function(____, k) return {a = k * 1.6 + 0.7, fase = k * 2.3} end
        ) else __arrL({}, 0)
        return {
            base = base,
            obj = obj,
            locs = locs,
            W = W,
            H = H,
            agua = if __t(Tr.aguaPontos) then Tr.aguaPontos else __arrL({}, 0),
            Tr = Tr,
            aves = aves,
            borbo = borbo,
            ilha = ilha,
            PAD = if __t(ilha) then ilha.pad else 0,
            barcos = barcos,
            golfinhos = golfinhos,
            parapentes = parapentes,
            balao = balao
        }
    end
    local function abrir(self, d)
        if not __t(ui) then
            montarUI(nil)
        end
        def = d
        if not __t(__call(cache, "has", d.chave)) then
            __call(
                cache,
                "set",
                d.chave,
                montar(nil, d)
            )
        end
        M = __call(cache, "get", d.chave)
        ui:querySelector(".t").textContent = d.titulo
        ui:querySelector(".s").textContent = if __t(d.subtitulo) then d.subtitulo else ""
        local bt = ui:querySelector(".teste")
        bt.hidden = not __t(d.teste)
        local ____t_223 = __t
        local ____opt_221 = d.teste
        if ____opt_221 ~= nil then
            ____opt_221 = ____opt_221.rotulo
        end
        __O[590] = ____opt_221
        bt.textContent = if ____t_223(____opt_221) then __O[590] else ""
        mostrarTrava(nil, -1)
        ui.hidden = false
        window:requestAnimationFrame(function() return __call(ui.classList, "add", "on") end)
        aberto = true
        sel = -1
        info = false
        viagem = nil
        faiscas = __arrL({}, 0)
        rastro = __arrL({}, 0)
        resize(nil)
        local atual = __call(
            d.locais,
            "findIndex",
            function(____, L) return L.atual end
        )
        local foco = if __ge(atual, 0) then centro(nil, atual) else {x = M.W / 2, y = M.H / 2}
        cam = {
            x = M.W / 2,
            y = M.H / 2,
            z = zMin(nil)
        }
        limitar(nil)
        anim = {
            de = __assign({}, cam),
            para = {x = foco.x, y = foco.y, z = if __t(celular(nil)) then math.min(
                zMax,
                math.max(
                    zMin(nil) * 1.15,
                    zCobre(nil) * 0.9
                )
            ) else math.min(
                zMax,
                zMapa(nil) * 1.9
            )},
            t = -0.25,
            dur = 1.4,
            f = ease
        }
        montarLugares(nil)
        ui:querySelector(".pv").classList:remove("on")
        ui:querySelector(".fade").style.opacity = 0
        mostrarInfo(nil, false)
        last = window.performance:now()
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(loop)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        if __ge(atual, 0) then
            window:setTimeout(
                function()
                    local ____t_225 = __t
                    local ____temp_224 = if __t(aberto) then sel < 0 else aberto
                    __O[591] = ____temp_224
                    return if ____t_225(____temp_224) then selecionar(nil, atual) else __O[591]
                end,
                1500
            )
        end
        return true
    end
    centro = function(____, i)
        local L = __get(M.locs, i)
        return {x = L.bx + L.bw / 2, y = L.by + L.bh * 0.6}
    end
    travaI = -1
    travaAte = 0
    rastro = __arrL({}, 0)
    window.Mapa3D = __ord(
        {
            abrir = abrir,
            fechar = fechar,
            aberto = function() return aberto end,
            selecionar = function(____, id)
                local ____callq_336 = __callq
                local ____opt_result_335
                if def ~= nil then
                    ____opt_result_335 = def.locais
                end
                local ____callq_336_result_337 = ____callq_336(
                    ____opt_result_335,
                    "findIndex",
                    function(____, L) return L.id == id end
                )
                if ____callq_336_result_337 == nil then
                    ____callq_336_result_337 = -1
                end
                local i = ____callq_336_result_337
                if __ge(i, 0) then
                    selecionar(nil, i)
                end
            end,
            ir = ir,
            info = mostrarInfo,
            arte = __ord({
                Px = Px,
                COR = COR,
                shade = shade,
                hash = hash,
                TS = TS,
                curva = curva,
                trilho = trilho,
                vn = vn
            }, "Px,COR,shade,hash,TS,curva,trilho,vn")
        },
        "abrir,fechar,aberto,selecionar,ir,info,arte"
    )
end)(nil)
return ____exports
