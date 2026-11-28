--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __imul, __lenq, __callq, __mod, __ord, __arrL, __iterar = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__imul, __JSR.__lenq, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar
local __t, __get, __set, __arr, __len, __call, __add, __new, __iter, __assign, __arrayFrom, __bor = __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__arrayFrom, __JSR.__bor
local __band, __bxor, __shr, __ushr, __hypot, __re, __re_test, __re_replace = __JSR.__band, __JSR.__bxor, __JSR.__shr, __JSR.__ushr, __JSR.__hypot, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
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
    local Px, zoomPara, limitar, moverSimples, irSimples, desenharSimples, fechar, selecionar, montarLugares, mostrarTrava, mostrarInfo, ir, montarRota, pontoRota, poeira, clique, resize, placaNome, cadeado, loop, ease, easeOut, hash, COR, shade, ui, cv, c, def, aberto, raf, last, tempo, M, cam, anim, sel, info, viagem, previaTimer, faiscas, celular, zCobre, zMin, zMax, SIMPLES, LS, colsSimples, centro, travaI, travaAte, rastro
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
                local ____t_result_3
                local ____t_2 = __t
                local ____get_result_1 = __get(
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
                __O[515] = ____get_result_1
                if ____t_2(____get_result_1) then
                    ____t_result_3 = __O[515]
                else
                    ____t_result_3 = __arrL({
                        "#24501f",
                        "#3a7f2e",
                        "#55a23a",
                        "#79c44c",
                        "#b0e27a"
                    }, 5)
                end
                local pal = ____t_result_3
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
                            __get(
                                pal,
                                __mod(k, 3) == 0 and 4 or 3
                            )
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
                                    q == math.floor(7 * s) - 1 and "#1c3c1a" or (q < 2 and "#3a7f2e" or "#2a6228")
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
                                    k > 5 and "#3a7f2e" or "#58a83c"
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
                            __t(__mod(k, 3)) and "#9a7040" or "#7a5228"
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
                                    k > 6 and "#3f8a30" or "#58a83c"
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
                local ____t_result_4
                if __t(o.telhado) then
                    ____t_result_4 = o.telhado
                else
                    ____t_result_4 = "#d0683a"
                end
                local tel = ____t_result_4
                local ____t_result_5
                if __t(o.parede) then
                    ____t_result_5 = o.parede
                else
                    ____t_result_5 = "#f2e6d4"
                end
                local par = ____t_result_5
                local ____t_result_6
                if __t(o.paredeH) then
                    ____t_result_6 = o.paredeH
                else
                    ____t_result_6 = 14
                end
                local pH = ____t_result_6
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
                local ____o_porta_7 = o.porta
                if ____o_porta_7 == nil then
                    ____o_porta_7 = math.floor(w / 2 + 0.5) - 4
                end
                local dx = ____o_porta_7
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
                local ____iter_9 = __iter
                local ____t_result_8
                if __t(o.janelas) then
                    ____t_result_8 = o.janelas
                else
                    ____t_result_8 = __arrL({6, w - 12}, 2)
                end
                for ____, jx in __TS__Iterator(____iter_9(____t_result_8)) do
                    do
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
                local ____t_result_10
                if __t(o.parede) then
                    ____t_result_10 = o.parede
                else
                    ____t_result_10 = "#e8e4dc"
                end
                local par = ____t_result_10
                local ____t_result_11
                if __t(o.topo) then
                    ____t_result_11 = o.topo
                else
                    ____t_result_11 = "#9aa0a6"
                end
                local topo = ____t_result_11
                local ____t_result_12
                if __t(o.fachada) then
                    ____t_result_12 = o.fachada
                else
                    ____t_result_12 = 22
                end
                local fH = ____t_result_12
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
        local ____t_result_222
        if __t(M.PAD) then
            ____t_result_222 = M.PAD
        else
            ____t_result_222 = 0
        end
        local p = ____t_result_222
        local x0 = __TS__Number(-p)
        local x1 = __add(M.W, p)
        local y0 = __TS__Number(-p)
        local y1 = __add(M.H, p)
        local ____cam_224 = cam
        local ____temp_223
        if hw * 2 >= x1 - x0 then
            ____temp_223 = M.W / 2
        else
            ____temp_223 = math.max(
                x0 + hw,
                math.min(x1 - hw, cam.x)
            )
        end
        ____cam_224.x = ____temp_223
        local ____cam_226 = cam
        local ____temp_225
        if hh * 2 >= y1 - y0 then
            ____temp_225 = M.H / 2
        else
            ____temp_225 = math.max(
                y0 + hh,
                math.min(y1 - hh, cam.y)
            )
        end
        ____cam_226.y = ____temp_225
    end
    function moverSimples(self, dv)
        if __t(not __t(aberto) or not __t(def)) then
            return
        end
        local n = __len(def.locais)
        LS.sel = __mod(
            __mod(
                __add(LS.sel, dv),
                n
            ) + n,
            n
        )
        sel = LS.sel
        LS.aviso = 0
        desenharSimples(nil)
    end
    function irSimples(self)
        if __t(not __t(aberto) or not __t(def)) then
            return
        end
        local L = __get(def.locais, LS.sel)
        if not __t(L) then
            return
        end
        local ____t_360 = __t
        local ____t_result_359
        if __t(L.atual) then
            ____t_result_359 = L.atual
        else
            local ____opt_357 = L.estado
            if ____opt_357 ~= nil then
                ____opt_357 = ____opt_357.ok
            end
            ____t_result_359 = ____opt_357 == false
        end
        if ____t_360(____t_result_359) then
            LS.aviso = 1
            desenharSimples(nil)
            return
        end
        local id = L.id
        fechar(nil)
        window:setTimeout(
            function()
                local ____this_362
                ____this_362 = def
                local ____opt_361 = ____this_362.aoIr
                if ____opt_361 ~= nil then
                    ____opt_361 = ____opt_361(____this_362, id)
                end
                return ____opt_361
            end,
            60
        )
    end
    function desenharSimples(self)
        local g = LS.g
        local W = 480
        local H = 270
        local n = __len(def.locais)
        local cols = colsSimples(nil)
        local lin = math.ceil(n / cols)
        local cw = math.floor((W - 24) / cols)
        local function R(____, x, y, w, h, cor)
            g.fillStyle = cor
            g:fillRect(x, y, w, h)
        end
        local function txt(____, t, x, y, cor, tam, al)
            if tam == nil then
                tam = 9
            end
            if al == nil then
                al = "left"
            end
            g.font = __add(tam, "px Pixel, monospace")
            g.textAlign = al
            g.textBaseline = "alphabetic"
            g.fillStyle = cor
            g:fillText(t, x, y)
        end
        R(
            nil,
            0,
            0,
            W,
            H,
            "#2a1a10"
        )
        R(
            nil,
            3,
            3,
            W - 6,
            H - 6,
            "#8a5a32"
        )
        R(
            nil,
            6,
            6,
            W - 12,
            H - 12,
            "#f3e3bf"
        )
        do
            local x = 6
            while x < W - 6 do
                R(
                    nil,
                    x,
                    6,
                    1,
                    H - 12,
                    "#ead6aa"
                )
                x = x + 24
            end
        end
        do
            local y = 6
            while y < H - 6 do
                R(
                    nil,
                    6,
                    y,
                    W - 12,
                    1,
                    "#ead6aa"
                )
                y = y + 24
            end
        end
        R(
            nil,
            6,
            6,
            W - 12,
            26,
            "#5a3a20"
        )
        R(
            nil,
            6,
            30,
            W - 12,
            2,
            "#3a2412"
        )
        local ____t_result_363
        if __t(def.titulo) then
            ____t_result_363 = def.titulo
        else
            ____t_result_363 = "MAPA"
        end
        txt(
            nil,
            tostring(____t_result_363),
            W / 2,
            23,
            "#ffe9a8",
            10,
            "center"
        )
        local topo = 40
        local alt = math.min(
            20,
            math.floor((176 - topo + 40) / lin)
        )
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local cx = 12 + __mod(i, cols) * cw
                local cy = topo + math.floor(i / cols) * alt
                local ativo = i == LS.sel
                local ____opt_364 = L.estado
                if ____opt_364 ~= nil then
                    ____opt_364 = ____opt_364.ok
                end
                local bloq = ____opt_364 == false
                if __t(ativo) then
                    R(
                        nil,
                        cx - 2,
                        cy - 1,
                        cw - 4,
                        alt - 2,
                        "#2a1a10"
                    )
                    R(
                        nil,
                        cx - 1,
                        cy,
                        cw - 6,
                        alt - 4,
                        "#ffd98a"
                    )
                end
                local mx = cx + 3
                local my = cy + math.floor((alt - 4) / 2) - 3
                if __t(L.atual) then
                    R(
                        nil,
                        mx,
                        my,
                        7,
                        7,
                        "#1c3a52"
                    )
                    R(
                        nil,
                        mx + 1,
                        my + 1,
                        5,
                        5,
                        "#3a8ad8"
                    )
                elseif __t(bloq) then
                    R(
                        nil,
                        mx + 1,
                        my - 2,
                        5,
                        1,
                        "#2a0808"
                    )
                    R(
                        nil,
                        mx + 1,
                        my - 1,
                        1,
                        2,
                        "#2a0808"
                    )
                    R(
                        nil,
                        mx + 5,
                        my - 1,
                        1,
                        2,
                        "#2a0808"
                    )
                    R(
                        nil,
                        mx,
                        my + 1,
                        7,
                        6,
                        "#2a0808"
                    )
                    R(
                        nil,
                        mx + 1,
                        my + 2,
                        5,
                        4,
                        "#d83a3a"
                    )
                    R(
                        nil,
                        mx + 3,
                        my + 3,
                        1,
                        2,
                        "#2a0808"
                    )
                else
                    R(
                        nil,
                        mx,
                        my,
                        7,
                        7,
                        "#1e3a14"
                    )
                    R(
                        nil,
                        mx + 1,
                        my + 1,
                        5,
                        5,
                        "#5ab83a"
                    )
                end
                local ____t_result_366
                if __t(L.nome) then
                    ____t_result_366 = L.nome
                else
                    ____t_result_366 = ""
                end
                local nome = tostring(____t_result_366)
                g.font = "9px Pixel, monospace"
                while __t(__len(nome) > 4 and __gt(
                    g:measureText(nome).width,
                    cw - 22
                )) do
                    nome = __add(
                        __call(nome, "slice", 0, -2),
                        "…"
                    )
                end
                txt(
                    nil,
                    nome,
                    cx + 14,
                    cy + math.floor((alt - 4) / 2) + 4,
                    __t(ativo) and "#2a1a10" or (__t(bloq) and "#7a6a5a" or "#3a2412")
                )
            end
        )
        local ____t_result_369
        local ____t_368 = __t
        local ____get_result_367 = __get(def.locais, LS.sel)
        __O[602] = ____get_result_367
        if ____t_368(____get_result_367) then
            ____t_result_369 = __O[602]
        else
            ____t_result_369 = {}
        end
        local L = ____t_result_369
        local ____opt_370 = L.estado
        if ____opt_370 ~= nil then
            ____opt_370 = ____opt_370.ok
        end
        local ok = ____opt_370 ~= false
        local fy = 186
        R(
            nil,
            6,
            fy,
            W - 12,
            H - fy - 6,
            "#5a3a20"
        )
        R(
            nil,
            8,
            fy + 2,
            W - 16,
            H - fy - 10,
            "#fff6dc"
        )
        local ____t_result_372
        if __t(L.nome) then
            ____t_result_372 = L.nome
        else
            ____t_result_372 = ""
        end
        txt(
            nil,
            tostring(____t_result_372),
            16,
            fy + 16,
            "#2a1a10",
            11
        )
        if __t(L.sub) then
            txt(
                nil,
                tostring(L.sub),
                W - 16,
                fy + 16,
                "#8a5a32",
                8,
                "right"
            )
        end
        local ____t_result_387
        if __t(L.atual) then
            ____t_result_387 = "VOCÊ ESTÁ AQUI."
        else
            local ____t_result_386
            if __t(ok) then
                local ____add_377 = __add
                local ____add_376 = __add
                local ____call_375 = __call
                local ____re_replace_374 = __re_replace
                local ____t_result_373
                if __t(def.botao) then
                    ____t_result_373 = def.botao
                else
                    ____t_result_373 = "IR PARA LÁ"
                end
                ____t_result_386 = ____add_377(
                    ____add_376(
                        "Livre para ir. ENTER ou ",
                        ____call_375(
                            ____re_replace_374(
                                tostring(____t_result_373),
                                __re("[▶►]", "g"),
                                ""
                            ),
                            "trim"
                        )
                    ),
                    "."
                )
            else
                local ____t_result_385
                local ____t_384 = __t
                local ____t_result_383
                local ____t_380 = __t
                local ____opt_378 = L.estado
                if ____opt_378 ~= nil then
                    ____opt_378 = ____opt_378.motivo
                end
                __O[603] = ____opt_378
                if ____t_380(____opt_378) then
                    ____t_result_383 = __O[603]
                else
                    local ____opt_381 = L.estado
                    if ____opt_381 ~= nil then
                        ____opt_381 = ____opt_381.reason
                    end
                    ____t_result_383 = ____opt_381
                end
                __O[604] = ____t_result_383
                if ____t_384(____t_result_383) then
                    ____t_result_385 = __O[604]
                else
                    ____t_result_385 = "Ainda não dá para ir."
                end
                ____t_result_386 = tostring(____t_result_385)
            end
            ____t_result_387 = ____t_result_386
        end
        local linha = ____t_result_387
        local ____t_result_392
        local ____t_389 = __t
        local ____temp_388 = not __t(ok)
        __O[605] = ____temp_388
        if ____t_389(____temp_388) then
            local ____opt_390 = L.estado
            if ____opt_390 ~= nil then
                ____opt_390 = ____opt_390.trava
            end
            ____t_result_392 = ____opt_390
        else
            ____t_result_392 = __O[605]
        end
        local T = ____t_result_392
        local ____t_394 = __t
        local ____t_result_393
        if __t(T) then
            ____t_result_393 = __lenq(T.nomes)
        else
            ____t_result_393 = T
        end
        if ____t_394(____t_result_393) then
            local ____add_397 = __add
            local ____add_396 = __add
            local ____t_result_395
            if __t(T.titulo) then
                ____t_result_395 = T.titulo
            else
                ____t_result_395 = "PRECISA DERROTAR"
            end
            linha = ____add_397(
                ____add_396(____t_result_395, ": "),
                __re_replace(
                    __call(T.nomes, "join", " "),
                    __re("\\s+", "g"),
                    " "
                )
            )
        end
        local cor = __t(L.atual) and "#2c5a9e" or (__t(ok) and "#2e6a1e" or "#b8261e")
        g.font = "9px Pixel, monospace"
        local pal = __call(linha, "split", " ")
        local l1 = ""
        local l2 = ""
        for ____, p in __iterar((pal)) do
            local ____t_403 = __t
            local ____temp_402 = not __t(l2)
            if ____temp_402 then
                local ____le_401 = __le
                local ____g_measureText_400 = g.measureText
                local ____add_399 = __add
                local ____t_result_398
                if __t(l1) then
                    ____t_result_398 = __add(l1, " ")
                else
                    ____t_result_398 = ""
                end
                ____temp_402 = ____le_401(
                    ____g_measureText_400(
                        g,
                        ____add_399(____t_result_398, p)
                    ).width,
                    W - 40
                )
            end
            if ____t_403(____temp_402) then
                local ____add_405 = __add
                local ____t_result_404
                if __t(l1) then
                    ____t_result_404 = __add(l1, " ")
                else
                    ____t_result_404 = ""
                end
                l1 = ____add_405(____t_result_404, p)
            else
                local ____add_407 = __add
                local ____t_result_406
                if __t(l2) then
                    ____t_result_406 = __add(l2, " ")
                else
                    ____t_result_406 = ""
                end
                l2 = ____add_407(____t_result_406, p)
            end
        end
        local ____t_409 = __t
        local ____t_result_408
        if __t(l2) then
            ____t_result_408 = __gt(
                g:measureText(l2).width,
                W - 40
            )
        else
            ____t_result_408 = l2
        end
        if ____t_409(____t_result_408) then
            while __t(__len(l2) > 4 and __gt(
                g:measureText(__add(l2, "…")).width,
                W - 40
            )) do
                l2 = __call(l2, "slice", 0, -1)
            end
            l2 = __add(l2, "…")
        end
        if __t(LS.aviso) then
            R(
                nil,
                12,
                fy + 21,
                W - 24,
                __t(l2) and 30 or 17,
                "#ffe0d8"
            )
        end
        txt(
            nil,
            l1,
            16,
            fy + 33,
            cor
        )
        if __t(l2) then
            txt(
                nil,
                l2,
                16,
                fy + 46,
                cor
            )
        end
        txt(
            nil,
            "< > ESCOLHE · ENTER VAI · ESC FECHA",
            W / 2,
            H - 12,
            "#8a5a32",
            8,
            "center"
        )
        local bt = LS.el:querySelector(".ir")
        bt.disabled = not __t(ok) or not not __t(L.atual)
    end
    function fechar(self)
        if not __t(aberto) then
            return
        end
        aberto = false
        if __t(SIMPLES) then
            if __t(LS) then
                LS.el.hidden = true
            end
            window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
            local ____opt_result_428
            if def ~= nil then
                ____opt_result_428 = def.aoFechar
            end
            if ____opt_result_428 ~= nil then
                ____opt_result_428(def)
            end
            return
        end
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
        local ____opt_result_433
        if def ~= nil then
            ____opt_result_433 = def.aoFechar
        end
        if ____opt_result_433 ~= nil then
            ____opt_result_433(def)
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
        local ____mostrarTrava_441 = mostrarTrava
        local ____t_result_440
        local ____t_439 = __t
        local ____t_result_438
        local ____t_435 = __t
        local ____ge_result_434 = __ge(i, 0)
        __O[608] = ____ge_result_434
        if ____t_435(____ge_result_434) then
            local ____opt_436 = __get(def.locais, i).estado
            if ____opt_436 ~= nil then
                ____opt_436 = ____opt_436.trava
            end
            ____t_result_438 = ____opt_436
        else
            ____t_result_438 = __O[608]
        end
        if ____t_439(____t_result_438) then
            ____t_result_440 = i
        else
            ____t_result_440 = -1
        end
        ____mostrarTrava_441(nil, ____t_result_440)
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
        local ____opt_442 = L.estado
        if ____opt_442 ~= nil then
            ____opt_442 = ____opt_442.ok
        end
        local ok = ____opt_442 ~= false
        local f = centro(nil, i)
        local largo = window.innerWidth > 760
        local cel = celular(nil)
        local ____t_result_444
        if __t(cel) then
            ____t_result_444 = window.innerWidth > window.innerHeight
        else
            ____t_result_444 = cel
        end
        local lado = ____t_result_444
        local ____t_result_445
        if __t(cel) then
            ____t_result_445 = math.min(
                zMax,
                math.max(
                    zCobre(nil) * 1.4,
                    1.6
                )
            )
        else
            ____t_result_445 = math.min(
                zMax,
                math.max(
                    zMin(nil) * 2.2,
                    3
                )
            )
        end
        local z = ____t_result_445
        local ____assign_result_455 = __assign({}, cam)
        local ____f_x_448 = f.x
        local ____t_result_447
        if __t(largo) then
            ____t_result_447 = 170 / z
        else
            local ____t_result_446
            if __t(lado) then
                ____t_result_446 = cv.clientWidth * 0.22 / z
            else
                ____t_result_446 = 0
            end
            ____t_result_447 = ____t_result_446
        end
        local ____temp_454 = ____f_x_448 + ____t_result_447
        local ____f_y_453 = f.y
        local ____t_result_452
        local ____t_450 = __t
        local ____t_result_449
        if __t(largo) then
            ____t_result_449 = largo
        else
            ____t_result_449 = lado
        end
        if ____t_450(____t_result_449) then
            ____t_result_452 = 0
        else
            local ____t_result_451
            if __t(cel) then
                ____t_result_451 = cv.clientHeight * 0.2 / z
            else
                ____t_result_451 = 110 / z
            end
            ____t_result_452 = ____t_result_451
        end
        anim = {
            de = ____assign_result_455,
            para = {x = ____temp_454, y = ____f_y_453 + ____t_result_452, z = z},
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
        local ____temp_457 = pv:querySelector(".sub")
        local ____t_result_456
        if __t(L.sub) then
            ____t_result_456 = L.sub
        else
            ____t_result_456 = ""
        end
        ____temp_457.textContent = ____t_result_456
        local ____temp_460 = pv:querySelector(".desc")
        local ____L_nome_459 = L.nome
        local ____t_result_458
        if __t(L.descricao) then
            ____t_result_458 = L.descricao
        else
            ____t_result_458 = ""
        end
        ____temp_460.innerHTML = (("<b>" .. tostring(____L_nome_459)) .. "</b>") .. tostring(____t_result_458)
        local ____temp_471 = pv:querySelector(".motivo")
        local ____t_result_470
        if __t(ok) then
            ____t_result_470 = ""
        else
            local ____add_469 = __add
            local ____t_result_468
            local ____t_467 = __t
            local ____t_result_466
            local ____t_463 = __t
            local ____opt_461 = L.estado
            if ____opt_461 ~= nil then
                ____opt_461 = ____opt_461.motivo
            end
            __O[609] = ____opt_461
            if ____t_463(____opt_461) then
                ____t_result_466 = __O[609]
            else
                local ____opt_464 = L.estado
                if ____opt_464 ~= nil then
                    ____opt_464 = ____opt_464.reason
                end
                ____t_result_466 = ____opt_464
            end
            __O[610] = ____t_result_466
            if ____t_467(____t_result_466) then
                ____t_result_468 = __O[610]
            else
                ____t_result_468 = "Ainda não dá para ir."
            end
            ____t_result_470 = ____add_469("🔒 ", ____t_result_468)
        end
        ____temp_471.textContent = ____t_result_470
        local bt = pv:querySelector(".ir")
        bt.disabled = not __t(ok) or not not __t(L.atual)
        local ____t_result_477
        if __t(L.atual) then
            ____t_result_477 = "VOCÊ ESTÁ AQUI"
        else
            local ____t_result_476
            if __t(ok) then
                local ____t_result_472
                if __t(def.botao) then
                    ____t_result_472 = def.botao
                else
                    ____t_result_472 = "IR PARA LÁ ▶"
                end
                ____t_result_476 = ____t_result_472
            else
                local ____t_475 = __t
                local ____opt_473 = L.estado
                if ____opt_473 ~= nil then
                    ____opt_473 = ____opt_473.trava
                end
                ____t_result_476 = ____t_475(____opt_473) and "🔒 TRANCADO" or "BLOQUEADO"
            end
            ____t_result_477 = ____t_result_476
        end
        bt.textContent = ____t_result_477
        pv.classList:remove("on")
        local ____ = pv.offsetWidth
        __call(pv.classList, "add", "on")
        local prev = pv:querySelector("canvas.prev")
        local pc = prev:getContext("2d")
        pc.imageSmoothingEnabled = false
        local function desenha()
            do
                pcall(function()
                    local ____opt_478 = L.previa
                    if ____opt_478 ~= nil then
                        ____opt_478(
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
            local ____t_482 = __t
            local ____opt_480 = L.estado
            if ____opt_480 ~= nil then
                ____opt_480 = ____opt_480.trava
            end
            if ____t_482(____opt_480) then
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
                local ____opt_483 = L.estado
                if ____opt_483 ~= nil then
                    ____opt_483 = ____opt_483.ok
                end
                local bloq = ____opt_483 == false
                b.className = __t(bloq) and "bloq" or (__t(L.atual) and "atual" or "")
                b.textContent = __add(
                    __t(L.atual) and "● " or (__t(bloq) and "🔒 " or ""),
                    L.nome
                )
                b:addEventListener(
                    "click",
                    function() return selecionar(nil, i) end
                )
                el:appendChild(b)
            end
        )
    end
    function mostrarTrava(self, i)
        local ____opt_result_487
        if ui ~= nil then
            ____opt_result_487 = ui:querySelector(".trava")
        end
        local el = ____opt_result_487
        if not __t(el) then
            return
        end
        travaI = i
        el.classList:remove("on")
        if __lt(i, 0) then
            return
        end
        local T = __get(def.locais, i).estado.trava
        local ____temp_489 = el:querySelector(".t")
        local ____t_result_488
        if __t(T.titulo) then
            ____t_result_488 = T.titulo
        else
            ____t_result_488 = "PRECISA DERROTAR"
        end
        ____temp_489.textContent = ____t_result_488
        local ____temp_493 = el:querySelector(".n")
        local ____call_492 = __call
        local ____call_491 = __call
        local ____t_result_490
        if __t(T.nomes) then
            ____t_result_490 = T.nomes
        else
            ____t_result_490 = __arrL({}, 0)
        end
        ____temp_493.innerHTML = ____call_492(
            ____call_491(
                ____t_result_490,
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
        local ____temp_495 = el:querySelector("small")
        local ____t_result_494
        if __t(T.texto) then
            ____t_result_494 = T.texto
        else
            ____t_result_494 = ""
        end
        ____temp_495.textContent = ____t_result_494
        local ____ = el.offsetWidth
        __call(el.classList, "add", "on")
        travaAte = tempo + 5.5
        __get(M.locs, i).tremor = 1
    end
    function mostrarInfo(self, v)
        info = not not __t(v)
        local ____opt_result_500
        if ui ~= nil then
            ____opt_result_500 = ui:querySelector(".desc")
        end
        if ____opt_result_500 ~= nil then
            ____opt_result_500.classList:toggle("on", info)
        end
    end
    function ir(self)
        local ____t_504 = __t
        local ____t_result_503
        local ____t_502 = __t
        local ____temp_501 = sel < 0
        __O[611] = ____temp_501
        if ____t_502(____temp_501) then
            ____t_result_503 = __O[611]
        else
            ____t_result_503 = viagem
        end
        if ____t_504(____t_result_503) then
            return
        end
        local L = __get(def.locais, sel)
        local ____t_510 = __t
        local ____t_result_509
        local ____t_508 = __t
        local ____opt_505 = L.estado
        if ____opt_505 ~= nil then
            ____opt_505 = ____opt_505.ok
        end
        local ____temp_507 = ____opt_505 == false
        __O[612] = ____temp_507
        if ____t_508(____temp_507) then
            ____t_result_509 = __O[612]
        else
            ____t_result_509 = L.atual
        end
        if ____t_510(____t_result_509) then
            return
        end
        local ai = __call(
            def.locais,
            "findIndex",
            function(____, q) return q.atual end
        )
        local para = centro(nil, sel)
        local ____ge_result_511
        if __ge(ai, 0) then
            ____ge_result_511 = centro(nil, ai)
        else
            ____ge_result_511 = {x = para.x - 200, y = para.y + 120}
        end
        local de = ____ge_result_511
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
            dir = __ge(para.x, de.x) and 1 or -1,
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
        local ____pts_515 = pts
        local ____acc_516 = acc
        local ____t_result_514
        local ____t_513 = __t
        local ____get_result_512 = __get(
            acc,
            __len(acc) - 1
        )
        __O[613] = ____get_result_512
        if ____t_513(____get_result_512) then
            ____t_result_514 = __O[613]
        else
            ____t_result_514 = 1
        end
        return {pts = ____pts_515, acc = ____acc_516, total = ____t_result_514}
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
        local ____t_result_519
        local ____t_518 = __t
        local ____get_result_517 = __get(R.pts, i)
        __O[614] = ____get_result_517
        if ____t_518(____get_result_517) then
            ____t_result_519 = __O[614]
        else
            ____t_result_519 = a
        end
        local b = ____t_result_519
        local seg = __get(R.acc, i) - __get(R.acc, i - 1)
        local ____t_result_520
        if __t(seg) then
            ____t_result_520 = math.max(
                0,
                math.min(
                    1,
                    (d - __get(R.acc, i - 1)) / seg
                )
            )
        else
            ____t_result_520 = 1
        end
        local k = ____t_result_520
        local ____temp_522 = a.x + (b.x - a.x) * k
        local ____temp_523 = a.y + (b.y - a.y) * k
        local ____t_result_521
        if __t(def.voa) then
            ____t_result_521 = 48 * math.sin(math.pi * math.max(
                0,
                math.min(1, u)
            )) ^ 0.55
        else
            ____t_result_521 = 0
        end
        return {x = ____temp_522, y = ____temp_523, alt = ____t_result_521}
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
                local ____t_529 = __t
                local ____t_result_528
                local ____t_527 = __t
                local ____t_result_526
                local ____t_525 = __t
                local ____temp_524 = p.x > L.bx - 6 and __lt(
                    p.x,
                    __add(L.bx, L.bw) + 6
                )
                __O[615] = ____temp_524
                if ____t_525(____temp_524) then
                    ____t_result_526 = p.y > L.by - 30
                else
                    ____t_result_526 = __O[615]
                end
                __O[616] = ____t_result_526
                if ____t_527(____t_result_526) then
                    ____t_result_528 = __lt(
                        p.y,
                        __add(L.by, L.bh) + 6
                    )
                else
                    ____t_result_528 = __O[616]
                end
                if ____t_529(____t_result_528) then
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
        c.fillStyle = __t(ativo) and "#ffd98a" or (estado == "bloq" and "#5a5048" or (estado == "atual" and "#3a6a8a" or "#a8643a"))
        c:fillRect(bx, by, w, h)
        c.fillStyle = "rgba(255,255,255,.25)"
        c:fillRect(bx, by, w, 2)
        c.fillStyle = __t(ativo) and "#2a1a10" or "#fff6dc"
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
        local ____x_531 = x
        local ____gt_result_530
        if __gt(tremor, 0) then
            ____gt_result_530 = math.sin(tempo * 55) * 4 * tremor
        else
            ____gt_result_530 = 0
        end
        x = math.floor(____x_531 + ____gt_result_530 + 0.5)
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
                v.dir = dx >= 0 and 1 or -1
            end
            local sx = veic.x
            local sy = veic.y - veic.alt
            local ____t_result_534
            local ____t_533 = __t
            local ____t_result_532
            if __t(v.ant) then
                ____t_result_532 = dt
            else
                ____t_result_532 = v.ant
            end
            if ____t_533(____t_result_532) then
                ____t_result_534 = __hypot(sx - v.ant.x, sy - v.ant.y) / dt
            else
                ____t_result_534 = 0
            end
            v.spd = ____t_result_534
            v.ant = {x = sx, y = sy}
            v.roda = v.roda + v.spd * dt / 3
            local ____t_result_539
            local ____t_538 = __t
            local ____t_result_537
            local ____t_536 = __t
            local ____t_result_535
            if __t(def.voa) then
                ____t_result_535 = __gt(v.t, 0)
            else
                ____t_result_535 = def.voa
            end
            __O[617] = ____t_result_535
            if ____t_536(____t_result_535) then
                ____t_result_537 = k < 1
            else
                ____t_result_537 = __O[617]
            end
            if ____t_538(____t_result_537) then
                ____t_result_539 = math.max(
                    -0.42,
                    math.min(
                        0.42,
                        math.atan(
                            dy,
                            math.abs(dx) + 0.01
                        )
                    )
                ) * 0.8
            else
                ____t_result_539 = 0
            end
            local angAlvo = ____t_result_539
            v.ang = v.ang + (angAlvo - v.ang) * math.min(1, dt * 7)
            if __lt(v.t, 0) then
                veic.y = veic.y + math.floor(math.sin(tempo * 60) + 0.5) * 0.5
            end
            if __t(__ge(v.t, 0) and not __t(v.decolou)) then
                v.decolou = true
                v.sq = 0.7
                v.impulso = 1
                poeira(
                    nil,
                    veic.x,
                    veic.y,
                    __t(def.voa) and 16 or 8,
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
                                cor = __t(__mod(k2, 2)) and "#ffd36b" or "#ff8a3a"
                            }
                        )
                        k2 = k2 + 1
                    end
                end
            elseif k < 1 then
                local ____veic_541, ____y_542 = veic, "y"
                local ____t_result_540
                if __t(def.voa) then
                    ____t_result_540 = math.sin(tempo * 7) * 1.4 * math.min(1, veic.alt / 12)
                else
                    ____t_result_540 = -math.abs(math.sin(tempo * 16)) * 0.9
                end
                ____veic_541[____y_542] = ____veic_541[____y_542] + ____t_result_540
            end
            if __t(k >= 1 and not __t(v.pousou)) then
                v.pousou = true
                v.sq = 1
                v.treme = 0.22
                poeira(
                    nil,
                    veic.x,
                    veic.y,
                    __t(def.voa) and 18 or 10,
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
                                    cor = __t(__mod(k2, 2)) and "#fff2b0" or "#ffb040"
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
            local ____t_result_543
            if __t(v.impulso) then
                ____t_result_543 = v.impulso
            else
                ____t_result_543 = 0
            end
            v.impulso = math.max(0, ____t_result_543 - dt * 1.6)
            v.emit = v.emit + dt
            local taxa = k >= 1 and 1000000000 or (__lt(v.t, 0) and 0.09 or (__t(def.voa) and 0.06 or 0.05))
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
                            vx = __TS__Number(-v.dir) * (8 + math.random() * 10),
                            vy = 2 + math.random() * 6,
                            t = 0,
                            vida = 0.55 + math.random() * 0.3,
                            r = 1.5 + math.random(),
                            cresce = 4,
                            cor = math.random() < 0.5 and "#c8f0d8" or "#eef8f0"
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
            local ____t_result_544
            if __t(def.voa) then
                ____t_result_544 = zBase * (1 - 0.18 * math.sin(math.pi * k))
            else
                ____t_result_544 = zBase
            end
            local zAlvo = ____t_result_544
            local ____veic_x_546 = veic.x
            local ____t_result_545
            if __t(dx) then
                ____t_result_545 = dx
            else
                ____t_result_545 = 0
            end
            local tx = ____veic_x_546 + ____t_result_545 * 6
            local ____temp_548 = veic.y - veic.alt * 0.5
            local ____t_result_547
            if __t(dy) then
                ____t_result_547 = dy
            else
                ____t_result_547 = 0
            end
            local ty = ____temp_548 + ____t_result_547 * 3
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
                        local ____this_550
                        ____this_550 = def
                        local ____opt_549 = ____this_550.aoIr
                        if ____opt_549 ~= nil then
                            ____opt_549 = ____opt_549(____this_550, id)
                        end
                        return ____opt_549
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
        c.fillStyle = __t(M.ilha) and "#3a98d8" or "#8ccfe8"
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
                            do
                                local ph = __mod(
                                    tempo * 0.7 + hash(nil, x, y) * 6,
                                    6
                                )
                                if ph > 1.6 then
                                    do x = x + 34 continue end
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
                            end
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
            local ____iter_552 = __iter
            local ____t_result_551
            if __t(M.ilha.eolicas) then
                ____t_result_551 = M.ilha.eolicas
            else
                ____t_result_551 = __arrL({}, 0)
            end
            for ____, ____value in __TS__Iterator(____iter_552(____t_result_551)) do
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
                                    j > 14 and "#c43c3a" or "#ffffff"
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
                local dir = -math.sin(b.a) >= 0 and 1 or -1
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
                do
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
            end
            local ____t_554 = __t
            local ____t_result_553
            if __t(M.ilha.farol) then
                ____t_result_553 = __mod(
                    math.floor(tempo * 1.5),
                    2
                )
            else
                ____t_result_553 = M.ilha.farol
            end
            if ____t_554(____t_result_553) then
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
        local ____this_556
        ____this_556 = def
        local ____opt_555 = ____this_556.animarChao
        if ____opt_555 ~= nil then
            ____opt_555(____this_556, P, tempo)
        end
        c:drawImage(M.obj, 0, 0)
        __call(
            def.locais,
            "forEach",
            function(____, L, i)
                local ____t_559 = __t
                local ____opt_557 = L.estado
                if ____opt_557 ~= nil then
                    ____opt_557 = ____opt_557.trava
                end
                if not ____t_559(____opt_557) then
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
                local ____lt_result_560
                if __lt(k, 1) then
                    ____lt_result_560 = math.sin(k * 15) * math.exp(__TS__Number(-k) * 4.5) * 0.22
                else
                    ____lt_result_560 = 0
                end
                local y = ____lt_result_560
                sy = 1 + y
                sx = 1 - y * 0.6
                if __ge(k, 1) then
                    L.pulo = nil
                end
            end
            if i == sel then
                c:save()
                c.globalAlpha = 0.35 + math.sin(tempo * 5) * 0.15
                local ____c_564 = c
                local ____t_563 = __t
                local ____opt_561 = __get(def.locais, i).estado
                if ____opt_561 ~= nil then
                    ____opt_561 = ____opt_561.trava
                end
                ____c_564.fillStyle = ____t_563(____opt_561) and "#ff4a3a" or "#fff6c0"
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
            local ____c_569 = c
            local ____c_drawImage_570 = c.drawImage
            local ____t_result_568
            local ____t_567 = __t
            local ____opt_565 = __get(def.locais, i).estado
            if ____opt_565 ~= nil then
                ____opt_565 = ____opt_565.trava
            end
            if ____t_567(____opt_565) then
                ____t_result_568 = L.esc
            else
                ____t_result_568 = L.s
            end
            ____c_drawImage_570(
                ____c_569,
                ____t_result_568,
                __TS__Number(-L.bw) / 2,
                __TS__Number(-L.bh)
            )
            c:restore()
        end
        local ____this_572
        ____this_572 = def
        local ____opt_571 = ____this_572.animar
        if ____opt_571 ~= nil then
            ____opt_571(____this_572, P, tempo, dt)
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
                        local ____t_result_573
                        if __t(sg) then
                            ____t_result_573 = (d - __get(R2.acc, i2 - 1)) / sg
                        else
                            ____t_result_573 = 0
                        end
                        local kk = ____t_result_573
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
                    c.globalAlpha = math.max(0, 1 - q) * 0.45
                    P:circ(p.x, p.y, p.r + p.cresce * q, p.cor)
                end
            end
            c.globalAlpha = 1
            if __t(v.marca) then
                local ____v_marca_574, ____t_575 = v.marca, "t"
                ____v_marca_574[____t_575] = ____v_marca_574[____t_575] + dt
                local a = math.max(0, 1 - v.marca.t / 2.2)
                if a > 0 then
                    c.globalAlpha = a * 0.5
                    for ____, off in __iterar((__arrL({-9, 9}, 2))) do
                        R(
                            nil,
                            v.marca.x + off - (__gt(v.marca.dir, 0) and 18 or 0),
                            v.marca.y,
                            18,
                            1,
                            "#3a2a1a"
                        )
                    end
                    c.globalAlpha = 1
                end
            end
            local ____gt_result_576
            if __gt(v.sq, 0) then
                ____gt_result_576 = math.sin(v.sq * math.pi) * v.sq * 0.22
            else
                ____gt_result_576 = 0
            end
            local e = ____gt_result_576
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
            local ____this_586
            ____this_586 = def
            local ____opt_577 = ____this_586.veiculo
            if ____opt_577 ~= nil then
                local ____tempo_585 = tempo
                local ____alt_580 = alt
                local ____v_roda_581 = v.roda
                local ____temp_582 = alt > 3
                local ____temp_583 = __lt(v.t, 0) or __ge(veic.k, 1)
                local ____v_spd_584 = v.spd
                local ____t_result_578
                if __t(v.impulso) then
                    ____t_result_578 = v.impulso
                else
                    ____t_result_578 = 0
                end
                local ____lt_result_579
                if __lt(v.t, 0) then
                    ____lt_result_579 = 1 + v.t / 0.38
                else
                    ____lt_result_579 = 0
                end
                ____opt_577(____this_586, P, ____tempo_585, {
                    alt = ____alt_580,
                    roda = ____v_roda_581,
                    voando = ____temp_582,
                    parado = ____temp_583,
                    vel = ____v_spd_584,
                    impulso = ____t_result_578,
                    carregando = ____lt_result_579
                })
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
                    local lado = __t(__mod(i, 2)) and 1 or -1
                    local k = math.ceil(i / 2)
                    local bx = a.x - a.dir * k * 9
                    local by = a.y + lado * k * 6 + math.sin(tempo * 2 + a.fase) * 6
                    local asa = math.sin(tempo * 12 + a.fase + i) > 0
                    R(
                        nil,
                        bx - 3,
                        by - (__t(asa) and 2 or 0),
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
                        by - (__t(asa) and 2 or 0),
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
                bx - (__t(abre) and 2 or 1),
                by,
                __t(abre) and 2 or 1,
                2,
                b.cor
            )
            R(
                nil,
                bx + 1,
                by,
                __t(abre) and 2 or 1,
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
        local ____iter_591 = __iter
        local ____t_result_590
        if __t(M.parapentes) then
            ____t_result_590 = M.parapentes
        else
            ____t_result_590 = __arrL({}, 0)
        end
        for ____, pp in __TS__Iterator(____iter_591(____t_result_590)) do
            local a = tempo * 0.35 + pp.fase
            local px = pp.x + math.cos(a) * pp.r
            local py = pp.y + math.sin(a) * pp.r * 0.5 - 30
            local dir = -math.sin(a) >= 0 and 1 or -1
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
                    local ____temp_588 = px - 12 + k * 3
                    local ____temp_589 = py - math.floor(math.sin(k / 8 * math.pi) * 5 + 0.5)
                    local ____t_result_587
                    if __t(__mod(k, 2)) then
                        ____t_result_587 = pp.cor
                    else
                        ____t_result_587 = "#ffffff"
                    end
                    R(
                        nil,
                        ____temp_588,
                        ____temp_589,
                        3,
                        4,
                        ____t_result_587
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
                local ____t_597 = __t
                local ____t_result_596
                local ____t_595 = __t
                local ____t_result_594
                local ____t_593 = __t
                local ____temp_592 = sx < -100 or __gt(sx, W + 100)
                __O[618] = ____temp_592
                if ____t_593(____temp_592) then
                    ____t_result_594 = __O[618]
                else
                    ____t_result_594 = sy < -60
                end
                __O[619] = ____t_result_594
                if ____t_595(____t_result_594) then
                    ____t_result_596 = __O[619]
                else
                    ____t_result_596 = __gt(sy, H + 80)
                end
                if ____t_597(____t_result_596) then
                    return
                end
                local b = math.floor(math.sin(tempo * 3 + i) * 3 + 0.5)
                local ativo = i == sel
                local ____placaNome_602 = placaNome
                local ____temp_600 = sy - 6 + b
                local ____add_result_601 = __add(
                    __t(L.atual) and "● " or "",
                    L.nome
                )
                local ____opt_598 = L.estado
                if ____opt_598 ~= nil then
                    ____opt_598 = ____opt_598.ok
                end
                ____placaNome_602(
                    nil,
                    sx,
                    ____temp_600,
                    ____add_result_601,
                    ____opt_598 == false and "bloq" or (__t(L.atual) and "atual" or "ok"),
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
                local ____t_605 = __t
                local ____opt_603 = L.estado
                if ____opt_603 ~= nil then
                    ____opt_603 = ____opt_603.trava
                end
                if not ____t_605(____opt_603) then
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
                local ____t_611 = __t
                local ____t_result_610
                local ____t_609 = __t
                local ____t_result_608
                local ____t_607 = __t
                local ____temp_606 = x < -60 or __gt(x, W + 60)
                __O[620] = ____temp_606
                if ____t_607(____temp_606) then
                    ____t_result_608 = __O[620]
                else
                    ____t_result_608 = y < -60
                end
                __O[621] = ____t_result_608
                if ____t_609(____t_result_608) then
                    ____t_result_610 = __O[621]
                else
                    ____t_result_610 = __gt(y, H + 80)
                end
                if ____t_611(____t_result_610) then
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
                    local ____t_result_612
                    if __t(pv.classList:contains("on")) then
                        ____t_result_612 = pv:getBoundingClientRect()
                    else
                        ____t_result_612 = nil
                    end
                    local r = ____t_result_612
                    local meia = el.offsetWidth / 2 + 10
                    local ____t_result_615
                    local ____t_614 = __t
                    local ____t_result_613
                    if __t(r) then
                        ____t_result_613 = __lt(r.top, H * 0.4)
                    else
                        ____t_result_613 = r
                    end
                    if ____t_614(____t_result_613) then
                        ____t_result_615 = r.left
                    else
                        ____t_result_615 = W
                    end
                    local ladoDir = ____t_result_615
                    local ____t_result_618
                    local ____t_617 = __t
                    local ____t_result_616
                    if __t(r) then
                        ____t_result_616 = __ge(r.top, H * 0.4)
                    else
                        ____t_result_616 = r
                    end
                    if ____t_617(____t_result_616) then
                        ____t_result_618 = r.top
                    else
                        ____t_result_618 = H
                    end
                    local base = ____t_result_618
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
    ease = function(____, u)
        local ____lt_result_0
        if __lt(u, 0.5) then
            ____lt_result_0 = 4 * u * u * u
        else
            ____lt_result_0 = 1 - (-2 * u + 2) ^ 3 / 2
        end
        return ____lt_result_0
    end
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
        local ____t_result_15
        local ____t_14 = __t
        local ____get_result_13 = __get(
            ac,
            __len(ac) - 1
        )
        __O[516] = ____get_result_13
        if ____t_14(____get_result_13) then
            ____t_result_15 = __O[516]
        else
            ____t_result_15 = 1
        end
        local total = ____t_result_15
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
                local ____temp_19 = d - __get(ac, lo)
                local ____t_result_18
                local ____t_17 = __t
                local ____temp_16 = __get(ac, hi) - __get(ac, lo)
                __O[517] = ____temp_16
                if ____t_17(____temp_16) then
                    ____t_result_18 = __O[517]
                else
                    ____t_result_18 = 1
                end
                local k = ____temp_19 / ____t_result_18
                return {
                    x = __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k,
                    y = __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k,
                    ang = math.atan(
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
            __newExpr(window.Int8Array, FW * FH),
            "fill",
            1
        )
        local tipo = __new("Uint8Array", FW * FH)
        local function ok(____, x, y)
            local ____t_result_24
            local ____t_23 = __t
            local ____t_result_22
            local ____t_21 = __t
            local ____temp_20 = __ge(x, 0) and __ge(y, 0)
            __O[518] = ____temp_20
            if ____t_21(____temp_20) then
                ____t_result_22 = __lt(x, FW)
            else
                ____t_result_22 = __O[518]
            end
            __O[519] = ____t_result_22
            if ____t_23(____t_result_22) then
                ____t_result_24 = __lt(y, FH)
            else
                ____t_result_24 = __O[519]
            end
            return ____t_result_24
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
                local ____set_26 = __set
                local ____get_result_25 = __get(TI, o.tipo)
                if ____get_result_25 == nil then
                    ____get_result_25 = 0
                end
                ____set_26(tipo, i, ____get_result_25)
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
                local ____t_result_27
                if __t(ok(nil, fx, fy)) then
                    ____t_result_27 = __get(nivel, fy * FW + fx)
                else
                    ____t_result_27 = __get(
                        nivel,
                        math.max(
                            0,
                            math.min(FH - 1, fy)
                        ) * FW + math.max(
                            0,
                            math.min(FW - 1, fx)
                        )
                    )
                end
                return ____t_result_27
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
                                        local ____i_28 = i
                                        i = ____i_28 + 1
                                        j = ____i_28
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
                local ____t_result_29
                if __t(suave) then
                    ____t_result_29 = curva(
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
                    )
                else
                    ____t_result_29 = __call(
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
                end
                local pl = ____t_result_29
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
                local ____t_31 = __t
                local ____t_result_30
                if __t(o.tipo) then
                    ____t_result_30 = __call(
                        __arrL({"asfalto", "pedra", "chao", "calcada"}, 4),
                        "includes",
                        o.tipo
                    )
                else
                    ____t_result_30 = o.tipo
                end
                if ____t_31(____t_result_30) then
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
                                            local ____t_35 = __t
                                            local ____t_result_34
                                            local ____t_33 = __t
                                            local ____t_result_32
                                            if __t(e) then
                                                ____t_result_32 = e.id ~= id
                                            else
                                                ____t_result_32 = e
                                            end
                                            __O[520] = ____t_result_32
                                            if ____t_33(____t_result_32) then
                                                ____t_result_34 = e.tipo == o.tipo
                                            else
                                                ____t_result_34 = __O[520]
                                            end
                                            if ____t_35(____t_result_34) then
                                                achou = true
                                            end
                                            dx = dx + 1
                                        end
                                    end
                                    dy = dy + 1
                                end
                            end
                            local ____t_37 = __t
                            local ____t_result_36
                            if __t(achou) then
                                ____t_result_36 = not __t(__call(
                                    juntas,
                                    "some",
                                    function(____, ____bindingPattern0)
                                        local b
                                        local a
                                        a = ____bindingPattern0[1]
                                        b = ____bindingPattern0[2]
                                        return __hypot(a - px, b - py) < 40
                                    end
                                ))
                            else
                                ____t_result_36 = achou
                            end
                            if ____t_37(____t_result_36) then
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
        local ____t_result_40
        local ____t_39 = __t
        local ____get_result_38 = __get(PAL, hex)
        __O[521] = ____get_result_38
        if ____t_39(____get_result_38) then
            ____t_result_40 = __O[521]
        else
            ____t_result_40 = __set(
                PAL,
                hex,
                RGB(nil, hex)
            )
        end
        return ____t_result_40
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
        local lv = __newExpr(window.Int8Array, N)
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
                                local ____temp_41
                                if L == 0 then
                                    ____temp_41 = (U - 1) * WH + 7
                                else
                                    ____temp_41 = (U - L) * WH
                                end
                                local hh = ____temp_41
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
                    do
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
                        do
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
                                    local ____temp_44
                                    if d < h - 2 then
                                        local ____temp_42
                                        if d < 2 then
                                            ____temp_42 = terraB
                                        else
                                            ____temp_42 = terraE
                                        end
                                        ____temp_44 = ____temp_42
                                    else
                                        local ____temp_43
                                        if d == h - 1 then
                                            ____temp_43 = AG.espuma
                                        else
                                            ____temp_43 = AG.raso
                                        end
                                        ____temp_44 = ____temp_43
                                    end
                                    put(nil, i, ____temp_44)
                                    do x = x + 1 continue end
                                end
                                local ____t_51 = __t
                                local ____t_result_50
                                local ____t_46 = __t
                                local ____temp_45 = d < lip
                                __O[523] = ____temp_45
                                if ____t_46(____temp_45) then
                                    local ____t_result_49
                                    local ____t_48 = __t
                                    local ____call_result_47 = __call(VERDE, "has", top)
                                    __O[522] = ____call_result_47
                                    if ____t_48(____call_result_47) then
                                        ____t_result_49 = __O[522]
                                    else
                                        ____t_result_49 = top == TI.campo
                                    end
                                    ____t_result_50 = ____t_result_49
                                else
                                    ____t_result_50 = __O[523]
                                end
                                if ____t_51(____t_result_50) then
                                    local ____temp_53
                                    if d == lip - 1 then
                                        ____temp_53 = pal(nil, "#2f5e26")
                                    else
                                        local ____temp_52
                                        if d == 0 then
                                            ____temp_52 = pal(nil, "#4f9a34")
                                        else
                                            ____temp_52 = pal(nil, "#3c7a2c")
                                        end
                                        ____temp_53 = ____temp_52
                                    end
                                    put(nil, i, ____temp_53)
                                    do x = x + 1 continue end
                                end
                                local ____t_57 = __t
                                local ____t_result_56
                                local ____t_55 = __t
                                local ____temp_54 = d < 2
                                __O[524] = ____temp_54
                                if ____t_55(____temp_54) then
                                    ____t_result_56 = __call(CAMINHO, "has", top)
                                else
                                    ____t_result_56 = __O[524]
                                end
                                if ____t_57(____t_result_56) then
                                    put(
                                        nil,
                                        i,
                                        pal(nil, "#7a8086")
                                    )
                                    do x = x + 1 continue end
                                end
                                if d >= h - 2 then
                                    put(nil, i, terraB)
                                    do x = x + 1 continue end
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
                                local ____t_61 = __t
                                local ____t_result_60
                                local ____t_59 = __t
                                local ____temp_58 = h2(nil, x, 99) < 0.035 and d > 4
                                __O[525] = ____temp_58
                                if ____t_59(____temp_58) then
                                    ____t_result_60 = d < h - 4
                                else
                                    ____t_result_60 = __O[525]
                                end
                                if ____t_61(____t_result_60) then
                                    col = terraB
                                end
                                local sx = __shr(x, 2)
                                local sy = math.floor((d + __band(x, 3)) / 3)
                                if h2(nil, sx, sy + y * 0, 13) > 0.93 then
                                    local ____temp_62
                                    if __mod(d, 3) == 0 then
                                        ____temp_62 = pedrinhaC
                                    else
                                        ____temp_62 = pedrinha
                                    end
                                    col = ____temp_62
                                end
                                if __t(__get(wd, i - 1) < 0 or __get(wd, i + 1) < 0) then
                                    f = f * 0.72
                                end
                                put(nil, i, col, f)
                                do x = x + 1 continue end
                            end
                            local ____t_result_63
                            if __t(__get(sh, i)) then
                                ____t_result_63 = 1 - __get(sh, i) * 0.045
                            else
                                ____t_result_63 = 1
                            end
                            local f = ____t_result_63
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
                                do x = x + 1 continue end
                            end
                            local tint = 1 + (L - 1) * 0.035
                            f = f * tint
                            local col
                            repeat
                                local ____switch232 = t
                                local ____cond232 = ____switch232 == TI.grama or ____switch232 == TI.mata or ____switch232 == TI.cerrado
                                if ____cond232 then
                                    do
                                        local ____temp_65
                                        if t == TI.mata then
                                            ____temp_65 = M3
                                        else
                                            local ____temp_64
                                            if t == TI.cerrado then
                                                ____temp_64 = CE3
                                            else
                                                ____temp_64 = G3
                                            end
                                            ____temp_65 = ____temp_64
                                        end
                                        local P3 = ____temp_65
                                        local m = vn(nil, x / 36, y / 36, 7)
                                        col = __get(P3, m < 0.38 and 0 or (m > 0.64 and 2 or 1))
                                        local q = h2(
                                            nil,
                                            __shr(x, 1),
                                            __shr(y, 1),
                                            8
                                        )
                                        if q > 0.93 then
                                            local ____temp_66
                                            if t == TI.cerrado then
                                                ____temp_66 = pal(nil, "#c8c070")
                                            else
                                                ____temp_66 = pal(nil, "#c8f07a")
                                            end
                                            col = ____temp_66
                                        elseif q < 0.05 then
                                            local ____temp_67
                                            if t == TI.cerrado then
                                                ____temp_67 = pal(nil, "#7a7a3a")
                                            else
                                                ____temp_67 = pal(nil, "#7cb83c")
                                            end
                                            col = ____temp_67
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
                                            col = pal(nil, hv > 0.5 and "#e2e5e8" or "#d4d8dc")
                                        elseif ly == 3 then
                                            col = pal(nil, "#a8aeb4")
                                        else
                                            col = pal(nil, hv > 0.66 and "#c4c8cc" or (hv > 0.33 and "#bcc0c4" or "#b4b9be"))
                                        end
                                        break
                                    end
                                end
                                ____cond232 = ____cond232 or ____switch232 == TI.calcada
                                if ____cond232 then
                                    do
                                        local lx = __mod(x, 8)
                                        local ly = __mod(y, 8)
                                        col = pal(
                                            nil,
                                            __t(lx == 7 or ly == 7) and "#b8b0a0" or (__t(__mod(
                                                math.floor(x / 8) + math.floor(y / 8),
                                                2
                                            )) and "#e6dfd0" or "#ddd5c4")
                                        )
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
                                        col = pal(
                                            nil,
                                            vn(nil, x / 6, y / 3, 16) > 0.7 and "#d8c07a" or "#ead69a"
                                        )
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
                                        col = pal(
                                            nil,
                                            fr < 0.35 and "#6a4228" or (fr < 0.45 and "#8a5a36" or (__t(__mod(
                                                x + math.floor(r) * 2,
                                                3
                                            )) and "#a6dc58" or "#ccf27e"))
                                        )
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
                                        local ____t_result_68
                                        if __t(__band(x, 1)) then
                                            ____t_result_68 = q > 0.5 and "#e8c25a" or "#d8ae48"
                                        else
                                            ____t_result_68 = __mod(r, 3) < 1 and "#f4dc80" or "#c89a3a"
                                        end
                                        col = pal(nil, ____t_result_68)
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
                                            col = pal(
                                                nil,
                                                fr < 0.12 and "#2f5e26" or (__t(b > 0.85 and fr > 0.3) and "#c43c3a" or (__mod(
                                                    x + math.floor(fr * 9),
                                                    4
                                                ) == 0 and "#58a83c" or "#3f8a30"))
                                            )
                                        else
                                            col = pal(nil, fr < 0.7 and "#6a4228" or "#8a5a36")
                                        end
                                        break
                                    end
                                end
                                ____cond232 = ____cond232 or ____switch232 == TI.campo
                                if ____cond232 then
                                    col = pal(
                                        nil,
                                        __t(__mod(
                                            math.floor(x / 12),
                                            2
                                        )) and "#5aa046" or "#66ae50"
                                    )
                                    break
                                end
                                ____cond232 = ____cond232 or ____switch232 == TI.quadra
                                if ____cond232 then
                                    col = pal(nil, "#3c7ab0")
                                    break
                                end
                                ____cond232 = ____cond232 or ____switch232 == TI.pista
                                if ____cond232 then
                                    col = pal(
                                        nil,
                                        h2(nil, x, y, 20) > 0.9 and "#4c5156" or "#565b61"
                                    )
                                    break
                                end
                                ____cond232 = ____cond232 or ____switch232 == TI.nuvem
                                if ____cond232 then
                                    do
                                        local m = vn(nil, x / 18, y / 10 + 0, 21)
                                        col = pal(nil, m > 0.6 and "#ffffff" or (m > 0.4 and "#eef4f8" or "#dde8f0"))
                                        break
                                    end
                                end
                                do
                                    col = __get(G3, 1)
                                end
                            until true
                            local ____get_result_69 = __get(ty, i - W)
                            if ____get_result_69 == nil then
                                ____get_result_69 = t
                            end
                            local tu = ____get_result_69
                            local ____get_result_70 = __get(ty, i + W)
                            if ____get_result_70 == nil then
                                ____get_result_70 = t
                            end
                            local tb = ____get_result_70
                            local ____get_result_71 = __get(ty, i - 1)
                            if ____get_result_71 == nil then
                                ____get_result_71 = t
                            end
                            local tl = ____get_result_71
                            local ____get_result_72 = __get(ty, i + 1)
                            if ____get_result_72 == nil then
                                ____get_result_72 = t
                            end
                            local tr = ____get_result_72
                            if __t(__call(CAMINHO, "has", t)) then
                                local ____t_78 = __t
                                local ____t_result_77
                                local ____t_76 = __t
                                local ____t_result_75
                                local ____t_74 = __t
                                local ____temp_73 = y > 0
                                __O[526] = ____temp_73
                                if ____t_74(____temp_73) then
                                    ____t_result_75 = __call(VERDE, "has", tu)
                                else
                                    ____t_result_75 = __O[526]
                                end
                                __O[527] = ____t_result_75
                                if ____t_76(____t_result_75) then
                                    ____t_result_77 = __get(lv, i - W) == L
                                else
                                    ____t_result_77 = __O[527]
                                end
                                if ____t_78(____t_result_77) then
                                    f = f * 0.74
                                else
                                    local ____t_84 = __t
                                    local ____t_result_83
                                    local ____t_82 = __t
                                    local ____t_result_81
                                    local ____t_80 = __t
                                    local ____temp_79 = y > 1
                                    __O[528] = ____temp_79
                                    if ____t_80(____temp_79) then
                                        ____t_result_81 = __call(
                                            VERDE,
                                            "has",
                                            __get(ty, i - 2 * W)
                                        )
                                    else
                                        ____t_result_81 = __O[528]
                                    end
                                    __O[529] = ____t_result_81
                                    if ____t_82(____t_result_81) then
                                        ____t_result_83 = __get(lv, i - 2 * W) == L
                                    else
                                        ____t_result_83 = __O[529]
                                    end
                                    if ____t_84(____t_result_83) then
                                        f = f * 0.88
                                    else
                                        local ____t_90 = __t
                                        local ____t_result_89
                                        local ____t_88 = __t
                                        local ____t_result_87
                                        local ____t_86 = __t
                                        local ____call_result_85 = __call(VERDE, "has", tl)
                                        __O[530] = ____call_result_85
                                        if ____t_86(____call_result_85) then
                                            ____t_result_87 = __O[530]
                                        else
                                            ____t_result_87 = __call(VERDE, "has", tr)
                                        end
                                        __O[531] = ____t_result_87
                                        if ____t_88(____t_result_87) then
                                            ____t_result_89 = __O[531]
                                        else
                                            ____t_result_89 = __call(VERDE, "has", tb)
                                        end
                                        if ____t_90(____t_result_89) then
                                            f = f * 0.84
                                        end
                                    end
                                end
                                local ____t_103 = __t
                                local ____t_result_102
                                local ____t_92 = __t
                                local ____temp_91 = t == TI.asfalto
                                __O[536] = ____temp_91
                                if ____t_92(____temp_91) then
                                    local ____t_result_101
                                    local ____t_100 = __t
                                    local ____t_result_99
                                    local ____t_98 = __t
                                    local ____t_result_97
                                    local ____t_96 = __t
                                    local ____t_result_95
                                    local ____t_94 = __t
                                    local ____temp_93 = tu == TI.pedra or tu == TI.calcada
                                    __O[532] = ____temp_93
                                    if ____t_94(____temp_93) then
                                        ____t_result_95 = __O[532]
                                    else
                                        ____t_result_95 = tb == TI.pedra
                                    end
                                    __O[533] = ____t_result_95
                                    if ____t_96(____t_result_95) then
                                        ____t_result_97 = __O[533]
                                    else
                                        ____t_result_97 = tb == TI.calcada
                                    end
                                    __O[534] = ____t_result_97
                                    if ____t_98(____t_result_97) then
                                        ____t_result_99 = __O[534]
                                    else
                                        ____t_result_99 = tl == TI.pedra
                                    end
                                    __O[535] = ____t_result_99
                                    if ____t_100(____t_result_99) then
                                        ____t_result_101 = __O[535]
                                    else
                                        ____t_result_101 = tr == TI.pedra
                                    end
                                    ____t_result_102 = ____t_result_101
                                else
                                    ____t_result_102 = __O[536]
                                end
                                if ____t_103(____t_result_102) then
                                    col = pal(nil, "#d8dcdf")
                                end
                            else
                                local ____t_109 = __t
                                local ____t_result_108
                                local ____t_107 = __t
                                local ____t_result_106
                                local ____t_105 = __t
                                local ____call_result_104 = __call(VERDE, "has", t)
                                __O[537] = ____call_result_104
                                if ____t_105(____call_result_104) then
                                    ____t_result_106 = __call(CAMINHO, "has", tb)
                                else
                                    ____t_result_106 = __O[537]
                                end
                                __O[538] = ____t_result_106
                                if ____t_107(____t_result_106) then
                                    ____t_result_108 = __get(lv, i + W) == L
                                else
                                    ____t_result_108 = __O[538]
                                end
                                if ____t_109(____t_result_108) then
                                    col = pal(nil, "#6aa232")
                                end
                            end
                            local ____t_113 = __t
                            local ____t_result_112
                            local ____t_111 = __t
                            local ____temp_110 = x > 0 and __get(lv, i - 1) < L
                            __O[539] = ____temp_110
                            if ____t_111(____temp_110) then
                                ____t_result_112 = __get(wd, i - 1) < 0
                            else
                                ____t_result_112 = __O[539]
                            end
                            if ____t_113(____t_result_112) then
                                col = pal(nil, "#4f8a28")
                                f = 1
                            else
                                local ____t_117 = __t
                                local ____t_result_116
                                local ____t_115 = __t
                                local ____temp_114 = x < W - 1 and __get(lv, i + 1) < L
                                __O[540] = ____temp_114
                                if ____t_115(____temp_114) then
                                    ____t_result_116 = __get(wd, i + 1) < 0
                                else
                                    ____t_result_116 = __O[540]
                                end
                                if ____t_117(____t_result_116) then
                                    col = pal(nil, "#4f8a28")
                                    f = 1
                                else
                                    local ____t_121 = __t
                                    local ____t_result_120
                                    local ____t_119 = __t
                                    local ____temp_118 = y > 0 and __get(lv, i - W) < L
                                    __O[541] = ____temp_118
                                    if ____t_119(____temp_118) then
                                        ____t_result_120 = __get(wd, i - W) < 0
                                    else
                                        ____t_result_120 = __O[541]
                                    end
                                    if ____t_121(____t_result_120) then
                                        col = pal(nil, "#d2f48a")
                                    end
                                end
                            end
                            put(nil, i, col, f)
                        end
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
            local ____t_127 = __t
            local ____t_result_126
            local ____t_125 = __t
            local ____t_result_124
            local ____t_123 = __t
            local ____temp_122 = __lt(x, 2) or __lt(y, 30)
            __O[542] = ____temp_122
            if ____t_123(____temp_122) then
                ____t_result_124 = __O[542]
            else
                ____t_result_124 = __ge(x, W - 2)
            end
            __O[543] = ____t_result_124
            if ____t_125(____t_result_124) then
                ____t_result_126 = __O[543]
            else
                ____t_result_126 = __ge(y, H - 2)
            end
            if ____t_127(____t_result_126) then
                return false
            end
            local i = y * W + x
            local ____t_result_144
            local ____t_143 = __t
            local ____t_result_142
            local ____t_141 = __t
            local ____t_result_140
            local ____t_139 = __t
            local ____t_result_138
            local ____t_137 = __t
            local ____t_result_136
            local ____t_135 = __t
            local ____t_result_134
            local ____t_133 = __t
            local ____t_result_132
            local ____t_131 = __t
            local ____t_result_130
            local ____t_129 = __t
            local ____call_result_128 = __call(
                VERDE,
                "has",
                __get(ty, i)
            )
            __O[544] = ____call_result_128
            if ____t_129(____call_result_128) then
                ____t_result_130 = __get(wd, i) < 0
            else
                ____t_result_130 = __O[544]
            end
            __O[545] = ____t_result_130
            if ____t_131(____t_result_130) then
                ____t_result_132 = not __t(__get(sh, i))
            else
                ____t_result_132 = __O[545]
            end
            __O[546] = ____t_result_132
            if ____t_133(____t_result_132) then
                ____t_result_134 = __get(lv, i) > 0
            else
                ____t_result_134 = __O[546]
            end
            __O[547] = ____t_result_134
            if ____t_135(____t_result_134) then
                ____t_result_136 = __get(lv, i - 26 * W) == __get(lv, i)
            else
                ____t_result_136 = __O[547]
            end
            __O[548] = ____t_result_136
            if ____t_137(____t_result_136) then
                ____t_result_138 = __get(wd, i - 26 * W) < 0
            else
                ____t_result_138 = __O[548]
            end
            __O[549] = ____t_result_138
            if ____t_139(____t_result_138) then
                ____t_result_140 = __get(lv, i + 3 * W) == __get(lv, i)
            else
                ____t_result_140 = __O[549]
            end
            __O[550] = ____t_result_140
            if ____t_141(____t_result_140) then
                ____t_result_142 = __get(ty, i - 1) == __get(ty, i)
            else
                ____t_result_142 = __O[550]
            end
            __O[551] = ____t_result_142
            if ____t_143(____t_result_142) then
                ____t_result_144 = __get(ty, i + 1) == __get(ty, i)
            else
                ____t_result_144 = __O[551]
            end
            return ____t_result_144
        end
        do
            local k = 0
            while k < N / 120 do
                do
                    local x = math.floor(h2(nil, k, 1, 31) * W)
                    local y = math.floor(h2(nil, k, 2, 31) * H)
                    local i = y * W + x
                    local ____t_152 = __t
                    local ____t_result_151
                    local ____t_150 = __t
                    local ____t_result_149
                    local ____t_148 = __t
                    local ____t_result_147
                    local ____t_146 = __t
                    local ____temp_145 = y < 4 or y > H - 2
                    __O[552] = ____temp_145
                    if ____t_146(____temp_145) then
                        ____t_result_147 = __O[552]
                    else
                        ____t_result_147 = not __t(__call(
                            VERDE,
                            "has",
                            __get(ty, i)
                        ))
                    end
                    __O[553] = ____t_result_147
                    if ____t_148(____t_result_147) then
                        ____t_result_149 = __O[553]
                    else
                        ____t_result_149 = __get(wd, i) >= 0
                    end
                    __O[554] = ____t_result_149
                    if ____t_150(____t_result_149) then
                        ____t_result_151 = __O[554]
                    else
                        ____t_result_151 = __get(lv, i) == 0
                    end
                    if ____t_152(____t_result_151) then
                        do k = k + 1 continue end
                    end
                    local q = h2(nil, k, 3, 31)
                    local esc = __get(ty, i) == TI.cerrado and "#7a7a3a" or "#3c7a2c"
                    local cla = __get(ty, i) == TI.cerrado and "#d8d080" or "#8ad45a"
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
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k < N / 260 do
                do
                    local x = math.floor(h2(nil, k, 5, 35) * W)
                    local y = math.floor(h2(nil, k, 6, 35) * H)
                    local i = y * W + x
                    local ____t_156 = __t
                    local ____t_result_155
                    local ____t_154 = __t
                    local ____temp_153 = y < 8 or __get(lv, i) ~= 0
                    __O[555] = ____temp_153
                    if ____t_154(____temp_153) then
                        ____t_result_155 = __O[555]
                    else
                        ____t_result_155 = __get(wd, i) >= 0
                    end
                    if ____t_156(____t_result_155) then
                        do k = k + 1 continue end
                    end
                    local ____t_result_161
                    local ____t_160 = __t
                    local ____t_result_159
                    local ____t_158 = __t
                    local ____temp_157 = not __t(agua(nil, x - 3, y)) or not __t(agua(nil, x + 3, y))
                    __O[556] = ____temp_157
                    if ____t_158(____temp_157) then
                        ____t_result_159 = __O[556]
                    else
                        ____t_result_159 = not __t(agua(nil, x, y + 3))
                    end
                    __O[557] = ____t_result_159
                    if ____t_160(____t_result_159) then
                        ____t_result_161 = __O[557]
                    else
                        ____t_result_161 = not __t(agua(nil, x, y - 3))
                    end
                    local beira = ____t_result_161
                    local ____t_result_168
                    local ____t_167 = __t
                    local ____t_result_166
                    local ____t_165 = __t
                    local ____t_result_164
                    local ____t_163 = __t
                    local ____agua_result_162 = agua(nil, x - 9, y)
                    __O[558] = ____agua_result_162
                    if ____t_163(____agua_result_162) then
                        ____t_result_164 = agua(nil, x + 9, y)
                    else
                        ____t_result_164 = __O[558]
                    end
                    __O[559] = ____t_result_164
                    if ____t_165(____t_result_164) then
                        ____t_result_166 = agua(nil, x, y - 7)
                    else
                        ____t_result_166 = __O[559]
                    end
                    __O[560] = ____t_result_166
                    if ____t_167(____t_result_166) then
                        ____t_result_168 = agua(nil, x, y + 7)
                    else
                        ____t_result_168 = __O[560]
                    end
                    local longe = ____t_result_168
                    local ____t_170 = __t
                    local ____t_result_169
                    if __t(beira) then
                        ____t_result_169 = h2(nil, k, 7, 35) > 0.45
                    else
                        ____t_result_169 = beira
                    end
                    if ____t_170(____t_result_169) then
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
                                    __t(__mod(j, 2)) and "#3f8a30" or "#58a83c"
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
                    else
                        local ____t_172 = __t
                        local ____t_result_171
                        if __t(longe) then
                            ____t_result_171 = h2(nil, k, 8, 35) > 0.82
                        else
                            ____t_result_171 = longe
                        end
                        if ____t_172(____t_result_171) then
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
                        local ____t_182 = __t
                        local ____t_result_181
                        local ____t_180 = __t
                        local ____t_result_179
                        local ____t_178 = __t
                        local ____t_result_177
                        local ____t_176 = __t
                        local ____t_result_175
                        local ____t_174 = __t
                        local ____temp_173 = __get(wd, i) == 0 and __get(wh, i) > 12
                        __O[561] = ____temp_173
                        if ____t_174(____temp_173) then
                            ____t_result_175 = __call(
                                VERDE,
                                "has",
                                __get(wt, i)
                            )
                        else
                            ____t_result_175 = __O[561]
                        end
                        __O[562] = ____t_result_175
                        if ____t_176(____t_result_175) then
                            ____t_result_177 = __get(wd, i - 3) >= 0
                        else
                            ____t_result_177 = __O[562]
                        end
                        __O[563] = ____t_result_177
                        if ____t_178(____t_result_177) then
                            ____t_result_179 = __get(wd, i + 3) >= 0
                        else
                            ____t_result_179 = __O[563]
                        end
                        __O[564] = ____t_result_179
                        if ____t_180(____t_result_179) then
                            ____t_result_181 = h2(nil, k, y, 41) > 0.55
                        else
                            ____t_result_181 = __O[564]
                        end
                        if ____t_182(____t_result_181) then
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
                                        __t(__mod(j, 3)) and "#3f8a30" or "#58a83c"
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
                local ____t_194 = __t
                local ____t_result_193
                local ____t_192 = __t
                local ____t_result_191
                local ____t_190 = __t
                local ____t_result_189
                local ____t_188 = __t
                local ____t_result_187
                local ____t_186 = __t
                local ____t_result_185
                local ____t_184 = __t
                local ____agua_result_183 = agua(nil, x, y)
                __O[565] = ____agua_result_183
                if ____t_184(____agua_result_183) then
                    ____t_result_185 = agua(nil, x - 6, y)
                else
                    ____t_result_185 = __O[565]
                end
                __O[566] = ____t_result_185
                if ____t_186(____t_result_185) then
                    ____t_result_187 = agua(nil, x + 6, y)
                else
                    ____t_result_187 = __O[566]
                end
                __O[567] = ____t_result_187
                if ____t_188(____t_result_187) then
                    ____t_result_189 = agua(nil, x, y - 4)
                else
                    ____t_result_189 = __O[567]
                end
                __O[568] = ____t_result_189
                if ____t_190(____t_result_189) then
                    ____t_result_191 = agua(nil, x, y + 4)
                else
                    ____t_result_191 = __O[568]
                end
                __O[569] = ____t_result_191
                if ____t_192(____t_result_191) then
                    ____t_result_193 = __get(wd, y * W + x) < 0
                else
                    ____t_result_193 = __O[569]
                end
                if ____t_194(____t_result_193) then
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
                local ____opt_result_203
                if def ~= nil then
                    ____opt_result_203 = def.teste
                end
                local ____opt_result_204
                if ____opt_result_203 ~= nil then
                    ____opt_result_204 = ____opt_result_203.acao
                end
                local ____opt_result_205
                if ____opt_result_204 ~= nil then
                    ____opt_result_205 = ____opt_result_204(____opt_result_203)
                end
                return ____opt_result_205
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
            local ____t_result_208
            local ____t_207 = __t
            local ____hypot_result_206 = __hypot(a.x - b.x, a.y - b.y)
            __O[570] = ____hypot_result_206
            if ____t_207(____hypot_result_206) then
                ____t_result_208 = __O[570]
            else
                ____t_result_208 = 1
            end
            return ____t_result_208
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
                local ____t_212 = __t
                local ____t_result_211
                local ____t_210 = __t
                local ____t_result_209
                if __t(pinca) then
                    ____t_result_209 = dedos.size == 2
                else
                    ____t_result_209 = pinca
                end
                __O[571] = ____t_result_209
                if ____t_210(____t_result_209) then
                    ____t_result_211 = not __t(viagem)
                else
                    ____t_result_211 = __O[571]
                end
                if ____t_212(____t_result_211) then
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
                local ____t_216 = __t
                local ____t_result_215
                local ____t_214 = __t
                local ____temp_213 = not __t(drag)
                __O[572] = ____temp_213
                if ____t_214(____temp_213) then
                    ____t_result_215 = __O[572]
                else
                    ____t_result_215 = viagem
                end
                if ____t_216(____t_result_215) then
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
                local ____t_220 = __t
                local ____t_result_219
                local ____t_218 = __t
                local ____t_result_217
                if __t(drag) then
                    ____t_result_217 = not __t(drag.moveu)
                else
                    ____t_result_217 = drag
                end
                __O[573] = ____t_result_217
                if ____t_218(____t_result_217) then
                    ____t_result_219 = not __t(eraPinca)
                else
                    ____t_result_219 = __O[573]
                end
                if ____t_220(____t_result_219) then
                    clique(nil, e)
                end
                drag = nil
            end
        )
        cv:addEventListener(
            "wheel",
            function(____, e)
                e:preventDefault()
                zoomPara(
                    nil,
                    cam.z * (__gt(e.deltaY, 0) and 0.88 or 1.14)
                )
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
    zMin = function()
        local ____t_result_221
        if __t(celular(nil)) then
            ____t_result_221 = math.min(cv.clientWidth / (M.W + 2 * M.PAD), cv.clientHeight / (M.H + 2 * M.PAD))
        else
            ____t_result_221 = zCobre(nil)
        end
        return ____t_result_221
    end
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
                        do
                            if not __t(__get(d, i + 3)) then
                                do i = i + 4 continue end
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
                            __set(
                                d,
                                i,
                                __gt(r, 255) and 255 or (__lt(r, 0) and 0 or r)
                            )
                            __set(
                                d,
                                i + 1,
                                __gt(gg, 255) and 255 or (__lt(gg, 0) and 0 or gg)
                            )
                            __set(
                                d,
                                i + 2,
                                __gt(b, 255) and 255 or (__lt(b, 0) and 0 or b)
                            )
                        end
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
                                do
                                    local i = (y * w + x) * 4
                                    if not __t(__get(d, i + 3)) then
                                        do x = x + 1 continue end
                                    end
                                    local r = __get(d, i)
                                    local gg = __get(d, i + 1)
                                    local b = __get(d, i + 2)
                                    if not __t(__gt(gg, r + 6) and __gt(gg, b + 18)) then
                                        do x = x + 1 continue end
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
                                end
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
        local ____t_result_227
        if __t(o.margem) then
            ____t_result_227 = o.margem
        else
            ____t_result_227 = 300
        end
        local PAD = ____t_result_227
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
        local ____t_result_228
        if __t(sn) then
            ____t_result_228 = __arrL({sr / sn, sg / sn, sb / sn}, 3)
        else
            ____t_result_228 = hex(nil, "#b4ea6a")
        end
        local med = ____t_result_228
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
            local ____t_result_233
            local ____t_232 = __t
            local ____t_result_231
            local ____t_230 = __t
            local ____temp_229 = math.abs(r - g) < 22 and math.abs(g - b) < 26
            __O[574] = ____temp_229
            if ____t_230(____temp_229) then
                ____t_result_231 = __gt(r, 140)
            else
                ____t_result_231 = __O[574]
            end
            __O[575] = ____t_result_231
            if ____t_232(____t_result_231) then
                ____t_result_233 = not __t(__gt(g, r + 6) and __gt(g, b + 18))
            else
                ____t_result_233 = __O[575]
            end
            return ____t_result_233
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
                        do
                            local x = X - PAD
                            local y = Y - PAD
                            local ____t_239 = __t
                            local ____t_result_238
                            local ____t_237 = __t
                            local ____t_result_236
                            local ____t_235 = __t
                            local ____temp_234 = x >= 0 and __lt(x, W)
                            __O[576] = ____temp_234
                            if ____t_235(____temp_234) then
                                ____t_result_236 = y >= 0
                            else
                                ____t_result_236 = __O[576]
                            end
                            __O[577] = ____t_result_236
                            if ____t_237(____t_result_236) then
                                ____t_result_238 = __lt(y, H)
                            else
                                ____t_result_238 = __O[577]
                            end
                            if ____t_239(____t_result_238) then
                                __set(cls, Y * W2 + X, 1)
                                do X = X + 1 continue end
                            end
                            local ____temp_241
                            if x < 0 then
                                ____temp_241 = 0
                            else
                                local ____ge_result_240
                                if __ge(x, W) then
                                    ____ge_result_240 = W - 1
                                else
                                    ____ge_result_240 = x
                                end
                                ____temp_241 = ____ge_result_240
                            end
                            local cx = ____temp_241
                            local ____temp_243
                            if y < 0 then
                                ____temp_243 = 0
                            else
                                local ____ge_result_242
                                if __ge(y, H) then
                                    ____ge_result_242 = H - 1
                                else
                                    ____ge_result_242 = y
                                end
                                ____temp_243 = ____ge_result_242
                            end
                            local cy = ____temp_243
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
                                    local ____t_result_246
                                    local ____t_245 = __t
                                    local ____temp_244 = __gt(
                                        __get(bd, q),
                                        236
                                    ) and __gt(
                                        __get(bd, q + 1),
                                        236
                                    )
                                    __O[578] = ____temp_244
                                    if ____t_245(____temp_244) then
                                        ____t_result_246 = __gt(
                                            __get(bd, q + 2),
                                            236
                                        )
                                    else
                                        ____t_result_246 = __O[578]
                                    end
                                    return ____t_result_246
                                end
                                local ____t_256 = __t
                                local ____t_result_255
                                local ____t_254 = __t
                                local ____t_result_253
                                local ____t_252 = __t
                                local ____t_result_251
                                local ____t_250 = __t
                                local ____t_result_249
                                local ____t_248 = __t
                                local ____br_result_247 = br(nil, cx, cy)
                                __O[579] = ____br_result_247
                                if ____t_248(____br_result_247) then
                                    ____t_result_249 = br(nil, cx - 10, cy - 10)
                                else
                                    ____t_result_249 = __O[579]
                                end
                                __O[580] = ____t_result_249
                                if ____t_250(____t_result_249) then
                                    ____t_result_251 = br(nil, cx + 10, cy + 10)
                                else
                                    ____t_result_251 = __O[580]
                                end
                                __O[581] = ____t_result_251
                                if ____t_252(____t_result_251) then
                                    ____t_result_253 = br(nil, cx - 10, cy + 10)
                                else
                                    ____t_result_253 = __O[581]
                                end
                                __O[582] = ____t_result_253
                                if ____t_254(____t_result_253) then
                                    ____t_result_255 = br(nil, cx + 10, cy - 10)
                                else
                                    ____t_result_255 = __O[582]
                                end
                                if ____t_256(____t_result_255) then
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
                                    do X = X + 1 continue end
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
                                    local ____t_260 = __t
                                    local ____t_result_259
                                    local ____t_258 = __t
                                    local ____rua_result_257 = rua(nil, er, eg, eb)
                                    __O[583] = ____rua_result_257
                                    if ____t_258(____rua_result_257) then
                                        ____t_result_259 = dd < m - 16
                                    else
                                        ____t_result_259 = __O[583]
                                    end
                                    if ____t_260(____t_result_259) then
                                        col = __get(
                                            TERRA,
                                            vn(nil, x / 5, y / 5, 45) < 0.5 and 0 or 1
                                        )
                                        k = 5
                                    else
                                        local ____temp_262
                                        if x < 0 then
                                            ____temp_262 = -x - 1
                                        else
                                            local ____ge_result_261
                                            if __ge(x, W) then
                                                ____ge_result_261 = 2 * W - 1 - x
                                            else
                                                ____ge_result_261 = x
                                            end
                                            ____temp_262 = ____ge_result_261
                                        end
                                        local mx = ____temp_262
                                        local ____temp_264
                                        if y < 0 then
                                            ____temp_264 = -y - 1
                                        else
                                            local ____ge_result_263
                                            if __ge(y, H) then
                                                ____ge_result_263 = 2 * H - 1 - y
                                            else
                                                ____ge_result_263 = y
                                            end
                                            ____temp_264 = ____ge_result_263
                                        end
                                        local my = ____temp_264
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
                                            col = __get(GR, n < 0.4 and 0 or (n > 0.62 and 2 or 1))
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
                                col = __get(AR, n < 0.35 and 1 or (n > 0.7 and 2 or 0))
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
                                __set(cls, Y * W2 + X, k == 5 and 1 or k)
                                if k == 5 then
                                    __set(trilha, Y * W2 + X, 1)
                                end
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
                        do
                            if __get(cls, Y * W2 + X) ~= 2 then
                                do X = X + 3 continue end
                            end
                            local ____t_270 = __t
                            local ____t_result_269
                            local ____t_268 = __t
                            local ____t_result_267
                            local ____t_266 = __t
                            local ____temp_265 = __get(cls, Y * W2 + X + 3) == 3 or __get(cls, Y * W2 + X - 3) == 3
                            __O[584] = ____temp_265
                            if ____t_266(____temp_265) then
                                ____t_result_267 = __O[584]
                            else
                                ____t_result_267 = __get(cls, (Y + 3) * W2 + X) == 3
                            end
                            __O[585] = ____t_result_267
                            if ____t_268(____t_result_267) then
                                ____t_result_269 = __O[585]
                            else
                                ____t_result_269 = __get(cls, (Y - 3) * W2 + X) == 3
                            end
                            if ____t_270(____t_result_269) then
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
                                local ____t_result_273
                                local ____t_272 = __t
                                local ____hypot_result_271 = __hypot(x - cx, y - cy)
                                __O[586] = ____hypot_result_271
                                if ____t_272(____hypot_result_271) then
                                    ____t_result_273 = __O[586]
                                else
                                    ____t_result_273 = 1
                                end
                                local dd = ____t_result_273
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
                                __t(__mod(j, 2)) and "#f2f2ee" or "#e8433a"
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
                local ____t_283 = __t
                local ____t_result_282
                local ____t_281 = __t
                local ____t_result_280
                local ____t_279 = __t
                local ____t_result_278
                local ____t_277 = __t
                local ____t_result_276
                local ____t_275 = __t
                local ____temp_274 = X < 0 or Y < 0
                __O[587] = ____temp_274
                if ____t_275(____temp_274) then
                    ____t_result_276 = __O[587]
                else
                    ____t_result_276 = __ge(X, W2)
                end
                __O[588] = ____t_result_276
                if ____t_277(____t_result_276) then
                    ____t_result_278 = __O[588]
                else
                    ____t_result_278 = __ge(Y, H2)
                end
                __O[589] = ____t_result_278
                if ____t_279(____t_result_278) then
                    ____t_result_280 = __O[589]
                else
                    ____t_result_280 = __get(cls, Y * W2 + X) ~= 1
                end
                __O[590] = ____t_result_280
                if ____t_281(____t_result_280) then
                    ____t_result_282 = __O[590]
                else
                    ____t_result_282 = __get(trilha, Y * W2 + X)
                end
                if ____t_283(____t_result_282) then
                    return false
                end
            end
            local ____t_result_288
            local ____t_287 = __t
            local ____t_result_286
            local ____t_285 = __t
            local ____temp_284 = __lt(
                x,
                __TS__Number(-r) - 4
            ) or __gt(
                x,
                __add(W, r) + 4
            )
            __O[591] = ____temp_284
            if ____t_285(____temp_284) then
                ____t_result_286 = __O[591]
            else
                ____t_result_286 = __lt(y, -4)
            end
            __O[592] = ____t_result_286
            if ____t_287(____t_result_286) then
                ____t_result_288 = __O[592]
            else
                ____t_result_288 = __gt(y, H + 34)
            end
            return ____t_result_288
        end
        local ocupados = __arrL({}, 0)
        do
            local k = 0
            while k < 1400 do
                do
                    local x = __TS__Number(-PAD) + hash(nil, k, 7) * W2
                    local y = __TS__Number(-PAD) + hash(nil, k, 8) * H2
                    local h = hash(nil, k, 9)
                    local raio = h < 0.45 and 14 or (h < 0.62 and 12 or (h < 0.66 and 26 or 7))
                    local ____t_292 = __t
                    local ____t_result_291
                    local ____t_290 = __t
                    local ____temp_289 = not __t(livre(nil, x, y, raio))
                    __O[593] = ____temp_289
                    if ____t_290(____temp_289) then
                        ____t_result_291 = __O[593]
                    else
                        ____t_result_291 = __call(
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
                        )
                    end
                    if ____t_292(____t_result_291) then
                        do k = k + 1 continue end
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
                            __t(__mod(k, 5)) and "verde" or "amarela",
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
                        __t(__mod(j, 2)) and "#f2f2ee" or "#c43c3a"
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
            while true do
                local ____t_314 = __t
                local ____temp_313 = k < 400
                if ____temp_313 then
                    local ____lt_312 = __lt
                    local ____len_result_311 = __len(eolicas)
                    local ____t_result_310
                    if __t(o.eolicas) then
                        ____t_result_310 = o.eolicas
                    else
                        ____t_result_310 = 0
                    end
                    ____temp_313 = ____lt_312(____len_result_311, ____t_result_310)
                end
                if not ____t_314(____temp_313) then
                    break
                end
                do
                    local x = __TS__Number(-PAD) + hash(nil, k, 21) * W2
                    local y = __TS__Number(-PAD) + hash(nil, k, 22) * H2
                    local X = math.floor(x + PAD + 0.5)
                    local Y = math.floor(y + PAD + 0.5)
                    local ____t_309 = __t
                    local ____t_result_308
                    local ____t_307 = __t
                    local ____t_result_306
                    local ____t_300 = __t
                    local ____t_result_299
                    local ____t_298 = __t
                    local ____t_result_297
                    local ____t_296 = __t
                    local ____t_result_295
                    local ____t_294 = __t
                    local ____temp_293 = X < 0 or Y < 0
                    __O[594] = ____temp_293
                    if ____t_294(____temp_293) then
                        ____t_result_295 = __O[594]
                    else
                        ____t_result_295 = __ge(X, W2)
                    end
                    __O[595] = ____t_result_295
                    if ____t_296(____t_result_295) then
                        ____t_result_297 = __O[595]
                    else
                        ____t_result_297 = __ge(Y, H2)
                    end
                    __O[596] = ____t_result_297
                    if ____t_298(____t_result_297) then
                        ____t_result_299 = __O[596]
                    else
                        ____t_result_299 = __get(cls, Y * W2 + X) ~= 1
                    end
                    __O[599] = ____t_result_299
                    if ____t_300(____t_result_299) then
                        ____t_result_306 = __O[599]
                    else
                        local ____t_result_305
                        local ____t_304 = __t
                        local ____t_result_303
                        local ____t_302 = __t
                        local ____temp_301 = x > -10 and __lt(x, W + 10)
                        __O[597] = ____temp_301
                        if ____t_302(____temp_301) then
                            ____t_result_303 = y > -10
                        else
                            ____t_result_303 = __O[597]
                        end
                        __O[598] = ____t_result_303
                        if ____t_304(____t_result_303) then
                            ____t_result_305 = __lt(y, H + 10)
                        else
                            ____t_result_305 = __O[598]
                        end
                        ____t_result_306 = ____t_result_305
                    end
                    __O[600] = ____t_result_306
                    if ____t_307(____t_result_306) then
                        ____t_result_308 = __O[600]
                    else
                        ____t_result_308 = __call(
                            eolicas,
                            "some",
                            function(____, ____bindingPattern0)
                                local ey
                                local ex
                                ex = ____bindingPattern0[1]
                                ey = ____bindingPattern0[2]
                                return __hypot(ex - x, ey - y) < 60
                            end
                        )
                    end
                    if ____t_309(____t_result_308) then
                        do k = k + 1 continue end
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
                end
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
        local ____this_316
        ____this_316 = d
        local ____opt_315 = ____this_316.objetos
        if ____opt_315 ~= nil then
            ____opt_315(
                ____this_316,
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
                local ____t_result_317
                if __t(L.desloc) then
                    ____t_result_317 = L.desloc
                else
                    ____t_result_317 = __arrL({0, 0}, 2)
                end
                local dx, dy = table.unpack(____t_result_317, 1, 2)
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
        local ____t_result_318
        if __t(d.ilha) then
            ____t_result_318 = fazerIlha(nil, base, d.ilha, d)
        else
            ____t_result_318 = nil
        end
        local ilha = ____t_result_318
        local aves = __arrayFrom(
            {length = 4},
            function(____, _, k) return {
                x = math.random() * W,
                y = 80 + k * (H - 160) / 4,
                v = 34 + math.random() * 22,
                dir = __t(__mod(k, 2)) and -1 or 1,
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
        local ____t_result_321
        if __t(ilha) then
            local ____arrayFrom_320 = __arrayFrom
            local ____t_result_319
            if __t(d.ilha.parapentes) then
                ____t_result_319 = d.ilha.parapentes
            else
                ____t_result_319 = 0
            end
            ____t_result_321 = ____arrayFrom_320(
                {length = ____t_result_319},
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
            )
        else
            ____t_result_321 = __arrL({}, 0)
        end
        local parapentes = ____t_result_321
        local ____t_result_324
        local ____t_323 = __t
        local ____t_result_322
        if __t(ilha) then
            ____t_result_322 = d.ilha.balao
        else
            ____t_result_322 = ilha
        end
        if ____t_323(____t_result_322) then
            ____t_result_324 = {x = -60, y = H * 0.35}
        else
            ____t_result_324 = nil
        end
        local balao = ____t_result_324
        local ____t_result_325
        if __t(ilha) then
            ____t_result_325 = __call(
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
            )
        else
            ____t_result_325 = __arrL({}, 0)
        end
        local barcos = ____t_result_325
        local ____t_result_326
        if __t(ilha) then
            ____t_result_326 = __call(
                __arrL({0, 1, 2, 3}, 4),
                "map",
                function(____, k) return {a = k * 1.6 + 0.7, fase = k * 2.3} end
            )
        else
            ____t_result_326 = __arrL({}, 0)
        end
        local golfinhos = ____t_result_326
        local ____base_329 = base
        local ____obj_330 = obj
        local ____locs_331 = locs
        local ____W_332 = W
        local ____H_333 = H
        local ____t_result_327
        if __t(Tr.aguaPontos) then
            ____t_result_327 = Tr.aguaPontos
        else
            ____t_result_327 = __arrL({}, 0)
        end
        local ____Tr_334 = Tr
        local ____aves_335 = aves
        local ____borbo_336 = borbo
        local ____ilha_337 = ilha
        local ____t_result_328
        if __t(ilha) then
            ____t_result_328 = ilha.pad
        else
            ____t_result_328 = 0
        end
        return {
            base = ____base_329,
            obj = ____obj_330,
            locs = ____locs_331,
            W = ____W_332,
            H = ____H_333,
            agua = ____t_result_327,
            Tr = ____Tr_334,
            aves = ____aves_335,
            borbo = ____borbo_336,
            ilha = ____ilha_337,
            PAD = ____t_result_328,
            barcos = barcos,
            golfinhos = golfinhos,
            parapentes = parapentes,
            balao = balao
        }
    end
    SIMPLES = not not __t(window.DAROCA_ROBLOX)
    LS = nil
    local function abrirSimples(self, d)
        def = d
        if not __t(LS) then
            local el = window.document:createElement("div")
            el.className = "m3d-lista"
            el.hidden = true
            el:setAttribute("role", "dialog")
            el:setAttribute("aria-modal", "true")
            el.innerHTML = "<canvas width=\"480\" height=\"270\"></canvas><button type=\"button\" class=\"ant\" aria-label=\"Lugar anterior\">&lt;</button><button type=\"button\" class=\"prox\" aria-label=\"Próximo lugar\">&gt;</button><button type=\"button\" class=\"ir\">IR PARA LÁ</button><button type=\"button\" class=\"teste\" hidden></button><button type=\"button\" class=\"fechar\">FECHAR</button>"
            window.document.body:appendChild(el)
            LS = {
                el = el,
                cv = el:querySelector("canvas"),
                sel = 0,
                aviso = 0
            }
            LS.g = LS.cv:getContext("2d")
            el:querySelector(".ant"):addEventListener(
                "click",
                function() return moverSimples(nil, -1) end
            )
            el:querySelector(".prox"):addEventListener(
                "click",
                function() return moverSimples(nil, 1) end
            )
            el:querySelector(".ir"):addEventListener(
                "click",
                function() return irSimples(nil) end
            )
            el:querySelector(".fechar"):addEventListener("click", fechar)
            el:querySelector(".teste"):addEventListener(
                "click",
                function()
                    local ____opt_result_344
                    if def ~= nil then
                        ____opt_result_344 = def.teste
                    end
                    local ____opt_result_345
                    if ____opt_result_344 ~= nil then
                        ____opt_result_345 = ____opt_result_344.acao
                    end
                    local ____opt_result_346
                    if ____opt_result_345 ~= nil then
                        ____opt_result_346 = ____opt_result_345(____opt_result_344)
                    end
                    return ____opt_result_346
                end
            )
            window:addEventListener(
                "keydown",
                function(____, e)
                    if __t(not __t(aberto) or not __t(SIMPLES)) then
                        return
                    end
                    local k = e.key
                    local cols = colsSimples(nil)
                    if k == "Escape" then
                        fechar(nil)
                    elseif k == "ArrowRight" then
                        moverSimples(nil, 1)
                    elseif k == "ArrowLeft" then
                        moverSimples(nil, -1)
                    elseif k == "ArrowDown" then
                        moverSimples(nil, cols)
                    elseif k == "ArrowUp" then
                        moverSimples(nil, -cols)
                    elseif __t(k == "Enter" or k == " ") then
                        irSimples(nil)
                    else
                        return
                    end
                    e:preventDefault()
                    e:stopImmediatePropagation()
                end,
                true
            )
        end
        local atual = __call(
            d.locais,
            "findIndex",
            function(____, L) return L.atual end
        )
        LS.sel = math.max(0, atual)
        LS.aviso = 0
        local bt = LS.el:querySelector(".teste")
        bt.hidden = not __t(d.teste)
        local ____t_result_350
        local ____t_349 = __t
        local ____opt_347 = d.teste
        if ____opt_347 ~= nil then
            ____opt_347 = ____opt_347.rotulo
        end
        __O[601] = ____opt_347
        if ____t_349(____opt_347) then
            ____t_result_350 = __O[601]
        else
            ____t_result_350 = ""
        end
        bt.textContent = ____t_result_350
        local ____temp_354 = LS.el:querySelector(".ir")
        local ____call_353 = __call
        local ____re_replace_352 = __re_replace
        local ____t_result_351
        if __t(d.botao) then
            ____t_result_351 = d.botao
        else
            ____t_result_351 = "IR PARA LÁ"
        end
        ____temp_354.textContent = ____call_353(
            ____re_replace_352(
                tostring(____t_result_351),
                __re("[▶►]", "g"),
                ""
            ),
            "trim"
        )
        aberto = true
        sel = LS.sel
        viagem = nil
        LS.el.hidden = false
        desenharSimples(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        return true
    end
    colsSimples = function()
        local ____t_356 = __t
        local ____t_result_355
        if __t(def) then
            ____t_result_355 = __gt(
                __len(def.locais),
                12
            )
        else
            ____t_result_355 = def
        end
        return ____t_356(____t_result_355) and 3 or 2
    end
    local function abrir(self, d)
        if __t(SIMPLES) then
            return abrirSimples(nil, d)
        end
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
        local ____temp_411 = ui:querySelector(".s")
        local ____t_result_410
        if __t(d.subtitulo) then
            ____t_result_410 = d.subtitulo
        else
            ____t_result_410 = ""
        end
        ____temp_411.textContent = ____t_result_410
        local bt = ui:querySelector(".teste")
        bt.hidden = not __t(d.teste)
        local ____t_result_415
        local ____t_414 = __t
        local ____opt_412 = d.teste
        if ____opt_412 ~= nil then
            ____opt_412 = ____opt_412.rotulo
        end
        __O[606] = ____opt_412
        if ____t_414(____opt_412) then
            ____t_result_415 = __O[606]
        else
            ____t_result_415 = ""
        end
        bt.textContent = ____t_result_415
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
        local ____ge_result_416
        if __ge(atual, 0) then
            ____ge_result_416 = centro(nil, atual)
        else
            ____ge_result_416 = {x = M.W / 2, y = M.H / 2}
        end
        local foco = ____ge_result_416
        cam = {
            x = M.W / 2,
            y = M.H / 2,
            z = zMin(nil)
        }
        limitar(nil)
        local ____assign_result_420 = __assign({}, cam)
        local ____foco_x_418 = foco.x
        local ____foco_y_419 = foco.y
        local ____t_result_417
        if __t(celular(nil)) then
            ____t_result_417 = math.min(
                zMax,
                math.max(
                    zMin(nil) * 1.15,
                    zCobre(nil) * 0.9
                )
            )
        else
            ____t_result_417 = math.min(
                zMax,
                zMapa(nil) * 1.9
            )
        end
        anim = {
            de = ____assign_result_420,
            para = {x = ____foco_x_418, y = ____foco_y_419, z = ____t_result_417},
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
                    local ____t_result_423
                    local ____t_422 = __t
                    local ____t_result_421
                    if __t(aberto) then
                        ____t_result_421 = sel < 0
                    else
                        ____t_result_421 = aberto
                    end
                    __O[607] = ____t_result_421
                    if ____t_422(____t_result_421) then
                        ____t_result_423 = selecionar(nil, atual)
                    else
                        ____t_result_423 = __O[607]
                    end
                    return ____t_result_423
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
                local ____callq_622 = __callq
                local ____opt_result_621
                if def ~= nil then
                    ____opt_result_621 = def.locais
                end
                local ____callq_622_result_623 = ____callq_622(
                    ____opt_result_621,
                    "findIndex",
                    function(____, L) return L.id == id end
                )
                if ____callq_622_result_623 == nil then
                    ____callq_622_result_623 = -1
                end
                local i = ____callq_622_result_623
                if __lt(i, 0) then
                    return
                end
                if __t(SIMPLES) then
                    moverSimples(nil, i - LS.sel)
                else
                    selecionar(nil, i)
                end
            end,
            ir = function()
                local ____t_result_624
                if __t(SIMPLES) then
                    ____t_result_624 = irSimples(nil)
                else
                    ____t_result_624 = ir(nil)
                end
                return ____t_result_624
            end,
            info = function(____, v)
                local ____t_result_625
                if __t(SIMPLES) then
                    ____t_result_625 = nil
                else
                    ____t_result_625 = mostrarInfo(nil, v)
                end
                return ____t_result_625
            end,
            simples = SIMPLES,
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
        "abrir,fechar,aberto,selecionar,ir,info,simples,arte"
    )
end)(nil)
return ____exports
