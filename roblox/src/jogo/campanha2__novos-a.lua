--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add = __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_8 = __t
    local ____t_4 = __t
    local ____t_2 = __t
    local ____opt_0 = window.CampanhaCenarios
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.arte
    end
    local ____temp_3 = if __t(window.CampanhaNovos) then window.CampanhaNovos else not ____t_2(____opt_0)
    __O[452] = ____temp_3
    local ____t_7 = __t
    local ____opt_5 = window.CampanhaCamadas
    if ____opt_5 ~= nil then
        ____opt_5 = ____opt_5.kit
    end
    if ____t_8(if ____t_4(____temp_3) then __O[452] else not ____t_7(____opt_5)) then
        return
    end
    local CC = window.CampanhaCenarios
    local A = CC.arte
    local K = window.CampanhaCamadas.kit
    local R = A.R
    local ell = A.ell
    local mk = A.mk
    local hash = A.hash
    local cl = A.cl
    local mix = A.mix
    local limb = A.limb
    local tile = A.tile
    local sky = A.sky
    local haze = A.haze
    local tree = A.tree
    local vis = A.vis
    local night = A.night
    local shadeHex = A.shadeHex
    local pick = A.pick
    local lightAdd = A.lightAdd
    local lampGlow = A.lampGlow
    local vgrad = A.vgrad
    local reflexo = A.reflexo
    local gente = A.gente
    local pessoa = A.pessoa
    local plaster = A.plaster
    local brick = A.brick
    local roofTiles = A.roofTiles
    local janela = A.janela
    local caixaDagua = A.caixaDagua
    local antena = A.antena
    local cartaz = A.cartaz
    local bandeirinhas = A.bandeirinhas
    local gato = A.gato
    local cachorro = A.cachorro
    local plantaVaso = A.plantaVaso
    local lampPost = A.lampPost
    local bench = A.bench
    local ipe = A.ipe
    local fog = A.fog
    local conquistaBack = A.conquistaBack
    local passaros = A.passaros
    local objetos = A.objetos
    local chaoDetalhe = A.chaoDetalhe
    local terra = A.terra
    local pedraPortuguesa = A.pedraPortuguesa
    local calcada = A.calcada
    local asfalto = A.asfalto
    local pisoInterno = A.pisoInterno
    local grafite = A.grafite
    local Q = A.Q
    local QL = A.QL
    local sombra = A.sombra
    local concretoBase = A.concretoBase
    local lerpC = A.lerpC
    local GY = A.GY
    local sunInfo = A.sunInfo
    local pxText = K.pxText
    local largura = K.largura
    local pessoinha = K.pessoinha
    local carrinho = K.carrinho
    local arvoreM = K.arvoreM
    local nevoa = K.nevoa
    local buildRua = K.buildRua
    local noiteTile = K.noiteTile
    local andaRua = K.andaRua
    local scr = K.scr
    local wrap = K.wrap
    local balao = K.balao
    local SKIN = K.SKIN
    local ROUPA = K.ROUPA
    local T = K.T
    local OUTDOORS = K.OUTDOORS
    local LW = 482
    local LH = 270
    local TAU = math.pi * 2
    local function HERO()
        return A:heroiPos()
    end
    local function drawMid(____, c, mid, camL)
        return c:drawImage(
            mid,
            camL,
            0,
            LW,
            LH,
            0,
            0,
            LW,
            LH
        )
    end
    local function indoor(____, k)
        return function(____, s) return mix(
            nil,
            s.amb,
            __arrL({1, 1, 1}, 3),
            k
        ) end
    end
    local function placa(____, c, x, y, w, h, col)
        if col == nil then
            col = "#8a6a45"
        end
        R(
            nil,
            c,
            x + 3,
            __add(y, h),
            2,
            210 - y - h,
            "#5a3a20"
        )
        R(
            nil,
            c,
            __add(x, w) - 5,
            __add(y, h),
            2,
            210 - y - h,
            "#5a3a20"
        )
        R(
            nil,
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            "#4a2e18"
        )
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            col
        )
        R(
            nil,
            c,
            x,
            y,
            w,
            1,
            shadeHex(nil, col, 1.25)
        )
    end
    local function nota(____, c, x, y, col)
        R(
            nil,
            c,
            x,
            y,
            2,
            2,
            col
        )
        R(
            nil,
            c,
            x + 1,
            y - 5,
            1,
            5,
            col
        )
        R(
            nil,
            c,
            x + 2,
            y - 5,
            2,
            1,
            col
        )
    end
    local vaoAgua = __ord({fundo = "#163c3a", borda = "#7ac0b8"}, "fundo,borda")
    local POCO = __ord(
        {
            W = 2600,
            POOL = 1290,
            GUARITA = 2150,
            ARV = __arrL(
                {
                    __arrL({70, 22}, 2),
                    __arrL({420, 26}, 2),
                    __arrL({770, 18}, 2),
                    __arrL({1110, 24}, 2),
                    __arrL({1700, 26}, 2),
                    __arrL({1990, 20}, 2),
                    __arrL({2420, 24}, 2)
                },
                7
            )
        },
        "W,POOL,GUARITA,ARV"
    )
    local F28 = {}
    local function buildMataLonge(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local function hy(____, x)
            return 96 + math.sin(x / T * TAU * 3) * 9 + math.sin(x / T * TAU * 8 + 1) * 4
        end
        do
            local x = 0
            while __lt(x, T) do
                local y = math.floor(hy(nil, x) + 0.5)
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    LH - y,
                    "#7f9c8e"
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#9ab8a8"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 600 do
                local x = hash(nil, i + 280) * T
                local y = hy(nil, x) + 2 + hash(nil, i + 281) * 60
                ell(
                    nil,
                    c,
                    x,
                    y,
                    3 + hash(nil, i) * 5,
                    2.5 + hash(nil, i * 3) * 3,
                    pick(
                        nil,
                        __arrL({"#86a596", "#7a988a", "#90ae9e", "#749284"}, 4),
                        i
                    )
                )
                i = i + 1
            end
        end
        nevoa(nil, c, T, "rgba(205,220,228,.32)")
        return cv
    end
    local function buildCopa(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        do
            local i = 0
            while i < 100 do
                local x = hash(nil, i + 290) * T
                local top = 72 + hash(nil, i + 291) * 52
                R(
                    nil,
                    c,
                    x,
                    top + 10,
                    2,
                    200 - top,
                    "#6a7a64"
                )
                do
                    local k = 0
                    while k < 8 do
                        ell(
                            nil,
                            c,
                            x + (hash(nil, i * 9 + k) - 0.5) * 32,
                            top + hash(nil, i * 5 + k) * 26,
                            9 + hash(nil, k + i) * 7,
                            7 + hash(nil, k * 3 + i) * 5,
                            pick(
                                nil,
                                __arrL({"#5a8a5e", "#62926a", "#4f7e54", "#72a270"}, 4),
                                i + k
                            )
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            184,
            T,
            LH - 184,
            "#4a6e4c"
        )
        nevoa(nil, c, T, "rgba(196,214,206,.24)")
        return cv
    end
    local function buildTroncos(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        do
            local i = 0
            while i < 48 do
                local x = math.floor(hash(nil, i + 300) * T + 0.5)
                local w = 3 + math.floor(hash(nil, i + 301) * 6 + 0.5)
                local col = pick(
                    nil,
                    __arrL({"#5a4e3e", "#6a5a46", "#4e4436", "#7a6a52"}, 4),
                    i
                )
                R(
                    nil,
                    c,
                    x,
                    0,
                    w,
                    206,
                    col
                )
                R(
                    nil,
                    c,
                    x,
                    0,
                    1,
                    206,
                    shadeHex(nil, col, 1.25)
                )
                R(
                    nil,
                    c,
                    x + w - 1,
                    0,
                    1,
                    206,
                    shadeHex(nil, col, 0.72)
                )
                do
                    local y = 10
                    while y < 200 do
                        if __gt(
                            hash(nil, x + y),
                            0.62
                        ) then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                w,
                                2,
                                "#6a9450"
                            )
                        end
                        y = y + 9
                    end
                end
                if __gt(
                    hash(nil, i + 302),
                    0.5
                ) then
                    local by = 60 + hash(nil, i + 303) * 100
                    ell(
                        nil,
                        c,
                        x + if __gt(
                            hash(nil, i),
                            0.5
                        ) then w + 2 else -2,
                        by,
                        4,
                        2,
                        "#4a8a46"
                    )
                    R(
                        nil,
                        c,
                        x + w,
                        by - 3,
                        1,
                        3,
                        "#d84a6a"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 34 do
                local x0 = hash(nil, i + 320) * T
                local x1 = x0 + 20 + hash(nil, i + 321) * 50
                local sag = 30 + hash(nil, i + 322) * 70
                do
                    local k = 0
                    while k <= 24 do
                        local u = k / 24
                        R(
                            nil,
                            c,
                            x0 + (x1 - x0) * u,
                            6 + math.sin(u * math.pi) * sag,
                            1,
                            2,
                            "#5a6a3a"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local x = 0
            while __lt(x, T) do
                local h = 6 + hash(nil, x * 0.7) * 14
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 208}, 2),
                            __arrL(
                                {
                                    x + (hash(nil, x) - 0.5) * 7,
                                    208 - h
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    if __t(__mod(x, 3)) then "#4a7a40" else "#62904c"
                )
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 80 do
                local x = hash(nil, i + 340) * T
                do
                    local k = 0
                    while k < 6 do
                        ell(
                            nil,
                            c,
                            x + (k - 3) * 6,
                            3 + hash(nil, i * 7 + k) * 22,
                            9,
                            7,
                            pick(
                                nil,
                                __arrL({"#2f5a32", "#3a6a3a", "#28502c", "#447a40"}, 4),
                                i + k
                            )
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            205,
            T,
            4,
            "#3a3024"
        )
        nevoa(nil, c, T, "rgba(160,196,160,.16)")
        return {cv = cv, f = 0.38}
    end
    local function arvoreGrande(self, c, x, w, seed)
        local col = pick(
            nil,
            __arrL({"#5a4632", "#4e3e2c", "#64503a"}, 3),
            seed
        )
        R(
            nil,
            c,
            x,
            0,
            w,
            214,
            col
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    0,
                    1,
                    214,
                    shadeHex(nil, col, if __gt(
                        hash(nil, k + seed),
                        0.5
                    ) then 0.8 else 1.15)
                )
                k = k + 3
            end
        end
        R(
            nil,
            c,
            x,
            0,
            3,
            214,
            shadeHex(nil, col, 1.22)
        )
        R(
            nil,
            c,
            __add(x, w) - 4,
            0,
            4,
            214,
            shadeHex(nil, col, 0.62)
        )
        do
            local y = 16
            while y < 204 do
                if __gt(
                    hash(nil, y + seed),
                    0.58
                ) then
                    R(
                        nil,
                        c,
                        x - 1,
                        y,
                        3 + hash(nil, y) * 7,
                        3,
                        "#5f8a46"
                    )
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        1,
                        "#86b45e"
                    )
                end
                y = y + 5
            end
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            do
                local k = 0
                while k < 3 do
                    local h = 24 - k * 7
                    do
                        local j = 0
                        while j < h do
                            local rx = if side < 0 then x - 3 - k * 6 + j * 0.25 else __add(x, w) + k * 6 - j * 0.25
                            R(
                                nil,
                                c,
                                rx,
                                214 - j,
                                4,
                                1,
                                shadeHex(nil, col, 0.9 - k * 0.06)
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        local by = 84 + hash(nil, seed) * 60
        do
            local k = 0
            while k < 7 do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    __add(x, w) + 1,
                                    by
                                },
                                2
                            ),
                            __arrL(
                                {
                                    __add(x, w) + 3 + k,
                                    by - 7 + math.abs(k - 3)
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    if __t(__mod(k, 2)) then "#3f7a3a" else "#5a9a46"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            __add(x, w) + 4,
            by - 4,
            2,
            3,
            "#e8433a"
        )
        if __gt(
            hash(nil, seed + 1),
            0.35
        ) then
            local oy = by + 34
            R(
                nil,
                c,
                x - 3,
                oy,
                3,
                2,
                "#e8a8d8"
            )
            R(
                nil,
                c,
                x - 2,
                oy - 2,
                2,
                2,
                "#f6d8ee"
            )
            R(
                nil,
                c,
                x - 1,
                oy + 2,
                1,
                5,
                "#5a8a46"
            )
        end
        do
            local k = 0
            while k < 4 do
                local cy = 150 + k * 9 + hash(nil, seed + k) * 4
                ell(
                    nil,
                    c,
                    __add(x, w) + 1,
                    cy,
                    3,
                    1.5,
                    pick(
                        nil,
                        __arrL({"#e8833a", "#f2c94c", "#f2efe6"}, 3),
                        seed + k
                    )
                )
                k = k + 1
            end
        end
        ell(
            nil,
            c,
            x + w / 2,
            118,
            4,
            6,
            "#1c140c"
        )
        ell(
            nil,
            c,
            x + w / 2,
            117,
            3,
            5,
            "#2a1e12"
        )
    end
    local function buildPoco(self)
        local W = POCO.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        local p = POCO.POOL
        R(
            nil,
            c,
            0,
            194,
            W,
            26,
            "#4a3a28"
        )
        do
            local i = 0
            while i < W * 2 do
                R(
                    nil,
                    c,
                    hash(nil, i * 1.3) * W,
                    194 + hash(nil, i * 2.1) * 26,
                    2,
                    1,
                    pick(
                        nil,
                        __arrL({
                            "#6a4a2a",
                            "#8a5a2a",
                            "#5a7a3a",
                            "#a86a2a",
                            "#3a2a1a",
                            "#b8862a"
                        }, 6),
                        i
                    )
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                if __gt(
                    hash(nil, x * 0.37),
                    0.4
                ) then
                    local h = 5 + hash(nil, x) * 12
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, 200}, 2),
                                __arrL(
                                    {
                                        x + (hash(nil, x * 3) - 0.5) * 6,
                                        200 - h
                                    },
                                    2
                                )
                            },
                            2
                        ),
                        1,
                        if __t(__mod(x, 2)) then "#3f6a36" else "#5a8a46"
                    )
                end
                x = x + 3
            end
        end
        do
            local x = 0
            while x < W do
                if __t(x > p - 90 and x < p + 330) then
                    continue
                end
                R(
                    nil,
                    c,
                    x,
                    194,
                    3,
                    18,
                    "#6a4a2a"
                )
                R(
                    nil,
                    c,
                    x + 32,
                    194,
                    3,
                    18,
                    "#6a4a2a"
                )
                R(
                    nil,
                    c,
                    x,
                    197,
                    64,
                    2,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x,
                    197,
                    64,
                    1,
                    "#a8845a"
                )
                R(
                    nil,
                    c,
                    x,
                    204,
                    64,
                    2,
                    "#8a6a45"
                )
                x = x + 64
            end
        end
        do
            local i = 0
            while i < 46 do
                local rx = p + 10 + hash(nil, i + 500) * 250
                local ry = 70 + hash(nil, i + 501) * 120
                local rw = 14 + hash(nil, i) * 18
                local rh = 10 + hash(nil, i * 3) * 12
                ell(
                    nil,
                    c,
                    rx,
                    ry,
                    rw,
                    rh,
                    pick(
                        nil,
                        __arrL({"#5f5f58", "#6a6a62", "#52524c", "#76766c"}, 4),
                        i
                    )
                )
                ell(
                    nil,
                    c,
                    rx - rw * 0.2,
                    ry - rh * 0.3,
                    rw * 0.6,
                    rh * 0.45,
                    pick(
                        nil,
                        __arrL({"#7a7a70", "#86867c"}, 2),
                        i
                    )
                )
                if __gt(
                    hash(nil, i + 502),
                    0.4
                ) then
                    ell(
                        nil,
                        c,
                        rx + rw * 0.2,
                        ry - rh * 0.7,
                        rw * 0.5,
                        3,
                        "#5f8a46"
                    )
                end
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 24 do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    p + 40 + k * 9,
                                    70 + hash(nil, k) * 30
                                },
                                2
                            ),
                            __arrL(
                                {
                                    p + 38 + k * 9 + hash(nil, k * 2) * 4,
                                    100 + hash(nil, k * 3) * 60
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    "#4a7a3a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            p + 112,
            70,
            34,
            8,
            "#4a4a44"
        )
        R(
            nil,
            c,
            p + 112,
            70,
            34,
            2,
            "#6a6a62"
        )
        ell(
            nil,
            c,
            p + 130,
            202,
            128,
            13,
            "#0e2422"
        )
        ell(
            nil,
            c,
            p + 130,
            201,
            120,
            10,
            "#163634"
        )
        do
            local k = 0
            while k < 14 do
                R(
                    nil,
                    c,
                    p + 30 + k * 15,
                    198 + __mod(k, 3) * 2,
                    8,
                    1,
                    "rgba(160,220,210,.25)"
                )
                k = k + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({p + 10, 200}, 2),
                __arrL({p + 250, 198}, 2),
                __arrL({p + 60, 210}, 2),
                __arrL({p + 200, 210}, 2)
            },
            4
        ))) do
            local rx = ____value[1]
            local ry = ____value[2]
            ell(
                nil,
                c,
                rx,
                ry,
                14,
                7,
                "#6a6a62"
            )
            ell(
                nil,
                c,
                rx - 3,
                ry - 2,
                8,
                3,
                "#86867c"
            )
            ell(
                nil,
                c,
                rx + 2,
                ry - 5,
                6,
                2,
                "#5f8a46"
            )
        end
        local tx = 560
        R(
            nil,
            c,
            tx,
            202,
            76,
            11,
            "#5a4030"
        )
        R(
            nil,
            c,
            tx,
            202,
            76,
            2,
            "#7a5a40"
        )
        ell(
            nil,
            c,
            tx + 76,
            207,
            5,
            6,
            "#c8a06a"
        )
        ell(
            nil,
            c,
            tx + 76,
            207,
            3,
            4,
            "#9a7046"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    tx + 10 + k * 13,
                    198,
                    2,
                    4,
                    "#f2e8d0"
                )
                ell(
                    nil,
                    c,
                    tx + 11 + k * 13,
                    198,
                    4,
                    2,
                    if __t(__mod(k, 2)) then "#e8833a" else "#c43c3a"
                )
                R(
                    nil,
                    c,
                    tx + 9 + k * 13,
                    197,
                    1,
                    1,
                    "#f2efe6"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 9 do
                R(
                    nil,
                    c,
                    980 + 6 - (9 - k) * 0.7,
                    210 - k * 2.4,
                    (9 - k) * 1.4 + 3,
                    3,
                    if __t(__mod(k, 2)) then "#b07a4a" else "#a06a3e"
                )
                k = k + 1
            end
        end
        placa(
            nil,
            c,
            180,
            158,
            64,
            18
        )
        placa(
            nil,
            c,
            880,
            160,
            70,
            16,
            "#7a5a3a"
        )
        placa(
            nil,
            c,
            p - 70,
            156,
            54,
            16,
            "#6a8a3a"
        )
        placa(
            nil,
            c,
            1830,
            162,
            50,
            14
        )
        R(
            nil,
            c,
            892,
            163,
            10,
            10,
            "#f2c94c"
        )
        R(
            nil,
            c,
            894,
            165,
            6,
            6,
            "#8a8a80"
        )
        R(
            nil,
            c,
            893,
            169,
            8,
            1,
            "#c43c3a"
        )
        local g = POCO.GUARITA
        do
            local k = 0
            while k < 64 do
                R(
                    nil,
                    c,
                    g + k,
                    148,
                    4,
                    62,
                    if __t(__mod(k, 8)) then "#8a6a45" else "#7a5a3a"
                )
                R(
                    nil,
                    c,
                    g + k,
                    148,
                    1,
                    62,
                    "#a8845a"
                )
                k = k + 4
            end
        end
        roofTiles(
            nil,
            c,
            g - 6,
            140,
            76,
            8,
            "#6a4a32"
        )
        R(
            nil,
            c,
            g + 8,
            160,
            22,
            16,
            "#3a2a1a"
        )
        vgrad(
            nil,
            c,
            g + 9,
            161,
            20,
            14,
            "#8ab0b8",
            "#5a7a84"
        )
        R(
            nil,
            c,
            g + 18,
            161,
            1,
            14,
            "#3a2a1a"
        )
        ell(
            nil,
            c,
            g + 13,
            170,
            3,
            3,
            "#9a6440"
        )
        R(
            nil,
            c,
            g + 10,
            173,
            6,
            3,
            "#3c6a3a"
        )
        R(
            nil,
            c,
            g + 11,
            166,
            5,
            2,
            "#5a6a3a"
        )
        R(
            nil,
            c,
            g + 40,
            168,
            16,
            42,
            "#5a3a20"
        )
        R(
            nil,
            c,
            g + 52,
            188,
            2,
            3,
            "#e8c24c"
        )
        R(
            nil,
            c,
            g + 20,
            150,
            26,
            7,
            "#3c6a3a"
        )
        R(
            nil,
            c,
            g + 21,
            151,
            24,
            5,
            "#5a8a46"
        )
        R(
            nil,
            c,
            g + 66,
            172,
            4,
            6,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            g + 67,
            173,
            2,
            3,
            "#ffe39a"
        )
        for ____, ____value in __iterar((POCO.ARV)) do
            local x = ____value[1]
            local w = ____value[2]
            arvoreGrande(
                nil,
                c,
                x,
                w,
                x
            )
        end
        do
            local i = 0
            while i < W / 5 do
                local x = hash(nil, i + 600) * W
                ell(
                    nil,
                    c,
                    x,
                    hash(nil, i + 601) * 30,
                    10 + hash(nil, i) * 8,
                    7 + hash(nil, i * 2) * 5,
                    pick(
                        nil,
                        __arrL({"#2a4e2c", "#335c34", "#24452a", "#3e6a3a"}, 4),
                        i
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 30 do
                local x = hash(nil, i + 620) * W
                do
                    local k = 0
                    while k < 18 do
                        R(
                            nil,
                            c,
                            x + math.sin(k * 0.5) * 2,
                            28 + k * 2,
                            1,
                            2,
                            "#3a5a2e"
                        )
                        k = k + 1
                    end
                end
                ell(
                    nil,
                    c,
                    x,
                    66,
                    2,
                    2,
                    "#4a7a3a"
                )
                i = i + 1
            end
        end
        terra(
            nil,
            c,
            W,
            "#5a7a36",
            "#4a6a2e"
        )
        do
            local i = 0
            while i < W * 3 do
                R(
                    nil,
                    c,
                    hash(nil, i * 3.7) * W,
                    222 + hash(nil, i * 1.9) * 48,
                    2,
                    1,
                    pick(
                        nil,
                        __arrL({
                            "#8a5a2a",
                            "#a86a2a",
                            "#6a4a2a",
                            "#c88a3a",
                            "#5a7a3a"
                        }, 5),
                        i
                    )
                )
                i = i + 1
            end
        end
        chaoDetalhe(nil, c, W, "natureza")
        return cv
    end
    local function poco(self, c, s, t, camL)
        if not __t(F28.mid) then
            F28.longe = buildMataLonge(nil)
            F28.copa = buildCopa(nil)
            F28.tr = buildTroncos(nil)
            F28.mid = buildPoco(nil)
        end
        local nt = night(nil, s)
        local p = POCO.POOL
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(nil, c, F28.longe, camL * 0.05)
        haze(
            nil,
            c,
            s,
            t,
            camL,
            90,
            170
        )
        tile(nil, c, F28.copa, camL * 0.14)
        do
            local per = 38
            local ph = __mod(t, per) / per
            if __t(ph < 0.35 and __lt(nt, 0.6)) then
                local k = ph / 0.35
                local x = -30 + k * 560
                local y = 70 + math.sin(k * 9) * 5
                local f = math.sin(t * 14) > 0
                R(
                    nil,
                    c,
                    x,
                    y,
                    9,
                    4,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x + 9,
                    y,
                    7,
                    3,
                    "#f08a24"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    y + 1,
                    2,
                    2,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    y + 1,
                    3,
                    3,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y - if __t(f) then 4 else -3,
                    6,
                    2,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    y + 1,
                    4,
                    2,
                    "#1c1c1c"
                )
            end
        end
        tile(nil, c, F28.tr.cv, camL * F28.tr.f)
        do
            local i = 0
            while i < 4 do
                local cyc = 6 + i
                local ph = __mod(t + i * 2.3, cyc) / cyc
                local j = math.floor((t + i * 2.3) / cyc)
                local x0 = 120 + __mod(j * 97 + i * 211, 1100)
                local x1 = x0 + 50
                local u = cl(nil, ph * 3)
                local x = x0 + (x1 - x0) * u
                local y = 70 + i * 22 - math.sin(u * math.pi) * 18
                local sx = scr(nil, {f = F28.tr.f}, x, camL)
                if not __t(vis(nil, sx, 10)) then
                    continue
                end
                R(
                    nil,
                    c,
                    sx,
                    y,
                    5,
                    3,
                    "#8a8478"
                )
                R(
                    nil,
                    c,
                    sx + 4,
                    y - 2,
                    3,
                    3,
                    "#6a645a"
                )
                R(
                    nil,
                    c,
                    sx + 4,
                    y - 3,
                    1,
                    1,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    sx + 6,
                    y - 3,
                    1,
                    1,
                    "#f2efe6"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            sx - 1 - k,
                            y + 1 + math.floor(math.sin(k * 0.8 + t * 3) + 0.5),
                            1,
                            1,
                            if __t(__mod(k, 2)) then "#3a3630" else "#b8b0a2"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        if __lt(nt, 0.5) then
            c:save()
            c.globalCompositeOperation = "lighter"
            do
                local i = 0
                while i < 6 do
                    local x = __mod(
                        __mod(i * 157 - camL * 0.9, 700) + 700,
                        700
                    ) - 80
                    local a = (0.05 + math.sin(t * 0.4 + i) * 0.025) * (1 - nt * 2)
                    c.fillStyle = ("rgba(255,248,200," .. tostring(a)) .. ")"
                    c:beginPath()
                    c:moveTo(x, 0)
                    c:lineTo(x + 14, 0)
                    c:lineTo(x + 60, 220)
                    c:lineTo(x + 34, 220)
                    __call(c, "fill")
                    i = i + 1
                end
            end
            c:restore()
        end
        drawMid(nil, c, F28.mid, camL)
        do
            local x = p + 116 - camL
            if __t(vis(nil, x, 60)) then
                do
                    local k = 0
                    while k < 26 do
                        local y0 = 78 + __mod(t * 70 + k * 13, 110)
                        R(
                            nil,
                            c,
                            x + k,
                            78,
                            2,
                            118,
                            if __t(__mod(k, 4)) then "rgba(170,220,228,.55)" else "rgba(220,244,248,.7)"
                        )
                        R(
                            nil,
                            c,
                            x + k,
                            y0,
                            2,
                            6,
                            "rgba(255,255,255,.8)"
                        )
                        k = k + 2
                    end
                end
                do
                    local i = 0
                    while i < 8 do
                        local q = __mod(t * 0.6 + i / 8, 1)
                        ell(
                            nil,
                            c,
                            x + 13 + (i - 4) * 5 * q,
                            194 - q * 14,
                            3 + q * 6,
                            2 + q * 3,
                            ("rgba(240,250,250," .. tostring((1 - q) * 0.5)) .. ")"
                        )
                        i = i + 1
                    end
                end
                do
                    local k = 0
                    while k < 3 do
                        local r = __mod(t * 14 + k * 20, 60)
                        c.strokeStyle = ("rgba(190,235,230," .. tostring((1 - r / 60) * 0.5)) .. ")"
                        c:beginPath()
                        c:ellipse(
                            x + 13,
                            200,
                            r * 1.4,
                            r * 0.14,
                            0,
                            0,
                            TAU
                        )
                        c:stroke()
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = p + 248 - camL
            local puff = math.sin(t * 2.4) > 0.6
            if __t(vis(nil, x, 10)) then
                R(
                    nil,
                    c,
                    x,
                    188,
                    6,
                    4,
                    "#4a8a3a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    187,
                    1,
                    1,
                    "#f2c94c"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    187,
                    1,
                    1,
                    "#f2c94c"
                )
                if __t(puff) then
                    ell(
                        nil,
                        c,
                        x + 3,
                        192,
                        3,
                        2,
                        "#c8e0a0"
                    )
                end
            end
        end
        if __gt(nt, 0.3) then
            for ____, ____value in __iterar((POCO.ARV)) do
                local ax = ____value[1]
                local w = ____value[2]
                local x = ax + w / 2 - camL
                local ____t_11 = __t
                local ____t_10 = __t
                local ____vis_result_9 = vis(nil, x, 10)
                __O[453] = ____vis_result_9
                if ____t_11(if ____t_10(____vis_result_9) then __mod(
                    math.floor(t * 0.7 + ax),
                    5
                ) else __O[453]) then
                    R(
                        nil,
                        c,
                        x - 2,
                        116,
                        1,
                        1,
                        "#ffe24a"
                    )
                    R(
                        nil,
                        c,
                        x + 1,
                        116,
                        1,
                        1,
                        "#ffe24a"
                    )
                end
            end
        end
        do
            local i = 0
            while i < 4 do
                local x = __mod(i * 233 + t * 14, 900) - camL * 0 - 40 + math.sin(t * 0.8 + i) * 30
                local y = 130 + i * 18 + math.sin(t * 1.6 + i * 2) * 16
                local f = math.sin(t * 16 + i) > 0
                if __gt(nt, 0.6) then
                    break
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    3,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y + if __t(f) then 0 else 1,
                    3,
                    if __t(f) then 3 else 1,
                    "#3a8ae8"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y + if __t(f) then 0 else 1,
                    3,
                    if __t(f) then 3 else 1,
                    "#3a8ae8"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local k = __mod(t * 0.05 + i / 12, 1)
                local x = __mod(
                    __mod(i * 97 - camL * 0.9, 520) + 520,
                    520
                ) - 20 + math.sin(t * 1.3 + i) * 10
                local y = k * 230
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    pick(
                        nil,
                        __arrL({"#c8882a", "#a86a2a", "#7a9a3a", "#d8a83a"}, 4),
                        i
                    )
                )
                i = i + 1
            end
        end
        if __gt(nt, 0.2) then
            do
                local i = 0
                while i < 30 do
                    local x = __mod(
                        __mod(
                            hash(nil, i) * 700 - camL * 0.7,
                            600
                        ) + 600,
                        600
                    ) - 60 + math.sin(t * 0.7 + i) * 12
                    local y = 120 + hash(nil, i * 3) * 90 + math.sin(t * 0.9 + i * 2) * 8
                    if math.sin(t * 2 + i * 1.7) > 0.1 then
                        c.globalAlpha = nt
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#d8ff7a"
                        )
                        c.globalAlpha = 1
                    end
                    i = i + 1
                end
            end
        end
        fog(
            nil,
            c,
            s,
            t,
            camL,
            0.32
        )
    end
    local function pocoLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __gt(a, 0.2) then
            do
                local i = 0
                while i < 30 do
                    local x = __mod(
                        __mod(
                            hash(nil, i) * 700 - camL * 0.7,
                            600
                        ) + 600,
                        600
                    ) - 60 + math.sin(t * 0.7 + i) * 12
                    local y = 120 + hash(nil, i * 3) * 90 + math.sin(t * 0.9 + i * 2) * 8
                    if math.sin(t * 2 + i * 1.7) > 0.1 then
                        lightAdd(
                            nil,
                            x,
                            y,
                            0.25 * a,
                            10
                        )
                    end
                    i = i + 1
                end
            end
            local gx = POCO.GUARITA + 68 - camL
            if __t(vis(nil, gx)) then
                lightAdd(
                    nil,
                    gx,
                    175,
                    0.7 * a,
                    50
                )
            end
        end
    end
    local EST = __ord(
        {
            W = 2800,
            PORTAO = 650,
            BANCO = __arrL({1150, 1950}, 2),
            STX = 380,
            SW = 1500
        },
        "W,PORTAO,BANCO,STX,SW"
    )
    local F29 = {}
    local function PLACAR()
        local t = window.performance:now() / 1000
        local gols = math.floor(t / 45)
        return {
            a = 1 + math.floor((gols + 1) / 2),
            b = math.floor(gols / 2),
            gol = __mod(t, 45) < 4,
            min = 1 + math.floor(__mod(t * 1.5, 45))
        }
    end
    local function buildArquibancada(self)
        local SW = EST.SW
        local cv, c = table.unpack(
            mk(nil, SW, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, SW, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            60,
            SW,
            112,
            "#8a8e94"
        )
        do
            local r = 0
            while r < 14 do
                local y = 70 + r * 7
                R(
                    nil,
                    c,
                    0,
                    y,
                    SW,
                    7,
                    if __t(__mod(r, 2)) then "#9a9ea4" else "#8a8e94"
                )
                R(
                    nil,
                    c,
                    0,
                    y + 6,
                    SW,
                    1,
                    "#6a6e74"
                )
                r = r + 1
            end
        end
        do
            local k = 0
            while k < SW do
                R(
                    nil,
                    c,
                    k,
                    64,
                    6,
                    108,
                    "#6a6e74"
                )
                R(
                    nil,
                    c,
                    k + 1,
                    64,
                    1,
                    108,
                    "#a8acb2"
                )
                k = k + 220
            end
        end
        R(
            nil,
            c,
            0,
            48,
            SW,
            14,
            "#c8ccd2"
        )
        R(
            nil,
            c,
            0,
            48,
            SW,
            2,
            "#e8ecef"
        )
        do
            local k = 0
            while k < SW do
                R(
                    nil,
                    c,
                    k,
                    62,
                    3,
                    10,
                    "#7a7e84"
                )
                k = k + 30
            end
        end
        R(
            nil,
            c,
            0,
            60,
            SW,
            2,
            "#5a5e64"
        )
        R(
            nil,
            c,
            0,
            168,
            SW,
            12,
            "#2a2e34"
        )
        do
            local k = 0
            local i = 0
            while k < SW do
                local L = __get(
                    OUTDOORS,
                    __mod(
                        i,
                        __len(OUTDOORS)
                    )
                )
                R(
                    nil,
                    c,
                    k + 1,
                    169,
                    58,
                    10,
                    __get(L, 1)
                )
                pxText(
                    nil,
                    c,
                    __call(
                        __get(
                            __call(
                                __get(L, 0),
                                "split",
                                ":"
                            ),
                            0
                        ),
                        "slice",
                        0,
                        14
                    ),
                    k + 30,
                    171,
                    __get(L, 2)
                )
                do
                    k = k + 60
                    i = i + 1
                end
            end
        end
        for ____, fx in __iterar((__arrL({120, 520, 980, 1380}, 4))) do
            R(
                nil,
                c,
                fx,
                0,
                4,
                64,
                "#6a6e74"
            )
            R(
                nil,
                c,
                fx - 14,
                0,
                32,
                16,
                "#3a3e44"
            )
            do
                local k = 0
                while k < 6 do
                    do
                        local j = 0
                        while j < 2 do
                            R(
                                nil,
                                c,
                                fx - 12 + k * 5,
                                2 + j * 7,
                                4,
                                5,
                                "#e8eaec"
                            )
                            R(
                                nil,
                                n,
                                fx - 12 + k * 5,
                                2 + j * 7,
                                4,
                                5,
                                "#fffbe0"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        local px = 700
        R(
            nil,
            c,
            px - 60,
            4,
            120,
            40,
            "#1a1c20"
        )
        R(
            nil,
            c,
            px - 58,
            6,
            116,
            36,
            "#0c0e10"
        )
        R(
            nil,
            c,
            px - 4,
            44,
            8,
            16,
            "#5a5e64"
        )
        nevoa(nil, c, SW, "rgba(200,214,226,.12)")
        return {cv = cv, nv = nv}
    end
    local function torcida(self, c, x0, x1, y0, t, ola, pulo, rows)
        if rows == nil then
            rows = 13
        end
        do
            local r = 0
            while r < rows do
                local y = y0 + r * 7
                do
                    local x = x0 + __mod(r, 2) * 2
                    while __lt(x, x1) do
                        local i = math.floor(x * 7 + r * 13)
                        local sx = x
                        if __lt(
                            hash(nil, i),
                            0.18
                        ) then
                            continue
                        end
                        local up = if math.abs(sx - ola) < 18 then 3 else 0 + if __t(pulo) then math.floor(math.abs(math.sin(t * 9 + i)) * 2 + 0.5) else 0
                        R(
                            nil,
                            c,
                            sx,
                            y + 2 - up,
                            3,
                            3,
                            pick(
                                nil,
                                __arrL({
                                    "#e8433a",
                                    "#f2efe6",
                                    "#2c5a9e",
                                    "#e8c24c",
                                    "#e8433a",
                                    "#2a2a2a"
                                }, 6),
                                i
                            )
                        )
                        R(
                            nil,
                            c,
                            sx + 1,
                            y - up,
                            2,
                            2,
                            pick(nil, SKIN, i)
                        )
                        x = x + 4
                    end
                end
                r = r + 1
            end
        end
    end
    local function buildEstadio(self)
        local W = EST.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        local g = EST.PORTAO
        plaster(
            nil,
            c,
            0,
            40,
            g + 20,
            170,
            "#d8d4ca",
            290
        )
        do
            local k = 0
            while k < g + 20 do
                R(
                    nil,
                    c,
                    k,
                    40,
                    6,
                    170,
                    "#c4c0b6"
                )
                R(
                    nil,
                    c,
                    k,
                    40,
                    2,
                    170,
                    "#ece8de"
                )
                R(
                    nil,
                    c,
                    k + 5,
                    40,
                    1,
                    170,
                    "#a8a49a"
                )
                k = k + 24
            end
        end
        R(
            nil,
            c,
            0,
            34,
            g + 20,
            8,
            "#bcb8ae"
        )
        R(
            nil,
            c,
            0,
            34,
            g + 20,
            2,
            "#e8e4da"
        )
        do
            local k = 0
            while k < g do
                R(
                    nil,
                    c,
                    k + 10,
                    60,
                    30,
                    30,
                    "#2a2e34"
                )
                ell(
                    nil,
                    c,
                    k + 25,
                    60,
                    15,
                    7,
                    "#2a2e34"
                )
                R(
                    nil,
                    c,
                    k + 12,
                    62,
                    26,
                    26,
                    "rgba(120,150,170,.4)"
                )
                torcida(
                    nil,
                    c,
                    k + 12,
                    k + 37,
                    66,
                    0,
                    -99,
                    false,
                    3
                )
                k = k + 48
            end
        end
        R(
            nil,
            c,
            40,
            100,
            420,
            22,
            "#c43c3a"
        )
        R(
            nil,
            c,
            40,
            100,
            420,
            2,
            "#e85a4a"
        )
        R(
            nil,
            c,
            40,
            120,
            420,
            2,
            "#8a2a2a"
        )
        do
            local k = 0
            while k < 3 do
                local bx = 70 + k * 60
                R(
                    nil,
                    c,
                    bx,
                    150,
                    44,
                    34,
                    "#3a4048"
                )
                R(
                    nil,
                    c,
                    bx + 4,
                    154,
                    36,
                    18,
                    "#9fc4d0"
                )
                R(
                    nil,
                    c,
                    bx + 4,
                    172,
                    36,
                    4,
                    "#c8ccd0"
                )
                ell(
                    nil,
                    c,
                    bx + 22,
                    164,
                    4,
                    4,
                    pick(nil, SKIN, k)
                )
                R(
                    nil,
                    c,
                    bx + 18,
                    168,
                    8,
                    4,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    bx + 2,
                    140,
                    40,
                    8,
                    "#f2c94c"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 2 do
                local ex = 300 + k * 140
                R(
                    nil,
                    c,
                    ex,
                    172,
                    40,
                    30,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    ex,
                    172,
                    40,
                    3,
                    "#c4955c"
                )
                R(
                    nil,
                    c,
                    ex + 2,
                    166,
                    36,
                    6,
                    "#2a2a2a"
                )
                do
                    local j = 0
                    while j < 6 do
                        R(
                            nil,
                            c,
                            ex + 4 + j * 6,
                            165,
                            1,
                            6,
                            "#c8a24a"
                        )
                        R(
                            nil,
                            c,
                            ex + 3 + j * 6,
                            167,
                            3,
                            2,
                            pick(
                                nil,
                                __arrL({"#8a3a2a", "#c4743a"}, 2),
                                j
                            )
                        )
                        j = j + 1
                    end
                end
                ell(
                    nil,
                    c,
                    ex + 20,
                    150,
                    22,
                    6,
                    if __t(k) then "#2c5a9e" else "#e8433a"
                )
                R(
                    nil,
                    c,
                    ex + 19,
                    150,
                    2,
                    22,
                    "#5a5a56"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 5 do
                local jx = 520 + k * 18
                R(
                    nil,
                    c,
                    jx,
                    140,
                    1,
                    4,
                    "#5a5a56"
                )
                R(
                    nil,
                    c,
                    jx - 6,
                    144,
                    14,
                    16,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#f2efe6", "#2c5a9e"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    jx - 8,
                    144,
                    3,
                    7,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#f2efe6", "#2c5a9e"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    jx + 7,
                    144,
                    3,
                    7,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#f2efe6", "#2c5a9e"}, 3),
                        k
                    )
                )
                pxText(
                    nil,
                    c,
                    tostring(k + 7),
                    jx + 1,
                    149,
                    "#2a2a2a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            512,
            138,
            96,
            2,
            "#5a5a56"
        )
        R(
            nil,
            c,
            g - 10,
            30,
            40,
            180,
            "#a8aca8"
        )
        R(
            nil,
            c,
            g - 6,
            120,
            32,
            90,
            "#2a2e34"
        )
        do
            local k = 0
            while k < 32 do
                R(
                    nil,
                    c,
                    g - 6 + k,
                    120,
                    2,
                    90,
                    "#5a6066"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            g - 10,
            106,
            40,
            12,
            "#2c5a9e"
        )
        do
            local k = 0
            while k < 2 do
                R(
                    nil,
                    c,
                    g + 40 + k * 18,
                    186,
                    4,
                    24,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    g + 36 + k * 18,
                    196,
                    12,
                    2,
                    "#c8ccd0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            g + 30,
            206,
            W - g - 30,
            4,
            "#3a6a3a"
        )
        R(
            nil,
            c,
            g + 30,
            206,
            W - g - 30,
            1,
            "#5a9a4a"
        )
        do
            local x = g + 30
            local i = 0
            while x < W do
                local L = __get(
                    OUTDOORS,
                    __mod(
                        i + 3,
                        __len(OUTDOORS)
                    )
                )
                R(
                    nil,
                    c,
                    x,
                    198,
                    70,
                    10,
                    "#1c1e22"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    199,
                    68,
                    8,
                    __get(L, 1)
                )
                pxText(
                    nil,
                    c,
                    __call(
                        __get(
                            __call(
                                __get(L, 0),
                                "split",
                                ":"
                            ),
                            0
                        ),
                        "slice",
                        0,
                        16
                    ),
                    x + 35,
                    200,
                    __get(L, 2)
                )
                do
                    x = x + 72
                    i = i + 1
                end
            end
        end
        for ____, bx in __iterar((EST.BANCO)) do
            R(
                nil,
                c,
                bx,
                172,
                100,
                4,
                "#c8ccd0"
            )
            do
                local k = 0
                while k < 100 do
                    R(
                        nil,
                        c,
                        bx + k,
                        176,
                        2,
                        30,
                        "#9aa0a6"
                    )
                    k = k + 10
                end
            end
            R(
                nil,
                c,
                bx,
                172,
                100,
                30,
                "rgba(180,220,240,.35)"
            )
            do
                local k = 0
                while k < 7 do
                    local px = bx + 8 + k * 13
                    R(
                        nil,
                        c,
                        px,
                        190,
                        8,
                        6,
                        "#2c5a9e"
                    )
                    R(
                        nil,
                        c,
                        px + 1,
                        182,
                        7,
                        8,
                        if __t(__mod(k, 3)) then "#e8433a" else "#f2c94c"
                    )
                    R(
                        nil,
                        c,
                        px + 2,
                        177,
                        5,
                        5,
                        pick(nil, SKIN, k + 2)
                    )
                    k = k + 1
                end
            end
        end
        local cx = 1580
        R(
            nil,
            c,
            cx,
            186,
            2,
            20,
            "#3a3a36"
        )
        R(
            nil,
            c,
            cx - 6,
            206,
            14,
            2,
            "#3a3a36"
        )
        R(
            nil,
            c,
            cx - 8,
            176,
            18,
            10,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            cx + 10,
            179,
            5,
            4,
            "#1a1a1a"
        )
        pxText(
            nil,
            c,
            "TV",
            cx + 1,
            178,
            "#c43c3a"
        )
        R(
            nil,
            c,
            0,
            210,
            g + 30,
            10,
            "#d0c8b6"
        )
        asfalto(nil, c, g + 30)
        R(
            nil,
            c,
            g + 30,
            210,
            W - g - 30,
            LH - 210,
            "#b4523a"
        )
        do
            local y = 222
            while y < LH do
                R(
                    nil,
                    c,
                    g + 30,
                    y,
                    W - g - 30,
                    1,
                    "#f2e8dc"
                )
                y = y + 12
            end
        end
        do
            local i = 0
            while i < W * 2 do
                local x = g + 30 + hash(nil, i * 1.7) * (W - g - 30)
                R(
                    nil,
                    c,
                    x,
                    210 + hash(nil, i * 2.9) * 60,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "#a44a32" else "#c45e44"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            g + 30,
            210,
            W - g - 30,
            2,
            "#e8e4dc"
        )
        return cv
    end
    local function estadio(self, c, s, t, camL)
        if not __t(F29.mid) then
            F29.arq = buildArquibancada(nil)
            F29.mid = buildEstadio(nil)
        end
        local nt = night(nil, s)
        local P = PLACAR(nil)
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 29, birds = true}
        )
        local ax = EST.STX - camL * 0.55
        if __t(ax + EST.SW > 0 and ax < LW) then
            c:save()
            c:translate(0, -18)
            c:drawImage(
                F29.arq.cv,
                math.floor(ax + 0.5),
                0
            )
            local ola = __mod(t * 120, EST.SW + 400) - 200 + ax
            local pulo = P.gol
            torcida(
                nil,
                c,
                math.max(0, ax),
                math.min(LW, ax + EST.SW),
                74,
                t,
                ola,
                pulo
            )
            if __gt(nt, 0.05) then
                c:save()
                c.globalCompositeOperation = "lighter"
                c.globalAlpha = nt
                c:drawImage(
                    F29.arq.nv,
                    math.floor(ax + 0.5),
                    0
                )
                c:restore()
            end
            c:restore()
            do
                local px = ax + 700
                R(
                    nil,
                    c,
                    px - 56,
                    8,
                    112,
                    32,
                    "#0c0e10"
                )
                pxText(
                    nil,
                    c,
                    "PLANALTO",
                    px - 30,
                    12,
                    "#ffa83a"
                )
                pxText(
                    nil,
                    c,
                    "CACAUEIROS",
                    px + 28,
                    12,
                    "#ffa83a"
                )
                pxText(
                    nil,
                    c,
                    (tostring(P.a) .. " X ") .. tostring(P.b),
                    px,
                    22,
                    "#ffe39a",
                    {s = 2}
                )
                pxText(
                    nil,
                    c,
                    if __t(P.gol) then "GOOOL!" else ("2T " .. tostring(P.min)) .. "'",
                    px,
                    33,
                    if __t(if __t(P.gol) then __mod(
                        math.floor(t * 6),
                        2
                    ) else P.gol) then "#ff5a5a" else "#8ae08a"
                )
            end
            if __t(P.gol) then
                do
                    local i = 0
                    while i < 4 do
                        local fx = ax + 200 + i * 300
                        do
                            local k = 0
                            while k < 8 do
                                local q = __mod(t * 0.8 + k / 8, 1)
                                ell(
                                    nil,
                                    c,
                                    fx + math.sin(k + t) * 6,
                                    76 - q * 50,
                                    4 + q * 8,
                                    3 + q * 5,
                                    ("rgba(230,70,60," .. tostring((1 - q) * 0.45)) .. ")"
                                )
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
            end
            local gx = __TS__Number(-camL) * 0.75
            do
                local k = 0
                while k < 40 do
                    local x = math.floor(gx + k * 60 + 500 + 0.5)
                    local w = 60
                    if __t(x > LW or x + w < 0) then
                        continue
                    end
                    R(
                        nil,
                        c,
                        math.max(x, ax + 0),
                        162,
                        w,
                        38,
                        if __t(__mod(k, 2)) then "#4a8a3e" else "#56984a"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                math.max(0, ax),
                162,
                LW,
                1,
                "#f2f2ee"
            )
            R(
                nil,
                c,
                math.max(0, ax),
                180,
                LW,
                1,
                "rgba(255,255,255,.35)"
            )
            do
                local mx = gx + 500 + 60 * 16
                if __t(vis(nil, mx, 40)) then
                    R(
                        nil,
                        c,
                        mx,
                        162,
                        1,
                        38,
                        "rgba(255,255,255,.6)"
                    )
                    c.strokeStyle = "rgba(255,255,255,.6)"
                    c:beginPath()
                    c:ellipse(
                        mx,
                        180,
                        26,
                        6,
                        0,
                        0,
                        TAU
                    )
                    c:stroke()
                end
            end
            for ____, gxx in __iterar((__arrL({500 + 60 * 2, 500 + 60 * 30}, 2))) do
                local x = gx + gxx
                if __t(vis(nil, x, 20)) then
                    R(
                        nil,
                        c,
                        x,
                        164,
                        2,
                        16,
                        "#f2f2ee"
                    )
                    R(
                        nil,
                        c,
                        x + 14,
                        164,
                        2,
                        16,
                        "#f2f2ee"
                    )
                    R(
                        nil,
                        c,
                        x,
                        164,
                        16,
                        2,
                        "#f2f2ee"
                    )
                    do
                        local k = 2
                        while k < 14 do
                            R(
                                nil,
                                c,
                                x + k,
                                166,
                                1,
                                14,
                                "rgba(255,255,255,.4)"
                            )
                            k = k + 3
                        end
                    end
                end
            end
            local bxw = 500 + 60 * 16 + math.sin(t * 0.37) * 600 + math.sin(t * 1.1) * 80
            local by = 182 + math.sin(t * 2.3) * 8 - math.abs(math.sin(t * 3.1)) * 5
            do
                local i = 0
                while i < 12 do
                    local home = 500 + 60 * (4 + i * 2.2)
                    local px = home + (bxw - home) * 0.35 + math.sin(t * 0.8 + i) * 30
                    local sx = gx + px
                    local y = 172 + __mod(i, 5) * 5
                    local f = __mod(
                        math.floor(t * 8 + i),
                        2
                    )
                    if not __t(vis(nil, sx, 6)) then
                        continue
                    end
                    R(
                        nil,
                        c,
                        sx,
                        y - 6,
                        3,
                        4,
                        if __t(__mod(i, 2)) then "#e8433a" else "#f2c94c"
                    )
                    R(
                        nil,
                        c,
                        sx,
                        y - 2,
                        1,
                        2 + f,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        y - 2,
                        1,
                        3 - f,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx,
                        y - 8,
                        3,
                        2,
                        pick(nil, SKIN, i)
                    )
                    i = i + 1
                end
            end
            do
                local sx = gx + bxw
                if __t(vis(nil, sx, 4)) then
                    R(
                        nil,
                        c,
                        sx,
                        by,
                        2,
                        2,
                        "#ffffff"
                    )
                end
                local ax2 = gx + bxw - 40 + math.sin(t * 0.5) * 20
                R(
                    nil,
                    c,
                    ax2,
                    182,
                    3,
                    6,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    ax2,
                    180,
                    3,
                    2,
                    pick(nil, SKIN, 3)
                )
            end
        end
        drawMid(nil, c, F29.mid, camL)
        do
            local k = 0
            while k < 5 do
                local x = 90 - camL + k * 11
                local bob = math.floor(math.sin(t * 1.4 + k) * 0.6 + 0.5)
                if __t(vis(nil, x, 10)) then
                    pessoa(
                        nil,
                        c,
                        x,
                        208 + bob,
                        k + 7
                    )
                end
                k = k + 1
            end
        end
        for ____, ex in __iterar((__arrL({300, 440}, 2))) do
            local x = ex + 20 - camL
            if __t(vis(nil, x, 30)) then
                do
                    local i = 0
                    while i < 6 do
                        local q = __mod(t * 0.4 + i / 6, 1)
                        ell(
                            nil,
                            c,
                            x + math.sin(t + i) * 3,
                            162 - q * 30,
                            2 + q * 4,
                            2 + q * 2,
                            ("rgba(230,230,226," .. tostring((1 - q) * 0.45)) .. ")"
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local x = __get(EST.BANCO, 0) + 112 - camL
            local arm = math.sin(t * 5)
            if __t(vis(nil, x, 20)) then
                gente(
                    nil,
                    c,
                    x,
                    208,
                    4,
                    false
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 6, 196}, 2),
                            __arrL({x + 12, 190 - arm * 4}, 2)
                        },
                        2
                    ),
                    1,
                    pick(nil, SKIN, 4)
                )
                if __t(__mod(
                    math.floor(t / 3),
                    2
                )) then
                    balao(
                        nil,
                        c,
                        x + 4,
                        186,
                        "MARCA ESSE CARA!"
                    )
                end
            end
        end
        do
            local x = 1700 - camL + math.sin(t * 0.6) * 30
            local j = math.abs(math.sin(t * 6)) * 4
            if __t(vis(nil, x, 20)) then
                R(
                    nil,
                    c,
                    x,
                    186 - j,
                    12,
                    14,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    178 - j,
                    8,
                    8,
                    "#e8e2d0"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    174 - j,
                    2,
                    4,
                    "#c8a24a"
                )
                R(
                    nil,
                    c,
                    x + 9,
                    174 - j,
                    2,
                    4,
                    "#c8a24a"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    181 - j,
                    1,
                    1,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    181 - j,
                    1,
                    1,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    184 - j,
                    4,
                    3,
                    "#d8c8b0"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    200 - j,
                    3,
                    8,
                    "#e8433a"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    200 - j,
                    3,
                    8,
                    "#e8433a"
                )
                pxText(
                    nil,
                    c,
                    "BODAO",
                    x + 6,
                    189 - j,
                    "#e8433a"
                )
            end
        end
        fog(
            nil,
            c,
            s,
            t,
            camL,
            0.12
        )
    end
    local function estadioLights(self, g, s, t, camL)
        local a = night(nil, s)
        local ax = EST.STX - camL * 0.55
        if __gt(a, 0.05) then
            for ____, fx in __iterar((__arrL({120, 520, 980, 1380}, 4))) do
                local sx = ax + fx
                if __t(sx < -200 or sx > LW + 200) then
                    continue
                end
                lightAdd(
                    nil,
                    sx,
                    10,
                    a,
                    120
                )
                local gr = g:createLinearGradient(0, 10, 0, 220)
                gr:addColorStop(
                    0,
                    ("rgba(255,252,230," .. tostring(0.22 * a)) .. ")"
                )
                gr:addColorStop(1, "rgba(255,252,230,0)")
                g.fillStyle = gr
                g:beginPath()
                g:moveTo(sx - 10, 10)
                g:lineTo(sx + 14, 10)
                g:lineTo(sx + 160, 220)
                g:lineTo(sx - 150, 220)
                __call(g, "fill")
            end
        end
    end
    local function torcidaFrente(self, c, camLk, t)
        local P = PLACAR(nil)
        local x0 = (EST.PORTAO + 40) * 1.45
        do
            local px = x0
            while px < EST.W * 1.45 do
                local sx = px - camLk
                if __t(sx < -20 or sx > LW + 20) then
                    continue
                end
                local i = math.floor(px)
                local up = if __t(P.gol) then math.abs(math.sin(t * 8 + i)) * 4 else math.max(
                    0,
                    math.sin(t * 2 + i * 0.3)
                ) * 1.5
                R(
                    nil,
                    c,
                    sx,
                    LH - 10 - up,
                    8,
                    12,
                    pick(
                        nil,
                        __arrL({
                            "#c43c3a",
                            "#e8e2d0",
                            "#2c4a7a",
                            "#c43c3a",
                            "#1c1c1c"
                        }, 5),
                        i
                    )
                )
                ell(
                    nil,
                    c,
                    sx + 4,
                    LH - 13 - up,
                    4,
                    4,
                    pick(
                        nil,
                        __arrL({"#1c1612", "#3a2a1a", "#6a4a2a", "#2a201a"}, 4),
                        i
                    )
                )
                if __t(if __t(P.gol) then P.gol else __gt(
                    hash(nil, i),
                    0.8
                )) then
                    R(
                        nil,
                        c,
                        sx - 1,
                        LH - 22 - up,
                        2,
                        10,
                        pick(nil, SKIN, i)
                    )
                    R(
                        nil,
                        c,
                        sx + 8,
                        LH - 22 - up,
                        2,
                        10,
                        pick(nil, SKIN, i)
                    )
                end
                if __mod(i, 11) == 3 then
                    R(
                        nil,
                        c,
                        sx + 3,
                        LH - 46,
                        1,
                        36,
                        "#3a3a36"
                    )
                    do
                        local k = 0
                        while k < 16 do
                            R(
                                nil,
                                c,
                                sx + 4 + k,
                                LH - 46 + math.floor(math.sin(t * 6 + k * 0.5) * 2 + 0.5),
                                1,
                                12,
                                if k < 8 then "#c43c3a" else "#f2efe6"
                            )
                            k = k + 1
                        end
                    end
                end
                px = px + 9
            end
        end
    end
    local ROD = __ord(
        {
            W = 2400,
            HALL = 1250,
            BAYS = __arrL({
                1300,
                1450,
                1600,
                1750,
                1900,
                2050,
                2200
            }, 7)
        },
        "W,HALL,BAYS"
    )
    local EMPRESAS = __arrL(
        {
            __arrL({"NOVO HORIZONTINHO", "#2c5a9e", "#f2c94c"}, 3),
            __arrL({"AGUIA BRANQUINHA", "#f2f2ee", "#2c5a9e"}, 3),
            __arrL({"SAO GERALDINHO", "#c43c3a", "#ffffff"}, 3),
            __arrL({"RAPIDO FEDERALZINHO", "#3c8a5a", "#ffffff"}, 3),
            __arrL({"GONTIJINHO", "#e8833a", "#ffffff"}, 3),
            __arrL({"CAMURUJIPINHO", "#7a3a8a", "#f2c94c"}, 3)
        },
        6
    )
    local DESTINOS = __arrL(
        {
            __arrL({"SALVADOR", "22:30"}, 2),
            __arrL({"ITABUNA", "14:10"}, 2),
            __arrL({"JEQUIE", "15:45"}, 2),
            __arrL({"BRUMADO", "16:20"}, 2),
            __arrL({"ILHEUS", "17:00"}, 2),
            __arrL({"BELO HORIZONTE", "19:15"}, 2),
            __arrL({"SAO PAULO", "20:40"}, 2),
            __arrL({"FEIRA DE SANTANA", "21:05"}, 2)
        },
        8
    )
    local F30 = {}
    local function onibus(self, c, x, y, E, dest, aberto)
        local nome, cor, cor2 = table.unpack(E, 1, 3)
        R(
            nil,
            c,
            x + 4,
            y,
            104,
            3,
            "rgba(0,0,0,.25)"
        )
        R(
            nil,
            c,
            x,
            y - 44,
            112,
            40,
            cor
        )
        R(
            nil,
            c,
            x,
            y - 44,
            112,
            2,
            shadeHex(nil, cor, 1.2)
        )
        R(
            nil,
            c,
            x + 2,
            y - 40,
            108,
            13,
            "#24303a"
        )
        do
            local k = 0
            while k < 7 do
                R(
                    nil,
                    c,
                    x + 18 + k * 13,
                    y - 39,
                    11,
                    11,
                    "#3a5a6a"
                )
                R(
                    nil,
                    c,
                    x + 19 + k * 13,
                    y - 39,
                    3,
                    11,
                    "rgba(255,255,255,.18)"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 2,
            y - 40,
            12,
            18,
            "#4a6a7a"
        )
        R(
            nil,
            c,
            x + 2,
            y - 47,
            30,
            4,
            "#14161a"
        )
        pxText(
            nil,
            c,
            dest,
            x + 17,
            y - 47,
            "#ffa83a"
        )
        R(
            nil,
            c,
            x,
            y - 24,
            112,
            4,
            cor2
        )
        pxText(
            nil,
            c,
            nome,
            x + 62,
            y - 18,
            if shadeHex(nil, cor, 0.55) == cor then "#2a2a2a" else if cor == "#f2f2ee" then "#2c5a9e" else "#ffffff"
        )
        R(
            nil,
            c,
            x + 4,
            y - 20,
            12,
            18,
            if __t(aberto) then "#1c2228" else "#3a4a54"
        )
        R(
            nil,
            c,
            x + 40,
            y - 12,
            50,
            9,
            if __t(aberto) then "#1a1a1e" else shadeHex(nil, cor, 0.85)
        )
        R(
            nil,
            c,
            x - 1,
            y - 10,
            3,
            3,
            "#fff2b0"
        )
        R(
            nil,
            c,
            x + 110,
            y - 12,
            2,
            4,
            "#e8433a"
        )
        for ____, wx in __iterar((__arrL({x + 22, x + 92}, 2))) do
            ell(
                nil,
                c,
                wx,
                y - 3,
                6,
                6,
                "#1c1c1c"
            )
            ell(
                nil,
                c,
                wx,
                y - 3,
                3,
                3,
                "#9aa0a6"
            )
        end
        if __t(aberto) then
            do
                local k = 0
                while k < 4 do
                    R(
                        nil,
                        c,
                        x + 44 + k * 11,
                        y - 10,
                        9,
                        7,
                        pick(
                            nil,
                            __arrL({
                                "#c43c3a",
                                "#2c4a6a",
                                "#e8c24c",
                                "#4a8a5a",
                                "#7a3a8a"
                            }, 5),
                            k + x
                        )
                    )
                    k = k + 1
                end
            end
        end
    end
    local function buildRodo(self)
        local W = ROD.W
        local H = ROD.HALL
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            0,
            H,
            24,
            "#c8c4ba"
        )
        R(
            nil,
            c,
            0,
            22,
            H,
            3,
            "#8a8a84"
        )
        do
            local x = 20
            while x < H do
                R(
                    nil,
                    c,
                    x,
                    14,
                    30,
                    4,
                    "#fff6d8"
                )
                x = x + 60
            end
        end
        plaster(
            nil,
            c,
            0,
            25,
            H,
            185,
            "#e2ddd0",
            300
        )
        do
            local x = 0
            while x < H do
                c:clearRect(x + 14, 32, 102, 40)
                R(
                    nil,
                    c,
                    x + 12,
                    30,
                    106,
                    2,
                    "#5a6066"
                )
                R(
                    nil,
                    c,
                    x + 12,
                    72,
                    106,
                    2,
                    "#5a6066"
                )
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x + 12 + k * 35,
                            30,
                            2,
                            44,
                            "#5a6066"
                        )
                        k = k + 1
                    end
                end
                x = x + 130
            end
        end
        A:azulejo(
            c,
            0,
            120,
            H,
            90,
            "#e8e4da",
            "#d8d2c4"
        )
        R(
            nil,
            c,
            0,
            118,
            H,
            3,
            "#2c5a9e"
        )
        __call(
            EMPRESAS,
            "forEach",
            function(____, E, i)
                local x = 30 + i * 132
                local nome, cor, letra = table.unpack(E, 1, 3)
                R(
                    nil,
                    c,
                    x,
                    128,
                    120,
                    82,
                    "#5a6066"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    130,
                    116,
                    12,
                    cor
                )
                R(
                    nil,
                    c,
                    x + 2,
                    130,
                    116,
                    1,
                    shadeHex(nil, cor, 1.3)
                )
                pxText(
                    nil,
                    c,
                    nome,
                    x + 60,
                    133,
                    letra
                )
                do
                    local k = 0
                    while k < 2 do
                        local gx = x + 8 + k * 56
                        R(
                            nil,
                            c,
                            gx,
                            148,
                            48,
                            30,
                            "#9fc4d0"
                        )
                        R(
                            nil,
                            c,
                            gx + 1,
                            149,
                            46,
                            3,
                            "rgba(255,255,255,.4)"
                        )
                        ell(
                            nil,
                            c,
                            gx + 24,
                            162,
                            5,
                            5,
                            pick(nil, SKIN, i + k)
                        )
                        R(
                            nil,
                            c,
                            gx + 18,
                            167,
                            12,
                            11,
                            pick(nil, ROUPA, i * 2 + k)
                        )
                        R(
                            nil,
                            c,
                            gx + 18,
                            170,
                            12,
                            1,
                            cor
                        )
                        R(
                            nil,
                            c,
                            gx - 1,
                            178,
                            50,
                            4,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            c,
                            gx + 18,
                            152,
                            12,
                            3,
                            "#2a2a2a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    182,
                    120,
                    28,
                    "#7a8086"
                )
            end
        )
        R(
            nil,
            c,
            820,
            36,
            170,
            72,
            "#14161a"
        )
        R(
            nil,
            c,
            822,
            38,
            166,
            10,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "PARTIDAS",
            905,
            40,
            "#ffffff"
        )
        local lx = 1010
        R(
            nil,
            c,
            lx,
            120,
            110,
            90,
            "#c47a35"
        )
        R(
            nil,
            c,
            lx + 4,
            124,
            102,
            14,
            "#8a4a20"
        )
        R(
            nil,
            c,
            lx + 6,
            142,
            98,
            26,
            "#f2e8d0"
        )
        do
            local k = 0
            while k < 6 do
                ell(
                    nil,
                    c,
                    lx + 14 + k * 15,
                    156,
                    4,
                    5,
                    "#d8943a"
                )
                R(
                    nil,
                    c,
                    lx + 12 + k * 15,
                    150,
                    3,
                    2,
                    "#c47a35"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            lx,
            168,
            110,
            4,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            lx,
            172,
            110,
            38,
            "#8a4a20"
        )
        pxText(
            nil,
            c,
            "COXINHA DO TERMINAL",
            lx + 55,
            128,
            "#fff6d0"
        )
        R(
            nil,
            c,
            1140,
            150,
            50,
            60,
            "#2c5a8a"
        )
        R(
            nil,
            c,
            1138,
            146,
            54,
            5,
            "#1d4070"
        )
        do
            local k = 0
            while k < 12 do
                R(
                    nil,
                    c,
                    1143 + __mod(k, 6) * 7.5,
                    154 + math.floor(k / 6) * 14,
                    6,
                    11,
                    pick(
                        nil,
                        __arrL({
                            "#d9634a",
                            "#e8c24c",
                            "#5f9fd0",
                            "#f2efe6",
                            "#c86ab8"
                        }, 5),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1196,
            130,
            50,
            80,
            "#8a949a"
        )
        do
            local k = 0
            while k < 8 do
                R(
                    nil,
                    c,
                    1198 + __mod(k, 2) * 24,
                    132 + math.floor(k / 2) * 19,
                    22,
                    17,
                    "#a8b0b6"
                )
                R(
                    nil,
                    c,
                    1216 + __mod(k, 2) * 24,
                    140 + math.floor(k / 2) * 19,
                    2,
                    3,
                    "#5a5e62"
                )
                k = k + 1
            end
        end
        pxText(
            nil,
            c,
            "GUARDA-VOLUMES",
            1221,
            122,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            790,
            128,
            24,
            20,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "WC",
            802,
            131,
            "#ffffff"
        )
        pxText(
            nil,
            c,
            "R$1",
            802,
            139,
            "#f2c94c"
        )
        do
            local r = 0
            while r < 3 do
                do
                    local k = 0
                    while k < 6 do
                        local x = 60 + r * 300 + k * 13
                        R(
                            nil,
                            c,
                            x,
                            196,
                            11,
                            4,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            c,
                            x,
                            186,
                            11,
                            10,
                            "#4f80b0"
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            200,
                            1,
                            10,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            c,
                            x + 9,
                            200,
                            1,
                            10,
                            "#5a5e62"
                        )
                        k = k + 1
                    end
                end
                r = r + 1
            end
        end
        R(
            nil,
            c,
            H - 20,
            26,
            W - H + 20,
            18,
            "#b8b4aa"
        )
        R(
            nil,
            c,
            H - 20,
            26,
            W - H + 20,
            3,
            "#d8d4ca"
        )
        R(
            nil,
            c,
            H - 20,
            44,
            W - H + 20,
            4,
            "#8a8680"
        )
        do
            local x = H + 20
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    46,
                    18,
                    2,
                    "#fff6d8"
                )
                x = x + 50
            end
        end
        __call(
            ROD.BAYS,
            "forEach",
            function(____, bx, i)
                R(
                    nil,
                    c,
                    bx - 6,
                    48,
                    6,
                    162,
                    "#c8c4ba"
                )
                R(
                    nil,
                    c,
                    bx - 6,
                    48,
                    2,
                    162,
                    "#e8e4da"
                )
                R(
                    nil,
                    c,
                    bx - 18,
                    60,
                    30,
                    16,
                    "#2c5a9e"
                )
                pxText(
                    nil,
                    c,
                    tostring(i + 1),
                    bx - 3,
                    62,
                    "#ffffff",
                    {s = 2}
                )
            end
        )
        R(
            nil,
            c,
            H,
            196,
            W - H,
            14,
            "#cfc8b6"
        )
        do
            local x = H
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    206,
                    6,
                    3,
                    "#e8c24c"
                )
                x = x + 12
            end
        end
        pisoInterno(
            nil,
            c,
            W,
            "#d8d2c4",
            "#c2bcae",
            22
        )
        return cv
    end
    local function rodo(self, c, s, t, camL)
        if not __t(F30.mid) then
            F30.mid = buildRodo(nil)
            F30.rua = buildRua(
                nil,
                {
                    seed = 300,
                    base = 168,
                    f = __arrL({2, 6}, 2),
                    w = __arrL({26, 44}, 2),
                    pal = __arrL({"#ebe8de", "#e0d6c2", "#dfe6ea"}, 3),
                    lojas = K.LOJAS_RUA,
                    lojaIni = 4,
                    lojaChance = 0.7,
                    outdoors = 4,
                    outIni = 5,
                    rua = true,
                    gente = 16
                }
            )
        end
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 30}
        )
        tile(nil, c, F30.rua.cv, camL * F30.rua.f)
        noiteTile(
            nil,
            c,
            s,
            F30.rua.nv,
            camL * F30.rua.f
        )
        andaRua(
            nil,
            c,
            F30.rua,
            s,
            t,
            camL
        )
        __call(
            ROD.BAYS,
            "forEach",
            function(____, bx, i)
                local cyc = 34 + i * 3
                local ph = __mod(t + i * 9, cyc) / cyc
                local E = __get(
                    EMPRESAS,
                    __mod(
                        i + math.floor((t + i * 9) / cyc),
                        __len(EMPRESAS)
                    )
                )
                local dest = __get(
                    __get(
                        DESTINOS,
                        __mod(
                            i * 3 + math.floor((t + i * 9) / cyc),
                            __len(DESTINOS)
                        )
                    ),
                    0
                )
                local x = bx + 4
                local aberto = false
                if ph < 0.15 then
                    x = x + (1 - ph / 0.15) * 520
                elseif ph > 0.85 then
                    x = x - (ph - 0.85) / 0.15 * 700
                else
                    aberto = ph > 0.22 and ph < 0.78
                end
                local sx = x - camL
                if not __t(vis(nil, sx, 120)) then
                    return
                end
                onibus(
                    nil,
                    c,
                    sx,
                    196,
                    E,
                    dest,
                    aberto
                )
                if __t(aberto) then
                    do
                        local k = 0
                        while k < 3 do
                            local q = __mod(t * 0.25 + k / 3, 1)
                            local px = sx + 10 + q * -0
                            pessoinha(
                                nil,
                                c,
                                sx - 6 - k * 6,
                                196,
                                i * 3 + k,
                                t,
                                false
                            )
                            k = k + 1
                        end
                    end
                end
            end
        )
        drawMid(nil, c, F30.mid, camL)
        do
            local x = 820 - camL
            if __t(vis(nil, x, 180)) then
                do
                    local r = 0
                    while r < 7 do
                        local D = __get(
                            DESTINOS,
                            __mod(
                                r + math.floor(t / 8),
                                __len(DESTINOS)
                            )
                        )
                        local y = 51 + r * 8
                        local st = if r == 0 then if __t(__mod(
                            math.floor(t * 2),
                            2
                        )) then "EMBARQUE" else "" else if r == 3 then "ATRASADO" else "NO HORARIO"
                        pxText(
                            nil,
                            c,
                            __get(D, 0),
                            x + 4,
                            y,
                            "#f2c94c",
                            {align = "left"}
                        )
                        pxText(
                            nil,
                            c,
                            __get(D, 1),
                            x + 104,
                            y,
                            "#e8eaec",
                            {align = "left"}
                        )
                        pxText(
                            nil,
                            c,
                            st,
                            x + 164,
                            y,
                            if r == 3 then "#ff6a5a" else "#6ae08a",
                            {align = "right"}
                        )
                        r = r + 1
                    end
                end
            end
        end
        local nt = night(nil, s)
        do
            local i = 0
            while i < 6 do
                local x = __mod(
                    i * 113 + math.sin(t * 0.5 + i) * 20,
                    1100
                ) + 40 - camL
                local hop = math.max(
                    0,
                    math.sin(t * 4 + i * 2)
                ) * 2
                if __t(vis(nil, x, 6)) then
                    R(
                        nil,
                        c,
                        x,
                        216 - hop,
                        5,
                        3,
                        "#8a8f98"
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        214 - hop + if math.sin(t * 6 + i) > 0.5 then 2 else 0,
                        2,
                        2,
                        "#6a6f78"
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 66 + 26 - camL
            if __t(vis(nil, x, 20)) then
                R(
                    nil,
                    c,
                    x,
                    180,
                    24,
                    8,
                    "#3a4a6a"
                )
                ell(
                    nil,
                    c,
                    x + 3,
                    182,
                    3,
                    3,
                    "#9a6440"
                )
                pxText(
                    nil,
                    c,
                    "Z",
                    x + 8 + math.sin(t * 2) * 2,
                    170 - __mod(t * 4, 8),
                    "#5a6a8a"
                )
            end
        end
        do
            local x = 400 - camL + math.sin(t * 0.2) * 120
            if __t(vis(nil, x, 20)) then
                gente(
                    nil,
                    c,
                    x,
                    216,
                    6
                )
                R(
                    nil,
                    c,
                    x + 6,
                    200,
                    6,
                    8,
                    "#c8a06a"
                )
                if __mod(
                    math.floor(t / 2.5),
                    3
                ) == 0 then
                    balao(
                        nil,
                        c,
                        x + 3,
                        192,
                        "OLHA O AMENDOIM!"
                    )
                end
            end
        end
        if __mod(
            math.floor(t / 12),
            2
        ) == 0 then
            local msg = "ATENCAO, PASSAGEIROS COM DESTINO A SALVADOR: EMBARQUE NA PLATAFORMA 1"
            local w = largura(nil, msg)
            local x = 820 + 168 - __mod(t * 30, w + 170) - camL
            c:save()
            c:beginPath()
            c:rect(820 - camL + 2, 100, 166, 7)
            c:clip()
            R(
                nil,
                c,
                820 - camL + 2,
                100,
                166,
                7,
                "#0c0e10"
            )
            pxText(
                nil,
                c,
                msg,
                x,
                101,
                "#ffa83a",
                {align = "left"}
            )
            c:restore()
        end
        local ____ = nt
    end
    local function rodoLights(self, g, s, t, camL)
        do
            local x = 20
            while x < ROD.HALL do
                local sx = x + 15 - camL
                if __t(vis(nil, sx)) then
                    lightAdd(
                        nil,
                        sx,
                        16,
                        0.25,
                        50
                    )
                end
                x = x + 60
            end
        end
        local a = night(nil, s)
        if __gt(a, 0.05) then
            do
                local x = ROD.HALL + 20
                while x < ROD.W do
                    local sx = x + 9 - camL
                    if __t(vis(nil, sx)) then
                        lightAdd(
                            nil,
                            sx,
                            47,
                            0.5 * a,
                            60
                        )
                    end
                    x = x + 50
                end
            end
        end
    end
    local UE = __ord({
        W = 2600,
        MOD = 60,
        CANT = 530,
        BIB = 820,
        DCE = 1200,
        RU = 1440,
        XER = 1860,
        VERDE = 2100
    }, "W,MOD,CANT,BIB,DCE,RU,XER,VERDE")
    local F31 = {}
    local function buildCampusTras(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nv, n = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local b = 182
        do
            local x = 0
            while __lt(x, T) do
                local h = 30 + hash(nil, x * 0.3) * 26
                R(
                    nil,
                    c,
                    x,
                    b - 10 - h,
                    3,
                    h + 10,
                    "#6a8a5a"
                )
                ell(
                    nil,
                    c,
                    x + 1,
                    b - 12 - h,
                    4,
                    8,
                    pick(
                        nil,
                        __arrL({"#5a7e4e", "#6a9058", "#4e7246"}, 3),
                        x
                    )
                )
                x = x + 4
            end
        end
        do
            local x = 30
            local i = 0
            while x < T - 140 do
                local w = 90 + math.floor(hash(nil, i + 31) * 60 + 0.5)
                R(
                    nil,
                    c,
                    x,
                    b - 34,
                    w,
                    34,
                    "#ece8dc"
                )
                R(
                    nil,
                    c,
                    x,
                    b - 34,
                    w,
                    3,
                    "#2c5a9e"
                )
                R(
                    nil,
                    c,
                    x,
                    b - 18,
                    w,
                    2,
                    "#2c5a9e"
                )
                do
                    local k = 0
                    while k < w - 8 do
                        K:janelaM(
                            c,
                            n,
                            x + 4 + k,
                            b - 30,
                            i * 30 + k,
                            0.6
                        )
                        K:janelaM(
                            c,
                            n,
                            x + 4 + k,
                            b - 14,
                            i * 31 + k,
                            0.7
                        )
                        k = k + 9
                    end
                end
                R(
                    nil,
                    c,
                    x - 2,
                    b - 37,
                    w + 4,
                    3,
                    "#bcb6a8"
                )
                x = x + (w + 30 + math.floor(hash(nil, i) * 40 + 0.5))
                i = i + 1
            end
        end
        local tx = 700
        R(
            nil,
            c,
            tx,
            b - 90,
            4,
            90,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            tx + 26,
            b - 90,
            4,
            90,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            tx - 6,
            b - 112,
            42,
            24,
            "#e8e4dc"
        )
        R(
            nil,
            c,
            tx - 6,
            b - 112,
            42,
            3,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "UESB",
            tx + 15,
            b - 104,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            0,
            b,
            T,
            4,
            "#cfc8b6"
        )
        R(
            nil,
            c,
            0,
            b + 4,
            T,
            8,
            "#6a6e72"
        )
        nevoa(nil, c, T, "rgba(204,218,228,.2)")
        return {
            cv = cv,
            nv = nv,
            base = b,
            f = 0.4,
            gente = 24,
            rua = false
        }
    end
    local function modulo(self, c, x, w, seed)
        plaster(
            nil,
            c,
            x,
            104,
            w,
            106,
            "#efebe0",
            seed
        )
        R(
            nil,
            c,
            x,
            100,
            w,
            6,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            x,
            154,
            w,
            4,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            x - 2,
            98,
            w + 4,
            3,
            "#c8c2b4"
        )
        do
            local k = 0
            while k < w - 10 do
                janela(
                    nil,
                    c,
                    x + 6 + k,
                    112,
                    14,
                    16,
                    "vidro",
                    seed + k
                )
                R(
                    nil,
                    c,
                    x + 4 + k,
                    164,
                    4,
                    46,
                    "#d8d2c4"
                )
                R(
                    nil,
                    c,
                    x + 4 + k,
                    164,
                    1,
                    46,
                    "#f2efe6"
                )
                k = k + 22
            end
        end
        R(
            nil,
            c,
            x,
            158,
            w,
            6,
            "#c8c2b4"
        )
        R(
            nil,
            c,
            x + 2,
            164,
            w - 4,
            46,
            "rgba(60,60,70,.25)"
        )
        do
            local k = 0
            while k < w - 10 do
                R(
                    nil,
                    c,
                    x + 10 + k,
                    176,
                    8,
                    16,
                    pick(
                        nil,
                        __arrL({"#c88a6a", "#6a8aa8", "#a8a86a", "#8a6aa8"}, 4),
                        seed + k
                    )
                )
                k = k + 22
            end
        end
        do
            local k = 0
            while k < 8 do
                R(
                    nil,
                    c,
                    __add(x, w) - 30 + k * 3,
                    158 + k * 6.5,
                    14,
                    2,
                    "#bcb6a8"
                )
                k = k + 1
            end
        end
    end
    local function buildUesb(self)
        local W = UE.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        modulo(
            nil,
            c,
            UE.MOD,
            420,
            3100
        )
        R(
            nil,
            c,
            UE.MOD + 120,
            86,
            180,
            12,
            "#f2c94c"
        )
        R(
            nil,
            c,
            UE.MOD + 120,
            86,
            180,
            1,
            "#ffe8a0"
        )
        pxText(
            nil,
            c,
            "SEMANA DO CALOURO: BEM-VINDES!",
            UE.MOD + 210,
            89,
            "#2a2a2a"
        )
        local ct = UE.CANT
        R(
            nil,
            c,
            ct,
            140,
            110,
            70,
            "#e8833a"
        )
        R(
            nil,
            c,
            ct + 4,
            146,
            102,
            26,
            "#f2e8d0"
        )
        R(
            nil,
            c,
            ct,
            132,
            110,
            10,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 110 do
                R(
                    nil,
                    c,
                    ct + k,
                    132,
                    5,
                    10,
                    "#f2efe6"
                )
                k = k + 10
            end
        end
        R(
            nil,
            c,
            ct + 2,
            174,
            106,
            4,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            ct + 6,
            148,
            40,
            22,
            "#2a2a2a"
        )
        pxText(
            nil,
            c,
            "PASTEL 4",
            ct + 26,
            150,
            "#f2c94c"
        )
        pxText(
            nil,
            c,
            "SUCO 3",
            ct + 26,
            157,
            "#f2efe6"
        )
        pxText(
            nil,
            c,
            "CAFE 1,50",
            ct + 26,
            164,
            "#f2efe6"
        )
        do
            local k = 0
            while k < 2 do
                local tx = ct + 130 + k * 60
                ell(
                    nil,
                    c,
                    tx + 10,
                    170,
                    18,
                    5,
                    if __t(k) then "#2c8a5a" else "#c43c3a"
                )
                R(
                    nil,
                    c,
                    tx + 9,
                    170,
                    2,
                    24,
                    "#8a8a86"
                )
                R(
                    nil,
                    c,
                    tx,
                    192,
                    22,
                    3,
                    "#e8e2d2"
                )
                R(
                    nil,
                    c,
                    tx + 10,
                    195,
                    2,
                    15,
                    "#8a8a86"
                )
                for ____, sx in __iterar((__arrL({tx - 6, tx + 24}, 2))) do
                    R(
                        nil,
                        c,
                        sx,
                        200,
                        6,
                        2,
                        "#c8ccd0"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        202,
                        2,
                        8,
                        "#8a8a86"
                    )
                end
                k = k + 1
            end
        end
        local bb = UE.BIB
        R(
            nil,
            c,
            bb,
            80,
            330,
            130,
            "#3a5a6a"
        )
        do
            local k = 0
            while k < 330 do
                R(
                    nil,
                    c,
                    bb + k,
                    80,
                    2,
                    130,
                    "#2a3a44"
                )
                k = k + 30
            end
        end
        R(
            nil,
            c,
            bb,
            80,
            330,
            4,
            "#e8e4dc"
        )
        R(
            nil,
            c,
            bb,
            140,
            330,
            3,
            "#2a3a44"
        )
        do
            local r = 0
            while r < 2 do
                do
                    local k = 0
                    while k < 10 do
                        local sx = bb + 6 + k * 32
                        local sy = 92 + r * 60
                        do
                            local j = 0
                            while j < 3 do
                                R(
                                    nil,
                                    c,
                                    sx,
                                    sy + j * 14 + 12,
                                    24,
                                    2,
                                    "#8a6a45"
                                )
                                do
                                    local b2 = 0
                                    while b2 < 22 do
                                        R(
                                            nil,
                                            c,
                                            sx + b2,
                                            sy + j * 14 + 4 + hash(nil, b2 + k + j) * 3,
                                            2,
                                            9 - hash(nil, b2 + j) * 3,
                                            pick(
                                                nil,
                                                __arrL({
                                                    "#c43c3a",
                                                    "#2c5a9e",
                                                    "#e8c24c",
                                                    "#3c8a5a",
                                                    "#7a3a8a",
                                                    "#e8833a"
                                                }, 6),
                                                b2 + k + j + r
                                            )
                                        )
                                        b2 = b2 + 3
                                    end
                                end
                                j = j + 1
                            end
                        end
                        k = k + 1
                    end
                end
                r = r + 1
            end
        end
        reflexo(
            nil,
            c,
            bb,
            84,
            330,
            126
        )
        R(
            nil,
            c,
            bb + 140,
            170,
            50,
            40,
            "#2a3a44"
        )
        R(
            nil,
            c,
            bb + 142,
            172,
            22,
            38,
            "rgba(160,210,230,.5)"
        )
        R(
            nil,
            c,
            bb + 166,
            172,
            22,
            38,
            "rgba(160,210,230,.5)"
        )
        local d = UE.DCE
        plaster(
            nil,
            c,
            d,
            120,
            210,
            90,
            "#e8e2d2",
            3200
        )
        grafite(
            nil,
            c,
            d + 4,
            124,
            120,
            60,
            3201
        )
        R(
            nil,
            c,
            d + 130,
            128,
            74,
            56,
            "#8a6a45"
        )
        R(
            nil,
            c,
            d + 133,
            131,
            68,
            50,
            "#c8a46a"
        )
        do
            local k = 0
            while k < 8 do
                cartaz(
                    nil,
                    c,
                    d + 136 + __mod(k, 4) * 16,
                    134 + math.floor(k / 4) * 22,
                    3210 + k
                )
                k = k + 1
            end
        end
        pxText(
            nil,
            c,
            "DCE",
            d + 60,
            190,
            "#2a2a2a",
            {s = 2}
        )
        local ru = UE.RU
        plaster(
            nil,
            c,
            ru,
            110,
            380,
            100,
            "#f2efe6",
            3300
        )
        R(
            nil,
            c,
            ru,
            106,
            380,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            ru + 150,
            82,
            80,
            26,
            "#c43c3a"
        )
        R(
            nil,
            c,
            ru + 152,
            84,
            76,
            22,
            "#e8433a"
        )
        pxText(
            nil,
            c,
            "RU",
            ru + 190,
            88,
            "#ffffff",
            {s = 3}
        )
        do
            local k = 0
            while k < 6 do
                janela(
                    nil,
                    c,
                    ru + 20 + k * 60,
                    122,
                    30,
                    20,
                    "vidro",
                    3301 + k
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            ru + 170,
            150,
            40,
            60,
            "#5a3a24"
        )
        R(
            nil,
            c,
            ru + 172,
            152,
            18,
            58,
            "#8a5a3a"
        )
        R(
            nil,
            c,
            ru + 190,
            152,
            18,
            58,
            "#8a5a3a"
        )
        R(
            nil,
            c,
            ru - 10,
            190,
            170,
            2,
            "#9aa0a6"
        )
        do
            local k = 0
            while k < 170 do
                R(
                    nil,
                    c,
                    ru - 10 + k,
                    190,
                    2,
                    20,
                    "#9aa0a6"
                )
                k = k + 20
            end
        end
        R(
            nil,
            c,
            ru + 300,
            150,
            60,
            30,
            "#2a2a2a"
        )
        pxText(
            nil,
            c,
            "HOJE: FEIJOADA",
            ru + 330,
            156,
            "#f2c94c"
        )
        pxText(
            nil,
            c,
            "R$ 2,00",
            ru + 330,
            166,
            "#ffffff"
        )
        local xr = UE.XER
        plaster(
            nil,
            c,
            xr,
            140,
            170,
            70,
            "#f2e2a8",
            3400
        )
        R(
            nil,
            c,
            xr + 4,
            144,
            162,
            12,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "XEROX DO SEU ZE",
            xr + 85,
            147,
            "#ffffff"
        )
        R(
            nil,
            c,
            xr + 10,
            162,
            70,
            48,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            xr + 20,
            176,
            30,
            16,
            "#e8eaec"
        )
        R(
            nil,
            c,
            xr + 22,
            172,
            26,
            4,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            xr + 90,
            162,
            70,
            30,
            "#2a2a2a"
        )
        pxText(
            nil,
            c,
            "APOSTILA",
            xr + 125,
            168,
            "#ffffff"
        )
        pxText(
            nil,
            c,
            "R$0,10 A FOLHA",
            xr + 125,
            177,
            "#f2c94c"
        )
        do
            local k = 0
            while k < 8 do
                local bx = UE.VERDE + 20 + k * 9
                ell(
                    nil,
                    c,
                    bx,
                    204,
                    5,
                    5,
                    "#2a2a2a"
                )
                ell(
                    nil,
                    c,
                    bx,
                    204,
                    3,
                    3,
                    "rgba(0,0,0,0)"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({bx - 4, 204}, 2),
                            __arrL({bx, 196}, 2),
                            __arrL({bx + 4, 204}, 2)
                        },
                        3
                    ),
                    1,
                    pick(
                        nil,
                        __arrL({"#c43c3a", "#2c5a9e", "#3c8a5a"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            UE.VERDE + 12,
            200,
            80,
            2,
            "#8a8a86"
        )
        A:ponto(c, UE.VERDE + 400)
        R(
            nil,
            c,
            UE.VERDE + 404,
            GY - 31,
            30,
            6,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "CIRCULAR",
            UE.VERDE + 419,
            GY - 30,
            "#ffffff"
        )
        do
            local lx = 40
            while lx < W do
                lampPost(nil, c, lx, 120)
                lx = lx + 240
            end
        end
        objetos(
            nil,
            c,
            31,
            W,
            "cidade",
            30,
            W - 30,
            __arrL({120, 220}, 2)
        )
        pedraPortuguesa(nil, c, W, 210)
        R(
            nil,
            c,
            0,
            210,
            W,
            2,
            "#c8c2b0"
        )
        chaoDetalhe(nil, c, W, "cidade")
        return cv
    end
    local function uesb(self, c, s, t, camL)
        if not __t(F31.mid) then
            F31.mid = buildUesb(nil)
            F31.tras = buildCampusTras(nil)
        end
        local nt = night(nil, s)
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 31, kites = true}
        )
        tile(nil, c, F31.tras.cv, camL * F31.tras.f)
        noiteTile(
            nil,
            c,
            s,
            F31.tras.nv,
            camL * F31.tras.f
        )
        andaRua(
            nil,
            c,
            F31.tras,
            s,
            t,
            camL
        )
        do
            local sx = scr(
                nil,
                F31.tras,
                wrap(nil, t * 20),
                camL
            )
            if __t(vis(nil, sx, 40)) then
                local y = 192
                R(
                    nil,
                    c,
                    sx,
                    y - 14,
                    40,
                    12,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    sx,
                    y - 9,
                    40,
                    2,
                    "#2c5a9e"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            sx + 4 + k * 6,
                            y - 13,
                            4,
                            4,
                            "#3a5a6a"
                        )
                        k = k + 1
                    end
                end
                pxText(
                    nil,
                    c,
                    "UESB",
                    sx + 26,
                    y - 7,
                    "#2c5a9e"
                )
                R(
                    nil,
                    c,
                    sx + 4,
                    y - 2,
                    4,
                    3,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    sx + 31,
                    y - 2,
                    4,
                    3,
                    "#1c1c1c"
                )
            end
        end
        for ____, x in __iterar((__arrL({UE.VERDE + 120, UE.VERDE + 300, UE.CANT - 30, UE.RU + 400}, 4))) do
            local sx = x - camL
            if __t(vis(nil, sx, 60)) then
                ipe(
                    nil,
                    c,
                    sx,
                    212,
                    if __t(__mod(x, 2)) then "#e8c84a" else "#b86ac8",
                    x,
                    0.95
                )
            end
        end
        drawMid(nil, c, F31.mid, camL)
        do
            local k = 0
            while k < 9 do
                local x = UE.RU + 140 - k * 16 + math.floor(__mod(t * 3, 16) + 0.5) - camL
                if __t(vis(nil, x, 10)) then
                    gente(
                        nil,
                        c,
                        x,
                        212,
                        k + 3,
                        false
                    )
                    R(
                        nil,
                        c,
                        x + if __t(__mod(k, 2)) then 6 else -4,
                        198,
                        4,
                        8,
                        pick(
                            nil,
                            __arrL({"#c43c3a", "#2c5a9e", "#2a2a2a", "#e8833a"}, 4),
                            k
                        )
                    )
                end
                k = k + 1
            end
        end
        do
            local x0 = UE.VERDE + 170 - camL
            if __t(vis(nil, x0, 80)) then
                do
                    local k = 0
                    while k < 4 do
                        local a = k / 4 * TAU
                        local x = x0 + math.cos(a) * 22
                        local y = 212 + math.sin(a) * 3
                        R(
                            nil,
                            c,
                            x,
                            y - 7,
                            6,
                            7,
                            pick(nil, ROUPA, k + 2)
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            y - 11,
                            4,
                            4,
                            pick(nil, SKIN, k)
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x0 - 4,
                    203,
                    9,
                    4,
                    "#a8742a"
                )
                R(
                    nil,
                    c,
                    x0 + 5,
                    204,
                    8,
                    1,
                    "#5a3a20"
                )
                local st = math.sin(t * 10) > 0
                R(
                    nil,
                    c,
                    x0 + 1,
                    203 + if __t(st) then 1 else 0,
                    3,
                    1,
                    pick(nil, SKIN, 1)
                )
                do
                    local i = 0
                    while i < 3 do
                        local q = __mod(t * 0.4 + i / 3, 1)
                        c.globalAlpha = 1 - q
                        nota(
                            nil,
                            c,
                            x0 + 4 + i * 6 + q * 8,
                            196 - q * 26,
                            "#2a2a2a"
                        )
                        c.globalAlpha = 1
                        i = i + 1
                    end
                end
            end
        end
        do
            local u = (math.sin(t * 1.4) + 1) / 2
            local xa = UE.VERDE + 340
            local xb = UE.VERDE + 440
            local fx = xa + (xb - xa) * u - camL
            local fy = 196 - math.sin(u * math.pi) * 30
            if __t(vis(nil, fx, 60)) then
                gente(
                    nil,
                    c,
                    xa - camL - 8,
                    214,
                    9,
                    false
                )
                gente(
                    nil,
                    c,
                    xb - camL + 4,
                    214,
                    2,
                    false
                )
                ell(
                    nil,
                    c,
                    fx,
                    fy,
                    4,
                    1.5,
                    "#ff5a8a"
                )
            end
        end
        do
            local cyc = 20
            local ph = __mod(t, cyc) / cyc
            if ph < 0.5 then
                local x = UE.MOD + ph / 0.5 * 1500 - camL
                local f = __mod(
                    math.floor(t * 10),
                    2
                )
                if __t(vis(nil, x, 30)) then
                    gente(
                        nil,
                        c,
                        x,
                        214,
                        5,
                        false
                    )
                    R(
                        nil,
                        c,
                        x - 4,
                        198,
                        5,
                        7,
                        "#2c4a7a"
                    )
                    do
                        local i = 0
                        while i < 5 do
                            local q = __mod(t * 1.3 + i / 5, 1)
                            R(
                                nil,
                                c,
                                x - 8 - q * 40,
                                200 - math.sin(q * 3 + i) * 10 + q * 12,
                                3,
                                4,
                                "#f6f4ee"
                            )
                            i = i + 1
                        end
                    end
                    if __t(f) then
                        balao(
                            nil,
                            c,
                            x + 3,
                            192,
                            "ATRASADO PRA PROVA!"
                        )
                    end
                end
            end
        end
        do
            local x = UE.CANT + 60 - camL
            if __t(vis(nil, x, 20)) then
                cachorro(
                    nil,
                    c,
                    x,
                    212,
                    "#c98a43"
                )
                if __lt(nt, 0.5) then
                    pxText(
                        nil,
                        c,
                        "ZZZ",
                        x + 22 + math.sin(t) * 2,
                        194 - __mod(t * 5, 10),
                        "#5a5a66"
                    )
                end
            end
        end
        fog(
            nil,
            c,
            s,
            t,
            camL,
            0.16
        )
    end
    local function uesbLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.05) then
            return
        end
        do
            local x = 40
            while x < UE.W do
                lampGlow(
                    nil,
                    g,
                    x - camL,
                    120,
                    a
                )
                x = x + 240
            end
        end
        local bx = UE.BIB - camL
        if __t(vis(nil, bx, 330)) then
            g.fillStyle = ("rgba(255,236,190," .. tostring(0.3 * a)) .. ")"
            g:fillRect(bx, 84, 330, 126)
        end
    end
    local PLAT = __ord(
        {
            tronco = function(____, c, x, y, w, t, sd)
                sombra(
                    nil,
                    c,
                    x,
                    y,
                    w
                )
                Q(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    w + 4,
                    20,
                    "#3a2a1a"
                )
                Q(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    16,
                    "#6a4a32"
                )
                do
                    local k = 0
                    while __lt(k, w) do
                        Q(
                            nil,
                            c,
                            x + k,
                            y + 4 + if __t(__mod(k, 16)) then 0 else 2,
                            6,
                            2,
                            "#5a3a24"
                        )
                        k = k + 8
                    end
                end
                Q(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    4,
                    "#5f8a46"
                )
                Q(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    2,
                    "#86b45e"
                )
                for ____, ex in __iterar((__arrL(
                    {
                        x - 4,
                        __add(x, w) - 6
                    },
                    2
                ))) do
                    Q(
                        nil,
                        c,
                        ex,
                        y,
                        10,
                        16,
                        "#c8a06a"
                    )
                    Q(
                        nil,
                        c,
                        ex + 2,
                        y + 4,
                        6,
                        8,
                        "#9a7046"
                    )
                    Q(
                        nil,
                        c,
                        ex + 4,
                        y + 6,
                        2,
                        4,
                        "#c8a06a"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        local mx = x + 14 + hash(nil, sd + k) * (w - 30)
                        Q(
                            nil,
                            c,
                            mx,
                            y - 6,
                            2,
                            6,
                            "#f2e8d0"
                        )
                        Q(
                            nil,
                            c,
                            mx - 4,
                            y - 10,
                            10,
                            4,
                            if __t(__mod(k, 2)) then "#e8833a" else "#c43c3a"
                        )
                        Q(
                            nil,
                            c,
                            mx - 2,
                            y - 10,
                            2,
                            2,
                            "#f2efe6"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < w / 20 do
                        local vx = x + 8 + k * 20
                        local len = 6 + hash(nil, sd + k * 3) * 14
                        do
                            local j = 0
                            while j < len do
                                Q(
                                    nil,
                                    c,
                                    vx + math.sin(j * 0.5 + t + k) * 2,
                                    y + 16 + j,
                                    2,
                                    2,
                                    "#4a7a3a"
                                )
                                j = j + 2
                            end
                        end
                        k = k + 1
                    end
                end
            end,
            arquibancada = function(____, c, x, y, w, t, sd)
                sombra(
                    nil,
                    c,
                    x,
                    y,
                    w
                )
                concretoBase(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    24,
                    "#d8d4ca",
                    "#b4b0a6",
                    sd
                )
                do
                    local k = 4
                    while k < w - 10 do
                        local col = pick(
                            nil,
                            __arrL({"#c43c3a", "#2c5a9e", "#e8c24c", "#f2efe6"}, 4),
                            math.floor((x + k) / 12)
                        )
                        Q(
                            nil,
                            c,
                            x + k,
                            y - 8,
                            10,
                            8,
                            col
                        )
                        Q(
                            nil,
                            c,
                            x + k,
                            y - 8,
                            10,
                            2,
                            shadeHex(nil, col, 1.3)
                        )
                        Q(
                            nil,
                            c,
                            x + k + 2,
                            y,
                            6,
                            2,
                            shadeHex(nil, col, 0.6)
                        )
                        k = k + 12
                    end
                end
                Q(
                    nil,
                    c,
                    x,
                    y + 14,
                    w,
                    2,
                    "#e8e4da"
                )
            end,
            malas = function(____, c, x, y, w, t, sd)
                sombra(
                    nil,
                    c,
                    x,
                    y,
                    w
                )
                do
                    local k = 0
                    while __lt(k, w) do
                        local mw = math.min(
                            w - k,
                            28 + math.floor(hash(nil, sd + k) * 20 + 0.5)
                        )
                        local col = pick(
                            nil,
                            __arrL({
                                "#c43c3a",
                                "#2c4a6a",
                                "#e8c24c",
                                "#4a8a5a",
                                "#7a3a8a",
                                "#3a3a3a"
                            }, 6),
                            sd + k
                        )
                        Q(
                            nil,
                            c,
                            x + k,
                            y,
                            mw - 2,
                            22,
                            col
                        )
                        Q(
                            nil,
                            c,
                            x + k,
                            y,
                            mw - 2,
                            2,
                            shadeHex(nil, col, 1.3)
                        )
                        Q(
                            nil,
                            c,
                            x + k + mw - 4,
                            y,
                            2,
                            22,
                            shadeHex(nil, col, 0.7)
                        )
                        Q(
                            nil,
                            c,
                            x + k + 4,
                            y + 8,
                            mw - 10,
                            2,
                            shadeHex(nil, col, 0.8)
                        )
                        Q(
                            nil,
                            c,
                            x + k + mw / 2 - 4,
                            y - 4,
                            8,
                            4,
                            "#3a3a36"
                        )
                        Q(
                            nil,
                            c,
                            x + k + 6,
                            y + 12,
                            6,
                            4,
                            "#f2efe6"
                        )
                        k = k + mw
                    end
                end
            end,
            livros = function(____, c, x, y, w, t, sd)
                sombra(
                    nil,
                    c,
                    x,
                    y,
                    w
                )
                do
                    local r = 0
                    while r < 3 do
                        local off = (hash(nil, sd + r) - 0.5) * 10
                        local col = pick(
                            nil,
                            __arrL({
                                "#c43c3a",
                                "#2c5a9e",
                                "#3c8a5a",
                                "#e8833a",
                                "#7a3a8a",
                                "#e8c24c"
                            }, 6),
                            sd + r
                        )
                        Q(
                            nil,
                            c,
                            x + off,
                            y + r * 8,
                            w,
                            8,
                            col
                        )
                        Q(
                            nil,
                            c,
                            x + off,
                            y + r * 8,
                            w,
                            2,
                            shadeHex(nil, col, 1.3)
                        )
                        Q(
                            nil,
                            c,
                            __add(x + off, w) - 6,
                            y + r * 8 + 2,
                            6,
                            4,
                            "#f6f2e8"
                        )
                        do
                            local k = 8
                            while k < w - 10 do
                                Q(
                                    nil,
                                    c,
                                    __add(x + off, w) - 6,
                                    y + r * 8 + 2 + if __t(__mod(k, 4)) then 0 else 2,
                                    6,
                                    1,
                                    "#e0dccc"
                                )
                                k = k + 3
                            end
                        end
                        Q(
                            nil,
                            c,
                            x + off + 10,
                            y + r * 8 + 3,
                            math.min(30, w / 3),
                            2,
                            "#f2d898"
                        )
                        r = r + 1
                    end
                end
            end
        },
        "tronco,arquibancada,malas,livros"
    )
    local REG = CC.registrar
    REG(
        nil,
        __ord(
            {
                id = 28,
                key = "poco-escuro",
                nome = "Reserva do Poço Escuro",
                lugar = "Reserva Florestal do Poço Escuro · mata atlântica no meio da cidade",
                grupo = "novo",
                width = POCO.W * 2,
                draw = poco,
                lights = pocoLights,
                amb = function(____, s) return mix(
                    nil,
                    s.amb,
                    __arrL({0.66, 0.78, 0.66}, 3),
                    0.4
                ) end,
                vao = vaoAgua,
                plat = PLAT.tronco,
                labels = __arrL(
                    {
                        __arrL({
                            212,
                            167,
                            "TRILHA DO POÇO ESCURO",
                            4,
                            "#f2e8c8"
                        }, 5),
                        __arrL({
                            918,
                            168,
                            "NÃO ALIMENTE OS SAGUIS",
                            3,
                            "#f2e8c8"
                        }, 5),
                        __arrL({
                            POCO.POOL - 43,
                            164,
                            "POÇO ESCURO →",
                            4,
                            "#f2f2e6"
                        }, 5),
                        __arrL({
                            1855,
                            169,
                            "SILÊNCIO",
                            4,
                            "#f2e8c8"
                        }, 5),
                        __arrL({
                            POCO.GUARITA + 33,
                            154,
                            "GUARITA",
                            4,
                            "#f2efe6"
                        }, 5)
                    },
                    5
                ),
                interact = __arrL(
                    {
                        __arrL({"grass", 500, 220}, 3),
                        __arrL({"grass", 2500, 200}, 3),
                        __arrL({"crate", 1500}, 2),
                        __arrL({"bucket", 1900}, 2),
                        __arrL({"fence", 1200, 90}, 3),
                        __arrL({"puddle", 2900, 70}, 3),
                        __arrL({"hay", 4300}, 2),
                        __arrL({"grass", 4700, 240}, 3),
                        __arrL({"trap", 3900}, 2)
                    },
                    9
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,vao,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({700, 384, 150}, 3),
                        __arrL({890, 328, 140}, 3),
                        __arrL({2000, 384, 150}, 3),
                        __arrL({2190, 328, 140}, 3),
                        __arrL({2380, 272, 140}, 3),
                        __arrL({3080, 384, 220}, 3),
                        __arrL({3600, 384, 150}, 3),
                        __arrL({3790, 328, 140}, 3),
                        __arrL({4500, 384, 150}, 3)
                    },
                    9
                ),
                gaps = __arrL(
                    {__arrL({3100, 180}, 2)},
                    1
                )
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 29,
                key = "lomantao",
                nome = "Estádio Lomanto Júnior",
                lugar = "O Lomantão: bilheteria, portão 3 e a pista em dia de jogo",
                grupo = "novo",
                width = EST.W * 2,
                draw = estadio,
                lights = estadioLights,
                plat = PLAT.arquibancada,
                labels = __arrL(
                    {
                        __arrL({
                            250,
                            111,
                            "ESTÁDIO LOMANTO JÚNIOR",
                            10,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            135,
                            144,
                            "BILHETERIA",
                            5,
                            "#2a2a2a"
                        }, 5),
                        __arrL({
                            EST.PORTAO + 10,
                            112,
                            "PORTÃO 3",
                            5,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            320,
                            155,
                            "ESPETINHO",
                            4,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            460,
                            155,
                            "PIPOCA",
                            4,
                            "#ffffff"
                        }, 5),
                        __arrL(
                            {
                                __get(EST.BANCO, 0) + 50,
                                168,
                                "BANCO DE RESERVAS",
                                4,
                                "#2a2a2a"
                            },
                            5
                        )
                    },
                    6
                ),
                interact = __arrL(
                    {
                        __arrL({"ball", 1700}, 2),
                        __arrL({"ball", 3100}, 2),
                        __arrL({"ball", 4600}, 2),
                        __arrL({"cone", 2400}, 2),
                        __arrL({"cone", 2460}, 2),
                        __arrL({"cone", 2520}, 2),
                        __arrL({"trash", 560}, 2),
                        __arrL({"trash", 3500}, 2),
                        __arrL({"bucket", 2900}, 2),
                        __arrL({"crate", 1100}, 2),
                        __arrL({"grill", 640}, 2),
                        __arrL({"lever", 4200, "party"}, 3)
                    },
                    12
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({900, 384, 150}, 3),
                        __arrL({1600, 384, 150}, 3),
                        __arrL({1790, 328, 140}, 3),
                        __arrL({1980, 272, 140}, 3),
                        __arrL({3300, 384, 150}, 3),
                        __arrL({3490, 328, 140}, 3),
                        __arrL({4400, 384, 150}, 3),
                        __arrL({4590, 328, 140}, 3)
                    },
                    8
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 30,
                key = "rodoviaria",
                nome = "Terminal Rodoviário",
                lugar = "Rodoviária de Vitória da Conquista: guichês, partidas e plataformas",
                grupo = "novo",
                width = ROD.W * 2,
                draw = rodo,
                lights = rodoLights,
                amb = indoor(nil, 0.5),
                plat = PLAT.malas,
                labels = __arrL(
                    {
                        __arrL({
                            ROD.HALL / 2,
                            12,
                            "TERMINAL RODOVIÁRIO",
                            9,
                            "#2c3a44"
                        }, 5),
                        __arrL({
                            1040,
                            112,
                            "LANCHONETE",
                            5,
                            "#2a2a2a"
                        }, 5),
                        __arrL({
                            1165,
                            143,
                            "REVISTAS",
                            4,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            1800,
                            36,
                            "PLATAFORMAS DE EMBARQUE",
                            7,
                            "#2c3a44"
                        }, 5)
                    },
                    4
                ),
                interact = __arrL(
                    {
                        __arrL({"trash", 700}, 2),
                        __arrL({"trash", 2300}, 2),
                        __arrL({"crate", 1500}, 2),
                        __arrL({"crate", 1528, 1}, 3),
                        __arrL({"pot", 100}, 2),
                        __arrL({"pot", 2480}, 2),
                        __arrL({"bucket", 1900}, 2),
                        __arrL({"cone", 3000}, 2),
                        __arrL({"cone", 3800}, 2),
                        __arrL({"tire", 4200}, 2),
                        __arrL({"puddle", 3400, 70}, 3)
                    },
                    11
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({600, 384, 150}, 3),
                        __arrL({790, 328, 140}, 3),
                        __arrL({1700, 384, 150}, 3),
                        __arrL({2800, 384, 150}, 3),
                        __arrL({2990, 328, 140}, 3),
                        __arrL({3180, 272, 140}, 3),
                        __arrL({4300, 384, 150}, 3)
                    },
                    7
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 31,
                key = "uesb",
                nome = "UESB",
                lugar = "Universidade Estadual do Sudoeste da Bahia · campus de Conquista",
                grupo = "novo",
                width = UE.W * 2,
                draw = uesb,
                lights = uesbLights,
                plat = PLAT.livros,
                labels = __arrL(
                    {
                        __arrL({
                            UE.MOD + 210,
                            92,
                            "MÓDULO DE AULAS",
                            7,
                            "#2c3a44"
                        }, 5),
                        __arrL({
                            UE.CANT + 55,
                            137,
                            "CANTINA DA TIA",
                            5,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            UE.BIB + 165,
                            74,
                            "BIBLIOTECA CENTRAL",
                            8,
                            "#2c3a44"
                        }, 5),
                        __arrL({
                            UE.DCE + 167,
                            124,
                            "AVISOS",
                            4,
                            "#5a3a20"
                        }, 5),
                        __arrL({
                            UE.RU + 190,
                            116,
                            "RESTAURANTE UNIVERSITÁRIO",
                            6,
                            "#c43c3a"
                        }, 5)
                    },
                    5
                ),
                interact = __arrL(
                    {
                        __arrL({"ball", 4400}, 2),
                        __arrL({"ball", 4500}, 2),
                        __arrL({"trash", 1000}, 2),
                        __arrL({"trash", 3600}, 2),
                        __arrL({"pot", 1700}, 2),
                        __arrL({"pot", 4200}, 2),
                        __arrL({"crate", 2900}, 2),
                        __arrL({"crate", 2928, 1}, 3),
                        __arrL({"bucket", 2600}, 2),
                        __arrL({"lever", 3000, "bell"}, 3),
                        __arrL({"puddle", 2000, 70}, 3),
                        __arrL({"grass", 4800, 180}, 3)
                    },
                    12
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({700, 384, 150}, 3),
                        __arrL({890, 328, 140}, 3),
                        __arrL({1080, 272, 140}, 3),
                        __arrL({2300, 384, 150}, 3),
                        __arrL({2490, 328, 140}, 3),
                        __arrL({3900, 384, 150}, 3),
                        __arrL({4090, 328, 140}, 3)
                    },
                    7
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    local CAMS = window.CampanhaCamadas
    CAMS:configurar(
        28,
        __ord({povo = 4, trilha = true, fg = "natureza"}, "povo,trilha,fg")
    )
    CAMS:configurar(
        29,
        __ord({povo = 10, fgDraw = torcidaFrente}, "povo,fgDraw")
    )
    CAMS:configurar(
        30,
        __ord({povo = 20, fg = "interno"}, "povo,fg")
    )
    CAMS:configurar(
        31,
        __ord({povo = 22, fg = "cidade"}, "povo,fg")
    )
    local PL = window.CampanhaPlantas
    local ____t_15 = __t
    local ____opt_result_14
    if PL ~= nil then
        ____opt_result_14 = PL.adicionar
    end
    if ____t_15(____opt_result_14) then
        PL:adicionar(
            28,
            __arrL(
                {
                    __arrL({"samambaia", 300, 160}, 3),
                    __arrL({"capim", 1000, 120}, 3),
                    __arrL({"flores", 1500, 90}, 3),
                    __arrL({"samambaia", 2300, 140}, 3),
                    __arrL({"capim", 3400, 160}, 3),
                    __arrL({"samambaia", 4100, 120}, 3),
                    __arrL({"flores", 4800, 100}, 3)
                },
                7
            )
        )
        PL:adicionar(
            31,
            __arrL(
                {
                    __arrL({"floreira", 600, 100}, 3),
                    __arrL({"flores", 4300, 140}, 3),
                    __arrL({"capim", 4700, 160}, 3),
                    __arrL({"floreira", 3100, 100}, 3)
                },
                4
            )
        )
    end
    window.CampanhaNovos = __ord({
        PLAT = PLAT,
        placa = placa,
        nota = nota,
        vaoAgua = vaoAgua,
        indoor = indoor,
        drawMid = drawMid
    }, "PLAT,placa,nota,vaoAgua,indoor,drawMid")
end)(nil)
return ____exports
