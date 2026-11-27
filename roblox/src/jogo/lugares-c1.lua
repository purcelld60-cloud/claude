--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __NumberV, __lt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call = __JSR.__NumberV, __JSR.__lt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call
local __add, __iter, __keys, __entries, __assign, __isArray = __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__entries, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.LugaresC1) then
        return
    end
    local ____opt_0 = window.HdMaps
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.kit
    end
    local K = ____opt_0
    local FLOOR = 440
    local TAU = math.pi * 2
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
    local function ell(____, c, x, y, rx, ry, cor)
        c.fillStyle = cor
        c:beginPath()
        c:ellipse(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            rx,
            ry,
            0,
            0,
            TAU
        )
        __call(c, "fill")
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
    local LUGARES = {
        ["40"] = __ord(
            {
                nome = "Oficina do Lucas",
                sub = "Garagem e ferramentas",
                largura = 2400,
                porta = nil,
                interno = true,
                plataformas = __arrL(
                    {
                        __arrL({480, 330, 150}, 3),
                        __arrL({880, 300, 140}, 3),
                        __arrL({1460, 320, 150}, 3),
                        __arrL({1900, 290, 140}, 3)
                    },
                    4
                )
            },
            "nome,sub,largura,porta,interno,plataformas"
        ),
        ["41"] = __ord(
            {
                nome = "Lanchonete do Zito",
                sub = "Coxinha, pastel e suco de cacau",
                largura = 2000,
                porta = 300,
                interno = true,
                plataformas = __arrL(
                    {__arrL({1320, 330, 170}, 3)},
                    1
                )
            },
            "nome,sub,largura,porta,interno,plataformas"
        ),
        ["42"] = __ord(
            {
                nome = "Açude da Roça",
                sub = "Píer, capivaras e pescaria",
                largura = 2400,
                porta = nil,
                interno = false,
                plataformas = __arrL(
                    {
                        __arrL({1180, 380, 420}, 3),
                        __arrL({1720, 320, 140}, 3)
                    },
                    2
                )
            },
            "nome,sub,largura,porta,interno,plataformas"
        )
    }
    local NPCS = __ord(
        {
            tio_juca = __ord({name = "Tio Juca · mecânico", scene = 40, x = 760}, "name,scene,x"),
            zito = __ord({name = "Seu Zito · lanchonete", scene = 41, x = 1040}, "name,scene,x"),
            vagner = __ord({name = "Seu Vagner · pescador", scene = 42, x = 1500, y = 380}, "name,scene,x,y")
        },
        "tio_juca,zito,vagner"
    )
    local FERRAMENTAS = __arrL(
        {
            __ord({id = "chave", x = 560, y = 300, nome = "Chave inglesa"}, "id,x,y,nome"),
            __ord({id = "macaco", x = 950, y = 270, nome = "Macaco hidráulico"}, "id,x,y,nome"),
            __ord({id = "alicate", x = 1960, y = 260, nome = "Alicate do Tio Juca"}, "id,x,y,nome")
        },
        3
    )
    local GENTE = __ord(
        {
            tio_juca = __ord(
                {
                    name = "Tio Juca",
                    skin = "#8a5a3c",
                    shade = "#5f3d2a",
                    build = "belly",
                    top = "#2f5d8c",
                    topKind = "overall",
                    inner = "#c9c3b0",
                    pants = "#2f5d8c",
                    hat = __ord({kind = "cap", color = "#c0443c"}, "kind,color"),
                    hair = __ord({style = "short", color = "#8a847a"}, "style,color"),
                    mustache = "#6f665c",
                    grease = true,
                    item = "wrench",
                    pose = "carry"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hat,hair,mustache,grease,item,pose"
            ),
            zito = __ord(
                {
                    name = "Seu Zito",
                    skin = "#c48a62",
                    shade = "#93613f",
                    build = "belly",
                    top = "#f2f2ec",
                    topKind = "apron",
                    apron = "#e8433a",
                    pants = "#3a3f46",
                    hat = __ord({kind = "cap", color = "#f2f2ec", band = "#e8433a"}, "kind,color,band"),
                    hair = __ord({style = "short", color = "#2a1d16"}, "style,color"),
                    mustache = "#2a1d16",
                    pose = "talk"
                },
                "name,skin,shade,build,top,topKind,apron,pants,hat,hair,mustache,pose"
            ),
            vagner = __ord(
                {
                    name = "Seu Vagner",
                    skin = "#c48a62",
                    shade = "#93613f",
                    build = "belly",
                    h = 0.84,
                    top = "#5a7a4a",
                    topKind = "vest",
                    vest = "#c9a24a",
                    vestBand = "#8a6a2a",
                    pants = "#4a4a42",
                    hair = __ord({style = "short", color = "#2a1d16"}, "style,color"),
                    mustache = "#2a1d16",
                    goatee = "#2a1d16",
                    pose = "relaxed"
                },
                "name,skin,shade,build,h,top,topKind,vest,vestBand,pants,hair,mustache,goatee,pose"
            )
        },
        "tio_juca,zito,vagner"
    )
    local function registrar()
        local CP = window.CampanhaPersonagens
        local ____t_5 = __t
        local ____opt_result_4
        if CP ~= nil then
            ____opt_result_4 = CP.registrar
        end
        if not ____t_5(____opt_result_4) then
            return false
        end
        for ____, ____value in __iterar((__entries(GENTE))) do
            local id = ____value[1]
            local sp = ____value[2]
            CP:registrar(id, sp, "NPC (Itabuna)")
        end
        return true
    end
    if not __t(registrar(nil)) then
        window:addEventListener("DOMContentLoaded", registrar, {once = true})
    end
    local function glow(____, c, x, y, r, cor, a)
        if a == nil then
            a = 0.3
        end
        if a <= 0.01 then
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
    local function cone(____, c, x, y, w0, w1, h, cor, a)
        c:save()
        c.globalCompositeOperation = "lighter"
        local g = c:createLinearGradient(
            0,
            y,
            0,
            __add(y, h)
        )
        g:addColorStop(0, cor)
        g:addColorStop(1, "rgba(0,0,0,0)")
        c.globalAlpha = a
        c.fillStyle = g
        c:beginPath()
        c:moveTo(x - w0, y)
        c:lineTo(
            __add(x, w0),
            y
        )
        c:lineTo(
            __add(x, w1),
            __add(y, h)
        )
        c:lineTo(
            x - w1,
            __add(y, h)
        )
        c:closePath()
        __call(c, "fill")
        c:restore()
    end
    local function noiteDe(____, s)
        local ____t_10 = __t
        local ____opt_result_8
        if s ~= nil then
            ____opt_result_8 = s.night
        end
        local ____TS__Number_result_9 = __TS__Number(____opt_result_8)
        __O[1312] = ____TS__Number_result_9
        return math.max(
            0,
            math.min(1, if ____t_10(____TS__Number_result_9) then __O[1312] else 0)
        )
    end
    local function dith(____, c, x, y, w, h, cor, k)
        if k == nil then
            k = 2
        end
        do
            local yy = 0
            while __lt(yy, h) do
                do
                    local xx = __mod(yy, 2)
                    while __lt(xx, w) do
                        R(
                            nil,
                            c,
                            x + xx,
                            y + yy,
                            1,
                            1,
                            cor
                        )
                        xx = xx + k
                    end
                end
                yy = yy + 1
            end
        end
    end
    local function fumacaSobe(self, c, x, y, t, n, alt, cor)
        if n == nil then
            n = 8
        end
        if alt == nil then
            alt = 40
        end
        if cor == nil then
            cor = "#9aa0b8"
        end
        do
            local k = 0
            while k < n do
                local u = __mod(t * 0.18 + k / n, 1)
                c.globalAlpha = (1 - u) * 0.5
                local r = 2 + u * 6
                ell(
                    nil,
                    c,
                    x + math.sin(t * 0.8 + k + u * 4) * (2 + u * 8) + u * 10,
                    y - u * alt,
                    r,
                    r * 0.8,
                    cor
                )
                k = k + 1
            end
        end
        c.globalAlpha = 1
    end
    local function vagalumes(self, c, x0, x1, y0, y1, t, n, a, cor)
        if cor == nil then
            cor = "#8af0ff"
        end
        do
            local k = 0
            while __lt(k, n) do
                local fx = x0 + hash(nil, k + 3) * (x1 - x0) + math.sin(t * 0.7 + k) * 8
                local fy = y0 + hash(nil, k + 7) * (y1 - y0) + math.cos(t * 0.9 + k * 1.3) * 5
                local b = 0.5 + 0.5 * math.sin(t * 3 + k * 2.1)
                if b < 0.2 then
                    continue
                end
                R(
                    nil,
                    c,
                    fx,
                    fy,
                    1,
                    1,
                    "#ffffff"
                )
                glow(
                    nil,
                    c,
                    fx,
                    fy,
                    6,
                    cor,
                    a * b
                )
                k = k + 1
            end
        end
    end
    local oficinaMid = nil
    local OF = __ord(
        {
            W = 1240,
            PEG = __arrL({230, 700}, 2),
            LAMP = __arrL({
                120,
                330,
                560,
                790,
                1010
            }, 5),
            JAN = __arrL({300, 560, 820, 1080}, 4)
        },
        "W,PEG,LAMP,JAN"
    )
    local function buildOficina(self)
        local W = OF.W
        local cv, c = table.unpack(
            mk(nil, W, 270),
            1,
            2
        )
        do
            local y = 26
            while y < 220 do
                local k = (y - 26) / 194
                R(
                    nil,
                    c,
                    0,
                    y,
                    W,
                    1,
                    ((((("rgb(" .. tostring(math.floor(52 + k * 26 + 0.5))) .. ",") .. tostring(math.floor(60 + k * 26 + 0.5))) .. ",") .. tostring(math.floor(72 + k * 22 + 0.5))) .. ")"
                )
                y = y + 1
            end
        end
        do
            local y = 30
            while y < 220 do
                R(
                    nil,
                    c,
                    0,
                    y,
                    W,
                    1,
                    "rgba(20,26,36,.35)"
                )
                do
                    local x = __mod(y / 12, 2) * 14
                    while x < W do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            12,
                            "rgba(20,26,36,.28)"
                        )
                        x = x + 28
                    end
                end
                y = y + 12
            end
        end
        do
            local i = 0
            while i < 2600 do
                R(
                    nil,
                    c,
                    hash(nil, i) * W,
                    28 + hash(nil, i + 1) * 190,
                    1,
                    1,
                    if __t(__mod(i, 3)) then "rgba(255,255,255,.05)" else "rgba(0,0,0,.12)"
                )
                i = i + 1
            end
        end
        local ____opt_13 = window.LugaresFundos
        if ____opt_13 ~= nil then
            ____opt_13 = ____opt_13.oficinaParede
        end
        if ____opt_13 ~= nil then
            ____opt_13(____opt_13, c, W)
        end
        R(
            nil,
            c,
            0,
            186,
            W,
            34,
            "#3e4652"
        )
        R(
            nil,
            c,
            0,
            186,
            W,
            2,
            "#d8a83a"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    188,
                    8,
                    2,
                    "#1c1c1c"
                )
                x = x + 16
            end
        end
        R(
            nil,
            c,
            0,
            0,
            W,
            26,
            "#1e2128"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    0,
                    2,
                    24,
                    "#2a2e36"
                )
                x = x + 5
            end
        end
        R(
            nil,
            c,
            0,
            24,
            W,
            3,
            "#121418"
        )
        do
            local x = 40
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    0,
                    8,
                    220,
                    "#2c3440"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    0,
                    2,
                    220,
                    "#46505e"
                )
                do
                    local y = 10
                    while y < 220 do
                        R(
                            nil,
                            c,
                            x + 3,
                            y,
                            2,
                            2,
                            "#6a7482"
                        )
                        y = y + 22
                    end
                end
                x = x + 200
            end
        end
        R(
            nil,
            c,
            0,
            28,
            W,
            6,
            "#2c3440"
        )
        R(
            nil,
            c,
            0,
            28,
            W,
            1,
            "#46505e"
        )
        for ____, x in __iterar((OF.JAN)) do
            R(
                nil,
                c,
                x - 2,
                40,
                64,
                30,
                "#1c222a"
            )
            R(
                nil,
                c,
                x + 30,
                42,
                2,
                26,
                "#1c222a"
            )
            R(
                nil,
                c,
                x,
                54,
                60,
                2,
                "#1c222a"
            )
        end
        for ____, px in __iterar((OF.PEG)) do
            R(
                nil,
                c,
                px - 2,
                94,
                124,
                66,
                "#6a4a2a"
            )
            R(
                nil,
                c,
                px,
                96,
                120,
                62,
                "#c8a46a"
            )
            do
                local y = 99
                while y < 156 do
                    do
                        local x = px + 3
                        while x < px + 118 do
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                "#8a6a3a"
                            )
                            x = x + 5
                        end
                    end
                    y = y + 5
                end
            end
            do
                local k = 0
                while k < 8 do
                    local x = px + 8 + k * 14
                    local h = 18 + __mod(k, 3) * 7
                    local cor = __get(
                        __arrL({
                            "#9aa0a6",
                            "#c43c3a",
                            "#3c6aa8",
                            "#e8c24a",
                            "#7a8086"
                        }, 5),
                        __mod(k, 5)
                    )
                    R(
                        nil,
                        c,
                        x - 2,
                        100 + __mod(k, 2) * 4,
                        7,
                        h + 2,
                        "rgba(60,40,20,.35)"
                    )
                    R(
                        nil,
                        c,
                        x,
                        100 + __mod(k, 2) * 4,
                        3,
                        h,
                        cor
                    )
                    R(
                        nil,
                        c,
                        x - 2,
                        100 + __mod(k, 2) * 4,
                        7,
                        3,
                        "#7a8086"
                    )
                    R(
                        nil,
                        c,
                        x,
                        100 + __mod(k, 2) * 4,
                        1,
                        h,
                        "rgba(255,255,255,.3)"
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        px + 10 + k * 34,
                        140,
                        22,
                        12,
                        "#3a3e44"
                    )
                    R(
                        nil,
                        c,
                        px + 11 + k * 34,
                        141,
                        20,
                        3,
                        "#5a6068"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            0,
            80,
            74,
            140,
            "#0e1218"
        )
        R(
            nil,
            c,
            0,
            74,
            78,
            10,
            "#5a6470"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    0,
                    75 + k * 3,
                    78,
                    1,
                    "#3a4450"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            76,
            84,
            3,
            136,
            "#5a6470"
        )
        R(
            nil,
            c,
            70,
            90,
            1,
            60,
            "#9aa0a6"
        )
        do
            local k = 0
            while k < 5 do
                ell(
                    nil,
                    c,
                    104,
                    214 - k * 8,
                    17,
                    6,
                    "#121212"
                )
                ell(
                    nil,
                    c,
                    104,
                    213 - k * 8,
                    15,
                    5,
                    "#262626"
                )
                ell(
                    nil,
                    c,
                    104,
                    213 - k * 8,
                    7,
                    2,
                    "#0a0a0a"
                )
                R(
                    nil,
                    c,
                    92,
                    211 - k * 8,
                    3,
                    1,
                    "#3a3a3a"
                )
                k = k + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({596, "#2f6a3a"}, 2),
                __arrL({620, "#a83a2a"}, 2),
                __arrL({644, "#2f5a8a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local cor = ____value[2]
            R(
                nil,
                c,
                x,
                176,
                20,
                44,
                cor
            )
            R(
                nil,
                c,
                x,
                176,
                20,
                3,
                "rgba(255,255,255,.25)"
            )
            R(
                nil,
                c,
                x,
                186,
                20,
                2,
                "rgba(0,0,0,.3)"
            )
            R(
                nil,
                c,
                x,
                206,
                20,
                2,
                "rgba(0,0,0,.3)"
            )
            R(
                nil,
                c,
                x + 2,
                178,
                3,
                40,
                "rgba(255,255,255,.12)"
            )
            R(
                nil,
                c,
                x + 6,
                194,
                8,
                6,
                "#e8e2d0"
            )
        end
        R(
            nil,
            c,
            676,
            194,
            34,
            26,
            "#c43c3a"
        )
        R(
            nil,
            c,
            676,
            194,
            34,
            4,
            "#e86a5a"
        )
        ell(
            nil,
            c,
            682,
            220,
            5,
            4,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            704,
            220,
            5,
            4,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            684,
            184,
            14,
            10,
            "#7a8086"
        )
        ell(
            nil,
            c,
            691,
            186,
            4,
            4,
            "#c8ccd0"
        )
        do
            local k = 0
            while k < 10 do
                R(
                    nil,
                    c,
                    710 + k * 3,
                    214 - math.sin(k * 0.7) * 6,
                    3,
                    2,
                    "#1c1c1c"
                )
                k = k + 1
            end
        end
        for ____, x in __iterar((__arrL({1000, 1016}, 2))) do
            R(
                nil,
                c,
                x,
                200,
                12,
                20,
                "#c83a2a"
            )
            R(
                nil,
                c,
                x + 3,
                196,
                6,
                4,
                "#8a2a1a"
            )
            R(
                nil,
                c,
                x,
                206,
                12,
                2,
                "#e8c24a"
            )
        end
        R(
            nil,
            c,
            196,
            198,
            10,
            22,
            "#e8c24a"
        )
        R(
            nil,
            c,
            410,
            198,
            10,
            22,
            "#e8c24a"
        )
        for ____, x in __iterar((__arrL({196, 410}, 2))) do
            do
                local y = 200
                while y < 220 do
                    R(
                        nil,
                        c,
                        x,
                        y,
                        10,
                        2,
                        "#1c1c1c"
                    )
                    y = y + 6
                end
            end
        end
        R(
            nil,
            c,
            190,
            194,
            236,
            5,
            "#7a8086"
        )
        R(
            nil,
            c,
            190,
            194,
            236,
            1,
            "#b8bcc0"
        )
        R(
            nil,
            c,
            220,
            156,
            172,
            32,
            "#24467a"
        )
        R(
            nil,
            c,
            220,
            156,
            172,
            4,
            "#5a86c8"
        )
        R(
            nil,
            c,
            250,
            134,
            104,
            24,
            "#2e5a98"
        )
        R(
            nil,
            c,
            256,
            138,
            42,
            18,
            "#9ac8e0"
        )
        R(
            nil,
            c,
            304,
            138,
            44,
            18,
            "#7ab0cc"
        )
        R(
            nil,
            c,
            258,
            139,
            10,
            2,
            "#e8f6fc"
        )
        R(
            nil,
            c,
            220,
            172,
            172,
            2,
            "#1a3458"
        )
        R(
            nil,
            c,
            352,
            140,
            40,
            4,
            "#2e5a98"
        )
        c:save()
        c:translate(354, 156)
        c:rotate(-0.6)
        R(
            nil,
            c,
            0,
            -2,
            40,
            4,
            "#2e5a98"
        )
        c:restore()
        R(
            nil,
            c,
            356,
            148,
            32,
            10,
            "#3a3e44"
        )
        R(
            nil,
            c,
            360,
            150,
            8,
            6,
            "#6a7078"
        )
        R(
            nil,
            c,
            372,
            150,
            10,
            4,
            "#c43c3a"
        )
        for ____, x in __iterar((__arrL({250, 362}, 2))) do
            ell(
                nil,
                c,
                x,
                190,
                13,
                11,
                "#141414"
            )
            ell(
                nil,
                c,
                x,
                190,
                6,
                5,
                "#9aa0a6"
            )
            ell(
                nil,
                c,
                x,
                190,
                2,
                2,
                "#3a3a3a"
            )
        end
        R(
            nil,
            c,
            386,
            166,
            6,
            6,
            "#ffe8a0"
        )
        R(
            nil,
            c,
            220,
            166,
            4,
            6,
            "#c83a2a"
        )
        R(
            nil,
            c,
            270,
            212,
            52,
            5,
            "#3a3a3a"
        )
        ell(
            nil,
            c,
            274,
            218,
            2,
            2,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            318,
            218,
            2,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            318,
            204,
            22,
            8,
            "#2f5d8c"
        )
        R(
            nil,
            c,
            338,
            204,
            8,
            6,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            318,
            210,
            22,
            3,
            "#24486a"
        )
        R(
            nil,
            c,
            466,
            184,
            118,
            7,
            "#7a5232"
        )
        R(
            nil,
            c,
            466,
            184,
            118,
            2,
            "#9a7248"
        )
        R(
            nil,
            c,
            472,
            191,
            6,
            29,
            "#5a3a22"
        )
        R(
            nil,
            c,
            572,
            191,
            6,
            29,
            "#5a3a22"
        )
        R(
            nil,
            c,
            470,
            206,
            110,
            3,
            "#5a3a22"
        )
        R(
            nil,
            c,
            480,
            166,
            40,
            18,
            "#c43c3a"
        )
        R(
            nil,
            c,
            480,
            166,
            40,
            4,
            "#e86a5a"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    482,
                    172 + k * 4,
                    36,
                    1,
                    "#8a2a1a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            494,
            162,
            12,
            4,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            536,
            172,
            18,
            12,
            "#4a5058"
        )
        R(
            nil,
            c,
            540,
            166,
            10,
            6,
            "#6a7078"
        )
        R(
            nil,
            c,
            534,
            170,
            4,
            4,
            "#3a3e44"
        )
        R(
            nil,
            c,
            560,
            174,
            8,
            10,
            "#d8a83a"
        )
        R(
            nil,
            c,
            562,
            170,
            3,
            4,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            572,
            180,
            10,
            4,
            "#c8b8a0"
        )
        R(
            nil,
            c,
            860,
            86,
            74,
            50,
            "#f2e2b8"
        )
        R(
            nil,
            c,
            862,
            88,
            70,
            12,
            "#c43c3a"
        )
        R(
            nil,
            c,
            868,
            106,
            58,
            22,
            "#3a6aa8"
        )
        ell(
            nil,
            c,
            897,
            117,
            10,
            6,
            "#7ac8c8"
        )
        R(
            nil,
            c,
            950,
            96,
            34,
            40,
            "#f6f6f0"
        )
        R(
            nil,
            c,
            950,
            96,
            34,
            8,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 20 do
                R(
                    nil,
                    c,
                    953 + __mod(k, 5) * 6,
                    108 + math.floor(k / 5) * 6,
                    4,
                    4,
                    if k == 12 then "#c43c3a" else "#d8d8d0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            970,
            160,
            44,
            2,
            "#5a3a22"
        )
        R(
            nil,
            c,
            974,
            150,
            26,
            10,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            976,
            152,
            8,
            6,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            990,
            152,
            8,
            2,
            "#ffd27a"
        )
        R(
            nil,
            c,
            998,
            144,
            1,
            8,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            1040,
            182,
            80,
            22,
            "#7a3a2a"
        )
        R(
            nil,
            c,
            1040,
            176,
            80,
            8,
            "#9a4a32"
        )
        R(
            nil,
            c,
            1036,
            178,
            8,
            26,
            "#6a3222"
        )
        R(
            nil,
            c,
            1116,
            178,
            8,
            26,
            "#6a3222"
        )
        R(
            nil,
            c,
            1060,
            186,
            14,
            6,
            "#a85a3a"
        )
        R(
            nil,
            c,
            1134,
            160,
            28,
            60,
            "#e8e8e0"
        )
        R(
            nil,
            c,
            1134,
            160,
            28,
            2,
            "#ffffff"
        )
        R(
            nil,
            c,
            1136,
            178,
            24,
            1,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            1156,
            166,
            2,
            8,
            "#7a8086"
        )
        R(
            nil,
            c,
            1140,
            148,
            10,
            12,
            "#5a3a22"
        )
        R(
            nil,
            c,
            1142,
            144,
            6,
            4,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            0,
            220,
            W,
            50,
            "#5e636a"
        )
        R(
            nil,
            c,
            0,
            220,
            W,
            2,
            "#8a9096"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    222,
                    1,
                    48,
                    "#52575e"
                )
                x = x + 64
            end
        end
        do
            local i = 0
            while i < 26 do
                local x = hash(nil, i) * W
                local y = 230 + hash(nil, i + 3) * 30
                local r = 8 + hash(nil, i + 5) * 16
                ell(
                    nil,
                    c,
                    x,
                    y,
                    r,
                    3,
                    "rgba(12,12,22,.45)"
                )
                ell(
                    nil,
                    c,
                    x - 2,
                    y - 1,
                    r * 0.4,
                    1,
                    "rgba(120,90,160,.25)"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            620,
            236,
            30,
            6,
            "#3a3e44"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    622 + k * 5,
                    237,
                    2,
                    4,
                    "#1c1c1c"
                )
                k = k + 1
            end
        end
        dith(
            nil,
            c,
            0,
            222,
            W,
            6,
            "rgba(255,255,255,.05)",
            3
        )
        local ____opt_17 = window.LugaresFundos
        if ____opt_17 ~= nil then
            ____opt_17 = ____opt_17.oficinaChao
        end
        if ____opt_17 ~= nil then
            ____opt_17(____opt_17, c, W)
        end
        return cv
    end
    local function oficina(self, c, s, t, camL)
        if not __t(oficinaMid) then
            oficinaMid = buildOficina(nil)
        end
        local n = noiteDe(nil, s)
        local ceuCor = if n > 0.5 then __arrL({"#0e1430", "#1c2650"}, 2) else __arrL({"#8ac8f0", "#c8e8f8"}, 2)
        for ____, x in __iterar((OF.JAN)) do
            local sx = x - camL
            if __t(sx < -70 or sx > 490) then
                continue
            end
            local g = c:createLinearGradient(0, 40, 0, 70)
            g:addColorStop(
                0,
                __get(ceuCor, 0)
            )
            g:addColorStop(
                1,
                __get(ceuCor, 1)
            )
            c.fillStyle = g
            c:fillRect(sx, 40, 60, 30)
        end
        do
            local sx = __TS__Number(-camL)
            if sx > -80 then
                local g = c:createLinearGradient(0, 80, 0, 220)
                g:addColorStop(
                    0,
                    __get(ceuCor, 0)
                )
                g:addColorStop(1, if n > 0.5 then "#2a3a3a" else "#9ac87a")
                c.fillStyle = g
                c:fillRect(sx, 80, 74, 140)
            end
        end
        c:drawImage(
            oficinaMid,
            camL,
            0,
            482,
            270,
            0,
            0,
            482,
            270
        )
        for ____, x in __iterar((OF.JAN)) do
            local sx = x - camL
            if __t(sx < -70 or sx > 490) then
                continue
            end
            if n > 0.5 then
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            sx + hash(nil, k + x) * 58,
                            42 + hash(nil, k + x + 1) * 12,
                            1,
                            1,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
            end
            if n < 0.5 then
                cone(
                    nil,
                    c,
                    sx + 30,
                    70,
                    30,
                    60,
                    150,
                    "rgba(255,240,200,1)",
                    0.12 * (1 - n * 2)
                )
            end
        end
        do
            local sx = __TS__Number(-camL)
            if sx > -80 then
                do
                    local k = 0
                    while k < 4 do
                        ell(
                            nil,
                            c,
                            sx + 12 + k * 18,
                            150,
                            12,
                            9,
                            if n > 0.5 then "#1a2a22" else "#5a9a4a"
                        )
                        k = k + 1
                    end
                end
            end
        end
        for ____, x in __iterar((OF.LAMP)) do
            local sx = x - camL
            if __t(sx < -80 or sx > 560) then
                continue
            end
            local pisca = if __t(x == 790 and math.sin(t * 13) > 0.85) then 0.2 else 1
            R(
                nil,
                c,
                sx,
                34,
                1,
                22,
                "#1c1c1c"
            )
            R(
                nil,
                c,
                sx - 10,
                56,
                21,
                5,
                "#3a4a3a"
            )
            R(
                nil,
                c,
                sx - 8,
                61,
                17,
                2,
                "#fff6d0"
            )
            cone(
                nil,
                c,
                sx,
                62,
                8,
                44,
                150,
                "rgba(255,240,190,1)",
                0.16 * pisca
            )
            glow(
                nil,
                c,
                sx,
                62,
                22,
                "#fff2c0",
                0.5 * pisca
            )
            do
                local k = 0
                while k < 7 do
                    local u = __mod(
                        t * 0.05 + hash(nil, k + x),
                        1
                    )
                    local px = sx - 20 + hash(nil, k * 3 + x) * 40 + math.sin(t + k) * 3
                    local py = 70 + u * 140
                    R(
                        nil,
                        c,
                        px + (py - 70) * 0.15 * (hash(nil, k) - 0.5),
                        py,
                        1,
                        1,
                        "rgba(255,248,220,.6)"
                    )
                    k = k + 1
                end
            end
        end
        local sx = 372 - camL
        if __t(sx > -40 and sx < 520) then
            local on = __mod(
                math.floor(t * 9),
                6
            ) ~= 0
            if __t(on) then
                glow(
                    nil,
                    c,
                    sx,
                    152,
                    30,
                    "#8ad0ff",
                    0.55
                )
                R(
                    nil,
                    c,
                    sx - 1,
                    151,
                    3,
                    3,
                    "#ffffff"
                )
            end
            do
                local k = 0
                while k < 10 do
                    local u = __mod(
                        t * 1.4 + hash(nil, k),
                        1
                    )
                    local vx = (hash(nil, k + 4) - 0.5) * 60
                    local x = sx + vx * u
                    local y = 152 + u * u * 70 - u * 20
                    if y > 218 then
                        continue
                    end
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        if __t(__mod(k, 3)) then "#ffd23a" else "#ffffff"
                    )
                    glow(
                        nil,
                        c,
                        x,
                        y,
                        3,
                        "#ffb040",
                        0.4 * (1 - u)
                    )
                    k = k + 1
                end
            end
        end
        local gx = 1000 - camL
        if __t(gx > -30 and gx < 510) then
            local y = 142
            ell(
                nil,
                c,
                gx,
                y,
                9,
                5,
                "#2a2420"
            )
            ell(
                nil,
                c,
                gx + 8,
                y - 5,
                5,
                4,
                "#2a2420"
            )
            R(
                nil,
                c,
                gx + 5,
                y - 10,
                2,
                3,
                "#2a2420"
            )
            R(
                nil,
                c,
                gx + 10,
                y - 10,
                2,
                3,
                "#2a2420"
            )
            if math.sin(t * 0.7) < 0.93 then
                R(
                    nil,
                    c,
                    gx + 7,
                    y - 6,
                    1,
                    1,
                    "#e8d24a"
                )
                R(
                    nil,
                    c,
                    gx + 10,
                    y - 6,
                    1,
                    1,
                    "#e8d24a"
                )
            end
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        gx - 9 - k * 2,
                        y + 1 + math.sin(t * 2.5 - k * 0.5) * k * 0.8,
                        2,
                        2,
                        "#2a2420"
                    )
                    k = k + 1
                end
            end
        end
        local rx = 990 - camL
        if __t(rx > -20 and rx < 500) then
            do
                local k = 0
                while k < 3 do
                    local u = __mod(t * 0.3 + k / 3, 1)
                    c.globalAlpha = 1 - u
                    R(
                        nil,
                        c,
                        rx + u * 14 + math.sin(t * 3 + k) * 2,
                        146 - u * 26,
                        2,
                        2,
                        "#ffd27a"
                    )
                    R(
                        nil,
                        c,
                        rx + 2 + u * 14 + math.sin(t * 3 + k) * 2,
                        140 - u * 26,
                        1,
                        6,
                        "#ffd27a"
                    )
                    c.globalAlpha = 1
                    k = k + 1
                end
            end
        end
        local fx = 1166 - camL
        if __t(fx > -30 and fx < 510) then
            R(
                nil,
                c,
                fx,
                184,
                2,
                36,
                "#4a5058"
            )
            ell(
                nil,
                c,
                fx + 1,
                180,
                9,
                9,
                "rgba(120,130,140,.35)"
            )
            do
                local k = 0
                while k < 3 do
                    local a = t * 11 + k * 2.09
                    R(
                        nil,
                        c,
                        fx + 1 + math.cos(a) * 6 - 1,
                        180 + math.sin(a) * 6 - 1,
                        3,
                        3,
                        "#9aa0a6"
                    )
                    k = k + 1
                end
            end
        end
        for ____, x in __iterar((OF.LAMP)) do
            local sx2 = x - camL
            if __t(sx2 < -60 or sx2 > 540) then
                continue
            end
            c.globalAlpha = 0.12
            ell(
                nil,
                c,
                sx2,
                236,
                30,
                4,
                "#fff2c0"
            )
            c.globalAlpha = 1
        end
        local ____opt_21 = window.LugaresFundos
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.oficinaAnim
        end
        if ____opt_21 ~= nil then
            ____opt_21(
                ____opt_21,
                c,
                t,
                camL,
                n
            )
        end
    end
    local function oficinaText(self, c, cam)
        c:save()
        c:translate(
            -math.floor(cam + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "9px Pixel, monospace"
        c.fillStyle = "#ffffff"
        c:fillText("GASOLINA? NÃO! GÁS!", 1794, 190)
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#f2e2b8"
        c:fillText("OFICINA DO LUCAS · DESDE 1998", 1794, 290)
        c.fillStyle = "#c43c3a"
        c:fillText("NOVEMBRO", 1934, 200)
        c.fillStyle = "#ffe9a8"
        c:fillText("CAFÉ DO MECÂNICO", 2160, 340)
        c.fillStyle = "#e8e2d0"
        c.font = "7px Pixel, monospace"
        for ____, x in __iterar((__arrL({1212, 1260, 1308}, 3))) do
            c:fillText("ÓLEO", x, 395)
        end
        c:restore()
    end
    local lancheMid = nil
    local LN = __ord(
        {
            W = 1040,
            PEND = __arrL({230, 330, 870, 950}, 4),
            PORTA = 150
        },
        "W,PEND,PORTA"
    )
    local function buildLanche(self)
        local W = LN.W
        local cv, c = table.unpack(
            mk(nil, W, 270),
            1,
            2
        )
        local casas = __arrL(
            {
                __arrL({"#f2c4c4", "#c8544a"}, 2),
                __arrL({"#d4ecc8", "#7a9a5a"}, 2),
                __arrL({"#f2e2a8", "#c8844a"}, 2),
                __arrL({"#c8dcf0", "#5a7aa8"}, 2)
            },
            4
        )
        do
            local k = 0
            while k < 4 do
                local x = k * 38 - 4
                local h = 70 + __mod(k, 2) * 14
                local y = 150 - h
                R(
                    nil,
                    c,
                    x,
                    y,
                    36,
                    h + 40,
                    __get(
                        __get(casas, k),
                        0
                    )
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    36,
                    4,
                    __get(
                        __get(casas, k),
                        1
                    )
                )
                do
                    local j = 0
                    while j < 2 do
                        R(
                            nil,
                            c,
                            x + 6 + j * 14,
                            y + 14,
                            9,
                            14,
                            "#3a4a5a"
                        )
                        R(
                            nil,
                            c,
                            x + 6 + j * 14,
                            y + 14,
                            9,
                            3,
                            "#5a6a7a"
                        )
                        R(
                            nil,
                            c,
                            x + 5 + j * 14,
                            y + 28,
                            11,
                            2,
                            __get(
                                __get(casas, k),
                                1
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        local ____opt_25 = window.LugaresFundos
        if ____opt_25 ~= nil then
            ____opt_25 = ____opt_25.lancheRua
        end
        if ____opt_25 ~= nil then
            ____opt_25(____opt_25, c, LN.PORTA)
        end
        R(
            nil,
            c,
            0,
            190,
            LN.PORTA,
            30,
            "#c8c0a8"
        )
        do
            local x = 0
            while x < LN.PORTA do
                do
                    local y = 190
                    while y < 220 do
                        R(
                            nil,
                            c,
                            x + __mod(y / 6, 2) * 4,
                            y,
                            4,
                            3,
                            "#a89f88"
                        )
                        y = y + 6
                    end
                end
                x = x + 8
            end
        end
        R(
            nil,
            c,
            0,
            186,
            LN.PORTA,
            4,
            "#8a8478"
        )
        R(
            nil,
            c,
            LN.PORTA - 8,
            26,
            16,
            194,
            "#8a5a36"
        )
        R(
            nil,
            c,
            LN.PORTA - 4,
            30,
            2,
            190,
            "#5a3820"
        )
        do
            local k = 0
            while k < 12 do
                c.fillStyle = if __t(__mod(k, 2)) then "#e8e2d0" else "#c83a2a"
                c:beginPath()
                c:moveTo(70 + k * 7, 70)
                c:lineTo(77 + k * 7, 70)
                c:lineTo(80 + k * 7, 86)
                c:lineTo(73 + k * 7, 86)
                c:closePath()
                __call(c, "fill")
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 12 do
                ell(
                    nil,
                    c,
                    76 + k * 7,
                    86,
                    3,
                    2,
                    if __t(__mod(k, 2)) then "#e8e2d0" else "#c83a2a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            LN.PORTA,
            26,
            W - LN.PORTA,
            104,
            "#f0d890"
        )
        do
            local i = 0
            while i < 900 do
                R(
                    nil,
                    c,
                    LN.PORTA + hash(nil, i) * (W - LN.PORTA),
                    26 + hash(nil, i + 2) * 100,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "rgba(255,255,255,.18)" else "rgba(140,100,40,.12)"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            LN.PORTA,
            130,
            W - LN.PORTA,
            90,
            "#f4f4ee"
        )
        do
            local y = 130
            while y < 220 do
                R(
                    nil,
                    c,
                    LN.PORTA,
                    y,
                    W - LN.PORTA,
                    1,
                    "#d8d8d0"
                )
                y = y + 9
            end
        end
        do
            local x = LN.PORTA
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    130,
                    1,
                    90,
                    "#e2e2da"
                )
                x = x + 9
            end
        end
        R(
            nil,
            c,
            LN.PORTA,
            128,
            W - LN.PORTA,
            6,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            LN.PORTA,
            128,
            W - LN.PORTA,
            1,
            "#5a8ad8"
        )
        R(
            nil,
            c,
            LN.PORTA,
            0,
            W - LN.PORTA,
            14,
            "#3a2416"
        )
        do
            local x = LN.PORTA
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    0,
                    4,
                    14,
                    "#4a3020"
                )
                x = x + 8
            end
        end
        R(
            nil,
            c,
            LN.PORTA,
            14,
            W - LN.PORTA,
            14,
            "#6a4228"
        )
        do
            local x = LN.PORTA
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    14,
                    10,
                    18,
                    "#5a3820"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    14,
                    2,
                    18,
                    "#8a5a36"
                )
                x = x + 60
            end
        end
        local ____opt_29 = window.LugaresFundos
        if ____opt_29 ~= nil then
            ____opt_29 = ____opt_29.lancheParede
        end
        if ____opt_29 ~= nil then
            ____opt_29(____opt_29, c, W, LN.PORTA)
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({180, "#5a8a4a"}, 2),
                __arrL({216, "#3a7aa8"}, 2),
                __arrL({252, "#c8844a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local cor = ____value[2]
            R(
                nil,
                c,
                x,
                48,
                28,
                22,
                "#5a3820"
            )
            R(
                nil,
                c,
                x + 2,
                50,
                24,
                18,
                cor
            )
            R(
                nil,
                c,
                x + 2,
                62,
                24,
                6,
                "rgba(0,0,0,.25)"
            )
        end
        R(
            nil,
            c,
            180,
            84,
            100,
            3,
            "#6a4228"
        )
        do
            local k = 0
            while k < 9 do
                R(
                    nil,
                    c,
                    184 + k * 11,
                    72,
                    8,
                    12,
                    __get(
                        __arrL({"#e8433a", "#f2c94c", "#3c8a5a", "#3a6aa8"}, 4),
                        __mod(k, 4)
                    )
                )
                R(
                    nil,
                    c,
                    185 + k * 11,
                    74,
                    2,
                    3,
                    "#ffffff88"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            300,
            40,
            204,
            76,
            "#5a3820"
        )
        R(
            nil,
            c,
            303,
            43,
            198,
            70,
            "#24302a"
        )
        do
            local i = 0
            while i < 160 do
                R(
                    nil,
                    c,
                    304 + hash(nil, i + 40) * 196,
                    44 + hash(nil, i + 41) * 68,
                    2,
                    1,
                    "rgba(255,255,255,.06)"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            426,
            158,
            308,
            62,
            "#a83a2a"
        )
        R(
            nil,
            c,
            426,
            158,
            308,
            5,
            "#e8e8e0"
        )
        R(
            nil,
            c,
            426,
            163,
            308,
            2,
            "#7a2a1a"
        )
        do
            local x = 436
            while x < 734 do
                R(
                    nil,
                    c,
                    x,
                    168,
                    24,
                    46,
                    "#c84a3a"
                )
                x = x + 30
            end
        end
        R(
            nil,
            c,
            440,
            134,
            180,
            24,
            "#24303a"
        )
        R(
            nil,
            c,
            442,
            136,
            176,
            20,
            "#bfe0e8"
        )
        R(
            nil,
            c,
            442,
            136,
            176,
            3,
            "#ffffff"
        )
        R(
            nil,
            c,
            442,
            150,
            176,
            2,
            "#9ab8c0"
        )
        do
            local k = 0
            while k < 16 do
                local x = 448 + k * 10.5
                local cor = __get(
                    __arrL({"#d88a3a", "#e8b860", "#c8682a", "#b8502a"}, 4),
                    __mod(k, 4)
                )
                ell(
                    nil,
                    c,
                    x + 4,
                    148,
                    5,
                    3,
                    cor
                )
                R(
                    nil,
                    c,
                    x + 2,
                    145,
                    3,
                    1,
                    "#fff2c0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            630,
            128,
            34,
            30,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            632,
            132,
            30,
            14,
            "#d8a83a"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    634 + k * 5,
                    133,
                    2,
                    2,
                    "#ffe08a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            630,
            128,
            34,
            3,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            672,
            132,
            18,
            26,
            "#3a3e44"
        )
        R(
            nil,
            c,
            674,
            126,
            14,
            8,
            "#5a3a22"
        )
        ell(
            nil,
            c,
            681,
            128,
            6,
            2,
            "#8a5a2a"
        )
        R(
            nil,
            c,
            700,
            136,
            24,
            22,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            704,
            140,
            16,
            10,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            706,
            150,
            4,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            744,
            100,
            48,
            120,
            "#d8dce0"
        )
        R(
            nil,
            c,
            746,
            104,
            44,
            70,
            "#0e2a3a"
        )
        do
            local r2 = 0
            while r2 < 4 do
                R(
                    nil,
                    c,
                    748,
                    120 + r2 * 16,
                    40,
                    1,
                    "#5a7a8a"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            750 + k * 6,
                            108 + r2 * 16,
                            4,
                            11,
                            __get(
                                __arrL({"#c43c3a", "#f2c94c", "#3c8a5a", "#e8e8e0"}, 4),
                                __mod(k + r2, 4)
                            )
                        )
                        k = k + 1
                    end
                end
                r2 = r2 + 1
            end
        end
        R(
            nil,
            c,
            786,
            130,
            2,
            20,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            744,
            100,
            48,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            818,
            52,
            86,
            52,
            "#121212"
        )
        R(
            nil,
            c,
            822,
            56,
            78,
            44,
            "#2a6a2a"
        )
        R(
            nil,
            c,
            860,
            104,
            4,
            12,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            852,
            114,
            20,
            3,
            "#2a2a2a"
        )
        for ____, x in __iterar((__arrL({176, 290, 846, 930}, 4))) do
            R(
                nil,
                c,
                x,
                184,
                56,
                6,
                "#d8d0c0"
            )
            do
                local k = 0
                while k < 7 do
                    R(
                        nil,
                        c,
                        x + k * 8,
                        184,
                        4,
                        6,
                        if __t(__mod(k, 2)) then "#c43c3a" else "#e8e2d0"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x + 4,
                190,
                48,
                2,
                "#b8b0a0"
            )
            R(
                nil,
                c,
                x + 26,
                192,
                4,
                28,
                "#7a7e84"
            )
            for ____, sd in __iterar((__arrL({-1, 1}, 2))) do
                local cx = x + 28 + sd * 38
                R(
                    nil,
                    c,
                    cx - 7,
                    194,
                    14,
                    4,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    cx - 7,
                    180,
                    3,
                    18,
                    "#a82a2a"
                )
                R(
                    nil,
                    c,
                    cx - 6,
                    198,
                    2,
                    22,
                    "#7a1a1a"
                )
                R(
                    nil,
                    c,
                    cx + 4,
                    198,
                    2,
                    22,
                    "#7a1a1a"
                )
            end
        end
        for ____, x in __iterar((__arrL({400, 806}, 2))) do
            R(
                nil,
                c,
                x,
                198,
                16,
                22,
                "#b8643a"
            )
            R(
                nil,
                c,
                x,
                198,
                16,
                3,
                "#d8844a"
            )
            do
                local k = 0
                while k < 7 do
                    ell(
                        nil,
                        c,
                        x + 8 + math.cos(k) * 8,
                        190 - math.abs(math.sin(k * 1.7)) * 14,
                        5,
                        3,
                        if __t(__mod(k, 2)) then "#3a8a4a" else "#4aa85a"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            LN.PORTA,
            220,
            W - LN.PORTA,
            50,
            "#d8c8a8"
        )
        do
            local x = LN.PORTA
            while x < W do
                do
                    local y = 220
                    while y < 270 do
                        local on = __mod(x / 12 + y / 12, 2)
                        R(
                            nil,
                            c,
                            x,
                            y,
                            12,
                            12,
                            if __t(on) then "#c8b494" else "#e2d4b4"
                        )
                        R(
                            nil,
                            c,
                            x + 5,
                            y + 5,
                            2,
                            2,
                            if __t(on) then "#a84a3a" else "#3a6aa8"
                        )
                        y = y + 12
                    end
                end
                x = x + 12
            end
        end
        R(
            nil,
            c,
            0,
            220,
            LN.PORTA,
            50,
            "#7a7468"
        )
        R(
            nil,
            c,
            LN.PORTA,
            220,
            W - LN.PORTA,
            2,
            "#a89878"
        )
        local ____opt_33 = window.LugaresFundos
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.lancheChao
        end
        if ____opt_33 ~= nil then
            ____opt_33(____opt_33, c, W, LN.PORTA)
        end
        return cv
    end
    local function lanche(self, c, s, t, camL)
        if not __t(lancheMid) then
            lancheMid = buildLanche(nil)
        end
        local n = noiteDe(nil, s)
        do
            local sx = __TS__Number(-camL)
            if sx > -160 then
                local g = c:createLinearGradient(0, 0, 0, 190)
                g:addColorStop(0, if n > 0.5 then "#0c1230" else "#7ab8e8")
                g:addColorStop(1, if n > 0.5 then "#2a2448" else "#d8ecf8")
                c.fillStyle = g
                c:fillRect(sx, 0, LN.PORTA, 190)
                if n > 0.4 then
                    do
                        local k = 0
                        while k < 14 do
                            R(
                                nil,
                                c,
                                sx + hash(nil, k) * 140,
                                hash(nil, k + 2) * 60,
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
        c:drawImage(
            lancheMid,
            camL,
            0,
            482,
            270,
            0,
            0,
            482,
            270
        )
        do
            local sx = __TS__Number(-camL)
            if __t(sx > -160 and n > 0.3) then
                do
                    local k = 0
                    while k < 4 do
                        do
                            local j = 0
                            while j < 2 do
                                if hash(nil, k * 3 + j) > 0.35 then
                                    local x = sx + k * 38 + 2 + j * 14
                                    local y = 150 - (70 + __mod(k, 2) * 14) + 14
                                    R(
                                        nil,
                                        c,
                                        x,
                                        y,
                                        9,
                                        14,
                                        "#ffd27a"
                                    )
                                    glow(
                                        nil,
                                        c,
                                        x + 4,
                                        y + 7,
                                        12,
                                        "#ffb050",
                                        0.35 * n
                                    )
                                end
                                j = j + 1
                            end
                        end
                        k = k + 1
                    end
                end
            end
            local px = sx + 40
            if px > -30 then
                R(
                    nil,
                    c,
                    px,
                    100,
                    3,
                    90,
                    "#3a3e44"
                )
                R(
                    nil,
                    c,
                    px - 8,
                    96,
                    19,
                    5,
                    "#4a4e54"
                )
                R(
                    nil,
                    c,
                    px - 5,
                    101,
                    13,
                    2,
                    "#fff2c0"
                )
                if n > 0.2 then
                    cone(
                        nil,
                        c,
                        px + 1,
                        103,
                        6,
                        40,
                        90,
                        "rgba(255,230,170,1)",
                        0.18 * n
                    )
                    glow(
                        nil,
                        c,
                        px + 1,
                        102,
                        20,
                        "#ffe0a0",
                        0.6 * n
                    )
                end
            end
        end
        do
            local x = 168 - camL + 60
            local on = math.sin(t * 7.3) > -0.9
            if __t(x > -120 and x < 600) then
                R(
                    nil,
                    c,
                    x - 50,
                    94,
                    104,
                    20,
                    "#1a1220"
                )
                c:save()
                c.strokeStyle = if __t(on) then "#ff5aa8" else "#5a2a44"
                c.lineWidth = 1
                c:strokeRect(x - 49.5, 94.5, 103, 19)
                c:restore()
                if __t(on) then
                    glow(
                        nil,
                        c,
                        x,
                        104,
                        70,
                        "#ff5aa8",
                        0.35
                    )
                end
            end
        end
        for ____, x in __iterar((LN.PEND)) do
            local sx = x - camL
            if __t(sx < -60 or sx > 540) then
                continue
            end
            R(
                nil,
                c,
                sx,
                28,
                1,
                30,
                "#2a2a2a"
            )
            c.fillStyle = "#2c5a3a"
            c:beginPath()
            c:moveTo(sx - 8, 66)
            c:lineTo(sx + 9, 66)
            c:lineTo(sx + 4, 58)
            c:lineTo(sx - 3, 58)
            c:closePath()
            __call(c, "fill")
            R(
                nil,
                c,
                sx - 3,
                66,
                7,
                2,
                "#fff6d0"
            )
            cone(
                nil,
                c,
                sx,
                68,
                8,
                30,
                120,
                "rgba(255,220,150,1)",
                0.14
            )
            glow(
                nil,
                c,
                sx,
                68,
                26,
                "#ffd890",
                0.55
            )
        end
        do
            local sx = 530 - camL
            if __t(sx > -120 and sx < 600) then
                glow(
                    nil,
                    c,
                    sx,
                    140,
                    70,
                    "#ff9a40",
                    0.35 + math.sin(t * 2) * 0.04
                )
            end
        end
        do
            local sx = 768 - camL
            if __t(sx > -60 and sx < 540) then
                glow(
                    nil,
                    c,
                    sx,
                    140,
                    50,
                    "#7ad8ff",
                    0.28
                )
            end
        end
        do
            local sx = 861 - camL
            if __t(sx > -60 and sx < 540) then
                local k = 0.5 + 0.5 * math.sin(t * 5.3) * math.sin(t * 1.7)
                R(
                    nil,
                    c,
                    sx - 39,
                    56,
                    78,
                    44,
                    ((((("rgba(" .. tostring(math.floor(40 + k * 40 + 0.5))) .. ",") .. tostring(math.floor(110 + k * 30 + 0.5))) .. ",") .. tostring(math.floor(40 + k * 20 + 0.5))) .. ",1)"
                )
                R(
                    nil,
                    c,
                    sx - 1,
                    56,
                    1,
                    44,
                    "#e8f8e8"
                )
                local bx = sx - 30 + (math.sin(t * 0.9) * 0.5 + 0.5) * 60
                R(
                    nil,
                    c,
                    bx,
                    76 + math.sin(t * 2.3) * 8,
                    2,
                    2,
                    "#ffffff"
                )
                glow(
                    nil,
                    c,
                    sx,
                    80,
                    60,
                    "#8af08a",
                    0.18 + k * 0.06
                )
            end
        end
        do
            local k = 0
            while k < 8 do
                local u = __mod(t * 0.35 + k / 8, 1)
                local x = 452 + k * 21 - camL + math.sin(t * 2 + k) * 3
                c.globalAlpha = (1 - u) * 0.5
                R(
                    nil,
                    c,
                    x,
                    132 - u * 34,
                    2,
                    2,
                    "#ffffff"
                )
                c.globalAlpha = 1
                k = k + 1
            end
        end
        do
            local fx = 646 - camL
            if __t(fx > -40 and fx < 520) then
                do
                    local k = 0
                    while k < 6 do
                        local u = __mod(t * 2 + k / 6, 1)
                        R(
                            nil,
                            c,
                            fx - 12 + hash(nil, k) * 26,
                            134 - u * 6,
                            1,
                            1,
                            "#fff2c0"
                        )
                        k = k + 1
                    end
                end
            end
            fumacaSobe(
                nil,
                c,
                646 - camL,
                124,
                t,
                5,
                30,
                "#e8e8f0"
            )
        end
        do
            local vx = 600 - camL
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
                ell(
                    nil,
                    c,
                    vx + 1,
                    40,
                    5,
                    2,
                    "#5a3820"
                )
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 7 + k * math.pi / 2
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
            local gx = 324 - camL
            if __t(gx > -30 and gx < 510) then
                local b = math.sin(t * 1.6) * 0.6
                ell(
                    nil,
                    c,
                    gx,
                    191 - b,
                    8,
                    4 + b * 0.4,
                    "#e8a85a"
                )
                ell(
                    nil,
                    c,
                    gx + 7,
                    190,
                    4,
                    3,
                    "#e8a85a"
                )
                R(
                    nil,
                    c,
                    gx + 5,
                    187,
                    1,
                    2,
                    "#e8a85a"
                )
                R(
                    nil,
                    c,
                    gx + 9,
                    187,
                    1,
                    2,
                    "#e8a85a"
                )
                R(
                    nil,
                    c,
                    gx - 8,
                    192,
                    6,
                    2,
                    "#d8984a"
                )
                if __mod(
                    math.floor(t * 0.7),
                    3
                ) == 0 then
                    c.globalAlpha = 0.7
                    R(
                        nil,
                        c,
                        gx + 12,
                        180 - __mod(t * 6, 8),
                        3,
                        1,
                        "#ffffff"
                    )
                    c.globalAlpha = 1
                end
            end
        end
        for ____, x in __iterar((LN.PEND)) do
            local sx = x - camL
            if __t(sx < -60 or sx > 540) then
                continue
            end
            c.globalAlpha = 0.14
            ell(
                nil,
                c,
                sx,
                232,
                26,
                4,
                "#fff2c0"
            )
            c.globalAlpha = 1
        end
        local ____opt_37 = window.LugaresFundos
        if ____opt_37 ~= nil then
            ____opt_37 = ____opt_37.lancheAnim
        end
        if ____opt_37 ~= nil then
            ____opt_37(
                ____opt_37,
                c,
                t,
                camL,
                n
            )
        end
    end
    local CLIENTES = __ord(
        {
            cliente_dona = __ord(
                {
                    name = "Cliente",
                    skin = "#d8a77f",
                    shade = "#ab7856",
                    build = "belly",
                    h = 0.92,
                    top = "#3a8a6a",
                    topKind = "cardigan",
                    inner = "#f2e6c8",
                    skirt = "#5a4a62",
                    hair = __ord({style = "curlyShort", color = "#d9d6d0"}, "style,color"),
                    glasses = "#7a5a3a",
                    bag = "#b8643a",
                    pose = "talk"
                },
                "name,skin,shade,build,h,top,topKind,inner,skirt,hair,glasses,bag,pose"
            ),
            cliente_rapaz = __ord(
                {
                    name = "Cliente",
                    skin = "#8a5a3c",
                    shade = "#5f3d2a",
                    build = "slim",
                    top = "#e8c24a",
                    topKind = "tee",
                    sleeve = "short",
                    pants = "#2a3442",
                    hat = __ord({kind = "capback", color = "#3a6aa8"}, "kind,color"),
                    hair = __ord({style = "short", color = "#1c1714"}, "style,color"),
                    item = "mug",
                    pose = "mug"
                },
                "name,skin,shade,build,top,topKind,sleeve,pants,hat,hair,item,pose"
            )
        },
        "cliente_dona,cliente_rapaz"
    )
    local function regClientes()
        local CP = window.CampanhaPersonagens
        local ____t_42 = __t
        local ____opt_result_41
        if CP ~= nil then
            ____opt_result_41 = CP.registrar
        end
        if not ____t_42(____opt_result_41) then
            return false
        end
        for ____, ____value in __iterar((__entries(CLIENTES))) do
            local id = ____value[1]
            local sp = ____value[2]
            CP:registrar(id, sp, "NPC (lanchonete)")
        end
        return true
    end
    if not __t(regClientes(nil)) then
        window:addEventListener("DOMContentLoaded", regClientes, {once = true})
    end
    local function lancheText(self, c, cam)
        c:save()
        c:translate(
            -math.floor(cam + 0.5),
            0
        )
        do
            pcall(function()
                local tt = window.performance:now() / 1000
                local ____opt_45 = window.Art
                if ____opt_45 ~= nil then
                    ____opt_45 = ____opt_45.drawCharacter
                end
                if ____opt_45 ~= nil then
                    ____opt_45(
                        ____opt_45,
                        c,
                        "cliente_dona",
                        470,
                        440,
                        {frame = tt, facing = 1, grounded = true}
                    )
                end
                local ____opt_49 = window.Art
                if ____opt_49 ~= nil then
                    ____opt_49 = ____opt_49.drawCharacter
                end
                if ____opt_49 ~= nil then
                    ____opt_49(
                        ____opt_49,
                        c,
                        "cliente_rapaz",
                        1780,
                        440,
                        {frame = tt + 2, facing = -1, grounded = true}
                    )
                end
            end)
        end
        c.textAlign = "left"
        c.textBaseline = "middle"
        c.font = "10px Pixel, monospace"
        local itens = __arrL(
            {
                __arrL({"COXINHA", "5"}, 2),
                __arrL({"PASTEL DE QUEIJO", "7"}, 2),
                __arrL({"ACARAJÉ", "10"}, 2),
                __arrL({"SUCO DE CACAU", "6"}, 2),
                __arrL({"CALDO DE CANA", "5"}, 2)
            },
            5
        )
        c.fillStyle = "#ffe9a8"
        c.font = "12px Pixel, monospace"
        c:fillText("CARDÁPIO", 622, 100)
        c.font = "10px Pixel, monospace"
        __call(
            itens,
            "forEach",
            function(____, ____bindingPattern0, i)
                local p
                local nm
                nm = ____bindingPattern0[1]
                p = ____bindingPattern0[2]
                c.fillStyle = "#f2f2ea"
                c:fillText(nm, 622, 126 + i * 18)
                c.fillStyle = "#f2c94c"
                c:fillText(
                    __add("R$ ", p),
                    940,
                    126 + i * 18
                )
            end
        )
        c.textAlign = "center"
        c.font = "13px Pixel, monospace"
        c.fillStyle = "#ff9ad0"
        c:fillText("ZITO LANCHES", 456, 208)
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#3a2a1a"
        c:fillText("ABERTO", 160, 160)
        c:restore()
    end
    local AC = __ord(
        {
            CASA = 520,
            FOGO = 1620,
            POSTES = __arrL({1190, 1390, 1590}, 3),
            CACH = 60
        },
        "CASA,FOGO,POSTES,CACH"
    )
    local function acude(self, c, s, t, camL)
        local n = noiteDe(nil, s)
        local ____t_54 = __t
        local ____opt_result_53
        if K ~= nil then
            ____opt_result_53 = K.sky
        end
        if ____t_54(____opt_result_53) then
            K:sky(
                c,
                s,
                t,
                camL,
                {}
            )
        else
            R(
                nil,
                c,
                0,
                0,
                482,
                150,
                "#9ad0f0"
            )
        end
        local function tinta(____, d, nt)
            return if n > 0.5 then nt else d
        end
        local F = window.LugaresFundos
        if __t(F) then
            F:camadaAcude(
                c,
                s,
                t,
                camL,
                n
            )
        else
            do
                local i = -1
                while i < 7 do
                    local x = i * 130 - __mod(camL * 0.12, 130)
                    ell(
                        nil,
                        c,
                        x + 65,
                        150,
                        96,
                        44,
                        tinta(nil, "#5a8a6a", "#1c2a3a")
                    )
                    i = i + 1
                end
            end
        end
        do
            local hx = AC.CASA * 0.12 * 0 + 300 - camL * 0.12
            if __t(hx > -80 and hx < 560) then
                local y = 104
                R(
                    nil,
                    c,
                    hx - 18,
                    y,
                    36,
                    22,
                    tinta(nil, "#e8d8b8", "#3a3448")
                )
                c.fillStyle = tinta(nil, "#a8543a", "#2a2238")
                c:beginPath()
                c:moveTo(hx - 22, y)
                c:lineTo(hx, y - 16)
                c:lineTo(hx + 22, y)
                c:closePath()
                __call(c, "fill")
                R(
                    nil,
                    c,
                    hx + 8,
                    y - 16,
                    5,
                    10,
                    tinta(nil, "#8a4a3a", "#3a2a2a")
                )
                for ____, wx in __iterar((__arrL({hx - 12, hx + 6}, 2))) do
                    R(
                        nil,
                        c,
                        wx,
                        y + 6,
                        6,
                        6,
                        if n > 0.3 then "#ffc860" else "#5a7a9a"
                    )
                    if n > 0.3 then
                        glow(
                            nil,
                            c,
                            wx + 3,
                            y + 9,
                            14,
                            "#ffb040",
                            0.5 * n
                        )
                    end
                end
                fumacaSobe(
                    nil,
                    c,
                    hx + 10,
                    y - 18,
                    t,
                    9,
                    46,
                    if n > 0.5 then "#5a5a78" else "#d8dce8"
                )
            end
        end
        if __t(F) then
            F:arvoresAcude(c, t, camL, n)
        else
            do
                local i = -1
                while i < 10 do
                    local x = i * 84 - __mod(camL * 0.3, 84)
                    ell(
                        nil,
                        c,
                        x + 42,
                        156,
                        56,
                        20,
                        tinta(nil, "#3a7a4a", "#14202a")
                    )
                    do
                        local k = 0
                        while k < 2 do
                            local tx = x + 20 + k * 38
                            R(
                                nil,
                                c,
                                tx,
                                128,
                                2,
                                16,
                                tinta(nil, "#4a3a2a", "#0c1218")
                            )
                            ell(
                                nil,
                                c,
                                tx + 1,
                                126,
                                8,
                                5,
                                tinta(nil, "#2a6a3a", "#0e1820")
                            )
                            k = k + 1
                        end
                    end
                    i = i + 1
                end
            end
        end
        if __t(F) then
            F:aguaAcude(c, t, camL, n)
        else
            local wg = c:createLinearGradient(0, 150, 0, 198)
            wg:addColorStop(
                0,
                tinta(nil, "#5a9ac8", "#16264a")
            )
            wg:addColorStop(
                1,
                tinta(nil, "#2a6a98", "#0c1630")
            )
            c.fillStyle = wg
            c:fillRect(0, 150, 482, 48)
        end
        do
            local ____s_moonT_55 = s.moonT
            if ____s_moonT_55 == nil then
                ____s_moonT_55 = 0.5
            end
            local ____s_sunT_56 = s.sunT
            if ____s_sunT_56 == nil then
                ____s_sunT_56 = 0.5
            end
            local lx = if n > 0.5 then 50 + ____s_moonT_55 * 380 - camL * 0.012 else 40 + ____s_sunT_56 * 400 - camL * 0.012
            do
                local y = 152
                while y < 198 do
                    local w = 3 + math.sin(t * 3 + y * 0.7) * 2 + (y - 150) * 0.12
                    c.globalAlpha = 0.55 - (y - 150) / 120
                    R(
                        nil,
                        c,
                        lx - w + math.sin(t * 2 + y) * 2,
                        y,
                        w * 2,
                        1,
                        if n > 0.5 then "#e8f0ff" else "#fff6c8"
                    )
                    y = y + 2
                end
            end
            c.globalAlpha = 1
        end
        if not __t(F) then
            do
                local k = 0
                while k < 44 do
                    local x = __mod(
                        __mod(k * 53 - camL * 0.7 + t * 5, 520) + 520,
                        520
                    ) - 20
                    local y = 154 + __mod(k * 7, 40)
                    R(
                        nil,
                        c,
                        x,
                        y,
                        5 + __mod(k, 3) * 4,
                        1,
                        tinta(nil, if __t(__mod(k, 2)) then "#8ac0e0" else "#6aa8d0", if __t(__mod(k, 2)) then "#2a3a6a" else "#22325a")
                    )
                    k = k + 1
                end
            end
        end
        do
            local x = AC.CACH - camL * 0.7
            if __t(x > -40 and x < 520) then
                R(
                    nil,
                    c,
                    x - 10,
                    118,
                    22,
                    34,
                    tinta(nil, "#5a6a5a", "#1a2228")
                )
                do
                    local k = 0
                    while k < 12 do
                        local u = __mod(t * 1.6 + k / 12, 1)
                        R(
                            nil,
                            c,
                            x - 6 + __mod(k, 4) * 3,
                            120 + u * 32,
                            2,
                            4,
                            tinta(nil, "#d8f0ff", "#6a8ab8")
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 6 do
                        ell(
                            nil,
                            c,
                            x + (k - 3) * 4,
                            152 + math.sin(t * 6 + k),
                            3,
                            1,
                            tinta(nil, "#ffffff", "#8aa8d8")
                        )
                        k = k + 1
                    end
                end
            end
        end
        for ____, wx in __iterar((__arrL({
            240,
            330,
            980,
            1900,
            2150
        }, 5))) do
            local x = wx * 0.5 - camL
            if __t(x < -20 or x > 500) then
                continue
            end
            ell(
                nil,
                c,
                x,
                186,
                9,
                3,
                tinta(nil, "#3a8a3a", "#1a3a2a")
            )
            R(
                nil,
                c,
                x + 2,
                186,
                4,
                1,
                tinta(nil, "#2a6a2a", "#12281e")
            )
            if __mod(wx, 3) == 0 then
                R(
                    nil,
                    c,
                    x - 1,
                    183,
                    3,
                    2,
                    "#f2a8c8"
                )
                R(
                    nil,
                    c,
                    x,
                    182,
                    1,
                    1,
                    "#ffffff"
                )
            end
        end
        for ____, wx in __iterar((__arrL({700, 1100}, 2))) do
            local x = wx - camL
            if __t(x < -30 or x > 510) then
                continue
            end
            local mast = if math.sin(t * 6 + wx) > 0 then 1 else 0
            ell(
                nil,
                c,
                x,
                196,
                15,
                8,
                "#7a4e30"
            )
            ell(
                nil,
                c,
                x - 2,
                193,
                12,
                4,
                "#8a5a36"
            )
            ell(
                nil,
                c,
                x + 13,
                191 + mast * 0.5,
                7,
                5,
                "#6a4228"
            )
            R(
                nil,
                c,
                x + 16,
                188,
                2,
                2,
                "#1c1c1c"
            )
            R(
                nil,
                c,
                x + 12,
                186,
                3,
                2,
                "#5a3a22"
            )
            R(
                nil,
                c,
                x - 11,
                201,
                3,
                6,
                "#5a3820"
            )
            R(
                nil,
                c,
                x + 6,
                201,
                3,
                6,
                "#5a3820"
            )
        end
        do
            local x = 900 - camL
            if __t(x > -20 and x < 500) then
                R(
                    nil,
                    c,
                    x,
                    168,
                    2,
                    20,
                    "#f2f2ee"
                )
                ell(
                    nil,
                    c,
                    x + 2,
                    166,
                    7,
                    4,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    164,
                    7,
                    1,
                    "#e8c24a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    186,
                    1,
                    12,
                    "#3a3a3a"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    186,
                    1,
                    12,
                    "#3a3a3a"
                )
            end
        end
        do
            local x = 260 - camL
            local y = 176 + math.sin(t * 1.5) * 1.5
            if __t(x > -60 and x < 520) then
                c.fillStyle = "#6a3a1a"
                c:beginPath()
                c:moveTo(x - 26, y)
                c:lineTo(x + 26, y)
                c:lineTo(x + 17, y + 9)
                c:lineTo(x - 17, y + 9)
                c:closePath()
                __call(c, "fill")
                R(
                    nil,
                    c,
                    x - 24,
                    y,
                    48,
                    2,
                    "#a86a3a"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    y - 2,
                    12,
                    2,
                    "#8a5a2a"
                )
                c.globalAlpha = 0.3
                ell(
                    nil,
                    c,
                    x,
                    y + 12,
                    26,
                    2,
                    "#0c1630"
                )
                c.globalAlpha = 1
            end
        end
        R(
            nil,
            c,
            0,
            198,
            482,
            22,
            tinta(nil, "#7a6a42", "#2a2a2a")
        )
        do
            local k = 0
            while k < 70 do
                local x = __mod(
                    __mod(k * 37 - camL, 500) + 500,
                    500
                ) - 10
                R(
                    nil,
                    c,
                    x,
                    191 + __mod(k, 4),
                    1,
                    7 + __mod(k, 3) * 2,
                    tinta(nil, "#4a8a3a", "#1a3a22")
                )
                if __mod(k, 9) == 0 then
                    R(
                        nil,
                        c,
                        x + 1,
                        190,
                        2,
                        2,
                        __get(
                            __arrL({"#f2c94c", "#f2a8c8", "#ffffff"}, 3),
                            __mod(k, 3)
                        )
                    )
                end
                k = k + 1
            end
        end
        for ____, wx in __iterar((__arrL({150, 880, 2280}, 3))) do
            local x = wx * 0.5 - camL * 0.9
            if __t(x < -30 or x > 510) then
                continue
            end
            ell(
                nil,
                c,
                x,
                204,
                12,
                6,
                tinta(nil, "#6a6a6a", "#22262e")
            )
            ell(
                nil,
                c,
                x - 3,
                201,
                7,
                3,
                tinta(nil, "#4a7a3a", "#1a3020")
            )
        end
        for ____, wx in __iterar((AC.POSTES)) do
            local x = wx / 2 - camL
            if __t(x < -40 or x > 520) then
                continue
            end
            R(
                nil,
                c,
                x,
                150,
                2,
                40,
                "#3a2a1a"
            )
            R(
                nil,
                c,
                x - 3,
                146,
                8,
                6,
                "#2a2420"
            )
            R(
                nil,
                c,
                x - 2,
                147,
                6,
                4,
                if n > 0.15 then "#ffd27a" else "#c8c0a0"
            )
            if n > 0.15 then
                glow(
                    nil,
                    c,
                    x + 1,
                    149,
                    26,
                    "#ffc060",
                    0.65 * n
                )
                c.globalAlpha = 0.35 * n
                R(
                    nil,
                    c,
                    x - 1,
                    170,
                    4,
                    26,
                    "#ffd27a"
                )
                c.globalAlpha = 1
            end
        end
        do
            local a = __get(AC.POSTES, 0) / 2 - camL
            local b = __get(AC.POSTES, 2) / 2 - camL
            if __t(b > -20 and a < 500) then
                do
                    local k = 0
                    while k <= 24 do
                        local u = k / 24
                        local x = a + (b - a) * u
                        local y = 150 + math.sin(__mod(u * math.pi * 2, math.pi)) * 6 + math.abs(math.sin(u * math.pi * 2)) * 4
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#3a2a1a"
                        )
                        if __mod(k, 3) == 0 then
                            local cor = __get(
                                __arrL({"#ff8a5a", "#ffd27a", "#8ad8ff"}, 3),
                                if __mod(k, 3) == 0 then __mod(k / 3, 3) else 0
                            )
                            R(
                                nil,
                                c,
                                x,
                                y + 1,
                                2,
                                2,
                                cor
                            )
                            if n > 0.15 then
                                glow(
                                    nil,
                                    c,
                                    x + 1,
                                    y + 2,
                                    6,
                                    cor,
                                    0.5 * n
                                )
                            end
                        end
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = AC.FOGO / 2 - camL
            if __t(x > -60 and x < 540) then
                R(
                    nil,
                    c,
                    x - 50,
                    150,
                    2,
                    40,
                    "#5a5a5a"
                )
                c.fillStyle = "#c43c3a"
                c:beginPath()
                c:moveTo(x - 76, 156)
                c:quadraticCurveTo(x - 49, 132, x - 22, 156)
                c:closePath()
                __call(c, "fill")
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x - 70 + k * 14,
                            152 - if __t(k == 1 or k == 2) then 4 else 0,
                            1,
                            4,
                            "#8a2a2a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 32,
                    182,
                    10,
                    8,
                    "#3a6aa8"
                )
                R(
                    nil,
                    c,
                    x - 32,
                    182,
                    10,
                    2,
                    "#6a9ad8"
                )
                c.strokeStyle = "#6a4a2a"
                c.lineWidth = 1
                c:beginPath()
                c:moveTo(x - 40, 190)
                c:lineTo(x - 10, 138)
                c:stroke()
                local fy = 204
                R(
                    nil,
                    c,
                    x - 8,
                    fy,
                    16,
                    3,
                    "#3a2a1a"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    fy - 2,
                    3,
                    3,
                    "#5a3a22"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    fy - 2,
                    3,
                    3,
                    "#5a3a22"
                )
                do
                    local k = 0
                    while k < 5 do
                        local h = 6 + math.abs(math.sin(t * 8 + k * 1.7)) * 6 + if k == 2 then 4 else 0
                        R(
                            nil,
                            c,
                            x - 5 + k * 2.4,
                            fy - h,
                            2,
                            h,
                            if __t(__mod(k, 2)) then "#ff8a2a" else "#ffc640"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 1,
                    fy - 5,
                    2,
                    4,
                    "#fff6d0"
                )
                glow(
                    nil,
                    c,
                    x,
                    fy - 6,
                    44,
                    "#ff9a40",
                    0.55 + math.sin(t * 9) * 0.06
                )
                glow(
                    nil,
                    c,
                    x,
                    fy - 6,
                    14,
                    "#fff2c0",
                    0.5
                )
                do
                    local k = 0
                    while k < 8 do
                        local u = __mod(
                            t * 0.5 + hash(nil, k),
                            1
                        )
                        local ex = x + (hash(nil, k + 3) - 0.5) * 10 + math.sin(t * 2 + k) * u * 8
                        local ey = fy - 8 - u * 50
                        c.globalAlpha = 1 - u
                        R(
                            nil,
                            c,
                            ex,
                            ey,
                            1,
                            1,
                            if __t(__mod(k, 2)) then "#ffb040" else "#ffe08a"
                        )
                        c.globalAlpha = 1
                        k = k + 1
                    end
                end
                fumacaSobe(
                    nil,
                    c,
                    x + 2,
                    fy - 14,
                    t,
                    6,
                    34,
                    if n > 0.5 then "#4a4a60" else "#c8c8d0"
                )
            end
        end
        do
            local x = 695 - camL
            if __t(x > -60 and x < 540) then
                R(
                    nil,
                    c,
                    x - 38,
                    186,
                    3,
                    26,
                    "#5a3a20"
                )
                R(
                    nil,
                    c,
                    x + 35,
                    186,
                    3,
                    26,
                    "#5a3a20"
                )
                R(
                    nil,
                    c,
                    x - 46,
                    136,
                    92,
                    18,
                    "#3a2410"
                )
                R(
                    nil,
                    c,
                    x - 45,
                    137,
                    90,
                    16,
                    "#8a5a32"
                )
                R(
                    nil,
                    c,
                    x - 45,
                    137,
                    90,
                    2,
                    "#b8845a"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    154,
                    4,
                    32,
                    "#5a3a20"
                )
            end
        end
        R(
            nil,
            c,
            0,
            220,
            482,
            50,
            tinta(nil, "#8a7a56", "#2a2620")
        )
        do
            local x = 0
            while x < 482 do
                local wx = x + camL
                R(
                    nil,
                    c,
                    x - __mod(camL, 10),
                    224 + __mod(
                        math.floor(wx / 10),
                        4
                    ) * 6,
                    3,
                    2,
                    tinta(nil, "#6a5a3e", "#1e1a16")
                )
                x = x + 10
            end
        end
        if __t(F) then
            F:chaoAcude(c, t, camL, n)
        end
        for ____, wx in __iterar((__arrL({400, 1680}, 2))) do
            local x = wx - camL
            local pulo = math.max(
                0,
                math.sin(t * 2 + wx)
            ) * 6
            if __t(x > -10 and x < 490) then
                ell(
                    nil,
                    c,
                    x,
                    216 - pulo,
                    4,
                    3,
                    "#5aa84a"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    213 - pulo,
                    1,
                    1,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    213 - pulo,
                    1,
                    1,
                    "#1c1c1c"
                )
            end
        end
        if n > 0.2 then
            vagalumes(
                nil,
                c,
                0,
                482,
                120,
                214,
                t,
                26,
                0.7 * n
            )
        else
            do
                local k = 0
                while k < 4 do
                    local x = __mod(
                        hash(nil, k) * 600 + t * 12 - camL * 0.5,
                        520
                    )
                    local y = 160 + math.sin(t * 2 + k) * 14
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        1,
                        __get(
                            __arrL({"#f2c94c", "#ffffff", "#f2a8c8", "#8ad8ff"}, 4),
                            k
                        )
                    )
                    R(
                        nil,
                        c,
                        x + if math.sin(t * 18 + k) > 0 then 1 else -1,
                        y - 1,
                        1,
                        1,
                        __get(
                            __arrL({"#f2c94c", "#ffffff", "#f2a8c8", "#8ad8ff"}, 4),
                            k
                        )
                    )
                    k = k + 1
                end
            end
        end
    end
    local function acudeText(self, c, cam)
        c:save()
        c:translate(
            -math.floor(cam + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "9px Pixel, monospace"
        c.fillStyle = "#fff6dc"
        c:fillText("AÇUDE DA ROÇA", 1390, 282)
        c.font = "7px Pixel, monospace"
        c.fillStyle = "#ffe0a8"
        c:fillText("PROIBIDO NADAR COM CAPIVARA", 1390, 298)
        c:restore()
    end
    local function plataforma(self, c, p, scene, t)
        local x, y, w = table.unpack(p, 1, 3)
        scene = __TS__Number(scene)
        if not __t(__get(LUGARES, scene)) then
            return false
        end
        if scene == 40 then
            R(
                nil,
                c,
                x,
                y,
                w,
                8,
                "#6a7482"
            )
            R(
                nil,
                c,
                x,
                y,
                w,
                2,
                "#b8c0c8"
            )
            R(
                nil,
                c,
                x,
                y + 8,
                w,
                2,
                "#3a4250"
            )
            for ____, lx in __iterar((__arrL(
                {
                    x + 4,
                    __add(x, w) - 8
                },
                2
            ))) do
                R(
                    nil,
                    c,
                    lx,
                    y + 10,
                    4,
                    FLOOR - y - 10,
                    "#4a5462"
                )
            end
            do
                local k = 0
                while k < w - 20 do
                    R(
                        nil,
                        c,
                        x + 10 + k,
                        y - 14,
                        22,
                        14,
                        "#a8784a"
                    )
                    R(
                        nil,
                        c,
                        x + 10 + k,
                        y - 14,
                        22,
                        2,
                        "#c89a68"
                    )
                    R(
                        nil,
                        c,
                        x + 18 + k,
                        y - 9,
                        6,
                        4,
                        "#6a4a2a"
                    )
                    k = k + 28
                end
            end
            return true
        end
        if scene == 41 then
            R(
                nil,
                c,
                x,
                y,
                w,
                8,
                "#8a5a36"
            )
            R(
                nil,
                c,
                x,
                y,
                w,
                2,
                "#b8845a"
            )
            do
                local k = 0
                while __lt(k, w) do
                    R(
                        nil,
                        c,
                        x + k,
                        y - 16,
                        2,
                        16,
                        "#5a3820"
                    )
                    k = k + 12
                end
            end
            R(
                nil,
                c,
                x,
                y - 17,
                w,
                3,
                "#7a4a2a"
            )
            for ____, lx in __iterar((__arrL(
                {
                    x + 6,
                    __add(x, w) - 10
                },
                2
            ))) do
                R(
                    nil,
                    c,
                    lx,
                    y + 8,
                    4,
                    FLOOR - y - 8,
                    "#5a3820"
                )
            end
            return true
        end
        if scene == 42 then
            R(
                nil,
                c,
                x,
                y,
                w,
                8,
                "#9a6a3a"
            )
            R(
                nil,
                c,
                x,
                y,
                w,
                2,
                "#c8945a"
            )
            do
                local k = 0
                while __lt(k, w) do
                    R(
                        nil,
                        c,
                        x + k,
                        y,
                        1,
                        8,
                        "#6a4224"
                    )
                    k = k + 14
                end
            end
            do
                local k = 8
                while __lt(k, w) do
                    R(
                        nil,
                        c,
                        x + k,
                        y + 8,
                        6,
                        FLOOR - y + 10,
                        "#5a3a20"
                    )
                    k = k + 70
                end
            end
            R(
                nil,
                c,
                x,
                y + 8,
                w,
                2,
                "rgba(0,0,0,.3)"
            )
            return true
        end
        return false
    end
    local ____t_59 = __t
    local ____opt_57 = window.HdMaps
    if ____opt_57 ~= nil then
        ____opt_57 = ____opt_57.register
    end
    if ____t_59(____opt_57) then
        local function interno()
            return __arrL({1, 1, 1}, 3)
        end
        window.HdMaps:register(
            40,
            __ord({always = true, draw = oficina, text = oficinaText, amb = interno}, "always,draw,text,amb")
        )
        window.HdMaps:register(
            41,
            __ord({always = true, draw = lanche, text = lancheText, amb = interno}, "always,draw,text,amb")
        )
        window.HdMaps:register(
            42,
            __ord({always = true, draw = acude, text = acudeText}, "always,draw,text")
        )
    end
    local function fala(____, name, text, actionLabel)
        return if __t(actionLabel) then {name = name, text = text, actionLabel = actionLabel} else {name = name, text = text}
    end
    local function achadas(____, q)
        local ____Set_65 = Set
        local ____call_64 = __call
        local ____isArray_63 = __isArray
        local ____opt_result_62
        if q ~= nil then
            ____opt_result_62 = q.ferramentas
        end
        return __TS__New(
            ____Set_65,
            ____call_64(
                if ____isArray_63(____opt_result_62) then q.ferramentas else __arrL({}, 0),
                "filter",
                function(____, id) return __call(
                    FERRAMENTAS,
                    "some",
                    function(____, f) return f.id == id end
                ) end
            )
        )
    end
    local function falar(self, id, q, api)
        local ____t_68 = __t
        local ____opt_66 = __get(NPCS, id)
        if ____opt_66 ~= nil then
            ____opt_66 = ____opt_66.name
        end
        __O[1313] = ____opt_66
        local N = if ____t_68(____opt_66) then __O[1313] else id
        if id == "tio_juca" then
            if __t(q.ferramentasFeita) then
                api:say(__arrL(
                    {fala(nil, N, "Com as ferramentas no lugar, essa oficina conserta até avião. Teu carro a gás tá voando bonito, hein?")},
                    1
                ))
                return
            end
            if not __t(q.ferramentasAceita) then
                api:say(
                    __arrL(
                        {
                            fala(nil, N, "Ô Da Roça! Sou o Juca, tio do Lucas. Foi aqui que a gente montou o carro a gás do teu pai."),
                            fala(nil, N, "Só que o gato da oficina derrubou tudo das prateleiras: a chave inglesa, o macaco e o meu alicate da sorte."),
                            fala(nil, "Da Roça", "Deixa que eu subo nas prateleiras. Parkour de oficina é comigo!", "Procurar as ferramentas")
                        },
                        3
                    ),
                    function()
                        q.ferramentasAceita = true
                        q.ferramentas = __arrL({}, 0)
                        api:toast("Missão Ferramentas sumidas: ache 3 ferramentas nas prateleiras da oficina.")
                        api:save()
                    end
                )
                return
            end
            local n = achadas(nil, q).size
            if n < __len(FERRAMENTAS) then
                api:say(__arrL(
                    {fala(
                        nil,
                        N,
                        ("Achou " .. tostring(n)) .. " de 3. Olha nas prateleiras de cima: o gato adora esconder coisa no alto."
                    )},
                    1
                ))
                return
            end
            api:say(
                __arrL(
                    {
                        fala(nil, "Da Roça", "Chave inglesa, macaco e alicate da sorte. Tudo aqui, Tio Juca!"),
                        fala(nil, N, "Rapaz! Toma esses materiais que sobraram do conserto. Leva pro Kauã que ele transforma em arma.", "Receber o prêmio")
                    },
                    2
                ),
                function()
                    q.ferramentasFeita = true
                    api:materiais(3)
                    api:xp(160, "side-ferramentas")
                    api:toast("Ferramentas sumidas: +3 materiais escolares e XP!")
                    api:save()
                end
            )
            return
        end
        if id == "zito" then
            local primeira = not __t(q.zitoVisita)
            api:say(
                __arrL(
                    {
                        fala(nil, N, if __t(primeira) then "Bem-vindo à Lanchonete do Zito! Coxinha quentinha, pastel de queijo e suco de cacau da roça." else "Voltou, cliente de ouro! O de sempre?"),
                        fala(nil, N, "Herói de Itabuna não paga lanche aqui. Senta aí que eu caprichei."),
                        fala(nil, "Da Roça", "Coxinha com suco de cacau... isso é poder elemental!", "Comer o lanche")
                    },
                    3
                ),
                function()
                    api:curar()
                    if __t(primeira) then
                        q.zitoVisita = true
                        api:xp(60, "side-zito")
                    end
                    api:toast("Lanche do Zito: vida e gás cheios!")
                    api:save()
                end
            )
            return
        end
        if id == "vagner" then
            local ja = not not __t(q.pescaria)
            api:say(
                __arrL(
                    {
                        fala(nil, N, if __t(ja) then "O açude ainda tá falando daquela pescaria! Bora de novo? A fogueira tá acesa pro peixe frito." else "Psiu... fala baixo que os peixes escutam. Sou o Vagner, pescador desse açude desde menino."),
                        fala(nil, N, "Quando a boia afundar, puxa! Aperta o botão ou E na hora certa. Pega três peixes e tu vira pescador de verdade.", "Pescar")
                    },
                    2
                ),
                function()
                    local ____opt_71 = window.PescariaBene
                    if ____opt_71 ~= nil then
                        ____opt_71 = ____opt_71.abrir
                    end
                    if ____opt_71 ~= nil then
                        ____opt_71(
                            ____opt_71,
                            {onFim = function(____, peixes)
                                if __t(__ge(peixes, 3) and not __t(q.pescaria)) then
                                    q.pescaria = true
                                    api:xp(150, "side-pescaria")
                                    api:curar()
                                    api:toast(tostring(peixes) .. " peixes! Seu Vagner fritou na fogueira: vida e gás cheios e XP de pescador.")
                                    api:save()
                                elseif __ge(peixes, 3) then
                                    api:curar()
                                    api:toast(tostring(peixes) .. " peixes! Peixe frito de novo: vida e gás cheios.")
                                else
                                    api:toast(tostring(peixes) .. " peixe(s). O Seu Vagner disse que a boia não espera ninguém.")
                                end
                            end}
                        )
                    end
                end
            )
        end
    end
    local function coletar(self, q, player, scene)
        local ____t_81 = __t
        local ____t_80 = __t
        local ____t_78 = __t
        local ____temp_77 = __TS__Number(scene) ~= 40
        if not ____temp_77 then
            local ____t_76 = __t
            local ____opt_result_75
            if q ~= nil then
                ____opt_result_75 = q.ferramentasAceita
            end
            ____temp_77 = not ____t_76(____opt_result_75)
        end
        __O[1314] = ____temp_77
        local ____temp_79 = if ____t_78(____temp_77) then __O[1314] else q.ferramentasFeita
        __O[1315] = ____temp_79
        if ____t_81(if ____t_80(____temp_79) then __O[1315] else not __t(player)) then
            return nil
        end
        local a = achadas(nil, q)
        local f = __call(
            FERRAMENTAS,
            "find",
            function(____, p)
                local ____t_83 = __t
                local ____temp_82 = not __t(__call(a, "has", p.id)) and math.abs(player.x - p.x) <= 34
                __O[1316] = ____temp_82
                return if ____t_83(____temp_82) then math.abs(player.y - 30 - p.y) <= 44 else __O[1316]
            end
        )
        if not __t(f) then
            return nil
        end
        __call(a, "add", f.id)
        q.ferramentas = __arr(__TS__Spread(__iter(a)))
        return {count = a.size, message = if a.size >= 3 then "Ferramentas 3/3! Volte ao Tio Juca." else ((tostring(f.nome) .. " · ") .. tostring(a.size)) .. "/3"}
    end
    local function desenhar(self, c, t, q, scene)
        local ____t_90 = __t
        local ____t_89 = __t
        local ____temp_88 = __TS__Number(scene) ~= 40
        if not ____temp_88 then
            local ____t_87 = __t
            local ____opt_result_86
            if q ~= nil then
                ____opt_result_86 = q.ferramentasAceita
            end
            ____temp_88 = not ____t_87(____opt_result_86)
        end
        __O[1317] = ____temp_88
        if ____t_90(if ____t_89(____temp_88) then __O[1317] else q.ferramentasFeita) then
            return
        end
        local a = achadas(nil, q)
        for ____, f in __iterar((FERRAMENTAS)) do
            if __t(__call(a, "has", f.id)) then
                continue
            end
            local x = f.x
            local y = f.y + math.sin(t * 3 + x) * 4
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = 0.3
            c.fillStyle = "#ffd24a"
            c:beginPath()
            c:arc(
                x,
                y,
                18,
                0,
                TAU
            )
            __call(c, "fill")
            c:restore()
            if f.id == "chave" then
                R(
                    nil,
                    c,
                    x - 12,
                    y - 2,
                    24,
                    4,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    x - 16,
                    y - 6,
                    8,
                    12,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    x - 13,
                    y - 3,
                    3,
                    6,
                    "#3a3e44"
                )
            elseif f.id == "macaco" then
                R(
                    nil,
                    c,
                    x - 12,
                    y + 2,
                    24,
                    6,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y - 10,
                    6,
                    12,
                    "#e86a5a"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    y - 12,
                    12,
                    3,
                    "#7a8086"
                )
            else
                R(
                    nil,
                    c,
                    x - 2,
                    y - 10,
                    4,
                    10,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y - 10,
                    4,
                    10,
                    "#e8c24a"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y,
                    6,
                    8,
                    "#9aa0a6"
                )
            end
        end
    end
    local function objetivo(self, q, scene)
        local ____t_98 = __t
        local ____t_97 = __t
        local ____t_92 = __t
        local ____temp_91 = __TS__Number(scene) == 40
        __O[1318] = ____temp_91
        local ____opt_result_95
        if q ~= nil then
            ____opt_result_95 = q.ferramentasAceita
        end
        local ____temp_96 = if ____t_92(____temp_91) then ____opt_result_95 else __O[1318]
        __O[1319] = ____temp_96
        if ____t_98(if ____t_97(____temp_96) then not __t(q.ferramentasFeita) else __O[1319]) then
            local n = achadas(nil, q).size
            return __arrL({"Ferramentas sumidas", if n >= 3 then "Leve as três ferramentas ao Tio Juca." else tostring(n) .. "/3 ferramentas achadas nas prateleiras da oficina."}, 2)
        end
        if __t(__get(LUGARES, scene)) then
            return __arrL(
                {
                    __get(LUGARES, scene).nome,
                    __add(
                        __get(LUGARES, scene).sub,
                        ". Use o carro a gás (mapa) para voltar à campanha."
                    )
                },
                2
            )
        end
        return nil
    end
    local function alvo(self, q, scene)
        local ____t_105 = __t
        local ____t_104 = __t
        local ____temp_103 = __TS__Number(scene) ~= 40
        if not ____temp_103 then
            local ____t_102 = __t
            local ____opt_result_101
            if q ~= nil then
                ____opt_result_101 = q.ferramentasAceita
            end
            ____temp_103 = not ____t_102(____opt_result_101)
        end
        __O[1320] = ____temp_103
        if ____t_105(if ____t_104(____temp_103) then __O[1320] else q.ferramentasFeita) then
            return nil
        end
        local a = achadas(nil, q)
        local ____opt_106 = __call(
            FERRAMENTAS,
            "find",
            function(____, f) return not __t(__call(a, "has", f.id)) end
        )
        if ____opt_106 ~= nil then
            ____opt_106 = ____opt_106.x
        end
        local ____opt_106_108 = ____opt_106
        if ____opt_106_108 == nil then
            ____opt_106_108 = NPCS.tio_juca.x
        end
        return ____opt_106_108
    end
    window.LugaresC1 = __ord(
        {
            ids = __call(
                __keys(LUGARES),
                "map",
                __NumberV
            ),
            tem = function(____, n) return not not __t(__get(
                LUGARES,
                __TS__Number(n)
            )) end,
            nome = function(____, n)
                local ____t_111 = __t
                local ____opt_109 = __get(
                    LUGARES,
                    __TS__Number(n)
                )
                if ____opt_109 ~= nil then
                    ____opt_109 = ____opt_109.nome
                end
                __O[1321] = ____opt_109
                return if ____t_111(____opt_109) then __O[1321] else ""
            end,
            sub = function(____, n)
                local ____t_114 = __t
                local ____opt_112 = __get(
                    LUGARES,
                    __TS__Number(n)
                )
                if ____opt_112 ~= nil then
                    ____opt_112 = ____opt_112.sub
                end
                __O[1322] = ____opt_112
                return if ____t_114(____opt_112) then __O[1322] else ""
            end,
            largura = function(____, n)
                local ____t_117 = __t
                local ____opt_115 = __get(
                    LUGARES,
                    __TS__Number(n)
                )
                if ____opt_115 ~= nil then
                    ____opt_115 = ____opt_115.largura
                end
                __O[1323] = ____opt_115
                return if ____t_117(____opt_115) then __O[1323] else 0
            end,
            plataformas = function(____, n)
                local ____call_121 = __call
                local ____t_120 = __t
                local ____opt_118 = __get(
                    LUGARES,
                    __TS__Number(n)
                )
                if ____opt_118 ~= nil then
                    ____opt_118 = ____opt_118.plataformas
                end
                __O[1324] = ____opt_118
                return ____call_121(
                    if ____t_120(____opt_118) then __O[1324] else __arrL({}, 0),
                    "map",
                    function(____, p) return __call(p, "slice") end
                )
            end,
            porta = function(____, n)
                local ____opt_122 = __get(
                    LUGARES,
                    __TS__Number(n)
                )
                if ____opt_122 ~= nil then
                    ____opt_122 = ____opt_122.porta
                end
                local ____opt_122_124 = ____opt_122
                if ____opt_122_124 == nil then
                    ____opt_122_124 = nil
                end
                return ____opt_122_124
            end,
            npcs = __assign({}, NPCS),
            ehNpc = function(____, id) return not not __t(__get(NPCS, id)) end,
            falar = falar,
            coletar = coletar,
            desenhar = desenhar,
            objetivo = objetivo,
            alvo = alvo,
            plataforma = plataforma
        },
        "ids,tem,nome,sub,largura,plataformas,porta,npcs,ehNpc,falar,coletar,desenhar,objetivo,alvo,plataforma"
    )
end)(nil)
return ____exports
