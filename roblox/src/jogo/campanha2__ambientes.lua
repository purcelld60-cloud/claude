--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add, __shr = __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__shr
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local bloco, tilesEscola, apagao, LW, R, shadeHex, LH, BL, ESC, revela
    function bloco(self, c, x, y, base, o)
        if o == nil then
            o = {}
        end
        R(
            nil,
            c,
            x,
            y,
            BL,
            BL,
            base
        )
        R(
            nil,
            c,
            x,
            y,
            BL,
            1,
            shadeHex(nil, base, 1.25)
        )
        R(
            nil,
            c,
            x,
            y,
            1,
            BL,
            shadeHex(nil, base, 1.12)
        )
        R(
            nil,
            c,
            x,
            y + BL - 1,
            BL,
            1,
            shadeHex(nil, base, 0.62)
        )
        R(
            nil,
            c,
            x + BL - 1,
            y,
            1,
            BL,
            shadeHex(nil, base, 0.7)
        )
        local s = math.floor(x * 7 + y * 13)
        if o.tex ~= false then
            R(
                nil,
                c,
                x + 2 + __mod(s, 3),
                y + 2 + __mod(s, 4),
                1,
                1,
                shadeHex(nil, base, 0.82)
            )
            R(
                nil,
                c,
                x + 5 - __mod(s, 2),
                y + 5 - __mod(s, 3),
                1,
                1,
                shadeHex(nil, base, 1.1)
            )
        end
        if __t(o.tabua) then
            R(
                nil,
                c,
                x,
                y + 3,
                BL,
                1,
                shadeHex(nil, base, 0.78)
            )
            R(
                nil,
                c,
                x + if __t(__mod(s, 2)) then 2 else 5,
                y,
                1,
                3,
                shadeHex(nil, base, 0.78)
            )
            R(
                nil,
                c,
                x + if __t(__mod(s, 2)) then 5 else 2,
                y + 4,
                1,
                4,
                shadeHex(nil, base, 0.78)
            )
        end
        if __t(o.pedra) then
            R(
                nil,
                c,
                x + 3,
                y + 2,
                2,
                1,
                shadeHex(nil, base, 0.75)
            )
            R(
                nil,
                c,
                x + 1,
                y + 5,
                3,
                1,
                shadeHex(nil, base, 0.78)
            )
        end
    end
    function tilesEscola(self, c, W)
        R(
            nil,
            c,
            0,
            210,
            W,
            LH - 210,
            "#c8ccce"
        )
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    210,
                    1,
                    LH - 210,
                    "#b4b8bc"
                )
                x = x + 20
            end
        end
        do
            local y = 222
            while y < LH do
                R(
                    nil,
                    c,
                    0,
                    y,
                    W,
                    1,
                    "#b4b8bc"
                )
                y = y + 14
            end
        end
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x + 4,
                    214,
                    14,
                    2,
                    "rgba(255,255,255,.4)"
                )
                x = x + 40
            end
        end
        R(
            nil,
            c,
            0,
            210,
            W,
            2,
            "#8a9096"
        )
    end
    function apagao(self, c, camL)
        if revela <= 0.01 then
            return
        end
        local x = ESC.Z0 - camL
        local w = ESC.Z1 - ESC.Z0
        c:save()
        c.globalAlpha = revela
        c.fillStyle = "#000"
        c:fillRect(
            -4,
            0,
            math.max(0, x - 4),
            LH
        )
        c:fillRect(
            x + w + 8,
            0,
            LW(nil) + 8,
            LH
        )
        c:fillRect(x - 8, 0, w + 16, 16)
        c:fillRect(x - 8, 236, w + 16, LH)
        do
            local y = 16
            while y < 236 do
                bloco(
                    nil,
                    c,
                    x - 8,
                    y,
                    "#8a9298",
                    {pedra = true}
                )
                bloco(
                    nil,
                    c,
                    x + w,
                    y,
                    "#8a9298",
                    {pedra = true}
                )
                y = y + BL
            end
        end
        do
            local xx = x - 8
            while xx < x + w + 8 do
                bloco(
                    nil,
                    c,
                    xx,
                    16,
                    "#8a9298",
                    {pedra = true}
                )
                bloco(
                    nil,
                    c,
                    xx,
                    220,
                    "#9aa2a8",
                    {tex = false}
                )
                bloco(
                    nil,
                    c,
                    xx,
                    228,
                    "#7a848c",
                    {pedra = true}
                )
                xx = xx + BL
            end
        end
        c:restore()
    end
    function LW(self)
        return 482
    end
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_2 = __t
    local ____opt_0 = window.CampanhaCenarios
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.arte
    end
    if ____t_3(if __t(window.CampanhaAmbientes) then window.CampanhaAmbientes else not ____t_2(____opt_0)) then
        return
    end
    local A = window.CampanhaCenarios.arte
    local GY = A.GY
    R = A.R
    local ell = A.ell
    local mk = A.mk
    local hash = A.hash
    local cl = A.cl
    local limb = A.limb
    local sky = A.sky
    local tile = A.tile
    local tree = A.tree
    local bench = A.bench
    local lampPost = A.lampPost
    local lampGlow = A.lampGlow
    local lightAdd = A.lightAdd
    local vis = A.vis
    local night = A.night
    shadeHex = A.shadeHex
    local pick = A.pick
    local plaster = A.plaster
    local brick = A.brick
    local azulejo = A.azulejo
    local roofTiles = A.roofTiles
    local janela = A.janela
    local caixaDagua = A.caixaDagua
    local plantaVaso = A.plantaVaso
    local cartaz = A.cartaz
    local grafite = A.grafite
    local gato = A.gato
    local carro = A.carro
    local ponto = A.ponto
    local lixeira = A.lixeira
    local placaRua = A.placaRua
    local moto = A.moto
    local bike = A.bike
    local ipe = A.ipe
    local calcada = A.calcada
    local asfalto = A.asfalto
    local pedraPortuguesa = A.pedraPortuguesa
    local conquistaBack = A.conquistaBack
    local fog = A.fog
    local pessoa = A.pessoa
    local coluna = A.coluna
    local reflexo = A.reflexo
    local vgrad = A.vgrad
    local lojaFrente = A.lojaFrente
    local OBJ = A.OBJ
    local SHOP = A.SHOP
    LH = 270
    local function HERO()
        return A:heroiPos()
    end
    local function marmore(self, c, W)
        R(
            nil,
            c,
            0,
            210,
            W,
            3,
            "#6f6a60"
        )
        R(
            nil,
            c,
            0,
            210,
            W,
            1,
            "#a8a294"
        )
        vgrad(
            nil,
            c,
            0,
            213,
            W,
            LH - 213,
            "#f2ede2",
            "#ddd6c8"
        )
        local rows = __arrL({
            213,
            218,
            224,
            232,
            243,
            257,
            270
        }, 7)
        do
            local r = 1
            while r < __len(rows) do
                R(
                    nil,
                    c,
                    0,
                    __get(rows, r),
                    W,
                    1,
                    "#cdc5b4"
                )
                local step = 26 + r * 10
                do
                    local x = __mod(r, 2) * step / 2
                    while __lt(x, W) do
                        R(
                            nil,
                            c,
                            x,
                            __get(rows, r - 1) + 1,
                            1,
                            __get(rows, r) - __get(rows, r - 1) - 1,
                            "#d6cfbf"
                        )
                        x = x + step
                    end
                end
                r = r + 1
            end
        end
        do
            local i = 0
            while i < W / 4 do
                local vx = hash(nil, i * 1.7) * W
                local vy = 216 + hash(nil, i * 2.9) * 50
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({vx, vy}, 2),
                            __arrL(
                                {
                                    vx + 4 + hash(nil, i) * 6,
                                    vy + hash(nil, i * 5) * 3 - 1
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    "rgba(150,140,125,.28)"
                )
                i = i + 1
            end
        end
    end
    local function espelharChao(self, c, cv, W, alpha)
        if alpha == nil then
            alpha = 0.15
        end
        local H = LH - 213
        local tmp, tc = table.unpack(
            mk(nil, W, H),
            1,
            2
        )
        tc:drawImage(
            cv,
            0,
            210 - H,
            W,
            H,
            0,
            0,
            W,
            H
        )
        c:save()
        c.globalAlpha = alpha
        c:translate(0, 213 + H)
        c:scale(1, -1)
        c:drawImage(tmp, 0, 0)
        c:restore()
        do
            local k = 0
            while k < H do
                R(
                    nil,
                    c,
                    0,
                    213 + k,
                    W,
                    1,
                    ("rgba(238,233,222," .. tostring(k / H * 0.55)) .. ")"
                )
                k = k + 1
            end
        end
    end
    local function tacos(self, c, W, y)
        if y == nil then
            y = 210
        end
        R(
            nil,
            c,
            0,
            y,
            W,
            LH - y,
            "#8a5a36"
        )
        do
            local r = 0
            local yy = y
            while yy < LH do
                R(
                    nil,
                    c,
                    0,
                    yy,
                    W,
                    1,
                    "#5a3a20"
                )
                local off = __mod(r * 37, 60)
                do
                    local x = off
                    while __lt(x, W) do
                        R(
                            nil,
                            c,
                            x,
                            yy + 1,
                            1,
                            6 + r,
                            "#6a4428"
                        )
                        x = x + 60
                    end
                end
                do
                    local x = 0
                    while __lt(x, W) do
                        if __gt(
                            hash(nil, x * 3 + r * 17),
                            0.82
                        ) then
                            R(
                                nil,
                                c,
                                x,
                                yy + 2 + math.floor(hash(nil, x + r) * 3 + 0.5),
                                2,
                                1,
                                if __gt(
                                    hash(nil, x + r),
                                    0.5
                                ) then "#9a6a42" else "#7a4c2c"
                            )
                        end
                        x = x + 3
                    end
                end
                do
                    r = r + 1
                    yy = yy + (6 + r)
                end
            end
        end
        R(
            nil,
            c,
            0,
            y,
            W,
            2,
            "#a8784a"
        )
        do
            local k = 0
            while __lt(k, W) do
                R(
                    nil,
                    c,
                    k + 10,
                    y + 4,
                    14,
                    1,
                    "rgba(255,240,210,.18)"
                )
                k = k + 40
            end
        end
    end
    local function porta(self, c, x, y, w, h, col, o)
        if o == nil then
            o = {}
        end
        R(
            nil,
            c,
            x - 3,
            y - 3,
            w + 6,
            h + 3,
            if __t(o.batente) then o.batente else "#efe6d4"
        )
        R(
            nil,
            c,
            x - 3,
            y - 3,
            w + 6,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            __add(x, w) + 2,
            y - 3,
            1,
            h + 3,
            "#c8bca4"
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
            2,
            h,
            shadeHex(nil, col, 1.15)
        )
        R(
            nil,
            c,
            __add(x, w) - 2,
            y,
            2,
            h,
            shadeHex(nil, col, 0.75)
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({y + 6, h * 0.38}, 2),
                __arrL({y + h * 0.5, h * 0.42}, 2)
            },
            2
        ))) do
            local py = ____value[1]
            local ph = ____value[2]
            R(
                nil,
                c,
                x + 5,
                py,
                w - 10,
                ph,
                shadeHex(nil, col, 0.88)
            )
            R(
                nil,
                c,
                x + 5,
                py,
                w - 10,
                1,
                shadeHex(nil, col, 0.7)
            )
            R(
                nil,
                c,
                x + 5,
                __add(py, ph) - 1,
                w - 10,
                1,
                shadeHex(nil, col, 1.12)
            )
        end
        if __t(o.vidro) then
            R(
                nil,
                c,
                x + 6,
                y + 8,
                w - 12,
                h * 0.3,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + 7,
                y + 9,
                3,
                h * 0.3 - 2,
                "#d8eef4"
            )
        end
        R(
            nil,
            c,
            __add(x, w) - 7,
            y + h * 0.52,
            4,
            3,
            "#c8a24a"
        )
        R(
            nil,
            c,
            __add(x, w) - 7,
            y + h * 0.52,
            4,
            1,
            "#f2d898"
        )
        if __t(o.placa) then
            R(
                nil,
                c,
                x + w / 2 - 7,
                y + 3,
                14,
                7,
                "#c8a24a"
            )
            R(
                nil,
                c,
                x + w / 2 - 6,
                y + 4,
                12,
                5,
                "#f6e8b8"
            )
        end
        R(
            nil,
            c,
            x - 2,
            __add(y, h),
            w + 4,
            2,
            "#6a5a44"
        )
    end
    local function quadro(self, c, x, y, w, h, kind, seed)
        R(
            nil,
            c,
            x - 2,
            y - 2,
            w + 4,
            h + 4,
            "#8a6a3a"
        )
        R(
            nil,
            c,
            x - 2,
            y - 2,
            w + 4,
            1,
            "#c8a46a"
        )
        vgrad(
            nil,
            c,
            x,
            y,
            w,
            h,
            "#a8d0e8",
            "#e8d8b8"
        )
        if kind == "cristo" then
            R(
                nil,
                c,
                x,
                __add(y, h) - 6,
                w,
                6,
                "#8a9a6a"
            )
            R(
                nil,
                c,
                x + w / 2,
                y + 3,
                1,
                h - 8,
                "#6a6258"
            )
            R(
                nil,
                c,
                x + w / 2 - 4,
                y + 6,
                9,
                1,
                "#6a6258"
            )
        end
        if kind == "catedral" then
            R(
                nil,
                c,
                x + w / 2 - 5,
                __add(y, h) - 14,
                10,
                14,
                "#eedfb6"
            )
            R(
                nil,
                c,
                x + w / 2 - 2,
                y + 3,
                4,
                10,
                "#eedfb6"
            )
            R(
                nil,
                c,
                x + w / 2 - 1,
                y + 1,
                2,
                2,
                "#eedfb6"
            )
        end
        if kind == "cacau" then
            R(
                nil,
                c,
                x,
                __add(y, h) - 5,
                w,
                5,
                "#4f8a3a"
            )
            ell(
                nil,
                c,
                x + w / 2,
                y + h / 2,
                5,
                7,
                "#c47a35"
            )
            R(
                nil,
                c,
                x + w / 2 - 1,
                y + h / 2 - 6,
                1,
                12,
                "#8a4a20"
            )
        end
        if kind == "paisagem" then
            R(
                nil,
                c,
                x,
                __add(y, h) - 7,
                w,
                7,
                "#5f8a46"
            )
            ell(
                nil,
                c,
                x + w * 0.3,
                __add(y, h) - 8,
                6,
                4,
                "#6a8a5a"
            )
            ell(
                nil,
                c,
                x + w * 0.7,
                y + 5,
                3,
                3,
                "#f2e8a8"
            )
        end
        if kind == "trio" then
            R(
                nil,
                c,
                x,
                y,
                w,
                h,
                "#f6f2ea"
            )
            do
                local k = 0
                while k < 3 do
                    local px = x + 3 + k * (w - 6) / 3
                    R(
                        nil,
                        c,
                        px + 1,
                        y + 4,
                        3,
                        3,
                        __get(
                            __arrL({"#d6a071", "#825033", "#dcaa82"}, 3),
                            k
                        )
                    )
                    R(
                        nil,
                        c,
                        px,
                        y + 7,
                        5,
                        6,
                        __get(
                            __arrL({"#dc8c47", "#4d7374", "#1c1e22"}, 3),
                            k
                        )
                    )
                    k = k + 1
                end
            end
        end
    end
    local function arandela(self, c, x, y)
        R(
            nil,
            c,
            x - 1,
            y,
            3,
            6,
            "#c8a24a"
        )
        ell(
            nil,
            c,
            x,
            y - 2,
            4,
            3,
            "#f6e8c8"
        )
        R(
            nil,
            c,
            x - 3,
            y - 2,
            7,
            1,
            "#fffaf0"
        )
    end
    local FR = __ord({W = 1300, ENT = 680}, "W,ENT")
    local function buildFrente(self)
        local cv, c = table.unpack(
            mk(nil, FR.W, LH),
            1,
            2
        )
        local x0 = 300
        local x1 = 1060
        local top = 54
        do
            local x = x0
            while x < x1 do
                R(
                    nil,
                    c,
                    x,
                    top,
                    20,
                    GY - top,
                    if __t(__mod(x / 20, 2)) then "#e6e2d8" else "#dcd7cb"
                )
                R(
                    nil,
                    c,
                    x,
                    top,
                    1,
                    GY - top,
                    "#c8c2b4"
                )
                x = x + 20
            end
        end
        do
            local y = top + 24
            while __lt(y, GY) do
                R(
                    nil,
                    c,
                    x0,
                    y,
                    x1 - x0,
                    1,
                    "#c8c2b4"
                )
                y = y + 24
            end
        end
        R(
            nil,
            c,
            x0 - 4,
            top - 6,
            x1 - x0 + 8,
            6,
            "#f4f0e8"
        )
        R(
            nil,
            c,
            x0 - 4,
            top - 6,
            x1 - x0 + 8,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            x0 - 4,
            top,
            x1 - x0 + 8,
            2,
            "#a8a294"
        )
        R(
            nil,
            c,
            x0,
            top + 6,
            x1 - x0,
            4,
            "#e8833a"
        )
        R(
            nil,
            c,
            x0,
            top + 10,
            x1 - x0,
            1,
            "#b8642a"
        )
        R(
            nil,
            c,
            x0,
            top + 18,
            x1 - x0,
            26,
            "#2c4656"
        )
        do
            local x = x0
            while x < x1 do
                vgrad(
                    nil,
                    c,
                    x + 1,
                    top + 19,
                    12,
                    24,
                    "#7fb0c8",
                    "#3c6a84"
                )
                x = x + 14
            end
        end
        reflexo(
            nil,
            c,
            x0,
            top + 18,
            x1 - x0,
            26
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({x0 + 20, "#c43c3a"}, 2),
                __arrL({x1 - 190, "#2c5a9e"}, 2)
            },
            2
        ))) do
            local ax = ____value[1]
            local col = ____value[2]
            R(
                nil,
                c,
                ax,
                top + 52,
                170,
                30,
                "#1c1f24"
            )
            vgrad(
                nil,
                c,
                ax + 2,
                top + 54,
                166,
                26,
                shadeHex(nil, col, 1.2),
                shadeHex(nil, col, 0.8)
            )
            R(
                nil,
                c,
                ax + 2,
                top + 54,
                166,
                1,
                "#ffffff66"
            )
            R(
                nil,
                c,
                ax + 10,
                top + 90,
                150,
                58,
                "#2a3640"
            )
            do
                local k = 0
                while k < 5 do
                    vgrad(
                        nil,
                        c,
                        ax + 12 + k * 30,
                        top + 92,
                        28,
                        54,
                        "#fff4dc",
                        "#e8d8b8"
                    )
                    do
                        local j = 0
                        while j < 3 do
                            R(
                                nil,
                                c,
                                ax + 15 + k * 30 + j * 8,
                                top + 110,
                                6,
                                14,
                                pick(
                                    nil,
                                    __arrL({"#d9634a", "#3c6aa8", "#e8c24c", "#3c8a5a"}, 4),
                                    k + j
                                )
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
            reflexo(
                nil,
                c,
                ax + 10,
                top + 90,
                150,
                58
            )
        end
        do
            local k = 0
            while k < 3 do
                local px = x0 + 220 + k * 34
                if px > FR.ENT - 110 then
                    break
                end
                R(
                    nil,
                    c,
                    px,
                    top + 92,
                    28,
                    40,
                    "#c8a24a"
                )
                vgrad(
                    nil,
                    c,
                    px + 2,
                    top + 94,
                    24,
                    36,
                    pick(
                        nil,
                        __arrL({"#3c6ab0", "#b83a3a", "#2a7a4a"}, 3),
                        k
                    ),
                    "#1a1420"
                )
                R(
                    nil,
                    c,
                    px + 8,
                    top + 106,
                    10,
                    18,
                    "#14101a"
                )
                R(
                    nil,
                    c,
                    px + 4,
                    top + 124,
                    20,
                    3,
                    "#f2efe6"
                )
                k = k + 1
            end
        end
        local ex0 = FR.ENT - 110
        local ex1 = FR.ENT + 110
        local et = 24
        R(
            nil,
            c,
            ex0 - 3,
            et - 3,
            ex1 - ex0 + 6,
            GY - et + 3,
            "#5a646c"
        )
        vgrad(
            nil,
            c,
            ex0,
            et,
            ex1 - ex0,
            GY - et,
            "#a8d0e4",
            "#4a7a92"
        )
        do
            local x = ex0
            while x <= ex1 do
                R(
                    nil,
                    c,
                    x,
                    et,
                    2,
                    GY - et,
                    "#3c4850"
                )
                x = x + 22
            end
        end
        do
            local y = et
            while __lt(y, GY) do
                R(
                    nil,
                    c,
                    ex0,
                    y,
                    ex1 - ex0,
                    2,
                    "#3c4850"
                )
                y = y + 26
            end
        end
        reflexo(
            nil,
            c,
            ex0,
            et,
            ex1 - ex0,
            GY - et
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    ex0 + 10 + k * 34,
                    et + 40,
                    8,
                    26,
                    pick(
                        nil,
                        __arrL({"#e8833a", "#3c8ad8", "#c43c3a", "#f2c94c"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            FR.ENT - 70,
            et + 8,
            140,
            22,
            "#1c1f24"
        )
        vgrad(
            nil,
            c,
            FR.ENT - 68,
            et + 10,
            136,
            18,
            "#f6a24a",
            "#d8642a"
        )
        R(
            nil,
            c,
            FR.ENT - 68,
            et + 10,
            136,
            1,
            "#ffd8a8"
        )
        R(
            nil,
            c,
            ex0 - 40,
            140,
            ex1 - ex0 + 80,
            8,
            "#f4f2ee"
        )
        R(
            nil,
            c,
            ex0 - 40,
            140,
            ex1 - ex0 + 80,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            ex0 - 40,
            148,
            ex1 - ex0 + 80,
            3,
            "#9aa0a6"
        )
        do
            local x = ex0 - 30
            while x < ex1 + 40 do
                R(
                    nil,
                    c,
                    x,
                    150,
                    6,
                    2,
                    "#fff6d8"
                )
                x = x + 20
            end
        end
        for ____, px in __iterar((__arrL({ex0 - 34, ex1 + 30}, 2))) do
            R(
                nil,
                c,
                px,
                151,
                4,
                GY - 151,
                "#c8ccd0"
            )
            R(
                nil,
                c,
                px,
                151,
                1,
                GY - 151,
                "#f2f4f6"
            )
        end
        local dx = FR.ENT
        ell(
            nil,
            c,
            dx,
            208,
            30,
            4,
            "#3c4850"
        )
        R(
            nil,
            c,
            dx - 30,
            162,
            60,
            46,
            "rgba(160,210,230,.45)"
        )
        R(
            nil,
            c,
            dx - 30,
            160,
            60,
            4,
            "#5a646c"
        )
        R(
            nil,
            c,
            dx - 1,
            164,
            2,
            44,
            "#3c4850"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({dx - 26, 170}, 2),
                    __arrL({dx + 24, 200}, 2)
                },
                2
            ),
            1,
            "#3c4850"
        )
        for ____, sx in __iterar((__arrL({dx - 70, dx + 40}, 2))) do
            R(
                nil,
                c,
                sx,
                162,
                30,
                46,
                "rgba(160,210,230,.55)"
            )
            R(
                nil,
                c,
                sx,
                162,
                30,
                2,
                "#5a646c"
            )
            R(
                nil,
                c,
                sx + 14,
                162,
                2,
                46,
                "#5a646c"
            )
        end
        do
            local k = 0
            while k < 4 do
                carro(
                    nil,
                    c,
                    24 + k * 62,
                    GY + 2,
                    pick(
                        nil,
                        __arrL({
                            "#c43c3a",
                            "#f2f2ee",
                            "#2a2a2a",
                            "#3c6aa8",
                            "#9aa0a6"
                        }, 5),
                        k
                    ),
                    if __t(__mod(k, 2)) then 1 else -1
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            276,
            GY - 30,
            18,
            30,
            "#e8e4dc"
        )
        R(
            nil,
            c,
            276,
            GY - 30,
            18,
            3,
            "#c43c3a"
        )
        R(
            nil,
            c,
            279,
            GY - 24,
            12,
            8,
            "#9fc4d0"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({294, GY - 14}, 2),
                    __arrL({330, GY - 14}, 2)
                },
                2
            ),
            2,
            "#e8433a"
        )
        do
            local k = 296
            while k < 330 do
                R(
                    nil,
                    c,
                    k,
                    GY - 15,
                    4,
                    2,
                    "#f2efe6"
                )
                k = k + 8
            end
        end
        R(
            nil,
            c,
            240,
            GY - 52,
            2,
            52,
            "#5a5e62"
        )
        R(
            nil,
            c,
            230,
            GY - 62,
            22,
            14,
            "#2c5aa8"
        )
        R(
            nil,
            c,
            233,
            GY - 59,
            16,
            8,
            "#f2efe6"
        )
        local tx = 1140
        R(
            nil,
            c,
            tx,
            30,
            40,
            GY - 30,
            "#2a3036"
        )
        R(
            nil,
            c,
            tx + 2,
            32,
            36,
            28,
            "#e8833a"
        )
        R(
            nil,
            c,
            tx + 2,
            32,
            36,
            1,
            "#ffd8a8"
        )
        do
            local k = 0
            while k < 7 do
                R(
                    nil,
                    c,
                    tx + 4,
                    66 + k * 14,
                    32,
                    10,
                    pick(
                        nil,
                        __arrL({
                            "#c43c3a",
                            "#2c5a9e",
                            "#3c8a5a",
                            "#7a3a8a",
                            "#e8c24c",
                            "#d84a7a",
                            "#2a2a2a"
                        }, 7),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    tx + 6,
                    69 + k * 14,
                    20,
                    3,
                    "#f2efe6"
                )
                k = k + 1
            end
        end
        ponto(nil, c, 1200)
        lixeira(nil, c, 1110)
        placaRua(nil, c, 1270)
        bike(nil, c, 1060, "#3c8ad8")
        moto(nil, c, 1084, "#2a2a2a")
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    1210 + k * 30,
                    GY + 16,
                    28,
                    10,
                    "#e8c24c"
                )
                k = k + 1
            end
        end
        for ____, px in __iterar((__arrL({x0 + 10, ex0 - 60, ex1 + 50, x1 - 20}, 4))) do
            R(
                nil,
                c,
                px - 10,
                GY - 10,
                22,
                10,
                "#8a8478"
            )
            R(
                nil,
                c,
                px - 10,
                GY - 10,
                22,
                2,
                "#b4ae9e"
            )
            do
                local k = 0
                while k < 8 do
                    ell(
                        nil,
                        c,
                        px - 6 + k * 2.5,
                        GY - 14 - __mod(k, 3) * 3,
                        3,
                        3,
                        pick(
                            nil,
                            __arrL({"#e86a7a", "#f2c94c", "#4f8a3a", "#f6f2ea"}, 4),
                            k
                        )
                    )
                    k = k + 1
                end
            end
        end
        pedraPortuguesa(nil, c, FR.W, 204)
        R(
            nil,
            c,
            0,
            220,
            FR.W,
            1,
            "#8a8478"
        )
        asfalto(
            nil,
            c,
            FR.W,
            __arrL({}, 0)
        )
        return cv
    end
    local frenteMid = nil
    local function frente(self, c, s, t, camL)
        if not __t(frenteMid) then
            frenteMid = buildFrente(nil)
        end
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 21}
        )
        for ____, x in __iterar((__arrL({140, 1240}, 2))) do
            local sx = x - camL
            if __t(vis(nil, sx, 60)) then
                tree(
                    nil,
                    c,
                    sx,
                    200,
                    0.8,
                    1,
                    t,
                    x
                )
            end
        end
        c:drawImage(
            frenteMid,
            camL,
            0,
            LW(nil),
            LH,
            0,
            0,
            LW(nil),
            LH
        )
        for ____, x in __iterar((__arrL({FR.ENT - 160, FR.ENT + 160}, 2))) do
            local sx = x - camL
            if __t(vis(nil, sx, 60)) then
                ipe(
                    nil,
                    c,
                    sx,
                    206,
                    if x < FR.ENT then "#b86ac8" else "#e8c84a",
                    x,
                    0.8
                )
            end
        end
        do
            local ph = __mod(t * 0.4, 1)
            local dx = FR.ENT - camL
            if __t(vis(nil, dx, 40)) then
                do
                    local k = 0
                    while k < 3 do
                        local a = (ph + k / 3) * math.pi
                        local px = dx + math.cos(a) * 26
                        R(
                            nil,
                            c,
                            px,
                            164,
                            2,
                            44,
                            "rgba(60,72,80,.8)"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local i = 0
            while i < 16 do
                local wx = 40 + i * 82 + math.sin(t * 0.3 + i * 2) * 40
                local sx = wx - camL
                if __t(vis(nil, sx, 20)) then
                    pessoa(
                        nil,
                        c,
                        sx,
                        216,
                        i
                    )
                end
                i = i + 1
            end
        end
        do
            local cx = __mod(t * 30, 1700) - 200 - camL
            if __t(vis(nil, cx, 40)) then
                carro(
                    nil,
                    c,
                    cx,
                    246,
                    "#c43c3a",
                    1
                )
            end
            local cx2 = 1500 - __mod(t * 24, 1700) - camL
            if __t(vis(nil, cx2, 40)) then
                carro(
                    nil,
                    c,
                    cx2,
                    260,
                    "#e8c24c",
                    -1
                )
            end
        end
        fog(
            nil,
            c,
            s,
            t,
            camL,
            0.2
        )
    end
    local function frenteLights(self, g, s, t, camL)
        local a = math.max(
            0.15,
            night(nil, s)
        )
        do
            local x = FR.ENT - 140
            while x < FR.ENT + 150 do
                local sx = x - camL
                if __t(vis(nil, sx)) then
                    lightAdd(
                        nil,
                        sx,
                        150,
                        a * 0.5,
                        50
                    )
                end
                x = x + 20
            end
        end
        local tx = 1160 - camL
        if __t(vis(nil, tx, 40)) then
            g.fillStyle = ("rgba(255,190,120," .. tostring(0.25 * a)) .. ")"
            g:fillRect(tx - 20, 30, 40, 180)
        end
    end
    local P2 = __ord({W = 1600, ESC = 50}, "W,ESC")
    local LOJAS2 = __arrL(
        {
            __arrL({"RIACHORRO", "MODA"}, 2),
            __arrL({"MAGAZINE LURDES", "ELETRO"}, 2),
            __arrL({"SENTAURO", "TÊNIS"}, 2),
            __arrL({"O BUTECÁRIO", "PERFUMES"}, 2),
            __arrL({"CACAU CHOU", "CHOCOLATE"}, 2),
            __arrL({"LIVRARIA CUTUCADA", "LIVROS"}, 2),
            __arrL({"GAMESTOPA", "GAMES"}, 2),
            __arrL({"RI TRISTE", "BRINQUEDOS"}, 2),
            __arrL({"AMENICANAS", "ELETRO"}, 2)
        },
        9
    )
    local function buildPiso2(self)
        local W = P2.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        local MZ = SHOP.MZ
        R(
            nil,
            c,
            0,
            0,
            W,
            46,
            "#c4ccd2"
        )
        do
            local x = 0
            while x < W do
                c:clearRect(x + 3, 2, 34, 32)
                R(
                    nil,
                    c,
                    x + 3,
                    2,
                    34,
                    32,
                    "rgba(205,234,248,.22)"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    3,
                    10,
                    30,
                    "rgba(255,255,255,.14)"
                )
                x = x + 40
            end
        end
        do
            local x = 0
            while x < W do
                do
                    local k = 0
                    while k <= 160 do
                        local yy = 34 - math.floor(math.sin(k / 160 * math.pi) * 26 + 0.5)
                        R(
                            nil,
                            c,
                            x + k,
                            yy,
                            2,
                            3,
                            "#7a8892"
                        )
                        if __mod(k, 16) == 0 then
                            limb(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({x + k, yy + 3}, 2),
                                        __arrL({x + k, 40}, 2)
                                    },
                                    2
                                ),
                                1,
                                "#98a4ae"
                            )
                        end
                        k = k + 2
                    end
                end
                x = x + 160
            end
        end
        R(
            nil,
            c,
            0,
            38,
            W,
            4,
            "#8a96a0"
        )
        R(
            nil,
            c,
            0,
            42,
            W,
            4,
            "#d8dce0"
        )
        do
            local x = 20
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    44,
                    6,
                    2,
                    "#fff6d8"
                )
                x = x + 40
            end
        end
        vgrad(
            nil,
            c,
            0,
            46,
            196,
            164,
            "#ece6da",
            "#ddd5c6"
        )
        c:clearRect(0, 46, 196, MZ - 46 - 2)
        __call(
            LOJAS2,
            "forEach",
            function(____, ____bindingPattern0, i)
                local kind
                kind = ____bindingPattern0[2]
                return lojaFrente(
                    nil,
                    c,
                    200 + i * 150 + 2,
                    146,
                    kind,
                    i + 11
                )
            end
        )
        do
            local i = 0
            while i <= __len(LOJAS2) do
                coluna(
                    nil,
                    c,
                    196 + i * 150,
                    46,
                    MZ - 2
                )
                coluna(
                    nil,
                    c,
                    196 + i * 150,
                    SHOP.TOP,
                    210
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            MZ - 14,
            W,
            14,
            "rgba(188,226,238,.38)"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    MZ - 14,
                    2,
                    14,
                    "#9aa6ae"
                )
                x = x + 24
            end
        end
        R(
            nil,
            c,
            0,
            MZ - 17,
            W,
            3,
            "#b8c2c8"
        )
        R(
            nil,
            c,
            0,
            MZ - 17,
            W,
            1,
            "#f6fafc"
        )
        R(
            nil,
            c,
            0,
            MZ,
            W,
            12,
            "#f6f4ee"
        )
        R(
            nil,
            c,
            0,
            MZ,
            W,
            1,
            "#ffffff"
        )
        vgrad(
            nil,
            c,
            0,
            MZ + 12,
            W,
            6,
            "#aaa496",
            "#d6d0c4"
        )
        marmore(nil, c, W)
        local ex = P2.ESC
        R(
            nil,
            c,
            ex,
            213,
            120,
            57,
            "#2a2e34"
        )
        do
            local k = 0
            while k <= 30 do
                local u = k / 30
                local sx = ex + 116 - u * 110
                local sy = 213 + u * 57
                R(
                    nil,
                    c,
                    sx,
                    sy,
                    6,
                    2,
                    "#c4ccd2"
                )
                R(
                    nil,
                    c,
                    sx,
                    sy + 2,
                    6,
                    1,
                    "#6a747c"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            ex,
            213,
            120,
            2,
            "#c8ccd0"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({ex + 124, 196}, 2),
                    __arrL({ex + 104, 200}, 2),
                    __arrL({ex + 20, 260}, 2)
                },
                3
            ),
            3,
            "#1e1e22"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({ex + 124, 195}, 2),
                    __arrL({ex + 104, 199}, 2),
                    __arrL({ex + 20, 259}, 2)
                },
                3
            ),
            1,
            "#4a4a52"
        )
        R(
            nil,
            c,
            ex + 118,
            196,
            10,
            14,
            "#8a949a"
        )
        R(
            nil,
            c,
            ex + 118,
            196,
            10,
            2,
            "#c8ccd0"
        )
        espelharChao(nil, c, cv, W)
        return cv
    end
    local piso2Mid = nil
    local function piso2(self, c, s, t, camL)
        if not __t(piso2Mid) then
            piso2Mid = buildPiso2(nil)
        end
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(
            nil,
            c,
            A:shopFar(),
            camL * 0.4 + 300
        )
        do
            local x = 120
            while x < P2.W do
                local sx = x - camL
                local sw = math.floor(math.sin(t * 1.1 + x) + 0.5)
                if not __t(vis(nil, sx, 40)) then
                    continue
                end
                R(
                    nil,
                    c,
                    sx + 8,
                    44,
                    1,
                    6,
                    "#5a6066"
                )
                vgrad(
                    nil,
                    c,
                    sx + 4 + sw,
                    50,
                    26,
                    30,
                    "#c43c3a",
                    "#7a1e1e"
                )
                R(
                    nil,
                    c,
                    sx + 4 + sw,
                    50,
                    26,
                    2,
                    "#e86a6a"
                )
                R(
                    nil,
                    c,
                    sx + 8 + sw,
                    72,
                    18,
                    2,
                    "#f2c94c"
                )
                x = x + 260
            end
        end
        do
            local i = 0
            while i < 8 do
                local wx = 40 + i * 200 + math.sin(t * 0.2 + i * 1.3) * 60
                local sx = wx - camL
                if __t(vis(nil, sx, 20)) then
                    pessoa(
                        nil,
                        c,
                        sx,
                        SHOP.MZ,
                        i + 6
                    )
                end
                i = i + 1
            end
        end
        c:drawImage(
            piso2Mid,
            camL,
            0,
            LW(nil),
            LH,
            0,
            0,
            LW(nil),
            LH
        )
        do
            local k = 0
            while k < 16 do
                local u = __mod(t * 0.16 + k / 16, 1)
                local x = P2.ESC + 116 - u * 110 - camL
                local y = 213 + u * 57
                if __t(vis(nil, x, 10)) then
                    R(
                        nil,
                        c,
                        x,
                        y - 1,
                        6,
                        1,
                        "#eef2f4"
                    )
                end
                k = k + 1
            end
        end
        do
            local i = 0
            while i < 16 do
                local wx = 220 + i * 90 + math.sin(t * 0.35 + i * 2) * 40
                local sx = wx - camL
                if __t(vis(nil, sx, 20)) then
                    pessoa(
                        nil,
                        c,
                        sx,
                        216,
                        i + 3
                    )
                end
                i = i + 1
            end
        end
    end
    local function piso2Lights(self, g, s, t, camL)
        do
            local x = 20
            while x < P2.W do
                local sx = x + 3 - camL
                if __t(vis(nil, sx)) then
                    lightAdd(
                        nil,
                        sx,
                        44,
                        0.22,
                        50
                    )
                end
                x = x + 40
            end
        end
    end
    BL = 8
    local function caixaInterior(self, c, b, o)
        c.fillStyle = "#000"
        c:fillRect(0, 0, 482, LH)
        do
            local x = b.x0 - BL
            while __lt(x, b.x1 + BL) do
                bloco(
                    nil,
                    c,
                    x,
                    b.top - BL,
                    o.teto,
                    {pedra = true}
                )
                bloco(
                    nil,
                    c,
                    x,
                    b.top - BL * 2,
                    shadeHex(nil, o.teto, 0.8),
                    {pedra = true}
                )
                x = x + BL
            end
        end
        do
            local y = b.top - BL * 2
            while __lt(y, b.floor + BL * 2) do
                bloco(
                    nil,
                    c,
                    b.x0 - BL,
                    y,
                    o.lado,
                    {pedra = true}
                )
                bloco(
                    nil,
                    c,
                    b.x1,
                    y,
                    o.lado,
                    {pedra = true}
                )
                y = y + BL
            end
        end
        do
            local x = b.x0 - BL
            while __lt(x, b.x1 + BL) do
                bloco(
                    nil,
                    c,
                    x,
                    b.floor,
                    o.chao,
                    {tabua = true}
                )
                bloco(
                    nil,
                    c,
                    x,
                    b.floor + BL,
                    shadeHex(nil, o.lado, 0.85),
                    {pedra = true}
                )
                x = x + BL
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({b.x0 - BL * 2, b.top - BL}, 2),
                __arrL({b.x1 + BL, b.top}, 2),
                __arrL({b.x0 - BL * 2, b.floor}, 2),
                __arrL({b.x1 + BL, b.floor + BL}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            bloco(
                nil,
                c,
                x,
                y,
                shadeHex(nil, o.lado, 0.75),
                {pedra = true}
            )
        end
    end
    local function papelParede(self, c, x0, y0, x1, y1, a, b2, flor)
        do
            local y = y0
            while __lt(y, y1) do
                do
                    local x = x0
                    while __lt(x, x1) do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            BL,
                            BL,
                            if __t(__mod(
                                __add(x, y) / BL,
                                2
                            )) then a else b2
                        )
                        if __t(if __t(flor) then __mod(x / BL + y / BL, 3) == 0 else flor) then
                            R(
                                nil,
                                c,
                                x + 3,
                                y + 3,
                                2,
                                2,
                                flor
                            )
                            R(
                                nil,
                                c,
                                x + 3,
                                y + 5,
                                1,
                                2,
                                "#5a7a3a"
                            )
                        end
                        R(
                            nil,
                            c,
                            x,
                            y,
                            BL,
                            1,
                            "rgba(0,0,0,.05)"
                        )
                        x = x + BL
                    end
                end
                y = y + BL
            end
        end
    end
    local function tabuado(self, c, x0, y0, x1, y1, base)
        do
            local y = y0
            while __lt(y, y1) do
                R(
                    nil,
                    c,
                    x0,
                    y,
                    x1 - x0,
                    4,
                    if __t(__mod(y / 4, 2)) then base else shadeHex(nil, base, 0.92)
                )
                R(
                    nil,
                    c,
                    x0,
                    y + 3,
                    x1 - x0,
                    1,
                    shadeHex(nil, base, 0.72)
                )
                do
                    local x = x0 + __mod(y / 4, 3) * 9
                    while __lt(x, x1) do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            3,
                            shadeHex(nil, base, 0.72)
                        )
                        x = x + 26
                    end
                end
                y = y + 4
            end
        end
    end
    local function portaT(self, c, x, chao, cor, o)
        if o == nil then
            o = {}
        end
        local y = chao - 40
        R(
            nil,
            c,
            x - 1,
            y - 2,
            18,
            42,
            "#3a2414"
        )
        R(
            nil,
            c,
            x,
            y,
            16,
            40,
            cor
        )
        R(
            nil,
            c,
            x,
            y,
            16,
            1,
            shadeHex(nil, cor, 1.3)
        )
        R(
            nil,
            c,
            x + 15,
            y,
            1,
            40,
            shadeHex(nil, cor, 0.65)
        )
        for ____, yy in __iterar((__arrL({y + 4, y + 22}, 2))) do
            R(
                nil,
                c,
                x + 3,
                yy,
                10,
                14,
                shadeHex(nil, cor, 0.85)
            )
            R(
                nil,
                c,
                x + 3,
                yy,
                10,
                1,
                shadeHex(nil, cor, 0.65)
            )
            R(
                nil,
                c,
                x + 3,
                yy + 13,
                10,
                1,
                shadeHex(nil, cor, 1.15)
            )
        end
        if __t(o.vidro) then
            R(
                nil,
                c,
                x + 4,
                y + 5,
                8,
                10,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + 5,
                y + 6,
                2,
                8,
                "#d8eef4"
            )
        end
        R(
            nil,
            c,
            x + 12,
            y + 20,
            2,
            3,
            "#e8c24c"
        )
        if __t(o.num) then
            R(
                nil,
                c,
                x + 5,
                y - 7,
                6,
                5,
                "#c8a24a"
            )
            R(
                nil,
                c,
                x + 6,
                y - 6,
                4,
                3,
                "#f6e8b8"
            )
        end
    end
    local function tocha(self, c, x, y)
        R(
            nil,
            c,
            x,
            y,
            2,
            6,
            "#6a4428"
        )
        R(
            nil,
            c,
            x - 1,
            y - 3,
            4,
            3,
            "#f2a83a"
        )
        R(
            nil,
            c,
            x,
            y - 5,
            2,
            2,
            "#ffe39a"
        )
    end
    local COR = __ord(
        {
            W = 480,
            x0 = 40,
            x1 = 440,
            top = 112,
            floor = 220,
            Q = __arrL(
                {
                    __arrL({82, "1"}, 2),
                    __arrL({154, "2"}, 2),
                    __arrL({254, "3"}, 2),
                    __arrL({326, "4"}, 2),
                    __arrL({398, "5"}, 2)
                },
                5
            ),
            ENT = 48
        },
        "W,x0,x1,top,floor,Q,ENT"
    )
    local function buildCorredor(self)
        local cv, c = table.unpack(
            mk(nil, COR.W, LH),
            1,
            2
        )
        local b = COR
        caixaInterior(nil, c, b, {teto = "#7a6a5a", lado = "#6a6a72", chao = "#8a5a32"})
        papelParede(
            nil,
            c,
            b.x0,
            b.top,
            b.x1,
            172,
            "#e8d4b0",
            "#e2cca6",
            "#c45a5a"
        )
        R(
            nil,
            c,
            b.x0,
            172,
            b.x1 - b.x0,
            3,
            "#7a4a2a"
        )
        R(
            nil,
            c,
            b.x0,
            172,
            b.x1 - b.x0,
            1,
            "#b07a4a"
        )
        tabuado(
            nil,
            c,
            b.x0,
            175,
            b.x1,
            b.floor,
            "#8a5a34"
        )
        R(
            nil,
            c,
            b.x0,
            b.floor - 3,
            b.x1 - b.x0,
            3,
            "#4a2e18"
        )
        do
            local x = b.x0
            while x < b.x1 do
                if __gt(
                    hash(nil, x * 1.7),
                    0.8
                ) then
                    R(
                        nil,
                        c,
                        x,
                        b.top + hash(nil, x) * 50,
                        1,
                        2,
                        "rgba(110,80,40,.12)"
                    )
                end
                x = x + 2
            end
        end
        do
            local x = b.x0 + 30
            while x < b.x1 do
                R(
                    nil,
                    c,
                    x,
                    b.top,
                    6,
                    6,
                    "#5a3a20"
                )
                R(
                    nil,
                    c,
                    x,
                    b.top,
                    6,
                    1,
                    "#8a5a34"
                )
                x = x + 80
            end
        end
        for ____, x in __iterar((__arrL({120, 240, 360}, 3))) do
            R(
                nil,
                c,
                x,
                b.top,
                1,
                10,
                "#3a3a3a"
            )
            R(
                nil,
                c,
                x - 6,
                b.top + 10,
                13,
                2,
                "#c8a24a"
            )
            for ____, dx in __iterar((__arrL({-5, 0, 5}, 3))) do
                R(
                    nil,
                    c,
                    x + dx,
                    b.top + 7,
                    1,
                    3,
                    "#c8a24a"
                )
                R(
                    nil,
                    c,
                    x + dx - 1,
                    b.top + 5,
                    3,
                    2,
                    "#fff2c8"
                )
            end
        end
        portaT(
            nil,
            c,
            b.ENT,
            b.floor,
            "#6a3c24",
            {vidro = true}
        )
        for ____, ____value in __iterar((b.Q)) do
            local x = ____value[1]
            local n = ____value[2]
            portaT(
                nil,
                c,
                x,
                b.floor,
                if n == "4" then "#8a4a2a" else "#7a5232",
                {num = true}
            )
            R(
                nil,
                c,
                x - 2,
                b.floor - 2,
                20,
                2,
                if n == "4" then "#b83a3a" else "#5a6a3a"
            )
        end
        for ____, x in __iterar((__arrL({
            72,
            112,
            144,
            184,
            244,
            284,
            316,
            352,
            388
        }, 9))) do
            tocha(nil, c, x, 150)
        end
        quadro(
            nil,
            c,
            116,
            128,
            20,
            14,
            "cristo",
            1
        )
        quadro(
            nil,
            c,
            196,
            126,
            24,
            16,
            "catedral",
            2
        )
        quadro(
            nil,
            c,
            360,
            128,
            18,
            14,
            "cacau",
            4
        )
        R(
            nil,
            c,
            110,
            178,
            2,
            42,
            "#5a3a20"
        )
        R(
            nil,
            c,
            106,
            178,
            10,
            2,
            "#5a3a20"
        )
        R(
            nil,
            c,
            105,
            180,
            5,
            16,
            "#3a4a6a"
        )
        R(
            nil,
            c,
            111,
            180,
            5,
            14,
            "#8a2a2a"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({108, 181}, 2),
                    __arrL({110, 196}, 2)
                },
                2
            ),
            1,
            "#e8c24c"
        )
        R(
            nil,
            c,
            120,
            212,
            8,
            8,
            "#4a5a6a"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({122, 212}, 2),
                    __arrL({121, 202}, 2)
                },
                2
            ),
            1,
            "#c43c3a"
        )
        R(
            nil,
            c,
            200,
            196,
            30,
            3,
            "#7a4a2a"
        )
        R(
            nil,
            c,
            201,
            199,
            2,
            21,
            "#5a3a20"
        )
        R(
            nil,
            c,
            227,
            199,
            2,
            21,
            "#5a3a20"
        )
        R(
            nil,
            c,
            201,
            208,
            28,
            2,
            "#5a3a20"
        )
        R(
            nil,
            c,
            205,
            190,
            20,
            6,
            "rgba(0,0,0,.15)"
        )
        R(
            nil,
            c,
            207,
            188,
            14,
            8,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            208,
            190,
            12,
            1,
            "#c43c3a"
        )
        R(
            nil,
            c,
            208,
            192,
            9,
            1,
            "#5a5a5a"
        )
        R(
            nil,
            c,
            278,
            168,
            14,
            52,
            "#5a3420"
        )
        R(
            nil,
            c,
            279,
            169,
            12,
            50,
            "#7a4a2a"
        )
        ell(
            nil,
            c,
            285,
            178,
            5,
            5,
            "#c8a24a"
        )
        ell(
            nil,
            c,
            285,
            178,
            4,
            4,
            "#f6f2ea"
        )
        R(
            nil,
            c,
            285,
            175,
            1,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            281,
            190,
            8,
            22,
            "#3a2414"
        )
        R(
            nil,
            c,
            284,
            194,
            2,
            12,
            "#c8a24a"
        )
        ell(
            nil,
            c,
            285,
            206,
            2,
            2,
            "#e8c24c"
        )
        R(
            nil,
            c,
            344,
            186,
            22,
            34,
            "#6a4428"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    345,
                    188 + k * 11,
                    20,
                    1,
                    "#4a2e18"
                )
                do
                    local j = 0
                    while j < 6 do
                        R(
                            nil,
                            c,
                            346 + j * 3,
                            190 + k * 11,
                            2,
                            8,
                            pick(
                                nil,
                                __arrL({"#c43c3a", "#2c5a9e", "#e8c24c", "#3c8a5a"}, 4),
                                j + k
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            424,
            208,
            15,
            12,
            "#8a5a32"
        )
        R(
            nil,
            c,
            424,
            208,
            15,
            2,
            "#c8a24a"
        )
        R(
            nil,
            c,
            424,
            213,
            15,
            1,
            "#5a3a20"
        )
        R(
            nil,
            c,
            430,
            211,
            2,
            3,
            "#e8c24c"
        )
        R(
            nil,
            c,
            416,
            204,
            7,
            16,
            "#8a8478"
        )
        do
            local k = 0
            while k < 6 do
                ell(
                    nil,
                    c,
                    418 + k * 1.2,
                    199 - __mod(k, 3) * 4,
                    3,
                    4,
                    if __t(__mod(k, 2)) then "#3f7a3c" else "#5f9a46"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            412,
            130,
            20,
            20,
            "#5a3a20"
        )
        vgrad(
            nil,
            c,
            414,
            132,
            16,
            16,
            "#c8d4dc",
            "#e2e6e8"
        )
        R(
            nil,
            c,
            421,
            132,
            1,
            16,
            "#5a3a20"
        )
        R(
            nil,
            c,
            414,
            139,
            16,
            1,
            "#5a3a20"
        )
        do
            local x = b.x0 + 4
            while x < b.x1 - 4 do
                R(
                    nil,
                    c,
                    x,
                    b.floor + 1,
                    2,
                    3,
                    if __gt(
                        hash(nil, x),
                        0.5
                    ) then "#9a2a2a" else "#8a2424"
                )
                x = x + 2
            end
        end
        R(
            nil,
            c,
            b.x0 + 4,
            b.floor + 1,
            b.x1 - b.x0 - 8,
            1,
            "#c8a24a"
        )
        return cv
    end
    local corMid = nil
    local function corredor(self, c, s, t, camL)
        if not __t(corMid) then
            corMid = buildCorredor(nil)
        end
        c:drawImage(corMid, 0, 0)
        for ____, x in __iterar((__arrL({
            72,
            112,
            144,
            184,
            244,
            284,
            316,
            352,
            388
        }, 9))) do
            local f = __mod(
                math.floor(t * 9 + x),
                3
            )
            R(
                nil,
                c,
                x - 1,
                147 - if f == 1 then 1 else 0,
                4,
                3,
                if f == 2 then "#ffb04a" else "#f2a83a"
            )
            R(
                nil,
                c,
                x,
                145 - f,
                2,
                2,
                "#fff2b0"
            )
        end
        do
            local sw = math.sin(t * 2) * 3
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({285, 192}, 2),
                        __arrL({285 + sw, 204}, 2)
                    },
                    2
                ),
                1,
                "#c8a24a"
            )
            ell(
                nil,
                c,
                285 + sw,
                205,
                2,
                2,
                "#e8c24c"
            )
        end
        do
            local br = math.floor(math.sin(t * 1.4) + 0.5)
            R(
                nil,
                c,
                236,
                214 + br,
                10,
                5,
                "#d8a24a"
            )
            R(
                nil,
                c,
                243,
                211 + br,
                5,
                4,
                "#d8a24a"
            )
            R(
                nil,
                c,
                244,
                210,
                1,
                1,
                "#d8a24a"
            )
            R(
                nil,
                c,
                247,
                210,
                1,
                1,
                "#d8a24a"
            )
        end
        do
            local k = 0
            while k < 3 do
                ell(
                    nil,
                    c,
                    418 + __mod(t * 5 + k * 6, 12),
                    136 + k * 4,
                    3,
                    2,
                    "rgba(255,255,255,.4)"
                )
                k = k + 1
            end
        end
    end
    local function corredorLights(self, g, s, t, camL)
        g:save()
        g:beginPath()
        g:rect(COR.x0, COR.top, COR.x1 - COR.x0, COR.floor - COR.top)
        g:clip()
        for ____, x in __iterar((__arrL({
            72,
            112,
            144,
            184,
            244,
            284,
            316,
            352,
            388
        }, 9))) do
            local fl = 0.24 + math.sin(t * 11 + x) * 0.04
            local gr = g:createRadialGradient(
                x + 1,
                146,
                1,
                x + 1,
                146,
                22
            )
            gr:addColorStop(
                0,
                ("rgba(255,190,110," .. tostring(fl)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,190,110,0)")
            g.fillStyle = gr
            g:fillRect(x - 26, 120, 54, 54)
            lightAdd(
                nil,
                x,
                146,
                0.3,
                30
            )
        end
        for ____, x in __iterar((__arrL({120, 240, 360}, 3))) do
            local gr = g:createRadialGradient(
                x,
                122,
                2,
                x,
                122,
                34
            )
            gr:addColorStop(0, "rgba(255,230,170,.2)")
            gr:addColorStop(1, "rgba(255,230,170,0)")
            g.fillStyle = gr
            g:fillRect(x - 34, COR.top, 68, 50)
        end
        g:restore()
    end
    local QT = __ord({
        W = 480,
        x0 = 150,
        x1 = 330,
        top = 130,
        floor = 220,
        ARM = 187,
        PC = 230
    }, "W,x0,x1,top,floor,ARM,PC")
    local function buildQuarto(self)
        local cv, c = table.unpack(
            mk(nil, QT.W, LH),
            1,
            2
        )
        local b = QT
        caixaInterior(nil, c, b, {teto = "#7a6a5a", lado = "#6a6a72", chao = "#8a5a32"})
        tabuado(
            nil,
            c,
            b.x0,
            b.top,
            b.x1,
            b.floor,
            "#9a6a40"
        )
        do
            local x = b.x0 + 22
            while x < b.x1 do
                R(
                    nil,
                    c,
                    x,
                    b.top,
                    4,
                    b.floor - b.top,
                    "#6a4428"
                )
                R(
                    nil,
                    c,
                    x,
                    b.top,
                    1,
                    b.floor - b.top,
                    "#8a5a34"
                )
                x = x + 44
            end
        end
        R(
            nil,
            c,
            b.x0,
            b.floor - 3,
            b.x1 - b.x0,
            3,
            "#4a2e18"
        )
        portaT(
            nil,
            c,
            b.x0 + 2,
            b.floor,
            "#7a4a2a"
        )
        local ax = QT.ARM - 12
        R(
            nil,
            c,
            ax - 1,
            b.floor - 47,
            26,
            47,
            "#3a2414"
        )
        R(
            nil,
            c,
            ax,
            b.floor - 46,
            24,
            46,
            "#7a4e2e"
        )
        R(
            nil,
            c,
            ax,
            b.floor - 46,
            24,
            1,
            "#a8784a"
        )
        R(
            nil,
            c,
            ax + 11,
            b.floor - 44,
            2,
            42,
            "#4a2e18"
        )
        for ____, dx in __iterar((__arrL({1, 13}, 2))) do
            R(
                nil,
                c,
                ax + dx + 1,
                b.floor - 42,
                9,
                18,
                "#8a5a36"
            )
            R(
                nil,
                c,
                ax + dx + 1,
                b.floor - 22,
                9,
                18,
                "#8a5a36"
            )
            R(
                nil,
                c,
                ax + dx + 1,
                b.floor - 42,
                9,
                1,
                "#6a3e22"
            )
        end
        R(
            nil,
            c,
            ax + 9,
            b.floor - 26,
            2,
            4,
            "#e8c24c"
        )
        R(
            nil,
            c,
            ax + 14,
            b.floor - 26,
            2,
            4,
            "#e8c24c"
        )
        R(
            nil,
            c,
            ax + 2,
            b.floor - 52,
            8,
            6,
            "#3c6aa8"
        )
        R(
            nil,
            c,
            ax + 12,
            b.floor - 50,
            9,
            4,
            "#c47a35"
        )
        local mx = QT.PC
        R(
            nil,
            c,
            mx - 20,
            b.floor - 20,
            40,
            3,
            "#6a4428"
        )
        R(
            nil,
            c,
            mx - 20,
            b.floor - 20,
            40,
            1,
            "#9a6a42"
        )
        R(
            nil,
            c,
            mx - 18,
            b.floor - 17,
            3,
            17,
            "#5a3a20"
        )
        R(
            nil,
            c,
            mx + 15,
            b.floor - 17,
            3,
            17,
            "#5a3a20"
        )
        R(
            nil,
            c,
            mx + 4,
            b.floor - 17,
            11,
            9,
            "#7a4e2e"
        )
        R(
            nil,
            c,
            mx + 8,
            b.floor - 13,
            3,
            1,
            "#c8a24a"
        )
        R(
            nil,
            c,
            mx - 15,
            b.floor - 37,
            24,
            15,
            "#14161c"
        )
        R(
            nil,
            c,
            mx - 4,
            b.floor - 22,
            3,
            2,
            "#2a2c34"
        )
        R(
            nil,
            c,
            mx - 14,
            b.floor - 36,
            22,
            13,
            "#1e2236"
        )
        R(
            nil,
            c,
            mx + 11,
            b.floor - 34,
            7,
            14,
            "#1c1e24"
        )
        R(
            nil,
            c,
            mx + 12,
            b.floor - 33,
            5,
            12,
            "#2a2c36"
        )
        R(
            nil,
            c,
            mx - 13,
            b.floor - 22,
            16,
            2,
            "#2a2a30"
        )
        R(
            nil,
            c,
            mx + 4,
            b.floor - 22,
            3,
            2,
            "#2a2a30"
        )
        R(
            nil,
            c,
            mx - 30,
            b.floor - 16,
            9,
            10,
            "#c43c3a"
        )
        R(
            nil,
            c,
            mx - 30,
            b.floor - 24,
            3,
            10,
            "#c43c3a"
        )
        R(
            nil,
            c,
            mx - 26,
            b.floor - 6,
            2,
            6,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            mx - 30,
            b.floor - 1,
            10,
            1,
            "#3a3a3a"
        )
        local jx = 264
        R(
            nil,
            c,
            jx - 1,
            145,
            30,
            28,
            "#5a3a20"
        )
        vgrad(
            nil,
            c,
            jx + 1,
            147,
            26,
            24,
            "#b8c8d4",
            "#e2e6e8"
        )
        R(
            nil,
            c,
            jx + 1,
            163,
            26,
            8,
            "#a8b8c0"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    jx + 2 + k * 4,
                    158 + __mod(k, 3),
                    3,
                    13,
                    "#c0ccd2"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            jx + 18,
            150,
            1,
            8,
            "#6a7476"
        )
        R(
            nil,
            c,
            jx + 16,
            152,
            5,
            1,
            "#6a7476"
        )
        R(
            nil,
            c,
            jx + 13,
            147,
            2,
            24,
            "#5a3a20"
        )
        R(
            nil,
            c,
            jx + 1,
            158,
            26,
            2,
            "#5a3a20"
        )
        R(
            nil,
            c,
            jx - 5,
            143,
            6,
            32,
            "#7a4a9a"
        )
        R(
            nil,
            c,
            jx + 27,
            143,
            6,
            32,
            "#7a4a9a"
        )
        R(
            nil,
            c,
            jx - 6,
            142,
            40,
            2,
            "#3a2414"
        )
        R(
            nil,
            c,
            jx - 2,
            173,
            32,
            3,
            "#c8a46a"
        )
        local bx = 296
        local f = b.floor
        R(
            nil,
            c,
            bx + 28,
            f - 26,
            4,
            26,
            "#5a3a20"
        )
        R(
            nil,
            c,
            bx + 28,
            f - 26,
            4,
            1,
            "#9a6a42"
        )
        R(
            nil,
            c,
            bx + 27,
            f - 27,
            6,
            2,
            "#7a4e2e"
        )
        R(
            nil,
            c,
            bx,
            f - 16,
            3,
            16,
            "#5a3a20"
        )
        R(
            nil,
            c,
            bx,
            f - 16,
            3,
            1,
            "#9a6a42"
        )
        R(
            nil,
            c,
            bx + 3,
            f - 6,
            25,
            4,
            "#6a4428"
        )
        R(
            nil,
            c,
            bx + 3,
            f - 6,
            25,
            1,
            "#8a5a34"
        )
        R(
            nil,
            c,
            bx + 4,
            f - 2,
            2,
            2,
            "#4a2e18"
        )
        R(
            nil,
            c,
            bx + 25,
            f - 2,
            2,
            2,
            "#4a2e18"
        )
        R(
            nil,
            c,
            bx + 3,
            f - 10,
            25,
            4,
            "#efe8d8"
        )
        R(
            nil,
            c,
            bx + 3,
            f - 10,
            25,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            bx + 20,
            f - 14,
            8,
            5,
            "#f6f2ea"
        )
        R(
            nil,
            c,
            bx + 20,
            f - 14,
            8,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            bx + 20,
            f - 10,
            8,
            1,
            "#c8c0b0"
        )
        do
            local x = 0
            while x < 18 do
                do
                    local y = 0
                    while y < 6 do
                        R(
                            nil,
                            c,
                            bx + 3 + x,
                            f - 12 + y,
                            1,
                            1,
                            if __t(__mod(
                                __shr(x, 1) + __shr(y, 1),
                                2
                            )) then "#b83a3a" else "#8a2424"
                        )
                        y = y + 1
                    end
                end
                x = x + 1
            end
        end
        R(
            nil,
            c,
            bx + 3,
            f - 12,
            18,
            1,
            "#d85a4a"
        )
        R(
            nil,
            c,
            bx + 3,
            f - 7,
            18,
            1,
            "#6a1a1a"
        )
        do
            local x = 0
            while x < 18 do
                R(
                    nil,
                    c,
                    bx + 4 + x,
                    f - 12,
                    1,
                    6,
                    "#e8c24c"
                )
                x = x + 3
            end
        end
        R(
            nil,
            c,
            300,
            146,
            28,
            22,
            "#5a3a20"
        )
        R(
            nil,
            c,
            301,
            147,
            26,
            20,
            "#c8a46a"
        )
        do
            local i = 0
            while i < 60 do
                R(
                    nil,
                    c,
                    302 + hash(nil, i * 3.3) * 24,
                    148 + hash(nil, i * 7.1) * 18,
                    1,
                    1,
                    "#b8945a"
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 6 do
                local cx = 303 + __mod(k, 3) * 8
                local cy = 150 + math.floor(k / 3) * 9
                R(
                    nil,
                    c,
                    cx,
                    cy,
                    6,
                    6,
                    "#f6efd8"
                )
                R(
                    nil,
                    c,
                    cx + 1,
                    cy + 2,
                    4,
                    2,
                    pick(
                        nil,
                        __arrL({
                            "#e48fb0",
                            "#f08a24",
                            "#e9d6a8",
                            "#c8d8ff",
                            "#a8743a",
                            "#e8433a"
                        }, 6),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    cx + 2,
                    cy - 1,
                    2,
                    2,
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
            284,
            b.floor - 10,
            9,
            2,
            "#6a4428"
        )
        R(
            nil,
            c,
            285,
            b.floor - 8,
            2,
            8,
            "#5a3a20"
        )
        R(
            nil,
            c,
            290,
            b.floor - 8,
            2,
            8,
            "#5a3a20"
        )
        R(
            nil,
            c,
            286,
            b.floor - 18,
            6,
            8,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            287,
            b.floor - 17,
            4,
            6,
            "#f6c86a"
        )
        R(
            nil,
            c,
            287,
            b.floor - 20,
            4,
            2,
            "#3a3a3a"
        )
        R(
            nil,
            c,
            288,
            b.floor - 22,
            2,
            2,
            "#3a3a3a"
        )
        return cv
    end
    local quartoMid = nil
    local function quarto(self, c, s, t, camL)
        if not __t(quartoMid) then
            quartoMid = buildQuarto(nil)
        end
        c:drawImage(quartoMid, 0, 0)
        local b = QT
        do
            local x = QT.PC - 14
            local tela = __get(
                __arrL({"#3c8ae0", "#e05a8a", "#5ae070", "#f2c94c"}, 4),
                __mod(
                    math.floor(t / 2),
                    4
                )
            )
            vgrad(
                nil,
                c,
                x,
                b.floor - 36,
                22,
                13,
                tela,
                "#1e2236"
            )
            R(
                nil,
                c,
                x + 3,
                b.floor - 34,
                16,
                2,
                "#f2efe6"
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        x + 3 + k * 6,
                        b.floor - 30,
                        4,
                        4,
                        pick(
                            nil,
                            __arrL({"#e8433a", "#f2c94c", "#5ae0d0"}, 3),
                            k + math.floor(t)
                        )
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                QT.PC + 13,
                b.floor - 31,
                3,
                1,
                if math.sin(t * 3) > 0 then "#e05a8a" else "#5ae0d0"
            )
        end
        do
            local f = 0.8 + math.sin(t * 13) * 0.1 + math.sin(t * 7) * 0.1
            R(
                nil,
                c,
                287,
                b.floor - 17,
                4,
                6,
                if f > 0.85 then "#ffe39a" else "#f6c86a"
            )
            R(
                nil,
                c,
                288,
                b.floor - 16 - if f > 0.9 then 1 else 0,
                2,
                3,
                "#fff6d0"
            )
        end
        do
            local nt = night(nil, s)
            if __gt(nt, 0.02) then
                c:save()
                c.globalAlpha = nt
                vgrad(
                    nil,
                    c,
                    265,
                    147,
                    26,
                    24,
                    "#0e1630",
                    "#24305a"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            267 + hash(nil, k * 3.1) * 22,
                            149 + hash(nil, k * 5.3) * 10,
                            1,
                            1,
                            if math.sin(t * 2 + k) > -0.3 then "#f6f2ea" else "#8a90a8"
                        )
                        k = k + 1
                    end
                end
                ell(
                    nil,
                    c,
                    284,
                    152,
                    2.5,
                    2.5,
                    "#f6f2d8"
                )
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            268 + k * 5,
                            164 + __mod(k, 2) * 2,
                            1,
                            1,
                            "#f2c94c"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    277,
                    147,
                    2,
                    24,
                    "#5a3a20"
                )
                R(
                    nil,
                    c,
                    265,
                    158,
                    26,
                    2,
                    "#5a3a20"
                )
                c:restore()
            end
        end
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    265 + __mod(t * 4 + k * 9, 24),
                    150 + k * 6,
                    4,
                    1,
                    "rgba(255,255,255,.4)"
                )
                k = k + 1
            end
        end
    end
    local function quartoLights(self, g, s, t, camL)
        local b = QT
        g:save()
        g:beginPath()
        g:rect(b.x0, b.top, b.x1 - b.x0, b.floor - b.top)
        g:clip()
        local f = 0.55 + math.sin(t * 13) * 0.05 + math.sin(t * 7) * 0.04
        local gl = g:createRadialGradient(
            289,
            b.floor - 14,
            2,
            291,
            b.floor - 14,
            60
        )
        gl:addColorStop(
            0,
            ("rgba(255,190,110," .. tostring(f)) .. ")"
        )
        gl:addColorStop(1, "rgba(255,190,110,0)")
        g.fillStyle = gl
        g:fillRect(228, b.top, 102, b.floor - b.top)
        local gp = g:createRadialGradient(
            QT.PC - 3,
            b.floor - 30,
            2,
            QT.PC - 3,
            b.floor - 30,
            40
        )
        gp:addColorStop(0, "rgba(120,170,255,.35)")
        gp:addColorStop(1, "rgba(120,170,255,0)")
        g.fillStyle = gp
        g:fillRect(QT.PC - 45, b.top, 90, b.floor - b.top)
        g:restore()
        lightAdd(
            nil,
            289,
            b.floor - 14,
            0.6,
            50
        )
        lightAdd(
            nil,
            QT.PC,
            b.floor - 30,
            0.4,
            40
        )
    end
    ESC = __ord({W = 1000, Z0 = 640, Z1 = 830}, "W,Z0,Z1")
    local RAMPA = __ord({x0 = 1300, y0 = 440, x1 = 1580, y1 = 200}, "x0,y0,x1,y1")
    local function paredeEscola(self, c, x, w)
        R(
            nil,
            c,
            x,
            24,
            w,
            96,
            "#f4f4f0"
        )
        do
            local y = 30
            while y < 120 do
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    1,
                    "rgba(160,170,180,.10)"
                )
                y = y + 12
            end
        end
        do
            local i = 0
            while i < w * 2 do
                R(
                    nil,
                    c,
                    x + hash(nil, i * 1.1 + x) * w,
                    24 + hash(nil, i * 2.3 + x) * 96,
                    1,
                    1,
                    "rgba(120,130,140,.07)"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            x,
            120,
            w,
            8,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            x,
            120,
            w,
            1,
            "#5a8ad8"
        )
        R(
            nil,
            c,
            x,
            127,
            w,
            1,
            "#1d3a70"
        )
        do
            local y = 128
            while y < 204 do
                do
                    local xx = x + __mod(y / 8, 2) * 6
                    while __lt(
                        xx,
                        __add(x, w)
                    ) do
                        R(
                            nil,
                            c,
                            xx,
                            y,
                            12,
                            8,
                            "#e2e5e8"
                        )
                        R(
                            nil,
                            c,
                            xx,
                            y,
                            12,
                            1,
                            "#eef0f2"
                        )
                        R(
                            nil,
                            c,
                            xx,
                            y,
                            1,
                            8,
                            "#c8ccd0"
                        )
                        xx = xx + 12
                    end
                end
                y = y + 8
            end
        end
        R(
            nil,
            c,
            x,
            204,
            w,
            6,
            "#7a848c"
        )
        R(
            nil,
            c,
            x,
            204,
            w,
            1,
            "#a8b0b6"
        )
    end
    local function janelaEscola(self, c, x, y, w, h)
        R(
            nil,
            c,
            x - 2,
            y - 2,
            w + 4,
            h + 4,
            "#c8ccd0"
        )
        vgrad(
            nil,
            c,
            x,
            y,
            w,
            h,
            "#8ec4e8",
            "#d8ecf4"
        )
        ell(
            nil,
            c,
            x + w * 0.3,
            y + h * 0.35,
            8,
            3,
            "#ffffff"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    x + 2 + k * (w / 5),
                    __add(y, h) - 8 - __mod(k, 2) * 6,
                    w / 6,
                    8 + __mod(k, 2) * 6,
                    "#e8e4d8"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + w / 2 - 1,
            y,
            2,
            h,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            x,
            y + h / 2,
            w,
            2,
            "#c8ccd0"
        )
        reflexo(
            nil,
            c,
            x,
            y,
            w,
            h
        )
        R(
            nil,
            c,
            x - 3,
            __add(y, h) + 2,
            w + 6,
            3,
            "#e8eaec"
        )
    end
    local function buildEscola(self)
        local W = ESC.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        vgrad(
            nil,
            c,
            0,
            0,
            W,
            22,
            "#e8eaec",
            "#c8ccd0"
        )
        R(
            nil,
            c,
            0,
            22,
            W,
            2,
            "#9aa0a6"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    0,
                    1,
                    22,
                    "#d8dce0"
                )
                x = x + 30
            end
        end
        do
            local x = 30
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    8,
                    50,
                    6,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    9,
                    46,
                    4,
                    "#ffffff"
                )
                x = x + 90
            end
        end
        paredeEscola(nil, c, 0, W)
        for ____, x in __iterar((__arrL({140, 440, 880}, 3))) do
            janelaEscola(
                nil,
                c,
                x,
                40,
                54,
                40
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({90, "1º A"}, 2),
                __arrL({300, "2º B"}, 2),
                __arrL({890, "LAB"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local n = ____value[2]
            porta(
                nil,
                c,
                x,
                118,
                34,
                92,
                "#2c5a9e",
                {batente = "#c8ccd0"}
            )
            R(
                nil,
                c,
                x + 8,
                128,
                18,
                22,
                "#9fc4d0"
            )
            R(
                nil,
                c,
                x + 9,
                129,
                16,
                6,
                "#3c8a5a"
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        x + 10 + k * 5,
                        140,
                        3,
                        3,
                        pick(
                            nil,
                            __arrL({"#e0b08a", "#9a6440", "#c88a60"}, 3),
                            k
                        )
                    )
                    R(
                        nil,
                        c,
                        x + 9 + k * 5,
                        143,
                        5,
                        4,
                        "#2c5a9e"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x + 4,
                106,
                26,
                8,
                "#1d3a70"
            )
            R(
                nil,
                c,
                x + 5,
                107,
                24,
                1,
                "#3c6ab0"
            )
            local ____ = n
        end
        do
            local k = 0
            while k < 12 do
                local lx = 150 + k * 12
                R(
                    nil,
                    c,
                    lx,
                    132,
                    11,
                    72,
                    "#2f5f9a"
                )
                R(
                    nil,
                    c,
                    lx + 1,
                    134,
                    9,
                    30,
                    "#4a7ab8"
                )
                R(
                    nil,
                    c,
                    lx + 1,
                    166,
                    9,
                    36,
                    "#4a7ab8"
                )
                R(
                    nil,
                    c,
                    lx + 1,
                    134,
                    1,
                    68,
                    "#6a9ad0"
                )
                do
                    local j = 0
                    while j < 3 do
                        R(
                            nil,
                            c,
                            lx + 3,
                            137 + j * 3,
                            5,
                            1,
                            "#2c5a9e"
                        )
                        R(
                            nil,
                            c,
                            lx + 3,
                            169 + j * 3,
                            5,
                            1,
                            "#2c5a9e"
                        )
                        j = j + 1
                    end
                end
                R(
                    nil,
                    c,
                    lx + 8,
                    158,
                    2,
                    5,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    lx + 8,
                    163,
                    2,
                    2,
                    "#e8c24c"
                )
                if __gt(
                    hash(nil, k),
                    0.55
                ) then
                    ell(
                        nil,
                        c,
                        lx + 5,
                        180,
                        2.5,
                        2.5,
                        pick(
                            nil,
                            __arrL({"#f2c94c", "#e86a8a", "#7ac85a", "#f2efe6"}, 4),
                            k
                        )
                    )
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            380,
            56,
            120,
            50,
            "#8a6a45"
        )
        R(
            nil,
            c,
            383,
            59,
            114,
            44,
            "#c8a46a"
        )
        do
            local i = 0
            while i < 300 do
                R(
                    nil,
                    c,
                    384 + hash(nil, i) * 112,
                    60 + hash(nil, i * 3) * 42,
                    1,
                    1,
                    "#b8945a"
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 10 do
                A:cartaz(
                    c,
                    388 + __mod(k, 5) * 22,
                    62 + math.floor(k / 5) * 20,
                    30 + k
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 4 do
                local dx = 236 + __mod(k, 2) * 30
                local dy = 56 + math.floor(k / 2) * 26
                R(
                    nil,
                    c,
                    dx,
                    dy,
                    24,
                    20,
                    "#f6f2ea"
                )
                R(
                    nil,
                    c,
                    dx,
                    dy,
                    24,
                    1,
                    "#c8c4bc"
                )
                ell(
                    nil,
                    c,
                    dx + 8,
                    dy + 8,
                    4,
                    4,
                    pick(
                        nil,
                        __arrL({"#e8c24c", "#e8433a", "#3c9ad8", "#7ac85a"}, 4),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    dx + 4,
                    dy + 14,
                    16,
                    3,
                    "#5f9a46"
                )
                R(
                    nil,
                    c,
                    dx + 11,
                    dy - 1,
                    2,
                    2,
                    "#c43c3a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            520,
            70,
            90,
            120,
            "#8a8478"
        )
        R(
            nil,
            c,
            522,
            72,
            86,
            116,
            "rgba(200,230,240,.55)"
        )
        do
            local r = 0
            while r < 3 do
                R(
                    nil,
                    c,
                    522,
                    108 + r * 38,
                    86,
                    2,
                    "#e8e4dc"
                )
                do
                    local k = 0
                    while k < 4 do
                        local tx = 528 + k * 20
                        local ty = 98 + r * 38
                        R(
                            nil,
                            c,
                            tx + 3,
                            ty,
                            6,
                            8,
                            "#c8a24a"
                        )
                        R(
                            nil,
                            c,
                            tx + 5,
                            ty + 8,
                            2,
                            4,
                            "#c8a24a"
                        )
                        R(
                            nil,
                            c,
                            tx + 2,
                            ty + 12,
                            8,
                            3,
                            "#8a6a3a"
                        )
                        R(
                            nil,
                            c,
                            tx + 3,
                            ty,
                            2,
                            6,
                            "#f2d898"
                        )
                        k = k + 1
                    end
                end
                r = r + 1
            end
        end
        reflexo(
            nil,
            c,
            522,
            72,
            86,
            116
        )
        R(
            nil,
            c,
            860,
            160,
            20,
            44,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            862,
            160,
            16,
            6,
            "#e8eaec"
        )
        R(
            nil,
            c,
            868,
            156,
            4,
            4,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            840,
            150,
            8,
            20,
            "#c43c3a"
        )
        R(
            nil,
            c,
            841,
            146,
            6,
            4,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            842,
            136,
            6,
            6,
            "#c43c3a"
        )
        R(
            nil,
            c,
            843,
            137,
            4,
            4,
            "#f2efe6"
        )
        ell(
            nil,
            c,
            250,
            40,
            10,
            10,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            250,
            40,
            8,
            8,
            "#f6f8fa"
        )
        R(
            nil,
            c,
            250,
            34,
            1,
            6,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            250,
            40,
            5,
            1,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            30,
            46,
            50,
            16,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            32,
            48,
            46,
            12,
            "#3c6ab0"
        )
        R(
            nil,
            c,
            600,
            26,
            28,
            10,
            "#2c8a3a"
        )
        R(
            nil,
            c,
            602,
            28,
            24,
            6,
            "#4ac06a"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({612, "#2c5a9e"}, 2),
                __arrL({626, "#e8c24c"}, 2),
                __arrL({940, "#c43c3a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            R(
                nil,
                c,
                x,
                186,
                12,
                18,
                col
            )
            R(
                nil,
                c,
                x,
                186,
                12,
                2,
                shadeHex(nil, col, 1.3)
            )
        end
        R(
            nil,
            c,
            960,
            180,
            36,
            4,
            "#8a6a45"
        )
        R(
            nil,
            c,
            962,
            184,
            3,
            20,
            "#5a6066"
        )
        R(
            nil,
            c,
            991,
            184,
            3,
            20,
            "#5a6066"
        )
        local z0 = ESC.Z0
        local z1 = ESC.Z1
        vgrad(
            nil,
            c,
            z0,
            24,
            z1 - z0,
            186,
            "#d8dce0",
            "#b0b8be"
        )
        do
            local y = 30
            while y < 210 do
                R(
                    nil,
                    c,
                    z0,
                    y,
                    z1 - z0,
                    1,
                    "rgba(120,130,140,.12)"
                )
                y = y + 10
            end
        end
        janelaEscola(
            nil,
            c,
            z1 - 52,
            34,
            36,
            28
        )
        R(
            nil,
            c,
            z0 + 70,
            28,
            24,
            4,
            "#f6f8fa"
        )
        R(
            nil,
            c,
            z0 + 72,
            29,
            20,
            2,
            "#ffffff"
        )
        R(
            nil,
            c,
            z0 + 6,
            40,
            40,
            24,
            "#f2c94c"
        )
        R(
            nil,
            c,
            z0 + 8,
            42,
            36,
            20,
            "#f6dc7a"
        )
        R(
            nil,
            c,
            z0 + 12,
            46,
            8,
            12,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            z0 + 24,
            46,
            16,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            z0 + 24,
            52,
            12,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            z0 + 120,
            24,
            30,
            8,
            "#2c8a3a"
        )
        R(
            nil,
            c,
            z0 + 122,
            26,
            26,
            4,
            "#4ac06a"
        )
        local function rampY(____, x)
            return 220 - (x - z0 - 10) * 120 / 140
        end
        do
            local x = z0 + 10
            while x < z0 + 150 do
                local top = math.floor(rampY(nil, x + 10) / 2 + 0.5) * 2
                R(
                    nil,
                    c,
                    x,
                    top,
                    10,
                    220 - top,
                    "#a8b0b6"
                )
                R(
                    nil,
                    c,
                    x,
                    top,
                    10,
                    2,
                    "#e8eaec"
                )
                R(
                    nil,
                    c,
                    x,
                    top + 2,
                    10,
                    1,
                    "#7a8086"
                )
                R(
                    nil,
                    c,
                    x + 9,
                    top,
                    1,
                    220 - top,
                    "#8a9298"
                )
                R(
                    nil,
                    c,
                    x,
                    top,
                    10,
                    1,
                    "#f2c94c"
                )
                x = x + 10
            end
        end
        R(
            nil,
            c,
            z0 + 150,
            100,
            z1 - z0 - 150,
            6,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            z0 + 150,
            100,
            z1 - z0 - 150,
            1,
            "#e8eaec"
        )
        R(
            nil,
            c,
            z0 + 150,
            106,
            z1 - z0 - 150,
            104,
            "#9aa2a8"
        )
        porta(
            nil,
            c,
            z0 + 158,
            54,
            22,
            46,
            "#c47a35",
            {batente = "#c8ccd0", vidro = true}
        )
        R(
            nil,
            c,
            z0 + 156,
            44,
            26,
            7,
            "#2c8a3a"
        )
        R(
            nil,
            c,
            z0 + 157,
            45,
            24,
            5,
            "#4ac06a"
        )
        R(
            nil,
            c,
            z1 - 8,
            84,
            6,
            14,
            "#c43c3a"
        )
        R(
            nil,
            c,
            z1 - 7,
            80,
            4,
            4,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            z1 - 7,
            86,
            4,
            1,
            "#f2efe6"
        )
        ell(
            nil,
            c,
            z0 + 190 - 6,
            94,
            4,
            5,
            "#5f9a46"
        )
        R(
            nil,
            c,
            z0 + 181,
            96,
            6,
            4,
            "#c47a35"
        )
        R(
            nil,
            c,
            z0 + 52,
            110,
            34,
            20,
            "#f6f2ea"
        )
        R(
            nil,
            c,
            z0 + 52,
            110,
            34,
            3,
            "#c43c3a"
        )
        R(
            nil,
            c,
            z0 + 55,
            116,
            22,
            2,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            z0 + 55,
            120,
            26,
            2,
            "#5a5a5a"
        )
        R(
            nil,
            c,
            z0 + 55,
            124,
            18,
            2,
            "#5a5a5a"
        )
        R(
            nil,
            c,
            z0 + 100,
            70,
            26,
            18,
            "#f6f2ea"
        )
        R(
            nil,
            c,
            z0 + 101,
            71,
            24,
            16,
            "#8ec4e8"
        )
        ell(
            nil,
            c,
            z0 + 113,
            80,
            5,
            5,
            "#e8c24c"
        )
        R(
            nil,
            c,
            z0 + 103,
            84,
            20,
            3,
            "#5f9a46"
        )
        R(
            nil,
            c,
            z0 + 8,
            76,
            10,
            6,
            "#e8eaec"
        )
        R(
            nil,
            c,
            z0 + 9,
            77,
            3,
            4,
            "#ffffff"
        )
        R(
            nil,
            c,
            z0 + 14,
            77,
            3,
            4,
            "#ffffff"
        )
        do
            local k = 0
            while k < 15 do
                local x = z0 + 14 + k * 10
                R(
                    nil,
                    c,
                    x,
                    rampY(nil, x) - 22,
                    1,
                    22,
                    "#5a6066"
                )
                k = k + 1
            end
        end
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({z0 + 12, 196}, 2),
                    __arrL({z0 + 152, 76}, 2),
                    __arrL({z1, 76}, 2)
                },
                3
            ),
            2,
            "#2c5a9e"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({z0 + 12, 195}, 2),
                    __arrL({z0 + 152, 75}, 2),
                    __arrL({z1, 75}, 2)
                },
                3
            ),
            1,
            "#5a8ad8"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({z0 + 4, 186}, 2),
                    __arrL({z0 + 4, 100}, 2),
                    __arrL({z0 + 4, 60}, 2)
                },
                3
            ),
            1,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            z0 + 20,
            196,
            22,
            14,
            "#5a4a3a"
        )
        R(
            nil,
            c,
            z0 + 22,
            198,
            18,
            4,
            "#c47a35"
        )
        tilesEscola(nil, c, W)
        do
            local x = 0
            while x < W do
                if __gt(
                    hash(nil, x * 0.9),
                    0.6
                ) then
                    R(
                        nil,
                        c,
                        x,
                        224 + hash(nil, x) * 10,
                        5,
                        1,
                        "rgba(255,255,255,.3)"
                    )
                end
                x = x + 6
            end
        end
        return cv
    end
    local escolaMid = nil
    local PAREDE = nil
    revela = 0
    local revT = 0
    local function buildParede(self)
        local w = ESC.Z1 - ESC.Z0
        local cv, c = table.unpack(
            mk(nil, w, LH),
            1,
            2
        )
        paredeEscola(nil, c, 0, w)
        R(
            nil,
            c,
            0,
            24,
            2,
            186,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            w - 2,
            24,
            2,
            186,
            "#c8ccd0"
        )
        porta(
            nil,
            c,
            14,
            118,
            34,
            92,
            "#c47a35",
            {batente = "#c8ccd0", vidro = true}
        )
        R(
            nil,
            c,
            8,
            100,
            46,
            12,
            "#2c8a3a"
        )
        R(
            nil,
            c,
            10,
            102,
            42,
            8,
            "#4ac06a"
        )
        R(
            nil,
            c,
            12,
            104,
            6,
            4,
            "#f2efe6"
        )
        R(
            nil,
            c,
            70,
            50,
            100,
            46,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            72,
            52,
            96,
            42,
            "#f2c94c"
        )
        R(
            nil,
            c,
            76,
            56,
            88,
            6,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            76,
            66,
            60,
            4,
            "#5a4a10"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({150, 88}, 2),
                    __arrL({158, 72}, 2),
                    __arrL({166, 88}, 2)
                },
                3
            ),
            2,
            "#2a2a2a"
        )
        janelaEscola(
            nil,
            c,
            120,
            140,
            50,
            40
        )
        return cv
    end
    local function escola(self, c, s, t, camL)
        if not __t(escolaMid) then
            escolaMid = buildEscola(nil)
        end
        if not __t(PAREDE) then
            PAREDE = buildParede(nil)
        end
        c:drawImage(
            escolaMid,
            camL,
            0,
            LW(nil),
            LH,
            0,
            0,
            LW(nil),
            LH
        )
        local hx = HERO(nil).x / 2
        local dentro = hx > ESC.Z0 + 6 and hx < ESC.Z1
        local dt = math.max(
            0,
            math.min(0.05, t - revT)
        )
        revT = t
        revela = cl(nil, revela + if __t(dentro) then dt * 3.5 else -dt * 3)
        do
            local i = 0
            while i < 10 do
                local wx = 40 + i * 100 + math.sin(t * 0.4 + i) * 30
                local sx = wx - camL
                local ____t_6 = __t
                local ____t_5 = __t
                local ____vis_result_4 = vis(nil, sx, 20)
                __O[431] = ____vis_result_4
                if ____t_6(if ____t_5(____vis_result_4) then wx < ESC.Z0 - 10 or wx > ESC.Z1 + 10 else __O[431]) then
                    pessoa(
                        nil,
                        c,
                        sx,
                        216,
                        i
                    )
                    R(
                        nil,
                        c,
                        sx - 1,
                        202,
                        7,
                        2,
                        "#2c5a9e"
                    )
                end
                i = i + 1
            end
        end
        local x = ESC.Z0 - camL
        if __t(vis(nil, x, 200)) then
            c:save()
            c.globalAlpha = 1 - revela
            c:drawImage(PAREDE, x, 0)
            c:restore()
        end
        apagao(nil, c, camL)
    end
    local function escolaLights(self, g, s, t, camL)
        if revela > 0.5 then
            lightAdd(
                nil,
                ESC.Z0 + 82 - camL,
                30,
                0.35,
                70
            )
            return
        end
        do
            local x = 30
            while x < ESC.W do
                local sx = x + 25 - camL
                if __t(vis(nil, sx)) then
                    lightAdd(
                        nil,
                        sx,
                        12,
                        0.3,
                        60
                    )
                end
                x = x + 90
            end
        end
    end
    local PT = {W = 1100}
    local function buildPatio(self)
        local W = PT.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            150,
            W,
            56,
            "#e8e8e2"
        )
        R(
            nil,
            c,
            0,
            150,
            W,
            2,
            "#ffffff"
        )
        R(
            nil,
            c,
            0,
            176,
            W,
            6,
            "#2c5a9e"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    128,
                    1,
                    22,
                    "#5a6a7a"
                )
                x = x + 6
            end
        end
        R(
            nil,
            c,
            0,
            126,
            W,
            3,
            "#3c4c5c"
        )
        R(
            nil,
            c,
            0,
            126,
            W,
            1,
            "#7a8a9a"
        )
        R(
            nil,
            c,
            0,
            52,
            620,
            8,
            "#8a949a"
        )
        R(
            nil,
            c,
            0,
            52,
            620,
            2,
            "#c8ccd0"
        )
        do
            local x = 0
            while x < 620 do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 60}, 2),
                            __arrL({x + 5, 68}, 2),
                            __arrL({x + 10, 60}, 2)
                        },
                        3
                    ),
                    1,
                    "#9aa4aa"
                )
                x = x + 10
            end
        end
        R(
            nil,
            c,
            0,
            68,
            620,
            2,
            "#7a848a"
        )
        for ____, x in __iterar((__arrL({10, 200, 400, 600}, 4))) do
            R(
                nil,
                c,
                x,
                70,
                6,
                140,
                "#7a848a"
            )
            R(
                nil,
                c,
                x,
                70,
                2,
                140,
                "#a8b0b6"
            )
        end
        plaster(
            nil,
            c,
            40,
            92,
            150,
            114,
            "#f2e6c8",
            270
        )
        R(
            nil,
            c,
            40,
            92,
            150,
            12,
            "#c43c3a"
        )
        R(
            nil,
            c,
            40,
            92,
            150,
            2,
            "#e86a6a"
        )
        R(
            nil,
            c,
            52,
            110,
            60,
            34,
            "#2a2e34"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    56,
                    114 + k * 6,
                    30,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    90,
                    114 + k * 6,
                    16,
                    2,
                    "#f2c94c"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            120,
            110,
            60,
            40,
            "#9fc4d0"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    124 + __mod(k, 3) * 18,
                    118 + math.floor(k / 3) * 14,
                    14,
                    10,
                    pick(
                        nil,
                        __arrL({"#e8b85a", "#c4743a", "#f2efe6", "#e8433a"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        reflexo(
            nil,
            c,
            120,
            110,
            60,
            40
        )
        pessoa(
            nil,
            c,
            150,
            166,
            3
        )
        vgrad(
            nil,
            c,
            44,
            164,
            142,
            42,
            "#e2e6ea",
            "#8a9298"
        )
        R(
            nil,
            c,
            44,
            164,
            142,
            2,
            "#f6f8fa"
        )
        R(
            nil,
            c,
            44,
            170,
            142,
            3,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 3 do
                local tx = 230 + k * 120
                R(
                    nil,
                    c,
                    tx,
                    186,
                    70,
                    6,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    tx,
                    186,
                    70,
                    1,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    tx + 10,
                    192,
                    6,
                    18,
                    "#8a9096"
                )
                R(
                    nil,
                    c,
                    tx + 54,
                    192,
                    6,
                    18,
                    "#8a9096"
                )
                R(
                    nil,
                    c,
                    tx - 4,
                    198,
                    78,
                    4,
                    "#8a9096"
                )
                do
                    local j = 0
                    while j < 3 do
                        R(
                            nil,
                            c,
                            tx + 8 + j * 22,
                            182,
                            8,
                            4,
                            pick(
                                nil,
                                __arrL({"#f2efe6", "#e8c24c", "#c43c3a"}, 3),
                                j + k
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            650,
            90,
            160,
            116,
            "#f2f2ee"
        )
        do
            local i = 0
            while i < 400 do
                R(
                    nil,
                    c,
                    654 + __mod(i, 38) * 4,
                    94 + math.floor(i / 38) * 4,
                    3,
                    3,
                    pick(
                        nil,
                        __arrL({
                            "#e8433a",
                            "#f2c94c",
                            "#3c9ad8",
                            "#7ac85a",
                            "#c86ab8",
                            "#f08a24",
                            "#2c5a9e"
                        }, 7),
                        math.floor(hash(nil, i) * 7) + if __mod(i, 7) == 0 then 1 else 0
                    )
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 6 do
                ell(
                    nil,
                    c,
                    700 + k * 12,
                    140 + math.sin(k) * 6,
                    6,
                    6,
                    "#f6f2ea"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            690,
            170,
            80,
            10,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            850,
            182,
            90,
            6,
            "#2c7a4a"
        )
        R(
            nil,
            c,
            850,
            182,
            90,
            1,
            "#4aa06a"
        )
        R(
            nil,
            c,
            894,
            176,
            2,
            6,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            856,
            188,
            4,
            22,
            "#5a6066"
        )
        R(
            nil,
            c,
            930,
            188,
            4,
            22,
            "#5a6066"
        )
        do
            local x = 850
            while x < 940 do
                R(
                    nil,
                    c,
                    x,
                    177 + if __t(__mod(x, 4)) then 0 else 1,
                    1,
                    5,
                    "#e8eaec"
                )
                x = x + 2
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({970, "#2c5a9e"}, 2),
                __arrL({986, "#e8c24c"}, 2),
                __arrL({1002, "#c43c3a"}, 2),
                __arrL({1018, "#3c8a5a"}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            R(
                nil,
                c,
                x,
                186,
                14,
                20,
                col
            )
            R(
                nil,
                c,
                x,
                186,
                14,
                2,
                shadeHex(nil, col, 1.3)
            )
        end
        for ____, x in __iterar((__arrL({212, 612, 820, 1060}, 4))) do
            R(
                nil,
                c,
                x,
                190,
                16,
                20,
                "#8a8478"
            )
            do
                local k = 0
                while k < 7 do
                    ell(
                        nil,
                        c,
                        x + 3 + k * 2,
                        182 - __mod(k, 3) * 5,
                        4,
                        5,
                        if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            1040,
            70,
            4,
            140,
            "#c43c3a"
        )
        R(
            nil,
            c,
            1026,
            70,
            30,
            20,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            1034,
            86,
            14,
            4,
            "#e86a3a"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({1036, 90}, 2),
                    __arrL({1046, 104}, 2)
                },
                2
            ),
            1,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            6,
            106,
            48,
            104,
            "#dfe2e4"
        )
        porta(
            nil,
            c,
            12,
            118,
            34,
            92,
            "#c47a35",
            {batente = "#c8ccd0", vidro = true}
        )
        R(
            nil,
            c,
            8,
            100,
            44,
            10,
            "#3c8a5a"
        )
        tilesEscola(nil, c, W)
        do
            local x = 0
            while x < W do
                if __gt(
                    hash(nil, x),
                    0.7
                ) then
                    R(
                        nil,
                        c,
                        x,
                        212 + hash(nil, x * 3) * 50,
                        2,
                        1,
                        "rgba(255,255,255,.3)"
                    )
                end
                x = x + 3
            end
        end
        return cv
    end
    local patioMid = nil
    local function patio(self, c, s, t, camL)
        if not __t(patioMid) then
            patioMid = buildPatio(nil)
        end
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 27, kites = true}
        )
        c:drawImage(
            patioMid,
            camL,
            0,
            LW(nil),
            LH,
            0,
            0,
            LW(nil),
            LH
        )
        do
            local bx = 895 + math.sin(t * 3) * 40 - camL
            local by = 172 - math.abs(math.sin(t * 6)) * 14
            if __t(vis(nil, bx, 10)) then
                R(
                    nil,
                    c,
                    bx,
                    by,
                    2,
                    2,
                    "#f6f2ea"
                )
            end
            for ____, k in __iterar((__arrL({0, 1}, 2))) do
                local px = 862 + k * 70 - camL
                if __t(vis(nil, px, 20)) then
                    pessoa(
                        nil,
                        c,
                        px,
                        216,
                        k + 4
                    )
                end
            end
        end
        do
            local i = 0
            while i < 12 do
                local wx = 220 + __mod(i, 6) * 60 + math.sin(t * 0.5 + i) * if i > 5 then 50 else 2
                local sx = wx - camL
                if __t(vis(nil, sx, 20)) then
                    pessoa(
                        nil,
                        c,
                        sx,
                        if i > 5 then 216 else 202,
                        i
                    )
                    R(
                        nil,
                        c,
                        sx - 1,
                        if i > 5 then 216 else 202 - 14,
                        7,
                        2,
                        "#2c5a9e"
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 1040 - camL + math.sin(t * 1.3) * 12
            local y = 120 - math.abs(math.sin(t * 2.6)) * 30
            if __t(vis(nil, x, 20)) then
                ell(
                    nil,
                    c,
                    x,
                    y,
                    4,
                    4,
                    "#e8833a"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    2,
                    2,
                    "#2a2a2a"
                )
            end
        end
    end
    local function patioLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.03) then
            return
        end
        for ____, x in __iterar((__arrL({100, 300, 500}, 3))) do
            lampGlow(
                nil,
                g,
                x - camL,
                70,
                a
            )
        end
    end
    local function indoor(____, k)
        return function(____, s) return A:mix(
            s.amb,
            __arrL({1, 1, 1}, 3),
            k
        ) end
    end
    local REG = window.CampanhaCenarios.registrar
    REG(
        nil,
        __ord(
            {
                id = 22,
                key = "frente-shopping",
                nome = "Frente do Shopping",
                lugar = "Estacionamento e entrada do Shopping Conquista",
                grupo = "ambiente",
                width = FR.W * 2,
                draw = frente,
                lights = frenteLights,
                plat = function(____, c, x, y, w, t) return window.CampanhaCenarios:plataforma(
                    c,
                    16,
                    __arrL({x, y, w}, 3),
                    t
                ) end,
                labels = __arrL(
                    {
                        __arrL({
                            FR.ENT,
                            43,
                            "SHOPPING CONQUISTA",
                            12,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            405,
                            121,
                            "AMENICANAS",
                            9,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            955,
                            121,
                            "RIACHORRO",
                            9,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            1160,
                            46,
                            "SHOPPING",
                            5,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            241,
                            152,
                            "E",
                            8,
                            "#2c5aa8"
                        }, 5),
                        __arrL({
                            FR.ENT,
                            132,
                            "ENTRADA",
                            6,
                            "#2c4656"
                        }, 5),
                        __arrL({
                            600,
                            170,
                            "EM CARTAZ",
                            5,
                            "#f2c94c"
                        }, 5)
                    },
                    7
                ),
                interact = __arrL(
                    {
                        __arrL({"trash", 2220}, 2),
                        __arrL({"pot", 900}, 2),
                        __arrL({"cone", 640}, 2),
                        __arrL({"cone", 700}, 2),
                        __arrL({"crate", 2400}, 2),
                        __arrL({"ball", 1700}, 2),
                        __arrL({"puddle", 2000, 70}, 3)
                    },
                    7
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({300, 384, 150}, 3),
                        __arrL({490, 328, 140}, 3),
                        __arrL({1800, 384, 150}, 3),
                        __arrL({1990, 328, 140}, 3)
                    },
                    4
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
                id = 23,
                key = "shopping-piso2",
                nome = "Shopping · piso 2",
                lugar = "Lojas do segundo andar",
                grupo = "ambiente",
                width = P2.W * 2,
                draw = piso2,
                lights = piso2Lights,
                amb = indoor(nil, 0.8),
                plat = function(____, c, x, y, w, t, sd) return window.CampanhaCenarios:plataforma(
                    c,
                    20,
                    __arrL({x, y, w}, 3),
                    t
                ) end,
                labels = __call(
                    __call(
                        LOJAS2,
                        "map",
                        function(____, ____bindingPattern0, i)
                            local n
                            n = ____bindingPattern0[1]
                            return __arrL({
                                200 + i * 150 + 77,
                                SHOP.TOP + 10,
                                n,
                                if __len(n) > 12 then 5 else 7,
                                "#f6f2ea"
                            }, 5)
                        end
                    ),
                    "concat",
                    __arrL(
                        {__arrL({
                            110,
                            150,
                            "DESCE ↓",
                            6,
                            "#5a6a72"
                        }, 5)},
                        1
                    )
                ),
                interact = __arrL(
                    {
                        __arrL({"pot", 600}, 2),
                        __arrL({"pot", 3000}, 2),
                        __arrL({"trash", 1500}, 2),
                        __arrL({"trash", 2600}, 2),
                        __arrL({"crate", 3100}, 2),
                        __arrL({"ball", 2000}, 2)
                    },
                    6
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({800, 384, 150}, 3),
                        __arrL({990, 328, 140}, 3),
                        __arrL({2300, 384, 150}, 3),
                        __arrL({2490, 328, 140}, 3)
                    },
                    4
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
                id = 24,
                key = "corredor-pensao",
                nome = "Corredor da pensão",
                lugar = "Pensão de Dona Lurdes · corredor dos quartos",
                grupo = "ambiente",
                width = COR.W * 2,
                draw = corredor,
                lights = corredorLights,
                amb = indoor(nil, 0.5),
                limites = __arrL({(COR.x0 + 6) * 2, (COR.x1 - 6) * 2}, 2),
                labels = __call(
                    __call(
                        COR.Q,
                        "map",
                        function(____, ____bindingPattern0)
                            local n
                            local x
                            x = ____bindingPattern0[1]
                            n = ____bindingPattern0[2]
                            return __arrL({
                                x + 8,
                                177,
                                n,
                                3,
                                "#5a3a20"
                            }, 5)
                        end
                    ),
                    "concat",
                    __arrL(
                        {
                            __arrL({
                                214,
                                184,
                                "CADÊ MEU RÁDIO? —LURDES",
                                2,
                                "#c43c3a"
                            }, 5),
                            __arrL({
                                COR.ENT + 8,
                                176,
                                "RUA",
                                3,
                                "#f2efe6"
                            }, 5)
                        },
                        2
                    )
                ),
                interact = __arrL({}, 0)
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,limites,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL({}, 0),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 25,
                key = "quarto",
                nome = "Quarto do Da Roça",
                lugar = "Pensão de Dona Lurdes · quarto 4",
                grupo = "ambiente",
                width = QT.W * 2,
                draw = quarto,
                lights = quartoLights,
                amb = indoor(nil, 0.38),
                limites = __arrL({(QT.x0 + 6) * 2, (QT.x1 - 6) * 2}, 2),
                labels = __arrL(
                    {__arrL({
                        QT.PC - 3,
                        179,
                        "FLIPERAMA",
                        3,
                        "#f2efe6"
                    }, 5)},
                    1
                ),
                interact = __arrL({}, 0)
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,limites,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL({}, 0),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 26,
                key = "escola-terreo",
                nome = "Escola SESI · térreo",
                lugar = "Corredor das salas e a escada para o pátio",
                grupo = "ambiente",
                width = ESC.W * 2,
                draw = escola,
                lights = escolaLights,
                amb = indoor(nil, 0.8),
                labelAlpha = function() return 1 - revela end,
                labels = __arrL(
                    {
                        __arrL({
                            55,
                            54,
                            "BEM-VINDO AO SESI",
                            4,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            107,
                            110,
                            "1º A",
                            4,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            317,
                            110,
                            "2º B",
                            4,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            917,
                            110,
                            "LAB",
                            4,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            ESC.Z0 + 31,
                            106,
                            "ESCADA",
                            4,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            ESC.Z0 + 120,
                            76,
                            "PÁTIO NO 2º ANDAR ↑",
                            5,
                            "#5a4a10"
                        }, 5),
                        __arrL({
                            ESC.Z0 + 30,
                            56,
                            "SUBA",
                            4,
                            "#f2f2ee"
                        }, 5),
                        __arrL({
                            440,
                            50,
                            "MURAL",
                            5,
                            "#5a3a20"
                        }, 5),
                        __arrL({
                            565,
                            64,
                            "TROFÉUS",
                            5,
                            "#5a5a5a"
                        }, 5)
                    },
                    9
                ),
                interact = __arrL(
                    {
                        __arrL({"trash", 700}, 2),
                        __arrL({"ball", 1000}, 2),
                        __arrL({"pot", 1900}, 2)
                    },
                    3
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,amb,labelAlpha,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL({}, 0),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    REG(
        nil,
        __ord(
            {
                id = 27,
                key = "patio",
                nome = "Pátio · 2º andar",
                lugar = "Pátio da Escola SESI, com vista da cidade",
                grupo = "ambiente",
                width = PT.W * 2,
                draw = patio,
                lights = patioLights,
                plat = function(____, c, x, y, w, t) return window.CampanhaCenarios:plataforma(
                    c,
                    21,
                    __arrL({x, y, w}, 3),
                    t
                ) end,
                labels = __arrL(
                    {
                        __arrL({
                            115,
                            98,
                            "CANTINA",
                            7,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            730,
                            176,
                            "GRÊMIO ESTUDANTIL",
                            5,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            30,
                            105,
                            "↓ ESCADA",
                            4,
                            "#ffffff"
                        }, 5)
                    },
                    3
                ),
                interact = __arrL(
                    {
                        __arrL({"ball", 1400}, 2),
                        __arrL({"ball", 1460}, 2),
                        __arrL({"trash", 1900}, 2),
                        __arrL({"pot", 1240}, 2),
                        __arrL({"cone", 1600}, 2)
                    },
                    5
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({1300, 384, 150}, 3),
                        __arrL({1490, 328, 140}, 3),
                        __arrL({1680, 272, 140}, 3)
                    },
                    3
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    )
    local PORTAIS = __arrL(
        {
            __ord(
                {
                    cena = 22,
                    x = FR.ENT * 2,
                    tipo = "porta",
                    rotulo = "ENTRAR NO SHOPPING",
                    para = __ord({cena = 20, x = 180}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 20,
                    x = 90,
                    tipo = "porta",
                    rotulo = "SAIR DO SHOPPING",
                    para = __ord({cena = 22, x = FR.ENT * 2}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 20,
                    x = SHOP.ESC * 2 + 20,
                    tipo = "rolante",
                    rotulo = "SUBIR A ESCADA ROLANTE",
                    de = __arrL({SHOP.ESC * 2 + 12, 420}, 2),
                    ate = __arrL({SHOP.ESC * 2 + 224, 192}, 2),
                    para = __ord({cena = 23, x = (P2.ESC + 150) * 2}, "cena,x")
                },
                "cena,x,tipo,rotulo,de,ate,para"
            ),
            __ord(
                {
                    cena = 23,
                    x = (P2.ESC + 130) * 2,
                    tipo = "rolante",
                    rotulo = "DESCER A ESCADA ROLANTE",
                    de = __arrL({(P2.ESC + 124) * 2, 440}, 2),
                    ate = __arrL({(P2.ESC + 20) * 2, 540}, 2),
                    para = __ord({cena = 20, x = SHOP.ESC * 2 - 30}, "cena,x")
                },
                "cena,x,tipo,rotulo,de,ate,para"
            ),
            __ord(
                {
                    cena = 13,
                    x = (780 + 144) * 2,
                    tipo = "porta",
                    rotulo = "ENTRAR NA PENSÃO",
                    para = __ord({cena = 24, x = (COR.ENT + 8) * 2 + 30}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 24,
                    x = (COR.ENT + 8) * 2,
                    tipo = "porta",
                    rotulo = "SAIR PARA A RUA",
                    para = __ord({cena = 13, x = (780 + 144) * 2}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 24,
                    x = (__get(
                        __get(COR.Q, 3),
                        0
                    ) + 8) * 2,
                    tipo = "porta",
                    rotulo = "ENTRAR NO QUARTO 4",
                    para = __ord({cena = 25, x = (QT.x0 + 10) * 2 + 24}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 25,
                    x = (QT.x0 + 10) * 2,
                    tipo = "porta",
                    rotulo = "SAIR PARA O CORREDOR",
                    para = __ord(
                        {
                            cena = 24,
                            x = (__get(
                                __get(COR.Q, 3),
                                0
                            ) + 8) * 2
                        },
                        "cena,x"
                    )
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord({cena = 25, x = QT.ARM * 2, tipo = "armario", rotulo = "ABRIR O ARMÁRIO (ROUPAS)"}, "cena,x,tipo,rotulo"),
            __ord({cena = 25, x = QT.PC * 2, tipo = "pc", rotulo = "USAR O COMPUTADOR (FLIPERAMA)"}, "cena,x,tipo,rotulo"),
            __ord({cena = 25, x = 628, tipo = "poderes", rotulo = "MURAL DOS PODERES"}, "cena,x,tipo,rotulo"),
            __ord(
                {
                    cena = 21,
                    x = (1250 + 720) * 2,
                    tipo = "porta",
                    rotulo = "ENTRAR NA ESCOLA",
                    para = __ord({cena = 26, x = 120}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 26,
                    x = 70,
                    tipo = "porta",
                    rotulo = "SAIR DA ESCOLA",
                    para = __ord({cena = 21, x = (1250 + 720) * 2}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            ),
            __ord(
                {
                    cena = 26,
                    tipo = "rampa",
                    x0 = RAMPA.x0,
                    y0 = RAMPA.y0,
                    x1 = RAMPA.x1,
                    y1 = RAMPA.y1,
                    para = __ord({cena = 27, x = 130}, "cena,x")
                },
                "cena,tipo,x0,y0,x1,y1,para"
            ),
            __ord(
                {
                    cena = 27,
                    x = 58,
                    tipo = "porta",
                    rotulo = "DESCER A ESCADA",
                    para = __ord({cena = 26, x = RAMPA.x0 - 50}, "cena,x")
                },
                "cena,x,tipo,rotulo,para"
            )
        },
        15
    )
    window.CampanhaAmbientes = __ord(
        {
            portais = function(____, cena) return __call(
                PORTAIS,
                "filter",
                function(____, p) return p.cena == cena end
            ) end,
            todos = function() return __call(PORTAIS, "slice") end,
            rampa = RAMPA,
            cobrir = function(____, c, cena, camera)
                if __t(cena ~= 26 or revela <= 0.01) then
                    return
                end
                local camL = math.floor(camera / 2)
                local sub = math.floor(camera + 0.5) - camL * 2
                c:save()
                c:translate(-sub, 0)
                c:scale(2, 2)
                apagao(nil, c, camL)
                c:restore()
            end
        },
        "portais,todos,rampa,cobrir"
    )
end)(nil)
return ____exports
