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
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.CampanhaNovos)
    __O[467] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[467]
    else
        ____t_result_2 = window.CampanhaNovos.b
    end
    if ____t_3(____t_result_2) then
        return
    end
    local CC = window.CampanhaCenarios
    local A = CC.arte
    local K = window.CampanhaCamadas.kit
    local N = window.CampanhaNovos
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
    local gente = A.gente
    local pessoa = A.pessoa
    local plaster = A.plaster
    local roofTiles = A.roofTiles
    local cachorro = A.cachorro
    local lampPost = A.lampPost
    local bench = A.bench
    local ipe = A.ipe
    local fog = A.fog
    local conquistaBack = A.conquistaBack
    local objetos = A.objetos
    local chaoDetalhe = A.chaoDetalhe
    local terra = A.terra
    local pedraPortuguesa = A.pedraPortuguesa
    local grafite = A.grafite
    local Q = A.Q
    local sombra = A.sombra
    local lerpC = A.lerpC
    local GY = A.GY
    local bandeirinhas = A.bandeirinhas
    local pxText = K.pxText
    local pessoinha = K.pessoinha
    local arvoreM = K.arvoreM
    local nevoa = K.nevoa
    local noiteTile = K.noiteTile
    local scr = K.scr
    local wrap = K.wrap
    local balao = K.balao
    local SKIN = K.SKIN
    local ROUPA = K.ROUPA
    local T = K.T
    local LW = 482
    local LH = 270
    local TAU = math.pi * 2
    local drawMid = N.drawMid
    local LAG = __ord({
        W = 2600,
        PIER = 900,
        QUIOSQUE = 1480,
        PEDAL = 2020,
        ILHA = 1300
    }, "W,PIER,QUIOSQUE,PEDAL,ILHA")
    local F32 = {}
    local function buildMargem(self)
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
        do
            local x = 0
            local i = 0
            while __lt(x, T) do
                local w = 14 + math.floor(hash(nil, i + 32) * 16 + 0.5)
                local h = 8 + math.floor(hash(nil, i + 33) * 18 + 0.5)
                if __gt(
                    hash(nil, i + 34),
                    0.45
                ) then
                    local col = pick(
                        nil,
                        __arrL({
                            "#f2e6d0",
                            "#e8d0c0",
                            "#d8e0e8",
                            "#f2e2a8",
                            "#f6f2e8"
                        }, 5),
                        i
                    )
                    R(
                        nil,
                        c,
                        x,
                        162 - h,
                        w,
                        h,
                        col
                    )
                    R(
                        nil,
                        c,
                        x + w - 2,
                        162 - h,
                        2,
                        h,
                        shadeHex(nil, col, 0.82)
                    )
                    roofTiles(
                        nil,
                        c,
                        x - 1,
                        159 - h,
                        w + 2,
                        3,
                        pick(
                            nil,
                            __arrL({"#b8644a", "#a8543c"}, 2),
                            i
                        )
                    )
                    do
                        local k = 0
                        while k < math.floor(w / 6) do
                            R(
                                nil,
                                c,
                                x + 2 + k * 6,
                                165 - h,
                                3,
                                3,
                                "#5a7a8a"
                            )
                            if __gt(
                                hash(nil, i * 7 + k),
                                0.5
                            ) then
                                R(
                                    nil,
                                    n,
                                    x + 2 + k * 6,
                                    165 - h,
                                    3,
                                    3,
                                    "#ffd98a"
                                )
                            end
                            k = k + 1
                        end
                    end
                else
                    do
                        local k = 0
                        while k < 5 do
                            ell(
                                nil,
                                c,
                                x + w / 2 + (k - 2) * 4,
                                154 - hash(nil, i * 5 + k) * 10,
                                6,
                                6,
                                pick(
                                    nil,
                                    __arrL({"#4f7a46", "#5f8a52", "#6a9a5a"}, 3),
                                    i + k
                                )
                            )
                            k = k + 1
                        end
                    end
                end
                x = x + (w + 2)
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            160,
            T,
            4,
            "#6a8a52"
        )
        R(
            nil,
            c,
            0,
            163,
            T,
            1,
            "#8a8a7a"
        )
        nevoa(nil, c, T, "rgba(200,214,226,.22)")
        local rv, r = table.unpack(
            mk(nil, T, 40),
            1,
            2
        )
        r:save()
        r:translate(0, 40)
        r:scale(1, -1)
        r:drawImage(
            cv,
            0,
            124,
            T,
            40,
            0,
            0,
            T,
            40
        )
        r:restore()
        return {cv = cv, nv = nv, rv = rv}
    end
    local function buildLagoa(self)
        local W = LAG.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            200,
            W,
            12,
            "#5f8a46"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    199 - math.floor(hash(nil, x) * 3 + 0.5),
                    2,
                    3,
                    "#7aa856"
                )
                x = x + 3
            end
        end
        do
            local x = 0
            while x < W do
                do
                    if __t(math.abs(x - LAG.PIER - 30) < 50 or math.abs(x - LAG.PEDAL - 40) < 60) then
                        do x = x + 40 continue end
                    end
                    R(
                        nil,
                        c,
                        x,
                        192,
                        3,
                        18,
                        "#7a5a3a"
                    )
                    R(
                        nil,
                        c,
                        x,
                        192,
                        1,
                        18,
                        "#a8845a"
                    )
                    R(
                        nil,
                        c,
                        x,
                        195,
                        40,
                        2,
                        "#8a6a45"
                    )
                    R(
                        nil,
                        c,
                        x,
                        202,
                        40,
                        2,
                        "#8a6a45"
                    )
                end
                x = x + 40
            end
        end
        local p = LAG.PIER
        do
            local k = 0
            while k < 20 do
                local y = 206 - k
                local w = 60 - k * 1.5
                R(
                    nil,
                    c,
                    p + 30 - w / 2,
                    y,
                    w,
                    1,
                    __t(__mod(k, 3)) and "#a87a4a" or "#8a5a32"
                )
                k = k + 1
            end
        end
        for ____, dx in __iterar((__arrL({-26, 24}, 2))) do
            R(
                nil,
                c,
                p + 30 + dx,
                190,
                2,
                16,
                "#6a4a2a"
            )
        end
        R(
            nil,
            c,
            p + 30 - 1,
            172,
            2,
            14,
            "#6a4a2a"
        )
        local q = LAG.QUIOSQUE
        do
            local k = 0
            while k < 18 do
                R(
                    nil,
                    c,
                    q - 8 + k * 0.8,
                    132 + k * 1.6,
                    112 - k * 1.6,
                    2,
                    __t(__mod(k, 2)) and "#c8a050" or "#b88a3a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            q + 4,
            160,
            4,
            50,
            "#7a5a3a"
        )
        R(
            nil,
            c,
            q + 88,
            160,
            4,
            50,
            "#7a5a3a"
        )
        R(
            nil,
            c,
            q,
            176,
            96,
            34,
            "#8a6a45"
        )
        R(
            nil,
            c,
            q,
            176,
            96,
            3,
            "#c4955c"
        )
        do
            local k = 0
            while k < 10 do
                ell(
                    nil,
                    c,
                    q + 10 + __mod(k, 5) * 18,
                    186 + math.floor(k / 5) * 9,
                    5,
                    4,
                    "#5a9a3a"
                )
                ell(
                    nil,
                    c,
                    q + 9 + __mod(k, 5) * 18,
                    185 + math.floor(k / 5) * 9,
                    2,
                    2,
                    "#7ac85a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            q + 20,
            162,
            56,
            10,
            "#2c8a5a"
        )
        pxText(
            nil,
            c,
            "AGUA DE COCO",
            q + 48,
            165,
            "#ffffff"
        )
        local d = LAG.PEDAL
        do
            local k = 0
            while k < 12 do
                R(
                    nil,
                    c,
                    d + k * 8,
                    204 - __mod(k, 2),
                    7,
                    6,
                    "#a87a4a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            d + 10,
            160,
            60,
            14,
            "#3c8ad8"
        )
        R(
            nil,
            c,
            d + 12,
            162,
            56,
            10,
            "#5aa0e8"
        )
        pxText(
            nil,
            c,
            "PEDALINHO R$10",
            d + 40,
            165,
            "#ffffff"
        )
        R(
            nil,
            c,
            d + 38,
            174,
            3,
            30,
            "#5a5e62"
        )
        do
            local k = 0
            while k < 3 do
                local ax = 300 + k * 34
                R(
                    nil,
                    c,
                    ax,
                    186,
                    3,
                    24,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#3c8ad8", "#e8c24c"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    ax + 20,
                    186,
                    3,
                    24,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#3c8ad8", "#e8c24c"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    ax,
                    186,
                    23,
                    3,
                    pick(
                        nil,
                        __arrL({"#e8433a", "#3c8ad8", "#e8c24c"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        do
            local lx = 60
            while lx < W do
                lampPost(nil, c, lx, 130)
                lx = lx + 220
            end
        end
        for ____, bx in __iterar((__arrL({520, 1200, 1800, 2380}, 4))) do
            bench(
                nil,
                c,
                bx,
                212,
                40,
                "#8a6a45",
                "#c4955c"
            )
        end
        objetos(
            nil,
            c,
            32,
            W,
            "cidade",
            40,
            W - 40,
            __arrL({160, 260}, 2)
        )
        R(
            nil,
            c,
            0,
            212,
            W,
            8,
            "#cfc8b6"
        )
        R(
            nil,
            c,
            0,
            220,
            W,
            LH - 220,
            "#b4523a"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    220 + hash(nil, x * 1.3) * 50,
                    1,
                    1,
                    "#c45e44"
                )
                x = x + 2
            end
        end
        R(
            nil,
            c,
            0,
            244,
            W,
            1,
            "#f2e8dc"
        )
        do
            local x = 50
            while x < W do
                pxText(
                    nil,
                    c,
                    tostring(x * 2) .. "M",
                    x,
                    250,
                    "#f2e8dc"
                )
                x = x + 100
            end
        end
        R(
            nil,
            c,
            0,
            220,
            W,
            2,
            "#e8e4dc"
        )
        chaoDetalhe(nil, c, W, "cidade")
        return cv
    end
    local function lagoa(self, c, s, t, camL)
        if not __t(F32.mid) then
            F32.m = buildMargem(nil)
            F32.mid = buildLagoa(nil)
        end
        local nt = night(nil, s)
        local sun = A:sunInfo(s)
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 32, trees = false}
        )
        c:save()
        c:translate(0, -16)
        tile(nil, c, F32.m.cv, camL * 0.2)
        noiteTile(
            nil,
            c,
            s,
            F32.m.nv,
            camL * 0.2
        )
        c:restore()
        local top = 148
        local bot = 204
        vgrad(
            nil,
            c,
            0,
            top,
            LW,
            bot - top,
            lerpC(nil, "#7ab8e0", "#1c2a44", nt),
            lerpC(nil, "#3a7aa8", "#0e1626", nt)
        )
        do
            c:save()
            c.globalAlpha = 0.2
            local o = __mod(
                __mod(
                    math.floor(camL * 0.2 + 0.5),
                    T
                ) + T,
                T
            )
            c:drawImage(
                F32.m.rv,
                __TS__Number(-o),
                top
            )
            if T - o < LW then
                c:drawImage(F32.m.rv, T - o, top)
            end
            c:restore()
        end
        do
            local y = top + 2
            while y < bot do
                local sp = (y - top) / (bot - top)
                local off = __mod(t * (8 + sp * 14) + y * 13, 40)
                do
                    local x = -40 + off - __mod(camL * (0.2 + sp * 0.6), 40)
                    while x < LW do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            6 + sp * 10,
                            1,
                            ("rgba(255,255,255," .. tostring(0.08 + sp * 0.1)) .. ")"
                        )
                        x = x + 40
                    end
                end
                y = y + 3
            end
        end
        if __t(__gt(sun.str, 0.1) and __lt(nt, 0.3)) then
            local ____s_sunT_4 = s.sunT
            if ____s_sunT_4 == nil then
                ____s_sunT_4 = 0.5
            end
            local sx = 40 + (1 - ____s_sunT_4) * 400
            do
                local k = 0
                while k < 12 do
                    local y = top + 2 + k * 3.2
                    local w = 4 + math.abs(math.sin(t * 3 + k)) * 10
                    R(
                        nil,
                        c,
                        sx - w / 2 + math.sin(t * 2 + k) * 3,
                        y,
                        w,
                        1,
                        ("rgba(255,248,210," .. tostring(0.5 * sun.str)) .. ")"
                    )
                    k = k + 1
                end
            end
        end
        if __gt(nt, 0.2) then
            do
                local lx = 60
                while lx < LAG.W do
                    do
                        local x = lx + 1 - camL
                        if not __t(vis(nil, x, 10)) then
                            do lx = lx + 220 continue end
                        end
                        do
                            local y = top + 2
                            while y < bot do
                                R(
                                    nil,
                                    c,
                                    x - 1 + math.sin(t * 3 + y * 0.7) * 2,
                                    y,
                                    3,
                                    1,
                                    ("rgba(255,226,150," .. tostring(nt * 0.55 * (1 - (y - top) / 50))) .. ")"
                                )
                                y = y + 2
                            end
                        end
                    end
                    lx = lx + 220
                end
            end
            local mx = 360
            do
                local y = top + 2
                while y < bot - 10 do
                    R(
                        nil,
                        c,
                        mx - 3 + math.sin(t * 2 + y) * 2,
                        y,
                        6,
                        1,
                        ("rgba(240,240,220," .. tostring(nt * 0.4)) .. ")"
                    )
                    y = y + 2
                end
            end
        end
        R(
            nil,
            c,
            0,
            top,
            LW,
            1,
            "rgba(255,255,255,.35)"
        )
        do
            local x = scr(nil, {f = 0.45}, LAG.ILHA, camL)
            if __t(vis(nil, x, 60)) then
                ell(
                    nil,
                    c,
                    x,
                    178,
                    34,
                    6,
                    "#4f7a3a"
                )
                ell(
                    nil,
                    c,
                    x - 6,
                    172,
                    12,
                    10,
                    "#3f6a32"
                )
                ell(
                    nil,
                    c,
                    x + 10,
                    170,
                    10,
                    12,
                    "#4f7a3a"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    170,
                    2,
                    8,
                    "#5a4a32"
                )
                ell(
                    nil,
                    c,
                    x,
                    183,
                    36,
                    3,
                    "rgba(20,40,40,.4)"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({-14, 166}, 2),
                        __arrL({4, 162}, 2),
                        __arrL({16, 166}, 2)
                    },
                    3
                ))) do
                    local gx = ____value[1]
                    local gy = ____value[2]
                    R(
                        nil,
                        c,
                        x + gx,
                        gy,
                        4,
                        4,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        x + gx + 3,
                        gy - 4,
                        1,
                        4,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        x + gx + 3,
                        gy - 5,
                        3,
                        1,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        x + gx + 6,
                        gy - 5,
                        2,
                        1,
                        "#e8c24c"
                    )
                    R(
                        nil,
                        c,
                        x + gx + 1,
                        gy + 4,
                        1,
                        3,
                        "#2a2a2a"
                    )
                end
            end
        end
        do
            local ph = __mod(t, 26) / 26
            if __t(ph < 0.5 and __lt(nt, 0.6)) then
                local k = ph / 0.5
                local x = 500 - k * 600
                local y = 120 + math.sin(k * 6) * 6
                local f = math.sin(t * 7) > 0
                R(
                    nil,
                    c,
                    x,
                    y,
                    6,
                    3,
                    "#f6f6f0"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y + 1,
                    3,
                    1,
                    "#f6f6f0"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    y + 1,
                    1,
                    1,
                    "#e8c24c"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    y + 1,
                    4,
                    1,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y - (__t(f) and 4 or -2),
                    5,
                    2,
                    "#e8e8e2"
                )
            end
        end
        do
            local i = 0
            while i < 3 do
                do
                    local dir = __t(__mod(i, 2)) and 1 or -1
                    local wx = wrap(nil, i * 420 + t * 6 * dir, 1400)
                    local x = scr(nil, {f = 0.62}, wx, camL)
                    local y = 172 + i * 9
                    if not __t(vis(nil, x, 30)) then
                        do i = i + 1 continue end
                    end
                    R(
                        nil,
                        c,
                        x,
                        y - 6,
                        18,
                        6,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        x,
                        y,
                        18,
                        2,
                        "rgba(20,40,60,.35)"
                    )
                    local ____temp_5
                    if dir > 0 then
                        ____temp_5 = x + 16
                    else
                        ____temp_5 = x - 2
                    end
                    local hx = ____temp_5
                    R(
                        nil,
                        c,
                        hx,
                        y - 14,
                        3,
                        9,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        hx + (dir > 0 and 2 or -2),
                        y - 15,
                        3,
                        2,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        c,
                        hx + (dir > 0 and 4 or -3),
                        y - 14,
                        2,
                        1,
                        "#f08a24"
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        y - 11,
                        4,
                        5,
                        pick(nil, ROUPA, i)
                    )
                    R(
                        nil,
                        c,
                        x + 4,
                        y - 14,
                        4,
                        3,
                        pick(nil, SKIN, i)
                    )
                    R(
                        nil,
                        c,
                        x + 10,
                        y - 11,
                        4,
                        5,
                        pick(nil, ROUPA, i + 3)
                    )
                    R(
                        nil,
                        c,
                        x + 10,
                        y - 14,
                        4,
                        3,
                        pick(nil, SKIN, i + 2)
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        y - 9,
                        6,
                        3,
                        "#e8433a"
                    )
                    do
                        local k = 1
                        while k < 4 do
                            local ____R_8 = R
                            local ____c_7 = c
                            local ____temp_6
                            if dir > 0 then
                                ____temp_6 = x - k * 5
                            else
                                ____temp_6 = x + 18 + k * 5
                            end
                            ____R_8(
                                nil,
                                ____c_7,
                                ____temp_6,
                                y + __mod(k, 2),
                                3,
                                1,
                                "rgba(255,255,255,.4)"
                            )
                            k = k + 1
                        end
                    end
                end
                i = i + 1
            end
        end
        do
            local wx = wrap(nil, t * 5, 1400)
            local x = scr(nil, {f = 0.75}, wx, camL)
            if __t(vis(nil, x, 40)) then
                do
                    local k = 0
                    while k < 5 do
                        local px = x - k * 8
                        local py = 198 + math.floor(math.sin(t * 3 + k) + 0.5)
                        local big = k == 0
                        R(
                            nil,
                            c,
                            px,
                            py - (__t(big) and 4 or 3),
                            __t(big) and 7 or 4,
                            __t(big) and 4 or 3,
                            __t(big) and "#8a6a3a" or "#e8c24c"
                        )
                        R(
                            nil,
                            c,
                            px + (__t(big) and 5 or 3),
                            py - (__t(big) and 7 or 5),
                            __t(big) and 3 or 2,
                            __t(big) and 3 or 2,
                            __t(big) and "#2c6a3a" or "#e8c24c"
                        )
                        R(
                            nil,
                            c,
                            px + (__t(big) and 8 or 5),
                            py - (__t(big) and 6 or 4),
                            2,
                            1,
                            "#f08a24"
                        )
                        R(
                            nil,
                            c,
                            px - 3,
                            py,
                            3,
                            1,
                            "rgba(255,255,255,.4)"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local ph = __mod(t, 9) / 9
            if ph < 0.12 then
                local x = scr(
                    nil,
                    {f = 0.55},
                    600 + __mod(
                        math.floor(t / 9) * 173,
                        900
                    ),
                    camL
                )
                local k = ph / 0.12
                local y = 190 - math.sin(k * math.pi) * 10
                R(
                    nil,
                    c,
                    x + k * 12,
                    y,
                    4,
                    2,
                    "#c8ccd0"
                )
                ell(
                    nil,
                    c,
                    x,
                    192,
                    4 + k * 8,
                    1 + k,
                    ("rgba(255,255,255," .. tostring(0.5 * (1 - k))) .. ")"
                )
            end
        end
        drawMid(nil, c, F32.mid, camL)
        do
            local x = LAG.PIER + 30 - camL
            if __t(vis(nil, x, 40)) then
                gente(
                    nil,
                    c,
                    x - 4,
                    186,
                    8,
                    false
                )
                R(
                    nil,
                    c,
                    x - 6,
                    168,
                    10,
                    3,
                    "#d8b878"
                )
                local bob = math.sin(t * 2) * 1.5
                local pull = __mod(t, 30) < 2
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 4, 176}, 2),
                            __arrL(
                                {
                                    x + 26,
                                    __t(pull) and 150 or 156
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    "#5a4a32"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    x + 26,
                                    __t(pull) and 150 or 156
                                },
                                2
                            ),
                            __arrL({x + 30, 182 + bob}, 2)
                        },
                        2
                    ),
                    1,
                    "rgba(240,240,240,.6)"
                )
                R(
                    nil,
                    c,
                    x + 29,
                    181 + bob,
                    2,
                    2,
                    "#e8433a"
                )
                if __t(pull) then
                    R(
                        nil,
                        c,
                        x + 28,
                        160,
                        6,
                        3,
                        "#c8ccd0"
                    )
                    balao(
                        nil,
                        c,
                        x,
                        160,
                        "PEGUEI UM!"
                    )
                end
            end
        end
        do
            local x = LAG.QUIOSQUE + 48 - camL
            if __t(vis(nil, x, 40)) then
                ell(
                    nil,
                    c,
                    x,
                    172,
                    4,
                    4,
                    "#9a6440"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    176,
                    8,
                    8,
                    "#e8e2d0"
                )
                if math.sin(t * 1.3) > 0.7 then
                    R(
                        nil,
                        c,
                        x + 6,
                        178,
                        6,
                        2,
                        "#9a6440"
                    )
                    ell(
                        nil,
                        c,
                        x + 14,
                        178,
                        3,
                        3,
                        "#5a9a3a"
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
            0.28
        )
    end
    local function lagoaLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.05) then
            return
        end
        do
            local lx = 60
            while lx < LAG.W do
                lampGlow(
                    nil,
                    g,
                    lx - camL + 1,
                    130,
                    a
                )
                lx = lx + 220
            end
        end
        local q = LAG.QUIOSQUE + 48 - camL
        if __t(vis(nil, q, 60)) then
            lightAdd(
                nil,
                q,
                170,
                0.6 * a,
                50
            )
        end
    end
    local PQ = __ord({
        W = 2400,
        PLAY = 80,
        SKATE = 560,
        IDOSOS = 960,
        PIC = 1300,
        CARR = 1660,
        PARCAO = 1960
    }, "W,PLAY,SKATE,IDOSOS,PIC,CARR,PARCAO")
    local F33 = {}
    local function buildArvoredo(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local b = 192
        do
            local i = 0
            while i < 70 do
                local x = hash(nil, i + 330) * T
                local s = 0.9 + hash(nil, i + 331) * 0.7
                R(
                    nil,
                    c,
                    x,
                    b - 26 * s,
                    3,
                    26 * s,
                    "#5a4a36"
                )
                do
                    local k = 0
                    while k < 9 do
                        ell(
                            nil,
                            c,
                            x + 1 + (hash(nil, i * 9 + k) - 0.5) * 26 * s,
                            b - 30 * s - hash(nil, i * 3 + k) * 20 * s,
                            8 * s,
                            7 * s,
                            pick(
                                nil,
                                __arrL({"#4f7a46", "#5f8a52", "#6a9a5a", "#457040"}, 4),
                                i + k
                            )
                        )
                        k = k + 1
                    end
                end
                if __gt(
                    hash(nil, i + 332),
                    0.8
                ) then
                    do
                        local k = 0
                        while k < 6 do
                            R(
                                nil,
                                c,
                                x - 8 + hash(nil, i + k) * 18,
                                b - 40 * s + hash(nil, i * 2 + k) * 16,
                                2,
                                2,
                                pick(
                                    nil,
                                    __arrL({"#e86a8a", "#f2c94c"}, 2),
                                    i
                                )
                            )
                            k = k + 1
                        end
                    end
                end
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            b,
            T,
            3,
            "#8a7a5a"
        )
        do
            local x = 0
            while __lt(x, T) do
                R(
                    nil,
                    c,
                    x,
                    b + 1,
                    3,
                    1,
                    "#5a4a32"
                )
                x = x + 5
            end
        end
        nevoa(nil, c, T, "rgba(204,218,228,.2)")
        return {cv = cv, f = 0.42, base = b}
    end
    local function buildParque(self)
        local W = PQ.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            196,
            W,
            16,
            "#5f8a46"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    195 - math.floor(hash(nil, x) * 3 + 0.5),
                    2,
                    3,
                    "#7aa856"
                )
                x = x + 3
            end
        end
        local p = PQ.PLAY
        R(
            nil,
            c,
            p,
            200,
            380,
            12,
            "#c4583a"
        )
        do
            local x = p
            while x < p + 380 do
                R(
                    nil,
                    c,
                    x,
                    200,
                    10,
                    12,
                    "#3c8ad8"
                )
                x = x + 20
            end
        end
        R(
            nil,
            c,
            p + 10,
            128,
            4,
            72,
            "#e8433a"
        )
        R(
            nil,
            c,
            p + 120,
            128,
            4,
            72,
            "#e8433a"
        )
        R(
            nil,
            c,
            p + 8,
            126,
            118,
            5,
            "#f2c94c"
        )
        R(
            nil,
            c,
            p + 160,
            150,
            4,
            50,
            "#3c8ad8"
        )
        R(
            nil,
            c,
            p + 186,
            150,
            4,
            50,
            "#3c8ad8"
        )
        R(
            nil,
            c,
            p + 156,
            146,
            38,
            6,
            "#e8c24c"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    p + 160,
                    158 + k * 8,
                    30,
                    2,
                    "#5aa0e8"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 40 do
                R(
                    nil,
                    c,
                    p + 194 + k * 1.6,
                    150 + k * 1.25,
                    8,
                    2,
                    __t(__mod(k, 2)) and "#e8833a" or "#f2a83a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            p + 156,
            140,
            38,
            6,
            "#e8433a"
        )
        do
            local k = 0
            while k < 38 do
                R(
                    nil,
                    c,
                    p + 156 + k,
                    134,
                    2,
                    6,
                    "#e8433a"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            p + 300,
            192,
            70,
            8,
            "#d8c49a"
        )
        R(
            nil,
            c,
            p + 298,
            190,
            74,
            2,
            "#8a6a45"
        )
        R(
            nil,
            c,
            p + 316,
            188,
            6,
            4,
            "#e8433a"
        )
        R(
            nil,
            c,
            p + 340,
            189,
            10,
            3,
            "#3c8ad8"
        )
        local sk = PQ.SKATE
        R(
            nil,
            c,
            sk,
            150,
            360,
            50,
            "#a8aca8"
        )
        do
            local k = 0
            while k <= 60 do
                local u = k / 60
                local y = 150 + math.floor((1 - math.cos(u * math.pi / 2)) * 0 + math.sin(u * math.pi / 2) * 0 + 0.5)
                local ____ = y
                k = k + 1
            end
        end
        do
            local x = 0
            while x < 360 do
                local u = x / 360
                local depth = math.floor(math.sin(u * math.pi) * 30 + 0.5)
                R(
                    nil,
                    c,
                    sk + x,
                    150,
                    1,
                    depth + 10,
                    "#bcc0bc"
                )
                R(
                    nil,
                    c,
                    sk + x,
                    160 + depth,
                    1,
                    2,
                    "#e8ece8"
                )
                x = x + 1
            end
        end
        R(
            nil,
            c,
            sk,
            148,
            360,
            3,
            "#8a8e8a"
        )
        grafite(
            nil,
            c,
            sk + 30,
            162,
            300,
            26,
            3301
        )
        R(
            nil,
            c,
            sk + 140,
            186,
            80,
            2,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            sk + 150,
            188,
            2,
            12,
            "#8a8e92"
        )
        R(
            nil,
            c,
            sk + 208,
            188,
            2,
            12,
            "#8a8e92"
        )
        local id = PQ.IDOSOS
        do
            local k = 0
            while k < 4 do
                local ax = id + k * 40
                local col = pick(
                    nil,
                    __arrL({"#e8c24c", "#3c8ad8", "#e8433a", "#3c8a5a"}, 4),
                    k
                )
                R(
                    nil,
                    c,
                    ax,
                    170,
                    4,
                    30,
                    col
                )
                R(
                    nil,
                    c,
                    ax - 6,
                    168,
                    16,
                    3,
                    col
                )
                ell(
                    nil,
                    c,
                    ax + 2,
                    185,
                    8,
                    2,
                    shadeHex(nil, col, 0.8)
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            id + 180,
            186,
            40,
            4,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            id + 198,
            190,
            4,
            10,
            "#8a8a86"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    id + 184 + k * 6,
                    184,
                    4,
                    2,
                    "#f6f6f0"
                )
                k = k + 1
            end
        end
        for ____, sx in __iterar((__arrL({id + 170, id + 224}, 2))) do
            R(
                nil,
                c,
                sx,
                194,
                8,
                2,
                "#8a8a86"
            )
            R(
                nil,
                c,
                sx + 3,
                196,
                2,
                6,
                "#8a8a86"
            )
        end
        do
            local k = 0
            while k < 3 do
                local tx = PQ.PIC + k * 110
                do
                    local x = 0
                    while x < 40 do
                        do
                            local y = 0
                            while y < 6 do
                                R(
                                    nil,
                                    c,
                                    tx + x + (__t(y) and 2 or 0),
                                    202 + y,
                                    3,
                                    3,
                                    __t(__mod(x / 4 + y / 3, 2)) and "#e8433a" or "#f6f2ea"
                                )
                                y = y + 3
                            end
                        end
                        x = x + 4
                    end
                end
                R(
                    nil,
                    c,
                    tx + 30,
                    196,
                    10,
                    7,
                    "#a8742a"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({tx + 30, 196}, 2),
                            __arrL({tx + 35, 192}, 2),
                            __arrL({tx + 40, 196}, 2)
                        },
                        3
                    ),
                    1,
                    "#8a5a2a"
                )
                k = k + 1
            end
        end
        local cr = PQ.CARR
        R(
            nil,
            c,
            cr,
            176,
            34,
            22,
            "#eef4f6"
        )
        R(
            nil,
            c,
            cr,
            176,
            34,
            6,
            "#3e7cc0"
        )
        pxText(
            nil,
            c,
            "PICOLE",
            cr + 17,
            186,
            "#3e7cc0"
        )
        ell(
            nil,
            c,
            cr + 6,
            200,
            4,
            4,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            cr + 28,
            200,
            4,
            4,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            cr + 17,
            160,
            16,
            5,
            "#f2c94c"
        )
        R(
            nil,
            c,
            cr + 16,
            160,
            2,
            16,
            "#8a8a86"
        )
        R(
            nil,
            c,
            cr + 80,
            172,
            30,
            26,
            "#f6a8c8"
        )
        do
            local k = 0
            while k < 4 do
                ell(
                    nil,
                    c,
                    cr + 86 + k * 6,
                    164,
                    5,
                    5,
                    "#ffd0e8"
                )
                R(
                    nil,
                    c,
                    cr + 86 + k * 6,
                    168,
                    1,
                    6,
                    "#f6f2ea"
                )
                k = k + 1
            end
        end
        ell(
            nil,
            c,
            cr + 84,
            200,
            4,
            4,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            cr + 106,
            200,
            4,
            4,
            "#2a2a2a"
        )
        pxText(
            nil,
            c,
            "ALGODAO",
            cr + 95,
            184,
            "#c43c6a"
        )
        A.OBJ:pipoca(c, cr + 170, 0)
        R(
            nil,
            c,
            cr + 172,
            GY - 24,
            18,
            3,
            "#c43c3a"
        )
        local pc = PQ.PARCAO
        do
            local x = pc
            while x < pc + 400 do
                R(
                    nil,
                    c,
                    x,
                    184,
                    1,
                    16,
                    "#5a5e62"
                )
                x = x + 6
            end
        end
        R(
            nil,
            c,
            pc,
            184,
            400,
            1,
            "#5a5e62"
        )
        R(
            nil,
            c,
            pc,
            192,
            400,
            1,
            "#5a5e62"
        )
        R(
            nil,
            c,
            pc + 160,
            172,
            80,
            12,
            "#3c8a5a"
        )
        pxText(
            nil,
            c,
            "PARCAO",
            pc + 200,
            175,
            "#ffffff"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    pc + 60 + k * 90,
                    196,
                    20,
                    3,
                    "#e8833a"
                )
                R(
                    nil,
                    c,
                    pc + 62 + k * 90,
                    199,
                    2,
                    8,
                    "#8a8a86"
                )
                R(
                    nil,
                    c,
                    pc + 76 + k * 90,
                    199,
                    2,
                    8,
                    "#8a8a86"
                )
                k = k + 1
            end
        end
        A:hidrante(c, pc + 360)
        do
            local lx = 40
            while lx < W do
                lampPost(nil, c, lx, 124)
                lx = lx + 260
            end
        end
        bandeirinhas(
            nil,
            c,
            PQ.PIC - 20,
            PQ.PIC + 320,
            120,
            33
        )
        objetos(
            nil,
            c,
            33,
            W,
            "cidade",
            40,
            W - 40,
            __arrL({180, 280}, 2)
        )
        pedraPortuguesa(nil, c, W, 212)
        R(
            nil,
            c,
            0,
            212,
            W,
            2,
            "#c8c2b0"
        )
        chaoDetalhe(nil, c, W, "cidade")
        return cv
    end
    local function parque(self, c, s, t, camL)
        if not __t(F33.mid) then
            F33.arv = buildArvoredo(nil)
            F33.mid = buildParque(nil)
        end
        local nt = night(nil, s)
        conquistaBack(
            nil,
            c,
            s,
            t,
            camL,
            {seed = 33, kites = true, trees = false}
        )
        tile(nil, c, F33.arv.cv, camL * F33.arv.f)
        do
            local wx = wrap(nil, t * 16)
            local sx = scr(nil, F33.arv, wx, camL)
            local y = F33.arv.base
            if __t(vis(nil, sx, 80)) then
                R(
                    nil,
                    c,
                    sx,
                    y - 10,
                    12,
                    9,
                    "#e8433a"
                )
                R(
                    nil,
                    c,
                    sx + 2,
                    y - 14,
                    6,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    sx + 9,
                    y - 16,
                    2,
                    6,
                    "#5a5a56"
                )
                do
                    local k = 1
                    while k < 5 do
                        local vx = sx - k * 15
                        R(
                            nil,
                            c,
                            vx,
                            y - 8,
                            13,
                            7,
                            pick(
                                nil,
                                __arrL({"#3c8ad8", "#e8c24c", "#3c8a5a", "#c86ab8"}, 4),
                                k
                            )
                        )
                        R(
                            nil,
                            c,
                            vx + 1,
                            y - 11,
                            11,
                            2,
                            "#f2efe6"
                        )
                        R(
                            nil,
                            c,
                            vx + 3,
                            y - 10,
                            3,
                            2,
                            pick(nil, SKIN, k)
                        )
                        R(
                            nil,
                            c,
                            vx + 7,
                            y - 10,
                            3,
                            2,
                            pick(nil, SKIN, k + 1)
                        )
                        k = k + 1
                    end
                end
            end
        end
        drawMid(nil, c, F33.mid, camL)
        do
            local p = PQ.PLAY - camL
            if __t(vis(nil, p, 220)) then
                do
                    local k = 0
                    while k < 3 do
                        local a = math.sin(t * 2.2 + k * 1.3) * (k == 1 and 0.2 or 0.55)
                        local px = p + 30 + k * 34
                        local len = 40
                        local ex = px + math.sin(a) * len
                        local ey = 131 + math.cos(a) * len
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({px, 131}, 2),
                                    __arrL({ex, ey}, 2)
                                },
                                2
                            ),
                            1,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            c,
                            ex - 4,
                            ey,
                            10,
                            2,
                            "#3a3a36"
                        )
                        if k ~= 1 then
                            R(
                                nil,
                                c,
                                ex - 2,
                                ey - 9,
                                6,
                                9,
                                pick(nil, ROUPA, k + 4)
                            )
                            R(
                                nil,
                                c,
                                ex - 1,
                                ey - 13,
                                4,
                                4,
                                pick(nil, SKIN, k)
                            )
                            R(
                                nil,
                                c,
                                ex + (a > 0 and 3 or -2),
                                ey + 2,
                                2,
                                4,
                                "#2a2f3a"
                            )
                        end
                        k = k + 1
                    end
                end
                local sl = __mod(t * 0.35, 1)
                if sl < 0.5 then
                    local u = sl / 0.5
                    local x = p + 196 + u * 62
                    local y = 144 + u * 48
                    R(
                        nil,
                        c,
                        x,
                        y - 8,
                        5,
                        7,
                        "#e8c24c"
                    )
                    R(
                        nil,
                        c,
                        x,
                        y - 11,
                        5,
                        3,
                        pick(nil, SKIN, 2)
                    )
                else
                    local u = (sl - 0.5) / 0.5
                    local y = 196 - u * 50
                    R(
                        nil,
                        c,
                        p + 168,
                        y - 8,
                        5,
                        7,
                        "#e8c24c"
                    )
                    R(
                        nil,
                        c,
                        p + 168,
                        y - 11,
                        5,
                        3,
                        pick(nil, SKIN, 2)
                    )
                end
                local a = math.sin(t * 1.6) * 6
                local gx = p + 240
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({gx, 196 - a}, 2),
                            __arrL({gx + 50, 196 + a}, 2)
                        },
                        2
                    ),
                    2,
                    "#3c8a5a"
                )
                R(
                    nil,
                    c,
                    gx + 23,
                    196,
                    4,
                    6,
                    "#3c8a5a"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({2, -1}, 2),
                        __arrL({44, 1}, 2)
                    },
                    2
                ))) do
                    local dx = ____value[1]
                    local sg = ____value[2]
                    local y = 196 + sg * a
                    R(
                        nil,
                        c,
                        gx + dx,
                        y - 8,
                        5,
                        7,
                        pick(nil, ROUPA, dx)
                    )
                    R(
                        nil,
                        c,
                        gx + dx,
                        y - 11,
                        5,
                        3,
                        pick(nil, SKIN, dx)
                    )
                end
            end
        end
        do
            local sk = PQ.SKATE
            local u = (math.sin(t * 1.3) + 1) / 2
            local x = sk + 20 + u * 320
            local depth = math.sin(u * math.pi) * 30
            local ____temp_9
            if math.abs(math.cos(u * math.pi)) > 0.9 then
                ____temp_9 = math.abs(math.sin(t * 2.6)) * 10
            else
                ____temp_9 = 0
            end
            local up = ____temp_9
            local y = 158 + depth - up
            local sx = x - camL
            if __t(vis(nil, sx, 20)) then
                R(
                    nil,
                    c,
                    sx - 4,
                    y,
                    12,
                    2,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    sx - 3,
                    y + 2,
                    2,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    sx + 5,
                    y + 2,
                    2,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    sx,
                    y - 10,
                    5,
                    8,
                    "#4f8a52"
                )
                R(
                    nil,
                    c,
                    sx,
                    y - 14,
                    5,
                    4,
                    pick(nil, SKIN, 4)
                )
                R(
                    nil,
                    c,
                    sx - 1,
                    y - 15,
                    7,
                    2,
                    "#d9b347"
                )
                R(
                    nil,
                    c,
                    sx + 1,
                    y - 2,
                    1,
                    2,
                    "#22262c"
                )
                R(
                    nil,
                    c,
                    sx + 3,
                    y - 2,
                    1,
                    2,
                    "#22262c"
                )
            end
        end
        do
            local id = PQ.IDOSOS - camL
            if __t(vis(nil, id, 260)) then
                do
                    local k = 0
                    while k < 3 do
                        local ax = id + k * 40
                        local sw = math.sin(t * 2 + k) * 4
                        gente(
                            nil,
                            c,
                            ax - 1,
                            200,
                            k + 10,
                            false
                        )
                        R(
                            nil,
                            c,
                            ax - 1 + sw,
                            192,
                            2,
                            8,
                            "#2a2f3a"
                        )
                        R(
                            nil,
                            c,
                            ax + 4 - sw,
                            192,
                            2,
                            8,
                            "#2a2f3a"
                        )
                        R(
                            nil,
                            c,
                            ax,
                            180,
                            6,
                            2,
                            "#e8e2d0"
                        )
                        k = k + 1
                    end
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({160, 2}, 2),
                        __arrL({222, 4}, 2)
                    },
                    2
                ))) do
                    local dx = ____value[1]
                    local i = ____value[2]
                    gente(
                        nil,
                        c,
                        id + dx,
                        202,
                        i + 10,
                        false
                    )
                    R(
                        nil,
                        c,
                        id + dx + 1,
                        182,
                        5,
                        2,
                        "#e8e2d0"
                    )
                end
                local bate = __mod(t, 5) < 0.3
                R(
                    nil,
                    c,
                    id + 196,
                    184 - (__t(bate) and 4 or 0),
                    4,
                    2,
                    "#f6f6f0"
                )
                if __mod(t, 5) < 1.4 then
                    balao(
                        nil,
                        c,
                        id + 200,
                        178,
                        __t(bate) and "BATI!" or "É CARROÇA!"
                    )
                end
            end
        end
        do
            local b = PQ.PIC + 230 - camL
            if __t(vis(nil, b, 120)) then
                gente(
                    nil,
                    c,
                    b,
                    212,
                    3,
                    false
                )
                do
                    local i = 0
                    while i < 7 do
                        local q = __mod(t * 0.18 + i / 7, 1)
                        local x = b + 10 + q * 90 + math.sin(t + i) * 8
                        local y = 196 - q * 80 + math.sin(t * 2 + i) * 4
                        local r = 3 + __mod(i, 3)
                        if q < 0.9 then
                            c.strokeStyle = ("rgba(220,240,255," .. tostring((1 - q) * 0.8)) .. ")"
                            c:beginPath()
                            c:arc(
                                x,
                                y,
                                r,
                                0,
                                TAU
                            )
                            c:stroke()
                            R(
                                nil,
                                c,
                                x - r * 0.5,
                                y - r * 0.5,
                                1,
                                1,
                                "rgba(255,255,255,.9)"
                            )
                        end
                        i = i + 1
                    end
                end
            end
        end
        do
            local pc = PQ.PARCAO - camL
            if __t(vis(nil, pc, 420)) then
                local u = __mod(t * 0.3, 1)
                local ____temp_11 = pc + 40
                local ____temp_10
                if u < 0.5 then
                    ____temp_10 = u * 2
                else
                    ____temp_10 = 2 - u * 2
                end
                local bx = ____temp_11 + ____temp_10 * 320
                R(
                    nil,
                    c,
                    bx,
                    200 - math.abs(math.sin(t * 4)) * 8,
                    3,
                    3,
                    "#e8f24c"
                )
                do
                    local k = 0
                    while k < 3 do
                        local dx = bx - 16 - k * 22 + math.sin(t * 3 + k) * 6
                        cachorro(
                            nil,
                            c,
                            dx,
                            210,
                            pick(
                                nil,
                                __arrL({"#c98a43", "#2a2a2a", "#f2efe6"}, 3),
                                k
                            )
                        )
                        R(
                            nil,
                            c,
                            dx - 3,
                            210 - 9 + math.floor(math.sin(t * 14 + k) + 0.5),
                            4,
                            2,
                            pick(
                                nil,
                                __arrL({"#c98a43", "#2a2a2a", "#f2efe6"}, 3),
                                k
                            )
                        )
                        k = k + 1
                    end
                end
                gente(
                    nil,
                    c,
                    pc + 10,
                    214,
                    6,
                    false
                )
            end
        end
        do
            local k = 0
            while k < 2 do
                local x = PQ.PIC + 40 + k * 110 - camL
                if __t(vis(nil, x, 30)) then
                    gente(
                        nil,
                        c,
                        x,
                        208,
                        k + 5,
                        false
                    )
                    gente(
                        nil,
                        c,
                        x + 14,
                        208,
                        k + 8,
                        false
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        200,
                        6,
                        6,
                        pick(nil, SKIN, k + 3)
                    )
                end
                k = k + 1
            end
        end
        local ____ = nt
        fog(
            nil,
            c,
            s,
            t,
            camL,
            0.16
        )
    end
    local function parqueLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.05) then
            return
        end
        do
            local lx = 40
            while lx < PQ.W do
                lampGlow(
                    nil,
                    g,
                    lx - camL,
                    124,
                    a
                )
                lx = lx + 260
            end
        end
    end
    local MAR = __ord({
        W = 2600,
        BARRACA = 700,
        CAMINHAO = 1080,
        RAMPA = 1600,
        CRUZ = 2020,
        TORRE = 2320
    }, "W,BARRACA,CAMINHAO,RAMPA,CRUZ,TORRE")
    local F34 = {}
    local function buildVale(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local hz = 104
        do
            local y = hz
            while y < LH do
                local u = (y - hz) / (LH - hz)
                R(
                    nil,
                    c,
                    0,
                    y,
                    T,
                    1,
                    lerpC(nil, "#a8b8b4", "#7a9a6a", u)
                )
                y = y + 1
            end
        end
        do
            local r = 0
            while r < 18 do
                local y = hz + 2 + r * r * 0.45
                local h = 1 + r * 0.6
                do
                    local x = __mod(r * 37, 40)
                    local i = 0
                    while __lt(x, T) do
                        local w = 12 + r * 4 + hash(nil, i + r * 50) * 30
                        R(
                            nil,
                            c,
                            x,
                            y,
                            w,
                            h,
                            pick(
                                nil,
                                __arrL({
                                    "#8aa070",
                                    "#9aae78",
                                    "#7a9460",
                                    "#b0a878",
                                    "#a49868",
                                    "#88a87a"
                                }, 6),
                                i + r
                            )
                        )
                        x = x + (w + 1)
                        i = i + 1
                    end
                end
                r = r + 1
            end
        end
        do
            local x = 0
            while __lt(x, T) do
                local y = hz + 20 + math.sin(x / T * TAU * 4) * 8 + math.sin(x / T * TAU * 9) * 3
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    "#c8e0e8"
                )
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 9 do
                local x = hash(nil, i + 340) * T
                local y = hz + 8 + hash(nil, i + 341) * 40
                do
                    local k = 0
                    while k < 10 do
                        R(
                            nil,
                            c,
                            x + hash(nil, i * 9 + k) * 18,
                            y + hash(nil, i * 3 + k) * 5,
                            2,
                            1,
                            "#f2efe6"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        nevoa(nil, c, T, "rgba(200,214,226,.35)")
        return cv
    end
    local function buildEncostaSerra(self)
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local function ry(____, x)
            return 166 + math.sin(x / T * TAU * 2) * 10 + math.sin(x / T * TAU * 6 + 1) * 4
        end
        do
            local x = 0
            while __lt(x, T) do
                local y = math.floor(ry(nil, x) + 0.5)
                do
                    local yy = y
                    while yy < LH do
                        R(
                            nil,
                            c,
                            x,
                            yy,
                            1,
                            2,
                            lerpC(nil, "#6a8a58", "#4a6a40", (yy - y) / 80)
                        )
                        yy = yy + 2
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#8aa870"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 300 do
                local x = hash(nil, i + 350) * T
                ell(
                    nil,
                    c,
                    x,
                    ry(nil, x) + 6 + hash(nil, i + 351) * 70,
                    2 + hash(nil, i) * 4,
                    1.5 + hash(nil, i * 3),
                    pick(
                        nil,
                        __arrL({"#4f7a46", "#5a8a4e", "#3f6a3a"}, 3),
                        i
                    )
                )
                i = i + 1
            end
        end
        local road = __arrL({}, 0)
        for ____, x0 in __iterar((__arrL({200, 860}, 2))) do
            local x = x0
            local y = ry(nil, x0) + 3
            local pts = __arrL(
                {__arrL({x, y}, 2)},
                1
            )
            do
                local k = 0
                while k < 5 do
                    x = x + (__t(__mod(k, 2)) and -90 or 90)
                    y = y + 7
                    __call(
                        pts,
                        "push",
                        __arrL({x, y}, 2)
                    )
                    k = k + 1
                end
            end
            __call(road, "push", pts)
            do
                local k = 1
                while k < __len(pts) do
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __get(pts, k - 1),
                                __get(pts, k)
                            },
                            2
                        ),
                        3,
                        "#5a5e62"
                    )
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __get(pts, k - 1),
                                __get(pts, k)
                            },
                            2
                        ),
                        1,
                        "#8a8e90"
                    )
                    k = k + 1
                end
            end
        end
        local TUR = __arrL({}, 0)
        for ____, tx in __iterar((__arrL({
            100,
            380,
            620,
            1040,
            1300
        }, 5))) do
            local ty = math.floor(ry(nil, tx) + 0.5) - 30
            R(
                nil,
                c,
                tx,
                ty - 46,
                2,
                46,
                "#e8ecef"
            )
            R(
                nil,
                c,
                tx - 1,
                ty - 48,
                4,
                3,
                "#d8dce0"
            )
            __call(
                TUR,
                "push",
                __arrL({tx, ty - 47}, 2)
            )
        end
        nevoa(nil, c, T, "rgba(204,218,228,.2)")
        return {cv = cv, road = road, TUR = TUR, f = 0.24}
    end
    local function buildMirante(self)
        local W = MAR.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        do
            local x = 0
            while x < W do
                local h = 14 + math.sin(x * 0.02) * 4 + math.sin(x * 0.07) * 2
                R(
                    nil,
                    c,
                    x,
                    210 - h,
                    1,
                    h,
                    "#7a7058"
                )
                R(
                    nil,
                    c,
                    x,
                    210 - h,
                    1,
                    2,
                    "#a89a78"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < W / 18 do
                A:rocha(
                    c,
                    hash(nil, i + 3400) * W,
                    200 + hash(nil, i + 3401) * 8,
                    8 + hash(nil, i) * 14,
                    4 + hash(nil, i * 3) * 4,
                    i
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                if __gt(
                    hash(nil, x * 0.9),
                    0.35
                ) then
                    local h = 5 + hash(nil, x) * 10
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, 202}, 2),
                                __arrL({x + 2, 202 - h}, 2)
                            },
                            2
                        ),
                        1,
                        __t(__mod(x, 3)) and "#c8a858" or "#a88a40"
                    )
                end
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 14 do
                A:cactus(
                    c,
                    40 + hash(nil, i + 3410) * (W - 80),
                    204
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    196,
                    3,
                    3,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x,
                    196,
                    3,
                    1,
                    "#eef0f2"
                )
                R(
                    nil,
                    c,
                    x,
                    199,
                    3,
                    2,
                    "#9aa0a6"
                )
                x = x + 3
            end
        end
        do
            local x = 6
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    196,
                    3,
                    14,
                    "#7a8086"
                )
                x = x + 30
            end
        end
        local b = MAR.BARRACA
        R(
            nil,
            c,
            b,
            150,
            2,
            60,
            "#6a4a32"
        )
        R(
            nil,
            c,
            b + 98,
            150,
            2,
            60,
            "#6a4a32"
        )
        do
            local k = 0
            while k < 100 do
                R(
                    nil,
                    c,
                    b + k,
                    146 + math.floor(math.sin(k / 100 * math.pi) * -4 + 0.5),
                    1,
                    8,
                    __mod(k, 10) < 5 and "#e8833a" or "#f2e8d0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            b + 4,
            176,
            92,
            34,
            "#8a6a45"
        )
        R(
            nil,
            c,
            b + 4,
            176,
            92,
            3,
            "#c4955c"
        )
        do
            local k = 0
            while k < 8 do
                R(
                    nil,
                    c,
                    b + 8 + k * 11,
                    166,
                    8,
                    10,
                    __t(__mod(k, 2)) and "#e8a83a" or "#d89a2a"
                )
                R(
                    nil,
                    c,
                    b + 8 + k * 11,
                    164,
                    8,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    b + 9 + k * 11,
                    168,
                    2,
                    6,
                    "rgba(255,255,255,.4)"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 4 do
                ell(
                    nil,
                    c,
                    b + 20 + k * 18,
                    186,
                    6,
                    4,
                    "#f6ecd0"
                )
                R(
                    nil,
                    c,
                    b + 14 + k * 18,
                    186,
                    12,
                    1,
                    "#c8a46a"
                )
                k = k + 1
            end
        end
        local cm = MAR.CAMINHAO
        R(
            nil,
            c,
            cm,
            140,
            130,
            58,
            "#e8e8e2"
        )
        R(
            nil,
            c,
            cm,
            140,
            130,
            3,
            "#ffffff"
        )
        R(
            nil,
            c,
            cm + 6,
            150,
            118,
            22,
            "#2c5a9e"
        )
        pxText(
            nil,
            c,
            "TRANSPORTES PLANALTO",
            cm + 65,
            158,
            "#ffffff"
        )
        R(
            nil,
            c,
            cm + 130,
            160,
            40,
            38,
            "#c43c3a"
        )
        R(
            nil,
            c,
            cm + 140,
            164,
            22,
            14,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            cm + 166,
            186,
            6,
            6,
            "#fff2b0"
        )
        R(
            nil,
            c,
            cm,
            196,
            172,
            4,
            "#3a3a36"
        )
        for ____, wx in __iterar((__arrL({cm + 24, cm + 50, cm + 150}, 3))) do
            ell(
                nil,
                c,
                wx,
                203,
                8,
                8,
                "#1c1c1c"
            )
            ell(
                nil,
                c,
                wx,
                203,
                4,
                4,
                "#9aa0a6"
            )
        end
        local r = MAR.RAMPA
        do
            local k = 0
            while k < 120 do
                R(
                    nil,
                    c,
                    r + k,
                    186 - k * 0.12,
                    1,
                    4,
                    __t(__mod(k, 8)) and "#a87a4a" or "#8a5a32"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 120 do
                R(
                    nil,
                    c,
                    r + k,
                    190 - k * 0.12,
                    2,
                    20 + k * 0.12,
                    "#6a4a2a"
                )
                k = k + 20
            end
        end
        R(
            nil,
            c,
            r + 100,
            120,
            2,
            54,
            "#9aa0a6"
        )
        local cz = MAR.CRUZ
        R(
            nil,
            c,
            cz,
            120,
            6,
            84,
            "#6a4a32"
        )
        R(
            nil,
            c,
            cz - 18,
            138,
            42,
            6,
            "#6a4a32"
        )
        R(
            nil,
            c,
            cz - 10,
            200,
            26,
            6,
            "#8a8a80"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    cz - 8 + k * 6,
                    196,
                    2,
                    4,
                    "#f6f2e8"
                )
                k = k + 1
            end
        end
        local tw = MAR.TORRE
        for ____, dx in __iterar((__arrL({0, 70}, 2))) do
            R(
                nil,
                c,
                tw + dx,
                30,
                3,
                176,
                "#c43c3a"
            )
            do
                local y = 30
                while y < 206 do
                    R(
                        nil,
                        c,
                        tw + dx - 5,
                        y,
                        13,
                        1,
                        "#d8d8d0"
                    )
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({tw + dx - 5, y}, 2),
                                __arrL({tw + dx + 7, y + 10}, 2)
                            },
                            2
                        ),
                        1,
                        "#d8d8d0"
                    )
                    y = y + 10
                end
            end
        end
        terra(
            nil,
            c,
            W,
            "#8a9a5a",
            "#6f7f48"
        )
        chaoDetalhe(nil, c, W, "natureza")
        return cv
    end
    local function serraMarcal(self, c, s, t, camL)
        if not __t(F34.mid) then
            F34.vale = buildVale(nil)
            F34.enc = buildEncostaSerra(nil)
            F34.mid = buildMirante(nil)
        end
        local nt = night(nil, s)
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(nil, c, F34.vale, camL * 0.02)
        if __gt(nt, 0.1) then
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = nt
            do
                local i = 0
                while i < 40 do
                    R(
                        nil,
                        c,
                        __mod(
                            __mod(
                                hash(nil, i + 9) * 600 - camL * 0.02,
                                LW
                            ) + LW,
                            LW
                        ),
                        110 + hash(nil, i * 3) * 50,
                        1,
                        1,
                        "#ffd98a"
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        do
            local L = 0
            while L < 2 do
                c:save()
                c.globalAlpha = 0.75 - L * 0.2
                do
                    local i = 0
                    while i < 14 do
                        local x = __mod(
                            __mod(i * 97 + t * (3 + L * 2) - camL * (0.05 + L * 0.05), 620) + 620,
                            620
                        ) - 70
                        local y = 134 + L * 14 + hash(nil, i + L * 20) * 12
                        do
                            local k = 0
                            while k < 5 do
                                ell(
                                    nil,
                                    c,
                                    x + k * 12,
                                    y - math.abs(k - 2) * 3,
                                    16,
                                    7,
                                    lerpC(nil, "#f6f6f2", "#5a6a8a", nt)
                                )
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
                c:restore()
                L = L + 1
            end
        end
        tile(nil, c, F34.enc.cv, camL * F34.enc.f)
        for ____, pts in __iterar((F34.enc.road)) do
            do
                local i = 0
                while i < 3 do
                    do
                        local u = __mod(t * 0.015 + i * 0.33, 1)
                        local n = __len(pts) - 1
                        local k = math.min(
                            n - 1,
                            math.floor(u * n)
                        )
                        local f = u * n - k
                        local x = __get(
                            __get(pts, k),
                            0
                        ) + (__get(
                            __get(pts, k + 1),
                            0
                        ) - __get(
                            __get(pts, k),
                            0
                        )) * f
                        local y = __get(
                            __get(pts, k),
                            1
                        ) + (__get(
                            __get(pts, k + 1),
                            1
                        ) - __get(
                            __get(pts, k),
                            1
                        )) * f
                        local sx = scr(nil, F34.enc, x, camL)
                        if not __t(vis(nil, sx, 10)) then
                            do i = i + 1 continue end
                        end
                        local truck = i == 1
                        R(
                            nil,
                            c,
                            sx,
                            y - 3,
                            __t(truck) and 7 or 4,
                            __t(truck) and 3 or 2,
                            __t(truck) and "#e8e8e2" or pick(
                                nil,
                                __arrL({"#c43c3a", "#3c6aa8", "#e8c24c"}, 3),
                                i
                            )
                        )
                        if __gt(nt, 0.2) then
                            R(
                                nil,
                                c,
                                sx + (__gt(
                                    __get(
                                        __get(pts, k + 1),
                                        0
                                    ),
                                    __get(
                                        __get(pts, k),
                                        0
                                    )
                                ) and 5 or -1),
                                y - 2,
                                2,
                                1,
                                "#fff2b0"
                            )
                        end
                    end
                    i = i + 1
                end
            end
        end
        for ____, ____value in __iterar((F34.enc.TUR)) do
            local tx = ____value[1]
            local ty = ____value[2]
            do
                local sx = scr(nil, F34.enc, tx, camL)
                if not __t(vis(nil, sx, 20)) then
                    continue
                end
                do
                    local k = 0
                    while k < 3 do
                        local a = t * 1.6 + k * TAU / 3 + tx
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({sx + 1, ty}, 2),
                                    __arrL(
                                        {
                                            sx + 1 + math.cos(a) * 14,
                                            ty + math.sin(a) * 14
                                        },
                                        2
                                    )
                                },
                                2
                            ),
                            1,
                            "#f2f4f6"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    sx,
                    ty - 1,
                    3,
                    3,
                    "#d8dce0"
                )
                if __t(__gt(nt, 0.1) and math.sin(t * 2.5 + tx) > 0.3) then
                    R(
                        nil,
                        c,
                        sx,
                        ty - 2,
                        2,
                        1,
                        "#ff4a3a"
                    )
                end
            end
        end
        drawMid(nil, c, F34.mid, camL)
        do
            local cyc = 24
            local ph = __mod(t, cyc) / cyc
            local r = MAR.RAMPA
            local x
            local y
            local voando = false
            if ph < 0.12 then
                x = r + ph / 0.12 * 110
                y = 186 - (x - r) * 0.12
            else
                voando = true
                local u = (ph - 0.12) / 0.88
                x = r + 110 + u * 340
                y = 172 - math.sin(u * 3) * 14 + u * 60
            end
            local sx = x - camL
            if __t(vis(nil, sx, 60)) then
                if __t(voando) then
                    do
                        local k = -7
                        while k <= 7 do
                            R(
                                nil,
                                c,
                                sx + k * 2,
                                y - 26 - math.floor(math.sqrt(1 - (k / 8) ^ 2) * 4 + 0.5),
                                2,
                                3,
                                __t(__mod(k, 2)) and "#3c8ad8" or "#f2c94c"
                            )
                            k = k + 1
                        end
                    end
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({sx - 13, y - 24}, 2),
                                __arrL({sx, y - 6}, 2)
                            },
                            2
                        ),
                        1,
                        "rgba(60,60,60,.7)"
                    )
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({sx + 13, y - 24}, 2),
                                __arrL({sx, y - 6}, 2)
                            },
                            2
                        ),
                        1,
                        "rgba(60,60,60,.7)"
                    )
                    R(
                        nil,
                        c,
                        sx - 2,
                        y - 7,
                        5,
                        6,
                        "#c43c3a"
                    )
                    R(
                        nil,
                        c,
                        sx - 1,
                        y - 10,
                        3,
                        3,
                        "#f2efe6"
                    )
                else
                    local f = __mod(
                        math.floor(t * 10),
                        2
                    )
                    R(
                        nil,
                        c,
                        sx - 2,
                        y - 12,
                        5,
                        7,
                        "#c43c3a"
                    )
                    R(
                        nil,
                        c,
                        sx - 1,
                        y - 15,
                        4,
                        3,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx - 2,
                        y - 5,
                        1,
                        4 + f,
                        "#2a2f3a"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        y - 5,
                        1,
                        5 - f,
                        "#2a2f3a"
                    )
                    do
                        local k = 0
                        while k < 10 do
                            R(
                                nil,
                                c,
                                sx - 14 - k * 2,
                                y - 4 - k * 0.5,
                                2,
                                2,
                                __t(__mod(k, 2)) and "#3c8ad8" or "#f2c94c"
                            )
                            k = k + 1
                        end
                    end
                end
            end
        end
        do
            local x = MAR.RAMPA + 102 - camL
            local sw = math.sin(t * 4) * 1.5
            if __t(vis(nil, x, 30)) then
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            x + 2 + k * 4,
                            120 + k * 0.3 + sw * k * 0.3,
                            4,
                            5 - k * 0.5,
                            __t(__mod(k, 2)) and "#f2f2ee" or "#f08a24"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = MAR.CAMINHAO + 180 - camL
            if __t(vis(nil, x, 30)) then
                gente(
                    nil,
                    c,
                    x,
                    208,
                    6,
                    false
                )
                R(
                    nil,
                    c,
                    x - 6,
                    196,
                    8,
                    4,
                    "#e8e2d0"
                )
                do
                    local i = 0
                    while i < 3 do
                        local q = __mod(t * 0.5 + i / 3, 1)
                        R(
                            nil,
                            c,
                            x - 3 + math.sin(t + i) * 2,
                            192 - q * 12,
                            2,
                            2,
                            ("rgba(240,240,236," .. tostring(1 - q)) .. ")"
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local x = MAR.BARRACA + 50 - camL
            if __t(vis(nil, x, 60)) then
                ell(
                    nil,
                    c,
                    x,
                    172,
                    4,
                    4,
                    "#c88a60"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    176,
                    8,
                    8,
                    "#7a3a8a"
                )
                R(
                    nil,
                    c,
                    x - 5,
                    168,
                    10,
                    2,
                    "#d8b878"
                )
                if __mod(t, 9) < 2.5 then
                    balao(
                        nil,
                        c,
                        x,
                        164,
                        "MEL DE ABELHA DA SERRA!"
                    )
                end
            end
        end
        do
            local i = 0
            while i < 6 do
                local k = __mod(t * 0.4 + i / 6, 1)
                local x = __mod(i * 89 + t * 60, 560) - 40
                local y = 60 + i * 22 + math.sin(t + i) * 6
                R(
                    nil,
                    c,
                    x,
                    y,
                    10 + k * 6,
                    1,
                    "rgba(255,255,255,.35)"
                )
                i = i + 1
            end
        end
        fog(
            nil,
            c,
            s,
            t * 2,
            camL,
            0.45
        )
    end
    local function serraMarcalLights(self, g, s, t, camL)
        local a = night(nil, s)
        if __lt(a, 0.05) then
            return
        end
        local tw = MAR.TORRE - camL
        local ____t_15 = __t
        local ____t_result_14
        local ____t_13 = __t
        local ____vis_result_12 = vis(nil, tw, 100)
        __O[468] = ____vis_result_12
        if ____t_13(____vis_result_12) then
            ____t_result_14 = math.sin(t * 3) > 0
        else
            ____t_result_14 = __O[468]
        end
        if ____t_15(____t_result_14) then
            lightAdd(
                nil,
                tw + 1,
                30,
                a,
                30
            )
            lightAdd(
                nil,
                tw + 71,
                30,
                a,
                30
            )
        end
        local cz = MAR.CRUZ - camL
        if __t(vis(nil, cz, 30)) then
            lightAdd(
                nil,
                cz + 3,
                196,
                0.5 * a,
                26
            )
        end
    end
    local PLAT = __ord(
        {
            deque = function(____, c, x, y, w, t, sd)
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
                    16,
                    "#4a2e18"
                )
                do
                    local k = 0
                    while __lt(k, w) do
                        Q(
                            nil,
                            c,
                            x + k,
                            y,
                            8,
                            12,
                            __t(__mod(k, 20)) and "#a87a4a" or "#9a6a3e"
                        )
                        Q(
                            nil,
                            c,
                            x + k,
                            y,
                            8,
                            2,
                            "#c8985a"
                        )
                        k = k + 10
                    end
                end
                for ____, px in __iterar((__arrL(
                    {
                        x + 8,
                        __add(x, w) - 14
                    },
                    2
                ))) do
                    Q(
                        nil,
                        c,
                        px,
                        y + 12,
                        6,
                        30,
                        "#6a4a2a"
                    )
                    do
                        local k = 0
                        while k < 4 do
                            Q(
                                nil,
                                c,
                                px - 1 + math.sin(t * 2 + k) * 1,
                                y + 30 + k * 4,
                                8,
                                2,
                                "rgba(160,210,220,.4)"
                            )
                            k = k + 1
                        end
                    end
                end
            end,
            brinquedo = function(____, c, x, y, w, t, sd)
                sombra(
                    nil,
                    c,
                    x,
                    y,
                    w
                )
                local col = pick(
                    nil,
                    __arrL({"#e8433a", "#3c8ad8", "#e8c24c", "#3c8a5a"}, 4),
                    sd
                )
                Q(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    w + 4,
                    18,
                    "#2a2a2a"
                )
                Q(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    14,
                    col
                )
                Q(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    2,
                    shadeHex(nil, col, 1.35)
                )
                do
                    local k = 6
                    while k < w - 6 do
                        Q(
                            nil,
                            c,
                            x + k,
                            y + 4,
                            6,
                            6,
                            shadeHex(nil, col, 0.8)
                        )
                        k = k + 12
                    end
                end
                for ____, px in __iterar((__arrL(
                    {
                        x + 6,
                        __add(x, w) - 12
                    },
                    2
                ))) do
                    Q(
                        nil,
                        c,
                        px,
                        y + 14,
                        6,
                        26,
                        pick(
                            nil,
                            __arrL({"#e8c24c", "#3c8ad8"}, 2),
                            __add(sd, px)
                        )
                    )
                end
                do
                    local k = 0
                    while __lt(k, w) do
                        Q(
                            nil,
                            c,
                            x + k,
                            y - 8,
                            2,
                            8,
                            "#f2efe6"
                        )
                        k = k + 8
                    end
                end
                Q(
                    nil,
                    c,
                    x,
                    y - 10,
                    w,
                    2,
                    "#f2efe6"
                )
            end
        },
        "deque,brinquedo"
    )
    local REG = CC.registrar
    REG(
        nil,
        __ord(
            {
                id = 32,
                key = "lagoa",
                nome = "Lagoa das Bateias",
                lugar = "Pista de caminhada, píer, pedalinhos e garças",
                grupo = "novo",
                width = LAG.W * 2,
                draw = lagoa,
                lights = lagoaLights,
                vao = N.vaoAgua,
                plat = PLAT.deque,
                labels = __arrL(
                    {
                        __arrL({
                            LAG.PIER + 30,
                            166,
                            "PÍER",
                            5,
                            "#5a3a20"
                        }, 5),
                        __arrL({
                            LAG.QUIOSQUE + 48,
                            128,
                            "QUIOSQUE DA LAGOA",
                            6,
                            "#5a3a20"
                        }, 5),
                        __arrL({
                            1300,
                            88,
                            "LAGOA DAS BATEIAS",
                            10,
                            "#f2f2e6"
                        }, 5)
                    },
                    3
                ),
                interact = __arrL(
                    {
                        __arrL({"pot", 300}, 2),
                        __arrL({"pot", 3800}, 2),
                        __arrL({"trash", 1500}, 2),
                        __arrL({"trash", 4300}, 2),
                        __arrL({"ball", 2500}, 2),
                        __arrL({"bucket", 1900}, 2),
                        __arrL({"crate", 2800}, 2),
                        __arrL({"crate", 2828, 1}, 3),
                        __arrL({"puddle", 4600, 80}, 3),
                        __arrL({"grass", 600, 200}, 3),
                        __arrL({"lever", 4000, "sprinkler"}, 3)
                    },
                    11
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,vao,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({800, 384, 150}, 3),
                        __arrL({990, 328, 140}, 3),
                        __arrL({2200, 384, 150}, 3),
                        __arrL({3270, 384, 220}, 3),
                        __arrL({3900, 384, 150}, 3),
                        __arrL({4090, 328, 140}, 3),
                        __arrL({4280, 272, 140}, 3)
                    },
                    7
                ),
                gaps = __arrL(
                    {__arrL({3300, 160}, 2)},
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
                id = 33,
                key = "parque",
                nome = "Parque da Cidade",
                lugar = "Parquinho, pista de skate, dominó, piquenique e o parcão",
                grupo = "novo",
                width = PQ.W * 2,
                draw = parque,
                lights = parqueLights,
                plat = PLAT.brinquedo,
                labels = __arrL(
                    {
                        __arrL({
                            PQ.PLAY + 190,
                            110,
                            "PARQUINHO",
                            6,
                            "#ffffff"
                        }, 5),
                        __arrL({
                            PQ.SKATE + 180,
                            140,
                            "PISTA DE SKATE",
                            6,
                            "#2a2a2a"
                        }, 5),
                        __arrL({
                            PQ.IDOSOS + 60,
                            160,
                            "ACADEMIA DA TERCEIRA IDADE",
                            4,
                            "#2a2a2a"
                        }, 5),
                        __arrL({
                            PQ.IDOSOS + 200,
                            178,
                            "DOMINÓ",
                            4,
                            "#2a2a2a"
                        }, 5)
                    },
                    4
                ),
                interact = __arrL(
                    {
                        __arrL({"ball", 900}, 2),
                        __arrL({"ball", 4100}, 2),
                        __arrL({"ball", 4300}, 2),
                        __arrL({"fountain", 2400}, 2),
                        __arrL({"trash", 1700}, 2),
                        __arrL({"trash", 3500}, 2),
                        __arrL({"pot", 2900}, 2),
                        __arrL({"crate", 3300}, 2),
                        __arrL({"grass", 3700, 180}, 3),
                        __arrL({"puddle", 2100, 70}, 3),
                        __arrL({"lever", 2700, "party"}, 3)
                    },
                    11
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({400, 384, 150}, 3),
                        __arrL({590, 328, 140}, 3),
                        __arrL({1500, 384, 150}, 3),
                        __arrL({1690, 328, 140}, 3),
                        __arrL({1880, 272, 140}, 3),
                        __arrL({3100, 384, 150}, 3),
                        __arrL({4500, 384, 150}, 3)
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
                id = 34,
                key = "serra-marcal",
                nome = "Serra do Marçal",
                lugar = "Mirante, rampa de voo livre e a estrada descendo a serra",
                grupo = "novo",
                width = MAR.W * 2,
                draw = serraMarcal,
                lights = serraMarcalLights,
                plat = function(____, c, x, y, w, t) return CC:plataforma(
                    c,
                    15,
                    __arrL({x, y, w}, 3),
                    t
                ) end,
                labels = __arrL(
                    {
                        __arrL({
                            MAR.BARRACA + 50,
                            141,
                            "MEL · REQUEIJÃO · CAFÉ",
                            5,
                            "#5a3a20"
                        }, 5),
                        __arrL({
                            MAR.RAMPA + 60,
                            170,
                            "RAMPA DE VOO LIVRE",
                            5,
                            "#f2efe6"
                        }, 5),
                        __arrL({
                            400,
                            186,
                            "MIRANTE DA SERRA DO MARÇAL · 1.000 m",
                            5,
                            "#f2efe6"
                        }, 5)
                    },
                    3
                ),
                interact = __arrL(
                    {
                        __arrL({"grass", 300, 260}, 3),
                        __arrL({"grass", 2600, 240}, 3),
                        __arrL({"grass", 4400, 260}, 3),
                        __arrL({"hay", 1800}, 2),
                        __arrL({"crate", 1500}, 2),
                        __arrL({"crate", 1528, 1}, 3),
                        __arrL({"bucket", 3500}, 2),
                        __arrL({"tire", 2400}, 2),
                        __arrL({"fence", 3800, 90}, 3),
                        __arrL({"barrel", 2700}, 2)
                    },
                    10
                )
            },
            "id,key,nome,lugar,grupo,width,draw,lights,plat,labels,interact"
        ),
        __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({600, 384, 150}, 3),
                        __arrL({790, 320, 140}, 3),
                        __arrL({980, 256, 140}, 3),
                        __arrL({2700, 384, 150}, 3),
                        __arrL({2890, 320, 140}, 3),
                        __arrL({3700, 384, 150}, 3),
                        __arrL({3890, 320, 140}, 3),
                        __arrL({4080, 256, 130}, 3)
                    },
                    8
                ),
                gaps = __arrL(
                    {__arrL({3400, 200}, 2)},
                    1
                )
            },
            "platforms,gaps"
        )
    )
    local CAMS = window.CampanhaCamadas
    CAMS:configurar(
        32,
        __ord(
            {
                povo = 18,
                fgLista = __arrL({"capim", "flores", "arbusto", "capim"}, 4)
            },
            "povo,fgLista"
        )
    )
    CAMS:configurar(
        33,
        __ord(
            {
                povo = 24,
                fgLista = __arrL({
                    "flores",
                    "arbusto",
                    "bike",
                    "flores",
                    "sacos"
                }, 5)
            },
            "povo,fgLista"
        )
    )
    CAMS:configurar(
        34,
        __ord(
            {
                povo = 5,
                trilha = true,
                fgLista = __arrL({"capim", "pedra", "capim", "pedra"}, 4)
            },
            "povo,trilha,fgLista"
        )
    )
    local PL = window.CampanhaPlantas
    local ____t_19 = __t
    local ____opt_result_18
    if PL ~= nil then
        ____opt_result_18 = PL.adicionar
    end
    if ____t_19(____opt_result_18) then
        PL:adicionar(
            32,
            __arrL(
                {
                    __arrL({"capim", 200, 160}, 3),
                    __arrL({"flores", 1300, 120}, 3),
                    __arrL({"capim", 2600, 140}, 3),
                    __arrL({"flores", 4200, 120}, 3)
                },
                4
            )
        )
        PL:adicionar(
            33,
            __arrL(
                {
                    __arrL({"flores", 1000, 140}, 3),
                    __arrL({"floreira", 2200, 100}, 3),
                    __arrL({"flores", 3000, 160}, 3),
                    __arrL({"capim", 4200, 120}, 3)
                },
                4
            )
        )
        PL:adicionar(
            34,
            __arrL(
                {
                    __arrL({"capim", 400, 200}, 3),
                    __arrL({"cacto", 1300, 90}, 3),
                    __arrL({"capim", 2200, 220}, 3),
                    __arrL({"cacto", 3200, 90}, 3),
                    __arrL({"capim", 4300, 200}, 3)
                },
                5
            )
        )
    end
    N.b = true
end)(nil)
return ____exports
